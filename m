Return-Path: <linux-kernel+bounces-144971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DE78A4D57
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999521C2137B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA495D756;
	Mon, 15 Apr 2024 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Zkdpv/6k"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699765D47B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713179344; cv=none; b=LB19c6FRpOd18jzxFtSwxmR1BDMcpGOZaUMQTfWSa962RjgpM1edn3tKd5AEY3gSzOZdG9ixjjXZ50NDQylVOWrffAIJ8VgFqUZDRKvYJIJxN8pFm2urNi1/j+PGpYhY3nZE9YbXOBfnJg9PZnufP1HrRe9MHADvGIkgkTuPkow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713179344; c=relaxed/simple;
	bh=b7uI2YDYyfDJc/waqMd1ndg8iT6Q8Xh6MSwt1IjGMhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgL9JIqGIh2T+vDmKWLDsyiKE216utJrAiiiVbSNQ+yz87WFMAWFQRNnqNwln+sEZFhMYd5z4bV2/A4RV6vRDM7GYyc9Gp6egQm/6g78mTusoF8MNKSkAH5LzH1XUqdU8aMU+oc+7KZqWdp8yDt0OVtgs5ZdnQUWuL86EpKn0Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Zkdpv/6k; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a526a200879so111755966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 04:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713179339; x=1713784139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5M9yJhy99Eqb6GsotMlodvuJ+GqdhB7F9TG3M1YTZ7Y=;
        b=Zkdpv/6kyAOZJnuUNVOGYuMQU7XWoXTPJuI6EZoBHYHm3xrHbPzH1JZog4CN62cR2P
         2/BwVdARPyTbhUYysfV/8LBDtfNDoRneViCbtXeK949PhVwslYc1x4+3bQNAZi6e4iyZ
         PeyG+c/CzzOtDnEXtDU9Kg2CIaeaz+hwrvMws7NEIJl3K5z9t2+7QYNedHFB4PWkfk4+
         6XDGTi5NThcvWyBgdNZQa2ZdtP31pNxycerxUhRjkg89XJ0b3OBNUgMGUj02st+ivSE9
         LtLI1MBfrpZmJGYQtuoNxQU9VUrj2R/yKFMRYCzrp+P6UmOrfsYnXO8telV91+hfRxGK
         H2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713179339; x=1713784139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5M9yJhy99Eqb6GsotMlodvuJ+GqdhB7F9TG3M1YTZ7Y=;
        b=HbxgvRQ+qEEZH3DydcQaV4G9iUPV8G9t0aN1pbVOiE8FMa+Q6D1rMF3SKV/12RStWW
         gtFC8TlVyfQXj3M51JN/sKagk6o2iVc/rnZrlw9vEaaoYkp/TwOvoOKjlq6avkmv0gGL
         n9IapjRJxylOqGZzJd3I/NJu0icbDlFdWfxdpHyntc3EhcUblpry2RfxQHPVBmhBonFn
         7nk1dkhurlDebaLlCCW5UdEBssf4P2kX+GIhlRY/CC9sKOYwHNlqvHImz4S7fs7qbZ+q
         zqbdDySKwjRrnK0VlfBoxfem1O7pIwpkGtvggVVvd2L2Rawkt1Ns0u0sBbhw39W4Dcb0
         Ay6A==
X-Forwarded-Encrypted: i=1; AJvYcCU0QvY7poIFiZjr0ZcuctxZLHPxMSGcyS33S04lLUQtEzZW8SWDGsPBqd7j62bcYqPQ0dEF1SFWlMG5vFUNgWd7sybkCVH2VjyPNjfm
X-Gm-Message-State: AOJu0Yw9JNOKLr/R6P4QGAu9Xb/qqbxPwNItphKNLE/je9PHTaiOKwxe
	XPl5p+FT1YqIHQ+x75IIF4LNI13ggQOSnUBWA6VckUOlOKe1Z6CRDpU+JS6zpN0=
