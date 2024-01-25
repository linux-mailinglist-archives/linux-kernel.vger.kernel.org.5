Return-Path: <linux-kernel+bounces-38239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF46483BCF3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B66AB24C70
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0D01BDFA;
	Thu, 25 Jan 2024 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="O4ULXlhg"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27501BC39;
	Thu, 25 Jan 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173827; cv=none; b=rwjAgU6LSBrPRUhJQWSACpQNh58kiIfC3n0044H2DQCIEqv04xAdvLl2s6JsX6KTUx21n7IkUA39vOs/Tg/a15WtoSqMCK+jF6g2D8MefqO8FiuK/7+vdCtlmksiRHZwYIN1LCYNg4h0AcpHL84VE6sEjh6iJfFsFDLaBeEarAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173827; c=relaxed/simple;
	bh=mWozjZ0MQ+V6lQWz+OjK00G+pFbB5gGnuEUnxHrILTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DNrJ7GNflxfq8nnPTPeRWo8dOCYpZ+yYKHKt/tEU7c/OUDDenH1RrlQYmpMZiNQlZb8qvwb1DISNZr8mw9bvCiCHxvP93jJu3ap/KP/0KJJ+jzV2CMiDT9isGME8BKeBGNmYCI5H2DSV++rw3ynY6NVeleGarRqphh1Aq5SdclQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=O4ULXlhg; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=v7OHKf/eD55Qem09PPYclG2VfzoScAThX9wIj8orSYc=; b=O4ULXlhgZi+zbMO8b6WHYFzfuk
	qNakRjVE6dc4R7OgodO6nyTQG9Plrk+O7BoYHgBciWgmjKf3YUHjitBGQ06BnTfxIFNrD151EIGsO
	L/9C3eCoOeillnLyHONjFtcvlZtF37IwhEGW4M4pLrUfDQmfPYafbRwMAkRr/9EWpWcoZ28s0ZOUE
	/bBzDUnOE9ozDamxxdkRPHpmBPmtqbwRQ/EiYlX5xe2Z1QgO7jq4FD0sRDo7gul93vBWtVJhNq4Py
	ji5F4O5Do+Fab7Yt2/6EhM15nLJbZ1lfa3UKpoxFNsdzr+e0B85lE/amZ+Vqs5BrI0Wnt5/14ENII
	X5s398cg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rSvkZ-000OIA-5F; Thu, 25 Jan 2024 10:10:19 +0100
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rSvkY-000KJu-8A; Thu, 25 Jan 2024 10:10:18 +0100
From: esben@geanix.com
To: Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Rob Herring <robh+dt@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Alexandre Torgue <alexandre.torgue@foss.st.com>,
  Giuseppe Cavallaro <peppe.cavallaro@st.com>,  Jose Abreu
 <joabreu@synopsys.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: net: snps,dwmac: Add
 time-based-scheduling property
In-Reply-To: <20240124-reptilian-icing-a95b20f123be@spud> (Conor Dooley's
	message of "Wed, 24 Jan 2024 16:07:48 +0000")
References: <b365dc6f756a3fad4dfaa2675c98f4078aba8a55.1706105494.git.esben@geanix.com>
	<30ce8f45b8752c603acc861ebb2f18d74d2f8a07.1706105494.git.esben@geanix.com>
	<20240124-reptilian-icing-a95b20f123be@spud>
Date: Thu, 25 Jan 2024 10:10:17 +0100
Message-ID: <87bk99hj7q.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27164/Wed Jan 24 10:45:32 2024)

Conor Dooley <conor@kernel.org> writes:

> On Wed, Jan 24, 2024 at 03:33:06PM +0100, Esben Haabendal wrote:
>> Time Based Scheduling can be enabled per TX queue, if supported by the
>> controller.
>
> If time based scheduling is not supported by the controller, then the
> property should not be present! The presence of a property like this
> should mean that the feature is supported, using it is up to the
> operating system.
>
> That said, why is this a property that should be in DT?

It is added to the tx-queues-config object of snps,dwmac bindings. This
entire object is about configuration of the ethernet controller, which
is also what the purpose of the snps,time-based-scheduling.
So yes, it is not specifically about describing what the hardware is
capable of, but how the hardware is configured. It is a continuation of
the current driver design.

> If support is per controller is it not sufficient to use the
> compatible to determine if this is supported?

Are you suggesting to include the mapping from all supported compatible
controllers to which TX queues supports TBS in the driver code?  What
would the benefit of that compared to describing it explicitly in the
binding?
And for the purpose of the above question, I am talking about it as if
the binding was describing the hardware capability and not the
configuration.

/Esben


>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
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
>> +
>>          allOf:
>>            - if:
>>                required:
>> -- 
>> 2.43.0
>> 

