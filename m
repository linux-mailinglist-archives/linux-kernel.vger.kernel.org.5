Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F4B7A9604
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjIUQ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 12:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjIUQ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:56:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2016.outbound.protection.outlook.com [40.92.41.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC1513E;
        Thu, 21 Sep 2023 09:56:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuAIv+J6X+sdoN9P2zPrUCTHFrTcH1VHx3Aa+BIcLy07z7tA5b0z9BeiyZVlHXOLeBkqf+rdPDM8vBK9Ok/fjI8F7eWs/61VVVyA6GHeTMlx+b3O4nptiHdDKpU6CQR0GkJNhes+4VUM6NLWfCSD7sodArma/Y+ajl7oXYbrELidLjTi75iR8XRM2vHkFEH+jXNPxA6wA8LkBL4oClORVssmxMsvz+yg/mywdK4Nc771V4GseZUDtEiMf/qpvMiL4sLiZ7bmZg9cxLGf79vOFC2XFpsJVq34tMyjA/Na0W0LmT9Mu6TtBqngWCUHj2yKZ90x/XtQO+y3hiSsw3ToOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=le/zm9z34I0rfHXyQ2cCAN0dVBYkqw+QbRb6XQQSKTE=;
 b=HxcOrr1LWNA/c+CeFMLU0hrziQyrW34vGw67h9j49HnAx9HMbmod6BCpxoNu4Rx8Ac7EzUwuG9EoJAWHVgY7XuN0Z0bvLB5r9wCbUVUXX2YxnI5AhKhbAb/3Sy/vc09NVJgD5CtzGpEJcRPvApytUn9XM0vjP2cdmHX6+2HqtTcZ9PELugMR0hDspj/gJpK75c/JZgsN0Rvd15viI9YIC73WJBYitDElw1noHHIoo7xbmzjQ5zwHnT19wyeaR/63YpFjNySTXw+Da4losjvAAJJhxD34dnheqcWiPvJRfDTmwRHN2urcbyewv6VXV9PL6UXoBujWU+Kc200psF1Ljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=le/zm9z34I0rfHXyQ2cCAN0dVBYkqw+QbRb6XQQSKTE=;
 b=S+3wfKkHOJFSmYaCT+JU0K6QQqXXyrTMpFuXByNW28p7VEgDA1z3esoNzzNHuL4vUpuewufZjR44DdF2CyMJw5KV0gVQTWLJZ+Bgrhi922GXQjA28gpZbUJpHjSuleFWaSydGP0bipJ4eQhZl9OaVmdnyPDwznB06fAdbTNWDxk5c63XuN23+UVYN4l5F2GOLQZ0lBsCpFqZ+DSxuM9C/Hwp5LGLr8FXud1QhPjUgd38DDdCzk17Y+vbOe1rtUg3RGaiJ/+kPe+HtbRSe5Vvi17FtTGrP/Nb5h82be5zrFwhrDFH0nufq39wLUqloWanPVbSF6DtKERPjfTuDnLxUg==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by BN0PR20MB3942.namprd20.prod.outlook.com (2603:10b6:408:117::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 08:18:54 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::1138:fa92:3562:7932]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::1138:fa92:3562:7932%4]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 08:18:54 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        evicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
