Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308067B83DA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243097AbjJDPk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243104AbjJDPkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:40:46 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7518F112;
        Wed,  4 Oct 2023 08:40:41 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57ddde51033so540789eaf.1;
        Wed, 04 Oct 2023 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696434041; x=1697038841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGAJAL4u2VX3FIWEkVnsPhkCa6a31tzGgZXni0+jw5s=;
        b=Ivtq1BQI8RsQQ5fd0UQz646ec25V5AN05GeW7zJTxIIBF5mdbotQmv8xwyP5HCIksr
         mWrCslOcHrVptQdDPB9JW3hnDI3PVrFyCUfpJQ24gjvZ/j7JAD+yyeMfytoHm3Ci2nYn
         qy1Y3VWEWjocMnThwnt1ddkw9ZNIsDoosSCysF7AVlmQ0EAYGy3/7sntMBAEzzV5b5pK
         yMD5NufDG9qYtc47TnV/uB0fmwiPa1KvTM6gY+VHpvZrX0XB3k/OLE0LnhD+7BYX0CCO
         Rp/eLe8/1L3hw55v0NklwVA9BJ0pBTGmV8nqDdUHbTFa3BBFxyoTeFnrDIol0EGk9ZB9
         JQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696434041; x=1697038841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGAJAL4u2VX3FIWEkVnsPhkCa6a31tzGgZXni0+jw5s=;
        b=A6ovLa2DdWKMC3evtjzrrqehKZrczqI1+VHeQBj5sHO1lpmjCM8FwJOaC7lCoBSuTt
         88Yr9CrzORAXdTVnlqE8YZUlpzqa89h0TrQq+3TgWbPsgSqaZyHJrQlSfPCApbCX7AI9
         hqYSaYMK7tMYWsnWOsO9UrJIn3DEwtd734PC52lEQZxSbly1qo1B23b7bc8qny666bg4
         4RYiihFC0hajyi6jRIRnAry9S8nbPYNwHwFkSlj0nmB3cLPaXWBZOxsYZtWeqgGV3xWo
         /GQ9lBm9anEM3eje0SaY6ctB8/x59gPxXJsdwyIDcvU3bFenqLw+v4WoyCPEGkUe5o06
         AxAQ==
X-Gm-Message-State: AOJu0Yy/M2pSyzffvaUoO/uLN6tVv+WkD+LulBUl5TWRRDdqfiXxSQ0i
        qF1NYytUQL02J4j6N+svdE8=
X-Google-Smtp-Source: AGHT+IFTIU1nASd/e+dc6F3k6Dv/9g628/YQ1wR0t0xkHX0r9SBPbwv40GV37Gq9oXgdJhnenlUoOg==
X-Received: by 2002:a4a:255c:0:b0:571:1c44:c9c0 with SMTP id v28-20020a4a255c000000b005711c44c9c0mr8013ooe.1.1696434040692;
        Wed, 04 Oct 2023 08:40:40 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 128-20020a4a1d86000000b0057b43a25deasm677359oog.3.2023.10.04.08.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:40:40 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 02/10] dt-bindings: vendor-prefixes: add milkv/sophgo
Date:   Wed,  4 Oct 2023 23:40:32 +0800
Message-Id: <aab0368a9558571c698fdb78585a47ae3297743f.1696433229.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696433229.git.unicorn_wang@outlook.com>
References: <cover.1696433229.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Wang <unicorn_wang@outlook.com>

Add new vendor strings to dt bindings.
These new vendor strings are used by
- SOPHGO's SG2042 SoC [1]
- Milk-V Pioneer board [2], which uses SG2042 chip.

Link: https://en.sophgo.com/product/introduce/sg2042.html [1]
Link: https://milkv.io/pioneer [2]

Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Chao Wei <chao.wei@sophgo.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..fcca9e070a9a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -863,6 +863,8 @@ patternProperties:
     description: MikroElektronika d.o.o.
   "^mikrotik,.*":
     description: MikroTik
+  "^milkv,.*":
+    description: MilkV Technology Co., Ltd
   "^miniand,.*":
     description: Miniand Tech
   "^minix,.*":
@@ -1273,6 +1275,8 @@ patternProperties:
     description: Solomon Systech Limited
   "^sony,.*":
     description: Sony Corporation
+  "^sophgo,.*":
+    description: Sophgo Technology Inc.
   "^sourceparts,.*":
     description: Source Parts Inc.
   "^spansion,.*":
-- 
2.25.1

