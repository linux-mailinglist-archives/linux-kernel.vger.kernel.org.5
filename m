Return-Path: <linux-kernel+bounces-148145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C556D8A7E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C3E2841CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756F58662A;
	Wed, 17 Apr 2024 08:31:38 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640A3653;
	Wed, 17 Apr 2024 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342698; cv=none; b=Ht/IWuyEALGzLe9CvoCqNejcEqowDbYhxADXJyB+Y98bXILs3my79Fno1Xb5DqY542r1Xy7lbeH3bLh1vrjAsSUYLLyxWRkRkprm9jYKV6/ctQHHQXiQyuP3QxUh5nenwy0YdghRKQWlDl3TRY/FKgzOfiOgyuz7caK7xrJhpW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342698; c=relaxed/simple;
	bh=nmLAaYhyBUsFaBrhRWWZAQOdq6RHarRIgwAD5BZLtvY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Epah4MkXdUQnbvLuOLHeGEoQ/acugq1JKN43hJ/OIAYVTm6WZvtunmOlxYb+Tri406VnZK0LlrXxkHUe7pIcV1RD1y/VeBJ4UT95dTLmYaWxlB5jhkGR3rg9nxB/GhwV+ZowVANzV2rZGGvMiZLOfFjt3h6pxHqOInQGmm8NaZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id EA3282F2024D; Wed, 17 Apr 2024 08:31:26 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 2F67A2F20242;
	Wed, 17 Apr 2024 08:31:18 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: broonie@kernel.org,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	zhuning0077@gmail.com,
	u.kleine-koenig@pengutronix.de,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [PATCH ver.2 6.1.y 0/6] ASoC: codecs: es8326: fix support (backport from v6.6)
Date: Wed, 17 Apr 2024 11:31:10 +0300
Message-Id: <20240417083116.608610-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without these patches, all tested laptop models using the es8326 audio codec
have no sound from the speakers and headphones, and the headset microphone
does not work. Although the initialization of the sound card is successful.

--
ver.2:
drop a commit that does not affect the fix of functionality;
added an explanation that does not work on the current version of the kernel
without patches.
--

Patches have been successfully tested on the latest 6.1.86 kernel.

[PATCH 6.1.y 1/6] ASoC: codecs: ES8326: Add es8326_mute function
[PATCH 6.1.y 2/6] ASoC: codecs: ES8326: Change Hp_detect register names
[PATCH 6.1.y 3/6] ASoC: codecs: ES8326: Change Volatile Reg function
[PATCH 6.1.y 4/6] ASoC: codecs: ES8326: Fix power-up sequence
[PATCH 6.1.y 5/6] ASOC: codecs: ES8326: Add calibration support for
[PATCH 6.1.y 6/6] ASoC: codecs: ES8326: Update jact detection function


