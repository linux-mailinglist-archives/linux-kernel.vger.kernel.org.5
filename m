Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DD67C5A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjJKRYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJKRYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:24:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7CA9D;
        Wed, 11 Oct 2023 10:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697045038; x=1728581038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0ubx0Xp75C/3DiPLGl1MPo0vBdgRkFIOnnCzCzbyrNE=;
  b=EIv4lCR+zRsN1eU/3PgL+UgczqalWIJdIXJJFecQt3J7SxK+eVpanuGF
   OVNhp2cQDZYuq3ror6o0/R5e2mkAubXRdJZJ2zyAUsizqtDS7i90TH9Ze
   S5Ho1Ad7Z+P1/zjMSYi41SHern8s6GWCwAtF+Nq7qO3btiThaaG4PVGhZ
   z8vGWwt2gntCs8PaMBvLcpFHheQqlXgiKLDCbajQg2VxkGXThlOj5q1fq
   dK+sPkAoJI0n178ySDcjtq/Eb2MjCBe7WbilSXCtqRN2nK0hlUsG2+Zep
   wV2QOhn/8A4jED0tGr8xlZ2CSfJoN+2zKClCU+1uqHbtmNM3gHXbvyfKf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="451210210"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="451210210"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 10:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="703819880"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="703819880"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 10:23:57 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 10:23:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 10:23:57 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 10:23:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URCpFooZmGTpiInFAuW5QG1Vyzs1JZ27OYvfdIcXAugaBL8ir2nlsMXaXuGJUtVYn9wf8dfx6q4V6tyliLPLQ3PoRvj2LOK0wGGZHSZDQ8YFU6faBlLT4tDL8h7HdBgEClZkBrCWdjOj1jkTNJRfGdqsQTvkFOJ05Sc5BmcI5ghdZVGOIcRW0lEk7HiV7gBqaIHsZXp2TjVH28OZbfAgl5Bo+XRPMyfyrVzP2oAaJlyf5DW8+AipXSkZ+9GxMbb1arACtG6Rbr2QkGC/M0AJSh+qzVLAzlBLGY/31wtbZBe0qEM2C+xr9MQo4AQF6bmznmgFgRU90UPcoN8if6D/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ubx0Xp75C/3DiPLGl1MPo0vBdgRkFIOnnCzCzbyrNE=;
 b=MmS24U6F4fE5rWd/CVXQMmVkTuG2bNHM/p0cVF8wmABcKzs9Tw6tlLhRVTJVx3kNJbbcx1kseth/mvbc3s1p6fSVNxbi3ksl3N0MCg84qjf004hKH6eHQdzSwQssF68apYlbwOsqwXfXhC7oYpnOrQCWVJ67jlnzAKYQMEDLoOfJVu4CE0TqSg6uD8XIPLc6FwjQuS9XX1m0zA+zz6RnDNre5Y6w+m3uCBnNOKN6JE6du2Y9xXcP0sXIf71M5twVF6LiHMeSD4bNkKpw3/3AdF4pBZVAZ/MzDaXDI7IqEIQQyf+MbtO9yMPY3pu+DIRqETLhnU6ts7c4Pyz9kgnFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB6199.namprd11.prod.outlook.com (2603:10b6:8:99::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Wed, 11 Oct 2023 17:23:55 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8%4]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 17:23:54 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Tang, Feng" <feng.tang@intel.com>
CC:     "Sang, Oliver" <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Thread-Topic: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Thread-Index: AQHZ9vG7TU6w8G+TdkO4n2sYy/mmYrBEV9iAgABlLACAAAgpAIAAGdzg
Date:   Wed, 11 Oct 2023 17:23:54 +0000
Message-ID: <SJ1PR11MB6083154D148B42B8B7BC48D9FCCCA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231004183623.17067-3-tony.luck@intel.com>
 <202310111637.dee70328-oliver.sang@intel.com>
 <SJ1PR11MB6083D191286779302821A7EAFCCCA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZSbCYt35j20ezT98@feng-clx>
