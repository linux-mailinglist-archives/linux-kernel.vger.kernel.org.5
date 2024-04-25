Return-Path: <linux-kernel+bounces-158287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83C78B1DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1701C23F51
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2487A86AE3;
	Thu, 25 Apr 2024 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="gh41LO5k"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213E6E605;
	Thu, 25 Apr 2024 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036917; cv=fail; b=jxDEmunFGqkGlG7GHMvtsY9mNAJcYU+Um3gsE8jA/wCVvJ/PG+lO0H38WXPyKVYBEfmBNTKrRO2qHI1V2PL7Miozezs6t/htHIfBEAGFmF4pTjxOwLwLVq7tmL4RvZl5Hno5szwP0tyLUG2dL+SMMDx+AWZw7mQ5BdOXnUYAa3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036917; c=relaxed/simple;
	bh=Y5Gmv1CLIEQRAuCMQk3dA7naLHwxR7kXcjxrtXoB8qw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PHbTLj6tQRuEbmVA7ZjB+5COzFDtSNVlQgKAF3lBTV4vmf6vALP2ClC823f4g7zXnRBX0exYd4i/34g8nR5xNXsjOEusIx5b7kTxQiICDp6sxCtd7Sje0fWC0iWBfROzgLqc7ykPtVBnBQaIYmnFF/ZfGYRmwZOkz7UG1kK02hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=gh41LO5k; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P9FG1n019220;
	Thu, 25 Apr 2024 10:21:11 +0100
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011007.outbound.protection.outlook.com [40.93.132.7])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xny4n99f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 10:21:11 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrRVz8bIEiyC7EYPsYLQWFSORnZ7jhwctlbhINBzrE6799Z2vLGfnSRZ8kBfWWHSnRpQ4R94dxXxPtql74hpSzHfdc5juZ+/CfCkOdXQZH9RP+QDCSK2DJhY1LP1t7YaJsKO7ZJq1XAYM1tTq75C3eC/syVyUfcG3sUQKAt7KrUNPe+EtyuSz1E8OsDAdxHwVyUKVGaTE4gTC4j/KjBzAqg4gz9mzwoSFgOsxD08XXwFwGaZ6GRjr/UjNkedeOjJpBKDthtJCdOLQTBA+8JhU61igqdoii5OH8feticfL1ELL0I+CrkOJ4Yxs/8UUbQ4Bck9vQ55f+CMLM/6z1Q83g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgamFm34dKg5+jQujJYzyn1bQPjGPryfXA5AZZ4mWag=;
 b=Fw/z5Ljcer+jRvgyH8G4zLes0ckKHgSaRXPEWMoyLQPGoHoORN2GAcdlIsDzzTTu85pZtwerRPoL8oZjtdtMDqdMIZ9RfrUpw8p6piSB7vV3L/0EI30gMY7GnjVAyDobUOmmh8fOxg6OXPEGHQI4UQzWPikrdCVV/cBy6E759viQyKm1eJ6HMP2Glf25KH8WTUv/Hr8JR/Bh7mfOC6P7PTWHuTtAHX/IDCgToRzKce83BwqBHZvB85hvRdDaU2/j53XjX1gs+fy6XuY7RSFfoel/OMvMZBGTkiRWFuKH59FXDEiTQJVgBS5koywwUKhaUO9X8fVdNAlsmL4X9ReuFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgamFm34dKg5+jQujJYzyn1bQPjGPryfXA5AZZ4mWag=;
 b=gh41LO5k0zJI2fCXPd9+WSPASgzgtqdhhFCQB9A1wxGkRl8n046MkkcR6Cf154iQO5POTAnR+hV4KCw5SL2Y8GhtsSo344V0lB+YQzveZDrXc4znidGYnx5DeAhEVQVem3UNHR4i35hUJsvfRBGcCbdWeC3pvQL+H/eNZM8Aqio=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN3PR01MB9343.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 09:21:02 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 09:21:02 +0000
