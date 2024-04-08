Return-Path: <linux-kernel+bounces-135320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8250D89BEF9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370372824E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683DF6BB22;
	Mon,  8 Apr 2024 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CMx7UXND";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KARaDRjL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8962D638;
	Mon,  8 Apr 2024 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579421; cv=fail; b=fZeJhOAuwXGQ2L/27YDA8hJ6FrLYSvnr9LLb2F3flomWEM8vouvr1/7NoF3RXdOc8VDz38/DLnK0rzTslZZ9pIT8g633RZrQSfaV3AkaJaq5Mp6Iq60LPztc8z6RzGWPiYh4p0dL+k4LHND6KUGcZs/CzafWvkXXq6bIZheYhYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579421; c=relaxed/simple;
	bh=RcHl1pf3ECaFQfEndM3Nx1bgqW7SN5lKWppZdFs5cBg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UqqZiFY6Nw6im20DftkRGGY3LyvP1c6PWFhd/3zXgtzt40qDkVCREuNfNWFXdnU6KjJ127ffXB9HDzxrDR7wkxwy/B3wK8fgv00o+peNfGfqsNFQAuqomxYXyev8Zbc9UCDbQXolEZErs+IDWj50hslDhmKjrcvOCnJ+Y5pSmvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CMx7UXND; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KARaDRjL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4386YB09017175;
	Mon, 8 Apr 2024 12:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=w4OmUFO8/sneiSS4sHqmujSX4+bHPI2oGlnIWCs3grk=;
 b=CMx7UXNDAuXV+PhOAxHPvFihnlButh8MmqjubWU+GKgj9CDlmXeB0IYtir2YgxrcDmOy
 vjNxiZauhmP0W4uCEL7aU7ze0ydz7CMy9Uo8yLLnfgWa9WADvjVywgENJvaP52OR3u5B
 TL9GtKtV0brVChTqLEeXiSPcYR9sjyR5McjhXMQSMqq53gXWasHxUd0Ga3RxVJ3kG6zn
 9Sa7paRb8qarv9ZDPwvvDrgFtsFzu3QkuE1swqfZfgrGv0Pt/QMqj76U6ByaUJHl13Gu
 Yyb043P8uZI9fsN2/3/nAjm/8BhQZJS8fshLw2X1uOZah6P8QdgAAC99Gvf0F7sRqHiI 0Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw642hr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 12:30:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 438ATEOP002812;
	Mon, 8 Apr 2024 12:30:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavubmgcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 12:30:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnESSo+a0zBoOULj/8yPoyTPpki5DKSCuWvYGp8DmOxRWF+8sGUXgip7ESRv68wtz1jYByy6mKKaUF/ug9hzw4xmAeFfkz2b3VqcPvmAABQKvBwk/tln2wEeCAJ3EKd5AazxleTZZ6RYNAAdf9lN1QkgeW0Yk9/tq5irKIOvZP7RnEVntuus6fPI4gvBD58eAW+iEn1ruff0MXzwl2sXdJq2ja8Us0QWghzeCqktPt/RRZxNpewkAn8n1vkjEsEhnT61iyqn7ZX8hRQUevYavbqQpq7EZmhlv3GVSNm0vR/eCW/ETkoeWTUuY3j/Y/eE5cNYBOhwESRFzvHFb5isRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4OmUFO8/sneiSS4sHqmujSX4+bHPI2oGlnIWCs3grk=;
 b=Z8ppaI7ODmbJkXlvQo8mYeoFJLJvKqzmTlONe1zKkgrxfvNtT6RACEMksLniW2+TWUeZbwYZ0veQohMIKl2t7q3vjvC4vgfkkByofHVs5cJq9hYdiLstU4Nq06MjHV2SDz55AjNr+x6v7/WeStiG7n67E+UehoTNOSnoHod7cLu3jC+tiPLkSacpZJ75/Sl1ZSV1q++iZ+HW4NHNiglU4Zg5JxP+VLRdFh1JH3ot5cD6R2WH5RKCBjSBvUvYFs7SGokgDRG9IEXisaaHlgSf7tMaxXnR6xEJ7i3lpjGfQJfIGYJ0NEYarT0gRDp54zx0+gGN3ZIYLB1aHiXeWDQJYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4OmUFO8/sneiSS4sHqmujSX4+bHPI2oGlnIWCs3grk=;
 b=KARaDRjLEUtP8YFqi0UsiphKE/nFxGBzemU4sUaMwwgmeKkpa2Gl69s99S8MraJJ8EoHeKfdL36BwhU+j2+xkpeN0Ei+p7KEUzOOEdCj+2liLR+DgRygPQ3MM46fOyWoMczJKGWDPR5ZX5t4EB4SElAPKACR0TfLdWFc01DhHqc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4225.namprd10.prod.outlook.com (2603:10b6:a03:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 12:30:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 12:30:11 +0000
Message-ID: <e0179895-5d06-4c47-98f2-635175a05cf7@oracle.com>
Date: Mon, 8 Apr 2024 13:30:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] scsi: megaraid_sas: make module parameter
 scmd_timeout writable
