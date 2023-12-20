Return-Path: <linux-kernel+bounces-6352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7FE81979D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4FF1F25E74
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75BA8F71;
	Wed, 20 Dec 2023 04:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="tHtRqaZ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DOe8Cv2u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8DA1D699
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 9304E3200A48;
	Tue, 19 Dec 2023 23:18:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 19 Dec 2023 23:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1703045892; x=1703132292; bh=XR6dDe9SdL
	Viul/VkLKU8KFtzdmbcDDwaOcUEYOSNO8=; b=tHtRqaZ99J5AIwISQrc7f9TcXj
	7OrcfI3GJKy/hzIUbQ2a0hJqBgJ+bofWvUuhnhI9TdSTfawP8Vlsq2h/3DeL+Xu8
	/52E3BJ6aPk0lFwqArm1hu/8NPklYoNt4ZnxDvuqrfYzlA+akQ1Vrdubwke1e56R
	R6YDTypOh7WFGNU2QwXDqD2uyCo323WqdOlGYT6GV89TE3pT1RwuqCQDApvzxG4i
	OU7b5+hgJbyMPFdSNW/zoyKfVNWw66wZjpDVaRUWZUliG/tCDIs9JhjYkpLAOQi6
	M1964CdmjlukOk4mlM7mNRnE4TSt+TpIxGbbz0+ZGQzoxhdN7xXDTG+cGqqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703045892; x=1703132292; bh=XR6dDe9SdLViul/VkLKU8KFtzdmb
	cDDwaOcUEYOSNO8=; b=DOe8Cv2ulwMcqqbBx0m4EgDw2T5pSJFbYNQeF/T/Awi2
	CdpxfWY4MgIOzNNXVOqThrXYg2Q9Kug8kh3uYY/8jtmOIuEJsVG7T+hxeSno3BT+
	gW7PMJ8ghcNbh98PyRZLSW4B2bPSk9kbwQc3wUBg7D9sknrWZgnaORbkQrDGEY28
	MsV+2b9t7VeAL2UP/fiQKMk1ESxpOrk6laBhB6jHfeiH/3T6eKPR3UOwIUNP0V10
	Jyrj3jGfg9rFHufH0n2XMyQtFTnTg7X9PFLLHKzxmIKTkTbN8xUZvqa3vXy6cb9b
	r5eY2UlcUwBmDvcwDTYFn9aqtrrNjhmo8x3KAaMtjA==
X-ME-Sender: <xms:A2uCZYaNH3UGDjYiAwUgu-C8EJVrrXkCk259jquKIKMc7PcVji79Dw>
    <xme:A2uCZTbCEyvFdjD0FkyAGfZPDkunwXhTckoSFPui8QzMHsbJvEFvnvelxbecXbIYO
    XXXj4FBZ5qiURq1IWU>
X-ME-Received: <xmr:A2uCZS-NDu1D7Z6mF_HeMltSQlpaG2CVUZWQP31VX5QFtg_rLlW9i8OBDVsLAlrPml1FjI7S1k77jqO2Xv_wkIQlbQOWf6mnx86ApkybTKbprA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduuddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfgrkhgrshhh
    ihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
    eqnecuggftrfgrthhtvghrnhepuddvleetteefledttefhvddtteelkedtgffguddvudev
    teeuhedvveejleetgedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdprghrtghhih
    hvvgdrohhrghdpudefleegthgrrdhorhhgpdhsohhurhgtvghfohhrghgvrdhnvghtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkh
    grshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:A2uCZSrDQTCrFjry8Rf1Y0IaGNw61Y5V7qQCf8ymc0W4A7l9wP7eRw>
    <xmx:A2uCZTqZUzQhNGmEJTLS5q63nxV4MC3cCMtv_Pz1NgYXlLD7JrwcMQ>
    <xmx:A2uCZQT2oHG1UySlI4U3uDRHxG7dmgU8LPj1iOmKrFW9Q-TsCrhZXQ>
    <xmx:BGuCZcBJGnfhwnj72v_2vOPXk5eMgtVoL6mioJlguGDqQFbPed2vXg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Dec 2023 23:18:09 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [PATCH 0/8] firewire: core: support legacy layout of configuration ROM for AV/C device
Date: Wed, 20 Dec 2023 13:17:58 +0900
Message-Id: <20231220041806.39816-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series of change is to update my previous post for RFC[1], and for
merge.

Current core function of Linux FireWire subsystem has support for legacy
layout of configuration ROM, described in annex of 1394TA document[2].
However, in a point of device attributes (e.g. nodes in sysfs), there
are differences between devices with the legacy and standard layout of
configuration ROM. The differences bring some inconveniences to users[3].
The series includes changes to solve them.

The series includes changes relevant to driver matching procedure and
notification to user space, thus could easily bring functional regression.
For safe, the series includes some KUnit applications to test the change.

However, backward incompatibility is inevitable due to change of modalias
for device corresponding to unit. As long as I investigated, any unit
drivers in kernel are not affected by the change. Additionally, less
applications in user space are not as well. I think we can be optimistic
to the regression.

Changes from RFC:
* rename file and KUnit tests so that they are related to device
  attributes
* fix traverse failure when detecting textual descriptor
* remove redundant indication for CSR key type

[1] [RFC PATCH 0/8] firewire: core: support legacy layout of configuration
    ROM for AV/C device
https://lore.kernel.org/lkml/20231217103012.41273-1-o-takashi@sakamocchi.jp/
[2] Configuration ROM for AV/C Devices 1.0 (December 12, 2000, 1394
    Trading Association, TA Document 1999027)
https://web.archive.org/web/20210216003030/http://1394ta.org/wp-content/uploads/2015/07/1999027.pdf
[3] [PATCH] Fix missing sysfs vendor/model entries for some devices
https://sourceforge.net/p/linux1394/mailman/message/55802731/


Takashi Sakamoto (8):
  firewire: core: adds constant qualifier for local helper functions
  firewire: core: replace magic number with macro
  firewire: test: add KUnit test for device attributes
  firewire: test: add test of device attributes for simple AV/C device
  firewire: test: add test of device attributes for legacy AV/C device
  firewire: core: detect numeric model identifier for legacy layout of
    configuration ROM
  firewire: core: detect model name for legacy layout of configuration
    ROM
  firewire: core: change modalias of unit device with backward
    incompatibility

 drivers/firewire/.kunitconfig            |   1 +
 drivers/firewire/Kconfig                 |  16 ++
 drivers/firewire/core-device.c           | 127 +++++++++---
 drivers/firewire/device-attribute-test.c | 251 +++++++++++++++++++++++
 4 files changed, 368 insertions(+), 27 deletions(-)
 create mode 100644 drivers/firewire/device-attribute-test.c

-- 
2.39.2


