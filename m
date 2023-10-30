Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FC27DC22F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjJ3Vzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjJ3Vzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:55:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80914FE;
        Mon, 30 Oct 2023 14:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698702935; x=1730238935;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OH5MLYrCSCTlDgLsWiJxAiJ27YXTspPS0ynUpPnY+UI=;
  b=KDo7wfETenCGFQlCsYEJbhZ4IuCIaYIGLJAuL50gqd2hMY3xa7f7rxXQ
   /3WfdeoaHAfyasX9+Vci55dOtHQTlHg8llyngBZS7yEmHUdQk7mspJ8xY
   2DDmb1juD/7VhVhKlxUQ+RZeIttN9OvV141BOVg1vDnbzwsBi3FLEYBlt
   7RQ9scKQG47DGKOc7o3+s/jjd5jcD0PNNM6K8/6AcL+jiMYMHjgs6iMDm
   XbKH4g2qhTQSwFZP50S4fvW51GQkjlvOFBh16MeAHlPvK9QbS33Wtia06
   i9gHMU0qmuoHMNnrzG6LiRdZ0HMHBpfx4wy1+qXoeW1so5XlqOZdFASkn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="452442800"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="452442800"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:54:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="884014292"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="884014292"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 14:54:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:54:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 14:54:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 14:54:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QP5pPSXmJSAb2LTnVYvKsv3zYGMmwZE11fl0m7oGnXChMh1pZkoqjtcYdVdjYyMes1EkxnkwWEyIUvJ9uBGJkqUVUD14R4LC3Qfg+3d11kF1/WIJTgfeTgWWxyc1dr7LS6D/FtmDyIUDBAziIycwxZmNK6YkLg87ps7exgZGknMc5Q4R2wjaukTYYeY3WZNBWxKjvZfHiTSmt6n153Si0z5kaBX0H8cG3/YFaJovK22SEG1kwkM43rBSUIh7kspfumlAAwQSegUwea2co5BCR2GmSqZQLmQWMTmEC5V9zbwaQ8PI4VRjEtqKM1oda4zKEWPEiin5rwVf5ByjQgxCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMLF2pKQBzHOWK8H/2EzX9eEbglS8pGtckqTddMyWgs=;
 b=MoOKOeszQ4GDXgqFkbQeCMCyLrTp3Hy9q2QWInPMsBLBx3G4R5QanRQLapAlDtZTDyhSTXpqXI5MFhvzpfJgTvhwDv0j+lw/YM+IuTRLKvRNpVzT9dNwEG8Oh0QihuUXadBKEK0+tDYQNN5Omh1cuouGNNQVX+9BHJzpZpzamilr1vS2C/hFOlmE7kC5jSJPr7MiKZ+7Ap4Eiz7CC+el7fBuSQkBYLTT1qdzOnQ6jmrT7J2UAuWNhSoTRzoPPijPlhAm/OzVrkVt1qpMyI22vKLsdxaYmZSohrw4xlousUn5lYwcdQGobRUJ0vs7ao6nB2JfJNZw0MjB5XkPSrk0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by DM4PR11MB5549.namprd11.prod.outlook.com (2603:10b6:5:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 21:54:01 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::f815:7804:d9a8:fdce]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::f815:7804:d9a8:fdce%6]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 21:54:01 +0000
