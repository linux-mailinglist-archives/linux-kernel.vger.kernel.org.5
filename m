Return-Path: <linux-kernel+bounces-58293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052FE84E426
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86CB71F23E4C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EEC77F33;
	Thu,  8 Feb 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="jLErUgXV"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2098.outbound.protection.outlook.com [40.107.22.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F137BAE3;
	Thu,  8 Feb 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406867; cv=fail; b=XIEkG2sdbInMOJGUa+dtY7Hw7CVt+qDY/U5m1oGVNjuOgj8h/RibJw/J47X4MmpW4M66MFlg8LJ1lgVlcBgMymiEmFWqZCNGMH1em3xCKERcbmF3X+Jxt1VN6bvhcMvzEqlNh6rSmHKfsNnP4iLuhGH+3uND+mo2SuoKhnXH0X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406867; c=relaxed/simple;
	bh=IOB8R6K+uwbXGQnJwy+/s4bBbH7FgE6NWl2x+Otjtsk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DWUjvZrDNva3XLBmtnFddsNv1lKXqnOUFtAl0S/JeoVJ61nhH2nYxXXA7Ph3QyWUV5KRwP5P3OSycGxE4Zd9P2Y1WKKvnpVvNQuRtTsS2mbEY4rvvPCKCy7J+QTT5ZW1zwMC1U1vfaLFjsnxSZSZU7ZSjz2BmXfe/rB1qJBlqfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=jLErUgXV; arc=fail smtp.client-ip=40.107.22.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSMvHQCIXTFGDIYe6InldKYaKmb9fkTFXefA0UdBnI17DREi1Iw3HAvNpfsLqV5HGmOuQgtCnAX7OnFZ5V9W/7LwmUAjxeiWqzmBqrICy2tTMqUaZVjyd8TLtBUzqdq4WHPSR9QU5aofCnE5RXFeaz6iTeLURHE2H/+BaFHFV/3NDdc/cNdM23sesk+FDRF1LExgXVD+oEEruj4UREJEdZP0C6KpEKvp1zJ7YTA0DuH4ARQXgvzoUplVd/grmdU1xVdIa6v5ahmm30GxOOCYqdS6ZxunaMjB9IoIgk+xUfHtop9IemLhXg6xiZp9jDFtbGZfJPUGOX/VGtH9ge9qSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzXnL9EaqOhySjspSDKiz3Z7Qph5Q6lMd4LriNQ2V4M=;
 b=eB94oncInzXhzpqEavnv4B6Py8VqPUbIMezJNwh0OclcIsOpSuMkuxd8TLA3/rU+7T5MIEWebfWO/kyFCheN3cGeJOfrAwX35DHdEmwkeG0O6r3qhImfXvIT50T5pBxJttschvywA/aRju5NmdzaDnxwVKUXWpyFT6/v8HdmNBn2PLNRqgpMdzMu/da3wgA26OcHwVfHBLrpbJTUQlAemCPLMSY7riH73Q91Kluq14RIL04d8XVD0walzGyaZZ9sCeGbpVBDGkQX/dULMY8tT7tepbtpVX1TySqrfn1CMEJe1hIk0g2Isv10smjFb41s86PcvzRVE+w1iN5sn3do2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzXnL9EaqOhySjspSDKiz3Z7Qph5Q6lMd4LriNQ2V4M=;
 b=jLErUgXVmAsZJWzgI5D/RuafZX0iKrtHe5Ob66ifWCEbKqyV+lD8F+tTi7N4yEVwg1kLdJNbrFqGlTpsDIaZXDdDpNDbQiCWLd0K/F21kiQG9Hobl5oBlNSoIoFvEFZT0sFIIopXw3IPuf+bvf61+34H5Z4C4h8CCOpMvmW0tXaQI0hq/zL0yG13UR9K28uSd7sFa/yIW5ZESKAtVXROjU4rJW8evfsIf+Ihj07b/5Fehj/YfGdGqVJcCpTq02f6CJew9JgDa42nq7SbWMmy77cUUKjCe0LZCpvGJfQWVkRntrd2CWtZcxMIqYE1u2GzZkwfjaob0HvYu4oRZhFuTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by AS8PR04MB7621.eurprd04.prod.outlook.com (2603:10a6:20b:299::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 15:41:00 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50%4]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 15:41:00 +0000
From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Date: Thu, 08 Feb 2024 16:39:55 +0100
Subject: [PATCH v6 1/2] arm64: dts: rockchip: rk3399-puma-haikou: add rs485
 support on uart2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-dev-rx-enable-v6-1-39e68e17a339@theobroma-systems.com>
References: <20240208-dev-rx-enable-v6-0-39e68e17a339@theobroma-systems.com>
In-Reply-To: <20240208-dev-rx-enable-v6-0-39e68e17a339@theobroma-systems.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 quentin.schulz@theobroma-systems.com, 
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: VI1PR06CA0208.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::29) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|AS8PR04MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a1b9a0-9922-47cf-2fce-08dc28bc591b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ofeklTURX/27lXqLCh+J/1raBQw2srg87Rtn3QrNWZGbr8HSZILt+H6lhyeo5QVIzW2U9qAFBXlGfHbP7lRKVFJDdflTc3CtNRVeoMSvvAwIdufHhZOaDj8KF42DRlat2fS1VtaSeZnU7zCZOHhtjOGIiOuS4T0FCtuXpMkTi1LGWpcvwDXIHbxsrAEET2TWIVoVXX9DwC+YHyndTeJxA7hEO2L3u+A9IEyRFeBwOcYdx9rc4EoXb5D19D+IikMv3HPl8AlWjAqK110EkmlRrfBtjXt2eYzYJpOUAyjucC3hdvHtZqUCUkQtQNEhunUmuYoqjoQWLmTYQxvtQOFDRA6Uzvyp9cW5Ru2WypPqRRd7W6JMpH938ZzjL1rXOtsiNPi1hYVz6NqCYIsdttaCmztvfnZaiMF25a8a8xYuIBPjYtCc8IdrjNkQ0yIKM766NVnReF7tLWt21MMMErklVaXD439L3DF+M26FY855gSRu4hB3bvA6MichE+oEpt1ieyVJLayw/NnHRI+4i5YxuNWfEN4xFsmD7S5Bb9QJMjOz+jY0+c/lLbYOdCq9Iprm3CO2Q9qimqrrJ5YDZpKiU1+t3aPtipE6+BxCUD+4Lnh5J3BTTt5/Fet4bKknro4a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39850400004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(107886003)(86362001)(2616005)(26005)(6486002)(44832011)(478600001)(5660300002)(2906002)(38350700005)(110136005)(66476007)(66556008)(316002)(66946007)(8936002)(4326008)(36756003)(6512007)(8676002)(6666004)(6506007)(52116002)(38100700002)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MllSR2lwTlFpL0s5cXYybFdQL2VUUEpRU3YzQ2ZwalRwUVhlMDhsb0JvbVhK?=
 =?utf-8?B?SUdTeVdiUVd0NlhDUlEyRjRMSit0aEVQV29RSUJWaGk3ZG1hSjFSenVIWEVa?=
 =?utf-8?B?cFBSSWF0KzQ4dXZyS3orbG5vV2xxVlIrRlNjblUwS21FaFBHckM3Q0oyMytj?=
 =?utf-8?B?NVh0ZlBnTHpDMFIyWkp0VDhzWVA0VVlNL2FkbHpTRG9odmpxbWYyanRVdWRQ?=
 =?utf-8?B?VVZPVXluNm4xOHFicWU1Y05xZW93UE9JRElkVy85Qmo4bTNLV2Z4TTRuV3FX?=
 =?utf-8?B?eFdUWVJOZW9BZ0I5QXJybGZjeE81VDlleUNXUEc2azN3SmFqZlgzMnlUejlF?=
 =?utf-8?B?NU04eEJNdEs0ZjlQOVJCbjhyVlBCMHRwTFJiS1RMN2VmdVRBaXhqaTI4ZzZw?=
 =?utf-8?B?MzQrV2UzU0hiSGZnempPVTRWSGlFWmU3cy9sbG5kUDlBMGtuNXh0Z2xzNGR6?=
 =?utf-8?B?OWVWZEgvb3Y5Uis2TzI3T0k4aFVJYjNCVGljUjV6Z0ZtdmoraFFlVGw0UUhC?=
 =?utf-8?B?b1hZRkluNitaT2ZSWjZtdUthY01WbkpDUTV6RWcvbmpzWEExQ0ZNTVMvc1RV?=
 =?utf-8?B?YnVvWmFkWHFSZWRTR1R3Z1A3UXRXOU91SERCVStScnRWV3Y4bFU0NWo2ek1P?=
 =?utf-8?B?ZXNtSlhEZUNiUWdMYkdLYnZzZkZRcktTODdOZW9tSEl0b2xaUlczZTlRUVZt?=
 =?utf-8?B?Vnc0QXhSMy9PaVNMbFZtazhJMVNwVmUzeDZQalA2NTlMd0ZKZVY3SmJQMTRF?=
 =?utf-8?B?Z3FJbi9BOU9qNzduTzI2NEt3eDJyUS9QbFRhdS9Mc0M5eVBZdC85Yk84eCt6?=
 =?utf-8?B?MVpVckkxbmJrSEFPb2cxNHI2cGc1WVZKUDIzaHRpK0E1amhaMy9UZHJtR1lH?=
 =?utf-8?B?UUZFVHg4aGNZbThJNGlCRk1SZThvZFJ4YmJsdDcvakNHczI4T1JsVkVoR3Zv?=
 =?utf-8?B?UTdqLzgramExRnBTc3JEOGE0QVRBYi8wZ2l1MVJud2w0biszakVuNjJkWVpn?=
 =?utf-8?B?N3pjSGlTK0FKbnZZSTNOcWN4L28rQmxaeGlpSEZNU3ZHTG4xZ1NEdW03Z2FR?=
 =?utf-8?B?djQvN01DUklWeTI5VzYvYkNocTdFNmNRdzh4b2I5UGF2enRqTEN2U3pFSXI0?=
 =?utf-8?B?WnlsbnY4cFZ1MW02ckxkdndPRkV2RXRSV2V0S1E0MDEvYzU5STk2a3VBdmNY?=
 =?utf-8?B?d0d0cHhwOFpXS0Q3bCs5SUNDQWNjTUdtcXRnb3JxTmxyM3hDYnZrRGpweEVM?=
 =?utf-8?B?RkEvWFhQbFhZeDRnd21FR0x5OXNOQmZKT0RRbEpRcEVmVUJ5TlhqMnNKM1V2?=
 =?utf-8?B?cGFZVEpDUTd4ZzFxbHdjbjZUL3JiUjlQM0tnM3BRcUxDSG9hRWxzeng5UmV2?=
 =?utf-8?B?WTBrcS9zTEVvRE44eW92QnRPdUVqdEREMWZ5b1JHbDJWU2JsQlNBbHlHczMz?=
 =?utf-8?B?QmVFaXBBQjJ6VENQUVRpUWxvSllLMmhNYlFkNlU4cVB2ZTZVb3FiOStITnlk?=
 =?utf-8?B?ZDFIeVZsOEZ6czBxa0dmNVludzFyMGswYjN2Z0VFUG0vQ1pRTEJuNVUrdjcz?=
 =?utf-8?B?Sm1KaERYN0g2bWltc1BJemw0WXY1UW1paksxOWQrOHFrZ3d2OFR0aFI3dTBs?=
 =?utf-8?B?OXJSYUNqTHQyQks0VmdlVFRkWTRkMzV1N2VzQ3lPbjdQckJWaWQ3VHlrWllD?=
 =?utf-8?B?T043WHJkcTV5WVZkNGRvTUFRSDczQzZGQlcvMlF6WmNyUU94YXo5dUNqeE5y?=
 =?utf-8?B?SVduT0E5K2RUZ0VWc3gzdHJ0T3pUWmxOV1QwRXJlSWppeHp2eFNNeEVPNEtV?=
 =?utf-8?B?OE9yRUpMR0xxQ0dJWmNJVDduTjNzQm8wL0tYaStMNTRIV0J6OEZsMkVzZFhE?=
 =?utf-8?B?U1IvWlY2UlhqM1l5cVYvWGsxWHlsN0hmenZVQlhEU3cxN3MxSGYwZVpORHV2?=
 =?utf-8?B?VThQV1ZkU2d6ejE3UEFia2lJTDFSM2N1RTgxdXJWcktJbU5Cb1lrQ3hKUVht?=
 =?utf-8?B?TXNNU2VmcXEyN1QxTDZQUTVtdHJ5VzlRK29JODBIdDFCRTYxMXZtbGtQK1Fl?=
 =?utf-8?B?SGJJT0U2ZDNnL1ZsREtwV2FMVkRVNm5IVVJsdTRKUFdyWnEzV050eHFrRHZ2?=
 =?utf-8?B?QnBKNkZ6Zm9qeHlBNWljUVJsYXVEaGYwRnRnd1hDY3dBVEVORXpUR09Md2JV?=
 =?utf-8?Q?oR58FPFVc+TPSw+XT6i+HFA=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a1b9a0-9922-47cf-2fce-08dc28bc591b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 15:40:59.4801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGOBUwM7a+bInfRM7tQb3mRZjeWpy7ObxAV3kl0RYjGizA98qAYVwn/mC0GU3ibuqxYSVV3UcaIApM6a24v/jYhSNHn04EXhuXWfDNXs3dm4n4XrRHcdjuF10/txsSWT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7621

A hardware switch can set the rs485 transceiver into half or full duplex
mode.

Switching to the half-duplex mode requires the user to enable em485 on
uart5 using ioctl, DE/RE are both connected to GPIO2_C3 which is the
RTS signal for uart0. Implement GPIO2_C3 as rts-gpios with RTS_ON_SEND
option enabled (default) so that driver mode gets enabled while sending
(RTS high) and receiver mode gets enabled while not sending (RTS low).

In full-duplex mode (em485 is disabled), DE is connected to GPIO2_C3 and
RE is grounded (enabled). Since GPIO2_C3 is implemented as rts-gpios, the
driver mode gets enabled whenever we want to send something and RE is not
affected (always enabled) in this case by the state of RTS.

Signed-off-by: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index 18a98c4648ea..2c3984a880af 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -273,11 +273,12 @@ &u2phy0_host {
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
+	pinctrl-0 = <&uart0_xfer>;
 	status = "okay";
 };
 
 &uart2 {
+	rts-gpios = <&gpio2 RK_PC3 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 

-- 
2.34.1


