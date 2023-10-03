Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C137B7339
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbjJCVTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJCVTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:19:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C836BAC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696367968; x=1727903968;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0B08+WmQ1kFZ+0sT9Qh86/o/7baVSrA/9mFE8ArDVaA=;
  b=B1iJX08loSPCU7ogvuoTtzYImYdCKVhzaa/aiMaCkT5AFTAGxG2jghw5
   s990QX0ZVK80RBZkiKVzVNc2mqJcKst7pmd2vj0i6RfxzEtJ4AbfcdSSA
   LJDLsNRP/k7eMEAuan5ImUKBeb7+P9WXhNScmDSUrfim+XDVILvO3aFN3
   g1cDM2QV61ULaXmQXoC+wBHqD1Bl/7YrewArLCUZx+tvWDvJzVekrDio8
   +3XqquiOSNuhdWCXJspHs1iWXK8HNYZPhM50LbvmrWi0lIWfo/BdciNTu
   klJGOnjsQXgRLN4MvhBk0+cbUEBmnOiCGhpegtsfGbzKdbkk+fcC8rKuI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1577448"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="1577448"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:19:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082176142"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="1082176142"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:19:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:19:27 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:19:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:19:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:19:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRG7zLud3CqN6y2Ltd8hRwCUkEf+aqcNtj9lGL3Vx64po26ufzyOx8mTVj378L8tqf1LpSz0eUBQJUzetBP+m/fhG0LQRl3cpCVjLitoCfYmca+g+b4Tts+u6iizerz7ZlKNP87HCOo1qF5Jcqez5FAo3XL46P5+/s/OMK+D65sQgNv2RCYNIRWXi+ajC9cAZbjvVkX1RgUInFSlNgXvReTlCk+F08XX/VltVstm4G4FHfDwKJkzx/Uzo3QS7KL8HIMiplZVrIa5QTeCK1P1tgLR07/kcilbM+Z1OgET4QXdzJvJLLTJTxZmz3yL4A3JeMWGgLkiZIdUzzmoIabukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGUaqXXaE0AkYfyrhNnua1wrPZ7XHRJRWDwCgy8moMg=;
 b=PIVDhamnK93gaMsvj9GqmB4jQyDY/otoziiYiuwcy6ckZvz7qzfMDyQRpemgqNWBxhRF7I5Yp4skYyeD1roc/EfeKhgMy9xBjj11hC0WlOaBdb6gT9lJV8qxcxoSMIi89q7wxP17HdSndUE0P1Kc5DA6KrauSIIuQqlAYl1czyMZJ9CbwyS9Zp0ovnD9M7CV4qj036EYUmb/SirA/xJOdzRYPf6WIBo6h1S7idrkrkXbcRMARNQJ4N3DSClzG8YnpPziiCFiepnjDPhUrXnJ8vaXAmW84PYclBCRYc2jCWZ/Q4FBp3zzj/nhH/fDk8FjUoC/EZGPvcBbP7cYI46qag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB7132.namprd11.prod.outlook.com (2603:10b6:806:29e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 21:19:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:19:25 +0000
Message-ID: <ae09459f-9412-16ff-de90-1e51504de4f0@intel.com>
Date:   Tue, 3 Oct 2023 14:19:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 17/24] x86/resctrl: Move alloc/mon static keys into
 helpers
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
 <20230914172138.11977-18-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-18-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0256.namprd04.prod.outlook.com
 (2603:10b6:303:88::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 175a4123-a8c3-49f3-c374-08dbc4566b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFzYG+6PLNol26UAzItcWjE1LXFWsETeUqFZjA8Kim8O2Wby2VInYjTpm7vgX74Q4jmu+N6hbORVadBkbQoWR5xo87POnHkKX0tRIezmtGUdkM6GvDnlH2OtR9saNZgVfyi3FJBwKwAA/cxBzwogBqBcIa4KIoUQGHrV+SBG41Mz7kEtuRVmj0D2tJuYZvfK/EDYTXywSrHYH2KxLjRpZYb+liaXm4R2JzkkEcQBiMy0Ggu7zbtqutub/c9gAKj0e9tYX0jtlQwW+6mLYkw/14v9Gq6kL9K0EqX0995qv8mrNa06z/mlTnNcHn8Y9O/sFYwuriUj4JSESVPzb5LkU9lDSx5vy9ejPIOTlXiwl8z7cloKS3hORLMdyLf5faz6SF4NllpTZV8vLD4FeLIKlDIDa4VZVNTMbCpbmYr0Jcdpo4qxPqczSihQH78M7BezPIA23/y2wcUjhqBi27op1D6AuErKAfC/Txh1pWZBsFU+QJIBfnNQFPYdKzHzfuFUSkz9rdaFEtQtzA1HulvNR5gQuNI7OrduF7pn0w2MzjfewavYz5fZyIiWndIUBtvyuSvej5PPFM8ScfKp2nMYdkBxpBpgT/s3frCclHGanHMd091oLVnixcOJEa3Zk6IEd/mJod9Drci1lSehtkIypA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6486002)(53546011)(6512007)(6506007)(478600001)(2616005)(82960400001)(2906002)(7416002)(26005)(41300700001)(316002)(44832011)(66946007)(5660300002)(66556008)(66476007)(8936002)(54906003)(4326008)(8676002)(36756003)(4744005)(86362001)(38100700002)(31696002)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDE2cU9FTTFjZGsrR3VmeFFOMmtSUm9XTUJKcG83UHNJR0E2NEZhZVAvTEJ3?=
 =?utf-8?B?SkRVelQ4OTFvOEMzTHNUc0dTL3YxLzNqd0MwZTFpQkhNaXFRM2NYczNpbjhJ?=
 =?utf-8?B?QjJTY0VZanY2U1ByMGlwM1FhaWtiT3lCMjdheWowOG5aTXhlZGtEMysxNDU5?=
 =?utf-8?B?aVpvdDByNlAvUHFQL1dTdzEwWHZBcmRvMUVvSUZNNytzWUp4bzFXclJqL04x?=
 =?utf-8?B?Tnh2Q0FTR0JpMk44QnkvemRNeTFmekpQS09aZS8wZ2ZoQTFKVkp0RjlsQXhC?=
 =?utf-8?B?a1BpTkRmeUswTXlZaDUwRHg2WHJqQlFqbFdXNHVjYnByQVpOZFdPM003V3Jh?=
 =?utf-8?B?Vi8xRmlhZC9jeHk2NlZjVUNWQlZZTVNBYjlUbnlrYnNGdkN5M2lRL0xJY292?=
 =?utf-8?B?MktiNzNqYmZWVWZFd0JSUVJYRzM3YzJ5L2pFNmNqVTRYR0E3d1A0Y1JrUlcw?=
 =?utf-8?B?bitSWW1vTTRkR09kczlkbkpiQ3kzYVd4eVpSa0ZzeERadDY1UmEzV0FBN1dP?=
 =?utf-8?B?Y2VCSzk3c254U2xUVmlXTjE1TWFJUUNyVWpwTkd5bks5NjY1b3hKTGp0MnpW?=
 =?utf-8?B?enZsbU4yVWNKS0ptZENpQ2xWUXNzZHAxcExmV1hIcEJ1RTR2Ni94SnFOTENS?=
 =?utf-8?B?Q1pnckxxeVJzeXVoUG55UzQvSFNaS0lwOVR5cmxLb01YNDR2YmlQL0FEdStq?=
 =?utf-8?B?S3E4WUhNZW9vNVpzWTdsaFZISGUvRENtekhSUWRERk5IczZFbUdCT09WZWZO?=
 =?utf-8?B?TVIwcy9pV2I3UkhoQXNsK05PWWp1RmxwUDJNYTNGMVRSMVZxelVINnF1SHBz?=
 =?utf-8?B?RjFWU29ZWk1aTVZFWmRGcVU3c0IrYlkvbXRpRXMrUXJCUm1WckVYTVhEcTho?=
 =?utf-8?B?WVNnNXdJTTdlQWZhK1orYmpqZlV4dkRzV2ZQNkkrWDZnc0JtdXAzWUd5QkxS?=
 =?utf-8?B?MlJNT0ZmTTVISkVlUnVFb0cvWkxjMEMxVy9GZTVuL09vdlBnci8xNFBpUXBo?=
 =?utf-8?B?Zm1ScVE0cEpuTGR2Z1N5WDM1UXFCU3I3SE80eFI3WUxwNTdOTzNzVTNsZzJD?=
 =?utf-8?B?ZmQvNkIrZ21QeTVwc2NPbUVmKzhiakJJYkJKQTlsVk11TzVVZjhCTG5pZmFL?=
 =?utf-8?B?akphZjZtZXBhMURMTFowZXhkOURhKzl1eStVQ1RWQVdZUlJTYis2S0xuWWp5?=
 =?utf-8?B?OG9vVGtESHBMLzJYang2N2U0cFZyRUtxREFtbGh3NDlwUHliL3I1R0QzUG1a?=
 =?utf-8?B?TmU3M0k1NkMxR0pVbGtRME1HdHphTWpEL3pHZnJmWERheExTSE9YcUp5bG14?=
 =?utf-8?B?ajBNSHVieVp6b3o0R3Y2WXN4SW1JM3ludHlTNDFCZCtOS1AwWDlITDU2WVBz?=
 =?utf-8?B?N1VIU2RoMzNQdUdxVTE3ZUtqRk04RkRPQnhMZWYxdlRzNlFDREFrRlMrTFM5?=
 =?utf-8?B?UVZIRmdCYmRkeXZoNlFoT1RMZDhVUUV2VU9SdGZqRlpSVkc3ZWtyL2Ztbmxu?=
 =?utf-8?B?VjZURVJ1WjRaS29kVmxhT1hpSHBXS3pwUTcvWmt2cDFZWEthUCtHKzVGK2Ji?=
 =?utf-8?B?Z00ycXZMTGxqclYzSlJMaHRJYUNEUFFvUElWWFp1dmdLMnJtbVlBRDNGZFdC?=
 =?utf-8?B?VW90UlpMZk53eTBkektoMld5c0hodjZTeU5nWm1DOGVCc0h5bm5kN2c0MGpS?=
 =?utf-8?B?aCtmQ3RWeERxMkcxZFVMbXBPUysvL2Vab1NpSUNWUlhXN09WNkZ6N0dLSnZm?=
 =?utf-8?B?aGtDUFFyM3JZYVhQSUxIL0JBRXJybTYwZlZTQU0vaXRqSlhaQlljRjZkK2hX?=
 =?utf-8?B?ampNYWNvYnBKN2hDeTFaUWR5cStXTmhmeWlRNHY1UHo4a0EvMVVOVGJxWmgw?=
 =?utf-8?B?QWZWelorYVo0Q2lvMU1Cb3grNGFuUjJJVnE3YU1Fc3BWbFFhbG5pRFlOSVp1?=
 =?utf-8?B?VUlPbE9NVHpjcWx0T2NXek9aNm0rTXZFOGhMWnhDOWM2UEdKVmdWWU02ZWd3?=
 =?utf-8?B?ZHNZL2Y4SkZJek9MTXJ4OW94eVZsQUVZK2xKYzIvOHdMTkFkL2JmQi8yM0pX?=
 =?utf-8?B?K3E3enRCY2Mwczk1d0dJVDJGZVRNVU4rSXBnaGU2Q1lqaFlYN3RwNDJnM0ZV?=
 =?utf-8?B?RjFjdFR5THVIazF2MG9UeVN5OUdvckM4cWplcmVMRWJtak9oR1hDYVovd29V?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 175a4123-a8c3-49f3-c374-08dbc4566b84
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:19:25.4371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GC/MqRVDE3rM0CbLMx3tKw/YBVu94l3fSjcLCk43kOz1m7R/xAhibfSZjE46N0xXDX/V/iOENgfKcc8pFKh74CtNh+neJ4uqytsYlGf/wJE=
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
> resctrl enables three static keys depending on the features it has enabled.
> Another architecture's context switch code may look different, any
> static keys that control it should be buried behind helpers.
> 
> Move the alloc/mon logic into arch-specific helpers as a preparatory step
> for making the rdt_enable_key's status something the arch code decides.
> 
> This means other architectures don't have to mirror the static keys.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
