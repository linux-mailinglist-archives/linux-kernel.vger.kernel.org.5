Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54CE79C324
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbjILClt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240514AbjILCla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:41:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B88FDC89
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694484410; x=1726020410;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hVeW33BXB86s9TOUEiDeQmk69g4LK06OgfPPiVQVGaU=;
  b=NSwVWmCs9XXi4OuJ02Y/dNKCo5UoscxhpSjGYkeZc0jOkCmrbzioYmZ3
   9woCUd24eO2E6BBjoQBMbcdhyiNvCLEC9ejIkF8dm3FL9otcmhKe9Omdq
   dob9OFhm9t52jrFkSF272gSkEutou7s+sAg++441M8IoTOeTj5YoCZihk
   1a9Tij8rtyRkx3OeNATsJ8Iaj2d+KcISIwnYOhcjWBveOh4Nei6gi3MgC
   oA3DZb0TDvvaTN4vkaFCGyCDLyxqwcDgFLZS5HSbK6SSdVh2EloDoc0Yg
   UST2uxEaBOmVGKDRAwCH9+dg2CPYKFyILoKf7XEZAx+rc27tBkttcYeKM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="382061078"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="382061078"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 18:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="867165946"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="867165946"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 18:26:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 18:26:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 18:26:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 18:26:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 18:26:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTtvm+xIBANeJa48xfMfOrYsbVaYJUm/rlgxzonheTPNDw9OHpj+Pt8ZhCJheGkm/ZkxjHDV0yLLAcvV14J9dCn9u/AC1uyVz2rUg7ErwO5q6C/Panvqn1b2z4grSLYsNfvYL+JUKR+gVX2hLR2qlNl3nKDsrQ+jUFCuBM2BogsOb6A/gSUqAMTa6iW8u9x1LBp9x7dN4Q1UujuOSrpIHFjGEd3BpJ1NC+db5PPdRXbgV+MxEgs/0o/SLvpQ0WZeY1sHSYd0w3Pmxd70516Se5tNk4zQO780lBbm1yg31E84wb7D3Me2v53ttlXnRFkqkbqnw3xPxOkIn7gEc3VREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnNSzZQ9X8G6vAcQwT7U1OJZPIOLKpD/8xlHd88sNZI=;
 b=NMwrNnqIc0LbPR3oKyKFLRN6TfoN3JjypXbyVe6D9JbEW0/uHuVVg0+rHvJ2FLr4tbEsMAgIX+GOgJHbrkGXjqQ8Ogq+NwzrzryqQlxKSXXMLpUmFcoW8UvI2faMhgMHLu1nMI1UbxafJeOfSplDlZI3guYV5s+0Dlyjz1DbWdtW/ABgT1ZnxaFKW/TMSQB+JuM4+h4XCWh9B6hP5fCzePiZJQUDhNBvFQiBVA47ofGmGYYo6eMq+vpRnX+JAK/aZKfFHySOUOV6zyF5vt+UfvFmMzNnKGHbT5BqPTVj7ndgtHerezLyBFAV7KVIsr2zgApHAWY0mjxhbnSG/nmM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BL3PR11MB6531.namprd11.prod.outlook.com (2603:10b6:208:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 01:25:57 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 01:25:56 +0000
Date:   Tue, 12 Sep 2023 09:25:45 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        kernel test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: Re: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Message-ID: <ZP++GV9WURg1GhoY@xsang-OptiPlex-9020>
References: <202309081306.3ecb3734-oliver.sang@intel.com>
 <C85F44FD-BC7D-421B-9585-C5FDFAEA9400@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <C85F44FD-BC7D-421B-9585-C5FDFAEA9400@oracle.com>
X-ClientProxiedBy: SG2PR01CA0170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::26) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BL3PR11MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f3e9c78-e6ec-4d33-8ae0-08dbb32f3675
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BxkWbL3HhRyUn2iBTRVR+EGHb9CvfCuR4b2hixkrKOrDYqqlE5U6Rz3g+/+Y6gnC/BulN2T/SIenpn/1lmBQOUFfZhnqBEz5jm4lPr9TR/4U0MktuQnNdlmIRLB1vaU8TbGeMV5WifszmbUsjSguZGdYboZ4Jty6SEAglZYZSIk0vyp3DVwhO9E5h/Lgmg1u9gbWXqH4DMylrygJCimIMyKZYno/5kWRCVdfyk17PV8NJSgY78C9N3qstHAWm6RicCBKrtvDDy7wv96RdM/NW3rL3MlsBmfNauqsyj5HuPDInlYhgvZM7LCpSRgeGxOG5LaYdVfADfGB2Q/c7lKjPcXfTGXDFhstJzHdXTVhxNZGVeNmfYVH6mF9sOj7uO9SSL2WV33lbNxvlXvsnzVWV5pp+HZEULgU41GXSCZ+bcrehHZUvTVHz5yTprqmi5xyrZX5vvpEHOGSwaMNLsLWh1IBJ+6pSkkO30Nq331VWlEtkcbgNn+mYCPvZlJ6yFC5Fm3bhC34WhJ92p2W75sqNJiEg/dnWE924L7d0CV4eFLFHE2jU/vavMnuTfEWxp/eWO9afGG/P/B9wjg6jplm+7IPp0Nisd2TJgi/UO1XSdGG7Xe82ze0sfhlj9u9Q9jX2wWGnMfxrRvmh+rmPbdNfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(33716001)(6666004)(6486002)(53546011)(6506007)(9686003)(6512007)(83380400001)(966005)(26005)(478600001)(2906002)(8936002)(66476007)(66556008)(66946007)(6916009)(41300700001)(44832011)(107886003)(54906003)(8676002)(5660300002)(316002)(38100700002)(86362001)(4326008)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XoJp87eGUF5AVDMNfL3HVLgCEj0/Xcg2YiGGHZvORe3EJ9BpdTQ7U395DMHR?=
 =?us-ascii?Q?K1Wfv3U0ONSlnaGDizS7V0imryd2ov3tFH6JoNNs+bSy/KMBl/tvHFO3DXuo?=
 =?us-ascii?Q?sUmW7ONYdBqO+gcyBE7KwhonIE3vjk5Rf3T9XNsAqzX5PJV0aV6htcs9XVc6?=
 =?us-ascii?Q?Vb/pn8X5nwUiqUJ5arIoEibyVRuoCoK7WsvTx5F4jqW1PJhirF9o/vsH5u+F?=
 =?us-ascii?Q?sGZsBL6YEImm22QOY40vPu2kdN5YhFqTAHSZtpT2rw3BbUA3rCBKgqcG5cCj?=
 =?us-ascii?Q?rXxMvEv9IgUJJbw4bJLF5gOSYV8QCYLThhdL3fFQdLFO5hYxadK+R/DvCJHc?=
 =?us-ascii?Q?1J4yhFiy2xINXpxo6vLc2oE7JyyZUC0SXAVs4vFIJOVWhMnjNKLmQepHF26e?=
 =?us-ascii?Q?eToFQS38qapowyQ7Y2fWfmvGzBvgM994abhDbInhpdp2LrsJcv4QrgADzwYC?=
 =?us-ascii?Q?3bPvo7fRKULDnA13syo/54BZmiAQbT/vMkrsYfm6UUlIeqlecYLT51Y6vyTz?=
 =?us-ascii?Q?N+TyS4F+pvG1s2moy/Kv0WIM5wokQDvTJqOQtTQ8LZdlYUJY07qna56VlFZe?=
 =?us-ascii?Q?JsUtAbs+SQBknhcEIMY5qQmtz/+Dnwz98A/9XwvpjdguIHKq9jgo1rwwXMDX?=
 =?us-ascii?Q?GjfObBdDWsQ8Rm1cE+wuOrOwQDuAlIQIhtj1S1fqg+FI5nrQXqxs5k2rT7IU?=
 =?us-ascii?Q?TydBGL8yNcHdt6XbByo1bqCauoUUZJ1g6FgtBO6P4NxfqGMuEaOoMEQK2Uqu?=
 =?us-ascii?Q?tXDK9EmcL+CJQJb+ZFLZ5GyK9ci/n9cwbFm3yUyVhSKAAftKZaYMuoGjwSQa?=
 =?us-ascii?Q?Oo6JMxBWD+rLB0yiqCWRYhHUwB4YcPKoMacfMlm44VrN9rLdzjmbfaKJgn2V?=
 =?us-ascii?Q?IllrnSw0mTZfotpRPjBzJvJ8LRo0AtA1ZwP2cLW3pKZ+wKqzXxf123FMe0Vo?=
 =?us-ascii?Q?oj83qbtczkmgPQ7UyP/oofTLdy7zfTzAqLyWgxjeEk4dm60SnJAJd5uv5XxJ?=
 =?us-ascii?Q?G1H+caYE0phv4p03PU5MiH+y1p2wkwvMIsFAjzfEgT+KU7I/mvvzV0gFzKHt?=
 =?us-ascii?Q?5N89UQLfxa+3j0KjtHbr/w5sYquSqlQXdLpTChsAIeaEzmUPcq+BSFeqeYDO?=
 =?us-ascii?Q?NP5nFTzsgQmvsysMe6C0hmqFHrQSw62BRc6Lw37TQBE7eZi29lzxJuzMVnM8?=
 =?us-ascii?Q?laKLqQ5TMpdXaNEt/bIWRxV0SwJe5tV4kfddId2lzfnLDMo/I+4jCfxTi2Ok?=
 =?us-ascii?Q?c2UfsD74uQiav3Z7e+ORE7m51aSsjTnjCIHVyOjex9HoZqV/k77uACh+e4y0?=
 =?us-ascii?Q?MrX0/b05m504C0djXmPFmdwB/FeJATbYUaJrwjtk8b10R3zlcb6Cz6KaOm34?=
 =?us-ascii?Q?m3FJJsn3t1tCKjUDs0lr0Gx5c6qtI+9uk9QxTrrOBgKW43af9w9Dokawscuu?=
 =?us-ascii?Q?KtPPeXOzwCXdK15csbZXTsnbgI1nJx9Qy3K/KIklT+GeaR/0j3Cx2wsZjO0B?=
 =?us-ascii?Q?Vu4cw0LJd1xcIg7rZjDtbwRr7VM3ASODfk75TNG39ECUCjphN9w+3mroRq/R?=
 =?us-ascii?Q?8A+DZd6GzTnFQmb9BfMAeynpDPbpxuYPRRiWj7Jpcs1+6D+HTr7Vamaugkit?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3e9c78-e6ec-4d33-8ae0-08dbb32f3675
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 01:25:56.2726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlkQ1OEpexpAsmaNc2e+EZFnj9ZlbQAn2z0nzs/k5Yn0rzhvX29yjrBfhzSllWrx0lwZvDhrnRsRZ2+dsyQJxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6531
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Chuck Lever,

