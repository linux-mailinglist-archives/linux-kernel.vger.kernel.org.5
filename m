Return-Path: <linux-kernel+bounces-157798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 325338B165D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5662C1C239E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D5E16EBEF;
	Wed, 24 Apr 2024 22:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Hpe3g5lW";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Za0mMzLO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QCeXp8J3"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D0216E871;
	Wed, 24 Apr 2024 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998637; cv=fail; b=tW9p8H9wcZCsFtjOkTTNz9954N+9RJN7XFePt5Y/B9hZZDoaRdMxGlO0GOTARq2+5j3wSLTzTeJOohsQqDZdTPPTDoZdn/xHFGYecetK5IYo3D9GBLiKttf7wT44Ajnzvhl8Wbk4Pl88l93CaXCRD68l87tqV9TZj99CpyKuC7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998637; c=relaxed/simple;
	bh=s+jtfB5NmanIKWGduXqvYr3AxiUtblS9q9moROSc2tQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hTx4x1mruIwCCux4gg38Xhtbgx/myr+7ggYwG5lGu/uevrHX/b2G4DfOkCURn+Rr1xK6vzhPlSivGcO/tpM7jbnUOmtkFup0C9XBF9dVoltrljHYpaUfBR09cronEs4HhFqOhsrn3TKhC/kUFeSKUa25S38iUAz+TfiSyxoF68I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Hpe3g5lW; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Za0mMzLO; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=QCeXp8J3 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OKF3DF018930;
	Wed, 24 Apr 2024 15:43:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=s+jtfB5NmanIKWGduXqvYr3AxiUtblS9q9moROSc2tQ=; b=
	Hpe3g5lWD7d2weWjBUlVgzHJjriO5d7G8nRDCwxtF57aCiM++U4WMnAv6I7p9K78
	rF1gqf39CPAq+RBqGDpcuF26s8XNACQYoHfqZjgMWhTG2+dWZWlqdyW3ANgms4vk
	zQ1SKXl1dU0AvzhAUlEkGabKPCHXqCgIl8yfA9IiGEvpTCULQ6/Pwxx6EoQd1sMj
	r3F3zUHNMsUt0FgJ70H5rlGuLQPTYttX+qxGekBYEc5DzMu721waeHarAZ1+xSdp
	K7Cu1pMoVGaLJNLMZ6HD8LhkOi5C+IeaRdEBZOknmUrkAH2oSIlZOxFBMFY4U7B1
	CfD2V1OeFUHVdYu8s6dIpQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xpf6yexdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 15:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713998617; bh=s+jtfB5NmanIKWGduXqvYr3AxiUtblS9q9moROSc2tQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Za0mMzLOEciE40UskdpgevfWYdCRtwIp6cs81nM/fFgpvV7K9J1hB2D0fTeM5jiHl
	 HtbfUvkxbzhUtal3F6s7hY58qZzi8wjpRzMH6JF5nE42Hk844VMlsO06syQ6aR1OL6
	 uoX0QCCYaJEOZOkvsH7SIV+2bQ3CcXSa7gCpNwQjd30t/hF0MyW/Gr9cpsL18MaJnR
	 83QIqhN0JePLQrSlDjQPkBjfnTT0FEKbHVJ8YDkGx14/dxFqcMNOQlofF7C+c6tMDn
	 Tufr2iFZ/5CD1LWJCHpJGQjjmu4xbs8geUztnMZODWHSvajQHOBihk1rdtCVSSRwNI
	 Pk31q/IiWvELg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BFDBE4044C;
	Wed, 24 Apr 2024 22:43:35 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 3FFBCA00A9;
	Wed, 24 Apr 2024 22:43:34 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=QCeXp8J3;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 86C8540354;
	Wed, 24 Apr 2024 22:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fpttf6d5k7EseKlkGzfu5gRbd6hQeoeqWAO8slXPpFtehI6VKS7kTD6/pd8vPqAxAxp5FB4XXue273e3Qg2intlrUOa+z0WqMehWTdtCAk4P94YEY/+vfWxhOMASr8nRu83ay1KQLZ6YBTvKof6akv0In5yAAgm6xVOEuH+JoyQc/A5BgqN2nSQWPLbzx0rHks0TsESxDx+uCeyA27FzqcxlViiZw7EjOu9WIJX1bCyur38HCFnithpgppojvzTo3TzxcMvwxf4dPAkDKiTeJV8/+dUw9eUsIhUugdcYUB8jaQzdAxgwhq65+wV7LQ96V9iSP97ya6gA4+To3e2kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+jtfB5NmanIKWGduXqvYr3AxiUtblS9q9moROSc2tQ=;
 b=gsyIXOgesAbWLGAr3kg66qmXaL1Ht5eaZEFMCtXRZ86g5ge4pi+7tLFPJ2mKr/dJL2O0d32GpJBHy/YqOyOfsAtSQ011sua069Aa6ARaNuxftc8v2Jqb1tJVoxOIaZ1urLI9esOuOk8i4YKQbxLEJoOAqIDAYMbu8aMydPhScwTmvx3Y55bnKlRD0CTEmVcuggBmIVYjCuNlnWEpj8wY6+T8V4m/Kam10NkylD5ZqvP0/Mv+SshRmhrFMb65YLBzeSUlpL7G4Ss8MkZRiBW0W+Lbj/BVmDTknes5FQy15kSU6cmeV5iTJUucT1T4CTeYGd9/i/p5+eckW8J+fJZuAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+jtfB5NmanIKWGduXqvYr3AxiUtblS9q9moROSc2tQ=;
 b=QCeXp8J3C/RneXQhBfU6q7yd23CXQpWpUeNIjZ7UoygQr8M60VztD3n9zmeprIJDwFMN56IAfwrtEIusUQ3TVUCt/MnxFH4gGxXq5cR7wvqvTU6AF/grlLmQAG1tFkzBVxG1qcNMeBKPNFstnMgj2iBXlh1z38rZFdN76sJssUQ=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Wed, 24 Apr
 2024 22:43:28 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 22:43:28 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: =?utf-8?B?QW5kcsOpIERyYXN6aWs=?= <andre.draszik@linaro.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Peter Griffin <peter.griffin@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: dwc3: exynos: add support for Google Tensor
 gs101
