Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD6977EA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346059AbjHPUNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346074AbjHPUMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:12:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C53CD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:12:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d67a458ff66so5887459276.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692216771; x=1692821571;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hydyucHbEMYV5+mvu/0+drZ5pRwXhZ3ATbVyt9DjydA=;
        b=fzxWMts4UEmnzP6fJ2QWvTELoVKoanALduDXpelbb6K2Sx/NKTI8aHONeqm3L7g60x
         Oph7ZPDsE00Ppnv0bsi1VSx6dApV6sx3Hli7NkAu1BfO5lg9grMb5d1JuBPrivixpInl
         AgRYBnKzIPNBDloGRS9Ps8sDg6jfY75rm9KNssmBlIwultXUB4rsg+z7mkMdDxLxZ1ZB
         uG1DIxxYD37lmVVS8JagsBToSaDO6obMBTgl3zKeset1INOlUjwvuUUdc3eh25MQs4Zu
         WkF94PpX0c+LD05aSIW+TnNhVISAXVuGJXt8VP5TLCmxY/cvW6PXTGPFFvBF25EpQXcK
         Zg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692216771; x=1692821571;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hydyucHbEMYV5+mvu/0+drZ5pRwXhZ3ATbVyt9DjydA=;
        b=aAEUapUBMOh+eJb7y+F1lQvvGxuu16y+w/5l3SsHOPFT3Rg/ux97F1zY2TS2huir3/
         QA1iUvMdkuO9Ku8tls7TDTrEsHZwkN7rDkbODA1fWrezqBdDY3jrEwYD5JHvQDlwPvby
         QJx+qiXBfE9jPOdTDAmta4Rv67OSgBqHYLypjYIHH3TnRiH+c/6SOHpGK6VU9C2na/Sd
         MsR8Z3TdSrYvtibNJBc9mtVZB7Kg2W4LxfFx0NbOUEcPIDvzi7U4fPWG0Ev48AhY4Lj4
         1n8wnmMXg5cT4opHIvpfHZ0L0DX3nP+rmZdpbqsXp4uR+HoBXHEFaWadE0iNUF+thTkx
         qjIA==
X-Gm-Message-State: AOJu0YydPMPMgfVzvDGqYbeiq+wSEeqvvKz4ZUHNBsOq1qwLAeYQ3SHe
        EO0ssP6A9MKMrJ0lrizFOiF0uu0zZy8f2304Wg==
X-Google-Smtp-Source: AGHT+IFLGTAxhMYLm8DFHm78BtYVv9lY+/3tEbprNaXyy0am7lutMrDeIFseTWyfQKcL2/BeiHMfp+QrXAY9gzXU1g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:dc02:0:b0:cfe:74cf:e61a with SMTP
 id y2-20020a25dc02000000b00cfe74cfe61amr34513ybe.6.1692216771386; Wed, 16 Aug
 2023 13:12:51 -0700 (PDT)
Date:   Wed, 16 Aug 2023 20:12:50 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMEt3WQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDC0Mz3bL8zBTdlKLMstSiYt2U3ETd/PIcMG1imGRpmmhgaWFkbqoE1F5 QlJqWWQE2Ojq2thYAc/7o4WoAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692216770; l=1512;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=U9ty+DDtLpJvR47VlNEwBh9kqmbTSFNlITqYCfsM3Bs=; b=v8iUzRtOSkauZieTRS3I319sV44jCCOMocqj50dYh39trm3BFtFgLPMdbYxUDlFOv5wj5bdFX
 O3GEz+290sKBU1Va5HaVwngl3C8rSo2dp55GAn8+BuMVf8JLuMPcr7F
X-Mailer: b4 0.12.3
Message-ID: <20230816-void-drivers-dma-owl-dma-v1-1-a0a5e085e937@google.com>
Subject: [PATCH] dmaengine: owl-dma: fix clang -Wvoid-pointer-to-enum-cast warning
From:   Justin Stitt <justinstitt@google.com>
To:     Vinod Koul <vkoul@kernel.org>,
        "=?utf-8?q?Andreas_F=C3=A4rber?=" <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang 18 I see the following warning:
|       drivers/dma/owl-dma.c:1119:14: warning: cast to smaller integer type
|       'enum owl_dma_id' from 'const void *' [-Wvoid-pointer-to-enum-cast]
|        1119 | od->devid = (enum owl_dma_id)of_device_get_match_data(&pdev->dev);

This is due to the fact that `of_device_get_match_data()` returns a
void* while `enum owl_dma_id` has the size of an int.

Cast result of `of_device_get_match_data()` to a uintptr_t to silence
the above warning for clang builds using W=1

Link: https://github.com/ClangBuiltLinux/linux/issues/1910
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/dma/owl-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index b6e0ac8314e5..f340a04579f4 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -1116,7 +1116,7 @@ static int owl_dma_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "dma-channels %d, dma-requests %d\n",
 		 nr_channels, nr_requests);
 
-	od->devid = (enum owl_dma_id)of_device_get_match_data(&pdev->dev);
+	od->devid = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
 	od->nr_pchans = nr_channels;
 	od->nr_vchans = nr_requests;

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230816-void-drivers-dma-owl-dma-41b95a098275

Best regards,
--
Justin Stitt <justinstitt@google.com>

