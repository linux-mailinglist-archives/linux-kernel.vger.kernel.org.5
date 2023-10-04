Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF427B83E3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjJDPmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjJDPme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:42:34 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF7FD8;
        Wed,  4 Oct 2023 08:42:32 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6c7b3adbeb6so575995a34.0;
        Wed, 04 Oct 2023 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696434151; x=1697038951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tD24LkujqQMbRRxB8/xrA8at3l30kwtwxAWKzy7MPw4=;
        b=GI1LDTh76zDJrs9FKZBMbG2KlVf7P5z9drsA8zs9gGKNdkguq3bHI92of4B0V0XQ3k
         d64Na1XAsnx7PA4GVeoAFTyncOwcIi3kkO5q+H8O21pqgnzc3BqhHHXDkuyd54LvBb1g
         uxOXMgEs5BsP3IjGPeNThCtB+ceQDPKu1HiyMzz3zbtSwMeiMhMgRgvHKIxiCYbeKYrx
         wvC54PEH5BU3hGw4EtTHTpfK68DptnP1pBMDgqN2PuUFxxuu2b85gh8TSxP02Y3wqlE8
         U4OriXq4kISS6N00FuXuto0tbizINU9XTnnKmveKsGLzOICxnUgSeuwRp5SiwWgSslHt
         q28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696434151; x=1697038951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tD24LkujqQMbRRxB8/xrA8at3l30kwtwxAWKzy7MPw4=;
        b=kcI2nLmerIdMh2o60yvFlZwbVn60foLpanVJsQgCAWI7j1isoBUx6fcliqciVGRDvD
         U3A1P6FgXuV5i9HYGXr5k6ni2+fbqwm4PogKx0+0YfLanRF/fj9Wtlpd+57oHCsalzRN
         Oz116ePHqLbY3dcM62R9+mMU/DFzMtrPW1LOnr3uQ7uvxrl6R1S/rS7FlMQlMerCSZhe
         dKf4jPMEO7ChhIH42dCzntR0sVMoguK+eMtpu5yiDJgnzyuWfJ7U/3FkLLCUfiwz/wer
         gabqeTfGHvIs80Q03kjLdSAGaDzSx6wL2movVssSJqaNybj9yMOPe3fSvtdhUfcit+tw
         UAoA==
X-Gm-Message-State: AOJu0YyDAixmE2z9EqgNBo5QHI5ZfpHo+MupxGP8VVpGdBDot/kwi8dS
        MEIFL+rLWGKWdWW88tapP7Q=
X-Google-Smtp-Source: AGHT+IHiVCdVEpqi7jlc0CA8t+7KoZMRtaA+COKsbNFkbWk5l/6KEeiWVzvpQZZ9dEIXCy3vm2pBew==
X-Received: by 2002:a05:6870:f708:b0:1d5:bda7:130e with SMTP id ej8-20020a056870f70800b001d5bda7130emr2754434oab.18.1696434151284;
        Wed, 04 Oct 2023 08:42:31 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id n9-20020a0568301e8900b006b954f7f422sm486778otr.6.2023.10.04.08.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:42:31 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 04/10] dt-bindings: riscv: Add T-HEAD C920 compatibles
Date:   Wed,  4 Oct 2023 23:42:23 +0800
Message-Id: <bd63ede60c5757af3d15a13d1259fc91589325ec.1696433229.git.unicorn_wang@outlook.com>
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

The C920 is RISC-V CPU cores from T-HEAD Semiconductor.
Notably, the C920 core is used in the SOPHGO's SG2042 SoC.

Acked-by: Chao Wei <chao.wei@sophgo.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 38c0b5213736..185a0191bad6 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -47,6 +47,7 @@ properties:
               - sifive,u74-mc
               - thead,c906
               - thead,c910
+              - thead,c920
           - const: riscv
       - items:
           - enum:
-- 
2.25.1

