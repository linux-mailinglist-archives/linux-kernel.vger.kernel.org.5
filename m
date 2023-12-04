Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7283E80416A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbjLDWPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjLDWPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:15:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84A8127;
        Mon,  4 Dec 2023 14:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701728112; x=1733264112;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mhgjxJ8FuXfaYPnnaCNm7V6cRyRvFTEUgEkn6E8rn1E=;
  b=fMadR8qmEWJTKmScSMGygLNpHpEh0fXDAyxsUc1Oz8fg7st6PFO1vgrD
   CPj096lWgQxDowVt6pXcMXxMHo7xC4JszWqskKjCvl5fny3UUvbJ6vAv0
   5auCo61V21EX3Rk+fjmtU3StOvGFX09BwsHAKV0x2IiqJHVYuXYyIv8hC
   H1fyGaI22OSHEIKH3JaL9XSuJNf2XWlPghYvrZziMfS+UGry6aFoX2WXH
   DaFtVAbQbR6qQMHuZaPtV25t1FYkcSgyxD3dKJNr9JEIO9jatAnkOuejv
   2G+q7aJSa6OKsgEWmGeQa6UZ4BmHCO5yagaz1xqOLOCDCESn8qgDB2nWX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="390959863"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="390959863"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 14:15:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="894143198"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="894143198"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 14:15:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 14:15:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 4 Dec 2023 14:15:11 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 14:15:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksk8fcl2nhiC7ygWULzEYS3ZlmCND2K8I9Db0NzSKxPlPMeK+azypXlt24f0LJ9Lmoa6WB1UmjZV4oN5HNw3bZlugk9BmwABDQWjLikR2ASvXH5rBHZrTBNt4vs5r1vTYpBj/FIVacO4Nju1FdwMbTSdkq5w2Pa1ci/FTlQny3V68sxpO/vRbTkJoYvp3g8q0Y90HOsTXibJx+Sbz/Ix4sbZ2Hi7YEr60B4D9wV8txWgrwUcMX5BxIbnOs/LIN1ko+9peD6JbZEn3J4Y21LwR5TiXyw0I/aDMH+1ojOdg6MnmfbGdghhBaEtst+qTn49w3dly6bo2i/m7QlO1D6SRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/94kpmG4N8sUPaUW9nr4KYtIZAzpc+t9ATTqCm//Sn8=;
 b=nMl4QqmOfptvstgxWK49i80ybp+D+6n30Q4xkqZPEuifr9ihv9gWbbHqROxknpSATREP7gvgjoo7u4ieQnfRZFMEu9a95a2++Brim7IU1dthKRzy7bAnLhhdARe1oilj71gTicMfLON+L4gPwr2nHrARfR7LWSB8u4sYIQT76kraKHWKu/osX1vqRoiESXIZpLMpYqfl1SEAwMAcgxXX1p6CWkCMPJoWA4fre5NTuX3gTIVwGBq4JlKpiRobKZS09LtVQDLSpWAEzwoXvBMXIgncryzFAZ5nXCsChGuPTUGPQHtV83/GxYwb7rwBFs02mSfFCu1iR/wHK5QnB8mXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7432.namprd11.prod.outlook.com (2603:10b6:510:272::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 22:15:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 22:15:08 +0000
Message-ID: <0c2beb97-437c-4315-9aff-14c650297565@intel.com>
Date:   Mon, 4 Dec 2023 14:15:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] x86/resctrl: Add event choices for mba_MBps
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     "babu.moger@amd.com" <babu.moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20231128231439.81691-1-tony.luck@intel.com>
 <20231201214737.104444-1-tony.luck@intel.com>
 <fd8a44a1-9001-4e3e-a1a9-63e7f737e6e1@amd.com>
 <ZW4XjqxfYBFZId6H@agluck-desk3>
 <660935b2-93bf-4ca0-836a-7aba46009c5c@amd.com>
 <SJ1PR11MB60839F92B1C15A659CD32478FC86A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0285bbec-7152-4f54-94a3-45ce265a3ebe@intel.com>
 <ZW4/sE4Af0p3jl07@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZW4/sE4Af0p3jl07@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0356.namprd04.prod.outlook.com
 (2603:10b6:303:8a::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 17625f7c-6934-43ef-d6a2-08dbf51679da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: heIhlQBFotg45z/s6kexgDe/yIvKrJ1x1n3GfI9Q3DfJ1lEj7FBkIZ2NKJr126nAn9/QJhZDDwZNk1UYaUH0vGtHyuR/8Y4j9eIVXp2AIoxUi6tTkf6XQAdt/bUvKCxtZyXo1oVvgxS8wasWGSslyqlioj4kdAKiJTcFQVRFNmRi5ieUJB4zLWbX5iDHMfx55uzAGYCoFf4cmbcV19KlHq1GflIjiNNDWVAwZZTuXMR4hynXFQWrrk9DtI5WK2IuWyUWsBf3E6Ig4w8xgNdz8tsqFkHI9CsXkxk8JAkudpJBUsKTZ0i7TKDAmvgHpvEnlWKNPESbJBySIYGHGk9af6p/3kiC4+0vdiaw0F8+znB3oW+/0CDUg67lJqy8Dz+r+2ofdxlY9oUdcPsKPq2LAqyYKUQnF9Wxxk3Cmz8/MjJ0qC3FzFg6i43l6Xp4gx3sRcswaY/sgqBoZMsxnpzKB+c7Ci+3IJcuuvrE1Dix34lCc5hEUhPWj9qd/ovuAgxppB2QKk2eor3VDQmubVgvrrcntJlvaFu07u3DHE0IsKtJLZWQR2FKICo8dyBFtsT2FN4+GC+AchkUBIoqAfxonIyykNW/eTRYkKzkQuwdCatxtyOvNzwnHFigt9UFRnlbp1oR7/lh6kOFrAQfpZK7aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(36756003)(41300700001)(31696002)(86362001)(44832011)(5660300002)(7416002)(2906002)(2616005)(26005)(53546011)(6512007)(82960400001)(83380400001)(45080400002)(6506007)(6486002)(478600001)(966005)(38100700002)(31686004)(4326008)(316002)(6862004)(8936002)(37006003)(6636002)(8676002)(54906003)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnJpMnFReGZIZk9KWFBxNERxZEhvKzRHMTV0dEpSTGlqWndaTTJGY1BJRjNY?=
 =?utf-8?B?Z2Qrd2c3WUM4MTdhZE9EUjZ2UHZxS0gwMC9kWUp1bTBXTFp3MWExSDVjaWNl?=
 =?utf-8?B?NVFTR0Y1R2ZZY0I1d3cxL2VCZG1BMUM5QkMwSzc3MUxLbnNSQW54NGJoNDgz?=
 =?utf-8?B?UlUrL3owSWVxaFRIRUE2VkVLbnU4S1JOUUpDOUoxMHEwUmZ3UXc0YklQUGFk?=
 =?utf-8?B?WWZpQWJmd0dzWGtFQncrdUtCU2R3SUhTUDU0ZGxZZUlQZjJGdWJzWG5NSzZK?=
 =?utf-8?B?UUhLZnRmblViSjZnVFkxMndHM2kzczFYM3ovaFJJUnBPcGJCeVlkU1lUQnB5?=
 =?utf-8?B?bzRqZVExRDE0WUlmSG5KNFVrZ2x1TnB0UUs3NCtPUDZhalFyd24wSU5NbXhF?=
 =?utf-8?B?Z2ZycDVnbE11ZDVKaUllbHNoUGw1U1VnZnY4RU04dUN6UmRlRjFoWmlDUkRH?=
 =?utf-8?B?VEJ5TXVUYzRzZE0zZ0V4aU90YktsZXBwRTBQNFkxQkZzMjdiSjBES3Bpckpp?=
 =?utf-8?B?YklrdlhJTUgwRXRKMU9nN1R6a2V2WExqcHgyRzFQTmt6eVZCUWRyY0xIdkJ3?=
 =?utf-8?B?M2JLR0FSVUNkSG9yWDQrUWVKUml1NUdWOHBCV0hNRm80cWpwOUpxVjE4Z25I?=
 =?utf-8?B?QXViQnZXRXRkdGVIQlEvbFEvR3FJTzg5OWtOcFp5SlBKc0JTT1p0ZWd4K3Fx?=
 =?utf-8?B?LyszV2FCTTZMOFd2eHN5dlJ0Y1czem1Db1d3WEFwSmdOd1IwOXlDanRjN00r?=
 =?utf-8?B?NWZIcWl2bktzVmJMMUo3Q0toVytQRVlCcFNyN2xjamdDMVNId2JsLzRXa0hi?=
 =?utf-8?B?MkZ6MDRzeWxLak4wb29qdGFtT1BBeXVBUi9zUmx5ZkN5b01vTlUvNjBEU2Za?=
 =?utf-8?B?bkdaSGNic2JVbk11VUpKdGxjdG9mbE5idXFwMEdzQTJBc2ZOWktFYkZ4Wktk?=
 =?utf-8?B?N0Q3aXFaL0dBWDlMMEJCRFJORHlvYTdQS2FjaVFwQkdqd21JbkdwODRBbG9I?=
 =?utf-8?B?MHpDd0x3b0NEektBK2hkemFadjFqZjVsTlRxY2NQV0ZTaXFQQjhJdnMyWUs1?=
 =?utf-8?B?a0YzdFNDVmdlOFBvd05hV3JaV0s0YllEZGdCQ1FlV1FCZ2pZUWc3dG1aWG96?=
 =?utf-8?B?c25RcXA1VEhzdlVaQnR5WlNUWm14VU9pQWZibTFVT2F4QU9hRnowVDJpdDY0?=
 =?utf-8?B?SExKWDRrblFBMVdyTzJ0UHl3bUpaQW1CVjZvaWZNMTdlSHhaRGE1L2hPaElh?=
 =?utf-8?B?czFCakNTbUJvM2xZZnRzTVJ5QzN5YzVjV0IxQTB3akhsRGtDYmdUTXNEaEp2?=
 =?utf-8?B?d0taUW5hV0FkZkhtUTg1THBnWlNoR3FRRU5hbGhkRUhFZ2R4dThid29GVyt1?=
 =?utf-8?B?OERyeUdnK1crTHFWVyt3RzJZUDc4QjNhOEhnWDBtN3VPeVR2VzJ3UkxTbk9a?=
 =?utf-8?B?OFJRcHplSGM3MzNJQXJGV1ROdFdCNDh5a0tsVkp3dXpCTEtnQmt3YzNzR1pq?=
 =?utf-8?B?TnpydTBXazBXeHdDTmNDWmwzMDNqNmtCWFpMTUpVZFBQaGRVSVNKVHVoVFZB?=
 =?utf-8?B?SStIMlN1TjJaVThGaDdNaFI4MXNGOFIyZ2t3NnpJU0NNTXdBaDJsSG95U0I5?=
 =?utf-8?B?M29MZW1yRWxzelJzTEViL2JxanZpWkJPRmNSU3ROVThUcWROQzdXTjYrSEdl?=
 =?utf-8?B?dWZWU2ROTUZyQWhXRVhsVUVCUzdUZVBLenBweDlkWm1JV1pQdXU2UVZSSGtC?=
 =?utf-8?B?YzVDa3J4MmIrVmRkWXdXclRJS0NlV0JlUnVXRmpGS05Nc0pzZEFDUU9ZeG41?=
 =?utf-8?B?TWg5akt4aDVSN21TRk1UcXcyVVlDVjk2Q2F3QVNWL0ZlVERMTlI2QndXUEdQ?=
 =?utf-8?B?T0g0aUpmaHpZOFFmYkpLcXpCMmxSRmw5am9waEw3aXFIQVYyWVgvUjE0V09X?=
 =?utf-8?B?VGVkU2NGVnM1a1F1aGtzZUkrblJhdlJjZ2hldURiRlBxRm5RNzZzMVRxQm1O?=
 =?utf-8?B?TFFHYzYzNW9yOFBiVnk4REJrRUZlaVZkRjk3UVlraXQvMGxwMFNjQlFUeG1X?=
 =?utf-8?B?eDlrVE93NW9zc2ViUmdlWDRPb2t4RHN4LzBmRitIRGZEZVBSK1VVREN5VWdT?=
 =?utf-8?B?QXB3MGJIS3J0SERIN1QxWUZIQkVVSW9yTnE2R0Y3aWk2MVFJQkFEYjJVSVJS?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17625f7c-6934-43ef-d6a2-08dbf51679da
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 22:15:08.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSu5bKWrNSraV2/YBdVYkULm0JiYxxEEmCMxoTwE56L3op8bS7cr2skNyR/yd9CtLS0Vtlrr9PWE4mIUS77eBsPURgGzvNnmRfX1Zd8jcsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7432
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 12/4/2023 1:08 PM, Tony Luck wrote:
> On Mon, Dec 04, 2023 at 12:03:23PM -0800, Reinette Chatre wrote:
>> Hi Tony,
>>
>> On 12/4/2023 11:45 AM, Luck, Tony wrote:
>>>> Yes. I saw the thread. Even then I feel having two similar options can
>>>> cause confusion. I feel it is enough just to solve the original problem.
>>>> Giving more options to a corner cases is a overkill in my opinion.
>>>
>>> The "original" problem was systems without "local" bandwidth event. I
>>> wanted to give a way for users of mba_MBps to still have some way to
>>> use it (assuming that "total" bandwidth event was present).
>>>
>>> Reinette suggested that some people might want to use "total", even
>>> on systems that support "local". I firmly agree with that.  It is easy to
>>> construct scenarios where most bandwidth is to a remote node. using
>>> "local" event will do nothing to throttle in these case. I'm not at all sure
>>> why "local" event was picked. There's nothing in the LKML threads to
>>> give clues.
>>>
>>> I proposed a mount option "total" as a modifier to be used in conjunction
>>> with "mba_MBps". Reinette said it was too generic. Her suggestion was
>>> to add "mba_MBps_total" to be used instead of "mba_MBps".
>>
>> No, it cannot be used instead of "mba_MBps". My intention was for it to be
>> in addition to existing "mba_MBps" since taking "mba_MBps" away would be
>> considered breaking user space ABI.
> 
> I was unclear. The mba_MBps option must remain as legacy ABI. My
> "instead of" was intended to convey that a user wanting total bandwidth
> would use:
> 
> # mount -t resctrl -o mba_MBps_total resctrl /sys/fs/resctrl
> 
> rather than the new option being a modifier and requiring both
> the legacy option and the modifier like this:
> 
> # mount -t resctrl -o mba_MBps,mba_MBps_total resctrl /sys/fs/resctrl
> 
> which seems overly verbose.
> 

I misunderstood your comment. Thank you for clarifying.

>>
>> Even so ...
>>
>>>
>>> Is that where I should have gone, instead of "mba_MBps={local|total}"?
>>
>> While I did propose "mba_MBps_total" (in addition to "mba_MBps") I do
>> recognize your comment that a new key of mba_MBps_event does give more
>> flexibility if different events become available in future. Emphasis is
>> on "different" since I do not believe the parsing can support multiple
>> events and thus mba_MBps_event cannot be treated as a general bucket for all
>> mba_sc options, just different events guiding the feedback loop.
>>
>> "mba_MBps" must be kept and having it continue to use local bw as default,
>> but total bw on systems that do not support local bw seems appropriate,
>> (which is what this patch does).
> 
> So we defintely have:
> 
> "mba_MBps" - defaults to local, on systems without local may switch to
> total if that is available. Should this switch get a pr_info()? Or just happen
> silently (as I've done in patches so far).

I do not think a message is required ... I cannot see how it provides information
that user space does not already know. It surely does no harm and I would not
object if it is added. Even so, I do not think a kernel message should be what
is relied on to share with user space what guides the feedback loop. To that end
I think the mount options combined with the system capabilities (learned via
resctrl) provide that information.

Please do note that if the solution of this version is maintained then
rdtgroup_show_options() needs to be updated. With that done, user space should
be able to determine at any time during runtime (no matter if kernel log has been
cleared) which event is being used.

> and need to come to agreement on which of these to implement:
> 
> A) "mba_MBps_total" - forces use of total. Fails the mount if total is not
>    available.

The "cons" of this is that (a) user is not able to prevent the failover,
and (b) harder to support future events (which are unknown and difficult
to prepare for anyway).

> 
> B) "mba_MBps={local|total)" forces use of chosen event, fails if event
> is unavailable.

I assume you mean "mba_MBps_event={local|total}". This is my preference but
I would like to learn more about Babu's "overkill" argument. I do believe that
(B) is well motivated in [1] and has no impact on AMD.
My uncertainty here (considering one motivation is to future proof it against
adding more events) is the generic "local" and "total" names. Even so, all
I could come up with are "local_bw" and "total_bw", which I do not think are
improvements.

> 
> C) Something else.
> 
> D) Don't provide any way to force use of total event.

(D) is what would be needed at minimum. 

In support of Babu's comment I can see how having mba_MBps as well as
mba_MBps_event can cause confusion. To help with this the documentation could
be expanded with more detailed content and also examples.

Reinette

[1] https://lore.kernel.org/lkml/SJ1PR11MB60839F92B1C15A659CD32478FC86A@SJ1PR11MB6083.namprd11.prod.outlook.com/
