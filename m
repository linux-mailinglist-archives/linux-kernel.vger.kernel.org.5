Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF876C27D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjHBBuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjHBBuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:50:03 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1301BE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690941002; x=1722477002;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=UBM1VnPD3dr5JnidHDQVk69xuY7Wb0pUqyRVGnVXtw0=;
  b=cvRBeNsn40aKUTNi5JSsEhO32EoDz73XMR3jl3VPzZrZTYjlkRKsCguu
   Sb3YhEE8GSBuwmoqeK+Yp3Y+5m3Z3E1J5ol427+JXcw+6/Bl/qFngC3fy
   0gBLTGFxrHQ5bAkLvVfceuVyLvJy/da6J10moTQ/4b5BihzxYXJbyv5QH
   3JHwJGJqZSsHGiReecG4Gelxm5sT1TfEDUUoxHK5RvxGXnWJcmJpz9Ykp
   GBEC93EdFl0cSTLtIgzOPQkUFMrLG+0IUofgFqidBgLMCw66IiwyHn/pa
   dUeVTGheh5eX11pMqiIkglmq8gw3Og49YqmOijAOOXmiWlq6d9Hk/p1lv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="435780625"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="435780625"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 18:49:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="975502802"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="975502802"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 01 Aug 2023 18:49:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 18:49:51 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 18:49:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 18:49:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 18:49:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrEFMA2wF+cN1zHqBE4qLAW7fDULU9N33wuM+eQ9yzOyzRbaouGlOD+0G230m9GMcZp/0jD0F0TJETX2WyjAa+kkZjHNATeWhIQvppunrAKei4lrPjg28/M2t0wHTcHPfaTSNPxaZnqdpHIipYEh4317hBaWjqTfralhsdgCNh9MYkDGwtqpwgC72wY8B215xscRnfNfkqONmgSPRoaGD6VXEaUKeW7MzLcVXaV/hrIWnAA2W4EZg8J1DTFgt8JlrqSPGjPRFAaLNGBfcERaNWroh6SSBjUWx23nj7Ci8e/KckpDDVVendAwP+udxsorM/m+IeLr3Oh+w5+q5t1+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQ/hDUko6YDavJsylCp2P8Fy7WytaCwqXzNafFl3n1Q=;
 b=MsotwNiHoOz6xZxJJ+FOyk4t6wQVLnzeSPZMknXVcIlWKIiJfpV9V9ier1FIxTP0uw0T8lpjB6S+0mXyGhOkktjf2rzooXEY0iUX9RptI6t8nkDNJ5Uon60pZtRagBMdyi2EhWWzbNs/pfVGcdiWb0q+hhv8P+8wxTRiKq+hl8pyvt54mi/dL9yAcVkwvjbTbw5WWdmjBF6mSxQfPlswp86TUK/a0jflV+Xtrpj1aicqbulTzIP9QKLJsUl8D4q+X4AFMSl9UBJJYRxx2TfOk8JW1263EPQlwvNwr4oFCHGCu3DrVGRGS3UjLULo57HaOpFWrk7LoPLnu0bgACEAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 IA1PR11MB6147.namprd11.prod.outlook.com (2603:10b6:208:3ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 01:49:48 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::1b1a:af8e:7514:6f63]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::1b1a:af8e:7514:6f63%2]) with mapi id 15.20.6631.043; Wed, 2 Aug 2023
 01:49:48 +0000
Date:   Wed, 2 Aug 2023 09:22:57 +0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        <intel-gfx@lists.freedesktop.org>,
        <intel-gvt-dev@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4.1] drm/i915/gvt: Explicitly check that vGPU is
 attached before shadowing
Message-ID: <ZMmv8bdGbsLwIfMM@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20230729013535.1070024-7-seanjc@google.com>
 <20230801230520.1509954-2-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230801230520.1509954-2-seanjc@google.com>
