Return-Path: <linux-kernel+bounces-96971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 813098763F0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C96B21AB8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEEA56746;
	Fri,  8 Mar 2024 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="caqsbDKf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dkRkZUc3"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6392E55E78;
	Fri,  8 Mar 2024 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899493; cv=none; b=T3A6vdUJqPEnJP+WuCVnZHpOrOPzF5ouqhei+JcrgYCz4l9lGT6fFP2+SV8yi0l8Z2RrMIHdeaRd6bty2uxaeE6xG4F9U60nTRkP7gqBar9rfIUQ2SnXR0/0YjAlIWB8U3AWNcEGHHqDZ7nwDqRum3d2FNCCQ/UbbaOmJkYSC2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899493; c=relaxed/simple;
	bh=enJzpMkxpty9ZZFrdBUYmXNvaIBQeUC0olKR1k99CJ0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Bl+kWYgHDgj1iH1f33mkvg3VpQCY5k9LyiuvKW6USNqd/UFHnZhbeS8p73CT0ZKOz1uTvNysglPTYpjAENeYmuYKTgb9IaK7SU8bMzstIB/XYWCAlBarDB18vqB2lh7wTHBtMig05nMN/Z6KOUw/+FJDdSAnrs5x4niPRr7mlNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=caqsbDKf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dkRkZUc3; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 5482E5C0067;
	Fri,  8 Mar 2024 07:04:50 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 08 Mar 2024 07:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709899490; x=1709985890; bh=RKnGe+GTEV
	6c+u5mEN7T/9INXIlRU9V+9PALmdI4oS8=; b=caqsbDKfWyQXdlBJvne1YNI+PG
	4owQLmFjhBobfNPlBnsbMJA0ooi6PC56BElSyrsk29rF9QfNnjB0vSm0mI3DhIQV
	zKcfCKPi5cxLSEAPE8H1sjVDRqRTZiufgPBeeGOkg5sFgb+kNv4C7B5O0HX9SO+b
	UsD+lbJ1vgM2mHZTzddpDTONCdmc5dqgLE4hRYrKiAPIe4SgOB1WbyKVmKEfAbQF
	23sKmgRDfYE2s3kbt5PW7z18Tiwj8evO1kR5PwKCorlS2W1WB72Y2JGTmH4DVgcn
	IibudJLqxUkIlB9ZQJkJ+1ZDQ9NtjoiwJ8WfyM266ZHQ21tpajXtbuUsrU3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709899490; x=1709985890; bh=RKnGe+GTEV6c+u5mEN7T/9INXIlR
	U9V+9PALmdI4oS8=; b=dkRkZUc3y2z7ZKn83ZbrrgzKdoCJ4scJEgt2pil/lRuE
	I0OCbqLifw0OBqjLhWzfP2ov0YI6TPYei99rsvG92sNFhQzPdEIJge2OE1JkLG5S
	m2SdiQU8f/pZmDwJ0k0C9UnXNYHR/JeH0TaHCfZvhR7x9YZFo4oTx4Ervw8prBUn
	uIz3N/f9sFh7U6DTVd6zIH1BsLDC5/gJp9FtmtsUMlcq7QehA6hbPp7n3Zx1G/F5
	lfAhm/7L5G5FlIMw8+L8iCODwTU3LdcA8FC727FL/WhDU87XOQGrHT9CnhI1mkE4
	7QKC0XmijJLFTqPg9KGJswb2dXZQERaiEhdr/gb6Ng==
X-ME-Sender: <xms:4f7qZTyoIhUj1Drd7ogj5tLobTgH8nTGQJCsozpgik132j3HpBavMA>
    <xme:4f7qZbSlLYplzUvtIFmyIUW7a0YWMMrW8wdYNPyCsY7FKB7zTiRh74ZjPaPm9raGa
    h3u3yX2_fc9Q4rD1YY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieehgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:4f7qZdWdn6lInjr8DU9CrwkyH2xEYq65CoeKdtrGQbyFpb4u8n8x3Q>
    <xmx:4f7qZdj9AhzCNetrW-roRPCHIXHuqBO0WTZNLS0FkGRECN5LBVMqVA>
    <xmx:4f7qZVDpuSyswAg_X-zllSL2hUeFhyX_Ep8Lr36eZO1ErcpRNGXYpQ>
    <xmx:4v7qZZtEs0WY8V-esfqBZBpDV4AE5Y1648nBirvNwf_NlObhdCcNEw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 156C7B6008D; Fri,  8 Mar 2024 07:04:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8f69d1f2-0ce3-4851-a784-c76b274dd9ff@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYsVni7x6AuP97i10oxcusUrB4+m2wpM4Z3mTzWsnMz-Mg@mail.gmail.com>
