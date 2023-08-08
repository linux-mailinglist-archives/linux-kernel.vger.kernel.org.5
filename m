Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF35774BC3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjHHUyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjHHUyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:54:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960C6A622;
        Tue,  8 Aug 2023 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691514596; x=1723050596;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eqkrZ/qFybHABH84EQCIX1pmJ/YDTbq3lju0nVvTH94=;
  b=GPz26pgb9XKeSBi4/o6IvAR8osM52hDD+T4j5nl+iKTT6uq945ziQiYv
   1L2hvBXcOATO8P11+RJ8ls9ncBueHGeD5VZHuJBXBDdsb0NNnoFLnDnJP
   TMAthqHtVbrF3PBkdeWn7VPGmB2Fj4MvCZ1eCiI6+G1R4OBU7cLlRCNO7
   GkEKWCS5DxbLyK9y4e0Z40uZYH7W0W1qoRqGFUVFa7OB6bhPdAKWIORIo
   Soq0WC2lhEQ//OOBt40dVptOWfMkuzXUP+KB11u3xYilWCFW3dIp5bUBV
   h+gJOXU0X3lk7Rr2I7ygbAy1ZCDfTKVGODViw9J3Sh6CmVlIJ0JQIlliB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="370882530"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="370882530"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 10:09:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="905256121"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="905256121"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 08 Aug 2023 10:09:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 10:09:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 10:09:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 10:09:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 10:09:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqtkhxLo1gMqGg6TcxIhT4k/8RGiT8wVtQTzVmLpyGgswQF1nMI1D1SXlRAdZy8OBU+urmnqqCI1NwxDU/JcilWbJeDa7q+VMfGNWy69Ftk+m1Rn8Ji7Z7XmoVI3g4k+ATJFwUHonPcIz6vFem97axFRVc5CaLL3JFA90YWX4/4srddMcgfRIyB1u7EDcBe37/coSYX5IqTOd2dMdwESNN4Iod2s91y15VpcjdxvgScxr27fyZQ4SHALNIxHfrtNeptYWlD9VKTsxg/r6yqw5IXc3t2dnKMRbYLG2sZRk0CVolVznnlhKtl5G4NMmxklatbt22AkD4BEYf1POwDZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FSUFDZi/I4SPnWPOCYN6qDF3j7NoDPHFx4mKUGjlU=;
 b=QbvFvqRu+wFcQJqyY6armADMZCIb6l8RjWu0QEfhE4/PEV4NUUZNHuPipaNCon9Nhda8YirRH3Ged/YwLyXZRTqC5rIdWxU+N5bJpKRctZh3UA6+DzuHQ+Vy6/pNx61stCLadCjLgqZXbI+D/BK+2A+sSSGAnJjUUxm0RtMoR4scm4wMC7BFs8QrKaglemGeUaqJm+2B9rcCvBD9mLnpxUDRVTEpI+1ktekz0y0w+3yE8Qd0DWqvmTO7n6rlAsn8VDqleuCph+ip0d0yzSaOTxgwH8z7kLKhMRtwMqN49Ojsf+ieJVCPj03qlcjeJz2EKroRzjZr/x9K9guf0igpSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6870.namprd11.prod.outlook.com (2603:10b6:806:2b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Tue, 8 Aug
 2023 17:09:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 17:09:12 +0000
Message-ID: <b74b543e-ea5e-4c60-1f37-eade3affdd9c@intel.com>
Date:   Tue, 8 Aug 2023 10:09:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v6 7/8] x86/resctrl: Introduce "-o debug" mount option
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
 <168980893967.1619861.7249871216790436466.stgit@bmoger-ubuntu>
 <68d6d4a4-80e4-2aa5-409f-0e2744c20e88@intel.com>
 <091884b4-d479-9b24-013c-8d5dd9eb4ecd@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <091884b4-d479-9b24-013c-8d5dd9eb4ecd@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0096.namprd04.prod.outlook.com
 (2603:10b6:303:83::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 863322df-f666-4a88-0334-08db9832300b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HE8GbT/DXSiPyWU2PgiEVp03oQOdwgt29utATtAGFd7RW3xnog9ypBZIODlqlbRCQoBz5EhWawfNVaN28QXRpcaUUgEndNkFmwnA9N6W42nWY8pING2SQIPgioVxxLrXzbqQavtU4Vo5sBYKT5ay6Qz3sP9F9f5Vviiw7cyAkfDmKDmiH4wu5zBjDxC2cuiluiLdA4VQ3UJeC7SdMzjRrz4wQmLU3vtgTICt0FOkz6f1iwcWZHpKwZkzEBhVI9F3fn8wfjh1GhmJ4rf4o1AI0oAWX6YpstSxNqCGXlCv8GN6OC4LWFGZ92w+hEtskDJ5Gl1Yki1AuqyDPfeDWeUR3YnfyCmiSzJE+6HUJU09KgvllMjHceohJTIs9swjWNa3ABGcJn0AlF4qeYPjNC28iMGlB4jrhUC1Qlzxggq2KaZWTb7ynqzmzuzqq4w3noIcj9trzKQpLQOR6xvttLePCPI+X4dDkS54CHXNV9eFpdmM0yHOFPBJY0cWhYBQtmKF0yHK/TDcaq2WGVCO3FKV89EFOFGDby84alaB+GMTsURiH83A87ACSQsdTkGWfmhGAeuEO2jG6XZ77x5OKPCZH5AYsKoUxlQPtDN3sYXc+OVvEG09u1i2SwdyGTGE8zEi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(186006)(1800799003)(966005)(6512007)(6506007)(26005)(53546011)(66556008)(36756003)(38100700002)(44832011)(7416002)(5660300002)(7406005)(86362001)(31696002)(4744005)(4326008)(8676002)(2906002)(66476007)(66946007)(41300700001)(8936002)(316002)(6666004)(478600001)(82960400001)(2616005)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTFEaklnRk9YNkZZZ0VRYk5aUW1HcjBkWFZoUkZ6ODNMVW9CNE9Lb1BBazBK?=
 =?utf-8?B?UkJFY2FHVmdDUElkL0lPbGtDcnU5OXJ1SFBNT0ZBLzR1QUpHbUNHNzJ6RXdG?=
 =?utf-8?B?Y1BVQ0dzeWU5KzQvY1ovb3VDek1zQWh0czNNaVpPL1NNWkJ4UEw3WUQ5Vk1v?=
 =?utf-8?B?ajlUZ2J3c3E5Y1pWVG9SdXRXczRIbVRFYWNJZ00vdzI5cll0cXFpVUMwbkpR?=
 =?utf-8?B?cnJsZXFFcWFNQTNCZ2lFUzBQeTJtNzJ2WFR2ZCtReE5PRXRuMHowc3dXQW15?=
 =?utf-8?B?TjNaMmRxbFF5YXI5bGpUTDBCM0FHd3B5OHJ2N0NRU2dET2tkeWZ2YnlaaCsy?=
 =?utf-8?B?SC9XYTMvZTNLdlFGZ3BnOS9HTXFWRmtiVS81dXlEVllDTHhTTVU3QzAyWFkr?=
 =?utf-8?B?VmFTam1zdWJtK1AwRGJQcmNNZDBCQmh0dC9pcHo3bmdFaE5VNHg4d2c5b3hp?=
 =?utf-8?B?U2JMbWxiZ1A1VlZrZ0NSR2dQUzNxeHp5RnBNY2d1S2dON1NIaFZ6K3JBWXp6?=
 =?utf-8?B?eVJ5ejI2SVJlOC9XTGp1UzZJSFA5MVFHay9rMGFyOHZTZXZqY2xpbFBkU1Qx?=
 =?utf-8?B?OXVyekZ1STNNRGZBM2kvQ0p1TzlIdmdGKzdycU5vZnpZdVZqWEpGV1hkZ1du?=
 =?utf-8?B?WTNCZGpMTitWMjRrOEZDOHcveUhraWxRQmY2Y3FBTWFFZEJMOHlrOXovNmN4?=
 =?utf-8?B?OGN0amJRK09RUCt6aGJEN2p1MXdvbzdFbWlCTC9yYkYydkQwQnM5YnJRYnIz?=
 =?utf-8?B?eUVNRFBYOHJNTkozTklWZ282aGJrdzhzUzZuMjlnUmFoenBuZnM4VlhIaGhm?=
 =?utf-8?B?UWlCanVCcTFxbjl5ajhIa2t1aEVoMnJHdVdDWTJ6cnlCWlI2eXdGa0R0RGZ3?=
 =?utf-8?B?aCtQc2o5aTcrVXFGN2x1eW9YK3lkcFN6Q09YcVYvWVlVVHRwNmJEVVlYNU4v?=
 =?utf-8?B?MkNmaitTZ0RQb2l6VE1IVVl3UnJaRXBQQjFOSDFJMUFoa3Y4UzhuWi9wV0w5?=
 =?utf-8?B?MktJWlYrYlhwSWZoZVV1L0ZMYklCRXBlZnRnSUNFWUYwOGpRU2Izc3ZkU2c5?=
 =?utf-8?B?aGlCV3hadGo5eUFFd2hSbEZaQjJFRXpXdG5PYXE0V3JoUVpLS2xRZTlHakZE?=
 =?utf-8?B?TzlMYkRkeXk4Ym1CUjA2ejNjZC9vaWNwZUwxWXZBQVVWSEdKb00rOUo1YWZz?=
 =?utf-8?B?bFlPNGpHOXp1eHVkcHlwenZmdUZuYW5zRXBIdHQwcjJ0cnQvSlZGc3lvcTdv?=
 =?utf-8?B?QzJvR01qMitRWkxtMHRvQmxRSW56VDF5U3ppWi95S0g5WWhiQzBKdlErdU1F?=
 =?utf-8?B?NE5pTE02WmJpcVJCUzE5bW5pRnk0U2N1WGQ4SnIzL2xvQlM1ck44KzVWMzV3?=
 =?utf-8?B?VjJ2U1JYWEl4cDdSa1IvQ3dETHQxSkNBa0YzRC9UaGl1T05vR0tCclBQTDZs?=
 =?utf-8?B?aHBHcll0MWZ1eStYUmtQZGZ4U3pPd2FZL3NmT2dlZ1gwdkNkeGFhWHEwbG1x?=
 =?utf-8?B?NDVzaFkwM0YxQStKaXlOdWdiQnl3QXVFWGQ2OTFtN0U2SWprU2xIdDJlVTdl?=
 =?utf-8?B?dXlCK3FUcGpUdERwb1hLMXVxSklUamdKdSs2WEJmMDEzejcxVmMyb1B0cnFO?=
 =?utf-8?B?VGZmOENkOTE1SXM3TXlJQ2dIVjZ1T3dadmJNdlNuejkzYzR0eTNZR1EvcnBn?=
 =?utf-8?B?eHkrWmRYZTRnR0NZSGcwa2wzUnAwZ1B5c0doNzVqbm5JUHU3cWE0MGlSRHoy?=
 =?utf-8?B?dHVuQTQ1QWt3eW5lb2N6WG82aXVwWmV3b2E3dmlVeFhoYmxSVVZGdWFOZDR3?=
 =?utf-8?B?dW5SK1NpSEEvRjJ5UE1CRmxIUmRrS09jZ2xRY1ZKWWM2ZnJTSDJMOG5FdjBa?=
 =?utf-8?B?QVdwNVNrZjNiVXRFK2Jpa1BoblY3T2Ivakx0R1JIdjVrV0lRWkdZRHNXRDNM?=
 =?utf-8?B?VFFsOStHdUlpRkI3MlJlUU1uYWs2MVhCd0tBRUxZa0MzSHdDQlc1cTVsVVFG?=
 =?utf-8?B?U2Z6b3lwRzBoaTkwWTk2MDRTMFVBVDdsUytsNHJoWmRKQ3Y3ZEdzT215aHds?=
 =?utf-8?B?RFpLaFFrZk0wUEtka2ZKTjVFUzdyazR5d2oydExwQURtbWZleVdEWUZBbEI4?=
 =?utf-8?B?bGt0RmVyeUIyeklUUzdReVNpbktkUEg0ZFArRnphNUhNOEZJYVRlTUlBV3Rq?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 863322df-f666-4a88-0334-08db9832300b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 17:09:12.7010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wvUSfJbWktivEGT6jDYg7IbyKo6ixd6ksty/jmjImI54cAYYrMG5Ju0bdDSl4YJqQxxoJwmYGxG9nNdj86cMZp3vzcMxVLi5nb/poLUtec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6870
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/8/2023 9:29 AM, Moger, Babu wrote:
> On 8/4/23 15:42, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 7/19/2023 4:22 PM, Babu Moger wrote:
>>> @@ -2591,6 +2599,8 @@ static int rdt_get_tree(struct fs_context *fc)
>>>  out_schemata_free:
>>>  	schemata_list_destroy();
>>>  out_ctx:
>>> +	if (ctx->enable_debug)
>>> +		resctrl_debug = false;
>>>  	if (ctx->enable_mba_mbps)
>>>  		set_mba_sc(false);
>>>  	cdp_disable_all();
>>
>> These changes are a red flag to me. Developers still need to
>> do what patch #4 was aiming to prevent.
> 
> I think you meant patch 5 (x86/resctrl: Unwind the errors inside
> rdt_enable_ctx).
> 
> I can take care of this unwind part in rdt_disable_ctx() and call it here.
> https://lore.kernel.org/lkml/9fd70ef3-ca90-65e3-4746-7d574bdd159b@intel.com/#t
> 
> Hope that is what you meant.

It is. Thank you for reading what I meant to write.

Reinette
 
