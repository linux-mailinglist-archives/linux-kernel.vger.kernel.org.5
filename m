Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2BA7BBE45
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjJFSDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjJFSDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:03:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C594FB6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 11:03:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3175e1bb38cso376312f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 11:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696615379; x=1697220179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DW5DjcAJlISg3sn4dnbscxpT4hEh5MjXjjwSsYat0ec=;
        b=lznVfkCGvtRhAzipxKhDyepjPL76u4ZJGOnwHINO1/MlK6LpSkNwaf7CK3jcBPTOFm
         ajGVt3UUbjXEVOyxt4gx+Ir4zfBvvjLhkWeLITMFawvPYo7WK+H7uJGzIvPKmDotmX2s
         gYUoSAlHLF8ICx2sDQSCDtQ7EYYYiEtRmUP9B1pqg3C8GdjOH2Bx4JCSthfUpMirlCiK
         hr1TyCqGnn/OF7cKCOcZbMFgAZPepM+NYjbiCqGYHwSSZRN0QgdxKLKos4zcn2hwvbZ9
         yFyF0lx1eHPKRMA/x0rXabkndRDvn5Q5pnOUbUsnJm06hnqDeu4Vyx9NQdDE9GxcYX3p
         XI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696615379; x=1697220179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DW5DjcAJlISg3sn4dnbscxpT4hEh5MjXjjwSsYat0ec=;
        b=hLzDc66RIPJrRhxC9dfRgfKLcf+GmyDbe/hoVWkl/qPknyUCTxLpSQw+iAlJSsZZ6K
         mHzb5miWBsVuT9WpSygySZUh+T5lq+vcDqDTh3ICmVzH4KhNY3S95GoJbt6niBF8OmP4
         Zc7DBt07vzP7CpjvPkc7L+EBwXHhmeehbElzsLxsyjIz2xtea3PBmkGQTOXKfBbU2tXx
         0Y9Zdo1SmWanjFBXw8LmU/zAIwR4kKJsfFy/84Nrh78CmXURNRzS7rjoCQonD8FsAuz8
         Ei4W27/GFXg2CpPMowmorGwVs0bbEonnkeLAXyk/B5v7WKvIu86FdRPbjcqppYNR9rZR
         EzcQ==
X-Gm-Message-State: AOJu0Yz0V/FijibG3/O9rh7Q+ROmJDvrCMuA8w2bTx778DuX2m84Bcu3
        MR1DiKnGMa58BKWYo/dyao0=
X-Google-Smtp-Source: AGHT+IE3rPgMYpXgMKooXH0DQLexRyaKcUcmKebwZM6Kl3hFNlUUhmaaSDA2KHIsA8aGt7JMQzno8A==
X-Received: by 2002:a5d:5687:0:b0:317:73e3:cf41 with SMTP id f7-20020a5d5687000000b0031773e3cf41mr7453777wrv.1.1696615378930;
        Fri, 06 Oct 2023 11:02:58 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:e405:da00:cf04:a7d5:e45d:73bf? ([2a01:4b00:e405:da00:cf04:a7d5:e45d:73bf])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d6b0b000000b00324853fc8adsm2129192wrw.104.2023.10.06.11.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 11:02:58 -0700 (PDT)
Message-ID: <2fa1f433-326a-8eb6-b01e-e34ff82a2dd9@gmail.com>
Date:   Fri, 6 Oct 2023 19:02:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] ALSA: aloop: Add support for the non-interleaved
 access mode
Content-Language: en-US
To:     Jaroslav Kysela <perex@perex.cz>, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230927113555.14877-1-ivan.orlov0322@gmail.com>
 <b9b2ea05-9d10-d263-f08a-5e3cf1f33a9d@perex.cz>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <b9b2ea05-9d10-d263-f08a-5e3cf1f33a9d@perex.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 08:23, Jaroslav Kysela wrote:
> On 27. 09. 23 13:35, Ivan Orlov wrote:
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
> Nice extension. Thank you.
> 
>> +static void copy_play_buf_part_n(struct loopback_pcm *play, struct 
>> loopback_pcm *capt,
>> +                 unsigned int size, unsigned int src_off, unsigned 
>> int dst_off)
> 
> I would probably prefer to have dst,src,size arguments to follow memcpy, 
> but it's really nitpicking.
> 
> Reviewed-by: Jaroslav Kysela <perex@perex.cz>
> 
>                      Jaroslav
> 

Hi Jaroslav,

Thank you for the review!

I agree that parameters similar to the memcpy would look better than 
that, I'll keep it in mind when I send the next patch :)

--
Kind regards,
Ivan Orlov
