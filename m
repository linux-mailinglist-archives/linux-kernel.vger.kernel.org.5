Return-Path: <linux-kernel+bounces-112313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470DE88783B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795741C20DFE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A047F17585;
	Sat, 23 Mar 2024 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nlo3uo5j"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5628D12E4E
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711193622; cv=none; b=H/KzhPn2YcFecRh1kKamfMDGHMo1u8DkQqddyaMequdCSfy1SShvVmfNfRq7g6wwJS6XAhWsnsNmrisQTTAjA8A/t64Fd7AEJRnjzTcAFLmO8odwFRW967WB2Ql2t6BbpxxrR1eqvY11+7tHVQA130RQ8TKyunjlPn3fmvYZSPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711193622; c=relaxed/simple;
	bh=lVMTPBer1GBC0aTfV+tnwQGV28AQ0c+Wn1dED58wnnA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4kRwDLjz9MvQx9QpwBlZPEm9+xIHNZSxmdVK3Vx4Z5OBRTChHP7xVua+rhSBRa7/+3ZLBXUomXlSBS8IFsrng2tkS0bVLxjMhbxjOfHn3GWHda5OOkGDHlVcvur6B7ZmMEG+zV+yfEOFa8SuIltmKCQLnlHP/BLZRGmK1EQe5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nlo3uo5j; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=cxg2ykibv5bgfaxqtmlv6yvxne.protonmail; t=1711193617; x=1711452817;
	bh=sbVf4Q+GEkWRKl3AKJdJ5EZhyVY97cY1z0wDeX4RD08=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nlo3uo5jwFPV3LASuBdaa9tVkJKHDJCB94VS22/mtbkuqjcIowj7yS2BfgxC48L3v
	 2DQGRppJKjlv0EJO/8XDfp1POJ516p/CoNAHURwASRN3LsuQqNPvIc5wSo7RtGtmbB
	 ZNIw8OTenu2gsrOZ8RNgQhjGOUy7GuAQzrab9naDx+ZYQXbMSRgZxlp1R5P52L5zmE
	 UfyoFdwzx7U+FiATuaoQy+4dh97ISrkjkNAh5IUXPfbx74L8yg07wD61zbCjMMh25d
	 pkV84OSACZzeAS31YlS5hW3mObB21Mk1CMUR7cq8hp3ps1u74V6HWOqSqrDTiNo6a4
	 x5Z1ZeWYqSOhg==
Date: Sat, 23 Mar 2024 11:33:26 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez
	<da.gomez@samsung.com>, open list <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 4/5] rust: block: add rnull, Rust null_blk implementation
Message-ID: <QqpNcEOxhslSB7-34znxmQK_prPJfe2GT0ejWLesj-Dlse1ueCacbzsJOM0LK3YmgQsUWAR58ZFPPh1MUCliionIXrvLNsOqTS_Ee3bXEuQ=@proton.me>
In-Reply-To: <20240313110515.70088-5-nmi@metaspace.dk>
References: <20240313110515.70088-1-nmi@metaspace.dk> <20240313110515.70088-5-nmi@metaspace.dk>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/13/24 12:05, Andreas Hindborg wrote:
> +module! {
> +    type: NullBlkModule,
> +    name: "rnull_mod",
> +    author: "Andreas Hindborg",
> +    license: "GPL v2",
> +    params: {
> +        param_memory_backed: bool {
> +            default: true,
> +            permissions: 0,
> +            description: "Use memory backing",
> +        },
> +        // Problems with pin_init when `irq_mode`

Can you elaborate?

--=20
Cheers,
Benno

> +        param_irq_mode: u8 {
> +            default: 0,
> +            permissions: 0,
> +            description: "IRQ Mode (0: None, 1: Soft, 2: Timer)",
> +        },
> +        param_capacity_mib: u64 {
> +            default: 4096,
> +            permissions: 0,
> +            description: "Device capacity in MiB",
> +        },
> +        param_completion_time_nsec: u64 {
> +            default: 1_000_000,
> +            permissions: 0,
> +            description: "Completion time in nano seconds for timer mode=
",
> +        },
> +        param_block_size: u16 {
> +            default: 4096,
> +            permissions: 0,
> +            description: "Block size in bytes",
> +        },
> +    },
> +}

