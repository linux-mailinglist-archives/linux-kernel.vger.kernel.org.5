Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0467C91A3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjJNABN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjJNABL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:01:11 -0400
X-Greylist: delayed 527 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Oct 2023 17:01:09 PDT
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F206EAD;
        Fri, 13 Oct 2023 17:01:09 -0700 (PDT)
Date:   Fri, 13 Oct 2023 21:01:02 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1697241668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+A9cxjZQ4atgBjgDYZMNYaWX62CwYSOelOrpz+DrBc=;
        b=IUYRNUB2n9flw0Qrs+BVpZQGsPvws4cj8J2FQtPLoQjvoDQmuue5BR2WeOq+V6oO4TOfnS
        iTuUHO/yWmGZQkGb5686ffOqMuiMZasA5smLINyYliG2Dk0prpvZ7TNl0YZLfOq0odU4MS
        PxTQ9M7/enOmF/kDKHFrsqjmJVVFdt6TD/ETQpZb1364bkjeeZMoeEeu5cXIfe5cJ7KRM7
        gJz3W8B9JAiEmJPqrv8F7KATYBIj5wfH8WnojxPt2Wy5iCNXConqcUZXlLPU5fdU6rRcLy
        gM+ck8NUZncJ7jwC2QLSum4FDtaSXuVH/a88Ie7J9PRrVEpN/F9pVgf77OmfFw==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1697241668; a=rsa-sha256;
        cv=none;
        b=CyrTzOZgcs/RdLoYXwknk1SCFF6NjEBWvok+tDTMlid3AWtC6xsYmb3swmmBPb3QwsShsV
        4HKl064uYwip+a/JMcutplDI6MOBPu2cIGikmPwZWi2MNIYlvdhwiyDulEyij2/sfY5tIk
        EkHAx/56+Joo7vw435L9d9KNbyp47k2M6XnauLz9KE+WAkjXVjXVJFDqrX5PtJkkZiXigb
        ZO0EQXKuq1SI3lszJZ8+Oot0rX933YZ57my+wQBlez9p4mzXFPEDfZf9loTZvRQGUOXEIb
        X3x288QcOHXW8SNzusiCNRGRlZ0SQtpm0faRbko+FXR7DXTjo5rMKal2sZ4a1Q==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1697241668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+A9cxjZQ4atgBjgDYZMNYaWX62CwYSOelOrpz+DrBc=;
        b=g+jeq8MEkYE7JKlrGfn92iyVK6zlmLs9pEYvD1gAFHUxiW27SUVlYnEVt6ysNWNk0z6JDT
        IAJ30VLEqtpcYUHLQVMwF+DFqN9tjRxt0t7X83+QbsxPcTggCPWyodXhoIF4Ybti9ES/zw
        fnl7N00wVKW26bwTIn5EpKsLpP/AZ02mckKQqF+COyXLprKBQ9enuX/YeOrDOKZxiggbMX
        RveGkCzxDuQ2kyPQQDNj64VTReYfIoWF7KgEdxseFS40txF6a0/KgCQY8XRGkp0jbThYbv
        1bBM6YIcY1AMqls9q5CZmXZ6FebnRc2TZGGVq2hxr17OUdxcZ2cDf5itNnQ89w==
From:   Paulo Alcantara <pc@manguebit.com>
To:     matoro <matoro_mailinglist_kernel@matoro.tk>,
        "Dr. Bernd Feige" <bernd.feige@uniklinik-freiburg.de>
CC:     tom@talpey.com, smfrench@gmail.com, paul@darkrain42.org,
        linux-cifs@vger.kernel.org, bagasdotme@gmail.com,
        regressions@lists.linux.dev, ronniesahlberg@gmail.com,
        nspmangalore@gmail.com, brian.pardy@gmail.com,
        bharathsm@microsoft.com, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_Possible_bug_report=3A_kern?= =?US-ASCII?Q?el_6=2E5=2E0/6=2E5=2E1_high_load_when?= =?US-ASCII?Q?_CIFS_share_is_mounted_=28cifsd?= =?US-ASCII?Q?-cfid-laundromat_in=22D=22_state=29?=
