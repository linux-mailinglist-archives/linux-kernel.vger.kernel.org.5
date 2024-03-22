Return-Path: <linux-kernel+bounces-111599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B527886E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7A41C21AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C394481CD;
	Fri, 22 Mar 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rzn5WAmP";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rzn5WAmP"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F1A47A73;
	Fri, 22 Mar 2024 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.57
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117154; cv=fail; b=BaRiCpzFBtSfsXY2T5lp7fjz2DC1YnnBKmk4ox3qiCusMx4o/MXeusfJY8qHzhmhReN2T1bznYUognvyK1leG1Xoo7vLMuGzrOHn4Y2wZm18ScGSUfJpVlScUSl2H9Q6zu8Vj7lKywd7in3On67AX3oVsF0cek18vp0sIcOwKYg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117154; c=relaxed/simple;
	bh=xo3aRlx5uuH/3G5EA7jlQZ7lgNbJTGdTlewdFWwmN2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QGCWk8SkZWmxIC9teIvbYo6X1//hf6LM93nS7OsVBKnuEYOgEMyZbd6IRq0Uc8ffWxLTzJB0dENKe/RtiTr29JwibEhO15OJ1SwK7o/vp61TjNvgfuvp3B4RPpxEQtadu6sPM75g7Z6Eb/czHtKZCHguWZnmB54DawwgpF2Jq9U=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=rzn5WAmP; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=rzn5WAmP; arc=fail smtp.client-ip=40.107.8.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=cB0Ww5qJMCwCDuOPBM9p5dos9KlK72dOCYsVbwvguMbOeVp4oi8e9F+qLdd7SAdQhMRPATjCZWbDDJzzalvPBvUYieHIPhtSKk1QKwDygWJVlo6UKufdprvhK536nsyq7GsBS6OMrNRxsRHZu7xDgkKSF1NNpGyZa8zlEU6nB4fC5R+XC9jpI5AhvvcKMOgbF7sGqyp9keVicYL61LE/aGQpwDD+lmSS9JwRjuZ8kTojUzrtXdBzy/n7KtwGYtH5JGyc+OSamXGD1lHnDVoLufaXk/vs7bZm6sg6V/SuEcbes2UcuDTC9t5h5gUPxRC5vEwbLuAHwohFcCvLCzCIjg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xo3aRlx5uuH/3G5EA7jlQZ7lgNbJTGdTlewdFWwmN2s=;
 b=UQZCAaWAeS73LWUtbUZlilRVnrAhpPrPo0qfZX9wMsa8zhwyi3wdRZUmJN/+VG3cW7SiQWfJUBa4uTdvIQDLHKU/+E1CxM0BGBcEsSWb6VL4QbvodwblxkUU3Uq8AKQHrXrzuKasCHYaGJSWYDm9ENrJ7Iv81seRKoV24fyW+tGsweweBZ+N0uXkLEPUcfpWunTSnuMYkKCqvdjC8YzMK6QzGA+bxUM2FHpEMgZRHzJEsCk3EOYS1uyhkvj8LIV2oVSAX5xqIwX6KZPTs72fjsJ7XF9J6evFoQRKpHr5kDEYVZzSQTy01WCW1Opasn/L6Zfhr3DK1AfeHBBvpt2TEQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xo3aRlx5uuH/3G5EA7jlQZ7lgNbJTGdTlewdFWwmN2s=;
 b=rzn5WAmPie6Ln5IOn3n722MOOkXEgYGvKx6rH6+2XnYrmmj6PHRpTAfjzudG9mUflkTPpu5rb+FyvmuUWKfa3g7diOavteNqQaCrhPRADo/Ywr7AzYdDw+La6CAhPfi4Er14D/KecPK6vWVfbhbNZlEXlWj+BAagqmwu02QmFkQ=
