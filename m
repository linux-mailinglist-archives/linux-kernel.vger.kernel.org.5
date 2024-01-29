Return-Path: <linux-kernel+bounces-42521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A4D840289
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73327281D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D9A56444;
	Mon, 29 Jan 2024 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="yyS6D+u3"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AA155784;
	Mon, 29 Jan 2024 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523101; cv=none; b=IAuJEVJ1kJ9tK/fzpPbvuhL5IptScjnSyQJAKixvYNZnImeB1bX3QoJTWSoZSGjjI8sGpn56fXdtKzWko680u5/AacO3vAgjGQD4WFjnhzqy2ME0sLBn+vgwrzrMSCfPBkI3yO5VaIHVJBA/iB9nPN9AAxnykcEvQ7ibyCqjdtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523101; c=relaxed/simple;
	bh=aP6nppY5vuDWhdT1EKho5Ztj2YLfKifFJSnO2YmYNGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LcIxr8oMP7bHnwaQz3KbMGI/xIDNY7s5TmwduVDtG99ZDFGF8BcPOzT7XK14FAi+eAM5ocs48yIw35ESEJrnwnMlzIRLTylb2Xzzj538IHZ/ckny10AGwRStfD61mWVbb3N8BRpqvJgxjaTCYIflTvtYJp6FZrHN1HtauFUUzO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=yyS6D+u3; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=F3JBR5y9GKGAqMtonNzwpD3YmZTrMPQTqcJ9HmXVvzc=; b=yyS6D+u3TeFvuc2yHwCeZfP0JR
	OgJzuLndRUYv7v6AM35molg6u0/YwdUERsHc8tZMxqn4K2hr9aEaDYuPlIkH8MsfguYVjxS2jB4p+
	f0zW2O9ytkKSensR9kvABo/dufznu3EUbn5pPFyiUxi6aPMkypV8NRJnHskaOev8kpF9yRVf5pIor
	/JBu+YIOUz4t97i3qloAd31bpDL3fdttH97a8GDHfb229B1FoRwfryShX/KDEZ4MUuCYMBIwVMxJg
	h/SxO4AKTNVlJTzVRYFpCNYUmOa3bpBPeplerPFb3R3Khms9eXPk6uUoM/pE4VuXXMi1ZvPpy2H+o
	sWfhyh5g==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rUObn-0003SD-7S; Mon, 29 Jan 2024 11:11:19 +0100
Received: from [87.49.42.9] (helo=localhost)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rUObm-000XU1-3Y; Mon, 29 Jan 2024 11:11:18 +0100
From: Esben Haabendal <esben@geanix.com>
To: rohan.g.thomas@intel.com
Cc: alexandre.torgue@foss.st.com,  conor+dt@kernel.org,
  davem@davemloft.net,  devicetree@vger.kernel.org,  edumazet@google.com,
  fancer.lancer@gmail.com,  joabreu@synopsys.com,
  krzysztof.kozlowski+dt@linaro.org,  kuba@kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-stm32@st-md-mailman.stormreply.com,  mcoquelin.stm32@gmail.com,
  netdev@vger.kernel.org,  pabeni@redhat.com,  peppe.cavallaro@st.com,
  robh+dt@kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: TBS support for platform driver
In-Reply-To: <20240126173925.16794-1-rohan.g.thomas@intel.com> (rohan g.
	thomas's message of "Sat, 27 Jan 2024 01:39:25 +0800")
References: <87v87g4hmy.fsf@geanix.com>
	<20240126173925.16794-1-rohan.g.thomas@intel.com>
Date: Mon, 29 Jan 2024 11:11:17 +0100
Message-ID: <87plxktpoa.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27168/Sun Jan 28 10:37:47 2024)

rohan.g.thomas@intel.com writes:

> From: Rohan G Thomas <rohan.g.thomas@intel.com>
>
> On Fri, 26 Jan 2024 09:35:01 +0100, Esben Haabendal wrote:
>
>> > +	/* If TBS feature is supported(i.e. tbssel is true), then at least 1 Tx
>> > +	 * DMA channel supports TBS. So if tbs_ch_num is 0 and tbssel is true,
>> > +	 * assume all Tx DMA channels support TBS. TBS_CH field, which gives
>> > +	 * number of Tx DMA channels with TBS support is only available only
>> for
>> > +	 * DW xGMAC IP. For other DWMAC IPs all Tx DMA channels can
>> support TBS.
>> 
>> The Ethernet QOS controllers found in various i.MX socs does not support TBS
>> on TX queue 0. I believe this patch would break the dwmac driver for these
>> platforms.
>
> AFAIU from Synopsys DWMAC5 Databook, all queues support TBS. But TBS
> cannot coexist with TSO. So all glue drivers enabling TBS feature are
> avoiding queue 0 to support TSO. Also packets requesting TSO are
> always directed to queue 0 by stmmac driver.

After re-reading the i.MX8MP documentation, and making a few
experiments, I have to agree with you. Enabling TBS (enhanced
descriptors) for Q0 should be ok on i.MX.

>> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> > @@ -3773,12 +3773,18 @@ stmmac_setup_dma_desc(struct stmmac_priv
>> *priv, unsigned int mtu)
>> >  		dma_conf->dma_rx_size = DMA_DEFAULT_RX_SIZE;
>> >
>> >  	/* Earlier check for TBS */
>> > -	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++) {
>> > -		struct stmmac_tx_queue *tx_q = &dma_conf-
>> >tx_queue[chan];
>> > -		int tbs_en = priv->plat->tx_queues_cfg[chan].tbs_en;
>> > +	if (priv->dma_cap.tbssel) {
>> > +		/* TBS is available only for tbs_ch_num of Tx DMA channels,
>> > +		 * starting from the highest Tx DMA channel.
>> > +		 */
>> > +		chan = priv->dma_cap.number_tx_channel - priv-
>> >dma_cap.tbs_ch_num;
>
> For IPs which don't have tbs_ch_num, this loop goes from 0 to
> number_tx_channel to check if tbs_enable is set by glue driver.
> Existing logic is also the same. Unless you set tbs_en flag of
> queue 0 from the glue driver or dts configuration this patch doesn't
> set tbs flag for queue 0. This is a sanity check to avoid wrong
> configuration for IPs which support tbs only in a few number of
> queues.

Sounds good.

>> > +		for (; chan < priv->plat->tx_queues_to_use; chan++) {
>> > +			struct stmmac_tx_queue *tx_q = &dma_conf-
>> >tx_queue[chan];
>> > +			int tbs_en = priv->plat->tx_queues_cfg[chan].tbs_en;
>> >
>> > -		/* Setup per-TXQ tbs flag before TX descriptor alloc */
>> > -		tx_q->tbs |= tbs_en ? STMMAC_TBS_AVAIL : 0;
>> > +			/* Setup per-TXQ tbs flag before TX descriptor alloc
>> */
>> > +			tx_q->tbs |= tbs_en ? STMMAC_TBS_AVAIL : 0;
>> > +		}
>> >  	}
>
> Please correct me if I've misstated anything.

No corrections for now :)

/Esben

