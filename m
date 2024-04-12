Return-Path: <linux-kernel+bounces-143286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBCF8A36C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCF628356C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AC31514C0;
	Fri, 12 Apr 2024 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TAz6tPM/"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E18C1509B6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712952626; cv=none; b=sS8BjYsCzpolm5QJzVlzbxryyrf1tFcNp0V5d7vTnvGOSRRJF9CcyvoS36ukrJWEEZPMl2slxuUVb/KkmgEuMzDnEnzHZ7ES8Y80W2iEcJaANY4/vX9h6OSMZBd7me2wVFFKdD7eFSTSpaLxUcmI3hKXzK60Psb22MtMCs10fgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712952626; c=relaxed/simple;
	bh=gFQn3ngIBB45TI7clk8deVKnQbHxoIV+WWeqJbiQMkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L62i6dYiGh+2JCj9rLRrsUlhuNekPP2SPdJxvDh91m8IMEYheERRggjxp1OwxIc/iGJntz5WfY6kNg2GbvreEJngTOliDdt3h/NjNVoymbwG694wTJlC3sR4sHH48nTyfmoslmQ0T1f/fEB7y2IwP6Mfd6GJDtj0FrvLgdSGgw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TAz6tPM/; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a6bc828d-9e1f-4932-bcf7-314de74b21cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712952622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/8POj1G6HzMpHHIXHNk18gOsDA3y61c3GGrDYww5pA=;
	b=TAz6tPM/B1vIxMkR55PEagsWcY/pZ1Fnp1X8EqCQ1aCpM+6D4rIMfKXo1pXxbtSkJYi7pY
	Jm7WG8YzPX/6YWP0bJCs3xFUspaXGodk/UrQAYXpta7Rn8lvXw6bNxxlcYTQyJyCtSCp2C
	muc13Owvry3OVp14OY1P0Jd1QjDo4ds=
Date: Fri, 12 Apr 2024 16:10:15 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4.19 000/175] 4.19.312-rc1 review
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <ZhmPpo+EI9Ce3bI1@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/12/24 15:46, Pavel Machek wrote:
>> Sean Anderson <sean.anderson@linux.dev>
>>     soc: fsl: qbman: Use raw spinlock for cgr_lock
> 
> As we don't have commit ef2a8d5478b9 ("net: dpaa: Adjust queue depth
> on rate change") in 4.19, we should not really need this. Plus, 10msec
> under raw spinlock is quite evil, such kernel is not realtime any
> more. We should not be doing that.

Patches welcome :)

At some point I will try and revisit this.

--Sean

