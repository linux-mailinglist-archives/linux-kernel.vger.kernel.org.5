Return-Path: <linux-kernel+bounces-105112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7437487D93F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A09B21577
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 08:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53878EAE5;
	Sat, 16 Mar 2024 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="AE5WUaq5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jy4Ifg/l"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6291B748A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710576352; cv=none; b=DAom2p47cojBW1ueIxwT5O8Sc7cUW5qerN5R4uZiIr7FpxTiUrQOH7ckDQTjJaOs8qidCtnwOl76Y9W/gdxsO4Yj2lBEsSJDx+FX2K9q5ZPgIKkA+wfaAgJ0ZRRVI9s2MXGY7gy7n+ySbOxcdm8ZZNXIVmYOuYPzSXQoRO8s8ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710576352; c=relaxed/simple;
	bh=374UJRRmeGjqgUzJk+9TzaS2eYl4CrUTUJH3GxVBc2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aLfS77LiBokq5Nl6cdim/ePxh5JO99VvveLDnt6O3IxwWeOOGx/B13wtjrikwxUeJ/VtaQKhNIhU8yqYHP56EMx8WH2SCJcKMo0uLu1cDS7NNoIWpb5dG36VIsP3qLDdoHy0KmdXW8arPcAIN+55pF90cINEREStXZbdFo3RGqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=AE5WUaq5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jy4Ifg/l; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 335E31C000D3;
	Sat, 16 Mar 2024 04:05:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 16 Mar 2024 04:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1710576348; x=1710662748; bh=wfzrm6EZwEM/kGhsdInSZ
	rfFgroXMcRCq9vfUyY+h3s=; b=AE5WUaq55AKc2oaiSlE3VQjznJyL16nh44oj4
	Rw41kWSYRGGayjnMfWxCyGrzdzdUshzSPyVg8nb1oB4h5nMXflcQeGD79UsD14tj
	QkFGfywYTuvMbQLgwLyNOcTrcyyqcYZdFYyfRWVlR5/V4e/VmbeJSib91DgA9B6P
	zpW1AwuxP0GYpE3V5rTFX1HjQy1Ddwqp9CtSTmL6TeBoBGYJOgayrR0+b5eDkghE
	NposPwxDQUamkJIx/684Jf1MHkzcrmmWFa2oRUNWJk4QojgcI+JesFnv3wWxRGKm
	a1rIIhisQGhK0RKN2irZq53V5kHVm/xoiaafAL3bmRjP7K6ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1710576348; x=1710662748; bh=wfzrm6EZwEM/kGhsdInSZrfFgroXMcRCq9v
	fUyY+h3s=; b=Jy4Ifg/lywQPzBxD+UA6p4jTAeKN2qiVsbVshBDJjju0uElJqXx
	ez+nND/VULHAj6qKNxHY2wIa+ydrxP9Plk1xY3SgAuAJtSVaqNxP/irVIU1u5ySj
	BKYZ9AMbgFeebsdRWRZPesg08j0RuH06xcJfqJsZb7APWIZsJO05nXykjMSu1+xS
	CtRb2+AHzt14Vw0ANxf2pc07tpXaqZB99TcYzHEuCZtW+wesfg6PBzK3IsZrjaNv
	lAv7e6zsxlILftLSUYivvV7zOHkrIg/xEcaEchVIJhmthOblK11kXqvy2mriiWvG
	2H+2Guwmyq+iebaqvH/sJmaZl9w4OT31N0Q==
X-ME-Sender: <xms:3FL1ZaDp5loOG4TaG_-XQ5E4A5GbW-L1a6ApVPNfCpvSVX2W-9ZAWg>
    <xme:3FL1ZUhVrZGtDamMVr1hBaP0v9yZ2Z01_3U0G5ywiApXgQOglyRxsvzPrQfRtCiW7
    mp7B0VbUKdKZKOUkvY>
X-ME-Received: <xmr:3FL1ZdlXLMdJU1brCb_H5M7UelIzugm5bGISKdXZNrC04TYJV8z_dDBqpazDeh4I0d4mjIx5LntZDuaAby3CWrfM4c87KPmzrL8l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkedtgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetfeeiteefve
    egvdfggeffheetleejkeekleeugeffffdtgfdtteetkeevvddvgfenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:3FL1ZYzJvRO41JzChOY69hFK_rqApJrYyc2JPDK1orWoe59gD0h-Pg>
    <xmx:3FL1ZfRcNlzGYRrmnlXkmUEYMoPR91K5AAn1G_OEzzRHVYAZ2kVAkg>
    <xmx:3FL1ZTZof-QxbRYn8qMm29EqZCOXZprD7mNJJsPuZPaCIOFm_g17jw>
    <xmx:3FL1ZYR0RRrRgS__g-EGRxXeyR19nMH43N7pK6c4MvbJnWADYEFX0w>
    <xmx:3FL1ZZdenBWY23mVqa8ktRSTmGD0QkozXV2lvLlCxBkiYVj3XAzsk8VKgyc>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Mar 2024 04:05:47 -0400 (EDT)
Date: Sat, 16 Mar 2024 17:05:44 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] firewire updates for v6.9-rc1
Message-ID: <20240316080544.GA395657@workstation.local>
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

Please pull firewire updates for v6.9.

At the previous version we have some work to support legacy devices, while
for the next version we have just a small changes to string processing,
as it closely resembles the subsystem for the old technology.

The following changes since commit e8f897f4afef0031fe618a8e94127a0934896aba:

  Linux 6.8 (2024-03-10 13:38:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.9

for you to fetch changes up to 04f082d39b99f0b7b4b1cada14280f41d99f1e1f:

  firewire: core: fix build failure due to the caller of fw_csr_string() (2024-03-11 10:38:13 +0900)

----------------------------------------------------------------
firewire updates for 6.9

This update includes small changes about page-aligned buffer for string
processing in device attribute.

----------------------------------------------------------------
Li Zhijian (2):
      firewire: Kill unnecessary buf check in device_attribute.show
      firewire: Convert snprintf/sprintf to sysfs_emit

Takashi Sakamoto (1):
      firewire: core: fix build failure due to the caller of fw_csr_string()

 drivers/firewire/core-device.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)


Regards

Takashi Sakamoto

