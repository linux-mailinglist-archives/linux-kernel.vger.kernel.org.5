Return-Path: <linux-kernel+bounces-160526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C6B8B3EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D442831DB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D750D168AEA;
	Fri, 26 Apr 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oJt+KRjo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MQYftB5z"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF345037
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714154276; cv=fail; b=oOVDaSbaGy5NfS6xI/G+xsJTQ5A3BQZLi49lKhuxjxt1aOeteGzoed1P0JeBkPW+wN7UcxcSlsYS5+XwytjU1sCV4KXPp4kdns9lA6ZYfKLI/EekOTbi2qzIzxxlNIR0eUjEZGtPWDRYBzgbx/bTUrn+1phAKeVdSbTZoxA+Xkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714154276; c=relaxed/simple;
	bh=3PAH2QUsau+8ysM1nxMZcucln2J7VzGhTJuabwLAZto=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oa/BzvhfRdBvUclAegyCS2pL+scUatKaLX7APOzWI1uI+G0H5gBt9b4a8uJYKQTjwxJAWeKZkk9Kerf5oJJX5YC4NHq5nGio3geDyTPLlG9r0NIE/KZW5t/5wFseO+J4Qaybqwdilge96/P677EU5Uhu1tOj4QtQK13c0AGL6X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oJt+KRjo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MQYftB5z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43QHMs98014205;
	Fri, 26 Apr 2024 17:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=DgZDy5VveJDaHDWfoM9dWaMNm7mj/l0zILZkTpWkwRU=;
 b=oJt+KRjoOh8A9M5XGvt4OO4ZPv2Ol7lJsG0iyHp6/UPUTF+uvdnKHJ/57aG2GaQjKcny
 KVSogYcMQRzTO1MU9XYUJo5APebtCLFvlYc/d97k/L7h4SpsA/PKJoUQFyjpGqxRowgV
 JpUdRitqoUK8XndVuFPIkFttBJzl1mUHfffdFfFmP+pI41obHDgcSa0c5koFKWL/FdTB
 CnDsrujhmEv8H6scw1xAZJA4HJ8uuMyh4DM0Hr/RL2NZY/sfD/Js/QUCpDucWZst6AoR
 Ji2aNP/usb/dMha9BQRwPj85yJ6gal//xtxxL4kAzSkYFXqodmmkjapTozZiexnFfVYw JA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5re64dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 17:57:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43QGDm76035593;
	Fri, 26 Apr 2024 17:57:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45bxv6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 17:57:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4jlKibp1MH1HCgAnkh3rxjlcfmiUvXhCkLMw0raswQOXxdAIxsKQEQNqsO9g9iC1V4DlLadwxdcX+Tfz3vIdTy/6iYblD6zVHwV7Ry24DR7lqtaLrMWsFCCVZqwSYVlsiPql57RjeyfSIJ6ttXzpS+5Y0EbElKW0qJEftqY02PnJHG8s4RU5Ehgl3UeSAs/KyzMw71ID4LG4cuBucbp0m0Qe9qnA0mwRIq5h7PUjCdGuyiw6WcWTYWjfFuV5BFYPnVF8bd9eaG5l0EsXxmYOhBlAipzxmTkagVX21uCw0kqegAUpSINhf1OJF63A1wWfJLM9zeOY4yRm+Y52ftcGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgZDy5VveJDaHDWfoM9dWaMNm7mj/l0zILZkTpWkwRU=;
 b=UHWCyXY6ClG0Ua7XXabJaXHUzQTnzhAwT1DFJlKmTrlbtM8ZJedvhHMWxaFfiTySHTe2EcrYxd3sV4XLmq6rk87RKwtA+G+82w9axFgPiCGO/KxpbPWNCwy/TBWCskezC9uCcLKLf9Bx1olicWARKoHhqiqxTH08kYgzAOZ1Fsx/MSsxR7l80li8UlIT6w99n0jLYWZRRUhzXVClJNw8raehowFBttCRvsbBXrlQF26pow9w9NgP+YSjESvuIiQ8VTRvLEcnRMpei5bituI2jUGFURHdjrhX/h7lxJmWRAZeL6Z+G2CK11PziUwPCxuIgXsWFOnyu5HK9eOM6NavsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgZDy5VveJDaHDWfoM9dWaMNm7mj/l0zILZkTpWkwRU=;
 b=MQYftB5zEUPh38GW3QzvXwPy69VGaB3Ttb/vLw5bVlRpEKJeZqYNEwggQO+Cwdfkc0SUzlJQBs1QfI+wwQRp+fO5iVXPe1W5LMM3wVJlxle0z7Rb0Jzrl/WEW3sX/TdKnkzP+L3FfLDQKEH/EumUcbC/kulRoi4JkjgBQKPVe4U=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA1PR10MB7755.namprd10.prod.outlook.com (2603:10b6:806:3ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 17:57:34 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%4]) with mapi id 15.20.7519.030; Fri, 26 Apr 2024
 17:57:34 +0000
