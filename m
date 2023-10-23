Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1537D2A59
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjJWGYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjJWGYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:24:45 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08D9DF;
        Sun, 22 Oct 2023 23:24:43 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c50ec238aeso41401951fa.0;
        Sun, 22 Oct 2023 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698042282; x=1698647082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u63ePI/ecrbvy23ZluOCFzJyp4YA/m/rdW6t9+hNFxA=;
        b=KUwRT3xj+9dDAFf+KqLGBpV0UfgTjQuojprHAzTnzjKAOMdhcjRfQRiLIYDbdOEcXz
         RtfexO6dzqCTIMBbWNRNwn+zOaCZvURSb15vlWajGgDwWAHNoR4ltpDFvCGz4g3sxSUE
         ZIeuxg2tY+SECqZnHqE+Kl2vve8x57wY2OsHoc08LDlbWZXbsPE7C1vcyH2G/QTKIOJL
         +TZd+sGKT8/YtWeb6+J3phlhr2s6TytLWN2n3NcFeloZJcdmTW/YRbiz/n9fqiF9J5HR
         xZzSA3QobZpbq047SACOMzcFZ+z3/BohnuSKrfz/71WLkQtlkaVuJYaKkHrJ5MBmEQXI
         xIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698042282; x=1698647082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u63ePI/ecrbvy23ZluOCFzJyp4YA/m/rdW6t9+hNFxA=;
        b=LhfxvJR0fPpuh3zmKzS3DeRtHrAPU4fbvnBgN2LHL3LgiBNKUAGoMymyE+Jwwuv6AF
         4R6UUtSmjKSiy+Xnel91aSM9tlksXPCqV7rGKH6WS3e3vk1FMKyl8pA1t+HLkyD4M3cg
         K5duXmrbNd+jo2A3ZCRpr/KlMOsMQdo0WogFkVN6umFOIJjAZb1WHwxmw5PZS7s8sAbx
         hBVfie1mWfQYYTrQqiGSD/R1cLAupN4DsY+EOS+CLrNwYpeGuxecdbcvLwkrVtGre6QO
         c/TbVRRXdIUX1NZLITTaox8Cfm/XLfbwQB1RoAuMFwRisTSntGuBBi0q4HFmpQnfrGK4
         NcgA==
X-Gm-Message-State: AOJu0Yw6gqYKuBwL4k3gDY3KPEy1jHIfFTueyzGwyjhGd0bsA76we1pj
        SVCvm2v5OZtrLQMua9ueYd/VR1W5Txiy4g==
X-Google-Smtp-Source: AGHT+IH2WW3hWxD70RfsVynOvdDaxRJ4BJQeLYa7I0biC2Jl991bZO1HchXjmPsgQeWn8MLMurGDDQ==
X-Received: by 2002:a2e:b0e3:0:b0:2c5:1900:47a4 with SMTP id h3-20020a2eb0e3000000b002c5190047a4mr5402725ljl.0.1698042281688;
        Sun, 22 Oct 2023 23:24:41 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::7? (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id w10-20020a2e160a000000b002c032e54948sm1513805ljd.117.2023.10.22.23.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 23:24:40 -0700 (PDT)
Message-ID: <77b5f4a6-4012-4409-9034-419b852a783f@gmail.com>
Date:   Mon, 23 Oct 2023 09:24:39 +0300
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
 <c623b6ff-6d6c-4351-b828-4ed4663f9de9@gmail.com>
 <CAM+2EuJ8J+sJNBqbPuFLXVK-Y9V=q+Lt=js9giWdSZ6H=aJ2Jg@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAM+2EuJ8J+sJNBqbPuFLXVK-Y9V=q+Lt=js9giWdSZ6H=aJ2Jg@mail.gmail.com>
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

On 10/20/23 19:48, Jagath Jog J wrote:
> On Fri, Oct 20, 2023 at 5:39 PM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>>
>> On 10/19/23 21:21, Jagath Jog J wrote:
>>> Hi Matti,
>>>
>>> On Thu, Oct 19, 2023 at 6:54 PM Matti Vaittinen
>>> <mazziesaccount@gmail.com> wrote:
>>>>
> 
>>>> I did only very quick testing on KX022A and iio_generic_buffer. After
>>>> the patch the values seemed to be correct order of magnitude. Further
>>>> testing is appreciated :)
>>>
>>> Values are correct with this change, Thank you for fixing.
>>> Tested-by: Jagath Jog J <jagathjog1996@gmail.com>
>>
>> Thanks a ton for testing! May I ask which component did you use (or did
>> you just use some 'simulated' regster values?)
> 
> Hi Matti,
> 
> I just simulated with the register values, Should the 'tested-by' tag only be
> provided after hardware testing?

I am not sure TBH. I didn't have a problem with your tag though, I was 
merely curious to hear about the IC usage :)

Now that you mentioned the tested-by tag usage, I started to wonder it 
as well. From pure SW/driver point of view the register value simulation 
is sufficient - but in practice we are not interested in whether the 
code works "in theory" - but whether the products do really work. This 
is something which includes handling of potential HW quircks and 
oddities - which are not always documented or known.

If we assume a case where someone is developing new gizmo and hits a bug 
which is in reality caused by some undocumented HW hiccup - then fixes 
with "tested-by" tags which are not actually tested on HW having this 
hiccup but using SW simulation - may be misleading.

The above is just some overall pondering - I am not too concerned on 
your tested-by tag :) Besides, it's cool you did the testing! I 
appreciate that! However, I wonder if there is some wider consensus 
whether the tests should be ran using real HW when tested-by tag is 
given. Jonathan, do you have any educated opinion on this?

> I referred to this driver because it's
> the most recent accelerometer driver that was merged.

Makes sense :) Thanks for replying!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

