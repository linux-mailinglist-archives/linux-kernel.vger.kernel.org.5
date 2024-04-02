Return-Path: <linux-kernel+bounces-127456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A02894BA2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C911C22679
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D707F2BD00;
	Tue,  2 Apr 2024 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shjh6Jig"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA9D25575;
	Tue,  2 Apr 2024 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712040154; cv=none; b=H3/fU9sIfOqKLZHs/aGoAmJQuMyBnEkp7O1VfKFY8J7x+jqDQPnV2e2/cQqNnYzmgALlPb+8Z7KpWwwE29YefnomDRoFu04AR+9AXl7JzvI0KubGwjGKJ/jsqLxVFyFt0iA69FIpPyeyBoBE5C0ksZ/wJ3QMOUqYXhZG0ES4SYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712040154; c=relaxed/simple;
	bh=UuMVNu47ABLBwufUz8vcoU7JSIfgVrnEYBWKR50X9fY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMdOCiAyIaSTX56mj0vy6dmTmoeCehMDSivfo+odMC1opjN2QPLB0U53sVCuZz/xCqAMpKQBf09XniU7WCQBB+MsL2KsY4cx5GCgoeLteEErFtqCW2By/H0bvhpoVKPu3UbKxpa2ylc7AD/sStJtgCYS+Bazats0N76bgohGlmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shjh6Jig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE9AC433C7;
	Tue,  2 Apr 2024 06:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712040153;
	bh=UuMVNu47ABLBwufUz8vcoU7JSIfgVrnEYBWKR50X9fY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=shjh6Jig+ZoH1RaX8rAd1oLwZc3beqCbk06d2YrjhZZakbSRaOaCcUkdS2Jk33a4r
	 74wNJPLvApWAIDkyM4ShU/RLTeE2tKDOaKQlS2AhAxgzbXylB76aw2TLfxT6tAHEVv
	 /kI0kBkN2FSZqLRo3o7nUrNqtRVvVnvhzUf6/TLb8ufmkeAF+KRJ2vpvRQ/Un1GFAn
	 At8sY8yfxlLN7DAateOcrZAhX+z3gT2r7lMv6sMVH1EjOCZGNZE+Rn1fJA+Pfy+lNj
	 yZCvx5S8d5YGW7KSrOrmN4+0DThR6ebFxM3poAdEji+RX46Xx78V2fXu1cu9on6IXu
	 WGmpi6blQof7Q==
Message-ID: <d62656e8-adc1-4e29-9b79-7322eacba980@kernel.org>
Date: Tue, 2 Apr 2024 15:42:31 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: ata: ahci-da850: Convert to dtschema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327064354.17384-1-animeshagarwal28@gmail.com>
 <d5429736-8305-4afe-89a8-fe62907616e1@kernel.org>
 <971be9ec-44a2-48cb-8d67-a4d4ce3b7d46@linaro.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <971be9ec-44a2-48cb-8d67-a4d4ce3b7d46@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/24 15:41, Krzysztof Kozlowski wrote:
> On 02/04/2024 01:40, Damien Le Moal wrote:
>> On 3/27/24 15:43, Animesh Agarwal wrote:
>>> Convert the ahci-da850 bindings to DT schema.
>>>
>>> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
>>
>> Krzysztof, Rob,
>>
>> Are you OK with this patch ?
> 
> You got Conor's review, who is DT maintainer.

I missed the fact that Conor is a maintainer. I should have checked :)
Thanks !

> 
> Best regards,
> Krzysztof
> 

-- 
Damien Le Moal
Western Digital Research


