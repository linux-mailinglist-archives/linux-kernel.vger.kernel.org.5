Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA0C77D656
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbjHOWnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240468AbjHOWnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:43:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8018FE74;
        Tue, 15 Aug 2023 15:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692139422; x=1723675422;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/BXHH9yEi5qB2wC5D/IFMz/OhVX6QWb39FGXaME9wU0=;
  b=bAxrGkvaeuQcD90J5bcY/OAaHUoiYAgbTot2iDRgYW4MgAShxyquDbdR
   28dCJFeLMZu1pP9VOcSwx+nuwr0yd17QivLVJasfOkVYz2rzATYB1thuu
   RoCW8gzxn0DY3cq/n1Iv5TTXfs/FZcxAXz9i/WPwVsGYPNY5A0VaMJnZW
   7QFnz3pT+R+xdL7FKi8R7ayLg6Ox5piWL9ZX8ib9BAPFrSzZbiY6VyfWt
   LR6rW/HheFApoD8YzBXC3wOmAUcy1HdWiUEBPucIzC8VD2EF0rRRCrq+q
   rf0g0WVS5cvw+Y5IZa0ZJOqFue5JrJR2pYn9465IwCdHni64S/sHF9cTT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357372429"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="357372429"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 15:43:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="803982503"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="803982503"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 15 Aug 2023 15:43:39 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 15:43:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 15:43:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 15:43:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQW1lmsAVAT49pWZgyb6ezMqbg07wiJknP5enBwWxSpsyzyWv/KmieH8TuelSmv88doPPfc3STsXVIiHNGhQ8kf8eq2ZB1JIrhurr0Jg1FPmJ27qPuinDtQfxSE4oi8oBKbbfhr/eH5wKMPD1DgZJEbTUJPmG/gLvCcb+n62RJhhYpT6fiHEUrq1LxIDafEdgySGZVpKSvFkxdqmhMixl85fy6VZnUO4N6MQHktqWN5rz5eAmQD69Y/pw6w/sjUJ54gglguR6aD4mu1V/WqI/ryXi7Pfc96j1H9tUl4EbWkqsaiIJqgzDpBAQdEq2T8XahPd6eT1rzhbqHSm0sUuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raX9bQyizkayEKDIOQj8H8iqu/vfDmc63Cnw7Ci7Vk8=;
 b=NVTeyxJltzaJ1Q8LpH6KY1lYFzNi0FdH75oDgXmwwpn4h0jZDxyRpfATYbvl/5i1e+M0kFB16603KubJu+8okJwNZS4h05rilSSQMaeCsj4Zsgt3Wi6cmKa811Lf95sfOgm9M6oLZ9BuZsVlUFcyHnFHe14xgQ4k8+6sT3k1uwk6ciiRCRcyEEXopJi2jfSxQcQRnG+JSOdQr4AZpmW8Ifvde2A6bsW9BbJDAmRGx6qT4//wYj7lvAKTxNFomTu44sGXTqsgQ9Ax+4H7r6qIHJsh+aT5x6Porks9IDt4QE9xIBGx2vIB1NhfQ558c79GZJaYMIb7dn4X+lwWkb9Khw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7804.namprd11.prod.outlook.com (2603:10b6:8:f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 22:43:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 22:43:36 +0000
