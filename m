Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AE57DFC09
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377433AbjKBVel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjKBVej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:34:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC34B187
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 14:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698960870; x=1730496870;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZfId0anUk7YT2oi0vHqPF5IFuSxycbbn+xgw4zCm1GU=;
  b=L3Fu+KeSmoVWtYcZ9X/aRrVTd905h89sxi3AZSBPlZSEOervlQmDgONn
   KY/bE65gxdtTN/MqXFIFg2H/SWvoFWEO/6/BlROxoE5l0P+ck275Ct0U2
   KRg6rDNBCjIedkB0WipohSn8AEUe+akfk6G0+tQiblSgNzrSk9jvNpR9h
   wY3fpqmq1uwiGH7091cHlaJPHe3Hx4icfOLJL74Tau+hdHt5pZadfiX3a
   bCW48twHm+yrBhN4c71h9z54q86phRdbt5qBInfXdfOMv9Czus+TgTtYQ
   vjnJq7EUh8SmiN/2+EESMiden9nxdwMEAVGd2QMhAM354JkXMK+4o4rNM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="388646433"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="388646433"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 14:34:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="2586547"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 14:34:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 14:34:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 14:34:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 14:34:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nU6Ccqy5m7bnv9H/yrJ9Ivl/PElPmIk2o4VSTe98MvauXqOG3Lx7U+iqdAcf3DuuzyxzUWmlYEA8HubBKI32R5rfA/LgQZDbUoqzlON6FErxW+dNJRnmbXYBehFzxCZiS2tKfRsbTOkIS2DqpD9m3jIkJB7Y6n1eBz5HqlwhLcq6BG7dzQOvMrTFXlusD++mGpdjYOBf48Vw1eQNba72/zOV0ADlk1Wrww6t1rhV/Pkkjz6d3iCmlHB5k+0NdI1pvzeM8MoZ6PxwfPKLXHHPPWrMqKWQrGU2QxhhbYdyUFHteagMNwtbBAF8l/tHgKjuVg64fLkZvD+Nt940ceUsrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/oqaeTtKdrBnEHlK+tdoIhg6j14BL6+9lVjzOEF6fQ=;
 b=I0G19rGL5ZFaP7FIImJMzPOxgujvTk6v/yug0CpRORsMTGnZLzIaGPbLb35PXA5alaIeBrwH+SvZJprGwZDLAtjllVFmMGQa20x39sa7fG+wA30NDkSo8W09nVma6c2I7bV7x1GSkcNn+D026F7MvlYiKZkw29QFndKG3lOE9jOWe2XYGJdz+9CHLGNrEE0N8T/JMC7L5KxMBuXwrZkr83yjWuuv+VXRCM0UUggUkxK/1Oq8hYF4QZ9gmThIhKwWu9WrEsXXX1ayA8mb4ogl/FUkVg9kU49AabQdJZIP9MXtBdnTTlxl2RByUThzLczpl6xNoX8DHhUTRcqRhj4Grg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO6PR11MB5619.namprd11.prod.outlook.com (2603:10b6:5:358::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 21:34:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 21:34:21 +0000
Message-ID: <3ca2b0ed-6732-4fc4-a5fe-1846b873b02c@intel.com>
Date:   Thu, 2 Nov 2023 14:34:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/resctrl: Fix unused variable warning in
 cache_alloc_hsw_probe()
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, "Moger, Babu" <babu.moger@amd.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20231031220534.37730-1-tony.luck@intel.com>
 <d47235e0-7ecd-483e-82c3-78f13c77df67@amd.com>
 <SJ1PR11MB6083C14236AC0AFCB49DFB15FCA7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <9e6a979a-48db-4b25-884f-ac8d4c2bb078@amd.com>
 <ZULCd/TGJL9Dmncf@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZULCd/TGJL9Dmncf@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:303:8e::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO6PR11MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 323f930f-4f46-4b03-550c-08dbdbeb79f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfy6H9rN3ILAhfhaj72TVdqoG3m4Bj5kLvkMB2n6pzQE0TCvUM/64hPwake3AtE+nZjsA6nn9lYxt8hohlibZI/c5TOUarnXS0NbvtrRep+d6Y2duyqe0efzqG+QI7li2rAWYRTMfZL59t5bkSG6bTXUcw+5q9HS79R99O5lMZMgIQ0P98WG5cNPWkbbbK/1NU8wVyJQ7t+kfz0r/pIpaL0W+OLQSj4fyrvm4INPUqS8eIafYUkQD95IHyPizCcGj3++MQYAmo7rGbzGGjgcW9ZESa8c9fpbZl49Y0q1su6DIwDCxjE2EktsEdd2fZihEi90cd+054q67Tq3OjCzlQz8G6R4I1y2JayJ2RC87jDYxwBMVdWQs6DcaVSodDKQzW5xVSTv8rLBv12SSC6zrL1BueDWPyVlUym8VVc399xakFiH1/7Y+UWpNhV9z9WBihvc/+bHwOuQWEkEhBx/IH/wc8iYKayArYkAHztA9axr4krkSpmKJ4AnthHVYcFqr82LQDaPngh0uWD9yHR6L5NACtplEdmCwrIpC+IOyW3G6QuF/rAvkqnwrMe3Ma1wwC8AXIjU48rhFidKm//8MsCQkEf9YpxtioS3G2T5bTi54AK9I8d2CKbYZqqHDp5mD5MZwBe5ndFQ9HYaPa+onZrZqtifrKxB52xUIyqNilguQIeYOBCTMd1u/afUfzXV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799009)(8676002)(44832011)(4326008)(54906003)(316002)(110136005)(66476007)(66556008)(66946007)(31686004)(5660300002)(8936002)(4744005)(2906002)(82960400001)(83380400001)(478600001)(6486002)(41300700001)(26005)(86362001)(53546011)(2616005)(31696002)(36756003)(6506007)(6512007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzBER0RHNlJoa2tGV1RPUjVsbk5tUGJCYVNJSTg4aC9GRnBHam8ySjVhQTRv?=
 =?utf-8?B?c1VkbzVLTHFJUmEvZXBZam1TK3JyNXRmSmREOHpINmpnaDdPUGhtU0hyd1dm?=
 =?utf-8?B?RFA4OXNqa1hXcTBlYTZycDRxQTRTbzRhdFpkV3h0aThzT2NhVHZwdTB3cklO?=
 =?utf-8?B?YlNwUy81b2pSYU5QU3h2aFY3VHFHNjhBQnBMRnA4VXMwQzZwTkZzSTFodmtz?=
 =?utf-8?B?Z1Y4SEp0dlpvb2hndmRZTWdrMTNDdHVGd0lweEdHZ3oyYzZWanYzcFFwdVRD?=
 =?utf-8?B?U1Z4WXp3bVNONUhNeUJ2WGRuODRkYkllVWNhcnhjb1NlVFZpYzN4Q1M3MENp?=
 =?utf-8?B?SGEzVjhub2VNbThvNGxnbzZNcnNwa2gyQ3Q3YWp6V2Jma1BnN3pEM3JUVlNI?=
 =?utf-8?B?eE4yb1VJZllsc25nM01PUnc0VCtqd0xoWE5xR0Jvb2tCTU5JTGxUb0E5alVq?=
 =?utf-8?B?QUZIdzF1Z1QzYloyNjhYaFRpeGNadkhON2ZnK1NZN0hvY3M1WWdEWDNQSzNk?=
 =?utf-8?B?UW55K0lnNVkzcDJFbDV2WkdUNnAvT1NVWm4vSlJha3lTTkZRc0lsV3BncUJy?=
 =?utf-8?B?WDhLbWFQc0NXUlFFUzFtZWNSenlPa2dydkVCRllyOTZWaTlJOCt5WndONk5M?=
 =?utf-8?B?K2ZON2k4N2V0ZEliMWk1V3F6SU8yeXNETitmcFg3UlpFRmZsT1ZrVy9GbGVu?=
 =?utf-8?B?dVRDSERQanF4YitSdkVBa3lFUWkvWFVYdVpsS0d3Q3NocHByQzh3VVZqSTFI?=
 =?utf-8?B?RTlQKzNnWnJHK0txQlphU1MwWko5M2xMQU1aYVNlVU90d1VNOUhlSStlNHRL?=
 =?utf-8?B?MkpiZW1MM2sxbCsvNm15dFN4Y3J0K2FqVDBac3ZpdmJKNGl5cUtrSjZ0cjh5?=
 =?utf-8?B?dzNYUUc5V0NZMG91bnIzU2VxT0p1SHBXcnRQd2tHeXplWVJrUjQ5TmZzWGNR?=
 =?utf-8?B?NDVHUWxSK2xsYnk3b21oZUxuY3hDMXFSaUFmWmsrak52UGVoUnhiUDNhMnNM?=
 =?utf-8?B?STJCcXBlNTZ0bzR6SkcrSlBnU3JwOHU5K1JRR1VnVDZIajM2NFNLdUhyTk9z?=
 =?utf-8?B?Y2VoTEthT0c2eUd0UmpwMGpKZjViOWx6OUsrYTB3YnMwbC8zem10N2JvbHlF?=
 =?utf-8?B?bWVLWDJKRGx6ZWFhaFJ4ckdKVHIxWXB6SnFGNWZLR1QwTU1KTGxXR3Q5WUVK?=
 =?utf-8?B?MzFKSmVvTGZYWmQxenlMTmJRQWszbFpKRWRsNFQzUXNBNkpvTTVqUEdDQ2d5?=
 =?utf-8?B?OGdsQW1xSlRSZWEwYXc2RzhPNCtSLzNrSVVGeUl5VGcxYkNYUys3NDNUT01m?=
 =?utf-8?B?clNXY3EzNUlPL29qMitWckR6VUpVdUdDN3JiNE5sdk5wOUl1STRpY1VOc293?=
 =?utf-8?B?cmtEeU8rYlpSTGh1RUN5NVc3TEVjQkJIWlAyd0pkWFNwOHowTnNmc3U0SGd5?=
 =?utf-8?B?MmczdHk3M3UyMXUzcENvVjVZYnBZZ2RWVzZ4eXNEbFlDZGwwRWw2RDBNWmFr?=
 =?utf-8?B?cFE0b0o3QVVzMW56WGx1SzFYQjJ4ZFpQWXZWcFpQZGFwd0dlYjRCS1RPUUJt?=
 =?utf-8?B?ZWVmNW5mM3kyRnB3ZkhjYlg4UVBIQzkzd3lXYWc5T284R0FhN1djVTZWZHd4?=
 =?utf-8?B?dEMzc0tnUmsrbWpJNGF3djFkVUFsRjVrQXVMUFMxUEIzeVZQdEFIK2pNN01v?=
 =?utf-8?B?eXlhZ1FpMkNQOU1ud0hNa0tJTUcvMXNBR2hON3ZVT3pjZjJtWUc5ak1CUjNv?=
 =?utf-8?B?elhOTVNxRy9BYjJMb3JzV0NXUjgybGRDM0ZMcnU4K3YyZDBtVWF3ZmEvYlVK?=
 =?utf-8?B?N2gydERiQ3JvTjFvcDE2MElSR1ZhSmZhWXZkMDNRM0RmUzkrR1l5Y2FtbmZM?=
 =?utf-8?B?SFNUV3pDTGFxai9DTVM3VERkdzFQTnEvUGlqQmhlb2tibHZ3eGJXZDl2TVVO?=
 =?utf-8?B?RHpaalVMNFBjS2Urc01hQVBmOHF4Qy9JelBCOVpjWXRtMmRCT21FbHpuNVRq?=
 =?utf-8?B?djBuTHY5V0lsZGJhbFZpM0UrU3pIZjd3Z3ozcHdNVEZMa3pBZzA3SElNNmFw?=
 =?utf-8?B?R3ZGaUE1Ri9tYzVoWnJTZ2N5NzNWMUJ4YlBNc20zZXpaWWxDTG9nT3NadWlQ?=
 =?utf-8?B?c0FzUk01WERlc1JvaGJnNEtIZ3JOU21PTmNZMy9jNjg1N3lSTm1NTmdYSmZp?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 323f930f-4f46-4b03-550c-08dbdbeb79f4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 21:34:21.5331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDMFjET3ENiVpxhTgkTi82R8KZPr96/oypX/jY9+uD8GVOk1Ry2saI7NG+hDqXT4kjNeMxcHItpIWaRBqLj0DWsFGzLPgA/rzV/t3WBbZ+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5619
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 11/1/2023 2:26 PM, Tony Luck wrote:
> In a "W=1" build gcc throws a warning:

This is strange, I am not able to encounter this warning. Is my gcc perhaps
too old? I know there were some specific versions needed to reproduce similar
warnings with clang (see reference commit 793207bad71c ("x86/resctrl: Fix a silly
-Wunused-but-set-variable warning")).

> 
> arch/x86/kernel/cpu/resctrl/core.c: In function ‘cache_alloc_hsw_probe’:
> arch/x86/kernel/cpu/resctrl/core.c:139:16: warning: variable ‘h’ set but not used
> 
> Fix by switching from wrmsr_safe() to wrmsrl_safe(), and from rdmsr()
> to rdmsrl() using a single u64 argument for the MSR value instead of
> the pair of u32 for the high and low halves.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>

I do not know if all the text from that reference commit applies here, but
for what it is worth:

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
