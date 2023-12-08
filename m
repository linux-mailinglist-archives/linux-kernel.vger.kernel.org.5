Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED12B8098EF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572975AbjLHB7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572946AbjLHB7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:59:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ED1121;
        Thu,  7 Dec 2023 17:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702000781; x=1733536781;
  h=message-id:subject:from:reply-to:to:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=difPZ6LGk8HeoJ6jkiYg2wZvZ7jn2G6QafOq0xOt/44=;
  b=RVlm1LBtC4bDevX1tfY/Bo4WQGi5H8RrDQYc7JhE9bDgMdN+VCf77TiJ
   77Rs2CL2XQ1uB8dlAcfFegraU/1GyFP5pTbk0KsA4oDz9vDbArii6N88Z
   tVJ9jFhITjDxdLqj1fLCgkcn2QEaupVS9xSUzWZyB7aOJi2N1RNccg+F6
   OzKByENRGHDJlRd+AsYJcc1Xre71zVU5Vcws+udqgJfTQDiVklQYvFJh4
   tCulowE6Bcoi+JyUp6wCtUi3HG/WKx7yxS3A9KBAl1/era56Uqj+rTypG
   KdF6aM8Usnz+sf85Ey5ARkQQR7sNiynF1BqeTJ+ycMyEpjXzekslb/T01
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1225378"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="1225378"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 17:59:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="842429946"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="842429946"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 17:59:40 -0800
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
        by linux.intel.com (Postfix) with ESMTP id 25F32580D9B;
        Thu,  7 Dec 2023 17:59:40 -0800 (PST)
Message-ID: <cfbb7bc2ea1b84035d19b222e6f77b03bfe04658.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel/pmc: Remove GBE LTR ignore
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        jahutchinson99@googlemail.com, ilpo.jarvinen@linux.intel.com,
        xi.pardee@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajvi.jingar@linux.intel.com
Date:   Thu, 07 Dec 2023 17:59:40 -0800
In-Reply-To: <3b3d2bea-c8be-4438-9c71-876ce55dce35@amd.com>
References: <20231207182311.2080972-1-david.e.box@linux.intel.com>
         <585eee5b-06ee-4b0a-a5e3-50e5c471fcff@redhat.com>
         <3b3d2bea-c8be-4438-9c71-876ce55dce35@amd.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-12-07 at 13:18 -0600, Mario Limonciello wrote:
> On 12/7/2023 13:02, Hans de Goede wrote:
> > Hi David,
> >=20
> > On 12/7/23 19:23, David E. Box wrote:
> > > Commit 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and
> > > core_configure()") moved the GBE LTR ignore workaround from core.c to=
 PCH
> > > code and added it new for Cannon Lake PCH in cnp.c. This introduced a
> > > network performance regression on a CNP PCH system [1] which has been
> > > observed on other PCH architectures during testing. Remove the probe-=
time
> > > GBE LTR ignore for all platforms. While this will prevent performance
> > > degradation, it will also limit the deepest SoC Package C state that =
can
> > > be
> > > entered at runtime while a LAN cable is attached.
> > >=20
> > > Reported-by: James Hutchinson <jahutchinson99@googlemail.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218143=C2=A0[1]
> > > Fixes: 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and
> > > core_configure()")
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > Tested-by: James Hutchinson <jahutchinson99@googlemail.com>
> >=20
> > So it seems to me that to fix 804951203aa5 the only thing
> > which needs to be done is remove the pmc_core_send_ltr_ignore()
> > call from cnp_core_init(), the other changes here are NOT
> > related to fixing the regression.
> >=20
> > So IMHO it seems better to split this into 2 patches?
> >=20
> > Also if this block the system from reaching PC10 should
> > this then not at least be done at suspend time and
> > undone at resume ?=C2=A0 I'm not seeing anything in the current
> > code which does an equivalent on suspend/resume, so it
> > seems to me like this will cause a significant increase
> > on suspended power-usage if an ethernet cable is attached ?

We don't have many systems attached to onboard LAN. I initially tested on a=
n
Alder Lake and D3 during suspend was enough to allow PC10 and s0ix without
ignoring the LTR. But with your comment I tried on a Tiger Lake and indeed =
it
could not get to PC10 during suspend with D3 only. So I'll send a V2 with t=
hose
patches. Thanks.

>=20
> In addition to system suspend on these system does GBE support runtime PM=
?

LTR is the runtime pm mechanism for our GBE. The problem is the hardware. G=
BE
wasn't provided an LTR register large enough to write a value to get to PC1=
0. As
is the maximum LTR value it can write will only get to PC8 or PC9 depending=
 on
the platform.

David

