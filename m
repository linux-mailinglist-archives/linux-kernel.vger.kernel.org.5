Return-Path: <linux-kernel+bounces-5700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983E7818E4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB55E1C23EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ECA347DF;
	Tue, 19 Dec 2023 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="1PQkSO/1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FYaEq0od"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3263174A;
	Tue, 19 Dec 2023 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id D58053200A07;
	Tue, 19 Dec 2023 12:38:42 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 19 Dec 2023 12:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1703007522; x=1703093922; bh=NZGyZihxFa
	h0LL7yYJRdhv/PPbzAuX/RXJJmr8N6IHg=; b=1PQkSO/1PQdZRqyoCNcqArta9n
	Ec305g4d+0BssKdPN8wGztEY33kNNdnhhBFmkvfaGLW7TaslN9Cv6i6bwtz+gSFl
	SejRQ2neCctLguXSRp2qdqAmVJGNCqALR8qdIknw0lfrwqeqcC0z0QCoLAPlISUX
	v63aJxujrVJ1I2bPt9IFwpxZYbo+zr4mXz7SBFYGkzC6bFVTCigOOSxopJsVrnya
	57VglgS6xgJcIqwDd4zLNp4QWuCFSkm3Eb8KpaHvb2ERwp5uiVEJ65Bwnspy09O7
	FnxQwSLq3q9mOf7jYSwMYy/u+hsRRX7qeuW5wmyYmglwihoz+p/2lr7ySVjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703007522; x=1703093922; bh=NZGyZihxFah0LL7yYJRdhv/PPbzA
	uX/RXJJmr8N6IHg=; b=FYaEq0odw552hYEyGxn66AqospWQNmq2tOXybUDjJTqL
	AZWowKlaEbI30KaIFk77Zz5e6XKxD8Yw8bSqJx4/f3nwHV3h3xj1v/HMQzZO2wJW
	r1AUFjH1dkjlc8Mw+ezNh0DyKQOZwI5HLSBg2wcnolpREJManunxzJXAMjlbEHKE
	+fp1iMqG8GoI9of3BotOoNp61V4al81ppocF6gPU8ynL9fKWgru5RsKFuFXT/bMD
	gplFcRqfNIs+54adFQ53zvBbDp0fB8FMbi7L+SIt+8amn9EM8E5YgsQ8cG0PAH/J
	iFwbMbMqNgvP+ZRGEVdomn40De4vnq8IRbliG2ybsw==
X-ME-Sender: <xms:IdWBZbK5tXBepbZsjjh6J30xz7PbZzzob0kOp89V7hXZ--KGZMUvXg>
    <xme:IdWBZfIYRBZAmZzKjIVpCpRRzgXxw3gAGe_bQjsH7pk4idvwjg2JQ1MbVa-kBLPdC
    6KMgLlqQXTpH4c4f_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddutddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:IdWBZTtj4HtLvhrVXyvMx93jLyQaFSiLmwsrB9d_ECv2JpXffj0rnQ>
    <xmx:IdWBZUau-EAEnzxeyixGrsspBAtKPp0HVS8N03vMwnp68xmEW16o0g>
    <xmx:IdWBZSbcQK_WUf_PIckvV60woL_K7-85GuMxz9nNwQckV-SzxvxBnw>
    <xmx:ItWBZXPvrJl1BdYOKERUaSECLFW36Aatgt016P0ZAL0n1dTgfqCQSQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B655CB6008F; Tue, 19 Dec 2023 12:38:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1350-g1d0a93a8fb-fm-20231218.001-g1d0a93a8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fcb410dd-f042-4469-9319-040c26099b2b@app.fastmail.com>
In-Reply-To: <20231218061201.98136-2-joshua.yeong@starfivetech.com>
References: <20231218061201.98136-1-joshua.yeong@starfivetech.com>
 <20231218061201.98136-2-joshua.yeong@starfivetech.com>
Date: Tue, 19 Dec 2023 17:38:23 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Joshua Yeong" <joshua.yeong@starfivetech.com>,
 jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com,
 "Jassi Brar" <jassisinghbrar@gmail.com>, "Rob Herring" <robh+dt@kernel.org>,
 krzysztof.kozlowski+dt@linaro.org, "Conor Dooley" <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mailbox: starfive: Add StarFive Meu Mailbox Driver
Content-Type: text/plain

