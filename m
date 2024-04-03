Return-Path: <linux-kernel+bounces-128873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 486BF89615F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F287B288743
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665CE211C;
	Wed,  3 Apr 2024 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="uBSGR3H6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZG0oODTV"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA54D4C8B;
	Wed,  3 Apr 2024 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104170; cv=none; b=AoufDK8g8GJPf/ahYn8ZzP+IuOsWkt8s6j9ddZQbUtjtdxbiPIM0iAVODzhtB+rgA5re4XiIVos8wdOCHt3J6cRo6ISjQt3sEskIVQSeCep7BFPvMVZ+lFFww9tFisXGpoui5B6m/u8mWQb2UeV7GnSGAI13OPGaWyRTkH2PVhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104170; c=relaxed/simple;
	bh=necNBAiT4uEBb53LhnrSQkwDeLiPSBjZDkJk25KLwCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L3td2HkBy87za+7I/6dIT+/QuosewL5FVBbAEd9wuIV+UgdhZZm+OG9zJgwEa0T8Nn6RLM6cYqXYKYQllHOf3GEGkwyBfAGkQLhGipMxNwyny8zTv6PKZt1Dn0jWw2FHaulHOiVw5nuc6T7loIfniR3ZZ+8vfi8L2zlNaK4IUJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=uBSGR3H6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZG0oODTV; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B3A89114010F;
	Tue,  2 Apr 2024 20:29:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 Apr 2024 20:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1712104167; x=1712190567; bh=E8
	6ynlUqqzdKHWpmhjpcRgll2uxiDCjB/PLuV4iy0rk=; b=uBSGR3H6AmElB2ukVE
	31LWBMEoqqzLxW4iiMPz+G4LYqaDy5YBRvjOs1BP4xVkxaRO6V3zOhHhaSGemjDW
	wsQfSxy2YRwAMLufodOaK44wsdLmVIkZMs3zkAkFzKsCpgU8t33P2zb/Qt26xYoy
	akH/HgLsUQYwYdiZIgvOnr27GCJ4KZJzt3NCmzrFRt3J9coNdSuAiABAAnsM14jN
	JVzPFlQ7N3iilZKxPkWYf9ZOpZRwuZF/FqrJbLSSre0nN9qzXBV+0AU1QuxtHpHN
	9wixpDWdksa42sY8kaMUSd5nnGcRXqktUP+qoUisBXcMHB11MSGycKqUnsnzeo/r
	mVlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1712104167; x=1712190567; bh=E86ynlUqqzdKH
	WpmhjpcRgll2uxiDCjB/PLuV4iy0rk=; b=ZG0oODTVBJiQ9FYGzynnLK6JHKlBc
	cyd8jcImeAaQDk0Mgk3hYdF2wfQn+cB6bZaNCoXjiwHNUrkgLw69ezK6Z+DVtsSo
	8CtohfW+0HoOTu/BoXKpijvceCacQrZJjpNocSY3Mc9BCt6kbDRTL0X5ThhCyzsC
	C7hRausfC89HCdzmvODDgbDp4HVEqCBTfUQjZBjIqW+MUSYMyjT5IgPD257dvrKq
	DK/tO+OPqPK6RPyyQXjlWiF+MFlIolPJKqa3FPdq9zmi6vJ1zRtDBHiqooZCCbI+
	tydJm0x5QEN7ZiEApfan0t5f0jW6E4FnAhSjDFRSbd09/vrnwm4l/NPgw==
X-ME-Sender: <xms:56IMZhJnlJGrsbakRbqOXxMwbyuJDN6L8PNuIDtmn3_Jtyclpe5ljA>
    <xme:56IMZtIqWDnlDQGSsrJepvc3vttYipdEGQYp1S5Ts85QJBHyxuDyHXrI6DIc_irqR
    RQ_mpM-YxUTqig9lfE>
X-ME-Received: <xmr:56IMZps_-y0aJmUFturm9l-NteVsp493BY55sJf5hjgcVTjFqKhkAb0j9pfm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
    dtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeejtdfhheffkefhteekleduteegud
    fgleekheejuedvueefvdeltdehuefgveekkeenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplh
    hukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:56IMZibD5qAJBpgDvP8S5C1TvDuTTUZB1ts5yKZ9h1ZoYCzIRx9rzw>
    <xmx:56IMZob_4Oy-I5Ja9YLTyhSRSuGGX6gKmdx1NTdQWXSzTHklTkvMAA>
    <xmx:56IMZmDMzUUDUhrsOemiJhY-x5MyJr89RRUUaP41hRIZajp1dJK8XA>
    <xmx:56IMZmbWW7ka9D9kQizRefGe0edHdwwUi9-eQpLrm3ScxiI648tkYg>
    <xmx:56IMZtO0ET_qrm2uR9haFsc4PZUMNCpaRazooicz2BUyIVd6tVyhsXug>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 20:29:25 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 0/9] asus-wmi: add new features, clean up, fixes
Date: Wed,  3 Apr 2024 13:29:08 +1300
Message-ID: <20240403002917.2870959-1-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
- V3
  - mini-led patch:
    - Add error handling
    - Add defines inplace of "magic" numbers
    - Remove outdated comment
    - Clarify existing comments
  - post-sound patch:
    - Add missing newline
  - min-default-ppt patch
    Use `%u` instead of `%d` in sysfs_emit()

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
 drivers/platform/x86/asus-wmi.c               | 407 ++++++++++++++----
 include/linux/platform_data/x86/asus-wmi.h    |   6 +
 3 files changed, 353 insertions(+), 86 deletions(-)

-- 
2.44.0


