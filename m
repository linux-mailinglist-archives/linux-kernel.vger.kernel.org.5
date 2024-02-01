Return-Path: <linux-kernel+bounces-48101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4778384573E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4FD1C25F65
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EA715DBB4;
	Thu,  1 Feb 2024 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="RC/Qzu3e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iXRbkXU6"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B544D9E9
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789974; cv=none; b=eby1FtG1httBZer6OMM1xGGH45IjwwPRgF9dXTvVugmbZs5v6KzBEs5T3HVcN4MoQT62tvOK33U46BrBMvP4ei8VJ8ixFCDY2uxzMe+/OWEYt0cFhb5Dulh84bSscGF5qA+w3o7jhpGJ6BbRrLBhTTx32w4hEwBaEJuO7P/LC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789974; c=relaxed/simple;
	bh=VEup7kQ5lx85Rrf62gFLlylZZgc+GALWkDRL7k5jXWk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pkzrXdm1RUk3ZJAuSYRZxgt9yYMIz03Mhz7Pwhr2c8Y233ct8Cmym3PtsZGmvQbFQaBUFPsTF7w0MDxbJUVTcx17+JRpiDoyQfQE2w6p/R4WKq3S6s2EDvCw32MJj8SfmYwVGfg2q7w4o4YmNCxZ9LhOgGvfK6U/V+VyrFAukOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=RC/Qzu3e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iXRbkXU6; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 3467F5C0085;
	Thu,  1 Feb 2024 07:19:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 01 Feb 2024 07:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1706789971; x=1706876371; bh=jAOlD2wRP+TkqANNdA/oO
	ptwRFEKnMR/PUTgpA6xP+s=; b=RC/Qzu3euPahqodoXR5ZVDunM0xNvuueZ/72j
	3RbHvdTSIgOUA3jx/jMTqIGK/JYBxp8SFxZl8xwG4cwR7npuiIEvjNO5m6Q3Ohdm
	EnGdeZHLoKW31GJeGTftbZVnmOBgQYBzmEAu64oKv2VhlbS+/UmVxTgLYHPWiydu
	Zaq1Sh3BGarm9ow7A0iRCUdNg61Dots9ee6nStMzm7gOrOhBjdR+0eK4aMvR8ZHb
	XYsr1EtIUT4+Bzoxit0EA5gjj/JyC2gx0hF/aWkJ2b8S+YtAzOASPSUHUK2njKaa
	zjzTbuUTAX4EFEjNrFmZgaq8n7DLRgEnOjSFRVd8fHKa5tdRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1706789971; x=1706876371; bh=jAOlD2wRP+TkqANNdA/oOptwRFEKnMR/PUT
	gpA6xP+s=; b=iXRbkXU6FGFzt2VLxA6yMCBsrOEyS0/72reuGXNlxAO7XWt+zZL
	CtFJoTKL98ggnwYjlG+BzZSnuGMtaivcJOphh+PSg3idIkE3fL2jwDigVIZGE28k
	847dzkQhhvCdsmJiENiG5YDJiYBvrziK5ReG9kctWQrAvFkS10PQ9wnlEVHt9wWy
	37OKJnQsWsxF4CnfYtOM/auy0M/LlLDEjLLewKqax7OGN172nY+fGKbwiVnjJWqA
	K1A36ENUF/PkFI2M4HEyxDscYnB8VxY/Qd2dASoeNhRDbuhUEzBmxp3Sp/1CMS31
	4ksd/t7M+wiR6yiVnJUc1nsc0+eY72VtdDQ==
X-ME-Sender: <xms:Uoy7ZYQd3BfcG1GQL-wfE9Xxh5clOwoF-T3J5R9R3X9x1N00vM2gYw>
    <xme:Uoy7ZVxF4-A-4Jv4NgO67GsUbtMyYW4awFU8Y1Sd31Lzd5Xegi4xQN5GRpB60oODq
    NnyGi1WQHn0K1V9YjE>
X-ME-Received: <xmr:Uoy7ZV2IRaHsXxBbihwLQu3apHpSjbRlKoG2xG-giI8N9DxYArNVZPFMifTjoJ-uVpVUsJvpi-KJ3gBBt-mUk1n-uF5dlwa-HHaU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetfeeiteefve
    egvdfggeffheetleejkeekleeugeffffdtgfdtteetkeevvddvgfenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:U4y7ZcAJvsOHneN4HhK6tP6uLM2S3nLPJPrWFHnhD-W5ljsjNZJC6w>
    <xmx:U4y7ZRhr8M0D_zcKTkLFqHBg46bbP_lAta2Qy2b9LKE1paUU9a8xPQ>
    <xmx:U4y7ZYrFm7rOYAUSMht-84VJa0iHw8-Eb0dyPC-YhkrJQnr34qqcAw>
    <xmx:U4y7ZRJ0ZprPGTo9UsIQ5tBwQ8L6Dlo_iFGqNVAtXwGg54kfEj_pIQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 07:19:29 -0500 (EST)
Date: Thu, 1 Feb 2024 21:19:26 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] firewire fixes for v6.8-rc3
Message-ID: <20240201121926.GA87292@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The support for legacy layout of configuratom ROM was merged to
v6.8-rc1, while it appears that it is not enough for some devices,
since they have a specific quirk. This pull request includes some
changes to handle the quirk.

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.8-rc3

for you to fetch changes up to 47dc55181dcbee69fc84c902e7fb060213b9b8a5:

  firewire: core: search descriptor leaf just after vendor directory entry in root directory (2024-02-01 20:53:18 +0900)

----------------------------------------------------------------
firewire fixes for 6.8-rc3

FireWire subsystem now supports the legacy layout of configuration ROM,
while it appears that some of DV devices in the early 2000's have the
legacy layout with a quirk. This pull request includes some changes to
handle the quirk.

----------------------------------------------------------------
Takashi Sakamoto (2):
      firewire: core: correct documentation of fw_csr_string() kernel API
      firewire: core: search descriptor leaf just after vendor directory entry in root directory

 drivers/firewire/core-device.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)


Thanks

Takashi Sakamoto

