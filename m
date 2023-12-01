Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A60880156B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 22:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379671AbjLAVcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 16:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAVcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 16:32:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0726610D0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 13:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701466367; x=1733002367;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k3x92ahFryQAy0wc1aHF3KJibKgCCPPxXYM7+FE6fFA=;
  b=FUU1dew5cNDGeWChdBHayU51mFj5367JB+/kyY/O4lLdaPVCLjDAZIo1
   KBZri986jd5BFudLmJV0VxM8RyOpNn9ju2QHPw4rrXbohXWfJQn+69Rkv
   HUgVhhqoHeI1T4DmeFWIZ88zvDa0zYiOycnT0R4h8MIASChYUqw3M9CFH
   VVjE6IjUjkmOMe1mD3M0vUaIk4mzmtzGWladdSF+5fVS1ucNPSzIl5Glv
   0+sgNNL0oEvPRYFsqVvfVdBT+3kTFkI7y/KTSqI+8pqOwmc//sdxWWHHR
   lRcMS/zNFFFfeNeMjZzuv3Grhs+I/0zMArQmrEsAKnUUfbcpVtUwEfz7b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="460046251"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="460046251"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 13:32:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="769818893"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="769818893"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 13:32:46 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 13:32:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 13:32:46 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 13:32:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjGKQOMIWSaK9G+xnoJB/AM5KPOG7SaS217U3ZyWGnma1ku6nC//asHaPDI8x4OpczRuQ4VlN4/drghHPqyQbO4AVpkQiCEp6VnMJGdNjTPqzORzQblAczNtZvwIXbVqHhWmwJ5PptN1NZyNjcf1u5HXQu7J4/YzfUTXw4FCS953kpOMTkOaMNtA5LHrto5+W9FdOZsHPx2J7yYJrdEGA3kUqwl+JirRnbzowUb8GaH3Dw7dIug31KK4G6iv9Dj/WJyuG0LxIcrpja+rHAlsaxDCOpGcwnRm4LMDX8FPC0I+YxWrKcfcbar3bI9tBpksZJVT5VovIatm/MMS80sbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kz+uzqpANkXG6pbkDZ5b6pQIK+B9P7KW1JDROyS8WIc=;
 b=PZErJ7J/0oQRUE9Bj8AfyPRf+4EqRorLWMubsmz8hFCdq2fPD4yB7m0BuvufYRcHIRZw/25HAKlVe8A63n4/Nr52kbwWvHbg9iDH35gSmT0aJNq7QCr/4XsgoKPOSRSlVc3QjooOLPjNtynzQ+CBP528VWC1i0X7JcM5dnOv4Np4EmgAdn1jiX0/CmCfWCFhD52pUExZ+dE0a9NZtDATXyruo7EIBRYP4Fty9XPRTiwMiUjaFZocNmDs27yiJ1z/ztQlEvRfltE2MGka4QWI/9xWyWh0bginNeIWGmyYOH7n0/PVkXE08VdfhTGCJz3Fy2dECYEccWk+gx6LMjOKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MW3PR11MB4587.namprd11.prod.outlook.com (2603:10b6:303:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 21:32:42 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e%5]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 21:32:42 +0000
Date:   Fri, 1 Dec 2023 13:32:37 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/2] x86/microcode: Rework early revisions reporting
Message-ID: <ZWpQ9Wbb7u4ss0mt@a4bf019067fa.jf.intel.com>
References: <20231115210212.9981-1-bp@alien8.de>
 <20231115210212.9981-3-bp@alien8.de>
 <ZWjVt5dNRjbcvlzR@a4bf019067fa.jf.intel.com>
 <20231201163928.GCZWoMQNAAQSA9U12D@fat_crate.local>
 <ZWpDHgNjhQKLodF6@a4bf019067fa.jf.intel.com>
 <20231201204146.GGZWpFCqodLUPS27tJ@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231201204146.GGZWpFCqodLUPS27tJ@fat_crate.local>
