Return-Path: <linux-kernel+bounces-86654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0811786C871
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2941F22F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4157C6F6;
	Thu, 29 Feb 2024 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fsjs4ZgH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="irf84uyA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029F37AE42;
	Thu, 29 Feb 2024 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207330; cv=fail; b=cM/jdFaOFbUzAoDm9vsYJn3y6VSPhNX4rkKS9EYkGvGsq3KvUtn+wBpy3WDqFEpJ8d1mT8pLG5Ru5pq85srVv4Nx1VoujeU1Y0+K2KKNRd9wQcC3Pc7+wcCZcDFr2x7v3r/izXEJ+4LRq+yKOijXjQwsMyn9+1x/CrjfMdowyko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207330; c=relaxed/simple;
	bh=nXW5rZGNWfE6+tXBxc8IvibABV12irvhWIk6dyEuDhg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EcLeQSSYVI1BVjyE3Ta61yoPnf/RATqvLbPRBKqkrfGkDXVMpUyGwr01SNIR+w1umdZcSUYyejVp4vgG49qU7s/LkNIxha5iCDM+S+bXWC7FxkedYu8l9r9nS9GPf/C0i/f5ftpOC/cNZPET8A2Qzy/ocVvKlipNcQwxIr4yaQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fsjs4ZgH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=irf84uyA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41T9Vixo012302;
	Thu, 29 Feb 2024 11:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=CqHbGjX79sSIFzzmoVBinLE9J7Ra4kjNkYoyW2QpsSc=;
 b=fsjs4ZgHM6hLrZ1A9klGcbV67UaW0LiHTNOGeVLf5ENanA+MtKnLHhOs1GRFQC6zgRfs
 tPCOH3IY/MmESlBnguhUE/EtSukx84peMR+Up+IMcuYbxl512SbhQV7qPg3tMdN+s9dE
 5xoivSG7uMQ4vjQJ6Ma5uJgfet9xGYCxsRs9q0RAYkU92mEUWvmTI89WD41V9BG0gdk4
 y1QMszjKcQoT3d0WhUIlIDtEjS+zhj/Mr1hyGxMAY/gfyDKg4Yo8Xe1VwYq/6xo5ToYx
 SfMRFyPK8IQm9oakL1jxdVM4zyaijv3E7uoIxWv4aAHY1OjtmTK+wtipLnUHRX/TECFs Pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8bbd2s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 11:48:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41TA7jNk015267;
	Thu, 29 Feb 2024 11:48:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wajjk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 11:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIAKJV8abUlBAP6k9JPkOcEKh3fVw68H7AIS2jCcZmFHoL/iUhKfdc3mvnzUx5XL2/jfEW1yLrdaw6ZwbWD6qLYKCzaZt48oQc9qxZ+32o7bwiU8I8axg2PskOXENf8Ogi/dtGPtqfOiTV+JIZA6MF9ePGe1qFOcnLCxF3BySZqnHFLGPG5aN8MOudl+Nnluk31kh5qW3E/M1LhaY1UibK2TMCEtdgNROexFZXWOzByuY6vwTOXFIwCJZlTwUs2DNE6h4F6+9SLG/gS6J8o1noXHtl8dZYJFT0xuEgIBqSn6Gmwg8mmwkckD7CxFzG/u4jsr/z0ZEBJuKA2rb9d23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqHbGjX79sSIFzzmoVBinLE9J7Ra4kjNkYoyW2QpsSc=;
 b=ZxfX5LGC4Ex0JwH7Pza4AnO1fJIYXiCyHVcY26fd0gXeI/kNhnSLSLAqqrz08jQYiuOilY5kqimpflbXyPcJzEffJ9oIkxoBO1VovAq0j37mhgUggVLc+saO5oPxBxcinN5qlR6IvVL/dT8FYOV22pJJmnVnaKNvC5dOsyhiNAY6kwijoHa3ZBuYeTSrk/5zVMuEfFNW1hQiYf1Zu6jntjBJkCYwvjDJfR2+J6Uww8Ps8UqGunZymwesOW2a1NmQyxSjff0x9ODRg2hEp0oCZ1yq6OtgUo1Zgg0hB7ETouYF2VBwnkoWc3UBJkGBvOxextU5VX3j6hFy86ForDsw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqHbGjX79sSIFzzmoVBinLE9J7Ra4kjNkYoyW2QpsSc=;
 b=irf84uyAHFdNNbWDO0A4wkmK5RzIXSE+aUysLP30ePhNGeiCqpmiev/SqqAPpt3DtZ8VCIDPD6flb+Y8xCjL6c1mqQX5dVr5k8xrRdQOAzXBK4+pQDFPfBoF4ox22asxqetJVHLXOJC7VzqanuIgakqf+TYIMYPbbM7+ld9Im0g=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CY8PR10MB7242.namprd10.prod.outlook.com (2603:10b6:930:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 11:48:06 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a4ab:7076:36d:a488]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a4ab:7076:36d:a488%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 11:48:05 +0000
