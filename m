Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAA67B9E83
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjJEOGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjJEOE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:04:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B89528110;
        Thu,  5 Oct 2023 06:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513496; x=1728049496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YxNFJsQ1hEtTeJacNHerQk4QSizXeR4R+jHU8lMlHNo=;
  b=EV5FqhO2vvRlHaKDKEUScgCwOQjdcW+3oYsokR22hjsPCesVsSi1kurY
   xBM6U0kHrUZ4ddbBy7hbYAds0KFlSEjd6cBA1xyJWEZJvXrwUxN/iY84K
   rq8AL4mUGyNI4xe2D0LCcEhs/VX+cgE4wffyrq1yAIbggVVpEPS2Hqz4V
   EXyBLV/G3KIGNsmKhszy0DL39rrP744uEIxflI8q+4dC+N4O/9TR3C0hW
   kcZikWrkedjSvO2evk2qB7crM91NBdzNH8iJMCzROdkGzlRqebWYpvPAW
   QyWNqDyEOgTKX+4sWLTpUxDvKt3jRtGZghY8p74l9qoZfvtFwAFC4R7tn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="447621114"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="447621114"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 01:15:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="998881300"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="998881300"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 01:15:04 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 01:15:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 01:15:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 01:15:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fl8SCSXwcyqPRO1QcQE06BifCqchKOF+go2bawQalkrsoMCt4WEx8D+o148hDxYYJnsD3F0MpCLjurRn4qidhk9OYZigoZO+rbb3d2c4sqxoBvdBHnGGFB5mqCuLHtiVojQ9hDvLc2q5JA9SxbUhfW+J/F4P19Y+zhLLc9brxLZezZoCtBRkn2fzzkTPvA5uwryu4ZQc1ayGulyRGtk9tVIGux/9jD3hCshulTDCh0VyrmfZJrwOb8fYxJPQpMzF4tFJuQJ6dIvDDd24u+u13U/CYT9UmUQSjnh40cDiig2WJWz1F+1Uio4E4H7/IeL7WAEzs+LgXneiyg0hsWGjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4O5Aj6tg7Dbg3hLW0AouqTVXiuj8BYChWzs8WeD5yWc=;
 b=cgw+lEmmOF3KKhjOv3Ru6jsmV0IJOrzoHtJRmVeeISgbxHPkkKUtlyiIqIdqDEWyU5U57X7/PBfUvlXrZqxXsqFkvas0SMs+ugS4Bq9OmVtCHoDGMH2X33kofpVX6BTWlDhZbcbX2iGsX79HX8yZ8QevXBWo+36pVnvX+FGaqG93vbKEnURNwkN6tXK5eJzvBGSm4vuM0USQnNLsTX8syBpWnDfYzDhtbnmaKc3GbvaTXo2ZmwrdbSFGeKRfvQLb3OPc+Ipss7y3z7IYDOE/Q9unqal7NawYJVw2RymGMvX4/GpO9PHI8uxgZBsvnycg6TcgZ7F6JK0uOB1zYJfgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SA1PR11MB8473.namprd11.prod.outlook.com (2603:10b6:806:3a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 08:14:57 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8%7]) with mapi id 15.20.6838.024; Thu, 5 Oct 2023
 08:14:57 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     ivecera <ivecera@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "edumazet@google.com" <edumazet@google.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next v2 5/9] i40e: Simplify memory
 allocation functions
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2 5/9] i40e: Simplify memory
 allocation functions
Thread-Index: AQHZ8R1CmkEEfj+nDUqzFV6AeSOCerA65W2w
Date:   Thu, 5 Oct 2023 08:14:57 +0000
Message-ID: <BL0PR11MB312294B3A69BAAA99F5A28CBBDCAA@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20230927083135.3237206-1-ivecera@redhat.com>
 <20230927083135.3237206-6-ivecera@redhat.com>
