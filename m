Return-Path: <linux-kernel+bounces-31462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA11832EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109E51F23CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAD856451;
	Fri, 19 Jan 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RUZCd9st";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RUZCd9st"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91866524B3;
	Fri, 19 Jan 2024 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.89
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687754; cv=fail; b=KZg3EChzu9mosotIdM53BUozp/JBnxGUQHpxMMCm+FpzLUN+wvMXxHKrD7eqvQd8DB1WDxqtqP9uOdRj4akEZNSJQuVedhJ3VwU+1TlOJshpIUnMDiCSE7LioKW5zzq3RUkmu+C8hsnAQTgc0kkEG0YP16Sq322IIp5EkTmDtes=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687754; c=relaxed/simple;
	bh=9bwk3S8PSdXfmAcUYNoRxJJPDPkz+FqiSE/8W+jTb0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=McEBs1NKaI6Bebj2aaCHV5NRx/CWbQIT1aSXarnxpPltIUwF59SM7cBkhAIxkbJ81576vIlr3t7UaRxLiZaK5S1zhZn0qE5cxLN8gb7JU/+b4wmyIKbR/t8EDVbZEygtOWSdtkkyGOCDNBxFt+DpmgH8Lxf+Mgsa/y3ns0xncr8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=RUZCd9st; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=RUZCd9st; arc=fail smtp.client-ip=40.107.104.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=UrBBluhjRPCNvx8ZHnEdFgLJ82bRQC8FPeq4NeWbIlcXM6h8qPHbuyPwUVJvRBL0CccGKAffM7FpyaRfYrFOGrfvZuBbNiddRRaBSSb8bHTfpsBZjbHNIs5OMr0u41mhguQCMEg+KMSyLhG+tNMNAj7M8ck1mXZQV5+3pfX41v21mQx/qzXCj1h38khdMTuOphyZFWZHzg7+0HT6bi7J9Uldn/zELG10i6jpmrPLAdvRp5GyZjzYFEdAE+QfvFpaKb1PwrqzLWLL+a9FOXa/x1xkUwNmxL9R/0HWpsZSvsHP23/2Mjsvm7n4wY1g7NZD1ckgYgBZdfaxPm4+PJC/Lg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bwk3S8PSdXfmAcUYNoRxJJPDPkz+FqiSE/8W+jTb0c=;
 b=OeXgqEdbowvnBDBAd+HpsfoBq/pKE2ShY4l9NCKHNs9exKAtkhuwJx7Xmgbb/HX9EsPj5OXmEAu+KjMqWiXA6DwDG+I2VrxIKUA8mIVdK9yADZYHDdljd/qtBooIykQ2cXG0YgfLqB61ds7YdWD697fxSlh6wgJmlsylcSj6uPpbiww7o+G+hJyposV1xQ1BDBW3dYtyYmnbjWOrmry+gOeZHOhP5Y5I2ZpNudUQkN3NC27swPjFeESLoizFq/JcjFBepPQcDyuBikop/fFO/dwH9YZbUKtdz1KQLvvw8H7VgAvBN3/1Idw7/I47GwcPZ5KxUhvKeye67smHQII6iA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bwk3S8PSdXfmAcUYNoRxJJPDPkz+FqiSE/8W+jTb0c=;
 b=RUZCd9stbNPBGcpiPgMFMDuVClqfcLhzOxOGy6iuRbuyow60li1UQQCJsncLNMFjFDaRuaNd7RASq4TFP3NLznJmgnRoBNAwE7/bgawiMhIfBIBjrp+iEYzvC/fX4crxzE+YxLxTKOHG6fv8YpaBWSXxpUU6ycfzaj8Rip+f/lc=
