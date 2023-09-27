Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AF97B0BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 20:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjI0ScC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 14:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjI0ScB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:32:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CD78F;
        Wed, 27 Sep 2023 11:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695839520; x=1727375520;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9qv7TLRlgpdsg71lPSumPrQLnepqGcvD/iqo+YDWKFE=;
  b=Q9ePsOFh48EuR32cqYNtge6qOyoFEZilEH8d9hK+gCTooAlw2xAH4AA7
   +SgMee5Q8t01KhkMMcx2DVY8AQ8ohro8223/KguCWC7wB7QanJdxdZ23j
   2NwxIsBFlrIHRlCKImujzXqFJDt6wo9jo+eCQ5kyI2OXbEVnl7Sx7ZcwH
   MloS1Si/E4w9MERj8cjSZuJ1B4Za668gKWJadLom6NjrN+yprhs7cyHN8
   u9N14zUdoso9dP/p1d60bwrK0+98LORhs1fzoZJpf0sBBPRAfvvriKYjh
   K8g3KaD1hLQMpz9FeV7Lfs+zizB0lnJs4pQKql463YqMd7x6mEq9vLPX0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="502030"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="502030"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 11:31:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="864945564"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="864945564"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 11:31:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 11:31:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 11:31:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 11:31:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 11:31:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBmI4xVdatRcpN/EwkTxzIhS6Wlzc07BeJFJe1iZ/UosLXEQH5AztnFzreSn5lNjmts+D3v8XySzrD2D4NWWmHBnHcRkMBUI9t7+531d3r/Hjuk4ZoRQ2UGcZw24N9+8SarZCqQ4v96QcYNqh9SO3GTe9QBi0b4OypLRAtxNkFcMM7ULGzrzVGkzlPQns1wBsbniOVW0MZXQxHwTM/akCLCKsP9NvGMau8NPMKk2J8jjQ5vKvjofmiGJyzBtto/ocZo20iSfoh4P+XXVWshGum9P04HCofm5W7vx3xKCOkAt9GgWtqSB7a4vPr3lOS6qTC3BWDlD+jiyrnDY5mwuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vg2yduT6orrF6f/UdAxOrsmRzH2DaWMYnWMQVsrg8zo=;
 b=KOfJ27M2v3EY13BIe0AOOJDyn/xFL8wY0LDkN3/NuLdQf9LggEwLJxqMqqQOdMQrYffr/M+9hyr+H57kFMX06vZiD1EDyTAb5+HwiJpe+ptrU6ZXK1J3bc6svvzZUZIN7cwof5I3w9J7u+n3aIa3onKIavLZVEDfOn9FXI0VcHzg7aGuMupdO0QrMSo0qqxHGyq7N/+lrGD7BCCbzV7G2UYqC/qfPjZQlZwDfZrt+j843f1upQyklN7JssV1fUszKZAgLOZKlfPoOl1SETHhl/mVGhHjW5Ile//t7VVdaTvpwRee7XCiA22Esvpy718CE/sqOWYTzVqNpWz1PCIsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4927.namprd11.prod.outlook.com (2603:10b6:a03:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 18:31:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 18:31:53 +0000
