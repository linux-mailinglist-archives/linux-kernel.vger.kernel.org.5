Return-Path: <linux-kernel+bounces-166931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3268BA233
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3D51C21F02
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B5A181BAA;
	Thu,  2 May 2024 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhnfiERs"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1479A23A9;
	Thu,  2 May 2024 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685152; cv=none; b=SUECnhf5+p9xLm97xHvgDoshlRoLPeELfRjpDMLXqapNJC0ahTWPhSe1L/47Ok+xyQWg4Me+GCdMorbqTUQoV8JYgkCh9y0OedRpluR58boUs5pOzF5fdRMa6pgypYapMBJ2imt+CQiHsc2FHDNtNntGWuWMakhb4foI3zJua2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685152; c=relaxed/simple;
	bh=vs8+/rCFdWBPdEHiqoIF1165GKGKLEOKQbXIn1k92aQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jmfIDOITo2TdavW/+DuZXqKXkkiMEX9KgbqwXG9kRTw6bjruWPJ48cnntTC37f5vP8USW12j4DwKK4+xsNzgZIM0/1HB6s9o2E5Fe94ftAux4OX4nzi5KQ2c0O/UQbTtvTgbHFi3IJY6LHg4H/S+1yz08aITrSVioYB695R6A1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhnfiERs; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43ad398f164so25336481cf.2;
        Thu, 02 May 2024 14:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714685150; x=1715289950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ev0Z8U58j2TfGxi/KHWXdws++QJEPMK8/ysXmvnkKHA=;
        b=YhnfiERsTrz5uGmiZYcFRwZUusJrfvUlz/vWgZG28mcEqkOiTqz1yVwZod7NsB5AgP
         muJYjgUtvnPM0SowTDLNUoUJJuExyljG2vxTqmXNpaTbgFsB4XDOYM+n3yrvrenmdr33
         CYp+caQrfi4JslsMAgBhujo27DQZqIzLScTrbyoZcbbgzXANRP6NdXHXulQmc5XqeR2/
         Wu29dAZL1KiNIT3NmH/YPKy9EZFPpwYjTlKjBBsuT57J7VoEGtsRVukmxUqT0tO4xPvm
         iIqCcYFMBvJ2/BJ9644bmgmwTFzA+IKlSjWvo8+N1XOGRwDrDqVM/mGYoHmLv90eAuZ/
         P1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685150; x=1715289950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ev0Z8U58j2TfGxi/KHWXdws++QJEPMK8/ysXmvnkKHA=;
        b=vQV6Ddm28YsgzRSb65T2sYVNC42+d6wYvHKUn3Yr6Sq4J89AGv5dp44rdc2O0P8sUE
         /V+WbXd64u0fDbDFjzmPI4P/sGpNnLfEinH8WhtXKPqQb14u9fcyCzIqjnvjJZRqsA+j
         AgT1xJac2AuyQQw3nUiAcclM9U7YLv1tgSxkEcEnGMhu6kgNE4fz10VFzan214htIvmx
         FXNTdVL3OEbS7vOlV7arqyg2X0BwVw7LS6rKslbjTLAo/WikR3KJWHIRWj7zpgsLt2Ue
         Si5TFiEZbC6PzKZIMwUiYuIlre8QodQHsJH+hGDOoy4y/kK5/y8pdk+ipgsjAZpSEYfB
         ggew==
X-Forwarded-Encrypted: i=1; AJvYcCWYLQCEJK0zpDUDnd8C49VhKqZarVCxn+0kA9LFD3BtHYj0npl1/6nrUVrfqrTQFJMI5haUAUc2aygEPW4f77KGpl+us8hNpMUFYvqjHH6ZkuwuKOW8/IThQvfct4PCAUxsvKOFpK04
X-Gm-Message-State: AOJu0Yw8czvQDx3MdarsWBAg6nOuToS9WuDjDKmFZ3vgteZrSWTPK9EK
	06b4eXkt15kbXkmVp2giInD1RJC6yRpLhBVg+SK5HwX714ApmbGnvvsmjbDc
X-Google-Smtp-Source: AGHT+IGJnD1beWSb3EMwThlT8Wy3fA5zyYCPB+8wxnL2kFGQwND4BiswoBMO5jHL0rHCgryOnSNSvQ==
X-Received: by 2002:ac8:5911:0:b0:43a:cbe9:2e32 with SMTP id 17-20020ac85911000000b0043acbe92e32mr758771qty.55.1714685149744;
        Thu, 02 May 2024 14:25:49 -0700 (PDT)
Received: from dennis-US-Desktop-Codex-R.. (d24-150-189-55.home.cgocable.net. [24.150.189.55])
        by smtp.gmail.com with ESMTPSA id cd14-20020a05622a418e00b0043791f7d831sm829205qtb.63.2024.05.02.14.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:25:49 -0700 (PDT)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: chris@chrisdown.name,
	corbet@lwn.net
Cc: Dennis Lam <dennis.lamerice@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs:core-api: fixed typos and grammar in printk-index page
Date: Thu,  2 May 2024 17:25:22 -0400
Message-Id: <20240502212522.4263-1-dennis.lamerice@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <dennis.lamerice@gmail.com>
References: <dennis.lamerice@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
---
 Documentation/core-api/printk-index.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/printk-index.rst b/Documentation/core-api/printk-index.rst
index 3062f37d119b..1979c5dd32fe 100644
--- a/Documentation/core-api/printk-index.rst
+++ b/Documentation/core-api/printk-index.rst
@@ -4,7 +4,7 @@
 Printk Index
 ============
 
-There are many ways how to monitor the state of the system. One important
+There are many ways to monitor the state of the system. One important
 source of information is the system log. It provides a lot of information,
 including more or less important warnings and error messages.
 
@@ -101,7 +101,7 @@ their own wrappers adding __printk_index_emit().
 
 Only few subsystem specific wrappers have been updated so far,
 for example, dev_printk(). As a result, the printk formats from
-some subsystes can be missing in the printk index.
+some subsystems can be missing in the printk index.
 
 
 Subsystem specific prefix
-- 
2.34.1