Message-ID: <17953924-bf09-4eba-b8d6-1f828f39c0a2@blaize.com>
Date: Thu, 25 Apr 2024 10:20:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "olof@lixom.net" <olof@lixom.net>, Neil Jones <neil.jones@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        James Cowgill <james.cowgill@blaize.com>,
        "heiko.stuebner@cherry.de" <heiko.stuebner@cherry.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "macromorgan@hotmail.com" <macromorgan@hotmail.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "u-kumar1@ti.com" <u-kumar1@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com>
 <20240425091403.17483-3-nikolaos.pasaloukos@blaize.com>
 <f45a76b3-996f-4204-9b9c-289d40767708@linaro.org>
Content-Language: en-GB
From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
In-Reply-To: <f45a76b3-996f-4204-9b9c-289d40767708@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0348.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::11) To MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:12a::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB10184:EE_|PN3PR01MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: 682d651b-c115-4f91-24bd-08dc650906ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|1800799015|376005|7416005|366007|921011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NGlETi9DV21vQjhjaWxSalpyRzhMb2tvbFovTHlTaVdEZDE3aCsyM3FaQ1lG?=
 =?utf-8?B?cGhEZXE1UW81a3NuVEdUNDI5dzBZZG1zWmNSWVk3RjN0YTBqUmdhVHdtRFZE?=
 =?utf-8?B?SWx5Rk9NaHFlMWRwQUpQeVdPaXR5d3dLYVFiSXMvMDEvbzhlbDNobFM3V0ZC?=
 =?utf-8?B?S1p5MVVGV2xlOUx0eEcyTDdRZTBId0ZrSXZyMTJrNmZQS0NBOXh4RkovWXZC?=
 =?utf-8?B?cnVoZmpZcnd3Um9vaVZacjRiYTRZSURYMmM1RHlGMUhyWXNGRzFBTmZxcyt2?=
 =?utf-8?B?R0w3Z3hheEVRVEltT3huOGc1TWlOSTNEbnM0ZUlFQlFHTW51dlF6SDRKQncv?=
 =?utf-8?B?Z2c0dGxzUXptazFpQUlwNTJURmN4bWgxTm54MmU3eU1GOEVNbGRsaDBnOFVy?=
 =?utf-8?B?RmdZR1pHL1RtZm1KNk00NnA3bVI1Q0NXUVQ2OVpNM2pvU3h0MW10NTR2NEVm?=
 =?utf-8?B?L2VCWG5zVDhPd1JzcWFLRWFtTUUrV0xTZEI3VG5mZjBsNHIvS3dyTUNtbUpr?=
 =?utf-8?B?S015UmR1elhmajRDcFNhQmdzQTVKem9tMlVmOUxMY3FuMGxmWlRiWFpLYWVL?=
 =?utf-8?B?OTBMTnE2ejhwV000TkxzUkhKY3RaOUhIa3RGQmdUSDNRYXltcVgwQUdJM1g4?=
 =?utf-8?B?bmFWZW1kNFAraEZvTWxzb1RFSFlhamRzVzNPZGJjVnUyR1k5RVFKdi9NWnRp?=
 =?utf-8?B?NklwSmxzNURzMGg5TTZoKzFrdG0yR0dzczJuYnd0Q202RFRKUDdhRCsxRHRE?=
 =?utf-8?B?Y0tLNS9sOGVhTUV5WTF5Z3FlaUZoVk91c3lLZXB4dkh6aU5PTTE0b1o0MXI5?=
 =?utf-8?B?aTV0VDdQS1J5QmxuT29KdHl3ZHR6d29hVmswU0xUckIwVnNuTnNDb09jKyth?=
 =?utf-8?B?RGpRbG01bG5OeWJ1em1FMGY1aXFrU21JMDdsTy83eG1tSVo3MHNRenM2WVho?=
 =?utf-8?B?K1FnQmwrYWdpMTY0TDRkT1A1cVZnSEQzZHNvSnVoMG1HanYyQUJ0NlR0YVRa?=
 =?utf-8?B?UGlJQnJMWTNNa1d5ZVkzMUltbEhsTXV5ZVNadDZZRlRCYjFzWE5LWWVoL3lT?=
 =?utf-8?B?QlJIcWFRTUhPRTlFNW9peXV2UCtqbEtTYnhnUmlWVmkzMFBrZ2crVDdTeFpn?=
 =?utf-8?B?dTlRbTZDZUdOVUkrRE9HdGxjeEZiNG9XZDFDRGxSd3QyWkhmZE9ZVTZrVS8x?=
 =?utf-8?B?aHFjclU4UkZQSkF3K3FnU2V2OUlzdEZFdmo1UDVDUlNOTEN6S3ErWW5laHh6?=
 =?utf-8?B?YW9YaFlFYXVUNFRFUXU0RFp4RDJGVEhIV24yc05Id3RLZnl2c2F0ZS9MbUhq?=
 =?utf-8?B?TDVPS0prVDNDNld0ajFsVktTclNnNXRhRUNGczRzL3hqQUxWRzN5aHp6VjY0?=
 =?utf-8?B?NHFHQ3p0NUtsMWZFZ0pzYkYwL1VVN3lVUC8zMG1aV3JEM0FzR0NXSTRKMUU0?=
 =?utf-8?B?WittL25RQXZnVHcvTGhmb244RjlhVHkzb1JLcldpWGU2MkhyY2lEYjBXdlo4?=
 =?utf-8?B?bGtJcHFFVVVOOWdiK0lFVXZLamY5ZGg2SmIzZUF6NllCTmhyNk91UGdNdjEx?=
 =?utf-8?B?WnhhK3NSQXpnNG14OGhHWjVvLzFYclNtNkhwRXN5cFU1WWZhb0cxSUcvQXZ5?=
 =?utf-8?B?aWlUc1dudVM2V1lSaS9NTHpBWFJDRUtqN1VuNFhtVFZEK3ZkVno0VlI3RTVY?=
 =?utf-8?B?WnNkUE0rY1B4TGNJL1NoK0xCM0d4QTBxbFExbE0zVm5HWEdUWU9OQ293PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dWRORmVmZ1FkMmhXd1gxaGdJNEkyUGF5WFRtbWh1a2t1dWdqcnp2TVE0cWha?=
 =?utf-8?B?OUp2VWJZL0FIUjdUWlA5OTEvMklCNjUwd0pZSnI5ZVdodXhsWjFtUTByZE1m?=
 =?utf-8?B?REFPWGQwNFhmTHZqdm5peWVGcjFQODMxYUl4ZGZvSGh1NnVjK3JENXdwTHFQ?=
 =?utf-8?B?MUhDK2ZHdnZFeU9pelFSb3FDeFFqQ0NvYTZJalRIN0MwMFV2YU1CZXFFWm0z?=
 =?utf-8?B?VDQvSnRHV0VQWjhaV09GWXd4amo4TW4xcUNnZmpWTExyV2JXekVJd1RTZmJw?=
 =?utf-8?B?S0t4TktmYzFzMjNDN2JPMDlrT1cvV010MkwvTlNqVjlYVWNsaDczNGxSL2FG?=
 =?utf-8?B?TENnV0VUdmtrV3NIZkN5bVFRR3ExVm1qUVNMUFlvU2JRZjllajFla0xQcEpV?=
 =?utf-8?B?TVZrS2VMOEFwVUlMcTY4NU01V0l4TGtrS1N6THd4MlFHTXU1T3JqZHVzQUpJ?=
 =?utf-8?B?UTJidDcrOS85N2dHcUoyRGFWY0VyT3Y0cXZ0ZGpORi9FRDBnVjhuM2tQeW5l?=
 =?utf-8?B?ZTVTTmJrTDlYZytUN0VCWHAyOVhnQ1lOVjZ5VG9NVjFZcUt0SmxJZGxrbkVJ?=
 =?utf-8?B?d3drcjFZMkZKQnJpM3lKczBDb2RZbUVZQk5maCtjcEplN1FJMVJ6OVNmaDh5?=
 =?utf-8?B?ekZBMzJ3V2lEalo2RVMwWnlObkhSTXBtdTVqQTVZZnFXZElZV2pRRmxnL0ZE?=
 =?utf-8?B?UDZicHN5azNJV0JCQTFTalI3WXJjSnlZM2dycG1nRkJuenBzdkM5NE81ZDRQ?=
 =?utf-8?B?bFlrVVRMSUUzVllGV0J5YW1UT1gyN2NmL1Q0dmtQbElRRi9uSXg0QU5PMGZh?=
 =?utf-8?B?Y1VKb0FwRzdwUnZDZHcwS3dKeUJlUmJxVHZ6SytkZ0Z3VXV0Ums1dnhrNXVF?=
 =?utf-8?B?MStCSUtYVWlVMkNXUXZBY1JxSGpGTGJqRWw3QlRMM1JnWXE3bCtCS3NTcXkv?=
 =?utf-8?B?UStoMFB5SjFnME9ZWnNUV28wbEE2UUlNdUJxRjJrTitZcWRqWTU5S0JMZWVq?=
 =?utf-8?B?Zy9PN0Vvbkh1dk5YOW1xN3kwVlZRbjU2Sm1JSnQ3QTlwZzZCU1ZlU2J6eTZR?=
 =?utf-8?B?Tk4xWDNwalo1bG14WkkvL3VkTG92VGE2ZWdzYjZvbXlzRHZYSER2WUV4dDVB?=
 =?utf-8?B?RVlVTUFqS0NUaEk5RVhvbEFMQmFkaFNBbmZMbHdKV2JWWG1jTjljQjR0VFNt?=
 =?utf-8?B?UW1wbXp2WEdoNk1YL2xmS3V3UlV4ZGREZWRkZ3llc2JMelFNYVpZZjBVYjhW?=
 =?utf-8?B?MHJOZ0NjVHlMUlYzbmt6Q29YN2FpM3JnZ0h3S1hyS0RIL3AzU3BKOC9aTFZj?=
 =?utf-8?B?YVduQ2V1Nk9uQ05ETmI2ejFod2FmeE9WajJ4Z0llN2pFTGRuWWJvOS9TRkY1?=
 =?utf-8?B?MHRUWXdHdXhqQkR5VngrYmNzcUlxNU1KU25rSzU2aVRpZ2t6dGVTeUdZQjhU?=
 =?utf-8?B?T0cyYVc2Sy9NS2ZESE1yRk5vZ1c0WGhUTGVkQ3luSVlzd09QR3dXTG5YOFZD?=
 =?utf-8?B?dWF1U2x0U3lIMW0rUVg4aEt2VFRqM3pQcHBCajhpamxBNTN6WnRqVWVVRE4z?=
 =?utf-8?B?ajhYd0w2SjJtSWxNdjM5KzU2OXJiQjJINmdhaHljRmdHeTBBcUJCeW9pMEN0?=
 =?utf-8?B?M3dEcjB2UzdhaFRwQ0g3bHMrZnhwUy9wdHNoOGRpaUhOUW1sOE5sb3hlZ2Jt?=
 =?utf-8?B?Tnp4eUc1aHFsZ1QrYmRqQi9uT2lvTVdrRVRSWVdPaDdrdElOVVI4dTU3eCtI?=
 =?utf-8?B?QjlsTXF4OWdRYVEyczZWZ0k2WGp4Mnd3ZTBWQVhzM3ljcFB2VGgzQk1xMzJr?=
 =?utf-8?B?ZHI1ZHNsclEzTkdqOHMyNG1BL2FNTVYrU3Bmdy9YVHJhZjdMelA0WUhsYWNM?=
 =?utf-8?B?aXo3QmVsblZtUzBEaEFSQWUxY3kyeGpnSDhNeVBkZVJwN0p1TEdaeVJvZ3Rq?=
 =?utf-8?B?L1pXRk5sa1NQbE1hYUZKZ002cXY3c2M5elk0b25MaENSTUZKamxCbFRzek92?=
 =?utf-8?B?cHRyTzZ6ejFjMGQwZElSNmVXNm9kOTdqY0tINVUvb3NVUFdhUXZWM2pHNU1C?=
 =?utf-8?B?Y0JKQjhDclVMa0FPejByem9pSlQzNWNLdDJWZXh3SWE3Q0pxUnpiRDVxNU1B?=
 =?utf-8?B?TjFWSGZ6c2RDS2w2ZzJWUXV5Y01na1JoYUlPaXNsYUVOaXZhNkNZMUNNY3J0?=
 =?utf-8?B?cTZkN1NqK3NQSG5MN2dDbUxBcDN0V2ZmdHlEWUlUdUNWT2lIanF0MkV6K0pU?=
 =?utf-8?Q?/es5XWe9O2dL9h+ZYmnuTbfZYZA1FVw7k/m6fWjlkc=3D?=
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682d651b-c115-4f91-24bd-08dc650906ac
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 09:21:02.5045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+HePL+n4ahxUVEI0YVw7UW80K6CD+tFW4t0Xe8cVMUKiseMdKF7tq05cNDYAC/t7uQ0UqI5Efbwt03rEv/R1Tf6maSeDEgP+Bc0co1tWSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB9343
X-Proofpoint-GUID: fcLep7KfcQ8bYnncS_hEScPJWp4opmE5
X-Proofpoint-ORIG-GUID: fcLep7KfcQ8bYnncS_hEScPJWp4opmE5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_09,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2404010002
 definitions=main-2404250067

