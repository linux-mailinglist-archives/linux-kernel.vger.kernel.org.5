Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81447B17AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjI1Jjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjI1Jj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:39:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2016.outbound.protection.outlook.com [40.92.22.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D551AE;
        Thu, 28 Sep 2023 02:39:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Da/+E1qRQwnGVRCkPKGDK2WmXJ/xe4stZFQQl0VZr5DXbERXBTZxksv4LDLl8B0KVUY7LVnZZRFsibaqXETxpy33cvfsFYxk19HG0T2MI1+81rsOSEfrvk4pFl5pg/vF9jVr2AWV2fFOnUY3f6i/B9aszpWx5hCXFub0yHgMwLRY2vYvtji+s26/CMSeg5uaaDdAz2slyOhLrgu80uRXzai7K97Q8ZO5jFXYxiP3zDq4zL6eI2WXHC1u2qa3SQ9xfqy8YQNAl+4iYYmhZikJ+7NM/LwLZfnc3p9iPZwq0PVC02b/QMb0R4msSXZdjpBX0o6XbEmivooUCp938PZNzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asy85TjLQLQiIwfF7+PJRbXx4xn708tpJi+3YHvlIxQ=;
 b=hI58V2ZxYVR1KGCeUroZ6+UNDHXekkaOG5xETww8Kgm0JYjGKJD8HTw72GErdVX39u3kGyNKsWKulZ0LdwJDAAOdloS/TrwHVQOJ2MAuw12aWoVSV5uTC6VdE0K1WP+ZOnfkhvQiFUrrlUNwjlTa7VVXGA4tXKPlRrnrqbam74XNomSkoGqh2Utu3okKga8stADwuzxWVMTHR0NoadDW53k7cMAHMKlA6DL7QplWz/5+U4JLXN32zi9q9Htu777sqUAYjpHsl23Zo1Ef/OtGCu/9ljHiDeoGZgR5smKqTMev0yUxQKalre3/RESiuYVfAM4jphfOYWWMJ3RkLASMKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asy85TjLQLQiIwfF7+PJRbXx4xn708tpJi+3YHvlIxQ=;
 b=U2NP8E2/yURp07wEzdzV+jcgKOPJOBhQEyDENV5T5EbLoiIgud4CHLUm5TpcXWH7YOxRg7DkEeeTL+T+sUy8qry7pAwNpv2/uNlLDU5M+MpptiamguHnyXcXLAtn8a7AIgOk61WLaAEpyxycNsWR5bRqCvitMb4+qnBdWwNFbaAypRUGsAJw0qPLk5ug8bPCbMeg9dF5TRHjYQ8+qAkwqzJYJj8CiWRQszs1FWo97iec/DBgZk4oBSEwm6dtRx8CIaKSmpFLyOeBwAhm8xCaCbatSpB1Mi051l4hGT61C7l2t41Yin/4rQyPln6kKev0V+We1XpVZW+B8yo+xNQMHA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ1PR20MB4785.namprd20.prod.outlook.com (2603:10b6:a03:45c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Thu, 28 Sep
 2023 09:39:21 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 09:39:21 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Anup Patel <apatel@ventanamicro.com>,
        Chen Wang <wangchen20@iscas.ac.cn>,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH v3 06/11] dt-bindings: timer: Add Sophgo sg2042 CLINT timer
Date:   Thu, 28 Sep 2023 17:39:17 +0800
Message-ID: <IA1PR20MB495373BAA77A74C5EEB7BE49BBC1A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230928-winter-uranium-cc07496a49e3@wendy>
References: <20230928-winter-uranium-cc07496a49e3@wendy>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [PaxYHsbg2F6f7Iggom2JRKGQol/5SVdOT1ACplAsioE=]
X-ClientProxiedBy: TYAPR01CA0035.jpnprd01.prod.outlook.com
 (2603:1096:404:28::23) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230928093917.149074-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ1PR20MB4785:EE_
X-MS-Office365-Filtering-Correlation-Id: bfadf014-0b5b-4a2a-16f0-08dbc006caee
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/s3rUu3Mho8zYM8UWCBLSWeIGR7Lj2yNqlvZ7zgPpBZav6fd64Fxl+fgRmiXAgUbwinEgj05XO8iN5SNsk13gIv9s9t8VOj+h0XfjvT2jZdI8wErpc1F2ZbhGtSyfpiiYz8q3+li3OoZAiFbZdIHK3iin7wuVvupn9rokLU5P3lNZMhC6xFaOkk6LhlNRlTCD7cA0wcfMvSdFk6d3Y++m/yQgPGbgp/E8azGlg+b3voHe9IhpI+RW8xzOl34PrN+TQ51J/kg4Y9n4bXW45jYxc1M+W+IJsY59Y9oGWv35xeIrqdvS4Ndtj4mlSd64HUArwjxQ/18PKDqkY3dlhQYeG+TtMO+Kl1cquDvtIpaWKlrSI6yA8+nS+fMqlmhy+0Ta/l95wde38PA8ZSBtrhrKoJS2bpxwHDuPkBDrrftFpUuNnNUGmrR9EoBAe2tCcQympTmnXrsPHfSB5jX7YWmpKvqgjc+DFUVmFPQdd7LVOgrEludfUECO/bvUovR3xviNf/+fbmvqXDphIwKKVbzu2X0LYr+S0BUdKEKIP9uXxjLIcF1Qnz7MKUhpVVzq1RkMGv1U4qCxg46BBQRlDuqeOfHCPVrZiBCgCE7Ol9YcA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RLzEc4aKq0mqNZszuUgddc1kD85MTROSxjqPU/7pmjwLqRw/8XfRccZrdXiH?=
 =?us-ascii?Q?opCstgK27iEaS6XL+b6XZOIv0Z65ADtMiNy+ND93/wiOOqiNZCKni6dKvM8M?=
 =?us-ascii?Q?Ef+b3iOnb/ud9t86bL4Jlv4bjLfIYYdh/q4gOTRY8ugWuWmRIG1iPT7ePKXp?=
 =?us-ascii?Q?yV4cScBYirqbeXVLuGyDvofZda6Pb6GL+Jua5LcLFZh/R4i8vUYFOjOrJgQ3?=
 =?us-ascii?Q?VPkTJwdNjRm3J/QEqPGXitS4wnm2jD9KUGdQGUrQZnL2hjM+azQbas41vKro?=
 =?us-ascii?Q?H418RKVou/S8MRdylM7Ya5ibFZacBN9NbhyQcYxOBKtzoKZTrFADo1KcFb3x?=
 =?us-ascii?Q?zig4f05rbLQg54v8U+xp3fMSfa9uuEMpqgdifBrzZEwp6ZDR8YTJ2k8NwdsQ?=
 =?us-ascii?Q?lXWUTwoLkKv51yK6DLsrHzAdM8fZp2XQF8gr41ZK0h1zyfOrALj6+lyuE9Dk?=
 =?us-ascii?Q?KhZyFX6qW6cwIM4zG71RkMh5vHEOdHZ4JE+b40FqkomgXBdehqx208x7mTlk?=
 =?us-ascii?Q?BsuFjZ+1kcmIVFbq1Paa3l07o5LwY98wbCAp0qrDBIPBplRmd0y6lSEkrm9a?=
 =?us-ascii?Q?gVPoRT1UQmczGtTEGVhtSvwL7XF1DvlqXDh1f2bWVypBM9rROpm7uAJhT4uE?=
 =?us-ascii?Q?TyRwlenoREBrsq3/OBTQPWX7MLFG+yICDPIvKLUA99rOF5YDTYS0B9K9h/4e?=
 =?us-ascii?Q?cV/jmH7CIGqT6JdVQ59+2wCDAy2j49zXerwTFDn+SXWTOg/DN5Iz2BScldsa?=
 =?us-ascii?Q?61l7/eBYMZl0eoFMdQ+upkWqPuW9h8ClEr9iDbwh5u3Ks7J8+AyNJ6XcShxr?=
 =?us-ascii?Q?Ja+0Ki8obmRFqa/IqRCiAWlN9YWL6gDXMXpEPcJH45750QYOTajgjo9pOKJc?=
 =?us-ascii?Q?f3S9NQnanQmVgZRrg/CNqW5VH03ha2St2NdKMf+OPuLsQY5r9qBDirpjr5dz?=
 =?us-ascii?Q?SeieQ4OnWNh6lsdtJZ3pCTObl6I21K6dp4tgsAx+OHtYkIs0UghoLee/OvjT?=
 =?us-ascii?Q?W9U5UpngV93ZWKHgQVOfcHCrAHn2rL3j6VdzG0lUBeySpHnFSLkyTaZeu2Or?=
 =?us-ascii?Q?fLN7YBi6xqiXK1edQfhT6NSiOWOeSihrwiJEJ8KlscAgEUfSvGzHP5Dai62x?=
 =?us-ascii?Q?xmUrZ0NrvEEq6VfEzj0fhiRzwWoeD6wh5UWM/iqHl+uZ6Vyb8PyR9mmS4CEh?=
 =?us-ascii?Q?DsMvHvDdilMsfIvriAbqyPHXrAQfH5YIBT/rKwcHTQETIuzzV3jtDEHb2R4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfadf014-0b5b-4a2a-16f0-08dbc006caee
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 09:39:21.2489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR20MB4785
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> If so, whether we should replace the "thead,c900-clint" with these separate
>>>> DT to describe the thead clint?
>>>
>>> No, since that's a different device, right?
>>>
>>
>> Yes. It seems sophgo defined these by themselves, but the T-HEAD. Sorry
>> for my mistake.
>
>I'm sorry, I don't quite understand this. Do you mean that the IP is not
>T-Head, but rather designed by Sophgo? If the IP is made by T-Head, then
>I would expect to see something like
>
>compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
>
>in the dts.
>

AFAIK, the clint IP is designed by T-HEAD, not Sophgo. Sophgo change this
IP layout to fit its weird cpu design. But in my test, the timer and mswi
of clint is compatible with the T-HEAD one. So we should treat this as
T-HEAD IP, not Sophgo?
