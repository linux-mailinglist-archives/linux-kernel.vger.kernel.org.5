Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324917B7338
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbjJCVTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJCVTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:19:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F3BCE
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696367982; x=1727903982;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kfOjoJ2/vr1AHeoyqPR6bo6prVMnGSa0fkgq+Zu3XNI=;
  b=bHkjD1egdMe6yiPj4drIqKjgJ1+heJB4ILTEC2VroBNKmys1LFmvL2NA
   0QlDZnVfdv2ZnED7exI8TQrl7G2wHLZPLny/tG058NB1UKQOyZ1/EY7KU
   ipgT2diAzqHMCAAgmJxrVyL1Q9NeJKOSclvBiXBTAHpKRwMOhmlvUf1SZ
   1ugOyFTS5yBCMtBuHdcGFe13WO+6jn9DtjOfEn/V1rrxVj9HC4Lnf4SlD
   8I3wgqAoo7uPIJc+jfcS+a42dYUxvVlKehVp+IZ6midQZ3EzTj7TL3Lr6
   rfICMs5MuOx0PWVpxqaEL5DDwoLwlA3qucVaEG+4UJZQAEZJxLic705Ze
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1577535"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="1577535"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:19:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082176176"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="1082176176"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:19:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:19:41 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:19:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:19:40 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:19:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvXMUkx7JbjdT44js+ep7TQ+zH1W5nLLwxQsPgsZHLwqTKX6ToJ02Cj4WHH5ibQNbHf/NxcA8pByOXY4DlN1LDrm7rFjCX+ID3ynF/0EFctxBP2G7bZ+052V7Mr01cYU2hbTcbTILgNIt8nEitsoZSh1oxAKVKtac3AHgg5S6kFnRxqjW+pbGIPjo4/d014ZIqEOFIX1J74z4g3vbE2JX1oSpsnfvlJtht5aKQGaZFRN6S+JamxRrZbZwfRvoQJaIUzahfq/mM7zJMnmi7Cv6XNwb10aOICfJyAtma49VsdeXhqN6PC4uvrdrvyxMZTNaBAMDcogJ8JlKkqC3pjZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G96XEg8HopuPRB7tEXjtt0DQr2dpdyHtdxzUdbjqE0Y=;
 b=Q88zUMBlbb1MxHqIrW+5osAA9gWzNOUwLXcgY+mJH0Doyvo/1Uv3oXcKEmvb0pJ72/3Kq3CecRvey/KzTUGTX46Nvrax5xOs3/pwjlx+wCvAmlPGf/3CU6DwHK+29JSHbZctwWa5F/yFgL8Meq84OGLYSM+oeHLZxCN+pYSXTC8nEHkDbUHQ4/ZAcjmouWMeaiE/ZSDePFDyGWqTPbTVl1fjnBMC9UwYTtU3XF0qVgIJXZCMXdnHBDhFUYpljXoh+gvWddydJJPxsr52OYK8rD2D80vss3CLjwS5tC7W051O9aUf2HToMSgSB+3CMNTYDqGD6FfSWgWzzPp5HK/FZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB7132.namprd11.prod.outlook.com (2603:10b6:806:29e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 21:19:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:19:38 +0000
Message-ID: <f29a69fb-eb5b-3947-7022-4b68129901ed@intel.com>
Date:   Tue, 3 Oct 2023 14:19:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 18/24] x86/resctrl: Make rdt_enable_key the arch's
 decision to switch
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-19-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-19-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:303:b6::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 198a87da-ff11-40a2-dbf1-08dbc456735b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rifAM7Cni960e/PrIkHTpQYdsCKRoOJEPko1SBkSccibMZ7QH4aCp0Y1U5A1EyOjz4F2jR1IpQvW8VgwAgZEMW7W4AXR71uStlaai1meqlNcWyCoFMg5vrA2Ka5kU/izhL5rHWMGfRC7WwVpl1ITjDFFkvah9nPluUoBj+ZCTjAq2U7W4pFyA1MCiLV/sESRkOJE3GKCy+REVchlQwhzmUj4s0ctPfl8efkaRtof/aCbscr7a4nwGPcs7zzaHSyPr1rPtBrOXmnrbLUechNOmHCExTf+P+Z4PGWogsHAiqf/xD4Pz1fl5/oSZ+h0evbXCnyV/m9t87tQp5otOlJbJZN7o5DVBB64yAU/f+fwAFAAd6a3x8IQW4ks9yq/cjDK9x5c/O4x7JOgI7TYeTyaoUb8Znw8DrXyilwFiH39tvjXRdaAwo9Z1+Ai96VSqgQLc8gLvRdTPvMBxQOcn8IyJnMqlyiwDERaLfZdQCArO5zBgDWFuD85DuDRaR/lWufqPoDtA4AtUyXW8Se1/oJGbjFixedkO3jX6fgXcXrOalIx+oO8Fyc5ebjVdgQZS3sTBcW7ohWnIABKYKf2eTRW+7Mqns540BngxknmtHpCdq7bWiHjEMThdwKrq+YzcXKseMlDYXnwSC2IVLMoCAqdoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6486002)(53546011)(6512007)(6506007)(478600001)(2616005)(82960400001)(2906002)(7416002)(26005)(41300700001)(316002)(44832011)(66946007)(5660300002)(66556008)(66476007)(8936002)(54906003)(4326008)(8676002)(36756003)(4744005)(86362001)(38100700002)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVgxY1ZxQ0ZqZmFoekNrNk4xb3V2Q0ZNbFg2TkpNVlZBdzlubGJsb0NsaHJD?=
 =?utf-8?B?ZnRUb01aa3prTmhCcmhKZFFCNXNSaHJrN1pMQ1hpYUtJeGJrbDlaN2VHWG15?=
 =?utf-8?B?bG1ubmY1VUF4UjdUUEVkSnFsTmNCaFFKd0dBSzd6ZzkvSWlaNGlXaUt5RkM5?=
 =?utf-8?B?OUNaZms2Vi9pdi9mUGJqRFkrRGx1T1lxUmwyakFpb0QyNFVZRmVnUEpCUWlZ?=
 =?utf-8?B?cjBsTlFnUmxaa05tdGJNVS8vUzNiQjNUQ0d3R1RWQlNLT2JWQWdaSHY5MXYw?=
 =?utf-8?B?NTV2azFsRlZ2citIdHBsSi92Ull3QndCRGk5R1d4ZTJSem9qL0l1YXl3QVll?=
 =?utf-8?B?UW9tZFJoWjhXZ2JhaGNlQ3Nzd3FtSnhVcFJWQUc0WWI5ZDMxYzM5OEdsaytG?=
 =?utf-8?B?UE1mUkd6cXdnOFhna1JXRXpsdHk0QUxvMS9NSVpCaGRlbG5kN0ZCSWNZRTdn?=
 =?utf-8?B?V1MxMnc2S1p4SXVQL0syUXE3Mm5hTWhDWVkwNFluSFhSN2NsT0ZQQk5wbUEr?=
 =?utf-8?B?aHkxNEVrck5KZ2pGZHkyYmZVQzJza2lnRXhMM25NTTE2MU9Wb0UwL1Q5Z0R3?=
 =?utf-8?B?VFp0OFpzaU5mSWtQK0xqbUpzMU10S0JBMkF6SENwQXBEMUtrdGtMcU5QVy9T?=
 =?utf-8?B?Z2VPcVJieHJ5eWh3RFlGTFRVYncyd0tKdEExOVJoYkd3a1VVU2lhYmt0empp?=
 =?utf-8?B?Qzl0RkdnU1EzNVZvdGpsYmUwWjBndnBNaDNEVWZ5S3Z4YUp3WG82aFQ2WkdM?=
 =?utf-8?B?c3VaSzFtbGVlaHFWMzNtQ005VkVGZDNnSFdlVWNlWTNmRElnVXpWd050UzBh?=
 =?utf-8?B?NjBIY2R3My9OT3dOaEhJNU43MW5ob3ZncXN4QmhQVXk2ZnIxcU5oNlhjVkY4?=
 =?utf-8?B?Y3BtZlVJejZQNUdFeHovN2txQ1VKWjFEaTVwaC9ZRmhaYnN4a0lQRTNrNWJL?=
 =?utf-8?B?TUp1czBoQWUrUVVkVFh4ay84blhkbytqeHZGYnpOTlNmUmp6aFpLR3JHdmdp?=
 =?utf-8?B?K2dJK3VTV0p2a2dneDN2eDlEeGhmdno2UTc0V044dHZVbGZyQlJqQ1BBNWkw?=
 =?utf-8?B?cGdJc2hUZm4xN0dQTjFhL3lObjNBM3dBWWx5UCtRS2dIeTM0K1k1RVM3dFhZ?=
 =?utf-8?B?YnVWazJTTXAvcjljZThyK2dTWm50YkFsTXVaMWdPTjF0L0tSZ2Y5YU8zK2hy?=
 =?utf-8?B?OU92OFpGTDNjaXMyaG5CK01XREo4UUNNa1BrVnUxYW5JU2pCT3VxT09RaGR0?=
 =?utf-8?B?U2RnQTA4SzNnWGVETk5EQnB2NUZRcHdyR2pOTER0Njl1OWJwUzZOamJBNCtO?=
 =?utf-8?B?RFVsYnJkd0ZkbHJQM1ROU1gyT2dZTjR2S0ZHa3JXUGxQL2pQN2hXVTNYWEIr?=
 =?utf-8?B?M1FXZXE0MDYwa0JCVGNFVXJOWE9WVFp6aVQraTBtWGJ0ZDg2YVA3U1hXUkMz?=
 =?utf-8?B?QVM4Uy9ZY240enM2LzhzVnd1SnlSeG05bUY0TGtmUGpBN0hEalRVYkpJdEVo?=
 =?utf-8?B?US9ianpzMk1jcXhmTWc1dktmR0xQQ1AyTUtoOVQzaWVPNW94RXN3REVhUm5R?=
 =?utf-8?B?cDhOemlpV0tzdDdIejZpREdRblJ2Vmg0SXRaWTdtUVlSYnNHK1diQkhIeTNx?=
 =?utf-8?B?Y01RMFAwWDA5UTNDdmJ1Vy9YT01mcUFIcU9XOWZPY001UVRMZ3V4WjBPVEZl?=
 =?utf-8?B?Q1ZzaG1xcUE3TkpHQzZ3MHp6cmoyT3o1UDYyOTFxZmIwS2Fod3JaZzcyTm1J?=
 =?utf-8?B?TXVoZlpXWnRQcVVWRzZrOFY1Ky83UllOcVk3ZER6M3cwY1RVUjdsT0NNZ0E5?=
 =?utf-8?B?eE1rWThuajZENkx1dXM0OGNKekJuRHVMa2NwNE1xckpmNUIrMmcyYVNlMDZ1?=
 =?utf-8?B?eExvRHA1Y1hndnZCQXowQmdWa1lZZFY4bU1JZmk5dHdDMmhTTmRMQ2VISkt4?=
 =?utf-8?B?czZXVW9ZeTNScDllWVpQRzB5N1g3TmI1ME5kWnUyMmFlNEc5TUx4K0lTYklm?=
 =?utf-8?B?SUZTWHlzS21lYThMR05nZTBVVVROZmJRR25zaldzWlRqR3NvUlpQa0VCZUFn?=
 =?utf-8?B?VHYzQjh4RXluOHI2UG81K3lZKzlqMlhJZ3BPVWdNdHVqclB5ekhrUUhkT2VV?=
 =?utf-8?B?SGxRQnhtWXF3WWVhbWFXSTU5V2FCL2VsZ296VHZ2V3JzRmJGKzlRZ0RuN0Iy?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 198a87da-ff11-40a2-dbf1-08dbc456735b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:19:38.6201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bha86WcDSeC6/NFJhhJUOStbPKDC2spXDeP/n7co3nDHNr2ys2kO64upJ7bQkt80ryJJqAsT/gQBq8zwwM92ez6ECVJ9nVzlGb35Akb95ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7132
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:
> rdt_enable_key is switched when resctrl is mounted. It was also previously
> used to prevent a second mount of the filesystem.
> 
> Any other architecture that wants to support resctrl has to provide
> identical static keys.
> 
> Now that there are helpers for enabling and disabling the alloc/mon keys,
> resctrl doesn't need to switch this extra key, it can be done by the arch
> code. Use the static-key increment and decrement helpers, and change
> resctrl to ensure the calls are balanced.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
