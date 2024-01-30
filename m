Return-Path: <linux-kernel+bounces-44291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D80841FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54741F23C34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360C960885;
	Tue, 30 Jan 2024 09:47:27 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E27605B1;
	Tue, 30 Jan 2024 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608046; cv=none; b=nrRVqW/0IsUUWuc0oTenf5P0DK4IEplPD8NU3QzbdLSQfumn74p5LAuQcPjND6POq0UUmxJOCxQDQksgVITRMF1c0pyB/o03i8pAzCdNURFLi7FDt02vhs61ZSPP23eHQOy49s2fzbFSuTfJtFbj34TKFXyMuNIZzaEuRc545fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608046; c=relaxed/simple;
	bh=7V3O32k5q5iF15oXFkEescXZTWUBuU5h8LLfuVaOQ+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z/EJx1VWY0CuPr72QDFut+dqfdQ9UQuN2Q7Zl/GMcvKqjNvKo13NKxWFA8dNgcjyLiUWg9sV44ilaqZ8Xu0UiXsgYRtbUkHlTSFJDWmzVgxr8Z1nJs+d/kxFu8PzyWJcA8bPYAGX6GHQc9uJq7Nt7fuwOJd/S5JsClT4XBm6t44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id C47FE2F2024A; Tue, 30 Jan 2024 09:47:16 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 9B5882F20241;
	Tue, 30 Jan 2024 09:47:14 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	u.kleine-koenig@pengutronix.de,
	a.firago@yadro.com,
	sashal@kernel.org,
	zhuning0077@gmail.com,
	tiwai@suse.com,
	perex@perex.cz,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y 0/7] ASoC: codecs: es8326: fix support
Date: Tue, 30 Jan 2024 12:47:01 +0300
Message-Id: <20240130094708.290485-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches were backported from v6.6 upstream and
are intended for 6.1.y stable kernel.

Patches have been successfully tested on the latest 6.1.75 kernel.

[PATCH 6.1.y 1/7] ASoC: codecs: es8326: Convert to i2c's .probe_new()
[PATCH 6.1.y 2/7] ASoC: codecs: ES8326: Add es8326_mute function
[PATCH 6.1.y 3/7] ASoC: codecs: ES8326: Change Hp_detect register names
[PATCH 6.1.y 4/7] ASoC: codecs: ES8326: Change Volatile Reg function
[PATCH 6.1.y 5/7] ASoC: codecs: ES8326: Fix power-up sequence
[PATCH 6.1.y 6/7] ASOC: codecs: ES8326: Add calibration support for
[PATCH 6.1.y 7/7] ASoC: codecs: ES8326: Update jact detection function


