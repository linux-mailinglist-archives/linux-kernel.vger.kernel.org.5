Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF87776C33
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjHIWeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjHIWeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:34:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BC5DC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691620444; x=1723156444;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lZfZyJeU6GHmlNxPpyhmI+p5i4AY86wSE3tirbcuiPY=;
  b=fjjY6C4KpnUKVnrbHieK2ybDc2Xf1OPPjLwdYTBLQsBFf15DVpYZ58KM
   Npt+8cDok9zBnOnB7WE6N975XnQ2U1YhbMEupWLxayRskezFtoZK8K66a
   pr+HXatRXE/19MGYFhZdC9GEiifvLhyWD0a5XpIrrFoXQAOg99Vx2tHjq
   OcLl7w/Ff9ZEhtm2s3E9hIXVWKLZNlXA2jqOFOKCKIMfkLYi1LIUTiibr
   52ejdmdE2O+QJ2/PK2S2NDEiYgDcftNzsK92g1fu9kiHBd9beBy51TOZq
   Lb9jAtl19gwQWqkngpxU2fnnxTLCMQgCv6yrj3KE272My7WSauHlWSpVl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="350823809"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="350823809"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:34:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="731979185"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="731979185"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 09 Aug 2023 15:34:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:34:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:34:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 15:34:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 15:34:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0uYpfTFZNcw47EVGvPwjgn9e7r4nd0lVXyQSceYbZdyQdloe6/HAsW3ZLBHI55xoQV8nZVcNquTiyNyg1X2oAenvPOsPtF5F8Jr+xkljdLFg1B7xVStZNrUkpIWVVLL9uEyrum8sPZllpypgce8xWWco/0gHwaKuXVfdtxLt1iUXD/gTSpL7PvixE06fVTG+8X3VX6tj2X3r1+lAKHXudXa6Q4UTnPZZxyAOyZ51/Gi8bn9VdusjJRbyAZ+zEc8qa0Tf0OG4OkoXHdm3V5pJrqQFNoPcnCmtiEQmm1dytRIo2U/5ovBD6SOClWse1LmW+9jX08k99yVgVwPY/jT7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Th6ZOjoICkK0qsPqFWm+idNZRm+35n/7Q6n+jyNHy8=;
 b=YTj9scgOa/nH/IDKRoKIVegw8Yg8XmmYv0AvnHYAwWtTJc4NdPk0dJZIwcMR0RdfGO1tEy5pcxOJc9roS8KYlf4WnZ6Ff/S/pLKdf9O9eoWBr9x4IhlU+9IdHzRwXpIdvlFlaZ1nKhk5LpHEHg8KKzHjDpIx1TiQddl9/R1jyFhYzyaMhbpHBmfg/hLfPvSvETSKQVuRK4VUz33FPIGzt/UUC101QJawqYM9Ao/kVlmqJnjPLGNbzGZJ5SCDNEouYrQUrzwmSlVrfVg4NIwMVbYqH+IQKTHTVSN4g7TNTTzm1tBlCb3QskdFLa16mFYX/dVTY18xrhjD2bQfjUZ+zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7413.namprd11.prod.outlook.com (2603:10b6:806:31a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 22:33:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 22:33:58 +0000
Message-ID: <03cd7ac4-b58d-c7a8-7cb9-ebcc770d21f0@intel.com>
Date:   Wed, 9 Aug 2023 15:33:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 06/24] x86/resctrl: Track the number of dirty RMID a
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
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-7-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230728164254.27562-7-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:303:83::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 88371f76-163e-4c32-8ab2-08db9928b8e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYn0Qcr4vNglYj7v9KlYXNUyt1NZdKfIhIbK/pk2U0jVo4vqpFLAruT0x+m1P18n9GTdBOlPLsWcuOXqIpOfS/Qy/Xfq3XehOPyZvNgY+XAXd98tJRs5NgpW0fSVFjq7txpPCX7Wth42mleoIu0XR7XWFPVifQ5ST+JVBD1G3OYslaR1c7uQjg+mO5YUYe7syxMp3CIIlzYLGtZkhgGQi32jcQKQJK2lVRRy2uor9VIzuDnPkJXWhkqYr3NSuaGZgtsUnoWAPooqpIEuLzlH/2m55nMDts4EhUwmhpbbeOhiD1naBhIvPRP9f6J6DtbNm2FK0WIQ4f/99J/T/g29/pJX+dOn/8qq7W7doDq3rpHCvx0KtfmIhjWZs3c3bZaAvUu67cHctXgIO+2TgFky6vHjUws+f6nbc/HmuVA38PgxD7xB/jgzV4geUwXoyreNfDCf/J/682QZpwGMNX0mq/V4EmdgbAoHGQd1DWrI/IDxhPsI5r+oqF+qXJ7BtewpuO34UXrIaQN1dRzc5ZLK2Kv4Wr5thZx34ev/MoZa0m1MCz3mOUP9fFg1dno8nVNPTHbX0L/ie3YEo0QteRYPw0zMiVcL9CMX4ntdCswiLOrYerOmQc5UWBWDJTQ8uMGbfpnv4P0WLADfh6gd4f91x5P72ahijISM/VHLON4ZObQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(366004)(136003)(186006)(1800799006)(451199021)(26005)(8936002)(41300700001)(2906002)(44832011)(5660300002)(31686004)(7416002)(83380400001)(8676002)(2616005)(38100700002)(316002)(53546011)(478600001)(31696002)(86362001)(66556008)(6506007)(6486002)(54906003)(82960400001)(66946007)(6666004)(66476007)(6512007)(4326008)(36756003)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjhSZEJva2V6ajF2NXAxMk8vVzY0MWpGY0c2ZVB6bkkrSVA0dWE4RUtmTktW?=
 =?utf-8?B?SGZpKzRrZGRVMmJUQmM5RmI0UjdaeEhvTmdNZ2lmWHhXcUlIN3NWOGlSMktB?=
 =?utf-8?B?Y0t6cTY0RFVKZWxYYjJhaGh2QnpYMGw1Qmk2L0lvRWdCbHRMUEUrU0xSR2Y0?=
 =?utf-8?B?SkNuUzYrQW43QkpWdUJVNEMwVlVwbTFzc1RCSWVSUEZwQkdrc0pkY2JwM3BU?=
 =?utf-8?B?dlFpaTZZQXRRREJnZEQvQm9xZlJMekdlUTV2T0xyTEN5a0tIYXBxVnVQU09Y?=
 =?utf-8?B?QkxuR2prbDRmQTlOQ0RUTjQzV1g3Ujh1Sk5lcXhUSTc1K0pSS1FiR3o3THY1?=
 =?utf-8?B?R09ESVVZaW5US1hjdDFrMjZMbVVyR2s3VTBoVW0rb1FtRTBLc29mY2hWZHdp?=
 =?utf-8?B?S21TMzFWZHB4SVNaU1ZoVXdIWU1RK1psbWtuQ1hUNE8yMmVPMjlCNHZhcnlJ?=
 =?utf-8?B?MmVBR3VpbHZrTUhqcldKVDZTR3NCK0xaN3VrTFREbGRzb1p2K0I4RnBmanRP?=
 =?utf-8?B?WDFCYkNxRjdrakU1Z1F5SmRWM0NOSzU0OVZFc1BFQUtzQjF2MUtpY2Zacllp?=
 =?utf-8?B?YkI5RUJ6U0tIYnovTlU1YmNlWm1lUzZHZzNwNmEybkdVUjBMWFRlTEJxNVNs?=
 =?utf-8?B?ZG12eGxzQ0RrSExVR1Q3UWgwdkxoYW85SlRCc1dONzRqVkZ5Y0NoZ3V0clRD?=
 =?utf-8?B?alMrclBCNVN3RklEWUFNS2ZhdFozNTVWZW9NRnJ2NTh4ajAzRFUzdzRqelhn?=
 =?utf-8?B?YWRjVkZoYzNIV2pWYVJoZy9ucVpyVFJCZGE0Mm43bnhlT0lFRGNGMTNRaWlu?=
 =?utf-8?B?MHVyd2tGY2lqMmNSdUI3UmdTUHF1RGZQNmlxbWE4NUxzWEtyblc4TVlBQmkw?=
 =?utf-8?B?cEtFME1rZ01rWXRXejc2UE9Qc0xJOCtIZmNOelQrSFp4clh1Z0g5NXFFdEpC?=
 =?utf-8?B?cFNlVWpHY2NOSERPY254WEgxdEYwcmEzLzd2eE1uOXBHekQxV1RRUzgrVnpH?=
 =?utf-8?B?SnA0YVZsYWI2Z29SR043ZFN4ZVpETWNpbFcza3ZTZ2labWwxT0t0RE5meERS?=
 =?utf-8?B?Sk5lbGZBVzlwZzhoUnpCOXF0V1FnZGJKRHk3ZlhGR1ptMlo5OElMWlJDQk5z?=
 =?utf-8?B?VjRUR05tUlQ4SGcvY0diNjM1ZWs3K01YVFd1bE9FdUdHR3cwb1UrRXV4L2p3?=
 =?utf-8?B?MWd0emlUeGxuWXo3ZENGM3FHRzY3NzBUdlZqWVFETm9YR3VDYmdKWENoK1p1?=
 =?utf-8?B?YjRMb0I5emphdWYyaVpBNDdpMHNmQ01DWWs0aTZubTBXRE1qS2JvRURCaXBM?=
 =?utf-8?B?YnJ5UDRla2RSbHBxY2hFZDhLQnFTd0J2V0JBaU5qejZQS2YwZVRaZ0ZOalJH?=
 =?utf-8?B?dWc3VGUzdk41dFNaQ3NXNisyWndDaGJkVW1NemhKVUhKcmhrZVlZeHJKampP?=
 =?utf-8?B?ZWI5RUpVd2J5MWFUbG9Vem5ZNkFhOWJUNm5wTm9xODkzL1hBandVOGhUVmZq?=
 =?utf-8?B?MC83aWVhcTNkbGk2dks2YXBUWU15RDBOUCtPZlhUbzZaSzAzZHZaRkZnVDly?=
 =?utf-8?B?TUgrOS8vd3VOdVZwbzZtaUxIV3JsTTdlQlgrVTFLeE5XK3hDc21UVnhxKytV?=
 =?utf-8?B?YjVScGdHcllVM254ZGNWU3YrTXYvUW9zTnhQa0NOUnNjY3cvVzRJY1Ezb3E1?=
 =?utf-8?B?RUYwMk9QUjcvQkJDOXd0VVJrbGZSNXVTQzNseG5qQkpoYUxVT0NiV3JGYWRD?=
 =?utf-8?B?T2FyeEoyVUtvaUNFMllsVFJrUGtFYUN6K0hSYVlUb1ZwWGFWdzhNN01kZ3Bm?=
 =?utf-8?B?S1hFejdEenQrZkVyWWpHbTVhb1F1UFRFODBLc29ra09QUkUvQ3h2TmFybjhW?=
 =?utf-8?B?UFUxZGxGVnEwSFh0WC8vYlp1SURQNXUzNEMrWmJGMDgrVk9OMkx3b1NmUW5F?=
 =?utf-8?B?UTZvUmRXeUxteWl3QURpOWsrUUplVUNrUnNGNk8zWWt4S2Fudy9qdGxnOVpC?=
 =?utf-8?B?VVhvRkhYb1JhRXZmVmZNOFc5Tm9vcFo0RUF4N1JOZ1dnSG8yNERTcFpqYlBE?=
 =?utf-8?B?YTNPbXZ5ZiswdVZuUS9QQnBDQXF6Uk4wcC8wRWJ2WG1aM0JoOHo3eUM3bVlr?=
 =?utf-8?B?Tkl5eWE4aTBXQ2F1WE52OFZpOHFMOU5QYURUYTJSZ3hJY1J0dTRJZ3hNcXRw?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88371f76-163e-4c32-8ab2-08db9928b8e0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:33:58.4411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFV7zJdBAf+UO4J4pEYHBJYEP0BXj9BSfky18Pc2hgzy7GfDY1u1Cr93RhskRJKPpGwXJIzukXhmAIUZU0j0+0+jpNEZEeNf8r2eyZQ3oDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/28/2023 9:42 AM, James Morse wrote:
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index de91ca781d9f..44addc0126fc 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -43,6 +43,13 @@ struct rmid_entry {
>   */
>  static LIST_HEAD(rmid_free_lru);
>  
> +/**
> + * @closid_num_dirty_rmid    The number of dirty RMID each CLOSID has.
> + * Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
> + * Indexed by CLOSID. Protected by rdtgroup_mutex.
> + */
> +static int *closid_num_dirty_rmid;
> +

Will the values ever be negative?

>  /**
>   * @rmid_limbo_count     count of currently unused but (potentially)
>   *     dirty RMIDs.
> @@ -285,6 +292,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  	return 0;
>  }
>  
> +static void limbo_release_entry(struct rmid_entry *entry)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	rmid_limbo_count--;
> +	list_add_tail(&entry->list, &rmid_free_lru);
> +
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		closid_num_dirty_rmid[entry->closid]--;
> +}
> +
>  /*
>   * Check the RMIDs that are marked as busy for this domain. If the
>   * reported LLC occupancy is below the threshold clear the busy bit and
> @@ -321,10 +339,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  
>  		if (force_free || !rmid_dirty) {
>  			clear_bit(idx, d->rmid_busy_llc);
> -			if (!--entry->busy) {
> -				rmid_limbo_count--;
> -				list_add_tail(&entry->list, &rmid_free_lru);
> -			}
> +			if (!--entry->busy)
> +				limbo_release_entry(entry);
>  		}
>  		cur_idx = idx + 1;
>  	}
> @@ -391,6 +407,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  	u64 val = 0;
>  	u32 idx;
>  
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
>  	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
>  
>  	entry->busy = 0;
> @@ -416,9 +434,11 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  	}
>  	put_cpu();
>  
> -	if (entry->busy)
> +	if (entry->busy) {
>  		rmid_limbo_count++;
> -	else
> +		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +			closid_num_dirty_rmid[entry->closid]++;
> +	} else
>  		list_add_tail(&entry->list, &rmid_free_lru);
>  }

This new addition breaks the coding style with the last statement
now also needing a brace.

>  
> @@ -782,13 +802,28 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  static int dom_data_init(struct rdt_resource *r)
>  {
>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> +	u32 num_closid = resctrl_arch_get_num_closid(r);
>  	struct rmid_entry *entry = NULL;
>  	u32 idx;
>  	int i;
>  
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +		int *tmp;
> +
> +		tmp = kcalloc(num_closid, sizeof(int), GFP_KERNEL);
> +		if (!tmp)
> +			return -ENOMEM;
> +
> +		mutex_lock(&rdtgroup_mutex);
> +		closid_num_dirty_rmid = tmp;
> +		mutex_unlock(&rdtgroup_mutex);
> +	}
> +

It does no harm but I cannot see why the mutex is needed here. 

>  	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
> -	if (!rmid_ptrs)
> +	if (!rmid_ptrs) {
> +		kfree(closid_num_dirty_rmid);
>  		return -ENOMEM;
> +	}
>  
>  	for (i = 0; i < idx_limit; i++) {
>  		entry = &rmid_ptrs[i];

How will this new memory be freed? Actually I cannot find where
rmid_ptrs is freed either .... is a "dom_data_free()" needed?

Reinette
