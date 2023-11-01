Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DAC7DE694
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 20:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347364AbjKATx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 15:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345631AbjKATxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 15:53:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D585119;
        Wed,  1 Nov 2023 12:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698868430; x=1730404430;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M9xVc4RU+I+3lt8fPQ1rra7oPUQkh/bproxiAKQkZww=;
  b=WfKHAKElx0rAmOyxqSY+7XJhGAwe53bS8NWEnTxqFaQ8w6lX06KKoTn8
   XvW/7bZYVsdLVhZgVRXSgEk+FKL/8v97w0S0ssNwcRfpC755NyjP2geeD
   3FVSMJi8rfXAT+E/g70nuAfzarxDsRUz9T0aBwmqBQFoK5aJTUqywL9N0
   qEbTFdDYBOyD9V3bTAh5yv93juWTevceDCUGUnMam5cMn6QDov1Ga5QVD
   1NGxVWob5IImbpfkPouuH4B8me5q7d1adI2BvtlVSsbPn+XuriKFYPoKv
   z1whL2z2DcZ/Nq1WQREbXNo3pqm1Zu01kkUC5boZUsMVTng6B8mzhA1ot
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="378960535"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="378960535"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 12:53:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="9151150"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2023 12:53:49 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 12:53:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 1 Nov 2023 12:53:49 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 1 Nov 2023 12:53:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWfDnZG/gdG0LldSQMU7uXc+s0WUmj4Bp7yIuQprl1S35+yhZr7HssEgaaKxmEDQdmzxTiZO/UV8xJPwGqVpb4rAPvV4IdhjbZ+EDimxGDNnoWN/uFlKtpn3e3Isl6OAgOBb9BWMPI0ROjZFf0K9hO8aXEXgcATUgQh8jIAUDJW7/NoeOcfLT9Oow8/53etQn0mpsVMt3UZP+wklrHsNSpn1Zyzo1kn/F7onLA065LlkjVbb4UHa2aEj1ab12XhbCApagNxxXqWeI1kB5x4eecepyP5AGBRSeXwfRr/WDsOqaKe70jE6t7VQ8MHvK3rvQlAfDJP9giJguGtFXMWbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9xVc4RU+I+3lt8fPQ1rra7oPUQkh/bproxiAKQkZww=;
 b=E9Uf0XBMMYy8SnR113a6Mu+quJSJQnz2vO+HHwqogmBsLrmySqMc0P2PoOfGIsg8Gg0vPr+m2BDimqwNeYAQKVGo8jT72kpcQCWkwOER7BEyWLcwQ3WRsew75cUjAjJRZkKbNfEwYBoNDv7JWRa/KRCAH7qCTAThJkJP0tCM1yr3blI2i1vGIcE+Zpst2DJ0EGuic5GvVcY4ff8+D2sEhRQE5DD/LFpi1yrRrIEvbDUHFextBQbhumSYEltXTbaSAh0kxVUmmyzwiRFko753A36oJ+lZ2oxPJ4CdBy+/6FA8fa7Jc5CFwBfYIIuP4LJdNZKqJdS7QPbyHSorwv4Pfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA0PR11MB7401.namprd11.prod.outlook.com (2603:10b6:208:433::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 19:53:44 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%5]) with mapi id 15.20.6933.029; Wed, 1 Nov 2023
 19:53:44 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v10 3/8] x86/resctrl: Prepare for different scope for
 control/monitor operations
Thread-Topic: [PATCH v10 3/8] x86/resctrl: Prepare for different scope for
 control/monitor operations
Thread-Index: AQHaDD+m8/venzY3sEKkZr/G3i5JJ7Bl4TZw
Date:   Wed, 1 Nov 2023 19:53:44 +0000
Message-ID: <SJ1PR11MB6083401EF56E9AED2C8245A5FCA7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231020213100.123598-1-tony.luck@intel.com>
 <20231031211708.37390-1-tony.luck@intel.com>
 <20231031211708.37390-4-tony.luck@intel.com>
