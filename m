Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46D6766ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjG1Nwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbjG1Nwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:52:30 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032A12D47;
        Fri, 28 Jul 2023 06:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690552349; x=1722088349;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OBBtEOOUJTfJTyaqfBjIbufcaCOTVbXtgPdvwqmngOw=;
  b=RLNm/buzSisH+//1URCn4nY2//uEN3QzodLSVuNBKUKP+fuAE8OFAo/v
   IyYDoj+vZIiL1z2Qs3ioI2JYsqmEoye+SM4xeaNHctuTVNMxbQgvMzPM+
   hd1zXykBU6SqROlcmy252ThO9plZ0wVn+y8vP1lfwtKlHxnL6KFeSz8LN
   tXlcuXD+MYvxl//yUqLI71AIcJk4Neepx5ZedAs5ES7m19VF+Q/d8AIzL
   4CAV+KuUhsM6a2HWHIx+qt3ZGsIg8LnvkN7qZRfNlAKa+ZfIsavs7jgVj
   +xXNuxGwR+bHNXhQcTSr21M9WvAen/Jnmj4hqTJb9CkLI4R1Kjw5XOY52
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="371292740"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="371292740"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 06:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="727490167"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="727490167"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 28 Jul 2023 06:52:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 06:52:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 06:52:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 06:52:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ly8y4cHFUpS5wq6oPPnlVxgcEbA0eqEjbp/wRMWmGCQMplWS47GbfTtn0o+nxZf4BkZ3rzwuInMtCB9/MhWMOVYJvg8tN8oKjDfbSj+61xPd70clMzmv3wozWL8aMtI17aBotLLwp+GqJ25pPJF5VYoAR3c4Rhkd9x0aTeteGHiBTCi/eOky+dSdKPrrxtvYM6nshrNkLNBDb6mNvEcA9dw3CNurEbcBd/lKxf1BXR+fWYV4CFYDsZwc0J4rmdKFTqlo43+1/lJ9xrF31RcE0Ko16PC+4S1m9qZghJIqCB+IN/vOFdThg82xguZithw64RPJ67jaWmubn417IXuTlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ry49q0rgpynMrnmEVRImNM6Jsw9A88ZHB4Z84nStpfQ=;
 b=kfIjgQ/+e+BDD21zFMbnJfkzYI1RpV3WpNsTPTru4XFU3wyqCSlxeYxTxI16ix6tY9s/NymECWLwAHxMhubnkKfHhmJoNB/O1janTkfVXQ7XVy8vFfXhE/ww0vHulTksI1yA+rrqhpsBzirLQTNM1afFavcVyp0W7YewN6+97KBbMioFQ61PGuCG4RfaDSfdyRW1MXHjyPTdGdzlYZFi9fPo7e+HcvULJkFKg5kT53cQEdXawOHzQcXqyk88G6Flblx8x3iApoRjLFFs2d7XOUL473k19BTw8Ml2/ZIX/Pti3q3RFhOmjE4/zuR3TdNXCcqYVc2AhSCW2r5Vbov0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB6322.namprd11.prod.outlook.com (2603:10b6:208:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 13:52:24 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 13:52:24 +0000
Message-ID: <38c06c0e-7467-2596-133f-05c5c1569ccc@intel.com>
Date:   Fri, 28 Jul 2023 15:50:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next 9/9] net: skbuff: always try to recycle PP pages
 directly when in softirq
