Return-Path: <linux-kernel+bounces-91645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C5C871499
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDCF1C21B24
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A523D0B5;
	Tue,  5 Mar 2024 04:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=asus.com header.i=@asus.com header.b="tLmby4bq"
Received: from ms.asus.com (ms.asus.com [103.10.4.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDB079F2;
	Tue,  5 Mar 2024 04:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=103.10.4.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709612111; cv=fail; b=OSUVLn1ZgQtij8rAC7UdkprWBiCpPcJ1KBTKOVptyokVftd+raj1woLu3LyhSsm49fHPwMkd2julGrYLTYAGabZvqEGi5JA57TLqATqqYPDaxFI1zZCY3doGsh9hGvIt2W6eT8BxzLlEHcUEu9U2IZWRVgQvcYmOmKwllaGSEIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709612111; c=relaxed/simple;
	bh=Qf5annmUraPfECuX7OpwYuZQa0nfUyWm8vTwK/zrgqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PUb0KKVR2Qf7QX2sCmvHxo0VVKXxfXxTO2g0AaBAqXGo2ot6hYoK/M0HeRqgjkU6aJIs+UHV9Ykhurx85GQbV+fd35hxFuBg29qBEjVAGu00sQagu7f2WE/4osyHWL8KTQUgjagCKx2Uq9RE1EpbCCYdWkTEpkxoBVXZ+9XSnL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asus.com; spf=pass smtp.mailfrom=asus.com; dkim=pass (1024-bit key) header.d=asus.com header.i=@asus.com header.b=tLmby4bq; arc=fail smtp.client-ip=103.10.4.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asus.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=asus.com; i=@asus.com; q=dns/txt; s=asuscom;
  t=1709612109; x=1741148109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qf5annmUraPfECuX7OpwYuZQa0nfUyWm8vTwK/zrgqY=;
  b=tLmby4bqjp4vLyXTmx52UP6baPOH9eMAxnsVzQaNIqzRNQUQTEKo+U9x
   IydkbD1Pai+wQC5eHY7t/Ghz5CDrSZwbxEZGAfouVQFH198IfoGkDvDPP
   VH3XDQBLMelISOwUY6r0mvDqzGZJWLQcvABBtQPo5DIzGmrphqiQfvJEJ
   Q=;
X-IPAS-Result: =?us-ascii?q?A2ErAADVmuZl/w4GFqxaHQEBAQEJARIBBQUBQAmBMggBC?=
 =?us-ascii?q?wGCOHqBYYRViB2JSgOKIYE/kFEqgSwUgV8LDwEBAQEBAQEBAQcBAS4WBAEBh?=
 =?us-ascii?q?QYCFodeJzQJDgECBAEBAQEDAgMBAQEBAQEIAQEBBQEBAQEBAQYEAQEBAoEZh?=
 =?us-ascii?q?S9KglwBg3YBAQEBAwEiEUUMBAIBBgINBAQBAQECAhkNAgICHgcKFQgIAgQBD?=
 =?us-ascii?q?QUIhSQDMZVhmzp6gTIaZ4IWBLAfDYEsgSkJAYEQLgGBaIYfHgGBVoFsgjODQ?=
 =?us-ascii?q?XuCTyZvQoFmgQI+gh+BbwESASMFEBUMAoMhOYIvBIE3XIMSKYMwgSiMTYESh?=
 =?us-ascii?q?C6FbglLfxwDgQUEWg0FFhAeNxEQEw0DCG4dAjE6AwUDBDIKEgwLHwVUA0MGS?=
 =?us-ascii?q?QsDAhoFAwMEgS4FDRoCEBoGDCYDAxJJAhAUAzgDAwYDCjEwVUEMUANkHxYcC?=
 =?us-ascii?q?TwPDBoCGxQNJCMCLD4DCQoQAhYDHRYEMBEJCyYDKgY2AhIMBgYGXSAWCQQlA?=
 =?us-ascii?q?wgEA1QDIHQRAwQaBwsHeIIJgT0EE0YBDQOBNAaKHgyDDwIFIwQmgVsDRB1AA?=
 =?us-ascii?q?wttPTUGDhsFBB8BHXwFojETgSkQEBQucCsVUBEuUI91gkCDP0mtMUpwDYMMg?=
 =?us-ascii?q?QOZNIF9hisXhAWMeoZcA5JJmFsgkVCWYgIEAgQFAg4IgUEjgSZwMz2DN1IZo?=
 =?us-ascii?q?iJ4OwIHAQoBAQMJhkiCJgUvZ18BAQ?=
IronPort-PHdr: A9a23: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
 o3n5+0=
IronPort-Data: A9a23:0aSbwK+FYkob9gmgPbJuDrUDKH+TJUtcMsCJ2f8bNWPcYEJGY0x3m
 2sWC2jSM/jcZ2L1fd1za47j8k5T65XWyNJlQQJp+HgxFiIbosfsO4+Ufxz6V8+wBpSYFRo4t
 a3ySTViwOQcFCK0SsKFb+CJQUFUjP3OHPynYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzBXf8s9JKGjNMg068gE431BjCkGtwlkAzY/lNoGjfmxE9ZH7IDfrpR5dQatA88t+SH
 44v/pnglo/q105F5ueer1rOWhZirog+neS5oiE+t6CK2nCur8Gpu0oxHKJ0hUx/011lkz3to
 TnkWFPZpQoBZ8XxdOohvxZwHz9OFvdt35X7e3nu4fSLz3LqLXHW6qA7ZK02FdVwFudfKFl83
 KRAch09RFaIgPiuxr+nDOB3m99LwMvDZdxF/Cs6i2+fVKpOrZPrGs0m4fd70TM0l/duAPDRT
 8MCdCEpZxPFC/FKEg1OV8tjw7711hETdRVWtFKIhLAvuVLZ0U8g17LIGebpXeOjEJA9ckGw4
 ziuE37CKhIAJs2E2yaC/DSvgf3LmjzgW4M6ELy+/+RtxlqJyQQ7EAUXWlu8vOK0okG7UtNbb
 UcT/0IGt6849A+nUvH+Uge+rXrCuQQTM/JTCf8r8xORzaSS4AGLAm8bVT1AK9A6nMs3QzUw0
 RmOhdyBLTdotrqPCn6B3rSZtzW/PW4SN2BqTS0DQA8t4dz45oA/yBvSJv5qFqKvg8LdEjb8z
 juNqjMinagYkYgA0KD99E2vqz6huJnCQxIv6wj/QG2o9EV6aZSjaoju7kLUhd5ELYCEXhyIp
 n1BmMWE6u0KJZWMjzCWBuQLEqug6/uMPHvbm1EHN50g8Sm9vne4ZY1d7Bl6JVx1KYADazvga
 lSVvhlejLdXPX23fep0bpi3BsAC06ftD5LmW+rSY94IZYJ+HDJr5wk3OhTWhTqrzg51zcnTJ
 KumTCplNl5CYYwP8dZ8b7h1PWMDrszm+V7ueA==
IronPort-HdrOrdr: A9a23:8ReAE69vqOs+2G8DGfluk+GUdr1zdoMgy1knxilNoENuHfBwxv
 rDoB1E73LJYW4qKQsdcdDpAtjjfZquz+8J3WB3B8bpYOCGghriEGgM1/qF/9SNIU3DH6tmpN
 xdmstFeZDN5DpB/L/HCWCDer5KqrfnzEnrv5an854Ed3AsV0gK1XYdNu/vKDwQeOAwP+tcKH
 Pz3LslmxOQPVAsKuirDHgMWObO4/fRkoj9XBIADxk7rCGTkDKB8tfBYlSl9yZbdwkK7aYp8G
 DDnQC8zL6kqeuHxhjV0HKWx4hKmeHm1sBICKW3+4cow3TX+0iVjbZaKv2/VQMO0aKSAZER4Z
 vxSiIbToVOArXqDySISFXWqk3dOX0VmgPfIBej8ATeSIrCNXQH4wAov/MBTvMbg3BQ5O2Vqs
 hwrjikX8E8N2KcoMy4jOK4CS2DUyKP0CEfeSp6tQ0CbWPYAIUh8rD3tXklbqsoDWb07psqH/
 JpC9yZ7PFKcUmCZ3ScpWV3xsewN05DaCtub3JyzvB96QIm60xR3g8d3ogSj30A/JUyR91N4P
 nFKL1hkPVLQtUNZaxwCe8dSY/vY1a9CS7kISaXOxDqBasHM3XCp9r+56g0/vijfNgNwIEpkJ
 rMXVtEvSo5el7oC8eJwJpXmyq9CVmVTHDo0IVT9pJ5srrzSP7iNjCCUkknl4+6r/AWEqTgKo
 OO0VJtco3exEfVaPV0NlfFKuhvwFElIb0ohuo=
X-Talos-CUID: 9a23:XYUrFG/n9dANIJG4xhCVv0IKKut/WVr38C3Rch+AEWZWZOOfc3bFrQ==
X-Talos-MUID: 9a23:Dyg2SQgNr7ac4u31GX4l0cMpOtto/oW0EBo3m4hF6s6OEAVMBxCipWHi
X-IronPort-Anti-Spam-Filtered: true
Received: from unknown (HELO APZA002EXB.corpnet.asus) ([172.22.6.14])
  by ms.asus.com with ESMTP; 05 Mar 2024 12:15:05 +0800
Received: from APZA001EXB.corpnet.asus (172.22.6.13) by
 APZA002EXB.corpnet.asus (172.22.6.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 5 Mar 2024 12:15:04 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (104.47.26.105)
 by APZA001EXB.corpnet.asus (172.22.6.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Tue, 5 Mar 2024 12:15:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4ak3YbaNXhW4mP2ImOzLD8O/FvYPId282ZxNFuxk/+yWAAUcif/+9u7xW0hxlaC1Z8emI6TsmbhTRHnydXOg9QMYswvclIDeeKcBE5Tg4vE4f3Fk8e1s1bwDWi3uyLo+zDBPOylT8OEHKQm8BvNa2KJ6r/WJg6xQ1YkmYTbrxu/RXHZkW+7f5fFT3ivL8Wbf2Erym9BpXkZKHuRqDddzah6jpGd3NuSQTynpCKX7CRzM5S0FhqJ6eE2NJZr9HLaeRJnJzzFBS5ltycsVftBvgh/760FBsxg8AdmmNqLc8k4mqrnjzSPrZp6atTH9Z12oeWSO6iSxmf9CQ/w8bx6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwJIgUxmhRMK+LY4gdszpD9YMo8Kt0pxIT6cZB8JKdQ=;
 b=jIMj+F8S77LWVY/jmbY0bEW5QLkpFTa+636PfQ1rB8bJtFPS+KVbenTOfwC0oNs015eyTOjkOzAQuKFEMI4rtkWN/p9nQJI0THorvz3lnleSU8Ci282GfckJ+KEc7rcHb1zqYU4LpgGeoHfLHfCKb7D5AoaYmbV07kyx/7cUQMY1tjY0JrOyC26Rdv8SwNtz2Vhd6uz1rfN9IwxJOirpH6qaglK0ro6XtpSt1AHPf1TO2RGgmaLrHsBHEvZ+9SppnbCHtT6ColmVIjTCL2UDg+ZLTvuObubAMiZdSErJNqxSJNaFUZKDBq/5dLJmAntWHvq3XkpoGwsUiJLtzKad6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asus.com; dmarc=pass action=none header.from=asus.com;
 dkim=pass header.d=asus.com; arc=none
Received: from TYZPR04MB6596.apcprd04.prod.outlook.com (2603:1096:400:28d::13)
 by TYSPR04MB7190.apcprd04.prod.outlook.com (2603:1096:400:472::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 04:15:02 +0000
Received: from TYZPR04MB6596.apcprd04.prod.outlook.com
 ([fe80::ceae:2258:3883:29e6]) by TYZPR04MB6596.apcprd04.prod.outlook.com
 ([fe80::ceae:2258:3883:29e6%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 04:15:02 +0000
From: =?utf-8?B?S2VsbHkgSHVuZyjmtKrlmInojokp?= <Kelly_Hung@asus.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Kelly Hung
	<ppighouse@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
CC: "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?QWxsZW5ZWSBIc3Uo6Kix5bm85bKzKQ==?=
	<AllenYY_Hsu@asus.com>
Subject: RE: [PATCH] ARM: dts: aspeed: asus: Add ASUS X4TF BMC
Thread-Topic: [PATCH] ARM: dts: aspeed: asus: Add ASUS X4TF BMC
Thread-Index: AQHaU1pVz0U1vnDOQESBbDEICKEggLDyKU8AgDaUrrA=
Date: Tue, 5 Mar 2024 04:15:02 +0000
Message-ID: <TYZPR04MB659609383D503E6DD3AEA3D29D222@TYZPR04MB6596.apcprd04.prod.outlook.com>
References: <20240130085652.198010-1-Kelly_Hung@asus.com>
 <57419138-9c80-46c3-9341-b55576a3f7d2@linaro.org>
In-Reply-To: <57419138-9c80-46c3-9341-b55576a3f7d2@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asus.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB6596:EE_|TYSPR04MB7190:EE_
x-ms-office365-filtering-correlation-id: 5177b80a-304d-48f7-3c2b-08dc3ccad47b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0fpRYNkT4aQRpaE6zlqIGhWZfm6is5X8vD014g+pFH3bUut2WFLPqLwjwgpk1dLdK2SEz1VgKwojVWgM8gRATQIJAhZKrf9abNZMB2ByfPCrQ89h2sDu/Nad4PzA4ZJMLG0WokB0ZuacmLut3FwluFtEFyq+DPxRerbRmHGwsSLaZ68dolr7Gr1YOq92tt+25mDn2F2DHIHa2tfbgp9kDjhh8NbTSG50sWJ3L/TTLjZjpPAzD5IvrOHcHpcYeCnPPBebZsvt7BritJh5xbpVL/sfTzRg2mdaT7CO8ZVFHrMhah+3aI9boY5opE/sTpBbcIzKlCxYnN7Al1YmR/qi1cd8pwnep9ZQTvhADq/aIl4g1hzpYNlzm8/U1PK6G8wDK6nEqzwbIKZWhjeENUfgY0lnFuNSqkQs/UJZ5J3vdLJH4dQbbNG9S9JZ6Xk753jNd4/EBTPPZRoph/qxtn9iWdMZ7il9qDXwTetDV/3Za736oWNU4zHQa6Dmu3b1+LqQrD2q4o16O0Qf5+bn4G2cr4gqxXIu2+DizwOCHFLPiUDGan4Ibi8TYRFLXhLFfNeyyhLbxXPfWy+xutLWJYC1Y+KmD20eVOCWluZJsR8kb0Oz58agGaTUfvZesWf/G4PnYG1a006tt+xHV+Wy6ZHTkzg3x9bKaTM5sbKD7YELdO08rOL/B5fYn5UE+Vs3bxGO9Bxnae38Yekh+CbjAkJbK4b87ikFQTwrK/owHDb+MQM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB6596.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R04vZVhKOURkZnhvRS81WC9LT1lmVFNGeDdQOUd4NjI4bkw0NHkva3VnU2hY?=
 =?utf-8?B?VUVPcndFZW1IVFZpbDUvT2JLVFVub1ZrbHN1NU5hd1l1M3ZoS3IrN0dGUVUw?=
 =?utf-8?B?WTBCeGdHUkdyOWFRWlVOWFhZeVRTVW5udCtPMTU5RjBvYWRDRjhvU0FoalZs?=
 =?utf-8?B?TE14ZWJXRzFjS1RybTlPOUE5KzI1bXpmY3d5UFFPaVBVVUlSTFdFdUxJT2pC?=
 =?utf-8?B?ZlZDbW9ic09xd2M0QVR4VnA4VUdWZGRsS2RqSFE5bjMycXBMaEpwL0haR005?=
 =?utf-8?B?K1kzOXZOejRvVkdydlQ0NkRSdERoeG5ncUxFNzUxbytpd29YSnBnamU0ZTk5?=
 =?utf-8?B?Uy9HWm80REsrTjVGcTREOTExMTFESzU1ZXY1YnNGL3JETXJ2K3JWM0M4UVI3?=
 =?utf-8?B?QjA0VmxRL0lqT2tZVHdHUGdTME9tbG0xeTNaa21IWlpDU25OWXBtOE9GRTJ2?=
 =?utf-8?B?ai9YNVlyc0VIekpQeE9YUTRmNk1OQUNKb2lGWFZHSUo0N1J3bmtxQXN0VmJr?=
 =?utf-8?B?UkV0SXRxRFFCUHNpL0dKT3lXOUFha09IOXVLSGhpUmVtNTlxMUlxY21uUHNq?=
 =?utf-8?B?RkRySkJPMWNJTjV3bjdTcWI2K0I5OC9naGZHVVI4blREbGhkOVVmc0dxN2hy?=
 =?utf-8?B?K2pOM1drd0tYeFdMMDVOT09xejdhMWk5M01PR3BkRGtTWlIyc0VVVEZ2VElB?=
 =?utf-8?B?U011ZlZBT1g0cmtMaFlsMzR6eTdMK3I2SUxvV2pzcEVqNjRpR0RKZCsyQXU3?=
 =?utf-8?B?dmZqUmpqaUJMYkY1TWx2a1NGSXJEVUl4VjFOM05NNC9hSjIweEdBd3lac0pD?=
 =?utf-8?B?OVJ5ZzVST3pnUU5objB4bUJkVXRxbkJiVEhDSENZbndpa1E3ZzBITS82K3Qr?=
 =?utf-8?B?RkVBRjBWazIxUEwvNzJKcERmYm0xWHd3ajVOVVRWMDNzMmtNYnU2V05TdXNu?=
 =?utf-8?B?MjZjV0UyNk9uTDRPd1k5S1VWNWhyVXRzdE1MdUpzOGgyamErVngyaExnQXUr?=
 =?utf-8?B?bll1TmRoa2JhRU5TYnVQSDR1MFpzckkyVTQrbnEvTWdwVTNKNG1PRFg5SmY2?=
 =?utf-8?B?ZG5qQWVuTjFmTGVwM3dJQzVqTWdHL2JMZDFZNWRPNDhRb3REM3VxNHNITjJO?=
 =?utf-8?B?UzBnNFF4TVgvck1MdFJvMWFTRU13c1dOOVFpTk5pdEh6cWtTMkF6ZE1HWkF2?=
 =?utf-8?B?MEVVSW01eW9sWCt2cld3MlF3K0psNGh4aGRvaElhQlFVYzFuQlA1N2p5RUY2?=
 =?utf-8?B?UjRLaURVQldETHNvZllrSmxNNDZQU0FydU9OQjkzbXgyU0RKWkRYOTExakVU?=
 =?utf-8?B?K3FJY1RadEZybWs4ODN5d0gySUpHUHp4Z2JoUGwxWm5hR3JOWHpRd1ZWbnp2?=
 =?utf-8?B?d0ZvMUdwejRYZFZ3MUd5SGJkQ3gyNlJSN3lrQ3dkVHhjNlVrbGtoVWNBK2Qy?=
 =?utf-8?B?WWNUcjIzTUJTYXVMYkpHWHpZcUQzb2U1WjBnN3NBVGtuQy8xc3dMUUFIVnhv?=
 =?utf-8?B?ZnlkSkRNM2J4RnlicnBFbzZrakNTMDNSc3ZuTGlBTXBmeXFsU3RZa3lsSmRa?=
 =?utf-8?B?U1h1WXNCak1lR1U4ZHpIYzlJY3ZzOUN2MjhHZVRlczFpMjZJNHliNXlSY01v?=
 =?utf-8?B?YU5YUkVyYzJYZFJNS0NJUVppTzdMbGR2aEc2ODNocmt5ZHpralp5NjVqY2sz?=
 =?utf-8?B?WTBvNDNiTzNPQy9tcDF6TnQ4NzRvTlkvRDJJbnBEVEdjQ01tRmcvMms3LzFl?=
 =?utf-8?B?MTRUcm5lUUlXa3hiMmhtcnVxSmNoR01KZHY4NDl1Sk13RUxZMTdPVGN0bTJQ?=
 =?utf-8?B?MVdDTEJEbHhyU0d6V0thbDByMlVBOVNjKzNyM3ZwbHFKSy9YQWpFS2k0MXBx?=
 =?utf-8?B?SGluUjdYYTU1QlhYdDdObEFja2VMZ2gzRm80NndZcUpnSHdsN2p3czk3bzZ4?=
 =?utf-8?B?SlpNYjdtKzRma2pkOElwUCtJbTNCRWcwTDlGZWRMYnYwNWJySHhLUno3WHM4?=
 =?utf-8?B?Zi9Wd0krSjdsRzZ1NE51ZDNDd3Z5R1A5RWFicHlMcnFFOUszVlZKakZjZDZW?=
 =?utf-8?B?QkMyOTd1Qk5rYk84WGtoSEtHZzFNS0p4QVlsamRxU3J4RGlJV1RwT091V2Er?=
 =?utf-8?Q?07gMSSKt72cmyENmNN03UWN7t?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB6596.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5177b80a-304d-48f7-3c2b-08dc3ccad47b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 04:15:02.5405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 301f59c4-c269-4a66-8a8c-f5daab211fa3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5P8jbKcHFGjNrc4GhwrqEbYuBOd3rYl5peVWoK9e48NZtnnKb6tuqNLgZSH8iRnkhuSo7325qu7jwzjRVO3Bxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7190
X-OriginatorOrg: ASUS.com
X-TM-AS-Product-Ver: SMEX-14.0.0.3197-9.1.2019-28232.001
X-TM-AS-Result: No-10--19.255100-8.000000
X-TMASE-MatchedRID: scwq2vQP8OH5ETspAEX/npGPSO6O5JCa1G4YyZIIIrNCSStXJecWpp0Q
	FAkvwQa1sH7Odm1h3hhDqCDV3QmKJzVxLV/TD3CF+ihdEtc5LWe0QsaeKO+kUivC8vN7zcoCnSI
	CScvpD9lEFj6d8eMMtk1c2rf/UW4THBCHExSex5xpHZaVkrZX0l3cOT1qj4Q/W8QNufYAF0wC+L
	R0UYLJq3rXd53wcg59jX3M0aFmhUO4YW3IPBlDmpoCUGxv+/Hoo2sqUJr6IXBxg7svMtapLg7Ht
	RZkYKSFlExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.255100-8.000000
X-TMASE-Version: SMEX-14.0.0.3197-9.1.2019-28232.001
X-TM-SNTS-SMTP:
	1A56363CB5B2A34FBC5788C8A72C3593159C4E8E1077C24EF8CBFA19B67CF09B2000:8

SGksIEtyenlzenRvZiwNClRoYW5rcyBmb3IgcmVtaW5kaW5nLiBJJ3ZlIGZpbmlzaGVkIGFuZCBj
b3JyZWN0ZWQgbXkgdGhlbWUgcHJlZml4Lg0KDQpCZXN0IFJlZ2FyZHMNCktlbGx5DQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9m
Lmtvemxvd3NraUBsaW5hcm8ub3JnPg0KU2VudDogVHVlc2RheSwgSmFudWFyeSAzMCwgMjAyNCA2
OjM1IFBNDQpUbzogS2VsbHkgSHVuZyA8cHBpZ2hvdXNlQGdtYWlsLmNvbT47IHJvYmgrZHRAa2Vy
bmVsLm9yZw0KQ2M6IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgY29ub3IrZHRA
a2VybmVsLm9yZzsgam9lbEBqbXMuaWQuYXU7IGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdTsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IEtlbGx5IEh1bmco5rSq5ZiJ6I6JKSA8S2VsbHlfSHVuZ0Bhc3VzLmNvbT4N
ClN1YmplY3Q6IFJlOiBbUEFUQ0hdIEFSTTogZHRzOiBhc3BlZWQ6IGFzdXM6IEFkZCBBU1VTIFg0
VEYgQk1DDQoNCkV4dGVybmFsIGVtYWlsIDogRW5zdXJlIHlvdXIgZW1haWwgaXMgc2VjdXJlIGJl
Zm9yZSBvcGVuaW5nIGxpbmtzIGFuZCBhdHRhY2htZW50cy4NCg0KT24gMzAvMDEvMjAyNCAwOTo1
NiwgS2VsbHkgSHVuZyB3cm90ZToNCj4gVGhpcyBpbml0aWFsIGRldmljZS10cmVlIHByb3ZpZGVz
IHRoZSBuZWNlc3NhcnkgY29uZmlndXJhdGlvbiBmb3INCj4gYmFzaWMgQk1DIGZ1bmN0aW9uYWxp
dHkgYW5kIHdvcmsgb24gQVNVUyBYNFRGIHByb2R1Y3Rpb24uDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IEtlbGx5IEh1bmcgPEtlbGx5X0h1bmdAYXN1cy5jb20+DQoNClBsZWFzZSB1c2Ugc3ViamVjdCBw
cmVmaXhlcyBtYXRjaGluZyB0aGUgc3Vic3lzdGVtLiBZb3UgY2FuIGdldCB0aGVtIGZvciBleGFt
cGxlIHdpdGggYGdpdCBsb2cgLS1vbmVsaW5lIC0tIERJUkVDVE9SWV9PUl9GSUxFYCBvbiB0aGUg
ZGlyZWN0b3J5IHlvdXIgcGF0Y2ggaXMgdG91Y2hpbmcuDQoNCkJlc3QgcmVnYXJkcywNCktyenlz
enRvZg0KDQoNCjxwPjwvcD4NCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpUaGlzIGVtYWlsIGFuZCBhbnkg
YXR0YWNobWVudHMgdG8gaXQgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gYW5kIGFy
ZSBpbnRlbmRlZCBzb2xlbHkgZm9yIHRoZSB1c2Ugb2YgdGhlIGluZGl2aWR1YWwgdG8gd2hvbSBp
dCBpcyBhZGRyZXNzZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQgb3Ig
cmVjZWl2ZSBpdCBhY2NpZGVudGFsbHksIHBsZWFzZSBpbW1lZGlhdGVseSBub3RpZnkgdGhlIHNl
bmRlciBieSBlLW1haWwgYW5kIGRlbGV0ZSB0aGUgbWVzc2FnZSBhbmQgYW55IGF0dGFjaG1lbnRz
IGZyb20geW91ciBjb21wdXRlciBzeXN0ZW0sIGFuZCBkZXN0cm95IGFsbCBoYXJkIGNvcGllcy4g
UGxlYXNlIGJlIGFkdmlzZWQgdGhhdCBhbnkgdW5hdXRob3JpemVkIGRpc2Nsb3N1cmUsIGNvcHlp
bmcsIGRpc3RyaWJ1dGlvbiBvciBhbnkgYWN0aW9uIHRha2VuIG9yIG9taXR0ZWQgaW4gcmVsaWFu
Y2Ugb24gdGhpcywgaXMgaWxsZWdhbCBhbmQgcHJvaGliaXRlZC4gQW55IHZpZXdzIG9yIG9waW5p
b25zIGV4cHJlc3NlZCBhcmUgc29sZWx5IHRob3NlIG9mIHRoZSBhdXRob3IgYW5kIGRvIG5vdCBy
ZXByZXNlbnQgdGhvc2Ugb2YgQVNVU1RlSy4NCg0KRm9yIHByaWNpbmcgaW5mb3JtYXRpb24sIEFT
VVMgaXMgb25seSBlbnRpdGxlZCB0byBzZXQgYSByZWNvbW1lbmRhdGlvbiByZXNhbGUgcHJpY2Uu
IEFsbCBjdXN0b21lcnMgYXJlIGZyZWUgdG8gc2V0IHRoZWlyIG93biBwcmljZSBhcyB0aGV5IHdp
c2guDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0K

