Return-Path: <linux-kernel+bounces-133751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4879389A80F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442831C22B12
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04262CAB;
	Sat,  6 Apr 2024 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="KaEjfSMa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uf/yfG7e"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954124C81
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712365468; cv=none; b=Ymhr2c4BYCxd3VNdSN21m7IPAI+Hd+yUyzVG/Q/LDq27VqgUgOSxZrGlHGhsqhvZbgwN6lOKQ95/o5wY/pksTck9OG9ugdQjtR65G5xJgaNMzMe8s28rg0wyQ7nHKu0ZgczWSVhU3tVqoaYuITuaVT1UmanoeCa/CHv5TzJX0H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712365468; c=relaxed/simple;
	bh=J/SFrCGV6sqtwMRf+6u6rRAJU2v7VuzQfoSzMbDWQmg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q+uU3GjfcshLR+M5UvBJWFG4wx7X0dbi71Yk3BsjKcn34aiDfDfGKdHCdVHmIfRUJJFODR2R1rErJknBQsK/lStMlXAMpZie3jflimlP/6JqwcEOQ8cQ3CD8qw9UreXkyVbrrHBVcBgi586QLEEwEBG2t+v202LjkG0ALzhyvG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=KaEjfSMa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uf/yfG7e; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id CB0951800101;
	Fri,  5 Apr 2024 21:04:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 05 Apr 2024 21:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1712365464; x=1712451864; bh=89U+TdJUj1ZMB4RVMN7/q
	e49kuN6JsPg2Vp2UH9cvuo=; b=KaEjfSMa158SQqfmpSyJMX8NiwyHm8Kzwt3Rc
	c6RrysL1DoSgbELtsz6A1p0DhsCAqmZEtmA6uQdaR/Hd6QVT/ZLuwRyr+fO6Am12
	J3/PllBMLMJP/lrJp+gMTMbeEyMGo3l81SJgDhcCApTWr7tVtAc1QYAbqf10hTYT
	I0ifv0SmKiZi9UCSPVlQFYAwhT3g7V4v5FX5WOggrffBntKc0qc9WBOO8URST3UE
	zz5nU24uG0GfPFkqVdHD9vGQdKiWxUpwnUmtu2ru8N61foGhm4ObY+Ttl8T52Srj
	oXjWVKtZ5lgTe6U1+bv944MUuG24yaP7L73nZkT+UQxgY0eog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1712365464; x=1712451864; bh=89U+TdJUj1ZMB4RVMN7/qe49kuN6JsPg2Vp
	2UH9cvuo=; b=uf/yfG7eNr9YjWcwedFazqg1JeTdYRD+Ac2vd42pYb5dJuvSqgT
	6Z6o6f+PhDhKQHlG2RlwP1R6P8E2y7kZz/ZhR6pOBUS8NFywuI+LKRj0JQYw/fdS
	r79AWL5puTyKXZqehv2Xsx85F6VeW0TglXXyxBh/traFSj94D0MGOnAVe4+BnP6T
	RmpK/C/A4HS4OyqepxXIB8mCjuHOSI0FBNTCu14NWvDwJXq7ZX5gJtjZjxbcbc6w
	5DIhwLB7cXCOGVkXSOu5ios0/uWWRC4ZXvhfaWhp6x7ov23iA8EnyrbuspJyREhA
	bz6x/n4f8VrtFL15c8syFb9N+WEMp0jgNSg==
X-ME-Sender: <xms:mJ8QZrCStbst69IILut2OlO0TYCh3fJxwMvFEJAxxo_ylv09shrpfA>
    <xme:mJ8QZhixTzBL0H_nTUgT8XDxQggre-_0V9fWCuP_5JZ6pgHfa13N4z_vcHOIx6iNK
    nBSQG0kpssTe-QXZho>
X-ME-Received: <xmr:mJ8QZmlPijTT76pkvMh56lOJ5TsQWHDss670OA4vRVZ2_QUECk6s7HvjGYbrgjZs87kybubJe5ImcaPUOsiUFcvAKh0BFmnoIXc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeguddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetfeeiteefve
    egvdfggeffheetleejkeekleeugeffffdtgfdtteetkeevvddvgfenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:mJ8QZtyR6ym9-bUBLGqJZw2EunWE_x4pW0nAKB24yY9fMKQ3ZFJ8EA>
    <xmx:mJ8QZgSHbPn0pHlZW0sSiSTpywpd1W8stPHgSLK4GmLGMfUOG8Eurw>
    <xmx:mJ8QZgaxGSW907T8Cs2_RkMNYts87Wc5kNsZFlFDr10pzwjtfbDX-A>
    <xmx:mJ8QZhRVIbm4a0jVyMs2z6IEaZn3OIVoZ_kiLFhgQ5E1LO0aVPwEfA>
    <xmx:mJ8QZmfxyPKRojDSyf_tLSpMX2FxnByh8WYEhYZByxrugb-a3tCATI9D>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Apr 2024 21:04:23 -0400 (EDT)
Date: Sat, 6 Apr 2024 10:04:20 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] firewire fixes for v6.9-rc2
Message-ID: <20240406010420.GA7197@workstation.local>
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

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.9-rc2

for you to fetch changes up to 752e3c53de0fa3b7d817a83050b6699b8e9c6ec9:

  firewire: ohci: mask bus reset interrupts between ISR and bottom half (2024-04-06 09:36:46 +0900)

----------------------------------------------------------------
firewire fixes for v6.9-rc2

The firewire-ohci kernel module has a parameter for verbose kernel logging.
It is well-known that it logs the spurious IRQ for bus-reset event due to
the unmasked register for IRQ event. This update fixes the issue.

----------------------------------------------------------------
Adam Goldman (1):
      firewire: ohci: mask bus reset interrupts between ISR and bottom half

 drivers/firewire/ohci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)


Regards

Takashi Sakamoto

