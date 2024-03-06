Return-Path: <linux-kernel+bounces-94445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D4E873FE9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDFF1C22066
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF5413E7C1;
	Wed,  6 Mar 2024 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sl3zwUFT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CHXcclTX"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5140E266D4;
	Wed,  6 Mar 2024 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750794; cv=fail; b=JxkhHi+HQRwNNnuPJpcZGHH+e0t7kJUzvAs3su/fLcc+7XjfbxepiqOGW7rjYVHHjHvrH3F1HwTwOEDrbD7dpBXMtziGEdugxzYWb45LhMVUoBDVjklDFqi8f+mBFnQjDeHUfHf5Nb1zm3b2fq28KECURw0L2HZjKn2T3lgjGT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750794; c=relaxed/simple;
	bh=RUlWlw+Ab6+yL2ZqOKGz953WQeIcGj7r9SctYxB01sM=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=S0c6HyQ9eLwneAMvQWebMxrEbTR0CoukY/ex40bZNIMtinDYP2STOnOiYHoakNY3l7r+EN9E/1adEao1DY/Qawl/W+/13rxOjRfV21yoF50h/upHt7ydR3UD44Vsr2P8bPQqyCJxQX/4i2GbAGMRGi8QqHUajMyR9SwXMkkcPjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sl3zwUFT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CHXcclTX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426H4Bvw007374;
	Wed, 6 Mar 2024 18:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=nESQ+IK8ptQj6cfg5qTp06js3I8vbf+gA71oGp9nEOc=;
 b=Sl3zwUFTbvG9dG7ZobmCUMq61F/g6EmUISUk51FvXbplW9pXpUDwwiHI1HszHovRMhC/
 EiXX1yt/cz0gxCMmb8l7D/2YOJwWzBvrXO2DZDTC9P96ZCVcx/3BWs0zmJlJrWxkdizl
 qT5uLs3Emr4qZPatapm45sEvt/ZmipaOE55fpJQF6TFSrRlKTSooa84QoSN6KWZYF4b8
 IaDA7MmZPQpNsubw64mV/Pmyf1AqiFjaSgRB9i6/Rx5Rbv8mWj5TcUP5K4IC81C3tWTM
 gCVwzpI+ftCUWjfV9BZ/O3a+eaM47LAPQ4l/8X4oY84uOWDd9AgACrMLzGulyNffQuzF nQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkuqvhq65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 18:46:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 426IPQ2U005206;
	Wed, 6 Mar 2024 18:46:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wp7nshrdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 18:46:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzcOv2iH/OdjPkSFRt/ZHS3U1sw4qEbxoaamQhFNQhWrJc4koULXfWiHkFywbWCuzpJ1oYF4ZSej87qCPFdm3b8xONoba6pRPAsi6nY3YjKm3shTzhb9vMOvSgCZRImE2Yak8B1Hl+vK/IlXOBDhKUXbR0Eg6bAd3SWl6uWfDbx7UmZtiiv0d83dXb59DoL3jva6KKQ72TMk5w/RyIKmgw6RQjz/xYK9js5HWKrX/eLFf8r/v9G+Z4Y9Np0e8fDANW3okKpLegiv6iSrp+yy2VeqIu8YpfGgB9xfbqX2TyVRrcNv6GrcAnrLb4QPl4dfkuR9+z1f4IdnpLZ68Nw+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nESQ+IK8ptQj6cfg5qTp06js3I8vbf+gA71oGp9nEOc=;
 b=RgeCP3B/G/g0fG+1RUel0zvEjeeAtQnUGuHPOlEoGREODr8CHNZ/NErZc0ZIY0G3gjQqVJ/HTXYr+/pyq3PNFHbpubvnvMz0Mcm6T30xxNbNXI5IzwFy+yEhUmir6mvX57vaWLKglNs4uC7jbvtxV/jamaFd2fNEwHM9YSWT/G6EZVMoXod2hCMNO5BLdbLEANEH/trPAth/5HpIGyDXQ0RgPu1gSZCNC7IlAaujNV/U8Bpx3SFa+2CB6K0QuqdNFMfGlqPfNltHhC9KuNMaGoqQt4/XvcXGlLiAu3IhC0HDu4oj8uy45uFjHMHX2Z+KzKec3w/6qvvNq1X7PYk3oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nESQ+IK8ptQj6cfg5qTp06js3I8vbf+gA71oGp9nEOc=;
 b=CHXcclTXoWxxlMZBo6wklZYxp/9p+wEV7R0s2LuLaJlWPfwBWxCJ4Fw/enm5XKGlNuVnXBzz9KMmeGyOCJUt/T/7rXbkHWa2mQkRWobVDuV40j4iB25992IHfkvSMUcM+PIw6xIr26rACqPkTONStHo5Cfs+sGFSXbxfyKKQ56E=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA2PR10MB4523.namprd10.prod.outlook.com (2603:10b6:806:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 18:46:17 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 18:46:17 +0000
Message-ID: <5ce2ae5d-61e2-4ede-ad55-551112602401@oracle.com>
Date: Thu, 7 Mar 2024 00:16:07 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: zhiguo.niu@unisoc.com, bvanassche@acm.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
        Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
        Paul Webb <paul.x.webb@oracle.com>, nicky.veitch@oracle.com
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [bug-report] Performance regression with fio sequential-write on a
 multipath setup.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:4:7c::32) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA2PR10MB4523:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c57ca40-7e1d-45ce-2b8b-08dc3e0db4d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CtHc7kxejZh9rniNpLKfKAgDB3azezTfpSkJoLrL7Al7jhZFZbUwF4FF6qCD3hJLkKsSzOaNaRqq5bxl1zOz5rEJAfCiLULU9EluV6M696KDm+ix9xwBt+0Lq0BeKTq8CgN2qoC1cCw3qGsirSRd52ddQw3aA79wHmt9Pq8z0YvZcZkUqi8aWbA2z3lryAGK919Z+DSPHviq4+ABCDG+5xtBK5X3W2E44JmZzTb2QWHcOw5L8jg/wF0CEGZKQ38S8rKEmUrxAAVattYsNMsCRfwTyZFLyLMnLrjGUysg1HXLKjDwAXCK7xTAdUs89F1XHQWuCTYUps+NcLYBJzkB5mrwiZ1zMs1bm2qtL4w2osMlSDUOE0DDNnWvq0jMbzxh4nDeVrv+7GJWtwsUXmZgPF+kWeLixUph+FJKT6IzcZoe6FdBK6CLqloQcD71J5bMkDERDnVP60UhxKSgpZenLTH3HIi8RQi9qkqBOnjSXbecxwMipxc6Umu1SOYxjXSZiP1xhofzBJafC6gFoWsjaSZ7sQ4WLFkJrNpsgmnh3Q/YOGNQe1hTGOncLQE7c+aDmxaczKO009RRVM/N13O0YTTq5Dgn9GF3zBY+TD56ItemqalsRfbV8wwrM/nYlceyC8cn+aQOumQ1Hpt3m7ZEDelPNdrLafmqsLGPeo8ZzVg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VzRMRGhZL1ZRMzcrc2kwYXFNK1h0a20xUG1ZU2FRL25EVXNYdUpjaXNsNjZx?=
 =?utf-8?B?WkpXN29rV0VDcUJteVl6cjhzNjhwd0FXZW9ha2ZmalJodWd4dy95WlJJVFdx?=
 =?utf-8?B?TFo3MVUzb1lGS1dadnluQTdjRk9rN3RRdHlBY0VyS3B0L3BJdEpzQTdvQzVB?=
 =?utf-8?B?RFN4S01acUlabEdJTno2VFZXR3BZYllXeUtmeTNoS3hrNW1XSDNwenRERTN1?=
 =?utf-8?B?MThPY1Q5bC9aQStxMkRCSzNubThlMWJWaFVEeE14b1hqSzBmRU5VSGdXMlAr?=
 =?utf-8?B?Sm5tZXg0S0JtQm5YdjVzbk1GZUFIRXRSK2tFbWFoZnFVRHQxczk5b1VHT3VM?=
 =?utf-8?B?V25OVXFMcnZST0lPYWdIaUR1U0YrVmU4ck54eWY4QnhUcGZMaFptZHQ2cU9C?=
 =?utf-8?B?QnF1bGhlSjc2dnUxOGNSTVVEcFNzdHFFZmVWaG1RbEZIRkJNYUh2aUtVV1pL?=
 =?utf-8?B?cGplYnhMWDJQUjlJU2FWZGt5TS96RS9Wc2pzeUNRUTlkTlJ0RGhMMkN1djFu?=
 =?utf-8?B?dHZlK3FvU0d2ZFVrWTZxYnVuNXFNMmpQQkpKVHRUUmpyZ2Q4aU5BeWJjUHZv?=
 =?utf-8?B?VkRQUmlaTWNBOGppdktrd0JYY2V4S0pvSmhiQlBqUE5ydHdwOEJCMUJDM1Fh?=
 =?utf-8?B?elBBZWd2RXpYaUZDWGFiN3BQdWRZNTRkRC8zYjk4cGJoU09WT05ncWkxRG9T?=
 =?utf-8?B?UDByYlgyZzlIVjV0cHgwZnY1WFM2ZVNrMkZuZVRZbzVvMmlXSk5LWmU5Q2ti?=
 =?utf-8?B?dWRsNlJhZmJ4ZHQrYit5SEJKSG90bkkwQjdFcExacE40Mi9aZjBlZXp4aStL?=
 =?utf-8?B?clRJcjcwL3dROTRrTXlUNTJZTnprMGFIUmhKWDVNbklaSUpzamZVT0EwS2Qz?=
 =?utf-8?B?VGFXODJUd08yZHU5SFI5a3N2WGhkWnV3cmpWbTZKM2ZVV3FhV3Jxb2xGRDBl?=
 =?utf-8?B?d3hJVHZzeUYrUzRESnBwa0tXQ0J4S1U3anF3RkVDMjNNdFdrbklmbTJtV1pl?=
 =?utf-8?B?SFBDcG40SlBZUnRMQjZ5N2hUNzNoL0MraWIwTjlIRml1V2FrS2JGU1VSYlV3?=
 =?utf-8?B?SjBMRWpELzIrU0pQM0lwZHpGQjZPTzYxajlDU1Z3MXJVVlpIdzMzOVdQRWlE?=
 =?utf-8?B?SWlCd1Y2SHhkRjk0a1crTVZkakQyMStURjlqamNUVXFTYVZKUmtoTVQ4MmhZ?=
 =?utf-8?B?R2htOGdJVU5XTW9zbDliS1IrTFAyUnF4ODd6SGpITGNUVENMV0ZWSEc4aXM1?=
 =?utf-8?B?WGcwLzh2Y0VOY2p1cjd2bllPL0MvNWxMOXNyUVFGbW5La2l6NXcxVzdIVDR5?=
 =?utf-8?B?OUM2YW44ckhxT2RoMFBlemV0OTRuNTB2OEx1OHJ5MGtlcWhFbVRxVEJGRU5I?=
 =?utf-8?B?c0c1S0RqZGNJclBHRUVCTTZRSjBHQzRJWksxNUd6OXBZTmRzc0h0YVFjSnNP?=
 =?utf-8?B?anNxSlR0QWVaeDI3Q3Z6eW5DMzEwUFY3OG8vTDBWaS9zb2JLRWlicXA1NVY3?=
 =?utf-8?B?QWp2bmNoYmN4T21HVGx5YkVSOEQycmFkbEZpSUwzSGpEY0xMMDBtUm9ONksz?=
 =?utf-8?B?NE0rWGhwVCsvWHZWa3pwMk5OeWtrK3NaK2JGaUc5bWdFbzdXZ01WWTBsem5E?=
 =?utf-8?B?aVQrWVhsN0Jwc0o4RkxFc0VuU2VyUThyQ29COEoyaGVXOE9qekxWR2pJNTNZ?=
 =?utf-8?B?Y3liSjI0ckpHakloblMzMWRHc3JOTC9FR053NDZPSnlZZVhhUUVrM3B3TDh3?=
 =?utf-8?B?WksvcXNqdnpYYnNXNFV4bUhHcjBJUlhNZnVYY1JGbE9tU05uYnVOWjhjdUdJ?=
 =?utf-8?B?TzMvb0JzZHl2Yk9vbWl4ZkgvV0oxL1pYNjVscjkzeG9XV2tOaFZRR1VrSzdw?=
 =?utf-8?B?YUM0Y0NhM1MwZVlkdnp4OXV2bkllblBHblN6QUhPZ0d5QVI5UklpN3dQOEZB?=
 =?utf-8?B?dTh0b1kvZHF1ZlJ0ZkhHdlA4eXNPTmUvaTgyWTJyeUp1Rk5qZ0JsK2RIWXdD?=
 =?utf-8?B?WXlubVJzTmxYeHhGQkVaZ1BRSm8wQzFjT1pzS3dXaGxSRmk3N3djZmE1TlFL?=
 =?utf-8?B?OE1GYm9EQlZCS1hDMjRNd1ptTFVVM1BDZXFvR1RSM1lWU05Wdyt3T0p3cFd2?=
 =?utf-8?B?eUJyMFd5eHpVL0Z2YUE4Y3pOTVBneEQyZ05PNnY2VStqNHN2QmI1dTFlZTZP?=
 =?utf-8?Q?QlFWXUsdnSEULsepJE/VQN4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RR8mGOtrb4kNvwKNBN5ACCYEqMgVh9qOdh9C1rGEr2QgsFya0WtylsKGUPk8dsY+iNZ68yv8fsa33aEt0fj3mjb90CvrbvtYvBb+gAcEBv+qH1qlVCypUL4OhFGvB3vS5UQJfdwIxSxao+G81JZZBr+6T/6TB5BRTqrTIjpV5VG5xWax4oUtjXn/lLiEA8qhDo3uQZoaI8AIzZECEuHBn+KepDPgISImasMZMfcjwlP+EJJ7nMqOdmO/ThbCEl0GqLTQBf/dwgdrz1IDhm/SQBEx/fRQsr1lVzmqzCKmpyQYDccnkKLmHGlH/y7nvR15HpxbTUezopHyxvKGShr8+dOSn8HwRb+1TeP6333GIq6sewWnt3agsAijH19Hikmfv/eCwaim0EoHPf2rMxo/G0cE4hA6QbKBQedgWv2YFx/6ylfNV2ew033tC0SR9Ic6+N/lZCGiLb/F8ixpn1+v0ump1WyW62dp2Pd7y/fm1RIz5O8XfpYKw2IwAn3X1E6QhNt0/m9gPYtaN6fxH/DJ5R5pfFOu8tMMH/8Xpv2E22sSdvK6ryOjNb9TtnWHU/9JGWGjiLy2KjHOx+VBSMK6N7JPxa4vqZDfPX7eMDxm8qg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c57ca40-7e1d-45ce-2b8b-08dc3e0db4d7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 18:46:17.1931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KY9S4KweboTECwAbBr1DBC4MCxFR649s4NjJkY3E5wcVGwC16aft2AYg+w3UuQ9L/N4mwLU88FwhFK5IKFUngvx5ch7XMsay6KnTkpd3IG0lrnxHLYW8EHo+Nl1d1E3v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060152
