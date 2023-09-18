Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FC87A4ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjIRQ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIRQ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:27:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792563527E;
        Mon, 18 Sep 2023 09:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695054267; x=1726590267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l54zxGpG+8D4yLPOAcANR8QL/i8EDNPgk2ihzsIXus0=;
  b=UgIp/SW3MtyarbRecAaTCKY4b/mlwqBxotIsxRDbBUOsm/shHUu5BeNy
   CObbIhSLWTJv1XMVnVunDc82S/7OrZHt4kKzT6xzJmeYcr+6mXZtHSL1C
   G0dahxH0c8klf/TLphxYqjWjse0RIUx8DnBuZp8YaoXWU/8U9ejXi3RJB
   1FFMg4qo25K8dwZMdQp6KSxnvz7VcFeIQsbuOH4NG2J44KlAbjCfMyzEb
   LK8UJ0Az/02Ci51vxWOx/oe7wx5MN6+w3iLe8/uen653s3PAo2nYEfw2d
   GEPU8ubQaPg3UZNGCUlTqikZid6LUKRdHeeKdh5KHE+hu6VTu8v6qQHaA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="443781386"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="443781386"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="861129618"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861129618"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 09:19:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 09:19:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 09:19:27 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 09:19:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkiBAyHqiezUY7T54qSaKNT7L3AVh9UhGYD9dHdH2LugEeZhk6rY8plpzxqT+ExE9yn2RxWQSpfpnwiH/OyykyDRGiCCwyTx7X25fxw3NasxtVOmYaI+LAcZgW2DH87oWykBut+YcJaW4eqeNDg2UiSwu/rVK6DSjfdSgIhffagH3KVUws44TYNhelbnz47nCow3G0OD2ieX3/O1RfdAZ6DWH5E6BZXzPMbm1eL/TQNDHJYIGrT4M+mdzvyvtqc+S1hx9xeEDoSP7oaKD9mUcjWORZL9rzqTrjlqu5IxJfTQlLImWm+WjiVbdM87fSZsvm4Dwte3FK4onPsT1ZOuTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIZn1SLmgIcY2d5RdsTWNUE1nS77iyaEM+AlQzHV7vs=;
 b=E0ejErDpzxjT91mB/JDMsY7JcyIEpI5a614g9zjWiU+1DiL7Zsdz33FtvV6n7j4dgXUuQxpae5bugbFID8yBzc+Ca3L9tof3lM0MKBWR/EdmTYqjlX13d9yf99F3qPFTRyGHMzjDFRPEbMPNF3FLdijc8vc0nChjQzNdk+IOwCIz61ap83aRQWpBpPPW1v1k4xuWEzfxIi/2cwIto6G5ts0Va5ncMTOB4S4aAffLlUMo5+LH3KzMjpuNMr8g5J5yXHyQsp7mZ96jBN5QBA2L472i+tiws1FOvgsv7x/4NvCVMMQWCoB8uv9raVKtCknndx1ibwMf9uAuyzZs3zR/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by CH0PR11MB5393.namprd11.prod.outlook.com (2603:10b6:610:b8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 16:19:25 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::dccd:a041:a764:21f4]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::dccd:a041:a764:21f4%3]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 16:19:25 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Prashant Malani <pmalani@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v3 3/4] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Thread-Topic: [PATCH v3 3/4] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Thread-Index: AQHZ5RQ8pkufV0PHy0qNPGaCC0iZ37AWY6qAgAWtvqCABDHIgIAAibbg
Date:   Mon, 18 Sep 2023 16:19:24 +0000
Message-ID: <MWHPR11MB00487D601B4CDD3A387BA0E3A9FBA@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20230912005752.1532888-1-utkarsh.h.patel@intel.com>
 <20230912005752.1532888-4-utkarsh.h.patel@intel.com>
 <CACeCKacmH19niA7gWTZCj89ZmFth0LWvkMYasYwUvVHrmFKCZw@mail.gmail.com>
 <MWHPR11MB0048848CD12DC750417E7264A9F6A@MWHPR11MB0048.namprd11.prod.outlook.com>
 <ZQgEbXDNZ+Ap/HiV@kuha.fi.intel.com>
