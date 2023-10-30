Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A247DC22A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjJ3VxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjJ3VxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:53:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F62FF;
        Mon, 30 Oct 2023 14:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698702795; x=1730238795;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vbdjolTS/0gJ8pCfY5/YRPkPUH66XO6NLLR883dH1bg=;
  b=VKzMuvVanN6XT7gUIM1SJFvHbGrcOhGv68ta3UboeDQw0iNF06hISo7S
   SOEumrk4L9FR1UntB6liUvH5SD6sEb/C7MB/6tOlquRq4sRrj4pONLpiK
   4Eo/CV/xphCTH3lFYAPn4G0XjZgRQmoufiwR2hEPluXRQXrk9vYqdvJLc
   r0djqiAJPrnqk+nCVb88xdWEXko5CJtnPZBu2741kGghZTBvC49sNcslH
   RLhUEXl0nMzewEvvK0M7SNEw/trnovCF4zw8TT2Cp58ilkSu+Hmw75TLn
   sFDjZoUREBF0ndXg+aszCMIyYkrBFMkgsiU18MUFbV52v/PxoQbJWWLHD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="378556701"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="378556701"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:53:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="933911361"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="933911361"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 14:53:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:53:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 14:53:14 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 14:53:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiwxZNpOhsPDJvreiMYE/AisXv0yOf/TqXckbCcAw4xB0uJNRrBNTIpDsJE+zxjCa718CllfM8ZgxXjYv1JTx1j5iwPYaZg/uivj32IEjbVbH4wM22XacinzgN9XFqQuyseIrz9tEYLx7bb6WSDnRl2iKzEgFN64M2+0c+fRFGe14+DnBuHmFUjlEZokxbmTPzT45ABCjRDlK+yB3Qitvcpneh3hj8J/3GJZDlVLOOHzK6S2SlFWwO0kggoT3dkZpe9C+o+kJpNlP9g0ncvYGNSBFlC+Rsm5+rrcM1MD9yWYybMu/63hEJTuflQ5MtFIM6oKZiHkFY444S6K1gyvgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paCfBqouKJkaeNyKjYGV/LMC+bimVeBxKT9icWQKZvU=;
 b=UVV3mizwQklChWuddUQSxpUmcI/AOU8AHfuna0o0e8OxarEiyW562OhFSKu//2o/Xj4r14Toeys/n5Omhtv/0dfuiVLwTPjXIiNR3PBrfnEhuwZLQjsdP4SH8OqDQfFkvrcaN/qTK17j1m3zCaMs5IN4jaACzndM23mZiLc43smI/CVc/pvt3sVyzjtuz7yzvbsqm4JPLSG4P29Azn3tHGKZFINymAG0NoohfQ7DXzZWfb7+SRzihQpAuf80SX9SVYu2uPqk9VQU6EOkynkgIVqzwiBCxmzn6V/uClS4x48+xRs5CpDXLhrY1EU7D0YjLnbTMdulf6LQ2lvjPj1zNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by DM4PR11MB5549.namprd11.prod.outlook.com (2603:10b6:5:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 21:53:09 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::f815:7804:d9a8:fdce]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::f815:7804:d9a8:fdce%6]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 21:53:09 +0000
