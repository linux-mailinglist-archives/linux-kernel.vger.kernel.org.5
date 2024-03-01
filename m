Return-Path: <linux-kernel+bounces-88379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D811A86E0C7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8C11F22D3D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF816D50A;
	Fri,  1 Mar 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QmT3L1VV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="udgeHS1m"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D4F5F483;
	Fri,  1 Mar 2024 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709294403; cv=fail; b=cs60mFgPWMJ5GXloNRzTEDbUfeZ7yw7vHMi8tUt+Mydt/vi7oNIp0OJLemEf4kxWgEdfuowkauiKrj6Dv/tVAbXIugl0kBkkrLIquwrEdpmejh9QkKZZ7e6qtDlbAk4O10axsliYmRgMXGgug4BkSE+0cF5s7KL+LE3NWcASYzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709294403; c=relaxed/simple;
	bh=kHijnn6v1I9HNShuB+5Igmvg4DE5NEOywasAyRoBU88=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CCNNBziWtviSN2GXAAqfeHeVC9RcJcyb5wlFgqIVjbEGsGUr+1z1SIQOEB0Rrh2EmQXGnUFlnFiQa4r8bhW5Vij8dEFXQlDpd2pb156xd2N4IFS/o6az3zlE0JN3nveJZLuf5qnDW5C7lvUrVqEEUONwjjN4K0O0XbWiHIg1aSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QmT3L1VV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=udgeHS1m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42195KV9012326;
	Fri, 1 Mar 2024 11:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xT1SPJhU8mNMtzHua7eAqJZdqVXyIlCo0VCQN/vBsJE=;
 b=QmT3L1VVmuuINA1eCWrXgjseqT4+Xy8C9+cYfxm5Tni/HTzA7y5fssC4jFtkqEXh9z8z
 Mgxdj82Onls/7RIIBPrIWzGK5CccGBoFGb+5UBl7yMel6tKjbvH6DmPHTFNGrFtv1IND
 tel51GFrmIyYPf+6oq8whUh4L+pZzw/kXNiGCJDOVQ/79mDl6YjvAU1QEdSkf6FPO2+p
 zIja7u66ZZnNt1KvmrqoWqqyrOfF5ILh/iRda59rji3a2zUsveGtMyrOT1AXTsKXLfGG
 nJ0a43wf9S78xA/Vsem2IpFf9+iQn/avT2ocZZsHDOwmK+DeMJf0Qpz2SJyHWhN/S0ib Nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gdrxt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 11:57:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 421B2DbJ009437;
	Fri, 1 Mar 2024 11:57:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wjrqmq256-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 11:57:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X52j+kscEU4HJolwitBosCdMS2fESIkSjSKk2HaT2gu2Ci16ciGiR87+FPGJHoYwJr3NzpO2c8k+OIvpQXUuaqkPrBz9X1CE/VN4MCn4iV3yeNIsSWCYR9ehO/NqfMging4FZFZVb2qeuK4zCzNZJVTXxG5jvbIgJK4osOZ05mRbRC/bTP95kAqFoF620CAHrkEJU5OlJcFSfBymaGMc38mxw0QBF1uSCOlnyP+ZB/Wz5yTRqgiO0/TsjpEVrM45D2CyPPbJsPaC+QMhL6IZdHMMw5wTc5Se7MaPnt36Y1Xyy5jPdszKtZ9SRHMgWdfnF/RsjAjzv1Dvt+ESZuUVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xT1SPJhU8mNMtzHua7eAqJZdqVXyIlCo0VCQN/vBsJE=;
 b=cEcwP9x4ZD7N3pVbVoyjXGYlMUT3DjDtYyuUo+UHumB+NXYQoeEdHdVWJhbMT19VsakrjfX4w7EcHpkAr7iFgt4Keng76LvDpikv5RvysVMxWWWwsx7nACk9WmofOgQV6CYMXcOc69LYLxUclrzljeIH0OSfkoWQoqFIVWwqgyRqxd8y1F0DicFp2K935u4ivGXUyklg1hkN/QMBgZpEs2IdQloBTgu1H/44o3KcWG5F1eItUniuN2oPNwXXDjuRWL/FHrU63/iCWKeoln7RbhunL2QijSHHURUt8r9IJXgFCrZbE9sxaTwr1EiNC+LRUWVNXYonxFLtAS8xRNs25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT1SPJhU8mNMtzHua7eAqJZdqVXyIlCo0VCQN/vBsJE=;
 b=udgeHS1m4KOjzoUO5+lh1tDf9MiQy7zlYnEvXPA4f28gnIelUm9TUw+u10hS/FM3056eUuRb76SETY1F3ZaljN/G17pQEvoQ/TvuLpCtd6yFsTGMu+vl5lyI3qGbTctI/KpCvo5ZNW9v982JcogKa2aD3H1y+t41yMhS/DK+xr8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV8PR10MB7823.namprd10.prod.outlook.com (2603:10b6:408:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 11:57:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%3]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 11:57:40 +0000
