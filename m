Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660C47749F8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjHHUIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjHHUIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:08:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3712A9E84
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691519406; x=1723055406;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jJUCQoxhXyPK4VhHA461RsSByCpg/LkeT3xhgGq7zBQ=;
  b=Q0F2rNGsYpQRaBt+9BLQWK36om8IF6WXFniT1SVOUYk0NtYil1C69UA7
   a5flddeJD+TJ1bwIh6d8ukh+gCpG1aYv7HY9LhCLdCnTnkthKvyWwOf4R
   3zII5oSmk8KPlkhnra/8QP/bqvty454EkYsBcR88bejWD6i/mNXho1FN/
   R+No1r8gtpRPYo5P50qNpOjP95JowFOXltMYHA7k1TphI0GuJ6tEFwtbH
   L3isTmYMKiCIHVdrNFs7NzxmpnZKbH6QF35mdKqbhnGnAJLP1jm3kcBHV
   gGrcl/1rFJHts07D9VBLxvRyvo22P3p3auYDlJo7HQ8spLwZSd5p78yUr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="368369520"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="368369520"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 11:30:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="761020024"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="761020024"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2023 11:30:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 11:30:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 11:30:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 11:30:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 11:30:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Umml7wVDCyuTuprhjDtOXjsGbu3w4rzGqsY0qoP3s3hsUtOaEBVnuwFgo0jri5yxFE+wMM2u5H1krLc5sVCSzbIL3VzhuqR7rAtDH5crWsJR7tJzsueUUD4p/gxhkBpai+c1Amie036p/rAiJSrUQEc5ChXFd32ipegMF9O1V3eDFJcFVn1hTWo7ldxaT6aV9dyn0w/JR2n4q9wdWVbaKc+cZx3OgrQjcAQOhKFaMcSSyggs6TP+3G5cD9brJTkLfhyF9kNc8n9HNCEUEjq4bVQwCdoq0t6pF/+kXVhau9RiZu01uN6dI1wJVgnyafZhx4RzUxS0n7/LUVZcsBOgXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYqFhCRgq3covePyqaacoSKCmBGHe/izu9OsNgEI7mE=;
 b=JP7B89Ym2F+6kd65aut60CMwgeXmma6KOVvFbO8c+n8THXBXD8UOcU8tSCat3t+6oTg8LLidbc0Z3+FRTZx8G2u55g7ESTXQRg0V9GHMB502wDytPQXgWHkQPGFilhLRRLjyyRvxz5EkKTKO8Y5upaHLLqL+J+6lHdwAdYXnaGeRxq30W1Y0/bx+/8e7Uhff335vv08YKLnRjn8AFv9rAZd4+shp+v082wlGP++glusphPWLA2pXh/lVmY55k/HwBK6Ye79vMUR/1AS++doCvvT1Hsa5v7R+d/xkld4qq0AtWgHDKyOyMM7sihfNNhAGxo/hO8q/DqmzSstd0ydjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB6189.namprd11.prod.outlook.com (2603:10b6:8:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 18:30:02 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::70ac:fe46:e033:41be]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::70ac:fe46:e033:41be%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 18:30:01 +0000
