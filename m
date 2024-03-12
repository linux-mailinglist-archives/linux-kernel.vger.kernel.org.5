Return-Path: <linux-kernel+bounces-100536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C485B879947
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9CD283025
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3654D7E58A;
	Tue, 12 Mar 2024 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LpGcltHm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EyP2Jmfx"
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF2015BF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262024; cv=none; b=cnQqFbkVg/Ofv7U4Q0M97+eC7hAMhr2aWt/njfcAOjvdWx4pLPnLXlrqS3RE0KjMZkyY3s2zkkKRmehsV4W7SffZPH9lSNCkPt65Qv2gMZy+raIHFgqDjgMtIHYX+REiKydX5MiWUWDUJRhhlqts+1Y/k+tMCcSY9bOalxzn51Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262024; c=relaxed/simple;
	bh=Bmk/3+v1QwJcBRx8UOLPoXvV5jlPuvnYJf1PzbFyo0Y=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ZPWbRHfx0Rzxxj+EkwyC3/8ZYMNklJvvs7w/N074EQ9YzaHrt4se+q93IgA6pL6qZHrnCQmDTqhXX1ww7NFDCxlyRIJXLrpsHacLTYwJ1TOpqALIOj4xTpTFLLEaB6enc9H/Y+T/gKR5imSg2cpkhzwn4Y5YK80I2jxb6f3d/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LpGcltHm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EyP2Jmfx; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id AE5251C00076;
	Tue, 12 Mar 2024 12:47:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 12 Mar 2024 12:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710262021; x=1710348421; bh=MwpOu/tg2M
	IdvMwhIU2xxdVqRvxdJJhDNXci8dpj6ic=; b=LpGcltHme0xzcZMpEYg74GLl6T
	lZ7d4wDim82W7CYwpGUsFTANcaPLlidmWy7PdCgzGiSu3alk2o/GEE8JTS48XXc0
	VhmPAk4UpQb26y+CEQ0nPvb3uLrBm6TQLbpeit2njP+1OYBGatjTUPwiSgbsgRQ1
	FZz3TammLdBSm75ZP5v0NGzfUuRBIg+jW09cKw+TCms2co3vrOnRBod1HHAOSBui
	D5KNUrMt9mGZzhXL7N00w0WMvvEqJXVK9ouQzaJ7DAUyVUdNxmVujW8h5B0eZnaN
	DDsd2NIUdTzdGIr24TEiBSgYn0fUidNyMzKPj49xekq3fWbe7ANzkJkWl0zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710262021; x=1710348421; bh=MwpOu/tg2MIdvMwhIU2xxdVqRvxd
	JJhDNXci8dpj6ic=; b=EyP2JmfxOP+Sa6QnCLClT0TAR11NnSYb9chR+SSqhupW
	TkQExX4SYgJvIAvWUv0iIRo3ngtJLsnbSUjzGxQpruwon9l3wwR3VzDX1l4P4kI5
	LjDo07AxJCtihMIQ/8Of8IaOZYlqKhclwMkC3gc/qM8VgOg4bnAqOxgTUQMM1lPX
	QTGxOP4p4jykAnHffRiPR5VYeB9Xtb1Iza+QljWxp5AAm+iifrk71TKbCyk1igFW
	iYGjfzIJb3v0zpYIIb4pWJv9kKzyXZ6C54jgXkKGujFX2Qik4AOTOORsJRT1WIAo
	cjLSNE+EFJz34F48DFUFnts9slabtfGavdBnUNpLTw==
X-ME-Sender: <xms:BYfwZdib365nQoG2OKiT1o5OHXIYbs8NhbFSKY22SFyLOaoyS-P1rQ>
    <xme:BYfwZSCHT56aZByGKeEIvr8VLrU3ueZrH_mCKLS8sslCh6SLM8gwcqiKLi_6xRQ1K
    ZkHmS8uiIbNkcYSF0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeeigeeuvdekheevudeiteegudfgjeehuefghfettddvteeuteekhfehudfhtefg
    vdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggv
X-ME-Proxy: <xmx:BYfwZdGgIyTdSgYKPHCa7ayYGRFc9QV_E7E7jkd4Kndke6TFhwovnw>
    <xmx:BYfwZSSrNikP_FKKoJrX4xjCPayBV-gToelz1CN-Lu6M7aehqCtiGw>
    <xmx:BYfwZaz6fOPJ2mteoIPZ_x-ZFWtdKvxTGhYGF0WFDfBDliTa0V1Gjg>
    <xmx:BYfwZY7f4-Q62Dk2bPOWThf2WnRw6Bzz6TxomTt1_VEFoz23bsT7DA>
    <xmx:BYfwZUsHNpuxJ0f_xDwTTcU_BtyUc2BRfEV73V3NmnJA2ArmQsQG1ZySPIM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 030AEB6008D; Tue, 12 Mar 2024 12:47:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1ba0456e-879b-4435-808d-54dd91b9506c@app.fastmail.com>
