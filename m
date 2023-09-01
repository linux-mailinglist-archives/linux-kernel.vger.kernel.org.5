Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845F978F75F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 05:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348208AbjIADJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 23:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbjIADJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 23:09:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CE9E7C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 20:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693537765; x=1725073765;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+UcENmcEBBZMEVzJHjNGnx0t8bLgqazdbIxw4xeGa8Y=;
  b=UKKQAmXdAnQ15MfGE+9lVeSdTVTA2yFx8gQ0j1SjvpgqqC4tAGQ0SKhn
   xCKZvgW1R1vXaIT56XBAfddNfVLAuf2Ol8EVmSiEOKc7txqqaFRdR03GK
   YQ74LkcX1Ad9NKbQdxfJW7HYf/ztb50UROm4kOEkq+CXZE7u9FFsF8wOz
   PjGF4DXgjSYpLwpJesTZe6xjzNMG/3mXnNmFPt1MtgjQs0VWofbO4txie
   4vkxZyjIiva225FQxXXhJASD5+vO9la8I+p2RhgxW1aOIAFXP/s+Ei9ey
   A+qAvUIEBxJFfS7WoZbdwMBvQ5Xf7lBeW9vfieqn1gdMeAYeNzZqYyoYr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="462486216"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="462486216"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 20:09:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="986493965"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="986493965"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 20:09:24 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 20:09:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 20:09:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 20:09:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8/uUSN9sz2plt40uQP0yvAPoVJ4Zz/dlqsyxT1NSRFwqFDAMG0Wo8IWp1oJUw81akXgC8BCAO3tWvIVs+XVvSvFFqQRKTMT5MYUmQnlLFHpVOt126pbhRO3voNVm9V3y3trQOf0Vnhrl3UHh5BqrTTuRMg0OscwY9kWtgASMD9XTarl9RAzA4rGZbk99bOZbTByp1WwhFdcFHPbyG9ITzCAV6SL0h9eyeND6wx/QNcqXkHOwxgxonOBGDWuWJkiSj8qFLKX70lBE7LpRoUiWjsA1OqG6S+BglfFhMA+OXjI48pvn8ru+yZhjzgaQA6i0RZ2+On4Ugd9mushlGgVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wn5W/dEDZoERI97KyfD/5RgJ5pyqpjPj9E022/A+E98=;
 b=LxDVd7vcz5gi6tp9zkxO/wtpG8ssuQm7kEWlIELsCRiWAPIJW9ipluH3GTsJ/sLT87EIgJ3DXwP98KvgzHMJ91Ptav9k++VmXuS9bIjuPQ/JrV+vIPwAMS/MhFoM4riaJvd/CPX6KRWguAXTu7w0D/vrRSQZYxErLiFvb2BTYb6LevF16CchTUU/E9ZDaI/6VbjLfqoVmHDTQNM/EHoTAvXp6UMKwtCQy3TQQ3fHhEYmdkaFX7nc59vHxpy4hmnDXbQtqx/nkYsNpg8QqIgBJmX6jse2htx6pqZJFySpDZJOpipz7NPz7XTSgM4T2oy47SmAYmegKBNPDNoN1S+6Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6010.namprd11.prod.outlook.com (2603:10b6:208:371::11)
 by MW4PR11MB6740.namprd11.prod.outlook.com (2603:10b6:303:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Fri, 1 Sep
 2023 03:09:21 +0000
Received: from MN0PR11MB6010.namprd11.prod.outlook.com
 ([fe80::3f6a:413a:ffe4:7b5b]) by MN0PR11MB6010.namprd11.prod.outlook.com
 ([fe80::3f6a:413a:ffe4:7b5b%7]) with mapi id 15.20.6745.020; Fri, 1 Sep 2023
 03:09:21 +0000
From:   "Brown, Len" <len.brown@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: [patch V3 27/40] x86/cpu: Provide a sane leaf 0xb/0x1f parser
Thread-Topic: [patch V3 27/40] x86/cpu: Provide a sane leaf 0xb/0x1f parser
Thread-Index: AQHZxSuNHqTVYruCfUiH6AgMgzkGq6/mYcAAgADEZgCAAT52gIABItGAgABDd4CAACAJAIAAH1qAgAGk5gCAApuqAIABPhYQgAUg5wCADZfPQIAAse4AgAJ9nUA=
Date:   Fri, 1 Sep 2023 03:09:21 +0000
Message-ID: <MN0PR11MB6010E31577416B56B708A3AFE0E4A@MN0PR11MB6010.namprd11.prod.outlook.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.258937135@linutronix.de>
 <8e5bbbc91ff9f74244efe916a4113999abc52213.camel@intel.com>
 <87350ogh7j.ffs@tglx> <87ttt3f0fu.ffs@tglx>
 <b8637c8c92751f791bf2eae7418977c0fd0c611d.camel@intel.com>
 <87il9hg67i.ffs@tglx>
 <MN0PR11MB6010CB72411BA723BEFC5565E017A@MN0PR11MB6010.namprd11.prod.outlook.com>
 <877cpxioua.ffs@tglx>
 <MN0PR11MB601007E7DAE4C5FC86E58DB0E014A@MN0PR11MB6010.namprd11.prod.outlook.com>
 <87fs4ighln.ffs@tglx>
 <MN0PR11MB6010D09FF7C20779B70A3B83E01BA@MN0PR11MB6010.namprd11.prod.outlook.com>
 <874jksher3.ffs@tglx>
 <MN0PR11MB6010F1D501B9A2C0B7B3D1F6E0E6A@MN0PR11MB6010.namprd11.prod.outlook.com>
 <87r0nk66xl.ffs@tglx>
In-Reply-To: <87r0nk66xl.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6010:EE_|MW4PR11MB6740:EE_
x-ms-office365-filtering-correlation-id: 8032c6e4-8d5d-4cdd-32da-08dbaa98d697
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8GCPgxsrnip5X6Sq5TXrKUPTDEhi5Bk1Vh63UM1xsN5v38XLqDqhIA5VkFkisty8+NIgC73it9PQLAr01//M4eFmOiN7kWvV+Za8aO6lz+Cuiaq4y4wxFWAaTDS/KO5UwEW66kOm9lPKiVm3z1vI8neC8xnCmOMV7+0UjmEY7+fbatukAv4yyXPDBLnf+QhellFN/vKLF7IauoIDYEf0Xouu06JQm7/A5BsOZwf9goT1LMBhDfDJ2ikDFBEMjFvWOEdawLjEjhMYxKNoKu4vP1Zjgm4vCV5urtaBfX149w1i3qFnS+qspykTC2LJXmFEYguGl1r6AZn6QFsiblALfUEngmkE93F3THjVUpILmOdEuxAbt9wejkdylIqBHP/JrXXdwxBUawcpPwvwxDuXvJ/lfAYpvE+R3CeKR/1HwXdDY061GBdRSh5PRvFRnHkkIfx706pzsMqa1cyIN0Awl2a/M9prttu4ueci3/oXZg3h5vZQWy8wa+VkMy5QYzg+CBYdNguVrpdvTXpfu7ewrrRAb9Uqs08M5/YzflsRaKTR7CihyXrKCNUI98ANV8c1CL1lzlfhUavC4hsTGF+DksQYK3xFQGxMhtqpTV/4hOc2fJfQvF6KywkQNZhP0Ral
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6010.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(1800799009)(186009)(451199024)(9686003)(38100700002)(41300700001)(38070700005)(316002)(66899024)(82960400001)(4326008)(7416002)(33656002)(86362001)(26005)(83380400001)(52536014)(5660300002)(8676002)(2906002)(55016003)(8936002)(71200400001)(6506007)(66476007)(7696005)(66446008)(66946007)(66556008)(54906003)(64756008)(110136005)(478600001)(122000001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZRawO7vDSZgYw7PmpM+G3gYg9uOAP0Ha101DTQzJOKhkiOX675XpjmlXAUKM?=
 =?us-ascii?Q?Jv9aFWzlYFFqZTg1+NyATKQXmdBcUczg1cSMmig4b3iNFXh1bUXR65r8X54G?=
 =?us-ascii?Q?EkQf1Of10ihVKxbMQxERow46dLxozFy1m/hsIL0ESzZeyZTmt4Lz0QRpmvc1?=
 =?us-ascii?Q?J299Z7zMf6fv2abJzRBQreTiP7yqeXxgHQTdR5aDWWYg412WQLhNn+b+oSip?=
 =?us-ascii?Q?of5Ip3zJ0XoH4xq/TVpVcCf9ZWweQSm+6PS45btu328eqKATwO8XKzyqc0nj?=
 =?us-ascii?Q?54jXUZIysF3veQwAk/qXu4GLWpmCZyJEZBBAH6w2/1+98GPI3+guyjE8GJH3?=
 =?us-ascii?Q?fUc8FSZpXd3Cy1JM4RxJ94vz1+PuSrrRpHRZBoIXEPZUFPw4YklrmzA4wepT?=
 =?us-ascii?Q?Ft/QVWN6PN0ko942MICINopi1QhvfWOGuUsj6Y378bKOsGl1PS+/PdzBVwm8?=
 =?us-ascii?Q?a6ZYTo2oD1wInGWwU63UM57uT08M3LnVtWYg/YbdQ6mQFKv5hRXrRd8/6iq5?=
 =?us-ascii?Q?E/EKis3jlKT/EN+gAS+eyIlyL300MjLx86HbungW2i1GNLq6onLKvpM9rq0p?=
 =?us-ascii?Q?Zfd8qwFXIOoiAnDPZqJeRwBtHVTn2Ncy2OGN0bJzNODSgpqiKIATs0dfpNXF?=
 =?us-ascii?Q?dQxqHby3/jEzWgBhtIgsp/sZI6kyIK0m0wajuDyMIHh4XqK1LsNcvFCrG2Pq?=
 =?us-ascii?Q?UeT1vzhk+AMg2CC9O5VIgywyYgvViB/YIcpf2xk0wdyxOi4ujQb40OZT/qij?=
 =?us-ascii?Q?Y2n+qJOYC3bme+tTFGuXX/TkNBKgpPDk/mWN/cog1R7sUYBdDqMMBLf2D8Pl?=
 =?us-ascii?Q?H4hnhZ8b7k53zC3WXYwPOsq+6l/Mmo8rTdcAmyjFAFVPHKAyxjzUbn9pxVeH?=
 =?us-ascii?Q?FGxi8OoBwZIGLIzrRAAc6WkldYYTw15AXFBZbDmxhts5qzgWgVqBfaX+MYDV?=
 =?us-ascii?Q?BrciQ9LTiMGH4VRqkEOkY4kU0cwuK2CXsv/zcz+NMvHHmYarrnzzi97Q7MgU?=
 =?us-ascii?Q?I60uyUqoWzMcApX/PBcUxtn7XOT7Mja/80bHmt/oe5LkuXQfrfOL/iVy26hh?=
 =?us-ascii?Q?GFCUKn2e3RlBQweb7UeA+iG6tyyAsfKwBfb33cw0HzRH7SdNPOtT1buoC1tu?=
 =?us-ascii?Q?Sft5qfNQJVcetFy9zwpKbY1H9K9yIdh8sWhZv3CTxpjmddRsQlnmU4TNlkvq?=
 =?us-ascii?Q?ILBdITOhfnOvxCZgb56eoJgFIOEfiIRFAXxANcfFu82gJIKZflwE+kBLaEWm?=
 =?us-ascii?Q?0yowQpGibBLeVtmCxCtsGs+HckEMLR0fvyeffWv9a0+bqxLL8ndmLq9HDYPp?=
 =?us-ascii?Q?lEjDesYi1iE1L6BB10JkTLWWxHJbIDfW9vgTX9D5XQFhDi8nL/SUUB3HAdGp?=
 =?us-ascii?Q?mMtQeM0TeMslVprhJqHWqjWDfqriUwoX/P6DOJajdwgR1aFEs+sKd3PYAIbA?=
 =?us-ascii?Q?pEpGSIwORzGGZQt2qAZjcKJ7FLTotVGYi+bs5MfJNuGJGR4gI0qqexk3AFId?=
 =?us-ascii?Q?aoOrV0hlaDAjX43CtpKEAGKWmoeI7govHgcwmbWbL6AC2LGFoAr0grZLsnCV?=
 =?us-ascii?Q?M4OyTaB2OvPm4DyLnA4gJs8rVQOFZrIf/ZQ6Z4u1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6010.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8032c6e4-8d5d-4cdd-32da-08dbaa98d697
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 03:09:21.4566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 67X5pnCfyNzcyhWkDwEqXA/gZZb5dhygwYTSfAFReMcCA2AN1dxwTxgwFYrWMrXw4rIspuP8f1KSslmFEM+nww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6740
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

> Conceptually _all_ levels exist, but the ones which occupy zero bits have=
 no meaning. Neither have the unknown levels if they should surface at some=
 point.
>
> So as they _all_ exist the logical consequence is that even those which o=
ccupy zero bits have an ID.
>
> Code which is interested in information which depends on the enumeration =
of the level must obviously do:
>
>    if (level_exists(X))
>    	analyse_level(X)
>
> Whether you express that via an invalid level ID or via an explicit check=
 for the level is an implementation detail.

Thank you for acknowledging that a level with a shift-width of 0 does not e=
xist, and thus an id for that level has no meaning.

One could argue that except for package_id and core_id, which always exist,=
 maintainable code would *always* check that a level exists before doing *a=
nything* with its level_id.  Color me skeptical of an implementation that d=
oes otherwise...

So what are you proposing with the statement that "conceptually _all_ level=
s exist"?

> The problem of the current implementation is not that the die ID is autom=
atically assigned. The problem is at the usage sites which blindly assume t=
hat there must be a meaning. That's a completely different issue and has ab=
solutely nothing to do with purely mathematical deduced ID information at a=
ny given level.

I agree that the code that exports the die_id attributes in topology sysfs =
should not do so when the die_id is meaningless.

Thanks,
-Len

Ps. It is a safe bet that new levels will "surface at some point".  For exa=
mple, DieGrp surfaced this summer w/o any prior consultation with the Linux=
 team.  But even if they did consult us and gave us the ideal 1-year before=
-hardware advance notice, and even if we miraculously added support in 0 ti=
me, we would still be 2-years late to prescriptively recognize this new lev=
el -- as our enterprise customers routinely run 3-year-old kernels.  This i=
s why it is mandatory that our code be resilient to the insertion of additi=
onal future levels.  I think it can be -- as long as we continue to use glo=
bally unique id's for all levels  (IIR, only core_id is not globally unique=
 today) and do _nothing_ with levels that have a 0 shift-width.

