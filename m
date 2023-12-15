Return-Path: <linux-kernel+bounces-1100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BB6814A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B851C239CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F1C30FB8;
	Fri, 15 Dec 2023 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="PhCzasCn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jMKVAUcd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5A130FAC;
	Fri, 15 Dec 2023 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anarazel.de
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 6592B3200A7D;
	Fri, 15 Dec 2023 09:20:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Dec 2023 09:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702650023; x=1702736423; bh=18qEFRKK3O
	e9XW5rui6ep0d3REKALWXbfxoaAU0FUvc=; b=PhCzasCnYa3AllDgNpCHNZahtL
	Nk4oMW2LkzSd5s2HU9cNeIpcgyCM9pMaCXChkEVp42BdPBkpCwXLkhgr1JRxqZnN
	s7wS23fcp3Pj9Jkk4ncDO0b9RadVi2Wn6dCAj3FqPIOhMiHtD2V5DQzRLy5gZokm
	x1emDEBQCOPbtFG2MDXkB9FTh05exrSxyTMJxP2JC54HpxEUDuNmN4aCnDpzIlIE
	5I3nlTcDOfXfMfdFjm+W3QPiugiix4Hn+QbzUBrwpDcC1SpnpdgVG6CEpjSiFkQU
	JMAHw+wkd3bv26L2WHnoGaEX3ugvbkHMrbHWYM+R+bhTDRhCGcAVtifwutUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702650023; x=1702736423; bh=18qEFRKK3Oe9XW5rui6ep0d3REKA
	LWXbfxoaAU0FUvc=; b=jMKVAUcdNIqSIkPxQ5iRLCI+fvYvX6Y32OzQkRa/n1Pb
	N1X4QQK6X6lcoypDWPrzXjukjDX75WIeHq8Ybx60QQqZNnYTHs5n25TTw4WLbB3D
	TZVWCTu1Bm3iEf6rVlaq54cRWf1eKaF99iR0dVV5acy5W5ApNEphTM+ZTyDVZVR6
	3Wqi5UPb2p+3vYV6ryBiQjXCX+FLO3Vk6PFOC4A20EWEShG0rblGbnLtWOEexbbp
	Xwtj9pIp+XN4cU98Ko6Tft0eZclRLKqXCLANmqSMYdzu+iNN+LIrr6P93/3FVBV2
	xhS9mbDs5cnvT3gmpcgmw1rQrpnaiRgk9YLSMPOETg==
X-ME-Sender: <xms:p2B8ZQAjhymlw8GI3RkHMUA9yahWLtN9jq-dgbwSX_vZc-0eOJHDeQ>
    <xme:p2B8ZSgD8qMH450MpY3LVNLWKStnm1KlvXFKOMGRqM81ZHJwk2SRCw2c5573a5Ied
    xqDBICoVFyBxVtfCw>
X-ME-Received: <xmr:p2B8ZTmgIc1IqEO9PEvpaziGfRdYILjGBk06nIjLGaOcx64H_134HE6R166hYkEppIcItar-grZU8JMXlMVXnhPRI_Mlu-JUaLqWJ1usIuIkqERjarrwSRY9-Kzm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtvddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepvdfffeevhfetveffgeeiteefhfdtvdffjeevhfeuteegleduheetvedu
    ieettddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:p2B8ZWzas_Rxowb2kRWcufhFlu0hRO3s8poBLv8BRsl1EpCQfr42VQ>
    <xmx:p2B8ZVTMpAao1GXJMTpuuNqpOoKFLdzi_oN-IlfDewWjK0VC0HJW2A>
    <xmx:p2B8ZRYUFZpb01_T4PrvR9DdfkTFuoAi1FdDThH4XQxJ1meGpa4O2w>
    <xmx:p2B8ZUFIAyH77oPkH-CjkPMXq9JkhDt_W5MdInR6At-k0LZ3btaTaw>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 09:20:22 -0500 (EST)
Date: Fri, 15 Dec 2023 06:20:19 -0800
From: Andres Freund <andres@anarazel.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Zhang, Rui" <rui.zhang@intel.com>,
	"jsperbeck@google.com" <jsperbeck@google.com>,
	"tip-bot2@linutronix.de" <tip-bot2@linutronix.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Message-ID: <20231215142019.uvih3wlstacqut6o@alap3.anarazel.de>
References: <1e565bb08ebdd03897580a5905d1d2de01e15add.camel@intel.com>
 <87ttonpbnr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttonpbnr.ffs@tglx>

Hi,

On 2023-12-12 18:34:48 +0100, Thomas Gleixner wrote:
> The simple change below should do the trick.

Yep, can confirm that that suffices to boot with all CPUs brought up.

Greetings,

Andres Freund

