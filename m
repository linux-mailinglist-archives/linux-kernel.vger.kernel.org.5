Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C45E7FF037
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345593AbjK3NdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjK3NdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:33:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F80A10A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701351204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lIdax5nkZnwudivN9rSoOKpFOEYMEgv4l8J3J8z/rRE=;
        b=IhH3UnSgjHbkd/winX+Kckwc/Q19FFssG0XUaefzu0WWtJLpYNV3IKWnt3fJQcEOHriOgT
        A3ZbNQcD70Qpnfx0tWVuFUEaZCcM0H6P2JtXLEwBoKiwz11xolz1N0w7DY1GH/eUUl32Pz
        lHQ3gvv0Cfdt4yZebWud1Ahb9Onzn4Y=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609--Fw0J-5vNfWjNhcQYTpyMw-1; Thu, 30 Nov 2023 08:33:16 -0500
X-MC-Unique: -Fw0J-5vNfWjNhcQYTpyMw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5cddc35545dso15843737b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701351196; x=1701955996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIdax5nkZnwudivN9rSoOKpFOEYMEgv4l8J3J8z/rRE=;
        b=FCZVbbWHq4T2Qx68FRUZgaGivyRZ3o4CIrb3fp8/TYyMoIgBEv11yhrPu5Gxot/4Be
         D2VPB3H/F0HCuWfq8I8BV5JzQV9hyGjbJNNVf5EKdSv3YlseMVQXSFD7IOlpNFYgG8RA
         Bsz/8au4cc8D/0s+swFKtI+JtCLgn71wME62EAF6uWRsv6g05DBaMC5wP7cDw/aB4U8U
         LqdEqHouszEKRl8cGfJXfkLV5O4XPTMAeJf4vyQZyrv45wkxZ/j2PxBVmCCGQM0HbQ1o
         zf8CK8VdSfUgRmh3zRPYngpgb2XZgzhIulJO1WldefUeeqV5fvp2IARQmoUCzZDjCvaj
         W70Q==
X-Gm-Message-State: AOJu0YzsqpnelMn1l620C04E9RG1gb3EI+IaAiZZtZcyTeIxhOl2xI+S
        SKzf0+wsmTJtHNqVFrNHAfsUnnIv4fqcly/ftlTbWgQUARHfDhSBmxN19cTJBoylFaXDVn+/6eD
        rR3hJXUk0J5Y5+WZz7LVz3QyMq7RVCVjHbcUJOnv/
X-Received: by 2002:a05:690c:26c5:b0:5ce:2148:d4cf with SMTP id eb5-20020a05690c26c500b005ce2148d4cfmr20665601ywb.7.1701351196243;
        Thu, 30 Nov 2023 05:33:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyHMfB1iLmJUS19oxGI8jchledMhy59y3Chc3JAP3cbaAu3Lb3Zgy8ugriUEexPf+OP5vCDjPkByF3Ed/Hc9I=
X-Received: by 2002:a05:690c:26c5:b0:5ce:2148:d4cf with SMTP id
 eb5-20020a05690c26c500b005ce2148d4cfmr20665576ywb.7.1701351195958; Thu, 30
 Nov 2023 05:33:15 -0800 (PST)
MIME-Version: 1.0
References: <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz> <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv> <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv> <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv> <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv> <ZWiOO-KNJ82f6Gxu@tiehlicka>
In-Reply-To: <ZWiOO-KNJ82f6Gxu@tiehlicka>
From:   Pingfan Liu <piliu@redhat.com>
Date:   Thu, 30 Nov 2023 21:33:04 +0800
Message-ID: <CAF+s44QSJL5e6BVTAyyHR9Kzx7RJqZSkR=uXEypaouK_XuBbEw@mail.gmail.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 9:29=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 30-11-23 20:04:59, Baoquan He wrote:
> > On 11/30/23 at 11:16am, Michal Hocko wrote:
> > > On Thu 30-11-23 11:00:48, Baoquan He wrote:
> > > [...]
> > > > Now, we are worried if there's risk if the CMA area is retaken into=
 kdump
> > > > kernel as system RAM. E.g is it possible that 1st kernel's ongoing =
RDMA
> > > > or DMA will interfere with kdump kernel's normal memory accessing?
> > > > Because kdump kernel usually only reset and initialize the needed
> > > > device, e.g dump target. Those unneeded devices will be unshutdown =
and
> > > > let go.
> > >
> > > I do not really want to discount your concerns but I am bit confused =
why
> > > this matters so much. First of all, if there is a buggy RDMA driver
> > > which doesn't use the proper pinning API (which would migrate away fr=
om
> > > the CMA) then what is the worst case? We will get crash kernel corrup=
ted
> > > potentially and fail to take a proper kernel crash, right? Is this
> > > worrisome? Yes. Is it a real roadblock? I do not think so. The proble=
m
> > > seems theoretical to me and it is not CMA usage at fault here IMHO. I=
t
> > > is the said theoretical driver that needs fixing anyway.
> > >
> > > Now, it is really fair to mention that CMA backed crash kernel memory
> > > has some limitations
> > >     - CMA reservation can only be used by the userspace in the
> > >       primary kernel. If the size is overshot this might have
> > >       negative impact on kernel allocations
> > >     - userspace memory dumping in the crash kernel is fundamentally
> > >       incomplete.
> >
> > I am not sure if we are talking about the same thing. My concern is:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1) system corrutption happened, crash dumping is prepared, cpu and
> > interrupt controllers are shutdown;
> > 2) all pci devices are kept alive;
> > 3) kdump kernel boot up, initialization is only done on those devices
> > which drivers are added into kdump kernel's initrd;
> > 4) those on-flight DMA engine could be still working if their kernel
> > module is not loaded;
> >
> > In this case, if the DMA's destination is located in crashkernel=3D,cma
> > region, the DMA writting could continue even when kdump kernel has put
> > important kernel data into the area. Is this possible or absolutely not
> > possible with DMA, RDMA, or any other stuff which could keep accessing
> > that area?
>
> I do nuderstand your concern. But as already stated if anybody uses
> movable memory (CMA including) as a target of {R}DMA then that memory
> should be properly pinned. That would mean that the memory will be
> migrated to somewhere outside of movable (CMA) memory before the
> transfer is configured. So modulo bugs this shouldn't really happen.
> Are there {R}DMA drivers that do not pin memory correctly? Possibly. Is
> that a road bloack to not using CMA to back crash kernel memory, I do
> not think so. Those drivers should be fixed instead.
>
I think that is our concern. Is there any method to guarantee that
will not happen instead of 'should be' ?
Any static analysis during compiling time or dynamic checking method?

If this can be resolved, I think this method is promising.

Thanks,

Pingfan

> > The existing crashkernel=3D syntax can gurantee the reserved crashkerne=
l
> > area for kdump kernel is safe.
>
> I do not think this is true. If a DMA is misconfigured it can still
> target crash kernel memory even if it is not mapped AFAICS. But those
> are theoreticals. Or am I missing something?
> --
> Michal Hocko
> SUSE Labs
>

