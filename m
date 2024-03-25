Return-Path: <linux-kernel+bounces-116359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2B6889A87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97B35B27073
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D42113AD05;
	Mon, 25 Mar 2024 04:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="KTkaaqjI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qo4Q5kCd"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7C170EAC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 00:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711327302; cv=none; b=Xn6BU1t2YFXJVB7V4jtrhTG6Yo6JQvisDCWqndJ4QWjydSnw0FHDFqHZ67J+rKPMmisInXxvOMNYSmQnOC03kXg6qWMwEN1EGTHA6YqSsIJ+b9HfFIeg6Bxp94p1ThQFrEiDNR2Jek97/C1quDm54ZCcU6dDQLHCMdTL7s0A/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711327302; c=relaxed/simple;
	bh=1R6tsIfyD4FKqYacylId0ehCe60JV+xN2G04+gjdyeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOT+isnmP5b/uwuOZZf/oj+uHzrNIVCzFCrhmLujASUWuasoDc1LH71VPXhDJTnyupIXbwaBk8EoZohnl2M1Jh+reL0/OaGkCba6C7s5EEpTnYluJewlxCtbDG1lheUqs3RJ1yJqmQ772IoNDipxkg/TlGS/QKq4Vfgcx2Fl5OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=KTkaaqjI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qo4Q5kCd; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id CF9C75C004D;
	Sun, 24 Mar 2024 20:41:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 24 Mar 2024 20:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1711327298; x=
	1711413698; bh=Dh+dJEY2gJkF1hs/hYpFYfuFKg28LMybI2iLz5LxJGE=; b=K
	TkaaqjIGBzU26M4F/P0PKnLJlKxDm/gMiENw+SrBVHuPZBN9mFg3jhLt2CTGIOKx
	dc9sZQkhgKsxzNHtQe5YvU6ry2fc4Mn/5zzCr0/weXkkIOO/aJJWLj00z7YPT83X
	+EwygA45GHyViS0xWX/P2tfgkeKgAiMYCYkqvqkw8YQEfeTkenHnnhuhKxTphrBN
	MqVmS8abJ/kkHYREQCMyoP7Isrc4/wox1b/1qNKRTlkd78cImzPG0snR5e2wFAVB
	3O815ZZ90mRSYP9jMtCnSDw0jDhARufD0fYebWojU8oBv8BRFwWwCycxHSF+5nCn
	4BPpkARPOkZf9TN0/C80Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711327298; x=1711413698; bh=Dh+dJEY2gJkF1hs/hYpFYfuFKg28
	LMybI2iLz5LxJGE=; b=Qo4Q5kCd0yAKtC5UZTJrHDhuWA001qerYR1P4tzHFoS6
	cEKo8iwioLuRSm4Ey7hP8knfY4JXOxO36JUBiNj6o9HSYVyPApo3Em4qhlqPoaVh
	kLhdZNgMONYAv2jwsgAyb9zChCimxdBCLSuNXrduByQO0c/bx11X7zaXiyb7Vii6
	zsUKFiYKfIJKHUzJavUXNLSxtCo/RDRz8CrftNdX4TV8lIN14SitYK8HSfCkIQTD
	QQp8s6BjK/q9PRSiWf8XByw6ybCT28D8xWX0Hmxz3OSvUAhFl1G6g7ufdDEmBVhq
	oe9AgsrjjbxzWx+fJxi9z7ppYaHCwCETLFxUxeMsDA==
X-ME-Sender: <xms:QsgAZr39FC7aElUGw604XOdu4epMAaI-kUN6qnuVl0cUk-p42JaxjA>
    <xme:QsgAZqHzGZMLzJYvxii1seljXIuE4_kAYw0Gxc5wepDQbARUPJSZoVFYz__IeHAOE
    ghkdreUp0QtujwmD0U>
X-ME-Received: <xmr:QsgAZr65uyDheMdP617wkbR4r3k3VCsm1Xd0qdTSHMnEhaBLcg0uvhau8c1I7vhK80iUv4C3c0eEQQbrXSE2KMKIpfJh4-DtmuI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
    ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:QsgAZg022tybLCCK14m06uRBbMM9BVOAcuGGVnQyJuJMz7_eANd_HA>
    <xmx:QsgAZuF1uGttxdkhcD1_f-7ypIwr11Cj3e2W3PL3QbR3f3yPHMJ7vw>
    <xmx:QsgAZh_zxOHvJ8QVALS2GQ09REcYa4UeZXZcvwsiXWHM_oSd3OuQMQ>
    <xmx:QsgAZrnveojPZWsAipMaoPuF0_wVr4fgj5H49tVht6e2g2PJkmcInw>
    <xmx:QsgAZqD9hrdHY8oydnffxe4lZmn4UkcwFt73R8MhvLpHy41aIOc2pw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Mar 2024 20:41:37 -0400 (EDT)
Date: Mon, 25 Mar 2024 09:41:34 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Adam Goldman <adamg@pobox.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: option to log bus reset initiation
Message-ID: <20240325004134.GA21329@workstation.local>
Mail-Followup-To: Adam Goldman <adamg@pobox.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Zfqo43xhFluOgO01@iguana.24-8.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfqo43xhFluOgO01@iguana.24-8.net>

Hi Adam,

On Wed, Mar 20, 2024 at 02:14:11AM -0700, Adam Goldman wrote:
> Add a debug parameter to firewire-core, analogous to the one in 
> firewire-ohci. When this is set to 1, log when we schedule, delay, or 
> initiate a bus reset. Since FireWire bus resets can originate from any 
> node on the bus, specific logging of the resets we initiate provides 
> additional insight.
> 
> Signed-off-by: Adam Goldman <adamg@pobox.com>

Thanks for the patch. I applied it to for-next[1].

Now we have two debug parameters per module for the slightly-similar
purpose. In my opinion, it is a pretty cumbersome to enable them when
checking bus-reset behaviour. I think it is time to investigate the other
way.

Linux Kernel Tracepoints[2] is one of options. Roughly describing, the
tracepoints mechanism allows users to deliver structured data from kernel
space to user space via ring-buffer when enabling it by either sysfs or
kernel command-line parameters. Linux kernel also has a command-line
parameter to redirect the human-readable formatted data to kernel log[3].
I think it is suitable in the case.

It requires many work to replace the existent debug parameter of
firewire-ohci, while it is a good start to work just for bus-reset debug.
The data structure layout should be pre-defined in each subsystem, thus we
need to decide it. In my opinion, it would be like:

```
struct bus_reset_event {
    enum reason {
        Initiate,
	Schedule,
	Postpone,
	Detect,
    },
    // We can put any other data if prefering.
}
```

Would I ask your opinion about my idea?


[1] https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git/log/?h=for-next
[2] https://docs.kernel.org/trace/tracepoints.html
[3] 'tp_printk' in kernel/trace/trace.c, 'trace_event' in kernel/trace/trace_event.c

Regards

Takashi Sakamoto

