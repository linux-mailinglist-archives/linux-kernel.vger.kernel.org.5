Return-Path: <linux-kernel+bounces-4879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026D581833F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4F12831F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E126411C96;
	Tue, 19 Dec 2023 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kgiIf6wQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A3411700;
	Tue, 19 Dec 2023 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdKZWkgDC0ieP+IvaJwwcx66yqa6iMoSvmVXmGeYgOArgLv5dIX3jkeRi6aSC4jR/P/os6TSS5/kb8xeP2hlTCn+Benx/a7pamlQXHREIA7EIFgFPCRB6fNPu8O4F+n5GBSvtxqAJLXEiVH2R4KkTw43M5O+JLVOmNuzvRZQns/dNTXnDiHIkOzbg5+6R+ih1lKE/AlrDpXBzMgKfYNIe/oREWsvu+jlB+NsZGUagjOqz9oMhSJ/1q1bbDeY+xdidpG9NsBfgdyGPHwVJu9cA1zvU8U5ifDAvutG9J0D/NxFviPFTZtV3/7qpACWZJQ2CqHyD2JE1gLBJyxcL2T2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ES028lRtVV21EyInrbjoFexYv1iVuEU2LMGnNFo69C8=;
 b=GahLPE0+TTtXjhwg+REaB0NpE4mUMscUwGgLmr1FLtHs22x321dPec+0FH+aU8aT5YHvBh+1Hn5Zf2sL/t4jxJzkMc5vHrYJlcfHHQX2NMRpi7obdl/AwyQI01OYGH1vwr9b+nPlVf4G/jrke/Q9GdCnc57fmQYLXRRyN1GcKWCtB7LprRYOGBKlhppKQ+iMpt3i9+kLlhYsJPMc79UwCncA34pqZwOt1TLohN8FphbGGyZFFJG+J+f/NoCk9HPEuK13rKj/qtYT8QmkvgbhsSUqdU9ljHbXoalwae1E48snYjeGLVrLISfwd7KIIses4Koyz7bXhMcoA8wogy8ceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES028lRtVV21EyInrbjoFexYv1iVuEU2LMGnNFo69C8=;
 b=kgiIf6wQMpQLTUWqlX+bhBd1hESfmh7piPprRTpEFlKe9IDEAbk6bjZ63Nv6DoiWB7Bu2r+gfLplu2qSvPZkp9HQcTycdRWt1E/Q34OfwqMUW8kbhEgiwycy/xw35UzDbryaKQ1rnUYaMsd8knKt7Nhq2zdupda93s3z8S9SP19yw0UgPZmVPig7jRpgSWyhoyKWsus3H3qtFgu87KFLb8IyUUvLfJUXWjNU2udOpQG+Q941eTQFHXGGiLgeyo3HqFacOg52RTwVxKDKZjgsIeLPMUJGYECtfOZEIfFn0YGaYPTsOfPvGEniCcT7HyMWwanPdkFyS1n0YyS2Fv3aPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3529.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 08:22:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 08:22:24 +0000
Message-ID: <4c31adc5-3fc5-47bc-9766-6d3d1eeddb65@siemens.com>
Date: Tue, 19 Dec 2023 09:22:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dts: iot2050: Support IOT2050-SM variant
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bao Cheng Su <baocheng.su@siemens.com>,
 Chao Zeng <chao.zeng@siemens.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Li Hua Qian <huaqian.li@siemens.com>
References: <cover.1702917360.git.jan.kiszka@siemens.com>
 <11e0b0c8b828254567a8ff89820c067cacad2150.1702917360.git.jan.kiszka@siemens.com>
 <8b3daa3c-dbf8-4286-b04e-011cd9b0efa5@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <8b3daa3c-dbf8-4286-b04e-011cd9b0efa5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3529:EE_
