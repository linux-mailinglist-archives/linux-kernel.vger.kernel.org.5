Return-Path: <linux-kernel+bounces-116699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8927688A943
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B67FFBE2F88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2557515250F;
	Mon, 25 Mar 2024 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="RQbj2c4f"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D615358D;
	Mon, 25 Mar 2024 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355565; cv=none; b=CaL9dHMjUd5qadTuQUyMQ9IMRThagU9Zdkc5uJ39fn2z3XSCVtRLqjuQVP4cZ6X5vjVTriQ82s0O5hf7ePDfpT1EePe6ba4YPaw87yIRfp/rxm5nQV0laDA2xjDwopAmr61BgbmeZX4FKf3mtXLGJ/trxNDeg+uQU6ZEgqkolHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355565; c=relaxed/simple;
	bh=T+KuV9HtfJVCbl6FShyoCjfSusY83MHIQ6USqsqqlDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thx/IQmgbVIvo7vSrc7jBOEGiHo32I+RQGamRxzMjptuvZLyWkmehOrXrJzGizjnqUDUea2txEt5p8hF10u8sbbwVgfQ9+F1dT7aN8HvWTP0UmW2ne9BbB49eqTvWpf/jjauEASZjizYn6AwiDuSVBX86MXxezRtuKm6D1X0eWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=RQbj2c4f; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YrCunCuDAyPCrU96nP770AWQf4NmnthgUBMgNyJAu48=; b=RQbj2c4f2qRXjxr4gX4KrktSa7
	6pyVjGvANCdMY6rnYJZKgB2zZmHJ3xsm0+Wixre/iPhruVV6Q8Rr5rOQylqcDU4EcbRPViemr4e6c
	J0VLDwjgtUPZCykZG5tFV6kGJXBIeB1sGDCPaB4tNwMw4sU862lgtI/zeHmQaAvjFUK+EYzG19ZXZ
	Oi75f0rgsWuFu+iC6Z0ucvxHveT9Rk9Eobz2AOGtM7Y48GjhOEfiwnDCOnH+kIRM3BXlyPhmHqOxL
	YwJqunzsdxF4bC5Gq2g9OUn4h3B9qP2ONgFqhpyU7B6Sfv55eWTaneVMl4RZx28Ckwe1wBEkatnTK
	pNPIk68A==;
Received: from [89.212.21.243] (port=33976 helo=[192.168.69.84])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1rofky-009ZHa-1T;
	Mon, 25 Mar 2024 09:32:36 +0100
Message-ID: <3423ea96-859d-4c4b-a9a7-e0d9c3c00727@norik.com>
Date: Mon, 25 Mar 2024 09:32:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] i.MX93 ADC calibration settings
Content-Language: en-GB
To: Jonathan Cameron <jic23@kernel.org>
Cc: haibo.chen@nxp.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, lars@metafoo.de, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 upstream@lists.phytec.de
References: <20240320100407.1639082-1-andrej.picej@norik.com>
 <20240324135559.1640551d@jic23-huawei>
From: Andrej Picej <andrej.picej@norik.com>
In-Reply-To: <20240324135559.1640551d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Jonathan,

On 24. 03. 24 14:55, Jonathan Cameron wrote:
> On Wed, 20 Mar 2024 11:04:04 +0100
> Andrej Picej <andrej.picej@norik.com> wrote:
> 
>> Hi all,
>>
>> we had some problems with failing ADC calibration on the i.MX93 boards.
>> Changing default calibration settings fixed this. The board where this
>> patches are useful is not yet upstream but will be soon (hopefully).
> 
> Tell us more.  My initial instinct is that this shouldn't be board specific.
> What's the trade off we are making here?  Time vs precision of calibration or
> something else?  If these are set to a level by default that doesn't work
> for our board, maybe we should just change them for all devices?
> 

So we have two different boards with the same SoC. On one, the 
calibration works with the default values, on the second one the 
calibration fails, which makes the ADC unusable. What the ADC lines
measure differ between the boards though. But the implementation is 
nothing out of the ordinary.

We tried different things but the only thing that helped is to use 
different calibration properties. We tried deferring the probe and 
calibration until later boot and after boot, but it did not help.

In the Reference Manual [1] (chapter 72.5.1) it is written:

> 4. Configure desired calibration settings (default values kept for highest accuracy maximum time).

So your assumption is correct, longer calibration time (more averaging 
samples) -> higher precision. The default values go for a high accuracy.
And since we use a NRSMPL (Number of Averaging Samples) of 32 instead of 
default 512, we reduce the accuracy so the calibration values pass the 
internal defined limits.

I'm not sure that changing default values is the right solution here. We 
saw default values work with one of the boards. And since the NXP kept 
these values adjustable I think there is a reason behind it.

Note: When I say one of the boards I mean one board form. So same board 
version, but different HW.

Best regards,
Andrej

[1] i.MX 93 Applications Processor Reference Manual, Rev. 4, 12/2023

