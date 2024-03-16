Return-Path: <linux-kernel+bounces-105270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C280D87DB3B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 19:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CEB7281CBD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DEF1C696;
	Sat, 16 Mar 2024 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjBbSzYq"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FB11C680
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710613467; cv=none; b=fDM9K1ciRPaOw5nTpq/FRtkF4JlN+DTSHolptyHC/J7FL+FTdFijtWqtRtv3rPVh8V/FBoW3EkOiR27Qk5n8ZX+LpnSayNdL7/KxCwZbR+0Xd65Bucw9iI315Rdlbea80nSHCrv1+ZOYA1YvcuZCaFPbbU47rZ6+9sHNw0F177g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710613467; c=relaxed/simple;
	bh=kdtt3NzZ9nYRAP0wHMvXECy1vS+6sTci7jlAi8PaMwE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HpMnWf4GtSiAe+v3rewI5VuwRV6YoIWO7SX7Eapd3x3G71BIhkOey07rZVW1fiXv+OoJ5912RlBXVepNkGYgiK+vQxcsgJUEfxDD6BebXYEGkNMxR2YImv60dxBKfnfs4VbOYLoP+fKSer0sDR26UMPCfkBUAyeri825Qbf/69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjBbSzYq; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22222357d76so1914264fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 11:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710613465; x=1711218265; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E09IXxgUM16xdtFyL0dx+eMZf9QOFWFcDsMglhoVD7I=;
        b=PjBbSzYqFAqVQ5W9Nm8AQhYIbMeH/RMcWE2pOKxQ7us1gno7UBasv1zlcAolAxplCq
         e6lylW5kqY3wbhHEAWOwvme+ZqEIcebZcpGDCwEh6/rOaqmVzJTsBjzZxSx4OqmykzBn
         ku2chEooL3e0kNQgPfWngsKQ0Uw5jOVmDxtefXcWbwHTvHvgJUn4Zzm/jsnRH/pALZkm
         bzNWJnM7O0Je7Rc8AfKVtXscQWSS4pzam+nvZQP+bSiRYWqNfU4c1S8TK2bj+PUtMw43
         9lE0G12djisQmaXa9oxAyY5vEjMLOdJND1KpARtgSX7X5qkynidXu/u0KLYmRu5GVMXW
         UN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710613465; x=1711218265;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E09IXxgUM16xdtFyL0dx+eMZf9QOFWFcDsMglhoVD7I=;
        b=eqLVg+PGpSzejzpUCIfKSnd/IgUo790olf9oQG8pKJ4/Bz5V0C2MvedxfcrFpJpGyE
         bfi3svkyd8blI6e9ilbAxKEvgZ0UGOgBICOowq6YboQCPAN4wXVErOzcLorvGAaejE31
         dwvovbpGOyDSlYU9dijI9717lRDPvpwDdvF3IyRfUAgeE88P7dugo50l0RaWozdBhCYP
         eqCMaUZ2/zIg6EIHOudhgq8/hee0SpZYsz4LCp4WGNbGlP+mHHUVY1xFgZTDtJTtIEBJ
         2kG13aUGIIzgdqQAC+0zXZfmOqQoq5lswiEbatSVcEeDtFfGnoAhFuAF6XWvVbv5vxND
         uZoA==
X-Forwarded-Encrypted: i=1; AJvYcCXJXJfngdTNU/qa/FNVZumu9nGHmxeezrb+dWhYa6zhT48KXu7dKtPM1AV781xipiEbRci1eJW2ffU0zGwaj0BrbXVVdCPEEB2hW0ea
X-Gm-Message-State: AOJu0Yycc5YgEbmCHStlXrSgG05c2TWQ6ygX7ezitIdJw1Hsok5JO0SX
	U4wt7FIRWJvpF5TMIqHzTunbDsglN3fA6LWYWvnKYXz08uaje8HW
X-Google-Smtp-Source: AGHT+IF9I4AUP4qpAcKv2jcUOn6honDrtJrtCTWJyd3xHrUyfO+pv4YrLF7XdBNdWs4pLEOEir8TEQ==
X-Received: by 2002:a05:6870:2046:b0:21e:7156:a69f with SMTP id l6-20020a056870204600b0021e7156a69fmr8218616oad.42.1710613464644;
        Sat, 16 Mar 2024 11:24:24 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id y71-20020a62ce4a000000b006e6b989514bsm5451616pfg.60.2024.03.16.11.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 11:24:24 -0700 (PDT)
Date: Sat, 16 Mar 2024 23:54:21 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v5] staging: greybus: Constify gb_audio_module_type
Message-ID: <ZfXj1WkJ3nrYh3qL@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Constify static struct kobj_type gb_audio_module_type to prevent
modification of data shared across many instances(instances here
refer to multiple kobject instances being created, since this same
gb_audio_module_type structure is used as a template for all audio
manager module kobjs, it is effectively 'shared' across all these
instances), ensuring that the structure's usage is consistent and
predictable throughout the driver and allowing the compiler to place
it in read-only memory. The gb_audio_module_type structure is used
when initializing and adding kobj instances to the kernel's object
hierarchy. After adding const, any attempt to alter
gb_audio_module_type in the code would raise a compile-time error.
This enforcement ensures that the sysfs interface and operations for
audio modules remain stable.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>

---
Changes in v5: added more details as per feedback.

Changes in v4: added more details verifying the change.

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


