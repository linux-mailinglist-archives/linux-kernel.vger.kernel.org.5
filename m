Return-Path: <linux-kernel+bounces-46192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BA5843C00
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BE41C2602B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041F176052;
	Wed, 31 Jan 2024 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="linYKR0L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFSskRoT"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A3D6E2A5;
	Wed, 31 Jan 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696117; cv=none; b=ee7ZPgsNOIG2zr7L82EZvhswrtbdlNiBEhIuuo+LClYECzroIySWlPVCR0q1rsK09txBAM2fBFFojZDCkzny/4OG/+DFU1ccle2JzoV7zcp8yzwDG2ekiBZw0lNoqOZz7FGsjO6FjmvVPwzRwjX2WsePIvVB/eqen/szTicPgA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696117; c=relaxed/simple;
	bh=w/0vv7TrIVCb0F38hakGI6R+FGoVqx4cnrXY1lbUkaw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=SqxW75yQfFBr21b8UnWegPzjytskCpDlltYOmfxYA5oy8/wD7lgC7eSWfnIiKU8Pb6PjN/GHYY5E9XzMmq2QQZQOehXyCG2irHdcLxrtMVPWn08dzAGrmf7P09TspzqhsXbdeVO1D13XYu+5q9BjxjX1NpeNlpkBHKRTL99v6mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=linYKR0L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TFSskRoT; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 0ECEA5C00FD;
	Wed, 31 Jan 2024 05:15:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 31 Jan 2024 05:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706696114; x=1706782514; bh=PIqvIF++O8
	prNRQycSl4yvs3SVb1+7vU4k2CiJh82ow=; b=linYKR0LyGqBh3M5lanjAOuEuZ
	omaiGbbc6Spdg52E+kLUwNSZnT0g/VknKNhG+PU3jp1wLgBNbcFFsXj5aHbuNhOO
	OOsQhVBa5lcdMuJ1xx4QA68wn/zeqrtqkSl4EqPMY3gZnJSc9jPmSi0wi7mD0O9U
	v8k2ORiIpt4xKcRTV8eYey2BmDV9C776BcaGEREoWM7yJmAINYRdSZqQ7Ka03iGd
	+w82j6BX22e+lxUB18S8Ew1KbNUHWfpkPsYROZX83gYkgJlEefxRCr1TFsQhLN/V
	Qx+QbMoACnWtMG3Jml1qHLjHIc+ni3bQXRDODNUE8jqfNmSCBx5e3vB0xekQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706696114; x=1706782514; bh=PIqvIF++O8prNRQycSl4yvs3SVb1
	+7vU4k2CiJh82ow=; b=TFSskRoT5bHEuYQ56uM/KKpe/PIW2urOakSkflYOdaSi
	LxCMxzYlgaLZoroFxVlKxUKGX11MZiuNYX+sZ3YVN+UH8QqBKJ737VV3Da+Ruvt/
	S6gNIs65AdBUOVuc+jkyEnSBGlxUDu0+LcsDOvaEGqcSfB0Enza4dGPcHRm2Nfx0
	C7MRL23WzpBLOwhkjOHmGtVOVc/MPUoW+OgOcqrnjudjsItvclO3PVM5Zy3/ffkr
	yddzV3zLYUkcioedp2G7JpFPuS5/BEsZlSwgPOD/MFpE5CXLgXEkzRp5wQtSfBPH
	KB/uojd5p6UCXl25PDJu7+YHsVJ+fGjmKe0VwYwwOg==
X-ME-Sender: <xms:sB26ZRrljK2vyL7xQVyBlEga_u2-Q2mu_ZJwQRKoHA_g9vDs57VQPA>
    <xme:sB26ZToEwYJTVLKnWzJevpF4m3QWTVDn1L4dQF62DFD7JJ7m6eLWg70hRYQPa67NK
    OazVPOTbzWRNKLBf5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtledguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:sB26ZeNA0z5pqyylBq1yb0e42jwqKTqNxL0Bo5czCN7rwXImd8n66w>
    <xmx:sB26Zc7-ZXwKR70kdAEMYa5v3Gd1VQA0n7TYNEiHhLvEewyPfsV8fg>
    <xmx:sB26ZQ5WhmATJ2LRwwsSaOfzi5_3AAwVKTZjVNM4aE7E7Edrzd_jQg>
    <xmx:sh26ZSTp6M1RZ9IBwZQDPwqDfmc_YHtMkDjFM8NRmF8UQgtUF5lM1g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5D984B6008D; Wed, 31 Jan 2024 05:15:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4ce460c4-00ab-4665-8bfa-6f16cdcb38e3@app.fastmail.com>
In-Reply-To: 
 <LV8PR11MB846358B901CA67965197C4AB8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
