Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294017BBE60
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjJFSGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjJFSGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:06:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0132ED6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 11:06:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-406aaccb41dso5143615e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 11:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696615600; x=1697220400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cm3rU0s+wij9WVyx3Qhj5G5fmBbZgp+XmLtSeaB6d2U=;
        b=G1vNeIdRxwdRydtOywZFybPedxPmE9RF13Sk5lkxX1kG1KKkaLFDqyjuSdK3PudCcY
         /hpFog9Hweigu1WZh/oGDXqTZL7InR2zfJKC07U0349xDEZbhcJO/LOsLYa9IPsVVsM9
         2zFjYCgH8/TUmmQARMe3zvIM9xt4PK+K2530ZNWb2d3UyNNHQKQNGy2pfXiFf8SxWJ84
         1yXJWfE/yz01WTwuc3PBKYbiRSYJX/czVJVwX9BDvxxGOCiYxg45mZYDF8UmRBf2WMc8
         Y+dQQnPIKdCSbH1gi79/WLWMFK6F0mPk+nBxwgg+zA9hVHH70KufhiPKyX2CvtvuGFVh
         6CWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696615600; x=1697220400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cm3rU0s+wij9WVyx3Qhj5G5fmBbZgp+XmLtSeaB6d2U=;
        b=LnRmHFnym9KjWvhUvT72NbUBe+rkh4gVhYmdrKA49cQX3A26Ye2Di0dTtB2j1aQ/bg
         C8HfNN+0nFXu9gZbJKAi17dpuwJfxtUCVUxur0CKYXGWRLYImO/aav7FszkLv8pqBqz4
         HBJUWHXQBwGyMASXx6BWTqmJSdZNESk7MiMf3+B60QemmfjkU6meafiYgQ5rIGvb6KN0
         MC5n1g1Uor2MrF5aZJOEP/wMUqw5uCgt16o+iOIW1wEoVnUQ3Jmc0mSiD413cEnQq9EP
         5Jf6o9FTrmb9uFd39HdpcFUOYF2pBS7SeM0H+4ZXw0/iilOMTdpgK1de5pMe/G8Hvo4K
         nE6Q==
X-Gm-Message-State: AOJu0YwaOvdgnwUNMIh417hsLdPEnCSq3yqNF0ZThhXIsLphk6RvPATG
        vGY65q1dsxQJ4G1+zUW49F4=
X-Google-Smtp-Source: AGHT+IEbbIpQ+E7sgB0llYkcPQJK3+3Sog2yKB7MyyaZhZ3taDN1yVM75GHsqn8cu9e0OgVsnL2jOQ==
X-Received: by 2002:a05:600c:474b:b0:401:c07f:72bd with SMTP id w11-20020a05600c474b00b00401c07f72bdmr8262114wmo.4.1696615600162;
        Fri, 06 Oct 2023 11:06:40 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:e405:da00:cf04:a7d5:e45d:73bf? ([2a01:4b00:e405:da00:cf04:a7d5:e45d:73bf])
        by smtp.gmail.com with ESMTPSA id f17-20020a1c6a11000000b004063ea92492sm4215134wmc.22.2023.10.06.11.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 11:06:39 -0700 (PDT)
Message-ID: <e82750a9-d12f-77e4-0284-71d502f58254@gmail.com>
Date:   Fri, 6 Oct 2023 19:06:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] ALSA: aloop: Add support for the non-interleaved
 access mode
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230927113555.14877-1-ivan.orlov0322@gmail.com>
 <87sf6ow2t6.wl-tiwai@suse.de>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <87sf6ow2t6.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/23 09:52, Takashi Iwai wrote:
> On Wed, 27 Sep 2023 13:35:54 +0200,
> Ivan Orlov wrote:
>>
>> The current version of the loopback driver supports interleaved access
>> mode only. This patch introduces support for the non-interleaved
>> access mode.
>>
>> When in the interleaved mode, the 'copy_play_buf' function copies data
>> from the playback to the capture buffer using one memcpy call. This call
>> copies samples for multiple, interleaved channels.
>>
>> In the non-interleaved mode we have multiple channel buffers, so we have
>> to perform multiple memcpy calls to copy samples channel after channel.
>>
>> Add new function called 'copy_play_buf_part_n', which copies a part of
>> each channel buffer from playback to capture. Modify the 'copy_play_buf'
>> to use the corresponding memory copy function(just memcpy /
>> copy_play_buf_part_n) depending on the access mode.
>>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> 
> Sorry for the late reaction, as I've been (still) off since the last
> week.
> 
> Now applied both patches.  Thanks.
> 

Hi Takashi,

No worries and thank you for applying both patches :)

--
Kind regards,
Ivan Orlov

