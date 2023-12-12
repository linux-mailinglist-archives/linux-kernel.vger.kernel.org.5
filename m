Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4DF80E4FE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjLLHnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLHns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:43:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7D1BE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 23:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702367034; x=1733903034;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6x4xHN71pLMNq9Kq7lfHbshllATlnf+QnuB6dCakScU=;
  b=UwQ5RtMpyHHAEfFkVWoPjOkt3BJ5V26XZAib7GcI1D+Nyi2398bF2/7k
   Y42MysHrWghbi3A0pWDOcpUP9elG6P+GDDFvthiWiTsOOw2q2K7oFqr4n
   DW2FBVRZzbPsc5X6btXqoOII4UKHeYot/8nS2kgJwv6EJoqdtfQBguLsc
   uLm4nL8qssxBF1ddSzKZ/FTk1pfSvVKS+ahKWA8OnAHBO7NCMJMoTrJhD
   UeFxQGKsXo0ckvZNFKSQXLG/rxVSrmWVwSQ+0hQv5/4Ot4AlSjZr4+6OU
   AN+YeSCTRxg0LLULcNaHe2YyGk2hjsZ3SGXlbd2OOFMgYM2jb9p9gY2tn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="394517046"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="394517046"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 23:43:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946660054"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="946660054"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 23:43:54 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 23:43:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 23:43:53 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 23:43:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBmOrqk0NHkLG8APVyFOfQlZ305zfdYgofhlWPYt1DYOB5TiPC8A0L2asifKfczDcTTJZ850xxSwFWVwE5/TwASpSCw9j+uysJscpvkovEOyAH1ZxgozP1O7GtkxnfqkAJEo9iwcE9fio7NS+DyDYcQDIafNqtFtcct8PR0Pz9H3ssmQQQYvFHUQkj8wq/jFICNBqP3qvorRHim7YIRIdwM1hbiTI1wwSAnECb8dqkIsA0kX1Wn65gsLYKqqRji0PQKsUXhe1013RAyuw+NXqX370Xh2JeN2ehyWiT79VklvPStQfTANkcwgSrvgYK0x2S3PonJFT53CuJPdF3E2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCHsVO84P0oVQn2DtefcDomg6GP9rHNha0oIsBD1Das=;
 b=HH4SGpJkXioGwmFS/pP/aI6++x9DiSiWky8xYRvyVIyLpjpGbBa2uq66VCG2poqX20th5GrSuhItrFOiimzA84VDD+Wvnn11Rb4gTd1uDWWBJBNqT4BcRs1Q8x8oztgfCI9hbOMU5KToSfA53BFdcAT5CIbHrVfZheuQBUgpMTf/i57h8Ntqj8MBkfMnT2VNAGzj9rdGxBMnK6KZeOtR2prQYwJsu79rzBMkx7Q/qI7LFyp9bjaM54bBnAnYD5khJC9lOe/a5aEGLUWMsvciEn0GaqsQToT5uT0GPN9mF4kNoXsHkXOoOlIXE0DiUlcPlfu2bBLgiG5oIhChgbN79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB4947.namprd11.prod.outlook.com (2603:10b6:303:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 07:43:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 07:43:51 +0000
Date:   Tue, 12 Dec 2023 15:43:44 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [paulmck-rcu:dev.2023.11.08a] [EXP locktorture] 1254a620b4:
 WARNING:at_kernel/rcu/tree_stall.h:#rcu_stall_chain_notifier_register
Message-ID: <ZXgPMLDAn5ZHqvT6@xsang-OptiPlex-9020>
References: <202312071506.6eac1bac-oliver.sang@intel.com>
 <2ad1abcc-d82b-406f-a7b7-606224a24813@paulmck-laptop>
 <ZXfALH1TIHSH/7cN@xsang-OptiPlex-9020>
 <4be82070-4cd5-4f31-8eb4-b38853fad865@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4be82070-4cd5-4f31-8eb4-b38853fad865@paulmck-laptop>
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB4947:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a427b9-e732-42d0-5f97-08dbfae61590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mzta/ElsJUyRC28ZX9gjqHmshFA/x/rJBp9pd4Q+srYs/JYsRYgiwFEFrSj04k3jESh1oCx0wqTi1lpVobNZyKM+KEHW+KJmHbko85a9lxFS7OLeyIpUOzBxPO+vmw7L70mmfpt1YVOUKq9v6AVtrrbfY1gXZKEkEhp4zNrERroEFSJNCue3dKLDF5yT8XcRRSeCWlSlGTjWjSQw6eGJtE3ZUHTa6i4oYxVWbFAATIDk2GocdlZoqow6rE4QbFB7fqBpC20goFtt0Jy9TxQZFuGXofNG3a7NJOCmHg/W/mL/LWl0PvjG7gZ3Lqrt86xOwW8BaTH8RAY26Ut7/+Ws9XwB5w3GmoXejN/rLUk7otKKF/epPudexTQrJsHiqrAqsGl3Iv0npleO7bKNDg+P3xrvSAXBmlW1UMtBI/0hAUH5rb9oOxVZibIhogAqWQWHCmA1/VzZlsd5QY48J/bxk0xHeYtG6U66q0wLV5xonEXxib+pDSg1eNTsz+ygnqLfKHTzFMWwMXgxWMAta3WL5qEhuI5lCcFFmpiLa8XR736uxsWUkHToonZ1bqPdbXh+SRciPhQjQ/OCQ6h1tA2QzI7Lps101uBeIuBwJbMyeZb2kzJDpJQRpB8YSSBbdK0A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(39860400002)(346002)(366004)(396003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(86362001)(82960400001)(316002)(66476007)(66556008)(41300700001)(26005)(33716001)(83380400001)(107886003)(6486002)(9686003)(6512007)(6506007)(6666004)(966005)(2906002)(478600001)(66946007)(6916009)(8936002)(4326008)(44832011)(5660300002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D48sAanrqHU6nPRL8DiSx56PdwYSzrPvPNpDS4LAvc2id4hdDycH7wdJ1bGa?=
 =?us-ascii?Q?eqUcB9DFAvrQKXd4ibTLqBPXhAmf2Q8Ri0EbqzYBFw4bHl2+vX78oi4jLYPl?=
 =?us-ascii?Q?wIOOXptzFPU5gTSS1zfOrvGKizZhMU9q7LDyNQjWpkXv1coOokZ42dcxfDmz?=
 =?us-ascii?Q?rb2hfsIQCbX25D8dlss38v/67fZvAVp0xNxdcaNT4grvBIVF05R1JkCFS4Yo?=
 =?us-ascii?Q?eIYo7HMYaDyYXbcFboIMMgGyd7B9feidSkoyRH0zCTynNixyE1kZ1pB86kZH?=
 =?us-ascii?Q?gZ35gRlIqMoyGV0l2FlLn1bWNyZoSHE2JB3tXqCfkirDT1wQsCZyCEtEdcvS?=
 =?us-ascii?Q?ut50cj68/DGvCsYw9nklIc+rFVIyeaM5kjbBhZMcwa5QLDV65FAUyXj9qza7?=
 =?us-ascii?Q?k/7A0E2FVEtFh3QPlItetKIRmzU4vyYgGENogJljk05oUDQ4ub20L1dA5jn0?=
 =?us-ascii?Q?06uohXjGtLNrP+xB44KYHwmTFskdFWkX5NFcg7okNst7Jy8/elX2ufiQWaOr?=
 =?us-ascii?Q?wSbIyS5WeAAmajCO4gKMdqdgKAKa+VD7ne7vs9TFgP48Cm20dn/sMqbd05BR?=
 =?us-ascii?Q?J/MIKswiDTA9w+L9VPHlhi7aavZw2RCXECv6h9CpU0VrErZOXblhok0gq9ry?=
 =?us-ascii?Q?hffRQdJ3aksVAMqKG1emVsXtNF/KlXR2lV7RDd2XqplpKQ3vfrj6lDYwGjow?=
 =?us-ascii?Q?2Ou0yjsz7qxegCLgcwzQ/ySCU87JDxcM6ykReHJpIAkC09UUoOmE0V4P4EYV?=
 =?us-ascii?Q?hcFNyxop0efp9I+yi5Tf1BZ/XiQ+jf/I6Ee2KOczupSnk1c1j3xVzqEwQrbU?=
 =?us-ascii?Q?iIIjwMwdc15PZa3snVM3aW/3oib/ENBLyHaNhs2lkNV19pMgAaTpdSdx08vd?=
 =?us-ascii?Q?pFQKuhRddyH7lx7iYe9IcIYzI4iEl/iNknDn9ujedklS621XNNCYw9rhWk7e?=
 =?us-ascii?Q?szJP0z7VbdB6v6fHZuUswiMaih48Laa8Usu56Uu9904TnYTmIKa1innVwalT?=
 =?us-ascii?Q?/wjIzb2OKNxpmVVUUQETKT8t85g2YJR9sK0GzAro5DdqWw1ObMDYYeAEpZ95?=
 =?us-ascii?Q?PwSTG0bi74LyURFrkQZN9DZj5wxmrnwmWgjY6IBvL5+6tSqLbDnkCJxW4eww?=
 =?us-ascii?Q?BhvmUw18HIM+z30+Dvd7+/DtJUi4BHc9kVaE1ze/ge8uLMW/+BnVuGyYrDtP?=
 =?us-ascii?Q?i5egz6lpvTPR8KxIAv5o8da9HxNbjWgrJKuT/w6V+WoUyJ3nsTFL4/bGZ6Qp?=
 =?us-ascii?Q?N7K+AqMjn4Fs/DsyG4Ja8ALGgpSGEAnHFDuNw1jFsFlUU7ghW92isIFJghZg?=
 =?us-ascii?Q?FSGhWeTRIj1bDhKM2MRcK4ehqzDsFmmOre0oHBUspvXln3rAX8e7fC9AKPLI?=
 =?us-ascii?Q?sfg/BipCz/mOAIwCoVqSg8sBBpiszWlbBe3YmRLSmdI0Gu28s6ZyuMihidZd?=
 =?us-ascii?Q?Av3a0zTeBY7syvUfabLchs2dad/nHS9gQfRkYfcbHbCJc16ufcCcM+irj5Oi?=
 =?us-ascii?Q?IxVi3ssPEGbGCJiIA0gL5l9k42/Tcr4Gr+DfdFD9zi+lmkuShqpBXmGrVxAk?=
 =?us-ascii?Q?EyLYtWQbCNJfoO7MZeZi9xC+dDwBllV1UOGaSzXM0NUcbk1mIRRAaBYqMRkn?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a427b9-e732-42d0-5f97-08dbfae61590
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 07:43:51.5159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06nagDYc47nEKL+yKHXXHCmMdIjq0RHndjdJbs5NDlmlXFsjdfwJj364WBLd8F2cwKtdpjRbsIM1KkJb08Ae2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4947
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

hi, Paul,

On Mon, Dec 11, 2023 at 08:26:12PM -0800, Paul E. McKenney wrote:
> On Tue, Dec 12, 2023 at 10:06:36AM +0800, Oliver Sang wrote:
> > hi, Paul,
> > 
> > On Mon, Dec 11, 2023 at 08:59:16AM -0800, Paul E. McKenney wrote:
> > > On Thu, Dec 07, 2023 at 04:19:56PM +0800, kernel test robot wrote:
> > > > 
> > > > 
> > > > Hello,
> > > > 
> > > > kernel test robot noticed "WARNING:at_kernel/rcu/tree_stall.h:#rcu_stall_chain_notifier_register" on:
> > > > 
> > > > commit: 1254a620b4a3832e65ac01bcef769b99e34515b2 ("EXP locktorture: Add RCU CPU stall-warning notifier stub")
> > > > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2023.11.08a
> > > 
> > > Thank you for your testing efforts!
> > > 
> > > This one is expected behavior by explicit request from Linus Torvalds.
> > > The concern is that people might use this hook without understanding
> > > the risks of losing RCU CPU stall warnings.
> > > 
> > > One fix would be to never specify the rcupdate.rcu_cpu_stall_notifiers
> > > kernel boot parameter.  Another would be to forgive this warning when
> > > that boot parameter was specified.  Your choice!  ;-)
> > 
> > Thanks a lot for information!
> > 
> > this commit (1254a620b4) is a test for this warning, am I right?
> > when this warning mechanism goes into upstream, do you want us still report
> > for similar cases? or we could just ignore them? Thanks!
> 
> This 1254a620b4 ("EXP locktorture: Add RCU CPU stall-warning notifier
> stub") commit is a debug-only use of this facility that will never go
> upstream, as signified by the "EXP" at the beginning of the subject line.
> 
> Or is there some better way than "EXP" to mark commits that are not
> intended for mainline?
> 
> 							Thanx, Paul
>

sorry, seems I didn't state it very well. let me clarify.

the 'EXP' and "This not-for-mainline commit" is very good for us to know it
will not go into mainline.

what I asked is if this warning is triggered by other usages (not this
debug-only test), could we still ignore them by following below guidance you
gave us?
> > > One fix would be to never specify the rcupdate.rcu_cpu_stall_notifiers
> > > kernel boot parameter.  Another would be to forgive this warning when
> > > that boot parameter was specified.  Your choice!  ;-)
