Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0EF7AE233
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjIYXZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbjIYXZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:25:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BAA101;
        Mon, 25 Sep 2023 16:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695684304; x=1727220304;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ES8wX734WzB2K/7mAcxRSDDkKSkDDqSKRHQYSjX1rNE=;
  b=VYYnRJiRq1EH1F+oqzZtUkbNEhfkiaSkvfk3rk55GO3ig8++siSmHZTa
   UXsOcPMBAO5FvxT2BUE9uLqJMeE0lm+JdqRU2oBykW9Nl2XsLJiHHhpAg
   pMjY24TUgjauECwX6ABCKfemVEBidUPnJnOUBguJJvTZfa78U9D5K0s7Y
   RwWCG1Hnx8YrMTGOAn4lW5OURSaaHOk69lj8zBWSCbvAK9g4L21Y+fiZs
   79LK0dY38bFFV5cwcyhRsBk2F2K8V353AldDaQ+qOtZsqAekZ1JruKTAj
   KszlEgWnva/uXzoKHMyPqWvWD5TCXPEEfGHZn5F1r4dvaYCGNRKuBepyE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="385284511"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="385284511"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 16:24:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="783733892"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="783733892"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 16:24:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:24:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:24:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 16:24:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 16:24:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzyO0CvfBqCbKh0Rr8lArZsslhBPfL7dh8UxfnSdTQWEESjfqh89ffCid/IzO7TTHHYtndoZxFYa5fRLnHjScUnXW/+Cj9vnpY5f2vyEP/kDtFUDdodA4iadk7Ist0lzCmVdWYbF0K3HInDAqHB4YMBljzA/BnB/32+Otp0NpJKGvV6ckaeCECkcGStmoPwA13GZ4+BVNog9afWbbBv7bvbpI/3O7ZZ5pbobDZ4/uqzc1VoJel7sI7ZEapGNnGZLrG8MQZafx5XBugoThwU7mlBT1e0Mng7fZD8Cp2exdUnUuvxMeCmr+mNstRQsuJ2t7K1I5eyKdlLRtNX6gsq2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsPFRaXe9hMkQwqxWo5owtEKkEDAor+WIvsGdkJQlBI=;
 b=PAsBDX93WBfVXhVUSs2aZyhZzXQclyAV1C5SYZJ40epr77fNf5Bpn4TXRQPO/NohSo11PP3WQjWH4YRsHIjShcm5yFM7R80fv7LNRckVC/KoN2IbkJBzlsOzWpDWQxJ1sZqOs/WI83UsG2qgkx1udn0QfChOdJ5f/iTDpQEPB0MlAgr15UQuJ9u/gaIX/c0UoO7PADZBVvDRkvOx4DlP8YaArwhS8OkB29iRseVCPIox4Dy8v1jztc1yJIGNTlkH3TPfxNRgrNOK2WB3MJHpvGWvQ+Ew21fVXr0LdsN4QhMipOBfljEsOjdu1qk51dkh/R6o84Oo3XESiOL5XlFWZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 23:24:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 23:24:13 +0000
