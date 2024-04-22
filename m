Return-Path: <linux-kernel+bounces-153092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865F78AC8ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A111C20D63
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA08612D3;
	Mon, 22 Apr 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOp3yYHE"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528C2C8F3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778372; cv=none; b=XRkeMwOMPjEjMgZXGsRK4ompwSOBCk2F1We/kmic3JfCDFTZ9yA6j7/Vo/ZSoYg3v7JjV9QeV0ZEhzNazSE8jmwFqiRo9bMjMSSIBQyyj5R9WcaQanMnx/3M0IokmG4R7HXTy0NghQoYciOCUSUvd5cvBJp4cwCaW3eqQ1VHUDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778372; c=relaxed/simple;
	bh=ORQ71f0AaQQ5akKJiukuBgi17kny7qie7GaIGLxzN/I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SEwiWHJTC/1waMdGskfMqKIxYyp89RzCGX0xKGUnyF9YPh3kW0NW6bMVJWOquEeHI5zn64S0J2W86FtnyHJqDNYl6ddmb5SUOveowdZ74TjwzBPCZ5/mhfzveAX0MU3xkRbqkEcbWMk678wPx0U6HPXq1+Cmwfkh9qc8H6phBMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jOp3yYHE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-572040691c9so1553296a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713778368; x=1714383168; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1CqQcJrzdvW3IqhkKP04Hdt5bWJd9zRL4G/OeUl8Pw=;
        b=jOp3yYHEkvhzxwN8/UjDO1vdZ5aXhFMHbjacqI+X033n5DCn6+XuLkC1J2TLci2ZON
         ghDYUv5T6mDEJteFGq5l2FGdKSqMzJHrA1o2bqAApx8CPyvayW6LE405FHnQD0rXc6MX
         87wynayoeQAww1bBJ4bF1eDOHoZtHVzCOPQ+ZRBM2EeaOCI22Ej+JCf5Sw//pbExNV39
         lCIqoiJgDpkC30LrRVTI/h9VJOW/HLaovzhfD28wqSvXdrmDBLc1g3kdVQceBkDvAMfx
         zlNi5u3uoieOM9/jUxXPu8rx+4KYSeE+aWAHQJD7RX7+3Dst/Wdwoceddbt4/sttfynB
         Em4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713778368; x=1714383168;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1CqQcJrzdvW3IqhkKP04Hdt5bWJd9zRL4G/OeUl8Pw=;
        b=IWe0Tgkn+EHGUqzbnVlZv0m+0ac8bg0ylogDaBB5bP+DO/EFDKnLMWdWItalKOKFxp
         AI/W66qZl+MNitempk3aQbtXYPEm+6eolLw8AwmNNg7rsIeHd2x9UCDBtdb18RbHUdId
         3xrQnk0V2aU3cWJPRH1UWzJxjRAB/1QTsFUnA+cc9lJgbjrwHTY4HkICi36xqraZRJEi
         /4odaMcTZ+awbcCmTR/tZRjn4r2BSKbjyI3l8nH7FPoJsE932fbsln77JCAqSuTNcqHr
         BK7bYCCXz+rZHdf8ZzWQq04ZKd0Sw7O5Ufp0B+7tEpUpq+EI4lusurYCQMXLXDfjZy1p
         JPnw==
X-Forwarded-Encrypted: i=1; AJvYcCXGckfZ7nyLQqfF8N2BowqOhJE8Cw5qrg4W0NyLuaIDJx0t0/4PPRIYqPoZUAR5LILevfkFyOWJ7lLOMTmzI4xvHZg4tGpVPQy+56qG
X-Gm-Message-State: AOJu0YyqJf3HsYhnyuJgzU5oBvkDKbnNwxO6An9JADU+KEZNr/d1dq8q
	W49yE1PORBjfh7/bIMxFuWhpQ6havBnl8/lF2bmp8+558jY/h7gH4h/emS9RbUY=