Content-Language: en-US
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <brouer@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <qingfang.deng@siflower.com.cn>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
 <20230727144336.1646454-10-aleksander.lobakin@intel.com>
 <db85d260-fdad-9b7c-cf7e-2e848151292d@redhat.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <db85d260-fdad-9b7c-cf7e-2e848151292d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::8) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ea4731-c6d5-4ed6-5fec-08db8f71df30
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XgxMJO+F/ZCNPA88IcgSUDlq4si8c4wcTfJT8UsONPkPNCNchzAMm3zbT1yYLD6pIqG40wgMX+WFaSeORZOzgWBKS0Xe2AvPSm6XzXagqPtJX2h/g4I2Eo+cFdC2rUJTugbywJq9mXhwzygTgsGtwWvWNAyc2FW1F4nNpcFEYce2er14iQKoct75ERHB2kDDKbd6FaYePwm8I0sOa9Sdx4Tc9ib9IvnkKr+dEebou7g2oAy3vj4nsXWMMrGsFYn7Qu5oUcUNPiXSrnejJRnoF56tR50LyJOuOoIDPPdwQQqFq09FsdomFCDwxf0VA8LH0FsSsRkRiTfkUE5QxDl4/kqTpd5hW3Aqz+kfzdbgojaVctppr+cirtOfRRIETw93mrBE5roC0EFHyQuRb45I4WYpr5V+FiLq+183IEs7uzgYkIBBRrNG9B41AWyfMm0zLu9HtN8hCVUa1FGmWffrlQCGekGeQgVDuJoeQ1x+3bgcd3Mzs4t4t83JHdw0Pa/AI+XX+TuSWy7kf0JQtFKip6PncTHCWZga0Pwm5bli7oz3Z2PPfEK1aAiQiu9olxjCYzUziaWk9SCgJBoiwxHW2uaVao9VA9fY65s0Jt7/+wEOVLZXLZaAVCS9zFVhuANIwy4NIBBEAW80Exkbje1XLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199021)(316002)(2906002)(8936002)(8676002)(7416002)(5660300002)(41300700001)(36756003)(31696002)(86362001)(6486002)(6666004)(478600001)(26005)(82960400001)(6506007)(186003)(54906003)(31686004)(2616005)(66946007)(66556008)(83380400001)(6512007)(38100700002)(66476007)(6916009)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmxOK1JhRE50a2V0OVo2MFpmUmpjbGpTNWNncnRQRC85bFRhTGpZdWlrMWJ6?=
 =?utf-8?B?RXFjOWNGcWtWU2V0QWF2TlJ4ZHZYTk82dXFJNFB3bEQxZGE4em5zemNydFhW?=
 =?utf-8?B?V3FaZG9MNzB4aSthblpYalBTN2RWVnZYSCtzeDBJRHFEazd3SWNna3E5Rzhz?=
 =?utf-8?B?MDFOcXNmeFUzZTNoTG10L1luTXdnR29SNk9xSkpnUkVGNVY3anp5ZHpSM29K?=
 =?utf-8?B?NnVZQVdFN3A2aEltMTZLeWRPL1Eyci9xVmh0M3VTM3h5YzFENElnUmFaRFZV?=
 =?utf-8?B?dGZyeHFkUGhNSTV6WTk5TXp1YTBqQ1hpQXZRN25wV2JBc2VtUUdJNnZsVjNN?=
 =?utf-8?B?VkNZQ0E5WmlaVE9OZlY0eUxuTnhTWkl1akxaa1c5VTA2a0hvV2VQeG85Vld5?=
 =?utf-8?B?UGZpU1VBNEpndkUreGNPMlZNRUIwUDZlT0RqTnBxMDJ6UFNRTWs2S1VZS04w?=
 =?utf-8?B?SHZINkVpWWxnOEhEQzFkY1hXbUVDbmpJNHNuZmZVY3IzM1VVeHljbGNwNTRj?=
 =?utf-8?B?UHVvU2xRQ3pyNDRkYmFzOElpUzhFWXpGUlJSalpaYUJvSnY2dnRUSlZnSjhn?=
 =?utf-8?B?OUhrZHNjUUp0Mklpd3gySEFYUXVzY2FRUnFZSS9WM2xCazNURWxOOUJ3UnNl?=
 =?utf-8?B?c3V0UzNaK1NLVXd5Vy9TRzQyMzNDMG1rN2szaThOd21tRXozanlIYkxmSTl2?=
 =?utf-8?B?cWgzYm5YYWhwVFo1cFdXOER4ZE1weHkzUGdBazM0amVjV0pLeXNiNkVJQnNo?=
 =?utf-8?B?UHBWbStZdVJDU0FDVDlZcGxySGdaRkpEdGJ4SVVBUENsRnlxR1haaE0wdU0y?=
 =?utf-8?B?c3lFd1dGZ3ZXSWd0OHRtbzZFSjlCNlJvNDZGOXNoakJvbExzRXZUenNBeS9y?=
 =?utf-8?B?RlQrMTVTTkNyVUxyZTZsZE41blFaaXdreWs0WVpxTkQ4bFdpVytxV1VCOHh4?=
 =?utf-8?B?emRITmZTWjFRVFhiZEJrUXJoOFpVSVd0L0JyL3prclI0VWpaUzBEbFVpVHVo?=
 =?utf-8?B?T3Z1RS9xRlNDOFBBL2pXQ1h2SmhoeXBVZ052Y2Y3aWxudkp2NVBNSGJkQjdG?=
 =?utf-8?B?OUNoRGloN1J5ektaYzA3REVUcjY4dnkrclVaSVlHQ2tzcFJKa0dGVHgxdWlK?=
 =?utf-8?B?Vk8vNHBVMjBCZmk3RDRpTyszUVlOMnpmTG91NU1waVlEaEp3SkRHTFpNbzBs?=
 =?utf-8?B?cnFpK2FXQndGRTVpZXplREUxQmttSS9Tb3BJU2gwdGJ0L292RmNQUzZ3a3Vi?=
 =?utf-8?B?K0xZcUxwWi9hVU9RMndxWXUzSzhqQ09jWVhZTWNiZ2J6dkl3dXpiQ0pJQWI4?=
 =?utf-8?B?TTlnd0RGY2RSay84TUNrTzFjbGVLMUpJRElyZTgxS0ZOYXJMVERiYUR4eWxS?=
 =?utf-8?B?aURxcTZBMy83a3pUMzNlTHNIY216a0Vpb0VPeEpEblFzek1ZYlE2cHRYQTFv?=
 =?utf-8?B?U25xT0xKRnN4OEExWnFKbDdKdHluYlFyVkpMZ0RiVFRTQ0M2cmxXK2xUc3ZY?=
 =?utf-8?B?S09KNmN2Nnc2TUlET0RCZzFFNy91ckw4eU44QkQ1MHpXT3pGRU93M2dNMTJo?=
 =?utf-8?B?aWt1dDJkcDFBNDh4MkFtZnlEa0JJa2hJSHlpMUZUMXl0K3laZVVtOTZUWmZY?=
 =?utf-8?B?NkQwQTNUMGxobTE3TXgvSGdmNGt4bXhZbHcrMEx1ODNpOXBKYUE5S3NrWWhs?=
 =?utf-8?B?T0g4TEo1WW52QUtMZ2lnOHhRYTlBWkxXVEtoYW8yNlN5WE9VeEtJM2phdEhk?=
 =?utf-8?B?dExmazA1ZzNkR1ZPU0daV3BwRnVZTjJxRWJyeTNtQXhMRElQb1pWUEMrVmMv?=
 =?utf-8?B?anp2UnRBQzFkOTZjMkVZS0VCdDBGUDhQcldNQnUramJreWRRZTZqanVVWTZO?=
 =?utf-8?B?VWVON0ZBNFBGQTJvVHFoVm5reG5OcWd3WDVENjFETzlNaXpDTXlva0hBRzU0?=
 =?utf-8?B?ZzFFV2Y3bFpaQWp4TlZvdmFKTnJhZHVSQ2lMRi9qVG85Qnl6QVZza0JZSldB?=
 =?utf-8?B?R3VvZUFQaW0wMmEvdm1QMmpCTWJiSE1lbzljbUIwQ3ZPMGFtYllXV3FQa0FE?=
 =?utf-8?B?cm9rNGU3cWZXR09GQll3NngweDQveDNyT3FOUEJhTzdoOXZhOXgzcmlZbDlr?=
 =?utf-8?B?aVlXcWhFSG0vYWFaakJ5dnNyRU8wOG9HN1hiWXV5akovQVlrUk14NmFJclBD?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ea4731-c6d5-4ed6-5fec-08db8f71df30
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 13:52:24.4184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlaVON24/6SZ+StCduDG+cNZBQChXxBnAxf4QyYPr+r1Bw8bJpj4IyQNG76r8JoFEuA72pS9iCZKQvFhKMYTPfdGWS3dUUfNgIBzm4ZAOHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6322
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Date: Fri, 28 Jul 2023 11:32:01 +0200

