Return-Path: <linux-kernel+bounces-161255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF988B49A7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A001B213DF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1018B53A6;
	Sun, 28 Apr 2024 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WMyZgSBf"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A109C1FA5;
	Sun, 28 Apr 2024 05:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714280403; cv=fail; b=uwdMtRc8j0/jicq++nZ+GB7sG7qpE9FgGdyQ2gcZzBOX9f6/osLp1JRiNsVZeotg5Qk0JtfQcAet03AXEyR08mSs7k8V7wnJJsGN/31GPNDk2WLPlWNQ4iVix2cfLZ31tHjsN0hpIOOxcTzi1XoW0ii2/0al2rUgKl+aC5+07oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714280403; c=relaxed/simple;
	bh=vOKo7/odR8hekhkyhiWX0k9Gmh7OQi14krTibbn3X7s=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=VIHo4zGO4dyWNTHW+wBIdEESuA7aD63oX2hfFeOQ6rrQtp85NhaX9gI1hRB8MnXeSz8uoXjibZnU8PDAHdduxBAZCN98bBBmN/pwdFlu0s7IS4XxLswrJI9LpG9y+rtsT+XMu2wtnt105i4S1dmAQpSD5fRPEJVLVuzV4ApZkRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WMyZgSBf; arc=fail smtp.client-ip=40.107.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESaptvpZpSZnz8OmboQnqTn9GAmwemj4lvvWA2bsN997FqNsqzQ9Dw33gRIyHtdojB63ZIIwwIItTPtP1I/mWn9qwrvW7ow5Hf0prxDj8AwDuFVSTTqNEB+F3WJ+mYZ9KC+HZT7UOrN53AbM+5/Gdj4Vn4PQwbDHyjVYsL7v3Y4azUHgkXY6qwnK6aO53QL4G2JwsmXKUng7ol7TrUWjZYazi0qzfOSgt5Qo/r4CzXTXs3kPJdWrnpDkTqCT8mhOQW80rgMQXsj2vhd+sWbrjGuMoQZCIk6w+BS4zZ5UF6+GD8K5OkIXPNdMurC4hF2nbzeyYXaBmvDH3A56wM9gvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KDJYz/RaM7+x0Uj5LtEf7dYd8i1b80eON+juDLerWA=;
 b=N6pHmge8m26Yr/pUXEyKiwS2aSESmqc9Iq4XOFy1ynAkXHDqv9cQ0br/Sfoh9twkvYpFbdMY/qOkKTrfxqWTNCmSOujk/hV3T2vmjc+qsT3AXgIDh22Az0Na3ckGFAPOpOSGl+/4/XMJO4HEsyDvizSEMuGvhxbxyjCBObZQzULl5XtTLkaT8fg42q2IktLVYHCGhJ9daynjbM+Pi738ADTX8sTsojfAXRF++r5c2t188QwimGuh0ybvIYD/yUlFwZt/+5/ZU4Yjwds+hvUaN/mEzMJmttDXCzrC/e1saVc6jBXdrgmWgij04nCyB5IAuQUjqI1kPqMrc5In6wlYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KDJYz/RaM7+x0Uj5LtEf7dYd8i1b80eON+juDLerWA=;
 b=WMyZgSBfHv8JOkIX3Y7PQyLen2d/7yeQKmeI9EBNGqPGie1exweZxFsKZ67gYDon+qwthuVD5mQVrtZXaDBLNoiPdyP8pkW8PGzTse86ZlyO/dIM8QvjR9qrNpN2S1E9Xf9+hfLCt6iDO3A4dNJaCdoJdcuwPrO+H3bBD3DFO4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 04:59:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 04:59:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 0/6] pinctrl: scmi: support i.MX95 OEM extensions
