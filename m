Return-Path: <linux-kernel+bounces-125024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C93E891EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D891F2BF14
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ABC1BA358;
	Fri, 29 Mar 2024 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpWQlzEo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DE71BA341;
	Fri, 29 Mar 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716648; cv=none; b=HDU0B5UebbvHjG1XPdimHVyjdi0YzmsGW9dqqtD0DlTYcL6z8/ygqQHoVEcab80yg24Lp8I5oqg+k+6Bdc0jaWCXlumA9oYQIgfaPZo4YujoMi0dOUTYUQsR7olY4+LGZbFTunTQm5vRJdw4seYttRUqD53v2fH4meIOOYu3898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716648; c=relaxed/simple;
	bh=0kaDuUtDLYltzRqkbMSzpPVgYxR938oVhqlSQvnc6b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrwgcdeEeQ+Sz0HxSIRUeVepwjrdAzZRtLi3373TxqixlKasKvlJ+gEIFfRbTIH1WLgDG8b/pg4bZGV4fiZLozp490D6Y1CpXTh0ClKi3+DfJOG9LxPnZqYd/VdWNQmG2ZQrf5XqZnlDLNRnJEB4oZIfRqqegUGnfrMLbGwcrdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpWQlzEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A68C433F1;
	Fri, 29 Mar 2024 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716648;
	bh=0kaDuUtDLYltzRqkbMSzpPVgYxR938oVhqlSQvnc6b0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EpWQlzEoAoquOaQDAC6XB8dV0bATMRiKEa4OcRNVZMaj+lzF05CU6s5h9XnVlcy1B
	 t4w8qv1A2LEgPveQ25d+13mn6S/DVH6Ozp91kIs9d+IEoSxP8ZqINCNyePmMOJKsJL
	 hA2j/slg7VrWrpihxEnVrGf71P+awOnRxmB3VsJV+cLdZx0tHvEwGksKzAAwj6LRf9
	 hJFV4X0hkEWRtywrB7N5FoEkIMXXci4VFNgAlrWC+poFXyGyo9hIl0DpKU8u65ENQs
	 ONwr8alE/fJnu7kWknU1iZoMi65EF/K+JU/1iP6PKVzOwSlOzKEOSKMZLpVc74w0WZ
	 pJxvBzJyFpoaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 22/23] Input: allocate keycode for Display refresh rate toggle
Date: Fri, 29 Mar 2024 08:49:55 -0400
Message-ID: <20240329125009.3093845-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125009.3093845-1-sashal@kernel.org>
References: <20240329125009.3093845-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index 7f0ae1f411e3a..bf6c2f0b26fdc 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -598,6 +598,7 @@
 
 #define KEY_ALS_TOGGLE		0x230	/* Ambient light sensor */
 #define KEY_ROTATE_LOCK_TOGGLE	0x231	/* Display rotation lock */
+#define KEY_REFRESH_RATE_TOGGLE	0x232	/* Display refresh rate toggle */
 
 #define KEY_BUTTONCONFIG		0x240	/* AL Button Configuration */
 #define KEY_TASKMANAGER		0x241	/* AL Task/Project Manager */
-- 
2.43.0


