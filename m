Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6687973DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242444AbjIGPbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343606AbjIGPah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:30:37 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA50B1FC4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGHqcQqwdLy1ARDVulOJgV1lkESN3Gcqdks9SSSRfgDKQm6YmNEtLVzf1nwkfx2rLEYWtN+ksJNQmu6YI0gRWyN74Eu8MwZSy4UcvDIbOUXnFz9mOlKdfqv2oI2Fj5ethqIcj3hIx8pofqWmq4KKlrqDu2zOYOMMVzuDhVAJVSeLobTu+Uu9YmilyYcF6ckA+39AmU2Mh8fpnrwJfRUSDI5ZQ5xiyDxKU0UJVS2Cht3SvsXj8NVt5cMb+dWqWMqzZpS6a/1chcILqm771/5E6lCfKPa/XBmX+b/Q1gLsJUk19YUDE9jzqMGS4et6sMIcPmBTySNPXcqrd71vNPvblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HogHCOuUF2Rn3dRl2Mz5hHSZ5NQqH4hr4gu/McGOOTM=;
 b=aS6jckBklpnObH6cmxEb3ZAbeNUYUP9eh7LFLBYmMTzrzwXjfYPXz1vE9aFmw7HO1qpGdbG8g0N4si/ASG2tF9+wszDEuCD4+pmuJ/X3cP+09F0psmIeUQZckTlehePIsoeLjqcvBYJaWZmE7hWrYzpGCwz4hi6MYMyq9p/QmGyIDukz5gdMPjmdCgTFRAyouXgKpBcfz3SuAMXKm86CcsQrdahCbd4mT7zD6rE7+gEEquTqzcydErSs4Nz5yHkwXdA+HyVPkCwvF8BoOspVEWyDiqyJYEhKDi+ZbOoz/K3RZMo8yMBNc9AbKq36DSnG8hYml/qeF1IX/tjiYMDX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HogHCOuUF2Rn3dRl2Mz5hHSZ5NQqH4hr4gu/McGOOTM=;
 b=UfJi4vpfSXzBs+ryYjMaGnYsGxk+78bPZnWOqpyK/RIIhEFgez3yhCUq3HQljssxiC8oDsNYn9Fl2WGLjauSQvAC80jecxAx8SLEokkGbajX/lPbVHg54ljNalPQ7Epm7WQS9Gxb4cSNABqsskqK6eV4cGScOmWREzW5W3MkZxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7250.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 14:29:03 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 14:29:03 +0000
Date:   Thu, 7 Sep 2023 10:28:51 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/9] dt-bindings: i3c: svc: add compatible string
 i3c: silvaco,i3c-slave-v1
Message-ID: <ZPneI4KUw8UXBUze@lizhi-Precision-Tower-5810>
References: <20230905213842.3035779-1-Frank.Li@nxp.com>
 <20230905213842.3035779-5-Frank.Li@nxp.com>
 <e9880548-11c5-2790-7c77-7ca031849182@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9880548-11c5-2790-7c77-7ca031849182@kernel.org>
