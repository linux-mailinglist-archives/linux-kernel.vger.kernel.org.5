Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ABD7DE39E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbjKAOo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbjKAOo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:44:26 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314CD130
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:44:20 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d261cb07dcso4402612a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1698849859; x=1699454659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4IpCU4VrtbgMYqrW8WEc0nwJkLuzpVsRF/yurqkluX4=;
        b=fyQh+i3Y9jEiwl4Af53E0f7K6pp559KwHk3R3VZ+fb00ej0Nd2etMdn5m+g8vLYpBT
         wgZX3EsT3PsHzzEqYyD2Pcxirm+HPhLgfzzx7t4apB8HreHEVm2rHf1/fhK76RG3B4hP
         SnHM0bOv6irzcMFz3SdudjDyA+/IRjycI1N5YDSvNIy4FTAA3h3yoEh0f3CH7yeQaRnn
         CGBlDdhWnrzIUwU2niADVZjbc2yyflFC5x+kmzAYPGAMFjBTHmFT0qJE+jXBLMP5lJkN
         dNSIeCfd19fkG2UBUnmbrVFwckHHbMjlzmyQo1iaevG1SqWzFYEWPfrJGYzctncqsPFV
         8etQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698849859; x=1699454659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4IpCU4VrtbgMYqrW8WEc0nwJkLuzpVsRF/yurqkluX4=;
        b=UDSZFV/GfoKvxJV3v8ende2M5kOC/XrmBQ1hHUv+d9TTktCnXR4tcrurT2mnb13x7U
         qL0q4OgagJz6qP/qDij4CwwbiGgU/GpUkG7LmM+3xcu8stTNHiDwV+XEF9YPhl8hIGR6
         /InVNUtLcOWGRGzlmkSMo6jfHoUM6Z3XKBsHmwXD5K072OlPD5h3ffzyAJGNqtiuKrgn
         bXsfEGwielakEszouQi+ICgf8gaDgXAmGEGnYhr71crwwGnY7O4ZiniIQjttgQmy9vg6
         OxCL6eDgihMdR06bkzY3nPnXc4cL3SJByI3pCA3JChfUDA/4OvLMeeXOT8qBtP162UWc
         +D5w==
X-Gm-Message-State: AOJu0YyxMiGLQUyvMA78G7n5CyG70F5Iq6FTNf0eQGR4gV4chOBgWxTI
        wmyY6dVtX4eiGtg+bwiNA9nz5g==
X-Google-Smtp-Source: AGHT+IE7gMSMclM/BM4b1LcagJInk+j0rz0eNKap491SZfFa1bDO1MMZRiFGjm0Zq7oQQAys/EOjDw==
X-Received: by 2002:a05:6830:2b23:b0:6b4:5ed3:8246 with SMTP id l35-20020a0568302b2300b006b45ed38246mr23604334otv.2.1698849859458;
        Wed, 01 Nov 2023 07:44:19 -0700 (PDT)
Received: from [192.168.1.4] ([136.62.51.249])
        by smtp.gmail.com with ESMTPSA id er1-20020a0568303c0100b006b74bea76c0sm219497otb.47.2023.11.01.07.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 07:44:19 -0700 (PDT)
Message-ID: <acfd4fdd-1e43-2118-1b44-a926b6f09b3b@landley.net>
Date:   Wed, 1 Nov 2023 09:48:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH] rootfs: Use tmpfs for rootfs even if root= is given
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Milton D. Miller II" <mdmii@outlook.com>,
        Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "H. Peter Anvin" <hpa@zytor.com>, Mimi Zohar <zohar@linux.ibm.com>
References: <20231031154417.621742-1-stefanb@linux.ibm.com>
 <2023103159-punctuate-amount-f09d@gregkh>
 <6dae6aa6-e6c6-89d6-f9d7-7563708f7662@landley.net>
 <e30c9f81-959f-418d-a4b1-d34d47391e09@linux.ibm.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <e30c9f81-959f-418d-a4b1-d34d47391e09@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/23 07:11, Stefan Berger wrote:
> On 11/1/23 07:35, Rob Landley wrote:
>> On 10/31/23 11:56, Greg Kroah-Hartman wrote:
>>> On Tue, Oct 31, 2023 at 11:44:17AM -0400, Stefan Berger wrote:
>>>> rootfs currently does not use tmpfs if the root= boot option is passed
>>>> even though the documentation about rootfs (added in 6e19eded3684) in
>>>> Documentation/filesystems/ramfs-rootfs-initramfs.rst states:
>>>>
>>>>    If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
>>>>    default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
>>>>    line.
>>>
>>> At this point in time, is there even any difference between ramfs and
>>> tmpfs anymore?  Why would you want to choose one over the other here?
>> 
>> I submitted a patch to fix this to the list multiple times, which got ignored as
>> always. Most recently here:
>> 
>> https://lore.kernel.org/lkml/8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net/
> 
> I just tried it with your patch and the machine I am using this with 
> (OpenBMC) uses the boot command line 'console=ttyS4,115200n8 
> root=/dev/ram rw'. When I append rootfstype=tmpfs to this boot command 
> line then it starts actually using tmpfs. So I think this would work for me.
> I can add my Tested-by tag to the patch if this helps to get it merged. 
> Ideally it would also propagate back with a Fixes tag...

Regarding the "why ramfs" question, one bug report I periodically get is people
using initramfs.cpio.gz that works on ramfs but fails to extract when they try
tmpfs, and the reason is tmpfs defaults to size=50% of memory and their archive
extracts to more than that. Since ramfs hasn't got a limit, it extracted and ran
fine (generally a dedicated init app doing its IoT thing) and so far they've
always gone back to ramfs as their fix.

I vaguely recall I had some todo item to let them supply arguments so they could
specify their own size= for initmpfs (ramfs doesn't take any so it hadn't been
wired up last time I looked), but somewhere between
https://lkml.org/lkml/2016/6/22/686 and
https://lkml.iu.edu/hypermail/linux/kernel/2302.2/05597.html still being out of
tree 7 years later I kind of lost interest...

Rob
