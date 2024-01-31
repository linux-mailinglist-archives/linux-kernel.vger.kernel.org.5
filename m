Return-Path: <linux-kernel+bounces-45925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C3B8437E8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5641EB20FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41F3537F8;
	Wed, 31 Jan 2024 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="j6zVGMan"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CC850A63;
	Wed, 31 Jan 2024 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686283; cv=none; b=co20WL2xHdGNJdDgEC173uu0dlhwtHwHYhU8ERi+s51Pc4RvHrbP4vwkcG3JYS2M0L7aPSyqNk1BNn+ohJEVRbzfi9z7TVRS2ozJhehJFbOtaD39NNx4iU8Sy3TQfACq31xHwV15zGKJVP/Zcr1xWnhhiqMF4ot6/UlAH7U1R0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686283; c=relaxed/simple;
	bh=hnngE/xvVeUudyliJUD+XFSMUVJq1k+6dcQsVcdiRRw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U4GLqrFIu9l29jl228G0pZB2iv/TkW3twsXqgI2vVu7w6O+py1SpYZUtAfjwzWkEVzU+F5t4yjVwV8MqpuZOCIpR1iJpIPGpbVFJr++sedV1qIxQrAzH5nWRuvufPZVyPo2V6IZIW07Se+Q/FookKbIb9mMu/DLYajbQyp9D7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=j6zVGMan; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=T+vT4KTVm5uJEp0LZxDmNfvh0KWaLsPEjnAqZuGPBKo=; b=j6zVGMantgmtScxIoBPxJkAJYJ
	hE3MkHgcX3LnCNv6tbu+TCBs3VYIP9wEJiUmy/fF7YDUz2Ttn5oTjxXVFngJi3x2282Pgtv/CIFSG
	b6EriJBmLgYC0S6n5R9DwE0jOoqNyb6caD5UA9nnKFsPDDIr19ih0RdXer08OfPR5LLbv6Elosshq
	POJnZLDWdzzxSmeVPRKsnVEX364fdQ/h9uF7/52PVnOz3yFSJu5lXXtTV/URYNmnkgEGgrH04YEgG
	nT/q7J8QNLg81vQFI8csp5U8Vu2n89XfKrjj5+G5pbDNWt35oKHL7CFil9wd1dGT13d/WbFETRny4
	aQElTyXQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rV53s-000HWK-Oy; Wed, 31 Jan 2024 08:31:08 +0100
Received: from [87.49.42.9] (helo=localhost)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rV53r-000XK1-Oy; Wed, 31 Jan 2024 08:31:07 +0100
From: Esben Haabendal <esben@geanix.com>
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Alexandre Torgue <alexandre.torgue@foss.st.com>,  Giuseppe Cavallaro
 <peppe.cavallaro@st.com>,  Jose Abreu <joabreu@synopsys.com>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: net: snps,dwmac: Add
 time-based-scheduling property
In-Reply-To: <20240130213926.GA2342546-robh@kernel.org> (Rob Herring's message
	of "Tue, 30 Jan 2024 15:39:26 -0600")
References: <b365dc6f756a3fad4dfaa2675c98f4078aba8a55.1706105494.git.esben@geanix.com>
	<30ce8f45b8752c603acc861ebb2f18d74d2f8a07.1706105494.git.esben@geanix.com>
	<20240130213926.GA2342546-robh@kernel.org>
Date: Wed, 31 Jan 2024 08:31:06 +0100
Message-ID: <87cytiez7p.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27170/Tue Jan 30 10:44:09 2024)

Rob Herring <robh@kernel.org> writes:

> On Wed, Jan 24, 2024 at 03:33:06PM +0100, Esben Haabendal wrote:
>> Time Based Scheduling can be enabled per TX queue, if supported by the
>> controller.
>> 
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>
> This is not v1 which you are aware. Where's the justification or do I
> need to ask the same questions again? Here's the last discussion[1].

Yes, I am aware. I must admit I only spotted the last discussion you are
referring to after submitting my version of it. Sorry about that.

> I'm still not clear on why this is needed. Seems like the combination
> of TBS and TSO capabilities provides enough information. If TSO is
> enabled for a queue, then don't enable TBS.

> This binding is already such a mess of properties, I'm inclined to say
> "what's one more", but it's death by 1000 cuts. Part of the problem is
> this binding is for not 1 IP block, but something that's evolved over
> at least 15 years.

It definitely is a mess. A lot of these properties are not the type of
properties that I think would be accepted today, as there is a lot of
configuration like properties there.

> The question on configuration properties really comes down to who
> would configure things and when. If it's one time for the life of
> given h/w, then DT makes sense. If every user wants/needs to tweak the
> setting, then definitely shouldn't be in DT. Somewhere in the middle?
> Judgement call.

Some of the existsing configuration properties in there is something
that users will need to tweak, such as the selection of queue scheduling
and priority algorithms.

The TBS vs TSO is probably somewhere in the middle. It might just be
that choosing TSO for TX queue 0, and TBS for the remaining ones are
something that everybody can agree on. But I am not really sure about
that.

I think we should drop this binding.

I have found another simple solution for i.MX, which does not involve
new bindings.
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=3b12ec8f618e

Improving on that, I think we should make switching between TSO and TBS
a run-time configurable thing, instead of creating binding for it.
But I am unsure if that is really worth it.

/Esben

>
>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> index 5c2769dc689a..301e9150ecc3 100644
>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> @@ -399,6 +399,12 @@ properties:
>>              type: boolean
>>              description: TX checksum offload is unsupported by the TX queue.
>>  
>> +          snps,time-based-scheduling:
>> +            type: boolean
>> +            description:
>> +              Time Based Scheduling will be enabled for TX queue.
>> +              This is typically not supported for TX queue 0.
>
> Make the property name clear it is an enable, not a capability.
>
>> +
>
> [1] https://lore.kernel.org/all/20230929051758.21492-1-rohan.g.thomas@intel.com/

