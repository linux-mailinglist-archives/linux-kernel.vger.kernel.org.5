Return-Path: <linux-kernel+bounces-112856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 293BF887F0C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDCAFB2102C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61B11CF87;
	Sun, 24 Mar 2024 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnF8jzaw"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9B41C294
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711314558; cv=none; b=gCfxN1QdvlClJFKIG0qhlQzaahbv/GSwAIfrgXFGMt3FiwGvIADxWlPC7PxP+Nj3VIGD71CFq/FU85U+QbuHqBGmAS3AKpplc+75+rv8VW95GBp6NW1zPjdkFviBomU9syByYxeXXqu7k2go5u1hgQYRLk7O7plxBDMTs7mHsYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711314558; c=relaxed/simple;
	bh=1UPPzA7qGfS9iEju5WF86tQ8AT5tLBO31f1je34qPZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YG9YaIlT96TR/v/KE3Flw0wbrz9dg+VGxtNdO3xR/v3prn91apANIPIyriPEriUbDnGJhGPt3YNTC0hRA+yUKPBXEZnRm8ODliWVfneIN3IBDVfUr/HvS7LNzL+VF58Rvc4z0V1dR+C6P2J0d6dl32nvcI7WQu3UwbssjIFHnuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnF8jzaw; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e445b4f80bso1676489a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711314556; x=1711919356; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=64D+JvyK+W4r1ZaU3GbM1lOh3S/v0YMhaiXiSCQigtk=;
        b=OnF8jzawJ9eqrYAggSaW4K249DfwuJH+ejstmZ1+6JfNqc6UAHz9YMuCSRMwhMT8kM
         tPYUbGuok+7v487ZQbxBgR6Rlr/DFzhPzCvtlMeINEruxuP2FB0J+O60wP5h7AQmmZTA
         YoS7fkBJ7kI07/pvD8pY2nvZrWMfH0x+LD7hcvIRG5tAZfBRq+rhpVISU25/cB30yhR1
         AnEyeRF5o90jfLzzTZY6A/pFPLRbGiTzOtZxeyfWriaXDxXQv8tAMVc0W+lSTT/s+bSy
         OWCaCtTnmMf2J9Lyx7QlIQyY8Lf0bej5RDTeDKq32L6dUpVEL8HPOPA8vGNIKc8ekY7M
         z0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711314556; x=1711919356;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64D+JvyK+W4r1ZaU3GbM1lOh3S/v0YMhaiXiSCQigtk=;
        b=f2HulQKtvdBeq4epMn/9xsMRGQTQnmp/rIqKnalFSiu9nSd3Xt3BfqN/TgP4i7JXRs
         mjbnIGqu4ylfk/Kpws6OSZmXl+jsh9R++H993E2f0noyNTji430su9HfUovQKGpZ3H4F
         2N7eaXzsu1P59UrYXIaLKDcf3Izlz1UL60Zd17uXYC/pJDZU1ErlyFbViI4VexqMXNB8
         kaD2cLEkjbIJs04MhEkhXJmHM/zT3mwAhtTr/eDgAN7S+m50pkKHt0oAgZG11LDX95at
         zXwXb+bECrk/jzdM5y1kjVKdJhm1Jw1AvKGQjk+FMf3HZMb7+fu/hb2xljeQY6Xijj+a
         5c8w==
X-Forwarded-Encrypted: i=1; AJvYcCXI5JTubsDaxXjYErQCu9OX6Vq+cdkW2QnDsIXcLuJitJPMx40PrtdE6MzInk4GRPS2wqw2FyRWvB6SmtrloGSZZULkPkiIQiByQDKp
X-Gm-Message-State: AOJu0Yzdzk+1WtbygJzbhGZo5ScOmFXIVV+br/aJX7H02fyLYX1P7eOT
	BS0r2EZrKPrrmlHbhe6nwz/a5SbjNskA8wxQRVx4Z8Sx10bw8QvFQda4VEHG2zw=
X-Google-Smtp-Source: AGHT+IHGThjrcLejKq999F3WY5CGo0Bi4DUx9T31LjW6OBIze8tvnJbF+C93iH6kJ6mCQzXj7PuYCg==
X-Received: by 2002:a05:6870:b490:b0:222:63e2:aba3 with SMTP id y16-20020a056870b49000b0022263e2aba3mr6599405oap.8.1711314556446;
        Sun, 24 Mar 2024 14:09:16 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id u8-20020a056a00124800b006ea8b233550sm3103462pfi.146.2024.03.24.14.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 14:09:16 -0700 (PDT)
Date: Mon, 25 Mar 2024 02:39:09 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8712: Remove additional space
Message-ID: <ZgCWdfJit4Ly14NB@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove additional whitespaces in SwLedOn() between u8 and LedCfg to
conform to common kernel coding style.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_led.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_led.c b/drivers/staging/rtl8712/rtl8712_led.c
index d5fc9026b036..6d9be5dec4e7 100644
--- a/drivers/staging/rtl8712/rtl8712_led.c
+++ b/drivers/staging/rtl8712/rtl8712_led.c
@@ -107,7 +107,7 @@ static void DeInitLed871x(struct LED_871x *pLed)
  */
 static void SwLedOn(struct _adapter *padapter, struct LED_871x *pLed)
 {
-	u8	LedCfg;
+	u8 LedCfg;
 
 	if (padapter->surprise_removed || padapter->driver_stopped)
 		return;
-- 
2.40.1


