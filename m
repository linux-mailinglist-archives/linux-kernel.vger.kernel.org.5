Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476697FE8A3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 06:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344559AbjK3FX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 00:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344550AbjK3FXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 00:23:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D8C10F8;
        Wed, 29 Nov 2023 21:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701321801; x=1732857801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wUYJTCkm2QPlFTcDa6v+bpn8h2oDeM+EtZ5XhgqU8TM=;
  b=bty/yCIprgfoETpGB4FBeg0yTGsGZF2SHj+PRfq2EHYzMuprEFLUTX5m
   WnN7JPskrIbWqgeIbz/YqWB+oLppi7ZobYW1MfrnEQZMn1nGlGGRbXQGX
   K1HHRfZhGtf9l14C7yQxhG8TSk+GabdL9iD67/c0oG622iusglxfwS2oP
   qgeqcCKjMwSiiuIvRKLJfoW5jxIbRBvuc+a+2g2ig1xOhcamcP7xYm5+X
   jbSV0vrqYVX4o+bfil26jaJud7JiCYocmsyFTar61xbiUKg/NkHWHN+b7
   MmO0e0qeT9aI8b+gY3S7vFunmABiaoUKutbxFb8ReFRrh51hivzeOpqjw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="150401"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="150401"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 21:23:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="719005203"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="719005203"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 21:23:19 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 21:23:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 21:23:18 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 21:23:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 21:23:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpPWwbXm1M2S5k+QsiOJwMuxJaqLg1DkF2MRW58AMygVRWBzPXtZQlkp2euz49jxaWsjYZMmB5Xuzjbha0td21d7/k72TGIFdJXuv9ZehE/lcYcyet/5RxIBORPdTs8K5ZgOA+0vm/0AQvR9LpVotY4DxNXin2CBIzE3ledkF9OgAft9N04mM1oYJvJKlalHT2E3xYVkJwQiQFI/nV0B/kwLLjENZXB3c+EiDdpx7XTXaVVrCqojC4Kt1+pYN40Vl53zBTmV55LrXV0Alh5YsSGg4FZOt1RZCq38GKRZ6rlmF3YcK4mu89HeLLv8M81c+anBEAp11Otibqy5LpL1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stGqdecBfNOF6BUsrPGkhmTixsCd+XGcSuSTIAQpRWQ=;
 b=I4qbRCkk5qEcNY3luMtltKdzBIp6IlYG5/PuwtA1WuS8awAm6m7Ns5B/vnQgnK7xJEOlLfZCN4FBMBeTK8PKxcXtGTIl213D//y0k2Q56zQi5pKKB5mRVNAnWWxYSXKAMb9EdZztD+c1Uvj5yTjele/1MaV5K+GlZGOZ4ph0YEiQI+8A3ydg0YnOh67BEbTo92NXnDnyIhM+2p6L66TQnbMhRRshSlQucLQ0+DktADpElMzppQDc5eHmb3nykojpBFRJch4XDOOR311Gqi/Afs5fy/GfdBpzG5wEEeyEdDprdcsQ69dw6N6IsPC3MRkJqQqbaGvwaPKJehIfl1ilcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 05:23:15 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f%4]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 05:23:15 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     ivecera <ivecera@redhat.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC:     "Drewek, Wojciech" <wojciech.drewek@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        Simon Horman <horms@kernel.org>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v5 5/5] i40e: Remove VEB recursion
Thread-Topic: [Intel-wired-lan] [PATCH v5 5/5] i40e: Remove VEB recursion
Thread-Index: AQHaHueeYIjUk5zw+kqX9mb8HYsqs7CSWzSQ
Date:   Thu, 30 Nov 2023 05:23:15 +0000
Message-ID: <BL0PR11MB3122061EBEEFBAD2726230FDBD82A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231124150343.81520-1-ivecera@redhat.com>
 <20231124150343.81520-6-ivecera@redhat.com>
