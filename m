Return-Path: <linux-kernel+bounces-109997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D21A8858C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED431C217F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD017580F;
	Thu, 21 Mar 2024 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKXFblR4"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060D56B68;
	Thu, 21 Mar 2024 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022642; cv=none; b=EwoThVxN2y9VN5g7N+4Z4x/Wbtv2L2BWpCPSSZkLxFyM3RwXDPfSnAhhyjXxJFEM+2wHvkktX9vdyHKBQP3v6ipQsQv+mWs3pC2oL78o/fxMBjsS52RB53SNxSszswJwAwkMI/pM6Gv5fDEAkaa9EDRsbgkyfpIi+x2v3uz6Xlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022642; c=relaxed/simple;
	bh=DTA9W/t9iIbGd7n0PZa6SLoZYst4DuYNjRduEVFThaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dWE2GD0xL7490hfu6XX6hCFGdhzYHtzaQ/5oj1+JmDcV7yZgK3WwS08eZvDmT1FH2oB2x8BBR5+Uiln+0ZAPUUGxrDylrl2u1gaobFfuwa0XFI1g97Bq1IFYRrgXdqR+Yv4C4+A7dPBdBb9L7IxXX7rzhJ7k/QPONVNXJUUjKOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKXFblR4; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7e09ba2ac02so488786241.1;
        Thu, 21 Mar 2024 05:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711022640; x=1711627440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VWe40Qw2RtIY9rsmg4dS1sWx+IBR19FeZvKGaxKc9lg=;
        b=NKXFblR4rOqkIgcGtOp8+3fLRjaZcnJMDeVrZhnoRRFyGuQcNaYSMMgpS/Y19NSHMb
         ns0tsk0lfi9lb1lCSiZwsabhgdPmHkkIqYTjZ/vOk98RNkNbbzkr4lAYo0oGi24oJcXa
         y6sgjugoF++l3rx7zlYVgQ5zkwPtKwt+Nxq595gjGau+LQLXly2Qk4zD/iIKX1heT3qg
         lenJSUWNjPFU3kjTrTTJweRXIEE03P13G4hDjOiaYUsh+/+LeoWrDzKAYqHjmZa62uw7
         eTHn3NsauoVrWT6jCThGu9uZc95HXNaVzoQucX88HiQCj0am8P8eNGdHVtXkFj/0rzsZ
         Jzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711022640; x=1711627440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWe40Qw2RtIY9rsmg4dS1sWx+IBR19FeZvKGaxKc9lg=;
        b=dpp0XQiXpF1upmguUxu4gvQVcmPf2fKW14M7eQ4tIzboKW+ilWH1csLl1U7beEUAUT
         AivHysojRcN9LXqjHmiEXHbCgOtS5rWavd0slvS/1ExY2D+gNgqho0NFkJFpHWSlwXSE
         U4wSyyhSePTMZ4nwYdT6ZeddEf8uabwTwWd4CUYKiZSLeKQBYiBYhjbHU4bbtx1TS/IJ
         gyoqS3CT3KWz3winaDy0fQOzPN1SDN9XbMDLcXNI+l5lyNZtbvtLJUbpqMiNqWzRtVuQ
         19no8I+v1y9cdg88okNn7y8ZE7biEkG6sRKVzfUZgaIDycwokc0UiC1gesQmqOuCcR0x
         M17Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPjRs/tfTgnCZV4LAOAAoeAMMjARJOd/xmNyswACdqcO2dHevibB5VxTP9kdCTuhE/dsGyoIhhgA24Wz6lLHyLxuoDa+jNnig4j724nXdv/KWhf9nJYeAnQ2MdgacyAB+GXhq7zpGk
X-Gm-Message-State: AOJu0Yx7Wr0nNHIvRI7wvSDAupx7rvH8gsJgkofeM/v1X7ktJPqu3nvO
	6R2iV9vBusut4SxJPlUPVyo8mqxAPNIsOTuA5jfJ2C/AWmoX3tjyAbeD/R+x0NBKLg==
X-Google-Smtp-Source: AGHT+IGd6j5zlTykKxJioDolomp0QHiRr0lYiNs6eUgfeEk0yQ8XJOhGTolmdzYlL54znpzC3S1cjQ==
X-Received: by 2002:a05:6a20:7da4:b0:1a3:63ca:632a with SMTP id v36-20020a056a207da400b001a363ca632amr13355089pzj.58.1711022302257;
        Thu, 21 Mar 2024 04:58:22 -0700 (PDT)
Received: from amogh-desk-mint.Dlink ([119.82.120.209])
        by smtp.gmail.com with ESMTPSA id c23-20020aa78c17000000b006e69cb93585sm13341804pfd.83.2024.03.21.04.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:58:21 -0700 (PDT)
From: Amogh Cheluvaraj <amogh.linux.kernel.dev@gmail.com>
To: airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net,
	javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org
Cc: Amogh Cheluvaraj <amogh.linux.kernel.dev@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix duplicate C declaration warnings
Date: Thu, 21 Mar 2024 17:27:08 +0530
Message-ID: <20240321115738.51188-1-amogh.linux.kernel.dev@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the duplicate C declaration warnings found on
Documentation/gpu/drm-kms.rst that was found by
compiling htmldocs

Signed-off-by: Amogh Cheluvaraj <amogh.linux.kernel.dev@gmail.com>
---
 Documentation/gpu/drm-kms.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
index 13d3627d8bc0..a4145f391e43 100644
--- a/Documentation/gpu/drm-kms.rst
+++ b/Documentation/gpu/drm-kms.rst
@@ -357,9 +357,6 @@ Format Functions Reference
 .. kernel-doc:: include/drm/drm_fourcc.h
    :internal:
 
-.. kernel-doc:: drivers/gpu/drm/drm_fourcc.c
-   :export:
-
 .. _kms_dumb_buffer_objects:
 
 Dumb Buffer Objects
@@ -458,9 +455,6 @@ KMS Locking
 .. kernel-doc:: include/drm/drm_modeset_lock.h
    :internal:
 
-.. kernel-doc:: drivers/gpu/drm/drm_modeset_lock.c
-   :export:
-
 KMS Properties
 ==============
 
-- 
2.44.0