Message-ID: <b10df0c1-5d8a-4c4d-b8bd-c0dbb53ea0d1@oracle.com>
Date: Fri, 1 Mar 2024 11:57:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] scsi: libsas: Define NCQ Priority sysfs attributes
 for SATA devices
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel <cassel@kernel.org>, Jason Yan <yanaijie@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, TJ Adams <tadamsjr@google.com>
References: <20240301013759.516817-1-ipylypiv@google.com>
 <20240301013759.516817-3-ipylypiv@google.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240301013759.516817-3-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0032.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV8PR10MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b62907-6e87-40bf-5a25-08dc39e6cb90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/nSbXdP5C5nzR70SwwhnkiJAGJ2k2V33vHrZnrEhWdGdpqnDPkwBk4GO2aYVYZ5LTf58+ValJOY6uJoKCeDrRbx0HhiVKcriPWX+1jubCrcd0Y0hzeV0AKww8xkBHvD0gScfLEFH5YymhF6qkjkSHKAWtPgvsKz4u3aCUiqzjloihswgDMzVZTSEqbz+jJ2rdGZxjg8vT9S3gJ6ZO/Y07ZzN/MPyUysgVXdlhrGQUcMReah363CdPDR6C+25m5lKcaVotUmAN7YGxuBSjlTfTAj8gxQD4MCeTvL6xVK7UXmseYjQCtO6R0jCuHwX2tUWjNUhz7oeWCNowGjvWpzP8iAx/p3BT0OruNCGjdp2NkRBySorxlfbjunAtqqtD8/L0BD9nN9LAvez+tD6rr8MsZrrgHxczsZ81kpjm+AHL5loi4Cx5qElyrU3t2Im8qLRo13BwqX25KY0ZOJPZ9dVFmYizEHtsGTnln/cFkmknvcK9JdZEI8EsU1HUEKFKotOJP/o8k4ugocuOEtBvC3oAG/ZEfMLMP4ypKtSuWzgdxnhMUJlY4IRo4dSamcmeLcKxOjq0/iC6HMdgtQA1ATCOaR7WrARIhTfZRh0HuKI5GcMIAtwoXD3CiLkvpdnSSQBvBTtkZdzBzB5g5ZpMYexLw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dkFkSzhpdTg5QmVrQ0c0Q3l4d2tGNWNsTW1Cb3Jib0hEN2dIYnFaOHBGaXhp?=
 =?utf-8?B?L3ZhbVAxU295QkxBMWFyNGExZVdCenkwZGVtMG1NVE9jcWIwVkV2Qlh3bFo0?=
 =?utf-8?B?R3lTQVBLVXNOeXprRnN4NFVxaDdzb2hMOUVqNDhyeWNYT1hLaURrcFIrcmpy?=
 =?utf-8?B?ckJlMy9nRHBDUlo5eTdvS1dYTko4enRaTGhCSzFjUi80bER4aXNoWndOenFs?=
 =?utf-8?B?azI0cFN5ZDh5Y2dhWHpqNUk0UTVjRmZlSFkvaWxudjJyS29mMnVFTkFPSG5H?=
 =?utf-8?B?REw5amFnVFJnRDVrNjFnaWVoZzRaYkcwR043NjFkbkdVOU0rSjU3dFl5RUlj?=
 =?utf-8?B?Ymc4TGJtUno0azlkdUwyTVA2bEtWdUlFcnVNNlgyV2NBUis2UVJpWGcxQjRo?=
 =?utf-8?B?M25BVVg2MGU2c1ZtMDY4ODU1T01TaDV4QkNoNkxCUWJnS2pyZGFOdnM3NkJL?=
 =?utf-8?B?ZjBiR3J4VkhyckVDTXVRU0M1MStVYU1BeTBBOU42SjJFUjFlcUdGeis5ajZi?=
 =?utf-8?B?QjdWWkxhNkRqWGw1TGVOU0xiY2pwMGpobFBQcHdBR2ZWRmwyUkhYemg4TFNN?=
 =?utf-8?B?NkFMRWxOT2Jmd2lXdVVTVHo4VnhhK1dUWTFyVm9Rb01qMWpvQmlxdnA2TlR2?=
 =?utf-8?B?czF4VmNuRC9tYkMyWmlBd2RZQWZDNDZSR1hURGlYVTRXc1JNRkt6OUVEL0hn?=
 =?utf-8?B?MEZzbWVGeGpob213VFZOL0M0WDZBZ1ZxcXR6cUtmMnYxaE54Wk56OEhFL0tt?=
 =?utf-8?B?TXM5aXk0U1NoSzdSU0NtaXZXSjM1WHRIemRXb2QxWkxlc0JIZGdSNUZLRHRE?=
 =?utf-8?B?VlJBWXpaSWllR1c4TWRZeVRZNTRkOXdlTE95RlhQVW1WRnJKeFRZYm4yb0FZ?=
 =?utf-8?B?SlZyTlNtY0xBOFJISWtJLy8zWGdjejZuenZsRTFzY3F0MkZYbERPTVB6Q2ZO?=
 =?utf-8?B?OFRBQWJOREZ5ejhvYWI2U09rSWZyZXg4VU1pNHExOUROdXRzT0V3RlN5MUxT?=
 =?utf-8?B?TlJheDl1UjZQeEpUL05YRmJZdVhmTUtuRUxZWnJoVHZyM3pLRUdDQVQzT3Nh?=
 =?utf-8?B?MGoyYlBDbUY2UHF0d21oZE5ZMy9jQkFWZHRYYkhjNW91dzZ1WTFCT1BHTmtR?=
 =?utf-8?B?Z3A2WE9XUlJlQWdHeEhXVFZxcEMvZ3RUV1RLdkhyc2R5blhMWlNnSVVISG0y?=
 =?utf-8?B?d2VCWWRkUmdyVWRxendobzFSa3dzcTVsZ3J3a281d0FPNGNkY3ZqSVBVU2k0?=
 =?utf-8?B?RkVpQ3BnSmhmVTZFUUpjbHd4YlpEMW5tM1N4c2ljcVE1aXl5MU1UOE9oOTBD?=
 =?utf-8?B?c0xUN0dFZENMcm4zTENWd3NPSHVwa3k1UUtuNzZMWkNaNjA1bGxZdlFnQ3ZJ?=
 =?utf-8?B?L1VHMmtJZVZKSkNYV2J6Y252T2RESjNFT0FsZyszS0UzZWVVVjh0L256Zi83?=
 =?utf-8?B?RDFXUmhIMDNsM0YrZEc3SFhuZU9lcXRHZFRGR1RkOEswMmk3c0xvL3Y0ckY5?=
 =?utf-8?B?SkFvTmFUVXhVSmxQNlZINU5rTnlEaGZwdnJZaUhuRVZSYitEeWllSXVUTXlv?=
 =?utf-8?B?Snl4RVFoM1VqWFU4Yzl1cVdkK3kyRUhiYzdldXJrME42c3VMdzN6S056OU9V?=
 =?utf-8?B?MHh3dUZaazFMQWFEUmUvLzdXdUJ6Rmt6MDNGSis5U20xZGlkd0tmRUxUQXF4?=
 =?utf-8?B?UlBJYTg0cmRERWpteENVQ2xYUXliU1NhcVdla3JJeDJHOU9OZllralV5a1RX?=
 =?utf-8?B?cC9VaWtqTTF4QlFvbGVkb0ZqREFYVWFYL3RzSDMrZVhoQjhad0VnYWRFWEdM?=
 =?utf-8?B?T0JNbjlZVDVJVm5oSmJTTk9UMGJwVnowQnBob1ZRR3lIWGlud0xPWFp2dDFx?=
 =?utf-8?B?WWkrSjVNT0JJWThkc3AydXlQUUZUSHRGNWNGWFBVOUFTcWVxTlBjOTArbzZw?=
 =?utf-8?B?L3FBSW4yMHFCa0pPUmpTZmdXeHlHTVJ3US9ER1ZYTTAzUWRoSVliVFZTTnFG?=
 =?utf-8?B?b1k3VzRYQ2REVVowckxzOEF5WGxkTEV6ME1jTEZVdnFtUFBLR1RmYmgyNGlH?=
 =?utf-8?B?eHhBSkIzMCtnUmE5M0tKcWQvdkVqcGVxS1JCLzhEeXNxUjg2MDhNV2hvbUt4?=
 =?utf-8?Q?8TPtdLOHjIpGUgrnBAcqP7abS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8quwwgrbxVAMf1jz/NTq7nBOwAUtNOtzeB9CjANyt1zx56ymFfPWb4aQZkZBfFnxzyNM8aM2lwhIjW/hLLdiMZ/WGHtkllEgUXUG7MUnxL2ZadyqILZ1UpBVHBu4TNyZETcVDZ8d9tZDR+7xxWM/V+wXz6XK0D7Hg2cY4dJPDYLS3iGdvDraTOoOoN6gP2biXyxMBqfY7/ygM/DmN8/nPmohOUMWANv8jJMIUyXwAbWFNsIV+IYYpO/4PLaBvWf7Y2pMmZ0+XPjGubEPHJIz29OwZuemDCFIEOmCYxVK3cPTTNMyr7h4d3sffbt1GFg4h7vlmpVqkz93JhJRUJdhXs41hlWd3MjLm8W2UqHnXD8UJ3SPmJEADFyu5qwI4KbkaBbQwlNFF2WWmqE/NyNbq+h8pYllBeZjjn+15dcazuok44Z5oQrYT58tGxV/hHo25VurzazlAe/0dFnXbi9+UGfU6ETGN4s+1p+ElLjI4Rp0IQ/1waTfWoUjwYh03C6tbT229v3EOBXIDv1/Fy1Ubj3YEfu6ZAz3jqrVLuhEKtgFvz77QOE9VSf1dtd5hnQowrYnbrOHzSA2Ra7j8n+HaWwVajKhfo1++IFb0hxKPBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b62907-6e87-40bf-5a25-08dc39e6cb90
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 11:57:40.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDJ2P0Crz1YKAhPGvqm04D9CE7gptLLaxtZDKLJZwfciyOJOTDGuJoBwGdWNc7HI624of50oVdkqeT0t8X4RIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_10,2024-03-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010101
X-Proofpoint-ORIG-GUID: LKPn1RelEIBRh-oBtRUv-ssjVXVOnRtd
X-Proofpoint-GUID: LKPn1RelEIBRh-oBtRUv-ssjVXVOnRtd

