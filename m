Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307FB7F9ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjK0HLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjK0HKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:10:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD7E1BEE;
        Sun, 26 Nov 2023 23:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701069031; x=1732605031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ofHOdfEDr/n5SdbMYqKSqjyOKKwMF3YtM1UWi2Tegzw=;
  b=mPmbtTEq7Zyf6l7D30GvU0h3FbI+kwUoyzwH0AfvYva8ndjuUNUiuIJ7
   qgQuaEvzzzBZKL9myUFjl3T2wjZuD8tfIEySbDb3Fnh7CxeVoaZNwuxFm
   ZVNaIJwmgET4o3ALMUYh3HrinhfdL0/wlL206O+dHaF/19LHGbwZNSlex
   r89b0DzTN8KnV72oC8eICJSoPgg+2iksa9uy0yAVYu5zmxWeMfaRC67zP
   R5jrCgTvArY1BJRcPLOJVdIaRk888fERTimtgG5zAsjJtiIdKB195JYBK
   W8Bk66BAt34uM2i9TVEOkPIrhFCSDTHJ+2RTG777WiVPgp8agBMBcTvvn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="14207743"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="14207743"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 23:10:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="858954264"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="858954264"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2023 23:10:06 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 26 Nov 2023 23:10:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 26 Nov 2023 23:10:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 26 Nov 2023 23:10:06 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 26 Nov 2023 23:10:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBQGSVO+4VHNXaONsMt93aynqUwaZOXVseOncBsGVuZ+I+w7JWlQUW6SA2XJUY3fh4kgm5RsIp5cvZnHlrtttkvLjiREuAQx5f8R5pkYbVlrg677cMYqgGU/mcya3dxwFmA6nSKXeUDJVyzolOL/io4RJl9sW98O4f6OOQE3ghm55kOxmuq1baBVP7m11i/Mn+Ync7uUglL0P7VF+75ZnsUaAC35B5G3sgHQ45XFPhXsmUFSKFYP8I99a3e/Nglt196Of94iFBeXKjAzpbDXgmMGlPybMOnd9GXOwcCKZ3tDaryR8JyuNB/H3xDoIUnBfJrJKPaDD3BiyW2Ervaasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z49HpAS15yaK3kq0alBsExiOGpgtc/W4DL3seNDFjuI=;
 b=F4gd37Hc54ilb4HlsemuXtIYmwUVzxK9DY64rBRHIWmmEBa/xNmMhVxcAbOQfseBYXEe39zVRTUx7Fqzi5Bzw0xjteWY1g3IFNoDdEUjb9yylPwesBA3fy+uiSmF81XfBf0JU4ksP++VbCFODtYeZpgX8ZfnHZgpIrNMr4aOgJtvJYX+fFTeBTwZnaKvKdDGJoSmpf49Ryj4/NQsmIjcOKXGyUfyt2MRFxIupBYHEOlv01WeBZ1nFqmDxENSgON+PXpAxpc20Zj8+oQBTbDpZ/GCWL2Lu0qsEElQd27PnBUM3vayqaq7+7u0kii3fmp/ROpX2rcXxsxuwZoQV15n4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SJ0PR11MB6742.namprd11.prod.outlook.com (2603:10b6:a03:47b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 07:10:03 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::8de8:c1ad:7062:6afc]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::8de8:c1ad:7062:6afc%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 07:10:03 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Su Hui <suhui@nfschina.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Rix, Tom" <trix@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] misc: mei: client.c: fix some error code problem in
 mei_cl_write
Thread-Topic: [PATCH] misc: mei: client.c: fix some error code problem in
 mei_cl_write