Message-ID: <d05cbf22-f3e8-414a-a2e3-03e0b857eaca@oracle.com>
Date: Fri, 26 Apr 2024 10:57:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory-failure: remove shake_page()
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, linmiaohe@huawei.com, jane.chu@oracle.com,
        nao.horiguchi@gmail.com, osalvador@suse.de
References: <20240426171511.122887-1-sidhartha.kumar@oracle.com>
 <ZivlrMAwRI6xJhc-@casper.infradead.org>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <ZivlrMAwRI6xJhc-@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::27) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA1PR10MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdfebe2-bc12-4c05-42e4-08dc661a599d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VTI5RGNOQmhpMEdzUEhZWHF1cUlZckRBcEpWZnZ0T1Z5VkwvTkk4RWl2Zk5Y?=
 =?utf-8?B?NVJtNkxIMFVObFJpRTRUU0cvczJNUTU1akFwUHVMTWtnbmpFRUFoaEc0VWU1?=
 =?utf-8?B?dVozdnZuOHlMWTJKeTRoNm00QVU2WEswK3BrL3N2aGFVbEVHRlZqV1hzQ2VM?=
 =?utf-8?B?ZEllYjVjbVUxWm9Vdk1lS2tuN3A1UE9PS3BOVlNhcWJydkNTNHhIUnNLVDdV?=
 =?utf-8?B?b1E5YWNkZ0J6VnhpYlQ4SVB6bUFPYVYrR3RMTFFmNjZRZmxKUFRmRDZYRHRC?=
 =?utf-8?B?cERMRUNhUVJsVGg3ZnpXQTRuMDIyUXJxWm5pZUh5STZyYW0xcGVuUXpiSURT?=
 =?utf-8?B?T2Iya1MvS0xOVzBNcTdMdDc4R0VNRERhM242SmdCSTB3NjlhTmNFOEZRZUVm?=
 =?utf-8?B?Nnh3bldrcEtRVUNyWGRjMmdGdDF6V2hPWTA4WnRqNFAzc3g3eEJFNXEvVnJn?=
 =?utf-8?B?SEJtbVBPUWkzRjRsSnA3V2lwK3IycGZPSXhRZ05tTXhnaDhhRzBJSHU0cERG?=
 =?utf-8?B?RHFnaTh2clBkWDNiZGpCL013VFQxeGFRV0RTbjhzTXhPM0h2M0pua0tPaEk4?=
 =?utf-8?B?bk1NWEZ0THE5aFhrMW1kRmZ5S0R1ZUhIQ2s4cW5qb0hGWTdTaWZXUjRwSzJC?=
 =?utf-8?B?b0FsQmJiZXppODhTSWJqZFlkSFIxNUtPZHFXcG5uMExFM1VqcE5Ibi96SlhT?=
 =?utf-8?B?bXUrdzdvaU50c2FrdTBsVEt3TUhVUU5DL3Nrb3pRYmpndGE1TS9jT3d4THJ0?=
 =?utf-8?B?aW1SRFlUTEhkSVdadkVDZ0lTNmZJZzJaQVIyWUFiTThuNlBVVTRIc2FTYUF5?=
 =?utf-8?B?cGticXBVQm1TZG9WeXUzQktYeWhEWHcxS0pPSnpKM1V2S3hJSW03YmEvRi9s?=
 =?utf-8?B?U3NoMnFncHlXeWJMWmVIcWc0dXQ0S01pb2c1VEVDNEVXUTVZLzF4c3dYSUc3?=
 =?utf-8?B?cC9vTlE2NTZXNGRQV2RYK0Z2ZldyTVVNTzNwQnVLN016dTBCQUZoY0pDMTM3?=
 =?utf-8?B?SzAwNTFCcjRTMmI2RzREakt6ZHh1RFQya1RIbDBhZmlHMjF3TFVYa0xKVEtv?=
 =?utf-8?B?eWtnLzg0bFgxTFlORWZueFBrQmxxT0xnNTBNTDdkRjdkcy90OUN2STliRXVF?=
 =?utf-8?B?K28wWHZTLzQ5T1FSWFdxQ0htdWZiU0FuS1FmcWdrcVpUWUREWEtDVTdPdDVR?=
 =?utf-8?B?cDJjTCtOa0xWUTRBcXJXQW0xRUZ4MVR4U294aGN0dUd1UnFPd1dVZlorMUJh?=
 =?utf-8?B?TloxaDI3VHN3ekM2Zi9NNzV0K2tFVVN5SE9YdENBeC9WV29oWW1zSk1zT2g5?=
 =?utf-8?B?ckRqcy9taXI5OGtaeks1cHk3M3AxVUMzTGV2UytSUGVQQzFubFhzUStTa2pX?=
 =?utf-8?B?d0M5aHZzdlhuWDBuYVNaaHRWREFSMk9uM25VTmN6aERjdkJPNUJTc3IrR2ox?=
 =?utf-8?B?M28yOXk2UVJFN2c3dS9Mdm9MQ1BONVIwQ2NNbGg5QitZbEs5V0wrcXM1bXFl?=
 =?utf-8?B?ekt1SGZLb01PRWtLazdhcy8yMzFnZUI0eFVEdzNTQ08vZ1hZN2ZWejYrTnov?=
 =?utf-8?B?Q0Y2UEhhNm43Z1J4L1dXWnhMQjZJZStQaXo5eTg4WHkzMnBCSzNCZmtuMTJr?=
 =?utf-8?B?QnZuc3JocGd6SjJBNUcveHVxNEdXNUJkMGxaTWVOcEdhbXRFUG5yVDVWUFBj?=
 =?utf-8?B?QUdlbFBQemdHWXpIZVM3YjRDQkRQaTRGZGd5TDVEa0diY0xnRlBVU1ZRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aDV2SktlSkh5aDRzZWNnZFcxcWYzaUhuWFBzblhZWTJ5cEZlQjF2c1pKWDQ2?=
 =?utf-8?B?dnBlbUFPN1BZZHBGSU5WQTRiZVpkK01pYmgzR1d2OWxwM3JGTEF6b2xMZEhI?=
 =?utf-8?B?S0RZZGk5RWdSMUFpd1hxSG5QK1dIWlZuZTFhYSs2cU1PSlNUWmhkSEpzODEx?=
 =?utf-8?B?S1ZYZ0JKVlJBVmJlTGR6QktBNTBJb3NVZ1p5N3MrZ1ZQdi9ETXRFMWpPc3Jk?=
 =?utf-8?B?Zmh5UVI1UTY5QkcrMTBkc3NVUnE0TGFaMHJwc29nMmo3VFJFOUFCOU05dFAv?=
 =?utf-8?B?aERURHV4MU9ITHh0Sm5wdkxJdThpR0srNlpnL1Bkb2tIWW9RWDc2ZUNJdDFu?=
 =?utf-8?B?L2NZa0NxK2daNmk0dkdTMzNLUFU2M3lrZGlYTnpSRmVOTk1YWE9oV0l0cGVF?=
 =?utf-8?B?cm15N0RaUy9McDlLZmpzcjNzWTdxTSs4ZW9zMUp5T2VkTXZOOVBDYzBBM0lW?=
 =?utf-8?B?cEQwREd3cERSdXlXS3R3elJDQVNKQlUrb2xMbjR1SDIwYXNteHlrcXp0YWkw?=
 =?utf-8?B?MFVKTDZsVTZIejBZUWNDZFZ5OVdOWjBveGs3Qmo1dVRoMThmb1BPY3lXRWFi?=
 =?utf-8?B?bytsUUxFamR5NkNKb3IrWDNxUzdFdTQ3UFVnaldHQmRUTEYzd1l6cHp4R2xX?=
 =?utf-8?B?M1AvbjdzWCtISkZwM2ZSeVZMM3dCc3QxeWtBbVB6ZVNuVmxwMklUV3owU1hz?=
 =?utf-8?B?S2IxOFZvYjRsVjU5V2Qwc0Y3S3o0S0pkd1l5aGNZSVd5T1BPdmdRSnRaVHFN?=
 =?utf-8?B?TmFBQS9lUkFjVHMzS2NUaHQ4WTBVVkticFZuTzhFY0p2T2M0QzJPaVAyMElN?=
 =?utf-8?B?eW5McjZCbWpHZEVnY1pwNEhRaUo2NjUvbE8vWGthT3BmcUdPaWVhSE10cmJ0?=
 =?utf-8?B?ejExMFY2RzUwcFVWU1UrOXd0M2dGdWo5OVJ2Y2Z1TkVDVjRBWW5peUJCQ1Zk?=
 =?utf-8?B?V0NiakZjbmd1TS9NMzJheGxhQmNYVytwVTE4TlZ3QTBNLzduTlhZb0NCa1A0?=
 =?utf-8?B?Y0xiSzE5QnFNM1NiNGlPZ0dBeDdjZEV1MWhRV1ZMbjc4WlhYbk5YME5hSm5q?=
 =?utf-8?B?L1BhekFaMGlKSlI1dy8zYnFkRlpYSGhCbnhlbTBielVqK0tIdTVjcjkvRUk4?=
 =?utf-8?B?MUptbGhUNUlSTGRwRFVvNjN1NWNWSExVVGJYN0xwSlp3M2l2VXBKNEdrUGgw?=
 =?utf-8?B?bytUeWdjL1FQYXVXQmhVODlxRjEvcVdhTnd6b01TeFg5bjV3c2k5Yk10Z1lt?=
 =?utf-8?B?TDJJUlh2aElJQkdadkVJdm5mb2ZOOWFrLzBrTGhaejEvRTVkc1RmTGRFb2VW?=
 =?utf-8?B?TDlQYXZoYnY3MFVDaUcwMnhTU3FEVnZsSmUvMEJqS2M3V3llWG9BeU55d0tY?=
 =?utf-8?B?OHlvNEpRVGl3VVNCWU83amVMbXJqemt5a3ZhclhZTUlMQ0VHWjkxR0dlMkw3?=
 =?utf-8?B?VXRDOXhhTjNNclM0ZS9HNUN2Smo0TWY5OHltR3pUd1daNG5CcmN2QWFYNnow?=
 =?utf-8?B?aXZmYXhyNnZkN0FhME5QNERvbW5LbjEzSURqbFpGbkNobjZ5MGNEQjllclEx?=
 =?utf-8?B?a3hzM0huN29QbHRzd3MzMmRhZ0x2SVFlb3dVN1hhRjhhQVY2VUg2c0MyaDYv?=
 =?utf-8?B?OEVNSGIwcUQrQTk4a3JFb1lPbjIvbEtXS2VXSVo5SFZpdjR6TFBIR0g0VWZs?=
 =?utf-8?B?cUR1c2QrdWJ3bzR0K2ZCbVhsWVpvbkY3cHZXSXdIaHJvelZCaUFSbUJ6b0Zt?=
 =?utf-8?B?aW5KU2tnQUJWNE02VVg4MUwwc3lNWWVONWMzU2J1a3VUTlNNT25jeEIrWXlV?=
 =?utf-8?B?OTNTL3l4bWNPKy82RUtSeGxSMUFmYitlejEraktITUhPVGVkWDV1TUNIclRS?=
 =?utf-8?B?RUQ4bW1MOWlpR2cweDRwaTFuNWRybElsVmxYeWgzNWpuRkNZK2wya3hPSk9z?=
 =?utf-8?B?UWpZamFZTlRCLzRsOHFoMWN6SjB5Szk5K0xkZkxOdmQ2ejRtOFhtekJGNG56?=
 =?utf-8?B?UEdDL0xZdCtFdVBwWVAvbytZdm02Um5BTGFjVnFlY1ZEbU42YkJ1MStrSC9y?=
 =?utf-8?B?WmZ4SGZadEVPLzlVS1hTb1B5VjI1aDBnQlNqaGx4bTFtd2gyYVJySEx4OXZq?=
 =?utf-8?B?RzVKSWduMTVPaFFwSGliQjVhMEdPd3FBMVlNcjh0ZUxPcXRHc3FLcStXTmR3?=
 =?utf-8?Q?BGFT4bH8EML68KMObpn1HaI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2zsVN+sJjbUW5dq5wWL9cYMwD5VHKS3/Vg9e+/gVB9I1DPNDwMaWy8zG+NfyJYM0neV6mCf+B5/rnFQfe6PR9Qz/GRrrwlf567azaym1BTe75YC8IrZ0RSsgsu1uOTn6Mh/tG4wzv1lU6B1svYMrcqvuWULsAAnwREUSoPfW6Ess0Zox6EJk4pPB65YHvwPJTGxOh/Mv07Ll/SFi+cNwRo0QdkmMUeUOpsix7g3FCohAw61gxzGSV6leEXiugTlz8wsd+E7vi/QVyNB/vTOrTNtRVfO+2nB2TMyykJSKn+p8zAu8Pom34vIK1e2Y9dbzecCQMgs5TF3AG/RilpYnlrzjzlequp6dA0oAOVstZnAxy2xcz/5DVP201XG8R1d30ZbLVXCYWHejq5Fir/hXhLYv6JkIG6jayb8B5OxIPd57ZwCSyW8/8sRGKg8j3qiyvtfOAaQp5/W/Voa+IPS/LM9GWELiNGJuo7xMs62vlC5KiCuX830kKj6kfin+NmGmlLt8tl4qO1vsVcG4WJtLEjkBj8MunfuF5VKT3QudFgRNiwxL2WONeFjDgpWJQdID6B1esmYZS2rdW8MQllpRoHSOzHmb2oi6QfivAzq+vO4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdfebe2-bc12-4c05-42e4-08dc661a599d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 17:57:34.0255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4ILFnVfiXg/YzjCsTurY0s8OATp6aszmxtGc39QKC1eSU+NoIWqa6wvy1Xr8jaBaStqatfAIvHP5d8otVcxjW7Ca1OexNLj/t6knHho/pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260121
