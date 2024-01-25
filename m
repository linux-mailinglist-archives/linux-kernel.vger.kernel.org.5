Return-Path: <linux-kernel+bounces-39129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A00183CB31
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3202328CEC1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC88136666;
	Thu, 25 Jan 2024 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="KmE9Igl9"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012851339A3;
	Thu, 25 Jan 2024 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207498; cv=none; b=eK93LR4UPiBfvSJYFQFNSPdvVT0x2sQWmwbcew1y8+bG0y012bbg+nlQynRc0d1ifQ0V5CEGWZxdiF/SZrVQbZbzKfPHTy/U0774DVe9FxqVRP8cMNHOm89RddofMbcuLB72MZK5xboOpjT/A3Mb72/bqFWKlfDxgqBjJQ0krE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207498; c=relaxed/simple;
	bh=5T100LdEWzfnw+YYm0h1x8aoonY4rriPdSCNHs5edGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xot/M6gQgqR70347GUqWhwN/RDfpYJ5arZXyPRYlj7AR9DO36wk4zRk1mVHKROhvTk6xLbJIx3HcwudWK1Zg8GtEC4NpDrMJrnIGZ1xypWxj3+sk4iGRXg6QQeQVKBEsor2xkgP3Rpfm97GJvSnLk5f/scWgtgWF7iw6awf6TFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=KmE9Igl9; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=u4CrcfRRouAam+gtwWUyS4EOA4ggi0EQiB/dLp0zrqw=; b=KmE9Igl9ur6EuxOtRm2zlEbgot
	Y3bbkrUZdnL/BP0h0RHhCuVPNs9nTvysVgfO0bX2GNuxI3GMZS6s3f+tlXgiqKHFl0wHuTZdleNOg
	Zn/wl1s8aIxd58g+gI554jVLQU9PI6wOiA+lV8BbIS13TkGk6mjzHib13aXNiRejZyyhDRN0ZKMQL
	eIrq0PqKa9pwDyImfXu9u34AkYjzIQWSWVrEqHNKeynYDvCr7DfpzFrMKVxHXUfDKz+QHLKHgps7t
	PRDHafOVZfJv+3yeDApsXSPN85ErAK5hBp/Hf2WmniPNX+LkZUZx6fKOhdgvxYHYxqZCYxAiQ5uH2
	CQCWwqPA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rT4VY-000EIW-R1; Thu, 25 Jan 2024 19:31:24 +0100
Received: from [87.49.43.79] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rT4VX-000QQV-PI; Thu, 25 Jan 2024 19:31:23 +0100
From: Esben Haabendal <esben@geanix.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org,  Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  Jose Abreu <joabreu@synopsys.com>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Maxime Coquelin <mcoquelin.stm32@gmail.com>,  Shawn
 Guo <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
  Pengutronix Kernel Team <kernel@pengutronix.de>,  Fabio Estevam
 <festevam@gmail.com>,  NXP Linux Team <linux-imx@nxp.com>,
  linux-arm-kernel@lists.infradead.org,
  linux-stm32@st-md-mailman.stormreply.com,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: stmmac: dwmac-imx: set TSO/TBS TX queues
 default settings
In-Reply-To: <081af630-ab5d-4502-a29a-a8577d414809@linux.dev> (Vadim
	Fedorenko's message of "Thu, 25 Jan 2024 17:11:08 +0000")
References: <cover.1706184304.git.esben@geanix.com>
	<5606bb5f0b7566a20bb136b268dae89d22a48898.1706184304.git.esben@geanix.com>
	<081af630-ab5d-4502-a29a-a8577d414809@linux.dev>
Date: Thu, 25 Jan 2024 19:31:23 +0100
Message-ID: <875xzh6z9g.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27165/Thu Jan 25 10:51:15 2024)

Vadim Fedorenko <vadim.fedorenko@linux.dev> writes:

> On 25/01/2024 12:34, Esben Haabendal wrote:
>> TSO and TBS cannot coexist. For now we set i.MX Ethernet QOS controller to use
>> TX queue with TSO and the rest for TBS.
>> TX queues with TBS can support etf qdisc hw offload.
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
>> index 8f730ada71f9..c42e8f972833 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
>> @@ -353,6 +353,12 @@ static int imx_dwmac_probe(struct platform_device *pdev)
>>   	if (data->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
>>   		plat_dat->flags |= STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY;
>>   +        for (int i = 0; i < plat_dat->tx_queues_to_use; i++) {
>> +                /* Default TX Q0 to use TSO and rest TXQ for TBS */
>> +                if (i > 0)
>> +                        plat_dat->tx_queues_cfg[i].tbs_en = 1;
>> +        }
>> +
>
> Just wonder why don't you start with i = 1 and remove 'if' completely?
> Keeping comment in place will make it understandable.

No good reason for now. Later on, we might have some setup in the same
lop that also applies to Q0. But the init value can be changed at that
point.

>
>>   	plat_dat->host_dma_width = dwmac->ops->addr_width;
>>   	plat_dat->init = imx_dwmac_init;
>>   	plat_dat->exit = imx_dwmac_exit;

