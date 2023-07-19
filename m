Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409FC758D59
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjGSFzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGSFzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:55:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20616.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37B11BF5;
        Tue, 18 Jul 2023 22:55:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwxTSbPGSWFvr5vw34xJp0nLdVW9In6ewt1yz30wLLVwuH2vl+46ANXeszZLYiXaeLkST7NMV76VSxxMCDx5eTDN8uf2acJkLYgv2qoUneqt5XuJ17eG5RDYy3XIzDIQfgIteay4JeOhmjMYDp3QLLzP31TcHbgBGP7asLSvaGy3cRHgyDJRtbHAvQ1KA9Ek8BZ2BbzREkDcjbekptlX08SZyPkMEOxdvyoPKdqpK/BOgII4J4o2p7xkPUa92Oulnd4nzkmWe0WM5LEU1N6l8EA2Ay6VolAbTANas00IUi+cueRlZ3k1ooTuGXp4dkiKIcE0Gzt9Td4o7A4WxVNG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUeyV/a0Ef2Mwzszx1aKGv4bCxudbDg6NQeJdkKrGJQ=;
 b=oPV82KVVRXByWYodx7XesA2EC1ggBDtEfViOSXzeQKrs0meCpCoNzKzWwM0eUnonwu5OnZkobJp/GJfQ9cVrtEEJvT11sJZVvhBHOJ1jDXurfqhNzXCM6yNckq47Jd3+z1FazNmueIUIZKRW2Sjbb1sL/HR2i/eCXzMGtoHhj5QO//xf7CoBOPh3TYYQ5TFyM+INSlr2r7kHk+sGQFyry9QQvKqtpUHvU6SUQp/WUHDpmZwQBF9bGLS2NXjVEJvy5K/n4eev0Wcf2goqjcwISVcYjnSWZRjWZi4zGXaCQgnyYM+PBhH/6ZDt/sqN6frEwvVDRHou01qnGV7DjMrL7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUeyV/a0Ef2Mwzszx1aKGv4bCxudbDg6NQeJdkKrGJQ=;
 b=Ku04ewdac5/7UGLJ4i2x5nie1Df/3oLH6xnteLZDVHQwaL7hFcMqSNus4s6xU9kgrE2+ux1mkH9UaX6pRW9Odl44agOjceACXW+DpDOV0wqB3NAuOcO9p7i+UpJBScfkwQLQz40/Y0UKWTvFypG+6L/yL7JfrFeDr3TIRhlhV53RBmoPDicshoEhZmgGL1yLSfMN8RNC0LyXKux3v4cdH6wqiSfuLChsAhIAaQbwFQfwHt1ex3M3ohaQ8wnVTb/pAs4Xlg0MerabCVo6fTI93kA+Ju5Ice1R58nEQKwNToZBbW0kp2fmP4jmgGyWQTROysY8UOM4TP6ErlBLlwrCog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 05:55:35 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::cd5e:7e33:c2c9:fb74]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::cd5e:7e33:c2c9:fb74%7]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 05:55:34 +0000
