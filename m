Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2BC7C7868
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442866AbjJLVNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442831AbjJLVNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:13:48 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBF3A9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:13:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4054f790190so16756795e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697145225; x=1697750025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHc53RKO8nhqYnehqtbOrBzFrWfxOOgucL77D+OqER8=;
        b=SfVh2eFI16gsj+L9htqhOHpp6t5KQTurkUoiXm8Gcd3rpCuRsf3KxMU4//DneKmbF2
         ODNoIKWjxjSE5zVMO6tWDTN0jtt49R/mj0ie7dZ1Ey47lEIkJ+V5TJJN2h6ZGLbuw9zX
         gQNbmn86Q4KBOUK2SLxt23sjQ0XDnl+y2ap5CMkTTdWgJ8t1Gts6FlMTRQfD59bwMelf
         5b+Mmr9FC0t6sFxDiR/WJrpWjcDkm9cUPCUoTCJQKqhlKsw7VfYX8uKjmqyHmSccoGHG
         J4MrD2ZKVu9vdW+TiWqDk3LGwPVt4eO9U5ll7+ZQfx/+NvflrNclFy2Ouw5lE4+Mf0Q/
         n0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697145225; x=1697750025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHc53RKO8nhqYnehqtbOrBzFrWfxOOgucL77D+OqER8=;
        b=vl1v+i3B8r4ZsQbbguVoNP2pPLQ0mF4RXan4QC2K2/AGvSViJ3eTxRHdvAN7ORj2TF
         L6Eofyqd8CyOlkcTKlrq3CUWN6/nUSGwF7O40PW92dpBfXabv2FJ0SH2HmoGaVx11uCp
         IXGRwpuy1OQfecb996Jli84v8livuCQtT5Yy0g0GOAz9SzHS72bKah8OynmKAtHbfAjo
         noTr5G6r3BvLUZAV4vX542t4iL95raTkd0QEnMLFF5QNjoT1fU84BJ5NNX9tp5J1mdU5
         QMleCTmF0iYZbvX4UfvoJBNAMyb4WO64THEt6oFKTKotHDAj2avmNpS0+J4Sy+Trxoma
         TNHg==
X-Gm-Message-State: AOJu0YyrRLPXm0/CID580cXUOItpl+t9/GCANFOSFmT2vqXv4bPVVN0O
        z36zMpdvRa1adTb55NW/ZumA9g==
X-Google-Smtp-Source: AGHT+IHkMdU2x5GDOFlu8prnbGfQ0iRf1BTa/zweOozEQ7yKut6PFviK1gyX1aQoj//OSEFwvENNJg==
X-Received: by 2002:a7b:cc8f:0:b0:403:7b2:6d8f with SMTP id p15-20020a7bcc8f000000b0040307b26d8fmr22114721wma.2.1697145224900;
        Thu, 12 Oct 2023 14:13:44 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id l25-20020a7bc459000000b004054dcbf92asm779383wmi.20.2023.10.12.14.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 14:13:44 -0700 (PDT)
Message-ID: <dcafb275-40eb-4663-8ede-bf15546f83f6@linaro.org>
Date:   Thu, 12 Oct 2023 23:13:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal/core: Hardening the self-encapsulation
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231012102700.2858952-1-daniel.lezcano@linaro.org>
 <a6b51de7-4f56-4db9-a7dd-60555ac6c37f@arm.com>
 <d9f3bd7b-a5db-4d37-bb1f-f97e40c8a63a@linaro.org>
 <CAJZ5v0gC4+Jam0a4KpEr7onydn8Sp8MkN2yzVxm0W9qDpmEoDw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gC4+Jam0a4KpEr7onydn8Sp8MkN2yzVxm0W9qDpmEoDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2023 19:44, Rafael J. Wysocki wrote:

[ ... ]

>> Yes, we should but there is the series for nvidia (pointed in the
>> changelog) which need a slight refresh for the bindings AFAIR. That
>> series is since March 2023 and Thierry seems busy [1]. I'm holding the
>> hardening since then.
>>
>> So I don't know how to make progress on this? I was assuming we can
>> merge this series and let the compiler recall what has to be fixed.
>>
>> [1] https://lore.kernel.org/all/ZK14edZUih1kH_sZ@orome/
>>
>> and as soon as it is fixed, we convert the WARNING to ERROR :P
> 
> To be honest, I'm not sure if anything needs to be done along the
> lines of this patch right now or even at all.
> 
> The only concern here would be that some new drivers would include
> thermal_core.h while we were waiting for the remaining existing
> abusers to be fixed, but since this hasn't happened for the last 6
> months, I'm not worried.
> 
> It would be good to add a notice to thermal_core.h that this file is
> for internal use in the thermal core only, though.

So this series will give a warning for the remaining nvidia driver but 
Thierry just send the changes to get rid of the thermal_core.h (Thanks!)

AFAICT, the last user of the thermal_zone_device structure is the 
int340x driver but the patch fixing the structure internal usage is 
already in the bleeding edge (well perhaps one nit is missing for the trace)

As soon as the bindings are acked, then I can pick the patches from 
Thierry which will end up in your tree. Then you can apply the current 
series. And finally I'll send the last patch moving the thermal zone 
device structure to the thermal_core.h. And we will be done with this part.

Having a compilation warning (I would prefer a more coercive error if we 
agree on that) will help to not have to double check every time 
thermal_core.h is not pulled in the drivers when patches are submitted.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

