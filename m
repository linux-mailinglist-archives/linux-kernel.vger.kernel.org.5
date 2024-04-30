Return-Path: <linux-kernel+bounces-164574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F808B7F86
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F75B282EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D03181D15;
	Tue, 30 Apr 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="a18sOTOJ"
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310E51527A8;
	Tue, 30 Apr 2024 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500764; cv=fail; b=ZiOaMDVSgUhLTwh3mYy8T0PfrbDZgvDSAMBURlU0+7xz3v2j9V3LVaKk3lFby4fIzkKY+ORoTnH7RXa80lWETGzV+JpLvCfrRNWB3JFccl7NAMs1Pgc9l1L2dRALKpL6GDgcBTYOhcW2mM/ITHz5At0UJK7JY+YEh62St1F274U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500764; c=relaxed/simple;
	bh=kQsbI5RIwlG432AturEdHywgILK65ypqAYIKJal0SIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=fTJNEP7Wy67Q83CONjXWEh7DLniYX4YiG2owZT4PK9zWKxMRII0p230WUZ7bmBw0P3IsKfjhUv8CkT5g+WS69/cH/po9iTuOjz1uHbOuYWlUk+xlyhsaHpiVr3FJ8AomhoZMDzXXP6Gt/fGAINdqibVD2r1EMQhRJVPaIuG8a/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=a18sOTOJ; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UCtThG003903;
	Tue, 30 Apr 2024 18:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=c1VLCE9KpEZdT57wKbn9O/JM+B/w4x6LMgl29OBhcbA=;
 b=a18sOTOJPMeujuygYAwlNeFb3mtlRxmbr/dvIO0TpZoXlgf6baTI6vtX0j47Z5rVuMOh
 kmZK6JffB6i9cED+i/nqoh54IreH+5J/wS0qm6f3XxyhhQToAQDuFHC3+fYMsRCXLz05
 yHyozdpZ216vCfYeSwdppC3v1H2ui50w+81nKbs/W/GSafv4VdpmJxZFyIeeBlssOncs
 uKxT6MwKWUYW5JP4iwPj2+h4eCoatbBy9m41g5vUUgY2heDJ0HWgo2DA8bYLGYYJlCbf
 C8w9qQadSTyOGQgUmCh6XP6HCKYVSASXTHYvg58ojLI5vqRQv7oNgQKk15Z/gla6crm0 fA== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3xrps5k2pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 18:12:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/JU3aWwZep//p2T1wkshADgsP+dfpfQ7HDk+kFxhv7VevqyTQSW2V9jQbCUkrDkFHbBup3XuwZS9dGE5zwdz0LetTYKSwaFCHt9MDNH/b3ytBKjvE3UAFvV8qOogVuF40IeqiWEaChLOIPhAUGQCQXtlJJAEx1Fbq1fA8YMptPOOIy0aubqsWBeNrEmCp3nywoUtZGeAdGsXrr6cf9SEolRtvscNWHik/UycF5xpQ26HUxKRktaZF0gIaG/qVYoXm91wkYACGjVLQMXyG6rSMfSJVErd//mTco/95InPLVA57fOFLZWs4u3zE5/2KUzE2/fDe7hrJQwBcvwDVohGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b2+OACntWAkut/z1tfEJtoDn9H4USAola3+LdUtK0Q=;
 b=F9FfbOgYwipOc3bIqkqaJgIZAcEOkqZEN8jXx2ZLVfOy2PhF79NYCzIUwifMSuuX6EaIRc5MC1iA8Tfm6V+CzEXbvuLXJFQ8seM2MjONS+PUscsW4+8KtOugPW3MvC+xKpj6tQXOjnFiKowaXlT8Xp/viCS73ePWBOBTJzH324GYShvaYXgrSTBRyK9pH0pBEWZmHwzxcVcJs8DuiLrxi/R4hr+dxzIREBWBygzE72RALswtxb0RZ1JYxEBCm7r/4a/+c+bqlvvQJAgzvLno4g9+ziMMF3Z0WmByrtbfx4oD9PK26BGMiKBAmvpx5vo6s8pL8Y0UjYsNRqKl58Cw6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from SA3PR13MB6372.namprd13.prod.outlook.com (2603:10b6:806:37d::13)
 by CO1PR13MB5000.namprd13.prod.outlook.com (2603:10b6:303:f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21; Tue, 30 Apr
 2024 18:12:11 +0000
Received: from SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6]) by SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6%5]) with mapi id 15.20.7544.019; Tue, 30 Apr 2024
 18:12:11 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Greg KroahHartman <gregkh@linuxfoundation.org>
