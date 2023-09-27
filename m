Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CED7B0BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 20:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjI0SbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 14:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjI0SbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:31:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89BB191;
        Wed, 27 Sep 2023 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695839474; x=1727375474;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dR557I5IC9fTEH0DtPQ50IhOgvN91/OcUIKnCvX564I=;
  b=mjzmMNfAD5rljKsCxf72z38KO/Q7o9vtLFr+4kQGaOQTMkHrO6scv+9R
   BN4Tf7Rk1dkqTjS+NlgplEBSa/lHsHfqC0PCIew47tK3REucuXVqaXVJF
   /xSwUcOLUz+71s2+IE4w16m2i9UCmjtJcIAi475kxmRVlWWj3Ga8qnMZs
   aYOgJRFsP3rUj8iA8M6gzRakhmvmC/H59nx4KzKHu8jN2KCml6GbJLghd
   0PlkvtqgClyT38LhluQSuVME+2kKXtq+Oj8WxmgIJRjQ+rnbvMZYvviE5
   u/H5y8dn8qla1wEHPRj/zm5/nQELaIjaeP8EItaTNbJBpdtsUbpZBnFdn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="501802"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="501802"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 11:31:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="864945286"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="864945286"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 11:31:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 11:31:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 11:31:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 11:31:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 11:31:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPPQH8EsM+8vGocVLhsVRdoB7HCF/wLAvpla2o+XzEdebStqJOFbTbHQHo6asRt5yK+SIFVXpXdaWuBMEXpy5ZVwW3h90Nzcjbv8FG35J2F97h4395a9OcUIEFx+Xme+sfFwhf3S6w6IaTYGs+3AXTH8ECDdUxb3XWZ88+B2QOeI685fK7KJ/sSYYJ3BDUB732igMX1RrWKBMFnhrA6tSEQ/plDzJe8/1mhcKQFM8U024bab9EFl8Dwm03+m9QMZQpO0vomTTrPKgJYEFgJTbIoAxIZxPl+WcNFMnu87jSajAop+7wIeNHvtBO7vsJ8VjaYP6cO1sLlOyc45y+T4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ganT3jEcrsWvd8Rj3hHeJovyyth5ycHEg3JU4l3+RTM=;
 b=O8FzPE1HBZRM3oEjVfLxQTjFZYiSEx4izbYXmvyMqPn3Dh7J6FE7+WTMYI1oKNF7G4AuviiwMNndUzhLRcB1OQXE9ETfoGMHtJk1JPOIODmL42mtlmfFalX6jmTvI3DPWCeRGCDptdsUhd4OIY4HAA3KZqU3dIh0L4GuED1PZPl98GRLjLnvvmHvpY/YYlMrLt28ak5rIMc3luSZKKHZQ36XP4fZ24u4HCvfL4R3eEPuYYbnIbET3TwNpq5n/AdQ6Q94AdKlHFFCn9Wz62DgoT/dPPUOGy+B3B97Kw3Wb7bHamFFta9NN7XXnUt7ip7hByZPQBJhO/EvtCaneu7bqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5411.namprd11.prod.outlook.com (2603:10b6:610:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Wed, 27 Sep
 2023 18:31:01 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 18:31:01 +0000
Message-ID: <dc1281bd-68ce-18f8-e4fe-d2d07535f047@intel.com>
Date:   Wed, 27 Sep 2023 11:30:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v10 01/10] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
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
References: <20230915224227.1336967-1-babu.moger@amd.com>
 <20230915224227.1336967-2-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230915224227.1336967-2-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:303:8e::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5411:EE_