X-Google-Smtp-Source: AGHT+IEq+Z88wgbIStN5EzvwdJOfTAX0fiWXJvBkGdYYTwJtQFUMA77dFbyTJtExISCiw851Jp7Kmg==
X-Received: by 2002:a50:99d3:0:b0:56b:dd7c:ac3d with SMTP id n19-20020a5099d3000000b0056bdd7cac3dmr8686797edb.10.1713778368390;
        Mon, 22 Apr 2024 02:32:48 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id g1-20020aa7c841000000b0056e718795f8sm5340030edt.36.2024.04.22.02.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 02:32:48 -0700 (PDT)
Date: Mon, 22 Apr 2024 12:32:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ezequiel =?iso-8859-1?Q?Garc=EDa?= <elezegarcia@gmail.com>,
	Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2] media: stk1160: fix bounds checking in
 stk1160_copy_video()
Message-ID: <e43980df-1ca5-459d-b037-788dd7d9085d@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The subtract in this condition is reversed.  The ->length is the length
of the buffer.  The ->bytesused is how many bytes we have copied thus
far.  When the condition is reversed that means the result of the
subtraction is always negative but since it's unsigned then the result
is a very high positive value.  That means the overflow check is never
true.

Additionally, the ->bytesused doesn't actually work for this purpose
because we're not writing to "buf->mem + buf->bytesused".  Instead, the
math to calculate the destination where we are writing is a bit
involved.  You calculate the number of full lines already written,
multiply by two, skip a line if necessary so that we start on an odd
numbered line, and add the offset into the line.

To fix this buffer overflow, just take the actual destination where we
are writing, if the offset is already out of bounds print an error and
return.  Otherwise, write up to buf->length bytes.

Fixes: 9cb2173e6ea8 ("[media] media: Add stk1160 new driver (easycap replacement)")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: My first patch just reversed the if statement but that wasn't the
correct fix.

Ghanshyam Agrawal sent a patch last year to ratelimit the output from
this function because it was spamming dmesg.  This patch should
hopefully fix the issue.  Let me know if there are still problems.

 drivers/media/usb/stk1160/stk1160-video.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
index 366f0e4a5dc0..e79c45db60ab 100644
--- a/drivers/media/usb/stk1160/stk1160-video.c
+++ b/drivers/media/usb/stk1160/stk1160-video.c
@@ -99,7 +99,7 @@ void stk1160_buffer_done(struct stk1160 *dev)
 static inline
 void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 {
-	int linesdone, lineoff, lencopy;
+	int linesdone, lineoff, lencopy, offset;
 	int bytesperline = dev->width * 2;
 	struct stk1160_buffer *buf = dev->isoc_ctl.buf;
 	u8 *dst = buf->mem;
@@ -139,8 +139,13 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 	 * Check if we have enough space left in the buffer.
 	 * In that case, we force loop exit after copy.
 	 */
-	if (lencopy > buf->bytesused - buf->length) {
-		lencopy = buf->bytesused - buf->length;
+	offset = dst - (u8 *)buf->mem;
+	if (offset > buf->length) {
+		dev_warn_ratelimited(dev->dev, "out of bounds offset\n");
+		return;
+	}
+	if (lencopy > buf->length - offset) {
+		lencopy = buf->length - offset;
 		remain = lencopy;
 	}
 
@@ -182,8 +187,13 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 		 * Check if we have enough space left in the buffer.
 		 * In that case, we force loop exit after copy.
 		 */
-		if (lencopy > buf->bytesused - buf->length) {
-			lencopy = buf->bytesused - buf->length;
+		offset = dst - (u8 *)buf->mem;
+		if (offset > buf->length) {
+			dev_warn_ratelimited(dev->dev, "offset out of bounds\n");
+			return;
+		}
+		if (lencopy > buf->length - offset) {
+			lencopy = buf->length - offset;
 			remain = lencopy;
 		}
 
-- 
2.43.0

