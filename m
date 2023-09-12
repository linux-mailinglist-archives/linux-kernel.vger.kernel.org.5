Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047BD79D7D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbjILRoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjILRoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:44:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31D5C1;
        Tue, 12 Sep 2023 10:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694540645; x=1726076645;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0ziaTm+0XCWBQ8Dhwf8/YjCz7fLWyPbwvEUPAGPP2PU=;
  b=XspUdAlSynI8QcOw7929nax1eUcfM616hxBS0kXVpNfhJeWhaPUyNTOs
   5x2epZJRAgYCJwT55quSAAJN8MFe3sLvNk6Ixub2As1ILnwiT5OYbfPkK
   FgQNrrvnAsp2IVACqjBAWQ3TvmUGJo+998JZkFPnl6Hmd7Jspk7g3+9jG
   L8ylvBF/9ZhBN+bry2nJXhZKu26lOVZcnx2NxvC9Yp56xwPZAoqS24KiX
   SEYRG2T4NRCpBDDCrX+wyAY6vobYCoZtKh5Kkkiu2XwT+qQl0WlOXsUgD
   WBcoK/HjITScYWwiq0BqZm63ckSj2rHtlrCrYzBIZfEw+LQOXS9YVGTuh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464824166"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="464824166"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 10:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="743798252"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="743798252"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 10:44:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 10:44:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 10:44:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 10:44:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAwHyMBkUb/m2twGMg0lfTr2WspapjlI5KrMf+vsYEowo/YjjB8oiHKHyZNLlopK8CM6NRLrul4UvolCw/VGdOvhodPouv4z2cuuBJor/l+XL3m6vIAaXEiSa+PjIBMmPCBH5C7YYjUR1X/qRKS21iCWPTjD/gD8PKWtRwuwjdg0azauPVDpbzax0sLv45LNarKN7+LWqmBdY4ZpeIdW1ZpsDGW4Dg1fHAGHO9dUpck7IyfumFMtXVQlOEeAu50D4rwpndHPw19RJBjMPuxcyxIzcAYocVOMmcitE93wVBR4AlKhwZS+XoExYjA/g3cnXwMA3PbfhiGkFFDP8XLxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6JM4lr1EpXag5bPR2KdXCzeb6WIIya67v3pELSjLGs=;
 b=nM5t4p8TxRNNYzPhL5HaCq5clAXCkaR/PrZh2jlR7mA7EjYOx7YLO57asvm13LxFXXw5ZO/GjumhMrM+OXHEB3ubncgI49+yztQ9nbuJzAalvQCSx2UrH5M0WAPCKvpF0opHsA+VuMhPnzpkI1n7TExfWLWgFDGT6z2KZOvjqej/cLStqvqNnp/NW58Uws4i7eyoxBaqcITSyAJ4Z7AAcRIr+ZstueWf2wnv36DFaKM9y2sKLaDcr6R9XvbhGQ4SXoHZA+k8p4NVJqGQN00LVKkWvS/3rvBanGD1/lKOVJh55wWLpCyopuMP4XZw+uG9lT95s/88Ic0O034SHOPoIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SJ2PR11MB8401.namprd11.prod.outlook.com (2603:10b6:a03:539::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Tue, 12 Sep
 2023 17:44:03 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 17:44:02 +0000
Message-ID: <8bc6c1cd-50bb-44ef-5979-3bb50a70afcb@intel.com>
Date:   Tue, 12 Sep 2023 19:43:27 +0200
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
 <f3e84a37-3218-0d52-e7ed-2d215fed58e3@intel.com>
 <CANn89i+AwmpjM-bNuYRS26v-GRrVoucewxgmkvv25PNM4VWPGA@mail.gmail.com>
 <39c906f6-910d-01c7-404a-8fe6a161ef2e@intel.com>
 <CANn89i+QSPoXphaLzfKCqCHxjsD20ifr8YPJM_fZ_H5kFZ7dwQ@mail.gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CANn89i+QSPoXphaLzfKCqCHxjsD20ifr8YPJM_fZ_H5kFZ7dwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::19) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SJ2PR11MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c41da0-7026-4186-fe6e-08dbb3b7da56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7yCw+bOXOSeEf7W7KC8QWDeG0tsOGpw5YPCP5IeZI22iX1JvAXu5pwhiPiDIoYbCLUuOrBICbY09OFsioWr3v80jgncTsrynpp0sFP/D/SW//q5cV/XCjlTSMFc4VHAl5m2XmhopjP2D2G20qGd6RXcuzgbBZP6JxZqtJS0Nd7X+qbKvu3zEbBZZoLg9KfASh95dEUATub940R+OW8ShUkaA1V3lqbsFMm/ZJI5RV+zqOBnsaP3eETO+DSEcsVhKoNVo8N+wJmQx23BAvfoNPsnvBZLnJsFPev+7Po/vRV8xFFMNXub9mYALi0ZhIR4ycvMjTgh6+4k4hCx1opyxUizt6fzAXNIgDazL53DTIZ9+N9+ddaE+JTbfL8Qd28E+pdiofgJm59EQJHq5bB11Az/x4NHginBKz9TErvTXu67DQpE/8KwyOfEn1LwK3qSesvf0N5hXS9holWDwKCwS7LIBCQFID1axiQQzabC25DZ/yN6lffAPrqXFJteCeuNX/sKWjMt94vMBhPvHf+++FTx/z/M4XNtr6hcvizMf3C9MdslAQ8HKG/0JZ3MK6KvN39IJcqtXZOgSk/HRd1Kvd2nILJvkOwf6NDbS49DqXlwUH8AYzNFzg8DRTSR6i+uQX7ReRCKnHmRV31AyDZXwWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199024)(186009)(1800799009)(8676002)(31686004)(2906002)(4326008)(8936002)(41300700001)(5660300002)(66476007)(66556008)(66946007)(6916009)(316002)(478600001)(6506007)(6486002)(6512007)(6666004)(53546011)(26005)(36756003)(2616005)(38100700002)(31696002)(86362001)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0h3MTlqRVgrUnFTZ1lSQTJldFhabXVnU0Y0MjRGV2NFeXYxZkI5ZktjTlZl?=
 =?utf-8?B?eUh0eGpBazZZTEptNkc2WW1CQnFhdEwraG5NL0U4ZGpneEpYd3pzazljdXVH?=
 =?utf-8?B?WjljN3BuSkNTSEdvUXhPSldheG1PckpTK3JRYnZvMTBNR0dmNTZ5em1EYlkx?=
 =?utf-8?B?ZnVNdmFBSEZRam92R2tqT0JOc3h1ZmZuNlVEaktML1Q3SXVPbmtZeHQvZ0F2?=
 =?utf-8?B?UzczNVpSQ3ZVSXd4cEU5TUFyMUYwd3JmN2FQR1pOU0xrVHRoclg3eGdhd1ZS?=
 =?utf-8?B?V2UrWTdpbCtGTUE5WmIySTNTdGM2dEcyU3dNTWtaZ09BYVJucWcxY3Z2MkZN?=
 =?utf-8?B?dlo4VEl4YjhIN0hwOHpvRUs3Znl1Y0drOGx5RTZJL3FuT3MyN3hkcGZrWW1N?=
 =?utf-8?B?QWkyVlNkZ1BYcnBXaXR0OWs0UjYvSmNzQ1F1enRobCt5cThuR0NlWXNQVENT?=
 =?utf-8?B?TDJFYU1HK1pMRTIrbjRDcGNIM3A1OWtoQmlyR0lQWmJNNXh6Q2xjTEJ0b1c5?=
 =?utf-8?B?S2NiYVJFV2FWNUE0ZnpzK2QvV2Z6OHg4RSttOTZPam9VNXkyaUNiMHZpVW1V?=
 =?utf-8?B?V2owazZnSDNPQkNkdC93SllKb3AvUlJzL3dvak5YMytJMkd5aEw2aWVlbFJi?=
 =?utf-8?B?QkdNc1QwVDdOL2hIZHczOGtiYXdrQTJpQWVIY1planpnbkNkZDNyYkw4amRR?=
 =?utf-8?B?TmpKSDhyZlpDYkorRUgzQUErOU1sdTQ2RU1hSjdySE53ejJzemExbkNvVjFN?=
 =?utf-8?B?d0Z1aHcxZnNDRHM2S1kvUDdJQ3lvb29sclkvSEpSazdQRTVRT3Flbk1FRERu?=
 =?utf-8?B?RVhTUFl6eHV1T3BPTjdrUXZXbDhMNXFqV2gyQncxRXhZcVRLVVJtQnA4NkJj?=
 =?utf-8?B?b1hkNXp5VEkwZnl6U21RLzk2NXl6SWtkWjN0U282c2ZSUlpMM0Vsc2VqeWVZ?=
 =?utf-8?B?MWRzNHBPdlZQK1Z5WmYvZ0E1YXoxdmQyQW8vTzNZM0p2Y3orZU9XbWZ5bGxs?=
 =?utf-8?B?WlVBSENHUmNSRWM5VG5GQVBzcWpqRVdrSTVCY1VFSXdQVkRJNGNvVnNsZ0py?=
 =?utf-8?B?aDAwa0Q0ZjFlMFdodFhkZmE3THpOenI2Yjc0azQ3YUtoZXJjWExHbVlaY2da?=
 =?utf-8?B?emUxVDk4NkhmWDE1Y2V0bjZUdWFCdXU2M0hnUkRNM1duaGExL1kzVXZNU3ZZ?=
 =?utf-8?B?alJCOUpURGFNekVyV2l5M2FXYU9RTXpXSzVxSEJ2ajhCeDQ0ekVMTTR0WVdi?=
 =?utf-8?B?aGZhbmpIdEFMdnFRYW1lMUVHSkdpQlIrUi9kYkl4YnBwMkdnRHBDTUtWcWp5?=
 =?utf-8?B?emlLa0NxU0RaeS8zS0xKRFYzbm5pcEQ4Wk1FVlFCbkQzcWtMcmttdFZTMGh4?=
 =?utf-8?B?aUczVFVRS1VsMS9ZTXlQYUVUYWxTYUtxL3R0NWhBR2tvOGNyc3pmY3A2RXZQ?=
 =?utf-8?B?U2xhMGNKeVNwQ2QrR2tUZlVCUmtsdDRVV1o3VmFmWW1LNFdKQjVpMmw0TlRR?=
 =?utf-8?B?eTlVMFJTaEQwMUkwS0xBMVpGV01IUkRTSHllV1pkWmkzTzRBL2pWaFZmcWYr?=
 =?utf-8?B?QitrNld3L1l1dzlMVFZrVm1Tbk0wakNCL0ZKZVBtYTIrbE1Va1JjZTRlRkhF?=
 =?utf-8?B?U3RmVGZha05YYUx5WVM0a1ZsMUNoMVhtZ0VuNmVOK2hDMWdIQllkRHpBVHpl?=
 =?utf-8?B?YVJhSjExSFBhaitnUU5ib1VnZ09Vd2tncjRJZ1d2UHFka040SnBlc0QwQmN0?=
 =?utf-8?B?Wjh4aTN6eldRTlQ0Qm55SXk4Rmp5bFZvT2VZYlZNQ0pxbmYrSzMxUFlsVTNp?=
 =?utf-8?B?Wmd0eEh4TkdlZnh2cHFvNHhWZ0d2SFBGVklkSDRFYlNscXh0dm0vNVp3RVNo?=
 =?utf-8?B?QTZpSzVucHFyNXFWNUJ5L2NEYkdZdGtSU3BuRVN6RERiZzR5V0tXaURaa0F4?=
 =?utf-8?B?K0Q5cU1OdXN3QndMaGJ6TU0vRVNGSTY3ZzgwSXR0SHhGdzMyK2RBc0c5QVZh?=
 =?utf-8?B?R21DU25TQ3pEMFVQUkk0T0hmbDFaKzhvZWdmRmlidXdPcndzUldHdnVaeTVl?=
 =?utf-8?B?OTNSMkFROXVFK0M5VTlNMjFMZ0NpR3VLWXhTRFVlVndlTDN3Y1ZwUm5IcWxv?=
 =?utf-8?B?Q0d0dStyTXAwdW04WnB0TTBVSFh6UXdVTUU4RlJCNFZzQTRIS0IvckdZdE1I?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c41da0-7026-4186-fe6e-08dbb3b7da56
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 17:44:02.8890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9M9EG7NaERityOUXqRKxEPn5XAEFTy5w+qeh+RuHZx1bp89JJRC6i510OiZlwBWoSsZ+twzI5WLNF0eGRPzXaajFIMw2N2XvVnEcNArNzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8401
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 12 Sep 2023 19:28:50 +0200

