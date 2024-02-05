Return-Path: <linux-kernel+bounces-52387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8CB84976A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A7D1F22FAA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3F9168BC;
	Mon,  5 Feb 2024 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAyDVk2y"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF5A14AA1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127901; cv=none; b=E8ljD+YA4QVC8nhCvfT9mKeBrVYBovjwleqhzEFdW1KkDstH9xd/+3D2LRUjRyRxdOKDSRVQjBYUYay2uBwbWeuzJWUGnUD4Xsoif+Xjw5uKb6BBoFMQvvQ+LszXRvE1mXw6rNkFjAdcLYii+QHc1Ul3fojR8/H6gk3sq2Ft+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127901; c=relaxed/simple;
	bh=1JXPf4IxvAnsYNQKuCSuwWhoBI3O9aaNpBx6WWZQ3rA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XkWH3oovJFnTeQEEkHxGAbIeR8zOxAo1Hvd3NhU+1tABJxTOgw/8WFCBNLbLPEUp6ssp4Z68/YWG90MqbnRqKDfQ25f0xIKNCRuO7qCooMb4Lg+IaImo/LpXfDjAOTyvoZjtN1A4IyxJETrNwZjUh1PZchwb0s74LCmMgYDyaNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAyDVk2y; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso34714005e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 02:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707127898; x=1707732698; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fx6SHSzTyrYuQWTW6XOrFFYgXM0nYIj9ZDGPGiFkmuk=;
        b=kAyDVk2yvSM+z5o8T285wadf8XN6Bj+5StB8QkB1psTG2lownPwnTXrVjjVSkB1iN0
         Dq1guiejFEejk4nE5vH+rlsKQiWIt+VolcLxXQMoV6l+jrG1WMwBJmrCU5Fpilc6bCa1
         2JPpFn5VUxSaLHo5RJcazbW5RP9o/tWaDxTK+tvGWCDOY8u/3gyHYKQCgWPBNfLaPhO7
         vwErAy7oGqRDyKMzm2oLHgAFntNsF1AqognzHF+LFMIztGGs99yiWh0j55S/ZWWtmzK7
         qjuBiIb/FCnn6I51n7lmVBoJhBLUtq6PYFZAybT7sx4T0xGqC0cyaLVsyYuA4VQv0noE
         Nh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707127898; x=1707732698;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fx6SHSzTyrYuQWTW6XOrFFYgXM0nYIj9ZDGPGiFkmuk=;
        b=EMEL8auDh5Zl/UBO/LqY5cyGoh7r9DHNzx9JVD/X6fldnNNmu1QE0JYf6LEy40iMxz
         2XaHNh17Y8+1WWriwuHZD8pKNeQk/ieTipcS3vl/fQnLUHy9f85s08OLY8VgoHzMnvht
         FrjFF919lyfYbpBFu6Y6RSIKSx9IDFidSd/AzgeWK1ZG2LtwJQcEoXYvueLe7bI8wzdu
         8HPxuFrRmJkYrlPdgHK9kPJ5ezug3l3r+BXg1BghJ7t97ikl3CahXZtjo6inDZR9DuGY
         q6c4gjRsI5Td1JSzztAvN2Qk4qEqodIYY7379hj0IWHb/v2ijvWjitr0rsD29+tgpV9E
         vtqQ==
X-Gm-Message-State: AOJu0Yzu9x/kFSlH2mx5RzNvtN5M8FlymnKqJenSk/1x6iwBG8R21P+/
	U6IxNxRao/AyD5dJx/7j3BCI61fWCkkyjrdC0XGLkjyV5gdcVmr4TOfIscRo+A==
X-Google-Smtp-Source: AGHT+IG3VYYnVbbIFEbkzRADW6gAhKa4HJLfpTckR2UeAIK7lOV1YJ6DVK+eKSIDDLKuZjI+Ynf7Kg==
X-Received: by 2002:a05:600c:458f:b0:40e:8fe8:a173 with SMTP id r15-20020a05600c458f00b0040e8fe8a173mr3998054wmo.4.1707127898379;
        Mon, 05 Feb 2024 02:11:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVM0bf4J8+2x3kdZCfKFeSGp2Batbc39r7onq2ybFrUR9DzmAH+Mq4v4ybCLYMEDvuM/cjGFeug59/5hGCiY4bhb0jSZAWVAGgIV4Qz
Received: from p183 ([46.53.250.163])
        by smtp.gmail.com with ESMTPSA id b5-20020a5d4b85000000b0033b41af645asm673647wrt.108.2024.02.05.02.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:11:38 -0800 (PST)
Date: Mon, 5 Feb 2024 13:11:36 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] sysfs: make sysfs_emit() return ssize_t
Message-ID: <33cd8f96-4b4f-4741-ac05-ef1bd267ce6b@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

sysfs_emit() is most often found in functions returning ssize_t
not int:

	static ssize_t oops_count_show(...)
	{
		return sysfs_emit(page, ...);
	}

This pattern results in sign-extension instruction between
sysfs_emit() return value (int) and caller return value (which is
ssize_t).

But it is better to do sign-extension once inside sysfs_emit()
then duplicate it at nearly every call site on 64-bit.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/sysfs/file.c       |    2 +-
 include/linux/sysfs.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -739,7 +739,7 @@ EXPORT_SYMBOL_GPL(sysfs_change_owner);
  *
  * Returns number of characters written to @buf.
  */
-int sysfs_emit(char *buf, const char *fmt, ...)
+ssize_t sysfs_emit(char *buf, const char *fmt, ...)
 {
 	va_list args;
 	int len;
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -356,7 +356,7 @@ int sysfs_group_change_owner(struct kobject *kobj,
 			     const struct attribute_group *groups, kuid_t kuid,
 			     kgid_t kgid);
 __printf(2, 3)
-int sysfs_emit(char *buf, const char *fmt, ...);
+ssize_t sysfs_emit(char *buf, const char *fmt, ...);
 __printf(3, 4)
 int sysfs_emit_at(char *buf, int at, const char *fmt, ...);
 
@@ -607,7 +607,7 @@ static inline int sysfs_group_change_owner(struct kobject *kobj,
 }
 
 __printf(2, 3)
-static inline int sysfs_emit(char *buf, const char *fmt, ...)
+static inline ssize_t sysfs_emit(char *buf, const char *fmt, ...)
 {
 	return 0;
 }

