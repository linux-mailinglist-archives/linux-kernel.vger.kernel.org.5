Return-Path: <linux-kernel+bounces-127716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB44894FE6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E484E28230D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356825B5BE;
	Tue,  2 Apr 2024 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="f8obOTaU";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="f8obOTaU"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D106259B4B;
	Tue,  2 Apr 2024 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053093; cv=fail; b=GVHmbe85MxATb0i7GeScqsZf7RkWrtIKBy4ZbArOARLqQyext0egL6Q3O031CRgp0DM6DG4O0SC8+kDgFbOiffNUv/GOiiJrJVJhs9GnTxh7696nuE5oE75PHNWy5xbOgPmTpjy2iGH0NCPIJvxsb3/kduBJrzQNxHfIwcH93Fk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053093; c=relaxed/simple;
	bh=i3pqcC+0H15MF9B5wyM3FmHSwIamIXsm60LtH5TFiRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HO8HBJvZ9ZaR8+Zc+x2TNzl5ZSoHXf9/JqVNka9Q3yuNB/EMJ/pAJG/P/at1HMiWe6+sQWHejhUf9fWgzrtMwd1MAQL4VPyZ9Cl2ggZQtwUPggl/RCcV3pOcAfGf2CR26Byn+pnxtq0kBCDXKrGibCMzBly3b6qmunsFrklKbfM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=f8obOTaU; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=f8obOTaU; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=jJJ4ozoBAbu2X0QOM8ruIkMp4OmHwuJpdSR+ouBEjGNGMFBitYMNURq0qWTywB4Vdtx+h80P7dUWQIgB7l8GMDHF2+eG1oZEALxPzSO4oqxoB2L8eI/Pg921rLaNc5dpipbjcEcTFuU3LPFY/IUZ8seGYNlvfD+vqALuffZBL4Y1jEMdYzLz7SD0cRS7JGBxl2ud8O7fBqQULTT4SMaEGfSC228CZHsNZa4HKac85iPWaCfXS3qjf4A3tPFnZX90jcPb2u/G3KucV05P4wB7IObxz2MIWF84CNVaAkG4A031Gao+7GuG6mZ7C8LbhxWnEKs1hPtjSChq/yyIz862Cg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3pqcC+0H15MF9B5wyM3FmHSwIamIXsm60LtH5TFiRo=;
 b=P1xAFdgTSneIX4wkf5EUnhUkdXDMHBbrHZ6ZZUHeqYikhOT6uxHFwgTL47lKeyVnrffxdV51Jv8X0J/i5UBRoRLxfOhK/n2VENMdhKSFhz9xsSR1uMnjdlEeXkHwe51MHRr/t3uHgvdOlKhD3H8xPMnV/8SHa+lcGxFr0HhbkXh5SGPv7sR9BLzhQFFw6zIYdKn+zUcHIs5AB8mfNtUxovNtFWGATiUIgaV5IPOmMo0mD2mhTUIjp/pitFu/2cuwoSNWesy7WX2j8iLIt4wnoDG2TxZJ+hojkHkrc8lhOzTecIl4YOqiaxGgPhV4ukOO01LDgvD+VothsZAI5hYP0w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3pqcC+0H15MF9B5wyM3FmHSwIamIXsm60LtH5TFiRo=;
 b=f8obOTaUqbOC2SHMi6/cMZVGBKeG0FnvbSt8aWNSeBo87KDS0XriSW/futAGlnApOk1zvKkU4UCjMi14JuVAwZbD2tTchuQ/HWMi47D0jOKza+pf0IfRquPedn2MN1ulBYjzm5XDlVNhT8p+nME4pxjRoUAdZRI6ZICbyDVXkt0=