Message-ID: <bb259840-35b6-4483-8e76-8046cae1269b@oracle.com>
Date: Thu, 29 Feb 2024 12:47:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/5] misc: mlx5ctl: Add info ioctl
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-api@vger.kernel.org,
        Linux Documentation <linux-doc@vger.kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>, David Ahern <dsahern@kernel.org>,
        Aron Silverton <aron.silverton@oracle.com>,
        Christoph Hellwig <hch@infradead.org>, andrew.gospodarek@broadcom.com,
        linux-kernel@vger.kernel.org
References: <20240207072435.14182-1-saeed@kernel.org>
 <20240207072435.14182-4-saeed@kernel.org>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20240207072435.14182-4-saeed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0035.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::18) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CY8PR10MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 073c05cb-01d1-4879-9d7f-08dc391c4ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	J7SZ6DFHqfScHrALP9QU65k3mW84pu4yYlhv3dC+xYiEtuBzTFmiaseUMR26YyG7wPuHtrCIIZqaSo4q2HF0WLihx5cpU6Nv0liELR2IaoHkeqG2IcgMzqCsxYsSqnKc2X2koZe3m35UFaWTriuzbZCLmGinpmBOw5IHkvA7VghmLIcNa2k4YS+XU5y274kih8ztekLEcxgojx7vSOyODs0fPeHIVUtCDT05V3WVfqUXPAK3iggSK+S7qYrSFosT8ZttIQ/4DSPt6wuzuN6cnodirFdISco8GkJjlLW1ALus0i2Qr+N6JTzkwxfFO7YST+KrppTB2pdCvq5tQKT2ZoYH8DMBnl6YTrKIgNVr9u7mqgUaDt1lOWJieE0uk3qoA3l8GBX9Omyec3qtrBlzI1uKoPqEc21v6h3P7BHXBGUeAnsx5FI1jiwD4mPUq1H2egF5680FFhrH5kBeKDtCSI6FPto+g1BGgajIVLqbayYN23nl9yfaouq8ak4gtBlQQPBhLEm0JqzfrTSqKv2QjNddN4siIIhrFNWe1+fU/dRsQNnn6OD0DCET+SrxBE/aVQmtLoqYnCfINkgPuIaDvJIbsDpmURUI7x51K2IHe0GwmFATyY6xgm+E/lE0PDTjqbzfiZKbTK57CLsO4jrXxQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dng1QlEybXZjQm8rME9YK3NjNVJEN005Wk9TbkhoKzYyWktLK2JpdGZRSzJP?=
 =?utf-8?B?M3lwU2kwaEdXaThiUTdBMklnZ0k4ZUwrVEo4a2ZBdUduKy9qc3czdGhNV21S?=
 =?utf-8?B?TjdrRXdibFoxUldqYmZEUFYvaWJybUR1N1pKazV0am5QZEh0MjdKMnlHUVlh?=
 =?utf-8?B?TUVudEhIeGNTUWpmcVZDVUpHYmdvLy9nTnhJdnpyVERJWXlMRHN2N1dvMWlx?=
 =?utf-8?B?ZGZTSE1YZitYdUs0R1EvMVlWZlNvc2ZwblRValY4c3llV0o4Q084dVM5SEM2?=
 =?utf-8?B?TnNLV3FEWnNJdnNMM1dML3V0OTJOU24zZ2VUL1JiVTdUQSt1QWJYVEs5djFJ?=
 =?utf-8?B?YzN0TmJjdG5XNSt0U0tlaFZtMTB0dnBlekRzWExjaWNRKzVWaWVPdTdyQVh1?=
 =?utf-8?B?cTVyYW1NNG5aeFNUZU9LNVJJYktML09Pd1M1ZGZINGUrdkVQbHVCM09nSWVy?=
 =?utf-8?B?STRhTTFRYmVKMkVDSWk3bkdZa3lSWlRFMmlrUzJlVC9JY1ExOHBobEZTajZ0?=
 =?utf-8?B?UHBwOTNSSzFoYmszb00ycFhPemFLcG51WC80QlJ4dmVpdmdkY3dFNk0xOHZJ?=
 =?utf-8?B?WkhyOFV6Nm1pMkFMV0U3Mlhhbmh1UFpVc05RaDFWZkFFazdXeUt3MjVHTFZN?=
 =?utf-8?B?bnJFLzF6cTBqc3RBYnhLWGlmYUN5SFFBNTNPYjBKVG9NNE5yY3ZVZlVvaDRS?=
 =?utf-8?B?eTNwMW5QSjg3cnVvY09zdmtZQmhYQ2FrRHBUVllacXJiOURHRmFLbzEybVdE?=
 =?utf-8?B?T2RFdCtjanpTNG11a0xxTjlRZ0ZyU2NkYWtrUE1KOTVJU2hBS2VJZHVoMzBw?=
 =?utf-8?B?a2Q1dFNwSG1UZ0RjaFpyTk9SMXd1R3RoNW9XL3JhVVJ2OUJKaWZUcDJaeVFk?=
 =?utf-8?B?M0cvaG16WEdPTmU1ajRPNHh3OGRQNEhrVW9tWFg0RWFrVDk1a2ZWTDBtV0t5?=
 =?utf-8?B?Rys1UlJDRjErZjdlM0dBV1M2Skxvb1BlR1h6enhSYkVMQmtiZTNqRWZPUWV0?=
 =?utf-8?B?bndmRmx2bkZ6R2phS2s1VXAvTk84SzRUYUlZMUFCN2Q4QUxORVJ4WnllUzRU?=
 =?utf-8?B?UTJWZy9tQkM2cWNiOFJqbXNiNkJMKzV0NXR3blpNREpidU05UDU1VWkvM2dC?=
 =?utf-8?B?ZlpIdjZuV0RpdzJKM3hXL05ISlYrSjVlWlo1VnBpRjNFRW1KSVh1SnErRHRz?=
 =?utf-8?B?RDFjay83dDc0MGZWRVFTMlFuLzA5S2lPWW5qek9seDZYdzF4L3Mxamg4Q2Yy?=
 =?utf-8?B?Ym1Mb200bjErZjdlUkpPdzJpSmF2bmxaZG5lcVBxcmlDejFVV2ZrRmlrenlr?=
 =?utf-8?B?Q2IzRFJyaFhlTXM5NjNpTG1MM1g4bE4rbGVsU0s5V0lvZGIrZGd1NGF5QTM2?=
 =?utf-8?B?K2FpM2tKUFN0RjQzSnN6dkZacmFkb1JvTG0zUTB4b0VqdUhrbnVFc0NBcmRn?=
 =?utf-8?B?YnlQRmxKZGpLU1MxTm9taGtYYkRBZGZQY2htSE1QeGZyWTU0Sk5HMU5nK1h2?=
 =?utf-8?B?MUFjQzcwbXltSjZMYXROejh3Q3ltbzFEeFlqajBTQnpTRUdVQmlUejcvN2s2?=
 =?utf-8?B?OGsxcGF2cDBNT1hhWldGVklrYzlwWXNIR0RpT3ExM2M3ZE1TbVloNCtIQU1x?=
 =?utf-8?B?bEFQS2hZNGlQN1hRWDgxdGpuSkpCNjZRMjZId1ZvYmcwcFp4Z1dDSE5DR0Iv?=
 =?utf-8?B?K1d5RUxZU2hnMS9qTU4zMzJUTWtta3E2TVpvNzJXZjBqa3FlQkpuNEJMOE1p?=
 =?utf-8?B?WDdHdWcvNlIyc1lTZWNzZVEvY0xiTVNubVYzSTBTUXZoVXNOTVdlN3U1S1Rl?=
 =?utf-8?B?Q1EzR3pkeTlaakRFYS9xT1p1MlpKdk5POEg2Z2tXYnFyMWZ2bElDQlVEQXNY?=
 =?utf-8?B?TnBJNTJSVXNVZ3UrcDJYLy8zUFlYYXk4OCtocW5UTUduMjlkNHpOVk9YVEhp?=
 =?utf-8?B?Yk11Q1RZdkg0Y3pBZS8wSERrRmh5NGhXZGw0RHRkWm5HK0xXSnlwelNaK3lp?=
 =?utf-8?B?LzN2UWNBLzd1c3RYZWxDcFpPc0ZvaW9FMnBiV3E3TjNqekNuckNrM1pEQmlJ?=
 =?utf-8?B?dm01dTZGbjlNNGtDVE1XZGFPaHdVZk9XZzlDMXlsd0Nod25ROVZGVzRJNzhy?=
 =?utf-8?B?V1dEajFHdEhIdnJDcnM4dEJFNFFqNzlseElwMldnaEpvYkxkZjd1Zk03QTJX?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Op8cmM35muojsSsPET4XT0evIfeHY6oJTaqwXLQ6RyF9lH8g8BfCS0c9CgJUH8osSjeri4/iCgF0iSPyXLhDEQaywy93jL9CatlTSt81j356i8a1I3EtqY5M3wZQJZLYXaacgDouIFRL2tO7ogMsEPDjFA2JkSY0Sg0U1hyNFWvEIzzCDs1ei4iTDIN5sH0e4lsgALGtMkSoS7Wxa8yOKhv9PkoOSbVdZpNg6kJWsToAWNISek6J1tV80Ijz5X5Z065Y6a2YjbAOc0T97/JgO+fK2cN2x4yIXyoe/omwJXMBZfmyniyWIL1oW/tEVFG+MWB+NJPGm1PpjojqLPutsDzBEd7aRToECQXMqClaph9UqISPETYcpfVsmPXSVFrVlQZ3ULE8mMhyWIwHyOhkd70/6/0Etq6UkMYgOCDtS7VFAkVKA78j0YoG2V9McR67V/1IXOJay5rY381TI3OUcVWXGPNfiASldaDLtdz2fS6/42E69SDSc3I+L60mJl/nhzHK69siMy5Hb0Idi3wBJPjY+89aXJ29dz1zj+mC6yHNMPQVhBTxDRmN44qONkuH/SNBdnoGYl7q5A0Gi81cEXRHdAHJmmQEADM9/gqq7b8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073c05cb-01d1-4879-9d7f-08dc391c4ade
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 11:48:05.8738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrpx0C2zSTbPSNZ6+4Gct11z7WAQkH4Dx8kbFlMPcL1phrt3luS12ebkK0KxWKExfoNkVAHnP4jaVWjRawxi3p6OGdGaVwVkddPE/qpjYQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290091
X-Proofpoint-GUID: CxUBgMhwOtRTfMSwvQSteRjHD8Xmcj48
X-Proofpoint-ORIG-GUID: CxUBgMhwOtRTfMSwvQSteRjHD8Xmcj48


