Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB6F7E3245
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 01:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjKGAdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 19:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjKGAdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 19:33:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA2310C0;
        Mon,  6 Nov 2023 16:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699317193; x=1730853193;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ediA1Oc4ARCQPWOiAkLpNiAnXnBMyuxD8fW3cL7PDMg=;
  b=dn51fKC9+gtdx5Oo3dtcHRFRdT0Mj8zZmykSGEjRmezRA6Ap8Zcqr2eE
   bGHBQ9+iLVJLyPYC0IAfZTuOHVGQrpugRK68eElzEp1ROiwvBb9+ix2O0
   2ABZWs3CmeHK9pgjU0hFGrEKEpAuOVNctni8pbBBppA+j9LLoK+r/0iZB
   JKsnwqzkR7BBoWFlNGqPsaebLOvvxIm3/uCGQoqCB0ARffI6/cxAU4XQf
   TSRDY8OAUl7bGLiNcn1K5b8VN2ROvmuBr+HhwIDsXwJNCE57nkqn7pXPW
   4IMQ8wSGkC6e3g/XEu6L320nb6G5gLZnfw4BcXx3wm9Ho7yRNOshCb5WC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="420507788"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="420507788"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 16:33:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="756010068"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="756010068"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 16:33:12 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 16:33:12 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 16:33:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 16:33:11 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 16:33:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cluKzjOm0GJdj2BOJDqOr17YA/Zyv/Rb5gZ4yrHeUTiXUzBceCuJ9+jlR6K4mCIOqbmaMJrjNGs+bdV1u96fVyx66HKv4TjUxjAYL7hGQAUEPy2debP2hWpNr1sM4du8MhQ37qM6j/m7VRuXS9x9Jj6QH7LG7TJclMc+gEz+8I8QDOIx+MJRleBmiGIfvB22zcY5csdaRHxnPvFR6VRKw/gOjTp7dqpIKCiUjnD/H4Fa9FmiqoPqiNrNDeOdVqULcmR+2PmSFm1dRk6Y5+/qIqkg9G8rHP1y4koTtq+XnGR2ZuNqFI3XSFxB3tK8/sJSjG0/0j8Txu1ZHN02oaDAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqstU7nQmngMo6izyZqtoM06Jxj2M3cnCWzCNNN9dCc=;
 b=VhCrkzaofR1GY2bIAkheNjNPUt6AXdP8n+qyxp8+qRwG8btbRM8iQSF3nWKkfaeQLjeGk6zBD4TwAFzYdjZNdSSUzTROdJJP3MsgwC0a+YzifJHdlrMjUpFgTYWeWAC8u4DlFCIQOKDF4YjhW5e8vBP9HHyqVeXb1nezwFfeIuj2lD3hwcDj+OGYW04CDo41qw1ZELgsMKdJVIzmj5wCtpE798ZmD1ionLAYgH2n+V2hSUE5RueURA2SaUOSn+gL/kLmafxtS78DEjf7aFPNiUc/L1dsF8isAZzS1hKm22fmmZDrPIrmXcpoeDlyvNox7Qy2QTSrwjubHuDvcLm9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB7614.namprd11.prod.outlook.com (2603:10b6:510:28f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 00:33:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 00:33:09 +0000
Message-ID: <7857bcde-effc-43ea-8df9-db79f6d396a3@intel.com>
Date:   Mon, 6 Nov 2023 16:33:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 7/8] x86/resctrl: Sub NUMA Cluster detection and
 enable
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Shuah Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20231020213100.123598-1-tony.luck@intel.com>
 <20231031211708.37390-1-tony.luck@intel.com>
 <20231031211708.37390-8-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231031211708.37390-8-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:303:b4::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 464adf32-be0e-4203-2881-08dbdf291dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSsnpFlKRqFg3Ac0Sx2WvEMSIs+/B4v6JpjSbKCN0yVn8UTX05mm7f7DiDBCiX8n0kaPFHj4Ly83tsHHdSQP3qYODCYrhWbnOIpUGRIVBZOMocXSLT86cvvO+BFh3XoJ1AA29Q8wYtEiTXN9MH4T2N6Z6RGKOmojwLlYdZ0m47NowaKpi/wE9d5ndQhpCLUUw6MpiDQfR4L0olbBfqLEQX8lSh2KHlAIc+ONksXGAsqBoWOijtZPjhrQ1II9LJ9kiKWzx4YJssqYpk0QoKBzn0NWxc6XksSvF1PVGFKdQpmUE/kdqZfyVmMOTeG13u378mTNd2T1t52GM1ohNtUNJBFII8kIVtfviGHf6pbYhgT1seXLPS88mA5F5qYWlb3IZKOWypeoG09dTLU4LqCnebknmHL+ljM/lTZ+JxrI4gY2Hq+mYx96tk0fHx9AlDVWW/33FMxyX88G8CdAIQRndaJPz5cYiebs9JIc2jKe2tKaoeLMWqnIYqyR4z46eNHE//OPiI+K+HtKuDdW7rCtypyacoQ6yGksC4M7C/AId/C2WZcN5JJsvSWb1sk4j+oQzpaX4BPNounMlhg9AdpEoJ06cijVMVMG/yUXm9cYoYmhaXStoNF+PeTMKwi++Yqqfyo6nh2zvYhCNMcq1enztA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(6512007)(6506007)(6486002)(478600001)(2616005)(53546011)(2906002)(41300700001)(38100700002)(36756003)(86362001)(82960400001)(31696002)(5660300002)(54906003)(66556008)(66476007)(83380400001)(66946007)(26005)(7416002)(8936002)(44832011)(110136005)(8676002)(316002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUxmWEdIOGYrUmtjdXpudXEwRWN3NnRIZlIxZGJaNnZzWlZtZEZ5YyttYkRQ?=
 =?utf-8?B?VGIvTGdpN2FZRWtwbitvMmk5YXV2VWo3TVAzVk5qNFlaNWIySmhQdXI2Rlls?=
 =?utf-8?B?eGZtWnR5YTZFVEF0ejdmcHY3YXhqSTdUWFlOYzEvM25UK3hxUEdQaHVHWXNz?=
 =?utf-8?B?cFV0SXlZNGdHSWNNSERWTzBXWWdScmJXT3g5NjFHN0duKzZZZ0dWSmZjTnAy?=
 =?utf-8?B?dTVzVUpFNUxjQWpoMlliOC9sbFlvdFB6Tnhka0k2QVlDWHMyODdQZHZXdGZP?=
 =?utf-8?B?YVoxNGhoam5ubjcxYklmNjExWm1xZUhMczZLZmcySExWbWFuZmdnNnh6VzNk?=
 =?utf-8?B?UjhtRXo3ZEVYZ1grRm9WSGZubEJHSVJQUHdHYmtjNHFrM0Y0VGNLRG11RFJt?=
 =?utf-8?B?ZWppV0cySjdjZkRLSXFQZm1keTJSRFRzT2FWemluaGI0SG5nVGdmNDk3akd2?=
 =?utf-8?B?OFBVRkEzQXJOWkhGbFBZZ1NXeGs0d1NlbVNjdlZoek1lbC9WcHV4RzNVa2xp?=
 =?utf-8?B?Q0RmM2RSK3FBNDhkNUx5R1hOY0NIaWFYc2xhTWpwaWpRTTUyTk44ZGJDUGhq?=
 =?utf-8?B?bDBUdDZkcEZ0ckQ5WnRKTklRYkxwMHNIQjkveDczUTJ6YnVmZDRqRkwyaEow?=
 =?utf-8?B?cWtwK2NUWmcxcTBSbUpTRlBlRGxCTlc5V2FDLzNpemVWZkluYkhDeUNIZldC?=
 =?utf-8?B?UzE4MDlkNXhqVzg2RjE4OVJhZGlqV0cxZUdKVUlWR0NQWFhOR3FWZi9Nem53?=
 =?utf-8?B?U1dqMEZxamswTGVOZzlwTi9uSGU0Y3NpVHZyWDJyY240WUtlMUdzSExCSW5h?=
 =?utf-8?B?UWZWZ3FIK3o3UXZxeFVvVnBtWU1YUksvNGFKNElDNVdPQ1Izazk2d09BMGJu?=
 =?utf-8?B?QUU1cGRUSFkxZ1pQRlYzY2dVYTgzMnVxZUVlaHBjNW9ZOWtBU3BXMXlKMVJ1?=
 =?utf-8?B?anNXUFA3UFVLUHdidjkrR0JQVkpYMVpJWjlYUkFzU0NXcHY2VEcwYmhqRzBh?=
 =?utf-8?B?bmtyMXZuTFFoYitRUlRldW5ZbUlHMWxYRW5CaE9vdk42T0tySmxmMG4xcWg4?=
 =?utf-8?B?bXF5cmdvaEpnallJTllVU0hmaGJ6aVhQNm1uTlB2MXVjUDBibTNFR0dGOUFP?=
 =?utf-8?B?R1RhNmFiMmdvQlc4OGswNktKWWR1eGtGNXZQL2RadjVMM29Qb3RudzhRaG82?=
 =?utf-8?B?U1MwQmFKempoZmt2RVlZTnpoeEZ6KzNia0NKVGp4ZngrV2lYam5Ga3FQc2dH?=
 =?utf-8?B?c09tOVZZYVhqUkxSYUdPbXhFVCsreUJOdXJ1UHJpdTBsaTNmbTM0NWkrdmpP?=
 =?utf-8?B?dmNqT041SjRsd3hLTkZMQXkwTm5zQ3Q4TVZaQWErUExWY3AwR2NrT2ZnTDFn?=
 =?utf-8?B?eUwrM21MdkZacGhSYnZjazY4WkJRdkthc3p3bkxtOW5ZUUdzR0FEeC9XYzU1?=
 =?utf-8?B?ZjV6d2tOUjZIZi9ub2FCajE1U25XYlEzTGVWZ09rNWlJeXJya2psSFhwcWRE?=
 =?utf-8?B?em5NeGdpQU1CUjMvUG1GMVNqRm1GejE0bWpuOS9TYVlpaWFFTnhMTmhOTjZV?=
 =?utf-8?B?dVV0Wjh0aFk4Vk9Ic3R5V2JyUXJPdG42akVsSlNJNnZqdG4vSk1NTmc0OGdV?=
 =?utf-8?B?TXhNaHgrZXJweE1mNE5ZY3BVdDllaHNUYkVzMUFXUHA1QUlsL0hNbjZ0OWF2?=
 =?utf-8?B?Mm5CcVRMQjJOVEhPcmRoUERHdG9UYzZhYUwvaXZ3MU1hUm9zV3dCdUhRelBt?=
 =?utf-8?B?Qm04ZmhjbXE4SU5ZYlk2TlNTRW42WUVMSmZndVlrdnBPL0ZLWWc1MllyVHVz?=
 =?utf-8?B?dmFaZVlTdWJKWmdrNVdBS0FlZmRiNy91TkpVa1djdWQzRzhVNVgrSmtCR0Fk?=
 =?utf-8?B?dS9OZWNOZ0Q5OXB1SS9uUzYrR2owRFoxWWtQb2NFQm1FdTJIb0NwaWhqWmln?=
 =?utf-8?B?bHR0SmxKNE5YS1QwbEQxY0JUSVpiYVBKYVludDJiV0NaS3EwWEhBKzFlVTNs?=
 =?utf-8?B?YW0zVmFJSy9KWjBQTzBWTUxtWXN0bS82RUJkYmROdmY4Q0YrZng1K1NFQzUy?=
 =?utf-8?B?cEtKZ2xFSnlaaDVqdGhBWXZERUVBU1YxcmJadnhKeXVzbzNMSVgzd1lIbCt5?=
 =?utf-8?B?dHZuTDZDTTFxMHFNbGc0SkZld2pWanV1VHVHcFYzMGhTWFhKaWYwSG1Id05R?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 464adf32-be0e-4203-2881-08dbdf291dd4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 00:33:09.1444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1J9uovwluOHyZMLKnw0I0eZ3O7WwJe1uGfjTCr5VYYcptdwRHFvVLShBHgTewUtce68Yz+7EOjqx7PaiduGqEUMbJZRpT07vqtv+nO+MM2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7614
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/31/2023 2:17 PM, Tony Luck wrote:
> There isn't a simple hardware bit that indicates whether a CPU is
> running in Sub NUMA Cluster (SNC) mode. Infer the state by comparing
> the ratio of NUMA nodes to L3 cache instances.
> 
> When SNC mode is detected, reconfigure the RMID counters by updating
> the MSR_RMID_SNC_CONFIG MSR on each socket as CPUs are seen.
> 
> Clearing bit zero of the MSR divides the RMIDs and renumbers the ones
> on the second SNC node to start from zero.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes since v9
> Expand h/w to hardware (commit and code comments)
> Remove "earlier commit" reference
> s/counnter/counter/
> Check for offline CPUs and warn user SNC detection may be broken.
> 
>  arch/x86/include/asm/msr-index.h   |   1 +
>  arch/x86/kernel/cpu/resctrl/core.c | 100 ++++++++++++++++++++++++++++-
>  2 files changed, 99 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index e3fa9cecd599..4285a5ee81fe 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1109,6 +1109,7 @@
>  #define MSR_IA32_QM_CTR			0xc8e
>  #define MSR_IA32_PQR_ASSOC		0xc8f
>  #define MSR_IA32_L3_CBM_BASE		0xc90
> +#define MSR_RMID_SNC_CONFIG		0xca0
>  #define MSR_IA32_L2_CBM_BASE		0xd10
>  #define MSR_IA32_MBA_THRTL_BASE		0xd50
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 97d2a5a7dd41..034f9797e1fb 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -16,11 +16,14 @@
>  
>  #define pr_fmt(fmt)	"resctrl: " fmt
>  
> +#include <linux/cpu.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/mod_devicetable.h>
>  
> +#include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #include <asm/resctrl.h>
>  #include "internal.h"
> @@ -184,10 +187,10 @@ bool is_mba_sc(struct rdt_resource *r)
>  
>  /*
>   * rdt_get_mb_table() - get a mapping of bandwidth(b/w) percentage values
> - * exposed to user interface and the h/w understandable delay values.
> + * exposed to user interface and the hardware understandable delay values.
>   *
>   * The non-linear delay values have the granularity of power of two
> - * and also the h/w does not guarantee a curve for configured delay
> + * and also the hardware does not guarantee a curve for configured delay
>   * values vs. actual b/w enforced.
>   * Hence we need a mapping that is pre calibrated so the user can
>   * express the memory b/w as a percentage value.

This seems out of place here. If you want to make such a global change
it can be done as a separate patch. For this work it can just consistently
use "hardware" in own areas changed.

Reinette