Received: from AM4PR07CA0014.eurprd07.prod.outlook.com (2603:10a6:205:1::27)
 by DBAPR08MB5784.eurprd08.prod.outlook.com (2603:10a6:10:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:18:07 +0000
Received: from AM2PEPF0001C708.eurprd05.prod.outlook.com
 (2603:10a6:205:1:cafe::c) by AM4PR07CA0014.outlook.office365.com
 (2603:10a6:205:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25 via Frontend
 Transport; Tue, 2 Apr 2024 10:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C708.mail.protection.outlook.com (10.167.16.196) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7452.22
 via Frontend Transport; Tue, 2 Apr 2024 10:18:05 +0000
Received: ("Tessian outbound 5ad6c4395be7:v300"); Tue, 02 Apr 2024 10:18:05 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a865fc3bed6865c1
X-CR-MTA-TID: 64aa7808
Received: from a0cce78e7914.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id A7B4A6BF-3386-41F1-ADA3-9A3D7DC6C53D.1;
	Tue, 02 Apr 2024 10:17:59 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a0cce78e7914.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 02 Apr 2024 10:17:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4MAj3UmYCxcWkVRJpH3CTKI07oo+dhxjwT3Y0DPRZzCzyJH0gTEN7xTk2vragnXJ8M6t1ZleeoyACKjScbkT6x63sBPaZh0z47FTHta7dS7k1zZvZKsenu++lzzrpkY6Hs5MsbJc2GI7vmDvtIwm/50Czqw3ezL98vHlHRFCtdc64wmiSyfPzsMkbcafEpfx+uRchPT+S3Bx+lMOb5zXmt6m2FIHrJ+mr2MWBQ5wOQMxfUb2LnvQFJbZZW/9b+q+ukNhKbmCREA3v3jWHXZkgsSZNUN8/z4Hc1i0k/oFNTnbk6Xm/MHzaQab6RZfKDudFyiSumP01wNzZnC3ZQdnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3pqcC+0H15MF9B5wyM3FmHSwIamIXsm60LtH5TFiRo=;
 b=EAnHwrTFsYoIz7il5z78jShdoFataeQSOE/HKxuv/DgEJPXfb3MEZkIixOii0GiqdMKvVV/BL61rLIW/Qivx6Qf/iTolDN9gwss62U5r2JMp9mUS7Eyri42qQy4z/xM7JUMTvnMakjgPN5aCQrTy/3m+uMQBfWJyDUBTXM8u5AQXyjke8re51zsysHYODdU5SYoiKo8Fno2UmsHwnPaW/RGUyM3PIXOph8/3fs2RYxJxOwcOetFI8Vug4Gko/7AU7QfE1bUMtrt33TRqUjhQrpBiWHcgY5+RYPbH5MJa7qrcRo8d3/isiJiZiPm6Qak57y/E3Bb/VhChtU90WSb+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3pqcC+0H15MF9B5wyM3FmHSwIamIXsm60LtH5TFiRo=;
 b=f8obOTaUqbOC2SHMi6/cMZVGBKeG0FnvbSt8aWNSeBo87KDS0XriSW/futAGlnApOk1zvKkU4UCjMi14JuVAwZbD2tTchuQ/HWMi47D0jOKza+pf0IfRquPedn2MN1ulBYjzm5XDlVNhT8p+nME4pxjRoUAdZRI6ZICbyDVXkt0=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by VI1PR08MB5487.eurprd08.prod.outlook.com (2603:10a6:803:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:17:57 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::73ea:d367:20a5:5358]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::73ea:d367:20a5:5358%4]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 10:17:57 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, James Clark
	<James.Clark@arm.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"irogers@google.com" <irogers@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH v4 0/4] perf: Support PERF_SAMPLE_READ with inherit_stat
