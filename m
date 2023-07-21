Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9431575CF6F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjGUQda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjGUQcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:32:33 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE17230E3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:31:08 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id ca18e2360f4ac-785d3a53ed6so26051639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689957027; x=1690561827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0JtwvbQtC+iskTlvyLN5EiIGyrZQ/+bgS1zwNRBV3g=;
        b=APW5D5N2zyP/3C7/aLp6sSV1S4sc8dxg2TTfy5wP2ErMasZzsAEfxt1H/vsrc/0OUD
         KF3qA1gNHJjbx7esCC6qyOLw0E7R4HB4wXNOy2OvG9NIQ4w/8AoTVFSNjj/6DgKag5WQ
         ZRhwASKKSJVD1XRqvbO+vdR42g+A/XQ7j7WyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689957027; x=1690561827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0JtwvbQtC+iskTlvyLN5EiIGyrZQ/+bgS1zwNRBV3g=;
        b=X4a7xB4pyFPB/iVYOushgFja+rL3tvbmlypgarFWukblJLwycAyKJpjrcERgVohpHT
         5BMotBnu5QWrxddsEn1NNMFUx+J58jWeIQMvyiLpcPrQIqdEAtYXNbJYKc2jtB/B8LBo
         4lgUROIc7vjXE+MyNmjfKy38af/aO2AFxjHxfcNwOIAr5EaKnh5/xmE6wvD4HRmxRoyl
         qU8IiDJ9QjhH+c6sQoHr4Lq2Gn4rhePEmRD4swEwXqmE7wsgS5NfUXRRDRQw86CpQcAc
         kuZI9UpH5WGQU0O4mToVI9ILN1EjzUbqMw1x/p1gc5HDnhX47H5i9q7sId2FTM7fWlEm
         JV6A==
X-Gm-Message-State: ABy/qLZlSUrPE6Rr8/qE0QN8cto/gQPN/XxgwLjC/ehWkd1ZH1kK3MoZ
        1W/hrIc4oDGyk5lXZSlYI9TBrA==
X-Google-Smtp-Source: APBJJlH4RQUKVHLkjGZF34XSzs4Luu314oyQ+D4PCOqpETARp6u9Im2A96K3UUOdmsZ84Z32gyUhSg==
X-Received: by 2002:a05:6602:14d2:b0:783:6ec1:65f6 with SMTP id b18-20020a05660214d200b007836ec165f6mr3145614iow.1.1689957024888;
        Fri, 21 Jul 2023 09:30:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l8-20020a02cd88000000b0042b149aeccdsm1150011jap.104.2023.07.21.09.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 09:30:24 -0700 (PDT)
Message-ID: <2fc0b741-f1af-b970-f505-48a897df6550@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 10:30:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] selftests: prctl: Add new prctl test for PR_SET_NAME
Content-Language: en-US
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230607153600.15816-1-osmtendev@gmail.com>
 <b7a3219e-4e0a-7a08-439a-a8a6e35271ca@linuxfoundation.org>
 <CAK6rUAMODPLQeUawXMW_RNiJFdukOqdhS5GA5XRAq4U9bnQdNg@mail.gmail.com>
 <3c03e28b-8006-a4ac-30bc-6aaf83ccb5d5@linuxfoundation.org>
 <CAK6rUAObT-kQVGddhvxxtaKPcuaDddM6ipEDXuECCFtpR-GV6w@mail.gmail.com>
 <CAK6rUAMuYTUhqcGmDrmeEWnigy3X4OxNb4zmHc0TmcVJ79MyHg@mail.gmail.com>
 <ecf66ba7-6e63-5ee3-acce-b2da9327b76f@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ecf66ba7-6e63-5ee3-acce-b2da9327b76f@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 10:21, Shuah Khan wrote:
> On 6/26/23 12:36, Osama Muhammad wrote:
>> Hi Shuah,
>>
>> Any feedback on this patch?.
>>
>> Thanks,
>> Osama
>>
>>
> 
> Please don't top post when you are responding on kernel
> mailing lists. It gets very difficult to follow the
> comments in the email thread.
> 
>> On Sat, 17 Jun 2023 at 18:01, Osama Muhammad <osmtendev@gmail.com> wrote:
>>>
>>> Hi,
>>>
>>> Yes, I did install the latest kernel headers and TASK_COMM_LEN is not
>>> accessible in userspace.
>>>
>>> I looked into the test which uses TASK_COMM_LEN but the test defines
>>> it in its own header file.
>>>
>>> Example:  https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/bpf/progs/pyperf.h#L13
> 
> bfp test does things differently because its dependencies
> on run-time environment.
> 
>>>
>>> TASK_COMM_LEN is defined in include/linux/sched.h, but this header
>>> file is not exposed to userspace.
> 
> Correct. you can include linux/sched.h like other tests do
> Take a look at tools/testing/selftests/clone3
> 

You are right about TASK_COMM_LEN not visible to user-space.
This patch has been applied to linux-kselftest next for 6.6-rc1

thanks,
-- Shuah

