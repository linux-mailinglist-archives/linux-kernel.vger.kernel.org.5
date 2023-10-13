Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7DD7C9146
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjJMXUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMXUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:20:30 -0400
Received: from matoro.tk (unknown [IPv6:2600:1700:4b10:9d80::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16538BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:20:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; bh=gPIeawjQuHddn41D6zeRo1qSWujy7kV/buuOoF9n4OY=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20230917; t=1697239177; v=1; x=1697671177;
 b=pxk+1LUXTBRrIGazGe0iAZ9P+i/5Xu2Pvys6EHru0vVD5Ns9hQ3E5jOiQ7hQ/Mn0GzFbwtvL
 fCPG9h1dncDv5nQuF195etaOxEIPFCpMcq1+m1payiLnHdY8Qlkoo6fpKBbArmWcxQhe2Rlu3HG
 ViZtjYsrLNBx0ZeSMRHQpmZz7O4M+IisGCscUSytz7AnLTZr1ZFGFheFggfJs7NXK4h5Rt2ofh3
 UlrBnjMEZsbJ4Ob0I8RTmtTJ2clVgGeLbgvQsJOBH3/KM7NpJZMcmsiIPXngKqdUS8mup9Wrke6
 +z7a2TY7G18BU6aJBYYE0mREmoCyfaQJuyqznRlXl2CmQDVWQuA1wMUWom3xwTjvigZT9qwewyS
 7wDeAt9rkZyFMuNln22tutBY+Pan4XFlXbXF2xUQryyk6qKg7XP+FIkhKLg/sTAd5rzRPAyJblr
 nHU9utmcG9KmoEsrog9FNxi2HRMt88f8ee6XlcMGFJUkK+WSTxTESehd8rZEmJJXx6EahwOKrox
 ZTXxL/E3hr3AxghoLFzDOwhYEfNyq9bmBU43fjbmyGdLlr6VfbvCZtOJkR/ztxeTjIPdJ9PcpmI
 /Mf5+FoayzHoh18qFPwZ0JCM6tvHXvSpm3qN0Lrtb4JQClnWQbj5T5pxWSKQ3wFehU0CQrnxHzK
 9HmvyTO5i2E=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id 0b729feb; Fri, 13 Oct
 2023 19:19:37 -0400
MIME-Version: 1.0
Date:   Fri, 13 Oct 2023 19:19:37 -0400
From:   matoro <matoro_mailinglist_kernel@matoro.tk>
To:     "Dr. Bernd Feige" <bernd.feige@uniklinik-freiburg.de>
Cc:     tom@talpey.com, smfrench@gmail.com, paul@darkrain42.org,
        linux-cifs@vger.kernel.org, bagasdotme@gmail.com,
        regressions@lists.linux.dev, pc@manguebit.com,
        ronniesahlberg@gmail.com, nspmangalore@gmail.com,
        brian.pardy@gmail.com, bharathsm@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS share
 is mounted (cifsd-cfid-laundromat in"D" state)
In-Reply-To: <85d538fec5a086acf62d5a803056586a6c00e4bd.camel@uniklinik-freiburg.de>
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me>
 <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
 <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
 <CAH2r5mtUedfLSv81Z-Yb3_=AbD_QpT3tVbU1PRzMTituaw7bgA@mail.gmail.com>
 <CAH2r5mt6YzapEKDo=hQ64yvBn7=jwMmY1c85NOABKcMPKPp3KA@mail.gmail.com>
 <CAO+kfxQtOKoKdb+LtMeFxgu8VXa73nbmTPSfscbdwjUXM7ME_A@mail.gmail.com>
 <CAH2r5msNf9WDHrBZSi5FhHDSewSNxMAuXTetMJDnoNh3CF_oMA@mail.gmail.com>
 <a895f860-11fa-e6d9-d042-a32bd08f9e9d@talpey.com>
 <CAH2r5mszCxPtdURenMVgeVDX5zc8knumH=ASXyUufPa7SxbJBw@mail.gmail.com>
 <ZRN9MtBqYnT6oX60@vaarsuvius>
 <85d538fec5a086acf62d5a803056586a6c00e4bd.camel@uniklinik-freiburg.de>
Message-ID: <83d00d50bc628a85db71adb440d8afb5@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-05 05:55, Dr. Bernd Feige wrote:
> Am Dienstag, dem 26.09.2023 um 17:54 -0700 schrieb Paul Aurich:
>> Perhaps the laundromat thread should be using msleep_interruptible()?
>> 
>> Using an interruptible sleep appears to prevent the thread from
>> contributing
>> to the load average, and has the happy side-effect of removing the
>> up-to-1s delay
>> when tearing down the tcon (since a7c01fa93ae, kthread_stop() will
>> return
>> early triggered by kthread_stop).
> 
> Sorry for chiming in so late - I'm also on gentoo (kernel 6.5.5-
> gentoo), but as a client of Windows AD.
> 
> Just want to emphasize that using uninterruptible sleep has not just
> unhappy but devastating side-effects.
> 
> I have 8 processors and 16 cifsd-cfid-laundromat processes, so
> /proc/loadavg reports a load average of 16 on a totally idle system.
> 
> This means that load-balancing software will never start additional
> tasks on this system - "make -l" but also any other load-dependent
> system. Just reducing the number of cifsd-cfid-laundromat processes
> does not fix this - even a single one makes loadavg report a wrong
> result for load balancing.
> 
> So, if cifsd-cfid-laundromat must really be uninterruptible, the only
> solution would be to change the way loadavg is computed by the kernel
> to exclude uninterruptible but sleeping processes. But must it be
> uninterruptible?
> 
> Thanks and best regards,
> Bernd

This is a huge problem here as well, as a client to Samba using SMB1 
(for Unix extensions).

For others encountering this problem, I was able to work around it with 
the following snippet:

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 2d5e9a9d5b8b..fc2caccb597a 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -576,7 +576,7 @@ cifs_cfids_laundromat_thread(void *p)
         struct list_head entry;

         while (!kthread_should_stop()) {
-               ssleep(1);
+               msleep_interruptible(1000);
                 INIT_LIST_HEAD(&entry);
                 if (kthread_should_stop())
                         return 0;
