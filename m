Return-Path: <linux-kernel+bounces-135167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1AD89BBF8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF251F22EEE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ED94C634;
	Mon,  8 Apr 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7b9bEx/y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7b9bEx/y"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2044.outbound.protection.outlook.com [40.107.15.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F8928370;
	Mon,  8 Apr 2024 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.44
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569127; cv=fail; b=dgbN6eEmrCDWp6qFYwysoe/dEnZvfha6tVIrDgTu+FeULAReUiVMpewRKqLJVSqcbFU57kgJ4QaFUEdeWzJ/AL9JhWBuVPwALNuRakfTDdWQj84P4ixJHrBPN4FI1+3dpdKohIDnaKvfAtxV77oquHUUUGYRrIFKbi84SHJIEVM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569127; c=relaxed/simple;
	bh=ZbMUu9j05UEeUq9kkz+Yi0LziYwtlONwfmE1RrZF6mw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BnEHomgA3EhADo/JuzwdxKNOBE90Y7Ex4slsABMCFNd9dEAus8eVNi/qSYwiKG+d4bhIRWduZheJdHHrEGEvtSzN/XgoSYEx+9g4MkdggfWJ9vrEOUoG7Az6T8v9AUfz6wzoJeRxhctd8HEO0GxMyLwmPnCbEamQdQL9ECr59js=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=7b9bEx/y; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=7b9bEx/y; arc=fail smtp.client-ip=40.107.15.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=YMROZNlrXK2enC22EUAqpppcMNsOqGP3c6pUtBjpR07O7qpW1P7ylVMJ0Zac1LVT4d8wHnEnXPJvVqxqHnrteYJ/yPnr7SsMlUqho/BLYTOr9/1a16b0N2fTMi2Ds9SKAa562C8Vc+bQg9STiMBDZ+VUtomkQrvjtIoo42JjochSkypfVBPKGC9rKxI7e4AhjcfqCSyi/6itDGZ2CoJ0HNLxaFk8FrKY6ku+PeYccvGBFq3aetr8lPJhzL3bRA8Y8N6jZg60Cg97XYKwzNiVe7wqCHiGHbDrdgy7ppN6whbj+yDRIPiz3Y6m5Rsj1C6oadgFDCensvbPkA1dB8pvQw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UI5ySwDKYygqGznq6FpvfGn0WdSLsvDiwcOjynefKZg=;
 b=MxpZfWFMTpGM8W2VUIiHmYnjQ67taA2FyDRGDpZ+r1raZOq8JMd/Bt8oauNJyrRcUs5Bmg1y+ttMIMiOlwdAg2EwBeXDz2BvW/PsTU+R9upOTtvQIZmGg3OIkqUPgHZY9dZEXykBMgK/53OcHb0vF4POX79knjnhJ9HyrKhjtZ0Y7gm5aInZlC+Ci+PzbVhN1wMKxSFA9O5m8sQ6myan658FSP/Ts19GsqHkcWEvZnIK3oFBrLZ/tQpt3aAs4WHu7vqP3XdFqhIp7LT3l2MJ0/BAh+v+GxwqTPszdSlOfnntZu136iBAvMBrTj6UfK6VuU6pLjFNQXWeFCDk91qy2g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI5ySwDKYygqGznq6FpvfGn0WdSLsvDiwcOjynefKZg=;
 b=7b9bEx/yv+jMWz2/MMVE2hMfryAi5DU/27k1isayLVd+YzLkSMc+OlrEPOVZwxnIdU9QbpGUeYmjTBEGRUsxGCYPR7bKublYsd5zcjr6yYAKMmayJ4VMhE+lKYoQDpwuDZX3UYFpdQC8BonuRS71UwI3VDzvRqTOdLSWTCFenbg=