X-Proofpoint-ORIG-GUID: yWwfYh0qEMJLbulcdTedWl7kB8QHnbIr
X-Proofpoint-GUID: yWwfYh0qEMJLbulcdTedWl7kB8QHnbIr

On 4/26/24 10:34 AM, Matthew Wilcox wrote:
> On Fri, Apr 26, 2024 at 10:15:11AM -0700, Sidhartha Kumar wrote:
>> Use a folio in get_any_page() to save 5 calls to compound head and
>> convert the last user of shake_page() to shake_folio(). This allows us
>> to remove the shake_page() definition.
> 
> So I didn't do this before because I wasn't convinced it was safe.
> We don't have a refcount on the folio, so the page might no longer
> be part of this folio by the time we get the refcount on the folio.
> 
> I'd really like to see some argumentation for why this is safe.

If I moved down the folio = page_folio() line to after we verify 
__get_hwpoison_page() has returned 1, which indicates the reference count was 
successfully incremented via foliO_try_get(), that means the folio conversion 
would happen after we have a refcount. In the case we don't call 
__get_hwpoison_page(), that means the MF_COUNT_INCREASED flag is set. This means 
the page has existing users so that path would be safe as well. So I think this 
is safe after moving page_folio() after __get_hwpoison_page().

Does that seem correct?

