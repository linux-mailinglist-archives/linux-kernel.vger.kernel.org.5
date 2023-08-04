Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26F177035F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjHDOoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjHDOoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:44:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC1249C5;
        Fri,  4 Aug 2023 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691160244; x=1722696244;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xMeZzmQGeNkf5WIalypbaKnEoLPojGOqNpTYmUPodoc=;
  b=aKo+uPLt0MtoxWm1adcBy0h0rrcyw4mQxBTCrb5jm4kun6GGv05uHAI+
   mnnmrbwDU5qep/vLpo3XsqyMmg0wLhssU2CUxVevFfMRxFYSSEF+yN7kM
   2dt1IzWP+ggnYFAvQtLcRjDvdB9TDPsmDzDam8AW6cvCT5Uiq0O1jb7aC
   kXYQEqrRMred77Rc6ZrxrJZLxR0OFYGxG2hkV7mOAYgYH2L4KceJZqB+r
   77DUsBPTbiKK5y00LWPpcTbIz4v2dO+OFO4PHLLp6RSFTISpuxNUZDhCn
   bphlgc9i9YOiDUlK41mlKf2BViGY8LPXZOz3srjGTrBpNPbfptbifFASw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="360223451"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="360223451"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 07:44:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="730087512"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="730087512"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 04 Aug 2023 07:44:00 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 07:44:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 07:44:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 07:44:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGgEdxbxRMPm359N+J18+ZZwifTc+VMptaexd1PGrNaZ6nDt7d4MDw9VCJg78ZP0dBUIN0Ov0MhHk2DtXFW7NJRqJbzUFclX8DlcOPkZkZAut6iFNQK0Frg9LFqqI85M8C4Mi9ZH6Q18cimhm/YnT27W4cCR30LibD1xCDJifjt0gQkWxGqxMxpTf2gmcqu4Uf2rSzVR3+BeSzBBUdz7muOmurFt7HSUr9bLj013xDsARVQ7OHd3MZeprDq8zKJ6gXM/0p9JGH7KxjzqLBlBO3PVMSApeNXmuG6+pM6D96TOqvEMTI1ZJtXFIWffhMmrq4wj6jhlOgyLAbeWxqUVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NG05LTO0cJFh53bB27vCjs+wdXlyWE2b+LoOxr+nVgo=;
 b=B87LNjt/7qxwPT9gsEaM9SAsm+z2YUxQYtNX1D5uRBngYe5hUIfObW9NbnstRoiGvl5EMjVWVup897+ni4J2yGaIYQc/3THp98fsvyNiQmojfzGEXS4iqcmRfIvWVqQyz7B3XCuFjfT4ok3tJjtSzHhz94zYsS4Ovxlpt0xToTYZlpKLKxSaIIPLyIJ6JQT6K5C3pkjSwhGtiJq5UjYrvzbkV6lCiFRkPkZywjgXj1E7AojeKRRaijLdVmsWk7TNldn9PzV4VHITNBZ08gi2ThXlD6YgfOxJmX4c3CppolDR06qrJSGj04guQEGnRBkoSRiQJGcswZLAVxXo7YyI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 14:43:58 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 14:43:58 +0000
