Return-Path: <linux-kernel+bounces-9574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675CA81C7CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B681C24F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E874A10A0D;
	Fri, 22 Dec 2023 10:03:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E085156C3;
	Fri, 22 Dec 2023 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 4C6C324E2DC;
	Fri, 22 Dec 2023 18:03:37 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 22 Dec
 2023 18:03:37 +0800
Received: from [192.168.125.131] (113.72.145.47) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 22 Dec
 2023 18:03:36 +0800
Message-ID: <11c932a8-5596-4186-9c9d-ec8ca5a6ea35@starfivetech.com>
Date: Fri, 22 Dec 2023 17:55:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: ASoC: Add Cadence I2S controller for
 StarFive JH8100 SoC
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Conor Dooley <conor@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Claudiu Beznea
	<Claudiu.Beznea@microchip.com>, Jaroslav Kysela <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>, Walker Chen <walker.chen@starfivetech.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
References: <20231221033223.73201-1-xingyu.wu@starfivetech.com>
 <20231221033223.73201-2-xingyu.wu@starfivetech.com>
 <20231221-saddlebag-tricolor-d02a17d66795@spud>
 <f1210b31-25af-4cbd-b73e-2a72aa6c41bf@sirena.org.uk>
From: Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <f1210b31-25af-4cbd-b73e-2a72aa6c41bf@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag

On 2023/12/21 21:58, Mark Brown wrote:
> On Thu, Dec 21, 2023 at 01:53:00PM +0000, Conor Dooley wrote:
>> On Thu, Dec 21, 2023 at 11:32:22AM +0800, Xingyu Wu wrote:
> 
>> > +  cdns,i2s-max-channels:
>> > +    description: |
>> > +      Number of I2S max stereo channels supported by the hardware.
>> > +    $ref: /schemas/types.yaml#/definitions/uint32
>> > +    minimum: 1
>> > +    maximum: 8
> 
>> Mark, is there no common property for this kind of thing? That said,
>> there's one device here so the number is known at present.
>> Another note, this property is not required, so it should have a
>> default.
> 
> I wouldn't expect this to be a property in the first place, as currently
> presented this is specific to a single instance of the IP in a single
> SoC.  In general this is something that is obvious from the compatible
> and doesn't need a property, it's only plausibly useful for Cadence and
> Designware which is a very short list of vendors.

The Cadence I2S can support 8 channels. But on the JH8100 SoC, two instances of this just provide 4 channels to use, one just provides 2 channels, and the other one can provide 8 channels. Should I use the property name of 'jh8100,i2s-max-channels' instead for some special instances on the JH8100 SoC?

Best regards,
Xingyu Wu