X-Google-Smtp-Source: AGHT+IF1v1eBuey7AAdvSFGbgfsnJoWMwJh8bGGAiWv+m6z1Fsxmu2YOb4SmFhOpDhx8pKKYE8vruA==
X-Received: by 2002:a17:906:3b99:b0:a52:527c:ea86 with SMTP id u25-20020a1709063b9900b00a52527cea86mr3172063ejf.33.1713179338785;
        Mon, 15 Apr 2024 04:08:58 -0700 (PDT)
Received: from ?IPV6:2001:a61:1366:6801:d8:8490:cf1a:3274? ([2001:a61:1366:6801:d8:8490:cf1a:3274])
        by smtp.gmail.com with ESMTPSA id jw9-20020a170906e94900b00a52241b823esm5099658ejb.109.2024.04.15.04.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 04:08:58 -0700 (PDT)
Message-ID: <a0a220da-ebd4-4ce3-ae26-e1f26d374146@suse.com>
Date: Mon, 15 Apr 2024 13:08:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: cdc-wdm: close race between read and workqueue
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Oliver Neukum <oneukum@suse.com>
Cc: Aleksander Morgado <aleksandermj@chromium.org>,
 linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, ejcaruso@chromium.org
References: <385a3519-b45d-48c5-a6fd-a3fdb6bec92f@chromium.org>
 <87mspvi0lk.fsf@miraculix.mork.no>
 <a6ad34d3-9cce-4178-8271-0e09ced2b6f4@suse.com>
 <878r1fht93.fsf@miraculix.mork.no>
 <c35f98be-23a3-41c3-bee5-f394ce504545@suse.com>
 <8734rmj3ro.fsf@miraculix.mork.no>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <8734rmj3ro.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15.04.24 12:53, Bjørn Mork wrote:
> Oliver Neukum <oneukum@suse.com> writes:
>> On 15.04.24 11:26, Bjørn Mork wrote:
>>> Oliver Neukum <oneukum@suse.com> writes:
>>>> On 15.04.24 08:47, Bjørn Mork wrote:
>>>>
>>>>> urb from service_outstanding_interrupt(). That's why it was added. See
>>>>> the explanation Robert wrote when introducing it:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/class/cdc-wdm.c?id=c1da59dad0ebd3f9bd238f3fff82b1f7ffda7829
>>>>
>>>> Well, the explanation is correct in that we must read
>>>> data available. However, if the RESPONDING flag is set
>>>> and the URB submitted, we are already doing so.
>>> Sounds reasonable.  Except that the bug proves we didn't.
>>
>> Why? I am afraid I do not get that part.
> 
> I don't get how it happens either.  But that's the only thing changed by
> the patch.

Now you have lost me. I agree that this is the only thing that the patch
changes, but how do you derive the consequences from that?

>>   > If you are right that service_outstanding_interrupt can race
>>    againts
>>> itself (and I don't doubt that), then I guess this could also happen
>>> between failure to submit the URB and clearing the flag?
>>
>> Yes, it can. In fact in this case the behavior should not change.
>> I am afraid we have a misunderstanding. It seems to me that in the
>> unchanged driver the result of service_outstanding_interrupt()
>> is undefined.
>> Please explain.
> 
> Sorry, I am so lost here that I am probably only confusing things.  I doresp_count
> not understand why we unlock &desc->iuspin around the usb_submit_urb
> call.  And git tells me I wrote that.

Dropping iuspin there allowed you to call usb_submit_urb() with GFP_KERNEL.
clear_wdm_read_flag(), as it then existed, could not race with itself because
its only caller wdm_read() is holding a mutex.

That, however, is not very material to the question at hand. iuspin at that
time protected only resp_count. Even today the URB itself is protected by
WDM_RESPONDING. (Which is why I think that test_and_set_bit is required)

Now, if we say that service_outstanding_interrupt() is racing with itself,
we have to ask why this is helpful. Do we at least agree that the regression
Aleksander is seeing is due to the removal of a race or are we looking at a side effect?

	Regards
		Oliver





