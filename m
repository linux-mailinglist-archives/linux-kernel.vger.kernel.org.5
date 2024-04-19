Return-Path: <linux-kernel+bounces-150913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDB38AA6A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCF5283B64
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC6679F6;
	Fri, 19 Apr 2024 01:49:14 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2137.outbound.protection.outlook.com [40.107.215.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B6B15C9;
	Fri, 19 Apr 2024 01:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713491353; cv=fail; b=CS7W32z7+ju1xKqnDy/3oebONgZcCn2FAImECgUpd7k9eo/T1F91nDXac7ea/qQj8vTzbgxoD4IMl5r2dAiJtUwF7H0nQeqP7DpYMVzzegemf82Z4JIk95AvqorakYuOUXQJSQYK7jT3xKEv4n001gitWNiGehLRmdctl75vmP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713491353; c=relaxed/simple;
	bh=/zFAx+j1tZXLj6A2uXFctHkThOvsmOlVr1Xqg1o++Qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BskJNkmZtel0622pv+z2+SpC8voj5yrm9sEDvUUU+IEr+NU+Mjkd6M2GTlwtTcH+bIMqnP0FRBIn+PuWVCIQ5Z3zYd2p26q1CNkhMg2rE6IGu3jb2epYquI7FlDELIA6CkbJUg9NnWe/tAv2Uyx19H+W880HVoCy7Jzj2DjtTvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUpQZoa7gnz8xXW4KZeQy0iYHRX3pfoajjvcTj0BNVaPIArYaUvsG9zT+9lyOKqqvVo6hl4pvNlQFIpKzHwZjNwksHO5UZEf+I+HsL/ePufgoziL7gOZIK3gyXl8H8qNx8u6W3LMbX08kTtUREbQnBrNs7mD4keyTUaU9+DVkKCyDARHcoUg6sS1lkZy5JLmc8JUh8nAvIXt9xtO00T4pvVE5WEE0PfxmWdqYT95kQv4byUzVUjudPn76mahiZbtOzsRI7zR16gbJXeUPOsUSSRpZnWb4LJXkcqCHRKa2fZ8NuvvXJ0nbso0sYL2Hx4PEQeefef/6KSYwiLVal6m4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UPLpZ2B5wuN227/9zgf981mYYxcW8FuzSLrstOeTqQ=;
 b=bxFkTlntcN7olnVXnqnTsSqNyfgjfqVFLPOd15beiSLMFi63SX/r853/uBJ+zglQiNxq3IH6hfsWODZKEzSWUa8LKo1sDo8N40genfGS4aq4G7F6bpG6B9yVZ0uBepYwFS1bz6U1VenTAaXrpIhfI+vMSYm7bdtkVN26QvZmMJlU1ErPgY1ynwJa2tPGBuMC4Y46sLwl4rvSHKSZtcveBtA2L2M/UFrbhZX4/NTZkbWW8fFg8p8pGcv+iQvcIv0lwpbDLPAPNpJ8YG2WMdI4J/7uBUMFpilGGllAnRsUhDQngZPn29MXW0feJ1QwWDUnFxDu/6HwMjinbx4h7vsd9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB6810.apcprd03.prod.outlook.com (2603:1096:101:65::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 01:49:07 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::c4f9:d4f1:c115:f1ca]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::c4f9:d4f1:c115:f1ca%6]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 01:49:07 +0000
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
	Jacobe Zang <jacobe.zang@wesion.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: panel-simple-dsi: add Khadas TS050 V2 panel
