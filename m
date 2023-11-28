Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88597FC1E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344761AbjK1Qve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjK1Qvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:51:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BECFD4B;
        Tue, 28 Nov 2023 08:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701190297; x=1732726297;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8AcFphvl2r/ylBqtrwuLKB5ZrrRetYuVVCN3CKStIUs=;
  b=PWH8WZVQ7BuEbXrR2QqjyAydWXadF6ZKJluaPN3BXLLtEsoDgZG0z+Bf
   JLSU/JJDl5IU+a6kxuGWUl+pHWs4i/hecxS+kplxsr6yCvsysp3XUaTrG
   UUP5oL3VL8KvUNUdwGEyyI0/T35hv/pcHwJKU0i7V+6U2ldDAisdAcLLt
   NLtEB9ZzZXudv0q1Mm3ZMJpAzWWDqJu/UoSqgqFsoepQv9vhZa1ezvK+B
   +NszGLHIAQCp2UtUxtA7D4gjN38L36yEiPJwy8UiQ+9aQbUfPYupHNucu
   q9cc95URqE8av5E8jF5G8mLtqDrYket7zHE5ZXp18Rygfd1jxNhcjlFTL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="457294125"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="457294125"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 08:51:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="859479761"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="859479761"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 08:51:36 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 08:51:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 08:51:35 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 08:51:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ylg+57am85xTYG4JqPdoFLrOwn7wrNtGeKU/nASFeyT+HOpWNMxbjEla+WV1L0Gfz7XAwgm/XxzskWfJz6TZp3fDXxYnrNvFLDGzCZXlpTxNjlsQwpJ55nODjT6mgXCFTINCXhqB5zK6lIMMGAeGmUGFwjlfhPiZmiafP1qjiLXu9iaNLjOYEnEZUwaWtZ4V5TvGEwKb0kw22CByep0DyyK6e2wfqc6Sa90cy7a+v3TdzMA9PtCIc87D2h3kaMa6bK11+xg43VaF0buO66ug7UErATR4T25mcXk1bgj8trh57b2OTyrmJDKBNnnQKkxjMEIbPLgIH/g7DhGfsYONzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mY5ukfyoKrrNpK3YRsrjbKa4tcBSX7C/03E8YOMUEHg=;
 b=ZCrVvKS58WZ1SosaM0sgM45xMkHw05Otjaqj9Nx4DgI0XXeQZILwQW1tQJL2RWjE8SXQdDZkvX9W4XSnf4Yrv+VyZK1L5fGlI/5+RGg+TKL4kJ84GSuFaHXqRdI28IJQ7KHI/G28wUGGECO4WTKnrt7LqILu6YDUH1NvGUVYrEk5VrPnxNu/af7EK8qyIqSoU/L70mcIWR30ahQlrBknx0jzViN+LBl6Y9kjrGEvrepapQO5xUOIEUeGB5Se6/oYYnhC0MZFEAjbUCby5sU72G0YKDB/ZfjSC8Q70tE+RqMbk6tgfAxKvKuQn2/OflXgI0G6pfhzEtSmmoR2iC0UVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SA2PR11MB5019.namprd11.prod.outlook.com (2603:10b6:806:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 16:51:33 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 16:51:33 +0000
Message-ID: <9a65e703-3476-4584-bec0-8f41198d840f@intel.com>
Date:   Tue, 28 Nov 2023 17:50:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 03/14] page_pool: avoid calling no-op
 externals when possible
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Yunsheng Lin <linyunsheng@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Paolo Abeni" <pabeni@redhat.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
 <20231124154732.1623518-4-aleksander.lobakin@intel.com>
 <6bd14aa9-fa65-e4f6-579c-3a1064b2a382@huawei.com>
 <a1a0c27f-f367-40e7-9dc2-9421b4b6379a@intel.com>
 <20231127101720.282862f6@kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20231127101720.282862f6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SA2PR11MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c4cecd-b54d-4c93-932e-08dbf032471f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YuMBBaXAm6Yxkn7F2GXLQ5DaqQdAX9/Lke2YJfbw/uwL8llZ0xZyOWZAJsGTyr7ER/ypkUgi5sacKWc4Wgf+/FLJ1V0Sbkpq58+ojn+Y1f27b6lObTYEZ+uxNGPFJSv/lZ3zQdaupuYaMNj95Ayzc2PHsqK0psCycdl+9oibq5JrFA1dUlGvmbRz0Gfvl4EjGcH0HoghV5VRK2XMgYrePSZxBOQspRZMQIWhFYG+dQoCCq7p9bTjOj3nAnGKbNlNKtCqnvtPdS7KK5mvqTnsaWcb12bIy/+1lwmwlIjDFCuE3upfLM7BdpoRpptHgeEKUyMNR2E9i1Nv7aP/yOy4shA6CP+ez5EyhNvIaiZguxd3l7Yi96UKZqV/ZGezc2V/QBcreoRWPQfhNjRTGV50KcFXmo5svkDMc+Y/jMmQq34m/n/XenHmKkGFqeUAnXO47oeGHLbVFtL+LDIZ0opYyMGSnKTIn7AxG2ajA0tKiCCxzKuUk1nwW1tg+qyGNxbwJYYKQHXZ7HTmDUHkT9AtZejyucpBIXVbPjUv2xgfMhgEiBFIf0tjS0OttvfnNZHBFuu3Gg3YSoxgnXI8JD0U8yUaYIPzhsdWtJGmiKpyAIAGTde+c8l+4/4uLmwKX4j/BK2/Y0wV212gcR0dwzs03Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(316002)(2616005)(6512007)(6666004)(31696002)(86362001)(6506007)(36756003)(26005)(6486002)(478600001)(38100700002)(82960400001)(6916009)(66476007)(66946007)(66556008)(54906003)(5660300002)(7416002)(2906002)(4744005)(41300700001)(4326008)(31686004)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUxDWFJkYlBaUEdNZThyT1FGYzNUNXZTbWhYMm9EUVVjYTRTVzYyelhaUkg4?=
 =?utf-8?B?K1o1ZEdnNFhCVTY4MmJOR3pKNURONnlNbFJCWmd4QlVLOHF5azRJazl2RnY1?=
 =?utf-8?B?OElsbW44Y1JVSnhCQzArZEcxT0toSDhQMjl5VUUreVVMcHZaZ2U1VnhYcUxj?=
 =?utf-8?B?dlJkYkx0SUpDc1gyVUc1MnFON1JDVkMrMUFYbEZ6VENEM01uTitITWRyNGJh?=
 =?utf-8?B?Njl6YzhQMENlMVZmRGVYckJKRjdSUXFJVG1Cd2RSaXF1bld6MFFOOHNNYkla?=
 =?utf-8?B?UVpYMFNhaVgramhseStIZzNOVmc1RUwwai9VL1U2UWlUc0VpOGhqRkRDUEda?=
 =?utf-8?B?bXVuSDZuTDBYRS9LRHowLzg2d01qNFFxVGJ4OVQxWnErWnZlMnMzYm5USUp3?=
 =?utf-8?B?YnczblBoYlhNSE1rKzlodXUvQWtmbk4rZmx6NkhLZHpZV1BYeE1WNTBxaHYz?=
 =?utf-8?B?WFh4UWZQTVB1cjFIU09CYXp0TWJURGxKWlFud0tqYUZnckZFY0FOaitRaUxH?=
 =?utf-8?B?enhPNlYrQ1h3M0VMZ3QyOFZXTjgwMXV2Rlc5RE1kWnlwb0dFa1VyeWFVVjFo?=
 =?utf-8?B?NmlGandUWERWdTJ1WVBQaEFDWGdDYkJJNXE5WWFSQkExUlI4d1d1L2NLOGRG?=
 =?utf-8?B?T09EYjNrSnRHVXErMU04NEZNWWt6M0hteDlwNDdKcGt0VWhTRmdTVVZpN1NI?=
 =?utf-8?B?dkI3Qk4wTzhmV0tZOFZSdVBPdFN6VmpkWVEyOWZnc0tQTGFsZWU0R3pQbVMz?=
 =?utf-8?B?NEI5SjkvZGZOaVlnWmpUTHY1eTdzQW56Q2RQR1dWaFc1d2YxSHVxd3pUUlI1?=
 =?utf-8?B?MU5Cb05RWVJ1RTcvUHZrNURPdkJjMFhuSTFIM2pidGJ0cUVSS2dOdmozK242?=
 =?utf-8?B?SmxhOTJjNDZ4cGsySGJCSVZYNkg3aDVVRlVxbk83a3c2NkRQcW4yNXN0c1p2?=
 =?utf-8?B?QTBrWXoyalYyUUZTY3dPYTZ4VnBIWmgrQUc3dGRSTjVXRzNnVnNMMmVtc2Qv?=
 =?utf-8?B?Vm1wZjJmMDR1YkVRSm9vS2tIS1hUKzJYZXZjejdYOFFxMWUvM3h4OFlVOXF4?=
 =?utf-8?B?amhNQUtrd0pVcXBtSTR2UHQyL3NsVFM2MUJSOVJiL1BkajFMeXhPTnlCRy92?=
 =?utf-8?B?Y2VrbzVKakZ3RzdBQ3U4WDBjNVlnVXd0cGcxNXBLTkk4N2ZaZURPa0NuMmpt?=
 =?utf-8?B?ZmFtQ2hhZ2RKY3VNZnBWYjN5ZFFpN1ZqQlI1S0VFNEdQWDVJVktYU3krbWpE?=
 =?utf-8?B?a1VJSk0rYjZ4NmZOdHhZbGVSMEh2dy9WTkIvc3M1V2ViK2tNdk9MWGxyYkVS?=
 =?utf-8?B?bWlFOEYrRzR0dGxXbEZKcGw3WG5xTS9sZEJHK2dOWGpzME40SnAvZnZkM1la?=
 =?utf-8?B?SDVjeDhLR0w1RldCZnNpeVVPWWlTbkVmM3l0UHc2eC9WbWliby9XZmdjb2R1?=
 =?utf-8?B?RUJVVHNOQ0ttRHBSWHBrblRTSGZZTlVWL1l4ampMWE1XSVc4L2J3OW1WSmVx?=
 =?utf-8?B?Z2d0NUwwZCt0Y2ZkN0wyWFBIUzJkUXowVHhMd2dTSUEzVlJYSGpoTHV0L2dn?=
 =?utf-8?B?T3NzRS8wZHU0azNFQVo3SVNLVFY0eEhJRmhEUStWSWtTR1JGQU0za2M0Tk5o?=
 =?utf-8?B?SWd4VUVIZ1NhZFVRK28vaTR6TGJPTnhYTmx0MHFBckZzTStzeU9IUTNTQ2tv?=
 =?utf-8?B?WGQzUTEzZy9XTWU2Qi9MTCt6OFp3dEpZZ3VRRW9HdlpHVEJWbFZ3TENWRGhX?=
 =?utf-8?B?M0NyWEZYOWIzUDQ5WjJxMnZ6NENIV29rOGU3YzBZSWMzaUt0NEwxSzJnbDla?=
 =?utf-8?B?Z1ZGMy92L1MzdjhqSjlKYXQ0Um9GR0hpWG5rQ2Qxb2M0SWlHTU5jNjNJTDd5?=
 =?utf-8?B?ZmlaeG1SaG8wbCtWdzcwcTFrOXNoZlVrZDdIWmR0MER0N1VBcWRaLzh5U053?=
 =?utf-8?B?aS9BVkVPSnhrUTRCV1RxTlBUQTBsamx4cFZSMDNBUHpMS2s2VW4zNWVhalpx?=
 =?utf-8?B?b1p1bUNnWUZkUGhnKzZuWWRLOENlWXh6M2orbGlHOUVqOG4rbnhDdFBqaTRD?=
 =?utf-8?B?QUpFRkY3cFVLUFpXbDhPZE1tSElyckp1UkVCMGRqZ1hJYjhuakU2cHFQT1d3?=
 =?utf-8?B?dFpOTituNjlnWHQwTU5EZFdTMmx1N25nTnRuNTRHMUxXU1N4c0JWS0ptUXBP?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c4cecd-b54d-4c93-932e-08dbf032471f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 16:51:33.7749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnpQJZ0eyorwBPfo1ll6kMGT/nGzTA99sNY0zFxKyN8Se0zMjY/Et96Y2zULT3+ThLubZARWUp9gBYxkAnUhYL+96O0M5edbTi5eqLTKd/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5019
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 27 Nov 2023 10:17:20 -0800

> On Mon, 27 Nov 2023 15:32:19 +0100 Alexander Lobakin wrote:
>>> Sorry for not remembering the suggestion:(  
>>
>> In the previous versions of this change I used a global flag per whole
>> page_pool, just like XSk does for the whole XSk buff pool, then you
>> proposed to use the lowest bit of ::dma_addr and store it per page, so
>> that it would be more granular/precise. I tested it and it doesn't
>> perform worse than global, but in some cases may be beneficial.
> 
> FWIW I'd vote to stick to per-page pool. You seem to handle the
> sizeof(dma_addr_t) > sizeof(long) case correctly but the code is
> growing in complexity, providing no known/measurable benefit.
> We can always do this later but for now it seems like a premature
> optimization to me.

Yeah, this also seems more logical and optimal to me. Will wait a bit
for a possible reply from Chris and then send the next rev.

Thanks,
Olek
