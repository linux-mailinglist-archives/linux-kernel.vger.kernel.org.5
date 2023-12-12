Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF7B80F5E5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376873AbjLLS72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376678AbjLLS70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:59:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C109DB;
        Tue, 12 Dec 2023 10:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702407572; x=1733943572;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AAHvt7i8Qk1Ihl9Q43MEZoNtXmyDI5nYhoTSbhJpa1A=;
  b=fIfjZSJLkCBlRREYIcnEJdZpaYSeq5uBb77/yTUa7o9xtUJ9GBlGzqV2
   omhC/I5/oTNXzfozw0A1+knY1Dmi0TqF3CgTGMVq74q+AgCsAxhTXogJb
   3RL2jJnA3WYtQxap7DThfLVpjbOyyEF8yfkoo2mrPA3L0F+G4PdAa63yx
   AkAVseUeADBMyNePi1Lkr2r7egZZGJqeoxs1EsoBMLrTHmcTwjPUkbv//
   Ned4OUVBvbF6XM0RptYqZ/ikqC85yxNEO2qDDM9W14Edme9MK2p8EBywd
   Q3AUQdAXjtLXPr7aCQKwwsmD4dkdF2PJPTWU5ZugxXWk4TXId0iTllv6t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8218421"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="8218421"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 10:59:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="917382958"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="917382958"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 10:59:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 10:59:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 10:59:29 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 10:59:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBiqpG8GWt/mdJDC9Y/cBqaZgGElOjMffnJmNISlLjUq9TuVbXad+EWuuTMle9oTcQcnXHFanmIayr3+fff0n7ppYssGK/dDJIoHeAN8WYKkgPJaYy7qCH1Cr+JS+tKfGeCaiyB+9Ltarcd84zlsyoW9/R3BQeX7TSxHPlaEv2ELr1QDbgj+f+9gDq93UM1mWXEpKcn9oBL5n0EsL5ZngcxXtk7YGtg2Y/EYOypu3wZntRbPFDls/Mui0zUKdjE/G4Sv8dICney/EvguMewTf3X1hXd6xiw67BUJYZinzE019xfXmETCr6vxN8Pa7wxe8yppIb6nvsLHQPz384bDRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2RVoeclIc3TsEE6EsLWuSSg/V9hSJVRi/DsqNJ5+vE=;
 b=bpOcUbezzL1Y852Nyhl7ef+kYGT9Q8gGhJSSVT5oNMG+snzYvSb/qq8qspxPCnplo+/Acxhn6JvZmBNgW36R3148o/k20zay61YCWE9+cAs+YmNl4wo5LGObNXYTjQSDKZp30RuG4Uxr6uMBOKbPYfRWyWloSpoholvRmd4n6ILicoxoAyjFY/kSBaXzIyjVldsHx06firdRTGGfgYCclZbxjtY3up0dzajsuyKezyaeQiyVbfkfXlHv801FCaF6BR4+U6uvhY3ZKCYfRqEH4jeQMhKR5Hgp21lTkE38QDqEh2Zzv1cPoefJChfXaHJHcxfDIHuWcuUcQGb7nDyuXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 18:59:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Tue, 12 Dec 2023
 18:59:22 +0000
