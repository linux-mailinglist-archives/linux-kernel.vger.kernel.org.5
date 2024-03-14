Return-Path: <linux-kernel+bounces-103689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D04AA87C304
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70BA61F2439B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787A21E480;
	Thu, 14 Mar 2024 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI335Mhq"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921B71750
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442086; cv=none; b=iOMajGf/DyguKp84SCJRNBEwwwld1hL5JzL8reJ4+1c0YPBQQrgviaFIc4GVijh4aNUFZOawH6MyXTO2X/zAuwfRrzDJFk0F83yZm7hnLyFo/zzZlhd3LbnQv32giAvL5d55AHJ+IkK3DtoUyedA6s6N4WLhTg4ve+i9cZ0loFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442086; c=relaxed/simple;
	bh=EZhbH9Xwujr/B3oht4heJ2cRMgZi/vMO7ZMCqXz3KMc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hwJTT6SCSZmblSgqAEZRNuCBAo14wndUqOugmEECtaAs0cjeQ2b6xeWJf0Xv8aezpm6J9X+aNO9qaZMy6zGn3qP7S3PGFd35VyfviY7Owj1LGPxWZdnGIz4rKqUpW+HmBZeiV+LIGXLpY77HZlwwARb2agvRYrvvlXjeOHDJKb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI335Mhq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dd84ecfc47so10012805ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710442085; x=1711046885; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QCEUuHzDWcMi+OoMke8TXPhtm1lQOemQGrFVoSbQ18I=;
        b=DI335MhqzDKZPv53se/zCIkwMtn1U0bYn0QbtjtnowYahz69fBc3jymn02rFPR4uT8
         pVJoPHwpzv9UtmQXl+hgbbejBmMDrPTxorpcjy6CG0tyXgasKOVmuvcWlWVU6W/METXI
         6dUkAVOURSOMmYnjx8tqoJGTYbVmAiM3cwEBxgdgOhq+v4YBAvY86HTq3295U3ZhcOpM
         1dgGbLn98ezEhyfZcsMxr1f6Guya0z0PpjfJESeRsC0tEYEWwWrMWQtwWL/e6GtEhwZM
         pU0SbC2PZ3uLFBuRaQAk8/NVifUe94IqlRQeHcrLkb83jjzbkA8vGTNeqcBdTqMD0hxR
         eNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710442085; x=1711046885;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCEUuHzDWcMi+OoMke8TXPhtm1lQOemQGrFVoSbQ18I=;
        b=R+JB9KVRzmQRdNJ3PZVgQq4BY3tLsKCuREhx8lItH/fxFrZPigXrBB+0vTkPnZv01a
         xGv9eaIpXOzizcg/781er8IxHZw4h++1Opa0UyjAvKirofX9O+3/Xba6BxOLYQ55scq6
         cB6ObhPpprSHgXDXQ/az5Wy27WlDc9lCU4KTG3MICUgE6q4IjUsaEQ6R6SExJeboTOWW
         74M/s4NRXnhoilwkiU28US7b9oWdSAdXzeGpgtmo5CEroYDD3yfuU582TZD4qoW6sGtd
         hvF9YyNLBkdlvSxgQjzB1z6voTIdQMsaUTYnCioXJql8xtfQtEJ41oxX4NzMrLUmexuA
         QrLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxbDaiRCAM/pdUbeGVg8OYpSCDIKOh8+NA8uK+ft+MNt39N89ZH+WEeZng/uiI2Tr52L+hdY3nCDtuIoZGVuxM5W/c/TNYD0Ieue4b
X-Gm-Message-State: AOJu0YyMeCKu7fNc/dpkH+hEGm4bBDJ74ldE8+p70L0HLtzTYs8z/ANZ
	yOJE1d04fEAJ3tRmdzECpNBrS6uudoKY8ix/AICNqInFepdpCETP
X-Google-Smtp-Source: AGHT+IEDtQA/4/IxqD2QHGTaBEu5I8uPvanoYr5fvT4nwEYTBsMMRCgC3ZzP5HFhm2YFPaLC4rGc1Q==
X-Received: by 2002:a17:902:6504:b0:1dd:de1a:bd02 with SMTP id b4-20020a170902650400b001ddde1abd02mr2656915plk.41.1710442084587;
        Thu, 14 Mar 2024 11:48:04 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.66])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090311cc00b001db9e12cd62sm2069170plh.10.2024.03.14.11.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 11:48:04 -0700 (PDT)
Date: Fri, 15 Mar 2024 00:18:01 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v4] staging: greybus: Constify gb_audio_module_type
Message-ID: <ZfNGYSC8CDHqVPlm@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
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
The gb_audio_module_type structure is used when initializing and
adding kobj instances to the kernel's object hierarchy.
After adding const, any attempt to alter gb_audio_module_type
in the code is raising a compile-time error. This enforcement
ensures that the sysfs interface and operations for audio
modules remain stable.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>

---
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


