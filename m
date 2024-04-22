Return-Path: <linux-kernel+bounces-153561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6F68ACF9D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C03E8B228A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DB415219E;
	Mon, 22 Apr 2024 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="arZz2iCW";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="arZz2iCW"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1BF152169;
	Mon, 22 Apr 2024 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.40
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796826; cv=fail; b=d0tqM0s8elGaQ6qso5RjU8clRLA+a+cyAZgrnWGePeCZLR+TQ31C4O+Q0Qen2fLgAk9YtkawStLD27+/sU4nm5VWOKqssdsPQ9z0jqWHlCpG5Vz9eP/JHQImTtsjHuARa2u10CPVBk3Nam7UmTQeFOjfbZu8EGcqyisOVrOtCJU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796826; c=relaxed/simple;
	bh=OpgOwHEwuKtCwsjq57apSDPzowoLTtP514sCwh+fVnE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LN/y9udA23hgzsaLzhyLlUrT3lzvnkOUl9p8cejlf2pJmn4aVozMso5OlWwepY+RKIfvT2I/wQZDRWO6mAMFk6f1/HD/DD7tSRahpDx0SXWwqDJPx9ENJxkwC/6kVnwUoLImy8hjJOEYsHJWFioJ2yEHTYF02HLJllghgIp2c7o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=arZz2iCW; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=arZz2iCW; arc=fail smtp.client-ip=40.107.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=P5kHJGDfDzFk7Bv0iaIwfS3LNQQPupDGNgfbVsWEyYC17Y1m+AbmgkTqtlUVTxavPEIpYKYsLv8tkoBQdM5N4mZxTN9g88xcgOf+kkcrTEwiL426Lc3OFa/+FX2g07VE9jNbsNu41ZzDTiUH9kmz2ChO5uJZX+Vx+6GZ+FUGfmNnGoZlfuQ/mRt1fV5+ikqyQtBCWJDMW31HL0Nkqc81GsDnvdONblSS4mtyTaY8kZ954tf3pi9vnkRXCyoPQr5wTEbzkqimblG4Y61/ycBny3ll1RI7IDFD425um7Wk4cBZN6ADWIGtd+Lmj+tYOe3EZ/XrA6etAtgs2zB09SNN1g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpgOwHEwuKtCwsjq57apSDPzowoLTtP514sCwh+fVnE=;
 b=nFxfjHrvM5eDLjO0xxSKqQyeYc82cL4GlYRlfInz+J6bdKi5i+xDgLAyxOJkQTBJSNYGFPuD7vL8APfXsBrS3NDInGASGgDXGKKmk2RDcwAOIwayyv2HD+zzP8rkp+7A2812IUJh7rBpXvhTp/y+atptQXKnzzM4QoZdGF3kiyvASucUelQ4oNdHfODKdg9pZ6M3prTskHrmnAk7GgutpLn77QzCPkzS2qXURD/rNFNNnCSKuFQ6N09HzaMvIXh5RHepQ7TZmHPoDkDjwS8lBpL4hIGz0fIaq4qSMIk0zi7QzyrA9Z0vD5DRcDm/sN/9te5v2YbOhVv3PWSgq3Y/dA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpgOwHEwuKtCwsjq57apSDPzowoLTtP514sCwh+fVnE=;
 b=arZz2iCWAqa8E4MTGfNcnMY8wmR9lSM9c+/ADhLevBhINq+q5vTXRvq0aJTspEPIvUkIjP2jbg9tVt0Ivhs50eryFg8NP4qV0W8JGFjW6zLbUX29pHKp6bqjZ90Zc/DyaDUcjLcI0uqitK8w9+RLfTEjVrRuCXc5CZ/WzT/jVxk=
