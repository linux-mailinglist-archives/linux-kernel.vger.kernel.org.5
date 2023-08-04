Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1F2770322
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjHDObX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjHDObU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:31:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CDF46B2;
        Fri,  4 Aug 2023 07:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691159479; x=1722695479;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ImeToNBHawxz9LX5H+EUdj6lli9JfSzFeYUV4H3GuSI=;
  b=NLE7GAGvfrZ+GwAKYWwYixIts+NZ680KkoQjJbYomgloe3X+JYumpyGq
   r0N19tTE+uQ+w9TKJc8oaryAt0D1i/VG2TKuvTR5O8291hV4Z/bLc17gP
   Dts8LisnAGK3uXSgQx3Gxdvh7+Otd+BbSuz46uGhexMNo7oDKpvFhbXV6
   H2lazzCarfQRQIq8Tro2MXpeSzrGv0ZpCNcD/5gqtL7EHWQVpb8cc3JeC
   jplrKQxTg6z//mVKpR2PnOhAf2Jz7gTxeK/Qa+FW0qiDVikGq3M9UmKKi
   AdzEj4R9T9utNAwQzl+cOCdJxGbz1Hw1G6JEEUKA9YEOfxL+9/e76s1oD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="360220802"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="360220802"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 07:31:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="853761984"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="853761984"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 04 Aug 2023 07:31:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 07:31:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 07:31:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 07:31:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 07:31:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buL/X73KMR5zYQgrVQsa/oDqO0oBUJSXuO8pEkNtH5Y+dVzhCJzlUAG+bEUoCYLQkGMVbU1k4pVoUOVQt0qZf11Tp2uXpkLY2g+6HW4TEN8AovTWpGNnM5bbzfubhbWRIgVTcBTZw0diANzLb8f+RJUXFRbsJYyEjQLX1ndT2HeHVYY7ByeUxIrRksD5c1ouNhI6Um2UBKJdfOAnaiD4ZAfX3Dg77j5DIsU6taFpfczeDM+DsYjv75QYWq0ENwbaLOzZzaxK3mq+lWgjOaRvAqN+WAoGGMTDvOyCeFQIiA260OPG0jhRbPkBy2Q8Q38h4afct6sWpH10/axQ0z9iVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUorN9eqc0/LSymR8olSUTU3P+SBwxh2bA7ZWx43cUU=;
 b=l5H97hKPdGVpTRnPJePcZfqylatfpartZzb3lKxbSmMkgKxzrFsRCdUtXLG8vVY6wyJUFQVb6sDvS5oB/Mi6RlWtHuTVz9W/s+bAlmqWAbhIsYb/eyi2bqQax7S+hroefykyJ/UgZ1hjaNWWnQdRneLHS2AQQbpxGBN3oRfgXDPeoRFwwZvxFff/H/ZKBmGjUg0jlYAA8VS/7rECLIp9TAodGL9xAqt2fiZC03WSm4r3l2Abs+B6wofLRyVMxGZgRKVk03wSfq6tOEGzz0TUx/keS9dJEAevWZGFf7ybftctEK0bSvDDRHZoalpiLRggcuxOoVrX3pJ5v7vLRpHyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA0PR11MB7861.namprd11.prod.outlook.com (2603:10b6:208:3de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 14:31:15 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 14:31:15 +0000
Message-ID: <bf553c4a-2f31-9a92-77e9-7670b062e768@intel.com>
Date:   Fri, 4 Aug 2023 16:31:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v3 0/6] page_pool: a couple of assorted
 optimizations
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230803182038.2646541-1-aleksander.lobakin@intel.com>
 <20230803182121.1baf4c13@kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230803182121.1baf4c13@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19)
 To DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA0PR11MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e29683-bbda-4780-d39f-08db94f77519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JvWCNATg8JnplziSWkJEKmAUKyATUGARQEFTICSMwAuWiOAlXDYkj4T/GxFwKLn2/KwMev0JTcm2lmhHE3zwdEXxwkyr4/4oWrLbVeghzfXlT/2UlagJc8O98o2xLJHfta/Q3BsUv234tSSJJwh4JdM+16Z9UyloYQqrF5nZzwgVvIabP4dkSgmQ9WkjFFX+9Uc1L8RGdvS9kZS3szU2WQ2+NsH2r9ACUGjUPMyizLxqiVJkOuvMYVP+jcb7ZGrvHZXaS8lJQoFaAl4vmanTUy/W+eri0X6m7JmBPs55HDfsVIJk0hJp7P1Jp+m/UJwENZS75O4h5hVBz8X4QaA3ft+N8WERmG0pvvBqKJIxFJDrTA4kXTFSF5YsGliZApjWYSpQpodCIrbxFS2VDb2k1m5z8gp0w6JHxudaoteFB1gcd6sL5/EwwawaN3yr0G5OAjBKrNjuM7REwvwC4jUdDBGbbaWj6Np9ZxByuiqPklvICVz86sy9/wchOTnBPbRqlUPejXBaCaIxeCvDUzPa2D4yLe+67/EjpN2EI6MNcyu010L8uYvsGHNyCV3zCyrWxVx9QPz8P7vks/BzALcXWgdJYfpE06QpLxAW3Guym75R+YTVOpYPH03/4WGFl/kXpUzfzeOkjuZiJfBGeGZelw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(1800799003)(186006)(41300700001)(6916009)(4326008)(2906002)(66556008)(8676002)(8936002)(31686004)(82960400001)(5660300002)(66476007)(478600001)(54906003)(316002)(66946007)(7416002)(86362001)(31696002)(6666004)(6486002)(6512007)(38100700002)(26005)(6506007)(36756003)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzErWWZidzJ0Q1ZHcUgrTUVIL2hSK2pDNDBqOGxKdGx5WUgwVTJ2QWhLR3d5?=
 =?utf-8?B?SFJRQjhEVjBrRHhyWUkzbGdnUjJrcEEzdTlmREsxcndZYXN5UEFpa3QxUVg5?=
 =?utf-8?B?UkREdC9DbmR6Y3VMcmtGUERRaWxoYjVBTWtYVCtCcFRrejh0NlRRNDREaWRU?=
 =?utf-8?B?cTZZV3RzcDlGQngzSGVxMFFYM2NyemFMa1ZCdUlMZ2xYcTJXY2o3Z2dPK0VB?=
 =?utf-8?B?NkJWU2NEY1hPYWIzdEk4OHQ3ZEQ2cVFVWkhEWWVnc3FDYklwbmRXWnlRZEU3?=
 =?utf-8?B?akI1akl3cTF5Rm9hdWwyNDY2bHVLQjJhM09Cd3Zzd2g5WTFENWhnRXJaT0po?=
 =?utf-8?B?bnFwcURhbGVLWWVDWklFdmhISHZkTXRtNFN5dU05WUsxRnlEYnloR3dkRlht?=
 =?utf-8?B?WjdLRmtROFhvTDhpRzdxZkJkWFl0bXFja1VWL1I2VnZNR1ZNTEgyNDVYTFBV?=
 =?utf-8?B?SWtDaG10Wk9XRU5CUmZsTHY5THpzN2NXZy81aGNlU3M1Skp0Q2lsMVQxZjEy?=
 =?utf-8?B?NkptU1ROZ2JsN0FMcjZ6dmpMdlBYTVlEOUpEdWgrM2YxRDkwMHhobjVRelo0?=
 =?utf-8?B?dWNKZldPcGljVFN1WGl4TzRuVWUxa0QvWnNxVXlKWS9KbzR6WVU3TWtJNnhE?=
 =?utf-8?B?eEMza2FWRTF4Q0tyekdwalJ4WXFUc0VUeXFxSURkekozbSsxcGtaTEtORTFn?=
 =?utf-8?B?K1VpWGhjaEZFN2daOVBBbXFyTS9DZkFqKzAwM2NTWWNNNURMS1phZHdrR0Vt?=
 =?utf-8?B?aVRtZFk0VURBMTg2L2FVa0pKMW11Tndnc0ZyUmUzdkhjbHlhdVlxUE03ME5M?=
 =?utf-8?B?N1FEdjJCaDhNNUhGRmxEWkFMaGJzSXkzeHYza1JmMDNtVkdzRzdTallyYkZT?=
 =?utf-8?B?dkdHQWdRNzlXRkJrWWJmS0lDSUpKelM3bVNwUTVLWE1rbitiSFdlNGIxcGUx?=
 =?utf-8?B?aCtFZXp1OVFueWdXMm5xMysvYSt2Ulh1VThzQkM4V0xlZEZlcU1SMXZKOW1u?=
 =?utf-8?B?cXExQm9GMTNlb0JCcEUraXdRMnh2Y2Z6TmhBYkFXeWp5WDc0eVAwQkJLR3p4?=
 =?utf-8?B?RWtDVFFvZXUxZU9mcUtIZGpZcGFuajZRMlB4K3dOZXdnZGQrWlNod3dHdTI5?=
 =?utf-8?B?TXAyQmJ0dEZkb0NLd0xGc2ZlWDYrTnZmQjY0V0FhY1drbVRPZk9EdWgyeVVG?=
 =?utf-8?B?anpUWE8zYlNvVWZuTzBld1E4Z0QxaDVBYXp3RXRxWXJtYUw1RFQwTlFDS1Bh?=
 =?utf-8?B?NEZKM3R1ekN4ZGpHUWFmTGZTL0x6amVXcko3V01BL0tGTHJCakN2UU5lZmFB?=
 =?utf-8?B?MEcwQzZaK1FMNVpMT2xGNEJvUUZYREU1ZElrNDJnb3FGWmtzQ0lnU09VMjJH?=
 =?utf-8?B?UVBJZHJKN2dSdnRjSkNXSGlJU3FtUEhPalYrUjB6S1pJZGNvQXlYUU5ZU214?=
 =?utf-8?B?NHVFaURqZTZ1dXVDVUhtRi8ybGgzYklDcDUzek92dDVZSXlmeGcrbmY5ZmQr?=
 =?utf-8?B?eGRTbjliTGh6VXltL3ZRKzJ5bU9uZ29mbTd0cWVlZDRDSWVOSFpqTmc0NDBN?=
 =?utf-8?B?UGdnSSs1OGRuc1lYcE9kaCt4VWEvcHF4ZTlSRkM4UWdBRUhSSi9XU0xRWjhw?=
 =?utf-8?B?anptNEhMRnFNSnppdW9OUkNmR0cxalhheGZ5N1JvWS9NK1p5TElzdmx4ZlZa?=
 =?utf-8?B?T01WSysyWUJGeXVZek9iSWdOejJlODRLaFNPb09pVmhUNTBGbFo3NC9YWEt5?=
 =?utf-8?B?SXdpdkV2aXVDMkdjV0xiZGt4NlZtbElPbncyMkFFNHA2em5xOWR3bEhnYTl4?=
 =?utf-8?B?elI4U3cweUlIYTV5TDFoOTI3K1Z0bHBwcmtQc0dTQ00wNjNFNVhwcUp5dkJI?=
 =?utf-8?B?M214aGFVL2V4dVdDMVc4NDdTcThTZWRxeGpxbWtIb0ZjeCt2emlkOGNvZmZZ?=
 =?utf-8?B?NVZJTUdBMVRnZGtFd2pROXNsb29IOGdDeVRPR21CRTlnOFJRMUFoVlQzdnls?=
 =?utf-8?B?bExhLzZtd0hVTU83STVtQ2dBRFR3RTB4TmUxTUZtY0w1b1hJMzdqaFZ3REZ4?=
 =?utf-8?B?VFI3VWx5R1ljU2Qzc3NtaklBVktoL3Q1YmpyQnlabUdlS0JsMHhOdU4vRHRr?=
 =?utf-8?B?R1JkOTJCV3BpdWtlVk5nYUlKVi9HbDV1UG8vNUp1OHk1UmFmSEg3WVZwVTF1?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e29683-bbda-4780-d39f-08db94f77519
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:31:14.9424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fo4GZ7o/WsP7iQpfgoynUKjb3uf5FqJSWJqCC5mQuNYvwZceyvtWCucMUpkgF3yzmvZNVVU8U9nCoodxRD6YJSF14khtnMs8x4hw9qQQlzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7861
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 3 Aug 2023 18:21:21 -0700

> On Thu,  3 Aug 2023 20:20:32 +0200 Alexander Lobakin wrote:
>> That initially was a spin-off of the IAVF PP series[0], but has grown
>> (and shrunk) since then a bunch. In fact, it consists of three
>> semi-independent blocks:
>>
>> * #1-2: Compile-time optimization. Split page_pool.h into 2 headers to
>>   not overbloat the consumers not needing complex inline helpers and
>>   then stop including it in skbuff.h at all. The first patch is also
>>   prereq for the whole series.
>> * #3: Improve cacheline locality for users of the Page Pool frag API.
>> * #4-6: Use direct cache recycling more aggressively, when it is safe
>>   obviously. In addition, make sure nobody wants to use Page Pool API
>>   with disabled interrupts.
>>
>> Patches #1 and #5 are authored by Yunsheng and Jakub respectively, with
>> small modifications from my side as per ML discussions.
>> For the perf numbers for #3-6, please see individual commit messages.
> 
> Our scheming didn't help much, the series also conflicts
> with the net/xdp.h includes which came in via bpf-next :(

Haha that happens. I rechecked everything before sending, but well, we
need a spinlock or what :D
I'll send v4 in a couple hours, so that ~22 hrs will pass since v3,
sounds okay?

Thanks,
Olek
