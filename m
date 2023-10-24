Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248767D5A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbjJXSY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjJXSYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:24:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C5FA2;
        Tue, 24 Oct 2023 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698171894; x=1729707894;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yfBgd2EvMXfs22XWfbAiHh+pw1w/zf5DdHM6/F3T2Wg=;
  b=GK7bMKUzDVSSrjZy9sgYIuiHXDrLcwPfTCk2tNTKnLeC8zAX3LLpYIQO
   C93Vt+ULDXIBsA+emmhUlaKoaeQP43/8ByfK0WvNH6UuVLM4KEbXl6bOq
   BfJJ4JkqoQ1iyCahssYxoPvzT0iE/KT1tHHMWID7z6edZRRQoVwDKiXc4
   7nKA2IzfUztMYoAA0kaiiRt5oBonJe7XoxT7TsVpGVyYmQWxs5HAF0Xg+
   G8LfgKt3HjExl0i7zUoawVJkNd1Csc+XiBsdo8ILAQh8GUU7TI2p9ZP8Y
   o3GkbnAJeTOL9FY8wPoPZnF7A3GI0ohrBxEdVFv4RrSc1yMu/L6krLbsP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="473364384"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="473364384"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 11:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="758570380"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="758570380"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 11:24:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 11:24:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 11:24:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 11:24:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 11:24:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwLE2Hw4FsNQC8xbE/o2/EsPO14dJs24Xy7G76bLslZpIuEVvXAtnl/o3WStlsfQWt2eP/GcUClSyE8Pf1viH/38cWePEn1uTMKv53slzyXkDiD0sVMHJnyj/vQnuZFJb5sG660xaODnIBHXgbZB9bwP815UxXTl028cYrShCOu2XFpTAwqNxa1MWneSzyIOcA7bjuF8EJrTRfQAS9/5BjtvG5KE/Njg9pQ6/ZT0HXsjT6/EgcB2T+LTmTURjV2g7K/nYSjyZWlibRxWfonUEJB6VCm1+8x3cxRzj2qs2UA1X5THoc7e56ADTFDlvLdp60dOO7rr/l2R/uxaNq1WhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfBgd2EvMXfs22XWfbAiHh+pw1w/zf5DdHM6/F3T2Wg=;
 b=DIWnL//rl10ZFXuD8GxOlFfomUQ5DcU8Dkvjmw9zeuVjDtMUWfb+uGi9eZwKM3atHzSdpULf5Iiw00X1Rg99ygJBoMppa9x9J/zMzt68FNov3I37zXkaaXIGp36piq/SHHg3rvoExdDQF6alz5rF3UXG/beWrG68I8FwCU/2RBugpoY2vcI3QLjK0SpjclQXrhNmN9nxgZOr1FdTJYLNXu7yZwBflMhRUyAgiUYu2Z/TrhPrvHcePzW5K82EuUzXPuJnzn6WAYXiZdfcu6+bRuMSPneSbgdVf0VtMxwtZ5KvxolEaPlq48eJrwSb9T4frWv6dCBvH1xpJfZuAMpgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 18:24:50 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3ffb:89e2:2724:4c5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3ffb:89e2:2724:4c5%2]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 18:24:50 +0000
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
Subject: RE: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Thread-Topic: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Thread-Index: AQHaBqYtRjw2ybQBRkugDlcC/RU7LLBZQKZw
Date:   Tue, 24 Oct 2023 18:24:50 +0000
Message-ID: <SJ1PR11MB6083F84A3A83F26F4111900EFCDFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231024181600.8270-1-tony.luck@intel.com>
In-Reply-To: <20231024181600.8270-1-tony.luck@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB8066:EE_
x-ms-office365-filtering-correlation-id: 57d26e8d-1c6e-4146-6020-08dbd4be8270
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YUlkmw41W/rLcKad72umVws3aPBoAjSbZO2UMMYeLkvV/MIfYhXAit3ssGKUqF3wIQ6vxCHrprje+5lor5dcmnEIzmYtruVPRKOBHVulZHg6PsZLMIqBeUYF0Nnee4nB5B/+vPTm18Q/4hPisy1aRUptE+G0I6zLfWm0greIQBf4Z+B1Lg11Dx+Bw3OwaBEYInLF11F5c1JNOELYXHX+STWiNi5vGtOSBlAVZCVrd3NE7vHPBBm3ng0cQniSE9oWvLrk8gog7qcnt2HV08+CHx2M2ypFJwT7/i6D9Ja23qM51ECbcgmTSkj0xxxXfWBakcllsB+6bCg/xCICrQbi4UEXAiwvXNxh2TQ5kwDbpRR+7xUHkM+fJc5OzJ0ZoP5fU8CgDrs3K7h2Bqgc02dmsi13RoJEHu2R0fwc/37JBUGq7a82Eo0c3Ik28WINUmN2jlK6Eq01jI3nKn3O6RzQkyP56/8N8Iah17328fMs3+IX1pRwyDE9rgvct2cJ59bvteRkNs7boG6VkCBo7VT4X7uAJXrvtIDvqt3prknpuj+58rsw1cHF6QiQ6/Ooyu5eiIqb5tMZI/EEl/f7IxDvgkookQFJsabaAZ5QADAkptDGeFPdugTLdQBpLCaVG3d0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(55016003)(9686003)(6506007)(7696005)(2906002)(26005)(71200400001)(5660300002)(4326008)(478600001)(7416002)(8676002)(41300700001)(52536014)(4744005)(8936002)(54906003)(64756008)(66556008)(66476007)(86362001)(82960400001)(76116006)(122000001)(316002)(66446008)(66946007)(110136005)(38100700002)(38070700009)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DpPg4VLsCYx5+7LcXHqKjn2fBQFCwBwL72y9iCGuu7OIPSi0wGVL/Az3vlgT?=
 =?us-ascii?Q?gU+rIWG3Z4UZEbo8VAEwP7gzvJaXSepDUlPivl1kx7b1E4Ilos8fi6+E/cpd?=
 =?us-ascii?Q?/1yYlwUdoCnjLXDHXnZXTaCvD5/fcvKdygl8ihTit0aBAtoqUiII5FphngCd?=
 =?us-ascii?Q?w4jnyY7dOZNyRpzy0UAE9bfFH8uQqmuZwPE7ZCfLuSnCalo498U5kf+94VMt?=
 =?us-ascii?Q?tHgo4QeoKUs8ZpYGJpZUCzsMxNwr+VBmBj5MAHbFVTSI3MF7STbz4mEBOi7L?=
 =?us-ascii?Q?Z0DFjuzGym4I0Uf5ba0r6P7RLOpza9BaBhaLktdnz9p6w/N/4ufMKUBbWlWt?=
 =?us-ascii?Q?EbrtX8cHoplo15CaPCr5MyoEYZ/0+r4RsX/RcHIv5t6RD5toFRfUArqO5LQm?=
 =?us-ascii?Q?qmDVRGmN8GMTdRzHWaBHKHIi8ebfkYRFes+oVXc4465bt2TsfcY6iR1LnBSf?=
 =?us-ascii?Q?YlrBwero2N5WWl0JnxTvVtlbiVgWgKSt2ZFe/0igXB1Yp9ZFU3VMWDea8bcP?=
 =?us-ascii?Q?QLYb6Y+n60Mwb5iccigSEK1KFoD5vjIIX1PK0M7XFvXV6mRDr05KbAiaf2d2?=
 =?us-ascii?Q?yVwe62vPUUVrtbCgBdIGATNoXsjaPCgo9L2bh7nv8rGyTIEsTwpaHWQuSKKW?=
 =?us-ascii?Q?QE/yz1IVVPYalGKmdxVenDz95Ko/pbiGq4JKZMKDhaLuImzGJ1W4jbNQWqwd?=
 =?us-ascii?Q?vJKVedPcsoG19QCtwaUIdw1hC6TXfWKRYxLZ+J6soWq1OiDMPj2OGsttx4k/?=
 =?us-ascii?Q?lNK0l3FMN3Vx0oYAaqz1qBtL5qyTKezqUVXDnWEoV7gpesTRuTaQ7v90C2Bd?=
 =?us-ascii?Q?ZBpukA2x8PLVEQI97bLYq65z3Ib0C9DIHIYKVu3U0u1LiYtuONmtMV5ERgtz?=
 =?us-ascii?Q?94HQQzgxQkptv7oJehjU+3oqYacFOb/xkKm/hlQO00WEZ0cjCef90fRTcyTv?=
 =?us-ascii?Q?ysqmnMJeqWhsFoZgMOiI04HHdxIHUkxAmfmDHnSVLC7FFNxYAdN7aZz3C7mz?=
 =?us-ascii?Q?JcAoMx2/MVfX7a/OiqRLT0XG2rSlxBl5tNPuQZ3E7MWyKhfcA5eIBJDVeYQY?=
 =?us-ascii?Q?Qei+73RZJ8Bqfhyrj2n132XHS+4CPl8iltJruHcK0AK67eBiXL2dt1Ylnb5+?=
 =?us-ascii?Q?IX8iwOiTl1Oz9Z0yOEz5iymMSu06iu7FNc9ur3iBbyHTIHzkBaTVmm1ImKc0?=
 =?us-ascii?Q?GkJ5DfUiyrWFEkf99/mA/zdPjI1Lxiak7c9APG7ha23znC46v0Q0m/gVu7Ry?=
 =?us-ascii?Q?7bGDrgPSHyCMPOrNfh3lIwweQgV+Kw+Ku1ZpkrcfoTs4oYAtL1laNiH3lGLR?=
 =?us-ascii?Q?41w+rsqPzwsld6N4qHBZrT55KtPmnmYHyIB0uTZ/RCtr4PePZmJ/Rv69ZZfU?=
 =?us-ascii?Q?bm6qHniZh5RUOSQrITWAh6P450hjPouCEIS2gE1RmjKCW3LYEes+j8+T++o7?=
 =?us-ascii?Q?zn0LjxeOnv8bQiWPMYzwUq+mRizUGcqoY5EGBxPujGvhNwTKRUReHBpIlShW?=
 =?us-ascii?Q?IuoGQLp7tOPIcoz4iPZSYZjXQnVZpdmydAjAt4n9ZnbVx/s/Lb37QuCqEr/w?=
 =?us-ascii?Q?jJgg6MC3DdT21Xc8o5l59JC37cf/NwpnsNx4/YOZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d26e8d-1c6e-4146-6020-08dbd4be8270
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 18:24:50.0272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brYtxsEgtk1yXHuVgaZ8G/ECBim8WPeQY2OjJRzK4gv2J2ZCV+mwv9VqBioZReN0JZHjyHvrm1zvSq2JwidIyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8066
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If local bandwidth measurement is not available, do not give up on
> providing the "mba_MBps" feedback option completely, make the code fall
> back to using total bandwidth.

N.B. I don't have a system yet that does this. Tested using boot command li=
ne
"clearcpuid=3Dcqm_mbm_local" argument to the kernel to fake the non-prescen=
ce
of local bandwidth monitoring.

-Tony