In-Reply-To: <ZQgEbXDNZ+Ap/HiV@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|CH0PR11MB5393:EE_
x-ms-office365-filtering-correlation-id: e3b09329-5b30-406c-b773-08dbb8630653
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AOBvOtHJlxbGqU7hjph34cF7gB6ZqRifZ3eOtaktOQE3xgdNvObkjlEdUzVZOjDkW7kY7ahjtgLQqqTAFTzu/m4lDgQT9Ye7iTpE33hxlzjHr8j36nA7zyy7uWsZtaGpF7Ok7kNi4jK8nO99IyfgS6u/PEaPGXpg4BPwemw/et40kSv262xWJsBuKJHEhJPLX6ebNvuMoCw9D014MZ6b85YElCRZajp2PGu8w6WsJ45ReLXG6YK+vARKQfZaZope3DsH6LWgiYD+vCUyCZXRMkTemrJ21RVUkPybfx1WnW9SUSy6z5CVFyOEaNkY4iIEXGaKiHzSLN8LBbkJ+OJT0Y1hPYqc+0oycc0ct/KOoA0Q8Mhs2q6ZIOg+8IxQ8Olm1nm8cvEF86DWLy+abnUVSHzA9m9EkgKWGq7fZVdBAhM/tF/buBZ3bckyPQf3FMHFr9Vt+KWiBEqWjPwKFTFamHo9Jwe56fbWIS44/xnN/5S5+GmbzHVo1fxDZvSCvRIm39OJfJtLPs8MkoxP4OecZEGwYiPcqWRdrgQYMeIbdyTcMKgsgRBc2myma5/YD1y8IqrRnYppAfFRq8oBDsVHbSq1FF+m9R2My1AiP2scnmIYbpBICRS3PRx4Y0A2Skrg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199024)(186009)(1800799009)(6506007)(478600001)(55016003)(71200400001)(26005)(316002)(86362001)(2906002)(83380400001)(5660300002)(52536014)(7696005)(82960400001)(122000001)(76116006)(66946007)(9686003)(53546011)(6916009)(54906003)(41300700001)(64756008)(66556008)(66476007)(66446008)(38070700005)(38100700002)(8676002)(4326008)(8936002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/XC8B7mLpJgx2CaHaioEujyl9jZF3krORUKY3PaL0pFAyoDBJf1rdy6Z7MED?=
 =?us-ascii?Q?uXjrTLZXTUX07isAbXZiyfem94jPKQzq8LmWOKrTCfIo8xCNUobEst9xJMmq?=
 =?us-ascii?Q?bUw5maO/IGW4CDry1R8cziRG3rTe6p18dBvVgOhLcGN6/xxo/WgSDhbyb8gB?=
 =?us-ascii?Q?JIF6Wy5287rCnYMd/GQN4lpma6K7K2t6SMt9kYa5PyK0Mi23pSwbaeJ/ZAcK?=
 =?us-ascii?Q?Ck2rsUF97tG0e8YKWm83Jz9vaXXhvXYYJ7NF6qIr7bdnpIhhVaCgtelQrHGJ?=
 =?us-ascii?Q?bXvwBQ61DhWiqFrCw67yAg0ZR0XSp4rGdEsmlvijTJyeF22cdb8/zI67He8u?=
 =?us-ascii?Q?m7eP3o8k1+PT/onOJnCtweyHNIkxNEvrNIedYJtazKTGEV+wZTpOYHXCv/kG?=
 =?us-ascii?Q?JKjIQpxyLe05zYOSt8JO8aJ0N7ezQ0ZQzCN3Z96jHu38wnvlTRIxg0dA+fHX?=
 =?us-ascii?Q?5M1knn9nhpDPJNyZnIXSMnUg0xUCD1sqLv5nSLnd1KtD/iLfBz6rwqO2qPCE?=
 =?us-ascii?Q?bNHiYsCmXrn53lh4VnjqGalAVPr5IEbgle5PNwAGtbFLNGEZTcxfuc29gXAc?=
 =?us-ascii?Q?jpIxVuHlqzgkdI8nd4ij+97hAx+pln/+oMZWinnb+7Mop9zPgjnh9DOXeIWV?=
 =?us-ascii?Q?FkCLWZZ5yBVN+bB6B/ULbocrj4eP5Mca6ymkLs3SPgJfBV8snTxZz/yApfKU?=
 =?us-ascii?Q?LSNqyJ+tORKvipdpG9XBn/968hyqwrnKj2q94D5e5djoFaBXHdgLQHIdiV80?=
 =?us-ascii?Q?a335AAggNPDlZGZdYc2be8cQv6pQ5sR82pLcjldzc+36mCYDLeiffhUbLI8T?=
 =?us-ascii?Q?IjDDmieQpIjpFB9faROUA6ZmGwHtf9YiUp0dSV7ER/gcAqM5//hW0bl1WHE+?=
 =?us-ascii?Q?DJaAs4MmwP+iA40X2QR0TDVXi2RvBywC/KtjGueXsPrHexYFbs3cWbHGTZ5Q?=
 =?us-ascii?Q?BLg/yxusEYU8Fw+ZSFHi1PCgRMmed9r5vxbQ6FO8xK7xSmK4X6nUr2b+g1LU?=
 =?us-ascii?Q?yRmeFNfI16mLK7nKhC7aor4tbRZs+Vp1ozOEsk1afUf565M1O72ZDvmbWBMJ?=
 =?us-ascii?Q?YtyBxaWe49Y8GXn+QzGtdSnPjgNpgqZhC1XIbDhLtn2HlvXd+EnTCig6Rx8k?=
 =?us-ascii?Q?bUESO7m/F3SqapeeKHnhxWgDNduwd1+3n8yFL0zRhQOwid6c2J98lUVms/oA?=
 =?us-ascii?Q?5aEyepMsfl0zbg6PWmjRfy1rz5OC6FFY17Kf88dDP5mv+pjBEtrcvRqNatMb?=
 =?us-ascii?Q?GVksWA0oo6vjt2CgIZFTq3BTjs5egIFj8eeLEra76KnVXRyKF3xV1kQ1LpRx?=
 =?us-ascii?Q?zg3Ih4v0PJsjNYbWjwaJJ9nDC1RR6ujzVVL/DGbwh87LzeBgtZCSf5MvkUso?=
 =?us-ascii?Q?VIuPkr92/VXI9yRyzOVI2Jzf9nlznCvMbxY83764+q/HyrXQKMW+008nOLDa?=
 =?us-ascii?Q?KmqOg3ZBLSPCR6AKG16x1szXYkGyOGaNvvw2iZRdL01cfxKx9HH5YwNsc+wf?=
 =?us-ascii?Q?NUd254tPieBffM+nPAik3RmtmveyVnM/Pupp6Kn8A+LEDKxBxT7nfe/evljJ?=
 =?us-ascii?Q?RqFmJIQyB4qW6zOSDVcAe7j6iwqNq5TrGDpYReUA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b09329-5b30-406c-b773-08dbb8630653
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 16:19:25.0118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m2X+r3I3v90EYMts85xCnmgS5t/nylsp49HCP4qs2+jaEQ80pFqKCwU5MpZ7r4kmFYAqTPLo9pfn10YnViR+birGgkwI4B9o8kySz31hTp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5393
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

Hi Heikki,

Thank you for the feedback.

> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Monday, September 18, 2023 1:04 AM
> To: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> Cc: Prashant Malani <pmalani@chromium.org>; linux-kernel@vger.kernel.org;
> linux-usb@vger.kernel.org; chrome-platform@lists.linux.dev;
> andriy.shevchenko@linux.intel.com; bleung@chromium.org
> Subject: Re: [PATCH v3 3/4] platform/chrome: cros_ec_typec: Add Displaypo=
rt
> Alternatemode 2.1 Support
>=20
> On Fri, Sep 15, 2023 at 04:01:44PM +0000, Patel, Utkarsh H wrote:
>=20
> > > > b057250704e8..3a747938cdab 100644
> > > > --- a/include/linux/usb/pd_vdo.h
> > > > +++ b/include/linux/usb/pd_vdo.h
> > > > @@ -376,6 +376,7 @@
> > > >          | ((vbm) & 0x3) << 9 | (sbu) << 8 | (sbut) << 7 | ((cur) &=
 0x3) << 5   \
> > > >          | (vbt) << 4 | (sopp) << 3 | ((spd) & 0x7))
> > > >
> > > > +#define VDO_TYPEC_CABLE_SPEED(vdo)     ((vdo) & 0x7)
> > >
> > > I would suggest putting this header modification in a separate
> > > patch; if for some reason we have to revert the Chrome part of the
> > > change, then we won't rip this part out too (some other driver down
> > > the road may use the macro and would break if it were to be
> > > removed). But I'll leave it to Heikki to determine whether that is pr=
eferred.
> > >
> > Heikki,  What's your preference here?
>=20
> I think separate patch for this like Prashant said.

I will add and re-send the removed [PATCH v2 3/5]  in the next version. =20

Sincerely,
Utkarsh Patel.