To: Lei Chen <lei.chen@smartx.com>,
        Kashyap Desai
 <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Chandrakanth patil <chandrakanth.patil@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240408100505.1732370-1-lei.chen@smartx.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240408100505.1732370-1-lei.chen@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0088.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4225:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XrNpx90fbEHvffosjgfhPTUNQsGhKvMTdIvHj0fnoVYmVjYL0Gu2LcFDm5o9s/sJmP5GYHz58sbZ3LFaCkKbo9BagjF681kEeEe47EhnU+eQ/G4MypD3QPjt8vjo2imgq5M2IwNNtnoC099r4Us6wgxkHVI6YUtnY/FEc/uWeFfol58p6nik1sxbFCWUtd2GjEJejqlmyEyp6GIKSSQtwQCqrgInzLHEql9TDYLycUq11Aw/5CVQQAFY4n+/K2Po6nLTQuGEI3sWvrFM9PcdrXd1Ov5ul9l7Y6rCjnWluWGLWH+JF93Z07R1qgEbSAEOTEwH4gMff2jwpF6pfJZ7zefW2V99kZ4kJLWGBHQLjtd0ef+rwfDaXZJKBrU1DrEGKJkeo1D1yXY9bZ6v6FGPbuBpJUZYRaU+Lxm2YTv0ivdoCmCweJYQMnHAm8YpujHpUg6z3J//x1rq5FvfC/fMPup8CrqEhgbbEEpmw24f4BNE41D8VnGi7KuFIqX0q5JDDI3vwTzZ/eC9jmBefTa3B31WAO39qZTcjf6TF2sAXeq5eZyUrFF9uEy1g0TeT5qRt83ZBKYW9viAIpdMeg0gauHRCH54i18A2NWD9PBLyMXmVqO9TJFMaG+t9vMpU8Rro9C8Uqzu33ngndOiEwizioVyz4wzL3SMMq8ypdZxoDk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NWtDcnNPMlJTNFAreWExaG43WllFNjZXMTRvWktocERucm9SQ0xBaWlmWERU?=
 =?utf-8?B?OGRBc28xMXpqc3VDUHlPbTZTeDNQSHp3bFBIbXlLTVJCb2tCbnJoR3pHajJZ?=
 =?utf-8?B?QldZZlNrQS9MaWo5YnFGQm5TS3dtZS9DaVJZMDdFdytrbEFLUTNtZkNoc2Nv?=
 =?utf-8?B?dS9JTTRianJPUG56OHJDT0RZZEk3NTluL2hLa3dTUEJ4NXVwUzh3NDJHc09a?=
 =?utf-8?B?TjZOWUhHQW5Nd3hnRG5zMjFYNHVKY3ZFRFYyZ3FkY3pPVklMVUtZdlBzWUY5?=
 =?utf-8?B?ZzBCb3l3bGFKTlJLcWVxV0dVWERnT0pUaExCbCtUejE0UmFsMzk4TVAzYWRV?=
 =?utf-8?B?Y3ZrSVUwKzQwbmNDVHgyMHk2Y013RGdidTIvYjFBWTYxd1pmdmNxeE1xVE5P?=
 =?utf-8?B?L2toK2hBMFNTS05DaXE4R2Z3djMzUXBaWXpWdHRpZmc4cXVDUEMwa3NIZTNM?=
 =?utf-8?B?ZUlKMm9vek1nb1F5THdtYkx6ZE5wc3FadE9IT1JUOVlveGN4aDFpN1hBUXBa?=
 =?utf-8?B?aDYzM1NkVURTa0JhckZpWXR2QTlJZVpscjdBVWxPbFBPOHBUZjlhTFVjaElC?=
 =?utf-8?B?VitWckhkYXFGYnFOODF1OENwaGxxSE1mVkluaWdGR3RQQzM1UWxyeSttUGJZ?=
 =?utf-8?B?bUdIaVMzMEFXVWhLVmc0MmhIU00yVGg1YWFoZEdPMkgrSkxESnJwaXlmYlpK?=
 =?utf-8?B?TDE5Y2NhaDIrQkZDMkxUOHduQks0MytJNjBrWjBJODZtT0Y0QmVvK25Ca2N2?=
 =?utf-8?B?ZDBYaStBRDN2Q0t2TFNLYlBubFVHTGZLZUtZMitHT09oc00ybDZOSjdJMHhk?=
 =?utf-8?B?T2NGdDVRWXZMZWV6cHhnbm5KV2xXQVl5NVRVQ0xHWjFMTGttZmNGalU5cWpK?=
 =?utf-8?B?M0lHRHpjMFBiOHhKZ1JyVVRBSlZUbGFWWjl4c3dlTnMvQm1OdGJlUWZYYzl5?=
 =?utf-8?B?NDlCUEdiUm15dm9qbDFQN1ZRME92ZVJwOXVJaDEzZnpPZjdjUVZselVkYzVr?=
 =?utf-8?B?MWFTR24xQmJ0WFlxbGlLWW9GZ3ZIU0NUUTJvalN1djY0ZXJST1VkYnFkVkc1?=
 =?utf-8?B?N05PclVMcTJqTUFMcHZWSlZPUW5iSzhwTjZvM2RuLzh1aWEySXFzcFNSY1NU?=
 =?utf-8?B?Y1pIdC8zUFZTT2xMRitjdTNUR0VQTWNQTEdObnFPWTdkSThYUjVwU2taZkdK?=
 =?utf-8?B?N1pLSXJaazBPdGhlUHJqeldnNU9GekRKcnZXdnpBVXF1d2tMbjJDcldEWHd6?=
 =?utf-8?B?dmtrMEUvNXREai9rTnB1OXlsbE1SZEhKVUFCY0dUaUYxYytWY0VnWEJMNEJ1?=
 =?utf-8?B?d2t3ZUdlVXRVeGhwU3hjQnczMUtyMnU5Vkp0Vm9haHA4VzZFYk80SGRzYWlX?=
 =?utf-8?B?TTVQVllraUNRaVZUeGhsVTVDbldvNGlBajRhWWcxT2tiR1VZbDNmMTBtcmZU?=
 =?utf-8?B?Y3pwTXBjNEdraEtvVnNKVmNmZlFkYVMvdndsbUNNUjNDRVJsbFQ1Y3hWMFRo?=
 =?utf-8?B?YWk5ekh0M1p4bzBaSkVsNVhCVzB1cTNNc1F4ZXZid1RrTmJyVTZJZHI4OE45?=
 =?utf-8?B?aHp0VllmLzlXS2N4TjhKcWF6RHVzMVQ2YldnWWJCUytBV3Bpekd3WDFMYTVs?=
 =?utf-8?B?aWdzMUpPcitaaERFZjEwdkZxMjFFc3NQM25jQkRaZ01TMzdsam43eUp5Slcx?=
 =?utf-8?B?UTRHRHRZdTZCNDZ5cll0VnI2Tzc5azBMcCt6MkRHQWs3MkRMWnN2QWR6bk9r?=
 =?utf-8?B?ZUw0YjhRMFJOeDBhY1FCUVc2ZmJjRTdqYkpwRGRUSGQ4NFdhRURXSnJjaTNw?=
 =?utf-8?B?TFZXTVREaENpeFFYSGU0Qng1ODQyNVVlWHhjK0k0di9QYzd0UUFzd0ZOTU1V?=
 =?utf-8?B?WHVNUll5TjdhUmtqVnBGbGw4NFRKSTEwaWRabmNrQkdtQXBNL1ppWi9tN1pi?=
 =?utf-8?B?ZnVlWFp4RHkwS01QQW80YVdibDBSeENEeWh2WnRKUUl4ZEJtckc3cnFKTlBI?=
 =?utf-8?B?TmFMZytLNG1VSXpZcktjbzc5TGFaaERBNXFaY3Jia1ZTbWpKQUJuS0lIclpP?=
 =?utf-8?B?WXpwM2JlMzRYQ1JtYzh0TXNMYzJaK0NIR2Rxd1ZrUzVEZ0p0ekNudmNMT041?=
 =?utf-8?Q?1WvYR5GP+VQpFdDZmeLFOWHzK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	66kBS+shDMdQmLba4bXAr53JMDIeZ630wgyfxMWurxdDhUBaoMvfjBBTIl3Wmgz0MutfE7fAj5yb3jeIZskB7SlT10Sqi6WgEWpK2rrKz+3Jsti7fnAuR68NxR9jroYOD7//MbnqyrqiZINt7CzAYDEs0Tyd4WyNyKPYyvXb1wf2Y7vYiHFSopygGn35phsifEOjDr4c3sna3kzyfdAWVRIpS7cFO5MdtcLtULx+lKiTZBaFZLJprSUQXgIh87YInL+eKD+asOegnuvP50eEz3Sw5Ji8sCKfY6U9oQ/twcqKDvPPQ0iBsNZtApQEDHLz3aBrKFBYIRfbkGxcYRCFz9KO5hXoOKBB6gEGCEx5ikpuJvW6uby1fpmkyL3cOE1s+SBk5Abm2EKnQPFvSzwXnodjI0P0YsWAlm8Tr5Qvtsyj0t0MNuRkqLkiaEYxckgUma5WmT2eka1Jv0hmpL/BL+50upNc18Do26sLKVcqdJcJjG97m1R3n5avJALYy243HMRTAXzbQ1VlRo/H2un/UqkSJy1TIt27ayRH5e532zIcOg0r+HNNqV60QNvOn5wQIbt91ByZdqrn9TpUffqqvOEKddDS+9204ioGZ5V8KRg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e052df7f-0603-4f62-1092-08dc57c7a289
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 12:30:11.9598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8Z/s4RGARhYobvc/ZNoigrg21BVPXF/ITj97e3gjWNNVk+pXgcENjkfNtplj+fGKLtmI9Fujq80FGIFqE8T/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_11,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404080095
X-Proofpoint-GUID: r_rWiY-f3QBVavXfY2akCBj2DG3XjWes
X-Proofpoint-ORIG-GUID: r_rWiY-f3QBVavXfY2akCBj2DG3XjWes

