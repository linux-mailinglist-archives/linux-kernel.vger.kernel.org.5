Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0487FE4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343780AbjK3AXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK3AXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:23:51 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E88EA0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:23:58 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5cece20f006so3935987b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701303837; x=1701908637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4JRTHm31IgG0m+smFSflOeLWctDc251xswgo6p1cTQ=;
        b=LZmZ6jmbsc6R4l9jyPHpoijh5dww8jyKaP5B8C12ghunRtNAOV5jB6LKF9ypi9nokD
         nqhFhqD9g3uV0gS4ttNATuHrdoMZHDs+fQNM64il5P3d9UBZDKAmXzu+O/eZ5qGJ7j3f
         a1mDVeHXigm9V5vZP0cQRXDsauaWnBSuL0a6fY/NBqYMNYot6Uld9GSoM66iWKSlQpH9
         VuGJ9ZLXGEsaisZH3SaJ/ZZcsf1JN6Ss+9i4HRc36687vZigGFvRonCehFM7dJ6+VUx7
         RoQihq7eo8fqBTW3kX8psDtz2pNTibK6+CNattgvuuUJ2gSK1wHh2fCAU3mgGLbsqX/I
         mhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701303837; x=1701908637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4JRTHm31IgG0m+smFSflOeLWctDc251xswgo6p1cTQ=;
        b=ZNsXmA7zJLBgPKV46WnUisLIwo47XhXYcikidEF+IgWfzhF4qVvcKZShSwN9iMMaH8
         AMXyB6/jb4QV5qBhf/4Xuq7NSYlUaV06pngyVSckEoOvvEy+5jaBnPQg5k+MF6Eyo3Ah
         sP9vdD4chMeaWew7Tnl3CLYOULi6H1ZFAUgkBff9m8HA/74QJ4EtDgvj3g3JRqFn2bc6
         K0anrKDQvXKw/WaivRDcS6+NwAdOQVIKm6uYOsFP2vq7n+rwLC17efwCvjC8WqQ3VX88
         mFcmG+AgvBYKCfiTIhqR9Tp04KujYvZjUhgnE7YLUTVPmOQtrs6T9C+b3J19kPvJSghA
         K0ow==
X-Gm-Message-State: AOJu0YwiI7FvZHlSYHOyujmKOMztGVm0WnBJZWiDSnS0W5QUaVsclwkw
        nVyD5jscN4CYKt9AMSZUJdY=
X-Google-Smtp-Source: AGHT+IGha01ZHIDCdMVHKKaaVkuwtz0exYlvQn3RzV9E3VM42JVxwzA4O9LQPQlcetG4qEIyHjSu1w==
X-Received: by 2002:a0d:c0c4:0:b0:5d0:2475:b79d with SMTP id b187-20020a0dc0c4000000b005d02475b79dmr13804220ywd.23.1701303837572;
        Wed, 29 Nov 2023 16:23:57 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j3-20020a05620a146300b0077d674445f5sm5878109qkl.80.2023.11.29.16.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 16:23:56 -0800 (PST)
Message-ID: <25a5e810-1e57-4a59-ae82-cb2c7d28a116@gmail.com>
Date:   Wed, 29 Nov 2023 16:23:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: No care given to GDB scripts..
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <cfc3aa17-0f1b-4ffc-b848-33baa51b1196@gmail.com>
 <20231129150629.0a82efbfc1494972e4e4f8cb@linux-foundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231129150629.0a82efbfc1494972e4e4f8cb@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 15:06, Andrew Morton wrote:
> On Wed, 29 Nov 2023 14:48:02 -0800 Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
>> Hello,
>>
>> It is quite clear that there are zero cares being given to making sure
>> that GDB scripts continue to work after making changes to core kernel
>> code, and why would you, because you probably did not know those
>> existed, but they do and they are used, and useful.
>>
>> A recent example that was fixed by Kuan-Ying is this:
>>
>> and now of course, "lx-interupts" also stopped working altogether after
>> this change:
>>
>> https://lore.kernel.org/r/20230519134902.1495562-4-sdonthineni@nvidia.com
>>
>> and who knows what else I could not test that is also broken.
>>
>> We really need to find a better way to stop breaking GDB scripts, they
>> break way too often to be even remotely usable, and this is really sad.
>>
>> It is also quite clear that we do not have enough continuous integration
>> and regression testing to ensure those breakages are caught ahead of time...
>>
> 
> This isn't terribly surprising - the gdb scripts are a pretty remote
> corner and are peculiarly sensitive to getting damaged by routine
> kernel development.
> 
> Is there any way of scripting the scripts so we can have some sort of
> automated testing down under tools/testing/selftests/?

That might be a bit difficult to do as this would mean that we can self 
debug and introspect using gdb the live kernel. Testing using QEMU is 
definitively doable however. Of course, I just found another script that 
broke (device.py)!
-- 
Florian

