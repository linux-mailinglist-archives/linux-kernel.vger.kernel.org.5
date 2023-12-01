Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D99800093
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjLAAya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLAAy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:54:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962DD10C2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701392073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YNA7ol50o+M8xPlYIHwLzfsOq0Ux1n/0WOxS3M7CEU=;
        b=PX+XK7V6DGcJc2XgJqMAVMP6UcUeV3tPTQrS3rA5vKsx/HxYtcfA/iq+wAHMWYEGigvedU
        DwD+jHGh+vBGWK/TNUR95RvykAZ6bLiZvWub0pZ8RpmAvb0ypR4b2lpIt8hkzo4IjGMzHb
        31tzh0UBKOkOOYdX9uGf6r03Yuefeo0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-WlLWEHwMNrSMEybN1EU_tw-1; Thu, 30 Nov 2023 19:54:32 -0500
X-MC-Unique: WlLWEHwMNrSMEybN1EU_tw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5d064f9e2a1so23516617b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701392072; x=1701996872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YNA7ol50o+M8xPlYIHwLzfsOq0Ux1n/0WOxS3M7CEU=;
        b=KnlFCto3NP27CbTXGf1N9QKLef43fvksNw57qKDEKy34Xn0/l8zRp/3SQziGq9V97X
         KDKSzDBf3ejPPFifdfmJ8scVfibIGoDumFEyV8lDLnOEX28DNMPqcfe8JRTjUYAtnAvK
         XSM6TXPhvcluL/6eP8ycVzuAX2Iz+GHQM2qd5yeEZkn7rL7rheRL1e30jMxVxH27iQ4C
         Vjk5gOC0tzTd+Zzq/ZHl1YoeJYwNz3SP/HrCE3ux2mTMKEXn5HbKGrFMbaqxlwYSSAcI
         cNeH2msKgf5J/+BQI09UsQL4T1+b24IN5xZUbPhNxavnXphs2ekL7vFjTvsbHvpiNfvj
         vklQ==
X-Gm-Message-State: AOJu0YyviLT7uZQylxuJsEGygZCu5qMzG2dRLINbNOrSNQOdrrXyNAng
        MBMyBkrHVSFIPw37ldb0io0fSfMCZLHVN57Jj8tBIVL1NNNQdQeHgUwckdxpbdR1hmjqdXaOvWJ
        VN12mp1wp4DzsWmxFS999uC4DAKyJHnvejT03BrR1
X-Received: by 2002:a81:af5a:0:b0:5d3:f707:1b84 with SMTP id x26-20020a81af5a000000b005d3f7071b84mr758447ywj.5.1701392071780;
        Thu, 30 Nov 2023 16:54:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0AsPt60yeCWcZErjbPH3Tr+DPo1H+7VWNVgjo2QBMmGBpKlm1EvbTieVX5cZTxsl5r79oGZERX/wEswE4hjQ=
X-Received: by 2002:a81:af5a:0:b0:5d3:f707:1b84 with SMTP id
 x26-20020a81af5a000000b005d3f7071b84mr758437ywj.5.1701392071475; Thu, 30 Nov
 2023 16:54:31 -0800 (PST)
MIME-Version: 1.0
References: <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv> <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv> <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv> <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv> <ZWiOO-KNJ82f6Gxu@tiehlicka>
 <CAF+s44QSJL5e6BVTAyyHR9Kzx7RJqZSkR=uXEypaouK_XuBbEw@mail.gmail.com> <ZWiRbLGdBMO2jFGs@tiehlicka>
