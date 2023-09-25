Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85A27AE23C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjIYX0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjIYX0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:26:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C34101;
        Mon, 25 Sep 2023 16:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695684366; x=1727220366;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v1ifVTnKbuIH7SWhPKLjk2CocERu91Yd/4yQ4kxMIco=;
  b=Mh80maXW5NtmPG2HH2K1LK1HMtETx5BDD2hImHvN2V5a3+pMgE7jP0S/
   GBoKhJ3DsvAomjwHFQBfAQFl3HQYvbxh159Ot9ozkR3EdxanWO0SQS+iM
   8kR89gDsCPqj9HupwAgo/HCGgMs2VzxqG1ZUQLHaO1bREZtElGEbVh70y
   1MAFjbmMSoHvSUTEeFVy736iM6+0oRL+0xEyBBkh4GlRIIHb3zYkGa8V6
   j5A1IjuR8aAFTa3Eu6MZDS3yQJkqh3QCZ4mu2fHp2pdueKyYFv9aO4E7B
   B+erZT3uIeyZd8BxK8OTLJkcLbwI7x8M8BxTlSNHD4i+UIUIlIHkHvNdd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="384215958"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="384215958"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 16:26:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995595754"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="995595754"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 16:26:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:26:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 16:26:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 16:26:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/jHJbHLBR8CQs+rvXFpoU5wlh7CvUGb7qg6ij8RgsAEoLdB7USHddeQ/j5AsHRi7IJBvHq9A2c/1cxVkO4FNscsrMbmgFasKx2PsT+z8K+eEXCkn4gTBL1vPyolseW5HB5qB9qnEjv7xwmmqKxuxGc94722evHpsJF8k/tIBFtM1GnwbFstJzoq1+MIXvBqI3Z/L0JPTmLyKdXpZTmeEM2bi7XkNA35TfQOLP4T5H9CZM75XVtnnysnPoJDEERk8RFAEiZNPMaGEf7YaCNWdY5NXJfvaDxzRo+XhJJqrT+aayXAxJLV6yMub0ZxdzHvyh7RO/6Z2yosBRiFVikvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkOE0FlqNnYLjk/S1hUA/2X9zgTn5duyyqyC9+gOOvc=;
 b=l95p/ZIzZwMj6zS8EBj7qdJmsgwXtL1z2qfd4JPZ5b6W51yJY9n4By3T2NATZlDPlT6QP9EH59pY1vJlnabSUjEtLw0mvtGn6jwhWORlEgwXKwGZwbuAULGxdVMcf+fmkSVsYLxYKPPCpZR+D7uRZ6sJ9mZNoPB3KeWuetQZyMvsRCNo4HqrES3hNdWBGVe3PaHnDPCXKQtIUk10KjPpsu516YlOj7RbKBqdszlL7Ub49BgsvpIjzaHpx9Gt2hoEwFE0vaySpnzmZtN2qb5vcWqabFSTmmZ3z+BJPB+rt3kI3fiE4VQeuLVmiE1Y4fjdyWdSLYJwgSMnJmaQEk2d8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 23:25:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 23:25:57 +0000