X-ClientProxiedBy: MW2PR2101CA0033.namprd21.prod.outlook.com
 (2603:10b6:302:1::46) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|MW3PR11MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: cb12ac81-68c9-489e-50c7-08dbf2b50cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ABqQEBAH/oMSur8Dhj9roiIR71SvaDiFSIiS7ookIDtog1F/OdEwAjFHMgZAp+gIFzxvSRtWJQsePdbpzZHMLJ5Izdpu/k5RhmoixP4J7wO623g1aKH2lrdyFmwePFxy6+xB2T2U5MdLKZ10+WhzCvEfVgx1lfS+wu7dd6CSkjXSlq6/v8LTIeR72BwsxSOhfAqpyb/AeLyHXU4qtQcdDbN8SAHe31h/XKQRhGGQm3jiZZQjmn1TVZrLfPVdPCrIpa2YfWYj5jAw1pKxFGgMjTcyXs6bl9knjjm4gOOM5FiHsvfE2xoUE+XTTNqzzwIRlIoo347n94yum/AUUY+rw5rd0qyB6qSvrLUgZMP/cgvq7o6f7g9R39xzCO3zB1vk9lp35G+J6++GzKLBQn/eSXKts+WnDby7WDuRKj2pLolBo1hrt8GUxSE8j190JKZXEmlvu0qRYbyUa1S2eSHDXD2gqel4EnOG+kvMHMGyUSMpIsML6LBf9tWVptmxmIbdjk2RBUXV5FQSDdG4tOuSboRxvKVloifvxaMeU/45sHo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(4326008)(8676002)(8936002)(86362001)(44832011)(6506007)(83380400001)(82960400001)(6512007)(26005)(107886003)(478600001)(966005)(6486002)(6666004)(54906003)(66476007)(66946007)(66556008)(6916009)(316002)(38100700002)(2906002)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YpTcu7Ilpw7gUAp0732X6D1pLvCHs3CBD5NFuoMcdzpsAr9fH8tW9MbiqPTL?=
 =?us-ascii?Q?3bUYXvic+Mm6BHuZypA2wJigTnA361dXQzar6mSZG+aGZ9txNoS8k0DqWM0q?=
 =?us-ascii?Q?hB8ms64rW7Uumr9/AIhEbrg4Caljzo4d1K9nCSlm5yK5lheK5gSnCx1H2B3z?=
 =?us-ascii?Q?G6h8fCakY50RNg46/QY7BnHH8X+dazAvu93ou0F1dHuKDFZcWcrP9bzC902u?=
 =?us-ascii?Q?HKFEhDHq7zgrGU5z5YNYCm4ZpaJXqzHESDlR4VWPoLnXtY4cDlKFIGKDQ4uA?=
 =?us-ascii?Q?eboP8AtXaL6DBeNGXSfW82qfmCMxaRTc9GuAhHUek9gfjBvz8JH3SePKALm7?=
 =?us-ascii?Q?N2HToCJ8YWgSXGWcRIapcrQjdiAmaWrRfsYcORqA0Jvy+wds61jETCLFTDi1?=
 =?us-ascii?Q?uAXxDbFikZvdZbHu6z28H4bUgJrpXkO9s5kIBR6Qy03rsK/VezE3cG2LrWoz?=
 =?us-ascii?Q?o78z5G7bfTeK0tMBQw2YteGe7BSDQ8ysKJyxm4wig9B/9kz4/haF/AO2NJFA?=
 =?us-ascii?Q?s8YkcJPhUKiHMGc+jYrx9TGnNqF+BvcdeocjR9j5SfHcovIYOGqEJFO7BElu?=
 =?us-ascii?Q?1Rj5Ir7+C7Yh1L0637DiBmdxngvU4ghuHmWNJ92xNFOQPxYkS5++N4ZwTCQt?=
 =?us-ascii?Q?b+XNW1TVLx8sfVCZlh9XFhcynsUE1XIEXisyHrd/AwWI6752H4XHLuDlH1YP?=
 =?us-ascii?Q?igXOL3DRAPrj9I/2c1pF/xVCbQhcR6F8xBsfw+DhJZb4Ne9Ayn7wnzwwO2cu?=
 =?us-ascii?Q?Kska217JQDlKq/0LkqpuGLOY1z2rlDpe6A6jtvfz7o6uRRin5FUE1e761J+D?=
 =?us-ascii?Q?wCgJyuXpk7Sd2RZ7wWn7OdKKjrnsNPfs4D1D35bHWzDH2O10918RoCOeswuU?=
 =?us-ascii?Q?Kz/Apmwij/yJP5ZA5WNu5o1Zpsr1N6du9FBWfaMxqbR1tXZYUEQuSq+J4Htx?=
 =?us-ascii?Q?nGqT21FvgFquek095pk7tCgP4rPfcCIXp55/P+ZCvZ7l/XNe+5/YZRg0sGzo?=
 =?us-ascii?Q?3EiScPUd3IoLbmUIobMR1dpSv2NuWw/jh9GrsaEEe5MsHOWk/cV1S6MK8I+j?=
 =?us-ascii?Q?5c8xLIvQC14/7UoAaPqrFHuw89nyG+Ukot8YLc0hSMdcIirWY2ia0tjpxYwT?=
 =?us-ascii?Q?DgL//kmv4v2q1Jz3Yv10o4iCAO1vgjQDinxwgBgK8b2lKxDgLoBgUePL+f2C?=
 =?us-ascii?Q?g3OvEZs76UsUGSo+RLwyJNmjsfBtrObpsxW7TFLDOXx7AbZ89dNpS3Q1fz1p?=
 =?us-ascii?Q?hYw2xvJEJE3/rsmLC4JZhutwl86FhDy9fFYVVmwgkPZhjind5/oVOBXhopOi?=
 =?us-ascii?Q?FXENGODMppbjZhX0AETYB/PHMwtfhkJBqaBMhHOHIej5cJNJPq2u8fcHI4Gx?=
 =?us-ascii?Q?GRFm2Ly6sRKAr8LjQ11qmd5sUyVwrBpqa8+miCz8Pwl7OyiyD/UtpDLToeS7?=
 =?us-ascii?Q?roqWsM2ZoBAHqiKLtC3cJCIgc6RTXwO0aMd7RnnamO9CQ2anGDZ24+13fGHq?=
 =?us-ascii?Q?ZKNF3r+p8zT+vC+Fu9mDj00X+sGrAVwVT/5OtgnU8lby8uKYFr5bc431LGC1?=
 =?us-ascii?Q?G4EW428hnsY5iLshLfUi79rZReGcoLNZnjXutJTr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb12ac81-68c9-489e-50c7-08dbf2b50cf4
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 21:32:42.5757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yiSP/QQUEK0BwAYpNzHfl7wyfZGN2YfEBHTLudMfX3n/Qe1FvnlsXrC5V9aawOpy7re62m7kJXf2lrBWZIm0Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4587
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 09:41:46PM +0100, Borislav Petkov wrote:
> On Fri, Dec 01, 2023 at 12:33:34PM -0800, Ashok Raj wrote:
> > I'll get a dmesg shortly once i get my test system back.
> 
> Thanks.
> 