Date: Sun, 28 Apr 2024 13:07:46 +0800
Message-Id: <20240428-pinctrl-scmi-oem-v3-v3-0-eda341eb47ed@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKPZLWYC/x3MTQqAIBBA4avErBvwD4quEi1EpxooCw0JxLsnL
 b/FewUSRaYEU1cgUubEV2jQfQdut2EjZN8MSigjjBrx5uCeeGByJ+NFJ2aNUkkthJZ2MB5aeUd
 a+f2v81LrBxXHCO9lAAAA
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-gpio@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714280885; l=3915;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=vOKo7/odR8hekhkyhiWX0k9Gmh7OQi14krTibbn3X7s=;
 b=mgHPmv0Apm6V1enrdtwj8U0J2a41tRJDvI1ly6q9PcBk+KF4vdQEarKOCEx15x+g8jhifOm+x
 7Rc13a3b5HXBgDqMLgyfe8AiRQUv3JgZdCcYL9bEBwCDDLX4RiAB5pJ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0245.apcprd06.prod.outlook.com
 (2603:1096:4:ac::29) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: b90c64fc-118e-4499-756f-08dc67400c75
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|52116005|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjJocTNqOThrWUdySE9LMkY2czRzTFVNclNsbk5pOEIyQjB5bVhFWkZEWVph?=
 =?utf-8?B?VTFnMlg1eUdlSzRzanVhOTUrNDgwWEx3aklsOEdnWmpZK0x1TUFuVExmQkNY?=
 =?utf-8?B?N0xDenVYVm83STVBdlF0VHpiZWtCYjJQV0k0ZmdhbmdYRWdKOHY4a0xueWJL?=
 =?utf-8?B?WTlwL1hoSzJ0di9sMjJtdjR0d3NpR3FSbnRaVFpYSWg3eGdVV2l1M3FxRnk3?=
 =?utf-8?B?ZFM4ODJpYlZ5aUp5OTh6bWVHVWVXZVBZQ21qWVFaV2dpNTdwMENYMXcwQjBD?=
 =?utf-8?B?SVYzMmtudW1Za3Vubk84Syt3Q3RqVGZhMW9GVmZpK2ZHT25rNng1ZFVDVEpX?=
 =?utf-8?B?SkNTOHByajhoRW1QbjNvZGZGMjFiQ0VkREJqWi9wd2ZpVjJnOTNuTE9hVThl?=
 =?utf-8?B?MFRSRkdXSENJYmF0TkxIdWVid09UWWI0L1ZvWFgrMDdQQW9ISEtxYUpHYnJo?=
 =?utf-8?B?bUV0ckdrODhnSlpWZ21keXYyUDhLWTNQclVoRmhoSkNRU05wMklBOFhCanRL?=
 =?utf-8?B?VVpMa3dQaVM2SFZzeHVzb1FiYlozcFhCMXJ2dmJaZ2lUelRIWHJvV2tOT1hX?=
 =?utf-8?B?NjFNOU9KVjFtMEFsam1pRXFrdkcyWUY3MEhqSTJhYmpQeThlL1BFLy94clRV?=
 =?utf-8?B?cDVFMWRNZlBISWI5NVlhRk5GUnhjYjk1VWIzcDM0VTBVdjdWaWEzSVFEMVB2?=
 =?utf-8?B?QXY2MHNNS2l6Q2EyYmJIWktJa2YyL2Z4aDhkRHR1bW42dzBLWERNQ1E4N2Jq?=
 =?utf-8?B?Tis0MlhCWDFsSWtvZE1EcjFRalhFUTV3Q3NRRWowZE42aVdVQ3hBTGRkUUNp?=
 =?utf-8?B?TWFNOUQ3UHYycWdpQWpKOXVRdU1aSU5pUTZ6OWVTTXJYWWJZTDNsZUVDVnlY?=
 =?utf-8?B?Y3g4VDFtbDlsSzF0VGhxaElXenl2ZXlzTGhBeVh2V3diN2YxQnEzNFd5ekRB?=
 =?utf-8?B?LzlEUjRpUFljb3JEUkt0SWIzMkdaMm1QMjV0bmo4dytjR201WUxKNk1nVnFH?=
 =?utf-8?B?bmdpaHFDWE9QZzQ5cVF2dVJsMi9kcE5nQ1N1TzYxU24wNDRNcHVYL0hYd1Fh?=
 =?utf-8?B?NVA4OE55bGdwQWRnMEd4czY0Q2N2QjN4M3Zhb0hlS0FiSG9YQ21lZkZubll5?=
 =?utf-8?B?YkhwT3VDWFNaanRFY1puNFRHRXJGL21mb0MzTytVcUtKa2ptelJtNE5UN1JF?=
 =?utf-8?B?aGRUeTRlODIwYVFJdHlLQ00xRGt2QmpNc3lrOTAxTmNKT0s4RnZmRmttSE12?=
 =?utf-8?B?WDRjYzlvYXVYdFQ4cmJ5NzFIMWNMOXZOY3RESFBGbHZERXdnMlU1QUpwY05s?=
 =?utf-8?B?cElYNTVtWnBRdkk2N1pYbGp4YStLLzNPN0JIVjRIUGZjbUorVkRlTndrVXYy?=
 =?utf-8?B?ZEJPOFI1NGhNWUN2V3RHczlVbTdPb0F3bi90UVZ5UzdXUi9aenhVbjRCZ1hM?=
 =?utf-8?B?bzBkeTYvRWlZb0xmYWEwYzlLYmFPdmJlbk1QZnhCV08xdVRWMVdPbFp0Qmk3?=
 =?utf-8?B?T2xvaDZRdG8zdTEwRWRjZWFQWkgreTltUldjdUdOYzhwZWhQNDFUK1l5ck5G?=
 =?utf-8?B?ckFzczRiclR3RU1wdVFRL3RLbTFSOERlcVE4WURnZkNabDNOcFdxUFEzV200?=
 =?utf-8?B?RXducjgzZWt5RCtsKytnb0dMMTEzKzVtNnJzdC9DMnlLWkYzVDdzTCtxK09t?=
 =?utf-8?B?NGRiQ0RyN0xpZG5UcFlNNkRwc21hdS9XVVl0RnZDdWF0Smd0a0MzanM5L1dh?=
 =?utf-8?Q?KIRv74uCWXAXvJ0Ulk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTdwOGo0ZGJ1Q21pTlhWckM5RFJXMGlJelRGTStSL0tYT3lGRFFsUDRBUFhm?=
 =?utf-8?B?VnFlOHh5NGdSMlkrZ2lCdXg1UmM1SlMxb1FNZWpnOUxYeHY1S1J4NUtFQnc4?=
 =?utf-8?B?ZzNCQlREUEtmY2RWQVM3M0dxekZhcEFmMnhHNVVFK3FOOEFnRTE1aW5vS0FI?=
 =?utf-8?B?VHYxd001ZEh1alYxWFVnc0owT0N5ODRLanJRLzJmUWpJanFFeHg3YU5EOHlJ?=
 =?utf-8?B?TC9kalY5L2Z3Y0FvbVVpbEY4L3E3ckJuZU9zR3dPNUhXaFg4amUwWkZzT2Nk?=
 =?utf-8?B?OE5lc1o0RVNBWHFITTVZRmxWZDBkd2NZTjhSVWlWUk1iZDY1UEcwTmVDRWQv?=
 =?utf-8?B?ZFJMSCtNR2N4cEptV1p6NisvNTc1MFZWbnNETlZWR3VsWEJXWkdybHcrdDFU?=
 =?utf-8?B?QTV0QlFnaFMxdHVPWjFUSjlrVkdDY3kyRkNXaTJ1emdnYUxRcVlKbXkxWjhW?=
 =?utf-8?B?OUdUMUx4T2dOQklYSmgxMGRtYzV3NTRCRUZaTEtFN1RGbXJhRkN6NXdwTnFi?=
 =?utf-8?B?cnh0M1hnMGpSU3FvUHRMTkkvUFR5YWhJdEUyUyszL254Z2JaWTludDl6K2gx?=
 =?utf-8?B?UGNWcFhkQ2hKRTgrVE91SnFZTmJiMlhEbTVWRXN0NC8xZjdMQWxWM2ZyOUYw?=
 =?utf-8?B?aFB1K1lraDIxWlFCbWNXV1R2dmtjMmZCZDhjMVFaNFFkZ1JWa3VmVmtXdDNu?=
 =?utf-8?B?ZGtmYVE2WFF3R3BuNGpSb1VFMGNGZVUxUVQ3V2dPY0xKVzZ6UU1GSk9lWXda?=
 =?utf-8?B?NTBpMmEzbEFsQmFIWUdFbnc2Ump3Z2QxL1ZGRUg1UXVlanNIQlZreVBtNHhD?=
 =?utf-8?B?UWlMSGFKbTZRdkVkRmNnazMrZkJud1cvNUtEOVN5cXlDVlZzVlVPNjF3OGJm?=
 =?utf-8?B?UnREbGd2bUpFRU1LWHQrWllJT1g3NS95OTFXMDV5dEoyajdPMGFOTmJDSFgy?=
 =?utf-8?B?bUM5ekZNU3pxY21kQnJJaU0rMENkNTRJUkhpb0hVallwQUhYMURaNVFYS0ds?=
 =?utf-8?B?bHM1R2Y4UWFjbVRKaFNLOEdnZUVBRXNNUEIwNXVhdWRsZkROcUNiRzduZGNh?=
 =?utf-8?B?cHFQNUEwYXlyV0pUK3ZEOExvNSswYzZKMzRWdnpGaHR2algzLzZJUW53ZWg3?=
 =?utf-8?B?REhNdzYzNk5pam9HNzhjWmlJOE9NT0VQRWMyQ3Vtek93MFM4STFKT0x1V0Zw?=
 =?utf-8?B?cGwxb2s3UElWc09zV1BjRGJGcVpJb0Z3ZXE3VlA2bVZvTUVtZXlqaEFKalQ2?=
 =?utf-8?B?YjVpRGRjaXVPYUpjOWhCUXE1QjdkRWtacndITTk0Z3hQTHFjbCt3R0kxZEgr?=
 =?utf-8?B?cWY0bFVWSjlVVCtHSHVKZkM0WnM4MXZLc1Y0eStSM0h5UkZIYWZFMXJnczRJ?=
 =?utf-8?B?K1VjNzhGeDdMTk13djdxS0d1bHo1bGlDVVRHdnlmblJOV2Y3S0FIWVlwRDky?=
 =?utf-8?B?RUNjT2ErUnV0OFptN1ZXazVCUTJ6S0ZZczY0WFJhQ3hYNENwbU01S2dmd3BW?=
 =?utf-8?B?eGJHaWRwaWdzajFiTHlIZ0N4b00wOVQ5T0NIQVpBNFdFMm1EN0FZK0ZDWjg4?=
 =?utf-8?B?WGVSUVNPYVpmR2J5K0ttaVRySUVDclRXeUFzTm1sdk5zaHhiVXIySFBuWTV1?=
 =?utf-8?B?QU5HRTF5TkdHdEp2WWk5aGJ5YlF0M3ZGVG5HQ3NuazlhZ3krT2luL0RVaWpr?=
 =?utf-8?B?bFZUVWlYcVQ4VkJzcGVFVHR1UDRVWWZTVGsya3pZaFUrZ1VHamVCZWhnR1dM?=
 =?utf-8?B?RXpzdWNrblh2cFNNYzlFVGxuOGVDWm9FWEhWVlUreE9UTFBVVG9SNnVqTlpz?=
 =?utf-8?B?aEZjY3pta2gvNWFnMFIrNkc3TzR6a1pHMWl2K0JnUDdUZkhmdFhkVjlBR21a?=
 =?utf-8?B?VkVudWR1dVNaeWkyc1BLY0NoMllYZXU0K2xqWDN4ZUJ5NmNoTVhxZ0VYZHdF?=
 =?utf-8?B?bWFUTTJRZ01PeWVJczV4YTVmWGwzL2VZcVBzR1lPMVlBTnFHVG56bG1sREts?=
 =?utf-8?B?RFJyRmE1TGU3d3BIY1JEcDVPU0R6emRxSmVjVkxtbVJqNWlrUmYzWkRTY3Vj?=
 =?utf-8?B?eVRKaGthekl1RDlkK3pPZzFQUS9ydjZsc2FlVytSMThvNHdMUUt2N2M4UGtK?=
 =?utf-8?Q?mKj1Z193GMobj8btn70Xh7HLZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90c64fc-118e-4499-756f-08dc67400c75
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 04:59:56.7778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WE891r9i5KZkKgzSvFgrVb2yGBGH1Uc9NrvVXCNvB6DwC8PHwMvgM1Jbl23gWtp1PTtkpgyggWj40ovU8SuPTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552