X-MS-Office365-Filtering-Correlation-Id: cc43fce8-6082-46bd-d8cd-08dc006ba0c5
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vjlbWQwa0ecqwIKAnNWc8yhepFRE3Ge9Tu3EgeW8VgZW3+gZhzEHTQpEsJ0HbyDHw/ZPrR5LYPPazuyCyIfIBi4ClltMoMd4roxRcaP6pYQMy/0akN8AmflqGA6qk6SUNzlFFF7E5K7MKQr6hTpyBVEbnRzUJ5YKff/WfSNQ+mYYcmbPeQj7zkE5joxZLtCD2fGc+sfRFmLy+gl6g4ooYZj+zK9dlcE46Rn7DTOb8hYW3P+bFftY0m1LIXXLnaZ+v2dZb8YFMFfvFv7lqflu8X4qQZPeWf42EALoI0s1IuSeyAFivcPn1snH242pqsaHWKdJQP8FSEwp0AUzmEtuq5EQ7BnKHFOKiehzoqQ1ZBYZQOwR1V8KFboyboeckFzq78Drwz39l6PTP5Go8ClxHFitLuiwvWCDMolpLKfUvM8GHWhsWHg/eHhVg1QmDrZYgCQ97RKqOCDEPA6Kfl7rGmSNpcKuK3L9kDgtqzAqiqbwSI2V67Zh2QRB7xwRsYm+pM/fdKLozq65/xH2VmnP095hs21McaXRdlMy5SREJ81Y/kS5IbVTJPDAq8a9/t8H9WRn/BmMnfslLfGOymmEbMveHKeZL7G14s5eJ/v1zs74SBElzS60vhx1lw3Yht3KURCtCabaKKf34WOE2pfaUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6506007)(6666004)(6512007)(53546011)(966005)(6486002)(478600001)(83380400001)(2616005)(107886003)(26005)(7416002)(2906002)(6636002)(316002)(41300700001)(5660300002)(110136005)(66476007)(4326008)(66946007)(66556008)(8936002)(8676002)(44832011)(36756003)(38100700002)(86362001)(82960400001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDBpa1paZ3Iyc2ZLc2NtaTIxNmhVYVpobzROUDBIVDN5NU1Iejd3Nisyb0xH?=
 =?utf-8?B?OWFlb092Lzh3QWJXQmRoMXp4WEduZ2F6VjFlTTNiQWcvRCtWbEJLWmtOQ1BG?=
 =?utf-8?B?a0kxcFQ5aEp2WU5JRWN4YjNKbTh4QnpybUpLUTB2YlU3UE44RnpIczVaOGg1?=
 =?utf-8?B?cXlXbE92RXZUWGRQTUtld0sxeXlkWXVjT2RPQ2VVMkNjS2RYbS9tZEFiSm1I?=
 =?utf-8?B?M3JtdnFBL3JvaURhdGZLR3B1TE1ISEdxaHUrQUw5cDVmMVo1MGIwclFpY2Fp?=
 =?utf-8?B?QmNCS2hnNFoxRy9LaHhMcXJoRU1mbFJPc3ExZWd1REhrbjA2NU9IU2tXeXRQ?=
 =?utf-8?B?NEE2WXU3WnZNTy8zZFlGa2R5VDZyNWd1NUVxamFRdThTcjU2QmZvS0lnSXNO?=
 =?utf-8?B?dUlVU29sVGtvcityTk9xejdlZXJoOVdZcHZEVE1XRFdxS3F5SGFiY3lpVEJL?=
 =?utf-8?B?N1Byb1M4UHVxM3pLdjR3OFRXaGIyd2M0cTV3NUxxS0tHdlYwYTNBMVdhWmhN?=
 =?utf-8?B?VG9UOGlHNEpHNFFlNTZjQmcxTm5lbHN4c3VOeisrVGcwTFQxb0dMSkpOdEg0?=
 =?utf-8?B?L2E1Q2JNNzUxdzduaDZKUmZNTVkwV1d2MTVXYWwreEJnNVI5L052STVyWjVH?=
 =?utf-8?B?Y0Nadlk4Tmo5SWJ4QlZ3UmxFTE1hcWh0eGhFaExOdTJvcC9rU1NEbjRHb0NJ?=
 =?utf-8?B?NHFydnRVU2hUS0xiaGxtRnpkUjc4QnBlV0pPSFNCd2JnUDl2d3hLSXhFVy91?=
 =?utf-8?B?dExMTmVzOXZVckVpY3RRcjB2UjBzUUt5ZkFnVzBZSW1TWXUrNWw4ekh5SUtD?=
 =?utf-8?B?a2llTFNEN3RRbGUrZ21LakxRM0c3b1JIczNjdUhQaUtVV0FYbzY2d1Z4T01S?=
 =?utf-8?B?UCtwUDJJR0QyNHorTjhkZTYvbEhjM3dsZHZkQWRzcWgySlMyRXNOSi92bVRt?=
 =?utf-8?B?V0FnRmFwUWpFU0VYRXlVZkFQYUlWd3NCdHdXdXRPUjVmVVRGR2NkZTluMmda?=
 =?utf-8?B?U1JsamtmMDhLa1p0VjZac3Q5ZWNHbCs1cEpKNjd4d0dlbDdqcG9Ed0p3dnpa?=
 =?utf-8?B?ci8rcnBPSkZSWGVoVGtaWnRvVkIzUml2M2NsNkR3bFNYNUROY1dZSGVwTkxv?=
 =?utf-8?B?c0VsY0paZlVnM2JoTGdDYzFCUHFxRmdBUmJnVlF4a09MYXlucndjZkJCcm04?=
 =?utf-8?B?NlArcU9nQzdGRlNsUnUzS1ZmeUlHNko5dUZudisyck1Kd2pDWEdvSDFVUzFh?=
 =?utf-8?B?VjdZcEVBNXpVUE1CYm5KTnkxenZreDlrVUZXck9aYlI5dXIwVm4xc3VmMG81?=
 =?utf-8?B?WUZlR3hDU1RqN08zSCtVdUYzQjVpNFlLQkhkZ2QzWEtweE10T3RSaHZBQlhF?=
 =?utf-8?B?WjNMZG8ralJCSDNjMGlPWFpsTlBPQWQyY0lWUFRFZGs4aUpISjZHcjBaOXdn?=
 =?utf-8?B?WUpuc2JRZmltV1Y1RzhySjRKYmlzRTJpSzU4QWZwdU9WNWo2bzdOMlhFVmZm?=
 =?utf-8?B?M0dldGttOW1zbHJjOFR4ZmhsdWtBRmVXMUM2YnZDUXJWeCt0RXZoVkoyR2Rx?=
 =?utf-8?B?QlFsV2VlUWF1YlhjSWNmUDQ1VXM3OXIzd0dIdjZSNENVbnExQXZST3hMWTJa?=
 =?utf-8?B?QURpR3IxRk5oc1lVcUtrTkpMYzFtSUxvb09JVms5cjJaaUwwOGxhS2RYL2Fq?=
 =?utf-8?B?RDl5djZPS3JoS1dtK0Vkd3h4c3NvQXMva0hkME84WWxSazhNY2Vsb3NSZWhv?=
 =?utf-8?B?cExZQkxjT0lmS2NJYnBVb2o3ZVZhWmJhNmVoVFFCZEdsMUNkSkg1eTdydEFt?=
 =?utf-8?B?bERDRWtLcGlZL0JVb0xnc1d4NHNtbE44T0VDeTdkQitZUi8vZDB4RzliYlNw?=
 =?utf-8?B?R3JzQjZiN1hYY1FuMlJIL2RoaEk2WjF4MkNhWmNYZ3RxYS9jNExobDJHWFda?=
 =?utf-8?B?bFZ3dzNWQ3VsL0xvblk2M0MxQUw5cDdPUEIzd1l3ZU90cWVtRmJsUzdUTVRt?=
 =?utf-8?B?N2d6bVYrcTBzWHJOb2J3am1DbytTZjFwS0dLVjVxcEZhSUlyTGp6aW0xSEt6?=
 =?utf-8?B?dVVkSEkyVzJrbnFQSjl5Sis0SXFDWTNBcE9iR2ZzTUowWW01SFBzY04xQ3RC?=
 =?utf-8?B?a3MxRnA5RlhZTVM2ejBMUnFveGpwTkx3cFdRME0rR25ReDhtbDJpZ2kzNWMw?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc43fce8-6082-46bd-d8cd-08dc006ba0c5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 08:22:24.0725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jDpJu+K6+ToyvER4EncQUY6FBa0q6FQV559GDeFUXk6wR3PE24r3ysWX0wlM+xk99TazCxKfc+nyeIFHsYcrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3529

On 19.12.23 08:54, Krzysztof Kozlowski wrote:
> On 18/12/2023 17:36, Jan Kiszka wrote:
>> From: Baocheng Su <baocheng.su@siemens.com>
>>
>> Main differences between the new variant and Advanced PG2:
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
> 
>>
>> 1. Arduino interface is removed. Instead, an new ASIC is added for
>>    communicating with PLC 1200 signal modules.
>> 2. USB 3.0 type A connector is removed, only USB 2.0 type A connector is
>>    avaiable.
>> 3. DP interface is tailored down. Instead, to communicate with the
>>    PLC 1200 signal modules, a USB 3.0 type B connector is added but the
>>    signal is not USB.
>> 4. DDR size is increased to 4 GB.
>> 5. Two sensors are added, one tilt sensor and one light sensor.
>>
>> The light sensor it not yet added to the DT at this stage as it depends
>> on to-be-added bindings.
>>
>> Co-developed-by: Chao Zeng <chao.zeng@siemens.com>
>> Signed-off-by: Chao Zeng <chao.zeng@siemens.com>
>> Co-developed-by: Li Hua Qian <huaqian.li@siemens.com>
>> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
>> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
>> [Jan: rebase over arduino refactoring, split-out light sensor]
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  arch/arm64/boot/dts/ti/Makefile               |   1 +
>>  .../dts/ti/k3-am6548-iot2050-advanced-sm.dts  | 210 ++++++++++++++++++
>>  2 files changed, 211 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index 77a347f9f47d..9b15eaad284c 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -53,6 +53,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
>> +dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-sm.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am654-gp-evm.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am654-evm.dtb
>> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts
>> new file mode 100644
>> index 000000000000..ab3eef683890
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts
>> @@ -0,0 +1,210 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) Siemens AG, 2023
>> + *
>> + * Authors:
>> + *   Baocheng Su <baocheng.su@siemens.com>
>> + *   Chao Zeng <chao.zeng@siemens.com>
>> + *   Huaqian Li <huaqian.li@siemens.com>
>> + *
>> + * AM6548-based (quad-core) IOT2050 SM variant, Product Generation 2
>> + * 4 GB RAM, 16 GB eMMC, USB-serial converter on connector X30
>> + *
>> + * Product homepage:
>> + * https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "k3-am6548-iot2050-advanced-common.dtsi"
>> +#include "k3-am65-iot2050-common-pg2.dtsi"
>> +
>> +/ {
>> +	compatible = "siemens,iot2050-advanced-sm", "ti,am654";
>> +	model = "SIMATIC IOT2050 Advanced SM";
>> +
>> +	memory@80000000 {
>> +		device_type = "memory";
>> +		/* 4G RAM */
>> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
>> +		      <0x00000008 0x80000000 0x00000000 0x80000000>;
>> +	};
>> +
>> +	aliases {
>> +		spi1 = &main_spi0;
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&leds_pins_default>, <&user1_led_pins>;
>> +
>> +		user-led1-red {
> 
> led-0
> 
>> +			gpios = <&wkup_gpio0 52 GPIO_ACTIVE_HIGH>;
> 
> Missing function, missing color. Color goes as property, not as node name.
> 
>> +		};
>> +
>> +		user-led1-green {
> 
> led-1
> 
>> +			gpios = <&wkup_gpio0 53 GPIO_ACTIVE_HIGH>;
> 
> Ditto
> 

This is adjusting the existing LED nodes in k3-am65-iot2050-common.dtsi,
not introducing new ones. We can add the color properties in a separate
patch, but the node names are now part of the kernel ABI. Changing them
would break existing userland.

> 
>> +
>> +&dwc3_0 {
>> +	assigned-clock-parents = <&k3_clks 151 4>,  /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
>> +				 <&k3_clks 151 9>;  /* set PIPE3_TXB_CLK to CLK_12M_RC/256 (for HS only) */
>> +	/delete-property/ phys;
>> +	/delete-property/ phy-names;
> 
> If your board need to remove phys from the SoC node, something is wrong.
> Either your board or SoC.
> 
> Any removal of properties in DTS is weird and unexpected. It deserves
> comments.

This goes along disabling USB3 which is by default enabled via
k3-am65-iot2050-common-pg2.dtsi

> 
>> +};
>> +
>> +&usb0 {
>> +	maximum-speed = "high-speed";
>> +	/delete-property/ snps,dis-u1-entry-quirk;
>> +	/delete-property/ snps,dis-u2-entry-quirk;
> 
> Same questions. If SoC has quirks, how can your board be fixed? It's SoC
> property... or you are using different SoC.
> 

Same story.

Baocheng, Zeng Chao, correct me if there is more behind that.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