Thread-Topic: [PATCH 2/2] usb: dwc3: exynos: add support for Google Tensor
 gs101
Thread-Index: AQHalbud9BYQQYvn80miB5x9y3+By7F4BiiA
Date: Wed, 24 Apr 2024 22:43:28 +0000
Message-ID: <20240424224323.ljlsp566qtuyogmx@synopsys.com>
References: <20240423-usb-dwc3-gs101-v1-0-2f331f88203f@linaro.org>
 <20240423-usb-dwc3-gs101-v1-2-2f331f88203f@linaro.org>
In-Reply-To: <20240423-usb-dwc3-gs101-v1-2-2f331f88203f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|BL3PR12MB6380:EE_
x-ms-office365-filtering-correlation-id: 2e4762b1-88f3-4e26-b28a-08dc64aff5c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|366007|7416005|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?eFFyZmZVajIrY01DODhhLzg1ekd5emE4SVc4cDM0QUp2SSt4Rks2U05xS1li?=
 =?utf-8?B?cXVZVmxMV1hEdGo2QW9WOTBoOXA2Nk9wWElDaEdWT2h4SXExdzZBUDZGTS9m?=
 =?utf-8?B?ZThvR0RLSUxicUE0SnJJVFYvT2U5cjJSa0Zod01SL3pxbkg4UlpiR2VqTkJC?=
 =?utf-8?B?blMrZ1pyZHNJTDlFbW80ZVhlbFo0TENpZzR3aE9hR2JvTmJ3c3kwTmlOb2dz?=
 =?utf-8?B?alRFODJKQ1hicHJVdXBEVFR4SXEwVlBPYVJLL3pMVFR2ZFc2cjU1YlBkUnFX?=
 =?utf-8?B?Rm56YkdZa2UrOGFKM1FFdjRydUpmd0kraVZHcFc5NldPRHl1dnZyWnVHNmxH?=
 =?utf-8?B?am1EaklpWFlrdjd1UE1XWTFLRDFnTmkzSUJCNXBpRXVKWmpVYzRIZEVscXFm?=
 =?utf-8?B?UVA1UnFGUWw3dmxyNjJhSFRwczB3ajJiSGcyMHNiUmYxOHRKMEYxbXlZU2Vs?=
 =?utf-8?B?Yy9vZ3ZxUVFaNmd0N3dNc01JdXVveHE1SkxTU1hiclN4blFOa3JMMnhhYXVu?=
 =?utf-8?B?cEg0SGFmVHNWa3ZlY3JsRk9Qa1h6RWY2OFRvUWVUZXl4Yk4zNTVmbDZuSVZt?=
 =?utf-8?B?UFQvM21qaWZjaUt1c1hNNldkcnN5UGVxZFVYODVBZXBLWTBmK0NpdlVCOTNj?=
 =?utf-8?B?S216KzZQZlJncTFXc1pUUktGSlRoWHpaZ0RYVys4b0RaVDRZT3FyOXBhRFJE?=
 =?utf-8?B?WGh4Q2loRnhMcWNrOEczSDU5TEZvY1pWajZPcE12ZnpTQTRZUlBjYmhQR3pp?=
 =?utf-8?B?Tjl1LzVnZkFuWmlNeTZvSkV2K2orVkFkdU9SZlowRXFjL3lFcFFYeU1yb08w?=
 =?utf-8?B?ak5tZ0VXV1I3OWYzT1F2b0pBSHEreWtqUjhmcUxUUXVUeXVMY3RtU1BpL2Mx?=
 =?utf-8?B?UVRFaDRLYkZ4WUQwMys4SjAvdVcxZTFjZFB4WFJvK2xmOTliVXZLQkNnUVcx?=
 =?utf-8?B?eDI5Z1dnYnFXZHZiaWtkUlVNMTQ0QXhDczBnNnVldWlNQjZrMGFGZFdrSk44?=
 =?utf-8?B?VEpBcnA5cUlaRWhIQWsvMXVvOEtMdS9QU2tYcmlzMXJpcGxjUnNXczRMQ1hp?=
 =?utf-8?B?NWp2aEhuVFkwTHBFSFp1dTM5Q2NVY3pqY3I2YjN6K2lMbWFtNXhHUGdJME5r?=
 =?utf-8?B?UVpYcW9aaGJqQlFvMDNLallTZjBFV3BSeU1UeGJ0TS9IdjNScXpZeGhlRDJ5?=
 =?utf-8?B?bXZNd08wcFVwYXdZMzdiMHJCakpTaWxlRmZVZ2xUN2NhMnJaZFVaTFcxb0pM?=
 =?utf-8?B?N1d2TUVQTGpGak55cU1RdHF6bWx3T1hLRkJ5M21OcVFJY0xoazNzVitLbnhm?=
 =?utf-8?B?NkxZWStkcVExdEQyN3N0R01YV0psZFVRNlJ0TUswUHlpSFdOSUhGRUJMaU5E?=
 =?utf-8?B?d3oxbTN0YnJ2REFPNUVIUGF0TkdhMjlKZTVoZmVlQmc5MVJtOEtIR0dZT1M3?=
 =?utf-8?B?Tjd5WVk5UktYQmpsanVoMjZmdkR6WVplMTBjQWg4V1ZsSUNzSDUzY1FBajNM?=
 =?utf-8?B?MkhtMEdIM1VRYU1NVkczWjBpcXNDenpsdnBsVDFGVEtIcWhibG5iMitmS1c1?=
 =?utf-8?B?NmlUbzY2b09nc1NtUGk4OVY0YTN4NVpiTXpMK3lkSi8wQ3ArYk50MzliM2du?=
 =?utf-8?B?d1JLR1R3am1LSkdmOWdldjdnRXh2NkJaWVk2MFEwMVdrTFFWVmMzZG5Rc2g4?=
 =?utf-8?B?eFpsY0pwejRHT2tYNEVSZHR6R0d5ZGxUUnA0MlpHUjJtaUt5bFdydWx3ZGVX?=
 =?utf-8?B?YUh6YzJKY1VwQy9CZWdTWUNIczJqRmlxaXJSU21XUDV4UlFreEpselppZUZV?=
 =?utf-8?B?NG1qL1lUNmhiUjJNdGlhUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QkhudkQrTkN5YjcvWjNZd3NzMEZGV1NzNUdzaGMwM3gvaC9UblBiTWIzMHhT?=
 =?utf-8?B?cjQyMGNiMHg3SXQ2Z3pEWVlYSE0rcWxUK01LY054SUcrcFVMS0RaVWVjV0dK?=
 =?utf-8?B?U2RjUzNPODV3QWVjQkp1alJIYU1ldmdGMWRuYVZwR0hQamtFVVdGVm9CaVIw?=
 =?utf-8?B?OGNTRDhVOC90OHNGU0ZVeWlNOVdUVkJneVp5Ry9jU3VpUno4Y1RUN2xJV3pO?=
 =?utf-8?B?OVJidHNlVjcwYWZmLzNncm5POWI4cHcxZFJVS3lOVzhHMUNsN21QRy92dW1U?=
 =?utf-8?B?a3d3ZVVMcVJaVGhqNzdsa3FqejlZdytxd1pBNmtrQkV2ZUtqbnJLQmkyUmR3?=
 =?utf-8?B?N0tVb01qcDk2c0E5NTd6SWpFS3Q5eUFodXlKWjBGYW9aM012SWh6Z1BTZUZH?=
 =?utf-8?B?TmFhQTlZcnpnbXhkOEdXTHlWNjlzL1NXSFcyUzhQTWpwUFJvYnhZWmNBay83?=
 =?utf-8?B?bGN4eXd6dE5mb1p2Y04vR3pEMk4rVzI5ZkplZDgzUCt2RXpkcVRVTWVNRVh5?=
 =?utf-8?B?bVlJZWRLU0ZSbEIzWjJzU1JUTFp2L1JkSWxDd0xNT21aQXpjSFFmZ2prOEdk?=
 =?utf-8?B?WVJPYTVNU1V1VUREdlUwMXdVUlpGa2syYk4vNG9lVkZqQ1diL29hcjZrTlR2?=
 =?utf-8?B?RlgxcnlPTWZqMk5ycU1RcXRXOTB3dDBkOXhJT2NlMHJhdFRpaDZMRjlRQTZN?=
 =?utf-8?B?YmwyRzh4c2krK0dma1BlS2lYQkRCaTd1ZVpIWmd4VmQ0d3k5SnNMaktsLzJW?=
 =?utf-8?B?NUhSaVlqeUtkeE8vampna1JOMU5vNjdVUmNQM2JORjFLSlMvb0dWcTY1eXI5?=
 =?utf-8?B?cDdsR3dlYWIwUm9WOEFnNU54a2dNOUlKL3pkWkZDYmNzdjBYeVpib0lWcUV6?=
 =?utf-8?B?bkhyMDFnTnRpZEw5M0w2ZVZKd0NLUzdrUzhLWk9YY3IyZ2RtdCsrZXRadXFa?=
 =?utf-8?B?WDZ1UExLc1BYR2ZSTjVDcFd4cG0rbkY3cWpGMUVFTzQ5YVdzUlorZUpEYUl6?=
 =?utf-8?B?eFo2dGQwVUZTSTJFZExSNEplMm00eUJJdFpueTVkMXFXWU90QWQ0UlIxWEk2?=
 =?utf-8?B?QjRxeDdOcUh2enJOeUI0bE9PL0VBbDJYR1pFN2RRSU4waDh4MmtxeEZUbmMz?=
 =?utf-8?B?RE9UQVVkWTZlUGo0WEh0TmZWNGorMzBVWUVQby9vU05FZWhtYkdnMDBraGM3?=
 =?utf-8?B?RFp5SEtuOG5rU1V6clpJTFZ6ZGNEb2F2Yk51b3ZNTCtrZEVoRmhicE1oQjVr?=
 =?utf-8?B?bXFNVS9FaWVjdkZJbldMZWhqaVZ3Ym5RR3l3cDZPVU1WOCtZK3p0TnNScjQw?=
 =?utf-8?B?UlgxVUJPYTFHUVZiTXpnMXo3MnA5d3lJdjdjblhhNDV4aXJvU0h3K0MwQyt0?=
 =?utf-8?B?WWw2UjBiVDIvN2Rxck5lTzJGaVBiUUlxbE1TelFGSkYrbFJIUDUwQjlITE9k?=
 =?utf-8?B?ODFFVWRkTWNVY0c3cnRoRXZibFJqRUJNZ0xWRnUyUDhaN1k3K1ZwTXNmSUdL?=
 =?utf-8?B?TEVtOTRXTmQzd2xvVHgzcmhESW12VDVSVTlSTVJTYnRSRWtrZnA5Kzlqd1Rq?=
 =?utf-8?B?NG0zNVFiQkJNZ1ZoQ21nTmJUTzdLWndhemxhdy9BZUovQXlOQVJDb1NpcXdn?=
 =?utf-8?B?OWlCcUxBWlFEOUlMOVBILzkydVFXdStDWmtOWktJVkwvTGpPOGllNXphQ2Q0?=
 =?utf-8?B?N3NRZE9WektLbXlEb2RaRTJNVWNtMlJaWm9SZWNjVTluSll3MUZHUUxzWkJT?=
 =?utf-8?B?cm8xM1l2aUdiNUR0bDdMMTUycURvMDRad09sQkpXcC95blRid3pwVTJWOUlV?=
 =?utf-8?B?VE8rbnhFejRmRnUyQWg5U2NqTDlEY1RBRENUNGwwK2VWb0M2dG1SRmI5VEM3?=
 =?utf-8?B?WVlmRlE5SStMTFF2QnZzVUJCWHgxcmhjYWxxYWdBQ2NFQTIvcklndlk4dklH?=
 =?utf-8?B?TERSL0ZmNDR0RThtTy9SeWEvY0piM3hXZ3JxOENyMGhUM1VCYktHbVZwRlhQ?=
 =?utf-8?B?NWRWVUQ5cHdxV2E2TnJpOHd3WUtVd3Brc2NHcUhjblpDSXBnQVlzdEJSam9Z?=
 =?utf-8?B?VXZMNFZIeGZRM1B3QVh5Umt0eXd5NkREdCt2bnZYNHlDbnEyc1ZzUjQxaWJN?=
 =?utf-8?B?UWFvaUk4UklIWDU4Rk9GMDExVVFqU1BVS2tZc3Zta2RZd1pJUTlPZUtNQUtG?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <024E3876C2A7254BBF1D619381E25F6B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YfzAqdzqJ+kemNweu2HmVWLkKmenQOwlIYDJmcBjwVCz5RU0xgSTEWcopsBnpK4fh77t+vD/PmUOdHZdhVP41ehsP6e08gOxFwtmhJYgsyzdWNg3u3EOToepO9YjGQtdodXzBog003BFIyaO5TUM12jVQDVsF5pSQxrzvg9VE2XVI9ZGAKgRStRKaPsIXkWhkieEjoQh2/zemNN2HYOpDbxUT83zbbG9cVYJWC/B+1NtIY9FiCYg7e/fuJUXeyWYpZ5mFbxTmT9OuEohyGvUsc7BBHDekA+u7eIuIb+MjW9t1jdaActE8Siog29YQU/YlEowPnG1przsuetoL+xcRiRTvcjLOI5eVGpC82iUMN3yKLeCs3Q3xOHY0lQWILPdROkZ6ISmYO2EXvy8yZjxffOKvP5TztrpJB0WC6YimGGywD1f1FwaMD/DilG+8zdsLOf/pjOkvUvacsp4kQFW+A50LqcNb0olt0s+FCkgeAnRzVUla+es56c1lOJmlcGSZrvjQBHCY8ATeCYYp4CbVhdtncwuDED5rdGl4lzexQxQLAF7q1+uh1JGuovXAXcga8RpSbQdovz0n4vf+y35Hff44Rbti+dPNJBGGFhjlbEh3N8fyWtT5kTfl7Yalwzh85DuALD2yg202ZG9WzSwdg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4762b1-88f3-4e26-b28a-08dc64aff5c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 22:43:28.4769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5McDS4eF6J13WAazl0+LNDXKndC3xUtcZuTP+8q+ekyAvOj+va1F3DsQbznluS0FADOZnuD2DSLOy9y/wI11CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380