Message-ID: <5d93f726-bd43-20ad-5057-1de575809cde@intel.com>
Date:   Mon, 25 Sep 2023 16:25:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v5 4/8] x86/resctrl: Add node-scope to the options for
 feature scope
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-5-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230829234426.64421-5-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0329.namprd03.prod.outlook.com
 (2603:10b6:303:dd::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0adc46-9c57-4c90-77bc-08dbbe1ec56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vII2vpsxecpJzQqJRr8z5izri+LJr9NoNwG58NbTqX3tIw3HWCTwRVHrIsbaATSIJlYWZH6d64EZOn7idFcITFJb8R6EGxnLw/Tv30adp5NS0iT95g0ocdeQbQVexs6kbAbXl0grCA3jRn/B9RSJgN3YKbtITj8jkruE5ZsjDgOaUGgNXnUG36Y1DrX8/+TqiPxwoS/Ve02IBj/gPEspzgwm0D9sD05ITYgcnglRg9ZTygZxzBNtcqmmGfiMbxi4jk8k/oiGiay1oTw9JQmIveBHvE5iaMOD1+L+dGQ8s6rlRd1FLTqBHPxU/XNY9GHwRvOsJnD6Aujs59mPORfhjTtKQ8tI0P/t0F0RGtJJK91Ykb5Yombcya6oWisalr8+rTAtn5XvcjKE+u3XMEKK780GBOEWgBmXaxhajTyyJ5n0p52D0Z9+kRI6EBujcM0mNLbhVPASMSaVXGpVRFHstI/xccQQnsj0a7DDpLS47CPIf1wthnn9lpNCulN2/g8d+JM2FCk3os54djux6vW4xSZPBVqM2mufY3rF3JWEJdA22kNUjiUXkf8jdYuRcWenI5YzHw7/bxcMnVxKwMUzn9kakC9RE6jBqvmgBhi7+fV/Z9KkHPKgg4Zfgf4HiwtPANzAi7MQ0BcIJuYnQeP8oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(31686004)(2906002)(7416002)(5660300002)(110136005)(66476007)(44832011)(66946007)(66556008)(54906003)(478600001)(6666004)(6512007)(53546011)(2616005)(26005)(6506007)(6486002)(4326008)(8676002)(8936002)(316002)(41300700001)(83380400001)(82960400001)(31696002)(36756003)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmpzS0twaVU5d0NzQjVvS2VTMEN4Um5oMUd6UC9Icy9XMUJzRGtEOUFZWW1M?=
 =?utf-8?B?U2ZpZlhpSUtsQURtWWlhVjVCaVJjWGYyUTZSM3AybGVZTUJsME9WeDB1M2FS?=
 =?utf-8?B?c25Ycll0cVcyL0ZXVFRqZUFFa0ZTdWw5RCtteG1HUmlUcy9uekJaSktNKzRh?=
 =?utf-8?B?akcvTWVRa0JVNXhxSzlvdXNWOUJrWXRSTGg4c3d4NG9iNTVpS3p2eER0UkRV?=
 =?utf-8?B?b3Jsd3lBV0dWYWliRXllTEVxMlBTOS84RmVkcGJDZnNQRW5lUjRTeXd1ZjdN?=
 =?utf-8?B?UXZrRjlTcEJnWVJ6cHViRmd2bG5DWFBZZkJlU2JYOWNUcTBFR1puNzU3SDJx?=
 =?utf-8?B?cUVzZnVkNnhjVGdjNXJLZDlyaDdhSVhtT0FPeUlqVXpvN2R3eGlGSmtUUmRy?=
 =?utf-8?B?SG52UVRBRWJUN0o3ckxPanF5cVZIK3lQc2habStBaDVtQmtDT0g2UU5oRUEx?=
 =?utf-8?B?UUlZSkNlbTJub3NVdGs2TFJnbUNLeVRUZ0d4KzhBMUlZSTdnZS8yR0FDZzNs?=
 =?utf-8?B?YjlyNUJjbmVOUUVyN1JVMEVIYkNRZEFjTjlSbDFreGpUQTRadkN2Q1gveFBr?=
 =?utf-8?B?UUxWa2VBc2ZEMzVtYThzUHNBZlRMSkp4RnBJSEJVbW44WGRVeWdWdWNRZlNS?=
 =?utf-8?B?NzZqeDA0Y3VrY050UFJzVEgzMEtuOG8yd29jUDZ2QUxnbkFXV1FzUjFYUG85?=
 =?utf-8?B?ZGJxaXh1TnFmU3lFU1A2WUo5aVN5NXk3ZThhWlk1M3NqSStSSlU3aDBpcjVM?=
 =?utf-8?B?b3ZxZGpoWU5qdzVGSFZSUUxwYmdmTWUvYTkveWhwNDU3SzlWaWVISFRRRFQ5?=
 =?utf-8?B?OFYrWW9nSjF1M3kwdE9SY3VpRm1hZXBsaXNwdjc4MXpPQ1JvR3lvYnFUeE05?=
 =?utf-8?B?VXpYaWJKVForOHorY3NoUzJ3ZkxVejBOOGVkY1VBbDVUVUU1bm5Za0x1UXdG?=
 =?utf-8?B?WGZqUGQ2eWJ4eTVSVGdDOFBFbGZEUEZ1ZEw1blJjRVh6c01SY3NlNXBMNi9x?=
 =?utf-8?B?eEd0eUtuNWVibzBkUEp4dG43U2ptbmFkdENuSzVxZ0RJWTNhZ084c0ZZMHpR?=
 =?utf-8?B?R3h2TnBHdWxQZFg4WkVXckZubW1iWG5PamE5Q0tXeUwrTHYxREFweklVUWhv?=
 =?utf-8?B?b3h4OTJ4MkIzTnlCcE9yVkZHSlU0dDBEU3Mvc0dOU0tib3dPNTYzUkt2d2Jo?=
 =?utf-8?B?bm5CSXVVaEU1NTVqM3VPQjVJUEFzTlFiR1lhS2NyczVrYUhZaXVKcHRZU0JW?=
 =?utf-8?B?enFCUGJPOVF5ckdSRXJ4b25aQU5OQmNZOTlvQ0ZaTXlqNWYrdUl4Mk11YjMw?=
 =?utf-8?B?b0JKYzJFaWtBZWVja0UzOENvR1hPb1dEeVBZa29Oa01kd2R6MFBGL3VYK1Jn?=
 =?utf-8?B?Wlg1MHBMTCtJRWpUVXlzb1NIb3pCaFhveDZIOURCanZUMlVGNHRIMTlTTEVx?=
 =?utf-8?B?WUNYbklnMC83NzAyWU85V25idUVOSFdKaWJrVTN5dnJrM25HMUM0RDNqOXR4?=
 =?utf-8?B?SXZSTzcvVkZhRWhzQUdoT25iR0tlSkhoZkxkaXM1RkdaMHJENVZaUXdXMUZ5?=
 =?utf-8?B?d3YzdGhQOGs3akFZSlZTSjZGZ0JZQTlRL0xTM3pick1TK2ZoY3JKTHJkREkx?=
 =?utf-8?B?aE8zck4zQ2s1QWtUT1pvSjlCc3NrUERJUHArUTdXeXpuN1A4ZzNLTHMvcW9h?=
 =?utf-8?B?dWxEcHZhd1F2cUF3ZVVYWWMzUWVybzhna0dsMkZRSHdkZSt3dXlmdi9zU2lV?=
 =?utf-8?B?U2lidlcwZHNQamtlZ1d5b09oZWdHamQrYlYxT3JvV2tnVW1ncC9jQWNwOEJV?=
 =?utf-8?B?L2tCM0x2d2E3YlB5VmR5WGJneUFJVVZCY1BNNFNuVm1SanoxTGg1VnE4R2Uz?=
 =?utf-8?B?TkFUMGdoektCbjJuaDBsaStWVjVPODlyNUJKODlWQjJnWDZaZXB4MEFVb1ZH?=
 =?utf-8?B?czZoSkFPMnZlaGwvS3U2SDdhekNtUkhjOG56d0c5Y1BPQzdnZnRNMUQ5R25V?=
 =?utf-8?B?NlFEZjNrdzFXMlVLYi9PZ2dyR0Y5b3JkMVRvc2l3UHhianBaVG50UDhlM3gx?=
 =?utf-8?B?eHUraWFBa1FEWmlRV0hwR2VWOGRCMDc5aGROQ3gyTVBtN3VUc1NRTWtxSXVQ?=
 =?utf-8?B?ZDMwSkNNdXJmYWNpaTk2Z3JscmtCMTIvZzZMRmczTThLaGltS05WQWVVL2Jz?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0adc46-9c57-4c90-77bc-08dbbe1ec56c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:25:57.4698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9//DYgDJ5vnZbBPKyCoccp43XamaMKdGLHd+0NYQBzpSlx8Rnucypls71k4POcv/wMZ8QKy85UaSAeHTPjg+Nl2n2g62uWBO69FdP699rU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8033
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 8/29/2023 4:44 PM, Tony Luck wrote:
> Currently supported resctrl features are all domain scoped the same as the
> scope of the L2 or L3 caches.

fyi ... this patch series seems to use the terms "resctrl feature"
and "resctrl resource" interchangeably and it is not always clear
if the terms mean something different.

> 
> Add "node" as a new option for domain scope.

Could the commit message please get a snippet about what "node"
represents and why this new scope is needed?

> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  include/linux/resctrl.h            | 1 +
>  arch/x86/kernel/cpu/resctrl/core.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 08382548571e..f55cf7afd4eb 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -163,6 +163,7 @@ struct resctrl_schema;
>  enum resctrl_scope {
>  	RESCTRL_L3_CACHE,
>  	RESCTRL_L2_CACHE,
> +	RESCTRL_NODE,
>  };
>  
>  /**
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 3e08aa04a7ff..9fcc264fac6c 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -514,6 +514,8 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
>  		return get_cpu_cacheinfo_id(cpu, 3);
>  	case RESCTRL_L2_CACHE:
>  		return get_cpu_cacheinfo_id(cpu, 2);
> +	case RESCTRL_NODE:
> +		return cpu_to_node(cpu);
>  	default:
>  		WARN_ON_ONCE(1);
>  		break;


Reinette
