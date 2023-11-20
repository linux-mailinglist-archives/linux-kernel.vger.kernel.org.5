Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A737F17F8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjKTP5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTP5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:57:43 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D320BA0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:57:39 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40891d38e3fso15367035e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700495858; x=1701100658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=89EYg4ouBWYX+fl0hKWC4znxsM2071TE3litLlRaSBY=;
        b=LedeSctZmmtnPMTWcreAG14MKHXqlcNWterODhulfhH8yJTjxbD2OYxByVyrJab0tU
         ozIWjcTPSe3kXySwITvCXx/aYJ4k0kl+Hpy6ZLxxMI5AEJFRQX8kflsLQ4hm3fXrXOsI
         IU9SwE9DR+XlBvFPWAWgcyppKM6S/P1vzJxRb5Kt3vH3BB7nL25emZlz1t5MSnAMk7jK
         JIXUDjyfFJ2jiaZVrsoUTTESNy7WJhjwBNxRKjU7jZUu47wAqfdGRPz95sSR1IYMgIvL
         D9lO5jj/B5Mb5m8mKiKtf6TpG6UASxLjx/3DCsWgLMSw8gUZCC9fn0XfQGQsDLrD90YC
         XOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700495858; x=1701100658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89EYg4ouBWYX+fl0hKWC4znxsM2071TE3litLlRaSBY=;
        b=ayZAZrXDrNQEbjXPc35TArqwe+LvGjhlyPVWoG+Ic3KnB9Nw4mQVMFFUQF9RTjbW0h
         vL03T4BMcwfdMjkQHBhU2odyCGx9LdWoEZuxWRktQaQJzj70v9NqWqvGxHRur9ub8i5U
         137lD/+Q4dNO0r7J3hYC4ZtY42O1kEpNrynAUiMC3NIoMZmnC50Z8r7K5OV9Oh5WjjyP
         lpUP51NJtQptIiAkvYXzG6o3rtd9RkNSNg8axlkTV7KkuhQ97frAUFK7kKVYGLG+oIqe
         pTc6W6N4+UlDrFd9+jkriam7OSYGWX2li9KVbVGnhrCWqZaScNaetndAGB9CywP1l8Wu
         AKBQ==
X-Gm-Message-State: AOJu0YwykaPdbehYjUaComu6Lo9nCGuHfqcXa6BTW5GUf+fw7rvWDcE1
        MNGNlCynCchslMrebOioS1wmKXmBk38=
X-Google-Smtp-Source: AGHT+IFhUMUVyBcUDGRSZaC3iPujMi7KSk5AL1rJDDgsBFZb0+BSUafYsTQ9/YcD2194+2G2rh41ZQ==
X-Received: by 2002:a05:600c:4f8f:b0:40a:4609:9c97 with SMTP id n15-20020a05600c4f8f00b0040a46099c97mr6312604wmq.20.1700495858005;
        Mon, 20 Nov 2023 07:57:38 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id y15-20020a05600c364f00b004060f0a0fd5sm13509216wmq.13.2023.11.20.07.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 07:57:37 -0800 (PST)
Message-ID: <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com>
Date:   Mon, 20 Nov 2023 16:57:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Radeon regression in 6.6 kernel
Content-Language: en-US
To:     Dave Airlie <airlied@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Luben Tuikov <luben.tuikov@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Phillip Susi <phill@thesusis.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <87edgv4x3i.fsf@vps.thesusis.net>
 <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.11.23 um 07:47 schrieb Dave Airlie:
>> On 12.11.23 01:46, Phillip Susi wrote:
>>> I had been testing some things on a post 6.6-rc5 kernel for a week or
>>> two and then when I pulled to a post 6.6 release kernel, I found that
>>> system suspend was broken.  It seems that the radeon driver failed to
>>> suspend, leaving the display dead, the wayland display server hung, and
>>> the system still running.  I have been trying to bisect it for the last
>>> few days and have only been able to narrow it down to the following 3
>>> commits:
>>>
>>> There are only 'skip'ped commits left to test.
>>> The first bad commit could be any of:
>>> 56e449603f0ac580700621a356d35d5716a62ce5
>>> c07bf1636f0005f9eb7956404490672286ea59d3
>>> b70438004a14f4d0f9890b3297cd66248728546c
>>> We cannot bisect more!
>> Hmm, not a single reply from the amdgpu folks. Wondering how we can
>> encourage them to look into this.
>>
>> Phillip, reporting issues by mail should still work, but you might have
>> more luck here, as that's where the amdgpu afaics prefer to track bugs:
>> https://gitlab.freedesktop.org/drm/amd/-/issues
>>
>> When you file an issue there, please mention it here.
>>
>> Furthermore it might help if you could verify if 6.7-rc1 (or rc2, which
>> comes out later today) or 6.6.2-rc1 improve things.
> It would also be good to test if reverting any of these is possible or not.

Well none of the commits mentioned can affect radeon in any way. Radeon 
simply doesn't use the scheduler.

My suspicion is that the user is actually using amdgpu instead of 
radeon. The switch potentially occurred accidentally, for example by 
compiling amdgpu support for SI/CIK.

Those amdgpu problems for older ASIC have already been worked on and 
should be fixed by now.

Regards,
Christian.

>
> File the gitlab issue and we should poke amd a but more to take a look.
>
> Dave.

