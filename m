Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1577DC227
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjJ3Vwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjJ3Vwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:52:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47AAFE;
        Mon, 30 Oct 2023 14:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698702762; x=1730238762;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0UlKHWQ/QTp7bqEuq52Tzo5TA2Fl9rzQbAiaMFp/NiI=;
  b=Sq2JAwHg+IHSETJURcgE97mTDNfHthIP1KgEPsqX47IMCwJfpDsBPA2Z
   M0wC8iwXvgHEfSN260YruJZ39jZ4wtsxw2u9LOuU+pk4JURMo8c4RE6/v
   mMyVwhTjU9yq+0MSeRjm2BUPpNH7tknpAegCZ6GKKsPZWGxYS7VuXnuuy
   lvBe7j4RDiQfymn1GD9LZUHiviN3lxITo25xGf5Gx8Z3q3/HFcmt3S2iO
   eW3HU2rRUvRUWJZY9fCXxVspiR56hmolXTBe1ed2X29+rEQs8LHnxgbGo
   dJqxOOqBFN6clzyHZam0hykW3Ex2mVCDWfOjZdgCtjnTDPAPeXOOUDNpP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="452442500"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="452442500"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:52:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="884013795"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="884013795"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 14:52:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:52:40 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:52:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 14:52:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 14:52:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFChiKyPn4Cltl4qILjlqQy3pwhhAkQtG25xJawX1x+Xzv/Hc01JziZ7/5QK8k4OJWVrWMrbflP9mYb4uto5aaofQPAOnFAXnqQEI+iLzmyYa1/CsnypCYXy2ksdMb8WhGQ08wzoM/QNPMX4y/hp/Z9gxETasNXIEYjMCGRNGpDKHETULi9ooryiocAUIpy7HoLgcUx5pTq3jvgE8U8pQstbLCRRd8ijbWvV0nCZRa9VJXDbAA5hDcu/XIj0SXkJxhyQlzMu95QiUwfbyuwr7a7CXpYFaLEq4ehFN5/QVkgrCG4Yg1iGl2UHnOZDqFjswSuLGNTKa3RjdC/QJ0rH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRDkt9mld28Rkh8WfcEzkpQeF4St82W5/pHa7pdVmck=;
 b=c6Hm/U7lKrcwPLoZQlPa9ZbobsCOO46yJXeiedNpwz3TPHrhQplQDDMlNj3VdU91dr7dC3ANgnKa/68ZDSZ8l/vkgdq0O8aZOzeLoa2PUMYvQd7ZldkO3swyU73wzIqTGqQqLxO88X+NbqtZfN6cvDKxtApKLtqTxU/Ip0gvxHF7sttSib6jvY5UblbesBAPsAzeA/ICTUwp0akJYmC+HPGqwtuX0aOEVen2QYErWcgMuPG0+f46y1YK7uK3gmKlHb6/DeaVz88kprF4WjmpVv6AQyAZu1Ed7wSbZcX2hMqg8cZmeGgqR8/8t2FYrfjC5h1tgGB/sUlEyPNNjF2erQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by DM4PR11MB5549.namprd11.prod.outlook.com (2603:10b6:5:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 21:52:33 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::f815:7804:d9a8:fdce]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::f815:7804:d9a8:fdce%6]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 21:52:33 +0000
