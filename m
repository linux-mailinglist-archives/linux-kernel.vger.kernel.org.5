Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826F777DCE1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243185AbjHPI7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243175AbjHPI64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:58:56 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F40B1990;
        Wed, 16 Aug 2023 01:58:55 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fe8c16c1b4so9731322e87.2;
        Wed, 16 Aug 2023 01:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692176333; x=1692781133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTJkrXWbhfgYd8DHDtHDl47GwVqiYFhKhamj/qCPvn4=;
        b=frJnwDZuiJ7GUuUnGu86WKskx5TWrl7t2OqI4wX90NjTrdfKKUWFeTw3L1/C7ocMCc
         4bKivJXsHCtscykXAxLXF4qukgbbQapgrwAQ5eROyzODQThEksnObVEhS/tYuQcialGo
         3N7FAE9aXV3gY/dTb+IeTa3JiELuORn0gNu4NSFl86URvtJUU17w0B4ojITcQ3RqLusS
         i6Y9gmCdJFNffuS7CdTHzSfkrlY4fJkwEDkkZj4s0I1sZQH7tO1Lt59dzIc5uNfjvVTN
         SygXr1MsKYaxli6GSLEi70RGKQ7VNC3fLtHQ9f4+Pwt8FsVxUeCavR4cty7V/qrhWHyZ
         6Lxw==
X-Gm-Message-State: AOJu0YwrIAywmTr4WgiCR3Z7Q7tWwasNgNaEthZq5wxAyOlg1SPntfki
        UMVY+NcSaKLm89tHprEBiodNjTdctgIfrA==
X-Google-Smtp-Source: AGHT+IHd2vfqi2Alc5nJPaoOZNy/cYIYAP1J0s3YddftE1EP8JVnXPTjpfbmz5Y7DL6Eg+tNanhnhg==
X-Received: by 2002:a05:6512:554:b0:4fe:7e7f:1333 with SMTP id h20-20020a056512055400b004fe7e7f1333mr1072406lfl.6.1692176333013;
        Wed, 16 Aug 2023 01:58:53 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id b3-20020aa7df83000000b005233609e39dsm7998716edy.30.2023.08.16.01.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 01:58:52 -0700 (PDT)
Message-ID: <00de3273-9433-138d-b659-826457e6a008@kernel.org>
Date:   Wed, 16 Aug 2023 10:58:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 34/36] tty: gdm724x: convert counts to size_t
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <20230810091510.13006-35-jirislaby@kernel.org>
 <20230815172247.GA1690054@dev-arch.thelio-3990X>
 <937e14c1-d884-0b6e-595a-e8aaa3d09025@kernel.org>
 <bdbdfdaad3a842d2837ac9d15ef2ab25@AcuMS.aculab.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <bdbdfdaad3a842d2837ac9d15ef2ab25@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16. 08. 23, 10:40, David Laight wrote:
> From: Jiri Slaby
>> Sent: Wednesday, August 16, 2023 7:47 AM
>>
>> On 15. 08. 23, 19:22, Nathan Chancellor wrote:
>>> On Thu, Aug 10, 2023 at 11:15:08AM +0200, Jiri Slaby (SUSE) wrote:
>>>> Unify the type of tty_operations::write() counters with the 'count'
>>>> parameter. I.e. use size_t for them.
>>>>
>>>> This includes changing constants to UL to keep min() and avoid min_t().
>>>
>>> This patch appears to cause a warning/error on 32-bit architectures now
>>> due to this part of the change, as size_t is 'unsigned int' there:
>>
>> Right, this is my brain fart thinking ulong is the same as size_t
>> everywhere. No, size_t is uint on 32bit.
>>
>> I will fix this -- kernel build bot seems to be slow -- it didn't find
>> the issue out in my queue, nor in tty-testing.
> 
> 'Vote up' my patches to minmax.h that make this all work.
> Then it won't care provided both values have the same signedness.
> (or, with patch 5, are non-negative 31bit compile time constants.)

Oh yeah, that [1] looks great. Why should one care in min(4096, 
sizeof()) after all…

So what's the current status of those?

[1] 
https://lore.kernel.org/all/b4ce9dad748e489f9314a2dc95615033@AcuMS.aculab.com/

thanks,
-- 
js
suse labs

