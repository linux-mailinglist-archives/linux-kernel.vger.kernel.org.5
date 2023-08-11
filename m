Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E427F779622
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjHKRb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbjHKRb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:31:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404CCCE;
        Fri, 11 Aug 2023 10:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691775086; x=1723311086;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rpubTa/pF9w0L0n+r+IrV+X31I7DdW+UYywURIYPk1Q=;
  b=m9AhuD8lYMkYyNqUzYDG7RyraNy27artrNzWcSLDwayUj7Tb0bNsZAdL
   1F92vT+Zr4BLib2kf9T5odTPN15ftr5mxJRlGWMESS7KxHXQOecTTyS2j
   DnQjCHVKy6R4P5zRI5OUpolK43L2OwFiGJs/STlVMT/YQryggteJ9llq1
   ItRwaLU25hlXoU4wxNrzIA3bZ4uiGY4bY853BFPHO7Q04v6bECrabwTv5
   OpkuWBJV2leA2mp/PmlGX2F/XH+1NbtTpGgh0nkEtpe/TNFOsZV8+ZDvc
   PzoW7v5VWXcZ+xfJwVlf/ce1QnNJdPLDzEf+7Rn538SpqPLL8alpXrlxK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="374492742"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="374492742"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 10:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="726324802"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="726324802"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 11 Aug 2023 10:31:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 10:31:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 10:31:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 10:30:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEHYyRLM/M4y1NytjqBgCJsnA1uHpnjKi7SANq1fGyT6HScUWOaZTg+Y5zlYQy/s0U7s+Pph532fWS8Jw5hvEL1ugc8f9UuZHClQ1r2D7TKhgHPKjDrS1Qq2bvSk2ZidHuEBNT7Lofh4pbb1e5GyWRr18+deIK6Y2ppLZQ+6leuQgX5UNTalLdXSIxgjUti6/Qgty9VjpqoKn2XbHrzep5JfU0m+Nda4f0sEiwaFbnESPt1ihe/PVsn/UfFXbNRX+CRLAaVb4yjrrLM7S4EsiL+qKjpPqVl/NmRwu62n+KZm/4YwrlmT6hEdrj829Ywnc6mqaucz1GBubXHtyg4Uwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zE5uw6cU4f88e6thPkLWq0oqAPpBw9E5kOixfG4vugE=;
 b=BmiIo/36tCoweuY8DEetQIkDuGYy6M2rS/fSMsN3UhXZlkY3qiFpzD1SLyLL4lqJ6rFrHwCCmN636w4vQAcIGtdBKU8+ELk7AjtyLs98Zht5/V+zHswM+LIv1WGPGML6KO4csj8qA5grf9GzOJuo0tzt+2FYKrXFFQjc7lHVxbymXSGU0Kd1X4KZUjTqxF14NO8XC634qtB4NXcWhUsoTvEjbM6mtKQSYj/WHwJ5I3O+hvCHJnJ1yBhtPARALjKaFVo0yn6G3Hedrh12ovagIbPGATfYSwUPUmHnVAyJC1NOh9E8TWt3kBMmPPjtl0K/1VbKT68accQlFuNxy8I0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5609.namprd11.prod.outlook.com (2603:10b6:510:e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 17:30:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 17:30:23 +0000
Message-ID: <17dbf847-bd91-08ae-7c1b-3278b000dc6f@intel.com>
Date:   Fri, 11 Aug 2023 10:30:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v4 3/7] x86/resctrl: Change monitor code to use
 rdt_mondomain
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
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-4-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230722190740.326190-4-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:303:dc::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: e7dd5ec6-a272-4e2a-cbce-08db9a90a475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sc2tkn6nUD3pGM8vHhrSTPpDVLoAnWiR3B73nupm7180qyWXqAupMIMuOSak61WzLDYzzuHp7nAvm5nk0S4J8mwy0Kwt5WB90mTJBZaJaPWhMKdgpHThRcUavZeob9eteoilBWPFH/1Fo42y3FWJlv9Xl7SVAmfEus+YuHgACfobRo2+R3MWgJUQC9oZG51zd8z8H4XWnFre4X6A7OgrfIPEUHZCcDa+kJ13TlRRx7uA9h9OrXk6/zitbaBOp+g44ynjqMar599lVXkxAXPRqVrIaFj7DB3aDIn1lqvE1Do/0J7Uo2B/1+X/+JBWUtwZvQmvx6n/7IOh3lHSWetd4DDCKJ+97g/ALIiT5VNtXPTKmFqu7PQKWrIKyCcFadeyMNvjFoElwiQFJBR5g6O4RGm5Y4XvwuUN6BUQXmCb0z41gknUjTdAmhAg/grM8eeDHpWxMqM30k2emtpXeSINuK3EeE3VYmk5mO9h5ZC09oK/ZJ/uqifQQy9PzDKXMasJhCdYR8lVyAQydaJHojSAPebhGCtSQfZrZQUfyEAOE02q6S1nZ7QA0xeMTfVjgzmWfxIMehTxVGSoeJurzbjhVvaJG90dKyMw6lrY5BJvvtz46lzRvlzpRZcS+DOVQMLcU4ZK+S1KWBpOb+zVxP5WyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(1800799006)(451199021)(186006)(36756003)(31696002)(86362001)(82960400001)(38100700002)(31686004)(110136005)(4326008)(8676002)(8936002)(44832011)(6506007)(6486002)(478600001)(6512007)(83380400001)(2616005)(26005)(41300700001)(53546011)(2906002)(7416002)(54906003)(66476007)(316002)(66946007)(66556008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEt5R2tkc09DNzVzQjQxNVVoOVNPVkNucVlZV2t2eWZYQ292OC9qSm9iZ3RX?=
 =?utf-8?B?RU05STNkcFZXdEwwMWVBL0ZCQ1lJWTgxS0VTWjNkYjdnMXB2ZzFSelVjRU8w?=
 =?utf-8?B?YU01QWNsdUlCTXB2dCt5MXpRUGZXbmlwMzkybHJhRWs2WER2emJtckFtNEh1?=
 =?utf-8?B?Nm84T3RRcTRieVM0eDRkdFJoOFhnaFRib0xVUVY5SlZEMEhBWG9hYmVxVDl6?=
 =?utf-8?B?dVdwcXpPVGVRQXdRWi9nQytNZHV6Z3dRcktsZnhPVTdLRi91WFhucEtHVU1w?=
 =?utf-8?B?UFYrVzA0dTVNa0VXWDcxOUpCRnNrRnB5ZXpLUXEwQ0VtTGNJaXc0b0JYZFJq?=
 =?utf-8?B?aGE2WFBJN2ZpYS9JK2d4MmFtR3lNQWlyTXdyRzgrcUwyQTRldGkwVmpQYW8v?=
 =?utf-8?B?UVhoejl1Z1gyZzhVWFdBcWViK3l5NmlvUGdpNEZSZ0tja0dZOWFpd0hZYkFL?=
 =?utf-8?B?YVd4VkR6THcvdmJEcGhMS0YrSHhSWHRyYVZZVU9LRm5KeTdlcWpRZ2lVV0Jy?=
 =?utf-8?B?OFpnNG1YMFdBTk00SmJuc3M0TUhoMGNIMVNlRTNFSWFncXBDWGtOM0xDbzRz?=
 =?utf-8?B?SENUVjlya1RnOHprNkpPdE4wNDBYS3BVOGR3UWFYRjV4ckI0bmVCNkRTWFho?=
 =?utf-8?B?WXRsVEJxamFtWGYvUkNFeXZEOGpJZG9zR1F4bFFhMjJOZE4rZkdIZWJFYUMx?=
 =?utf-8?B?TkowdUlYVVVFUEpodTZqcFNsSXczRTdURXhQeXJMbDFWQkZrYzBkN2w1VnBS?=
 =?utf-8?B?VXVxUE02WUNFbUx6ZGV0OWFhcXY3cTJtajZSa3RuaTdyRFdlZUF5dVl4dWVF?=
 =?utf-8?B?WDhXQURCdVZyZzM1bkFuTGVyWU1sWVkvSENhekR2VVJQWkRkWjlHV1lRcU1B?=
 =?utf-8?B?TTNRNkxMNk5rUXFVKy9OV09MTElTcEliSFZWWnR3ZmUxSjB3Z1JvMDNFV2Iw?=
 =?utf-8?B?NGdYdGU2NnNHZFc2QXRETUdsMFJsclVtNHVwSm91SDFROUN1VkxPUTk3S28z?=
 =?utf-8?B?K0hvYUZ2UlhJK2tENFBGa2VQREdtN2pLN2RrcXQ0SGVnQkQybisvNTFNM0M2?=
 =?utf-8?B?czM4am1JSloxcjZJeTBPUitqVUJCVWNPcThRYzArQWxRZmU5T2JCZ002QzM5?=
 =?utf-8?B?NUQ1U3Z1aVpZWVpDY05Ud1hNTEVPQytBWU82eGw5UFhWV3BvTWZPM3AvbUZZ?=
 =?utf-8?B?eXlzNEpRdnM3M2piSlBPckxnbHVNMk1nL2hhNC9ucWIwaTV1dnRqZWVEbHFx?=
 =?utf-8?B?M1A5Si9vNXpZQi9rbHlRU3JIZFA0ZHR6ZzZtRGNVTlN1Z2ZxK2lDMy9YN2VO?=
 =?utf-8?B?d0hTak5oeFpIZlFJOVc2eWRrc0sycUZpQkpOaHhtTHdlSUN4dk5hdkFtUWlk?=
 =?utf-8?B?SEJ2L3djekFZMUtUK0RjU1U1UFU2N3QxQnY0Sm52UmVGd05ZMzBTMXhxUUU5?=
 =?utf-8?B?bXMrTkNSSjZwUnBocHVWSDNpaEYrS2hqOTRZVTlmTHYyWDQxR284dFl6QWJM?=
 =?utf-8?B?Z1hCMUNwSm5NWjlBdGVaczAyMWlIRGxmT3lrd3pNUGlhYWpJRFM1THBBTWFt?=
 =?utf-8?B?SlIvbUs2am42Zi96ekVrbXd3dDNnMURVYkladEMrRjQ2eVVmaWhGeTFveUIy?=
 =?utf-8?B?Y2NPZU1kUFJLWW8rR29NVXFjZzhQUVQ5N1dWUmY5SGlWdFNaZm1wMFpwN3F1?=
 =?utf-8?B?SStPNmlqQ29UdXo1M1FYdWJMYmw0VGZoZTdWTzBnaHRzb21vSXkzU0dLaW9J?=
 =?utf-8?B?OWxuT0lFaGtDamdwdHlEdS9QQWkyOENHT3pqdVhJVkZVRTNPMWpDU0xqeHpX?=
 =?utf-8?B?QTYrUmF0TmlTMk8vYnZ6d2NOOTdnbHF0TGIySzhsRXBtRGVGN0Y1KzlFSmY1?=
 =?utf-8?B?M1ZKM25qY1hvZzVDTHowRTBKS1VZVGs2Smd3M2xLbVNLSUlVVWViZGpaSFFN?=
 =?utf-8?B?R1diWHFHREJJa1ptNnBaQm5JVEhhKzVvTkh2VU0rZXZwNTJueTB6MXZKTXk4?=
 =?utf-8?B?T1Bva0ZuT2l3TlB3NFVmS0NzRCsxaEUrSGR4UGZvQS82elIxTnU0THJOVHhG?=
 =?utf-8?B?S1J0eTNqN2FmdFJsanc4bVlLMExZcXZBMGJlRlR1MVhxRkdiMWs3ZytRTkQr?=
 =?utf-8?B?U2RxTjJuakxLQVJLVEFyQTFrbk01OFY0MGEzeDh2ZmtmMFloYm9ObGlUdjhi?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7dd5ec6-a272-4e2a-cbce-08db9a90a475
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:30:22.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZVcpNUO9MDOWCiFLcWuqoJkJ+dmkWry5czyKheing47SrPUR2zbQerlXHFtWHD21gaZFV7s2Re/YLTnY4ux3sykv7Q8/tGa2TgSQ79ua6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5609
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 7/22/2023 12:07 PM, Tony Luck wrote:
> A few functions need to be duplicated to provide versions to
> operate on control and monitor domains respectively. But most
> of the changes are just fixing argument and return value types.

Could you please add some context in support of this change?

I do not think "duplicated" is appropriate though. Functions
are not duplicated but instead made to be dedicated to
either control or monitoring domains, no?

...

> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 274605aaa026..0161362b0c3e 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -393,9 +393,12 @@ void rdt_ctrl_update(void *arg)
>   * id is found in a domain, return the domain. Otherwise, if requested by
>   * caller, return the first domain whose id is bigger than the input id.
>   * The domain list is sorted by id in ascending order.
> + *
> + * N.B. Returned value may be either a pointer to "struct rdt_domain" or
> + * to "struct rdt_mondomain" depending on which domain list is scanned.
>   */
> -struct rdt_domain *rdt_find_domain(struct list_head *h, int id,
> -				   struct list_head **pos)
> +void *rdt_find_domain(struct list_head *h, int id,
> +		      struct list_head **pos)
>  {
>  	struct rdt_domain *d;
>  	struct list_head *l;

I do not think that void pointers should be passed around. How about two
new functions dedicated to the different domain types with the void pointer
handling contained in a static function? For example,

static void *__rdt_find_domain(struct list_head *h, int id, struct list_head **pos)

struct rdt_mondomain *rdt_find_mondomain(struct rdt_resource *r, int id, struct list_head **pos)
struct rdt_domain *rdt_find_ctrldomain(struct rdt_resource *r, int id, struct list_head **pos)

rdt_find_mondomain() and rdt_find_ctrldomain() would be what callers use
while they can be wrappers of __rdt_find_domain().


> @@ -434,10 +437,15 @@ static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
>  }
>  
>  static void domain_free(struct rdt_hw_domain *hw_dom)
> +{
> +	kfree(hw_dom->ctrl_val);
> +	kfree(hw_dom);
> +}
> +
> +static void mondomain_free(struct rdt_hw_mondomain *hw_dom)
>  {
>  	kfree(hw_dom->arch_mbm_total);
>  	kfree(hw_dom->arch_mbm_local);
> -	kfree(hw_dom->ctrl_val);
>  	kfree(hw_dom);
>  }
>  
> @@ -467,7 +475,7 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
>   * @num_rmid:	The size of the MBM counter array
>   * @hw_dom:	The domain that owns the allocated arrays
>   */
> -static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
> +static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_mondomain *hw_dom)
>  {
>  	size_t tsize;
>  
> @@ -539,8 +547,8 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
>  {
>  	int id = get_cpu_cacheinfo_id(cpu, r->mon_scope);
>  	struct list_head *add_pos = NULL;
> -	struct rdt_hw_domain *hw_dom;
> -	struct rdt_domain *d;
> +	struct rdt_hw_mondomain *hw_mondom;
> +	struct rdt_mondomain *d;
>  	int err;
>  

Please ensure that reverse fir tree order is maintained in all these changes.

Reinette
