Return-Path: <linux-kernel+bounces-143298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6898A36EE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA1F1C22AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F071514C4;
	Fri, 12 Apr 2024 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p7jt+z9c"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66582150990;
	Fri, 12 Apr 2024 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712953111; cv=none; b=BE3grueGpCVy+RxOtZDufurX+iN+3mJkkwLkB/SEtyTdb6NLMU49aVAUgdDD58sYKXyJ/Gv1xtsuJ1vzxTAbhQ6EVwDZBo47/QAjcUPPtLmEPlOveGa90qw+0RLIz93P5eisIG+yne9smNwVeYya54+0fMsSUtlFTTUV5GU9Okw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712953111; c=relaxed/simple;
	bh=+8yd8nRZnsK4xoNUZ2lOwNHS5meRrf+aFzhiGaoSBD0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HHpl93OB7FAFjPom8D/hDUnG6+4Daz0JP5VnTX0uwvLobqJIkpTZEO+OfknB9yoBCMdcFcVeCE0UGD7V4otN9Ll9ndxAsv0uDfwIVK4zNdp3TEuqOSoLgiL2/aQZngQC1k97x04qVe4tt9b2SjW8bYrTUpiTB6zxCq/65MhWpNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p7jt+z9c; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7040a36b-b74a-41df-bd84-093b0e97a6b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712953107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLHlIUYkkULgzyqbRS6FF1LI5GIXKe6Pa6vjv4BQWm8=;
	b=p7jt+z9cc4v9PIS8lyAxIEXownkEIzBPe2g/oZJocDj4+m7XfpeRT8+5MwP1cGjSpwfvEH
	97EB0INVEdoR8NvS9SGgD7uUEnXN+IrXV35yevhrSx32zgnj95OyuNzJ51zSnNGtSUxKV2
	9ajPlMK08u5WN2ucsSuKB2G77y3VFAI=
Date: Fri, 12 Apr 2024 16:18:01 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4.19 000/175] 4.19.312-rc1 review
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Pavel Machek <pavel@denx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 maco@android.com, tglx@linutronix.de, christophe.jaillet@wanadoo.fr
References: <20240411095419.532012976@linuxfoundation.org>
 <ZhmPpo+EI9Ce3bI1@duo.ucw.cz>
 <a6bc828d-9e1f-4932-bcf7-314de74b21cc@linux.dev>
Content-Language: en-US
In-Reply-To: <a6bc828d-9e1f-4932-bcf7-314de74b21cc@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/12/24 16:10, Sean Anderson wrote:
> On 4/12/24 15:46, Pavel Machek wrote:
>>> Sean Anderson <sean.anderson@linux.dev>
>>>     soc: fsl: qbman: Use raw spinlock for cgr_lock
>> 
>> As we don't have commit ef2a8d5478b9 ("net: dpaa: Adjust queue depth
>> on rate change") in 4.19, we should not really need this.

Sorry, I missed this the first time around, but this bug will still
occur (just much more rarely) without this commit.

--Sean

> Plus, 10msec
>> under raw spinlock is quite evil, such kernel is not realtime any
>> more. We should not be doing that.
> 
> Patches welcome :)
> 
> At some point I will try and revisit this.
> 
> --Sean