X-ClientProxiedBy: KL1PR01CA0090.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::30) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|IA1PR11MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: fd575ea3-c2da-4bd8-b453-08db92fac10e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CemS3Etx69TSkoxqVCi1UWkgxe5VEA9U9zZLdeXKeNpUV3X0ZEvPFakBcXr5eW6NVn9WhmiZVrFQVIMwuCiSv53bjPYOreQ7CRob3hfB7VhYHiMnfiSJH42RLDfwoVCImXP8ClT8uKsUHyVfG0JbGfEJDKYXgxSF2lC/quJdoothdeH7vARzs9x/CfC0FVOmLNqOMntP8zoNMI90MtCWg3Nqi6D7gtDszOtHAgYaAIqfjDE0HSbJLpGkzZsiJ7H+mGartYecDD3W0fCGTBLX+utzDDUA5NgKe17NmypyIn0MsnrokFoi0k7YMzfMCoUQJnwjB0TK0v8ZyKDPRo4jnGZt8uSmN4ldpWhJ4ZcT9+Gkba1CO+0A0tpVJwg32OlydT11U4PaTGeNu5GAe7feQRVKL/VQLKhH/2MEMcA+MG7Ry0QCvSv5K2eYGUHOBPeTMKzDIlym3VhFl7sd944IFIU51kG1aIROsW8QXrEPi9IN2pHyxqTI1wtIJbwk0PdpbKtsGGArBV9sC0LAbdE1M5GTtsCQKk5HuxHJI/lvIg+4MmszgARQVFZI9LY2N58j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(186003)(6512007)(316002)(86362001)(478600001)(54906003)(38100700002)(66946007)(66556008)(6666004)(66476007)(6486002)(4326008)(6916009)(26005)(82960400001)(6506007)(41300700001)(8936002)(8676002)(83380400001)(5660300002)(3450700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QVq5cBWDHPisO31JDUgpOQX71K+Y4wlWof5yBHR7wUZfVrbTw49eloJ11JQI?=
 =?us-ascii?Q?m/PV7PU02ZlHhflfhp7CVVE3HiKkLcgiSpEpiV+luZERcRxtrxuigvIym+5k?=
 =?us-ascii?Q?2n2vgmRc9EhGeZD5Rh55M0FuHjEMrDaur5IevRaNXweWjiR4iB1KmJ3wNwSC?=
 =?us-ascii?Q?UX7fGaaXhmeb9eKul49PsvDZxOzVUSCQmWrcOsg+w1N69Gccmr74/6+cwsFp?=
 =?us-ascii?Q?KezYw0AS2eNk4FUYXMg5rDNo3SA7+tKuGFhMTF0+SMX7JTDtfouZ3EE15AO7?=
 =?us-ascii?Q?BjXElogV52LMtrY+9CYIT+T3+GdLrnlMGpZcW2HpeCRGiT31JKmT3sDL/fwM?=
 =?us-ascii?Q?y421ZEydF40HeJZov+kZ0yiOW+nHM2WROmEQY3gLVnfaKKTMcFxr3kVs5Xqa?=
 =?us-ascii?Q?9KbA8DiJP4kBhNVyZ8GY9wYVLiQNSvwBB8STkeF3O7xJaTrC/sDsh3/BF1QE?=
 =?us-ascii?Q?94aevwqDjP2joKwZitWEXiepfjgSEkVhYO2BTPK6ySUR5jSQHEcwRpT+MZLJ?=
 =?us-ascii?Q?sFsc3cY4NNFfhu+mWk/tDPNxtOrQsX05/jL+ToAYv7dvb5SyCmLJF3fKV6RB?=
 =?us-ascii?Q?iW+7aI3NMOBoXcsk4oeq2z36f397vW5OTQipUAEchZwBnVxKMOknF4zVke5v?=
 =?us-ascii?Q?8E+VxdEjo3eGNJTeOJpncHM4MK0tXsy7j2dTfLRxvb9KCPNVJg9XHX0nsVPI?=
 =?us-ascii?Q?57N7z612KaVYnrgtTYmZbDiYSbAqssTTdDfiiXX5LqSDyJ05RyplGaQMGGSv?=
 =?us-ascii?Q?e5lEGo76XvUSP/QKyXf5bXpX+jg85kR1mBs+d2ybdZ09BMy3sMTf28ecA9pg?=
 =?us-ascii?Q?1SeFUz2Ez4x5oeS+WoBzzzBTbhzlfT+wXrL7fK8oEqUJfGvEK1JsgJosSrSA?=
 =?us-ascii?Q?5FVKDF9CObE3el4WaC9qehXHj8QhDT7g03O3J59Hvzc+1T6dDr7cYNZF0a9Z?=
 =?us-ascii?Q?oADjuPMcC+hynrBAFBpgpWjowz1xaR0rVied1NzTVAqQIgvqjNKE5vRhybjR?=
 =?us-ascii?Q?9KOfclAZ3QE3ZrTEkFLWiQPKii4QT4g3F0xvwFcswC9QCkp77L41wxHPsFid?=
 =?us-ascii?Q?FTi4tXtKY2okPPIwNmiPlLsM1hZmeJtjNMrASChJy5dWEij2drylaQ/NMsz7?=
 =?us-ascii?Q?13mcXN8+Xf3X2WtZO0HDHH5TwHCnkctQa0l8TSjX5K0VPBDNXs6wHCEK01HW?=
 =?us-ascii?Q?NFMAl9h1GnlmO20moJr7c76WLTiKZJVDZvL2Vtgp52ZUpAA+PNxs8hbBSuk6?=
 =?us-ascii?Q?gq1NhWqdr9RtgyUZeZgiaTSB1VVoZvCbaSGJbs7r97lCIj5HzOJW4mjbx+6v?=
 =?us-ascii?Q?QbomonAUkcoBkAFmuHiqn83By8VBODQLeVh92Iwbs4SWuqGHlMnVCWUi5M/3?=
 =?us-ascii?Q?p0hC2M9f94xZYLHvfQBWODwXm4hFG2RW4M5CoLda+lhHtjlFvOfJHU3tY/bQ?=
 =?us-ascii?Q?x4M5JD0MUl0zRW5/hTe1BpRzGL9ZkcdOply67dBl8P1pJRY5I7Wij455AX1S?=
 =?us-ascii?Q?sDhrdZvGtEJfJO3ab/V9ONqz5pao5c78BUMSL4AlvnmLlfN+UqzwZ16qOSOa?=
 =?us-ascii?Q?MpFYRau/5ONG0N1wShkHLPWLoLEQCLuxUU0/mjxh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd575ea3-c2da-4bd8-b453-08db92fac10e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 01:49:48.3671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5U1eel1Fqfra3FsK1G94CXtilxxlKcPUi+q0jN5HbSjxKArE3WM2h7UvySr41LKLTiq60jFKzL8FXZ0LSLB6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6147
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Tested-by: Yan Zhao <yan.y.zhao@intel.com>

On Tue, Aug 01, 2023 at 04:05:21PM -0700, Sean Christopherson wrote:
> Move the check that a vGPU is attached from is_2MB_gtt_possible() all the
> way up to shadow_ppgtt_mm() to avoid unnecessary work, and to make it more
> obvious that a future cleanup of is_2MB_gtt_possible() isn't introducing a
> bug.
> 
> is_2MB_gtt_possible() has only one caller, ppgtt_populate_shadow_entry(),
> and all paths in ppgtt_populate_shadow_entry() eventually check for
> attachment by way of intel_gvt_dma_map_guest_page().
> 
> And of the paths that lead to ppgtt_populate_shadow_entry(),
> shadow_ppgtt_mm() is the only one that doesn't already check for
> INTEL_VGPU_STATUS_ACTIVE or INTEL_VGPU_STATUS_ATTACHED.
> 
>   workload_thread() <= pick_next_workload() => INTEL_VGPU_STATUS_ACTIVE
>   |
>   -> dispatch_workload()
>      |
>      |-> prepare_workload()
>          |
>          -> intel_vgpu_sync_oos_pages()
>          |  |
>          |  |-> ppgtt_set_guest_page_sync()
>          |      |
>          |      |-> sync_oos_page()
>          |          |
>          |          |-> ppgtt_populate_shadow_entry()
>          |
>          |-> intel_vgpu_flush_post_shadow()
>              |
>   1:         |-> ppgtt_handle_guest_write_page_table()
>                  |
>                  |-> ppgtt_handle_guest_entry_add()
>                      |
>   2:                 | -> ppgtt_populate_spt_by_guest_entry()
>                      |    |
>                      |    |-> ppgtt_populate_spt()
>                      |        |
>                      |        |-> ppgtt_populate_shadow_entry()
>                      |            |
>                      |            |-> ppgtt_populate_spt_by_guest_entry() [see 2]
>                      |
>                      |-> ppgtt_populate_shadow_entry()
> 
>   kvmgt_page_track_write()  <= KVM callback => INTEL_VGPU_STATUS_ATTACHED
>   |
>   |-> intel_vgpu_page_track_handler()
>       |
>       |-> ppgtt_write_protection_handler()
>           |
>           |-> ppgtt_handle_guest_write_page_table_bytes()
>               |
>               |-> ppgtt_handle_guest_write_page_table() [see 1]
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> v4.1:
> 
>  - Actually make the code do what the changelog says. [Yan]
>  - Fix a typo in the changelog. [Yan]
> 
>  drivers/gpu/drm/i915/gvt/gtt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
> index 5426a27c1b71..de6a484090d7 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -1163,8 +1163,6 @@ static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
>  	if (!HAS_PAGE_SIZES(vgpu->gvt->gt->i915, I915_GTT_PAGE_SIZE_2M))
>  		return 0;
>  
> -	if (!test_bit(INTEL_VGPU_STATUS_ATTACHED, vgpu->status))
> -		return -EINVAL;
>  	pfn = gfn_to_pfn(vgpu->vfio_device.kvm, ops->get_pfn(entry));
>  	if (is_error_noslot_pfn(pfn))
>  		return -EINVAL;
> @@ -1827,6 +1825,9 @@ static int shadow_ppgtt_mm(struct intel_vgpu_mm *mm)
>  	if (mm->ppgtt_mm.shadowed)
>  		return 0;
>  
> +	if (!test_bit(INTEL_VGPU_STATUS_ATTACHED, vgpu->status))
> +		return -EINVAL;
> +
>  	mm->ppgtt_mm.shadowed = true;
>  
>  	for (index = 0; index < ARRAY_SIZE(mm->ppgtt_mm.guest_pdps); index++) {
> 
> base-commit: 03e8f77e106ba1d2fd980f8b38339dad33333a07
> -- 
> 2.41.0.585.gd2178a4bd4-goog
> 
