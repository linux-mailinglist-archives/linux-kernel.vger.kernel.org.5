Return-Path: <linux-kernel+bounces-130105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF8C897421
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A691F26A22
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7197114A0B8;
	Wed,  3 Apr 2024 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BpRGfbZj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3514A081;
	Wed,  3 Apr 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158648; cv=fail; b=rdTzuZBcWp8YORJxtolHxANR4QkzWoIkepog4lwq5Kwen8ymEiyYYF0Df7ul26enIOf/M1yb0f6GlG3iVX6ujBRlqe8Op/nLtFwiJWZkB1hL3uy8CXBMQducFQxrY2J+lpIJceO996viJ1FfCWebm8vMQVUcEPSuuzFwd7nHKY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158648; c=relaxed/simple;
	bh=hL8y/cPTiXjL8Rc/io9aan7fTsDhyrNDyXq7DLyhIbY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s2zDoR0rlxWWleT1BtY3b/tsCj29qU0PMY/fCmsWQjkzLQXHi5lNI1Xee7ucfib+cgAzLlbBCXbPLCpRqSLf1sFIPbZ+qmqy0ysHLzYjdRnHkaC7gY7Pq333GcqX7ALsrgumfjAIR1q8qRtHtTHccop/PnLPGNoQxwOyNugAiVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BpRGfbZj; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433CLKwK017334;
	Wed, 3 Apr 2024 15:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=hL8y/cPTiXjL8Rc/io9aan7fTsDhyrNDyXq7DLyhIbY=; b=Bp
	RGfbZjMHsK0Ig96UqKG1zS8RmrmZRmcs1+3rNTAtammkHZHH+KBQEGp0qTEoshZO
	Gx/KQsISunHPW85RNzqztMR1kcb9QBbfFP4tU7PfIy41jq5XykeEGKUG16z6xUnc
	8ZMmAHVS2oXioIlM7cGrgcDWB33RXe1LLqrIx+iNPykC5f6PQHfteFXV8nMjUrMg
	kYI8SkQWaX/rGb2O+nv8QT0CDTht6ppWXUpFEIGazeGfICw92VA/RrNOGlrqw70x
	v28wFjjuGSB+h/Y8vtF2jGE4ttZGsRtkCAK3oEjEXXifyXu1JX63MEiaml9alnTp
	+OWUZQjUsJNsY8yRzEjw==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9077hh43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 15:37:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqNyivOQ72zk5Js/JiEWOxg4tYd0lQc9jay7yrumnxKrQaiEY64RHUICUylwQPBonC+enkpu3BuYgaNlZxSGA3wpxd8hQnGdn3XIATmUuK+8C2FS4blNSl5rcdHjt08Kc90HLAnW9C56d1OCXVXJUoR+z8r6RE1s54mwyywHEAgIVVadql5luOjHV283HAoXazaRtzXSb4B4QdP0KvBzxKzCkoU+BuQvKGMC1hP9kVimXGJHmCvQ/w84Swgvf/MT6gZ/I27dPRKV8g/qrGmGbfuTnNgweiQ3mfuKNzTSJMgQwXW6e+C+Vli4/W9/0McxwqRM1XVosywkj4vywG5MQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hL8y/cPTiXjL8Rc/io9aan7fTsDhyrNDyXq7DLyhIbY=;
 b=h5F4r+JAP4wjcC9bxp2gGe7VK5M60D7qtVHHsrZ2mpOELdHKuKLgACSevA16K4SAC1GU5aK+661SZ7tGHCYsETfauKkqf4zR03a6t8d5Wmc99Yh9VrWmqVJYt5Dunk7Ia7A/dEEKYUymK0kMIyvhs68ZE+8FkqOIZB16YokanI/aT4rfYp9TLLr8Jk1vTlyskrZxpvitDig7IB23pr+T83pOKd6cR3/zvnErSjECDxzMmPji05D+Mi362XHIgv/S8EuohkLi22JrpfwwhRySUWdNr3WuvPtapgK0LwFYpdtnpU9fNAhB4HNqusQbt/u6o06mhIVvr2ZK0OUSzXE2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by CH2PR02MB7032.namprd02.prod.outlook.com
 (2603:10b6:610:81::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 15:37:17 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 15:37:17 +0000
From: Brian Cain <bcain@quicinc.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
CC: "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        Arnd
 Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] hexagon: Don't select GENERIC_IOMAP without
 HAS_IOPORT support
Thread-Topic: [PATCH 1/1] hexagon: Don't select GENERIC_IOMAP without
 HAS_IOPORT support
