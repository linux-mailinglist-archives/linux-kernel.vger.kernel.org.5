Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B35480F99D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377535AbjLLVnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377434AbjLLVnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:43:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDDCAF;
        Tue, 12 Dec 2023 13:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702417437; x=1733953437;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fpGojZph5I5spuCmJ5ktPfomXo9/HwrlWfKWb6PGfW8=;
  b=RPBnaQHyjM8Hwu0Zs4mS5FOTa9q9V9rC7Nh6Lqkbrm30k9fTJjKySvv4
   W0D/Fe9xpRrBMa4Ec79hC3IHl9+a67wHdf72svTrPEzxKACmjCR35Cak6
   x4cscfD825waMRosT98fUAuvaQjIh2hKs4FTU6lkPAd/n+4WnpFlQYbXC
   C4VxUGNzQxsZy6fc7K9NlIJm0ddSLGIO3AqsMxj0qKQIHdqRGJAWDSZf0
   evLw0kJvV/rRNmzRSaW5otUeRZGzzAcA5NZvb29hMhNl0wKB8F2KwURhQ
   65XqP3XIXBN/WtTb2ugCfrRofdIwDTXItuaLb30YtaVZ/gvCBOshX+QMz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="398716432"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="398716432"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 13:43:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="891774372"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="891774372"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 13:42:57 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 13:42:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 13:42:56 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 13:42:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBmarKoBJEXA7GQb+MhBdPIOEYuMky/xYJq0qTkwhvdXpLDMjPd6kn5mXyJ8J2atyzBBzhZT7Buf1c6k5Sm7rILu6ZLEStC1495Noq4FhYUB/vvbaD7hqR38cFoR3xmzHy3kRNmmyK650M79JI9TBQ3ukljHGc2KJ/+PPheqxNRIuwjRgKm+k6D1e89gQNciIfXyYBzgBFUWYs1I/lI03qzdTw6hXnr1ByeKisKFTUNUdzTbccqAATtWnWIjW7IkKQEfbjZUxwuBFd4yVn9+nZx1I8wbm1Nm1b0mPM2lFvS5BbgISe2hEvN4jsV4K0ExsPw7CwCboPQieJWjGGer3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IH91qC85TtKrsv4cjDOHezeZjXkDg0OPsSO6l24umvc=;
 b=FrT812o0j0o0FGZ14074MzMDTpnTWkNxA0BOhRay3OGwUsP/I5PC6VJBuflSvkEklPMvnrb9Q93j6OgHBTw/QIBkOZ3XFdsPhnndv5euQeU9f4y/hOUBBk0wjM5oYrVz0FRIUdIXOGFtYglSoF3qVZWFnrV9eIql6/enQ8u1rXkNfgkefFTK9T+4cE1yqPbG+mByNBSBgXzMpbkf8gHHhiQ1chYkTdCTgCXVI9nT2GWZsxEJ+aAaJaDYOozc2ekhf6Ez6q0JithifKOUbd23IAI74LWDpwmCHZ7QBIKUVUe6HKEm8YtMCOuzcvCTqFcJjKSBJGVBtTqQqhQSaftJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8750.namprd11.prod.outlook.com (2603:10b6:610:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 21:42:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Tue, 12 Dec 2023
 21:42:54 +0000
Message-ID: <5215fe1e-52e1-4ca4-8bd2-a42152f3e0e3@intel.com>
Date:   Tue, 12 Dec 2023 13:42:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] x86/resctrl: Add mount option "mba_MBps_event"
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     Peter Newman <peternewman@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20231207195613.153980-1-tony.luck@intel.com>
 <20231207195613.153980-2-tony.luck@intel.com>
 <CALPaoCji1yzfkA=tms3LhYMvRB+wSJQM3qzPKrHNEa7a+KduTA@mail.gmail.com>
 <ZXORTTIUKWXOsd9p@agluck-desk3>
 <CALPaoCj_OvMzD8W9+jEORewwDquM6F-sOW32Ngcy+Gm6A1+OcQ@mail.gmail.com>
 <2377bfb8-00bc-4863-8d70-425cb70c9c0b@intel.com>
 <ZXi8Rj3znA6lmjE9@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZXi8Rj3znA6lmjE9@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:907:1::40) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 5485c9c6-4511-423e-ec90-08dbfb5b4c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvt30dmVkIOma1iy1qJL5BQpUA311ILmDHmxuNGJYJZhRelUog9rLngQj6A8J0W0FingEsKkO42zAgEGeZ+DAUUtIuB6/0MKA+mwVZ4oexRvLC5R4TU3U35m7K8d7TBS4sNFp4QoAaM4EhPzEKSDFxz3898HG6TvLbiyEvZGuz+us3NTCJwvmVQRxJLRsitrPo6dLbKalxb69kf/VkzqH2TSLX6r2GVj0U9hkfT9oXuGJPmqx8ZvlLSoBnxet4mwBTOcbwf4nc+IMR4aNI+wEc8a97cqQejPp8hq87Tl+NNaSr4H3hh11LMtJxJmZZcwv/a3Hspdg25rs9g9X0hbFzxpQi5JvH3j5tRDdjPNqOOf8gHPIwsAfGa9TOqef6g4zYtz0l1Kt2y9dyyiEDL1Vjb0JuZGK2S/aH+sHL+Rs0zQro9vItPjtHvMabWF7V8IRuN9SM8uhp/j39ZbS417CdrVtUQmm2+Kf9qWTMEOcxIsZpOBFYZYT/snBfwT/oVJHfmlED++iOT6xGkU7wdeBjp7GukRIeazCSYqQ82wwejGL7+cahIuj7q/oBH5DUKm+wB5voyrlYytGRxqjThMtp7FFn0WZHyKzyHGAd90RvfBkDUcUrn9kggHO7VHyl3EIRRNxHH3GbxP51KuB+hcTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(38100700002)(82960400001)(8676002)(316002)(8936002)(86362001)(37006003)(31696002)(36756003)(66556008)(66476007)(6636002)(54906003)(66946007)(478600001)(6486002)(2906002)(6862004)(6512007)(31686004)(7416002)(26005)(6506007)(53546011)(5660300002)(44832011)(2616005)(83380400001)(6666004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW9TTkE3V1FQK0FweEJ1MDgrOU5qbUYwTmxiTjlTS2oweUc5RGNoQ240TG1L?=
 =?utf-8?B?VTYvNlNkVktNRVBOdG9MSy90eHBFSU8zMzhZajd0MnhrRVBBTmZLSThlNWtL?=
 =?utf-8?B?VWgvMFptTnRXWVRkZHlWVStoSWp2Q05QWGw2OWZWYy9iZXFVOWc3eHpndWdD?=
 =?utf-8?B?ODJHOUpBOEdEclgva242M3ZKSUhXZlRsWHkvdER0Qkh0eWExT2ROQkhac0Jz?=
 =?utf-8?B?SDNMSlE2MEJpd1EydG4wbVRsdVZ1SElpeFpmYVBzdFpkOU1HM1lGeWtnemVx?=
 =?utf-8?B?Z0JrQ1NacXZQVmQ1eVhjc2dQU1Q4VmEySE9DTytZNlhOOGhVL3JQbVNKQ3J4?=
 =?utf-8?B?Y3MxWStFTXBOMVZLYzd5ZjVUZExOTUt5WmdESXZFMElsazRpT1dvNzVHTmtZ?=
 =?utf-8?B?blVmVzF6TEFlWHFJTWxzaHlJV3I4K1NlVGZiY2lhVml6ZThZcjVrRHZhc1Iv?=
 =?utf-8?B?VkhHVVZrZndwaC9zVVE3K3VYVjE1dVFmUzFnZlpYZzh3Y0pVWDJZVWNCZmVv?=
 =?utf-8?B?aG1NUU1IWUg4Z3dDMldQVTJXUWV5QVk3eWxoSTFnL0NCbTJvR0QwQWJ0Vm43?=
 =?utf-8?B?WlFFeTZTNFFIaUxneW04ZFlWUXZJMmdGL0pCRDdYdFY5OXdjRXllRnVWVTdu?=
 =?utf-8?B?OWFTU2g3MklwU3dFU3VPdlcvK1pvZ1kwS0Y1dkYzOTN6by94Qk5GSW45TmI5?=
 =?utf-8?B?R0dtemZtQTJyNDVQMHRFOGNMa3RzUW9qcFlIWWdRbzJBd2VvWGhJTFFIZWlL?=
 =?utf-8?B?VnE3SC8vU09Mck1UUWxVSkRVamdVak5PL3krSldaNDY5SlMvWGZvMkJJcnd4?=
 =?utf-8?B?My9rMW52c3Jub0JWR05VVFlTRko5TjM4cG5paUFCdjVTbUs1TDhBVTBoSVFo?=
 =?utf-8?B?R0FHWFBURmhWaGIzWDR5QytNdmdmMVlYZHA5YmVzVXFvUThTSlUrMGwzR1p5?=
 =?utf-8?B?UFVhVENzQTZoL0hYZklTY29Qb0UrU3hIMFBVZ0tGS2tETEdhcmZoMnJDdmIw?=
 =?utf-8?B?OU1IZkcvNjJXRmFramkxZjNJYjJtZTFyTi9QQVJSZCtwcXNKcGVPT1FUdXBs?=
 =?utf-8?B?NWNndFMxS0NaSGZyNzlkQ3lWUVVQeDYwVWVyVzBYRHpjSmdyb3ZzUHBhelBZ?=
 =?utf-8?B?S3JYRVBHN2VSMHI1ck1oWVpQTGhoakdURHBJc2FGM29mbXFBYXBidlF1SnNW?=
 =?utf-8?B?OFpaSUE2cVByQUJzaE00bXNFdTVmdUlMbUwvNGRCeU5QczJkYXYrZTJ5NEs1?=
 =?utf-8?B?NmRxaWg2Rk9Db0dsUCtYVUZEaTNnSUtFcEVMVE9VN0RrWDk3UGlKTHhYRGNE?=
 =?utf-8?B?cS94VGNlYkw5Zm1ZRGw0dHlLbmtabVJ2cXVkbThiQ2R3OHFYUXhZMGY0d200?=
 =?utf-8?B?ZmYyd1RuV2RQblNJZHF3cjZjVUdSV0M2Q3IwRjJFZnRseDBaQUNPeXprSUtU?=
 =?utf-8?B?OUlXZk9jUGpBc01HY0FJNEZ3RVhCQ3RPd21xaS80ejlpcnpLdUxlTDRVdEhv?=
 =?utf-8?B?YjhnOU8zM3Z0YXpyYTdvTWROSi9nUkFuQUg4TXZ0V1dvaGZCYVpDM2M3UVF4?=
 =?utf-8?B?Q1lDUkVFTVJmUTlsQk4rVkw4RXJ0S2ZMUDliNGY2Q3FQUGZUN2RmTk9XSzhk?=
 =?utf-8?B?Qis4WTV6Ry85RjkrYzl1TWRBQVNKUTk2WWR1VHlwR3ZPUERUbFVIUEFjSHBM?=
 =?utf-8?B?MVErTm1sSWpuWTZHQldHT2R1QlZYS2JDRjdMSVFzbHhlRnpOc0g2VnprQ3RJ?=
 =?utf-8?B?SVh6VFE1dnkweUluVWh6RnFXUm1iYXZuVFFhYzNNTERrL3U2SVRQV2EwSitM?=
 =?utf-8?B?VmlPYTB3UzZiM0d0WTJuMUluVE82RmV5OFloT3BlcmczY3o1UjRDTjV6Y2g2?=
 =?utf-8?B?RnZoRUhoOTN5aFlZY1BKZjdhR0dYWlpkYmFuNmdCZ3NYdDNINkFLN0tWRUtz?=
 =?utf-8?B?OVZOd0lteWVGUEl5Sk80QzdodWNndFlYelFLNDhTbDFsb2FubmVDSVIzbVJp?=
 =?utf-8?B?a0k1L08zVE5wQ1pHMHZSbm8wZTZFamVXSDQvdEIxMkpzU2xQR1BkR1NxR2sw?=
 =?utf-8?B?ZGh4N0lpOTlGK1d4L2orMVRiK2pNMGNkdnI5VzJNQTRBWWE4dmMyS2dlNk5H?=
 =?utf-8?B?ZG5kVVNKdEFoSkcvQlF5Wk1oUGRQaEg0ZVY3cGFndHpaU00wazBRYmROZXpv?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5485c9c6-4511-423e-ec90-08dbfb5b4c15
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 21:42:54.1620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLk4sX0kcERWNTKLGiIiVkG62ZSDFc05XLodS4uvVAd+cX8JWSrnu45BC5QxXJbTjHc02Bt3ajQP4xMxBY5/o18W/PsSV3lF/Bea/apXeVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8750
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 12/12/2023 12:02 PM, Tony Luck wrote:
> On Tue, Dec 12, 2023 at 09:54:38AM -0800, Reinette Chatre wrote:
>>
>> On 12/8/2023 2:09 PM, Peter Newman wrote:
>>> On Fri, Dec 8, 2023 at 1:57 PM Tony Luck <tony.luck@intel.com> wrote:
>>>>
>>>> On Fri, Dec 08, 2023 at 10:17:08AM -0800, Peter Newman wrote:
>>>>> Hi Tony,
>>>>>
>>>>> On Thu, Dec 7, 2023 at 11:56 AM Tony Luck <tony.luck@intel.com> wrote:
>>>>>> @@ -2715,7 +2723,25 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
>>>>>>         case Opt_mba_mbps:
>>>>>>                 if (!supports_mba_mbps())
>>>>>>                         return -EINVAL;
>>>>>> -               ctx->enable_mba_mbps = true;
>>>>>> +               if (is_mbm_local_enabled())
>>>>>> +                       ctx->enable_mba_mbps_local = true;
>>>>>> +               else
>>>>>> +                       return -EINVAL;
>>>>>> +               return 0;
>>>>>> +       case Opt_mba_mbps_event:
>>>>>> +               if (!supports_mba_mbps())
>>>>>> +                       return -EINVAL;
>>>>>> +               if (!strcmp("mbm_local_bytes", param->string)) {
>>>>>> +                       if (!is_mbm_local_enabled())
>>>>>> +                               return -EINVAL;
>>>>>> +                       ctx->enable_mba_mbps_local = true;
>>>>>> +               } else if (!strcmp("mbm_total_bytes", param->string)) {
>>>>>> +                       if (!is_mbm_total_enabled())
>>>>>> +                               return -EINVAL;
>>>>>> +                       ctx->enable_mba_mbps_total = true;
>>>>>> +               } else {
>>>>>> +                       return -EINVAL;
>>>>>
>>>>> It looks like if I pass
>>>>> "mba_MBps_event=mbm_total_bytes,mba_MBps_event=mbm_local_bytes" I can
>>>>> set both flags true.
>>>>
>>>> That's going to be confusing. I'll add code to stop the user from
>>>> passing both options.
>>>
>>> Also kind of confusing, after reading the second patch, I realized
>>> "mba_MBps_event=mbm_total_bytes,mba_MBps" also results in both being
>>> set. If you're able to fail the mount operation if both flags somehow
>>> get set, that would address this one too.
>>
>> Are two separate flags required? All existing options within struct rdt_fs_context
>> are of type bool but that does not imply that it is the required type for
>> all. 
> 
> Reinette,
> 
> Maybe a flag and a value?  The structure becomes:
> 
> struct rdt_fs_context {
> 	struct kernfs_fs_context	kfc;
> 	bool				enable_cdpl2;
> 	bool				enable_cdpl3;
> 	bool				enable_mba_mbps;
> 	enum resctrl_event_id		mba_mbps_event;
> 	bool				enable_debug;
> };

A flag and value would work. This brings the implementation close
to the resource properties. Something that is confusing to me with
this change is the inconsistent naming:

struct rdt_fs_context:
	bool			enable_mba_mbps
	enum resctrl event_id	mba_mbps_event

struct resctrl_membw:
	bool			mba_sc
	enum resctrl_event_id	mba_mbps_event


The intention with the above naming is not obvious to me. How are
these intended to be viewed?

One option could be to view these as separately representing user
space (struct rdt_fs_context) and kernel space (struct resctrl_membw).
If this is the case then the following naming may be more intuitive:

struct rdt_fs_context:
	bool			enable_mba_mbps
	enum resctrl event_id	mba_mbps_event

struct resctrl_membw:
	bool			mba_sc
	enum resctrl_event_id	mba_sc_event



> 
> Mount option parsing (including blocking user from setting the options
> multiple times):
> 
> 	case Opt_mba_mbps:
> 		if (!supports_mba_mbps() || ctx->enable_mba_mbps)
> 			return -EINVAL;

I am not familiar with the API but it seems that invalfc() is available
to communicate a more useful message to user space than the default one
shown in changelog of patch #2.

> 		if (is_mbm_local_enabled())
> 			ctx->mba_mbps_event = QOS_L3_MBM_LOCAL_EVENT_ID;
> 		else if (is_mbm_total_enabled())
> 			ctx->mba_mbps_event = QOS_L3_MBM_TOTAL_EVENT_ID;
> 		else
> 			return -EINVAL;
> 		ctx->enable_mba_mbps = true;
> 		return 0;
> 	case Opt_mba_mbps_event:
> 		if (!supports_mba_mbps() || ctx->enable_mba_mbps)
> 			return -EINVAL;
> 		if (!strcmp("mbm_local_bytes", param->string))
> 			ctx->mba_mbps_event = QOS_L3_MBM_LOCAL_EVENT_ID;
> 		else if (!strcmp("mbm_total_bytes", param->string))
> 			ctx->mba_mbps_event = QOS_L3_MBM_TOTAL_EVENT_ID;
> 		else
> 			return -EINVAL;
> 		ctx->enable_mba_mbps = true;
> 		return 0;
> 
> 
> and use of the options to enable the feature:
> 
> 	if (ctx->enable_mba_mbps) {
> 		r->membw.mba_mbps_event = ctx->mba_mbps_event;
> 		ret = set_mba_sc(true);
> 		if (ret)
> 			goto out_cdpl3;
> 	}

Since 0 will not be used for an unset/invalid value I expect mba_mbps_event
will not (cannot) be cleared by rdt_disable_ctx(). If this is the case I think
future changes can be supported by expanding the kerneldoc of struct resctrl_membw
to document that "@mba_mbps_event (or @mba_sc_event?) is invalid if @mba_sc
is false".

Reinette
