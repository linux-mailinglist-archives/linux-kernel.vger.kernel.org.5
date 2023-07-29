Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396C0767958
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbjG2AFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjG2AFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:05:33 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC30F1724;
        Fri, 28 Jul 2023 17:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690589130; x=1722125130;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WTT9vZqy4/Q8TG0Fe7RASjZt+3z0KHzn7FiS9kXPXCo=;
  b=ihvHW734WKl47qyDgUybS7y0xbwNMY42Mf3m5gf4xRu87bYydrK9HNQn
   GXIZOzVcNBEUtS/vZwULJh9f3MBNHzR3CzDS2Q4IS9X8IlcO1QlvCp2Ac
   Ghlzes0RHRBKCCGeY770RGWrqOXIQF7SRHFwXqCAO+dax2KxBpkC3kwVm
   WZiPZkOoavtxsIXZz4qkPMpX78fehRlMzTHLpbpROUU5ORIZgNsI56Gbg
   bTloHHGwnF/7xUryV7wYnmEO3zWuDAkst1rZzcRRF/8Myhi9VT49SCqhI
   EM2056Qz+ce4EVB2/k4nEtvd9F2tsRkg86eIsRyQ8sXNyfszFNHVZx3Y7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="368719171"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="368719171"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 17:05:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="841507918"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="841507918"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jul 2023 17:05:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 17:05:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 17:05:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 17:05:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2vqEhnK+cjDpYH+vGitW4ba2U/B5DCfC0tC0qbJJNOGwzxwybNZhnj52ARpgF0nlsKwvsDPXujHbXiJTCezeT51ksEXPaUCIQ2Aw3ySlGfh/JnROxa1EGqNpBVbiRHVlfKlEpe3lBkph/Etr9ivuQkRNgQicUkoG8J27/brKwRxpAq/x4jJoGiSdDQWJLanmULsSw/QsAlMWc2lhvDWj+Fuj4kKyAzj6FVgws183Amxyvm55Jd3WjBQM9fFyzI8kaE6tJaGP36xvpoWtktzp3osbjd1EjYdzMu+ldmQEKS97GBLuJ7puo07TfrJPi9L7bEltHHiwr4W0P8HxsNqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+FVS/yNQqlLmtMfQD1N+RVZdVw8AVn8p0vjn8D0CjY=;
 b=MN7nVhJFcfj6eojccwHh+9n244+inRcmyvAnTWIxMJCG+jSZMn8NbYgLS1UnF1WXkJdrX5uj/HKexip2iG5Co75ztiWFbbjjkjCmtftawKP6KDksubpADBQb45AqpAnCh61wIpI4JgVGOGsHg47nqf5kyQnc3z6USjRl7qxZQX8v43pakuZqf8LNl6hy/q9+K68N5PrFQKK50gnKfjbaAeaCkTFmgsqVwXtmoK9uS8wHxGU5hRW93h4G9K1JfxoLvoTRFV9iIuIniQAU6/bE0IynnS3IlBgNoodB2Z7SHbG02OWfCrNOWFkmPuN6SC0IcSPD/eUzdc2JPBBQ8l5lSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB5503.namprd11.prod.outlook.com (2603:10b6:5:39f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 00:05:27 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2%2]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 00:05:27 +0000
