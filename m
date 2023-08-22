Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E185C783E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjHVKkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjHVKku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:40:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4B7D1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:40:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c93638322so888573766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1692700847; x=1693305647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EtkRY1jmYwwZKGUT6GKi2lYbs/rnolItz7yunjkfTUE=;
        b=vRqJyMPwpBjcl3tf+EYFWQTPiMQZEvD7T6FvKLjABWSOeGSosWuDdjxcvTGKHDmeAt
         Q1oYCxFJBgQBK8pxgazV1n7AlbQ1AP5g3j9REhoJoT2vD0iLM52qYXTZMFj10/vD4MVe
         HY4AQzOMvAjZR/nE8MWjpx72nHJzAxy0Oa2XBOqKRU7XjxmcYfkuHwzUxbv0k/f61RhQ
         r34ZEJnvFi0OwC2hxjTOLj8HiCVdsfe2HHB1xeOzshBeiD7wQRZED/mIGbs6rbHQAMhz
         AHVFSbytRMvaaC45Hr+PGVuLlEPLzd2/7a/9EzHagqYjb3IxPxAMsOn+sIf+pkL9C3V4
         ljBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692700847; x=1693305647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EtkRY1jmYwwZKGUT6GKi2lYbs/rnolItz7yunjkfTUE=;
        b=G1qG62YFqixI+fK/DNg3hy40J4sYrKOxgsiY6/KoPNPb7Z3gKfLjoyhQWvvj2cCF3y
         VUVqokfAAg4wtbXOGq+S6hGtUydUtp/aKwByQm/V0yRsB52WX/H1zPMiYo7MhFV/utNF
         im5YvZ4OvyrRyQxyApIevY1UOOVxrK1r5MIIZeRCytfJJBa8V6gB+jkmqS2+NcbijaNN
         PTi1396b4rqELk5t278jp6T4Unw+vWJZtVxjAwLLuN+1xLVr/UOmfpzASPniKYQT06Rt
         XxbVvTJhqPoymP3CrVacr0V/hpX+GSiHtYnJyh2wvbB5a+I2/KXa1ATL2RZ2E69/kTnr
         YkDw==
X-Gm-Message-State: AOJu0YwnIISl+J0RjeHKtVcrvQcurVb3aQqRDeg3Ew7cruComCmCNVRx
        ZxFELYf98Jk75iIBe8Ut56np6w==
X-Google-Smtp-Source: AGHT+IGejXQyuL6OmLUot7fp4FTAfapXJLUoNfcjAlSAoXH1hauFGBP5F41yvVrVMpRMtc6ydrKTug==
X-Received: by 2002:a17:907:7da3:b0:982:a022:a540 with SMTP id oz35-20020a1709077da300b00982a022a540mr10182356ejc.11.1692700847182;
        Tue, 22 Aug 2023 03:40:47 -0700 (PDT)
Received: from [192.168.1.2] (handbookness.lineup.volia.net. [93.73.104.44])
        by smtp.gmail.com with ESMTPSA id n12-20020a170906688c00b00982be08a9besm8162023ejr.172.2023.08.22.03.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 03:40:46 -0700 (PDT)
Message-ID: <c81340d8-25f3-4014-b881-5afe01b56f6b@blackwall.org>
Date:   Tue, 22 Aug 2023 13:40:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] net: bridge: Fix refcnt issues in dev_ioctl
Content-Language: en-US
To:     Ziqi Zhao <astrajoan@yahoo.com>
Cc:     arnd@arndb.de, bridge@lists.linux-foundation.org,
        davem@davemloft.net, edumazet@google.com, f.fainelli@gmail.com,
        ivan.orlov0322@gmail.com, keescook@chromium.org, kuba@kernel.org,
        hkallweit1@gmail.com, mudongliangabcd@gmail.com,
        nikolay@nvidia.com, pabeni@redhat.com, roopa@nvidia.com,
        skhan@linuxfoundation.org,
        syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
        vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000051197705fdbc7e54@google.com>
 <20230819081057.330728-1-astrajoan@yahoo.com>
 <df28eac7-ee6e-431c-acee-36a1c29a4ae0@blackwall.org>
 <20230819225048.dxxzv47fo64g24qx@Astras-Ubuntu>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230819225048.dxxzv47fo64g24qx@Astras-Ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/23 01:50, Ziqi Zhao wrote:
> On Sat, Aug 19, 2023 at 12:25:15PM +0300, Nikolay Aleksandrov wrote:
> Hi Nik,
> 
> Thank you so much for reviewing the patch and getting back to me!
> 
>> IIRC there was no bug, it was a false-positive. The reference is held a bit
>> longer but then released, so the device is deleted later.
> 
>> If you reproduced it, is the device later removed or is it really stuck?
> 
> I ran the reproducer again without the patch and it seems you are
> correct. It was trying to create a very short-lived bridge, then delete
> it immediately in the next call. The device in question "wpan4" never
> showed up when I polled with `ip link` in the VM, so I'd say it did not
> get stuck.
> 
>> How would it leak a reference, could you elaborate?
>> The reference is always taken and always released after the call.
> 
> This was where I got a bit confused too. The system had a timeout of
> 140 seconds for the unregister_netdevice check. If the bridge in
> question was created and deleted repeatedly, the warning would indeed
> not be an actual reference leak. But how could its reference show up
> after 140 seconds if the bridge's creation and deletion were all within
> a couple of milliseconds?
> 
> So I let the system run for a bit longer with the reproducer, and after
> ~200 seconds, the kernel crashed and complained that some tasks had
> been waiting for too long (more than 143 seconds) trying to get hold of
> the br_ioctl_mutex. This was also quite strange to me, since on the
> surface it definitely looked like a deadlock, but the strict locking
> order as I described previously should prevent any deadlocks from
> happening.
> 
> Anyways, I decided to test switching up the lock order, since both the
> refcnt warning and the task stall seemed closely related to the above
> mentioned locks. When I ran the reproducer again after the patch, both
> the warning and the stall issue went away. So I guess the patch is
> still relevant in preventing bugs in some extreme cases -- although the
> scenario created by the reproducer would probably never happen in real
> usages?
> 

Thank you for testing, but we really need to understand what is going on 
and why the device isn't getting deleted for so long. Currently I don't 
have the time to debug it properly (I'll be able to next week at the 
earliest). We can't apply the patch based only on tests without 
understanding the underlying issue. I'd look into what
the reproducer is doing exactly and also check the system state while 
the deadlock has happened. Also you can list the currently held locks 
(if CONFIG_LOCKDEP is enabled) via magic sysrq + d for example. See 
which process is holding them, what are their priorities and so on.
Try to build some theory of how a deadlock might happen and then go
about proving it. Does the 8021q module have the same problem? It uses
similar code to set its hook.

> Please let me know whether you have any thoughts on how the above
> issues were triggered, and what other information I could gather to
> further demystify this bug. Thank you again for your help!
> 
> Best regards,
> Ziqi

