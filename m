Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF56804FC7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344951AbjLEKGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjLEKGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:06:05 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2073.outbound.protection.outlook.com [40.92.52.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9DFA7;
        Tue,  5 Dec 2023 02:06:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyMWO1qdyJymCT2uXkJ3xQPdcJ6j/CWOZNVt9xPVwJCU4vSX3Tkl+lBse4ma8l2D5dqPVG0lJx/NV2eB637CHFhpwhuZfGMD12DtYnqI3hzUQOwbYKlKP3j7S1lTcKfBgRR4PTMJUb3W/AyZdtR9+rKrfcMOgdKfVFb+XoHf8nK45Q2oLtM2O8IQ/XAiMOsyETe+rhiNsW3iYskum2bEBswLEfI+nfNDl4JoCXMOH1jN89OyebK9MbnfR8BlZJi0h78z/D1e7kPgpvpqT3flQoJ8IHmMx403VR6TwtBfMGg/+fMlUZ+d5J354oUJp0wbDguKfxvjPphD6Jj89JhKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKhxWmIdDiIMAzWAiSNLLBuHVP89Xp1LGNtfBX0yFSg=;
 b=f7FlHbFKavL2MwcCMN4tr/bCQL4zUxhSaFBVGusnn79gOHmgT+QiNhf+2tvOhlIuOukfBacKs550y6RKJ3YP32Hq+tfpNI6okXhuBOEgi7V1jKHxNkfogcCQkdXXKiP4gd7wbe5eFApNyiNZYRYGERsM0M5L+qgYuJ3Lql240dpEs70Yl3BzK2pKKMyTFqWiABVP3EHanzzHtU1I8YE1JF5vNsYpaGEh/5gehcuc6qvWG7wlXIhUOy8vRbgCpUnq9ncldeyi+pHF3K5OUg18BEFoiy4qoG3t3BRxox4PBUOc9yDRJKJxRCfxoVIyiVZfklP516DLPOZHIQZmX0Uqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKhxWmIdDiIMAzWAiSNLLBuHVP89Xp1LGNtfBX0yFSg=;
 b=iSxC6LKa2VaQ0iyO54UGL8dAA/yvLXZYzIeenR7pLsKlUujDdaK/TMWsWxd+sTddaChPE5EXcR/zpFUCqBbVgV/1mCrNGrXjSCWMutEdyt8ZL0iDtsajnafCnlpMpP2zz5PnnVn7K77VvuxLDJE8BNArjCfN9CsXMrEtJtUkaUZ3DQahjTv4AOQPYDNZ3++6+8FvKIEPD8xVNKfd9MQ+O/V05IaeFm3G/zg5R1eQsMSBpepbs+PUmbmYK5iNEnlYQTJjhU+JlHpjFubcQsCpwV9y7GeeH50BwRsk6NoZaqDNUrfDSbb+ZzzuIlgbeEu6ug1DUx9LzwZKCeOhsxSrSw==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by SEYPR06MB6587.apcprd06.prod.outlook.com (2603:1096:101:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 10:06:04 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::f2fd:d852:e4b9:6166]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::f2fd:d852:e4b9:6166%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 10:06:04 +0000
From:   Allen_Lin <allencl_lin@hotmail.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Allen_Lin <allencl_lin@hotmail.com>
Subject: [PATCH v1 0/2] Add HX83102j driver for HIMAX HID touchscreen 
Date:   Tue,  5 Dec 2023 18:05:50 +0800
Message-ID: <TY0PR06MB56110AE059FC985028EF2E409E85A@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [+WOS5bSWrvBkBI4dqqj2IVU+lU9np3Jb/jhll2J/ogwDTI+X4d0Ck+SHXxJkvr5fESK7BJyQwr8=]
X-ClientProxiedBy: TYCPR01CA0102.jpnprd01.prod.outlook.com
 (2603:1096:405:4::18) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID: <20231205100552.723620-1-allencl_lin@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|SEYPR06MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 366aecbe-1b6b-4bf6-169d-08dbf579cabe
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: trbyneZUi9OL4fy8bSK9LOQtuIw4+saQT85XMS2rORWLyu6hYvp+raVluRi1N84S9KzdSH0FfH7bYp50pUOxR//xe9IG9a1zHmfpXjy2JYjEOD9csMeF9SQ6ILCqgPsmhtO6eEAyaKWZX2fI/f2TbYOr6J6m5qEj+xAOoglXlP5yoJ2jiLk9rgTHuvIht7zo2Vt8JuMEDq2HJSeUyGvKCZ5tyqInnWYabLbS8yM0g7k/JSQzlrYVt/IDoH5kK4WxVyaVFpKEmK+swJFfQAWqIpKx2JKrH+N2Fvst5NnjV/ffBuSaravG0nDpou1A6WBoBExCwEsnpJ+fk77KjCtLJ0NAbs5gfqSxXLZGQ90qSrIrUK4pMBPJequ83A/7g+mC3kWo0BO851IGQMeUUwIT/mI3lzzysViP+RcMaCWGZYxE5rwR9i++IYhrPhNMpsmkopFgyjv/J4BPHBq5sQpTkqO2+iFWBUPU+40XVwbZuGg97DL0duE+plfr07MzXJP7mcUFNUzKRDQCiUzgKAAenUaD3eZnaVSseKQWQ/ssYI4jGbuCFU9rzmDwRxu0inxr2oNsvwj7imLKIEkGeoYGFo+ZJSWGbBhtssiZe8oac2ldpu7RF6DAQ4es9EKkP3jW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WC+Gta5GSvMHJG0NbMlcX4fWBJQx6Nwa+H8bFnvuyAqE1QQx8HLgrIQgGI3P?=
 =?us-ascii?Q?JcLRWyhu5PRfnSWhU6EqnGvDR7hlWZpEGyBC1sIeW8B+hkNDhyVEK8TmmL4I?=
 =?us-ascii?Q?nI2EX3lcEqlstCrdWD0lt9WMpo5ZoBUJb94X5dUSW7s4jbfWtIlDcJqS25Mx?=
 =?us-ascii?Q?4edGhxnf2+pVzjT4fQJn7h+uSUeu8CmPQJZsbpwEmhhelc7eAgr1KKmhrjXO?=
 =?us-ascii?Q?YCfQhgng8GA+M6310/ykO/moLst8Xmg8Oa4syUGn2xRb3tkCeUE26kyjLLHw?=
 =?us-ascii?Q?5fYbyUE7kzH+VhojXJJfyX9GUrQ50xqIyOwelbDyDQ7CCXcrBKCuXjCsxCdP?=
 =?us-ascii?Q?uL88Gfrw2Tqi4RHfZsk7weH0PcIIjBRs6JPyJ0CTr54X1z3iVvaKUAvIhEP9?=
 =?us-ascii?Q?041Un3eceOJ7b01Rnac0neWgCQfupLp2i4Q542oG9UA5T2waOBuqJVOu/ijq?=
 =?us-ascii?Q?KP2fhYNW3fUpSDFJ1QAzP9ZdYqe22P6Qfllf/fX91yPKg+P39ZOxj4kdWabL?=
 =?us-ascii?Q?yfHQamI7+qut3ZfKL/E1voNeW6ew9Y8pMMn3Wvk4i0CaBI066/JtSmo0YzbW?=
 =?us-ascii?Q?kyotma5kiLTrU5unaRrDtwTxDE6TZB/57sLr9AQoNjip7wT2C/k6y8MqHl8b?=
 =?us-ascii?Q?K2iue7dTxvz3ItmLJjkgJxdsdDcjiwHtHHXc1ttxi3hFLEPVLPM7HfqCM3Id?=
 =?us-ascii?Q?LrHfwjDV0NIar5rxpGByF00FTWDO1j4VUHr1V0ahKedxGQ/P2k8/IFDIk8Wl?=
 =?us-ascii?Q?2yDQ6CliCkr4LseX0XEsOmluJidZAeo+s4fgvVs9M/RfH/d7ryp2F/b8dLh3?=
 =?us-ascii?Q?RzqIsjxSt7mJHTL8eqayluq4EV9vr+wgKCZp1qGs+LzfCsK2/OowOPe5NEdB?=
 =?us-ascii?Q?3MM61Dna1VrKUeOzlRIrefitD2G04fyuOlf5mDb1h9Yy9gj4QbBiwZhUiPHQ?=
 =?us-ascii?Q?01Q4dXCx8UWlnKL1ZU8Sk5x/hWKL1yLm9mJfICa+J8rx73+Sky527pNFaw/Y?=
 =?us-ascii?Q?0FfeDIJVENf4B8HlowruF3XTpblnwjb/hKfXsiArr1vB37r86GzzqsDE0UQz?=
 =?us-ascii?Q?jYDt29hHvECssDcRolF9R/eVR9KO6ikhqrH0NpsEJKXhoo5zPnd1TW2Jrs36?=
 =?us-ascii?Q?bAwQukdCMAeEwzrz7tUgXLKnntAjXlSkTKEIVsSAGSqowKPNgy2Y7RF6aqLM?=
 =?us-ascii?Q?z4fxlDMdzi83j6iWduCeSsFFsKsM0LAApSg2xQ/pvnUBHovaGD9RC6755d/G?=
 =?us-ascii?Q?YsFRkF4kFdzxbZ3oR1WIFHSCDQAzqFJQhbt20QZtykv6zeBCPSGSTUWYGAZD?=
 =?us-ascii?Q?ejo=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 366aecbe-1b6b-4bf6-169d-08dbf579cabe
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 10:06:04.7061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6587
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This driver implements for HIMAX HID touchscreen HX8310XX series. 

Using SPI interface to acquire HID packets from driver. 

Patchs notes as below 
1. Add the Maintainer and devicetree bindings document for driver
2. Add the driver code and modify Kconfig/Makefiles to support the driver

Thanks,

Allen_Lin (2):
  dt-bindings: input: Add Himax HX83102J touchscreen
  Input: Add Himax HX83102J touchscreen driver

 .../bindings/input/himax,hx8310xx.yaml        |   70 +
 MAINTAINERS                                   |    8 +
 drivers/hid/Kconfig                           |    9 +-
 drivers/hid/Makefile                          |    2 +-
 drivers/hid/hid-himax-83102j.c                | 3176 +++++++++++++++++
 drivers/hid/hid-himax-83102j.h                |  927 +++++
 6 files changed, 4190 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/himax,hx8310xx.yaml
 create mode 100644 drivers/hid/hid-himax-83102j.c
 create mode 100644 drivers/hid/hid-himax-83102j.h

-- 
2.34.1

