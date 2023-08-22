Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589DE784BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjHVVXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjHVVXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:23:14 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058C7187;
        Tue, 22 Aug 2023 14:23:10 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 377D81002A0;
        Tue, 22 Aug 2023 21:16:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CAC40101F89;
        Tue, 22 Aug 2023 21:16:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1692738989; a=rsa-sha256;
        cv=none;
        b=8lm7OpfOwqr4VyIH8oG9anXaQnKt2xuVT2KkRz00dxdCsZlBsyimwwVa55npzbdnPoG/ac
        lrZvWuDv8wf5BjY1rc6L6Jkv/A6T0NK53N2XwzJ6eGspO4TktA5tNsG2RCpDgv9NYRcwJ1
        mKvmmPjRWfeAWChuwAqMmUgRH7UnzLh72r9RFFO8Ot7OT8/s+knY91Xrq3Ohq6rHgWGZ/k
        x/Ov3ZXjCIrMfYogZOVHDmVvHJdUlVyW3ltBN8i+aMHtvPZkMct10RiEQui0dM4bdCIVjQ
        rDE/rr/t49mebMuu6RoC5mAepe6PopeGna1KYeQ1Ybxmde+acfgm4UI5tdHPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1692738989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=HTp3iPmIl17r1yijZ+2KZ1A0mhKpvCahgxzlnf2MJmk=;
        b=3ZdYs3ZcQ2XDK9xzk25uj9SQOwTpVtvZ/aq3+oxdvAiKna4QO2WIZHwYSZNStChq/6cN8/
        8GAZz3zymhEDb0HlmCs8mwpeUXb4wcoSd/1WDnN3nEH8t3FoptoqXqnSmRV8WJBwU4eUMY
        wbMcx6RbgyeFbpgUCLHOnHgBB2iejq/ts3HaiArdh0pML/Lth7wYzzKFcWzU2WjcZgEt5A
        eohO2iRSo+0GhyhFBp+/N07WFOElIpKH87r63w75e94c99eJLZ9G3dXK1b6GhPSWuxfrKo
        4wzk7lx6JsKE3gtfuqS8lPVfmPfNL3F4g0MxUNJukGRripPwbkjsXmGKPs6TQA==
ARC-Authentication-Results: i=1;
        rspamd-7878b5d4b5-2vh85;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Supply-Bitter: 534ca5b26f43d748_1692738990044_3850399868
X-MC-Loop-Signature: 1692738990044:3831377830
X-MC-Ingress-Time: 1692738990044
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.61.237 (trex/6.9.1);
        Tue, 22 Aug 2023 21:16:30 +0000
