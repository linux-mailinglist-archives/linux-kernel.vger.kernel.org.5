Return-Path: <linux-kernel+bounces-153062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769108AC880
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2573E28109F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FDD4C602;
	Mon, 22 Apr 2024 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="0x1qRYA2";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="0x1qRYA2"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED194D135;
	Mon, 22 Apr 2024 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.85
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776955; cv=fail; b=J8qWhdutcCr0ioRKQzaCL5neDzDo1Hhj/CrzfP++TdE6FNReG5ADErlMbqqT3agTkRDM3sJK59UuBOhlVObvaSrACTIeXJPCJXCKjuW4iZmABZ8Eqj9YzSPWSdJy2g2KEs0GkioaQSCXRr4tJvLkyL44X8w3TQ+8Qm7jHnERja4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776955; c=relaxed/simple;
	bh=QUzLCQM4Ooq8O5PVv1inZH63LMzEfK7l2SH1mlbJI5M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hqDfJEY8IbQTHKxWnd/mKWerbj1Z7ZEYR/ZzSscJ/3Yh01zttfA5nOmuxObcRsTGYKNSkMpdGTyaiaXqAr49eZD+wmeFtxi6ktOvLfAXMu5mabCNAXIaafpk++ixyPZc5OFRJe3y2anABPrOUag2tQmdfbQVRDBAL05m5LmNoZg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=0x1qRYA2; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=0x1qRYA2; arc=fail smtp.client-ip=40.107.247.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=YtsoDQIeDvvqo2pLmfFWVD9wEFn/TyLx1RrG62HU5+FWk6vAuNWUymKiPu79HChHIyxBtGQE3sXshZPoexfEmzcFC4sATNBpqikO9izfz+LZ4/Q3hLiOlq/iS1KS7VmcDrQQ8ihhkH1cn9HfyZhEj75GYEgO9wOYZZsSiW61atjsdNMJx3BwHmHS35piRm/IumO+Vtlo6lWUJX2/3yzREVPdOWA1DHqUTd7dhVGk/lwVJ9awfImArHRTDgM0mgnz474Nb8CZ3NjZ/q2ayx+KRC1hlq37iO3dJdruQd0RE9qIkKcLjQ04vwqKVrd6hztL44itK0N8Wj0d6tCFUaoSEA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOyZuO2+k15q3dVT/PuMTx+2w70fIF7lB9zca2KBPu8=;
 b=FHBwKmcTbE4JvtPL8XlCbO+zIKtEQxjjC1PCY3HfeezgsJ1H0kUKRjVMjcx4Btesl+NAROCXxi3wU2N66+iJiWA+zDp9r/U4zgNQ5LduEgSV5tyK4LVXcdcvKU8b6Gbc/PmC0Oe2kPAmT/4dqxdCva/u+MNwpP4xGrVRqQODOgcIaIzwEhhL4N4DkCUYSo/GKTFMBXa5AGEMAJjActDTfKSnFdqY60uOUGtUsrZNgWsP44XzrO+keVHGTze//U/t5lIDaoDTJptc0Wk2qPbx04Yv3pcy5RDThEo7MZhldOmK0PB1+vcdRVFf+R4nvld2lhwm8XQPl37dzq6ezkauBw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOyZuO2+k15q3dVT/PuMTx+2w70fIF7lB9zca2KBPu8=;
 b=0x1qRYA29M2QkSCV6DNHDz8PrgnDaDSMMaqmnMJ+CiL7CEvWRe18IGb5bx8VX3x0aXoqlejPWboq3LoCLLyTsKXGSSF3vpeGvz2eJ44D5/wAf2FIFpSQSxWuFvoo0kOmnYAImimuxBwTxLkUrHtDSszgjO/9j4AbUG1GGUyu7Po=