Message-ID: <457f625e-f74f-47da-8bd3-f558956a2ce7@intel.com>
Date:   Mon, 30 Oct 2023 14:53:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] r8169: Coalesce mac ocp commands for 8125 and
 8125B start to reduce spinlock contention
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
 <20231029110442.347448-4-mirsad.todorovac@alu.unizg.hr>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231029110442.347448-4-mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|DM4PR11MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: 2248208c-b0af-4139-6186-08dbd992ba0b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mw32hpJ7BYdltmDs+3+QtpeOHkFzxBHpJJ5oJtvH2B3w23qaj59Nl0u89ASbFEq4v47Zw4TQMka1Eu6EZBkSkwtVjKnF66UcVNsDWYt/g2l4kk7t4jd/MWqZCvS9qRVUwOTTYVIEtC8UvzCgZxUB4C/wrq/JLQBB4K8dGpSvnfLTj81dy5oFnZKTMt56MF+Fd1SPufrNVVOwENRQxCKT4mSE8AgnrT463rGwozlbfQo0A7PpAKhpM9ycVw50RWhpUfAo6UEm7VtW5MfdhIeUETbbgZQE77X8M7YNBUtcQSWGAXPqE4nkj5RS9b3WeGaqOM2aAj4fo4S2OL+/E5O3m+Y9KkmRi0qAiwfugVOGmU5gUy8bTUOtpY2BMIQcMt8qcSBn3NH3kth+HD1gW6jw0quFA5p8Yu/KQE8XweOm8yCY1tUuG7hprVfZeMyMUuIQhAwZtxKLHkYomRVWCHfftKI5+5vTZ0S5HASvqDwGUDGHQu2kSWH4+GRgEWe8J7aaaGf78rwA9PQ/tteD6syZTzSvEmoBDZoaJthyvcdWwBjNPRZCXDo/gsR+UDuT/mp00LY6rn4FBrqUMRlrNCSnM9F5ykjj7OlaHY9R+j7EjHM3fx5P/wHBxbGtIfQbgZWyxuF1W3GxxlXBHk8g1yqOF9BR1YgppTGeXS4YaRKPAxi6chCjYqwfe9KRH3+tRLiy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(478600001)(66946007)(6506007)(966005)(110136005)(6486002)(82960400001)(83380400001)(36756003)(38100700002)(66556008)(66476007)(2906002)(41300700001)(2616005)(6512007)(26005)(53546011)(4326008)(86362001)(31696002)(54906003)(8676002)(5660300002)(7416002)(8936002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3c4TTVnazN5SGx2VnFhT0lKWk9tZFdFUmVuRWF2S0kvL1FmQ3dqYXB4VnNT?=
 =?utf-8?B?Q3hjTDlnaWpNWUpveHk3bHQza1Y1VFcwcUEyd2ZRZmdoZDNqVXFUZkg4VXk5?=
 =?utf-8?B?cWZSVUFoWi9CdGFabE81dGlkYzd6UVNIdmVuTVlDWGlzc1B2SkhZSDRBNHN1?=
 =?utf-8?B?WWdqRmtLTkN4RzYxNFhrbHhVV0RTckxxS0RPTDdDdmJlR0t0WFVJR3ZNdzVi?=
 =?utf-8?B?Vm91aitObEhuL3IxM3JjTU1QZEJ0QmJ6VlBmWUxmK1hyWkdWd1V0RGN0SlI1?=
 =?utf-8?B?UDU3ZFhUNElWSjFMSHBSNmZ5eXZ3dndIOTZ4cTh5SEkyN2htSk9tYVJpZDNZ?=
 =?utf-8?B?YjM2UXBaTE03OVlRVDRuZDFMK2QyZlRMQUFnTXhaa0thTXc5QW92ZG9BTXoy?=
 =?utf-8?B?dVN4QS9iRW8vb0hGeHFMNU81cFJRUlJTVWNkWDlPZ0FKL2VPS2FBcVVVbDF3?=
 =?utf-8?B?aXBSWDlaN2xoTGJQdTA4SHRDQkFJaHFoaW1zTzVhczZDSTdYL0kxVm96TWVM?=
 =?utf-8?B?T20vV1BmbzZadERWcGhRbTliQTFEMWtMTlFLSXNPL2NWc2dkUkJyNGdsdVB1?=
 =?utf-8?B?NlEzallaYzkvckIvenVhWC9nZGNOd01qQ1FWOUZ4ajl5N2RiZW4xaklSeVJE?=
 =?utf-8?B?N2IrSVNBVXdxdDZCV250RHNLQ3RrbWpQVlJpbFJBeDBveGMxZGkrd2gvSWJI?=
 =?utf-8?B?cVl3bUluRjJFZlZha09OSHZidTZXd0N1VTNBM0VxVEhZL21uZUdJRW5tRE1R?=
 =?utf-8?B?VkFLVHJ2L2ZqdUhMaHl2clFXaEtBaXljZ0c4eHBBVWx2UkE2a2pKdlE5RTJP?=
 =?utf-8?B?WjExZDhzL3AyVFVleTZsMU5paGt5MC96WUlNT1FWTzVoL24wbmJNMk5LZE9t?=
 =?utf-8?B?NTl2YjlHUmdEV01Pa0NJYmhEWExyNXBzUFphSHZZMFlaaE1ESUIzcDVERS8z?=
 =?utf-8?B?dDN2Q3MvNUlrY2VPWkVTRHJKajBxdXduZEFyRTMzVHlmZmVSZERwWXIrSGlq?=
 =?utf-8?B?c2diaVpIKzVuMVVTOVRhZ1VVYjYydU5XTlBIOXNaNnlRZGpycVJ6WndmUkZC?=
 =?utf-8?B?aG90ZFpsdjQwVUJKRlViQWlKTWFjd29oTzUwSnQyeVoxK1c3OFNqUTBCSkN1?=
 =?utf-8?B?b05nTkI4cDMrWUhwMnF3c1VJaHlrQUVMVEswaFU3OU41MW12L3J3NnEvb1pu?=
 =?utf-8?B?T0JSNFdFdXluQW1Zek9jRUlYMk9jZnNodCtpRHV0RS90aFhGUDA5VjZiWXAz?=
 =?utf-8?B?T1hudFBvWTFMdWEzcCtjYzUvVUtGeU5wdUNUMmxReHJ2TzRRMm5ZQkhDQUV6?=
 =?utf-8?B?anVaT2tBUlN0QTRBR0piZ0p3K1hvNTYvWjBnd1lrbm9abnA2a3k4Slh3U1I4?=
 =?utf-8?B?dGZoT0g5amJuOHRYMTBpRkpsbUhyVWRtQkxKRnEyMnNHU29Xa2RoZGpUaVBa?=
 =?utf-8?B?MTViSUFlQ0NtZHZYd3ZvaFoxMkpKRlQwZm4vY3BDOHh3aWpOdXFhL2xiMHZV?=
 =?utf-8?B?M2wvZEVJaHhlOU1RQk9jK0tHZE9vekZTVC9qY0paZXQ0aFdwOXFYV25GMVNY?=
 =?utf-8?B?bzJOWmVaZzhJTXhuV08xczY3WGxlVFpEb01jd3pKWWpsVU91OUpjZEZvcTJx?=
 =?utf-8?B?ZlZBdTBBOTdSdS82RTdhb0VVcUVhTUViUEN1bVpTcUREallaWXIrU2ZoZjdT?=
 =?utf-8?B?UjgyRWMyZ2lnVzFKTVNYcWNJWXc5eVdQalZJWlBHKzE5WkQwLzMvVWVmc0lo?=
 =?utf-8?B?MXo4L1ErWlFXcVk1YzU1bWFBQ2FpN3k1SDd6MzJaTzdTYTk3U0ZyNURVMUF4?=
 =?utf-8?B?VUo3M2h0WVFUeDl4cGFBS0kxbFFzanNNYS9idCsxb1RnMVhYVEFaUWhkQm5V?=
 =?utf-8?B?Uk9vK2tLTHBEVGcybFVaemUwSWdBbkV5RURjempnbmY3L2tOSVBKNkt5MHlw?=
 =?utf-8?B?WmtHSUdSdkJHZEd3T1FIZHA0S2gxZllHQUNheXZ3czJ1N3RReUVDcGhRNldp?=
 =?utf-8?B?WTNDN1lRRjd3OWJHT3p2Q0E1cnIwQkxQNG5Da3F4bGdrTXNsUmp5dnVMYm1B?=
 =?utf-8?B?bmh5d0JqN01RR29MNlFtT2JRMzdRcU5ZOTB4MTB0bWVKb3dpajRwQjFvSFB5?=
 =?utf-8?B?Wm4wUEY4b0V1RlFRTCtQKy95Tys0OHFrUDRhWm9UM1dHZElOTUxqS1dNVVd6?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2248208c-b0af-4139-6186-08dbd992ba0b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 21:54:01.4062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CdQWw/NPQZp3c3pfGFPncF3p698kGd+A23xLMK++W62AFCVFDPnv67V4AOoN06d/4f6ccFc1T+BLdLJw60Pp1evzxJzMBdAZm2UVbfSEqM=
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
> Repeated calls to r8168_mac_ocp_write() and r8168_mac_ocp_modify() in
> the startup of 8125 and 8125B involve implicit spin_lock_irqsave() and
> spin_unlock_irqrestore() on each invocation.
> 
> Coalesced with the corresponding helpers r8168_mac_ocp_write_seq() and
> r8168_mac_ocp_modify_seq() into sequential write or modidy with a sinqle lock/unlock,
> these calls reduce overall lock contention.
> 
> Fixes: f1bce4ad2f1ce ("r8169: add support for RTL8125")
> Fixes: 0439297be9511 ("r8169: add support for RTL8125B")
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
