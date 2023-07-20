Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559A375B59B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjGTR2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjGTR1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:27:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA87272B;
        Thu, 20 Jul 2023 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689874073; x=1721410073;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SBkwte/d+EcWYqtuWs6yjZhBCov8OC+FaB9CU732Xbc=;
  b=ZPNqEaiHoZ38136OviSBvTZKVpnrL2aFBdQIQEyg1YiLqRABjJRVCMPd
   vKvr1pknz08RLGSmiPUW7gxMxeYMr8LAxD7E6tZQP8NFDyf0PJeYVmo/4
   hMutkbQ6gbkFc8sO+f3syFrO74kGSIkebz0lrJyUDU+AgREBdpeOgUyo7
   dk0ArIOdXCHZqZnRD6tUgiRSaVJXr1gbWjYLdr31LKGblcz/h59oQFhF7
   lIsBMsJrSadLlNxU3PkdD20lu7sbdkpCQ+CD+zjH3QugwS4OkN8vTxAbX
   eWvGnazcrpWDVdwNj/Ww1gV9rYzUeQX4URo7siWRWG18wt0VsPeto1vK+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="366847699"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="366847699"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 10:27:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="727778738"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="727778738"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jul 2023 10:27:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 10:27:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 10:27:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 10:27:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJZ1mwlogHFKWXR6PoryHhc6dWCW7+xBQsGvDl+Gzbcqp23kkKXTYIA7SYdfuUEpPLyiyYc+VOCawZ6wyZnlkklRg2zMcgcFr8qqrTbATM1BSL0LJFo066Ul8w/lCLsmSOrLZH4g7cQzjkK4FiNmTlKwcQfuk59nGgZhwZUIVRZGMfuecuEScCY8G1f8uTQ0Khte6qmVmCTrgUNxD+pWTL8EbNxzRaDw9hxC+Urv9yi2JxXfVLHRNc4iO0Jn1ACXF+2k+Xgsu1e7yVFwePMRZmQIOptwCiTfn7TALoraq1Qw6Av/3btmE1ar1AhTi5ScspXaU4WGJF9Jozk7YvXD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7u66zDe0KJuEawxrm69KHhGGp+su+RpQn5So7Wdfik=;
 b=NWqpPtuhQ/dVqMqxDKq40El/adCL0CNAtACA3Ic4tMHdWoW3uryFNwwQfJyLmFxmi0ItIYuXAoYah6jMNWq2xRA44zsXzGwtCmfznnZw5QbV6DpsNES5jPSlZ34oF3rBZz2N9cQpQPiF7y9V3xIg8y5KmSBCpt7M7SGqYJs44eM6gbVGlWjeDueacRfAu0/xFROK1UDd3b7mLhpzoYnOPRpjpXHbzCJLjzJuSlknsjCAlsQ4iW9LwV8yeOh//D7XUf2xXZl3Z0YHdP9rTtD3lUkrwDy+ckWox+BztkFEOO4uKFE8dJqT9/U56BMi7VP3YBBDn2fv4Yd7nM1ZldNhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6499.namprd11.prod.outlook.com (2603:10b6:510:1f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 17:27:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 17:27:48 +0000
