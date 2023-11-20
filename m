Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37B17F2018
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjKTWT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjKTWT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:19:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A79FA;
        Mon, 20 Nov 2023 14:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700518763; x=1732054763;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N3G5IuP+nmBL/lozX2Th8fz3/z0K0h5qolwlverP+s4=;
  b=jy8GQ3mbTj4C/8aOyPBtWPtmqfZZYF4tyI7XGVrJsIPRnKd90V0aC2of
   UQrCqhSr2kfjaOAJkTG2HiDzzhJfY9GEZ0gOkm3hhACZsMjaYb9oHwPJR
   K8JiLtSw7//hBiM9I8GD5zFjW8yZG7E9gmvUIYubGuYv3U+iF4OnNUU+1
   fdNCJAeJ94R7n77usKgT0eMuTlcsQ/oNygz/PiSjpvXPEOlhwBaJJlDc8
   cYdWKa0eA29mkKGLTS69uaNPei6NUS6/0dyNP517wUsUcjwv+XYoiVHhJ
   D7nUG4CVwTiPlEtuptWHK4gWFlksjusIR5N71nvPuaQ35N6UqdNOkhgyP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="390575127"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="390575127"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 14:19:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="939910698"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="939910698"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 14:19:22 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:19:21 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:19:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 14:19:21 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 14:19:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cU9wjuIpGT8L1RYlP8Je9ZGm8i1cZifmBIUwXl41xFpFEPDMM14trHbPnbynZlSEZm5ygMbPYfPMEdTHEJUoxu7qr1J1mgzB0mvArMbUrqCHCejYK70tStBfjYeOYIBQsazn0rHWPR+6q+KZEGXw51O3iB/GwblPBtFIiiHVqwXkMtzB4O3s7FmKU/xQ33XEG0r2NG4eX7vjLEWgn1EOCNXhV7/WEes1aXsSlWVNE/jF9Ebl148EILlOpAvdBq70S4HJiCkCQqinG7cfiJhI8PvpOMX9I5eCy/Ec1CeZYyDUnWqU+hgUYu0j6wyombetCtu3UbtSZ2Cr4HVEksOCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArHoMcdW28B9I5+ITbrti4e5yTPviD/KajcTXnFexcA=;
 b=fYS6PNwox6eG4zb2snqG1cnuM2MXVDAiMPFUWUedDTOfjOnUHKEj7qrk0/yUu6k39g4TuZ+dceRaf1Iqb8jfrksn8XsJnOGRTCRgnU6AumVcIZeWGiC4cTOge32GgaMcKHfd1OII3kih3gXpxokobWD+DqD4alKYIAn3gBjDQfct0wFED9mQ7yi3nt/jLqZkm/zqgPpIxoEPgBOIICJV7Ahob/LbNvIds5tBOxu4duMLH2IiGK3o2MPnMFgQ7+9wgjvIzI1l5fUTv4xqvuGDLKVN2dMbZYuowAUlIKx2Ju6ftgQes05GQefMcOANMBmRz60+U+9wTZnVL+KHGAnerw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4678.namprd11.prod.outlook.com (2603:10b6:208:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 22:19:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7002.019; Mon, 20 Nov 2023
 22:19:18 +0000
Message-ID: <ea33eeed-e3a7-47bc-88f2-b7ab46be0aaf@intel.com>
Date:   Mon, 20 Nov 2023 14:19:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/8] x86/resctrl: Split the rdt_domain and
 rdt_hw_domain structures
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
 <20231109230915.73600-5-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231109230915.73600-5-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:907:1::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: 788f78e8-6e5e-4469-d7b5-08dbea16bd2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5yIshYJMGTmjJInkH9yhj4+kbTiC+XO/DU0lm1frdzqxFFzwomWhHtk3rRGCjOtdAqif8UomUNIImPUiXJXbB1WwULwlULHztQt0onRgBnJ4BQvHcgOpMzxWFObUDYGJU7Q5L/Yh84ctI+ZDtE9Ln4h/ntjQpWCINfjljHGTU7KyC2xEM8oTqOIlN47NqLap8IOArONTUpXzdFTrIZQoPIBwzAV6BNUv8sB9MrOMEpF0FQciVUgkCGp1ts5bacR+dG4d+hLhs+szi1aiyx741sa3ZjfoMZFtQ47S+UOAij7cxIOZatg/lXOLONE+lwbFAwEX1Z+ShnAottePdFfhSnE1nFhOdYP3/OE+gki1AkVrw6COeSK1R/54hJLWLFpv0hi4IxgILFmQqRXZ1N3OMBrQ4yrRTCXAkp5V4WG7ncuM/Wn19epo0r79nPvsp1bT0iiaLWPsRl1vvNxifQvYKIMycdqSno6MaqglkR8LyZjpy9bxb3YPkJsTX58pwzGPjKjA2LRMkw/kchyK2+MSwbGPHasldSGL+oS3kgprBJ5+mE0lOVa+LUw6IPyV7V5dT++9iRhOpYZeAE1SV0Q4wWryiEpi3kHZQJlbAgzQvytwuMkKdUf3HHFXkD62L27WYyEAR1wtVCJveXWcjYw21g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(44832011)(5660300002)(31686004)(2906002)(4326008)(8676002)(8936002)(41300700001)(7416002)(4744005)(66476007)(316002)(54906003)(110136005)(66556008)(66946007)(86362001)(6486002)(478600001)(6512007)(36756003)(53546011)(6506007)(2616005)(82960400001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wkk5QnFIdUNyc3JQNUVIbXc4MXlIaWp3TGl5Y1AzT040dlJCcDFzWkp2NUlN?=
 =?utf-8?B?WFRxdEhNUVd1VDgwS3pLOWJ2VlpYZDVNdVFVWFZyQXNpOVNXZ0RVVkwrd05i?=
 =?utf-8?B?Und2NUZ1c1lvWnpPUXQ1dGVTQlVQaHVNUjRodjQ1WVRlSzRsalR4LzVlNStv?=
 =?utf-8?B?b1AzbjZPZ05kM29SZCt4YnJQV244dll3dTN0QkZQckFNWmJiZUZuWXdJMjNM?=
 =?utf-8?B?T0hjRTZhV1Vwb1QrZEhNdFlzVjFBK1hudDFEcWYwblh5VE45M2lkVWdWWW5N?=
 =?utf-8?B?NDVYT3VrSlBuSVo0ekxVNHBQb3h3aDFJVG9mNUxiWWsxWlV4dmk3WUQwWVNU?=
 =?utf-8?B?TUNIbVJYTDdnWmpHQlplQmYrNWs5YXlpcFMvWHFFaXkvcDBrQktKZFdEdSsr?=
 =?utf-8?B?dVVIUEEvbDh0bFB0aWp3aXdMTzZTeWJCYmoxR1M2NVNTOEd6OEYzdVJKUzY5?=
 =?utf-8?B?dm4rVXZCWjJ5UDIxMDZwNHN2YzNvRFFZeDRpUUI2ODI3bXl5TmVJS2xEN2RE?=
 =?utf-8?B?c3lPcmFhWGdqbDdJSUdabDFqU0ZqOGdCRHBQUHYybUNweEhGTHM0NkpzVFJH?=
 =?utf-8?B?YmdZeXRJS2NkZXNzWFltN0d3RUJBV1hIRm5aYlRJSFV4Ym9FR2YxKzN1Nlh5?=
 =?utf-8?B?TU5yUXNWMXNzNWNyV2NVTDh2NnJ5MDllaUozRFliRUJnWUxzTkdVejhGRmdL?=
 =?utf-8?B?YWYxc1ZHbS9yMDFrMmZXc2M1cU1TeEIvSXNURlE0NjFiVnZFRHJlTU9BMm1Y?=
 =?utf-8?B?bTVWVzRWbmVIcjdYSW9CZzE5NTVBTUNQckVGampJWXdYcWE0dDdyUS82Q2g0?=
 =?utf-8?B?Z1NaYUJLY3hvTk1VWXBpVHB5MDY3dDNqMXpGQVBuUmxLWVF6QnpKcjBqM1Ey?=
 =?utf-8?B?K3Y5RTRuWEVQK2tLS2pLYzNtYkc4YmdnQVVORTVSMzVxRkVzamF0OFl5UGhl?=
 =?utf-8?B?ZGJ1ZkN0ZFB1U1c4Rlh4K25CeU9kTkM3N25xSUxkZEVsci8rTXVQcTE2WHgr?=
 =?utf-8?B?WGNCVURjL0pnM2UvSDJZMGtxUldkWUJaaG5aRFI1b2sxbVdLM3REZ1Nhdzcx?=
 =?utf-8?B?eldJRnhieUs5NU95R2tDNUxNS2dWb2NZSlE0S1FXakJRM04yNHBGUUhjMVNy?=
 =?utf-8?B?S25YSWRaSFJId2E2cG8xaVJZeTdpeDZKUW1EOHY1QjVvYnRsRnpyVjI2bCs1?=
 =?utf-8?B?SGhkNFhTbk1qNGxzWlFZblI5bWZadVZ6TVYyd1V2VFBBaG9ubk1yYmZmdnNR?=
 =?utf-8?B?NTFjUzhCK1oxdG5WUlpWaTBhQituN1BIUVFyOTNPaUFzWnpZZWRRUHhiYTFx?=
 =?utf-8?B?UDlRSHBwRmE4ZlQ5YU05UTd4TWR2YkI5cERGZEUzQ1dHeHBTYW5wZkxrYzRl?=
 =?utf-8?B?Q2tGbFIzbktKTHdITVkxUzBYSmw4UzFJdTJCcC9zNnltdXdWcm5JTFpRT3JH?=
 =?utf-8?B?SFFnazF4NkhXaTFvREJhdjBOVFloYTgwVWxZRWJPV1lwMXFWcFFyRkxWd09Q?=
 =?utf-8?B?eWpta200V3dEWXpDZXhvZm1tS3ZxUjNOSEc2OUpNSStRWjQ0NGlzYmplelNi?=
 =?utf-8?B?cTg3TkMxbU5XNFROYTY3TjBRTW41ektiNWxpZmVsaVcwcUVNdWF2QUNnQ3B6?=
 =?utf-8?B?dm5kQzE2Mzhzdy9mSWEzU1lDdUFOMlk4bFFNc1pqdTVWejdXR1FHemp1V0t4?=
 =?utf-8?B?ZG1lZjBySmN3Z2ZjMktZc1JBeXZrQ0pjdDZnVXJRN0JNb05uY01OejZTbDg3?=
 =?utf-8?B?WEtpYTZBby9RM1BOL1VBSWJ3RmhkeE1tT2E1WVN1T3U1ZmVwaXZnL2FYbUt2?=
 =?utf-8?B?bDQ3N1V5MnVjdWdWUzdsTitoT3R3RlhWK2ZQWVNzdzBCTWFrSDNTd2taSm5Y?=
 =?utf-8?B?MlJmc0gyblByVkVmem5QYndxaG56aWtnenBjZnNXYTBsRHNtRys3REtCSFpE?=
 =?utf-8?B?Q1FkcmRDOTQyV1RXV2QxaVlQNEJEaVU5Ym44R0RVYnZieFZSNWlVV1BKZTRZ?=
 =?utf-8?B?ZGtYUWg2MVE2OC9BemphT0dJSUhKai91OWlQL0Y5dTdQMXFlcXM2T2ZwOVpk?=
 =?utf-8?B?SGkwUVJjaUFpcmJNd05OaDFPQloxN2hrcllkVXJ0aUd1R3dvMytrVTRhd2ZF?=
 =?utf-8?B?ZzYyaVJsVUlrNzcyRjZNTjg1ckFjUVZ1d2xVMVZNQldWcnM4ZXZES0tQYUsz?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 788f78e8-6e5e-4469-d7b5-08dbea16bd2b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 22:19:18.8127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bEdQHJOCKn8W9RPbWwZ9KDG80+7i1G3cYFxAdWeQStBk8yvGGwW7ZLPnSB/QnTesjg5glfnxPO6FkRRoToc0iB9RsaS048kDFBePEXn8ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4678
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

Hi Tony,

On 11/9/2023 3:09 PM, Tony Luck wrote:
> The same rdt_domain structure is used for both control and monitor
> functions. But this results in wasted memory as some of the fields are
> only used by control functions, while most are only used for monitor
> functions.
> 
> Split into separate rdt_ctrl_domain and rdt_mon_domain structures with
> just the fields required for control and monitoring respectively.
> 
> Similar split of the rdt_hw_domain structure into rdt_hw_ctrl_domain
> and rdt_hw_mon_domain.
> 
> Reviewed-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
