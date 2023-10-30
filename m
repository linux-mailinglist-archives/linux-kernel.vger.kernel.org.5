Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4BD7DC21E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjJ3VvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJ3Vux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:50:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D969FED;
        Mon, 30 Oct 2023 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698702647; x=1730238647;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8RJJKkaDkXDCvliUBHtkSB8gQxSspnWXMxevO9uhG6A=;
  b=mrneyRFdJT1CeAMf6JNyjK5n12x9nfYuZVFD+p1Zsos2FQzCdFTxe0kS
   23mu9Ss80YKT4Jerk2BPNEP1lecoZXVjvpv/WqXdGjwStHJBW26pqJmcz
   bj3of3Qn1oP9kgyGDEVA4DFNIlXgsOyEeE9TRygOBsHHa5cem+QplyNe0
   D5kCaG63eUgGoXbZh/dAoNoBDg7QK7gbsIBydZm/KZCiV3gbP1gfUFnbS
   sQnio8qxbn3Gv6X38JOQYOCBnItga4kMh5V/sdsKL3jI2qyniVaLW9aVd
   nQq9muMPiojqLtvtHWerIYpBRrO3tUHls9K0HJEobSuTqL2yHkswcEZRI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="452442242"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="452442242"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:50:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="884013454"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="884013454"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 14:50:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:50:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 14:50:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 14:50:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOXuagIIwF3BpvFhMHIN7Tw45LZIUPRPYV3ToaMTEvT9KT/y1pz8tqIdvG9KV7NGLnbB6kmZheckV+OTwihQ1KkMxwj6B7qcJihQjXAheISwtMi1CJrTHS87V0+CC1ye4uSz8aL9eHPTIeVWHlwi9xvYPMCtOz6HJY6A5I4eju0cvWu4zxVWvg1frNo4CczRcc+UxOSOBHvny40C+HPI+nbuHotgW+M04t8ZLGQllANmB6oDQq5l7EETFQgIM06FdSXhhuRmckFk6LUvkgmKekoE0e4ES537asYPjcRdD46iX0qV0Q84NxEt9dWBF/o8JdvZ7KKJTtSJ/x9IH/hE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OpG3AEt4+z94vb1ZOc976fle/dgZ94h8hBg5zn80wg=;
 b=obIdhhOgf76ZliQ886V1zEXDPWSjdrhUjfl/tueXZvwC4MIfJ1mT1E53ZcHOG0UWzCWBjb6a5vhM0trszmCx91d0PCyjzIXqIeAhERq5OyBl57jsDx4Vcsp2WntdyZCEZJurM08ZYl4CS/6lFQ88m1lHbyQ/og0eOLvVXnVgiLC7cKwuvZycAnTuWjqY3J+OXgIfbFYRyO+MdlwIUgn/WyZblkZwBTvp8kdrA0oUikAJScZmfGMqS/T+i5YB//hy9bdeu23SXkqUdp/Z/TfMalVF1PSdQ0l/7xvPTox98sPq/gD9hYYQ/b9sZFv5Ttotwbk99/ReIJugThMUKOoqfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by DS0PR11MB8072.namprd11.prod.outlook.com (2603:10b6:8:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 21:50:43 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::f815:7804:d9a8:fdce]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::f815:7804:d9a8:fdce%6]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 21:50:43 +0000
Message-ID: <e7a6b0c1-9fc6-480c-a135-7e142514d0e7@intel.com>
Date:   Mon, 30 Oct 2023 14:50:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] r8169: Coalesce r8169_mac_ocp_write/modify calls
 to reduce spinlock stalls
