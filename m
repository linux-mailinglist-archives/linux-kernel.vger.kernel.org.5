Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D29C7990E2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344515AbjIHULj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjIHULh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:11:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206A69C;
        Fri,  8 Sep 2023 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694203893; x=1725739893;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1i1KfBFiSTUY7x496pUWhUcOiahc2+FwwF/1+70/gGM=;
  b=fTFYIkDL0alFOT8feaUVRMNAmONqzAAGFyYTf66zelj8Xr5+7kx4NxGQ
   3+FTG60kh2BoYW51yXK83u/LeJBAkYxId0ptOMLW79OJai0CMidAa0aTw
   hcqU4Nm3yCqYXErXAHX/cEiRJNWVTTcqiWynTkWrNUobE5K1Y75hueXYR
   YKOa7r93iratwULOGZQR94WAog3mmPSnbacKP+O3L0WGpOIBoM3SXOzPv
   Gst4YTxeAJa5RceWpq7SnypFOAvp1XHZI2h9SafPCauj05PUkBCa7iODu
   67HVVJNqr4FDSoh8VnLDnT2svMam3Xge/xfe+RiNFVKzomL1UJoQHNSTV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="408716962"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="408716962"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 13:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="692386255"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="692386255"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 13:11:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 13:11:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 13:11:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 13:11:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 13:11:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D79bWHIHcAGao8+s0xnExEZJ5kTCG2ovEywuYsC9EAUY5HdJW3MeJ6O+YKY9eR0D6Rt1r3bTXAObr2zV4PNexKDmf7phfUzhS++pMcPOypzBP3QxrWZw8oBqee8yWKTbqBbL73tqnhTagk2WKXOm1oQ26e/G9fcgxsCj6WR9wjEgCvcYO310V+efVAJeHjWiPJogXnA6zC8Vo0rNRHwQkguOxf8M3NnePTKb4SBYuNp1Ye3Yb3Ceet8xaM4Nr2BJI9/7rMNwth/6AEB1dtaQuH6FPrvmkXk+bvo56qCPtq1l/RY9VRyC14nT1h4m61oja2FFaX9/zt4e3/vJj7Gb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITsFKc6viREIUi4oY2tHCbJwrPfUOalpknLnhP0+Xqc=;
 b=OIKfvLHcLiIja5KqvwF/nzRIvjxs26BGWkBzueD2B3ITLOqfd7POoLlH4MIJksLHv0F/kSl4rwrvX9Dw2wzDDXeSgcqtIuqU1nLuyzANiUsd4P1N3QnspRSZ0OzzHYtq0xXMYto1BdBW1PWMjRzh5NwExpbz7+J9mntYRdGtgiv906cJsS5kCa2ANg1iR4akpryRvHr3YeV6cNp4VHwAW2s9FK/AtK/F71v6XMe/gBj3ZsPvR9KDwXnDOdr/5+I2tngerocTp+UoR76lu9jPB2nwxoaP5rXed2PZgHmm1I4k5asX0yGrU6zqikzsAFGePVLNiYeXtsdM0X4QpHfsHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by CH0PR11MB5505.namprd11.prod.outlook.com (2603:10b6:610:d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 20:11:27 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 20:11:27 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v2 4/5] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Thread-Topic: [PATCH v2 4/5] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Thread-Index: AQHZ25LloUpSuUlFqEqhUDSvXhP6krAEhr0ggAyuzQCAADQvcA==
Date:   Fri, 8 Sep 2023 20:11:27 +0000
Message-ID: <MWHPR11MB004837C6D40AD0315A5EB3DFA9EDA@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20230830223950.1360865-1-utkarsh.h.patel@intel.com>
 <20230830223950.1360865-5-utkarsh.h.patel@intel.com>
 <MWHPR11MB0048D87555CACAC4DC7DF1DFA9E5A@MWHPR11MB0048.namprd11.prod.outlook.com>
 <ZPtTzovOMJ2gmPdy@chromium.org>