Message-ID: <c8ca9e16-ce03-1fe0-cf9f-f6cc2302dbac@intel.com>
Date:   Tue, 8 Aug 2023 11:29:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [patch 00/53] x86/topology: The final installment
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Huang Rui" <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K Prateek Nayak" <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        "Andy Shevchenko" <andy@infradead.org>
References: <20230807130108.853357011@linutronix.de>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230807130108.853357011@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::15) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM4PR11MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 183a8ed4-bb1a-4fde-83f3-08db983d7a52
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pyVkSCpBeDqyjJ9hgkXg1Vl13K9Jy0MXy4oVaQ6f/jxi6M7Km6OJcRXCi93IBvl09CvuHAnwOkerxsQXjWJ/y5IpqC17yJbloQtzo9qVkdU9a7zhNlndwbr1chq8mMryFN+a7EBVEcxP0ko3sojTmfAq5Q9MKjhiIq9et+rusnrkUmEAwhge/QkxPGHdNPSyt/PV4uT0AQrcytU7cx8SCv/M9mJS7XmtXckw8QsEurqiPNVq3q1v3x5Vdopeg6KeEVyykVqZt3DCFjhjFrobtbCWOwuJLIPJJTkmVU1aFWtXeBh/9Anzqn2w8Ome1z0fyNjnCxZ9b5tHY7P1opPprRod5Fglqx0mYTOkcmTEWQonigA9tedctkBGrsEbbvgeJ+uOrh9WmpwBg1wy+kcmmR3rkmgpjKeqcjUK1akM6Km3mKy9mq0owZXyAmjZII5cjMWnVVUzccGosycI25K6AZ0O3qdIu7GtJ/hlqg745VzXzuWL9Hf7ckfaS5sHqp9iArTVrODPtO7mZEzTleLPwcB+iaMgalpqJkvVx1UHNwU9XzfvKpzCL2Lhk27GOS6qlWwcJ9l+PQRn7lPjZLFiE+jab4Z49MVodinG8QzsEDPBJpCd5bftKEGQg7W3owukleOtcsmIb6bKs7AnNoZ3Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(366004)(39860400002)(186006)(1800799003)(451199021)(2616005)(36756003)(26005)(6506007)(53546011)(6486002)(6512007)(966005)(31686004)(478600001)(82960400001)(38100700002)(54906003)(110136005)(66476007)(66946007)(66556008)(4326008)(316002)(41300700001)(8676002)(8936002)(5660300002)(7416002)(44832011)(2906002)(83380400001)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzdRLzAvWVFTMmRwRHAraGJGamNYamVEOFN2UmVLMTRMUVQ5OXlYNFBSbTZl?=
 =?utf-8?B?UXRZTThtemwybEhHcldCY2RYRFJaQWcvcDA3QlF1WlY0UTVyZ0xKWmI5dzN1?=
 =?utf-8?B?M0VBZlEyRmpMNHZlMWc0U0FtbUYxL0lGVW9YUmJZUjBXN2E1cFNzcUFUOEN3?=
 =?utf-8?B?TXZUWlZQQVdGcUFZaExJSTRNZmlFWVcrajVDVUoxZjJWNUcyZXJIVy9WR3JQ?=
 =?utf-8?B?OTNOTEZmemtsRUpxWHh5bGVuM3FwZ3FOMnNvbTZMT0YvckhtejlGSWNvYWZR?=
 =?utf-8?B?R1hwVUtOdVdMdHIyRnFWRVlRTFdJRDBGbksxNzQrVUMvcitGcVJNWURiQ2xG?=
 =?utf-8?B?Nk8zVWJFTXdWRkNpVkRjZXhRVjdVc2krbTFwckNheGVIaytndjR5ZzhsQVNj?=
 =?utf-8?B?TUZHTU5Ka3hydzVMYnowTyswN0FBL0hjVWU3SjZ2Ykgva3pnQ0czcnhpQ1V0?=
 =?utf-8?B?N21ZeDRyMm9jME9xeXVKRjNHYUVQblJlS3d3QmRGWU5OTWMrUkpOWTROWksr?=
 =?utf-8?B?VTFLQWxUVzNTZnFjYjB3eXNKSUExdG9RRHNCajFVbUhHVkhZVW8velZLV3Av?=
 =?utf-8?B?RW5hemx1Rlo3b0ZNZDZEQzhwU0ZtOEJ6WlNJUC8wNVczNXByemFpdnBVNFNY?=
 =?utf-8?B?RkM5eHgvZEcramNDV1hveWJpWDJiaDZINWQ5YkhYS2xHT3pqT0Z2RldvcTNu?=
 =?utf-8?B?Ti9JMVNXR0ZCTm43WTdaMHNvWnJLRytRanErQ1hzL0NlN2Vna1dheTZueUdp?=
 =?utf-8?B?YUpka1pMdWgxNFpQTnZPK1YyejlyOENKcTZsZ2lCK05mVDh3S3pORjdiK2lr?=
 =?utf-8?B?RjlaZDE4dEtzNTQxV0FuZGZjcUsydnpsT3BITCtDZGpXNHB6emtUZEkvWjVv?=
 =?utf-8?B?Skk5U2dQdTZBT3lUeld0OG5QK00xZU5jSm9xbWFVY3c2UmpPY1BWekh4Q0xG?=
 =?utf-8?B?UW5xQjVNVEhnbW82ZlhNVG5UTVI1TkpoemZoblBiMHM3TmVQQXF5ZUwyUDFD?=
 =?utf-8?B?R1IwWGFISDN3c1p3dzQwa1Z0elNwR0VjcXR4dldxUVAvakhWam5Kdmw0NWFH?=
 =?utf-8?B?bHJXQTZZR1pYZVVnQjlJeUlvSGpDa3MyTHlPeTFqY0JIRThRMGFjS1V6Rklw?=
 =?utf-8?B?UGhLZEduUWVyVEJIeUgxRWNEWnpSZ3RBQy9KR0cxL2VjdjhkVXpJcklZa21B?=
 =?utf-8?B?YTUya3RIc3hibEIrWUFLU0R3RENzNWlsV2lZczFLOFVRd3lzZHRjOWVaQTFT?=
 =?utf-8?B?NWs5Y2xpWUE2TDJlMTExWWNHMmxKMUhKVW5SNDB2SXVBTnhqbmJXM0c1QVhI?=
 =?utf-8?B?QXM1TEdtQzZzSDhvU0M1NDZwcC9qdnUzSWVGdTUxb1laYncreEFWNmlxTlVz?=
 =?utf-8?B?MENZYktUVHhIRUtXWWh4Wmd6Um1YVHhNWmVvNzVvMkxhdlZNYWhpcnlCWjhC?=
 =?utf-8?B?TVZwTE5QVEN4OEd1SGlzM1YwR1Q2WSswYnZmRmhxSFJFM1NMWEZxQVlKdVp2?=
 =?utf-8?B?ZGpENmdHSDdab1owWmlNV0xJdElteis3cHYvNVUwVm5TSHBlY2FTR1ZiRi96?=
 =?utf-8?B?ZWpVeG5McEovNzc2N3FTOC9lVkVMUDBRcHcyRkcyQzd3UmpjazRPaVp1Kzk1?=
 =?utf-8?B?TE1jZU1mZjljUmtOZTc5NWlpK011czhOZVUyU3hTYnRRMGE5YnpQVGtXakJu?=
 =?utf-8?B?T3F2QWppeGhiVlA0OUJOL0dDRFhHd3FZcm9yUWFXV2t6YTFiN2lSZWxESTBl?=
 =?utf-8?B?cXBQNW1sZFVhTW0wWDRZSkxRNnYwVUxJdzMxTUV1UEdIcnFBelhQanB5QzNr?=
 =?utf-8?B?eTRIcmUrSnAxaS9Xc0NmRmFwV0tpZkRUZVJLMUpSVzJyQUdqWHlna0lhZ3RE?=
 =?utf-8?B?Q21LN3d6NzUvVEU1MHlTR1lGTDN2dUVoMGhIRjVDc0IvdFNNVjdXQzVGeXoy?=
 =?utf-8?B?VGNOSEhVanNCcFNMKzM4UklsdVZuanpPNWFzZFBvRVV2V2E3MTBhbzBHUUtw?=
 =?utf-8?B?YXJCZEhzZXpZeW9OVHJ3UUJQVlV6MFF5QlZTZUtCVmZmTVRkaTBGSnhWcEcx?=
 =?utf-8?B?MXdxbjZESmdVWmk3VXQ0bXIzbjRNV3ByZkR5bHFHankvOEtZNjZKTXptczhO?=
 =?utf-8?Q?6Xux1Rj2xypCcjQODRCdNBkS4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 183a8ed4-bb1a-4fde-83f3-08db983d7a52
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 18:30:01.7521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYpVAYyhOy9pjsZjc8H0SLMYi/4p/k55lfyn6I2toj6TIzVgbFMsGMpjGCGPi8jEUPcvLLrbmFYIguDq8Ud9cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6189
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/2023 6:52 AM, Thomas Gleixner wrote:
> 
> The current series applies on top of 
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v3
> 
> and is available from git here:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-full-v1
> 

