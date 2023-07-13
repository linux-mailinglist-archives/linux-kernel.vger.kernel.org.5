Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BEA7525AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjGMOzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjGMOy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:54:59 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D3219B;
        Thu, 13 Jul 2023 07:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAILiozkOWAmMW/cIU+s+RwIPslaxsgiQBU0vhFEmshDX2g5Q737LR9M2e6jRITqZsQqP2j4vgJcqq12/zlA/a024XNpl4tM246825tyZUimkbyguxaGMJs5Pk1A5M6wv5sW8k5zAuvEdvE0/N3AUkv/6DeoLlCgmzDJucIu62q6dvQmcqtJ6tDgcj8G1yIuPAFlrjCItbNSAHSmxEbxFo1l99hmi2Prhgzy0tdbsCYeWki5/6rBFL77zEkv9cMKJnUGuakvLYJGdLefi9Xijuedf61Tsp0cPBGBKC8IW5AkMQs6NETsTXR8DP4TU1uP/Khau2UfDISr2lQxpZ5eBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6aQV9suVJpL82kmoOKXGFdMItUDlKF48mO/TN0aJR4=;
 b=mX/wfhEUCUF+MWWTdovxfXUt1DyZvSfALbzwpIDeXbTgExZh2O+9HJvuKFBwivSBhSbC5iFiBFkRMowuoutOwjCMxHmy8lsr7hZlA1gE/WHdwM+KhOqIG56SkrMlSVYAAo3gf5taS6MgF7hZZjI3IQllRDwSh80QtqSxBNZcGEuTCkXoBJPbpSltxL5zJYOAIQlxSjIDyAVFfvMR4YcJGSZxMrABzjDUj4Yi4sR5fE0QCQyegfkUUikbhOf2p+czFdjUmyRClSxqRT7jq6QIWJJBBlPuuXlnZ7FiruUzIvW+ZevjOQkTDAuYc3zYdmapuhat38z2V8FZKVB3lJtzgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6aQV9suVJpL82kmoOKXGFdMItUDlKF48mO/TN0aJR4=;
 b=ddzUfYQ2WHndusbE82LTHqT+HL1z6lezhRVzjlvkYumw8iy16DHCsubpIH+BgD5LS8mAha14QQr0DSomK9bqD6DPEgLgMD3NaZ+JdsFhjmfhvgb57y/GMoNS8Q2HqFvMowOj5yx4S8PiY5/lT6JBfEWxKfn7O7EKv9Rehtowcn+MlL8PLH6wmKUEFM/vcOWLsE7361HJtYUjtCvnbfiMFKeCy53w61Z6/mKV0lHXNMWTyTSvjWiqcOO6K+vY9JMRH+5IXrKSPWaEjM8CJT4LVz68PJVnt1HZoqxfDq8/0mDMHa0blPS/5KnoZ2BpPgmLGGywsN34G/2jZyPxbm+ARw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PAWPR10MB7125.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Thu, 13 Jul
 2023 14:54:55 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 14:54:54 +0000
Date:   Thu, 13 Jul 2023 16:54:44 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH v2 0/3] platform/x86: simatic-ipc: add another model and
 hwmon module loading
