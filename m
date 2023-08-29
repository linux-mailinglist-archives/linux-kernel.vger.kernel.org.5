Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FA778BDE7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbjH2Fc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbjH2FcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:32:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2401A3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693287134; x=1724823134;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wMMXozrau2R7WKvCKRz9bKh+AzcpumoqQSilIgVpgw8=;
  b=jEOT5BghaENq2Hs59kRt6mwzH32dGjDaWEcgah76oJ4fzYnmf3tDGcDD
   6O9u5zeZ9iVuO4UQL6WU0qgfMrGREbeWTKOgSLtZPV8Zn1LzfqTVN4xlk
   jCgPsQdbdEvDBcsq3bLemZGVFWCaqZhJUyX91cdYk7DxY5gSGZMHF1lBK
   Z32fN9BmhJUbVJWre0STajvDUDumzFVvtLalTkRV0Q/arrdQqPzpnN9ZT
   CBwZT3cs0xYDjz1IeIfVF8c0iQSTcIaY2zaoGC6DfOf2LZfiFV4umd+hM
   Rloe9mNAmvQBd8+V+/V1hVY8h4cj1Xt7NZaZPlosvIbQdlFdMkW3Xqltk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="461645113"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="461645113"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:31:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="808547821"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="808547821"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 28 Aug 2023 22:31:47 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 22:31:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 22:31:47 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 22:31:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNwpZ1x8m8GdjAa0m03+6Uk9HXZyhY8//UDsH/GMoBDRp27GTvHwIXyqI+NYYo6PTrwhU5Qhj99TUngr0/eSgZMt7p4X7pb/Jt+bmKTStSrJjmy79QxbQgFtJrVirgEjgML8IY5xjRYcyv/IlVYdwiCPGK14XGZpTOfUuRviCz6fl6Y4TxDp2fdzLmo4z4eYJTVaMQ9pPXKx4zP1FUZkkZf0HP5lKlAswk8fFJvtyP3/kuJ3FtDHPezLa5mYCqk7BPALphE0nq42DoyzExkSyThkJ3XibribcCyQqGv1IDzXBRU7hYlmaCkIIroejBcJ7HEmVaOVznLYIwW0EEu27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgRNROQZvJQJdgF8SRr6TDJBbXYTFrT7geGiA7wmkLs=;
 b=So5Z9yisrnhlRjJMJo9V/dcDbWBRL8kKQAZDd3Y+aRxxYndOe9Yz+s1f2kVpXHct8aVEZZwflBY4NnUszucr5R6rSo576dxuUDzGIpX/e00c730fLQRiHn616nHbSmHWQRnYr/yVr5kkkfHo5XdRg/sIqkXkLN+9+sLTnj5vtmDF1qHAtRf1xSroKWGOJ3iSNPxGhiuPJNJ1lttijFKBv8U5Q6TGmzOMh8H650YzsBTKxLrrPACFzfVNGvJ0YuENgYZ72lSQdwZCKUhx7Xhrs08Y/THjMb6SVwAy5qMFKulQgnxIUpmMFqp/SJTF8fYXGI84FWN7He7MvhsXvwtr0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by MW4PR11MB6739.namprd11.prod.outlook.com (2603:10b6:303:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 05:31:43 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d718:207a:ec74:2556]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d718:207a:ec74:2556%5]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 05:31:43 +0000
Date:   Tue, 29 Aug 2023 13:31:33 +0800
From:   Philip Li <philip.li@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     kernel test robot <lkp@intel.com>, <llvm@lists.linux.dev>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: arch/x86/kernel/cpu/amd.c:1289:6: warning: no previous prototype
 for function 'amd_check_microcode'
