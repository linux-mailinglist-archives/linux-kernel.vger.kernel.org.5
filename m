Return-Path: <linux-kernel+bounces-149016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87FB8A8A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939172858F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B5C172BD7;
	Wed, 17 Apr 2024 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ue7Q9sj8"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC6E174EF7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376289; cv=none; b=hoCE2lIoeC0MLqiaSRYphntTHwx10w963E0PhgWbshadcbuSkxwvQZdHThoIdclyQCqTQO2e8/X+7tq0pCXxdABfv38Ats5ohIHjG6YgGhAZ9pQecQIcJqhKMYASHOcqE9gi791Iy4bhv7RALVO3apG+NcJQp5aWX8PeZ3oUhoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376289; c=relaxed/simple;
	bh=kxKejiY5Vxw1asyQacjiWDKZDv4Plb+WMxRCwVm8W60=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z4g12DEeMysfvvpqU3lXUbPfAQSmp6EQBMPYYYH7fscx5JicFTHWGRMtIC78q6U8gFRgKOqsZ9VAFRQ1jPrUHj928cogk9cU2eamglb35O6d9bU3nYjAarot/iqdFFYfIT9jczbiOYmjbptpO/u8vbxSVXbbhFwNCouw8A4GfHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ue7Q9sj8; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso7833542a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713376284; x=1713981084; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MgZqCyNCGaQC8H0yKbmw1VwHJNsqgr3VIM8LYOEI/BM=;
        b=Ue7Q9sj8L8v7tW4/K/zuZ++CQCEUyD+fOD4Er5s3eSnsnpO0ar/9GjTINzB8PUGxSH
         5fMB6FsbYdSoEZZhyGAgdavmQljlyqO4HGoMc21oiDyPMEZKdOc7TwooZD4PQW7JyrO5
         iXj8ir8fMobYHTYshA1BJaXfHMN/zwuCJPsfsolvBzCSuOLNVzohsScMcZgr3+2RaCVm
         392Ar7LCxE51xjxsqal+7dS2TbwmFt5gmawihPMiuqOOozdxmz42Z20o/SxbAt+mOv8H
         EihtB6/PlZsR5ohOZoAODyTEV18fxok0Hm+DghXhslGKCJRdXNeoqOUHsT2Q6qQsz5Qu
         Yo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713376284; x=1713981084;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MgZqCyNCGaQC8H0yKbmw1VwHJNsqgr3VIM8LYOEI/BM=;
        b=tfFCCdil3Kcgkkr9FhwRruBSiEpcJDz+fFesfRvrE5v/Oi5oIpP5EsDIa8i+/58XOm
         qPe8l3udThNpKDJz8RRkirdyOy+YiTG8TuR0+CV5MwJGZMTS9/EQqLD4rT6vSEkeoemV
         LmoLwpsxRaPBJlQ0r+e18YKYTZ3DLcYBeX5fvZ0UM/I52AgLKqe86R5IVSYcwQGav9AJ
         7HLZYcNkShyhHnWszLP2sbW4dcVDAREKbLQAj4njIF28qyaHPZLD6HoXoqEq7AyIR5EN
         u+5BArYA5Pjd/uoAjusyLihL+LDC58EzpHy/nZ8iVyM3aEBuf1ujfHPMiBD47PNkB2lA
         sBNw==
X-Forwarded-Encrypted: i=1; AJvYcCVA0bRNpYSCS3kBOlFdItlxDWwePrNTR3mXCtP38KVMxAYWlRs5AzVtpe8Wbgr+lTOcYbec5W4YwrIAvoz81M8f7+sbM/FKVzj8Vpfe
X-Gm-Message-State: AOJu0Ywa8rZDwE7yo6M/dpxk5vWGzpe53Oj41YJQ+5GSL2AE/tSUbFWY
	QnhbrfVimgRkf6vPnJwgaM/qs9TE9DJz7XBG4E3LGW+4MRYcqGfl4Xb50j8K+ko=
X-Google-Smtp-Source: AGHT+IG3g99Fh5NG2CN+WRwot7slvkEmK0aM122+VwEWPwWqCg9dIm7MTVR0ieqeFKldtS06ro8LDw==
X-Received: by 2002:a50:d75b:0:b0:56d:c937:7558 with SMTP id i27-20020a50d75b000000b0056dc9377558mr241527edj.9.1713376284274;
        Wed, 17 Apr 2024 10:51:24 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 12-20020a0564021f4c00b005701eb9441fsm4734271edz.75.2024.04.17.10.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:51:24 -0700 (PDT)
Date: Wed, 17 Apr 2024 20:51:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ezequiel =?iso-8859-1?Q?Garc=EDa?= <elezegarcia@gmail.com>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH] media: stk1160: fix some bounds checking in
 stk1160_copy_video()
Message-ID: <ab56c444-418a-423d-8528-cf04d5d458ef@moroto.mountain>
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

Fixes: 9cb2173e6ea8 ("[media] media: Add stk1160 new driver (easycap replacement)")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This patch is untested, I just spotted it in review.

When this bug is fixed, the two checks for negative values of "lencopy"
could be removed.  I wrote a version of this patch which removed the
checks, but in the end I decided to leave the checks.  They're harmless.

 drivers/media/usb/stk1160/stk1160-video.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
index 366f0e4a5dc0..bfb97ea352e7 100644
--- a/drivers/media/usb/stk1160/stk1160-video.c
+++ b/drivers/media/usb/stk1160/stk1160-video.c
@@ -139,8 +139,8 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 	 * Check if we have enough space left in the buffer.
 	 * In that case, we force loop exit after copy.
 	 */
-	if (lencopy > buf->bytesused - buf->length) {
-		lencopy = buf->bytesused - buf->length;
+	if (lencopy > buf->length - buf->bytesused) {
+		lencopy = buf->length - buf->bytesused;
 		remain = lencopy;
 	}
 
@@ -182,8 +182,8 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 		 * Check if we have enough space left in the buffer.
 		 * In that case, we force loop exit after copy.
 		 */
-		if (lencopy > buf->bytesused - buf->length) {
-			lencopy = buf->bytesused - buf->length;
+		if (lencopy > buf->length - buf->bytesused) {
+			lencopy = buf->length - buf->bytesused;
 			remain = lencopy;
 		}
 
-- 
2.43.0


