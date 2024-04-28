Return-Path: <linux-kernel+bounces-161260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851E08B49B6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115611F21710
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311D410A2C;
	Sun, 28 Apr 2024 05:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jlMhic4H"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2051.outbound.protection.outlook.com [40.107.13.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5438F10953;
	Sun, 28 Apr 2024 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714280431; cv=fail; b=aNdlpRD6qN43hvd8DMWaW/nBClzNalV1He/RYHlbZQLdtPkuVSJaJoZkvwndP57pEXd/jlf2YkWNiBsIQ3NUrSSkmo+xINrn7hCDfulfvi/rWQXP0D9SZTOWr8cL0wUzkI836jGb9qX2B4VnMbb7UVl9B++O8yYoJEkSiDLcwEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714280431; c=relaxed/simple;
	bh=qT1gMIuECKr4AY1noQu+dj4lD9tdtRmznKszsDoYSKo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eeor8tCvhBvoJqQBh9zKoBhbLOzVdLyy38Wn1OfnCkycQ6v1qDtdrX3h0p+tuR6kSry2FYOig5J0cEJGgnSFlJJp7xFO5NgHoYuy86tDn50VdMcdF4phii+ROG6k6s5WRRiQjM6wluZKO6/gLnD7/+fJguTLaN/m6vO0NBDgL9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jlMhic4H; arc=fail smtp.client-ip=40.107.13.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh2Utdf1hM4MOsbpHHxeN/HF171EsbhgFElcsFDStW7d1jolDCBmrKNFkEP5jpopYeZW76oW43bJBKIthsY5/FnlaLCmz0ITTjd4OaNqK/RKtBUiwNWiXTpiQ3tPCRQQ6D3ARd13aQbtMCQj9o5DtkvrMgbYYkPQZgyN9+O5P8t/tRYna0b1ACZ+OCESayBlhuWW5GEqpSxqXcFM96ZUK1ljkCt2BE8g5X21eHT3B6SEfuYgNWxyunMX4Sf9HCOH7L3h5eD77PtPQOmyU3oUvlmEFIr+vrQ2PUjDCi+XMqLDOUz+9+xjrA3sW5n5ujmPFvQN6Ug7Z1ZYq2FfWDsP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xGma/ISq/IkMsbn1rRp7qErVSMnBd1TEHoCFW0L12U=;
 b=dodbVpWD95WM/DwGPbZnPMFPDwdXlRqLNItyoaXXzrgM9J1rb1TerCsRDABcNalWPLLtRXro1q4RgZC7qHhoW60hh3DiSvklnzImGpaICY5t/kEzM2Mko+4D0+zoWqDS0mJ+jxkV8SqtbSN9smn6ztHymtB/BahQOm+CwkjDHLJEQ8sE7DQ3HigMwQNVMfEix08yHygJRf7yPm1dmdjb9Qm0jlnobmLpksOTpzQU9h0VyHki2lhPxjYbKtvBKgXTjWR8DyrttLnReQj+Fr0e79AlHifmnb8t+WWloy6u4b5bbo40x/E/FSaXpQajYevjaob6KXhWQFVXhB/jN2CPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xGma/ISq/IkMsbn1rRp7qErVSMnBd1TEHoCFW0L12U=;
 b=jlMhic4HYRWSXNEYc8KR2wnp15dtQ3fcuLXanU4r278RI/rduV4aHHz9NOnIwnNXVW5hROecmGapuqpYXZhrQ5DiOOXWym4MSWGqjlNi+R8iynSuJhCjUslifCZ8jBb80CjX40qulGWzqKQInqwzdwbbb4HHxgu/J8d/PZDRMIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 05:00:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 05:00:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 28 Apr 2024 13:07:51 +0800