Message-ID: <766f1321-ea01-40c1-832a-3989677e7d4b@intel.com>
Date:   Mon, 30 Oct 2023 14:52:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] r8169: Coalesce RTL8411b PHY power-down recovery
 calls to reduce spinlock stalls
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
 <20231029110442.347448-2-mirsad.todorovac@alu.unizg.hr>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231029110442.347448-2-mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|DM4PR11MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b6b7f7-342a-4b06-f061-08dbd992854f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +l4TyZk74yBBsttilN+JjodHnFX9PFThOzdX+bK4ojTcXbQdRGqKEEXwZtDw3/5HcO0OyNpPD7bOWBZ0vr4XErHZ5l3bdR38//6+r3/T8BjN7SPx+VJ3/4oz0co01aE8NMjX2dQ3CWheWG6QRj1F/MYEXLoWVo2WO8krXWx7hY/vGpWPdc4wCO2UJgoXPzsPxE12awEzA8gwFYkVoUiMW/Zqwk3G6vyp5854ulf3ZmfFhRQ424P0VgLjwW3Qbdoijd7i3EbC5j1udALE+5sSsnM8YikJdswLzLIFjQa3A5nYE38YGLiNg0juGLY3WYkA8uGQtd+AlH/xl9gBVd3v368k/aRpJIqTgYgeqtxzaPw8KjJWIQEfjCDvyxVyr+5SFOM2v3X6xfgiygnFTYaK/4BbmhzhaROvmYpSvb6HjQDYmQXW6jGXMctZP48DTdVSa8/ZBdTocGgNcMaOc3DsHNO3/nOJRvaU7L8tlxiiEan1gebnRn+C6+2gUREXQTSqFa5S4c6yrEQkBxUWswWaeHmWEx9vuUOKopezlpbrJya/Aix6lt3PFSNcB+65ZFmpDXz88OpZ/FWuDCyj4inf8NHY0YJtqW/8gRmG+ECXPWr1A2+YHXqk9kFWgOym02BS/By7ZsfZwuvPJ7Se6/8sFXXZcyiHjfIJkQ0KN7OUOBKhE9qNg96Ux+83UViBIc+H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(478600001)(66946007)(6506007)(966005)(110136005)(6486002)(82960400001)(83380400001)(36756003)(38100700002)(66556008)(66476007)(2906002)(41300700001)(2616005)(6512007)(26005)(53546011)(4326008)(86362001)(31696002)(54906003)(8676002)(5660300002)(7416002)(8936002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzBlUE5oajFHVmlGSGZnSDRWcUNKR1JCN2lZWCsvQ0ZBSjBzcEJrSXo2endv?=
 =?utf-8?B?T1BaRkZrT0FyaGVTdkxaZWlFWVdiYUNlNDFyY1pVM3VBMGZhTTdaS2RZcmlJ?=
 =?utf-8?B?OCtkVkQwYW5NNjdWS0xyOWVicUtFcnRRTjJ0QXdCdFBBbFloT1dXNk1QMW42?=
 =?utf-8?B?dnIvNjhPSGR6Q2pMdzJNRlNWOFNhQzl4TjFkMys3TG5CY1lwYUZSclRiNTRW?=
 =?utf-8?B?eHhBK0htbGUyOGhHWmNkZWFSWkl6RHVjL1lYS3lFU3owUy9mWmppQUNwejN6?=
 =?utf-8?B?TG1nN0tCN2pjdTdSN0xNdVpRMEtkNVdhS2dFd1Jjc1VodERURTRoMjgydnFu?=
 =?utf-8?B?UnErcXc3eTVoVDNZOEVmb2NUdTBhK2pkZW9UOWc0VmRjVkMySnpMSE8ySHhl?=
 =?utf-8?B?cm1IaTZxd0JPd3NWQ1J6clRSQXZ4anBsT0RiQXBsb0dRTE1HNVpMUUpDaWNG?=
 =?utf-8?B?V05JZlI5b1l0dDI3TFJ0VjAra25RaW4xbzFWOWttZlJaOUNpRm5kU2hFUnVC?=
 =?utf-8?B?K2JuUmhBMWNDWGFUdmtvc0dpNGZITFdvdHVrc0I2N0VHRlp5a0d5R3NGcXY3?=
 =?utf-8?B?YklIMjgzSm0za1JPNWt0T2hrcFE4anN6VkxNUmJYK2c4czNPMEZZcDRVbkdY?=
 =?utf-8?B?emIrUTZPdlY1RFVGZHhjUjk5bkM1UVlvZm53b2F3eXlkTWl4Ky9WYVVmUFZm?=
 =?utf-8?B?NkVSZktPVkRMWUdvaEpPVEt0eE5nNTg3TWRQeXBXZlZ6WTVBdHA4ZWVSdTNv?=
 =?utf-8?B?VmZMUDR3NXB2KzFzOG5PVlZBcVBuMmlTc29PcGxXMW9RREsrODRyczZ6T2lB?=
 =?utf-8?B?eU9GcDNZTGZlZUtiQWZkMWQxM0djaUtFZGRnNGltQm9WVzZHNXpYbi9KbWZw?=
 =?utf-8?B?azVoOGN3Qy83YjZSRkM4eDlrUUZMeFVERDZNWEI3ejBTbEVEWTBMV28yeXRo?=
 =?utf-8?B?T2VET01nQzBsNEphOHltZVA0WjlyTnkydUcvV2JKT2I3WnRtOVAxQ3VmdUp0?=
 =?utf-8?B?MmpCZWVJazVTR0ZvWk1JRk5oV2xHcnFJUTFVWWdHVURROU9rM0p3Zm9HLzMv?=
 =?utf-8?B?cy9acFpEM1paTHIyZSs3SWZFMU5oSStsRzZPT3VqTjM0RjZVZlZia0hhdHZN?=
 =?utf-8?B?Yk9zZ1dDOUtHZkVUcWlGRnhucU9BdkRvV1ovaXVGckI2TkFkK09QL1l0Qi9n?=
 =?utf-8?B?Nld4ajZXYTlONDg3dkJ0ODJDd2pLRlkzcDM2bzVxVnZydDdMVjVNamdaMGVs?=
 =?utf-8?B?ZjljZnpxYzk5cDloU2tNSjRjeEw3RGZQVVpId0xrVFJad3htaWVmL2kzT0R1?=
 =?utf-8?B?ME1sR3NKbjEzQWc4eWF0emNTN1hKdFlEVEJGcDZHMUlLM0tBYXRDeURvajA1?=
 =?utf-8?B?ZWtZTDlsdnZ6cXpCcmYyY0hLRUV2UnZXc2Nja1VNRkJ4Z3lnSCtQZnVxRzFr?=
 =?utf-8?B?SHJvakY2cTM3VHBGaDgrbVZXTHZSQThNbTZtUDZLR3BCcXBueGgxM2RrMC9n?=
 =?utf-8?B?WWFLYUhNaFNOQUo0ek14dW13Z0E0RTZrTSthQTFnQkt3c0phM1o5WXlUUThq?=
 =?utf-8?B?THl0Z2F1Z25zL0cxQkRaamh2WXJwV2hYckQ4TUsrRHhWVFhWNE9mcXd1RXc0?=
 =?utf-8?B?bHE2TUJzWlh5UkE5aFM1bXpxODhLOE5wdExyOFJkMzBhQUNkaWUyck5mSkNr?=
 =?utf-8?B?aGtkQXpNOW9MbGUvRHRQc1NDVzZEcWlidHV6VE1zMnd1blhaRkIzclRnRzdN?=
 =?utf-8?B?ZDB1SWhqSlMrMWx0MHhPcVVWMGNWWGhBaU9MWDh3NnRTZ1FhVjRxRUJWeWpx?=
 =?utf-8?B?b0VueGw2bUpDdWJDdTNzKzJERjV6RSt6Ym9KY0JaeWtEVGpnWGlNOHk2VTZH?=
 =?utf-8?B?UFk2ek0ybDYyRnYvNkl2M05TRnZyUnBDNXNzYnpXSGRsaVVnTWZ2R2xjbFhB?=
 =?utf-8?B?WFUyamVjcGhidkRta1pPRW1SeUdWblJqdGJ0K0x3bHd5YTB3a0hjSUJkbDdM?=
 =?utf-8?B?cEtYaiszZTZDaGc3VXMvTmROMW4zVXhkcE1VUG5WOVNEK2dyMjRHYmR6NVVm?=
 =?utf-8?B?NjlHMjNqZHJZRnR1cWhoM0Jnck1PRGQ2RU05c3l1dUZQNUU0clkya3d6azRw?=
 =?utf-8?B?YjdtdGd0c2ZTdXRzakJLbDVHVWRvaDZ6K2hXRkliUEE3Y0FsMVpoakNYOTl5?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b6b7f7-342a-4b06-f061-08dbd992854f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 21:52:32.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMs58hD8f0YHIttAMdD8MQrF6Yuo9Dva+61ui/B/QOL8IVB3SA9034uJy1+PjkjEIYwb8yFuYgBLk79KFNW7JihvBjHXCcKEh36FWXuRmbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5549
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



