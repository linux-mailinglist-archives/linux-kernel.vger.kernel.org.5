Return-Path: <linux-kernel+bounces-149907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010288A97BE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF4128199D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8592215DBC5;
	Thu, 18 Apr 2024 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Tlc3znyI";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Tlc3znyI"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2052.outbound.protection.outlook.com [40.107.241.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A132315B96D;
	Thu, 18 Apr 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.52
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437311; cv=fail; b=qnrdho/yGLBetW/ssL3NUHAoQ+RQ1Kazue6klO55lJppbll5cOuuDnsO2HZef6kQiK9anwrHG0YxUCsK4B1TJoOkp5sjn+yG8aHsdyQwA4XfbjndYk77qZ54ov8pga2eFdKJtnpHm9DLaX/1ItDZVItw3DHJVwialV8HStQmtD0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437311; c=relaxed/simple;
	bh=RuqUKkqPooVXDJj9Ee6PMehw/1uhLN5puO7/7dpts+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BVQbBaypTKKgEZARCH8Fbm8TUbrqQ/b5/EuF5DYurfo7G3eYaA1q63Oinc4DrfT7hIq+bzHuPjZNNEFWVL0+oH0wPORjgN4tPr1hWteOZa/y7MLcAfoEyVXi9h9UnV9jGJ7N9Hv2bkdefYE6BZH2owteZiAa987bxSwWCejlPxc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=Tlc3znyI; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=Tlc3znyI; arc=fail smtp.client-ip=40.107.241.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=F02MgKhaTo41pnq5FnazPyo5a76wZiY094TYIYACX+x/ShO/jM44Y8UTu4DiP4Pp/UWwFQ13cNOni1yZKSlqTMB7nzJ3zjkWKBEZwZIaLZ2u9RYq2ZsswOHyFpLq7aENE1j+CgOns/tG/yJPq8FgwhTmmyWv5EoN1wR/gwcEDW08EpWSuUPdkBKy2mvvToEwFJxsI/wsIB94c1BtS7irUfa1lqda2j5J2ruHosHFarXA48ekT987T5y448hNZWYHdDt1kyup1NMPRqi6x62UI9ujapFp8Mh5wJ6uLfLS8tQA10I3Hdt4HvafAS+HHbEz7kWBTWjwCOc30gfj5rFZog==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU+4Kc8nnCGON6KyHe+TeBoYob5aNi8eDWk6+NB49DU=;
 b=JMvjILeOzHWJiBhlg2Y3d0pM5Iu6WyZQZVlyuTn6axJYJ2r/ZgidEqZVxH/uvxi6pkIiS8SmLsv0Cn3BWpceGPeDKsmgekcfpoKG/G65LZeCRg/TvPy6PMGQCmFVj1p4hvg9d/fD6Zij1+NpNo7ZAEon7u/lTcvbhSwiKSyDw5WKVz6/DsGBominF5EcY8dCZeoRF2io3wrFzsmFoNs+ln1d/2K7Ix3QFt9bZGArgEIKIRHq63xFNLzXrAOFFbNM1BXxacgtFrgYy9Lq974BEiRHVpB6g2PxbxuKaMKcN00Xl12PqyYcS2a+kdEkQSs5Me0EWDCKl0ngWAZbYbqjXQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU+4Kc8nnCGON6KyHe+TeBoYob5aNi8eDWk6+NB49DU=;
 b=Tlc3znyIYIybKo8uDG2aVXjMXZ/Oy0xKquErAYwLJkB2q3nVfqepM22wr7OMQZv7uTdilhKNezf2hBVsYslThe1cB1xIKE6pkRGcOWEdsKpU+HVF6jcYfMo2iSE1PuwNPj7VeuvK6cpB0F+ReflMrP0zQxU1oKz+42mFbKYNHVM=
Received: from DUZPR01CA0122.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::26) by AS1PR08MB7612.eurprd08.prod.outlook.com
 (2603:10a6:20b:477::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 10:48:13 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:4bc:cafe::76) by DUZPR01CA0122.outlook.office365.com
 (2603:10a6:10:4bc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.23 via Frontend
 Transport; Thu, 18 Apr 2024 10:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7452.22
 via Frontend Transport; Thu, 18 Apr 2024 10:48:13 +0000
Received: ("Tessian outbound 01a47eb2eb85:v313"); Thu, 18 Apr 2024 10:48:12 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e3245234062996d5
X-CR-MTA-TID: 64aa7808
Received: from a39508fde16f.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 90D97D1C-5B7D-4058-896A-13C3A177EB23.1;
	Thu, 18 Apr 2024 09:25:40 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a39508fde16f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 18 Apr 2024 09:25:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LV6zODfRNz9zo1y+l7D626mtv7/2LH4GBvinymO2hm3BzqQG8DMihkFhws0HKfFBkmXiW2yrHKtukQeZUvGeTTvY7131U9FzH67OncqiaBZVX3KlhAUf8dTdlH4nds6tFC1BccN4tH5eo6q4sH8legt3CH4RypJsv3nEs7CYKxHPbK3DBUoCDFLFdocYuzSb/ENpAYH+98BuBVZ/MREPIl4e7gdC7X1EtlzxWqRxScJFnVGw/PeVfsKetm234sqRElBhX4Ob/eR0M9GZxP1Q6LJHmH9Xi1JXsptFuU3lLQBc9f/k4cnTU0FFX13k85YZBN4toAprIHghgYwW/csMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU+4Kc8nnCGON6KyHe+TeBoYob5aNi8eDWk6+NB49DU=;
 b=BryOQlIlKUDMSZwxX/jb4N/rLO0SEbagjeow/8EHjb3Ryr6DYnE6R2pJHHehWmn5cRgA/A8CdMFCrRyV2pLVAG89/Npo+Dh6BQ6SeeyJkhKRAB4qHksqPYyTH7O/BvDaAmktUEDQeJvhKrILAApuVoldpbF99ho9+M+nkKiSGCMIEaiIbzMh3QF6DDHxoLZ0YNXeaOLUxb+4r5SOEx3tPT6rPA+3RA/POdck4TX/jnBVRy/wSCbFuVGde4cTKMBBBlLgtFKBmVPPgRmdhYytTax5p4/wkeqQ5NjAwmNumK4YJSkK/3dn7/iM7nP3eNasgMlVZR0uV60V18Keq1fKwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU+4Kc8nnCGON6KyHe+TeBoYob5aNi8eDWk6+NB49DU=;
 b=Tlc3znyIYIybKo8uDG2aVXjMXZ/Oy0xKquErAYwLJkB2q3nVfqepM22wr7OMQZv7uTdilhKNezf2hBVsYslThe1cB1xIKE6pkRGcOWEdsKpU+HVF6jcYfMo2iSE1PuwNPj7VeuvK6cpB0F+ReflMrP0zQxU1oKz+42mFbKYNHVM=
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by GV1PR08MB8404.eurprd08.prod.outlook.com (2603:10a6:150:80::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 09:25:36 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::c392:bd57:e439:1f25]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::c392:bd57:e439:1f25%5]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 09:25:36 +0000
From: Mike Leach <Mike.Leach@arm.com>
To: Suzuki Poulose <Suzuki.Poulose@arm.com>, Mike Leach
	<mike.leach@linaro.org>