Subject: [PATCH v3 5/6] pinctrl: scmi: add blocklist
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-pinctrl-scmi-oem-v3-v3-5-eda341eb47ed@nxp.com>
References: <20240428-pinctrl-scmi-oem-v3-v3-0-eda341eb47ed@nxp.com>
In-Reply-To: <20240428-pinctrl-scmi-oem-v3-v3-0-eda341eb47ed@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714280885; l=1584;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=GBly3E3FCpamuuNCyb9X5Tw3NOV/O8isPoV7JaTrRkM=;
 b=HBeNuROaZj91h+BxKGKeL8IdhhCsjaoKD5xXF/cfnJamIG4/bIzd2aTI2SxQ03ubQViSXygvj
 nJnS8w00ZUQDMgTHvhpKXRzhyaHMwI2ac5Ug4pR6KCisFeRs3g5ptg+
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
X-MS-Office365-Filtering-Correlation-Id: 2a0419b3-e99f-4932-ff95-08dc67401e1d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|52116005|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czRsTUhDSVhTNDVBNlZIVjg4UmFPTjhjaUJ4c3lkU2VIZkdyaFE1c1lKYTd4?=
 =?utf-8?B?K0dsR0laclRhQ3pFTDl5THNGalBPZ25jZzg0a0NBdVJHMnU2NGJHMjBCOGpF?=
 =?utf-8?B?ektCSG1jSlI1Qnp0S0wvUmxnS0Z5WWhtQjdrVlIzSWw1bldCUTVBOHl0VXlk?=
 =?utf-8?B?Qm9JdTVQNyt5NGVlTXV5dzNnRFNYMmF0NXV0TWZiN04zdVRkeHFaMVUxN0pC?=
 =?utf-8?B?N1Nrd1d4Tkc3QXZBMjFXc3ZSUFRFU1B5R0szdmVGTkJFK2hCa0Ewa0IwZ0di?=
 =?utf-8?B?V3d2WUxXYTU3dDYyQ0NUc2JlVmZWWDUwbytSbEdnaStyWTlwOFIyeVhYZmMv?=
 =?utf-8?B?dFlWNXBHSXI3ZFpTa29ueTNHNm4xdk1VMVJKOGNsdGdFNHBnTUxaNXh5RzNV?=
 =?utf-8?B?RytYeGY5WGlqeWxmN1BCZysrK1hiSnNveDRXWDZzNTlLZFhBN3dxSkFaS1li?=
 =?utf-8?B?akYwQWJOSVFXZzVnL1dFUEl6TFNQZ2FYZWFwNFAyckx3K0NXTUczd3E0bUw0?=
 =?utf-8?B?WTNyQ2tjVEtWWkhWUVg4Y1NYRkFReUdrT0ttaEVSZ0tpZ0hoT3M1OG15NHk0?=
 =?utf-8?B?cE9WOE9DQlVmbUd0M3M2eWUzWTFDaTBnc0J4R0h3aWhQOU1LeXZkNjVDbmN3?=
 =?utf-8?B?SHpXSkJHNnI1eEhnVnBkaTY1S1JyeDJMTlEyaUo3VlluaVNYbG9CYnV5cTh2?=
 =?utf-8?B?d1hiSkRQQTFmb3VkU0ZvZXN0dDRnOEZZeEo5UEV3SFhycWU1VnRpVk1kdkJX?=
 =?utf-8?B?dkJ0aEd6eXdmcmorMDAxU3ladXowSGZ1em1zeEs4dnowdE9WVnAvQWFKcTJU?=
 =?utf-8?B?eitjT3B6TDF6WmZpOW12SWwyajR1YkhvWExzWUxlM2d2aURycVVld2VFQ3la?=
 =?utf-8?B?aVlDUmFORDRGYUt3Tm85bUpSN2k5cm83VENZYmVwVlJucytNOHNFajJMdlNs?=
 =?utf-8?B?SDNOU09ablk1R1FvMHgvU1hKbW5PNVR4VHoveFBFQkhwZ00vU1lZamlncytT?=
 =?utf-8?B?dVVHZWZLZVhFMng0dzAwUXMyVVRpaXNab3pYNk9ZR0hFaVpMaHhTZG5VQzRs?=
 =?utf-8?B?d3FQazlaN3NtYThQWXNhTnNFbHNyRWpacXpEK241aC9QSUxDb1hpY20zVTBX?=
 =?utf-8?B?TStaSE5xRGk5L0duMVlneWpJR2hPWGU0OURNZjA2WXMxNUxCVlRkNnhidlp5?=
 =?utf-8?B?NVZ2N29JV1NZVXdvekc4Y1JRQnNXbCtPSmd6MklOUDlrNDFZbmhkOXh2cG9h?=
 =?utf-8?B?KzIzNUszc21PZC9kWXg3a2xVaUJkZHB0RnBNcGlnVXZXSGFVM1lVZFVIY1RV?=
 =?utf-8?B?RUl0aDhBejJ1c2k0NDZ4bGFKTFJaYWM3OHlqTWE0UlI0QWhTMUNVSGVJeVQy?=
 =?utf-8?B?QzFSQmJJL0Zxa2htVTZBQnRoYkhwMjdmSllJVm5MS0JiV21uOHdQTXBwM29a?=
 =?utf-8?B?eHNFZWNGT2NOWElXNGcwNEZGSTBLNGNJS00rMWpvSWdiRHBORGVVdFpQV3BT?=
 =?utf-8?B?UXJDTkNRZzFOVFVjUndlV0dKYXp1MlhpUXhLQnMrczJYRHpDY0VnR3VLTytC?=
 =?utf-8?B?elZlZmRROGZ0ZDZDMWJWQ21zZkVLNFBBRlBHTGtqM1kzd0ozL2VPaXRaWGNB?=
 =?utf-8?B?cy82ZDhmWDVBelo0RTNxSEttT25BdFMvNjFTeHNhM3VSZUlXRmFIc0VTTWVS?=
 =?utf-8?B?UFhhejNDaU5hNlc0M1VqV2d2VllKbnJRdG9zM2RQNG5oeDFBTE1QNllWYzJC?=
 =?utf-8?B?Y3grWmpGQS9NcEd1T1Rkdy92RlY4S0lWVWRPWUJiTGtTMjBVTlYvQVR0Mmh3?=
 =?utf-8?B?d0ozS0tGUFdjY1Awb1Jldz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVRDcXJ4cnpQZTc3NFFrRENreGxQRE1rOCt6enN4dEpQMlFXZXZJeW9vdWpM?=
 =?utf-8?B?SUlGc0JyVzE1UWlBMXRVQUtlUUMwZzh1dHJRL21ZQzljNHFkTTZPUWFUemtE?=
 =?utf-8?B?QXB0em9LL2pBZ2xvSGQvZkRrT3Z6YXEvZ05iV2NTODdrT0FsbzZ1ekdJV0d2?=
 =?utf-8?B?MGFFbVplRVd1cVNOREVLZzN6aFVYNHJwV21ZKzc5eTdVcjkxc3lMVEhCZjhn?=
 =?utf-8?B?TG1wY25MOVQvUkZ1V0VYYlZERVdBWU5SUkNFcVNwY0QvdkFzdEZWQzJsMWlI?=
 =?utf-8?B?MEZ4WFFjR3JNSVg1UlpIZjdUbVFwWU9DSVhZTGNhK3IrN09MK0xJNnVpc3hL?=
 =?utf-8?B?RzlsNm54czFXWWRVVllCVWNSNVpVcEZGc3IyelZtdEZTY2JqSEFnTmhHUUFV?=
 =?utf-8?B?S3VRL0JMMkVjd3A3TXptV0E1OHVoUkdhVEpBMll4MHJxYS93eXJ6ZHVEbElN?=
 =?utf-8?B?REg3YmRTdDBTZzVWT3pVNXAzK3dWdUQ4c2tjTjNWZU9LdjFhcTR2VGR0bVBx?=
 =?utf-8?B?ZEpLcVlYK3pYemJZM2o4WndvY1FiNGNBTWNHOWU4NVpYbEc3TzhRRnFIWUp0?=
 =?utf-8?B?blJJejl3d2NrVFBzQ1hYQUFOZjV0WjdPaHVkbG90UzFPUDZtckpxYnJOOW9Z?=
 =?utf-8?B?Y28rNVNiKzBzOW9UL05jcklZMmhYQ29oZGw1eHlwU0RuK2lDY3VSeHFrb1h3?=
 =?utf-8?B?aG1hYkRmbHh2a0xEVHpJcXhnS3lscktJMEJUMmtRVUtobmdyVUJVY3Y1bW1z?=
 =?utf-8?B?SktHVTd1T1YxSzRuKzdhd0RKay9GUUlNcmRtclJhR3ZnK0hDMGhteHRkaUIz?=
 =?utf-8?B?cmFEU05rRVNMK3BLUWE1ZUNaUHpNalk1eGg3UGxkeG54SjIzSWMvRStxOGlP?=
 =?utf-8?B?TTdSL2gzaDZRY05KUHl5QnBWY0Q0SXlUR1NYbkNXdTd3WE4veUJjQ3JNRDJ1?=
 =?utf-8?B?MTdYN2xuT0lZUkxhazJhd0Ewalk2UDJTMUxlU0NGdHdDdExCUkZNdHpnZGFD?=
 =?utf-8?B?L2tMMzkwT2dyOEFadmQvUG9WcmJHYnZuaU9OUkVpN2RWckRKb0QwRS85Q1FN?=
 =?utf-8?B?ckVLdFhGZktCTE9XTzZ4L21GSGl5Sjh1L3dIKzIyU3RqNjZISGxVQXZuN2RR?=
 =?utf-8?B?dmpPSU8yU09jb000TUF6Y2FnRFQ3N2x2aTh6SnRuM3dLalJDYXhrU1QvT1dm?=
 =?utf-8?B?cCt5RUV3b3Y1NkIzR1pVOUxpM2R6eUhwMk1jWTl5ZnpMeDQ1cWkyajdkV2l4?=
 =?utf-8?B?UENUTHZlWWlDRFJsZytzK1FkaUV6UGxZa3FXK3VLdmtxVjNnM05TSjJNSTBm?=
 =?utf-8?B?c2dOL2tIVWlMeVZkTWQxVXkyRDRmcURQRWN3cUNaRUovdW1ybGwrT2tzc1Bm?=
 =?utf-8?B?TFRQdnpDMHF5RUxtS3NhREt1VUJiZVRRaXlSUGM1M0xpd0xBbDlIUk9LWHVy?=
 =?utf-8?B?NFQ2Z2dWbTY5cTNoVE1JVVpoajEyZkNLd0E3eUhLcS9BRkZySkJFZkp0UjBR?=
 =?utf-8?B?M2tSRGVXb0NvbVhLeWF0T1dxM0hSdUVBN0xNL0hIRTFIRU1sOTFZZmo5Qm5r?=
 =?utf-8?B?MXQrZkxXaDhSWmE2SjRkby9tUG82L3VPMVVPQzRSbXJNNU9PNm4xVVplQmRO?=
 =?utf-8?B?S3NBS0lJUUJsZTQ1MVg1SExxejZCMkdwTkRlT05YZlRzQU11SDVGN0s5NWI4?=
 =?utf-8?B?WE5nOFV5Tm1PTC9TU25pbkZtTmJWS21GSm5OU254Uy8vM3BCSXlSc2RJTWpC?=
 =?utf-8?B?dWw0eGUrUm5udnhDcFJlUGV5anBNMkR5bzJIeDN1NTQzZS9yY2ZEdkdYWExT?=
 =?utf-8?B?RWkvY2RJcjlHMGZ1SnpScGtIUEMvY1cwY1pQUWlvMVdEaVpZUSsxaGZtVkZm?=
 =?utf-8?B?MWtISTJNc1FoMHIxTzZXNm5CdDdRbmNaNWwrOC9HTlJHWGF3cGhudUZ6MzVZ?=
 =?utf-8?B?cVNqNjIwU2NSaVB2YlVocjljblNZeFZiUXhSRTlZSkZjUUs5ZTRMZldtQXpu?=
 =?utf-8?B?bFAyNkQvb1ZNbXcyZXlJLy9Iblpvak9qQzE3UlhCTno4b0lyZ2VKNXJUTGg3?=
 =?utf-8?B?c3NncEJUQlRzOERiSlhFWjlCNzJaUWdtbG11MW9QTjNmSEFlbVJwU29kTnlv?=
 =?utf-8?Q?/gzvjVMvsQuBJReUVnMO1hZyV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0419b3-e99f-4932-ff95-08dc67401e1d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 05:00:26.1405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yyOjzxTEhuTmxEyyaCoi1v4sQwddEvhO6CC/fgOYhuxPvf+OghAxobxNGfwW84FLonmxSo3bTMrccNWvX+KMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552

