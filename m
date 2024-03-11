Return-Path: <linux-kernel+bounces-98551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B2C877BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3BE4B20CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B58212B70;
	Mon, 11 Mar 2024 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7yNmZXum";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7yNmZXum"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3F914271;
	Mon, 11 Mar 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710146723; cv=fail; b=AA8jLWtIjx9PW77fyDHoTcvs4ZGBvzR7ovJR/lLCssexx562eOjJtQdSv7NUldF+sfVuiN6CgDBjSlLUyqe/IPnINSCjWMnG0sTFjnsH2v8XccUFdgGkmTxkX7jEPZTu9UqdDjRB6Ipu2l12n9HCKSYXOMRzRHBrd+YXpiX1eHo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710146723; c=relaxed/simple;
	bh=xlXcpoW1HY5XbY2tIqG2I0ioy0GbnhsMyif1T7i30YM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N9Eyk6zIfLfyOm2+kGpT6fsGjaNHMHn5jtBGoUvAcU4C0aZWHVVkADIzK3eaARdrORWAwu6gLzJMVqF9BcHBdm70czGgqqIYNLkinW/G1FEV2TljG93OEA/gulY5N7cxpSWN5Fvm++3bwODsacyToWiPGb5rJn8doHdSTP0a0ak=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=7yNmZXum; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=7yNmZXum; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=C8o+Pv0E+QifhksaoX608sclBfCX8O7evble/uY2uk8FK72abjhzYJWj5fVqpPMdmgqTU9yUZU8Cv/SRQOvgOy+kC/frnb8iau2EcTgBs3SVK8JVUe0ryaupyJkqB1AQteM26ZjH4VRvm8JK2n+9Rv6Akzzq/Mf6EZEZkb2CBigDzTj7m3wvI0SMubmE7mbl1buVkHJHml/yZ9k9Lk7N5Xix65wWCSY/8IyQlI/PDk9Aii+Y2emS98mFmF2zk41d59RR8fNmnXlGd50YEYkj9ZH5QGpZk8/RT08I9g+Hl6C/0tNSv+Q/nN9JLDiulM7eGUoLnCufSHNWtnjaAfi25w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3na7lJ+9uU8/Azhtx/hu4dGwwlR8YPrHIpb4S7bXxtA=;
 b=NRwzEHs6Sn8RNlhKz6kj0rDiINOiI0+OVReNGBjQkvqqlHxFX5YsdhiPnyjn+HL6l2HjuHhQ1EfaRqEssaHfWzKAcUIORxUtJnry/oKXSsu50kaZtlCDN+qXidI/ZCVLEek3V9jvhGJAIdOxZvJNcCMDBtlWycITN75Elr7MEzYGpMkngt5rjGpmAr5WW/p3UiKfrFgBfuD0/M8dT6m0ADKHJC2dgguSJuTyAleBW7xVlWIRis72f+PIskcxFo+ql9NjTlGiv+xFZ3JyGBQfEhkVlC5rTw7HslkXReXkSaP2T+5q7wAAEF8ZbdPfBvtzZhyqO79yhwyjxrLfCF7c7w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3na7lJ+9uU8/Azhtx/hu4dGwwlR8YPrHIpb4S7bXxtA=;
 b=7yNmZXumfOqotPYRRJmKYyuFg76szPhCjqBxWotNr1h9hOxL4WLM51khDQ4zSlqpsShA0JBVAHkSGI8hgbx8A1ApC/Ay1l6JZV45enRoMIn399zZic0oUmstMJWt5rdqCKDHv0hHwqLXodlPwQ1uAfLmmCwZg7V69rQcPqRJlFI=
