Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A786C766EF7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbjG1OAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbjG1OAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:00:50 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B88C2D67;
        Fri, 28 Jul 2023 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690552848; x=1722088848;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VRCnT2zZhr9TyhtfTJ5IRFpYvFYZ6uc7ZV8sKNpKSPE=;
  b=DwMJPwcMKmVLrb35F981iJ0MtYmHCxY8sylcCZ6hpmNwki+ZNfVkmfpm
   aMX9TDkSeZNzyBKNBNJvKm1QOBNOxOEPY1Z7pwABXEgKpqRf+1zqAwop+
   bgRkjdJABWLT0pVwwDzog15HSFNiaS/oK+Ag7PJOkavSR50l/E0dJhk2/
   DyWGoF+xwmUG7XPStZK9sPyQJwqO2tch003Rrn2xG66DOjN5tU1XRQ+QZ
   SN4/GGwh0HHV1SLFcJMkXL1p70RWgUbMHfC+fJ92Rh4KMD2+NYKyS8MWh
   3hiyRnpdQr8gBoq8AUbRFZ3m/RuSNwOgW/bYfOhry/JJ3CCLUyTJsjaEl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="358623992"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="358623992"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 07:00:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="792956982"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="792956982"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jul 2023 07:00:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 07:00:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 07:00:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 07:00:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6dHlfU2jlwMvI/C9GGMgHK88HJLuvOuLoMUl65bpUICZXc/EtLzoyJM119NhbNVHrPuRXR695Ks7Z1GN6CylJurv0nKqrmZDl/09sOn+ZJPw1tHTlE87DKMmcz6NqoS6YDLxK8IEXx0dnKX0IJrq2sxHR5AewLnRWOpljIVlw0NtE2+oCGqjeT77gEUzf5q4ogM/LAKBttS3ZpsAxkcwnszDWkB/hYMASY9nNw0KDDsIHaz3PEQeewskIq8ez+wQ+1O8PAz/XK10o/N99v9eGY9qoCFTTf3O/Ab930VrienC1dhV89yDHisGl/gOe/jYSCqv1RUgP2YlJADxj5TkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVArJTsNnJhZ7EML/wtgIRQWJyvv3J7OBXMPgJatUsY=;
 b=mfJJUGNgcEiL6N8Obm8bg/2okNtT6WR93lT/b7lz4ToTeKW+BDnp2XLeqPILx4+2K+eoB6uo39EvxtLLvcS30d7IMCWA1baXgvCTVtZVawZvs1Kq3rywMcxsZsdiWgovQUKXe6QsrWA4kvww6mb6pUBmTQMUidyDm3bSb/tXxW8ie0U4UkG7Hodn5FlK7wk42gE8Xrz10sQLXDmDlN3ahcSpnSY58mfTVGgXEdVjGWWMDKCHi0rSSSOtFPd9lwZn9ZD+dW9uKtCDyQdNDmD5/9Mt4X+aBLK5EjwIDNTNHzzAb9vpAHpP+8hKJciDz6kQZJLl9OCosOoBMTQRIARgjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DS0PR11MB8740.namprd11.prod.outlook.com (2603:10b6:8:1b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 14:00:39 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 14:00:39 +0000
Message-ID: <5ba84af2-51d1-de5d-14cc-752c08e5371f@intel.com>
Date:   Fri, 28 Jul 2023 15:58:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next 2/9] net: skbuff: don't include
 <net/page_pool/types.h> to <linux/skbuff.h>
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
 <20230727144336.1646454-3-aleksander.lobakin@intel.com>
 <f283dfa9-d599-7311-1c2f-4317c2f7957d@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <f283dfa9-d599-7311-1c2f-4317c2f7957d@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::15) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DS0PR11MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: cd442594-d5a2-4979-f330-08db8f73064d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZQMEcu7CT5GFvFe8UaX5h9XP9A6npnkras4dFVrRT1IqmFwUSbDxwvsbIus8T9rXxEPKNJUMnm+AwKxLHTWUd1c7BvbOs9htzDak1bypYKVSDsuU4a7C/gW9ZAVLdwx3mC+ZkEBjJiqDA1csvP3MUeY33RVgaNRMLjHDg+Xr0GpwkTadawiiWUemEsdsKwb6y3NAVJYyFGpKtKRTU91IF1h9hcoERg+Kfud+FcRR/nSfqD21POtHYdzbeW6512J9obNZyh8RokVEyiau41azwTE/hWbMAv3pP/xo3GNg5NaxfHJxrb0bMGwjW/LDrqSNmQpGC92p9QUoOGMNERO2UmNfi0auojNw2+/QRQoTHbfirj90IzSK68ZqsAmX2sQ10rituiXSZSdzW5iqpmNmtDbjZaTR2mvMP1EnE/agHKTMJqR0h6a3af1V3r3eYx6iin0kTBr/nt2tiTgLxC+ZOkfmOVFpZ0pM1Dr+sL8xz4zHpL4u2tFgLe41A88oWYNXo33JRVqN/wfBCCi2S2zVxB3L9ZdmLOuAFZE4XZ9G2XsWSVHtckVyaP/PtE3GaxxBOQc9zVXM2laJfbmitHb3zw9MQp2HyYCRWzAd4vmNpYHrNu3fFcaudIzVZyiQnVGZGVxcRkz1HrdaJYYjrQZiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199021)(2906002)(41300700001)(5660300002)(66946007)(66556008)(66476007)(316002)(6916009)(4326008)(8676002)(8936002)(7416002)(86362001)(31696002)(36756003)(2616005)(83380400001)(26005)(186003)(6506007)(53546011)(38100700002)(31686004)(82960400001)(6666004)(6512007)(6486002)(478600001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlJyQXZ6dkdybUJ0c3ZhcFY3Q0VPMGtEWFRIaGp6TE9rMEhjWVVjTkZEdG84?=
 =?utf-8?B?aHVEWmo4dlRXRUJPN1g4eEsxS2tGNU1Ba2NtN3AvTmlZck0wWC9odzhONjF2?=
 =?utf-8?B?V2RGYlJsdGF2ODhyanI2T3dPcElBOW9mQXBRakhrakcxYWFEV0lNakEyVkhG?=
 =?utf-8?B?YkYrdU5QQ0dqVnVUSmtRSXVIRjJ3Z1NuV0xOL0s1RHBzRy9iaWlxSi9jQkpK?=
 =?utf-8?B?TURpMS8vbUoya1hzN3FuWXJQbG5MU0I4dTQ0YjRzc0FaNy91NmhzQ0M0MHBq?=
 =?utf-8?B?dWVSQThRaGZ6dXg2MzlOK2ZoRU9RMDJERU9PQkZPODRIc2xkQjZBb3pSKzhw?=
 =?utf-8?B?TWNhWDZnWXAvRTJzb0xsbEFMTHdrWGdMVitxNXZNVFpkK3Vyb0NrWVpNT1Fs?=
 =?utf-8?B?Z3NyNm13bUVacGxxNEg3ZWRrNGpQOHlYSXpzU1krSk5SSTRvUUdjNXlldjhO?=
 =?utf-8?B?NU9IamY3NU1EbzNNemEwbVlBYkFGRDJ1WFoyQlRLRzY3cnFGQ0RDdW84bVdK?=
 =?utf-8?B?TmY2b05nNTFMK2VWeEtnUENVUFdUb2FFL1N6eWxZMVdyVTZ5NkxtYUJvcHNJ?=
 =?utf-8?B?NDRlWkpEL05GLzUwbklkbzVDbTNhbUhGZkFlK25DRS9tdlNIRTh1VXNUSWRU?=
 =?utf-8?B?aVJoY0lYZHFsZGdUZXJlaDVMNUVRNnV3ZFZpN1grRW8zdzNmZklkVHJPSC9v?=
 =?utf-8?B?RzVYVUJYRjYyeERiTXJZdU5ONDVhT25zbG5ZYlZxemFHclMwdFZpTFhOSGdF?=
 =?utf-8?B?c0NTNjg0V2VYWkZJTjJlVUQzek9NQ29vZnp4Q2FPaHU0RGk5TE5LcjVBQmxU?=
 =?utf-8?B?Q2VpcWR2aS96N3FnOS9heUZ6aHNoMTNHZ3FYVTMxdWJESG0vbGlyRHF1WmJK?=
 =?utf-8?B?RjlidXJPZHBJcUpmNEdkcm44NUNxYkc0YlFhenA2UFJKL0ZwMUx1TFh5Ykw1?=
 =?utf-8?B?WUltYmZjY29LYnAxcHZrbTdRenRteTFHeCsvb3lVcDNjTnVGbnZTK1ZNcHRX?=
 =?utf-8?B?dVRSSTMvTjdCUmhtN0RDc2EyV0tIWk5qbWo5VEFYRk0wbzZJbEpuVlhTbWQ3?=
 =?utf-8?B?RmdTZFVwWW9qeWlTZlJIdityWEVhaWRIMks2M2FWUERIK1JzY1JzYnhmQlFP?=
 =?utf-8?B?RTdsODh4UXdUVnJpOU9LY3RLWTN4NENoaU1FeUZmZko5c1lwOEJlMW5RaW1z?=
 =?utf-8?B?TVI0ZUxqamhPaFlDU3NJUnRqbXgyaHgwWklsWWZqc1J3L1ArVDBoclBoK0o5?=
 =?utf-8?B?bWVDb3Vnd0phem52SnduOEVUN0Fnc2FYMkJsaDRPcU1URlIyZW9md1FmSmVq?=
 =?utf-8?B?SHVOU3NxcURSVndGa3NwSW1TRzBJVXhkTkIyTnB4bkQyeGpTRWY5T3gycHRn?=
 =?utf-8?B?QlU2WXFoNEwzUXl4R0NlN2sxbjJCN00wWW5KSklhNkI2N1U0Y2hxd2c5aHFu?=
 =?utf-8?B?OGVJenJodHZjV3NibTc2MTVUbXNrY01KWURQMTZFNzhZaFpTTHN4cnFZOHF1?=
 =?utf-8?B?eEJmSFdmbGoraUJCc0tPUWFWVTRoWlVjcXFwLzJ2Nm8zRW5NMnJOaVBpN2FJ?=
 =?utf-8?B?TE9FSG9oejNuT0R6bUJNNldXMDdXNDU1bUl0YkxXT3FwcDB3WkNGWElqNFA2?=
 =?utf-8?B?ZG5nbUdlSEhUc0dyTXcrVVdWRFdjenBoeWdjcmExZUhrSDk5dTFtajZRRzdO?=
 =?utf-8?B?TGJmYWhpa3F6a290OVQ5eHlKYnBnUWQvOHhtTzVkWS9LbHFxL3VLWS9TSnY0?=
 =?utf-8?B?LyswQUk5UHRwNi8vcjZuRDY2ekRaMW52SnFPY3BMNU1HWU5hN3dYZlZmMWIy?=
 =?utf-8?B?ekVmUjV3aWNwRFR4WkJ6TXBsV2RrUnE3dzhqeXkza1dxV0U2ejlYRllZc3Bs?=
 =?utf-8?B?aThraTlKdmc2Nmthc05QNERlb0Y0cWNldCtCaE1LZjVLbVF5anNTeHFpZ3dn?=
 =?utf-8?B?TVJUQStaTUZtMjhWRnpRTXBZbVZnZ09oeXBsWXQ1MGkzanZnNlVIZUl4Z3ZF?=
 =?utf-8?B?N0h2c0xMdXhBbzJjN0RiY09EdnM0UzRTbmhXa2tTMjE1bTFpYVlRdklDeU4x?=
 =?utf-8?B?M2xPM1RkSWtIVE1sbU82YWpCZnZic3BZUmx2bUQ4U2hPYUltZUFVSFFvUlAw?=
 =?utf-8?B?dmNwSmtzbWlBU01WRDIwWFg2ZjkybU1SMWhMV2hLRHhaRjBPVGQ3TzZoeVpL?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd442594-d5a2-4979-f330-08db8f73064d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 14:00:39.5715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZrBhCUgoeUvPP8GpAV5/zX5vgbJvi/9zsWdUKEPyMs8oMLl3iSuS2k+bUhsKtAVGiEbJ82Vxk2Adj0TUqTQLCRrolmuLnM37uzCcJDQNWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8740
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Fri, 28 Jul 2023 20:02:51 +0800

> On 2023/7/27 22:43, Alexander Lobakin wrote:
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> 
> ...
> 
>> +bool page_pool_return_skb_page(struct page *page, bool napi_safe)
> 
> Still having the 'page_pool_' prefix seems odd here when it is in the
> skbuff.c where most have skb_ or napi_ prefix, is it better to rename
> it to something like napi_return_page_pool_page()?

Given that how the function that goes next is named, maybe
skb_pp_return_page() (or skb_pp_put_page())?

> 
>> +{
>> +	struct napi_struct *napi;
>> +	struct page_pool *pp;
>> +	bool allow_direct;
>> +
>> +	page = compound_head(page);
>> +
>> +	/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
>> +	 * in order to preserve any existing bits, such as bit 0 for the
>> +	 * head page of compound page and bit 1 for pfmemalloc page, so
>> +	 * mask those bits for freeing side when doing below checking,
>> +	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
>> +	 * to avoid recycling the pfmemalloc page.
>> +	 */
>> +	if (unlikely((page->pp_magic & ~0x3UL) != PP_SIGNATURE))
>> +		return false;
>> +
>> +	pp = page->pp;
>> +
>> +	/* Allow direct recycle if we have reasons to believe that we are
>> +	 * in the same context as the consumer would run, so there's
>> +	 * no possible race.
>> +	 */
>> +	napi = READ_ONCE(pp->p.napi);
>> +	allow_direct = napi_safe && napi &&
>> +		READ_ONCE(napi->list_owner) == smp_processor_id();
>> +
>> +	/* Driver set this to memory recycling info. Reset it on recycle.
>> +	 * This will *not* work for NIC using a split-page memory model.
>> +	 * The page will be returned to the pool here regardless of the
>> +	 * 'flipped' fragment being in use or not.
>> +	 */
>> +	page_pool_put_full_page(pp, page, allow_direct);
>> +
>> +	return true;
>> +}
>> +EXPORT_SYMBOL(page_pool_return_skb_page);
>> +
>>  static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_safe)

(this one)

>>  {
>>  	if (!IS_ENABLED(CONFIG_PAGE_POOL) || !skb->pp_recycle)
>>

Thanks,
Olek
