Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42D8758E11
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjGSGqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGSGqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:46:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A621FC4;
        Tue, 18 Jul 2023 23:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689749169; x=1721285169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3HWSZPLfe63jyruIzncyGrTB6B69Z8qKP4a90FW8cBw=;
  b=TzujoLAWKLDEr9tbz05ssZ1mUS01Y9jxaG6jNCv2ggJccepOehKbPRDG
   0vAoDsEltPAMsGmRPI2L7euoO+DuTmCmO7lOv5Qz26qxzRNmSsH2SSpht
   o/SPaGkAsMPBO2bKFfmhecwOLX5flokO/BW9ngoZPpZK24uJA9+7OzE33
   vly8FKF8FC9XMU5W4ZfBGnRQTFlpkOg/uW0ZayxJDkhuI79KfXSSq2Cp/
   HEmbcG32qYB+MKLvNtpw1HrWgzOatYzobqZ5fwCXXp2AcsPL6Vfv69TfS
   LjhI30oALBu1peEppNwh8RxWbzbjwjEC1km+eiiZCJpRs+cBfO3xZvXm7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="351255985"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="351255985"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 23:46:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="727198267"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="727198267"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jul 2023 23:46:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 23:46:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 23:46:04 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 23:46:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioWSmCgrzkkjlf8MWrqh3GCohHpaJvJPySCr27FpHU/JRbZn2ffJkSqtsXMcapxw4AYJ3N4LGV02sZb7a/wnV1/dz1Xt7QhVw5LKd76HKFaQK6WV12LYqpf9O/9k193jx3txqERCWPP8S8YjpY6Hn46+Slpx7PXvbwfSs0UX0qAD6pDrKL6rYtmpGW7s+hDvJEeHZHRGpmKsC04Ye6Ymf5u+SGOpJHuYaNG2jNn47BLEbitq9m02MJNlUkR3Nd7VTXoQxnzkiioBk3lSDPKLz9rgcaZlUS7JXWZ1Z2V38WpRKsqzbKwWKL7m4OdhUc51ZpakyzOYPhnyyy8rNaNvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HWSZPLfe63jyruIzncyGrTB6B69Z8qKP4a90FW8cBw=;
 b=VXqnYxt+OlAajPxPEoS3csYrzVFaP06JT67YtR/ITPPaPo+ALy6Bk0g7VwGAfAAKh0C1+jEB1vbnbvjaPlBTGIUBfXInBc9Q40gzBvNlEMEXSZrNmXapnxEkOKjlMtXsnWDjKUHRFWjc1XkHLMFosW4glMfSPtATStpRHwoZvwEfuZDKYknBpBD3mgKz8NrdzFtz76BEzZiEFdHF57U0z4UPDYBXamYDBnse6QAtcgb6NINZcoGyXx4FpWxs3Fvd5v8mNEvHkogFOdCQldpar4OeirAjE4QOktJvMEEZ+cfR3VOgU8YTWAseWbORoccfUaUaflDUiNIWTh/5rAE0Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) by
 MN6PR11MB8218.namprd11.prod.outlook.com (2603:10b6:208:47c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 06:45:56 +0000
Received: from DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::e1a8:582d:1efc:dffc]) by DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::e1a8:582d:1efc:dffc%4]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 06:45:56 +0000
From:   "Peer, Ilan" <ilan.peer@intel.com>
To:     Rudi Heitbaum <rudi@heitbaum.com>
CC:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Networking <netdev@vger.kernel.org>,
        "Linux Wireless" <linux-wireless@vger.kernel.org>
