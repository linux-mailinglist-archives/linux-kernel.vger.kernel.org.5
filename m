Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E187D7A15
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjJZBXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjJZBXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:23:11 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E83AA4;
        Wed, 25 Oct 2023 18:23:09 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7a80a96dbso13516827b3.0;
        Wed, 25 Oct 2023 18:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698283388; x=1698888188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=u8mIrYZi0yJBTkfE0I4Tn+5fir+dZ0INB4+AMiyws7E=;
        b=J6pjy2+LxCYCvzS0Hlx/RI+OdfJBdPGR7HP6ckyBcD4OT5W3TYxaDzxQiOTaLzY99K
         3TI974lM0uoReKXvoZTHy58bsRGQCW/VvPIA2IiWY4Nn0FlEK/A5PaVPPIN/E+fGBOX/
         g7+pRJmHfDV3C568zJxiytOOU/1mUPw7Tce5bVVpy9gSQs0/NSsSmopaN/1ELZ0usnfM
         s/RD5M9dHrRJx6WdQkY/YQzDcEcX8nIrTRQjyC+Q2d3dYM3Zq2xPXLoqQDibmAVmCM99
         Ffeu2Kds/40ynQN8G3IpaHdwtl5FVljrPm9Q4OcLA67+YO4fOSIJJ/GaqBGWC+j/yLQ8
         Q9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698283388; x=1698888188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8mIrYZi0yJBTkfE0I4Tn+5fir+dZ0INB4+AMiyws7E=;
        b=WU9SNA79y5oMlOuPvk+3cdTb4rc5vQosnBsNOS7wAmfAYoO4SdcvCuzWjJvZkzzhfu
         F/+vUTB5owV0zKjV0EPyW5tuqbF4SRJIhlRISFBp996MXFY2+E+90ipj/CmgDgoCt+ZJ
         w9wMf6jnm4iM/KtasgJThlz7ilUegS7jEU9j7qLgy5UaIsb33U7kZmru7t164bnwemGB
         K7NOOhZh8yL63LRL1BlN8wxrK8AimZVaSyc57kQ5Fbz+u8dEVtQ6D7yfTKyvFVHva+Bv
         1NdZN7l2E9HHBb1F291vCopCkeNadcJJ6a6vqXUyXWb2gJMDteR357g/8K5OrTlh9BMp
         UA+A==
X-Gm-Message-State: AOJu0YxCv5QJYLS4STrqtfTnoiWmC1WT/VWufIFMFtAtA/kGYO/TRC1S
        9ywnbjuWA6A8pBy9WNep/cc=
X-Google-Smtp-Source: AGHT+IGwukaFvT8vY/voibhmBVtjgWzcSiUUw9BiDcENmNzE9Khnzsip0n0ndTjeCqA7hU1ggCVOIQ==
X-Received: by 2002:a05:690c:d89:b0:5a7:c887:43bd with SMTP id da9-20020a05690c0d8900b005a7c88743bdmr3072178ywb.15.1698283388461;
        Wed, 25 Oct 2023 18:23:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b190-20020a0dd9c7000000b005a23ab90366sm5535995ywe.11.2023.10.25.18.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 18:23:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <757599b5-aa8d-3915-230e-cea920aa0084@roeck-us.net>
Date:   Wed, 25 Oct 2023 18:23:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: renesas_sdhi problems in 5.10-stable was Re: [PATCH 5.10 000/226]
 5.10.198-rc1 review
Content-Language: en-US
To:     Pavel Machek <pavel@denx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        niklas.soderlund+renesas@ragnatech.se,
        yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com,
        Chris.Paterson2@renesas.com, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        linux-reneas-soc@vger.kernel.org,
        Linux MMC List <linux-mmc@vger.kernel.org>
References: <ZSRe78MAQwbBdyFP@duo.ucw.cz> <ZSUy+zA0+Chm6dFb@duo.ucw.cz>
 <ZSU+GHl1q7T/TBp5@duo.ucw.cz> <ZSWg1fv3gOyV5t+h@shikoro>
 <2023101057-runny-pellet-8952@gregkh> <ZTgZa1ic1iFbdaTM@duo.ucw.cz>
 <CAMuHMdXQApuOPfU1zNKcHKN5=fCuLBSDiLtF06U7e4Tx0+noyA@mail.gmail.com>
 <CAMuHMdVrdmBgopnPnJK_ij52wz2WVBdYRHur2KfosFnT945ULw@mail.gmail.com>
 <CAMuHMdWZvTGrFgx_o3g3usOwkDvD2rw5QH9_ibo=OKdw17sAzg@mail.gmail.com>
 <CAMuHMdXvpiGQ7jqAG69Zo=10wV-E0bioC9AYUHwwhRGmLXygWA@mail.gmail.com>
 <ZTmP+WuZGKQQiYzb@duo.ucw.cz>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ZTmP+WuZGKQQiYzb@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/23 15:00, Pavel Machek wrote:
> Hi!
> 
>>>>> I don't have a HopeRun HiHope RZ/G2M, but both v5.10.198 and v5.10.199
>>>>> seem to work fine on Salvator-XS with R-Car H3 ES2.0 and Salvator-X
>>>>> with R-Car M3-W ES1.0, using a config based on latest renesas_defconfig.
>>>>
>>>> Sorry, I looked at the wrong log on R-Car M3-W.
>>>> I do see the issue with v5.10.198, but not with v5.10.199.
>>>
>>> It seems to be an intermittent issue. Investigating...
>>
>> After spending too much time on bisecting, the bad guy turns out to
>> be commit 6d3745bbc3341d3b ("mmc: renesas_sdhi: register irqs before
>> registering controller") in v5.10.198.
> 
> Thanks for bisection, let me take a look.
> 
> I reverted 6d3745bbc3341d3b on top of 5.10.199 and that solved my
> issues:
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1049624365
> 
> (Strange thing is I seen a failure on qemu this fixed, too. I guess
> that must be some kind of glitch).
> 

qemu interrupt timing is different, which can result in exposing race
conditions which are not seen with real hardware. Plus, of course, there
is always the possibility that the qemu emulation is buggy.

What is your qemu command line ? I'd like to add it to my tests if possible.

Thanks,
Guenter

