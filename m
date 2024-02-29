Return-Path: <linux-kernel+bounces-86655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3568786C873
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDEC1F229DB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212337C6EF;
	Thu, 29 Feb 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R/k0SmyS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eeTarIgs"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BBF7C6E0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207419; cv=fail; b=sAh71jX9cPxLgmn1beLEriv9cOrV45MRNqy75s4GxlolnRNSaWbbe/av3Id/x5YADrzTi9vaOaBymar1blrhFGHGkz7CS4Spz1jbA5MksL22izipL7XfX7xcNnKwqDNVqve4m7OY0JsUvN5FuNxDpKuU9Ec74JfO7HusSHb4GDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207419; c=relaxed/simple;
	bh=YLZ+P57ZAnjkQjPWOwpQqNhWdsQmlb7CsZ4rFOCTNdk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YUxiWEH0+fVOyJKdJHks7H0xY4GUay3MmcWoAYBY382vrW7AwwmTneIXByFpPupQNRSGOGahvc9Va0/kcMgpy1wN38AA+WCYUUCh6jhgN/om6Cgh8+ZPyagZ6ycRiQgzppDwMi2bPSlzeujwu2nFPPNxi1Ua5PnaZRRNVAwxzF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R/k0SmyS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eeTarIgs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41T9UQ1Q017802;
	Thu, 29 Feb 2024 11:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=IdFhXKkYZKvi88xh34usNYGI4jKPkFyFPpwrLjjmeo0=;
 b=R/k0SmyS0tXx4EZZBCwte9qsRqj1K86NEQBRR/emHMCPiqofvZDnOFrNPFbW3eT0Hy92
 zKpN8ZNx/9UEiaqrYJ95EpFU+f4+0qiOQ3MfW9lXRAXNDtzL+RKlkzkId7+iYam65MC6
 6ZamBrVQrOxJzp7kklc6iwdhmNdy2TdkpY/MTmN8RQfB3ljZmkhTMpeNyzHhKIYRaZGa
 7Yrh4vpFA7RGCO54wjdy2dd7vl9lBVYr3ZiC/ODwD0gzDUFP9p4QQuiaclAr8p6TxCZ1
 RI86ovZqX2+5kM/vh0wsKl5Sd1BZy6UaPiDhbTHJddjqraSVsesId13kmaDlW9es629/ fQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf722nahp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 11:50:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41TA6fLx022465;
	Thu, 29 Feb 2024 11:50:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wars2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 11:50:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfGZPs5KQDl3AGZL9aBI0cBj986B2iSmnjI47ZiMTYBje+VaJtBkp9X575QxttwxV9FV09YVXp1t4CwKDg/x9Q0oeC97XUM0FratAa4KRESPhBX9uP5CJoKA9rhgulTzMCgste66H2AYUjsweTLMtgTElHyZIO84XJAOnI5E44X1ygFf2bFgcrsFHS29irIOUaBkFMpK+v/vZM8dVSOo3Azxxdo9MT1oLRp8xpawgWwXtiscDcu1Ik7+IdG1WTl4xE8ng8Cbj9UMt85xDKdsH7ypo/lzSKIWJmnBfaMDXPtxz7ackiZX045G5vmEg6PdoBxokcwLI+2zZrUjIcZeTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdFhXKkYZKvi88xh34usNYGI4jKPkFyFPpwrLjjmeo0=;
 b=e+jJrm8wfXtEvGY1hN0G+nZvfca3v+hT/0/qM+48TymOUMxowQfXhSk5C5/QNTv4ynrYX6yFz+LKq66RWuTPorxGvAOfXtYsqk7uLmglfAxE/pMXbSXDIXr15j/2fNQIWQ3UK3TG7FieHAVLpz9n18tDgVGu10uLBYGg8unqZTF89L25Gvfzh56DS+X7woashueIYtnag7qJANGKe1fDUP0gdV6ABL5Gc+5XlCQWwWINl98ZTDMkCMyA1komlYkbQ4zUSmQL2oyxpYbzbDoqHIDR294uYq4E+dLIMXkqRX+azmxikgZ1RN0LAR9MgIn1i6UZvHNBzaV1NAKRjjdF/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdFhXKkYZKvi88xh34usNYGI4jKPkFyFPpwrLjjmeo0=;
 b=eeTarIgsgkZU189gEwVt1H7sfWzHVz0QOEPP8GwLbx4ROpYzlKnhk3AwNzz81WhJ65toc2QhswiOpA7L44fxk2XhjzvHfDh982GolyhElZL6Fv52tMK908vuVvh5d4OrqFHKGsRXcaiGNH9xMk+TS4Lz+6YR+jGlunKJh5K81rY=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SA2PR10MB4476.namprd10.prod.outlook.com (2603:10b6:806:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 11:50:03 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a4ab:7076:36d:a488]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a4ab:7076:36d:a488%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 11:50:03 +0000
