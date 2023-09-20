Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35B77A80E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbjITMkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbjITMkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:40:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2093.outbound.protection.outlook.com [40.92.19.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442D38F;
        Wed, 20 Sep 2023 05:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Se1Lm/jMvTI2o50ISjfWdNIINrxvh5y+zHGjhfkEH/aEMPjXK/sKna5VPfTOi+FRGQ1xoUtBIYvR5/VCXxJfE8ek+diB1tCy2tBVZdx8Se5MAN2pWApNiRsRK67WSf/HvJM8PtYZghFqNr01SZ1PcAUerZ61UydIZ5ShCB9Ci56nQmUlvYPyGqdYbncQ9h7y8UrYGzC+Qz7PDhi5H0qdqzW7KcAbHkS7dH5XEVzo9Vey326tWW99+fSg3rF/krCBWrekB5Z9h+YH6RUlxwn/ngn8KLNoDlpY707IV8RAEwp7xgbTArQSH82S+3T5AQO5ZKGTlZm1RYLooA6JKU0hBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIsqo+XA6IjhVishFwl6bRrjZLsgFpgu72rV/maQ800=;
 b=c2bYysoM2eVOSk+M0rsSxH1Q1vHzLzpR/6qUrdLMphHjFpZueRRuEUI/SiVu/aMRXvSpSERfSeeV3xpPPEfn1KBIwToATTzeSD/qRZh4ljiGa2ljP6EfufPScgvEsB2aMOKLI2yJ24mVAIZYNcbzTTmv4NlvaTZ0l7klr0UCOPoRSjrSTmnfDprbSXd6kYXEiKLJr+hUgJ5jqanyqIXFpMe7rqfT+Z8Tn0nD8XBtkcYHzJ1IJ0eZbunW4g1C384XZ1YRob6UG8eIs3fS4SmWsNXiDBNem1JoV+o3osU6fc144ZxW+25tm9WIz7Iy2bWfnJ6ujjsGXXnKHk0qZdFqsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIsqo+XA6IjhVishFwl6bRrjZLsgFpgu72rV/maQ800=;
 b=XTdh4Fr5bc+P1gOLfjrUeOaXn5O+VTc3rz7VmT+amEXjT0qBEQ4lUo7ZHQY2j4lTCghiTBi0U34lMuSxCJ8NZXoZNCIRhGyZ4+ow5+rZxRhzuIAwKdE90cBLYnYjgM2axuiyAigYjoNYtVbyXUPrucesZqYvUJUjeBHyCzDALFPjqQQC+LkRXdMJpHR02ZA+ibVNCAlu9TVBXRdpWShEeh2RZNks2yj4Zilzs+oGSy8L4HFP2navoiGcxKNPXquYCoVsFP5AHU6cRWCp03SHsQ43Dcxeg6vkJbXL+YmLM5bG9mqhNDEPEc1ODgbjN3vELrmYjfd7DYkQVIaZU3E/Jg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA1PR20MB6270.namprd20.prod.outlook.com (2603:10b6:208:3ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Wed, 20 Sep
 2023 12:40:32 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 12:40:32 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        evicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
Date:   Wed, 20 Sep 2023 20:40:07 +0800
Message-ID: <IA1PR20MB49536BFE1254ADEE0E795A26BBF9A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <66b988f0-39fc-2ed3-8f38-151d6a3c9e52@linaro.org>
References: <66b988f0-39fc-2ed3-8f38-151d6a3c9e52@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [fAQusCy4zV8xnIj5aAb8ga9Y/1a4Hnk4E48hniRYXRM=]
X-ClientProxiedBy: TYBP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::25) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230920124007.204314-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA1PR20MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 21aa47f7-a0fd-432b-64aa-08dbb9d6c737
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DHFQIhLM3O3ZafbqZSBSv5A4jJ4+pcMeW9G82Xc1Lv3J5yZ75ErDGr2K7YPr3kFDyFiCiMX5fVF88P32GArnUXl6aFmdWLxlj/jq0UYUvmzzIki0aANuuhICoRy+dBOIKJz70o+JGr1fRjJ5fT3yq9qXJKYnCCvmaXg88UjXHUj2UcuV7+uBdEOf2+9uDUsklMW2h5sLrx5AWiMjX4q+J8HTD3Vm7UXHnYz6WZMKYTyC5UhVeFoTsbklVANhQAp71sM/YZ9e9wB2QqNJtzf6cA6m1juk7ATzDj9dO39u/Bzjmk4ubDqUoJb0oev4IXZVHvJLk5625bYhlkDlWZyMvBpGT8840wrJnTnvMxdt4hoK8DFBv09c+GOd43Qd7I4x5eOtRB3nCOKcTPMTiB3oyT3xKRorOpHLq5a3V3R71yKDg49P28/IKm584ZAfXIE6hZMMpNAIEyrpsBcQCOnOUjhD4oYwXL2DYXAycPQE9wfLwTzBHvfGpcP7CraPenEHYyPkj7UPaXunvKQkGflKsA9LtLH1W028zNeGYmRQj3zAPt1ZVIsepgurMOtNUKH09AjM4ETL9HEUWmUlsME2xhrHVk3IpqNkbW11IxWuu7Gk166Ovt4F13pl/Q18QOJ8
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6HZy0fOQ5CFnARlgxbLCEiC9c/3VDqdxydyQQYR1pr57NYkVD+658DaBzETf?=
 =?us-ascii?Q?EBIqK12O35KT/Bw2wbmNNqZ66zDEgPDJuwjKYQaHBHVjrSHKt6zqSeU2Mxie?=
 =?us-ascii?Q?7SgeQ0ki6PodZth9JBEq80n059z2XbRpknWKffrvRDBksTqGG2Zq9a0lu1Wn?=
 =?us-ascii?Q?psMqVtvwQ1jsBBDicSWNa6QEm7CD5ACqytBePiGJFXntpM7ahecd1A0C10/3?=
 =?us-ascii?Q?UTrPT3z+LWR79xD32ZU579joxlQUUUsxQXl4uF2rO0Kx9x10ktxsehlPnCJu?=
 =?us-ascii?Q?7fgXkPD4jDajNrmQ/LXxPKY9xjWT07moDlCZr7sC9V2toRtm9gaEiCUrBiHG?=
 =?us-ascii?Q?s8E+XzQfVkP4uh7hU1gMYI9fgjw8XOfq5vxWxXY2KS9+AOkoglLhv/ugn3Ox?=
 =?us-ascii?Q?QG0qAQAX00+gyZfwzRg1VDsVVUTVi1DCICOjAUQP9MOJS8FtCjUFZuXDZuT0?=
 =?us-ascii?Q?9iv3tRVE7Qxzc26JhfvyLS20nYyEXgZ7DQadltBF6ImW5a6LTVYkJ87hXTeg?=
 =?us-ascii?Q?HxaAFjk4debISB9Hr8CCHtgY7MhL5oBa+jrnOgc+ASQ2rNCXl+ZBuWGXzMc7?=
 =?us-ascii?Q?afPHRSWssEXZMPkWMOd1F1a7rD+ldrYL3BLA2h0GRkyq4R4htuFz4b79bRTj?=
 =?us-ascii?Q?F8qLzSVZQBs/6vKtlGFlhu/B5OFeO0pSqrf1ouFslVKbxHHzE2FSuLisbv7d?=
 =?us-ascii?Q?U0jZ3Oj9zRx+GfJQlFYeNOXKZKFMPAiehAYwnbYV5QEUsJ3kTALS0VmHkQHF?=
 =?us-ascii?Q?GNAMPDgOnn/sESEpH1fbcu4DzmVBFJWnw4EXXMS/D3EW+tcBnfOqqFbq61de?=
 =?us-ascii?Q?qSWAXhnIpLsgrKsvWZfM1HZHAjHjLHk7NBgqpYxomhJG8UdYdKRjQSH3YOjP?=
 =?us-ascii?Q?l+m2iXY3oQq7+JDimMOdzExlcNY0xnXAm9hhsto0H+kFO5+mXLn6ebk4E1hj?=
 =?us-ascii?Q?7v2FVy+Qc3xheEr7sFh+n6j7ODpvXkWAhWatxiOLssb12EyP2WJgCIXwfuzQ?=
 =?us-ascii?Q?YGCktV1bdWvHskqRntFZxYCdxl6wPbJ00ZMbqpr0NeKz6+uNkMTVT/1QhQva?=
 =?us-ascii?Q?0I6KL7YEKyyttF1OAaTCucdLVL3CuDRXKubxAwvQyZLceLMLxEQtBtO1HwTJ?=
 =?us-ascii?Q?bGctAcWn8kzpVUYvwDz9I1Iyt4YlKMNcb1x/yzpgwBNdxwI9SnIk8+vaGulQ?=
 =?us-ascii?Q?dVr6iN3R/A67i6UkCKWEgkIwAIVTKEV/0WO974T1tXwowbXEZMV6yu6C5uo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21aa47f7-a0fd-432b-64aa-08dbb9d6c737
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 12:40:32.2354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB6270
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 20/09/2023 14:15, Inochi Amaoto wrote:
>>> On 20/09/2023 08:39, Chen Wang wrote:
>>>> From: Inochi Amaoto <inochiama@outlook.com>
>>>>
>>>> Add two new compatible string formatted like `C9xx-clint-xxx` to identify
>>>> the timer and ipi device separately, and do not allow c900-clint as the
>>>
>>> Why?
>>>
>>
>> If use the same compatible, SBI will process this twice in both ipi and
>> timer, use different compatible will allow SBI to treat these as different.
>> AFAIK, the aclint in SBI use the same concepts, which make hard to use the
>> second register range. I have explained in another response.
>
>What is a SBI? Linux driver? If so, why some intermediate Linux driver
>choice should affect bindings?
>Best regards,
>Krzysztof
>

SBI (Supervisor Binary Interface) is defined by riscv, which is an interface
between the Supervisor Execution Environment (SEE) and the supervisor. The
detailed documentation can be found in [1].

The implement of SBI needs fdt info of the platform, which is provided by
kernel. So we need a dt-bindings for these devices, and these will be
processed by SBI.

[1] https://github.com/riscv-non-isa/riscv-sbi-doc
