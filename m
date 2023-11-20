Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A127F2035
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjKTWZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjKTWZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:25:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA7AA2;
        Mon, 20 Nov 2023 14:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700519108; x=1732055108;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kCoHWLRUjCz1B33ze0bFZznqL42nderpCP7wNidrXDU=;
  b=NdIKiGcNqSbqRjS3ibtau2GB/6G9OyPO1d/WkzCqhIUP33K9M968+ZWx
   1jM89PLpz6eBoz6Dc0v17ltVjB1SgGPtSxGhBnsSWCLfV0ZJEDQGEeuPa
   47d9ygolbRt1bPxALUceqn32Ihmw8LATSmJ9zgcr5kJ0W+CLTkOUtsoaz
   TETp+XAl+Nkp6/arf0N7v74ikS1iq+FLkusUqIC8PmITCTQ6X5e0dh6Hc
   G2y4Tij12yrpOCCua1i7CPR5BQ4JOLwWWHCecE+4yHNSbpooHsfF5EOZz
   O9v6IjQrHvlFDJHRP0SmDZUYyN+2v2opi4noH46CTgvaf3C3heKVDh7na
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="382111426"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="382111426"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 14:25:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="890066447"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="890066447"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 14:25:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:25:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:25:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 14:25:06 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 14:25:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H58HBih9YFIXdJASuPP8wJemPryLXFN9xIURrYqMeuhpg2xG7Pek2R4vqWRST7+ebEhNeiMp5Y8+nnkNiKVIppNwUttzcKwfRj0W1b5OJ9nJGifwqYysxzBirnd5AXY0FLyXohrF+ExWVNtvJcCEMwmYTXG28ZPpcZzxcMa3s0xDFOUKJcgtT9//93jDe3PgmY3inkjNWVGtTDlmKpf4kYIQrGr/A0obg4GXmvV+xnQ0LI4s70vfpzlV61gJuldGB4a3Dbn5MCxVlJ7h8FttajpCEAehblYpk4smXBMRx4frvgJYMf6fuAf5CG9PYtwpZsuDexRy+038ufbdkGbhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rv3bq2Q6KqL7chaCSowhFFSOrD49BuSUGclGtte3kTc=;
 b=f7BShk3lXp+j2/vt+RnxRERnb97Cq4V4LJazWZzEwrH47JLbBea5A/wSSzno/hHO7hszc3qdKIMDmQ9FaGT6vuhUsC5jLkqDcgHirGEdbHAi99eZt7TZ6W/vOg+mQSbIZvcQjyNo/JJiriHmuNj3ZYyUfCK6kL5IOo0UOV0P4DexDYWk7lt6WVBfLa35/U9cGFN3ZXIDIiuDm+yQ8ZkGey7eFHUix9wkOjA7T7P/N4VTwudgP0gp529Y8HxtPu53U5tFElfbha0KkwRH5bb+Xr7O2KmjYIkAhzpKRIHiA4RislFVx8ClxseZsvXkEPTwQWQGNsQT4U/yKejQk/W9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 22:25:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7002.019; Mon, 20 Nov 2023
 22:25:02 +0000
