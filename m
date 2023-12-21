Return-Path: <linux-kernel+bounces-8525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9494481B907
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FB28B27ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF566D6CB;
	Thu, 21 Dec 2023 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="jHxfqpqe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OKOIGgfA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69D76518F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id A193A5C0245;
	Thu, 21 Dec 2023 08:48:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 21 Dec 2023 08:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1703166532; x=1703252932; bh=MpWlL/I4TT
	CCirTvKzurV4wZMXNFFME8XRsx9U13RCc=; b=jHxfqpqeKpmTeAWN+qK2of5tQv
	AgrNkGCBPeNezkJjbzJEw1XCEWHZOhPh6oLSr6I5z9OXhjpXnU/xWdQYNGa28pLc
	8DkDMXGkNuE2zwjniFL925A5+bh5buh5tyKYxc0ka14/gNylddqARL/LbiTJ1L88
	jlCSU2f4BNRkK1nO+UECO6aCmmXl//Z7svX64l2ITs2dYnpC8bRM4kiay+TsmZHu
	YXodxVG5TxSVnXeKFh4UciuSvT9J+eh322DVUZWgpnOK76UckIyPkIhrXx0+IPHD
	ao4NOVt9jl7u9H6werN1NeML/MC1q43AxyfUb4E3nFrncXO4Cx4AM9sO+hXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703166532; x=1703252932; bh=MpWlL/I4TTCCirTvKzurV4wZMXNF
	FME8XRsx9U13RCc=; b=OKOIGgfA21gsWJ43Rxvtsl/xAelvSB611cb9usglXhq6
	OLad7qnuwBVQCqsmOFyVXXpnh9Wa63AnrmsW13oUuDKAX1QVu/QAb1+JVzSe+bFQ
	qzNsfXAxBRAC2umk44QWgR1mq7U7BOdC+SLFuuLncZz/bRrL0yDO7HHoqawR72mF
	4gURrTtXPQ7Lwm2jnordLVAUQyq8T971h6lL+WFOCfEP7Cpr3Qx3dnWzR++/Hyle
	f7Z+8oRLGeeV9f3HJ6jX4cxJisuSC0DBTdCxwAxP51eK5HBgRM8DtHmWD6E8zTpw
	rxzXeHAR3+HcUx3QPHACnH2rTFgnmkY/8JIeAK4P5w==
X-ME-Sender: <xms:REKEZdEvlB45f2iiHn-kcgDtNPh93cm6wAHHQKgxQoSI0h1Wh2hqZA>
    <xme:REKEZSU-sMJgwxxOi5OdWnjhUAq4pjpbFx2Nvr3O91NYZlaIpPE2ZBzKrqF0d764q
    d_iw_MBIRjHTUadf5c>
X-ME-Received: <xmr:REKEZfILXJScLZ3wI2B62KzR_P7zZseA977xgmJXDdTPuXL1Ofdm_8q1Okf5I3bsAciVPY-rJNQtHNk_Rotq38ETydAKNbAkBGUi3nRPxq91jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfgrkhgrshhh
    ihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
    eqnecuggftrfgrthhtvghrnhepuddvleetteefledttefhvddtteelkedtgffguddvudev
    teeuhedvveejleetgedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdprghrtghhih
    hvvgdrohhrghdpudefleegthgrrdhorhhgpdhsohhurhgtvghfohhrghgvrdhnvghtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkh
    grshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:REKEZTHu5wGZto0zsmXgpJlDmhXzdNohfkDcUuisXhcAkQat8ejiZA>
    <xmx:REKEZTU1MH_qHCC9TTUbgyyUAUIQZq8dXqLAurEHBma2KogiYkf_1A>
    <xmx:REKEZePhFvuQ1N2YeJay9kwXHUG00TXk3CXbCZL9pbMD13AEKi3WWw>
    <xmx:REKEZacuQkOmbJqA_53XHaRKVvNd23LC6uzkETsoQ8Gf04CqUP9mqg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 08:48:51 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [PATCH v2 0/8] firewire: core: support legacy layout of configuration ROM for AV/C device
Date: Thu, 21 Dec 2023 22:48:41 +0900
Message-Id: <20231221134849.603857-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series of change is take 2 of my previous post[1].

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

Changes from v1 series:
* fix evaluation of uninitialized variable in 7th patch

[1] [PATCH 0/8] firewire: core: support legacy layout of configuration ROM
    for AV/C device
https://lore.kernel.org/lkml/20231220041806.39816-1-o-takashi@sakamocchi.jp/
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


