Return-Path: <linux-kernel+bounces-166422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0648B9A6B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3711F21BB8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0F6627E2;
	Thu,  2 May 2024 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="IhGIqq0I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a60KI2QL"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6422C76048
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714651625; cv=none; b=u0J7Q4HihhxNks+lFR+ymVkkGLfJ2+3B2vuPBDrJ2f9bZmgu/z1gg9XRZlEwW2Fc8OyU6SEhUf5ZCIIuGDAZrpCh4pujK27bFRsYt9E9AAHsgWM2vHS1JRP6BQo5pBoBaLL3rsKAwDXztylUTnqDE94HIV3W64Csok0GZDeLrBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714651625; c=relaxed/simple;
	bh=8IrV1T9CB7HVTX7Hf4sBrMPMMLE4m4iOalJ7OH9cstY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KtoywL3RiKJIfvhxGAE46KxqutcTy/ILWixosqj4De4AQSdIk/gX1PZukkmT9hBaHFVHQCMit0AhA1rvk15nqyxzG01B3T6hGDQcbxQ4CBfmjWQE83/KNU3s7XsaXrUL3xw++EM9bH1mqfMp4nxInpxl32c8OqNIPPgRPiDkITE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=IhGIqq0I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a60KI2QL; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2D5081140092;
	Thu,  2 May 2024 08:07:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 May 2024 08:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1714651622; x=1714738022; bh=cpgbTJPINWDuCQJJISt3p
	MMPFgRhdl1XPatpsg7wiwk=; b=IhGIqq0IlDnYjXzpQOPDFfN1Hqy3bKNpQZ/8t
	e6N55CokaWKPaD3diPRNc7gXwDfLqRUK201dEeOsxE0ILj/s9BiWiJhACUesCFzC
	9G1A8+zau5gMrg98EPqy72KqdtKqWEpv4rTkPKyhc1gRlXZ97NDi+EXc1PcWq4Fa
	pzcWzvGLWc9hxS3vSMqmRfjElmj2RSDsUbHb8oa6bGbtIM8wj7YKrNg9aVp6NNep
	kFu+W4gvwiqmiQjBuram0xO5iMImeTdOzjqCXHQIdjIHcptGQHnp7BS984WhxnHS
	BPzKeyQtr5JeuG0vinUP//Ud3hbNDTWx60c21V90U2VcVxo1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1714651622; x=1714738022; bh=cpgbTJPINWDuCQJJISt3pMMPFgRhdl1XPat
	psg7wiwk=; b=a60KI2QLZR8VqBq6MUlGmA3acYbHyCqU2ooMtF2B//imRHm3RFJ
	kJ0lFAr4q0HHIgsfGqgzKTinoRcj0fTRKP6uS1GrjT2kU+5jPBy+uVEbsH8b91sy
	NiDrIcLVSvFHepj7C3MZX908U+jsRTO3ufwX4jFv0/v4BcoIHr3pJsa/Ns6yrPO6
	ft3dRQJxd1/OhRbxyLm8o+vYOz+hkXMASF6kfJKTWZ8XYFMtv54+84mh+sa0ELai
	HaJxDe8L3w3XmUN+S305Pa5fRlpefDhppFtbwYRoCGKwSaK+g4IYHQJzJNnpyBBq
	GAgo9pfhmdZkA18mAgxbTCn0ZY4fu3H4ZOA==
X-ME-Sender: <xms:5YEzZsGv6CIlZb6vLAlPo_mbTo1DrbRrFBYFIxOvWEoYGd_h1Scbaw>
    <xme:5YEzZlVX3JbGrF0uUtK9gLAHzTckg1fzvcvgg9RF82_4FviD-7mdBZnYtrJLNkUDF
    qNopVFxQi1d6XXSQnk>
X-ME-Received: <xmr:5YEzZmLlA2LqakGZE8MzRrODdqyqncwgtNmWpXCNFMa_SFu8y7cdhj9go5hUnpkjTKfdqmlNxX2wITjF8qT6J3JmdnLcERglwK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetfeeiteefve
    egvdfggeffheetleejkeekleeugeffffdtgfdtteetkeevvddvgfenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:5YEzZuEi-vJiXAbUNSnbtFsexGARMcJ2v0lP7MkFKV9ufxRCeBrdFQ>
    <xmx:5YEzZiXEhrE9Ze15w-U7vlmr02eYT4zAybkus_EnMJBDI7b6FCeqQA>
    <xmx:5YEzZhNenRM70LNDeN0gyno5r34YuwrRFzqUOFdfI2l0LwUVMVIz5g>
    <xmx:5YEzZp2xp2KZRIOYuhHTjxdbbir8RTryKHUsMwh40Kc1knHYZeziZw>
    <xmx:5oEzZhRTHpBA_0vsIRLEkuP6AD__F0U2dnRvPIXON1l_Gp6XBh2bcLOb>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 08:07:00 -0400 (EDT)
Date: Thu, 2 May 2024 21:06:57 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [GIT PULL] firewire: fixes for v6.9-rc6
Message-ID: <20240502120657.GA121265@workstation.local>
Mail-Followup-To: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit e67572cd2204894179d89bd7b984072f19313b03:

  Linux 6.9-rc6 (2024-04-28 13:47:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.9-rc6

for you to fetch changes up to 09773bf55aeabe3fd61745d900798dc1272c778a:

  firewire: ohci: fulfill timestamp for some local asynchronous transaction (2024-04-29 18:41:00 +0900)

----------------------------------------------------------------
firewire: fixes for v6.9-rc6

The following two driver fixes:

* The firewire-ohci driver for 1394 OHCI hardware does not fill time stamp
  for response packet when handling asynchronous transaction to local
  destination. This brings an inconvenience that the response packet is not
  equivalent between the transaction to local and remote. It is fixed by
  fulfilling the time stamp with hardware time. The fix should be
  applied to Linux kernel v6.5 or later as well.

* The nosy driver for Texas Instruments TSB12LV21A (PCILynx) has
  long-standing issue about the behaviour when user space application
  passes less size of buffer than expected. It is fixed by returning zero
  according to the convention of UNIX-like systems.

----------------------------------------------------------------
Takashi Sakamoto (1):
      firewire: ohci: fulfill timestamp for some local asynchronous transaction

Thanassis Avgerinos (1):
      firewire: nosy: ensure user_length is taken into account when fetching packet contents

 drivers/firewire/nosy.c | 6 ++++--
 drivers/firewire/ohci.c | 8 ++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)


Regards

Takashi Sakamoto

