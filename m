Return-Path: <linux-kernel+bounces-144514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8F28A4746
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1351C20CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAECA2B9BC;
	Mon, 15 Apr 2024 03:16:27 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2121.outbound.protection.outlook.com [40.107.215.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2AD224DC;
	Mon, 15 Apr 2024 03:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713150987; cv=fail; b=azXelP/D9jOV70weosKy+z8KaFtCYVKQyrJdlHM6xCcpjCd+NXm/X/vExA9mH9gUJVjfFkmBIsQSdZx+uLhl/FIO05lGBUPGKP1gKztiyiK3aE08+Otx64veh0m+pQlN3Te7E1YtrZPjOP6tc3pBbPba+oRHRxfsl1XM/tz43yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713150987; c=relaxed/simple;
	bh=q1pAfrU912lJ9aQNCW9o+7QkDEe2iYcTa81C6IsuP4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s0x941GbSLHtHoXQEqc1qh9bdnRGOfglmM7EslTSHPX8sskC56a1r9fd47DToT8LQtaJ9N/TNjvwBxDWzV8/sWHPee5yg7jMS78+2ZWG66j7MJc+eJqCve1PnqynfTKPeKqT+jHRYQ8O/8NteFhsOLJ8WgqnikbPNV9Pn+FPSdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fI4GOKPxftHeh9nqR2RISesomI7F1e1e+vYs7navccOik/9Aa2XyZsIIgpVHLyHWhePERPt+inLxLcGfqS95tNcaousKt9N3ZRpPKFGTmywY5U3auTwbfAEXdoKeiih7YaFRTdsBYxQgryWr3NRxWd7+L5U5fi7H9JYz2afvjCJ8q9STaMui5C3/qxwdAi/5qpBaL0KBTmtD1YC83eE/FQ9fj7F+EPPYlH72fn4D2ModhK/F3M7iXm53d6Hhb3kdciPfVBP0LHv5J/cxCKw5PCtmQfdvsz7f1R91UksYsOdq33QcohR1w/T3zc5vBgPcOb30k2RAIaDShN0Z5n0wJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=em+ymEvPeu9QadwFxQpjr+1AheZHvMQVfKswH3hOfHc=;
 b=JVfHRuRGt9bXe1HHgQxB9LS41Q09h6uEJ+sM+3lXi+vixCVsqDuJXkfPK+xZMWeFOg36FMz3t2VCc/TBPIQTi6eb4KEp+1hup76mU3gchamhi9Z8KcCulBfFO4lIUqfeXDtXKuxhhPTZJF3PsxFaXyNFDDnk6hhOdLBgFRtgYgAJjt5oeYQNgT4PUHXwPrrvWQPWYHqtnSOG7AfUbziSxAjq3xnZaJxG4hZG17RcL+nZ22MzmSqahWNRi4UlQRe5mn+DtfyqvPMV6nPEx58pRVprA2wCd8/qYZ4WH3OMsSrfciLZ3kJQ6x0ttMYph6JLTkHwgCmVIZR9X6Y+60goYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB8128.apcprd03.prod.outlook.com (2603:1096:101:16d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 15 Apr
 2024 03:16:22 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::c4f9:d4f1:c115:f1ca]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::c4f9:d4f1:c115:f1ca%6]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 03:16:22 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: neil.armstrong@linaro.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: nick@khadas.com,
	linux-amlogic@lists.infradead.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	thierry.reding@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v2 1/2] dt-bindings: panel-simple-dsi: add Khadas TS050 V2 panel bindings
