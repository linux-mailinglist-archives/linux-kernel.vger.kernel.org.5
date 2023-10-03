Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C85E7B7314
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbjJCVLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjJCVLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:11:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CF983
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696367487; x=1727903487;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sedwEueykFU3UsqJtZchvYtoyyBl+KysHnGSACDHhAI=;
  b=MUiLH6N40L7wjaMBgI7JQLQnAZbnuIcdQ54o4uFzmVALbXhgoKFtg1Qm
   JYfcxQpwKSAEB3jBwsMddg4KLU4ZFC9FY+risZ2jz7S7lWaR4IYCVBlBn
   NqcZ0WmzwmOA73ioTuw+3Gq+QK27qrc66iVQkI/A5W+41VtJmnuaQdgt5
   QiCHVks8fsim7rGzCj1Ym9mgvqm8StWBn/6vsclx2W3iWSChRE546JK3F
   dhdOOCWkKeaaYkSkYjAt4WeEl1wT36RZfzYADRo5niEqbVN6wBUEESV5o
   QSEgiMzJyBsHy/wbPf54cbts/c/L913qLNoR8azhUYMu0WBbIX5vwG57X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="382890468"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="382890468"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:05:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="816850461"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="816850461"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:05:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:05:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:05:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:05:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntbNrCFOIz0ZclPQMgnwsJXEgp6ZYde3RrPhCGESgH5XXy9qH9l8P3eXGpfOEpSe+5lPR7F3P3e+HWJDYftNXedw/M9GGVxesNR4HqoBEbFep0xIFsP+nhGveSEDT7D+lqFeVRGFRfG2DCM6DimZk3Eg4TAkqMfmKnYzZ2LRKGKlZbs3GIrvQT3NdJj1SdsGeZMQMAT52KbI9RTPAT1UMF1YS0iEJ6nvMz9NQveRgKpt/Tfa9ZgXwn1kongyjvGO8UQP6gTE45IRDrX5qo/50PaiyiaVQIGW3+f4danlhJqs72EOGOJnjDFbjLjEQ3sDPYxVaM6Cn7Yo8y38cGtEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKstbZ2HbhAxzfTNlDLnsEUMi0Y8S2gu1F8iF+4bsN8=;
 b=BkNlXRWm9kXpt5fB5YQZBZQ9jYphrjHW5Ji3bzXRBjdCBQZz5v0V56KFnj3+KEiAke0BSFy/TgslBPqlEGCSabJrbcfT3R+ccR4HlCFd6wOqLI9zEL1iWsCXucC6lAf88GoINWAnoVkupXjo5Ngas0sF79RaPvYf6TCjvFFZSTQHriUKumAR1YqnGp4/6c/a8X3mDd7+0usZ+us7tTZJ21AhUbiRs8GwRsxR+zYlILtnr/Az8oGA67jxjVPljqX66351q5idkMcOO00t0y3FOTNNK5oQSzzle0V5X/BQ5H7sqKu6pUaIUWyYw9Uuhe+5hMnkvW4kIgygjZfjSJ0DpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6908.namprd11.prod.outlook.com (2603:10b6:510:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Tue, 3 Oct
 2023 21:05:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:05:56 +0000
Message-ID: <fd8301e6-b0fe-8e8c-f0bc-13646da3ec41@intel.com>
Date:   Tue, 3 Oct 2023 14:05:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 01/24] tick/nohz: Move tick_nohz_full_mask declaration
 outside the #ifdef
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
 <20230914172138.11977-2-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-2-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0005.namprd21.prod.outlook.com
 (2603:10b6:302:1::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: c230f542-d193-4a00-c65c-08dbc454895e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y608XZpYrz0xC71+l/I7vVrDwVAnSB+9NpcHdNuzXeT0jCZgXkV3EhYqwfIcefLyB+uZs8/4JvqAB75ui8aDW/zRllESrU5246MlL9O2Jhu1R6ZMgZ3xSS7HFtw8inrlJy2HcOqHTf8FluWj4QuxTnxL8ERa2JUeDaCGKJshuFS3tYFs2hcCgy4yunVljklss5iIAMEKUC4t3jUhIAa7fYzTikv6f4bGV82w2WFtMAD4j+vjpeB4kpMqmf2IzJLBUVvVXpM9Rr+qKZ1/msWIe6qjgbAVL239QW7Su9tkbhEKsTIqCYBiggZjKdasyuP+4EqeRqAFNSZLiKDBfCAlWX3KefJl+QOzrG1SvcGoRuJprqmNOnrZvuajPLmQ5PZs3eGPP183pUHPntvRBPq/h7g89Bugi7A3UUoyiRoZny2qGjsTXAmKtl5s3PL4A4iFwuXHFA8g/NEX5TVp16TuzrUXjvYZKZRIFnj7wdbV+KekCTI1L7WJaBQ1Y4G9pcddyM7c83dDjH7m1Ar5BDeSpzjCJtq4fWhKZG2HBMz3+w46nTwDqA79vOT+OMiRNIbnYGw3iT1UuQ1156hJGhbeOjTMyXP85BOwLy8Cm70fj+W5CqQpQeye7krLXzj/6X0S7Qflmvk4orKzDJAfD28gTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(44832011)(5660300002)(66556008)(54906003)(66476007)(31686004)(41300700001)(4326008)(8676002)(66946007)(8936002)(316002)(82960400001)(38100700002)(2906002)(36756003)(83380400001)(478600001)(86362001)(53546011)(7416002)(6666004)(31696002)(2616005)(6512007)(26005)(6506007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmtyUG4vQWRQaDIzaHF3SHh6RUl5SHNOOEJveE0rWVQ4SklyQ2dldkpZb2Y3?=
 =?utf-8?B?aEFnVW1DTDlsRzNKei9McXhyNGo1T2xsY01IbVc1c3NCQjhiRkRKYU9Mbzc1?=
 =?utf-8?B?RUdJSnlyNkQ5VDdNTzFlQWpxY1Q0RGU3OTNMc3pxRkhQREE5MHNVYlNreVVC?=
 =?utf-8?B?c3VXbmZvdzZmTUlhV1U4aHhNcXFJeXpBY0R6QVRpUW1lQTdRU2JYT080Z0JT?=
 =?utf-8?B?RzVnTGFRcjdha1JOQlpsQjVZV0s3Y01nYXRDdnZXV3orM0dOb1pTNXJjNzRQ?=
 =?utf-8?B?ajFJQnNhdTNIYSsvRytuTG9aRmlxcTNrY0RKajFycjdSdVovaWlqR1hRUGU4?=
 =?utf-8?B?VEx6VU84ak5YVHUzYk13eUJHUHJWRGtBY1dLR1kzaFVwS3A5bm5WODdjSDY4?=
 =?utf-8?B?eGFGSDBxQkFHVlppS0kzbXd6UDMxR090NmwranFUeWxxbkYwWUtHL2xSQjZX?=
 =?utf-8?B?V0g1Nml0b2NzQzRRTUVra3c3c2h6eGdaQmxaSS9xNVRXanRqWlRDRVg4ZE53?=
 =?utf-8?B?enh2L3hFQXQ3UlhDSDZ4NkdpNHBHdHFKbTJZODlLalBXQ2xrbzVwRkF0VHFU?=
 =?utf-8?B?WmhVaE83YVROTVoyZmJTdFZJM3k4M0hSVHI1Y3FJMnJMUThvNjZWT2gzMTlx?=
 =?utf-8?B?bldUbWJEYlpZTXV5dTN4cUhUa09WQlF3eS9pK3hGTWJVVitpakFiVXl0enla?=
 =?utf-8?B?T1BzSkNCQURlWFQyb3p0U3NkZUFFdkc4aGxIZVduVXNYQUxwVi9FaVNNUU9U?=
 =?utf-8?B?cHFqSi9ZR2xCK0JqZGZDYWlFWWxxZVpjTzdWWDFUVHdKSHBCbHppd2RvL2hR?=
 =?utf-8?B?ZmJIbFNCN0xWaEVibm1mTmZISFkvaERFTVJJbXYrcXpaUUFqeVJ4ZTJPdzdF?=
 =?utf-8?B?d0JGY3M4NXRxcjVTT0g4SlQzaXpvbG1GMVhhUmlOSUdxc1Z0UjRYbXhsL3FM?=
 =?utf-8?B?OUNGeGRFZXRCU0haRGxSNTJQajdob05Dc3piY3U3QnNwRVhRdUN0emVUR3VK?=
 =?utf-8?B?a2ZQeTJQTE4veXVpU3pIN3BSMGR6elVHSzYrMXAyWHQ0QWNLTWtGV1JvbnBs?=
 =?utf-8?B?c1ppMnp6SWFLN2lwUEVvT2tHTzN1R0MxazF2cDFKZlpMajVjdko4UTNSL1RP?=
 =?utf-8?B?ODhrb0YvU2o3a0xwZ2d0RFdsUHhHUXIxTHRmNGJUeU1rZDBYc1haREpnOC9K?=
 =?utf-8?B?SVdNanp4cUh6VVJmZEhwMXVOUElTdlVPNEp0b01Sa1A5MndBcXFKRS9PSHpp?=
 =?utf-8?B?MjFMd3ZkUjFwYktLdHpuRTRlVjFOcHoySVljTExva1BjenJ2MVM4R2tZYm1j?=
 =?utf-8?B?WjBjMWYycnlxNk4rSHVwUU1naUIrWFAxNTQvZ0tkVHpXUWdTWklrL1BEQXVi?=
 =?utf-8?B?Zy9JSE15aFBYNDZkWTBSbWs4ZGl6QXVxR0FROFVNeWVOZTNHeDBCWWRxYW5T?=
 =?utf-8?B?SXFoZXBCSEpycXpISlg4eTl2Ympja2laK0U0b3lzdnNQVFVhY3NNajlRclJW?=
 =?utf-8?B?T25ScWV2VEJRV1EvWEkxY09qcGU0WmZxTkdhMGxDQW5RckZ3a1FzdXBUaWpD?=
 =?utf-8?B?QXNScTVJem5aaWFpYjM5YXVVU3NEWjBwQ3pMeGVlMEtRbDNXaHMvY2pTN1BJ?=
 =?utf-8?B?dzAybGJySGVYejd1YXl2b2Zsa0hxNlpMZWtlRk9ZWG9VWlMxN05ybUhQb05i?=
 =?utf-8?B?K1RXOG5RVmhRRUxmaTdmWFdEbGRRdkpOUnpEbGw5V3RJRE9TaVlhOGJEbnUw?=
 =?utf-8?B?MXlML1RDYTNCd3p5RXFYS29ZZ0Y5RmlQZDMxZU8wVjYzWVQxbVV2dFlaRU5E?=
 =?utf-8?B?QTRZSmhadEt0MjZtdVVmelhocVNaYTh6WDZpd01SVmJ0Q2J4L2hMTDNiQ0hq?=
 =?utf-8?B?OEhCclcyTXJpTnRsTk5mcUplS1Fra0hlN1hYVjMveWZVelR1dWgveFBNRnhq?=
 =?utf-8?B?cFVaWi9IcytzUmhRQWhkN3VObjdQeWpUbHdXRk1kT01pZTRvMnlTOEZ1a1Jq?=
 =?utf-8?B?TnkvOUtyTE42dFU3b0NsOGFXMnV1R2lVWWIwK2VaMElEa0VkWkluMEwvVHlN?=
 =?utf-8?B?NTQ3RW0vOUtVcUFMdHI2NDZQbytybThxWVMzdE1ETTkyRnVzcE5oNnNRRCtD?=
 =?utf-8?B?USt2UzRNU2RESzYyV3hiSXo5azdIVTRFTHdBcHlwb0JPbUdxTEs5UGtqNzdI?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c230f542-d193-4a00-c65c-08dbc454895e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:05:56.6286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpZSMovCkga7MuHRWlVHl4d8GSwSUL2U3pkknQtiQjMLWuEqddI++ylyh+RSCTToDcsgjwrKRjKrCrK1Hk6mSz+Gxn5+7hzdIyPNSs26dHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6908
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/2023 10:21 AM, James Morse wrote:
> tick_nohz_full_mask lists the CPUs that are nohz_full. This is only
> needed when CONFIG_NO_HZ_FULL is defined. tick_nohz_full_cpu() allows
> a specific CPU to be tested against the mask, and evaluates to false
> when CONFIG_NO_HZ_FULL is not defined.
> 
> The resctrl code needs to pick a CPU to run some work on, a new helper
> prefers housekeeping CPUs by examining the tick_nohz_full_mask. Hiding
> the declaration behind #ifdef CONFIG_NO_HZ_FULL forces all the users to
> be behind an ifdef too.
> 
> Move the tick_nohz_full_mask declaration, this lets callers drop the
> ifdef, and guard access to tick_nohz_full_mask with IS_ENABLED() or
> something like tick_nohz_full_cpu().
> 
> The definition does not need to be moved as any callers should be
> removed at compile time unless CONFIG_NO_HZ_FULL is defined.
> 
> CC: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Reinette Chatre <reinette.chatre@intel.com> # for resctrl dependency

Reinette