Date: Fri, 19 Apr 2024 09:48:51 +0800
Message-Id: <20240419014852.715125-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419014852.715125-1-jacobe.zang@wesion.com>
References: <20240419014852.715125-1-jacobe.zang@wesion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0118.jpnprd01.prod.outlook.com
 (2603:1096:405:4::34) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEZPR03MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 881b2e5c-2b92-4226-00b1-08dc6012e63e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bktvbGMreUcvQ0wzUnM4bUNZeEVnWGRhQjJmWlByMURPaEg2Mk9kaFFrcUFV?=
 =?utf-8?B?ZXNKQnkxeVJac2JLNlpJTDFTaVM2blNJOW9MYytrVnplUThBQ0F0Z2d6WHJS?=
 =?utf-8?B?U2pKaFhjdXg2V0RMbjNLdHE0YnpEY2MyVkRSK3lTSk14WWkyczhMcVQvZXdB?=
 =?utf-8?B?dEViNyt2eDhla2oyR2t3aEd3am13emZaUEhSZTRnM3ZSaTJaYVkxS080bzJj?=
 =?utf-8?B?eE5ZdWdwUk1VVk1xV2VPdURtaGY0KzFnbkIxcTZvYVdKYmhZekVRYjhENzBO?=
 =?utf-8?B?ZGlNWFE2RUFwdmx6amxHYWs1Rzh2MjgrMUQ5S3VReFcwTnVaMTZZSkxHM1VK?=
 =?utf-8?B?WkErbkoyaS9sRkE5Qm1PSkV5VjJ4RHdkYzJ3Y0h2TVJXK0hKRXFYbWEyZDlW?=
 =?utf-8?B?RUNjWmN0VzdxdWxWMGdwNGJUcCtpS0tHZFdianp0eWxVR0twLzFacUh6dzVQ?=
 =?utf-8?B?V1RLQ09BbUpOTmdIQUdoWm5jbCsvWnIrWkIzQVhWeUxJZmFOSFFzaTkrbVNZ?=
 =?utf-8?B?QUtyZGNKTi9hV2MrR0QwOTltK1UyY0l2eUpENVRZRHdHTUdzdjV0YTJVOUhx?=
 =?utf-8?B?UGQrYW9QNjBhUjlzdUpKeC9pVWZtZXBUeUFlekFtcjdYSmttWlFHZVhHVUZu?=
 =?utf-8?B?U0dFRTJWaUE1dm9OcTZNR2VENS9wQmsxSmNtSUtXVTliTmp1TC9tZkdUV0VO?=
 =?utf-8?B?bDdqekd6US8raUVTemx4bWlQTlhkeUtSeHZXRmFPOXF5MSs4Rm9MbVV3TCtW?=
 =?utf-8?B?dDJYVDk0VXgrbWNkS0J4YjFaZDJzRmtJU2k2MTk2UEFGd1BSM3VUNGNMenA1?=
 =?utf-8?B?ZXRKNEhUYkhGQU5IcEZXU0NOR3lwbzJON3YrdkNicmdVOG9ScHFFS2F4Q2d6?=
 =?utf-8?B?Tks1cHdOMW5ZVXNqMWljRmVTNjQ2MHpXU2Q1TjNqaEJsanhpN1lISUpObTJ0?=
 =?utf-8?B?ZnVPQ0hoenpBWnM3Q0p5aHBZZmZUbVFMMmNmRUJEZzBsTlZCaWtrT1ZmdDND?=
 =?utf-8?B?U0k3TmJ6U3RDdW1TN0lQKzZkcDUvOTl6WHBxMURjTm9mTFZZSk54NVBaVXFT?=
 =?utf-8?B?SEdDczFUVjNPbW95dFBsUnB3RmZUNG9LU3pRSU01RE5sM1pPZjN1SmxHY1FC?=
 =?utf-8?B?WHF3VlBxU09xL2M5ZkNycEQzaEJVVExPVlVaa3puMENrcHBnTnd6Y0xkeFZM?=
 =?utf-8?B?ZnYyekQvN25VaTdJNWRmOVhaakdueW1kTkEyUjdudEtzVjNqZkVKczMrbjBS?=
 =?utf-8?B?Smp4OW1Td2hVM3U3OG0zNUQ5c2dlRU91MTR3b25JRkZ0MUV4d05rTmNqS3l0?=
 =?utf-8?B?dEdEYlE2cXdSU3lHR1NYZGJ4RjZwZ1pScXJEdW1aQUVBbEE1TUNJR0VqTmNH?=
 =?utf-8?B?L1UrMnhxWVBadE9OR2ttQ0UvYlZncGdOUWtRbmhqRDh2V2FXMTFuTDdKZ0Ey?=
 =?utf-8?B?WnNGMXZVUGVKaUxTb2NWQkphcHlITFBRcngrVnFVTmNyN2drd0hLUFRWU3pE?=
 =?utf-8?B?akFkUnBTOHRWL0h0SjJrOHFHUFRsMjBRbmdWd2pjRGNNL1k3TEVZVjFYNllu?=
 =?utf-8?B?K0JxZkRWY2l4cDBKb3hJMEtHcjRmWUVGSGpWdUFoQk9lemxmb0JMT09vcjRO?=
 =?utf-8?B?VWpVMmJ1MXRoejZ0V0xqa3BSaU9Na2F1enhVWC9LakR5aUo1a0FZeFNkQkpi?=
 =?utf-8?B?OEM4cTBpbG0rQitldnVENjI4QTQxbit1Wlc1amRNVUdJUkRjQUpMWXpOblJq?=
 =?utf-8?B?OGdoY3dkL2VyQTZ5aDhXTWZDdGZPRGNJV2tSQ3BwVGhyOVU5TkxOd3NjLzZz?=
 =?utf-8?B?V0ZabjRMdGVwZGE1SkFDUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU5RN2s3VDRsNXZQSWczWUFGZHVYTEd6VlhrZll3Z3MrOWlNM2hwTVBodnJy?=
 =?utf-8?B?Q0xjN0NhM2pBVW8xdUkxUGtMa1N4SlRBWWU5bzg1RXdSTVF2L3NHRHhBTHA2?=
 =?utf-8?B?ZmZDRnVyWWVoanVRcHNTV05hTDhpak1IcWQ2MVJQUEdZSHJRYzFMUWxZbWp0?=
 =?utf-8?B?VWtDb29zbDBUZmJMY0tkWFBlU25ialFXSnIyMUNFcHFVV3ZqWWl3RmpSRnlt?=
 =?utf-8?B?VERIUFF2S1ZBK2hXZ0o0bUMwSUVCZ1JGYzFKU2pGUThyREtXMVlwMVJ6MmNh?=
 =?utf-8?B?aSt0Q1UwMm11TGNpRmM5S0M5Q3hHNE9CSDhmNmdNVnNlR3RSYkJwRHlWdGNx?=
 =?utf-8?B?b0VUUldJd0Q0OEw4MndPQlR0OWVpQkRJV2ZjSkJya0Ria296OTRWUTlSSnZa?=
 =?utf-8?B?OFZHNjJKdTBtZlA0bXVZelJrZG5ObzE2WFJKVk9vWWVscUc5MGE0YlJ4cXFM?=
 =?utf-8?B?S0dlSHB2STBhRWNTOXEycU9OS3E1V3RLaXJJYlJXQU9Nc2k1bXBJOEVlTVVH?=
 =?utf-8?B?cENzUmtlbFJ4UzJmbXFRZlorNWZ5dEtsbk41enRWd1pVWWxPVnRQeXQvVWNm?=
 =?utf-8?B?MWJVb1pqcTEyMythZ29QRjNaTGUyeVBiYjlCNjhaWXg3Z2t0by9NMndvWDJN?=
 =?utf-8?B?QklxMDBuazY5Z0JWUFJrenFyVHUwNUZIREJUSUlPekFBcENmNWxmKzNLdzNE?=
 =?utf-8?B?MFNQMUhMM2MyUFpaS1hOSmx1aExiaC83UE40YVE1VS83RVlMdlREbXROUlRn?=
 =?utf-8?B?TG9iVE8ram03bVhKT1JnanJjeFpCd2wxK2NFQy9nbU81V3ZBVnR6Z2JLK0s1?=
 =?utf-8?B?OEpCREpSMHRRRGt4by94ZkNTWVJxN2p3Ukd0NFlFMlZYUnErQ0c4MzdyYjlL?=
 =?utf-8?B?VDRqWVppQnY4cGo5MGhpUjFRalVNU3F6dXRwNkZ4K2VhZkdzQmhaazg4R2xZ?=
 =?utf-8?B?b3V0eUkycEVEMDhYVzlDNGF2dU1CVktLY0twZnJWd25UTUhNRzFKVjQxQWls?=
 =?utf-8?B?K2FjZ1ZkT1ZmcUV4MitTbWs2Z1d1a0w2bGR5Q0hvakFtaWhNUy9oQ1NJcFRB?=
 =?utf-8?B?QUIySEZPY2RvQ09KT3J4RFdsU3JaQ21rb29ndDRzSCtObjFHNUFWcWdPT2FU?=
 =?utf-8?B?dnVjaERPZDBUb0RSRzFsYndTVVRUbGZKUFgvUFM1b0IrWDYzZ3Q2b0dSVmpW?=
 =?utf-8?B?STBYUXpFTFpUb2llRDA3a0tUMVNnbk1wNTR1d1QyOWJzVGFKQStwYlgzaGZk?=
 =?utf-8?B?cHFmYkRTdmwwUEwxN1dzaEZZdzByOC9uSUV5TEVuUGcrMU5vQm5kK2VNTmdu?=
 =?utf-8?B?aEFHTWcybmF3WE81Y2d6c0doZVNnZnBCdDNMcnNzMzBEU25RNjFwVHdvMFhk?=
 =?utf-8?B?cmo3VFVMS2daSjVkZm56R01WNTlJNHVMMkpDTXRHL1NhZ0dzUzBka3BaSkU5?=
 =?utf-8?B?RU55MThlUWozOFF2TUlaYXVINERvdm5od1lEdzZCNHo0enVuQkdwOTNHb3Fh?=
 =?utf-8?B?Rk9XNGJ0STFEaUFWRGptUXBobDBFSUh2NE9DMkIwTVhoa3Q2RUVVMzlHNEF3?=
 =?utf-8?B?R2paeFdIY0VPZHN4Z0hTejBGeUlaVkdDcGcxQmY3d1I0UnM3dmhKQnE0TXVa?=
 =?utf-8?B?M25TSzJ1SVJzUTcySVdyUS80ZkxLalE2MjJPVDNVek14K05IWXAwcHpObFJK?=
 =?utf-8?B?RVl2WWhobkhEU21LaUV1SzlFVlA1bjUxQ2VQUWhka3FvSWU4NlV4TTN4aURk?=
 =?utf-8?B?c0gxNFNtc0xEQlpneVJRcUFFTnVOWGpmVWJtbVpaL3JNN1luOWhzcE1KTzd0?=
 =?utf-8?B?VEtvS1FVbGlJTnBmNEhWWWY1Q1YxZnBMZ2wrM0l2TWpURTV6WHpzY1RqZlph?=
 =?utf-8?B?YzdDNWVmSmFmZUk4cHNxOU1nUlZRZzYyVzZCQTZJT1BSQ3VZNTZHZllsTlE3?=
 =?utf-8?B?QlpndWhTRlA2b1V0djQwQVpZZUVIbXdvWW9UVWloQzlFL2V1UHlXRFNxT0RT?=
 =?utf-8?B?SjNDZkRVazlmSWVxek1wZWxzcFZZNFpmS3FuMmFHQnpnOXdwY3F6YTJxM0M5?=
 =?utf-8?B?M3AxMEI5ZG82b0FzQkU3cUw5elFHU0gxN0xYc1psTEtMRHBEZlp0YTZKdW5l?=
 =?utf-8?B?bks0MCtLRS8rdlRZM2R5a1hhcS82SDNFQVRnTVpCZXowaTNBNk00REwwRWk3?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881b2e5c-2b92-4226-00b1-08dc6012e63e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 01:49:07.0065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeZJG9hIPHGPbBDccF6wxv/FsF/uJdPKoRDzBsKsHIb907/OamoT8rKmPNq304PLf52F+xAgKHBhaXJi4h+diw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6810

This add the bindings for the Khadas TS050 V2 1080x1920 5" LCD DSI panel
designed to work with the Khadas VIM3 and VIM3L Single Board Computers.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
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