Message-ID: <20230713165444.1ee67557@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230713144832.26473-1-henning.schild@siemens.com>
References: <20230713144832.26473-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:610:b2::11) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|PAWPR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: cef8043f-9657-4443-0f6b-08db83b11e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdGzX5QutZz5zrO2aExcLQpBcFJd7pTtKvI041sLWeYqjUf92DAngWwya8ciu4Whrc4RsaUW7Vo4DcA75oOv9KdmN9Jeoy4a6KCacu4aNgEBxUPUP4f1HIg4oeLFzH7ih+KR6G++yP8hI5YcNJPW/FfUv5H1RKgzmeIyi8vBKdFEPPb5YJrZk6iW54a17m4sZehWtN1ZMD8XR9wCQ3UTiBLyXObdOg8IukeAuUcnafEqAl2jIMmy1ftmIvXL233EQq+SF6qTUlSYl5Ghg/VrCT21sF6kmdFJ7rHo0NAHQYfqfTdUA8oi7pnCFJChhBo5Dwax6TYeo67Gw5zsn04UKjxSZr4M7ND14ocse/FzszBCTNG7Ah797+cfVW0cHsZYmraSsENERjUXYzbqUmpNi+DxKmltpnky4BEFZnVwrMX6Ai5Tz/o5jX6aYyzEw61vNtpx7+UpSU49+lcjmRIFV2gtikFlqBw877ufwf19LqbXfTg/hscAAPC7GLBS3Pm3UugqlElRTE928ijnJF2mMJ5LUCnft+QXQWHUlVo7vXu2jKsmdPJVJDQcWLIMoVHe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199021)(83380400001)(2906002)(86362001)(38100700002)(82960400001)(41300700001)(4326008)(316002)(6486002)(6512007)(5660300002)(107886003)(478600001)(8676002)(8936002)(66476007)(54906003)(6666004)(66946007)(66556008)(110136005)(44832011)(1076003)(186003)(6506007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Stm/eDk9XuGf1cALQRPpkg2aQBQsIeIj59p3IaKgJApQbWYY+/fRoU049Ebm?=
 =?us-ascii?Q?ryOBhGRE0gRiWMkGEZle5SJuF27TmeltGDGBQd4naSWUxnqUB+YYEX5tWxeL?=
 =?us-ascii?Q?8cMv4zCUlVTnKJg9lAzl0Neb2GYx5irhXtd0VEI2/U6Af/mDT+fz0X62qh+w?=
 =?us-ascii?Q?dmQxQjeeadnfywTStWQMAv4972n4LFg2BeZkTbCftBDHhpxzejvCEqDsC9jf?=
 =?us-ascii?Q?EWGjDNBhBRRxmNAIc8hXht+CBud0w9Ypj1l2htkmz4PR0iE8HJ+AR7uhKkBK?=
 =?us-ascii?Q?XI1FH15np+hUxzglWzkiirRmGj94vOPMS09i4yE/Xqss3R/FUIfYTRSjfUAl?=
 =?us-ascii?Q?eTZ2RTnuFCZEoHhbC/GZbgNYaruAPC/8dR8wJyYpLg6QEyz/Mk9Gn6zE7oEr?=
 =?us-ascii?Q?mP8s8cbD/50cE8zSTP6JCJrBlCgGaIm4sBCL9b7I7Ofv6IXemkfM4Utf+wsO?=
 =?us-ascii?Q?zfxZhYt1i2hF5AvGCG7j0CNmjL+QUj5LqGXspfBJeJoNxXWhUt4iZEbMw3M2?=
 =?us-ascii?Q?zQwMEkm0qGJzolUtn22j4b1pql4IiJo/JeBCzF1Zpn84+joxkjiVdVWVE2wa?=
 =?us-ascii?Q?HDMKItN5CHkFz4bn/yQhMgCGZZF8vmu+Mm0P18tXIuoTdAeEKpJeXAEF8uNZ?=
 =?us-ascii?Q?mP2Lulf1aIRedTB03jrTXh6RARaCokeYir4GNnfup5tG53v2OUqTeuMevAtN?=
 =?us-ascii?Q?tIM7JsFLCM2FUsTyw41/eR1hcjJwM3cS5E0utpsqc4Z+JX4novvAuH7KbsHk?=
 =?us-ascii?Q?ILNC185k8t90GwU+GNu93eYuWu6vBlS1Pj4KunCYkJXR/zbjrE+dGAhVZXdk?=
 =?us-ascii?Q?dkS5XF/CHF4KSpHMbI40HyNciZlsvz3odk4z7RO42bQPE/IpOtRua6XEFnYd?=
 =?us-ascii?Q?LzcFfXH0dfyQyDwp7TSTi+Rb1lvjrb7kBRypoBLLs1bI+KR2xgMANfJb2OIr?=
 =?us-ascii?Q?TnZa5J1x0A2uYsSUywOL97+eychk+6cQORHgUA4/hjsDZs5+09xzN/y6uKNE?=
 =?us-ascii?Q?ynrX4KbvvuOV0uxF9vx8MlOwHFKThcfcUphth/+RFOWIicWQcGckKdUYLJ6Y?=
 =?us-ascii?Q?dHnGMMJk8C8zvRcBYHg4Sg5zXsERK1PkC3AkLsaYMX/sj86K0A3uHySSa8+P?=
 =?us-ascii?Q?adGF6puHvIWrx8n/Ghc88KuIyNHF4jytrqQ7PQEc1ML7oY6tBd76IHGraQ9c?=
 =?us-ascii?Q?Ba6+rOoi1Ne2UdvMDIIz2Liu48Wx52jH+mdLKMJ0Gx0eHk6waQoziUnD1WQq?=
 =?us-ascii?Q?8LTg0x3wIwz1Ozhn1YGhtTDsn9XzCi1P/elTVrJjlU5oyD7y/ByxgmqfFan4?=
 =?us-ascii?Q?j1z7FSQ5SI77yGv82RsJuL+gcCMnBCXAodBHl/ch4ZId55rXNdY9a5RaEzeS?=
 =?us-ascii?Q?fW6wqs2wxbKv4y/GbMwkpKI77L/AqQRGWcQoJ5zZBstdqI+3NoauHKchcgJM?=
 =?us-ascii?Q?nH9lURl5C2W0SpOehSuRt0x8VZK5YloSZZqiOniSwmxX47bbfwwk52hkXN8/?=
 =?us-ascii?Q?A+C+wqub3g6dR155FLS8t5N/8Sot8t4g/FJUIGf1KWIjZO+HMQzYsF5dnGfO?=
 =?us-ascii?Q?9Gzmmwj2fpOBLlcP3lhj79YiMWot5VcvfXlOFxPjSL0v+vcsTkwyyCC+v+Qx?=
 =?us-ascii?Q?AAkn0ofDWx9lzBIrxVFW8H0sWqV7KLaV0bz1dOceAxNtlUHiUNOzb/wP3gOY?=
 =?us-ascii?Q?uYXSXA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef8043f-9657-4443-0f6b-08db83b11e67
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 14:54:54.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtyQm0beObV4QwXB7CHhwbrr+ryDN7To4yOlNsF32UFnISZosm3ZelPsXV6+YCz60lIurMiLrkjr9C5p4Id32a3ChKduvlJ8xcbpcaC6MEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7125
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 13 Jul 2023 16:48:29 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> cahnged since v1:
>  - switch to using a list of modules per device
>  - add p3 and make the watchdog module load code use what p2 created
> 
> The first patch just adds a device that is pretty similar to another
> one we already had here.
> 
> The second patch loads modules for hwmon support, should they be
> available. That will save users the need to detect and manually load
> those modules after a machine has been clearly identified by its
> Siemens Simatic IPC station id.
> 
> And finally p3 changes another request_module call to use the
> mechanism introduced in p2.

Note that this is based on

 [PATCH 0/2] platform/x86: add CMOS battery monitoring for simatic IPCs

which is based on

 [PATCH v2 1/2] platform/x86: simatic-ipc: add another model BX-21A

Henning

> Henning Schild (3):
>   platform/x86: simatic-ipc: add another model
>   platform/x86: simatic-ipc: add auto-loading of hwmon modules
>   platform/x86: simatic-ipc: use extra module loading for watchdog
> 
>  drivers/platform/x86/simatic-ipc.c            | 74
> ++++++++++++++----- include/linux/platform_data/x86/simatic-ipc.h |
> 1 + 2 files changed, 57 insertions(+), 18 deletions(-)
> 

