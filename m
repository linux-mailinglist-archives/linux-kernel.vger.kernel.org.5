Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D3379EDCF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjIMP7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjIMP7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:59:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8664EA3;
        Wed, 13 Sep 2023 08:59:07 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68fb46f38f9so3571943b3a.1;
        Wed, 13 Sep 2023 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694620747; x=1695225547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QslsEG61654TnZAJ11sxBlCfDgH5y0HxCZFKGHwqcj4=;
        b=EdkJKyW1PGKNeypC2B2GI8KXnI3ipLZbIUOIAj6SZLekOtzyhh+OzZ5iq6S911j2jy
         2rv3SK4jdP6cbLjQKkprpuMI4eL4dTw17zMo858Jk6AB2mCB9r3MNxX00ZK3ZAyAF0zG
         svY3FFyPufhAsEpFkzlFOFEmXNbsjTJUldnHw1hzNE0+HBcLWy4xJR5Mled6bGW4FVPk
         8skRooTTqewlQzxOdxn1Illq2Do1KpbDgMTfOIPp0E3Uws6Y2PbIttKwob+XZGM2A2h/
         /Gja6qXM6udsEaR2Umt7gDZAeebQCN4cSMZqfSdTEplcwmjrkwIONCtGRYXQxbu+D/0k
         I9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694620747; x=1695225547;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QslsEG61654TnZAJ11sxBlCfDgH5y0HxCZFKGHwqcj4=;
        b=OwtmnYQZQcCHwhTVXbB5TxJBW0H5QB5MNt7AeR2Z70HhPsxAyWOcoiyF4a/DQl5q05
         OKROkUopL2nkWSE6P4OyA+QU9ugSSelcLYG8PJu07T/gzLMl2kvtnoMQD0j16XMui2PX
         bJx0J5ABQ7LJCajopXEU0giCUpY7uyuhp9D5H+xm8Oc0iBdEJ8R91VN8Yf/PfYHqDZrD
         XbzshKjFCWs0gyVsXEM/GZ/4XQ+PrVbXPSesC/K8NQ6TziyIodbFdjtaplIU3ESR+pC4
         35FN4fIQt+PqIzQXF/QjdCTCnKtljzPsO2i3+HvvtUFRire5s1fk4+TKC5L/id/q2CJD
         34Vw==
X-Gm-Message-State: AOJu0YwpUZIg71pexdUt09edCDp+Pi+Km1QbfARnxbNcMQpVTrnIVvas
        xOtF+wz/vkJDJw1nehfAEXc=
X-Google-Smtp-Source: AGHT+IHfovNQ2aWsDhSw0j3kQlPWf66W5vEhEg3GYNCZaVp633zC9wHUbyL6VJ+WELrUbbyTVOaDvg==
X-Received: by 2002:a05:6a00:15c5:b0:68f:cb1d:8371 with SMTP id o5-20020a056a0015c500b0068fcb1d8371mr3461051pfu.30.1694620746768;
        Wed, 13 Sep 2023 08:59:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z14-20020aa791ce000000b00686fe7b7b48sm9238432pfa.121.2023.09.13.08.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 08:59:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a50218b6-fc42-7f12-155a-5e01fc8dd1a0@roeck-us.net>
Date:   Wed, 13 Sep 2023 08:59:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heyi Guo <guoheyi@linux.alibaba.com>, netdev@vger.kernel.org
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
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3] workqueue: don't skip lockdep work dependency in
 cancel_work_sync()
In-Reply-To: <6b1c6996da5d215371e164b54e8854541dee0ded.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/23 07:41, Johannes Berg wrote:
> Hi Guenter,
> 
>> This patch results in the attached lockdep splat when running the
>> ast2600-evb emulation in qemu with aspeed_g5_defconfig and lock debugging
>> enabled. Reverting this patch fixes the problem.
> 
> Umm ... That's only true if you think the problem is the lockdep splat,
> rather than the actual potential deadlock?!
> 

It was hard for me to say because the workqueue lock doesn't exist
in the first place if lockdep debugging is not enabled.

>> [    9.809960] ======================================================
>> [    9.810053] WARNING: possible circular locking dependency detected
>> [    9.810196] 6.6.0-rc1-00004-g6faca50f629f #1 Tainted: G                 N
> 
> I don't have this exact tree, but on 6.6-rc1,
> 

