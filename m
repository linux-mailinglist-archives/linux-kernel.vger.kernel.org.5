Return-Path: <linux-kernel+bounces-24758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980C382C1EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB7A1C238D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5676DD19;
	Fri, 12 Jan 2024 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QSxNKtH0"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223C964CFF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e66315d93so6316215e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 06:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705070057; x=1705674857; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wMAozsps9KhdnPC0gC/CqjxcAys0VIF1YUv+72UuGdM=;
        b=QSxNKtH0L5ny97b8ubTtPuslm7pNmNynFnHnzGI/mk4exHOX4oaK6f/LzjXq4m4Pgg
         S2PttR0ATVEnHHRuqAQ/hszkFViYWkW29xxS4hpqduKzbbE0KmkTN7Bv+XmNrZOz922v
         JFt9J4fTpVVMk7QEygpR3hHUoDTzQF6Hi1SzEXFWh5877WesQ1pZ6W54e92A+k+74k5F
         Jg+MDlwuDGu0zpZKLXxXtpmimmiwuPU4zs2BQxsAZTZbqcpSOk4PanE6D5B81vvrkooY
         vTPWxCu5EgZV07p640BUWol6qiBj4+Rdb2B8oEw4atT+ZZjkmhyKJIOC3rxPd729dIxO
         A0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705070057; x=1705674857;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMAozsps9KhdnPC0gC/CqjxcAys0VIF1YUv+72UuGdM=;
        b=Ynj+EVfQIA/6X7UYc6Bfd+98+Wv9DcOJNwtsPv2iGHmETRTCUo42KaPwDVZLljdtOV
         XSBhyNFREj6ggzP0DwTQCL+4vIfRag3kmyJ+QTwH6W2Y0Xpa66HbFWwBA+W7eoxHklA9
         rMY4DlwesPLYRoGXoLJUyJMVIOb5ARIaOjmIwwGXfsFETQDplHAECiOS525xi8cCS5hz
         DLf4CXjo/0Z03uElyqUQadoHEd/9ymlejstVNj9F6EWQmLnQRItmrNLB/RaVac+OeEr3
         02YwMFO0zbHt8d5+JV2oFdC2qpj5XwQnfhLqHpvYUiInOAhcfaftO1R0A9D+i7xnJlBH
         2pIg==
X-Gm-Message-State: AOJu0Yz7bjghyQCJ0/4tnE+gtWLkdKyQ2npRXc4fbLv8jaOLiPriqNg1
	MjysslP0CdqIgeKXMp+gAE0pdE6nNvHf9xde1q9f4tBd/jE=
X-Google-Smtp-Source: AGHT+IEo2mOleVaYUfc9j4l2dY3+TK3k54YTZMybDNjOmwmfLYfAMTaWAKbDYx/jgnOTy0AsBo3okg==
X-Received: by 2002:a05:600c:1705:b0:40e:4832:9fab with SMTP id c5-20020a05600c170500b0040e48329fabmr886892wmn.143.1705070057428;
        Fri, 12 Jan 2024 06:34:17 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id l17-20020a05600c1d1100b0040e4a2b36bfsm9849022wms.22.2024.01.12.06.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 06:34:17 -0800 (PST)
Date: Fri, 12 Jan 2024 17:34:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] HID: hid-steam: remove pointless error message
Message-ID: <305898fb-6bd4-4749-806c-05ec51bbeb80@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This error message doesn't really add any information.  If modprobe
fails then the user will already know what the error code is.  In the
case of kmalloc() it's a style violation to print an error message for
that because kmalloc has it's own better error messages built in.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/hid/hid-steam.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index b3c4e50e248a..59df6ead7b54 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1109,10 +1109,9 @@ static int steam_probe(struct hid_device *hdev,
 		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 
 	steam = devm_kzalloc(&hdev->dev, sizeof(*steam), GFP_KERNEL);
-	if (!steam) {
-		ret = -ENOMEM;
-		goto steam_alloc_fail;
-	}
+	if (!steam)
+		return -ENOMEM;
+
 	steam->hdev = hdev;
 	hid_set_drvdata(hdev, steam);
 	spin_lock_init(&steam->lock);
@@ -1179,9 +1178,6 @@ static int steam_probe(struct hid_device *hdev,
 	cancel_work_sync(&steam->work_connect);
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->rumble_work);
-steam_alloc_fail:
-	hid_err(hdev, "%s: failed with error %d\n",
-			__func__, ret);
 	return ret;
 }
 
-- 
2.43.0