Message-ID: <8732499b-df8c-0ee0-bf0e-815736cf4de2@intel.com>
Date:   Fri, 4 Aug 2023 16:43:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXT] Re: [PATCH net] octeontx2-pf: Set maximum queue size to 16K
Content-Language: en-US
To:     Ratheesh Kannoth <rkannoth@marvell.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sunil Kovvuri Goutham" <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
References: <20230802105227.3691713-1-rkannoth@marvell.com>
 <18fec8cd-fc91-736e-7c01-453a18f4e9c5@intel.com>
 <CY4PR1801MB1911E15D518A77535F6E51E2D308A@CY4PR1801MB1911.namprd18.prod.outlook.com>
 <f04cf074-1cff-d30a-4237-ad11f62290b1@intel.com>
 <MWHPR1801MB1918C41E2A44527D178F213CD309A@MWHPR1801MB1918.namprd18.prod.outlook.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <MWHPR1801MB1918C41E2A44527D178F213CD309A@MWHPR1801MB1918.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::8) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CH3PR11MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c3879f-b15b-432a-c923-08db94f93bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwNEexIYqpfh7Qly++yaLMlOFybz/z6dirsVmtU7ISip+c3dQCRz1uuo5gnxPP/x4oqB/geKY1sm4qPAKzIQK9P6YP3ABEtw3k7vZ8H5Mwe4MpckD5wGBAgGnn9vh/jIThOQexWML0Vq2DbviycIURgGpi8s6/92qjoSAeuG+AuUatFy5qOfReubXLM2uSj0dhqFAa6OZmOW+DRS600iyo3xxga9d2wYOJcZ6HI3cgVhqtOrNO9+ap3DuZvLx5jzc6CvWVNDd1XiKODLfUcRHSc2aBqAPeJuvxX70MO2lkCaHaDZ4r8MuWvCNg959wFptTRepv1FUXCS/sR4uL8j3eGGmtSixPR/2/8gIELVnwFVj4lYR7bqMWJ5l6lSfctqJc+2NW+evynr3OznxeZ5QrdIQFKMSYfkgGJKlaOOFiYlGskhF75S5w/dNlrA5HmAzE62B9W3UdrNIHnBGdlXbApPqtEcY6f9DLt+Dtk/yCwC25GgXYcRXRmYtATcVmBD/UePZSU8wQXBWXeeiiNA5UZFzk7HM15HBxjmwLzVkagwT9IALlAXuRf0FRTxvtpmnp29yOm9+ta7B6zTw+7o5L9/QPQYkH3Io5E0xKapGZan/ohOc6ml/pa5Gpxn6h2qOnGqm5sn/SnRYpqqEnIcQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(366004)(346002)(1800799003)(186006)(451199021)(36756003)(86362001)(31696002)(31686004)(54906003)(478600001)(82960400001)(38100700002)(41300700001)(6506007)(83380400001)(2616005)(26005)(53546011)(8676002)(6486002)(8936002)(7416002)(6512007)(6666004)(4326008)(316002)(5660300002)(66556008)(66476007)(66946007)(6916009)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek5ycXhnRGxrSCtrbW13NXVmNWJMUFJjTkc1QmpvVDZWY0oxVDdQdXhoQkNr?=
 =?utf-8?B?dkpNc3ppSGMzV1VaZ29aU1JaUjZuRkFBajFsalBJL1FjUk1HRm5oQ01seTh5?=
 =?utf-8?B?ZzlPMzhCbXFFdS81WVpjRERZRGN2QmpPcEszMFJxR2FiZEVxcHNPNnYyNmth?=
 =?utf-8?B?WWpaVXdMZGZvTDJrcHVwcTJoaDB5NEE5Nnp1YnloZEpURlBnVmJVTUxkelJ3?=
 =?utf-8?B?aUltR01RQU03Rnc4eHlQdkZPTEloQlJrZ01aVjJpU2V3d2lrNm93VWs2NFNE?=
 =?utf-8?B?ZGI1VUJQOVFrd1NQb1pCcklaMHpvemFkYWZiU0FxOXdsOEhubG55NzlSbFpP?=
 =?utf-8?B?WnlNZ0tuMHREeXc0UDFob1dZMndMNVhlSUVGVFlKS0tsR1I3MzlPTjR1VWgx?=
 =?utf-8?B?UUxYU2xCdkR6dTd5NHJiSlR5OXFZeGJGRDJJMzYxYkFHL202ZytCaWJUWmhq?=
 =?utf-8?B?cGkwSG1jYkxocEJCeHc2dmd1ZzZYbGRjSzIvTGdhMWJBU24wcmJvY0FUbGU3?=
 =?utf-8?B?WGdtOHhLcHBkVjFSTU5oSlViWDNySm5ZNHM5NWcrNWVSSUNWMkVHRlB5NThj?=
 =?utf-8?B?RDcyeFN0TVVUZzhOKzdyVDlBaHVka29vUnlIRDBVRzNVMm1IcVhZcFVaeG5W?=
 =?utf-8?B?a0YwSlZwWm5XT0pmY3JTNUxDMjNvYmtTODBxK0dpaDdGMkFFV01ySFZIZW5n?=
 =?utf-8?B?WHRBOWx2YVJGSnJhR1BVWC8zbVlNenloMm1KSWVud1lNaGNFM2dSalpHU2tC?=
 =?utf-8?B?bUxrc2hhNVJFNlNCdGVralZmbFQ4bmNZZ3ZCdWl5QlZmc0FCdG1seEpSeGdM?=
 =?utf-8?B?UytmQ2l2OWVJbTVIeHAwVm43MTRXc21ZK1VVSFlKL0lFL1BvQnRvNTM2VTB1?=
 =?utf-8?B?b3lhOHVBTWhlZmVsYkhDdldSOXFXOElhOHpSczUzRDkwQTQyUzd6NEREMU9J?=
 =?utf-8?B?QXZWWTdFK3hXZElNNnlrOEx4N0hhZUJOdlAvT1owL3UyUWpNNVYrekRNSDlh?=
 =?utf-8?B?VU5URkpJWXdWUUkrUG8wTHg3SllvSE02VkNtVmtlRzBkTGdKd3V1TUpKcFhC?=
 =?utf-8?B?T3V1QzJ5citJRjBjaTRVbG9TKzRpYWVjWEdYS1c5Z0ZrZlBtSVB5VmROc3dG?=
 =?utf-8?B?RkNkQVFWbjlnK1NnOVVBb0xjcnVacEdoSFhQSTNMTlVmYldTc2dhdGtqdTVB?=
 =?utf-8?B?T3NBN2djSit3NjFBQWdLV20wYm8vL25ZYlc2SlF2ZDJtRk1xdTI0VUpMRldR?=
 =?utf-8?B?ZExjZHhJUDBhVnFZUlNySjdBUXFrS1N4VE5qZFBZdmR6RjVrL3EvdEZIZHRW?=
 =?utf-8?B?TExlb29YM05zeFlBbjhIQ0tIMFA1eVRXMHljb1dHKzZOcVFjVXRWQlNUdk9F?=
 =?utf-8?B?MlkyaUQrYzlJNzFiUDhKdnJoUzNZdG9SNlBFY0hiRXVBak5seFd0b0NLV1hU?=
 =?utf-8?B?bzkzamo0ZjJqTGR0WWVYTmRzMmVvUTZvVUZhRlhmbmdIWnpOUDFqSVNGUld5?=
 =?utf-8?B?QUcyZ1hkcHdWSmRhR25iMlBIdUJQbmlRRG1HcjFtK3FsMHorUVB5T2VySkxV?=
 =?utf-8?B?eGdKTFlhd1NQRC9TVWgxZ1VQZ1RKV0s0dUhobzBYUVhnNWhyN1Z3R3FKQU5o?=
 =?utf-8?B?andaaDcxZm8xb2k4MDc4WlhJQWZNNU9qMURUR1psOWdlY0N0S3RKVTdFWllO?=
 =?utf-8?B?N3N4OVJ3bHdHNVo3MHBXZzZNMERjMXFuUkFkTG1sdzdrSlFaS0NqblhEc2gw?=
 =?utf-8?B?TDYxK0dDKzB2MjAxUUgvbExHTjB5OE1PQTh6VzM0YjI4R2dKbTF5ckoxMXZn?=
 =?utf-8?B?YmF5bEJxUjJwS3FUQld4bENaVFlQV2dXZFdLM09BcnJndGtYWU42Y0xDTFh6?=
 =?utf-8?B?YXluT3ZLQXY5NlZEWGNpai9LY1FPVW5UVkZkdnZwKzhqWjBPZTB3YkltQ0di?=
 =?utf-8?B?WGVaS01HUGtSL2lPc05ETGk5TWhXVjlJSmdOcGFqUHprRWg0b0hXS0JYQ1cv?=
 =?utf-8?B?a0NqbkR2Vll3ajlDQ3FHVDBWMXNBV2xnTmZPYlRra0F5QXYyWUdtZStLNURL?=
 =?utf-8?B?emR1Wk8vOExCM2NOSzZ6WUNIR2VRaFo5cGMxU3YvMzlqY0lGOTZnKzRRNS9X?=
 =?utf-8?B?b1FHQVlDM2t2b1VneFdoWTUyaU8zNEluT2FMRUlNZVJiQ0FOeFdaRlVUYzFS?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c3879f-b15b-432a-c923-08db94f93bef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:43:57.8713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nAOZvMPmdwRzLs5MC3uJ5+o8+t9VXFf0ah/vsBieO/WCnyquTGpvUOXNEoOKVzU2UyhCxXECMRW49vIe4mAsqWSFAHZ8SYRWkUMG+eQ2K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8414
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ratheesh Kannoth <rkannoth@marvell.com>
Date: Fri, 4 Aug 2023 02:25:55 +0000

