Return-Path: <linux-kernel+bounces-38549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE80A83C162
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09907B24190
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FDD36124;
	Thu, 25 Jan 2024 11:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="LaukGkcs"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9C481A1;
	Thu, 25 Jan 2024 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183721; cv=none; b=rhHBZJnu2y3drFaih2kwuOrO3kybplYyV8mDwadIndio+xDVSJHrH8xYRFcBPbY+oiq0NPbIZ0z22ailTowuFA+OzqGKwN8InElbioSh3IuYBkRXju9OzwC4hu0Eu+wDcdsOzdndU7IIiGnZ/+ve38daapiIvO6KwbYujIfh5SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183721; c=relaxed/simple;
	bh=0/KtXWM+5DW4c3nEA6ICqAjrU+Do2pgeS89POdOEYsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ULboprvX/U9H4zetJ4oH+ZBGrjpG+LBWevot5BO9T0KtRV8S8ZIjE+faSUtVyhbSP4Y/Y20Q0Lz4v5KBeczLwkspvQrFC1I+RJfmNM84YY/KG/HlW3hedmRDJPGrRPkBNPqoG2Hd0nCEuyh0GnhSYb24/hdLlajjxuf/+ygLhzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=LaukGkcs; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=19ahVdd1QUjj/gfp0rYesJtgcE+kp9SEnJVob0r94EQ=; b=LaukGkcsHzUeZW5NLj7IJXgzZQ
	ivjUU2g1KQCVPUuKm5qDxbGQvetBPb73CVDN4mQNYEnQNvrP1dRPzOV5Rs2ShqH6WrDH4BZEyD8p/
	c81ueGK+idmgdWov8udfud6RWRhovZmbEzA2sBSF+TaAF7OMDsdP4uMM9JaYjBD38T9mOczg85XL5
	eR8wYzvyI4Pavou9vASfNoQQ9+rzR21yrH+yXG7Gm4HDFC0Dm5S38YuF0kXQfykGaFoEL21Jxb94X
	c5zURftVO4Ol71NqI/rRMUJJjAcSy+6/z3aRKMn9mHjj6XLzOAE92eZrHNuPZ3VkwzEmnlVKgQ2GP
	gtD11bJw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rSyK9-0000LM-ID; Thu, 25 Jan 2024 12:55:13 +0100
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rSyK8-000MDh-Ot; Thu, 25 Jan 2024 12:55:12 +0100
From: esben@geanix.com
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor@kernel.org>,  devicetree@vger.kernel.org,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Alexandre Torgue <alexandre.torgue@foss.st.com>,  Giuseppe Cavallaro
 <peppe.cavallaro@st.com>,  Jose Abreu <joabreu@synopsys.com>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: net: snps,dwmac: Add
 time-based-scheduling property
In-Reply-To: <3adf7908-be27-4125-ae5b-6f2eb6100304@linaro.org> (Krzysztof
	Kozlowski's message of "Thu, 25 Jan 2024 10:19:45 +0100")
References: <b365dc6f756a3fad4dfaa2675c98f4078aba8a55.1706105494.git.esben@geanix.com>
	<30ce8f45b8752c603acc861ebb2f18d74d2f8a07.1706105494.git.esben@geanix.com>
	<20240124-reptilian-icing-a95b20f123be@spud>
	<87bk99hj7q.fsf@geanix.com>
	<3adf7908-be27-4125-ae5b-6f2eb6100304@linaro.org>
Date: Thu, 25 Jan 2024 12:55:12 +0100
Message-ID: <877cjxhbkv.fsf@geanix.com>
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

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 25/01/2024 10:10, esben@geanix.com wrote:
>> Conor Dooley <conor@kernel.org> writes:
>> 
>>> On Wed, Jan 24, 2024 at 03:33:06PM +0100, Esben Haabendal wrote:
>>>> Time Based Scheduling can be enabled per TX queue, if supported by the
>>>> controller.
>>>
>>> If time based scheduling is not supported by the controller, then the
>>> property should not be present! The presence of a property like this
>>> should mean that the feature is supported, using it is up to the
>>> operating system.
>>>
>>> That said, why is this a property that should be in DT?
>> 
>> It is added to the tx-queues-config object of snps,dwmac bindings. This
>> entire object is about configuration of the ethernet controller, which
>> is also what the purpose of the snps,time-based-scheduling.
>> So yes, it is not specifically about describing what the hardware is
>> capable of, but how the hardware is configured. It is a continuation of
>> the current driver design.
>> 
>>> If support is per controller is it not sufficient to use the
>>> compatible to determine if this is supported?
>> 
>> Are you suggesting to include the mapping from all supported compatible
>> controllers to which TX queues supports TBS in the driver code?  What
>> would the benefit of that compared to describing it explicitly in the
>> binding?
>
> The benefit is complying with DT bindings rules, saying that bindings
> describe hardware pieces, not drivers.

Understood.

>> And for the purpose of the above question, I am talking about it as if
>> the binding was describing the hardware capability and not the
>> configuration.
>
> "if"? You wrote it is for driver design...

If you look at the current driver, all the devicetree bindings under
rx-queues-config and tx-queues-config are violating the DT binding
rules.
Cleaning up that requires quite some work and I guess will break
backwards compatibility to some extend.

But that is another story.

I will respin the patch according to Conor's suggestion.

/Esben