Received: from AS4P250CA0012.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::18)
 by VE1PR08MB5661.eurprd08.prod.outlook.com (2603:10a6:800:1b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:09:06 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5df:cafe::73) by AS4P250CA0012.outlook.office365.com
 (2603:10a6:20b:5df::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 09:09:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7519.0
 via Frontend Transport; Mon, 22 Apr 2024 09:09:06 +0000
Received: ("Tessian outbound e14047529286:v313"); Mon, 22 Apr 2024 09:09:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6d60dc0846416e29
X-CR-MTA-TID: 64aa7808
Received: from 939a57e1403a.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7C154E7B-C68E-429A-AC6C-D3C2EDF0C415.1;
	Mon, 22 Apr 2024 09:08:59 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 939a57e1403a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 22 Apr 2024 09:08:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+I2vUusFzlJ6rgHaDuc+vy29OWEtzadMiLGqjqRIBpkZZMqdO6MeWFq6PYBqyAtFnkfDkQrXvtH8CMPqFI3R3G2SrT4atHpFb0XvgwA0WrC/ets+FurC/N62OyV6Fd8CJp8QXm0AWtA+YA1VjlscZc5S9b7S5dmxvMhrq9C1e5rbrEEODAMAsjiO1fnvLy7gyaFGx5urG2l4G7QtdwIdvBiYrEK/8nhDYs0FQ5g/mPEKwxH/wCg8r/DLjBPF0xcjrnL72SrbyavL1Mof3ttGbivvKfSgXr8Gv6uMLU882INUnZqFYPD7u3/dfODxlulJ+hfup5xhRs+N3o6I5yK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOyZuO2+k15q3dVT/PuMTx+2w70fIF7lB9zca2KBPu8=;
 b=dB6S3PvYQVGOPI1cbWqGJPI8WG40ki3V+ddEeMRXmyW0tPTVz0Q351OMznKuhcGa8WM4zisy2Pmv6KUwXZi++pwXBWA80nUTMKmV1kJmzkFRo9h0yV9z2ntl+hkRL1MBy2ShAYvVtw4N7YiA8OXz8eySwRpZqCMbMGa0kbypvWePnY55goHAHMcIBPtwZYxrudKoR/jA+BynUDC0PYnoBrxfIYPz8YJSx7nUaYE5YNcCoTvixs0+eHrOghkxoVD2reHrMM44dWo35r4YAJyleM+axqcGoqyyNlkzhoZ2AwlKdsvfNpAjSB02LT3uQ5CXac6PnB70JQ8y1iMiZ/qIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOyZuO2+k15q3dVT/PuMTx+2w70fIF7lB9zca2KBPu8=;
 b=0x1qRYA29M2QkSCV6DNHDz8PrgnDaDSMMaqmnMJ+CiL7CEvWRe18IGb5bx8VX3x0aXoqlejPWboq3LoCLLyTsKXGSSF3vpeGvz2eJ44D5/wAf2FIFpSQSxWuFvoo0kOmnYAImimuxBwTxLkUrHtDSszgjO/9j4AbUG1GGUyu7Po=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9884.eurprd08.prod.outlook.com (2603:10a6:102:32f::22)
 by AS8PR08MB10246.eurprd08.prod.outlook.com (2603:10a6:20b:63c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:08:56 +0000
Received: from PAVPR08MB9884.eurprd08.prod.outlook.com
 ([fe80::2a19:f256:8150:9605]) by PAVPR08MB9884.eurprd08.prod.outlook.com
 ([fe80::2a19:f256:8150:9605%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 09:08:55 +0000
Message-ID: <1a78e0e1-af0a-4bb9-8d2d-982e244a1ce1@arm.com>
Date: Mon, 22 Apr 2024 17:08:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] arm64: dts: rockchip: Add ArmSom Sige7 board
To: Jianfeng Liu <liujianfeng1994@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de, sfr@canb.auug.org.au
References: <20240420034300.176920-1-liujianfeng1994@gmail.com>
 <20240420034300.176920-4-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Weizhao Ouyang <weizhao.ouyang@arm.com>
In-Reply-To: <20240420034300.176920-4-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0180.apcprd04.prod.outlook.com
 (2603:1096:4:14::18) To PAVPR08MB9884.eurprd08.prod.outlook.com
 (2603:10a6:102:32f::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9884:EE_|AS8PR08MB10246:EE_|AM4PEPF00025F9B:EE_|VE1PR08MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 45079bc4-c122-4fa8-d35c-08dc62abdcdc
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?U3VnU3lqdVZVOUtxRytlM1lncWtpTGo4YTNOcURXWENWdmtVU3FSUjVCSlFQ?=
 =?utf-8?B?cDViQzF3L2Zta0RPL2R2YkZQb1VDN2E5OFFhT3N0TTlXVXpZQWx2Z2l4YkVx?=
 =?utf-8?B?R2FhcXhtdVdBTE02WlpJdnpwRUJhK01lRDFUOWRlb0cxcndTTVY4S2lpcWYx?=
 =?utf-8?B?UC91Rjg2UEEzZWgrcHg1NDZrME5ZYUxKRzh2ZTFEbElBQ3p2OGJGS2xoempL?=
 =?utf-8?B?czRNcFlvNTZhOVhaL082Y2ZvWmlrSDhRK0lXOGZZT2c5K0dYZzRnamlKSjdp?=
 =?utf-8?B?WFdQbmdzNmRLdnJCQ1lxWDk4bWNxUVhVcTBGcXZpTGlkblpaRWxHSTA1V1hS?=
 =?utf-8?B?c3pJVnhMbTVTamZrZktsUCtlSXlHU3p0WG1PblBMbU9wb2NNZ2c0Yzlnc0lX?=
 =?utf-8?B?d3VYZ0FMZ21lU1NZSWJmV3FCS3IvNkNOWXJEYVlyUVNYTjhpVlhnL3hQMC8x?=
 =?utf-8?B?UUxXQU4vRlhXYTQ2NlVOQjVjaFlUNXdZZ1hHWFE5cUMrWWxrUlhlTjRrR2Ni?=
 =?utf-8?B?djZLbnZ4RGptcmxSR2R0MUozMEJvUGxHK3loY1lXZ2dTRW5LR3lhL2tBWW05?=
 =?utf-8?B?MWpONVRqL3A0MjhDL0U5WlhETm5BeXFJS3R5Y1VpTlEzU2NmQ3Z0N0F1Z2pq?=
 =?utf-8?B?NFJRZG9VVVhyMkp3SlZqNFArRlpiTXJrMllwOXFOeURlZVcwOUk4YlB5UkI2?=
 =?utf-8?B?YklzQUhoSkhlRllkZ2ZYQS9YWGVrRHVSSmlVeHVYdUtjbWpmTjhiaCtLbld6?=
 =?utf-8?B?RHhzS0RXWGQ4ZmYwL0FSR005QnJTcUVwMmMvY0Y2eWxqNkdxQjJaR0hrVUdt?=
 =?utf-8?B?MVR5YVhsYkdldnpUb29qN3IrVW5WOWNnZm9wZi9HYlBwY0J6V2ZUdU1uMSsw?=
 =?utf-8?B?UVdEdXUvQ1RLVFN5b0k4Q0VpR0M2SWloYWZvWUdWYWt1bWovZCt2Vyt2d0ZN?=
 =?utf-8?B?ODVHMjFxTlVDQXl2MkZERGFhc1B5c005VVBBL3VrVzR4SDdvMkR6b3RFL1Jx?=
 =?utf-8?B?SjBYa1ZXRzlNSmxQTGJTYVkxOS9nMFAvcldQeVdRVG9ReFVIdkg4QUIvcXVv?=
 =?utf-8?B?ZTdpRGhVRmUwZWFvQjFwK3hJMHhjSW1na1U1STJKZ1VFN0ZzQys0NERkVW1G?=
 =?utf-8?B?T25GV0hWQlBZbTZTbnVndUczNGM0TWlDZ0NyUUxKY0JjcDVQQ0J6Y2d4SG9T?=
 =?utf-8?B?SWZnaVFYYkVPUk9QNTUzbjg1bFJxUW5aMElTUUpiaHRvUnNVSmdpck9ON2xa?=
 =?utf-8?B?KzFRV0lST1UyeExaZnVGS3RDZ2hJV2Q4ZklCaHdxWXpIdFVPRm1KNXBFV0or?=
 =?utf-8?B?czI5N0xGWFc0VytaNkxoMW4vQ2M3ZWU2WDVJblo5T3dvbU1lYTgvNnNOSllJ?=
 =?utf-8?B?NHBkZ0xvVVhWemxPR2l3T0RWQVpMSUNEN3cyMFF5WElRMWJBQXA4MFBnR1k5?=
 =?utf-8?B?T1JIaGt1Q3AzNGMwakxTb0N1cWI1WlVFVXgyU2F4ajNQazhyUTJobEs2dldN?=
 =?utf-8?B?REZDdXJUQ1pNNGNWR2Z2dGhvMDFWcWdBenF3QlBxa3lPTTNtMk1LM1VGY1hU?=
 =?utf-8?B?VzFmZlM2YnBoOHlOUDM4ZlcxUnlyNmIvemlueGxLV2doeUFkU3ExeWZVeHRa?=
 =?utf-8?Q?3W2X0AH8VLd8B/ZWyu12FschIacSFl7qSXFnox6b3V1s=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9884.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10246
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f9b81518-ae89-4997-dc81-08dc62abd682
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkFWODRXaFJ0MlpjOWpHM0NhYUJkNWJ0aHVOd0w4bEFYMWNDZDJaL04reGF5?=
 =?utf-8?B?SWJCc3k1WElBdlYrSGl2TkJ0Z3FsQTl3b2NMSzZuUFZhbHdhOThZSVhaSUlF?=
 =?utf-8?B?VWxaejdTVG9wK1J5OWV2SXZhT3BLRFJIakRMSGxnWXF1TFpKNzU4R1AzK0xD?=
 =?utf-8?B?Nk4vR1dwc0JHYXhqRzIrOEhIaU5ENGtxREJXa25NV08vaUl5YkNLeGRxNGl0?=
 =?utf-8?B?TzUrWWx6L2ZPc2tPOTdzVVZBWElwUDRwbU0wWXludVkxSHNIR2l3QkRXR29W?=
 =?utf-8?B?SWRFdy9OdmkzMWs3enVCWWVZc1h6YlI0RzdLYkRoYmpFbzF3aTAzOExGR3ZR?=
 =?utf-8?B?ODJFZ1E0Q245NmVRU3lVWWxQQTQwM0ZMRW5vZHBQc2xpRGI0Z0c4U3BtaFBN?=
 =?utf-8?B?aWVSZ1p1TTJocUNNb254dkY5UENpWVZsdE9QSGZPeTJnSytuWmxpdzcyS2lQ?=
 =?utf-8?B?MkV1NVh1ODVrSUU5Zmlpcit0Q0laemZUNHFvalFBeFcvMDh1dGM0WFdoT0VG?=
 =?utf-8?B?T21pU2w5NmN2T3VtNjFJVmM3ZjNaelNyaC9odWQ1NlNUZ2NlM1dWN3Jpdmdi?=
 =?utf-8?B?Uk8relQ3WThTRUJqNnBQTmJRL0VJNUM2U1Eyb3ZXSCtTM21GSmcyQVlXQjkx?=
 =?utf-8?B?Y0M5aEM0Q3ZQbjExbVFQKytYcWZFZnl1TWRjWUY3dzgxK1BweUtXTzY4UU5I?=
 =?utf-8?B?UGZyQU44Zm15c21NZTBic3g4VkZ5aUNta0REYndVN3dMK282ajYvNkVwc2RM?=
 =?utf-8?B?YW80ZG96aVhtdVJrVDZ2a243dHIwaytJRWFMNE1SektyZU8yUzU4UFlaSSs4?=
 =?utf-8?B?R2FFdGdDNGxEOXhGSDNyUHZmNU5WZUpZejZxTEFBQ2pTMDVTdXB2TFg4d2Vo?=
 =?utf-8?B?ZjQyMTRRL0ExdE1vckgwWUVpckw5bnVVM1o4ZG9aMGNNcEM1bkVFbGVYdzIx?=
 =?utf-8?B?TnpQUXNmNkxiUXU0d29tZmxFOXM2anFMMjRyUVIwZEJxaUt3bkpwUmpVMnlz?=
 =?utf-8?B?Q3pIOW5ZQnpOZGZCYXFtYkxlc2VZUjUxRVdPZWNNVExmSUxBN1BBMGpadURW?=
 =?utf-8?B?MVRuOHgvQU9VYUtQSS9KNEt3WTVpbE5Eb3ZJUWtiMUNQRnJYMFZWalV4aDBR?=
 =?utf-8?B?QjJRVGlhaWk2RXVvci9HbkpYSHBUTzhDUDhFbDQzdHdhcjdTd09ST1JkbE9a?=
 =?utf-8?B?TThsZ3luUkNqOW5taEhhY0tva0swQWxKRTJmSEs0amhZSEg0a25VQXRqcFhw?=
 =?utf-8?B?SXR4R1BYSGpVV0lKWUlCS3hnSHNPbWpVVGk0M1ZPVkNyelZ5amRwM3hhUUlZ?=
 =?utf-8?B?cUN5R3RXd2pTODF0My9PWXY5NGhuRnBsc0o0YjNvVmtiSmM1WW5hTis0V1gz?=
 =?utf-8?B?Tm1tNVpWbjlHdHVZNGtnZFEyakFrNHRuaHZjcW5MY3NRelprVkdzQ2NUZ0ZT?=
 =?utf-8?B?VWhNYy9PQ3M5OU5SRHRwZ1FGVVVxQm5FL0gxNTIzbDV5d24wNG9XLzVzTnF2?=
 =?utf-8?B?QkRvZTR1cmduSzhpTEZrR2pUSFpUVHVHUTRPcnpHdHJGajdtRlo4Ymd1N1E1?=
 =?utf-8?B?MGR6RHJJSmF3aGc1VmdWQjlDUjNDL0ZuaExYNVdBT3FxYnA1QVJiR05DSXA5?=
 =?utf-8?B?VTJLWG9iMndlZzZuM1Fwak9uYTZDZHZNRGtOQlJxY3o1WjY0ZUFDbzRabEFn?=
 =?utf-8?B?NmJ5UDlqcXVid2E3dnhPd1R5bkJTbDBOQSt5WXdsUytJR3AwaWZYQUsraTRj?=
 =?utf-8?Q?anS7gTmWpMS98W1CDH31sEcLh6szZ6hJ/cw86sk?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:09:06.3375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45079bc4-c122-4fa8-d35c-08dc62abdcdc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5661


On 2024/4/20 11:43, Jianfeng Liu wrote:
> Specification:
>         Rockchip Rk3588 SoC
>         4x ARM Cortex-A76, 4x ARM Cortex-A55
>         8/16/32GB Memory LPDDR4/LPDDR4x
>         Mali G610MP4 GPU
>         2× MIPI-CSI Connector
>         1× MIPI-DSI Connector
>         1x M.2 Key M (PCIe 3.0 4-lanes)
>         2x RTL8125 2.5G Ethernet
>         Onboard AP6275P for WIFI6/BT5
>         32GB/64GB/128GB eMMC
>         MicroSD card slot
>         1x USB2.0, 1x USB3.0 Type-A, 1x US3.0 Type-C
>         1x HDMI Output, 1x type-C DP Output
>
> Functions work normally:
>         USB2.0 Host
>         USB3.0 Type-A Host
>         M.2 Key M (PCIe 3.0 4-lanes)
>         2x RTL8125 2.5G Ethernet
>         eMMC
>         MicroSD card
>
> More information can be obtained from the following website
>         https://docs.armsom.org/armsom-sige7
>
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>

Reviewed-by: Weizhao Ouyang <weizhao.ouyang@arm.com>

BR,
Weizhao

> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3588-armsom-sige7.dts | 724 ++++++++++++++++++
>  2 files changed, 725 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
>
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 3b2086134..f6fff3fa2 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -112,6 +112,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3a.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-display-vz.dtbo
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-io-expander.dtbo
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-armsom-sige7.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-coolpi-cm5-evb.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-io.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-wifi.dtbo
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
> new file mode 100644
> index 000000000..7acb6b774
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
> @@ -0,0 +1,724 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include "rk3588.dtsi"
> +
> +/ {
> +	model = "ArmSoM Sige7";
> +	compatible = "armsom,sige7", "rockchip,rk3588";
> +
> +	aliases {
> +		mmc0 = &sdhci;
> +		mmc1 = &sdmmc;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	analog-sound {
> +		compatible = "audio-graph-card";
> +		label = "rk3588-es8316";
> +
> +		widgets = "Microphone", "Mic Jack",
> +			  "Headphone", "Headphones";
> +
> +		routing = "MIC2", "Mic Jack",
> +			  "Headphones", "HPOL",
> +			  "Headphones", "HPOR";
> +
> +		dais = <&i2s0_8ch_p0>;
> +		hp-det-gpio = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hp_detect>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_rgb_g>;
> +
> +		led_green: led-0 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led_red: led-1 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "none";
> +		};
> +	};
> +
> +	fan: pwm-fan {
> +		compatible = "pwm-fan";
> +		cooling-levels = <0 95 145 195 255>;
> +		fan-supply = <&vcc5v0_sys>;
> +		pwms = <&pwm1 0 50000 0>;
> +		#cooling-cells = <2>;
> +	};
> +
> +	vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_pcie2x1l2";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		startup-delay-us = <5000>;
> +		vin-supply = <&vcc_3v3_s3>;
> +	};
> +
> +	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
> +		regulator-name = "vcc3v3_pcie30";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		startup-delay-us = <5000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_host: vcc5v0-host-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_host";
> +		regulator-boot-on;
> +		regulator-always-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_host_en>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_1v1_nldo_s3";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1100000>;
> +		regulator-max-microvolt = <1100000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +};
> +
> +&combphy0_ps {
> +	status = "okay";
> +};
> +
> +&combphy1_ps {
> +	status = "okay";
> +};
> +
> +&combphy2_psu {
> +	status = "okay";
> +};
> +
> +&cpu_b0 {
> +	cpu-supply = <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b1 {
> +	cpu-supply = <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b2 {
> +	cpu-supply = <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_b3 {
> +	cpu-supply = <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_l0 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l1 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l2 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l3 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_gpu_s0>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0m2_xfer>;
> +	status = "okay";
> +
> +	vdd_cpu_big0_s0: regulator@42 {
> +		compatible = "rockchip,rk8602";
> +		reg = <0x42>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu_big0_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <550000>;
> +		regulator-max-microvolt = <1050000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	vdd_cpu_big1_s0: regulator@43 {
> +		compatible = "rockchip,rk8603", "rockchip,rk8602";
> +		reg = <0x43>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu_big1_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <550000>;
> +		regulator-max-microvolt = <1050000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&i2c6 {
> +	status = "okay";
> +
> +	hym8563: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +		clock-output-names = "hym8563";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hym8563_int>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> +		wakeup-source;
> +	};
> +};
> +
> +&i2c7 {
> +	status = "okay";
> +
> +	es8316: audio-codec@11 {
> +		compatible = "everest,es8316";
> +		reg = <0x11>;
> +		clocks = <&cru I2S0_8CH_MCLKOUT>;
> +		clock-names = "mclk";
> +		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
> +		assigned-clock-rates = <12288000>;
> +		#sound-dai-cells = <0>;
> +
> +		port {
> +			es8316_p0_0: endpoint {
> +				remote-endpoint = <&i2s0_8ch_p0_0>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2s0_8ch {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2s0_lrck
> +		     &i2s0_mclk
> +		     &i2s0_sclk
> +		     &i2s0_sdi0
> +		     &i2s0_sdo0>;
> +	status = "okay";
> +
> +	i2s0_8ch_p0: port {
> +		i2s0_8ch_p0_0: endpoint {
> +			dai-format = "i2s";
> +			mclk-fs = <256>;
> +			remote-endpoint = <&es8316_p0_0>;
> +		};
> +	};
> +};
> +
> +/* phy1 - right ethernet port */
> +&pcie2x1l0 {
> +	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +/* phy2 - WiFi */
> +&pcie2x1l1 {
> +	reset-gpios = <&gpio3 RK_PD4 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +/* phy0 - left ethernet port */
> +&pcie2x1l2 {
> +	reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&pcie30phy {
> +	status = "okay";
> +};
> +
> +&pcie3x4 {
> +	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_pcie30>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	hym8563 {
> +		hym8563_int: hym8563-int {
> +			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	leds {
> +		led_rgb_g: led-rgb-g {
> +			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +		led_rgb_r: led-rgb-r {
> +			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	sound {
> +		hp_detect: hp-detect {
> +			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	usb {
> +		vcc5v0_host_en: vcc5v0-host-en {
> +			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&pwm1 {
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&avcc_1v8_s0>;
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	mmc-hs200-1_8v;
> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	max-frequency = <200000000>;
> +	no-sdio;
> +	no-mmc;
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc_3v3_s3>;
> +	vqmmc-supply = <&vccio_sd_s0>;
> +	status = "okay";
> +};
> +
> +&spi2 {
> +	status = "okay";
> +	assigned-clocks = <&cru CLK_SPI2>;
> +	assigned-clock-rates = <200000000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> +	num-cs = <1>;
> +
> +	pmic@0 {
> +		compatible = "rockchip,rk806";
> +		spi-max-frequency = <1000000>;
> +		reg = <0x0>;
> +
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> +			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> +
> +		system-power-controller;
> +
> +		vcc1-supply = <&vcc5v0_sys>;
> +		vcc2-supply = <&vcc5v0_sys>;
> +		vcc3-supply = <&vcc5v0_sys>;
> +		vcc4-supply = <&vcc5v0_sys>;
> +		vcc5-supply = <&vcc5v0_sys>;
> +		vcc6-supply = <&vcc5v0_sys>;
> +		vcc7-supply = <&vcc5v0_sys>;
> +		vcc8-supply = <&vcc5v0_sys>;
> +		vcc9-supply = <&vcc5v0_sys>;
> +		vcc10-supply = <&vcc5v0_sys>;
> +		vcc11-supply = <&vcc_2v0_pldo_s3>;
> +		vcc12-supply = <&vcc5v0_sys>;
> +		vcc13-supply = <&vcc_1v1_nldo_s3>;
> +		vcc14-supply = <&vcc_1v1_nldo_s3>;
> +		vcca-supply = <&vcc5v0_sys>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		rk806_dvs1_null: dvs1-null-pins {
> +			pins = "gpio_pwrctrl1";
> +			function = "pin_fun0";
> +		};
> +
> +		rk806_dvs2_null: dvs2-null-pins {
> +			pins = "gpio_pwrctrl2";
> +			function = "pin_fun0";
> +		};
> +
> +		rk806_dvs3_null: dvs3-null-pins {
> +			pins = "gpio_pwrctrl3";
> +			function = "pin_fun0";
> +		};
> +
> +		regulators {
> +			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_gpu_s0";
> +				regulator-enable-ramp-delay = <400>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_cpu_lit_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_log_s0: dcdc-reg3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <675000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_log_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <750000>;
> +				};
> +			};
> +
> +			vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_vdenc_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_ddr_s0: dcdc-reg5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <675000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_ddr_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <850000>;
> +				};
> +			};
> +
> +			vdd2_ddr_s3: dcdc-reg6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vdd2_ddr_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_2v0_pldo_s3: dcdc-reg7 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <2000000>;
> +				regulator-max-microvolt = <2000000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_2v0_pldo_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <2000000>;
> +				};
> +			};
> +
> +			vcc_3v3_s3: dcdc-reg8 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc_3v3_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vddq_ddr_s0: dcdc-reg9 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vddq_ddr_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8_s3: dcdc-reg10 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc_1v8_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			avcc_1v8_s0: pldo-reg1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "avcc_1v8_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8_s0: pldo-reg2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc_1v8_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			avdd_1v2_s0: pldo-reg3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-name = "avdd_1v2_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v3_s0: pldo-reg4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vcc_3v3_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vccio_sd_s0: pldo-reg5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vccio_sd_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			pldo6_s3: pldo-reg6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "pldo6_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vdd_0v75_s3: nldo-reg1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-name = "vdd_0v75_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <750000>;
> +				};
> +			};
> +
> +			vdd_ddr_pll_s0: nldo-reg2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-name = "vdd_ddr_pll_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <850000>;
> +				};
> +			};
> +
> +			avdd_0v75_s0: nldo-reg3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-name = "avdd_0v75_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_0v85_s0: nldo-reg4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-name = "vdd_0v85_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_0v75_s0: nldo-reg5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-name = "vdd_0v75_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&uart2 {
> +	pinctrl-0 = <&uart2m0_xfer>;
> +	status = "okay";
> +};
> +
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	status = "okay";
> +};
> +
> +&u2phy1 {
> +	status = "okay";
> +};
> +
> +&u2phy1_otg {
> +	status = "okay";
> +};
> +
> +&u2phy3 {
> +	status = "okay";
> +};
> +
> +&u2phy3_host {
> +	phy-supply = <&vcc5v0_host>;
> +	status = "okay";
> +};
> +
> +&usbdp_phy1 {
> +	status = "okay";
> +};
> +
> +&usb_host1_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ohci {
> +	status = "okay";
> +};
> +
> +&usb_host1_xhci {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> --
> 2.34.1
>

