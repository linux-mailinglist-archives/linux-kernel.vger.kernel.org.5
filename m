Return-Path: <linux-kernel+bounces-110607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B13CC886139
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3AB281958
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03280134434;
	Thu, 21 Mar 2024 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ASDidFR+"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFA3847B;
	Thu, 21 Mar 2024 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050159; cv=none; b=rPQbGGK55221dpV3nSwjzZ+N1p+VYEaZIkMwqBt07o9whe78conXNMLaMP/vuYNTM5xo6aZxOl4C80HRjbOcjXzu+ncOdhzVBkc0o1wX0R1WCuen6TOVWTceB9bAaex1yvudQugMI66wNT9HoI5GO6PpDE3xQMvzwNK0jd0biWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050159; c=relaxed/simple;
	bh=YSAribocTF+rrupZDIuD87XtJLJvbUFIofeJ1GmRNqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWdZx3+b6LOD4MmuA0BvOR7aPAVUuBwCX5E1UuY5nX0yPbA5Mb3Pz1JhQOjhe5D7A7yIrtItXfw4huR/R/w451llO6EGb/+kDDzW+jzCcFroVAHo893CbVBjV3jTPCX04spsU3O49b/Jp6xoPDlVtke1Ody2fclCXtLAAv+mSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ASDidFR+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CSMqwDKzbAF07LEj16Y/SY3uynIQ3ZDCh9oahh4/HcU=; b=ASDidFR+i4iYNluQP0rJyHKR+9
	MA14ki1enjp3yP1hOvsRmysiDbELxsPMxXQPk/M+1NUURfmZQeOIdKIC6kU22hynxmMBBalxTl2Ey
	TIbTKUAN37DFqIZgesWvog5zZdyXU42VxFl9IVicM6sVxLXhb7QCeU7Rkh1xS1LqxN8E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rnOIw-00Au4Q-Dp; Thu, 21 Mar 2024 20:42:22 +0100
Date: Thu, 21 Mar 2024 20:42:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: "Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
	"ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
	"Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"Thorsten.Kummermehr@microchip.com" <Thorsten.Kummermehr@microchip.com>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"Nicolas.Ferre@microchip.com" <Nicolas.Ferre@microchip.com>,
	"benjamin.bigler@bernformulastudent.ch" <benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v3 08/12] net: ethernet: oa_tc6: implement
 transmit path to transfer tx ethernet frames
Message-ID: <f9ded7f6-7f7d-4564-8b06-e73e603ef927@lunn.ch>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-9-Parthiban.Veerasooran@microchip.com>
 <208fb61b-4740-46bf-8c70-29ab59cbb965@lunn.ch>
 <f9d8a18c-b1fe-450c-a5ca-d91f96793a04@microchip.com>
 <96dd422f-0bf9-411d-8cc2-5755c1e60e27@lunn.ch>
 <53b090b1-d7bb-4a81-9f0b-9979db8dec59@microchip.com>
 <BYAPR02MB5958A04EF61FF6B7512CE7EE83322@BYAPR02MB5958.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR02MB5958A04EF61FF6B7512CE7EE83322@BYAPR02MB5958.namprd02.prod.outlook.com>

> > > This second part is clearly an optimisation. If you have lots of full
> > > MTU packets, 1514 bytes, they take around 24 chunks. Having the last
> > > chunk only 1/2 full does not waste too much bandwidth. But if you are
> > > carrying lots of small packets, say voice, 130 bytes, the wasted
> > > bandwidth starts to add up. But is there a use case for 10Mbps of
> > > small packets? I doubt it.
> > Yes, for sure there is a possibility to get into this scenario and the protocol also
> > supports that. But as proposed by you below, let's implement it as part of
> > optimization later.
> > >
> > > So if you don't have the ability to combine two packets into one
> > > chunk, i would do that later. Lets get the basics merged first, it can
> > > be optimised later.
> > Yes, I agree with this proposal to get the basic version merged first.
> 
> While latency is important, so is using the available bandwidth efficiently. Here is a suggestion.  We know that the tx credit available basically tells us,
> how many chunks could be transmitted without overflow. Instead of stopping the netif queue based on number of skbs queued, why not stop the queue based on
> number of bytes accumulated? Basically, at any given point of time, we enqueue the tx_skb_q until we are have enough bytes to cross the threshold of (tc6->tc_credit * OA_TC6_CHUNK_PAYLOAD_SIZE).
> This way, during the next transmit, we could utilize the whole available credits. Bandwidth utilization between bigger frames and smaller frames would be not be vastly different.

Please configure your email client to wrap emails at around 70
characters.

tc_credit is 5 bits. So it is a maximum of 32.

A 1514 frame takes around 24 chunks. So you only need two full size
frames to consume all your possible credit.

If you happen to have smaller voice packets, say 130 bytes, you need
three chunks to send it. So you might want to have 10 such packets on
hand in order to make use of all your credit. But if you have 10 voice
packets to send in a burst, your voice quality is going to be bad,
they should be 10ms to 20ms apart, not in a burst...

I don't like the original idea of having lots of packets in a transmit
queue. But having 1/2 dozen should not be an issue.

In general, we prefer things to be simple. We can then optimise later,
and use benchmarks to show the optimisations really do bring a benefit
to justify the added complexity.

   Andrew

