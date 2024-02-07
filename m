Return-Path: <linux-kernel+bounces-56400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E0084C9B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9BC1F235DC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BCF1B7FF;
	Wed,  7 Feb 2024 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qm1HqhDw"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9A619BBA;
	Wed,  7 Feb 2024 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707305855; cv=none; b=KXjAXvIzBf1j+l5EZyDm3fLtApSP6FIs+zLycXyWuVf0O1fN3nBsDeKtuyW6yGkVCfBIpe+ndKKlDfSLKdPcF1neV1FnlFXcYUWUfN9Z+YRBNjgqAt8NYzMvmlM97o8ju+qQZCgqVJxllMNKnFheYkJTPlPOzLNBrz1cNUvTjo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707305855; c=relaxed/simple;
	bh=83PVRJcxzAA2WbczYT0DNaElV8eyxg5A/J+MvaxcW0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gUQRu8WzDqLUoP12cNIJXHnHvQh85LSjXN6ai3BiM7vasGfcwacd7qCoBrPy19EPHwtEEItvcb1ky0RMnvV8/ZbboDoPSmCczMvUFY1waO9XhiKimMAnWI2dRx87xXaDJYuksw5hfcksUmYBpHzT9oRDuYCK1ngqfl0AGhilmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qm1HqhDw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fe79f1aaaso4342495e9.0;
        Wed, 07 Feb 2024 03:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707305852; x=1707910652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dlcGl3niyrqEgqteXegO7t1b/+0Yl2m8/0ksFX1JNYk=;
        b=Qm1HqhDwCr5wOIQQ69zC1Zo3ORDg280cjli0YjypQKw2NoT95LTPuDj1DxYP0K7EsP
         tsvnF/cxDopBdaWcrYoLEIMIKgoogeSAB6HrXheCMFLPL+I9g8s0+vX5khS+8bvn7CD0
         iR9m80UDF8yNK4ewlaTRQwzpyEAGinKFPv/0jL6p5qkmzxO8sjdlyWrdZgkebjD+5jlq
         DZVCEjeN8YDvNmS1jFQFt7oxzp3ChObc1wLCUjg9Gpbvh44TNXoDC6X+fwNqBKVkkhPc
         daDHT/q8saSiFmfwmUgWFK14B72xrRGHF6CA944oeDYcGbImFYYqyhzNIbS/w6wv+qeF
         lYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707305852; x=1707910652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlcGl3niyrqEgqteXegO7t1b/+0Yl2m8/0ksFX1JNYk=;
        b=ctQqzXeixRFgIeXkBeDuA7H2719+jX5zPGCVFcIqS0TB3lbcgvT3u/weaWlPpWshGo
         Eobua6pgNaLNbKMfpwyasmNUHVM6jdvHvHuRR7KctySKgwTHDJentB/bEKMH+3neUF/l
         SE+aAYvSVgsY2lwxBwoIh5iZ//CchjkuBK+iSRDcfW3QHt9aTRshD0vNwwPQ4wBFWe0Y
         mY/T8iu58uAjaRtTaIYIybmBiCvo4+ePqFqEZjFofb+78oaVVXNLgKu+fE5q2uRuNLFA
         OwAKFZmLEYyHQ9lfU8v0FCnQcUTyic8hirzbTLmpUMhWd0MyAYLkjJqg2pLbAYcnLNWa
         RdYg==
X-Gm-Message-State: AOJu0YwSz6W1BODeuJDQ9A71bVNaWIKXKmS46zVivYYkdBCDG+zrhWG0
	VDIjhoqHtHaXfq+LCCmVGgM29emgut7H+HQkbVUNLEPIg6NKfOga
X-Google-Smtp-Source: AGHT+IHhCUX2jjAkPgubFzMyy76hD0Xxlq2ESogbUyYzpNFEBgb67F+Ta6WRyJY0bGIudfZoiE7p+A==
X-Received: by 2002:a05:600c:4fce:b0:40e:fc20:b574 with SMTP id o14-20020a05600c4fce00b0040efc20b574mr4281438wmq.10.1707305851884;
        Wed, 07 Feb 2024 03:37:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXfFqoZvMNzjNtuEk2FBBeq/zo+aauQxSicOM2td9a+tz8NUXIwEzc8t4NV/BC+ZYMZoGmlcHTt54JzNMAPsTA5WD7Yb5q6FPdrW+63d+see3Dp91Yfn2agcmN48l6WmXvz5zidUzed4YyDsWXhY6ZpQPdNSgyXj8a0tWRbeFj
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bd24-20020a05600c1f1800b0041004826669sm2081907wmb.42.2024.02.07.03.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:37:31 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: image: mdc800: Remove redundant assignment to variable retval
Date: Wed,  7 Feb 2024 11:37:30 +0000
Message-Id: <20240207113730.2444296-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable retval is being assigned a value that is not being read
and is being re-assigned a new value a couple of statements later.
The assignment is redundant and can be removed.

Cleans up clang scan warning:
drivers/usb/image/mdc800.c:634:2: warning: Value stored to 'retval'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/image/mdc800.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/image/mdc800.c b/drivers/usb/image/mdc800.c
index 67f098579fb4..7b7e1554ea20 100644
--- a/drivers/usb/image/mdc800.c
+++ b/drivers/usb/image/mdc800.c
@@ -631,7 +631,6 @@ static int mdc800_device_open (struct inode* inode, struct file *file)
 	mdc800->camera_busy=0;
 	mdc800->camera_request_ready=0;
 
-	retval=0;
 	mdc800->irq_urb->dev = mdc800->dev;
 	retval = usb_submit_urb (mdc800->irq_urb, GFP_KERNEL);
 	if (retval) {
-- 
2.39.2