Meh, I just included a couple of bug fixes not yet available in 6.6-rc1.

>> [    9.810327] ------------------------------------------------------
>> [    9.810406] ip/357 is trying to acquire lock:
>> [    9.810501] 83af6c40 ((work_completion)(&(&dev->state_queue)->work)){+.+.}-{0:0}, at: __flush_work+0x40/0x550
>> [    9.811052]
>> [    9.811052] but task is already holding lock:
>> [    9.811133] 81639924 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x124/0x514
>> [    9.811264]
>> [    9.811264] which lock already depends on the new lock.
>> [    9.811264]
>> [    9.811361]
>> [    9.811361] the existing dependency chain (in reverse order) is:
>> [    9.811466]
>> [    9.811466] -> #1 (rtnl_mutex){+.+.}-{3:3}:
>> [    9.811616]        lock_acquire+0xfc/0x368
>> [    9.811717]        __mutex_lock+0x90/0xf00
>> [    9.811782]        mutex_lock_nested+0x24/0x2c
>> [    9.811845]        ftgmac100_reset+0x1c/0x1dc
> 
> 
> This does indeed take the RTNL:
> 
> static void ftgmac100_reset(struct ftgmac100 *priv)
> {
>          struct net_device *netdev = priv->netdev;
>          int err;
> 
>          netdev_dbg(netdev, "Resetting NIC...\n");
> 
>          /* Lock the world */
>          rtnl_lock();
> 
> and is called from
> 
>> [    9.811907]        ftgmac100_adjust_link+0xc0/0x13c
>> [    9.811972]        phy_link_change+0x30/0x5c
>> [    9.812035]        phy_check_link_status+0x9c/0x11c
>> [    9.812100]        phy_state_machine+0x1c0/0x2c0
> 
> this work (phy_state_machine is the function), which
> 
>> [    9.812405] -> #0 ((work_completion)(&(&dev->state_queue)->work)){+.+.}-{0:0}:
>> [    9.812531]        check_prev_add+0x128/0x15ec
>> [    9.812594]        __lock_acquire+0x16ec/0x20cc
>> [    9.812656]        lock_acquire+0xfc/0x368
>> [    9.812712]        __flush_work+0x70/0x550
>> [    9.812769]        __cancel_work_timer+0x1e4/0x264
>> [    9.812833]        phy_stop+0x78/0x128
> 
> is cancelled by phy_stop() in phy_stop_machine():
> 
> void phy_stop_machine(struct phy_device *phydev)
> {
>          cancel_delayed_work_sync(&phydev->state_queue);
> 
> but of course that's called by the driver under RTNL:
> 
>> [    9.812889]        ftgmac100_stop+0x5c/0xac
>> [    9.812949]        __dev_close_many+0xb8/0x140
> 
> (__dev_close_many requires RTNL)
> 
> 
> So you have a potential deadlock in this driver. Yes, workqueue items
> and RTNL are basically incompatible. Don't do that. Now this bug was
> _probably_ added by commit 1baf2e50e48f ("drivers/net/ftgmac100: fix
> DHCP potential failure with systemd") which added a call to
> ftgmac100_reset() in ftgmac100_adjust_link() which is the thing called
> from the PHY state machine in the first place.
> 
> Should that be reverted? I don't know ... maybe it can be fixed
> differently.
> 
> 
> But anyway ... as far as lockdep/workqueue stuff is concerned I'd
> definitely call it a win rather than a bug! Yay for making lockdep
> useful - it found a deadlock situation for you! :-) No need to blame
> lockdep for that :P
> 

So you are saying that anything running in a workqueue must not
acquire rtnl_lock because cancel_[delayed_]work_sync() may be called
under rtnl_lock.

Fair point, but is that documented somewhere ? If not, how is anyone
supposed to know ? If it is not documented, I might we well argue that
cancel_[delayed_]work_sync() should not be called with rtnl_lock held
because some worker might hold that lock.

FWIW, it would be nice if the lockdep code would generate some other
message in this situation. Complaining about a deadlock involving a
lock that doesn't exist if lock debugging isn't enabled is not really
helpful and, yes, may result in reporters to falsely assume that this
lock is responsible for the potential deadlock.

Reverting 1baf2e50e48f does fix the problem as well.

Thanks,
Guenter

