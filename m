Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C6F7A6750
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjISOvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjISOvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:51:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FC5BE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695135099; x=1726671099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gLf5uphZnXLldH4M/WXbM51swZ6+kjk0g9VydaZUq5Y=;
  b=IOw+X62//xny1eUzxt/7IU1PeZTfLelsun0VGDR5/ELZDvbrlmKoFQXI
   qsUtXmbdf3QSkpdmv3K6zYp/ERrUVA23fVeDqnAfeX1yh9JXEPQi+nari
   E20vla9vIIWpgKidKrhIRRADU0s0/ZJ2GHUaNNK0nncVl+8x+MffvB+4v
   HFm5cSc+JpPTeLmIWG36gLZyomoqnJ1e9PTaWfo1SjIbGZbiRcWUhcZwm
   3NhPxe0qPqF3PAi7gPLDRGWaGPbAHel0cfJPDcS2tAek70ufBfx5wbTDG
   eNS5gdg7DYXfwZA3xWQ6rh27qybYXnUgs2jWFaxm2SzJyy88lzC78BWtv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="378853174"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="378853174"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 07:51:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="749510157"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="749510157"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2023 07:51:39 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 07:51:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 07:51:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 07:51:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5iFgD65f87x5+lykyi9lrc2JLL46qRyuw4WZXj8FVuxEZBcJ9zwSvG7xvixZ+1I+mSa7GttkpdLYAKvTDVzRKhQd8ctvD+nrpM0zxnAH2gajGrM94sW7o7NeuZJW7FIGQNWeEqAjqelkJXP6kb5GKFwLM/+X1zR4+mehO1OG0YVIuGRzRzaH7op0qHZKJVBkUk0rqLIwWEPwGCWVQP699qWRclZPSfUdhaHy+nEBwvXrsgk2eL2NTLs8wn8EIzStBtzFgcOUkOpTCLXw83bmEli5K/nPc7ao4DyR/Ytw+w1tQvvH9W2t8xduHcm6fwA8kBAVIQJwp1P2RGDtkQcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkOgVog0E3rVoqUtkWnZo5IYDR3VuQVXg/2jjV4M/JU=;
 b=UYTfaTUOWNvS1YLNh4QMzWEZL8EzWvs6ZjdlTjHEihEd9qj3UuUDzQw250L5WcFmnQyBZxMxS/uun4kElaMFm1ZI0AwyOZLTNQ4uO0gp+x5BQYci3OydoAxeA01+7HX3JZmwy/5IBdCXgoCtc4Iw7BMXsX5WB2TugunIgxdQKBdViQsjfptQRxYRrL3ltzCrT8T36xtKqfxNVGO0Vm0yRCltaIOcwj5hMTG0MoTEIa8XmEGjz1LzwJWnYOBS1lVvOY7hhgrEkXKc4v0Box8nrVtxhXP5u/VcPu82js/OfpwFkSMX4VyLXkzXrqRkroZadEkvu8uu8RKn7HYf0OUhLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 14:51:28 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 14:51:28 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Subject: RE: [Intel-xe] [PATCH v2 3/4] drm/xe/gsc: add gsc device support
Thread-Topic: [Intel-xe] [PATCH v2 3/4] drm/xe/gsc: add gsc device support
Thread-Index: AQHZ5uJbRP0g67a/70au1c8G9s9n77Agy6SAgAFwF1A=
Date:   Tue, 19 Sep 2023 14:51:27 +0000
Message-ID: <CY5PR11MB6366B55F5A0EB8EABBE999BCEDFAA@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20230914080138.4178295-1-alexander.usyskin@intel.com>
 <20230914080138.4178295-4-alexander.usyskin@intel.com>
 <ZQh5628W52y5JkZt@intel.com>