Message-ID: <34671424-8dc5-3937-3779-8a8e52f47904@intel.com>
Date:   Mon, 25 Sep 2023 16:24:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v5 2/8] x86/resctrl: Prepare for different scope for
 control/monitor operations
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
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-3-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230829234426.64421-3-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:303:b8::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 38641db9-7aa8-4a83-92b2-08dbbe1e874e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rsQGjjkiENzg0k2HtQFB9MQOAhOh3cYji3T7H2cYffo6QR+Pod7lUHXo/LP+hXLWivNb3VyQ9QQw+PTiEdW1T6HfJKDdXPpyCOA8EWQNKrkLwk11jEeuHXQxkyOQ3o6r5l/9C4AY0S9gCAarULuX7I33wSg+MN1Fnx+mN0CcmGxs7c0qXeiwSnmhh9qRj9ln3aLoxle2dHzdL/yIg08zHlT8b7/u54e2g/qAA/uLlO+lPRpYs1B/eiQ6B3eMfc2HGQUEbFh8SqGIw/nWwMSrrORlrhOODGZ9CpwXQdpLi6yCbROawAhWIz9ouc8GwBeHdE/LOPhrc+W98YI1kuvTLbZpRuEj6cvwl1D710eRoJUGxD5UuWBDa0aSO22WVA0CL3o+8LE5ql9tRVayzXWdF0QgjP9cnJDNnoyW9fNNF/av1bsI+j+NYcdFmqa4jXVA0V2yUHFyM1rydHWWeOiyGDBzt8Fse1VnYd4A2wBi4ckNElx9/VWNIMmiTvQf/UmTxHZrOBPeaXOPezptOBzGq7uooBLWnu57Ipq8sbQLOfWpAYA+mwWVvGFT0+BYvvQSn2bZ7+vOvMa2iq++EdyFAhyrBVYq0NV6w9fPngpNTBoI/wFLQI5UZaGjCoPv0KjBwlm5DxgAH5z1SHNYCJR1cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(30864003)(31686004)(2906002)(7416002)(5660300002)(110136005)(66476007)(44832011)(66946007)(66556008)(54906003)(478600001)(6512007)(53546011)(2616005)(26005)(6506007)(6486002)(4326008)(8676002)(8936002)(316002)(41300700001)(83380400001)(82960400001)(31696002)(36756003)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3F3TTk5Z3hIWW5LQVUxeTVIM051akN6KzI5bWdFL3MzdzJheVFYQ1V0QVM2?=
 =?utf-8?B?Y3RCVGk5dWdJbWRidkZOdDBtaFk0aUNFbllJNEh2VWtsS2dzUnBoWnBOUDRo?=
 =?utf-8?B?anhjblp0dzJUdHVXL1F5VjFOUVBEWWxTTVp0bFJzdXdJQmJiRnRyNS9BeGJo?=
 =?utf-8?B?S0lWNkxHQ1VBSjRFL1VTcGNpdFpET0tua3dHUnVvN0VIMWt4WEpycWJ3Tlhh?=
 =?utf-8?B?R1VpNlpSMDhDeGRTSTBGTzRFbzFnb0duSFdnQXVicG4rQUpoMnB6N2ZUSGpG?=
 =?utf-8?B?MzJPVlp0cXhwZkI4M3UwUCtzTUxRUVVZeGhQSWMvdDhZMG5JM3hUMDRrUkFD?=
 =?utf-8?B?NUZUQW55MWg4OVJoby9iYVdIa3VjWTFYajAzNEJ6elJacUlTTmRXTFJVNkwr?=
 =?utf-8?B?RHJUM3FqNUs5UlJTdkF6cCtTSnVLTEdtVC91aG9lUVgzOWoyYm9meVpRU2Fx?=
 =?utf-8?B?QnRwbmdURzVna0wwVUp4R2gzTzZFdU9XN1ZmeDN5MC9odmk1MDFMVDYyUU50?=
 =?utf-8?B?RzlBc05jVFVGQUFUTGkxWFpGQ1hHQm84Z2RkL1J5K1NmUmh3S1d0Z0xsT1BJ?=
 =?utf-8?B?TXUvUmdTck9VUDVLcVJKdGExNi9xOHBCRXNKREY2R3ZEK0VRcmpEL1RTWXow?=
 =?utf-8?B?b20zRnh3aklPRzhDNXMwMzI2ajIydmNRdjJ1VWZ0ZllUSVkyUDdNclQ2QVNt?=
 =?utf-8?B?a0pBb1NLRURhckRaM3gvd1FlOHc5Rnd3ZnpVMGgzWFU0TkNSZ1RHdnRsSE1Z?=
 =?utf-8?B?Vkx5MHhzWm8vWXoxam43YlFVU0FOejhZSmxmcm1ZM1dvN2pHVEx6OFpsdEpY?=
 =?utf-8?B?UU1QbGl3S1dPWUVOdTVFc0E1ZlpjbjdCUUxTOE1sakkvamhRaGVBYlpEZ3N0?=
 =?utf-8?B?c3Q0RE9CZG83dU81NWVRdklDL0YrZU5iMVgvS0k4UWhtV1h2bW96ekh6YzJ4?=
 =?utf-8?B?VnJVaU80TGhINzVpbjRYRFJORy9tazFIL20vNHpZc3J5dCtWQjhZWGFqNXZK?=
 =?utf-8?B?ZEYxb0lHQnJ2NlpzUDNISEd4a29yeWVNT3J2ZUdGU1RxNUZ5b241bXRqTTRN?=
 =?utf-8?B?TXZGWTJDZERtNkQ5dG1uT1ZYZmNxRVg2dWhCZ0U1b1dHTG5zUmVYT3pHOElH?=
 =?utf-8?B?Tnd6UE5UUC9hUXRac1BRV0tGaTgzOE8rV01GaUhpMDNPQ2JLbXlucGg0elFW?=
 =?utf-8?B?N3NUMFBhdWNJblNHU1R3WlJ0RXl5ZDFDalJCV0MycGNaYmpXdnVaQ2piMGJZ?=
 =?utf-8?B?THNSMmFWeUNuQ1pKejl6Wldyc1c5NTRtS1lDUnU4SmtUNkc5b1VSeUN3QkQy?=
 =?utf-8?B?SU91NHllc2hwNkg4cEE0YVNTVFFWRUVxWi9VcXo2YWdOeFZjdFc3L2ZsY05Z?=
 =?utf-8?B?VnBVaTNHZlJwUllJM1huSmRwWjcrWVhHQTNYUlo5YWlDTDhXNEFZYzBGY3Jk?=
 =?utf-8?B?OVlDcmUzNG1hZTFGcFJoMkxUNzM5R3BOZlpJeXdwVTR4TFF2SEg3dm1oT0Rh?=
 =?utf-8?B?TktqcVI2aEhYbnlOMmdPRE9Ua2lURXRiOTdLUmw1OWlEVnlFdG00czMrYVlF?=
 =?utf-8?B?ZmRCNHBRcE9ta1BWQWxtKzNGQTVCMVlKR3V1NTNsMjNaREVLeC9vZHM4cVBw?=
 =?utf-8?B?RHVDaUFpMDdvcTZoWS9TQkNVZ2plaE1MVmZtRWZ6V3ZRUDFtOUkyRXd3RDBo?=
 =?utf-8?B?OW9pWU52emtvMkZmUlNKNUpaNXVYUndDd1dWOW5sTnFHRUZML3ZEdnJPamZp?=
 =?utf-8?B?dklVQ1oyUGFyeXRKRVRUaHBJM2F6bTc2THR6Tk5LQ3dDcHRZNGNCWTFRZ0ds?=
 =?utf-8?B?c25YOXc5U2JrekpSVlhIN3FMcjN4TXoxVkZMZ1lOYk9RR2pKeWNZYUxOMWpV?=
 =?utf-8?B?NFRLcm05MXhOclN2TlcrM3YrRXM1eXZFMWVEMXhES1R0U0VGT0hsNGtJVVN1?=
 =?utf-8?B?Q1lqbGNWQlNvM0ZwZ1BObnIzZnZiZFM0SDNYK3NtVFUvV1VvQjVWVnQwUFov?=
 =?utf-8?B?cWlQdmlEeEYxS0I5QTJTem9MZmlyY245WHgyNFJ5U1ZvUzIwb2k4SkRXaDda?=
 =?utf-8?B?aDhTazhIRjlwNVhwR3lTWXFnY2xEQS9SOWh1UXZPWE9FdjNMKzh1VGI0dWh6?=
 =?utf-8?B?dFRsUUViQVU3UEJUbU9qSDM4QXlNd1hIb21MSjhreW02dFJxS1FhbHA3UytE?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38641db9-7aa8-4a83-92b2-08dbbe1e874e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:24:13.2418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLgr6ReynVCw65421GeBVkMTmGKLhw8//i7IeUl8GHMZiv1MLo9d/QBLP+JIg7gHn32HIas+TyQwqkANWVVcn2hYbb1W/t9DfbR4yfluzYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8033
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