Message-ID: <95c56b28-414d-b148-055f-b41e7da9401a@intel.com>
Date:   Thu, 20 Jul 2023 10:27:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/8] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230713163207.219710-4-tony.luck@intel.com>
 <769521ee-6907-1613-442f-e2915a8ea554@intel.com>
 <ZLcY1MQr5/Ibnv7N@agluck-desk3>
 <076a76c9-ab57-cae2-e6e4-99d26921b578@intel.com>
 <ZLh9y8LQNkR/VhOq@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZLh9y8LQNkR/VhOq@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:303:8d::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf80e28-ec65-4666-f531-08db8946a371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXRNsqQqW/QQC7g12dgv4exrTF8zVg5uVCvlIlff9sMUFtT9uA8aJsfj5IXQltg5HSAjV2NLXtyfIl7SVbi/vuJBpYbymFClc9whkH9u4o9LS7adVgCfxFviQ3TCpfjSvQy/2MupGxZVmmFKa/iVUtIGey27L0UpZGRwAmT7cTzu+/s5HZYawIj6OBoY9hQf+Cz/RmQJU1+nYNuJNvwc+qYNkwbD5KZwfQjZKHWlF9lHDeeJOTuFgf9IyydYryMECDVQsWS9aPMc5JZ4UjFwbhiczG/5ZiMa5Q5qSfvDhcTo2rZMMnqbW0PQwpt4cUKuNBnvp8i2/Dvuey2yQX+Q9iSTYl7/pnbYOIRI7aWHr9exg9hA2FLNHwrSKcTbsWWUX3VJbxHOpRlD88fYiVST/esieN/DtRFgcoYmDHs47lIGf2zN6N20yNw56Cf0c2cyNU5C5YYDP/ChuUgXvwa0izGiec+HdUCRcOyShQi2VtC6VxK9AbFYgOfNVL0gYhkFsNKi+y+12mZi+Oxpj6hoLGN3EfzUFPO3XrNEuWxp8lIAINeNVaSIq64EYF6iJA6nqeE729oHBDadvyDJUPjXBVaPsDGQZgCNW2USrueIqYVKZplMqJfwF5Z57JdSVyWVzUPbkeDiC0s3yWILGxFW0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199021)(83380400001)(66899021)(2616005)(2906002)(82960400001)(38100700002)(66556008)(316002)(66946007)(478600001)(4326008)(53546011)(41300700001)(6636002)(6506007)(26005)(186003)(66476007)(31686004)(6486002)(6512007)(54906003)(37006003)(31696002)(5660300002)(6862004)(36756003)(44832011)(8936002)(8676002)(86362001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFdpYURocXk2a1pCb1lXZ2pFZ3U1Z0o5MUNweEJEbWwwckRia2JrRS9YRVVj?=
 =?utf-8?B?VGR4L09ybXBRVzlHQUdWVnQxQXVFaTROcGM4YTlPeERraHdiaHJZT2FPaWZi?=
 =?utf-8?B?SDY0RnZKQUF2WkxscmJUTXNoYVBDUDVHKzJrZ1diZndKTXg1elY3VFp6OWI2?=
 =?utf-8?B?anQ4d3dNN0t0bmw1RzZWejgyc3FUYkVzZ3IyRkFFa3MvVFV6QXpwUDBWSjVR?=
 =?utf-8?B?c1J0SFRMbmZ5enZuSis5NkpaUnRiOXUxWHZLQTJKbXBudmwya20wRW45VFFV?=
 =?utf-8?B?MkhwZXY1R1hqRzBEQXpPRWpSanlhRzNRVWp5bDExMUhGN1ovRzUwZWs0emJB?=
 =?utf-8?B?aVpvbWpuYVFTVVBkSitJUGYwaGYyWXJmV2hTa0pnQVcwd1FDd1dIdzVHeHZh?=
 =?utf-8?B?aUNUeG8xM0E3azE0Vm9kOGVqRE1MNm5uNHdNU1F4RTJ6TSt2WGZmUk4xRkVB?=
 =?utf-8?B?QkZMQzZLay9EeFFGVXNabExQV1JxbUJKek54eGpldjFmc1RFaEJRejg5QTIr?=
 =?utf-8?B?Y2hxeGd0N0Y4SUdDZkFvcjVaZU0yU21EZWhtU0JUZWFSS3U3bGVUUkEyQTEx?=
 =?utf-8?B?Um1VRGlNbXdOWnZHOUltRnVuaWQzUjVZRnJ4N29SU2dVTXdRZDEyNzQ2MDcr?=
 =?utf-8?B?T2pIaDBUdk5nRUJjZXoxKzdDK2o1WUVJdTRxd0poaEVvRklBZlRaOVczb1pw?=
 =?utf-8?B?dGFMT3R1KzVHTVFMWEU1akxNV2twMVdxcUZmUmdzRzZNUkJGemlyR3kwSnFX?=
 =?utf-8?B?ZTh5SitsMWtqY3FublF0K3J3SnR1c3h5RTk4VTQxRnY3WmZ2TlpDK1Nhd1Z5?=
 =?utf-8?B?VjdpdEhoZzZLb2NxOHZ4MUtjeDZsOEh0elh2dXhPMkRXUzA5Q3dHdGRJZHoy?=
 =?utf-8?B?YXFuRjhrb3h6Y3R4Ump5azAvVXBNQm5kdDJCYVVqV2Izc05FclhWQUd1N1NL?=
 =?utf-8?B?NjRTZGI1UEIxQnY4WjQ4a0dUVVFocTMvWDIzcEZWaXVRN2QxQUhkWFZEYmt5?=
 =?utf-8?B?U0U1eUluSW8yUGJoVWRXcVh1cm9CNWhwZEl6ZEN6bHh4RGp6dUtJVDNyWno2?=
 =?utf-8?B?RFBaYzRQREFUd2RvK0VoaXhRZThoVVU2VjJLbkQwKzdYQlhscVQwbVg2bHN3?=
 =?utf-8?B?Q3FDL1Ixa3k1cnNlR3ZwcFY1M2lDMzBDNFpKUW9nUTY0WkQrQkhKOENKaEhl?=
 =?utf-8?B?bU9XMVpmSW5Ed0ZJVnNsVURtYzAzMGF6TUM3ekdDSzhoZnUxbVgvL3g4Z2pp?=
 =?utf-8?B?R3Q1bnNYeDhuYnQ2TElldTcrTDdVOGVyUnJMM3ZnV2RBTHZCV0VhSFV4UzYw?=
 =?utf-8?B?SXV5QVd3Um12c3hWeTRCKzJYOTUvMXIzVGpvOXdmeGkxMm1SZ2dYdjczcjJ0?=
 =?utf-8?B?dGlFNkFXd2NUb0UyNWxRNVFKcXhNWHlJOGlqdlVidDdGNWNvR1FFR1lhanBR?=
 =?utf-8?B?MlgxcXlISTRvNjNwVEFKU2NoUGZDWW9TNkVyc3FMVTArNEZzUUJ2djY2eE8z?=
 =?utf-8?B?OVJ6K0hiM25QaVRyN28zdmJPaXlqVFoybmJncnZOMnFQZ1VqK1M0U2dwWjVW?=
 =?utf-8?B?bFZtblU0ZGJzaXAxZzZINExEdjg0SlJrUXNVL2NZdDFZTFp0Q2NKZW1WdU5l?=
 =?utf-8?B?amgwV0lGSFQvOG5jeTdyRHhpUzVkeHVBWnlwWlJqQXZBem5BVGMzY1l4LzVG?=
 =?utf-8?B?UE5uQ0lIVHRiTkRpNkhCUnpwY2JOU0lhMW1uZXdNKzkrQmV3YXc4SGhqRVBy?=
 =?utf-8?B?dStING1Dd1lSODgremdhdnc0WTJ4K0cvYmxQMWdVbE9ya3pDVmdNZFgzK1cz?=
 =?utf-8?B?cmJUL2d3SElaZWZaeDYwV0RRcStVeHg3VFhIakhGTVhvY0xvSEZQQTVMUXBW?=
 =?utf-8?B?VEx2b3dFRXlGNjFGTEJOc3ZrRFh3dEQxZkNBcFU4RW9IMEZpOStla2dZcG5I?=
 =?utf-8?B?ell4VkNhRDZHSEpxNVY4SWdaWmV6MTZJVDV2WWF1SEhBMkMvczVwellIREp4?=
 =?utf-8?B?cUpBY0ROejZTcHo3czAzRTM1OStodHF3L0MxQzZnTXJ4VVhDWWQzRTlmMDBK?=
 =?utf-8?B?Y0JpOUN0YlU5RCtlZm4zSXhDRElobEgyLzllTDJwbHZUdUU1d1dSdXVqMVo4?=
 =?utf-8?B?TEEveGgvMnBHNlUxaTgzN1kxc2RQRkFSeGpOQlh4S0ZHTEhzamNtT2hKZXVQ?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf80e28-ec65-4666-f531-08db8946a371
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 17:27:48.7171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IL/qiEm1cwnDB2zxAAwwHoa7EdJI6Lomxmt7gLul2thnu0KxSJR5QecA7IJySdjU/RIKfhZP7iYiJUDEJZN72XRX3zTq+PfHiKtJFLVy8fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6499
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 7/19/2023 5:20 PM, Tony Luck wrote:
> Here's a quick hack to see how things might look with
> separate domain lists in the "L3" resource.
> 
> For testing purposes on a non-SNC system I set ->mon_scope =
> MON_SCOPE_NODE, but made domain_add_cpu() allocate the mondomains
> list based on L3 scope ... just so I could check that I found all
> the places where monitoring needs to use the mondomains list.
> The kernel doesn't crash when running tools/testing/selftests/resctrl,
> and the tests all pass. But that doesn't mean I didn't miss something.
> 
> Some restructuring of control vs. monitoing initialization might
> avoid some of the code I duplicated in domain_add_cpu(). But this
> is intended just as a "Is this what you meant?" before I dig deeper.

Thank you for considering the approach. I find that this sample move
towards the idea while also highlighting what else can be considered.
I do not know if you already considered these ideas and found it flawed
so I will try to make it explicit so that you can point out to me where
things will fall apart.

The sample code introduces a new list "mondomains" that is intended to
be used when the monitoring scope is different from the allocation scope.
This introduces duplication when the monitoring and allocation scope is
different. Each list, "domains" and "mondomains" will host structures
that can accommodate both monitoring and allocation data, with the data
not relevant to the list going unused as it is unnecessarily duplicated.
Additionally this forces significant portions of resctrl to now always
consider whether the monitoring and allocation scope is different ...
note how this sample now has code like below scattered throughout.
   h = r->mon_scope ? &r->mondomains : &r->domains;

I also find the domain_add_cpu() becoming intricate as it needs to
navigate all the different scenarios.

This unnecessary duplication, new environment checks needed throughout,
and additional code complexities are red flags to me that this solution
is not well integrated.

To deal with these complexities I would like to consider if it may
make things simpler to always (irrespective of allocation and
monitoring scope) maintain allocation and monitoring domain lists.
Each list need only carry data appropriate to its use ... the allocation
list only has data relevant to allocation, the monitoring list only
has data relevant to monitoring. This is the struct rdt_domain related
split I mentioned previously.

Code could become something like:

resctrl_online_cpu()
{
	...
	for_each_alloc_capable_rdt_resource(r)
		alloc_domain_add_cpu(...)
	for_each_mon_capable_rdt_resource(r)
		mon_domain_add_cpu(...)
	...
}

This would reduce complication in domain_add_cpu() since each domain list
only need to concern itself with monitoring or allocation.

Even resctrl_online_domain() can be siplified significantly by
making it specific to allocation or monitoring. For example,
resctrl_online_mon_domain() would only and always just run
the monitoring related code.

With the separate allocation and monitoring domain lists there
may no longer be a need for scattering code with checks like:
   h = r->mon_scope ? &r->mondomains : &r->domains;
This would be because the code can directly pick the domain
list it is operating on.

What do you think? The above is just refactoring of existing
code and from what I can tell this would make supporting
SNC straight forward.

Reinette