On 25/04/2024 10:16, Krzysztof Kozlowski wrote:
> On 25/04/2024 11:15, Niko Pasaloukos wrote:
>> Add device tree bindings for the Blaize BLZP1600 CB2
>> development board (carrier board), which uses the
>> BLZP1600 SoM.
>>
>> Reviewed-by: James Cowgill <james.cowgill@blaize.com>
>> Reviewed-by: Matt Redfearn <matt.redfearn@blaize.com>
>> Reviewed-by: Neil Jones <neil.jones@blaize.com>
>> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
>> ---
>>  .../devicetree/bindings/arm/blaize.yaml       | 40 +++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/blaize.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/blaize.yaml b/Documentation/devicetree/bindings/arm/blaize.yaml
>> new file mode 100644
>> index 000000000000..8034aeb7a2b4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/blaize.yaml
>> @@ -0,0 +1,40 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://urldefense.com/v3/__http://devicetree.org/schemas/arm/blaize.yaml*__;Iw!!FddXBOku!i6XKbnL3gXmoklJKfuksrfCB61MTEFuw8JiIVn9sS0CzEmHpqDhXguC5Me3sUQt1gw4RxA4mo8TAHR8psxBV0Dmrs0veWKlRgo18$ 
>> +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!FddXBOku!i6XKbnL3gXmoklJKfuksrfCB61MTEFuw8JiIVn9sS0CzEmHpqDhXguC5Me3sUQt1gw4RxA4mo8TAHR8psxBV0Dmrs0veWEVjMhqf$ 
>> +
>> +title: Blaize Platforms
>> +
>> +maintainers:
>> +  - James Cowgill <james.cowgill@blaize.com>
>> +  - Matt Redfearn <matt.redfearn@blaize.com>
>> +  - Neil Jones <neil.jones@blaize.com>
>> +  - Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
>> +
>> +description: |
>> +  Blaize Platforms using SoCs designed by Blaize Inc.
>> +
>> +  The products currently based on the BLZP1600 SoC:
>> +
>> +  - BLZP1600-SoM: SoM module
>> +  - BLZP1600-CB2: Development board CB2 based on BLZP1600-SoM
>> +
>> +  The compatible property should follow the format:
>> +
>> +  compatible = "blaize,blzp1600-cb2", "blaize,blzp1600";
> 
> This is a friendly reminder during the review process.
> 
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
> 
> Thank you.
> 
> Best regards,
> Krzysztof
> 

Apologies, you are right. Now with the threading fixed, I'll be able to gather all the feedback properly.
I'll fix this on V4.

Best regards,
Niko

