Return-Path: <linux-kernel+bounces-67359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99007856A67
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194761F211FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A61213665F;
	Thu, 15 Feb 2024 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="M6UJzW3o"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69B7A41;
	Thu, 15 Feb 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016528; cv=fail; b=NLqsqFZol9oATnGImHd7X5n1BKFgTh6421DouIxwAXUJZ+5G2UtekJHHnFMgjNKyQB5brmFqTxr1q9tNsySgSRavQJEjVWAFJ1hjm4mI94I6pIbM0Tl6yveg0OPzsCXVVqK7Y7Crp5DAHjOFpZZwfa/YirXz5jR6kP51VI0E1SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016528; c=relaxed/simple;
	bh=Na76vAkBpmyHwOeP+AIEf17h1QP+BsmwaQk6dVW6QtM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kGN+5m6X7Q2NSUzRs/3xLydTyFErs4P7wmBJwGb1RKcOQH0XjElKOhxb/tEhet1y6L8A+n79Kk9/9BFHuXtjGhrnqrD5DQsHDiHK88u4E1krCc1w6pn4/NBeO8C5qAzxJNWaGXijs7qEH7C8VuZibYM2uZUSE044Gaq4F3VQ978=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=M6UJzW3o; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FACUt6012571;
	Thu, 15 Feb 2024 09:02:04 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3w9gnchfcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 09:01:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EC3LP4ouo+aAkq5OMV13ruhguQPlltk7wHYsdaxpljt0ljBkgwFZKTgq0T30AunrbO/s/Epd89UIYRPb1HrUUCshz/FAyjfP2fxO4xdsH9Kqj+2o9xtk53YzpK0asOJgWB7OmX5Lo5+DOelCeYXj2HUZq4L9MsM1Qpk47lUuxpXC4Th6QtS/tzIpK+CNkHnYnXLVfZWvyBjBwp+O7a1IMiwt4u2X4IIxR5QMT7tA9CLRmVUGBRbfp2W0zBJUiodrqA3yGEBSjQwIVJrrElogAyJxjQ0GRs4P+543AtQ4Yikj8CctwWIeO0z70wDjJWVZyEnqYjAPZRSuIgbmdZy28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Na76vAkBpmyHwOeP+AIEf17h1QP+BsmwaQk6dVW6QtM=;
 b=VrZuxoBIAacbdBJ8nlEDDRNeEgV6U8hW72hh4j6gzLmVLFK4OO5rj/e+OtffpI0jJ9u33GTtrbNWcd2DAQDaQVFySic9G+bHKpeOtOjPquL6hIdfVRXlwD8ZWnk6orDtlpnkhaegVo1tH0i8iJcjKyLMqf0aES9EC/P6TKeHQIEVqt2vB50XZFi7p/X33uZhwYPm/umuPpErJ+x3vrltRBlANFT0th7lsueyoDChHLEQX1O5+/rdTWTc6e7Bk4odPHpg9nUgaIi5xkFVbLDIqibbWuS1O23WWG8sQxEWbbowiK/47EcdCZnd1CH8kYKCg3R1h7UaGMTnKPoxACwN/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Na76vAkBpmyHwOeP+AIEf17h1QP+BsmwaQk6dVW6QtM=;
 b=M6UJzW3oKAlvS1YSpSD4sy6azXyGnnwq0MYz2bIFD22WD3fHGU8SxCEmC/0yRoIfbEl9OUzv2iJ6UoZBz8lyi/mLY6Or6JfQmQYbgymZcDwcg99qkehZgWp8HKA2fQnAVKDheHPVysaZZvVZac5gDxbgIk1vFWNHw/MyTIT7aqI=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by BN9PR18MB4124.namprd18.prod.outlook.com (2603:10b6:408:135::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Thu, 15 Feb
 2024 17:01:41 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::9b7a:456c:8794:2cae]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::9b7a:456c:8794:2cae%4]) with mapi id 15.20.7292.027; Thu, 15 Feb 2024
 17:01:41 +0000
From: Elad Nachman <enachman@marvell.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "huziji@marvell.com" <huziji@marvell.com>,
        "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2 0/2] Fix PHY init timeout issues
Thread-Topic: [EXT] Re: [PATCH v2 0/2] Fix PHY init timeout issues
Thread-Index: AQHaYCpPWJvc6LaOSU2WJKfe0w8up7ELnfwAgAABgKA=
Date: Thu, 15 Feb 2024 17:01:41 +0000
Message-ID: 
 <BN9PR18MB4251FD4F9BD9915477823316DB4D2@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240215161613.1736051-1-enachman@marvell.com>
 <CAPDyKFpNL_zFgzSNgaSRqaH8tDNjwB16ZD1YGwqM64vcQ2oxtA@mail.gmail.com>
