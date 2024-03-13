Return-Path: <linux-kernel+bounces-102394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5166C87B18B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E571F237B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD535A0F9;
	Wed, 13 Mar 2024 19:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjsVS+t6"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A6C168CD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710356582; cv=none; b=IuANpoL34t//+u6iMkxP6JechKCE/aDJYEiPZoXQVxjLOAikZQPm6AF/DP21U5n/U2tWc1RN6RT0k7c6yS7gfWDXxwMR4sn55YBux60IqHYYP3ijzNWNcV3hW2UuYzkpKHNqZ2YxPjK8tq0LhNhj8eSLQ/2Q+D4RK2DNtEDw0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710356582; c=relaxed/simple;
	bh=jyHu3DD33SQw40vH0ZcmNDRW4P3d+298/8SBjo+jPWE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jqf1iKNh/OPTB+g/ARsVbT5WokeJl5y7UBiVGwipz49/aCP53p1Aujlf7edMId3MOQcZaQ42AiB7yrg875m23jg2LnAiYzLvLVY6oB7lJmZx8AlUjlXzClGccxKbxkNilM/wxGHijg6EnEMkdua1ORWiwk15uvD8Ylx1dQS0FRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjsVS+t6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dd59b95677so1403295ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710356581; x=1710961381; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19x1Ac15rLwOqUkCkkNDCNMXVAzg+BltQMzrd17CHPE=;
        b=SjsVS+t6HCguUULmLzrkj4cOnEj8nPo1wufRXDiANZIEmoWHsTJ5IMPq5w5080tNTy
         vztZmh0AxQF1FXNq5WeNbglBHjcO7frITqNHKpERsbUX3EuE/5cboiOdKikhCWXmxloX
         +ndb1t0ILAWrKkuh7pAd589WYUZ92vAnb8be8TVJQQYREZuvMGO0oHCJzwpynSPs6v8J
         j78xltjaFcKxJa+fwMR4dQjVaXj+mijJETct7p6jEt1DAb5BhU0bYAk9mCS4z0irFzDC
         Q3L30a01cdLXaJLqA7NjMKkzwQaA3z3Hh2RrdlfB3uN9g6U+s3xtnhK4YzotfoSxNLSc
         +VYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710356581; x=1710961381;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19x1Ac15rLwOqUkCkkNDCNMXVAzg+BltQMzrd17CHPE=;
        b=CNc3+Y6urBmGJt1B5r7XbmgiKt9rCylvU/TY/sO5pKjNoYczDLZlg2ie/4ODAPDj2Y
         I+mnmoqqTV1bb0vjdYrQBfEsLI+21BkSYZg+j87runPdkCw0/eZ1nkSI+gWcwYHYkqok
         gNBnAVNttSox/NBYkq15pVOgma5p9A9eSGCCVa3FCnieN6dDjNKE3f7Kf7wztVrDnjHq
         lzWiLA8Rqf5P65Z4d0q68wFtgDR7xYL+5z+OShngIditvDGkMwRDaYHVS17iFwRz3xt8
         tp46Lm9r4fBuTB937WU147QK8ufY41fcUZySrM25eHv6/qTRhz56+xmVAJH9o376d+xk
         q48Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/qZhYmw6+WP+wOEO36IS+nJD5EXAns7CyZvK3/KG/PhhrXvMI7FtPlGt65ZwMnPbvQXt4Vv5dAgJXsfuu3lw+OF9REE6TTLaMgSxK
X-Gm-Message-State: AOJu0YyYH9pYAS+0872LKbVJZAmFzHZcwoe0i7QW2W+Wf22EDfpQvY0F
	UxFHPyJ1oXGnyZH4qliy1fosEclLyCyEoF/EQa2tfaQPnU5Y2O6H
X-Google-Smtp-Source: AGHT+IE18sgOLbaW5DDx7QTLZxLjcsulic3sUQHOlLW/Qrfss+6U0Y8XhvyH1Tqv5XUVfxAjP3rZrw==
X-Received: by 2002:a17:902:eb88:b0:1dc:1c81:1b19 with SMTP id q8-20020a170902eb8800b001dc1c811b19mr17280391plg.3.1710356580702;
        Wed, 13 Mar 2024 12:03:00 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001dd91af1f03sm7142853plg.200.2024.03.13.12.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 12:03:00 -0700 (PDT)
Date: Thu, 14 Mar 2024 00:32:57 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH] staging: greybus: add const type to struct kobj_type
 gb_audio_module_type
Message-ID: <ZfH4YZ9qyK231T5l@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add type qualifier const in struct kobj_type gb_audio_module_type to
address checkpatch warning and conform to the kernel coding style.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
 drivers/staging/greybus/audio_manager_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/audio_manager_module.c b/drivers/staging/greybus/audio_manager_module.c
index 5f9dcbdbc191..4a4dfb42f50f 100644
--- a/drivers/staging/greybus/audio_manager_module.c
+++ b/drivers/staging/greybus/audio_manager_module.c
@@ -144,7 +144,7 @@ static struct attribute *gb_audio_module_default_attrs[] = {
 };
 ATTRIBUTE_GROUPS(gb_audio_module_default);
 
-static struct kobj_type gb_audio_module_type = {
+static const struct kobj_type gb_audio_module_type = {
 	.sysfs_ops = &gb_audio_module_sysfs_ops,
 	.release = gb_audio_module_release,
 	.default_groups = gb_audio_module_default_groups,
-- 
2.40.1


