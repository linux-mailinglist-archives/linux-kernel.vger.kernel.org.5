Return-Path: <linux-kernel+bounces-18002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 387568256D0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA341F233A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EAF2E647;
	Fri,  5 Jan 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="N1YSEGRn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zN0gs1bK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F02E63B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 9C2BB5C0256;
	Fri,  5 Jan 2024 10:39:04 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 05 Jan 2024 10:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1704469144; x=1704555544; bh=ohuGZOw33eIoSDD39Uu8Pt6HEQ4Oo1Jz
	5tZEjl1+7/A=; b=N1YSEGRnqlQeTMW9pPGpQQ3MSXLwr0e59mbzLW1TjqBrBc44
	AuT8hM/gd2Kw3cquQ+pWI3iV714C251bnpDe+YIDpa7b4yZqHeliM/5p1h52NJLF
	vd5k4SKRqvnMqQJD4kbZMQixHciMabO5wrs4cRxw0RmoDPomoNJzd67aYLtOS+mr
	a7TdbMj+qwt10eulcA44OwY5zKfB4iQHCfGv/U6Ub2PCNO7yv5PXjd0wyvr8Ovzv
	XD2QY8BzfuFR++nCyz0bbJXI4dA6FDVMOikTfOD//olMmU9zsQgjPo+x5PJYAsQf
	6yxOsooamseo/mcEkdMuSGhA9ooazFN56CRs6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1704469144; x=1704555544; bh=ohuGZOw33eIoSDD39Uu8Pt6HEQ4Oo1Jz5tZ
	Ejl1+7/A=; b=zN0gs1bKwGbCVoRW6N4qbLvuT30yVrxXCdIpo5vapZ2Xx4gnc0R
	wQWdI7r4I0JTWrTGomMuCnyd+kayM9RhHDaOZHftIJyoJqIL5pIZW/0XXh1ECAke
	Py641J8Sq+wBB9Bz6kOYzjA7iScNSW65dyq7UiPAqrmFKnKDxjYslWUYUXIAKwxi
	KQ/O9oH0rZBiF0eBP7vD57h9s1qrxi2Z7zhCMIKa9ybcYf3tyD6BWocqWQq3dB2D
	D+jSyirb0794HSmZfRfP0qN/+8kpkPiFHWyH/FW+F5/eQx+rf94JIcI5EYwNeOiN
	D1VljJXh32DtbxebOcVyFpiSYVq7B0+Vwmg==
X-ME-Sender: <xms:lyKYZZSxdANR_w6DtLfhxSwa_DIbT6oHoBzJLrsetOgnovBQiUj__w>
    <xme:lyKYZSywoKTgFcS28kyX5J28C_DuSYzwBIMxd2QE_LCE8Y5IcJRELQ1342Cu4V1Xx
    S4TcZ1YJoaOtIJd-hs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegledgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeefuefhkeejvedtvddtleeltddttdejgedvhfdtuddvhfeukeduiefhjeetgfei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:lyKYZe3iov5xyOUYAn-uCgwSvbsrw2kcLz9ZaDceeERdMFHRaiShhA>
    <xmx:lyKYZRD5msD1VQRkaGNpzz7zfvTbz0yzD7-h61Tu6dypbQaqr_BnAA>
    <xmx:lyKYZSgwxPSBkWu86cBe-xoQyM-yGGq6HZa3hO1NbLGDYv3GJEWxOw>
    <xmx:mCKYZTsE6jGn_qQpUR5mDFVvmUx2v-a8RF3FBwjCtCtW1WU5035qVw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C4684B6008D; Fri,  5 Jan 2024 10:39:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ade6f246-910d-4d9a-aab4-1ae21a18da00@app.fastmail.com>
Date: Fri, 05 Jan 2024 16:38:43 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, "Stefan Wahren" <wahrenst@gmx.net>,
 "Chen-Yu Tsai" <wens@csie.org>
Subject: [GIT PULL] ARM: SoC fixes for 6.7, part 3
Content-Type: text/plain

The following changes since commit 861deac3b092f37b2c5e6871732f3e11486f7082:

  Linux 6.7-rc7 (2023-12-23 16:25:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.7-3a

for you to fetch changes up to 643fe70e7bcdcc9e2d96952f7fc2bab56385cce5:

  ARM: sun9i: smp: fix return code check of of_property_match_string (2024-01-02 16:45:16 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 6.7, part 3

These are two correctness fixes for handing DT input in the Allwinner
(sunxi) SMP startup code.

----------------------------------------------------------------
Stefan Wahren (2):
      ARM: sun9i: smp: Fix array-index-out-of-bounds read in sunxi_mc_smp_init
      ARM: sun9i: smp: fix return code check of of_property_match_string

 arch/arm/mach-sunxi/mc_smp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

