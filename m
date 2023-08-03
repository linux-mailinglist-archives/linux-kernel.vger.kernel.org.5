Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1824D76DC18
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjHCAJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjHCAJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:09:17 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEF8422E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 17:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691021334; x=1722557334;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2yuG6Jm9Qe48JmOagNHk2nT09/9xRMcaa694TTWzz/s=;
  b=LtyWwOW1kMjSFxciCkpsNrqoPrn8Ru+nEdF+E0+yXjGC6cou3iZO1D0P
   Jp3ePvpAJdZxJH1dGJppzE8xjs5HW4KVdd9hepyTMRXbtF8PixiERK/JN
   KwdEUOCP4+5o6PvnqLXzeaSm7EkSpp34pZY/ZMrDJn+Vk7GXnc3DkYelB
   XqBSndT2KWdKWaiC//Q6ZUS5QXGIWfrjYCqxtAwoLbwwtvWHu0UrjGDr0
   MNor3Al1RwbtkXAtVJI36+a/VW5erkPfFN0zb98z4Ss5dl/Zz9TmDVIOU
   g9Aw8vH95GlnWDjRjDCTr2LA5VDtE1AoMJUjgXwgPnZwtbU1YEK0V6iNM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="349328186"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="349328186"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 17:07:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="794794821"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="794794821"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 02 Aug 2023 17:07:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 17:07:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 17:07:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 17:07:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZEGf/CmoBpY0POWgaaiuYNvZDdwydE37jE7++VDYTfAVjiz+upaqvlhB89+bH299g1acOAKNeoHiER7ab4kElOKae6Fo6G1uXa61xl3eOCJ8XUBYL2FcvwkAdbVJeqngmSx1kMVsfKmnf8leieNA1dHFHivlQXWT9vyRY3ojXQEEN7pDcqJ8HqNhJgNT5ThdiUr59ymt0TH9pwZDjJG1ROiOyCzwQew4tbjxpTzPzDi1jXBmrfKHubTVbZHfcNPTtaKVfOpClQN3EEmkVpp/0d1hOuvMQUYo+UHy4pI1CeyNzPFtCJQSMyJ/ZRtPq9f7v2PymsH0M4lJg7w8cui3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeX39BiNEfWfT0BlgYfCA0xp2ggrAmybfHjnJ+Vdsbg=;
 b=iG+I3ncIe8Et83F/oLQ8wDIaKbaAkm0qbkuqZ/N0KryRvAHFbhd2WVq/G/mkSjE4QTcIfrnuEvgQ7W+VksrlLxMjQ5lapeRK3Y6+IG9AKXcp0S0O9Hz+STpqOXfLp2gw6pzKhZxBSpFCuPuJFGxyZ9z0DFYTEQqW1wFgAnD+MYeKPYC6OdqIvPpkcXrmJNxdwjTVLJij5LZDqnGviCvRAUcBi6tp20JHHzc5joyav9Ow0+oSvjxaKQggxPYgai6AjM3d/3ol6wPE6mNh/yQQ6O72KkTRQKE6J16d3kSFxzrqjmPXE0j42jWfoS08zfDb+sjuS7aFKblp0ytpvTOvcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SN7PR11MB7439.namprd11.prod.outlook.com (2603:10b6:806:343::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 00:07:28 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e96e:8ce2:abd9:c61c]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e96e:8ce2:abd9:c61c%4]) with mapi id 15.20.6652.019; Thu, 3 Aug 2023
 00:07:28 +0000
