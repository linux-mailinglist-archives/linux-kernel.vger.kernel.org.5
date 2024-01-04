Return-Path: <linux-kernel+bounces-16640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56778241BA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409EC2861BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68FF219ED;
	Thu,  4 Jan 2024 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="qtMJfZA1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6snWFrcr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377092136C;
	Thu,  4 Jan 2024 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 0FAAC5C0167;
	Thu,  4 Jan 2024 07:26:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Jan 2024 07:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1704371200; x=
	1704457600; bh=Meyf+8HOowsCgjAcne3s8KH81Tf6xBYj/bEm7WmbPCo=; b=q
	tMJfZA1rfcIiQ8X6RgZu4gA+Q9w/l9+txbHbNWsYvav/l6Bh0NVeHijwEOF+34G0
	G0BBIJdjbFUzfeErJzWhiN0X+qvLvsE6onlfP+Abf0Gzq+PYjnejQu9JwuC7ibAU
	Xf2HtLK+1k4ROq/ewFLEcevgWRafSM1Eus8+m/0XmKwx4bcDBSytJzllJj9M9BjN
	y9oghHZEWWjCRkD46+9J3s0H6zSvDi/v8UMsqXFuOmdXgrrCJJuAyg41gAQWuiJL
	R8MpdIxzpfFqo3YV8Uxi7amKBTa35tNwot5nVLvjzJpaQj+lDwj5ECAI2SF8GxMN
	QgIw7p3qdN4mzkWAdKGJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704371200; x=1704457600; bh=Meyf+8HOowsCgjAcne3s8KH81Tf6
	xBYj/bEm7WmbPCo=; b=6snWFrcruHpwi2UbO+b5q/FK3U1BwtvipECnHLW4ys/V
	TPqv2VkYODqqdAM9B4lb1VibdnO/UzRcb91s3yxlYhd1tK13vumo5Y+gQmqvBzRW
	BrQK8gxy9QSQILzGI7xecrcgV11Ql97ubAAgIngZW7NdIZ1q32YFSWAyIyPqKbG2
	ysDSoBxRQP4ddE84z6I+LZRfmjEJm8N7EdPylo2tEHRhkqWnfJqpSo4m3LquM4EN
	5j3fkt9RA9c2SuFZSiX6Fbc4stHJekCCZfi6yB4Kq0LXvsSX0tbXb7SDIiOeZnai
	RMEBSwXSCFZfBRaB1b5DmKMIGEwGrjdeyoXlxAWDsQ==
X-ME-Sender: <xms:_6OWZfldj0zZ68b48xDEI4qo5mJ09BipIeFhYQq3GfzEFW2dNIuuPA>
    <xme:_6OWZS3V-j4dBi4w5EfWcBWJkmU1brChjg8Rdw8Zn4wSu_Gvr63v3T0_lxo8j0_pK
    kAZFh9uyJQvWX1OOhE>
X-ME-Received: <xmr:_6OWZVqKL69TRxksJ2trlxF6TBAhRc0J7XvUI2lDv0dKe1uPP1NtySMYAyzSTWuzzcUxLuzrCRYh2w2zLV3aTOXEGeljPABOX2iU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegjedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggu
    jgesthdtredttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceooh
    dqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhep
    leevffeuteelhfeftddvvdevudelteegkeeghefgtddtieettdevkedtudefjeeinecuff
    homhgrihhnpehsuhhsvgdrtghomhdpkhgvrhhnvghlrdhorhhgpdhsohhurhgtvghfohhr
    ghgvrdhnvghtpdhrvgguhhgrthdrtghomhdplhgruhhntghhphgrugdrnhgvthenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:_6OWZXkwZinPso-f-nI7LyubDs-_LjXK9x-ekuGNt6s7J4_36ZInnw>
    <xmx:_6OWZd0d30ki__Wc8u6NOZ7kGMW467HFGJOLwNcr5NhbUw5Ivy39ig>
    <xmx:_6OWZWvhdpelLQNftBsjf5vkeKYHPFLT1fienqMXBwiUEShKGvy3YQ>
    <xmx:AKSWZWzpc0uvOn6pzH7qSsoZZEMPf7PD2LlOHtBlbTNsIbeWcVru_A>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 07:26:38 -0500 (EST)
Date: Thu, 4 Jan 2024 21:26:35 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] firewire: ohci: suppress unexpected system reboot in
 AMD Ryzen machines and ASM108x/VT630x PCIe cards
Message-ID: <20240104122635.GA350070@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	stable@vger.kernel.org
References: <20240102110150.244475-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102110150.244475-1-o-takashi@sakamocchi.jp>

Hi,

On Tue, Jan 02, 2024 at 08:01:50PM +0900, Takashi Sakamoto wrote:
> VIA VT6306/6307/6308 provides PCI interface compliant to 1394 OHCI. When
> the hardware is combined with Asmedia ASM1083/1085 PCIe-to-PCI bus bridge,
> it appears that accesses to its 'Isochronous Cycle Timer' register (offset
> 0xf0 on PCI I/O space) often causes unexpected system reboot in any type
> of AMD Ryzen machine (both 0x17 and 0x19 families). It does not appears in
> the other type of machine (AMD pre-Ryzen machine, Intel machine, at least),
> or in the other OHCI 1394 hardware (e.g. Texas Instruments).
> 
> The issue explicitly appears at a commit dcadfd7f7c74 ("firewire: core:
> use union for callback of transaction completion") added to v6.5 kernel.
> It changed 1394 OHCI driver to access to the register every time to
> dispatch local asynchronous transaction. However, the issue exists in
> older version of kernel as long as it runs in AMD Ryzen machine, since
> the access to the register is required to maintain bus time. It is not
> hard to imagine that users experience the unexpected system reboot when
> generating bus reset by plugging any devices in, or reading the register
> by time-aware application programs; e.g. audio sample processing.
> 
> This commit suppresses the unexpected system reboot in the combination of
> hardware. It avoids the access itself. As a result, the software stack can
> not provide the hardware time anymore to unit drivers, userspace
> applications, and nodes in the same IEEE 1394 bus. It brings apparent
> disadvantage since time-aware application programs require it, while
> time-unaware applications are available again; e.g. sbp2.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1215436
> Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217994
> Reported-by: Tobias Gruetzmacher <tobias-lists@23.gs>
> Closes: https://sourceforge.net/p/linux1394/mailman/message/58711901/
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2240973
> Closes: https://bugs.launchpad.net/linux/+bug/2043905
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/ohci.c | 51 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

Applied to for-linus branch[1]. I'll send it tomorrow and expect it applied
to the mainline kernel, the latest stable kernel, and the longterm kernels.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git/log/?h=for-linus

Regards

Takashi Sakamoto

