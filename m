Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D3A781D71
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 12:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjHTKc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 06:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjHTKcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 06:32:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E3F5267;
        Sun, 20 Aug 2023 03:28:34 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3feddbb670cso11555565e9.3;
        Sun, 20 Aug 2023 03:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692527310; x=1693132110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94uIH6VS6gCDgKqMKOSc2iIFz6eCet2HKZcMlYptNYI=;
        b=aS96MJM/fQ8ImFphvXUauVSn/5sbW0er4pALKMkXG89QEVHNEdQlkukP6V/HhTtzUs
         llTS/R9oLd2u2Y6Qw+ojLYbEBajEAPgYfUKzZCKWifQi4nALNfAe3STKpiHcgS4XMLXC
         Zocbvr0Z8uS7BaKuksrk2jAW3nPLbxU5F2eVTZLg0SA4UeQrOZtd7jfsVzE634nM05Lk
         DntXnoLUv0y32Mez0IbqvK+1e3tpluX2Dm2KsWTMoJwfPYbWIn+tBVAlBrDcdSYZv8TX
         57zbtqR0NxYCdFHwXa5x1OGIyjkPKOmhRK2Iw8HLIzTpcWAVb/JJAemZAOfWjRiabJLg
         DoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692527310; x=1693132110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94uIH6VS6gCDgKqMKOSc2iIFz6eCet2HKZcMlYptNYI=;
        b=ZqNo9s6OfJ6P1BCKiULQd0LtboFP6w8PcfT/4HIhXDVwX8Eqyo21Rr79KzXt83o1+x
         /HOd3KF19HbOekWeB2v/A2qcGJg9ftEefMxcJAXW+yUEgMYvnCRm6bGcxEziNFPKHhao
         K34wvzbjZvqeEF7J5/vovUceK+M7I/Gba6Wxm3RX50AYqyH8wYvRB2/msDXC6B+v22Gf
         lSV88lpG/jZNywoo3L3B15rYvzLHGpUXisQSkl03RSKzPeZe/CQjg5yBN5hcAzppzv2m
         zLPHTIorUpTll/di0LpO7+tLlwcpfg9ctn2P7jZbDG7HMmYeCwAWIpbaxgaP5QyV/jlC
         yWDg==
X-Gm-Message-State: AOJu0YwQBX2HQn2GdrcW9nin9MW0SEPkOjlKlg9Qj/KzWBedWMbRarRU
        ERy/SVCf0uyqAAJPSN8rq5c=
X-Google-Smtp-Source: AGHT+IFf5aNDzN2MDrJ91cQtvrfXkuniDVlVThP7KPuXd+BLNJhyHXibCDp0X5/LQ8xN7vQMRvwg9A==
X-Received: by 2002:a7b:c38a:0:b0:3fe:ba7:f1ef with SMTP id s10-20020a7bc38a000000b003fe0ba7f1efmr2778520wmj.30.1692527309808;
        Sun, 20 Aug 2023 03:28:29 -0700 (PDT)
Received: from ?IPV6:2a01:cb15:b7:2500:4ac9:fac6:b0ea:bf8d? ([2a01:cb15:b7:2500:4ac9:fac6:b0ea:bf8d])
        by smtp.gmail.com with ESMTPSA id f19-20020a7bcc13000000b003fe24441e23sm8822260wmh.24.2023.08.20.03.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 03:28:29 -0700 (PDT)
Message-ID: <5799076a-7fbe-cba9-5c6a-73de83351a3a@gmail.com>
Date:   Sun, 20 Aug 2023 12:28:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] intel_idle: Add RaptorLake support
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "noltari@gmail.com" <noltari@gmail.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Bityutskiy, Artem" <artem.bityutskiy@intel.com>,
        "Kumar, Vinay" <vinay.kumar@intel.com>
References: <20230119070205.90047-1-noltari@gmail.com>
 <c79904e98b86b68c87add286aa1487b3f81712b6.camel@intel.com>
 <c7d1eced-d77b-aca7-1422-6eefaf704f3e@gmail.com>
 <7e2c1da24b48217045e8ad95b739ec96cdce5931.camel@intel.com>
Content-Language: en-US, fr-FR
From:   Guillaume Martres <smarter3@gmail.com>
In-Reply-To: <7e2c1da24b48217045e8ad95b739ec96cdce5931.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 20/08/2023 à 11:20, Zhang, Rui a écrit :
> On Sat, 2023-08-19 at 21:41 +0200, Guillaume Martres wrote:
>> On 1/19/23 17:13, Zhang, Rui wrote:
>>> On Thu, 2023-01-19 at 08:02 +0100, Álvaro Fernández Rojas wrote:
>>>> This patch adds RaptorLake support to the intel_idle driver.
>>>>
>>>> Since RaptorLake and AlderLake C-state are characteristics the
>>>> same,
>>>> we use
>>>> AlderLake C-states tables for RaptorLake as well.
>>>
>>> RPL and ADL have same cstates and use the same mwait hints, but the
>>> latency of each c-state are still different on different platforms.
>>> So we can not just duplicate the ADL table on RPL.
>>>
>>> There is an effort ongoing that measures the latency of each
>>> cstate on the RPL platforms. And based on the measurement result,
>>> we
>>> can decide if a new custom table is needed or we can just copy the
>>> previous platform. Hopefully we will have a patch in a couple of
>>> weeks.
>>
>> Hi, I just stumbled upon this patch series as I was wondering about
>> the
>> lack of support for Raptor Lake in intel_idle.
> 
> intel_idle support for RaptorLake, and also other platforms that don't
> have a custom table, is always there as long as we have BIOS support.
> The custom table is just an optimization.

Thanks for the information, I might be misinterpreting the effect of
this patch then. I can report that on a Thinkpad P1 Gen 6 using a stock
6.4.11 kernel, the list of C-states looks like this:

$ cat /sys/devices/system/cpu/cpu0/cpuidle/state*/name
POLL
C1_ACPI
C2_ACPI
C3_ACPI

Whereas with this patch they look like this:

$ cat /sys/devices/system/cpu/cpu0/cpuidle/state*/name
POLL
C1E
C6
C8
C10

Neither of which looks quite complete (and
/sys/module/intel_idle/parameters/max_cstate is set to 9). Is this
something I should open a bug report about?

Thanks,
Guillaume