Message-ID: <d0a478d4-0d82-3760-1b54-632d40d43e62@intel.com>
Date:   Fri, 28 Jul 2023 17:05:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch v2 28/38] x86/cpu: Provide an AMD/HYGON specific topology
 parser
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, "Jean Delvare" <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "Russ Anderson" <russ.anderson@hpe.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120931.226185847@linutronix.de>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230728120931.226185847@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::29) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM4PR11MB5503:EE_
X-MS-Office365-Filtering-Correlation-Id: c92b0c99-2a14-490a-a9fc-08db8fc78350
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMBQ8VASgbmkmctSHWEedAbbbAkmC1os+MtpyfwTBxUt0d7IvMoxfV5pmriMBdbYpVqI3/jnLf+3c6WY0QBKMBdPwXMVnmHM7vaShO8nox89jmGfiQ9tpm+Z9RCH/p/YXO6JObvpYDYmT1iQ3NWhIxqwPasDbbfeVb3CRBb0u2yrhs+yinDI2AgGIyrNJkdbNE7beakxu1nd70tvK8KxCfdSoPl4sGOjtB0t4jBEdJViaX3TMsG2IF84KPD461aNFdsuvPGhXwDRTNx1aasuM1qH9Kk+VU9ubVdQu5SPccuePHtHP+0ZcbpqYI/9F+x3EnbeDLk4wkbyg0pkFjvIPOTeXnO79S8xfLfurkbIIJLQlwmjPWQuIbd91p/LOKvdD9H3/B2xopOjfT4RDC61PnEAwEmgOS7TfvI8fhcKFjWr1n0zStPRmAalymZ6GODcls0Q5vcWSPB7f2a83UOGvvvdARJh7dDWhnKQGP/oNfTKk3Yg7FA3Cgh8piJ3sWvql1L4Gj8957WQZHmvI/G0duuOWQZJdy+GMQKqnxTgKkCGIqIf1rGc8cWper8cLlcqPtnD7Ryf58+kI3XiSKsJ7BHRxcQZWaUxejFxc3j/X6ueSv92dGZeKKunnyuzJ4aQun5dkMOW0EQqxWHwwkjVQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(86362001)(31696002)(36756003)(31686004)(2906002)(4744005)(110136005)(478600001)(54906003)(38100700002)(82960400001)(26005)(186003)(2616005)(53546011)(6506007)(41300700001)(44832011)(8676002)(66946007)(6486002)(316002)(6666004)(6512007)(66556008)(4326008)(7416002)(5660300002)(66476007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1ozQzUxb2hrL0F5WXRFWWxBbmFoRVV5MEE4VzIwa05iRFBYU2Z0Z1N1bHhq?=
 =?utf-8?B?NXVVbkZ1N21wKzF4VW5ydEl5Y25XSkFUZ0toMzJBa3YybmRtdGpFQ2I1R1A4?=
 =?utf-8?B?K1JXdnU3WWl6K281M3ZZQkV0amJxQmJZeHQzcDFXNGxLZFhhZWhSRFJwMzJi?=
 =?utf-8?B?U3hJaFp2YUc3M0JmL1IzN0JuakpURWphT241SFZtbnR4L25iOHUzNzgreVdq?=
 =?utf-8?B?ODg2WWF0YlZLQ0dib0tkMU1zd2hEOS9sTnhHKytPUWcrb2cwcXRhWG1QbzRt?=
 =?utf-8?B?bVhlbktQRENvTXJPanNjRnRhSU40aHorOVF3eFE5WmJIMitQRXVRMVFoa28y?=
 =?utf-8?B?enRXZzN4RU5BSXIyNmwwMVF4ZnN3RW40K3k2TklMbmZQd0xvUEhvQ2tLSGVo?=
 =?utf-8?B?OHFoZ20vdTJDRkxRZzhLSnQ3NmFYclcxYmJnMU1WdHlKSGdmK0hGTW9MbjA2?=
 =?utf-8?B?TC9IZUdXSjZ0QlNRWm9MZGNqeXpvL3Jrd3FjbGExM2ZpUHhiY2w2UEhad0Zp?=
 =?utf-8?B?UVBKN2lMeEY4MExrREdnc3N4aUY2UERlR1ZpK2E2UW1tZlUzWDBMbEVyTk80?=
 =?utf-8?B?L0RubzZvWmM2QTMzRG84bTFMeDUybEN0dDV3OS9IQ3FKZU5EMGlIQWFRT05J?=
 =?utf-8?B?eVhITnVYUmxDNGlqbkR4L0sxaUJXY2FnRDlSSUE1VFBGZmxOeHM5M1pYUW1Z?=
 =?utf-8?B?V2hkTC9Ld1pmZXdsUklyYWNCVURONVUwclNMbHZqZUJPaEJUUXVUQ0ZjNyts?=
 =?utf-8?B?K2M4TVF0MUxxWUxLaGdaVTJTVXNIN2FlKzI2YXNGR1JBMmZSWlZ4S0ROWDlF?=
 =?utf-8?B?MnBuOE5INmRPaE5hMW44Y2M4UTVoZmJzeEdaZk83TkpjWTl4dDVDTm5ZdGdl?=
 =?utf-8?B?QjM4anJVOEZjaGUrTDE1MnpvQ2ViV0lHY0NUeVRqeXdyRWdoOVhYQ0kvajBP?=
 =?utf-8?B?bGpibVVSMjF2cG9HTzNhSDFtOGtLTWN2TjExa25uS21KVm1pR3RWWHBpalFv?=
 =?utf-8?B?NHhwWVhYZ0JVeWdBUHVtTVNkclN3aG11blJrNjVSbGg0YkYwVWJSdWFCdHNO?=
 =?utf-8?B?OTVodk0vdGZ2ZjdNWWNQTDN3ZjVFbU9KWElPUDBIdmFsVVZCUHpNTWxkSVRO?=
 =?utf-8?B?NTlSRUcyd1dhcldUUjg4Umg5T0VmZ05XeExaTGRCUW5HT1doR1RxYnh4a2FW?=
 =?utf-8?B?U0FVOWxuL1JZS0RwT3FLWTJ6c0YxZ2ptWHlQRm16ajBhRXpCSmNsQmF3eDhl?=
 =?utf-8?B?U0FxbU9MR1NVcGR0TVl6ZDdtbjNyZXBZamNwMTd6YWdJQ2lOQ1hnTjlKR2tt?=
 =?utf-8?B?ZWRsOXcwa2NuZHg3UXFpcHE0N0ZWczl3MUtUU2hKUUhPaXB2N2p4aDgrOEN3?=
 =?utf-8?B?SE9IRGlTby9ZSUF2blY1K2diQVJzeDZ2dFZnTkJsRlBKZHVISm9xa21YUWhL?=
 =?utf-8?B?TGVuaExDNnZSRXlmSHRCOUh4akZoOUIvWWlEdEVhZXRsMTVYYnJaanpDS0ZX?=
 =?utf-8?B?bDVaU3hWd1FaRGJWZlV6MUJ0N2cybzR4WEU2UnZWc2cxZllyek9QekFwWXh5?=
 =?utf-8?B?Nkg3R3QvM0haT053UDVwZzFoN016TmZMcEkvU3dibTZDdWFJNjVYbU5zdkRj?=
 =?utf-8?B?WG5QZ0dvU2pMMHZZc3hreFVMUlJkMlo0anRramNBUlkxUW5nRXBSS2NLUFox?=
 =?utf-8?B?NURSeXN6dTVmYnlyaS9iYWd6ZmRDQnVwaFRkNFNjUGozak55enlrbTF2TDg5?=
 =?utf-8?B?c3R2eXlIc2ZTeUd2U0doMy9neXFMSlVUZm54OThIRmUzZm1ZdkdHdkJGc2k1?=
 =?utf-8?B?emNsbFFGOGRTbzhXT1dQYUl1MFZ3QzNvbUtiNXE0Rndka1pRYzFwSnJsTEl3?=
 =?utf-8?B?Mm04NTd1dWYyOHQyeDMwd2wxTVhtK0VSTTdlVjJqUjYvV0pldE9IVW9aalR4?=
 =?utf-8?B?OGt0ZjRaOVJJT3ZvaFVsQ3JQRUdpaEJ1VFNsT05QcnNrYnFEZkRIc1poQzUr?=
 =?utf-8?B?amc3Tjc5czdXT1Z1Q2lOU0pmaWZkbnREQkpuZm5UVTBLaCtic3c2MDZXcnNG?=
 =?utf-8?B?c3I3N3BrbnFQekQxTVc3VGNUU3plcHpsZnIxV3diaUVIeldHZkRucmc4OTgw?=
 =?utf-8?Q?uwLzA2YbkRktoOta20fmtk0+J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c92b0c99-2a14-490a-a9fc-08db8fc78350
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 00:05:26.9165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fH8yCQPB3BBCRrSdBpcleiS3HlIyFkkVAYE+GYBW+8HPu8emYbTCP6DHwwWXsQ6pO1j9FpsKXnG3crRHy9B1Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5503
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/2023 5:13 AM, Thomas Gleixner wrote:
> AMD/HYGON uses various methods for topology evaluation:
> 
>   - Leaf 0x80000008 and 0x8000001e based with an optional leaf 0xb,
>     which is the preferred variant for modern CPUs.
> 
>     Leaf 0xb will be superseeded by leaf 0x80000026 soon, which is just

s/superseeded/superseded


> +
> +	if (tscan->c->x86_vendor == X86_VENDOR_AMD) {
> +		if (tscan->c->x86 == 0x15)
> +			tscan->c->topo.cu_id = leaf.cuid;
> +
> +		cacheinfo_amd_init_llc_id(tscan->c, leaf.nodeid);
> +	} else {
> +		/*
> +		 * Pacakge ID is ApicId[6..] on Hygon CPUs. See commit

s/Pacakge/Package


