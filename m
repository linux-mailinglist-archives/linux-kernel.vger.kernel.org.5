Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EE47A5215
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjIRSd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIRSd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:33:56 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D6A116;
        Mon, 18 Sep 2023 11:33:50 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fbd31d9deso4429627b3a.3;
        Mon, 18 Sep 2023 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695062030; x=1695666830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0JJqXk8saT1UpZJqWSNTHDvRdSuIsq2vpeQit0b051c=;
        b=V2/HgMbl+dEmIgoo5DgNYValLUruv0a9FrJ4f0ANRcbb7deHonr19XKiXecU6/e5C6
         ok8/b6IOnnBz4bWZQT6+wf8Y6zbQoRjqKwEQgv3hokNF7Ho9gUFQCfhzXWw8L6sP2WMA
         uVUU07A/HaGXkxo7rXEvXLBsdo5Y5SiSWBKSe9tS485Sad2knRGe2oCp8vY4zkPnoDFc
         s7R+J9WpMWSoA9js5FcAmEsvh3O3r/wCV1Bp5HPVdcwBQIYI6FhWRK6NKtj1fQwFPpmM
         RZc79u6ZnJx/NJM7GhyNyUl0bXQmOKcgGl00p0Wn+c3xQG3pVfkJsGbIRpOsJ3+IjTxH
         Hsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062030; x=1695666830;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JJqXk8saT1UpZJqWSNTHDvRdSuIsq2vpeQit0b051c=;
        b=Iq6OnE3ywJBI7yDcM5tTW5YZ/y4TTt69bNGFx+4bTEoOnTL/VDQQpDI0siHxed+V2q
         umGAeoWpPKPz1EdHtrDDqzcECBqtEkXmiD3yqQgPyplPdmf/XWuR0DBtW29i3MW7kmCQ
         8T59z4QJO/klZoK0pQAbwSr3hYcNpUI9ZFbIU3/0u5YjUXtKZ88QHthnZI9sY5Y2VD+j
         ZFgylXBtA30fMaJjXUSuuunkW6aOWQvqF0nlWZrwgDMzpWiAOJLaK6dFoFAgH7OjD9tM
         k/iJaisAdJbVMZ0X42a5xAY9OX3vMb33MyO04shiiZEhxQP7vdMWEJaVMrFuS1itcK1N
         zENg==
X-Gm-Message-State: AOJu0Yy8OL0HpyNEy8EspuMeSr86Od4UiIzsZy11a09J1OtJikal0IY5
        smOPYRIXpEB6bDHlYjWwANfbusM0oOA49Q==
X-Google-Smtp-Source: AGHT+IGfxE6j5T4ue1S0pIcaoeFiyewjrAsKE9T16y2pWxVymCWMFQRMFc9HTouMNyoTACDYYbOjGg==
X-Received: by 2002:a05:6a00:21cd:b0:690:3a0f:4164 with SMTP id t13-20020a056a0021cd00b006903a0f4164mr10605379pfj.19.1695062029732;
        Mon, 18 Sep 2023 11:33:49 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id a26-20020aa780da000000b0068fe6ad4e18sm7446894pfn.157.2023.09.18.11.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 11:33:49 -0700 (PDT)
Message-ID: <19db0278-b11d-49f3-819b-cbc998769832@gmail.com>
Date:   Mon, 18 Sep 2023 11:33:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 0/2] vlynq: remove bus support
Content-Language: en-US
To:     Wolfram Sang <wsa@kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-mips@vger.kernel.org
References: <20230916091125.3221-1-wsa@kernel.org>
 <CAOiHx=kLQzTTzuGM0tyuv=e9J3Oi7EbWWYFRK5mEfqNrVj05NQ@mail.gmail.com>
 <3395161f-2543-46f0-83d9-b918800305e1@gmail.com> <ZQhOGY+tr25CDuI3@shikoro>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ZQhOGY+tr25CDuI3@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/23 06:18, Wolfram Sang wrote:
> Hi all,
> 
>> Agreed, TI AR7 is nearly 25 years old now, we should be able to remove that.
>> Wolfram, do you feel like doing that or would you rather have me do it, say
>> next week?
> 
> So, I pushed out an RC here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/cleanup/remove_ar7
> 
> Just waiting for the buildbot report before I send out patches. buildbot
> was already happy with my protoype, though. But I needed to reorder the
> patches. (I do wonder, though, if they build AR7. I would have expected
> a build failure with my prototype).

Looks good to me, just a few nits:

arch/arm/configs/pxa_defconfig:CONFIG_MTD_AR7_PARTS=m

this is clearly a stray reference to begin with, but should be folded in 
your commit removing the MTD partition parser.

Other than that, LGTM and thanks for doing that clean up.
-- 
Florian

