Return-Path: <linux-kernel+bounces-136456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7773589D435
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00071F24A17
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E48D80022;
	Tue,  9 Apr 2024 08:27:04 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2117.outbound.protection.outlook.com [40.107.215.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0220B7FBD7;
	Tue,  9 Apr 2024 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651223; cv=fail; b=XdNgO9b4QLqym1cNBNsN0qbL3xm69L9tMwShx56EdyYcCZ2Pj4a1xga3sa6Z7URB6K2rQMMK7plina2PkIhzMtmyamSsOGpkhHqYz8VkjAXEaPqPSv3qE693XcwICBXhCcteDmU5n5pNEESnrtbNd/i2UzySEm8f7bDq7+kOjHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651223; c=relaxed/simple;
	bh=TmZWYyicXG37+LTfCZZrtm3PGbmycE3JYAMCwFeACT8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S7iUT0+ChEYUpV6AjZpDqnuXOhNRVsjZ8mPlx/AFDZAtifewPejsSnohIMVs2D9u4POFY3m7/4sWeDPJruHXK6NpPOKh9GAzgbY8s+les1EAjEsTvFvkY0kvqMGp+eYInvgYdNQ+iTpFXLZdiVST1BPhx17UdIrBlkx6B5y6BwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/9i/GfcCCJvvZUgX988smsZ+qDBj0DjqOcov7eNu5j6yZanN74JNkTWspA6+sMMWPDFmjoghuklIizCto4pCGr3AdfFrIRdgqetEsMVBRR9PiPiIUjXrGHLojmLWyzdQ3porbTC8nGsMNF44x2VG6kjCAK6rvlxrFzcHbIIa97dwIEEgOlf8/Vpb6K6J2VFkWNEktIGQcBB7PsouGex0zVTrLLfSSgjNf2kASu0snxSHnOuu00YvJ407SvnBaWSM59rCDlwalZhuvXHeC9R5X0KAKVsPskyBePqsI4fbeozauoU5pCs8gxxCshMVO37R41Yu4gO9wevuUmmmriuog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH0GRc/H/DLf7+uJGT/IyjQljXh2DM8YRGEjSfdu8JE=;
 b=kUKmt79BRMtIECebP/5L4r+pfSxwMFDWIZ6fFBdN1HGvxHVuNaFSr4g1Eh/fjeKfqkMIRHpcJ0B2anmgWQrSO6kodi/bPGZCnLY6vAW2ZHWzOtnQgMFnAPugAvsVk3DXjWtPxnlMowxmfxsV24a4QbvI+JtDVeF83nN/zv2iTAWMTiwJmbO79ORd1bY5+A/ZJiOlqAlIkwUK4T2RqXG93V87/Jl0l3Sxfw9EwzOlpdXAyDy2t+Ov5CaiJP5LQcKOrkkV26unV8QMuIUszhnnzw+By7C4MGiJIxLGCoCwCeSFFz8tN6wR3QVZmNZuezYOH5d5+159/tM55cTli26Qcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB6880.apcprd03.prod.outlook.com (2603:1096:101:b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 08:26:55 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::c4f9:d4f1:c115:f1ca]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::c4f9:d4f1:c115:f1ca%6]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 08:26:55 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: neil.armstrong@linaro.org,
	narmstrong@baylibre.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	nick@khadas.com,
	thierry.reding@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH 1/2] dt-bindings: panel-simple-dsi: add New Khadas TS050 panel bindings
