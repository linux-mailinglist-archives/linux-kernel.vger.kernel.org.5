Return-Path: <linux-kernel+bounces-11615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E8F81E8EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67C91C21EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49F654F9A;
	Tue, 26 Dec 2023 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="l4sF4QSG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F6754BD1;
	Tue, 26 Dec 2023 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lutlJPeyDOkaFMwK2kzT/hDxVDEmP0OHBiWz64tmAn71j2SMAg2XVwq+7yEarCSGY6mTSxx5423Hrc6JGrnO7LGm+M3F0MgNRh2JlR0sinNk7zW4tuiZ/WE5nUweuY9OibCmj7JjUmvJUxbshZWpMByGUih70IYtade6IqP7z5VpGs51ti3YbkKI304jTfpGzXKrQLxv4AyMSZfDgiQIVnjgCD4D7LgiYHwyOtmzLtfxII6XYqiLHp5rKUwE4b7yY08ZHQGreVJpxpRRS2WN3P6+R+HNAKdzY88aKR8iTL4pu57lb67by0KRJWcQnlM6rsGtMg6T5+pAG9slANvCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgcl289EmJRwpJtbpRe4wL18fqPn5M9ka+q6zrHa0xg=;
 b=gSkfKA+3dK19rhmPLXYiVaYt0zTBjGCDg6QIOJKEZelBT6D/Yj9ktdzYtIklx4dPRZtCKy2IHf4xCFiWEhYw+fvklBradLOYxBnfa0NTUJG6eZSDGbyzC2zs3TORXKKg9j0WT4MMtiakcjC7MExq0Q6kjJEL3H7Qrq35YQf74IsjCVJ76yDuEtfdMgzfAY7LcDqeUjsBVPzf0L/HIDOlXyPLzLUnmMNiC0cntzRovdsjK4Y2MqQYPvUWElwIVgyYlJVX2NpG6wjiZHfN8ZWw4D3VdsCDklrPcYPrke00EqmmPJMpS+zAAvOCLNqNSzCenRcvary+aRw9kLq40ADjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgcl289EmJRwpJtbpRe4wL18fqPn5M9ka+q6zrHa0xg=;
 b=l4sF4QSGYP2+jtTC3kcS9LaBYc4zk8kvGsqwV7OuuNdkJldrqikwiFGAJ0KdTTIVLq/kKVfYuSRLnzk+xqO1bq7w2jdULsKI2FNlOWqwYDNh77K1T4a7PczV09hGx1FR3octnEAdV3o//LKpmb/Ps7fPg0IlkSqwiUA7rCscZyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB9868.eurprd04.prod.outlook.com (2603:10a6:10:4c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 18:11:55 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 18:11:54 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 26 Dec 2023 19:11:39 +0100
Subject: [PATCH v3 8/8] arm: dts: marvell: clearfog-gtr-l8: align port
 numbers with enclosure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231226-support-clearfog-gtr-l8-sfp-v3-8-fd1ac2d6bf2e@solid-run.com>