Thread-Index: AQHaG48vJTlRi7LggEaYoOapL7NON7CNyOtw
Date:   Mon, 27 Nov 2023 07:10:03 +0000
Message-ID: <CY5PR11MB63668F464A281A239FA12B6AEDBDA@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20231120085343.157381-1-suhui@nfschina.com>
In-Reply-To: <20231120085343.157381-1-suhui@nfschina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SJ0PR11MB6742:EE_
x-ms-office365-filtering-correlation-id: 3839d3d3-a643-46d8-eb45-08dbef17e0d2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TsNk7eHlYYb3XR/dXr6YmYXDSxfWRiwX0XPEKpq8ZZUQxiez836xBV0ObSDBbYrFRP5oCDORmNDpVrrkGPzIswmfeQL/svrikqRhaN8ZTkCgc4MoIm1Y17qSPdxXXsAV6XAiuggnbbZRqLgT+AI6PTa3n9IpeOL2u6a8Unob8kYWAjVmgBNh5RnvHUh+x49WvMsZdw9e86CKoKHcLcIsoc+61H0h9OxqjK4BMS4j8Hm+bDQvnOwR7gZ8JJSm4b2outZFL90axf0z5kWDlhXw0hyLXszdD159zEi974kbIhzp0TPrIF4cXsgkvweaVxmnWojGKYhuAAQgE36ttMocKW+qA6f05TppTxRIVDAjRnpmDHCvi4bJr64XPSDdnFhUXfWHWNCYMTLOuoo858eK9Ez0kpvldx2BJ/W3NZNgKR+euv1adZ8E3CJgwidOdEqKugXdUsTmt2spGIMydojBmqRIBY5v3LPDT4qmDjKfSPzMxG11N+6aVBB3FruCpyxdyUBkxbNDYHxTy07mzHacxH0cOOnyOrEQ1rEgJXr85z2uABw3AxCwn7yzR5vPRjpNkkcu0+bAdxvj/KpBDjJ/ueeWX0QyAf1jmQLMjDYWS5o/tya5EuzVv2Tyx+1ySa/Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(4326008)(52536014)(5660300002)(41300700001)(26005)(8936002)(8676002)(2906002)(55016003)(478600001)(6506007)(7696005)(9686003)(53546011)(71200400001)(38100700002)(83380400001)(316002)(54906003)(64756008)(66476007)(66556008)(66446008)(76116006)(110136005)(66946007)(122000001)(82960400001)(86362001)(33656002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?etIf7KineY7aUTRtpm7V+GaMqEWfyv2rb7LSCweVckwNtapd9+wzpnXpXL8N?=
 =?us-ascii?Q?eDXZUX+bX0C+636EhBcL+uYAtKaAAtzduBmyUjuWvKskufZG/xbdAhk6iTP0?=
 =?us-ascii?Q?stVTilm7RWHj/KkEAeJIbfQHvM2GYS4X3YLilnFXwN/nPlKWOxhaSGXqRzU9?=
 =?us-ascii?Q?0/33SfzTQf/k0i4WTwmlKpHN2UONlFZDNqCvdPqxnsnq1JBQRAxBynOBUUnr?=
 =?us-ascii?Q?a6KcdHcV5R06JD+PvqNAkFlywtJDbXZBETNycbudwyR4I3DjXeIMcyDStd3t?=
 =?us-ascii?Q?NNyD8iUQpa7iowIC0Jt4hjpL2iiOl/gUiahDb50pTNln50BEgakBEiyrpiVC?=
 =?us-ascii?Q?uFZlo1qtIFq126e7Z9dyh3pDEiOMRKUWEXr2AKNmXrt7g74dY2Gi9JL/Fx6/?=
 =?us-ascii?Q?gHkCOv2eFutw+U/2ZCTmnqM+6Z5TjVZg7oxvYb/+KyzbJYG14Di1FSfdPQnc?=
 =?us-ascii?Q?1Eu4PexVwR+Gr9GAQgaHOwPY63K4VIkUgmHPK3BRJMqwKYGl1H+6UdNS6RwB?=
 =?us-ascii?Q?t0koUslCXBCjmWORyZaAi+u18SVgRIo5l8l6QbUO0R2qklh0WdVKUxYKkxg3?=
 =?us-ascii?Q?nJPT9X1HN9CXCjeKK8oUJxgs+932xfL+gllpoV9Aat5stpgA/wylX+oTO5NZ?=
 =?us-ascii?Q?zMcACBzXv/FRuMvd4tZdXawm1ANZT6wrNm2nVf3RK0dOXZ/wBnX5vDWIwU+y?=
 =?us-ascii?Q?Kf+A7LSWGiYzg00FCLI18Y60FZ4j5CL3K85UGbjpPB7914sLq8faABgV+5nq?=
 =?us-ascii?Q?zeHvIfCIXKC8pv2kglTyiAdEnZyUfcH8O0wWNFg9V1ccpNfznU2end/Nj8Eb?=
 =?us-ascii?Q?AitXp/byhnax6tuoSlcAw0hCpoHi9WxuE5ObA3bT97QSU+0XYLnxxSbOBX3v?=
 =?us-ascii?Q?s1OPcdGzNfr0RUHYPvl0tB1e1gvkZvZ9xa/cXqAXYxvmNbNCfAQafEUlcwG9?=
 =?us-ascii?Q?rC4U86bwA3UgeBR1euM336ML7N55otsMY+e+NtscyLFz5ydREJo9iwbwZevb?=
 =?us-ascii?Q?WRVcPYkCSOILkRz7lzftk8tgAFFGA05zmf9KyBwD/8YO+U2fn6Wfxn2p140W?=
 =?us-ascii?Q?r4zfJSwAdstTeQtaDis3MLI/57t12ZqVx+au/v798i5ZkI9K7cmThggKPsQr?=
 =?us-ascii?Q?YPWKOudC0n3ZSlvGrbXvlGl3V7ZUazBtXS4KfyduS+nXapWFH0A6Cacpyi3w?=
 =?us-ascii?Q?I8BgfXCwBvLYUFWlR0UthLyIr/LOcKQbJVVK1mHAuqa+a+LSvIDHp0l3JCGP?=
 =?us-ascii?Q?MghrS10NkmA+3WkwJe3oxW2voTANJhM19a5f55fni6dIYID2TaO2iazA0owE?=
 =?us-ascii?Q?FjDJA2Xa3++4Uc099ty/P8Mp6iQQqebjmISdCiTKr64Q2KDpwvksL2RAgL7+?=
 =?us-ascii?Q?Zt7k3ZlNA0NxjAI4zVna2NQs3+N9tU+OtwYg31f36CWkjdAFWt3hDVmQzI4e?=
 =?us-ascii?Q?GvAGmu94ro7jaVSbuBqnX7uppPeoLn8hSvd3EsjChtPREUBDZFjGwCsUVKL/?=
 =?us-ascii?Q?GGdiJQ/013TrNH52AwyOvKn4f8aRMoUHnibV6efAHqbCg0U7HrIgDM7BGNe9?=
 =?us-ascii?Q?G45V3Jj4L/JjZeoB2UMl6dbODnjmURIKwwtoGB1Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3839d3d3-a643-46d8-eb45-08dbef17e0d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 07:10:03.8099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8Asb3VwhqV3PxIk6LdzRkTbteNpmYverAyZH/zjPp8V5NI+zgrtA18psi4TzjC7fZJNecUlgCiFjc6clorR0lvDbChUTowYuJ01VQwnGw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6742
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Su Hui <suhui@nfschina.com>
> Sent: Monday, November 20, 2023 10:54
> To: Winkler, Tomas <tomas.winkler@intel.com>; arnd@arndb.de;
> gregkh@linuxfoundation.org; nathan@kernel.org; ndesaulniers@google.com; R=
ix,
> Tom <trix@redhat.com>
> Cc: Su Hui <suhui@nfschina.com>; Usyskin, Alexander
> <alexander.usyskin@intel.com>; linux-kernel@vger.kernel.org;
> llvm@lists.linux.dev; kernel-janitors@vger.kernel.org
> Subject: [PATCH] misc: mei: client.c: fix some error code problem in mei_=
cl_write
>=20
> Clang static analyzer complains that value stored to 'rets' is never
> read. Remove some useless code, and let 'buf_len =3D -EOVERFLOW' to make
> sure we can return '-EOVERFLOW'.
>=20
> mei_msg_hdr_init() return negative error code, rets should be
> 'PTR_ERR(mei_hdr)' rather than '-PTR_ERR(mei_hdr)'.
>=20
> Fixes: 0cd7c01a60f8 ("mei: add support for mei extended header.")
> Fixes: 8c8d964ce90f ("mei: move hbuf_depth from the mei device to the hw
> modules")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/misc/mei/client.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
> index 9c8fc87938a7..00dac0a47da0 100644
> --- a/drivers/misc/mei/client.c
> +++ b/drivers/misc/mei/client.c
> @@ -2011,7 +2011,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_=
cl_cb
> *cb, unsigned long time
>=20
>  	mei_hdr =3D mei_msg_hdr_init(cb);
>  	if (IS_ERR(mei_hdr)) {
> -		rets =3D -PTR_ERR(mei_hdr);
> +		rets =3D PTR_ERR(mei_hdr);
>  		mei_hdr =3D NULL;
>  		goto err;
>  	}
> @@ -2020,19 +2020,17 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct
> mei_cl_cb *cb, unsigned long time
>=20
>  	if (rets =3D=3D 0) {
>  		cl_dbg(dev, cl, "No flow control credentials: not sending.\n");
> -		rets =3D buf_len;
>  		goto out;
>  	}
>=20
>  	if (!mei_hbuf_acquire(dev)) {
>  		cl_dbg(dev, cl, "Cannot acquire the host buffer: not sending.\n");
> -		rets =3D buf_len;
>  		goto out;
>  	}
>=20
>  	hbuf_slots =3D mei_hbuf_empty_slots(dev);
>  	if (hbuf_slots < 0) {
> -		rets =3D -EOVERFLOW;
> +		buf_len =3D -EOVERFLOW;

Here code should go to the error path, not wallpaper over it.
The "goto out;" below should be replaced by "goto err;" instead of above fi=
x.

--=20
Thanks,
Sasha


>  		goto out;
>  	}
>=20
> --
> 2.30.2

