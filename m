Return-Path: <linux-kernel+bounces-163901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D888B757B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C23DB22242
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9FE13D268;
	Tue, 30 Apr 2024 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E7QU96gy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xrbABH5e"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717BF13D2BF;
	Tue, 30 Apr 2024 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479096; cv=fail; b=dgAcVrvBVVzNYiOrkZM28GbBeBB24KgEpWVdGVqudtldISvWzhCOFT7Ux+kTw0O1kzLYojH6gtbdJ7gvDImYBhEiZJjyqOrkXcLx7ix2NPG4Txf5Zxvr4NU9BUQvZTh+soZvOK6ePIuQkkljUZnHnspCAVOhkGZhRqVrALwZDGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479096; c=relaxed/simple;
	bh=avZYH/68R8Kcp2ANHc/Y5LDMyIHkSEYpZjstDHJugf0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nvjTirMSTgpUISOjNaoCUeqJ1C4wpNxd6yckZ9ku3DssE3krG6UGQNC0TEkzQWxXlRRY6O870YGEUsCf9R7EbIsiEPck3fGKR50C8uGDgfjj1OcrdWldutA1PZnHiNKDntlK5urTEtu/5twFQpYJsZacPXeUxsZtqfOmB74LwbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E7QU96gy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xrbABH5e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43U1iMNe018306;
	Tue, 30 Apr 2024 12:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=dD8/Jh22CYaPdxO51vrb4HTiGXPEZHKKgJ50KObEEfE=;
 b=E7QU96gyAn7iiCh9h77Q18Gu4iQE93i314h/+lLQSwkP0JMXFuT57vcLoJKob3QV7ItA
 lNkngeaGv6BWLOkWFaqqZ+ASgzXK4pcSz0EZIZdlP58/msrLnEbi9xQs1ngjTmIAZNzX
 2rF3CwN3nNXkhOW26hReJRR9DwEn6fLzR4k+2+83qwqGi21oM605SGzux0ITBKonoKbm
 DvN1huzdwqD1bX2015GUHelHtesk3M1k3vwgtVcWXhvPMykYs3uhqiVUPmiG9uUsew5i
 E/CEILpvWQR7Pqv41CuPI+hNN7lMr6tRQdovWGpuzjZmOIN5tYbJ/ELS6qsYSLdXOHYE OQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr9cmxcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 12:10:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43UBxGgs011467;
	Tue, 30 Apr 2024 12:10:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt7taq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 12:10:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAepQ9zKyBe+3oc1OrrXE15EaUS4nm93qbUkdeUeo63q1IIwveWDJIORLwQUZiy9Ut+vcgpZZJHAWi9IojZ8xu09YTBATp+4tMuo1uux8d1BalFe9bRrgQFf+Ar4f1i8p33q9IfbYVuqppp5swnc8KGhYTJk/8J0nly7bZRqabZxeUcJqvdwEAaZ+22ltbzwO+rd2hB36yBmfnDOcCqDFzW8Zj4qUgsKUxJY+qELP8vNqTqrNoyJoq5fGgUlZRb5B07ugcNacmxNo4K7Zd12EMQivBuFLRWIYXBG/xn81wheJrTSYACItBMBahUVE5KE9NThZjHwD3c/ZZnCI9kqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dD8/Jh22CYaPdxO51vrb4HTiGXPEZHKKgJ50KObEEfE=;
 b=ZWlp6adSNwXmBQTi+lBrmBCeKOZYxE2p3cqqa1MAfzh7oE6iJypgdiwrhFGXHlRo5tAOZetdHhF68koPoscvUQi7gg+f1W0cCUxnNt1TKyIsqbyjsVZoWIfL5MLN3X2Kj2hCTkmLg7C/z7VhbtofsbR0KsJns9Df1sLlqaN0jQ8Z0dyrcKcPyNTNfaMXwiyOFGtLKvQHZFWd++3/PimFipwNpD28PlCSOAbi50ytZZDHCrBaKKV47PeK+DJeR8neYTxgh9tRH6jeie0KkDvEbvo9qE5Qwe73KCrjRMfFCY5Xr1vwCzix9MuW1N+CBu+VbgSMatFXEUUfIqboqjJkBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dD8/Jh22CYaPdxO51vrb4HTiGXPEZHKKgJ50KObEEfE=;
 b=xrbABH5epGXH0xYQEt4WwOUAscVCb06lDjjwFPMwgZgIy7RUPlxapc3n+S7BZiYFzONTVDM5TAfO0+6NBCscm/72W1nWkqVB2WMelPE9bLij3lfHrKSneYOxnYEhr1ytAlMjN1lNZKkUioZtL7X4tPe78bjHHM3g/bmw89QaB/8=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS7PR10MB4830.namprd10.prod.outlook.com (2603:10b6:5:3ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 12:10:56 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 12:10:56 +0000
Message-ID: <c114e341-be56-4e30-9e55-2b08f983c916@oracle.com>
Date: Tue, 30 Apr 2024 17:40:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/107] 5.4.275-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        broonie@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240430103044.655968143@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240430103044.655968143@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS7PR10MB4830:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc080de-fe6f-4a57-bc1d-08dc690e96b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MmhHZ3BYSXIyK0FOSStOR1VJYWZGZ0dic25BWUxWd2t1ZkJMeWVqYllFVm1i?=
 =?utf-8?B?dFErOXdRVDNjaXVqU0g2WE54YXY5dmNGYmhYck5ZeGVELzByeXBGMENaYWM4?=
 =?utf-8?B?RnEvMDNJU2JZVDRjZjJzWnZiaEdobXQ2eVlUdkZVZWpxN3pkSDhJOFVKaVJB?=
 =?utf-8?B?YXduQmRaZ2hUYURJc3FlYnpRZVBOcjBsdDN1Uy9CSHhIMDdNZU9nSEtDRyt4?=
 =?utf-8?B?bFFKR3hBa1ZaSW1VV0lmWkhYRmpML3ZoN2tvTGsxTzdvbkI2N0NDanYwcjhT?=
 =?utf-8?B?aFR6SnlKTnBVV2NUdE9QMmRESEU1Y2dvTXZHamh3ZXRtVmgxQmZQQXpRRXpj?=
 =?utf-8?B?UFZlVW1jRnlYeEZYeVd5R3JEVWJKbnd0V2l5OTFWUkJqQmx5b04rWVVEajMv?=
 =?utf-8?B?MEJ4MDcva3JpeVNxTkZPVUZUV2M2aGtsdmM0bmduUkR1akdwRDdRRmFhSkFH?=
 =?utf-8?B?YitRTzdIVWJzbmd4NG9aZDhUeDVUUy9taW1kcUwxME80ZnpVTG5VdGYzWnlZ?=
 =?utf-8?B?T1pNYTRwS2RRSU93Uys0bDRCRVdnSng5aVlxZU85TUVHbWJ3T3U3ZTRoU1I0?=
 =?utf-8?B?Ti91dDdlbFpONzFmUC9uNmx5NU85VWVtbmF6MVBVbHlHY1l0WU13T25KR09S?=
 =?utf-8?B?enI4K0RmZWlEV3ZyUUFHYnYyRGlXMm1HaGFPKzdVU05yb1Z4NStYS0FMWUVU?=
 =?utf-8?B?NFk2azRDQ2oxb05mbHZpOHlteDlIWmdyNEVXWmhoY3hMRGlBT3RVdHl3aEFw?=
 =?utf-8?B?Ujhqa0kwYUdrMW5XL2VhTmthWnEweGR5dXlFaFdJTFh2TnVJd0V6emlQVXRK?=
 =?utf-8?B?YXl2YXhuZ3NIQWxNWDRTQXRUanAwSE04NFRhVFM3YTJ3VDNEUFhhNnFZb3FZ?=
 =?utf-8?B?ZStNT2tmSTY5NW9iYmxLSFUrUFFJbitDUWZ0UFpoY3kyRFlkcTJEVDhLYlBK?=
 =?utf-8?B?VEx2S0JUSzlPblphYmpTUEladFdtK3pZT3h1YkVVSlg1QU15Zm9tS25EaXJX?=
 =?utf-8?B?T3U3MUJiRktvc2x1S25zSnh0bHBSQ1BvdU1kUlFZakFCTUJocndKVVk5b0RM?=
 =?utf-8?B?YUpTYUp5TVIwTXFSV0FVOUpiaEpJckhYZVNxcmRUL2lNS04wd3FSRHlWTEVj?=
 =?utf-8?B?bUFLaDh1WjVwQ1FwbXBuL1loRWVNNUZuV3p3bkZxTkE3eDdmUndkZWlkUEFK?=
 =?utf-8?B?VEtVdkUreGFGV0dGNW1yaFZkaWpXN3haRFhKb21Kam9SWUprcGVKdEVDY2dJ?=
 =?utf-8?B?VEhFdmlCQlVpdkhYRkRBVzNVOUZQUkpVMlJBY216dkRPZW02ZkFteDBzdkJM?=
 =?utf-8?B?dGY1OE14SDBxMjVJTFE3Tm5TMWQ1MEdvOXczVGdxblZReHZEL2FYSVNwRDFL?=
 =?utf-8?B?VWlaOXNselNSNEt4TW5vQUVPV1FrR0lpTDEybGh5aWw1Ni94Q05HMW5yZEt1?=
 =?utf-8?B?UTllT2s4RWRHL2dpc3JUQWFucEdFWkdoUXpYRHltOWNVajJvcXozblRsZEtD?=
 =?utf-8?B?a1kzTHNuU0IzcXJxSFo2N3FoOG01T2R4bENVYkxJREVaTzhjelRrU2lHWStx?=
 =?utf-8?B?U2QrcjBjS1IrUjFuUkpRRnJkajdWOFY4ZWlBTmtDcStBd0VFRkJQSFFmbXp0?=
 =?utf-8?B?VjkyTmRvYUlzbGNKQWhHYmdCSVY1dndmNXNjQTd5RTVObCtkQW9MaU5mVk1F?=
 =?utf-8?B?VGZFQzhJd0xJNVAwNldEVFNtbGhjOWNNSWVpandwTUJnOHM0azhKRk53PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VXFLRzFjb0tqY0dHS3VMV1QzSVFiR0g0NXJKMFFtOEhsa1doMkx2WGZ1NnJR?=
 =?utf-8?B?TG56ZUJEUVpEYlh2SXFYeU5aQnkrei9qbDhjb2N2TkVoRUJuTWVnT25mQ09G?=
 =?utf-8?B?WWhUa3F0NDMvY0p6SUV0UFNQNVVNdHJudzFIaWZLcjJrQ2NJZ3Rka1QyeUNG?=
 =?utf-8?B?SFBScEwvbmsyV3lXM1UxUk5xM2RTNHh2aVpRWFpsb2ZORlpIcHIvblRoeEUy?=
 =?utf-8?B?TFo1RzBrcWlEVnRlOWtueXFoL3IxV0VRaVY0TlRLOFVSUTdodHJhY00ra2x2?=
 =?utf-8?B?a24rUUpUVjg4Nk5GaWl0L004ZHB3SlRLSGxGdHV4eUwyWEZxT1huZXdKM1pS?=
 =?utf-8?B?UEtjY0xhUVdWN2tYUGI2NUhmNzM5MDdBdVBjcWkySWQ2eEJKVVF2MkR5VVZs?=
 =?utf-8?B?YVA2cWZsdHBxaEpEYjFRaWFEU1BrY3lWWTRTTXdyWmp0Y2wrb3JMeDRxVEtB?=
 =?utf-8?B?c0psRXBEWTNQUFJkdGJOdUlPa3NXUWVZRUgxUVFkSEFqOEh6WXBZS2wxTERX?=
 =?utf-8?B?TitKVlNYMCtFamgrTFpVdHg4SjBxZnJNMFBvYm1ucWRwdGJEZk1VZkROeXQr?=
 =?utf-8?B?K1MzQTVNNGIrZWFVR1BkVko0dXRGVlJUWTdFN3MvUUdnbDhweXpiRUF0bkxU?=
 =?utf-8?B?YlA5NFMxZWJJckRXeUVoSkhGenF6SjUraXVwcnl0Nkg2ZDdGZTdKLzNXdW9r?=
 =?utf-8?B?dTBLYXVMM2tLUnk5anBhcndiRFBOZU5tWDRVTmVzNFY5clZNWm9sTjVyWmYy?=
 =?utf-8?B?SlY0bFlxQ245cGFvVkp4NUtTV09MdUFmQVJpNGIxV2Z4N2E2OG8zdmx4cW41?=
 =?utf-8?B?ZFcxZTZ6TzhzbDBVb2dQS3lLOFVBRmZSUGphcDIwWjBpWlE4Uit4SzlWMC9i?=
 =?utf-8?B?ZForc1I2NkphUDZ3c0RFRDd1TnBIb2I3SkM5N3RBL1NQRGQwR0hWMC82aldh?=
 =?utf-8?B?emJwc0N2ejVnWnVXek01NUlUb3AxN0lOandVdnA0QTJnQjlpczUyZzErY2lO?=
 =?utf-8?B?UEtvdGxYaklBdTg1ZTVXZm1McWxZU2U5dElPY3FKT0pRdmttRUN1aVY0WFpG?=
 =?utf-8?B?ZUtzeG5GdEFZUTFEd1FWTkQxUDhhaWhxdGYxNkxWOXo4aWVCRzBDa2c3WHE3?=
 =?utf-8?B?ZHpaKy8vL2ZUalhEVUpiWml3ZkplelhqUno0aVo4b0g4KzVYUlM3QXRuWUVk?=
 =?utf-8?B?dTlqbXAwM2lWYVJWek50TFMyZnJ2WW5PanBkZWh3V3pOQVVzOHV2T2ZJQTB3?=
 =?utf-8?B?ck5FSTVHZzF3OWJaQktlQ0NZRlBvVkxhYitwQmg3ZjRWOHBVVE5lQyt4Kzhw?=
 =?utf-8?B?R0RGZ3RpS3YyMVpad1VpL3ZBNms1d3NkaC9oclNvTGpXYVc3ZFFSRjZlVWtx?=
 =?utf-8?B?cW5ZajdRU0VVVlJXZysyazRJWjVlaXFLVkxMT1Urd3BlZkFMbVpBdHAwcHp3?=
 =?utf-8?B?c1k4ZmQzSEczYytmSWlraXZzYUNIMCtvRStPTElMSlRoNWptczdmaHRicUlW?=
 =?utf-8?B?akRLaW1hRzlyMm1JWTZBb1hodFNaeElQQXpBdjlnNG1YR09RZjZrd3JGelA4?=
 =?utf-8?B?ZWIvSXV3RGtqb2ZtQ2dyVFVYVzdYR2JYUGh4RTNlbW0vQ1gwKzlqdzBHeGQ3?=
 =?utf-8?B?Rmxvcms2ZXlKRTZKVW5MUjQwNVlhUVZDN2d6M0dYU2xsZldtUEpReXJGV0xW?=
 =?utf-8?B?aHRSN1N4a3ludU9SMkVtaGtIK084WjNEZGNyc29aVG1wNjIzMVUzYjdkSVh6?=
 =?utf-8?B?QjN3eFN1SEE3SDJtaEpXR2k1Q05sZ0NLN0ZHVVp4V0hoVS9BdFFxQXp2WGNv?=
 =?utf-8?B?MjNjYkEzQjF4WUdhd2c5b2tJb1g0b3hRL0RxS0d1M1N4ZTF6a3VqajAxalFV?=
 =?utf-8?B?WklCR2xDZEthU0N0MDg4aWI3NENjcFhWSitEMXk4Nk80TjZSbzBGc3BwV3l6?=
 =?utf-8?B?Q3laWDhSQm8xQktPOTdMT2ZIUS9RbXVrQVNCdW4wTlJiZ1lqeTBMZDFzVSsx?=
 =?utf-8?B?L2tFYkNsdU16U3I0NTBrY0NoZEtXNTcyQXB2ZHlPdDY2bERMWGdkY215azlj?=
 =?utf-8?B?UktLRmZLMnhTN2xyNlNvVkJjWnQxeHhxTDB1S0VJVC9aRzdZUWxKNWQ1RzBY?=
 =?utf-8?B?R29KM3Y5N0xNZEREKzZCK0tER0VObTUxNHFSYUhTTFd5UmRqVnJHS2J1ZC8x?=
 =?utf-8?Q?IvftW1EZSKN5/UH7iizBA5I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	efQ1cudSgWBfpNO8672sqJRGRT8m4sxVv/2/EXhcPQVLrJjCUoIK27Ded0fup8AKjHmkyG7Ba8OENXVe1pwlze5ESej81ndcfIxq986Fc0mGszscyb06r4QS45yldT2aSjhdhDIqjuGKxDT8gt7lkKM16vIjD2gy/qKAft2jH8cs45MvdYHGylZDqEv4G6eY65Eh9IWgZeptbus027Sdr4A6U5wAUShQCXKrshB45B+/SyFirkM/kzLGKGBTHKR55EnM8UWmucWZB6aNQVbYSgChy0Qb6zHunJ0FK4ANYvqxuaf5Mi5VxjE+Rm4PSEXwhgdgpb3STxZktSaV0/H99Np6+zc0zxFitsXG2n7DRwaXVMvJBFWUQgNEGCNPfznF8gbF4OVfK2Y7Ktq2V+T6SgJo40DvWtfoWmljL4ryeNY4tc7OIyY/klZBzV762W8R7+V62jEuofh8jkUHkeSu+614QV5gCl3NUld9x577+2o7CP2Vm/KV11YZUeHkQO3//Y0i2A4ecv+pxEcZLaKUXe3xnphgFDWEkY7n2TAkR8ThhCPP9G2T1vujcRLP+PptCLAE7XswJn0FPbIFKy25Wcd1WW9+AqqLlbtIZU2AG2Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc080de-fe6f-4a57-bc1d-08dc690e96b5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 12:10:56.1763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypGzTROoDMpbBtax0mJu8o5NRkz5eBz29lqo4L5QpvUQtjzK/qW78uWyVLIkSvZK5EeZ1kUgO66Z4l8ZhsjX4FBcasseA39e+H4u00lmdmWHFPS2o818CMXCy/XN2Fo4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300087
X-Proofpoint-GUID: 2f90otgWkrX6ylhwaEXIItwJYVzlKw0l
X-Proofpoint-ORIG-GUID: 2f90otgWkrX6ylhwaEXIItwJYVzlKw0l

Hi Greg,


> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.275-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
..

> Ikjoon Jang <ikjn@chromium.org>
>      arm64: dts: mediatek: mt8183: Add power-domains properity to mfgcfg
> 
BUILDSTDERR: Error: arch/arm64/boot/dts/mediatek/mt8183.dtsi:580.26-27 
syntax error
BUILDSTDERR: FATAL ERROR: Unable to parse input tree
BUILDSTDERR: make[2]: *** [scripts/Makefile.lib:285: 
arch/arm64/boot/dts/mediatek/mt8183-evb.dtb] Error 1
BUILDSTDERR: make[1]: *** [scripts/Makefile.build:497: 
arch/arm64/boot/dts/mediatek] Error 2
BUILDSTDERR: make: *** [Makefile:1290: dtbs] Error 2

aarch64 builds are failing with the above error

Thanks,
Harshit