Date:   Thu, 21 Sep 2023 16:18:57 +0800
Message-ID: <PH7PR20MB4962478C50534722C16B17DDBBF8A@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230921-d7bab3f036e498a23eb6b578@fedora>
References: <20230921-d7bab3f036e498a23eb6b578@fedora>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [AJsJ/a61zJa9QXCL0BuVHExQlHg8k75/CqeMMnwc4sI=]
X-ClientProxiedBy: BY5PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::41) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID: <20230921081857.127551-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|BN0PR20MB3942:EE_
X-MS-Office365-Filtering-Correlation-Id: be1a518e-22b5-4a55-4766-08dbba7b650f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqRWEMg99tqiwZ59PXghTvMwgTxQFpdlIfcT6NA4ceNg2aZnGNCua+K8VW5z9V5m37Lv/Y8NCVTTHQ2NHffv4hv/vfDvvfaVNJUiMK6W3I0MiDaWhmDs3usR5gEiXmI+GXCWqhU/HG3MIk4XBwtd708leKO3FFH1EQ0r/HiEg6sW2n4Qkbnt9DpfMHqzaJuy+9zY2lQkffXQdyPPeEuvwO+xqY5KrZSDBxLpiIayfyidMzD/dyyqrTcULztSpRfX0p88i/CvQLMMKBEdH7lY+wKPltDrYkrYW5LNhGSd5t9lJovtQXiUDI+9xI1h2IzOIZYpmEjSktD6MSBQ8nl89MQS4+gAf9ZrRKPEkSXnsGsPmRzvJocaYN5r8SjCPcQjLT0mtPohA+zQtDBtC0w/y6FnAhUZbSBi0A+s6Q/EStf8gKcP81gW8/s5auN3ww+IcUWA6dlY8q9Efzn442U1elJd2cXRjVRwlIfhIipsK3grmDDdFUwnoJPoYtGvEDO4k3aXc60s8f/lT9UGxZ7pD7qwAN/50sODkUf2mJGh7FIKCZyi2UgpMj1DMvNfhsO1VsapLkoy3CC51ExGr7cLbnfL5mcrdLZKz8wimzaeTdZV56TiJpKlq1bgUHUYw+Uj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gQatIg1cekE4+gj0zi+ggWuNDk/KwGHIWOLDqCxcugz/IdQWowWHvHOCcqUO?=
 =?us-ascii?Q?wR9PyXa2QqKtfMVdaxhtPExwMmBjaFbHJnJII5tXQHiso25N53zA3QeuwnwW?=
 =?us-ascii?Q?euOt2W36IiZJZJy+sjyRH/yQRrgnPibkQnS1YMGIMihDKFNSbgEJeTXPHXNq?=
 =?us-ascii?Q?RfJHfuBPPYm/lQf1Xzp35YN4H5TpVXxwapPw1JM87UDDi3lXAQSsku2ayjrp?=
 =?us-ascii?Q?YopMfn3zAV+7FOiIKzmYDtuAVaXSjVMl2vttyW4lO652+UPJOBaqxo5SFdQp?=
 =?us-ascii?Q?LOEFcdzeeotuLTZiXWTPogzCO7yUO3Z49a3d7p3aZnSQruqnfgWE7PAdex4y?=
 =?us-ascii?Q?YjnRhlpptQuWE2p/WSIPbwICUk/yVNZDQK3fipNBBx6n+Y04X8JZPJkPOYU2?=
 =?us-ascii?Q?Vm5PAjAFJJeBYnPXkr7Jw3XbGdEmj17i3MmUHwoROZ+VmZAZlISbc0C1E+dV?=
 =?us-ascii?Q?x1R4rjnTCvO+Uw1GdUllwIua5cYguBbitSu9L5NbLfgkP9PNRbEzLU7xjirx?=
 =?us-ascii?Q?At/mI2N0Fs6rCSb6vwo7hOtH/pdG8NM9Col8n4xBYtOd1a6q154HkHfg0lBF?=
 =?us-ascii?Q?X+O3gtXWTxOQ2jGUf/lR3EZewTlJqjCJdNLIvs7qzWLie0MQYp0wH+xbupp3?=
 =?us-ascii?Q?JL/LzTS+Ri6UICcNiOUA6BWIxrYTPjD2mRoC8Js5VjmMg5Ha3hnRcEbMwZpf?=
 =?us-ascii?Q?dy6uQdhd9MI5AN1+cflW0XeVDzN6yeNnOTpey2oMYMlEoUHrZNrX1/X3MfJI?=
 =?us-ascii?Q?79zgLXERI+/VrEIqTBIl46+SpRup+McwKVeNmRbRCzFpjNkOi7mhmVCeLDtE?=
 =?us-ascii?Q?yWMNFzzHJADzt4aSenDCYWqT7pssCz1qg9Oh9GDy4fUCkRybelewgOcIV55O?=
 =?us-ascii?Q?Hsfgw/wmKv2nd47OQFD0Mk1GxzPRsMQzqd6F+C1dBrPG1jYWY/ug7PqgObPf?=
 =?us-ascii?Q?s0MB4iS1pkP8jK5gNmG0NiTks1IvBMyElhevbClv0IQkQOJU9AMFmUTllob6?=
 =?us-ascii?Q?cIvW51eFXLz5PpEREK6suFqio9xJtE9J3b61cumWOtdh4a9qdIuhoRkuyvs4?=
 =?us-ascii?Q?XYIeIs0lj4bIPbu9h7FCvgDOmpIPK4WmyWcICeIO3ux8riHZROJmUFHQNQfy?=
 =?us-ascii?Q?Zjn6IrEhRxhxs/AEcorc01oXr2ia5/dvg8unpXbRH/LwCxefKKqgEc0fmozO?=
 =?us-ascii?Q?xixqC5Afu6tnqjuXpgkwCIi46no+QjRLmcnyPRL67Xwj09+qWxCARFNtGp4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1a518e-22b5-4a55-4766-08dbba7b650f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 08:18:54.5705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR20MB3942
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Thu, Sep 21, 2023 at 08:43:47AM +0800, Inochi Amaoto wrote:
>
>>>>>> but not one. In another word, there is no need to defined mtimer and ipi
>>>>>> device on the same base address.
>>>>>
>>>>> There's also no need to have two compatibles for the same interrupt
>>>>> controller, so I do not get this reasoning. What actually _requires_
>>>>> them to be split?
>>>>>
>>>>
>>>> Yes, it is one, but can be mapped into different address. So I think we
>>>> need two.
>>>
>>> Not two compatibles though, just two memory addresses that you need to
>>> locate (or maybe even 3, for SSWI?)
>>>
>>
>> We may need four (mtime, mtimecmp, mswi, sswi) if use register range.
>
>Why would you need 4? The first two certainly could be individual
>reg entries, no?
>

After reading the aclint doc again, I found the all of them can be mapped
on the different address. (See the section 2.1 in that doc). But for now,
the mtime and mtimecmp have the same base address in any platform. Anyway,
the frozen spec in future will decided how many ranges we need.

>> Anyway, I will use a vendor spec implementation as a temporary solution.
>> I hope this will be corrected in a predictable future, and we can use a
>> standard way to resolve this at that time. :)
>
>If the spec doesn't get frozen, there'll not be a standard way merged.
>Hopefully not too many others go off an implement non-frozen specs, and
>we will not really need to worry all that much about it.
>
>Cheers,
>Conor.
>