CC: Tao Zhang <quic_taozha@quicinc.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Konrad Dybcio <konradybcio@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Jinlong Mao <quic_jinlmao@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Tingwei Zhang <quic_tingweiz@quicinc.com>,
	Yuanfang Zhang <quic_yuanfang@quicinc.com>, Trilok Soni
	<quic_tsoni@quicinc.com>, Song Chai <quic_songchai@quicinc.com>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"andersson@kernel.org" <andersson@kernel.org>
Subject: RE: [PATCH 2/4] coresight: Add support for multiple output ports on
 the funnel
Thread-Topic: [PATCH 2/4] coresight: Add support for multiple output ports on
 the funnel
Thread-Index:
 AQHae2pv0mdrG+VBKEuFHrmNfSaS57FCZocAgAwZLACAESRRAIAAZwEAgAluhoCAAaG0AIABPxQAgAGJMYCAAAMmgIAAA3Fw
Date: Thu, 18 Apr 2024 09:25:36 +0000
Message-ID:
 <PAVPR08MB967408AB27E2FBCCBAE070188C0E2@PAVPR08MB9674.eurprd08.prod.outlook.com>
References: <1711009927-17873-1-git-send-email-quic_taozha@quicinc.com>
 <1711009927-17873-3-git-send-email-quic_taozha@quicinc.com>
 <8d381e6e-9328-46ff-83fe-efbe5bb4363e@arm.com>
 <ffce4577-b0f9-4af3-a379-0385a02ddae8@quicinc.com>
 <a8947ac4-e251-47ba-b44a-6f4fc58f1aac@arm.com>
 <6baaff95-728b-4492-ae3e-00dedbb50fb0@quicinc.com>
 <7fc09bfe-b34a-4658-a141-105f0f62e62c@arm.com>
 <CAJ9a7VjP_B8o4krdZcz3J9qzUMSYmvVyy4cFyrYZOdg43YD2YA@mail.gmail.com>
 <1f9609fe-298f-4a5f-aa5e-be8c7dd6a719@arm.com>
 <CAJ9a7Vif3HKcrT16W=jSs-G21idr+ZKGg67F7yQ71L9Laasujg@mail.gmail.com>
 <754fa8ba-5736-4a03-a321-0b40bd8b4d4b@arm.com>
