Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D394A7DC1CB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjJ3VVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJ3VVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:21:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B950E1;
        Mon, 30 Oct 2023 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698700879; x=1730236879;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y4wzabStVI2xztinhM8nYByQ7EQlrwstoxkQZ+k9nc4=;
  b=bvEXRcIqINYqvSDSRYB1+EGPhGQm8F/UdNY+pGoRcIwP4x3eA4FKiwi4
   3iq47ehxrVvTtjNGb0XxmpK686Dd7AEqocVzFQ9Xi/zI1Iqk6H/aO8SLS
   iI4YLyU4cBtA/LU0T+xUk0Mv41l+bNQnsznwR4VZu5ACcWrCAy1ojNaZy
   +31WHeIbi0ItzbytqXLlAR+cm0RJLnXAs2MAf00vlZHsrkaIPJrmJnJLv
   n0BTMyE1AzYoBim02im5kCHui9/4AoPBNvbNmU+5QdtcodM3aDXjjXn1Y
   1irwvO3+mdPJlKxUlip1hf8ET+lSBnVesRy0+gnDVxGF7PZWLgmD5XyHE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="367511491"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="367511491"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:21:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="736867348"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="736867348"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 14:21:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:21:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 14:21:18 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 14:21:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ug1IIlx/SkcgY6DSQtOKhX1bhm0mf6X9zt6bDZ63auHSvPPc2WFVZAoqQKI5ysIzT4OWLB8gOlQurl8WI2dRQt3ty8J9zHbJy93NZ++cWcJSWp+bhzw+802UCXeQW798JfaWOLfsj4cshjc1aIbwd+Cs9agbOTZ0TDNhtUU/DaWApsa13hjv+BCqRk4esQZfIErs8ZHnUgUYUEwwhlrBMa4ssncQODJJYA+le7GCOf48lesXx7TfITkW1YqlbxhXmrHDT3ioZ0w00ucOXDAOALRvbDsXvDlILfpe+vp7FzBomoGCRGbWF3nz3Sqoa5gqKZ+XXF9Q+wgg4s5ttI1irA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYLS5Xofwvt1pKe8h4UJ7LyByR2KvurowOa4/bQeXWY=;
 b=OGZ06ksKwV3CIG9C4+9CFXUp8T53IPb9FffEeVh23MHV4mpc2ZrGGqofczIaje9YURQosZAfsIa26/Zs8vy+LxDJkD/5JlnraYBz57ekdKOYatyvnXrG0fnc/Jd/cKrEza/AHWskZse4/8hLt7L37mowFYifrAgenyh3RMZ8T+gS4yNDvIUCBNVhtelH0t2M0WknDcc27fK3EwkMm7ncD1ehe0/78gWphntpZQFjh6Ql8L0XNBpiqgB9/K/7F/u2MecKLLE8S/tapJgvKzS94rM6rYoInC6d75xAErA2HTYL/wbUXUYN0P2XhpAmQVq6SF2fcZDg04JfIyWdNxD7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB8136.namprd11.prod.outlook.com (2603:10b6:8:159::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 21:21:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 21:21:14 +0000
Message-ID: <2143a2b7-bb11-44a0-82e3-a61e9df50f19@intel.com>
Date:   Mon, 30 Oct 2023 14:21:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/8] x86/resctrl: Prepare for different scope for
 control/monitor operations
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
References: <20231003213043.13565-1-tony.luck@intel.com>
 <20231020213100.123598-1-tony.luck@intel.com>
 <20231020213100.123598-4-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231020213100.123598-4-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 23223447-f67c-407e-a9e3-08dbd98e25c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6oEb2ZWzSbbzSYusv0ocYNXtJOQk4chJSjSgFzzKla5UQyTwejiySjB5rIdF/ihpl8ZapU2H3QYhDdyyjZz/jmupRa99W+9IXguoyqW3kXeod6U/ZucJ3SOaUHD6GMuBWNWlAhvisknaaOddZOmTrqM91J3sbsKksTyBXib7bigbZP4eXmx0AZ98K6xY2nZe9HQH/HGa7222dyZCuvYb8hfDd8/oXmw7/D91uvxhTx2bQ+Cak6+i8S1iXOWYVSMGaeqRgk7dBYZ8AWY8XnRhsMuj0mocxB3ht0yv5QCx1v1mAy1xX9XrYvjNlmfvtrWZGJGqFOJ5FA5shyLKKDdVJz76Jf2plLEo8iJJJqh5fq84lcv2pda+vR70B7JJ5nqLhirTEFNnoYdiDiat86aFziqnLglc6g5gXaJPvs0PmY1cL2C2yqJJM/jyFzNsvT41sueeSrsiG+NOntikjmIVp+iTt5ZwhhirwCsCmbv/Lu625tW3iKx6iNdxvNyAOxLFNBVEL3upwW451KjteWvXytVKFOuUpOTBjV7ySKMZRj4Fhz4PjKwDvl5JOdxWV2IjjIRpc58+4u5vwAjAlchk56xrzrAHkwZ+iwuZNUWpGlDXq9DB/os0iXEEcIivdRBB2f7WV94zroH0Pz0VmsXP0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(478600001)(110136005)(6506007)(966005)(6666004)(6486002)(66946007)(82960400001)(83380400001)(36756003)(38100700002)(2616005)(41300700001)(66476007)(2906002)(6512007)(26005)(66556008)(53546011)(44832011)(86362001)(31696002)(8676002)(8936002)(54906003)(7416002)(4326008)(5660300002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US9DN0NRRGg5NzNRbHdvMnRRSjdXL1ZNMkdJdkliQlNqSG1jZ3V2YWhyNkM5?=
 =?utf-8?B?WHgvUmhTb1ZGZC9HSWJERUtubFNoUlkzTlNpaEd0VXdYWVQ3MmFHQmxBQjhQ?=
 =?utf-8?B?VHJBdStFNWdEdWN1Rzh4QWttSnYrSHJKVDlINWZybW5oRlFKRlp4dGtQMHNr?=
 =?utf-8?B?WDFrWW1WRlZvUklobnlzUFBPOEVoN2lyOHdQOHZPV0hjV3RYMjEzNDA1TzR6?=
 =?utf-8?B?bHlLKzRySjk2SWRIL0xJNUtLQnpGRjRMcUdtVWEzRDl2RzlHODBOMGIwV0Qw?=
 =?utf-8?B?N041bzJpRTl3NVNwTTRJa3JLcFpkV3dzdmF5Q3U4cUpUdkdqR1RxQzlic01U?=
 =?utf-8?B?SEFabERsd3ZjclEvMkovcUl4WWVCaE4zL1lCMk5nbGlOQ2JWMFMrUDgxNG13?=
 =?utf-8?B?R2QyclVmZUhPdzgzV1F5ajF0UzQ1NjU1dStnM041TEpJcHFLVGo0Tmk0Zkoy?=
 =?utf-8?B?ZWZiWUpDamt0R2dvbGx6M0pPcXo4bHFQT1VtNHZXZmxWQUxHSGlRV0dDN05h?=
 =?utf-8?B?dlVaZjRBaG9HdDk0cXlNSmt0ejZLbGh4djJmWDZOUU5oRW1aMHRwWlZQSXZp?=
 =?utf-8?B?YUllSnhQZnE3Z3oxYzh5NGdETGRwelBpVlAzWTBZSlFPV0tobTZOUkd3UHJl?=
 =?utf-8?B?WDh3VTY0QWtRU0swWnNMTllmcXZFSVBBb1FxSWFDeW5ZS0dvVmFNUUcyVHdx?=
 =?utf-8?B?RElramVYV2FYTGI0ajE3ZTFDRERYdVlqL3dHL3JLU2ZidnNhVHcxUUpTSmh4?=
 =?utf-8?B?ZWNhT2hvNXl6VkxIRFIvTVZYUTZGcnlsTVh5Wk9XQVJaSmpla0lVeXo1R1BD?=
 =?utf-8?B?M01DdCtLVVJQcXl0YWNsTFlsbFNWM1c4Nm5YYmY4ekp4UEk0TTdxcWxtMU1y?=
 =?utf-8?B?U29kbWF3dXdkTVJJTy9lSzVXNFkxUFRNNG4zYjltbEZkZndWeDNVZCtFdGFB?=
 =?utf-8?B?aVVzczN4bEQwekZCcFI5Y0FXVDc2SzRTcEhpenloMWhISEVTa293eVZnTGdT?=
 =?utf-8?B?NG1JTkQwQW55ZFBxQ3UzaDhIRm9xVmVLZVdGYU8ra0VFajJaQThabUprcHpt?=
 =?utf-8?B?K3N3eThacDl6cHozZklvcFVFS0FETXBxYVNnRlI4OTlvUWZKK0Y5cEY5Z044?=
 =?utf-8?B?UUdET3doZWhtTmpLOG9RbUs5RmR6MFJBaXVyTzRwOGhZaDNwTkIrNjJqTmpn?=
 =?utf-8?B?aXA3ZE9nOWlYSitHRkdzSnZMT1lJUGkzQ2FpVUdDWjN5TXMyRWhKSkc0aGoz?=
 =?utf-8?B?TUFpVzhHN0p4c2M2TG1EYzNhWkUwOEd6THQrc0dwZHY0RkdIWFc2V2FPbHgw?=
 =?utf-8?B?VmxRb3A3WVN0WjhUYTZxMGZaenpYTnhFeTRtbnJXZ1pyZVNQQzI4S2NRQnJi?=
 =?utf-8?B?YUVlZDJwZ0NOdzM2R2ZhczcxVlV0dGJka3lhVDJtbU9FYmZtTFZMUTIzWWpC?=
 =?utf-8?B?K0RBYzZsMXM3NWVvcDdDTGRoMlZZaFQwNGZUbVprajl2czA1eUladTFGT2Zl?=
 =?utf-8?B?ZFVUOUdxL3QreE1qaXR1QUxrcE5mZHFweGkvcnhWSWhnQkJoU1AySXVyYkw5?=
 =?utf-8?B?UldvQVJuTk8vcmZZMXR4WEFQMm1vUlVxS1F1K25sbHBxZU1Bb2wxYmQyZ0sw?=
 =?utf-8?B?V2hQZDlkbWRWendoSVBoaXlhM3AyZFIySGhYMHMvUkdZa29HZ1RIblNQQXJY?=
 =?utf-8?B?OG5UM3BFNzNScVNFU3duTWJ2QW9IL09BYkxZZDVDRjQ4OUFHSm91Zk8xc2h6?=
 =?utf-8?B?dmlsWGVtcTNkVkVvZkRjVUxNOG5GZFdTVWNReE1EcXROUGpiREFKYm5sMUE2?=
 =?utf-8?B?OUtUVXU0TktoS1VOb3cxSmN2Rm4wSmVUcXUwcG5kUStuSFNuYkNkV3VUUnRW?=
 =?utf-8?B?REdUUDFQdjgxZFd2UzNxQWpKd2xhNG5UR2pvMFhiSkhKVjFVZlRxOUo2Nmh3?=
 =?utf-8?B?NGpobGVLbkhEK2MvM2JzRmFySEQ3RVJhdkRKc3VObWE5Z25welpsUll4emJR?=
 =?utf-8?B?K3dWak0zM2hxUE91YkpWNXhkc2RxbHBlRDFiejJBUTFBaGpXTHpHMlJpZjZa?=
 =?utf-8?B?Q1oza09VTUp3Z0EwOG43eW1wY1JZcGU5SzdTbHN3Y0RlMjY1SVNFdGVidGRY?=
 =?utf-8?B?cjRneElqb2N1Q3pDaVAwVmE0d1dMRVpubDRXalVxaFpzV3haeXFDUDRKUU1q?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23223447-f67c-407e-a9e3-08dbd98e25c8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 21:21:14.6628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdhuJRuAGqwHUaZzVpUBI/DGu5wKyDOnAjoVNNplz9FCA1zY4d+o2kRX8ugXz/XskndfiBN7IJ1YIYqtDytXKdm+nzoV0domVt8czNsDfvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8136
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/20/2023 2:30 PM, Tony Luck wrote:
> Resctrl assumes that control and monitor operations on a resource are
> performed at the same scope.
> 
> Prepare for systems that use different scope (specifically L3 scope for
> cache control and NODE scope for cache occupancy and memory bandwidth
> monitoring).

The first paragraph is a generalization of all resources but then the
second paragraph only mentions L3. In preparation for readers seeing
that only L3 resource's monitoring scope initialized it may help
to be specific here that resctrl only supports monitoring on L3.

> Create separate domain lists for control and monitor operations.

Please do note that an upcoming change changes the domain list locking.
I expect the transition to go smoothly with the locking and list type
translating to both lists so just sharing for your information in case you
are now aware:
https://lore.kernel.org/lkml/20231025180345.28061-25-james.morse@arm.com/

> 
> Note that errors during initialization of either control or monitor
> functions on a domain would previously result in that domain being
> excluded from both control and monitor operations. Now the domains are
> allocated independently it is no longer required to disable both control
> and monitor operations if either fail.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
...
> @@ -356,7 +359,7 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
>  {
>  	struct rdt_domain *d;
>  
> -	list_for_each_entry(d, &r->domains, hdr.list) {
> +	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
>  		/* Find the domain that contains this CPU */
>  		if (cpumask_test_cpu(cpu, &d->cpu_mask))
>  			return d;

This appears to silently turn a generic "get_domain_from_cpu()" into
code that assumes control domain. This works for now for the existing
users but can trip up future changes. I think this would be better
renamed to get_ctrl_domain_from_cpu() or something better.

> @@ -388,29 +391,39 @@ void rdt_ctrl_update(void *arg)
>  }
>  
>  /*
> - * rdt_find_domain - Find a domain in a resource that matches input resource id
> + * rdt_find_domain - Find a domain in one of a resource domain lists.

The above does not sound right.
"one of a resource domain lists" -> "a resource domain list" or "one of the resource
domain lists" or ?

>   *
> - * Search resource r's domain list to find the resource id. If the resource
> - * id is found in a domain, return the domain. Otherwise, if requested by
> - * caller, return the first domain whose id is bigger than the input id.
> + * Search the list to find the resource id. If the resource id is found
> + * in a domain, return the domain. Otherwise, if requested by caller,
> + * return the first domain whose id is bigger than the input id.

The above does not sound right. First there is "Search the list to find
the resource id." The resource id is not involved in this code, do you
mean "domain id"? Also later "If the resource id is found in a domain,"
what does that mean here?

>   * The domain list is sorted by id in ascending order.
> + *
> + * If an existing domain in the resource r's domain list matches the cpu's
> + * resource id, add the cpu in the domain.

domain id?

> + *
> + * Otherwise, caller will allocate a new domain and insert into the right position
> + * in the domain list sorted by id in ascending order.
> + *
> + * The order in the domain list is visible to users when we print entries
> + * in the schemata file and schemata input is validated to have the same order
> + * as this list.

Please document what the caller does at the caller. Also, please always use "CPU",
not "cpu". Finally, please do not impersonate code (no "we"). I understand you
are copying original comments, no need to propagate these issues.

>   */
> -struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
> -				   struct list_head **pos)
> +struct rdt_domain_hdr *rdt_find_domain(struct list_head *h, int id,
> +				       struct list_head **pos)
>  {
> -	struct rdt_domain *d;
> +	struct rdt_domain_hdr *d;
>  	struct list_head *l;
>  
>  	if (id < 0)
>  		return ERR_PTR(-ENODEV);
>  
> -	list_for_each(l, &r->domains) {
> -		d = list_entry(l, struct rdt_domain, hdr.list);
> +	list_for_each(l, h) {
> +		d = list_entry(l, struct rdt_domain_hdr, list);
>  		/* When id is found, return its domain. */
> -		if (id == d->hdr.id)
> +		if (id == d->id)
>  			return d;
>  		/* Stop searching when finding id's position in sorted list. */
> -		if (id < d->hdr.id)
> +		if (id < d->id)
>  			break;
>  	}
>  
> @@ -504,39 +517,33 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
>  	return -EINVAL;
>  }
>  
> -/*
> - * domain_add_cpu - Add a cpu to a resource's domain list.
> - *
> - * If an existing domain in the resource r's domain list matches the cpu's
> - * resource id, add the cpu in the domain.
> - *
> - * Otherwise, a new domain is allocated and inserted into the right position
> - * in the domain list sorted by id in ascending order.
> - *
> - * The order in the domain list is visible to users when we print entries
> - * in the schemata file and schemata input is validated to have the same order
> - * as this list.
> - */
> -static void domain_add_cpu(int cpu, struct rdt_resource *r)
> +static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_domain_id_from_scope(cpu, r->scope);
> +	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
>  	struct list_head *add_pos = NULL;
>  	struct rdt_hw_domain *hw_dom;
> +	struct rdt_domain_hdr *hdr;
>  	struct rdt_domain *d;
>  	int err;
>  
>  	if (id < 0) {
> -		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
> -			     cpu, r->scope, r->name);
> +		pr_warn_once("Can't find control domain id for CPU:%d scope:%d for resource %s\n",
> +			     cpu, r->ctrl_scope, r->name);
>  		return;
>  	}
> -	d = rdt_find_domain(r, id, &add_pos);
> -	if (IS_ERR(d)) {
> -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> +
> +	hdr = rdt_find_domain(&r->ctrl_domains, id, &add_pos);
> +	if (IS_ERR(hdr)) {
> +		pr_warn("Couldn't find control scope id=%d for CPU %d\n", id, cpu);

How can the failure in the error message be encountered at this point?

>  		return;
>  	}
>  
> -	if (d) {
> +	if (hdr) {
> +		if (WARN_ON_ONCE(hdr->type != RESCTRL_CTRL_DOMAIN))
> +			return;
> +
> +		d = container_of(hdr, struct rdt_domain, hdr);
> +
>  		cpumask_set_cpu(cpu, &d->cpu_mask);
>  		if (r->cache.arch_has_per_cpu_cfg)
>  			rdt_domain_reconfigure_cdp(r);
> @@ -549,48 +556,115 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  
>  	d = &hw_dom->d_resctrl;
>  	d->hdr.id = id;
> +	d->hdr.type = RESCTRL_CTRL_DOMAIN;
>  	cpumask_set_cpu(cpu, &d->cpu_mask);
>  
>  	rdt_domain_reconfigure_cdp(r);
>  
> -	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> +	if (domain_setup_ctrlval(r, d)) {
> +		domain_free(hw_dom);
> +		return;
> +	}
> +
> +	list_add_tail(&d->hdr.list, add_pos);
> +
> +	err = resctrl_online_ctrl_domain(r, d);
> +	if (err) {
> +		list_del(&d->hdr.list);
>  		domain_free(hw_dom);
> +	}
> +}
> +
> +static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
> +{
> +	int id = get_domain_id_from_scope(cpu, r->mon_scope);
> +	struct list_head *add_pos = NULL;
> +	struct rdt_hw_domain *hw_dom;
> +	struct rdt_domain_hdr *hdr;
> +	struct rdt_domain *d;
> +	int err;
> +
> +	if (id < 0) {
> +		pr_warn_once("Can't find monitor domain id for CPU:%d scope:%d for resource %s\n",
> +			     cpu, r->mon_scope, r->name);
> +		return;
> +	}
> +
> +	hdr = rdt_find_domain(&r->mon_domains, id, &add_pos);
> +	if (IS_ERR(hdr)) {
> +		pr_warn("Couldn't find monitor scope id=%d for CPU %d\n", id, cpu);
> +		return;
> +	}
> +
> +	if (hdr) {
> +		if (WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
> +			return;
> +
> +		d = container_of(hdr, struct rdt_domain, hdr);
> +
> +		cpumask_set_cpu(cpu, &d->cpu_mask);
>  		return;
>  	}
>  
> -	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> +	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> +	if (!hw_dom)
> +		return;
> +
> +	d = &hw_dom->d_resctrl;
> +	d->hdr.id = id;
> +	d->hdr.type = RESCTRL_MON_DOMAIN;
> +	cpumask_set_cpu(cpu, &d->cpu_mask);
> +
> +	if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
>  		domain_free(hw_dom);
>  		return;
>  	}
>  
>  	list_add_tail(&d->hdr.list, add_pos);
>  
> -	err = resctrl_online_domain(r, d);
> +	err = resctrl_online_mon_domain(r, d);
>  	if (err) {
>  		list_del(&d->hdr.list);
>  		domain_free(hw_dom);
>  	}
>  }
>  
> -static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> +/*
> + * domain_add_cpu - Add a cpu to either/both resource's domain lists.

cpu -> CPU (please check all changelog and comments)

> + */
> +static void domain_add_cpu(int cpu, struct rdt_resource *r)
> +{
> +	if (r->alloc_capable)
> +		domain_add_cpu_ctrl(cpu, r);
> +	if (r->mon_capable)
> +		domain_add_cpu_mon(cpu, r);
> +}
> +

> @@ -3914,18 +3916,22 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>  	return 0;
>  }
>  
> -int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
> +int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
>  {
> -	int err;
> -
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
>  	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
>  		/* RDT_RESOURCE_MBA is never mon_capable */

This comment was used to justify the early exit based on later
"if (!r->mon_capable)" test. With the test removed this comment
becomes unnecessary.


Reinette
