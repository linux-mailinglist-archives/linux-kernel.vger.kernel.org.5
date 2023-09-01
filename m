Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E7078F84D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348324AbjIAGCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348314AbjIAGCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:02:34 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB5110CA;
        Thu, 31 Aug 2023 23:02:31 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99cdb0fd093so192768966b.1;
        Thu, 31 Aug 2023 23:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693548150; x=1694152950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=szgK28PtaN+FU2kNtru/isvknJO6EUq+kNUlT5T4kY4=;
        b=kQnPKXx6LbpKvpwmALFyCdJeZSkOon4+VCHilxVXvxLEMRunYoEqdwN+Wt1N+6ebTq
         PeG3l77LxW4pEC9cpwYrnalhoova7WZk03lutZUknFa4L+Qde2h6FCWav42XxtKB5Qnf
         xb5lluVG0frpPIkzich26lwagDuhcn/FQhsIK3Im+9WGeKH2Bq43tSsla3hdf+sdsBj8
         h4/hFLKPQiRIWop98ag54C7G+7g+Bn3rrIfq/BDljMJBRuHHfMHj/E/azhHco+caSHFQ
         HmlY8AKi1xCqJiZpgCWFEIoG8I0sLgyZJ2m175gBw191L0PPOcIRkOimMBqy49IRO8/Y
         Nxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693548150; x=1694152950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szgK28PtaN+FU2kNtru/isvknJO6EUq+kNUlT5T4kY4=;
        b=FinGFx3pKvJD5deTTaNPDXfb5cHkQ/m1g/NRlFG+1HJkKm5+GvewHjnV/OlNCz+7WS
         6mrGVilGYfrRX4hoIAh/1varkB5DpKgb9bC3ARINHwdpsqdICEaoZ+jEJjmAeJQM1wc+
         FdH3DALIII2GLtz4LfKhvCaLomP1Z+1UtOL++tve3b1d6Z71qPpl6z/3WPPh4+0WX+dp
         /96fPRRX7IWmS/bcDN657GMP7sZzl0vAiRGfGtFQMJ5/RN9YcpCbKQ2VJLI5rsnT47eK
         3aFZDBNrjwfGH9JQ0gwQERpBXfoIrM70/NuvpXNM5D2xrAI9ysH1v3BX/39oggtYInAJ
         94bg==
X-Gm-Message-State: AOJu0Yyp+zUro/JebLSHzywyU4RIB5+pEp0CAZ11OrQOYplu1hWCSmzr
        7v76EtVj+HdTz+poOJAcVb8=
X-Google-Smtp-Source: AGHT+IHEUGe0z8VierR0iSKfteFbT/T7ZDzjLe13f9z2w3FINUU5xeaDGfrxriHiwmLpr9zPAqvGAA==
X-Received: by 2002:a17:907:b609:b0:9a5:d2c6:c578 with SMTP id vl9-20020a170907b60900b009a5d2c6c578mr898754ejc.11.1693548149577;
        Thu, 31 Aug 2023 23:02:29 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.42])
        by smtp.gmail.com with ESMTPSA id rk17-20020a170907215100b00985ed2f1584sm1560268ejb.187.2023.08.31.23.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 23:02:25 -0700 (PDT)
Message-ID: <44fd45f9-8e2c-f9a2-fe89-97329734e13c@gmail.com>
Date:   Fri, 1 Sep 2023 08:02:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH AUTOSEL 5.10 13/22] drm/amdgpu: install stub fence into
 potential unused fence pointers
Content-Language: en-US
To:     Chia-I Wu <olvaffe@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        stable@vger.kernel.org, Lang Yu <Lang.Yu@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230724012419.2317649-1-sashal@kernel.org>
 <20230724012419.2317649-13-sashal@kernel.org>
 <CAPaKu7RTgAMBLHbwtp4zgiBSDrTFtAj07k5qMzkuLQy2Zr+sZA@mail.gmail.com>
 <55fc4a28-1e17-44df-2069-a688828080e6@gmail.com>
 <2023083145-scoured-celery-2511@gregkh>
 <c657653e-24d8-5790-a91c-4c13bb9eaeb0@gmail.com>
 <2023083144-railroad-daybreak-7f41@gregkh>
 <CAPaKu7Q2vq5m6Av6L2LthnFy5w2XtjKUYF8Z2__0hVp0vj2L1A@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAPaKu7Q2vq5m6Av6L2LthnFy5w2XtjKUYF8Z2__0hVp0vj2L1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 31.08.23 um 20:55 schrieb Chia-I Wu:
> On Thu, Aug 31, 2023 at 7:01 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Thu, Aug 31, 2023 at 03:26:28PM +0200, Christian König wrote:
>>> Am 31.08.23 um 12:56 schrieb Greg KH:
>>>> On Thu, Aug 31, 2023 at 12:27:27PM +0200, Christian König wrote:
>>>>> Am 30.08.23 um 20:53 schrieb Chia-I Wu:
>>>>>> On Sun, Jul 23, 2023 at 6:24 PM Sasha Levin <sashal@kernel.org> wrote:
>>>>>>> From: Lang Yu <Lang.Yu@amd.com>
>>>>>>>
>>>>>>> [ Upstream commit 187916e6ed9d0c3b3abc27429f7a5f8c936bd1f0 ]
>>>>>>>
>>>>>>> When using cpu to update page tables, vm update fences are unused.
>>>>>>> Install stub fence into these fence pointers instead of NULL
>>>>>>> to avoid NULL dereference when calling dma_fence_wait() on them.
>>>>>>>
>>>>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++--
>>>>>>>     1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>> We start getting this warning spew on chromeos
>>>>> Yeah because the older kernels still kept track of the last VM fence in the
>>>>> syncobj.
>>>>>
>>>>> This patch here should probably not have been back ported.
>>>>>
>>>>> Why was that done anyway? The upstream commit doesn't have a CC stable and
>>>>> this is only a bug fix for a new feature not present on older kernels.
>>>> It is part of the AUTOSEL process.
>>> Could we prevent patches from being backported by adding a Fixes: tag?
>> Yes, that will show exactly where the patch should be backported to.
> This is also AUTOSEL'ed to 5.15.  That might need a revert as well,
> depending on when the amdgpu feature landed.

Both the feature and the bug fix landed in 6.5.

The bug fix should have never been backported to any older kernel at all 
as far as I can see.

Regards,
Christian.

>
>
>> thanks,
>>
>> greg k-h

