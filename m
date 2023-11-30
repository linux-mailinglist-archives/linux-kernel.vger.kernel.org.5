Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE8B7FF9D4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjK3Sqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjK3Sqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:46:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E8C10E2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701369999; x=1732905999;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4sWHRSyJ2ieJWzWk7QNiXPBvvQXHzTxKY9S0Kr1V5fM=;
  b=Wow3gfNjWI+gyZTnNHZ4QIg64e+NU4rIwjxuzJOw3gBhQ1uTC9E0aKjz
   PnSRYrufgmWiz367icHoWqelpsh+0alnFI6iUedbXxvdCDd92hZ7r6be2
   SI4T1qQqvWcuKyGRQwNJSYqB+pbSZdoEg3RLc9KYXFBch89Kam6BHOkCT
   PsNVjsvs6S0AtbjQVCkhr/NXWjfr96WznYULl4Un+4Cn9tzpRp/4GViab
   aIPv5X+Sh5s+IVqvwROUWS7ykH+8lcB4WhAsbOkDI0TKzRIc1+A2GN016
   sJsy/IqlMx9X2X0AZsnvfHKcq6by0EzVlt2d3AJGC8TycGG/J7okm7Yjf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="396180292"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="396180292"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 10:46:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="892913746"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="892913746"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 10:46:39 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 10:46:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 10:46:38 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 10:46:38 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 10:46:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERVV3fvaPEnPMVk8zsp3bULf4ORrChfRI0vjTdF8834YAMhjkAojSMRpVWZz9JD/HYIMPtCee4jsCJ5pvWxvGU459qvA+YHYi+MPBxkL1HrNXWSSc2bvkk7RXs0Y16Kmqiygr/42eeJLMWyQwUyJy2Hh1c1QDo+Pfb+31gIF8ukRp/C5t5O9BT5e+CoXdLEq5elM7bIB/is5P0mlXev1n+uTVAMVwj7SUdg9mbrM1ttqWxQywFQbcMyQwOkMMJo6IUrQw5Amr0ZBJoedWbY7t/qAGe4u9I3n4yzIxawLbPOy5wv/q3xAK3QuPzj0FSdg3vHYiVIY/ZY5bwzKY2DHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Cp0G69SjYGQ92mVx8HygaehibgVPzfayCKL1RTNhos=;
 b=LG+LGyI949PETk2IQVs4NaHTlJVnsgxBExhoEyRy4U95JcPOlpQxg1vXlCPZD/q0bd8oP2vs5O3bPZVkox3SEh04RZxUo/CXoHKWwD2VYOESIOtKDnE1+shE231Qpoab15FwnzmeM5kjmJRyycsDA5ZwHCWtjKEUd4apDryMWgaqDTJ1hGHV323VUO+8bLm11ZPDvVIBFK2bYBg/ofLw2mlhT3C6fzlumTrEQbL28QCXHT3zeXcR+62BkIuzdjNPLtk0WvEyZvaCWOpFyoKbYAsVIOmf2CsU9FRoIkYu+yHQJKriajPpGZFHzB1Tv7SxG2eFQ4wsrXfmmBTDngKpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SN7PR11MB6727.namprd11.prod.outlook.com (2603:10b6:806:265::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 18:46:35 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e%5]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 18:46:35 +0000
Date:   Thu, 30 Nov 2023 10:46:29 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/2] x86/microcode: Rework early revisions reporting
Message-ID: <ZWjYhedNfhAUmt0k@a4bf019067fa.jf.intel.com>
References: <20231115210212.9981-1-bp@alien8.de>
 <20231115210212.9981-3-bp@alien8.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231115210212.9981-3-bp@alien8.de>
