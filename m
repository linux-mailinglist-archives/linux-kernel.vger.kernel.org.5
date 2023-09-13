Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314BC79F08B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjIMRp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjIMRpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:45:24 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E79719AD;
        Wed, 13 Sep 2023 10:45:21 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c3f97f2239so417685ad.0;
        Wed, 13 Sep 2023 10:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694627120; x=1695231920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnGI3RaVVtJkStAQna3VeQvJT3msOVlp9SlL9tPSjYg=;
        b=TvdXNXM8yfb0u62Hxk6MuPdeAU7qeTMfvxU7yQJEjgvB2YIfB7qKXcZTwC6qHCDUeb
         /cnoLH8QRDzrQxQJcU7Z7vRMFRQTGAQMQq6ebB21CIuXJY2IoKc+ua7YtN/b2mSs1+Kf
         1VtdpdBy9+Bc8NCiQiOM4YHamUoySuVcuobGagm/daMZz9fnRxxkFVD8vyp2DgbC3neS
         UusgcHkw+3YFPDBsn4JsF6pJXFsGgaqBwf7yYe1RrqyRimfuU460OC4KJI9HO5TBWtji
         TVZYAtsR4uU2bRIF+9bZEm9yKKbnXHbru821n7h/Ir44FwBc7FUghy10SwDZBvVnMLXv
         MINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694627120; x=1695231920;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lnGI3RaVVtJkStAQna3VeQvJT3msOVlp9SlL9tPSjYg=;
        b=Pi5SsaopZ580vOujTVBbzwrDXYGS281jX/mE+Tux9v/jYh+MHNBCXc0y0yedOKpD6S
         XDGScUxjrIHDXRScqCbL4WMe3Rl7eSkByk3d3wsBmsNRa+zLKYv+nYdE5VwPueI+UZ3T
         huSFZJaUGB8wbuuEC+M0s8iQ2CpnYN8HGEXaj2fEwKsc6gdM6ues6jz1Hd2Vev9U6+1v
         1TSoXVNMzswQKpWqc8p+X8ZFqy2yR8b6h9hcQfLdS3+3sJHpKVvtqBedPkpd7v2z1Xsz
         kObpRROOBgZ++MXXvZEUtE9XfBFrepgO5AGvewnq3BhxFmw7X9h3rhtqlbXHWqAo1tEE
         b0EQ==
X-Gm-Message-State: AOJu0YwiB1OfmwlXsgYrVVqvDe7ZaLEiGaqn07D+kqGE1MVQOU4u6Ugy
        o4XlhKNCNr0vc+OFDDVhfOc=
X-Google-Smtp-Source: AGHT+IF4BubhOG3dc43BgaHj/XarpU6yijU35I93raqwI5aUhV8Sf79ADmGUW6RLudemahri6wZm5A==
X-Received: by 2002:a17:903:26c3:b0:1c0:afdb:1e6c with SMTP id jg3-20020a17090326c300b001c0afdb1e6cmr3292629plb.8.1694627120424;
        Wed, 13 Sep 2023 10:45:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j12-20020a17090276cc00b001bc68602e54sm10727886plt.142.2023.09.13.10.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 10:45:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ab6b6caf-6e6b-e4d7-f1e9-b178115c7fc5@roeck-us.net>
Date:   Wed, 13 Sep 2023 10:45:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Heyi Guo <guoheyi@linux.alibaba.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <21b9c1ac-64b7-7f4b-1e62-bf2f021fffcd@I-love.SAKURA.ne.jp>
 <YuK78Jiy12BJG/Tp@slm.duckdns.org>
 <0ad532b2-df5f-331a-ae7f-21460fc62fe2@I-love.SAKURA.ne.jp>
 <97cbf8a9-d5e1-376f-6a49-3474871ea6b4@I-love.SAKURA.ne.jp>
 <afa1ac2c-a023-a91e-e596-60931b38247e@I-love.SAKURA.ne.jp>
 <7d034f7b-af42-4dbc-0887-60f4bdb3dcca@I-love.SAKURA.ne.jp>
 <0a85696a-b0b9-0f4a-7c00-cd89edc9304c@I-love.SAKURA.ne.jp>
 <77d47eed-6a22-7e81-59de-4d45852ca4de@I-love.SAKURA.ne.jp>
 <e0717628-e436-4091-8b2e-2f4dcb646ec8@roeck-us.net>
 <6b1c6996da5d215371e164b54e8854541dee0ded.camel@sipsolutions.net>
 <a50218b6-fc42-7f12-155a-5e01fc8dd1a0@roeck-us.net>
 <ebf7bce8-0856-2a07-0d29-edbcd1b76942@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3] workqueue: don't skip lockdep work dependency in
 cancel_work_sync()
