Return-Path: <linux-kernel+bounces-89616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D1B86F317
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 00:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F75E284135
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 23:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0359A5381B;
	Sat,  2 Mar 2024 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="oc0dp8ab";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K2nkRAUf"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7842AAA
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709421170; cv=none; b=ZfUD1x3NxSq9whZopQ36M6jBFvTZIKHJdkHytNt5BdrB0lX8/JxAvjnmRwWT5OLlTzcFpfrfDsSuFC6eJMGSmwA48H+UeLmvkJFpb6pAHfIDq9xflvlUJGX6J0tC2zsjyiaKA8aCGcMBHSjnLUKO9ih5iRNGQZdAR8PYq+S2zJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709421170; c=relaxed/simple;
	bh=GvvduoDWaWn9UZgFOtEKrLOkFObRw6HRsI3S3jn/B6A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eI8uCKqn0XTvcW/WxrbzhA42tvtgKnvcMhLVsB5SkPIFQ0UA6ItKoOpeGg/PG0cl4yeH8OvQIe0JHJ81zEsK+qAm40NPA9MaMiTks65XVQc0dNi5mPfIETN9YU0QcUSqvw2nbyxCUoxovXx3yAflEQqOAY325s+SSQebRw2Rb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=oc0dp8ab; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K2nkRAUf; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id B2AF71380091;
	Sat,  2 Mar 2024 18:12:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 02 Mar 2024 18:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1709421166; x=1709507566; bh=xEa8U+fcdtQZXtTPQc0i1
	7UZcUYa94v4oI4hRUw1s84=; b=oc0dp8abhl9nuV+c1yROa+gKocTMl8+ZKO/GZ
	c7tXfXl56dF31MnL5mWFaYCNC+PErGEBHfO6XWpEaOe5pHfzjH30rWIgfDgmjKXe
	zuh19jtcMt4QfyCaeoQ2S+sKKEoZsrclmJj4oc8heK6fLzwhB1j1az2HQZEnl/em
	cIuX8yZhnGAWDqjKtSD15HzE9auoZg0tpQoCv7GiGmcumcy2hp4jDQ7as4ELd8Cn
	ADkJryOLs8RHIbD/Od0bWEecM0ODkKnUOk1+IthR4HfQo/pSG+TYWxHHtPRptBXQ
	oLMhIECMFHFH35usqJ/nyHP47UjynRMZ/jnn9IZG78pEs7BHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1709421166; x=1709507566; bh=xEa8U+fcdtQZXtTPQc0i17UZcUYa94v4oI4
	hRUw1s84=; b=K2nkRAUf3CK/lqyKy3tTWnYdcEf4wJXJn6psneS6Q+HGcd+QWsm
	CgZ0mHInEESx4Jl1NOYgYz1h5Wxm713arWGdEKPhaqSzwp0tfnxM8n2mnwtarJfv
	H8UlTcVuMdIrQjX5X1PVM3jVLYBnJXJdj/GZShS5E12dy0vBTLNspPptvDktYlnF
	4oD9druEwa6DDkxfPVD0q1n30rNXlljHCrEeIfp4i4ICSFsJmNLcW/cd7Vci1YRy
	zLkbXhFBNVxr/Jj/P4bC1qnTqhCqzCkAqONJleb4DWXd1emIH/1GWFIEmk4go3x7
	+OV/dxQ/Uyzjf01gwCcGVgP98dnzGyem2Dw==
X-ME-Sender: <xms:brLjZYBxQrXrAM3zGHz9fyyfBI6h_gbtPFTroygEkxUHzle81OOLBQ>
    <xme:brLjZahvOcn-59gMYoIfXoFERYhsqyoS1ko7xxvrjqgpm0WwivDjaRZ01IL9N5POP
    wEZj5-4SODCBXrsAkU>
X-ME-Received: <xmr:brLjZbnSBd57EnUCKOuQy60yt3vVIffRBzls16tJOzEycBNQovcywNleN_sC2FfZlmBbHNGWEeE3R1kMnm65MkR88WYzMN_VBY4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheeggddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesthdtredttd
    dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepteefieetfeevge
    dvgfegffehteeljeekkeelueegfffftdfgtdetteekvedvvdfgnecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:brLjZexaPLlrQWu9ypWqyaNA1PixAQw1k8kq_vl4Fzn3TFlyz2yFvQ>
    <xmx:brLjZdSCNs78AGsM0AsL3Vjpi5Tn9DeoACrscuiDnhjUUVpXFCmOJQ>
    <xmx:brLjZZbIFruwQzX2DEgAGOcvJB3weXDjcuZlTVxI1XHkoTQaRJogKA>
    <xmx:brLjZYeWt8HsWZiWSczJ7V30N_38NWV0umitXaBoWkjzRatdQsJbhw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Mar 2024 18:12:45 -0500 (EST)
Date: Sun, 3 Mar 2024 08:12:42 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] firewire fixes for v6.8-rc7
Message-ID: <20240302231242.GA33788@workstation.local>
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

Please pull the following fixes for the next RC from firewire tree.

We have identified a long-standing issue involving continuous bus resets
in some older devices (e.g. DV camera manufactured in the late 1990s).
After thorough investigation, Adam Goldman has finally figured out the
underlying mechanism.

The problem arises in environments where both IEEE 1394:1995 PHY and
IEEE 1394a-2000 (or later) PHY exist. It is triggered by the short bus
reset defined in IEEE 1394a-2000. The current implementation of firewire
stack uses this short bus reset to solve the gap count mismatches in the
certain generation of bus topology, and causing the issue.

As a workaround, we decided to use the long bus reset instead. I anticipate
that the workaround will also be applied to the stable kernel and the
longterm kernels.


The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.8-rc7

for you to fetch changes up to d0b06dc48fb15902d7da09c5c0861e7f042a9381:

  firewire: core: use long bus reset on gap count error (2024-02-29 22:18:14 +0900)

----------------------------------------------------------------
firewire-fixes-6.8-rc7

A workaround to suppress the continuous bus resets in the case that older
devices are connected to the modern 1394 OHCI hardware and devices

In IEEE 1394 Amendment (IEEE 1394a-2000), the short bus reset is added to
resolve the shortcomings of the long bus reset in IEEE 1394-1995. However,
it is well-known that the solution is not necessarily effective in the
mixing environment that both IEEE 1394-1995 PHY and IEEE 1394a-2000 (or
later) PHY exist, as described in section 8.4.6.2 of IEEE 1394a-2000.

The current implementation of firewire stack schedules the short bus
reset when attempting to resolve the mismatch of gap count in the certain
generation of bus topology. It can cause the continuous bus reset in the
issued environment.

The workaround simply uses the long bus reset instead of the short bus
reset. It is desirable to detect whether the issued environment or not.
However, the way to access PHY registers from remote note is firstly
defined in IEEE 1394a-2000, thus it is not available in the case.

----------------------------------------------------------------
Takashi Sakamoto (1):
      firewire: core: use long bus reset on gap count error

 drivers/firewire/core-card.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)


Thanks

Takashi Sakamoto


