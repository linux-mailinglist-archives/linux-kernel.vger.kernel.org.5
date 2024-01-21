Return-Path: <linux-kernel+bounces-31983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE868354DC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 09:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB9B282C8E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 08:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5777364AF;
	Sun, 21 Jan 2024 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Q24U5l1W"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB514F61;
	Sun, 21 Jan 2024 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705824136; cv=none; b=Y3Bq6fFEZ5V4ZpF3oxp24sKqHB9EeW6U5WUgehRo0iAApTDWlmhS4dvvcqTesqoNx+sCv0vHO7pyLMfchXddEDpqk1/dY/HbnDz3ISiFQfjLMZGEXU3g8bYarsmLRD7FSnzCFbXOjtYLtLuYZhmhLZFyzf0p/7DWT+9DWnMtoE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705824136; c=relaxed/simple;
	bh=lmEl2d7HAt/XbGIN81juIpgwCW99VwCJsVaLTSFIR8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzmbajFjaU5SF8DRBZtU/Mq+jxwML1i1gcqAEm8MH5YRO5OYIAnz5KhvZeWQ6qrckBQWwCseYwUn80NuCD+zovdVRaHZKBepRljZxv9FFdgmQwko+cxG8RIQaSi5tLfLc5rHeSSxN7L5UNHOLbbe2dOeJrpg/QLqz54/8XobyuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Q24U5l1W; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705824117; x=1706428917; i=deller@gmx.de;
	bh=lmEl2d7HAt/XbGIN81juIpgwCW99VwCJsVaLTSFIR8Y=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Q24U5l1WuGkPh74jae0sAt++EHF353b9Nqzp/snjJj6RD1RKPu2X5HPab3vkJePK
	 kQbIyXyWSJA8wTLhP3GJJFZB4hfIGuNa+9AytxoWMc+hHnKMip7HKX74mscIJLXRV
	 rsHG1hfjK6gq9RJOp/Qu8l8E1H0ymdEyPAZ2P+xgm9yoxbaaIVUUOohT+xoRuxjkh
	 egaqadmuN5+5t9twjl0qAMrIjvV5N7Kwq8QBmdUCrAWKrZbLiLuOn6sTZwxsI8J36
	 efzV16qLOuaVBRIEybZfMWi5WggDRJ/PZp3MUm8iX7UL5Ls/ODbOl58PSpBpmzbJI
	 UfESlxeEjPs9LmkCAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.154.190]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGiJ-1rb38I1faF-00REM1; Sun, 21
 Jan 2024 09:01:57 +0100
Message-ID: <fb18e94f-3254-48d1-b260-1c3a7514bd8f@gmx.de>
Date: Sun, 21 Jan 2024 09:01:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fbdev: sis: Error out if pixclock equals zero
Content-Language: en-US
To: Fullway Wang <fullwaywang@outlook.com>, tzimmermann@suse.de,
 sam@ravnborg.org, javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 fullwaywang@tencent.com
References: <PH7PR20MB5925C492B7F8CDACB2386DB4BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <PH7PR20MB5925C492B7F8CDACB2386DB4BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rPKVCaXb0ndO2tg3vgAi1V42uGT3otTXDBMHqCejyzRXKpSEwZl
 wrBIS0IrqQ0kGRVowQuILGo5vUcd/uXFtbPMqpWHsTc6s5Ahf1asxcU7dqYNVivdH1+1nK/
 MO4l8gdOaWGjkX/YMgbnxElXpkqLK2iT7AGNWBPJf7VAjl0uEk6QyNapl8wAW5UxH7A9flZ
 XTEL4vOBYaps/A1OczL4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U+LjjRAcEUk=;1D46GZPLBjz3tYeDKRVyT3rZXNG
 Cy7gdqKck1qX+M3pAlK8zBuGdyhA7m31D7W2OclwfiBuBM6aZr25NFo9isLq1zjr3q353ZjeI
 /1lGrm7bkQ6cxWeJuwTNC7MZyLsQzLP0mP9ipT1RkWO+Ncan4g5U+wYYr9dJIDudGcEmn+hsc
 tPwbQWkh+CjIe9Lgag/IXVvIDlsF2sDKY33rQxgdzIZKI0sLWfceYS6tw/TOtbu5ZmlOB16wF
 aXcGOIOINvGBqV0xInOXdIWd6egqLnQitaEL0UAVrCTKqU4si6jbMgcSF9ilUNyfOn5ZrJRUO
 yjMNxrqCQpRPegbEe3ABIeI4ttCEvbuFtKRksM3xFc6Bj1mJX9szHFDS08O01AYxgLnDqPSSz
 H7bAdABJnfH1u1GCZ19HJnfp0YL1NAOkhMXIyugZy1QwcN7kIGJxDP0qQg+SZo2eZneXrKvB9
 S8xBHTj/fhCMpgPMkgv2JVJLtdNvgynZJiFw74t+XW8KZvgFemjGp/T0j+7IsMm8oeMoOofR7
 vaSPI7EfsrCFXQgjceo0qc2C3z4usCnzPtxam2aMM8wxVMF0YmcuTq8Jg5nsNLuVZJPXikjbe
 kyI6J7sEHj8Oi38j4Wo4avJwcZpIOlrErKDka+igCUYZ1jiXA1BJpdD6EHCT4sCq9R5aONldz
 o6wZ4N4RQxh6OjMf+j4SRWexL/RQwTULfHvDRTxoTyaYOURNTS+EiKcQVIp4GLtUBjjnhBl7E
 12D2iElcn83atAxlC/agxh/0YhiQnvux3ck3+9FLbWK5fXoyao+LUjoVizr9gw9SLd7d4OKml
 5L7begdQ2+ivPF48hJ7EDoSXzA/JbMszxHJe3tuw/z8wHWvHLWcD8gkpl5ajc4AFIH4H4KJJE
 nghxVjlWq+uSxNr/j9QczbsMDmzGMHtyIH63On3MV0KuG0euk6mKpC3CQYVLEGOeV8BOmpnQc
 vOl0Jg==

On 1/18/24 07:24, Fullway Wang wrote:
> The userspace program could pass any values to the driver through
> ioctl() interface. If the driver doesn't check the value of pixclock,
> it may cause divide-by-zero error.
>
> In sisfb_check_var(), var->pixclock is used as a divisor to caculate
> drate before it is checked against zero. Fix this by checking it
> at the beginning.
>
> This is similar to CVE-2022-3061 in i740fb which was fixed by
> commit 15cf0b8.
>
> Signed-off-by: Fullway Wang <fullwaywang@outlook.com>
> ---
>   drivers/video/fbdev/sis/sis_main.c | 2 ++
>   1 file changed, 2 insertions(+)

I've applied this patch and your savage patch to fbdev git tree.

Thanks!
Helge


