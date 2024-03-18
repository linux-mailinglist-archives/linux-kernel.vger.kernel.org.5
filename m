Return-Path: <linux-kernel+bounces-106326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D62187EC6E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3A8B21745
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FCF524DB;
	Mon, 18 Mar 2024 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/RbE34u"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63974524BD;
	Mon, 18 Mar 2024 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776778; cv=none; b=CbLm6VIvv4uNfLIflLScc5XoBJBl5knCammUHouMLQQFjrtPdWDPFsTutylh2zbW9dKasC0vNEuOFHYtYV9f1py1LLhZacrzP4U06qFJu9KOe0pRuDSlOBR2jV49Rxv8gfh827I3FjbXobp7rMu1NO6NWKAr1f2rglZym/e0Mpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776778; c=relaxed/simple;
	bh=pN6gBHQH+U7zmnj05igyF+tWRAWUqSXcl7RJeV4tZUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KavqKZz75sejX3Ovu1/GAoIXSCuRxMOWpEphisfdr4KZ94Nvo8XaXGLelMjyQKeS8MPn80XdBRlsDNcw3YZGIvsYw4OMTWmEDB1/Fpiqv98yy1wY/gkW3nOWBJ4IPoMYvOM+xXujjv36QyW/UZhpCQJmmPJRHsExz6L8c4la7gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/RbE34u; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e7224cb3f2so838757b3a.1;
        Mon, 18 Mar 2024 08:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710776776; x=1711381576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//cjIHsLGxZvDadUYfdQ9t2weBDzGP5AK8GunubsHTs=;
        b=O/RbE34uovB005TYKXuwHpxMEOWoAQ7F5Bbme8pjEbscvEPJfcGsg6flE6rQUsaQv1
         2h29EfeSB2o30Au4MwSnIk42cL6y63/eCj2LeH/xyP39Em8bsPMrDYyQDdJg2s2TBxSA
         f2ZQpaGyFcp+v7i5YYI5aXnSkpTuV2zLoF8IHNpJkN4Odmn1dIdyko89t+KiNSdkXE0t
         YxXXO0fukrgx5LezoCMkKKEae/VFFT/kkQUxn61zFmktzqbeSR2qel/usfXKkOtieQkD
         aR5txXgqKc20sH2zWRNlP5Oid+Ti5kRRXdz/P6ECWZp5inCIvNLLV/LT3VVHui0P6kC0
         AfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710776776; x=1711381576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//cjIHsLGxZvDadUYfdQ9t2weBDzGP5AK8GunubsHTs=;
        b=WERRwRGcp/L1I0FDBSL17ELc75Fk7ahgnhIdpbKo8ZOG9iC6fw92BvXTPQPxUH2nPx
         PbZheFA5v6AhYf+u58d3fvFFl+t4zXcPx2uCOpLBo6u8ZRYdAVBiWN02XWfhQ+7ZGJJO
         XmiUN8U2Zyh8vg74bL6tgQM6t4Cdn9HQMjzKMWSmOOCpiX2IeFoedzSmGMVpa7IAL5GO
         uS0+olox49jN2GfzE8s6KE4MZ47GbeBAXgY+tDXLfd2qEQPW8IXy3axntjzkIKJSxHsV
         tBVOc1Ng5lwqnSgyaoSgEGLibFdXvpgqBXcRhnlDkskL1VjeBQFdYGashtpJmgVdQcW7
         QZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA9Wb005BVf0n7Jm1t1a0F+BJucaAMf8ZKW/Y3za2DRYS6E6qHDLwl9H5SErFm3BRCQ2vl5JXo5i7Z1T71EoDOHpi1vAdTeTNfUiw=
X-Gm-Message-State: AOJu0YyEMB4yWhOZOTISY2k0w2mahbvbGjoGuqA7kJ11p92YSQkB25cO
	LuQPcA8f3NVr1GR1L8XOqIn5OnS3lZYgrSEY7wOBhAdvjHyHgA7WDUJVkB5IIzk=
X-Google-Smtp-Source: AGHT+IH/S0D3hlf/DZm4yR8jlYMf0YKTmf3rxwefTnyvdsjrPuq3YbxvTRjevTKhL1GuZNQMQHGDFw==
X-Received: by 2002:a05:6a21:3a83:b0:1a3:63cd:5262 with SMTP id zv3-20020a056a213a8300b001a363cd5262mr5436677pzb.26.1710776776230;
        Mon, 18 Mar 2024 08:46:16 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:31f8:807c:8911:659b:1495])
        by smtp.gmail.com with ESMTPSA id u8-20020a6540c8000000b005e840ad9aaesm2400080pgp.30.2024.03.18.08.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 08:46:15 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v2 1/2] spi: lm70llp: fix links in doc and comments
Date: Mon, 18 Mar 2024 21:08:34 +0530
Message-ID: <20240318154540.90613-2-five231003@gmail.com>
X-Mailer: git-send-email 2.44.0.273.g4bc5b65358.dirty
In-Reply-To: <20240318154540.90613-1-five231003@gmail.com>
References: <20240318130840.74589-1-five231003@gmail.com>
 <20240318154540.90613-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update links in the documentation and in-code comments which point to
the datasheet and schematic.

The current links don't work because National Semiconductor (which is
the manufacturer of this board and lm70) has been a part of Texas
Instruments since 2011 and hence http://www.national.com/ doesn't work
anymore.

Fixes: 78961a574037 ("spi_lm70llp parport adapter driver")
Fixes: 2b7300513b98 ("hwmon: (lm70) Code streamlining and cleanup")
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 Documentation/spi/spi-lm70llp.rst | 4 ++--
 drivers/spi/spi-lm70llp.c         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/spi/spi-lm70llp.rst b/Documentation/spi/spi-lm70llp.rst
index 2f20e5b405e6..ff98ddc76a74 100644
--- a/Documentation/spi/spi-lm70llp.rst
+++ b/Documentation/spi/spi-lm70llp.rst
@@ -6,7 +6,7 @@ Supported board/chip:
 
   * National Semiconductor LM70 LLP evaluation board
 
-    Datasheet: http://www.national.com/pf/LM/LM70.html
+    Datasheet: https://www.ti.com/lit/gpn/lm70
 
 Author:
         Kaiwan N Billimoria <kaiwan@designergraphix.com>
@@ -28,7 +28,7 @@ Hardware Interfacing
 The schematic for this particular board (the LM70EVAL-LLP) is
 available (on page 4) here:
 
-  http://www.national.com/appinfo/tempsensors/files/LM70LLPEVALmanual.pdf
+  https://download.datasheets.com/pdfs/documentation/nat/kit&board/lm70llpevalmanual.pdf
 
 The hardware interfacing on the LM70 LLP eval board is as follows:
 
diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index f982bdebd028..3c0c24ed1f3d 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -29,10 +29,10 @@
  *
  * Datasheet and Schematic:
  * The LM70 is a temperature sensor chip from National Semiconductor; its
- * datasheet is available at http://www.national.com/pf/LM/LM70.html
+ * datasheet is available at https://www.ti.com/lit/gpn/lm70
  * The schematic for this particular board (the LM70EVAL-LLP) is
  * available (on page 4) here:
- *  http://www.national.com/appinfo/tempsensors/files/LM70LLPEVALmanual.pdf
+ *  https://download.datasheets.com/pdfs/documentation/nat/kit&board/lm70llpevalmanual.pdf
  *
  * Also see Documentation/spi/spi-lm70llp.rst.  The SPI<->parport code here is
  * (heavily) based on spi-butterfly by David Brownell.
-- 
2.44.0.273.g4bc5b65358.dirty