X-ClientProxiedBy: MW4PR04CA0042.namprd04.prod.outlook.com
 (2603:10b6:303:6a::17) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SN7PR11MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d3d8a9-703a-4645-b599-08dbf1d4ad60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: moGgqLgePjyO7H8Cz+D30ycOCiuQkFc44k0rucucsINFHUzKxLEmOhKWT26FWKfKqWnLgicZCs3gox6hjHdxlyHYracoa70bbAJkU/eKRcsEhQjcgdVNyVzC9n1eRV0j+28tz6SKYrh3hdGiTVnasnLFF07Iq6AYgsOaIi5mgLbsp3QPQcYzR3//QS1/FUdAD2uxd7ovSTb+1btdwYgpBKIme05XC18/Q34Z3TK1gTi4XFiMUsPrsWhS6h0I5hrAjnNhshmdYPykYoh7BjepOloruk7ptQz+xU+gIyp4fMUsjTNve1SBNRrVquglofUr1sHkILQX3hel/Dy8uIeZ490vMo/Oqkwg49r4DhbbOgw65qnoFNUKZLpFHz+PMHo8u1B6JW4y5iz1pFGfLbrDfZkpcw+f2nsUiOVRBkPSJpil2pFGw2e1VzjZw1nPbR60ORwdSq5fFLZXbGuDCvGLq0FaLJFk+RZUhQE3zG0KMlIamuxb6DP+/lmIvI4XIq+tEHnvTTmODaAH6jrIRNqy3WYVwz0fHaG2LPgJteZmvpBfXyUV69u77Ct08uKIrUS7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(6506007)(26005)(83380400001)(6666004)(53546011)(6512007)(107886003)(478600001)(4326008)(44832011)(5660300002)(8676002)(8936002)(41300700001)(6486002)(2906002)(66556008)(316002)(66476007)(54906003)(6916009)(66946007)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bTTDEc9xr0FhEsaNdS6LfshE3qMgDDaNWS3Bgs+MUmpsE+6xoEFf/aId/GyU?=
 =?us-ascii?Q?k/j/oIGFowouLEDT56waJJk5D11QbbgQ+wGHjSt6xgCd3LeIhLOmSALheugN?=
 =?us-ascii?Q?RUuUpv6115odAcqK7NdTb0IiMWtsBYF1noEFPply1SyBdKl+GClQeVAGirdo?=
 =?us-ascii?Q?yUWfW13n6l+nXnDzbSYXzAnqJjmhFCggeL//fWqk9AlqeYkyWBr9sAHOBjGM?=
 =?us-ascii?Q?h1qsy8rkk8j+1B4Vuvb6gEFg7eV654QwuiZYwn5EFQTztWuexweRlOB5Tot/?=
 =?us-ascii?Q?AkmUmKlmb7IoC9Ks6IqU4FHWE+obtSC/cr7KXKoqBu60FH9gOfRr/UlXVzeB?=
 =?us-ascii?Q?31FnuEH7yGryCGD+/u+7DBdWFGwr8yk4N/K7mFxasuB3E9ozamE5aADJGtBo?=
 =?us-ascii?Q?1pyqoe9XgwcZmPNl3JwNJdFo+8q1VDue92Iq3ex1YtccTeJLlo6guihiH3lS?=
 =?us-ascii?Q?wo16c1xgfucINMvBj59WZEhKK6SATa+r508YZqWmKFBaqU3y01/dxqgm/AUM?=
 =?us-ascii?Q?5MJnfm3BEmqVjHP4g+gw4E4JIySOL77dJCLh3IaiBrCaqpSz54vNniRdIB4z?=
 =?us-ascii?Q?LehdsHNoexZEI2ANK6c1EkxjqbnCnrAu17JrKqENoVGb9S6dRtDfnrLtS6u/?=
 =?us-ascii?Q?pd+YN7xvBQpgkFlVjE0UOhQ006gecBAplW3HBxvBjoTtmo3wP/SFXB90EAR1?=
 =?us-ascii?Q?DOEA6sc7dyvMYMSaLZ0DTBFbW1ZuYx+e0IdSP8FOVPJLa6doV0DsiNnDyab5?=
 =?us-ascii?Q?A5PzyCtUct4u7hCZyU94DABonMxoo1rQB9UXU4jAt2CZnCKfMRddPYO2hw2q?=
 =?us-ascii?Q?5nR7KKjSaR1o6BfO2pgiPrbmjHYwJ7FTAifZ8LX/C0c1wJKlAShPP/ucuSEB?=
 =?us-ascii?Q?zFpIX1YTPY3SjX+CbTNLatIx69xiORXndcR+jIirU8W10hYhsyJRByB54K+V?=
 =?us-ascii?Q?d1oDltGnnmvxOa8aQtHcI33hYwBAeTfMmfCaSPr9PmtH4v8XJDBWfB1sKhQd?=
 =?us-ascii?Q?JPGO/3OKA4S5JbJ60aecGgPy84eDjJOX9VP+r4zmcPZnGaRmbXnYRqFjIT/S?=
 =?us-ascii?Q?GYVphN+AIgdunzBoDo1X5HuAcEsfz/BP3xruq8b2UoYmlVxQAh6EdTZ+mFIn?=
 =?us-ascii?Q?Q/uxLy1zGHG78Eg8GONQv6uRJF8wC6RjTlUSY/YWoMeIfIoTlOj4Nm0vwnL1?=
 =?us-ascii?Q?JzPogj3NEUvgCnEzES+z+K+n7zZCnfsd/mC/GhuskPuyoF+872kpVF3fF0bl?=
 =?us-ascii?Q?a1ef4MB1WvM/qTkOJUYT1TYUumEe0B4AU/CeoCzoRBY7+fXwbavWyQOl7YQR?=
 =?us-ascii?Q?tITZbcCmGd6/dyuUo47WMXWTxX9GIQd+SUjO+0o2M4ZPlbmMinK923psEC7o?=
 =?us-ascii?Q?4SUxuHsbr5E6LZ6PY7OzJstWZUggpMHE2Ro18G0+6PVCxEnlkqbhDWl/RaOH?=
 =?us-ascii?Q?iAbI3OvEvkyjoE46PAFMAlMVE3htUiXgqg3gbmsN5XZ4OJYxRfzOvthjtwVB?=
 =?us-ascii?Q?/2SALCJOkmDxfMNm2+Y/oeZ3kE+bWKjW+7HYS8MnbpzfpmAnQFKBfq+keWtU?=
 =?us-ascii?Q?LlKmzDUZDT+oLzfaLgAsWUX2n2dtl8CfnX/EyCqB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d3d8a9-703a-4645-b599-08dbf1d4ad60
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 18:46:35.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVj3X2ZP1JbDH5ohOvHt9enCG4m1lp6L47rKW0yV0e/dwNJh1XoLTH4mqAr8BRmQvVycbI92NxJBt2g8NmCmCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6727
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Since the late load already announces the old and new revision in core.c