>=20
> If so, would it make sense to also have a Linux communication path from=
=20
> the GBE driver to this driver as part of the runtime PM callbacks?
>=20
> Then if the the GBE goes into runtime PM it could tell this driver to=20
> waive LTR and if exits runtime PM it could tell this driver to stop=20
> waiving LTR.
>=20
> >=20
> > Regards,
> >=20
> > Hans
> >=20
> >=20
> >=20
> > > ---
> > > =C2=A0 drivers/platform/x86/intel/pmc/adl.c=C2=A0 | 6 ------
> > > =C2=A0 drivers/platform/x86/intel/pmc/cnp.c=C2=A0 | 6 ------
> > > =C2=A0 drivers/platform/x86/intel/pmc/core.c | 2 +-
> > > =C2=A0 drivers/platform/x86/intel/pmc/core.h | 1 -
> > > =C2=A0 drivers/platform/x86/intel/pmc/mtl.c=C2=A0 | 6 ------
> > > =C2=A0 drivers/platform/x86/intel/pmc/tgl.c=C2=A0 | 5 -----
> > > =C2=A0 6 files changed, 1 insertion(+), 25 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/intel/pmc/adl.c
> > > b/drivers/platform/x86/intel/pmc/adl.c
> > > index 64c492391ede..e4a421ca64be 100644
> > > --- a/drivers/platform/x86/intel/pmc/adl.c
> > > +++ b/drivers/platform/x86/intel/pmc/adl.c
> > > @@ -321,11 +321,5 @@ int adl_core_init(struct pmc_dev *pmcdev)
> > > =C2=A0=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmc_core_get_low_powe=
r_modes(pmcdev);
> > > =C2=A0=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Due to a hardware limit=
ation, the GBE LTR blocks PC10
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * when a cable is attache=
d. Tell the PMC to ignore it.
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_dbg(&pmcdev->pdev->dev=
, "ignoring GBE LTR\n");
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmc_core_send_ltr_ignore(p=
mcdev, 3);
> > > -
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > =C2=A0 }
> > > diff --git a/drivers/platform/x86/intel/pmc/cnp.c
> > > b/drivers/platform/x86/intel/pmc/cnp.c
> > > index 59298f184d0e..416d3a0c3615 100644
> > > --- a/drivers/platform/x86/intel/pmc/cnp.c
> > > +++ b/drivers/platform/x86/intel/pmc/cnp.c
> > > @@ -216,11 +216,5 @@ int cnp_core_init(struct pmc_dev *pmcdev)
> > > =C2=A0=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmc_core_get_low_powe=
r_modes(pmcdev);
> > > =C2=A0=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Due to a hardware limit=
ation, the GBE LTR blocks PC10
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * when a cable is attache=
d. Tell the PMC to ignore it.
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_dbg(&pmcdev->pdev->dev=
, "ignoring GBE LTR\n");
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmc_core_send_ltr_ignore(p=
mcdev, 3);
> > > -
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > =C2=A0 }
> > > diff --git a/drivers/platform/x86/intel/pmc/core.c
> > > b/drivers/platform/x86/intel/pmc/core.c
> > > index 983e3a8f4910..7c6a74957d57 100644
> > > --- a/drivers/platform/x86/intel/pmc/core.c
> > > +++ b/drivers/platform/x86/intel/pmc/core.c
> > > @@ -462,7 +462,7 @@ static int pmc_core_pll_show(struct seq_file *s, =
void
> > > *unused)
> > > =C2=A0 }
> > > =C2=A0 DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
> > > =C2=A0=20
> > > -int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
> > > +static int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 valu=
e)
> > > =C2=A0 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pmc *pmc;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct pmc_reg_=
map *map;
> > > diff --git a/drivers/platform/x86/intel/pmc/core.h
> > > b/drivers/platform/x86/intel/pmc/core.h
> > > index 6d7673145f90..3bbdb41a754f 100644
> > > --- a/drivers/platform/x86/intel/pmc/core.h
> > > +++ b/drivers/platform/x86/intel/pmc/core.h
> > > @@ -493,7 +493,6 @@ extern const struct pmc_reg_map mtl_ioem_reg_map;
> > > =C2=A0=20
> > > =C2=A0 extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *=
pdev);
> > > =C2=A0 extern int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev)=
;
> > > -extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 valu=
e);
> > > =C2=A0=20
> > > =C2=A0 int pmc_core_resume_common(struct pmc_dev *pmcdev);
> > > =C2=A0 int get_primary_reg_base(struct pmc *pmc);
> > > diff --git a/drivers/platform/x86/intel/pmc/mtl.c
> > > b/drivers/platform/x86/intel/pmc/mtl.c
> > > index 38c2f946ec23..33d32a76c43a 100644
> > > --- a/drivers/platform/x86/intel/pmc/mtl.c
> > > +++ b/drivers/platform/x86/intel/pmc/mtl.c
> > > @@ -1065,11 +1065,5 @@ int mtl_core_init(struct pmc_dev *pmcdev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmc_core_get_low_powe=
r_modes(pmcdev);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtl_punit_pmt_init(pm=
cdev);
> > > =C2=A0=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Due to a hardware limit=
ation, the GBE LTR blocks PC10
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * when a cable is attache=
d. Tell the PMC to ignore it.
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_dbg(&pmcdev->pdev->dev=
, "ignoring GBE LTR\n");
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmc_core_send_ltr_ignore(p=
mcdev, 3);
> > > -
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return pmc_core_ssram=
_get_lpm_reqs(pmcdev);
> > > =C2=A0 }
> > > diff --git a/drivers/platform/x86/intel/pmc/tgl.c
> > > b/drivers/platform/x86/intel/pmc/tgl.c
> > > index d5f1d2223c5a..7e6f5739a197 100644
> > > --- a/drivers/platform/x86/intel/pmc/tgl.c
> > > +++ b/drivers/platform/x86/intel/pmc/tgl.c
> > > @@ -265,11 +265,6 @@ int tgl_core_init(struct pmc_dev *pmcdev)
> > > =C2=A0=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmc_core_get_low_powe=
r_modes(pmcdev);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmc_core_get_tgl_lpm_=
reqs(pmcdev->pdev);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Due to a hardware limit=
ation, the GBE LTR blocks PC10
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * when a cable is attache=
d. Tell the PMC to ignore it.
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_dbg(&pmcdev->pdev->dev=
, "ignoring GBE LTR\n");
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmc_core_send_ltr_ignore(p=
mcdev, 3);
> > > =C2=A0=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > =C2=A0 }
> > >=20
> > > base-commit: 35ddd61cf023b5deb2b7e9f1627abef053281c0a
> >=20
> >=20
>=20