References: <20231226-support-clearfog-gtr-l8-sfp-v3-0-fd1ac2d6bf2e@solid-run.com>
In-Reply-To: <20231226-support-clearfog-gtr-l8-sfp-v3-0-fd1ac2d6bf2e@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB9PR04MB9868:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b6be5a-24e1-4ff7-db26-08dc063e2466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ds971dRPbGVO691FI1SLdN2a9zQgsGQUxt5hd/e84iz38qpGHIEv2AnexV0yZE7TBt+g2uhacPDVeXTRugrvY2PT0AR4AXSCYQ947emmV1jJX7mHQtJ+6nvpsKJX1EhVsLQqataX4RtwQpqt0sYY3IuV/pDQJ7UozKIB24qfZs3/2LCNKOLyei00+SxGTOTH+0PtVvGYsLQ84ofjz6Uzib5g5nOHnp/QMlbEWZvHshdm096rxQwZxAKqOYmUVnr/UmQtQAQFPY52QhJnU96dDMG2/9jXSKpPfAIJ8XJiYfkzYqdwXiLRUGgR1E1CtDwiTDo7GddVfzc8YEb9fiaI3bUyGqXpO4X54HzyToVVUbWZrx3hpl+59h7pE7jTTrKIpjUPex9nhJHcQcWrKQqqaKO7mVu7QS0Rm1TZYwt2TgBiZY3h+hT0hTPwLi4Gi4+yqOVOVcYYqPgLMZw//CLb3wuRWp6oFM4q+msIkCaqdrnwlQBtOsgEWEQo78NJ4CdSUPKPJ3w5NHeMfH5xWYYoIsw57v57ztrR/msf/6/YzPlW+IRikOECoCmK4uuUX5iOO54STDQuFbAnz5RZa2TqhpSUlJYIRdpr8HySszaI+RaaLLnUKO4dDeTpk5Tzc35P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39840400004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(6512007)(2616005)(4326008)(8676002)(110136005)(66946007)(66476007)(66556008)(316002)(83380400001)(52116002)(6506007)(107886003)(6666004)(38100700002)(86362001)(8936002)(478600001)(6486002)(5660300002)(2906002)(36756003)(41300700001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnlaSVN4OTkzQUw3MzVmd3VRVWloUDU3WGE2SlVFTVdsY1FDT014dTVZNnI1?=
 =?utf-8?B?emR4ZHk0OUh5aEhOSHhEVFgxSFNlekoxcDVkdm9GQm9MTUZjVkNWMmN1Q09j?=
 =?utf-8?B?aTVDSVFvVVY2YzNSSmxMQ3ZPZDBGTGV5dDcrbEJjMCtxaDFkVnd5cVlacFBJ?=
 =?utf-8?B?aDdiVnhWcW5pUUM2UXNJa093b0szcVZiM1R1cEVJR0JPWXJGTUVSM3JDQldG?=
 =?utf-8?B?aDJBVW9YZUljVEdXeStpaGNtc3lYZXhrQ0I1ZXI3SGZ5UHpDc0hIUUZmWXVx?=
 =?utf-8?B?WkJNMzhVVXhwT0tBSmZZZE1vc3hFQnM4YWc3ZFUwenV0eXIyNlQzS2V0Szl4?=
 =?utf-8?B?SHRYSUp6WFU1TFZqV3RFcmovbENBVmVxZ3V4RjkwRy96R21KM0c2QW9SSzRH?=
 =?utf-8?B?QmVGUldWL3ErQzBEU0NOK0p4UDMwdUdpNzFYZGRIWlVsa292cVJMV08zQkQ4?=
 =?utf-8?B?M1ZhSFBjWTNoZTR2U0Rudm1CdmVDQ2dWNDNzSHY3U1F5VmpaWDN1bHV4c1RK?=
 =?utf-8?B?WDR3eENGL1ptNjZKbUdaa01yQ1cwTnk0TUYyZE5oZDVoNWFIRFIvb3NIOVRG?=
 =?utf-8?B?dHNUS3hUWGE4RkZmUk5Id04weDdwWnJaQU9UMVcvNmVnOVZJS0I4MVdmcjJQ?=
 =?utf-8?B?V09hZ1ZWZVYzaHlQM3VGRmdPYktsQVVZT2RnS0VrRytEQWdHSzE2VHRBWjR5?=
 =?utf-8?B?bDljMEIwQnlkcGRGZEFtSmFmUVpGZFB4dDVaQUQ4QTRrODBrL2VaQzk0aVJ2?=
 =?utf-8?B?S2FyUWhIb0MyTEQvS29FLysrU0hwWDRadXc3RmhsQ3pCTWlXb0FXcEVPQVY1?=
 =?utf-8?B?ZEVkTXhHaDJzeDB6dWpBeFpLSGZmYlg5VnMyK3M4QzVwU0wrUnFUSVJ1RjFZ?=
 =?utf-8?B?aHZXelcyWU5Yci9Mb0F5NmhDc1RzNzlVcmVtekpXaEtaNDVDd2lDT0FLaUJC?=
 =?utf-8?B?enlSTVZJaUVGRjVJTUxUM0dhaFEzU1RoZkE3NzdhZW00T010bG9FekZEeHRK?=
 =?utf-8?B?MWFMM0pLaDNOSkVLenJsSzF6SExoZWV4YWxTKzUxVUpsV2RVSmo3dHVQYkJa?=
 =?utf-8?B?MzM2cXMwUUJZWVpnTWppbnFDYVZZeWpNajhIeFdpN0VTcGVLZEExM092bkFm?=
 =?utf-8?B?TmQxMXJ1R0NvZkQ2Zks5UFdMMVgzVkxDV1kxUnJSMHVCeWRnQXlhMC9NSGd4?=
 =?utf-8?B?eml2YnVkWWg4bWErc01NTzNINUtVWk1CWk1rNHlLcmZCTW5Ua0N4OS9CaTcv?=
 =?utf-8?B?RXExMU5LdW5EcVZ2aEQyYzRpay9mNVF5ZEgzQzgvckF6TWVsMzRRc2htK243?=
 =?utf-8?B?ZERzeHR4OTlsN21nTUcwcXF2Q1UweTVqRWR1cHRWRGsxWWVSOG1wOFFnT2xR?=
 =?utf-8?B?Kzl1QThVZjVKWkx1cGt0S1cyMEJDSnFDbmNZNEhTdmNrNTBtKzJueHdXQVVK?=
 =?utf-8?B?dnM4cXpiZGxRdTdBZEN1a3U2L2UzTUN0SVp5MW5yamE2dXRjSDllNE8yL0Ji?=
 =?utf-8?B?TjlWR3VQbHY0UG0xQVBSelZRdmxGQnZSMWRtNnJsamwvcTBuQ3NSZmVYZlA2?=
 =?utf-8?B?cW9mczNROHBLc1R1UkhZa0c5MkovQ2xwUTIzNlQ3Zm5OTXNaQ0ZDZlUzeXZB?=
 =?utf-8?B?WWpKKzRhbjFyWko2RWwrN2FickdDMjVERy84N0w0bG8rd1lEUlZ3VEZkWU11?=
 =?utf-8?B?eUszamlpY2pScFZNZGF3bjdlQi9ETUViV0czdng4dEZBeDUxU2pQMEFRbEp0?=
 =?utf-8?B?dmJ6bzROSjAzdkQyYjI0K3FUcDM4ZzByUzUwMnZyZXNKZkFpdTlFUDVTQy9a?=
 =?utf-8?B?dDdpamljLzJRZTdycHVUdVUvSHRKVncyMXc3V1NjMEN4Q0E1MSsvbWJFNHlM?=
 =?utf-8?B?UWtsbXFPMTdvWWptNnpZL2wyZW9hcnJEdlNEclhrYkp2ZXNpM3dCSHNMR3kz?=
 =?utf-8?B?ZmtUeFNMS0JqanJrekR5ckNkREU3OWJ6cEk5MjBzUkhOM0JPZkVSMXVkL2lW?=
 =?utf-8?B?a1hrL2x4MCtucktHakdzVlpnNXI0M0ErbERpMTE2T0hyTWYyOTdBSEpQVERY?=
 =?utf-8?B?bEp5MEpwamVoRHkxZ0dOMHFKOHhoaGVZVzJ0d3BibDVXZmVmb1lVWkkyUThY?=
 =?utf-8?Q?LPBbPwXmbkn+sMO4j8kroKrUU?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b6be5a-24e1-4ff7-db26-08dc063e2466
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 18:11:54.9206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRP+RTTCUJglpgOC0CD4Wa0cUdjgwvXdXF26e3sA2xkXyzOkUsJDvUnoDZnjyUm4W5/octi9JYFPgyNepCvNng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9868

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