References: 
 <LV8PR11MB846358B901CA67965197C4AB8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Date: Wed, 31 Jan 2024 11:14:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Corona, Ernesto" <ernesto.corona@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Cc: "'oleksandrs@mellanox.com'" <oleksandrs@mellanox.com>,
 "Jiri Pirko" <jiri@nvidia.com>, "Castro,
 Omar Eduardo" <omar.eduardo.castro@intel.com>,
 "'omar.eduardo.castro@linux.intel.com'"
 <omar.eduardo.castro@linux.intel.com>,
 "'pombredanne@nexb.com'" <pombredanne@nexb.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "'bbrezillon@kernel.org'" <bbrezillon@kernel.org>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Johan Hovold" <johan@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Joel Stanley" <joel@jms.id.au>, "Palmer Dabbelt" <palmer@sifive.com>,
 "Kees Cook" <keescook@chromium.org>,
 "William Breathitt Gray" <vilhelm.gray@gmail.com>,
 "'federico.vaga@cern.ch'" <federico.vaga@cern.ch>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Tony Luck" <tony.luck@intel.com>,
 "'christian.gromm@microchip.com'" <christian.gromm@microchip.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "'zzyiwei@google.com'" <zzyiwei@google.com>,
 "'rubini@gnudd.com'" <rubini@gnudd.com>,
 "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Mika Westerberg" <mika.westerberg@linux.intel.com>, "Filary,
 Steven A" <steven.a.filary@intel.com>,
 "'vadimp@mellanox.com'" <vadimp@mellanox.com>,
 "'amithash@fb.com'" <amithash@fb.com>,
 "'patrickw3@fb.com'" <patrickw3@fb.com>, "Chen,
 Luke" <luke_chen@aspeedtech.com>,
 "'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>,
 "'rgrs@protonmail.com'" <rgrs@protonmail.com>
Subject: Re: [PATCH 30 1/7] Add JTAG core driver
Content-Type: text/plain

