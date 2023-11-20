Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A48B7F2016
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjKTWTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjKTWTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:19:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6F497;
        Mon, 20 Nov 2023 14:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700518749; x=1732054749;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cxt8nFi3dlYOZf3FxecGk/2zhBHohoInJUhgvXH+1B8=;
  b=a3Jf/Po4C6bkVduaMZ+fkRIiXi0uLyOjQq4FJ/HslsPgcQ7EnQH2wua0
   PJj2lmYxHMtb5EnfV7GE9mlNOL3kJAmwt8Q0cDaR8yNTvMrJXmbbJPN1U
   53Po2f/+P1/nwdYtHmEGCwUV1TOAKq4OXBez3UaE9gaSQEYnT5R4GUZAf
   0Bz82uG58EQ7qwBkWl4IP8naGfK9B3NFLzCN/veLrs6n5SAOJEiXXDotI
   z/S0nRLWLmFevYA44SylNYwU8qVKNCtn3ReGzcCDpzMyppP6ehsaIP0Yr
   z3LYrc7jOnf4UVP7U9P/U5kWhfYkoJpfK+cnNzGGvhoXg0BVPNuBvtj7l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="390575090"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="390575090"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 14:19:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="939910692"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="939910692"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 14:19:08 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:19:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:19:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 14:19:07 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 14:19:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXSuwTncbyXZwahpoOIoYtbFv6OdqHzvZZ76W2FTq9XLxXR4dtqg1l9eoXt48PLqfyUnSLuR8cBbdZzZ8BfXHxynQ2sXdV9WjcVY4CKwh8AAop0AA61RZtw6wUl0Xmi3HbLhIcT1tlNYmO3KVbGkFISjFF794DD32mWeag6rWtfxoe8UImhDD5DCj9ITJa5VjKTY8IoScIm/gnm+jpXubxS3fXq78f1GyOTAyZcVT9UNt3GC/tMCp6QXTJFqfQ4wKIhDCg3prOkshAlWm4+g4o2sXXw3Y/wVZSsp7xUgRK9EkW1D6FB/0j25LNCk7b4h3ckEcCeHsl9JywsbtCgdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUWnJ+3q+KTm0IokQ3lALv1leSTudXHQYyPUtywB8bY=;
 b=kKCLFCkVoIyiQW9om7We+7dqJok6+N9TGyLzd3OJoCXqfh3JKqNQFJv1cX6eoweUk+ve2MAMlI+tCfMpsEnouu2ybU9pRXl9LH0ZYmPv8+pTmdZUwWzH3Rm8m4JHsBRYhS83lCk3fZMlTNtfCUjumG7+LhB2vAD52Y/gFVfl8HG8eqAnaXv49SlRcR7N/TRdSWQPLhw18AMs3XapRLMub087fkgqDO3+Vss9yJwLemjJ7q4YwXoBFtcAP+0hfaXYW8qAjwr2IFgAzxwpJ7DG2dBLMB2m46tyAwoCBWtxh2oOKChEp7oGXNtyRoc1VaUmluc656IMU8BDAXAHiF9B8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4678.namprd11.prod.outlook.com (2603:10b6:208:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 22:19:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7002.019; Mon, 20 Nov 2023
 22:19:05 +0000
Message-ID: <e2dc025e-4776-4876-961b-470a6273b8e8@intel.com>
Date:   Mon, 20 Nov 2023 14:19:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/8] x86/resctrl: Prepare for different scope for
 control/monitor operations
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
 <20231109230915.73600-4-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231109230915.73600-4-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:907:1::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: 49dce4f6-dd75-42f7-09cb-08dbea16b527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RudOWpLaXF0R/v6kzb2J3WSTp7synWoKDQT7DdxaucOvljPEtNHHoxmbCk2cdKUkTSC2lsZPJFC2/1L250zPsLzKVOE16KXwc3uCgHTfDubQTk8syMYfk7Y+Cl8e7VzgKVgFZSmaEHTXHByxIq2dC492z5eo9SjSmNd1/OyWYONWPko7OxiIFenwWbJHm/wA8qfqwqOM8p5YTRgj7IDBZp38YE5SekJmuxjIvzlsd7VmfBfoIZrjftF8uzg3pZDsmJQlKkhMgvxyB0AiZ/7zdGpUhBrpsbQaCcjoeqXNBroB8HsejW68UIM847x+CMGc7hHwFN8RkYCl33QTvQiEcEUVi7rxHH98ZvSqkEH2FiVbPblSDefH8wPdcpkfbulIXXlm0S9yK5ejstHaGVj7sPuHltTB5rMgGjL8c/CGTW+0/Qz/xZ+Wb08oClr0qnAbzoiOV5kM/RuZfm33X/e9BO0zycQP5zJnKarTFCiVJS12S/RaTjThEtKi11OJ5FsUWJ9q9WO3bWubSIChtO5qgUIZNObDWApzRClJuc6dzH1AyAlBgg/4nIRaGsF4d1OlGQuuALLT5kaeRWXEahXMXz3kzD9LFloJCzCLAvs/bmE6QsMvyNNd2DfvZJfXviPLux0M4Fkxy/FH+ZztzN5YBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(44832011)(5660300002)(31686004)(2906002)(4326008)(8676002)(8936002)(41300700001)(7416002)(66476007)(316002)(54906003)(110136005)(66556008)(66946007)(86362001)(6486002)(478600001)(6512007)(36756003)(53546011)(6506007)(2616005)(83380400001)(82960400001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGVHazRwRGlxN2dJWlNTS2ppcTNSVUF5aDJHUFNOc2t5WHVTdDcyMmxwaXh1?=
 =?utf-8?B?bUlHNldvUjNhQ2VadWJINHR5ejYyY0M4OEN6YlpzL1RUODhkckxDZTkxSUw4?=
 =?utf-8?B?Y1lzSDgzZlNCYWEyNGhUMm54eDNUazFac2F5N0RZd2pxS0tDdVpSdEdUb0RO?=
 =?utf-8?B?dUJnM3FVZTd2cThtVGNyUkp1NG0wT3FxeHVkeHhoN05nbEprNXB6TUVqaWVm?=
 =?utf-8?B?Sm1hQldxcW5Vc25CbkpqUnNKblB1QmpDdlZ1Skt6cGhldVNKdk9TNGU0czJR?=
 =?utf-8?B?V2VoQnVzYXpJL0QrT2hjMHBzUllJcmx0ajF4eHkyMTZXUUdDWVV2dCt3L1dJ?=
 =?utf-8?B?UnZNT2thc1MyL2lLZlFPNEhFa2ZjaUNHM3ptY2c1TGtibS9mV3R3VmRoeHU0?=
 =?utf-8?B?OVVQUFl6ODhJb3pTYmlNaHRGeFVqN2lCKy9FaXVJMmMwejNwMzd1QVZjNzBD?=
 =?utf-8?B?RmNsSy9kT3I2U1V5UHVTdkNIOG1VOXJ4RVdQWWF5d1BFSEJySmZsU2hFZDBz?=
 =?utf-8?B?dVlUZkNaMG8wNEhSdjZzYUpDQlp3U2ROeDRBYmVRUlBJZEk3eEJSendoYjlW?=
 =?utf-8?B?eXpnekFlSno1UFpzRmpvWTEvTWJmbS96c2dRZzRqSjFORXYxQ0d2V0w5U0Jp?=
 =?utf-8?B?dlJWVEZFUmVHWEpFWkdTWFB0c3F5N293QWh2MHRaY3lURkExcEJsc3Z2WFc1?=
 =?utf-8?B?VWVNMDZoTVVxSjdwRG1GMjBjMXczaDRwUzljcW1Dbmd1TUdBYXhXNTN2TGM3?=
 =?utf-8?B?NkwxTXFMQzUvYjBRMTExYXoxRThsWS9ucnNTNWR5NDFiK1BWaWRKTzRrWkdE?=
 =?utf-8?B?Mk9OWWFyMlFaRndaNkdaNkluRWhUajJEbmZSaGJUZTBDWXdBcjVQQ2x1Y3Rv?=
 =?utf-8?B?aHpLdnQvL1Roeml0cjM3ak5uWDZ0dW1wRWpKWHlyQ0VyQ2xxOW1lOTl4bzdE?=
 =?utf-8?B?RW9sUktzYlJEOTBTVWdwQVNGUTd6L0NRS0VONUxFUEVKcnNqc0Z6Vk1vS0JM?=
 =?utf-8?B?TXV1Vy9FSWp1bURGUjVYTUVCcGFBVFYzQlhlcjJpdGw3eWtDL3M3T3JNUmla?=
 =?utf-8?B?cVF4SzJhblJqRkpWdnhrcGMxT3lwUEI3aEJwT3VLT0xTTzdhc2N5Zk1hNkpp?=
 =?utf-8?B?Y1FKcXVmS1NZSTgzZjFieGJrMVZqRlpYalBabWZqNUxUTzVycjJOSzJ6b2cz?=
 =?utf-8?B?eng4VFQzNTZ0M1gvNFIrb1Z6V21VWWpIR3hrYTI5TTZrdVJHeHlqa0NYbWJ0?=
 =?utf-8?B?b3Zqd2Yrc2prL1JPNi9tWFg3NTdnQmRSK25NdjRkZ0VCSllpN1lMelhyeUdV?=
 =?utf-8?B?RlFuNXFFWlZGbUE0WmhNQWRhVms0V1dTeUZOYmY3TzVFQnJQamJMd2k3cUZi?=
 =?utf-8?B?VHpSZEpGQUhwWGJRNFRrcnNLaVZEZFBzSmZ1TDN5SjJ3ZERHNTJPM3IyaW1K?=
 =?utf-8?B?cFRheHRPL0grODF0dG9hYmpJdnd0bE5aY3FGMVF4SUp4WG9lWmJyU3Z4QzNZ?=
 =?utf-8?B?d0ExSDI1ZjNCcXlXVlZQQy80VWYxRXdVWlpqT3BpWllERThYUTc2M25qOUZl?=
 =?utf-8?B?bmI3YjZhZnRnSzBoWm0rNlVleGV6RzhKU2hmTG1qUlpCU29vMUJLWFR0OEV2?=
 =?utf-8?B?dXBjbnRaMlNuNFRkY3NGS1VFcExlejRrV0oyMkcrRmJPY0xBbGtsWjNBZHdT?=
 =?utf-8?B?RTlnODZmNzQwMHgyanBadUJUV1FLbmpvNDAxQlUxRTFZR0NsTHUraDRJd2pw?=
 =?utf-8?B?RmlUZHQrN2xlNmtkdTdwRDBDM2lYMnZxSkt1ZityeURaeUZqNUZBVm50SGVj?=
 =?utf-8?B?dytrdzB3TUhhc1pwNmduem14VXlEZlp6OG9qSzdtcVlsbXBhRVk0NjYvNTl4?=
 =?utf-8?B?ekVNclI3bWp6TUJySnpkcWNyMXRlemV6SHZRTTVaUXA3OWI3T1RnZ1RwTms2?=
 =?utf-8?B?UGtha2QzSGYvK01vN2Y0OGRGK3RQcVlNOUpUcDltOWZ5ZzJOUFRST2RVWHZy?=
 =?utf-8?B?VXlESUVnNDBwYmJrOUxwV1hUZmVWczhyQitvdDN6K1J3SjJLMUVRbTU1YW8x?=
 =?utf-8?B?TDIrUldKKy9iVDFTTEJvQUJwTWtlRU1aOWs4S3p0ZUY2Z0Z0bGR0VVMxaE0w?=
 =?utf-8?B?NXJYcEdBR2J1YS9YS0dTNGkyVDV1YWc4eHAwN2hNUHFhSGFWVkpHNzNQZXZ6?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49dce4f6-dd75-42f7-09cb-08dbea16b527
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 22:19:05.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwAlg4Ub1CAjBq6e6vQRp/K+hnjf3d4XzaFnBN8UQCOqAmD5sVK5kEFTDMnJ21932FGos6CSVW9sQTPh2vlR7NBAFYBK9jkwZ8Q3Nh0tzbQ=
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

...

> +static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
> +{
> +	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
>  	struct rdt_hw_domain *hw_dom;
> +	struct rdt_domain_hdr *hdr;
>  	struct rdt_domain *d;
>  
>  	if (id < 0)
>  		return;
>  
> -	d = rdt_find_domain(r, id, NULL);
> -	if (!d) {
> -		pr_warn("Couldn't find domain with id=%d for CPU %d\n", id, cpu);
> +	hdr = rdt_find_domain(&r->ctrl_domains, id, NULL);
> +	if (!hdr) {
> +		pr_warn("Couldn't find control scope id=%d for CPU %d\n", id, cpu);

This error message seems strange to me. Shouldn't this just be "Couldn't find
control domain with id=..."? Also, can the resource name be added in error message
to help user dig into cause of error?


>  		return;
>  	}
> +
> +	if (WARN_ON_ONCE(hdr->type != RESCTRL_CTRL_DOMAIN))
> +		return;
> +
> +	d = container_of(hdr, struct rdt_domain, hdr);
>  	hw_dom = resctrl_to_arch_dom(d);
>  
>  	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
>  	if (cpumask_empty(&d->hdr.cpu_mask)) {
> -		resctrl_offline_domain(r, d);
> +		resctrl_offline_ctrl_domain(r, d);
>  		list_del(&d->hdr.list);
>  
>  		/*
> @@ -596,6 +654,38 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  
>  		return;
>  	}
> +}
> +
> +static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
> +{
> +	int id = get_domain_id_from_scope(cpu, r->mon_scope);
> +	struct rdt_hw_domain *hw_dom;
> +	struct rdt_domain_hdr *hdr;
> +	struct rdt_domain *d;
> +
> +	if (id < 0)
> +		return;
> +
> +	hdr = rdt_find_domain(&r->mon_domains, id, NULL);
> +	if (!hdr) {
> +		pr_warn("Couldn't find monitor scope id=%d for CPU %d\n", id, cpu);
> +		return;
> +	}

Similar to above, can this be "Couldn't find monitor domain with id..."?
Can resource name be added here also?

The rest of the patch looks good to me.

Reinette