References: <20230719143233.1c283b0e@canb.auug.org.au>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Date:   Wed, 19 Jul 2023 15:55:16 +1000
In-reply-to: <20230719143233.1c283b0e@canb.auug.org.au>
Message-ID: <87bkg8la27.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0116.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::12) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: eca6d7d0-3745-4eec-30fe-08db881cc4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZDkGxnc1kwscS3lq24P/RO8UUOeGuMSeEv0NVDGDge8RWwuma01mnknJR+uB8l5UX3S7RhIVQzOFC/+HDYzBZ+pweTR6/v3lQX9Q6GMpNxZX6HxbVyoXupi/upVxhQhN9gBFFz+ez8Zyvc+INI+bdYcbsEUGiSBSWp35+PEj6w/FmTIAgtrYgSY38VpdKjcXcGgwvPficHxLHrHSUp4tT2d1e3lpoDctct/6jre5NZZQK2PJ+vs+laNWY0oFu3PAhCuRYgO4ozWujO7ITDxtGcuihlqU9dumjGYsofndxHgf7QgzdyNvr0ZCEn+ExK7WoYzPUmvN21PtjsHJup0RfAA647Ujor8UbzIjPNFArzgh/avSvFHI5phdsMifpQ8NpTmqT7AninipR0wFUmo+6ulvuhleLA0scolxS5wNY3guHBcASNMSWpxWavtLxS+29Vjlx66AvERsH8TMO/4MwgrVzyy60llJF9DKWVa5r7H4zy7Y9a4c3TsRSfUFMA9Xl1Lk/Qv3YYuPrHqrSTD6EmhqITU30vEbNBORECqnAEXMIWSb+CbYlI2NZo37vnu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199021)(478600001)(6666004)(6486002)(66556008)(54906003)(83380400001)(86362001)(9686003)(2906002)(6506007)(186003)(6512007)(316002)(38100700002)(26005)(6916009)(4326008)(66946007)(41300700001)(66476007)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q0B6i4MU5TalezM02ku9ZQ6kWzpgAIg8UGTPQo4EBqlCGsul2ucFBC5VUpBP?=
 =?us-ascii?Q?8SIH/RJ3c4L89EkAjD/rxJhCvOUHZoA5UNAA20G6AyolOYlQ7oCVSgKIpCO0?=
 =?us-ascii?Q?Qgk2JkJhU8CpIpwakRO3ESEZXnIX7lt+jZx2QZ0G5sSdTEyD3iuH8sDzCUe6?=
 =?us-ascii?Q?KGl2rFr5yz7AxJSxqWEpOzMVIU1w8DOX8tfkz6LioBoXKPFeg+eccMpmQcdi?=
 =?us-ascii?Q?v31n1WTBZDqhLMO7Lbsp+hvbzb5dmQbr2Gu2HpVYhnoHDNTome/PUncohu7Q?=
 =?us-ascii?Q?HcIdAMuzVqvpgXriC2XB9YCQQosWNq8199KUQojn0eCSs8Jh55b65+5bIGer?=
 =?us-ascii?Q?236HFjm01f1qvLldoK5IaOr+kbeqa0nlbTUBtirhc1XwCH6zzTa2abDBinMb?=
 =?us-ascii?Q?BcddxLpznsI+r1WrDVHlZaZOscfd6zKuyoPG1YNkvzWjujZXy0AXgn6zmhS/?=
 =?us-ascii?Q?r/ArYZK/cO16aIQinTRqC68PQ7TVQd0X6LWA1VvdzjLzisGALDqruD43iQhO?=
 =?us-ascii?Q?1pFRdxaVHIeQbewMyU3M9RqEDAEEoDaVX/mM2Sd2PvF5yR4G3OB9CgjJsJ8g?=
 =?us-ascii?Q?KsmKIkOAmpa5Po0XC3/4MeaIz9cpdBy1bW6TRJuLiQCJaIn72NuOqpkDykO5?=
 =?us-ascii?Q?TxiWVWQhvcRUQ/G6VCu8Zo3hrXB+En7cEmzHqo67GBCJZz+lnQ1jQqnYjkJl?=
 =?us-ascii?Q?fZpk1VwBTh6u/MixQ/J6rZrrp9+kdy0OtVf1qd1NIoFe4zyVH7bseOvFqowF?=
 =?us-ascii?Q?nx2qrdktr86jC976sVVGjm08PMLoFrcE9U+Re6/yM6oogAJQWG0rS2J4xeO5?=
 =?us-ascii?Q?YbTlcsGN8Q+jSj/s5nZXUruZQ6JnzBii0X3+niZbQhB9pJzUxndercsUQX2s?=
 =?us-ascii?Q?X2GzwleDOdXlMw9NUBjgBi4xZre9wWPURZ23AhPDGYVrW+5JioBPuT0A+cCQ?=
 =?us-ascii?Q?iyv+3mO8FdkKvvFatZFRcLvj/l/qCMdOpSWjLUdL7+HVgc5yE3KXSFK43ecv?=
 =?us-ascii?Q?TEr+kAYQzTGwWIEZPPeBWEn6UJ73nmiYWwU6mcfTNf0ybVHQKVh91LZ8nHlW?=
 =?us-ascii?Q?6NkN4StgL1LW0z6rTuUBqWk1HaxR2svmCZyIs5wKIK5H5QwbhXnSZLbDbkbD?=
 =?us-ascii?Q?Wpy2pX/AUWpzjVVH6bhZeDSrvQlTAp5UmHUz03OvapqojhgpK9CxD4TDMY/C?=
 =?us-ascii?Q?b3bupBt94ERCAQsMqep8nfOOinDXDDKMXKjC9SM041+GYj8PHG7h5KWPEmtZ?=
 =?us-ascii?Q?avGitjBcz/yY74dX0FsOiBNxlIRw8S2Ut4HdSbAcJT6PV4Z5TGhYFed7ihbV?=
 =?us-ascii?Q?Y3T/McZS4yEbNCT98+nYaIq4dJYow9ulRNFhdQCE4UUETs+T5r/CnR8cdScZ?=
 =?us-ascii?Q?5rnsFjc5Ki9b0Fe1ZnEuxlv0VP/KTi1PMPGTOsVIfWm79gSXTPl/q6JfN5UA?=
 =?us-ascii?Q?QiwaFUP7qqmrRtxF7pVKcFcp00CwrkZ1QHHOdkUSBjirHSgyv++SAID4QkJr?=
 =?us-ascii?Q?vMHIktzqsGT6UhKP72D+M9IITO7xw5DlGYCmJMgd04NPBZTDE9K4EyTgMhJ+?=
 =?us-ascii?Q?MBzuKCCmOJ+tSVrLxnKd/cXMCX1wPEVScm/v1W5d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca6d7d0-3745-4eec-30fe-08db881cc4ce
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 05:55:34.6281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rh0Z3g+m5sM712CtE8Pz+C5t3BwukVznqVNO2y5sw35MHZpZFyjXwpkfe0zQtijhVXHHM3I7EDR0i7vVXPpaNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Stephen.