> 
> 
> On 27/07/2023 16.43, Alexander Lobakin wrote:
>> Commit 8c48eea3adf3 ("page_pool: allow caching from safely localized
>> NAPI") allowed direct recycling of skb pages to their PP for some cases,
>> but unfortunately missed a couple of other majors.
>> For example, %XDP_DROP in skb mode. The netstack just calls kfree_skb(),
>> which unconditionally passes `false` as @napi_safe. Thus, all pages go
>> through ptr_ring and locks, although most of time we're actually inside
>> the NAPI polling this PP is linked with, so that it would be perfectly
>> safe to recycle pages directly.
> 
> The commit messages is hard to read. It would help me as the reader if
> you used a empty line between paragraphs, like in this location (same
> goes for other commit descs).

O_o
I paste empty line basing on logics. These two don't have it, as the
second paragraph is the continuation of the first: it expands what I
mean by "a couple of other majors".
Do you want to have empty newlines between each paragraph instead?

> 
>> Let's address such. If @napi_safe is true, we're fine, don't change
>> anything for this path. But if it's false, check whether we are in the
>> softirq context. It will most likely be so and then if ->list_owner
>> is our current CPU, we're good to use direct recycling, even though
>> @napi_safe is false -- concurrent access is excluded. in_softirq()
>> protection is needed mostly due to we can hit this place in the
>> process context (not the hardirq though).
> 
> This patch make me a little nervous, as it can create hard-to-debug bugs
> if this isn't 100% correct.  (Thanks for previous patch that exclude
> hardirq via lockdep).

