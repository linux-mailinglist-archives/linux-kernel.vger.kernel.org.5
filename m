Return-Path: <linux-kernel+bounces-122696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDDC88FB93
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814A929E85D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD4956B77;
	Thu, 28 Mar 2024 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EHkqQqXZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cvli/9HT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBED2594;
	Thu, 28 Mar 2024 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618379; cv=fail; b=s7ZC6w26swNtL/s15maw1ssLbccInm1vsmnScK5B0unMG4dA0/6ZyQ9hz5/IeiM0tkZfMBaXL+eZ0qIyqLPChsaGwurqJVbAeQVrKzcOaAGhZ3GumVKIDYVUiITgBtaxDJYYV3CBgiKyKWXa+/mwA/ZtrjA5CUyAUi84qI1/TpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618379; c=relaxed/simple;
	bh=YXqOUiV0UG2Xh9cK+rO6yYwfy8X/nPIvwIkLERi3rh4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qaTNeYXfwTRgeBmXLb6Xfr/ems6fagM5Y7hqEGFjNTdRU7t+9MRX7/m6eQEYzrieWoSxvG27brnmSNC0RgC7lK9W4W7Zf2oh4/3Rb3Wi8tvxo9YG/gmBc87TcI20XjO8KMNxAKrxEEAi/YHbbpK+zTFby83Nqs29mcBp4JE/a9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EHkqQqXZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cvli/9HT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S8x2K5025134;
	Thu, 28 Mar 2024 09:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=e9arifviVQnIvEa0vfWXv/uZVahryFWO/rMyuh+syp0=;
 b=EHkqQqXZ44nX4BV+JRfT+t6LlbHutxiw3mmgbIlbVUUPd0u7RV2BH/Ra3A3ZwhBIx3Y/
 mjpo1Ni+JAANY0rJu28ru+vRUbydijpnEBwzMToJdmKjQ4Mv1BcvHorshbp+I6gSGw+f
 /0kXJpyRrRHaKJBsj+66nj1c+zpZjpx5VHdLCs4cneaX0ZhUARWNUALd3HIdxEwD1yGD
 oKpRoA/Hl2K0mDwMjYE/sALSVFmtS1rL+2yqGJxI4tBSTJ0jWKHaz2IIToQ7C7xWGhGF
 zqD7QWNDrHSJpJ0XcpdSppMZt0mFEGQ5C9zUxfaVg5lXyrwyxyQ3Rn09+zwh1hvQdhMX kQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x4cxy2qur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:32:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42S9GrZ6014429;
	Thu, 28 Mar 2024 09:32:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh9run1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:32:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etz4exy5sRqFrE4IuD0rPnMitEehDS1SpLXTZr4oRotNeRSbyj9rRseokrKwaRUdUY5gDKz2zRPCBW3Dv1WvUO8HeNtyDXHMSPgIiBHeUeUAjjwmIRLgPXq8o7XiOq9VQQZ9PhNuzlYm3qygUd7gjeVXZmYGGaZxy87hf2oW/Mtyu/EGKi5rEr6vAZ2G5remLID4HBjtfl9Qg2eGIVA5xM5ExSOGIVzOPtaOMEzP13TVikvc7X7zO3tCTax43roecoVcE0zcZDqat71ghcPUhjuVKkqIBB6ptAAdxQXdY1ao6xrBLwv6jhIZSiNTt9d30sHriWyXQeZwDJVpkjraKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9arifviVQnIvEa0vfWXv/uZVahryFWO/rMyuh+syp0=;
 b=hgrnkc6pqi7s6ynNca2FcjJssDW2s7yr4QdVXeFZIATI9j0TxMSkkaJbx6o6l9oQ8UT6B49RYkNnMf6mpq6tzsKXQUpOydiWQZrPBvqKlR0LvrnEv7fIhRk+9IXwK2SQDnZ0e3IFs+S/yTRvyw72DLVRnt50DiCSfY1reIOy70TD6pAR/T4vWr/TMdltHxAOcIMBreStBqib5nSv3w/eA61mb0IDmwr8wnJALBtd3WcJLs90gTmFqDVTmZGCvSfKKFCP9eum1T21CHrQV6gjn9HhrwbSDP9azx13a8CpgY33HjIi59pSogqmxI9WyYhQyoBGvRIjGQXygUjoJ4+zBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9arifviVQnIvEa0vfWXv/uZVahryFWO/rMyuh+syp0=;
 b=cvli/9HT8TCQwP6xwYtF+yoIGzCegnuBu8uqlA+J9Q6ojP5Fnsi7hiAp/qpqdjMg8Ks7abxHtMybRK5Nc+OzjVHEvvv1UEiIu4dgHtNFDnTHRMN9mLk0EdSRI6V9/1aTcrPJi2/TII0Ae7I917XqP+UZPshgGuFE0rO9vGHuE3k=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB7205.namprd10.prod.outlook.com (2603:10b6:208:406::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 09:32:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 09:32:28 +0000
Message-ID: <225d75ff-c7a6-45ee-a149-51eb720c5420@oracle.com>
Date: Thu, 28 Mar 2024 09:32:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scsi: libsas: Allocation SMP request is aligned to
 ARCH_DMA_MINALIGN
To: Yihang Li <liyihang9@huawei.com>, yanaijie@huawei.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, dlemoal@kernel.org,
        chenxiang66@hisilicon.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@huawei.com, yangxingui@huawei.com
References: <20240328090626.621147-1-liyihang9@huawei.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240328090626.621147-1-liyihang9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0036.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: a656d402-a38a-44b9-3560-08dc4f09fbce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mEnHov7Zk3EEfY9OsWl9tPjsoBz/ij9+nprJArZhcEMZRHlGTkKhSmM8cjOl94o91M71a8BOOPvtxd9+RBewmsyNFML/Y+egba/EwHRYn1m8UQtosPHvquWhnqLizlrnk/1rKb8rqxKxZMgzGzBnfluheLpZ43JAvwTlspWDhmVtyEJJwFUvVY1rVVMM1a/7DH6c+pkDpCKKyAq6V7OLuReGDwnVIrZ/zvdSKTkpyXf1NOZqSmA/fAsN3nJJBPTWYJfmPbG61Wpj3je2buziV6ZSAeQckUTYbW852n4TU5gL9itZT/E8nxpx9Hg2rt3veSiFJtcRIjPnEwFA+rGbnGLl+yR1QlCzSEbKkxGoSJg5FM8CnoZlOy5C1uZ+v6laoMA8tizFIfARDpKTN57PjvaiJQFGWSXYPOxKJJaShacYQhs0wy24kv5MLjCI65f5T6KTwvH3F4WaRZkKP5A+FV/RoPAWuou+IeZOCsa26cI4CgW8MKS/Xf97HncaFfGntXjhWabD7ErvZ1crr6NNK75r+/nGiv8GfsM1sT5hexoM0Tt+P5KdSqVJCG345ZiVgfWGXt5e8DnCzAoRBIF4RQMbVL5Ao9xTazDG1PqQxL4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L25rYTgzRCt4L2ZhQnJKNG5TbUpZaldvY3dxWExXVHphWVUxTEhHQlRiN2d6?=
 =?utf-8?B?TXJ0d2hUZDBJYlVYc3hvL0p0bTN3VHNyWUpGWEU3Yi9tMEhHQTNTeGNqc3FX?=
 =?utf-8?B?SVR5MG5Kc0ZLRWMyUGVGVDY4ajJMU1BidmQ1d3dNVGQwV2NpMDVjVlVQbCtI?=
 =?utf-8?B?SFJTK3I0c1plcEhuRnVRSE41ejY4NTFnMVpsR1N6QVhLdW5OVzdEUUtmQXV4?=
 =?utf-8?B?aC9oczlDVnRsZ1k5azR0WXM4N3kreUJOYktEbUd4WkNlMVVXckFOWHN6SGl1?=
 =?utf-8?B?VjNuVVBJaHpYWGxVekszYXRaTmhsakRHNXNIeVFZUDdFTy9TV1Bjb2s5aHJa?=
 =?utf-8?B?VTIzUmpCZ1ZtMzZoeWU1NWI4WUE0SktPWDhnZ3VEbWFXSFppWUEydSs1bWZu?=
 =?utf-8?B?S2hFTUFRSmdNbTFrY2tlT0NvWXNVbjZXVjBLWSs2Nm5oRm5tQ1dKeFAyQnR4?=
 =?utf-8?B?aEp1ZE9YbkE4NHg5ZThNbm9BWWZaeERHM2NORWdreGdqcXNnVE42U3piZ0Jt?=
 =?utf-8?B?ZnJqU2UzaHRiMjJnWnRUaEhlbWhCcWhvazZaNmpUQTYvMzFvM1A1Z3lBcU9a?=
 =?utf-8?B?amg5L3ZuRFZRWHdTSGVGanlSRXVlTlh2SDhxbHB1M2s2U0k2ejNxWWduTit2?=
 =?utf-8?B?WXFHcHRhRk9reC91d0MrR1U5V2drN01UdURvenZMOG1lUUJ6MHhmN0FEOG1H?=
 =?utf-8?B?Zk4rU0ZoV2tYN21qTWpybUNUcW1QTjN5VGp3cmFvYjdJL1NhdERqL0pjWGJS?=
 =?utf-8?B?UTdDRmU3SFh0dDB6QVczQU9RT21rSU9NNjd6MXNKWFNQVjBZUFlHWEVkOE5H?=
 =?utf-8?B?ZkgrZkIyc1VaTldDZVNXOFlqTVVOTU9OYzA0NG5MV1hWM3RuYloxY3RTYjlN?=
 =?utf-8?B?OU9NSVYwUDV5U1BMWEZJcW1pY1p3SGFNZmpJTldxekhxYldieDVEY3JkVnJZ?=
 =?utf-8?B?czArTGJUQ2lwWnFkTkpWazRlOE9uY3U1QTZ1cXp6RWVPdEQ5UWNmUDRrRHpS?=
 =?utf-8?B?WnpRQjB3cXdtck9PVUtjeHYydVgwL1JBWlhIM1N6YzZCbHk3T1orMmJsY3B1?=
 =?utf-8?B?aDhUNlY4czRuVktDU20weHIzK0tmeVo0RG5iaC9vaGRncmczcjJRWFJJOExS?=
 =?utf-8?B?NWtKRjhHLzZEYkd4ZkQ0U0NZWnMwd0J5WTdwUG1Fcjlra085bS85cnFTRmxj?=
 =?utf-8?B?TmlkcXJjckUxZnVURlZwQ1FqVUc5UlVVUDdoTExNakxuMlQ2RlhIZkd0NWRT?=
 =?utf-8?B?WjlmN0d2YWgrckVYT0Q0NEFyL1czSHdsQlJic3ErRkhhQlR0TDJwUUdtWkJv?=
 =?utf-8?B?bmk0dWFuNk1oU0FXMWJ2SmpEa2hRblM0aUdaMkQzSW5LNGRqNEZVRFlrNkRW?=
 =?utf-8?B?ZHY0d21jRFVHVG9TeWZFaUhmT2ppWFIrdjJrVXRvTEhWREVKM1l6QzVsaUNq?=
 =?utf-8?B?ODNwMFJSVUI0bW9abi91V0t2LzBOV0VlUSttMmI0MWlHNmRaZlBWS2JFU1Zi?=
 =?utf-8?B?SFlFeGxlS0RlRDIwYVZwNmdRcEx1S0swSUlsQ3MzdVI2TDZzWXZNZWNyazVx?=
 =?utf-8?B?YjJOS3JMWUJyYlhYTkxWdHJVR0pGeUZIZFdTVWxLUm9qbVJOOGFQdWZJOERJ?=
 =?utf-8?B?WEdETlVuT2swdTJqWmhQRmUvalJZUWtwYnoxK2NMQjlOQ2NJSzFINnYrOXhC?=
 =?utf-8?B?TU4rdnd5c2JMS0ozeHN1aDBraW1sUEFCQXI5TENOYVQxc01pY1lESFdDWWRN?=
 =?utf-8?B?aTRiRjdpbDQydWZlTmM0N0NpL1ZNS2Z2MUFzcnd2RTJKVnQyQ3ZubytMYVFw?=
 =?utf-8?B?RWhlT0pRSFViUjR3WEJiWkRhVVpRZWFFWFk5Y0JFR0I3M2kvYXhrY0FsNW4y?=
 =?utf-8?B?bUk1MUNnRGtlblRJR0Y2aTRvcXhpZTVsQlc0dlJ5S1lWeTB3RkJOdjFmSUFx?=
 =?utf-8?B?OXErL1A1REthR29VcE9VSXVPa2pFdFdGa0VZbzZSUTExN0FWSCtlSzlIdENM?=
 =?utf-8?B?S2t4ZE1pbWtReVV5Mkg2SzR0OUFRQlMyY1RaUlllcnZwL1l1SnZ4YVdpUXZu?=
 =?utf-8?B?SVNTNFlFbXVSODJ2ZE1RYnRETjdwQk9iTzh5cFNoZ3loSFBITEI0TjV4TFRh?=
 =?utf-8?B?RUFtNzZ5K0dSWEZicStXUHVNeDRmWlQ3bE5EY2huOStsVCt4WnhQSnpTcGRz?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6ZEtEtLSwEgs23uO6euGP4fE0nGjL4QIubPfifPJi8ZKUUa+K/kojSNh/osprQyemf/jmEa4Xbqsspi7QFI1DXSmm3pzhlfu3CFWX/fMP+ctodIWaT3qyiOBb7t6VVvV6RdQCNIzbWvITazGYGl/jlRM4f6wznk9+AYDKctqwMzPTr+t6oK6z2aCPZPlrzs8MfLWento3+ff/kvYgD4WZqmCZb46Ny5fjeNEHxl6U3e0APdmckPSB/Q1rjLSzoqQKyz2/cYNJw1A2NGN6DAlTdITfwXOEHFlWj3ntUo8sonapDTFEaURd9vrqlVTU6rDzGjvmE2r30RQq40NX+1mIGKtz51G3TXaUT+bBBrRQvM/qCfsZ8ir2XEjo/nQF3tB0MSbQgFzQmtO06eBjDDhA1UZJG/Q/7Tr/1VZCSzhv9c94EUyGvVgwmlMjUpuO4skedUtCKFGSvz+H527Bj21hmbdzplHh7G+Yz64clVE3LwcGpxAXtzcnF21lEkVhIOGhotZQiKnkBNxQrBt14cxedeeTqNi7V5OQ+p9DvcOlFGYXRUvk4FFsUk2m8oUIt221jRnKEXfTxRH/aFJQknbylieYM3JOTb0xV8F8zIF7nQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a656d402-a38a-44b9-3560-08dc4f09fbce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:32:27.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSN6MAIY5Ft60LOpU0xMzNNfwe4TwIuuP9w3Gnd7CEOu532ueLv1Z5qjr7JjsRRrpIzq3Zb9r0xh5qRIn1VkIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_09,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280063
X-Proofpoint-ORIG-GUID: B8-XyKb_Men1aLxeBSseHLXThMAKW48v
X-Proofpoint-GUID: B8-XyKb_Men1aLxeBSseHLXThMAKW48v

On 28/03/2024 09:06, Yihang Li wrote:
> This series [1] reducing the kmalloc() minimum alignment on arm64 to 8
> (from 128). In libsas, this will cause SMP requests to be 8-byte-aligned
> through kmalloc() allocation. However, for the hisi_sas hardware, all
> commands address must be 16-byte-aligned. Otherwise, the commands fail to
> be executed.
> 
> ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> operations, so use ARCH_DMA_MINALIGN as the alignment for SMP request.

I'd say that we must align to at least ARCH_DMA_MINALIGN for memory 
which we want to map for DMA. ARCH_DMA_MINALIGN would never be less than 
the 16B requirement for hisi_sas, so just align to ARCH_DMA_MINALIGN.

> 
> Link: https://urldefense.com/v3/__https://lkml.kernel.org/r/20230612153201.554742-1-catalin.marinas@arm.com__;!!ACWV5N9M2RV99hQ!LbkCJSfklWds8mk0UGjtg0qRNpWuAc-ibudDMl7sI_Qip4Hd6WNqHZmRbuJfObd4fcZXj0sC8nGTs1UbA5PlCA$  [1]
> Signed-off-by: Yihang Li <liyihang9@huawei.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
> Changes since v3:
> - Still aligned to ARCH_DMA_MINALIGN for safe DMA operations.
> 
> Changes since v2:
> - Use 16B as alignment for SMP requests instead of ARCH_DMA_MINALIGN.
> 
> Changes since v1:
> - Directly modify alloc_smp_req() instead of using handler callback.
> ---
>   drivers/scsi/libsas/sas_expander.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index a2204674b680..c989d182fc75 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -135,7 +135,7 @@ static int smp_execute_task(struct domain_device *dev, void *req, int req_size,
>   
>   static inline void *alloc_smp_req(int size)
>   {
> -	u8 *p = kzalloc(size, GFP_KERNEL);
> +	u8 *p = kzalloc(ALIGN(size, ARCH_DMA_MINALIGN), GFP_KERNEL);
>   	if (p)
>   		p[0] = SMP_REQUEST;
>   	return p;


