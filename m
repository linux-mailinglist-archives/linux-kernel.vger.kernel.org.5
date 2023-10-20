Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE6E7D16CD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjJTUN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 16:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjJTUN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:13:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3D01A4;
        Fri, 20 Oct 2023 13:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697832801; x=1729368801;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hifpEEqumjssTS/hG5GH99tgwmwzZQJdmrBBjrz4yII=;
  b=T6sTL1CbLC0DKhc7OdAUqzhsuH4LpojgDFz4t4cva180L2tB37ZCujAX
   10HGc5/VvEVciyLG2cVRm7ZJ6uXr6Jjp9UnopX/elVBDmtElWYa48GA6B
   WtC913jrxxHsgActRNVv6seDBEDTdBFfK0EUIJs7Wun1iswWMyu5Ip5HJ
   r9QoVo7UfnqUO+ZmZf53VZD2HGhuzExv3Ml4eheQADpWxLD4gjEzH8oKz
   IzWA52dUTb2tooPg9IvxeKciObwMVllX6Kov5tE9O/xG8efN7HIMGhJZL
   zX457naqy8JSB7hYhq62LLo8MhJbS0exN5PX83ihRxATLeskTKJHdLTr6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="450796434"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="450796434"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 13:13:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="751037684"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="751037684"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 13:13:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 13:13:17 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 13:13:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 13:13:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 13:13:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoiqvCWzqq3C5Z7U1lvjYLabcZkiTJMAGkcnXPpPf4YGpBHr45qK8KsB77X4UiGsIYFvSLxz3pN8ETekTqVHaY9fYa384cuHEGK1m2Zs7f+FVeIOPBOMA0R5BSOZAVPShZuS1aZ/U3dIdKRWTw/A2/FmyHtzLhHVZFUfjxXRT3HCXjFYSEqGvnBY3Xwt1G59QXRFFvGr7g7C4mGlgM7NB7iKlCq15VHOz/DfTVbp6bnv+XQQYVRahGh4GGugFDVrDlxfBRNSzVyMAIY0g3BtGHu7n+ZYvUGMOC9DzH9QRFJaP9SoU0yMel3ohC6ga4p9DZGxnyfzXzVNd7EpYIkW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nl9TTGAnNGG9Hv6390gJyk9DOn7yYs88BYn9dMFaZ7k=;
 b=fVVcZLh9DDHDehSWKTlJKVAuTk02uWF7J9N0hMlMra9Nrf7kelwMOXIlvkznl0yE3Ek9A0fKJfWEZSlkkSKeMSXXW68YHMHVuw199U58F2ALYvCxMTyshW49ZcS31/vyAUPwfVEc2/NC0fFG4oY1xKgO4o38CkQHC5BdwViG7GEcG/yTPapi5FrKoA8KeNkwt8f0nvUjL/hgVOFYhcK+pxoCzHXsEu7kt2IJ1sOodpm6keu5qXg/FiAJRuCFoQwOI6/8AJkI6MtdtMtWT1dkYEdactoMcq1U4AaHV4mECtosqjfI+/qx4M7kjkuQlALmIrOz6fmtG107PjJTdjateg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by SJ0PR11MB4991.namprd11.prod.outlook.com (2603:10b6:a03:2df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 20:13:13 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 20:13:13 +0000
Message-ID: <0329924b-a868-49b9-ab98-0b3f8bd545cb@intel.com>
Date:   Fri, 20 Oct 2023 13:13:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next] net: sched: extend flow action with RSS
To:     Hariprasad Kelam <hkelam@marvell.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>
References: <20231020061158.6716-1-hkelam@marvell.com>
 <CAM0EoMkawLKubMdrTOAcOhYq8Jicc5XuXuytBVi-yy-_QgiTuA@mail.gmail.com>
 <PH0PR18MB4474C304575E55092A2C7377DEDBA@PH0PR18MB4474.namprd18.prod.outlook.com>