> On Tue, Sep 12, 2023 at 7:16 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Eric Dumazet <edumazet@google.com>
>> Date: Tue, 12 Sep 2023 18:04:44 +0200
>>
>>> On Tue, Sep 12, 2023 at 5:58 PM Alexander Lobakin
>>> <aleksander.lobakin@intel.com> wrote:
>>>>
>>>> From: Eric Dumazet <edumazet@google.com>
>>>> Date: Tue, 12 Sep 2023 06:23:24 +0200
>>>>
>>>>> On Mon, Sep 11, 2023 at 10:20 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>>>>>>
>>>>>> Although there is a kfree_skb_reason() helper function that can be used
>>>>>> to find the reason for dropped packets, but most callers didn't increase
>>>>>> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
>>>>
>>>> [...]
>>>>
>>>>>>  EXPORT_SYMBOL(netdev_stats_to_stats64);
>>>>>>
>>>>>> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
>>>>>> +static struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
>>>>>>  {
>>>>>>         struct net_device_core_stats __percpu *p;
>>>>>>
>>>>>> @@ -10488,7 +10488,33 @@ struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device
>>>>>>         /* This READ_ONCE() pairs with the cmpxchg() above */
>>>>>>         return READ_ONCE(dev->core_stats);
>>>>>>  }
>>>>>> -EXPORT_SYMBOL(netdev_core_stats_alloc);
>>>>>> +
>>>>>> +static inline struct net_device_core_stats __percpu *dev_core_stats(struct net_device *dev)
>>>>>
>>>>> Please remove this inline attritbute. Consider using __cold instead.
>>>>
>>>> __cold? O_o I thought the author's inlining it as it's a couple
>>>> locs/intstructions, while the compilers would most likely keep it
>>>> non-inlined as it's referenced 4 times. __cold will for sure keep it
>>>> standalone and place it in .text.cold, i.e. far away from the call sites.
>>>> I realize dev_core_stats_*() aren't called frequently, but why making
>>>> only one small helper cold rather than all of them then?
>>>>
>>>
>>> This helper is used at least one time per netdevice lifetime.
>>> This is definitely cold.
>>
>> But then each dev_stats_*_inc() (not cold) has to call it from a
>> completely different piece of .text far from their. I either don't
>> understand the idea or dunno. Why not make them cold as well then?
>>
> 
> The __cold attribute is only applied to the helper _allocating_ the
> memory, once.