In-Reply-To: <ZSbCYt35j20ezT98@feng-clx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB6199:EE_
x-ms-office365-filtering-correlation-id: 17ade6f6-ed46-4e7b-579c-08dbca7ed830
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: smuMj8u4eNALr6py8OtHQDEAP2aZ7PKY23BNTpDOaAl6MzOZHJ++PioSjEGuaI3sHg2tQtvek6aQLS7lGUzVjVtv9udoH+ZewUwhCc+smP4HzLpBEn8R3syFsd1AYHNqsOvNxbxr3eMZfWfMFLaQLUwwVKHZDBtnMglZmXi6yWR02+R2zJvErIrb7MGrEC9jmaOQHfmOIJKhDX1GW2o9XdCAva6jnrOffyEdWutzvT0F5/KgH2ir7jqqr4uT3vOR+SfoNqIWIEJing6QKfmmnybIK3zdflFwDJDv33TcyAh8a9nA1hhYuGMdfcrJ2Lh2I7Yl8GPf7GFbR6Fh8/5a6V2mVoio1YD3ZIhx6L+dKPpuiiRcaffnneOb0KESLmkJTro0xMocandaymmihHDSWzj3v+6QR5CLUH5yXPrUjAWE1XSRHWtEXYobNDnOX+m0GzGcjsOS5oBRhkbYkIUHGgEHR6FoKbnxG60Z7vJE+bybGOCqbjjsSwqSvHytLoOJPUGIldVJv9IAKLzkYaID5pfKTh3LC9FE0wfU1caYFb9kk7DMUoRcfgMhwWme2Lqib//kgw/bsD2CjlXdf+geoKA0+VZYrcCJzrPFgYJS9vqso4SJ/gCI30D0mRqBhlI5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(15650500001)(7696005)(55016003)(478600001)(71200400001)(82960400001)(26005)(83380400001)(2906002)(122000001)(86362001)(33656002)(38070700005)(6506007)(9686003)(38100700002)(8676002)(41300700001)(5660300002)(66556008)(66476007)(66446008)(66946007)(64756008)(316002)(6636002)(54906003)(52536014)(4326008)(6862004)(8936002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LQIJFhg09hzjhEuKn5ICUEalsaoeolw76StKPCMRqk/cs8XbvRpsqrrbkfQh?=
 =?us-ascii?Q?zPp0Tq6wKz+GRICmW9O/E65e6bGayCrfTdckeOmQcydOhc/bR1EiQ8UNPtNE?=
 =?us-ascii?Q?TuCWLzHkUEKvtmnIbn65tw+AVkujZkV8PDsUtnJYXrQ6K6xuzgTLCkH23TmH?=
 =?us-ascii?Q?0xN9fSNfuPwBh2ia0lnjVvWcDwuKcnZJZJhlE3V+sNWuZTElj+e/1Uuqk37O?=
 =?us-ascii?Q?2h+h5Iz4Ay5AnpzKM4eeJQpO45JvT8FmFUM9K0kHOYKVKfnMqCeMJfDRRbks?=
 =?us-ascii?Q?02HQ7LpkSXpzgHdv4VdplVzKa8KN6E64gToerlNMQAFvcyKtWGGCF6E0LFtK?=
 =?us-ascii?Q?KbhF0gcGzF22JW38W0lJO4no/96SL3cMyTM6r/YkJX2GtwQCMrE/H/MlX2S8?=
 =?us-ascii?Q?CXs80pYzoGt1xXFQss7XmIUe13TmQ4YsZ5vc4K0319IqE/I9mamXr76MAeEy?=
 =?us-ascii?Q?vHGgxqepU7G1pA1bs39D7njltpY/Pm/WaH4ETI3OZQENGqz1hi7V9bGF5Q9L?=
 =?us-ascii?Q?stnNTXaE27RFairnnKd6SFnWIN4tVy8FgmcrV7clbAad4cCuDIY1I9YNyROx?=
 =?us-ascii?Q?8IuJHqRD/IR283kNqEOKbJYYc/25eXEN0GPFXmkGvK/ySNRhTQWX9M6Az+5m?=
 =?us-ascii?Q?fupn5Ss0WF52uom+CY1V/VH8Wf22SFYxnLzAaFWMFIbv4y/473l10fjFeEkM?=
 =?us-ascii?Q?MsTwC4BiW6FQD6DBMr/U+Sn0YH99d1H6iaI3r3TVo1s0CFkqc7LJu5PtfFx/?=
 =?us-ascii?Q?/BLwOFTULCzHu+4L+pPsTJQMDmA6BMFHXYThbX976VT76XjxW8s9DjLauZSc?=
 =?us-ascii?Q?3yKlsaGZcXyRyxPuP0CFvrYD/KLPIL0DBRf9jtcBweUiVjepQfcaDcF13+bc?=
 =?us-ascii?Q?G/7Edg5WdeRsR0wLDq3zLDlwpuOnBzAvPBAogO28qI7CtV9pWTs3qptW+65h?=
 =?us-ascii?Q?kasDPX/lI6Yr11w1LP9HCDcwMAYk858QpzvR24Lcncpf4hpwlyqiTjI+pkS9?=
 =?us-ascii?Q?AHVj9n91MH/Ln2k1s11SJnpR4eUhMter4ADgXcBvVoXvKKWbXHAWkpPAK7O6?=
 =?us-ascii?Q?2E+rhKXGSbUsZ9ThMbY3n1Wb8GHeW8uwgZS4vdy1THg6pBT/TkES4nHPH7cG?=
 =?us-ascii?Q?PvNsrQMhekVwtFyYLHOvJHJso2v66J54jXrQ9a+53TyIFBsV9gQn+4jbMJtH?=
 =?us-ascii?Q?DXapsD7Gyu2w8C3dm0xaMUXjSkyKPQiSTmgv3nGkJqy/vBvsDOopW4g4l7r4?=
 =?us-ascii?Q?59AYfBwFkRRxA7rvHOyIRgJosTuID3ly+C03b1V3VeGxw/tL9MC+FOYr/Ocs?=
 =?us-ascii?Q?cPAk/jt658TWNT0MySC63hcMF/nAX+zsYUaqImr63CrcoDIVeet4JcRxiBj3?=
 =?us-ascii?Q?viKt5wNQBm8JgsGL1MTg/MYuQ00M4rSCfMmaJ+Kce/S/k8RmfPb4NC/x7oQP?=
 =?us-ascii?Q?1q71V2kY7YmkEuRdO5yE3W+VLQUiWGSC98PTa5sszrNetGAUlA2nLfqJtMv1?=
 =?us-ascii?Q?Q8pd5oUWs5wxoUZNjLgFT2tBTDOlnSCyw8lLFBGBsdJJ8Ow4brLIMYS9d8T2?=
 =?us-ascii?Q?eP2x72Iu7m51BoXByAxF+ctwE2RJBK3EotDxdwL3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ade6f6-ed46-4e7b-579c-08dbca7ed830
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 17:23:54.4728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W4x9t9I3oju3GxLWtc3hM3ZLnsDi4yVBnNk3f6ZWTcfL2OmeOno7SM49gXy+y2ZqnSGXJ5z6J9CF18hZ7mS/9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6199
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

> IIRC, CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B was enabled in 0Day's
> kernel config for quite a while, to force each funtion's start
> address aligned on 64 bytes. Don't know if this has been changed
> recently.
>
> Also I noticed the patch introduce a new per-cpu variable 'storm_desc",
> if the function address is 64B aligned, then per-cpu data alignment
> may be related.

If adding (removing, changing) per-cpu variables can cause 8% performance
changes, then maybe there needs to be some way to insulate the builds
from these side effects (as was done with the 64-byte function alignment).
I've no ideas on how to achieve that :-(

"storm_desc" is a largish per-cpu variable at 1568 bytes. But that doesn't
quite get it into the top 20.

In the config used for my kernel build, it does appear just before a bunch
of interrupt related per-cpu variables. Those might be sensitive to alignme=
nt?

000000000001ff40 d smca_misc_banks_map
000000000001ff48 d bank_map
000000000001ff50 d threshold_banks
000000000001ff60 d storm_desc
0000000000020580 d tsc_adjust
00000000000205c0 d lapic_events
00000000000206c0 d vector_cleanup
0000000000020720 D __uv_cpu_info
0000000000020738 d ipi_mask

-Tony