I tested this on a 2S Ivy bridge system with 10 cores per socket
resulting in a total of 20 cores/40 threads. The specifications are
listed at:
https://www.intel.com/content/www/us/en/products/sku/75279/intel-xeon-processor-e52690-v2-25m-cache-3-00-ghz/specifications.html

However, I am a bit confused with the dmesg results.

Dmesg output
------------
CPU topo: Max. logical packages:   4
CPU topo: Max. logical dies:       4
CPU topo: Max. dies per package:   1
CPU topo: Max. threads per core:   2
CPU topo: Num. cores per package:    16
CPU topo: Num. threads per package:  32
CPU topo: Allowing 40 present CPUs plus 120 hotplug CPUs
CPU topo: Thread    :   120
CPU topo: Core      :    60
CPU topo: Module    :     4
CPU topo: Tile      :     4
CPU topo: Die       :     4
CPU topo: Package   :     4

smpboot: x86: Booting SMP configuration:
.... node  #0, CPUs:          #1   #2   #3   #4   #5   #6   #7   #8   #9
.... node  #1, CPUs:    #10  #11  #12  #13  #14  #15  #16  #17  #18  #19
.... node  #0, CPUs:    #20  #21  #22  #23  #24  #25  #26  #27  #28  #29
.... node  #1, CPUs:    #30  #31  #32  #33  #34  #35  #36  #37  #38  #39
smp: Brought up 2 nodes, 40 CPUs
smpboot: Total of 40 processors activated (239426.00 BogoMIPS)

