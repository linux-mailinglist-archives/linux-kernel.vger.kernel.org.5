Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC1380424D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjLDXD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbjLDXDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:03:46 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726C8134;
        Mon,  4 Dec 2023 15:03:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2+rl1HC1kk4oIo41mHtLV0CfXRYYhoGtM2r6zQVDp+4g7ncv96UC23auXK06JMXmiEg3G/TUtuGo4hCut2YeGsq3/7ntdOR1sk8qM38YNstkbUm5mTGNN7ZyGi4zrLiDFC2OXr5+6AdaIoAaP1IilSzsRpObsP4XyxP5AK2b2PB5uF1y+4tlTV1ZaAeNZnz9Y7sGbKuhii9P26SekuBsk3g6ZQkvRJ5lAtYLspRgPmCFVc4CMIOTJFfuXPedEz0yMaA7bmwgp6MO5q7pl6KVF9zWUDh51E7JIikmiQ594hfRve9pwOowCPzIqec/jBEABSdVit0fHyFo3CxXbYu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8By/l+1CcGYC/1voKOTM2tJRwCbUsU9fw5zmQOoFDDE=;
 b=LKZast3LOTQXSUXTfvye/b26XKumTr1q5SIKuo3syu1I6JMtbSzGzNrTJL1DtJxAirn1ACKM6qs2qlEDKDWemuZ7iB60yshdY1saXmIjI2F62ycjuBIRpqvXlj8796tNDbWoavhjT5aqS16jRg5p8PrknTTCb6iju1lYolN4cMDmfhRMQwU7lyyZZCBCKjcSdNj1QAEh5zdfOciKzMDvSyJGng0kmj77oF6Nql6/ypz8OWkbbBdtClPWeN5R+dI66ehoKsGIocHqEOB23zenDPbYiyiCweTWWnxzWAK2hu3Z7oNIMqto5iwpmhxT/Ax+xPd6MCScvcQ5usW7dDVcrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8By/l+1CcGYC/1voKOTM2tJRwCbUsU9fw5zmQOoFDDE=;
 b=MePCFIrR6HMVacRf1BdrGAX4oFAoPVSjT7jS69+8oXTjwqq1G2e4uXHeEliS4Ojd2J31JoXSWDSmuK6zQHZuo6k2iJLiovol12ujczE1uCimaFVR80TW25cw9PQzCfIGHDHcHW/7aAsrOilmwekQKssgUwhJ2MSfMetcR42yatI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 23:03:39 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 23:03:39 +0000
Message-ID: <a264bb8d-d941-1b34-39b8-48b111889d55@amd.com>
Date:   Mon, 4 Dec 2023 17:03:36 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   "Moger, Babu" <bmoger@amd.com>
Subject: Re: [PATCH v13 2/8] x86/resctrl: Prepare to split rdt_domain
 structure
Reply-To: babu.moger@amd.com
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20231130003418.89964-1-tony.luck@intel.com>
 <20231204185357.120501-1-tony.luck@intel.com>
 <20231204185357.120501-3-tony.luck@intel.com>
