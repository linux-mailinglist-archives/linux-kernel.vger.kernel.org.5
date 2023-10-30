Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F292E7DC232
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjJ3Vzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjJ3Vzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:55:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647A3130;
        Mon, 30 Oct 2023 14:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698702945; x=1730238945;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NQSTFhgZZFZyzqfFEAKnMharRWl+GtcEkqmo9kA/g2g=;
  b=TGV+SpyXlD+YKFXguUvIiht+yCxXRd+/ZuS0ZR1LkW7C2u3MypbQaiQW
   Wyk6nHyTCtH2eSyGRXW/lflEsxaMQqknLI6shhBbHBAUha7Ub8zu9k94q
   4uBQ9twrc0pqZb5czsYZXzpXB1c+FDtVATuSVkc0kbGrl7L6/H8BixCb+
   86xkJj0pBTSWywd7VnZD5WC4L+s+AC9OsEVI9Q5J8OYIJTAgaX0Vd3B0+
   /zEmhmiQc7H5153g3ZCbaOoJtLbOjlkpNqmHVsTkYfRG/fihK1OpBXNuA
   IP9ti0TOO1q2RWWK974Z2VDOqVdVCXCXpo/rI+Sa6/WnONbTF4f+lmuYT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="452442862"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="452442862"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:55:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="884014377"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="884014377"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 14:55:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:55:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:54:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 14:54:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 14:54:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcLjdmroLaSc6zSPlFqVc4bS+/3lUGPulMM8w/e7NajYgHYT0SZRfoSVQihjGR6Lhqekm6MSAnHnQUXyeVZ6wC3YrPm0nxgPEaRAIfV2Jec3vHmA7RCtT52IdTZsZa8fmgCyyA7r36yT+e6SQjEUwKXZXWSkc2Q+2ib7ryJx5wlCwgV40AiI6ewFCueoJPms0pFiZQIgQTANUzGwRowD4tk72RfqUz5uaON2NQ1WPaEWUl01Ke2V5UyfiC6PvrACMPnrdWIjnJwaTsFfy2J0cDhtHykF0SJ6CezVceNPFv7/weai+qv8ux0pRJ684laUQqyzDh4F3dgwSCB20AC/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3k4G8KudhWx6CFxVtLzY1qLfffgB5sCeTirp2tIBSM=;
 b=diEYr/2CatFosvzQYWfeNU5szwrD19IaPnzcyxGJsqNcR7sH8Xieke/Qv2THeUuFBitO0OaS9pwEe2KgbNuTubLvz3i3MCRn52puOid1Sk4Cxh5NJ9qNTCqOeNn7t9Xs6pM85X+lDE34oSrI8E4s4s/oe98NamYx5p/PVZYqGnCVu0ADvA3Rawekxundx04DFqbpY141iggrJEx7d6d76aPjM4/YHpJihkw3YqpKYMugsjcf/2Vf8duNFZj/q4ulJ+lFxsLbea0UpbKqDq8r8LIjYebdLFSS4Ka+dmUFAxr3bPfbIToBAogGwCJxIT3AQA7wItB/O2C21rj8V5PpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by DM4PR11MB5549.namprd11.prod.outlook.com (2603:10b6:5:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 21:54:56 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::f815:7804:d9a8:fdce]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::f815:7804:d9a8:fdce%6]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 21:54:56 +0000
