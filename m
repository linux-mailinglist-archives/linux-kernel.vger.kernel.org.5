Return-Path: <linux-kernel+bounces-95289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DCC874BD1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E74B2313C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC92128818;
	Thu,  7 Mar 2024 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="myY1t07F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GB2Ju8P4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59C412C540;
	Thu,  7 Mar 2024 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805699; cv=fail; b=E4er35sGNXpXBOaM3WIepQPwsUvz4bzB9aQdMc8lWWOVKz3bOiyl68R5HWRPgplYfzTy+o1OrJtv5Hew9dBMjSs0E+qJ/ERKdGe14q9dFKgYAH0Pp/b7ml6+3J4gXH4kmEpev20xcfaRiz7lNF18xYMgKLXmXptrdYhBNQkgSeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805699; c=relaxed/simple;
	bh=Is1R85aaSvLKtqIHSlj3hFCJ1Hk6I0Zzb9jC+ieCowM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q8nF2MjvwkjUDhf6rdGjjrwpHzEaVTnG/spWHJX98QrUjpoCd6sqQt6kGoj6T6XSlh77ddb/iYk22UyR2RDn1S6tjKCutczfH35ce7EsJlwaeJUmBpd9aDLXJQbbB2TCFj8G97g9twmn8340bbzd3XkFbqSmD/lrcW5Nqz6eayQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=myY1t07F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GB2Ju8P4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279ncOD020816;
	Thu, 7 Mar 2024 10:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VtR3Q/MVGnhQxi/mUggT5FfHwgK485NZMov4uNaHEoo=;
 b=myY1t07FiOziF+nqG4qJ7YRXLtpsQC7WM/Mr3w82OjMjSnL465fAKJcrTpXDzGEONjoE
 nLfBg/VysrVVSsWUIk6/QJKs+L+PFV0tsolvl1JgYeQGtKh5UbQCCooHoUT+H/nDaCsV
 cE8wqHKSX+tMmkt7vEL59vxT9dNc/3FgTea55d29fMTQX0MjnuSPjwYJPsccmiGf8BEf
 xSlCx+CejOjnl+SWHXw7bWwU0k9by1TQPQfkS4QbglMQoeDjVJ3U5F3CtZJSgIL0vE67
 cWaEK18up8Owe1uPPakm633cuxfNXrK+Zq4K91NtwKn7ucUf/F58iZunYeq/gW4FL2DX ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktq2bks7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 10:01:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4279cX0T000451;
	Thu, 7 Mar 2024 10:01:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjgs7kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 10:01:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OY1PxnZs4A/RAmDhiXn4MA1X1Y5E77xn9cvcWAsHfui1h8OsT9u1nf5Z4i5w6RsWVZTx07wj9GpmtjoJ5uBRzhg8qGF+kfYSXPiPd+cRKayxdMTX4F2a4bj9r/ntHy+xOpent5Nd7Bp/azdhwXhMrEvS1NQujky1a5hvHlfrran9LElXJLNm0AJuCUWHLNG93CB3U4mbBumYvsPFhlvsO/IN4tgSOC+AwjTD0nCTzUwzNm4ZizMgOZJrAel+xDYJ7buVORg9QdZ66oipx0zPs8Gd+ductQYhF6TwG52nEfaNYhkJoFQrq66yJv7v0CU+O8ullSZxq3n67KLCFAZgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtR3Q/MVGnhQxi/mUggT5FfHwgK485NZMov4uNaHEoo=;
 b=UE2ISdAc36fo1wnQrswt4SJ3lJZPknWCTOlgl54RTNkOIPYiyRlg2d/1WEGAa3AX4NqMEOr8vQiE0ejgSdlpQN7feIvMlnifdZIdNtNEjgwXf/9Agern71T7CfBUW3jh/GW0svbrrDQf2G0fLB/Td1EaB0LdzWMJTd80EPB4yOG3QUsoO69KpfxWneHu9XaNpccny9beun1YHZ8RebdaBJOjZEWgHH+v18TkufXj6GbiPsBQC08BMsmnKTf/ZdyZgJFPlab9AZ7LfWalDXA1TtcRU9DiP7DqRjpzkfmmABtFt5duhhvpAuIMz9eoigFCyEdJSp0JiesfqCchcj3CeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtR3Q/MVGnhQxi/mUggT5FfHwgK485NZMov4uNaHEoo=;
 b=GB2Ju8P40yxkzj9TSONLbbLnzILTN69L3RsgLVWaRePo4PNys6nJdx8c62Yv/kuMKWG/GGNDiyykrwAKZVRiEHMt9/wfewPUqcPmN1m3eY3r6Ax0e5OHT/dUrZKhOk0LIYhESdM3CvdgDJWOTJ/BUgpRmM0krdx1XAD69pftIt8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB6331.namprd10.prod.outlook.com (2603:10b6:806:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 10:01:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 10:01:19 +0000
Message-ID: <a382d713-f2d7-4b92-99c7-3b2cc066179f@oracle.com>
Date: Thu, 7 Mar 2024 10:01:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] scsi: libsas: Fix disk not being scanned in after
 being removed
