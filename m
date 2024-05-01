Return-Path: <linux-kernel+bounces-165841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063998B9242
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982B01F211AD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8C1168B09;
	Wed,  1 May 2024 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="cfBYHfFj"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AC5168AE2;
	Wed,  1 May 2024 23:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605771; cv=none; b=BPJEdmXNdUNGE28q5wjvv6G74OiMfHUxpFAJEYTjvHXCICZpl3HVskSr/L7RHXttRZGiC6r62tfIb+/udSBpDB3NLLLUqz3IIMA+4qwDg5rhEU/8BqPRMHXSUc8aPdSRDr4lF0jT29YdJEPJ5ZOnhiaimPItq19co7bCYlwdzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605771; c=relaxed/simple;
	bh=ASG9oeBUFZtM4xnfSdSwMJ0RkzBAhW91WAMIIg//66I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRkURIZfIntfuSrj9d5nsoSpe1TAFKge0He/qMtwNIOSrBOUaGNgeQdfZXKjJ5UvQ6TdOEMPvOowAaW7HFnfNHpYFfbnKrvRNfKoTepprREOEHOOr62Jyt1txo4znfn8xrmx++4b1QyffMH7iqKiF5/B1I36y4dZ9FaErYQp72Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=cfBYHfFj; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 36D3A1E4;
	Wed,  1 May 2024 16:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1714605337;
	bh=LA75uaniDW9QbvPNlFYPb/h62PSnV3LT98zz/24EjcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cfBYHfFjUj9spCXIvTPWoe0grN9GBk4zZD9EBNPT87kJNyFwebFs8KOjPnsicacQr
	 3gKXWVTe/LlFNeucZ4NxYj9sGXdQ6ORmlSWWuH+Q8qoCq/4fkVB1dnYiEjfLgPkRok
	 PV+61sd320i63fCX0lJIFAdzcI561zcirWD1SKvo=
Date: Wed, 1 May 2024 16:15:35 -0700
From: Zev Weiss <zev@bewilderbeest.net>
To: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: Add ASRock SPC621D8HM3 BMC
Message-ID: <561b69da-f4e4-49df-ac3e-db0003d549e0@hatter.bewilderbeest.net>
References: <20231120121954.19926-4-zev@bewilderbeest.net>
 <20231120121954.19926-6-zev@bewilderbeest.net>
 <CACPK8Xf6vRKJZHuovMXd2h=nnuKW4m5mcRrfZaTsY987Ai6huQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACPK8Xf6vRKJZHuovMXd2h=nnuKW4m5mcRrfZaTsY987Ai6huQ@mail.gmail.com>

On Mon, Apr 29, 2024 at 06:23:27PM PDT, Joel Stanley wrote:
>Hi Zev,
>
>On Mon, 20 Nov 2023 at 22:50, Zev Weiss <zev@bewilderbeest.net> wrote:
>>
>> This is a Xeon board broadly similar (aside from CPU vendor) to the
>> already-support romed8hm3 (half-width, single-socket, ast2500).  It
>> doesn't require anything terribly special for OpenBMC support, so this
>> device-tree should provide everything necessary for basic
>> functionality with it.
>
>We've had these in the aspeed tree for a while, but as I was on leave
>there was no pull request. I'm just putting one together now and
>noticed some unusual looking device tree compatibles:
>
>WARNING: DT compatible string "renesas,isl69269" appears un-documented
>-- check ./Documentation/devicetree/bindings/
>#220: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts:181:
>+        compatible = "renesas,isl69269", "isl69269";
>
>WARNING: DT compatible string "isl69269" appears un-documented --
>check ./Documentation/devicetree/bindings/
>#220: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts:181:
>+        compatible = "renesas,isl69269", "isl69269";
>
>WARNING: DT compatible string "st,24c128" appears un-documented --
>check ./Documentation/devicetree/bindings/
>#230: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts:191:
>+        compatible = "st,24c128", "atmel,24c128";
>
>
>Can you update the patch to be checkpatch clean when applied to v6.9?
>
>Cheers,
>
>Joel

Hi Joel,

After looking at it a bit, I *think* the third warning above (st,24c128) 
is a false positive due to the checkpatch script's ad-hoc grep of the DT 
binding files not picking up on the regex-based compatible definition in 
Documentation/devicetree/bindings/eeprom/at24.yaml -- AFAICT, the 
compatible strings match what's described in the comment in that file 
(and the actual regex itself I believe).

The isl69269 warnings are certainly legitimate though; I'll submit a v3 
with that added to trivial-devices.yml.


Thanks,
Zev


