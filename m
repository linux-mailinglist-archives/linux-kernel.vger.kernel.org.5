Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B1680F861
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbjLLUtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjLLUtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:49:19 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3E5D4D;
        Tue, 12 Dec 2023 12:48:16 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d319a7a35bso24108185ad.1;
        Tue, 12 Dec 2023 12:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702414095; x=1703018895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=c3UB6NPM8uJWf0yt1AkDFK1KvBcW6hVLav7kTbQVHuI=;
        b=ihyT6PATE9cmnsR/05zseOgvD0tmRVj8mJh6vwAmnCdN3FKPAtUzlEg2secYXA9qzA
         jn7QTZLtMhMkb3OOcz0VrTpzokDP0a8nRkJ8iKh7JJVSQ0RRma+A/8jOsqY434Heq0QG
         tNv5fKXw00y61ihSdvssHvIA1Lf/A/4heDEMQA/hpUrTRDiCHXx0eRm7+lE1JjtveuH2
         nKJfKyZzAaH2EufD5cPne9L4T9K0F0LehUKuaFD9MLmw0sUwy5jNKxZOUgzGCVGq8S59
         d+z1TIdhw/mK/UXo5xfEgtcXLf4C1vkXGbKPWJRc95eCQSXLCPdvqU2zT2K2U0c3/vn3
         yphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414095; x=1703018895;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3UB6NPM8uJWf0yt1AkDFK1KvBcW6hVLav7kTbQVHuI=;
        b=g06FkBH4snNE6qQuS1t+J/evNkYsoAzZ64ruvgeZJ9CmdXRFw9fB5TTYa4fjd0T9o0
         /UCRHIcoBNNm2Z/wvs48f3ShgoD4Zz04EzeXXOl49a9YQ5k7yosiWUlNJ3JeJf0gBGjQ
         ku/NOrAucVaL0pI/DV0gmyfoTWYfVP+cwuG6pxXPvviig5Frl1E8Uj9MLFBGR4Jafu04
         6c8H1Oj8tsMMyVVA1Prw1QPl0g7HnkFv2DYIEhWw/5WxBBsWR0KbaLJx5gIur//u9DEs
         HhyZ1KKgf+nkOyn+bUDJcolO4Eta6CLvY28O44aA68DvV5i5UDq0gyoIbywYrqnqnGPo
         KA7A==
X-Gm-Message-State: AOJu0YzRGWKxXzHTkbLZmQDvA32lrIzhtSRGywzfZpCNVNCWhVD6KDF3
        7JI006wGPfXGM929F3gapYMplhfWn28=
X-Google-Smtp-Source: AGHT+IGerKImsoibndC3ru39ngIREW15z4Pq3podn9EgBS9hxPRcxFjpW0scu2xlhavtjIR379wwiQ==
X-Received: by 2002:a17:902:da89:b0:1d0:7844:5055 with SMTP id j9-20020a170902da8900b001d078445055mr7542365plx.62.1702414095242;
        Tue, 12 Dec 2023 12:48:15 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b001d0b32ec81esm9004795plf.79.2023.12.12.12.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 12:48:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a6af01bf-7785-4531-8514-8e5eb09e207e@roeck-us.net>
Date:   Tue, 12 Dec 2023 12:48:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RTL8152_INACCESSIBLE was Re: [PATCH 6.1 000/194] 6.1.68-rc1
 review
Content-Language: en-US
To:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dianders@chromium.org, grundler@chromium.org, davem@davemloft.net
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
References: <20231211182036.606660304@linuxfoundation.org>
 <ZXi9wyS7vjGyUWU8@duo.ucw.cz>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZXi9wyS7vjGyUWU8@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 12:08, Pavel Machek wrote:
> Hi!
> 
>> This is the start of the stable review cycle for the 6.1.68 release.
>> There are 194 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
> 
> 
>> Douglas Anderson <dianders@chromium.org>
>>      r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()
>>
>> Douglas Anderson <dianders@chromium.org>
>>      r8152: Add RTL8152_INACCESSIBLE to r8153_pre_firmware_1()
>>
>> Douglas Anderson <dianders@chromium.org>
>>      r8152: Add RTL8152_INACCESSIBLE to r8156b_wait_loading_flash()
>>
>> Douglas Anderson <dianders@chromium.org>
>>      r8152: Add RTL8152_INACCESSIBLE checks to more loops
>>
>> Douglas Anderson <dianders@chromium.org>
>>      r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE
> 
> Central patch that actually fixes something is:
> 
> commit d9962b0d42029bcb40fe3c38bce06d1870fa4df4
> Author: Douglas Anderson <dianders@chromium.org>
> Date:   Fri Oct 20 14:06:59 2023 -0700
> 
>      r8152: Block future register access if register access fails
> 
> ...but we don't have that in 6.1. So we should not need the rest,
> either.
> 

Also, the missing patch is fixed subsequently by another patch, so it can not
be added on its own.

Guenter