Message-ID: <49c10592-5e95-30cf-7bfa-7105a16bc315@intel.com>
Date:   Wed, 27 Sep 2023 11:31:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v10 03/10] x86/resctrl: Rename rftype flags for
 consistency
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <20230915224227.1336967-1-babu.moger@amd.com>
 <20230915224227.1336967-4-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230915224227.1336967-4-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:303:8e::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3e8ee1-e28f-4e3c-2bfc-08dbbf88056a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNmNmpnL3yR5uoXdwavmtPBgQfO94wr2wNjSbTGAvyEs5Nd/Fj7HXwZqaNprqVzZbBq/W0fDL2rrgXWQZZTTgZ5oTH1PAE4A0uFlLBedSxzm65CtyfWmp+WpEWK+SCfkaY9Quyij6T5HdwK8HAAJIV6ujvZYyo3z9L1WgGur604GUjt7MHuIaG0l+s8pOKzgqZq9RSmS3u8HmYACbLUr7M79mfUUJWsIB28WUH2FVN7EXFSs7fP808uB1xuKDK4Egc5Jv7d0FZD/QGu9WuHIqEX6XVy5LycoAuSIUnOiUCGCID7NPM2iFEp102ZMNcdmSA52Ab55M4MsvKURLF2/geDf6OyB8yymw90UAYvL0UkxVKuwWQiPPRAlsbp+ccjMWULc3W9eVJDXRfeAGoU5NT7VyGxgRn4Y92njhTT/s/VhbZJflRHRVZfxUuqh6n2LiZ/H9PaV6rZq+zp/DjrLfdLQFjTfz3z1f0ikKByOxraCpWZibGkjZPxN00bY40cZA3cw5Pcyj7/aPOeNYRj4iTh8q5JdqTqgLDy3lDwMfF5qIP6Gf2kUoMCSUUm65+PhBkL9eg8aJjPshegWw6bbHmfyQCOYEfkmSXvYzhem0jPe3g2AaHEN8QnD2qyOP8Vw/jv2bpCKNr8WuOTAPV1stg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(1800799009)(31686004)(6506007)(26005)(5660300002)(7416002)(7406005)(44832011)(4744005)(2906002)(316002)(41300700001)(36756003)(8936002)(8676002)(4326008)(6512007)(86362001)(66946007)(6666004)(6486002)(66556008)(31696002)(66476007)(82960400001)(2616005)(53546011)(38100700002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkMwNGJWU3c2SStnY3owRjRLTzRCdThyQTVKR2cvSnRRSXpsM2ZQbW1POUlI?=
 =?utf-8?B?ajJwOEhpSWtPQ2ltTmkzY09KVGhweDhlam8xZHV6OTZqSnErSzNYTDZ4WXBz?=
 =?utf-8?B?TjJzS01rRGdzN1Ezc1IwTlNVS1o0UjAwNDd1by9UdGtLUm9KM2lxbi8ydW8r?=
 =?utf-8?B?emZoYW10dDdkc0NkS2pLb1M3eTVyNXR4R2g4ejZrc3gyNUtRdC9JWHo3d2dQ?=
 =?utf-8?B?OWNaZlpWYjlFd0xQbk9pclBsQ0dFMVBZNWxRMVpMcEtEc2Z6MC9KelNIRGFI?=
 =?utf-8?B?d3pwaEJMRUtLb1JvMlZFbWJFSmxQaFl4WlpCb2Y4bUxvMVZzdUpZa0NncnNF?=
 =?utf-8?B?OTI2dnA4ZTcxWGhtcUdTa0tjeHV5R3ZVOHd3QTZsN1FiUFFXT2tiYkNnZ2VR?=
 =?utf-8?B?RkxwVi8rb1hUdzUxWUVCQ0VWdTVLOVdiUnVJMG14dW9ZRCtwM3E3Zmtadkht?=
 =?utf-8?B?M2M0UjNLeDRSajRxNHRaVFcvUVhtVnJSRVd1NTA4dWpoaUJIUTdaMjNoNmdI?=
 =?utf-8?B?b3dHcklkZzJBTkhuNStzbTBhcTVvMkRtOEJ6bWY3cU9ITDIvUkFkaXk4VFpP?=
 =?utf-8?B?NDJBemJwcDdnR0R5bExWaUtMckNoQVRERTB1WjlWZWJwakptc1NYUk4rZTI5?=
 =?utf-8?B?dWViT1VidmUzQk1TK29IeldtM0lBT1d1dWJDcFpWbkpqSW9oQWQ2ZkdDQUZh?=
 =?utf-8?B?YlZhNk8zS1dxSVpIV1QzeE1aWWlidG5wZHFEYWxhaTdlOWgzUW0wRFVjOERG?=
 =?utf-8?B?TU1GK20rUmdrUDlyakgrT3hzWEN2RUJaOGFzSlFCNWtKbFh6dkNuRnFqSzhY?=
 =?utf-8?B?bnhaaVc5NitOZXd3Z01ya3BsaGNEb0JYZkNDMnZFRGxJM0ZybEo2MUxTTmlC?=
 =?utf-8?B?T2g5SFRHclRNVk0xUFhiMDluaklncXFxd1Vab09NanVyVWdsMnkrcUFCUFhI?=
 =?utf-8?B?SDRXZTNhSG5KUWFQZEU0c2tFWDdLUmZ4ZUlBSnhTTWxxTUhZdlBnTmFEUmhH?=
 =?utf-8?B?enFkUGZHY0hSb05UUUViUTF0cnR0enFsYlhxSGd0R0FxOTZyU0JYMU54cFFK?=
 =?utf-8?B?d2wwemFsMmJwL1ljZ1hnNHFjOFhKaDRsOFpVd0d3TzhGWlNvZ1V0VXc1Yldu?=
 =?utf-8?B?NWRWczlDYWM2T0VsUU5TM1ZubmxPSlBCNlN0dzI2aUdRTldranBVT0llanpF?=
 =?utf-8?B?YTFsbE5pUzB4NVJnM3EvaFR5Q3E3YXdzY3d2cHNDMjEybTNMRTNWeWE4VTBX?=
 =?utf-8?B?QTFlUzA2SkI2UEpOMG52NzJDMDB2N2gvRFUyMDdWNGR1MGtEUmtTby84RUFs?=
 =?utf-8?B?OTRqZXBEVS9raWRtNTlpU0gyOWpxZERncExJUEdBc2FVNGJ5UHFOQkNNSDVG?=
 =?utf-8?B?Ty9zUDBZZ0RzK21mRmlpK0NvK1dyL0VKa2ovazVrTTNYMUdXL1BrQmlNVk5n?=
 =?utf-8?B?eG9wZjFUZWpRVHo2ZWZuWm95T1pwaE01QkNIV3owaXlBWFZDV1c1OEVFNk1v?=
 =?utf-8?B?TkhpTDV4VzdRUTY3L1ZoQXVQNTNSWWpnbzZRMDdkczU0UDlpS3MyOTgrVWht?=
 =?utf-8?B?SUJ6ZzdmVytNbkRpYlJTcEtSZmtYdW5HQVhJaFV0TlJhdU1lMG1FRnJPdlN6?=
 =?utf-8?B?N1haWXdWYlYwZDNzbWtlWUNUN2IrRGxVS1VDd2JPKzR3OXdOTi8rM2lzOXJp?=
 =?utf-8?B?UUQxelA0eVZxRHFqOWFxYXJXZmJxNjZWcEhNR1ZPWUkzc1dweUowR2lKYXNp?=
 =?utf-8?B?MUFEcVJzYXVQZ28rTVBkNWFNVnE0NGdNdVRuOHlLUFNTZytKKzZZOFc0SmZC?=
 =?utf-8?B?OVFlTVh0cXh5NWlIN1VHM1F0elppZ1B0SFFtbEdwUm1BaGw1ZmZUY3M1VGFt?=
 =?utf-8?B?L1lmejhLY3Iwd29xTDgzN29FMjY0Qm40UjZlYlJjd05UZ2x5Y0ZqT2FmM3hn?=
 =?utf-8?B?emdOWldyN1ZsUDY3YkROUjJVZFZaVmh1ckdyTWt3Y2V1cllGNllHNDg0VDFL?=
 =?utf-8?B?OHU3MmpMdDU2b2ZwQkx0WVY4ZnFFTForQTJiaitDTnFicW5MdER3a2VyQVRP?=
 =?utf-8?B?cTF4VFQwM09EYm0rYnVKSVlKRDdRVVZZRXB4OXRlQTJpRG1uSitaeXFEdmdE?=
 =?utf-8?B?aGZzMGVZZmp1SmNSSTVmdkczSXdKYWNraEx5N3ZxdEE3c0FGV3dOUjlNdmRj?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3e8ee1-e28f-4e3c-2bfc-08dbbf88056a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:31:53.2230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3amSk0dYU4zGr1XNfHZOpc6F/BJFYeXSjit1cT23IRQQbwo3f1Ymrdu89Rgl0jx1ebIylo0wd5LITwVYab4Niql9ZAV0sHAJvZDSpY/w1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4927
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/15/2023 3:42 PM, Babu Moger wrote:
> resctrl associates rftype flags with its files so that files can be chosen
> based on the resource, whether it is info or base, and if it is control
> or monitor type file. These flags use the RF_ as well as RFTYPE_ prefixes.
> 
> Change the prefix to RFTYPE_ for all these flags to be consistent.
> 
> Also add the flag RFTYPE_MON_BASE, which contains the files required for
> MON group only.

This appears to be appending an unexpected (because it introduces an unused flag)
change without motivation as an afterthought.

How about:
	Add RFTYPE_MON_BASE that will be used in a later patch. RFTYPE_MON_BASE
	complements existing RFTYPE_CTRL_BASE and represents files
	belonging to monitoring groups.

Feel free to improve.

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

The patch looks good. With the changelog cleared up:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