Content-Language: en-US
In-Reply-To: <20231204185357.120501-3-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0065.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::42) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 510b62cf-a93e-4be1-5514-08dbf51d40a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbq7+FdH60tydzHZuO3i4N7wvv++BFSTbDIZ/o+h2aCiKdKWs8jeyczmcH8+wrGI+WuDlVRZcXbKMT1leyfk3VOm2fqCT5eK55ejL1hoRSwUgk0nn1u6JM8njBaunKwAEz15pWPtV3oOPOR4mgyKVg/bBAARdLAu/KtVUvlr2DjwaX/MYxujrLcvn9RkWggWUt5Lq8wG5rAA/AwxcaPHXE3Yz219FZiBAUWu87pUZzCdrRCcy2hK/epRZ0PTTzRHQPX6xP4AD2Xrsv8MIlHaUUQFHy87lPrJoHatTjfgFJHykf0cdyyxqKHqzqw8iQcKNC5ms/qvLmG16EDFR80ZN2tKq+1e95g+UpYNsIM7RAci0LtrOOTdfQGfZcRlcIfwpx5gBDAl3K+XyCuVOc146MWTOCSJR7dhgwV9dTSK+Pem76kZzBwqBXDRQUgLcyf0wdtsgHdM4GSSqsznr4Yz88E4IwvTLQObdBvU+kK8PUT7uD3BM4Xi+5P05+mZmWAuzNmeuS2OoewFA+thNCp9OZ5WXdE36iN3iP2yywIsn7HKP0Y4olaEb3L9dxraLzA18C3WrfEZITIcjxnvmh6ToUf5NHpkoN2jSWI0OGaSevGa5/hc0RB5UidPKcmae3BLE48qF14ZP+tMP7b0VO8NYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(38100700002)(36756003)(31696002)(2906002)(83380400001)(5660300002)(7416002)(26005)(30864003)(2616005)(31686004)(53546011)(6512007)(478600001)(6486002)(6666004)(6506007)(4326008)(8936002)(66556008)(66476007)(110136005)(8676002)(316002)(66946007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzJ2cDFrT1UrdXpZMkl0SnNnS2ppTDlGWlM1L1ZSK25VTlZqL0lHckNVeThN?=
 =?utf-8?B?d1k1eWg3M2lZU0M5YWxQSklGSzZpZWZVTE0rTXNKTGlobE8xODJJK0NHWVBM?=
 =?utf-8?B?R0F1WkFIU3ZDVlE3NnJCd0tzaTUwZTJ2R3ZOTUhRZjVLMkhCZVhyeWs4T3Vi?=
 =?utf-8?B?dm9ZUndSSEsvN1dWYTFERXVJRjN1ZDQ0QzE5aGJzOEVCTk9aVVgyWVpYWnBt?=
 =?utf-8?B?REo5MzAwaXcvN1pqWXVxWlovNmlIcmFDS0w5MnE1WTV4SE81Ni9KNkFDNlZr?=
 =?utf-8?B?ckJHN0FzRXFoM0NsdGd2amRsTDdMY0Q3V1NLbUdjZE5vUFZSWHNYSmxNT1FR?=
 =?utf-8?B?bWV3ZWp4VEl3Qmc1dVFpM1daYmlkakFWRGdYbWRORDl2NmdmSDRFejZ5dzE3?=
 =?utf-8?B?and4T1VVWDlhbDBRQjY1c2VNekR2MEJlVXNEL1FRcUNNaEU5dVlPTmxpY2py?=
 =?utf-8?B?dEU3MURGSjRvODN0emdRSE1jaVp1Tm5mZFZSV0ZLcEttaVM4a0NkWlMrcGVT?=
 =?utf-8?B?NUthQ2VuSlRJNlVTT0JzWnB6dXVkWFdJeVRUMm9keHJWMjlNckRpaTdrUlFL?=
 =?utf-8?B?ZnptTTdUZzdFMjZ1dHAwK0g0VmRDMjZnMWZPcU1jcmVWQ1VxUUFXOEhkR2Fo?=
 =?utf-8?B?dW9kRzJUaUUya2EraFZkOUhMV3lZUVlFS0k5WmVGOXlEWXl0ck5OM0ZvdUhz?=
 =?utf-8?B?eGNNMUQrR3dvQ01TSWZpNUdkYXNrb0pFS0RDZGh5SEU1THNibTd6RERybDhU?=
 =?utf-8?B?MmtmVHBRTzRnREg0SDBJMHNSN2gxUlNmSVkrQ1dlVXd3MXRvSncrN2NUNS9p?=
 =?utf-8?B?MnJsUklIZ2wzakpuUTUwRGdHN1djMWFyWVFOS3pYWStpR1pTTWVWMUY0bFVr?=
 =?utf-8?B?Qjk5Y3grb0d0UHh6bElDejh1Nnk3RldaanZFNHdkMldmQ2tqYW54V0IzL0Mr?=
 =?utf-8?B?NkF5ZUJ1cEtZWDJRZjZqUXo5WEF1VVpXREVpS0tPWEdlV0sxUzBnOWRJcHJP?=
 =?utf-8?B?NmU1MzJ3ZlRnMkRyQ1Z4SVd6anpWajNRYWlWMi91WlpzdnpiVEtjSklLb1J3?=
 =?utf-8?B?MG9xNFZLWWx0ZDZuNys5Q2w4YSt3TkVaRnhUTEFnVGpzUzI0S1dMVSs1TndY?=
 =?utf-8?B?dnZBTXE2WnRYVmxZWElaUjFTUlQ4RlFsRmUxWVUwdnZza0NZbFAyemhzV2xI?=
 =?utf-8?B?UWdPNEJCZzhYdlFrOWJUa1JlQy9wSTEzTTFpYmxjWnhibzJFK2MxeHE0anJi?=
 =?utf-8?B?SkN5VzRpWHludEZlcEh6NjFJU29iRDFFOW82M3dyQXZCbFZXcFhuUS94eEcz?=
 =?utf-8?B?N1dlTEpmZ0J0SEU2LzRhYzJsdWFESHZpSVJaUmg0eXBFY0FkcjZkVENLQVdC?=
 =?utf-8?B?dW93OElNUEtaNmJTVWhQcVhIYjIyWnBHWVQyeWNiNGVMMGZEVzdQUzk4d2Rq?=
 =?utf-8?B?MmNEWGQ1dTgvKzFsQkxqU1ZOQzBWdFFnTk9FdURzdnBLWUdxTGdSZjJ3K0ZZ?=
 =?utf-8?B?RFViZi9JVUtic2o1NDlMelBzZmFESTdrcE94TitrUC9iQ1N3dnB3VERTcTZ5?=
 =?utf-8?B?T3hISnY0RG9MaHVtUW5xdWxkbWFaTDk4ZXNwUW12SGs1WDNPc3JCdHh5SWY2?=
 =?utf-8?B?VHp1QmgydWlKK2t6VTVWaDZabVZVd3NneGh5Yk00NXR0dkdNU2VBUW5RSTBD?=
 =?utf-8?B?MllEQndPV2tzRDcyM1JGNGhYUUJUczJCbGR6Mi81cURnQ0gwMS9ZZkZpaGhh?=
 =?utf-8?B?c29hUmptekFNdlBOaWlPdVFxNGl1dERRYXVtMWhTdWJnaWh1VmVWQi9NREZP?=
 =?utf-8?B?MHJhWW5Ibk9uem9UZkJHMVI5Qk9UOERjVnFCdjFDSndESXpJR1gyMmRkeDBr?=
 =?utf-8?B?UnV6bUtEaXZ5OTB5cnJXcWl2dGIyZGFOWDN2WTNTWmxUMjZhQzBBT3hJNEtp?=
 =?utf-8?B?ZkduNkxBMWJBMkdVSExWcHhjNjV6Y2tyRG9qYzhYRHhheWZlNlV1b1IvZWcy?=
 =?utf-8?B?cEp2ZytWL1c5YzFiZGt2NUZxK1BZeko4SjZxY21acTd6ek5ZVjliamhGRFlE?=
 =?utf-8?B?Z2NXY3VrUGRHS2RUTnl2WUM4U0YxQXUvTlBOOVJHWmtZTXhET0xhUnowWFNh?=
 =?utf-8?Q?3JDBQ+YW2EIFsVICgnAwnhayp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510b62cf-a93e-4be1-5514-08dbf51d40a4
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 23:03:39.1867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DUsp2XBydOPPrN3fyfiIfpf2iUHyE0kTm6+tZJoJU/fq98ZkySt0x9gsHMegccW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/4/2023 12:53 PM, Tony Luck wrote:
> The rdt_domain structure is used for both control and monitor features.
> It is about to be split into separate structures for these two usages
> because the scope for control and monitoring features for a resource
> will be different for future resources.
>
> To allow for common code that scans a list of domains looking for a
> specific domain id, move all the common fields ("list", "id", "cpu_mask")
> into their own structure within the rdt_domain structure.
>
> Signed-off-by: Tony Luck<tony.luck@intel.com>
> Tested-by: Shaopeng Tan<tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Reinette Chatre<reinette.chatre@intel.com>
> Reviewed-by: Shaopeng Tan<tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
> ---
>   include/linux/resctrl.h                   | 16 ++++--
>   arch/x86/kernel/cpu/resctrl/core.c        | 26 +++++-----
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 22 ++++-----
>   arch/x86/kernel/cpu/resctrl/monitor.c     | 10 ++--
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 14 +++---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 60 +++++++++++------------
>   6 files changed, 78 insertions(+), 70 deletions(-)
>
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 7d4eb7df611d..c4067150a6b7 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -53,10 +53,20 @@ struct resctrl_staged_config {
>   };
>   
>   /**
> - * struct rdt_domain - group of CPUs sharing a resctrl resource
> + * struct rdt_domain_hdr - common header for different domain types
>    * @list:		all instances of this resource
>    * @id:			unique id for this instance
>    * @cpu_mask:		which CPUs share this resource
> + */
> +struct rdt_domain_hdr {
> +	struct list_head		list;
> +	int				id;
> +	struct cpumask			cpu_mask;
> +};
> +
> +/**
> + * struct rdt_domain - group of CPUs sharing a resctrl resource
> + * @hdr:		common header for different domain types
>    * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
>    * @mbm_total:		saved state for MBM total bandwidth
>    * @mbm_local:		saved state for MBM local bandwidth
> @@ -71,9 +81,7 @@ struct resctrl_staged_config {
>    *			by closid
>    */
>   struct rdt_domain {
> -	struct list_head		list;
> -	int				id;
> -	struct cpumask			cpu_mask;
> +	struct rdt_domain_hdr		hdr;
>   	unsigned long			*rmid_busy_llc;
>   	struct mbm_state		*mbm_total;
>   	struct mbm_state		*mbm_local;
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index fd113bc29d4e..62a989fd950d 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -356,9 +356,9 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
>   {
>   	struct rdt_domain *d;
>   
> -	list_for_each_entry(d, &r->domains, list) {
> +	list_for_each_entry(d, &r->domains, hdr.list) {
>   		/* Find the domain that contains this CPU */
> -		if (cpumask_test_cpu(cpu, &d->cpu_mask))
> +		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
>   			return d;
>   	}
>   
> @@ -402,12 +402,12 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
>   	struct list_head *l;
>   
>   	list_for_each(l, &r->domains) {
> -		d = list_entry(l, struct rdt_domain, list);
> +		d = list_entry(l, struct rdt_domain, hdr.list);
>   		/* When id is found, return its domain. */
> -		if (id == d->id)
> +		if (id == d->hdr.id)
>   			return d;
>   		/* Stop searching when finding id's position in sorted list. */
> -		if (id < d->id)
> +		if (id < d->hdr.id)
>   			break;
>   	}
>   
> @@ -530,7 +530,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>   
>   	d = rdt_find_domain(r, id, &add_pos);
>   	if (d) {
> -		cpumask_set_cpu(cpu, &d->cpu_mask);
> +		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
>   		if (r->cache.arch_has_per_cpu_cfg)
>   			rdt_domain_reconfigure_cdp(r);
>   		return;
> @@ -541,8 +541,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>   		return;
>   
>   	d = &hw_dom->d_resctrl;
> -	d->id = id;
> -	cpumask_set_cpu(cpu, &d->cpu_mask);
> +	d->hdr.id = id;
> +	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
>   
>   	rdt_domain_reconfigure_cdp(r);
>   
> @@ -556,11 +556,11 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>   		return;
>   	}
>   
> -	list_add_tail(&d->list, add_pos);
> +	list_add_tail(&d->hdr.list, add_pos);
>   
>   	err = resctrl_online_domain(r, d);
>   	if (err) {
> -		list_del(&d->list);
> +		list_del(&d->hdr.list);
>   		domain_free(hw_dom);
>   	}
>   }
> @@ -584,10 +584,10 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>   	}
>   	hw_dom = resctrl_to_arch_dom(d);
>   
> -	cpumask_clear_cpu(cpu, &d->cpu_mask);
> -	if (cpumask_empty(&d->cpu_mask)) {
> +	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
> +	if (cpumask_empty(&d->hdr.cpu_mask)) {
>   		resctrl_offline_domain(r, d);
> -		list_del(&d->list);
> +		list_del(&d->hdr.list);
>   
>   		/*
>   		 * rdt_domain "d" is going to be freed below, so clear
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 3f8891d57fac..23f8258d36a8 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -67,7 +67,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>   
>   	cfg = &d->staged_config[s->conf_type];
>   	if (cfg->have_new_ctrl) {
> -		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
> +		rdt_last_cmd_printf("Duplicate domain %d\n", d->hdr.id);
>   		return -EINVAL;
>   	}
>   
> @@ -146,7 +146,7 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>   
>   	cfg = &d->staged_config[s->conf_type];
>   	if (cfg->have_new_ctrl) {
> -		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
> +		rdt_last_cmd_printf("Duplicate domain %d\n", d->hdr.id);
>   		return -EINVAL;
>   	}
>   
> @@ -226,8 +226,8 @@ static int parse_line(char *line, struct resctrl_schema *s,
>   		return -EINVAL;
>   	}
>   	dom = strim(dom);
> -	list_for_each_entry(d, &r->domains, list) {
> -		if (d->id == dom_id) {
> +	list_for_each_entry(d, &r->domains, hdr.list) {
> +		if (d->hdr.id == dom_id) {
>   			data.buf = dom;
>   			data.rdtgrp = rdtgrp;
>   			if (r->parse_ctrlval(&data, s, d))
> @@ -274,7 +274,7 @@ static bool apply_config(struct rdt_hw_domain *hw_dom,
>   	struct rdt_domain *dom = &hw_dom->d_resctrl;
>   
>   	if (cfg->new_ctrl != hw_dom->ctrl_val[idx]) {
> -		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
> +		cpumask_set_cpu(cpumask_any(&dom->hdr.cpu_mask), cpu_mask);
>   		hw_dom->ctrl_val[idx] = cfg->new_ctrl;
>   
>   		return true;
> @@ -291,7 +291,7 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
>   	u32 idx = get_config_index(closid, t);
>   	struct msr_param msr_param;
>   
> -	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
> +	if (!cpumask_test_cpu(smp_processor_id(), &d->hdr.cpu_mask))
>   		return -EINVAL;
>   
>   	hw_dom->ctrl_val[idx] = cfg_val;
> @@ -318,7 +318,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>   		return -ENOMEM;
>   
>   	msr_param.res = NULL;
> -	list_for_each_entry(d, &r->domains, list) {
> +	list_for_each_entry(d, &r->domains, hdr.list) {
>   		hw_dom = resctrl_to_arch_dom(d);
>   		for (t = 0; t < CDP_NUM_TYPES; t++) {
>   			cfg = &hw_dom->d_resctrl.staged_config[t];
> @@ -466,7 +466,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
>   	u32 ctrl_val;
>   
>   	seq_printf(s, "%*s:", max_name_width, schema->name);
> -	list_for_each_entry(dom, &r->domains, list) {
> +	list_for_each_entry(dom, &r->domains, hdr.list) {
>   		if (sep)
>   			seq_puts(s, ";");
>   
> @@ -476,7 +476,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
>   			ctrl_val = resctrl_arch_get_config(r, dom, closid,
>   							   schema->conf_type);
>   
> -		seq_printf(s, r->format_str, dom->id, max_data_width,
> +		seq_printf(s, r->format_str, dom->hdr.id, max_data_width,
>   			   ctrl_val);
>   		sep = true;
>   	}
> @@ -505,7 +505,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
>   			} else {
>   				seq_printf(s, "%s:%d=%x\n",
>   					   rdtgrp->plr->s->res->name,
> -					   rdtgrp->plr->d->id,
> +					   rdtgrp->plr->d->hdr.id,
>   					   rdtgrp->plr->cbm);
>   			}
>   		} else {
> @@ -536,7 +536,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>   	rr->val = 0;
>   	rr->first = first;
>   
> -	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
> +	smp_call_function_any(&d->hdr.cpu_mask, mon_event_count, rr, 1);
>   }
>   
>   int rdtgroup_mondata_show(struct seq_file *m, void *arg)
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f136ac046851..dd0ea1bc0092 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -238,7 +238,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>   	u64 msr_val, chunks;
>   	int ret;
>   
> -	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
> +	if (!cpumask_test_cpu(smp_processor_id(), &d->hdr.cpu_mask))
>   		return -EINVAL;
>   
>   	ret = __rmid_read(rmid, eventid, &msr_val);
> @@ -340,8 +340,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>   
>   	entry->busy = 0;
>   	cpu = get_cpu();
> -	list_for_each_entry(d, &r->domains, list) {
> -		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
> +	list_for_each_entry(d, &r->domains, hdr.list) {
> +		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask)) {
>   			err = resctrl_arch_rmid_read(r, d, entry->rmid,
>   						     QOS_L3_OCCUP_EVENT_ID,
>   						     &val);
> @@ -661,7 +661,7 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
>   	unsigned long delay = msecs_to_jiffies(delay_ms);
>   	int cpu;
>   
> -	cpu = cpumask_any(&dom->cpu_mask);
> +	cpu = cpumask_any(&dom->hdr.cpu_mask);
>   	dom->cqm_work_cpu = cpu;
>   
>   	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
> @@ -708,7 +708,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>   
>   	if (!static_branch_likely(&rdt_mon_enable_key))
>   		return;
> -	cpu = cpumask_any(&dom->cpu_mask);
> +	cpu = cpumask_any(&dom->hdr.cpu_mask);
>   	dom->mbm_work_cpu = cpu;
>   	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
>   }
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 2a682da9f43a..fcbd99e2eb66 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -221,7 +221,7 @@ static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
>   	int cpu;
>   	int ret;
>   
> -	for_each_cpu(cpu, &plr->d->cpu_mask) {
> +	for_each_cpu(cpu, &plr->d->hdr.cpu_mask) {
>   		pm_req = kzalloc(sizeof(*pm_req), GFP_KERNEL);
>   		if (!pm_req) {
>   			rdt_last_cmd_puts("Failure to allocate memory for PM QoS\n");
> @@ -301,7 +301,7 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>   		return -ENODEV;
>   
>   	/* Pick the first cpu we find that is associated with the cache. */
> -	plr->cpu = cpumask_first(&plr->d->cpu_mask);
> +	plr->cpu = cpumask_first(&plr->d->hdr.cpu_mask);
>   
>   	if (!cpu_online(plr->cpu)) {
>   		rdt_last_cmd_printf("CPU %u associated with cache not online\n",
> @@ -856,10 +856,10 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
>   	 * associated with them.
>   	 */
>   	for_each_alloc_capable_rdt_resource(r) {
> -		list_for_each_entry(d_i, &r->domains, list) {
> +		list_for_each_entry(d_i, &r->domains, hdr.list) {
>   			if (d_i->plr)
>   				cpumask_or(cpu_with_psl, cpu_with_psl,
> -					   &d_i->cpu_mask);
> +					   &d_i->hdr.cpu_mask);
>   		}
>   	}
>   
> @@ -867,7 +867,7 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
>   	 * Next test if new pseudo-locked region would intersect with
>   	 * existing region.
>   	 */
> -	if (cpumask_intersects(&d->cpu_mask, cpu_with_psl))
> +	if (cpumask_intersects(&d->hdr.cpu_mask, cpu_with_psl))
>   		ret = true;
>   
>   	free_cpumask_var(cpu_with_psl);
> @@ -1199,7 +1199,7 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
>   	}
>   
>   	plr->thread_done = 0;
> -	cpu = cpumask_first(&plr->d->cpu_mask);
> +	cpu = cpumask_first(&plr->d->hdr.cpu_mask);
>   	if (!cpu_online(cpu)) {
>   		ret = -ENODEV;
>   		goto out;
> @@ -1529,7 +1529,7 @@ static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
>   	 * may be scheduled elsewhere and invalidate entries in the
>   	 * pseudo-locked region.
>   	 */
> -	if (!cpumask_subset(current->cpus_ptr, &plr->d->cpu_mask)) {
> +	if (!cpumask_subset(current->cpus_ptr, &plr->d->hdr.cpu_mask)) {
>   		mutex_unlock(&rdtgroup_mutex);
>   		return -EINVAL;
>   	}
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index c44be64d65ec..04d32602ac33 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -91,7 +91,7 @@ void rdt_staged_configs_clear(void)
>   	lockdep_assert_held(&rdtgroup_mutex);
>   
>   	for_each_alloc_capable_rdt_resource(r) {
> -		list_for_each_entry(dom, &r->domains, list)
> +		list_for_each_entry(dom, &r->domains, hdr.list)
>   			memset(dom->staged_config, 0, sizeof(dom->staged_config));
>   	}
>   }
> @@ -295,7 +295,7 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
>   				rdt_last_cmd_puts("Cache domain offline\n");
>   				ret = -ENODEV;
>   			} else {
> -				mask = &rdtgrp->plr->d->cpu_mask;
> +				mask = &rdtgrp->plr->d->hdr.cpu_mask;
>   				seq_printf(s, is_cpu_list(of) ?
>   					   "%*pbl\n" : "%*pb\n",
>   					   cpumask_pr_args(mask));
> @@ -984,12 +984,12 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>   
>   	mutex_lock(&rdtgroup_mutex);
>   	hw_shareable = r->cache.shareable_bits;
> -	list_for_each_entry(dom, &r->domains, list) {
> +	list_for_each_entry(dom, &r->domains, hdr.list) {
>   		if (sep)
>   			seq_putc(seq, ';');
>   		sw_shareable = 0;
>   		exclusive = 0;
> -		seq_printf(seq, "%d=", dom->id);
> +		seq_printf(seq, "%d=", dom->hdr.id);
>   		for (i = 0; i < closids_supported(); i++) {
>   			if (!closid_allocated(i))
>   				continue;
> @@ -1302,7 +1302,7 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
>   		if (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)
>   			continue;
>   		has_cache = true;
> -		list_for_each_entry(d, &r->domains, list) {
> +		list_for_each_entry(d, &r->domains, hdr.list) {
>   			ctrl = resctrl_arch_get_config(r, d, closid,
>   						       s->conf_type);
>   			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
> @@ -1417,7 +1417,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>   		return size;
>   
>   	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
> -	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
> +	ci = get_cpu_cacheinfo(cpumask_any(&d->hdr.cpu_mask));
>   	for (i = 0; i < ci->num_leaves; i++) {
>   		if (ci->info_list[i].level == r->scope) {
>   			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
> @@ -1465,7 +1465,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>   			size = rdtgroup_cbm_to_size(rdtgrp->plr->s->res,
>   						    rdtgrp->plr->d,
>   						    rdtgrp->plr->cbm);
> -			seq_printf(s, "%d=%u\n", rdtgrp->plr->d->id, size);
> +			seq_printf(s, "%d=%u\n", rdtgrp->plr->d->hdr.id, size);
>   		}
>   		goto out;
>   	}
> @@ -1477,7 +1477,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>   		type = schema->conf_type;
>   		sep = false;
>   		seq_printf(s, "%*s:", max_name_width, schema->name);
> -		list_for_each_entry(d, &r->domains, list) {
> +		list_for_each_entry(d, &r->domains, hdr.list) {
>   			if (sep)
>   				seq_putc(s, ';');
>   			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> @@ -1495,7 +1495,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>   				else
>   					size = rdtgroup_cbm_to_size(r, d, ctrl);
>   			}
> -			seq_printf(s, "%d=%u", d->id, size);
> +			seq_printf(s, "%d=%u", d->hdr.id, size);
>   			sep = true;
>   		}
>   		seq_putc(s, '\n');
> @@ -1555,7 +1555,7 @@ static void mon_event_config_read(void *info)
>   
>   static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
>   {
> -	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);
> +	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_read, mon_info, 1);
>   }
>   
>   static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
> @@ -1566,7 +1566,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
>   
>   	mutex_lock(&rdtgroup_mutex);
>   
> -	list_for_each_entry(dom, &r->domains, list) {
> +	list_for_each_entry(dom, &r->domains, hdr.list) {
>   		if (sep)
>   			seq_puts(s, ";");
>   
> @@ -1574,7 +1574,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
>   		mon_info.evtid = evtid;
>   		mondata_config_read(dom, &mon_info);
>   
> -		seq_printf(s, "%d=0x%02x", dom->id, mon_info.mon_config);
> +		seq_printf(s, "%d=0x%02x", dom->hdr.id, mon_info.mon_config);
>   		sep = true;
>   	}
>   	seq_puts(s, "\n");
> @@ -1646,7 +1646,7 @@ static int mbm_config_write_domain(struct rdt_resource *r,
>   	 * are scoped at the domain level. Writing any of these MSRs
>   	 * on one CPU is observed by all the CPUs in the domain.
>   	 */
> -	smp_call_function_any(&d->cpu_mask, mon_event_config_write,
> +	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_write,
>   			      &mon_info, 1);
>   
>   	/*
> @@ -1689,8 +1689,8 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
>   		return -EINVAL;
>   	}
>   
> -	list_for_each_entry(d, &r->domains, list) {
> -		if (d->id == dom_id) {
> +	list_for_each_entry(d, &r->domains, hdr.list) {
> +		if (d->hdr.id == dom_id) {
>   			ret = mbm_config_write_domain(r, d, evtid, val);
>   			if (ret)
>   				return -EINVAL;
> @@ -2232,14 +2232,14 @@ static int set_cache_qos_cfg(int level, bool enable)
>   		return -ENOMEM;
>   
>   	r_l = &rdt_resources_all[level].r_resctrl;
> -	list_for_each_entry(d, &r_l->domains, list) {
> +	list_for_each_entry(d, &r_l->domains, hdr.list) {
>   		if (r_l->cache.arch_has_per_cpu_cfg)
>   			/* Pick all the CPUs in the domain instance */
> -			for_each_cpu(cpu, &d->cpu_mask)
> +			for_each_cpu(cpu, &d->hdr.cpu_mask)
>   				cpumask_set_cpu(cpu, cpu_mask);
>   		else
>   			/* Pick one CPU from each domain instance to update MSR */
> -			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
> +			cpumask_set_cpu(cpumask_any(&d->hdr.cpu_mask), cpu_mask);
>   	}
>   
>   	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */
> @@ -2268,7 +2268,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
>   static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_domain *d)
>   {
>   	u32 num_closid = resctrl_arch_get_num_closid(r);
> -	int cpu = cpumask_any(&d->cpu_mask);
> +	int cpu = cpumask_any(&d->hdr.cpu_mask);
>   	int i;
>   
>   	d->mbps_val = kcalloc_node(num_closid, sizeof(*d->mbps_val),
> @@ -2317,7 +2317,7 @@ static int set_mba_sc(bool mba_sc)
>   
>   	r->membw.mba_sc = mba_sc;
>   
> -	list_for_each_entry(d, &r->domains, list) {
> +	list_for_each_entry(d, &r->domains, hdr.list) {
>   		for (i = 0; i < num_closid; i++)
>   			d->mbps_val[i] = MBA_MAX_MBPS;
>   	}
> @@ -2653,7 +2653,7 @@ static int rdt_get_tree(struct fs_context *fc)
>   
>   	if (is_mbm_enabled()) {
>   		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> -		list_for_each_entry(dom, &r->domains, list)
> +		list_for_each_entry(dom, &r->domains, hdr.list)
>   			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
>   	}
>   
> @@ -2780,9 +2780,9 @@ static int reset_all_ctrls(struct rdt_resource *r)
>   	 * CBMs in all domains to the maximum mask value. Pick one CPU
>   	 * from each domain to update the MSRs below.
>   	 */
> -	list_for_each_entry(d, &r->domains, list) {
> +	list_for_each_entry(d, &r->domains, hdr.list) {
>   		hw_dom = resctrl_to_arch_dom(d);
> -		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
> +		cpumask_set_cpu(cpumask_any(&d->hdr.cpu_mask), cpu_mask);
>   
>   		for (i = 0; i < hw_res->num_closid; i++)
>   			hw_dom->ctrl_val[i] = r->default_ctrl;
> @@ -2986,7 +2986,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
>   	char name[32];
>   	int ret;
>   
> -	sprintf(name, "mon_%s_%02d", r->name, d->id);
> +	sprintf(name, "mon_%s_%02d", r->name, d->hdr.id);
>   	/* create the directory */
>   	kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
>   	if (IS_ERR(kn))
> @@ -3002,7 +3002,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
>   	}
>   
>   	priv.u.rid = r->rid;
> -	priv.u.domid = d->id;
> +	priv.u.domid = d->hdr.id;
>   	list_for_each_entry(mevt, &r->evt_list, list) {
>   		priv.u.evtid = mevt->evtid;
>   		ret = mon_addfile(kn, mevt->name, priv.priv);
> @@ -3050,7 +3050,7 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
>   	struct rdt_domain *dom;
>   	int ret;
>   
> -	list_for_each_entry(dom, &r->domains, list) {
> +	list_for_each_entry(dom, &r->domains, hdr.list) {
>   		ret = mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
>   		if (ret)
>   			return ret;
> @@ -3209,7 +3209,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
>   	 */
>   	tmp_cbm = cfg->new_ctrl;
>   	if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
> -		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->id);
> +		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->hdr.id);
>   		return -ENOSPC;
>   	}
>   	cfg->have_new_ctrl = true;
> @@ -3232,7 +3232,7 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
>   	struct rdt_domain *d;
>   	int ret;
>   
> -	list_for_each_entry(d, &s->res->domains, list) {
> +	list_for_each_entry(d, &s->res->domains, hdr.list) {
>   		ret = __init_one_rdt_domain(d, s, closid);
>   		if (ret < 0)
>   			return ret;
> @@ -3247,7 +3247,7 @@ static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
>   	struct resctrl_staged_config *cfg;
>   	struct rdt_domain *d;
>   
> -	list_for_each_entry(d, &r->domains, list) {
> +	list_for_each_entry(d, &r->domains, hdr.list) {
>   		if (is_mba_sc(r)) {
>   			d->mbps_val[closid] = MBA_MAX_MBPS;
>   			continue;
> @@ -3864,7 +3864,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>   	 * per domain monitor data directories.
>   	 */
>   	if (static_branch_unlikely(&rdt_mon_enable_key))
> -		rmdir_mondata_subdir_allrdtgrp(r, d->id);
> +		rmdir_mondata_subdir_allrdtgrp(r, d->hdr.id);
>   
>   	if (is_mbm_enabled())
>   		cancel_delayed_work(&d->mbm_over);
