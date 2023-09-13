Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1010979F05E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjIMRZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjIMRZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:25:28 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3BFA8;
        Wed, 13 Sep 2023 10:25:23 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-770ef0f51ccso5387885a.1;
        Wed, 13 Sep 2023 10:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694625923; x=1695230723; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94Od8mjjUYzj4mUuSdwYfL18nPkrK5m8B0pD3QkucJI=;
        b=K8vL83DSsW28u1HLD+qvTlOAOpNHGPg+Ab05oLsFbaJ0VCtOIGwn9E68uMoUSNe7Uz
         Al4Le/K55+ZK4gE8r/GSJXuGTEMOFt/PldNzwXug/fcs6UxiPII5zNL+pErb/OLQnDbi
         2Pp5WQmzyKxPgTnesgNEaLGnUHiD2FPX8+pEoSxH1RxTJbSbJBNR0mDSrgRKgRqscZh+
         6McQpzd4UsF/XCoXBsJ9LZb0+jvaMlXW2wBqMOmWOJrKulPv3xks43K9tVtbMTPEwMLX
         uv5Upm5rtTVJTgNKY+L3oa5hpHzDeZsvXIcSfBf5FeSK/DfR9FgtFof5UumvXE6NHsq4
         MbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694625923; x=1695230723;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=94Od8mjjUYzj4mUuSdwYfL18nPkrK5m8B0pD3QkucJI=;
        b=K31jaXwFKtzJvnb1FrJvn5vUwWECKze53DTtz8TUFbSfOZZxvcQnHdOtmmWLnyIgxJ
         VRGFWbuX8jQyXTHzv8qV6+X4HGNT5ME6B5v5pYLAiHll7WQQ+RjaguU5dH6LcsmH5FfS
         CcgIBXSE6qi03ERGHEJ0DmofuNApU/hYJ+SXlYm7E2X/nKM9w7hdQpeWQiH125dSFUEu
         WI4dVo5zvWtPyQwCsYxrBohkpxOZynvaVXThlWf2cunMQ5TrjXtrGfN0/8/dSw1rGhae
         L01nimbsFSHuGsfds0cQsgpzQYNkQykkkxSEf/+4MsvV/Qq7DNcWmn4EjUIfLmDO2XhE
         bP6w==
X-Gm-Message-State: AOJu0Ywh6VYJq/qX8qDD7t1ZG+KuFKG8oiBosPfsAJPnSrjfC33DMjLu
        wRFbrbqc3XIvmhwFnY++gyOV4BG/SYIyhA==
X-Google-Smtp-Source: AGHT+IFyozc5ypFGql6xM4j80Lc6C2zh7bY+YdVvilKH1iH8FKCAGmKswJOnkh2KzIuxrqjg27YL7A==
X-Received: by 2002:a05:620a:1708:b0:76f:272f:46ad with SMTP id az8-20020a05620a170800b0076f272f46admr2578200qkb.49.1694625922940;
        Wed, 13 Sep 2023 10:25:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ud6-20020a05620a6a8600b0077263636a95sm210054qkn.93.2023.09.13.10.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 10:25:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------OgAGDfKH4BPoE0YZ8jI904SA"
Message-ID: <ebf7bce8-0856-2a07-0d29-edbcd1b76942@gmail.com>
Date:   Wed, 13 Sep 2023 10:25:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3] workqueue: don't skip lockdep work dependency in
 cancel_work_sync()
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Heyi Guo <guoheyi@linux.alibaba.com>
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
 <a50218b6-fc42-7f12-155a-5e01fc8dd1a0@roeck-us.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <a50218b6-fc42-7f12-155a-5e01fc8dd1a0@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------OgAGDfKH4BPoE0YZ8jI904SA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/13/23 08:59, Guenter Roeck wrote:
> On 9/13/23 07:41, Johannes Berg wrote:
>> Hi Guenter,
>>
>>> This patch results in the attached lockdep splat when running the
>>> ast2600-evb emulation in qemu with aspeed_g5_defconfig and lock 
>>> debugging
>>> enabled. Reverting this patch fixes the problem.
>>
>> Umm ... That's only true if you think the problem is the lockdep splat,
>> rather than the actual potential deadlock?!
>>
> 
> It was hard for me to say because the workqueue lock doesn't exist
> in the first place if lockdep debugging is not enabled.
> 
>>> [    9.809960] ======================================================
>>> [    9.810053] WARNING: possible circular locking dependency detected
>>> [    9.810196] 6.6.0-rc1-00004-g6faca50f629f #1 Tainted: 
>>> G                 N
>>
>> I don't have this exact tree, but on 6.6-rc1,
>>
> 
> Meh, I just included a couple of bug fixes not yet available in 6.6-rc1.
> 
>>> [    9.810327] ------------------------------------------------------
>>> [    9.810406] ip/357 is trying to acquire lock:
>>> [    9.810501] 83af6c40 
>>> ((work_completion)(&(&dev->state_queue)->work)){+.+.}-{0:0}, at: 
>>> __flush_work+0x40/0x550
>>> [    9.811052]
>>> [    9.811052] but task is already holding lock:
>>> [    9.811133] 81639924 (rtnl_mutex){+.+.}-{3:3}, at: 
>>> rtnetlink_rcv_msg+0x124/0x514
>>> [    9.811264]
>>> [    9.811264] which lock already depends on the new lock.
>>> [    9.811264]
>>> [    9.811361]
>>> [    9.811361] the existing dependency chain (in reverse order) is:
>>> [    9.811466]
>>> [    9.811466] -> #1 (rtnl_mutex){+.+.}-{3:3}:
>>> [    9.811616]        lock_acquire+0xfc/0x368
>>> [    9.811717]        __mutex_lock+0x90/0xf00
>>> [    9.811782]        mutex_lock_nested+0x24/0x2c
>>> [    9.811845]        ftgmac100_reset+0x1c/0x1dc
>>
>>
>> This does indeed take the RTNL:
>>
>> static void ftgmac100_reset(struct ftgmac100 *priv)
>> {
>>          struct net_device *netdev = priv->netdev;
>>          int err;
>>
>>          netdev_dbg(netdev, "Resetting NIC...\n");
>>
>>          /* Lock the world */
>>          rtnl_lock();
>>
>> and is called from
>>
>>> [    9.811907]        ftgmac100_adjust_link+0xc0/0x13c
>>> [    9.811972]        phy_link_change+0x30/0x5c
>>> [    9.812035]        phy_check_link_status+0x9c/0x11c
>>> [    9.812100]        phy_state_machine+0x1c0/0x2c0
>>
>> this work (phy_state_machine is the function), which
>>
>>> [    9.812405] -> #0 
>>> ((work_completion)(&(&dev->state_queue)->work)){+.+.}-{0:0}:
>>> [    9.812531]        check_prev_add+0x128/0x15ec
>>> [    9.812594]        __lock_acquire+0x16ec/0x20cc
>>> [    9.812656]        lock_acquire+0xfc/0x368
>>> [    9.812712]        __flush_work+0x70/0x550
>>> [    9.812769]        __cancel_work_timer+0x1e4/0x264
>>> [    9.812833]        phy_stop+0x78/0x128
>>
>> is cancelled by phy_stop() in phy_stop_machine():
>>
>> void phy_stop_machine(struct phy_device *phydev)
>> {
>>          cancel_delayed_work_sync(&phydev->state_queue);
>>
>> but of course that's called by the driver under RTNL:
>>
>>> [    9.812889]        ftgmac100_stop+0x5c/0xac
>>> [    9.812949]        __dev_close_many+0xb8/0x140
>>
>> (__dev_close_many requires RTNL)
>>
>>
>> So you have a potential deadlock in this driver. Yes, workqueue items
>> and RTNL are basically incompatible. Don't do that. Now this bug was
>> _probably_ added by commit 1baf2e50e48f ("drivers/net/ftgmac100: fix
>> DHCP potential failure with systemd") which added a call to
>> ftgmac100_reset() in ftgmac100_adjust_link() which is the thing called
>> from the PHY state machine in the first place.
>>
>> Should that be reverted? I don't know ... maybe it can be fixed
>> differently.
>>
>>
>> But anyway ... as far as lockdep/workqueue stuff is concerned I'd
>> definitely call it a win rather than a bug! Yay for making lockdep
>> useful - it found a deadlock situation for you! :-) No need to blame
>> lockdep for that :P
>>
> 
> So you are saying that anything running in a workqueue must not
> acquire rtnl_lock because cancel_[delayed_]work_sync() may be called
> under rtnl_lock.
> 
> Fair point, but is that documented somewhere ? If not, how is anyone
> supposed to know ? If it is not documented, I might we well argue that
> cancel_[delayed_]work_sync() should not be called with rtnl_lock held
> because some worker might hold that lock.
> 
> FWIW, it would be nice if the lockdep code would generate some other
> message in this situation. Complaining about a deadlock involving a
> lock that doesn't exist if lock debugging isn't enabled is not really
> helpful and, yes, may result in reporters to falsely assume that this
> lock is responsible for the potential deadlock.
> 
> Reverting 1baf2e50e48f does fix the problem as well.

I would refrain from reverting without giving a fighting chance to the 
author to address it. It seems a bit strange that we do this locking 
dance while it might have been simpler to introduce a 
ftgmac100_reset_unlocked() and ftgmac100_reset() and call both at the 
intended places, something like the completely untested patch attached 
maybe?
-- 
Florian

--------------OgAGDfKH4BPoE0YZ8jI904SA
Content-Type: text/x-patch; charset=UTF-8; name="1.patch"
Content-Disposition: attachment; filename="1.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZhcmFkYXkvZnRnbWFjMTAwLmMg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mYXJhZGF5L2Z0Z21hYzEwMC5jCmluZGV4IGEwMzg3
OWEyN2IwNC4uMjUzYmY2ZDY2MjgwIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9mYXJhZGF5L2Z0Z21hYzEwMC5jCisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZhcmFk
YXkvZnRnbWFjMTAwLmMKQEAgLTEyOTksMjQgKzEyOTksMTcgQEAgc3RhdGljIGludCBmdGdt
YWMxMDBfaW5pdF9hbGwoc3RydWN0IGZ0Z21hYzEwMCAqcHJpdiwgYm9vbCBpZ25vcmVfYWxs
b2NfZXJyKQogCXJldHVybiBlcnI7CiB9CiAKLXN0YXRpYyB2b2lkIGZ0Z21hYzEwMF9yZXNl
dChzdHJ1Y3QgZnRnbWFjMTAwICpwcml2KQorc3RhdGljIHZvaWQgZnRnbWFjMTAwX3Jlc2V0
X3VubG9ja2VkKHN0cnVjdCBmdGdtYWMxMDAgKnByaXYpCiB7CiAJc3RydWN0IG5ldF9kZXZp
Y2UgKm5ldGRldiA9IHByaXYtPm5ldGRldjsKIAlpbnQgZXJyOwogCiAJbmV0ZGV2X2RiZyhu
ZXRkZXYsICJSZXNldHRpbmcgTklDLi4uXG4iKTsKIAotCS8qIExvY2sgdGhlIHdvcmxkICov
Ci0JcnRubF9sb2NrKCk7Ci0JaWYgKG5ldGRldi0+cGh5ZGV2KQotCQltdXRleF9sb2NrKCZu
ZXRkZXYtPnBoeWRldi0+bG9jayk7Ci0JaWYgKHByaXYtPm1paV9idXMpCi0JCW11dGV4X2xv
Y2soJnByaXYtPm1paV9idXMtPm1kaW9fbG9jayk7Ci0KIAogCS8qIENoZWNrIGlmIHRoZSBp
bnRlcmZhY2UgaXMgc3RpbGwgdXAgKi8KIAlpZiAoIW5ldGlmX3J1bm5pbmcobmV0ZGV2KSkK
LQkJZ290byBiYWlsOworCQlyZXR1cm47CiAKIAkvKiBTdG9wIHRoZSBuZXR3b3JrIHN0YWNr
ICovCiAJbmV0aWZfdHJhbnNfdXBkYXRlKG5ldGRldik7CkBAIC0xMzM4LDcgKzEzMzEsMTkg
QEAgc3RhdGljIHZvaWQgZnRnbWFjMTAwX3Jlc2V0KHN0cnVjdCBmdGdtYWMxMDAgKnByaXYp
CiAJZnRnbWFjMTAwX2luaXRfYWxsKHByaXYsIHRydWUpOwogCiAJbmV0ZGV2X2RiZyhuZXRk
ZXYsICJSZXNldCBkb25lICFcbiIpOwotIGJhaWw6Cit9CisKK3N0YXRpYyB2b2lkIGZ0Z21h
YzEwMF9yZXNldChzdHJ1Y3QgZnRnbWFjMTAwICpwcml2KQoreworCXN0cnVjdCBuZXRfZGV2
aWNlICpuZXRkZXYgPSBwcml2LT5uZXRkZXY7CisKKwlydG5sX2xvY2soKTsKKwkvKiBMb2Nr
IHRoZSB3b3JsZCAqLworCWlmIChuZXRkZXYtPnBoeWRldikKKwkJbXV0ZXhfbG9jaygmbmV0
ZGV2LT5waHlkZXYtPmxvY2spOworCWlmIChwcml2LT5taWlfYnVzKQorCQltdXRleF9sb2Nr
KCZwcml2LT5taWlfYnVzLT5tZGlvX2xvY2spOworCWZ0Z21hYzEwMF9yZXNldF91bmxvY2tl
ZChwcml2KTsKIAlpZiAocHJpdi0+bWlpX2J1cykKIAkJbXV0ZXhfdW5sb2NrKCZwcml2LT5t
aWlfYnVzLT5tZGlvX2xvY2spOwogCWlmIChuZXRkZXYtPnBoeWRldikKQEAgLTE0MDUsMTQg
KzE0MTAsNyBAQCBzdGF0aWMgdm9pZCBmdGdtYWMxMDBfYWRqdXN0X2xpbmsoc3RydWN0IG5l
dF9kZXZpY2UgKm5ldGRldikKIAkvKiBSZWxlYXNlIHBoeSBsb2NrIHRvIGFsbG93IGZ0Z21h
YzEwMF9yZXNldCB0byBhcXVpcmUgaXQsIGtlZXBpbmcgbG9jawogCSAqIG9yZGVyIGNvbnNp
c3RlbnQgdG8gcHJldmVudCBkZWFkIGxvY2suCiAJICovCi0JaWYgKG5ldGRldi0+cGh5ZGV2
KQotCQltdXRleF91bmxvY2soJm5ldGRldi0+cGh5ZGV2LT5sb2NrKTsKLQotCWZ0Z21hYzEw
MF9yZXNldChwcml2KTsKLQotCWlmIChuZXRkZXYtPnBoeWRldikKLQkJbXV0ZXhfbG9jaygm
bmV0ZGV2LT5waHlkZXYtPmxvY2spOwotCisJZnRnbWFjMTAwX3Jlc2V0X3VubG9ja2VkKHBy
aXYpOwogfQogCiBzdGF0aWMgaW50IGZ0Z21hYzEwMF9taWlfcHJvYmUoc3RydWN0IG5ldF9k
ZXZpY2UgKm5ldGRldikK

--------------OgAGDfKH4BPoE0YZ8jI904SA--