In-Reply-To: <ebf7bce8-0856-2a07-0d29-edbcd1b76942@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/23 10:25, Florian Fainelli wrote:
> On 9/13/23 08:59, Guenter Roeck wrote:
>> On 9/13/23 07:41, Johannes Berg wrote:
>>> Hi Guenter,
>>>
>>>> This patch results in the attached lockdep splat when running the
>>>> ast2600-evb emulation in qemu with aspeed_g5_defconfig and lock debugging
>>>> enabled. Reverting this patch fixes the problem.
>>>
>>> Umm ... That's only true if you think the problem is the lockdep splat,
>>> rather than the actual potential deadlock?!
>>>
>>
>> It was hard for me to say because the workqueue lock doesn't exist
>> in the first place if lockdep debugging is not enabled.
>>
>>>> [    9.809960] ======================================================
>>>> [    9.810053] WARNING: possible circular locking dependency detected
>>>> [    9.810196] 6.6.0-rc1-00004-g6faca50f629f #1 Tainted: G                 N
>>>
>>> I don't have this exact tree, but on 6.6-rc1,
>>>
>>
>> Meh, I just included a couple of bug fixes not yet available in 6.6-rc1.
>>
>>>> [    9.810327] ------------------------------------------------------
>>>> [    9.810406] ip/357 is trying to acquire lock:
>>>> [    9.810501] 83af6c40 ((work_completion)(&(&dev->state_queue)->work)){+.+.}-{0:0}, at: __flush_work+0x40/0x550
>>>> [    9.811052]
>>>> [    9.811052] but task is already holding lock:
>>>> [    9.811133] 81639924 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x124/0x514
>>>> [    9.811264]
>>>> [    9.811264] which lock already depends on the new lock.
>>>> [    9.811264]
>>>> [    9.811361]
>>>> [    9.811361] the existing dependency chain (in reverse order) is:
>>>> [    9.811466]
>>>> [    9.811466] -> #1 (rtnl_mutex){+.+.}-{3:3}:
>>>> [    9.811616]        lock_acquire+0xfc/0x368
>>>> [    9.811717]        __mutex_lock+0x90/0xf00
>>>> [    9.811782]        mutex_lock_nested+0x24/0x2c
>>>> [    9.811845]        ftgmac100_reset+0x1c/0x1dc
>>>
>>>
>>> This does indeed take the RTNL:
>>>
>>> static void ftgmac100_reset(struct ftgmac100 *priv)
>>> {
>>>          struct net_device *netdev = priv->netdev;
>>>          int err;
>>>
>>>          netdev_dbg(netdev, "Resetting NIC...\n");
>>>
>>>          /* Lock the world */
>>>          rtnl_lock();
>>>
>>> and is called from
>>>
>>>> [    9.811907]        ftgmac100_adjust_link+0xc0/0x13c
>>>> [    9.811972]        phy_link_change+0x30/0x5c
>>>> [    9.812035]        phy_check_link_status+0x9c/0x11c
>>>> [    9.812100]        phy_state_machine+0x1c0/0x2c0
>>>
>>> this work (phy_state_machine is the function), which
>>>
>>>> [    9.812405] -> #0 ((work_completion)(&(&dev->state_queue)->work)){+.+.}-{0:0}:
>>>> [    9.812531]        check_prev_add+0x128/0x15ec
>>>> [    9.812594]        __lock_acquire+0x16ec/0x20cc
>>>> [    9.812656]        lock_acquire+0xfc/0x368
>>>> [    9.812712]        __flush_work+0x70/0x550
>>>> [    9.812769]        __cancel_work_timer+0x1e4/0x264
>>>> [    9.812833]        phy_stop+0x78/0x128
>>>
>>> is cancelled by phy_stop() in phy_stop_machine():
>>>
>>> void phy_stop_machine(struct phy_device *phydev)
>>> {
>>>          cancel_delayed_work_sync(&phydev->state_queue);
>>>
>>> but of course that's called by the driver under RTNL:
>>>
>>>> [    9.812889]        ftgmac100_stop+0x5c/0xac
>>>> [    9.812949]        __dev_close_many+0xb8/0x140
>>>
>>> (__dev_close_many requires RTNL)
>>>
>>>
>>> So you have a potential deadlock in this driver. Yes, workqueue items
>>> and RTNL are basically incompatible. Don't do that. Now this bug was
>>> _probably_ added by commit 1baf2e50e48f ("drivers/net/ftgmac100: fix
>>> DHCP potential failure with systemd") which added a call to
>>> ftgmac100_reset() in ftgmac100_adjust_link() which is the thing called
>>> from the PHY state machine in the first place.
>>>
>>> Should that be reverted? I don't know ... maybe it can be fixed
>>> differently.
>>>
>>>
>>> But anyway ... as far as lockdep/workqueue stuff is concerned I'd
>>> definitely call it a win rather than a bug! Yay for making lockdep
>>> useful - it found a deadlock situation for you! :-) No need to blame
>>> lockdep for that :P
>>>
>>
>> So you are saying that anything running in a workqueue must not
>> acquire rtnl_lock because cancel_[delayed_]work_sync() may be called
>> under rtnl_lock.
>>
>> Fair point, but is that documented somewhere ? If not, how is anyone
>> supposed to know ? If it is not documented, I might we well argue that
>> cancel_[delayed_]work_sync() should not be called with rtnl_lock held
>> because some worker might hold that lock.
>>
>> FWIW, it would be nice if the lockdep code would generate some other
>> message in this situation. Complaining about a deadlock involving a
>> lock that doesn't exist if lock debugging isn't enabled is not really
>> helpful and, yes, may result in reporters to falsely assume that this
>> lock is responsible for the potential deadlock.
>>
>> Reverting 1baf2e50e48f does fix the problem as well.
> 
> I would refrain from reverting without giving a fighting chance to the author to address it. It seems a bit strange that we do this locking dance while it might have been simpler to introduce a ftgmac100_reset_unlocked() and ftgmac100_reset() and call both at the intended places, something like the completely untested patch attached maybe?


I agree. As it turns out, there are lots of "workqueue items" in the
kernel calling rtnl_lock(), and at least some of them are canceled
with cancel_delayed_work_sync(). So there has to be some additional
qualifying factor, such as that it is safe to acquire rtnl_lock() in a
worker as long as its cancel function is not called with the lock held.

I don't know if the attached patch would work because I don't know the
impact of executing ftgmac100_reset() without holding the locks.
Also, after all, the problem isnt't the lock itself, but the fact that
cancel_delayed_work_sync() may be called on this specific worker with
rtnl_lock held.

Guenter

