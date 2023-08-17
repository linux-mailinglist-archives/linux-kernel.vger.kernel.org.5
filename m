Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A3C77FB19
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353294AbjHQPpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353305AbjHQPp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:45:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2A730F3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692287125; x=1723823125;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iCQ6wBSW5aNRj4JBDJQo2mPOukDuq3x94K5mcISX3xM=;
  b=JmRS5vlVTLAlJGbVyIHDgLvcVYHwplyzH2pbgDOmo3JR4os0onPecwjp
   kv4A2tA9mxP3UEq8aQOuMy6j7obVx69X/f6KJ8TYzxTC7Lb+Fn41sqfUI
   nKBKwsbR3c3HuHs7rRNbpM9pwCRhfZfadobeeOYTkKVOFSxI1b/nPy89P
   KfDiJUXdlrXGffg68ZGlLHqQ4n6OA+Iwl4Any3i44gZaTpDzC+cRHDImS
   rN7E6VVFEPcpPb9F295uuH2QlP8wfwhkeefNkDYcJk4iaCtMmfCGn/oFm
   +7a2Efp7+7LDxjx0pI4rmH5r4j1fvAwRUc3rNb1DcnSl8dB2VbhOeI70o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="375629279"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="375629279"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 08:45:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="858273359"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="858273359"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2023 08:45:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 08:45:17 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 08:45:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 08:45:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 08:45:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qu/5Rq/ohOCF+6akfquBnlMtrQHfsraPMQiEd/wByyeEZO/qU5OK57Zwp/+Y9AWD9v6ZJY9MgXVRuXzHjaQFCM16HK4sDnlm2QzVoAO2jYDjTV93HxRz3MaZNmMN3Kc00L1XWSCRNDUCl5oV5VuZE1jfIZd6PJJD1oFAQlBYUg8NogTHua92mjFh+xrAyZhExGmjMqOLoppT6rVLdR5/0QoldFGNYqHfSs42iZ8AzA0//O6+3rFmpQSswsic9x0UqQzpiI1i7P3x/FocAJAg6k9glpZPZBMo0TLUYrhANf05yiHawlEy5uBpAmj+ul4m+RHK92mgX+Ox6/k7z2XPOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FVye6a4rBEfPSrvZQTM27RDOkeAXLc9KFqLnb1SZaQ=;
 b=WZ3xswPoP8plsQTQSia5Q+laEfQmMhIslLRMvzVU5v4QRxuBeGQp2yZEwU1mVvoOxk6x1Bie8gYxFwYQDK4zR3daQ8ingzhukRCUSMqBzUHbitLQiIcDIVONveuGJUE5rthf7fSc2EX4inS2v3tvHgZSy8AJ2bPwuHCWzR3nldJ+egdflYyh5IrRYFTUSZAUKaQT2ZITRvlz12AAN41OKBSCYxrDkA39TM1kqU8VoFCk4OVJFgQzHrvz24cas8xgCNs1nX+y+n04sIwKp1CQmQdFKjIJWq7ksbTK4wZT+20sfNZW8CfH81h/vw6VO4bFWXjeb3JrwQlcBo7oOAaIFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS7PR11MB7859.namprd11.prod.outlook.com (2603:10b6:8:da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 15:45:09 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 15:45:09 +0000
Message-ID: <cb36ebb0-6220-c3d9-0772-bfcbd16baa77@intel.com>
Date:   Thu, 17 Aug 2023 08:45:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] drivers: nvdimm: fix dereference after free
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <yusongping@huawei.com>, <artem.kuzin@huawei.com>
References: <20230817114103.754977-1-konstantin.meskhidze@huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230817114103.754977-1-konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::17) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS7PR11MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 95655f0d-1a7e-4638-e288-08db9f38efbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BiGDGUzQzymamd0tFdjXsT4VzoDZQJwybnyfWj4J+fjTk3a40jzvu4bsD3M80slCVgkpiJ+HpA7KL9SwmKxbGo6cJ3JS2tvgYtcSHX/9l7Fdq0qEoxe09dqh4CbDfdvek4JIOfDJMtk54hnpNBrEpSFhcrhcmRNTUHdcdR2Jg720pVh/6sYZ4MedKrjj/0nUxEdGC64JHETU4Hh+8IzPqOhQLrVNWJMUYW5nmvRvqmuTnOgVbusLpf40v0t7CYYltkxkqWohoXs1xvQyfw4SOa1GlfPCWULkc5u1JNhEP3PIbwqfgrrWQldWFZZtkDh4uzbTQKx7EOt6/eoHY6Am/hEHHNfy60jmEsTJdJiZzpNPPUFsePnh3izUbX6F350a02/S2guS0H+TA7DEjwySo6yoPZmVTmzaqHermjbGuc5LXAUoHrfaii+AmSSt/QOpjzjEgrdT7g/dMwo/5u/Z+42zahf698cDARBTzTVpr7phSLQ1LFdKjHsgxT7PtkODLgosEq4SWQ4Wxf9UEwjNvCEEFfc9bcw9fFpKmt/gZYNpZCmT48F4xCWfwR0nQM7Sf0pJc+eNirOBRaG2gW2odBgk0mHngzUkSBvTFx0pEJHUFyXrI7b4ZWT88523XlqeQ4eIXh7VW3nf8b2tKHzY+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199024)(186009)(1800799009)(31686004)(86362001)(31696002)(36756003)(82960400001)(38100700002)(478600001)(5660300002)(2616005)(44832011)(66476007)(6486002)(6506007)(66556008)(66946007)(316002)(6666004)(26005)(6636002)(53546011)(4326008)(6512007)(8676002)(41300700001)(8936002)(66899024)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFBsRzhkNXlqbEtMQjRmenBFTjVtbTZSMUVvSENsOUVBTlJOOXBKTUZOQnNT?=
 =?utf-8?B?QlRlaXhKcEUrS1F0ajhJM2dqSmN5dHgwd1RWd3dUaVVlejJHRXV5ZmhQcEZ2?=
 =?utf-8?B?ZjkwV05qb2lBSThMTnNPbjlpQVdrN09YV1lDWFRhMkx5cE9qY0c5UzM3aGlv?=
 =?utf-8?B?UVlBUWZQaTJPY1pwR2U1dEpseW5jenl5RUhSMUJjWE9ZbVRrNCt0eVRHNEtW?=
 =?utf-8?B?SUxBcW04TVBqZm4vSzJWUDNTWjJmb0pzRS91REdRVU1VRk13aFgvQ1REamJ4?=
 =?utf-8?B?YkpBbHFJWTdHYUxUTWc1eG4zM3p2MlRZYWlUM0VNNGNFMVdNU2lRdmJVeExR?=
 =?utf-8?B?eVkzOHpKQ1F5MjR6SWFwbytMNDAxalpXVmhBK2pYV3hYSCttTStGUndwNWdY?=
 =?utf-8?B?ZVN4UmxiSEVhOU1CdGpTVllyY1FzM0lmdnZaSG55U2hkd3IyRkZWTGd2ZTB0?=
 =?utf-8?B?QnBMNkJNRkdtdnZ4c20ydWMxb2VJcmlORmhIMzRXTmlQc2JEU214YXRqQUd3?=
 =?utf-8?B?WmFPYUpUby9vQk9yNHF5U2dBZXVhTkVSODlpZVhsNHZFaHJBR1MxQkJuMS9x?=
 =?utf-8?B?WE9jcG9LY0xUQVZqSEpKMG5Sd0xMdEZFTlNsc1o4eXovS3RLYXhzQUlYaUYy?=
 =?utf-8?B?d2lhRi9UYXhwME5JV05Ha0RtVTFBTGw3UmlrVWR5Ti92V2VNTDlLZS94OUxC?=
 =?utf-8?B?eFl3Wk5paVE3bEZjUUF2bVdWYi9NclcrUmwvZWwyV003WUpaTjg0dCtyTURh?=
 =?utf-8?B?UzF1L2RGZjcvNDhTVUxjeGNNa2preE5NTXgyOWNSbnlPdFdwUDYybWQrUWNW?=
 =?utf-8?B?ZjU2Zm9jL1U4dS9uc1A3ZVFJam42Z1h0TGxhS2xLWlppZnJna0FwdHdjb3U3?=
 =?utf-8?B?bmp6dzY2TXREZlM1SnJDQmdvMXp0RnZUbGNaRzNBU1cvYlN6eFdSVXl2V1BR?=
 =?utf-8?B?YUFkM0crMFdGS05jR0FRTFNLTDZlV0ZnanNoeVo5U1A2eW04dStGTTdHcldT?=
 =?utf-8?B?SDRrbFJNRnZWQmlkdHF1T3lGeGhWZmRPNitJT1Y0Vnhoc3ZPU0cxUDR4U1Yv?=
 =?utf-8?B?ZFZ1bHB3ZTg1WldTOWN4dG5sMVJIeHkwNWtKMUk5dnFFZGYxWlM5anVZVk13?=
 =?utf-8?B?K3hSemlrd0JCTVVPVCs5U2pxOStPZ3JjTWl1K1ZCbW9ka0ZIVy9PTWRET0VS?=
 =?utf-8?B?UjBKb1d1NjBxOFVveWluR0hrVHRqWVVxSGJzTWZlWDFCTXdNa2N4cFV5T2JI?=
 =?utf-8?B?bVI4RW9EWjIxdTBxYlFNRTRhM3QwZUVQMmVzSUt5OGtNYVNLaGxySHNTL0pE?=
 =?utf-8?B?SWtZNjRCL1dNajhIUGlyTXZvMlE3KzAxd091U2F5SzFNMDd2ZnhuSHFOcnlh?=
 =?utf-8?B?b0JXb3RBZkpMdGkybW4rSFNuS0NDSUV6ekVwaU1iZjZVSnlidXhVWEx2VlM0?=
 =?utf-8?B?ZS9NSGN6a3I4eDh1d3Y2Q3k2cnYxcWlVV1VseGxVOGNpMW1yNFFBaXNFODZs?=
 =?utf-8?B?S2dHSzhHRk1YRnNxRVlKSzRjMktaKzhDQy9SVlVFL0hxdVBZdGcvdis1dkJ1?=
 =?utf-8?B?cmszUCs4TFpTQ1M2S0txWkdIRmhEcWJMU3FiV0dJcjBPSnMvMm9EWWdhTkZz?=
 =?utf-8?B?WmJDMVBrRkVXai9uQUw5bWg2b1l4QVdwbkVzNzlpNGJwaWh3MXBIMllFaDZF?=
 =?utf-8?B?QUg3cnVnQ1NnbWZkWVFiQ3lRTDFOQlM5Z0VxNXQ4K3FUM0JGMUlDREcrUHZZ?=
 =?utf-8?B?NU54RVlMcDVNZmU5cC9EWkIyKzhXS3R6WXFWay9xcjdXRHRXcHJuUFlBY3BU?=
 =?utf-8?B?TW1McVdaVmVMR3hmZmc3WDZSdzUvTHVObXU0VkFkVHg5dElGaHZ5blhHK0d5?=
 =?utf-8?B?MGdzWGNVNjdmNXRXNjFzVktNVFE5UUIxUk5zOXc5dlVQTjZEVS9nbDdYTTRP?=
 =?utf-8?B?eisvYnAvQ1RXMjU4aTFpUjhEYnlqYWQ2dU1QQ1hib1BVR0pVRERIeTFjM1Bh?=
 =?utf-8?B?QVZLS042RlljaWk0V0xjVWk4dXpNb2F0M0JYWEk1MGNDdWxmZktETG80WGN4?=
 =?utf-8?B?cG10aXloWUFjb1ZEc1hnZTNKR25wK3UvOFNydzY2Y1dkUjBSNGZlbzIydnJP?=
 =?utf-8?Q?ms9kvk2Q+uVrkygKNOJFdrI3K?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95655f0d-1a7e-4638-e288-08db9f38efbe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:45:09.4731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: puTAeQmt7AHhDQlcm8ViCAnoKDFEIlnAcDmY3aoCCL3E0pYoV2RP+g8AtMk/ZVE/zq0o2RAfPJuUg5Et4ZVfsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7859
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/23 04:41, Konstantin Meskhidze wrote:
> 'nd_pmu->pmu.attr_groups' is dereferenced in function
> 'nvdimm_pmu_free_hotplug_memory' call after it has been freed. Because in
> function 'nvdimm_pmu_free_hotplug_memory' memory pointed by the fields of
> 'nd_pmu->pmu.attr_groups' is deallocated it is necessary to call 'kfree'
> after 'nvdimm_pmu_free_hotplug_memory'.
> 
> Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>

LGTM

Does this need a Fixes tag?

> ---
>   drivers/nvdimm/nd_perf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/nd_perf.c b/drivers/nvdimm/nd_perf.c
> index 14881c4e0..2b6dc80d8 100644
> --- a/drivers/nvdimm/nd_perf.c
> +++ b/drivers/nvdimm/nd_perf.c
> @@ -307,10 +307,10 @@ int register_nvdimm_pmu(struct nvdimm_pmu *nd_pmu, struct platform_device *pdev)
>   	}
>   
>   	rc = perf_pmu_register(&nd_pmu->pmu, nd_pmu->pmu.name, -1);
>   	if (rc) {
> -		kfree(nd_pmu->pmu.attr_groups);
>   		nvdimm_pmu_free_hotplug_memory(nd_pmu);
> +		kfree(nd_pmu->pmu.attr_groups);
>   		return rc;
>   	}
>   
>   	pr_info("%s NVDIMM performance monitor support registered\n",
