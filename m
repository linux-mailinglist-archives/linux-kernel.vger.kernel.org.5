Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC6A7A72AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjITGQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITGQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:16:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B98B9D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695190556; x=1726726556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wago0Kb1B+ixLW3mfmOFrQRcxDbOSR9/FrSEsSZdEFY=;
  b=IMdXSpLmE3AkdfshvgC7+Dh3A8QbQOqNsXkSBRrOAHz0rg/bSASZC803
   odw05HDiEAFOBWh72InWRzkErmLBdV3D++qVux3bgOLSiw+WEOlPxWnTs
   8WG7d9urkN31Ao3Y0IRKiQyxDY5jxvh9SkTruGFY/l5kbtHpx86qy+DUS
   w9GzTh4RfQzIhpBGyI9Y8AIcBAUYfRk/MGh5Azyp5b/dljpb/gW4zRwrZ
   +KeR7an7xTetuLcfY3gYus0VwWGHA//9h4qDRj9qV+iMiKq/+apZucufw
   dEgjxp7oawSy2O3mZxFEA23+vGnVOIxPxrMEYBBgOHEe1Z3PiTf0w1U+k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="359524395"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="359524395"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:15:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="749766934"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="749766934"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2023 23:15:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 23:15:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 23:15:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 23:15:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 23:15:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcJU9d64ONKuN4F2/uSxyadjxYJvStMrspaQzSPiJXU8QvCFMhhjAwTA1v/yfqTrt+Nt3YeT+dDMGiS/xfDMWuYXQr9Kws35Lfe4gTAo1QC9NhoqkzII9Ex7GbvYfyc+Grt0qg3Rzg4Hl1LCx00mhU7QqFvKr8uatnE3urGd4L8uzdqQWzuTmyKYPqHdCmqJlXzeP6v4S1DqtUiisNN8FdzfI1TR5FbY3oh5tNuHrkaEHVbiJzKcZNFy3BzmVqrmRDUuAHFtFDXu9+uT1vq/ReBYAXBnjnA2gOnf//nMrVQ6jwGNhr8VQaYCiMRGRnLtOmPTbXzRRZ7nXExsA9YeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gdE3XysUsRn55RDxkgslr+x4qpFQQPMbFjX0UI0bys=;
 b=AkCU4s3xvNzTLFiyFWXE3PZZrEfzs9iDZbbZR85mLY9fv2CEpbWEPFYTxdXtzEMQ46/rFjSgHIAN29FQHz6hWAkdhXE0ymVR+UqN8OOe1Ffs/UKPkeUguDJdgimb1TasEAtqiosRcgEIoDjl9xXMU/vnagj06wqmltihArsljXnowSbu9LKvSaVl6hmp/A6sziW5PF/Mt/TXOKhAdzFDrWC2tFo97Rxqh/RUPNfML9zHxbc9psWVTqNrH9diwt3UGBAAFkdBMB1RFvYhTdUEVWteQheMv6OkGYJ9JRHPAJt+IJV4iJZm5MhoAuRiXyR70gb/EB5ND9Re7+khICvcSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by DS0PR11MB8051.namprd11.prod.outlook.com (2603:10b6:8:121::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 20 Sep
 2023 06:15:51 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 06:15:51 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Subject: RE: [Intel-xe] [PATCH v2 0/4] drm/xe/gsc: add initial gsc support
Thread-Topic: [Intel-xe] [PATCH v2 0/4] drm/xe/gsc: add initial gsc support
Thread-Index: AQHZ5uJU4dZB8UAZnUqHEr+T0h+hArAgxnUAgAJ/HKA=
Date:   Wed, 20 Sep 2023 06:15:51 +0000
Message-ID: <CY5PR11MB6366B29757BAD32AC21C0B8AEDF9A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20230914080138.4178295-1-alexander.usyskin@intel.com>
 <ZQh1klXZSf9/qqf5@intel.com>
In-Reply-To: <ZQh1klXZSf9/qqf5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|DS0PR11MB8051:EE_
x-ms-office365-filtering-correlation-id: b7a4b600-0f6b-4a28-ae83-08dbb9a109f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rvo8ZBOGw0ZnEIsq9CfU7s0HLaGH7OG/3rnKtt9trn1T4bSSca+wFxr360SYU0nOR47aIPajs1s8AWK1qKJ9pmPyurObUou9GPZOFB3U2DAYgBf4okLhqzMmJKOn7PBn3mwrCpuSD+QFD1ny1dMKr+SJYeBvuoYQ6Gd83Tmjn16ieK3Ch5tnKZjfnCdgdlg+tnbEeFKFZX2EnAb4rjwtHQs0kYyJ7D06bd+l/rNYD6ruYoHMMMuPUjBr0zk67dnAjqURaOSHYeka1lS1O6d1GWjeIA2SICTJc3ZZjEN8AkkJyMDiH52oigBt7SdanCUlpInmeikD1NUMfGXIzvs6XU0jOKaQUjjvLdXNmYFgVDsxE9Dw1FA3JJcWqF7R5CCKxyO5hTIyUUKJB9tsf3RxvW8vpaPcF365Tiuucc25GyzlV0W7w/eYQr8bK7fcx8nReXcKhRRltnDSiuibg/FKtshP5vwOCs0zLgZCKGTIJ1NLooPt9qmNOGUfiNJgnGZXnKIywlsaYOcsr6YyQbbgTft0LHotBciBQICNdN+nRiRVfY3UYVFQps2/6g9d4+m9IWPw8dpketFISh9+RoOe7RNrc7B+pWDQfBhhIbOdMRnKHqmM27mBPFd9RF5XUKYh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199024)(186009)(1800799009)(41300700001)(5660300002)(4326008)(8936002)(8676002)(6862004)(52536014)(7696005)(53546011)(9686003)(6506007)(26005)(83380400001)(478600001)(71200400001)(316002)(6636002)(55016003)(122000001)(66476007)(66446008)(66556008)(54906003)(66946007)(64756008)(76116006)(86362001)(2906002)(33656002)(38070700005)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HeqaQ/6Tk352bofLCRBpflxxe0a90Awe7pbAEgGAnoe5nWpMQrbD/bTltvMk?=
 =?us-ascii?Q?dJr2iRJ4FBy7WYGGxzEQ8jpZmiT/ea18Nj+LARLNroJJA+/5Hy76ndMmGFDg?=
 =?us-ascii?Q?xXalIgDCtRS+EGE2J5zGCibCncK0YaCh4qBBb5Lb7xZBf0Iz1CFZ3Q316t7E?=
 =?us-ascii?Q?z0uJzl35lQfG7R02Ut6F2SUA/6RoLuxrVF62ffW3P5p9z5L0zom6vV8RRCBi?=
 =?us-ascii?Q?ZmFnag8ajO58a1j/a1rRoYNomumEUF61KlZU0ltMONXa8D9CdIf5jtol59PY?=
 =?us-ascii?Q?08InkgJ3ZCz2K1SMnEvYctpdXlcY4TF7HTor1SUq3B/UMG3780M+dhF9OSHv?=
 =?us-ascii?Q?Ksq5Ep0lnZZCBVWar2ec8LDGocZosHEt9+ss3Ue2vZX1K8frkHEeN0lQqHYP?=
 =?us-ascii?Q?lzmkbSFgF2Z6OnJcPQo3ETBYGdamInSS9m4k0LyReic0aXGMpY26q0dAq0bS?=
 =?us-ascii?Q?NqXxk1qzmAvKwKGSDAAEnKi7meiJTz4T9QmdYyCAQOtGHR02cTwayGE4jy6l?=
 =?us-ascii?Q?6sHo2ZRYgDewKP5iHadUi3dKJohyBRGXtO0PtcqkiQSdNkGcBaRtsrdeAPkV?=
 =?us-ascii?Q?ntQlUyQj0B456BkQ9Iz/SOMJVy4Fv6gmDaV4PuI+Rq1seTbxmJPh4LzFhPfz?=
 =?us-ascii?Q?XLkZZxurWOC8DjqYV14YSrh9AW3rX/Q3ubOZ/NhWELZ6eMAFoW7ad5Txnoog?=
 =?us-ascii?Q?zoI5+6B5S40tmMBAwoF61Iudhb59J/iVSPFvM68Oj4q1gJC4r8PeSDmafYU/?=
 =?us-ascii?Q?l5Y2t6m3pXkKogq/YLqTKDlM+Abbl26aEfuc4EY4ponL72RvkXfatFUn2rwv?=
 =?us-ascii?Q?L6s7/p7CzLDOT7burWN+Zj0AMhi9g2ihVESgDhTQ/D9kchVRh090WrHuR/ZA?=
 =?us-ascii?Q?5g4qsZF4npw6uJaBiO3nHCIOJyegEy4NXHqbo5oSuBk2/o7EHdNh6u9XPwS3?=
 =?us-ascii?Q?k8r7mnjBUKbvyoa4qJidnSSJ7ArzWyyyxyPAobbpIgjEG96pMo+MpcNPlb7n?=
 =?us-ascii?Q?cmaKcs7WVZDwhNqaqT35mJpcYFaJe7PZLsSX5TRD22DZ8+gqAsiz1U9bRHqH?=
 =?us-ascii?Q?v/qFCfGN7jb9cJQ2HrgVvrj7IczIJLHQzEPkHbkcJDTX+uCA6bMlhsbDJ5oo?=
 =?us-ascii?Q?RE/6AS8FfAw2FwB0amJUaOmIXjWWKV9jzWyzVIHbI/7X+Lr+FYfqkFg2rWwN?=
 =?us-ascii?Q?nn+Vdmc2NGjMuj6fsWahDgXrLQBtFO71Hc3XazVc112uIzOQ6v6EZG5YhSlG?=
 =?us-ascii?Q?q9M4qeNP9RLbTZIUKsXSl9KEmc4tWvV/A71eCQ3A9ewa8dU0Oy+kcuDCk6dQ?=
 =?us-ascii?Q?xUcpd9QHnq9NLZSkFZCKpyK2m+ifIe5Po8YAZwLBwomoXsw/z9nG7rO2Hfqg?=
 =?us-ascii?Q?mEq0o5vjaraFmGsxqXsYjAp+ZSjNeqS+mbYhJ9SigNa63DjK/pn9venstfIC?=
 =?us-ascii?Q?kDzvxGBKRykATtneLMyCvypBIcLyNZ/GsE1odWSEp8jNT0M93uivSAyBwCXK?=
 =?us-ascii?Q?NTq2hc8fDEbMWpAcUwe8AgiH/0PXJeOxFGN/JXXnnSIAh2Wv6dYXDeUXUdzj?=
 =?us-ascii?Q?taDkEo4l+BJc3vyjLLSe8r0ByWQHl6z1ieB4c3gMQzDYwBIObTJr/VdUb3E3?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a4b600-0f6b-4a28-ae83-08dbb9a109f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 06:15:51.0649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3PhNevONjs1rQyuA9ZsVxd0CGCA8iP73PIsAmqWO80H7q/zqnaU+vkqU8pa6ir1KX9LG7ws/KPaWJ3LQ1nS+MnjUeLBRyvecMhovkhs8J4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8051
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
> Sent: Monday, September 18, 2023 19:07
> To: Usyskin, Alexander <alexander.usyskin@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; De Marchi, Lucas
> <lucas.demarchi@intel.com>; Ceraolo Spurio, Daniele
> <daniele.ceraolospurio@intel.com>; linux-kernel@vger.kernel.org; Winkler,
> Tomas <tomas.winkler@intel.com>; intel-xe@lists.freedesktop.org
> Subject: Re: [Intel-xe] [PATCH v2 0/4] drm/xe/gsc: add initial gsc suppor=
t
>=20
> On Thu, Sep 14, 2023 at 11:01:34AM +0300, Alexander Usyskin wrote:
> > Add initial GSC support for DG1 and DG2.
> > Create mei-gscfi auxiliary device and add
> > support for device created by Xe to the mei-gsc driver.
>=20
> why are we not adding the GSC already? because dependency on the GSC
> engine or something like that?
>=20

