Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE47789016
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjHYVEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjHYVEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:04:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC262210D;
        Fri, 25 Aug 2023 14:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692997473; x=1724533473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LY3j3sPDId+578pzVVA1k5vSa21oVXcTJFgjiFtnM8c=;
  b=hqnfWj00s+bKGSZaHu1UJfmbYMo2Yt5olLZRCTjO8ClGeIT2vGynblBF
   swXySLYAJHHXRp2eOV1b35XYmXyMstHt/nUoazBeM+zimJxe4xSELMtdQ
   +yFx0VWzdDcgqru6qlZ77LpyvEm/OTKb+4fuUVzoURoB7zKWUeYx9PReU
   tw02ifUiEP92YkF2PdoD7iUniKh506jtIzjOcHtReuVzUAzLshRPnAVJI
   +Qmk3Qte+hhdo4MOEqctvjImIiCqfjueGQ0DC/3TgGy7bb1m73ILTIM6e
   tLSyRjzOCqk/jWbpJF5FsAjsI06sCtgd+S502/go1WQU813GrB11Fq9Eo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="438744682"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="438744682"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 14:04:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="740738887"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="740738887"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 25 Aug 2023 14:04:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 14:04:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 14:04:31 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 14:04:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAfVnUYXlavVx434J2+OpSYtQ7Mf3spRIdAxN8QGPPr7/jrvlXqiaESbkiF3BZUpg+8oKWsXEwgztRdhQ/L8ebzIujiEVErnAfiuwQZ6lkDCNPFjdKNzFGsHysafygRfgcc+mp6ENgePH5Kge7HOjYTt0fVgmwJit8v6bomf5/Mh1z8p9GbYk0xTKKVsWH4JouLoYTA7YeTVHIBm/VfGmeuSxX7+OR/pe3eFTUg4jkNR/Cp9k9Sa8RcqlD5Ngnham5gSRyfUwLrB6mieYpzFmU8j6EeE/MJ7gUuSq6ZnZ8razbUfr1Q9AmFjIQ4hsPqpehlvaHLYz4nuowPUYfNvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4PdA/r1lu9zVINhMosXCvoIOtdBuNHPvRa9xbURa78=;
 b=XKksq7lycDO9wbfHLbX9HMG9IKfC40VrziJeRSSTYtWOK6I7pwsgy7whva6vwT/Nvdg1unWACkfOi/CNL2k4TfgDmDNoCOLraQk9A8wf46lQr35rhsNaevy1bw/DuKa/RvjXrMIqZOmceSDR3OwITNfgM6eR/0QYoVirjK9+43CJwpwOHrdoiVFFY2jwW+n+r8DqCdTN5n5RlSIybHrQYwfJrWeafrPeRXnA3OGRlIVBQ8iyQeYLIRP28+nhtksB+6LGvUJfkTH+iBFTF2H20VxTlc4vxaxpYe0AHayiZ5c67hjULvkEH1dCxNeB3nXztJ0Eiek0oagXcYX39ndZdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by MW3PR11MB4713.namprd11.prod.outlook.com (2603:10b6:303:2f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Fri, 25 Aug
 2023 21:04:29 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 21:04:29 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Topic: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Index: AQHZuR/m4IKFgl1ovU6TI3vwoe4fN6/weR2AgAS6PdCAAGlfAIABbScAgAEyooCAA4BjoA==
Date:   Fri, 25 Aug 2023 21:04:29 +0000
Message-ID: <MWHPR11MB0048B06F1FEB1EF7187B4AFAA9E3A@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20230718024703.1013367-1-utkarsh.h.patel@intel.com>
 <20230718024703.1013367-2-utkarsh.h.patel@intel.com>
 <ZN+j/z97Yy0wv/if@chromium.org>
 <MWHPR11MB0048DAF02954ACC66C026533A91EA@MWHPR11MB0048.namprd11.prod.outlook.com>
 <CACeCKacWhrZE6LFFwF=vDO8362u9feN71pPO8Qr8XoaRgwj5uw@mail.gmail.com>
 <MWHPR11MB0048018BB93C531401D00EF9A91FA@MWHPR11MB0048.namprd11.prod.outlook.com>
 <ZOYnJTqTajyyJV0d@chromium.org>
In-Reply-To: <ZOYnJTqTajyyJV0d@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|MW3PR11MB4713:EE_
x-ms-office365-filtering-correlation-id: 9228ff53-a5c7-4de5-36f9-08dba5aedf83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a1+p7omMNBniie1rcCNuM6jNyC75R4jUZ6+zBnz1i5tyfdiz5Opw+m8GdCrNMvycXjS8vFUG61quqsIpVm/odPjq/FHPXsokt4veLDSIS4hZaQ//gV9HOXo3A+UUaECsUzKdbMih9IIrOCJjS2Kjz8d2Z9huezqr9bMN5dccApdEPr0DmRL+LtppAswO+K51HTwX8Zp4/jbzQ7ljFGY04IY5dgExnl1oDldtavEpHzyvaBL4P6/iYuORLwX2WGSfTZ+igO9V2AxkB12BlmiaUgDIvjhwjHRDzTniRi2JN2AZEG4jhFe8bKZDod+X7i8QeheSNiF28V0t59QZcIi+sGqtcET33skul1zOvq1ZsMU6C75GipRi6Db8WFzGmVKAHWRYT7bvZQXb9F1Ca4iafCvJ+YNRk7Jv345gYgN9kDEiWabewP8kvOzAtnlGPm+QIDVdDzwCLUwxSXqlmLSNDdru01TdZpg5IZzAoI7JUeTlZa9YtS2ptLUlog9Uru54h/Vcu5QiCfoNnCdEDTLIjsKJpW8IQN2xRxWq+9FoV7VySbZKzFbYE3MbSCQvXStb4HzkWtEwS+fkMTmwj+e7vVAkBSs/K1usiqOORlenc48MzEgv09k5p/ruPe2Rkjzk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(1800799009)(451199024)(186009)(5660300002)(8676002)(52536014)(8936002)(4326008)(66556008)(26005)(4744005)(66476007)(66446008)(316002)(41300700001)(2906002)(6916009)(54906003)(76116006)(66946007)(64756008)(478600001)(71200400001)(7696005)(6506007)(9686003)(55016003)(122000001)(82960400001)(38070700005)(38100700002)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Pbe3fhay0KhcqWSWIGfelOp628qMFJcpnv1hFUCxFYexUKUsBT0wjUDxnNK?=
 =?us-ascii?Q?KxP5aoBSI9aACm7QWdkmEaTWDEDom8oUj4pANQFaHUFFt7SOCD6/okOZ5cQO?=
 =?us-ascii?Q?sMbzsjqCE2dMRmTZqSBr8ttCl/C68k+1wfiiV7SmojtD9JCgb5Kfgk5dtfNF?=
 =?us-ascii?Q?LMHZtU01JQqNatIavMAJqAifuTWWJISSz0ONUL370PRNQdbABrI7xNxckiJf?=
 =?us-ascii?Q?1rw9UTBp/kqyvSt8xJoaj+1PXHD2wBDpq+N0aKChQe8Qs92/1+UPwlJ6Bt2d?=
 =?us-ascii?Q?eWkUrO75Hhh9+wV5qRXcfkr55gYT2Xb2luFZMU596Rufs+FFXOQXyfuyzKRS?=
 =?us-ascii?Q?59csTMEQjkwCUXAphbaLyYO5h4I9uO3P+VUC87Fd3rW8l2uMRxSXF9pL/ByK?=
 =?us-ascii?Q?7dvxGpFPYyC9ug2gn9WYNdJ6incZ8KEo3+OaUnIL0rzo3gUlrMOch1xx8wTt?=
 =?us-ascii?Q?+VOS5A85MyQ6OQOTvxlIp26b65FSHd6WpFpdfO7Hzv4YMZunm3XxgSZ8XVGB?=
 =?us-ascii?Q?r5tGZInhhjdioBUyYyOEJRGuEVB440xJvh0xP/s51X7t5cZtuTBUM4yJrieE?=
 =?us-ascii?Q?0HrjhKZO1O190t8NjOioEbQqxpJp/58Qfq1THN3TWewBXcwFG6mOtCS/mQlJ?=
 =?us-ascii?Q?4arF2kCNPa9nm3Z455bFRxyDq5mdJI65ocMaHnsI0mP7qZ3X0pajkT1qY+sU?=
 =?us-ascii?Q?9r9ubNAUdEyRNHA/kE8wDF2LgnVgR7Um+c+FsL1/+/GzXfKV0qXps6Gh2VcG?=
 =?us-ascii?Q?2xlFelW0iur0GZMq4eMXXo66Bvm9TBh0xvCx/DxlleErPyiGDmHsIP4oX4rz?=
 =?us-ascii?Q?RtvJf0+SdIm3H0ayPZIu6Sy3ucKEZDg85R5PsNjE7TfwFldDhA/0KrTee9xg?=
 =?us-ascii?Q?DQ9aES3mpwdxHWE4+jIjXWnBZrrIoL+E500hVDITus9Kot0i2pZvEXsaCgFr?=
 =?us-ascii?Q?0NXTlsrTyGoKsZ2ghdbERmhJBdbLZiP1gc28aB2i5T1UzWWnDfEbZ7KQGsP1?=
 =?us-ascii?Q?g1HdvfW/xzO63GVL5vkNVhgiP6US0qn/u6OIml13WC/1vg8rRIQjwxfOduGU?=
 =?us-ascii?Q?Mex5v65ZwbwkpQXk+Jf6CqN50hoWOFKnsfx9GAlypGqpruX82b/cSAxBK9a3?=
 =?us-ascii?Q?sDzQQRhf8a79hElnD80WfA7ufIr4Dfogi+Z/vY3cJPUO/EO9+9yj/+HkoZ4t?=
 =?us-ascii?Q?7mO2F0splsIyuJbvGxG7KTPqC58CO3gvs8iz2n5zLd7E4H4tjYPqG5vPzl9m?=
 =?us-ascii?Q?5QtsFWRS5kL+QisfmdzvxFBG06P2D1T1Z9XjmL1VVwDYpwnwWJ8uFmkb96yt?=
 =?us-ascii?Q?BpKHV2sDQmtnVlu3Sg1po4k3S16+qMzIhL7KzmEngQJgZuFuob09GHM+oHbV?=
 =?us-ascii?Q?PNDnAWBLMruWXnuPQKeGHrdSvp7c7o5DFlepio6H8jVpXuLO3OcyUmmcYasG?=
 =?us-ascii?Q?XikKr3rOerUhlbxAqDNOGIRpFZrr3EAAvhrz11xcWVT6zBG3vfN/PZtw99Tg?=
 =?us-ascii?Q?ms/dY+zUzu8j8OV+fsuxj/IPP/uaSI7zySHeIsV2tHEElvpCLcswOWawdL7R?=
 =?us-ascii?Q?/hVGe9UUecP4m/Tkc7CURG88XW+aeNIrAagkLWaA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9228ff53-a5c7-4de5-36f9-08dba5aedf83
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 21:04:29.5838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cSdP/Lt+JFyeLLdrqP9zM0PUyI0yAlUuYr/3nNyv2lKfmPYxE/FyQNZp+mcqXnQkxCtLiynZ15a3i6q2YfivBGVRAWSxN+WUXw4rZsphJwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4713
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > > >
> > > > We are only calling it once depending upon which mode we enter TBT
> > > > Alt or
> > > USB4.
> > >
> > > There should only be 1 "call site" and that should be sufficient to
> > > grab the VDO from the framework for all circumstances. Whether the
> > > other invocation doesn't get called under certain circumstances isn't=
 as
> relevant.
> >
> > Are you suggesting something like this?
> >
> > static int cros_typec_configure_mux(struct cros_typec_data *typec, int
> port_num,)...
> >
> > 	if (port->mux_flags & USB_PD_MUX_USB4_ENABLED ||
> > 		port->mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED)
> > 		cable_tbt_vdo =3D cros_typec_get_cable_vdo(port,
> USB_TYPEC_TBT_SID);
>=20
> My apologies, I misread the patch. I think this looks good.
>=20
> Acked-by: Prashant Malani <pmalani@chromium.org>

Could you please add this patch to usb-next.

Sincerely,
Utkarsh Patel.=20
