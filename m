Return-Path: <linux-kernel+bounces-40235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F8683DCF5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149B028174A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C9F1DDEC;
	Fri, 26 Jan 2024 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="D9q6kdjA"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2078.outbound.protection.outlook.com [40.107.241.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245421D52C;
	Fri, 26 Jan 2024 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281115; cv=fail; b=iN2odwddO9PzK1GMjugpLs6KPyG0fStkaMQLJX5aMzMNefmP9GdYhYqQ9IGjRM13JQet1vusWyEZWU/B+7yWLk0n0aCE0rfI5qnYptH3f3enZUbgZgg7n4OjiUR6Z+yADESv1JGnwZ8UwrajSKShQ/Aj9V89MTGxIKdp+Xbuq2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281115; c=relaxed/simple;
	bh=SlcPbM60WlKzEnTHdZgAM18nuAzy5MTJKsX4lGwwL0Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lk1gMuqmaerNwDzsK9xhv/iBAqufqZDxi+axmj94kDEUA1gZRtL6FdI+rPsOTwmhCFCX8YfpnliOBZgpDf7T6cghDV5j07WFtDKGYThNFvJzQwN+P4HRwmD36LBLkfZ4uWCAcwm68xvbai1ten6RifuxhXj8s1i1wTbo8CO5E3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=D9q6kdjA; arc=fail smtp.client-ip=40.107.241.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kwn9wUZJ5kIYwqdPCyOtw3R6VYOUsOxjjJjhKNsvbmjtvtAyH/w3mHr/TKWCwfFFLXqdqmZ44wAkmBgoVcxVMHogehHwDzl6o4FDPHpjiVZakFKElASdQ+SSTEdJm1Rzpb3GoRmfQri3O+tKhAibBKERwD6eAYXJh37gNr96NWnQTlYtiv7/SSkBtkFFSyYqda+ci4lLsJI/dWmjxuBDRHiMToqd82pRw6qpT451ikfa/LycGcxJZdct1FPlOFKBgctGrlGVDCYw6jifZUoWRToFxdqSILcJTE+rPazL7w0MvwUPMDqGvqLuXQMWk0sO7TCNA1CKWELWkBcbgrK1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dh9xD3qkAnT4zDfH45UENOftyY6lM3S9XnELbSMrfDE=;
 b=VNSeEmdxRkxARmSG9tkhdVbMIV8iZvk3I7ohcBEiC4iR5W3WvayIK1PFrSP1kE/1ooPqSOKpjuEqghs90zv9pbjczs7/vK8k1oAF1y01N8FGSDC0ah+VmcKxMrE5Wq7ZaZ1XqGewBbh1PUcljZNw3zsxqohQ2FGCR+LHGg2PxPEEwL6YDlRqFmkLuILedjsaIRQ4P8P4vGd064hi62vg32CCPtI5Z0BfKHC7Y+N3Ww5EDXBCJtT3Vh5fhI9Zjupdl8Uv2It1kjKG2L0/3W2sFY+zVCGy+hq9Qvlgr6/lLMCPFaODDwRwtOSHOOB6Sq9aOoXHQANIIrPj77ALBUM9GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh9xD3qkAnT4zDfH45UENOftyY6lM3S9XnELbSMrfDE=;
 b=D9q6kdjAcggdZtKX6qg6LbKq1GGN2YVkkHegbYtDdoOdyEWO/QCSiGq2Z2aHmpWH7DeAdMEHaaKNAPtR0kIGDXlg9qzdXyX7CF/Tg/WGtCXBp/Mw9vEv6o2nVB4mSBNTv1fLEygQVLH6cL6c/KBvupTUJ/n5/BjTfFOy5lXVVDjk37njP+OIY2v20D4/3azFyO7c18JPEd5niiSA61jAFr3UEdaWe4Dp/BKx/jRA4V6sUDyKk1dQfwIfPqcLaLPbdmnZMAWZVWgnfbto3Z1zOX+/k9ZYBhck6DgeJ2VTShR2sZDdy66GsunXv3TATR8alcKX7RW62WdY5cRLOw1IYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR04MB6371.eurprd04.prod.outlook.com (2603:10a6:208:178::19)
 by GVXPR04MB9735.eurprd04.prod.outlook.com (2603:10a6:150:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 14:58:26 +0000
Received: from AM0PR04MB6371.eurprd04.prod.outlook.com
 ([fe80::e130:6c40:23e5:9a8f]) by AM0PR04MB6371.eurprd04.prod.outlook.com
 ([fe80::e130:6c40:23e5:9a8f%5]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 14:58:26 +0000
From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Date: Fri, 26 Jan 2024 15:55:14 +0100
Subject: [PATCH v4 5/6] arm64: dts: rockchip: rk3399-puma-haikou: add rs485
 support on uart2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-dev-rx-enable-v4-5-45aaf4d96328@theobroma-systems.com>
References: <20240126-dev-rx-enable-v4-0-45aaf4d96328@theobroma-systems.com>
In-Reply-To: <20240126-dev-rx-enable-v4-0-45aaf4d96328@theobroma-systems.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 quentin.schulz@theobroma-systems.com, 
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: VI1PR06CA0114.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::43) To AM0PR04MB6371.eurprd04.prod.outlook.com
 (2603:10a6:208:178::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6371:EE_|GVXPR04MB9735:EE_
X-MS-Office365-Filtering-Correlation-Id: 6efb7f02-11dd-4ea0-6627-08dc1e7f401f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L+hOi6ufXvXkOebFWx77newJSg/6k0l5l4rhb3Yu3Dw++2bkNIYlc2JIxXa04YD2krPe9EagRFjIAV0y3lEm6y8qNZaNduCliCIhSkz8RWGrnwVEp9pugGyzN0gnIa4SO5v+/Kx9/kyrHkdMFyAAeLmGMcp2oVVnN/PUDt7mNtqXaVVKc8/7uMv/wNglh2zxOttJh17sufwQJ87KcMp5/kppxKzUt7WSlT2J94wZJNWyo5vfbSxcswb/IT2ffP2Y8MJ+M/b+JvLBC0B59YTx6WOC2cyBVvDyDee727oLEWe4Uwaf8YKsyFTwItEOS4Quw02Q1BHBtuOdbLFk0+ApXPRQ8HOLWgrfOEJZO7uml81AXshj8w9QLMJZHAcBL/7mSR/S2OuRNtZzLaGgL0I9ms8RkTaePLCoxQ4Z9R8aPO+4HSHOZfA37EOzLRTwy2yVo7QNcZ6WENIQPFskvKsisDgEIhPwMOxuEGX6pOZhZ4H8rvI2lFm56AsrzEm9sVmVyVvx6AFylQXsT9MtcRsZ4MHqPyQudrG38pcXKVqdlfsk6SdOOj0s0vtNXZ+QpI6UEusKgYr8woeebwRgHbEHxrfO0E+I7c0ALU+jjqfkEXo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39850400004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66476007)(54906003)(66556008)(86362001)(478600001)(38100700002)(6486002)(6506007)(36756003)(38350700005)(41300700001)(52116002)(4326008)(8676002)(8936002)(26005)(2616005)(316002)(5660300002)(66946007)(6512007)(6666004)(7416002)(2906002)(44832011)(83380400001)(107886003)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3grYXdTU3cvMTBXTlZ4RTRKbzRYZHg5WmxwZngwTm0yVW9wWXJ2OWVOb0Z1?=
 =?utf-8?B?SUJjTldVb2Z6dG9vcmNsWklCYzM4cUFrdWVmblprY21PbHNkS2xkWXdVSU5N?=
 =?utf-8?B?UWZsMXVSWnd4Rm5iWlF2cWtKQ3VoaDZlTUxneTYxMmxhV1JxbHNOb05rYTZV?=
 =?utf-8?B?eGFLRlZUWlJDL212ZDRYYzkydlF5bkVWdDZucjBrcElyYTBvTWhmNE44Y1pI?=
 =?utf-8?B?ci9OWHBKSVFDS0s5dGh1M1BrT1JOUVlkNERlSXZFL2h1NHBJdmxobjBEMXRT?=
 =?utf-8?B?RXZycy9aL3grZndpM0lLNFg5NE5CYldPTEJ2eHZyWlUrcURXTlBEN01lMHZz?=
 =?utf-8?B?Sm90OGxEWHVSR3hCb2RPWXRxQi9USHM4TmxzYnd6MVhzWHYrTXpjMlB6b3JB?=
 =?utf-8?B?QzVkM3JObllRcDhBaHg0WVBQMWFWY2t3a1NsMXV3NWYwdG10ODFncmVQNDRR?=
 =?utf-8?B?Zm51Q01DR0lTZzhCNlI3M2F1WkE2aTBFc2JNdjB6VmdPTnBvRlZsSndwbmht?=
 =?utf-8?B?U0g1SkFjajRqVWdkdDFsTnU3RHUzWFBBYkthaDQ5MVJCakhkNDEyelBDT3pr?=
 =?utf-8?B?cjRGTkdxd2JxcHNSY3RUUUtLUS9XYW5nUk1ha0c4d0lzZlo4czAzMnJwTGts?=
 =?utf-8?B?aXNLMjFlVjVzQzE1VmFyVGt0S2pSV0NKMVhhc20rM3JVOWdtcjU4VE9tYmI0?=
 =?utf-8?B?T3l3QnFFVjZkVE9PcnNkUWRuRG53eTFoSXJQYXI4cjBsbzNHRHViMU1BUURm?=
 =?utf-8?B?OVN1Zi9kcmhqSExyRlViKytsbERDdlFQbjZFa0VZZENZSHZOWkhzekhMeGZC?=
 =?utf-8?B?WDJZOEJWV2NhVytTSEpheG1WV2tCbzB5YWZEaEZsTG13Q2RPYVc0aEZGYlRs?=
 =?utf-8?B?YXZJaU41UmRUb3o5UXZhZWUzaHFXR0dUM0NjbCtZdjBsSEY5alF1QmJEaTVX?=
 =?utf-8?B?MDJCa2xzcEF5dGhaN2lESnE1MmFDM2YvWVc4TndoU2FFTDFpN2Q5bll6YXJk?=
 =?utf-8?B?YmF2Y3NyY0FFMGhaeFBSWEtoM0FNR0x2RitWWGQ0QXBVTGVtQngxSE1NNXVZ?=
 =?utf-8?B?T1RLNjc4Y256b3lSeGE1alBRdXZWTEFQZTNFYlpWa09FL0JDZm1QRTF2d2xx?=
 =?utf-8?B?Ulo5SkI4N0RFZExSWE5sbXp3V1B2ZkZIdzhpWTZLZkJ4bzVtMVVLS2ZDNEZt?=
 =?utf-8?B?VnJTeVkwL3FCbk9kNTdDNkN4Q1ZCTmJERFhNQUZuSHYvbFBRelE2dVV1aHBU?=
 =?utf-8?B?SUQ0UW1GYTF4L0E2SFNRZUdmTFlKV1E3alpndmIwdkpLTUpRWk8yT0NYOEVU?=
 =?utf-8?B?aWkxcDZtQXg5WkRnQktkVXBmdnBpVVN3Z2g3MEc5YTdJQjZSSjYzR2F5Q0oy?=
 =?utf-8?B?WVl1Q0ZFODRlcUpXa3ZycWVZWCsyZmxuLzI1VWdxdnBBOGhhdDNtMjdCK3Vq?=
 =?utf-8?B?Mnp3emwwU21TMWp3TExYNndQUVViVGpQbTJTNWFPVHM3UzlMUFY4UnNkTEZn?=
 =?utf-8?B?NE1BcEM4V0F4Y204SmtaYkhVby9CcUtKeDJjQ1FrWVdCTndxZHB2b0ZxM2NR?=
 =?utf-8?B?dG95cnZydnFuaDB2L2dwSkF6OFN1bTdSazE3QW9hN0NrdHo2dSt2UGxWK2R0?=
 =?utf-8?B?SkV1UWVESURTbVdiM0NkYXN0RVdwelhMOEJlM1Nwc0hrY0NXRktXd3o2alkx?=
 =?utf-8?B?RFhHUDZEdHZZMEtncmszSzE4TWszeFIxWGxTa29meWQ4QytXOXh5cXhOZG51?=
 =?utf-8?B?ek9GVXlPbEcrcERoK1M4MWplTFdHb29PY1lVVkhRaXF5RkdDYlhoZURvYk1o?=
 =?utf-8?B?dzZ0MWY0NCt3U2c5c0t6OHladEQ0UDV3cFE4YlBQNDlyTmlVRmtvRXhZbm5i?=
 =?utf-8?B?TzlRd0RxNGFKaGpDOXhQYU5YRk9LKzlTYk5sMmxFMmx2VThXWUhST21nNmNy?=
 =?utf-8?B?cVNZcjFrK2NQRC9Mc1RnQ3JaSnZQVDdPbTdIc2dFV1o4S2RYNm1TeStCbnBV?=
 =?utf-8?B?Q2s4WmttWk5remE2YS9aK3RDdVpoWUxsUGpUQmhQcy9JdDE4WkFnNlRxMXVq?=
 =?utf-8?B?a2FEWWRvdmxOelBLMWF6MjZPTW5xMmo1UHlYYUIxcGNYU1F1akVxVEtwM2Fh?=
 =?utf-8?B?d2JQamNIWFRrS0dmblNmSzhHOWFXOXBrS0lMOFZVTmpDOEcrWjZGRmZDeDl0?=
 =?utf-8?Q?uTJSxyfWz8APojvP+4ZRMko=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efb7f02-11dd-4ea0-6627-08dc1e7f401f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 14:58:26.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SrH1vOXKAo53wXvXG8yvq73fOXtG3kz25Of3FFPsCLyygCLogtp49NoDA7PHaN42Hjk7MFcc86Qy37V59XXyQHbBYVvBueXv1WXiH+OjcnpiwXSfUWjcA6xKjZoMVE4V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9735

A hardware switch can set the rs485 transceiver into half or full duplex
mode.

Switching to the half-duplex mode requires the user to enable em485 on
uart2 using ioctl, DE/RE are both connected to GPIO2_C3 which is the
RTS signal for uart0. Which means GPIO2_C3 is implemented as rs485
rx-enable gpio.

In full-duplex mode (em485 is disabled), DE is connected to GPIO2_C3 and
RE is grounded (enabled). This requires rx-enable gpio to be inactive to
enable DE as well.

Signed-off-by: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index 18a98c4648ea..576024c745ed 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -273,11 +273,13 @@ &u2phy0_host {
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
+	pinctrl-0 = <&uart0_xfer>;
 	status = "okay";
 };
 
 &uart2 {
+	rs485-rx-enable-gpios = <&gpio2 RK_PC3 GPIO_ACTIVE_LOW>;
+	rs485-rx-enable-inactive-when-rs485-disabled;
 	status = "okay";
 };
 

-- 
2.34.1


