Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF987AEF7F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjIZPTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIZPTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:19:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C607511F;
        Tue, 26 Sep 2023 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695741569; x=1727277569;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bjYLSlw5f6qnoHtz6hUb90Df7Hb+k01zibBdxwtwo88=;
  b=EfN+kPpp1l62BTlUpyEmzBylnc6dPpIMosDXE+8VYXRK2gyZrOURYJ1u
   h3PTWTgJo32Ru6KOiy8AJcU/TnFH1rwpFPRP5JOudCaYbIvf3unHyCIxd
   pTU3ZEKt6fZtOzGQKhuWpEbBwSstXZ1VD01/nG2j68YQRWN/OziJ8InBg
   yUxbbW1TAUvwuuqOGk04Iov1Gj0eAhYvgX83XNO31pzvRgVy3EqNdMlbh
   SAtk8ubiBNFT57Qg4uMmVHmbqQ6c22hlGIG8FVehxFYfg32JdtCgarS5x
   TDWKzgcn023glvrIBSvLFCuw+DnMHunu3+lvD4BTQyqRIqA80vhKOT92G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="384371666"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="384371666"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:19:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="995840951"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="995840951"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 08:19:28 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 08:19:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 08:19:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 08:19:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQdtt0AcTQRMYz5Ivc0mkzaiLLaFyruLgUIZQIx7ahkZ+H2X+hMNNkuEIDvHr7GO8OEz8LY+DfenobATuGMEEtDkKCgo1AerN1j8TkppC8/W/H/opPPXji+UZF2UpciwAHf/lbPvuU4iM8fSbfIUa/fc/fhbmUMqiIAsHQ+y4O/BRWZuiFxfQu4X2im9Uehsrza6QhvNh4uNdJX6oQq9gDKWgAP0yMm5stwgbUGweNTbhNWxPQTttFH4c8YCFeB2ewiKsCe5cfmXSDFdbEvXJW+3Yzn7xwTDAIMXlk0386F7vVDR7Yn6WKVzR3fU3g/1tR8iuoNPSOKoQ2OArc/8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVruliQpaGvsBto6TuotjsHy9V8DMdzHekoUtCixdyY=;
 b=VPbZJZ10HQF9XlwfR0Du5utij2CuXMOgHQKbsRd4nLAbcT5GwbRvZarBlOdiQZQuXpA/t86RJ322J3LlDhPav8Qdr2K18GrWh73PAraDgZIU6IMIjDpjP0Ep3ysu7w03xWQANRtDi1fnnXw+Tk8L6sm8ZQ6zaTB5xSvCVS3cEkgd1WNHeAd9cHrMehMaH62lzRbql9wK3ko3giOt+9k3x9tk4u1LyGNop7LJrTpQMel84erMzREtq65JQlrj+DR598D2NIPe+DStrQke8eFlTA8h9HE3VK9JygfG0qktKhdP0NYIkX5cybGZrpDEy9n+n4h92UftXZnA/oEWC9c+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8766.namprd11.prod.outlook.com (2603:10b6:408:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 15:19:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 15:19:23 +0000
Message-ID: <3ae70dc7-8a87-e63d-95e1-bb61a649e134@intel.com>
Date:   Tue, 26 Sep 2023 08:19:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v5 1/8] x86/resctrl: Prepare for new domain scope
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
 <20230829234426.64421-2-tony.luck@intel.com>
 <25dae76d-9e8e-9381-066f-7eaeadb85dc7@intel.com>
 <ZRIsWmIiL8O57c9w@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZRIsWmIiL8O57c9w@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWH0EPF00056D1B.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: d488589b-cab1-406c-7752-08dbbea3f6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymSRLQv2nmKuXnSAvLtmCxCnKI/3U6LZ43p0CPLW4+b0XEFgwchOiv7v+nnSE2Y70xpFIoh+1zNLpLLgh288axy7z6J8KRKwaNKiwkqw4BWKpBnxtE5DMmkH2RCh4i2iEFjajjqce0SX7eeqceGw/OIIUXIdOqli/g+NxYgazuivX4VjfDofA7YFXsT6vjp0e1RdXkMNxAGcvPufMiT5BGyIplnQS4o+cagVJuUw5giqkI/bOcLLxGhGZvlgRe5JF7UKANQDa4uRZYe2nL7fC79a8EZalO0zbXKbltMU3azkkJvAIoA+JQ+L7SCDKVDFW5eUA0T4v+kLh+7/S1541LEVG2cxW33hw3g3z+p8drvvNbmNcr+RalcKBh2eeQs/JdcrQfmSdRml+AtM49fq4NjQDMaj/EwJX2xWzbvhibphMIe4jehVplGgCKW24VPt3495cc95FUvzd4gJVs/A28Lw8eSI44KgRMg/Uu7uzkhYUqW6dxlvsk+I5vsIWuEHV8DHB6kY+UmKfhzi9QP3YaIiT91b8L+XP+MW3M04VTEGpaBoaJeUfVL3XtjhGT/6dbxLUp5WU+eTqoHcdr4HB5aBBRWS8lQ48nDfToOpBHw5Fn4ibnpfg4sCFD/FYhH3QtJShWwDfb9KTC5fKE+YzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(346002)(366004)(230922051799003)(1800799009)(451199024)(186009)(66899024)(38100700002)(36756003)(82960400001)(86362001)(31696002)(2906002)(66556008)(478600001)(54906003)(66476007)(4326008)(6486002)(37006003)(2616005)(8936002)(53546011)(8676002)(44832011)(6506007)(6512007)(31686004)(7416002)(316002)(66946007)(6636002)(5660300002)(6862004)(41300700001)(83380400001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3VkV1ZrTUMyb1ovNXU0RXhoYjBIVlZyZlcvQ3I4WElUSHhjdkNObmxISllw?=
 =?utf-8?B?TWdpRGNKdDZpRjhISit2TitBTmZkUmR2RmZVTklOSG9HSm9JcnFxbzBnWlRp?=
 =?utf-8?B?RC9IVXVUTU50YzNENTdVSkszd2lIZzBpQklKVXNLZHJ6QkR3OTNpbTlaTCti?=
 =?utf-8?B?OHJTa2Q4VkdibGg0dGwzNHJEZWQzRFY2TEdXMDFpSlVSTGhsQ1pMOEhBOGJJ?=
 =?utf-8?B?cklub3dldTg1bHlqamd0L3RkcC9oQmhoM1F1K3pHK3o3YktXcVliWG5naHpm?=
 =?utf-8?B?T0M0bFNNK1VQTjZtM1pqTC9VRXFEU3E5eVFIQ0FydGtpTUlOeEJHU2dZWVBN?=
 =?utf-8?B?Z3d5YkllK1BWNmlvdS9BcEZpZWhrSWgxZXpwQWwyajErdGtsZFZmNTdoNktY?=
 =?utf-8?B?Z2I4dzhiaHFOVDd3S2YybVNobnF1aUJraEZjK3hTVC9vNDlxWkhvRUNLc2xT?=
 =?utf-8?B?TXd2NHVwUlFwSDZXYWZGa1B4ZEg0MXNVaCtWa0xQZHB6aDJSeCtXQ3Z1R2c5?=
 =?utf-8?B?R0ovMjRwQU8rMWVwUnczVkR1eU9IVldyc2c2d2I2c3lmZCtzMk9LN2lrN1pm?=
 =?utf-8?B?VTY3Z3NDYXNkbTB4R1ZaUExPNFZsMmFJOWt1T3RKS3JmRWpCeUNYZ29HcThT?=
 =?utf-8?B?ZmZNeUVqNVcxZ050YWJlOGlSSEJWd1ZUZGpBUFIyVW1JbUkrdE5MeGVKemNG?=
 =?utf-8?B?Qk5CcE5kTXovRHRCWDJOSk12TGw2TUdwNmp4YWM5VUNzazFUbmlmeHNZR285?=
 =?utf-8?B?QW1NMG1tQUlFMjZPQzllcENWak1ob2VYVUJsVHJjSmhwNkN4bW9PVldubFZH?=
 =?utf-8?B?NXhlTjAvdHk5d0UvcUcwUkQxT1d4enJQV2lOWVpwMTVTWTV3dzlvdVFEK1RW?=
 =?utf-8?B?ZjhBdlB6M0d5aWt4UDBydnNpY3ZIbURKTmo1WFlwYkIxTFVOV0pJQkJuZnc1?=
 =?utf-8?B?RWIxaHVSSG9SN3p3MnVFMTB4cy9BVzhwOUF1bVh2TzZ2aTduU3RsZ09VTURB?=
 =?utf-8?B?eW9ISXJTUjVKRnV0VFZuVy8xSWIrTXh1RWRUYVZROGdqTUE3K0c1WGdRQm85?=
 =?utf-8?B?TG9QUEE4amFVSFh2Z0x3SStyaDF2QkhoRFB3elYySVpaK0w1TGNBMmpFcTMz?=
 =?utf-8?B?Zm5VRE1RSC9LbG5MQSt6ZU5OSGQvbjZDWVlYaStvY3dpM3JCT2g5MW5mV2VF?=
 =?utf-8?B?TmVIcm5IQTJuUnJDc2N3RFhvQzdKUUw4ZjhRb3VqMzBYSm5kc2ZYeEdnTlNq?=
 =?utf-8?B?aGN1Zk9helBJeHdocENUb1RLd0FWY3JwcVhRdkpoOUIvU2ppVGlkRkh6UWpq?=
 =?utf-8?B?dEtYU0xPUUttK2kvV2JHYkxOMG5EcUlrUmlUZ1d2dTVLQUFQRWR1OGVRUTRH?=
 =?utf-8?B?aFVIZ1Y0RXFCRGI5WGtvSWx4dnZ2SmZsT1czMS9aR2JvV1d0bmw2bkpHR0xZ?=
 =?utf-8?B?QkwrMVkwdzBpWlBEcVhJTHpCZkM5YWVienpTTHB3S0E1MlpVd25ESkpmemp6?=
 =?utf-8?B?d1FsTzJKOFFER2RRQmZqOUh4SGRtMmlmT0M0YXA2ci9FVVBUd2pycVlqQ0RO?=
 =?utf-8?B?RWxjSGFMUXliT2hBL3piQk1Bd1FBZVhwZGZGam1qbk9ENFBPU3lZRkdYeXNV?=
 =?utf-8?B?T3QvT21jMUVNb2NkR3N6QlZGcGNXRXpvVEMrc0R3ODVyelZHODB6Wk9LZ3dX?=
 =?utf-8?B?bzRKc2dBWUJFanA4S21HL3pjb24xSkQ5NlJQUktISG1uZC9mVE10djFLUFpC?=
 =?utf-8?B?QVIwdlZRMlJCRzF6UG5sVC9oMHEvZm15dUp2VGlTV2hVbEdMR0RvaXBERnFm?=
 =?utf-8?B?YzI2cnRWWHhRSWM5ZlM3eDBxTGZDdTRlNmhCdjhibkRkMGFvNzVzY014MTJW?=
 =?utf-8?B?dmhSYkJCbkFDT2ZZeWw5cG00a25ObFZiME1yUkVSMk8vWWlLaDY1K3FGQytC?=
 =?utf-8?B?S3ZlRXpkMGswajRQbGlPV0d4K1ZHTFk5cGsyY3BXQVpmNUlTR3RHeE8wL3RS?=
 =?utf-8?B?U21qOGwrTlRmRTcrM2xOeVpxYlM4c25PdS9tbnRwVVM2RndpakIwVzFDTVhH?=
 =?utf-8?B?STU2YnBGR3hLd1ZyRkxoMDIxOXg2bzdCcEJ5Ri9zeVNEcTNVZkExcEloSExB?=
 =?utf-8?B?Qlk2QytWVHFaSGVWaHdRUUZycDFlbGovcGtPNllVdHpXMUQxYStVMldOMXZE?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d488589b-cab1-406c-7752-08dbbea3f6cc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 15:19:23.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvFmZRmZoEkusnYfwLRRKS8cvh4I6IAJpNEEw6DFLgWvPaY9LjsbqnG+sn6BwiUNq4HY0YgU0feQo8+rclt9h3ou6A1UdCUQueRCWNiAgFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8766
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 9/25/2023 5:56 PM, Tony Luck wrote:
> On Mon, Sep 25, 2023 at 04:22:29PM -0700, Reinette Chatre wrote:
>> On 8/29/2023 4:44 PM, Tony Luck wrote:

...

>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>> index 8334eeacfec5..2db1244ae642 100644
>>> --- a/include/linux/resctrl.h
>>> +++ b/include/linux/resctrl.h
>>> @@ -144,13 +144,18 @@ struct resctrl_membw {
>>>  struct rdt_parse_data;
>>>  struct resctrl_schema;
>>>  
>>> +enum resctrl_scope {
>>> +	RESCTRL_L3_CACHE,
>>> +	RESCTRL_L2_CACHE,
>>> +};
>>
>> I'm curious why L3 appears before L2? This is not a big deal but
>> I think the additional indirection that this introduces is
>> not necessary. As you had in an earlier version this could be
>> RESCTRL_L2_CACHE = 2 and then the value can just be used directly
>> (after ensuring it is used in a valid context).
> 
> I appear to have misundertood your earlier comments. I thought you
> didn't like my use of RESCTRL_L2_CACHE = 2, and RESCTRL_L3_CACHE = 3
> so that the could be passed directly to get_cpu_cacheinfo_id().
> 
> But I see now the issue was "after ensuring it is used in a valid
> context". Are you looking for something like this:

Indeed. My concern with the earlier version was seeing a variable that
may contain any scope be used in a context where it can only represent
a cache level.

> 
> enum resctrl_scope {
> 	RESCTRL_UNINITIALIZED_SCOPE = 0,
> 	RESCTRL_L2_CACHE = 2,
> 	RESCTRL_L3_CACHE = 3,
> 	RESCTRL_L3_NODE = 4,
> };

I do not think RESCTRL_UNINITIALIZED_SCOPE is required (perhaps getting too
defensive?) but adding it would surely not do harm and indeed make it
obvious how the uninitialized case is handled. I am not familiar with
customs in this regard and would be ok either way. You can decide what
works best for you.

About the new name RESCTRL_L3_NODE. It is not clear to me why "L3" is
in the name. 

> 
> static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
> {
> 	switch (scope) {
> 	case RESCTRL_L2_CACHE:
> 	case RESCTRL_L3_CACHE:
> 		return get_cpu_cacheinfo_id(cpu, scope);
> 	case RESCTRL_NODE:
> 		return cpu_to_node(cpu);

(oh - maybe the earlier RESCTRL_L3_NODE was a typo?)

> 	default:
> 	case RESCTRL_UNINITIALIZED_SCOPE:
> 		WARN_ON_ONCE(1);
> 		return -1;
> 	}
> 
> 	return -1;
> }
> 

I'll leave it to you to decide if you want to use
RESCTRL_UNINITIALIZED_SCOPE. If you do decide to keep it
could you please let the "default" case be the last one?

>>
>>> +
>>>  /**
>>>   * struct rdt_resource - attributes of a resctrl resource
>>>   * @rid:		The index of the resource
>>>   * @alloc_capable:	Is allocation available on this machine
>>>   * @mon_capable:	Is monitor feature available on this machine
>>>   * @num_rmid:		Number of RMIDs available
>>> - * @cache_level:	Which cache level defines scope of this resource
>>> + * @scope:		Scope of this resource
>>>   * @cache:		Cache allocation related data
>>>   * @membw:		If the component has bandwidth controls, their properties.
>>>   * @domains:		All domains for this resource
>>> @@ -168,7 +173,7 @@ struct rdt_resource {
>>>  	bool			alloc_capable;
>>>  	bool			mon_capable;
>>>  	int			num_rmid;
>>> -	int			cache_level;
>>> +	enum resctrl_scope	scope;
>>>  	struct resctrl_cache	cache;
>>>  	struct resctrl_membw	membw;
>>>  	struct list_head	domains;
>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>> index 030d3b409768..0d3bae523ecb 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>> @@ -65,7 +65,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>>>  		.r_resctrl = {
>>>  			.rid			= RDT_RESOURCE_L3,
>>>  			.name			= "L3",
>>> -			.cache_level		= 3,
>>> +			.scope			= RESCTRL_L3_CACHE,
>>>  			.domains		= domain_init(RDT_RESOURCE_L3),
>>>  			.parse_ctrlval		= parse_cbm,
>>>  			.format_str		= "%d=%0*x",
>>> @@ -79,7 +79,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>>>  		.r_resctrl = {
>>>  			.rid			= RDT_RESOURCE_L2,
>>>  			.name			= "L2",
>>> -			.cache_level		= 2,
>>> +			.scope			= RESCTRL_L2_CACHE,
>>>  			.domains		= domain_init(RDT_RESOURCE_L2),
>>>  			.parse_ctrlval		= parse_cbm,
>>>  			.format_str		= "%d=%0*x",
>>> @@ -93,7 +93,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>>>  		.r_resctrl = {
>>>  			.rid			= RDT_RESOURCE_MBA,
>>>  			.name			= "MB",
>>> -			.cache_level		= 3,
>>> +			.scope			= RESCTRL_L3_CACHE,
>>>  			.domains		= domain_init(RDT_RESOURCE_MBA),
>>>  			.parse_ctrlval		= parse_bw,
>>>  			.format_str		= "%d=%*u",
>>> @@ -105,7 +105,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>>>  		.r_resctrl = {
>>>  			.rid			= RDT_RESOURCE_SMBA,
>>>  			.name			= "SMBA",
>>> -			.cache_level		= 3,
>>> +			.scope			= RESCTRL_L3_CACHE,
>>>  			.domains		= domain_init(RDT_RESOURCE_SMBA),
>>>  			.parse_ctrlval		= parse_bw,
>>>  			.format_str		= "%d=%*u",
>>> @@ -487,6 +487,21 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>>>  	return 0;
>>>  }
>>>  
>>> +static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
>>> +{
>>> +	switch (scope) {
>>> +	case RESCTRL_L3_CACHE:
>>> +		return get_cpu_cacheinfo_id(cpu, 3);
>>> +	case RESCTRL_L2_CACHE:
>>> +		return get_cpu_cacheinfo_id(cpu, 2);
>>> +	default:
>>> +		WARN_ON_ONCE(1);
>>> +		break;
>>> +	}
>>> +
>>> +	return -1;
>>> +}
>>
>> Looking ahead at the next patch some members of rdt_resources_all[]
>> are left with a default "0" initialization of mon_scope that is a
>> valid scope of RESCTRL_L3_CACHE in this implementation that would
>> not be caught with defensive code like above. For the above to catch
>> a case like this I think that there should be some default
>> initialization - but if you do move to something like you
>> had in v3 then this may not be necessary. If the L2 scope is 2,
>> L3 scope is 3, node scope is 4, then no initialization will be zero
>> and the above default can more accurately catch failure cases.
> 
> See above (with a defensive enum constant that has the value 0).
> 
>>
>>> +
>>>  /*
>>>   * domain_add_cpu - Add a cpu to a resource's domain list.
>>>   *
>>> @@ -502,7 +517,7 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>>>   */
>>>  static void domain_add_cpu(int cpu, struct rdt_resource *r)
>>>  {
>>> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
>>> +	int id = get_domain_id_from_scope(cpu, r->scope);
>>>  	struct list_head *add_pos = NULL;
>>>  	struct rdt_hw_domain *hw_dom;
>>>  	struct rdt_domain *d;
>>> @@ -552,7 +567,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>>>  
>>>  static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>>>  {
>>> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
>>> +	int id = get_domain_id_from_scope(cpu, r->scope);
>>>  	struct rdt_hw_domain *hw_dom;
>>>  	struct rdt_domain *d;
>>>  
>>> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>>> index 458cb7419502..e79324676f57 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>>> @@ -279,6 +279,7 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
>>>  static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>>>  {
>>>  	struct cpu_cacheinfo *ci;
>>> +	int cache_level;
>>>  	int ret;
>>>  	int i;
>>>  
>>> @@ -296,8 +297,20 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>>>  
>>>  	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
>>>  
>>> +	switch (plr->s->res->scope) {
>>> +	case RESCTRL_L3_CACHE:
>>> +		cache_level = 3;
>>> +		break;
>>> +	case RESCTRL_L2_CACHE:
>>> +		cache_level = 2;
>>> +		break;
>>> +	default:
>>> +		WARN_ON_ONCE(1);
>>> +		return -ENODEV;
>>> +	}
>>
>> I think this can be simplified without the indirection - a simplified
>> WARN can just test for valid values of plr->s->res->scope directly
>> (exit on failure) and then it can be used directly in the code below
>> when the enum value corresponds to a cache level.
> 
> Is this what you want here?
> 
> 	if (plr->s->res->scope != RESCTRL_L2_CACHE &&
> 	    plr->s->res->scope != RESCTRL_L3_CACHE) {
> 	    	WARN_ON_ONCE(1);
> 		return -ENODEV;
> 	}

Something like this, yes. It could be simplified more with a:

	/* Just to get line length shorter: */
	enum resctrl_scope scope = plr->s->res->scope; /* or cache_level? */

	if (WARN_ON_ONCE(scope != RESCTRL_L2_CACHE && scope != RESCTRL_L3_CACHE))
		return -ENODEV;

Reinette