In-Reply-To: <754fa8ba-5736-4a03-a321-0b40bd8b4d4b@arm.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAVPR08MB9674:EE_|GV1PR08MB8404:EE_|DU2PEPF00028D06:EE_|AS1PR08MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 54771280-fda1-4286-344d-08dc5f950bed
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 7r9VMB+CYrBqvhmJFjngd3j0KuD1s+kgx5tL+7baTBrjkPljXfr6Eq0oKbYA1NR/I+5CIhR0XbfIeFrj5YoQG0mIpXuRQXUGtaRwVxfURAbBlpWrINA3sjsAEYUuTts1Wl2qQnHLrF3t3zthAYSjaOdZzo08tVzZz6jkTZR/V8ZU2CzCiqrvGYBTTil81WMnHEeBP+FCEQuSqUjXs8+HyDG+L6mjx58vNzVRo6BOOCw6qL/rDnjLtXtEUK5kaz8C2OMZWQh6uLA9otFYOSrRr/gQsASL7az7kCClT3QOrAh6fz5oAidurG9Pu34yL7k5eR4POKlRVPYkT+2W+67GN/UTwe0AJUZV/Q+uDJUbjv2JhrxgoMCYVaBeMnNY4d/QfH+vOebMU2ag+MUFbEtcN3TlKKSHk3S6EMxoZm25IfWRtnT59BoerlKB7SbosK1+3ECJ3d68H3yHzLu9FhAQwyPyxx4WsdgH5FAUHf+2vGHCX8M6HfW+qZhSPgaZ7c6ERtfxgStPltThxso2SCCnIL9Tm8fzy8WGXsm+p7uN5RKz6e8u0jWO3Terh+VBlStZv5Yz6MIN1kKbVaNAZabWdq4U/D20V1QpHvGd2g/iSUqihUGbGIyDrR40Gq7B3s/cXucSdnZ882T+jEqUxYGUjMNlvxhkrLqFoi+Ru2B6tMYb29iEHJedGrkAAb3e3hWlvUhvLY9WCH9/IJANENn/Ja+AhLMnMYvEyT3krD0WZbU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8404
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f446ad10-7e77-48e9-7ad0-08dc5f898146
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oSE4+uQveo2YhwzbfrJJ24jBUCoDU3NDBhZXRnW6IDTXzFTOWp0mI867FUsFA0GfmhdlcoDNDVIQcdgEymx99ePVYmjezfmYiSfpVOO2ZKqfnTIIgxghvyALdb5zzD2CKQpUh0/bM4RuMCJTvI8QKl3nD2jHTRvx2stTDXzDcdStav2fvQxY7AJ8hAikXBGLsDI30y4JKDfCyAB34PJUkYtsPTTuB5fe0R7B44dVN+71ZruJOEj18jXI6aqwQhwsO6YDtqJ55ehPRNc/E4r+DdAPcugm7YLWV4OqfgV2VFEDDRDn9e+UOAt8GQTwF+DNfqe7m/nbyeAk0PC+p12/lu80i4rUO/9cSXLp4+108Ic4Nj/UZdbjXxSWb+2Qla8Xb7J0HFdASSlODDr4/ZIY7nTtkuyszIlFikjC38j0cwepFHF07B3wh81VC8cxWLGtlKl3aCZXHMNFXAHQxhHzLRkPVzXjf/IyC+NVRYLx27bjs10IObtXceXA8J+BaTjozwYrIcWUB6nY5NK6gtwoCI5QCcr+Rln2O54v8wCP6HW09P4QCdza07W3yqO9FSxjv2vfSpVIrGgd0d7/JNqY1TJZHGjWCwWomCQ+bjNWCobQMe3wWc2nitbR9rZs9daZfQhu3ni1F68QEMHP4UO8iUsw8faPWqG+Yt6gQbIBlzRrFAltIi0+j6t/zYk5+hLeQDx9xHvB6IqE+0pukQdljbqj0kejEfMmGVfPYCuwLbcvmMkhzHyoh/y+a//Xswaj
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:48:13.3534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54771280-fda1-4286-344d-08dc5f950bed
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7612

Hi Suzuki

> -----Original Message-----
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> Sent: Thursday, April 18, 2024 10:00 AM
> To: Mike Leach <mike.leach@linaro.org>
> Cc: Tao Zhang <quic_taozha@quicinc.com>; Mathieu Poirier
> <mathieu.poirier@linaro.org>; Alexander Shishkin
> <alexander.shishkin@linux.intel.com>; Konrad Dybcio
> <konradybcio@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Jinlong Mao
> <quic_jinlmao@quicinc.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; coresight@lists.linaro.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Tingwei Zhang <quic_tingweiz@quicinc.com>;
> Yuanfang Zhang <quic_yuanfang@quicinc.com>; Trilok Soni
> <quic_tsoni@quicinc.com>; Song Chai <quic_songchai@quicinc.com>; linux-ar=
m-
> msm@vger.kernel.org; andersson@kernel.org
> Subject: Re: [PATCH 2/4] coresight: Add support for multiple output ports=
 on the
