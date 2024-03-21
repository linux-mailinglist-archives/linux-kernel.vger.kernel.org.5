Return-Path: <linux-kernel+bounces-110091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D24DB8859EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5361C2132E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CDA84A3F;
	Thu, 21 Mar 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="AJ1LL4Wk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wBT6STPA"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70F783CD8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027525; cv=none; b=EF8kX8d11v4YBYBYeQzjCEx1bBi/UNcpZK56BcuU81Jx2thDUqGs7tCZUTZpf7PXvMd7Qs4tnSVnK29sWR18/7bhQAbmUPJfzlu4NpazU7qeS4wv0MJ5xRxxn6HC6bFdUtLcCLFsXszR4RLwtLNEpHweKaH9/ZoiBHrNFc1e9dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027525; c=relaxed/simple;
	bh=h8ZifEKnaXUc0zdI/qG1xC3K4ax198OvtVaNLxqSPnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiHjzCFf3CVl8Jt7nIrg1Tz/P4ZbUmmoyP/zxLBLmRSUEPnVLs9tgnVdzjUqnsBGIan7fA7ExprBudD6vYd6otzlJKx1z3oFObGVAp5GPprz8ECRgtTFZ3BWmxNVejz1vAPCXcPicjlN4A7dNuQc9j4f+zFykk0OPrm160qIufY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=AJ1LL4Wk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wBT6STPA; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id AEA3D1380145;
	Thu, 21 Mar 2024 09:25:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 21 Mar 2024 09:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1711027522; x=
	1711113922; bh=FM/ekE5Io3Dn3mqf5BFQ86JSx+WgTpNVAU55ps3Oaaw=; b=A
	J1LL4WkrTHGGRRuuF1b19nf0CmG1HZ6LoQHlAIazSOyySlaC9YTzVBAIDeC3+CLH
	jkY+57QV7JfyoFDZzB9mqGxcz6cpfwRa3EnBi4w5p4y4b/oYusJxPovdGobPUgL8
	LNb65Lwlelenkr67uqqYXL8ZVDE8c4RUlpP/anIoat+H0/O1oXhIFGq9fhT5fkqB
	/oxcbkyk2yrnCm3xJPSk2xC5UNYJiMw25Evnw+agtiUlk9p3PvEsiEr3Ozsg4w2A
	Hv02HN6wCqZlnTd/Sz8Jge2stAGSWaNvW79LZm7Z15gfVSr/T1AE2P/EVZkbgZw3
	dWowOphxEvvDIzIJTES/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711027522; x=1711113922; bh=FM/ekE5Io3Dn3mqf5BFQ86JSx+Wg
	TpNVAU55ps3Oaaw=; b=wBT6STPA6NUULLuiubLxlYogt1j0trDR5RA/e/Pq3y8F
	5db8Kf0RPC4OUHU9jXiK6lN41kF7JrR7dApdaGUQ8LWScliPTGHC2fm1Fgpc/fht
	GSojYrctzRTWSD5do/Bm4GHHV0zTgLiYiTB1H2U+wkXix6S0/zHjKXMrjOfM6E8n
	N1m5jVXD8qsvOjmq1Q9oNlNvnFmwQs8SowGXaRpCId9f9A3xwqxlmDnU8SbctFEl
	5IyOWwCrlLPrIfZW56ypRJPKNqgGftN253/3Ul3LeQMPRVy6c9O30tb1JcRx+NB3
	GmLVRXtNFFzcdMYZyylzgEeR+x1tVnQ8qPgR0OgUQA==
X-ME-Sender: <xms:QjX8ZWjZN8onfLLl89haiixGZ7FwKE-7gztpNNCWToQS6cnRsR_XOA>
    <xme:QjX8ZXAd8SqWbTes42rL52NvYrKUnUIQYf5_fi9x_c-wrH8DQyaQVD5-URTz772hL
    jOV1Uz5YoTW9HMPqxo>
