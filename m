Return-Path: <linux-kernel+bounces-134817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AC389B757
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EEE2817CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5933A849C;
	Mon,  8 Apr 2024 05:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDmHFt5b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8226E1F93E;
	Mon,  8 Apr 2024 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712555862; cv=none; b=hUDqG4bqqCX3ds/UvG3xgl26tNjjNKGFKhHwErRAD+Po4dY2c1ROKr3WvqKlNfvmvrguW6E8ZCUrn8MJvD6lqcpGz3F2A8ahjWd846mMoZlVVhHw/5D88FzcZ4ffYD95x39poMeBbnndAGW6x8n3D2lkrf6um4hJcOjTesNLzjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712555862; c=relaxed/simple;
	bh=mBGucGHxPEYjNGFj9o1D+BgtglcfHZFWJhMetpAilZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OckMNXe71KKiYQLR6tljxRG0/+nBT9jzljYh25L5ydROk4suvC19LBS7R+SfvJUSiCP0icD23tLbKJqHJPVghZOrsPTKzfJZdYRlMa9o7YTQ0mjhBzd6FaSFXF+7YLw0NAQWN9BFwg4aFq6MCPIpWVAZXK4HU5i+RLQVHrE/4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDmHFt5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE34C433F1;
	Mon,  8 Apr 2024 05:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712555862;
	bh=mBGucGHxPEYjNGFj9o1D+BgtglcfHZFWJhMetpAilZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sDmHFt5bWapR5TTFh/Ikxt8jRpMRejQ6zXt1Sm9GJOMtT1UPvftyO1fQMwS/nI0Nv
	 3lCcjqfnMn07nsWcrjJpYGmJPML4SwLj+E8KqONvckc+WbNinUc+Wk5YS0QdLI3rFQ
	 IHPacDQ1xU7fJBbO1XQZHDYM48zD+LPjUiU2jFaSSZQ4Tu1Qg4rkuOJ41OqGHrM16f
	 yOWXS9cP7qps4qRBOaAPdduyQYmWecRtGL2L6ijy9e4u4sWQxCz7u8L8sl4vf3HFwY
	 WSvm5OLD0VrvtuK5GhkDZkHKC8BnzqA90J2bhdTnpC8nNANbs4iS1xj2hZnIGkt+Tq
	 0PgiUqgPe424A==
Message-ID: <ba4c9f20-0391-4ac2-a236-d6930285cd7e@kernel.org>
Date: Mon, 8 Apr 2024 07:57:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: set
 additionalProperties to true
To: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-1-9fc9186856c2@nxp.com>
 <614b5107-656d-4d41-99c1-77941c48342c@kernel.org>
 <DU0PR04MB9417932A6208128FBBB22C4188012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <09f6b752-6b72-49d7-b248-6faba2fd13a7@kernel.org>
 <DU0PR04MB9417C5B9BDD9E0B47E7494C088012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <5b9e0e44-0b9c-44fc-9d18-21c47b46dc63@kernel.org>
 <DU0PR04MB9417839C42681F57366003EF88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <DU0PR04MB9417839C42681F57366003EF88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 01:50, Peng Fan wrote:
>> Subject: Re: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: set
>> additionalProperties to true
>>
>> On 07/04/2024 12:04, Peng Fan wrote:
>>>> Subject: Re: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: set
>>>> additionalProperties to true
>>>>
>>>> On 07/04/2024 02:37, Peng Fan wrote:
>>>>>> Subject: Re: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: set
>>>>>> additionalProperties to true
>>>>>>
>>>>>> On 05/04/2024 14:39, Peng Fan (OSS) wrote:
>>>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>>>
>>>>>>> When adding vendor extension protocols, there is dt-schema warning:
>>>>>>> "
>>>>>>> imx,scmi.example.dtb: scmi: 'protocol@81', 'protocol@84' do not
>>>>>>> match any of the regexes: 'pinctrl-[0-9]+'
>>>>>>> "
>>>>>>>
>>>>>>> Set additionalProperties to true to address the issue.
>>>>>>
>>>>>> I do not see anything addressed here, except making the binding
>>>>>> accepting anything anywhere...
>>>>>
>>>>> I not wanna add vendor protocols in arm,scmi.yaml, so will introduce
>>>>> a new yaml imx.scmi.yaml which add i.MX SCMI protocol extension.
>>>>>
>>>>> With additionalProperties set to false, I not know how, please suggest.
>>>>
>>>> First of all, you cannot affect negatively existing devices (their
>>>> bindings) and your patch does exactly that. This should make you
>>>> thing what is the correct approach...
>>>>
>>>> Rob gave you the comment about missing compatible - you still did not
>>>> address that.
>>>
>>> I added the compatible in patch 2/6 in the examples "compatible =
>> "arm,scmi";"
>>
>> So you claim that your vendor extensions are the same or fully compatible
>> with arm,scmi and you add nothing... Are your extensions/protocol valid for
>> arm,scmi?
> 
> Yes. They are valid for arm,scmi.
> 
>  If yes, why is this in separate binding. If no, why you use someone
>> else's compatible?
> 
> Per SCMI Spec
> 0x80-0xFF: Reserved for vendor or platform-specific extensions to
> this interface
> 
> i.MX use 0x81 for BBM, 0x84 for MISC. But other vendors will use
> the id for their own protocol.

So how are they valid for arm,scmi? I don't understand.



Best regards,
Krzysztof