Looks like a conflict with 9c47011d3302 ("arm64: support
batched/deferred tlb shootdown during page reclamation/migration") which
restructured that code slightly. I have to respin my series anyway so
will rebase on mm-unstable rather than v6.5-rc2.

 - Alistair

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> [[PGP Signed Part:Undecided]]
> Hi all,
>
> After merging the mm tree, today's linux-next build (arm64 defconfig)
> failed like this:
>
> In file included from arch/arm64/include/asm/pgtable.h:15,
>                  from include/linux/pgtable.h:6,
>                  from arch/arm64/include/asm/io.h:12,
>                  from include/linux/io.h:13,
>                  from include/acpi/acpi_io.h:5,
>                  from include/linux/acpi.h:37,
>                  from include/acpi/apei.h:9,
>                  from include/acpi/ghes.h:5,
>                  from include/linux/arm_sdei.h:8,
>                  from arch/arm64/kernel/asm-offsets.c:10:
> arch/arm64/include/asm/tlbflush.h: In function '__flush_tlb_page_nosync':
> arch/arm64/include/asm/tlbflush.h:268:53: error: 'vma' undeclared (first use in this function); did you mean 'cma'?
>   268 |         mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, uaddr & PAGE_MASK,
>       |                                                     ^~~
>       |                                                     cma
>
> Caused by commit
>
>   8c2be11e06f4 ("mmu_notifiers: call arch_invalidate_secondary_tlbs() when invalidating TLBs")
>
> I have reverted that commit (and the following clear
> one and the two
> earlier ones - otherwise it would not buildfrom) for today.

