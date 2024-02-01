Return-Path: <linux-kernel+bounces-47775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE2A8452A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F69B247A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DD415A49E;
	Thu,  1 Feb 2024 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="pzkZFjMj"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BC5157056;
	Thu,  1 Feb 2024 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775983; cv=none; b=ePgty8vlItjmcyLrF5ly9+4KkhP46a4S6WpdbVwfS9K0RahJOI5qmZivuuxPVFr2CsVYgYCWjtWZKbNFh/egUCNgXCk7qyVAnm8yAi/vNecm6LrKEuSyg+5NB0bKc1Tg3yRB27eOM5QzLg67z3CFNiAxphjSCbROHUyTGt+h278=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775983; c=relaxed/simple;
	bh=L7J9l+tQr12cszugiTQ2/jJwHQL4P8qY+gS5EWtcA+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LhVFE0iHLLmA0l2+yfx37CA4NFl3+1UbzC4BiJouZ2BQm11XQQvp1tz5c9sZq7PHBcngohW2YrIoHDcZWj9EsIcdv+o52qplG0ocPegghK+7FZnRDmgNryq1bDTtd7YqGQkCLiBWFrAZgenpcybKCoqdT7pAlaj49ys2QTIwWJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=pzkZFjMj; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=L7J9l+tQr12cszugiTQ2/jJwHQL4P8qY+gS5EWtcA+I=; b=pzkZFjMjeqS+UrlgihHusc+0EJ
	JlY8keQHJE1OXGauS1N85D/qEI8+OLJM3JYseJ8XnEZi/jWjEwvvcGL1z/GnJtvZT5VKsGrRPQ79C
	gNAC0D1Q8IP1uKxg5ye1BDOCx2rZo3tFr3Fmm725VznEsgkcFSf1cp1MzMKzEHC9kXdp9JVTPZjZj
	2c7m8lOqiylRf7VskVGkaYjeT88XVwhHpCt/IAoXeJtrFENe4cRj39ux2EcK9kwqqXQ9A1UIATO77
	xlpmqYlrvhqe3eCnvstZtrGUgWSHZ3lV6eGKkHwXZmLPTlu2WWuNKcbu6xHA0oBhd1MqcNwGC0KW9
	Mweamwgw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rVSOe-000JUV-54; Thu, 01 Feb 2024 09:26:08 +0100
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rVSOc-0002s1-1r;
	Thu, 01 Feb 2024 09:26:06 +0100
From: Esben Haabendal <esben@geanix.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: Rohan G Thomas <rohan.g.thomas@intel.com>,  "David S . Miller"
 <davem@davemloft.net>,  Alexandre Torgue <alexandre.torgue@foss.st.com>,
  "Jose Abreu" <joabreu@synopsys.com>,  Eric Dumazet <edumazet@google.com>,
  "Jakub Kicinski" <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Maxime Coquelin <mcoquelin.stm32@gmail.com>,  Rob Herring
 <robh+dt@kernel.org>,  "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Giuseppe Cavallaro <peppe.cavallaro@st.com>,  "Serge Semin"
 <fancer.lancer@gmail.com>,  Andrew Halaney <ahalaney@redhat.com>,
  <elder@linaro.org>,  <netdev@vger.kernel.org>,
  <linux-stm32@st-md-mailman.stormreply.com>,
  <linux-arm-kernel@lists.infradead.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <quic_bhaviks@quicinc.com>,
  <kernel.upstream@quicinc.com>
Subject: Re: [PATCH net-next 2/2] net: stmmac: TBS support for platform driver
In-Reply-To: <5626e874-066c-4bf2-842d-a7f3387b6c1b@quicinc.com> (Abhishek
	Chauhan's message of "Wed, 31 Jan 2024 13:59:20 -0800")
References: <20230927130919.25683-1-rohan.g.thomas@intel.com>
	<20230927130919.25683-3-rohan.g.thomas@intel.com>
	<92892988-bb77-4075-812e-19f6112f436e@quicinc.com>
	<87r0i44h8v.fsf@geanix.com>
	<5626e874-066c-4bf2-842d-a7f3387b6c1b@quicinc.com>
Date: Thu, 01 Feb 2024 09:26:06 +0100
Message-ID: <87a5okvbdt.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27171/Wed Jan 31 10:46:17 2024)

"Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com> writes:
> On 1/26/2024 12:43 AM, Esben Haabendal wrote:
>> "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com> writes:
>>
>>> Qualcomm had similar discussions with respect to enabling of TBS for a
>>> particular queue. We had similar discussion on these terms yesterday
>>> with Redhat. Adding Andrew from Redhat here
>>>
>>> What we discovered as part of the discussions is listed below.
>>>
>>> 1. Today upstream stmmac code is designed in such a way that TBS flag
>>> is put as part of queue configurations(see below snippet) and as well
>>> know that stmmac queue configuration comes from the dtsi file.
>>>
>>> //ndo_open => stmmac_open
>>> int tbs_en = priv->plat->tx_queues_cfg[chan].tbs_en;(comes from tx_queues_cfg)
>>>
>>> /* Setup per-TXQ tbs flag before TX descriptor alloc */
>>> tx_q->tbs |= tbs_en ? STMMAC_TBS_AVAIL : 0;
>>>
>>> 2. There is a no way to do this dynamically from user space because
>>> we don't have any API exposed which can do it from user space
>>
>> Not now. But why not extend ethtool API to allow enabling TBS for
>> supported controllers?
>
> ethtool API can be implemented but that still doesn't solve the
> problem of stopping the entire MAC block because of enhanced desc
> allocation.

I am not sure what you exact point is here.

If you look at the implementation of ethtool API for changing ring
parameters, you have stmmac_set_ringparam() which calls
stmmac_reinit_ringparam(), which again calls stmmac_release() if the
interface is up (stopping the entire MAC), and then stmmac_open() which
reinitializes everything.

The same pattern could be applied to changes to enable enhanced
descriptor allocation.

I don't see why that will not be acceptable. Why would anyone have to do
that while critical traffic is flowing? In your system you should be
able to know which queues needs enhanced descriptors before starting
communication.

> 1. We can either allocate enhanced desc for all channels at bootup and
> then choose to switch to enable TBS mode at runtime (Additional memory
> usage)

A good default would IMHO be to enable enhanced descriptors for all but
TX queue 0. This will allow use of TBS without needing to change
anything. If the rather minimal extra memory usage is disturbing anyone,
then they can tune it at boot time before bringing the interface up.

> 2. Live with the disruption of traffic for a brief duration of time.
> Which is not a good solution for priority and critical traffic.

As mentioned above, I don't see why anyone would need to modify the
descriptor allocation while critical traffic is flowing.

If you are able put this information in your device tree, you definitely
will be able to put it in an boot script in some form.

>>> and also TBS rely on special descriptors aka enhanced desc this
>>> cannot be done run time and stmmac has to be aware of it before we
>>> do DMA/MAC/MTL start.
>>
>> Isn't this somewhat similar to changing the RX/TX ring parameters,
>> which I believe also is quite difficult to do at run time, and
>> ethtool therefore requires the interface to be down in oroer to
>> change them?
>>
>>> To do this dynamically would only mean stopping DMA/MAC/MTL realloc
>>> resources for enhanced desc and the starting MAC/DMA/MTL. This means
>>> we are disrupting other traffic(By stopping MAC block).
>>
>> Yes. But you would be disrupting traffic less than by requiring a
>> complete reboot of the target which is needed if the devicetree must be
>> changed.
>>
> any DTS solution today anyway requires completely loading the boot
> image and rebooting the device, but once the device is functional, End
> user can activate TBS, as he knows the exact usecase and requirements.
> I understand the solution is not scalable, but at this point we don't
> have a solution to activate TBS at runtime.

Exactly. We are discussing a solution to activate enhanced descriptors
at "runtime". But I propose to do it in a similar way as changing ring
parameters, so it is in runtime seen from a CPU perspective, but the
interface will be shortly brought down when changing it.

>>> 3. I dont think there is a way we can enable this dynamically today. I
>>> would like upstream community to share your thoughts as well.
>>
>> Hereby done. Could we investigate the possibility of using ethtool to
>> change TBS enable/disable "run-time"?
>>
> We can either allocate enhanced desc for all channels at bootup
> and then choose to switch to enable TBS mode at runtime.

I think we should do something like this:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=3b12ec8f618e

for all glue drivers, so a sane default is established that allows using
TBS from boot up.

But in addition to that, I think it would make sense to create an
ethtool API to change it from that default. And it will bring down the
interface while applying the change.

/Esben

