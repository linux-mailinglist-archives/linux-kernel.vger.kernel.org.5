Return-Path: <linux-kernel+bounces-146364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D490B8A6448
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617E51F21A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4E96EB7C;
	Tue, 16 Apr 2024 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PpPWUgdG"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0486F9F5;
	Tue, 16 Apr 2024 06:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713250027; cv=fail; b=ZClX+xRMQ+RvpgWS4UqOZKqrHQi6zqbXRpEJdKUvVZWn3VmZ5SbhMgRyQAJeQaEC3m4VxCpiSVgrP7Xhl+BYq1tfCwQ3juanPmxGNqkJRHh2WHbFYTX5ZtPiJ2+BIh9rtRKduNAZzC9cRMfCypL2ugWiFodBtEAwi0rTaiNLJUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713250027; c=relaxed/simple;
	bh=OriWDmUtTVFo7NYmu9i9Z29DHKFzqF+Z//wczZbftzk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YDy7TFWoE2GV7NmhgU7ze3Tovj8KzzbUYibE1eyIgPi0tlsyLRuQIo7RrsmQw7zSiBCPVAr7DAJnG5oEyl58ss1kGpuMBnRtGNtsgq3lFmbFdRDNL1sE29xsVV8ig5RqkT3XovkuZ0n1XWp9vU2RqRXYSyu0JrkIVzdnz5+7UBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PpPWUgdG; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PORYJHaGMtZJyL+xsk2Fk+TJwuMtiS2GFX5I6KWtdEtY/s7stK1b+8ksUMKEBbvlr9cmEfG+WiUy63LsRB+vySBR0rpInbAZgxwMsZXR36ZT6MpezQ9/N6W04QX87R2aiycGB61h+PECBnJOp7Ffqr5+wSuErD85nxgwMgVlQXExW0vEmtUHDzcim9itRd5D9D6l4kO4e8HNGkB/e66c5o5ZsB+0EAWXXvDq2gT4hlkIQUYN6NzvzSiX7AKNXaQBOFHUBRq4EfNXkmKEKqcASu7FdE/cYCulYnTahIw3QCbX0MWs1PCmbTtQjCV/NorKiWQmr32zeDjOIloKVLHj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OriWDmUtTVFo7NYmu9i9Z29DHKFzqF+Z//wczZbftzk=;
 b=HYiF+gNw6PQ5LPDcb89OPc90gIsq54guVnAWGVcamoM0XpTHJacpb6o6eo80SJ9H02YHTV+/fGjenIfwUFxUbrv5ZtSNttjgZ7AwbMf6KXbG+aV2JFPUlFJ6E6rx05J7jTEaX6tavaTcJ8s/TJO/6jJQnd5gR+Ttt2nvsQqRgawM/1jUs276OeybGiYbrc68XmkIxSZw/h4DvFlbQD1PeB58INI7csduxPdWcGhrI6+PWyMwFkLFG3TjWB/d7iGKmZTe68jjQ6K4qfnPlRFQuybKLLlGy4ht/RIfUh0awHq6/eXnNlpF64NDB0kGoe2ZnOeLFoBq06ee39HbH4oEiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OriWDmUtTVFo7NYmu9i9Z29DHKFzqF+Z//wczZbftzk=;
 b=PpPWUgdG/SUg0MHcLadWuuPVehXdHq4AdLKslKjtx7mYbYx2a2Wr7K/085gPM4Ahi7fn/uIgbYemGH4wxhI8PVA7gmAukJQM4b6lqdhjEjYlDPb9M+XaVga+bI8f8OSxtr80G4LY5HVssHRaHuKjYFI2p9N1zmJJEX3HFKrvCmU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB9979.eurprd04.prod.outlook.com (2603:10a6:800:1da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:47:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 06:47:02 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, Dhruva Gole <d-gole@ti.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: RE: [PATCH v10 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Thread-Topic: [PATCH v10 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Thread-Index: AQHajxDwBGYofP/RAUWo+vczNAgrJ7FpXGyAgAEYpCA=
Date: Tue, 16 Apr 2024 06:47:02 +0000
Message-ID:
 <DU0PR04MB941773C6DFD95237ED051E8A88082@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240415-pinctrl-scmi-v10-0-59c6e7a586ee@nxp.com>
 <20240415-pinctrl-scmi-v10-4-59c6e7a586ee@nxp.com>
 <CAHp75VdoaL-66vDFeDWXg5V0XnL45F_JQZ_BNeaaOcSwQz5gnQ@mail.gmail.com>
In-Reply-To:
 <CAHp75VdoaL-66vDFeDWXg5V0XnL45F_JQZ_BNeaaOcSwQz5gnQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB9979:EE_
x-ms-office365-filtering-correlation-id: 806609e7-accb-40ef-bada-08dc5de105b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWl3OGEzZmJodVFXc0FwaEw2U09yWXhvQlpuYjU3VUsvUDN4aW5TclZvZ1BW?=
 =?utf-8?B?UTYvais0TDlSSWp5b0hGYnlJUDc4MWJWNExESTgrRVIvQXhINXh1OGkxYlAz?=
 =?utf-8?B?TDREWVQ2VEl3VE5GRjZWTlZ1VTFUOU9mT2xMM1RQNERiTXBHOFYwckczSk9u?=
 =?utf-8?B?SW5DbCs1S0czTWhiOU1IdzJPQVpCSTZqbUNCOUtvdjVmcE51cDFhRnRvck5j?=
 =?utf-8?B?VFVxc1hOZGx6Z3J1U29Ramt5K1h0dFZ2WDQ5Sm5nbjc3eGowQ094UEZTN1Na?=
 =?utf-8?B?NXFUMEpHbGF2aTB5elRmVTdWajFmZ3pQWnpuc0RtS2E0c09PeVBPSG8ybk9Z?=
 =?utf-8?B?blhGM0toZ244anNoUjVmU0hlVzZrRk1zSzQrQno2V3FpS0RKNkZGdnBBWk9G?=
 =?utf-8?B?SGEwUzVEaUxrcVVlTlRSWC9TVnEyaHErVjd6YVd1VXY1RUNETDl0N2VvM0xO?=
 =?utf-8?B?c3V2VTNHNG1RM054S3NNU2p3dW9lVGV0TlpZaytqQmk1dFJOODhCVy8zUUV2?=
 =?utf-8?B?UXJIcnFWcURWU2l3UkRiUm9YZzVZRTdiSVlHMytPQjhqT1lzaDdOdUR3RGhW?=
 =?utf-8?B?OWJSN2RBRHVmRkY1clVYc1pQSCtUMFZScGh3dWZGL0kzSVE2OVIwVkhkZFVH?=
 =?utf-8?B?cWNaVE9oNktQNGhEM05ZcTg3L0wvbldTOEhETmhDUldTYVZpSm94bUREenNw?=
 =?utf-8?B?d2ZramJOZno0K2d2Vko2MlZDNi9TcnJZdGhBQjBPOHpQMTRNekVudEJJOXUw?=
 =?utf-8?B?eUxFMlVDRzJsSjZOY1VEL3pMN1p1enV2VmVqMm9Fa3lNTFVNN2hnUzRORnMx?=
 =?utf-8?B?cm8yYjhCSFU4WE50d0ZWSG9wSjRhRXRVUzZ1dkRwUDZHWUVTY1VzUWoxaHVK?=
 =?utf-8?B?L1lvdmJVYWsvbDhFa1NzODlSbDR1elptZmI4RUFnczVFenpqYll2YkRkU0xT?=
 =?utf-8?B?UWRwbTVRQUFOZ1h0WjJwRHNCMEFKV0IyWndtWjVZWm01dWVaL1dRYXdMbnRE?=
 =?utf-8?B?a0Z4WldadCtsdGhGWnhRVWdJcjA5TkZHM3hLb3RwNjBFWGRFNWx0MDdCTVFH?=
 =?utf-8?B?Mk1yRTB5emFQZzl2UlJidDFEZ2FVS1lxbDdabUJIVlIyUnFsbHdBdVNHL3Qy?=
 =?utf-8?B?OVJQellPanJ5UCtjZzlBOFFLZ1VWWU1hVmxJTFVrQjhsTDhYNGFxSHZ4U1BH?=
 =?utf-8?B?MzYxL2piNjdhM1VLUEMwRU0xN0Y4THdGcWpFZTFJd0pnWHdVUGRQbXFYS25C?=
 =?utf-8?B?NWN4Qng4dkRuN2YveWRFU0JSTDZRUURCMHNhNjBoVGNQOCtHbFFVejd1a0ZE?=
 =?utf-8?B?d1kwNlV3YXY0bjhPQVNkdmNSNTlTOFlyM1NIZ0xXalhKZmgzSkJieEpYeVls?=
 =?utf-8?B?bjBjVDRvNXpHYm13d2FXZkx5NVJyWWFvYWFEcFRCM2pTeTlOYjFGQWZUemFC?=
 =?utf-8?B?NjNGZ2tVeiszT2NVSXNvVlRFRFIzcENPekg2SlpmTC9FQWQyeEppQlZHVFBW?=
 =?utf-8?B?cEFZNXFReWF0NUdHWXZEaDh0akY5dkZJakVDMGorM0VoK2gvZGozTksyVnNM?=
 =?utf-8?B?QnFDdzMxTkRodGY1VWFCd0h2V1BUdDVTd2R1Y0IrM1EwZ0JJdWNzMzF4ckNK?=
 =?utf-8?B?K2x4a1NQV1pmeS95L1hObm1OTStpVWJnQ3QraS9SK0VEVXVDYUZIQytNTnJp?=
 =?utf-8?B?Qm4xUjFNQU5ON0daMUdVMXgxNkhXeEFMcWZMNUNIV2Fqb210WmlwMGdmMGlF?=
 =?utf-8?B?N2ludU04ZmVzQWd3MlJMbW12NEJ0cmQxdEN6dGFaWThsT2todTJmOG5NRHMw?=
 =?utf-8?B?TGFWalNsU05tY0h2Y0ZTdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnJjUjFXTkxvMEhuTW1xbU8wbjRub2RTWDBoQ2szWmN6SkxnWG9uSXhuWHZh?=
 =?utf-8?B?Nk0xNUN1SU9KczMwb1Z5OUtBSGhNejIza0w1djRzNC9BNksxYkw1M1A3SmRO?=
 =?utf-8?B?Nkdta09RbDlyQTNuclVEV2Qwa21KTE5YVVozejEwQXg1VDVBdE4yMjhzVVBt?=
 =?utf-8?B?ejFCdi8rSWExN0lra3huOWo0WG9ibmd2T3Z1a2I5SzJuY3ZuTmxEcFl0cUoy?=
 =?utf-8?B?aU1tU0pud1h3bVVCRTdDMS9YZDJ4Z1NHdzNOUTFhdmpXc2o0YnZXS1FsZjV3?=
 =?utf-8?B?TGw2R3F0bUgxSStSQXpUN3hraUFQR0tQelNlSTY2VG1TTmZWajZQTFBCNi85?=
 =?utf-8?B?YU5PKzloQmoxQk4xT2N1aVUyVktCOURZQmRUeEd3OXdORzU5dFVvckJrVjYy?=
 =?utf-8?B?OS9FdTB6bnlPdWozMjl5a016N0lPZ2JkeTlxV1lsdnBCdEtFU0hnWklNVDU0?=
 =?utf-8?B?WkhubnVhdVViZlRhMmtJMlZnNGxMKzUzRHJZMHpBQW5pamprczZ6Z3JNUG5C?=
 =?utf-8?B?dUNwK0svMk5OaGRTRVdncEV5cFNSSDdyWXdrZk5pMUNqdUJQQW1kdWFVZlhw?=
 =?utf-8?B?N2tYZUU1cnlGT1BWUy81Z1BsYXBDVGt6bkVhSi9IdFoxWGVNeTZpV0tYR240?=
 =?utf-8?B?QmFsVXZUWHhPNzlvU3ovekE0WlRhSGR1cnZGRlU2NUJaWVhIakNML0s4di9n?=
 =?utf-8?B?M0ZPQkNmSE1peE9DVXcwNHJDdFh2M1grYmFMcXlheWNSMFV2aEZVdWJRZWJJ?=
 =?utf-8?B?aFBxVXg2TVV5aUdUWlVabzIwamFvNkFWWllPYnhWSHJRZk9tS2g3cTNscnlJ?=
 =?utf-8?B?eVEwa3g5YnVIVEV3YzZkS1l3NmhoMGtYVGlOMHlqV0Q5UkU3UG4rV0tBQjZj?=
 =?utf-8?B?WC9KSW52VnFyTkVldUI4Nkh6N2Vha3RtTERPUUlFRUVFRWtOMGJ2cnN4dFl0?=
 =?utf-8?B?RkVxbUlMbjBXcjNlVm1aRjdUR241L3hac3lqSmxLZ2t5azJiN1BGN1FXbUdn?=
 =?utf-8?B?THZicFV6UC9LWjBSU01iUGJXemYzZFF2MjhZZWc5M1pXUVhpR1pnQUNwaXJq?=
 =?utf-8?B?bU8wSDdxdEh0RmUrbWJKblJRbDZGTTBESUtrbXFNZk1qYm9OR25rQzJTaGlR?=
 =?utf-8?B?OW9SVEZYN3BndkpXdE44UFF6NnBtakpja1ZpVm96ZXhsdVc5eW1KQnI1cUFF?=
 =?utf-8?B?NGlUR1RaODRiZ1hSaTVRQXVBenN2ZVpFTHp6N2crRFFOLzQ4V1Jja1FwNVZU?=
 =?utf-8?B?SUNzN3VObU8zaVFOaTdRRDJBbnE0RFNjcEpHY2diYUs4RDk0TFNaR01rK0Z0?=
 =?utf-8?B?Y1BhWnRmZzI5SG0zazkwb0ZPWlMyRDA2cWNLWGNMQ0VJMmloT2pvZThHT2JU?=
 =?utf-8?B?Ujhaa2dyVVhwdXdnd1JRK203S3ZQSjF1aEFZbFlIckhQcW55TzVRUTVDVE9B?=
 =?utf-8?B?Z0hJREV4Rk1LUmphNUZ6RUpoNUFncnMzaHd6TWM4eGZFVlZBS24vUWdUYWgy?=
 =?utf-8?B?dWpJdkdaSENsbGV3Zk56L3NMdGpja0xLRFBpazFuL29HQzJmV0phNC9nSFNL?=
 =?utf-8?B?cCtTektFM2xnN3NrRGdNRnZrbTNlR1hoNDdnaWJ3VTJTWWg3ZENCbnZtelVO?=
 =?utf-8?B?czR6ZDJ6NTFldXYydHYyOVJRVW0yZ0I0NE5GSXpxMHZacHdZMUtLcG5RQW1W?=
 =?utf-8?B?dU1sRlNSS2U3VEhwemwrY3p6RmFYbnFwVzc4TXh0YVoxWXJwNzVVUG5RN2JR?=
 =?utf-8?B?Y2xhTFJsMnBwcTNTMUh4TjNpeFJMOHZVMXJ5TUU0Q2ZuTTcwU1hrcThZNEhP?=
 =?utf-8?B?aHIzZUpiL0Q5NVpRUFR3NUo5SHgzbzhFSTExNk5jK05kK0p0ekFJQkpURzYx?=
 =?utf-8?B?dmlmM0g2QStQRWwyOHdud1Q4N0hyL09YMlNtem45UkxTR1FwZXZFUDBOSTJw?=
 =?utf-8?B?b3FOMDFvSHFRVkhIKzI4M2RCc1ovd2h4NnByRGVMU29DS3JnWDBJSEF3UUVZ?=
 =?utf-8?B?djdCZThHQmFmK3NKNUpxc2lyTmErbm00VmkyQU9Rb25iNjltR3VYY2xmN0hW?=
 =?utf-8?B?Q2pXaXpZYTEyWUdkRmlFUlFFdHVRbUxKS0dIektpQXpKOXlLSkpZZGNwVm0y?=
 =?utf-8?Q?CmIs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806609e7-accb-40ef-bada-08dc5de105b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 06:47:02.4168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZlbOw7/qB8fzFHBlllsdzXO069p+B/JAM1cnCr0Y2w+kcMi6t7fiui8QZDK3Jylsd3W8cut2+uShgiJK6Ra5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9979

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMCA0LzRdIHBpbmN0cmw6IEltcGxlbWVudGF0aW9uIG9m
IHRoZSBnZW5lcmljIHNjbWktDQo+IHBpbmN0cmwgZHJpdmVyDQo+IA0KPiBPbiBNb24sIEFwciAx
NSwgMjAyNCBhdCAxMTo0M+KAr0FNIFBlbmcgRmFuIChPU1MpIDxwZW5nLmZhbkBvc3MubnhwLmNv
bT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4N
Cj4gPg0KPiA+IHNjbWktcGluY3RybCBkcml2ZXIgaW1wbGVtZW50cyBwaW5jdHJsIGRyaXZlciBp
bnRlcmZhY2UgYW5kIHVzaW5nIFNDTUkNCj4gPiBwcm90b2NvbCB0byByZWRpcmVjdCBtZXNzYWdl
cyBmcm9tIHBpbmN0cmwgc3Vic3lzdGVtIFNESyB0byBTQ01JDQo+ID4gcGxhdGZvcm0gZmlybXdh
cmUsIHdoaWNoIGRvZXMgdGhlIGNoYW5nZXMgaW4gSFcuDQo+IA0KPiBCZWxvdyBhcmUgc29tZSBj
b3NtZXRpY3MsIGJ1dCBpbiBnZW5lcmFsIExHVE0sIHRoYW5rcyENCj4gUmV2aWV3ZWQtYnk6IEFu
ZHkgU2hldmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPg0KDQpUaGFua3MgZm9yIGhlbHAgcmV2aWV3
aW5nIHRoZSBwYXRjaHNldC4NCj4gDQo+IC4uLg0KPiANCj4gPiArI2luY2x1ZGUgPGxpbnV4L2Rl
dmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZGV2X3ByaW50ay5oPg0KPiANCj4gVGhlIHNl
Y29uZCBvbmUgaXMgZ3VhcmFudGVlZCB0byBiZSBpbmNsdWRlZCBieSB0aGUgZmlyc3Qgb25lLCBz
byBkZXZfcHJpbnRrLmgNCj4gY2FuIGJlIHJlbW92ZWQuDQoNCkZpeCBpbiB2MTEuDQo+IA0KPiA+
ICsjaW5jbHVkZSA8bGludXgvZXJyLmg+DQo+IA0KPiArIGVycm5vLmggYXMgRU5PVFNVUFAgaXMg
ZGVmaW5lZCB0aGVyZSBhbmQgc3VycHJpc2luZ2x5IGVyci5oIGRvZXNuJ3QNCj4gaW5jbHVkZSB0
aGF0Lg0KDQpPaywgaW5jbHVkZSBlcnJuby5oIGluIHYxMS4NCg0KPiANCj4gKyBtb2RfZGV2aWNl
dGFibGUuaCAoZm9yIHRoZSBJRCB0YWJsZSB0eXBlIGRlZmluaXRpb24pDQoNCkZpeCBpbiB2MTEu
DQoNCj4gDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiArI2luY2x1ZGUgPGxp
bnV4L3NjbWlfcHJvdG9jb2wuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPiAr
I2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+IA0KPiAuLi4NCj4gDQo+ID4gKy8qIERlZmluZSBu
dW0gY29uZmlncywgaWYgbm90IGxhcmdlIHRoYW4gNCB1c2Ugc3RhY2ssIGVsc2UgdXNlDQo+ID4g
K2tjYWxsb2MgKi8NCj4gDQo+IGtjYWxsb2MoKQ0KDQpGaXggaW4gdjExLg0KPiANCj4gLi4uDQo+
IA0KPiA+ICsgICAgICAgcmV0ID0gcGluY3RybF9vcHMtPnNldHRpbmdzX2dldF9vbmUocG14LT5w
aCwgcGluLCBQSU5fVFlQRSwgdHlwZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICZjb25maWdfdmFsdWUpOw0KPiA+ICsgICAgICAgaWYgKHJldCkgew0K
PiA+ICsgICAgICAgICAgICAgICAvKiBDb252ZXJ0IFNDTUkgZXJyb3IgY29kZSB0byBQSU5DVFJM
IGV4cGVjdGVkIGVycm9yIGNvZGUgKi8NCj4gPiArICAgICAgICAgICAgICAgaWYgKHJldCA9PSAt
RU9QTk9UU1VQUCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRU5PVFNVUFA7
DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgICB9DQo+IA0KPiBJ
dCBjYW4gYmUgc3BsaXQgYXMNCj4gDQo+ICAgICAgICByZXQgPSBwaW5jdHJsX29wcy0+c2V0dGlu
Z3NfZ2V0X29uZShwbXgtPnBoLCBwaW4sIFBJTl9UWVBFLCB0eXBlLA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmNvbmZpZ192YWx1ZSk7DQo+ICAgICAgICAv
KiBDb252ZXJ0IFNDTUkgZXJyb3IgY29kZSB0byBQSU5DVFJMIGV4cGVjdGVkIGVycm9yIGNvZGUg
Ki8NCj4gICAgICAgIGlmIChyZXQgPT0gLUVPUE5PVFNVUFApDQo+ICAgICAgICAgICAgICAgIHJl
dHVybiAtRU5PVFNVUFA7DQo+ICAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgICByZXR1
cm4gcmV0Ow0KDQpGaXggaW4gdjExLg0KDQo+IA0KPiAuLi4NCj4gDQo+ID4gKyAgICAgICByZXQg
PSBwaW5jdHJsX29wcy0+c2V0dGluZ3NfZ2V0X29uZShwbXgtPnBoLCBncm91cCwgR1JPVVBfVFlQ
RSwNCj4gdHlwZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICZjb25maWdfdmFsdWUpOw0KPiA+ICsgICAgICAgaWYgKHJldCkgew0KPiA+ICsgICAgICAg
ICAgICAgICAvKiBDb252ZXJ0IFNDTUkgZXJyb3IgY29kZSB0byBQSU5DVFJMIGV4cGVjdGVkIGVy
cm9yIGNvZGUgKi8NCj4gPiArICAgICAgICAgICAgICAgaWYgKHJldCA9PSAtRU9QTk9UU1VQUCkN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRU5PVFNVUFA7DQo+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgICB9DQo+IA0KPiBBcyBwZXIgYWJvdmUu
DQoNCkRpdHRvLg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVn
YXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=

