Return-Path: <linux-kernel+bounces-124999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F61E891EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0F028891F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16E81B31A7;
	Fri, 29 Mar 2024 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMlscdCO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CD2152505;
	Fri, 29 Mar 2024 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716591; cv=none; b=C/zCyQ01TGT+4EGUyiZzI3ZCPWRbSEi+Qn9eEa3AMjXv8zJ4tX3+7wqEZQnAXXpYOgWiE+0UWzx4XolhsMUDVzUX1iusP3gVy8aY0yqZRHPie9nclNx8Ih4uUKZ8G5PIOwGbxMKkWoaHYqH17JQUcCoDlIAUh3npGxtnqTlnO2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716591; c=relaxed/simple;
	bh=ewjU2HkeKat/OJ2QdByR91WQA7bTQED3R5Erhj5bqsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCw6fqb26Oe/51j5o6UaH7/1pWN7GlQMxQLpO59mLe1dQM0m4cxG+/tJz4XLbd1/L6jdKau6j0bLZBEYCWadnQWqbEkSpoxSdyGwgvxr7FgOJnVFAx8TiYY8rcmCLcI0LL0GBYyXu3JIEJ/bVL9obuo3HvnBf0p3RHyHIukECoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMlscdCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A932C433C7;
	Fri, 29 Mar 2024 12:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716590;
	bh=ewjU2HkeKat/OJ2QdByR91WQA7bTQED3R5Erhj5bqsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KMlscdCOQgIkQW7maXN2noWs2PF8rTW4aw2NbNKgpd+/Q0QfJDUuLzDbtwjGbM9uH
	 z1ZFLI9M+dcbia58SF0WGleJ91NwfS/h1AF5m2uPU96+9ictEAQwoqMDr46unRSB+w
	 hfHbBVxEijzw6YacEdkp7UCKx9sQfHn1f/t3owt30swNtHUZFCUTk4lJLSHuUt2WH9
	 3jbFbyoruh73t2O4YP6qZcyVISupr2w7f5ztIoSC1Gk6DJzGOw3ZMnj+D1gzMk+Gma
	 o18daBipY+N15ZjsrDLWS+14tsJNPnWwGZ21z2ldm5DDQfh+FGaaeGwRhJyzD6H+Sz
	 cfhJ9jJNwobHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 28/31] Input: allocate keycode for Display refresh rate toggle
Date: Fri, 29 Mar 2024 08:48:45 -0400
Message-ID: <20240329124903.3093161-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
Content-Transfer-Encoding: 8bit

From: Gergo Koteles <soyer@irl.hu>

[ Upstream commit cfeb98b95fff25c442f78a6f616c627bc48a26b7 ]

Newer Lenovo Yogas and Legions with 60Hz/90Hz displays send a wmi event
when Fn + R is pressed. This is intended for use to switch between the
two refresh rates.

Allocate a new KEY_REFRESH_RATE_TOGGLE keycode for it.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/15a5d08c84cf4d7b820de34ebbcf8ae2502fb3ca.1710065750.git.soyer@irl.hu
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/input-event-codes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 7989d9483ea75..bed20a89c14c1 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -602,6 +602,7 @@
 
 #define KEY_ALS_TOGGLE		0x230	/* Ambient light sensor */
 #define KEY_ROTATE_LOCK_TOGGLE	0x231	/* Display rotation lock */
+#define KEY_REFRESH_RATE_TOGGLE	0x232	/* Display refresh rate toggle */
 
 #define KEY_BUTTONCONFIG		0x240	/* AL Button Configuration */
 #define KEY_TASKMANAGER		0x241	/* AL Task/Project Manager */
-- 
2.43.0