dmesg for the microcode part here below:

https://paste.debian.net/hidden/e911dffc/

> > What I meant was 
> 
> I know what you meant. Did you see the diff I sent you?
> 
> It has the fix already:
> 
> @@ -410,13 +421,19 @@ void __init load_ucode_intel_bsp(struct early_load_data *ed)
>  {
>         struct ucode_cpu_info uci;
> 
> -       ed->old_rev = intel_get_microcode_revision();
> -
>         uci.mc = get_microcode_blob(&uci, false);
> -       if (uci.mc && apply_microcode_early(&uci) == UCODE_UPDATED)
> +       ed->old_rev = uci.cpu_sig.rev;
> +
> +       uc_dbg("old_rev: 0x%x", ed->old_rev);
> +
> +       if (uci.mc && apply_microcode_early(&uci) == UCODE_UPDATED) {
>                 ucode_patch_va = UCODE_BSP_LOADED;
> +               ed->new_rev = uci.cpu_sig.rev;
> +
> +               uc_dbg("updated, new_rev: 0x%x", ed->new_rev);
> +       }
> ^^^^^^^^^^^^^
> 
> The assignment is now inside the UCODE_UPDATED conditional.

The first patch I tried was exactly this, but assumed having the fix  in
core.c would help both AMD/Intel.

Assuming if the same loaded patch was also present in initrd, 

load_ucode_amd_bsp()
   early_apply_microcode()
      __apply_microcode_amd()

old_rev will still be non-zero. 