Thanks,
Sid




> 
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>>   mm/memory-failure.c | 20 ++++++++------------
>>   1 file changed, 8 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 16ada4fb02b79..273f6fef29f25 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -385,11 +385,6 @@ void shake_folio(struct folio *folio)
>>   }
>>   EXPORT_SYMBOL_GPL(shake_folio);
>>   
>> -static void shake_page(struct page *page)
>> -{
>> -	shake_folio(page_folio(page));
>> -}
>> -
>>   static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
>>   		unsigned long address)
>>   {
>> @@ -1433,6 +1428,7 @@ static int get_any_page(struct page *p, unsigned long flags)
>>   {
>>   	int ret = 0, pass = 0;
>>   	bool count_increased = false;
>> +	struct folio *folio = page_folio(p);
>>   
>>   	if (flags & MF_COUNT_INCREASED)
>>   		count_increased = true;
>> @@ -1446,7 +1442,7 @@ static int get_any_page(struct page *p, unsigned long flags)
>>   				if (pass++ < 3)
>>   					goto try_again;
>>   				ret = -EBUSY;
>> -			} else if (!PageHuge(p) && !is_free_buddy_page(p)) {
>> +			} else if (!folio_test_hugetlb(folio) && !is_free_buddy_page(p)) {
>>   				/* We raced with put_page, retry. */
>>   				if (pass++ < 3)
>>   					goto try_again;
>> @@ -1459,7 +1455,7 @@ static int get_any_page(struct page *p, unsigned long flags)
>>   			 * page, retry.
>>   			 */
>>   			if (pass++ < 3) {
>> -				shake_page(p);
>> +				shake_folio(folio);
>>   				goto try_again;
>>   			}
>>   			ret = -EIO;
>> @@ -1467,7 +1463,7 @@ static int get_any_page(struct page *p, unsigned long flags)
>>   		}
>>   	}
>>   
>> -	if (PageHuge(p) || HWPoisonHandlable(p, flags)) {
>> +	if (folio_test_hugetlb(folio) || HWPoisonHandlable(p, flags)) {
>>   		ret = 1;
>>   	} else {
>>   		/*
>> @@ -1475,12 +1471,12 @@ static int get_any_page(struct page *p, unsigned long flags)
>>   		 * it into something we can handle.
>>   		 */
>>   		if (pass++ < 3) {
>> -			put_page(p);
>> -			shake_page(p);
>> +			folio_put(folio);
>> +			shake_folio(folio);
>>   			count_increased = false;
>>   			goto try_again;
>>   		}
>> -		put_page(p);
>> +		folio_put(folio);
>>   		ret = -EIO;
>>   	}
>>   out:
>> @@ -1643,7 +1639,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
>>   
>>   	/*
>>   	 * try_to_unmap() might put mlocked page in lru cache, so call
>> -	 * shake_page() again to ensure that it's flushed.
>> +	 * shake_folio() again to ensure that it's flushed.
>>   	 */
>>   	if (mlocked)
>>   		shake_folio(folio);
>> -- 
>> 2.44.0
>>
> 


