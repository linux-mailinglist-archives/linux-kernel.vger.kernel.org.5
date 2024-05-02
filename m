Return-Path: <linux-kernel+bounces-166263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4E38B9842
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4909F285C51
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EEB56B78;
	Thu,  2 May 2024 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="ThypioNq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MwWsdNvK"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E89B44374;
	Thu,  2 May 2024 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643980; cv=none; b=lUODh5ocmtm7R286BEEx7nFe7WvCkCkTR/aqulOb4Sxiy/ddnWP5XHUzDPlA9WUdFFFo4mrA+CgYFdeFwoCQ/cT7PhRkiQLq2ZlQC3H+Dat8DeMiflBEgB5ZrKnk0CaxNgWxCvcuxjt2kTo9cgFyS09hgK3lyNdkH4uEjO3l208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643980; c=relaxed/simple;
	bh=DcVD+OAMhzUIPuBLicTKktBmrnqdwg9u8cdk9CXSAuc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fbjFJrJ35T2qKv7P5su4mrtN2+hHHtbi0DuT08QfLJ1X0Fg0aTR0fpCBsZYaiGTT5V8M2FA6hIX7E08U3zytoCdyjf659mOrfo/Tk7cbPfNgpbM78OtSN4QxB7sqwLXtlQDrVLVEPShPN+oOJcQjC+Vu3fufWKnPvptgVpglKSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=ThypioNq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MwWsdNvK; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6132613810C2;
	Thu,  2 May 2024 05:59:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 02 May 2024 05:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1714643976; x=1714730376; bh=ko
	Bi8a5OtpD29T0eV24Y2ij/s7j1apAbux+6IxIHaR0=; b=ThypioNqNlMuH8fNFf
	N4HyccuabbnohpAri65HT93Enp+EdhGrKDjAuVDYTGBtclnullUCh7rRawDDuz4A
	BnZDcPPtpuuCGEaGMLK88zkS0zqn8KAmKYKl5+kPfke3GdUZlzQHRLmPPW2HWzYw
	RzSYLA4PINhcmrsbLKVrqqFlHbO/ASfL/PGOTx3H8muBN74I7099doAMiNcwl6CU
	vB2Ge/d2c7rMX1aJ41RNFLAdAzhPmgfkt0fuuR53CGx9vTflUQKJ544Kl9c/LgLx
	gfxy+LZCcVHT5rgOoi/DWfIVufzYgFnWetrmloRBrOQa7RhBbm4iTKIM/NRh7yUA
	Mebw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1714643976; x=1714730376; bh=koBi8a5OtpD29
	T0eV24Y2ij/s7j1apAbux+6IxIHaR0=; b=MwWsdNvKNeM7xslSQoINFqem3I7RC
	GaIHB0maHz55oFz+eyg+EeNi2zttMQLct5x0NoSymmPOurhyuUCmpVBQ56XMGPHn
	AWaJByinctob/IooKGGuIOcNcOeZRMPRAygfPachOh4D9Ka06UIW5S1NKjs7QbVq
	R7/Q5uGg20S2trwQGe31EfIBkZjX6rg7OWkUMo7Xf4ok67gYEPBoW4M1VkQL4wpl
	aw1Iee70HWvpUJyhjcVJRGo5G7EOc8gOGgQxyIfRTAsuhmqFGTerQFcvKIfcpCE5
	q+DEzeP1fIPBZnG6n5vVTgH1YgVd0g12kBDG71L2TK7OAnx5EcT/UqRYQ==
X-ME-Sender: <xms:B2QzZhVy2UzZ_1J_kEzh9RlhvWqSPnN8hU_6BmHRnimd6BLJ58gqHQ>
    <xme:B2QzZhmNZr6tiKdsy5S9_TmFtGehS-L84zHpBj5UBqkRyrPJOLlgZZN3ePp83XIrJ
    fnou5zqGpVPdEj31ic>
X-ME-Received: <xmr:B2QzZtbh2uwZpRfSSJbm9VC3cDFonnWyNAQoTFJNNKi_QSYx4thSwXc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeugfegvdeuueejkeejteek
    kedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:B2QzZkXYQ4qlcHQcouTyGNE30-_jzepjcvtEOCBeK0IVKua3hCAW9g>
    <xmx:CGQzZrnXEEUKoxK1nvI-at-bw48hL0xjtnC4_8q7euxmYJXPb0Se6Q>
    <xmx:CGQzZhesblcpcimgkRwo2waDDbme-dekv2XGgh1X8F6INnuDH6vgIQ>
    <xmx:CGQzZlGBjbLQVLB4nFmeuGI2mfDEOt4sqjZu6tP2QiCvyrQlcHQoNg>
    <xmx:CGQzZmvmY_fa1-O997jRNmxS4zjbvI0daYoqLChIZlt2MqJH_e18UahT>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 05:59:35 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 0/9] MIPS: Unify low-level debugging functionalities