References: 
 <CA+G9fYsVni7x6AuP97i10oxcusUrB4+m2wpM4Z3mTzWsnMz-Mg@mail.gmail.com>
Date: Fri, 08 Mar 2024 13:04:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 linux-mm <linux-mm@kvack.org>, linux-next <linux-next@vger.kernel.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 "Linux Regressions" <regressions@lists.linux.dev>,
 lkft-triage@lists.linaro.org
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Ard Biesheuvel" <ardb@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>
Subject: Re: arm64: WARNING: at mm/vmalloc.c:315 ioremap_page_range
Content-Type: text/plain

On Fri, Mar 8, 2024, at 12:53, Naresh Kamboju wrote:
> The following warning was noticed while boot arm and arm64 devices.
> The below log is extracted from arm64 ROCK Pi 4B while booting and
> another issue is kernel oops noticed while testing selftests:  kvm:
> memslot_perf_test.
>
> 1) WARNING: CPU: 1 PID: 201 at mm/vmalloc.c:315 ioremap_page_range
> 2)  Unable to handle kernel NULL pointer dereference at virtual address
>   Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
>   Kernel panic - not syncing: Oops: Fatal exception in interrupt
>
> Please find steps to reproduce, logs and config file links below.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Warning log:
> -----------
> [   21.074045] ------------[ cut here ]------------
> [   21.074468] vm_area at addr ffffffffc0800000 is not marked as VM_IOREMAP
> [   21.075125] WARNING: CPU: 1 PID: 201 at mm/vmalloc.c:315
> ioremap_page_range (vmalloc.c:?)
> [   21.075854] Modules linked in: industrialio_triggered_buffer
> pcie_rockchip_host(+) coresight kfifo_buf drm fuse backlight dm_mod
> ip_tables x_tables
> [   21.077047] CPU: 1 PID: 201 Comm: (udev-worker) Not tainted
> 6.8.0-rc7-next-20240307 #1
> [   21.077749] Hardware name: Radxa ROCK Pi 4B (DT)
> [   21.078163] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   21.078782] pc : ioremap_page_range (vmalloc.c:?)
> [   21.079197] lr : ioremap_page_range (vmalloc.c:?)
> <trim>
> [   21.086242] Call trace:
> [   21.086464] ioremap_page_range (vmalloc.c:?)
> [   21.086839] pci_remap_iospace (??:?)
> [   21.087192] devm_pci_remap_iospace (??:?)
> [   21.087579] devm_of_pci_bridge_init (??:?)
> [   21.087990] devm_pci_alloc_host_bridge (??:?)
> [   21.088410] rockchip_pcie_probe+0x34/0x30c pcie_rockchip_host

The warning was added by commit 3e49a866c9dc ("mm: Enforce
VM_IOREMAP flag and range in ioremap_page_range.").

This indeed uses a special memory area at a fixed physical address,
but I don't see where the vm_struct comes from.


> # Testing move active area performance with 1 runs, 5 seconds each
> [  353.142236] Unable to handle kernel NULL pointer dereference at
> virtual address 000000000000000a
> [  353.143045] Mem abort info:
...
> [  353.156328] Hardware name: Radxa ROCK Pi 4B (DT)
> [  353.156743] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  353.157369] pc : unmap_region (mmap.c:?)
> [  353.157744] lr : unmap_region (mmap.c:?)
> <trim>
>
> [  353.164918] Call trace:
> [  353.165144] unmap_region (mmap.c:?)
> [  353.165478] do_vmi_align_munmap (mmap.c:?)
> [  353.165873] do_vmi_munmap (??:?)

No idea here, but it seems unrelated to the first one.

Something is wrong with your address decoding, there are no line
numbers.

      Arnd

