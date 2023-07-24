Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539CB75EE71
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjGXIzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjGXIzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:55:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60661131
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690188898; x=1721724898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U41ZaIdLWL/cxAnXhlkMzcbgHjl/ygt+ac5n92GF9E0=;
  b=nqq5WV8Swr5psdycZFT4KOPivKsbyfzZ5ZTJ1+RCF1UyqMxgJD2CxXOo
   ou5cU5juXk07lR9XO1cy092J9fhHWPDygag+tNIK/MQLtv6EzA7EFLnot
   slMn38pwMFZ0fTORW2edxvbOS7v81kF/tY9JCEBI6oaNa2qXtx8khGnOJ
   VbsCr3oSs2U3qWkigHW4RAc5l9kzfHmxksnyh41JpZo+AgqUSh2b5hkuj
   ZT0ufxvvs4T/kIdQsi6MLK/u++b15Sd7LPABajN5HLvnPoTtckiYbmEwx
   va0+f9mb09LUDknX0o+ywAz9MI+90+m8EV3HXYe29Aa6h48UtxqMR8XEN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="370056433"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="370056433"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 01:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="1056342663"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="1056342663"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2023 01:54:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 01:54:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 01:54:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 01:54:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbF40wLNOqiJ3fR1IbvFOLqmQdbv7w947HwMhF5R1xhySCVpWMvv2XYg9vuho5AZgCiGWLR7vtNyZqxSLreB9IU6lm4XRLOJnCCBUMyEZ3f3c9Kp+vN9GJYKFz4cUVuNQZ52d0noQoIkiT3zdwVFk+LaTOzHBBeWYE0uJjvAAKvUMuVHk40/KdfSudLvMCMZu06p+t8fZxFvv3k5IPYQdiYqZ8JxUzFelME1uA4gaQXqdZtrajwxW6A+lvVCOjockeo3s5EqVEPvSMwj0yNe8jDKCAvJmitrlZmM4TP8C9rEzkm3yFg31bji5zYe4+EgR4Ilkd3aFo99RiAT8jh01Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsAcqU7pFvyW7QTlEwyinXJkXXQTE9Jjxoyg4F3Izn4=;
 b=bj9WiEbYcJpxbpRG+n09RG5OWjjF13DUF6cihhuAVmujKNBZSW5h7P13nrfCZBI31Ok5EgMtnDMGzgGbjXWdR6t+8dTMYEEbnbcPE90xYEDvNzzvb9+3rVOPb91hEy+Hs/sCD3YXopX5yTAM+LtYklT6eltri04zqFszmwC0PqEsQd07MWhivLx8+jEpbPVJeqL8YoYUaFKD93ltPSAOX5/A6UyAzYeWwJKFKnFuYjn3hEzyRipplh+ANwBluvYvOpuGyQTeO1YbaSrACnfcRBijxPOI98VB9ZMMxA5mQjFVDZIQBvrykTRgPOUHft5BMYXtFjTuNhw5fu8jsJQYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by IA1PR11MB7293.namprd11.prod.outlook.com (2603:10b6:208:42a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 08:54:49 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::50e4:2cb8:4529:af04]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::50e4:2cb8:4529:af04%7]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 08:54:49 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Li, Xin3" <xin3.li@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>
Subject: RE: [PATCH] x86/ia32: Do not modify the DPL bits for a null selector
Thread-Topic: [PATCH] x86/ia32: Do not modify the DPL bits for a null selector
Thread-Index: AQHZr83AFvT4TTcrIkq3d3Abr5XF0q+sxk7ngAC/myCAAC0zwIAA3mCQgABOVsCAAAwbN4AAax4AgBlVv/A=
Date:   Mon, 24 Jul 2023 08:54:49 +0000
Message-ID: <SA1PR11MB6734633D2D745D3FE9A670F2A802A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230706052231.2183-1-xin3.li@intel.com>
        <87v8exgmot.fsf@email.froward.int.ebiederm.org>
        <SA1PR11MB67348D11385F584354AB84C3A82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
        <SA1PR11MB6734F3F72095C4D6B9C12C9BA82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
        <87sf9zfx76.fsf@email.froward.int.ebiederm.org>
        <SA1PR11MB6734577080AC6734E305D735A82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
 <87pm53e3ne.fsf@email.froward.int.ebiederm.org>
 <SA1PR11MB6734547F70FAFC9297D89F7BA832A@SA1PR11MB6734.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB6734547F70FAFC9297D89F7BA832A@SA1PR11MB6734.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|IA1PR11MB7293:EE_
