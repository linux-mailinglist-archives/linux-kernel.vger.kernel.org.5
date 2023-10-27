Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8057DA1DF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 22:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346420AbjJ0UkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 16:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjJ0UkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 16:40:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC80E5;
        Fri, 27 Oct 2023 13:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698439203; x=1729975203;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nzxktYnN08I19EY76M8ZvgFM7Kjo+RMVaFgYEudrcNE=;
  b=HySMm7zx8dZuGnb/ohvwXSWbuQEC+S0n1y4drui6W/66hgzQjqcnO9+/
   y7+jHiiuShhj+HU2lnPqZLbClBlYh4Y5RvfR/mf4ejsQeiGmLniADq71r
   OpEV2L/QFj8Q9NJfc2MI0FOOPcBSC3fMeNSIyjIbzckQuJlIxLsp2z2k4
   LnnKKBPDhtW9ZfZKxLThU8sjmdGfzjNtjcg/ObrS7bwVv9kmcMSouhpul
   p2kxZma6UJJdI2eGhrctbg4pzKZ9VKZkvVNin58LzyZ7sJxdoM21DGDjN
   g831qHd8gr7QCLfuXxBKqg+bkDWt50ryaWzoReQI3tDHw8VRNcGUb4sM/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="390711923"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="390711923"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 13:39:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="794691707"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="794691707"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 13:39:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 13:39:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 13:39:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 13:39:55 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 13:39:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijOU3G8OfYtNPsMyaqtasGgSyAfd1TEhMg2fShf0gFt2R/GGpnB2/CfftWT93yx+6srmB3oBDEpKn6Dm9Yri0LrsNAbGrVJPK/cy92gZEfNEeQHayrwzPE2EuHwc1Ovv+3kVIZaRyjPD0dBgmJ572dudnybZJNOBCrlcpq15Pc4TixexXxRNvMTb7lCJ1tJxKnFzck8g1+flGPfuJek1Ij35JIji5xfurz47yDc4o/Y2ZFb5Ci9eZFxiCjq5m2w042WSrZKiMwO5dZlfvgk60k0TWs/micqpGT93+4B95YR0LCZt7h6Nh/qBPyo3yL0rILfG3zp57nddTkk5VMCXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fOcm9uHehYLePpjL/g5bewKN1XwnI3/P1VmfUkeItY=;
 b=HobqqGf//hXmtmnm92W/ImFPM0S3B9zperyZ+bIok1V0eB3j2e2mF9nrosVlWcNAOw5xrSlZBwHGMQ3RhSfKiY6tfX3qogsDGafHOdOoP46iXLt+poKnKNykhVy+XoxsL8UxC6ng4Jvzfz5L+jo6BvCgwr9D6Lm2HLRY0Xks0JR5eJHgEF6CE09+1d3USZ48Y4kv7EIFgu3zfXcaJ5q/PM6kZg1YXa+5yXrf6ZclFaIKUyTof9/9RVG1boke+A5snATkdVFB5Poiz0bPvyn3w+u+rI6b1vkxAQf9ScLxjvINQ5aNzSYDsSXmdniUScQUFvVEnc9ruJPSLOHKchsL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5303.namprd11.prod.outlook.com (2603:10b6:208:31b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 20:39:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::2724:db16:fe7b:2ffa]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::2724:db16:fe7b:2ffa%6]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 20:39:52 +0000
Message-ID: <bc4bde38-3256-4567-8cdc-7bb310b08bd5@intel.com>
Date:   Fri, 27 Oct 2023 13:39:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] iavf: use iavf_schedule_aq_request() helper
Content-Language: en-US
To:     Petr Oros <poros@redhat.com>, <netdev@vger.kernel.org>
CC:     <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
        <linux-kernel@vger.kernel.org>