Date: Thu, 02 May 2024 10:59:27 +0100
Message-Id: <20240502-mips_debug_ll-v3-0-3b61f30e484c@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP9jM2YC/32MSwqDMBQAryJZNyU+JbZd9R5FJJ8XfaCNJFYq4
 t0b3XXRLmdgZmURA2Fkt2xlAWeK5J8JilPGTKeeLXKyiRkIKEUBkg80xsaifrVN33ODFTjEXEs
 FLDVjQEfv4/eoE3cUJx+WYz/Dbn+dZuCCV4WQFwXK2vx6d/3SejWdjR/29b9Oy1JpU0kHKv/q6
 m3bPss3m/bkAAAA
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2679;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=DcVD+OAMhzUIPuBLicTKktBmrnqdwg9u8cdk9CXSAuc=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTjFPaHsRfPCJ1RWfr29GwrBR+TH0rrnsQyvOuoXnNAo
 vdidJF2RykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzkTCfD/9Dcv7NORx20VY81
 548x1WfbPpUrbl/z6/a8GpckT6ViBYZfTP/TFoc6T3/ttnup4iyTpNvrxd8VP721dMExbrvHXNs
 amAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Hi all,

This is a attempt to bring all low-level debugging print functions
together and provide a arm-like low-level debugging interface and
a further capability to debug early exceptions.

This patch elimiate platform specific early_printk, zboot printing
functions and cps-vec-ns16550 by newly introduced debug_ll.

Hope you'll find them handy :-)

Happy hacking!

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v3:
- Collect review tags
- Fix an indentation
- Link to v2: https://lore.kernel.org/r/20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com

---
Jiaxun Yang (9):
      MIPS: asm: Move strings to .rodata.str section
      MIPS: debug: Implement low-level debugging functions
      MIPS: debug: Hook up DEBUG_LL with early printk
      MIPS: debug: Provide an early exception vector for low-level debugging
      MIPS: debug_ll: Add Kconfig symbols for some 8250 uarts
      MIPS: debug_ll: Implement support for Alchemy uarts
      MIPS: debug_ll: Implement support for AR933X uarts
      MIPS: zboot: Convert to use debug_ll facilities
      MIPS: CPS: Convert to use debug_ll facilities

 arch/mips/Kconfig                        |  12 +-
 arch/mips/Kconfig.debug                  | 240 +++++++++++++++++++++++--------
 arch/mips/boot/compressed/Makefile       |   9 +-
 arch/mips/boot/compressed/dbg.c          |  39 -----
 arch/mips/boot/compressed/debug-vec.S    |   3 +
 arch/mips/boot/compressed/debug.S        |   3 +
 arch/mips/boot/compressed/decompress.h   |   8 +-
 arch/mips/boot/compressed/head.S         |   6 +
 arch/mips/boot/compressed/uart-16550.c   |  49 -------
 arch/mips/boot/compressed/uart-alchemy.c |   9 --
 arch/mips/boot/compressed/uart-ath79.c   |   2 -
 arch/mips/boot/compressed/uart-prom.c    |   9 --
 arch/mips/include/asm/asm.h              |   2 +-
 arch/mips/include/debug/8250.S           |  60 ++++++++
 arch/mips/include/debug/alchemy.S        |  46 ++++++
 arch/mips/include/debug/ar933x.S         |  41 ++++++
 arch/mips/include/debug/uhi.S            |  48 +++++++
 arch/mips/kernel/Makefile                |   4 +-
 arch/mips/kernel/cps-vec.S               |  16 +--
 arch/mips/kernel/debug-vec.S             | 194 +++++++++++++++++++++++++
 arch/mips/kernel/debug.S                 | 130 +++++++++++++++++
 arch/mips/kernel/early_printk.c          |  19 +++
 arch/mips/kernel/head.S                  |   4 +
 23 files changed, 756 insertions(+), 197 deletions(-)
---
base-commit: 084c8e315db34b59d38d06e684b1a0dd07d30287
change-id: 20240326-mips_debug_ll-ce72fee1b6a2

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