Received: from AS4PR09CA0028.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::16)
 by DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 14:19:08 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::da) by AS4PR09CA0028.outlook.office365.com
 (2603:10a6:20b:5d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Fri, 22 Mar 2024 14:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 14:19:07 +0000
Received: ("Tessian outbound 5ad6c4395be7:v300"); Fri, 22 Mar 2024 14:19:07 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 785bf973d5f60b6d
X-CR-MTA-TID: 64aa7808
Received: from 50fc714c5380.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 32B09E15-6D3D-4174-B285-8C4EE35F9EAE.1;
	Fri, 22 Mar 2024 14:18:56 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 50fc714c5380.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 22 Mar 2024 14:18:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvYrWRQo/I/pLbhHPLNui4y7g82VDeUg/rzQBfbCRnh87Q25XIZM7LO3p0ewLD+9GCIWXdqOIi0zTH8AOJcFHGD/Hj4aD5D89KCxtPuotYYZ+rlfnXOk5jeVAHMB8bta5/taOVp3nzECFKcnlIu1XxT0t/G6/KJduP1siHlVokLgmFUixyc66wSXshpzbGw+JFUtavOD8R6mbJsvgRWxVbDUKjU2UEBRscR5npZJGE+h1knZSuDeZtJZTDo9OAlt3a9I/B06gEqB6rZyTc1M0e0ypFQ2fVH3V5roO4pjCG4DZlUgjoMxsqJfoBkvLRuFBacFmYkc8hvoGAQVvQ5KJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xo3aRlx5uuH/3G5EA7jlQZ7lgNbJTGdTlewdFWwmN2s=;
 b=ZiU4ONQfemI80g1wWvF/VTK7jY5rOMzG06qADqIqlBOqTRRKfYHdZovK70F4YYNjP7S2qEdPRlJx7E0JCuXYKTGI6NoND0GTbsV6Xx3+LeBxmPkJJFnWzNqOARmLbthbVYhgw8G6oKEVVbRqsJcqFskuMyP5KrB/+msHfyolQpyuc9vHlmD2xYAN/g2MLIuEt+uqmcoUPbZNYZEXQyz7tdfcrE0Xr2WQR+uKLIwAMuJdpSPYAIyvkrn2wVg+5vBiEJdb0Vw6lb80fS96J+HF4XcthbQVSasjIWgMlWZWBNYNZZd4VpJCSZwRzpOBdeEwleCpBtqN90LT7sZML3bw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xo3aRlx5uuH/3G5EA7jlQZ7lgNbJTGdTlewdFWwmN2s=;
 b=rzn5WAmPie6Ln5IOn3n722MOOkXEgYGvKx6rH6+2XnYrmmj6PHRpTAfjzudG9mUflkTPpu5rb+FyvmuUWKfa3g7diOavteNqQaCrhPRADo/Ywr7AzYdDw+La6CAhPfi4Er14D/KecPK6vWVfbhbNZlEXlWj+BAagqmwu02QmFkQ=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by DBBPR08MB10530.eurprd08.prod.outlook.com (2603:10a6:10:53c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 14:18:54 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::73ea:d367:20a5:5358]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::73ea:d367:20a5:5358%4]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 14:18:54 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	Mark Rutland <Mark.Rutland@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, James Clark <James.Clark@arm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "irogers@google.com"
	<irogers@google.com>
Subject: Re: [PATCH v3 4/4] tools/perf: Allow inherit + inherit_stat +
 PERF_SAMPLE_READ when opening events
Thread-Topic: [PATCH v3 4/4] tools/perf: Allow inherit + inherit_stat +
 PERF_SAMPLE_READ when opening events
Thread-Index: AQHafFmLp88gz18WD0ONUS0W9pe2/bFDzwmA
Date: Fri, 22 Mar 2024 14:18:54 +0000
Message-ID: <bffa028a3ce0ed157560a96a1f0fc3cc5d707ecb.camel@arm.com>
References: <20240322130414.70186-1-ben.gainey@arm.com>
	 <20240322130414.70186-5-ben.gainey@arm.com>