Thread-Index: AQHahcpVFLymayp/+ESCyghLOHlzDbFWoRoggAAItICAAAGzYA==
Date: Wed, 3 Apr 2024 15:37:17 +0000
Message-ID: 
 <CH3PR02MB10247A45A17F7D8104D1922A8B83D2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240403132447.719833-1-schnelle@linux.ibm.com>
	 <20240403132447.719833-2-schnelle@linux.ibm.com>
	 <CH3PR02MB10247296630FC062F4E3DE2FDB83D2@CH3PR02MB10247.namprd02.prod.outlook.com>
 <c04ed601dbd0a8053e034fef1c05ce2ca6e95392.camel@linux.ibm.com>
In-Reply-To: <c04ed601dbd0a8053e034fef1c05ce2ca6e95392.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|CH2PR02MB7032:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 04lM2rGzo+q2RPt1e7uFxyXfhd/Mc9ww5V8Vpl9V/fxAXJ2nwCq+7IA30RkoVMdla0vpQNxkvgHw4YBCnvhaTVV6bSC/+vsh4e1rvtwC6aWI8mY9EGLjN1YZXKYvqGkfF01O1J1pnSX6WSnG7LAw3CxlF48fUHBe30orKwTQkae9RXT9tWXNj2h/A8l1LnWwEnYkXrwagLFIyPEq4c9Mh/3if1nLBm2QHTVbuUFG25JG53RtmWffRzVLHhrjnf2sdEX/Za983Omb1RXSceYRHo8t4PmzCOPyQdx7ml7kVyCx7F8PWM47qOg3toX9Jk9uJEiuAUeDqKfcYhgIkhpeDcHANZKak7ZF+vhpGZYfNy8s6Bag6bA73e8ip1XnRnaUuddNmtkKdZTXuyxDnuXi0Nz2+ktP3TZap6e0ET0/I/Z/x4V1Gd2h+HjVTSBIdpZM1BUi3IJLcLS5sKbf/SwaT/ho/qJWhf02nrXr4uyjRKn2pYS2sZWfNBXRJkgXUqpMXO6kGGCe54LdWx3qFnrNW6jdjelLMbvjMOMw4j4cF6HxxS9BfPS95tSQQf/lZ2Qkb6nhVIPnhn2b3H360OgAQU1HcD/AE32mD98AOW9kq5pAO1Ku8jt7IsSzu0WmRkOPmEEfzKZix8VB85WQ6d56qjHhessI2vejtwlt8K3pduI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR02MB10247.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Tk9GVlJleldYbmJFTXY3VDlMYW5WMzNUQy90MUhuUDVOMENWa1M2VW9MdDF5?=
 =?utf-8?B?VkJ4THE1aHJUNFJ1d29CWEs5bENOQmtZSHg5bzFDUzRCUmt1SUJCRDVVd2U2?=
 =?utf-8?B?Tm5FRit2a3J0cm1HSlNlTURIZGc2UlZ3NjFITldTY0NnRFVWeDlEZkdMeEFF?=
 =?utf-8?B?bHlKSGl2YTJPdXN3dEtNM0V5TFJBMVJlVHlMMDNwL25mTTQ1bGVLNDJuRy9i?=
 =?utf-8?B?Zjl5aFBvcXowZDRodm5OQXZwOWZaQnJaMlRsTkpraE5KaVgyN055ZGoxbGwy?=
 =?utf-8?B?Q3JpWjRYZEpPK3I2c3c1MGxrY0lmZ3dvK1pPWmlveVEyUVRyb1VtV05BVXBP?=
 =?utf-8?B?K21JT1hWRVBxbWxOK0lFZW0zRW41ai9malVrdTFsa1dpcENFR2FCaU4ydzVR?=
 =?utf-8?B?N1Q0eHpQSVhhWmg0U0EzcFd2RFZoUGE0WktJOXdHUThUUkgzNXpXSHV4aFAy?=
 =?utf-8?B?QW1kempOUThkZWN5WjM1RXUwM1lXc2xtQlA1QlE0RXdXcnk5cnpwVTJNcTAy?=
 =?utf-8?B?SWdCZTh5bkdZZzFObmdBKzQ5T2NNTGF2RXkxUExyZWNyOS85dEV1c1JDZ3Yv?=
 =?utf-8?B?OEdZbDFyNjVEUVBiV0h0SVhqaFRId1piTlBBZmpEN2pMa2VmYXZzNFlYYy9U?=
 =?utf-8?B?d2JHUnFRckJ5SGlzNGE0ckxxbDNOTmphOStwekFBNGRhbGZxRDNra3U5NHlt?=
 =?utf-8?B?NldpY3pIS0hTdWkrVlB4b2tCM2k2UlF5bmVFbFY1Tk4xTUNRZEhRMWhhUzBR?=
 =?utf-8?B?VW1pT2ZJVU5OZU8zQTRHTCtIVzVQeUhpWk85QytrUTByUjVXK3JFQjhNckVo?=
 =?utf-8?B?V1A0ZEd5RUpFK3pjNnZ2bUFiWEtLSk5Xb1ZSbURsV3JQajRVcm51TkhseGpv?=
 =?utf-8?B?cGE0QmFhaFV6b2xiNC8rRFBmbjBIYXJkNkc2OEpDUFVsNDNNdERPNkVhSlp5?=
 =?utf-8?B?UUhnbU01aDdYOVlMMXkwTmZDa05ENHh3TjlER0YxdVdabDJqRURIMmQ2blhQ?=
 =?utf-8?B?WUh3NkV1VHJybXhwUzR0ZVBrc2k4Rk5qZVNvRUdwU2xPRXZOWmYxMVNvRExU?=
 =?utf-8?B?ZHpXaG8ydlpLWkRDWXFUUEJ6dTJaSHg5TmMybDhhTzNJUFZlb3pudnh4dmNO?=
 =?utf-8?B?WDM0Qll1RTJtRC9iRzVvd1VabWRSdlp6aU5lTytYc0EwNXBGaStpUEV2amlx?=
 =?utf-8?B?emVMcUF1bXhhdWZvdlM5SXZsK0RtdlkvT2UrUFU4ckx2TkloRTV2a0lsYW1r?=
 =?utf-8?B?WHVUcG80RzE3TGpWMlQxcnZ4ZE45M0JSeCtJblZ2c0c1Q1pGRnprR3I4L254?=
 =?utf-8?B?dExUcXAxcUZNTGk3QndWNzJscEVxOVdvUk5VWDBEQjdkOE1HODVZaTdhR3lH?=
 =?utf-8?B?ajRyVm14NFZXdGdRUzVORHVvME1VbjEvQlc4bFNTZkF0TlNySjRXdWIyZG1F?=
 =?utf-8?B?Z2FPc2dYTUx6Z25EWUFHUjRJR0tHMzJlUDNNVEw1VFBSWWJhK0FJZUJ2cTFU?=
 =?utf-8?B?SHpLQm15QmFPRElCNUNGUWZFZ2dQTm9jQndKd0QwTDdJcFUwM2tCWTdwMGpZ?=
 =?utf-8?B?b2NKb1pzR2liUnNpK3pnTXJ0UFVSa1dnbnBuYmNiR2p3NXlMZU9McUVaaEY2?=
 =?utf-8?B?azE3Tkhraks3WkxaVW1oYXFTZ0NSYmhvT1E2a0xqdzFNdWcwbi92bjVRcEta?=
 =?utf-8?B?MWdEVW1HL0dQSDdGcUE2UHMrV2ZSQ2ZGNUcxeUV2cDl0OHVqaEgvaXdMUG9u?=
 =?utf-8?B?bFpQMEZVM1VJQlJtamJxUkFFV1U5WTZsT056MnFaZSsxZFFFU0JjSnp0b2xL?=
 =?utf-8?B?UVl2UFhnQ29qbDNNcWJEUHk5MEdtRlNzdXJYb2VUWkUweGpDYmhvOGhYQVRO?=
 =?utf-8?B?VnhGUWtXbjhsRE1PSzNGcE94aXJqcUhHY1ZNWHA0cnEya0wzQmNZVDhzc0kz?=
 =?utf-8?B?cEFac3RqNG55YU5DZFFHRnl5cVpPTldlRnpia0RyUmtpMVE2KzZabkh5RGxt?=
 =?utf-8?B?N0VpRlAyZkswaFFqSEcyYy8yOHRDRVVudHR4SVpUQjhsQWVhdkxqZk1PQjlC?=
 =?utf-8?B?aDZsSTBiUDBXNEJVOWZyK08wYUc2ajlGZG5IVlRKclRGbXJXSmJwY3N6QUNz?=
 =?utf-8?Q?ZTMA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OJB2WgT0ZN/I4whvHLeYt9fdfAXmS01Hq3+cPwGwffZ464LnYN6/5nf4EunQvMUb+SjHX32lqdNPFwgFWX7k3pI7a5AEPn+awjZwGIL5NlusF6SZ3O8j4Ig7O/nqNhWtZGcx8itxJWo3xDyP20Cn/Ic2iCiC5kxenfy0IwuDhy8yJNSYX2JMoDgAhFrp62dgCLsTXitFv+p80Cc0irTzomHamh/ENFyDisydSTk823dOhd40QMpPw9eSrT/YItw92B5/mOqTYWKUeu0I6H5Jg2ZLbi2YCxCAWSR1BC5GQRtInTADHbZwxiB8GdC/9diTlheOacaPIebuiibIDuI5QS/68AqsVmDr0TC9KF4x16fW2oBu0wo469BBkT+//5vCTij3qDJmC2j96/3xDnhCuRPh4dMShOR3zHpF8YNITG/k7nNpqY7eJ+wnhJYg9AA4iimaIZul35dK6MzWEm+VIemrX46yKb+Eh6BZ+MrC2552De3eIh3V3P+VdQsdvd+FaJt90RtyF2ssJpkqNgp3KrVBFe2hfwoI73x/K2iTZpZVXiJTy5XFyOZV3DJuepzVMXed3/h+Tl3EeBxJd8o/DoXggsZoBiiBNuifboLR2yCqcts2PpwOjdwBWKriR2E+
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb7f3b9-884f-480f-6fb2-08dc53f3f181
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 15:37:17.3165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGamPuN23B7uXp3RQps2O2UcQIN+1gAuhauI+I5rqg/GlvVM5xCeivV06vJKcQVpnwN+UgUKdJx2kHchHTxdag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7032
X-Proofpoint-GUID: I52K3lfKoFevMwyK9RsjxpAAazgUvlJi
X-Proofpoint-ORIG-GUID: I52K3lfKoFevMwyK9RsjxpAAazgUvlJi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_15,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=565
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030105

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmlrbGFzIFNjaG5lbGxl
IDxzY2huZWxsZUBsaW51eC5pYm0uY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDMsIDIw
MjQgMTA6MjIgQU0NCj4gVG86IEJyaWFuIENhaW4gPGJjYWluQHF1aWNpbmMuY29tPg0KPiBDYzog
bGludXgtaGV4YWdvbkB2Z2VyLmtlcm5lbC5vcmc7IEFybmQgQmVyZ21hbm4gPGFybmRAa2VybmVs
Lm9yZz47DQo+IEhlaWtvIENhcnN0ZW5zIDxoY2FAbGludXguaWJtLmNvbT47IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIGhleGFnb246IERv
bid0IHNlbGVjdCBHRU5FUklDX0lPTUFQIHdpdGhvdXQNCj4gSEFTX0lPUE9SVCBzdXBwb3J0DQo+
IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxj
b21tLiBQbGVhc2UgYmUgd2FyeQ0KPiBvZiBhbnkgbGlua3Mgb3IgYXR0YWNobWVudHMsIGFuZCBk
byBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+IE9uIFdlZCwgMjAyNC0wNC0wMyBhdCAxNDo1MSAr
MDAwMCwgQnJpYW4gQ2FpbiB3cm90ZToNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiA+IEZyb206IE5pa2xhcyBTY2huZWxsZSA8c2NobmVsbGVAbGludXguaWJtLmNv
bT4NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMywgMjAyNCA4OjI1IEFNDQo+ID4gPiBU
bzogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+ID4gPiBDYzogbGludXgtaGV4YWdv
bkB2Z2VyLmtlcm5lbC5vcmc7IEFybmQgQmVyZ21hbm4gPGFybmRAa2VybmVsLm9yZz47DQo+ID4g
PiBIZWlrbyBDYXJzdGVucyA8aGNhQGxpbnV4LmlibS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBOaWtsYXMNCj4gPiA+IFNjaG5lbGxlIDxzY2huZWxsZUBsaW51eC5pYm0u
Y29tPg0KPiA+ID4gU3ViamVjdDogW1BBVENIIDEvMV0gaGV4YWdvbjogRG9uJ3Qgc2VsZWN0IEdF
TkVSSUNfSU9NQVAgd2l0aG91dA0KPiA+ID4gSEFTX0lPUE9SVCBzdXBwb3J0DQo+ID4gPg0KPiA+
ID4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29t
bS4gUGxlYXNlIGJlDQo+IHdhcnkNCj4gPiA+IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywg
YW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPiA+ID4NCj4gPiA+IEluIGEgZnV0dXJlIHBhdGNo
IEhBU19JT1BPUlQ9biB3aWxsIGRpc2FibGUgaW5iKCkvb3V0YigpIGFuZCBmcmllbmRzIGF0DQo+
ID4gPiBjb21waWxlIHRpbWUuIEFzIGhleGFnb24gZG9lcyBub3Qgc3VwcG9ydCBJL08gcG9ydCBh
Y2Nlc3MgaXQgYWxzbw0KPiA+ID4gdGhlIEdFTkVSSUNfSU9NQVAgbWVjaGFuaXNtIG9mIGR5bmFt
aWNhbGx5IGNob29zaW5nIGJldHdlZW4gSS9PDQo+IHBvcnQNCj4gPiA+IGFuZA0KPiA+ID4gTU1J
TyBhY2Nlc3MgZG9lc24ndCB3b3JrIHNvIGRvbid0IHNlbGVjdCBpdC4NCj4gPiA+DQo+ID4gPiBD
by1kZXZlbG9wZWQtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAa2VybmVsLm9yZz4NCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAa2VybmVsLm9yZz4NCj4gPiA+IFNpZ25l
ZC1vZmYtYnk6IE5pa2xhcyBTY2huZWxsZSA8c2NobmVsbGVAbGludXguaWJtLmNvbT4NCj4gPiA+
IC0tLQ0KPiA+ID4gIGFyY2gvaGV4YWdvbi9LY29uZmlnIHwgMSAtDQo+ID4gPiAgMSBmaWxlIGNo
YW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9oZXhh
Z29uL0tjb25maWcgYi9hcmNoL2hleGFnb24vS2NvbmZpZw0KPiA+ID4gaW5kZXggZTIzM2I1ZWZh
Mjc2Li41ZWExYmY0YjdkNGYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9hcmNoL2hleGFnb24vS2NvbmZp
Zw0KPiA+ID4gKysrIGIvYXJjaC9oZXhhZ29uL0tjb25maWcNCj4gPiA+IEBAIC0zMSw3ICszMSw2
IEBAIGNvbmZpZyBIRVhBR09ODQo+ID4gPiAgICAgICAgIHNlbGVjdCBIQVZFX0FSQ0hfVFJBQ0VI
T09LDQo+ID4gPiAgICAgICAgIHNlbGVjdCBORUVEX1NHX0RNQV9MRU5HVEgNCj4gPiA+ICAgICAg
ICAgc2VsZWN0IE5PX0lPUE9SVF9NQVANCj4gPiA+IC0gICAgICAgc2VsZWN0IEdFTkVSSUNfSU9N
QVANCj4gPiA+ICAgICAgICAgc2VsZWN0IEdFTkVSSUNfSU9SRU1BUA0KPiA+ID4gICAgICAgICBz
ZWxlY3QgR0VORVJJQ19TTVBfSURMRV9USFJFQUQNCj4gPiA+ICAgICAgICAgc2VsZWN0IFNUQUNL
VFJBQ0VfU1VQUE9SVA0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IEJyaWFuIENhaW4gPGJjYWluQHF1
aWNpbmMuY29tPg0KPiA+DQo+IA0KPiBUaGFua3MgZm9yIHRoZSBSLWIsIHdoaWNoIHRyZWUgc2hv
dWxkIHRha2UgdGhpcz8gSWYgeW91IGhhdmUgb3RoZXINCj4gaGV4YWdvbiBjaGFuZ2VzIGZvciB2
Ni4xMCBJIHRoaW5rIGl0IHdvdWxkIGJlIGVhc2llc3QgdG8gdGFrZSB0aGlzDQo+IHRvZ2V0aGVy
IHdpdGggdGhvc2UuIEFzIG1lbnRpb25lZCBpbiB0aGUgY292ZXIgbGV0dGVyIHRoZSBwZXItc3Vi
c3lzdGVtDQoNCkkgZG9uJ3QgaGF2ZSBvdGhlciBjaGFuZ2VzIHBsYW5uZWQgZm9yIHY2LjEwIGJ1
dCBJJ20gaGFwcHkgdG8gdGFrZSB0aGUgY2hhbmdlIGluIG15IHRyZWUuDQoNCj4gY2hhbmdlcyBh
cmUgYWxsIGluZGVwZW5kZW50IHVudGlsIEhBU19JT1BPUlQ9biBhY3R1YWxseSBkaXNhYmxlcw0K
PiBpbmIoKS9vdXRiKCkgd2hpY2ggQXJuZCB3aWxsIHRha2Ugb25jZSBhbGwgdGhlIHN1YnN5c3Rl
bXMgYXJlIGNvdmVyZWQuDQo+IA0KPiBUaGFua3MsDQo+IE5pa2xhcw0K