In-Reply-To: <20231031211708.37390-4-tony.luck@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA0PR11MB7401:EE_
x-ms-office365-filtering-correlation-id: d27e9ca0-c936-4e5a-540e-08dbdb14411b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lBQR9A5Sy2+xYX4YyxR7hhscQ6w4aqW4N0a2BzNK8uwOiVKwS0F0IvD2GbPI2GRCsmAKz0LMCFEl7hoHVIv6CwvXyatZu5zorsDgdluYnc9hYP5EotqunW3UKQyVqksoNYft+Se4z1ffmGnnKsGMHnGhWv84UxISJyr9jLJ7nqoPxNzBSkJbUEPvCkHUoiuB6PTzCTCvqOhUQ3hXSPS04d26yYDmZfjNK5Ur4BUYwWjNbNCaE5YQHv6Vml04DhBW/5pstl/30fXq0x0lNg4OGzWjFT0NEZAx4KODX5ttd1EljhLTyR+3m/cbB8GgKEqkIO/sEEAabEYOfjQnDA1QpRzljyHMCDO+Bejzt25bopxyFV42wctcVnbvXrb2+KKHg7PUi67C3peRee3K2jYfhJEHJzbEWx0yn8Ffimp4kBzY3n5D9v9P2kqPy5SxXfofam1YwD6m8affZpYfToA4Eerd4D7iOc8ShFOGVEsXEpU6DSbUlRSWaSvAXrUUb2GiJFJonaz0RAtKYzenbqyYunPkr2NS75hBZyiuvYa0m8o/OQk1qVBUcTa2Y37XC8EUtg278/G7g4dJ6EZ8sQZ/ZF1cgp/PdunQmWNQWWBzLic8T9cQGDEZftT4Sdh9Ka1w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(478600001)(26005)(9686003)(6506007)(8676002)(5660300002)(7696005)(7416002)(52536014)(76116006)(110136005)(64756008)(41300700001)(66946007)(316002)(54906003)(4326008)(8936002)(66446008)(66556008)(66476007)(38070700009)(82960400001)(122000001)(2906002)(38100700002)(71200400001)(558084003)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Tto3EWlmJsYdRkLmSp1tChcziq7146UyRbw2jlypO1dSKcwmmtCOZuiGMxe?=
 =?us-ascii?Q?KRBRMXXY6rSQBtVoQGDdxfph7dYj2mx4uh5czVHmf2+ozarw0LkSRfRxfShC?=
 =?us-ascii?Q?O5MI+A1qexZPVaS8kJa00mMBfUZKUec28KEHS5aUf9ChazOt7L3vS9rhqoGL?=
 =?us-ascii?Q?H/xj8FMWrMIH5w5/ZxwIhg70TjKyGC0VU52GGvN7xkU2U8ZmbeOtACe7LDUn?=
 =?us-ascii?Q?L53ErXdITCjZqRK6PPEkW+WNyo2F4ulHsiWllUEHjVQ0AjPiJaXQEgppFmQx?=
 =?us-ascii?Q?EdM/qUCo42+xvJ2+vPaSoMxPx9SElWSPCp5TUr3aRUFuE2UhzQDbk+pJ0e9E?=
 =?us-ascii?Q?sMIlZ8X6mDRqBcWHKD+FlJlybS8yJpcDgAX38nnS4wYxSVLRCpUG1KFfRpJU?=
 =?us-ascii?Q?ApqXCwabReGjaSxIUwMyeWW0qWetiNvwEdfY2XIoxm6sdGdpR3I/xWqdNsvc?=
 =?us-ascii?Q?xw9xA4QkpRr53IFcYt3ZFacQWxrpzNViapcP77FT9iENmvZAWCs5du8o6LOs?=
 =?us-ascii?Q?YBacWrureXw/8iS3tpJ0LjDw8yhWoKpHbtpLU25IVjdoczDLGk/jDZlTsLM0?=
 =?us-ascii?Q?ZiLJYyfY/fnco0tD6BHsOzHSyhgK7S649m7pHqJPjHi29iAfnDj9ZADCdzE3?=
 =?us-ascii?Q?/uZxSyw0263AZKYQkFiGXpb6/CxwtKOMCyUIdL4Vy2UUbipiDho51ZjfWe3N?=
 =?us-ascii?Q?nsBCEvWjkS4kNqyNRMKjbTrHwqrkWOc3qpKltGeqNXewlg1HuBRbnYhJ7E+Y?=
 =?us-ascii?Q?yanFamZnq6eBYPPkpSsIiVmA0MBIrJvM8CdXK6sVJ+xoBVE4VN6hSyl6cF3v?=
 =?us-ascii?Q?NUfaym3CcOKWU7jBSnDrDxvRKx+ISDvH53RB8S0KOu1F7jqimFnsBhg8Z2Uv?=
 =?us-ascii?Q?Q/AVgoM1yQiyy4XVktpxnSZd86a5E430YKZAwQCJYEm29w4oYnAztZR86giI?=
 =?us-ascii?Q?5gbuo2JAsoWknEdn4mmK3bYi2QH8JP6TRL966pSPo/VbRP9zLxKCrPXWeiea?=
 =?us-ascii?Q?Ucl3s9L0cRnocm3usWkEIwsJTvga9ASHE9hkbuk1XKwMuc9kRVHUyHnJisB2?=
 =?us-ascii?Q?1bbAnAYZQ6TpYXkhCMx/r6bBFz8Lae9oD5v8gM9kLkgILtmTHZHm7xvXC4Oe?=
 =?us-ascii?Q?ey2ZYpwnYp6+NbdKaX0vap5Z0IJpGKJTsi9aC5YaCfqIUVSsIr10/WOKiLcs?=
 =?us-ascii?Q?yMezrwExjetA1ThQzXptOy44AKTHJVb8O1Sh4CztstKsJF3MgB2myhKMrOd/?=
 =?us-ascii?Q?07NThSdb6rWlNTpI2TrvePHq1neJHAE8Qa+Z8dOEZmX0EheSwsBDPn58OZkB?=
 =?us-ascii?Q?SBEJXMq0ZxatCBiatgY4TQHPPPeGlqH5s0MUJeB3bOSMRlABrqs4Rt4plcDU?=
 =?us-ascii?Q?QeSkxhhFgYXB3GTIR2hbf6/Iq5mnKsHaPH+nLtBJ6tVavAetuj/KTEtneVAw?=
 =?us-ascii?Q?fd59grPkslM05u7ukKoHXwZf2Ln5Ec/iwI75c7u3lOyR25lVBT0a0TmcAlX7?=
 =?us-ascii?Q?jQ8Ss0yfUs8GIJBt4ja9A1fQoXy5KWTTRNpUP4oKWyMQOqW8CAEvy8/voc/l?=
 =?us-ascii?Q?DZhWZygtTJwberkOAnVlfJ7fHMedEdCBDJjXrq28?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27e9ca0-c936-4e5a-540e-08dbdb14411b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 19:53:44.1095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1e1CGLVTztyV0kjH3nD216VEsTVP4IH7M80i+06UlAFXYvol/kEw+7SJZwH+nB81w9uevxjywZydb4WE7jS5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7401
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+/*
+ * domain_add_cpu - Add a cpu to either/both resource's domain lists.
+ */
+static void domain_add_cpu(int cpu, struct rdt_resource *r)

Bother. Missed one comment that needs s/cpu/CPU/

-Tony
