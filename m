Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992B577BBF8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjHNOtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjHNOsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:48:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE2B183
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692024520; x=1723560520;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1/6qxLRsK0I0z/9i2yS24A1jRffW3W/mLUYM9saHa8Q=;
  b=g5dHthtZfP/pSXtpHeA+ftnN0vYpCCyjjk9/f6eJvSW5bijGQZc44ian
   JXMZuJeaVpL8W9K6oQfUXOwdWz5NnyCGenPi1ceKUe+4CgN5pE5dQsIdr
   ADhqhFxq/z6R58/XNk6VxeNPtKx30vBZQsBFZRO7x352ORJkiZMmzanxo
   jtn09ADqHrlf/UV6LufCOSdMKfZ9e6QnUprh6ntfvG0oU0G0lKi7E+KNK
   6KuSK5NrGu7FkLeYt75vC703NU0iTqmVsuSJc1kMrtVAf5JV8faF3dMYm
   EctYXPC2ivE6HG5LodKeY1WPxoze/l/9lv4DT2YEAYJIIwj6RKH82AnXU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="369523599"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="369523599"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 07:48:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="736537029"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="736537029"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2023 07:48:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 07:48:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 07:48:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 07:48:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJ3RrYIxLe/QwsSocyPE9e3NKbElb9Y0rIYkMYC4EjVEnwK+kFq1LfleeMT5bknndxKBuvKpBLXFncygDHLVZzj166e3tTAl5yVZs8sXEW79HtRV/MaF0LO9r3JIN2JJ7dINMRzManii3vaswOuhC1TMWbRf+jBspJsjBidQ7RGGI4SV/HtOFLNsfmYzVFaUKeVpyaVHCQ7+nXZcvm9HCWbk3fNRz5Z0AZUiQzxggKbeusa+H5LqnOrUChhByScNdyuDQi+K85z/+5uZ0Ta8f6cQj3lDxfsWBL2a4RcOU2D9JydI7SnrafjGD3FpgN1c/5LlYz17NS6l3ndl/hp7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2te/B7EXhZHTcosjxgAivuzbyDYfWfroogGaLQeMLVw=;
 b=MPyAgBPp0INNsg3mSkUxHsInSuky7273FBgyvJLjVbgbkr8jMmtwr6HuP3YIkz/yWsB/XIGlEs1Ij84eJ3CGHoiVjT3GYcccf6MIxe07A58ekB0Zy25ECywFLg4bpkC9VJZhSVdX+Z8/K/UbXq3gsTUPWxUAFgA728oJa8ND7TDuKZoScbMVgrg8dE45MnFFnAzmU/+/HyNeDp6OG/q6rQ5UjVEfx0yZyjXIFG6hwp4KHLAk8c+UegtOha1E+2Ik/76tOxR38Z5M1NmnJCiaVj2faK3//gU862Ho18rucp6edKQ4GHk5ZVOmOYkNTX4dhLOqR9ePD5E0wgYQ4/EbJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6010.namprd11.prod.outlook.com (2603:10b6:208:371::11)
 by DS0PR11MB7384.namprd11.prod.outlook.com (2603:10b6:8:134::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:48:36 +0000
Received: from MN0PR11MB6010.namprd11.prod.outlook.com
 ([fe80::3f6a:413a:ffe4:7b5b]) by MN0PR11MB6010.namprd11.prod.outlook.com
 ([fe80::3f6a:413a:ffe4:7b5b%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:48:35 +0000
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
Thread-Index: AQHZxSuNHqTVYruCfUiH6AgMgzkGq6/mYcAAgADEZgCAAT52gIABItGAgABDd4CAACAJAA==
Date:   Mon, 14 Aug 2023 14:48:35 +0000
Message-ID: <MN0PR11MB6010CB72411BA723BEFC5565E017A@MN0PR11MB6010.namprd11.prod.outlook.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.258937135@linutronix.de>
 <8e5bbbc91ff9f74244efe916a4113999abc52213.camel@intel.com>
 <87350ogh7j.ffs@tglx> <87ttt3f0fu.ffs@tglx>
 <b8637c8c92751f791bf2eae7418977c0fd0c611d.camel@intel.com>
 <87il9hg67i.ffs@tglx>
In-Reply-To: <87il9hg67i.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6010:EE_|DS0PR11MB7384:EE_
x-ms-office365-filtering-correlation-id: 64ff41c0-4535-4b40-8d07-08db9cd589bd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w2Tje3IymVUvr21QaG4TYotVW9Yz51wzUdAQ9i5wGPewNpgTvmCpfV7caYyDxTq487BoAdtSu0ej4dM7bal33/dm3gbqh4R7qd+fHNHJi7yzAnfjrg9X7x98r5g6WACMf179IASVyAu0xhxF7GasUEX2OZdZvb3QBvduTIdC0wQuMSLgsWDQroKfUrBv68aJrlsv60NSmeLxGHPqqVN237dodFPi8jhwCIn8iAyrdxgy9YOAiSS9t0ORdSZYrJ+ZtxE0FjpRcAiGbw1ufKf6F74J++euonmaf2/2SFwASYP8GXpry9MIXWCTk8ZYsRbg6dCSxF0gBqgh1DPpUTH5W7I8TluAvQ5CNtMRUW+FErRFWLWQCXh7B3aWXms9utYChns/0poQXWJ3VibdfFm231LAmwBCVeZNkHY+mzMNXOtkQdgGpBiUEmnrDrjyKj9gZt/fnw4RpjV7TsSgOLGgg9XNVgfR4BHaAxdRN2fgY297OPfBYPJ+9IQNHruADlZ7ECD8jOzZf/J9I0DPz/DydUU06pCaHCMUkSdVHkgdrnyBgLY8IgzKuAfmJ7ExkjkfOxbPs8rzweq0gIbRs0N8wVEkZq7brEG3GR8iw7Aq0s+5D5fIsZrjZ27MLB1nxJcH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6010.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(376002)(39860400002)(346002)(186006)(1800799006)(451199021)(55016003)(478600001)(122000001)(82960400001)(71200400001)(8936002)(8676002)(4326008)(66446008)(64756008)(54906003)(66556008)(316002)(41300700001)(38070700005)(76116006)(38100700002)(110136005)(66476007)(66946007)(83380400001)(9686003)(6506007)(7696005)(26005)(86362001)(2906002)(52536014)(5660300002)(7416002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MhfjkfMgbSeuOibeMkiJ5wm45BmSx8UlF61evCFEy0NIBJhg1ElhdoZtiqIY?=
 =?us-ascii?Q?1ogHfjO7ZuQ/KmGSr+UqgzStOiguZk0xuStaTEKdwb1PFhG9V5E6dyZZJN8j?=
 =?us-ascii?Q?HR9sZqQOLh3FVCZNIYYWl49fgqR2lhkKyiN1cGKVQh7VoBzcqFJ5fiinzSl4?=
 =?us-ascii?Q?mGugUNmd9DpXyMbNag/NmEzio84l9JXvmWl9c0jl4w2UD4ZMKKVhLoPoJUVa?=
 =?us-ascii?Q?aJNWc0HT1hEunSMsmDSzNN63UpywVGLKXcN1txTfU4k63KGgq7cl8HEC7xuZ?=
 =?us-ascii?Q?40Dc0nHNlItSsBZH1fktOaWJ7fsYBSEDdquoj+hqhcE+/EOFr7ZQxXnK6crM?=
 =?us-ascii?Q?XwC2AgJGwI1Uc2LjKsodhXqxDVjm8RQ689z8jqxSdtFc+ojytnSQ3cu7XvGN?=
 =?us-ascii?Q?6ObBU63toCSeq63uc0rzz9hyrn2iH3jtpEx8jVyRdqaK8Da66D5PF9e3pSP2?=
 =?us-ascii?Q?4GZoQ5Z1h7N/JYmn4NaANKCAyhATctS3Ps6bwkrZK52WFix1Skw0GvmD4RpH?=
 =?us-ascii?Q?nkvu5x4Rd3l3y7g0VF3PIfcWyqfZ/LCzd9V3rrMgIgJcN4U3ssUBpRNgTId9?=
 =?us-ascii?Q?gFN423NlO4ovPq03t3tmF96yltXC02YwvyTbizPnkj1XsYzitqrJ23W8neoN?=
 =?us-ascii?Q?fIw9NQFxPTg0L2Bd6yWEI2jQBdzXhbJ4d/LUAn2+1HcH8Z1Ltoc+ah/HONZA?=
 =?us-ascii?Q?wuEeiBcTLR6DERmKm7tEfvA7I/T6Nx+uSRvxv/KcKnwWyifPhx17sqcrSeAd?=
 =?us-ascii?Q?31yipE7zDVBoCw26rjumn0INNUSBFSkju3NfKz/6LYfbUWitNni9cICDN3M6?=
 =?us-ascii?Q?oyEwrulwqtPKFdgrSGHZLzfFMfQTIQGZZExczCGV6iq1ih5rpKHL1qUkrK2n?=
 =?us-ascii?Q?rPy77DF1792qBwNLdYb1XTRjF2sLmUF/NhyLVpGcppmfMZrZtwnDrzVHBHHk?=
 =?us-ascii?Q?E4UuzICD3Rs1BiVytpP72MRSzulj+eeof+xq/WQghatpG32zivfIqnK+yQEh?=
 =?us-ascii?Q?uf57CNqpVy4hBRUhpLvfU0vBQxshZNMkbPX+n7HzPTuKw8qUGzqBvJxdaaoJ?=
 =?us-ascii?Q?viNXFmx1lEWltxnSs7Fe7XRktbSXpnNbbGyhDnuKiPK8cEnAUDfagrrUcoMu?=
 =?us-ascii?Q?+tqZpIQAndDOml9WLE6npl+5t8JYMB7E1wxZBtaVIXHB3CGpQvhzETECY7a1?=
 =?us-ascii?Q?w9fXEs9Z9A7yvzRvoC+CEci2e9bAuphpF5OJjafxckIdS3E8qgkToLqdV4AG?=
 =?us-ascii?Q?MmeK20mfIUshR5EPTz41jygNH8ypa2LBUtkLwBKoGpb3OU3dFU79gAOErUcD?=
 =?us-ascii?Q?QmFrr7JmEuiD+rAv9233TdRQCoCVqeiztvjTQpvWPQ7YrhM5fS88OQcgMghg?=
 =?us-ascii?Q?LvMGr9l8ad8ZF1RD8XXI8Zg4rXMSFc/XtffkhxWpl4dmB9qNUqiPE0BNExNq?=
 =?us-ascii?Q?GKn7fP8953gq9biSiQpc+m67FX1w0vxk/TS7qMd+gzAWgShXbBToS2dka84Y?=
 =?us-ascii?Q?0fKnjpK4bHLh8F3XpXEgrcLjME/2xMWvRjFYGDTaRXmqaVU2x3kWE0gsE4SX?=
 =?us-ascii?Q?GYBSFWabHlwiX68V7vZ0lxWuZ4N3t5VHQ9KMjeAe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6010.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ff41c0-4535-4b40-8d07-08db9cd589bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 14:48:35.5761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nk0vmmFSJ2QFIY+Ep/1J5pFp0XPSFlzgbhTqqFqPyqHdcZPWAGSsV7FDGRDNa3l2M6vkGfwOSbthf3j5pxAPUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7384
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What's the problem you are trying to solve? Some real world issue or some=
 academic though experiment which might never become a real problem?

There are several existing bugs, bad practices, and latent future bugs in t=
oday's x86 topology code.

First,  with multiple cores having the same core_id.
A consumer of core_id must know about packages to understand core_id.

This is the original sin of the current interface -- which should never hav=
e used the word "sibling" *anyplace*,
Because to make sense of the word sibling, you must know what *contains* th=
e siblings.

We introduced "core_cpus" a number of years ago to address this for core_id=
s (and for other levels,
Such as die_cpus).  Unfortunately, we can probably never actually delete th=
reads_siblings and core_siblings
Without breaking some program someplace...

Core_id should be system-wide global, just like the cpu number is system wi=
de global.
Today, it is the only level id that is not system wide global.
This could be implemented by simply not masking off the package_id bits whe=
n creating the core_id,
Like we have done for other levels.
Yes, this could be awkward for some existing code that indexes arrays with =
core_id, and doesn't like them to be sparse.
But that rough edge is a much smaller problem than having to comprehend a l=
evel (package) that you may=20
Otherwise not care about.  Besides, core_id's can already be sparse today.

Secondly, with the obsolescence of CPUID.0b and its replacement with CPUID.=
1F, the contract between
The hardware and the software is that a level can appear and can in between=
 any existing levels.
(the only exception is that SMT is married to core).  It is not possible
For an old kernel to know the name or position of a new level in the hierar=
chy, going forward.

Today, this manifests with a (currently) latent bug that I caused.  For I i=
mplemented die_id
In the style of package_id, and I shouldn't have followed that example.
Today, if CPUID.1F doesn't know anything about multiple DIE, Linux conjurs =
up
A die_id 0 in sysfs.  It should not.  The reason is that when CPUID.1F enum=
erates
A level that legacy code doesn't know about, we can't possibly tell if it i=
s above DIE,
or below DIE.  If it is above DIE, then our default die_id 0 is becomes bog=
us.

That said, I have voiced my objection inside Intel to the creation of rando=
m levels
Which do not have an architectural (software) definition; and I'm advocatin=
g that
They be *removed* from the SDM until a software programming definition that
Spans all generation is documented.

SMT, core, module, die and the (implicit) package may not be well documente=
d,
But they do have existing uses and will thus live on.
The others maybe not.

-Len



