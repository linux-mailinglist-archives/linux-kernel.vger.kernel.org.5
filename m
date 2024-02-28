Return-Path: <linux-kernel+bounces-85611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E38D86B847
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05841C2442D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4E71332BC;
	Wed, 28 Feb 2024 19:35:47 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788BD2CA8;
	Wed, 28 Feb 2024 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148947; cv=none; b=UfE0aoAdOkYnnB5P0dJ3ckd6Q4o+Wco6F5awzaX0SHva1xSN4p3+dTsm0VLdnE/7XEZnRQqqpmbyiIDs3q6fmMt9d+hkI2BxZLpDiBaXiFUHY5sDRVAlw3Ie27IKx5GhvmP1J42bw5VznLv8NRZphy8/XaQV6MGtJWQWoeUGcfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148947; c=relaxed/simple;
	bh=+6etF/fq7ldjOI/GyGfq1efGbshb281kNLWkoDRIiYY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NJAHaHBNDvhh9PChFSwS4LdVHmXAaoI7+5QURV8SR+snMqJ9xiWyBpaOe1UHtwc+mctGvzhyXguYPch+1yB9GXgv7k12Y6pUHJmbmwGaqj1Y9CN3asrk1Siv6bexEsGQ4cH6G4IMEbpkf3Q9ozeHmklyT3kK5DkQiT3qT+qJGSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e4aa4877a9so14577a34.0;
        Wed, 28 Feb 2024 11:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709148944; x=1709753744;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXxRrKueZ7Vtn7mi6LjZZurm7sEhUkklteXK7bV+wK0=;
        b=o7aEJuUWE6UJXbyE66fWmMFeOQVVIv6+MEuAlsicuksaZ5t7/yzkThaS6cQqOh0Ih4
         SRZ+8edJxXpOhvm4Wohy3gj0lONTmCv/iMYTdc+az35Nof8FfnmUd2DOUYMpjegBHln3
         hm8ZgKHwDtOUMeMrDJ/c3kDSsqSLnRT+aAOAiFvb/a5dY0HNiy4q6BATflj2taurzsmi
         X9+IQCLewCpKN53Mlmi6tSMi8/tHDp9nWuvo5aPnO3CP8XPqIYKkutI2nmrIsA11ZpFS
         9epGww1Wfg0IVoQFS56VNwewxhuNR7vsZb8IMc+FBLRpdFiDIV0zZ6IZGrHNrKqXmhm6
         7avg==
X-Forwarded-Encrypted: i=1; AJvYcCVKlryZUQP4P8wWCJn10pEOOhWxocSljC0NYrDISQK2Sg7qUemq308u9y1dt7IKotwm67mUdvFHsUNg0oQ+bBebM3I0tBwxdhaPiLH8
X-Gm-Message-State: AOJu0YxhHahawItyTLG/3jpJCyzLSFjzryhE3BqP1uX+q1QbBV/RRDuT
	I/cVK++U3mf1NSPDD9veh1cxYvM9tS26f2lB36GzkjUGEC2nEr3/8ldU7PXMIZP6pcuxVYGk2IC
	dn4SNvxSp2e2daBCMTIheJeCOSINqBVkLpcs=
X-Google-Smtp-Source: AGHT+IHlA/ryiasXjC2chxTtgTt63LIwNqQHfaBtieBiN9f4Zo/yWMzTVpnvGQpjFIJ59MjDAHS7FSolYg33sE41gL0=
X-Received: by 2002:a05:6820:d09:b0:5a0:3d13:a45a with SMTP id
 ej9-20020a0568200d0900b005a03d13a45amr86864oob.0.1709148944537; Wed, 28 Feb
 2024 11:35:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Feb 2024 20:35:33 +0100
Message-ID: <CAJZ5v0jnP3cJ=tVobm310iLQR0A7n+_wtp9vAefGC_NJ0G2aGQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.8-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.8-rc7

with top-most commit e0359f1551b8d4a8d00704699c07fabb11a07cf1

 Revert "ACPI: EC: Use a spin lock without disabing interrupts"

on top of commit b401b621758e46812da61fa58a67c3fd8d91de0d

 Linux 6.8-rc5

to receive an ACPI fix for 6.8-rc7.

This reverts a recent EC driver change that introduced an unexpected
and undesirable user-visible difference in behavior (Rafael J. Wysocki).

Thanks!


---------------

Rafael J. Wysocki (1):
      Revert "ACPI: EC: Use a spin lock without disabing interrupts"

---------------

 drivers/acpi/ec.c | 112 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 66 insertions(+), 46 deletions(-)