In-Reply-To: <E1F307C7-9B1E-40F6-860B-6050856E8395@manguebit.com>
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com> <ZPfPfyIoVxw5L6El@debian.me> <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com> <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com> <CAH2r5mtUedfLSv81Z-Yb3_=AbD_QpT3tVbU1PRzMTituaw7bgA@mail.gmail.com> <CAH2r5mt6YzapEKDo=hQ64yvBn7=jwMmY1c85NOABKcMPKPp3KA@mail.gmail.com> <CAO+kfxQtOKoKdb+LtMeFxgu8VXa73nbmTPSfscbdwjUXM7ME_A@mail.gmail.com> <CAH2r5msNf9WDHrBZSi5FhHDSewSNxMAuXTetMJDnoNh3CF_oMA@mail.gmail.com> <a895f860-11fa-e6d9-d042-a32bd08f9e9d@talpey.com> <CAH2r5mszCxPtdURenMVgeVDX5zc8knumH=ASXyUufPa7SxbJBw@mail.gmail.com> <ZRN9MtBqYnT6oX60@vaarsuvius> <85d538fec5a086acf62d5a803056586a6c00e4bd.camel@uniklinik-freiburg.de> <83d00d50bc628a85db71adb440d8afb5@matoro.tk> <E1F307C7-9B1E-40F6-860B-6050856E8395@manguebit.com>
Message-ID: <CA6E0F87-65FD-4672-AA0C-A761E5006B7D@manguebit.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You probably want these two as well

https://git=2Esamba=2Eorg/?p=3Dsfrench/cifs-2=2E6=2Egit;a=3Dcommit;h=3D2da=
338ff752a2789470d733111a5241f30026675

https://git=2Esamba=2Eorg/?p=3Dsfrench/cifs-2=2E6=2Egit;a=3Dcommit;h=3D3b8=
bb3171571f92eda863e5f78b063604c61f72a

as directory leases isn't supported in SMB1, so no waste of system resourc=
es by having those kthreads running=2E

On 13 October 2023 20:52:11 GMT-03:00, Paulo Alcantara <pc@manguebit=2Ecom=
> wrote:
>Could you please try two commits[1][2] from for-next?
>
>[1] https://git=2Esamba=2Eorg/?p=3Dsfrench/cifs-2=2E6=2Egit;a=3Dcommit;h=
=3De95f3f74465072c2545d8e65a3c3a96e37129cf8
>[2] https://git=2Esamba=2Eorg/?p=3Dsfrench/cifs-2=2E6=2Egit;a=3Dcommit;h=
=3D81ba10959970d15c388bf29866b01b62f387e6a3
>
>On 13 October 2023 20:19:37 GMT-03:00, matoro <matoro_mailinglist_kernel@=
matoro=2Etk> wrote:
>>On 2023-10-05 05:55, Dr=2E Bernd Feige wrote:
>>> Am Dienstag, dem 26=2E09=2E2023 um 17:54 -0700 schrieb Paul Aurich:
>>>> Perhaps the laundromat thread should be using msleep_interruptible()?
>>>>=20
>>>> Using an interruptible sleep appears to prevent the thread from
>>>> contributing
>>>> to the load average, and has the happy side-effect of removing the
>>>> up-to-1s delay
>>>> when tearing down the tcon (since a7c01fa93ae, kthread_stop() will
>>>> return
>>>> early triggered by kthread_stop)=2E
>>>=20
>>> Sorry for chiming in so late - I'm also on gentoo (kernel 6=2E5=2E5-
>>> gentoo), but as a client of Windows AD=2E
>>>=20
>>> Just want to emphasize that using uninterruptible sleep has not just
>>> unhappy but devastating side-effects=2E
>>>=20
>>> I have 8 processors and 16 cifsd-cfid-laundromat processes, so
>>> /proc/loadavg reports a load average of 16 on a totally idle system=2E
>>>=20
>>> This means that load-balancing software will never start additional
>>> tasks on this system - "make -l" but also any other load-dependent
>>> system=2E Just reducing the number of cifsd-cfid-laundromat processes
>>> does not fix this - even a single one makes loadavg report a wrong
>>> result for load balancing=2E
>>>=20
>>> So, if cifsd-cfid-laundromat must really be uninterruptible, the only
>>> solution would be to change the way loadavg is computed by the kernel
>>> to exclude uninterruptible but sleeping processes=2E But must it be
>>> uninterruptible?
>>>=20
>>> Thanks and best regards,
>>> Bernd
>>
>>This is a huge problem here as well, as a client to Samba using SMB1 (fo=
r Unix extensions)=2E
>>
>>For others encountering this problem, I was able to work around it with =
the following snippet:
>>
>>diff --git a/fs/smb/client/cached_dir=2Ec b/fs/smb/client/cached_dir=2Ec
>>index 2d5e9a9d5b8b=2E=2Efc2caccb597a 100644
>>--- a/fs/smb/client/cached_dir=2Ec
>>+++ b/fs/smb/client/cached_dir=2Ec
>>@@ -576,7 +576,7 @@ cifs_cfids_laundromat_thread(void *p)
>>        struct list_head entry;
>>
>>        while (!kthread_should_stop()) {
>>-               ssleep(1);
>>+               msleep_interruptible(1000);
>>                INIT_LIST_HEAD(&entry);
>>                if (kthread_should_stop())
>>                        return 0;
