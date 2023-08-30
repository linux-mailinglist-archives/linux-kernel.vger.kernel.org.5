Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F311C78D235
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbjH3Cq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241772AbjH3Cqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:46:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592AFCC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 19:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693363591; x=1724899591;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q8GxsPHeqOzazdCC0t3t5ZaYoFqiSTRS2If3yuTOmHo=;
  b=RQ8ThXu4ooH5vRxxSUphnbpWEWuHE+aUTYB2BtMx9vo6SGzbnIWWlrhg
   g4fJZasO0MsB8NoEgRZVp2LptS/HGwwegT4QYNdRc6mt6fE3jWbhwqMG2
   J5WczFa7zfyL0Ki0lZH6wu/bNaHsXcLqFWemW9pRxSaqWGJyY26WVtour
   kaGi4RSDQ3a+I9QkKMG9IksoWr0pZmLiWj0LZueTlT1IFe7iG8BSFkirL
   Wy5+RBwWvYQS825QJdMrDEIOM5ri67HlUKHAEsjVWJqK5vjcEVqXOgK1x
   MTENKjlSw/PwuYRr4SP0TafRdKWQPQ1XePQgf15DQmbwNxPVl/teI61Hx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="365735362"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="365735362"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 19:46:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="808938467"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="808938467"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2023 19:46:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 19:46:29 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 19:46:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 19:46:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 19:46:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X00JIztzxTgtFFM010C4YSnG1j/Dx8ub3VE2ddQCtAgmn2erdY7nUB2ft/y3y6NYOdteQTwjCQnU657DO2FhctIElIoWeUXE4jzRvDdASfoanFodpxBl8rGoaGGMryHR1NiQpNUkh+KDYJJAA8nJ6KT9D2OfVL87vbSPikgobAy8FyDB3T8bxCf0GQM/HkoVUeiEsx75oNveiHLB/ebkje2j8+F5EwfYCwlXCadQa32C8TFSsI6w0uqRjnE5+IHIhhHyU2mmtXqrTdZU/J/cNsoXiv6+hElCG5LR4G8ccvSNckC1y9vrE+xSqsFszkgv8kBdG4oi+k1MUHlmZ2I2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehIFKhTwPnlJXsCUMqQqViDqx9NnnnHmy67j3rex48A=;
 b=Wkwj9zBagx5JvcHruIapFCqCCbobQOibx90oNYA/UfEJthJtTjFcI1fGXyiFG2d27O8PA+NBogXwjtZ/VAWrqBg3d2d2UL8Lpy65Dd6m9obGhCVeBDw5u5ajJKOR7x0zrBmiLVBKZk6JMoLB4US3z9LA0sucZsHX+tbTdv2cMZlEronKR2K58/4XYuLNgnabhpFPC8c65SeWjfhg+RLXYbvpSQa6e5K72IHWx2nPQQEFrdfo6Q2HMdnLdHkKtTFdvGsjlCJt1dcm3+3117pW+DYn7k53J4TkBaYGe5T/LiZB3G2ZnrKRAblT0GdATQR2D2ggPLDLEgxcfvt7HuA4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6010.namprd11.prod.outlook.com (2603:10b6:208:371::11)
 by IA1PR11MB7248.namprd11.prod.outlook.com (2603:10b6:208:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 02:46:20 +0000
Received: from MN0PR11MB6010.namprd11.prod.outlook.com
 ([fe80::3f6a:413a:ffe4:7b5b]) by MN0PR11MB6010.namprd11.prod.outlook.com
 ([fe80::3f6a:413a:ffe4:7b5b%7]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 02:46:20 +0000
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
Thread-Index: AQHZxSuNHqTVYruCfUiH6AgMgzkGq6/mYcAAgADEZgCAAT52gIABItGAgABDd4CAACAJAIAAH1qAgAGk5gCAApuqAIABPhYQgAUg5wCADZfPQA==
Date:   Wed, 30 Aug 2023 02:46:20 +0000
Message-ID: <MN0PR11MB6010F1D501B9A2C0B7B3D1F6E0E6A@MN0PR11MB6010.namprd11.prod.outlook.com>
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
In-Reply-To: <874jksher3.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6010:EE_|IA1PR11MB7248:EE_
x-ms-office365-filtering-correlation-id: 31c5a3e2-c4e3-485e-a870-08dba9034a92
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P6ooWPszk7gFgKOb+HnjYfrH++UF1WZdn2I7C2QVkSIKZ9kYRWAIXLd1kcxtJxrssGsQ2XQxmiM4sV1rOW19+Hqptx8aLsrKumnzsm2mDq/dgPNrUOosyzCgT0fUWZ1e1s8B4bFUpVlQhh3CuiGdh+8HMejEom0foV5kPfREouj343IiYn/E7ofq2InVym6bseKFpUYgNvvZFCFQffuLOloV0EQtQJ8SJT780C/EWBYkBMfZtfTmuknGEPNu/pyDYlUqJKBrumg9Gtq5ylX+z1iBc/IBRFJTSJ+ap03tpEsCxGIVbD7AgVbjASuDgog9XoumjmPje90tUsbZaGNW4Umc7A/tM+4aaknWq1sNV6oBrGug8IXJ6dy51fgIW3IhihDTgtuZzuAzdqyB4UmudAKLguNr4Xjx2cwV1L9TdSLyYXhX2XqOV3Lj/hx2kKEUSz49lyyP2tl+OC9YezBi6b3Q1Wc28xwKXesgVmJZ6G4OIz+9ksLQLS27DbKuoMWAawDQSiFOQ3EnjbDi1diCxjfwnYGE/MUKdmwaaz37iJ+cskK7xoKxPa7g++TV5FFGx9H2ZFVES1V6bi2LEzRp5wiWr0LZiusYew1TOAf8IKm6uh1MTfUwzsESSoaZoQKr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6010.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(26005)(122000001)(86362001)(38100700002)(82960400001)(38070700005)(478600001)(71200400001)(7416002)(9686003)(6506007)(7696005)(55016003)(66476007)(76116006)(66946007)(110136005)(54906003)(2906002)(66446008)(64756008)(33656002)(66556008)(316002)(5660300002)(4326008)(8676002)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lZ6AuSGzYsTsOxefJkPcWmxcT6kpHHgYIEdTZmxr7nUEdSh8Mu3qQNtLLD0e?=
 =?us-ascii?Q?vVJNUu9ULvKhlN64tQzZk8dYFV6uDP3tVeGunAwgMWB7pH7vfOvrQvlBKhOO?=
 =?us-ascii?Q?iWzkr+7sNLlGVnFaS7H344zck8NZHmk+mpc39SIWCMfLfYckUUJ2cSEfagsT?=
 =?us-ascii?Q?BViCoVruARb0DlWvD4g7EDDUvx+KJD54JBYzqLGbVya7bSITA47kN1nNQeVL?=
 =?us-ascii?Q?G+NzJ7RcVLSGaeogHNv5ArUqDruXmX27TWfsnUNSBmtyFTXbsrSf52xBb+gQ?=
 =?us-ascii?Q?1ByrOUTV4XNww5D3MH8lXmzgEpR1IJlBkF3N5l4mtiPyAKfecUAEb+8zuT6F?=
 =?us-ascii?Q?nhAMEGsmFVZBji6jHVcYXabiIQQVaSb65zl8RqPhnqIAPzYe6LX57rOdi1hb?=
 =?us-ascii?Q?akbpgLmXrs6DH4SwQDBhx/BOLZaeZElFcxyii/z8NDF0j89hKTL/MD3VvgEY?=
 =?us-ascii?Q?Te4MKpATpyvWHrpUpzurDsML4DNcZiPF7FTkS//9xOqSkjHrK+SV8pGFb3q+?=
 =?us-ascii?Q?tMTFosCrD3Dts5HRxelJl7686+mJpBb5pNvNPdTa0Qxz6m7EVePnBh7khltf?=
 =?us-ascii?Q?XFTRakuwLhWuBH2W11Y1Rmb8E4DINYmAXMuzU2lPCnfJTFTzG8PqvtJapLhq?=
 =?us-ascii?Q?dShj+y6zk5x3CWUq7Z713vmWE5SlXs4LdfkbyjBeHeva/g4Y5qMceewfGUk+?=
 =?us-ascii?Q?0qDDqQrv+fvN4W1a5Zqu0jF8PxK3RtIqvJcofCVUc2EdV1Npdzh/VzzyHqv/?=
 =?us-ascii?Q?7TiYI15ag39wPlaPc/8NC34QGZ3WcGtM3SH/xM/Ndo+MxnCtk1IvbMcZA/HG?=
 =?us-ascii?Q?YoH5mxCQQlAzL3tOgG6xkRdxRVX4iHgS1QfLp7XG/B/az0Wg6x2C4/NonOR3?=
 =?us-ascii?Q?Ibbkk80IhthZnpUYIJE7jPqDaF0CG6KERVxRuiQ0KIHtZm2Ri+CS2adlzTM8?=
 =?us-ascii?Q?e4k0KCvgwGlxqO0YL7FPh2cvq23FxeVXVaMLoyxyGS8w3igfc5M3h5K+YX/Q?=
 =?us-ascii?Q?UbeQr+8aPGxmO171rAxAKaL2tQd9UsZnYKssOzUigjmxl3sYK3J9VLmuV/fU?=
 =?us-ascii?Q?4t9fr3tTrRV9VKcwfozQA+Y7yI0YE7QGa2VsNCmTO4Vh4u382g6ZXzA8FfqA?=
 =?us-ascii?Q?Dy0n8PkPdpSLmnwj8T5mRKckW2ZTsFbWpOiixrFe7mw7dd0C1D1imbm+CAkO?=
 =?us-ascii?Q?09U79E9XAYVIgWfy0BSyZ31VLu7g8/BxK1K/NaAE5w+oUrsHnNBPU77j1eJm?=
 =?us-ascii?Q?jNSqlms9/04xeXQ0703dxorEMt1hfCCWwCxSmWYXVAvSVb0A8YrPQLbCSSoQ?=
 =?us-ascii?Q?xbt1rvE46qAK+E/tN6B/2YDyN8x9+v+lvzdbxFgSo0gekQdUMR3+NqybO4bt?=
 =?us-ascii?Q?5toBcbvhVXWB8HHVseaSaOKKs2gXwEmgC3bfDruZuFXX3BObTf2CB7PWx/g0?=
 =?us-ascii?Q?N1Z98/siO4ovmrcwooj0mzBfXwCWf0zHU2tDALoWQDunpN6fRUOPvIG8vCTH?=
 =?us-ascii?Q?nJHy1QagQz11kz4F2vHK9fl9Eck4zQsnSzezMgIAIa07coBrSYkN682l+RFo?=
 =?us-ascii?Q?HCHIW3X12r+hPMf10sI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6010.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c5a3e2-c4e3-485e-a870-08dba9034a92
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 02:46:20.3677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLma2qLC9MFhYKKjfIP4JKetl2yg+kwgTJTRgCAcc3iSBYj6DIpprwr6J7dwJUI5RES98NLg0z8hmTrAFq5soQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7248
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

Hello Thomas,

>    The way how 0x1F is designed and how the APIC ID space is
>    partitioned, makes it entirely clear that all domain levels must be
>    evaluated no matter what

Correct.

>    and it's more than obvious that
>    non-enumerated domain levels occupy _zero_ bits in the APIC ID
>    partitioning and therefore end up being size _one_.

By "size _one_", do you mean that a non-enumerated level gets a valid id, e=
g. id=3D0?

That direction would be problematic.

If CPUID.1F doesn't enumerate a module level, then there is NO module level=
.
Conjuring up a valid module_id=3D0 in this scenario is a bug.

For a module level to exist, it must occupy at least 1 bit in the APIC ID.

This is what I failed to impress upon you about die_id erroneously followin=
g the example of package_id.
Package_id is special.  There is always an architectural package, and if no=
 package bits are set in the APIC-id, we can still assume package_id=3D0.

This is not true for the intermediate levels.  If they are not enumerated, =
they DO NOT EXIST.

This is particularly important given the ability of CPUID.1F to gain levels=
 currently undocumented, and omit documented levels that may have no utilit=
y, or even a meaning, on future hardware.

-Len