In-Reply-To: <ZWiRbLGdBMO2jFGs@tiehlicka>
From:   Pingfan Liu <piliu@redhat.com>
Date:   Fri, 1 Dec 2023 08:54:20 +0800
Message-ID: <CAF+s44TQ2g6VTL4JSubvch5VkW7SSsePp-aBz+kigg563NijJg@mail.gmail.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
To:     Michal Hocko <mhocko@suse.com>
Cc:     Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>, Tao Liu <ltao@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 9:43=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 30-11-23 21:33:04, Pingfan Liu wrote:
> > On Thu, Nov 30, 2023 at 9:29=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Thu 30-11-23 20:04:59, Baoquan He wrote:
> > > > On 11/30/23 at 11:16am, Michal Hocko wrote:
> > > > > On Thu 30-11-23 11:00:48, Baoquan He wrote:
> > > > > [...]
> > > > > > Now, we are worried if there's risk if the CMA area is retaken =
into kdump
> > > > > > kernel as system RAM. E.g is it possible that 1st kernel's ongo=
ing RDMA
> > > > > > or DMA will interfere with kdump kernel's normal memory accessi=
ng?
> > > > > > Because kdump kernel usually only reset and initialize the need=
ed
> > > > > > device, e.g dump target. Those unneeded devices will be unshutd=
own and
> > > > > > let go.
> > > > >
> > > > > I do not really want to discount your concerns but I am bit confu=
sed why
> > > > > this matters so much. First of all, if there is a buggy RDMA driv=
er
> > > > > which doesn't use the proper pinning API (which would migrate awa=
y from
> > > > > the CMA) then what is the worst case? We will get crash kernel co=
rrupted
> > > > > potentially and fail to take a proper kernel crash, right? Is thi=
s
> > > > > worrisome? Yes. Is it a real roadblock? I do not think so. The pr=
oblem
> > > > > seems theoretical to me and it is not CMA usage at fault here IMH=
O. It
> > > > > is the said theoretical driver that needs fixing anyway.
> > > > >
> > > > > Now, it is really fair to mention that CMA backed crash kernel me=
mory
> > > > > has some limitations
> > > > >     - CMA reservation can only be used by the userspace in the
> > > > >       primary kernel. If the size is overshot this might have
> > > > >       negative impact on kernel allocations
> > > > >     - userspace memory dumping in the crash kernel is fundamental=
ly
> > > > >       incomplete.
> > > >
> > > > I am not sure if we are talking about the same thing. My concern is=
:
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > 1) system corrutption happened, crash dumping is prepared, cpu and
> > > > interrupt controllers are shutdown;
> > > > 2) all pci devices are kept alive;
> > > > 3) kdump kernel boot up, initialization is only done on those devic=
es
> > > > which drivers are added into kdump kernel's initrd;
> > > > 4) those on-flight DMA engine could be still working if their kerne=
l
> > > > module is not loaded;
> > > >
> > > > In this case, if the DMA's destination is located in crashkernel=3D=
,cma
> > > > region, the DMA writting could continue even when kdump kernel has =
put
> > > > important kernel data into the area. Is this possible or absolutely=
 not
> > > > possible with DMA, RDMA, or any other stuff which could keep access=
ing
> > > > that area?
> > >
> > > I do nuderstand your concern. But as already stated if anybody uses
> > > movable memory (CMA including) as a target of {R}DMA then that memory
> > > should be properly pinned. That would mean that the memory will be
> > > migrated to somewhere outside of movable (CMA) memory before the
> > > transfer is configured. So modulo bugs this shouldn't really happen.
> > > Are there {R}DMA drivers that do not pin memory correctly? Possibly. =
Is
> > > that a road bloack to not using CMA to back crash kernel memory, I do
> > > not think so. Those drivers should be fixed instead.
> > >
> > I think that is our concern. Is there any method to guarantee that
                           ^^^ Sorry, to clarify, I am only speaking for my=
self.

> > will not happen instead of 'should be' ?
> > Any static analysis during compiling time or dynamic checking method?
>
> I am not aware of any method to detect a driver is going to configure a
> RDMA.
>

If there is a pattern, scripts/coccinelle may give some help. But I am
not sure about that.

> > If this can be resolved, I think this method is promising.
>
> Are you indicating this is a mandatory prerequisite?

IMHO, that should be mandatory. Otherwise for any unexpected kdump
kernel collapses,  it can not shake off its suspicion.

Thanks,

Pingfan