In-Reply-To: <20231124150343.81520-6-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|DS7PR11MB6198:EE_
x-ms-office365-filtering-correlation-id: c2eeea9a-e538-4df3-1fb2-08dbf1647495
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8mvOxoFk5oX6IcN1MvlQbkFuNiyJTl62EPzYFsmnBZfYZ2y193ldfMDeCk4j+wRQ+LfzONRy11MmTA5CIH2REgLQQAZ7HdIY8kQWMbY5Kmy7H6SxkTOIlDTZk/xsnG3kV+HoiGrmviQFC2HFe4KD+N+AFDYvMSucNaHHAEFzkizs4zlGRD0BbqJ01s+BJ7Z6lV4Yb6dKbLtRXyXC1P4ZQE3AruCw8L3hfsICFSCZoutO4UhxYtTcpKpf8U8mjOD42Gh85XkARoCvDPTwFMlzZkldNATiZ93KMbHx4ereFKd8eURyLV2JBfiF3bCkWOfpYRt6FLLiNKDQ07XLtgThV8wUcvpt144Zuq9Ft2SJPlmQkidiB/OkswHoOALTYl1SExu4UoTiSsswZ+OfV+z07bi40x6o22QKYlEQlUInWs21oL8FQl9c/qcBuNFH+9M4jWYdXKetiOs6/9cL01D71tthYMJsO89Vuf8wIQWj+1ekEkeA0cHjsjyDRHZ8/EhmlstKjGtW2JPjeQSNOO9rrEAWJYiHSVTUIo0pSCOiAPqnPzkwQ2C+u+KTUX/sv1Tf8ixCGWYLsNhRkxibBkmTXAMjIpZ1a+V1t5VL/tOzO2QR5r994jKzXh1cWdgGJZx/iZuO8c4HYMVBUgyAUH1F8zkRZen/UI6zVRay51uF3b0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(478600001)(71200400001)(9686003)(26005)(53546011)(2906002)(5660300002)(41300700001)(83380400001)(7696005)(110136005)(8676002)(8936002)(66946007)(52536014)(66446008)(66476007)(66556008)(6506007)(76116006)(54906003)(316002)(64756008)(4326008)(82960400001)(122000001)(86362001)(33656002)(38100700002)(202311291699003)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bvOkU+0eZ5e5QVb49Mong/fxEwON3ESHdoH8VB0ylxZUVVSZ68lO/wC4gjn9?=
 =?us-ascii?Q?NB73cDn2OR5twj1ZTyhvYqoTYPm48exjoX5YNilxJ3I32pfW8YF+o9p4lak8?=
 =?us-ascii?Q?792soSbNVdWrZ+6KOuQc+CpzoGoFBgMMuo+uDerO6dgIt4mHMqojxRUyCeLW?=
 =?us-ascii?Q?r9qeX7Tg5gIkCTcKSpOCknf/zcHhEET4mXiEJvtOPEFsrj+MAtpyJ+t5lp1D?=
 =?us-ascii?Q?t77fMOkhWEOjbNahs/EZFBBq4ybsJ8xhUKrO7keVYwuo2l6lhP6iAc/rFskn?=
 =?us-ascii?Q?tLF198RE9VGF03RujcmpsztZXMWpiLdjfOzZOn6r0F7UcDbRD3Tr3Ci9NZ0a?=
 =?us-ascii?Q?jxKJSqgHhCwJ/hIeu8GwHmtB3wWjNFIIG9RWiVbshl7KYe4f1F09AMHtmEfW?=
 =?us-ascii?Q?2NhNdTD3HypoGsJsx2Qq8ExjOea+yV+ZSKO3WBbYEZcGYVTmfi/Jo/P8LeNy?=
 =?us-ascii?Q?dAvMuFtglOSPHyOWKg0E+4tgKPn6oibR02GOT4lagptkEKEdgQn6jaunrPZV?=
 =?us-ascii?Q?4cPu2sB6AWTf9R2FNTuRetBysMJpKY9qMVAeaOoiEHp9+dp4Zw0aOXZNhJgQ?=
 =?us-ascii?Q?/htTrvdWxMJMLgZQDYW+BMcOVQKjLlwwAW4TbajejHDHKW+18wGo0UnrEI4h?=
 =?us-ascii?Q?Sxua4cLfM9NvTMJMkLMfN9UEy1Qs3Dlliji8kqP3dkYdaWE1Y0beXnCcIkX3?=
 =?us-ascii?Q?n3Yg5LSKYLe0qPltdaLDI/UaHI4UE+rhf6WJEPXnDVzaUEj7oTAq0ZETSLEE?=
 =?us-ascii?Q?HPzwS2HPK3BJExrdPkIBRQzvfykALhcDk3k7mwWVfh8s9qQxN0yXzhiIvMlZ?=
 =?us-ascii?Q?gg8J6VuEEFj8dmYRpUiGspM2TcLM9GPZGEZgWF6bMrrfWebs5IoyHTnGl6PJ?=
 =?us-ascii?Q?tCQwJhu6dbaGjku+NnhKIrLYlBjiYuHqplzq0Wd2WiAm+ds6LKqGwaKMIAxe?=
 =?us-ascii?Q?hHGpYAagRRKm15QPgLNmxrha83wT80EG8vMQTtXupNOI5YbfuQ/tK92E1s3k?=
 =?us-ascii?Q?sWMcQ57B9o83fPPz4BXvkpFZ1FUFdUuSIVGZPe2xUB0pjI4aeXeYNtUmXTKk?=
 =?us-ascii?Q?yUIjEtnzBt/DS/Ywt2X+GdafD2hVOWQgOY1SWOL+crd5512XzSzGpzuLo8XZ?=
 =?us-ascii?Q?rxiFJVG29m4lC6Ko9mGTCifzieGisPBGJUWVaXQVCUO5FGfMVPmjj3LQNbHZ?=
 =?us-ascii?Q?y+SO9KdALbK1t48RHtgjeDsW12YOWA+oMXcnA9O/eX+BZEzsn1sXjoznjuvo?=
 =?us-ascii?Q?3cyed7c9cLQP5MiHckujMtzAqt+/K8r6psbVBLbahhUjdWOUh61L6RWOf7QY?=
 =?us-ascii?Q?hbT1zO59B9RvWx2HaGiIQoD1ha1WdV0eO18G6hx0T2fVI/7mSrqyRQEX+YNL?=
 =?us-ascii?Q?g6ex/xVhuYwlkjQB/WHjm8bMBQQkI91TAwD2O3a1tBdn/M/8oaR+s72NiPIe?=
 =?us-ascii?Q?8jY/7RQNi/HnscN4XlQ3P5bzWnqAZmP5UAl074Ah2cIveuHNzy3QkeYvmkBL?=
 =?us-ascii?Q?S2KfbCpUcXwgZm8rpsS1ntMsTP06lnRzi9Og0eLxnRS7lrgRhGDuLBgoO3B3?=
 =?us-ascii?Q?RB0PEqcHANop4XY+/3vFP8KS5nJ7WHWHSedsoBT7kp0I1GJ4w7XrxQ2CuAoi?=
 =?us-ascii?Q?zQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2eeea9a-e538-4df3-1fb2-08dbf1647495
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 05:23:15.7789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RoILynrAifCc3LuIsd+6rMwfXDuWIfdp6JuLDdiOGF2xLe0tLMhC2PIhKvv+DC2YMr4QAevckt3DYDcH4RNCq1gGavtwDbRknvnRBZwPKEqbtKWUA2jzln+mZe6lpSEo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6198
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Friday, November 24, 2023 8:34 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; netdev@vger.kernel.org;=
 Brandeburg, Jesse <jesse.brandeburg@intel.com>; linux-kernel@vger.kernel.o=