Debugfs
-------
# cat /sys/kernel/debug/x86/topo/cpus/39
online:              1
initial_apicid:      39
apicid:              39
pkg_id:              1
die_id:              1
cu_id:               255
core_id:             12
logical_pkg_id:      1
logical_die_id:      1
llc_id:              32
l2c_id:              56
amd_node_id:         0
amd_nodes_per_pkg:   0
num_threads:         32
num_cores:           16
max_dies_per_pkg:    1
max_threads_per_core:2

lscpu output
------------
Architecture:            x86_64
  CPU op-mode(s):        32-bit, 64-bit
  Address sizes:         46 bits physical, 48 bits virtual
  Byte Order:            Little Endian
CPU(s):                  40
  On-line CPU(s) list:   0-39
Vendor ID:               GenuineIntel
  Model name:            Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz
    CPU family:          6
    Model:               62
    Thread(s) per core:  2
    Core(s) per socket:  10
    Socket(s):           2
    Stepping:            4
    CPU max MHz:         3600.0000
    CPU min MHz:         1200.0000
    BogoMIPS:            5985.65

Virtualization features:
  Virtualization:        VT-x
Caches (sum of all):
  L1d:                   640 KiB (20 instances)
  L1i:                   640 KiB (20 instances)
  L2:                    5 MiB (20 instances)
  L3:                    50 MiB (2 instances)
NUMA:
  NUMA node(s):          2
  NUMA node0 CPU(s):     0-9,20-29
  NUMA node1 CPU(s):     10-19,30-39


Questions
---------
1) Before this series, the Max logical packages used to be logged as 8
in dmesg. But now it shows up as 4. Is that expected?
To me, it seems that to get to 160 potential CPUs with 10cores/20threads
per package, the Max logical packages should be 8.

2) The "Num. cores per package" is listed as 16 in dmesg but shows as 10
in lscpu. The lscpu one seems correct to me. Why does dmesg show this as
16? I don't believe it refers to Max cores per package either?

3) Should the domain name and weight print be a little more descriptive?
	pr_info("%-10s: %5u\n", domain_names[dom], domain_weight(dom));
Thread    :   120
Core      :    60
Module    :     4
Tile      :     4
Die       :     4
Package   :     4

This seems a little hard to decipher for the end user without some
context. Can you please help explain what does Thread: 120 refer to wrt
this system?

Please let me know if you need any additional info.

Maybe some of these things are not specific to this series. I apologize
for not raising these questions earlier. The new prints in dmesg caught
my eye and I started to wonder what it exactly means.

Thanks,
Sohil