On 8/29/2023 4:44 PM, Tony Luck wrote:
> Existing resctrl assumes that control and monitor operations on a

Please remove "Existing", it can just be "resctrl assumes ..."

> resource are performed at the same scope.
> 
> Prepare for systems that use different scope (specifically L3 scope
> for cache control and NODE scope for cache occupancy and memory
> bandwidth monitoring).
> 
> Create separate domain lists for control and monitor operations.
> 
> No important functional change. But note that errors during
> initialization of either control or monitor functions on a domain would
> previously result in that domain being excluded from both control and
> monitor operations. Now the domains are allocated independently it is
> no longer required to disable both control and monitor operations if
> either fail.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  include/linux/resctrl.h                   |  16 +-
>  arch/x86/kernel/cpu/resctrl/internal.h    |   6 +-
>  arch/x86/kernel/cpu/resctrl/core.c        | 227 +++++++++++++++-------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   2 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c     |   2 +-
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  32 +--
>  7 files changed, 199 insertions(+), 88 deletions(-)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 2db1244ae642..33856943a787 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -155,10 +155,12 @@ enum resctrl_scope {
>   * @alloc_capable:	Is allocation available on this machine
>   * @mon_capable:	Is monitor feature available on this machine
>   * @num_rmid:		Number of RMIDs available
> - * @scope:		Scope of this resource
> + * @ctrl_scope:		Scope of this resource for control functions
> + * @mon_scope:		Scope of this resource for monitor functions
>   * @cache:		Cache allocation related data
>   * @membw:		If the component has bandwidth controls, their properties.
> - * @domains:		All domains for this resource
> + * @domains:		Control domains for this resource
> + * @mon_domains:	Monitor domains for this resource
>   * @name:		Name to use in "schemata" file.
>   * @data_width:		Character width of data when displaying
>   * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
> @@ -173,10 +175,12 @@ struct rdt_resource {
>  	bool			alloc_capable;
>  	bool			mon_capable;
>  	int			num_rmid;
> -	enum resctrl_scope	scope;
> +	enum resctrl_scope	ctrl_scope;
> +	enum resctrl_scope	mon_scope;
>  	struct resctrl_cache	cache;
>  	struct resctrl_membw	membw;
>  	struct list_head	domains;
> +	struct list_head	mondomains;

kerneldoc is "mon_domains" while member is "mondomains".
I do think to be consistent with other members that "mon_domains"
would be appropriate. I also think it will be very helpful it
domains is renamed to "ctrl_domains" to more accurately match
"ctrl_scope" and what it represents.

>  	char			*name;
>  	int			data_width;
>  	u32			default_ctrl;
> @@ -222,8 +226,10 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
>  
>  u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>  			    u32 closid, enum resctrl_conf_type type);
> -int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
> -void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
> +int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
> +int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
> +void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
> +void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
>  
>  /**
>   * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 85ceaf9a31ac..31a5fc3b717f 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -511,8 +511,10 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn);
>  int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
>  int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
>  			     umode_t mask);
> -struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
> -				   struct list_head **pos);
> +struct rdt_domain *rdt_find_ctrldomain(struct list_head *h, int id,
> +				       struct list_head **pos);
> +struct rdt_domain *rdt_find_mondomain(struct list_head *h, int id,
> +				      struct list_head **pos);

This is not what I expected after our previous discussion. It
should not be necessary for caller to be aware of the different
lists. It looks to me like the original parameters of (struct rdt_resource *r,
int id, struct list_head **pos) can be maintained.

>  ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>  				char *buf, size_t nbytes, loff_t off);
>  int rdtgroup_schemata_show(struct kernfs_open_file *of,
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 0d3bae523ecb..97f6f9715fdb 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -57,7 +57,7 @@ static void
>  mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
>  	      struct rdt_resource *r);
>  
> -#define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.domains)
> +#define domain_init(id, field) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.field)
>  

It may make the code easier to read if this is split into
a "mon_domain_init()" and "ctrl_domain_init()"

>  struct rdt_hw_resource rdt_resources_all[] = {
>  	[RDT_RESOURCE_L3] =
> @@ -65,8 +65,10 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_L3,
>  			.name			= "L3",
> -			.scope			= RESCTRL_L3_CACHE,
> -			.domains		= domain_init(RDT_RESOURCE_L3),
> +			.ctrl_scope		= RESCTRL_L3_CACHE,
> +			.mon_scope		= RESCTRL_L3_CACHE,
> +			.domains		= domain_init(RDT_RESOURCE_L3, domains),
> +			.mondomains		= domain_init(RDT_RESOURCE_L3, mondomains),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
>  			.fflags			= RFTYPE_RES_CACHE,
> @@ -79,8 +81,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_L2,
>  			.name			= "L2",
> -			.scope			= RESCTRL_L2_CACHE,
> -			.domains		= domain_init(RDT_RESOURCE_L2),
> +			.ctrl_scope		= RESCTRL_L2_CACHE,
> +			.domains		= domain_init(RDT_RESOURCE_L2, domains),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
>  			.fflags			= RFTYPE_RES_CACHE,
> @@ -93,8 +95,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_MBA,
>  			.name			= "MB",
> -			.scope			= RESCTRL_L3_CACHE,
> -			.domains		= domain_init(RDT_RESOURCE_MBA),
> +			.ctrl_scope		= RESCTRL_L3_CACHE,
> +			.domains		= domain_init(RDT_RESOURCE_MBA, domains),
>  			.parse_ctrlval		= parse_bw,
>  			.format_str		= "%d=%*u",
>  			.fflags			= RFTYPE_RES_MB,
> @@ -105,8 +107,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_SMBA,
>  			.name			= "SMBA",
> -			.scope			= RESCTRL_L3_CACHE,
> -			.domains		= domain_init(RDT_RESOURCE_SMBA),
> +			.ctrl_scope		= RESCTRL_L3_CACHE,
> +			.domains		= domain_init(RDT_RESOURCE_SMBA, domains),
>  			.parse_ctrlval		= parse_bw,
>  			.format_str		= "%d=%*u",
>  			.fflags			= RFTYPE_RES_MB,
> @@ -384,15 +386,16 @@ void rdt_ctrl_update(void *arg)
>  }
>  
>  /*
> - * rdt_find_domain - Find a domain in a resource that matches input resource id
> + * __rdt_find_domain - Find a domain in either the list of control or
> + * monitor domains that matches input resource id
>   *
>   * Search resource r's domain list to find the resource id. If the resource
>   * id is found in a domain, return the domain. Otherwise, if requested by
>   * caller, return the first domain whose id is bigger than the input id.
>   * The domain list is sorted by id in ascending order.
>   */
> -struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
> -				   struct list_head **pos)
> +static void *__rdt_find_domain(struct list_head *h, int id,
> +			       struct list_head **pos)
>  {
>  	struct rdt_domain *d;
>  	struct list_head *l;
> @@ -400,7 +403,7 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
>  	if (id < 0)
>  		return ERR_PTR(-ENODEV);
>  
> -	list_for_each(l, &r->domains) {
> +	list_for_each(l, h) {
>  		d = list_entry(l, struct rdt_domain, list);
>  		/* When id is found, return its domain. */
>  		if (id == d->id)
> @@ -416,6 +419,18 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
>  	return NULL;
>  }
>  
> +struct rdt_domain *rdt_find_ctrldomain(struct list_head *h, int id,
> +				       struct list_head **pos)
> +{
> +	return __rdt_find_domain(h, id, pos);
> +}
> +
> +struct rdt_domain *rdt_find_mondomain(struct list_head *h, int id,
> +				      struct list_head **pos)
> +{
> +	return __rdt_find_domain(h, id, pos);
> +}
> +
>  static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> @@ -431,10 +446,15 @@ static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
>  }
>  
>  static void domain_free(struct rdt_hw_domain *hw_dom)
> +{
> +	kfree(hw_dom->ctrl_val);
> +	kfree(hw_dom);
> +}
> +
> +static void mondomain_free(struct rdt_hw_domain *hw_dom)
>  {
>  	kfree(hw_dom->arch_mbm_total);
>  	kfree(hw_dom->arch_mbm_local);
> -	kfree(hw_dom->ctrl_val);
>  	kfree(hw_dom);
>  }
>  
> @@ -502,6 +522,93 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
>  	return -1;
>  }
>  
> +static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
> +{
> +	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
> +	struct list_head *add_pos = NULL;
> +	struct rdt_hw_domain *hw_dom;
> +	struct rdt_domain *d;
> +	int err;
> +
> +	d = rdt_find_ctrldomain(&r->domains, id, &add_pos);
> +	if (IS_ERR(d)) {
> +		pr_warn("Couldn't find scope id=%d for CPU %d\n", id, cpu);

I am not sure here ... this generates identical error messages
for control and monitor domain. How will the user know what failed?
Also, how does printing id help? If I understand correctly it can
only be -1 when the above prints.

> +		return;
> +	}
> +
> +	if (d) {
> +		cpumask_set_cpu(cpu, &d->cpu_mask);
> +		if (r->cache.arch_has_per_cpu_cfg)
> +			rdt_domain_reconfigure_cdp(r);
> +		return;
> +	}
> +
> +	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> +	if (!hw_dom)
> +		return;
> +
> +	d = &hw_dom->d_resctrl;
> +	d->id = id;
> +	cpumask_set_cpu(cpu, &d->cpu_mask);
> +
> +	rdt_domain_reconfigure_cdp(r);
> +
> +	if (domain_setup_ctrlval(r, d)) {
> +		domain_free(hw_dom);
> +		return;
> +	}
> +
> +	list_add_tail(&d->list, add_pos);
> +
> +	err = resctrl_online_ctrl_domain(r, d);
> +	if (err) {
> +		list_del(&d->list);
> +		domain_free(hw_dom);
> +	}
> +}
> +
> +static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
> +{
> +	int id = get_domain_id_from_scope(cpu, r->mon_scope);
> +	struct rdt_hw_domain *hw_mondom;
> +	struct list_head *add_pos = NULL;

Please maintain reverse fir ordering. Please check all code.

> +	struct rdt_domain *d;
> +	int err;
> +
> +	d = rdt_find_mondomain(&r->mondomains, id, &add_pos);
> +	if (IS_ERR(d)) {
> +		pr_warn("Couldn't find scope id=%d for CPU %d\n", id, cpu);
> +		return;
> +	}
> +
> +	if (d) {
> +		cpumask_set_cpu(cpu, &d->cpu_mask);
> +

This is an unnecessary empty line that distracts from how the rest
of the function looks.

> +		return;
> +	}
> +
> +	hw_mondom = kzalloc_node(sizeof(*hw_mondom), GFP_KERNEL, cpu_to_node(cpu));
> +	if (!hw_mondom)
> +		return;
> +
> +	d = &hw_mondom->d_resctrl;
> +	d->id = id;
> +	cpumask_set_cpu(cpu, &d->cpu_mask);
> +
> +	if (arch_domain_mbm_alloc(r->num_rmid, hw_mondom)) {
> +		mondomain_free(hw_mondom);
> +		return;
> +	}
> +
> +	list_add_tail(&d->list, add_pos);
> +
> +	err = resctrl_online_mon_domain(r, d);
> +	if (err) {
> +		list_del(&d->list);
> +		mondomain_free(hw_mondom);
> +	}
> +}
> +
>  /*
>   * domain_add_cpu - Add a cpu to a resource's domain list.
>   *

Note that this leaves the comments about list management here while all
the list management code is moved away.

> @@ -517,70 +624,28 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
>   */
>  static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_domain_id_from_scope(cpu, r->scope);
> -	struct list_head *add_pos = NULL;
> -	struct rdt_hw_domain *hw_dom;
> -	struct rdt_domain *d;
> -	int err;
> -
> -	d = rdt_find_domain(r, id, &add_pos);
> -	if (IS_ERR(d)) {
> -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> -		return;
> -	}
> -
> -	if (d) {
> -		cpumask_set_cpu(cpu, &d->cpu_mask);
> -		if (r->cache.arch_has_per_cpu_cfg)
> -			rdt_domain_reconfigure_cdp(r);
> -		return;
> -	}
> -
> -	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> -	if (!hw_dom)
> -		return;
> -
> -	d = &hw_dom->d_resctrl;
> -	d->id = id;
> -	cpumask_set_cpu(cpu, &d->cpu_mask);
> -
> -	rdt_domain_reconfigure_cdp(r);
> -
> -	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> -		domain_free(hw_dom);
> -		return;
> -	}
> -
> -	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> -		domain_free(hw_dom);
> -		return;
> -	}
> -
> -	list_add_tail(&d->list, add_pos);
> -
> -	err = resctrl_online_domain(r, d);
> -	if (err) {
> -		list_del(&d->list);
> -		domain_free(hw_dom);
> -	}
> +	if (r->alloc_capable)
> +		domain_add_cpu_ctrl(cpu, r);
> +	if (r->mon_capable)
> +		domain_add_cpu_mon(cpu, r);
>  }
>  
> -static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> +static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_domain_id_from_scope(cpu, r->scope);
> +	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
>  	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
>  
> -	d = rdt_find_domain(r, id, NULL);
> +	d = rdt_find_ctrldomain(&r->domains, id, NULL);
>  	if (IS_ERR_OR_NULL(d)) {
> -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> +		pr_warn("Couldn't find scope id=%d for CPU %d\n", id, cpu);
>  		return;
>  	}
>  	hw_dom = resctrl_to_arch_dom(d);
>  
>  	cpumask_clear_cpu(cpu, &d->cpu_mask);
>  	if (cpumask_empty(&d->cpu_mask)) {
> -		resctrl_offline_domain(r, d);
> +		resctrl_offline_ctrl_domain(r, d);
>  		list_del(&d->list);
>  
>  		/*
> @@ -593,6 +658,30 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  
>  		return;
>  	}
> +}
> +
> +static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
> +{
> +	int id = get_domain_id_from_scope(cpu, r->mon_scope);
> +	struct rdt_hw_domain *hw_mondom;
> +	struct rdt_domain *d;
> +
> +	d = rdt_find_mondomain(&r->mondomains, id, NULL);
> +	if (IS_ERR_OR_NULL(d)) {
> +		pr_warn("Couldn't find scope id=%d for CPU %d\n", id, cpu);
> +		return;
> +	}
> +	hw_mondom = resctrl_to_arch_dom(d);
> +
> +	cpumask_clear_cpu(cpu, &d->cpu_mask);
> +	if (cpumask_empty(&d->cpu_mask)) {
> +		resctrl_offline_mon_domain(r, d);
> +		list_del(&d->list);
> +

This is an awkward empty line.

> +		mondomain_free(hw_mondom);
> +
> +		return;
> +	}
>  
>  	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
>  		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {

...

Reinette
