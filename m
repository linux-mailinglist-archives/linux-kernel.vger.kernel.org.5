Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B70D78EE96
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243280AbjHaN07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242625AbjHaN05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:26:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6C9E54;
        Thu, 31 Aug 2023 06:26:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c63cd4ec2so651003f8f.0;
        Thu, 31 Aug 2023 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693488412; x=1694093212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izN8y1TLkmCn8It+Lcd7BlxbIdHxMn/IMnM8Q8VhJ14=;
        b=MQyf5TVaXiy+bHpamdF8umdflKZRvHCMdsLCx35DobPDZIPlNUIWIXo0YsLCXvIcKE
         fbJ5vXkjFOqPgkqf+hYyKwWsmxEXgzloI2VOMWZUUFfSoenKZJ7UmWIbDByQ27PD5Cxt
         kvybpsJ31y0YFmxMrgskocrNAMPQpDecCzXv0pKUWgJwXaza0lxezVseGvkVQIjDcEpM
         J8h7xrka+jQXArfn9mc82D95oZCdko8eCWydyS6vmcukm7Gl2evIvvEPUiV+NUMSTF7R
         COGo4eRqINcmozVOI16Qv4p23d0/ZzjYUz9Jn5DMJHbhJjRHg9BXCICkTpuFAt9D38A1
         IVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693488412; x=1694093212;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izN8y1TLkmCn8It+Lcd7BlxbIdHxMn/IMnM8Q8VhJ14=;
        b=jlRcORg+wEKvKMciPLUKKjjCg5QE5HbxXvAJ7JrgFA+//aEJ8jURAe8aoD06/MMh6u
         DbZ+UUerOeCPrd9BX1GAZqU1ikDdK91ve+Il813ybAMXIStwZoVZqion1uNu1UrajTWa
         WQYqWMZMvF2sZw/LXItyfMdRuUP8JZ8Ivm7inI95MuYvv7ZxvitynnLauLO6tjrJtO8L
         Ey5ZCwlR6FO80XvSl7yEsLUKBClRfFGtqloFwldintmoVAa0ZBxRwQP5QVUZFXoIt38c
         W9ZPKZKU63PJeKB0FpJqohumwlDR/6iIAIfVwuqxmheEt67uRBSJ0n4O9yK8fVTJFsZq
         /Dhg==
X-Gm-Message-State: AOJu0Yzt7tUWxo0PFT/AtP1rdMZGKP/AiDkcQKhuA+OHOE56jVKbWnOs
        CuNUgH3ogqlD1kszW/0GO9U=
X-Google-Smtp-Source: AGHT+IHnagwLLeLlCCtU5v5GLAHjoVb8snl71EU2/1lG7lELEL/vPVePoL2VczUDyMaDlI1V9GLwXg==
X-Received: by 2002:a5d:49c7:0:b0:317:70da:abdd with SMTP id t7-20020a5d49c7000000b0031770daabddmr4047998wrs.59.1693488411526;
        Thu, 31 Aug 2023 06:26:51 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d5389000000b0031753073abcsm2240940wrv.36.2023.08.31.06.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 06:26:50 -0700 (PDT)
Message-ID: <c657653e-24d8-5790-a91c-4c13bb9eaeb0@gmail.com>
Date:   Thu, 31 Aug 2023 15:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH AUTOSEL 5.10 13/22] drm/amdgpu: install stub fence into
 potential unused fence pointers
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Chia-I Wu <olvaffe@gmail.com>, Sasha Levin <sashal@kernel.org>,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        stable@vger.kernel.org, Lang Yu <Lang.Yu@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230724012419.2317649-1-sashal@kernel.org>
 <20230724012419.2317649-13-sashal@kernel.org>
 <CAPaKu7RTgAMBLHbwtp4zgiBSDrTFtAj07k5qMzkuLQy2Zr+sZA@mail.gmail.com>
 <55fc4a28-1e17-44df-2069-a688828080e6@gmail.com>
 <2023083145-scoured-celery-2511@gregkh>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <2023083145-scoured-celery-2511@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 31.08.23 um 12:56 schrieb Greg KH:
> On Thu, Aug 31, 2023 at 12:27:27PM +0200, Christian König wrote:
>> Am 30.08.23 um 20:53 schrieb Chia-I Wu:
>>> On Sun, Jul 23, 2023 at 6:24 PM Sasha Levin <sashal@kernel.org> wrote:
>>>> From: Lang Yu <Lang.Yu@amd.com>
>>>>
>>>> [ Upstream commit 187916e6ed9d0c3b3abc27429f7a5f8c936bd1f0 ]
>>>>
>>>> When using cpu to update page tables, vm update fences are unused.
>>>> Install stub fence into these fence pointers instead of NULL
>>>> to avoid NULL dereference when calling dma_fence_wait() on them.
>>>>
>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>> We start getting this warning spew on chromeos
>> Yeah because the older kernels still kept track of the last VM fence in the
>> syncobj.
>>
>> This patch here should probably not have been back ported.
>>
>> Why was that done anyway? The upstream commit doesn't have a CC stable and
>> this is only a bug fix for a new feature not present on older kernels.
> It is part of the AUTOSEL process.

Could we prevent patches from being backported by adding a Fixes: tag?

Thanks,
Christian.