Received: from AS9P250CA0019.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::23)
 by PAWPR08MB9472.eurprd08.prod.outlook.com (2603:10a6:102:2e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:40:16 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:20b:532:cafe::3b) by AS9P250CA0019.outlook.office365.com
 (2603:10a6:20b:532::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 14:40:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7519.19
 via Frontend Transport; Mon, 22 Apr 2024 14:40:15 +0000
Received: ("Tessian outbound e14047529286:v313"); Mon, 22 Apr 2024 14:40:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e1b7c76f66032779
X-CR-MTA-TID: 64aa7808
Received: from 6c5a6e1653a2.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4348AF87-3DB2-42DE-97CF-824D2EB79F82.1;
	Mon, 22 Apr 2024 14:40:05 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6c5a6e1653a2.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 22 Apr 2024 14:40:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alD5aMmTk6EahWD1bPgdxVKsuu6Q1uF95Ym5HPBj4oa//Di6YrVTUJZJ/iqK/VWOiVdobaHRu9nM+kE2/m2+eqiXuirFBLVvmDPXQmTjmCQC61hNqs73DuTaqVp5xA/wLAD/rU8YhC6xWT637Rlq4qbngOeoUWHq25eZTbjbcaRCjLb+IZj8YQPFHRB9EDSTqyLtQkLu+3yjRQcfCoBbd6c3jXuhmoQG7LGnLVZn85K0sQlDbdmD68mLZOdJOt6yylqCuy14I534/hqUdMl/RYTHVdMCHc8qgruduG/mOQs/y6T1roL8QOMSKveAMMMGaBZjO2NZUZgEOOY3QcituQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpgOwHEwuKtCwsjq57apSDPzowoLTtP514sCwh+fVnE=;
 b=DdZnV7mmkJBVVnkIDpULkR2U8QuPr+04BuS53JJlpOeGwrJSxgSZd34AlSNiTCfiqM0VQcny33irZx8wiZEg3ABapiDazAVp3fYjPEboGHnDnEm8RMdQXYxd+52TjhNAOw+hd4H019LHV687Xh2qJiNqREo30bhttsGqSFuzBoAjKixhhaSz7dZ453GXlhwmzIrWuGcpyyesU9UIGC76R9WAnC21m+WFPkxr4sg26iOa8IUpSaZ+pho9h09cTvQxsBJZglYi9S1dx1mRDEcTHVE6soaUa70hGiY5HRG/IKkvlYukpq/h9Lh2ppIC1IT5StSSgy/C/2hyiruvzNbRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpgOwHEwuKtCwsjq57apSDPzowoLTtP514sCwh+fVnE=;
 b=arZz2iCWAqa8E4MTGfNcnMY8wmR9lSM9c+/ADhLevBhINq+q5vTXRvq0aJTspEPIvUkIjP2jbg9tVt0Ivhs50eryFg8NP4qV0W8JGFjW6zLbUX29pHKp6bqjZ90Zc/DyaDUcjLcI0uqitK8w9+RLfTEjVrRuCXc5CZ/WzT/jVxk=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by DB8PR08MB5404.eurprd08.prod.outlook.com (2603:10a6:10:117::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:40:02 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::9d7d:90fc:df7a:a5a6]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::9d7d:90fc:df7a:a5a6%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:40:01 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: James Clark <James.Clark@arm.com>
CC: "acme@kernel.org" <acme@kernel.org>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "ak@linux.intel.com"
	<ak@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>, Mark Rutland
	<Mark.Rutland@arm.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, "will@kernel.org"
	<will@kernel.org>, "irogers@google.com" <irogers@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 2/4] perf: Allow adding fixed random jitter to the
 alternate sampling period
Thread-Topic: [RFC PATCH v2 2/4] perf: Allow adding fixed random jitter to the
 alternate sampling period
Thread-Index: AQHalKLSGp+C2aNYRUuPV57ekmUO7bF0QwKAgAAZoYA=
Date: Mon, 22 Apr 2024 14:40:01 +0000
Message-ID: <50f8e635667f2c0b389f882bc3f881552ea77e68.camel@arm.com>
References: <20240422104929.264241-1-ben.gainey@arm.com>
	 <20240422104929.264241-3-ben.gainey@arm.com>
	 <1dd3692d-dd2c-428f-a7f7-e263d1d5e5c8@arm.com>
