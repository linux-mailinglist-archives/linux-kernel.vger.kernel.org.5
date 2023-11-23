Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987997F6088
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbjKWNmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345511AbjKWNmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:42:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44295C1;
        Thu, 23 Nov 2023 05:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700746940; x=1732282940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o4o57M6B8zyW7plSNPfWNr/c7m0Bq0UvPOKg8+XnMUk=;
  b=mMwBQInrVT5kGX9em53MBzhLypejkfwW+WLSa5nK0ErFrOUeeXXtO4lw
   XbmDYAaRcGcdUWLj//Gmn5dmCK6tvKKhu3DVdm2RPlTzY4jvf5kPJrjxx
   g4bUix/5gpUEVD94IBQXib7yC/UvGtEBLexRBfZ60wu0/C2aSOQtUZj/1
   hRu0NHp+NMVN7//JVFmY7qUcQtFbTc7WPkn36dKImdWqyUA2MFYUD8tuH
   Lfp3NT9BLQ6HFZ1HpKVFpaPJNccPYVCONMtwzFGzWTicLApiwmPiXkCz+
   b0ZFFBGl2Zw/qaWcOlR/t41zQUOqQ7AX5wDZt2JSNuNqxlrx0v8Ytifxb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="423398613"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="423398613"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 05:42:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="837808621"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="837808621"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 05:42:19 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 05:42:19 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 05:42:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 05:42:18 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 05:42:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQ0e08QvElDqNEqcyReIqjZM6hdwGNL6Hu+SqLHGTGA2pQ5u86l9HyZmzpE/GBvfGjv2HSO3TCc2lIv7VZy3Fdjayd0k6qpY779zSotnYDCNuQ5lcPfqoB9vTm1U7KYCcxJ6Nmh/lzkxLJk1BBnVh9blvoA+LgHYbwyayCZqZtrQL0FG4L1je5qZX3CrvPb6EuenA5gR0U4sFsnshwylHpkz+uwSzm9LBgVJ05RpHjbgaQNgIYZepM8pGrc7rOIdKNHNzpjEqymxkKof1WhtZmrNdoWfILV75WBPO8gpeX2zPEXjEw+RjwDHFzgouHlnml5tkjm0eHzr8bzcNOBrVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zr8KUh+xZ8g8Lu+uAjwmRG3lBAMGNyTYNDsW/d5BXXQ=;
 b=l2hpTUwoqy+6q/JcVe+/JDnMi0oexQURtTxfCdxiAZCbYFsrkkPZKPOn1nVrIuWFaHvLDSZQeaqvl5tqe3XQQnvd3vBBlMMKxd+vLFJfMy888Peyws/iDdAxrHLHGfWS+NXCPnOEsZtWjOZ0khfw+1RSCTO8GA2ElJ5/V7zJe5LbFXj0Cpy5ctS3JpGDZe5S81+nC1u2vuAorCZfigp0v7tv8G7QhqtlDUju4PdgSmvASWMWB6jod8XyNKuo82bhsB3beD+sRgVvQOfvPDm3K/cEpbNznrp52EDrvzt1MUkvtfHRetu8zcl/sfjhDqortoZt4c4SkYyp3roC0vBfCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by BL1PR11MB5462.namprd11.prod.outlook.com (2603:10b6:208:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 13:42:16 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::1498:c32d:2d2:975c]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::1498:c32d:2d2:975c%6]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 13:42:16 +0000
From:   "Romanowski, Rafal" <rafal.romanowski@intel.com>
To:     poros <poros@redhat.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC:     "Drewek, Wojciech" <wojciech.drewek@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v2 iwl-next] iavf: use
 iavf_schedule_aq_request() helper
Thread-Topic: [Intel-wired-lan] [PATCH v2 iwl-next] iavf: use
 iavf_schedule_aq_request() helper
