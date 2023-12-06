Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5B8806982
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376904AbjLFITM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 03:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377292AbjLFITA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:19:00 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A9ED5A;
        Wed,  6 Dec 2023 00:18:09 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SlVYM2HN3z1Q6DC;
        Wed,  6 Dec 2023 16:14:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 16:18:01 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Wed, 6 Dec 2023 08:17:59 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>
CC:     "ankita@nvidia.com" <ankita@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        yuzenghui <yuzenghui@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "gshan@redhat.com" <gshan@redhat.com>,
        "aniketa@nvidia.com" <aniketa@nvidia.com>,
        "cjia@nvidia.com" <cjia@nvidia.com>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "targupta@nvidia.com" <targupta@nvidia.com>,
        "vsethi@nvidia.com" <vsethi@nvidia.com>,
        "acurrid@nvidia.com" <acurrid@nvidia.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "danw@nvidia.com" <danw@nvidia.com>,
        "mochs@nvidia.com" <mochs@nvidia.com>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linyufeng (A)" <linyufeng3@huawei.com>
Subject: RE: [PATCH v2 1/1] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Thread-Topic: [PATCH v2 1/1] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Thread-Index: AQHaJyt5vUQXGRK0CEWl1So2KZfV67CaaoMAgAAm7ICAACpz4IABLXlA
Date:   Wed, 6 Dec 2023 08:17:59 +0000
Message-ID: <a3b71568a13949be938a4d104c0d7c42@huawei.com>
References: <20231205033015.10044-1-ankita@nvidia.com>
 <86fs0hatt3.wl-maz@kernel.org> <ZW8MP2tDt4_9ROBz@arm.com>
 <296657c5b09f46a1ac6e4d993fbc0875@huawei.com>
In-Reply-To: <296657c5b09f46a1ac6e4d993fbc0875@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.28]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shameerali Kolothum Thodi
> Sent: Tuesday, December 5, 2023 2:17 PM
> To: 'Catalin Marinas' <catalin.marinas@arm.com>; Marc Zyngier
> <maz@kernel.org>
> Cc: ankita@nvidia.com; jgg@nvidia.com; oliver.upton@linux.dev;
> suzuki.poulose@arm.com; yuzenghui <yuzenghui@huawei.com>;
> will@kernel.org; ardb@kernel.org; akpm@linux-foundation.org;
> gshan@redhat.com; aniketa@nvidia.com; cjia@nvidia.com;
> kwankhede@nvidia.com; targupta@nvidia.com; vsethi@nvidia.com;
> acurrid@nvidia.com; apopple@nvidia.com; jhubbard@nvidia.com;
> danw@nvidia.com; mochs@nvidia.com; kvmarm@lists.linux.dev;
> kvm@vger.kernel.org; lpieralisi@kernel.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linyufeng (A)
> <linyufeng3@huawei.com>
> Subject: RE: [PATCH v2 1/1] KVM: arm64: allow the VM to select DEVICE_*
> and NORMAL_NC for IO memory
> 
> 
> 
> > -----Original Message-----
> > From: Catalin Marinas <catalin.marinas@arm.com>
> > Sent: Tuesday, December 5, 2023 11:41 AM
> > To: Marc Zyngier <maz@kernel.org>
> > Cc: ankita@nvidia.com; Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>; jgg@nvidia.com;
> > oliver.upton@linux.dev; suzuki.poulose@arm.com; yuzenghui
> > <yuzenghui@huawei.com>; will@kernel.org; ardb@kernel.org;
> akpm@linux-
> > foundation.org; gshan@redhat.com; aniketa@nvidia.com;
> cjia@nvidia.com;
> > kwankhede@nvidia.com; targupta@nvidia.com; vsethi@nvidia.com;
> > acurrid@nvidia.com; apopple@nvidia.com; jhubbard@nvidia.com;
> > danw@nvidia.com; mochs@nvidia.com; kvmarm@lists.linux.dev;
> > kvm@vger.kernel.org; lpieralisi@kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v2 1/1] KVM: arm64: allow the VM to select DEVICE_*
> > and NORMAL_NC for IO memory
> >
> > + Lorenzo, he really needs to be on this thread.
> >
> > On Tue, Dec 05, 2023 at 09:21:28AM +0000, Marc Zyngier wrote:
> > > On Tue, 05 Dec 2023 03:30:15 +0000,
> > > <ankita@nvidia.com> wrote:
> > > > From: Ankit Agrawal <ankita@nvidia.com>
> > > >
> > > > Currently, KVM for ARM64 maps at stage 2 memory that is considered
> > device
> > > > (i.e. it is not RAM) with DEVICE_nGnRE memory attributes; this setting
> > > > overrides (as per the ARM architecture [1]) any device MMIO mapping
> > > > present at stage 1, resulting in a set-up whereby a guest operating
> > > > system cannot determine device MMIO mapping memory attributes on
> > its
> > > > own but it is always overridden by the KVM stage 2 default.
> > [...]
> > > Despite the considerable increase in the commit message length, a
> > > number of questions are left unanswered:
> > >
> > > - Shameer reported a regression on non-FWB systems, breaking device
> > >   assignment:
> > >
> > >
> >
> https://lore.kernel.org/all/af13ed63dc9a4f26a6c958ebfa77d78a@huawei.co
> > m/
> >
> > This referred to the first patch in the old series which was trying to
> > make the Stage 2 cacheable based on the vma attributes. That patch has
> > been dropped for now. It would be good if Shameer confirms this was the
> > problem.
> >
> 
> Yes, that was related to the first patch. We will soon test this on both FWB
> and
> non-FWB platforms and report back.
> 

Thanks to Yufeng, the test on both FWB and non-FWB platforms with a  GPU dev
assignment looks fine with this patch.

Shameer