On 07/02/2024 08:24, Saeed Mahameed wrote:
> +static int mlx5ctl_info_ioctl(struct file *file,
> +			      struct mlx5ctl_info __user *arg,
> +			      size_t usize)
> +{
> +	struct mlx5ctl_fd *mfd = file->private_data;
> +	size_t ksize = sizeof(struct mlx5ctl_info);
> +	struct mlx5ctl_dev *mcdev = mfd->mcdev;
> +	struct mlx5_core_dev *mdev = mcdev->mdev;
> +	struct mlx5ctl_info *info;
> +	int err = 0;
> +
> +	if (usize < ksize)
> +		return -EINVAL;
> +
> +	info = kzalloc(ksize, GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;

struct mlx5ctl_info is small, why not put it on the stack or even copy
it directly from the original object, assuming it has no holes/padding?

> +
> +	info->dev_uctx_cap = MLX5_CAP_GEN(mdev, uctx_cap);
> +	info->uctx_cap = mfd->uctx_cap;
> +	info->uctx_uid = mfd->uctx_uid;
> +	info->ucap = mfd->ucap;
> +
> +	if (copy_to_user(arg, info, ksize))
> +		err = -EFAULT;
> +
> +	kfree(info);
> +	return err;
> +}

Is there even a remote possibility of extending this structure in the
future? If so the size check will not allow you to be backwards
compatible. Should there be a version field in there or would you
just add a new ioctl altogether? Adding linux-api@vger.kernel.org to Cc.

> diff --git a/include/uapi/misc/mlx5ctl.h b/include/uapi/misc/mlx5ctl.h
> new file mode 100644
> index 000000000000..9be944128025
> --- /dev/null
> +++ b/include/uapi/misc/mlx5ctl.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 WITH Linux-syscall-note */
> +/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
> +
> +#ifndef __MLX5CTL_IOCTL_H__
> +#define __MLX5CTL_IOCTL_H__
> +
> +struct mlx5ctl_info {
> +	__u16 uctx_uid; /* current process allocated UCTX UID */
> +	__u16 reserved1; /* explicit padding must be zero */
> +	__u32 uctx_cap; /* current process effective UCTX cap */
> +	__u32 dev_uctx_cap; /* device's UCTX capabilities */
> +	__u32 ucap; /* process user capability */
> +};
> +
> +#define MLX5CTL_IOCTL_MAGIC 0x5c
> +
> +#define MLX5CTL_IOCTL_INFO \
> +	_IOR(MLX5CTL_IOCTL_MAGIC, 0x0, struct mlx5ctl_info)
> +
> +#endif /* __MLX5CTL_IOCTL_H__ */

Should you add anything to Documentation/ABI/ ? (Or add other
documentation for this driver?)


Vegard