In-Reply-To: <20230927083135.3237206-6-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SA1PR11MB8473:EE_
x-ms-office365-filtering-correlation-id: 31bb62d8-d329-4621-4be8-08dbc57b297c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gx+O9kLnq7+FkyU+3MPU7qlgZexkxBvVwZyTSpRaYzALHoAt4et5D0SLVAibClvz7W/75ZSjqu3sgTpJgsT0FsU3tlTC4jfdhsFvdDIy5W4OJv39jyIu0V6v+ba5TXZeFGTVpoo9Ls+JMkhIAfyRPD8oHpOA0aiOIbePj+QiBKWQ2aum+8x/F29RbwmW9Icv6pvL6Hj+CRuqGNiasXuu4hDWfFpoQvQ3ooycGNkgSJF1bdPMnXXZKFVpp2nks6834IYfYVUu4qrV45RVTUaqbkcfH2Y6IVx2Qb9hhP4Ya+WmmEnbkrLv/qtl4M7TGE6v82r0caixnlXjV7wH+qRxXY5SzOig5fpjyZHdSKeF8Rg8oD0Ij7IYWPTeqMbUgbYs7YMO+AxIA9DFY+rkfhKF6saFI9h4OqKINGqe6JFgbHY9IrqQHrK2UHOskeGpSETmauD1v8Niw1Ff8HzBHcW0oNFmv70T9vq7Qr8s0l8dPMU1LaQ7coIezvqhu+M6TrW3sVcyzIAAGgGK/w3VyAatqDEQCoyraW7P+Uh7vT6GU4EyWR4n0GvxF6uJyeqECl/L/b4cmAy243UsnLZq3uigHL9h4Yo6+9aQ5KadqxXVR2a7SG4Pz/8rJvhZq1Yz6jWN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66446008)(53546011)(110136005)(54906003)(86362001)(66556008)(66946007)(76116006)(66476007)(4326008)(41300700001)(33656002)(38100700002)(2906002)(8936002)(52536014)(8676002)(38070700005)(122000001)(5660300002)(83380400001)(82960400001)(316002)(26005)(55016003)(64756008)(9686003)(71200400001)(6506007)(7696005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3sUZaakylc5wg91h+lFUj6Z9et6v+rCt5SV+pQhoU5td0NMvp/lSmpbCY8Ic?=
 =?us-ascii?Q?/hhOx0ToZfLXYkQyuMQtGZLrHEoFzWF4prG1bD3chGW/rit9zJW1qlk09cuZ?=
 =?us-ascii?Q?FrBiJTg0/7Sm9g/t0cdN6Zj14PaTSez2/Dwi/gDll+Hhu3dzz/cHvK1w7kaC?=
 =?us-ascii?Q?SSwktU3hd7QrGnBoKvspgibj2ue0tnWjbNSX6rISOD0Uf/uQ6EQbWJS/B+dd?=
 =?us-ascii?Q?00gIEIPnq+0JTlmY88wYjOVrFBmdgZDuYIZSU5zyrJ9iNrOXJGOgmXP1J2Rg?=
 =?us-ascii?Q?jpSrcYsgcj5QzmtCUeulmb6b4fzZZlxdWgzw/wA4FJpeVviQKbnSIQeVp162?=
 =?us-ascii?Q?7CsNq1PsGzdK90QBYU3ZDPnM/VjFKphHvpA20NxjNw3U5IGG4f53ralhG9cU?=
 =?us-ascii?Q?mIRXYpLzUP+6ADhZd9AVcPYNi9WXM/eTnEfVfyeEMcylPZ6k/LgkSLHZNorp?=
 =?us-ascii?Q?LiGyp7Gx6foq0qW8CUaypwqdBsYT/L7xzng5PhWis7q3Di77P2+CGPw2W9bx?=
 =?us-ascii?Q?FYEvTGUG3peoCIoPc3IVyy/W/k67OaPO9XNoMLyHicTA5VueFUNRqs1P4Cms?=
 =?us-ascii?Q?A7/I3Ny0CVtUFYLNQAJFjaiN8dDORAwubln+84H6cb5o0ILhhu1YNX1/Rwur?=
 =?us-ascii?Q?rSUVKZFk8klQX/Zfki+6wAz3hnUh2Lu3uWI8xDO9B+6EIFT93C4e/TyDoMIj?=
 =?us-ascii?Q?I/tP4LfFVMtpatmMM+SKEOxO8KTUEikkRWePljr2cLJuoviCqI3k49cpwV0F?=
 =?us-ascii?Q?N92eC+vA7nc8Tmctsn3wIzzW4G75LsWel7lvtlTF9aLwh2/X2XJSjULBMh8W?=
 =?us-ascii?Q?ScoIwyX6NE2gT3ipP+QIapRZ+lQH5M3az3RauU5mVZeKW4WFURx+Us0ujU4H?=
 =?us-ascii?Q?2a7B8T6cUnuT49YZusiRYHjWjQ4OvAQWDvlrD4eKD+t//yhRyBWDEBisUeQV?=
 =?us-ascii?Q?3SY7ri6j6UI5L6xUpqcRcs8WCGnsu7LgY/WIrOIgHUYly1/pq7wxjrzfsFyS?=
 =?us-ascii?Q?gWwlONmTOJXpi0rUGZFU3sBS95Ygkb/Mqak8AtMfPlnTqe0mInCkbTSFXPs+?=
 =?us-ascii?Q?3wXvdlwa69Kn2sS5WtzztjIf+NzfazlI8uYNAfMad59Vx0uD1bdqN8MhBUxD?=
 =?us-ascii?Q?tRCEoCNqxf/6kKoBVD9YWB7fWJFyfJJzpG3g4y91egKRupQSOIJJY2RgjPIF?=
 =?us-ascii?Q?pj5/OHYjYyCeF0XQkKbm2OIKNt529umfu9nNohPZ3wPT/166PuJQ9EhxT7To?=
 =?us-ascii?Q?A+zqzKt6qUSppoQ7BzyiKwp+sGLvL3jSQuUn76jOkx2aI8HbBApe+/2imVbM?=
 =?us-ascii?Q?ptNm4l5fkYZx6sz1guonsy5IDqc+K2U69zYhKX1HN3fUeTdSkyeQSEPs3wX5?=
 =?us-ascii?Q?UhZr9KaTExj5fS+c+3JR5kxlxv6N9ZxWKc/4114lzzmAQJoEYTFSXTjEAtgY?=
 =?us-ascii?Q?aUAg9sP1X7+iCnalkbkz3tDGMK+/9CvPOYL943q8R0TaIdxs65HJvmlTUfQx?=
 =?us-ascii?Q?pA+5sCZMaBoiT+FLZXBDhcVsoVxGiphUxwBvCT8fwLk028D3iRUx52ld9OPU?=
 =?us-ascii?Q?Qz70vRWtCT6agmqfKbMGn8MzBS8xmCxiZ/Xzsl+pgJ77YlfSuehtC2i5aZv+?=
 =?us-ascii?Q?nQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31bb62d8-d329-4621-4be8-08dbc57b297c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 08:14:57.0282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QTpfJUuIqwmHGFz97bGRFN2SuVQbaGYV53uRpd9dPaDYdCAbzCvZ6JZIJgRFer4B5SCVPzU86dhsqVU63W25tlPVTiS7Ksh/yTD4JrNQrH+6tRSArtoNilBPqxX5Oq/P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8473
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Wednesday, September 27, 2023 2:02 PM
> To: netdev@vger.kernel.org
> Cc: edumazet@google.com; intel-wired-lan@lists.osuosl.org; Brandeburg, Je=
sse <jesse.brandeburg@intel.com>; linux-kernel@vger.kernel.org; Nguyen, Ant=
hony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitsze=
l@intel.com>; kuba@kernel.org; pabeni@redhat.com; davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH net-next v2 5/9] i40e: Simplify memory =
allocation functions
>
> Enum i40e_memory_type enum is unused in i40e_allocate_dma_mem() thus
> can be safely removed. Useless macros in i40e_alloc.h can be removed
> as well.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c |  4 ----
>  drivers/net/ethernet/intel/i40e/i40e_alloc.h  | 14 -------------
>  drivers/net/ethernet/intel/i40e/i40e_hmc.c    | 12 ++++-------
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 20 +++++++++----------
>  drivers/net/ethernet/intel/i40e/i40e_osdep.h  |  7 -------
>  5 files changed, 14 insertions(+), 43 deletions(-)
>=20

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