CC: Sasha Levin <sashal@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] docs: stable-kernel-rules: fix typo sent->send
Thread-Topic: [PATCH] docs: stable-kernel-rules: fix typo sent->send
Thread-Index: AdqYL9089+sCb2j3Si+txixVqLkj6wAWzCMAAKenNpA=
Date: Tue, 30 Apr 2024 18:12:11 +0000
Message-ID: 
 <SA3PR13MB63720647D48D0D725539549EFD1A2@SA3PR13MB6372.namprd13.prod.outlook.com>
References: 
 <SA3PR13MB63726A746C847D7C0919C25BFD162@SA3PR13MB6372.namprd13.prod.outlook.com>
 <2024042715-repossess-unshackle-a078@gregkh>
In-Reply-To: <2024042715-repossess-unshackle-a078@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR13MB6372:EE_|CO1PR13MB5000:EE_
x-ms-office365-filtering-correlation-id: 14f0e795-ecca-4dc0-edc5-08dc69410e87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?R0xOUU9XRXEwZnY0dFpJNmJiTjdUYjFjOTNpQWFrZUdOSmZPRTVDbFFIM1Aw?=
 =?utf-8?B?cWRsYVpKaGJjYTlkMEhtZ1VLellSRE01Z0h5MDJOeVM4d0NBUUs1NHd4Zzdk?=
 =?utf-8?B?VnBHdXR0RDNmYkNEVmN3amtIaEF6bDF2N0dSYURGb01nYkZKTFY0eW5iNFh0?=
 =?utf-8?B?Qy9lRlpsTnJub2xUUml6MGNNZ1Z1eWh6ZThGRkZZSVFIdnYxQ3MzS0RvWVJn?=
 =?utf-8?B?K2V2ZXdGTmtTaFh3OTljYWdxM3oxWFhMUUsxOEtZYVI2M2dFaC9ia0I1bEQ5?=
 =?utf-8?B?OXY4S0JoZk9pdWdta3JBdFpKa1pPT29XOWRqaUNaSk13Y3c4OWsyQ05YcXRH?=
 =?utf-8?B?VXY4OGRnb2g2Q2FtS2xueGdxanRLNEVXZWU3Ykk2MmtLOTVYR0srZjdGOTM0?=
 =?utf-8?B?c0cxVFpXWmptZDVJa0o0dzNMK2Vic29RTFBsTXFRT1RYZ3Vza2VneDU2M2xI?=
 =?utf-8?B?RmhNdUtpNXdoSS9HejN4WXM3OHNpeGJxcFBOdzBGNllKS1UxYXVjWEE2MmFh?=
 =?utf-8?B?alJSZ21UZnZwTHNva0Q1ZjVNZmhFSUdOUktIWGlFaHNWRHRvdDFKR0tPbUQ5?=
 =?utf-8?B?ajdVVHFlT3ZGeWlQQmROME5HamFZMkc1MXhKU2djNjZzRThFbjJZTUlPKzli?=
 =?utf-8?B?aXZJaUV2SUV1bC9aeXcwdnVuV0NacENTdmVqUjBLZE5VR29XbUZUUy80QlRV?=
 =?utf-8?B?enNsRmlseUdqalhrVGlBNXZYckd1NVUwRFlTN0p1TUVOeFlTTG0rS2V4ZkhM?=
 =?utf-8?B?eVM2bnFSTHFZamZaVExWUDh3Rnc3UFdyNHV1b1JnY0pXdlRhTUdSNHJZbmtI?=
 =?utf-8?B?NVNPZnkwU0JobnZHSzhiYk5RdG9pdTRGd0VRZzhlS1RKU0QyQThPRWVqbTQy?=
 =?utf-8?B?enRGREdQSE42VGFwcThvdjdxWkxvdDNneUhhV0VqVWxsNGFyWS9vZ0czSktP?=
 =?utf-8?B?bzdaWDNXeW9la3lqaG9Nd05GVEJDSHhSUFVwbHZLWkQyUkJCeWluaUtCMzBa?=
 =?utf-8?B?TDlsaE43WWtPM0t4WVg3RmF1a3dBUFA3NmNJdDZ4dEEwVEFHcnpaSEZyOHJH?=
 =?utf-8?B?SHYwR2pCdzRsQUVTVGtYS1FWbWpJSlJKcnVmd2hMY2lmV0FUMkdsT25WOHlV?=
 =?utf-8?B?MURyMEcvZlUxSXNFa0JyZXBNSEkvbCsvTURsblZxMkdBem9USVMwTmxFUGN0?=
 =?utf-8?B?QStGUEZTZ0dUdmVEWlEyTnNoVDkybWY5dzRHRzI1Zk5DTzg2cDIxV1lyR0dV?=
 =?utf-8?B?ejhlNVRkK1ZDcVF6WXpoQUFyU294RDZaSEYxMTA3ZFVWWTdDVEw0QkZPWmM1?=
 =?utf-8?B?OFJlaVR2R3NTdDdRVFdES04wbitCRlFtRlNHOHoxeEZPUTNRdXNmT2lFQ2w1?=
 =?utf-8?B?TzQvQ0tNYzJpTHFoR0xkRFR1cWVqQ0dnVDJxUGFHU051cEZKTzFGeitzWVRX?=
 =?utf-8?B?NG1TNnRqajNNa3YrS0xtcUNjbm1YNERtRkhpSUpiWm14Smh6MzNWQWx2S3hn?=
 =?utf-8?B?bTVJT0IxSjg1TEZaajFPTkc0c25mNm5CT2oyaE9OT3QzVS8yNUxVN2F3QXNW?=
 =?utf-8?B?N1FaZFh1cmRvazlROXRQSGlVVVRUK1F2Mnh4WHBJWDczckQzbllRcEtSM0h2?=
 =?utf-8?B?TUYwTXNZSzJkQms0TXIreEt4Z0Rhd2wrSUNORVBsL1pjRU1HcVBIdjI5enoy?=
 =?utf-8?B?RDM5cExmVUlBUU9pVlBzTmwxekcveHp0SGtFd2RhazIyUGttS01WUSswaWtH?=
 =?utf-8?B?bzY2TWsxMzVXdE95alZTZW0vZ1M3OGVDMHBiMEdhY2ZKYXRWelk1Z2VIZm9n?=
 =?utf-8?B?MmZhL1k0emNpUGUvY2FIdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR13MB6372.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UnlabVhaRTQraTJzNDlkVmV3NERLd0ppNG9Cbk9UbWhJcTc0UUZpNDBtR0hw?=
 =?utf-8?B?OUJwTlBqc2hGeGIrZzlYSmYwNWtsQTlTNER3OWMvRkx4ZnZEa3NoY3NNY0tv?=
 =?utf-8?B?QmJ1UlA5TWM0Qjg4di9lQlpZNUp3RjFjLzFpbWpuTjFZU2M3LzY2NVRneDJC?=
 =?utf-8?B?aGJkZGdhenpWaCtjb3g1d1QyVHVsdnJrTU5mTkcyTWthMDV0SlVMUkxmL2Ey?=
 =?utf-8?B?QXZPRk9mOXBCQzY1V21zYiszcHVVb1ZMWnI5VDhtcVlUQjlyWG9UOHB1YlNI?=
 =?utf-8?B?cTJkU3ZJOEs3L1h4N2RxY0JBR3JkaytuaDZ4R1p6eUlvSE5ZRnp5eTJQRjBE?=
 =?utf-8?B?WjVQZ3d6Vi90NENMUWVWbEsybnNsejZnYms1elhuUjFZQWdGMnNUeE1YT0tJ?=
 =?utf-8?B?blhSSDRkVW9XZEZJSmp1ZFNnNDFZWHhiYytYcnVwZUQrWVkxVXpaMk5qZEth?=
 =?utf-8?B?bENjMlYrYVo4R0dVVzlsLzlNZnYydXpRdVRPUndiSVplU2RqMWpoUFJ6aXJo?=
 =?utf-8?B?b3B5NUdod240OEhmLy9GcUdFU2xMaGNwOWx6eDhUTEVuenFxWSsvYnJQY21u?=
 =?utf-8?B?OUNqVWM2YWJtKzhEOVVVQWUxWEp3WFY3UlZRNHRwQkQzbzROWFV1Q2J5TDFp?=
 =?utf-8?B?THJlckhPTjdVOEp4YlpWYkRuT0pnSlNVMlhpc29oaVFIZVQ4ZEN0RXI2QlVj?=
 =?utf-8?B?eWNpQ0svUU94ekFiUEU5ZnZzdndYSWEwM3NYNytuQkJuNUNpcHljUEdyYUxt?=
 =?utf-8?B?MEtOdFJSZzBsNkQ4QVpTVmZ2YzMxeHlHWGdBUlMwakFsTWZJZHU1dnhWV3A4?=
 =?utf-8?B?T2RaMWNJQTYydW01QWpQYUQ5VCtXenZpRjE2Y250N2trb29wUTEzVUFxNXBK?=
 =?utf-8?B?WGtEREwxTjJ4cEl1a3ZQNlo2Q2FKVitPSWdDSkJVUUNCNmp0YzRidWJLQnU5?=
 =?utf-8?B?Y2xTVEF6ck5POEhWbW5HdE1SVm9tN0E5WVVtSVRMVXIrbDZHejFTeHZXM3Zu?=
 =?utf-8?B?VExIZHo5TDA3Y01lRDAvYlFvRTA2TEZYR0VHZW05V29XVFlVSDVCcXBzNktt?=
 =?utf-8?B?Y1YxWXZJdUJOYXZwUHZJTWdzSTdKZk8zeTdvMGVCY0QxbTFLSmw4cUpYUHA5?=
 =?utf-8?B?QWxBb0FQcnNKVnpvc2NDeGFhTkhMY3UveE93ZTZxQ2VRSGw2SjhIdHdkcmpE?=
 =?utf-8?B?ZHZWMGh6Mkp5U0g1ZE5xbWQvN0V0bXRhdlZyaGRnUExyc0lQZ3dsN1A3S3FG?=
 =?utf-8?B?QTRERVdsK1JMUDNrRmQ4bFFGdkc4cXVranZmZnQ3QWRmZjl6THRwbG80b2hK?=
 =?utf-8?B?cFNuYlp4aXJXd0xuMGtKNmhlOXJtMzcvYWtiNUJuVEIwRXdmbXdQWVM3dzBa?=
 =?utf-8?B?QkI4aWhHR3N2U1R1MXUxaVBMUjlwV0tjOWgrMFVtN0ZYai9RcFJXYmk2WWpQ?=
 =?utf-8?B?QUgvNjlkQnludFN5MEt3dC9FWlkzMlVBSVptbDY5QnBNcmxKdVJaOVAxV3RO?=
 =?utf-8?B?bjdza05hRWpDdTUvcVlBNGcxQmtYcWNwRG1aRGN1eElhZERIUmU4WWx6S1lX?=
 =?utf-8?B?U1NObkgvc1dOTXBRd2I3SzJENnp4bTZBRWE2VnpqaGxmUFNCTFoxL01BN1VG?=
 =?utf-8?B?U081bkZOVXZNbUxZRllJaEdkVVlBZTNLTDFFYWNoa3ZPQklYTkpTTU42NjNj?=
 =?utf-8?B?cWo3c2lpc3F3K1ZwaGhCMGx5Q2tmWDFkTTZCL1NCcndGWEVZVmZYcFZaZjBm?=
 =?utf-8?B?d2Z2QWtNbzB5cnRVNTBXaFlYRVFxanh1M1YyNDJLelFxREExVUMvSjNKZTdI?=
 =?utf-8?B?ZWdXMnlpcCtUakEyejRkL0t6MDlmOWdzS1V3SzF6QW9zMGdIbXlvSnlFcDQx?=
 =?utf-8?B?QU5zWVptcGlRTmhUS0VUdldIRW53RGt1QXdFdzNUdGh2WmR4WGZDWnlZSEp0?=
 =?utf-8?B?L21WZm5JZXBJMjdSbThlV1ljQkk3cUFjZnp5RXJ5cld0cXF4cFZzWnJTTjVt?=
 =?utf-8?B?Tkd4Ykh4aXNYMHpzLytnZGtZN3I1V2wxQWJVbitPY3lJNGMzd1ZyK2tkRk51?=
 =?utf-8?B?T1VsZlNKYkFXbTkzZm9IVFZqNXAwMnJqY3FxZzRCaFJIQUJVdE5sY1FCdDhl?=
 =?utf-8?Q?aaBI=3D?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZEIgepfKLrmiPLwdfMV7+M480Nfel/NqJN4NUhfZtFlzzicJ7RkTrI6rVrk7englzyK2nq761kolVMq9BcJfaonfoCGKNc5eX3Y/RaKp++RGsVjsEdZ1wrav08HLBHYhKJ9komIONo7UaBMlhG8CFC9nUPM2kxkSvGshYlkHv7W7j/MG0Tu8WYvY6mcJ3oVB72veaWXOYGv7nb/zyAiQME/01r+EHGC9fBS6UwzCRL2bRU6ZE5tMJT0XgOsT2OTuKcDpqI2ZSgs0CB2QqJkwCxca56iucwTk7hulJGU7KAU1HVltGKUVml7aAc5w210cMOxShHGmIGaYuwqdSd8rojbrQAQDYLHCs0rhw/2Bn5Zcng2bkk5edm42/+c6T7uiVA6lqwNua7s9WQ7rKu+Bed3ETkkwAFLq9eyNE0eaaZyl4TOn4y99dqxUFuPmuzdkiBeaUUHdxflFuUu4AQgIO87ix7OY4oWLX4J5P/91yQoLLvxv/cENp+uGUXQyYb3K2MP44yQv/zOQ1UkXuOxQzoGZFCgtM4OdOWPVkNS0L6KvlSJgB0BBumIPXE7J3LFMKR94izsWbGq5ng33J+HuTza9JSO26jOyY4OKbi1GxPE0tQv1CF3oXyr56BHhbdAE
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR13MB6372.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f0e795-ecca-4dc0-edc5-08dc69410e87
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 18:12:11.6963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qxSquv2FhNN4L0hd6TbBvLT9n1Y3VQ+D3H9mHDGRl5x49iY64cPN4yjeInZOwtfZ3reJLTIyFdifHdBkoQOxeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB5000
X-Proofpoint-GUID: WPLxJEkjJxaw_tUXsRdr_UuW74ix6yoE
X-Proofpoint-ORIG-GUID: WPLxJEkjJxaw_tUXsRdr_UuW74ix6yoE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: WPLxJEkjJxaw_tUXsRdr_UuW74ix6yoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_11,2024-04-30_01,2023-05-22_02