Message-ID: <9d180d2b-f786-bb6b-cb95-f7ad9528b5d0@intel.com>
Date:   Tue, 15 Aug 2023 15:43:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v7 1/8] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178449820.1147205.3688106607892992826.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <169178449820.1147205.3688106607892992826.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:303:8e::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: ee78c464-1305-49ac-9de9-08db9de10f57
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MWit26q+JfX1FD8WeMdGhYK2xmeR4YWWgLTtZzxIKTaCCL/KyNcdSQS4vNOU/33UPAw7ltPQ5JvjAttodOMEVhVbcK6euxy/Jn0Je3ueuC8DbPvmbHrBL/e1R7orjiYNf3AG6kh1lAojqGDYynzkUeeL8C7v8YWWJHDd5JXPtqilWTzcxT18Uy6l29h9auiyz7jlZPu+9ot3sosNf4sh/ikYKGclo9AZSVbWlD29zaoB6iGF8eJU5IZgLZDyOyJ9y8YdMhZlcy//76eyFlowI1GhkuhvTPBJSUNGEXmW58CIX1HUtpEFvx8djULsd6mWydPhxiUh3LJiZXLBD8ESS/m/2yE3dVc3iJhscmnDGunPppHzVSq4Js8Wkkx5UYMUTx3ETXqcBmRhxpO9q7ySa/VBNAbJj6lXPT4beEwVBYLRZM6/KrIw8wYjJNu4Oi5YZP4nPoZYNP7mcznTDTInZ9SfzxBZPzIZnrP0CpddDIB3E1C9q0JiDNmDAqt1PJJn0cJJ+35cOyx93Xv2dPRZNh01bfW02vyYgptqFQXp3kqqkqXlthXThfTaI6va7jAPeZR0ild2yAqMTucq4qaWCgkGMXlTioSzGdtPeGgV/HEMF/A4iaknckE80gQDBYovWWSFFRQUC03IVoYHMAj+LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199024)(186009)(1800799009)(66899024)(31686004)(478600001)(6666004)(86362001)(66556008)(316002)(36756003)(66476007)(66946007)(4326008)(31696002)(2616005)(7416002)(7406005)(41300700001)(82960400001)(8936002)(8676002)(26005)(38100700002)(6512007)(6486002)(6506007)(53546011)(2906002)(4744005)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWh0K2xTZlJLK2tzRUdDRTlGcnhjMk15ZWEzMEYzYmR0Um9CcmhZOE05LzVC?=
 =?utf-8?B?d0htS24yeTl6RVJ3WndxRVMvUTNqdVI0L205OHhGTHhVNEtQUUE5VnZmNk1m?=
 =?utf-8?B?OXNQYkM1cHpabzVnVUhPOElhck1kUGFBanpkN1NOSVE5QUN0Vnd1ZTh0N1FF?=
 =?utf-8?B?UHlrT3RNUFBkU3RVK0NLVDkwMjdjZ2ZTK2sxd0xRdjdBT0V5QkRWN1dZTlN5?=
 =?utf-8?B?MGNIR3ZFTERhTVQ3MWtTU1BDUXZaaHkyVFhqSGhWbUtUR3NpbzNpR2ZhVFpw?=
 =?utf-8?B?aDFXTWw4VEZDdzF3NkFmVHl0dkc1STQ1UFZPTS9SK2tqQ21MTmlaNVdFcE5Q?=
 =?utf-8?B?UFFEaHNOdUNJOUVHbFNuUFBZWnRiTnNZb2xIaDZDUmU5eTlMZ1pzY0ROU01W?=
 =?utf-8?B?QlpMYUJBSEtPMW53eisyR2FhKzBwUk1iaGIzVmFVWDNKOFVVZWNMcnpzNUc3?=
 =?utf-8?B?VUlEanlEVUpnbkM4ZnlLellRNXRvK2djeWpBNWtZM0xZOG5YS2trL0xkUlJX?=
 =?utf-8?B?T3lXNDlPb0plNkVnQ1cwKzRQMkUzKy9OTG8wZGdlcXdTYWxLcHZWL0prcklR?=
 =?utf-8?B?bWNYRXdJWitQZzJHdnVYU2xhTkIvUHZiUTJXbWkyVWgzSFNNdGpqSkdTYzZy?=
 =?utf-8?B?T3NIYi9hV3l5NFFkOUNFalVSSE45MlpZd0F4SGJtaVFLVERlVTRtcUplbFFM?=
 =?utf-8?B?ZjVzUjJvN3lTUC9EZ2FrTVBsQ1NPOEpPcFhCUTlSOE91OUdYV2t1bWN0RGl1?=
 =?utf-8?B?NDdiZUFWTnhzZTdvYjJFYzllYm5ZRE5xbTljQW9QNnp5NkRucG5GQ1hEUm9Q?=
 =?utf-8?B?NWhPSU14NTJPT3NqZ2QxVTFyVTB6RzZxUFRuN0c3R1Z3aHIreWg5MXRHdDVN?=
 =?utf-8?B?RC9uOG5yWXNSN2luSzlGd2lmc3RmKzdETVdLZzMrU3BuRjR5VGcxcjlwR1lW?=
 =?utf-8?B?YkU0TTU4RlVRZEd6aURIRk54TWswYUxMVHZPYzAyNGhTRkJYZzN1MGJUaGNj?=
 =?utf-8?B?R2ZBT3VEcGJJT3ZpbzV5WnRyQ1JGMzc1SGlpeW54ZUdTNDRjcUEyVjIvYi93?=
 =?utf-8?B?UjJSQWZGVVR0amp3ZUpjOVU4Q1M2YzRMbGVoUnhQVWdqTHJ5NXBoSnBQejV5?=
 =?utf-8?B?SXg4KzlpQXAwV29MOWZXQ2ovWFJ1M0dNRTJ2aWNndCtUYjJiWGlTRTk5c3Yv?=
 =?utf-8?B?RnZMbnJDR3hqNUpuYlNaRDlBQldWZm9MVnozSU5vNGRLOHJhR0tkVks5OHBi?=
 =?utf-8?B?VlVxeSs4WDM1bGE0eEZqV1ZhbEJRVFR0eG1sUG0rcVZKTVdHdWVzcXM2ck04?=
 =?utf-8?B?UExMaWdnTVBuYUhoNU53U2J0ZmJpV0NTUTBBbENwV212NVlvKzBUT1lhNmYw?=
 =?utf-8?B?a1QwZTlCVFVHYktwSHN0ODdvU2hYVEFaZndhVnp5SmdYMklMaE5mWHkrWG00?=
 =?utf-8?B?NVlXelhZSTdVWG1oRmF2cVdEUlZkaEFmdE5jZmRrWWxhZ0hQeitzK3dUZ252?=
 =?utf-8?B?UkQzR1B2aVJQbjRtL05CQW9GUzdrallZL0hwZU1NaUMrMTVBVDl1OHh5Sngv?=
 =?utf-8?B?ZXlxSVU4SnB2MVplQVVhV1ZMMUFabXZxcGpRM1psdG45UFpubTJFV3hndXdE?=
 =?utf-8?B?UWdRRlFiVmlnZVRMaE1oWk1UL0tTMDA2Q3I4TUlMaFVud2RFbjN2ME5uWERm?=
 =?utf-8?B?Sk1yTW4vQ1VXTit1MjFwanlsd1RrNnNFQzUyRnJSVjQwVFhNOVo1TVMwYXpk?=
 =?utf-8?B?VDBLZjJsRkFSUEhHY0E2c3BRVlZDZzF6ZVE3L25leCt1clJMWXBZdzRRT0gy?=
 =?utf-8?B?QzcyaHlWQzhWYU83ekVvSVRTSUlIMjcxZU1sWm5ZN3dCT2ZUY0ZFaFMzdkFo?=
 =?utf-8?B?R2Ewa3pWL1pORFgzdEU2aHpOYjJGY1VRd0tCZTBNNlEzYS9mOGZJaloxbitr?=
 =?utf-8?B?aWxOYmhWVVlhL3VGVDBFeGhZWHc3SGpkWjdXdENCVnh5Q0hUNFNZQ1J1ZFF6?=
 =?utf-8?B?VzQ0VGxBcC9WbmlkNnFid095UUowczFSV294TU55R1ZKOFpnRTVJY0xwWS92?=
 =?utf-8?B?dTVZUVlKQzdFREZEdHNWdGR4ZjFPMjJGZEdpQnVQNEpBVDRLOUpYeERNcEtS?=
 =?utf-8?B?SjJOVEpSNDhpdlpwNkoySi9TMFZreTh1SjFlTWZlR3dZMWNxMEZnRFA3ckFp?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee78c464-1305-49ac-9de9-08db9de10f57
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 22:43:35.6381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tR1WFNUfWUjzsMJhZG21PxQXSK8TKbix8BLpvDKIskUEsl2QYmLz9U1rDs1GZ4XowNNbhpi/+5NsRhhK0y5wlcoABLPR5lTr3QtqlqRlJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7804
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/11/2023 1:08 PM, Babu Moger wrote:
> The resctrl task assignment for monitor or control group needs to be
> done one at a time. For example:
> 
>   $mount -t resctrl resctrl /sys/fs/resctrl/
>   $mkdir /sys/fs/resctrl/ctrl_grp1
>   $echo 123 > /sys/fs/resctrl/ctrl_grp1/tasks
>   $echo 456 > /sys/fs/resctrl/ctrl_grp1/tasks
>   $echo 789 > /sys/fs/resctrl/ctrl_grp1/tasks
> 
> This is not user-friendly when dealing with hundreds of tasks.
> 
> Support multiple task assignment in one command with tasks ids separated
> by commas. For example:
>   $echo 123,456,789 > /sys/fs/resctrl/ctrl_grp1/tasks
> 
> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