X-ClientProxiedBy: BY5PR17CA0050.namprd17.prod.outlook.com
 (2603:10b6:a03:167::27) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 156087e2-b07e-4e6d-13cd-08dbafaec8f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +QsZaOP98aASuudS20sVHBjuGMrTgkYKU2LTDmHaHYJuuVt2+QUSj5mbZb/are5WdE7RsH7bzhQaTdHZm1PrxegOKQUxtrTkJ+4eYYzLH8FYB6MNXD31xoyy8crjvB4fpAoyM2zRBfA8K9UITLCm49Z6Ij5ShHi42EiaGDaClsv8s9ZLJZhPA1dojsYK8icJT8rG0ikXUVbo4KkibnUqT7+4HOdnLCo0YV+K7a4VurVh/ryoPuZNbiTocjjiZylxUblbgbtjKAGeaScfZ2/cziYocgj/V+fjey2oJA2Rprlxg4Qz3qfRpdBhEC682MZXbIIKwkpkkd4FeIttHcClp0Dn94o86wrLfqFAVBPN4Zb6RuamckWf8/euRnUXMfQdQCYZebEcFK0shb7/Air5JWmYaXyCZfG6Ago9N3OAgtv5cM8YJT9wu4UNOkoSlseFF6a1mwLYGQGBqBpdn+ZLY9ThzC+chRFyd0vP6VNbZ3hBA5NXkpkyb7ZV7Q8Srh5Wr1KOGOTQ+v1/5/6ahfvK2lrqDPxR8NlbJ/foW8UBiGuw3axPRAUkMj83GGqIhwSggvn2OoeC0JAjzrnERwDZZli9QEdIuPCDHywaSphaCoEAQfiq0zEGmF9+Mut/1653d86LfKdF5dpDkPI4TQSXKrqYMwOqrK5dCiji++TETLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(136003)(396003)(39860400002)(346002)(1800799009)(451199024)(186009)(6666004)(52116002)(53546011)(6486002)(6506007)(38100700002)(86362001)(38350700002)(26005)(9686003)(6512007)(478600001)(8936002)(8676002)(5660300002)(4326008)(2906002)(66556008)(66476007)(6916009)(316002)(66946007)(33716001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KUf8xRbmvSZ8bCc06q26ljkE0kc7mikuepvitijJmD47b803qW20z+z9Lx7S?=
 =?us-ascii?Q?IkZhm1nk5irwiq5rLXcwU02p6prsbdF8oa/6fxWAkMCdJ5NGq/KBIG4wi9ts?=
 =?us-ascii?Q?R29t8mzYMMYCUBmW2NLveubR3dEy2sQ9UvPR1a4kYWyNOVFdp9UFY7Opa97h?=
 =?us-ascii?Q?fK0MU3AMAOqFxNDxCu5oYojUod/Fw1kMiv+90uyocEI7j5XVIW4tCYmxSezG?=
 =?us-ascii?Q?aibyb8kWglJBXOzKiAa9NYLgrbQ8eY0ssiv1oVnwsCmfaYSFup0OazkC4peh?=
 =?us-ascii?Q?pS6H4tlA1v29XxMghEU9o5JVeqMKYoRMX0Ya3bvnC98Bvq66xiJL3oeOBUda?=
 =?us-ascii?Q?xY7WpurUFKvR4hxA/fo2ddx/8xBxUpMZI8onAEuhFRQz7dekmYD8fKESVuu+?=
 =?us-ascii?Q?EA84+R4a/LBst4i0HDZJw5b9AQ5PD7WozHc/VKuLgc4mBF14YItSW42wFXlQ?=
 =?us-ascii?Q?uHfUgLbJRvCg3FOZpW6jMkqH5YXpS6r5OSbhhimFxLjnxEwBK09qOsyiBQbA?=
 =?us-ascii?Q?UtkQRj1LyC/MdfIl/4ivMZmeHnTLHVWwsyFLlAYcY+YXYfIZ0HrE3OrhzIYM?=
 =?us-ascii?Q?ONsp1bQhzp4Q4Xu59UCbghx5/kuMTU4APPVUTyASSe3F6I+IJLoHJJaUHwio?=
 =?us-ascii?Q?l39I37Gu/pxcHMUBm0XSpd9NFXeTocfpeR0UYMgVhb30waWbzDMzWNfRsEHH?=
 =?us-ascii?Q?vth6XH51On4dDG92vfRX0RbCVj/GPZf0mv65uMXC42AYNScKPUO7P98j7+6q?=
 =?us-ascii?Q?rk/E9Ye3A5k7S7Yrel197kznhIvACSkEGI3tQ0Ctf5iSJcszU6b10uE0ylnV?=
 =?us-ascii?Q?7bb2XQ+WvqFGnZcd97Xkwam/t1nTkj3++kqWlrMFsWwOml0pERLwZNgqICxq?=
 =?us-ascii?Q?pX4NmrwFL9Vcv34upzwVL3BXuSMyXdRVuq2DfQ+KjtaB/B4sinNY1QSZpEWv?=
 =?us-ascii?Q?WOMetiBQWS9cbH+w+ExjafvLfWNixX8ntxYCwCHW6W9phjSOvf50DD+uXXMr?=
 =?us-ascii?Q?mWBwJDxKfkUGYCZ8T35A5SuW0TFCND+llUUa2yLVmxSQhByCK9afp2AZXBMK?=
 =?us-ascii?Q?4+K5kixI01Sm9TuqxzFRfvSOUbMXqD7I6gXiYhPyMC01eIKgjlULed9ykysE?=
 =?us-ascii?Q?2VQlP0k2Iomr1lBlnk+sSsL56fonie2a2dXtATbVQmKRuj7D6Zg6QxW4WStS?=
 =?us-ascii?Q?eZulJkWXnz16uL7e7nlH65liTweYH7aydYJ4//tFQ5Ki5Fun4SKrH3TyIBYp?=
 =?us-ascii?Q?KRtqFrjh6QGVWuyLwibHkKiBifTCuG6oNPP73bmO2IBWhi6ylDCsn152o52J?=
 =?us-ascii?Q?k7jXsn3HAQEzhGfCavIbolkfA/aYUHmZYba/uwxH8oyZY/nGu4WPFjxjmY7T?=
 =?us-ascii?Q?4r4imn7gSGSwuzyuZUUg+IKfIHsG0ubruHIESEqhLwNGCOwJcGCR8u0H+DC4?=
 =?us-ascii?Q?gHLOXrNfzY7VWOGxsVeaB0HGVTsHDivsgryNK1KWI1VZ1FMJ7QNxh3F8r9rv?=
 =?us-ascii?Q?tYlolXAYXcX3LW+L7Nhx3/AYo9LBSrkeK2DnTYc4sJrQ5an+KydttJ/LsHJm?=
 =?us-ascii?Q?TqinWSos4eMPQGJJYWAc17FaJTg13y3pWRZBF58k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156087e2-b07e-4e6d-13cd-08dbafaec8f4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 14:29:03.5736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7l27WPsvL0Tq9F2h1bWtb7fvp/JapwSkO1ddopiL1P2891VbpcWtQD3lUgL/31u28i7EpUhVKJXdjRkN6pu9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7250
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 10:01:40AM +0200, Krzysztof Kozlowski wrote:
> On 05/09/2023 23:38, Frank Li wrote:
> > Add compatible string 'silvaco,i3c-slave-v1' for slave mode.
> > 
> 
> No, it's the same device.
> 
> Anyway, this was not tested.
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time, thus I will skip this patch entirely till you follow
> the process allowing the patch to be tested.
> 
> Please kindly resend and include all necessary To/Cc entries.

Thank you for your comments. I write notes at RFC cover letter, this
patches is not totally completed yet. I want to get more feedback about
i3c slave mode API and configfs design, which will impact the overall
design.

So I have not included tty mail list and you in review list.
I send out all patches just because let i3c reviewer know how to use these
API. 

Frank

> 
> 
> Best regards,
> Krzysztof
> 
