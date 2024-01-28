Return-Path: <linux-kernel+bounces-41883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E5283F92C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DA42820F0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369E72E65B;
	Sun, 28 Jan 2024 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BzuF8bzU"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27198C1F;
	Sun, 28 Jan 2024 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706466756; cv=none; b=KtNeZ5KP9FiipN+M3BsbSrzcO4a5BBYbhJH7qKfvnxuwMs1mpouIn7x7JNwvLL8+OMqkmmd0V1VO5FNFrV8+RNVD3xQigRCXD2Mpo8uH1hSy8XAcuD98M4b+piIiNv9lo+SHMCqod63WxYn6rD9h2Ta7/UKrYCdtXIHdnmK8B6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706466756; c=relaxed/simple;
	bh=uTT/jcj1NmTzHT+D89Z39WUaWCXDZ3FlJM+w3u9zLuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4s4IBRK7NtRtVpogcUWv6cHGeMIHjltn0vRjNwk3qoJuHLDQxBTNocEer18bJpzIy2ye8Q9ViAN5FtE8mtECXB+MGcti3oY1XaZZvIInUjL/W7y5KInE1RzPyDsK3aHInoDgY5XFtmaRJXA2nbaSWi9aQ0FzpvInOotiLGCQ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BzuF8bzU; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.123.161] (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3DEB63F2CA;
	Sun, 28 Jan 2024 18:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706466218;
	bh=Vutysr8zKp94azivfu5X8ZtSSGaT9WFnXqrtSd/Jfpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=BzuF8bzUYA4t+yxx6PQycQS2U0JOsRK15YX6jpA/cIdC/LtCrqjhTAc1GDGQHC8S5
	 PkncFd4yspBegHIhL9r4HaKXwhcbboBrohdvi/PiewF49cbKQ9yt+pi6FeKddDGG6p
	 WK+KyyQBfLeEq5RqC3uNKmNWhZyAt+oFC7Pv+MYefkkwqx99PPF15XJOtDvlv65ESu
	 P98N0bXOT27F25UfRNzn46YitsyxrbcB1cOM0EmtMsPzNpT33onSeyUZBxbxhWHt6B
	 peORJ9cMegLl91r3oSEQBK5B/BYIKh+I31hbcdY/NGf70Va4ou/c0hUZ8+q+EVwvqZ
	 ylMv858ZtReew==
Message-ID: <3f751ed6-871e-424e-a50e-4362e1bfb527@canonical.com>
Date: Sun, 28 Jan 2024 19:23:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: riscv: cpus: reg matches hart ID
Content-Language: en-US, de-DE
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240128180621.85686-1-heinrich.schuchardt@canonical.com>
 <20240128-simile-endocrine-9e8af979d361@spud>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240128-simile-endocrine-9e8af979d361@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/28/24 19:20, Conor Dooley wrote:
> On Sun, Jan 28, 2024 at 07:06:21PM +0100, Heinrich Schuchardt wrote:
>> Add a description to the CPU reg property to clarify that
>> the reg property must match the hart ID.
> 
> That is the expected usage alright. Did you come across something where
> it was not being used in that way?

No. I was simply missing it in the documentation.

There is a page 
https://www.kernel.org/doc/Documentation/devicetree/bindings/riscv/cpus.txt 
but that seems not to be generated from the kernel tree.

Best regards

Heinrich

> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Cheers,
> Conor.
> 
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   Documentation/devicetree/bindings/riscv/cpus.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> index f392e367d673..fa9da59d9316 100644
>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> @@ -74,6 +74,10 @@ properties:
>>         - riscv,sv57
>>         - riscv,none
>>   
>> +  reg:
>> +    description:
>> +      The hart ID of this CPU node.
>> +
>>     riscv,cbom-block-size:
>>       $ref: /schemas/types.yaml#/definitions/uint32
>>       description:
>> -- 
>> 2.43.0
>>


