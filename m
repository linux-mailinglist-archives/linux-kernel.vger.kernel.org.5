Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80947E70B1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344788AbjKIRqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjKIRqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:46:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D61324A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699552005; x=1731088005;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qp2dwN6wZzJC1XektfjR/5Edb/YJP4CYUjpFR7MkF9E=;
  b=aOC4EbuhXpc08wmO+dbgg8sgqvfNTsw5sqX7U0xOi3F57kEEVMJSGm68
   MRq1JFzZGBFRll1IM+w90ewedvbRKwQ79GoDak/ZMfH+iwLAs/kXQXKR6
   pxoW/kIoILIQyGdujiwg28Iho64kLhHlx0+4oeiXxZqg74p+Xn4S4By14
   eI7VCJ/WUKab62aFWxnw7+OC9JZtcfyoH1rM4LQ8s18IXrREYDntqJWB5
   088e5iBzpaPU4M3AJHI/dY0T56vb6eAGVwvsO4T+RENMLsBMf1VkHFgoA
   FGkVMGCV//rPkwNbji62R+0PO8McyZiPGYtH/74ZJ1KxkCqJp6o3Sg1Vz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="8691346"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="8691346"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:46:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="792624218"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="792624218"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 09:46:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:46:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 09:46:44 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 09:46:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfzFIxSwPwY4N4y2dF36dFMCqeX6y9k6Z5dkjTOJllNNP7l+nWg6HL1iQvIOHdl9aqnSkb3DedBtA5D+/VbWlCBaS8UUVurGTU8u/LuU3m3wq87AkMfcUFlOYc3qzBmD6UfwwGLtTDQeaoZFUI8YgvflXr+08f/ClsPSFXYUIUhygSA1Ld+QtBdMMQAJcarFOgE+0HBDEB5R+Xj3WawopoQM4Mq2mOISdpCb0N6nIzJcWTbkOdfqowybVtJNcYIkOF0j6/kmLUERGPbVIe+KNN0yXi8VVAX0bIPIO6Pwoeo4vF98WilBsNtRqJ69eDwRPpqS0069swFrYhZhwtQ2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/sbEVZgTR7mvv9N9r+NIG/jAOsIGfObwkJk5yCFOdg=;
 b=XcRXwyum2n8O6lz6d2eqzp3YAkEDM87zGw1jdoRSwQ0+u9z2sQHrHJdNvJ2r+a3ZxnAkUl++gcB+6oYBFIYMB9v5tugHLik6FjOCTbCxmkokDyu9hiqvNBj1tjHNjlcJKOqvWvBY05Gov7J+VB6+rwy5ibZRiX5GM93vcUT3ffcQq8NuqvK5qMRD3O7VfZYWjXjuJgRoromzq6iDKqoGr4n7/sgOKLQqYrbj54Oe6Hm76uNXmU40H02uUo8Ygdx+RxT9bA+CC4eYr7mqOCmdVvBCE/Iq6d15bpotSAnFBp2LDQmAnzjQKbt5twnVbqcbsu5jehISOf/toi9pPsmbSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7303.namprd11.prod.outlook.com (2603:10b6:8:108::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 17:46:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 17:46:39 +0000
Message-ID: <9183b869-92ec-4da8-8d0b-4d8f6061d9d8@intel.com>
Date:   Thu, 9 Nov 2023 09:46:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/24] x86/resctrl: Add cpumask_any_housekeeping() for
 limbo/overflow
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
        <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-13-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231025180345.28061-13-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0199.namprd04.prod.outlook.com
 (2603:10b6:303:86::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a861147-bf22-4d79-c9ad-08dbe14bd390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sthiEjpufjD2lbiEbOrH15sgpeRYl1aqQpb1EjpTZ5AF5eAyh4kUb0xSOdgBXgFvf18Czkb+cJawh1wkDxw/DB8zNWkdfPMH0PHsVq4HwU+uKzQPZOTjJu4fXG0DzZ1gW8w4qbBHU5NnldkkZ0MZYdqMa7yntZ+P2faXlsOfkzfcMKyFliJzHiG38x0BgQIUWgYzBmkXGZqDc4UKHaSQVzmxi+3hC03FMt0iE7d9hbHp9PkLMLUl8GQr57SuhbhurRO+azapthc0woKgALMJ7cM2cndxX9CSPEzz6Q2LKBqFkHa+CxN2rcX255u8vb2xf0B6HacPbyXd7MNnTRfm8bsDq2AaU2LsWVk3SUbbmhyrV1g5AKbN7H31zzv/Jyz3mwAtMCWdC19PnuDIAmj9gyJvS5afXhO7N2e1nF9bwQah+JpbJ3iOQjb/bi3N3cFDqu/FhxPovYS+2yHZJbv0FD8pl+Z/89pOlbtjSOvSdDbJAtRzrrOtNzonXFdJKifp2ZpAIblHCnOWj55tHfO8/mKKPuMN7dEz9Ei0VtvdtXQGnA4Bjz91GrDFzfRMZlplsc315B8mOvj+gqmNQfTynBjPP2kQhlAJUcTb0aE7IDcI7cRvHhFvIfOzlOmL7QIAdf95wspBSBPIa5b7q4NysA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6506007)(82960400001)(83380400001)(6512007)(53546011)(36756003)(26005)(2616005)(38100700002)(6486002)(478600001)(31686004)(66946007)(8936002)(8676002)(4326008)(31696002)(66556008)(66476007)(54906003)(316002)(86362001)(5660300002)(7416002)(2906002)(44832011)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDlScTA1QWpRNlRvc1N3RHArOEpIckhWT3NaUmhGY28vSzE0MThLcFZodERn?=
 =?utf-8?B?KzFmcE1PSFZ1QlprRFpFMHRXQTdWRDdwc2g1TWE3YXlkWW9Ibk9sZi9YQlZW?=
 =?utf-8?B?ZmZkY05KZUY0M1EzNlpIWkZNaU5xci9vRzFqdkFhYytjNnNZTEdwa0ZKZEZy?=
 =?utf-8?B?WDZiMWZKLy9HZ01ZTFFiVks2T0RTL3pOME0vSjlKK3NPVlpEZzR4TWhLTElk?=
 =?utf-8?B?L1RtK0JseWhGZU51cjBRRFlmQ2Z4M0dpK0pNNzNiNGdnQkpPeTdUUW03R1p6?=
 =?utf-8?B?NkZjb01KRlU1eHN0a3BxRS85OFZyRW1GeHZKN0Jwc2h2REJNdml5WERmeXJa?=
 =?utf-8?B?cllEclI4YkZtSC9Ja3NFY1dJNWVVNnRiQ2Q0SDZpS01jbDRwMzd5SzB5RUNi?=
 =?utf-8?B?c2hvMnZNRk1NOVRHSE85UTFwdXBhUkJwaGxpSExFNEtFeWJKY2Z1aG9ZVi9E?=
 =?utf-8?B?TjNINzRpdHVoMUlkbzFBaE1TK1drZ29TUEVKM1JtK2tWYjh4amNNR3Q2U04v?=
 =?utf-8?B?dUJYUkw3TThjSHVsQVlGRithR2Y3ZUdESWxPUmNxYXpLOFFhUWFPUmdibjdY?=
 =?utf-8?B?a3hsRTJoOHAyVUMzeGszcHFaMlEyN3N2Tno3bW5ZMk5yaXdrYiswb0w5bUdD?=
 =?utf-8?B?bGkzSUhFdWJpU0o0QUJBV21qVy84ZFdmOXFaT3VHdFRmUC9TQzUzOENjN2gx?=
 =?utf-8?B?eVBZbUVESVFJQjg2UDQ5ang2cWVFQ2xqeWljLzcvK014QXkxWk9oOW12amo3?=
 =?utf-8?B?c255cmFXMjFTSllxOStTRWdtZDhmN2JXb0wrNWt3UlMyQi9KaXVjbEJNdU9C?=
 =?utf-8?B?VlFsUGlIQU9hb1FLWUoxSFVJazB2SzdNZFlKSEJMSngvRU9iTjdQdm94Rjhl?=
 =?utf-8?B?K0VpZzcrWlk4bUlIM2kxQlk4RlJYVjdRcnFJajlSYmE3cEt0c01Hb2NZOERw?=
 =?utf-8?B?aDhVeG8vYzVDMkhVWDU2TGhJVC9ubWhzN2p2VDY5TFVxbFNDVndFbnZORkZw?=
 =?utf-8?B?Zm1PZ2h2OEJXY0tDL2dUQUh3bnZabmxuWUR4OFVBZ0ltUTVhZjMyeXNWRzNR?=
 =?utf-8?B?b01hcVdoOW42TW9NNjJSSXJVb1Q5Nk9zV3dtc3dHVzI5QnArZkxYZ0Y2Z0Jv?=
 =?utf-8?B?Q09EakYvU0pTamRrcHlDU0JONFArc3k4SnJtQzVEZmh1S1hTSU1ieVNrK2JG?=
 =?utf-8?B?OFFjWEdyUDhvZG5UWThDcEFTM1phTnJqSGpUNnk0TVpDZExJc3VXTFpoRTZL?=
 =?utf-8?B?blRsbXNoaXRobG5NczBZZDZlNVZHRmNWWXBFQUhnQ0VDT3RzMmFvVHFxejZQ?=
 =?utf-8?B?WGNHM3NkTjEvYjlyZWJxcU9XVldyYlZJM2FhTTN6OG5TLzBCeFp1cWpIbGNs?=
 =?utf-8?B?RmlVdTRkWGpUdVlQa3AzMjBrVlduQ1Z2SHFqcVhsKzFyMW1WM0hqYnZCeXJO?=
 =?utf-8?B?bmgyZzJhYTQxWXpQckpVTlJBSkEwU1h2cDRFK0FMRjBsSllHVXZDSG8zQXZu?=
 =?utf-8?B?OUZzTEUyS29nbDhXaUFHUGVkVWd2ZVduL1l5OEpDZ1ZTMjNOVkkxMkVlNmN4?=
 =?utf-8?B?SWxVWjlZSE5JenF2R1o0ZEw1TGQzMWltbTJIZnZpZVo1RkJ6MjduQk0rV2NF?=
 =?utf-8?B?V011dzVjVytDMTRFQzBJSkJCazV2S05xMFdmdkd6RHZKRU1nbGVyNzJVUDRT?=
 =?utf-8?B?ekgvc3hadFhLOG05bHNjZUJmdTZQRWFUWHhTOHFOSUpSRXMrOGRteXVLa0U4?=
 =?utf-8?B?Yk5mSTdsZ0lYVTFsMTJiTEJvekxuREJ3NEoyVlBIb3NNM0pEenNKM091dzZ0?=
 =?utf-8?B?Z2VJNXFCNTlYaGZpR3pwbktydmFOazFtT1lwL0ZiY3BxWDI4eUtydFpQM3hR?=
 =?utf-8?B?V2JPbUJNcThFRVllTSs3eTFJVXZLRXFHRWRhZk5FRjdtMTVpZi9Zdk5RaFpO?=
 =?utf-8?B?RlBJbytGK3pzUUxoRklJWkk2Q0NzZVNXdTNKSU54c2pDejV0ZCtHSTJOV01M?=
 =?utf-8?B?bk5rQW9jeVpIdy83VFlaZjI0M0kzMnR6YkV3Q1lubW5JKytwUWVjZTVjK1JK?=
 =?utf-8?B?NE80dGJUUG5Ld3V3b3ZZbUZpRGFoMktUM29YcnBWWFFrR3ZWK3ZGZXg4SjNm?=
 =?utf-8?B?ajA3ZUFnRXJZRUlPZjlaTEYydm56ajVRc1BBRlRDNEUxU1lvRi9RT21Hdnhu?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a861147-bf22-4d79-c9ad-08dbe14bd390
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:46:39.2467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhTGu3vAM5BUsHH/NkfUFRCcNq8DM2BVUzeJzpwIkeSyCJDLDqIihHBCc6fgP3+oD6DhG24aAnrlgD4bsGHF4ZfARHkAcYKczs2kmdW1zZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7303
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/2023 11:03 AM, James Morse wrote:
> The limbo and overflow code picks a CPU to use from the domain's list
> of online CPUs. Work is then scheduled on these CPUs to maintain
> the limbo list and any counters that may overflow.
> 
> cpumask_any() may pick a CPU that is marked nohz_full, which will
> either penalise the work that CPU was dedicated to, or delay the
> processing of limbo list or counters that may overflow. Perhaps
> indefinitely. Delaying the overflow handling will skew the bandwidth
> values calculated by mba_sc, which expects to be called once a second.
> 
> Add cpumask_any_housekeeping() as a replacement for cpumask_any()
> that prefers housekeeping CPUs. This helper will still return
> a nohz_full CPU if that is the only option. The CPU to use is
> re-evaluated each time the limbo/overflow work runs. This ensures
> the work will move off a nohz_full CPU once a housekeeping CPU is
> available.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