In-Reply-To: <20240322130414.70186-5-ben.gainey@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS8PR08MB6646:EE_|DBBPR08MB10530:EE_|AM3PEPF0000A791:EE_|DB9PR08MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf67c6f-5f44-4043-850a-08dc4a7b0968
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 vD/TmNWs3yEaXD+IzV0N+cIgEl3aOXebt+dl/y/tODKUcKXjs+oHgQr4JHHchuQFCA4Xy6ZSa7jT0BV8Bz4BfvQCurggJ84kXB9NCpc8dSNCmYX2+RsBOmxlarRvGRzzw3ltSs8Ze4OxqON50tJnoNxUQ136I5gvrPPq9f8jAoupw4qF94PryH5COr+2bmPsm9dZ7irvefvScnHnjU8NV27Y3skLgBJupMNk1tPBwLEAzOrTlkUmsEfyGIeZ230xfN4qKl4xYgIdqLdXpULvbFPmrk8ygya5dTT7jLjury3a5ZclniCndvVuJuFvF5lrs6UEyNsSGDYtBL8ZZvhUeQ3LqIwUmztctisdmDDL/AO6VNPF4wD4iYSImt5o6pBSrVM3vfxQv/8VMCCfMBjeBDhzOpvGZPwGC5/oO3HR0eu8xEhN/iE0Q6N7nPpWohns/ApvcDbg9BiwpASslpXuKqZMuhe6PNesSMWLQKFw8rEfcD4QUeGzASzWIckftwjm57OwyrV1lB0JrGgOj7xryY7MmKRbOgTH4ZXXsWrmewJODFD0ZYRj7GY61D9x/36DqQzhsC/0nnA9zI7ofptS5mb/G7LuxE/uIU+h8AfBqzDPPJ0zF/jUzn71AXehkyIgFAn1BoIoQkwDf2HeMBvUr5YPBbhVZ2ZZRSjxSHgaMMo7yKsRgidfJSLqY1QMyeZPOfvk7LkSAx2EphUzSVJazQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <821E9FB75A99374FB1A877AA84D590DC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10530
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	dcb0a04b-a5db-435a-ac8c-08dc4a7b0170
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zNkYEHkWbMW906pjC7CoGCebD1jKXWaitILKwMH/GYy0/WXJY8v02UdvYq2bCao9m6zHeB/vy/G5rFBN78cPsJssBXzU+zi7A7YziZK95jkOZb3YLOhgvFhbXZU65lwx87pDjMAwfTxTNbKYS6PUpKCghP9zewzjzwwdoVCDjaPVr8ZwQClGK9zHywFzjJsolhnvO1mg4OPZjl4Ly8WQiTdT2NGjYNtq6Kjg7D9sR5CzcYKfdkUopVoYRYGBYxMisXXb4CiIUz4pOpQlE8bnnAWp0qYGsQcwvXzJYylQpjWaxwwoLVkj3x3uOAQxMPviLQysOCsxdxtmh8kuFaa8xzbVExsNS79h1LZOjKF2PWp5bOLYazQ/01RJk507uAtKHbW/DsKgkpT8QtyO3SlBiJxSILFYrJEbuRw9OkAPmCtk00txnZWIu5wcFaE4gaDCUvwfly27Da4bnDc23oSNQxv/XtdSpBt+pCrnI6K+mvXTZAYREyMJeiH2KjmViQiD6s+nfFYLwLgmoQlL/+nM4zbPOQZBc9pYIzhXNisDcOoaCGUUv7KKTTPVuS4hTuqpKP5Vpb7awJcUWPV6Wtuan7ofyRcAn60s4+kgXprGm31X/V617wKpN87tN3jmJKYl4xTg7nV4cS0mVEloCOrmngvasklT8lxjKm+gXW155cS4+ZPpsW1HCYN6kgiv1pfUw4mJnnAHskRt6+YO10hkmZyHdKu2oXH1y2PqRYhZ6rsrfBzU9nlq+IJvgEvNrS2S
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 14:19:07.8420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf67c6f-5f44-4043-850a-08dc4a7b0968
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6619

