Return-Path: <linux-kernel+bounces-60391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F25D850455
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC7E2B2442C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C513D564;
	Sat, 10 Feb 2024 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pz3UORl3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KDtIKKjv"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46322B9B3;
	Sat, 10 Feb 2024 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707566335; cv=none; b=QA2XItCPgSuxZqlHznclcz7EeNcydQeMw37dCVjD0OpQClju9bKmxZR7yIKoQe2CBNIs3lc5teaDloosL3cfxLvIzD64OQ3snbLkRxQLf4BK4rmW0XydocYXNLLFUpvzJvI3CbJ1QTwedzClZP2EVGu9995B0nlnhy4aTI+Uefo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707566335; c=relaxed/simple;
	bh=vYQMuEMzves6pmOj9xgmOX65ssgDEFn8L1/0Edk1QWo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=eb63RpFJ3TGywZKFFwZqc695MjwPcWvPvVh1fnpc0n9asaMJ3/uFxfKUbb6qgmN9Y5FDuc8/1Ta0xwZkjCKcwAsnJJuzk33WuBRKyJy5QZ6c+G3HwMLtybwwsGpGsgUxrBAMliy9AYxrNJZ7I4Kiwq2SBZB6O+k3tkOnEAjpgO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pz3UORl3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KDtIKKjv; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 786D63200A98;
	Sat, 10 Feb 2024 06:58:52 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 10 Feb 2024 06:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707566332;
	 x=1707652732; bh=ZPy9EUdoCY9n2s9bJ0x2J1FQ2Yt9OZf5nGGH8unh6Yk=; b=
	pz3UORl3Udp+NL3DEkGEWg7JnDF1uMfrtUs4zlVRQr14auaC1CC4dlih5q+kw6UF
	O1C0ZXpwbY1W2ym96hRwiyhu6lQ5vPU4qKvxc/DBhrtFBxRiUaSgio4p7aARniUk
	zNCUiz9s9qX8ad7ahYzErG7ZACXmEJrOj9zVibvRDF/duwh3jVNHkC2SMPJvl/F5
	vTS7opO70jb8vahJou9nBH0XYyKvvgdN+QT0gPP7w7MgjWBpAFwJnWVLcQETE+sq
	+8q4JPYm2wQyp3SH7S0JYaeOG4MWrZqqYh3/sp7f4h2pNqj7w2p0j7wxFulVPcbN
	v7BLZIVql4AB31JIq6wBXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707566332; x=
	1707652732; bh=ZPy9EUdoCY9n2s9bJ0x2J1FQ2Yt9OZf5nGGH8unh6Yk=; b=K
	DtIKKjv7cmnXrtNK3FhmLoUheLeQsKeVPs0U9Ip+RS+8orzR9DOJBUiO6yyTNFSC
	4TxSMUJErmUOZ7QVmX5cy3hsXe53lmhe4cQhpU4Va7qrni/DkfLczLW/rFgtG9zg
	l75bVvc8vMVop+q7jHojSDKCEyhXDqedZm6LdeS/WF1/EkF7aRP6AvAPk4mrL8+1
	0oU7VqJB383jHALD9IqhlFwwcHvrOMecFBWK2skIRiMowDFJsX5GtkXClUzxHSrW
	HHxdpAlFP2QPIBRqCLGQr0EIszdl0vJRAcR4tySH7mbNaA5nrQOSG8mhNd09LJcY
	D8Zn/z79wVTvRzlsKZOeA==
X-ME-Sender: <xms:-2THZValK6PD3S96N04tAuIREKRx2-4qk-mDmXq79EtKK0SA5m6Kog>
    <xme:-2THZcbFXvfxDjEbxl4IY-M6sng_A6sWVjN1wxllil59-i9-taBvnYWyAEhhGt2AX
    9xiy1JYGWxX8xfKEv4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdelgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:-2THZX9x8nYLVm1-yc9uhG2kP8aZhkojwG_NB9_pnb3FuEp4hI0ocA>
    <xmx:-2THZTrZKX_QqR_H8w7YDugJNsKhrzXTHCspGwVACtKY79dMc-JkQg>
    <xmx:-2THZQpet4ecCwsetdkh6Aq0VhQ5ZgpUtMWC3jlbmfoQqO98nnA61A>
    <xmx:_GTHZZlYaTTKDnT0TJ9qDjv6SNCHOnHz88Pp1qICoVy39Lj1bjfypw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 750DAB6008D; Sat, 10 Feb 2024 06:58:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <87e339bf-6ca9-406a-9f15-d744f90c9c40@app.fastmail.com>
In-Reply-To: 
 <CACRpkdb=aDd+CuJhckE9xZjA4MXRS_BD=qd3sc3Qjnm7CNbATA@mail.gmail.com>
References: <20240125-mmc-no-blk-bounce-high-v1-1-d0f92a30e085@linaro.org>
 <8ca6a46e-551a-4400-965f-f4ad60bff072@app.fastmail.com>
 <Zcaooa0bTKo3OdvV@qmqm.qmqm.pl>
 <CACRpkdb=aDd+CuJhckE9xZjA4MXRS_BD=qd3sc3Qjnm7CNbATA@mail.gmail.com>
Date: Sat, 10 Feb 2024 12:58:30 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Walleij" <linus.walleij@linaro.org>,
 =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: "Christoph Hellwig" <hch@lst.de>, "Ulf Hansson" <ulf.hansson@linaro.org>,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: core Drop BLK_BOUNCE_HIGH
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024, at 00:41, Linus Walleij wrote:
> On Fri, Feb 9, 2024 at 11:35=E2=80=AFPM Micha=C5=82 Miros=C5=82aw <mir=
q-linux@rere.qmqm.pl> wrote:
>
>> > I think it's worth mentioning the cb710 example here, which
>> > uses a platform device as a child of a PCI device and
>> > does not assign a DMA mask nor use DMA.
>> >
>> > This one will see a change in behavior, meaning that the
>> > blockdev buffers are no longer bounced. As far as I can
>> > tell, this is fine because the driver appears to correctly
>> > use the sg_iter infrastructure for mapping data pages,
>> > but it would be good to have this confirmed by
>> > Micha=C5=82 Miros=C5=82aw because this code path has probably never
>> > been tested without BLK_BOUNCE_HIGH.
>>
>> Hi, this driver doesn't do DMA at all, so having DMA mask set or not
>> it should be good as long as the CPU can read/write the buffers.
>
> The only difference is where the CPU have to read/write the
> buffers really, before the change those were all guaranteed to
> be in lowmem (bounced there by the block core), now they can
> also be in highmem, but sg_miter will deal with it for sure.

Yes, that was my point: The sg_miter() code is meant to
handle exactly this case with highmem data, but as far
as I can tell, that code path has never been tested on
32-bit systems with highmem but without BLK_BOUNCE_HIGH.

     Arnd

