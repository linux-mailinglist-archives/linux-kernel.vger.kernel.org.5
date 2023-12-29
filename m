Return-Path: <linux-kernel+bounces-12994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DCC81FE27
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3E21F21B60
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929F47493;
	Fri, 29 Dec 2023 08:34:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2603E7472;
	Fri, 29 Dec 2023 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 86F1B8068;
	Fri, 29 Dec 2023 16:34:21 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 29 Dec
 2023 16:34:21 +0800
Received: from [192.168.125.131] (183.27.96.32) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 29 Dec
 2023 16:34:20 +0800
Message-ID: <48943ae1-1d7f-44a6-97de-d2999b5f72a2@starfivetech.com>
Date: Fri, 29 Dec 2023 16:31:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] ASoC: starfive: Add drivers of Cadence
 Multi-Channel I2S Controller
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Claudiu Beznea
	<Claudiu.Beznea@microchip.com>, Jaroslav Kysela <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>, Walker Chen <walker.chen@starfivetech.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
References: <20231221033223.73201-1-xingyu.wu@starfivetech.com>
 <20231221033223.73201-3-xingyu.wu@starfivetech.com>
 <861f9b28-863d-48b0-8491-add4a286597e@sirena.org.uk>
 <c94b377a-1e21-4361-ae82-ca84d1dce60a@starfivetech.com>
 <27155281-573c-493d-96fe-1f28ebb0ce5e@sirena.org.uk>
From: Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <27155281-573c-493d-96fe-1f28ebb0ce5e@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag

On 2023/12/22 20:39, Mark Brown wrote:
> On Fri, Dec 22, 2023 at 05:11:17PM +0800, Xingyu Wu wrote:
>> On 2023/12/21 20:55, Mark Brown wrote:
>> > On Thu, Dec 21, 2023 at 11:32:23AM +0800, Xingyu Wu wrote:
> 
>> >>  sound/soc/starfive/cdns-jh8100-i2s-pcm.c | 262 ++++++++
>> >>  sound/soc/starfive/cdns-jh8100-i2s.c     | 727 +++++++++++++++++++++++
>> >>  sound/soc/starfive/cdns-jh8100-i2s.h     | 171 ++++++
> 
>> > If this is a Cadence IP why is the entire driver SoC specific?
> 
>> This a new driver about this Cadence I2S controller. Should I create a new folder and file like this:
> 
>> sound/soc/cdns/cdns-i2s*
> 
>> and I use different compatible to support other SoC like JH8100?
> 
> Yes, that seems more what I'd expect - with a fallback compatible for
> things that don't need any special quirks.

Okay, I will modify these in next version.

Thanks,
Xingyu Wu

