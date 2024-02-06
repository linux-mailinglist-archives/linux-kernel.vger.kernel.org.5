Return-Path: <linux-kernel+bounces-54729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3924584B2F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CDAA1C2368B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F198C5C90C;
	Tue,  6 Feb 2024 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g6xNsi5r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vmoa4/CA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455FF58101
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217309; cv=fail; b=MF1a1XKnPYSggR8ptaN5XtmdnO3+Kk339Fp5lYOCxvr9wHjjJ9LiLqRf2iGc+33gbyJeD3cGcSPqdSzHQIKVJLS+F1K8zQDI1G2OBEG1Ht/jfMYdJEyMiyKtSHbseeeWVazEskLjH4G/AqC4xW3Sq5BBEVgRpb/WXegoGYc3CVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217309; c=relaxed/simple;
	bh=DKx8cn+VO44OhIHI5IQEHeHYUlA+vfsJuKvlBwF7FIA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ieDpPtfu8kys/YcVowncWF2ADKI5pdG9mtTSlzgP5YmkRZw18GpXEVtBtBsF92ROLZpapjntBmb+8P5YfEWGF9FTyFMfT73OVbHjMTRLJHfVEYLP7PqJ1Io7MRGgRzO9AnmRu+mif741TASKyv6vNddeT/X+mKPzCez393cmVjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g6xNsi5r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vmoa4/CA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416APXCW025516;
	Tue, 6 Feb 2024 11:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BrkEPKK+MMbm5et55SCg/1uRMgzeWTqTIypiv2ORhlU=;
 b=g6xNsi5rwZaxV5/Q3bSx1Q/wxgDSgN7XgActCn5iVnIhRTCjvtnIBymxYapFxxiu9pnn
 +/2WryK7fr+7wUI3PoeaY0lCTLTipUSrBOCthC1F9C6lSUgqwwqsaJvL2vZkg3DLR/Ar
 3cyO4imuKTla/oSxJ5HakDKgRIcc6OFVqw4/e1LSy68J0bLqW96JJBO7Udof+oMsjkcC
 V/c/wItgizfVsM4Ip00lmOjcqqCpLUBxj8PiCTWAzoTrszZUaEJzuaa/wx1rF4PSmclK
 +XNrjcQhPh2lv1w+V5oh+7ggv/Fm3yjHtdzhqArU2YXpK3Z1xDKfXTaA6recILjKLIYH GQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1e1v6epg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 11:01:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 416ARQ3a007205;
	Tue, 6 Feb 2024 11:01:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx7bjk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 11:01:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXAdc5WZire63ZNnPS36O+xA0JoAkvDUZeF9ojjGfHHGxbK2SAsVHrUm40yjRYaMCj+ZnL6U7MFtWtPH2oBFCmOrrHuysgX4p7j5XOr1+DVnl8BFi6OlZ5HIDf3KRtdgEmnUH93IU0XrjCUiX1qGwj+3tpyenpRdxlzVArHY/rA3gG3ga0sh9/WvREaMsvbGLT38bNSVkJbs3XXoNJCcNA2y4+W4Z2gY7SAZnGmLJxDwja6MdsqIkU8iIgZEEcVVbyrgS90yK2AIZ5+DYV0FUo7O2YZ7Km0uoYIAzSUgAPVuHlRipES1rSubNcIcM7v3jiBv61iURVHDr7Dm8rhjJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrkEPKK+MMbm5et55SCg/1uRMgzeWTqTIypiv2ORhlU=;
 b=LnPNsdDu9qNAmeY//f7/IbJcvum6GDcLslgajKpIBEy+2HoDr23uds+R/icBfVyZY2e09LhZ4yx5PfOU9KDS1OdTAvOCwBF9iPux3JAplti4S0ovBQMgZgRgLtR1f+f2IEkgDWDa5mCdMwtjLL+TdsCeUQf5EYPO2TS63Whic71nCffmq9CUpBHx0jaeMjHagASy6Ly2Bd6wf4QlNZRZUBbXYJZyBqGbEy3hNAXF7nb5oTzTiP+t/mf+f6OtWPuqOaGXfwCtmT1YU4mooIpWuXQECDxfJQXCakTeLg9xrMPUmINU8KkqhBwWcxy9eJbXwZ7RfG8wnWWjZDOsgPqzrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrkEPKK+MMbm5et55SCg/1uRMgzeWTqTIypiv2ORhlU=;
 b=vmoa4/CA2+Th9ZFlt+ouhxfMJ6tKYvnZar/RkatWsYZycgJFph9JiBYfq8amd1TWqUp7XKhbKhXNA5OEsWSf3TX0362O+8wlG5KNgEjK7mny2UdCN48TC4oQ54kGOpCRB5Wkb7jTFL5kn3iPxpc+VLMuYzzfElgbcS1p8zhpejw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4438.namprd10.prod.outlook.com (2603:10b6:510:36::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 11:01:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 11:01:21 +0000
Message-ID: <6041982e-3c65-497f-b7bf-3ac444fa3623@oracle.com>
Date: Tue, 6 Feb 2024 11:01:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] iommu/iova: Tidy up iova_cache_get() failure
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc: will@kernel.org, pasha.tatashin@soleen.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com,
        yosryahmed@google.com