On Mon, Dec 18, 2023, at 06:11, Joshua Yeong wrote:
> This patch adds support for the StarFive Meu Mailbox driver. This enables
> communication using mailbox doorbell between AP and SCP cores.

I think the naming here is a bit confusing. As far as I can tell, this
is not a mailbox at all but just a doorbell, so maybe clarify that in the
wording.

It could be turned into a mailbox if you add a shared memory segment of
course, but neither the driver nor the binding specifies how to use that.

> +config STARFIVE_MEU_MBOX
> +	tristate "Starfive MEU Mailbox"

Please spell out MEU here, I don't think that is a well understood acronynm,
at least I have never heard of it.

> +	depends on OF
> +	depends on SOC_STARFIVE || COMPILE_TEST
> +	help
> +	  Say Y here if you want to build the Starfive MEU mailbox controller
> +	  driver.
> +
> +	  The StarFive mailbox controller has 2 channels. Each channel has a
> +	  pair of Tx/Rx link and each link has 31 slots/doorbells.

What is the significance of the "channels" as opposed to "slots"?

The binding seems to indicate that there are just 62 fully equal
doorbell channels as far as consumers are concerned. For efficiency
one might want to of course only use one doorbell per channel here
to avoid the interrupt sharing.

> +static inline struct mbox_chan *
> +meu_db_mbox_to_channel(struct mbox_controller *mbox, unsigned int 
> pchan,
> +		       unsigned int doorbell)
> +{
> +	struct meu_db_channel *chan_info;
> +	int i;
> +
> +	for (i = 0; i < mbox->num_chans; i++) {
> +		chan_info = mbox->chans[i].con_priv;
> +		if (chan_info && chan_info->pchan == pchan &&
> +		    chan_info->doorbell == doorbell)
> +			return &mbox->chans[i];
> +	}
> +
> +	return NULL;
> +}

If the number of doorbells is known in advance, maybe use
use it as the array index here?

> +static void meu_db_mbox_clear_irq(struct mbox_chan *chan)
> +{
> +	struct meu_db_channel *chan_info = chan->con_priv;
> +	void __iomem *base = chan_info->meu->mlink[chan_info->pchan].rx_reg;
> +
> +	writel_relaxed(BIT(chan_info->doorbell), base + CHAN_CLR_OFFSET);
> +}

Any reason to use writel_relaxed() instead of writel() here? Please
add a comment if this is necessary, otherwise this risks adding
races if someone tries to use the doorbell in combination with
shared memory.


> +static struct mbox_chan *
> +meu_db_mbox_irq_to_channel(struct starfive_meu *meu, unsigned int 
> pchan)
> +{
> +	void __iomem *base = meu->mlink[pchan].rx_reg;
> +	struct mbox_controller *mbox = &meu->mbox;
> +	struct mbox_chan *chan = NULL;
> +	unsigned int doorbell;
> +	unsigned long bits;
> +
> +	bits = FIELD_GET(CHAN_RX_DOORBELL, readl_relaxed(base + 
> CHAN_RX_STAT_OFFSET));
> +	if (!bits)
> +		/* No IRQs fired in specified physical channel */
> +		return NULL;
> +
> +	/* An IRQ has fired, find the associated channel */
> +	for (doorbell = 0; bits; doorbell++) {
> +		if (!test_and_clear_bit(doorbell, &bits))
> +			continue;

There is no need to use atomic updates on stack variables. Just
use for_each_set_bit() to do the loop here.

> +		chan = meu_db_mbox_to_channel(mbox, pchan, doorbell);
> +		if (chan)
> +			break;
> +
> +		/* Clear IRQ for unregistered doorbell */
> +		writel_relaxed(BIT(doorbell), base + CHAN_CLR_OFFSET);

Again, add a comment about the use of _relaxed() here.


> +static bool meu_db_last_tx_done(struct mbox_chan *chan)
> +{
> +	struct meu_db_channel *chan_info = chan->con_priv;
> +	void __iomem *base = chan_info->meu->mlink[chan_info->pchan].tx_reg;
> +
> +	if (readl_relaxed(base + CHAN_TX_STAT_OFFSET) & 
> BIT(chan_info->doorbell))

The readl_relaxed() again prevents the use of shared memory, so
change it to a normal readl() or add a comment about how ordering
is maintained.

     Arnd

