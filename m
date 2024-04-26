Return-Path: <linux-kernel+bounces-160055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6EE8B3873
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB401C2381C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46E6147C62;
	Fri, 26 Apr 2024 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVaWxPPx"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC4D13E88A;
	Fri, 26 Apr 2024 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138168; cv=none; b=nn6wz86aMQwaDJcal8pkQCg6a38ekpfpyQtfZb7G6VS6o6dkMPI8UGkMYIZTyQZm2pTjRQNC5hG5Y/mm4n0UQGkE0CRb3TU45KtcTzrEWz9+uG6U0vqk7YNUG2QIXmx5WQTSGlerf2gNvrg0xJJugc4aLHsSNrM0juaeiMOiA5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138168; c=relaxed/simple;
	bh=sSXrIPk8dN5BzLgwnptVn5b+rd6IY6uVXxvm3G8/Uq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rZh3d0Qop0sZWp+mGPpJ4n6YPN6E+YxAe7noL/ba6i7Pi2rLzHN7KbKOD23t0pFTnu63s5ZTSFdB6MXVWjxPX8MM46npv0OiBqPO9JiX3GpUzQwffnvOz+dY4BRvLg8hfOThISNMfjK0vdcLHg9lidEp9uh8xf/wjRx0gVwXlTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVaWxPPx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e9ec116e17so72265ad.3;
        Fri, 26 Apr 2024 06:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714138166; x=1714742966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FbA6cjhW6J46GsVq8JXfhJHiSKYbkxI3o0KCxsENyUU=;
        b=LVaWxPPxGkwTHW3CBi6LG50UqzX7c7w8G2vrYV8+HtfZb5BMIMP4x9+G2HQ6Bz7BIJ
         ImU/Qr+AOFckftAEhhMftnbYg7V3j89kDwOAVpB/cta4G9dKtLE8T7h3hJwBBIIJIOA9
         mmOOiRIGahaHJxuEY3NXKrpxeQF7P29yWbzl5S9fpBwl571fsuufJzv6ratnmPMwi99R
         5sA+yX+btoEGT2TpXBxhoQ73MseUREkyIYRShE/g5Wy/vHf17W7FEgvqvYChNyP8MGhP
         HDQQ5yG4JT6LOMtoPeQNykuveT5fWQCw0Nysy9SDRlu/DXdrJi1VdksBNqRqYeBTURpj
         Ipfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714138166; x=1714742966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbA6cjhW6J46GsVq8JXfhJHiSKYbkxI3o0KCxsENyUU=;
        b=UUq0x4cK4Tnfwr7jHl73Xt9yubbezJ5DRTM+XWbPnNVXTBsnelv2t0jwL40y7ZIwhe
         WbH1A8U41DXeoeIAUBZ2AcVaZJobqGF3P8CMTuXE3LYSPSAZd2DlO2rq3IuobZLRyITr
         yXCSWY8flFtzXD5qkItcaW5eYRLutcxV4xjof79FLhHmGytmDBFSOQLW9y2iHe9/PWFL
         v1kXA385HyEAEttggK73NJ1lXufDPzQQ5+onw2F2uoa0zfTAyU7bfSeB7C+LOqNh0fhf
         0rtH3xDWLsAiRaFug7eaQDyxgpM7NBJ8OY/TaaLf5LxufSSgDaicoWISNigRZR2k+VgY
         9y0w==
X-Forwarded-Encrypted: i=1; AJvYcCXaqHtvXF9z4hL3/0tIKdUbvvdz2j5BhG3FXfQ1fN6N/m/lr1D7eKSWLVk8e47lonI6xspV07Ub0tR/qTyo2hhGgGA4zOIpPo6LR/mP
X-Gm-Message-State: AOJu0YzG3tPaaCqa6YLzZongNcAn23Bf+J35wm4wnR+r+ZGwyQ77oDKn
	TWZqh43G/PMz5t76MqrihukvV7xRl8vn5CDMKW15OHGzZ2qQ0gQd5f/aty1a
X-Google-Smtp-Source: AGHT+IHbCFFOdLNerbGeyj1ohy0a1+wtk1eKruqicxbRJhK26cUaFGUlNPl2UqApQ+U2qFaSaWVH6w==
X-Received: by 2002:a05:6a21:99a6:b0:1aa:68c4:3271 with SMTP id ve38-20020a056a2199a600b001aa68c43271mr3608647pzb.3.1714138165801;
        Fri, 26 Apr 2024 06:29:25 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:751f:9418:61f4:229e])
        by smtp.gmail.com with ESMTPSA id k124-20020a633d82000000b005f7d61ec8afsm12912141pga.91.2024.04.26.06.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:29:25 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] wireless: Fix typo descibing to describing
Date: Fri, 26 Apr 2024 21:29:11 +0800
Message-Id: <20240426132911.16255-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a typo in the comment description from "descibing" to
"describing".

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 include/uapi/linux/wireless.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
index 3c2ad5fae..5df03b595 100644
--- a/include/uapi/linux/wireless.h
+++ b/include/uapi/linux/wireless.h
@@ -28,7 +28,7 @@
  * change dynamically (while the driver is running) some parameters.
  *
  * The ioctl mechanimsm are copied from standard devices ioctl.
- * We have the list of command plus a structure descibing the
+ * We have the list of command plus a structure describing the
  * data exchanged...
  * Note that to add these ioctl, I was obliged to modify :
  *	# net/core/dev.c (two place + add include)
-- 
2.34.1


