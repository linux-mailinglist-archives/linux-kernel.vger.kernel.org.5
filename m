Return-Path: <linux-kernel+bounces-124932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1D9891DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BB31F2CF6C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E026816C637;
	Fri, 29 Mar 2024 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUi+uZNN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228BC16C61E;
	Fri, 29 Mar 2024 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716448; cv=none; b=AqEdQoBqeVe8A8eukhqqHFhrAQa0WK+4DTFV3N7oR5dRGvcQLxNUrmpBE2BZrSH/KhuQWZKuL/1ngtjSJKXzZ1GRIBERtpWI3WMYGfdFASjcEvMdB2o13H3u/I4Ke+17a7/TUw3blnaQYQIb0Y3oMpdY9I8k0nxdtziTawFnGn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716448; c=relaxed/simple;
	bh=3vWNY+6Jbn1vQoAgM5CPPfg0OMJ8I8fB1jHQae5mi7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1H/NvzPNMkRDoxRuXCtrBYRPIn1bCxjbtoS9zqn35q15j8k0NhSh2WExypsDJ+gyYMEvoSgsRZChouGE+ZStAxg+lMcFUdzARtNaQyvuM9dYKvu7d4AJQU5pn7/JO29vNJzGuIz+661bC+M8/CILwWpHVey7BsblZcisekgFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUi+uZNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2C2C433F1;
	Fri, 29 Mar 2024 12:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716448;
	bh=3vWNY+6Jbn1vQoAgM5CPPfg0OMJ8I8fB1jHQae5mi7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jUi+uZNNGVoo/CScInd5lOpy4hpIcYk1xFqVQDOEQqF0rR9K+XutxwLfbtGpU25Lr
	 fdXi4nhW6QaLrb8vBy3mVFyMMHfXBbnv7+yiAgX254hEurtxctOF9UrsT6VcB5qGBD
	 /3vyCjuBRQbMChk4FJMJsEx958WWw3jf/Wb4vsz2rJ9jmxz14Bwy/apBaM/IlwgWZb
	 fFIuFK90Hyoaz8FT+Hxnj+EBGoK9egf6YIbajllxF5MBlJB7HgxJ8/2jltIwsUCPZC
	 ucJtaMKJoksF3tfT3lr0Y8eEK/YGJ6H2dx/Ez3fvh3bs/z+YOX6sYCqT8Y5dFdG82O
	 Vtt6cwm+6oEtg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 48/52] Input: allocate keycode for Display refresh rate toggle
Date: Fri, 29 Mar 2024 08:45:42 -0400
Message-ID: <20240329124605.3091273-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 7ad931a329706..1ce8a91349e9f 100644
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


