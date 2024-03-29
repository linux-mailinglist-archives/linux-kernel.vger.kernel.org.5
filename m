Return-Path: <linux-kernel+bounces-124878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A32E891D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CE12861FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DC214A631;
	Fri, 29 Mar 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueQydK58"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E961A204033;
	Fri, 29 Mar 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716332; cv=none; b=BKBdbz50lmI+vYR/ahXg5KuDl+OLFL7CjXWb1gJIHn1k5D6dAN/g+ActTXptyRrpHbyVzerkSvZuBELPLiOsEo5znaIL/uu/6q3gHEAm86r3u5h1RFVIs4UNvSe7YLmuflRvblqaIUhZYVAFM0siUtuHOjnt354TIfBHznZXLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716332; c=relaxed/simple;
	bh=J4aV3rqyp50JKjX46TX7OZ3Uc8vJrNWVe8jCtSV47bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRU9mOrBMRkcHdGL2RvCrNJqlUEzKxB81cTnc+yb+HA3FU5FXAuqZamjPa1hSbHQ0A3+zBn1R/+bm6wCw3MYiracDAUBnC5CZve9txPPmyCzjpwpxhqviOl/YXE8XWKHrtva2GMvSt8YxEetTR5UUjx3+BLeJ4oKcVb88NAYkmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueQydK58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3147C43394;
	Fri, 29 Mar 2024 12:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716331;
	bh=J4aV3rqyp50JKjX46TX7OZ3Uc8vJrNWVe8jCtSV47bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ueQydK58M9ZAhvDDLErpxtbAa7MQpZ9UvLET66qTXZvCr4fBs2WJZmCglrcCjMWQP
	 c83uA8WJhyPF7+cLd4tmfIgJ9kawSG/k7WexRCewD4360/LK76rRjfs8X75nh0L0sz
	 hTZngmSS+6t0OtGOspwafNY1KUNIYj+v5/uqhVZ5N/AltfE903y8W4ewS3lecfKYmL
	 vhSfdLwzZHPcWnmqwL7f9V4cId8q+4zEMPF+zyiAY5+c85OqruGe5PS93V0XH3J78q
	 X8pDwGBZKTl6fkmNYSKWPD5UlIs3dxsN4YypiA0MD0UC8zGGG/tCmN654RkPAQleHT
	 rdr8qqpJWagng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 69/75] Input: allocate keycode for Display refresh rate toggle
Date: Fri, 29 Mar 2024 08:42:50 -0400
Message-ID: <20240329124330.3089520-69-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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


