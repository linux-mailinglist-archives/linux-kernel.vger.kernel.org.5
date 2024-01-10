Return-Path: <linux-kernel+bounces-22055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AF682987E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACDF7B26594
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A638A47A79;
	Wed, 10 Jan 2024 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="IiRHC0jD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="379folda"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017CC47A63
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id C75153200ADA;
	Wed, 10 Jan 2024 06:13:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 10 Jan 2024 06:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1704885216; x=1704971616; bh=OaSqqCRQAb2hfOC+nKMvH
	e9BSxocFnhthDFw+chlU0M=; b=IiRHC0jDIMG2kvTsFFoF5ryARLEbVNhBC3GcS
	CA1mdH1oLRsugqPkcueM3oqEIFq2vBoiKfesi/8HEH//bn7qNpe9ox2ID7BtHT0v
	yGMW+NFBpnBvnlwvzlPt5uohAc8BN8dZVa+WyA7HP1MelcJNptB/eop0/UNj47kp
	mUreGGkqFhwN5aAmGRL5o2W24lQsluCZd66t/uP1CJRY/+Ey/8XkwkF8FGeSNo5A
	wEWtj34zcmsqQZibKTncEjYcB2thQHS4gZIfbRg9HhbJa4mo4EM8X7LL46MBE0Jm
	bgszxA71d2h8F3h8ngluPDgi+41Aikej0mvJnO/Rc4dYJf9aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1704885216; x=1704971616; bh=OaSqqCRQAb2hfOC+nKMvHe9BSxocFnhthDF
	w+chlU0M=; b=379folda+JFSqAkqrWcmyyzaBbKHBljFpGVo8bc7yht9Ys+b8jn
	YUFS5QKPdzFHbUXInrxeeIrQSDmLBxYJNwDv0Xji4sOFq3WjiccwBEPfp9QC4sW8
	j5xDV8ebEcxLA/r/hQKzneSWkHqwJ7wMzaKUypLIeXAkk11WmkQqu+IYvHuQIlxF
	37TolXwGIUG2FwjbQrLagkK6wMAM73Ri4oCNkl1PSUdSQ5NKYUa3HHfDDBUCDFKx
	VyRmL+YPd6fYzo10SUJ2O3rXie0OnTzsvJWCWdArf6c6biz0f9IOIXdIebU/dUAy
	k9wJ025ye0GU4RaXwzrkRo4iGFfBLjMr7Ww==
X-ME-Sender: <xms:33ueZVJp1UZohuWi1iGMtf4ycriUR4ZUvtBdqOOXSJKwsfWzoISfIg>
    <xme:33ueZRKgC2EaGt9c32kz3VZZ9KTvDl96ce_unH6pYrTTxChO5jNoUOAKJ49bklX7m
    v8HZCtZoa6uOrdr7fE>
X-ME-Received: <xmr:33ueZduru-f6JxtlN5-6VbMJIQZKp9gcgMjXNHCVkcs1_QtNxZjZyfFErI29dnMLbJongMqvI8h7EzFSExgVdxxWzIZwCRcLcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiuddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetfeeiteefve
    egvdfggeffheetleejkeekleeugeffffdtgfdtteetkeevvddvgfenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:4HueZWZaFuSng3CPaZiFnKujRMVLVBA_2dhUtn9FwvHmYs2ykv83Zg>
    <xmx:4HueZcblBznvIUZfFrGkg9pKHkZwhhicJI-V2GbOhuuWruifh1OyHA>
    <xmx:4HueZaBVO2hEbPcwShJrWBWjm2u_bj3V8i8wPEHZEXyVgbMxNA8CXg>
    <xmx:4HueZVBJ4nLTTtH8xkXaqCGuImFxm4Mj0JjhcCpOhGxndDwB7cQgig>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 06:13:34 -0500 (EST)
Date: Wed, 10 Jan 2024 20:13:31 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] firewire updates for 6.8
Message-ID: <20240110111331.GA138108@workstation.local>
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

The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:

  Linux 6.7 (2024-01-07 12:18:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.8

for you to fetch changes up to 986c20bb3e67d0171c0c2e4acd25429b1876b963:

  firewire: core: fill model field in modalias of unit device for legacy layout of configuration ROM (2024-01-10 18:37:13 +0900)

----------------------------------------------------------------
firewire updates for 6.8

This update includes the series of changes related to device attributes,
as well as slight code refactoring.

Some old devices are recognized to have legacy layout of configuration ROM.
They have an inconvenience that FireWire subsystem adds no attributes for
vendor information to corresponding devices. The main purpose of this
update is to rectify the inconvenience.

We have a slight concern about regression. The update changes the value of
modalias for the unit devices by populating its model field, which was
previously left as zero in the case. I've assessed the potential impact of
this change and anticipate it to have minimal concern for both the kernel
and user lands. The change is enough acceptable.

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      firewire: make fw_bus_type const

Takashi Sakamoto (8):
      firewire: core: adds constant qualifier for local helper functions
      firewire: core: replace magic number with macro
      firewire: test: add KUnit test for device attributes
      firewire: test: add test of device attributes for simple AV/C device
      firewire: test: add test of device attributes for legacy AV/C device
      firewire: core: detect numeric model identifier for legacy layout of configuration ROM
      firewire: core: detect model name for legacy layout of configuration ROM
      firewire: core: fill model field in modalias of unit device for legacy layout of configuration ROM

 drivers/firewire/.kunitconfig            |   1 +
 drivers/firewire/Kconfig                 |  16 +++++++++++++
 drivers/firewire/core-device.c           | 129 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------
 drivers/firewire/device-attribute-test.c | 251 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/firewire.h                 |   2 +-
 5 files changed, 370 insertions(+), 29 deletions(-)
 create mode 100644 drivers/firewire/device-attribute-test.c


Regards

Takashi Sakamoto