Content-Language: en-US
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, <nic_swsd@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20231029110442.347448-1-mirsad.todorovac@alu.unizg.hr>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231029110442.347448-1-mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:303:2b::24) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|DS0PR11MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc5fa9e-99c0-4d29-0a64-08dbd99243bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aj+46v93qkbSa0xJXmMRp3tlhJ+Gor+EkwvFNvjsphecnLICLjy2cq36wKvwv1peayjZrhtFtDGiYMwE1idavA1bSPGvdOMjZRHASdHdmHrR6RcVh4ikB+QgAqfeGw4YZxA/Keee2GDvgzVXlmTPIpJesK3ekW0zYMWlQUVBDJkc+rkp6Nwn2tnHreA2Jw/g1xix4WPpEC7NjCoz1sXzy/ZH4hi1hu0SeAuw7YORk8AiM0C9b2FqL9BzCs/kmu2TbqJWU5x0Y7uwaA9xZaotswBfJHJ0pabp4oSbG9tS1WzmaBfTRUAIt2WSINNbczSuj3e36JkCKVpdfbe8Z9BIVnrJu5mpVo9Ex5yT2ugAgDyJ+lXXhxv9fZ7NYJG2HumyOlvwBrlPC2Tp7G0SDMjmL7tuC2f/9JfbFI1x/eSo9SigMA7t3kbZreyh6bFiOOBYfFckRbyaLro/OtccDJKvW6EY0LYjAZ7tvh2fBMO+mYizNnUClfSbRJdb5dleaVy60TpRhXGsdlbv6muHrT898gt7upDWhjFTJIrrIrdvdajFFcdL0Yw84P8pT7TGVOH5h4ToA6yOQYBBll8ciIXtY9yMpkoXleZ+2RVZPLMz05GDR96QXJaM8VnoiUUDjcWHgP17YD02tzTHOSvSrI3q/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(316002)(5660300002)(66476007)(66556008)(54906003)(82960400001)(38100700002)(6666004)(6506007)(478600001)(110136005)(966005)(6486002)(83380400001)(66946007)(2616005)(6512007)(26005)(41300700001)(7416002)(4326008)(86362001)(8676002)(8936002)(36756003)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDBmY2VQVUkzMG9USnNqV1FwejMrckFmRGdHRE50emJYdjV6T1BzNTM3c2JP?=
 =?utf-8?B?cWQ5M2Z3M2JMM2w2dHY3Mm9oaWtpTjBDb3dwWUlBczVYVlVXV0tCYXdtWWpI?=
 =?utf-8?B?ZGdYSVdJbXl3TnR2Uzl2cDVqMDFzbEZUdmJ4UjBuTk1QQ09lNHAxMDZodk9E?=
 =?utf-8?B?Ym81VUo4cm8wSTJmMHl3VmVQbHBaaVZPS0FFUXI0MVViUmtBMkpoR2EvejZC?=
 =?utf-8?B?aDM0Wm1jc2U3bEJmZnM2VE5ObENwa0dOcUlLN0JrSVZDNUptWllPMWxZaVFr?=
 =?utf-8?B?dTFYdUw4TjAvNndJQ28wUnVRNUo5cStvOVNGTTlWUk1qYnpEbjkwYWl4eWZN?=
 =?utf-8?B?ZjNENUcyVEZ6ZW91aFEyZnJSQkZPVUd5cTdyYkZGVThCVm81YWEzQ2w5N05o?=
 =?utf-8?B?clFYY0U5SkR1V2lXa2VmRUpsQ3VjNmdKR1dwcEY4dStiSHZPb1NRQWYzSFpR?=
 =?utf-8?B?V3dqRXpMOHk5Q3JFQllRKzhNMitSVFoyc3A0Zm04Y0NjcHNEbnFXT0Vxc1VI?=
 =?utf-8?B?NytucmZQOURDcFpCYnRtTUV1SExYQnJTWitRMEQwUlFpalNuZWtDTko2SWpF?=
 =?utf-8?B?U3k3OUduYUdRVDgxbDBJQW9OOTRlOG9paHg0eWhnZEpVSU1PUU9JUDUxTEdX?=
 =?utf-8?B?andxeGNTYjlVcmNPL0t6NGUxdVF0N0Q2UjFOVGpWVkM1OGFGZ00xL1JxS2RN?=
 =?utf-8?B?T1YyNEZWRlVGZVNaZFB1YncycGdJcElJbHpvbW5MMWpyWDNRdkZLK2lCOUhH?=
 =?utf-8?B?K3ZRRHkzUnBjM3M2TGlaeDlYR3pBRnJ4UWE0VFpQM2ZoTUp2OTlDb29ualNJ?=
 =?utf-8?B?aVFzRmpNQVBVdHpHT2pERnhFS2dwWFNTdG0rbHkwWExZY2FzV3VnSUpXWXlW?=
 =?utf-8?B?d2JLSDdvVmFVL1FpTkk1eGR0cGE5RE1KUE0xdGx1UGl0dC9WN2JrdXVEUFBx?=
 =?utf-8?B?UVJnKzRyV2N1SEYzVVlaRy9ydGJ3bHROeS9GNzNnbEM3TytCMDByRmEzeWx5?=
 =?utf-8?B?WU1yck1CSFp5djVqZ2xYMFdWeTNRbkdlSVNaTnNYNGM1N3UzV3lLYWhuazZ0?=
 =?utf-8?B?RjZ1RWczakJyWjcyTTRBRkdHSVhMSXNlRFN5TkJNMWYrWThqNWZoamZ5ZjV2?=
 =?utf-8?B?RWhyRDVJWGlKcWZCRFVtTU1FdDJkc0M1YU9LaVhRNXh6WDRzNHFORXdDcTIz?=
 =?utf-8?B?WU1GK29rcmljUEF3aStCdXIyWThmc0VRZWFOSmFGTlFiL0FNM2NmYzVGL2Vl?=
 =?utf-8?B?NkxaNy9IU1NsQ1U2ZDhaaERoMTBpWlR2UGZ3dzN5elAzUEp6cHBjcm9SM2tk?=
 =?utf-8?B?ektQTzZ1dzkrZ0Q2cGs1bm9UOVZ3Nm1kQzlIdHNieDdLTGJNTDRQcXJ2cWYx?=
 =?utf-8?B?RUJtRTNMOEx2NVVVRWxFOVNjRVJ3aWE1Z291ODdLNFc3OS93OVBUR0tRb2Er?=
 =?utf-8?B?MHBDL3M3Y25CVDB1VUdMaTZ4Q0dTUkhPYlBjblhoYnJmNFNuWVhnenhwY0gr?=
 =?utf-8?B?K01NYURoUmNqNkI3dGZQeG1WZnRxdDAycllrL1hwdGZRRzdKWGNoaVhpU0pm?=
 =?utf-8?B?Vk1KK3p4Z1ROZWZYY2oxMjcyNFE1NUczRkdpWGZiYmhqVkVtWiszb3gzY3Nm?=
 =?utf-8?B?cTgzTnNHWjFmSmx0RHR6VG5CMnMzZXBzSloxVnFUYWxhamsvRVBpRGU3UlJo?=
 =?utf-8?B?ZWoxWlJRUmJLTWM4M3oyTE9oQnBCMHpiNy82SUh6ZUZYYVpDZXQwWk9NS1pq?=
 =?utf-8?B?UFlaa3orbHpHdWFzUEdJdFpQVGVDeDlxcUs1UjJ2d3ozdDBFdk92K3hvQmNI?=
 =?utf-8?B?RnNLNkNHeWpUK0JYQ3UrY2hzTUF1NytDby9HdUl4L1RPb0gzd3IwWkJ1bzRx?=
 =?utf-8?B?N0RWa0FZVWtBSlNHZ3ZNNWZWQ2FBR3VoL1hMc0FTWmd1YSs3OGNOSGdSWXFr?=
 =?utf-8?B?b3c5dTdjT1FyQU9KUzg4N2NmYVJ2OVNEemJGUlZ1VWVaKzFKdFB4WFhLM1dX?=
 =?utf-8?B?U2tGUzZhSlZqM2o1RGhybDkvb2RXN1hMMjNkVi90TDZZZ2JISjU3K25qZjBX?=
 =?utf-8?B?TzQ0NEtvOHBCakpCamNjTytYdHJtUU50TTl6TjVGK1ltSGRjN0ozVFlXSi9k?=
 =?utf-8?B?eG4wZ1RGS1hpSW9kZFBoVkJOL0FBZGRScHYvWkdtaHlremkrM05OWUhmRVZI?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc5fa9e-99c0-4d29-0a64-08dbd99243bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 21:50:43.0404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmNgeGwNGM4wQTgmvu0vzo+1PLlJdH5+3pOKKQ4Ut9h2zYMGyyWVxRgCvL4vQlh5BUlqTQHj/mrTWdrTWWdIVo+G7RXbGnwuqiUSf7aURNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8072
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/2023 4:04 AM, Mirsad Goran Todorovac wrote:> A pair of new
helpers r8168_mac_ocp_write_seq() and r8168_mac_ocp_modify_seq()
> are introduced.
> 
> The motivation for these helpers was the locking overhead of 130 consecutive
> r8168_mac_ocp_write() calls in the RTL8411b reset after the NIC gets confused
> if the PHY is powered-down.
> 
> To quote Heiner:
> 
>     On RTL8411b the RX unit gets confused if the PHY is powered-down.
>     This was reported in [0] and confirmed by Realtek. Realtek provided
>     a sequence to fix the RX unit after PHY wakeup.
> 
> A series of about 130 r8168_mac_ocp_write() calls is performed to program the
> RTL registers for recovery, each doing an expensive spin_lock_irqsave() and
> spin_unlock_irqrestore().
> 
> Each mac ocp write is made of:
> 
>     static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg,
>                       u32 data)
>     {
>         if (rtl_ocp_reg_failure(reg))
>             return;
> 
>         RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
>     }
> 
>     static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg,
>                     u32 data)
>     {
>         unsigned long flags;
> 
>         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>         __r8168_mac_ocp_write(tp, reg, data);
>         raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>     }
> 
> Register programming is done through RTL_W32() macro which expands into
> 
>     #define RTL_W32(tp, reg, val32) writel((val32), tp->mmio_addr + (reg))
> 
> which is further (on Alpha):
> 
>     extern inline void writel(u32 b, volatile void __iomem *addr)
>     {
>         mb();
>         __raw_writel(b, addr);
>     }
> 
> or on i386/x86_64:
> 
>     #define build_mmio_write(name, size, type, reg, barrier) \
>     static inline void name(type val, volatile void __iomem *addr) \
>     { asm volatile("mov" size " %0,%1": :reg (val), \
>     "m" (*(volatile type __force *)addr) barrier); }
> 
>     build_mmio_write(writel, "l", unsigned int, "r", :"memory")
> 
> This obviously involves iat least a compiler barrier.
> 
> mb() expands into something like this i.e. on x86_64:
> 
>     #define mb()    asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
> 
> This means a whole lot of memory bus stalls: for spin_lock_irqsave(),
> memory barrier, writel(), and spin_unlock_irqrestore().
> 
> With about 130 of these sequential calls to r8168_mac_ocp_write() this looks like
> a lock storm that will stall all of the cores and CPUs on the same memory controller
> for certain time I/O takes to finish.
> 
> In a sequential case of RTL register programming, the writes to RTL registers
> can be coalesced under a same raw spinlock. This can dramatically decrease the
> number of bus stalls in a multicore or multi-CPU system.
> 
> Macro helpers r8168_mac_ocp_write_seq() and r8168_mac_ocp_modify_seq() are
> provided to reduce lock contention:
> 
>     static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>     {
> 
>         ...
> 
>         /* The following Realtek-provided magic fixes an issue with the RX unit
>          * getting confused after the PHY having been powered-down.
>          */
> 
>         static const struct recover_8411b_info init_zero_seq[] = {
>             { 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 },
>             ...
>         };
> 
>         ...
> 
>         r8168_mac_ocp_write_seq(tp, init_zero_seq);
> 
>         ...
> 
>     }
> 
> The hex data is preserved intact through s/r8168_mac_ocp_write[(]tp,/{ / and s/[)];/ },/
> functions that only changed the function names and the ending of the line, so the actual
> hex data is unchanged.
> 
> To repeat, the reason for the introduction of the original commit
> was to enable recovery of the RX unit on the RTL8411b which was confused by the
> powered-down PHY. This sequence of r8168_mac_ocp_write() calls amplifies the problem
> into a series of about 500+ memory bus locks, most waiting for the main memory read,
> modify and write under a LOCK. The memory barrier in RTL_W32 should suffice for
> the programming sequence to reach RTL NIC registers.
> 
> [0] https://bugzilla.redhat.com/show_bug.cgi?id=1692075
> 


I might have chosen to send some of this information as the cover letter
for the series instead of just as part of the commit message for [1/5],
but either way:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