Content-Language: en-US
To: Xingui Yang <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        chenxiang66@hisilicon.com, kangfenglong@huawei.com
References: <20240307093733.41222-1-yangxingui@huawei.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240307093733.41222-1-yangxingui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0169.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: ae271ce5-ef12-408b-af0e-08dc3e8d8911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gdM75uf3HgeZY0EODFFWPR+pM0Ybv1T3fzbWmg6dU1OufgR4fZTVw3AT+QGvwxCimJRk0ZOo6R2mqWtmGez3YSgycHuyoS/uxO5uRuZztw6aRiMBf5g7zn8FCwWDR+YoLOaHTevEtNWHDXY1BF57Egy7kPLNbsJvLiksURXS6X2PslEMRx2D/tVox4gZlSg/Rhe5y7VnBbv/K5vZzFClxAmVDOGQHSOdhhOLyHyowzsQBwjFEz2vjSFRzCP8GA982Jzh6Dt4ngigHWwWdpdmiqaonSuQh7Vc1m4p3rc9dMPNpPScx2DBYdF65XvahHnlbjDpbPtvI7TPEniL8YPVHIP1LRfydP0SnJs6ecW2wHmF3novYN0HQk6JXvRfBq7zIqEDnXeO3bo0EtE30E/Q80HugPDgOwuSrW1aqZjktE1lPCOMQ7c/NM71+X1T7BpI0bnqi4n+W9YB12IbsoLvYjF1U9L7ysKXR3iwAK0VMgcmAK+rhSPu91MS1J+B5otWK78lMu+AV3u7JRXK3lk1MNO84y0x+0kTSllc0BDjHYe1HoxWVArtTfee9bapkN/qlKJr04PILB1ZaA6h9J6cHpcd6cc4kQnBnMA8Ojk+sS1QlKzXw2ZTg1K0OUZNpP0qO2HVBofPrSQ8RRo/gd3w2ZaCvegaSFRQnR6xfDaxU0o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NWRUcUE2WndldHVjWFlneHptbWhyaXE2emJoczR2M2pGem1zTm5kRE00TW1q?=
 =?utf-8?B?aENkRzZ0d3BtNEVobFdTN2dhYkFVS3hkSlN6Y29NUVgzV0tBZ1VFWUhndERG?=
 =?utf-8?B?QUVMZEZHQk1pZEFjays1TlVUKzVEN2RWb2Z0a1J0RlFiT3U2cWhQcFc0S2k5?=
 =?utf-8?B?OTR6cUFiTFZBaU9tUzN2cVdseTRJRitHRUltdjhEV2M1WjhyQXRrWTRJS2JP?=
 =?utf-8?B?TG9SU1cvZWp3cDhUWDZydzNRZUZsbiswQzBMVk5NVU5reFZiSFhieHI3NTBN?=
 =?utf-8?B?K3QvQUxITG41TUxaQnczb3p0OWJSMmJpL0RucXpXZ3NVY1lNZnB5eUxTYzIx?=
 =?utf-8?B?V3BQOVh1VlM1aDN3NnBzMmU4L1hNVk9TTjQ4Y0pDaDM5OTFJbUdmZEZhN1N1?=
 =?utf-8?B?a2J1bEZHNVorN2RMS0xpNkMrdVBydEo4RHNLaVVFbGx2c0RrZmdOZlY3Y2w2?=
 =?utf-8?B?TzI1dEdrYTNvQnZLdFVBcytER2V2b0ZvNm81cWhnV1ZCSlJDRXBjbGFIaGVL?=
 =?utf-8?B?dlNiVHl6MHJFTGFUNnFoQUp2aVNMcDBTaWp4Vm1VTUoxWTZMY2FsSEpGLzBO?=
 =?utf-8?B?cW5YTG0vOFlIckY0ekVUWXB4Y0tuVXo5aGlZYXZ0aWhadXNsTlhnVFBlMzJM?=
 =?utf-8?B?aWJwTVFnOUo5d3V0UXB6OGVYaVNlMEw2d1ZIMDNGWTErTHVhOFBYMXJPYS9j?=
 =?utf-8?B?ZlhrRzNEYU9TREZqeW44QjYzK1JmSWx0UVlRSzFGMzBWSzBUZU16WkYzdDZO?=
 =?utf-8?B?eW1iWHBVajc0Q1AzKzkybnJzNENpWmJHenZnYVV4eklwemVFMVlkVTFseElS?=
 =?utf-8?B?ODZ0dVZncHlmeEtIU3ZYVG0xeStMeUVlYnNUTUZCZ3dQaERYK1BXWjVnUXN2?=
 =?utf-8?B?Z0hxOGhJc3hTQTQ2eHdIVGV1ZVFBY2o0YXFOOWpRb0ZRWjhnRnR2QWk1bUhZ?=
 =?utf-8?B?K1I4bVJ6eHpJVmRxZWVFQXl1OFJQSVN3cXk1N2NGbTJYNVBQUGQyZXY1eEI2?=
 =?utf-8?B?V0dvQjAzNjROaW9Ocm5MbHgwN1ZuWnk4YmxQa3ZIdHlCRFVIMHU2VTRKV1dO?=
 =?utf-8?B?YUY1dXplWG1EUkVoZ0hoTnhSdmluT05mRHg4SWhqY3krSlVQZ0Y2VUt1UUlp?=
 =?utf-8?B?L0MvNHZjK0RSZ3ZacjU0eHA4SFJZVHVKNGZRMWo4dUV5eXg0b0todE5vZHV4?=
 =?utf-8?B?VTR3Sm9kaXZPQndlWlp3eU92NjRDa3pyR3hEejNvNG1LTjBqS2hKVzhkLzhQ?=
 =?utf-8?B?bFdEdGpvNWQvQkR4cnlybFRsUUtUbW1oc0tmRTFRQytOcnp5bS8xRzlRcWs0?=
 =?utf-8?B?SjFaVEkwdE1hTXJQdWp4eVhPSFJ0YW1OOWI0K1ppdldscDFJMkRUc3locmZv?=
 =?utf-8?B?S3dpQy9SS1NGd3lZQVpPN3NObmM4dldHOEx0MU1Dd3h2NHBYUURnWmNDYU1F?=
 =?utf-8?B?NS9XWEVXdlFaWElhVThuRVJEaTNON2VUVDQxYjdlTDNBTHN4S2hmSy9zaC81?=
 =?utf-8?B?dWt5dTNXSXk0Yjh0VmJBK1lYMFd1b2diWVFmTEZRVmJ0SExGY1R2ZVpSWGZx?=
 =?utf-8?B?c0ZuZk1QRXNQSWhyTVlGZ0pvQUl4a1M3V3VwSzdya2tuUVZ3WkV4VGgzSVFM?=
 =?utf-8?B?NTlzVmVBaDk2Y2RrMnhxZk5oWmliaFdZZm40ZDlJT1EzYXJMOGpCa3RUS0VF?=
 =?utf-8?B?L3paQlVvNlRPY2J2eGpZM1p0RWc3VXBveDJNUjlQOXJja1VqS1ZwRkRXREd5?=
 =?utf-8?B?QUV2c0FTQ1pWY20vaVFKVkY2dzJJUWxmQk1FZndRUkdBdnY2eXlLeHlDU1ZI?=
 =?utf-8?B?VzFodmtBbFpXOE9OczZsaFM1YWFuKzFhS1ZZRk1taWw2ei9rRmFaSTlGVTdv?=
 =?utf-8?B?dlRLZG00dlU4UEV4WS85aHJDL3ZNUHJBUXlMZzZmUUpyMXJOcnl0Z2lCZkVY?=
 =?utf-8?B?L1RHM3BGd3oxWHMrQTkrZ3k5ZjhTNEV1RE02SmswUHJ4d3dpSlFyUmxrTE1S?=
 =?utf-8?B?c1Fpa0ZFZkZ1MVFvNzZRdFpJdkluWmUrbGxjb3RlSS9MakpiZndXRjRXQStM?=
 =?utf-8?B?aVV6YTgzejdDWnNQaTlNWHEzU0VGRkFiUHRzNTZXcmRkYkpOVXFmOUdRTks0?=
 =?utf-8?B?T0ExQzZMVFU0K1NNVDhYSlliTzhpS2dQUnNpMFdGVG1PL0RBV1czNzBYVFIz?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uBOWlij4vbfuGPgnAUy2Qkl61YjsI08v6GixeEcCdUzQsynBcs0MuKhDH5ZGOr72YE5vR4iwRRqj4Cfcoo5ebEZVr8/YT8gMkdukGuMbAsc0AieFv+H1EKoZpmcAKgQ/eJrQHeJttWweWYnMJHp7sILNB4UT1rwFGPrdCLO6v9aHEAxrs41+uamIkQnZR5q4gmufOEs/n/lghtuPMjJTUNzBpouAUwasjjWQleS5qcFWOolcmL9pwnAvPlfl22fNaXLXOn3DzN8CMB+T+GgotDPxurEBqer32EbETkqLlPW73mNc1C1ltNZnJBeoAAoubh+W4jzrimD8/0bS1COSaheGWEwH9WjD4F0SbtaAqFZQTWzo1+bhxcnA9k2c8Zsi3mQS8SiQLCooqxvcfblMutjlqrs0mdYjxVYyx76TBuvqCjv9SW0NF8kLE1v3yMBH9gsYhoAicAV3nUCadGLhRGst4tX9w9tmAoUwDrgL3vOmFjSEm6CokqZti0HRy7AFqk5nisL01GMWquIPRHeSxgO2gebQr8zn9JyUSFWSXOWfMSXepI9rtL6SsGnWb27T2kOhTYzhKrDgOJeLjAx/8DWBm2KORER5aMcCxh1739w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae271ce5-ef12-408b-af0e-08dc3e8d8911
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 10:01:19.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qcj2RzrFvm6MVRWMuNqYB27gjVlGo6aIkPrjYnnsK58mQjmO/1k5ZR8v0DlR6QST5Pq2qUiJG5c99Gz0P0bODA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070072
X-Proofpoint-GUID: NpiZO7uDzAXW_HBBIg9A_56qPwnrkxjw
X-Proofpoint-ORIG-GUID: NpiZO7uDzAXW_HBBIg9A_56qPwnrkxjw

On 07/03/2024 09:37, Xingui Yang wrote:
> This patch series fixes an issue when do discovery on an empty PHY to
> update PHY info after device unregister could cause newly connected device
> to not be scanned.
> 
> Changes since v2:
> - Based on John's suggestion, allow smp_execute_task() arguments to be on
> the stack.

You can't just change one particular smp_execute_task() callsite to put 
the disc memories on the stack - they should all be changed.

Better yet, we should see how the changes look and then decide to change 
at all.

Anyway, since you are simplifying the code, let's revisit the 
smp_execute_task() change later.

Thanks,
John