T24gRnJpLCAyMDI0LTAzLTIyIGF0IDEzOjA0ICswMDAwLCBCZW4gR2FpbmV5IHdyb3RlOg0KPiBU
aGlzIGNoYW5nZSB1cGRhdGVzIGV2c2VsIHRvIGFsbG93IHRoZSBjb21iaW5hdGlvbiBvZiBpbmhl
cml0DQo+IGFuZCBQRVJGX1NBTVBMRV9SRUFELg0KPg0KPiBBIGZhbGxiYWNrIGlzIGltcGxlbWVu
dGVkIGZvciBrZXJuZWwgdmVyc2lvbnMgd2hlcmUgdGhpcyBmZWF0dXJlIGlzDQo+IG5vdA0KPiBz
dXBwb3J0ZWQuDQo+DQo+IFRoZSB1c2VyIG11c3QgcGFzcyAtLXN0YXQgb3B0aW9uIHRvIHBlcmYg
cmVjb3JkIHRvIG9wdCBpbnRvIHRoaXMgbmV3DQo+IGJlaGF2aW91ci4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogQmVuIEdhaW5leSA8YmVuLmdhaW5leUBhcm0uY29tPg0KPiAtLS0NCj4gIHRvb2xzL3Bl
cmYvdGVzdHMvYXR0ci9iYXNlLXJlY29yZCAgICAgICAgICAgICB8ICAyICstDQo+ICB0b29scy9w
ZXJmL3Rlc3RzL2F0dHIvYmFzZS1zdGF0ICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgdG9vbHMv
cGVyZi90ZXN0cy9hdHRyL3N5c3RlbS13aWRlLWR1bW15ICAgICAgIHwgIDIgKy0NCj4gIHRvb2xz
L3BlcmYvdGVzdHMvYXR0ci90ZXN0LXJlY29yZC1kdW1teS1DMCAgICB8ICAyICstDQo+ICAuLi4v
dGVzdC1yZWNvcmQtZ3JvdXAtc2FtcGxpbmctaW5oZXJpdC1zdGF0ICAgfCA2MiArKysrKysrKysr
KysrKw0KPiAgdG9vbHMvcGVyZi91dGlsL2V2c2VsLmMgICAgICAgICAgICAgICAgICAgICAgIHwg
ODINCj4gKysrKysrKysrKysrKysrKysrLQ0KPiAgdG9vbHMvcGVyZi91dGlsL2V2c2VsLmggICAg
ICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KPiAgNyBmaWxlcyBjaGFuZ2VkLCAxNDcgaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9wZXJm
L3Rlc3RzL2F0dHIvdGVzdC1yZWNvcmQtZ3JvdXAtc2FtcGxpbmctDQo+IGluaGVyaXQtc3RhdA0K
Pg0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi90ZXN0cy9hdHRyL2Jhc2UtcmVjb3JkDQo+IGIv
dG9vbHMvcGVyZi90ZXN0cy9hdHRyL2Jhc2UtcmVjb3JkDQo+IGluZGV4IGI0NGU0ZTZlNDQ0My4u
ZGQ3NmZiZGI2MjhmIDEwMDY0NA0KPiAtLS0gYS90b29scy9wZXJmL3Rlc3RzL2F0dHIvYmFzZS1y
ZWNvcmQNCj4gKysrIGIvdG9vbHMvcGVyZi90ZXN0cy9hdHRyL2Jhc2UtcmVjb3JkDQo+IEBAIC01
LDcgKzUsNyBAQCBncm91cF9mZD0tMQ0KPiAgZmxhZ3M9MHw4DQo+ICBjcHU9Kg0KPiAgdHlwZT0w
fDENCj4gLXNpemU9MTM2DQo+ICtzaXplPTE0NA0KDQpTaWdoLi4uIHRoaXMgb25lIGJlbG9uZ3Mg
ZWxzZXdoZXJlLiBUb28gbWFueSBzcGlubmluZyBwbGF0ZXMuDQoNCkknbGwgaGF2ZSB0byByZWRv
IHRoaXMgb25lIHdpdGggdGhlIGNvcnJlY3Qgc2l6ZT0gdmFsdWUuDQoNClJlZ2FyZHMNCkJlbg0K
SU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRh
Y2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5
b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5k
ZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90
aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUg
aW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K

