Return-Path: <linux-kernel+bounces-28647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0488183014E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD341C24367
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276AA11716;
	Wed, 17 Jan 2024 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1tJfG7b"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AED511707
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705480392; cv=none; b=JkPNYUkvfLrmk8n8wfNiZUTiApU7IMZ7RyIx2wxhVQ/QO9k/KiAPOr1LFnmLMBqX6GZAPToTVx6buPJyGfLcnCv3d8kQsy6j0H4wz6o28yhWDlHtTOvdZ6m/Z6fM275rQn5e/YjMa7lo5ITpA5rcuOpFex45vjRB0CeB5kUf8LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705480392; c=relaxed/simple;
	bh=eoprG9W1CI6YhzvZtTCTti0GN5/NLnpiNoVjdZZRl+s=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kax+aYxSW3a5E9WnXuOEf9m2VtBWBmXjs7x+xPOCrxE3I491ObiSURr1yeaTMjRks/4CAqw0nnRL9ASgpHDc4bjT7dVb525GH8wxpUGuDTmV1aDBwBOfO7Yrx4+pDJu+Msu7IQa/FnS4drpMp34AXV3sN+g+HxwYMC3xF8bNhj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1tJfG7b; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-21085f78398so668418fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 00:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705480390; x=1706085190; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iKjg9sUKFpQLbZiqakql5s58345FDY6ZbRep1Ynzd4U=;
        b=l1tJfG7bdwqRT9Wtapwd/sXqrb6dBw4XKz7DjZNhWIRhIvsScGGxuYwC8F+GDhfl8O
         9pADIinwAHI/DPUFiUYfDkimQfvi797Zg2x0b7TAAJAr9BAyZA84pgCyIp6WWc1wUTFe
         kpzIS7Z2kIxftqWmXdyKkCcHos3ECyoQ3GJ22X1vir5mu/z57fMsttcCrhcV6kzQ8WSd
         IWU3Qb3CkrCvWHXCKJ2E7ZRPgCOYDZHBw8WUAeZjyWSTCGbEGKErdjmrSgi6el2nYTsS
         JBFj43WZqgNuFSh9/CRcuiqp4qXcr6Tr0+7ZQvTUuxE52FwWUwAMgvGWCP0WZVfde+uv
         BzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705480390; x=1706085190;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKjg9sUKFpQLbZiqakql5s58345FDY6ZbRep1Ynzd4U=;
        b=YVH5ccdnzyPnUxXUtS0DayfCJy36uJJkBoWF30riWXXqVl8Sj+NRCbzSkZYkafPape
         LJiSvW7LgQbsJdgBdxHukig/9qc77QWKCI5+OghFz90CIaGPXS1nBbJSJoxYL30tP4ud
         etm+SxjGdwn/Bqud3BIjj+WBIzjJ5SemoMhNghg5Wz2sldO4NLj/7cVrmdE8pKg2YNCt
         8TpIs0IZJdvXmZEW1QUUIMBQYUwZkLd0ui1f/H/+BjeSWKOYu6E+uXLoVGzlyR1P0fiL
         dFpQ/2J0BEaTwdP64Srh8oNM/1ZPILTXqe/yMP+XZnpH5hjent93sXTT9BPnFtjZPPZJ
         vsEw==
X-Gm-Message-State: AOJu0Yzsz16y3tcM2WfIelGE7NmwvDy9MVF0Msf84BtB3TwYUXwocoxh
	hpuvgItk7eWX2mlmnDDNXNumRBojDBI=
X-Google-Smtp-Source: AGHT+IEbHuR38nMGqgjQmlvJ44fhnJ/8d0Ju2lZC8gAshMctaEeLRcpyEp+Imcu3HcafB6XYVh8NYA==
X-Received: by 2002:a05:6870:514d:b0:206:785e:9c with SMTP id z13-20020a056870514d00b00206785e009cmr11618314oak.23.1705480389919;
        Wed, 17 Jan 2024 00:33:09 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5c15:9a6:f612:d37a])
        by smtp.gmail.com with ESMTPSA id bj18-20020a056a02019200b005c2420fb198sm9889731pgb.37.2024.01.17.00.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 00:33:09 -0800 (PST)
Date: Wed, 17 Jan 2024 00:33:07 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Russ Weight <russ.weight@linux.dev>, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware_loader: introduce __free() cleanup hanler
Message-ID: <ZaeQw7VXhnirX4pQ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Define cleanup handler using facilities from linux/cleanup.h to simplify
error handling in code using firmware loader. This will allow writing code
like this:

int driver_update_firmware(...)
{
	const struct firmware *fw_entry __free(firmware) = NULL;
	int error;

	...
	error = request_firmware(&fw_entry, fw_name, dev);
	if (error) {
		dev_err(dev, "failed to request firmware %s: %d",
			fw_name, error);
		return error;
	}

	error = check_firmware_valid(fw_entry);
	if (error)
		return error;

	guard(mutex)(&instance->lock);

	error = use_firmware(instance, fw);
	if (error)
		return error;

	return 0;
}

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

If this is acceptable sticking it into an immutable branch would be very
helpful. Thanks!

 include/linux/firmware.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index de7fea3bca51..2035a0d9cc86 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/cleanup.h>
 #include <linux/gfp.h>
 
 #define FW_ACTION_NOUEVENT 0
@@ -196,4 +197,6 @@ static inline void firmware_upload_unregister(struct fw_upload *fw_upload)
 
 int firmware_request_cache(struct device *device, const char *name);
 
+DEFINE_FREE(firmware, struct firmware *, release_firmware(_T))
+
 #endif
-- 
2.43.0.381.gb435a96ce8-goog


-- 
Dmitry

