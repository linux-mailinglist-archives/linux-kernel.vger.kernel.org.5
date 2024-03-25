Return-Path: <linux-kernel+bounces-116721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2D688AB38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3F1B37C89
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9850715DBA0;
	Mon, 25 Mar 2024 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="XY9PQcdX"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7415FA78;
	Mon, 25 Mar 2024 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356927; cv=none; b=PgFSpTo0fwRZ8BVeAhevba/n2Nk9OULtjnnCR6ypaKmI0vF6Fgrz92elQJu4hKNdIvkWgemMDsU+lZP4S/6EdHuuDyGuldyaEqMjlfJFv3Bo3+joYT1A41IQjtDb15vgWk3pVXj0dK0Njwb06kEAJfR5Kep7I15PdQ29hk2AsKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356927; c=relaxed/simple;
	bh=9Zx5nFRmvcxOO0R4A2j6vwLiz60QZij0S1cVKtpLzGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DC4uYJrMWWKDUeQu2h/Ro+UCS8gnsqKxwcSE0XxaoLE+YaMQkZRpRS9FC4ckKvjLyL7K249A7G7cP14pGdg2v/Zo4nIr2pd4fE+MW64QbQCfIrt/HQKQWY7dW9jlWEiQnw02aX0y0ngsWR7RfpupTkoJnc/edxgY1Gsx21ZzIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=XY9PQcdX; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F6rSXpona0HdJDPphQfQZFWovV+BlIiwnVNpbjTN1io=; b=XY9PQcdXeEv9WDvOA7E9F8Tk18
	Zf9e74xVOMNr1mpIDwfutyg9bT6NEGXysqew9xEiIm/Zg3JVTtHyG6VHivJPlo3oS5RE1yspmIgn8
	AyolnG90VhozWvoasNtl7KjaiHHFCQbpeGsMdK1PE3OTpQRC+lvmkZhAWgz579TyqIC0MhBk5wxih
	CQVdABAkspZTKofRXjEfb5QNK1WNcmJa5x/WTzDere7Dub35txCIoNc/h2IEJ+A9GxK9HrkT/o6Av
	6a35y9O1NFTsfJRu3llqaxe70OrK4FyS98E13TwRe5UFRlAPA0wrFXm1u3VoYg+Yx9vG8Qb1SfooF
	4f263Ozg==;
Received: from [89.212.21.243] (port=35446 helo=[192.168.69.116])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1rog72-009eRJ-0N;
	Mon, 25 Mar 2024 09:55:24 +0100
Message-ID: <44ac8977-cf98-46a5-be15-1bec330c6a2e@norik.com>
Date: Mon, 25 Mar 2024 09:55:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 0/2] i.MX93 ADC calibration settings
Content-Language: en-US
To: Andrej Picej <andrej.picej@norik.com>, Jonathan Cameron <jic23@kernel.org>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, lars@metafoo.de,
 krzysztof.kozlowski+dt@linaro.org, imx@lists.linux.dev,
 linux-iio@vger.kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
 upstream@lists.phytec.de, linux-kernel@vger.kernel.org, haibo.chen@nxp.com,
 kernel@pengutronix.de, shawnguo@kernel.org, robh@kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240320100407.1639082-1-andrej.picej@norik.com>
 <20240324135559.1640551d@jic23-huawei>
 <3423ea96-859d-4c4b-a9a7-e0d9c3c00727@norik.com>
From: Primoz Fiser <primoz.fiser@norik.com>
Organization: Norik systems d.o.o.
In-Reply-To: <3423ea96-859d-4c4b-a9a7-e0d9c3c00727@norik.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Jonathan,

On 25. 03. 24 09:32, Andrej Picej wrote:
> Hi Jonathan,
> 
> On 24. 03. 24 14:55, Jonathan Cameron wrote:
>> On Wed, 20 Mar 2024 11:04:04 +0100
>> Andrej Picej <andrej.picej@norik.com> wrote:
>>
>>> Hi all,
>>>
>>> we had some problems with failing ADC calibration on the i.MX93 boards.
>>> Changing default calibration settings fixed this. The board where this
>>> patches are useful is not yet upstream but will be soon (hopefully).
>>
>> Tell us more.  My initial instinct is that this shouldn't be board
>> specific.
>> What's the trade off we are making here?  Time vs precision of
>> calibration or
>> something else?  If these are set to a level by default that doesn't work
>> for our board, maybe we should just change them for all devices?
>>

The imx93_adc driver is quite new.

If you look at line #162, you will find a comment by the original author:

> 	/*
> 	 * TODO: we use the default TSAMP/NRSMPL/AVGEN in MCR,
> 	 * can add the setting of these bit if need in future.
> 	 */

URL:
https://github.com/torvalds/linux/blob/master/drivers/iio/adc/imx93_adc.c#L162

So, for most use-cases the default setting should work, but why not make
them configurable?

So this patch-series just implement what was missing from the beginning
/ was planned for later.

BR,
Primoz


> 
> So we have two different boards with the same SoC. On one, the
> calibration works with the default values, on the second one the
> calibration fails, which makes the ADC unusable. What the ADC lines
> measure differ between the boards though. But the implementation is
> nothing out of the ordinary.
> 
> We tried different things but the only thing that helped is to use
> different calibration properties. We tried deferring the probe and
> calibration until later boot and after boot, but it did not help.
> 
> In the Reference Manual [1] (chapter 72.5.1) it is written:
> 
>> 4. Configure desired calibration settings (default values kept for
>> highest accuracy maximum time).
> 
> So your assumption is correct, longer calibration time (more averaging
> samples) -> higher precision. The default values go for a high accuracy.
> And since we use a NRSMPL (Number of Averaging Samples) of 32 instead of
> default 512, we reduce the accuracy so the calibration values pass the
> internal defined limits.
> 
> I'm not sure that changing default values is the right solution here. We
> saw default values work with one of the boards. And since the NXP kept
> these values adjustable I think there is a reason behind it.
> 
> Note: When I say one of the boards I mean one board form. So same board
> version, but different HW.
> 
> Best regards,
> Andrej
> 
> [1] i.MX 93 Applications Processor Reference Manual, Rev. 4, 12/2023
> _______________________________________________
> upstream mailing list
> upstream@lists.phytec.de
> http://lists.phytec.de/cgi-bin/mailman/listinfo/upstream