Pretty much any -next patch can create "hard-to-debug" bugs. Not a
reason to avoid any improvements, tho?
Speaking of this particular patch, can you give an example of situation
where this wouldn't be correct?

> 
>> For the mentioned xdp-drop-skb-mode case, the improvement I got is
>> 3-4% in Mpps. As for page_pool stats, recycle_ring is now 0 and
>> alloc_slow counter doesn't change most of time, which means the
>> MM layer is not even called to allocate any new pages.
>>
>> Suggested-by: Jakub Kicinski <kuba@kernel.org> # in_softirq()
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>   net/core/skbuff.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index e701401092d7..5ba3948cceed 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -901,8 +901,10 @@ bool page_pool_return_skb_page(struct page *page,
>> bool napi_safe)
>>       /* Allow direct recycle if we have reasons to believe that we are
>>        * in the same context as the consumer would run, so there's
>>        * no possible race.
>> +     * __page_pool_put_page() makes sure we're not in hardirq context
>> +     * and interrupts are enabled prior to accessing the cache.
>>        */
>> -    if (napi_safe) {
>> +    if (napi_safe || in_softirq()) {
> 
> I used to have in_serving_softirq() in PP to exclude process context
> that just disabled BH to do direct recycling (into a lockless array).
> This changed in kernel v6.3 commit 542bcea4be86 ("net: page_pool: use
> in_softirq() instead") to help threaded NAPI.  I guess, nothing blew up
> so I guess this was okay to relax this.

(below)

> 
>>           const struct napi_struct *napi = READ_ONCE(pp->p.napi);
>>             allow_direct = napi &&
> 
> AFAIK this in_softirq() will allow process context with disabled BH to
> also recycle directly into the PP lockless array.  With the additional
> checks (that are just outside above diff-context) that I assume makes
> sure CPU (smp_processor_id()) also match.  Is this safe?

Disabling BH also disables preemption. smp_processor_id() can give wrong
values only when preemption is enabled (see get_cpu()/put_cpu()).
Also look at how threaded NAPI and busy polling call NAPI polling
callbacks. They just disable BH. And nobody ever said that it's not safe
to call smp_processor_id() in the NAPI polling callbacks.

When your context matches and the processor ID matches, how could you
provoke concurrent access?

> 
> --Jesper
> 

Thanks,
Olek