Received: from AM8P251CA0027.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::32)
 by GV2PR08MB9400.eurprd08.prod.outlook.com (2603:10a6:150:dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 18:09:06 +0000
Received: from AMS0EPF000001A1.eurprd05.prod.outlook.com
 (2603:10a6:20b:21b:cafe::e5) by AM8P251CA0027.outlook.office365.com
 (2603:10a6:20b:21b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 18:09:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001A1.mail.protection.outlook.com (10.167.16.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:09:05 +0000
Received: ("Tessian outbound c4f080b252bb:v228"); Fri, 19 Jan 2024 18:09:05 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7261f7b32e35afdf
X-CR-MTA-TID: 64aa7808
Received: from 6f8b42987b23.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id C268AE2D-867E-4417-8840-6AFEED75B262.1;
	Fri, 19 Jan 2024 18:08:54 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6f8b42987b23.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 19 Jan 2024 18:08:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvApgXCjG+ESAyILpB2R8Lz3pyhg8XZ0+68DY6mzg8QsAhWY8IwJBMQQB39J4rxPGFW3f/ek0hWAr1850SQfnNUU5nZMMDOcFLrIhsz2P01WHEfHGJbzhih2BhvBqPl23eewnu+e7pi6/zz0qSYyXDZXxosRhnIODCABp0jw1MG8KGFZ65eZvovPCS8ZqOxFOhCKaakPorOkFKWNRjzdTABXb1QcnT1nB52U7XZUpY27Z6D3exzG+HyrUTtmj7BLmxjPAVO4m0pCW1IlyK/M9XAC73PEqMjYEvFwI/P/+DvS32x8xuYFftYewZhAO2O2PZ9XDPdtzlca63Q43bQicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bwk3S8PSdXfmAcUYNoRxJJPDPkz+FqiSE/8W+jTb0c=;
 b=T7UN+3tlqyF7UNIv8WJ99jgN0h67ezy5yEGHI7aN5F0sCO2KepLZu720vMb7ZtFPud4kneix2tLvHBcIIh7V/85JypTmTyiXoCbxhkttRlDsjYK0PYIxfePWcuwmBu0VK5k+U5Xj6H5Dag+W74Dm145bZH8AMMIo0T/9/X6oP9mHJ53jvIWSkiF5HE62RkeE0oMhwdv5EcvoA+auN1tAKk16gsMk1yg0hT5teV9+4kvMtoPwgPlI+xAj/SHDaNRoVHaU+YPJrwxF7gwRW/6y/wsBknJ3NQmvSnKEYGUMLQtObbxtqU0tXVK9DEqdnE/ZjpmXo+wFhhCgdIlM1rRfOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bwk3S8PSdXfmAcUYNoRxJJPDPkz+FqiSE/8W+jTb0c=;
 b=RUZCd9stbNPBGcpiPgMFMDuVClqfcLhzOxOGy6iuRbuyow60li1UQQCJsncLNMFjFDaRuaNd7RASq4TFP3NLznJmgnRoBNAwE7/bgawiMhIfBIBjrp+iEYzvC/fX4crxzE+YxLxTKOHG6fv8YpaBWSXxpUU6ycfzaj8Rip+f/lc=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by AS8PR08MB6629.eurprd08.prod.outlook.com (2603:10a6:20b:319::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27; Fri, 19 Jan
 2024 18:08:52 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::bf90:87a7:c796:ce84]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::bf90:87a7:c796:ce84%4]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 18:08:52 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: "ak@linux.intel.com" <ak@linux.intel.com>
CC: "irogers@google.com" <irogers@google.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	James Clark <James.Clark@arm.com>, "peterz@infradead.org"
	<peterz@infradead.org>, Mark Rutland <Mark.Rutland@arm.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/1] Support PERF_SAMPLE_READ with inherit_stat
Thread-Topic: [PATCH 0/1] Support PERF_SAMPLE_READ with inherit_stat
Thread-Index: AQHaSvYoATZqyOE6y0OGrcMnu7mKsrDhaMvtgAAGZYA=
Date: Fri, 19 Jan 2024 18:08:52 +0000
Message-ID: <e69ffb457b761763c30e2d63ffd8a38606dbadd3.camel@arm.com>
References: <20240119163924.2801678-1-ben.gainey@arm.com>
	 <87a5p1kyif.fsf@linux.intel.com>
In-Reply-To: <87a5p1kyif.fsf@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS8PR08MB6646:EE_|AS8PR08MB6629:EE_|AMS0EPF000001A1:EE_|GV2PR08MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ebd645-f9ee-45c5-6594-08dc1919b9a3
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 h8prf1kAoMMy7VTG1YBqycpMp2XgUoP3lyKmBN8Au9E0a2igrItdklXxjNOpd/QJj5fq27cqhEHmyuD2txO0EAPMzkP34vBuFLVt4XNXgYRz2V1nLrf7ysYpzuR1ojHg9EeITc5BtBiz4S1UR2SGfVnzeY9T12BIm5UDGmpnUoiGPUu2PvX3QX5yzR6+QSN3o3bdAZVhGvmkdhoXFbK8bQCdo4Bt9NJaOb7RvfJAAiACJXK8tgS6A9maOn99+tci1jjX1n2aaC7gyu/laPcSssb+/FFJzZ/Y189SnO1z5fQU3JswBhO/m8XdpINk706jAjiSNLKxmQAUhSh5ImhIxm5hFA5IcQqG/tD6x95Lsy9HwQ2t8UHQQAwiJbL6M5Q9Z3OHHlEu5++j2lVFvS7knEnoAgFZEqzs56uqdOe/S4gIGwXu4QmH4PTs1puA7EacVtwecyk2YC6Q1XRKX7Wuvg6WODedl0+pKBCxuv8t0z4TI2+0qskIYKVcnhaxYTo+DPUYeG9VsCDGkpQnhUg1QtQlJKJQ+6EC7hmhXu+vo8dtIzzRU/WkVd0sLULrDiTYQES/lBx/qyKsRDBCV9mBudbJ6G5xX4eKB2lU1/fKKazAT1vFvbgi9Xmp2NLg8cT2
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(478600001)(26005)(71200400001)(6486002)(6506007)(6512007)(83380400001)(2906002)(5660300002)(7416002)(41300700001)(66556008)(66946007)(76116006)(66476007)(66446008)(64756008)(6916009)(91956017)(54906003)(316002)(4326008)(8676002)(8936002)(38070700009)(38100700002)(122000001)(36756003)(86362001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <47D7897A28C35B42ACBF1C1C0FA08FBD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6629
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A1.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	76561e49-57f5-4ab3-aecf-08dc1919b185
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wp97oBPgqzNMstV+bFeTaOzuSHDx6ISMkgJjgIrvgpne2fv/d+MI7qr/kBQqyIWmB4s5Hs1G+IvZl7iKJVc+DuTOAOJvP+j68ku5Jjw9hWtcuUhLDq1pu48v6gS/46l66+3i1mZZLNt2dBUNaXrPbNjFWnpvScdmzlEnsb7r0WDieYSDo5C+dp/cX9oEtJAobAntbFnz2+LNaC7vzOpKxIuqyLeB8NVY+xw71Hrj+9lhz7cbiExOj2h3l8sxKTthGDysST4NNMZ+ldaFRYllk9zE8lKEoFhAN6zyWoh8xCxdxKsTHnl3Md871gJI98jIDx2WZXHyDPBl75gZwixEYA2C7Gqd7G5bG705yS435zYST+LtiDL0zFN2hOaDDwyar/pOJHtCnIeBKoFbXmH5nXmBCrECDi7DXVYH03BpmBlQnT944SR8OoGXEuogzIVuUPcl/FUUCW142JK29zw1YqkusIlgO54q9UXr6/LYnCCch6e4Zn+QBRwHG9ATLrDy8KQtL3vYaVx2uUEc9i7IBRUT/FiPx9wR0jV5DmJ0l6v4Ka6NSo7GY+LMwKkVouGZPvv/zt+ZajvySOHEGEnFn677fBv28P876e9gTGC/smrdzeuA5eCQJXVvnWMZu+u++eGKBo7BNK5G2gOoHYtzoVGYJNcE359QRbM650yqhhvTzatesX5qs+pw8ylz0qhjevqDGPR0+klcx3ktF7VkUwKEY9XtFkjrwDxprwLfjaGh0Taic+jGokSNxpiLWsjP
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(47076005)(36860700001)(36756003)(41300700001)(82740400003)(356005)(81166007)(450100002)(26005)(40480700001)(336012)(40460700003)(2616005)(6862004)(8936002)(4326008)(8676002)(107886003)(86362001)(6486002)(478600001)(70206006)(70586007)(6512007)(316002)(54906003)(6506007)(5660300002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:09:05.8512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ebd645-f9ee-45c5-6594-08dc1919b9a3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9400

T24gRnJpLCAyMDI0LTAxLTE5IGF0IDA5OjQ1IC0wODAwLCBBbmRpIEtsZWVuIHdyb3RlOg0KPiBC
ZW4gR2FpbmV5IDxiZW4uZ2FpbmV5QGFybS5jb20+IHdyaXRlczoNCj4NCj4gPiBJbiB0aGlzIGNv
bmZpZ3VyYXRpb24gc3RyZWFtIGlkcyAoc3VjaCBhcyBtYXkgYXBwZWFyIGluIHRoZQ0KPiA+IHJl
YWRfZm9ybWF0DQo+ID4gZmllbGQgb2YgYSBQRVJGX1JFQ09SRF9TQU1QTEUpIGFyZSBubyBsb25n
ZXIgZ2xvYmFsbHkgdW5pcXVlLA0KPiA+IHJhdGhlcg0KPiA+IHRoZSBwYWlyIG9mIChzdHJlYW0g
aWQsIHRpZCkgdW5pcXVlbHkgaWRlbnRpZnkgZWFjaCBldmVudC4gVG9vbHMNCj4gPiB0aGF0DQo+
ID4gcmVseSBvbiB0aGlzLCBmb3IgZXhhbXBsZSB0byBjYWxjdWxhdGUgYSBkZWx0YSBiZXR3ZWVu
IHNhbXBsZXMsDQo+ID4gd291bGQNCj4gPiBuZWVkIHVwZGF0aW5nIHRvIHRha2UgdGhpcyBpbnRv
IGFjY291bnQuIFByZXZpb3VzbHkgdmFsaWQgZXZlbnQNCj4gPiBjb25maWd1cmF0aW9ucyAoc3lz
dGVtLXdpZGUsIG5vLWluaGVyaXQgYW5kIHNvIG9uKSB3aGVyZSBlYWNoDQo+ID4gc3RyZWFtIGlk
DQo+ID4gaXMgdGhlIGlkZW50aWZpZXIgYXJlIHVuYWZmZWN0ZWQuDQo+DQo+IFNvIGlzIHRoaXMg
YW4gQUJJIGJyZWFrPyBJdCBtaWdodCBuZWVkIGFuIG9wdGluLCBpZiBpdCBicmVha3MNCj4gYW55
dGhpbmcsDQo+IHdoaWNoIHdvdWxkbid0IHN1cnByaXNlIG1lLiBXZSBkbyBoYXZlIGEgbG90IG9m
IGRpZmZlcmVudCBwZXJmIHN0cmVhbQ0KPiBwYXJzZXJzIGFyb3VuZCB0aGVzZSBkYXlzIGFuZCB3
ZSBjYW5ub3QgYnJlYWsgdGhlbS4NCj4NCj4gLUFuZGkNCg0KSSBoYWQgY29uc2lkZXJlZCB0aGF0
LCBidXQgZ2l2ZW4gY3VycmVudGx5IHRoaXMgcGVyZl9ldmVudF9hdHRyDQpjb25maWd1cmF0aW9u
IGlzIG5vdCBhbGxvd2VkLCBJIGFzc3VtZWQgdGhhdCBpdCB3b3VsZCByZXF1aXJlIGV4aXN0aW5n
DQp0b29scyB0byBhZGQgc3VwcG9ydCB3aGljaCB3b3VsZCBpbiBlZmZlY3QgYmUgYW4gb3B0LWlu
LiBPZiBjb3Vyc2UsDQphZGRpbmcgYSBuZXcgZmxhZyB0byBiZSBleHBsaWNpdCB3b3VsZCBiZSB0
cml2aWFsIGVub3VnaCBpZiByZXF1aXJlZC4NCg0KVGhhdCBzYWlkLCB0aGUgYmluYXJ5IGZvcm1h
dCBmb3IgdGhlIG1tYXAgcmVjb3JkcyAvIHJlYWQoKSBldGMgZG9lcyBub3QNCmNoYW5nZSBzbyB1
c2luZyBhbiB1bm1vZGlmaWVkIHRvb2wgdG8gcGFyc2UgdGhlIGRhdGEgZmlsZSB3aWxsIGdpdmUg
YmFkDQpyZXN1bHRzLiBUaGVyZWZvcmUgYW55IHdvcmtmbG93IHdoZXJlICJtb2RpZmllZCByZWNv
cmRpbmcgdG9vbCIgY2FuIGJlDQpjb21iaW5lZCB3aXRoICJvbGRlciAvIHVubW9kaWZpZWQgcGFy
c2luZyB0b29sIiB3aWxsIGJyZWFrLiBOb3Qgc3VyZSBvZg0KdGhlIGJlc3Qgd2F5IHRvIGhhbmRs
ZSB0aGlzLi4uIHByZXN1bWFibHkgd2hlbmV2ZXIgYSBjaGFuZ2UgaXMgbWFkZSB0bw0KdGhlIHBl
cmYgcmVjb3JkIGZvcm1hdCwgYW55IHdvcmtmbG93IHRoYXQgYWxsb3dzIG9sZCBwYXJzZXJzIHRv
IHJlYWQNCm5ldyBmb3JtYXQgZGF0YSB3aXRob3V0IHZlcnNpb24gY2hlY2tzIGNvdWxkIGZhaWw/
IEFkbWl0dGVkbHkgdGhpcyBpcyBhDQoibG9va3MgdGhlIHNhbWUgYnV0IGlzbid0IiBjaGFuZ2Ug
c28gaGFyZGVyIGZvciB0b29scyBkZXZzIHRvIHNwb3QuIEFueQ0Kc3VnZ2VzdGlvbnM/DQoNCkZv
ciB0aGUgcGVyZiB0b29scywgaXMgdGhlcmUgYSBtZWFucyB0byByZWNvcmQgaW4gcGVyZi5kYXRh
IGEgbWluaW11bQ0Kc3VwcG9ydGVkIHRvb2wgdmVyc2lvbiAvIGZlYXR1cmUgaW5jb21wYXRpYmls
aXR5IGZsYWdzPw0KDQpSZWdhcmRzDQpCZW4NCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50
cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQg
bWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lw
aWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlz
Y2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1
cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRo
YW5rIHlvdS4NCg==

