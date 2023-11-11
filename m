Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65D47E8807
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 02:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344613AbjKKB4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 20:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjKKB4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 20:56:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8F044B5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699667778; x=1731203778;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=mpRz2WwnD0LL4zvI9d+x/d0kvwNlu2Hm963x1GLzqwo=;
  b=CH58egDLs/AvDtpcVXu2yos2Z6FNcUVLEplgftuY/7+o8ON9zc/oHAmv
   bXh3Ju4qqOeunt6EPvXC50Duur1cRf+SyHN97OfDOBEaSwT1Oku2uRCae
   izG2g6ZXJwK+fsb2sKuR9///XFzs8T62cP3uq0NsnxQBARSBHYU3GG7FU
   7LxPd4hobESi1mNSw1e8qfVdwTH/AtZcopwhKrzL1uGPV7pRfy68NHc1n
   BMyzecvvIPXFD4wrDbIGtYg3tT3aBw+dgcDpojmNiGK7T0UGBF56HtLwO
   4V4+t1rv8QmAbvjrkbSGZK5cc7qHpV7DMthJsUgy/gTwSmnu4Z3l/mNt/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="456746983"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="456746983"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 17:56:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="763867873"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="763867873"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Nov 2023 17:56:18 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 17:56:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 10 Nov 2023 17:56:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 10 Nov 2023 17:56:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJrOAFv5IfBg3ktSPBdhFSaMtrj1dCqCMCUKHtydDI5Iie7D4U4mvJxUGn9PHlp8grzTgQuVLeQKtab3s6up4MAEloCAhN8DQtH8eE3g+D0M1DT/F0j94zQMoYyE7sDPD71TElPvf73vuvWhaFSdpwUbLh15pCzEOD6CjPMuu66fpwdAZ5Te3k2lKQs7iuL3ZPNLnGTQ/A0MP0dKqM9wlqzAUrS2I8n5+17J4RauJtzPmxaTKWMcTNNxa3/tKf/tNRfRy68RS212xbJqgvMkrRi9fJaTRiGK8S7XFfnNAGh5/RLP3lW1b4Xb4jQOE433hLNLH6u6N3OBghk/BVyRXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u92PzrvctkhwnbYKlRWpf21htaMZtd/Q33tdOC16bsA=;
 b=D44d2EFCp9oxGELrxMJg2plTz1sJ3zA0UQgAhUHQZVOdlKp8ObbfPXnaYKZL05YfelBSFduoCi2irnNc4yHmSSA8mOJyEeiGROfzDxwWOmwnlYGWtjtXVuZBw+Q+I8zaVxkHYyHAhu77rjtkPG0YopiXVQNyJB03wwz6OnvK2WHQcqAJhoJ7CSiYnAuasHXCbtSfTh/6eac+VpWUFQ4s6wFLeexSBtnl4hwFxeZrIoYRQ4BMm17OKNe3fCC01KYtrbMjaysAtHTcnS8TQNLIu65rPwHHc+ep16HZBEcLT34eQKsD7TjK9CWSiTWAhs+Vz1EFFrWA1OjH6VDbk1poVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.22; Sat, 11 Nov
 2023 01:56:15 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%4]) with mapi id 15.20.6954.029; Sat, 11 Nov 2023
 01:56:15 +0000
Date:   Sat, 11 Nov 2023 09:56:07 +0800
From:   Philip Li <philip.li@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: mm/vmstat.c:358:9: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <ZU7fN28blHi1z9qS@rli9-mobl>
References: <202311080409.LlOfTR3m-lkp@intel.com>
 <20231110154312.1xjowQfg@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231110154312.1xjowQfg@linutronix.de>