X-Proofpoint-GUID: t9leDAmvTpejen-cP_UAyhtjjgUF_RRv
X-Proofpoint-ORIG-GUID: t9leDAmvTpejen-cP_UAyhtjjgUF_RRv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240117

T24gVHVlLCBBcHIgMjMsIDIwMjQsIEFuZHLDqSBEcmFzemlrIHdyb3RlOg0KPiBUaGUgRXh5bm9z
LWJhc2VkIEdvb2dsZSBUZW5zb3IgZ3MxMDEgU29DIGhhcyBhIERXQzMgY29tcGF0aWJsZSBVU0IN
Cj4gY29udHJvbGxlciBhbmQgY2FuIHJldXNlIHRoZSBleGlzdGluZyBFeHlub3MgZ2x1ZS4gQWRk
IHRoZQ0KPiBnb29nbGUsZ3MxMDEtZHd1c2IzIGNvbXBhdGlibGUgYW5kIGFzc29jaWF0ZWQgZHJp
dmVyIGRhdGEuIEZvdXIgY2xvY2tzDQo+IGFyZSByZXF1aXJlZCBmb3IgVVNCIGZvciB0aGlzIFNv
QzoNCj4gICAgICogYnVzIGNsb2NrDQo+ICAgICAqIHN1c3BlbmQgY2xvY2sNCj4gICAgICogTGlu
ayBpbnRlcmZhY2UgQVhJIGNsb2NrDQo+ICAgICAqIExpbmsgaW50ZXJmYWNlIEFQQiBjbG9jaw0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQW5kcsOpIERyYXN6aWsgPGFuZHJlLmRyYXN6aWtAbGluYXJv
Lm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtZXh5bm9zLmMgfCA5ICsrKysr
KysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1leHlub3MuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdj
My1leHlub3MuYw0KPiBpbmRleCAzNDI3NTIyYTdjNmEuLjlhNmU5ODhkMTY1YSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLWV4eW5vcy5jDQo+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvZHdjMy1leHlub3MuYw0KPiBAQCAtMTY5LDYgKzE2OSwxMiBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IGR3YzNfZXh5bm9zX2RyaXZlcmRhdGEgZXh5bm9zODUwX2RydmRhdGEgPSB7DQo+ICAJ
LnN1c3BlbmRfY2xrX2lkeCA9IC0xLA0KPiAgfTsNCj4gIA0KPiArc3RhdGljIGNvbnN0IHN0cnVj
dCBkd2MzX2V4eW5vc19kcml2ZXJkYXRhIGdzMTAxX2RydmRhdGEgPSB7DQo+ICsJLmNsa19uYW1l
cyA9IHsgImJ1c19lYXJseSIsICJzdXNwX2NsayIsICJsaW5rX2FjbGsiLCAibGlua19wY2xrIiB9
LA0KPiArCS5udW1fY2xrcyA9IDQsDQo+ICsJLnN1c3BlbmRfY2xrX2lkeCA9IDEsDQo+ICt9Ow0K
PiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBleHlub3NfZHdjM19tYXRj
aFtdID0gew0KPiAgCXsNCj4gIAkJLmNvbXBhdGlibGUgPSAic2Ftc3VuZyxleHlub3M1MjUwLWR3
dXNiMyIsDQo+IEBAIC0xODIsNiArMTg4LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZp
Y2VfaWQgZXh5bm9zX2R3YzNfbWF0Y2hbXSA9IHsNCj4gIAl9LCB7DQo+ICAJCS5jb21wYXRpYmxl
ID0gInNhbXN1bmcsZXh5bm9zODUwLWR3dXNiMyIsDQo+ICAJCS5kYXRhID0gJmV4eW5vczg1MF9k
cnZkYXRhLA0KPiArCX0sIHsNCj4gKwkJLmNvbXBhdGlibGUgPSAiZ29vZ2xlLGdzMTAxLWR3dXNi
MyIsDQo+ICsJCS5kYXRhID0gJmdzMTAxX2RydmRhdGEsDQo+ICAJfSwgew0KPiAgCX0NCj4gIH07
DQo+IA0KPiAtLSANCj4gMi40NC4wLjc2OS5nM2M0MDUxNjg3NC1nb29nDQo+IA0KDQpBY2tlZC1i
eTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpU
aGluaA==