X-Proofpoint-GUID: vLfEGmKQvwpRCiMRm9IDgk4Qbxv8WIj_
X-Proofpoint-ORIG-GUID: vLfEGmKQvwpRCiMRm9IDgk4Qbxv8WIj_

Hi,

We have noticed a performance regression in kernel with fio sequential 
write job.

Notes and observations:
======================
1. This is observed on recent kernels(6.6) when compared with 5.15.y, 
the bisection points to commit d47f9717e5cf ("block/mq-deadline: use 
correct way to throttling write requests")
2. Reverting the above commit improves the performance.
3. This regression can also be seen on 6.8-rc7 and a revert on top of 
that fixes the regression.
4. The commit looks very much related to the cause of regression.
5. Note that this happens only with multi-path setup even with 2 block 
devices.

Test details:
============
(A) fio.write job

fio-3.19 -- fio version

[global]
ioengine=libaio
rw=write
bs=128k
iodepth=64
numjobs=24
direct=1
fsync=1
runtime=600
group_reporting

[job]
filename=/dev/dm-0
[job]
filename=/dev/dm-1

Each disk is of 600G size.

(B) Test results

6.8-rc7: 2 block devices with multi-path
-------

job: (g=0): rw=write, bs=(R) 128KiB-128KiB, (W) 128KiB-128KiB, (T) 
128KiB-128KiB, ioengine=libaio, iodepth=64
..
job: (g=0): rw=write, bs=(R) 128KiB-128KiB, (W) 128KiB-128KiB, (T) 
128KiB-128KiB, ioengine=libaio, iodepth=64
..
fio-3.19
Starting 48 processes

job: (groupid=0, jobs=48): err= 0: pid=6164: Wed Mar  6 17:58:33 2024
   write: IOPS=1884, BW=236MiB/s (247MB/s)(138GiB/600319msec); 0 zone resets
     slat (usec): min=2, max=540462, avg=25445.35, stdev=24181.85
     clat (msec): min=9, max=4941, avg=1602.56, stdev=339.05
      lat (msec): min=9, max=4973, avg=1628.00, stdev=342.19
     clat percentiles (msec):
      |  1.00th=[  986],  5.00th=[ 1167], 10.00th=[ 1250], 20.00th=[ 1368],
      | 30.00th=[ 1435], 40.00th=[ 1502], 50.00th=[ 1569], 60.00th=[ 1636],
      | 70.00th=[ 1703], 80.00th=[ 1804], 90.00th=[ 1955], 95.00th=[ 2140],
      | 99.00th=[ 2869], 99.50th=[ 3239], 99.90th=[ 3842], 99.95th=[ 4010],
      | 99.99th=[ 4329]
    bw (  KiB/s): min=47229, max=516492, per=100.00%, avg=241546.47, 
stdev=1326.92, samples=57259
    iops        : min=  322, max= 3996, avg=1843.17, stdev=10.39, 
samples=57259
   lat (msec)   : 10=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=0.02%
   lat (msec)   : 500=0.06%, 750=0.14%, 1000=0.93%, 2000=90.41%, 
 >=2000=8.42%
   fsync/fdatasync/sync_file_range:
     sync (nsec): min=10, max=57940, avg=104.23, stdev=498.86
     sync percentiles (nsec):
      |  1.00th=[   13],  5.00th=[   19], 10.00th=[   26], 20.00th=[   61],
      | 30.00th=[   68], 40.00th=[   72], 50.00th=[   75], 60.00th=[   78],
      | 70.00th=[   87], 80.00th=[  167], 90.00th=[  175], 95.00th=[  177],
      | 99.00th=[  221], 99.50th=[  231], 99.90th=[  318], 99.95th=[15680],
      | 99.99th=[17792]
   cpu          : usr=0.08%, sys=0.16%, ctx=1096948, majf=0, minf=1995
   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, 
 >=64=199.5%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, 
 >=64=0.0%
      issued rwts: total=0,1131018,0,1127994 short=0,0,0,0 dropped=0,0,0,0
      latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   WRITE: bw=236MiB/s (247MB/s), 236MiB/s-236MiB/s (247MB/s-247MB/s), 
io=138GiB (148GB), run=600319-600319msec

Disk stats (read/write):
     dm-0: ios=50/533034, merge=0/27056, ticks=16/113070163, 
in_queue=113070180, util=100.00%, aggrios=43/266595, aggrmerge=0/0, 
aggrticks=156/56542549, aggrin_queue=56542706, aggrutil=100.00%
   sdac: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
   sde: ios=86/533191, merge=0/0, ticks=313/113085099, 
in_queue=113085413, util=100.00%
     dm-1: ios=5/534381, merge=0/36389, ticks=240/113110344, 
in_queue=113110584, util=100.00%, aggrios=7/267191, aggrmerge=0/0, 
aggrticks=153/56543654, aggrin_queue=56543807, aggrutil=100.00%
   sdf: ios=14/534382, merge=0/0, ticks=306/113087308, 
in_queue=113087615, util=100.00%
   sdad: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%

Throughput Results:
WRITE:247:1884:0


6.8-rc7+ Revert : 2 block devices with multi-path
-------

job: (g=0): rw=write, bs=(R) 128KiB-128KiB, (W) 128KiB-128KiB, (T) 
128KiB-128KiB, ioengine=libaio, iodepth=64
..
job: (g=0): rw=write, bs=(R) 128KiB-128KiB, (W) 128KiB-128KiB, (T) 
128KiB-128KiB, ioengine=libaio, iodepth=64
..
fio-3.19
Starting 48 processes

job: (groupid=0, jobs=48): err= 0: pid=6104: Wed Mar  6 18:29:13 2024
   write: IOPS=2518, BW=315MiB/s (330MB/s)(185GiB/600339msec); 0 zone resets
     slat (usec): min=2, max=923472, avg=6789.22, stdev=20329.20
     clat (msec): min=4, max=6020, avg=1212.68, stdev=714.90
      lat (msec): min=4, max=6020, avg=1219.47, stdev=718.40
     clat percentiles (msec):
      |  1.00th=[  203],  5.00th=[  309], 10.00th=[  384], 20.00th=[  535],
      | 30.00th=[  709], 40.00th=[  911], 50.00th=[ 1133], 60.00th=[ 1334],
      | 70.00th=[ 1519], 80.00th=[ 1754], 90.00th=[ 2198], 95.00th=[ 2601],
      | 99.00th=[ 3171], 99.50th=[ 3608], 99.90th=[ 4329], 99.95th=[ 4597],
      | 99.99th=[ 5134]
    bw (  KiB/s): min=12237, max=1834896, per=100.00%, avg=413187.52, 
stdev=6322.04, samples=44948
    iops        : min=   48, max=14314, avg=3186.68, stdev=49.49, 
samples=44948
   lat (msec)   : 10=0.01%, 20=0.01%, 50=0.09%, 100=0.02%, 250=2.28%
   lat (msec)   : 500=15.45%, 750=14.26%, 1000=11.83%, 2000=42.52%, 
 >=2000=13.55%
   fsync/fdatasync/sync_file_range:
     sync (nsec): min=10, max=76066, avg=57.85, stdev=299.52
     sync percentiles (nsec):
      |  1.00th=[   13],  5.00th=[   14], 10.00th=[   15], 20.00th=[   16],
      | 30.00th=[   17], 40.00th=[   20], 50.00th=[   28], 60.00th=[   47],
      | 70.00th=[   65], 80.00th=[   80], 90.00th=[  103], 95.00th=[  175],
      | 99.00th=[  237], 99.50th=[  241], 99.90th=[  262], 99.95th=[  318],
      | 99.99th=[16512]
   cpu          : usr=0.06%, sys=0.07%, ctx=531434, majf=0, minf=728
   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, 
 >=64=199.6%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, 
 >=64=0.0%
      issued rwts: total=0,1511918,0,1508894 short=0,0,0,0 dropped=0,0,0,0
      latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   WRITE: bw=315MiB/s (330MB/s), 315MiB/s-315MiB/s (330MB/s-330MB/s), 
io=185GiB (198GB), run=600339-600339msec

Disk stats (read/write):
     dm-0: ios=0/246318, merge=0/493981, ticks=0/142584585, 
in_queue=142584586, util=99.17%, aggrios=6/181454, aggrmerge=0/0, 
aggrticks=112/70608689, aggrin_queue=70608801, aggrutil=84.92%
   sdac: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
   sde: ios=12/362908, merge=0/0, ticks=224/141217379, 
in_queue=141217603, util=84.92%
     dm-1: ios=0/233211, merge=0/538097, ticks=0/142579042, 
in_queue=142579043, util=99.15%, aggrios=8/174475, aggrmerge=0/0, 
aggrticks=128/70654686, aggrin_queue=70654814, aggrutil=85.20%
   sdf: ios=16/348951, merge=0/0, ticks=256/141309372, 
in_queue=141309628, util=85.20%
   sdad: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%

Throughput Results:
WRITE:330:2518:0

(C) performance difference:

That is roughly a 33.65% performance change, this is reproducible on 
higher number of block devices as well.



Thanks to Paul Webb for identifying this regression and sharing the details.
We will be happy to test any patches to check the change in performance 
and also follow any suggestions.


Thanks,
Harshit