In-Reply-To: 
 <CAPDyKFpNL_zFgzSNgaSRqaH8tDNjwB16ZD1YGwqM64vcQ2oxtA@mail.gmail.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|BN9PR18MB4124:EE_
x-ms-office365-filtering-correlation-id: d8731b4d-5173-4892-41b1-08dc2e47c7e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 kexGUKQCupdIPsQDn70icSUyWNkt9lfcJ5M1kD8kDbR3ylhW/cKg2cPUAALyiuJhs1GOfQywm97c3I0QvzstBPo00V/yKT/venp2mtGqE/NrMcQmqS3+Y9bCuXhuOU69pfpnMVyI2sGRMU7qpWIuXMU6mAQQf+hu6LgFZR5H68WC1cU319De7sXeihEpEZaR3sTT/MfI59LSqR9KwKZ7iAj2oODCPaPninRoohNISQHwtZtUOTnKmgB0SX4Xwau5G8O6OJSyhtnTkC82gquM0m2DWtaK7rpWTO7wx9jTqOKMQb1Zpvh9FPtboiz1Zm26CK0fWn/yAmskNEaukBdBrjMhgIrkGor8au7bqpf6EXyFNHhudXzth0zpZRaT2qf2SUfgDxFlZVpWYRRsotJcxfY11aInRHqWAEhmbqQTqzgLWX4GflLfe2ItFJkjtfzE+tIbbitD3L91FWotElavOQHXS0bSugAxNPJF1Xe/KsAsEWJdNPShqOT+1Fbz18ZaKnqqxBg9EqmtzRdDfuwxlyA5kDbQ+Lidc5MuWP2eA9jpYwmdUQhxKaJRziBcZbi1iEpVq9K4sAXA9VysShj0GugltM/+aPgGchcuJg0UO61UW/jIg+onNWmWYvtoGXob
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230273577357003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(83380400001)(53546011)(478600001)(7696005)(9686003)(6506007)(316002)(54906003)(71200400001)(41300700001)(5660300002)(52536014)(2906002)(66556008)(66446008)(66476007)(64756008)(66946007)(76116006)(8676002)(8936002)(4326008)(6916009)(55016003)(38100700002)(86362001)(33656002)(122000001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QlRMWFdkM1dFbnVHL2dlZjN0alFRTVBBaXRwb1hTZExlOWtqNms2TzZwdkUy?=
 =?utf-8?B?c2hsWDdKNXJHVEwvVTVLRkc1RjIzZGNHY1lNRTBYeGIrRUtLL0tqQXFNcHlo?=
 =?utf-8?B?TmZDQnRNK1ZUWXQ2ZnF3TUFMSmNIbEk0Z3BFd2xBT2F3ZkIybzBRdVNKOTdw?=
 =?utf-8?B?cFJJRWJhSFVHaDRBNTlKKzVabVltSVV6ZDZ5dzVjZkNGZFlBY0VTS0N6OTNL?=
 =?utf-8?B?V3J2aEIzWTc5TXgyZXRHemlEcFdZVHRhL3FLcDdqK1F0V0dEM1BlbTNkVHFz?=
 =?utf-8?B?SGlhN3JOZ050Q281OVpKVkNkZVhCYVNQZVFIWTBGalJWclZlVFpQbjJPSVEx?=
 =?utf-8?B?V2pYK0tmV0RzN1VwMUhySUlqcU1SbTBybUp5U3ROcDBIYm05TVd3OWJrQ21H?=
 =?utf-8?B?S1BlNEYzRUZVcmswa1NZWXdvNFJxS1lOQnNxamVycnBFTG1YbW5aVzBmaSth?=
 =?utf-8?B?anhac0c1ajhwaDJ0V2pvdmJSSEFxYTVLREZoTURmOU03N3FTWG9uZWhISmRq?=
 =?utf-8?B?aU9jQXd5Wmw0QnlkMnNSTmFzUGljTjZTTVh3T3ljOHBJdm5TTkR3YjdKRjJ1?=
 =?utf-8?B?RjdDYSs1ZHUxL3EvMUUzWC92QVcza2RyN0lFWGFYZkdTTHBmbE9rdDNhUW9S?=
 =?utf-8?B?N0l3QXBadGRDZlh0dEF3SUlJVFpvOGEvTTFUSStmcncxa1BNK3dNRVp4WXo3?=
 =?utf-8?B?NGZXbUo3SDNLNGlUemR6TDhCRnFjSUtaaG56WjlZcXNwMnZoSmwyMGZSZGVM?=
 =?utf-8?B?bmVpZlA1UzhNbVVoZlhydWxTclF0ZDVnZUxVSXdyMWc0bmxDZFVuZmFUVldJ?=
 =?utf-8?B?bk5nRmJEUis3eHprTFNwNmw3T3g2bWFwT25NVzhOUDZnNXJ4cXhLTTNpc0lN?=
 =?utf-8?B?U2lLTWp6K1gvMU1oTmpKbUVuWWlQOHVydnRCRXVyK2ZtREVCRG1UbmdPdW5K?=
 =?utf-8?B?VVI2cE5yMW9tOHlTY2N2S0VYWUxWUEpnYmJhSm4zSkFybWh0dlc0YmJHZTJr?=
 =?utf-8?B?L09sQ0lKR3ZqYXJNM1FPZHVvSUJtVkJSdG5KR3crTWRDdVVFZzFOUmpkOFlq?=
 =?utf-8?B?WnZYR24wWXZwc3dLaE52bnVPZEh2c1d5cG9vbC9ZZG83UlprRDkydHRITXhE?=
 =?utf-8?B?T3lFci9zMzZUYmtSOEgwalR1ckx3SUsrcStjOHZOdG1lNkxTKzFPSUROb08z?=
 =?utf-8?B?VTJmUkhZVy9lVFBrdXFPRXp4WHpqako3c2cwZmZ2RzBISWNhcytSUTBTcCtw?=
 =?utf-8?B?RFg2WFpSd2h2aFFWVURMVEhMMjdIU1YwVkNPdUQ2cXFCOE1DdGdJdFYyMGw0?=
 =?utf-8?B?T1kzdkExUjkvRlBDaUNvOFp2SlBCQ3lzd0VLYTBKaHZqbE53NUdNVDFnZTdI?=
 =?utf-8?B?dFdjbVJqSmg3N2FlaWhvVkthN3NFcTkzV05oaGlJYnl5SGZQU2pnajRxVGhC?=
 =?utf-8?B?M1pDZnhuZy9JeTBYZk81YWRQSGdlb1VkNHo3cnBFN1dxRlg2Z29RaVc4VnBm?=
 =?utf-8?B?d2NONkthOFF6ZktoeUkwZm9RS2VldnF1QXZ3TDlrNmROODRwbERUSlplcGFZ?=
 =?utf-8?B?V3l6VDFBa3JqR3lSZTZ3TWxQWmNhSmJTRm9kemVRRmZzNmVXRk1VWmpheGtt?=
 =?utf-8?B?NVliTWQ1ckdZbEVXbmpCVXcrUU42QlpJREViVDNGL2graC9vSEFOaEF6cUFy?=
 =?utf-8?B?dUhMTUhJaFN4dmJXRUpNZHR4ZzF6MVdwNXZlaThSbHlFbGk4amJ2elNkSU9q?=
 =?utf-8?B?WkJmWEZ2bXNzb2tReTVjTGdhWlJVK3VJbStleStCUURhUnR3ZitpamtXbGhK?=
 =?utf-8?B?cG9WN1piWlk3OVZEOFFkQ29XRmJvL1BaYytYQUV6bi85NWt2S09kYytuUGJG?=
 =?utf-8?B?Z08vOC9oYVpUUFQ0SjdSUnBwYXVRc2phMDhycnZSSmVFVDFDUkYwQmxNOTJO?=
 =?utf-8?B?U1ZldnNoMERHWTZoOEF2Z1REZ2RpN2dTK1poZnlBMENycUJKZlVuaTZRT01h?=
 =?utf-8?B?eWlGb1JFUzJhTUdWZ0xiRkdvTm1nZ3owLzlPakhkWnVTTjN5VEduVlJudzIw?=
 =?utf-8?B?cS9ENHlhUG5jdFNKdGgxZDVLTmhYRzZxZGpvSGw5allWZzFrRi8zaXdwSlRN?=
 =?utf-8?Q?EqF8oftyjp8yjpz8I/3OrsRFD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8731b4d-5173-4892-41b1-08dc2e47c7e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 17:01:41.0287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rywpDndgPs7ZT66vOgjAnQ9iTEAclMTd22GKNTMDQkDS3VKE9qjmaFgv3JpxAlt7phWUt++/fH98Vb2QSA92MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4124
X-Proofpoint-ORIG-GUID: U71I42mEfazO2QOaaM-uh90oaMMPXmh6
X-Proofpoint-GUID: U71I42mEfazO2QOaaM-uh90oaMMPXmh6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_16,2024-02-14_01,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAxNSwgMjAy
NCA2OjUxIFBNDQo+IFRvOiBFbGFkIE5hY2htYW4gPGVuYWNobWFuQG1hcnZlbGwuY29tPg0KPiBD
YzogaHV6aWppQG1hcnZlbGwuY29tOyBhZHJpYW4uaHVudGVyQGludGVsLmNvbTsgbGludXgtDQo+
IG1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogW0VYVF0gUmU6IFtQQVRDSCB2MiAwLzJdIEZpeCBQSFkgaW5pdCB0aW1lb3V0IGlzc3Vl
cw0KPiANCj4gRXh0ZXJuYWwgRW1haWwNCj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gT24gVGh1LCAx
NSBGZWIgMjAyNCBhdCAxNzoxNiwgRWxhZCBOYWNobWFuIDxlbmFjaG1hbkBtYXJ2ZWxsLmNvbT4N
Cj4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBFbGFkIE5hY2htYW4gPGVuYWNobWFuQG1hcnZlbGwu
Y29tPg0KPiA+DQo+ID4gRml4IFBIWSBpbml0IHRpbWVvdXQgaXNzdWVzOg0KPiA+DQo+ID4gMS4g
Q2xvY2sgU3RhYmlsaXR5IGlzc3VlIGNhdXNpbmcgUEhZIHRpbWVvdXQNCj4gPg0KPiA+IDIuIFRp
bWVvdXQgdGFraW5nIGxvbmdlciB0aGFuIG5lZWRlZCBvbiBBQzVYLg0KPiA+ICAgIFNvbHZlIGJ5
IGNvbnN0YW50bHkgdGVzdGluZyB0aGUgUEhZIGluaXQgYml0DQo+ID4gICAgdW50aWwgaXQgdG9n
Z2xlcywgYnV0IHVwIHRvIDEwMFggdGltZW91dCBmYWN0b3IuDQo+ID4NCj4gPiB2MjoNCj4gPiAg
ICAgMSkgY29udmVydCBwb2xsaW5nIGxvb3AgdG8gcmVhZF9wb2xsX3RpbWVvdXQoKQ0KPiA+ICAg
ICAgICBmb3IgYm90aCBwYXRjaGVzLg0KPiA+DQo+ID4gRWxhZCBOYWNobWFuICgyKToNCj4gPiAg
IG1tYzogeGVub246IGZpeCBQSFkgaW5pdCBjbG9jayBzdGFiaWxpdHkNCj4gPiAgIG1tYzogeGVu
b246IGFkZCB0aW1lb3V0IGZvciBQSFkgaW5pdCBjb21wbGV0ZQ0KPiA+DQo+ID4gIGRyaXZlcnMv
bW1jL2hvc3Qvc2RoY2kteGVub24tcGh5LmMgfCA0OA0KPiA+ICsrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgOSBkZWxl
dGlvbnMoLSkNCj4gPg0KPiANCj4gVGhlIHNlcmllcyBsb29rcyBnb29kIHRvIG1lLiBBbHRob3Vn
aCwgSSBhc3N1bWUgd2Ugc2hvdWxkIHRhZyB0aGlzIGZvciBzdGFibGUNCj4ga2VybmVscyB0b28g
YW5kIHBvc3NpYmx5IGFkZCBhIGZpeGVzIHRhZz8NCg0KTm8gcHJvYmxlbS4NCg0KPiANCj4gTW9y
ZW92ZXIsIGl0IHdvdWxkIGJlIG5pY2UgdG8gZ2V0IGFuIGFjayBmcm9tIEh1IFppamkuDQoNCkhl
IGRvZXMgbm90IGxvbmdlciB3b3JrIHdpdGggTWFydmVsbCwgc28gdGhpcyBlbWFpbCBpcyBpbnZh
bGlkLCBJIHRyaWVkIGFsc28gdG8gc2VuZCBhbiBlLW1haWwgbWFudWFsbHkgYXMgd2VsbCBhbmQg
Z290Og0KaHV6aWppQG1hcnZlbGwuY29tDQpSZW1vdGUgU2VydmVyIHJldHVybmVkICc1NTAgNS4x
LjEgUkVTT0xWRVIuQURSLlJlY2lwTm90Rm91bmQ7IG5vdCBmb3VuZCcNCg0KQ291bGQgbm90IGxv
Y2F0ZSBoaW0gdmlhIGdvb2dsZSBzZWFyY2ggZWl0aGVyLg0KDQo+IA0KPiBLaW5kIHJlZ2FyZHMN
Cj4gVWZmZQ0K

