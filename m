Return-Path: <linux-kernel+bounces-127294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD4A894956
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8351C23522
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFFCDF78;
	Tue,  2 Apr 2024 02:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="SeLqHJin";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L5ZU+66W"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE78D518;
	Tue,  2 Apr 2024 02:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024780; cv=none; b=YQpvhnx5l6y6mssMTPRV0J65SBS8q96jMLufuXKlvXTob76RYlxDqZpRIa4FKg4lnvQErlfLMsY/RlhuZAV+c4Z6qhrmdzUemKyA9Dx0yAYIaK+d7gq5W2P9dpg5hSeCYCwuIEDO4hWdc5dCC35icPyrkeAew5Be6IUkfvbHP0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024780; c=relaxed/simple;
	bh=yNMIU5BvcLrM2YSULEEBT+OZnGdDn9XlMsu794feDEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rSgc54yd6KDSy3ieobpPcJSQe/ML6yTI0fU4uBWFm69Cf0fRi2dyM0vYSqZtx6OFPm3iK3J58dkeKyaRk94ys//wdvtX/66TA1Revq+2/R2JOR8PJ/ZuBdFI34z6gNXV8isbxh4xSukcXneRumXTQc6yd7Od48C6SwB7iJOfIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=SeLqHJin; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L5ZU+66W; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 104291C000E7;
	Mon,  1 Apr 2024 22:26:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 01 Apr 2024 22:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1712024776; x=1712111176; bh=revw4RU6t4YZXMwj8jW6C
	AjJkLJLGU8mWvurq1rpA6I=; b=SeLqHJinupEJDXfkBn9O7Ea2hQda4q9swKhF0
	k9N/XqbWqb6Yg5aBK11I0e/yt4xc0pxxRyBLO9YghrcprWmTtp67ny1Hhr+vcrPr
	L5kqxjLf3YHYPk97xVCJbT5N6NyacbN7GK7UmFLH2K6EH+XxT8AmAiQJ9ilGChn1
	vLVN0f+RqeQR0zQx3dJmwzE/K77NmtWiXMRerfTYGn30SlywzfgP/T2Is2uWqiH/
	/irlboRYSZ77MMcAe7ql6yFRMCrnuZ87vIwZFXnK2LXrdV4JWUA06eBg9jVJezeG
	nulNAxPVVYPGOPQhSjQAgZHlRrswGLCFBhCMuTF1xgdy4F8Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712024776; x=1712111176; bh=revw4RU6t4YZXMwj8jW6CAjJkLJL
	GU8mWvurq1rpA6I=; b=L5ZU+66W47sJLNqlddhdvwORqPN3HOKTBxI8KbMCvQs0
	aNvRpbA/HOlQylqFHjwoUwEAtHyTVM9N7ERzxZV37iXj/OEjgZn4mbTLxKaEpvsi
	YdXi5sMOKlDBbCinwrtyF5o7qcrLx/jZU8eAUf3/BE4xIMRsQ+8eAx0xBsg+l8tP
	COhIiJrJf/+Gaohhr5B7R3fo7u3tR6j47HVPeIy3IA7F1KhtfP6wKzwvSs0lEh4m
	nT2EMbPUnqrisiwD90CZlVbLNoHFLcZLUiuBacTMkrOtPd5Zs+v+3LaG9p1gT/g+
	YV7SUSmxQvROFJjUiIwnyFlaDJDU/Klxkf1XUPbkDw==
X-ME-Sender: <xms:yGwLZq5tjGegbbLzJFaEU5VAgf9pXW3gjR9v2emHuXJ9wmePIpGgKw>
    <xme:yGwLZj4js4nsbhq1Kb1gYbjany21VWwlB7NZyGWXbSY3TR33weZPf6xrkYv5gv71L
    JxU5zl05X6ZDqc_oRs>
X-ME-Received: <xmr:yGwLZpcNeMtyH_pBV4tYzhxDxWzpTADOgEgYuvU3jOPZSVL65wz9qGhWXiRT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnheptdehkeeigeeggfelkeeufeefjeduvd
    ejveduvdehtdegveeftdeugeetvdeltdejnecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:yGwLZnLfajzKE0pyAH2GMYKoNHZH9-KqLjHOHHN_KPCKpw79WdjLyQ>
    <xmx:yGwLZuJTndNTeQ2ZfKgKcFvSuigWw0yc9jD3qHyeGYXtp9nORL1G0A>
    <xmx:yGwLZoxfmETCITzYBXit7b2lV8fisz8UkHEoO3yKG7klrZPuEI0yCA>
    <xmx:yGwLZiIIZgpivfUvXTKdXOX_thiZwqIqVqp417694cAg7ZLxoDM9Tw>
    <xmx:yGwLZm-ayAF7ELJSzbVJ9gab9VFniaKKCc5579w7m3pO3CnhHpNX6Xo7SGU>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 22:26:13 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/9] asus-wmi: add new features, clean up, fixes
Date: Tue,  2 Apr 2024 15:25:58 +1300
Message-ID: <20240402022607.34625-1-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My appologies for the rapid v2. I hadn't run checkpatch like I usually do and
when I did it showed some improvements.

This patch series touches quite a few things along with adding support for some
new features.

- Add support for mini-LED on 2024 ROG lpatops
- Add support for the gpu MUX WMI call on Vivobook laptops
- Add support for the POST boot sound on ROG laptops
- Add support for MCU power-save (ROG Ally only, saves more power on suspend)
- Store written values for ppt_* features
- Small formatting cleanup
- Small fixes to cleanup struct holes found with pahole

Obsoletes:
- https://lore.kernel.org/all/20240320011442.11608-1-luke@ljones.dev/
- https://lore.kernel.org/all/20240310065408.63703-1-luke@ljones.dev/
- https://lore.kernel.org/all/20240310061715.16531-1-luke@ljones.dev/
- https://lore.kernel.org/all/20240310055312.11293-1-luke@ljones.dev/
- https://lore.kernel.org/all/20240310233722.30884-1-luke@ljones.dev/

Changelog:
- V1
  - Mini-LED: use asus_wmi_get_devstate() and not asus_wmi_get_devstate_simple()
  - Fix dates in Documentation/ABI/testing/sysfs-platform-asus-wmi
  - Remove <name>_available bools and rely on devid for:
    - gpu_mux
    - mini_led
    - kbd_rgb (TUF RGB LED)
- V2
  - Fix formating on select if/else blocks shown by checkpatch.pl

Luke D. Jones (9):
  platform/x86: asus-wmi: add support for 2024 ROG Mini-LED
  platform/x86: asus-wmi: add support for Vivobook GPU MUX
  platform/x86: asus-wmi: add support variant of TUF RGB
  platform/x86: asus-wmi: support toggling POST sound
  platform/x86: asus-wmi: store a min default for ppt options
  platform/x86: asus-wmi: adjust formatting of ppt-<name>() functions
  platform/x86: asus-wmi: ROG Ally increase wait time, allow MCU
    powersave
  platform/x86: asus-wmi: Add support for MCU powersave
  platform/x86: asus-wmi: cleanup main struct to avoid some holes

 .../ABI/testing/sysfs-platform-asus-wmi       |  26 ++
 drivers/platform/x86/asus-wmi.c               | 393 ++++++++++++++----
 include/linux/platform_data/x86/asus-wmi.h    |   6 +
 3 files changed, 338 insertions(+), 87 deletions(-)

-- 
2.44.0