ARM SCMI v3.2 Table 24 Pin Configuration Type and Enumerations:
'192 -255 OEM specific units'.

i.MX95 System Manager FW supports SCMI PINCTRL protocol, but it has zero
functions, groups. So pinctrl-scmi.c could not be reused for i.MX95.
Because nxp,pin-func, nxp,pin-conf properties are rejected by dt
maintainers, so use generic property 'pinmux' which requires a new driver
pinctrl-imx-scmi.c

The node will be as below:
 pinctrl_usdhc1: usdhc1-pins {
         sd1-grp0 {
                 pinmux = <IMX95_PAD_SD1_CLK__USDHC1_CLK
                           IMX95_PAD_SD1_STROBE__USDHC1_STROBE>;
                 drive-strength = <0xe>;
                 input-schmitt-enable;
                 bias-pull-down;
                 slew-rate = <0x3>;
         };
         sd1-grp1 {
                 pinmux = <IMX95_PAD_SD1_CMD__USDHC1_CMD
                           IMX95_PAD_SD1_DATA0__USDHC1_DATA0
                           IMX95_PAD_SD1_DATA1__USDHC1_DATA1
                           IMX95_PAD_SD1_DATA2__USDHC1_DATA2
                           IMX95_PAD_SD1_DATA3__USDHC1_DATA3
                           IMX95_PAD_SD1_DATA4__USDHC1_DATA4
                           IMX95_PAD_SD1_DATA5__USDHC1_DATA5
                           IMX95_PAD_SD1_DATA6__USDHC1_DATA6
                           IMX95_PAD_SD1_DATA7__USDHC1_DATA7>;
                 drive-strength = <0xe>;
                 input-schmitt-enable;
                 bias-pull-up;
                 slew-rate = <0x3>;
         };
 };

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- patch 2,3,4,5 are new.
- Rewrite the binding, drop nxp,pin-x properties, use generic properties
  as Rob commented.
