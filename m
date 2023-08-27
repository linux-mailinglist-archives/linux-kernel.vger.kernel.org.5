Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A8378A2BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjH0WdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjH0Wc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:32:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2102.outbound.protection.outlook.com [40.92.21.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58865D2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 15:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEsTLI+ygFShyBBkc3lG6HnLgNcxB9O0r03A8WenE3V0ak2m4jieVmZ+j6Xu8BwHY3xGIAVQeFStBv0XclFBAVxahiKS5A0Qpv9gEWk5SKUud2G6jvYYvlVrsIPDwon3iJVODw2e+Dfe3IDNiXxGXQFVXNF2bG4rj+GajTcUSj/Ij9M1Lf3vlTFdu526O0oRWuswNf8ck8HIT6SFsf6fHw0Vzx0VAwYr86A60HDwee0vu+CrBYGm0mrlOdkioOuExbhW1FPe/hc6dgIIhnivi+9VDE6OBRhsjA3oTeMABoTUoAe3fTnwnSfcKlGnLYr7i6d7CZ4J14BqnM8Kf0O6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paQfAqlRiUUJw4oOf6slVFlsEDkfp4G8pHYcqcr9aUQ=;
 b=m3GhesVHxtusoR7RBFZKUSgQLIsfUluDuJbFJu5h1SrkqCOdXnhPlyIOkfIiBXkVfecMQDfCxGWb/pFF9Hl9Ro7m2CExa7U+scbOApggY9bKVKnw1xEPESGUhhA1zmFt6hgFE//En16neCdTVCET68VyrI80k6T+GC3JNnPGupaTO/ssopNlyRXpvBv+Nd08haPCZQsDpXUK2w6/OOmz4Dv+qCs7mhB90ZGPdNUf6xsp+7dWMeG2BPdGk1J0QIs//CgcuncP3bOPZF3u2ac35Y4jqzca3BSfanVlL0wTTZBDR82B+ovFurIa5DMLlbIstmugSgCxUY7+C4it2Npvyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paQfAqlRiUUJw4oOf6slVFlsEDkfp4G8pHYcqcr9aUQ=;
 b=bOUCR4DleJulxXTzplsHRLgsHplh0+QFUWpAqYUsxbmNGsv0NGNVZoMabgYcRm5Xw6v5bHuBfLjhn70PqYLGOLaKd3/r8Vm3H9qe5WrZ/3vua+bz2ITF3S4YBGHmPPJcPSNplBaDdNqytuFvbwjiO5XYmRIi10m6JMFz8jRBDI5KrtNoH4MqFMr4GTvJY7Z3zkN+GpA8fjxBdurTnon6Y1SWSkqhBESSrf7P6b1YSNcxl50Iwe5uHjmZDBfoKwUsqQxCxz72eDzl6Qw09xeHw0YSXUDhQrBMeKDCFA1NtRbMpJ1bUgURLvMuqvC1NAUz+BXD0Aan7vsEgbL3QHdOpw==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by SJ2PR11MB8421.namprd11.prod.outlook.com (2603:10b6:a03:549::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 22:32:54 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 22:32:54 +0000
Date:   Sun, 27 Aug 2023 18:32:51 -0400
To:     Nam Cao <namcaov@gmail.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/6] staging: octeon: clean up the octeon ethernet driver
Message-ID: <PH7PR11MB764320782B13A53D79F3DF69BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
References: <PH7PR11MB76436F3A05897D8F8DC9F967BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
 <ZOvNvkRJstLt4ghx@nam-dell>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOvNvkRJstLt4ghx@nam-dell>
From:   <ozlinux@hotmail.com>
X-TMN:  [cRA5uZnRz2Qkna/nV+vbbcpK8YdRxB5PXHBg1hvrMpOieNTblFqigkcffI7kKNNv]
X-ClientProxiedBy: MN2PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:208:234::19) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <qpzblgkrhi3usgybnkinctqifnyw65j7fe2dmsu5wk2fneu5zo@ius6szerbne3>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|SJ2PR11MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: a1fa64a7-8555-42bd-6876-08dba74d8de3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRBI1kRfQwWYe89gbOwLJSzAneG5PYvtuLatewuk9UvHOAouXp4h2ecIO2QkYyCerGiRfG6bi2EHWAAaLE/T87rQKojCUCcKbQhqMUITeFCpS5Rdbu7SbYK8Z0Ctn1qKUCNoBP2ni9r4F9DIS1dZENgZPfmGdcvUgLkT8rg9lUF4qxnYdiFf7LsowAgZ+3f3lo7lPUeVJ4YB9KTOskC2XmM9xKAvX7sZItuArobQCZX22rEv9lV80P5+x1ven0LNcU8It5qDGflLzCa0xusj2bFAnlRuqv53zgPYsjZ7PwG8sNfPwoWS4m1U8UpgC7sUNtj/2lWBR7N6sHn4qxKul4AjGkEBm3EkfKn4Sq9e3QVAth5+B9HmR5NMlNvR6zQ0jKwBv5KfoPyNEZ8pMHIqDinVuvnRQYpsB+CY6A9JeDP17uoGxMkE+8je0xR8ouMbDHaqPuPoA6deWv1A8u05Ny4awzPplY2U69wb789UsghxXC6OjiFmkf5HMpd/UfjbEwgFr05bcVOlMQGUWB1JcjIeSkd/viOtYWyC2QXnbVllSOMb+HJH1pK2yXHcv6/l
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eg2yiM+csfjiTznDsHru8IrXVomg+3r4LkaxHpdQKgIgzjRIQjuJhXXRlkNf?=
 =?us-ascii?Q?sA/cAVEaNmWXT0j9/w6DK5KSw6kZLmYjYnxlS8YdDt2GBoeosvadyoJCjKAB?=
 =?us-ascii?Q?Wlo0lyBLw8rxpv3RBS7uRgXRXoBUzuqB9sGjHOAYSv9LPDMsNPANJaJYTKop?=
 =?us-ascii?Q?4Rfi7fG8xmbHHCkktAf1GxdJJK5W9I+PnegYAOj9qMvmtUSAvVDfZH5OjKWz?=
 =?us-ascii?Q?++UWkWgxSBxi4dBk8C8pGlZtvlLw47e7MZ3X+yNyTQ5xafsdCgBAj3WP/q01?=
 =?us-ascii?Q?3Afjy1MhuA4YBaIdUbjbZA5u2WCtkQgxZLa/OaANjymUx/emaPnPIii8rvH4?=
 =?us-ascii?Q?kKZKqb1bs4eepdblTIi2iinj/lOrqSqO+4/m2WaqCo994GR1BYiXdIl1nU4Q?=
 =?us-ascii?Q?8H/REWly+NyFPTgmM8SvjqruG3EmWj4TX5Fs75bV99P7IqmR/9UYVhUwG/+n?=
 =?us-ascii?Q?mtc4FdTXOrwRXjRh74cj1NNN5iSsa63TS2cPBXSNTf/ni41L4/NkXVM1VKUc?=
 =?us-ascii?Q?UFTjEjaqlxaJAOgGN2WK4lxNph2wFiqXkrei2kuIxohQ8BVlY2Jqkoj+zC0C?=
 =?us-ascii?Q?g8FUzUaFY1IxVhnyZJfnVjF7sr/ps0Z+96MrCHUN55mLwWN+PY9E4g7koS3b?=
 =?us-ascii?Q?s2DjkKzwtSnY7QHINWh26j9P6zZnOQ5tLzX2nuA5l/uS3NOvRmFVetG30PN/?=
 =?us-ascii?Q?id4tC21G5zGqE64F5MMHToi7les7RsSMV9o0/vPGhpy0lfkyNtpP0u20/6oq?=
 =?us-ascii?Q?VgtRHVaEv9AakxFgJXzh4bJXMArz4T2Lo5BhcLq24o7BvEXZwI/lGRT5H0p1?=
 =?us-ascii?Q?Zyitmy8SjeWGH25GsoOcT2YaR0jtswiPhr59Bcp7rz2a6BpkeDLjwQG3c47/?=
 =?us-ascii?Q?pwfcXi0Dioa13z9f40lD09OIS6zyb5lox8fNMKBWfEWoPSaPtKBPZPhRcYCB?=
 =?us-ascii?Q?B5DgJ6N/Irkv+wrXZ+fJYXznIZtP8ffcl1B4Hi6oNBrq3luSI5RqrLo81FKG?=
 =?us-ascii?Q?ohdQl/eU7pD9Vxnr9RYl0aEhzxZGFDsGN3HtFoNZOEbiEqNzabqx63QG05+e?=
 =?us-ascii?Q?P4ceLUpdSSPLuLBB6vtsgVfeLDu77g9KbyEqOgtmoXuHZHvV7LZzhzZS4zyi?=
 =?us-ascii?Q?7KH27WxuwFLWwadorPJfcJ9NafwVi6tpfzMPEGPb3tDd9BUZr7OGvuNe4BV0?=
 =?us-ascii?Q?cpREqsUrYEM3HYJqSH+sc7VBJkT7knshykE1Wgn3+hcxa1IuPo18cvk+pA1C?=
 =?us-ascii?Q?QFaO3Eyex/L1wCoP4rfrJ/MC8pF/OrK66XDrHSLZDQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fa64a7-8555-42bd-6876-08dba74d8de3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 22:32:54.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8421
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:27:10AM +0200, Nam Cao wrote:
> On Sun, Aug 27, 2023 at 05:12:04PM -0400, Oliver Crumrine wrote:
> > Make the octeon ethernet driver better adhere to the
> > kernel coding standard
> > 
> > Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
> 
> See this conversation about a similar mistake that you also made with your
> patch series:
> https://lore.kernel.org/linux-staging/ZOpq4t22iRXewekD@alolivei-thinkpadt480s.gru.csb/T/#t
> 
> Best regards,
> Nam

That is totally my bad. Should I leave it as is? Should I resend the
whole patch set? Should I resend just the last five, but attach them to
the first one? This is my first kernel patch, so I'll take any advice I
can get.

Thanks,
Oliver
