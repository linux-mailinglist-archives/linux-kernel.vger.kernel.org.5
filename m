Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F517749BE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjHHUCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjHHUCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:02:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9C71D041;
        Tue,  8 Aug 2023 11:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691518762; x=1723054762;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WFxZPho3N896MerRD+bi6OLJrUCVPA0U0s9igu4ZMyU=;
  b=jl10g+YINlCmOpvSBEgEZCoMtkLBTPQ+AJxOi5FAae9dIZ7kK/fWnjVa
   sBgS2DT8I9jcodzTYpIzT2UrD3GAmbbSOyDf7q8tshPmumkt1dh5grewz
   gAFMt98nC4afPtb9XtlvZ8Tzdm9a3MeFxkSJhXzoumBHds5s9EKJeSG4m
   LIwfu4xHYtrzcdwUBzJtzJM6XeqPITTCT6TNnYvbrPOYFHrRhiVANYBV4
   XoqOkmhfXSTG2fGJCncpZzBnALhVqqplz3j6lanY3GznBb2iURqh/ofjK
   4fbRgzexFSTqUd+A3tuyGHKVIIyCjHpFOGMRHVUIbd5JQhzxDybi+Cz1F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="368366984"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="368366984"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 11:18:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="761017717"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="761017717"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2023 11:18:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 11:18:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 11:18:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 11:18:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAVVXzdDH/TZN3GWZPoJP7D1h3VTdRq3GpYrNSWoTri/YD8J9amMfqGtMyKja+hXA1ddwBctjKB00x+YktDrwHI0MMCH+OwtgFeejpN6oNDM5NRTM7lCYODSPP1dC+/qDueqFQlE9d1EXDbntYFJaHE/Q3P0kDTvRtSY/U1LpUD0Z+0I5+3j2x2hTuTgTc7VTbHn0PUQO0CMztDiseKAlxbnGhXwx/uJGVZcMDTUa7MaNmuS7OQomUcKEFBmGb0oQJ78wnH5y2U3VC6UXxOW0H6gGF23IcZan/rxAl2eh07HJu9FXlGbGpZsYceMXgp1tWQ0YZ+BIXyjdUvXdUMjpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVo0bLmqGzVgPdyVlSKzIkEtFxrui/EjlR0zVpcGgqw=;
 b=W1yssJXSiBhy1mNrgIJyb9xCxAf8m6WAAIB74u/k/F6burvLxxHDgItJteoP/TQswb5KkMSLQK9V7KYXkRhFmL4LN9rMz2w62OOfgPIHNtJTX9vY6nlS/2OPFd/zikVN0k5s4qJx7T3MWCEukpt8f9SyusiTrcXVSS3dARQ+j75TMzFMNm11yiGO3SYzBSuV8zjT8xMOd9707iJ8VzKuJHlXyxr0beCrG0acHvCoS50MSWgdHqq2hxrlpszxJotyv66/vk6jcZuJUL4apo34prkq/2K+ffW6Rwty3yYiyaSxIDIKRD+UW2Awr1aheL/jWc14MzXP5ejgTUYYDZpmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7363.namprd11.prod.outlook.com (2603:10b6:930:86::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 18:17:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 18:17:37 +0000
Date:   Tue, 8 Aug 2023 11:17:33 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        <dhowells@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Message-ID: <64d286bda1d8b_5ea6e294eb@dwillia2-xfh.jf.intel.com.notmuch>
References: <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
 <64cdb5f25c56_2138e294f1@dwillia2-xfh.jf.intel.com.notmuch>
 <1180481830431165d49c5e64b92b81c396ebc9b1.camel@HansenPartnership.com>
 <64d17f5728fbc_5ea6e2943f@dwillia2-xfh.jf.intel.com.notmuch>
 <c7d6e953a4b36014ea0c7406531b24bb29d6127e.camel@HansenPartnership.com>
 <2425e00b-defb-c12b-03e5-c3d23b30be01@linux.intel.com>
 <64d263e44e401_2138e29486@dwillia2-xfh.jf.intel.com.notmuch>
 <CAAH4kHamob7g_+BRd0JW76cM7_vS=jzXzRjrgCPDxZ29VnzdCQ@mail.gmail.com>
 <64d270a2a68ce_5ea6e294f0@dwillia2-xfh.jf.intel.com.notmuch>
 <CAAH4kHYht5s4CkS5Y9+VotPH4WqDrzng0vYy89oq0_U16H_dDA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAAH4kHYht5s4CkS5Y9+VotPH4WqDrzng0vYy89oq0_U16H_dDA@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:303:8c::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b7bce2-636b-419b-71ed-08db983bbeb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fMc+4gSKHViZNUIb1IQ8qDTkKe3El3dfIyXVXUb0B2xYMEtwRMCV8bRuc6Isl9T47RTZOCZoSbnNCqwhkRCod69ACGbkL9vb6LPLv0Y8+ol2Jg5hPJwu5oZjYbPydAFCyaQTu4ABxp7cMmAOVSMX0jb0ZQIcbzlfxMCc+oZd1MukMFmKA+WneuYsgdLC4AzwVJ+06FjWYEbGOJ2O+4qPyEltNgEZlEiiG1maXsTvDEcGNlv96n/ErG1m2WTx22CEG/d1H/8xusq2jGrAlhmohyZpdU07dBf9sytzK2MTHTV1MsZtXrs4k1+JptRMdsZSGgIL6WpMqQBJoDTZhvoGKxB/FubSGSLXiA/iUQrUPVytxbPSPxebuV3Omo+c4vyZh3GelmtVoqsi1pMdbk2xkwseiKnulb3XRAIzy6cci83ILJBFUVJQYrqKH93vNtbjMu69a2B2nJaa3pBfMeKsx1VaewvpU6JIciOPcooXXNYi5i30KfH7G4SKK1nKO6MDyLGrdYzgzGgGNQ52F9SYIZD5uIkSf5ViX4cnUxcYRsl3ernv9Yj1EFvu1gXg6nk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(366004)(376002)(39860400002)(1800799003)(186006)(451199021)(26005)(6506007)(6512007)(9686003)(6486002)(6666004)(478600001)(82960400001)(54906003)(38100700002)(110136005)(66946007)(66476007)(66556008)(4326008)(316002)(41300700001)(8936002)(8676002)(5660300002)(7416002)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pn8yJT6J1dIykYoaVuuFWoleX3jjYVPwaEuVfok1fuHBcive+X4I9ueL5nww?=
 =?us-ascii?Q?KVvqCUwqQMn4s2TFHNiMSiouZa1eTU9YCoWBnucYbQ0O/U+pfpYkvf0HSxNd?=
 =?us-ascii?Q?4COhUK6DKoa6xlZXpmOrJGGV5mPz+LEOgrKYGQ6z1a2Z9gxu94yfiAGEhGgv?=
 =?us-ascii?Q?GHY+/InR3YdWrNHsGtL20Mfmt/FlHeAUtvqAubTM5lf3p35jJkivYBGjd4gZ?=
 =?us-ascii?Q?iNuR0j/TjEuDMVHVd6ZVqYLmanph/9bdAKKzyqi63WHXo9kTz6VFwe59Tv+b?=
 =?us-ascii?Q?tZwslVNZI/+cyfbXehOJcBNXZP3xj9PBHE8QRtu3BFqB1aPvGfSWgM5jJSm/?=
 =?us-ascii?Q?ut6+tLBIRZVPrQTEGqOWfyCFk2dBixY3UM1JqXCV3i3lFJQ7VldVZAMicMZ5?=
 =?us-ascii?Q?e6WYFjkeIa3iecWys/c5ljsqlLC/x91QuCBn3mPPGdZyRw9JpmYW04UoBkXC?=
 =?us-ascii?Q?gB28iGZn9otKs0fU7KwhAflUr3zQexiQwdo8cld80EpQRJxUvj2YMfoDmQ4q?=
 =?us-ascii?Q?vhBKvO+kU4BVsxanIDx7jZFgGNvPdR+iiIqOBBbQhHL44SZyWoqW/rBz1kUe?=
 =?us-ascii?Q?5CVPnVKQJKpdXhmgQsjEC4N8TzBy9EsmvOKG+8emED+TiOEJcMvIy5azTOH/?=
 =?us-ascii?Q?fM2i+0MiD4d7obPyjL8ufPb7Z7FcElohszKfEW7eI1TSBvSytzh7dSiGM9kV?=
 =?us-ascii?Q?1lc7Q64eDvymYM4Vy2ZGKqivTpATUgHcfynUMRwdAA0IY7KlJ3T8twC/qiQH?=
 =?us-ascii?Q?UO/2B8UCTpZ0+UnRKf1qRZilFA+sfmwgMuBxxjKH7Qd/f5W+pVUcFLS1p9Tw?=
 =?us-ascii?Q?mgW2GK3cj6rwzShYm812vqJDOGl3YHd6D7vJ4iwi9/I2fhAgzBL3cKgFI3on?=
 =?us-ascii?Q?BY7Ab4Uxz9TLNExv4Qelrcr/k6JMdSbaSjJ855M5hl+qoLUAv4bnCk7pkE4X?=
 =?us-ascii?Q?er9dp5jMqCzADzX0QBsgN2cnADMKnvIe/cXud6kkeH9dIcvrxfMI21w9iC4o?=
 =?us-ascii?Q?D+oV3QaOfbI3/P1wUdaC2bOaYJn8QIcAeNRPrWl3co5HuX7su4ctmYcN95d8?=
 =?us-ascii?Q?HrXXOto1DoXf0M470CF6Y3P46eJbvTzKF0YRJ347DJ4QLINgNHRjIFXgHoFf?=
 =?us-ascii?Q?VJJl3uIU+snOt8bnAean8rxh2tRS7tpXzyGveZwQZdg+31pngXszHe6FQjDs?=
 =?us-ascii?Q?YFJ1Co70gH6/r/DREyel4/KWdpJLLaloPghpKDZS5FmQW3EczEUDQjYMcmFq?=
 =?us-ascii?Q?h98mVMKuaqSj5Nd8V88jZny4i28ucWeMgGbwVtCnHEmGS6sYnw8sAdvQvtGM?=
 =?us-ascii?Q?DqiosZlBRauAFs6XY6tPh2nsTN+5DbqXKdY2lDVKxf1muPyN7kNwIoe8HwmW?=
 =?us-ascii?Q?BgeCsqdjeSZnmrrY4dQKcSLt9BEsV9BPxqsnFCNbenE4JN+CE1blbT4GI+aJ?=
 =?us-ascii?Q?t2FoslJYiT4YvGnTN35oWAGqXYxDlb6UhgRZMBzQqG6GnnRDl1a6/8NZsc19?=
 =?us-ascii?Q?EFfHG5aKCgSAMGkUK7eZypRjjKHF3YKNaHaEMUYvbq9DVOVPU0GwUd9c2SRG?=
 =?us-ascii?Q?drDdqM4K4iI87L79YqMdYXWXJ98EzAy6+cZbSuW6MtD5yGwBcxmJHN6mQOMF?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b7bce2-636b-419b-71ed-08db983bbeb7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 18:17:37.4214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unZDo+IzhrliBsZz/tMKYOlgg7Ng/dS8eyczFzMPco+9vGlUEEh32FOdRPbivEA8RI8CNMxZmXhmlnMmCSxNcZhtT3qYZ2hFYhvvdda1+XU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7363
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

Dionna Amalie Glaze wrote:
> >
> > I do not see sysfs precluding a use case like that. If the kernel can
> > call out to userspace for TLS connection setup [1], then advanced user
> > can call out to a daemon for workload provenance setup. Recall that TDX
> > will round trip through the quoting enclave for these reports and,
> > without measuring, that seems to have the potential to dominate the
> > setup time vs the communication to ask a daemon to convey a report.
> >
> 
> It's rather hard to get new daemons approved for container
> distributions since they end up as resource hogs.
> I really don't think it's appropriate to delegate to a daemon to
> single-thread use of a kernel interface when the interface could
> provide functional semantics to begin with.

That's fair, it's also not without precedence for the kernel to await a
strong motivation of a use case before taking on a higher maintenance
burden. Unifying kernel interfaces is important for maintainability and
difficult / needs care. sysfs simplifies maintainability (but exports
complexity to userspace), keyring simplifies that (but there is a valid
argument that this is not a key), ioctl complicates that (it is not as
amenable to transport unification as the above options).