>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Sent: Thursday, August 3, 2023 8:37 PM
>> To: Ratheesh Kannoth <rkannoth@marvell.com>
>> Subject: [EXT] Re: [PATCH net] octeontx2-pf: Set maximum queue size to 16K
> 
> 
>>> These recycling will impact on performance, right ? else, why didn't page
>> pool made this size as constant.
>>
>> Page Pool doesn't need huge ptr_ring sizes to successfully recycle pages.
>> Especially given that the recent PP optimizations made locking recycling
>> happen much more rarely.
> Got it. Thanks. 
> 
>> Re "size as constant" -- because lots of NICs don't need more than 256 or 512
>> descriptors and it would be only a waste to create page_pools with huge
>> ptr_rings for them. Queue sizes bigger than 1024 (ok, maybe
>> 2048) is the moment when the linear scale stops working. That's why I
>> believe that going out of [64, 2048] for page_pools doesn't make much
>> sense.
> So, will clamp to 2048 in page_pool_init() ? But it looks odd to me, as 
> User requests > 2048,  but will never be aware that it is clamped to 2048.

Why should he be aware of that? :D
But seriously, I can't just say: "hey, I promise you that your driver
will work best when PP size is clamped to 2048, just blindly follow",
it's more of a preference right now. Because...

> Better do this clamping in Driver and print a warning  message ? 

...because you just need to test your driver with different PP sizes and
decide yourself which upper cap to set. If it works the same when queues
are 16k and PPs are 2k versus 16k + 16k -- fine, you can stop on that.
If 16k + 16k or 16 + 8 or whatever works better -- stop on that. No hard
reqs.
Just don't cap maximum queue length due to PP sanity check, it doesn't
make sense.

> 
> -Ratheesh 

Thanks,
Olek