Now that early loading doesn't print the 'date' for Intel, does it make
sense to remove those for late-load as well?

Feel free to squash this into any patch you have in progress if that makes
sense.

On Wed, Nov 15, 2023 at 10:02:12PM +0100, Borislav Petkov wrote:

[snip]

> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 6024feb98d29..070426b9895f 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -339,16 +339,9 @@ static enum ucode_state __apply_microcode(struct ucode_cpu_info *uci,
>  static enum ucode_state apply_microcode_early(struct ucode_cpu_info *uci)
>  {
>  	struct microcode_intel *mc = uci->mc;
> -	enum ucode_state ret;
> -	u32 cur_rev, date;
> +	u32 cur_rev;
>  
> -	ret = __apply_microcode(uci, mc, &cur_rev);
> -	if (ret == UCODE_UPDATED) {
> -		date = mc->hdr.date;
> -		pr_info_once("updated early: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
> -			     cur_rev, mc->hdr.rev, date & 0xffff, date >> 24, (date >> 16) & 0xff);
> -	}
> -	return ret;
> +	return __apply_microcode(uci, mc, &cur_rev);
>  }


From: Ashok Raj <ashok.raj@intel.com>
Date: Wed, 29 Nov 2023 13:56:43 -0800
Subject: [PATCH 2/2] x86/microcode/intel: Remove the redundant microcode
 updated message

After successful update, core.c/late_load_stop_cpus() prints a message as
shown below.

[  215.386472] microcode: load: updated on 128 primary CPUs with 128 siblings
[  215.394370] microcode: revision: 0x21000170 -> 0x21000190

Remove the redundant message.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 070426b9895f..5d6ea875b81b 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -457,12 +457,6 @@ static enum ucode_state apply_microcode_late(int cpu)
 	if (ret != UCODE_UPDATED && ret != UCODE_OK)
 		return ret;
 
-	if (!cpu && uci->cpu_sig.rev != cur_rev) {
-		pr_info("Updated to revision 0x%x, date = %04x-%02x-%02x\n",
-			uci->cpu_sig.rev, mc->hdr.date & 0xffff, mc->hdr.date >> 24,
-			(mc->hdr.date >> 16) & 0xff);
-	}
-
 	cpu_data(cpu).microcode	 = uci->cpu_sig.rev;
 	if (!cpu)
 		boot_cpu_data.microcode = uci->cpu_sig.rev;
-- 
2.39.2

