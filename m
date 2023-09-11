Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A216C79B32E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345807AbjIKVW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243890AbjIKSIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:08:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B6C103;
        Mon, 11 Sep 2023 11:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694455721; x=1725991721;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UU4Afob8104ntkvHD8vSOTvmxk+NtoLWisBYQaJxRzo=;
  b=F4iuCGLhQhobJQMRSbIcqM6uMUhLTTxkbEWC136EB4nPwo/wu/l7Obtx
   XDyxB2iCyTlKx+1P4ClktU1HeYeYSfd1vqpmXHuWwj81NfIhq+mfH2KwY
   opBpkIkE/hevXaECA3Repds3uIy3SNHVg0rkXbO2CCaa1Ory7r/7sab9C
   dQrt2b4ziGPBAn5cU6yMRnBqRVqa7TSpGKlaBmv6wFaZuc1FzmFhHVj1t
   0Y+ryQjYwYxgekxxOq8QbPxzD9wpEvxfbqadwjTf+OSGWSAhVy46TxUUo
   W5/dsn5zewRr+cB+j6mx2OCmFdCfbiFN2ZxTaOZp7q3C8AH038lUZVwj3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="381976782"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="381976782"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 11:08:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="1074238095"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="1074238095"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 11:08:29 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 11:08:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 11:08:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 11:08:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYdEDRZUxlVm/LTxXfWFqkYPyovZJx5EbueJtBvSS4vz4ZxURO4EoeKuA9Rl1hi5/mnPTQSDdQetUddsRJnumtDlwOL6HzLHFwAcnGbkUi2Lw/000tWGGx0z4SLWiquDIo28qGHDBA7xxDksipUHO1qrdKImTDcUUZJgbgdNYwa3g84N1wl/KbLuejOJocUg4/uqPv2KpJ2Myub5ErbzvD73rXPDX9hjBYjF59jJ4HJ7e4IvwoLkk79gHdNhrHVpLujO25HPNtUe/INC05mk70sj7ksThovjkO0LtH+JpkRfq54cKxZs1etJim3nmBYxLkof2FJlXktIxMSZrk/JMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Mnvu6dME4oFxK75zFDBieBzi56TR9UgrwAmFXgN+9k=;
 b=nF2apbDvtNJiJolNh08hN3rESOu/4bLG1r/UMx1enVbIyHOAbsQtDcQezRwswBaRsnT/oqyf3d68/hBN1hLP/PVPQWZfVAY1UUUZA2hKWxWfoYk3ZDBr8V363vYQYunCruKelJhq3xHs/vD/h/qJFLISU8rxtet5lmB4NAtRq8XltZbmcwjSJsdK2N5K57hTeJYNo1/BG635dj5yVe848LdIDxmJMKjyQ6r0IDgaf8Kqh72VW80rWUAhs8nRkP+faSbShHEiMKD4nRzMNGZU5Cz2IwdcvH0lpbhZgVhMCSwKMdndrw1VRaAC13OiVSs47w2htbcpBYiYlRYGT/bavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by LV8PR11MB8512.namprd11.prod.outlook.com (2603:10b6:408:1e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 18:08:24 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6768.036; Mon, 11 Sep 2023
 18:08:24 +0000
Message-ID: <d0bd1c6f-f1df-5355-5fc8-4fbd3be7d1e2@intel.com>
Date:   Mon, 11 Sep 2023 11:08:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v9 8/9] x86/resctrl: Display CLOSID for resource group
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20230907235128.19120-1-babu.moger@amd.com>
 <20230907235128.19120-9-babu.moger@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230907235128.19120-9-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:a03:255::17) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|LV8PR11MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc3d3b6-586e-43ff-6b1e-08dbb2f216fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WhzHcCjU1vyfKmmNg6acL8nX5gH+Whit1takppShxaYaeWydkc5RB86upQkjgEcQKf5gOnm+CCbDriqvKPKw22FPcfYk3KA0k3yhEFeHK2/+83uDFJbVrWnjHdKfd8NOczVjIfWWH0Ws/zn0RkYNxST4lDv9NtitsJFt1nLZsgyhDZHWkLLN7csl7zl+COfDs5zaTwY9oWGCBbhiGZEuazuu/lSfDuK0xtaFwPU+2tDp8fFUVgCrWeRM3ZPB9lPWny7Fl8yGcSpKXs/SWKpzayIJ8HeSPsiwAua5hUe2HUw8Szgbd7NlVGuiAMcKWja5xFc0aQXy11gZj4Xd6aNf2IiVIQ5J+4HA8c5oM5tqEBHEAJIZo46WqvAdOzlGuLAPyBwXP2JOpEG+MdeiXUKcoHxOPx/K/VYa3/1jl7iuSUz5HfDQgy81+l+wK3C+3a2mWosEsvP2CCsqQNInLbrBikotCglElC+AjbweDMmIsIK6tf+E6QCOy8qtGauviAPZUVFaGBR8e+suBu2YDhbsLhbsMt2YXjyyFwCdaF6He4aH4wRI6hVOe9UGoKtio5TEHncrqJ8qZCS+3U+1iKxjAsp86h9quAnKrBD2lU8rQxbx/shrfNqjshwtDNtw4lDhQsu0tC8GM1xusUnLXqOjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(186009)(1800799009)(451199024)(8676002)(8936002)(4326008)(83380400001)(66476007)(66556008)(66946007)(2616005)(41300700001)(26005)(316002)(6506007)(6486002)(53546011)(6512007)(478600001)(2906002)(82960400001)(5660300002)(38100700002)(31696002)(7416002)(7406005)(36756003)(44832011)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjFOeWZUeDR0TTBIc1RLOTNiQjVEVDRNVHZZeGs0VTdwTWo3YlpMa1hoQy9n?=
 =?utf-8?B?SXBkSEtoaW5tVXJiVTZQamZCM0Y5bzdlOWE3SjRRYWU1VEFNUVdZQjJBejZu?=
 =?utf-8?B?cWtveGJHZ0ZmSWg1WXczYk9yc1gzVW1NNGhoOTExd0xCNEJNVVVnd0FCdSt3?=
 =?utf-8?B?RzBXM1FxelU4MzI0NlRqUENoNXVkNncwM01nN3pCOGpGWUJLdVdPM3dIa2dn?=
 =?utf-8?B?NlBTNGhzZnZVbm5JTmRBZlVQWklWaWlhR2xWRk8wWWd1MmNtZmpRZU81cVJi?=
 =?utf-8?B?U1kwZXphRjVJaURVY2lzUzNVamI3YkQ2am9tVXM4NWRrVHBaMFY2djdsZVNn?=
 =?utf-8?B?QWJ3NlhFaGhPWjlnT2ZpQytQajl1aCszZjd4VnVvMTQ2NVNpelFEaGxVY1Vo?=
 =?utf-8?B?SXY4THNad3FHdUtrbXpJUmxBdU5nRTNicTZONnZ5Nlk3WStFMTBLY25PeG9C?=
 =?utf-8?B?c2hJM2pHOEx4U3gycEJVWEJkdUFrRTRCbnU0YkRobitHRGdIY2FDMzN4YTVE?=
 =?utf-8?B?MEtVRWZxaysvOEJETHV3WWYwS0JSRFBrOW9pejlIWXFFNSs4cGNqWlFPZWhP?=
 =?utf-8?B?eHZzQjM5bzkyWllpcjRrL2J0WVJ4eEpEOXphb2tUejRFcmJQMDVFL1dYVUlX?=
 =?utf-8?B?QUNjOGlNTHBiMWp3TWdGTVpuM0UzaUU4TTdmM2NWbERUcmN3MlFJNkVuMmVL?=
 =?utf-8?B?OVZxN0hLWW9ac3d5TEZqblpzZWVBd2NoTWxwd3FwRVJQc05IZjUxcGtFS1A4?=
 =?utf-8?B?RjAyTlNtZEhDdU8vSVRDaFA1aldwZkFrejFlMi9WVG03cUdKRGVQK0VIejBv?=
 =?utf-8?B?RGhtQXIxWVY2THd6QWcyTUpyWFJNN2kwYVFzbkE1NU5uQ3ZHTlBvdWVKdWJY?=
 =?utf-8?B?Y3VacHlYQUxEc0lMaGdxWEw0NHg1VWZTb1hsZzJ1NWNiNVI1RndETUw1aFFt?=
 =?utf-8?B?bWU0eExnZE83VFdMdmJIOTNrU3FLYmtHWVhMb3Blb3NtbFNNUzF3aS83bTJn?=
 =?utf-8?B?cG81eC9BdGhLY1o5N2tOYlBHN3F6RThCQjZsTkt5SHdJZ3BiTUFHdnp2bUJD?=
 =?utf-8?B?SUhaZDBKVDhlWlVnWm1IclVSV2I0eFkySHJVQUxuWC9hdkNWb2JMZ0liZTVx?=
 =?utf-8?B?NDJCNldxL0I5SHdLR3dsWTVIUEJEVXJ1VjdOSVJhN0tYQWl6VGVlY3BxWER3?=
 =?utf-8?B?TlR4MGkyZzhvN2RqMW50Yk5yQkFFaXFLMnVJeWt5RCtpazVGdjkxdWtQRjhS?=
 =?utf-8?B?cUpXa3diQWg0Q3RjVFRuZENVOC9velVIcSswYVcyNGQzVllaNnB1U1diNENP?=
 =?utf-8?B?Nmw1YnNiR3JhZ3owc2tGbENoc1NFT0hUWWpaRzVrZ0ttT2pIVXVQYyt6TFMv?=
 =?utf-8?B?SmlmVEg3YjY0cG9UQWFjZDd4bkpibEpLSXBSeit3ek1QUXBJRmZRMHlCSE9Q?=
 =?utf-8?B?ZXF5aHJYMThvbkhGdkp6TmFtOHJRTlBsditmTTJWbGxvUVUvVHUrdFY2K1Zx?=
 =?utf-8?B?UU52RGJwMENadW83QzRYcm51bHlmckpLT05pdFo1K3o2Y0ZWRVVBNW4wcm0z?=
 =?utf-8?B?N0hrMEtBMUIwL0Z3Sys3MExueDQydWJBcy9aa2ZWVGVZaTVpMUloa2NGWkts?=
 =?utf-8?B?OSt0dEpGa0pTeG9raUp5U21zT2tRNDFwN0hQVTBCelFxMXdyUGo5RUN4QVMw?=
 =?utf-8?B?NEVCV1JlRHkzMnI4Tlh6MDJhQ1RLY3J0NXFJR05nYlpTdWZ3cmZNQkxseUps?=
 =?utf-8?B?Z1pFR2VXVXVDL0tnZU9hZlR4M2lnL3NrZzdCSVQzZElYUlRNanRqTnhRVmp1?=
 =?utf-8?B?dlVZb3FoMTlTWENHcmNTamh2TU55OCtIMTRSR3pOM2tYTmI3OWlrNzNVNVdK?=
 =?utf-8?B?L3QxamphQlhYWG40RXFMUlpyNkxZaUNaMGNiRkUwVkVoNzdWMG1TL1YzU3Rp?=
 =?utf-8?B?Vk9EM05xOVgxcVhxWjBPcXc0RStEQk80UWlYM1l0YkhxUUtTNndDbW1QOFVD?=
 =?utf-8?B?aWVocHlWZnhnVWx1R29GMUhTNWl0N3MzdHh4TVpKaEp4RUFxZ3JqMjVYL05M?=
 =?utf-8?B?Wk9SQXllK0ZPeUVNU0U4VXh5ZHU5VlEvbTh0MVNua283VGc5RXNheHVLRVZ2?=
 =?utf-8?Q?9TL/aJ6zVnYUYoU5rWE8q8ydh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc3d3b6-586e-43ff-6b1e-08dbb2f216fc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 18:08:24.2642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbyBblKuGmRCxtq4rh/gw9cP7LX9xkxiwHstX1vP1ESi73aQCLdboKT8HGHsyrktP/YkKuwB8xPtdwC9a7U00w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8512
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