> funnel
>=20
> Hi Mike
>=20
> On 18/04/2024 09:48, Mike Leach wrote:
> > Hi Suzuki
> >
> > On Wed, 17 Apr 2024 at 10:21, Suzuki K Poulose <suzuki.poulose@arm.com>
> wrote:
> >>
> >> Hi Mike
> >>
> >> On 16/04/2024 15:19, Mike Leach wrote:
> >>> Hi,
> >>>
> >>> On Mon, 15 Apr 2024 at 14:24, Suzuki K Poulose <suzuki.poulose@arm.co=
m>
> wrote:
> >>>>
> >>>> On 09/04/2024 14:22, Tao Zhang wrote:
> >>>>>
> >>>>> On 4/9/2024 3:13 PM, Suzuki K Poulose wrote:
> >>>>>> Hi
> >>>>>>
> >>>>>> On 29/03/2024 09:27, Tao Zhang wrote:
> >>>>>>>
> >>>>>>> On 3/22/2024 12:41 AM, Suzuki K Poulose wrote:
> >>>>>>>> On 21/03/2024 08:32, Tao Zhang wrote:
> >>>>>>>>> Funnel devices are now capable of supporting multiple-inputs
> >>>>>>>>> and multiple-outputs configuration with in built hardware
> >>>>>>>>> filtering for TPDM devices. Add software support to this
> >>>>>>>>> function. Output port is selected according to the source in th=
e trace
> path.
> >>>>>>>>>
> >>>>>>>>> The source of the input port on funnels will be marked in the
> >>>>>>>>> device tree.
> >>>>>>>>> e.g.
> >>>>>>>>> tpdm@xxxxxxx {
> >>>>>>>>>        ... ... ... ...
> >>>>>>>>> };
> >>>>>>>>>
> >>>>>>>>> funnel_XXX: funnel@xxxxxxx {
> >>>>>>>>>        ... ... ... ...
> >>>>>>>>>        out-ports {
> >>>>>>>>>            ... ... ... ...
> >>>>>>>>>            port@x {
> >>>>>>>>>                ... ... ... ...
> >>>>>>>>>                label =3D "xxxxxxx.tpdm"; <-- To label the sourc=
e
> >>>>>>>>>            };                           corresponding to the ou=
tput
> >>>>>>>>>        ... ... ... ...                  connection "port@x". An=
d this
> >>>>>>>>>        };                               is a hardware static
> >>>>>>>>> connections.
> >>>>>>>>>        ... ... ... ...                  Here needs to refer to =
hardware
> >>>>>>>>> };                                   design.
> >>>>>>>>>
> >>>>>>>>> Then driver will parse the source label marked in the device
> >>>>>>>>> tree, and save it to the coresight path. When the function
> >>>>>>>>> needs to know the source label, it could obtain it from coresig=
ht path
> parameter.
> >>>>>>>>> Finally,
> >>>>>>>>> the output port knows which source it corresponds to, and it
> >>>>>>>>> also knows which input port it corresponds to.
> >>>>>>>>
> >>>>>>>> Why do we need labels ? We have connection information for all
> >>>>>>>> devices (both in and out), so, why do we need this label to find=
 a device
> ?
> >>>>>>>
> >>>>>>> Because our funnel's design has multi-output ports, the data
> >>>>>>> stream will not
> >>>>>>>
> >>>>>>> know which output port should pass in building the data trace pat=
h.
> >>>>>>> This source
> >>>>>>>
> >>>>>>> label can make the data stream find the right output port to go.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> And also, I thought TPDM is a source device, why does a funnel
> >>>>>>>> output port link to a source ?
> >>>>>>>
> >>>>>>> No, this label doesn't mean this funnel output port link to a
> >>>>>>> source, it just let
> >>>>>>>
> >>>>>>> the output port know its data source.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Are these funnels programmable ? Or, are they static ? If they
> >>>>>>>> are static, do these need to be described in the DT ? If they
> >>>>>>>> are simply acting as a "LINK" (or HWFIFO ?)
> >>>>>>>
> >>>>>>> These funnels are static, and we will add the "label" to the DT
> >>>>>>> to describe the
> >>>>>>>
> >>>>>>> multi-output ports for these funnels.
> >>>>>>
> >>>>>> I think there is still a bit of confusion. By "Dynamic" I mean,
> >>>>>> the "dynamic funnel" (explicit port enablement via MMIO) vs
> >>>>>> "static funnel" (no programming, always ON).
> >>>>>>
> >>>>>> So, coming to your example, do we need to "explicitly" enable
> >>>>>> trace flow for an "input" and/or an "output" port in your "funnel"=
 ?
> >>>>>
> >>>>> Sorry for my misunderstanding in the previous mails. Our funnels
> >>>>> are programmable just like the common dynamic funnels.
> >>>>>
> >>>>> In our solution, we just make funnels have multiple output ports
> >>>>> connected to different devices or ports. When we use it, we still
> >>>>>
> >>>>> enable the input port through programming. Our solution is to know
> >>>>> which input port the expected data comes from based on the
> >>>>>
> >>>>> source label corresponding to the output port. This way we can
> >>>>> build the expected trace path. In other respects, it is used the
> >>>>> same
> >>>>>
> >>>>> as common dynamic funnels.
> >>>>
> >>>>
> >>>> Ok. So, to summarise :
> >>>>
> >>>> 1. This is not a standard Funnel, but a trace link with multiple-inp=
ut
> >>>>       and multiple-output, with inputs hardwired to an outline at
> >>>>       integration.
> >>>> 2. The programming model is same as that of a "standard funnel".
> >>>>
> >>>> Now, we do have enough information in the coresight_connections to
> >>>> traverse input/output ports. But we need additional logic to
> >>>> "hardwire" the ports to each other and necessary logic to handle
> >>>> the
> >>>>
> >>>> There are two options here :
> >>>>
> >>>> 1. Treat this as a new component and have its own driver, with
> >>>>       additional logic to handle the input/output wiring.
> >>>>
> >>>> 2. Drive it using the funnel driver, with a a new compatible and
> >>>>       add additional logic to handle the input/output wiring.
> >>>>
> >>>> My inclination is towards (2), we need to see how this works out.
> >>>>
> >>>> We need to irrespective of the options, we need special handling
> >>>> for hardwired ports in 1) building path 2) walking back the path
> >>>> (in TPDA driver)
> >>>>
> >>>> We also need some "DT" information to bind a given input port to an
> >>>> output port. We must not use "any device" labels to hack this up,
> >>>> like the approach in this series.
> >>>>
> >>>
> >>> Given that the internal connections are static for the given device,
> >>> then the compatible will imply these connections in just the same
> >>> way as the arm,coresight-funnel implies that all inputs are
> >>> connected to the single output.
> >>
> >> I am sorry, I couldn't follow the last part. We have two or more
> >> output ports and we need a way to identify, which input port is
> >> hardwired to
> >> output-port0 and output-port1. Given we need special handling for
> >> these anyway, I would like to avoid hard coding the input-output conne=
ction.
> >> i.e., we do not want to assume that input-0  is always =3D> output-0.
> >>
> >
> > If we regard the current component as having compatible
> > "qcom,coresight-compound-funnel-v1", then this identifies the
> > relationship between the in-ports and out-ports.
> > So the new driver / extension to the funnel driver that handles this
> > compatible with know the static mapping between input and output so
> > program it.
>=20
> Ok, but like I said, having one compatible may not be enough to know the =
"static"
> mapping for all possible device instances on different SoCs.
>=20

