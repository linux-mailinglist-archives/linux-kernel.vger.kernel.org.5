Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E887815DA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 01:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242734AbjHRXfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 19:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242764AbjHRXfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 19:35:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735B026AA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 16:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692401729; x=1723937729;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jdDpJAK9SvIMsv91aWFe/CygqdnLFJeDPqt1NKmC20g=;
  b=Lyt3UBUsrjT781e1mJCkMD8s+gWD6LrJr+7cg4aH77+9eH8DQXLbtk8B
   Cq+CYKXNTurqBSN8pDukpJsM9xfa0WV9Pgg3Xir2W7xgoYtTsoHXpTWo2
   tXjxuVySGR1m7IpGN4Khl/5SxWa9BaJ+EMjmZLkNmTfA12NebMnc/sHpk
   yZ1oFHzmODgxzMIfw0qwrO4Zl1T46+AC2xuz+YugCiMB9KOa04XGiOwdt
   4KMmKb5HhpYUnouqNpg5CsWACx5EA11YjDtjWD3wgPrQckZHhV+2bhMR5
   nLVvgxiERNmLDSQgZyS6VD1I+vnBy73AcI6+2on2illogzxcR7gf6UI/2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="459587871"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="459587871"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 16:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="738271271"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="738271271"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 18 Aug 2023 16:35:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 16:35:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 16:35:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 16:35:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 16:35:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJ47D9bGa3QqLaIWaFvOaA5FDWWgfaNKrbXg0Lwx56+l9nCmPOutC3UpELV8EMmoFKq/CtuCbCe/VUkxrq5sWSxYM2lWFA4emYjpkmOm0U55UvDk7Cipj/4PAwuQef4uDM2giGwJM19w0clpKm583Ry2ME5aitWdKaYdZT9DFVhX1irLV+aNHwbc8Lq1X5oy7/bvydVI91jvoKYDww4UEu1nWptfyO2zaX8x3WpfQ54r12fmdWmGjItspmOAn5/0+iOinWoD0LtdpMUb7dL5oSRkXezHGuw9sEo+rEXgC2SGokiYFb22709mBwZJIpxwF5pTvFaxwAfTK3KM7EJ+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpZGfVceV/L9XH7+RiyggMpoAhkvoYbSzvxgc9BULy0=;
 b=TOAY07fFrk2Au+Av6jJ7pjbHW+cSyHtkyc+8VIaZq/xQvQ5UvDKqZ65r2OB6tDYHR3vkXk4cUtxKCQT1uf0LRxUNyHZIlKWTFSY52cm1Z6YEbGuNrW86rKzKGX34kEOS8PkI9vOkVzYLYyF0fZaeYq3e5/4aXntZfCwNKpO24UPlPWgj+LZSCAWIZ2Ydn1XeShnmuqg1zNijh77Q2YAn32hHb20OHYhu5J35SyeKI38tBcdnDnGBy2E3NUGaB9MPYF1E0RG4Z+JmOhYtxFfvIUuUwjNHPXNRg6B8qTOhRMGRU4CLQfz9I/tHx6b528bSrmCQuayZ1+y76kgAEnTYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CO1PR11MB4932.namprd11.prod.outlook.com (2603:10b6:303:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 23:35:25 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::ad4c:86ce:d99e:9740]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::ad4c:86ce:d99e:9740%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 23:35:25 +0000
