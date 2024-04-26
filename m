Return-Path: <linux-kernel+bounces-160301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D11C18B3B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095191C224B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34991149DF6;
	Fri, 26 Apr 2024 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MQAOIBN5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VOJgj382"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FE9149C72
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145569; cv=fail; b=OBR8p9cBwDZkDBzqgDWSNbB9WQ/hlDJbwDtxSddDfycVBwt6h8ybYkQkg/E42lpPe/D2413fySZGCZtGPc2HC4srv7rsIcJwfSv7GcA2TDZuIbrti6+YQf1thVrqW6pGW0HQsuz+2agiJK5iMBfc+vXGSpQv1AQ7JwEzkxGO2Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145569; c=relaxed/simple;
	bh=CToZQlXu+INCnrGDJLRDrQQWjW/PPjubfA9b1QFGtPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Miz0EysnZGJoZ44H19pHrqv0il7eYevza4Q9N1Sfo/SLg4k8k4YY16nZXqj7D/Nk70od4HMfrasbgbq3IUes4ogk4A0L0T92Q/VgSUFdk+ja1UzAP/0K2jnozkVOx4cPG7VGWQbQexF3OnZDPvi8r+v5qhehngBcd/farlSqDfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MQAOIBN5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VOJgj382; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q8SqKM025094;
	Fri, 26 Apr 2024 15:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=570RvkqAfHrdTDRel+X2lM2cCJYFQhXuusfLyxn4G3M=;
 b=MQAOIBN5ZOdCzapXrI4O5vv/8qIvOEGM+aytpa+S3bWTAi6AQGB82AqTgzxUgIumFVOU
 aCinXsTG6ZdplfZX2Tm3/I10VZ4szM5JJfQQxdiszJXsG7O9DlimjGthMbS1xx4y7ErC
 oH1mWU54GRfOPo4wN7xK3rV6WpxlU57CjBgT86dnJ0HZ8NERLjsXKowddRGuNaW4lccq
 UscTLF93XQ1ZxSw1Ceo408D15zDV0602+nunxR1jUuwsCmIY1mJZarkIh94PzqeFoAjQ
 4nTkq5zaRH/Z5GYF9Gma0DPfMcapvUEKQZhwWiF+aRRDJOHXckBZtS/+66JcseaH6oUH tw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4nrs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 15:32:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43QEd3VR030853;
	Fri, 26 Apr 2024 15:32:27 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45bte8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 15:32:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAZq8uJwykqjvpw2fpVhjEeWLyZRv+V06MsVXehMHMB3StFIVLa0QH4RU078pcRrM5dhZf2tKexRSJ7TfeWYtd6Bq567TBpMHUqU4ovM0wuW+HNJykXinSPTg0ALBImBClaDQa9+WQRv68d7Gik6wniNZ52g1g74Y08T8H2OvBzYEVHxGs4IkFuKmXsJTs+epYxr3PSPLzah4AS79U8e86MI1jDQeUPIsnrNpStjPoQJO3XjH+WuMMifn/WQSiCMMU52TF/wZpjBF3u1twuCWRZiuQ0MUNPgh+KtYUdku6UikyIqAyKA6xzo6ViW0q/tO47/XumeFKFHZhsqiTQ63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=570RvkqAfHrdTDRel+X2lM2cCJYFQhXuusfLyxn4G3M=;
 b=m79oMZwfTiZiNT1iRtoNQlOMDcSsvxRNLmncGNT8fUbzeto83Oe/YUEXVkxyZkjuTX0IxxguUTlJLPpSWpvBVMw7TZnRwiuW55ONP1nt/L2KbDSKOMsQ3hYq7ElvxcndF52P1hPsSlfoeTI7Zr432uRK5KXG/+0Bs4ZFIMOv4i+vuyQanSFgrZ3ZiParbW9eJQqnB3kuAN8+ntbWIcDMMDQKRsRlPySrNRWyH81cGhWbVnMzOoUEXTwYwuEVbeWJUjvQVZjVKuIk22cP3Ug/oXWLq8n5WLDN97DjFpMZLKwhWxrvIiKF0G9pIpw1yvFvv8eV7zXJDdYwIv4UXi2/sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=570RvkqAfHrdTDRel+X2lM2cCJYFQhXuusfLyxn4G3M=;
 b=VOJgj382l1VhfUkseonobgaBVYe+h/EwP28lrYXzQ4ZycpS3oluPrPbnlUFcyyS9si5m2E/W/QRSyswBpv2qAJtPB1mj1WFvSo5Y+0fLksM9LrvDbAKPD7CJQ5tfH1/cG/oFXsXjPHlllWYQxJQ6VrSxmjIHEkHQA1gByfZ+ByM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY8PR10MB6516.namprd10.prod.outlook.com (2603:10b6:930:5c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 15:32:25 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.7472.045; Fri, 26 Apr 2024
 15:32:24 +0000
Date: Fri, 26 Apr 2024 11:32:22 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <bj2hysiacl5qb7ooridrwnvhgefqxfw3sgd3r2u3btaygft6vv@tuq4kvzxghai>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	Alistair Popple <apopple@nvidia.com>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <20240411171319.almhz23xulg4f7op@revolver>
 <ZhhSItiyLYBEdAX3@x1n>
 <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n>
 <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org>
 <ZiuzikG6-jDpbitv@casper.infradead.org>
 <CAJuCfpH+O0NYtTrGKSY6FjBOcWpyKXB+_4rsSRjcewSXUWVfCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpH+O0NYtTrGKSY6FjBOcWpyKXB+_4rsSRjcewSXUWVfCQ@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0264.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY8PR10MB6516:EE_
X-MS-Office365-Filtering-Correlation-Id: c07e8ed9-04e9-4d66-2d0d-08dc66061264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SFRNVGxPOEF5SGpURVBxdGdYTzJhUmtFc09XRVBRcEZCMWxqK1JwL2s2TU9D?=
 =?utf-8?B?alphT1kxbXo4RklweENxcTFjbnlBbnBGR29hdkZHaDdZcXQ0OWNCNGMycW1F?=
 =?utf-8?B?OTJTZUx5QWZLcFlDZzBFZTFjZVQ5blFsRGVseHFMcWN3Tyt0blA2cUNrUHoz?=
 =?utf-8?B?V1dsVDk0Y05OVEN6Umc0a2Vyd0lGWWptb0grcGVHdzR3d1NVd05XLzZSOWZT?=
 =?utf-8?B?OUZsY3dOZXNSR2JRVC9OU2NqdjRlRDF3VmlpaXBBWXZkYjdGQkJYbjZaeXR5?=
 =?utf-8?B?V1BmcmRQZFdCWGVnUXVFbDdTZkxpMTc1N2gzUlFCZURaQkE3YUx2eXlDVzNK?=
 =?utf-8?B?Y0FTVU1qdkFHWVFvblNONEtSM3AwOUhZNDEzc2hmOWNqZzlUaCtEcXhkVGU5?=
 =?utf-8?B?ak02eVlWdjZtTW4yQWJYbG1NT3M0T3lkdWNEc2duRHMvQjhIbmQxcUI2ZXBz?=
 =?utf-8?B?K0k1SHJ2WmliVE42clFzc3N4Z0JUTHVoRnB0VmFmdzZsbmtld0VZcjJEVTNh?=
 =?utf-8?B?STBoelpxYkE3c0R0bGJwZDJITUh1cm02a0JwU05la3RSS1ZLaytub05aazEz?=
 =?utf-8?B?SXdxQmFIRmVHbzZETVRTNVIyNHJIQjRJMUNFTHRzd3lsaUJYRWtvbEtsNk94?=
 =?utf-8?B?QkZNelM2Tm9nUHpEdEhmTDlhc01OaXN1ZUNQOVpkZElVLzdYQldublh0d2xv?=
 =?utf-8?B?cmdPZ2REQUtmMk9KU3lpNzBCb0hkSjdKSVJRMXNpalkzTTNEQ2JyUzR6TlRL?=
 =?utf-8?B?VnYyNE1ycFE1cnpyeHR1b0k0cUplUzJHNUJHOHZLa1Q2NndtL29lWWZnbk9F?=
 =?utf-8?B?b3RvVlU5a0VYVVp6QUdJRndBcm14RVUrWXNXSkpiUmN0UXA2Nng5RXhOV0Vn?=
 =?utf-8?B?dDRWaHR6RnNxa1JCcEZpMUJTdStqbDZMNURJVXMwRlI3NVc1L3p4UVIyTkF0?=
 =?utf-8?B?djZhWEZvYW9DbStqL0thSDlRb3luVjFJSm1CcnFZKzRNb085bnZWYm9pc3hv?=
 =?utf-8?B?SGJOL296KzM3V1JOakhEUGdzYXE4d2QyTmkzUmNjNUt4T3VvRlprRnVTdUp0?=
 =?utf-8?B?UldCOFZES0taeit0SHR6eFRlWUluSWcySXVQQlFDLzY4cm91c1lTUytsazUw?=
 =?utf-8?B?aHBmVmR3UHJEN2ZzSVc3MXk0bGpwNks4a3pheHhyQmZ1SkhPNWV2cWhLYmt4?=
 =?utf-8?B?VC9oVzYwRlcraTFlU1pXR25pQno1RlhWaGdyWmN4NS9qN1phRFNBMnZ6Y1da?=
 =?utf-8?B?b3dMdVBXNTBNakFBZkE0QjZFbGFIcUNubFNXbDNtTmxmWlIzTlYwN2lIaGFq?=
 =?utf-8?B?L1AreFB4MzFDMjQ5cHlJWFVYai95ekpVZ01KUnZkNEh5UnlsUWJVMCtmZkp2?=
 =?utf-8?B?SkVLWE1NQ2FwMFRMWVZ2N1V2cGI3b1FiQXd5UDVqV0NvQVAxaGdrVmx3YUVM?=
 =?utf-8?B?R1l3WTQ3MXVWUFdNMFRyV2pSNnYzeTQ5VEdScms4aGpHQitVeFhZOEZJU1A4?=
 =?utf-8?B?U2dUdWFRancvdk5VVkVoZmpaSE5TcSt3VjU3NXVLTkIvdWQ1SnFLVFpWV1pq?=
 =?utf-8?B?Rm5QUW15L2d6eTZuN3J1QTZsb2l5TXZrMXc0UG9MRHdXNGhEOE16MXhmU3px?=
 =?utf-8?Q?jKdOm9Ayqzit3C7rLiRdyoDyeZSqZy6764+XoJDzaU84=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bkJyQWxGc3RFSGZ4c2ZhYURZREVmOTdlR2FybDQxZkg1SFhuSTVnWi93bjlw?=
 =?utf-8?B?S255VXNCUkdSaERkNWNCWVczazkvcm9WOUxFKzMxcE93ZHZpVGF5MHBkbUlC?=
 =?utf-8?B?eXlNYjZsbG5zRW1sNUhZQTdMUm9qWGV3ekFnN1o3U1FPSWc0b3p2b1UrYkl3?=
 =?utf-8?B?bmRCQUhLNU1WWGVjWG1RU3JWTFQ2eWFNRzJPL2RBZjQxcjJxQnJyby9GMzVx?=
 =?utf-8?B?cXhGL2JyWkNmRS9ZMjhtR3gyNUsxSC8waEJVb1VwM1RkTHRmZnNmQTBYalN3?=
 =?utf-8?B?SXVGQ0ZKT2xFSkZCSElmeEFGb2tJVXZBS0M2L0FabWxOR3FaNjVEcXVNU29S?=
 =?utf-8?B?clRHenlGcXp6ZEZCa0JqalBwbnpBZDdkQ2p4N2F5bC9nL0VLVDV0UG5YMmdM?=
 =?utf-8?B?VFB0cE9OTWVIVlNCczY2ZElPNWY0Z0h2aFpXckMwVWRnS3FEdEorUm50bWpl?=
 =?utf-8?B?YXpsWjA0STdXYWZsZTZ2bnV3RHorQjhCV1VWYUJEWG0vYjEwTjlmZnhhVDZn?=
 =?utf-8?B?blc3SmZEUlRuNVZXYnJ5N3duYlA3Rlo1ZkMzRWp3Q3owdWpVNEdQK2lXZUVJ?=
 =?utf-8?B?QldKUW5VRS9tSkJaYUs3Y0p4SU5rMWNZZzJlTXptNzBCdC9ZOGZzWDl6NE5q?=
 =?utf-8?B?SGVvUTkyc080SDgxVXhCWFRVYUg2eFIvQk9nZHdhY2gvZ1MzaTJWd3B3ME5J?=
 =?utf-8?B?Sm11eW96bk1yVnlrODlxSExYZW5kUGs5dnFvV2VFZkNhSUdKclA2NUlRaE95?=
 =?utf-8?B?WkhXUlVlRU9HTFNmZHEvOEJzcGt4ZzZVK3BUOXFWTmIwK0tRK0M1S3g1ZEhX?=
 =?utf-8?B?ODVINDVaZnBuTDhNc2laNVdXOE9GYXhKRFBZNVB2dUsxd3g5UU9RWmM4NXhF?=
 =?utf-8?B?Ty9JRk9qWEs2NytsRFltbjBSblpvaERiNWl0bk80QXR5K0dQZVhUVGUrV3Nm?=
 =?utf-8?B?U0dIZENSWEl3ZmZ3Z3UwTDhwSVpKYmUzKzd1bGJySUREbHFodUhWK1ZFRVI3?=
 =?utf-8?B?YXpCUjFCMFhEVmh0elovS3lzaGRZYWJ1N1ZGbTRVMXZ5Y1NzdmtjdktVTU44?=
 =?utf-8?B?TVVyT0QvTnRJTjFRcHp0RXB5N2RiZzM4OVFsbmV0b2l1a0JKRHVyZkdLaXZU?=
 =?utf-8?B?SCtBQmtCQUpidk4vaFJ5N2ZmQkJJNEY1Nm5RUzBJTXhuakJubDByWm8zL3hp?=
 =?utf-8?B?azFkZ2ZKdXFlY2hlVEtKMTJCMEtHVVZOZURQcCt6OENtYWdIMWN0czdmYnZZ?=
 =?utf-8?B?OHRQcnI4K1VhZCtKUVJNM21reHRTc1ZaWkh4dkRrVG9hV2xsdGdveTFEdDJT?=
 =?utf-8?B?L29ubk55Zzh1c1h4MUlvVkU3bFhzajNKS3VpMGk1RVRJcFhxTW1hNVFNK2F3?=
 =?utf-8?B?WTNKNUlTOGljSlpuaWp0Uy9pUlRMdUZERUZMVGpLZ2dsbDgvNGZwUXNBRUZF?=
 =?utf-8?B?UGxKNDJYOENFOFU0NTNqVldJVlhNSWNqNlZ2ZkpYb1lEaXZnODBqWFpBeEJ3?=
 =?utf-8?B?YXdBRU14V1B0dVo5QjRiNkQrcFZtTmJZZFZpVE5KTlJkSExhRVhXempidEpG?=
 =?utf-8?B?VmthcUdodkhYSnp6L1hDMWdydjZYbXdNOTdWYzQ1czNFUXJSSUp5eGhVWklz?=
 =?utf-8?B?blJQL1hjYkwzK1JiZC9TdW84SElrVkdERTZvd2RjM1RHOFBzZkdPNUdSalFy?=
 =?utf-8?B?OXEyNUE3bk1uU211NW83WU91eWE2YkhCajV2VStrVEhXdTVxbjI4cFU3eWph?=
 =?utf-8?B?anBXMytBdnhzeTRvUUFCeWJDQUtURk5OeXFpS0R6UFNOUTZYcGtjcm03c2NG?=
 =?utf-8?B?SzFXVndiNzlZbWNPVEJ0c3Y4dlJRZVVBNXZYaGN1T1F6aXFyTTJJdWJDQ2xI?=
 =?utf-8?B?VWgwN05LVWtPaE5CV2pUQnUwWjBsRUhmWGovT3RETEs5VFg0VEF2NGVwcUpS?=
 =?utf-8?B?ZmVGam1rYWx2RTZ6SVVxTGkxZXJxNFZDTVZHb3FhNG9Pd2FoM0wza0l6cTNi?=
 =?utf-8?B?VlloM2lKOE5lWmRlWmdVdnA5UWQxSlJldjhwUlNHSUQ3S3hWK2VNVGtEMzky?=
 =?utf-8?B?Qys1cTQySE54ZVR3WmhTY0xGWTBIRTBzYW94S2RVeXpQVUJBVG5ITXJGa2hX?=
 =?utf-8?Q?FKLfNMde+hPhGErvu/6iWvhud?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	q9stWrPzbxdIJLLpcP2H8mdrhaF2oI2atOFDDR9xoyJ/6NKqaEbNNARchGkPNpK9y1iSrjCEKVMfS8UGX24b4G1yUJ8zsFRoq4PJf/JE35d6Lo3QTdoHQ8utqCPERTIWrJ00Tjq7N9AgH1rsW/SJ8Cg2/lH7hndQZdt02Lo/r0WvrH1e/5jYZrFiTZItppaJu7QOce3vzBAkZ1GAxOxULCTpMWZIJUFMWCXq99Usddnj/aTRyppRWkEcJxuo59/0qsW9ser6NV8JMPSyrPDhMWeIIKwDXhWncgk469M1KTRb1QcfsR2mosBv7iPfkLB/MIqTD54khoxjBNaDD5yg02xEqfRFEy2iyhZYF2OwOJkETOIDqyaxcQJAJ18ArspgiCuszds8lUtTHVuIT0Y29LO8BYNYmkO1d6rWsR4UGliv6ka2SfkOOWSui3uObMk+nqLgTcnk/myskWKZhqyFJ3nxXDOMpfqCfXl+QjI/m9swgYAX+p6IdLhCT9A7rZ7gYUmWwnL2e3OJGxtLHL1GFu5Omqw66vbJhOgQEdxzcyprLsTK1ge7+KgQpAikSBH4mP/cfCFHCvcYJzIPIzVSJnwEebQI2a5p5wF4ALI8l5k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07e8ed9-04e9-4d66-2d0d-08dc66061264
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 15:32:24.5813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oi9IVEbFmPD+J6t2PoLNTpaYQot/FzLfoKoVcwGUnZpfeueR6z7+efwhzuxAH6azs+ut4uTuTHYljTyrfxDeLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6516
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404260104
X-Proofpoint-GUID: dXNUs5bm5euQTrgUraR2ZVmAyCdTohks
X-Proofpoint-ORIG-GUID: dXNUs5bm5euQTrgUraR2ZVmAyCdTohks

* Suren Baghdasaryan <surenb@google.com> [240426 11:08]:
> On Fri, Apr 26, 2024 at 7:00=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Fri, Apr 12, 2024 at 04:14:16AM +0100, Matthew Wilcox wrote:
> > > Suren, what would you think to this?
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 6e2fe960473d..e495adcbe968 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -5821,15 +5821,6 @@ struct vm_area_struct *lock_vma_under_rcu(stru=
ct mm_struct *mm,
> > >         if (!vma_start_read(vma))
> > >                 goto inval;
> > >
> > > -       /*
> > > -        * find_mergeable_anon_vma uses adjacent vmas which are not l=
ocked.
> > > -        * This check must happen after vma_start_read(); otherwise, =
a
> > > -        * concurrent mremap() with MREMAP_DONTUNMAP could dissociate=
 the VMA
> > > -        * from its anon_vma.
> > > -        */
> > > -       if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
> > > -               goto inval_end_read;
> > > -
> > >         /* Check since vm_start/vm_end might change before we lock th=
e VMA */
> > >         if (unlikely(address < vma->vm_start || address >=3D vma->vm_=
end))
> > >                 goto inval_end_read;
> > >
> > > That takes a few insns out of the page fault path (good!) at the cost
> > > of one extra trip around the fault handler for the first fault on an
> > > anon vma.  It makes the file & anon paths more similar to each other
> > > (good!)
> > >
> > > We'd need some data to be sure it's really a win, but less code is
> > > always good.
> >
> > Intel's 0day got back to me with data and it's ridiculously good.
> > Headline figure: over 3x throughput improvement with vm-scalability
> > https://lore.kernel.org/all/202404261055.c5e24608-oliver.sang@intel.com=
/
> >
> > I can't see why it's that good.  It shouldn't be that good.  I'm
> > seeing big numbers here:
> >
> >       4366 =C4=85  2%    +565.6%      29061        perf-stat.overall.cy=
cles-between-cache-misses
> >
> > and the code being deleted is only checking vma->vm_ops and
> > vma->anon_vma.  Surely that cache line is referenced so frequently
> > during pagefault that deleting a reference here will make no difference
> > at all?
>=20
> That indeed looks overly good. Sorry, I didn't have a chance to run
> the benchmarks on my side yet because of the ongoing Android bootcamp
> this week.
>=20
> >
> > We've clearly got an inlining change.  viz:
> >
> >      72.57           -72.6        0.00        perf-profile.calltrace.cy=
cles-pp.exc_page_fault.asm_exc_page_fault.do_access
> >      73.28           -72.6        0.70        perf-profile.calltrace.cy=
cles-pp.asm_exc_page_fault.do_access
> >      72.55           -72.5        0.00        perf-profile.calltrace.cy=
cles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
> >      69.93           -69.9        0.00        perf-profile.calltrace.cy=
cles-pp.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page=
_fault.do_access
> >      69.12           -69.1        0.00        perf-profile.calltrace.cy=
cles-pp.down_read_killable.lock_mm_and_find_vma.do_user_addr_fault.exc_page=
_fault.asm_exc_page_fault
> >      68.78           -68.8        0.00        perf-profile.calltrace.cy=
cles-pp.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma.do=
_user_addr_fault.exc_page_fault
> >      65.78           -65.8        0.00        perf-profile.calltrace.cy=
cles-pp._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read_killable.lock=
_mm_and_find_vma.do_user_addr_fault
> >      65.43           -65.4        0.00        perf-profile.calltrace.cy=
cles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_read=
_slowpath.down_read_killable.lock_mm_and_find_vma
> >
> >      11.22           +86.5       97.68        perf-profile.calltrace.cy=
cles-pp.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.ent=
ry_SYSCALL_64_after_hwframe
> >      11.14           +86.5       97.66        perf-profile.calltrace.cy=
cles-pp.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mm=
ap_pgoff.do_syscall_64
> >       3.17 =C4=85  2%     +94.0       97.12        perf-profile.calltra=
ce.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_=
write_killable.vm_mmap_pgoff
> >       3.45 =C4=85  2%     +94.1       97.59        perf-profile.calltra=
ce.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_kil=
lable.vm_mmap_pgoff.ksys_mmap_pgoff
> >       0.00           +98.2       98.15        perf-profile.calltrace.cy=
cles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_=
hwframe
> >       0.00           +98.2       98.16        perf-profile.calltrace.cy=
cles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >
> > so maybe the compiler has been able to eliminate some loads from
> > contended cachelines?
> >
> >     703147           -87.6%      87147 =C4=85  2%  perf-stat.ps.context=
-switches
> >     663.67 =C4=85  5%   +7551.9%      50783        vm-scalability.time.=
involuntary_context_switches
> >  1.105e+08           -86.7%   14697764 =C4=85  2%  vm-scalability.time.=
voluntary_context_switches
> >
> > indicates to me that we're taking the mmap rwsem far less often (those
> > would be accounted as voluntary context switches).
> >
> > So maybe the cache miss reduction is a consequence of just running for
> > longer before being preempted.
> >
> > I still don't understand why we have to take the mmap_sem less often.
> > Is there perhaps a VMA for which we have a NULL vm_ops, but don't set
> > an anon_vma on a page fault?
>=20
> I think the only path in either do_anonymous_page() or
> do_huge_pmd_anonymous_page() that skips calling anon_vma_prepare() is
> the "Use the zero-page for reads" here:
> https://elixir.bootlin.com/linux/latest/source/mm/memory.c#L4265. I
> didn't look into this particular benchmark yet but will try it out
> once I have some time to benchmark your change.
>=20

This test is read-only:
https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree=
/case-small-allocs-mt

And the zero-page looks to be what's going on here to me as well.

Would such a change have impact on people who "fault in" the memory
instead of asking for memory to be populated through an API?

Thanks,
Liam