Subject: RE: mm/page_alloc.c:4453 with cfg80211_wiphy_work [cfg80211]
Thread-Topic: mm/page_alloc.c:4453 with cfg80211_wiphy_work [cfg80211]
Thread-Index: AQHZt9Y8Drzo+t4D60uEaI2mUoJeL6+9+JZAgAE0GgCAAXycwA==
Date:   Wed, 19 Jul 2023 06:45:56 +0000
Message-ID: <DM4PR11MB604304FC3551BCD9AB13EBBDE939A@DM4PR11MB6043.namprd11.prod.outlook.com>
References: <51e53417-cfad-542c-54ee-0fb9e26c4a38@gmail.com>
 <DM4PR11MB6043088A4A65CBF124F5D518E93BA@DM4PR11MB6043.namprd11.prod.outlook.com>
 <ZLZHDm3mcxaLdvRH@503599e9be06>
In-Reply-To: <ZLZHDm3mcxaLdvRH@503599e9be06>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6043:EE_|MN6PR11MB8218:EE_
x-ms-office365-filtering-correlation-id: 4436cff0-14be-48ad-664a-08db8823cdd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8nPIZ1yOtbaIbdQySiXhxbv86fwelcELPfMpfzSROlOHj1ZzKWaaa2GQD7i9KaWANcsfabKwJe+1Wqg1y4fuQWaFO93OGyU/C6l/WFTT9jRbeq/SWJDJRPGMEfRJ7tvVpMieY9RjTD5vQGVvKP37OmgU4Oc2nRxXEx5ukZJQoYEwsSNOJFz6EhqrOWhOehuawTXvkA0TIMmg9/AAtO+aPEpLWUNBTJRmcuu7cgd53OfmLvS/S+hscEjxg0+3M9kz4P18O+/AWKLteOJoLCsW3ilnHUg1flgZjnOfnUfI3glw8CO1tSR8j6y147JbBaVFcdagReOQL5WRuU8uCb29UOKRSmMYCcK/HvLtI8wgyE3d+E8l/0heGSR5y+IOulHFDNwPl//kpJKCBPFGw27k/7u8sa7/mk6dZuexii+9709vf+L8Z6G9qx2vvYElb/TJ4f4oVr3qo8miHRKmhIi6O7mLYBYirTNX+iZsYJv+cLLIX0zfw3JHCDkKqm7aXG631HztnsmbJMW11xCyOqCkuHEfaXjVw82hMdhPgVQjuJttb/Si6H3Z9EiPkIZ70nGyCrORArnAHNK4xjDLq72X5Y8XoqCdmoHcnPAYxwDEdUZfJzOqr8gzDfZ0m+El8BhM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6043.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(71200400001)(9686003)(478600001)(54906003)(7696005)(6506007)(186003)(26005)(2906002)(76116006)(8936002)(64756008)(5660300002)(6916009)(66946007)(4326008)(41300700001)(7416002)(66446008)(316002)(8676002)(52536014)(66556008)(82960400001)(38100700002)(122000001)(38070700005)(86362001)(558084003)(83380400001)(55016003)(33656002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K6/p0Z2YgDVzxwwjciGS3yi8TPGzOA4nOVoyxauI2h0C1dog360MuHo9Wqo4?=
 =?us-ascii?Q?BYG7woo13d5etGxVO0FCf1+54MLFjwkbXBWeBH2wJeifY9jXdimvcxzvP7pX?=
 =?us-ascii?Q?dNnTtKt6dU1X2Lbt1Nd97Majqryalya+3ilGwPFEttp9obyVjGRcxraQcA3C?=
 =?us-ascii?Q?jrdGLv1b20nDWsrdci1wNVwCL2LwbNbN49pFlNJ07VSSTtY+u0hMjbv2cmiG?=
 =?us-ascii?Q?RQ0Cw2QVa7SoizOdsk/wMsYiFlhzib0PaFuul3mY5NC+yHLkMwNiij8IeUBk?=
 =?us-ascii?Q?WTvcjNPf0H3iwy1DKyf0ti/BXqWY5O+4F+kP+sPo3tdNqbc8sGVOUFFIRf+s?=
 =?us-ascii?Q?jYiZ5Zal5TMH91D+6G7S7gL2Kp1ZBdISgGB6Fv1m8nXzZIUPVqumkBWVtAb8?=
 =?us-ascii?Q?0cLCSZPpwcJxD3wjQLsEBUsJRdraTl5Y8mDz9LgFgQQOTS0ZOrc406RLZVdb?=
 =?us-ascii?Q?l8TIO87uUjeoTIHFrvKRp0sbON6MjxFB8yTfiJ+SsIFVbLppqbqulZuAzgse?=
 =?us-ascii?Q?70xfOW0LMKYYluX4jIfqvTPIPXbQebUXzTqB5fD67EXarJDQdqXVGhMM5WRg?=
 =?us-ascii?Q?clWxYUxvt+DTvsMwdQv20pwywqeDpJjd/528eNNqDRUrjT3fC5uoIxUxPXJO?=
 =?us-ascii?Q?qc+gcg6x4sUcSrFeaB5o6Ys5YycUFzwFK4Cvb7iMr+9qDuhQVQZuA658yiD8?=
 =?us-ascii?Q?EPJEVnHf4awEoyWYfBz5sire4pol8oMQnJjI5YCQNe3gdg8SQwK88SfUxcOZ?=
 =?us-ascii?Q?FegyaLvz8w/15n+OlJwZU9g0PD41ekdbW0zj/qW9I1bXKD3moOXkQBq76Hv4?=
 =?us-ascii?Q?AO8U2VQ3AqOAW9WrG0Km3Yr8YpFxq3dpgmgcTasfdfxs82PpRBUDqmk6VzHt?=
 =?us-ascii?Q?6vm+nH+0N+XhX104cmFRmvwIZmpZtTKaSWGYpIofnUYdCT2yYvio2ZIMFgvT?=
 =?us-ascii?Q?dwLPYE2wmZWuO5OdH8Kc+5fM5qwFSOz4QjGQ8doDq3B0vs5v0PUq5DUYEHU/?=
 =?us-ascii?Q?Q/TDkaiQmbu0Z6G/DMJpYw+B89aSsCl9tFU3lYMIeBZuOkv9GVaj33BKUef7?=
 =?us-ascii?Q?RgDu3NspCB/kTCG77KVvso3WG0SioffqZ8GZ9txY4iosqkGIlBT+kfYOQq5I?=
 =?us-ascii?Q?rJFQVHxDxL1axv5E2njqJD8rX41NnyOOwFDGVWYg4Itl3qkHF4Ivzl0HQR4W?=
 =?us-ascii?Q?ydDw3AZtFupD3XYAsqeyILm9X1xjyOwmbQ2rTeHl4jrWqRzPG9qK7dxbdsSw?=
 =?us-ascii?Q?GqrVSerVNeGw+rlI2e8uTY6zooqmKIXGttas/SOA8dG7oU3tUHXeLapA8uBQ?=
 =?us-ascii?Q?NhGtuNZfNnw3Ni7RfREH5GiX27tL3Ir+lf4Qakz/q/tAHqzUYj/7IbVSR0Cj?=
 =?us-ascii?Q?KTV6zv2RpuabxyDyJLJa3gwFuEN8NPV1C9yrlCQEWodTdC1HSV+zCVceS5zI?=
 =?us-ascii?Q?knhcoOu6P/TIPu0ADD+Hso6it31JB9DoHdQWSPmkAhbZmVTymgC2tc2R3hr9?=
 =?us-ascii?Q?Df+KnO6U/AHyo7veiQNRrooxI2uA5mJG3lNAmdzOKE8ZjmpXt+Xw0JsGROng?=
 =?us-ascii?Q?DXQZgh+6Q4NkIbdtWAU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6043.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4436cff0-14be-48ad-664a-08db8823cdd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 06:45:56.1502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hjDCpoT1v3qahUdEZBnu/QGy08ipTsSE+NW02BC7jyP52wEgoktQd/IcyXqk1JmSr4nIx+r46y+bplWfACXSSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8218
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Hi Ilan,
>=20
> I can confirm that this fixes the error in my dmesg.
>=20
> Regards
> Rudi
>=20

Thanks for the update. I'll push a patch to the wireless mailing list.

Regards,

Ilan.
