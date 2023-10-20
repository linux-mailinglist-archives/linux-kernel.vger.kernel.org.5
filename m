Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB817D0F65
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377212AbjJTMJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377099AbjJTMJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:09:21 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55239E;
        Fri, 20 Oct 2023 05:09:18 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so10556411fa.1;
        Fri, 20 Oct 2023 05:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697803757; x=1698408557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mGwuaBFtqO94TAMSnO/Xh6NCf2pq0vUZ7fh5FlEE1TU=;
        b=UOD1IR7jqLMlN9d4+r+Lk7+JogbOFvRlbgWrxJXqC29vtOP4v+6otcPGa8fYOulN6C
         fcvvo3Zy4qHBMlFBGeZ4SWQ/KIm+7RcMt7FtBNUU9hJlWVl/gnKLHUE4NICYJa6QO7TS
         /HoyXGfnYEHD7B85vwj8ewhOQ54x2pUOQLsNqq9H4dlXblEHwGo3+ZQObBfGheojHmm5
         iuK+/9Vkf15a/ZQADBOoOFT9Kit6gOs9lw+aRopvLUpflZy3o8KYS3uNNlOIvXxItqgK
         0VQ8KI/AbIvjZAJ2XDleNvc7swx9otzxa5uuPsPsVT1xkh7tsMjHaECUmjsSV+rbB+u8
         oZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697803757; x=1698408557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGwuaBFtqO94TAMSnO/Xh6NCf2pq0vUZ7fh5FlEE1TU=;
        b=q0GaLh19VNN5O7USmkEf6Znq/L3y4Qf5ZsknkaemVsqvir2W+uA3AKPpsrQH4zWSqD
         +Oj206R0/dDc9/j7aZpco2qrSjT70w5K/x2xlDX5UNSB9ULwgRI4EDQp3Pds6cNoTBVo
         a/0P3N5KzmXQiSstzJ0KuHCkGqGpsblGGpZV/LDRpk+rT8uefbmGGkqv9m1BxOxibtgw
         MJtjFjVWOI2cQwSuS1x1WCEFI3oVr3zmNwL8UB/F4rtJLhesbYy0vMwbJPiJwQpYs7zK
         kpyB0YJEmMTEMZwD4fFwvaVXJvHiczOa3rc4KJruZ9pffLMkv4Z/SLcc0oMjkgD+0LlH
         ETlg==
X-Gm-Message-State: AOJu0YxE6B/3ihe4rPGt0IftJ8Xfd9bFwj3luSr7De5jHWpsIH578oUk
        S0r+4nAqMLXBQD1eqzgUyxw=
X-Google-Smtp-Source: AGHT+IEybAXYasW4+8nL3Y9BDeBDb2GKJMqPe11p+UYNhBwcDhvtQ7xIF3mruApuJa8FW18hS/8pOQ==
X-Received: by 2002:a05:651c:a0c:b0:2c5:24a8:c22d with SMTP id k12-20020a05651c0a0c00b002c524a8c22dmr1760577ljq.3.1697803756767;
        Fri, 20 Oct 2023 05:09:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::7? (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id p12-20020a2e740c000000b002b6ad323248sm336000ljc.10.2023.10.20.05.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 05:09:15 -0700 (PDT)
Message-ID: <c623b6ff-6d6c-4351-b828-4ed4663f9de9@gmail.com>
Date:   Fri, 20 Oct 2023 15:09:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: kx022a: Fix acceleration value scaling
Content-Language: en-US, en-GB
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZTEt7NqfDHPOkm8j@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
 <CAM+2Eu+ndzS9NLvsZaX_=YTHb_+t4cE5GjQevJ1Lgc2EBO20rA@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAM+2Eu+ndzS9NLvsZaX_=YTHb_+t4cE5GjQevJ1Lgc2EBO20rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/23 21:21, Jagath Jog J wrote:
> Hi Matti,
> 
> On Thu, Oct 19, 2023 at 6:54 PM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>>
>> The IIO ABI mandates acceleration values from accelerometer to be
>> emitted in m/s^2. The KX022A was emitting values in micro m/s^2.
>>
>> Fix driver to report the correct scale values.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Reported-by: Jagath Jog J <jagathjog1996@gmail.com>
>> Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
>>
>> ---
>> The fix is somewhat crude and just crops the last 3 digits (rounds) of the
>> scale while using IIO_VAL_INT_PLUS_NANO. I played with a thought of using
>> IIO_VAL_FRACTIONAL, which could have modelled the computation
>> G_range * g * scaling / (2^16 * scaling) - where scaling 10000 would
>> have allowed using g value 980665.
>>
>> This would have worked fine for reporting scale and available scales -
>> but would be somewhat tricky when converting the user-supplied scale to
>> register values in write_raw().
>>
>> Well, the g varies from 9.832 (poles) to 9.780 (equator) according to
>> some website - no proper source check done but this sounds about right -
>> so maybe the loss of accuracy is acceptable.
>>
>> I did only very quick testing on KX022A and iio_generic_buffer. After
>> the patch the values seemed to be correct order of magnitude. Further
>> testing is appreciated :)
> 
> Values are correct with this change, Thank you for fixing.
> Tested-by: Jagath Jog J <jagathjog1996@gmail.com>

Thanks a ton for testing! May I ask which component did you use (or did 
you just use some 'simulated' regster values?)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

