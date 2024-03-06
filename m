Return-Path: <linux-kernel+bounces-93377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D47872EC2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62690B21E9D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F871BF20;
	Wed,  6 Mar 2024 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="kO/Z3JTU"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11021006.outbound.protection.outlook.com [52.101.133.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE71BDC4;
	Wed,  6 Mar 2024 06:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709705916; cv=fail; b=ZkZJ2/UnmmqyWOZR7kIQFlp6hhjSoQMFNa2r1CaPOEsN5KZys7sSGSNeprOzMFM3Z/BdKP9k9kKs66EJ0nNn4KLJ1sR2HzwZiYDZFzfSf8pXWJLtx7r89a2hN3JzNn+aaY725BPpPrP80yj0xCoRTMqo/frKUlbPhDWFR/fYN8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709705916; c=relaxed/simple;
	bh=mf+gZzdK6CV8KsIuLRr9pyopvJs2yP33u1nH6nK5+Ug=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Bx9S6XZ7yajGRg2PtQEdFBrhFhT6OrgTdNFHqsjtqxmY21z7PVeancn5wgDcZvOVR5Q5j8pdlMkgVxqaAGk2B7wJdkUaGvWRuRx8lKb9v1xjqCFAH5lfiMPqgrwOg2csM24AUaYYCnOYOxtgG5oT0u+nquyLfCak2t2Vk2bNDSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=kO/Z3JTU; arc=fail smtp.client-ip=52.101.133.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGUhJkT47iIvbbjW56ck93Ln1SZNeLfaM5xSJO2pMRyTRRWNiaceAoo7gHjuKFEB5ORAEC3bCUJI+LxJ4Ngi2oK+d2/uZtT/hyz4aNhXQSJLNxEE7VxXmXmp+SazQ9tMf+4Ns6Jns7tDqn/f7Xua2OtFoIWq3jkR5zk9/IK/0kApsQlD347Pl1qM71WW02Jmu4Rn4Izx0xiEIuTm1/Wkffgynzz3yIFskYvr9dQGGyvhia1Npbqry28fxCSNoE/qGW8BlU9HPwuWEpYu0Vr2HOWpbWhKWygfZdNTLUxZ40mDD6S75xQjZbXmSPf67/M5rjujqIGvQso28jGxQscBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf+gZzdK6CV8KsIuLRr9pyopvJs2yP33u1nH6nK5+Ug=;
 b=jFAK/tU+D/WaymxkHY2DGoWwjNew/NbjJb3F+7wtnw/NQD2LfD+OLDuk+idlEsayIZqIKTBDJ2mn1PjUM34GmUphnf7nPnIT8XsOZcIU90MRmQAM4hKq6SApXHLymspXpH72QHQhhueXsgLUipKqQYIjIqC+bw6ouYJv4dIGvJWIjGMgcPJV2mYRedrT1guNQObmS4PhsWK8iN+4kq6WDy+4aFCBxF6SS/3S8NPen4yBiWULSw64TnqEiThrOhCCZWvudRLuC7UbN0j29UkwNmpdJcTwDFqb+9IjVFpy7NCmgVmJfRpMjoYbnW/YNB3dV/EScN1o/jZDEfUVYXv1aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf+gZzdK6CV8KsIuLRr9pyopvJs2yP33u1nH6nK5+Ug=;
 b=kO/Z3JTU9IKXHDr2St7/0Pdv4PzH1LSBNWWP6pgMPLbvXKD8vlAwTIGjC4hoD+aL/rxfKOQd7OvwfKjDUNxZEunQk0P7W5K+Qp9UAFoDJKvytvFt2Z54lSaksy4LJiOTlpXHr5oLtT5S8UiBLo9Evu9z0c1GdkWFB16rUeRVJFI=
Received: from KL1PR02MB6283.apcprd02.prod.outlook.com (2603:1096:820:dc::11)
 by TYZPR02MB6222.apcprd02.prod.outlook.com (2603:1096:400:282::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 06:18:29 +0000
Received: from KL1PR02MB6283.apcprd02.prod.outlook.com
 ([fe80::87a8:fbd4:757d:2f75]) by KL1PR02MB6283.apcprd02.prod.outlook.com
 ([fe80::87a8:fbd4:757d:2f75%7]) with mapi id 15.20.7316.023; Wed, 6 Mar 2024
 06:18:28 +0000
From: "Bolan Wang(Bolan)" <bolan.wang@fibocom.com>
To: Lars Melin <larsm17@gmail.com>, "johan@kernel.org" <johan@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: add Fibocom FM135-GL variants
Thread-Topic: [PATCH] USB: serial: option: add Fibocom FM135-GL variants
Thread-Index: AdpvjNPq56VjetUaSKKUAbkY96LWsA==
Date: Wed, 6 Mar 2024 06:18:28 +0000
Message-ID:
 <KL1PR02MB6283EBD2786A3B3E4E373F0389212@KL1PR02MB6283.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR02MB6283:EE_|TYZPR02MB6222:EE_
x-ms-office365-filtering-correlation-id: 94b4fc72-7880-495d-3315-08dc3da53d4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xJUolu28UBDggVPV8KT88DNlDWqiBLCBrB+gmxspD+P+tS0d2GB27cW3iOkKUnRqHxOFg0VgnQNbq69xfEdQ+lsghqUpERMH4v22Znbr1ts0DVe8trMNTl+cu9tWBKLR+0XDF9eyEkgS+J3pkZj9pu1B6YWySRg5Jd8enEUuXYq0oX8zr8XNt6QXDBqjCwImeg8i0TvMhGLg56ptpP4Zvn385inB2jig/GObwgKypsllQwhsHATXb5mIqLxTcYfg+25XdpFyOB9JY7y3LhxWZyUw1ja2krXXWoDJo3epW2M/qeHBUMyXWBZzyh0gVXeqSjdF1T+f58bDxG9eguZriHWVZBuQCda9kQOhCCTRBAwsC1G+VFBU08xA+7c6V1cO1+QB8bnYTaR1RXeAX9cwqLEr7bDjYYlmwfg8cJaUnzBdmhlIb4G6a3CG2mwUKtsfD9WAkaU8tWnNewQesmDxelx+R801FMgLNvLKYijYjG9v5xpgwQn15JME8l/G4auSKjD3NreAkJYmhi+6r2U0MzhpEHB22V8MyKiJ2Ya0aOT1xDf4Btv8cDrvarD4OKksTINg/VSNf0tUsLQa+HRr3cD5drMm8CImE2VKvUKgHSGQQtcFWUKyFvD4id5Z86stxwPnu8D8A8U3qsYauuFghFx8oPYsAadWmMAph5Zdbn1n6e60xMYFt5gNBN8jaAP6ZDKmZ6IIk5AXHIOh8eojjP50ENKiZdq2pOOCyje5hEw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB6283.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGthOHd2U3YzOVFiRmR4MW4xNlZCMkV4VnRJblE0a3Y4VDFGQ0hNY3F3UkJY?=
 =?utf-8?B?RGRSNDNibUo4RXNobmduQUtwOVgrUEczN1ZaQ3AwNHp5N000VG1FMHN1TDdo?=
 =?utf-8?B?aHpPOWh5UXhRKzQvYmZpTFZNd2pNMDdmVWJOMUx3T3hKejQrVTZtVWhDSG43?=
 =?utf-8?B?bWlKME9rbVVZcUlteVN4ZEs0SUpIZnM4RGFkeHhpNll5KzVJckFJbDNnRkhF?=
 =?utf-8?B?ZDF1djNXYWpKQkxmbURuaVlaZTJKaTJzNmQvaU5YZVlzbmZ0c1I4cEE4UVla?=
 =?utf-8?B?SXZudGlYT3hsdGxWTXJLVE1weVA4NVdhcHhIdS9tYjlTZnBES3BiNDRWMjVT?=
 =?utf-8?B?ZEZpRFF5bTZFNjFIL1lndmxUNm1haEJWd2pjZFFoMTJ4aGpHdVhVVWNFY1Bm?=
 =?utf-8?B?MVJtNnpNT0NZNUtUaTJ0MTloU1U4bDZDaFhGVGE5V2JXYjNrYzFXbkQ5ODdq?=
 =?utf-8?B?REFyUTlnTGwvZVNJNzR3KzUvUGVEc05Ed0NsYzRjeWpxOVkrVGZQMW5Rd29a?=
 =?utf-8?B?NC9zc1ZJRkNOUnpsVVBJOGlDUXB4anpNQlMrVWljNlBndzdTdjZTZmJQVEVZ?=
 =?utf-8?B?U2NJa2U1dTBxazBMRkZneTl2SUlRQWpiRktUaEtMNzErdlNDUFRzOXNFWWhx?=
 =?utf-8?B?TzJYWGhZNDJldy9iaUs5a2pFRVIxVGJXLytWYnpodXU4d0hBQ1o3N005VkpO?=
 =?utf-8?B?NFFSd1lVbnRLbXJNZ0lRdUdPU01wWGx6RG5OY1RiT2tGSzF4R1VabEZySDRZ?=
 =?utf-8?B?c1lpOEpJOEVzMUNyaCtiZnBXVTR4bnhXRWFPalZTMi92ZmpFcTNGMmNSSE9t?=
 =?utf-8?B?b1ViQm94WFhuVXJWeC9tS3ZmdFNIQ01QQXU4YnN3NmdhSUM5Y3pkNXQ0T3Zs?=
 =?utf-8?B?WmlFaC9xQitQSTIrSENMMk9OVTlORUJSdVQycW05NXVJUUpiZnk2Yzl4Sk1i?=
 =?utf-8?B?djhaNmJRZGFsSHEwK1NaNnRCNWF2SFNkV2pMNkJOQmxmbmFsTnBJL0swY1Za?=
 =?utf-8?B?NkJyazgzQ3YyU2hlTXNJb0h5SEhaVHVRVUU2bXNGUnFsOW1BbHM0RlpZcG9q?=
 =?utf-8?B?cSt1V2JqSTJ4RFJWRFRNWk90Z0tWUE5kdHFoUktXaitFanlyTnZJQlYvTjNL?=
 =?utf-8?B?RmkwVXJkVUhRa3FmOEdwblY5TVk2MWI2Q3FwN21GWVhSckx3b3RuTDVkem5p?=
 =?utf-8?B?b0ZkYXZqcjROZTc4bTlRSGhuQTM1dS9VbnREYVVCRGljelVTWkxZazVydC9q?=
 =?utf-8?B?Ym1MSEJhMldnRnU1TTdNeUI2aFdxUlVxNUpYV01EN1p5bDIzNkV0ZWorcXRU?=
 =?utf-8?B?VFRCQWVOTkcxMDJvWGZVamRvU0xGbmtWZXNoUFZGemkrR05zSzFlaUt6bVRx?=
 =?utf-8?B?QnRiQ2VpRFRPTG1HMFgvNWhPMnZuTThiN1Y4LzcyZ3NVR2pvODBlYlhLMnR5?=
 =?utf-8?B?SWpBQzkxSENGWEtKQm0ybEthbEN0WHAvYXVhbmVOeDM5SWFYdXZHVkE1RzdX?=
 =?utf-8?B?K0ZUVGdCZGpBRUVsNU16cHRiV25KbU0rNHhIZUJtOTZWTzJCWGoyb0hzeHYr?=
 =?utf-8?B?V1pCemgrZ1RvTEdxVjlzeCtNekRVRnh1Q3VNZndyc0ZCSkV6NUtXV3p5WEIr?=
 =?utf-8?B?Tkh2SkE2enE5Y0NoYXFEWlV6UFo2R2Qxb2Exa2ViZmxYU2pyVEVaQ2h4eW5W?=
 =?utf-8?B?OHlHNTFtVkxrWFZtRVpSN0F6OVBRb21PZnIrRS9ZdnN1VGRnUytmcjJweGhF?=
 =?utf-8?B?T0RxWVdqbFhlbmZpQkF3UEd0UTVYbVRLcXpaUjRPWVN5Mk0wc1oxYkpPU0Vm?=
 =?utf-8?B?blN4NGhwZ0I2a0NvTmxvTEQrdUJLRTdrWGNHWURLMGJGbEltRUdIWGp2QlNr?=
 =?utf-8?B?bXR0ZDc4eVZuVk5PaVIvU0ptSndmZXJlOW9GMWp4aWZtUjNWY0tZYnU0RktQ?=
 =?utf-8?B?NjcyLzNHMzQrWGN3bHA2Z0lOTzJsRmJsZEhIellYK1lBbis0TnZkLzUwL3Bp?=
 =?utf-8?B?TUFybDlvc0NOQ2lrR1cvUTE5SVNNRXhmSjlUUUw2cjF2YVVySVZwOFZkenl2?=
 =?utf-8?B?V2JzaGR0ZjhhZWlQc0dNSkRHUXBqVnZvV0pWMDVxYThzRis5QlhUN2NyVnI5?=
 =?utf-8?Q?L5ug8sin0MBbhoh0d3sfR3EDH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6283.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b4fc72-7880-495d-3315-08dc3da53d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 06:18:28.6605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HXpmC7Jka9M4HItxRok0WmvsWL1UbMaJ78uYCdnIYsR5vK/Z26A0DH3KNs8mPE2smaE4dgVvQpwuucrfhO6ugg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6222

PiBJZiB0aGUgZGV2aWNlIHdpdGggcGlkIDB4MDFhMSBvbmx5IGhhcyBhbiBtYmltIGludGVyZmFj
ZSBhcyB5b3UgaGF2ZSBpbmRpY2F0ZWQgdGhlbiB3aHkgZG8geW91IGFkZCBpdCB0byB0aGUgb3B0
aW9uIHNlcmlhbCBkcml2ZXI/DQoNCkhpIExhcnM6DQogIFRoZSBwaWQgMHgwMWExIG1heSBpbmNs
dWRlIGF0LCBkaWFnIHBvcnRzIGluIGRpZmZlcmVudCB1c2IgbW9kZXMuIEN1cnJlbnRseSwgb25s
eSBoYXMgdGhlIG1iaW0gaW50ZXJmYWNlLg0KDQp0aGFua3MNCmJvbGFuDQo=