Message-ID: <80d913c6-2579-4373-a00b-a6910cbb0b6c@intel.com>
Date:   Mon, 30 Oct 2023 14:54:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] r8169: Coalesce mac ocp commands for
 rtl_hw_init_8125 to reduce spinlocks
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
 <20231029110442.347448-5-mirsad.todorovac@alu.unizg.hr>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231029110442.347448-5-mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|DM4PR11MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: fc406295-84ac-48ab-4950-08dbd992dae9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rvTkWGvi9HNj4TqZahHVru0No8dmXaamya+WWmNAQ8z3Hg3iXqaANUhHugd1zni59BXVhXwvyRnJp9KceXdGse+0zTLRinstpZ1LJkhbi/yGxoM9GxWuburK+qD4cM1uWotiLUrcg55w6tYMz6Kl55VqLfpc3TeVKPeF5nhPbvPnRg0+9VMzf6AQcLB7n+Dx+CXJy4NQ+ePDZATgiEkmbCcohPQC5SgwiIgLeOnhwV/H3yIzWgTXc1uzYcdN6bBAWUBVjfduld/Az6ZeM59rHKluoJUupNDzR3fBR3DmBFbU96eoEDC1dbnvI5pbD5tOrm8FPZUe4r5e+AvHTdoLJMaNiqyLZr/ZYfAdhI01LCi9zANRcrlJaIge1Frfe31gvexgVdKPjdc9uBOu3wYCSoiwivc/4iEDhNVxViGOunf57D4FXwnww0TgeXlm0jVM2XWAUNtXGyggQ/SaZ3k1Xr+leu/bDfpMqwVy/CKyd3l7RsAlG2jv8hHkee+B2SpwR4vnNUyUZXrnAxmB8+RHma3MkWPaatLnbM0TDqu/eC5FerJ/3ZqRQSDPw4xFW7qraBSSaxlH9PtR0p6jqxt0rUZvhOyb3BWZ+WD8aYPMa3JVViivZrURn9oTBc3HyJpo8TlchAvT699+Ii9OJl6k/mWZlNhhCLUZI0dnbdl+HttMl+bZlYLE5bXquitYFhrS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(478600001)(66946007)(6506007)(966005)(110136005)(6486002)(82960400001)(83380400001)(36756003)(38100700002)(66556008)(66476007)(2906002)(41300700001)(2616005)(6512007)(26005)(53546011)(4326008)(86362001)(31696002)(54906003)(8676002)(5660300002)(7416002)(8936002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjNLTTNuaTFsa2YrTnRvR0NGcXhHc2FpYmVmVGZtNGZiWENrUUpxWlpyMU5M?=
 =?utf-8?B?V0x5cENqY1VvNEFwUGc1Zk5VUWlIMHZibkIyTnpSMk9UbzB0UHpmMkQwYyto?=
 =?utf-8?B?WWZYdnh5T2EwUlpZLzZ0QjFFMGYvYjdFWHBZUEhtWVFSTWx3bks2NWVoNVBs?=
 =?utf-8?B?Rld3cS9xQzlGMGNwKy9YdVRsak8wcGFrNTRNN3I4NE01WlZhS0NPNkVZU1FW?=
 =?utf-8?B?UWg2aW9TdjJPc1ZCSEYrL21ZRVJVcE9mZXAxNHJFMlI1ZU1mZXF6TW9qamll?=
 =?utf-8?B?bEdIVkh3K0JMeTFjUVJqSWgxMjVqeXdxV1JPZkhzY1hqSHRLQWVYSlF0VEps?=
 =?utf-8?B?STA4bGExVXVpYUVqenBKYzFpS2l0VUdYWWoxRXpzL3ViaElVcGxyZmd2M2Jq?=
 =?utf-8?B?aTFXMXE2NVUrZmZTQXFDaGJWMTNUR2dyMFQxMmRacFVEM2RmeGFLSTljWVlu?=
 =?utf-8?B?NC9kYWkxTjhXMGU4ZGhTUk0zK3dNcG0xZmV3ZmUwaVRCT0JERW1vekYyQ3Q0?=
 =?utf-8?B?NDRwdFAwOGxad2cwMDZJYUEwOTRBZkRVMmdHUHh6VlE2eGU4MWhTT01acFJk?=
 =?utf-8?B?NVNRVnIrSE5UMlFLeDFZeDIyOUpFSnFCSW5zZmlpRmgzOWd3VGhtZFFwQ05T?=
 =?utf-8?B?ZGYza2pydDFLU0xVcWRtdkR3UFdvVFRoMzNIVWdiZ21CNjJIRkoxYTYyUDNi?=
 =?utf-8?B?cDl3L2s4VURPVkNjRjU3d1ZxM1lkYUlUT3JZK0xVSk1ZKzJ1NlovR21rOFMx?=
 =?utf-8?B?cmVpUmp6dkJBUlpOZGZiZytKNWN5RWtCblRvSlM3NHZwWkhNQ2lFRmVKTnJU?=
 =?utf-8?B?NTZNVXNFRmpISjFSNUdPYTI2a0JwV2VBZGlSYzBsV3d1U2gzcTZ3Yk53UEdF?=
 =?utf-8?B?K3huZDZzNkcyOHBZNGREQVJVNUU0eEthY2NWMHUrSklyUkhiOWU0TEVTTGxJ?=
 =?utf-8?B?eG1iZUliZytSUlBRaUg2K1BFSTQvRi9HYWpOa3B5TnM1ZGs5RkhKcTlUclhS?=
 =?utf-8?B?RWxOQnE3ajFHcERtU09GVmdwUjhBM3Q5M0ZqdEwxK1VOdzluWW1IZytQbUM0?=
 =?utf-8?B?cXlPNjFLTXVOZVpaYTdBSDZEWkxpR0h6UzFXamJLeURncmFBTkxKc0xHYk84?=
 =?utf-8?B?MWw2NXdzSlRmVXl1RDRaSEhBWkM3Qk9Ld3BUQm5NclJZanNkdm1YTDNiWmNY?=
 =?utf-8?B?TzF6WXlQR29wcERuTFpMb3N1WEpDckF3WUU2aW5wMnExMldYL09Zak1SS0lK?=
 =?utf-8?B?Um5ZVTRMNitSWmlrWDdGNEFjSXhZUlRBNkZNN1YxU3VTY21iRTRqMFZsT2Jp?=
 =?utf-8?B?b3VMM2pUS01iVTFiRzVqdUk2KzdCSHVLZi9URFBMQjFsYXU1WXJNSHp5b0ds?=
 =?utf-8?B?V2N4dXhOSnNnSFFaUUlhdmVMaDFDUGJtVFdvT0owUlV0eXBlRzhnUGFJajFm?=
 =?utf-8?B?M3QxbERJL1ovaUVUazR4bmI1M0lCQ0FaSllTa2RpWjdKMjFNTm1HSFNBbjQy?=
 =?utf-8?B?SFZmZnRaRkVPSDZ3NXdyTUloWXRWditPdVJPVk5Zd0U5Z2RCd1JqcnJ5c2Rm?=
 =?utf-8?B?YmJISmJDbWdlYy9mVDl3Q0ZCT1VZVElQVlM4enBPYVhIZG9MOG82dkhCbTFD?=
 =?utf-8?B?dlpmTGhkK2xIMjFkN2ZtSHdoUFNDUStnTGlPQkYrT1Fqdzl0MXRZNFp3dUVn?=
 =?utf-8?B?WHRKdk1FbDJybEJVYkpMSVB4RW1tdDNsSjRVSVhYZFZMV25wMnQzS051Ylp6?=
 =?utf-8?B?T3ZxT0FmNlRRSVF2RTJKWjJXNjBRRFlXcDVVZU9VMEl1OG5KSXlNa2I5elZn?=
 =?utf-8?B?QzZJMEpOdFRoT2FtcW9ORDdHb2dEN3IyNEFSUkJMQUpkQTVSM0krbG9DMnUv?=
 =?utf-8?B?M3lIeVBXdjd4NENXR0lRRURjQnNpWDRiOVNQR1JMZ2hES1d6NVNoSWNkYzdD?=
 =?utf-8?B?K2ZJQmVxbmZ6Mm9RTjhDc1M1c09tdmJuODB0NFZibzdtRVpTb1UxNXJOdDYv?=
 =?utf-8?B?V0JVNVhkR0t1TzcrcEJVMFppaVhSb2ZvYURxNzhNeDNhQUQ0a2Jyazc5aFQ1?=
 =?utf-8?B?R3dYWXcvTjlBeE0yd3JrRksycW5vek9WbnB1TW9jYnBuZ2ZOS3V4TDRBeUhz?=
 =?utf-8?B?QXNQQ0FJSDI0QzVTUEgxRkNTOFowTFg0aVlHcVM1UHJIWlZSUlNVK2hZZk9y?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc406295-84ac-48ab-4950-08dbd992dae9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 21:54:56.5478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzngBYxpmoIZLKwbcb3/XTQzxwfmNwVs9VgvlBcVKWi2QP1Wj6+HWt3PuF5AoubLIgbUk2fjTLt48kEXv+bY83OnzLSvYsqDq4bUbC9rlBE=
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
> the init sequence of the 8125 involve implicit spin_lock_irqsave() and
> spin_unlock_irqrestore() on each invocation.
> 
> Coalesced with the corresponding helpers r8168_mac_ocp_write_seq() and
> r8168_mac_ocp_modify_seq() into sequential write or modidy with a sinqle lock/unlock,
> these calls reduce overall lock contention.
> 
> Fixes: f1bce4ad2f1ce ("r8169: add support for RTL8125")
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
