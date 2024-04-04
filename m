Return-Path: <linux-kernel+bounces-130764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9A3897CDC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57BE1F219A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E76802;
	Thu,  4 Apr 2024 00:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="qeAnu6Cc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qf48OQxL"
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A661C36;
	Thu,  4 Apr 2024 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189827; cv=none; b=qMmhmkdxfWd75UdYx7akr+vLoWVNeRDovx37vA/M+ZdM2CxiS3nyyLL7Hkz2BLdJUQwb4E8kPYUTjx/lZDTAVKZAy9S3AG3+hEKSxGbcHRukVFXJDdF2piuXpNnL/gNuDiophXORqebL1MlUdSfAXZ9gykrc5a9yyBc2Snpqoa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189827; c=relaxed/simple;
	bh=1NV3k0jBNoLNvWDnYUr5wMabBSYCJhk5lMMYMr/hPts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QFtKN29Qy+/hF5hzmn3lm1HaxQ0vrClv0aCE5K+fi6DepN0Q9FRJb38xJVk1XEaD3Yq6S2oYxvQLDsDsgPYzMeiOhEI0LvEc21jqVG9hJc1sg9T7El+K0BCbtOCfgb4YqLao5w5DW9LQFInwsv7+oAyo09mrpV4fmQygd3baCc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=qeAnu6Cc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qf48OQxL; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 581FC1C00101;
	Wed,  3 Apr 2024 20:17:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 03 Apr 2024 20:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1712189822; x=1712276222; bh=9p
	ePwZQdFiMLHLTOsr0Ukt/rDRUDL+dja2g60K6h1GI=; b=qeAnu6CcG8gNDDoQ5s
	ble7ZmU1bOvCUUYCtE0nrWxw6crXpR0SQdVYKsy1jsr9cKa0meik+W/LEUl6u1O/
	Fu4o08xm4bacXGx2agnKNdT6GCA+hYR+797NOp5osUEvrE+tuFaFSrcubU1+STir
	fWtLMN9zEY+zKbd6MVDjAN0QPQZ89E2K0RwjavotiVpQmIRqD4+a2dNgMScBKgRO
	/eGulP+d8c0itODimqA54+hSUJpaLJF5ag0NU9qA1SG5NDIcdkSOk1aN2bMFTDIG
	r25V+nxjT3lQoFgnFOmQFtCRht34/wMcSRdaRO7VBax6qXNPcIfOwbsG3wWkO2uk
	S7bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1712189822; x=1712276222; bh=9pePwZQdFiMLH
	LTOsr0Ukt/rDRUDL+dja2g60K6h1GI=; b=Qf48OQxLA1wFqYjbSZISF8wsO1Jd3
	oURcaAvJvvjNJePiHZePju6+EbeA4YVjMl52QncF3TiiKU29IkyYCPAT673BRcZT
	OaPWg8Ak6kdc2w1D8UD/u/sCFN0yg4wy40KW6dgHXIlaYIV1PcDUeGmjLCqHy+mh
	F6dilQTUXLPKnHWlaP0tyMgjT/54QCTam2cm81snAiEGGHrT/nqa2Pcnm+2nH5JY
	eMJm7w/q78ItLS+IGSV0BdvH14uzIW+Qm0GBLbHjFhHMKHx9h6T6knRCJy9ul1hi
	c74TGRPMDCKgMN42fLuhHrWboxZ9SvYL5gOJjU0Mw6XrHfeIQ3T/QF9ZQ==
X-ME-Sender: <xms:fvENZvoHwGG9BZChz5nk_m_KQ2wzc9gP41yjl4e_J4OJ0YSLOFzm2A>
    <xme:fvENZpodXJRkgcO4Vs1mM63iIU4nKWP3PFY14ccDpN95yKfyaOYfDAonh87ZQ4dvv
    _GqX9-0SwTC5tPaZdE>
X-ME-Received: <xmr:fvENZsNOKbuHzgXfLYH_5CExUO0cdr8urpJ5ogi5NbLcD277LVMalDuEr3b8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
    dtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeejtdfhheffkefhteekleduteegud
    fgleekheejuedvueefvdeltdehuefgveekkeenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplh
    hukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:fvENZi4nAchTMhaxh_SxQKYeK9GQPowYmvgh2FTOvIeE0FijGwdaJw>
    <xmx:fvENZu7GXHC_eekkR7hzJw5cnVXgB1cUVwUBmZCFoIKU2zK1a0Ufew>
    <xmx:fvENZqgjiXpXdZiXAgomecBrNjKCpdewzexOUKtR58XjurpmvfmMcg>
    <xmx:fvENZg6w6mOE9WqJ8mR3J2m73RZGTh3j7HNux-T9dg59BsnDwYxHQg>
    <xmx:fvENZrtfh1r2sqTLgoaWGyzUzRFl19cnA5FUhDN6GwLW-RyslvpMDEzt>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 20:16:59 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v4 0/9] asus-wmi: add new features, clean up, fixes
Date: Thu,  4 Apr 2024 13:16:43 +1300
Message-ID: <20240404001652.86207-1-luke@ljones.dev>
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
- V4
  - mini-led patch:
    - Minor formatting cleanup

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
 drivers/platform/x86/asus-wmi.c               | 409 ++++++++++++++----
 include/linux/platform_data/x86/asus-wmi.h    |   6 +
 3 files changed, 355 insertions(+), 86 deletions(-)

-- 
2.44.0


