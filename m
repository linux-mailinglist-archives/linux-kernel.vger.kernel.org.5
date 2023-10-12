Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9477C738C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378664AbjJLQzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347325AbjJLQzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:55:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B700D6;
        Thu, 12 Oct 2023 09:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697129749; x=1728665749;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=hw5d0D+UDAOW8Bq43+gVg7NqNRWWJBjVVnFuLzRf47Q=;
  b=XRXdle/UmexMUwN1nk4kgYB52fk0KBGIZayIYSF1nkUGT5v7cUhuPqFE
   LYr81H/Anv+mSrW/Sg22iBc+EQxtH7nwhjw9iFRxjwakIMVLWdUsXdmTN
   mo5hx8cIyuDpP85qCqgtzfH5aNoNxxv7NlFVVFHg/8LQ0N0BYykCrvx7K
   l0vcEVd63J7imP7rwNhF398SY85f7CHBV/IDGkj1hi9TiatLjvEe8M+pQ
   xt7dRwtvyMFPjngL/bN15Z4QqWoyxnWJFuD2mEGL7ugdQDr4O3krfdtZz
   bvg3SJlIBCdbuAe8vihGXYLphyTgcEKlqpVdcjD+WbCPfpFWOwdB4zego
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="370046699"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="370046699"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 09:55:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="928067047"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="928067047"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 09:55:48 -0700
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
        by linux.intel.com (Postfix) with ESMTP id 09AF95807A3;
        Thu, 12 Oct 2023 09:55:49 -0700 (PDT)
Message-ID: <2dabf5df4de0da9d9179474a433d6817ea3607e2.camel@linux.intel.com>
Subject: Re: [PATCH V3 02/16] platform/x86/intel/vsec: remove platform_info
 from vsec device structure
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Date:   Thu, 12 Oct 2023 09:55:48 -0700
In-Reply-To: <1c56cbb-5745-5d50-fdc0-ceb9a4f1dab0@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com>
         <20231012023840.3845703-3-david.e.box@linux.intel.com>
         <1c56cbb-5745-5d50-fdc0-ceb9a4f1dab0@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-12 at 18:31 +0300, Ilpo J=C3=A4rvinen wrote:
> On Wed, 11 Oct 2023, David E. Box wrote:
>=20
> > In preparation for exporting an API to register Intel Vendor Specific
> > Extended Capabilities (VSEC) from other drivers, remove the pointer to
> > platform_info from intel_vsec_device. This prevents a potential page fa=
ult
> > when auxiliary drivers probe and attempt to dereference this pointer to
> > access the needed quirks field. Instead, just add the quirks to
> > intel_vsec_device.
> >=20
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> > V3 - No change
> >=20
> > V2 - New patch splitting previous PATCH 1
> >=20
> > =C2=A0drivers/platform/x86/intel/pmt/class.c | 2 +-
> > =C2=A0drivers/platform/x86/intel/vsec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 2 +-
> > =C2=A0drivers/platform/x86/intel/vsec.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 2 +-
> > =C2=A03 files changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/pmt/class.c
> > b/drivers/platform/x86/intel/pmt/class.c
> > index f32a233470de..2ad91d2fd954 100644
> > --- a/drivers/platform/x86/intel/pmt/class.c
> > +++ b/drivers/platform/x86/intel/pmt/class.c
> > @@ -31,7 +31,7 @@ bool intel_pmt_is_early_client_hw(struct device *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * differences from the=
 server platforms (which use the Out Of Band
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Management Services =
Module OOBMSM).
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return !!(ivdev->info->quirk=
s & VSEC_QUIRK_EARLY_HW);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return !!(ivdev->quirks & VS=
EC_QUIRK_EARLY_HW);
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_NS_GPL(intel_pmt_is_early_client_hw, INTEL_PMT);
> > =C2=A0
> > diff --git a/drivers/platform/x86/intel/vsec.c
> > b/drivers/platform/x86/intel/vsec.c
> > index 6bb233a23414..15866b7d3117 100644
> > --- a/drivers/platform/x86/intel/vsec.c
> > +++ b/drivers/platform/x86/intel/vsec.c
> > @@ -201,7 +201,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev,
> > struct intel_vsec_header *he
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_vsec_dev->pcidev =
=3D pdev;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_vsec_dev->resourc=
e =3D res;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_vsec_dev->num_res=
ources =3D header->num_entries;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_vsec_dev->info =3D inf=
o;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_vsec_dev->quirks =3D i=
nfo->quirks;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (header->id =3D=3D V=
SEC_ID_SDSI)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_vsec_dev->ida =3D &intel_vsec_sdsi_ida;
> > diff --git a/drivers/platform/x86/intel/vsec.h
> > b/drivers/platform/x86/intel/vsec.h
> > index c242c07ea69c..8b9fad170503 100644
> > --- a/drivers/platform/x86/intel/vsec.h
> > +++ b/drivers/platform/x86/intel/vsec.h
> > @@ -79,11 +79,11 @@ struct intel_vsec_device {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pci_dev *pcidev;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct resource *resour=
ce;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ida *ida;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct intel_vsec_platform_i=
nfo *info;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int num_resources;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int id; /* xa */
>=20
> What is this based on??
>=20
> Unfortunately, I couldn't review some of your later patches efficiently=
=20
> because this patch failed to apply.

platform-drivers-x86-v6.6-1 tag

I guess I need to update but I didn't expect any new changes that would
conflict.

David



