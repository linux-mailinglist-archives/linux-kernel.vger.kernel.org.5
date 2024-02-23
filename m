Return-Path: <linux-kernel+bounces-78556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B41BD8614FA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6352859D1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41245D73F;
	Fri, 23 Feb 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHqGNexv"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2235224E8;
	Fri, 23 Feb 2024 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700298; cv=none; b=MopD/0QtkZzhZaVKin+gdgSpj8ItXgtt0H84EQ3hOKTDzDpj4KuTndjT1k5NfxKouHv177hcmemEhv88ijPKGnL0sd9vrcxCWulwzqc4pONIDFCcRduPtI9YpVTBoLewGaovOumWtYwu0QX9qD/FBuG59SK6gKzec9S3iAZYa0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700298; c=relaxed/simple;
	bh=e/c+ZP0Jj4k3w0h5haFdrTRJ1bfgB9ofQ999qSO4ojE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s7T3mqH7SgJSZ/HCvN5TYUtHv3U0uAJ0TP0AEB5a7YMeYfZ4fWRxS+uhoqoYLzr/ugCRdoU/XIz93je1sSLunj3PQKXOtRr1XE/HmonL9/RclXYX29W1QXvv03uXgUmrSRf6TFPGiUJyXc9/KtHaz1ouXTZ+SiVpgvpguF3CfxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHqGNexv; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-787ac650561so46934085a.3;
        Fri, 23 Feb 2024 06:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708700295; x=1709305095; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4NDgszGodt3V3j5Lshn/mpqkCU7z4gbtXsqxc5uCqIs=;
        b=mHqGNexvWpeU/ZgOiIQTs2aPWEXsfemo6w+GBxcNwBBW6M+JC6yWd2JO+My244pBU2
         grJfTMMkXD4E97441OyjOO6fsgd4evYiIULqvs8kGcjEzcMhBUSFbOnuSdaBjNmPRzpi
         a2TM7KCT7ILcll82iYZpUbaMFnicdDuXPySneK12evUh9Ez0596ChQwz6tkKZV7rDHry
         XkoCZC+pNPp/2Z13mXVVDuvx+dozy/rXUKAfNSCWA2oqKHHflht9jj1AUPmnCKQcISdZ
         YzecxUPDA/67JZaD5rWghKHMhB5budsv9n3rijfVXnm/hVz5Djv8/pFcMMjQHskHprtV
         q5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708700295; x=1709305095;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NDgszGodt3V3j5Lshn/mpqkCU7z4gbtXsqxc5uCqIs=;
        b=VTJqspGYSQwUYSXojzNcASV88q/jndHv0RHyuRSoyjguvzjXzNS6ZpJ9OnzfJXQch4
         /73JDaS+e7FwNb6qUfdLIVGf1rMNQrZmXjogRW9BmGj8GBST4xGJxmQ+9Vw9YH2J5vFg
         CgPdWxvsX+OfKjks0piXLPwD3yHD3h3nPj2uyucFvG4MovpMR3GzkoQPyrUWYPnF+42i
         25lSlkZvmRMa2T6vXF4JvrLLecjfBKqfYD3c4CChnegmXOhNZbY08WS/mA2gOItHfd90
         SOw7wMq/2ecIS36tnrUKV7zZ54Nauq8gZp+mD8XvL1igVJc2EJ+t32GLuI4if2oECN2o
         A4LA==
X-Forwarded-Encrypted: i=1; AJvYcCVLWI/H3JY8ZvnETbyQNSCgSFUYIJerWOgH1xIWebuYnF4rgSixOybT/4nqxV0bbtqz8IF7wp2C2fqTS+G2NoyG1yqFpAdayDTr9KTwnQ3cFznf0890kHoVeVPaJrB3ZLUJc2k3Ef0y6Q0=
X-Gm-Message-State: AOJu0YyRSNrnhR8vJIueVXw6WF1BiJCaH2ouoxtEloVUoNWYahmIqoXZ
	8w8CPVFUOjfohHe20gSDn2BAeGSYdwhkVEnZLdb9HunQQbY/KPYq
X-Google-Smtp-Source: AGHT+IEpyx0dsbf4zcMWVmdW7wGWEWgrp0gOO7dTGs80H6Cm9yC9Adhi9vVXdU35s6LBJonWqi7ozQ==
X-Received: by 2002:a05:620a:4692:b0:787:746e:5ba8 with SMTP id bq18-20020a05620a469200b00787746e5ba8mr48329qkb.13.1708700295326;
        Fri, 23 Feb 2024 06:58:15 -0800 (PST)
Received: from Wayne (host-24-138-28-86.public.eastlink.ca. [24.138.28.86])
        by smtp.gmail.com with ESMTPSA id wa23-20020a05620a4d1700b0078742e741cfsm6552865qkn.61.2024.02.23.06.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 06:58:14 -0800 (PST)
Date: Fri, 23 Feb 2024 10:58:12 -0400
From: Samuel Kayode <samkay014@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: rename function deGetTransparency()
Message-ID: <ZdiyhAwNTPmbS3E0@Wayne>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rename function deGetTransparency to de_get_transparency to fix
checkpatch warning Avoid CamelCase.

Signed-off-by: Samuel Kayode <samkay014@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 44b9e3fe3a41..ad9d8bd34e5a 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -284,7 +284,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	return 0;
 }
 
-static unsigned int deGetTransparency(struct lynx_accel *accel)
+static unsigned int de_get_transparency(struct lynx_accel *accel)
 {
 	unsigned int de_ctrl;
 
@@ -391,7 +391,7 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
 		DE_CONTROL_ROP_SELECT | DE_CONTROL_COMMAND_HOST_WRITE |
 		DE_CONTROL_HOST | DE_CONTROL_STATUS;
 
-	write_dpr(accel, DE_CONTROL, de_ctrl | deGetTransparency(accel));
+	write_dpr(accel, DE_CONTROL, de_ctrl | de_get_transparency(accel));
 
 	/* Write MONO data (line by line) to 2D Engine data port */
 	for (i = 0; i < height; i++) {
-- 
2.34.1