rg; Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Simon Horman <horms@kernel.org>; Keller, Jacob E <jacob.e.kell=
er@intel.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat=
.com>; David S . Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH v5 5/5] i40e: Remove VEB recursion
>
> The VEB (virtual embedded switch) as a switch element can be
> connected according datasheet though its uplink to:
> - Physical port
> - Port Virtualizer (not used directly by i40e driver but can
>   be present in MFP mode where the physical port is shared
>   between PFs)
> - No uplink (aka floating VEB)
>
> But VEB uplink cannot be connected to another VEB and any attempt
> to do so results in:
>
> "i40e 0000:02:00.0: couldn't add VEB, err -EIO aq_err I40E_AQ_RC_ENOENT"
>
> that indicates "the uplink SEID does not point to valid element".
>
> Remove this logic from the driver code this way:
>
> 1) For debugfs only allow to build floating VEB (uplink_seid =3D=3D 0)
>    or main VEB (uplink_seid =3D=3D mac_seid)
> 2) Do not recurse in i40e_veb_link_event() as no VEB cannot have
>    sub-VEBs
> 3) Ditto for i40e_veb_rebuild() + simplify the function as we know
>    that the VEB for rebuild can be only the main LAN VEB or some
>    of the floating VEBs
> 4) In i40e_rebuild() there is no need to check veb->uplink_seid
>    as the possible ones are 0 and MAC SEID
> 5) In i40e_vsi_release() do not take into account VEBs whose
>    uplink is another VEB as this is not possible
> 6) Remove veb_idx field from i40e_veb as a VEB cannot have
>    sub-VEBs
>
> Tested using i40e debugfs interface:
> 1) Initial state
> [root@cnb-03 net-next]# CMD=3D"/sys/kernel/debug/i40e/0000:02:00.0/comman=
d"
> [root@cnb-03 net-next]# echo dump switch > $CMD
> [root@cnb-03 net-next]# dmesg -c
> [   98.440641] i40e 0000:02:00.0: header: 3 reported 3 total
> [   98.446053] i40e 0000:02:00.0: type=3D19 seid=3D392 uplink=3D160 downl=
ink=3D16
> [   98.452593] i40e 0000:02:00.0: type=3D17 seid=3D160 uplink=3D2 downlin=
k=3D0
> [   98.458856] i40e 0000:02:00.0: type=3D19 seid=3D390 uplink=3D160 downl=
ink=3D16
>
> 2) Add floating VEB
> [root@cnb-03 net-next]# echo add relay > $CMD
> [root@cnb-03 net-next]# dmesg -c
> [  122.745630] i40e 0000:02:00.0: added relay 162
> [root@cnb-03 net-next]# echo dump switch > $CMD
> [root@cnb-03 net-next]# dmesg -c
> [  136.650049] i40e 0000:02:00.0: header: 4 reported 4 total
> [  136.655466] i40e 0000:02:00.0: type=3D19 seid=3D392 uplink=3D160 downl=
ink=3D16
> [  136.661994] i40e 0000:02:00.0: type=3D17 seid=3D160 uplink=3D2 downlin=
k=3D0
> [  136.668264] i40e 0000:02:00.0: type=3D19 seid=3D390 uplink=3D160 downl=
ink=3D16
> [  136.674787] i40e 0000:02:00.0: type=3D17 seid=3D162 uplink=3D0 downlin=
k=3D0
>
> 3) Add VMDQ2 VSI to this new VEB
> [root@cnb-03 net-next]# dmesg -c
> [  168.351763] i40e 0000:02:00.0: added VSI 394 to relay 162
> [  168.374652] enp2s0f0np0v0: NIC Link is Up, 40 Gbps Full Duplex, Flow C=
ontrol: None
> [root@cnb-03 net-next]# echo dump switch > $CMD
> [root@cnb-03 net-next]# dmesg -c
> [  195.683204] i40e 0000:02:00.0: header: 5 reported 5 total
> [  195.688611] i40e 0000:02:00.0: type=3D19 seid=3D394 uplink=3D162 downl=
ink=3D16
> [  195.695143] i40e 0000:02:00.0: type=3D17 seid=3D162 uplink=3D0 downlin=
k=3D0
> [  195.701410] i40e 0000:02:00.0: type=3D19 seid=3D392 uplink=3D160 downl=
ink=3D16
> [  195.707935] i40e 0000:02:00.0: type=3D17 seid=3D160 uplink=3D2 downlin=
k=3D0
> [  195.714201] i40e 0000:02:00.0: type=3D19 seid=3D390 uplink=3D160 downl=
ink=3D16
>
> 4) Try to delete the VEB
> [root@cnb-03 net-next]# echo del relay 162 > $CMD
> [root@cnb-03 net-next]# dmesg -c
> [  239.260901] i40e 0000:02:00.0: deleting relay 162
> [  239.265621] i40e 0000:02:00.0: can't remove VEB 162 with 1 VSIs left
>
> 5) Do PF reset and check switch status after rebuild
> [root@cnb-03 net-next]# echo pfr > $CMD
> [root@cnb-03 net-next]# echo dump switch > $CMD
> [root@cnb-03 net-next]# dmesg -c
> ...
> [  272.333655] i40e 0000:02:00.0: header: 5 reported 5 total
> [  272.339066] i40e 0000:02:00.0: type=3D19 seid=3D394 uplink=3D162 downl=
ink=3D16
> [  272.345599] i40e 0000:02:00.0: type=3D17 seid=3D162 uplink=3D0 downlin=
k=3D0
> [  272.351862] i40e 0000:02:00.0: type=3D19 seid=3D392 uplink=3D160 downl=
ink=3D16
> [  272.358387] i40e 0000:02:00.0: type=3D17 seid=3D160 uplink=3D2 downlin=
k=3D0
> [  272.364654] i40e 0000:02:00.0: type=3D19 seid=3D390 uplink=3D160 downl=
ink=3D16
>
> 6) Delete VSI and delete VEB
> [  297.199116] i40e 0000:02:00.0: deleting VSI 394
> [  299.807580] i40e 0000:02:00.0: deleting relay 162
> [  309.767905] i40e 0000:02:00.0: header: 3 reported 3 total
> [  309.773318] i40e 0000:02:00.0: type=3D19 seid=3D392 uplink=3D160 downl=
ink=3D16
> [  309.779845] i40e 0000:02:00.0: type=3D17 seid=3D160 uplink=3D2 downlin=
k=3D0
> [  309.786111] i40e 0000:02:00.0: type=3D19 seid=3D390 uplink=3D160 downl=
ink=3D16
>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |   1 -
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    |   8 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 176 ++++++++----------
>  3 files changed, 76 insertions(+), 109 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

