Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CAA7C9028
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjJMWQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMWQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:16:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC0BC2;
        Fri, 13 Oct 2023 15:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697235370; x=1728771370;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MZOWfH1PAK2h89+1m5wg+GI+vWQsVXrKmtOPocFipGg=;
  b=LDRMy0RjppZqFN1h0jFKM92aaOruDa38uq5lKDw/B/K283lh0o6GB/cY
   ARU7f6NkmhTv8zzszA7bi4CSJJ2FkfJFoJxNvF9AR200KBs9Ie4yuTF1G
   prcreav1RA1eMCAmljEbVWQlSVaqU/VOVv0gsNB6YcxU4nY+Qcv/N5tkV
   9UElzt+2lS4tEDJvqYuan449YrDag8Z5W72uXit5Sbt0wcXFY4olaTs6r
   vT5tvjiL1nHcvzeLS9YEzpyoXzvnZjgKyxNBJs1rncjrLuPcdVQvrRm9g
   hvgso0P9xbRfB0a+euqDkjNwzet1DkiP+DraNojeWD5uOve3rpoXY0/B3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="471507608"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="471507608"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 15:16:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="754865755"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="754865755"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 15:16:08 -0700
Received: from jmloza-mobl.amr.corp.intel.com (unknown [10.212.236.32])
        by linux.intel.com (Postfix) with ESMTP id 89D34580BF0;
        Fri, 13 Oct 2023 15:16:08 -0700 (PDT)
Message-ID: <ec4ba6b6d05c2b6ca34009f40e84f65801a8104b.camel@linux.intel.com>
Subject: Re: [PATCH V3 03/16] platform/x86/intel/vsec: Use cleanup.h
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Date:   Fri, 13 Oct 2023 15:16:08 -0700
In-Reply-To: <4315a8db-16fe-7421-c482-5aede4d5cdd@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com>
          <20231012023840.3845703-4-david.e.box@linux.intel.com>
          <114e1cc4-f129-b6cd-a83b-7d822cde178@linux.intel.com>
         <fcd4ae3492b8bf08ec637a3405228efd2913921d.camel@linux.intel.com>
         <4315a8db-16fe-7421-c482-5aede4d5cdd@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-13 at 13:54 +0300, Ilpo J=C3=A4rvinen wrote:
> On Thu, 12 Oct 2023, David E. Box wrote:
>=20
> > On Thu, 2023-10-12 at 17:46 +0300, Ilpo J=C3=A4rvinen wrote:
> > > On Wed, 11 Oct 2023, David E. Box wrote:
> > >=20
> > > > Use cleanup.h helpers to handle cleanup of resources in
> > > > intel_vsec_add_dev() after failures.
> > > >=20
> > > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > > ---
> > > > V3 - New patch.
> > > >=20
> > > > =C2=A0drivers/platform/x86/intel/vsec.c | 17 ++++++++++-------
> > > > =C2=A01 file changed, 10 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/drivers/platform/x86/intel/vsec.c
> > > > b/drivers/platform/x86/intel/vsec.c
> > > > index 15866b7d3117..f03ab89ab7c0 100644
> > > > --- a/drivers/platform/x86/intel/vsec.c
> > > > +++ b/drivers/platform/x86/intel/vsec.c
> > > > @@ -15,6 +15,7 @@
> > > > =C2=A0
> > > > =C2=A0#include <linux/auxiliary_bus.h>
> > > > =C2=A0#include <linux/bits.h>
> > > > +#include <linux/cleanup.h>
> > > > =C2=A0#include <linux/delay.h>
> > > > =C2=A0#include <linux/kernel.h>
> > > > =C2=A0#include <linux/idr.h>
> > > > @@ -155,10 +156,10 @@ EXPORT_SYMBOL_NS_GPL(intel_vsec_add_aux,
> > > > INTEL_VSEC);
> > > > =C2=A0static int intel_vsec_add_dev(struct pci_dev *pdev, struct
> > > > intel_vsec_header *header,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct intel_vsec_platform_info *info)
> > > > =C2=A0{
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct intel_vsec_device=
 *intel_vsec_dev;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct intel_vsec_device=
 __free(kfree) *intel_vsec_dev =3D NULL;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct resource *re=
s, *tmp;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long quirk=
s =3D info->quirks;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret, i;
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!intel_vsec_sup=
ported(header->id, info->caps))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > > > @@ -178,10 +179,8 @@ static int intel_vsec_add_dev(struct pci_dev *=
pdev,
> > > > struct intel_vsec_header *he
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res =3D kcalloc(hea=
der->num_entries, sizeof(*res), GFP_KERNEL);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!res) {
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0kfree(intel_vsec_dev);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!res)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (quirks & VSEC_Q=
UIRK_TABLE_SHIFT)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0header->offset >>=3D TABLE_OFFSET_SHIFT;
> > > > @@ -208,8 +207,12 @@ static int intel_vsec_add_dev(struct pci_dev *=
pdev,
> > > > struct intel_vsec_header *he
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_vsec_dev->ida =3D &intel_vsec_ida;
> > > > =C2=A0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return intel_vsec_add_au=
x(pdev, NULL, intel_vsec_dev,
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 intel_vsec_name(header-=
>id));
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D intel_vsec_add_a=
ux(pdev, NULL, intel_vsec_dev,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 intel_vsec_name(header->id));
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0no_free_ptr(intel_vsec_d=
ev);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > >=20
> > > So if intel_vsec_add_aux() returned an error, intel_vsec_dev won't be=
=20
> > > freed because of the call call to no_free_ptr() before return. I that=
's=20
> > > not what you intended?
> >=20
> > It will have been freed if intel_vsec_add_aux() fails. It's a little me=
ssy.
> > That
> > function creates the auxdev and assigns the release function which will=
 free
> > intel_vsec_dev when the device is removed. But there are failure points=
 that
> > will also invoke the release function. Because of this, for all the fai=
lure
> > points in that function we free intel_vsec_dev so that it's state doesn=
't
> > need
> > to be questioned here. This happens explicitly if the failure is before
> > auxiliary_device_init(), or through the release function invoked by
> > auxiliary_device_uninit() if after.
>=20
> Oh, that's really convoluted and no wonder I missed it completely. It=20
> might even be that using cleanup.h here isn't really worth it. I know=20
> I pushed you into that direction but I didn't realize all the complexity
> at that point.
>=20
> If you still want to keep using cleanup.h, it would perhaps be less=20
> dangerous if you change the code such that no_free_ptr() for
> intel_vsec_dev and the resource (in 4/16, that's a similar case, isn't=
=20
> it?)

yes

>  are before the intel_vsec_add_aux() call (and I'd also add a comment=20
> to explain that freeing them is now responsability of=20
> intel_vsec_add_aux()). That way, we don't leave a trap into there where=
=20
> somebody happily adds another no_free_ptr() to the same group and it=20
> causes a mem leak.

Sure. After the comment I'd just do this then still the value is still need=
ed,

	ret =3D intel_vsec_add_aux(pdev, NULL, no_free_ptr(intel_vsec_dev),
                                 intel_vsec_name(header->id));

David