Thread-Index: AQHaF0rvAEgMF8sc5E6gUBQ0mqL7hLCH9xCA
Date:   Thu, 23 Nov 2023 13:42:16 +0000
Message-ID: <BL0PR11MB352138D2FE5BF9BCA0391CE98FB9A@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20231114223522.2110214-1-poros@redhat.com>
In-Reply-To: <20231114223522.2110214-1-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|BL1PR11MB5462:EE_
x-ms-office365-filtering-correlation-id: 79b7c5a7-61f1-42c2-9bc1-08dbec2a0184
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FQl9IbXinaZ83zOI4dqjBkYaypkZSbUoGBbpeme1Qr2eVLAibFRq+sw6iN8Ih2rjhKL1zOTboLBCu58NniI5VUzG7DsK4LgmM7yeNoAtN4Vo/Qojh5EfS7EfyNPV5VMSqePmb3BN6b+4YNyyeo1RzLM/r5A9JC0s2joYbdj07KjrlNLFkDClQxYn+0Qivak1sDMWPeAOe+efc0pA4tEe5DHgjRPtqoQa+30OG00mAOGZHcufu99toNvhBG4uhN0DC1gxRp+rzHDayGLnA68z0fH84PiIc5kTbkdeZYJWr24aofyPTXM9ogyMj4ILOH1ZAwOW70AKXTFVRc09xUU5YRnVYcMd0Hc1y4HN2hhvHMHAstCxUlWijQE/Z82ZoHuYTCIy5inGSG5C5almZi5cmEqSJmTV9iw46nlxN/HMrlVoeuyR6lX+v3fdVMmSlxDZ96V7MDGJpFuakwoih1QbDNQzUBdIFcoqOcGHfQn06rdI5N+YdIG/+Y5B169Au811n5p89IonOL9WQZ3T5k/cKNKrd9M0gcbhGvL7/IZevSsBj3a3Uke+Fockp2ggwfvgpw5Mfiu4Zt/C3weq3Sevt6LrlYQcu4EzkhKcLuFlLE+wg4rgivz7q0wvEHOI0m0y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(53546011)(6506007)(7696005)(122000001)(38070700009)(9686003)(26005)(2906002)(5660300002)(52536014)(86362001)(66556008)(76116006)(64756008)(54906003)(8676002)(8936002)(316002)(66446008)(66476007)(66946007)(83380400001)(110136005)(82960400001)(33656002)(41300700001)(4326008)(38100700002)(55016003)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AK9eXkrSaikDY7Dk//YKXypgiUWhNZTXc3TK9Yzckl3ccFlp74J7iJ/ulRu5?=
 =?us-ascii?Q?9APAieCTIaxDgjwubKwzNn8xC0K60z+X96deJCCH3wGxASeNBPmYHIxMPkAE?=
 =?us-ascii?Q?U0waDwirmpAseB2b9Z05i+wofXJyzYP9haQ4D05L+X6U0GuJbGQPuu0NxX5U?=
 =?us-ascii?Q?KhINZ9HBGc3Nnh749LCpYl+s7FKIzAzbpFwCAPRooA1BjIw2AWPAW6WemnmS?=
 =?us-ascii?Q?MGfO4ry3AAnUd0eByqN3tAd2EY5jaHj6eeMPeJGwnP8zluaAfonflvaP/mR4?=
 =?us-ascii?Q?LNzqOoEFtbDYhIDC8unXIlYnqIu6vBF1v76VTnh+237BEU8i59mChBnR7yEm?=
 =?us-ascii?Q?r/90n73mVIlTU8H1Q7jtVZ5U5gG7ht4galbwB2idXG+VfnqDDCegMsX/owDu?=
 =?us-ascii?Q?DnyiX1CTrms8xMbvy8u0AyCzMjnZTSBvmzeqtKCgcnCFDOSfyQOrY+DWjNSZ?=
 =?us-ascii?Q?L8ykfizWbe5Ug0biHyfSGxLpZg19WjEcOtfy96NRBCxzjNPSRq+CKuBXzQNR?=
 =?us-ascii?Q?64uuSmpS0jbj1ZZn0PK78og2rhXB3fwmaZyxP3uIwf6kBskW2L/1kFP+HtdR?=
 =?us-ascii?Q?R8R26GYQG1iaMz8IjPYeto9ufi2s9i9NwOyMgwK0YfKmSVbvI5cZmYZ3rpDC?=
 =?us-ascii?Q?ojge6Is9Z0x7b/dAjmXq+emGqgFL5+vP0JYGEThDdHyx+rN1FfkW6CnXX0Gp?=
 =?us-ascii?Q?hHsLaEut/YN9Jpd2Gxb8TAXFUIx/+/4I4A2H05XfgOzJuGyXttpQ3Sd8YVEX?=
 =?us-ascii?Q?miucOaaGV/tNNx/YfG86+3Nl8nb17QYUzQ0ScuEaD2b1aYzQA8GhudPBkDFN?=
 =?us-ascii?Q?Pnzd/qgJD0PJEqy/AhxT0FjVJQMpzdQnVrJBxDR2I6NvoR8mKjPi/Kcdkca0?=
 =?us-ascii?Q?hsIIINF7dFvIqmIfUCx/zgT2nZf/zS+JNHv69rt5HlcBSv2GOSZ6lNi+/40g?=
 =?us-ascii?Q?LC2Eb25sJkR6AzEFBxUfRlqYFeTEUeqDJ2x0CWKk1sqfk/fKIOfHeJUyPs4a?=
 =?us-ascii?Q?IY3Ba3r8aKxPOMuuk2yLTmJkxyJhV1CWgMavZ0CavJwrfBDDs5kHmG0HYxL4?=
 =?us-ascii?Q?x5dBeU/UXn78u/vaAC9YbmiqfrEeVcEt8lFxwaU4PjJwtoddEUO+j6Hi5uXp?=
 =?us-ascii?Q?MdO4zJQmaYSK5BxP/ZYiEAqG5hbbCss/mTQ/ndTHhIiRnESqHeaVLQUV5Bu6?=
 =?us-ascii?Q?uAOhsSk1RYY0cM0ZNIQumPK8/umFisdydmqGbXy6zJGQOXphBYY8dZzO4Nf1?=
 =?us-ascii?Q?DeQgwAZE8LCCARuPj+YbDjCMKzcXzwS7ltt1mHy5tBHvoNhZZpVfVNl5firE?=
 =?us-ascii?Q?In+xk+y27OtTWjWYPAXgp8J00PCnK+zNVGaUzucilcgwQRivg8Ebb4gn+yWM?=
 =?us-ascii?Q?WeVuOAvHeYGtottPCIWCISwc5MaGRd70DrGQQLABIkPfbSajwASOxeLFSGBN?=
 =?us-ascii?Q?9XXrRQleBl/SVumun0CTTOp7xI2QChanm3040nNWUdV5egzn34175T0qgN7Z?=
 =?us-ascii?Q?17FAZM4BjV8IjyOmUwm8QEPmM0A4Fc2jrFNQGaYK0H+ac8p70DgJVOg4fspN?=
 =?us-ascii?Q?dkERg3+3s1/LI3kll1rVm2NmgYc4vE0gtj6eQeOCeQ8yqu7MkK319Lm9rVuD?=
 =?us-ascii?Q?sA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b7c5a7-61f1-42c2-9bc1-08dbec2a0184
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 13:42:16.0755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2B00MoelDrDyEwJetvk6+l24UtVeU0IYEEAVa32R3LdD5THG+efWreyvWsYDP9PSXxuaZF+30MYyHngRYtWAkdGQ7oLqtBIyDCgB9gDkEpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5462
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Petr Oros
> Sent: Tuesday, November 14, 2023 11:35 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Drewek, Wojciech <wojciech.drewek@intel.com>;
> netdev@vger.kernel.org; Brandeburg, Jesse <jesse.brandeburg@intel.com>;
> linux-kernel@vger.kernel.org; edumazet@google.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; kuba@kernel.org; pabeni@redhat.com;
> davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH v2 iwl-next] iavf: use
> iavf_schedule_aq_request() helper
>=20
> Use the iavf_schedule_aq_request() helper when we need to schedule a
> watchdog task immediately. No functional change.
>=20
> Signed-off-by: Petr Oros <poros@redhat.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> v2: rebased on net-next
> ---
> drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 10 +++-------
>  drivers/net/ethernet/intel/iavf/iavf_main.c    | 15 +++++----------
>  2 files changed, 8 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index 6f236d1a6444e8..6b3d3e54b8b772 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -1445,10 +1445,9 @@ static int iavf_add_fdir_ethtool(struct


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