In-Reply-To: <ZQh5628W52y5JkZt@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|CY5PR11MB6307:EE_
x-ms-office365-filtering-correlation-id: a9371235-960f-4c79-b79e-08dbb91fe761
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mmmg91aKxBXYdkHECQ1I6VlQQrlOr5YXMhjZ9/5keotv+BIrugErSjgF3SCqEFLBN5NxQt7VO25hK9FO2OOGqerqdQzDF3o5yTVyD12li6nCN0M5x47fiSxvmWgpVrfrkwllE0FZheBlkeqz+PawQIJ/SaFqmg8hV3mtlTvIdkdIvdKSsxMH8eMMyHLJHcFqfatjKr6uhXpfPl4dBUlXycMSryEdIrnVByyNijrJeqYu3hsmTyHeKokY2cXlSDj9kpZDuDRqU+9oJYu8aEyHch7GgGiFpVpKgp//2jwqf5c8ABP0PoTlwkbDdegGm18Aq/1bjzLf9RQethAZ92OykJBpA3qJ2cUx/4RI4TDr81qultLU7X0vRuPD6LiTAV7WvCZH3BkL9OT8xUzrL6mu264gKb44txm+Qc2cLv1Meh2nETXBX5mu+QosQBuExPCaqLJErE8FKXhqLz7Rf2QyFkZl4CaPXx7ElPmBbGpveRVWZq2cE4kJpUH5DMbAKtY/wozUd054NHT7qD5A3opG2AiHfwbv/NDAs+IhtBq65S0XHXeUE5ULuxK+yttyn+UNzvufbwdGOgClnAJ3P3Co3xuslyso2lyvsz3vgZXpQum3LhsrUOvD6k49wlJWM54h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199024)(186009)(1800799009)(30864003)(478600001)(41300700001)(55016003)(83380400001)(5660300002)(52536014)(71200400001)(2906002)(76116006)(316002)(66946007)(64756008)(66446008)(54906003)(6636002)(66556008)(66476007)(8676002)(4326008)(6862004)(8936002)(6506007)(7696005)(53546011)(9686003)(26005)(82960400001)(122000001)(86362001)(33656002)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6/yeT5WHTvtCtbPc06NGzRmj4w6oiZBKBxw9qXIa3kveo8TbX529QrnmltT0?=
 =?us-ascii?Q?tgUBE8tWbKydTotmD0AH983CRPqttdOP61clHgBg+ZwLVPh/JJUDFJTD3a9v?=
 =?us-ascii?Q?S1CBKpJvaJOZXhAIVB5pLmoPlFzra2/vJuHCw/zaF/R1uiIjB7BB1WtOlVmn?=
 =?us-ascii?Q?ZFJpxrOtWSz998Z5BpVIS/dLoWQamPovJ7OkTSlA+C9cboeUSU1/+EUCr5qV?=
 =?us-ascii?Q?b2J3uXtev27hTACLRnm4LvX5jh95NcTBCrSFfaKtdaKNln4QCJ+i+h2X/eJM?=
 =?us-ascii?Q?/qHHaB+v+Rgl/2F6oR7dTRBdFAXNUY1sZ+fRGE/Ih1y4DxHu5aEG9fKgQb+D?=
 =?us-ascii?Q?iFXpga/XIaBKG39w9HmjXr05Hl1MdwbFfa+irnKlDhLEqRoDmrY1Ohy/CsfQ?=
 =?us-ascii?Q?aZUITBhIAL6TcvgLpeHgU8jDyTabrSEvGh8rbuAX0wvcZadbjFbz/aYpiXKc?=
 =?us-ascii?Q?up87j19p7G2PChCSQ+S9EqgPFltKmvHWD+OnxZWTg9+lkQqRcm9gaNSKcgDs?=
 =?us-ascii?Q?m+6hQmqPBFlu0zVGyqSS5104ho3tQwXlU4LjGS4+UBe9vrzdDmLpwAkp/DEO?=
 =?us-ascii?Q?qx/A71NawM/G91m3AzeOWkFoPlDNmSblf5wJt4+YggYJcMmWM506LVYmkPJU?=
 =?us-ascii?Q?lgX57pHBhVpylUZ9vdaqr/hbRfQMyKrLKk11GECIscSct8SLdLkgAYl3JDZo?=
 =?us-ascii?Q?fYQDZFbTiS3Fs74qDu+e+rKeP7q+vWIOGMbFGqFTaGJvi63SIDNLwCf2gYRv?=
 =?us-ascii?Q?lfFVg38WL9UxIKUD0kA2iCenUmWTDLPwyJDLA2Isr3VZq+nBe09GiywxRkMB?=
 =?us-ascii?Q?dUmJRixx3QQqntqbqokQHw3iSiPK5ULxuWVJAyFtgl66A7x6hQKP8EwYO8qK?=
 =?us-ascii?Q?uFePHN6gS9WeZPBBsssEHHbNWH+X5A5Mw7dlSeD6J98YUPIyYx61ytzKUMON?=
 =?us-ascii?Q?LmhKHuq54Y9lKyue2/5mINNukrK8+vgXQU6wCWRbusHaPmIR35W5DW+JgMvk?=
 =?us-ascii?Q?0UrMwlTs42QQQF/GcPOY5duyjOURVqtzv9zpaBniJvtZNHlpNCGhCBHPuERg?=
 =?us-ascii?Q?SEgvRouJJMZO/FfmRgvPQS62jPkL5rqNaKkWzQt9ewZQMQiKtUvjoq//a9H4?=
 =?us-ascii?Q?cWomRd1AitktVm9yso9Wj4llE0MBC35Z5rHdPuD+CXV0DPZBqm9EFwiod8Xw?=
 =?us-ascii?Q?RjqPjkt4eSob2rGwL0JMxiznZSBG3bo7iYVBEPYCC4Fl2///LlLiPRkdXcGr?=
 =?us-ascii?Q?qreTZjYuyLIjTYUxBblaljZQL+y+Q7dmK3EF4ILZKgk7+zt1YrmuGlgg9svG?=
 =?us-ascii?Q?/i/wcU98xZq37SGta0XYe+JMvKbV0GyISn+MQcL4ZJrt74DiqmMCuQoNisYU?=
 =?us-ascii?Q?sNfsXAu/P8Tzyrq7feiEe6OqKjWlo87uLEdVhmXFZHMWCO7efoHOS9ppyfie?=
 =?us-ascii?Q?QzIey+NlQaj3unN/p1abLt25ff6L9z87DrpqwyiQhrT5nrHSRmI/Zx5ZEwbZ?=
 =?us-ascii?Q?5cZi84RKKVYGE6rnxJ8hQFIEzwpuqzsnuvXPqSIqIVAhKOpn0BLifiFYT30F?=
 =?us-ascii?Q?qkNrYu30v7ycSSKvhePO7n6YPAzVwi6Sl055bpDesF8U4+l5ZsuTKJ3gO7X1?=
 =?us-ascii?Q?PA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9371235-960f-4c79-b79e-08dbb91fe761
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 14:51:27.9999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRx42hOqdu8gWxX9U8kem4tJsH40x8HQTnxj2A4hHK4/2Md2JHVhkl3ne2vffFwCPk6w4/uPnGH0mV1tCYHp/iNqmfQ3Zj6OFnhB0M4d+xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6307
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Vivi, Rodrigo <rodrigo.vivi@intel.com>
> Sent: Monday, September 18, 2023 19:25
> To: Usyskin, Alexander <alexander.usyskin@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; De Marchi, Lucas
> <lucas.demarchi@intel.com>; Ceraolo Spurio, Daniele
> <daniele.ceraolospurio@intel.com>; linux-kernel@vger.kernel.org; Winkler,
> Tomas <tomas.winkler@intel.com>; intel-xe@lists.freedesktop.org
> Subject: Re: [Intel-xe] [PATCH v2 3/4] drm/xe/gsc: add gsc device support
>=20
> On Thu, Sep 14, 2023 at 11:01:37AM +0300, Alexander Usyskin wrote:
> > From: Vitaly Lubart <vitaly.lubart@intel.com>
> >
> > Create mei-gscfi auxiliary device and configure interrupts
> > to be consumed by mei-gsc device driver.
> >
> > Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > ---
> >  drivers/gpu/drm/xe/Kconfig           |   1 +
> >  drivers/gpu/drm/xe/Makefile          |   1 +
> >  drivers/gpu/drm/xe/xe_device.c       |   4 +
> >  drivers/gpu/drm/xe/xe_device_types.h |   4 +
> >  drivers/gpu/drm/xe/xe_heci_gsc.c     | 205
> +++++++++++++++++++++++++++
> >  drivers/gpu/drm/xe/xe_heci_gsc.h     |  35 +++++
> >  drivers/gpu/drm/xe/xe_irq.c          |  14 +-
> >  7 files changed, 262 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/gpu/drm/xe/xe_heci_gsc.c
> >  create mode 100644 drivers/gpu/drm/xe/xe_heci_gsc.h
> >
> > diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> > index 096bd066afa8..da82084fe236 100644
> > --- a/drivers/gpu/drm/xe/Kconfig
> > +++ b/drivers/gpu/drm/xe/Kconfig
> > @@ -37,6 +37,7 @@ config DRM_XE
> >  	select DRM_SCHED
> >  	select MMU_NOTIFIER
> >  	select WANT_DEV_COREDUMP
> > +	select AUXILIARY_BUS
> >  	help
> >  	  Experimental driver for Intel Xe series GPUs
> >
> > diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
> > index 9d2311f8141f..fbdb28fa5ace 100644
> > --- a/drivers/gpu/drm/xe/Makefile
> > +++ b/drivers/gpu/drm/xe/Makefile
> > @@ -73,6 +73,7 @@ xe-y +=3D xe_bb.o \
> >  	xe_guc_log.o \
> >  	xe_guc_pc.o \
> >  	xe_guc_submit.o \
> > +	xe_heci_gsc.o \
> >  	xe_hw_engine.o \
> >  	xe_hw_engine_class_sysfs.o \
> >  	xe_hw_fence.o \
> > diff --git a/drivers/gpu/drm/xe/xe_device.c
> b/drivers/gpu/drm/xe/xe_device.c
> > index d6fc06d4c9dc..4d6e2f2b281f 100644
> > --- a/drivers/gpu/drm/xe/xe_device.c
> > +++ b/drivers/gpu/drm/xe/xe_device.c
> > @@ -323,6 +323,8 @@ int xe_device_probe(struct xe_device *xe)
> >  			goto err_irq_shutdown;
> >  	}
> >
> > +	xe_heci_gsc_init(xe);
> > +
>=20
> could we place this call earlier in the flow? maybe right after setting u=
p mmio?
> or maybe after pcode init where we confirmed the boot can proceed on
> discrete?