References: <cover.1707144953.git.robin.murphy@arm.com>
 <ae4a3bda2d6a9b738221553c838d30473bd624e7.1707144953.git.robin.murphy@arm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ae4a3bda2d6a9b738221553c838d30473bd624e7.1707144953.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0052.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: 13fa7e13-7ef7-4a23-a074-08dc2702f3a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LUGrPBkFEHx9Jz0MEmdjg4Nh6l2RPAIahTpiXRMIu/7c92IFloOZg3wt8tAsy3AsnoaJHZpBM3zwLFKDFUHp7itdmUV4ZxP1bINKTFz3qMtOySy0nwX4wK4SBozzjp1VlBdxsaE4WhMJuy3cGUYcm6N45jHFMTZ+MRnZcbm+fD76NVNEoIBJgTh1M3kOMBMXQKIM6SQmGiTiEnb7OZcygwyldoQO4PJJwKx2bPsonDPZmoyuOcD7Ci/K37nGvBnACsYHcpp6WkMG4DZ9Uy8jKFP85Pb5GslOyXAsf0EGrDztzUjn/aU3eXeEF3zO8XV4n2tTH9b8phPtj/PAyO/gsSOrZmrL5qOVxN0Uy+1vtu0UEJx1rvH/AaCbnjqIR+Bhf0+FWNjylj3Lf5MBz2GfwU7qnzk3mlIhvqaSDRZ4c4aR04J/Mga+bmYxXjKBHJlOFKE/8Of11apguZE8lh7TvcfTeSkoNoF+35ljirFZnUu/zvFHNGROvkPjVR3j/sS8+NECZPyI/yXeyE0NWBIjr1tQrDr8JySJlnICHJLX/V82CbgMI4XHTB5GrvjQmq9MS5kttkLngbiyBzRZaeYGB4aycQekvBcr2YXSaqCsuiKtK3eiovJdLv+XNQpkHSAG1FvCvdXWngo2sAzFSuK85w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(2906002)(83380400001)(31686004)(41300700001)(26005)(66556008)(66476007)(66946007)(316002)(31696002)(86362001)(4326008)(8676002)(8936002)(53546011)(36756003)(6512007)(2616005)(6506007)(36916002)(6666004)(5660300002)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d25pcTFpTUtIYmJ6QWllOW5mYnBDUis4eU1GRmJtS0t5UmE2b2VCWldHVEpk?=
 =?utf-8?B?bVU5MjhwamlyQzA4TzVzMHBIM1RHRHBFMjZwR3RPME1zQ1lCVzNFNDJGZ0Fr?=
 =?utf-8?B?ejFWTjdTRDg5bVYvQzMyT0V3UXM5NjZCclBhTjhVaUEzREFEdUY2UThvZjcr?=
 =?utf-8?B?VFZvVDVXTlhKaVY4K2U5SnZpVHVwWk1tdzVJUE81ZmQ4dVk2RlgrMDJDaERG?=
 =?utf-8?B?OFVmV2pmNWFvaVdyTlVvWjRPRWxRMWtjQURiNHF6ZXllUEQwSFRWYmRJY1J5?=
 =?utf-8?B?UVFpdlFHMnYzK1RJOXV6RFpIblRkUW1oNUlVTlhmckNzSFNJVEFMY1BUM3ZN?=
 =?utf-8?B?TDlQNllaOGdyVUFaZmVHRDZmeU9uTXlkUHBuMUtQTnEvTno1d2UxOEk1SnRK?=
 =?utf-8?B?cEhDbTlnR2MzRmNsZEJZMFBxd25MQUszR0RjamsvSFE0czFHMi8rOHBUM3R5?=
 =?utf-8?B?VlR2Vlo5bmZRaHJsSzZFYXk1cUpER1Q3MW80K01LYjNSSGg1bWRZdTQzRVpk?=
 =?utf-8?B?VTFPdVZzMjRUVWRnd05CRGNHRnhTancvUjh5ZlhBTTAwK1ZpVWQyNmh2eG56?=
 =?utf-8?B?aHNDSVczQWxmWE00M3dtamJzNGZ4WnJqUWFXSlJDMzZ6L09CUjQ3WHN1WlNQ?=
 =?utf-8?B?bjFCa3JYUzh0SDlTVGZBZXdXTDZCZ3g1NTNCdVF6RWtNQ0ZmZi9HYy9NYXhY?=
 =?utf-8?B?WDlETFUrMFo4NmQrY2paK05JWTgzeTdveG05aXVxTTFwaHh5Y1cyd1RsZC9l?=
 =?utf-8?B?d3p6ZjVNOE1ldkRwckNHcysrTkVBS1BMd0pTcXJ5SldzQ0R3WTNSZEU2VkVH?=
 =?utf-8?B?S0tkdm03TXRnc1VlazhLS3dYY3V4by9tYzNCUTJOYzZYS1p2dytWZGU3TWtU?=
 =?utf-8?B?YkJzc296SEZuUjRhWllNbVlCYVJPbUxNYXVLVTRIL2JXQ2lRZHVwYVlEYXQv?=
 =?utf-8?B?V0gyWlhMV2pubStHNnpYWWJ0enlTNTBPc1hRR1pYeU93UkRJcnk2d0t0RUll?=
 =?utf-8?B?Zy9HOHd2Zy9jODBwNVNoblgvYjc3bXRrWkpsQkpJcjR3amJZdnVhK2grL1g5?=
 =?utf-8?B?NTV1aEhkSkpoYWR0dzhXWVkrLys3M3M1ZjhsUTZLWUcvSHg2cGgwcCtKV0xL?=
 =?utf-8?B?M1dRZnB2NlNCU2RWcy9PamNWK1FZd29GODU3K05lNjdCN2JsczhGNlRLMS9Q?=
 =?utf-8?B?LzdjM3RiNDg5ZUovNkhEdmczbXVZbTZaRGtLNWNMeUlXM3NuYVFvSkhrcHU4?=
 =?utf-8?B?YWMvdFZMMFNUSGFyR1VOanRNTkpNWEpMYW1LaWl3MVRUY0hwR1lHV1BWSjRH?=
 =?utf-8?B?SVpzOU5SZS9QT3VVQXM3SDZtb0o2Yk9KKzdYQWJ6a3A2R1ZOb3pCYjFMVnZy?=
 =?utf-8?B?b1U2NmFEMVBaWGlZOSszR3JXbWZNWVpQNkF3MGR4cUVYSmVDZTVnbEMveHdI?=
 =?utf-8?B?ZEVyZENoRkp4TUliNFNxaGp5Z1NDMTNEYWlvcW5EWjZaTUhvVzNFL1pIK3Ra?=
 =?utf-8?B?NWVGK3FjUzZKbHJydWNadGZiY0VXZ1BzekdWVVhnemd3bFpodk0xb083N0gv?=
 =?utf-8?B?a3YyekcvYVE5Ui9HL1gvSjNFTnFxWnhzSVNDZVlZOXNOQzgxVkZCbzFOMUpK?=
 =?utf-8?B?Z3k1MEc3L2tHdGk4NlBxRDBPQlBsQXAxL2g5LzFhcmsvTzRma29MK2FWYlQr?=
 =?utf-8?B?SzJKQmwxOFlGOFB0ajJaSEIybjJiTGFLZ1RGNEZZSXkrMktSNjNLWlpnZjR0?=
 =?utf-8?B?MVZmMmFzY0JTZXVBazdVbmYxWTVMWG9WQ0VMcmppNXFaUnVCQmhXK3VOTUZF?=
 =?utf-8?B?dTlUQTl5am9wZDlxZ3dRSmxCZWJrRDlMWFRzODNNTmhXZEcvRGlzdnlFcEQx?=
 =?utf-8?B?ekJKM09oRXlhcDV1U1Q2UHlRTWt4b0dINHZ2Ujk0aFZwS3RpVXBwR1QwaFAv?=
 =?utf-8?B?SmxtZys2dlhJSkdSN0VENEtoRjJEYzlnaVRtQWZCSGNNRkJyTUZBZTRlVm94?=
 =?utf-8?B?VFVVR2N3VXVWREh0SnNZbkhoL3BKdkZhRmRsWXF3L0Zia001NEpFa05hYjlM?=
 =?utf-8?B?a3BjWkc1T0ZDT2RTajEzOXQ2VHFxTWZNWkFDVm84OS9nNzl6N0VLZzFmdVRv?=
 =?utf-8?Q?zJzCJt5s/+sO6TsXDwgJlCdsi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2jn252iugAg3GdE3nglUPkjZeVGPcNO+EfIvevF8/D9qAhmgbctF7Saw1LW06Bv/3H9EqGT1Svi77ngn3YOaPVNbnh9zaDG0tmOz1j3saXXtZeG+T8yvYZjMEHOHVU0JNfFKv5mxIyYb9z8FwzMwFbegMjXrdgNmX45lMytKPMPbl/+0jMfacmeC/wTISb0GY0xSFqpaE4lkcWQIr76W9lMrEDVBQxTmpTC0wIKB6cR+TXxY4IDgCE9sddNA3/4EhRCL57kzJVDn5R9WwR6J1Blc5Ht3JTfQdcjZB7ynTYptvIRffAUjLXeDb922SnzybqNplPcQtRyS9UhD9u47IIn/CdU9OOU0tNsRHp2hP8c0kRfokbyvaoxcrZFiOnY5EVTv1iFBY6mM/uolfvm+hCp2X6qKp6adVm5POyamr6StUhJXHEoxXPWshAuu56m31fXo73gi7ifjIxp4KHq30ZLHDLe/fYiaYQPaTCu8SRTZh/Jh5JE8Nxki+wskR4Xar5lhxIRrg3Pp07h4ezAoyQqL4r4QzXzs0FooLKlgOB67OM+xHz7mlr2GGBKQnZ4YkzXanaA+SbkAZ9QdRwQlcKUy9otKha49tjuONSc4iok=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fa7e13-7ef7-4a23-a074-08dc2702f3a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 11:01:21.2745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svKVD7RDpItcAM/ZyJ4MQu0KJEcW6HHCrVo5VZTM9I2jibxikjqMHdAnTvpPCp0sLqPTRmXTRc51lfjdhE6KAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4438
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060077
X-Proofpoint-GUID: Z7qCqXV2S7l3Mf0Yiw8U3sIHdUNtEwNg
X-Proofpoint-ORIG-GUID: Z7qCqXV2S7l3Mf0Yiw8U3sIHdUNtEwNg