Thread-Topic: [PATCH v4 0/4] perf: Support PERF_SAMPLE_READ with inherit_stat
Thread-Index: AQHafHgCEyGa3x+fLUesu0xkFXNghbFEiDwAgAO4qoCAA9J2AIAIwcMA
Date: Tue, 2 Apr 2024 10:17:56 +0000
Message-ID: <592120a4c377dd32ce248566ccf360335e0e25b2.camel@arm.com>
References: <20240322164237.203358-1-ben.gainey@arm.com>
	 <CAM9d7chfXH0ynfT_PSPyjhE8ATa=fV-kbx_csgeQrWiv+1EiiQ@mail.gmail.com>
	 <70cb93e37dc6036c7638a2630ae6dcbaa728602a.camel@arm.com>
	 <CAM9d7ciy+8j86n0v_tOiL=MswcVjj+qkROXvOmVd57MT14v_0w@mail.gmail.com>
In-Reply-To:
 <CAM9d7ciy+8j86n0v_tOiL=MswcVjj+qkROXvOmVd57MT14v_0w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 
x-ms-traffictypediagnostic:
	AS8PR08MB6646:EE_|VI1PR08MB5487:EE_|AM2PEPF0001C708:EE_|DBAPR08MB5784:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 pgEb6ta+LxTQN/XHJPXoujlrUBChvGGpuoEngVtu0QieTxacN7RbBehMu25PSvj36khTnfEpDkksucRn2cWsnqBHvHcntXASy4KtL0WFqowcIodiK5xDALrZIOqGGgI1mPdyaNo+c3mWSNGQz8mlw5kxPU9JF4j4Q3/4U/SRRUa6PimGBH+M5ossms5XBn4OZjvR/jQsBZ8n+1NAXbJXSovFmxRWk4e7Qq0DePVUpSzZgkVE6vbIZHH9i3jh3Y7/SiO2CkJ8QKLkRRkR05tohHH2SNNmE9R4qv4kHpwx5zS9LO8Y9qjmmFk5JlSRLbHmCVIMpUHamJC7QVtv3auOfF4Gq/PQx/Jz969uKVTg/H5TUYnIJ21Rn9M6rX6H1bOnZdwURVMV3RUZ0iUvTZTdOLzaFdUNjprLjgM/WgGPArM1J23h/qe569DHV1td0/cBqRs7xc3tr4W5LsfonqnHePWfmrnyKG2L6rr/FL7RUj5ZEDg+W62DQvQ2xDXaer4PxtS69xAZHtCXptx0IJtKxhDlFNh9WDHh9Id4WBBfqEU6gjdWauXmJ0kT6j9bvK9vtB0l6L7LMTYIYrD9I1z3TDGsuhTKERqrwuYxwN0RgEx7sBFCJLbJZ6UHpivy2Jx93ukkQEACXZyGAt8D7IubjLWeUMZJDmsBueomtiPetaQ=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <79C2D00DDADABD4FB1B19D819AB156EE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5487
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C708.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9469a91-e921-4aea-6f37-08dc52fe3005
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JokpdmMl/8P7Lg//uxGVvsMHgqBadnbS20SfPOiLghRhvqCQN050fB+Ooblpj5LVX/tlat+MA06Vs/2hl7e6Wu5ldvZBUpLFrqlv/SaP+YkIkkYUmBUjM2KHQGYmAiUTgfqUrJcUtXAJmbd//rbl0pvziwkp3nOG7ZjLNtjJ5VZb4YjojPx8oTQRnxaRlehgT4c5bW5QvLUjnLclqjB64DBwx6kLHMOZhwI1EyfGyCAqd10Z79tDizd321eRL0AwGJYMk69JFx2Zq5+B5YOIKn7OCEAJ5NPgJyB79HbztwSE5Ayt9Aix/hasm1jAqde2GoHhJrbwqk4DuxPhIV/2ibRqMzpanWNdDCIeKSAkFi/MZGKe87tgcD91kR8P3Ug61gkKg7OUP6vkCYPZB5zDRO7YXlX36risX/FauocEUeZA7f8y6DVrtB5D4vGE+Vz660NWnrJ85GeVQrNa2D33Pg4gcnIBdR+LX4Y7ux9TYh9TajXvU23LwMSLBYJo1Bvv5F962gYakI3YMqc0uMfI4g7R0cHwum4enKr82+HQ+3Gv1zEEO0B3jKnnOXJ6ixaSyBmhgHc21cbDjl4AJZJ7bHmGOo0t7MmlUa+XzM7QSJtDgC96GREHPdSmzk4eA7Yq6aI8P5S6sfxbX0pgge1NotcHlIMowBdIx+yLLTKRpTBW/hpEAq57Ag5G48+yKbeBloLrolHpW63NnCR1zCtt5oiz9p28RM0g/Qdl3kd5AB9Yh1RT6LEFsIRcDmK9wXCq
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:18:05.9663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9469a91-e921-4aea-6f37-08dc52fe3005
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C708.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5784

