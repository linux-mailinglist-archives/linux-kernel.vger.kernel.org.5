Return-Path: <linux-kernel+bounces-8805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF4881BC81
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E881F237E5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1927B5993E;
	Thu, 21 Dec 2023 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oIaXa8H9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8D559909;
	Thu, 21 Dec 2023 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47FBDE0006;
	Thu, 21 Dec 2023 16:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703177940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64g4WXHsmtstsXFWVKn4+jC7SrQnUgEAndJzQ+FYA9s=;
	b=oIaXa8H9AfHKgs3Zfmu8VPmK09bSKs+HtjTMOjRenfZ44LykxNabiA4r4NX3YJW/++hQjx
	R86criDYih8pJkoQ5c5pKQPtbZAwBRYmHtQkR8Rq64WHSmvIGOqJ4iMUUkeYPXKc631cnr
	LbFO7vYXlg9qkgzIsrJ0ueQOqpt8D5vB4NCCLYycBrDJnFtRXk//pfK2JajnoeANTfVLOA
	WHbOI70ihS71u57Zl9ZIuestgOaqYj00AhO0kLyvNAWyg7G7oI4FuBsJdaZ9vEVpSWRtJs
	Dq558tUtybtDXPh3o0iuR4w7bEsUcKvqYCfJ9enC7Vtyipz8vuZy1o120z0xVQ==
Date: Thu, 21 Dec 2023 17:58:57 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Sneh Shah <quic_snehshah@quicinc.com>, kernel@quicinc.com,
 linux-kernel@vger.kernel.org, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Eric
 Dumazet <edumazet@google.com>, Vinod Koul <vkoul@kernel.org>, Jose Abreu
 <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-arm-msm@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [Linux-stm32] [PATCH net-next] net: stmmac: dwmac-qcom-ethqos:
 Add support for 2.5G SGMII
Message-ID: <20231221175857.6d2874ff@device-28.home>
In-Reply-To: <vvlnwiobrgcwuam6lkud2np5xqocj6asjf627j3gekkhm4hfp5@vhdd47fyortm>
References: <20231218071118.21879-1-quic_snehshah@quicinc.com>
	<4zbf5fmijxnajk7kygcjrcusf6tdnuzsqqboh23nr6f3rb3c4g@qkfofhq7jmv6>
	<8b80ab09-8444-4c3d-83b0-c7dbf5e58658@quicinc.com>
	<wvzhz4fmtheculsiag4t2pn2kaggyle2mzhvawbs4m5isvqjto@lmaonvq3c3e7>
	<8f94489d-5f0e-4166-a14e-4959098a5c80@quicinc.com>
	<vvlnwiobrgcwuam6lkud2np5xqocj6asjf627j3gekkhm4hfp5@vhdd47fyortm>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Andrew,

On Thu, 21 Dec 2023 08:30:49 -0600
Andrew Halaney <ahalaney@redhat.com> wrote:

[...]
> 
> Note, I'm struggling to keep up with the standards at play here, so if
> someone else who's a bit more wise on these topics has an opinion I'd
> listen to them. I find myself rewatching this presentation from
> Maxime/Antoine as a primer on all of this:
> 
>     https://www.youtube.com/watch?v=K962S9gTBVM

:)

> If anyone's got any recommended resources for me to read in particular I
> am all ears.

I think Russell and Andrew did a good job clarifying some quirks with
all these standards :

https://elixir.bootlin.com/linux/latest/source/Documentation/networking/phy.rst#L229

There are some more info in Andrew's LPC talk here :
http://vger.kernel.org/lpc_net2018_talks/phylink-and-sfp-slides.pdf

(more phylink related though)

But I agree that this is hard to fully grasp, there are so many
variants everywhere, some standard, some ad-hoc standards, etc.

Maxime