Message-ID: <a2d9f27b-2194-3f44-6819-1c7ff1fef5bc@intel.com>
Date:   Wed, 2 Aug 2023 17:07:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch V3 00/40] x86/cpu: Rework the topology evaluation
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Huang Rui" <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
References: <20230802101635.459108805@linutronix.de>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230802101635.459108805@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::19) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SN7PR11MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 146dee49-c99d-4c24-b23c-08db93b59f6c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nnMKx/BCfGRGGUtyfNKHAAHLEYBGPYkNCil9yGLCfhkIeLufqjhbifGepyUjmjrrrh38eCqvXq51RsaX8O8tM7ETfZssgiBp2JZ2Q4NX7b688UQ62q1Iti8LtVNNVjcI/QVwhCsskNfIjFaHy4jczUYq86gcM9FZOf0clqZq8kofnonTi/VTjP/XFSmpaau3TVWWV2GJNrNDH4mCDNFbLaPbLb/qkLQFDLs9b1VunVzQlwaT4I5vn+xK/gj4Sx2IN1I1OR+DeQvvVcpwMx8a+jDotQ1hMRmG/QW1KEO4t8r+gYX/3uzA2id55pfMVH5g8AAXI4z0A6oAO4H8duvuPTMDhd4YcVVNuxlUuEUiIZ/WYtPKNPqN8BPDvpNJQeDyxaA2OGCtM2blRFSeoQLGjMksdtdfWlcfvTng3hKY9LBMTOLjMIFpRl4yCO5l21kHIc1gzMjqT+Wlbe2K1iYzWbp8PzdswCHVGHVHafEXdZc6wcmE7LzgOquBLURyWhUAGSfeKinFAqppmmu4tIET8LrJD23PZKAruZnSZUhWvdX0P0JTOegUDRKUX3PcQ44XYYS/opLWuTea00G98FfDlW1Hl1jGfuH7N+1QNlDHAeQsejJsjQvL9gcv96AiIIonK8MySj96T+YhM+hqLHb98w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(66556008)(44832011)(66476007)(4326008)(66946007)(2906002)(38100700002)(2616005)(186003)(82960400001)(53546011)(6506007)(26005)(7416002)(54906003)(110136005)(86362001)(31696002)(478600001)(36756003)(966005)(6666004)(6512007)(6486002)(4744005)(41300700001)(8936002)(8676002)(31686004)(5660300002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW1TQjVZU1o3WWhKZnhXODRtNUllc3lIUjhXVVNtR25vVlFPWHI1d3RCTlM4?=
 =?utf-8?B?UjVJaExCaDQyS0lUcDlOYS9sRmFNdTNpY0NncGJNRjdzK1UvQVJFa2hIaUlD?=
 =?utf-8?B?a0tlWGJENDdMWUI0blJIOHNuU1NNMlh6YUJ2MGhRNC9yeU5qUEFKdC94R3E1?=
 =?utf-8?B?OFhaSlB2L2VxZmo4VU1nSGVKRkhySHZqWHZWMzlwaEdkRXdzUHdWMGRmN0Ew?=
 =?utf-8?B?NC9ubWNQUENMbXVSTFVKZlI1TDkyVmlhZ016bDdBWFZFSEFZYkwzajFiYzVY?=
 =?utf-8?B?SXRSMk1qNC9YbUJ2eGk1SVlCNE9DY0s2bDd4UURDK2FYK3A0bXFtUGQybzFF?=
 =?utf-8?B?TGFpV1FDS0RBRFp5QmVaeG9uV1FYY3NGT3pYd3BEK0RxbXlQYW1nSWxuOE44?=
 =?utf-8?B?RDd2SjBSYSswcitZWnlFRm5ET3Y4Lyt5cTFvcUo4NDFSWUxOTGptRE5KS0Vp?=
 =?utf-8?B?Y2o3RWsrdlVGNGNKZFpwSmR5a3kvcnRtNUQrS2txd0FHUHVaZTljUnc2TG03?=
 =?utf-8?B?M295cmM4bE5LMUZBOVY2Q1c4Q3FCN2ZPdHc3SzFnTWNHM0hycXVVRFBTNzZy?=
 =?utf-8?B?L3c3VFBFVXJ2MUFYQWJSSGxGVHl2dEk4dGVVQjhNbE14eVUzVk9Jd25sSWww?=
 =?utf-8?B?ZEx4elByS2FyWnAyalZlaGdwNDNsbitZTmhaM1JMV29lakFqYlQ1WjI3M05q?=
 =?utf-8?B?YlNHdkdmTFRtbTlaV3NwVElXOGw0YnB4TjRwcmNuT1FiT3lXcjg5ZFJmN3lT?=
 =?utf-8?B?cmpvaG5ycUd1ZldPZmNESGUrZWNCanRYM3hGZVU5WlZ0d1AvWXRUb21GdGVi?=
 =?utf-8?B?VzUxSkw2bWpWYnRLUlpiTU1oV0FTY0tnbkJzNzk3MnV6SzRKSkJIUStPODN6?=
 =?utf-8?B?cWh4MG5TUUhZWTNCRnI5UFN5ZFd1Q0xLclFELzdZalFEcHFEQ2kvdzRFNGpF?=
 =?utf-8?B?aEM2S2EzR0orQk1GQU93Z29qVVp5Tmg5RTFEZUxkblRucGpWV2p3SlExWXow?=
 =?utf-8?B?ckhOZ1gzR3NKc1FZTEg0MTBIMzNpVk1RMEVpRnlxamY0b3liVWNDd29ncVpI?=
 =?utf-8?B?MFl1SUEyQWNtZXZnemtST20vMmJ3Nk5uNzNxT2o0K2pwUENZYWt6T1dQakh2?=
 =?utf-8?B?Z2VDTXVXeFY1UGthT2tSbFQraGJXVVZZOXdKN0NvRnBXWitjY1ZaQ3RkRzBS?=
 =?utf-8?B?bCtoamVEVzZDMjJJY1FnT21sNWJSOEpsd0FIam9WQzkwWkNkR2ZvRnJUenRl?=
 =?utf-8?B?SU1vaVBkUzBtc25VUk1pOCtQMGlNVUErcXFUT295Qy91bkQzbDdpOUxJOHI0?=
 =?utf-8?B?eG9FazRwN1JENnloN0FPckpZa21HTjMyaVBXM0FzRXF0enl4ZEpld0lrTk54?=
 =?utf-8?B?RHhMOFJ5WW5TZ3lCd054bEZKYXpSdXNnNWFjVGR0eVg0MjZ2cnNmWTBrY1Nr?=
 =?utf-8?B?eEFQMHpOYVVnemlFUE1MclBlQndWdGM4a1BiYW1ROGdUTU5nNjYza1hxeW5X?=
 =?utf-8?B?cGRFVTJnUXI0VkVrZ2RvbEpidEZsWTZYbDZ0ZGw4RnFGZy9GRUxNZ2RZRW1N?=
 =?utf-8?B?d25DZnozREpIaStma01nWTNpUTNQOTJuUVhqeWJmYXFpWVNHS0pIaTZxdDZR?=
 =?utf-8?B?UWc5WVl2Z0RxaHB1TzZQaUltVVBzb1JQQXBkQk4yUzFDZkNaNU9sbS9sK3FY?=
 =?utf-8?B?OUVsWmpUWG9pRXFmTllIQnY4c2tTLzVvTWtPTkFBVGlLN242M01VeFFMOFhi?=
 =?utf-8?B?dllvSkgxUzJRWjB5dVoxZVVBQllXZVJibHhlSmxielY1M2xZVzhpUmFrZmE2?=
 =?utf-8?B?bVB4amVIOWxNV1VmQkVNWms5bTVpcFBoWFBaTTVhRGRKQW9JNkVDT2kxVFpP?=
 =?utf-8?B?SzRacVozMExNeHpsQ1ZLNmZoTGZ1Qmw5VHAvRnV1OWN6Q1FVYWlEay9XaG9h?=
 =?utf-8?B?YVBYT3FnOXpHTUJiMElFbUJwYmpOSUEzUzJBZGdjWllCbzNmZWFQaW9vZVRm?=
 =?utf-8?B?cmpHeVRTZ3FRY2ZXMCtQVlhsbmRDdEFGNVp6S2ltaG9lc0U4UGlGb0dOUmNs?=
 =?utf-8?B?ZVNDQjhqc3lsbjA3cVduK1d3YTg2bnJPVVFrYWxIN2lvUENRMnlGdTd3ZU9Q?=
 =?utf-8?Q?EG4nRvf/EyQ/ea1wJQCpdFCB5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 146dee49-c99d-4c24-b23c-08db93b59f6c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 00:07:28.0224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dFcE/b1akCoFiRX+yT9V6PD+LRlKxq7ELFzHOpSh67ZwzSOvoMYrNjLTD24Nhcw7gjtpAlCm5xMeERPLzZ2AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7439
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/2023 3:20 AM, Thomas Gleixner wrote:
> The series is based on V3 of the APIC cleanup series:
> 
>   https://lore.kernel.org/lkml/20230801103042.936020332@linutronix.de
> 
> and also available on top of that from git:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v3
> 

Tested-by: Sohil Mehta <sohil.mehta@intel.com>
