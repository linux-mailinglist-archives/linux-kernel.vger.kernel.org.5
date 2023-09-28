Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55BF7B2593
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjI1Sw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjI1Swy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:52:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F4919C;
        Thu, 28 Sep 2023 11:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695927172; x=1727463172;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8yagVzO9mDsHPNWQoQpOfGwirRRn/WbR4/Z9V9TtvPw=;
  b=Bacm+hqDsDaQIdV0nO5PdUiJNHGZ+VGd9RdW81+dZP1lu4UdMWljS6yk
   YKwPuZEKFB7v+73A4P5R6Ph97idlsumWUF4priwuN91xYjrCjbJxJvgiw
   Z6BIFJdbVDxKwOchLaWL+Lr8ozbXCtq9rur8NVbtcD1TbFAjNCljRbFE7
   x9/DhHL0+YHY5EMWQcEgGWHlPnb5M5EF07kl1kkgZeR7VImRV4+AsKmlX
   NbXY4e6B1F4aLb8kC+P18PPwmP212cGB0CTmCOJhvVphn70i9uSntweDf
   9dJ133dpm6KMfUhS3a2unBEeWsT2I+oOpi50n36HC+xL1N/7rFPWeyva7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="361519251"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="361519251"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 11:44:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="726346069"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="726346069"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 11:44:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 11:44:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 11:44:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 11:44:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmDPgUEioY14aadaHlyiNmWlqNyy/fV57X9xa6XnapNBY9vDc7Kqeuyf+f/vAL651o/olgOS5lZ0giOv5csJc8XmXIhbf2twLQ4+nTU/hvx/phpgtQ2cJOqnfUBeCmNlcAslm5p57hLIed1mUVb1FAKC+01j4pzzNlH794P8VbR+sai6D5SHx6hry97I9wseXxUeav+zFc8YaUkbYMH4WDnH/LO39ACN5AyEa+3jQrNYo1boMBbRRC4wRJZ/AHX1pAg609/XzNhDCNBWek+K5HX1CAygDHIrPKs5cEAhT7A1W1BZ8aE7oxPzZS6HyDTbsnSEDFc5CBTu6sW+Z0UDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iCdvcdr8ouU57mnay3vozdRVmU6Dx6zs4IGm3QCzSY=;
 b=hieS6oF/xhBGt6IDVKH5YuF8ke3QYRUG/BxTu6MQuRDNW38Uv15pJkmmc/XBbJXGHifoiRu8E4TNmwEejLaUrPHHNN/lRM2T+Fuudk1nKmUbs2Ldqgjtfl+2UP1UuOoVIbnS7w9k3QCqBvMyRCxtz2EvPcnKtG+Yafsj78hfahkyNUb9O14b5l7PHohaV6F524JIA81GV0QZf06EWajhyQCUPWt8VJYZ2X5FceNYJHT6U5COb22DB0i2Ja5tjvE4XK8S+CDk0bDXpzxQ2Hl2f5WZhy5E6hIaW3okfEvvS5GAob/KGuhJPO4Titxt+crKLPWHC+yWheu5yqk5ZBG5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB6816.namprd11.prod.outlook.com (2603:10b6:a03:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Thu, 28 Sep
 2023 18:44:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 18:44:36 +0000
Message-ID: <4b13536d-a8e4-e1c8-c75b-914246651eaa@intel.com>
Date:   Thu, 28 Sep 2023 11:44:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v5 4/8] x86/resctrl: Add node-scope to the options for
 feature scope
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
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-5-tony.luck@intel.com>
 <5d93f726-bd43-20ad-5057-1de575809cde@intel.com>
 <ZRW69o0tNo2s8m+H@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZRW69o0tNo2s8m+H@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0007.namprd21.prod.outlook.com
 (2603:10b6:302:1::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: c08ce969-56d3-4483-822a-08dbc052f6fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Mkjhajz08CD6vB4o1uiK8q+QSzWPuNsnwXSNzC8UhITqcaizCBDgYzFizINNbn9dU6i+I/lCysrDjyii3z8aV3VkcRJ216wend2+ZV1Qtu91F+FBg33hUTthEwbPue/l9V9ZbN1wfh53k2TOnXwM+jHmNeH6pPN6NPrOPwaXRvWetuniHcvAtAaeuO9+SNY8/dUfqI+a2SXbPvx3SjObEQMAS9LVq3RmAeMPsNNz2A1r67OXHs4y+zxjQ1k5p9Im873n+JFC8ID2MPXviy5g4LWS9+KLx67VrGWV7bnDiZxPu1s3I4UCpEQ6tfoOftTBaMbs7+xYI5QYMd2MXFQw1wBlb65/Tee0/X0QJRqbMMOI34iz526nuOQu1wVF1TIMCWBcxl7W1LA4xnJwIEJsQWaILj92mKDIKks8k7BdaOeM3dTdZc4BjHAvKihATdGDpvWQii+aUc+XDuYoyV1ZoxrakDSnrCzAUEveIP+ynB9DZF57+J1v681W4rK4Xm6BcgTkuCjcyAMEFsj9oLpU+68GeR8BzepR0Uj1VB07PtxteLFOahzJJenx5mLodO6nZ2icMBhcfLTbyfctptgyvmvwj0FOP2bAI0AzBQdlCb+R7KMaLB3gCM0MUcwLl9oi4FRz8xmVspnp8nvEqXkeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(37006003)(41300700001)(6636002)(54906003)(316002)(66556008)(66476007)(66946007)(8676002)(6862004)(8936002)(4326008)(31686004)(5660300002)(44832011)(7416002)(53546011)(4744005)(478600001)(6506007)(6486002)(26005)(6512007)(2616005)(83380400001)(82960400001)(38100700002)(31696002)(86362001)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1M0SFliTVBqM0Fla0hQaUsxNm5rMjlVM0Z6Z1hvV3dtL3dSZzZSWUNrTTlW?=
 =?utf-8?B?ek90TnRWTkZiQ3R5UnVXOXJpeFdON1pVWXludVpmL0hIS1hDWDhEZGlKSHVD?=
 =?utf-8?B?RlM0ZlQrRWhsQk1nTmhYR3dIbmFHNk1vUisyd1U4bHVZVTdJdmt5dmNQSGVy?=
 =?utf-8?B?OE82Q0hPVUN2SVJraE9yaTBhVnNIZkJMdFUzc2ZqT1EyNjlLSkNLejFhV08x?=
 =?utf-8?B?aWM4T1dpYkpENm1jeG5mVmtSdG55UTlvaFkveEp6T1ZCVWNlNExZdWZlaTEw?=
 =?utf-8?B?cHZDNHFIUnd0TkwvREcwSzBXamNaNG55bW1jU3NsVkhmMzNXL3lFTis3VVBG?=
 =?utf-8?B?ZGtWdjVVL2VuMDZRTmlPK01xaFZXYVBXYWJoY2VsaHdVS0VLdlZtVEVNd2pj?=
 =?utf-8?B?Z1NsWFhTTmE0RkxmbFd0N2J6RU51N2xhQ0J1WUc5Z1RsYXZ6dmtHMDVuQnZW?=
 =?utf-8?B?VDkveU5lZ0hlbDhFQS9vVGFHeUR3UTQzNERrOWYxRFhVL0V5OWdvZTNzWktq?=
 =?utf-8?B?Rnp3WUJObE9FYXJ5TzVidWs5U3VXUjM2MHd0YXFRZWJCdEt5NUtpeU9uZnZN?=
 =?utf-8?B?T0ZFa2ZYMWlqekoxK1VWaktRditWL2luR3Awam9CUWZyb3l6L2NFTDgzMUh2?=
 =?utf-8?B?MnVnamplL0tiaklJVW42cjhxSmVKV3BVL3NUQkY3MTVWbi9uTUhFTTZkdGpq?=
 =?utf-8?B?dHJCeTFEZzRkUFVDcDNJNnBzcHFKUlZyRnM2ZUQveXFDcG5paGpPOEVzNXVp?=
 =?utf-8?B?SjdhdDVZMU80YWpnZXQ4TGtXcUQ2VFArQ2JFeXh5QjAvZ09Lb0EvOGIzM3cy?=
 =?utf-8?B?aU54MkI4TkZQOEJhV1ZBUzRFSkhPTlNOU21McGJOQmE2U0M4WHJaNHh0ZVA0?=
 =?utf-8?B?K1VabUxjMmdnS2EwYTZRa2RLTWN4WlhxMWZEZVlPenh6MG01Z3lZU0lqWW1v?=
 =?utf-8?B?dGcyT2lxcFF3T0ZzS1NNVnVMRlovREJqUHdlcVpad1BCL1JSUG9LZGVpNWdn?=
 =?utf-8?B?L1V2SEx0QzlOOXRhSDIwb1h4cnZRdzBEbDNpUHlXMkp1MHV3a3p4NzZBQ2RM?=
 =?utf-8?B?c3ZlaFZNZDBlOHJyQnIyZFNadHlkM28yUmtJWVZCRTBSdmRKT0tTQWlpTVRl?=
 =?utf-8?B?S2hhdG1MOG84dmpzN0ZQdmF2dm9iV001RE14cFdmVERPdTAxYXA1VmdtNGlN?=
 =?utf-8?B?eXA1V2FZd0pncWtjd2JpNlp2MDgvR0toZmNrMEQ5ckFxUWp0MTEzcEluSzZw?=
 =?utf-8?B?WVZVbnY0TFdveXNjOEt2THp0T2htQWE0Mnd0dHRNaFJ5U1QveldRVHFpMGNV?=
 =?utf-8?B?MmdJZVBqMFUwblpLTWJUaGNvZWhHK2d2a0pmUDZ4aW5aWTF1d0tma0Z4OVpR?=
 =?utf-8?B?OWhreE12VmVBOGp0Y3NNcHdCcEdlZHA0Z2JlUGVRNTZoV1lRUkYzTzE2UUl4?=
 =?utf-8?B?TWJOS1hjVGVTYTZub0taMkg0WnMrWGwwY0JOVFdzR3FNd3V6UHE0blRML2Fk?=
 =?utf-8?B?SXpxQzBRQzlJM3Z0K2Y0WWZKVURnSkpQeHpaRitvbVdaZWhkUGhyeUFGaU9a?=
 =?utf-8?B?VkpXdmJpUnNUNFZNVXJobXVZTDJsdnQzbFhjWk0vaWZJU1VaMklGb1RSN1g1?=
 =?utf-8?B?ZVJwMzNkMC9LTUZMQXN2WFY2YVJ5QTFieUszcVpCUGNwblduN2RYUWtQVnpC?=
 =?utf-8?B?Rkt5VEZqVmJnQUluYTBFc29meWd6Nm1tNXhicDJBMXpKZmhJYU1Iam5wRUZa?=
 =?utf-8?B?RjgzWVpYMTB6RGVNeXNWanhSTFhnWkxMZUhuSXVIQjVMZEZYdkZXQjloZEh0?=
 =?utf-8?B?MDVlVkFROUJpMVhiS0Fid3l3OUJzSzBkNDQ4Sjg2TTAwZG9aNXdNbEk1SFRM?=
 =?utf-8?B?OVYzTXY1V1hMUXBVemp3VWhvWWExeE0wK2ZMQVhjeDNVUHUwOVVqdWZaWXZ0?=
 =?utf-8?B?ZUVCTmpxeWphMzZrSUZsQ21WZEtMWWgxS2lLenJiL0czMmFXZmd6Q09PbUl0?=
 =?utf-8?B?aE4xeXZzTUkvTVNFaklZbTZKbU1QQWpXWFd0U2tkUmxTZUFLNjdva0tHd1k2?=
 =?utf-8?B?OU9OUU9IdzVpdXA0RGhxYTdWaVROK2NnR1MvZzJVSXFMd3RsNmdHYis4eUt2?=
 =?utf-8?B?QnNGYkxnVFBYUm4rdkQ1bXhkWksyN2l2VTkrYmNmRERTT2dEQmZrWkpEMEZY?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c08ce969-56d3-4483-822a-08dbc052f6fd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 18:44:36.7992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ht/sPx29IPI8XpCF05RQoq9cTA1ByaJTCDtLdOBMPv7BmtXG6tgNL62U+EKt3dJQHegcv6xaqfG0KTe4k5xDCnZa7du4/2nnxkbw088Uf2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6816
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 9/28/2023 10:42 AM, Tony Luck wrote:
> On Mon, Sep 25, 2023 at 04:25:54PM -0700, Reinette Chatre wrote:
>> Hi Tony,
>>
>> On 8/29/2023 4:44 PM, Tony Luck wrote:
>>> Currently supported resctrl features are all domain scoped the same as the
>>> scope of the L2 or L3 caches.
>>
>> fyi ... this patch series seems to use the terms "resctrl feature"
>> and "resctrl resource" interchangeably and it is not always clear
>> if the terms mean something different.
> 
> I think a "resctrl feature" is a h/w control or monitor feature. A
> "resctrl resource" is "struct rdt_resource" (which may have more than
> one "resctrl feature" attached to it. E.g. the RDT_RESOURCE_L3 resource
> has L3 CAT, MBM, CQM attached).

Please keep in mind that in resctrl documentation
(Documentation/arch/x86/resctrl.rst) L3_MON is described as 
a resource. The main message is just to ensure that it is clear
what is meant with particular terms and then be consistent in
their use.

Reinette