On 08/04/2024 11:05, Lei Chen wrote:
> When an scmd times out, block layer calls megasas_reset_timer to
> make further decisions. scmd_timeout indicates when an scmd is really
> timed-out.

What does really timed-out mean?

> If we want to make this process more fast, we can decrease
> this value. This patch allows users to change this value in run-time.
> 
> Signed-off-by: Lei Chen <lei.chen@smartx.com>
> ---
>   drivers/scsi/megaraid/megaraid_sas_base.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 3d4f13da1ae8..2a165e5dc7a3 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -91,7 +91,7 @@ module_param(dual_qdepth_disable, int, 0444);
>   MODULE_PARM_DESC(dual_qdepth_disable, "Disable dual queue depth feature. Default: 0");
>   
>   static unsigned int scmd_timeout = MEGASAS_DEFAULT_CMD_TIMEOUT;
> -module_param(scmd_timeout, int, 0444);
> +module_param(scmd_timeout, int, 0644);
>   MODULE_PARM_DESC(scmd_timeout, "scsi command timeout (10-90s), default 90s. See megasas_reset_timer.");
>   
>   int perf_mode = -1;

I don't know why megaraid_sas has special handling here (and bypasses 
SCSI midlayer).

If the host is overloaded and you get a time-out as a command simply 
could not be handled in time, can you alternatively try reducing the 
scsi device queue depth?