On Wed, Jan 31, 2024, at 00:26, Corona, Ernesto wrote:
>
> +static long jtag_ioctl(struct file *file, unsigned int cmd, unsigned 
> long arg)
> +{
> +	struct jtag *jtag = file->private_data;
> +	struct jtag_tap_state tapstate;
> +	struct jtag_xfer xfer;
> +	struct bitbang_packet bitbang;
> +	struct tck_bitbang *bitbang_data;
> +	struct jtag_mode mode;
> +	u8 *xfer_data;
> +	u32 data_size;
> +	u32 value;
> +	u32 active;
> +	int err;
> +
> +	if (!arg)
> +		return -EINVAL;

Why do you need a different return code for one invalid
pointer, compared to any other invalid pointer? It seems
better to just return the -EFAULT from put_user here.

> +	switch (cmd) {
> +	case JTAG_GIOCFREQ:
> +		if (!jtag->ops->freq_get)
> +			return -EOPNOTSUPP;
> +
> +		err = jtag->ops->freq_get(jtag, &value);
> +		if (err)
> +			break;
> +		dev_dbg(jtag->miscdev.parent, "JTAG_GIOCFREQ: freq get = %d",
> +			value);

These dev_dbg() statements look like this is from
code that is not quite ready. There are sometimes
reasons to leave debug prints in a driver, but those
are usually for events that happen asynchronously,
rather than directly being part of a user call.

I would just remove these all.

> +		if (put_user(value, (__u32 __user *)arg))
> +			err = -EFAULT;
> +		break;

The open-coded typecasts look suboptimal, and the function
is rather long. I would suggest you rearrange the ioctl
handler to

- have one function that takes the correct argument type
  (__u32 __user *arg) for each command

- a 'void __user *' variable in the ioctl function itself
  that has a single cast and passes the pointer to those
  functions.

> +
> +		print_hex_dump_debug("O:", DUMP_PREFIX_NONE, 16, 1, xfer_data,
> +				     data_size, false);

If this is enabled, it looks like userspace can produce
a denial-of-service by sending down gigabytes of data
that end up being printed.

> +static const struct file_operations jtag_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= jtag_open,
> +	.llseek		= noop_llseek,
> +	.unlocked_ioctl	= jtag_ioctl,
> +	.release	= jtag_release,
> +};

You should set

       .compat_ioctl = compat_ptr_ioctl

otherwise this driver won't be able to be used from
32-bit applications.

> +struct jtag *jtag_alloc(struct device *host, size_t priv_size,
> +			const struct jtag_ops *ops)
> +{
..
> +
> +	jtag = kzalloc(sizeof(*jtag), GFP_KERNEL);
> +	if (!jtag)
> +		return NULL;
> +	jtag->priv = kzalloc(priv_size, GFP_KERNEL);
> +	if (!jtag->priv)
> +		return NULL;
> +
> +	jtag->ops = ops;
> +	jtag->miscdev.parent = host;
> +
> +	return jtag;
> +}
> +EXPORT_SYMBOL_GPL(jtag_alloc);
> +
> +void jtag_free(struct jtag *jtag)
> +{
> +	kfree(jtag);
> +}
> +EXPORT_SYMBOL_GPL(jtag_free);

You have two 'kzalloc' but only one 'kfree' here. You
also leak the first allocation if the second one fails.

The usual way to do this is to have a single allocation
of 'sizeof(*jtag) + priv_size' and then point
jtag->priv to 'jtag + 1'.

> +struct jtag_tap_state {
> +	__u8	reset;
> +	__u8	from;
> +	__u8	endstate;
> +	__u32	tck;
> +};

This structure has a padding byte inside, which can
leak kernel information when copied back to userspace.
In some cases (not here) the padding can also lead
to incompatible layouts between architectures.

Just add an explicit padding byte and make sure this
gets properly initialized when copying to userspace
and checked for being zero when copied to the kernel.

> +/**
> + * struct jtag_xfer - jtag xfer:
> + *
> + * @type: transfer type
> + * @direction: xfer direction
> + * @from: xfer current state
> + * @endstate: xfer end state
> + * @padding: xfer padding
> + * @length: xfer bits length
> + * @tdio : xfer data array
> + *
> + * Structure provide interface to JTAG device for JTAG SDR/SIR xfer 
> execution.
> + */
> +struct jtag_xfer {
> +	__u8	type;
> +	__u8	direction;
> +	__u8	from;
> +	__u8	endstate;
> +	__u32	padding;
> +	__u32	length;
> +	__u64	tdio;
> +};

This one is indeed incompatible between i386 userland
and x86_64 kernels, and will need explicit padding between
length and tdio.

> +/**
> + * struct bitbang_packet - jtag bitbang array packet:
> + *
> + * @data:   JTAG Bitbang struct array pointer(input/output)
> + * @length: array size (input)
> + *
> + * Structure provide interface to JTAG device for JTAG bitbang bundle 
> execution
> + */
> +struct bitbang_packet {
> +	struct tck_bitbang *data;
> +	__u32	length;
> +} __attribute__((__packed__));

This one has no implicit padding because of the
__attribute__((__packed__)), but that attribute actually
makes things worse since pointers must be naturally aligned
on most architectures.

The pointer also makes this structure incompatible for
32-bit userspace, so you should use the same u64_to_user_ptr()
trick you have elsewhere, or ideally completely avoid the
extra indirection.

> +/**
> + * struct jtag_bitbang - jtag bitbang:
> + *
> + * @tms: JTAG TMS
> + * @tdi: JTAG TDI (input)
> + * @tdo: JTAG TDO (output)
> + *
> + * Structure provide interface to JTAG device for JTAG bitbang 
> execution.
> + */
> +struct tck_bitbang {
> +	__u8	tms;
> +	__u8	tdi;
> +	__u8	tdo;
> +} __attribute__((__packed__));

Here the __packed__ should have no effect here, what is it for?

> +/* ioctl interface */
> +#define __JTAG_IOCTL_MAGIC	0xb9
> +
> +#define JTAG_SIOCSTATE	_IOW(__JTAG_IOCTL_MAGIC, 0, struct 
> jtag_tap_state)
> +#define JTAG_SIOCFREQ	_IOW(__JTAG_IOCTL_MAGIC, 1, unsigned int)
> +#define JTAG_GIOCFREQ	_IOR(__JTAG_IOCTL_MAGIC, 2, unsigned int)
> +#define JTAG_IOCXFER	_IOWR(__JTAG_IOCTL_MAGIC, 3, struct jtag_xfer)
> +#define JTAG_GIOCSTATUS _IOWR(__JTAG_IOCTL_MAGIC, 4, enum 
> jtag_tapstate)

Enums are not good for interface definitions, just use a __u32 here.
I would also list __u32 instead of 'unsigned int' for the others,
though that makes no practical difference.

> +/**
> + * struct tms_cycle - This structure represents a tms cycle state.
> + *
> + * @tmsbits: is the bitwise representation of the needed tms 
> transitions to
> + *           move from one state to another.
> + * @count:   number of jumps needed to move to the needed state.
> + *
> + */
> +struct tms_cycle {
> +	unsigned char tmsbits;
> +	unsigned char count;
> +};

Maybe also use __u8 here.

> +/*
> + * This is the complete set TMS cycles for going from any TAP state to 
> any
> + * other TAP state, following a "shortest path" rule.
> + */
> +static const struct tms_cycle _tms_cycle_lookup[][16] = {
> +/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
> +/* TLR  */{{0x00, 0}, {0x00, 1}, {0x02, 2}, {0x02, 3}, {0x02, 4}, 
> {0x0a, 4},
> +/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
> +	    {0x0a, 5}, {0x2a, 6}, {0x1a, 5}, {0x06, 3}, {0x06, 4}, {0x06, 5},
> +/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
> +	    {0x16, 5}, {0x16, 6}, {0x56, 7}, {0x36, 6} },

It's not clear if this is part of the user ABI of this specific
driver or if it's just generic information about jtag. My feeling
is that this does not belong into this header if this is something
that an application would use regardless of the kernel
interface.

     Arnd