Message-ID: <86e0203d-d4f4-3502-da85-6626eecfac99@intel.com>
Date:   Fri, 18 Aug 2023 16:35:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] x86: Use __fpu_invalidate_fpregs_state() in exec
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20230818170305.502891-1-rick.p.edgecombe@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230818170305.502891-1-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:a03:255::26) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CO1PR11MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b54425-39b3-40a3-be5d-08dba043cbf4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +HNizELK4LFFhTcupH6tzsKMdI12cnRtPL53Zoilt+8YZUNxeJLdzHc409V9u7VXG4WaHSOOix2v+1vgtGHAPjJaX8zPb7Z3rrBsOEy//E+O+UCkBdDRRzNf+ACEOTcSlOicpF0onXZtp2KcJm48Hs6XXQojGbj9ErVHnxATLBqTTeNJuEkwn2zRxRG672HRWpvlD6M4+9rzE/TjDuMPkOLCGKIBSZ0qAYXPOSN+hfzYd0bjzqp+Eo0jCyi21ZpnRmit21jCXw5uc94WVh8+O2kPuN0S3DNmsbXhAqmRJSlowmmiQpnzSsvV1Zj5zyjYWyRB+UkgYQctuBeE3ZL4wYXJBESEycVYTdHNQ6M1QPT6/Ao2wMoDOSbHJsRWMAJgOql9nIhXJkYL+aT5DEIKUPo/QNFit4G0ng9S0wdnc7TcWQJWdF6nsqEoICvTvQRWk7W4qTzd8S4FIlrwkCqzOb9d03ygxZ9oh6XvExS1OwDJuSZqF+Alnjw2zL6BzuOgNcxYppZE+KcuPMcgMQcYSVOwDlM6BFeFz7PWGj9eStewwiCVcJO1+2owb/t96ZPBpx7Wkdse3Q3TxAl0lAWHV1PeJrvj9axdbhXRnnD/3sPw6f4OncJhWr0LrZu7d3orGyNDXXT5LvOJSuoBjdSOMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(1800799009)(186009)(451199024)(82960400001)(36756003)(31696002)(86362001)(31686004)(316002)(66476007)(66556008)(66946007)(478600001)(41300700001)(38100700002)(6486002)(26005)(6506007)(6512007)(53546011)(8676002)(5660300002)(8936002)(4744005)(2906002)(44832011)(2616005)(4326008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmJqZ1JnMDFNM05qS1o0VWkwUmpaUEd3aGN3V0w4ajdlY29nckR3SmwrZG41?=
 =?utf-8?B?ZDRhVmFWaFlCUC9QcVVPRmRLc3pjVGRha0VoMW5ZblppNFplaDI2YUhielN6?=
 =?utf-8?B?djh4d0VXajRsR0RuelArNWRzVndQN0p0WnZSd3oxUGhFeGNqeE5RdndjNjJX?=
 =?utf-8?B?YVE1MXJXMURYTWF6MHBDUlVIc1NrSENQY0tvRGtoQmsvdWNHT3hxWVRxYzlo?=
 =?utf-8?B?M1pLYmd6bWJrMjZiUmx3MVc5ZVF5cEFOZ3E0NlVzb3FuYm5SblVUVTM2V2JC?=
 =?utf-8?B?M0JCYWZGZ0pxalAxZ3JWNlVvRmtzdEV3bWNPZGNxeC9lQU54L0YxTU1kWjMx?=
 =?utf-8?B?L0pOZ0hFZXcvZGNhYWc2WXV3TjcvbEdmQlAwSUpVZmpWTlU2TFhzcitCRlZx?=
 =?utf-8?B?MFhuQmdVOVdJQzEyV3I4ajJFSGc3ZW91TjBkY3FGYWlmdlA2ZjZhZTBOK0RJ?=
 =?utf-8?B?ekRWbFk2WHRuSFBSTVJWam5Pd214bmpuR09sSDRlVVZVZnpKTGEvTUpDOXVL?=
 =?utf-8?B?TDByblk3UE5sTWExOXp6Q3ZtczlyY1pYTUNJTmpzSEN5T2J5UDdxZXB1bUtj?=
 =?utf-8?B?MUhMZXBNcmVEbXBsUVpkR0xwUGFWdkNqNFl4VlB2VHZnRmFBMUs5aGlvTHpF?=
 =?utf-8?B?NTBkcFdDQTl4TTcvVkpEK1NWRFlTVWxjMzluU3dpeU85RGJlMXVJb2F3aU16?=
 =?utf-8?B?NUIzdVJNd3hoUUZUTVdyTHptRkNLaUEyLzBFT1BwQzBzRUlydnZhaE1qS01w?=
 =?utf-8?B?K1R0K0ZjYk8xYmRkZ1dhQWFzcXlWRllRR1lLME14bURGUCsvLzBDSmdPUUY1?=
 =?utf-8?B?a3MxcWxybXk1Wm1zMjZ3Q2dpamQyN3IweFRnVFZ3WWYzUEpiVzMvY1JvZU13?=
 =?utf-8?B?SEs4Wkp6bDlwWTNNSjczZzZzRUpCSmJ2YzM5bzVjdTNKN2Q1elVISCtDREhy?=
 =?utf-8?B?U0p0dHJEUWdCMXRNZkprdUIwZUgrdEIxTjBYSTQrZUxpOWFjMVd3dDJWYkVh?=
 =?utf-8?B?MnNPVUhoOWdkVkhIczhOZHdyTSt3M0ZseGdEMGZmeHNMQWJCTFNtajFuSTJ6?=
 =?utf-8?B?S1JpRGhVNkZEblFzQ1VzdTFqMHY0RHZRZUNxcE9sQkEzdGpWSUQ4Z1dlOEUy?=
 =?utf-8?B?QnFWRHo1aHduK2c2TTZmVkwvZ24yaFRVMUpXU0NBM0VEV2dRcFJwYytCcnZS?=
 =?utf-8?B?NWx4cFEwWUJZcDJEZDJzSWREOUhZLytGdXZOVUMxZFhmN2hIMzNzZUtoQ0ZP?=
 =?utf-8?B?dlNTTTdLNFFqb05xV1FzTURnSnJyK1ZNeCtpM1A5dmNodmg5c2VQMXcwZDhP?=
 =?utf-8?B?bjFRU1lsVUEzSVhmT2xrS1ZSMkp1M01YT1lyR0hzbDE4SkdzN3M4a2dUT2RZ?=
 =?utf-8?B?VlBHa2t3R0t2amM1Zk5Fd3hWVlRYZTg4M2paVWVCQzhvZjRhbFAzK3l2TDRL?=
 =?utf-8?B?T3duYkRmNWtPeDg3NDNLSy9VNVFVZlpKQkw5RUsycWFOME1VdzA1dmFkQ25n?=
 =?utf-8?B?TmsvRjBxQkxSMy9JTmtFS0t0OXBaRWhFV0d3VVRiU0lqY1ZwbnpXMmdhbHBj?=
 =?utf-8?B?cmpUQWJyWHR5R3ZaR1VlbE53elB2UDlhMXFkdDh1enZrOEk5eHlNLzVrelJy?=
 =?utf-8?B?K0p4T3FrWEFiTkloV0lRU0h2andsRkpYQ1RHTTN2Q2VwYlJVZHJPeUFObEo2?=
 =?utf-8?B?TzFJN3JMeDM4Z0NvV2FpNThhRHJyUUs2UmgwM3Q4SG5BSHBMRlB2SXFIOUdV?=
 =?utf-8?B?bHRTMWErZ2Qxa2p3c0ZWdlNwbjdEMXI2S1RzSS9OQlRZMzh1aHRzVWpwOXNa?=
 =?utf-8?B?NERrbWpZamorYzVNWEFBMDVZQStEOUdJcHc1U0dBZWFBZFFJcE5GaGd5LzJM?=
 =?utf-8?B?bmJuQUVNckFBRGJ6YmpRY09mNWlvd3B4WlNOaHVsd3BrR0RCQlFIVkR1ODg3?=
 =?utf-8?B?dy9hMmVYV0h3cnNleG14WXliQ0p3RWRwbnEzbUpwY2sxeWh3bFNhRGRqcUZE?=
 =?utf-8?B?M01EZFpObFUrTTZBUVNpWHNkbG1zRUwrY1JmVEhVRktGa0hKdzY5WHg0YkJV?=
 =?utf-8?B?dmI3RW0wNERUU2hpQXVVTzRMbnY4WlhmSExTYWRqWFYyTy9rNjh3VnFlZVdw?=
 =?utf-8?Q?ZPzN7xfowGfjEaNNSyXzKMcaa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b54425-39b3-40a3-be5d-08dba043cbf4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 23:35:24.9343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kkIV0LSgE+Gcxhp0aSgjF3i02BhoOB2YjMIlayfaeXTGgJ9TQL3nUq5CCP8/TsV3ekdtW2U6a4qVb37yOMbPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4932
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rick,

On 8/18/2023 10:03 AM, Rick Edgecombe wrote:
> So the root cause is that exec() is doing the wrong kind of invalidate. It
> should reset fpu->last_cpu via __fpu_invalidate_fpregs_state(). Further,
> fpu__drop() doesn't really seem appropriate as the task (and FPU) are not
> going away, they are just getting reset as part of an exec. So switch to
> __fpu_invalidate_fpregs_state().
> 

I went through the scenario you described and it seems plausible. Since
the task is being reset (and the CPU is unaffected) it makes sense to
use __fpu_invalidate_fpregs_state() during exec().

> Also, delete the misleading comment that says that either kind of
> invalidate will be enough, because it’s not always the case.
> 

I think it would be helpful to expand the comment specifying exactly
when __fpu_invalidate_fpregs_state() should be used vs
__cpu_invalidate_fpregs_state(). I'll try to audit the usages and come
up with something reasonable if possible.

Sohil