Message-ID: <c8bc7435-518f-45a6-b2b8-8e7f4410438b@oracle.com>
Date: Thu, 29 Feb 2024 12:49:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/5] misc: mlx5ctl: Add command rpc ioctl
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>, David Ahern <dsahern@kernel.org>,
        Aron Silverton <aron.silverton@oracle.com>,
        Christoph Hellwig <hch@infradead.org>, andrew.gospodarek@broadcom.com,
        linux-kernel@vger.kernel.org
References: <20240207072435.14182-1-saeed@kernel.org>
 <20240207072435.14182-5-saeed@kernel.org>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20240207072435.14182-5-saeed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0043.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::17) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SA2PR10MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: 62660978-b836-452e-9066-08dc391c90af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Lm25JaMhDN78xAw4qdZBHLx/x5DUIDLj9x/plbx/bNGEYGQrMpERL9vPN9w2MpoZMPaGKH4LMvMquP/6VyEg85fDPVfsTi+5aYHyEbo2MqqCloaiNSJRtRaj8bxAnO1jsxDwmdyWsuadG5Eo5uA4j4v2HLv47BhEvaPcMJ6I4Ug/ITyLzdTCaIIXp1Myp1LfrjyouYWUWK6k2GPYz+bfGV0kuF4SkdCflXJ6AWvnSCQLX78pviqnpvB3QzoTsrMhrMYbZ1MyIj2PZn2rCoih3PQ+YHYMps43AV4/C/9boVDpQvDwk2cptr5V9i2EhadXls0TSTZlEtohcTvEJ8JaSnypA1TcS8Ty2YBjYK1dO8vWJNhD1iV0VOQci5UOrKqyFI1N2wt4noxwvGEwabRIACAzHfjQ4++/puivBZ/J6DX3DS2boVLVIVF00l1QwnPa8i2j3Mhp+W9suXhPayYpOGfUYb0eq1RWLsZBqIpsDCQ5qJLfQzNtYqE1wgcLsb3gBj0xk/87MWsBkqjxQqq3q0KAZNQjcuIVFr9R1gVTqDG3mSMqZjTPX2QAz6LhoDD990/OQpuvIwQ2bo3TErh1tqTS+eac+kg2LOHjkwg493gZZ+gQpdbggiSu7HP0cVl/xwkUn4qqQaeUgKmBs5kuLA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dWoxZEFhQUgzVGprQzBXcG82dkJSazN0SVlvVk8rbDM1ajRnZVhjaHppNG5p?=
 =?utf-8?B?WC9QM0wrc2ROMEFmMGQrK0dOY3gwWFIzT3BZSndRMWNRUVZ4Qm5CWWhjZFJS?=
 =?utf-8?B?a0w5UVJlNzdqVlNFZ2xYbjExdktldjA4by9TMHZURDdpVEpDZGdodGJ5RWxO?=
 =?utf-8?B?MzYwQ1pwU0ZWSDhvWm02RkVEbE0rMWtCbkd5Q0VxR1RKRlkrNUJmNDArczkv?=
 =?utf-8?B?NjY5YUNpb2lMUG9aQmQ2YXlKMEZ1Z2dqK3NXSkFwV3lkdGhpUjJ3QVB0SDhS?=
 =?utf-8?B?enJZMmRxVUtGYVQrdkJRWDIxaWRCUmdiNG81SHdKbXRNZjJPU3BkQStDd2Ez?=
 =?utf-8?B?MEtaZGw5YzFVejRjeWZpcldKNjFLVTFaVkRWNXRJQWRocDBGaUhDRjJhNWZ5?=
 =?utf-8?B?QzIvYi9VdTlhc3FBRUQ0ZFFGS0hoa3l5eWNTaUVidHlnNDNRUWJ5dGMzaXVO?=
 =?utf-8?B?aUhpQnNmNFhoZWJ3cUZ3WU12NVR2c3BCR1V5VzVFUUV0RnpaTitsQjFYUGVp?=
 =?utf-8?B?ZDdETDUzdGtlV2JGZWdLYTdMajUweDZZZFZrVFU5d1dvczVtc0hxWXZ3YU9a?=
 =?utf-8?B?blBDc0F6bmExQlgxcGxJYlVpQ3ZLM2l2TXJrZmlFSFB2cTJpczIwZThNYmR5?=
 =?utf-8?B?bWljR0cweGlhU3hSOXUyenYzQ1kyYVBHT0RmSmJyNGlEZkxPRDZ3eitvQzM5?=
 =?utf-8?B?ZHoySW5IT3VNUW54TWZOcHNveGJDNndIK3FMSTVjU2o0Q0VTVXRnYlh5Y3Rr?=
 =?utf-8?B?TXVEa0k5MXBVdzJNeW9JY1VoTFhSYXVlM1NuNHNaTVhMY2VpT203MEtORSti?=
 =?utf-8?B?MjZOS2QvNVM2VGJvc2xHUWNzK01IUmJ1amd5VzgyRGthakNBS09qM0VXNzVl?=
 =?utf-8?B?c1VYdDNCRmtTUEpCSlEwbmN5alkrOGdJZ3dtZ25mZWxNOGExV0M2bnJsQjYv?=
 =?utf-8?B?dFpTaFVMYVJZL1pycGFLaXA5Q3kyTUQ5Y3NFSnorZGZ2TDhTZTUxZ0dIU3hG?=
 =?utf-8?B?eVJPenE2SlN4SEVXZTcxaTJlUXhPQ2Uyb2N1WitiWXU3dXkzc1ZoTjEveTE2?=
 =?utf-8?B?cGZ6TDVwclp6M3NYZStxN1NsTi9NM2k2YXpBb2lLSjM4UlloS1BGQms4UGpQ?=
 =?utf-8?B?dW9LemFkNjI1ZDJnZlUrTzJ0R00xcUkwbGZES0VIMGRoYWJPbGRlTHhGSmds?=
 =?utf-8?B?ZzRHTFBtREl4SWpBSEpJZEcxSzlkdHFQOUY1SEhlMnpNNnJYRGtiTThZMHFZ?=
 =?utf-8?B?bnR6OUFpV0wyUnprcjNtV05obGVjUE5ObWhHdjFvaWdDVHdjOFl4Qyt2SkNH?=
 =?utf-8?B?RVJNLy9PM3JBOUxvalZ0TmNmcUh4cXVrdDU1S01KZTArZUVIUnovYVFncXo1?=
 =?utf-8?B?ZkM1UDlRbUx0L3hlT2l4dHRZM2lTWWI5Y3prMmEzNm9KemgrTE4vaTFUakl5?=
 =?utf-8?B?VnMweURGaXRlS3RrSmhLeFIyVTg3WklKM3hKRjZPeXJQOXltWURhQVNscTlq?=
 =?utf-8?B?S0hxN1p3clhlQythU1ExWnplMFlQenJIa29Nc1g3QXY4MGJLQ1FZVFRNcW1t?=
 =?utf-8?B?YXNWRldRMG5WL1ZmWCt0bVFtUFh0VVduZVhxSDB3MzR1WTBjWkkvalBLNzFv?=
 =?utf-8?B?MEFSZXlzMld1Q3BUUWZUaExvci80Ymh2Q2hFR2cxZ1YyVWo5VFh4SjlrWHJI?=
 =?utf-8?B?bjUxWk9KdTM5VFdYWEhHRVlWOGJ6VFhsS2xYUDhuUmhJYlNCOTBuYXJ5dzMw?=
 =?utf-8?B?L1NqUmZZWkduc0hvZ1R0cG1KczJrMWhZMzdqeTBPY2cwT2VaYnhtNldQY2xB?=
 =?utf-8?B?UTZubXhsUGlsaUxlNFNVdDlFK3o0ZE5HYmw0ZDQ1d20rVTVFaDNqSFVadXpr?=
 =?utf-8?B?MW1xTUZ6TUV6djByZ2lGWG04dU84amNsTWhRd2ExQS90Tzk2Vk1yTW1oY29B?=
 =?utf-8?B?SEREZnFwWGEySm1OcUdPd1pJOGhLbG9WVS9rU2FQRmQ0c3B2NjQrNnlVYzRS?=
 =?utf-8?B?MVNNTFM4ZTk0Y0p6emZDbGVtNVVnQTdORVJWM1BXRFQ2SGRSaVBkeGNpMElC?=
 =?utf-8?B?TWVHTExYdEJJMGx0NmpjWlFXbHhSbXpNUU1QQkVUejNDSDdQM0JyYWdWZW95?=
 =?utf-8?B?WVVQTko1Zk9NcnZXU0JVeUh6bHJWN2gwVnBycC96L2RRcStSaHFaTGd4SEJW?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wH9V5fOGLxCZ/5jWB3d0iDdJIosGOsyRQCJ3MKMV1H96zZaPfmCTaf73e6Cabydz1eyQAyKn0KrsketfjqJThznTtGEndBC0QIvTzKyN0Ir6+/cntK8VIro+u8xRBXt5IIsZOj0OUdDsRYWhubM2URG1/Tv3+K91ufVr6/904ZMWyOh1DmMB4P6QIRCy8xUumuj097+oSk4WkLxMB6849pcmzr3bbdol1kVecHBYN8ZD5K6MXIwe2+Nn7y66/GfKeEnno5RQN/bEjr18DfKpcVuNGPivGQle8JDQMKMs/RRIytrDttw5m8/y+zG9re8MrifBFOWEb94rFKrQ6WXpH/hXgwqPIML9to331o4BKJj/2cZuerjRK+sNljB/v4n0saNIcPqK/f2F0p+kZuo9jjUoY2n4m01PPAiHa4E51GlCKTLal24ZMDmTYQg0KyWSy16Jdiv5B5wAcPTVJP80nvwxQfSV5EJrLHrUhFwGGGiuMWEYPYqwiQxxSYg3Rhey0+YrPTU8FVN8wBYn53GoYVFEIyOmHdPFk4Red5cIcgismPDxxlU+LnZv8UswvSxgxYikkusjdUkC3DYCcMaJdAa7WpcF5Rn+Q9GeXq7LeZQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62660978-b836-452e-9066-08dc391c90af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 11:50:03.1412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFBDzGVchxJACCqRh1zvBhAvQ6sTE4d/yYNlYlEE8pzGlfWjbT7j+8JjqE/GMQMjvK1mAVX5/s99SRx5nKpzOt5lnh+Rl3rH+dalZfhnJkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4476
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290091
X-Proofpoint-ORIG-GUID: umdx6zDFY-xhgC1yAmvN_8eziIysq7t8
X-Proofpoint-GUID: umdx6zDFY-xhgC1yAmvN_8eziIysq7t8


On 07/02/2024 08:24, Saeed Mahameed wrote:
> @@ -328,6 +420,11 @@ static int mlx5ctl_probe(struct auxiliary_device *adev,
>   		goto abort;
>   	}
>   
> +	err = sysfs_create_link_nowarn(&mcdev->miscdev.this_device->kobj,
> +				       &mdev->device->kobj, "mdev");
> +	if (err)
> +		mlx5ctl_dbg(mcdev, "mlx5ctl: failed to create sysfs link err %d\n", err);
> +

Should this propagate the error to the caller?

What happens if/when mlx5ctl_remove()/sysfs_remove_link() gets called
later for this kobj?


Vegard

