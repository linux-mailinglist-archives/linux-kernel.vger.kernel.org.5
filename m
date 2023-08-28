Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F54E78A62C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjH1G7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjH1G6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:58:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2085.outbound.protection.outlook.com [40.92.41.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD479E;
        Sun, 27 Aug 2023 23:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iV62ezMxa43yV6okziQyoPrsOndsonzwAEfP4D8SfBwePLtcF+D0Q8NJUaeqqpzH2yC+nb7k6PRoo+3tAlEi42Qf8CdisuIDVxNvHt5SeSQhK5BrdURituEfpf9HK+yzxqzzebKgDJWsQPOBV0IPN+dbcTuDBFkFAXZswBiNvmmpkDUeKRqvaw0VckmjcxTe+sHXvB1LJM0kCR3zoxk0RGIFuXWnLE+4+vm9WluT4q51JDhxKUOv5T2xAH5WlAByL/KX5O7XEA8rj74FsxGNftWpHCaDVKnj0wFZtBKrphOBNIS8J/P+V2HLLa3PQnWDSkJh25qku0jg8TwIYAT+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FVHtqkBHzIlIKUa3DuF+TkQXUSOeuxbJuRTtXXZDSI=;
 b=CQorUyJ93gJfTV9ZiUKb+ReBK+8SuTg6aTVf4drdzQalyJGGN6fcHI4gXyEIQImFBHHlmz9L9JKQQU+/gyZIixK3+BEexJHJRqCyQPvEwSAekAthaLUVNpU/WdYhBPK6uVPsdC4YeD8a+Vm6hNs1hbNy4WKRG64DDypbhzauflMcZX5vBDG7wxeuo1Oo6fQUssncEohJh5r9nWOU3bbfgFvcVakJHFlRTIE/JbckXCX7Pe+CzQiaPq6byJJV16Jzlc51yBV9QhX3c95/LA0sakmXHc3PrMKggETS7aeApQdpLs/uYd7ns5cqWaqftNzdfTkjHaPIH5Iri0HPyLxkjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FVHtqkBHzIlIKUa3DuF+TkQXUSOeuxbJuRTtXXZDSI=;
 b=nJE+MuQ+p2GDba9ugUWO2btZpW0gj8uDgLlu0ZaNhyaB7BTkfoRyhGOqEQ6M1VvpjzE9czU3mCCk3h+czfPf1kpPjSpoqhY7B53kQhS1mZUtZNFD0wcUXM/ssLiZ8reFmmoHCF2owXMUtSOm9DsoMnYflM8JDlLL0bwo14bWXXAOUHPrDgBzqG8R8ijv6KfxycopApCag1icfxy7f+RJRjrUVJaVPjvy/DPVdxui54uX6La8T0/D0tbYkoo3xQpgFEhcnzq2wwVuol05IGM2BHXI/8UGfE6SmnTxpduzRP+z+xO/a4W+ADhkoJPbc39anIcFUMWwvXgQynRDPp10mg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN2PR20MB3286.namprd20.prod.outlook.com (2603:10b6:208:261::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 06:58:25 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 06:58:25 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>,
        Heiko Stuebner <heiko@sntech.de>, Wei Fu <wefu@redhat.com>,
        Pei Chen <cp0613@linux.alibaba.com>,
        Wenhan Chen <chenwenhan.cwh@alibaba-inc.com>,
        Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] riscv: dts: allwinner: d1: Add PMU event node
Date:   Mon, 28 Aug 2023 14:59:11 +0800
Message-ID: <IA1PR20MB495363989FE43EB1FFBF8730BBE0A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <d3c9e032-e20f-97e1-2d08-9bd87691d43c@linaro.org>
References: <d3c9e032-e20f-97e1-2d08-9bd87691d43c@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ttbY3DnjeA1YYlOihILjSeKrknmd8iCxTHjGZ80jbX4=]
X-ClientProxiedBy: TYBP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::27) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230828065911.293188-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN2PR20MB3286:EE_
X-MS-Office365-Filtering-Correlation-Id: 108adec9-5bae-4fac-ed67-08dba7942d1b
X-MS-Exchange-SLBlob-MailProps: Om8TgR6f4EA/I6Ph3LQop9pKneXMeAsHMmyRjz4iCzMxziTXWkA3b2h38ss/zBpNuGFZtJOxr9K0R2cn26z2pco8YuHihzcjiZ/+jyFtcfJx/1jfqZXZHoZBt2oeP++mYhsF+KXIOtFJd0ktWy7EwXhjn3YsORGjseMmgJ12Phd71GBrDs/ZQQnfKj0u3B42RoDx5cLtmCY2N5dlQUo4PDIUrPw1Lo5tUzAh+7wx+8hUBoy69vo3KjzItzcGWpTvqUjXMF0lfJ3fvS8hnZi2SNHGiIuwhjqfN25yJR8GyQtL8P2uxxYponiDEdchTdEXy6l7GXuw1bTFsh8QfSyn3Nxh2EuusnCZF9yRhkGAnXynq8SvifLb67/Ocoxg9C6D0FeYyfEvgMFB2YAcB6HKZxn1sqBvsStCllT4b/xwB4PbbjeNuXrxDUIMJ/i93DoGTdn6AB1GvMTmHWgSCFgBrLmx2/oOSXfclakEAnzKlg2ja35HdKR1B2c2659he+Ksv7/V4lgWnV8XYttZMdtCONoBltq3r53mreBKDBLcYsuw+8ix7lQoDueJEisgdUQlVznFWJK1C0bQap4quC9SWo7Bw7atVp/Bm29rY1QAE6TScwjOkRjKRgym7lguvKpAuFfbwPOSihbye3W5pNsoMwlNZpsOZQsdjKPrg/hdhXHTHkMMcEgvb4kz3AGjuNOFNk4rrFqLOdtWNxOMmeushC3uj+apULyJ4vBp8ty3qslLVy2oKnEc+MUhsT5/hYNmbiRHwQ1lk4IA4ft8rlkft2oIE8uWVGcTO0TZFc5mT0JMavnVW5gbFX2Cm/Vs2tux5k4AmwCdbFospqDJ7feCKVUqNy2Z3lHx
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCkuEMcffF6+CNW49w3rVDICYE8ysudolDWiVKKkYBFPjOuwa9egCVV5O/SkA+ue5Um78Wpo2zKtMdRSIvyY9eup5ohNA1MglOcefBAhsfnH5EFSEb5Gh2EG2srlA0QGCQE5aWPDFrBg5QASpcBiJMHnXIdwCwb1K+cQO3WDYtbA6JLSyX4ItOc3Js0RT5cJqhFvp0nPQltEkfQVIAlQZcl6bF73z0P/xNPxyGXP8LAb43r5XkO9Bb9IyR9QjpxDpAXiY9FxRcC59CGWB+QLpyMyaBJT6VRlxS0PZecPwXMO3bihA11smJjH2h546/LbWf5mVrBPvzm6KlD2TecTWHOanu30aVcpkGk9ecRkB49eK8/KA7rNq/fDAE7lyCp+BBOanDBfqiqIPT4v2GjtoK75opeFZZP2y3FY8shT1YUFmFFBtezBRn2oahmvDIiEFPYTNS1o3jyoMtvjlMXtjxSbwQPeM1GpmLwYc4WeWptRtVu7byaZYLOjyC0MzuwT1KylBag6U8f0ht+GgqHh8L82YhxIsvwoY9iRrQJaRvMLhJa0hFUQgcpB9XaknT5sQ7E5Bag3Y9pCFZ/9pzQYhREUjWyBB7aqtrNyJbq4vRA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q86PUECD/G4wgsdhzD/Dl0Z7jbyttsnfMNE9epwStbfsYbwvRUM7O1teN2pk?=
 =?us-ascii?Q?JBmaeCsq5t8JF2UptLmCq1CzRmXfyGE8fx50EH4jTc6/TucqklfFQUm4mO92?=
 =?us-ascii?Q?qRPmhvDB0zoKwNX+KblGs20s0UCYeSv0Y6+MoVOEpvHVq4r/jcgd5pPc44oj?=
 =?us-ascii?Q?lpcOKCQ2r3W90Ld0dn2SCW2RYBGFZEsMQM8clgrFngXe37KdP6h1f5gDFm22?=
 =?us-ascii?Q?YHilOy3CJTejnhv2Ox+2uM6pLW1F7+0LpcaGjlqYzzM+jaDlKCbqBYJLf/dD?=
 =?us-ascii?Q?8AJN97K1U7nUFpOfOT9pjexZ0+NPV9uoEr++1A5CyAE3Nl2668ofnzPrSfg7?=
 =?us-ascii?Q?f/mVaavsvRTb5WZe55h3ctBu5HzCFdVALRmWpQa4MOM6NfOxDEVxNZcyc+f6?=
 =?us-ascii?Q?PkkSqGGuv5hTQOLbcix8jTjAbzYgpbHa5/L+DfxCafwy2dSDeJ6aOYwA/v36?=
 =?us-ascii?Q?UW8nCWCkn/1cSE+Femeb7mHU4aAtLFuirJFRrJlo7v7HscUDVCguwafyhbL0?=
 =?us-ascii?Q?uVTft9ITORDAoY2Dwg68OmWvm0T3uIjSZ4PzVMU2ni27lrngiFpBBIsV9LG8?=
 =?us-ascii?Q?w2rGpfdVxYkGi1DXCtik0VdlYKhQhdTM12VBzEHUgG56CbkgK09VvP6c8bPm?=
 =?us-ascii?Q?SAWYIJ2XiOvmHKzcH8yH2VOaDeAMVICioxFtAMD+SzCKM++vgOeYpK7WmW54?=
 =?us-ascii?Q?pCuBiOsLCmDdEWM37PkaZL/uSByMbX+EoK4cPeqjOrpAKX6ioO62LZMPfURS?=
 =?us-ascii?Q?kVo3BfZWDtAXoq04AsEF0owve8GgJfKjsPzv+NHFx9PAsRN2uRGF5wO9lPXw?=
 =?us-ascii?Q?Ik5kNAOgDdiv8YCRMSufwUd1Xvoa5cgN5yFIXcXTigKJB92ico1MRaepSTdL?=
 =?us-ascii?Q?D+RHaMwc9iFp05s3OvJNnbpe+tNBJMDyCTlRgstl+W7pfsV8QnRfMopG/y0Y?=
 =?us-ascii?Q?GDr18pwCkt/1QAHminNctX5nmQPwHGWnnX75KckR16pJVTOCtAww8T02/t07?=
 =?us-ascii?Q?Bo2JOyBz4rgc1Si8x5hVwWCzZN4HmovJZYjbwchM/xRpYSKHwo8z76cgDjvr?=
 =?us-ascii?Q?VhVDVeNPh0CoPA2KXnx03Lx9Knkw41vfeA6MEUSJni5SPzRdOHYNv0nO10RZ?=
 =?us-ascii?Q?0wwl9GAQX9PxR6XvgBTK5oMnzG7QJY3sPed1mH/O9MnBlPjlNxBqss/JtFvw?=
 =?us-ascii?Q?bAfMGB3P7bcqPqE1kzBPu+R6tjric6ePfzCZrk5XeMzsVPDuIggKdx28FLQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108adec9-5bae-4fac-ed67-08dba7942d1b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 06:58:25.9168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR20MB3286
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 28/08/2023 08:41, Inochi Amaoto wrote:
>>> On Mon, Aug 28, 2023 at 12:30:22PM +0800, Inochi Amaoto wrote:
>>>> D1 has several pmu events supported by opensbi.
>>>> These events can be used by perf for profiling.
>>>>
>>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>>> Link: https://dl.linux-sunxi.org/D1/Xuantie_C906_R1S0_User_Manual.pdf
>>>> Link: https://github.com/T-head-Semi/openc906/blob/main/C906_RTL_FACTORY/gen_rtl/pmu/rtl/aq_hpcp_top.v#L657
>>>> ---
>>>> changed from v3:
>>>> 1. remove wrong event mapping of 0x0000a
>>>> 2. add reference url of c906 events implementation (D1 only support events
>>>> described in R1S0 user manual, but event mapping is the same)
>>>
>>> Why'd you drop my ack? There's nothing here that'd invalidate it AFAICT.
>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> Thanks,
>>> Conor.
>>
>> Sorry for this, I am not sure whether to preserve the ack.
>> Thank you for your ack again, and I will reserve this if no big change
>> happens.
>
>https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
>
>Best regards,
>Krzysztof
>

Thanks. I will take care of this.