Received: from DUZP191CA0043.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::26)
 by AS4PR08MB7735.eurprd08.prod.outlook.com (2603:10a6:20b:512::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 09:38:22 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::9e) by DUZP191CA0043.outlook.office365.com
 (2603:10a6:10:4f8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.30 via Frontend
 Transport; Mon, 8 Apr 2024 09:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7452.22
 via Frontend Transport; Mon, 8 Apr 2024 09:38:22 +0000
Received: ("Tessian outbound ff4e98f65004:v300"); Mon, 08 Apr 2024 09:38:22 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2cad97313a622f74
X-CR-MTA-TID: 64aa7808
Received: from d7f8426bcc4f.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id B2B241E5-C535-47D7-87C1-65856E8EA2E5.1;
	Mon, 08 Apr 2024 09:38:11 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d7f8426bcc4f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 08 Apr 2024 09:38:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITvXaiuA4dMdgmxW8hfjfkdW7/izvpk3CZd+DIUKpztuAVFkM5fMHpC87gxIYX3Iagiqq++gnUtFuf9jiEI7ilmsSmv+u2K07fAfB232GYcE7ThRO1g4ozDFBblC1Zj+t4r+1cM9HFFJGmO8kWId3vX3p1pYcdPHecITBwt6vfo49Xr8gr4h+9cT5U2KMly56nsE5VHJMFtC25kfG3QIuMVAUTqXKN0YXWhVl8XK/rpj5F2xMohUoyhBTxyFG/Bt3o7EtQ4Q0JAZ2eLB5hK7CsJWkyi98D08U68RVzkGNmqV9gyg2K+gz7qtEPFcsMsCypmLGScVXuF+ekQoZBCnnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UI5ySwDKYygqGznq6FpvfGn0WdSLsvDiwcOjynefKZg=;
 b=gFsVbsVp0P5cTTA/jNbvrGmhiEAkQXts5Teb/mPKCHe+KNWsBKR9BU/jqowolYXuVo73CVd8HBKoTScBpcYW5u3bhEg/Eb8kgvZaq58EtpTCP9Arye+GVKgtEAhpxro84jtvNxFGWo0h/9rkjVwzVBpKXYgGBR3+jE7WsVQR5n+nX4grBDe4hDbUPWCylmIMD5PzosGfii0Wl+Encjr8detmI3spMbT4dlpLYwJ6uz8MRXQSV1I+1Ptk95VQgT73w1twECi/psPjlnOt+o0JVcCLXYeRRkpc9UZrqP/Q3rSI2CtikplinjoRLYsB8ehA3ikc/xvcHqi/DiLagJthhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI5ySwDKYygqGznq6FpvfGn0WdSLsvDiwcOjynefKZg=;
 b=7b9bEx/yv+jMWz2/MMVE2hMfryAi5DU/27k1isayLVd+YzLkSMc+OlrEPOVZwxnIdU9QbpGUeYmjTBEGRUsxGCYPR7bKublYsd5zcjr6yYAKMmayJ4VMhE+lKYoQDpwuDZX3UYFpdQC8BonuRS71UwI3VDzvRqTOdLSWTCFenbg=
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com (2603:10a6:208:148::12)
 by GVXPR08MB7680.eurprd08.prod.outlook.com (2603:10a6:150:6e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 09:38:06 +0000
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::4a5d:48:bf49:a524]) by AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::4a5d:48:bf49:a524%7]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 09:38:05 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri
 Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland
	<Mark.Rutland@arm.com>, Will Deacon <will@kernel.org>, Aaron Lu
	<aaron.lu@intel.com>
Subject: Re: [PATCH] sched: Add missing memory barrier in switch_mm_cid
Thread-Topic: [PATCH] sched: Add missing memory barrier in switch_mm_cid
Thread-Index: AQHacWpg4RzUFZ0isEaP3JURG6Kl97E+2mIUgB9zq54=
Date: Mon, 8 Apr 2024 09:38:05 +0000
Message-ID:
 <AM0PR08MB428921B21B38D517A8A61FC4FB002@AM0PR08MB4289.eurprd08.prod.outlook.com>
References: <20240308150719.676738-1-mathieu.desnoyers@efficios.com>
 <AM0PR08MB42895432478A020E2C5B6C5FFB2C2@AM0PR08MB4289.eurprd08.prod.outlook.com>
