Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98B378153A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 00:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbjHRWFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 18:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241680AbjHRWFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 18:05:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9D73AB5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692396332; x=1723932332;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SSkvGliL3q+d7cV11bK7Fgkp2iTKPSooC5mhC/NDnps=;
  b=fSLZqRAH9qhbnVJQwGiSEQqB94ladJ3Qnc+7u5wmuRRNBqz81PULWD5m
   0a1cdS4/uZh2C890I6+ZHk7kpRh0amZXDYSrg9KOoO7Grhh47+jweeFoO
   cffZuI77bKqRXPpJTA+ykcoosCEqiPd0rqpfchEKDq1gnd2bIm8sPZ2ub
   7Ad0XDCI0GsOj993AsOdaLhUVskxkyxBV47Xjiykzn4v9vNxAWVElWof1
   9ruVJKUspAAxnE3no+e7uM/3U1gVxXEUqyxCeHK+yxQDHD6Q0GNxqko7O
   4th4Tp7IciFy+pd3JmujDoJNMJ21otKqL+I2kI1buUW0XvPH+GDsughRw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="439592411"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="439592411"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 15:05:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="858841981"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="858841981"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 18 Aug 2023 15:05:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 15:05:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 15:05:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 15:05:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+qr6Bfv9GtkxEXcY0dRss0/IfoeQnFA91OnHCI2SANmd+pfqPPEe2cPoKGkzhC64iBkhq7HiWZ22/w+M61gvAqtt9ax7IC/Vbtf/5F+0UbaBjqXecvKn5R4boBQFxdsWrbCWk6gwX8krvuQwiLyyub539uoyf8fQANn0xvSwkHz5naN3HFQUkCh01bTQURhTnL9SjriEeDp31LwgC+bovz7vUpnYfaMktrnRgA1r9yii1RpSw8/YCYIUE/ulvlad8Rq6l2E9ICbRqpLaTt+2tZnQlXVM2MYhC9QMvQygM4gDrAGBA/yVSzee+chjSSL1+6futl8mYE9gfANf1MV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwTiVzFQ1E9plxp67JdeypoTHFzxgf87tCi8ZutC7rs=;
 b=OxQLc8lVBI+Zo9gRgh+88hfHhl0z/7PnT/5Muj6vAGweR1G45AYFw27dVONuddeW+LxiodEmx4wlv9QM63OrKkuRCYFw9e/OTR3VPhHs7ir8rwU6wttIb04fzrf8jh9j7RcZJ+hFAEN4iGXpjXP816gYhDlluLaBeII/fyx0gTGZ/EEpsgc+jqVIJ9wYJsX1CdLqdM+rSBWQoI7dtXN8zs0aCs+2297xODJSU1j/U4iHjcvPhc2F9qNBidA84Cxl+veOVmPx8H0jLxQwa6uRgk/Phqpf6ndRusySqgEtfA4MbxT+KmIu29MhqNe/MmG8I7488jSfj4/L/Kp0jZP/qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DS0PR11MB7622.namprd11.prod.outlook.com (2603:10b6:8:144::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 22:05:24 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 22:05:24 +0000
Message-ID: <7425115e-6f2f-d0bf-4d35-c593360f4ded@intel.com>
Date:   Fri, 18 Aug 2023 15:05:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v5 24/24] x86/resctrl: Separate arch and fs resctrl locks
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-25-james.morse@arm.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230728164254.27562-25-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DS0PR11MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc642ca-3e8f-48f1-7c32-08dba03738b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+tIbzY5jhdUUnAVjZwlQz1h2TrgNvkCPqD//GSZmOGD94jlrnt7tZ3XW3yrOFIiTm3TQuTwiUrccknNUW3eHhRwHFQeXJlgDV0LcG+gptVYkmeHtBKlxGw0DG46aia4t+iCXS5u5p1TA8CAO1kxEf2gi4Ag8Yk8qtL+ttA5+yVTeemkv5cfSxpFXtOUwviFf44LqHkJsjIc35d/nefaodKBh7JalNtdcrLHyM5hAGxzZ3q0ZZeKiZ2Dt1QuWz3TH7LLx65QnFTRiXsR5oh5l0h3wosVMwK2qPHh/eFw8/kMXuV+yY9BHe4xx6Q4542Xe8gG8ewFHUcqjoLivXRwmbL+uVmXJMJNO8V0vf6ZHdiC2MwYQg6Rq0LTq//2gGBdrOF0QpCoQLZrF29OlbXwUfA9vkFwR0IUE38O5zP65fupPl3VbJc/chSsDi3iiAqRcjHrIn0DfVaIA36AAIqDdxAvMvPMxxJUt+3tLgnHS9irsx1HEuJk4+vWLSGGotPm1vDiT2KIoZ1+bkd0HXMZt6+Z+xI80TJLRok9LXBOkqeCaL3VGrBe3JnrARdIYHpt+KBso4g/Om1ieemJUCEi5DwQBgFl/VhCYwCW9TeHYuRHc4gkmSaNCfxKljNInMxsgcZODwgr+ZJbYzWnbuu47Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(1800799009)(451199024)(186009)(83380400001)(66899024)(316002)(66476007)(82960400001)(54906003)(66556008)(66946007)(38100700002)(478600001)(7416002)(8676002)(2906002)(41300700001)(4326008)(5660300002)(8936002)(30864003)(6486002)(6512007)(2616005)(6666004)(6506007)(53546011)(26005)(44832011)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDdVQlJpWEV1MTFJY21HTUF6L29pLzlKb2Rlb0J4SlhlSm03UGlXbjBMT0o1?=
 =?utf-8?B?S1pXeTBhYUQwWXdlNjFXam5mYnRGNitkRFdsS3JnRit2RG0rbEpZNzVEdkwr?=
 =?utf-8?B?YUw4VEVkaWN1TlhYc3puTmx4eitpSDJPejhXam5FdjVKNk5Bc0Y5aFNiMUQv?=
 =?utf-8?B?ZXJBR0NoOHc3Z20zbGN6K1dJajl4ZEk0eWhzTmdJaXgzM2NLNXhXWFpIbnJ5?=
 =?utf-8?B?MkxJa2JKU1IvTUpLZnNIMm5hN2ZFOHRyZVVoSi9tUzNueDBNemxyd2FBUTBC?=
 =?utf-8?B?bytwVVIvMFlNV05yWlVOVGpHNFA1eks0SlZaRzZKUkpNTHAvUkN3TGRpa0Np?=
 =?utf-8?B?cGVnckRyZThnWFdBRFQrOUJXWStNUnk3TWZ5SWVISDhZN0ZqYVprb28xWjZq?=
 =?utf-8?B?RXZQZUZ5ZHpDZEFPWFZNdUR2Qk1NVGxrY2pZT1RaVHVwaXM2UkJNTEFxUVpj?=
 =?utf-8?B?M1JsclJLTkd3bk10eWdDeEFuaHpOYjFxVXFybUR2UUlCWEZGNGZwTHMySXJB?=
 =?utf-8?B?cEh6VzVScVcxOFVWNFZCR3F4WStKakJ6ZUlCY0Zpb3c2ZnlVcTlpeG9JYk4w?=
 =?utf-8?B?WE0xSVAzai9NZDFRenRhaENiOC9zTGRRMUMrSHRvc0tEL0dUSytUN1V0V0F2?=
 =?utf-8?B?YmFEUktoUVhXL00yUmVxb3VyU0pRcWE4c2FGdFQ0VldkYmhKSzc0SUtOODRN?=
 =?utf-8?B?dVZaRzlWYU9iSkFBc3ZkR0RINHJzMXE4d1pKVVkvcy9OM2hlREpIdHFKVU00?=
 =?utf-8?B?UW03RDdpRGswdnA4bk0zMmlUcUxyTXNpTEFmRzYvaEJhS0pHZ1M5Si9sWDV2?=
 =?utf-8?B?c3JiNmZ4N0hyUTZPTElobktNdkJKTWFNbU9HNVUvYzZtanVITXA1SlluWDV3?=
 =?utf-8?B?bUMvYVFHWm02bzVtNFB2UEsrNFlSNDZoQnRzbytlUWQvU0hqRWpWb01HV1A1?=
 =?utf-8?B?dkpLczI4V3hRK0trdXVoNmlIck9xUUhFVU1ybWlzNDlBY3V5ZlpnTms2VlZT?=
 =?utf-8?B?YXVQM3pzUnRBcXNKQ1Z1RHJjbDRac0ZSMXZURE1JK2xUS0syOU5mVk1mbVR2?=
 =?utf-8?B?aGtTUFVEekVJMlIzbkRGcUg1YzI2bFhmVU9paVIrSTZtYWRZMUxTeXg4RENm?=
 =?utf-8?B?T3JveXZBcFkrYkRJREhuQWVDN3p3Y1krdnROd3FDSDBCUzdxa2RhOTJZendr?=
 =?utf-8?B?ajJzRlBqcWs0TVoybzFuQ2lORHZLZWxrOFlvajJIczhnUUlKcE45VmdPaG5V?=
 =?utf-8?B?eUdXMXJZNCs2K0FRZTd6SmF2ZDk5RnZKeTdxcGRxMHg5OTBsYlB4K0tXRmxT?=
 =?utf-8?B?QjNnVXlPdks1QkpUT2pWT011YlFybVNseWNicnd4L3A2Z2F6M0crRnhFUGth?=
 =?utf-8?B?eGxYdTlJS3I0bHQyR09YTEFta05RQ2hMODR0OWpiLyttTG02MkhWcWQ5eWg5?=
 =?utf-8?B?TGdQNVEwdlZnSVNOKzlhVzV0NWVaZzNpUHhia1VrQitiZmNhSjdwZzFiMnR6?=
 =?utf-8?B?TFdlUDdkQVJSazg0NGJtZXVxNnI1TUxQNlFyZ2IrWTJwRlg5UFQ5ejdzNE4r?=
 =?utf-8?B?d0FwM21wb0JSbVZHckUvS04rTFdxOUs2eGRjY0Q0NzNPalkvcklaQzhqOVN0?=
 =?utf-8?B?VnVjVDJndUVXaTZpVGtSS25VNnJvb052bUFEWGMweXRpcWdCQUxJN3lQZDND?=
 =?utf-8?B?dTZCNU1PQ1RXZDZHbUlaakw2UjN5UitmODlVaEcvLzliU0xrUlFNWUw5LzRn?=
 =?utf-8?B?cFFTYkd3OGZTdno4dy9JWStPRCtBSWgvSkE4ZEs4clNxNXRUbDF1WE5JQWNS?=
 =?utf-8?B?VC9BNWRkckJ3U1d4RG1sMnF6bkZWeVJKU0xRRk5tR0FsNm1RZDFXZUhHeGxU?=
 =?utf-8?B?aG5qbU1pSHlsYnFsRCtHZFVwd3hObXpOWkFjK0EzTzhaSDZkMHZ3RmZVL3R3?=
 =?utf-8?B?Mk9SNXlkeFVKalExUm1LdzYxamJzZ2VUOGpCclNvUVFNcXhuQjdTQ05jVGxT?=
 =?utf-8?B?ZkJ5dlJrNnh2dHNzY05BV09VVUlZaVQ4NlJpVWJIcGptOUJyUjRwYTU1aExR?=
 =?utf-8?B?bjlNOGQ4Uk9DeURCS0ZUSzZFYTdSMVI4RkdtY2Nhay9DNXhFbnBabUw1aWlD?=
 =?utf-8?Q?ofm9IRvpwzAPROAN3+mSvGOE6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc642ca-3e8f-48f1-7c32-08dba03738b2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 22:05:24.0498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAC3080dXEy64K7QgHedNb1PNx6WWBqOnT67tIEuW1Yb2iL1wVKEaTbQY0HMXBZBGFNpOS5s8PP15OiQAa7TVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7622
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