In-Reply-To: <1dd3692d-dd2c-428f-a7f7-e263d1d5e5c8@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.0 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS8PR08MB6646:EE_|DB8PR08MB5404:EE_|AMS1EPF0000003F:EE_|PAWPR08MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: b977cbd8-310b-4b1d-40f3-08dc62da2010
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?YUVVUWxOMDhBaUZSZER5MUd4bU9ZOFRQaUdscStIa1ZWVkE4VWh4d21iV3RQ?=
 =?utf-8?B?NGJXb1lENXNuZWFaVmxNRTRGbXFOcW1iaTczcUFQdm14Q0hrMTlnaFg4NXdI?=
 =?utf-8?B?NU0xRHZIZExmYXRmT1pvL0F6SU9YT0hsREdRWWY3TUxuVDU2Nm1DbzVQdFU2?=
 =?utf-8?B?RG5CV1NKd1lESXNtdmV2Y0taTmZMWG1jdVV3ckZmNkxZT0hrby9NVnYySko5?=
 =?utf-8?B?U2c4enBEbVJ0cHl3cGRsSXR6bDZPYm5pUHZ1MW42NE50akhRWUp4NkNVRzZB?=
 =?utf-8?B?Z2dvbEdXbE1aakFnbnk2NTBmTnVPL2o2d1Y3UXdwc3dJaTVrd2M5VG90b2c5?=
 =?utf-8?B?QjhiWnVId1l3MWVhR0EyeTliSjhOWXhUQUpBYzU0NEFjUnVQVTVSbTg5VGdH?=
 =?utf-8?B?c2w2bkFNcUVMNlMyaVZsTmhjdVVSa01KMW12OXZQc0JCR3FHbGw0QkM3MFg0?=
 =?utf-8?B?QitKWlIxWG4zZ3l3cUdFTWFGRTFiTWJHWTBQZWJMdStYVmFRbmJtMWUvQlI4?=
 =?utf-8?B?Z29TanUvaTN1UFN6Y2NGeWtlc0h4c2x4bTExWFNrS1pHVFJuZ3MrTk5lMzhn?=
 =?utf-8?B?YlRNUEZYVDNUUmVZMEgzVjFjSE1vNFZGNkR2M3E3L1hXc3RwUlZpaC9XVkE5?=
 =?utf-8?B?dHU3YWxsVDVQUjFhcDBNb0VWa1Q3TzdtblI4Vlh0VnZRd2l4NGptanhPUkZO?=
 =?utf-8?B?TDFUN1ZLQlArV2d6NjAwbUJsMGR3dDAvZUxRZG9qdHFQbEVhbUlTRWoxOW00?=
 =?utf-8?B?ZVQ4N1FlOGVDbW41cWJEdnA1NGp4anFFU00yQlh5QzA5N1ZQVEM0aXhiaG85?=
 =?utf-8?B?VS9aNjFzclFmY3YzcmpoMHg0WEZXbjVXSkNIQzJYVVEydTVJbVc5TGtLRGlF?=
 =?utf-8?B?Zm5sY2UyQks5OVZWZGh4S0toYVNqbkorOWxDOTQ2ZnpwazdJQmxjS0FleWp0?=
 =?utf-8?B?OCtnYkhhR1dzcUp5dDdXaGpWYTI0SmJRTjhUSDYvbmZ1aHR0bmZGMWRyb3N5?=
 =?utf-8?B?RXd3UEIrdXdDRnNnRjVhVWJNMy9zZ0kvTnRZVWxRcWZXM29oRXYxNVFtelN6?=
 =?utf-8?B?K3dPRHgrcWxSeTR1bVN6QXc2R0ZQNjhyUVV0c1RUaVVRdnJ1QlVLeC9hd1k2?=
 =?utf-8?B?QXBYZGlxY05tVUszL1FtZ3lOUGxVbUowcUNRSjNWZitnclNJY1JncnhxaC9I?=
 =?utf-8?B?V0tMM0pjRm9lbTBFQXVMMWIwcXNYTDJLNEMzVGhPem92aVZaQmZFRjdvRXJu?=
 =?utf-8?B?WEhkejlZYzJLTlpCS3Z6NmZjYWFMTEYvWjNQNm5aY3cyeURSYUI2NFJpT0FM?=
 =?utf-8?B?THh6alZtVFlxNWM3M0lsdi9iai9iczBRZjJqYjd1Y2VaL3JBbmUvR1J6NFVt?=
 =?utf-8?B?NE9QZ01sK0t4cGl2YzhzcFV4ZTRsVm1SOHl5dGFqekFTZDZ2UHRYamVIU2Y4?=
 =?utf-8?B?bHlnSmU4ZWl2d01kV1UrS3ZQU1BBa2FEcXNDWTIvOStsUmVBM3ZaRUpRUWlx?=
 =?utf-8?B?UjgySnJvRmhpdzRZTFJ2citjZlZ3aWk0bmwwQlAzZDk1V2kzSVMwY2lsTUZN?=
 =?utf-8?B?Q2JrZVEwUFp6WTBDZTE5MXU0Y3BjWWpETVo4Z1QxMitUVnlZZzVmSUw5Y3dF?=
 =?utf-8?B?RDV0b2o2V1BPRDJwME4vM3JCZ0lWSzN0L0piTFBST0lMLytSQUswSitESGRh?=
 =?utf-8?B?UGV4a1BDYlFjZXFRdnhRKzkvOG9qSHRnVENjQUs2N25rN3NrVmRwRStlRzRh?=
 =?utf-8?B?QStHVG1pNXJtdHgzWlJwUi9Vai9zTFhRbTUvdXBCMzlySWNlSnZycnBvbUVJ?=
 =?utf-8?B?bWdaTzlXT2d0dzFUR05IZz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E15023112FC1E4585A003806A051EF8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5404
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6673e3de-0e3b-414d-842e-08dc62da17ae
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDNGZnVBdVRzTms4UTdwWHBPNk5wWjlUQUpTbVFHNkNYaHQ4M1BUMVBRN2Zx?=
 =?utf-8?B?Tjdxa2RSRlNOUndpZnZwOTludVdENVVmUmJwWHlnZkt6azF4K1BWUDZYL1hW?=
 =?utf-8?B?T1dyeHk4MlhUT0hTdGlKNkVNekRsUXJFLzhubFhSTldZdHVmZ0s1eVpwamhV?=
 =?utf-8?B?NTh6aTRQT0RKUmNhR2NGQXFnU0RKZDg4UUloOW5jUWd1cDYwUEJyMzBYVTJY?=
 =?utf-8?B?K2QrdnM4d0tET0RtUzZKbk4xVmkwY080NWs5ckpvSkY2TDdIdWNVK25mVTdY?=
 =?utf-8?B?OWFNRDZFVUVFSkErOVNhcS8yc09tSjJLeVFtOEgyaUFBNThsbFVrZlJ4SkRN?=
 =?utf-8?B?VnBuczlLOG1ONWR6TnR0azZUVWtMUVlzTFpIVDFOaU5mdkMxMTRuK2I2dkZa?=
 =?utf-8?B?VnJmNGFkUjJGcG1DQnFxVTl6bzJVZFJabXlyWGNTem9LUjRGRHVnQjZjbzMw?=
 =?utf-8?B?dG1iYlY5TjZLQU1iMSs5UnFMaUFtcEhtdWoyNHNsajdxY3dPVWJEZU5jRlBq?=
 =?utf-8?B?R3RUZ0RYR1FldFM1WmQ5L3kvSVpqZHEybVd4RFM4ZmQ5d0F2ZDR1amNPRGZW?=
 =?utf-8?B?RUFUUDRUWG1zc2RablNtbVNhNmgyU2hydmNsYlVPdWJiOTU4MjhxaEhrMDkv?=
 =?utf-8?B?ekdGbEJ5MlhuSG5pbm1JUkFwQ29FVkJjejFTS2t5SmxtZXdFYUdFaUFwaG9m?=
 =?utf-8?B?azFGV0sxN3UwRlFudFROMnFqVER2QWtFN3dZdXViZWVaQ1Rwb0xNM0wxRU5L?=
 =?utf-8?B?ZmdQK2NWRUc5Skw2aGpCdWFYUVdyWXZ3eHF1VXdQaXpXQk52Mnk2YkNaRk15?=
 =?utf-8?B?T1lkZE1rMHU1YlpiOVdEcGRnRWs1YklMYm1zL3AxM0RGZ25OZ0MySHhieWJu?=
 =?utf-8?B?OUlNYU4weTluVlBJZUtZcUdmYmpieE0zRjJVaEJZUU9iV3dOM05KbFFCaThM?=
 =?utf-8?B?bktrNlhiRkx4d2Q5a1dZc0xRKzg0aUFkZEZadDdrdzFDamQ1OWUyaUZNZm9S?=
 =?utf-8?B?Zmh1dGc0RWZqSDc2a2Zna05GbDhQaUdCQ0srWTIrQTdkTTZDQUtzWVk0RUdr?=
 =?utf-8?B?VDVSQWxUZHlKdVJ2N3dmaWFyVGhWaVluS1oyTFBLUDdyT0tZV01NLzgzUDhF?=
 =?utf-8?B?R24zNkc1WnNBYS8zYmo0WEFFVzUwMDFEUWpNYUp1a3ZIOGpFNUdNcSsvczI5?=
 =?utf-8?B?dVZ2cUNJczRWT0ZSYThodEtiVWRyWWM3TEJTWnBwMUZvb1VydmNmbnZaUW8y?=
 =?utf-8?B?Q1NMREcyajNaNm5DM1NRWVRzdUkySFViNHNHZjR2REx0UlFoSHpBdC81cmZs?=
 =?utf-8?B?cDhhS245am5KcUVhOVdhRHlyUEJDZVB2bUJ4cmVGbnpvSzVuTWJTTXJlQlpy?=
 =?utf-8?B?OXcrUHRuVCszTXVSWmJUMFdJM3FINTRnTW9YamliZVI1MzZNODhZYXFIWDNZ?=
 =?utf-8?B?VUZ5WDZBSmZRZEgzV09zYlorNUNSYWJjVTc2V1lDSHpRYTE0QXlZUXVUTHMw?=
 =?utf-8?B?U0hFWTljWDRYdlgxK0dYV1pXNkd3TjlDWHp0eEc5cHMzaEVmWVNDVTJUbW5J?=
 =?utf-8?B?dEF6ZmdzWVZOVlJrOVFiMGVvVGhtNXQ5RW5FM002RUt4dmVwbXkyb2YvS0F6?=
 =?utf-8?B?VjM1YU5yQkQ0Z2Q4RUtXSmF2cVZlWkNxTFdnRWlrdndwOEF0QlArVTJJL2Y2?=
 =?utf-8?B?R3JTbjlpZ2l0N280V2IwdllmKzd2cENQM3RaSlhNWVlkWE9HU1ZCeHpJM0o2?=
 =?utf-8?B?MHloQ2hidEN6YXVoZEt0cWp5UEh4Mk82YnJRRkszQ2xnMmkrRGFwaDg4QUwr?=
 =?utf-8?B?NVdZbGcweHNlcXNIdzRGQ1pOdkt0QVVzZHVidElmSXZuemFMR2FZemNuMktm?=
 =?utf-8?Q?kQyuQdUqpRo0X?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:40:15.9158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b977cbd8-310b-4b1d-40f3-08dc62da2010
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9472