Received: from DUZPR01CA0080.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::9) by PA4PR08MB7435.eurprd08.prod.outlook.com
 (2603:10a6:102:2a6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 08:45:17 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:46a:cafe::3e) by DUZPR01CA0080.outlook.office365.com
 (2603:10a6:10:46a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 08:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 08:45:16 +0000
Received: ("Tessian outbound 456a16a4297b:v276"); Mon, 11 Mar 2024 08:45:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5d63408888937d48
X-CR-MTA-TID: 64aa7808
Received: from de800c37d027.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id A5C68ABE-42F4-45D0-AB3B-2B77DCE60F8A.1;
	Mon, 11 Mar 2024 08:45:10 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id de800c37d027.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 11 Mar 2024 08:45:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR7muyITHQSmDPsW3keDiZ7N4TgLl4KmWOS0drHRq8YyA9Rn/dkqX1kebveM8GRJvod/YLTUEWcukRq9Wbo8xMHctBgpE2YXnVEOWCTlrbgwFXzpUB/Q2pYWhYQVk0HYu6dUCMpa1eY5++Ic8DQ55UkBV7lZj3Zal/AdRcDPX/3GUQVRgFH0Yn9KTjx6u9H9fFzKBTbV2U11qSrbFkSCVZLpNRqoROf4VLdDCEcN2e0rKEnQZGrgxrzjZFDPbqzZlC4hbdez931a8yQwRx3PGUTCNQmbzl7xguIQjIAZaYifPUq+xYKbugmWeeSifXsBkD8OMzq2dVk62gOW7Rs48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3na7lJ+9uU8/Azhtx/hu4dGwwlR8YPrHIpb4S7bXxtA=;
 b=VWK/Pj4NJEgIcVXCqF585Y6tpYj82gutO/t8nb7aZsbPNm/0bcbxlaAJaTTTyIF2aLyVtV+cSF8ChPYlTPXjSq4Bws0wSigNdM3Z7XROYefH9Drl2uMpivuRE4Qo6FHk0ZIE2IV/qHOGD0H/3roZBwtZ/mSOFzdmuus23DKzpiKmDUQENd13rZrbD9ItwT419M+iL5kPQ0CBHlOXajYJ4GPg0vUOqMiTE3EYRILRPvuNfj+8Jo/dHM4dMmrO4kqTDRAJrMWPQSPeFROcKfFm7huuR8ozY6p88tfmnQFq2e2F6uDVhotDBlpPfhKq0XLnDBp7aXt1JV9jkel3T6Es+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3na7lJ+9uU8/Azhtx/hu4dGwwlR8YPrHIpb4S7bXxtA=;
 b=7yNmZXumfOqotPYRRJmKYyuFg76szPhCjqBxWotNr1h9hOxL4WLM51khDQ4zSlqpsShA0JBVAHkSGI8hgbx8A1ApC/Ay1l6JZV45enRoMIn399zZic0oUmstMJWt5rdqCKDHv0hHwqLXodlPwQ1uAfLmmCwZg7V69rQcPqRJlFI=
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com (2603:10a6:208:148::12)
 by AS2PR08MB9391.eurprd08.prod.outlook.com (2603:10a6:20b:595::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 08:45:08 +0000
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::4a5d:48:bf49:a524]) by AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::4a5d:48:bf49:a524%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 08:45:08 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Catalin Marinas
	<Catalin.Marinas@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Will Deacon
	<will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Aaron Lu
	<aaron.lu@intel.com>
Subject: Re: [RFC PATCH] sched: Add missing memory barrier in switch_mm_cid
Thread-Topic: [RFC PATCH] sched: Add missing memory barrier in switch_mm_cid
Thread-Index: AQHab9qBv07DN8ioIEGwFWG/l1dpWLEyNKPT
Date: Mon, 11 Mar 2024 08:45:07 +0000
Message-ID:
 <AM0PR08MB428936EACB47856176BFDD8CFB242@AM0PR08MB4289.eurprd08.prod.outlook.com>