Right after xe_irq_install will be ok (as we need working irq to setup)?
Will try, if this works.

>=20
> >  	err =3D xe_display_init(xe);
> >  	if (err)
> >  		goto err_irq_shutdown;
> > @@ -365,6 +367,8 @@ void xe_device_remove(struct xe_device *xe)
> >
> >  	xe_display_fini(xe);
> >
> > +	xe_heci_gsc_fini(xe);
> > +
> >  	xe_irq_shutdown(xe);
> >  }
> >
> > diff --git a/drivers/gpu/drm/xe/xe_device_types.h
> b/drivers/gpu/drm/xe/xe_device_types.h
> > index 1d1fe53fc30d..80233c2f0d81 100644
> > --- a/drivers/gpu/drm/xe/xe_device_types.h
> > +++ b/drivers/gpu/drm/xe/xe_device_types.h
> > @@ -13,6 +13,7 @@
> >  #include <drm/ttm/ttm_device.h>
> >
> >  #include "xe_devcoredump_types.h"
> > +#include "xe_heci_gsc.h"
> >  #include "xe_gt_types.h"
> >  #include "xe_platform_types.h"
> >  #include "xe_step_types.h"
> > @@ -364,6 +365,9 @@ struct xe_device {
> >  	 */
> >  	struct task_struct *pm_callback_task;
> >
> > +	/** @gsc: graphics security controller */
> > +	struct xe_heci_gsc heci_gsc;
>=20
> documentation doesn't match variable name.

Will fix in V2

>=20
> > +
> >  	/* private: */
> >
> >  #if IS_ENABLED(CONFIG_DRM_XE_DISPLAY)
> > diff --git a/drivers/gpu/drm/xe/xe_heci_gsc.c
> b/drivers/gpu/drm/xe/xe_heci_gsc.c
> > new file mode 100644
> > index 000000000000..1eca1c46f257
> > --- /dev/null
> > +++ b/drivers/gpu/drm/xe/xe_heci_gsc.c
> > @@ -0,0 +1,205 @@
> > +// SPDX-License-Identifier: MIT
> > +/*
> > + * Copyright(c) 2023, Intel Corporation. All rights reserved.
> > + */
> > +
> > +#include <linux/irq.h>
> > +#include <linux/mei_aux.h>
> > +#include <linux/pci.h>
> > +#include <linux/sizes.h>
> > +
> > +#include "regs/xe_regs.h"
> > +#include "xe_device_types.h"
> > +#include "xe_drv.h"
> > +#include "xe_heci_gsc.h"
> > +#include "xe_platform_types.h"
> > +
> > +#define GSC_BAR_LENGTH  0x00000FFC
> > +
> > +static void heci_gsc_irq_mask(struct irq_data *d)
> > +{
> > +	/* generic irq handling */
> > +}
> > +
> > +static void heci_gsc_irq_unmask(struct irq_data *d)
> > +{
> > +	/* generic irq handling */
> > +}
> > +
> > +static struct irq_chip heci_gsc_irq_chip =3D {
> > +	.name =3D "gsc_irq_chip",
> > +	.irq_mask =3D heci_gsc_irq_mask,
> > +	.irq_unmask =3D heci_gsc_irq_unmask,
> > +};
> > +
> > +static int heci_gsc_irq_init(int irq)
> > +{
> > +	irq_set_chip_and_handler_name(irq, &heci_gsc_irq_chip,
> > +				      handle_simple_irq,
> "heci_gsc_irq_handler");
> > +
> > +	return irq_set_chip_data(irq, NULL);
> > +}
> > +
> > +/**
> > + * struct heci_gsc_def - graphics security controller heci interface d=
efinitions
> > + *
> > + * @name: name of the heci device
> > + * @bar: address of the mmio bar
> > + * @bar_size: size of the mmio bar
> > + * @use_polling: indication of using polling mode for the device
> > + * @slow_firmware: indication of whether the device is slow (needs lon=
ger
> timeouts)
> > + */
> > +struct heci_gsc_def {
> > +	const char *name;
> > +	unsigned long bar;
> > +	size_t bar_size;
> > +	bool use_polling;
> > +	bool slow_firmware;
>=20
> will we need the lmem_size here?
>=20
PXP is not planned now, so will not need.

> or what's the difference on the mei-gsc and mei-gscfi exactly?
>

GSC sports two HECI heads - one for PXP (we call created device mei-gsc), a=
nother for chassis (mei-gscfi)
Here only second head is supported, as PXP is not planned now.

> > +};
> > +
> > +/* gsc resources and definitions */
> > +static const struct heci_gsc_def heci_gsc_def_dg1 =3D {
> > +	.name =3D "mei-gscfi",
> > +	.bar =3D DG1_GSC_HECI2_BASE,
> > +	.bar_size =3D GSC_BAR_LENGTH,
> > +};
> > +
> > +static const struct heci_gsc_def heci_gsc_def_dg2 =3D {
> > +	.name =3D "mei-gscfi",
> > +	.bar =3D DG2_GSC_HECI2_BASE,
> > +	.bar_size =3D GSC_BAR_LENGTH,
> > +};
> > +
> > +static void heci_gsc_release_dev(struct device *dev)
> > +{
> > +	struct auxiliary_device *aux_dev =3D to_auxiliary_dev(dev);
> > +	struct mei_aux_device *adev =3D
> auxiliary_dev_to_mei_aux_dev(aux_dev);
> > +
> > +	kfree(adev);
> > +}
> > +
> > +void xe_heci_gsc_fini(struct xe_device *xe)
> > +{
> > +	struct xe_heci_gsc *heci_gsc =3D &xe->heci_gsc;
> > +
> > +	if (!HAS_HECI_GSCFI(xe))
> > +		return;
> > +
> > +	if (heci_gsc->adev) {
> > +		struct auxiliary_device *aux_dev =3D &heci_gsc->adev->aux_dev;
> > +
> > +		auxiliary_device_delete(aux_dev);
> > +		auxiliary_device_uninit(aux_dev);
> > +		heci_gsc->adev =3D NULL;
> > +	}
> > +
> > +	if (heci_gsc->irq >=3D 0)
> > +		irq_free_desc(heci_gsc->irq);
> > +	heci_gsc->irq =3D -1;
> > +}
> > +
> > +void xe_heci_gsc_init(struct xe_device *xe)
> > +{
> > +	struct xe_heci_gsc *heci_gsc =3D &xe->heci_gsc;
> > +	struct pci_dev *pdev =3D to_pci_dev(xe->drm.dev);
> > +	struct mei_aux_device *adev;
> > +	struct auxiliary_device *aux_dev;
> > +	const struct heci_gsc_def *def;
> > +	int ret;
> > +
> > +	if (!HAS_HECI_GSCFI(xe))
> > +		return;
> > +
> > +	heci_gsc->irq =3D -1;
> > +
> > +	if (xe->info.platform =3D=3D XE_DG1) {
> > +		def =3D &heci_gsc_def_dg1;
> > +	} else if (xe->info.platform =3D=3D XE_DG2) {
> > +		def =3D &heci_gsc_def_dg2;
>=20
> in general it is better to add the most recent on top of the oldest.

Ok, but this is exact copy from i915

>=20
> > +	} else {
> > +		drm_warn_once(&xe->drm, "Unknown platform\n");
> > +		return;
> > +	}
> > +
> > +	if (!def->name) {
> > +		drm_warn_once(&xe->drm, "HECI is not implemented!\n");
> > +		return;
> > +	}
> > +
> > +	/* skip irq initialization */
> > +	if (def->use_polling)
> > +		goto add_device;
>=20
> what about creating a function
> heci_gsc_irq_setup(...)
>=20
> and then
> if (!def->use_polling) {
>    ret =3D heci_gsc_irq_setup(...)
>    if (ret)
>       goto fail;
>=20
Will do, thx.

> > +
> > +	heci_gsc->irq =3D irq_alloc_desc(0);
> > +	if (heci_gsc->irq < 0) {
> > +		drm_err(&xe->drm, "gsc irq error %d\n", heci_gsc->irq);
> > +		goto fail;
> > +	}
> > +
> > +	ret =3D heci_gsc_irq_init(heci_gsc->irq);
> > +	if (ret < 0) {
> > +		drm_err(&xe->drm, "gsc irq init failed %d\n", ret);
> > +		goto fail;
> > +	}
> > +
> > +add_device:
>=20
> it looks like this add_device always deserve a dedicated function.
>=20
Sure, will create one

> > +	adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
> > +	if (!adev)
> > +		goto fail;
> > +	adev->irq =3D heci_gsc->irq;
> > +	adev->bar.parent =3D &pdev->resource[0];
> > +	adev->bar.start =3D def->bar + pdev->resource[0].start;
> > +	adev->bar.end =3D adev->bar.start + def->bar_size - 1;
> > +	adev->bar.flags =3D IORESOURCE_MEM;
> > +	adev->bar.desc =3D IORES_DESC_NONE;
> > +	adev->slow_firmware =3D def->slow_firmware;
> > +
> > +	aux_dev =3D &adev->aux_dev;
> > +	aux_dev->name =3D def->name;
> > +	aux_dev->id =3D (pci_domain_nr(pdev->bus) << 16) |
> > +		      PCI_DEVID(pdev->bus->number, pdev->devfn);
> > +	aux_dev->dev.parent =3D &pdev->dev;
> > +	aux_dev->dev.release =3D heci_gsc_release_dev;
> > +
> > +	ret =3D auxiliary_device_init(aux_dev);
> > +	if (ret < 0) {
> > +		drm_err(&xe->drm, "gsc aux init failed %d\n", ret);
> > +		kfree(adev);
> > +		goto fail;
> > +	}
> > +
> > +	heci_gsc->adev =3D adev; /* needed by the notifier */
> > +	ret =3D auxiliary_device_add(aux_dev);
> > +	if (ret < 0) {
> > +		drm_err(&xe->drm, "gsc aux add failed %d\n", ret);
> > +		heci_gsc->adev =3D NULL;
> > +
> > +		/* adev will be freed with the put_device() and .release
> sequence */
> > +		auxiliary_device_uninit(aux_dev);
> > +		goto fail;
> > +	}
> > +
> > +	return;
> > +fail:
> > +	xe_heci_gsc_fini(xe);
> > +}
> > +
> > +void xe_heci_gsc_irq_handler(struct xe_device *xe, u32 iir)
> > +{
> > +	int ret;
> > +
> > +	if ((iir & GSC_IRQ_INTF(1)) =3D=3D 0)
> > +		return;
> > +
> > +	if (!HAS_HECI_GSCFI(xe)) {
> > +		drm_warn_once(&xe->drm, "GSC irq: not supported");
> > +		return;
> > +	}
> > +
> > +	if (xe->heci_gsc.irq < 0)
> > +		return;
> > +
> > +	ret =3D generic_handle_irq(xe->heci_gsc.irq);
> > +	if (ret)
> > +		drm_err_ratelimited(&xe->drm, "error handling GSC irq:
> %d\n", ret);
> > +}
> > diff --git a/drivers/gpu/drm/xe/xe_heci_gsc.h
> b/drivers/gpu/drm/xe/xe_heci_gsc.h
> > new file mode 100644
> > index 000000000000..9db454478fae
> > --- /dev/null
> > +++ b/drivers/gpu/drm/xe/xe_heci_gsc.h
> > @@ -0,0 +1,35 @@
> > +/* SPDX-License-Identifier: MIT */
> > +/*
> > + * Copyright(c) 2023, Intel Corporation. All rights reserved.
> > + */
> > +#ifndef __XE_HECI_GSC_DEV_H__
> > +#define __XE_HECI_GSC_DEV_H__
> > +
> > +#include <linux/types.h>
> > +
> > +struct xe_device;
> > +struct mei_aux_device;
> > +
> > +/*
> > + * The HECI1 bit corresponds to bit15 and HECI2 to bit14.
> > + * The reason for this is to allow growth for more interfaces in the f=
uture.
> > + */
> > +#define GSC_IRQ_INTF(_x)  BIT(15 - (_x))
> > +
> > +/**
> > + * struct xe_heci_gsc - graphics security controller for xe, HECI inte=
rface
> > + *
> > + * @adev : pointer to mei auxiliary device structure
> > + * @irq : irq number
> > + *
> > + */
> > +struct xe_heci_gsc {
> > +	struct mei_aux_device *adev;
> > +	int irq;
> > +};
> > +
> > +void xe_heci_gsc_init(struct xe_device *xe);
> > +void xe_heci_gsc_fini(struct xe_device *xe);
> > +void xe_heci_gsc_irq_handler(struct xe_device *xe, u32 iir);
> > +
> > +#endif /* __XE_HECI_GSC_DEV_H__ */
> > diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
> > index 1dee3e832eb5..d297e9b8a3be 100644
> > --- a/drivers/gpu/drm/xe/xe_irq.c
> > +++ b/drivers/gpu/drm/xe/xe_irq.c
> > @@ -128,6 +128,7 @@ void xe_irq_enable_hwe(struct xe_gt *gt)
> >  	struct xe_device *xe =3D gt_to_xe(gt);
> >  	u32 ccs_mask, bcs_mask;
> >  	u32 irqs, dmask, smask;
> > +	u32 gsc_mask =3D GSC_IRQ_INTF(1);
> >
> >  	if (xe_device_guc_submission_enabled(xe)) {
> >  		irqs =3D GT_RENDER_USER_INTERRUPT |
> > @@ -180,6 +181,9 @@ void xe_irq_enable_hwe(struct xe_gt *gt)
> >  		if (xe_hw_engine_mask_per_class(gt,
> XE_ENGINE_CLASS_OTHER)) {
> >  			xe_mmio_write32(gt, GUNIT_GSC_INTR_ENABLE,
> irqs);
> >  			xe_mmio_write32(gt, GUNIT_GSC_INTR_MASK,
> ~irqs);
> > +		} else if (HAS_HECI_GSCFI(xe)) {
> > +			xe_mmio_write32(gt, GUNIT_GSC_INTR_ENABLE,
> gsc_mask);
> > +			xe_mmio_write32(gt, GUNIT_GSC_INTR_MASK,
> ~gsc_mask);
>=20
> is there any way we could combine this with the upper calls to the same
> register?
> I believe i915 is combining them for instance...
>=20

Ok, will do, small gain, but it will be more readable.

> >  		}
> >  	}
> >  }
> > @@ -284,6 +288,11 @@ static void gt_irq_handler(struct xe_tile *tile,
> >  			instance =3D INTR_ENGINE_INSTANCE(identity[bit]);
> >  			intr_vec =3D INTR_ENGINE_INTR(identity[bit]);
> >
> > +			if (class =3D=3D XE_ENGINE_CLASS_OTHER && instance =3D=3D
> OTHER_GSC_INSTANCE) {
> > +				xe_heci_gsc_irq_handler(xe, intr_vec);
> > +				continue;
> > +			}
> > +
> >  			engine_gt =3D pick_engine_gt(tile, class, instance);
> >
> >  			hwe =3D xe_gt_hw_engine(engine_gt, class, instance,
> false);
> > @@ -470,8 +479,9 @@ static void gt_irq_reset(struct xe_tile *tile)
> >  	if (ccs_mask & (BIT(2)|BIT(3)))
> >  		xe_mmio_write32(mmio,  CCS2_CCS3_INTR_MASK, ~0);
> >
> > -	if (tile->media_gt &&
> > -	    xe_hw_engine_mask_per_class(tile->media_gt,
> XE_ENGINE_CLASS_OTHER)) {
> > +	if ((tile->media_gt &&
> > +	     xe_hw_engine_mask_per_class(tile->media_gt,
> XE_ENGINE_CLASS_OTHER)) ||
> > +	    HAS_HECI_GSCFI(tile_to_xe(tile))) {
> >  		xe_mmio_write32(mmio, GUNIT_GSC_INTR_ENABLE, 0);
> >  		xe_mmio_write32(mmio, GUNIT_GSC_INTR_MASK, ~0);
> >  	}
> > --
> > 2.34.1
> >

--=20
Thanks,
Sasha