On 05/02/2024 15:32, Robin Murphy wrote:
> Failure handling in iova_cache_get() is a little messy, and we'd like
> to add some more to it, so let's tidy up a bit first. By leaving the
> hotplug handler until last we can take advantage of kmem_cache_destroy()
> being NULL-safe to have a single cleanup label. We can also improve the
> error reporting, noting that kmem_cache_create() already screams if it
> fails, so that one is redundant.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Regardless of a couple of minor comments, below, FWIW:
Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   drivers/iommu/iova.c | 33 ++++++++++++++++-----------------
>   1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index d30e453d0fb4..cf95001d85c0 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -254,26 +254,20 @@ static void free_iova_mem(struct iova *iova)
>   
>   int iova_cache_get(void)
>   {
> +	int err = -ENOMEM;
> +
>   	mutex_lock(&iova_cache_mutex);
>   	if (!iova_cache_users) {
> -		int ret;
> +		iova_cache = kmem_cache_create("iommu_iova", sizeof(struct iova), 0,
> +					       SLAB_HWCACHE_ALIGN, NULL);

Maybe can use KMEM_CACHE(), but it would mean that the name would change.

> +		if (!iova_cache)
> +			goto out_err;
>   
> -		ret = cpuhp_setup_state_multi(CPUHP_IOMMU_IOVA_DEAD, "iommu/iova:dead", NULL,
> -					iova_cpuhp_dead);
> -		if (ret) {
> -			mutex_unlock(&iova_cache_mutex);
> -			pr_err("Couldn't register cpuhp handler\n");
> -			return ret;
> -		}
> -
> -		iova_cache = kmem_cache_create(
> -			"iommu_iova", sizeof(struct iova), 0,
> -			SLAB_HWCACHE_ALIGN, NULL);
> -		if (!iova_cache) {
> -			cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
> -			mutex_unlock(&iova_cache_mutex);
> -			pr_err("Couldn't create iova cache\n");
> -			return -ENOMEM;
> +		err = cpuhp_setup_state_multi(CPUHP_IOMMU_IOVA_DEAD, "iommu/iova:dead",
> +					      NULL, iova_cpuhp_dead);
> +		if (err) {
> +			pr_err("IOVA: Couldn't register cpuhp handler: %pe\n", ERR_PTR(err));

Maybe can use pr_fmt with "iova".

> +			goto out_err;
>   		}
>   	}
>   
> @@ -281,6 +275,11 @@ int iova_cache_get(void)
>   	mutex_unlock(&iova_cache_mutex);
>   
>   	return 0;
> +
> +out_err:
> +	kmem_cache_destroy(iova_cache);
> +	mutex_unlock(&iova_cache_mutex);
> +	return err;
>   }
>   EXPORT_SYMBOL_GPL(iova_cache_get);
>   


