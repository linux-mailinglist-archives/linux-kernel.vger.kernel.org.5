Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCFD77FD4D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354127AbjHQRxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354142AbjHQRxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:53:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58312705
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692294798; x=1723830798;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=05mogFAH3UoKBN5B5ALwq24XFe0dj0dQ4w5hXjU+E24=;
  b=cLrLYMGZ2xbcfQeHP1r6hw0kX44G52nCgtI99imzLQnnv9rUjWCfRyHx
   XHMdrt3zaMrRNAKNLIIGwTe4YapVQQEbZQ7ooSi7u3fy4JF3psrwKeThz
   g1+YhtbAvH5/TtYdlH1+EoukXqnNgYXq2v2NfJbnlG0H86eBO4LBYw37w
   WE/fWIhWZ5zkw7pC22jfco+SisOy8HQeS3yXZCk/CxUAouOBJx1zE1iAM
   3cbEUS4mVz8ZELFLZYCF8UrCp8ouJln0H+lVH6NLcQi0fBXiiA25aBRIf
   2CJs+kAg6Hc17j7R8SkVeQ2sjFaGNIJZIGfsSgzECSXWr2mY2uIXikFfZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="459246280"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="459246280"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 10:53:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="858307880"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="858307880"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2023 10:53:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 10:53:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 10:53:17 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 10:53:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtE/VwCtFjngZn3nKRZkg/w9D3g8VTlR/5iAGGtFjYTDML4Ge7WqpocVIA6smo4lS5ydMkQfngcvUsUlAIcc1HCpFUGXKoSCdQF2Tl5jxCmdRy/RaIEGIFkWXaF6Xg6aIPnd2KAg13kPrGSVNTuI4Cy3Z8EGIupTjS9R9NPGOkoYFUJ450kbUTkeNhVjHJZrCa1pQTBh8HfHevbq5sM4wlljCkup0mIq+uDW3rYujMoWWhqL0L5S6aFp0+wBOQiU8AoXjJoipr9Ox9CDrKvHcgSQ2cSoMziQKRGaQysPVpXC0QGYdYaKXyhCwY1bbPEaQiNbBks5T9X0MMUG4Bf0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zvna1z6Ihgb6iPmDB7iuJmzz5W4nDJBY5IxmVLaDbUU=;
 b=buhm/XrEPvAr6CZnfIlOayhjpiNJdfw9Sye0b765/NxLyTbaL66bZL4rrY8XmpT13TOVSb97CXXG+dT5TkqAHiXQi6Bv2Hzk4iIcoLJThRHrffrcYySGxA+zZrvWQTCmCMcIBOQBXPG4X/nzmYw1GENGWFCHwkP+y1xw47nLHU9yhthaSugmqt5I99jdgd+95vHZxJctCBUtpwFp+091t3/3mHVVaWAfURrE1eLValGy8DcHw4Y/uVqfLuzBz5nhZBdlIsSqnPFXto2rZc6o22PD3C2kI85X0bzo7S7HbwyT6RScL0wONV6VkMeC9VElcR1s5TQ0I9F7iUIG0jMdMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CH3PR11MB8210.namprd11.prod.outlook.com (2603:10b6:610:163::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 17:53:14 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 17:53:14 +0000
Message-ID: <a15019d9-f6f7-01c0-7449-c8fc59401d50@intel.com>
Date:   Thu, 17 Aug 2023 10:53:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [RFC 09/12] fs/resctrl: Extend schemata write for priority
 partition control
Content-Language: en-US
To:     Amit Singh Tomar <amitsinght@marvell.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
 <20230815152712.1760046-10-amitsinght@marvell.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230815152712.1760046-10-amitsinght@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:a03:331::13) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CH3PR11MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 0debbf6c-32e5-4f9f-172e-08db9f4ad447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jfSwr5c3dMy1CU3GmABNnADbWbdsqmnXYHt+zIOVH/enKGA42cd2rnojtSRJXPLpRg/XaGKpBsatBgbB0dV2/f05TcVTseza1O595mcfaf4RKMQMwjVqMb6CGYjPZbtEMSts3OSCZMped/lnZyNHErO69X+CE1Uh2HaYjveZpbHiLJyS1vMdgWCyJ5WetaxZ2nUK3tsA85ArtzJwN4JShtpIVK6O18Q37y66zUNu6kjslRm91nhxEJ7xBljmPU4yy15HnFkVz20XVDO2lTkgcK/T7kEtCgW3+y/cJvFNE5QxUHnLAYBfAEGomPp4h9bs2diy6IIh1j8IkvaSWddV1lq851Saljkgnu905ggYxFBzQtolhGgkq/3NxMgyL49xWzd13SmcagOmirCbtKTFXRFNDk0Cf8dAriN5bLa2QUIEw2GaFhq6WjXpb7clExUTo+yqMfbx7xG/qhZuRGKP7ewunumrx+F+HtFYXf2O/9OmgeE+HGymNUQSHd9TtQrgcIEMPcw5iIo9K4NVg8hnhH0umL808Bv4Gzbok8FmVV9dR7jpJDew/xKR9KS323iPmfbk4VY7mftUQY8Ap6ATJAYsFf/GGBRNsz4xc/h9ap7nn4ROuRDjMqjG9l7ZxkD5mU+E35Gl8I54yk1828vdWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(346002)(376002)(186009)(451199024)(1800799009)(31696002)(2906002)(83380400001)(26005)(86362001)(478600001)(36756003)(6506007)(6666004)(2616005)(6486002)(6512007)(53546011)(44832011)(5660300002)(41300700001)(316002)(66476007)(66556008)(66946007)(31686004)(4326008)(8676002)(8936002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGpZVmF6SERUR3ZlR0FXRlFXQ1BaVnlJK0xEYVM1REdLZ3QwWWRZcnRMa2xH?=
 =?utf-8?B?bU1EanVLZmFGdC9xS1ZaYWNhWlNPM1MyQ0pObTIwWmV2K3hvYVpHK0oyNm5i?=
 =?utf-8?B?NE1wc1BLcW5PTWZqVFYrMXpuUlBUM001SmZ4YlM2Q2xHZEVhbUFxeVhuayt1?=
 =?utf-8?B?elEycWRjT3FmUlRQckNVQm94S1FOb1NlZjk5VDZIU3dpS1hEOFkzQ3Mza3J2?=
 =?utf-8?B?eGNvTTQ0aXZNMVBxTjdxdmg4TXF2cFhFRjExanMzNk1FTElYN0hxRnFueHRs?=
 =?utf-8?B?MzFScnh1NUNDWUw5Qm9CSFg0K0NkaHQ1TWlvTWNPa1AxeHNWL1hUc0dTTHhy?=
 =?utf-8?B?TzE4WmNiTGtOYUVyQXVnUDNiSjdzd0s4MFdXQTROcktyKzlNYWdibGgwR3BU?=
 =?utf-8?B?QjBQMXZDVnBNbXEyUHMzTENibzFiWngzSXo3ODdrdVIyUHdQc0FJdW40bUFL?=
 =?utf-8?B?blFqTWs0VVNzdnlZMzF1WDRRWXpldXRUZE0wbUVUK1ltZEZRUUkrL01sQUV3?=
 =?utf-8?B?SmZoZ3k3ZmVEZEtLMXpJN3V2VFY0bXhKSjJSeEhISEEzeEFKZDNkaVFUZlJ4?=
 =?utf-8?B?U1JBYkgrdytSZ0RJSVUwaVB3amViMlBkaGxXdEJmOFVJck1CN2VOQTRoMURi?=
 =?utf-8?B?c2I2V250c3VWV3ZqMFc0ek5kOVIyZHdqcDk5R2pDZGxEeFhZQ1BkTHN5NVdU?=
 =?utf-8?B?L1RHekJtNEdKNndxSW1pc0dxYmd3NXUrSEZBeGVJQldwL0R4cStYZGRPK1c3?=
 =?utf-8?B?K1VLMm9RS2hZU2J2VFpXejF6Mm1nZFIyWkMvRTBSa1BqWE1VejVIZlFSMnQz?=
 =?utf-8?B?R2Z6UjE5QjNvcDB6aEU2ZEVzR09Lb3NwdWhpVm5JR05CMk5rb2ZGcUtIellO?=
 =?utf-8?B?OEl4VWtXVVB1Yndaa2xsRjQrS2oyTW5FVmRRV0NLbXZUL2E0Qi9ZK2J3bnhC?=
 =?utf-8?B?dnUranREWmR3S1FCZk9vc2FOYzVBS1A2aWhIbzJ6VURnU1Jja25zL1hGUkFu?=
 =?utf-8?B?bWpxQnN1YWhBVEUza0xiT0wwSW5WYVlCdEZDR2RXa25rN0lRT0RJT1hxblVG?=
 =?utf-8?B?anlHMzRxdTBKZGxLWThoZGxpeHMrendWNElIY3JMS0VTVzdWYnhIN2ZXMGhO?=
 =?utf-8?B?WmkxTWM0KzE5MGdnbjhlcUtsZU9LT1dFMk04Q1BjRnFTY0t6M2VqK1VkSldm?=
 =?utf-8?B?bGljUjYxRjFhUlhIYkxSZ1M0YWRpME9tRnBZaS90VVBxU05EQ1VMZUhHdkhV?=
 =?utf-8?B?YVFWQ1RLZEp6VjZ4S2JpclRlWDJLbmhMcmMrK2VtQmFhMk05clUvYnRnV1ov?=
 =?utf-8?B?NmVBZ0cxM1Q3WXJoV2gyclVGVVhkOERHYW4rcDM0UkdDekNMdXR0dmZEc1NU?=
 =?utf-8?B?QlJUS3VpQlA0dmM2UzVpbXNFVVNjVXlSZGczclcwR1oybkdiV0lTVkJLRVJv?=
 =?utf-8?B?bkljYmo4eDlxZ2hkWkZnQmx6UFErbXNUWGdpeGhHODRxYjFSZjREd2hKWGE4?=
 =?utf-8?B?QktSdG1Za3p4YytjRnk0ODl2VjlFSlczbTVIRGhGU0d1TzNzZlAvbVFDbEd5?=
 =?utf-8?B?S1AwSzc3ZTlTUDRBSlJyWmxJRkIwSW5MRjdVSGJaL0c2MGFrY3dGeXFPWThE?=
 =?utf-8?B?ZmgvOWpHN2hqSDYxMElNWmYxQnc4V0V6OWgybDF2SnB6K2VFMUhFaFBpRUht?=
 =?utf-8?B?UXk5UzdrRU53cC9HZzhsY202cXpjUCtMQmQzQm9Vdmg1UzYvOU5pdU9JK1ha?=
 =?utf-8?B?N256RzFhc0gwSjRQbGxJOHQrcmtXU1FjZms2b3NTemNRL0ZYLzlCL3ExTGpr?=
 =?utf-8?B?SC9UTVcyQzdabGxVN2JkcitUOHpmNnpxdmdsOUtIZ3dGSUJtbENUVm1YK01S?=
 =?utf-8?B?SjBFTTZScEhBc0RnemZ0MnMzQU9FZEQwMS9qMG1HWGQ4REh1bG1BdHMrcS9M?=
 =?utf-8?B?ZFl4d0hZb2xVU3BDYW00QXJkbGxpbS9Nc29DVmZ0b0FzWm1Uei95Z0xBSmgw?=
 =?utf-8?B?ZzViT2FVQ0toaHIrMXhlMkllMCtMWHNMU3BLVmtrREJWczZhandRcm9TK2tM?=
 =?utf-8?B?TGdKL1F5TkMwbnZDRU9YOVY1TmxMcW14NC9vYTRKTExXNWpwWlJrSlJ2RmR3?=
 =?utf-8?Q?b9JfxyJgUgfyPmx7Ap9Zucc64?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0debbf6c-32e5-4f9f-172e-08db9f4ad447
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 17:53:14.7339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8j3Qt+c7QUPv3kBKg2Kb/kBKjwNMfiS78bXPYUQxiB0tqh28kAX0iXKow8ghks1cxDOFPKGuIDgWmDhcwOVvCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8210
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Amit,

On 8/15/23 08:27, Amit Singh Tomar wrote:
> Currently, Users can pass the configurations for CPBM, and MBA through
> schemata file. For instance, CPBM can be passed using:
> 
> echo L3:0=ffff > schemata
> 
> This change allows, users to pass a new configuration for downstream
> priority along with CPBM. For instance, dspri value of "0xa" can be
> passed as:
> 
> echo L3:0=ffff,a > schemata
> 
> Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
> ---
>   fs/resctrl/ctrlmondata.c | 92 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 92 insertions(+)
> 
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> index ffeb68270968..b444adee2002 100644
> --- a/fs/resctrl/ctrlmondata.c
> +++ b/fs/resctrl/ctrlmondata.c
> @@ -30,6 +30,74 @@ typedef int (ctrlval_parser_t)(struct rdt_parse_data *data,
>   			       struct resctrl_schema *s,
>   			       struct rdt_domain *d);
>   
> +static bool dspri_validate(char *buf, unsigned long *data, struct rdt_resource *r)
> +{
> +
> +	char *dup_buf, *dspri_token;
> +	unsigned long dspri_val;
> +	bool success = true;
> +	int ret;
> +
> +	dup_buf = kstrdup(buf, GFP_KERNEL);
> +	if (!dup_buf) {
> +		rdt_last_cmd_printf("Failed to allocate buffer %s\n",
> +					__func__);
> +		success = false;
> +		goto out;
> +	}
> +
> +	strsep(&dup_buf, ",");
> +	if (!dup_buf) {
> +		rdt_last_cmd_printf("Unable to find priority value token %s\n",
> +					__func__);
> +		success = false;
> +		goto out;
> +	}
> +
> +	dspri_token = strsep(&dup_buf, ",");
> +	ret = kstrtoul(dspri_token, 16, &dspri_val);
> +	if (ret) {
> +		rdt_last_cmd_printf("Non-hex character in the mask %s\n", buf);
> +		success = false;
> +		goto out;
> +	}
> +
> +	if (dspri_val > r->dspri_default_ctrl) {
> +		rdt_last_cmd_printf("dspri value %ld out of range [%d-%d]\n", dspri_val,
> +					0, r->dspri_default_ctrl);
> +		success = false;
> +		goto out;
> +	}
> +
> +	*data = dspri_val;
> +
> +out:
> +	kfree(dup_buf);
> +	return success;
> +}
> +
> +static int parse_dspri(struct rdt_parse_data *data, struct resctrl_schema *s,
> +			struct rdt_domain *d)
> +{
> +	struct resctrl_staged_config *cfg;
> +	struct rdt_resource *r = s->res;
> +	unsigned long pri_val;
> +
> +	cfg = &d->staged_config[s->conf_type];
> +	if (cfg->have_new_ctrl) {
> +		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
> +		return -EINVAL;
> +	}
> +
> +	if (!dspri_validate(data->buf, &pri_val, r))
> +		return -EINVAL;
> +
> +	cfg->new_ctrl = pri_val;
> +	cfg->have_new_ctrl = true;
> +
> +	return 0;
> +}
> +
>   /*
>    * Check whether MBA bandwidth percentage value is correct. The value is
>    * checked against the minimum and max bandwidth values specified by the
> @@ -293,6 +361,8 @@ static int rdtgroup_parse_resource(char *resname, char *tok,
>   ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>   				char *buf, size_t nbytes, loff_t off)
>   {
> +	char *dup_buf = kstrdup(buf, GFP_KERNEL);

kstrdup() may fail. Need to check NULL for failure.

dup_buf needs to be freed. I don't see it's freed.

> +	struct rdt_parse_data data;
>   	struct resctrl_schema *s;
>   	struct rdtgroup *rdtgrp;
>   	struct rdt_domain *dom;
> @@ -354,10 +424,32 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>   		if (is_mba_sc(r))
>   			continue;
>   
> +		if (r->priority_cap)
> +			r->dspri_store = false;
> +
>   		if (!strcmp(resname, s->name)) {
>   			ret = resctrl_arch_update_domains(r, rdtgrp->closid);
>   			if (ret)
>   				goto out;
> +
> +			if (r->priority_cap) {
> +				r->dspri_store = true;
> +				list_for_each_entry(dom, &r->domains, list) {
> +					ctrlval_parser_t *parse_ctrlval = &parse_dspri;
> +					char *dom_data = NULL;
> +
> +					dom_data = strsep(&dup_buf, ";");
> +					dom_data = strim(dom_data);
> +					data.buf = dom_data;
> +					data.rdtgrp = rdtgrp;
> +					if (parse_ctrlval(&data, s, dom))
> +						return -EINVAL;
> +				}
> +
> +				ret = resctrl_arch_update_domains(r, rdtgrp->closid);
> +				if (ret)
> +					goto out;
> +			}
>   		}
>   	}
>   

Thanks.

-Fenghua