In-Reply-To: <ZPtTzovOMJ2gmPdy@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|CH0PR11MB5505:EE_
x-ms-office365-filtering-correlation-id: 73cae1ad-b4c4-4686-a4db-08dbb0a7c8a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pNPmJHS4Ashaetz1ob/qfhpyPFeKKwgw4RV1iGsdQThf7C+Oyi2zHZLfx/aND9bDon9+YlbyMoCE67JAikxBM3sUu2KriawG21aXjTXKhbBbJhockTOjSFMk8MSu32sLWttgwnzfkdamdxQennBVv0LBpFrL3ZnW7trJcAPmBaSasJJXod6d8biCR/NppVT6sWdLIH+7pMa9rAuR267H68SuX3SGvF0tMgsHYD0v9/YrhwQbfZ2feZ2uIOavb3XiIffYuGZ+5DIY/+dMIG8C4n1mohk4BHo66zRYRgOj24OHb7M/L9lGU8pESLm/aKxtEXOILV2ES+V5GsKl7mE4rfBLB/bgRRDnHuu7Yv2MvBXUcwtxYB8aMMrhyofyYSrm0Mt+aA50yl9h5jPKOJXtMffgIZvBcUNiFAQaZX0i4j4W9MhBXOK87bQXEyoSYVsAIziHk/uFFylhriX/MK74dDoCmdusw14PfbBS+deTGleZYTCuXydJAasrnPBIik/fmr6W5AfYY3Iaq/e+LJmZ65L6pCwJLAzHeUoE/7W2csT91GZSIE/4igi1dLQcb+ltR3bxcfwSgNlC8GlmluWVT9l8a3Mh7XIt4Ydwfu7GVXG855oyKUcenYCey4MYGtJj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199024)(186009)(1800799009)(122000001)(82960400001)(38100700002)(55016003)(86362001)(33656002)(478600001)(2906002)(9686003)(71200400001)(53546011)(7696005)(4326008)(6506007)(8936002)(52536014)(8676002)(38070700005)(5660300002)(316002)(66476007)(66556008)(54906003)(66446008)(6916009)(66946007)(41300700001)(64756008)(83380400001)(76116006)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wk1qyMDCRBAQGa/B1H9dDNmF6UijuWcSybUOmkLrJZmewsyNabm6pkfchPGE?=
 =?us-ascii?Q?ni43Ny+Axi/FDL/KFWgfscDS7exojgOu+u394VVGMmHvL678vrAXdtdLZn8W?=
 =?us-ascii?Q?USwgxpLSiiwkBXEIuY/D5oT1gHFrmEhTJqaCXzRfJQofVl0HS9qh/yKOHOEb?=
 =?us-ascii?Q?+Uv/JPeDmyk3PHaGIII8rlZ2cIhGSgnJaml8GJUF8vDy1rKIzw0sPmnQi3gj?=
 =?us-ascii?Q?oEFkZ2jA052rKUwpCQEkvuHX3u9gDQDQrQNzjXJWx0XUP1jRhWTgCRyXHDFn?=
 =?us-ascii?Q?eOuVvcwf7OAnNL2+R+LaZkeOjCbCgm33CTClDU7TN1HSouG3erbFQdNLwcbb?=
 =?us-ascii?Q?ng7XaZFV8zI4YNUQth5HzUZsWpmg9+96pDU7DOucUIx57IBts9Ssyz3VJGvM?=
 =?us-ascii?Q?mpWXeuW3KwU5d9Xi5L0uGQJ8mA+BXIIn2XGyJiqrHwbvfV145/sND83ih4A1?=
 =?us-ascii?Q?mTtG3veKDYehlm8DHhm5FH2y224eDjUgDnNCNSFf2u9JMs4pMt8KFoOaXmEi?=
 =?us-ascii?Q?1QGthfhpcTRJ7IF8lWiTasw+a3d4faauyR0gSDy6IFiL4/ZqHUnxkek/Tp1k?=
 =?us-ascii?Q?pJdPcKp+PsOXFRhOMEEEBHLn7ToSlUU/vh6Yjh8U8V4SE9YLhRomES8J+LCu?=
 =?us-ascii?Q?Mztb4fKYsAJ2TyS94cv1lp1O/Ja/3YMUbDdTiHOCHe60FNwRDLglfUJ2dPvb?=
 =?us-ascii?Q?rThj/Vn1vX+vomWFI6vsy7srsfzuNzZFPPBA3PAJK8M0saNLV5j7463Ifrcj?=
 =?us-ascii?Q?nuoadpFRb4J1TNYPct5n1bSwufhZxbkit19vc4iKWLe+XpaTmG9Dptg7YCi8?=
 =?us-ascii?Q?p/3C23GgeDfMaF+4D6ZY1b7DDAoMKjjvuEw4DH4kFVbo1wg1vtfDuxLdGFsZ?=
 =?us-ascii?Q?CckLRN3kQaKXFl/lMIFHIvl7IaDGJUf33VJBFFx7oc/DMvbjcZp3hwmjUkfc?=
 =?us-ascii?Q?tdAjOnvM6R8G2snRslFQg+09Wptpt4hu/q7+Kpx3pnzVlJZp2zX7nzbuG0A4?=
 =?us-ascii?Q?zYZIaxetHtbc39k3UoEqgl/rGpfNoMdlVI7Oi+iIOLGispLcUdvs2ORTpGdr?=
 =?us-ascii?Q?3Mz+fOHygsjgaagYtZeNXJzOPESnVtWmYti2Ng9clZphjvEfkk6zDAMyvHxL?=
 =?us-ascii?Q?RUPQrTEHfTjasXpLbzRZ61TaNzPyz+ePtMXPf6qfl48OqW/0OmmdsiQmakDL?=
 =?us-ascii?Q?yskwyNF9Ore9flv2cefwYgTbqHFwbCRdUXaUWbYW0rDmz0lglilHalhVtKat?=
 =?us-ascii?Q?xru0fXMO3By9vMGeXuqh61n2ooGJRqkyliHtzJ+qD1PHjfN4Opg53aoSdzc0?=
 =?us-ascii?Q?P/aREGA/A3ZEPf05UpebE7x11ULwJ/Us7tCgAVEzFNgPXv743AD0nROCnyof?=
 =?us-ascii?Q?Jx5UINfeT91lYnXopmt85X52sfjRZKZER+fj9totMlLxcOh2l3O6BlitSpF9?=
 =?us-ascii?Q?fauidCb/GEbRlZamj5aUpiO50cJvfW66G+AbCApkEweRKnyCJnVbFzu89iWQ?=
 =?us-ascii?Q?ju+cAvm825RSGNz/APysv2lFTfr7o2jbPw/g+R3kKN33M4yLkoCcktMmyWJE?=
 =?us-ascii?Q?41ItLgnf72mKWaYiOSVZkSMdmyRNg+LLZ8wsx3m7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cae1ad-b4c4-4686-a4db-08dbb0a7c8a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 20:11:27.5590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUr3pLg8YNLzjQ5VpFCtAp/S/8Ka9DWv4RKNWIeMp1LyULSgiV3VBGHnO7lPH9bC9Z7MXUCJXzPpOrJZcKbOxvC4GmKVdjUAKC/A4mqsVFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5505
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for the review and feedback.

