Return-Path: <linux-kernel+bounces-152903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6908AC5F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2F51F2124B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431584D5AA;
	Mon, 22 Apr 2024 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0E7xJ4aB"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01304CE05;
	Mon, 22 Apr 2024 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772174; cv=none; b=iM2NbnXjAO3yO2FAh311CaefDFwC57J+3JUq7BO/2T6m2/WygZrKxfTfII9XtdiQadtM+4OqscuuKLtnl7JL9OjR/o+DAfvh1fwjuFzEIaw+3Wi78Ry6H2CLsPeXNNn23HXkzF9ZKnCsw+6BS9aOaDlrN1Zkth0Jqz4ltogo47k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772174; c=relaxed/simple;
	bh=BYZdKxYmj8SkYixzwReLHnNnVyK/zqpbBVvuT2PSauY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRdYXc8iJqXf1rI/QipirDsYUU6FDZ7a+9KcRtuPKi3UCzKM1/JaKyQToffYmsIzv0+/Jnz/lUOfeZY0vZUs/H/koSFOhB1XthqwquMoO+Djdg0ha0h9kcJOD/oTsUSiOKp3OHpTUeIJoYzNH7WAB/fvPAS2jH8ALaHBhI0SkQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0E7xJ4aB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713772170;
	bh=BYZdKxYmj8SkYixzwReLHnNnVyK/zqpbBVvuT2PSauY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=0E7xJ4aBLe8dfoQFa7zSZuCfGVa1dp3todBYbpWwRtc4wn3NbnduJz9yR/7KkDINl
	 jk1ZPROjt6zi3jkyRIdkjIk7hKwHII/w578SZ0zQql/Cx+YkYCJ/cHAugsrlJ+WLkX
	 9RFwn7gbAf65M91i/PYqgIO7QHhzIg7Tc9zrcxTPJOQgnMt2dO3g85TKMQQ06huxB2
	 zqo51yFoZQbo7PIbOYXy0llC8Yjx9mLiY0mwhoWNcdTfTUfjiZnBrUG3I3+WuJNfDU
	 CYKv1fg9bHW7Akdqh02aUYH2u1gE88lEKliqugzMu/b30TRf4TQRT/JDiLSnmWawiv
	 g4bQKR+7v/KtQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 12CA837800DE;
	Mon, 22 Apr 2024 07:49:30 +0000 (UTC)
Message-ID: <47a25b01-b087-4a3d-9af9-07bb58c8d5b8@collabora.com>
Date: Mon, 22 Apr 2024 10:49:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: riscv: add Milk-V Duo S board
 compatibles
To: Michael Opdenacker <michael.opdenacker@bootlin.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Chao Wei <chao.wei@sophgo.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240421055710.143617-1-michael.opdenacker@bootlin.com>
 <20240421055710.143617-2-michael.opdenacker@bootlin.com>
 <c30cc11a-209a-4919-a382-7588daff0d71@linaro.org>
 <b1f59075-f2b0-4f2c-aea3-bc596ac45f1c@bootlin.com>
 <71f2e031-41b0-4a47-9bdd-e8fb6334da5d@linaro.org>
 <505a8cea-5b0e-4ecf-b566-e68b37b2d4ed@bootlin.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <505a8cea-5b0e-4ecf-b566-e68b37b2d4ed@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Michael,

On 4/22/24 9:23 AM, Michael Opdenacker wrote:
> 
> On 4/22/24 at 06:24, Krzysztof Kozlowski wrote:
>> On 21/04/2024 20:55, Michael Opdenacker wrote:
>>> Hi Krzysztof
>>>
>>> On 4/21/24 at 16:12, Krzysztof Kozlowski wrote:
>>>> On 21/04/2024 07:57, michael.opdenacker@bootlin.com wrote:
>>>>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>>>>
>>>>> Document the compatible strings for the Milk-V Duo S board[1] which
>>>>> uses
>>>>> the SOPHGO SG2000 SoC, compatible with the CV1812H SoC[2].
>>>>>
>>>>> Link: https://milkv.io/duo-s [1]
>>>>> Link: https://en.sophgo.com/product/introduce/cv181xH.html [2]
>>>>>
>>>>> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>>>> ---
>>>> Where is the changelog? It's v6!
>>> Oops, it was in my cover letter
>>> (https://lore.kernel.org/linux-riscv/20240421055710.143617-1-michael.opdenacker@bootlin.com/T/#t),
>>> which you didn't get because of get-maintainer.pl. As the recipients are
>>> patch dependent, am I supposed to describe the changes in all patches
>>> and not only in the cover letter?
>> If you do not send the changelog to everyone, then yes, please describe
>> respective changes in each patch.
> 
> Ok, will do, thanks!
> 
>>
>> It's your choice, but if you decide not to send cover letter to some
>> folks, then *it does not exist* for such folks.
> 
> Well, actually, I shouldn't have let get-maintainer.pl decide for me. Is
> there a way to send the cover-letter to the union of people who will
> receive the individual patches?

You may call get-maintainer.pl once for all the patches in the series
(e.g. use a glob pattern to select all needed files) and then manually
edit the cover letter to provide the 'To:' and 'Cc:' fields.

Additionally, you could use '--to-cover --cc-cover' arguments passed to
'git send-email' so that all those recipients will receive all patches.

Alternatively, you may try the b4 utility [1], which is able to automate
most of the manual steps.

Hope this helps!

Regards,
Cristian

[1]: https://b4.docs.kernel.org/en/latest/contributor/prep.html

