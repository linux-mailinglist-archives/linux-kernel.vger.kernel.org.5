Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F084775005
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjHIBAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHIBAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:00:31 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C22B19BC;
        Tue,  8 Aug 2023 18:00:30 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1bc479cc815so4968674fac.1;
        Tue, 08 Aug 2023 18:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691542829; x=1692147629;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5M+lYtROvgUoWpbGnjkc7x1tnRI6kO1H9ccD3HBAeI=;
        b=OESYakfXXhBWhZq/CdLUYYDc6Gxpj/srrIFnKTO3wN0LIK5EBPGmaOb1HTrJmokmKB
         /kKLCCBWTnG5B1P02M1idT/hkYWtaQyjbo9tKqVcKftAtqBRc6d1u4QYt0YOS7nbatTU
         dJeQTkn6MuoAkSz7q88PI/+aa0A4dsKpRG/KGCbc1z6YtRMB6BzrNWbdQDHBJiVmhLLy
         1wXqJFuLUoJKqtMpfMRi5k0NPzjOVFUU3nwXvrkFvS//8sVeSKYlQpJOVpx0A7V+Siqc
         DgT7HQrHyGNgb9QZhaBiluGihhrYqAFX84W9arIxuHQD6pTPi12RjwcONmTUBpZWbanJ
         PZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691542829; x=1692147629;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5M+lYtROvgUoWpbGnjkc7x1tnRI6kO1H9ccD3HBAeI=;
        b=Xkoj9/vQtHk/P8CXH2S7CsLzV4FJP2sMHoQIwocDRZVlMw22uDF5xydQzt2OfCKMQG
         +eDeI98mx+q4PlogBJ/EjmXs4dp2PnfSLEwNglVeIHSucq3FDmHNwVyqcO2uqUJKD3GJ
         DiI4VIwEZRGAlz9oZtZYbg4BWFXGN6ABxcUJCrZhhuLQNA49zoQeAuWzGKGsolP3OHiU
         afkkP1kxchaJ6fTlvOUl90qqh+cTkCas6wyVwjuOxQEjeI2zhR5KB5FXk4Q1Au3rdDjG
         GoEnfZX9ME1RGyLH4o6mH58VOs7MckW6vzyqz+vNZ91UPEBC9ZqVoBwhZBN0TXTcNwKg
         dKBg==
X-Gm-Message-State: AOJu0YxFFYR2IDrukXSaxCV3Rnl5Z3bI3vwOyopWXT+EJSW8rOIHmihZ
        YrNTTO+VarJpMoKSmDl+qJs=
X-Google-Smtp-Source: AGHT+IF9gn38jHrTQ0aE784M7bc7GflQ+ZLBScqkHsW00p/Wd7BGhV1cZczcnCiZLDO50SwFw/rrZw==
X-Received: by 2002:a05:6870:ac24:b0:1bf:df47:7b5e with SMTP id kw36-20020a056870ac2400b001bfdf477b5emr1744824oab.16.1691542829670;
        Tue, 08 Aug 2023 18:00:29 -0700 (PDT)
Received: from madhu-kernel (99-145-207-128.lightspeed.austtx.sbcglobal.net. [99.145.207.128])
        by smtp.gmail.com with ESMTPSA id f10-20020a056830204a00b006b8c277be12sm6445879otp.8.2023.08.08.18.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 18:00:29 -0700 (PDT)
Date:   Tue, 8 Aug 2023 20:00:26 -0500
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     hverkuil-cisco@xs4all.nl, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org, ivan.orlov0322@gmail.com,
        madhumithabiw@gmail.com
Subject: [PATCH] media: usb: go7007: Fix warning: passing freed memory 'fw'
Message-ID: <20230809010026.GA4770@madhu-kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix smatch warning - go7007_loader_probe() warn: passing freed memory 'fw'

The 'fw' pointer is released using release_firmware(fw) and then being used
again in another request_firmware() call without being reassigned to a new
memory allocation. To resolve it, use separate variables for each request.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/media/usb/go7007/go7007-loader.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/go7007/go7007-loader.c b/drivers/media/usb/go7007/go7007-loader.c
index 243aa0ad074c..5f5c425f4d45 100644
--- a/drivers/media/usb/go7007/go7007-loader.c
+++ b/drivers/media/usb/go7007/go7007-loader.c
@@ -35,7 +35,7 @@ static int go7007_loader_probe(struct usb_interface *interface,
 				const struct usb_device_id *id)
 {
 	struct usb_device *usbdev;
-	const struct firmware *fw;
+	const struct firmware *fw_1, *fw_2;
 	u16 vendor, product;
 	const char *fw1, *fw2;
 	int ret;
@@ -67,13 +67,13 @@ static int go7007_loader_probe(struct usb_interface *interface,
 
 	dev_info(&interface->dev, "loading firmware %s\n", fw1);
 
-	if (request_firmware(&fw, fw1, &usbdev->dev)) {
+	if (request_firmware(&fw_1, fw1, &usbdev->dev)) {
 		dev_err(&interface->dev,
 			"unable to load firmware from file \"%s\"\n", fw1);
 		goto failed2;
 	}
-	ret = cypress_load_firmware(usbdev, fw, CYPRESS_FX2);
-	release_firmware(fw);
+	ret = cypress_load_firmware(usbdev, fw_1, CYPRESS_FX2);
+	release_firmware(fw_1);
 	if (0 != ret) {
 		dev_err(&interface->dev, "loader download failed\n");
 		goto failed2;
@@ -82,13 +82,13 @@ static int go7007_loader_probe(struct usb_interface *interface,
 	if (fw2 == NULL)
 		return 0;
 
-	if (request_firmware(&fw, fw2, &usbdev->dev)) {
+	if (request_firmware(&fw_2, fw2, &usbdev->dev)) {
 		dev_err(&interface->dev,
 			"unable to load firmware from file \"%s\"\n", fw2);
 		goto failed2;
 	}
-	ret = cypress_load_firmware(usbdev, fw, CYPRESS_FX2);
-	release_firmware(fw);
+	ret = cypress_load_firmware(usbdev, fw_2, CYPRESS_FX2);
+	release_firmware(fw_2);
 	if (0 != ret) {
 		dev_err(&interface->dev, "firmware download failed\n");
 		goto failed2;
-- 
2.25.1