Message-ID: <8d81fd6a-a4d7-4dc2-a99d-a2631737a18e@intel.com>
Date:   Mon, 20 Nov 2023 14:25:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/8] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Shuah Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20231031211708.37390-1-tony.luck@intel.com>
 <20231109230915.73600-1-tony.luck@intel.com>
 <20231109230915.73600-9-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231109230915.73600-9-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b11041b-fbb7-464a-4ad8-08dbea178a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/MaYhMUraPfbSx1F2koeeO7respTLp6snN/iE8nU0Kk773XosxRAQpNgnTS1u1Cnd+d3fUqFljC5xHZ7T1N1KaEPtPVo1H5PlCwkSmfWGG2xKtNl7xnUD0m7tc0iBpdomJFCvngPZ85QCBd5sBSnOf4tIjVObWySxKCGQbrjoqRh7+QauVblFtrx8ydw2nXVFU4J+MmSpy7YY9IGLCikXRAoW35/hKuuPmjk2AoDa57RbVKXo8EKpSEMmsxSWw+CFMeW13ndUH9yvEc0Ml1lErg3jNGYi1WehZ8I/Fzo965hf0IxBPv01NkdX7kxyxbCzyGZiSXZMxn3TDmJzDNV9n13B2cQG5iRC4Psm0FPy1ga6YgwMXOII0LgxjIJZHMuWYIIU2fJm07A4jFDe5u5DFPh3BaWeWb/YJkEV1VqfWfn+CvAfC+Y6FoHAXlA65xsAvKBFsy/mPq7g1Y7AX702uPEn/cVWUjZpiLWOnKKyHKWO4m5SqmeAXsBCz81qq3QXRXx9WcOIiSCs4R/4jSzJZyb9BRAGPB+fUN7RpHM0A+CF8ZyWJfTEfS3de/hV6XGdOpe9KD9NJwSXHiMIkQ2D8d8zBA02Lfk1BxM2yqtWdf3TH6lZs+Afq2oGNSR1CmdcwsEfAsKDCFOiSbd3IQUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(39860400002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(6486002)(66476007)(66946007)(54906003)(66556008)(2906002)(41300700001)(82960400001)(8936002)(8676002)(36756003)(31696002)(86362001)(5660300002)(7416002)(44832011)(4326008)(4744005)(53546011)(6512007)(478600001)(316002)(6506007)(38100700002)(26005)(110136005)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGlITEdhd2xsaDlRYVRmUHJETTBndzhEOWdEZ3FKaVE2WjB3dEtpTjY0elZx?=
 =?utf-8?B?dE5CYkQ3eGRjWkpqenZTcHZoRlk1L3BmRitGK2IrMXhrd0Y3QUI3NVY5Qy9a?=
 =?utf-8?B?L1FDWXMwNXBYZElNR2tXWFlXSUN6VGdXRit1T1NTakF5bmw2Y3g3M29nVW1V?=
 =?utf-8?B?K0J2aS9IMWNpc0RleFZwM0lDbERtUzNNZ29mMFF3bzFTVzJndE1GTkV1YU1P?=
 =?utf-8?B?SFJFUHFwbHVZWWUzZ3Y5V0xoTm91OWNzb3N6YUozK3cwdkt1T0dXb0YyMXp4?=
 =?utf-8?B?M2l4amxoSDBST1JVTVN0dUxlU3h1Zm5yZnpYdXllaWI5S2RJRU1vT21tN3pw?=
 =?utf-8?B?aS91akRaeHE5TndvNUpONnFXYjNxWWlxRHVPN2hjMnpZTnJBcktGRGdrd0Rz?=
 =?utf-8?B?RDZodWJGNmg5T3l5TW94NXM2aWkzVnBYTHhyeXZHYzRjVkhaSUIxcDV6Y3BC?=
 =?utf-8?B?eTF5WXY0Yk9RN1ZtRVQ2aVhOYTN4WHZ2V21TUWoyUWpOcGlIZmJLZ3pmYWp0?=
 =?utf-8?B?cjltNGhEWnZ5UDBLNWNuejUvelZ3RHhaaitScUtTQWJEUFRUSU1KMHpZNm00?=
 =?utf-8?B?ZjdzaUV5WlNUZDE3cG9NUkJVUmhReGx3S0dKSlVwaHBncDRJSU80bHhhWTFx?=
 =?utf-8?B?OWNWdms4Q3JMQ1lKWk1IeTYyZDZZYXo3MklTREdxRUMwamhZMVhDZEZjTVE1?=
 =?utf-8?B?QmVlSGdNOHkyRHlxOGR4SmdWY3BaNmEzektNaGNoNWN5YXZFYXJodDBWVE1t?=
 =?utf-8?B?ejFVUktvTWZjQWxyeGRiMExjckc3NERDbFUydk1WVEJldHBGVW5kT1NNNmEw?=
 =?utf-8?B?c0lmY202NWc0VjA5YjcrTmI3anp0L2ZCVFUzZW1CeWY2Wm1XY1F6dkYvUzdK?=
 =?utf-8?B?Zmo5amhKREE0WHA0SXVnejB6Y2xORmY1aVBZZlMwS25WS2lrbG5UYWhDSytv?=
 =?utf-8?B?SVJ0aUFXSDRoYzJSS2pUQitQNnlKOGxpRnF1cjNYSC81ZktER0hHekxEMlZ4?=
 =?utf-8?B?T051dWdraW9qeHFtRjAySTdUUENVUVZXSjVjSlNuemhxWE1FUTlpV3R5aGxF?=
 =?utf-8?B?eDhsS1dTUjdNVWhhUUFwQlNvUkdIYTJEbldYRVFsK2FjdTUvZkFNdEJEMUFy?=
 =?utf-8?B?YUVRTldveWJaNjBEV01NdjdoNlNPWGZXNy8wTmlENFRQcVlYZ2J3R3gyRFhX?=
 =?utf-8?B?c3pnN2M5aFVxZTg2L3VzQndjdmd2UGxtOXhDMEFMdXBQeDRuU3hBbCthWmND?=
 =?utf-8?B?MDZXclJZcXJvb0ZQbkh1YUU2MC8yeEJuZDI0cHlXQXd3VFNkSTRYa0x1cFpV?=
 =?utf-8?B?ZFdOeEFCMkJNR0dHUzJpcEU5SE9QQ0VROXFEY2hWSnErWGwzaEp1bjg5ZWtY?=
 =?utf-8?B?c3YwRmM2Yi9ndC8xWDQ0WEFvYitFa21xWjhtUFVmWXlha1RSWGtxUjJRcUY4?=
 =?utf-8?B?dGlHZEl1MXZEYWZpd2pUaS9sRC84WmJueGpUU3NJcnloQTB6bFVsMjNnSjUx?=
 =?utf-8?B?QVcyMzdOSlN6a0NZbk10Um14TE81VTl4QnYxNFdlMHV6V2lRTHhGbnM5bVky?=
 =?utf-8?B?T1BqbEphYWFSemNrZnRmSXRwZWIvdzFtYUoySXFFeVZDNittUlZBWWh5VHUw?=
 =?utf-8?B?MkJxYlNBQjZsYkdSSlJQZFFOQTFRWTIxS1hLN3lRVXk3Vmx1azRGbnljdnZu?=
 =?utf-8?B?T0Z5Z1JvSFlXcDkrVlM3Z3dKVnFTU3NhNGdKUnZpSzR5MDZQVndqakVhQlV2?=
 =?utf-8?B?NFJ3QSthOGZYOGxSMjZ6T2thSEhpamdDL0dhZUU0WDBsUDZ0dVlpU1d5ZS8y?=
 =?utf-8?B?VDIxNE5GTVRQS1FYcHBhdUc0bW40dmZLMzh5aFRuZ0kxbmliR0xkckU0SUlC?=
 =?utf-8?B?ZTFJZ2lrUC9UaExJQzlYVUljWGY2NVNVWG92cFdqY1FqNUg0MU5mNUFJWHdy?=
 =?utf-8?B?cEVUalhydzJ4K083Vkp5VzFaOHIrZ1ZEbG16RloyYWtLcnpjdnVpSzlWRkVK?=
 =?utf-8?B?cDIrbjZwbEoxQWEzUWx6Y2ZvK1pwOVNKREd5TWloeXU4aXM2VzJtcU0vYkND?=
 =?utf-8?B?b0Q2UU43T0tWOEg5cGdsUHBzd0VsdGNDMlZ4SDRyVEtuQjN4SmRnMzFQbGti?=
 =?utf-8?B?b0pIWWRZZTdXbUt4em5pV09CeWozVjBOZ0l0T0JieFB2bFhQQWNyZGp1NjBl?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b11041b-fbb7-464a-4ad8-08dbea178a09
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 22:25:02.5506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J02f4jyh6bPZV1UNUc6kVbMT/glYCcYEbHc/dXucWcxELDXWSTuD/lwC05kdvN6GEbtRdNuRSpRABya+oKZdXvrNqker31gpZ2iz1Rp2DAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 11/9/2023 3:09 PM, Tony Luck wrote:
> With Sub-NUMA Cluster mode enabled the scope of monitoring resources is
> per-NODE instead of per-L3 cache. Suffixes of directories with "L3" in
> their name refer to Sub-NUMA nodes instead of L3 cache ids.
> 
> Users should be aware that SNC mode also affects the amount of L3 cache
> available for allocation within each SNC node.
> 
> Reviewed-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---

(note about order of commit tags)

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
