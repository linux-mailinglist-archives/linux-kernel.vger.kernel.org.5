Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C457E7093
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344789AbjKIRnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344785AbjKIRni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:43:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C173230FA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699551816; x=1731087816;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a0N7YGberE2DrCFQd+9fjh46thsbXVaanB+oHq8RxS8=;
  b=WkY5seTnGYb+CcjuaUBgFeQQMBJt7fvjN9IsX5BcutMvguTSmhfUDtI/
   7fQgfd6fa5tYgUHLtIzvlUl+TI0dPjOv4ihgJB6WFLegyZKiBkWiEZ1dR
   VIF9RIkCo5VWD08EMTlu3G3hZQdhCrKw1Kv581ssYd+wp0Fs9Cei94A3j
   2Z3ldUnqOeldKKoFZHWACP7E48/Lgv06Q/VvO8dhUXgc4IqDxguHhgEq0
   2hUYdHBTUztL08qDFSuXfB/w2Lr9mX9CfTz/wxPVqKS1ILZsTKkvj+fdh
   zGHsf3WDCTVCslketNvaW1EvTN/tRBHAdAkPCajUftUPbcJb2HhbIkHUc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="375075915"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="375075915"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:43:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="713390874"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="713390874"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 09:43:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:43:35 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:43:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 09:43:34 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 09:43:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JW9MFJuUSu/6yyyN1WF4S/L4QlJeox0UGZZTjRoEy45ZOdtDH2vuFmyyVdN70X2CqW6GSRGKEUg249/Mk77CvKN9W3RFOO/oqCnqrGMxt+HEL5GmNVHoxtO19SALqfAInStSpVB1HUvLm8AO1SWvhU3f5CwV8onRLYBiCvVs1HL9C+UNeoGsklbthulfunGE7FbFqxK4o/7vRg1d0s/RdHVuQ8ynMNw9lgqs8ElNFOTSzIEC3ItVQPwzjbIIGGYIskWXebtOYg+L1pCsoDGes1w+8iqtDr9dJQnHs65ZM64h+KyVhjYeGxazH1jYEy6ndao5Fm8eeN0som2VK5+jnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0er6ZoSeDL5lddIpY8F3V4G8wyPgtgTPRmbmT71VuHA=;
 b=m7MufDOFuYkijh+XK/J1Muep5KpWeKgIojZ/wbljNgqXrRlELE/VAy4HoXUcCnlOrS5oKUoMTKdDMtrXMwA3a2tkmtU8HqnS8khsPELe+0nabBLmhktFy7hGM/zUTQaDNjtJ2GEplaxIQhvSH6C91mQ82E3pSL6PYHtnS6tR/p456ZxM/75SkfRUYDG42s/qlXSVJgyjCtD1++6ZGj7I9r/zYEHHM3aCgGbzbhhhoYijjlZWtI/qmL68sKTmJjkvQtHFioVHGUqd3fSAeKm1zeo0s+IH3QTtM+DYsaZHUSA8U8RoQdTKIatAynr+Bd/LCsCHmM2pynUAIPZzxJN2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4707.namprd11.prod.outlook.com (2603:10b6:5:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 17:43:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 17:43:32 +0000
Message-ID: <2033865a-b57b-4956-8ab6-d749ad782aa3@intel.com>
Date:   Thu, 9 Nov 2023 09:43:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/24] x86/resctrl: Track the number of dirty RMID a
 CLOSID has
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-9-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231025180345.28061-9-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0225.namprd04.prod.outlook.com
 (2603:10b6:303:87::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2ba927-f837-4ae5-9d83-08dbe14b647e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gw+JRDvMY/awrCZ1pCp6meyNkMCe+buBzoCbKGrER8rQ8aAsfmrT1uKUttM4ZQbEDRXrwbvovj5uyIH3D6txnVVhc6LvNPNPrr4J7HG4vZoTfFMTcW1chATMBiJcdqdEK0J0bfQ8n1wOf5Abnk334YGo0DPN4vFefqE3T6rbQYAkAOajlZIJxsrOz1myb0FWko0EAK1JORXmfz13+cKp4FiEFIu/vF+9UgEUmTVGKgVebCKvfJOZ5nYSuEL6dQLifc8DZmG2ZVN048PQLemXPjAhkYNwNhEZZFsH8vG6hATVMHfYQ/ZZQmASpyhmNlL+vQZ6w5wFBAn1fRl5c8eRIWR443Sqvx3Eea5INCkocIcuy/oHQRmgqmE5LLGfOeV0hiI5WxXQK2stusHf/WWGXpJvCM60eNUHsGJpdUdlx1NHh7qDvOO/osV6SQaliINE4PnbrTMqNgmhAWkA4PvGJn0X33dZ6ydiYegPn12wodn+Y3KE9QwqXaLLUrPmgF8c0/99ULL8HN6pr7CTFSascmo5Zfiqt4B+qSzAYzkEgDvVi7iQfoAwKZmc//jrx84vci5Oc7uT7tRjifLTAUs4HIUydcmKnmfRYyW5BpdWIe/9giJUcKj+edmFwwnGbEJCuqrk/YUbnJLlEmYKifF59EFUlTwrckLQDkcglGW4gSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(31686004)(54906003)(38100700002)(66946007)(66556008)(86362001)(31696002)(36756003)(66476007)(82960400001)(83380400001)(26005)(2616005)(7416002)(4326008)(6512007)(53546011)(6506007)(478600001)(2906002)(6486002)(316002)(8936002)(5660300002)(8676002)(41300700001)(44832011)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDBnNUFWS0g0L2pOcHN4SFFCM2JxN2dBWEZQV05ESGxnTW0yN25TNE9VZlpj?=
 =?utf-8?B?VjVISWR5ODJGZ1FaRWJCT1NMWDNNcnNvdkl6S1RQY0F4Slgxa1BTcHh2VXcx?=
 =?utf-8?B?K2ZneGsyeUNsaS9rRk5pNjZFU2g3allzZ0NIa2MwTTQzTTJnUE1MYnZQNTEy?=
 =?utf-8?B?TUpvRlVRa2RJUmk1K1VrVTFrVmtoWkVRTFg3cDdaVGgvdTNDSndmVUVUSWZJ?=
 =?utf-8?B?d281S2NsTGJCa1pkWm93UTlHSVlMMGl1enJWSm4xWDBvY0xaYy9QMjVrZWNq?=
 =?utf-8?B?QWFzZzdiUG1aeDhpazB2bzAvUVAyM2JRdkh1QS9nYjEycXFuanJYb1hLc3c3?=
 =?utf-8?B?VldEVmRIZzBvZFlSaENzc1Z2NnNTcnl0Tm1RM2RLeGg4dDNodFliQlU0NDN1?=
 =?utf-8?B?VWJFL2dqQVlGT2REZ0Q0eW91NHhZOEZFT1pXWnNkRDV1SVBuSFRuYlc3TmlY?=
 =?utf-8?B?cnhGVXlOSDMyL1AwVEMzYmJjSXh3MTJzWWljYjF6OURIaG85NHg3Z0tKYjBQ?=
 =?utf-8?B?OFhPaDVwQ2xENEpGNWZxQjBZYjdLbWF6Q3hBQUFjMU9vUE9BVDNtUEZncVRm?=
 =?utf-8?B?V2RIei9aZEQxUkpkWllWMlBLOFBPckJmSkpJd3gvd2huMnpmcVFSQ0ZrOTRj?=
 =?utf-8?B?TVhzcWhTdlJvb2NiQ3RwSENCSGRIbXcxd2w5c1QrN3hiZE5ET1V1MlNsN01z?=
 =?utf-8?B?bXdNN0RPbFVrMFc0SWhMUCtlK0pQK1NqQ3Z3ZmZRL2d1MVArRUpGTzBYSmpx?=
 =?utf-8?B?TU1MS1dxeFpvcElzQVlubWEzd1luVklZRE40QlBvNHROU214ek1LTmNSQUpC?=
 =?utf-8?B?TU4wUlpoNmtGVklPQk1DQjM3MTc2dFJKNzZWbXE5QnBFZ2YxUFBYdm5XSnRY?=
 =?utf-8?B?OWM0cWROSlJzVVNDblZDSEM0ZVdtVUgxVFVhWThpdUZJS08ySWpmVnBJOTNM?=
 =?utf-8?B?ZFZxZjNPYWFsTHFocEZTcUppVEdKcnlOTVpScWhHeUNqbCtkNzFFVXdGNVJo?=
 =?utf-8?B?RnhpYTJmdFlCTDltdVFYQUk4RGg1aE9LNDU5cWQxa1N2K1d1VktkV1oyekRO?=
 =?utf-8?B?TVE5N1NQeHFMMXVNMFRQZkZnUSsraDdvRDE4MUcxVDRRQ2p4VnJvT1cxWmt5?=
 =?utf-8?B?Q1N2WUpJellwTFZhOGIwZUJrNkxDUTExbXpRYTN0ajVQaHF6Mzk3YUNhaDZP?=
 =?utf-8?B?TERWNWh6bnBmWFo4dkVXRStiNFVrZ0FBQ2xKeVFHU05kU0IxTnpPUTNIUEcx?=
 =?utf-8?B?aVFJV2kyMGxMeXIxdTdVSDRBd3RRRzJVTTFBdUlhcmhzMXBxMHN2aW1paGVT?=
 =?utf-8?B?bVpXeFN4a2VxWEZyb25KRmRwM0NNWHE5WlFzdk9ZR09Ca2hEVS9HdnpmSC9P?=
 =?utf-8?B?bUlHeE1XOVdIZlpWa25CQlhwWld5OUpUakRMZWpyckNFb04xTFRKZjNwakZV?=
 =?utf-8?B?RVFjSXB1VFYvMmEzeVo0bzMyd3B6UlRrTklRak5EWjRjakd3aWZrWlA2QUVZ?=
 =?utf-8?B?bk9qMUxQMUFTK29hWjlwM3BGSUtRNmpYZzYrSHZHcGR4MWNnam1DdWlSbWFu?=
 =?utf-8?B?SVZ2TEp1c3lYMlZMUlQvK0VRT2lhMFhoQmc5dVpjdzFsMTFHbUxDeHdUSytF?=
 =?utf-8?B?TStRbWJIL3ByYkNKYS9LZFNIckRWTWlIWnBvdHNtaEZEdW5xYTNrQjZiOUpr?=
 =?utf-8?B?UWZVdGZHRndtUkJWWDNVSmJvdklVUjRsUWh2Y1JxZzFTZTdQNXNSR3JxKzVS?=
 =?utf-8?B?ZkxsWk9xd0ZPTklYMHhqRFdUOS8xdjlhOThZU0FnNTdUaFBWL241SHZBOVZT?=
 =?utf-8?B?RzVRNml3NUt4bU80bjdEb3hkcERVM1lBL3lRM09rdkk3Qmc1QVd4MU1pbDd3?=
 =?utf-8?B?UW1hUnpGcXdNTktNWEpabWVTYXBnYjlWc1EwUWliR0piSUo1a2VxQ3o1b3Ro?=
 =?utf-8?B?cnJHQWVySkRHREZ3bkRNNUdBM0FSeDJNNFZLVks3UnQ2MXRjZmZsZXQyQmdl?=
 =?utf-8?B?L0s2R0pwdWl2T1ZDNjliMEUrQ0kvNnZqVDc5MUx1M2hNSEx6ZW5xU0NlV1JK?=
 =?utf-8?B?UjEzbnhnUnV1SEh6b0hNUU1mbVVoWjRmNHUxZ2JGMTV2MGw0alI3Q0I2U0ps?=
 =?utf-8?B?YXdYczRkZnlBRG5OSXNFaVliQmNUYzBQOHZ5NVF4QnpMZkJFc21KN24xMHRU?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2ba927-f837-4ae5-9d83-08dbe14b647e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:43:32.9199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSPbjuqRLZFU36wIKfvnouUFRWdeEB0HD/Ej2yTdm19XXjrj7TCGf4wgPg/xQGyWvCwgzK5vBpMHdpmOwFz5E1STCV3cRVyXJi9UhGG6ymA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/2023 11:03 AM, James Morse wrote:
> @@ -794,13 +815,30 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  static int dom_data_init(struct rdt_resource *r)
>  {
>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> +	u32 num_closid = resctrl_arch_get_num_closid(r);
>  	struct rmid_entry *entry = NULL;
> +	int err = 0, i;
>  	u32 idx;
> -	int i;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +		u32 *tmp;
> +
> +		tmp = kcalloc(num_closid, sizeof(*tmp), GFP_KERNEL);
> +		if (!tmp) {
> +			err = -ENOMEM;
> +			goto out_unlock;
> +		}
> +
> +		closid_num_dirty_rmid = tmp;
> +	}
>  
>  	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
> -	if (!rmid_ptrs)
> -		return -ENOMEM;
> +	if (!rmid_ptrs) {
> +		kfree(closid_num_dirty_rmid);

Since this is a global variable and resctrl keeps running on this alloc
failure I think it will be safer to add a:
	
		closid_num_dirty_rmid = NULL

With that added you can add:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