Message-ID: <ZO2CtepNj3jTAYCF@rli9-mobl>
References: <202308291220.DOn00Y1A-lkp@intel.com>
 <20230829044745.GAZO14cRtwAnfERdR9@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829044745.GAZO14cRtwAnfERdR9@fat_crate.local>
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|MW4PR11MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 1675c24e-8e98-4663-36c0-08dba8513a48
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PizKS/g1MuWIUSdITzSYjT3UcB3sRlmiZSfaO5YJx3rBu7H9Pginq14MRhULrTV+ea4WSS+nn+AHhgplAUDrOecNv6XP+/G1XxQAJ/XSY16M2QVQOKRxjTAY3VDPGfJ9Oh1SXQP1bIj1pVMIOlu8YWzwfhksyA8sUq7XyDCCT5NFPBoEaoov9uUBB/7YgjMBTTH6cQjtg4L0X1cAqrpsLlBbPJqnAPXUB4HPM2t7Whel0hZx4RVknDe0tLlggPiLP8Sj4OO/+dLHGu6/ra4nkVcF4l4DNssTS7AHuo60SDMy2BJS9hgQN9EeebV8sgVHgNzUmaI83s5459qEWH0gHuW2AIFd9dRcq3sYq8wSz6mNSXWmxw2ThLR2r48pUhcsHotPivupXHF+ulzJ8nxcRQF1bUY33t41bi34FjkO0CDymxsbWhwlASV5+3D6oad66lFtDsVn0eTXiiISbomRUkSsiibanYqsmG7G4nn4c8xzGVZS6amm3wJrecBwE9azwkjtL9pA4ZWoPMgISpw+rTQHYPaDWzNz5X+jag5eUpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(346002)(396003)(376002)(136003)(1800799009)(451199024)(186009)(9686003)(6512007)(38100700002)(316002)(6916009)(41300700001)(82960400001)(4326008)(2906002)(86362001)(33716001)(26005)(5660300002)(44832011)(8676002)(8936002)(6666004)(6506007)(966005)(6486002)(66556008)(66476007)(66946007)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X4XOOjIKqb7usTckqluctGPCOGfNVpM8j2krnicO4VrwdomKY3zFXaH5F9K9?=
 =?us-ascii?Q?REGIOgdVlRFWlTZCPJ4l5ujc3dSBGuoaTF6L+V2E3jN1z/5EdykxDbYogcPc?=
 =?us-ascii?Q?emcrBe0VjX/FQvYo4TB3eFEMkZdfX8LVjWZ9VKWExO0KQVOGf8vDiMdoefww?=
 =?us-ascii?Q?K0VPuOHDPzysdXHZENVZGxfX83ruGJg6Aaee2smIQFYco4zlvY27oQC8Ipzr?=
 =?us-ascii?Q?351/2xWoTvVNrm/UdppbIuvEC7hWGLgzazN6nTFQ8VpSsySdZdkRdfYK3aKM?=
 =?us-ascii?Q?9jrW4V+Yce3KJy4aZDqQb5iRO8LUvt5eqeF6YhZhC37B3S1EUfXxY2U+rW40?=
 =?us-ascii?Q?ObN2YC/W9sFe1868lc9t/r60dZuBS+JrFlBtG4lwSHVWbAA+KfGma0cagZCK?=
 =?us-ascii?Q?DCbT9C9FDSsQ/SXSuVi/Hlb+sD3dbAFGxfXtiIH7kFMZAoyqF4oozBKT/WA2?=
 =?us-ascii?Q?Lej6pezq1oIf0M7HwqqmAxY9Bgt2TiX5uLQA3KFjN/AmoC7Uhc/9MRy+ia4e?=
 =?us-ascii?Q?yUy2w7DECk49BPct/xu9kIxWt9c3aWnn8qG4SkZue7l8pUJqAZ3ApN2nu4lG?=
 =?us-ascii?Q?xSq9j4oezrDP6YgWZ3Bdndz4yqfjsOVYDKn4ExbQmtcDn1D03OADvmH+UH5r?=
 =?us-ascii?Q?sDepSL/0rWMwXvmIGTzgT5lP+74ydey/WOPONmPkZIbk0QE1aPAmJ+ZmYqZc?=
 =?us-ascii?Q?HA1MzCqSXJk0LAQVkVbxRIfMpbDEbPrnqndXRN8p67tc4/acT21bxbbowox+?=
 =?us-ascii?Q?1u1Dt9gUdRX8JSLUuavq6jdCAh2InpzPBNyFEIBHJNc3jIyFAvk/r1bSsGh9?=
 =?us-ascii?Q?u8ldixtM8WzV/t1aNTS0BlqGnr0TyEDVT9bLrhE6dLjySW4U8jODwrdGgqV9?=
 =?us-ascii?Q?PSF81HFlywUCIW8VPVoNQkq97+zmMltuBA5e0wqA9SWMQb+Kr6zt0jpVMGed?=
 =?us-ascii?Q?l8kdoVGo/c/NiMd0weXfDh8k3XZBF46KhB+7cLr/QhhAJhfoDog4MI4pHKMJ?=
 =?us-ascii?Q?pmgjX2Tg6Gy5btsDKd9fl4QW304jDL8Kgj+Smo9Gdop3+aVtQe4qZLFtOv/I?=
 =?us-ascii?Q?J7wJ/hWVqcLndV/+veOCs9GU7xyrBtazkHAXoZCEjRB0YHnzOO8O1fhqXc0x?=
 =?us-ascii?Q?zP08TCpbiZ/7VUyhKxJFG0cv8SyKlHwYPpOG5tDK+asFKR8vQaf7FS49hHzS?=
 =?us-ascii?Q?jh09lAS0ZBtD+3WEVxCY08z3Y5Ft2EjtDANIJuNCq3/ldG21FC4hZeCoNj+Z?=
 =?us-ascii?Q?im1VTdYXnW7fJKU6ZoStBWguARLGpFrblSE47RMr+4qxjSeaOJ7MFRJlaa+A?=
 =?us-ascii?Q?V9ZABtPPlnkaZPeARpOmaRgQQNvGl7kNC0lcR35p9uQ8YnY91gLGDAB7jz8Q?=
 =?us-ascii?Q?TT5ygRSLu/Yw2/GvBbkj54olDKMbeXa2Dy9uLpBwzrBzKRUk4yu41CQQtk96?=
 =?us-ascii?Q?YpDBKy7hK0ul3R47kVNvn7qG4rUqa+wuG+VTgq64Yz6CGqhcUqblS7Rl3GgW?=
 =?us-ascii?Q?aEsYNIXA/Qu116bA21+ZaHEvc1MDZCWgFNoupgGpRjLux1B2CdIT6AXbPw3A?=
 =?us-ascii?Q?aDctl1ZdFGmDhS1+7d1NiW1glCsb617FzxNrd3qY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1675c24e-8e98-4663-36c0-08dba8513a48
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 05:31:43.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NC+gLgc2wUFwB+kMSeJQVUibDtjzTrF3iA80MI2n4tqQdyzD3uQPxKj1vFJVXk3MdJJfafEL6KUKkZm/OsvOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6739
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 06:47:45AM +0200, Borislav Petkov wrote:
> On Tue, Aug 29, 2023 at 12:07:59PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   1c59d383390f970b891b503b7f79b63a02db2ec5
> 
> It doesn't trigger here:

Sorry Boris for this invalid report to cost your time. We will fix the code
issue asap to understand why this one is sent out when head is good.

> 
> $ git describe
> v6.5-1207-g1c59d383390f
> 
> $ make ARCH=i386 CC=clang-16 HOSTCC=clang-16 allnoconfig
> 
> $ make W=1 ARCH=i386 CC=clang-16 HOSTCC=clang-16 arch/x86/kernel/cpu/
> 
> ...
>   CC      arch/x86/kernel/cpu/intel_pconfig.o
>   CC      arch/x86/kernel/cpu/tsx.o
>   CC      arch/x86/kernel/cpu/amd.o
>   CC      arch/x86/kernel/cpu/hygon.o
>   CC      arch/x86/kernel/cpu/centaur.o
> ...
> 
> > commit: 522b1d69219d8f083173819fde04f994aa051a98 x86/cpu/amd: Add a Zenbleed fix
> > date:   6 weeks ago
> 
> Likely an old report.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
