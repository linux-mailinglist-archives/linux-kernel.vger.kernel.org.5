Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D4C8052CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346962AbjLEL1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346896AbjLEL1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:27:35 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2102.outbound.protection.outlook.com [40.92.42.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696543C35;
        Tue,  5 Dec 2023 03:25:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hd+XA4p0qKFuY/dDFvGnbXKWIV2Sec8xLNVDU/aN6qcVEzGQ1Avt0J61tpgzvqdF0qYn5ojVJsi6Te50yGLpjOf3w9mtJqgzTXxqEf46XFBUBGm7gwRwZ1pc5e+rRElM5RQTQsl8lvKTG7mP5dw7dRDtnJGrZqKVQam2nk5x7QWruWVNF4mD0NErDy4LdRljoGX92Qs9C4BIuW90F/E9ZIVw+o6H6oG70nxq3lV4bmPzxmsmzXgbgUGnMh+Qc+TN3AbZAcE8tqcdqs6PcXtrSIjEmBjzocJRPgvE/hh2Ruw3xQVnXCihsNj5m4DEArvTb8WKkNxFEcnD/001SyKn1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMN1Qxertfz04bAXR0J9l5Y+AhXoknH/hLTGNbCl2Bk=;
 b=bdDLRUbToMoAI0ni/A0GcXktJTsJqYMfhvcZ98kWB+TnoBaU5j7hF7VM3NmaZ38rqwmdabQwQYxIMAkcJFYUwyF7FHT5v6SbcUjnuvp803g1uECrNdmirGe5musFcsW4DM6wVWqQ4hfhoFg+O2JnVpEa1dYsRKRIo5psqQz6PS6LdhBUSHb+TNWrWMd0dgzuVYOVYE5uHv9O2aoB6P4pGQWNKCNh+pJm+6EYnPxouVZ2HHTpfXCBtjBGg3xBP2Ml9FP2J383DlUWBy/XNcm3F+8zfhvBGmIhRyz01IyH6AmN0vVsrxscAaswUCOcWG/eEPMjejrnT8w3QSUL08FcNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMN1Qxertfz04bAXR0J9l5Y+AhXoknH/hLTGNbCl2Bk=;
 b=ou/tm05k3xlyYjelg8pAObeBng1i5aKLyj8rn6dqlCx7s+xVDyK8uGAYW/qd4HANPg1rk3tf9yzVuXqYekhIMEpa/U6bI+1Inc849yQX9oCW7sc3X+iOXpUyyFe3kHLMLTBuj1a6FGe+Oh8JeilX+mJZWo4Vbbk8SGwnpCjPIxn7x9CiXDuBdmpAxbStpd3c4OL6bhOWdVJST1UD9/AVctKMqKXI6fquMyuDN0dhZSlKl4Xc5/zue4yQCdRAnofPN2nJmPd+EcFRCHT1GbB4rpmaOPhaKWzLA4wVQf54YSm/+NhOEeIGV+d7sT2sBdie/GsM4Xobj8cNrQi7o8Bfnw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB4988.namprd20.prod.outlook.com (2603:10b6:510:1f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Tue, 5 Dec
 2023 11:24:59 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Tue, 5 Dec 2023
 11:24:59 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: clock: sophgo: Add CV1800 bindings
Date:   Tue,  5 Dec 2023 19:24:53 +0800
Message-ID: <IA1PR20MB4953F0086FB77F8DC46C8095BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <05d17d6d-490e-4524-ab1c-4ccc27b0d7bc@linaro.org>
References: <05d17d6d-490e-4524-ab1c-4ccc27b0d7bc@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [SICo6BUo0eAnNp2b0ETd1BVVfZUu6AysvzUgsuJiPvk=]
X-ClientProxiedBy: TYAPR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:404:28::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231205112454.1025054-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB4988:EE_
X-MS-Office365-Filtering-Correlation-Id: e356a8ae-ede3-4f8e-1766-08dbf584d0de
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pifHK5vUgIgNqhRQSXgPI/OhIXpO+OUCP2SnIsBW6ZiMfndjZlU8apwJnmRW5Q+FNWV967AkEFfnXLrGMEr57wL/jCuR8KKxMPSKCoxpu4ACo7s+xCZ65sRaLtB1x9IuXR894IGS6ydXqPdwUP6LmbJHD2L2HSn/AuoYzhDE/F8sgcOjwexAhaFfwFT7WqQ06Hk4Bk0e/Q0yIzuOAvqVjor04wlOP2iI7RUDIKyncDR2CMrmC73+6w92jqfk0xggqVGu3PmW5XAZQ5gtdpLqZJvLL6qAJoSzQZR/Q3Z3AYU3V5L+gb0czNwTSPR67gb8+lgorPbcN4WI1QNoMALYMg6ZkxvTGWrJiGWIzehgMWfFhLdunPVqT3ZX5JA3Xvgj4C3NuZBg7/KaoVcpQ4W/dBI/0H9wyQC29LlOsixmwS5G1ek05sdaskGGrH4kgvxZjTyc5/6Agvd+5oqIC1xsCyRJiyYE0loH6KdqtslS8w9BtHz3RP1GyDBo18ytJPrJfkkz5iiHdW+23dV4Kr/tEVcqpn4BLam+VygKsajY3h/ve1j4trL9eUhZssgQJqmTT+mdPbfURTtuWplPnav1iAAuoVJevoKMZyhgCZ5xzyHv60zugh9UKXatpMeJ31Vs
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BLaKgaJRZp9yCattlFpm9X7vTWBYY4m4eHdw8fzisC7lPGlSrellaMQg5n7H?=
 =?us-ascii?Q?r7MfbRNdQpIKfbYNy2Pl3hr96hdv2kkJHVXtFBpt/ZY9bpunssJsLE21fNms?=
 =?us-ascii?Q?6EXHL6EcXylNprGg3JqidJhQk/5RDiaOcGyBJEhMkibYjF/IOLj0ZaNBMzAV?=
 =?us-ascii?Q?HFiKCNLaRzY8Boz7n/WCfwtJWe9k2LqBb8LzvRQRSEpnxjI5zY7gxLpEhAaf?=
 =?us-ascii?Q?6fdcrgpNhWNzxFbJ6teEsF9fZUKgZsVIX7RLwDdPR9V58OfsuHRJKt8cBKFm?=
 =?us-ascii?Q?bW9jelNz1dcIN0ldMIKaVW5s6B9tq79xsTQEtHga6EZmhIAoQ1Sq2JEoqsFo?=
 =?us-ascii?Q?V0eT4vjg+ACq/EdS/1iu3viNBnamMRhLvvHRMhbxSzoRZgq1xahv5H2scYka?=
 =?us-ascii?Q?qXA/4AkraoqlxdPJuJ8SYLvgsLm169OuhxbEmldN7CKNKmrDt1DtyaKfGaRv?=
 =?us-ascii?Q?D3lvXNwLWYQassroo8gHeWx0UZNwyLfY0xJMeQNMvQOGfgYYYCvQGv+ik2Bn?=
 =?us-ascii?Q?F0m+JFfEsX1ogQfpU+/vB3X/o3IsVLXPB/BeHdD4vxb0X2tdsNiSj1jQkF1P?=
 =?us-ascii?Q?SRsY38++Rw6NHiAu7egiIcBjo4o8iNSuDe4mfcQ4u3bn4/79F4dS8DTsyCP0?=
 =?us-ascii?Q?1g/AFu1VcHLkLnxNRB+WeKFqtT5yM+FPXV3kSXxG0A/J1x+yObOzvCjJVaHg?=
 =?us-ascii?Q?zbYLtAmBjfH5dyhX1pzL0YaNroAbUh6Y6N9B6pgjT8ycbMddV8ZHJJpXoiVX?=
 =?us-ascii?Q?RhRsiiMSXwHtFGnmn8niEruNKl2rR6gcnEi5w9/jpFMI4n/Hnc4g4q2z1wof?=
 =?us-ascii?Q?ErwuN3uQCn4V7boPmcaUOxdL4Kt4MAOESyEGLDtTtneYo5Z/K5rCCpBL0dip?=
 =?us-ascii?Q?qlA6ShdDLvtyVcsljJBbEp3ALLBawJM/fiZS80oX2ukvwwADbaV8LF7rIgli?=
 =?us-ascii?Q?m8rW5kB/E36hfeTWinaeHjNaSTdeq1qQt5a5Skzbv0gSR56wdxc6hg0Kk6kN?=
 =?us-ascii?Q?5zLfGdOzzLmkm+TB+DgEKr2ZhNNUMwBPM4OtW//sj45S6iFSPQ9YcBJ/uXJP?=
 =?us-ascii?Q?h2BTixf3OxuPMTIxJZqrfvOuX7GOnC6oWKD0g6RYFTun4+C8n5a4A8y+fb4C?=
 =?us-ascii?Q?ZRRItoPExGcrksB80rfA7SuAsRG8TagTNapo1BqjDNIHankL2kToDYBaYtmm?=
 =?us-ascii?Q?NO5/l4XjNYZ3nkLMdJeu1zf4D2hjsuG1IlQK6ECXldun8Ad5oVdih9Bmtzo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e356a8ae-ede3-4f8e-1766-08dbf584d0de
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:24:59.4040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB4988
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On 05/12/2023 10:43, Inochi Amaoto wrote:
>> Add definition for the clock controller of the CV1800 series SoC.
>>
>
>If there is going to be resend:
>
>A nit, subject: drop second/last, redundant "bindings". The
>"dt-bindings" prefix is already stating that these are bindings.
>

OK, thanks.

>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
>> ---
>
>
>> diff --git a/include/dt-bindings/clock/sophgo,cv1800.h b/include/dt-bindings/clock/sophgo,cv1800.h
>> new file mode 100644
>> index 000000000000..6a9897b34978
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/sophgo,cv1800.h
>> @@ -0,0 +1,174 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>
>Why not dual-license? Checkpatch complains about this, so are you sure
>you run it?
>

Yes, I have run it. It seems I misunderstood the warning message.
It only tells me it should be (GPL-2.0-only OR .*). And I think
GPL-2.0 is ok. Thanks for your explanation, I will fix this soon.

>
>Best regards,
>Krzysztof
>
>
