Return-Path: <linux-kernel+bounces-70205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8E08594C3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D543F1C2107E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED7E4C8E;
	Sun, 18 Feb 2024 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="NxEqw/4h"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093064C6F
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 05:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708233996; cv=none; b=ArM/5EFoH2bPIAi09Ykyu8nv1rJIXUYx7HEGkGIRnRB0SNB1M6+dm/3HLBArGZ+b1j8ALnTKDPZTUz++RnMP1iuF786QNBjyNR0RtgbTrpU7YNQHfConM0VH36hHlB1zF/Nm5v44TfjGxCaU4JRdhQ/ILmcqivmxF3t9VmHlw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708233996; c=relaxed/simple;
	bh=hIx6IJ5pL8itiTPrvVrZD5A6HOd06/aoGUHVby7uyP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QW9L4cLDyTYqMffTePqY+qerEJd6A/S52/sYruC9JVHBcZQbIGFmqo8DQoyp1abMu6tnJ5dKfZieF+gqkvwA1yc80NkasnNgnwToaMP7XxthPGPrd/fFkiGAXnqpaIH3nAXbOPtmLvclaqQppmWsOohr6tHmCboCqY1RvEqZxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=NxEqw/4h; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c457b8ef7cso126023139f.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1708233994; x=1708838794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQeF0EtWGS9tgKqxNFCbPNoiWJT3We61+76i+eNuJQE=;
        b=NxEqw/4hEulKtgleQNcBO9J9PGfa8EQRG3dtaE2mEESLDjOXoF+5vJue8jdV5OUoC6
         Xh5t3alwfFE0T5v+ES3peTfFpKqFWAh4n+CMJeALI++MLSOESUb72Lmhdbesvsm/bHV5
         ybI9YXtt04B+fBQnhFDnBb4flHhpd3yuUM13ZXjsguG5RStoSMnUeVU7nV4FXecnZheo
         amoXI/gN5SgxiOQhsfVexyRgvcqmZnLC73dltQC49IMINedcxEwY5VIktPaEj0tfKgHp
         hPDCTy7IUzpKNjiS7ZBQuSfEMsS1fzhGXswJQxxY91taHJtqDidm0DUavq9LtAwRR9HD
         K0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708233994; x=1708838794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQeF0EtWGS9tgKqxNFCbPNoiWJT3We61+76i+eNuJQE=;
        b=C+X1JOWlfPgDjDnamQvu1iUXYXiBtp09bwqtuCj91PZouKXiKqdqbpsV9UcCb1VYMG
         RYCLTOTp+RCLPfypwpQv3LGXe6m8XP6WNLsDitLPjj6+sdGuZQ282n7HhJYxQlb4II4p
         +a/0ZLlAga8RMjpAXG+/yZFEZAShCxUTTzvUjI/B7pyc0Loyp6VGsl0kx8sTgtpAgPzR
         iSkY1DIx//XxiKTYg1fjQNR9BCFw1vc4W1wSsCPQ9H022RcG3dBQo5k6p55rP6umCzSQ
         WpzZVPccbMnl4bwOSzFMVL0/UD2+2WYNSyTuQGUJaC8p3L7T9487c+NXN8ZvIdFKsfyV
         w1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc8bjHgvcLMbXMQeyyAz44QibQJuFRMS1AYrU13R+FMTpD3K0+db9fu85bB/Ioiv56Kxwwi+o5uWuGOyIP1xniYFTXNNIqCPK44GZG
X-Gm-Message-State: AOJu0YzckNIDxXlUZqkFjFqftUdTtmC3wupWh3p/LdqttQzc6CG95W5w
	sUbJ+ar3tT2bhrTFSZo4MK0BCTuK0OPLudOY9yBVSby90WyEnaswDUEIF3I1pjo=
X-Google-Smtp-Source: AGHT+IGJoaQ7PtOhyOTRWbhkkawxFgpWk1IyS8qeqN9+Jj3Sc4Kg+cl6u1KzDS9nsv35SSciiDEzSg==
X-Received: by 2002:a6b:4a01:0:b0:7c4:95e1:7c6f with SMTP id w1-20020a6b4a01000000b007c495e17c6fmr10943315iob.2.1708233993945;
        Sat, 17 Feb 2024 21:26:33 -0800 (PST)
Received: from [192.168.20.11] ([180.150.113.62])
        by smtp.gmail.com with ESMTPSA id l1-20020a170902d04100b001dbb14e6feesm2173492pll.189.2024.02.17.21.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 21:26:33 -0800 (PST)
