Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A301479D573
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbjILP6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjILP6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:58:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F2710DE;
        Tue, 12 Sep 2023 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694534286; x=1726070286;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iLA85+rwKq22rlySKo7y7oyi6rhYEUotHkbaIRmq2f0=;
  b=jNNxl+8tAJYtFSJe35E9t2JJlwyp8kl6kIf1cbKa4jmVPO7U+RcNzJyf
   n5lwDuYmWdiRWTxoUBBPrEP8yDXZZAkqHVD79QZPDjeDV7RG4Ciupz2H7
   TEuSG2AB6Onom+jTfvGhzFHQelwAwNOvAOp9Jz7KS5sS3ftqUVzDvirN6
   sUIIz/EQliFqx0yGmx7qpg8w8ayx/Pcqlpduu1l3TuMgc1vs0o4Zlt0o/
   txTKN6jN68cQZ5Jt8rKa0x43wrbFRihW8IGkRe9NRgppFVTDOYsNjSqni
   PfsugPDe7BuGL8pKEXM6mnvwJoZCRf1T7AJQFkqiYv23DelmR+VGC6NUI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="378324863"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378324863"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:58:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="720475292"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="720475292"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 08:58:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 08:58:04 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 08:58:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 08:58:04 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 08:58:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3oepY5Li9LpY7oaDaMEIV9KvHpVJcu/zSBlK3n2Hi676UiY+2gCOjZNKv2aUGRePlKEEMZp8Ta62O+vO4Yzo2CrvFloESI09UaIC0QgDR13ObGPVKzsJlQJhlB45zj1GiUMLBH2aNtbD0rk+pyjEECTlh4grfFm37C8YDGYy3o1c6mqf6PWEZmDFtb0EVQ+qfKGwiHP2d8XcuEFXCTBq9tAvKaimWnAlSDyC8WfwX1qvlv65wxdbKtQa8NtLvwpwxQh8VGTv7l8bzjJCWChs8wO/3nbnTCcvepr0/JaHCtT22gQ1fb+zqRyvDxIjYb0p5A/K3JVF4BJkSxHNWV9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+JIkQcbYnFPBpSI3oVNulRwem1aeNkDsFo3KwGlo8Q=;
 b=YPamN9JWkjO6fkx2E287WmiTwVNSigFAJjRhpMi82HaMf6Jbs2INdh+ROa1zlbnLtG3+iwlkEgJCOIQUHLj0lj8bQRwdQCOCk3/vMSo9IT6dKqhmV4WmrEVHWsFFY00YCM8PYzW9F0VIKbQkjk5ww5axfLZURX+dnZyVmBk28uoWjsAmBiNWq6dGqicCVlN8en1nB/HvnSEP+uWlPH1Z5dDy4UE/upoyVDqY0ZuOSUNOoYtsEf7Pt9qLSU/1qatbxj2mFAfnfr3eCA2W9fquZByMdk10nI2mtufw7xRv5QkFSfnrTRsSnxgfCDo44xGrR2oYki1RQCqHMkGBV1OnZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by MW4PR11MB6618.namprd11.prod.outlook.com (2603:10b6:303:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Tue, 12 Sep
 2023 15:58:02 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 15:58:01 +0000
Message-ID: <f3e84a37-3218-0d52-e7ed-2d215fed58e3@intel.com>
Date:   Tue, 12 Sep 2023 17:57:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net/core: Export dev_core_stats_rx_dropped_inc sets
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
CC:     Yajun Deng <yajun.deng@linux.dev>, <davem@davemloft.net>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230911082016.3694700-1-yajun.deng@linux.dev>
 <CANn89i+W1iAQmOhunLbqpvHu8EUO6uawv6Uvx7qimyBa_PBNCg@mail.gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CANn89i+W1iAQmOhunLbqpvHu8EUO6uawv6Uvx7qimyBa_PBNCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::15) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|MW4PR11MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f078341-ff88-4041-7f24-08dbb3a90abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DI3cNcH+yjBlYOmC3LuoNyjtmPHKqnpl16XqIsQFlfspUg3HYrbVBdQe03KrzavGknUyAsmq9kUCiGnscuEHe7gaHvnZYFQfWKjua7IBd8S7g9zqAR7H9wiPLGOIL8Oe5MkriA5U2WWcO8NtIE1l4Ld+CVPM/qmdzuFcTpxuE2eUUd9wIEOZ8uZ+N3fukF9Qf49bPckFSKI3p42M5n6PnF3bLwZYaP2nQ9oXTPh1qBBR93AZwix4DobD2vx2kuY0zrL5ofRdhymUvh1DrqpHdVPRgg3jodsXZTO16vTfsGa05CZOCdNXSH/LFhdeyJzp4idHLHHATOaZItf33VWECmFv7uBSgansi5usxTAcHfFb/R1IY4A6nL9voVps9bxQgj0pTD6U9UDKLWvai7lpfQ+53OpCn+wPv/tRRywuD/MdP/LzivU9IPFCJK4/RCvYtsYWoVJMebXHiVHf/D7hi/GFm/GaXXAQdrffd26GRk2sDb8c8tFk0XXJ5TI3jJv3ghymzLZf3FibND9me0cWvlorFqp5ahIPfp6/xEWJSAnksW95hfDO5ioydiVtN20BqgjLBYt+U4ZoGrlG1NgQBTpG10jbEPX457bt/H+XeIKOmokWz2PG1sjo9BaN7JF96Fl4VckR8g+Q+X7SdRJHMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(1800799009)(186009)(451199024)(5660300002)(41300700001)(8936002)(8676002)(316002)(6916009)(4326008)(26005)(2616005)(36756003)(86362001)(31696002)(82960400001)(38100700002)(31686004)(2906002)(6512007)(6666004)(6506007)(53546011)(6486002)(66476007)(66556008)(66946007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnJkSVdTZGRoZnpvRFNPRFJLRFgrRnlVK3pwYlNteWxacFNHcWs3dVV3Rm9C?=
 =?utf-8?B?ZWNON1liT2ZFKzVYOS96YUNtTXBKZUxMb2kwaGwyeGhKZEU5ZTRBYUtlRks5?=
 =?utf-8?B?bW0rRUgvS1VQMnFDMlNqb2RnTmZxQ3dsckpFRm9EQVpkNy9aQVFQN3lKUEo1?=
 =?utf-8?B?MjM2ZXR6WkVOY1M2bHRMQi9EYngraVg4K1Vta1YzUTFuWk95ZFdPZVJ1RTFS?=
 =?utf-8?B?WUtsSVBlVldsSWV0WUdtYmxUcFlmbUowUVJCclhySlNIN3JVb3RnNHh3ajI5?=
 =?utf-8?B?dWw2d0Zrc2dMK21zN1JmMVlRemU5SkF6dDliT2hOTlJkdFN4b3h1ZjBCZ3ZB?=
 =?utf-8?B?Q2ZYdDhoNDRybmNwZzRyOTVnakEvLzNpQlFTblFvblRUdlhoV21pK0hrSnhG?=
 =?utf-8?B?dVlCYzhEWHErUkN4VTJicC9iL20yZlpQWDY1VnlEdnBYNHFYR0Rxd0cxQlNY?=
 =?utf-8?B?cHdXVXoxUTRYeFBETFcycWYraXlNMy9Ua1phMlFKRnM2MlhvNUtPME9KbUk0?=
 =?utf-8?B?dXQydjRVdnNSQWxZREVobDFnV1VFUEtNZ0JBWVZ1NVJoWWFkNUZwaVAzRHRR?=
 =?utf-8?B?bFJhcjBPMmp5YkpFUG5JSzZUQ0RMOVBRNGRCTWZwOU5NbzR2TEFFUnpIYlpF?=
 =?utf-8?B?bWhlT0JMVzFscFQwbUlaS0NoNForaFZsb2krYlFsaFhQeGoreHpXa0pCMFdZ?=
 =?utf-8?B?NHVPeGs1NHJ5ZlA1MTVmMlNTTVFDcXArNGs5ZHVpYk4veDRxZWJWNkNnTW55?=
 =?utf-8?B?dWpRbjJIeHVqK1BiRzJkcndXdlJLNklRT2E4TXlxVXlzekkvdkxLQmxQUVRN?=
 =?utf-8?B?UnRXaFdVZEFmWW5MZVBDMlRLeURQd1hEQURBSUZqQU53V01EMG1HbndUMFk2?=
 =?utf-8?B?UjhUZUlmdGdKU0dSTGxWTzJ2a2JIR0pMTzlHcktRWlM5YXZmQStUck1naUx1?=
 =?utf-8?B?My9nYmk4eXFoVXpVVDVKMUZleHBaTWl4QXFzVkM3cENMUVBQWTl4NW96b203?=
 =?utf-8?B?R2twSHo5TUc3bk1kVlpSS1A0Q1V5emFZZGdDVWt6ZU5kKzl3TWowSFJVYjRC?=
 =?utf-8?B?TGpFUTArcUtvWlNsd1p3MUMrU291MzM2Rzc5ME5odktER1QrNWtDUGE0Um5s?=
 =?utf-8?B?Q00zL3didXpLOW9OcUNkRm94SWJZRi92UHJpSmwvekQrbXJPRVN4aC9kK0tX?=
 =?utf-8?B?Nm1pTGgyN2JaOFJta3ZNYUlxYVVsNEl6YkhzeGJNODhZdlFBWEdhQWp4Q3Fi?=
 =?utf-8?B?SnY0d0ZEWVlLTE1Zc0dVZXk4Z2hZVDdSTEVrZTRTMFNOOHAzWFNxY1JoNlNW?=
 =?utf-8?B?YUZFMzZnUFFZb3FyMGQzNVlsSm8zNVJ3MG52S2lCeXhjd21zOVVRS2VEd21m?=
 =?utf-8?B?MndwcC9RRnJaTHowRERWY2FXY2VWcWY4ZjBXK2hGcW0xclNOUEo5cER6aGVl?=
 =?utf-8?B?K21yTklDSHRIcEVjd2drN0lBbHM0dHdKWGZmeDNOcTFxc0VOUjJBTE53Yngy?=
 =?utf-8?B?bGw3MHdkWXcwdmRjaVFwK29oRTAzdkJ4QWJ1WnV4ZERqZG1yemMwdFpPNlpp?=
 =?utf-8?B?b0w2VGQzMXFRMlN6MWhlZ3ljS2F0Mi9ldDhGRmF2VG9IVzBxZUVvWkhPRi9n?=
 =?utf-8?B?MWorTnRzY1plN0Z3ZlNiMkJkdTFVeE45ZVJhVDc0WmY4Nk1samhzL01qcVIw?=
 =?utf-8?B?R2pScjlTMytVQmd4QlV3UFZNWUxPa0J6dU9xWnpjRklYWlJFQ1N3eEI0YnFI?=
 =?utf-8?B?dDgrOGhSZ0poOStUT3BlUnFIRzR4Q0QxQVEzTHU0b2ltQjFDYnEzTGpBUDlj?=
 =?utf-8?B?Q0wrVU5odG9sczF4ZHhXRlNXYUtDTE9jekNYUE94VGhtOGh3Wm5wVmFDdFk1?=
 =?utf-8?B?QzhkMkpld1NOYldlU0h1NFZCbmgwQ3RMU0s1M1pWTWh6cGNsRWhyUFErL0FH?=
 =?utf-8?B?V1QyWk5TQnpCQUtERkd5VHFkOER4NzJEY0tGd0ltWTE1SUFuV1BOWmkza1E0?=
 =?utf-8?B?MXl6N1pLemhvNHNNSDh1VmR3UFV0SmtqQW1OZFo4dlVVZE95ZjdNVjBaTDdn?=
 =?utf-8?B?S0RWUndhcXZKek1EUmlRcHE5L3ZQd3ZwekNnOTVZdFYzT0FjdjhtcWJZY0RO?=
 =?utf-8?B?QUlzTmsyb2YrNUI5Nm5NSThuT290cWdyK3V4dnpHK2tXdHBlQTQ2TXpqYmgz?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f078341-ff88-4041-7f24-08dbb3a90abf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 15:58:01.6345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAP2UrvRTgCBcvJasARaDi+s9JnStNwpbkc9E8PJBbw1jy5lMdK9PnoUnhLFAGh/9yq+Q5NXvvrur8YdxRNX32mLUydcCZ6S7HA+gIgEPKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6618
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 12 Sep 2023 06:23:24 +0200

> On Mon, Sep 11, 2023 at 10:20 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>>
>> Although there is a kfree_skb_reason() helper function that can be used
>> to find the reason for dropped packets, but most callers didn't increase
>> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.

[...]

>>  EXPORT_SYMBOL(netdev_stats_to_stats64);
>>
>> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
>> +static struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
>>  {
>>         struct net_device_core_stats __percpu *p;
>>
>> @@ -10488,7 +10488,33 @@ struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device
>>         /* This READ_ONCE() pairs with the cmpxchg() above */
>>         return READ_ONCE(dev->core_stats);
>>  }
>> -EXPORT_SYMBOL(netdev_core_stats_alloc);
>> +
>> +static inline struct net_device_core_stats __percpu *dev_core_stats(struct net_device *dev)
> 
> Please remove this inline attritbute. Consider using __cold instead.

__cold? O_o I thought the author's inlining it as it's a couple
locs/intstructions, while the compilers would most likely keep it
non-inlined as it's referenced 4 times. __cold will for sure keep it
standalone and place it in .text.cold, i.e. far away from the call sites.
I realize dev_core_stats_*() aren't called frequently, but why making
only one small helper cold rather than all of them then?

> 
>> +{
>> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
>> +       struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
>> +
>> +       if (likely(p))
>> +               return p;
>> +
>> +       return netdev_core_stats_alloc(dev);
>> +}

[...]

Thanks,
Olek