In-Reply-To: <89d0bb77-a608-4ae0-b9d9-e17fdf5f12da@app.fastmail.com>
References: <89d0bb77-a608-4ae0-b9d9-e17fdf5f12da@app.fastmail.com>
Date: Tue, 12 Mar 2024 17:46:31 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/4] ARM: SoC code updates for 6.9
Content-Type: text/plain

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.9

for you to fetch changes up to 98dcb872779f8bea30cd34716c7fdeb0963e3606:

  ARM: s32c: update MAINTAINERS entry (2024-03-05 17:23:09 +0100)

----------------------------------------------------------------
ARM: SoC code updates for 6.9

These are mostly minor updates, including a number of kerneldoc
fixes from Randy Dunlap across multiple platforms. OMAP gets
a few bugfixes, and the MAINTAINERS file gets updated for AMD
Zynq and NXP S32G.

----------------------------------------------------------------
Alexander Sverdlin (2):
      ARM: AM33xx: PRM: Remove redundand defines
      ARM: AM33xx: PRM: Implement REBOOT_COLD

Arnd Bergmann (8):
      Merge tag 'samsung-soc-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into soc/arm
      Merge tag 'imx-soc-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/arm
      Merge tag 'omap-for-v6.9/soc-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into soc/arm
      Merge tag 'zynq-soc-for-6.9' of https://github.com/Xilinx/linux-xlnx into soc/arm
      Merge tag 'zynqmp-soc-for-6.9' of https://github.com/Xilinx/linux-xlnx into soc/arm
      Merge tag 'omap-for-v6.9/omap1-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into soc/arm
      Merge tag 'omap-for-v6.9/soc-part2-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into soc/arm
      ARM: s32c: update MAINTAINERS entry

Christophe JAILLET (1):
      ARM: imx: Remove usage of the deprecated ida_simple_xx() API

Jay Buddhabhatti (1):
      soc: xilinx: update maintainer of event manager driver

Masahiro Yamada (1):
      ARM: omap1: remove duplicated 'select ARCH_OMAP'

Michal Simek (1):
      ARM: zynq: Remove clk/zynq.h header

Randy Dunlap (15):
      ARM: s5pv210: fix pm.c kernel-doc warning
      ARM: zynq: slcr: fix function prototype kernel-doc warnings
      ARM: OMAP2+: am33xx-restart: fix function name in kernel-doc
      ARM: OMAP2+: clockdomain: fix kernel-doc warnings
      ARM: OMAP2+: clock: fix a function name in kernel-doc
      ARM: OMAP2+: cm33xx: use matching function name in kernel-doc
      ARM: OMAP2+: CMINST: use matching function name in kernel-doc
      ARM: OMAP2+: hwmod: remove misuse of kernel-doc
      ARM: OMAP2+: hwmod: fix kernel-doc warnings
      ARM: OMAP2+: pmic-cpcap: fix kernel-doc warnings
      ARM: OMAP2+: prm44xx: fix a kernel-doc warning
      ARM: OMAP2+: PRM: fix kernel-doc warnings
      ARM: OMAP2+: fix a kernel-doc warning
      ARM: OMAP2+: fix kernel-doc warnings
      ARM: OMAP2+: fix kernel-doc warnings

Ricardo B. Marliere (1):
      ARM: s3c64xx: make bus_type const

 MAINTAINERS                                  | 20 ++++++++------------
 arch/arm/mach-imx/mmdc.c                     |  6 +++---
 arch/arm/mach-omap1/Kconfig                  |  1 -
 arch/arm/mach-omap2/am33xx-restart.c         |  5 +++--
 arch/arm/mach-omap2/board-generic.c          |  6 ++++++
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |  2 +-
 arch/arm/mach-omap2/clockdomain.c            |  4 ++--
 arch/arm/mach-omap2/cm33xx.c                 |  2 +-
 arch/arm/mach-omap2/cminst44xx.c             |  2 +-
 arch/arm/mach-omap2/omap-secure.c            |  4 ++--
 arch/arm/mach-omap2/omap_hwmod.c             |  9 +++++----
 arch/arm/mach-omap2/omap_hwmod_common_data.c |  6 +++---
 arch/arm/mach-omap2/pmic-cpcap.c             | 24 ++++++++++++------------
 arch/arm/mach-omap2/powerdomain.c            |  2 +-
 arch/arm/mach-omap2/prm-regbits-33xx.h       |  1 +
 arch/arm/mach-omap2/prm.h                    |  1 +
 arch/arm/mach-omap2/prm33xx.c                | 22 ++++++++++++++--------
 arch/arm/mach-omap2/prm44xx.c                |  2 +-
 arch/arm/mach-omap2/prm_common.c             | 10 +++++++++-
 arch/arm/mach-omap2/wd_timer.c               |  4 +++-
 arch/arm/mach-s3c/cpu.h                      |  2 +-
 arch/arm/mach-s3c/s3c6410.c                  |  2 +-
 arch/arm/mach-s3c/s3c64xx.c                  |  2 +-
 arch/arm/mach-s5pv210/pm.c                   |  2 +-
 arch/arm/mach-zynq/slcr.c                    |  5 ++---
 25 files changed, 83 insertions(+), 63 deletions(-)