The DG1 and DG2 have only HECI-GSC routed via mei.
The pure GSC without mei is for later projects.

--=20
Thanks,
Sasha


> >
> > This series intended to be merged intto Xe tree,
> > the only patch that touches char-misc is addition
> > of id and alias in mei-gsc.
> >
> > V2: Added heci_ to struct and APIs
> >     heci_gsc moved under xe_device as GSC is not under GT
> >
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> >
> > Vitaly Lubart (4):
> >   drm/xe/gsc: add HECI2 register offsets
> >   drm/xe/gsc: add has_heci_gscfi indication to device
> >   drm/xe/gsc: add gsc device support
> >   mei: gsc: add support for auxiliary device created by Xe driver
> >
> >  drivers/gpu/drm/xe/Kconfig           |   1 +
> >  drivers/gpu/drm/xe/Makefile          |   1 +
> >  drivers/gpu/drm/xe/regs/xe_regs.h    |   4 +
> >  drivers/gpu/drm/xe/xe_device.c       |   4 +
> >  drivers/gpu/drm/xe/xe_device_types.h |   7 +
> >  drivers/gpu/drm/xe/xe_heci_gsc.c     | 205
> +++++++++++++++++++++++++++
> >  drivers/gpu/drm/xe/xe_heci_gsc.h     |  35 +++++
> >  drivers/gpu/drm/xe/xe_irq.c          |  14 +-
> >  drivers/gpu/drm/xe/xe_pci.c          |   9 +-
> >  drivers/misc/mei/gsc-me.c            |   5 +
> >  10 files changed, 281 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/gpu/drm/xe/xe_heci_gsc.c
> >  create mode 100644 drivers/gpu/drm/xe/xe_heci_gsc.h
> >
> > --
> > 2.34.1
> >
