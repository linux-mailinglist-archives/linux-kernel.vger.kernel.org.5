Return-Path: <linux-kernel+bounces-129049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA828963D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F9D1B23F43
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B662346435;
	Wed,  3 Apr 2024 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWNU/nvt"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146E645;
	Wed,  3 Apr 2024 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712120914; cv=none; b=DLVi7V32JhXebf4e5fDBAY4xpUNKA1PrnA+oW6V+3iYWOqjp5uXCj9YJ7dThN1TNGO5fib+M8nFQfNUOhMTumRVLshGI+zkKk2HSiAkhvhf0/f+/v8fzWXLuERzlgelpwK33joHCFMM8uNO7E5KJz3wReDd0Lywu3BZyedQn7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712120914; c=relaxed/simple;
	bh=iTP2lx0+5/hKPX7Lgaiajz+wXzMvaqjQegPjM1Ons3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oRcFOvHqj/c5ZztUShVjog1sbqQao1oj25JRurfcLDJ8iUsrAazkuVwPE1sXpihGGociSQWgz/4Y/mMXTkdZHVeRoT82+MvUQLe5i5lQmYdw/EokHSmW9HYnZLD3q9MWnnT12og+wnfG9toA0gpnaEzIMuWFwYFTPJmyH520c8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWNU/nvt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1def3340682so51552935ad.1;
        Tue, 02 Apr 2024 22:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712120911; x=1712725711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+IAlcsaX9nh/sd//p39jgfKrXWxYVdvV9uT5WXHXs0=;
        b=HWNU/nvtIl7Akmiawa5+BcYtkPS6yur2Rrzd78I+6OI0M30e/tSDodI3X2fX6ijWno
         lQgxmcF7eldUnaP1eSrUwfv2T1y3SEfWvLMQsm+sipjHThGcj5Kk7NVDbE1rZkORCECj
         EH0twR76bSgVWZRTWLS0IJa9ZYuIt/2nRMW8rMH/LzxSE+AJJUBzPHrwhMdoxkRrQn2H
         WDQ6EOrwK390BDkPvEWoYOs1aCpUEPql8sKzrO1/qQfXP5AWGQhzmjF0OFmKA64yRCak
         TMFDxrf4BuQ05g8PaDi0MjFtjHKShdzyx6IrGV2utDaytYYO8UKCUm+0Y8h6GPNYkS9s
         AnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712120911; x=1712725711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+IAlcsaX9nh/sd//p39jgfKrXWxYVdvV9uT5WXHXs0=;
        b=Vk76cg6S2fDD3RANUxYKx2Dk6PFpCaIdxxwLBEyi8FQTyVxp4bVrcFbM0nwJ7UiEUn
         lyjfWI83cxNbpEVaixdtw1gDlm1hzZRGo37vx09ydtOgo2vuWH/9M9FNYVMNGpXa90z9
         eyPrhg8rWa4uEC0qnFCDGK8m+uERzwZoFiWWTCE2hv+CsbJUkP9uYHt0Pwwgd2iXXGFq
         4ZeEOPQRlDGnZOGu8rsnph92Q58r+PVc0TGqIC/firt1ck4pOqS7125ufi523D2fPcC6
         LSGQsM79CqP/Y3vGP97YcXAOfi+mo4S//hFUawIcFh/09RfaZqbYrGzyY2Fny8akjiT6
         n1Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXz0ZjjR6aZwjnTIJ4+zXXqFWzzg2QdpJmZLKDsGkDLskC6Lyp2A4VKyBG810Ko97VsJJ0gWz4H4AiEofj1QWsYpkcskAtFDzA3mxzFUcjdDOvSGIug2UHtRuIFHJRUm3sOb3ERvwCH
X-Gm-Message-State: AOJu0YwgibhXu30N+a37snoLT7+fzGsM+gXEX+v2maSGP40eyox+IvRq
	j4bHynkUsXI85sFnLfkYRzhEIb0BNO0377mq1bN48zMTdi+TV8qT
X-Google-Smtp-Source: AGHT+IHNtMsKzrW1xkjckiZnmLdT2waJr420bJqVcEia4dHJD/3JJU6nrRQW0Z8B17Fg8zZT8c+7YQ==
X-Received: by 2002:a17:903:2447:b0:1e2:6191:b97f with SMTP id l7-20020a170903244700b001e26191b97fmr6425041pls.6.1712120910958;
        Tue, 02 Apr 2024 22:08:30 -0700 (PDT)
Received: from kaiwan-dell-7550.wlan ([205.254.163.212])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902680d00b001e27462b97fsm2304712plk.293.2024.04.02.22.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 22:08:30 -0700 (PDT)
From: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
To: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Subject: [PATCH] docs: Add relevant kernel publications to list of books; LKP 2E
Date: Wed,  3 Apr 2024 10:38:24 +0530
Message-Id: <20240403050824.166787-1-kaiwan.billimoria@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Carlos, Jon,
As the 2nd edition of my 'Linux Kernel Programming' book is recently
published (29 Feb 2024), this patch is to request it's addition to the
book list.
I've currently kept the 1st edition as well (in reverse chronological
order); if this isn't required, pl let me know..

Regards,
Kaiwan

Signed-off-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
---
 Documentation/process/kernel-docs.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 8660493b91d0..f73671b65a71 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -75,6 +75,15 @@ On-line docs
 Published books
 ---------------
 
+    * Title: **Linux Kernel Programming: A Comprehensive and practical guide to Kernel Internals, Writing Modules, and Kernel Synchronization**
+
+      :Author: Kaiwan N Billimoria
+      :Publisher: Packt Publishing Ltd
+      :Date: February, 2024
+      :Pages: 826
+      :ISBN: 978-1803232225
+      :Notes: 2nd Edition
+
     * Title: **Linux Kernel Debugging: Leverage proven tools and advanced techniques to effectively debug Linux kernels and kernel modules**
 
       :Author: Kaiwan N Billimoria
@@ -91,6 +100,7 @@ Published books
       :Date: March, 2021
       :Pages: 754
       :ISBN: 978-1789953435
+      :Notes: 1st Edition
 
     * Title: **Linux Kernel Programming Part 2 - Char Device Drivers and Kernel Synchronization: Create user-kernel interfaces, work with peripheral I/O, and handle hardware interrupts**
 
-- 
2.40.1