- Switch to using pinmux means pinctrl-scmi.c could not be reused, so
  add a new driver in patch 6 for i.MX95. But pinctrl_scmi_get_pins and
  scmi_pinctrl are exported for i.MX95 usage.
- Link to v2: https://lore.kernel.org/r/20240418-pinctrl-scmi-oem-v1-v2-0-3a555a3c58c3@nxp.com

Changes in v2:
- Rename nxp,imx95-pinctrl.yaml  to nxp,imx95-scmi-pinctrl.yaml and move
  to firmware
- Merged patch [1,2]/3 v1 into patch 1/2 v2.
- nxp,imx95-scmi-pinctrl.yaml only has patterProperties for subnode
  The pinctrl will be as below for i.MX95.
        pinctrl_usdhc1: usdhc1-pins {
                sd1cmd {
                        pins = "sd1cmd";
                        nxp,func-id = <0>;
                        nxp,pin-conf = <0x138e>;
                };
                sd1data {
                        pins = "sd1data";
                        nxp,func-id = <0>;
                        nxp,pin-conf = <0x138e>;
                };
        };
- Add pins enum, correct description.
- Link to v1: https://lore.kernel.org/r/20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com

---
Peng Fan (6):
      dt-bindings: firmware: arm,scmi: Add properties for i.MX95 Pinctrl OEM extensions
      pinctrl: scmi: move pinctrl_ops to scmi_pinctrl
      pinctrl: core: guard with __PINCTRL_CORE_H
      pinctrl: scmi: export pinctrl_scmi_get_pins
      pinctrl: scmi: add blocklist
      pinctrl: imx: support SCMI pinctrl protocol for i.MX95

 .../devicetree/bindings/firmware/arm,scmi.yaml     |   9 +-
 .../bindings/firmware/nxp,imx95-scmi-pinctrl.yaml  |  37 ++
 drivers/pinctrl/core.h                             |   4 +
 drivers/pinctrl/freescale/Kconfig                  |   7 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-imx-scmi.c       | 574 +++++++++++++++++++++
 drivers/pinctrl/pinctrl-scmi.c                     |  60 +--
 drivers/pinctrl/pinctrl-scmi.h                     |  30 ++
 8 files changed, 689 insertions(+), 33 deletions(-)
---
base-commit: bb7a2467e6beef44a80a17d45ebf2931e7631083
change-id: 20240428-pinctrl-scmi-oem-v3-12130031a74d

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


