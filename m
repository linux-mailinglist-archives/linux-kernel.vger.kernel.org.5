Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6C97B83E8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243011AbjJDPm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242943AbjJDPmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:42:52 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BEEC4;
        Wed,  4 Oct 2023 08:42:49 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3ae214a077cso1625682b6e.0;
        Wed, 04 Oct 2023 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696434168; x=1697038968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfM5XCGs2tSFYtxKjnEgC+KhHndiRz+hbU9xrIiDamk=;
        b=Cbhp+7K+tnrjQrVKxo7JSPvNHUaoq3Kvzt18lbdkr0LOH0RKK2E67qvyyLIxMjHqAb
         1MkS3mlIoTAI0xh3Du/y2esDzHRFwazuo6BYdHiu0Wjg/HVpyE+O/sooi5EVS+3KJqh5
         vs54QFSQP5zhhG9tjLJLbkLy4TIQ9pnaUd83gUjIBbwbqX5DiXI9qkA2oWymJfw8SAsp
         X+XgQ305QI3XeBHx1wXNqR4GsZexW/iZRjVVNTd07hcBoHgv9KIPh+udtgcu0XYT0e8e
         hpmScuBy+vsXXev+oANffEJA2Dkt7YnqXXBLKtQNIokShhJrnqq1rb1c7P2HcoCHFAR/
         bGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696434168; x=1697038968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfM5XCGs2tSFYtxKjnEgC+KhHndiRz+hbU9xrIiDamk=;
        b=HjV6MINauWPDH7yR8nj9AAzY3nuvzwsArslWFAN6ffdSkQIB3xcmUK+9XKfF4pSFz4
         T4LpBvxehu9/nTzvXsIUYKI+DqcvwW0bhbwgLJGkkgnFm4yBM8AR0vFyMM2kCqT2tVUR
         7tQTvmg+GB9mCL3HOYAeC9x+XCgwLATOvG9l3Fphxy5rv+fMJ04X5JTh7NVVE6XUW5T7
         2b/lsDvY6W3BkZhNVlzvq8SOV6QFbZRecunz8FFo2Vdd3aCt6mPvoBojLUHR+IU0Xux7
         uEqdCQ6BJOfpaHobFGPgZoE53JWabfr2HbqIdR/JdwHT6VZeoSLR1qqHTb/CGKuJPDKu
         FRWA==
X-Gm-Message-State: AOJu0Yz2lSwgRxHw/df/VxY1xGM9tcnzNDltxCbR45AhDvwRQgh9lx+j
        w/J1VVyXxdGeCplAMmxHLlQ=
X-Google-Smtp-Source: AGHT+IHtVip/Sx3qhTmZhBJxHyVWkRBSXIODOPj/xBcCYq61Wz1gSwS6iTyG8GCGDEx8qhjHgg/n5A==
X-Received: by 2002:a05:6808:200c:b0:3a3:47c5:1de3 with SMTP id q12-20020a056808200c00b003a347c51de3mr3124437oiw.49.1696434168310;
        Wed, 04 Oct 2023 08:42:48 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 25-20020a544199000000b003ae59076b90sm540093oiy.14.2023.10.04.08.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:42:47 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 05/10] dt-bindings: interrupt-controller: Add Sophgo SG2042 PLIC
Date:   Wed,  4 Oct 2023 23:42:41 +0800
Message-Id: <ec837f89f5a23bd7b8ee34096fde8052351b0d5a.1696433229.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696433229.git.unicorn_wang@outlook.com>
References: <cover.1696433229.git.unicorn_wang@outlook.com>
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

From: Chen Wang <unicorn_wang@outlook.com>

Add compatible string for SOPHGO SG2042 plic.

Acked-by: Chao Wei <chao.wei@sophgo.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
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