Date: Mon, 15 Apr 2024 11:14:07 +0800
Message-Id: <20240415031408.8150-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415031408.8150-1-jacobe.zang@wesion.com>
References: <20240415031408.8150-1-jacobe.zang@wesion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0264.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::15) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: d6753da7-e7cb-4659-ec6a-08dc5cfa6d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGs2MWZJZ3RuSW5Xa2tXVXlwTm1kQ0d5b3dTYUtwYndSb0cxYlIveFRpUkdN?=
 =?utf-8?B?VzJHMzQyeFBFVU10STVOMEpJdFdyN1hybmxERW1nUDRmYmM1eGhSa1RXZDhX?=
 =?utf-8?B?YmRYbXBiVFhUK0FmUmN5ODh0Y0NDa1lRS1huZnZlcjFwVS9sWXduYnE0ZTZ1?=
 =?utf-8?B?M093WS90ZDBlaHdJVkRqeEhxSHRUWHBQb2FEeFg3S2s2QXJoK2tTNTE4bW1F?=
 =?utf-8?B?ZmY5N2tBT1Uyamo2VlJaZFhjZDVFSVZsZjVhOUpWcHhhSGRmQzFQbUpHejZG?=
 =?utf-8?B?TnMrWEVTMnNSTVZ0TlF6Znh0YWxxR0dUZFUzOUJKbmtUbzV1K1U2d0NkS2M0?=
 =?utf-8?B?ZXNDZXErTjRTUXlIOTl6aCtEaStZQ1RGck9GZ3lhT2hzTWRtQVgwMkFaZUM2?=
 =?utf-8?B?R1FCUzQycVhyWnFTbW02elFKZnpKNThLek4xVWJHNkx2N2JtREhybGRBdnhF?=
 =?utf-8?B?YzRvUnhTeURiakhCaHBMSVVaVWpVKzJoVFZUQ2NIRzlRdmFxWnBlUjhMb3k5?=
 =?utf-8?B?dlJrTU5TdkZHZTJVV3hNYWxTaTZ0UGlWaFg1WnV4ZnIvSlQyK05kcElZN29a?=
 =?utf-8?B?RkRPeThaQ21rRjJnMXJ3MW1IOXRwSUJNOFhGL09ZdWVTUTYwNmQvL29IaWVY?=
 =?utf-8?B?N3p5R1ZUMDExWXQ3cjduc2FjSDBkelJDSXJhcHZyckdyWm93b01UaGR3T3pU?=
 =?utf-8?B?UytEYkxPMElGblIvTGNkYnFmMEJVajBtN0QwUXBPVWdOMk9CVkxUY0x4V0RD?=
 =?utf-8?B?TGJCTklacnJCdGhzL2tUb1pGL0FvbGhGSHV4ZEtTbWd1VkRCNlp0NkY3cXFU?=
 =?utf-8?B?OU5xcVBLaHBwQVpaeURqTzhzSVB2QjRnK3pjaGVOQ2h2aUVEYm4ra3hYTWRS?=
 =?utf-8?B?Vy92Z3RIWXY1ZmM0Qzl5N2g4VlFFRFQzSk9JRW5ReGtxcWNPaU1FaFRLZ0ow?=
 =?utf-8?B?bnVwSVRra0RFdG5QU3c5bnU3VHlRVVM2RWhna3VlVUJjQ1J0NnNWcnR1TXRK?=
 =?utf-8?B?Ny9CNXZDRUdSV0E1cDBHNlJVMEMzNVZ2VDlxeTVjaC9PMUdDNGVNT3ZqK0JQ?=
 =?utf-8?B?STNveDlrWTBiam1yYzg2MjVYMDFoNW9rcS9KblpDMDhKTXRzb2NOdjJmRWpI?=
 =?utf-8?B?YlM1ZDRwZEdVZEc0WkQ2aG5pODlMc3E4cHFMa2VldEpYc1FaL2xhYWxtZElk?=
 =?utf-8?B?UTZhcWNzL2JIaXJuOEMwcUd1TG0xRjVSeUlEZVFLYjVvbkQwb3ErTVlML0c3?=
 =?utf-8?B?T2xSaTlSbmpOVisyRGJCa29VUmpOTjc3KzBCK3lpd1ZLenFrUjNJdFlzZVBw?=
 =?utf-8?B?QllIdHMvTVAzelFoTmNIM2Z0ckpES2xPUTdRRTQrQmlxanY4VjZYWjhxc0Fj?=
 =?utf-8?B?SmhESmFIdkp5MmRob2dvYkQ4L21mdWVFUUdvK2xlKy9nWGVIcjhpYVluMFpa?=
 =?utf-8?B?dHo2NmlyeFVQdUd4OUl3OGtTcWp5Ui9EdG1COXJxM0M0VUFOZjFZd0cxdFo4?=
 =?utf-8?B?NThWYWlZb253VVVSekl0V3V5bmlZWXRHZ1NZKzZjTklSYityS3d2N1FqTXYv?=
 =?utf-8?B?VERuenhhZTRzMStGSGNRTU1tZUc2ODBnMGQ3TjlFZCsvSHMwMHV1RGFMUEdM?=
 =?utf-8?B?cXRWQ3hqRkFaZmFDbWlON3lrMTFqaTlFZ0gzeXN3RHRiQmRaQUZ0NWdRUjVD?=
 =?utf-8?B?T0pEYUw1VEJQWjhGZFR4WkovdVUvY0o4WHJqRisvNWVLVUZnUEFZVm1wL0R1?=
 =?utf-8?B?MGpFMmo2ODFwY0EzV3kxbEM5K1NTeURBOVdpQWtvOG1vTW80My9wc2QrbEQr?=
 =?utf-8?B?b0dXZUVZaW9sOGRleFAzQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ulh6Q3QyMEN3amlZc002MVpwSGZLQVBzczRlSGUxNGNuYTB0SVdMcnNuQ2hJ?=
 =?utf-8?B?V0JCUkNFeWxLSVJ6bXJVamtnWVg1R2tRc0J1eklwNmY4T3B2MkE0WXNCUDdS?=
 =?utf-8?B?QlpXTXExNjlIS09XQmV0QW91d0dRSnZkZUdkODlnYStRVWplMFVSU3pCcDdm?=
 =?utf-8?B?V3NlMFVZSldWWTBsTGZhSmhtVFI2RHV6VmNvYnM4dFBZRkVmSXd3RmpNTG83?=
 =?utf-8?B?ZDFhUUFmVTEzWEVqQ3RiNlJoNVJBSUx3aVl2WWx4S3BPaXlncUNpZjZEWVoy?=
 =?utf-8?B?cHFudnpoVnhEU1U2TGVBNzVlc08vN3pvRklKdDM5b2x3T0p4ZUZQc3dPWmJH?=
 =?utf-8?B?dHR5bWh2czZ6anhEODZWSEhyUTY0ZkdLb1NldnROKy80TTVxTGRUQkRqdmZa?=
 =?utf-8?B?dE5lLzZGNUt1YUlzaUZ4RHdJa25RMDFzaFFFd1UvaEVtUlk5b3BXdWNtNC94?=
 =?utf-8?B?aC8wVkt3eFBCMUxQcnUrSXEvSkpVU3FqNTZpenRINlh0M1Q4MjZLQ0lmYjMw?=
 =?utf-8?B?N1JiNlZ2TWlPamR6M3QvVjU2bkFzblVMNTFyOElBR1hHYy9rV0VuMEprT2FU?=
 =?utf-8?B?QmZ4anNBVG42Z2IxVmN2ZEpkLytjY2tUTVlQbU4rQlFJc0FTUEsxVzJyZ3I3?=
 =?utf-8?B?cytHbG01UjE1YVV1WkFNSlgzWjFHMFlKdGt3akd1TW9NcmthaUxVcVhiZ1R5?=
 =?utf-8?B?WldoMGp1LzZhV2NGL2FteVhETEF0ZEdCTVFZOUFtU2x5NXJJK1BDNi9jaTBh?=
 =?utf-8?B?SjhQQitWR3JyK2lxdC9GZ25rL0VCWVk4U0x4czdJZlVTTnBlQjBYMkxCQVNE?=
 =?utf-8?B?N0R6b1AxaTdvNGdWcHVZRlo2QUJucFgyWDZyOFMzUVNURGg1dGhmeHc1TGFF?=
 =?utf-8?B?THBQUjFlL3NBSDJGZitOaExLWGphcjJibFhsb1dCRzMzbkt0MXhaQnIrR1Ru?=
 =?utf-8?B?eGFKQjJBNFowRWJWZWp4UEFqS2gxb3crNm43cXJwelA5bWwzWmlmc0dmYUhk?=
 =?utf-8?B?M010dkFCc2h1aTVFU2lyYTIxYTRrRnRIL2thWUZqS2RtQTZEVTZRcW1TQUpm?=
 =?utf-8?B?V1pCQ0x2Y3dRYWk2VGdDekx1MTFNQ0crWmRMQ2d3M2Fpa0wwcGp6SWlacHhr?=
 =?utf-8?B?cE14WW41dy9jeHY2Wk9wdk1WaXZmTkFrWCttWUNOd281NlFiR29WMFJSZmZC?=
 =?utf-8?B?RHNRV1JuSHVLVnRiMmxTZWVnRE51OW10UmlESkVuK0VIajByZkU0T0pzZEdp?=
 =?utf-8?B?NlEwYWk3VkdZV2tCaGYzSThqZHYxZncwdEN3VVQ0a0VHSytUNG9aenlZazBn?=
 =?utf-8?B?ck9VWUIxRm1wNS9abE96ZHowcTlwcDl1MVR6czdmZlU3N3Awa3JoaHhXMkhG?=
 =?utf-8?B?VkVVOXN5UEltZ25RNWh3QnVXTm04RUkyWWZ4WmlvdVRISk5UUS91RVovTm9E?=
 =?utf-8?B?bWtyeEVnd0xSS2ZZZUNab1Fpc0Z5VXNUQXRKVk9VSGhVcmE2K0Z6UnRNcUVp?=
 =?utf-8?B?MFFtV3ZWd1ZzaDliRm5PS1JPVmFoZVhkQUplcDFlRlEveVhIQm80VXJnbnlQ?=
 =?utf-8?B?V3hiYlZLbnVRMHpOdVdWdXUraDlncW9UdEJNM3JRL3paeUJsdFFxUjVqcmw2?=
 =?utf-8?B?WTdLS2NnWVFBa29sYnJiTVlLa1gvcHlZUFJub05uR3BSR0ZEaC9GZ09DMWRu?=
 =?utf-8?B?d2YxK081eXRBMzk0Si9jVHZGUVJiTnlGeXpTV3Z2cGdZd0lSSCtWck5HcTIy?=
 =?utf-8?B?U0lidk5UTTBFdUprNVltNUR0cEFFNlRadVRldmFuWm9nbHhmTnJpbTlnWC9O?=
 =?utf-8?B?KzN1Z2RYYXc3WjBMMTQ5eHgzT092V0Q0NlpHV2twVUNYWkhJMG52N1I2T1V4?=
 =?utf-8?B?ZmVub0szNVhodWtRVGRFUllnRU0rQzl2Y2x4ZXIxUVNycGQzOVpJWWpadFp4?=
 =?utf-8?B?NWJBNkwyRzJhN2Z4a0lZRkV2c0dNZFFIKzB4WGMrcFB4SmxhTXIzVGF2Wnh5?=
 =?utf-8?B?K2lDcXlWY0prcWErUDVnL2F3anhORGRrU1ArTnk1d2Y4dVhmK2NGWkpEZjNi?=
 =?utf-8?B?RmFZenNJZ09uYnhYenpWZU9CM1FtRDRoZ2p4WVoyS3ZYc3ZyenJvVk9aV2J1?=
 =?utf-8?B?Tit1c1MyaGZXWDlTS3pWRmp2RzlIb09wNnR2TGF2YkNwa2dQWkswTzVWRDht?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6753da7-e7cb-4659-ec6a-08dc5cfa6d51
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 03:16:22.7441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4AogOLUb4Sh+GgWzKy7QjxgiL7M6IkljBiGSElPPzvJxwi9YPmDfXN4sgEEZar6lpSZ84Arh3LqVe5kQPz4vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8128

This add the bindings for the Khadas TS050 V2 1080x1920 5" LCD DSI panel
designed to work with the Khadas VIM3 and VIM3L Single Board Computers.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index f9160d7bac3ca..ad0a733ee1331 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -36,6 +36,8 @@ properties:
       - jdi,fhd-r63452
         # Khadas TS050 5" 1080x1920 LCD panel
       - khadas,ts050
+        # Khadas TS050 V2 5" 1080x1920 LCD panel
+      - khadas,ts050v2
         # Kingdisplay KD097D04 9.7" 1536x2048 TFT LCD panel
       - kingdisplay,kd097d04
         # LG ACX467AKM-7 4.95" 1080×1920 LCD Panel
-- 
2.34.1