References: <20240306152443.6340-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20240306152443.6340-1-mathieu.desnoyers@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AM0PR08MB4289:EE_|AS2PR08MB9391:EE_|DU2PEPF00028CFC:EE_|PA4PR08MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 836abd7a-06ff-4894-f0b8-08dc41a7937b
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 DJgp73ATeKEPSfl96XHw2jR5IFWG/4teD77Kdos1O+zJBEzL45FBmzkBOhECsvYGJdc8yE1o2kMo0nDQu8FPPxpypR5gYnkQBvEYPj/ES+RSMk6S4sPHhlMJNymEugxehsCYiDshi8DfSSpfa/yFg3mTd/xi8q7e5qOMng0QjniyrGwU9nb1w0vMCKTZpLVT0TVczJ7OQjNueRWV6vzlrQArxQxkaJcXRzM9L54CLoM4Br2GOXKCrDpnrSktNmAOPc76FP7uBEI1AAXtJe3ysmJQR06CM5+fVaZkKchrMzWMomZDn5daIht4XRFkNlVG18NhN6k6YSyPM9uOvJ51Bq0UkQ0KYdoL7fk5yXFfhiNNzecJHChij+Egm4AGY9IBqM0t70647JhpLXJ+DzmZdKSaARs12i14TtWLm81pNfTdqL2vGAosfDxSoz0KHFVJONLuXPlBAmhp1Q6o5oWEYlJTBVZm5Iq4ilVZDGAA1oU4y37hTERORNPMMhgAQnblvzu0CF2ZEJrAmLFge6MkD72uAimyDC8NFBa5XFXQxHasIEVL7o/i9nOMIF6mh90J3ZIhwZklLLjhyrL4K6FYb64nE/1GCvML7pC8IWCosW4wcUCMq6VLlb9xZgfpo33qb/E+nkNII+fPtbkzDU0FaGNVdfL+0wt+yXYk9qzGRyILKAqBYYD/3bBF4Fkcp73vhIQijrhVp/OqpKJ+z/sKCim3gT9ZEHkLinzkf3QNDgw=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB4289.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9391
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1dcad2f7-caf0-4963-56a7-08dc41a78e20
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p7wWLvdHgGxIPLkTB7fQ4h3w1OdtzOgZ53v4uGFDgt3ii6Zk7CiV9TwVHjwBw45CAyApqesA9WJOs3UBzq2jJ+WXTIsyvaufTqQstEHpQI/aSCkqtHEBPFo85lgHXTcriHPVh6qR7IRdkLtP3LOdduGuuOpKHlHQkVpMXW3BUL5UGQXltd41o3J9v4hFyI3G1JRqMs+Q1folVwkjKh/yzeQjPiKCf26NHcR2sP1UFkJhAxudTr7AmnayrWX6iz9czT2cBL7idOBYqo9udGWVOZPlHPOC34+pK78oHyRNsHUeXkxVRV8wXEV6DD+f3o4BUpHdSRfcy5XNNnz6ObW6U4asVeE/8IY52WdgAg5mkc7CoymzMPVSl8VOzPZPVCO1tE0e1IjVk7B+z6hECLb6UGngD2bWfP96FROcRdFRALuUt2l27ltq6BG34y/8MAFhHVNQiJdv70IDcHrqHyFs2wNkz0CsZsT4xuvb7udFSg0UDPu/Ki2KhBGA8qD1zFE10xOMnJkhAF1OO778tdJZp5bpudYcF5wZkB+CT0KmmqDjpPr0DCtcDqis7UmEzQBPapKzGmV77T1KylRKp00i6S2PVQryuKtNwmGVavSWa3OGH0Ka+KHUDXXXaQecuBsQ7xt2Tp8JV+OWoRH0NnqAGl18VXN+sdDNWWpDzCvYK7bRdPMz1mcT6n5kIV58qqxXY29DLKRG+OTYYaKl7B5q14fPHOSZaNfR5NXv3WuVWNk1N026CQzg9HcLwoGrBoyl
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 08:45:16.9484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 836abd7a-06ff-4894-f0b8-08dc41a7937b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7435

Hi. Mathieu. Sorry to late answer.

> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrie=
r.h
> index 35389b2af88e..0d5e54201eb2 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -79,6 +79,9 @@ do {                                                   =
               \
>  #define __smp_mb__before_atomic()      do { } while (0)
>  #define __smp_mb__after_atomic()       do { } while (0)

> +/* Writing to CR3 provides a full memory barrier in switch_mm(). */
> +#define smp_mb__after_switch_mm()      do { } while (0)
> +
> #include <asm-generic/barrier.h>

IIUC, ppc already does smp_mb() in switch_mm.

Would it better to add the same macro which do nothing to pcc?\\

Thanks!

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