X-ClientProxiedBy: SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|PH7PR11MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 81506996-3921-4c48-2c2b-08dbe2596390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWDm6TJ+D1Rc94Bjp92UpRSNYNkvmR35K6PkL5R6cvm5gu36O10t0KY2VuB7DqdHlMWmwhg/bbyovV5eN6tM6Y97j8BcYYxbDD+iWx8wcw1CNvRkKvHQQ05mG2qXzm1EvEY3Gw+CP1AW8FesBhobdNCGssoRzJQVLjrF7x2ROwh6PAiiKcMij3kT3ImD1nK4szbonI0QYiMCN+4C9MMGRMqIqAPpEqgvxZi/5KjssizMPrwRrIZeHuxF6FZZ0X3nL7eNhUMh4CFgHXegdI/Rawbm3ues74iTWGB7MW2+moIGT01uQmEQHBYsZDMjHz1rNW7VhiWq23MsQ1+Oi61gmgMKptPjzXETubxa0+oO6KU5lzt/MSazn3rOZekZDPyyyE8GJvcMEmM5LmKAInD0e72xj2ORTCY3oTh18u8jnyNEav+9+4ODskKCKpcEJvecBdk8sS0vqR05e14B6TuDkW/TSWqx3kiIgd35vTltEN88HASw/I9gREf1ZFuclp8OaYAnoI2OqXLRJqMGYaD2ZY9Ybi6uqMHhzJVg1VPXFmybwOCa+BCI4QCPs5zJgOPl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(4744005)(44832011)(5660300002)(86362001)(41300700001)(33716001)(26005)(82960400001)(54906003)(66556008)(66946007)(66476007)(6916009)(9686003)(6512007)(316002)(38100700002)(6666004)(478600001)(6486002)(53546011)(6506007)(8676002)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkpveG9qQzUyemZ1UUFDV05PcXo3aG5yMWFLYXhMeGZTMGZER21KQVdSVGI2?=
 =?utf-8?B?TllnM1lWRUh5OUZlN1VTYlB1amNHQlgvbGxtbjZmOHdQekVsQUlHRVZqUytY?=
 =?utf-8?B?SHh1T1BIeGVpbHlJZW9WaE1XUEFDQkd0dWltSmlSVk5tUjFkNC9oN0h2c083?=
 =?utf-8?B?MzlzZW5aWHZmV2d5blhHWVBOSWVSeGJGSzd5NVRjSWpJekJRMUd3UmU0dEhT?=
 =?utf-8?B?ejFkSk5YSWR2MjEvNzRUN3dkWmhuNE0wb04veWlHQzR6QlV2QzFob0ZMck44?=
 =?utf-8?B?dm4xOHZvZEVkZjhiMkdvSHBDQWsxKzhua3FXeXhKNE9OakQwQ3VIOTd5M01T?=
 =?utf-8?B?eHZvK0NncHNEQ2Zoald2MTVTQ2twVE9ZWjZOZ0svQ09qc3ZmZjRvNnhRS3Rn?=
 =?utf-8?B?L0N4NkF1MS9nOWw5OEh4L2ROTStxSTRpemhpdUdYNjlVOWJFVlBpQTFFSWVx?=
 =?utf-8?B?Tmx2dUhMVGdGVVFJcDc5SW1oNmU1MlZKRldzY29YZjFYbzBOR255SHhtVG5Z?=
 =?utf-8?B?NDM2M0hnQU9QdVdGT05xUDZEUnJRcjltZ1dHN1RsWGpFQVp1Ny80UjB1cm5T?=
 =?utf-8?B?RVQzMTZtTHZXY24yOGJaOUxlV3NNdkxyNS9vM2hDeHFKeDBWZmI1MGcyakFp?=
 =?utf-8?B?ME9xcGdZV3lwZDEvWUdDeGhyVURheFRobkdoYTQrNjBtOVk4OGJTVTloUkxr?=
 =?utf-8?B?UVBxUHc2QS83aUR3eEYvVUpKcys5S3gyQWhQeWNnWVIrdTNFdmtCcTQyNDlm?=
 =?utf-8?B?R2I0Yk5UeE9rd1NBeHRXcCtZTmQ0R2pTc09rRkViNnFIYWFoREE4aFpYeTlB?=
 =?utf-8?B?cUhKTktHMEtkcklHNWxyZzV1eHlrdWdPWm5iRHZqaW5wMUpac21VdURrT3Zj?=
 =?utf-8?B?RW43SWlnSzlGd3ZicW9nMk81clJCTkxaVmxhZXMzeTlNMHJLaWFqYUZmZDNF?=
 =?utf-8?B?TDJKNzE2eDl1eUpMZVRSWnhoa1pqb1ZkckdvMnIzY0RTTzBIdTBKRi9IZTdq?=
 =?utf-8?B?U3NTRm1vWkNCRFdnbGJaNWtKcHhJa1NXSVlwSXhsQlQySklIWEl1RlNYQUZr?=
 =?utf-8?B?OVlmN1dnbXcrL3lKWm82NmY1bjRJaFYvK2V3a1B2cDRlQlozZDlTTFk0WFoz?=
 =?utf-8?B?Y1hQbUNkTGtQL3FxMUFYajBSMUREY0E1UERkVmNIVG1GVFpjZDhucTFIeDVV?=
 =?utf-8?B?Wkt6Q1dRWkl6YzQyZ0ZYTU9UKzZJcWF1OVZlZ0lQWVlLb2JKN2RrSkhpSzEz?=
 =?utf-8?B?SHcwZmVIK1F4azlTT1F0UnpwM2t6RTlyL09YNFZpMXNBajJCb1J5NzRDaWhC?=
 =?utf-8?B?YlF5dStIUFR0T1drR3J5MHhQL2lFTmIyK2gza2lPdC9CL2RDd3ZaMjhidm45?=
 =?utf-8?B?MnFBeDhvenNyM0lBclNERE1zaXlYWkFSWWxpNC9LQlNCNXBjRlhpc0R0aU5E?=
 =?utf-8?B?S0NkVklhKzFQMHFwQTdIaUVkd1lvbjVSZWZaLy9oZS9PeHE1MkM3Y29IYmxt?=
 =?utf-8?B?bEVvdm5hQzFxejdzNWRhMnIzTS9sNDFGY1FXaGk3KzNZVEx2SDdVS0RyWWZl?=
 =?utf-8?B?WW9mYUw3YUVLb2IzVE1LYzZ2Z2d0ZU52TmY4TFFSbmxaQzFZZjNWZG10eklh?=
 =?utf-8?B?eDZob1ZzanpRQ1RhMEdrbGV5UXZwUkZmZk9BZ0xhN3BUSUdsOGQ2UXVZTXpF?=
 =?utf-8?B?RkZwaGgzeVpxbUdLUmN5eVhwdm50SmwzNnVRZSs5OVNGM2hLZ0NwQy9kUHNH?=
 =?utf-8?B?NVJENVhnc0ZRZnZNWVpJMnVIZWZRVXFtdTFJT2I0R21qampFUlRWamcrS1NJ?=
 =?utf-8?B?dXBtT3VIWjNQdFE2SW4ySzlFdGx1Q01lQ0toZTJrTkE5TE1YaG5pem12dW1q?=
 =?utf-8?B?d2Z6aGpRQ0ZQQjFkSEJXRFlXUjBmZVVDMDdVZW9wMjNLaUVQa0ExZmRjSUhP?=
 =?utf-8?B?SElNMDFWcC83aXZqTWIybE55SS9GaHBvY3NST2xOYmdFZG5sV21tbzROU3Jw?=
 =?utf-8?B?UnFYS3BZMldLaXVEeHlKUXQwUXNGZGdwTGF2RVlxS3M2aTRxSzY5bTNLWkJ6?=
 =?utf-8?B?TGZSVW5aTG04Nk5WNXBIbVFFNUNZT1NucDdGV3k5UkVUZ3NsYmxlTEFXU2Fs?=
 =?utf-8?Q?/F1Vh8JBTdWDyCBZHNUbTBoU3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81506996-3921-4c48-2c2b-08dbe2596390
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2023 01:56:15.4556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssXm+bSzab1DME+v404iINL/T4KZbHzcxqwAj9ykaM7YJMcZVdZcT+CA90+MKNuhs1+7JZrLAXLDWYouGF853A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
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

On Fri, Nov 10, 2023 at 04:43:12PM +0100, Sebastian Andrzej Siewior wrote:
> On 2023-11-08 05:48:25 [+0800], kernel test robot wrote:
> …
> 
> Same report as in 20231110154208.5UoC_qsI@linutronix.de but for
> different file. Don't see anything wrong.

Thanks for the information, we will check this. Sorry for the false
report again.

> 
> Sebastian
> 