References: <20231027095102.499914-1-poros@redhat.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231027095102.499914-1-poros@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:303:8d::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac1f697-898e-4927-294c-08dbd72cdf05
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OVyajoOZKhKltl+rJ+ZbHudVMW11TcDJxBCfmwlpy9JQRbfuGFe7ptPv2PjPKvPFK+KLzuLJk2QTOfhTs749feXNbxp2yQnIuEMghDg8j3qC0cs4l7K/XP2kFXSpnbBWf1HuS0skKCmqdJ820Lsk/W9YMZ3VCgkrh0EpXYH7S4ReULFIw/h+/YCDSXRsLhJffrSR7u0ceiWuSXrpA6147JqxW7o5Vtz0Ju6Dy71r/3k4Y9SWhUl9y+QVlcHUIx8V5rEnsC4fDDLGLThq4icA50JT2YHq8a3pvHqssnW7xHAcbQvLbfRzWZVi8q4dTx4jlN8UYJ07azK64q65yxp6gZ1VKoBBMGWXioIaeyrRkE2sXtH3Ek9IuvJJT/jT+U2aQQD6zJiAbfhnyk5BjL555xAqmcO39Yt15g5IZZoRmwy9zNb9N/FxhaGKczgL2YxjM36cE6E56d3qW6oZ0X7CtBkDmRmRze4Tqz74QCS43+rdejzL5QL6pzwxZia5PdSsYqUZ1k/wNd85f9PwA1FA1ESIFAb6neqqzfhs3hQ+IyvdQkpnV0tfSq44ordH3UHflisxVVe8CRvgh159/7tvwttUA4/dki8IXnTupP673s0fAhdm7B0iUIuHhy/nx4Ebapm36LiIDAqRYwjjrWGIGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(26005)(31686004)(38100700002)(2906002)(4744005)(31696002)(41300700001)(36756003)(4326008)(8936002)(8676002)(53546011)(478600001)(66476007)(82960400001)(316002)(6506007)(2616005)(66556008)(66946007)(83380400001)(5660300002)(86362001)(6512007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUVqOHZLN0d4ZG5DYUc5RU5LZ0lkcGtmR0NYM1JYYTQ1dmpPTmlUZzhUNTdh?=
 =?utf-8?B?SnpTZGVNNjhRM0k3ZkNhQ1FJYkkvUXExM1VzWFZxa0dOem1zcTNmSy9CaExF?=
 =?utf-8?B?N2lmTVB0aThMRGNoRUgvVVMxRi9CMy8yT1ZNWWhGRkRWb0tKNXlmdEtDbWlV?=
 =?utf-8?B?ZHk4Q1ZvUGVuRENtbXNXOStWcGhjS1VDdWRwckw0LzdBVmw3dlNRU0JlMWpM?=
 =?utf-8?B?U1RDUlZjWFFwSXR0RXZpd0F0ekR3VkxSM1pLUjdxenhtYkNuTzMyVks1VFF4?=
 =?utf-8?B?d1RBcmJ2ZlNKTE9vY3NxUEJsOEViOXVoR2s0cWwyVXlaOFdTTDFqTnQ1RHFH?=
 =?utf-8?B?akc1UGRTZ2pUVGlJN0NrMTM3dzNCaGN5WGV3dzJkbno1S04vTXk0RndBOFNu?=
 =?utf-8?B?cXdsN1A1Si83SFFnY2hyUEljNEowOEIxQTRqMzBXVExjcmpCVFhBa000T0Vv?=
 =?utf-8?B?RXBWcW5NUDJSZmRYUG1kUjUzbnk4NzR1L1M2SlB5bGJEU3k2dWlGNnJsYlpX?=
 =?utf-8?B?VFY0ZThaclhaSXBMWDRqWHpnRW5jMXRQZERxRCtIekEyYVI4QWtFdHZENHZG?=
 =?utf-8?B?eVBQMG9OVFRsY3R1eW5Bb01jQVUxYk1WK1hkUmZEWTVEUDIwYnhzeCtpeW9Y?=
 =?utf-8?B?ajhIb1ArekFUVWJsdzdhSzNmYzVyckxIYnhCOERpUCtWKy80VmVHUGZyT0lT?=
 =?utf-8?B?SjVFOEtrTldBNmZseUNwTUIvQnVnY0JsWnRmQk9KMXhBRFp3V0kxeUJzbEI2?=
 =?utf-8?B?N3pKQ2h5QUplYXFwaXliS3hkVmRabEVqRS9oVThjdGF6cStGTTZhekdJS0Zw?=
 =?utf-8?B?azRaTTNyRHcyRFBEbGN1NXI0ZmFCeUc1NXNuajkxQ0lkajVuSUQ1SlR6Kzcz?=
 =?utf-8?B?ZjI5RC9yZXZQL2FOa2ZGUnNGUFluTTJiMmZhKzNlN0VUWkNHOTlTc0c5MHBW?=
 =?utf-8?B?RWNnUkdYajc3QVlJV21pU3dMTGpOTFNzTERLYXZTdlN6VnlyM1l0YTNQb1Zn?=
 =?utf-8?B?bkdidXZiaEVDQ1pabGsvTWIvR1p2VnNCL3NnNWthRzVlczZpNElxTk9aVy8w?=
 =?utf-8?B?MXlydllRRnF2VEthbGpJQmVqN2hyUGlrbng0amVzcGM2ZG1qMGxuL2RYazYw?=
 =?utf-8?B?eml5R1JKckQwaHBHaThNU3EvVWF6Z3kvMm4yTzdCZ0syQmd3RStJSzlPZGVa?=
 =?utf-8?B?bUQvUDdObS9CR08yRG5DR2hyZXlVdXcyVXhYTEhHUDVlY2FkOHpQclpBbWxj?=
 =?utf-8?B?SkF3aEpDdzdwTE5tc2hIWHl5cVpZTHBFOVhoMUxYMmd5ejhIWXl4WVJHSXNn?=
 =?utf-8?B?SmNNM2QrSWZ0Vjd4K1ZZQzNDZjJKUGZYQ0xMZVFXMFRxUEMvcmcvQ0JVeEIw?=
 =?utf-8?B?S3M3cURMQ0gxN0cvanpXcW1UNXNvQWNLMkRIVzk0TmFML1pFQlUvQ0lQNUNi?=
 =?utf-8?B?QjdNa2pPcEo0NmMweloyeWNTdWpSUzV1V1pDMEtUTFFVUm5iVTNsQTUwb04v?=
 =?utf-8?B?N0UvaGJVTHVDakhna3lxWmVyVWJ0dVRVOFhVL3VraC9sVUVOMGpVWXpwcFdS?=
 =?utf-8?B?S1hqVU5UWDhuY0diSFpUamdSYjJ3OFFZaWQ2YmFKQUR0aXk0elFOQ1hZMU5C?=
 =?utf-8?B?cnJZMEVoSUlWcVFuS2tsU081TnlVZ0E4akJwT2tTWlVoeHBRZ05SQUFYdUhQ?=
 =?utf-8?B?R2srTHZjelh1anVXL0hyQjI5MUJQbExXVzRQNHlsOW4vclpPdVVjdXVxTm9m?=
 =?utf-8?B?QnVPWmZtMERRMmhqMGREbHVGdlpWeXJZN0Frd1FZODJzSWcwVTRaWUlaYml6?=
 =?utf-8?B?SEt5SUgwWjBBTWJsdXIwQSs4SkpCZGV0Qmh6ci9LUUovOCsvVTNXNXVtbml2?=
 =?utf-8?B?K05wZDNBTmJDV2pTdUNlUVNIUUExZGxhMU02NktGanliNTlpVHNqMm5hazJz?=
 =?utf-8?B?aDBvNFdzcndWa2xydTBKM2xPSE5zUVdRQTRIMUpPUjR6ZmZicVcwQXBtaXZY?=
 =?utf-8?B?RklGS3Q5MmJkVDZnN2VKS3Juc0tlaTVBWXlleGtORUNZaitlSjZPdE00T2Nl?=
 =?utf-8?B?bC9IMmxkd1J0MytsK1RJZFc0UTBMVDVHOUwyUWVrZ3l4Nk1Qd1dhU1daR2k4?=
 =?utf-8?B?aGhiTEd4SDhzLzU5SG1zTmJGVS9qckJQS1VIRkNkN1Q3YjF6end1WVN4TWx6?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac1f697-898e-4927-294c-08dbd72cdf05
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 20:39:52.5350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bIEsq1hhRbuhq5+/zVBqgxuT2LlNnaMuwpXG6nFE6e9OmtSpcB4GzFUzwMoiJK+smJSkLBzMdGQlCpxARG075OJr+u41cT+Dnmt+YezncE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5303
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/2023 2:51 AM, Petr Oros wrote:
> Use the iavf_schedule_aq_request() helper when we need to
> schedule a watchdog task immediately. No functional change.
> 
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---

This does not apply as-is to Intel Wired LAN dev-queue. I have no
objection to netdev taking this directly, but if you want this to go
through our IWL dev-queue testing, please rebase it and sent it tagged
as iwl-next.

Thanks,
Jake