Message-ID: <53c6b75e-836e-45ba-8d16-017f907c3c3b@intel.com>
Date:   Tue, 12 Dec 2023 10:59:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] x86/resctrl: Add mount option "mba_MBps_event"
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20231207195613.153980-1-tony.luck@intel.com>
 <20231207195613.153980-2-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231207195613.153980-2-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:303:6a::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be7b280-fce5-4847-e68b-08dbfb44740d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dq1P3m4SGe92tPG2mDXM7NuE73CdM9OZXGE9YBUfkG/CDDhK1Hz7M80WHGc5JFmbPWBUQr4KpunR5m0NDYzzip0bUX7oXJXhH+r24FcDlV5Wm+22lDgy+bi5mC7NNjlnJxxmE6eNJyH4oL14OloVwuk2uK6RG/b6Q8A4ccuKXKyg+pH20eERC5DeFLIysSZohQcFYWs5+a489rrWMx4VxntQjYt+WC+WxZ+OsU1Fp/2Zr3kaCxOjZCkQBSwgseiNvF81zV8ahx+RMZmv/RdA4dqOaLK5Wb71WGdkuVVBttY0fa6QKovXvXEdooyZCJXGOx6ETGhVv1trNf1PorF8Dz4m7S9gzzpLB3ncX3s//Ftl5EDznNcGnAgKPco7aDdeBd1dg6YHE+oUCY7Ir1Hc+2t+5HSfiyLWx9L9xg4J9/A8EBxew1VTgB74ZIVKJXEH+1kBkZvXMf2m1MWfW8fl5M3AWk/5KF0KDmp8h4lJKgHFQ2Ny52RTP9TXhez7TWalXEllZqzuwj5qccdZmRd3WDtm/33UeUkkpUO+zf7Y4MpDyhYG+m80c/ZGAhsE8SkPTMrzr0xckVGiagVWpdkCKJjy5IgN766dPPnkb7huyvCIrmCsJU4p0RKKohS9hvRMqYeBrNBY4r8Drtx/rItmNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(4744005)(7416002)(41300700001)(38100700002)(31696002)(82960400001)(110136005)(36756003)(86362001)(2616005)(6486002)(26005)(83380400001)(53546011)(6506007)(478600001)(6512007)(44832011)(54906003)(4326008)(5660300002)(316002)(8936002)(66556008)(66476007)(66946007)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE43ZmYxOUJKNEs5SDdlZE5nc2FtMXJtQ1VHdXVnL1R1bDhKTkVuOXFXZmVM?=
 =?utf-8?B?TzVzb0JVTXBPUGt3cmZCd0E5c2tlbXFkb1NCU2ZDR2x4bEUvNUdady9WMks0?=
 =?utf-8?B?RXJwQ0c2N090VFV5QjFCdUxVeTJDS3cxSHd0U0hJdGQ5VlV0RmFsQTNmYWdq?=
 =?utf-8?B?WWlqVUtmRWFTQkNacXRhNlpiRlRqVFk2azFEQml4aFhYYmhOMWZxc0t2NmhD?=
 =?utf-8?B?emtuT3FqemRnNkp5dnNnRkdUUlYwbisvd1FzbVNLQkNOWDQwdjVpcHZ6OTNl?=
 =?utf-8?B?RklraGpuaGlHKzA1Y25qYkwzd1RrdkFLNE9IZ0IyY0pvblZNR0pjWWVtTmRw?=
 =?utf-8?B?SDM2Ni9EN3I2K2h2NGFNTHNPY0xyZVM3UWsxa2RkTHNzS0pWb0M2ZHJ3YU1w?=
 =?utf-8?B?T1lBSVFxR0Qya2t1YU0rRm5hc28xbkNTWGUxUVMzRDRSUmN1SGs4UnRLcUVq?=
 =?utf-8?B?LzY5cmtCZkU5Vno3WjdkeW1LT0dmRTdZZnE2WnlPUDFyYmlIQUpFcFlJTmNP?=
 =?utf-8?B?MnlnUmxlbUIyT2VpWFFXVW9QSVpVMEVSQkVnNjZpMUN2UzYxeHF1WGZwQjg5?=
 =?utf-8?B?VUtnSGY1OHY3KzQxRS8xd3hDQ0lIbGw3V3NlNFplcTBKQ0FZc001N01lOUdH?=
 =?utf-8?B?TFVHQ09uRE42ODlEay90YUtFUW9mUGNaZ0Ixb2R6UndFSmZIWGM2emlYNE90?=
 =?utf-8?B?S0FNYTZNTUZQR0s4OTNKVkhMRnl1WjlQYU1UNDl4Mmh3aUNndjdvTElOaHBT?=
 =?utf-8?B?Mmx3bjUwMDhoQmdFN2l2aFVwRnVyUjk4dlp1ak1vWndJcWM5Q1JVWW9RT0E4?=
 =?utf-8?B?blpWQ0dzOHJ4NURyYXdxQldCSEpEQ0hlNEVOeVgrK1Y1Mm1BTUliR21venoy?=
 =?utf-8?B?MDNlUEd4Tk1uQ2t1K3FNRW5QOHJZd21CSTUyTUExZkVESFVrdmZPbGxxWThE?=
 =?utf-8?B?RGdBUVByYlhZYUFWY2lLTUJBZXh3ZzQ0aU50b05vWjhBM3g3aGZNTGdlU3ZE?=
 =?utf-8?B?SU1XSHBSb29LVEJwcERGbUZ5dlRNQk9DSDdoYmlkMVRtdnpvU2ZCY0p2cUxu?=
 =?utf-8?B?UGtySVN5WVlLQzRsZGN4N2ZtSndCeVJ3RTFSVGRrYUJpR2s3U3Z2K2FxUGgx?=
 =?utf-8?B?d3gyOW5sRGdyTnFaM3hMbkwwcEJyK0VWd2lXWC9QbjRSTjk4SHBDbTU3VlBv?=
 =?utf-8?B?WTQvamxkRWRHMnJoVkVVYkRybEhCUHFVemZUZEkrbmF5Zzk3emlNUWxseXFy?=
 =?utf-8?B?OVhTeVRvRUgyWnJVWTdFcGxvUXZoNnM3ZUZVUVpxZmNFZ3B1MlJ6QkM4UFZ1?=
 =?utf-8?B?dlJQZlZ6VlQweGhFUzR3eGdZdWdjYTV6aDNiMWxCdmFXaUtsT2JlNEFaazRQ?=
 =?utf-8?B?Wll1c0E2S04vY3Z6bHJpVmZuZm5vSC96eGVuMlJyYjdXT3ZYdFljK1ZiS1Q5?=
 =?utf-8?B?NkJYYjFRdUtzMHJuUC84YTNpeFk3V2pwM0xLVUpTa1Q2MXBac3dDa20ydWQx?=
 =?utf-8?B?cUY0SEhxb2NBMWFXSXVBdjJhT2o0VDhEYTJ3Z3VDczhQTndGZk9VK0phSUdW?=
 =?utf-8?B?OFhvVHR3enBqT3JCbWxFWGVYSFZLRWRVUHYwdjl0Ui9vTUlRbWJQNWdvTXJJ?=
 =?utf-8?B?UGh2N2xYQ3FpRnNBbFF4NFZXNE9ZdHMrTkJnVktCL04wM0RUWEZ3UnRjNGpt?=
 =?utf-8?B?eVJrTFU0aEtxVGZZT3BxR0VYODFja1hiMzBBcUdpdG13VGthVDhIYXF0clMw?=
 =?utf-8?B?YzRqSXd1K2RpWlRQRHZUV3oyVTlTU242Z0E2TXJHbjZyN0FtYU04WmxKYWk3?=
 =?utf-8?B?WUNlSUJyME10cWh4RGJPdVZoZ0RENzVZZjh1WTZCMCtwRndNUzFteWM0RDlp?=
 =?utf-8?B?eC9IVUpRSlFMcWNMM1R6aVRCN096NjFOcTRMWEFQazlpNWk1WHZ6a1J0RGwx?=
 =?utf-8?B?bENxWnRzcUp1YnpBdGxJdGk4bUs2U1JDTUlaSGhlNUdyRmM0WUs5MDFyV2RR?=
 =?utf-8?B?cGI5RTF3bmlxOFdIb3J2ZGdLOENmMkVTQVpUcVh0RFlyWTA0MHluM2dMOVQ1?=
 =?utf-8?B?NmhoVjN5UFhQTThjU0pzZ3RMSzdac0RMSHdYM0lXTGFYZVdFM25IWHhVVlBN?=
 =?utf-8?B?Z1EvM1BsQnoveUU0QW5TVjJEYjZ6MWdsMWxFYXU0a0lSYmpweWhPbGF3NU95?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be7b280-fce5-4847-e68b-08dbfb44740d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 18:59:22.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aVcX+L3fq4DAGP4E73iPsxqYwU6CHixfJKc4k7YPAPxbiRBXAyFcCGWpj40jGQid8R9//k0b+FLUBUQr6j4jxkFijJV1kRTR0J5g6vcdl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5963
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

I'm just adding a few minor comments to the bigger items already
mentioned ...

On 12/7/2023 11:56 AM, Tony Luck wrote:

...
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 66942d7fba7f..1feb3b2e64fa 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -129,6 +129,7 @@ enum membw_throttle_mode {
>   * @throttle_mode:	Bandwidth throttling mode when threads request
>   *			different memory bandwidths
>   * @mba_sc:		True if MBA software controller(mba_sc) is enabled
> + * @mba_mbps_event:	Event (local or total) for mba_sc

This is quite cryptic and does not add more than the variable name and type.
One example could be:
	"Monitoring event guiding feedback loop when @mba_sc is true."

Please feel free to improve.

...

> @@ -3780,16 +3806,27 @@ static int rdtgroup_rename(struct kernfs_node *kn,
>  	return ret;
>  }
>  
> +static char *mba_sc_event_opt_name(struct rdt_resource *r)

This can be "const char *".

Reinette