Thanks.  I realize I should not have copied stable@kernel.org on this.
typo fixes are out-of-policy for stable.  Sorry for the noise.
 -- Tim

> -----Original Message-----
> From: Greg KroahHartman <gregkh@linuxfoundation.org>
> Sent: Saturday, April 27, 2024 4:10 AM
> To: Bird, Tim <Tim.Bird@sony.com>
> Cc: Sasha Levin <sashal@kernel.org>; corbet@lwn.net; stable@vger.kernel.o=
rg; workflows@vger.kernel.org; linux-doc@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] docs: stable-kernel-rules: fix typo sent->send
>=20
> On Fri, Apr 26, 2024 at 11:=E2=80=8A18:=E2=80=8A14PM +0000, Bird, Tim wro=
te: > > Change 'sent' to 'send' > > Signed-off-by: Tim Bird <tim.=E2=80=8Ab=
ird@=E2=80=8Asony.=E2=80=8Acom> > ---
> > Documentation/process/stable-kernel-rules.=E2=80=8Arst | 2 +- > 1 file =
changed,
>=20
> On Fri, Apr 26, 2024 at 11:18:14PM +0000, Bird, Tim wrote:
> >
> > Change 'sent' to 'send'
> >
> > Signed-off-by: Tim Bird <tim.bird@sony.com>
> > ---
> >  Documentation/process/stable-kernel-rules.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentat=
ion/process/stable-kernel-rules.rst
> > index 1704f1c686d0..3178bef6fca3 100644
> > --- a/Documentation/process/stable-kernel-rules.rst
> > +++ b/Documentation/process/stable-kernel-rules.rst
> > @@ -78,7 +78,7 @@ in the sign-off area. Once the patch is mainlined it =
will be applied to the
> >  stable tree without anything else needing to be done by the author or
> >  subsystem maintainer.
> >
> > -To sent additional instructions to the stable team, use a shell-style =
inline
> > +To send additional instructions to the stable team, use a shell-style =
inline
> >  comment:
> >
> >   * To specify any additional patch prerequisites for cherry picking us=
e the
> > --
> > 2.25.1
> >
> >
>=20
> Thanks for this.  If Jon wants to pick this up:
>=20
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> is fine from me, or I can take it through my tree as well.
>=20
> thanks,
>=20
> greg k-h