In-Reply-To:
 <AM0PR08MB42895432478A020E2C5B6C5FFB2C2@AM0PR08MB4289.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-traffictypediagnostic:
	AM0PR08MB4289:EE_|GVXPR08MB7680:EE_|DU2PEPF00028D01:EE_|AS4PR08MB7735:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 HM7LmNYRJ77sDz9mwYzXEnyDVoM1TAmZLjwhD46os4qPVk6tfqLNCVnzkdn3JkKyNIhzKAx0UHHyPHT1INo7wn1Wh4EgYOzacmvgYOYDQgGb5ppgRX5lpJ3vv/RFlWjBPWNd0Oz4VgHfq8WEKMVOV1JvOucdRwaM4I1koQAzG7uhV05CgpCkAs82pMuGl5N90aYcThmTFdrV8WZKqUE4xxeshDtPhq92moAGMYPfh4/Skva7OMCDuq2JoHXOp54fRvqQTaiTFtDl/+GpLZ1Zo7GhsE253yr29chI+S1fLrtyYZLgD1CL20d6P/O31vfw9XTCffetjqvduXA+HZSWm8o4HqO5aC35Nj6ivvikrTG53/ew/3pHevry1jyyn62o3QEJXJgTr6smj9WQVDALFeS7QSIby4cr2b5yiH/vHMgny37ByDWu/8XqtPSUMF4TlovjTJ3UOFHpddLp41bDDaUPdmwgE3fJ9KuWbRijTQsMcxkTV7e4cPRYeEaMHySLFfcxUzS44lBywzlpweK9m+kCdqOO1ipndch7qwHjeJAG1/5Bl3gdO9v85R3NQnZd+ZJt7rORms9SmlcTds2UFHY6VLxlxonqbsXcXfCNmQ4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB4289.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7680
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 895f9def-60d9-4f8f-1bb5-08dc57afa1e7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bxEZKjTGwRJ9yam1rno9PCXykpm2i1Ja5vDjxGskLjEKpW3kUQmc2YrHVxz9GqCPouSzPPqk6HL5jBUza3GH9P+W6TxykIMHzNfTkRzRNgHYBLCfstz135FwMm5ssyzFP1QcQ9DJrOEfCNUv/xDrXVzCaRlL6f8vEudx3+3uuh01QGIN2P97Khyvm5KNz2GkX5R5yznbTYT2jb7yxpGlWA5rgmKglZF4R/te4YgpdIQLrx0sQ68k/aL2ZbyAGfPFsYnBBEfnec1hpKghiOZ+nVzYR3+gva5RKJ4yuJh512ymLnzkKc4TNAuWcn+v+HjDUXiC5NKsOHi9aY1ows9PWUuxhlIsg8irI8Q8wGQgIFn/LdSG3QjHvs8JA9aSnVYZJumPU07tXLjOXmTzL0br2z5/7B8IohCf8PrOFk42lhCbhU3GNFpcAgjgCGTx6JqJrWUqikOvhqI4mfGUEqzR3qTQpvLjG9guKvX8KqOPqII8A66LrbHIOzZrc46n17dkFr/oLTlT0tF/EvrZ+I3dGvkq3iFIVnAm1Nk2aD2VY4OpCuxRvk6Nxohwxx15X0uTcMO9kPn3XrcpU6JiqpUV+yM/WrjikyOEyUaFJr9q9BDOCeFVxEmjs9/ORcGW+8wTch0JMeeyieGDHspRe96luYL13g+oOSG7wG0DJoaLv0RGQ8qP1M1Bnsl8N0G6yvNo7L4DxPIOzERlv0JbqE7r9g==
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 09:38:22.6938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 895f9def-60d9-4f8f-1bb5-08dc57afa1e7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7735

Gentle ping...

________________________________________
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
Sent: 19 March 2024 09:20
To: Mathieu Desnoyers; Ingo Molnar; Peter Zijlstra
Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; Steven Rostedt; V=
incent Guittot; Juri Lelli; Dietmar Eggemann; Ben Segall; Mel Gorman; Danie=
l Bristot de Oliveira; Valentin Schneider; Catalin Marinas; Mark Rutland; W=
ill Deacon; Aaron Lu
Subject: Re: [PATCH] sched: Add missing memory barrier in switch_mm_cid

Gentle ping.

________________________________________
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Sent: 08 March 2024 15:07
To: Ingo Molnar; Peter Zijlstra
Cc: linux-kernel@vger.kernel.org; Mathieu Desnoyers; Yeo Reum Yun; stable@v=
ger.kernel.org; Steven Rostedt; Vincent Guittot; Juri Lelli; Dietmar Eggema=
nn; Ben Segall; Mel Gorman; Daniel Bristot de Oliveira; Valentin Schneider;=
 Catalin Marinas; Mark Rutland; Will Deacon; Aaron Lu
