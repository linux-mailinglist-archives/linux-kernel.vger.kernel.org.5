Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5B87AFF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjI0JDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjI0JDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:03:08 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4C01B0;
        Wed, 27 Sep 2023 02:03:06 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3add37de892so5290006b6e.1;
        Wed, 27 Sep 2023 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695805385; x=1696410185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7RhJG0eb4h1rNL5PLmu2Fo83S0B+583tqhBhK3d4JI=;
        b=f0X0x4Mzed5uOuXDb0Op2EPbEZfcYMEKeJgAqanGCDgEardePzCqpoa+SpCypesQmF
         N+frceqi38Dkk0a91Df2MwJDeT8uRv20MbGJ2KLSi3ZsVfQRldbAVrbVVMWg+BDl8c/z
         yvJnela3fawd93h54ubNda8ZPe0O6S7VvKmMwKnNTetHdi+idqv/nlWtMly3Xn+USNQb
         052sDFCgQC50qNP2CBHf8wXH2nzVLPij+kLObl7GyC0iwQf2wNr+bALn1ZMQRi1I167u
         X8m37np0/U/fW7XSIRRWQgT7nf1lUsPZ4mc6Jq0Tw7nSlarZXpR+CcKGegK44yHMnfy5
         jL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695805385; x=1696410185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7RhJG0eb4h1rNL5PLmu2Fo83S0B+583tqhBhK3d4JI=;
        b=oJFELmGW/OfOtUN+F9UdoCcHaOh1ZpoEjOaXS9Mkx3cDDieyOIWyUB5SXn6yVQwca9
         +OpOhF4U+UzPPKalbiYdcJWfb6x2f5TVFsNZdnZmjvgKsYzXyzix0E2dwmqrEZ/7gY1k
         h+kxBUh9gSA/Hb04rp/DV38iLBEHiYbSCPAJI7DiRNic+GMX7udtp2zdOi2sgjfQYzi7
         Dc6kHOJirgHHZJwq1BeHlexjzK/2erfipdkYUyDGfV+GEDB8XIPLIi88cpAb1UA15Zqq
         aShRnwrhfpVz2VPt01MuiclqUNpWwf04zSN+g8v+oTmhUCib/dU45asdX+5ykdXupMCb
         KS4w==
X-Gm-Message-State: AOJu0YzI6L74t86edAEf2j24wNcgpToo8mxlPL566v5ZHKh6TrsqABIX
        ih1kktbjJF/J8JdRoY/oHxQ=
X-Google-Smtp-Source: AGHT+IHVTwpCDD+CcCbU7lnn521yLbJzkneYegHXpDLGMd37HYDLDoN+QRnWByfeQG0DJMir+qdcVA==
X-Received: by 2002:a05:6808:315:b0:3ab:83fe:e182 with SMTP id i21-20020a056808031500b003ab83fee182mr1543690oie.1.1695805385207;
        Wed, 27 Sep 2023 02:03:05 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id i14-20020a54408e000000b003ae24b38f99sm1809096oii.2.2023.09.27.02.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 02:03:05 -0700 (PDT)
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
Subject: [PATCH v3 11/11] riscv: defconfig: enable SOPHGO SoC
Date:   Wed, 27 Sep 2023 17:02:58 +0800
Message-Id: <f4789b3f9c963f0d8f2653d787abb73d58b91360.1695804418.git.unicornxw@gmail.com>
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

Enable SOPHGO SoC config in defconfig to allow the default
upstream kernel to boot on Milk-V Pioneer board.

Acked-by: Chao Wei <chao.wei@sophgo.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
Signed-off-by: Chen Wang <unicornxw@gmail.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ab86ec3b9eab..bf737cfa1d2c 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -32,6 +32,7 @@ CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_STARFIVE=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_SOC_VIRT=y
+CONFIG_ARCH_SOPHGO=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PM=y
-- 
2.25.1

