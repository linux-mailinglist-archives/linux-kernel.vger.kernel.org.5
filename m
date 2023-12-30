Return-Path: <linux-kernel+bounces-13469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA0C8206FE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F971C2127E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475BA14F61;
	Sat, 30 Dec 2023 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="XIhzt1Xf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B4D2FF;
	Sat, 30 Dec 2023 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MA2jwtxgnsgFkv981E39/9HU0wDC/gdOQy/xBpfWVoBuCTmt5gQx8iyePTpXpALX52zveXbTwJbOnW9iC5CcsEQJ+R3lB22w2e6CA+8miB8RDP1Hqlm6WGp/z6PmBv4MuxG2E7+iAK5jNldbdBUWoZji9W1y5T/42v/OrOg3XtGjtlEdRoZpx7aV8xOeE81Lr7tjDoUVrLr85EjxjIAssYH6paMw09+Ih60xWHgnvAVtKzNl04swBwAKDEwd/TySZSLHr54o65ssnPb8vWNm7r4fEH2DO5pw7Pc7G92cy8KHcg0fnO77VgdQEHwzTAGhtc26aMSEgUKatD4kFdIKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgcl289EmJRwpJtbpRe4wL18fqPn5M9ka+q6zrHa0xg=;
 b=IieyRgD14jAdMYEETC2quxJNiPSCVHirYHRfvumrDQfiX+ZwcE0zfcSO8m1qgWGJm2iu+3lYe7f/TCFnQYmwwZEz/UFFPX7hY0kHn2UMrBCozHcSyktgtwfUmyL+DUypfYIHja9egRvYzBsuXf9D8mHAFdt1Fn7Rsqvrk5B3cLdx2dP6AcFzfeB23h9eGOw/f9SUWD9MUSe9vmEV+DFc9EMKVq0omahh3P10MhuUTnapGjAF3t9OReP/uXCb7AZO3PHHK10jd3mrL/4bzggduuYYnOUo1KzlVViL2jmgZPyoa/LZy/duXD2rxLL3ec3ESAcJrMbdDk8mtBz0Ww99bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgcl289EmJRwpJtbpRe4wL18fqPn5M9ka+q6zrHa0xg=;
 b=XIhzt1XfP8QcUERuCAR14l35baui2NfytFv2TZ2hwHRrvYEL70CdlspqHG04LXR/s8/YAlQR4IrU+tvgqtpvO/3n44FGX9H6ajifLn9o92Xrpa3N1hS5Zm4t1dzB8Dzm9Uzp579WsLnFggHG6O0KWgJKNNtfCx0T4QtVjDIkKEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB9704.eurprd04.prod.outlook.com (2603:10a6:10:303::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Sat, 30 Dec
 2023 15:44:51 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7135.023; Sat, 30 Dec 2023
 15:44:51 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 30 Dec 2023 16:44:45 +0100
Subject: [PATCH v4 11/11] arm: dts: marvell: clearfog-gtr-l8: align port
 numbers with enclosure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231230-support-clearfog-gtr-l8-sfp-v4-11-1d7f0e2c7128@solid-run.com>
References: <20231230-support-clearfog-gtr-l8-sfp-v4-0-1d7f0e2c7128@solid-run.com>
In-Reply-To: <20231230-support-clearfog-gtr-l8-sfp-v4-0-1d7f0e2c7128@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB9PR04MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4d20c0-a3e6-4a42-65c2-08dc094e426a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BkrvY9rfcCQJNT7OlpGTbTnXAOf0GEB6gcOp6PerCZH7b/fmupdnmLGVs+zGT8OUYCB39hCBorjSDHbTjPNtuBJ5NZKzjX9BTSY2xkP7X4qh/QAKjr3K2Hk2BsvexsOzt8vefnjCR3G6yS810Ovz9YhrDM0M9jSd/mXqyVsOjBgCMVPndEp8Q92X8HMyvOj10UDuJj0W3qo5ZgsRT4Js/CAaxjfFJkkuJR10VJ12y9Nz7VxR730KVC5efLe2Qe3RzTKnBA5YJtMYgQFTZBbhlOAjc1a0nb9sCm+R+iD3C6YJhMa4qAEi6t4jPaW7VC2U8umRZLJ0MKqjLnB7VqPMijw8K3L831wNCnphDt9GICJnW9S4yp3M0ALqYDCTIGHlf8SZiYThjeu+JQBgrQwUKxRth9IQ10lkVnehLVrgff3eA1I6fqHn79Da5xleMRy00PeFf1IymLiXIEP5EFQn2BGTNFUeQ7PqZ+HHVwtf2jashXaDj8kgQmehyeCEZsQ2UNS2EbjWMRi5BQ24b/7RXSvWniTxvDqCKFfGjA5/wjk1MmanzthcryWVayuHthl78PIx3et3LxRVklczS4BF1mqKgucB/9tABHz3NP7oKw+91WCPYYgmFSfKkSjyqqys
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(376002)(136003)(366004)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(2616005)(107886003)(86362001)(38100700002)(38350700005)(6506007)(36756003)(8676002)(4326008)(6512007)(83380400001)(52116002)(110136005)(66476007)(66556008)(316002)(478600001)(41300700001)(2906002)(8936002)(6486002)(6666004)(5660300002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkttL1V4UzJ0Z2FsRmdXM1FOOS84b2hPR0hzYU5DTDJwMlhJeUd0TWNCZHhp?=
 =?utf-8?B?SmdubGo1RStqRHFEZ1ozVGVIWitoWFFMK2lmdHFBS3Y4Q3ZLNC9MOC92Z2VC?=
 =?utf-8?B?STZEcFZkR0NHNlpsTThXdXYwMk9OdDFoNWg3dXJpakJaYlVOZGFDTmlMTU5L?=
 =?utf-8?B?ZXhndTVPbHIvcWhTMTNDVXJKMjJoTWx5K1hyQWdlQ1NPTUwwMW9xRUF0OTBW?=
 =?utf-8?B?bjlpQkZNL0Jpc25PVCtmNkdiVkFGTzNtZXR1Q2J0c1lERXhFNjM5QTFoMmtx?=
 =?utf-8?B?QkV4WlByVUowMHliTHIrN09CcUNsZnBjYUxERm9OdWI2M1JkZ3R6MjhqS3JW?=
 =?utf-8?B?MG02TDBJNEljWHNJNlNwMmJKT0x3TzNjQlVXTFd0eFhMb0RzVlpheTZZenZx?=
 =?utf-8?B?MktQN25yUlFjZW5tNkJib0FFUWNaelpqSzc2blRzNUdQaGUzTkRnbkU1L1Yx?=
 =?utf-8?B?Y1NuQUtValdCa3BvUHNkQmJ1d2dTTUlUS1FWSk92THU0b1JhQUZqSm51MzZH?=
 =?utf-8?B?Q0w4cmJONlpiNDlUalBWdkxzL05DQWVWa0RaMDgrcElEYWZudVkvY3pMWXdC?=
 =?utf-8?B?aENSNmxibjZvWDJhZkxkaDNZSnhzOE1iSjdENTY5NmdWS3krdi9VaDFHQStI?=
 =?utf-8?B?MFIxSE44K2J2YmxwNUY5Nk9lSnFBdmhoRUtYUG9QQ1BzR1ZmOVlTRmwxa1VQ?=
 =?utf-8?B?ditWNWt3SU9PK0dOZHhQTzY4elN2SDUwVGZaVC9OeGJMSjMzTXdTZ25Rdm1Y?=
 =?utf-8?B?Mk43S3Q3WGI4TE42eXk0QitPeFBMZUZtdG5tMUJkemxhbWo1QWZ6UjQrNUFs?=
 =?utf-8?B?M2dJRFc1aFFNS1RHbkU5ZktVaG9mMjFpcHdiejlPaDFoK2wwZy9IVGdYbTFK?=
 =?utf-8?B?cFZ0djZwOHBuQmNJOEIxS1F0NG15NU5zQ2FMbVl5MmhrQjRWcEc1aTNNS3JG?=
 =?utf-8?B?WnZoeloyYXc4WDltYk9xY0JWWjVvNnBwSUk5b3lTVit4SnFvRm5xeUdIcXpE?=
 =?utf-8?B?TTJLb3BZWlNOUXVPb1dFekF1OWF2dFdCMmkyNzBqTUorYlNqQ201STJlV0RL?=
 =?utf-8?B?ekhldCsxdERqZHgyMEtsV1F1aXVMQVQ3T29DV2Q3Q0x5UEwvTk9PYmhNcGlB?=
 =?utf-8?B?b1JHREhlZ21QVktTSmZQd3U0RXB6eGpMWXJXQ0RGSDYwQm9veGE0d0E2TEtx?=
 =?utf-8?B?bGw3VldtZHptbkVIT2Z2UGpRRitGRUprMTIreGt2Z2o0MHg4bXppeWlMb1Fh?=
 =?utf-8?B?cEtoWHMwVEJYelVtcldaWTJoV3YyTXA4R0g2UmNXbEhyZTVhSVZOUDg2WkxQ?=
 =?utf-8?B?VUFSaU1VNzgyejBPek9EdkFMSUN0dHNTRVNDSjhqNWUvbC9pRzVtVDhBUGs0?=
 =?utf-8?B?aHpkU0N2ZElBNktFVnpJdXFuS0hTbldEMVE1Yk54U09oRzFSemUyeHo5Wisr?=
 =?utf-8?B?N0ZmRVNzRHYrVk1FbXZIVjcwWFJzSmMwNlpWblJVSEMwZWpidDFHSnNrQ3JM?=
 =?utf-8?B?dXhNSFZQRGlFZExZdlB4STRpdUN1U2p4c3ozMlVQWHA1Qi9NS2RjWFNacHl6?=
 =?utf-8?B?TGd5bWdwVDgzdU02L0I5cjBYcXkyMkhXY2xkNVJOTHp2Z1MvYSttRzVKK2s0?=
 =?utf-8?B?SlNHSUtWWlJQQ1RCbkxXc1MxUFVncWlXcE15RndYR3Y0WUlYaXBhc2s2Uk4z?=
 =?utf-8?B?TmhDN3AvcjZwRWttYlJUNUpOTFJSMm1Mdk9zb1lEWnpiRXZRSjdRYWRjZWQ0?=
 =?utf-8?B?MHZWNlZTdVozQVdxbjV1N3N2MTgwVk56QWlBeHhsU1ZyOWdMYzJIc0p1TGpo?=
 =?utf-8?B?MXpYVW9oWkt5NnhIcVVOY3BsNEVqTDhtTjA1WENCWkdLTTVCWXNXRU4reFJM?=
 =?utf-8?B?RmloT0wvbHg2RVB4UnpBZllSV2pGaFkzOFlDNmRzK2d0dDRzYnhSLzFmSjYv?=
 =?utf-8?B?cE4xZWJaNkpiQ2JSNWZ6YjV4dkJlTTROZHlQaEZDWkZubFNTRHh2U1lqTmhX?=
 =?utf-8?B?Vjl5TE9tdkdOU3VKVmtxaHNlSEovVitTWTk0NkJscW1iU21nUXZYeHJsRlVL?=
 =?utf-8?B?L3JlNklCQncyZiszdG5FS0FUQXIyZnlWU1RtYmZQTy80Skliay9EMEp5Z3Fo?=
 =?utf-8?Q?33GsuMtxzAmu4EBv1nTsXstt7?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4d20c0-a3e6-4a42-65c2-08dc094e426a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 15:44:50.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntsfHwh0ww0bZdg/XvMhyLOevQetYrpd9N06c1tob0mGOABeM/bxGihP4g+uYzeJiFvaWnTm5jcJtdSzqJklJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9704

Clearfog GTR has an official enclosure with labels for all interfaces.
The "lan" ports on the 8-port switch in device-tree were numbered  in
reverse wrt. enclosure.

Update all device-tree labels to match.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
index 2df388f222ec..da6981677b03 100644
--- a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
@@ -32,49 +32,49 @@ ports {
 
 			port@1 {
 				reg = <1>;
-				label = "lan8";
+				label = "lan1";
 				phy-handle = <&switch0phy0>;
 			};
 
 			port@2 {
 				reg = <2>;
-				label = "lan7";
+				label = "lan2";
 				phy-handle = <&switch0phy1>;
 			};
 
 			port@3 {
 				reg = <3>;
-				label = "lan6";
+				label = "lan3";
 				phy-handle = <&switch0phy2>;
 			};
 
 			port@4 {
 				reg = <4>;
-				label = "lan5";
+				label = "lan4";
 				phy-handle = <&switch0phy3>;
 			};
 
 			port@5 {
 				reg = <5>;
-				label = "lan4";
+				label = "lan5";
 				phy-handle = <&switch0phy4>;
 			};
 
 			port@6 {
 				reg = <6>;
-				label = "lan3";
+				label = "lan6";
 				phy-handle = <&switch0phy5>;
 			};
 
 			port@7 {
 				reg = <7>;
-				label = "lan2";
+				label = "lan7";
 				phy-handle = <&switch0phy6>;
 			};
 
 			port@8 {
 				reg = <8>;
-				label = "lan1";
+				label = "lan8";
 				phy-handle = <&switch0phy7>;
 			};
 

-- 
2.35.3