T24gV2VkLCAyMDI0LTAzLTI3IGF0IDEzOjM0IC0wNzAwLCBOYW1oeXVuZyBLaW0gd3JvdGU6DQo+
IEhlbGxvLA0KPg0KPiBPbiBNb24sIE1hciAyNSwgMjAyNCBhdCAzOjEy4oCvQU0gQmVuIEdhaW5l
eSA8QmVuLkdhaW5leUBhcm0uY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwgMjAyNC0w
My0yMiBhdCAxODoyMiAtMDcwMCwgTmFtaHl1bmcgS2ltIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBN
YXIgMjIsIDIwMjQgYXQgOTo0MuKAr0FNIEJlbiBHYWluZXkgPGJlbi5nYWluZXlAYXJtLmNvbT4N
Cj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIGNoYW5nZSBhbGxvd3MgZXZlbnRz
IHRvIHVzZSBQRVJGX1NBTVBMRSBSRUFEIHdpdGggaW5oZXJpdA0KPiA+ID4gPiBzbw0KPiA+ID4g
PiBsb25nDQo+ID4gPiA+IGFzIGJvdGggaW5oZXJpdF9zdGF0IGFuZCBQRVJGX1NBTVBMRV9USUQg
YXJlIHNldC4NCj4gPiA+ID4NCj4gPiA+ID4gQ3VycmVudGx5IGl0IGlzIG5vdCBwb3NzaWJsZSB0
byB1c2UgUEVSRl9TQU1QTEVfUkVBRCB3aXRoDQo+ID4gPiA+IGluaGVyaXQuDQo+ID4gPiA+IFRo
aXMNCj4gPiA+ID4gcmVzdHJpY3Rpb24gYXNzdW1lcyB0aGUgdXNlciBpcyBpbnRlcmVzdGVkIGlu
IGNvbGxlY3RpbmcNCj4gPiA+ID4gYWdncmVnYXRlDQo+ID4gPiA+IHN0YXRpc3RpY3MgYXMgcGVy
IGBwZXJmIHN0YXRgLiBJdCBwcmV2ZW50cyBhIHVzZXIgZnJvbQ0KPiA+ID4gPiBjb2xsZWN0aW5n
DQo+ID4gPiA+IHBlci10aHJlYWQgc2FtcGxlcyB1c2luZyBjb3VudGVyIGdyb3VwcyBmcm9tIGEg
bXVsdGktdGhyZWFkZWQNCj4gPiA+ID4gb3INCj4gPiA+ID4gbXVsdGktcHJvY2VzcyBhcHBsaWNh
dGlvbiwgYXMgd2l0aCBgcGVyZiByZWNvcmQgLWUgJ3suLi4ufTpTJ2AuDQo+ID4gPiA+IEluc3Rl
YWQNCj4gPiA+ID4gdXNlcnMgbXVzdCB1c2Ugc3lzdGVtLXdpZGUgbW9kZSwgb3IgZm9yZ28gdGhl
IGFiaWxpdHkgdG8gc2FtcGxlDQo+ID4gPiA+IGNvdW50ZXINCj4gPiA+ID4gZ3JvdXBzLiBTeXN0
ZW0td2lkZSBtb2RlIGlzIG9mdGVuIHByb2JsZW1hdGljIGFzIGl0IHJlcXVpcmVzDQo+ID4gPiA+
IHNwZWNpZmljDQo+ID4gPiA+IHBlcm1pc3Npb25zIChubyBDQVBfUEVSRk1PTiAvIHJvb3QgYWNj
ZXNzKSwgb3IgbWF5IGxlYWQgdG8NCj4gPiA+ID4gY2FwdHVyZQ0KPiA+ID4gPiBvZg0KPiA+ID4g
PiBzaWduaWZpY2FudCBhbW91bnRzIG9mIGV4dHJhIGRhdGEgZnJvbSBvdGhlciBwcm9jZXNzZXMg
cnVubmluZw0KPiA+ID4gPiBvbg0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gc3lzdGVtLg0KPiA+ID4g
Pg0KPiA+ID4gPiBQZXJmIGFscmVhZHkgc3VwcG9ydHMgdGhlIGFiaWxpdHkgdG8gY29sbGVjdCBw
ZXItdGhyZWFkIGNvdW50cw0KPiA+ID4gPiB3aXRoDQo+ID4gPiA+IGBpbmhlcml0YCB2aWEgdGhl
IGBpbmhlcml0X3N0YXRgIGZsYWcuIFRoaXMgcGF0Y2ggY2hhbmdlcw0KPiA+ID4NCj4gPiA+IEkn
bSBub3Qgc3VyZSBhYm91dCB0aGlzIHBhcnQuICBJSVVDIGluaGVyaXQgYW5kIGluaGVyaXRfc3Rh
dCBpcw0KPiA+ID4gbm90DQo+ID4gPiBmb3INCj4gPiA+IHBlci10aHJlYWQgY291bnRzLCBpdCBv
bmx5IHN1cHBvcnRzIHBlci1wcm9jZXNzIChpbmNsdWRpbmcNCj4gPiA+IGNoaWxkcmVuKQ0KPiA+
ID4gZXZlbnRzLg0KPiA+DQo+ID4gSGkgTmFtaHl1bmcNCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhl
IGNvbW1lbnRzLi4uDQo+ID4NCj4gPiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgY29ycmVjdCwgaWYg
eW91IGNvbXBhcmUgdGhlIGJlaGF2aW91ciBvZg0KPiA+DQo+ID4gICAgIHBlcmYgcmVjb3JkIC0t
bm8taW5oZXJpdCAuLi4gPHNvbWUtZm9ya2luZy1wcm9jZXNzZXM+DQo+ID4gICAgIHBlcmYgc2Ny
aXB0IC1GIHBpZCx0aWQgfCBzb3J0IC11DQo+ID4gYW5kDQo+ID4gICAgIHBlcmYgcmVjb3JkIC0t
bm8taW5oZXJpdCAuLi4gPHNvbWUtbXVsdGl0aHJlYWRlZC1wcm9jZXNzZXM+DQo+ID4gICAgIHBl
cmYgc2NyaXB0IC1GIHBpZCx0aWQgfCBzb3J0IC11DQo+ID4NCj4gPiB2cw0KPiA+DQo+ID4gICAg
IHBlcmYgcmVjb3JkIC4uLiA8c29tZS1mb3JraW5nLXByb2Nlc3Nlcz4NCj4gPiAgICAgcGVyZiBz
Y3JpcHQgLUYgcGlkLHRpZCB8IHNvcnQgLXUNCj4gPiBhbmQNCj4gPiAgICAgcGVyZiByZWNvcmQg
Li4gPHNvbWUtbXVsdGl0aHJlYWRlZC1wcm9jZXNzZXM+DQo+ID4gICAgIHBlcmYgc2NyaXB0IC1G
IHBpZCx0aWQgfCBzb3J0IC11DQo+ID4NCj4gPiBUaGUgYmVoYXZpb3VyIGlzIGNvbnNpc3RlbnQg
d2l0aCB0aGUgZmFjdCB0aGF0IG5vLWluaGVyaXQgb25seQ0KPiA+IHJlY29yZHMNCj4gPiB0aGUg
cHJpbWFyeSB0aHJlYWQgb2YgdGhlIHByaW1hcnkgcHJvY2Vzcywgd2hlcmVhcyBpbiB0aGUgaW5o
ZXJpdA0KPiA+IGNhc2UNCj4gPiBhbnkgY2hpbGQgdGFza3MgKGVpdGhlciB0aHJlYWRzIG9yIGZv
cmtlZCBwcm9jZXNzZXMpIGlzIHJlY29yZGVkLg0KPg0KPiBSaWdodCwgSSB3YXMgdGFsa2luZyBh
Ym91dCB0aGUgY291bnRpbmcgYmVoYXZpb3Igbm90IHNhbXBsaW5nDQo+IGFzIGluaGVyaXRfc3Rh
dCBpcyBvbmx5IGZvciB0aGUgY291bnRpbmcuICBJIHRoaW5rIGl0J2QgcmV0dXJuIGFuDQo+IGVy
cm9yDQo+IGlmIGV2ZW50IGF0dHIgaGFzIGJvdGggc2FtcGxlX2ZyZXEgYW5kIGluaGVyaXRfc3Rh
dC4NCj4NCj4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gPiBgcGVyZl9ldmVudF9hbGxvY2AgcmVsYXhp
bmcgdGhlIHJlc3RyaWN0aW9uIHRvIGNvbWJpbmUNCj4gPiA+ID4gYGluaGVyaXRgDQo+ID4gPiA+
IHdpdGgNCj4gPiA+ID4gYFBFUkZfU0FNUExFX1JFQURgIHNvIHRoYXQgdGhlIGNvbWJpbmF0aW9u
IHdpbGwgYmUgYWxsb3dlZCBzbw0KPiA+ID4gPiBsb25nDQo+ID4gPiA+IGFzDQo+ID4gPiA+IGBp
bmhlcml0X3N0YXRgIGFuZCBgUEVSRl9TQU1QTEVfVElEYCBhcmUgZW5hYmxlZC4NCj4gPiA+DQo+
ID4gPiBBbnl3YXksIGRvZXMgaXQgcmVhbGx5IG5lZWQgJ2luaGVyaXRfc3RhdCc/ICBJIHRoaW5r
IGl0J3Mgb25seQ0KPiA+ID4gZm9yDQo+ID4gPiBjb3VudGluZyB1c2UgY2FzZXMgKGUuZy4gJ3Bl
cmYgc3RhdCcpIG5vdCBmb3Igc2FtcGxpbmcuDQo+ID4NCj4gPg0KPiA+IEkgd291bGQgYmUgdmVy
eSBoYXBweSB0byByZW1vdmUgdGhlIGluaGVyaXRfc3RhdCByZXF1aXJlbWVudC4gV2hlbg0KPiA+
IEkNCj4gPiBmaXJzdCBjYW1lIHRvIHRoaXMgaXQgc2VlbWVkIGxpa2UgdGhlIGxvZ2ljIHdhcyBh
bGwgdGhlcmUgaW4NCj4gPiBpbmhlcml0X3N0YXQgYWxyZWFkeSwgYnV0IG5vdyB0aGF0IEkgaGF2
ZSB0byB0YWtlIGEgZGlmZmVyZW50IHBhdGgNCj4gPiBpbg0KPiA+IGBwZXJmX2V2ZW50X2NvbnRl
eHRfc2NoZWRfb3V0YCBJIHN1c3BlY3QgaXQgc2hvdWxkIGJlIHRyaXZpYWwgdG8NCj4gPiByZW1v
dmUNCj4gPiB0aGUgaW5oZXJpdF9zdGF0IHJlcXVpcmVtZW50Lg0KPg0KPiBvay4NCg0KPg0KPiA+
ID4NCj4gPiA+IEFsc28gdGVjaG5pY2FsbHksIGl0IGNhbiBoYXZlIFBFUkZfU0FNUExFX1NUUkVB
TV9JRCBpbnN0ZWFkDQo+ID4gPiBvZiBQRVJGX1NBTVBMRV9USUQgdG8gZGlzdGluZ3Vpc2ggdGhl
IGNvdW50ZXIgdmFsdWVzLg0KPiA+DQo+ID4NCj4gPiBJdCBsb29rcyBsaWtlIHlvdSBhcmUgY29y
cmVjdCwgYnV0IHRoZSBJRCBnaXZlbiBpbiB0aGUgcmVhZF9mb3JtYXQNCj4gPiBwYXJ0DQo+ID4g
b2YgUEVSRl9TQU1QTEVfUkVDT1JEIGlzIHRoZSBJRCByYXRoZXIgdGhhbiBTVFJFQU1fSUQuIChJ
IGhhZA0KPiA+IGluY29ycmVjdGx5IHRob3VnaHQvc3RhdGVkIGl0IHdhcyB0aGUgbGF0dGVyKS4g
SGVuY2Ugd2hlbg0KPiA+IHByb2Nlc3NpbmcNCj4gPiB0aGUgcmVhZF9mb3JtYXQgdmFsdWVzIGlu
IHRoZSBzYW1wbGUgcmVjb3JkLCB3ZSBlaXRoZXIgbmVlZCB0byB1c2UNCj4gPiB0aGUNCj4gPiBU
SUQgdG8gdW5pcXVlbHkgaWRlbnRpZnkgdGhlIHNvdXJjZSwgb3Igd2Ugd291bGQgbmVlZCB0byBt
b2RpZnkgdGhlDQo+ID4gcmVhZF9mb3JtYXQgdG8gKGFkZGl0aW9uYWxseSkgaW5jbHVkZSB0aGUg
U1RSRUFNX0lELg0KPiA+DQo+ID4gICogVGhlIGN1cnJlbnQgYXBwcm9hY2ggaW4gdG9vbHMgdXNl
cyB0aGUgSUQrVElELCB3aGljaCBwdXRzIG1vcmUNCj4gPiBjb21wbGV4aXR5IGluIHRoZSB0b29s
cyBidXQgbWVhbnMgdGhlcmUgaXNuJ3QgYW4gZXh0cmEgZmllbGQgaW4gdGhlDQo+ID4gcmVhZF9m
b3JtYXQgZGF0YSAoZm9yIGVhY2ggdmFsdWUpLg0KPiA+ICAqIEFsdGVybmF0aXZlbHkgSSBjb3Vs
ZCBpbnRyb2R1Y2UgYSBQRVJGX0ZPUk1BVF9TVFJFQU1fSUQ7IEkgd291bGQNCj4gPiBleHBlY3Qg
dGhhdCB0aGUgdXNlci90b29sIHdvdWxkIG5lZWQgdG8gc3BlY2lmeQ0KPiA+IFBFUkZfRk9STUFU
X0lEfFBFUkZfRk9STUFUX1NUUkVBTV9JRCBhcyB0aGV5IHdvdWxkIG5lZWQgdG8gdXNlIHRoZQ0K
PiA+IElEDQo+ID4gdG8gbG9va3VwIHRoZSBjb3JyZWN0IHBlcmZfZXZlbnRfYXR0ciwgYnV0IGNv
dWxkIHVzZSB0aGUgU1RSRUFNX0lEDQo+ID4gdG8NCj4gPiB1bmlxdWVseSBpZGVudGlmeSB0aGUg
Y2hpbGQgZXZlbnQuIFRoaXMgYXBwcm9hY2ggd291bGQgYWRkIGFuIGV4dHJhDQo+ID4gdTY0DQo+
ID4gcGVyIHZhbHVlIGluIHRoZSByZWFkX2Zvcm1hdCBkYXRhIGJ1dCBpcyBwb3NzaWJseSBzaW1w
bGVyL3NhZmVyIGZvcg0KPiA+IHRvb2xzPw0KPiA+DQo+ID4gQW55IHByZWZlcmVuY2VzPw0KPg0K
PiBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIHVzZSBUSUQgKyBJRC4gIElJVUMgdGhlcmUncyBubyB3
YXkgdG8gdHJhY2sNCj4gU1RSRUFNX0lEIGZvciBuZXcgY2hpbGRyZW4gb3RoZXIgdGhhbiBnZXR0
aW5nIGl0IGZyb20gc2FtcGxlLg0KPiBBcyBzYW1wbGUgaGFzIFRJRCBhbHJlYWR5IGl0J2QgYmUg
bWVhbmluZ2xlc3MgdXNpbmcgU1RSRUFNX0lEDQo+IHRvIGRpc3Rpbmd1aXNoIGV2ZW50cy4NCg0K
DQpTbyBpIGRpZCBpbXBsZW1lbnQgYSBwcm90b3R5cGUgdmVyc2lvbiBvZiB0aGlzIHdoZXJlOg0K
DQpQRVJGX0ZPUk1BVF9TVFJFQU1fSUQgaXMgYWRkZWQsIGFuZCBgcGVyZiByZWNvcmRgIGlzIG1v
ZGlmaWVkIHRvDQpyZXF1ZXN0IHRoYXQgaW4gYWRkaXRpb24gdG8gUEVSRl9GT1JNQVRfSUQuDQoN
ClRoZSBQRVJGX0ZPUk1BVF9JRCBpcyBuZWNlc3NhcnkgdG8gaWRlbnRpZnkgd2hpY2ggcGVyZl9l
dmVudF9hdHRyL2V2c2VsDQp0aGUgY291bnRlciByZXByZXNlbnRzLCBhbmQgdGhlIFBFUkZfRk9S
TUFUX1NUUkVBTV9JRCB1bmlxdWVseQ0KaWRlbnRpZmllcyB0aGUgY2hpbGQgdGhyZWFkLiBJdCBy
ZXF1aXJlcyBhbG1vc3QgYWxsIHRoZSBzYW1lIHBsdW1iaW5nDQphcyB0aGUgcHJldmlvdXMgaW1w
bGVtZW50YXRpb24uLi4gSSBqdXN0IG1vZGlmaWVkIG15DQpgcGVyZl9zYW1wbGVfaWRfX2dldF9w
ZXJpb2Rfc3RvcmFnZWAgaW4gcGF0Y2ggMy80IHRvIHRha2UgdGhlIHU2NA0Kc3RyZWFtIGlkIGlu
c3RlYWQgb2YgdGhlIHUzMiB0aWQuIEkgZXhwZWN0IHRoZXJlIGNvdWxkIGJlIHNvbWUgY2xlYW51
cA0KdGhlcmUsIGJ1dCBJIGd1ZXNzIGl0IGhpZ2hsaWdodHMgdGhlIGZhY3QgdGhhdCB0aGV5IGFt
b3VudCB0byB0aGUgc2FtZQ0Kb3V0Y29tZS4NCg0KSSdsbCBwYXJrIHRoYXQgYW5kIHB1c2ggb3V0
IGEgbmV3IHBhdGNoIHNldCB3aXRoIGp1c3QgdGhlIGluaGVyaXQNCnJlcXVpcmVtZW50Lg0KDQpU
aGFua3MNCg0KQmVuDQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFp
bCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHBy
aXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBu
b3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250
ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9y
ZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=