> -----Original Message-----
> From: Prashant Malani <pmalani@chromium.org>
> Sent: Friday, September 8, 2023 10:03 AM
> To: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> heikki.krogerus@linux.intel.com; chrome-platform@lists.linux.dev;
> andriy.shevchenko@linux.intel.com; bleung@chromium.org
> Subject: Re: [PATCH v2 4/5] platform/chrome: cros_ec_typec: Add Displaypo=
rt
> Alternatemode 2.1 Support
>=20
> Hi Utkarsh,
>=20
> Just a minor thing you can fix for the next version (since it looks like =
there will
> be one).
>=20
> On Aug 31 15:24, Patel, Utkarsh H wrote:
> > Hello,
> >
> > >  drivers/platform/chrome/cros_ec_typec.c | 31
> > > +++++++++++++++++++++++++
> > >  1 file changed, 31 insertions(+)
> > >
> > > diff --git a/drivers/platform/chrome/cros_ec_typec.c
> > > b/drivers/platform/chrome/cros_ec_typec.c
> > > index d0b4d3fc40ed..8372f13052a8 100644
> > > --- a/drivers/platform/chrome/cros_ec_typec.c
> > > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > > @@ -492,6 +492,8 @@ static int cros_typec_enable_dp(struct
> > > cros_typec_data *typec,  {
> > >  	struct cros_typec_port *port =3D typec->ports[port_num];
> > >  	struct typec_displayport_data dp_data;
> > > +	u32 cable_tbt_vdo;
> > > +	u32 cable_dp_vdo;
> > >  	int ret;
> > >
> > >  	if (typec->pd_ctrl_ver < 2) {
> > > @@ -524,6 +526,35 @@ static int cros_typec_enable_dp(struct
> > > cros_typec_data *typec,
> > >  	port->state.data =3D &dp_data;
> > >  	port->state.mode =3D TYPEC_MODAL_STATE(ffs(pd_ctrl->dp_mode));
> > >
> > > +	/* Get cable VDO for cables with DPSID to check DPAM2.1 is
> > > supported */
> > > +	cable_dp_vdo =3D cros_typec_get_cable_vdo(port,
> > > USB_TYPEC_DP_SID);
> > > +
> > > +	/**
> > > +	 * Get cable VDO for thunderbolt cables and cables with DPSID but
> > > does not
> > > +	 * support DPAM2.1.
> > > +	 */
> > > +	cable_tbt_vdo =3D cros_typec_get_cable_vdo(port,
> > > USB_TYPEC_TBT_SID);
> > > +
> > > +	if (cable_dp_vdo & DP_CAP_DPAM_VERSION) {
> > > +		dp_data.conf |=3D cable_dp_vdo;
> > > +	} else if (cable_tbt_vdo) {
> > > +		u8 cable_speed =3D TBT_CABLE_SPEED(cable_tbt_vdo);
> Can we declare this variable at the top? That is the style in this file a=
nd quite
> commonly seen elsewhere.
>=20
> Or better yet, just inline this and get rid of the extra variable altoget=
her:
>=20
> 	dp_data.conf |=3D TBT_CABLE_SPEED(...) <<
> DP_CONF_SIGNALLING_SHIFT;

Ack.

>=20
> > > +
> > > +		dp_data.conf |=3D cable_speed <<
> > > DP_CONF_SIGNALLING_SHIFT;
> > > +
> > > +		/* Cable Type */
> > > +		if (cable_tbt_vdo & TBT_CABLE_OPTICAL)
> > > +			dp_data.conf |=3D DP_CONF_CABLE_TYPE_OPTICAL <<
> > > DP_CONF_CABLE_TYPE_SHIFT;
> > > +		else if (cable_tbt_vdo & TBT_CABLE_RETIMER)
> > > +			dp_data.conf |=3D DP_CONF_CABLE_TYPE_RE_TIMER <<
> > > DP_CONF_CABLE_TYPE_SHIFT;
> > > +		else if (cable_tbt_vdo & TBT_CABLE_ACTIVE_PASSIVE)
> > > +			dp_data.conf |=3D DP_CONF_CABLE_TYPE_RE_DRIVER
> > > << DP_CONF_CABLE_TYPE_SHIFT;
> > > +	} else if (PD_IDH_PTYPE(port->c_identity.id_header) =3D=3D
> > > IDH_PTYPE_PCABLE) {
> > > +		u8 cable_speed =3D VDO_CABLE_SPEED(port-
> > > >c_identity.vdo[0]);
> Same here, you can inline this without affecting readability too much.

Ack.

Sincerely,
Utkarsh Patel.