Date: Tue,  9 Apr 2024 16:26:41 +0800
Message-Id: <20240409082641.359627-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0070.jpnprd01.prod.outlook.com
 (2603:1096:405:2::34) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB6880:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mcQi3yi8vMqi+7nEg17bEc4eS5kWeUBbMD6syID1CteEiBVKh/guq9EI5oUVQbP9gLkC0kYdV+N8wlgUkz/93RFhs6zOyBGer+f87lLniMl3Y4vXYDePTC3AgrJU7q2JJF0pbGlcuX46P62T0vJxS9iqze8UOEmB+RTGjfvohF8HF1nZBB5SrOQEc70WdeczLSBeWmvEGVfD+p6SXDPEvUVaM2iInQWDfQc9IgeCINovkTosWup8QShiCyF3UEXfzvFcVQBhky5eojk96eA/D4EA8/4OGYojgckaHMI802XHpN8OKM0QIpf0/7Zby4dqxu39aLO8IaNdLGoXsmGii2vxsgVKdFiGEda+LGAtcYNgC1b2RBlRqg9YsnEnEr2d9O2lM3IAmnsgtFh9qglHApJFTrxA97mrSlr/zetj725MiJWlrrnqhITo6KSjxEJ2KzZtutifke6YiB22A+ZrdgKSVqrBfAq4NxH0u7837CYRCqDVcrqq1ZN45aaGpWcs7G8a5VE0XMQMk0oteWqbSL6hXyoKamAWyBYFLUT9dCUa2ZdvIk7gXcGZXMb9Kq3sb/mGZ7YAVq3dIboMHA7v2LiFa/o+fbO4MxO1/dv4VD0+rn+oNaVbINrtYKTDI4ut9fmFY5hbPuxP5Ro+cDWb0XHFaCrLyiKXptbwnCz3dhjXUUX1hnx3NDC/Qx1bnyEroBSnlUFwP6dXjfjnxZPAGOHD67VX3+YXh8VqFSNRV7w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(366007)(1800799015)(7416005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTdRTXdCbm1BaUJ2SmZrbHFpN3E3VFpnMmFscE9mQ0doeGN2NTF0d1NQSHJI?=
 =?utf-8?B?eW81b1hVQmJNYW9KSHVCSUpNUWlPdXZVa0lUSlVMS0ordmU5TU1MZEk2T21l?=
 =?utf-8?B?b2UrSjFkSTBRZ0FZM1AwSDZyNFBWY3gxWXRDQVU0ejdGVnFrSlZMMndxVEFs?=
 =?utf-8?B?MXhVOVFqSmxjRmRZekw3K2RuMStLMkk2SGovd093NWppWEVyRS80SklnSWFn?=
 =?utf-8?B?ZWphb0dXc1JRZC9MUGFIYjRPRUFvMnhjdW55RVVsOTJiOEsveXVFb3pDVmw5?=
 =?utf-8?B?SjJVM2JObkpaeDNWeHIzRVloRUJvbFJYR0ZhSFpIWTg2dXRob04rYlY4M1Q1?=
 =?utf-8?B?eitiNFBuaWpKQ285YWpFRUZpUndnSmlCMTgxZ2MyZmdCNTlrT1hIN3N4UjZW?=
 =?utf-8?B?bU8rV2JXa2FMRzRsTDllRDNpM0MvbjFCWUdJVTIxNWlzeE5TSTdic2NnVzhx?=
 =?utf-8?B?QnJDQUxGdTl3c0liY0xZQzMwNlJxMFU2dk5IZGRjWUpsQkpjbVliTnRZZmRJ?=
 =?utf-8?B?V1FxL1BjeTJQTzgxS1JMSGovbjJjVFZxdnJFT0dDK0NsYlA4K3lmSkFUalpE?=
 =?utf-8?B?bWdOdHNOMTI0VGwvaWhDTGpDMlFGaHJuTGE0Z3BTeTlIR1M2SDRvaktJRFV6?=
 =?utf-8?B?MGFDcklyQ1J0UDdVbmVzMnk2MmI5eXZFYjZMOTFmYmY4MnRTWmYvYUl1ZjAr?=
 =?utf-8?B?THhaOTRtaVdDTWt0UEliRmQxazEyek1BbnVqY2JNaWlVK0VKS01RbjdRVWpo?=
 =?utf-8?B?OEtIM25vd3orRGd1TDNGS0paLzlGb0JyT2xEQzg5aEwrVmFrNWFDUlBDNXBN?=
 =?utf-8?B?ZnZVV1V1U0Q1ZERtM0FtVUpBMDM1b1FrT0I4dnVpVDBVM29pcU01eXlSaTkr?=
 =?utf-8?B?Ukttc0ZZMGozdkh0RUZtOHhqNU5MT1p5T2hiNTRHcjJsZ2FaMUI0M3BuNXhp?=
 =?utf-8?B?NGlxOXdOUHVGQ01LRy9PQ2g5SmlpUEhzWU9FaExLVHZ3cThDQUEvYnZVOWY5?=
 =?utf-8?B?K1RNZmgzaHluSzJ0bVROTjA5YVV6TjFSQ2RrR3Y0THpGZGFtM1p0RE5SNUt3?=
 =?utf-8?B?ZFhIdHFObG1aKzBJc0ovVmoxRVlxT0diZmY3NnRKN0V3cUFVcVh0N2I0aDc4?=
 =?utf-8?B?djNXcmpwRUQ0MXJObmZxcVZydHJ0K295dHp2eWI3dEZYOEthSm5MMmtSSWFN?=
 =?utf-8?B?ZUFjRTVQTDlJeHlTTmhxVVZpS0hGblBJRUliUUtWOU1IOWlSRHp5K2xFa2t1?=
 =?utf-8?B?SWNTZ2xpNlpvSG9TVGVGYlFZVEJXM04zYVA5azgzc0NkS1FwbDc2WmJoalh1?=
 =?utf-8?B?RXcvZW5YWjROSXFramdyTkJvQUF3L0gyTldMZjVoZGJXK1hqeFlsd2tkVENq?=
 =?utf-8?B?TVgwTWZUeFZXejlqZEVoWWNFVU9DUDdieUpwTGcxSUo3eVpraUdrTW1HZ1Ju?=
 =?utf-8?B?cjkwY2xMQ3E1UWhmNmpQNnJXWDYvaTlGTlgra2Y1Nkh4cWFoOExISDM5Z3pQ?=
 =?utf-8?B?NGY0cHJTazZzS3VrVkVuZVo3S0o0OWt3RGlkR29UNTlpQUhFakx2SFpyb3Ew?=
 =?utf-8?B?U25YTDZqbm9XYlFTSEZ0S0ZGbDNEekxQQnhOckdtT1hlaEQ2QjNtS3ZsNXk0?=
 =?utf-8?B?TElnWXRhV001MWNFaks4VTFTUmV2RnN3SFpUZXh5Q2dJWDdNSGEvYm5ocUR4?=
 =?utf-8?B?SkV1S2gzSG0yYTA1MUs5ZWxIdnB2ekVNRTRoemRTTDhjR0tmQXBYNldwSXk2?=
 =?utf-8?B?MEU2aG10U2NtNmVUZXBtSzlReEZIdEVMMjFHT0hhN1RzcGg1L1Bsckd0Kzhv?=
 =?utf-8?B?UVpzc1hrYktWS1luZllqbllYUFc4NmRVeWN4ZTNSWXhlcVFhWXFmTDZsc2dD?=
 =?utf-8?B?aTAvL1VwT3V6UnZzS0tETG9XUHBSY1RYZUh5TXNtVyt6WStxRSttUGdaQzB1?=
 =?utf-8?B?THV0M0UvdStTS0UrZnk2OGV5NForcDdQalNWaWJEb0RiVGlpOEQxV0ZiNWhF?=
 =?utf-8?B?VkIraUhBVlpFd1dBMEJqKzZZSFRuTmIva0dldWpwc01sTVV6dGh5c1dyZTZo?=
 =?utf-8?B?TWg1YjE1Q1RBakxnVVF6eGNlYmFOZ0pETkhYNGgwRnNKMUwwTHg4VDVDRkNx?=
 =?utf-8?Q?BhNErla7Wlvf1o+V2CP5tB717?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209dcff2-5c3e-4c6f-90f2-08dc586ed0c7
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 08:26:55.4281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcdiWu3UIL9+jzFpAp8bgnRNXmMimvMEEwVM7ATNNCoxN5/9WqEB1E0GIxpSeZwD6+BU78tOUwAPf2vgsOfTOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6880

This add the bindings for the New Khadas TS050 1080x1920 5" LCD DSI panel
designed to work with the Khadas VIM3 and VIM3L Single Board Computers.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index f9160d7bac3ca..e194309f31b72 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -36,6 +36,8 @@ properties:
       - jdi,fhd-r63452
         # Khadas TS050 5" 1080x1920 LCD panel
       - khadas,ts050
+        # Khadas NEW TS050 5" 1080x1920 LCD panel
+      - khadas,newts050
         # Kingdisplay KD097D04 9.7" 1536x2048 TFT LCD panel
       - kingdisplay,kd097d04
         # LG ACX467AKM-7 4.95" 1080×1920 LCD Panel
-- 
2.34.1