Content-Language: en-US
From:   "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <PH0PR18MB4474C304575E55092A2C7377DEDBA@PH0PR18MB4474.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0034.namprd16.prod.outlook.com (2603:10b6:907::47)
 To IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|SJ0PR11MB4991:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0500a3-cfed-4204-fb09-08dbd1a8fce1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSUzZYj6VHuhDyupwnprEB0psTXz6ZUOLe4RHPKZKAFPdW1cNGyXIf5IkqZeCFPlYuUDRL4S6sRJTrH05UPQC4CWHdreyH6GcA+Mfv+1Pq5iXx1it0t0X0qv69/fb884mrjmIjFBrkvCE3SGY/qyAny+8uXAugUGiha3CgBMofeEqexf7JOXUItQff5/5EwjfA7nKELfYaN59H7tmjifZj/IfdzcZbPGuegbmckkIw072t6l6149hUJ8qgHPBabLoeXSMTxMDjYdUifrc/Wbu+jAlD4ICrhKNwDXcrZmuGwfGNY87OgjAkmOdQPIlJk8qMRvrSU9gNpRiZZ4xfyYtd9KtiUshU3z9SCES6/unjc5C3NElMquqZtz/owpDJkVAW37EA6Ygn1bSQKmmKOgwxfc6rh2hRLSjZUC2Mjy+kN/UuatT1Z7+tUiaPR92Fdpg+56WVXYNqDXVkJDaA9cIM5NEyj02dmfXs3Oqho2cLWQ20ximg+qdZxIpB3htHUAJyzIexjCotjFRLygt3peKMA6LMaKEhZyuA3RYiWOZf8WFWQoJ4ZxzlroRGp6ZMMI4a7eiTSI7mnWbM7zduixtwTxMPHPwBnMsf56MpIm5zUgNO5a91HYfdwlqvZOZfqn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(8936002)(5660300002)(4326008)(8676002)(53546011)(6666004)(6512007)(2906002)(36756003)(7416002)(26005)(2616005)(38100700002)(86362001)(82960400001)(31696002)(6506007)(6636002)(478600001)(54906003)(316002)(66556008)(66946007)(110136005)(66476007)(966005)(6486002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXVIekk5ZDF1S0d2YU9sNllTN0NQdGlVVng0aG41MXJnK1BNbko1VzFXTUFn?=
 =?utf-8?B?OUhkOUFWNU1xbVRib3NGSjFmZ0N0WCsxQnpSNW0yRDNGKy9UenM4N3Q3SUQ5?=
 =?utf-8?B?Ni9PT3Z3ZTBPekVEWjdmYlVUMW9RSWFPbFZpbWF5RXFnMnlXWDdRRzhWb2hm?=
 =?utf-8?B?TG5VWXUwdEtkTXRndlpiYXJHK1ZvdkZsL0txSUdKbFhTVGtVYzQycUNhelpO?=
 =?utf-8?B?MHgwMUt6Y3hOcGZEeXdPc2tTdVlCZzN5UW9GVk9yNm5seTVzQUNYOWJwSEdl?=
 =?utf-8?B?VGVCd2NZbmZOUWZzNUdoSUFrMXd0T0xsM2JZZ21yV1daUmd1UDlkeVVla3Ax?=
 =?utf-8?B?RDRlR1pMYWJjVlVIcXBmeUluK1pLQS9mYnRtcmt1ZkZncGY0Qm1EbGpPSW44?=
 =?utf-8?B?d3I4ZU1NZ3U4UnBZNjN2Z3ZIRWdYUExjcjZpRDNrMFFGdHNaRzNpRjFTSnVu?=
 =?utf-8?B?N1hkMFBJbUFIS3J0TG5RVHRRS2w1MUJKUGdYOVljUVVaRVFDRmp5Vlh0T2lE?=
 =?utf-8?B?TGkyYlppaFlhdUhZR2RtbWNrQmJXOEZoNjVtR2s3U0NFS2U2N0ZNYWoyaFdh?=
 =?utf-8?B?Rk93d3NETjdCQXVjbzlFQ2Y1bm9rQlVzVVZHYTQ2a0wzTlhud1VTckMzd1pQ?=
 =?utf-8?B?LzN3ei92RTFGeHg4ZWJSeUJTR2JsZElsU21pYUR6LzVPZGtIVEExb2JkeGdG?=
 =?utf-8?B?NzlpWkpIeHlrazk4UjdjdFNNY1N4bGtoYkEzc29LZjlVS0xpbS9POCs1dUxS?=
 =?utf-8?B?UjI3Y1RMSzlBalN3eEhqZmZJVjFXV2hjMExvbEh5ZjhVZXhFUmdRcTNYYldv?=
 =?utf-8?B?anFzSlZxSDhIWHplZzYzbUV6ZllxRmZwdExRd2h2Yi9tVUtKSHdEV3BTdWpq?=
 =?utf-8?B?ZXZCOGZSTTlPa3d5QXJwMVRHb2l6NEpWN1RFdnc5OFlGdzRqYkxLV3BPQm9y?=
 =?utf-8?B?MUxWaUorZjFZU0FsdGJodnhaVlJvVEtEVk1qOGtkb2RXem5JdW8xOU5ldTBG?=
 =?utf-8?B?Q2tMTHlJVkFCdFh2WmtiQ0k1TDEvRmYxcEJSRU5Jd08vdVVXMC85N245Y0J3?=
 =?utf-8?B?MUplb2lxcE1uTjN2Y2VkaC9TOUlQWmVCTWRJV2ZFbElPRU9hdmtKM051dHFJ?=
 =?utf-8?B?RTVrODZ1VGJXZEl0UkRLQm1PM1JmZ2M3aTl4ZUVzeis2NmQ3K3lvdzFmeTcz?=
 =?utf-8?B?QzJvVXlrZGZRME54SUJ0NDUrRHNid2d1VkpiSHpwNnJEUzVwczV5YlNDU21Q?=
 =?utf-8?B?bzFNbktWdEN3N0ZrbUdVTnNoYXYzdU1XQW85ZmRURHlpMmxUREN3NzRhSFdK?=
 =?utf-8?B?QWFWZ0RjTDlRWWlQV2F6UkEzbGxScXhKSjBGa0xScUh2bUFLUEsvVEw4RnhW?=
 =?utf-8?B?c0NVWHh0cno0OG9mZEJ0MXc3OFk0SXdzdUZ3c2Erb2NiMXU1U3NDbld2eC9F?=
 =?utf-8?B?c2tGbERYZi9US3d3OXlzTkZkbGkva0Rsd0pqbGw3V2tQaUFnNm9LOVBOeWt5?=
 =?utf-8?B?N1ZJdWhONVByRzh4bXZnbHJlc212Qzg5WFQ0TmE0Y1Jhd1FlWEtCcmRZeEFW?=
 =?utf-8?B?akx0YmxVVjhQa3pKcUdpYXV0eVlFWHNTcWlkK2lKTGVlMmJqNFYvYlhGdTB6?=
 =?utf-8?B?SHRtSVl6aUJOQTUvTUxuMXdXUEhGUTlpd0tZNnlyenljd01kK3hrdjBYdXd0?=
 =?utf-8?B?emFuWk9QclVHWVl2NXNZSnFnVGpzZDYvbmpCNS94KzJ2bmxQeEIyYlAzWHJU?=
 =?utf-8?B?REJmOGZKMWRBYjZkWnlSV0thaUM4cXo1MmlHbW9jbVlZYlZzdXhGV0FNSjVh?=
 =?utf-8?B?QThBOW4vNE9LZFhXRkd1VlNKMkQvL1pTVVJOSjJiY1U5djErd2dkRjUwSTU1?=
 =?utf-8?B?QmlxeGZSVFlMdHBFdWZSMHI2OHdtRUsvNWpDbEdNRklJbzhQUzNscnRBYzJz?=
 =?utf-8?B?MmV1d1A1K2ExZTlFR0gwVHp2TXoyTklPRDZyR3ZyN05EY2Q0QjJmUU5zekIv?=
 =?utf-8?B?QktzOWxseXlBa2FkZW5TbnFKQ3B3cGxHOTR6aEJlOHlxR2g4T0psTG00N2I5?=
 =?utf-8?B?Ni9HdVdrVkwrR0RGVmpsTEpKdUhxS1AwYyt2THNIOFpzVnZ3d2czWm9TcFFR?=
 =?utf-8?B?VER4VjBHVnppaERvbmN3UEpPL2dmUTlBMnhNL2wrc1ZuTkxiNXVvZHZHWi8v?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0500a3-cfed-4204-fb09-08dbd1a8fce1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 20:13:13.2256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wGPJuBj/p21O8lvmX4H7FKQjeFz68AKY+khS9rL1+fdA13sK+Tlvl4q9r50XLZ7okGID2Vq/KaOIjCodG4kCyLEbKdHGGHhijOtcPV2pSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4991
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/2023 9:35 AM, Hariprasad Kelam wrote:
> 
> 
> 
> 
>> On Fri, Oct 20, 2023 at 2:12 AM Hariprasad Kelam <hkelam@marvell.com>
>> wrote:
>>>
>>> This patch extends current flow action with RSS, such that the user
>>> can install flower offloads with action RSS followed by a group id.
>>> Since this is done in hardware skip_sw flag is enforced.
>>
>> Our typical rule for TC is we need s/w equivalence for offloads. How would
>> this work in absence of offload?
>>
> [Hari]
> Our typical rule for TC is we need s/w equivalence for offloads. How would this work in absence of offload?
> 
> This patch we added as an extension to receive queue selection in hardware.
> This patch "act_skbedit: skbedit queue mapping for receive queue" enabled receive queue selection in hardware
> and skip_sw is enforced.
> 
> Adding stakeholders of this patch, to get their opinion.
> sridhar.samudrala@intel.com  amritha.nambiar@intel.com
> 
> incase of RSS, hardware makes decisions about incoming packets before they are even received in the queue.
> 

The skip_sw for skbedit receive queue action was enforced as the only 
other alternative was a new hw-only action, or changing the action 
mirred. See discussion at 
https://lore.kernel.org/netdev/20220921132929.3f4ca04d@kernel.org/

Few questions WRT this patch:
How are the rss groups created? ethtool rss contexts? Any reason to use 
TC to direct to rss contexts over using ethtool context ids?

IIUC, skbedit is meant to only edit skb metadata such as mark, packet 
type, queue mapping, priority etc. Even if this is a HW only action and 
has no use in the stack, would skbedit be the right fit here?

> Thanks,
> Hariprasad k
> 
> 
> 
> 
>> cheers,
>> jamal
>>
>>> Example:
>>> In a multi rss group supported NIC,
>>>
>>> rss group #1 flow hash indirection table populated with rx queues 1 to
>>> 4 rss group #2 flow hash indirection table populated with rx queues 5
>>> to 9
>>>
>>> $tc filter add dev eth1 ingress protocol ip flower ip_proto tcp
>>> dst_port
>>> 443 action skbedit rss_group 1 skip_sw
>>>
>>> Packets destined to tcp port 443 will be distributed among rx queues 1
>>> to 4
>>>
>>> $tc filter add dev eth1 ingress protocol ip flower ip_proto udp
>>> dst_port
>>> 8080 action skbedit rss_group 2 skip_sw
>>>
>>> Packets destined to udp port 8080 will be distributed among rx queues
>>> 5 to 9
