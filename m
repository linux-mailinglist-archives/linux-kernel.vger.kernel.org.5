Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03CA7B4753
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjJAMWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjJAMWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:22:10 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2083.outbound.protection.outlook.com [40.92.47.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47764D3;
        Sun,  1 Oct 2023 05:22:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiZCvnll+lOQbdx2I52YzHM01xrNiRBMvoU4o6HWQ/5U4ACXesRJPCPFjyjtER/0vV+W2hOeeek3bZxTYRCDo3iQHsDkkTfAALMGD+pKZ5nA+EXSzbu71n2k6kbs1/dzHrWV8AkP7sv6iquZkQnUWhjYIf/IFXO0+t4q0ZndeORKWRd2Q/utCGIARFTWBjFjSs1xatqayX5Ih/I90H7VORujR/vwlGBpLrSHceLcGNR3xXAEsLZycehWE/459C7lJr+bINUHTJ06gJBIp5tLMJjadHBm9B8ov+ot1NK3I1zVvHq2wvCLngzIsAkaB0dSHnNBZ5g63/ieOH/tBYJerw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVBUo3p24GgQUtBibRkqhWjwdDb/T/sOhy7YsPHkl2U=;
 b=mABEY+9CHu2OIZ7WPu/hDvNtdHD7axxtLiYel6dtvhuSm4PC0YyZDqwDphfwxPykRYg3+mmyNY4KnVhJJsWOmjw7fTlijDQc7sqRgx58BaegctSVEF7ij5aHIKzMnZVkiIlKZgita4/kIreSv0R16M79OJtLUr+nyeNNsqaGt5xg6fM029+oYC5nIIhKlSuS3Cyyu5fTqUPRCNtHHyn/IwhjZucxbOmTt8edyOzWO8dBMgDKre0tUUufoA83zYeOgjbtV0X9Y2KIjpF8YM0X25xeoPyD65C0en6vXIuMRXu0xuQ27cQzOPYV/tqBXM6QIxu70P1/xeSh3so5FHV/0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVBUo3p24GgQUtBibRkqhWjwdDb/T/sOhy7YsPHkl2U=;
 b=JDcJdlMl2TKwg7QzTvbZNZVJeaAQVlM39FihCYw5MEPggVrBjkRJVrTi3SMWp2S24BP45npWre8nMOvY49F0bYkK4JxLg4sxy8ARKin/Qdw/sTEABd/Ab2j4zYMBZBmfVlRwqwM6qhACMj1wSDuis4j1cxjmm3vMAyC2g9qK+ociLZjIXqhsFaTJ924eBoo8ZvxJAKjFbhyFU8XTCqbBYFOXyzRkoAJZrN8LjpCa+C59FXdx8UnCMFpqsHMCATv5+DUlTZ6yvMG0e/05JrN8H9l+2tYYhbURUe6xl52SEm2IBAkIJojYJNZcZwdtq7oYjJtUEqf/3EksU5H8JksQxA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH0PR20MB6018.namprd20.prod.outlook.com (2603:10b6:510:293::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Sun, 1 Oct
 2023 12:22:04 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 12:22:04 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor+dt@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH 4/5] riscv: dts: sophgo: add initial CV1800B SoC device tree
Date:   Sun,  1 Oct 2023 20:22:04 +0800
Message-ID: <IA1PR20MB4953967F34C7C48C74313B74BBC6A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <IA1PR20MB4953D58BA3ECFD487918E3A4BBC6A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953D58BA3ECFD487918E3A4BBC6A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [iYGVfm2TugDtMqnoXpUuB6MSQ/wtXzkTgONF4rj6jH8=]
X-ClientProxiedBy: BYAPR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:a03:74::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231001122204.667415-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH0PR20MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 994a52a4-3f7f-40bf-2a2b-08dbc2790566
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7Rnvk7fGGujICnDVBsxz1VYCXvKvgUbciQEdXKx0IiCgDeR6UXwFN/PBDA29a68sPORVkdzV0ftPxmp4mLSl6iKX+iy0+mAt5d5or9zIo7COor7ltBLlJHXSj43IsiHSqbyc06GfdsCNDo7HYMSsv0Nbdh8tyh4GgJ/uQDJbqYkf3TGqutpfF0tfJQSAFBmpDhAoCLbA811gaaV7nA2dSiiONeVCfV9iH5CiO8B4kB/wTkFpCub/kfcLZ1qgM1GZQWtigPDo3inKI4vw1PPTZ8rC6FqnnvdKYw3DwPiVBwIOwsBS5l9RD+RvMMX04ODqLZuZlthpwLPUa+P+/aZBi273Q4RFB87NVwmsESjdd1N5dIQcFid5pyN3m+r7kH2RdBAL3evPDF+EB/fhABeGRaPMp/2svA+irEn4eaV2CfVUwYJZoNI0TNxS94kITkLt6HtqgYs/rxuw7K9dQeedkJbBB3D2q/leh2srv9agKLrkbOW0ttkp4udeRI1s+Bf54/83Ot9uZB4ZrJgbjX2p44r20rJIb5uINbTAw7+kYgLRJvNIOYjfgs6T3b9DzTBZaQZh5EyBfmjLQaH/ys+QaBQd6iqDPNcjqLsNWNqxLpDfvSARaLtJnDXc+afE9a/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2UKJZiEhxTyH+OF/3mH0dhR1DmuNFG9prfA539wxnKpXsooGPc6KYSwy3tj2?=
 =?us-ascii?Q?NQnFAEJ5AzqWtzE3TLG8nwITkpuCP3i+/UYuM9F7UvBYivT6Vh4waKI3jKbf?=
 =?us-ascii?Q?5uqlzqsw5+Osw6iIwjsRXU+uOSbckZLDSMtyMljlpOWYJqh3BJopxzPkQKU8?=
 =?us-ascii?Q?8O0ryPmBuG2p/HvxkSYFOLw3nymiYoaMRFXVHlGDDaNjyeH93JjS63RfPZmw?=
 =?us-ascii?Q?hTfQZkuj6d882QLXFfHkwbXt37hYCs8BCMOQCXrArs804jcPSWJQN7LeSvOr?=
 =?us-ascii?Q?dHWlS7C6VlSkxsQZIIBFNOiczxKwMgQeKplceGpdTsa2bbmiWqyD3vh3qJyf?=
 =?us-ascii?Q?CynQGoDzwVsFpsdzPMXYDmMF7xOOF57AvKTmrkZyVW9duDIYpsz6HFOHWl6C?=
 =?us-ascii?Q?8DH+XpBncq8OwOt6SocRghTk6/V22wkBm1PUUjFRX/2M03iskazbR+GeNVFb?=
 =?us-ascii?Q?fRDWuWexFpBEWeznpEowrW1RGWrJSHcQ7n+g1/XOEDANWnK9SSTPhCW0ZC3B?=
 =?us-ascii?Q?zkVp0gwfK1PmhZdMrlTKwhCJk9tgmPYnI8nuujpFrkJqT3UHy2/iByHrUtqk?=
 =?us-ascii?Q?VgluCnEZZ+1DsW+iLzABrNGiBwp2wlfo2TTirdzA/uriElafTiYBqAhdG45s?=
 =?us-ascii?Q?Olxuwd+RsFk80+9Yay4Fn1gDvtUYLVifi3TxUsYpfY0B+FuLTMx6hGSkruhE?=
 =?us-ascii?Q?hZpfOxKcW9tejFpIMWEJpc4SEqZg0PJggoFtiv/RRhTU3yLnd9KgWS4fcl15?=
 =?us-ascii?Q?yXfQBOts6CisUKbQwgnIgsp8fkx7A9rBJBeXXoiJo83729N5wt+nQz7rqjNS?=
 =?us-ascii?Q?/hDAMjAdHzcCVgCxDCTwB3ZXQ4fB0WDYV8YqlxuynQxo3JUjACM/tyJ7WG0C?=
 =?us-ascii?Q?eeGQioymEG8L+x4YN14+bTbYK2vj/ZKPpYXtiL2TwNUAEU5DpeFbVNF+sMqK?=
 =?us-ascii?Q?7r46pA+j9SxP1FgTHpP3OlGgPAYpBjo3iGx3+whhy9zgpMGuksDrZwXtnkQG?=
 =?us-ascii?Q?7jRs2Hglc6liOh9TxQEYwqz3ZFjs8pY3VyhSRNu4XQQP6jgtJPIGc25IGELv?=
 =?us-ascii?Q?nVku0Clg5JbJLSpic9MNRcNvvGsWRoD3TdbXpPEoxLL5hEjTntdcOnBTfTd+?=
 =?us-ascii?Q?inSfCnEu61ydBlIWvp6h8DjsjHdQg1BThxjp7wmq+5Ax5+HA+YWNQo8cvCDA?=
 =?us-ascii?Q?QgqZFaovM8aGzL0PmURTdIX2Fm75XE8r9AKudW0FxypTDop/ZEy0Asi4+fs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994a52a4-3f7f-40bf-2a2b-08dbc2790566
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 12:22:04.2697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB6018
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>>On Sun, Oct 01, 2023 at 06:34:21AM +0800, Inochi Amaoto wrote:
>>> Hi, Jisheng
>>
>>>> Add initial device tree for the CV1800B RISC-V SoC by SOPHGO.
>>
>>>
>>> You add the clint dt-bindings of CV1800B clint, but I don't see the clint
>>> node in this dt. The SBI needs this clint node to provide timer for linux.
>>> AFAIK, the dt of SBI comes from the linux or the bootloader, and bootloader
>>> may load the linux dt and pass it to the SBI. I think it is better to add
>>> the clint node.
>>
>>> In addition, please separate the peripheral node to a different file, which
>>> can be reused by both the CV1800 series and CV1810 series.
>>
>>How do these SoCs differ?
>
>AFAIK, the most peripheral of CV1800 and CV1810 are the same. there are
>only a few difference between CV1800 and CV1810:
>1. CV1810 have mmc interrupt, but CV1800 have none
>2. CV1810 have more RAM and a more powerful TPU.
>3. Some models of CV1810 support I2S.
>
>Also is some you have already mentioned, the video capabilities (including
>encoding, output steam number, input steam number) are different.
>
>The only board with a CV1800 soc is Huashan Pi (CV1812H).
>

A mistake, I mean CV1810 soc, not the CV1800 one.

>>Documentation seems rather lacking, but I was able to find something on
>>github that suggests there is also a cv180zb. The difference between the
>>three seems to, from a quick look, be their video encoding capabilities.
>>Is that correct?
>>
>
>Yes. it is correct.
>It seems like you have forgot a chip called CV1801B, which has 128MB
>RAM. But I see no board with this soc, so at now it is not necessary to
>care it.
>
>
