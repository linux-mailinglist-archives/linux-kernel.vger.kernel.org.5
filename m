Return-Path: <linux-kernel+bounces-17982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6ED82564C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58428283C2E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9516F2E405;
	Fri,  5 Jan 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="LgdJiDN+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HoVTIDqd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8072E3F0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 131D53200AF7;
	Fri,  5 Jan 2024 10:06:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 05 Jan 2024 10:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1704467175; x=1704553575; bh=2K2USkqagJxxU6TRYwP62
	cHe0PmIb+mqCMNmH0QOAWM=; b=LgdJiDN+OmLTUpmJQW4kP9MRmyUJw3Hn0aC2n
	acKAQEBv4jOyhjbuL/hgwpU35qD43+BpWarvQiz5j5/s/bfmL7Ij5smvD+E+7L3f
	FUQltnqgWeUJi0HPuf85UXh3veTfM+ctz4jkBRzwjvhZAW56fPrBx/wcHrw2wwdJ
	cbDa+tjxqJRYKk8xpunSp21nuNYyVyv11HW9kvjk0ZBuLlPVp3DvfsoJI1sZ2M5N
	rXc5PFzKqSnFxFG4ZbDkVMKlfbxg0lIi5gPxnKTy6G4ujwh1nM+hAvg3fIScwyR8
	oBl3qK7TQUlt0IsSbxuHkCZkj8GTrSCCK4SV5nChB/u/AExOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1704467175; x=1704553575; bh=2K2USkqagJxxU6TRYwP62cHe0PmIb+mqCMN
	mH0QOAWM=; b=HoVTIDqdZljJDyQpU4aaodaV0H1937V6WtvFZEeFa/Vg6I1BwF3
	Etxpuh0HkotKNkorLX4cYb+N8nX/2ntIyqqkddPwPw2E6VeaSBd6GZb4+F6uZArN
	owYftRkdkyqP68h3dLyZBOc9OfI7e4C51uLykGqY42mtN878epFTS3fcdoH7QKpd
	TIEGvTV/tsED/Ky4VDRFyk8FuLEbBvKXfjg/re0NZQYPl6y7GqhqMfU9avICQx0b
	EVcwH3Ut0mxfpkQ6XfnPpUJhrc1MKex4fEvNSM2v/gJ90G23YmluHRcpDFPwmCDS
	EtOs++VEgKGOF4xIhCEn0BuozML8YnCXebA==
X-ME-Sender: <xms:5xqYZYKJ5tmtW4kuD6mAVVUljcG8i0ldzG5vKjxk2-YA_719rrqXdg>
    <xme:5xqYZYJ0ga4bgI0yWh5tuNq9Ic5huOiFVaaCKCNc0IwlOm6g66rMhX886KjsCEW3k
    NkcOnv2-_z6_wuPMkA>
X-ME-Received: <xmr:5xqYZYu_A7cIUPku7oJLJ5ncAVo2_olHB6Ygbj4QI_5GDo0ttQD1Nit97WrqfCCLzziX4HeXiWn7RySkknn3_Cwm_d0g6VwADSo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegledgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetfeeiteefve
    egvdfggeffheetleejkeekleeugeffffdtgfdtteetkeevvddvgfenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:5xqYZVbctq34YAelKNjE8XV3N2m2zswlbACvTBkLyGq73_Q1iiyCvA>
    <xmx:5xqYZfbYXDBChUQ14AVjNShAlObFSzkMKqSVpJpqFf5_C3gdFLhObw>
    <xmx:5xqYZRABJNoOMBg4B0450WmMjEpKC6-wcZfk6iNYpMwlmPOJ8Id23g>
    <xmx:5xqYZQAj1xfv7FvMxjrPqqUynetMbM1l6o3jpqd8YYWxftteq3UItw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jan 2024 10:06:14 -0500 (EST)
Date: Sat, 6 Jan 2024 00:06:12 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] firewire fixes for v6.7-final
Message-ID: <20240105150612.GA15407@workstation.local>
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

Please accept this request for v6.7 final. It includes a patch to
suppress unexpected system reboot which I reported[1]. The issue affects
all versions of Linux kernel which includes 1394 OHCI driver, so I expect
to apply the patch to stable and longterm kernels as well as mainline,
which includes 1394 OHCI driver.

[1] https://lore.kernel.org/lkml/20231105144852.GA165906@workstation.local/

----------------------------------------------------------------
The following changes since commit 610a9b8f49fbcf1100716370d3b5f6f884a2835a:

  Linux 6.7-rc8 (2023-12-31 12:51:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.7-final

for you to fetch changes up to ac9184fbb8478dab4a0724b279f94956b69be827:

  firewire: ohci: suppress unexpected system reboot in AMD Ryzen machines and ASM108x/VT630x PCIe cards (2024-01-05 21:28:08 +0900)

----------------------------------------------------------------
firewire fixes for 6.7-final

This pull request includes a single patch to suppress unexpected system
reboot in AMD Ryzen machines with PCIe card consisting of Asmedia
ASM1083/1085 and VT6306/6307/6308. When 1394 OHCI driver for the card
accesses to a specific register in PCI memory space, the system reboot
often occurs. The issue affects all versions of Linux kernel as long as
the 1394 OHCI driver is included. The mechanism of unexpected system
reboot is not clear, so the driver is changed to avoid the access itself
when detecting the combination of hardware.

----------------------------------------------------------------
Takashi Sakamoto (1):
      firewire: ohci: suppress unexpected system reboot in AMD Ryzen machines and ASM108x/VT630x PCIe cards

 drivers/firewire/ohci.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)


Regards

Takashi Sakamoto

