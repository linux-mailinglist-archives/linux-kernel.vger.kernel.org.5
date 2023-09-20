Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A639F7A72EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjITGkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjITGkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:40:11 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46139CE;
        Tue, 19 Sep 2023 23:40:06 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-573675e6b43so4165165eaf.0;
        Tue, 19 Sep 2023 23:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695192005; x=1695796805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwXg+ilQ0RHmfCXNasOazmFwYr/JJwhhEAkK60Nck04=;
        b=QQJVjwEljXgYm8IOhOLijSZE/O/w6muLfZ0KUJoGgH+S0naLh3TZrWae14Ns8HxcBN
         gDWFXAEdPoJ5J6OCQl7ZxTE0VyvJJKzBI0UMcB+NA7Vtjo5SQvVQ+EAQPepLpg57lGdM
         igfmi3yaBkcIK7+GfrxTnB9jKX9U6VHS+mu1oIytYi3dVFEc4S+7YSbUJP5qIq+NojVT
         OAz6cP7n+4hMLhbKEoBSnlEGvqjV1UYGjRm0BaRUG8jTLPDw9XUM2hZMhXlEbKhnWKu2
         HnfPZYaAl6FMGj7oNkWMunbTdh2uBiMAI2ryIAVy59u3USYyBir3Lqp/2v3bkUWkpU+T
         dsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695192005; x=1695796805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwXg+ilQ0RHmfCXNasOazmFwYr/JJwhhEAkK60Nck04=;
        b=czq9sKWMAYlOPThGfpUBAsdeV8MmqfChVxrtzEmfAXi3WChisGPFA0BsVeOHDs/98G
         6DcEAiCwbnd31lK38zi53ERvGLC/cX91xWPETiSziDKVRj9x5t7fQYUUdZJyHSFJDTaQ
         +7TzFoirFbGjXhJaVFeFuZf5oCeuyyJw8tqQgX1d9NH7KEoRe30NEe1ETHxrC0t9YGIK
         kJujxWR29iaI3HDcwKq8US5peTRT2H193G18wdwp4I/RWPyOv8oBW/v6RUsH0f5t4Ig4
         4rqQwKhFf+97I0Xa3VzgRz5+TxY25wGt86whkzykRqOBf27XCLfAGsJexIn5LbOT6E33
         Bl7Q==
X-Gm-Message-State: AOJu0YzZbh4k9Wu5d4VMc5E4IyB6sxK7WuZQWOuRGt8ZnRr8PxQE18zM
        YoxPSSZPLiTNqFMI0z2OBD8=
X-Google-Smtp-Source: AGHT+IHW9cf7GsKofv0VrXQeWwee9ruAO4LJSIL63WsuVZFAbAAr2jucMD2LgmNLvK50rjiBsZPYAg==
X-Received: by 2002:a4a:e096:0:b0:57b:3a07:181c with SMTP id w22-20020a4ae096000000b0057b3a07181cmr261020oos.9.1695192005156;
        Tue, 19 Sep 2023 23:40:05 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id z196-20020a4a49cd000000b005768a6a19f9sm6450618ooa.2.2023.09.19.23.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 23:40:04 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
X-Google-Original-From: Chen Wang <wangchen20@iscas.ac.cn>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com
Cc:     Chen Wang <wangchen20@iscas.ac.cn>
Subject: [PATCH v2 07/11] dt-bindings: serial: snps-dw-apb-uart: Add Sophgo SG2042 uarts
Date:   Wed, 20 Sep 2023 14:39:58 +0800
Message-Id: <05fcf91d60468323a6c7cdb8ac57c356ab4a3050.1695189879.git.wangchen20@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695189879.git.wangchen20@iscas.ac.cn>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Add compatible for the uarts on the Sophgo SG2042 RISC-V SoC.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 17c553123f96..011d89e6df0f 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -45,6 +45,7 @@ properties:
           - const: snps,dw-apb-uart
       - items:
           - enum:
+              - sophgo,sg2042-uart
               - starfive,jh7100-hsuart
               - starfive,jh7100-uart
           - const: snps,dw-apb-uart
-- 
2.25.1

