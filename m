Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2E47DAD00
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 16:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjJ2P3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 11:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2P3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 11:29:01 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86D0BE;
        Sun, 29 Oct 2023 08:28:58 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c595f5dc84so53303561fa.0;
        Sun, 29 Oct 2023 08:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698593337; x=1699198137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6xDf5Vc6zIi1SFmLYHQbpwJviofARaCdjRCBH2Jzes=;
        b=BmSv2/4yWcJ4yIBSPcRCmZ73Rsy1uTyagXBTKq7NiTllYTjjGObsxtdJWvl9f9zhZl
         cEzoJSbYJFoL15ETEAqyvgTh1NQr0BXwtZJCOuLB8pMky76IvkjAyT3lRAHq9rKLiY7Q
         /CowBj5IPmgMuFpI1mBDMqYZX9jnLk58z41z+buexw9L4Iiv33WSWPti/m3k7funE9k6
         YrPBs7GIjbzloKoO5nMJfJhnmuHjuhfvL6ICYY9pBIxeup6w7uaVNmEg3I4BTUlBD9We
         YtU1v6rYIiDpqYGwzUEBqW1hdSlaT2wTITMfK1TMOl20gu1tPEti9//tbISGXsENZoQ4
         Jc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698593337; x=1699198137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6xDf5Vc6zIi1SFmLYHQbpwJviofARaCdjRCBH2Jzes=;
        b=vUC+e9aHXf5Aru4hsFTcsyLZGVlbfx135IFev//RYBkB2CAsX2BM1qLohJ9j3u0PF0
         rUEG+t6LfxcMJBRzA2irJfQHpD+7a7bT6aJb3twDZiPXeLE5qzjjk9yd9QMMWWoxiyD+
         6KKQGfXdV2YapKt+PrYpXhOUXvreoywNmp5hz6I2VONtJpiApHXz/TuGmx2T+ojcz6w4
         EUHlrMgNWVXJA0C7PEzk7EeaOCFy4ONDslS3PxAjHWifz4/PaplxugDH5jn7q4xWBLwK
         pAOaueVx/0hQASrl7jjqKOEs4P8iyT29JCxQyudNHasmVEME++0i7H2CAxjCG14/5rUP
         dsxA==
X-Gm-Message-State: AOJu0YwnkMu+caoSkbuvz5qkUf27Ubv/eCQApB86iz7UQMARGe9scKRD
        CWq73gXsFbXxYxjHVSwuBBk=
X-Google-Smtp-Source: AGHT+IFmXgCezaC7vQI1X/HcXYQF/BW2paEjNK3JBgSkgq69t9L8kKBJH4xk5d1uQ0EtNSMxoDt7QQ==
X-Received: by 2002:a05:6512:3bc:b0:507:cc09:59ab with SMTP id v28-20020a05651203bc00b00507cc0959abmr2288341lfp.9.1698593336638;
        Sun, 29 Oct 2023 08:28:56 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id w29-20020a05651204dd00b00507f1c8040fsm1067146lfq.58.2023.10.29.08.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 08:28:55 -0700 (PDT)
Message-ID: <5d63087a-91c8-434e-aa47-a3d60e456e1f@gmail.com>
Date:   Sun, 29 Oct 2023 17:28:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Sanity-check available_scan_masks array
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1697452986.git.mazziesaccount@gmail.com>
 <20231021165535.34dcb94b@jic23-huawei>
 <db83cafb-1a96-40c4-ab36-8cb1ef0f2f30@gmail.com>
 <20231028173221.4dd81185@jic23-huawei>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20231028173221.4dd81185@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/23 19:32, Jonathan Cameron wrote:
> On Sat, 21 Oct 2023 19:03:15 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 10/21/23 18:55, Jonathan Cameron wrote:
>>> On Mon, 16 Oct 2023 14:04:11 +0300
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> Sanity-check available_scan_masks array
>>>>
>>>> The available_scan_masks is an array of bitmasks representing the
>>>> channels which can be simultaneously(*) scanned by a driver from the
>>>> device. Following special characteristics apply:
>>>>
>>>> - When IIO is scanning through the array it will use the first mask
>>>>     which can be used to scan all enabled channels. This means drivers
>>>>     should order the array in the order of the preference. This does also
>>>>     mean that a mask which is a subset of a mask located earler in array
>>>>     will never be used because the earlier one will be picked by the core.
>>>> - Masks wider than size of long are supported only to some extent. The
>>>>     code scanning through the array will interpret the first mask with
>>>>     first long zeroed as end-of-array terminator. Changing this behaviour
>>>>     would make mask-arrays for multi-long masks to be terminated by more
>>>>     than one zero long. Failure to do so would result kernel to read
>>>>     beyond the array generating a potentially hazardous bug.
>>>>
>>>> Add a sanity-check to IIO-device registration emitting a warning if
>>>> available_scan_mask array is misordered or if mask width is larger than
>>>> a long while available_scan_mask-array is populated. Currently there
>>>> should be no in-tree drivers with available_scan_mask populated and mask
>>>> wider than a long.
>>>>
>>>> Revision history:
>>>> v1 => v2:
>>>> 	- Add patch 2/2 documenting why iio_scan_mask_match() checks only
>>>> 	  a long worth of bits while searching for the end of the
>>>> 	  available_scan_mask-array.
>>>> 	- Styling of patch 1/2 as per comments from Jonathan
>>>> 	v1 and related discussion here:
>>>> 	https://lore.kernel.org/lkml/ZRvjuZaQWdZw1U1I@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi/
>>>>
>>>> Matti Vaittinen (2):
>>>>     iio: sanity check available_scan_masks array
>>>>     iio: buffer: document known issue

...

> 
> I've started queuing stuff up for rebasing post merge window, so I've
> added this as well. For now will only be exposed as the testing branch
> that 0-day pokes at.

Thanks Jonathan!


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

