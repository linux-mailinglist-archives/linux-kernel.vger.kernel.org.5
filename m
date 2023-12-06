Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB4C80638C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376308AbjLFAjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346659AbjLFAjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:39:07 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2028.outbound.protection.outlook.com [40.92.19.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFF7D3;
        Tue,  5 Dec 2023 16:39:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE9FNr3TqvU5S0uUGWEcrPUB+Z3LX5EALreeEI0Jzx0hZT0wIpXes9y0FG0WQJZ/HNpsFjf8TtxXfzku/eV8ktE/UiF/8NeknRZU7+JaF8MkzbT8Gb0YBciN/HZtAZxKKopwF4TNjBe8NGNppUCG9S8xBlsTjYSWFUoZR3z9/8HjllgjD94koyaSO3ag6zS2H3ZTFScTd7Go+b35r26L29ejTHOsmPHZPnPWHwh3yExLBL734uyE1b70UCUz7ihXhs663415trwTCfVRp6w+l/qc66C2gxFr+WfegaLrITxkuyLWQHik2JWkDF+VlQCbKcLJZeKUv4eqvailed+ngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXeEunOxPkYTsv8l86vP8gSM5RwHQh0MZDPvc6kt9XI=;
 b=jt/7nbw+xY4dyx68G1oL6ai7Ip0HvfG9BWYSZDS1er2YNl2Jm0HhG9LtTI2TwMmMdNd+ojA6X+yAf3McR43tRalXm0A0OheSKcuFSa4d1LWlaDIi+NxQ/gG3xxbHacgTM/aAU6rw+k5DrPtTZsbwhVhWb3b0Zv/zxt7UswYEa6kZtghR9sZXcrzgzrCbaXIXbOLVcv1lsfppWls8bNxFc9ff1UP6oHZjaV9FWVml3Yn0ACtEXd5NesY7xIF5omNSX369ZbGJjoNUH6JvLKmuVI8uano+O6koj2CvWS8rsbU1G/3zBg2ZIHKMcYKEld4yhkKHFg/qcsl3UCQsPHU94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXeEunOxPkYTsv8l86vP8gSM5RwHQh0MZDPvc6kt9XI=;
 b=NCI/1ObvdG7D7sN7J8tzvQ9h+ExLxy+GmVTt6cGYiCSsic01kQKSPu6Fnvl/bOTaMhkPF80MFfhSletI2IW/JS4k3mM1alDxt9SolnXi13BTjE4hymXWFWNizzK24l+26WfVW0cnlPp1tE+yOXl6+IICw69L8HA/kmJkBd7CsvTqjMaeSvHUEqEKIVNcYiciHMXy52GoQ1WAoHgYsNjXaOYnLz1nIeWLVPNSQyvIEqUk2iBOqQ9BDEXEIzPJnmq63O0FpPwtgx1GY62N6Pe5UYjuhY6nGVcpMsyjVfb93bq/eg5pStuScSptFZXhzVBE1x7dv7jy3tLpkLUJqNkUAw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA1PR20MB4956.namprd20.prod.outlook.com (2603:10b6:208:3ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 6 Dec
 2023 00:39:08 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Wed, 6 Dec 2023
 00:39:08 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen Wang <unicorn_wang@outlook.com>,
        Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: sophgo: Add clock controller of CV1800 series SoC
Date:   Wed,  6 Dec 2023 08:39:14 +0800
Message-ID: <IA1PR20MB4953BFA99F4C91EA525BF03FBB84A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205-chump-ravage-2c5478289421@spud>
References: <20231205-chump-ravage-2c5478289421@spud>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [2TewSEC5JSj+RKcDqmLJ3W4lNb8dt/9Q/U18a6fOzTs=]
X-ClientProxiedBy: BY5PR17CA0067.namprd17.prod.outlook.com
 (2603:10b6:a03:167::44) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231206003914.130206-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA1PR20MB4956:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fbe00e-0993-406b-a5cd-08dbf5f3c206
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2Uy0POvtbDBMDdERke/78WK5Kf2VpGGeqSPX56wf1vw3GeGIt9/kKAc6E/NUR7Dud8pjzlZFOy/pvjxggyyowyLlPBIY+XwIY4cEGU2PLMf27aUu1MUbqhhsioJIKHhLKUEqd1PdXJFWFp8hVWy2PX6Y8ImjXqdqlu7grGQKMh8objFIJkiSEBqQChNoOftkpOZFrxIxV9u3HEFyKz8FBaL/C0yT1MaXlL2y6nfQGYAR5RFHketFcc9dfUMbGM1X56IWeWMe23kJMYVZV2A4uq2TQqJvTSpiG2c98MlXBW1Tm/EuIcWCCNESdo1cXleH3ylzh/7CBFHObd4A/NA1869r/baVyK4nT6Rxo4nDnUA/cv/ew8txE2eiacR+tbIcsUBOMKzBif8aWw2qFVjb8Ym7jpBkhT93fVxBxBlRMQggKV7bBi3aN0I8p5gjn7DJjrKhb0AgI4a5VIBQgIGZzMynv3QIFnHOQKw1apsvVk4oqi/7KHnm1XXY7J8qezxQUmorU+lqZVklHGv3JBHjexN7ccUh9RVEPNP8Q0q4+73L8k2fjDptyIXc3sFmTEd5x0HNcPU8cgVkvZz/zqRsS2++ZMrwuGZo0dwAyfO/YPgLRc+neHSuwlYI8ZE6RzN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oe9vhbGrouSdGNuBxyqU8JBuYSHDEdbTaFu06DTea9axc005k/KOY6uIKU+e?=
 =?us-ascii?Q?PsCI7S2AG9cYDZM0AA0oWMq7NT+8cA+Qv4ZAaNs/vS+C4W6CS0eZCR5RbVYu?=
 =?us-ascii?Q?UshXRxJrwhGBwu42KGB9Xe2rpFBQPOGzapplt/zIqqOh4+exGSieEnEQUnhV?=
 =?us-ascii?Q?u9KdH90+JKKxmLKnZNWf/eyX48zeFRFZQBTCyZpVJAqN9jE6cMYSX10ISla2?=
 =?us-ascii?Q?SCUMkFrSJWwRy66WKPYLeVaQXghW4n2eIHPV6cEPibgj3K73ZOm+hp3DD6EL?=
 =?us-ascii?Q?pVulKC+HIwQEEtlQQ67+L0nf1TJgESwLiplmX3aTdJqVwQiWqfAeN5Av/rI4?=
 =?us-ascii?Q?WollOzC21u5eOTjQvd8UWIoLpS1i9qiM9W/TaDBLbKoPnnFbw/j9afW42l4G?=
 =?us-ascii?Q?r4VDnztXGNIjHq4Jz4mcE+OnpAuHjPFmvbYsM9mqixBGGQ+OtRGPmW6DAtJt?=
 =?us-ascii?Q?m4iK9NhgV5NeXcs/iFn5a6ZYX3VDgvgjWNFAloxTgXzUdbYpNrUF/5hGgYC+?=
 =?us-ascii?Q?0R+0ioXsjJFoJoKEORkcPlSmx0KCh1Wy+DpBkXQsNVyNpsEMiBzl/Yz9yylf?=
 =?us-ascii?Q?UkJgV1kwoUc/IRt2vBmBnbPU6L3YlXcNmWJKIkrabEyv3ptsyfTFq3dJ/6js?=
 =?us-ascii?Q?3YjvhJ20HSgzf4cmyp3cFaBEjsiJcWlUT5n7gOdupL1Uvj2CJVIrhZfAtOi+?=
 =?us-ascii?Q?2jnc3KjlcYaIQyDi4ZlqXtAj2BMvf1Banea6me6ngp4MMd5pr+CwsfQfQ7y6?=
 =?us-ascii?Q?+yjrYEBiyLsa09sum0sGc8J2RcHd+34MpuWL6MpZz0FFa5ZXSt+Z8rkZcv5M?=
 =?us-ascii?Q?IN/4oDg1xETA/M2/oziW09TnFDPngEab2QDFyDdgzOkFGWj+QKtjypgMgHg7?=
 =?us-ascii?Q?KbA0cEnGr1a9uOuu5of8dh74slrdU6Beb0HaNnlG+EFpiprUWALGwAg/AcEV?=
 =?us-ascii?Q?aOfMenOWshYdVK8MO12c0WoF3Ya9yuGOS+YG0pAaBJaAOE1GUjeIbU/rU8vt?=
 =?us-ascii?Q?qpQ62fIV9UbGcU6y+mfBEWCdoKuV6y9jwd8UfQ2wcroWMjvD9vC/YsPjcUvc?=
 =?us-ascii?Q?MQcvqGLBaFgZ5RWkjARVjoMyC3vi+Idlu3P5FbbE4G2ZpStdDabyHr3YUCv6?=
 =?us-ascii?Q?SbZOOh2Njmyb7MIuTZ63epyxZlBq4Q8KwAOrnrg9isN2F3UH4A7iXcpuSCM0?=
 =?us-ascii?Q?J9ndl4RRWBqeqzqykrkJjuv3uVow09efcfUMzqNIyP/Tb3qBl6tZeHsQmcA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fbe00e-0993-406b-a5cd-08dbf5f3c206
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 00:39:08.8044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB4956
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Dec 05, 2023 at 07:55:50PM +0800, Inochi Amaoto wrote:
>> Add definition for the clock controller of the CV1800 series SoC.
>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
>> ---
>>  .../bindings/clock/sophgo,cv1800-clk.yaml     |  53 ++++++
>>  include/dt-bindings/clock/sophgo,cv1800.h     | 174 ++++++++++++++++++
>>  2 files changed, 227 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
>>  create mode 100644 include/dt-bindings/clock/sophgo,cv1800.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
>> new file mode 100644
>> index 000000000000..388be5bfa163
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/sophgo,cv1800-clk.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sophgo CV1800 Series Clock Controller
>> +
>> +maintainers:
>> +  - Inochi Amaoto <inochiama@outlook.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - sophgo,cv1800-clk
>> +      - sophgo,cv1810-clk
>
>I'm not reading 1000s of lines of driver code to figure it out, what
>differs in the programming model for these two devices?

In fact, they have no different in the programming model. The only
different between them is that cv1810 have one extra clock.

>You should
>mention in your commit message why the cv1810 has an incompatible
>programming model if you are adding multiple devices in one commit
>message.
>

OK, I will

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Oscillator (25 MHz)
>
>This could just be "maxItems: 1".
>

OK, thanks.

>> +
>> +  clock-names:
>> +    items:
>> +      - const: osc
>
>You have one clock, why do you need a name?

I am not pretty familiar with this. I just wrote this binding by
referencing others. Maybe use "maxItems: 1" is just fine?

>
>Otherwise, this looks okay, thanks.
>
>
