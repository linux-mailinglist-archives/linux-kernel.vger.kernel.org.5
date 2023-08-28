Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F69E78B256
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjH1N4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjH1Nzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:55:43 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38329BA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:55:40 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-760dff4b701so31440639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1693230939; x=1693835739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RqPkGcsk4FuV+HMwkCm5TjJ0nUyn4er318TkaWcu7eU=;
        b=C4VpQu7oHbFFg0/6ofyDMcosnb5QZ2R6qrHVoZUOQ0W+mVHNTazVGA/M+dVzU1rs5b
         EDIbB8kQfsZa0QceQIjpWIQnQSJXSlXg3ogqJGak2RJb5RcdqUD3gkw/qpQkQcsW3/5H
         kQsTyzM6OHQucfWrfCnhrm5Ugow6wU4WANw5w+v7eYMkMwsEGvRxPYiFREXEJXuz6FXR
         +9ArjDGQZnfj5h+qoyHj+JACXwV9axzyy0oYAxJXZGlg3qNq9LKzxT+e0dPMaxPrRgVL
         EdnsWJhVlaLQFeXw4odqxEodubl1hGJ5Ntc4kqK3mKIgB1iO+yfSTgXqGmMPydKkLZSR
         j7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693230939; x=1693835739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RqPkGcsk4FuV+HMwkCm5TjJ0nUyn4er318TkaWcu7eU=;
        b=VKUw632ZiGaj55t29gN5LHclFm+HTog1XdJh2V+FJPHYrWBV7udbOXOptBXqinP6Z2
         qctFPrAIFaG+1V/kb+/hsmFv2iexkxd8QPZtJh9WLp+TuwW+x75X7+jpG0gk1NXKr2VZ
         rNMvlvvX3TKgixAajtbJjYdhASnyblgvPBxICELYFYZGYPl40UqknFAT9XKTzeGcQd1h
         9ONUER2UE9OnINbkxy0cuI0KHNegn9GpyiPQj6IowR/0/vYvm7nbOrsV3M04/JdYZ6it
         /Up2JBH5dT0ZBcx4Dacq/mLrshpnYKgndnFmUAljo4wBXjzIf5gwEnDjnVh0+E+0J5tj
         FtLA==
X-Gm-Message-State: AOJu0Yz/840LY7C2IW4qgiSXKllg6RHFcS6LljU9BA4/9HUHeizJuJaJ
        qp7j6b+whu9lkJVpZCp+9MaeBA==
X-Google-Smtp-Source: AGHT+IEZrYYmE2kyP+/ZWXWBFkncsQpTodgqMGVqRJXLmCNYekGBhdn8fuNayoi1iANMe7tqGsLSPQ==
X-Received: by 2002:a92:4b0d:0:b0:345:e438:7381 with SMTP id m13-20020a924b0d000000b00345e4387381mr25049882ilg.2.1693230939593;
        Mon, 28 Aug 2023 06:55:39 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a2-20020a02ac02000000b0042b39b2289asm2489029jao.102.2023.08.28.06.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 06:55:38 -0700 (PDT)
Message-ID: <285df093-dd85-4d5f-8151-6d9f54a994b5@kernel.dk>
Date:   Mon, 28 Aug 2023 07:55:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.5.0rc5 fs hang - ext4? raid?
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "Dr. David Alan Gilbert" <dave@treblig.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, hch@lst.de,
        adilger.kernel@dilger.ca, song@kernel.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <ZNqWfQPTScJDkmpX@gallifrey> <20230815125146.GA1508930@mit.edu>
 <ZNt11WbPn7LCXPvB@gallifrey> <ZNu668KGiNcwCSVe@gallifrey>
 <ZNwm7Mo9yv7uIkno@gallifrey> <324fc71c-dead-4418-af81-6817e1f41c39@kernel.dk>
 <ZNzg1/zhxYV2EkBX@gallifrey> <ZNzl2Sq9UJ3FiTgV@gallifrey>
 <ZOymtgiZYGQ6QlxN@debian.me>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZOymtgiZYGQ6QlxN@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 7:52 AM, Bagas Sanjaya wrote:
> On Wed, Aug 16, 2023 at 03:06:01PM +0000, Dr. David Alan Gilbert wrote:
>>>> Can you try and pull in:
>>>>
>>>> https://git.kernel.dk/cgit/linux/commit/?h=block-6.5&id=5ff3213a5387e076af2b87f796f94b36965e8c3a
>>>>
>>>> and see if that helps?
>>>
>>> <testing....>
>>
>> Yes it seems to fix it - thanks!
>>
> 
> #regzbot fix: 5ff3213a5387e076af2b87f796f94b36965e8c3a
> 
> Yet, I don't see that fix commit on v6.5 release...

That's because it's e5c0ca13659e9d18f53368d651ed7e6e433ec1cf

-- 
Jens Axboe


