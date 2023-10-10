Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511397C429A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344058AbjJJVcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjJJVcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:32:05 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE0892
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:32:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50435ad51bbso7540050e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696973521; x=1697578321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Pjl5gkMN+tM8cTCpSlEYTm/NSKpOFFUeh14zRzLcbk=;
        b=XqAAeEniUYSWT04379UmiBPgZ5qQRyMJMOtaX9B9zY2ggxvmibNu50FSI+VtlRETn/
         VhtYOLPBDBGQGN1tkpr9aYVmvBlfLWy+SU/Xk6zZBmqEEWNLy27UXT6wfjdejxIzxYER
         zlwYyZuZDns528aNj5NYQwbOXxHOVf1K9Mr+kKEVDF5fCTjwRRJP9pKaom1ukYn3GyyY
         bXytY5pZr9FcVJKMCYTj4s2311wSEMcsl72QDdo54LPSXTEete44DJAAwmVvUy1c24f2
         2AddR3LCXUeveogNgK3cuu1nQHtCE1XV5Ep4oZYD7srRwwgNBQgKTNw3LOolkQoYwmHS
         Xe5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696973522; x=1697578322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Pjl5gkMN+tM8cTCpSlEYTm/NSKpOFFUeh14zRzLcbk=;
        b=ChPWEStbw3YssGKJFYh9KMvvn78Sn8vYWe23Vxb6vw/Mgf6tKp1D1yQISFzVp0BnN/
         grwVSj4KSYMMaMOCd/l55wYfifa0/LyRo3jyT/iUiEKBBYyDRJl1T6ouDO+3IMSViZye
         Ce3NJs6LZAZhN790h06lNYQ9uHsB0tlYktXkZPfrm24bZgYFD4RnguGHCufPuuwtxL1D
         img1Jae1qnoFg2Mp2JXp8jdu4/C0bGTc+nkKaAWBxl1+454i67mgByFvlTZDa1BIAdx8
         /77OlCDoOQFHWQBDycsfGNs3wWTpgZeyLbwf/qm2DMDci7UMzXUNtnnNdcuYSmWm/iwC
         vgHA==
X-Gm-Message-State: AOJu0YzSemgm8SkXNXeyuwoKSeT66nmF1thJ5TreiszcrmHDZH1S4f1+
        IGXPO70CdcyGYGOp6mLpIRShRQ==
X-Google-Smtp-Source: AGHT+IFTH+PnydGygfHJ5Wn21hsrxocpZo61z4PXV5Fk+BDkmC1vFS6LrzUHkxTN24/XcrQG8pTqMA==
X-Received: by 2002:a05:6512:a8b:b0:4ff:80d4:e132 with SMTP id m11-20020a0565120a8b00b004ff80d4e132mr22854903lfu.29.1696973521677;
        Tue, 10 Oct 2023 14:32:01 -0700 (PDT)
Received: from ?IPV6:2a00:f41:8004:ab80:24a8:5e5d:e0b2:5884? ([2a00:f41:8004:ab80:24a8:5e5d:e0b2:5884])
        by smtp.gmail.com with ESMTPSA id s8-20020ac25fa8000000b0050482b29ac9sm1965533lfe.212.2023.10.10.14.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 14:32:01 -0700 (PDT)
Message-ID: <68fd8e0e-1788-435e-a0fe-77b4252387ad@linaro.org>
Date:   Tue, 10 Oct 2023 23:31:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] mm: hugetlb: Only prep and add allocated
 folios for non-gigantic pages
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        songmuchun@bytedance.com, fam.zheng@bytedance.com,
        liangma@liangbit.com, punit.agrawal@bytedance.com
References: <20231009145605.2150897-1-usama.arif@bytedance.com>
 <20231010012345.GA108129@monkey>
 <6b1d9860-3581-0b99-4fb7-4c1f5a2a05f3@bytedance.com>
 <20231010213019.GB279095@monkey>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231010213019.GB279095@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/23 23:30, Mike Kravetz wrote:
> On 10/10/23 18:01, Usama Arif wrote:
>>
>>
>> On 10/10/2023 02:23, Mike Kravetz wrote:
>>> On 10/09/23 15:56, Usama Arif wrote:
>>>> Calling prep_and_add_allocated_folios when allocating gigantic pages
>>>> at boot time causes the kernel to crash as folio_list is empty
>>>> and iterating it causes a NULL pointer dereference. Call this only
>>>> for non-gigantic pages when folio_list has entires.
>>>
>>> Thanks!
>>>
>>> However, are you sure the issue is the result of iterating through a
>>> NULL list?  For reference, the routine prep_and_add_allocated_folios is:
>>>
>>
>> Yes, you are right, it wasnt an issue with the list, but the lock. If I do
>> the below diff it boots.
> 
> Thanks!
> 
> I believe that may be that may be the root cause of boot issues with
> this series.  It is unfortunate that the failures were not consistent
> and did not directly point at the root cause.
> 
> Hopefully, these changes will resolve the boot issues for Konrad as well.
> 
> I will create a new version of the "Batch hugetlb vmemmap modification
> operations" series with these locking changes.
We sent a reply at the same time :P [1]

Konrad

[1] 
https://lore.kernel.org/all/6f381d4c-d908-4f00-89b3-ed3bcb26b143@linaro.org/
