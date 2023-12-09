Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2D080B418
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjLIL5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 06:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIL5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 06:57:20 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A7F10DF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 03:57:26 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1ca24776c3so829309066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 03:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702123045; x=1702727845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mj9IkjGM5bRDRMCtZPs5pD8acnCJT6TuxhCGWsEoCBo=;
        b=gpE8cWrctNE5uq6ayiROwrSSvv5RMFp1Uod0s6dO2YgmjuAaBVq7kpKthAeDaa8Sh9
         PAeQNvTko6CMpD8TrCWJUts3a0d30pgX6bLAeK7Ni8+qLQCHdmdDepHsxX8vPxe+5w73
         FWPxR7KEvrpujSGcSfOMDWgYzU1gjJDpvJ2JfW0/1E9oQzlLIqJhioqXUut/LFoBuLWN
         83zudLSl0rVJ2j2ZJ9wT0WmCffYJGELNnj/qrzjxohra9op6+VbcaMv1H7T8p/opVvV1
         73H82jgdciBSSjzgZT1WaflwMhl5/+Xl29aisijFJexDf2rG1sUj8aLlgg/8rjia1IRp
         QPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702123045; x=1702727845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mj9IkjGM5bRDRMCtZPs5pD8acnCJT6TuxhCGWsEoCBo=;
        b=dW437dO9WJRSpiCUmiwtCrmv9CJGyLdPpeFYCmvhDX51iTKvEdfHB5/MDkhQrQ+XZc
         Zcie4K0MPPVqyHdiWwSM+u8T6hjHfd3OG9iaMhuJdWfvyNXwG8xUeRX6nu5nIDGVdZM6
         FewbHjsTwJA2JLvi0jZnr+W2ouxXpx2s3QYUb0R7bOWCMLkgjIvCSCxzm6dfJDfepMxd
         hOYRhNHYkWDGHv4EMaLeQVNb+3E08nQAjshQnRSL4LC1u+akD70N50/zDpUeexbtAAM7
         z3XU6e85wzrV1awCUAsMKAriJt6OKjWC59uaxeqPJezILjhwz9oTioCJQA6OEkDEEfvm
         9Evw==
X-Gm-Message-State: AOJu0YzAeQmwIS4KHVjJmPcM5Mj+6yDGC7IkdxcalbbZn+1AzHUFfxSA
        MWm1w3S5PDUWpiGomZOvYEmngQ==
X-Google-Smtp-Source: AGHT+IGgta7Jxk34kweuhA8Cdq+Ns1KnaFrcUnCwE88ylKeOP19RsoEgQsESwXKcvcbLOsP25P5muA==
X-Received: by 2002:a17:907:da6:b0:a19:a409:37ce with SMTP id go38-20020a1709070da600b00a19a40937cemr2110755ejc.39.1702123045154;
        Sat, 09 Dec 2023 03:57:25 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:731f:e6b0:e567:aab6:1db2? ([2a10:bac0:b000:731f:e6b0:e567:aab6:1db2])
        by smtp.gmail.com with ESMTPSA id mn6-20020a1709077b0600b00a18374ade6bsm2129793ejc.67.2023.12.09.03.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 03:57:24 -0800 (PST)
Message-ID: <b028a431-92e0-4440-adf9-6b855edb88c0@suse.com>
Date:   Sat, 9 Dec 2023 13:57:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: User mutex guards to eliminate
 __kvm_x86_vendor_init()
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231030141728.1406118-1-nik.borisov@suse.com>
 <ZT_UtjWSKCwgBxb_@google.com>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <ZT_UtjWSKCwgBxb_@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.10.23 г. 18:07 ч., Sean Christopherson wrote:
> On Mon, Oct 30, 2023, Nikolay Borisov wrote:
>> Current separation between (__){0,1}kvm_x86_vendor_init() is 
>> superfluos as
> 
> superfluous
> 
> But this intro is actively misleading.  The double-underscore variant 
> most definitely
> isn't superfluous, e.g. it eliminates the need for gotos reduces the 
> probability
> of incorrect error codes, bugs in the error handling, etc.  It _becomes_ 
> superflous
> after switching to guard(mutex).
> 
> IMO, this is one of the instances where the "problem, then solution" 
> appoach is
> counter-productive.  If there are no objections, I'll massage the change 
> log to
> the below when applying (for 6.8, in a few weeks).
> 
>   Use the recently introduced guard(mutex) infrastructure acquire and
>   automatically release vendor_module_lock when the guard goes out of 
> scope.
>   Drop the inner __kvm_x86_vendor_init(), its sole purpose was to simplify
>   releasing vendor_module_lock in error paths.
> 
>   No functional change intended.
> 
>> the the underscore version doesn't have any other callers.
>>


Has this fallen through the cracks as I don't see it in 6.7?
