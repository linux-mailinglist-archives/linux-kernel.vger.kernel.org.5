Return-Path: <linux-kernel+bounces-127249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DD28948C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E8F282CE4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AEFC2FD;
	Tue,  2 Apr 2024 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="HxqbgGZG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lY7ys7EC"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261378F55;
	Tue,  2 Apr 2024 01:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021707; cv=none; b=X0oGIHejEWTZQPXnNDh4PvlUdpR5pFvt5F5H3WWBPtyLYuJSrNVtvA7O4TKRt/SmNVklwUYaTDBQz9dWsExmHtvcHscn9B2g4oRiKf2+mHE4YZVvvVg2mvVuZF2B9ZSvsuEJZPP1YxLWetiwws18tDnS4czT7gJDcqfHLKsXhrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021707; c=relaxed/simple;
	bh=9BQEaRwtlziCRrSzQ8XnilTqjrDIVbHdGrwuUf5F6v8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzJjX9p4GZE6EOwfwE4th2/n4WsWrGQDMI78nZ4JYJvEPs4vh+KrCKgLkqYVVT2eno5Ibfvg+T99Ck1jL2Vbl7LLJc9ehs5n8WLrF/iBQX1flv7SYBz+4loXhBGuGCtdmMgqYSpwRC9YhfibBfZQg5nBrDzUENL6rdA9/9h5jGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=HxqbgGZG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lY7ys7EC; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id AF3171C000D9;
	Mon,  1 Apr 2024 21:35:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 01 Apr 2024 21:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1712021703; x=1712108103; bh=bmMyF7ct42nzKhAjWMlmI
	0spC9T18BPY/N16z5kWpus=; b=HxqbgGZG3GSnrvNy1r42XR/GDDKICCimjj6c/
	8jP8FsH5zifM2uhRapgxdInxgnmTrk+MALnGPfeweeNOjExZMhFfF/V+iGxSOiGR
	NNo3Kn8MPJcaCucuEF57Y5o/BZOz/IynOrjhQwnnP8khp/RJ/8rxR3z7M/LtfEZm
	7KKgvN7rLfoWbCrcgdPfHpR2PGvwwXDjpLJnOiwEfgufNzYtudH3zYqxh3j2Zikj
	W2hJVqM44KywSBx42GCtlAfUKjUFvr7lYH0FJ3PtdAntlUypHHdP+6tSly4Wk/w+
	RH04farswoPLsj1Jl0BxGuWEu+6nsqcILMFD2jR2Oqm5fkutw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712021703; x=1712108103; bh=bmMyF7ct42nzKhAjWMlmI0spC9T1
	8BPY/N16z5kWpus=; b=lY7ys7ECMuMwwAMbj35szwiRdhlMn5ZHb1ylbH6wgpCB
	74cNG/Dz4WTt046tCOqLGyeCJ/YYcNMzpZTepD3+28+IZ5kuo+VETcomZNwskM9J
	bMJQxCjQDmhu/H0roKxm/Na4JoTQqZmASDtcFGpofZI9FfzgKlPtk3iPit9xBEfB
	I08f4owdzBlRnvY7+yJHS9r1hlZIP5kPbZFycfKfTbrMJWM0ZrFpQMv/ZUkPHA4I
	FZd9jQUJitJt5LxW69U8hJPrikNy5SqiElFFW0dCyKy1xrbIKq/mtF+3q9wsYrPk
	CUpDqTgvlg6f5/bQJOpxGKMfOOT3Al3+2KZH2mKq/A==
X-ME-Sender: <xms:xmALZjqHtbDndt89jBl0AT14MlbgiOKEotXWuAu2fK3vAEdr0_5Sag>
    <xme:xmALZtrLNpJ3b73BtJzPdAaHKnMR2XxPQRESeDXpwJR7X7XP9Jw4fXuwXh0Vn9QGQ
    Dxpm3ducxTPAM7xOw0>
X-ME-Received: <xmr:xmALZgMA02zMk7_1HJsz5ABOksrkwL1YjmTQBeB-yGL0kFDwAoK275GdN_m_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnheptdehkeeigeeggfelkeeufeefjeduvd
    ejveduvdehtdegveeftdeugeetvdeltdejnecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:xmALZm4fgckvfydhtbCrrrCyxti6bzA5ldGYU6ywCEJEorr0PlBxGg>
    <xmx:xmALZi764mfINuY392KdM7lcayrFEp94yLUakATp3ykJKbZdzsLemg>
    <xmx:xmALZuh1uC9XeqlqdjhB-PvIg4ViQBoYqb1c6_HUDt6wbGhZv-AKxw>
    <xmx:xmALZk419l_2Wtwc34bqbIVyVhPu2fum1Hn0auOxx4WIYFVDtft5jA>
    <xmx:x2ALZvsu2_peoECK2AVo2PO7HLkZqYiZlJGCSwX4S9NADdxSV6haWnqD-IY>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 21:34:59 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v1 0/9] asus-wmi: add new features, clean up, fixes
Date: Tue,  2 Apr 2024 14:34:44 +1300
Message-ID: <20240402013453.18205-1-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
 drivers/platform/x86/asus-wmi.c               | 396 ++++++++++++++----
 include/linux/platform_data/x86/asus-wmi.h    |   6 +
 3 files changed, 341 insertions(+), 87 deletions(-)

-- 
2.44.0