X-MS-Office365-Filtering-Correlation-Id: 1018301a-4885-495f-91c5-08dbbf87e663
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+Z5gdI8WMRscbSO8P3VvNpUoNEWmnKJFcIFhjV31DyYtnJlhy4gbaUl/3t2z2MCOGB8EJHVoOKVTM56Mm3PR2t/nhYpr1VK/jIqmZaNokDb+v9RwybM66w1q9MImsKL7Cpseh5O0Ie3dcD4dxsI4jAfJem3nBsXuDYTdNf9ewAfdqYZzkGzKCu/plBWC8bauuusr7HMzhTX4GIRHfxrt3IpUjfNtW4GuuiCS6iNUzlpZZ5lnvtnLyRScrqL5sqynGHi/ItHyAS/YNSfEQvnBEBkmoXgl+6S64vuZtydMHIQ7/NNsMCFNolqRcfK/reKMlP7tz4ruo+xXvK72CTSlsFL1fpA6yEwd8d2C2m0qLof6Yb/KrN+XqavJMQawhTxfS+HyOBgUM1PD0HsuvxnC0JQ/2tdDfm+Vmde3hpAHjwLHHY9isePyxDlYYQZmrseqlmgJJVvy9WqZYBLpx9lZSazSjZrge38eS4JadeqqRUDXTbV3JclWAh5FK5CiQj4KzNdlhYJzulMtwKN7S/qAmkmtdYOEborBFi7CxabuMTzKcVsMbJ6yuq/7Vy9uO5p4jcWI4LHLuaVXFjogJQIMU7tVmEEl4rP8camb+E00h3UblKMbFE6d42i/kvqXzho+ElG4DDraj+bhnI9RwAUCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799009)(451199024)(186009)(7416002)(31686004)(66476007)(44832011)(66556008)(5660300002)(7406005)(2906002)(66946007)(6666004)(478600001)(6486002)(6506007)(6512007)(86362001)(66899024)(53546011)(2616005)(41300700001)(26005)(316002)(8676002)(4326008)(83380400001)(8936002)(38100700002)(82960400001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnZQdklFbTBMMWJLenpQcmRFOXZyWG9lTkVkWXluZEZUTHdVemI2bXBUaFV5?=
 =?utf-8?B?YnpXMHoyTGp0TEg0aWlHOVE2TnJPRFc2ay9oc1lZTGNNdXo2aWk5RHYxaXk1?=
 =?utf-8?B?emFYZnVERjgvTUVkVTNnY3NoTWoyUEJtOWhSL1UrdDhKZXFjRjFOZjN2L00r?=
 =?utf-8?B?eDVCdzV3SWI2dHl3ZkN3dnVmK1hMM2pNejVYTy8rZ0ozYThsSzJKR0xyZzNu?=
 =?utf-8?B?S1pvMWNpSnBUMGV5QnhhYjFHN3g3Z1lvV2tQL3NhQlNDcnVWOXNXWm1xMUww?=
 =?utf-8?B?OVFmbzk0R1gyaGwrNkR6dTV6UEpDNFZpVkJueTNyc1RnWTRpWndldXZZbHhq?=
 =?utf-8?B?cWY1SksvKzhBK2YwUjhzRnhLUCtqY2hHd1dyTU5aaHFkUXhJdVJZQVVaL1ZO?=
 =?utf-8?B?S0JUZVZnRDRmQjMyMW5icGY3S1UxMUNPOXduWGt1bWFRM1pCb0dZY2Z5M1ZS?=
 =?utf-8?B?akJMSEdZZW5nZGhuYjlwMnJhWXFGU2VBOGFsbE1aMk9va2RVazNtaXdRSG43?=
 =?utf-8?B?V1Y3NmR2czRhNTV1TzMyVGU4U0VBN3hXa1pVdWNaNjJ6NFFvaEM5SEY5RnlC?=
 =?utf-8?B?OU1hRkFFWS8raURKTUJKODVlSHZmN1EyaEE2Sk1IN2d3dkVmdmxxVEFuSC8w?=
 =?utf-8?B?RWppOGREUGxpTFF6b2ZvTXhmZThGUnk1aUYvV2tXSjQra2hnazRZaFdZTUFD?=
 =?utf-8?B?U3ZGRjBxa01aNXI0LzU1NE1SWXFvaXp2WExleXpheUoxYXNaQTEyQ1JnTjYy?=
 =?utf-8?B?eWVHZ2lwcVArU2dSUjJsaTNpRDJRMVNIOGczZkovQlY4SjNsd3hNU0JJcGRx?=
 =?utf-8?B?QzhwQXhBSkRBTktlQlpMMHEvc3hVdUpNZkhDSE9Cdm1IRDA5Z3V0VklNNlpM?=
 =?utf-8?B?WXp5Sjg2cDUzcVdUckhUejVIRXFPZ0JMekYxYjlZRWlmaDBkdUIyTVpRUHQy?=
 =?utf-8?B?ektWRW5SWG9PVkplcGRVNlRPMVhWTndBeFJ6YlR5eWFBbnFoSUtoaFFzaTQ5?=
 =?utf-8?B?Z3lTcTc2QXpIUmpRSGtMcmtoUXJ2ZnV0R3MvRm8xRWNCYXpWV2FBbEFoVDN5?=
 =?utf-8?B?c0dpK2lBeVRzOXc1UzE1MnlQZVNWZUQ2UzFyNCtDdWJrYnlNZ2NFMm94VzdH?=
 =?utf-8?B?dGFFbFNnZ2xGT1ZTcEVObWJhVWhaUThSc3BET1JOM3UrWHl4K3hDTVZWQUhD?=
 =?utf-8?B?eUwxMWlpLzhjL3MwTDVpN2xzaW9tQ1dHcEEwcndiS3pFR2Myalg3Tkd3cys3?=
 =?utf-8?B?ekYrcFFVM1hVdFoyVmtoMlNIRGFiclVtOEpkSGZldHB6V21ZVzF1K3dGT2U4?=
 =?utf-8?B?ekVxcVlRRFZycHBER0plcjNoNHJ4MlhEeDV6azYyb1hpNVo0N1V4RWxCMXJL?=
 =?utf-8?B?aXd0SVk2RElDTzQ1MFdLdjdYem0vSWZycWhVc1hLSkJXaEg0OHFOREtNSjJP?=
 =?utf-8?B?QzNBTC9VbFNsQmROTTJMdlc5MW5EbDRnZzI1cThWZkE2T2VKS2lBUU4vNEZx?=
 =?utf-8?B?QWRTV01vVG5McTdVekVUR0dncDJvME5Udk9ucTFwcWxoalg1dDhKT3I0dDRO?=
 =?utf-8?B?M1NCd1YyTTJhT1IxZkgwbkhDQm9zY21OMmNXQnEyWlJpRTl6Y3E1SFVsc25y?=
 =?utf-8?B?UkVoOFgyQWVMU0JXV1ZDcWNnZGlQYUUzbUdMWXRGc3RPM001VFk1S0dSL3gv?=
 =?utf-8?B?cXMyZ3VsSVJtbTR0MFphK05rRFovQ2RsRG5PL3NFdDVYNkJYRDNTKzhTT05Z?=
 =?utf-8?B?Q0hxcFVTb2c3T2pMNHR1U2EyWXgyUERHcFVaMUYyRUErUnkvdGRvdEJvTENF?=
 =?utf-8?B?WWp3YVFxeVhidmZtMVhFUitPc0Zid0NnZjFtRW84czFRWHBMSURWZUc2MUg5?=
 =?utf-8?B?Zm5ic1dzVG4yQWxqNmdsL2IwNExzc2dzQW5FbUFDeW5zOXhab2pRTVpIN0Ez?=
 =?utf-8?B?SFNFemtkRDJ3TE14dmNhZW05WDN5M0dkWTQ4dzBmdnc2UU9FWlRKOStjbTJW?=
 =?utf-8?B?bUx4T0RPbXBBK2FuSWZLNFBGUWJtNzRpSlo0NjZKV25xUDZiVlBHUW9QN3FH?=
 =?utf-8?B?dDllejVQTDlTTUdBVDk0dnFGbHlkUFQ2bStZbkcrczZqZ0VtWWZYc0FzVXhM?=
 =?utf-8?B?dUNhdm8ya2pHQit4bXliQlpWckZqMjh1MVdZUzBBdG5XZUpGSXZGRnQ2UjdT?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1018301a-4885-495f-91c5-08dbbf87e663
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:31:01.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAn/x9JdpYG1WzbfgMMh65wNCaYM4k9eg43nhmsGKeU+JTRWSKHU9S3Hhd3nhTjhYCI7Mtni3/lT6DnTstDayMlk57fiEOYkOl6tK+Kl2EY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5411
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/15/2023 3:42 PM, Babu Moger wrote:
> The resctrl task assignment for monitor or control group needs to be
> done one at a time. For example:
> 
>   $mount -t resctrl resctrl /sys/fs/resctrl/
>   $mkdir /sys/fs/resctrl/ctrl_grp1
>   $echo 123 > /sys/fs/resctrl/ctrl_grp1/tasks
>   $echo 456 > /sys/fs/resctrl/ctrl_grp1/tasks
>   $echo 789 > /sys/fs/resctrl/ctrl_grp1/tasks
> 
> This is not user-friendly when dealing with hundreds of tasks.
> 
> Support multiple task assignment in one command with tasks ids separated
> by commas. For example:
>   $echo 123,456,789 > /sys/fs/resctrl/ctrl_grp1/tasks
> 
> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

x86 area aims to have a uniform view of commit tags.
Please review the "Ordering of commit tags" section within
Documentation/process/maintainer-tip.rst and apply that
custom to this whole series.

Reinette