x-ms-office365-filtering-correlation-id: 3230dc16-a48a-4368-e7b8-08db8c23a366
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ooRrtRXzFAo/RK2OhIFBAwgXlua2KG5jJ1E/q0YqFhLYJm9rOGZJZWCuvxSS1bi1hk02iL7s46jKnn7UEYtE1MIjKUitnQNNHBg3ZJYzh/KU9fJBlLePUMzlLh7BukPrwo9Qi4XSTCpONaYuuI3ya37FECTptomieomFtZbf8OnJ05cKWjYRAXr3bOi8tUUiV0NcLurhMyn1/MDa02FyvFD38b+GpRSC9QGA7WpXDp4qPTh3ML/LiPbE4BCtsDS2sD/pF2F1ab1GCa1mbLsut0kKHw7Qs6Y2rUncSenr4Dl4JyOnSt9FsfRKtLZxZSmo66bmF0819Co2iEChm9JstZEkhUDpHkUE9sWujIoTstJY6kEmqsQg+FbPx0p+z+HNHvENYtkeq0FeWnSlViuoWmiwJGjBLRJi+rJnn3yF5H7KtRGsfCeDj1xKSD9UXZEy1hck8lDwLyRQvJ2mi351cfTtQMFqhENFR3dEWXiRYm5jvMhKFYQkkST10MWtZjgZTBfb0rpyd2YvONsPDmQ967lT7KC31+4qLpVJ020BRs3ejm6UpQWsNM63BK1xUeqJLFO6Ji4b5jYNS20+CZKJCJHjeXtQ1e4u7iITZl4uLRQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(38100700002)(122000001)(52536014)(38070700005)(82960400001)(33656002)(86362001)(55016003)(54906003)(110136005)(4744005)(2906002)(186003)(6506007)(26005)(71200400001)(7696005)(966005)(9686003)(478600001)(8936002)(5660300002)(8676002)(76116006)(316002)(41300700001)(64756008)(66946007)(66446008)(66556008)(4326008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vjrjpjsIb9na+cZjpplpJitHEnbwYCt6iNgAI7TUhANpBkONCsf5CnE1L/Th?=
 =?us-ascii?Q?sdhdhS8ncgm5sh+1Rvv+bWZfzOrtTapm6/hK046HZBgTPYjjJKpE0YlTzaVx?=
 =?us-ascii?Q?l6TZVkZa9PKKm/0nNgyp1PNN1uST2yRQU9TP3oM8Vp8kMeivy6PTek1o7Yax?=
 =?us-ascii?Q?w4L0UjI7+dLKQG5s6rPhARmOEVSMp/h+Yb1+a46Aj9qiWb/4gheTcEsA6Yfs?=
 =?us-ascii?Q?msTMJVRzlsne1JvRhboFdd1BNf93OzJ+eYIz1FhHhD2oNiEfG/KbvH+z4VZG?=
 =?us-ascii?Q?GCne34WBAtpKXYnw5iGJ0jL1dU3BqwuWNYlDmglxfRdBlz3wGFnTUb23NaIV?=
 =?us-ascii?Q?kONRmOE/NV+prz07jXxtaCuJic909j4hIOqPO/iF0Ljca+zw0KMC7DV9OvHZ?=
 =?us-ascii?Q?Azzk9s+GsJ68JdMhgS39Lh/ycAAgV6bTPMYWYMvuxSRDmkVpxl8SbaTBqOt4?=
 =?us-ascii?Q?25iQtw/r8mSI0yJG6WZRbKKKkb9K/ddKRhfpukJmTS8iLccXVLRSnXgFfVRj?=
 =?us-ascii?Q?fkDnBJ6oNbVSaJm8+4B7vjAEzYqzzSwSXoZg8Nu5HCaZIHbGVjqxiMYmRMWe?=
 =?us-ascii?Q?mYJxGyhR+EX+uLi3gM3xHnU0SX/GxuoMYjn06Ulgzsgxe2Xa5ghda+Qckg7M?=
 =?us-ascii?Q?aicU0qu9iFFisFpsy+fIGGnNvpWGUeuzKjrkyl1gVJG0f8QVOTYKB2jdb/Tn?=
 =?us-ascii?Q?9lYJQPmuVVqoo8smTpmWmtuYZuvskRqWiSTjEuq7kf7ct4V3kBsVs4J/OUvQ?=
 =?us-ascii?Q?3RoFzy30YAf2tbnjKiohR8s8p/FuqPRe3OsGORPZ4EDqEfkbOiGvyoi0qEDS?=
 =?us-ascii?Q?4Xh1GDVBl40jtYxGqDpGeirlzhwiRwtioEqoCTpsDwXfbAkt6DyEzOn2/2Ev?=
 =?us-ascii?Q?vwDE5w6Qda4iYVCUMvABPanH5TwfZUoStI1Vl8aMLp8Bg3g/epBQIeUnj7v6?=
 =?us-ascii?Q?VIOd1wV+lnVJnJsH/la30VXxrLxNvz4v5FDaPyLuInsG60LaFOIAs16mbgBO?=
 =?us-ascii?Q?oLkPQfMUGm8TvKxWg6NDTF+zaptAAGb/2v2GOFOI1uFwP02mXh5DtWLAUbIw?=
 =?us-ascii?Q?3BfNJ2h5Jpx16N4wdT3XhshMyIl7xfGFM8+/+kanjbtbcgD/7y5dBWCjL53G?=
 =?us-ascii?Q?bKEXO7krsXr1+ehhKnWMSNJaRjHLvqTsvEaWL+reiNqnv5SUTYDCJcIMfexe?=
 =?us-ascii?Q?ybIiYKLquusGDcZW0u/z7LEFnYS1MrzNWf/LHVseQzmuBx5RzL9FN5rFMZ0r?=
 =?us-ascii?Q?oFhSwAu/norxN+ZJWewOzOuhgfF/VjSrkcfENeRjBOTVBWaWQl1peNjCzT0n?=
 =?us-ascii?Q?/Hglre+RlnXWq9smIpaJxjmGvJ+Zm9jmG4qZPTSuuI1CcSZ1Pl6z3xzn91t2?=
 =?us-ascii?Q?zDCC3oeLoqI7a4nN1Oj5CLQFbS3rxVboCBij3y0Lm2dUFtmi4O0r+sJCocmb?=
 =?us-ascii?Q?pmP1ARkBdPxkKOqbzWxRmJm6jmFFhDusFB7Iq0KqU6papRrjvYfNQn44U8lJ?=
 =?us-ascii?Q?UoLTP2aRE8bW/8UsvL2oJjNylWJdH2GRoYG1W0ABZhDfL0fcDpg+gB5JRdjH?=
 =?us-ascii?Q?3VuWZrylA9fBkUec5qM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3230dc16-a48a-4368-e7b8-08db8c23a366
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 08:54:49.5743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mr7nWOk/isCwpMyNWynHyDueVKfqgSgtLS3U0eFtNQ3X7cXOr/7qyGLEHoyXtdQR7JQXhc7zISI0FxBYxK/xkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7293
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > It bothers me that the existing code, and your code as well only
> > handles the normalization on x86_64 for ia32 mode.  Shouldn't the same
> > normalization logic apply in a 32bit kernel as well?
> > Scope creep I know but the fact the code does not match seems
> > concerning.
>=20
> Agreed! We *should* fix it in the same way.

The fact is that the existing code unconditionally sets the DPL bits
to 3 only on x86_64 (why did we forgot to do it on 32-bit?). Thus,
there is nothing to revert for null selectors on 32-bit.

With your suggestion to normalize null selectors, we need to add the
code only when IRET is NOT used to return to user level. Fortunately,
Brian Gerst just posted a patch set
https://lore.kernel.org/lkml/20230721161018.50214-1-brgerst@gmail.com/,
which makes the case whether IRET is used or not explicit on both x86_64
and x86_32. As a result it is straightforward to add the normalization
code afterwards.

Thanks!
  Xin