Then it should be applied to netdev_core_stats_alloc(), not
dev_core_stats(). The latter only dereferences the already existing
pointer or calls the former, which actually does the allocation.
That's why I don't get why make one if/else non-inline or even cold.

> 
> Not on the functions actually incrementing the stats.
> 
> There are situations where they can be called thousands/millions of
> times per second (incast flood).
> If this situation happens, the _allocation_ still happens once.

Correct, but dev_core_stats() will be called the same millions of times
per second, see above. It's called unconditionally each increment.

So seems like I got the idea of .cold correctly, but you were referring
to the wrong function.

> 
> 
> 
>>> Forcing an inline makes no sense, this would duplicate the code four times,
>>> for absolutely no gain.
>>
>> I'd love to see bloat-o-meter numbers, I suspect we're talking about
>> 20-30 bytes.
>>
>>>
>>>>>
>>>>>> +{
>>>>>> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
>>>>>> +       struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
>>>>>> +
>>>>>> +       if (likely(p))
>>>>>> +               return p;
>>>>>> +
>>>>>> +       return netdev_core_stats_alloc(dev);
>>>>>> +}
>>>>
>>>> [...]
>>>>
>>>> Thanks,
>>>> Olek
>>
>> Thanks,
>> Olek

Thanks,
Olek
