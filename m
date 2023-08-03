Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8669376ED9E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbjHCPJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjHCPJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:09:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3154730D2;
        Thu,  3 Aug 2023 08:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691075364; x=1722611364;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y6Pih6OhSkKvwxzR3OYz/XNDtkjBVuu5uFh8u9276wY=;
  b=gxHWQRkEl3lxlOdkyMXrjx9eis7bB43wcB4DtZ1EiF4toBEDrsptktIo
   gMfKbf+jzshKOO8BHQRoiT+byBWxgOOP0iXSN4S7nZnjhbYfUPcrLbhIE
   pfTUs7sJ5fY8MLQjJvD2aUzsebmFVQxw/My2w6jqlADPOMxfUPWqYFOmv
   RCQacec+X5ssIzJ3k54qYNEOo8n1C7l4ZO1Fl7svS1ppDi73yWsOlIQU/
   cD8p4Y4BHIvKI3nxthHy6oIgKkd2ZKwyMPg6pIOGk+2tjbj4pQCaIvT4B
   iNHLjMhCyze18ZnP5NONoEHX4ou5q9igGpzOED5Ki61ng745dE3vH8N+z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="369894919"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="369894919"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 08:09:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="976101768"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="976101768"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2023 08:09:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 08:09:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 08:09:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 08:09:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfRgQ+G+Ty/qpYYXeIWw9YrWwKxZOh/9N2Vp+1FOllVVACjgoGb+5bind7Li0lrFXW451wv2UiFJtJnsxlWAYQtUcTVdej70RA1JZ4F3nNxvwjnN5aMDdAvWymxX8Ei9eRZ4Q5h3Ii13lAT+XReua/R9CbGpiNbfen32J5QnKB9alBskR1uhqJdXZhKmGITrKv1ogM708CwJNlIBbrIRHCfFVkK+JyLN92Foj3o7v1OxR/zOVzVEHcjVqaeRFotWs6fzImeLUq/9j+tThkfBCCLO0k/6lLdXRR/dw12IjHnXhM2sP3zm0RK+80KnNbdgv7pWN4giH8dyadbDmHlRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZ2KMETCGbVELzzWAH5K/suPEBzwStgJux9GEzMxhwQ=;
 b=eCEPLAQKsdESHLSe5MyFFqy93y0WI19qFp8JutZH/A+s6ylxAbTIS0dKRHzsGAsZ6re1BKFbMKf/w/IIjSm8O96ciS7CyePGK2QxYEJS6UOug+FHVq/1dm/n/tDvsILLTSyYvXq9I93TTn0EW6+xeYpa/SWBdZ7V8yyBpQBz8Tap+1edWlMEeia4kY82AeoxWpyixmBCmXtbO3ukp+8YOvjj0sp8yzsdIqhmziD08pbU+/ydVc+9cIMfWAIQcgq43raPysi5lVUNjGPjkJtHwOm1zEUxUTNQfT3Qbr1dnRiDNACxNmzxlY/Ao4d1L5v/GJV8U56QHba4s/U/DGVblg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB6169.namprd11.prod.outlook.com (2603:10b6:208:3eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 15:09:12 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 15:09:11 +0000
Message-ID: <f04cf074-1cff-d30a-4237-ad11f62290b1@intel.com>
Date:   Thu, 3 Aug 2023 17:07:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] octeontx2-pf: Set maximum queue size to 16K
Content-Language: en-US
To:     Ratheesh Kannoth <rkannoth@marvell.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sunil Kovvuri Goutham" <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
References: <20230802105227.3691713-1-rkannoth@marvell.com>
 <18fec8cd-fc91-736e-7c01-453a18f4e9c5@intel.com>
 <CY4PR1801MB1911E15D518A77535F6E51E2D308A@CY4PR1801MB1911.namprd18.prod.outlook.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CY4PR1801MB1911E15D518A77535F6E51E2D308A@CY4PR1801MB1911.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::28) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d48ac1a-841a-47b1-5ba8-08db943397db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/2V7bhukNu8Qk34m8APGztdMD0gWn9iw4DBDZqK4NGidPyeW+AvthrIG6Te7zHa8duavs5G7D10K8TGeJsXSAT6gv5LcYJlAreJ6c81unPvzQwt/iTZP+RUxt10/4mPnuWAaYLZeOAdOsOexpG9Lt/SAIT4QSfwLOYuRihu1PWx+h50HEk0X5wWftPI+fb3OBwdQFI35K27pcWSk4Jqyz6HOwBQC0UhBWsr+kS3q4gYqn3wQqqZH8kxMVWsUCRooZ2BKmOJLhpA8Ww0U2hVXJzleAcNT4+YY4erMtcK2fmUXAiounER/ZQw9KTn6fHusEKfH64vsu+g2/r9MKyLtXbYXi5BYVecam8A2PAEnCw47kKZ0adLoCwMR0tNgX3wi7dfLMzR2tmgFoFMjqeArYjocPhO7Ok13NQBZKIYCdhNqTqupeBYtuYbgZPfi54L+eNNJ+aytRtRMawnyZzn9HkfuhVfighVGN8gkJua920YTUGZ/AgPLLTAQMtE6D+EP/mz9/w3qHWHybk86jWTZc9F4jXw+u9QeRrFDBMqyZsyRE+jmVCUTC4r5xnPTHLdiiTYMRSdWCMgXdc5Ot9cg84uz4usz6C9y0ABNJxM/7k4U9XUU4ucMMXtp+5B3R3wY4pu+XpmM0rlN72XM6cENw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199021)(86362001)(31696002)(36756003)(31686004)(54906003)(478600001)(38100700002)(82960400001)(2616005)(6506007)(186003)(83380400001)(26005)(53546011)(6666004)(41300700001)(8936002)(8676002)(6512007)(6486002)(316002)(6916009)(66476007)(4326008)(7416002)(5660300002)(66946007)(66556008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1o2SlhtKzM3SGpKdExxOXNoUURqTWVZVDl3YTI3WFdNSis5UWt4VlY4RVFQ?=
 =?utf-8?B?TmhjcC9ZR0lHQkJyZ05ncGxEV1dDMW5hTGNSTkV4cFVGeHVNcE91U2NxUVl0?=
 =?utf-8?B?bmNrQTBSNmJWQlYvVXF5a0dvNkQ3Vm5JRVh6WWhjVmRzTTR2L1RBVU1iUmN0?=
 =?utf-8?B?SXk2L1JvZHBaNzRJMjAyQWZ4TmxSdWNUTVp3bGZxQnNOOWlZc0xMT0JUaUd3?=
 =?utf-8?B?dEZkcmFzSERBWkJJajNjNHprdkdXMytoU29PL3lERm5VTk9FbWluM3ZJMmI0?=
 =?utf-8?B?ZHp0MHBsNTRqSTd5bjJHUEVGaEVVMHFtUmo0bnAxQTY2TjRubFlDK2RtUVl0?=
 =?utf-8?B?bDRtZGZrb1ZyN3FDNjFiQTJNOWwyQXgzWEptT0dtZ1c3RkF5NGRPdlcyTGVO?=
 =?utf-8?B?V3lCVkJxUVhXVWRGdGJYYUtOYW5zRlFSYTg3c2pzZ3FibVZzcGVzc2NBYWhM?=
 =?utf-8?B?SFdCSVdFUWhDQ1A0Z0l4S1UzOG9JalQzV0prY2NjZDd0M2EycFBiKzFQakhU?=
 =?utf-8?B?U2c0dW5wdFhwME1pU3Jzd24yaThXdFppdTk5Q3phVzZSTnBoM3U4ZE80dm0x?=
 =?utf-8?B?NWRLU2V5NjNyZW9KYzgybTdwK0JyaHpPWnBFcHd1QjZHRFV5OTVHQms0UTJr?=
 =?utf-8?B?dElvQXl2aHZsV0lIaktiM0w1SDVMRzFHTzJmYVVJMVJiYVVCUEMyb04vazdL?=
 =?utf-8?B?cFB0UVFDbHhGNUt0SmNEM3c1SW81YkhnbVZIZDJqcExtcEtPVVlQNnNUL3M3?=
 =?utf-8?B?OXJGRFJlTXZiVmdVcmRSTjNvSXpkZmZMc0N6VGc5b3R1MVpnUHdXRmlLQ0cy?=
 =?utf-8?B?d3I3dTBhTWJnNENIUmNPeTNYUm0xdVAvb3l3OGtKVzdkZzAxZW1ySXpVRjRF?=
 =?utf-8?B?OUVWYmRNMU9wL1gvY2dPbWxCMk1xVm5TSFVyN2JDL0Nma09kRW02RHpvaXhS?=
 =?utf-8?B?NXd3SnI3NlRnTG9sMVBoSHRsb3BZVmswcWloMENFNmxTVWdqN3ZhczZZVWox?=
 =?utf-8?B?c01ROUgwUktkNjB3YUVRa3cvSzEyd3FBdkRnVkZVWGdCMStNTGFHMlZ4WnMv?=
 =?utf-8?B?UVQ2Mll0elMvSlQySDBqdFRSTFFRQ2NHOFhFZ1RBWWlrRTBIZEZSQnNpY1ha?=
 =?utf-8?B?MnVWR25hdXp3bFJwSGRqZEhNR3VWa2VWYWFUa2FuNWxyMm9iRm5VWlhuK3dp?=
 =?utf-8?B?aHUvaytBWXFkUE42YXRxME9YcTBHZklVSjg5bmxHUWVsS01pbTR0RnRSTkc2?=
 =?utf-8?B?SkE2dEJTYlNIVlRRWEo0RHN0OVFzSjVjaC9xNUE0amVXMnFQL2NjOHROSi9K?=
 =?utf-8?B?anllOVhSQlBMVFBYeUZxUEphVWlOQitEdy9WYWtnRFQ3WUc5SUtpMUVVUnBj?=
 =?utf-8?B?MXM2YmI3Wm5vckVvTEVsMS9iNnJ3Vnh5UHN5TitidGpsVXhBcUYraVdFVGlC?=
 =?utf-8?B?WWl0VG1qT3BHVHNvakEzejQ0R3BDMFF4S3ozaUR6MmtabExYYVFPQ0JzdEJu?=
 =?utf-8?B?MVJFMWtCQkVlTFZOUFlaYWZ1dnhQVTVCTEVSbGpIa0tkNktIa2hFRzljQkhN?=
 =?utf-8?B?bTdHa2N6bDU4K1NUWm9mUW9qTzF3MUZpMFhFRk1QTmdCeXg3cC9XSXYrTlRp?=
 =?utf-8?B?L3h2ck45SENhNTJhclBoSnhjLzllK3Q4eWVyQ0hpaEs5R3R3N1pKUE02YlVs?=
 =?utf-8?B?RUljbjROcklVZ3JLV054T2dsUkp1cy9zNkVZcVZ5eitsM1p2b2lBbC9XUnM5?=
 =?utf-8?B?aEhGMVZtRkkyeW1LclBEMXcrT1dsSkw0RzhyVEM3OUx4RlFyMUU2TGRTb1NX?=
 =?utf-8?B?YWh5L1k5dFBzcTFQZWQ2S1gzZW9veGQxK0NFS0FDbjdwYnhqMlVuZ1RHZUpD?=
 =?utf-8?B?cmNaWk45MWJFSkZocnVPWHFseHFENXJ4eEN2S1lZK0dZRlJNcG1kd00vRUVO?=
 =?utf-8?B?L2l3K0oveVc1YUxVWm11RDBnSkZmcTBoS0ZSZGpqV0p3bnN2dy9WWEVVWUxH?=
 =?utf-8?B?a0JFME83MStGOU9PdUtUSTdja3lVQ2p2L0hCN0kxN1hBOFFsN1pCL3VyOUpr?=
 =?utf-8?B?YWhaYmNqNW4yclNzM1oyMzlpcEcxOHY4SVV2R3VicHFGa0w0NjhWTHNHR1lZ?=
 =?utf-8?B?NTNGcnllYWMyaDdzc2ovTFNHaHkvZit5Vk12Y2orayt3SGJFUkN5WURvN0xM?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d48ac1a-841a-47b1-5ba8-08db943397db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 15:09:11.7797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhccGMASCBNvqM8hayF2sF/aBcKPQk0YoK+nq6ty1aC15VrDFvIuI/TWL9TOJPnZbDj/9PfYd5jQrH3K5F1LOQimMt9xgbW2o0IqYZn0lQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6169
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ratheesh Kannoth <rkannoth@marvell.com>
Date: Thu, 3 Aug 2023 02:08:18 +0000

>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Sent: Wednesday, August 2, 2023 9:42 PM
>> To: Ratheesh Kannoth <rkannoth@marvell.com>
>> Subject: [EXT] Re: [PATCH net] octeontx2-pf: Set maximum queue size to 16K
> 
>> +ring->rx_max_pending = 16384; /* Page pool support on RX */
>>
>> This is very hardcodish. Why not limit the Page Pool size when creating
>> instead? It's perfectly fine to have a queue with 64k descriptors and a Page
>> Pool with only ("only" :D) 16k elements.
>> Page Pool size affects only the size of the embedded ptr_ring, which is used
>> for indirect (locking) recycling. I would even recommend to not go past 2k for
>> PP sizes, it makes no sense and only consumes memory.
> 
> These recycling will impact on performance, right ? else, why didn't page pool made this size as constant. 

Page Pool doesn't need huge ptr_ring sizes to successfully recycle
pages. Especially given that the recent PP optimizations made locking
recycling happen much more rarely.
If you prove with some performance numbers that creating page_pools with
the ptr_ring size of 2k when the rings have 32k descriptors really hurt
the throughput comparing to 16k PP + 32k rings, I'll change my mind.

Re "size as constant" -- because lots of NICs don't need more than 256
or 512 descriptors and it would be only a waste to create page_pools
with huge ptr_rings for them. Queue sizes bigger than 1024 (ok, maybe
2048) is the moment when the linear scale stops working. That's why I
believe that going out of [64, 2048] for page_pools doesn't make much sense.

Thanks,
Olek
