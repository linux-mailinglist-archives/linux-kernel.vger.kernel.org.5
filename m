Return-Path: <linux-kernel+bounces-2525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6E1815E73
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46E61F22147
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 10:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB976566E;
	Sun, 17 Dec 2023 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="LAOz02sw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vZEd7Jir"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB1A63B6
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 5A5295C00AF;
	Sun, 17 Dec 2023 05:30:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 17 Dec 2023 05:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1702809017; x=1702895417; bh=fyXh74lQge
	vKNGlAlWNEOwwiFaBctJceP26p4zqGrh4=; b=LAOz02swTOwpxlka4++GTNrEs/
	fK20h/G62v7uyyNLXgKe9owyZwFb90T7IcFW5szLAIH8N3fFFpLGcFP1vsQlbJzX
	1C2ZHKTi9w2d9wFFA0hKL7Qb++QADCHgCtaxd6lGShDvr3Vb6UrIXz7W1U56VWfP
	UqJQk4hcLOJ+P53PbdDcsupzioFFP8LOz7Pd+MUAE1612sbf4nIfeWT4X9Cm1VjC
	mXsPYOtrpvCeVmbFz5A7VpeiBRZtfbJbbYEuAqpzYu4lUUEeqgKSyL/XptTZPnI8
	QPuxI8qePv1LM0HHrqVpeA6RqOK1lzb2ItWYu3B60QyLDYeUg79a+iNOUaOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702809017; x=1702895417; bh=fyXh74lQgevKNGlAlWNEOwwiFaBc
	tJceP26p4zqGrh4=; b=vZEd7JiryxXG/GrZcsNf7s32q7XtWdT/ewhB4wsuHJnX
	SCQem2g64t1SxBsqqX3bMndI0jKnKLMew6XbsOGuwuzXGvJ3jnF4Gl9D3auaOedk
	3MT03PBe3u6TamPrxd6EaUQXbNTO5n13l1951R7oaJn/HX6aSC556V1rwSXNIsVV
	ilk7SCvt+l3vr+4zeMMWXtxb90hzXEJ/LfApBQiBZpBx4b6HFioH+Q8TPMaIyguI
	csiIsNjxZFPqQZVexmJDlNklwkl5voutkG7DH2+1u0Jl0D/j1S8e+oEvL5Uumf2P
	CLGk0oX0S3vHln1piKvsP3zL9EVu6BmdemxnGrkMsw==
X-ME-Sender: <xms:uc1-ZY1Ff3MSz0Atr8p7vdi5bLpKiz6UAuMtTn6oYwxL2jEhNHlmJQ>
    <xme:uc1-ZTFnnzFq7LSvnavQambnTPJZy3rwPiF1X4ChgyKLhXFN5goJtk8NboIVWx_ka
    haNNqrLCmScwyV_G9E>
X-ME-Received: <xmr:uc1-ZQ5OIe4yKeXYV7P3os72lCCbnGK0du7rJohxUys2bMrOyTddaNupe5K5K6WwES4AjiRBdsOtQNU3Bw5nmsW_sr-tgVUMfcflMb2RdRnOqWM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtiedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfgrkhgrshhh
    ihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
    eqnecuggftrfgrthhtvghrnhepvdevveefvddtteeiffetheehjeelkeffudejieevhedv
    leelkeejkeekieethedtnecuffhomhgrihhnpegrrhgthhhivhgvrdhorhhgpddufeelge
    htrgdrohhrghdpshhouhhrtggvfhhorhhgvgdrnhgvthenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmoh
    gttghhihdrjhhp
X-ME-Proxy: <xmx:uc1-ZR08Gq4mpicEvCWAcd3I0dXkwKVaHlYts-FHolWcQfTpbSbI8Q>
    <xmx:uc1-ZbFqLYAJ9G5ALyDleVl2r1x0YCf4RZaM3ypxPGQZxb25bELZOQ>
    <xmx:uc1-Za8PRLsLDs_y9wnmYQsGRrrOetT8Lm0uENqCMgJt_dAwvxFsTw>
    <xmx:uc1-ZRPOP4uTyu4j99KjPCFYRgUUZpOw286MO2ss4kk5ntRUIrwVdQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Dec 2023 05:30:15 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [RFC PATCH 0/8] firewire: core: support legacy layout of configuration ROM for AV/C device
Date: Sun, 17 Dec 2023 19:30:03 +0900
Message-Id: <20231217103012.41273-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Current core function of Linux FireWire subsystem partly supports legacy
layout of configuration ROM, described in annex of 1394TA document[1]. It
appears that some users have the demand of full support[2]. The series of
change is to satisfy the demand.

The change relates to driver matching procedure and notification to user
space, thus could easily bring functional regression. For safe, the series
includes KUnit application to test the change.

However, backward incompatibility is inevitable due to change of modalias
for unit device. As long as I investigated, any unit drivers in kernel
are not affected by the change. Additionally, less applications in user
space are not as well. I think we can be optimistic to the regression.

Anyway, I'm pleased if receiving your comment or test report about the
change.

[1] Configuration ROM for AV/C Devices 1.0 (December 12, 2000, 1394
    Trading Association, TA Document 1999027)
https://web.archive.org/web/20210216003030/http://1394ta.org/wp-content/uploads/2015/07/1999027.pdf
[2] [PATCH] Fix missing sysfs vendor/model entries for some devices
https://sourceforge.net/p/linux1394/mailman/message/55802731/


Regards


Takashi Sakamoto (8):
  firewire: core: adds constant qualifier for local helper functions
  firewire: core: replace magic number with macro
  firewire: test: add KUnit test for internal CSR API
  firewire: test: add test of CSR API for simple AV/C device
  firewire: test: add test of CSR API for legacy AV/C device
  firewire: core: detect numeric model identifier for legacy layout of
    configuration ROM
  firewire: core: detect model name for legacy layout of configuration
    ROM
  firewire: core: change modalias of unit device with backward
    incompatibility

 drivers/firewire/.kunitconfig   |   1 +
 drivers/firewire/Kconfig        |  16 ++
 drivers/firewire/core-device.c  | 117 +++++++++++----
 drivers/firewire/csr-api-test.c | 251 ++++++++++++++++++++++++++++++++
 4 files changed, 358 insertions(+), 27 deletions(-)
 create mode 100644 drivers/firewire/csr-api-test.c

-- 
2.39.2


