Return-Path: <linux-kernel+bounces-38000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E6F83B979
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92F91F228A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2D310A1B;
	Thu, 25 Jan 2024 06:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="boMjTzLZ"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D9910A05;
	Thu, 25 Jan 2024 06:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706163145; cv=none; b=Uywbt9oegfJKsFCoSllql8i0LiHy1yV9f5zSGIWDgolR4b5byG706ssidXadXVoAOkR6xQWskNjLwuddIb956q7YFKb6JypRKi3twKBVeSDhuR/lD9QIhH7b79S0DfaaIdjre/G8UJuh5U4ZYulP3KY8JcbDId5bUxfBOGKux2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706163145; c=relaxed/simple;
	bh=Vq3gANRtuA2pS1oK+Mi+Z+1d6RsxGu2oDbOXzukvJR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGFQ/KUH8r/en/05mKviWaXnsKuwwcd8w9zjh2cbKLhAtDvOMwS/70m2PeWLINbJQPBZXu8okdFYITXBLXsG5/doUV0es3SC/DSArS4IjnsTUxUrwjuVuWq0gnE04I3jrrrd8pP0ZCPF03sYWgnIAVBsF9XtsHN263n2HBKilNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=none smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=boMjTzLZ; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BJiapurcPu0C+QdDAc6vb0IXz4aMVQvrzapKQRt5mHA=; b=boMjTzLZIHjnflyES554D2P8kx
	U+wKi26vbHyr/r2Jhlpom3VY78oa5KExMlhOx8SKmIws2ZGN6j0cHujb0uF7YVgvfSKBzkbapFF1p
	RxZlXilepDIcTWEVXyC8mcYVa/ls9sauoPO0Wnx7wKfZnHrZj68mrjvwMqB04oJlsHV2Wcn+GESH8
	FS0ffHtVP8QtPqPMIIltTb4lmYsx2sHL368DOPIUAF7VBUgszo+1v+3wSoup+NDeaBUOtXZfi6azs
	DUSiICBfyz/ovzsZAv30ee/w7ZCYHS1TlbZd/bzoHRGeGMiHNRh+myzARcZGXH6tTsR3IeDCpLM4f
	JNBREAtg==;
Received: from [89.212.21.243] (port=36528 helo=[192.168.69.116])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1rSsyG-00394O-16;
	Thu, 25 Jan 2024 07:12:15 +0100
Message-ID: <26efc165-7319-434a-82b3-b557949f671d@norik.com>
Date: Thu, 25 Jan 2024 07:12:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93
 support
Content-Language: en-US
To: Wadim Egorov <w.egorov@phytec.de>, Stefan Wahren <wahrenst@gmx.net>,
 Mathieu Othacehe <othacehe@gnu.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Christoph Stoidner <c.stoidner@phytec.de>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, upstream@lists.phytec.de
References: <20240122095306.14084-1-othacehe@gnu.org>
 <20240122095306.14084-4-othacehe@gnu.org>
 <537266fe-0bf7-4208-a9f3-ae27f462c6ed@phytec.de>
 <85fe8c8b-ea08-4f24-9a06-33a5678c1a0a@gmx.net>
 <7944bd80-32d7-4ac3-9c0a-806394262f1c@phytec.de>
 <08ef805a-b041-4db0-aaf7-51d5d06596ff@gmx.net>
 <008317aa-4dd1-4889-8c64-5e4396d83931@phytec.de>
 <47c79a0a-5be0-4ee8-87d4-fd03809a9664@gmx.net> <87o7da4zc1.fsf@gnu.org>
 <f2fcb4d4-b1d7-4d82-a3b0-d06c0ffd906b@gmx.net>
 <13f6edd6-f3ae-4e32-88e9-03355d78153c@phytec.de>
From: Primoz Fiser <primoz.fiser@norik.com>
Organization: Norik systems d.o.o.
In-Reply-To: <13f6edd6-f3ae-4e32-88e9-03355d78153c@phytec.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

On 25. 01. 24 07:05, Wadim Egorov wrote:
> 
> Am 24.01.24 um 18:28 schrieb Stefan Wahren:
>> Hello Mathieu,
>>
>> Am 24.01.24 um 14:48 schrieb Mathieu Othacehe:
>>> Hello Stefan,
>>>
>>>>> Defining line names should be fine. But I would still prefer to have
>>>>> the muxing in an overlay bound to a specific use case.
>>>> I'm fine with this. Unfortunately Mathieu dropped the line names in V5
>>>> today :-(
>>>>
>>>> AFAIR reviewers should have 2 weeks time maximum. This was just 2 days.
>>> I am sorry but it is not easy for me to deal with contradictory input. I
>>> chose to remove the gpio-line-names even though it also seemed like a
>>> nice addition to me. The idea was to not interfere with Phytec plans in
>>> the future.
>> tbh sending v5 before the discussion between Wadim and me was finished
>> made it more complicated. Please keep in mind that some reviewers do
>> this in their spare time, so a response could take some time.
>>
>> In this particular case Wadim and me agreed on a solution, so no action
>> from your side was necessary except a little bit patience.
>>
>> The reason why i suggested the gpio-line-names in the first place is
>> that users doesn't need to care about different versions of the DT files
>> (except the downstream one). Changing the line names afterwards leads to
>> confusion.
>>
>> So before we discuss on a v6, just a question: are on the X16 connector
>> just 2 pins muxable as GPIO? This is hard to believe.
> 
> In theory you can use more of the Pins as GPIOs. But at this point I
> should mention that the Segin board became slightly more complicated
> since it started to support more SoMs with different SoCs. We have
> routings for various pins to help with the compatibility. So the naming
> in the schematics is not really trivial. And IMO the dt should follow
> the naming of the schematics.
> 
> I would prefer to go with v5 without having any namings for now.
> 
> Regards,
> Wadim

This would also be my preference.

Thanks,

BR,
Primoz


