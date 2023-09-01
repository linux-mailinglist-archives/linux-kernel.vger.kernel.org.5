Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9857903A0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350897AbjIAWZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350827AbjIAWZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:25:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFA726A0;
        Fri,  1 Sep 2023 15:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693606555; x=1725142555;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xsEaZM6cNnmLONcGRU2ffzvJkmOurGS5NjO+1Rm7yag=;
  b=M8UMjNg7jZl+jel23IIgcwu8IRstGFvFtvfOf51NYsRRgnkec6Qils5C
   vSHnBOrW7J5MXHp+aPCewHwSy8+qKpNgBUaWPV9wKLbLtcqN4cUCfxIdY
   HdFHKwZIbeRnaK7DNjk11IMGVmFXJ2LgElkCCmohR7xsKTx+/pzbxAgjU
   hNqvrvSLwTnpzJznCUg+ToY2VNZ6E/jGsgVp7TEwAldRswAj7L6BNVPX6
   TN0zH8NEhZueVPRBBjlhOiE83iLELet62C934TpuW23uOsFn6CUUQp4Zc
   3NgjzHwbR/q9CcYJsjXnM3fsXbXbo66ZlHFBIey+5Gx/QElXYhQ3TOzTO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="380109768"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="380109768"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 15:15:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="769335590"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="769335590"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 15:15:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 15:15:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 15:15:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 15:15:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 15:15:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fy6ui28PA89SqzJhB+oKi+ssgbCSAUmYWXekyMNnyuzfqILxbyHM5xLxgPvBmSA3bHK6idGmwGL2VSDNgfKk8+BHOOaGEXkcj/Zrirwk10j5YweekGhLKZjYiqYzvaqFiDSaspH8zowQEIiz0Q4uT1bYDPuVEHDNweqdwpFje09LPEupFr4CWJxLbFAAdNs2woPSxYwxRQZJMiu0L+K02zWaXAA5GprYC+yeldMDG1UwwKTwpx76BeCBKSU83tzTub3ZHXb5zYfAxVlsfA2FJtamg9bKL8lEaGV3RWyUnBElZBSr0VvtRim9CziwZqp4+rQWhqFLCL5JPLBDz/Hh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/O+820x/JJ59Ts9eOaW3WJ4OcKJb2tdmYJ+OEoJFGY=;
 b=UW4iIXrjUskPq+IRQ4AiNUeZpNDnO/0i6mCu6NXpC4lXJWTEFpIYGYJYoDHHUdY0WLqmcykO1LRhzYivz4KCI+TIRTLlAoe81xy/Evxc3ldlwVxkQeufG08BVkTf3A0Gpy7vDy5T8ll6LwLGJWKNgJ1JEDg2X7eR4BkWE5u/P1NyF0Fd5BRNcZ/Rk4GS4cJELGPs7Ki142uTYQaQVs93dYt7TirNszy/FEfWLibjfdxj3VIPIp0W5E2gtPM1+S0P21dLS0KKk5P8ZddredWPRe/XFJMTUu+jeRgNBM1wdy+FLyRbTMAxiNgcWTmOa4BkZz0FhvwMs7R96j/dvZf/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MW4PR11MB6981.namprd11.prod.outlook.com (2603:10b6:303:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27; Fri, 1 Sep
 2023 22:15:22 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 22:15:22 +0000
Message-ID: <cea65abe-127d-8c8e-9185-1aeeaee3d4cc@intel.com>
Date:   Fri, 1 Sep 2023 15:15:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 3/8] x86/resctrl: Rename rftype flags for consistency
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-4-babu.moger@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230821233048.434531-4-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:40::14) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|MW4PR11MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 3597cb30-3886-46d8-a78d-08dbab38ef45
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Inc7DZ2+jEWF6KtllJrWLQHFTdhswUp1siu0vPBXQlHDkUWyiljJ/Qv+Ns7eqFYWOu3nR065zBCYJxXUj1KFC4DYhEdU/HREKYdV25lnUnq1sKMds7K5A1BX3hywRx/5a/TeBs8c0jxTXJU60KoCHL91CTNfzZJaowUxIruV0B5Ho3jQGJOQsPGYji82TUY4+PSNZ77Hyl7u/uyfPkNu1vpZtSVkNsJ/Z5rKx7+5oRZm3S5+bDKLD7m5w7qAWQ9OZME03ovED47OWFG1iBVZ9zW48oLv2ntWjt2GbtQrNezHE/nZ9JzaJQ+cir9ct9Cz8at/7j6biZxfMmBHv4GW+w688dLuMrnhWUOtEVYNQdy1Z3X2UEn7WrKqic/tThjHL8lDM+h3YXtqypN3xeZL4UDXsezpUhaLDIBbWpR+bmqQEHJPSF0l6z2w9NMviAe6R4GxIvaU0KINDus2493R73jHRI3346jJkq0oXvG423NYdZIIaaNRPEijf4tjzSE8+7/dqdouwptn7QJ0i4d2kJ2sREQrNB9yDjn2YDi1upIpWIhyxLGjo6wfPi6lcNGFe1qn2CjEGMswH9oPFZS2LjIIkfcAAZe81un4hoUoUp5tKoDce9/jDEXU9E7NW8LMuLEdfth/PDgWWjL/TZpXTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199024)(1800799009)(186009)(66476007)(66946007)(66556008)(2906002)(4744005)(41300700001)(7406005)(7416002)(2616005)(31686004)(5660300002)(478600001)(4326008)(8936002)(8676002)(316002)(44832011)(53546011)(6506007)(6486002)(6512007)(36756003)(26005)(38100700002)(82960400001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0RxREZiTWpxRS9zZEFNZld6TUZBZUhkdzJWN0pveW1NU2hZSjc0b2Y1VHhy?=
 =?utf-8?B?eXlWVVN0M3M5RCtMTHdxVXNabmZXaW9UNHVUZ1h1VjN0bTNuRHoxcmpwWTBU?=
 =?utf-8?B?eEZwSEZLN1pvRTczWEg2ZlZKSVlmam5sYUhuL1NEY2lYL1V6QVRtN2hnUE05?=
 =?utf-8?B?RUttTXI0c0JBVVlTcUpEdldrZVVXRXJqTlllb2FiUEQ4c0hIRk1ZVllXSmNy?=
 =?utf-8?B?VDBYWGQ0V29RdzduVlFyNjNIeVlPWUxjYXdWSlV4U290VXAyd1FRdGNOcTFR?=
 =?utf-8?B?ZWdkUi9jZFU0TndKbWlhUXErZEdHRUJaUThWbWhkalo3WFRORlo1ZHQ3Zkpa?=
 =?utf-8?B?RUZ2NFZnbmhPMUdkQ1dnNTV5eTVFbFdJTnJ3K3Axby9NVDdtWEJGTWJmUFhN?=
 =?utf-8?B?TU1KWUNUTEU1ZlFkbWE1aHZKM1hDY20zbUt2UVJpT05DOHcweGhheWFGdUxo?=
 =?utf-8?B?eHVUSnFTZi9vQnlrUlI0MU1oY28zZE5wNHpQbGw1VWNRSkw2bFE4WUVPWGNQ?=
 =?utf-8?B?SndBN292ODFjYzlPOGh3YTBwcmMwaTFRSUdsclRHbURUSUdsVmMxZjdYRU41?=
 =?utf-8?B?OW5ha25sL1hpOS8xSUM5bnhuZmp3ZkNFcmhmZ2FEeTJGczB2Y082Syt4WTZq?=
 =?utf-8?B?WWE0dHMzVTdseVQwZGlhWmp6dkNZVktRaVFjeTFPb0FDKytJL3k0ZEdKOEpV?=
 =?utf-8?B?MFhiV0JoWEY2a0VkbzJ6WFdvVnlqR1N5YzM5Zyt0aU1pWmhySHR1Q2dBb1d0?=
 =?utf-8?B?ckg0OXBvUzlvT3N2c0hQK0thYVRKSExNNWxJY1N3dnp1aXlkVUNuMUVYMUNZ?=
 =?utf-8?B?am1sZ2orVmdGMkxmY1ZoalE0YnBTdEp0OG9XY2RGU0xwRFIzVlVQbGkwRlBJ?=
 =?utf-8?B?c285K0VYQlFoRFk1M1VMdm1ONkdWWG91MXdJaGx1cWgvcnd1Skk3ZFM5WmJ2?=
 =?utf-8?B?R2ZXZnVLdnN0Z3UvMTlXY2xVWU1NSFZaT2FvekVMVXhsa2F4SVNVU0xEWmY4?=
 =?utf-8?B?akRERW9nUnBnNWlBeG5ua293U29kS3F4a1F5emdtM0VobWVOcnR6Y1dMUkgy?=
 =?utf-8?B?bnVWSXBrUUgvRHkraG5jdTdLSEM3VDZDbUVVNGZTejV6aE15dzl3WjNvOUFJ?=
 =?utf-8?B?WXpzL1oyQ3NqSldJTUJFWVFEUWhRWFB6Qy9US2QrS2xRc3VlSlduL0tSQkhm?=
 =?utf-8?B?Y1lubXBNdFZtSmI1QW9yOVFhOVA3WnFQaVd2S09CbWxaU2pER1k5V3kxMzlI?=
 =?utf-8?B?Nk53S0RYVHdKbUV0L0hPNTlmYjZIUnhHNjVKeWl1QzdlSDNnNkpUUE1iU2Y2?=
 =?utf-8?B?ZUtqdVZPWnNqUUh4TkVBRExMQ0grT1h1Q2ZmaHVlRFViWlFGc2JXU3cySy8v?=
 =?utf-8?B?bU54YUhhVDFJT2JXNitRWVFZdGlzUnRJZUVyVThsazFLWVdrWkZBT0lBaFg1?=
 =?utf-8?B?SU9zcDB4TUY1MDZKMDlYMEt2b0ZmZTJPcFFkc2k2dGtPMlp4UnpkcjlhNXNP?=
 =?utf-8?B?UDk3ckRTUGpQNmFEOENwenRaSDV0c2JYYmttRGlwMGtkVkttLy9MZHMrc2Jp?=
 =?utf-8?B?eFRIay9keVBBWE55cnJvWnhNOUtta1Qra1lJeTcxV0ZLTnJHQUdkaU83dEt0?=
 =?utf-8?B?amhQUVE2TllnakozT3ZTNURlWE5zUDR3RmFhK2E3VXBLL1Y4Q1RPVHFBemNj?=
 =?utf-8?B?ZHJLR2ZYejZzdkNRNnMrTlBtekFlM0RTaWhVcTFYb2I3b3pTN0xmbHVJVSt0?=
 =?utf-8?B?S0tZKytFSi9jNE1lZkVDcnZIN3lsYTBTUXJzVkRMR3dWbDQrY20rK0dFUzgz?=
 =?utf-8?B?cVNrZ051aFUvZGxJcVRzZWNnb0JsR0ZhOTZqdm9kRW1hVVRRSGd0cnNUMlBm?=
 =?utf-8?B?UkIrUHF6R0IvNkpzcEtrS3B2ZHJZNUNvWG9sazZxeVgrZ01tQng4eVNFam1O?=
 =?utf-8?B?OVY3WFdtdTl2T1l6enlUNyttbStDUTNqRGQvZ2pNcUNGc25tRVZCem5IcXBT?=
 =?utf-8?B?d2VRL1JGUWFnMTlhbG5XdStpZE1jdlc4K1lTbnlVWTl3VGpHOFYxOUZGTVdh?=
 =?utf-8?B?SG95RDQzd2NWK2Q0MVpPNlR1USttMHBSYytza0JFTVRLcktkMmdXM1hPYTBi?=
 =?utf-8?Q?Elkxb3bqLmBVDPYDuy1/AP4oW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3597cb30-3886-46d8-a78d-08dbab38ef45
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 22:15:22.5926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcBM6jrPo1O3zh085MYTib5fm0sVXO+9ktbK2DsLT4UGQVdJkJg/0RyA63iMWgRHaz2If6eLvWARNSpn64GRiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6981
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/23 16:30, Babu Moger wrote:
> resctrl associates rftype flags with its files so that files can be chosen
> based on the resource, whether it is info or base, and if it is control
> or monitor type file. These flags use the RF_ as well as RFTYPE_ prefixes.
> 
> Change the prefix to RFTYPE_ for all these flags to be consistent.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
