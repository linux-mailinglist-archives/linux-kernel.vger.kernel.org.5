Return-Path: <linux-kernel+bounces-102962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD54F87B924
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621211F232F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC8A5D73A;
	Thu, 14 Mar 2024 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifcjlVH+"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC535C61E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710404007; cv=none; b=d1VQgO4neaaQC9RshK7VhMbhSAS8JcAxZjKYqZlhKF8mTAO1nulhMH0z5+speRH+0WNk+/ot37rf4VsNa0AtBWLkUVVdDuoIxlKyQYtZ8l96HQ3NQ12ytxkyYg1eaBSdxPR/HJJTaut8wrM2KLHH9KRIFDbIM7YWB0ynYQapW24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710404007; c=relaxed/simple;
	bh=mWC2hgkMgCMjiK8Q156Dzzx9hdHJuOl5Qi5+yUsPPzo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WgG/M+K9kp2f/2DktF7TxE6dx4pTZWAvoycQ8wxJPSRFEH60kkHnjdj3nR4+wSYeDuPVH7zq9cAqMvjcXerUW3+A0oCIxK1BBZugBdlyrTduU3k0Xo5wv25+NyyInHSWLoPjuy6qDx5PdhTqC99U23vC5C5QGYLeR7HKSZoeyS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifcjlVH+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dddbeac9f9so4990845ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 01:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710404005; x=1711008805; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qf2aeIWPzVWWa3DPEsJ5xpz9OQKvw7835GGNh+gdPhg=;
        b=ifcjlVH+MB/U7c2lP3D6InxTnrxFzre/0tS7dOp9HxpcnyFUefU69/UFKTReFkxepe
         N8OT1mMZYBau/J4Il/6kW4rfyMHyYLNy64L+e08YruFELSY+yA20j/+JfSa/0+h77qz5
         LX9o1eJQGj5YbFN+c0eynd5u2M98UgIn8TmdZBIGHGUd670HFGu1LIUhZ2/lXW6JiacD
         FuWhR40g6SzQLPck4EUGCYaQxIdUR3bZUBCPMnSyC+spxgBGo9kA7LIci/DMynxeAUs1
         zHCitHdXAjsScHIePdtk0JEZwu1VbDfMMvGcfMmFtpJ0GROJHXVHjmFhFMPJcCxXb1SZ
         UAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710404005; x=1711008805;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qf2aeIWPzVWWa3DPEsJ5xpz9OQKvw7835GGNh+gdPhg=;
        b=PN1lB18BSb3+cA8YU3uu11Yht+UDlPxcYAgcsB9JLhxBGJD885I1Aow58G9OI2pGV1
         w6t2/OuKO6fRpN5uoyS6li5EuYHgrHrdo9909CwhTSODeFTbg5IvWuXgtoIH9aSM1tx2
         n0txl9/CgH7gRSXKOj2Z9jqI+N5QJEPze+WC7nGkHtNcR7S9FygWYvCIkahVcDkWvHLS
         5ko9Js3K25a/KmQKawG9bHLQSmYkyzmHxdI3j1yQnZEIHJKPbnMJKEOKs7gqB30KXZ/j
         nI1iTIMZdXeT8J4XOfHmFtslX+ck+m4YDEOEuRCVmJODVzsr/geeg/nNvUDmnCJER3pO
         dc/w==
X-Forwarded-Encrypted: i=1; AJvYcCU6sqSpi8H7T2rq0qjjUU3MpGqsWXe0qrragmpMMeJfPf8sGiNK5Zvg+8budqBDoTq9B4W26JoKgqetzXh+aLJ9trojJdwf1iHkh+0K
X-Gm-Message-State: AOJu0YyeCi7x/mHDD7pS/8ubAlaxu1U3F0nq1/a1kOd2Kfp8rJyqNIKs
	e2czo1UAseErQHLM3QFL8CEx0V0F0FKKHq79tw0UYjPbtoBRZL1O5Bns5Z94EL0=
X-Google-Smtp-Source: AGHT+IHCCStWnVtJ1wfplEcsTHexRRD3jpD6RyHZM76NJzaGiMXVfW4xTIg4p8HibsP6/RukAdfcwg==
X-Received: by 2002:a17:902:ea12:b0:1dd:a3f5:edce with SMTP id s18-20020a170902ea1200b001dda3f5edcemr1342937plg.11.1710404005220;
        Thu, 14 Mar 2024 01:13:25 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.66])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709026f0f00b001d8f81ecebesm1019296plk.192.2024.03.14.01.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 01:13:24 -0700 (PDT)
Date: Thu, 14 Mar 2024 13:43:22 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v3] staging: greybus: Constify static struct kobj_type
 gb_audio_module_type
Message-ID: <ZfKxooDH2ef6/1y3@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Constify static struct kobj_type gb_audio_module_type to prevent
modification of data shared across many instances, ensuring that the
structure's usage is consistent and predictable throughout the driver
and allows the compiler to place it in read-only memory.
The kernel builds successfully without errors or new warnings,
verifying the change.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
Changes in v3: added the message that verifies the change,
as suggested by Julia

Changes in v2: incorporated changes in commit message
as suggested by Alison
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


