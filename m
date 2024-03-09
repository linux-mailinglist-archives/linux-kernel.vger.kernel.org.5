Return-Path: <linux-kernel+bounces-97817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D98FB876FE3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CD31C20B07
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FD837142;
	Sat,  9 Mar 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaenY9a4"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AE21E86E
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709974431; cv=none; b=QNaP3mhAcng8WyRPfDaYReAnP7n+1bWiFTrDxSq4g0hQ/vvyxjtd3EyX0Mf6aqZjHl805zjBVvf7ZSXBhrsMEMyB5bJXmOMN7L4UQ/q0w5xRwhbO9wIcmuhUL6KmdUWMsQRFZCcILaI/bZwMMXjGcgRScjhY0aFnPtsi2mfPwzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709974431; c=relaxed/simple;
	bh=shSEqvzoYcW9i9bedM9kkMWWgl1mlPbsKYHAmRts1zA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lyZNlJdFGI3YZv7+WF22CiJBMBdxSEySY3r50M1xvllyOj+n0YtkZ3jjq28jaF/b7t1QB4VRKWOU6Hh2+n3wMj+ab0s1LCP3ZPJLfUHCE83waZNrLJzuLcl+twuniqMpilSKiRcpjaoegK17hekaN4i6J1CaDIZ7tqx94vdI63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaenY9a4; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso2226830e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 00:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709974428; x=1710579228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNPyITx0UoynK6dHtAKEbnzfq8iXUV38jg8rhOlQ0zw=;
        b=CaenY9a4/ks9CpU4zSszH7gmOEb9fFbsNLgyRDQU2eNlB2LxySm/fpP2UoC0wT/O2X
         zgkOmib/4ClO2AIfQJJucO1Wx34v4P3qGJX+agPX8GUfOSAMk1TKKaopmZyQ3JDBlb9X
         v2I5Gf6ECQh+poJ/Rd6VgwscayjjxAZRcMhNlPdqS4Js4vSlA496p/HgZJB/55GfRWwA
         xPhmkREfeHaHwW5oxoSuR3R+5HfObePYT7Yx0qDLUDg5uwjFw7D2XIIpWFj8HrVHYddm
         T5W/KpKYqTIC15OzSnp4QR0E8qlKyhJTyCWsQjMtI61BZuB8LqXzYcevddXaxrXRf2xn
         Op0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709974428; x=1710579228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNPyITx0UoynK6dHtAKEbnzfq8iXUV38jg8rhOlQ0zw=;
        b=TvLrKkFp7ZAaW3TlZ1fZg1eIFFxiGhkjXyvhiAXxxTqgR4DayP/HC+fxazanVoJkF3
         2Qs11oFy6XFjsDpgKnQA8kRdu50Blo4o1Q9vfqPu00CSxvu0RM5rjRLyN+pIb5S4nszO
         REYwP9PcHDl/c6u/wNZ47twcpg5/fo8i+6c2Y+SUW2PjnVTJUFby3l3cp76ycbiD8tz8
         8XCFUFejUq2clS3GBvP0dM1zkO3ikDQtVnFwruWpqwhecTs0pI7SmmQXy2gWIf93LGGz
         IJ78hgSuqRba8gqVIHeG1Tj+XSZnfhjIGT+FsLdsGeTkLHFWXcOA/vhcVunM38VyDzzE
         Cx+A==
X-Forwarded-Encrypted: i=1; AJvYcCUWUivLkr9wC3G6FKQdqH2AvGbiIra/U/cDBlU4xP0mMZg5IwqfEzGOUY24nxom5rqzwXIaV5dYNZWHR5oOEu9NuMOjzJOswBQr8Z5m
X-Gm-Message-State: AOJu0Yyhx92p1OVspInw6O3UUo1xoJ8yhPf4S0ggDZ/Y+FIMvmdN5e1X
	mEov1uyMvKDnYjsnQUJwKVKneaDuNiVyaJIaMFR88KpjJQHgSVHB
X-Google-Smtp-Source: AGHT+IHWWg4PEGcbbfCVrN6utTHHytI9373U5pZYUdwcYrJWllctTcDb/ukmfX5viJwNacieIamtCg==
X-Received: by 2002:ac2:592f:0:b0:513:5951:61a4 with SMTP id v15-20020ac2592f000000b00513595161a4mr711358lfi.6.1709974427468;
        Sat, 09 Mar 2024 00:53:47 -0800 (PST)
Received: from localhost.localdomain (c83-255-0-123.bredband.tele2.se. [83.255.0.123])
        by smtp.googlemail.com with ESMTPSA id i8-20020a0565123e0800b0051316a84295sm242769lfv.144.2024.03.09.00.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 00:53:46 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jonathankim@gctsemi.com,
	deanahn@gctsemi.com,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH RESEND] staging: gdm724x: Remove spurious whitespace in macro definition and tidy up defines
Date: Sat,  9 Mar 2024 09:53:27 +0100
Message-Id: <20240309085327.57537-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes the following changes:
 * Removes extra whitespace in macro definition and
 * Removes extra newlines between macro definitions

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/gdm724x/gdm_tty.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.h b/drivers/staging/gdm724x/gdm_tty.h
index afec97ced476..3e0d5b621b25 100644
--- a/drivers/staging/gdm724x/gdm_tty.h
+++ b/drivers/staging/gdm724x/gdm_tty.h
@@ -7,8 +7,7 @@
 #include <linux/types.h>
 #include <linux/tty.h>
 
-#define TTY_MAX_COUNT		2
-
+#define TTY_MAX_COUNT 2
 #define MAX_ISSUE_NUM 3
 
 enum TO_HOST_RESULT {
-- 
2.40.1


