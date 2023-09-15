Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B0D7A1E06
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbjIOMFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjIOMFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:05:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852293C0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:04:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-502a25ab777so3293232e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1694779439; x=1695384239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t93tJk6x9KXevq75/2U+Hu+IOtVV0GhyzBblvFXEk8c=;
        b=uGHhaEgsk2yfVxaaJ4OT3A24PwSRacCcV2ocbO8IbwG+CWPkDcDUy199GyDhKPzys1
         nOCtr+3BIOazEZ70VoJkXSp92DdfUcP/UjGqXoSO9XWtniZh1NQRJXHVS2zSXCQWvKjJ
         NTeSlZJ3ItFiHmxA7A0BtvbahwHipInoE01MeMLB76eJQLMGQl2YAR9islrUGkfxML9v
         tYInjAeOnQNM8twtogSiZIu9Zsv4ldy5VKlAtLh8i85WfCipQ71j4e02TrhIaTBfAikU
         7YrHB4uVURSSUkFI078V/ftcb140hV6T+6tHjebwFpi/bGzbCDTNHxJSJLR/TM+nMW8r
         EGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694779439; x=1695384239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t93tJk6x9KXevq75/2U+Hu+IOtVV0GhyzBblvFXEk8c=;
        b=U1vPXp042m0j1SmzDoauZj9dziDJzU+Pp685zg41g5F4GNCQImUe9nvHLF2FunFOOf
         Kpaj4bAFVNfUGMYDU3MRBr18tLVKfzjNVwaG6gLANO/3QhO7ftw4Nzmj+GM4LkmGB6lZ
         0zm2tRiT9SxAKiDUQsMwl8ME27Uma4Z9JLm1BjMK1fymu0fYOldnJJMxeOsjiWd1h4Bb
         b2ShdjOx/Hh21hIWHn//nQiAVGrP3Hhj/tepWVZTXTMwWro8XGb+kdoEOpHVtvN2tlA3
         153oFNC5aISsKlNGCKPFCiCm4WDuX04ygrByr/ESJpg0LS2DZqQV64rFfxPig1CmtqEp
         gcjg==
X-Gm-Message-State: AOJu0YzE6JLeyVd553o+QVz+sEy0944URMd4WxBwwYF2J256l3BTZHxp
        ev0i0YMSN/2F8yHr8TmIx1KgMw==
X-Google-Smtp-Source: AGHT+IGK0BWnkxl2Z+BZ8xlBZpL3aHQZKHfdU5ZcTS3pbZdnjtvlonA5LgSXLrarnHD5eTS/ZjAKKQ==
X-Received: by 2002:a05:6512:3b13:b0:500:cb2b:8678 with SMTP id f19-20020a0565123b1300b00500cb2b8678mr1657469lfv.40.1694779438575;
        Fri, 15 Sep 2023 05:03:58 -0700 (PDT)
Received: from ?IPV6:2003:f6:af2c:1500:c7bb:d28e:613f:8cb7? (p200300f6af2c1500c7bbd28e613f8cb7.dip0.t-ipconnect.de. [2003:f6:af2c:1500:c7bb:d28e:613f:8cb7])
        by smtp.gmail.com with ESMTPSA id ee17-20020a056402291100b005308fa6ef7fsm650619edb.16.2023.09.15.05.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 05:03:58 -0700 (PDT)
Message-ID: <40467722-f4ab-19a5-4989-308225b1f9f0@grsecurity.net>
Date:   Fri, 15 Sep 2023 14:03:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] x86/hyperv/vtl: Replace real_mode_header only under
 Hyper-V
Content-Language: en-US, de-DE
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-kernel@vger.kernel.org, stable@kernel.org
References: <20230908102610.1039767-1-minipli@grsecurity.net>
 <20230908150224.GA3196@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ca1a5950-9092-6caf-471c-ebda623173e5@grsecurity.net>
 <20230913052714.GA29112@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <92c52af3-085e-8467-88bf-da4fbc56eeaa@grsecurity.net>
 <20230915113258.GA24381@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <20230915113258.GA24381@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.09.23 13:32, Saurabh Singh Sengar wrote:
> On Fri, Sep 15, 2023 at 09:06:15AM +0200, Mathias Krause wrote:
>> On 13.09.23 07:27, Saurabh Singh Sengar wrote:
>>> On Mon, Sep 11, 2023 at 10:00:59AM +0200, Mathias Krause wrote:
>>>> On 08.09.23 17:02, Saurabh Singh Sengar wrote:
>>>>> On Fri, Sep 08, 2023 at 12:26:10PM +0200, Mathias Krause wrote:
>>>>>> Booting a CONFIG_HYPERV_VTL_MODE=y enabled kernel on bare metal or a
>>>>>> non-Hyper-V hypervisor leads to serve memory corruption as
>>>>>
>>>>> FWIW, CONFIG_HYPERV_VTL_MODE is not expected to be enabled for non VTL
>>>>> platforms.
> 
> <snip>
> 
>>
>> Well, if you want to prevent people from using it, make it depend on
>> BROKEN, because that's what it is. All the other hypervisor support in
>> the kernel (Xen, VMware, KVM, ACRN, Jailhouse, even plain Hyper-V) can
>> perfectly cope with getting booted on a different hypervisor or bare
>> metal. Why is Hyper-V's VTL mode such a special snow flake that it has
>> to cause random memory corruption and, in turn, crash the kernel with
>> spectacular (and undebugable) fireworks if it's not booted under Hyper-V?
> 
> 'BROKEN' is certainly not the right choice here. If it is used on the
> correct platform as it is designed to be nothing is broken.

This "if" is all I'm complaining about. If that assumption gets broken,
for whatever reason (a user wrongly enabling Kconfig options / a distro
trying to build a kernel that can run on many platforms / ...), the
kernel should still behave instead of corrupting memory leading to a
kernel crash -- especially if it's that dumb simple to handle this case
just fine.

So please, can you answer my question above, why VTL is such a special
snow flake that it needs no error handling nor validation of its core
assumptions like all other hypervisor code in the kernel seem to get right?

> 
> The default option for CONFIG_HYPERV_VTL_MODE is set to 'N', there is
> sufficient documentation for it as well. I agree there can be cases where
> people can still end up enabling it, for that EXPERT is a reasonable
> solution.

I don't see why this would solve anything, less so in preventing the
memory corruption angle which can easily be avoided.


Thanks,
Mathias