Received: from localhost.localdomain (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4RVhwr5Ffbz3J;
        Tue, 22 Aug 2023 14:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1692738989;
        bh=HTp3iPmIl17r1yijZ+2KZ1A0mhKpvCahgxzlnf2MJmk=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=hBizyDmo6eMbZBnjC2C3taL0p4UpPVuTNWnJQPm9AdcK1jAbZE98G4tacWh6gOxPz
         GJQzkLrK2B2c8lpWDWwI0+uZH/DYm6AL3FTJE8SfM57wGjR2QZS34rLfnUOG40Iq/C
         KssNJvK8cECLEc9XT9cBxcAGlrBhaSgkjnxFf0G5eVvI6AdyoMHG8ubYPOoBwkSLJh
         j2Njk3YrOuSMqTWaEkX61+hYrpm8JYQ2FxeXVgmVWZGW1+OWljT3LF7/27aYZY91n7
         uZiKIxmanFEGqXb+fObW119pF5D88r6tahwmze9manajJZbZ3kvPM33Kt85eugnMvd
         c/j8pCm5uZjQg==
From:   Dragan Stancevic <dragan@stancevic.com>
To:     song@kernel.org
Cc:     buczek@molgen.mpg.de, guoqing.jiang@linux.dev,
        it+raid@molgen.mpg.de, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, msmith626@gmail.com,
        yukuai1@huaweicloud.com
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle" transition
Date:   Tue, 22 Aug 2023 16:16:27 -0500
Message-Id: <20230822211627.1389410-1-dragan@stancevic.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAPhsuW6R11y6vETeZ4vmFGmV6DRrj2gwhp1-Nm+csvtHb2nQYg@mail.gmail.com>
References: <CAPhsuW6R11y6vETeZ4vmFGmV6DRrj2gwhp1-Nm+csvtHb2nQYg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3/28/23 17:01 Song Liu wrote:
> On Thu, Mar 16, 2023 at 8:25=E2=80=AFAM Marc Smith <msmith626@gmail.com> 
> wr=
> ote:
>  >
>  > On Tue, Mar 14, 2023 at 10:45=E2=80=AFAM Marc Smith 
> <msmith626@gmail.com>=
>   wrote:
>  > >
>  > > On Tue, Mar 14, 2023 at 9:55=E2=80=AFAM Guoqing Jiang 
> <guoqing.jiang@li=
> nux.dev> wrote:
>  > > >
>  > > >
>  > > >
>  > > > On 3/14/23 21:25, Marc Smith wrote:
>  > > > > On Mon, Feb 8, 2021 at 7:49=E2=80=AFPM Guoqing Jiang
>  > > > > <guoqing.jiang@cloud.ionos.com> wrote:
>  > > > >> Hi Donald,
>  > > > >>
>  > > > >> On 2/8/21 19:41, Donald Buczek wrote:
>  > > > >>> Dear Guoqing,
>  > > > >>>
>  > > > >>> On 08.02.21 15:53, Guoqing Jiang wrote:
>  > > > >>>>
>  > > > >>>> On 2/8/21 12:38, Donald Buczek wrote:
>  > > > >>>>>> 5. maybe don't hold reconfig_mutex when try to unregister
>  > > > >>>>>> sync_thread, like this.
>  > > > >>>>>>
>  > > > >>>>>>           /* resync has finished, collect result */
>  > > > >>>>>>           mddev_unlock(mddev);
>  > > > >>>>>>           md_unregister_thread(&mddev->sync_thread);
>  > > > >>>>>>           mddev_lock(mddev);
>  > > > >>>>> As above: While we wait for the sync thread to terminate, 
> would=
> n't it
>  > > > >>>>> be a problem, if another user space operation takes the mutex?
>  > > > >>>> I don't think other places can be blocked while hold mutex, 
> othe=
> rwise
>  > > > >>>> these places can cause potential deadlock. Please try above 
> two =
> lines
>  > > > >>>> change. And perhaps others have better idea.
>  > > > >>> Yes, this works. No deadlock after >11000 seconds,
>  > > > >>>
>  > > > >>> (Time till deadlock from previous runs/seconds: 1723, 37, 
> 434, 12=
> 65,
>  > > > >>> 3500, 1136, 109, 1892, 1060, 664, 84, 315, 12, 820 )
>  > > > >> Great. I will send a formal patch with your reported-by and 
> tested=
> -by.
>  > > > >>
>  > > > >> Thanks,
>  > > > >> Guoqing
>  > > > > I'm still hitting this issue with Linux 5.4.229 -- it looks 
> like 1/=
> 2
>  > > > > of the patches that supposedly resolve this were applied to the 
> sta=
> ble
>  > > > > kernels, however, one was omitted due to a regression:
>  > > > > md: don't unregister sync_thread with reconfig_mutex held 
> (upstream
>  > > > > commit 8b48ec23cc51a4e7c8dbaef5f34ebe67e1a80934)
>  > > > >
>  > > > > I don't see any follow-up on the thread from June 8th 2022 
> asking f=
> or
>  > > > > this patch to be dropped from all stable kernels since it caused a
>  > > > > regression.
>  > > > >
>  > > > > The patch doesn't appear to be present in the current mainline 
> kern=
> el
>  > > > > (6.3-rc2) either. So I assume this issue is still present 
> there, or=
>   it
>  > > > > was resolved differently and I just can't find the commit/patch.
>  > > >
>  > > > It should be fixed by commit 9dfbdafda3b3"md: unlock mddev before 
> rea=
> p
>  > > > sync_thread in action_store".
>  > >
>  > > Okay, let me try applying that patch... it does not appear to be
>  > > present in my 5.4.229 kernel source. Thanks.
>  >
>  > Yes, applying this '9dfbdafda3b3 "md: unlock mddev before reap
>  > sync_thread in action_store"' patch on top of vanilla 5.4.229 source
>  > appears to fix the problem for me -- I can't reproduce the issue with
>  > the script, and it's been running for >24 hours now. (Previously I was
>  > able to induce the issue within a matter of minutes.)
> 
> Hi Marc,
> 
> Could you please run your reproducer on the md-tmp branch?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/log/?h=3Dmd-tmp
> 
> This contains a different version of the fix by Yu Kuai.
> 
> Thanks,
> Song
> 

Hi Song, I can easily reproduce this issue on 5.10.133 and 5.10.53. The change
"9dfbdafda3b3 "md: unlock mddev before reap" does not fix the issue for me.

But I did pull the changes from the md-tmp branch you are refering:
https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/log/?h=3Dmd-tmp

I was not totally clear on which change exactly to pull, but I pulled
the following changes:
2023-03-28 md: enhance checking in md_check_recovery()md-tmp	Yu Kuai	1 -7/+15
2023-03-28 md: wake up 'resync_wait' at last in md_reap_sync_thread()	Yu Kuai	1 -1/+1
2023-03-28 md: refactor idle/frozen_sync_thread()	Yu Kuai	2 -4/+22
2023-03-28 md: add a mutex to synchronize idle and frozen in action_store()	Yu Kuai	2 -0/+8
2023-03-28 md: refactor action_store() for 'idle' and 'frozen'	Yu Kuai	1 -16/+45

I used to be able to reproduce the lockup within minutes, but with those
changes the test system has been running for more than 120 hours.

When you said a "different fix", can you confirm that I grabbed the right
changes and that I need all 5 of them.

And second question was, has this fix been submitted upstream yet?
If so which kernel version?

Thank you