On 01/03/2024 01:37, Igor Pylypiv wrote:
> Libata sysfs attributes cannot be used for libsas managed SATA devices
> because the ata_port location is different for libsas.
> 
> Defined sysfs attributes (visible for SATA devices only):
> - /sys/block/*/device/sas_ncq_prio_enable
> - /sys/block/*/device/sas_ncq_prio_supported

it would be good to show the full path

> 
> The newly defined attributes will pass the correct ata_port to libata
> helper functions.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> Reviewed-by: TJ Adams <tadamsjr@google.com>
> ---
>   drivers/scsi/libsas/sas_ata.c | 87 +++++++++++++++++++++++++++++++++++
>   include/scsi/sas_ata.h        |  6 +++
>   2 files changed, 93 insertions(+)
> 
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> index 12e2653846e3..e0b19eee09b5 100644
> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -964,3 +964,90 @@ int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
>   			       force_phy_id, &tmf_task);
>   }
>   EXPORT_SYMBOL_GPL(sas_execute_ata_cmd);
> +
> +static ssize_t sas_ncq_prio_supported_show(struct device *device,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct scsi_device *sdev = to_scsi_device(device);
> +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> +	int res;
> +
> +	// This attribute shall be visible for SATA devices only

Please don't use c99 comment style

> +	if (WARN_ON(!dev_is_sata(ddev)))
> +		return -EINVAL;
> +
> +	res = ata_ncq_prio_supported(ddev->sata_dev.ap, sdev);
> +	if (res < 0)
> +		return res;
> +
> +	return sysfs_emit(buf, "%u\n", res);
> +}
> +static DEVICE_ATTR_RO(sas_ncq_prio_supported);
> +
> +static ssize_t sas_ncq_prio_enable_show(struct device *device,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct scsi_device *sdev = to_scsi_device(device);
> +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> +	int res;
> +
> +	// This attribute shall be visible for SATA devices only
> +	if (WARN_ON(!dev_is_sata(ddev)))
> +		return -EINVAL;
> +
> +	res = ata_ncq_prio_enabled(ddev->sata_dev.ap, sdev);
> +	if (res < 0)
> +		return res;
> +
> +	return sysfs_emit(buf, "%u\n", res);
> +}
> +
> +static ssize_t sas_ncq_prio_enable_store(struct device *device,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t len)
> +{
> +	struct scsi_device *sdev = to_scsi_device(device);
> +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> +	long input;
> +	int res;
> +
> +	// This attribute shall be visible for SATA devices only
> +	if (WARN_ON(!dev_is_sata(ddev)))
> +		return -EINVAL;
> +
> +	res = kstrtol(buf, 10, &input);

I think that kstrtobool_from_user() could be used. But 
kstrtobool_from_user() handles more than 0/1, so that would be a 
different behaviour, so maybe better not to use.

I would also suggest factor out some of ata_ncq_prio_enable_store() with 
this, but a public API which accepts char * would be a bit odd.


> +	if (res)
> +		return res;
> +	if ((input < 0) || (input > 1))
> +		return -EINVAL;
> +
> +	return ata_ncq_prio_enable(ddev->sata_dev.ap, sdev, input) ? : len;

Please don't use ternary operator like this. This seems more 
straightforfward:

res = ata_ncq_prio_enable();
if (res)
	return res;
return len;

> +}
> +static DEVICE_ATTR_RW(sas_ncq_prio_enable);
> +
> +static struct attribute *sas_ata_sdev_attrs[] = {
> +	&dev_attr_sas_ncq_prio_supported.attr,
> +	&dev_attr_sas_ncq_prio_enable.attr,
> +	NULL
> +};
> +
> +static umode_t sas_ata_attr_is_visible(struct kobject *kobj,
> +				       struct attribute *attr, int i)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct scsi_device *sdev = to_scsi_device(dev);
> +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> +
> +	if (!dev_is_sata(ddev))
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
> +const struct attribute_group sas_ata_sdev_attr_group = {
> +	.attrs = sas_ata_sdev_attrs,
> +	.is_visible = sas_ata_attr_is_visible,
> +};
> +EXPORT_SYMBOL_GPL(sas_ata_sdev_attr_group);
> diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
> index 2f8c719840a6..cded782fdf33 100644
> --- a/include/scsi/sas_ata.h
> +++ b/include/scsi/sas_ata.h
> @@ -39,6 +39,8 @@ int smp_ata_check_ready_type(struct ata_link *link);
>   int sas_discover_sata(struct domain_device *dev);
>   int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
>   		    struct domain_device *child, int phy_id);
> +
> +extern const struct attribute_group sas_ata_sdev_attr_group;
>   #else
>   
>   static inline void sas_ata_disabled_notice(void)
> @@ -123,6 +125,10 @@ static inline int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *p
>   	sas_ata_disabled_notice();
>   	return -ENODEV;
>   }
> +
> +static const struct attribute_group sas_ata_sdev_attr_group = {
> +	.attrs = NULL,
> +};
>   #endif
>   
>   #endif /* _SAS_ATA_H_ */