Subject: [PATCH] sched: Add missing memory barrier in switch_mm_cid

Many architectures' switch_mm() (e.g. arm64) do not have an smp_mb()
which the core scheduler code has depended upon since commit:

    commit 223baf9d17f25 ("sched: Fix performance regression introduced by =
mm_cid")

If switch_mm() doesn't call smp_mb(), sched_mm_cid_remote_clear() can
unset the actively used cid when it fails to observe active task after it
sets lazy_put.

There *is* a memory barrier between storing to rq->curr and _return to
userspace_ (as required by membarrier), but the rseq mm_cid has stricter
requirements: the barrier needs to be issued between store to rq->curr
and switch_mm_cid(), which happens earlier than:

- spin_unlock(),
- switch_to().

So it's fine when the architecture switch_mm happens to have that barrier
already, but less so when the architecture only provides the full barrier
in switch_to() or spin_unlock().

It is a bug in the rseq switch_mm_cid() implementation. All architectures
that don't have memory barriers in switch_mm(), but rather have the full
barrier either in finish_lock_switch() or switch_to() have them too late
for the needs of switch_mm_cid().

Introduce a new smp_mb__after_switch_mm(), defined as smp_mb() in the
generic barrier.h header, and use it in switch_mm_cid() for scheduler
transitions where switch_mm() is expected to provide a memory barrier.

Architectures can override smp_mb__after_switch_mm() if their
switch_mm() implementation provides an implicit memory barrier.
Override it with a no-op on x86 which implicitly provide this memory
barrier by writing to CR3.

Link: https://lore.kernel.org/lkml/20240305145335.2696125-1-yeoreum.yun@arm=
com/
Reported-by: levi.yun <yeoreum.yun@arm.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_ci=
d")
Cc: <stable@vger.kernel.org> # 6.4.x
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: levi.yun <yeoreum.yun@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Aaron Lu <aaron.lu@intel.com>
---
 arch/x86/include/asm/barrier.h |  3 +++
 include/asm-generic/barrier.h  |  8 ++++++++
 kernel/sched/sched.h           | 20 ++++++++++++++------
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.=
h
index 35389b2af88e..0d5e54201eb2 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -79,6 +79,9 @@ do {                                                     =
             \
 #define __smp_mb__before_atomic()      do { } while (0)
 #define __smp_mb__after_atomic()       do { } while (0)

+/* Writing to CR3 provides a full memory barrier in switch_mm(). */
+#define smp_mb__after_switch_mm()      do { } while (0)
+
 #include <asm-generic/barrier.h>

 /*
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 961f4d88f9ef..5a6c94d7a598 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -296,5 +296,13 @@ do {                                                  =
                     \
 #define io_stop_wc() do { } while (0)
 #endif

+/*
+ * Architectures that guarantee an implicit smp_mb() in switch_mm()
+ * can override smp_mb__after_switch_mm.
+ */
+#ifndef smp_mb__after_switch_mm
+#define smp_mb__after_switch_mm()      smp_mb()
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e5a95486a42..044d842c696c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -79,6 +79,8 @@
 # include <asm/paravirt_api_clock.h>
 #endif

+#include <asm/barrier.h>
+
 #include "cpupri.h"
 #include "cpudeadline.h"

@@ -3481,13 +3483,19 @@ static inline void switch_mm_cid(struct rq *rq,
                 * between rq->curr store and load of {prev,next}->mm->pcpu=
_cid[cpu].
                 * Provide it here.
                 */
-               if (!prev->mm)                          // from kernel
+               if (!prev->mm) {                        // from kernel
                        smp_mb();
-               /*
-                * user -> user transition guarantees a memory barrier thro=
ugh
-                * switch_mm() when current->mm changes. If current->mm is
-                * unchanged, no barrier is needed.
-                */
+               } else {                                // from user
+                       /*
+                        * user -> user transition relies on an implicit
+                        * memory barrier in switch_mm() when
+                        * current->mm changes. If the architecture
+                        * switch_mm() does not have an implicit memory
+                        * barrier, it is emitted here.  If current->mm
+                        * is unchanged, no barrier is needed.
+                        */
+                       smp_mb__after_switch_mm();
+               }
        }
        if (prev->mm_cid_active) {
                mm_cid_snapshot_time(rq, prev->mm);
--
2.39.2

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

