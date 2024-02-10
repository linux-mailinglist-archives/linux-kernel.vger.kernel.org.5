Return-Path: <linux-kernel+bounces-60559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2348506B3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01091C23E13
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF1660B96;
	Sat, 10 Feb 2024 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z73ZevZk"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA76088F;
	Sat, 10 Feb 2024 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602018; cv=none; b=Vgyl4mJbsXde9782gZqudL1MTLumr4sc9TGESICQiaME83s7rltmpReYcxMEHMT0qXvuo4ddc0vsDYKLcMT0VIJ7KOA+NtT0bAJV1hYlQ9YJ7e6ubMKBssp5llbuCynF10YQ/0i9uIkp2ej0D04smi+Z1iOulWwRsxu6pZnhfII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602018; c=relaxed/simple;
	bh=ySgqpJ/s17i6lGxYCSwWoimJrGRy6L5UY5mJ/EH+6yo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qEjM2ikzQ9O6H4f6SW2+Wxes7jevv5hkMgJ2tfNCDFOv4Czy6cBIzAz8mfPbP82SRC6s1084wDxhRNOHJZL/IZSMpKL8H2Ij9cC5K9a2es9m+sHdxXs7bBGm/UoCDCxxavbHGEWTZZfPR5ElAG/krHWj2TETs1RNlBQG3V9nNYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z73ZevZk; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5116588189aso3761049e87.1;
        Sat, 10 Feb 2024 13:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707602014; x=1708206814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+hI7qeo1D9gyYnUlkKG3fcFOY/MIqlDtpV0SLWt3F8=;
        b=Z73ZevZkPnaY9etMA6tBndgTH5lFUNdnLEmltubNZw5GvYxhP+b0A4aYR04EiaRyn5
         j1XcQAedmBCJfuxNRVM6kP6FsQO4ahlDeLpbiRHT6L0V+3pHgjL507UdKy2TqMaMQkiz
         jxthU+Thjew+X6xvfAEMpkNEON2xqlttskuVAgLeULxmBezbVWl/U6vAUHGs1cETls92
         ucwXTl5Ocd3R0ouYkoAKAl7MVom5aenxGSE8rcaqMSJgbN+yAYuR/eQYK1d6w7tzqRMI
         owyN61+KdKJS0ICrjGzSwW7Z0/79+lhBSNtLrMYIm5Wu0YubxfNIIW1LFgb/+/JlZ2/E
         ancA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707602014; x=1708206814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+hI7qeo1D9gyYnUlkKG3fcFOY/MIqlDtpV0SLWt3F8=;
        b=AEdsS5u8YmygEbmdtZLHjs6HvJXCeeOqlic2m+i8WJZVsBB6XPNdQ7i+RqVcgGQ80f
         UqXrXdLZjQpuzp7i5Yu/vnhrXDNGmvVHtzL/CJWIWC7qpbpS33w7aob9e/4l7vzK5ArY
         LBBwil1q7ZThRdxj9sjLLaY3J47IFG6p+Obv2h6HJMItWH+eZDZvrwPbvb5mvqRjJPPN
         rjVBG/lGlE99pDnh/nneNFOmtVoe9e3IKk14am6J+wU0fSrrEgGefPyzkUCj887Pp9Zi
         FPTwXMvL1tAc+kz1xaoAhAxlGTD5bwa58986NNneYWYIAgFyrXPDMfEdWLKikU2+dcUN
         1ILw==
X-Forwarded-Encrypted: i=1; AJvYcCVx69Ej2nwoqiLD9fKZgGCNcE5Fe68552IwmZDKFzRirR8nKxS5p/Q4O5WIMwX7r1470hX2DW+OhRvCaz7BSkhysEdoJfMPrtW/S3f6iWbAHNBYGYqq5sZUVFhzsza6G4JLEVGxBCZQoPw=
X-Gm-Message-State: AOJu0YyKa/fjECBsDfRMz5dUKMRrtkAxnklPMMmuL76bIwIliq/AJIdA
	Ars7hy/+GuSsSGNQVPKpzsMiyA3hHssYU8P+qB/pqOX/UiEjlLPh
X-Google-Smtp-Source: AGHT+IGZbdzHR6z/GDfg0eZ7PqBmHRRuhM3o4dRT7ySPAR0iJLVLzaUrmz2Zp0soZrzhWGnP83Kytg==
X-Received: by 2002:a05:6512:3ba6:b0:511:33d4:c99a with SMTP id g38-20020a0565123ba600b0051133d4c99amr2208570lfv.61.1707602014417;
        Sat, 10 Feb 2024 13:53:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW43ztFfTUOkWc5NU3thkM0MOfULXb7jJ83SMO+SSeDMGpv3V3IZkY9SLxzB7a7HN7TM4c7+um2faE31oG7mSyztQ0Sby6B8qOVS+tcrW6HYYSMl9df0899uE43X+XfZ0hSl0qigdz6KDmHXMsxzUFw27nKZZrGf6YJNbbj+7E7g+m1zJ0XwIQDK2C3R01PlaGf9J3NcnoKEChiTc6VqAvxIum0wf/aQCbXMjt3Dq4qzpAIT1g1IHCIufJgJotH/iUOaJkimVBoZELDQiNso9wmhSWR3SNuWBYE4zmaCZKMmzMTyOgjs8+chZv6/sSNwjywYz0ek00r7h3cPtSyzMt5EodjPPURw80sgOggo07RssgAkeScUw==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:53:34 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: chrysh@christina-quast.de,
	daniel.beer@igorinstitute.com,
	jikos@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	equinox@diac24.net,
	michael.zaidman@gmail.com
Subject: [PATCH v1 12/19] hid-ft260: uart: use kfifo_avail for fifo write room check
Date: Sat, 10 Feb 2024 23:51:40 +0200
Message-Id: <20240210215147.77629-13-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210215147.77629-1-michael.zaidman@gmail.com>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace uart fifo write room calculation with the kfifo_avail kernel API.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index f8d4bf7e6c4f..3d1a9ec88cb9 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1264,7 +1264,7 @@ static unsigned int ft260_uart_write_room(struct tty_struct *tty)
 {
 	struct ft260_device *port = tty->driver_data;
 
-	return FIFO_SIZE - kfifo_len(&port->xmit_fifo);
+	return kfifo_avail(&port->xmit_fifo);
 }
 
 static unsigned int ft260_uart_chars_in_buffer(struct tty_struct *tty)
-- 
2.40.1


