Return-Path: <linux-kernel+bounces-124801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25988891CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4226287EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9553E148855;
	Fri, 29 Mar 2024 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg/Zb7r1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF57318E0C8;
	Fri, 29 Mar 2024 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716158; cv=none; b=Uo6jKNWn8bxf47in6OGzFaL4Hangyrnb5dChRdI/BWMrKVeQYgye7mhqV4u1axbZf5OIefx5x1uqeta7kMTfqXBgDtZc2N2+jydFrFa+y5vyuFguehfonWYpbts0D0rwuDqOQ7lcwCl1yvm48oz0oGiPcIMVjvQNKCxUaQzO0i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716158; c=relaxed/simple;
	bh=J4aV3rqyp50JKjX46TX7OZ3Uc8vJrNWVe8jCtSV47bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRuHNPytEJB0TH738DnFxVQJ/hLamnAgK7TTM/mKplhrPPHxJIGa/lmspFOz4S+mr6ctlFqCh7iXzUvOZ8KBWgXHnUkygtRTpluqkjtthTKxIBUhRigq+qv/3nzoEV+uoVjI8dwTKF0+Y1Misg+ejh9lubO6TnXV1xtGJNKwpUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg/Zb7r1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66EAC43394;
	Fri, 29 Mar 2024 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716158;
	bh=J4aV3rqyp50JKjX46TX7OZ3Uc8vJrNWVe8jCtSV47bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cg/Zb7r1iu3gy43kFFjynK0B5/yjTdYqM6tmzkoCB1miX50n2PUhH0vwKb2M1ViWh
	 O06k7cHEJlTocTin9BZ5GmkWZiLXhno5tacjUHfSelEhZzWZS+8bjr4ZzpFZBKfYqn
	 1NqIne1CKs6YqNRHyczlN5xRi28PXtdhbfvCgisr9Z+GTGRBBXMkafH/axtX3vAO4p
	 FIm+yaZR2IbzDa3y2jp0kcb1ailjMoIYPurYA9jRf2E6cQly9U/Rd2dpNa1kLHST1A
	 +x2TZL6KPtdUhyRZQk4X+9J4HllF6dJCVrbI52ekAUCLlteL7Q+4HGySEEhAaVwgPW
	 yVg4WNCeGdc/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 90/98] Input: allocate keycode for Display refresh rate toggle
Date: Fri, 29 Mar 2024 08:38:01 -0400
Message-ID: <20240329123919.3087149-90-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 022a520e31fc2..03edf2ccdf6c8 100644
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


