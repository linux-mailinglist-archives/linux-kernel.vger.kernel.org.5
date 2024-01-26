Return-Path: <linux-kernel+bounces-39891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE9083D8FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F474B32B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F91627EF;
	Fri, 26 Jan 2024 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="y6BD1jbe"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C8612D3;
	Fri, 26 Jan 2024 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260136; cv=none; b=NIa/NgzXTbOxvctApzrxWPV9Dxsyduth/Jr14doH57PFZKo5DyLiluy1D9t+4vfHTsegH5Bc+0Gz0o+Nq+ijzf4goh02RbyZgbKF7lPmxR4wgl5vjIluurllZ0b7fX9Wvad03zPFJ7+kdk6EzqAAPfIOHLJnh0xBbEUBkE405js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260136; c=relaxed/simple;
	bh=Y6ysjC80/3HxVZG5UJcj5X7tUQusPEe/JH3Lz24bfkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QXS1nDfN4VzNlr8YXHfnMxWrZxL0xQOnFA7LCpVPE0rO5X+F8mNBZTUVBUFyeanj8+RhMhdEkDA/fp5cizd13s9FPkN5Gt4OYSMkZi0UBxXuXef242eCevrk8TVdD6XH3Sn57XaMdTr5gefV4CQG5hVsOV9sRt0/Q3i7DRLfTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=y6BD1jbe; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=oxqeIC7ttI03nT3m0P4jBVoLhILJzKjA4P3WHMGd76k=; b=y6BD1jbex9IqxWEA69pQNSDqVH
	D0wyfPojU3G20lcfmkgh3caXY+0zFvYLv8Y5ekKvYk9Ppu/iicTshnhlNd6NBaeici2ZeXDVcxXCU
	k+TP8tVNpunouS3ayFL2Cw09SDIPo2PKzfFcbVOxEEEsEo/zrDk3orOmQ0Nx21nmSsgRDWNwwhBwN
	60ITWFGCgRmafdPAtkvowwFvFy8M5vFjS5Gs0i0L+NZnlSBJvKlszD7L4VwZDvxifQ4L+ZbW2+b+E
	DOGfioj//Pvxrra8sLl9Z0B+7VRS25gox0tt9/4M/Ni8+duLziTaxVw4O93SbzVoB/VL+S2iJXOmE
	O46vT+NQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rTHx4-000DSM-8S; Fri, 26 Jan 2024 09:52:42 +0100
Received: from [87.49.42.9] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rTHx3-000LGD-7I; Fri, 26 Jan 2024 09:52:41 +0100
From: Esben Haabendal <esben@geanix.com>
To: rohan.g.thomas@intel.com
Cc: robh@kernel.org,  alexandre.torgue@foss.st.com,  conor+dt@kernel.org,
  davem@davemloft.net,  devicetree@vger.kernel.org,  edumazet@google.com,
  fancer.lancer@gmail.com,  joabreu@synopsys.com,
  krzysztof.kozlowski+dt@linaro.org,  kuba@kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-stm32@st-md-mailman.stormreply.com,  mcoquelin.stm32@gmail.com,
  netdev@vger.kernel.org,  pabeni@redhat.com,  peppe.cavallaro@st.com
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: snps,dwmac: Time Based
 Scheduling
In-Reply-To: <20230929051758.21492-1-rohan.g.thomas@intel.com> (rohan g.
	thomas's message of "Fri, 29 Sep 2023 13:17:58 +0800")
References: <20230928180942.GA932326-robh@kernel.org>
	<20230929051758.21492-1-rohan.g.thomas@intel.com>
Date: Fri, 26 Jan 2024 09:52:40 +0100
Message-ID: <87msss4gtj.fsf@geanix.com>
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

rohan.g.thomas@intel.com writes:

> From: Rohan G Thomas <rohan.g.thomas@intel.com>
>
> On Wed, Sep 27, 2023 at 09:09:18PM +0800, Rohan G Thomas wrote:
>>> Add new property tbs-enabled to enable Time Based Scheduling(TBS)
>>
>>That's not the property you added.
>>
>>> support per Tx queues. TBS feature can be enabled later using ETF
>>> qdisc but for only those queues that have TBS support enabled.
>>
>>This property defines capable or enabled? 
>
> This property is to enable TBS support for any Tx queue. Why this
> added is because I think TBS need not be enabled for all capable
> Tx queues(Tx DMA channels) because of the following hw limitations.
> 1. As per DWMAC QoS and DWXGMAC databooks, TBS cannot coexist with
> TSO. So TBS cannot be enabled for a Tx queue which is for TSO. 
> 2. Also as per DWXGMAC databook, "Do not enable time-based scheduling
> (or enhanced descriptors) for the channel for which TSO or transmit
> timestamp or one-step timestamping control correction feature is
> enabled".
> 3. As per DWXGMAC databook, "Use separate channel (without TBS
> enabled) for time critical traffic. Mixing such traffic with TBS
> enabled traffic can cause delays in transmitting time critical
> traffic."
> More explanation below...
>
>>
>>Seems like OS configuration and policy.
>
> Tx queues need to be configured for TBS during hw setup itself as
> special enhanced descriptors are used by the hw for TBS support
> enabled queues. Switching between enhanced and normal descriptors on
> run is not feasible. So this flag is for enabling "Enhanced
> Descriptors for Time Based Scheduling". This I think is a hw specific
> requirement.

Support for enhanced descriptors is definitely hardware specific.
Enabling the use of enhanced descriptors is a configuration choice.

The tricky part here is that the whole devicetree bindings story for the
stmmac driver is filled with such configuration choices. As such, it is
only natural to add the property you are suggesting here. I completely
agree. But you can also argue that it is "wrong", because it does not
just describe the hardware, but also a configuration choice.

>>Doesn't eh DWMAC have capability registers for supported features? Or
>>did they forget per queue capabilities?
>
> Yes, capability registers are available. For DWMAC5 IP, if TBSSEL bit
> is set, then TBS is supported by all Tx queues.

Not true. Some NXP imx8 and imx9 chips support Synopsys MAC 5.10a IP,
and does not support TBS for queue 0. And they have TBSSEL bit set, but
no TBS_CH support.

> For DWXGMAC IP, if TBSSEL bit is set, then TBS is supported by TBS_CH
> number of Tx queues starting from the highest Tx queue. But because of
> the hw limitations mentioned above, TBS cannot be enabled for all
> capable queues.
>
>>
>>> 
>>> Commit 7eadf57290ec ("net: stmmac: pci: Enable TBS on GMAC5 IPK PCI
>>> entry") enables similar support from the stmmac pci driver.
>>
>>Why does unconditionally enabling TBS work there, but not here?
>
> There, Tx queue 0 is not enabled for TBS as it is used for TSO.
>
>>
>>> 
>>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
>>> ---
>>>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>> 
>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/>devicetree/bindings/net/snps,dwmac.yaml
>>> index 5c2769dc689a..db1eb0997602 100644
>>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> @@ -399,6 +399,14 @@ properties:
>>>              type: boolean
>>>              description: TX checksum offload is unsupported by the TX queue.
>>>  
>>> +          snps,tbs-enabled:
>>> +            type: boolean
>>> +            description:
>>> +              Enable Time Based Scheduling(TBS) support for the TX queue. TSO and
>>> +              TBS cannot be supported by a queue at the same time. If TSO support
>>> +              is enabled, then default TX queue 0 for TSO and in that case don't
>>> +              enable TX queue 0 for TBS.
>>> +
>>>          allOf:
>>>            - if:
>>>                required:
>>> -- 
>>> 2.26.2
>>> 