The compatible name would have to change if the mapping changed.=20
Using the compatible is simpler, but less flexible

> >
> > If however you want a more generic approach to handle future different
> > versions of the component, then of course a method in DT of mapping
> > in-ports to out-ports is useful.
> >
> > If did wonder if something along the lines of:-
> >
> > compound-funnel@0x1234000 {
> >       compatible =3D "compound-funnel"
> >       regs =3D < 0x1234000 0x1000>
> >        sub-funnel@0 {
> >                   in-ports {
> >                          [some port definitions]
> >                    }
> >                   out-ports {
> >                         [some port definitions]
> >                    }
> >         }
> >        sub-funnel@1 {
> >                   in-ports {
> >                          [some port definitions]
> >                    }
> >                   out-ports {
> >                         [some port definitions]
> >                   }
> >          }
> > }
>=20
> That would work, with "two" different coresight devices for each "embedde=
d
> funnel". And that also confuses the user with the topology.

I wasn't suggesting two different coresight devices, but finding a way to i=
terate the sub-nodes to create a single device with the inputs mapped to ou=
tputs. Which may or may not be easily do-able.

As to topology - no more confusing than a "funnel" with multiple outputs, o=
r phandle links between inputs and outputs. It does visually represent what=
 the device really is - multiple effective funnels controlled by a single s=
et of registers.

Mike

>=20
> >
> >
> > might be made to work? not sure about the implications of having more
> > that one set of in-ports and out-ports in a component in the device
> > tree & would need specific handling in the driver to iterate
> > sub-funnels.
> >
> >
> >>
> >>>
> >>> Irrespective of if a new driver is used, or an extension to the
> >>> current funnel driver to handle a new compatible - the mapping
> >>> between input and output ports are created based on the compatible..
> >>>
> >>> As we are building a path from source to sink, what is then needed
> >>> is a method in the generic path building code, to recognise these
> >>> amppings and filter the output ports that are searched based on the
> >>> input port in use.
> >>
> >> Agreed. We could mark this as a property of the
> >> port/coresight_connection.
> >>
> >>>
> >>> On standard components, where the mapping is not present, then the
> >>> code will continue as it does now, for these compound funnels, the
> >>> mappings will be present and the output filtering will occur.
> >>
> >> Agreed
> >>
> >>> This removes the need for the labels / extra connection attributes
> >>> on devices other than the funnel, and also removes the need to
> >>> specify the internal connections as part of the device tree.
> >>
> >> I am still not clear how we map the input-output ports. Rest is what
> >> exactly I had in mind. So, once we sort out the port mapping we could
> >> proceed to the prototyping.
> >>
> >
> > given we iterate by output port index into an array of out ports, and
> > have an array of in-ports by index, a third mapping array, same size
> > as in-ports, determining the associated out port index should suffice.
> > Mapping array should be optional - if not there, path discovery works
> > as previously
>=20
> We could simply add a "(sticky)flag" to the
> "coresight_connection".src_port/dest_port and extend the array to include=
 the