Hi, Babu,

On 9/7/23 16:51, Babu Moger wrote:
> In x86, hardware uses CLOSID to identify a control group. When a user
> creates a control group this information is not visible to the user.
> It can help resctrl debugging.
> 
> Add CLOSID(ctrl_hw_id) to the control groups display in resctrl
> interface. Users can see this detail when resctrl is mounted with
> "-o debug" option.
> 
> Other architectures do not use "CLOSID". Use the names ctrl_hw_id
> to refer to "CLOSID" in an effort to keep the naming generic.
> 
> For example:
>   $cat /sys/fs/resctrl/ctrl_grp1/ctrl_hw_id
>   1
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>   Documentation/arch/x86/resctrl.rst     |  4 ++++
>   arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
>   3 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 28d35aaa74b4..54691c8b832d 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -352,6 +352,10 @@ When control is enabled all CTRL_MON groups will also contain:
>   	file. On successful pseudo-locked region creation the mode will
>   	automatically change to "pseudo-locked".
>   
> +"ctrl_hw_id":
> +	Available only with debug option. The identifier used by hardware
> +	for the control group. On x86 this is the CLOSID.
> +
>   When monitoring is enabled all MON groups will also contain:
>   
>   "mon_data":
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 38b99a21ccd8..ccdbed615d41 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -299,6 +299,9 @@ struct rdtgroup {
>    *		--> RFTYPE_CTRL (Files only for CTRL group)
>    *		    Files: mode, schemata, size
>    *
> + *			--> RFTYPE_DEBUG (Files to help resctrl debugging)
> + *			    File: ctrl_hw_id
> + *
>    */
>   #define RFTYPE_INFO			BIT(0)
>   #define RFTYPE_BASE			BIT(1)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 67b315f3a26c..8be0fb323ad3 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -779,6 +779,22 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
>   	return ret;
>   }
>   
> +static int rdtgroup_closid_show(struct kernfs_open_file *of,
> +				struct seq_file *s, void *v)
> +{
> +	struct rdtgroup *rdtgrp;
> +	int ret = 0;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (rdtgrp)
> +		seq_printf(s, "%u\n", rdtgrp->closid);
> +	else
> +		ret = -ENOENT;
> +	rdtgroup_kn_unlock(of->kn);
> +
> +	return ret;
> +}
> +
>   #ifdef CONFIG_PROC_CPU_RESCTRL
>   
>   /*
> @@ -1863,6 +1879,13 @@ static struct rftype res_common_files[] = {
>   		.seq_show	= rdtgroup_size_show,
>   		.fflags		= RFTYPE_CTRL_BASE,
>   	},
> +	{
> +		.name		= "ctrl_hw_id",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_closid_show,

Is it better to rename "rdtgroup_closid_show" as arch neutral name 
"rdtgroup_ctrl_hw_id_show"? So the name is arch neutral and reflects the 
ctrl_hw_id. So this can eventually go to generic fs code without 
renaming it. The getting closid implementation in the function will be 
arch specific.

> +		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
> +	},
>   
>   };
>   

Thanks.

-Fenghua
