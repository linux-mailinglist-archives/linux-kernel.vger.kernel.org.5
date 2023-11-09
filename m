Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA3F7E70B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjKIRrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344837AbjKIRrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:47:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC2C2D6A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699552019; x=1731088019;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0fBk3WgoNSYL4vw761J6yfSVHK8iHOGRpMa1TBWNXrY=;
  b=XlHxmUHBw0GubD/mgnCdtsFlc42KSF4PKrj0i3/WBOqMT5IWl5LtGm1w
   qYnSwUhYyfui+HDKCHobZIMdAoQ9kjRq/Lnz2/9FYg+LCsCLx+bp9wYtM
   O2zpFlquoOz6u/0+XPDJeoYBq9AlBdngpxhlWLAjsm+QHENs4iextRkFk
   S7TaKGUA1X+kYW5DAEclHRorIM5HpANBeckq2tVb3zRmdYHRUSQ2OX6Yt
   DXL2XfiK7G2tFUfwbGFDC1AYqIc8P1nMj/WQjyvfcyJjAWNj9QOkOXUW8
   tMTF2/y61KgpiOA7TM3MB/zijaCwPg/Ot6/hAitrDDhP6J0iqb5974ONs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="375076638"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="375076638"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:46:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="907208193"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="907208193"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 09:46:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:46:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 09:46:56 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 09:46:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMZd7HNso8Y/4V+CpsfNtQQHGbKlcADeqtYuKiGj9KuntNIqT8JF/I46AwtTSzj6K0tnHCYvkfZrFdpTZhEsHWL3HqGUwOkLFXSFs1YePD/cRmZXm1CNIUNd9Sc2rbLUL4dbzLFumHyBj/s+8K/XL7u5QRCTUitTwvVsL729f3n9NGb8dKj/UPVPX6zfaHJ3kxTc7RcoHcAR5Jd+btDuU4qpBXDtiB+PUa+rnf4FXVSBJZch4TD31gs1BaNk8aiSjl1D+Ichc/bVgvCAChes1MUKKDTEuF3J44jeD87X/5pRTOOCIRzRllWpLawB4OXdCBL6vhHuFoOVyf6b3vIcMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUJgyx7LaKfFffRZFI7FYAWzMA6e4gsFFcqmMYM+01E=;
 b=XqNqr7s43bxBxPhtIBtHwLI9atueS/yYWmFsJpCWdVVXF8icUQcHcLBT6+tEaWB34xfESPdiQNQR1dcSEeQJBRk38AUta2XP4VlCwtz3Fl0o1rb7FTOXLxYlGFEGkWwMKpbJGc8wTtWzwXRHX8Po0S1+d7ByUJEauv+VULQGcHINrDs+DEFW+idJMwVflwpJiARVQToR5taTDQrbd9gvRvztkQJPprTa2lr67m1Iel0AryHsWXsd+MTCaXKY/RvtC77rHhik8hAld8NP2lKaa5M2H39PzZ4fhMD9dvUnZSBKIrPc5Qc8+/eHqA8C176l1XZSuVtVpZCF3KN10tIlzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7303.namprd11.prod.outlook.com (2603:10b6:8:108::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 17:46:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 17:46:54 +0000
Message-ID: <cf8964cc-764b-4c06-98b5-45978578326c@intel.com>
Date:   Thu, 9 Nov 2023 09:46:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/24] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
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
 <20231025180345.28061-14-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231025180345.28061-14-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0199.namprd04.prod.outlook.com
 (2603:10b6:303:86::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 66901f5d-a451-44ec-5054-08dbe14bdcb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LV6jqVFwOV22YoPW08rs4sXzZCo+UeS6xhQYVWIlvv/RswBmgiInpCDBsADecTHmm58AtWcGogLpIQ7+SuiF94eA7oXpBcr14xgVtun0dWLGnutz58CAzd2IiVOSIrnz1r2V7I8Oj2XaMqUwFcnxM+DrqBH6Ruuxzs5aDvcjyiZM2OiK998xiZ13TPsbn5JvpmWNmmg1+G7qXnjNqp/FTYVXeVwK47nd1B8iblWXYvP9Z1hgdyjgP3+XwwDmEfh24DsqmifW2xyovdBS3ArAQECJPOTy3L+VuPATAlA/yyRizRiAPd3LUyUdz/w4qyjpXpVyIchZOmwm5BPTzdmCot2K/JadyojtACBlJhZlXvyokyaDjdWWPn8bK2B9h8izIe1JH7psdVvpCmykYb4qqSzLVlRWfJz2qhtjz7WtzCKPksnM1VJ/poqebsK8vhXgOZkDyBYRhXlgD6T1l+MxlnsrP5bYXXK/dGtJckRprTfhaO5WanrbZogkDiacM5oON/r4aw3MFDBiI7Q6xWc/5JPJos9zKZaCZCJlKfFfQviEcsJjzSRmZvtIuk/A/jpxCNkm9B0JRta3aNh7lJXIcyu8wfPwsc/oF4XvuGQno74WDf6VugRgBtScH8yBE13Ur3lRzL9Jzwt7YUHEaellwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6506007)(82960400001)(83380400001)(6512007)(53546011)(36756003)(26005)(2616005)(38100700002)(6486002)(478600001)(31686004)(66946007)(8936002)(8676002)(4326008)(31696002)(66556008)(66476007)(54906003)(316002)(86362001)(5660300002)(7416002)(2906002)(44832011)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2tHQ2lVSEFCMHJsQThsZElXZmI4NXF1U3FrOTlHVEVyVi9VZzJBK3RxZmNo?=
 =?utf-8?B?NGF0eWQ3bThBWUhybXVDbUJ0VFh0b1gvc0ExNTFFMTJTWEg4bVUxTzJxZmVV?=
 =?utf-8?B?T1Q2YmVTV0lMSURGSkFFazNZWnBNOHJzQW8xSFRkSlYrY1h3U1F5bjI5QnJZ?=
 =?utf-8?B?OUdkZmFGakJVWDNEOTZ0WEszamhpWHNIZlEwYWl1ZUg0a1UyN01JQU9BUStD?=
 =?utf-8?B?dzVVbFNCdDl2aEREa1FXSzU5ZFIrUStNK1VoM2pCaUFObHpIOVJZV1RKU0Fp?=
 =?utf-8?B?U2p0MFluQ1dNRnBkaWMrSTF2bnY4OU1kRVFmVXhqS2V3Y2lrTzcxaFlzazYz?=
 =?utf-8?B?eDBGaG1hNnpCVzU0OFJ3WDlUbHBsYkp0NG5vbUFLVVlqNU5wWXdFeTYxSVV3?=
 =?utf-8?B?aUtSTi90V2tYSENTQ21FYSt5bjNXWnEzclNNQzZ6OVVzMk9LUXNSOVprV1VX?=
 =?utf-8?B?QVJPWlJrMTQ2UkVHTVQ3OWpBN2ZxK0xQd29FL21lUWw0WjRvdjBkUXZwcVNX?=
 =?utf-8?B?UStnbTNMUVc5cW5TMEFlVkc5VVF4K01XeGlRb2FPejFIVEFmcVJQRmNvcVNP?=
 =?utf-8?B?ODhZaFRXOXB0Rmk2U0xqQmdYUUdGNzV6Q0FSaytRNkdRUzBKd0ZIMFVIUmJ0?=
 =?utf-8?B?Ym0xejVibCtvcjUzMGtjdk5peTJSS2Rla0VZbWZhRXhKdkhUdlc2emlBWVlq?=
 =?utf-8?B?aElkNlp5NDhjbnpyL1RYSXE0OUZNRHpHbFh5RUIyb1dyTVFTTUw4THNHSFI1?=
 =?utf-8?B?aG1VK3RkT0hQK25paWhONzh2RWZHekNuTEdQeW5LdThJMnJTaG5sUUNPcndH?=
 =?utf-8?B?aElzUmc0czVFTlR3N25nQTZvNEo3WXlUK2dpRGpiNkF1NWN5cElQZHJNYVFp?=
 =?utf-8?B?aFdGS2lQb0U3MEs0MG9HcUlHOUtreXVvY3MxZkRrNzVEYWJUc0E5eVh2Ty9L?=
 =?utf-8?B?aGdTMG9jY1dCSnpLeWszcXdnVDB3QzRyU2lHdmtvZExwK0VzUDN6bmRHbTZQ?=
 =?utf-8?B?ZDh6UmdWTzQxcnZXSUhWT2MxUXJJeWcrNVRidWtxL05PbUVJeUIvZnp0T2tX?=
 =?utf-8?B?eFI1cFIweE04KzFwZmh1YmxJdHRMNjhPSEtYL1NSdjB2UmRlbGVIRVo0RVEz?=
 =?utf-8?B?bSsxdS9FUUlOdERqT2FwMTlwS3VQZjhwNG5tQTh2NkxBNnA0TWFCMkVsL29X?=
 =?utf-8?B?UHVTVEpKbk5TWTJwUjFsVEZmYm1qWjJNU2JnSHdlVVJHN29ZTXg4cktSZzVP?=
 =?utf-8?B?VE4xL3FKNGt1TWVBZE5zczdHVlNjaHJQUlNPVzB2a2RUVE1udnpBcG9GVmZI?=
 =?utf-8?B?UFJzdFFJdTlFQm56TmZsU29JYXNtdEoxdEJZWldIWEI5UlA1RjhLQzdCb01W?=
 =?utf-8?B?Q2t5b0Npc1ZCall3aUtoL0pya3I0SUpWNWo1VmdneW44L0tGYWVrMG5WZHpt?=
 =?utf-8?B?WFkrTUJqazdLNm42QUNTZWFJNkNQNjRraW9oRHVjcTdUeVJVOE0vZUdmWVNk?=
 =?utf-8?B?OFhiRmFYSUxpSDA5aDRLMkNLdWd2LzVYeE9lOXdvcHA5UlY5QmVCUEkxR1VH?=
 =?utf-8?B?dS9UWE84cWxSVGE1RUhaVzJyVmdnUmo3VmlGVEhTTlNlYi8wNHRHS2xYajc5?=
 =?utf-8?B?NjdmNlBLOWc2MURrbExMMkhqYkJQT2RuS1dINllnSTlFSGYxeTFoMFJrVlpN?=
 =?utf-8?B?Zk5PdDROemd0a3ZSWkhsNW9kQmpwZVZ4UHk1ZjVkWmNtRkUyT0RIZ3FsVGVl?=
 =?utf-8?B?eFRBV29KYWhITG9mUUp3bkdvNmhrL2FvZTJkeTZWemswNUNzV1pHWmRNMFdZ?=
 =?utf-8?B?MTVVUHM1bzRJL1k1T01RaVhHKzFwQnlXc3NIRmJHSXorVm8vWmUwY09BZ1Ax?=
 =?utf-8?B?SlNuNWJNQityNjVOdUJuZzFYUzlOajBNUTI2RGgzaGpxNEdyVktvOUFjbTdG?=
 =?utf-8?B?RUhjTnFIVjVPYndzZW8xZDZhQzU2anJ0Q3NFcWxSR1haTVdkTWt3WENyS3h2?=
 =?utf-8?B?RFlXWE84OTJYT1I0eVRTRnlZY08vV2p3WEIyVFh6Sml0OVAwbVVqRkpEQkZm?=
 =?utf-8?B?bStVVzV0QmllT1FwWWQ3bmlVa25PeC9QalQ1RGVQRldRMGJVajNLMW8vNVgx?=
 =?utf-8?B?SmpwVkpTVU5ZbGE0UkU2OEh5QmpUVE45aUNtbC9MbUk0ZER6SEVVZUFEN3B2?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66901f5d-a451-44ec-5054-08dbe14bdcb1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:46:54.5574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arnPRXv1dbe0z4xzt726ma3iS2uDPuWPsFc5LuhZcAh25HL589jkOTD2+X7wm4Kt9hNKKmkFAzApRkCZDIBW3RDx/TjLCe+UujmSab4b2u0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7303
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/2023 11:03 AM, James Morse wrote:
> Intel is blessed with an abundance of monitors, one per RMID, that can be
> read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
> the number implemented is up to the manufacturer. This means when there are
> fewer monitors than needed, they need to be allocated and freed.
> 
> MPAM's CSU monitors are used to back the 'llc_occupancy' monitor file. The
> CSU counter is allowed to return 'not ready' for a small number of
> micro-seconds after programming. To allow one CSU hardware monitor to be
> used for multiple control or monitor groups, the CPU accessing the
> monitor needs to be able to block when configuring and reading the
> counter.
> 
> Worse, the domain may be broken up into slices, and the MMIO accesses
> for each slice may need performing from different CPUs.
> 
> These two details mean MPAMs monitor code needs to be able to sleep, and
> IPI another CPU in the domain to read from a resource that has been sliced.
> 
> mon_event_read() already invokes mon_event_count() via IPI, which means
> this isn't possible. On systems using nohz-full, some CPUs need to be
> interrupted to run kernel work as they otherwise stay in user-space
> running realtime workloads. Interrupting these CPUs should be avoided,
> and scheduling work on them may never complete.
> 
> Change mon_event_read() to pick a housekeeping CPU, (one that is not using
> nohz_full) and schedule mon_event_count() and wait. If all the CPUs
> in a domain are using nohz-full, then an IPI is used as the fallback.
> 
> This function is only used in response to a user-space filesystem request
> (not the timing sensitive overflow code).
> 
> This allows MPAM to hide the slice behaviour from resctrl, and to keep
> the monitor-allocation in monitor.c. When the IPI fallback is used on
> machines where MPAM needs to make an access on multiple CPUs, the counter
> read will always fail.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