X-ME-Received: <xmr:QjX8ZeGAvCOSyaiLjP-og5EWfgMCQ1dHL0TC4MAC8fpZ5f4U42uJn1AkYbdapOzGOD4VXZNMB_YRuR97Pc6GwINbUJjIHDX8N60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeevieelhfdukeffheekffduudevvdefudelleefgeei
    leejheejuedvgefhteevvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:QjX8ZfRxXMUx7FvFj7vqGM4i7V8_9x0QVAa5cW65Lg-bhRqaxYSBPg>
    <xmx:QjX8ZTyB8fcFdJ78f35DXwFsVt7ZiYgsNsSbC6dELt39_znJVyZvUA>
    <xmx:QjX8Zd6KJjiT1_3eOSM68Idx1ug8w_pvcDhZTZIML9iyS5yaBGqOcQ>
    <xmx:QjX8ZQwmcoTQoDEp78AR-rGDNSXV1BEMazoUHeCAKktT9JkwNPs0Jg>
    <xmx:QjX8ZVvqBUGrh8LIDyypRKFhmMRl1Hbl5NXkIZ2xAmFy2V3WMomDsg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 09:25:20 -0400 (EDT)
Date: Thu, 21 Mar 2024 22:25:18 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Adam Goldman <adamg@pobox.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: use long bus reset on gap count error
Message-ID: <20240321132518.GA755964@workstation.local>
Mail-Followup-To: Adam Goldman <adamg@pobox.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <ZdxH-mjmd09jmYZN@iguana.24-8.net>
 <20240228004144.GA72391@workstation.local>
 <ZfqufddlPhxzcDCN@iguana.24-8.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfqufddlPhxzcDCN@iguana.24-8.net>

Hi Adam,

Thanks for the patches to improve the subsystem.

Inconveniently to you , we are now just at the merge window for v6.9
kernel, thus I would not put any changes except for the changes to
Linus. I'd like you to wait until the next week, sorry.

However, in the topic of logging PHY register, I have an idea to utilize
the Linux kernel tracepoints framework[1]. It is tangled to program with
the provided macros, and it is available just with the relevant tools[2],
but it would be helpful in the case, I think.

[1] https://docs.kernel.org/trace/tracepoints.html
[2] https://docs.kernel.org/trace/tracepoint-analysis.html

On Wed, Mar 20, 2024 at 02:38:05AM -0700, Adam Goldman wrote:
> Hi Takashi,
> 
> On Wed, Feb 28, 2024 at 09:41:44AM +0900, Takashi Sakamoto wrote:
> > Additionally, for your investigation, you added the debug print to get the
> > timing of bus reset scheduling. I think it useful for this kind of issue.
> > Would I ask you to write another patch to add it? In my opinion, the case
> > of mixed versions of 1394 PHYs in the same bus has more quirks and the
> > debug print is helpful to investigate it further.
> 
> I'm sorry for my delay in preparing a patch.
> 
> I've submitted a patch to linux1394-devel to log when we schedule or 
> initiate a bus reset. This is enabled with a new parameter to the 
> firewire-core module. It provides logging similar to the debug print I 
> used to investigate the reset loop.
> 
> Also, there is already logging for bus reset interrupts in 
> firewire-ohci. This logs all bus resets and does not indicate whether we 
> initiated the reset or some other node on the bus initiated it. However, 
> the logging in firewire-ohci always froze my computer when I enabled it. 
> I've submitted a separate patch to fix the firewire-ohci logging.
> 
> I believe both forms of logging can be useful. firewire-ohci logs all 
> bus resets, but it doesn't tell where the resets came from. firewire-core 
> only logs bus resets we initiate.
> 
> I also considered adding an option to firewire-ohci to log PHY register 
> access. This would include writes to IBR and ISBR, so it would log when 
> we initiate resets. However, this logging would be more complicated to 
> add, so I didn't do it.
> 
> -- Adam


Thanks

Takashi Sakamoto