> sticky_port for src/dest port and use that flag to force the path travers=
al.
>=20
> Suzuki
>=20
>=20
>=20
> >
> > Regards
> >
> > Mike
> >
> >> Kind regards
> >> Suzuki
> >>
> >>
> >>>
> >>> Regards
> >>>
> >>> Mike
> >>>
> >>>> Rob/Krzysztof,
> >>>>
> >>>> Do you have any recommendations for describing the 'hard wired
> >>>> ports' ?
> >>>>
> >>>> e.g:
> >>>>
> >>>> component {
> >>>>       input_ports {
> >>>>          component_input_port0: port@0 {
> >>>>              ...
> >>>>              <hard-wired-to*> =3D &component_output_port0;
> >>>>          };
> >>>>          ...
> >>>>      };
> >>>>
> >>>>      output_ports {
> >>>>        componentne_output_port0: port@0 {
> >>>>            ...
> >>>>            <hard-wired-to> =3D &component_input_port0;
> >>>>        };
> >>>>        ...
> >>>>      };
> >>>>
> >>>> };
> >>>>
> >>>> *Need a better suitable property than "hard-wired-to".
> >>>>
> >>>>
> >>>> Suzuki
> >>>>
> >>>>
> >>>>>
> >>>>>
> >>>>> Best,
> >>>>>
> >>>>> Tao
> >>>>>
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> "If they are simply acting as a "LINK" (or HWFIFO ?) " I'm not
> >>>>>>> sure what's the meaning
> >>>>>>
> >>>>>> i.e, Like TMC-ETF in HWFIFO mode. In this mode, the TMC-ETF is
> >>>>>> acting like a cache for easing ATB data load, by providing h/w buf=
fering.
> >>>>>> (In your case, it may not be providing any buffering, it doesn't
> >>>>>> matter either way, as it is not visible to the driver).
> >>>>>>
> >>>>>> Suzuki
> >>>>>>
> >>>>>>>
> >>>>>>> of this. Could you describe it in detail?
> >>>>>>>
> >>>>>>>
> >>>>>>> Best,
> >>>>>>>
> >>>>>>> Tao
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Suzuki
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> >>>>>>>>> ---
> >>>>>>>>>     drivers/hwtracing/coresight/coresight-core.c  | 81
> >>>>>>>>> ++++++++++++++++---
> >>>>>>>>>     .../hwtracing/coresight/coresight-platform.c  |  5 ++
> >>>>>>>>>     include/linux/coresight.h                     |  2 +
> >>>>>>>>>     3 files changed, 75 insertions(+), 13 deletions(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c
> >>>>>>>>> b/drivers/hwtracing/coresight/coresight-core.c
> >>>>>>>>> index 5dde597403b3..b1b5e6d9ec7a 100644
> >>>>>>>>> --- a/drivers/hwtracing/coresight/coresight-core.c
> >>>>>>>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
> >>>>>>>>> @@ -113,15 +113,63 @@ struct coresight_device
> >>>>>>>>> *coresight_get_percpu_sink(int cpu)
> >>>>>>>>>     }
> >>>>>>>>>     EXPORT_SYMBOL_GPL(coresight_get_percpu_sink);
> >>>>>>>>>     +static struct coresight_device
> >>>>>>>>> *coresight_get_source(struct list_head *path)
> >>>>>>>>> +{
> >>>>>>>>> +    struct coresight_device *csdev;
> >>>>>>>>> +
> >>>>>>>>> +    if (!path)
> >>>>>>>>> +        return NULL;
> >>>>>>>>> +
> >>>>>>>>> +    csdev =3D list_first_entry(path, struct coresight_node,
> >>>>>>>>> link)->csdev;
> >>>>>>>>> +    if (csdev->type !=3D CORESIGHT_DEV_TYPE_SOURCE)
> >>>>>>>>> +        return NULL;
> >>>>>>>>> +
> >>>>>>>>> +    return csdev;
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> +/**
> >>>>>>>>> + * coresight_source_filter - checks whether the connection
> >>>>>>>>> +matches
> >>>>>>>>> the source
> >>>>>>>>> + * of path if connection is binded to specific source.
> >>>>>>>>> + * @path:    The list of devices
> >>>>>>>>> + * @conn:    The connection of one outport
> >>>>>>>>> + *
> >>>>>>>>> + * Return zero if the connection doesn't have a source binded
> >>>>>>>>> + or
> >>>>>>>>> source of the
> >>>>>>>>> + * path matches the source binds to connection.
> >>>>>>>>> + */
> >>>>>>>>> +static int coresight_source_filter(struct list_head *path,
> >>>>>>>>> +            struct coresight_connection *conn) {
> >>>>>>>>> +    int ret =3D 0;
> >>>>>>>>> +    struct coresight_device *source =3D NULL;
> >>>>>>>>> +
> >>>>>>>>> +    if (conn->source_label =3D=3D NULL)
> >>>>>>>>> +        return ret;
> >>>>>>>>> +
> >>>>>>>>> +    source =3D coresight_get_source(path);
> >>>>>>>>> +    if (source =3D=3D NULL)
> >>>>>>>>> +        return ret;
> >>>>>>>>> +
> >>>>>>>>> +    if (strstr(kobject_get_path(&source->dev.kobj, GFP_KERNEL)=
,
> >>>>>>>>> +            conn->source_label))
> >>>>>>>>> +        ret =3D 0;
> >>>>>>>>> +    else
> >>>>>>>>> +        ret =3D -1;
> >>>>>>>>> +
> >>>>>>>>> +    return ret;
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>>     static struct coresight_connection *
> >>>>>>>>>     coresight_find_out_connection(struct coresight_device *src_=
dev,
> >>>>>>>>> -                  struct coresight_device *dest_dev)
> >>>>>>>>> +                  struct coresight_device *dest_dev,
> >>>>>>>>> +                  struct list_head *path)
> >>>>>>>>>     {
> >>>>>>>>>         int i;
> >>>>>>>>>         struct coresight_connection *conn;
> >>>>>>>>>           for (i =3D 0; i < src_dev->pdata->nr_outconns; i++) {
> >>>>>>>>>             conn =3D src_dev->pdata->out_conns[i];
> >>>>>>>>> +        if (coresight_source_filter(path, conn))
> >>>>>>>>> +            continue;
> >>>>>>>>>             if (conn->dest_dev =3D=3D dest_dev)
> >>>>>>>>>                 return conn;
> >>>>>>>>>         }
> >>>>>>>>> @@ -312,7 +360,8 @@ static void coresight_disable_sink(struct
> >>>>>>>>> coresight_device *csdev)
> >>>>>>>>>       static int coresight_enable_link(struct coresight_device =
*csdev,
> >>>>>>>>>                      struct coresight_device *parent,
> >>>>>>>>> -                 struct coresight_device *child)
> >>>>>>>>> +                 struct coresight_device *child,
> >>>>>>>>> +                 struct list_head *path)
> >>>>>>>>>     {
> >>>>>>>>>         int ret =3D 0;
> >>>>>>>>>         int link_subtype;
> >>>>>>>>> @@ -321,8 +370,8 @@ static int coresight_enable_link(struct
> >>>>>>>>> coresight_device *csdev,
> >>>>>>>>>         if (!parent || !child)
> >>>>>>>>>             return -EINVAL;
> >>>>>>>>>     -    inconn =3D coresight_find_out_connection(parent, csdev=
);
> >>>>>>>>> -    outconn =3D coresight_find_out_connection(csdev, child);
> >>>>>>>>> +    inconn =3D coresight_find_out_connection(parent, csdev, pa=
th);
> >>>>>>>>> +    outconn =3D coresight_find_out_connection(csdev, child,
> >>>>>>>>> + path);
> >>>>>>>>>         link_subtype =3D csdev->subtype.link_subtype;
> >>>>>>>>>           if (link_subtype =3D=3D CORESIGHT_DEV_SUBTYPE_LINK_ME=
RG
> >>>>>>>>> &&
> >>>>>>>>> IS_ERR(inconn))
> >>>>>>>>> @@ -341,7 +390,8 @@ static int coresight_enable_link(struct
> >>>>>>>>> coresight_device *csdev,
> >>>>>>>>>       static void coresight_disable_link(struct coresight_devic=
e *csdev,
> >>>>>>>>>                        struct coresight_device *parent,
> >>>>>>>>> -                   struct coresight_device *child)
> >>>>>>>>> +                   struct coresight_device *child,
> >>>>>>>>> +                   struct list_head *path)
> >>>>>>>>>     {
> >>>>>>>>>         int i;
> >>>>>>>>>         int link_subtype;
> >>>>>>>>> @@ -350,8 +400,8 @@ static void coresight_disable_link(struct
> >>>>>>>>> coresight_device *csdev,
> >>>>>>>>>         if (!parent || !child)
> >>>>>>>>>             return;
> >>>>>>>>>     -    inconn =3D coresight_find_out_connection(parent, csdev=
);
> >>>>>>>>> -    outconn =3D coresight_find_out_connection(csdev, child);
> >>>>>>>>> +    inconn =3D coresight_find_out_connection(parent, csdev, pa=
th);
> >>>>>>>>> +    outconn =3D coresight_find_out_connection(csdev, child,
> >>>>>>>>> + path);
> >>>>>>>>>         link_subtype =3D csdev->subtype.link_subtype;
> >>>>>>>>>           if (link_ops(csdev)->disable) { @@ -507,7 +557,7 @@
> >>>>>>>>> static void coresight_disable_path_from(struct
> >>>>>>>>> list_head *path,
> >>>>>>>>>             case CORESIGHT_DEV_TYPE_LINK:
> >>>>>>>>>                 parent =3D list_prev_entry(nd, link)->csdev;
> >>>>>>>>>                 child =3D list_next_entry(nd, link)->csdev;
> >>>>>>>>> -            coresight_disable_link(csdev, parent, child);
> >>>>>>>>> +            coresight_disable_link(csdev, parent, child,
> >>>>>>>>> + path);
> >>>>>>>>>                 break;
> >>>>>>>>>             default:
> >>>>>>>>>                 break;
> >>>>>>>>> @@ -588,7 +638,7 @@ int coresight_enable_path(struct list_head
> >>>>>>>>> *path, enum cs_mode mode,
> >>>>>>>>>             case CORESIGHT_DEV_TYPE_LINK:
> >>>>>>>>>                 parent =3D list_prev_entry(nd, link)->csdev;
> >>>>>>>>>                 child =3D list_next_entry(nd, link)->csdev;
> >>>>>>>>> -            ret =3D coresight_enable_link(csdev, parent, child=
);
> >>>>>>>>> +            ret =3D coresight_enable_link(csdev, parent, child=
,
> >>>>>>>>> + path);
> >>>>>>>>>                 if (ret)
> >>>>>>>>>                     goto err;
> >>>>>>>>>                 break;
> >>>>>>>>> @@ -802,7 +852,8 @@ static void coresight_drop_device(struct
> >>>>>>>>> coresight_device *csdev)
> >>>>>>>>>      */
> >>>>>>>>>     static int _coresight_build_path(struct coresight_device *c=
sdev,
> >>>>>>>>>                      struct coresight_device *sink,
> >>>>>>>>> -                 struct list_head *path)
> >>>>>>>>> +                 struct list_head *path,
> >>>>>>>>> +                 struct coresight_device *source)
> >>>>>>>>>     {
> >>>>>>>>>         int i, ret;
> >>>>>>>>>         bool found =3D false;
> >>>>>>>>> @@ -814,7 +865,7 @@ static int _coresight_build_path(struct
> >>>>>>>>> coresight_device *csdev,
> >>>>>>>>>           if (coresight_is_percpu_source(csdev) &&
> >>>>>>>>> coresight_is_percpu_sink(sink) &&
> >>>>>>>>>             sink =3D=3D per_cpu(csdev_sink,
> >>>>>>>>> source_ops(csdev)->cpu_id(csdev))) {
> >>>>>>>>> -        if (_coresight_build_path(sink, sink, path) =3D=3D 0) =
{
> >>>>>>>>> +        if (_coresight_build_path(sink, sink, path, source)
> >>>>>>>>> + =3D=3D 0) {
> >>>>>>>>>                 found =3D true;
> >>>>>>>>>                 goto out;
> >>>>>>>>>             }
> >>>>>>>>> @@ -825,8 +876,12 @@ static int _coresight_build_path(struct
> >>>>>>>>> coresight_device *csdev,
> >>>>>>>>>             struct coresight_device *child_dev;
> >>>>>>>>>               child_dev =3D
> >>>>>>>>> csdev->pdata->out_conns[i]->dest_dev;
> >>>>>>>>> +        if (csdev->pdata->out_conns[i]->source_label &&
> >>>>>>>>> + !strstr(kobject_get_path(&source->dev.kobj, GFP_KERNEL),
> >>>>>>>>> + csdev->pdata->out_conns[i]->source_label))
> >>>>>>>>> +            continue;
> >>>>>>>>>             if (child_dev &&
> >>>>>>>>> -            _coresight_build_path(child_dev, sink, path) =3D=
=3D 0) {
> >>>>>>>>> +            _coresight_build_path(child_dev, sink, path,
> >>>>>>>>> + source)
> >>>>>>>>> =3D=3D 0) {
> >>>>>>>>>                 found =3D true;
> >>>>>>>>>                 break;
> >>>>>>>>>             }
> >>>>>>>>> @@ -871,7 +926,7 @@ struct list_head
> >>>>>>>>> *coresight_build_path(struct coresight_device *source,
> >>>>>>>>>           INIT_LIST_HEAD(path);
> >>>>>>>>>     -    rc =3D _coresight_build_path(source, sink, path);
> >>>>>>>>> +    rc =3D _coresight_build_path(source, sink, path, source);
> >>>>>>>>>         if (rc) {
> >>>>>>>>>             kfree(path);
> >>>>>>>>>             return ERR_PTR(rc); diff --git
> >>>>>>>>> a/drivers/hwtracing/coresight/coresight-platform.c
> >>>>>>>>> b/drivers/hwtracing/coresight/coresight-platform.c
> >>>>>>>>> index 9d550f5697fa..f553fb20966d 100644
> >>>>>>>>> --- a/drivers/hwtracing/coresight/coresight-platform.c
> >>>>>>>>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> >>>>>>>>> @@ -205,6 +205,7 @@ static int
> >>>>>>>>> of_coresight_parse_endpoint(struct
> >>>>>>>>> device *dev,
> >>>>>>>>>         struct fwnode_handle *rdev_fwnode;
> >>>>>>>>>         struct coresight_connection conn =3D {};
> >>>>>>>>>         struct coresight_connection *new_conn;
> >>>>>>>>> +    const char *label;
> >>>>>>>>>           do {
> >>>>>>>>>             /* Parse the local port details */ @@ -243,6
> >>>>>>>>> +244,10 @@ static int of_coresight_parse_endpoint(struct
> >>>>>>>>> device *dev,
> >>>>>>>>>             conn.dest_fwnode =3D fwnode_handle_get(rdev_fwnode)=
;
> >>>>>>>>>             conn.dest_port =3D rendpoint.port;
> >>>>>>>>>     +        conn.source_label =3D NULL;
> >>>>>>>>> +        if (!of_property_read_string(ep, "label", &label))
> >>>>>>>>> +            conn.source_label =3D label;
> >>>>>>>>> +
> >>>>>>>>>             new_conn =3D coresight_add_out_conn(dev, pdata, &co=
nn);
> >>>>>>>>>             if (IS_ERR_VALUE(new_conn)) {
> >>>>>>>>>                 fwnode_handle_put(conn.dest_fwnode);
> >>>>>>>>> diff --git a/include/linux/coresight.h
> >>>>>>>>> b/include/linux/coresight.h index e8b6e388218c..a9c06ef9bbb2
> >>>>>>>>> 100644
> >>>>>>>>> --- a/include/linux/coresight.h
> >>>>>>>>> +++ b/include/linux/coresight.h
> >>>>>>>>> @@ -167,6 +167,7 @@ struct coresight_desc {
> >>>>>>>>>      * struct coresight_connection - representation of a
> >>>>>>>>> single connection
> >>>>>>>>>      * @src_port:    a connection's output port number.
> >>>>>>>>>      * @dest_port:    destination's input port number @src_port=
 is
> >>>>>>>>> connected to.
> >>>>>>>>> + * @source_label: source component's label.
> >>>>>>>>>      * @dest_fwnode: destination component's fwnode handle.
> >>>>>>>>>      * @dest_dev:    a @coresight_device representation of the
> component
> >>>>>>>>>             connected to @src_port. NULL until the device is
> >>>>>>>>> created @@ -195,6 +196,7 @@ struct coresight_desc {
> >>>>>>>>>     struct coresight_connection {
> >>>>>>>>>         int src_port;
> >>>>>>>>>         int dest_port;
> >>>>>>>>> +    const char *source_label;
> >>>>>>>>>         struct fwnode_handle *dest_fwnode;
> >>>>>>>>>         struct coresight_device *dest_dev;
> >>>>>>>>>         struct coresight_sysfs_link *link;
> >>>>>>>>
> >>>>>>
> >>>>
> >>>
> >>>
> >>
> >
> >
>=20
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org To unsubscribe send =
an email to
> coresight-leave@lists.linaro.org

