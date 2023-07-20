Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A82775B596
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjGTR1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjGTR1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:27:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3B41984;
        Thu, 20 Jul 2023 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689874064; x=1721410064;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GDH2mWhAgq+IzVmqtqwbar4+pqQme+4JI9H5UFT48g4=;
  b=O1QMTkA853YKax5ikPWuWu9A/Jzjm2VuLrZ1tv9hL7fPyenCgWL7zC04
   5g/vC6iznBpqfIA0axfxtjQSn2zvoT/sQVsrVk1qGlcycryTifrgIpaiB
   oN6iwRrVh8LDik4eRcXHuDt083bDNAnVHmiTw+ww4gZ/FrEhCLDagS1Mc
   EvBYzvJ0/9uZPXIreAHZK5ckqGpJ8zNnJves7usUqGYsY0W/g6Ea/g/MK
   2m8lTmNe00b5MhYPJ1VoGLhlPsan2/c0zHMvzRx5kA3vsQILrtpur95Dn
   3BW2fBRWzrusDV/HOvNqX7y9co2t+ISfC1Q1t2FRpjGkpkKa05OBZvFPH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="453190694"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="453190694"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 10:27:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="759655611"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="759655611"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 20 Jul 2023 10:27:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 10:27:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 10:27:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 10:27:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzXkiygxEIs8F3SOa0PmJpujuDw/lrQcdqAdqeVphPtsqkZGewxdIldV7uRBcVS7V7zsnpnlRgK+/oubaE2TLxCBbLp13aMBqRri7flA5e3elVrm9ctC9dBvMqdGg2LX08ZQWP8x+d1JPXMWZPImUuXQwl92FfCugxbZ9fS8tW7zPcIN0ZWErQ80h883FAd1d4yqUdG0bvscK0qAKbGn/mYpldzqIC0EKJCSgDKpDHdHeW6cwvU56r1LBHSDQmohMva4yQEXkWNLSJwvDTfhqKzPE6K1MSTjf3n/rJjdYgEir2wBw45rP3nK1wJaK4HAtUXHIDg+DHyOt5b08xmK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXjghv5Q83jQ5phO4XieEP6xJCEETrOQRvOxkP3/WyU=;
 b=KZFfAsVKKtF0/vGaVCZMiKgl07KQXRZuS34qIvQZ5gnkUCZP2ITKGs7OEohgEeLQACO32MSBVhkL0+dRxRtnb8QVjwCwOIwZDJWMoW9TF+1Tl2SOUp5LfzXYU4DuybVEGFnjJRmk8qmWjXqLBVjeUYsrerjZsihxlxMTxGZx06wgZ728z/iTUjGoOEcE+WpZKZVZkwJicJlKPiUS5Me+jhmNeh5O2BzePP86zrL/ECdkQMKYSenRHw4KZISvJtgoH4bbHPORVquM0RQLva1QauyrpJWTfn8FPI07B+Olon1YlcDTHnoOkSLEhS8NqFJwprixgUAeHqYCXCiSkMSRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6499.namprd11.prod.outlook.com (2603:10b6:510:1f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 17:27:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 17:27:35 +0000
Message-ID: <4cb9aaa1-c4fb-490e-5b91-a05ab1a0e95e@intel.com>
Date:   Thu, 20 Jul 2023 10:27:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/8] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230713163207.219710-4-tony.luck@intel.com>
 <769521ee-6907-1613-442f-e2915a8ea554@intel.com>
 <ZLcY1MQr5/Ibnv7N@agluck-desk3>
 <076a76c9-ab57-cae2-e6e4-99d26921b578@intel.com>
 <SJ1PR11MB60834DE7D5F7728BF45953F7FC39A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB60834DE7D5F7728BF45953F7FC39A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:303:8d::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b54ed5-16ca-4f48-cee9-08db89469b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qa6C9Q09x6FOQwyq+xRaUcvpmm6O30zyVM5D7fWqUWbJe+pmckXqDPDcg8bux9PyQkjm1vEMEDtx+W7A9uuCQBe8YDl5RUOp7YlL0Yw1rlMWHqEDpXLOlmt8Cy1HJnEdMCdRSuvljvup3ZMK1SKYorkwdS47neKKr/RoKgbdVp6xN1yvb9guVUw4neKIREVkdo3vjwHXgCg/E/YlMfrAylUO5//RX54UqcdK7KKK2+v8B+yk1E9OCOfOYui7BxjCDsROvcyjnsXQ+i/7EPAO53KNYl1tiKoPhw+dr6cyoFk+sf1ygKs1CAaGfBIE51iVhnzC7uJOihZqcl4CnaQNwBuUhGDgBsqfwjQ7JK0cZRItzCGLfmA5+9qNBX6K7HsWBGtBCBZzxuDtDyZl7jwsUaGivggS1LiLVdWyWfBNyXAV6WtEoXPhTqsMI6IXB1utIv72NYKiRcZzuF74I9PTd5XOIW9dSlDkejedN4W4of6fCpdXK2wKdTI41fMkF3iUWO31ROL2VHjYxo4CDud6SDJ8GbWb2tsXg/3v/AAAgCS/0yuCt0pfWuaxcoGFczTX9S0viJgZSqihdZdkYXv9RRg1cfyuzP+/R0F3vzWViDM0riKWpO+hbEd3xNHunrHrtXLZnMpSoOm3I6tawtaxpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199021)(83380400001)(2616005)(2906002)(82960400001)(38100700002)(66556008)(316002)(66946007)(478600001)(4326008)(53546011)(41300700001)(6636002)(6506007)(26005)(186003)(66476007)(31686004)(6486002)(6512007)(54906003)(37006003)(31696002)(5660300002)(6862004)(36756003)(44832011)(8936002)(8676002)(6666004)(86362001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTBKdzJCam5UMnFHNlpMUkcveW9NWFZ0cDdMcXh5am5iOXJrYzNSeTh0VGZt?=
 =?utf-8?B?eXkvTDRwaWRBcXRzVDRoa3kwbmhTekI0TmJBNE9uZ0xjWHo0dVpuTTNFU2R4?=
 =?utf-8?B?MW9ydjVpUXk0QUc4Qjh6THVJUmliRGY0TGZ0N3hodnZFZERmVXhiMWZNd2Zr?=
 =?utf-8?B?ZG9SYUYzbFZpcVV3SXhTMzBjV3hOUWRJaEVzS0ZyRHVXcEcwdzdFYzZVa1FN?=
 =?utf-8?B?WFZCVjJFZUdGaE5zN25hMVNpTUwxdEJTRUQvODQ0M1ZrNWwzNmtTMlJLYXNz?=
 =?utf-8?B?Sm16ekRzWmYwUU56OUdJZVJ2ZTRhVXlFSUtCOTZONWs2MjQ0U2FXMVNxKzJi?=
 =?utf-8?B?c3NQR09CTm8rbURYKzZNSUJCQ3ZlcXNqRVNkVzRjQ2hMaGllK3BuL1ZuOGJF?=
 =?utf-8?B?MFlHR0tWOHR6ZEh5L01hOUt5VXBBdUszK2tMN0tkSi9KSUVYZWlmK0FvbVNH?=
 =?utf-8?B?Z01BV2xCT1htbGpTNnhQdXMwek55SjdYOXJuMlUzUEEvaWkwZWhBQTB4WDlu?=
 =?utf-8?B?YnlPelRLdVJTeWx6MSt2M1hsMFNKWEt4RjA0YkNwdjNyNm16R1BsMjByZVRu?=
 =?utf-8?B?Y2dOczlYZ0ZZVGNIcmlXVURmUWpteFBJa2g3ckNmLzFRS29tYmdHSWErM25K?=
 =?utf-8?B?akJKbmw1Yys5OWgzdVFWN0lJK3FabHQ0WjRUTDQ0d0pucmU1QXo4Y0ZDZEJZ?=
 =?utf-8?B?TndNbXVaRXRTYmhkU0J2aFk4V0FacWY0M2hQa0lmeVdDWTU2UkJGQUhFU080?=
 =?utf-8?B?MDhuZWRuMmdaNDNNSnB4V3h4dit5V3htcnRabmtycGpuSmtXN2tlRXRyRWV1?=
 =?utf-8?B?VHdQbmFSV3hXT0w1QzJuUmlTQW95VThYNTJkWjJhTXUydHpZVGJFd2Z2YkhT?=
 =?utf-8?B?WkRPYWtMc3gzL2RWdjRDc3VPWlpHdXZCN3V3WVAvaGJaYm9LZEdWUEk0MkNC?=
 =?utf-8?B?eWF4N1BubTJvaUx2RmRWVG5IeWtVbTc0U3FRR0lSRnJpb25mODRwU0dvaEp5?=
 =?utf-8?B?NVN1YWpiY010YS9aS2syUVlVejBWSndGSUhsRFpoNTA2YStOZmFWNWVIU2J3?=
 =?utf-8?B?SzljTllsNWI0K2tETGsyeHRNOEMwVC9QdnJXbndVaU9BVWg4R0xzOFVWRzNC?=
 =?utf-8?B?ZWpUN1QxZWhnZjhhMmI3K0c1TU5NMVdiTkEvS21HazczQVZOd2ZWU2VNeEJS?=
 =?utf-8?B?T1FUY1lVbFlWa1hHK0NkbWRHckM4eUw0MU11RUhXYlEvZHF3NzB2aytOL2M5?=
 =?utf-8?B?S29OU1NWeWZWS21lQnpLNWMxc3J4WVFrME93ck5TaTFWaU5CZ2ZFeUE0Lzc2?=
 =?utf-8?B?QXhFZ1puYW5KTGJKVEY4SmJ3RFpSRFR2UURjNUhIeXlDcnIwdlZVeWNkVkNQ?=
 =?utf-8?B?TWNvRmozZlpPWURPdU5PWnFJRHhSYW9FS2Y3S3VRUGwyNjh0ZnNKMVNkMnVQ?=
 =?utf-8?B?RVVSYW4xMUlab29nVkY3Z0FJdWxVQUoyTWxaeXJuRjRmcWhQcnkyeFNmNGdY?=
 =?utf-8?B?TGdXQ3hOdTFjUXdiZlUyQ1hHQllGd1ByRHZNVGQ4a3ZJbDFlUkVJajZZN0dq?=
 =?utf-8?B?dDZWZ0hBcDB3WnRMQWRNWDdNdWFEdDI4d2liSXRwVTJJTXQrM2hkMDhCSi8z?=
 =?utf-8?B?dHpSWWk5c1lnaXRHY2lJci9JQ1R6R1dTbEhKZ3NHaWdtakFEVmZXNDQ5Q3Ro?=
 =?utf-8?B?eHIxR0plZXI5UHNSSzJ3bHVlNC9mWUJKZ3U4ZmVKeisvWk9xQk1QM0dqNnJv?=
 =?utf-8?B?MGpna01uZjM2dzF4SVV5Z3YrR2JqdVZSSFJ6S3VIa2dTbFFxZmd6Sjl2Y3Z0?=
 =?utf-8?B?NzhsRFZRcnAxYjJVUi9pQUNZZzNsajRnM3h4SWFENzBWZ0JyZ2FtaU5pSko2?=
 =?utf-8?B?LzROQTNDMUpWQ1NZOEx1Tjc3eGh4V2dYdmxuSEFHeUZvQzArMmNacVFkMmti?=
 =?utf-8?B?eEpDWkk0QWhBQmd1dmtPaHZLeHJxcS9DRTZhYjh2Y2NsQXFScFA2ekhtMUNs?=
 =?utf-8?B?WmJCalVHeEpzK0Rhb2NrU3o0anFTZms0VnovL21BWldLRHgvdU45dEZIVml1?=
 =?utf-8?B?WmZkc0Y2b2FXVm1aYkpEcUp4WTJ1d1JtYTk5a1R4U3VkQXVEQWxFWGlGVysr?=
 =?utf-8?B?T3JPUVo5aHhjZHhkWmNZS2lCK01EYjI5eDBqVW1vRUsvTis4NFZra2tkclZB?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b54ed5-16ca-4f48-cee9-08db89469b49
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 17:27:35.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUKOeYfQUzmv9Fjgh4YD1R/X9cT4gRCcUp5WH509MZ4WztS6eapu+2wGiF/tkquLaLKKYlBXb8e6qvDEZRdc52ns8YRU2Imrm5apf+ptsao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6499
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 7/18/2023 5:11 PM, Luck, Tony wrote:
>> Yes, this is the idea. Thank you for considering it. Something else
>> to consider that may make this even cleaner/simpler would be to review
>> struct rdt_domain and struct rdt_hw_domain members for "monitor" vs "control"
>> usage. These structs could potentially be split further into separate
>> "control" and "monitor" variants. For example, "struct rdt_domain" split into
>> "struct rdt_ctrl_domain" and "struct rdt_mon_domain". If there is a clean
>> split then resctrl can always create two lists with the unnecessary duplication
>> eliminated when two domain lists are created. This would also
>> eliminate the need to scatter ctrl_scope == mon_scope checks throughout.
> 
> You might like what I'm doing in the "resctrl2" re-write[1]. Arch independent code
> that maintains the domain lists for a resource via a cpuhp notifier just has this
> for the domain structure:
> 
> struct resctrl_domain {
>         struct list_head        list;
>         struct cpumask          cpu_mask;
>         int                     id;
>         int                     cache_size;
> };
> 
> Each module managing a resource decides what extra information it wants to
> carry in the domain. So the above structure is common to all, but it is followed
> by whatever the resource module wants. E.g. the CBM masks for each CLOSid
> for the CAT module. The module tells core code the size to allocate.

hmmm ... what I am *hearing* you say is that the goodness from the
rewrite can be added to resctrl? :)

> "cache_size" is only there because the cache topology bits needed to discover
> sizes of caches aren't exported. Both the "size" file and pseudo-locking need
> to know the size.
> 
> It's also possible that you may hate it. There is zero sharing of resource structures
> even if they have the same scope. This is because all modules are independently
> loadable.

Apologies but I am still unable to understand the problem statement that
motivates the rewrite.

Reinette
