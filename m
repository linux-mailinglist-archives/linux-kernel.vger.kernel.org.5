Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ECB7D5EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 01:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344616AbjJXXZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 19:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344484AbjJXXZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 19:25:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F76A10C6;
        Tue, 24 Oct 2023 16:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698189906; x=1729725906;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=OLLJooS+8n7LDKiiInrVKA7Yk055RdtAlDwuIfffYcY=;
  b=OKNFdCzkzEQmU0y4t/seleAE6SJ6MdZUjVLKRvHcKk8Bl0PRFCIe7gjM
   tZufLxH4Uu4WLl1yM2afw5EoO7eijry7KokegBMF9n1T8ov+JerCubA63
   Pe9NgfeNh5FjXYsKa90ZukbuJe2sYXpPkN1gSgZ3mnxnKO7jHQOmF3ULx
   2s4GpDypGCplPk63rOo84aHBsgmdKoj966qptte068E2i55D8TcQmuk3H
   QNK9x3ch6OsXZzlPLTpAES+M0n4MQUZISRHYPeK9vFXS1SPQawy0v9LhE
   PGw1LiNj9Ym91UUn96JhWfxs+Zs9TBqe43uZv0GCWcnGMzar72VsqWw2m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="372254620"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="372254620"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 16:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="824470723"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="824470723"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 16:25:05 -0700
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
        by linux.intel.com (Postfix) with ESMTP id 12A10580C99;
        Tue, 24 Oct 2023 16:25:05 -0700 (PDT)
Message-ID: <3c79dce512877c593b7d09337ae659223ba0a00d.camel@linux.intel.com>
Subject: Re: [PATCH V4 04/17] platform/x86/intel/vsec: Add
 intel_vsec_register
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Date:   Tue, 24 Oct 2023 16:25:05 -0700
In-Reply-To: <991521f5-73c1-81f3-f721-15aac9c1d035@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com>
         <20231018231624.1044633-5-david.e.box@linux.intel.com>
         <991521f5-73c1-81f3-f721-15aac9c1d035@linux.intel.com>
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

On Mon, 2023-10-23 at 18:21 +0300, Ilpo J=C3=A4rvinen wrote:
> On Wed, 18 Oct 2023, David E. Box wrote:
>=20
> Use () in the shortlog after the function name.
>=20
> > From: Gayatri Kammela <gayatri.kammela@linux.intel.com>
> >=20
> > Add and export intel_vsec_register() to allow the registration of Intel
> > extended capabilities from other drivers. Add check to look for memory
> > conflicts before registering a new capability. Add a parent field to
> > intel_vsec_platform_info to allow specifying the parent device for
> > device managed cleanup.
>=20
> While reviewing this patch, I couldn't understand why the parent is never=
=20
> assigned with anything?

That's because ...

>=20
> > Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> > V4 - Move res cleanup to previous patch
> >=20
> > V3 - Replace kfree on request_mem_region fail with use of cleanup.h hel=
per.
> >=20
> > V2 - New patch splitting previous PATCH 1
> >=20
> > =C2=A0drivers/platform/x86/intel/vsec.c | 19 +++++++++++++++++--
> > =C2=A0drivers/platform/x86/intel/vsec.h |=C2=A0 4 ++++
> > =C2=A02 files changed, 21 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/vsec.c
> > b/drivers/platform/x86/intel/vsec.c
> > index 28191313d515..638dfde6a9e2 100644
> > --- a/drivers/platform/x86/intel/vsec.c
> > +++ b/drivers/platform/x86/intel/vsec.c
> > @@ -188,6 +188,12 @@ static int intel_vsec_add_dev(struct pci_dev *pdev=
,
> > struct intel_vsec_header *he
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 header->offset + i * (header->entry_size *
> > sizeof(u32));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0tmp->end =3D tmp->start + (header->entry_size * =
sizeof(u32)) -
> > 1;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0tmp->flags =3D IORESOURCE_MEM;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/* Check resource is not in use */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (!request_mem_region(tmp->start, resource_size(tmp)=
, ""))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 -EBUSY;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0release_mem_region(tmp->start, resource_size(tmp));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_vsec_dev->pcidev =
=3D pdev;
> > @@ -205,9 +211,8 @@ static int intel_vsec_add_dev(struct pci_dev *pdev,
> > struct intel_vsec_header *he
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * intel_vsec_add_aux()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0no_free_ptr(res);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D intel_vsec_add_aux(p=
dev, NULL, no_free_ptr(intel_vsec_dev),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D intel_vsec_add_aux(p=
dev, info->parent,
> > no_free_ptr(intel_vsec_dev),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 intel_vsec_name(header->id=
));

... for devices probed by this driver, intel_vsec_add_aux() will assign the
probe device as the parent if the argument is NULL. Originally this functio=
n
didn't have an argument for parent. It was added when this function was exp=
orted
for use by the tpmi driver which needed to specify its own parent. Users of
intel_vsec_register() need to do the same. I suppose for clarity this drive=
r
could set it as well and we can remove the NULL check.

David

> > -
>=20
> Extra newline change.
>=20