From: Peng Fan <peng.fan@nxp.com>

i.MX95 will have its own pinctrl scmi driver, so need block
pinctrl-scmi driver for i.MX95, otherwise there will be two pinctrl
devices for a single scmi protocol@19.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinctrl-scmi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index 360b813072df..8ff35869efea 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -11,6 +11,7 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of.h>
 #include <linux/scmi_protocol.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -492,6 +493,11 @@ int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx, struct pinctrl_desc *desc)
 }
 EXPORT_SYMBOL(pinctrl_scmi_get_pins);
 
+static const struct of_device_id scmi_pinctrl_blocklist[] = {
+	{ .compatible = "fsl,imx95", },
+	{ }
+};
+
 static int scmi_pinctrl_probe(struct scmi_device *sdev)
 {
 	int ret;
@@ -500,10 +506,14 @@ static int scmi_pinctrl_probe(struct scmi_device *sdev)
 	const struct scmi_handle *handle;
 	struct scmi_protocol_handle *ph;
 	const struct scmi_pinctrl_proto_ops *pinctrl_ops;
+	struct device_node *np __free(device_node) = of_find_node_by_path("/");
 
 	if (!sdev->handle)
 		return -EINVAL;
 
+	if (of_match_node(scmi_pinctrl_blocklist, np))
+		return -ENODEV;
+
 	handle = sdev->handle;
 
 	pinctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL, &ph);

-- 
2.37.1