On 10/29/2023 4:04 AM, Mirsad Goran Todorovac wrote:
> On RTL8411b the RX unit gets confused if the PHY is powered-down.
> This was reported in [0] and confirmed by Realtek. Realtek provided
> a sequence to fix the RX unit after PHY wakeup.
> 
> A series of about 130 r8168_mac_ocp_write() calls is performed to
> program the RTL registers for recovery.
> 
> With about 130 of these sequential calls to r8168_mac_ocp_write() this looks like
> a lock storm that will stall all of the cores and CPUs on the same memory controller
> for certain time I/O takes to finish.
> 
> In a sequential case of RTL register programming, a sequence of writes to the RTL
> registers can be coalesced under a same raw spinlock. This can dramatically decrease
> the number of bus stalls in a multicore or multi-CPU system:
> 
>     static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>     {
> 
> 	...
> 
> 	/* The following Realtek-provided magic fixes an issue with the RX unit
> 	 * getting confused after the PHY having been powered-down.
> 	 */
> 
> 	static const struct recover_8411b_info init_zero_seq[] = {
> 	    { 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 },
> 	    ...
> 	};
> 
> 	static const struct recover_8411b_info recover_seq[] = {
> 	    { 0xF800, 0xE008 }, { 0xF802, 0xE00A }, { 0xF804, 0xE00C },
> 	    ...
> 	};
> 
> 	static const struct recover_8411b_info final_seq[] = {
> 	    { 0xFC2A, 0x0743 }, { 0xFC2C, 0x0801 }, { 0xFC2E, 0x0BE9 },
> 	    ...
> 	};
> 
> 	r8168_mac_ocp_write_seq(tp, init_zero_seq);
> 	mdelay(3);
> 	r8168_mac_ocp_write(tp, 0xFC26, 0x0000);
> 	r8168_mac_ocp_write_seq(tp, recover_seq);
> 	r8168_mac_ocp_write(tp, 0xFC26, 0x8000);
> 	r8168_mac_ocp_write_seq(tp, final_seq);
>     }
> 
> The hex data is preserved intact through s/r8168_mac_ocp_write[(]tp,/{ / and s/[)];/ },/
> functions that only changed the function names and the ending of the line, so the actual
> hex data is unchanged.
> 
> Note that the reason for the introduction of the original commit
> was to enable recovery of the RX unit on the RTL8411b which was confused by the
> powered-down PHY. This sequence of r8168_mac_ocp_write() calls amplifies the problem
> into a series of about 500+ memory bus locks, most waiting for the main MMIO memory
> read-modify-write under a LOCK. The memory barrier in RTL_W32 should suffice for
> the programming sequence to reach RTL NIC registers.
> 
> [0] https://bugzilla.redhat.com/show_bug.cgi?id=1692075
> 
> Fixes: fe4e8db0392a6 ("r8169: fix issue with confused RX unit after PHY power-down on RTL8411b")
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Marco Elver <elver@google.com>
> Cc: nic_swsd@realtek.com
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/lkml/20231028005153.2180411-1-mirsad.todorovac@alu.unizg.hr/
> Link: https://lore.kernel.org/lkml/20231028110459.2644926-1-mirsad.todorovac@alu.unizg.hr/
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