Message-ID: <65582213-1091-4877-ae83-c9450a3610fa@tweaklogic.com>
Date: Sun, 18 Feb 2024 15:56:12 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] iio: gts-helper: Fix division loop
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 David Laight <David.Laight@aculab.com>, linux-iio@vger.kernel.org
References: <Zcn-6e-0-nh2WcfU@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
 <20240216135812.07c9b769@jic23-huawei>
 <dfe6e5da-b104-4acd-b323-4a7fa980de88@tweaklogic.com>
 <20240217162724.767f2ab6@jic23-huawei>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20240217162724.767f2ab6@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/2/24 02:57, Jonathan Cameron wrote:
> On Sun, 18 Feb 2024 01:09:33 +1030
> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
> 
>> On 17/2/24 00:28, Jonathan Cameron wrote:
>>> On Mon, 12 Feb 2024 13:20:09 +0200
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> The loop based 64bit division may run for a long time when dividend is a
>>>> lot bigger than the divider. Replace the division loop by the
>>>> div64_u64() which implementation may be significantly faster.
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>>>>
>>>> ---
>>>> This is a resend. Only change is the base which is now the v6.8-rc4 and
>>>> not the v6.8-rc1
>>> Given I'm not rushing this in, it is going via my togreg tree, so the
>>> rebase wasn't really helpful (thankfully didn't stop it applying).
>>> Would have been fine to send a ping response to the first posting of it.
>>>
>>> I was leaving some time for David or Subhajit to have time to take
>>> another look, but guess they are either happy with this or busy.
>>>
>>> Applied to the togreg branch of iio.git and pushed out as testing for
>>> all the normal reasons.
>>>
>>> Jonathan
>>>    
>>>>
>>>> This change was earlier applied and reverted as it confusingly lacked of
>>>> the removal of the overflow check (which is only needed when we do
>>>> looping "while (full > scale * (u64)tmp)". As this loop got removed, the
>>>> check got also obsolete and leaving it to the code caused some
>>>> confusion.
>>>>
>>>> So, I marked this as a v2, where v1 is the reverted change discussed
>>>> here:
>>>> https://lore.kernel.org/linux-iio/ZZZ7pJBGkTdFFqiY@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi/
>>>>
>>>> Revision history:
>>>> v1 => v2:
>>>>    - Drop the obsolete overflow check
>>>>    - Rebased on top of the v6.8-rc4
>>>>
>>>> iio: gts: loop fix fix
>>>> ---
>>>>    drivers/iio/industrialio-gts-helper.c | 15 +--------------
>>>>    1 file changed, 1 insertion(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
>>>> index 7653261d2dc2..b51eb6cb766f 100644
>>>> --- a/drivers/iio/industrialio-gts-helper.c
>>>> +++ b/drivers/iio/industrialio-gts-helper.c
>>>> @@ -34,24 +34,11 @@
>>>>    static int iio_gts_get_gain(const u64 max, const u64 scale)
>>>>    {
>>>>    	u64 full = max;
>>>> -	int tmp = 1;
>>>>    
>>>>    	if (scale > full || !scale)
>>>>    		return -EINVAL;
>>>>    
>>>> -	if (U64_MAX - full < scale) {
>>>> -		/* Risk of overflow */
>>>> -		if (full - scale < scale)
>>>> -			return 1;
>>>> -
>>>> -		full -= scale;
>>>> -		tmp++;
>>>> -	}
>>>> -
>>>> -	while (full > scale * (u64)tmp)
>>>> -		tmp++;
>>>> -
>>>> -	return tmp;
>>>> +	return div64_u64(full, scale);
>>>>    }
>>>>    
>>>>    /**
>> Hi Matti and Jonathan,
>>
>> I somehow missed testing this patch earlier. The above patch works fine with apds9306 v7 driver(which work in progress!).
>> There are no errors.
>> My test script is simple:
>> #!/bin/bash
>> D=0
>> S=`cat /sys/bus/iio/devices/iio:device${D}/in_illuminance_scale_available`
>>
>> for s in $S; do
>> 	echo $s
>> 	echo $s > /sys/bus/iio/devices/iio:device${D}/in_illuminance_scale
>> 	sleep 5
>> done
>>
>> One question - if I test a patch like this, do I put a "Tested-by" tag or just mention that I have tested it?
> Both are useful - so thanks for this email.
> 
> Preference for a formal tag though as that goes in the git commit and we have
> a convenient record that both says you tested it + that we should make sure
> to cc you on related changes as you may well be in a position to test those
> as well!
> 
> Thanks,
> 
> Jonathan
> 
>>
>> Regards,
>> Subhajit Ghosh
>>
>>>>
>>>> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
>>>    
>>
> 
Thank you Jonathan for explaining the above.
I forgot to mention that the above test is run in parallel with continuous raw reads
from another script and event monitoring.
As I understand that you have already applied this patch but still,

Tested-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

Regards,
Subhajit Ghosh

