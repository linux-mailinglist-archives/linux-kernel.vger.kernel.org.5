Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAF17B0204
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjI0Kk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjI0JB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:01:29 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70DE1B8;
        Wed, 27 Sep 2023 02:01:27 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c4e38483d2so3663475a34.1;
        Wed, 27 Sep 2023 02:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695805287; x=1696410087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YppGQzKW+2r3xnb53t/LIH/j9u+a8juMyAfNzTVGTww=;
        b=NldFDpBBn60FCAYIJRrEmfoy5lzUR1VFIEjsWbZZRE5jddU6ZnfJmPg8F8V3dBsNLn
         6LGm3eTpQreP5bjnbSmflLfQ2Y+6uI724rbypNuY4funQIjGOwRQIq+j99AuStxa4iDP
         91DPD8XVnLscK+GRUlW5nkBauAT2dY8fGyRf8Cf2EIOIkLtCZ/uTulFmNiFI4grd/NbS
         HkO66aJISrqtR0bRfkdCIursT1KzG5oX9aWvmw80XMwabU4JNXYlKsUpqwAUl66TfUL1
         l31X/lNfckTO+rLS27yTNQHR45r9Y9uDnKtxh/91uSfwRgz4ucpx+yiZGQK7v1fpRRdL
         +Jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695805287; x=1696410087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YppGQzKW+2r3xnb53t/LIH/j9u+a8juMyAfNzTVGTww=;
        b=kru+Mmd5SXt4g4c64I2zWtzMk5kXHQ8IcwCazEeGw+VGTbAcJsvoEHSk8TEqsg5kM+
         S3hq9/AOzG7Lp7GPf8sfd3+yjmb3Q5XrBkIqm7+ao6Hjy/OMmN/f0RNjLB9Jn99YY8nw
         JtXc4lnU16PviIHri8Wjyl/mvDPKFfyS4m7oFdH+Z6Q+x8vuFz6jrJ/3n6vu7AoPe0CE
         SpPkvofAx9rE5gkQzc4tmrd/zqcwjktHF3BwwwG6A0D1bVOAIeQ1nH2Xwvu6o3Hb33Lx
         54e84+fX0ATS7boudxfa3ywAdcCda61KkgkwhfXtRKn01oyNjqHxsonTgvPy+HxiJf7Y
         bstQ==
X-Gm-Message-State: AOJu0Yxa4kVTka4uIw2RmLCFNSNaLvZo3WJFmTxuQVgmHL7NR1bxKXIB
        97oUueun/bRO+vxI19hZZcu0YSYAXQXqMQ==
X-Google-Smtp-Source: AGHT+IES/qcWO76tOeeuoIlprC1dblIRpibZEH/5iy8gCVaskuyWvzti7QClb5q84LqsaWehVwQJ/w==
X-Received: by 2002:a9d:4f12:0:b0:6c4:a30c:f3f1 with SMTP id d18-20020a9d4f12000000b006c4a30cf3f1mr1566244otl.19.1695805286685;
        Wed, 27 Sep 2023 02:01:26 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id w1-20020a9d5381000000b006c4e2f00135sm1086568otg.28.2023.09.27.02.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 02:01:26 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicornxw@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Chen Wang <wangchen20@iscas.ac.cn>
Subject: [PATCH v3 05/11] dt-bindings: interrupt-controller: Add Sophgo SG2042 PLIC
Date:   Wed, 27 Sep 2023 17:01:19 +0800
Message-Id: <8fb6f431928271bf9d5d4bba204729efdd12669a.1695804418.git.unicornxw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695804418.git.unicornxw@gmail.com>
References: <cover.1695804418.git.unicornxw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for SOPHGO SG2042 plic.

Acked-by: Chao Wei <chao.wei@sophgo.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
Signed-off-by: Chen Wang <unicornxw@gmail.com>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index dc1f28e55266..16f9c4760c0f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -65,6 +65,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun20i-d1-plic
+              - sophgo,sg2042-plic
               - thead,th1520-plic
           - const: thead,c900-plic
       - items:
-- 
2.25.1

