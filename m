Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1CE7B7333
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjJCVS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJCVS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:18:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DC8AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696367935; x=1727903935;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T4ja5ecv+tMrnCGKUGRCk7S1UJ/hNyVc3aPE/nviSPM=;
  b=MoGUMHTiX4ZYlfAzj+3twk+zQBgRPoPQbDgCOamvWQ2lBjD4yUOGeXmW
   qRydbue1zEny5p/WUm9uWqXm5sXHnbAVjTNoksSGHObFvw/0nms/vUy97
   GwyagGwKpw61z2dMA4HqwHsPvFf4zKU2Nqm6mMJ0KleWkrRBZNlzsfebo
   //ZRH558AH9ex580z0+GIF8Hdswiv8bOSMr1liaaMlRzI5kek88oqv17e
   Um7+SqaX+RBDe5QVbnuyaSpb7xLQTfSo1Abu0XTZO4szzPt6Fb3dA2qgo
   vovF2e/jQnQ4XVdlPjLWG0buOqBpbdUmfKY9CKTrsXhzD40bBsdE4USUm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1577135"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="1577135"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:18:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082175992"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="1082175992"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:18:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:18:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:18:53 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:18:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nALhT3sC1Mz3zEZVFabp5I5lb1Ni5ap9wEA4ik1zEYfExIT3vGw6yS8g6Y3dM56TyPbP6edl1/znGGuOTOhJXVy/o+KGd0nNGwSR5qe+J7GIF0wLvuixn7jxhR6dp2r2mIp4ilE+hhUboExxWf1nOh8CpIoE2WQO3Phqo6EA0sbhHM8+KqKQm74I8U7bsBzQhbZBcbcRoycYgoJ7yXu8rk9WtEdwKatnhawr2UDwAsC/S9Vko2E1THJ7BG5R4qiip3wCvCbAn2ulYFEiY8vpsZ99RY+ixwJmv6p5ZHzxkc7XjhSDypeNaYT5dAKfA+Y1yzxq+IbSDs0AXSbgsIVWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3HcGOs8m5WB2coLDf6ukpaQiveHWHYyi7nm2fP79/E=;
 b=cagZKZdCnfTskQH4oOSWhTgjrM0R/8aLtkWXnfdr0Ge84/TDUbAGmapDogY4XjGBYD09le/mEjIz/HQh0LjE4Cjjnx6WK3ZxgWsWVa621vRKcrMIr8Hr9qtX9TUvzV00mIuzmS2TnmqagvpPW6NOXmTmb46g/oCTg0wfHPo/L5IoaDSXbSVJ+4NANLoOr0kw1UEWHkrTlaubUvklDd60QKTTqtA4FqR4RHCFhZ7dywJVA4K2JXGC/GG8dq6P1Pn5uF++QZDGJYS2MBnB8sNBUWUpdetWMeDM8HhYjR8HUDk1WUa4KnYyjNmRNWVc4JtxvQYn+k4UhglJcsDqbXRHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB7132.namprd11.prod.outlook.com (2603:10b6:806:29e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 21:18:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:18:51 +0000
Message-ID: <2947d0b3-349d-4dc3-0c57-0a68b297327c@intel.com>
Date:   Tue, 3 Oct 2023 14:18:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 14/24] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
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
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-15-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-15-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0218.namprd04.prod.outlook.com
 (2603:10b6:303:87::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc40fa4-14cc-4385-78b3-08dbc4564bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: va33BS5XcLOvJIWgHiBxbCbSPNe8+q5kzgq4Qy4oVnhHD5lm6xgUXcOlQpvs2xfhXepjW4ElLg7YRk8Cd4/m1NwXL7fiURgx7aaBQEITO7x/7boNnQRr9w0AgocvT2SX3AG7trOgw0eWdqIPU42m2nK2iQibjIVyIPhkdZWTx+iWvYZd9l6uemoSOo+TICBuAHrVMszl8DzVUOZQfeltdEMXGJNLlsNMYNMT1hThksBkZqlioBfKMyvrt9tyTAJSb9uzYcMfG9QltXaJ44IAXEsxSv+dR9r+m4KS1/rpEVA3L2gWD62178ycRZy+RcR1NeKW5KhG7JgI8NzNIPRbCFA+v1qpvKyFSv9lUa+M+vB00/QzObJyWN7Jo4JVBKGn0+g15QK/AFLiOFywDKoK++Ova3VCSnG5Rs4ZmY7AFTPz0w5P0EGxPtOhU3HvMpKwzgKnoTtBvuQiMpmITFwUKvu819nZ/d2CshmcfGfz6azJ1U2ufrIri3kOrzqza5cMJmzar58uE6eTHYrs3XreM/umdo+dRs3jaYw+wc187jE2/Fs2TL9CV5q5Yi7ZVsREXi7tM7b2xHRfRNAJnB1wdxua6Jk/XLsRUDbk0Ei69LufLoqc+4zwltbXTTPJ67qqpKmzom6z8LNSErsOl3qNXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6486002)(53546011)(6512007)(6506007)(478600001)(2616005)(966005)(82960400001)(2906002)(7416002)(83380400001)(26005)(41300700001)(316002)(44832011)(66946007)(5660300002)(66556008)(66476007)(8936002)(54906003)(4326008)(8676002)(36756003)(4744005)(86362001)(38100700002)(31696002)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEEvdGRabWNLZjZ1RzZPWklFcDlYaHJ5U1Z2eU9xYXIydzZpRFphN0hkN1lS?=
 =?utf-8?B?ZFIvcm83SWpHeDBUSXNsNG03RDZ4NlJ1MlA4cE9VTkJJK25CejJFeWZjaTkw?=
 =?utf-8?B?Z1Y0QjczMUVtSWwvbzhxblJxRTFpd0NsWS8yeWFHMjVKYlhxcG9IalFkOXF6?=
 =?utf-8?B?UjdzOWhhUVovRC9PYU5vaDdENDZueXB5WnZJTWFIWm85VjBucFZSdWZxTzZp?=
 =?utf-8?B?cUtYL2xnUlp0dHN6ZXhUeEhXK0RhYmxDMlREemxvVnprRFhFL2M0dk1Ddk00?=
 =?utf-8?B?ZitXalZJZXZPU3ZLUjZLM3RyWm9mWEQxQnh4eEZxSFUzWVZCdE4vb0Rxbk5y?=
 =?utf-8?B?d2o4L0xVa0hkWXRQSGlKSTRpZkFUWE1hbktwKzMrZmREbUNyNGVWMUhOeTBZ?=
 =?utf-8?B?QkppUDd3Sjd1YXl3M0g2c0lWaDN4OC92Q0pMNWQrQjNMZnRWSVkrcnR6L0Y4?=
 =?utf-8?B?ajZMc05pWGhhTFM3Z0RFWGk5ZldTVkp4MHE4NHlvZ0JwbU9WT3hUaDZsZElG?=
 =?utf-8?B?eWdSYnlScjdEazd2MmIwV0lZQlE1OTZzM2c0YXozbUZ0UjFyMXJaSW5KWkl4?=
 =?utf-8?B?TVlmMmFIeVB6VWJFcVRaVlVROWVhTTBGQmo2d2tKVnZORm1BVUs1OXk4U3Ju?=
 =?utf-8?B?ajRkYkJ2eHNSaU5abEZ1QXI5RDVVaE13Z3Y2aDNnbTd0MkFBb0xsWkQ3dHBo?=
 =?utf-8?B?c2VxTkt4ZDNvUFVWZTJ6YWhuNFA5aUUxbTNZSmhKdVVBMnBkaU01RjFuNllE?=
 =?utf-8?B?Uk9teXYvTlN3eWxlTkg2Rlhaai96d21aY0pNTkdhTUJ4eW81WnZMb3BMd2FQ?=
 =?utf-8?B?RXF6cll0bnA1ZlgyUlFOVWVVOU1GU1R4UzFQY2dHUTMxZzlDbEFlaTlSVG9Y?=
 =?utf-8?B?eWtwL3h0UlY0LzgxM29YT2JjNVlMRnU3OUg4d1gyK1hVeEwraTBmd0tieEht?=
 =?utf-8?B?eGs1dFQ5bGI5V0cvTy9Fc1BQRFN6a0NzOXNINndqWUpzRW9vdWpwdm93T1hZ?=
 =?utf-8?B?WG9ycWVLNE02YjdyTHNOUXZLK3N2aVpDN3BhaUJYVFNpNDVPT3JSMVp0MUha?=
 =?utf-8?B?QmNxOTNvSjdxSElsRlo0YmNIR3N5d3NBZmpNWDZjZkZuMTExY1o3YlBmc3dK?=
 =?utf-8?B?dEdNTEZoMTJ6cXNRd3k5UTV0M1JwZXdMMVpvRWUxNWE1anNBUmZCUE94dWRs?=
 =?utf-8?B?QVF4S3hsYmx6U0RIdTRFTUtHTzVQTUpFbWdyMVlocW5aTFZscmt6SVVtNUk2?=
 =?utf-8?B?V2RLS1h0M0Z6WlNUNldEVWIyR01uWnFHVnlUTXBIU2EyNVFYWE0rSHIyeGlW?=
 =?utf-8?B?bngrTWhWNG9STm1nUjJ2Ylc0QnJtbnNJd0g4MUkzb0QvMklmeEdMOHNPWDR4?=
 =?utf-8?B?TklVUWx0Q0RSZ09tOFlTb1c5R1dwZ1FwQU11QXA0MU9ob0ZQNWoxMHp2V2ZB?=
 =?utf-8?B?T0hJcmg1YkJxaEtZMUl6Yks3MUlzc1JXMTIyQ3hYRG54VEI5S0JtMkE0Wkhz?=
 =?utf-8?B?Q21jc1dDUWZaVisweUkxK3NTemZ0djdTOGFza0RZdWQwdWhFWlZtcndOT25k?=
 =?utf-8?B?aFhWeGVjbFFFelFBRnQwUkppRXNPVnRPV1prZzZ2YU1PQWRrTzlqQVl3VVdt?=
 =?utf-8?B?OUo4MG9MOUNuaUpUbDdwN25KQmRKalB0NmhQUDBwc2VWaXRiYy9tOHhYbVJO?=
 =?utf-8?B?eGcvZTNLTG1GQm5aOXNnZGlubTNoU3ZwNDUrMjdHV2ZIQ2NwNjByVVhveXhY?=
 =?utf-8?B?TlcrZHZXNzl5OHRKQk5NM2V4VUtoOUpyMXUyMnVWVnk3Q0dGYVQraFdiS21a?=
 =?utf-8?B?MmsvNjE1amxPZkYrRlFQY3ZCVFVZR3RhZjNsNmp1WGVXeWNRV3NPVDc0V3pm?=
 =?utf-8?B?ZVN4WkhSTDNvTzN5bmIzYjU5ZndDMkVWZVkyRkI3c0lHTkU2MUFXSkVZUjA3?=
 =?utf-8?B?ZXZiZm1lODliNS90WWRDc0NCUW5jUXdTd0RRalI4a3liNnBkbVRyZS9QakVJ?=
 =?utf-8?B?UEE1YUhmYmNEYWlpNnF2c1J5cWphcitzZjMyNWRoVDlQQzhtT0t6SmtsQW5O?=
 =?utf-8?B?NGh1K1g3RWNPV09MUlMwZmF3L0MrMHR4NG1FaTkzZFFUbDZjYkpSbVRSUGxM?=
 =?utf-8?B?YnNNemJNZWFQYi9NN1VuditXc1ZNb1JmYnFSUmxOeDllRzBGa2MxWXVCSzdN?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc40fa4-14cc-4385-78b3-08dbc4564bfd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:18:32.5414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8a69iIAjHReTr/T7/U2MTjs6KoL5G8LdY0Y9tvi9yerPAS6OdcZ62WgDBQ9XRvZ5DutAne7e7g1VI73UO8aFmnUQf0TjgcZoaZVR7qNImYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7132
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:

..

> @@ -245,6 +250,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
>  			   u64 *val);
>  
> +/**
> + * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts
> + *
> + * When built with CONFIG_DEBUG_ATOMIC_SLEEP generate a warning when
> + * resctrl_arch_rmid_read() is called with preemption disabled.
> + */
> +static inline void resctrl_arch_rmid_read_context_check(void)
> +{
> +	if (!irqs_disabled())
> +		might_sleep();
> +}
>  
>  /**
>   * resctrl_arch_reset_rmid() - Reset any private state associated with rmid

I was expecting the above to look like you said it would look [1].

Reinette

[1] https://lore.kernel.org/lkml/9d69d0ca-212d-9b1b-3001-9f56731e48fd@arm.com/