On 7/28/23 09:42, James Morse wrote:
> resctrl has one mutex that is taken by the architecture specific code,
> and the filesystem parts. The two interact via cpuhp, where the
> architecture code updates the domain list. Filesystem handlers that
> walk the domains list should not run concurrently with the cpuhp
> callback modifying the list.
> 
> Exposing a lock from the filesystem code means the interface is not
> cleanly defined, and creates the possibility of cross-architecture
> lock ordering headaches. The interaction only exists so that certain
> filesystem paths are serialised against cpu hotplug. The cpu hotplug
> code already has a mechanism to do this using cpus_read_lock().
> 
> MPAM's monitors have an overflow interrupt, so it needs to be possible
> to walk the domains list in irq context. RCU is ideal for this,
> but some paths need to be able to sleep to allocate memory.
> 
> Because resctrl_{on,off}line_cpu() take the rdtgroup_mutex as part
> of a cpuhp callback, cpus_read_lock() must always be taken first.
> rdtgroup_schemata_write() already does this.
> 
> Most of the filesystem code's domain list walkers are currently
> protected by the rdtgroup_mutex taken in rdtgroup_kn_lock_live().
> The exceptions are rdt_bit_usage_show() and the mon_config helpers
> which take the lock directly.
> 
> Make the domain list protected by RCU. An architecture-specific
> lock prevents concurrent writers. rdt_bit_usage_show() can
> walk the domain list under rcu_read_lock(). The mon_config helpers
> send multiple IPIs, take the cpus_read_lock() in these cases.
> 
> The other filesystem list walkers need to be able to sleep.
> Add cpus_read_lock() to rdtgroup_kn_lock_live() so that the
> cpuhp callbacks can't be invoked when file system operations are
> occurring.
> 
> Add lockdep_assert_cpus_held() in the cases where the
> rdtgroup_kn_lock_live() call isn't obvious.
> 
> Resctrl's domain online/offline calls now need to take the
> rdtgroup_mutex themselves.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>   * Reworded a comment,
>   * Added a lockdep assertion
>   * Moved clear_closid_rmid() outside the locked region of cpu
>     online/offline
> 
> Changes since v3:
>   * Added a header include
> ---
>   arch/x86/kernel/cpu/resctrl/core.c        | 38 +++++++++-----
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 16 ++++--
>   arch/x86/kernel/cpu/resctrl/monitor.c     |  4 ++
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  3 ++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 64 ++++++++++++++++++++---
>   include/linux/resctrl.h                   |  2 +-
>   6 files changed, 101 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index edc0dd123317..f106c68a9be8 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -25,8 +25,15 @@
>   #include <asm/resctrl.h>
>   #include "internal.h"
>   
> -/* Mutex to protect rdtgroup access. */
> -DEFINE_MUTEX(rdtgroup_mutex);
> +/*
> + * rdt_domain structures are kfree()d when their last CPU goes offline,
> + * and allocated when the first CPU in a new domain comes online.
> + * The rdt_resource's domain list is updated when this happens. Readers of
> + * the domain list must either take cpus_read_lock(), or rely on an RCU
> + * read-side critical section, to avoid observing concurrent modification.
> + * All writers take this mutex:
> + */
> +static DEFINE_MUTEX(domain_list_lock);
>   
>   /*
>    * The cached resctrl_pqr_state is strictly per CPU and can never be
> @@ -508,6 +515,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>   	struct rdt_domain *d;
>   	int err;
>   
> +	lockdep_assert_held(&domain_list_lock);
> +
>   	d = rdt_find_domain(r, id, &add_pos);
>   	if (IS_ERR(d)) {
>   		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> @@ -541,11 +550,12 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>   		return;
>   	}
>   
> -	list_add_tail(&d->list, add_pos);
> +	list_add_tail_rcu(&d->list, add_pos);
>   
>   	err = resctrl_online_domain(r, d);
>   	if (err) {
> -		list_del(&d->list);
> +		list_del_rcu(&d->list);
> +		synchronize_rcu();
>   		domain_free(hw_dom);
>   	}
>   }
> @@ -556,6 +566,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>   	struct rdt_hw_domain *hw_dom;
>   	struct rdt_domain *d;
>   
> +	lockdep_assert_held(&domain_list_lock);
> +
>   	d = rdt_find_domain(r, id, NULL);
>   	if (IS_ERR_OR_NULL(d)) {
>   		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> @@ -566,7 +578,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>   	cpumask_clear_cpu(cpu, &d->cpu_mask);
>   	if (cpumask_empty(&d->cpu_mask)) {
>   		resctrl_offline_domain(r, d);
> -		list_del(&d->list);
> +		list_del_rcu(&d->list);
> +		synchronize_rcu();
>   
>   		/*
>   		 * rdt_domain "d" is going to be freed below, so clear
> @@ -594,30 +607,29 @@ static void clear_closid_rmid(int cpu)
>   static int resctrl_arch_online_cpu(unsigned int cpu)
>   {
>   	struct rdt_resource *r;
> -	int ret;
>   
> -	mutex_lock(&rdtgroup_mutex);
> +	mutex_lock(&domain_list_lock);
>   	for_each_capable_rdt_resource(r)
>   		domain_add_cpu(cpu, r);
> +	mutex_unlock(&domain_list_lock);
> +
>   	clear_closid_rmid(cpu);
>   
> -	ret = resctrl_online_cpu(cpu);
> -	mutex_unlock(&rdtgroup_mutex);
> -
> -	return ret;
> +	return resctrl_online_cpu(cpu);
>   }
>   
>   static int resctrl_arch_offline_cpu(unsigned int cpu)
>   {
>   	struct rdt_resource *r;
>   
> -	mutex_lock(&rdtgroup_mutex);
>   	resctrl_offline_cpu(cpu);
>   
> +	mutex_lock(&domain_list_lock);
>   	for_each_capable_rdt_resource(r)
>   		domain_remove_cpu(cpu, r);
> +	mutex_unlock(&domain_list_lock);
> +
>   	clear_closid_rmid(cpu);
> -	mutex_unlock(&rdtgroup_mutex);
>   
>   	return 0;
>   }
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 55bad57a7bd5..b4f611359d1e 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -209,6 +209,9 @@ static int parse_line(char *line, struct resctrl_schema *s,
>   	struct rdt_domain *d;
>   	unsigned long dom_id;
>   
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>   	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
>   	    (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)) {
>   		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
> @@ -313,6 +316,9 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>   	struct rdt_domain *d;
>   	u32 idx;
>   
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();

When rdtgroup_schemata_write() calls resctrl_arch_update_domains(), I 
don't see cpus lock is held. Is it held in the path?

> +
>   	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
>   		return -ENOMEM;
>   
> @@ -378,11 +384,9 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>   		return -EINVAL;
>   	buf[nbytes - 1] = '\0';
>   
> -	cpus_read_lock();
>   	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>   	if (!rdtgrp) {
>   		rdtgroup_kn_unlock(of->kn);
> -		cpus_read_unlock();
>   		return -ENOENT;
>   	}
>   	rdt_last_cmd_clear();
> @@ -444,7 +448,6 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>   out:
>   	rdt_staged_configs_clear();
>   	rdtgroup_kn_unlock(of->kn);
> -	cpus_read_unlock();
>   	return ret ?: nbytes;
>   }
>   
> @@ -464,6 +467,9 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
>   	bool sep = false;
>   	u32 ctrl_val;
>   
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>   	seq_printf(s, "%*s:", max_name_width, schema->name);
>   	list_for_each_entry(dom, &r->domains, list) {
>   		if (sep)
> @@ -534,8 +540,8 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>   {
>   	int cpu;
>   
> -	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
> -	lockdep_assert_held(&rdtgroup_mutex);
> +	/* When picking a cpu from cpu_mask, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
>   
>   	/*
>   	 * Setup the parameters to pass to mon_event_count() to read the data.
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 471cdc4e4eae..11b5da93044d 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -15,6 +15,7 @@
>    * Software Developer Manual June 2016, volume 3, section 17.17.
>    */
>   
> +#include <linux/cpu.h>
>   #include <linux/module.h>
>   #include <linux/percpu.h>
>   #include <linux/sizes.h>
> @@ -484,6 +485,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>   
>   	lockdep_assert_held(&rdtgroup_mutex);
>   
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>   	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
>   
>   	entry->busy = 0;
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 460421051abf..fc3ed917d173 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -830,6 +830,9 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
>   	struct rdt_domain *d_i;
>   	bool ret = false;
>   
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>   	if (!zalloc_cpumask_var(&cpu_with_psl, GFP_KERNEL))
>   		return true;
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index a256a96df487..47dcf2cb76ca 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -35,6 +35,10 @@
>   DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
>   DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>   DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
> +
> +/* Mutex to protect rdtgroup access. */
> +DEFINE_MUTEX(rdtgroup_mutex);
> +
>   static struct kernfs_root *rdt_root;
>   struct rdtgroup rdtgroup_default;
>   LIST_HEAD(rdt_all_groups);
> @@ -954,7 +958,8 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>   
>   	mutex_lock(&rdtgroup_mutex);
>   	hw_shareable = r->cache.shareable_bits;
> -	list_for_each_entry(dom, &r->domains, list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(dom, &r->domains, list) {
>   		if (sep)
>   			seq_putc(seq, ';');
>   		sw_shareable = 0;
> @@ -1010,8 +1015,10 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>   		}
>   		sep = true;
>   	}
> +	rcu_read_unlock();
>   	seq_putc(seq, '\n');
>   	mutex_unlock(&rdtgroup_mutex);
> +
>   	return 0;
>   }
>   
> @@ -1254,6 +1261,9 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
>   	struct rdt_domain *d;
>   	u32 ctrl;
>   
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>   	list_for_each_entry(s, &resctrl_schema_all, list) {
>   		r = s->res;
>   		if (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)
> @@ -1520,6 +1530,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
>   	struct rdt_domain *dom;
>   	bool sep = false;
>   
> +	cpus_read_lock();
>   	mutex_lock(&rdtgroup_mutex);
>   
>   	list_for_each_entry(dom, &r->domains, list) {
> @@ -1536,6 +1547,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
>   	seq_puts(s, "\n");
>   
>   	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
>   
>   	return 0;
>   }
> @@ -1627,6 +1639,9 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
>   	struct rdt_domain *d;
>   	int ret = 0;
>   
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>   next:
>   	if (!tok || tok[0] == '\0')
>   		return 0;
> @@ -1668,6 +1683,7 @@ static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
>   	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>   		return -EINVAL;
>   
> +	cpus_read_lock();
>   	mutex_lock(&rdtgroup_mutex);
>   
>   	rdt_last_cmd_clear();
> @@ -1677,6 +1693,7 @@ static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
>   	ret = mon_config_write(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);
>   
>   	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
>   
>   	return ret ?: nbytes;
>   }
> @@ -1692,6 +1709,7 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>   	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>   		return -EINVAL;
>   
> +	cpus_read_lock();
>   	mutex_lock(&rdtgroup_mutex);
>   
>   	rdt_last_cmd_clear();
> @@ -1701,6 +1719,7 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>   	ret = mon_config_write(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);
>   
>   	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
>   
>   	return ret ?: nbytes;
>   }
> @@ -2153,6 +2172,9 @@ static int set_cache_qos_cfg(int level, bool enable)
>   	struct rdt_domain *d;
>   	int cpu;
>   
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>   	if (level == RDT_RESOURCE_L3)
>   		update = l3_qos_cfg_update;
>   	else if (level == RDT_RESOURCE_L2)
> @@ -2360,6 +2382,7 @@ struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn)
>   
>   	rdtgroup_kn_get(rdtgrp, kn);
>   
> +	cpus_read_lock();
>   	mutex_lock(&rdtgroup_mutex);
>   
>   	/* Was this group deleted while we waited? */
> @@ -2377,6 +2400,8 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn)
>   		return;
>   
>   	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
>   	rdtgroup_kn_put(rdtgrp, kn);
>   }
>   
> @@ -2664,6 +2689,9 @@ static int reset_all_ctrls(struct rdt_resource *r)
>   	struct rdt_domain *d;
>   	int i;
>   
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>   	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
>   		return -ENOMEM;
>   
> @@ -2948,6 +2976,9 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
>   	struct rdt_domain *dom;
>   	int ret;
>   
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>   	list_for_each_entry(dom, &r->domains, list) {
>   		ret = mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
>   		if (ret)
> @@ -3766,7 +3797,8 @@ static void domain_destroy_mon_state(struct rdt_domain *d)
>   	kfree(d->mbm_local);
>   }
>   
> -void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
> +static void _resctrl_offline_domain(struct rdt_resource *r,
> +				    struct rdt_domain *d)
>   {
>   	lockdep_assert_held(&rdtgroup_mutex);
>   
> @@ -3801,6 +3833,13 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>   	domain_destroy_mon_state(d);
>   }
>   
> +void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	mutex_lock(&rdtgroup_mutex);
> +	_resctrl_offline_domain(r, d);
> +	mutex_unlock(&rdtgroup_mutex);
> +}
> +
>   static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>   {
>   	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> @@ -3832,7 +3871,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>   	return 0;
>   }
>   
> -int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
> +static int _resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>   {
>   	int err;
>   
> @@ -3870,12 +3909,23 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>   	return 0;
>   }
>   
> +int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	int err;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +	err = _resctrl_online_domain(r, d);
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return err;
> +}
> +
>   int resctrl_online_cpu(unsigned int cpu)
>   {
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> +	mutex_lock(&rdtgroup_mutex);
>   	/* The CPU is set in default rdtgroup after online. */
>   	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
> +	mutex_unlock(&rdtgroup_mutex);
>   
>   	return 0;
>   }
> @@ -3896,8 +3946,7 @@ void resctrl_offline_cpu(unsigned int cpu)
>   	struct rdtgroup *rdtgrp;
>   	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>   
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> +	mutex_lock(&rdtgroup_mutex);
>   	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
>   		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
>   			clear_childcpus(rdtgrp, cpu);
> @@ -3917,6 +3966,7 @@ void resctrl_offline_cpu(unsigned int cpu)
>   			cqm_setup_limbo_handler(d, 0, cpu);
>   		}
>   	}
> +	mutex_unlock(&rdtgroup_mutex);
>   }
>   
>   /*
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index f3ef3ceb9c5e..2bbdd3d591ea 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -159,7 +159,7 @@ struct resctrl_schema;
>    * @cache_level:	Which cache level defines scope of this resource
>    * @cache:		Cache allocation related data
>    * @membw:		If the component has bandwidth controls, their properties.
> - * @domains:		All domains for this resource
> + * @domains:		RCU list of all domains for this resource
>    * @name:		Name to use in "schemata" file.
>    * @data_width:		Character width of data when displaying
>    * @default_ctrl:	Specifies default cache cbm or memory B/W percent.

Thanks.

-Fenghua