On Fri, Sep 08, 2023 at 02:43:22PM +0000, Chuck Lever III wrote:
> 
> 
> > On Sep 8, 2023, at 1:26 AM, kernel test robot <oliver.sang@intel.com> wrote:
> > 
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a -19.0% regression of aim9.disk_src.ops_per_sec on:
> > 
> > 
> > commit: a2e459555c5f9da3e619b7e47a63f98574dc75f1 ("shmem: stable directory offsets")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > testcase: aim9
> > test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory
> > parameters:
> > 
> > testtime: 300s
> > test: disk_src
> > cpufreq_governor: performance
> > 
> > 
> > In addition to that, the commit also has significant impact on the following tests:
> > 
> > +------------------+-------------------------------------------------------------------------------------------------+
> > | testcase: change | aim9: aim9.disk_src.ops_per_sec -14.6% regression                                               |
> > | test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory |
> > | test parameters  | cpufreq_governor=performance                                                                    |
> > |                  | test=all                                                                                        |
> > |                  | testtime=5s                                                                                     |
> > +------------------+-------------------------------------------------------------------------------------------------+
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202309081306.3ecb3734-oliver.sang@intel.com
> 
> Hi, several weeks ago we requested that these tests be run
> again by the robot because they can't be run in environments
> I have available to me (the tests do not run on Fedora, and
> I don't have any big iron).
> 
> We wanted the tests rerun before the patch was committed.
> There was a deafening silence. So I assumed the work I did
> then to address the regression was successful, and the
> patches are now in upstream Linux.
> 
> This new report is disappointing.

I'm so sorry that I missed the test request for
https://lore.kernel.org/all/169030957098.157536.9938425508695693348.stgit@manet.1015granger.net/

just FYI, when this auto-bisect done,
head commit of linus/master: [65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4] was
tested, it already includes
2be4f05af71bb libfs: Remove parent dentry locking in offset_iterate_dir()

in our tests, the regression still exists.


> 
> But, I'm still in a position where I can't run this test,
> and the results don't really indicate where the problem
> is. So I can't possibly address this issue.
> 
> Any suggestions, advice, or help would be appreciated.

if you have further fix patch, could you let us know? I will test it.

> 
> --
> Chuck Lever
> 
> 