Message-ID: <ef101904-a615-4527-8d8f-1f43b3d997f6@intel.com>
Date:   Mon, 30 Oct 2023 14:53:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] r8169: Coalesce mac ocp write and modify for 8168H
 start to reduce spinlocks
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
 <20231029110442.347448-3-mirsad.todorovac@alu.unizg.hr>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231029110442.347448-3-mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|DM4PR11MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: dca96bcf-cb13-46e1-b716-08dbd9929ace
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iugxRr0hRHBT0/VhSFvBcHdk1s/zLmGmgFZiRWS/0E7ENiryjsfrhhFRRnX19xKz6WTUVSTz2YeZBDDBUL6nEGLuFU8XSYxbws/xAAHKXIIh2w64gSL8qA1ULGC6J5b+IMZ63Su4ssRwFPRvQtbUEwSbjdivore9My+wM9mkc5a0o7Y2E5VTSPkUlcPnxGxUwCeO0l+D6AL3OK7TjkXHrcY5wkclVQN0nKAT6GnvxBFKeYt5mz04hRxL97AFlUT97WfMAtgfa+iFcKB/nyn6M0GSNL5nAWpeljxfAMMvlTo5fMnJbHHTYNpp7VOnkLayQLaCNmViWtbp6mhLejP1UyjgeBSgnXgcr74E8N1nhfrzNzKUB8esnEL7D9FuiXg4oP+5kz6Vh6M3WBCJiZEHsj1T7d4wH8hFCYFsLIa1zOafjt3Hxjo6UhLLMCHxV3tptTCRQiyE4Nm5fWw6RlAuTCaLkog8dDiVlxl9aPqGr29u/DdfMGry8YOlD9+XQBuy8n/BrEnKt+eo585EhEFnHPudLGfoyBBiIzNQZR4YCZl3OLAmxaUnGoGfG4+BgVrRjpG0G942nQpMbPQE9Oi5aGvn3YMOECU0ukjq7xGiR0lzLVoFS4hEqN8Um/V/T/RtoaM5wefpc0jvWbA5JfoIDHOZftnEsSuLG/dErOzmo8MH1WIyLtTiI04bB0m+idf9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(478600001)(6666004)(66946007)(6506007)(966005)(110136005)(6486002)(82960400001)(83380400001)(36756003)(38100700002)(66556008)(66476007)(2906002)(41300700001)(2616005)(6512007)(26005)(53546011)(4326008)(86362001)(31696002)(54906003)(8676002)(5660300002)(7416002)(8936002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG5tNGozOTJBTHFGSno3ZnRYN2RrRWRPM21teHRTKzB6ZGN1WWNkV01vem94?=
 =?utf-8?B?V3hJQ2E4cnArUzVXZWh4U2k4Ky9VWWVZM1QvZWJRcWRxZGJaVHI2MC9ucEhj?=
 =?utf-8?B?UXAyek1KUmt4Z3VGcC9GVHhmYkNYekt4WjdYZWFtSzBEZEpHVVlaSi9BY215?=
 =?utf-8?B?cFVGZ05iS3UxVVJ1UG5BaDIrMXQxclNJUGVoaTJQcVBBOC9lSk9lME5vRTBY?=
 =?utf-8?B?Y2dUcitBaHNoTUFsd0dXRWVZR29KekJkUW1IdXk0NHVkU1RJeUpXSXVEbSta?=
 =?utf-8?B?Zlc0b1BVZ3BNL1dSTHBMWTVkNlRJOU5ZcGoyTUQ2eUdtVGVoelNyNGVNcXFa?=
 =?utf-8?B?K25nRWdMa05ybHhiTHlmaDVnV29sdjhzOVJzanRUTjdVbmtTYXhBN3dhN3hZ?=
 =?utf-8?B?dkQ1SFZoTE5KTkNRQkk0V2FHRXJlWm11dW9WVkNhQ1I1L25rYWI2d1hnbG96?=
 =?utf-8?B?YTd6THY5bXcwbnBUZ29jWDZuTnlraHZFRGVGaTQ3amJacDJ5Tk4zZUdDdVFj?=
 =?utf-8?B?cGhISHlZMDhUMUtaLzdmQndyYWdzSCttVFpiZVpFbkF5SVE3bFVsYXI5TWtF?=
 =?utf-8?B?SXR4ZnMxSGpsK3hxSzZYbXQvMGtxZ2NtaktybG4vSVdzVVhtWFF4RjlLTVNM?=
 =?utf-8?B?M3ViRXh2bUQrRW1CVWdudVhzUnhqV1BVLzVJUGRuNTdENC91T0JXaXJkOTA0?=
 =?utf-8?B?R1FDN3VhQlNBRzZjKzBBRmFsOVlPMitXVnNSWWthTU9oTVV1ZVJLTndaWm9z?=
 =?utf-8?B?M2tKamN2RUtFcGtEWTVqVStrS0pqT0hDMy9aUlIxY0tBc3E2cW42NVRZVUZU?=
 =?utf-8?B?NkJSUllQRVBRNFkzRFA2S2VaQmJCZ0UvNGxQSnFQQmtrbkkzZkNpQ0lyTDZE?=
 =?utf-8?B?a3JOOHhOcWVJbmN6enJXTHFXMHlFeWR6QlhBd0J6ZG5DeVljd1RoR2g4RDlo?=
 =?utf-8?B?TVJQZTZqT1lRRU9VV2V4eENjdEdpSEdjQ0FETmRsdytPOWdXc1ZVNUNZMllH?=
 =?utf-8?B?VGtqUU9JRzZSOTREUE9keXRaUEQzaXJFV3NPdGVRVGVRSnlUb3NPd3M5TTd1?=
 =?utf-8?B?Nmt1aE13eldoVWdFaU16dkZxTGpQNGpoMU9HbTVESkRDNTdPdkp0b1RueEFq?=
 =?utf-8?B?ODhnSU9tRVg4a2ZyRDdVUXN3Uk9iTkQ0dks5dHl5VmM3MlBhb285YW9MMHpU?=
 =?utf-8?B?MHJUeGdMWHVtNlhEYjBVZDZOWmhoUmNvY1FFVllDQkIrNTRTRlR1Yy9Bend0?=
 =?utf-8?B?R1N6c0ovRG9JeGFjSEp3NEM5dFg0TndaTm9PSGEyWkxXdjIzNm1hei9nNGxt?=
 =?utf-8?B?RHROMzlhbWdobFI4SWhlbWJIZ1FNcUVTMjBqaDdqNEZ6cVhnS3hleVZub1Zh?=
 =?utf-8?B?M2dvN1RkU29lV3ZSekhnZklBVjZNckM4bm9PL2hIRXhSdVdWUVpEajhWczhk?=
 =?utf-8?B?OGFKTVZVb3Y4OHgrZ1QxVEdDRytQOTZaM1UrdTVDQ3RtNmh4U2NQRlpmQUVl?=
 =?utf-8?B?ODBDYzJMRU1rYkRjVEdMQ0xmVWxsYWt3RlJTYi9Gb3FCQ1BEMGt3MXdWSHc4?=
 =?utf-8?B?MCtBcS9hanBISDVZN3RLa2pVQ1lwaXA0SlY4RkZVUm1DelNBM1k4WkdqY2dz?=
 =?utf-8?B?YTU0NTdUS29wZlhGMjVsMjdyZVUvcHZHUmdTZFczUFdmYmpWNmFNcVRuQ2VX?=
 =?utf-8?B?ZXEzMmRzOVc4eE1BMnNjNkJtMjFIaXg2VjU5V0gvZmFBTUdZTWJiOGtPZnoy?=
 =?utf-8?B?QU5GR3FhUGRDOVBMZjl1S0c4Q2ZybCtKdUdtaXNOV3Foa3UvbG9kWEYyaFp6?=
 =?utf-8?B?aWNhWGVjUHhrYmRmaFhaZ1Y2eDVDTXQwK3YyV1NNcFhtOGdEYjFhcUJ3endF?=
 =?utf-8?B?L25nbnhkdWhjRWZnYnUweUhRQXRHOUdJRGJZUFNHOERlRHpEM2ZocVl5MERh?=
 =?utf-8?B?VkkyUlcxSFU0L3FoRVFVR21xa2RVZ1puZFJzaWZ4TzRJV0tDV3RFa29OT2JC?=
 =?utf-8?B?amg1WUlSSXRwQm42MDNKUEtmOHdWL1pJOEJIbTE3ZE1vRjFRbHA1dmlNODJW?=
 =?utf-8?B?WSt6TkpURU9ZdUpldTVoSlJnYVFaMllDUWdoME84UU5aUmRCL094dU9SSGg2?=
 =?utf-8?B?QzZZQmRJamVCVGptWGd2a0VJSmVTa2g0WlJVK0loT0N2VTZXcUVhVFU0NXpy?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dca96bcf-cb13-46e1-b716-08dbd9929ace
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 21:53:09.0119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVLwORCb9GD1zlEvW/TEV+YJqNSRzcIbSYTchqYI7bkfc2+1NZXMYGwrrNzXSjpwTT/W79/3CPPsx2SCYnizvgJB1IT45KqZ4hCmDfRc7lQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5549
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/2023 4:04 AM, Mirsad Goran Todorovac wrote:
> Repeated calls to r8168_mac_ocp_write() and r8168_mac_ocp_modify() in
> the startup of 8168H involve implicit spin_lock_irqsave() and spin_unlock_irqrestore()
> on each invocation.
> 
> Coalesced with the corresponding helpers, r8168_mac_ocp_write_seq() and
> r8168_mac_ocp_modify_seq() with a sinqle lock/unlock, these calls reduce overall
> lock contention.
> 
> Fixes: ef712ede3541d ("r8169: add helper r8168_mac_ocp_modify")
> Fixes: 6e1d0b8988188 ("r8169:add support for RTL8168H and RTL8107E")
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
