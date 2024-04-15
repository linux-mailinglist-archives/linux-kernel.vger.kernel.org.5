Return-Path: <linux-kernel+bounces-145100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 734B98A4F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D0A283FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59AA7442E;
	Mon, 15 Apr 2024 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYin6wo5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE259745C4;
	Mon, 15 Apr 2024 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185354; cv=none; b=n0Zo6HNeZEP9nTEKMSv6ESpQltOFYYL5ypFm+8F0tFYbPU0gIw3L+74s4ejILXxgR/XhYznffT/2Wuk2WOIiAM6hxW62GCzFytqpx5CaCbivQ6OHVI06KK+ywP/758rOw28pB51uJ2G7uaqbrXYtLgDRDLgSWLt3KCPVo0mQbYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185354; c=relaxed/simple;
	bh=ght8BJNX6A/j7rHJE4Dh6XP/NEcplQcXuxyvyVAkquU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WltVdhuJFPxo0K9hqjKbTC/AGuL0bHGFNDPogsNE9pDceCyCqwwFwxqhEXXdn70Zj5XB4R27eG47+D8DvunVX3TsmegEH8hAhwWbRxc93C+v4CGOihgA/XhaSvOiAOLA6XfuutqpAJpqkpt77bspCBfFVCLpRWR4Gld8KmWRRyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYin6wo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2492C4AF07;
	Mon, 15 Apr 2024 12:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185353;
	bh=ght8BJNX6A/j7rHJE4Dh6XP/NEcplQcXuxyvyVAkquU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYin6wo5RwN3uC0kDLQsC73txuDy4EMT/wIhVhTOOR1oLFkp9sgAB85pl0+aC5ZHY
	 MgZHHEF2HfFLcDcHqI+IZmK3R4VvPBl0aJQAcL0gYFqZ9UES4Z39oYDIwyOHjaNzwP
	 n/x2euL9UobdyAzvO2iYr42+c8OG6fNd8Yjim/KylR2rleqSeYT0Fu90euhCphYhBN
	 faBVHdGWBRvdbaOLZcPDxd1C+79M0Y38+MMEg7k3fxZE/RYSlBn61U3mo7AVVvLlI3
	 WTbGZ6Z4DbTFDxib987Hg+GJpKMZW1NXhfHHQQxHREL2fIrnsIR9tE/Vraew3ATEeC
	 GsKa7DRlPO39A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 04/15] OSS: dmasound/paula: Mark driver struct with __refdata to prevent section mismatch
Date: Mon, 15 Apr 2024 06:02:44 -0400
Message-ID: <20240415100311.3126785-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100311.3126785-1-sashal@kernel.org>
References: <20240415100311.3126785-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.6
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 755795cd3da053b0565085d9950c44d7b6cba5c4 ]

As described in the added code comment, a reference to .exit.text is ok
for drivers registered via module_platform_driver_probe(). Make this
explicit to prevent the following section mismatch warning

	WARNING: modpost: sound/oss/dmasound/dmasound_paula: section mismatch in reference: amiga_audio_driver+0x8 (section: .data) -> amiga_audio_remove (section: .exit.text)

that triggers on an allmodconfig W=1 build.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Message-ID: <c216a129aa88f3af5c56fe6612a472f7a882f048.1711748999.git.u.kleine-koenig@pengutronix.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/oss/dmasound/dmasound_paula.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/oss/dmasound/dmasound_paula.c b/sound/oss/dmasound/dmasound_paula.c
index 0ba8f0c4cd99a..3a593da09280d 100644
--- a/sound/oss/dmasound/dmasound_paula.c
+++ b/sound/oss/dmasound/dmasound_paula.c
@@ -725,7 +725,13 @@ static void __exit amiga_audio_remove(struct platform_device *pdev)
 	dmasound_deinit();
 }
 
-static struct platform_driver amiga_audio_driver = {
+/*
+ * amiga_audio_remove() lives in .exit.text. For drivers registered via
+ * module_platform_driver_probe() this is ok because they cannot get unbound at
+ * runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
+ */
+static struct platform_driver amiga_audio_driver __refdata = {
 	.remove_new = __exit_p(amiga_audio_remove),
 	.driver = {
 		.name	= "amiga-audio",
-- 
2.43.0