T24gTW9uLCAyMDI0LTA0LTIyIGF0IDE0OjA4ICswMTAwLCBKYW1lcyBDbGFyayB3cm90ZToNCj4g
DQo+IA0KPiBPbiAyMi8wNC8yMDI0IDExOjQ5LCBCZW4gR2FpbmV5IHdyb3RlOg0KPiA+IFRoaXMg
Y2hhbmdlIG1vZGlmaWVzIHRoZSBjb3JlIHBlcmYgb3ZlcmZsb3cgaGFuZGxlciwgYWRkaW5nIHNv
bWUNCj4gPiBzbWFsbA0KPiA+IHJhbmRvbSBqaXR0ZXIgdG8gZWFjaCBzYW1wbGUgcGVyaW9kIHdo
ZW5ldmVyIGFuIGV2ZW50IHN3aXRjaGVzDQo+ID4gYmV0d2VlbiB0aGUNCj4gPiB0d28gYWx0ZXJu
YXRlIHNhbXBsZSBwZXJpb2RzLiBBIG5ldyBmbGFnIGlzIGFkZGVkIHRvDQo+ID4gcGVyZl9ldmVu
dF9hdHRyIHRvDQo+ID4gb3B0IGludG8gdGhpcyBiZWhhdmlvdXIuDQo+ID4gDQo+ID4gVGhpcyBj
aGFuZ2UgZm9sbG93cyB0aGUgZGlzY3Vzc2lvbiBpbiBbMV0sIHdoZXJlIGl0IGlzIHJlY29nbml6
ZWQNCj4gPiB0aGF0IGl0DQo+ID4gbWF5IGJlIHBvc3NpYmxlIGZvciBjZXJ0YWluIHBhdHRlcm5z
IG9mIGV4ZWN1dGlvbiB0byBlbmQgdXAgd2l0aA0KPiA+IGJpYXNlZA0KPiA+IHJlc3VsdHMuDQo+
ID4gDQo+ID4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBlcmYtDQo+ID4gdXNl
cnMvWmMyNGVMcVp5Y21JZzNkMkB0YXNzaWxvLw0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEJl
biBHYWluZXkgPGJlbi5nYWluZXlAYXJtLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGluY2x1ZGUvdWFw
aS9saW51eC9wZXJmX2V2ZW50LmggfMKgIDMgKystDQo+ID4gwqBrZXJuZWwvZXZlbnRzL2NvcmUu
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMSArKysrKysrKysrLQ0KPiA+IMKgMiBmaWxlcyBj
aGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvcGVyZl9ldmVudC5oDQo+ID4gYi9pbmNsdWRlL3Vh
cGkvbGludXgvcGVyZl9ldmVudC5oDQo+ID4gaW5kZXggNWMxNzAxZDA5MWNmLi5kZDM2OTdhNGIz
MDAgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3BlcmZfZXZlbnQuaA0KPiA+
ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9wZXJmX2V2ZW50LmgNCj4gPiBAQCAtNDYxLDcgKzQ2
MSw4IEBAIHN0cnVjdCBwZXJmX2V2ZW50X2F0dHIgew0KPiA+IMKgIGluaGVyaXRfdGhyZWFkIDrC
oCAxLCAvKiBjaGlsZHJlbiBvbmx5IGluaGVyaXQgaWYgY2xvbmVkIHdpdGgNCj4gPiBDTE9ORV9U
SFJFQUQgKi8NCj4gPiDCoCByZW1vdmVfb25fZXhlYyA6wqAgMSwgLyogZXZlbnQgaXMgcmVtb3Zl
ZCBmcm9tIHRhc2sgb24gZXhlYyAqLw0KPiA+IMKgIHNpZ3RyYXDCoMKgwqDCoMKgwqDCoCA6wqAg
MSwgLyogc2VuZCBzeW5jaHJvbm91cyBTSUdUUkFQIG9uIGV2ZW50ICovDQo+ID4gLSBfX3Jlc2Vy
dmVkXzHCoMKgIDogMjY7DQo+ID4gKyBqaXR0ZXJfYWx0ZXJuYXRlX3BlcmlvZCA6IDEsIC8qIGFk
ZCBhIGxpbWl0ZWQgYW1vdW50IG9mIGppdHRlciBvbg0KPiA+IGVhY2ggYWx0ZXJuYXRlIHBlcmlv
ZCAqLw0KPiA+ICsgX19yZXNlcnZlZF8xwqDCoCA6IDI1Ow0KPiA+IMKgDQo+ID4gwqAgdW5pb24g
ew0KPiA+IMKgIF9fdTMyIHdha2V1cF9ldmVudHM7IMKgIC8qIHdha2V1cCBldmVyeSBuIGV2ZW50
cyAqLw0KPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvZXZlbnRzL2NvcmUuYyBiL2tlcm5lbC9ldmVu
dHMvY29yZS5jDQo+ID4gaW5kZXggMDdmMWY5MzFlMThlLi4wNzlhZTUyMGU4MzYgMTAwNjQ0DQo+
ID4gLS0tIGEva2VybmVsL2V2ZW50cy9jb3JlLmMNCj4gPiArKysgYi9rZXJuZWwvZXZlbnRzL2Nv
cmUuYw0KPiA+IEBAIC0xNSw2ICsxNSw3IEBADQo+ID4gwqAjaW5jbHVkZSA8bGludXgvaWRyLmg+
DQo+ID4gwqAjaW5jbHVkZSA8bGludXgvZmlsZS5oPg0KPiA+IMKgI2luY2x1ZGUgPGxpbnV4L3Bv
bGwuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3JhbmRvbS5oPg0KPiA+IMKgI2luY2x1ZGUgPGxp
bnV4L3NsYWIuaD4NCj4gPiDCoCNpbmNsdWRlIDxsaW51eC9oYXNoLmg+DQo+ID4gwqAjaW5jbHVk
ZSA8bGludXgvdGljay5oPg0KPiA+IEBAIC05NTQ2LDYgKzk1NDcsOCBAQCBzdGF0aWMgaW5saW5l
IGJvb2wgc2FtcGxlX2lzX2FsbG93ZWQoc3RydWN0DQo+ID4gcGVyZl9ldmVudCAqZXZlbnQsIHN0
cnVjdCBwdF9yZWdzICpyDQo+ID4gwqAgcmV0dXJuIHRydWU7DQo+ID4gwqB9DQo+ID4gwqANCj4g
PiArIyBkZWZpbmUgTUFYX0FMVF9TQU1QTEVfUEVSSU9EX0pJVFRFUiAxNg0KPiA+ICsNCj4gDQo+
IElzIDE2IGVub3VnaCB0byBtYWtlIGEgZGlmZmVyZW5jZSB3aXRoIHZlcnkgbGFyZ2UgYWx0ZXJu
YXRlIHBlcmlvZHM/DQo+IEknbQ0KPiB3b25kZXJpbmcgaWYgaXQncyB3b3J0aCBtYWtpbmcgaXQg
Y3VzdG9taXNhYmxlIGFuZCBpbnN0ZWFkIG9mIGFkZGluZw0KPiB0aGUNCj4gYm9vbGVhbiBvcHRp
b24gYWRkIGEgMTYgYml0IGppdHRlciBmaWVsZC4gT3IgdGhlIG9wdGlvbiBjb3VsZCBzdGlsbA0K
PiBiZSBhDQo+IGJvb2xlYW4gYnV0IHRoZSBqaXR0ZXIgdmFsdWUgaXMgc29tZSByYXRpbyBvZiB0
aGUgYWx0IHNhbXBsZSBwZXJpb2QsDQo+IGxpa2U6DQo+IA0KPiDCoCBnZXRfcmFuZG9tX3UzMl9i
ZWxvdyhtYXgoMTYsIGFsdGVybmF0aXZlX3NhbXBsZV9wZXJpb2QgPj4gNCkpDQo+IA0KDQpJIGRv
bid0IHJlYWxseSBoYXZlIGEgc3Ryb25nIG9waW5pb247IGluIGFsbCBteSB0aW1lIEkndmUgbmV2
ZXIgc2VlbiBhbg0KQXJtIFBNVSBwcm9kdWNlIGEgcHJlY2lzZSBhbmQgY29uc3RhbnQgcGVyaW9k
IGFueXdheSwgc28gdGhpcyBtYXkgYmUNCm1vcmUgdXNlZnVsIGluIHRoZSBjYXNlIHRoZSBhcmNo
aXRlY3R1cmUgaXMgYWJsZSB0byBzdXBwb3J0IHByZWNpc2UNCnNhbXBsaW5nLiBJbiBhbnkgY2Fz
ZSBpdCdzIGlzIGxpa2VseSB0byBiZSBzcGVjaWZpYyB0byBhIHBhcnRpY3VsYXINCndvcmtsb2Fk
IC8gY29uZmlndXJhdGlvbiBhbnl3YXkuDQoNClRoZSBtYWluIGRvd25zaWRlIEkgY2FuIHNlZSBm
b3IgbWFraW5nIGl0IGNvbmZpZ3VyYWJsZSBpcyB0aGF0IHRoZQ0KY29tcGlsZXIgY2Fubm90IHRo
ZW4gb3B0aW1pc2UgdGhlIGdldF9yYW5kb20gY2FsbCBhcyB3ZWxsIGFzIGZvciBhDQpjb25zdGFu
dCwgd2hpY2ggbWF5IGJlIHVuZGVzaXJhYmxlIG9uIHRoaXMgY29kZSBwYXRoLg0KDQoNCj4gPiDC
oC8qDQo+ID4gwqAgKiBHZW5lcmljIGV2ZW50IG92ZXJmbG93IGhhbmRsaW5nLCBzYW1wbGluZy4N
Cj4gPiDCoCAqLw0KPiA+IEBAIC05NTczLDcgKzk1NzYsMTAgQEAgc3RhdGljIGludCBfX3BlcmZf
ZXZlbnRfb3ZlcmZsb3coc3RydWN0DQo+ID4gcGVyZl9ldmVudCAqZXZlbnQsDQo+ID4gwqAgaWYg
KGV2ZW50LT5hdHRyLmFsdGVybmF0aXZlX3NhbXBsZV9wZXJpb2QpIHsNCj4gPiDCoCBib29sIHVz
aW5nX2FsdCA9IGh3Yy0+dXNpbmdfYWx0ZXJuYXRpdmVfc2FtcGxlX3BlcmlvZDsNCj4gPiDCoCB1
NjQgc2FtcGxlX3BlcmlvZCA9ICh1c2luZ19hbHQgPyBldmVudC0+YXR0ci5zYW1wbGVfcGVyaW9k
DQo+ID4gLSDCoMKgwqDCoMKgwqAgOiBldmVudC0+YXR0ci5hbHRlcm5hdGl2ZV9zYW1wbGVfcGVy
aW9kKTsNCj4gPiArIMKgwqDCoMKgwqDCoCA6IGV2ZW50LT5hdHRyLmFsdGVybmF0aXZlX3NhbXBs
ZV9wZXJpb2QpDQo+ID4gKyDCoCArIChldmVudC0+YXR0ci5qaXR0ZXJfYWx0ZXJuYXRlX3Blcmlv
ZA0KPiA+ICsgPyBnZXRfcmFuZG9tX3UzMl9iZWxvdyhNQVhfQUxUX1NBTVBMRV9QRVJJT0RfSklU
VEVSKQ0KPiA+ICsgOiAwKTsNCj4gPiDCoA0KPiA+IMKgIGh3Yy0+c2FtcGxlX3BlcmlvZCA9IHNh
bXBsZV9wZXJpb2Q7DQo+ID4gwqAgaHdjLT51c2luZ19hbHRlcm5hdGl2ZV9zYW1wbGVfcGVyaW9k
ID0gIXVzaW5nX2FsdDsNCj4gPiBAQCAtMTI1MDMsNiArMTI1MDksOSBAQCBTWVNDQUxMX0RFRklO
RTUocGVyZl9ldmVudF9vcGVuLA0KPiA+IMKgIH0NCj4gPiDCoCB9DQo+ID4gwqANCj4gPiArIGlm
IChhdHRyLmppdHRlcl9hbHRlcm5hdGVfcGVyaW9kICYmDQo+ID4gIWF0dHIuYWx0ZXJuYXRpdmVf
c2FtcGxlX3BlcmlvZCkNCj4gPiArIHJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiDCoCAvKiBP
bmx5IHByaXZpbGVnZWQgdXNlcnMgY2FuIGdldCBwaHlzaWNhbCBhZGRyZXNzZXMgKi8NCj4gPiDC
oCBpZiAoKGF0dHIuc2FtcGxlX3R5cGUgJiBQRVJGX1NBTVBMRV9QSFlTX0FERFIpKSB7DQo+ID4g
wqAgZXJyID0gcGVyZl9hbGxvd19rZXJuZWwoJmF0dHIpOw0KDQo=

