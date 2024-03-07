Return-Path: <linux-kernel+bounces-95305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F268A874BFD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88FD282907
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7D686AC4;
	Thu,  7 Mar 2024 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Voe5pIvr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IF0YYCFZ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965F84FAB;
	Thu,  7 Mar 2024 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806140; cv=fail; b=YmgJc/JgEaC65MN+tDfzJERFlw4EyOIah1mJW0jwBx3i/WH82qRrNFeMI8cq6oWlNnX8HbO2I6Kuy67fLDcEds8C7Pir6nXwAnbL2CPJvJNEHsqCksVeZo7z0imsCFlf2NsEe9Bp9JfmctTTUZKZvM2vdNe3Nyz777Rrrb77OA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806140; c=relaxed/simple;
	bh=yEKPs0N1Li59xRpslS9l9wWRmDaU5YUAePOak1Asz2Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t/UQ5Z6DvFD6ZRKDbdNz4Tajrj2Z9YdoraXW3Xd1z+kbnlRIy5/uCQjxpFYif5Dcj548xkN1ugwOAcLqVgi0xQLmHW2y00zYkE9QeSanStSvJMM0V/YcCH4/eL90pysoi7CuQPKsFrOnSS/FzvPFJO82u0dY/nDJLvCC4xr2HzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Voe5pIvr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IF0YYCFZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279nc1r020807;
	Thu, 7 Mar 2024 10:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=r0UpOulgMurtrO2VbWl9cTbqs2W2QA1kogOg0ASbiRg=;
 b=Voe5pIvre+Fd2o48jkv4MTaKX6FJ+aw92yHQSKEJvO+zn7IRLegkAiua1bpTDFlwuMea
 GYkX/l9hKlBf1IDseN+NxOHVgmEB/qd3GuEWMV7rfWAY/f5aL+I1sZvXVHZENtci4Ybt
 fBit/eVa5RJCd9Sa0WGMmh6viPNu4WIaSs3kEsilSbvSZAflolqkTZjUm0s+9GRJ8q3S
 XM6YR3WMUDDAAXmM95M/E6IpkBFyl8tTN5oah1SHRGP/bi9gUbfKsmrfFT7KL+ljDyHP
 macTpTklZja4ZU7TLF9ALo/X0ibRhlfSR4Jn8ZomXedvKbG4GXRqoMjKnHWJ6HmyRpyh jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktq2bm3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 10:08:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4279VClD000549;
	Thu, 7 Mar 2024 10:08:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjgsh8t-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 10:08:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBDur/2gvthWSb7HfQTrYg7fBqIid9qc3iQyzTg8F/UlxbZRt+/rBtmoqOez1fjmBPPBsVbOtgu9y+ce7EJSbU2CmkjP1OzToRTp6cQhOKoBnQ6wdG/YVhOHxGs/OMMTzfK/Fzzo7DHHqHmsYyx2rd15BxkcODZVDkw0p+okOWkkAsp1po6NYpIYzxQhAjs0u7Rw57POIWZfBOdieHLnNy+8qWrarDXuDoXSxfnG5xO+kC4TdOzuruq+WrEGVYLXcTTr1Y5EpmFm6lbBkYucwzTdKqu9c+0BQJgMJehY7oizOuaGxPN3Y6c2J3751x3CwH4bfXpfEjw+NpWhd1uFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0UpOulgMurtrO2VbWl9cTbqs2W2QA1kogOg0ASbiRg=;
 b=ROm2BmnTIm8dtGbroqgu8KDvjKR+ZmgLSEfSwtCVa9bTJORMR/6kf0znfL5JQ7kMr+eOEXQwlTmnhYpLePzesm8SxWkQYc5Va7sB2EGJyUWYPYzJa5GHGGCnMBx2BkLuc7wlRpcBhXx6TvXjFoY6QNbknUbkTDVY2677zZmzsI8EAMywCInNjgiilVq7bjYG+ACJp3AtfXYv8o1A8XnFb7k3H9UtL2qBZtApeebOZM7bfJP3wVPxhm67erR/zkG0bUf71Bodr0kcN/EE92IY13pML7PxFp8C1pkZ2DzCcrnsZuWckNOW40ICQUcj7B2Y7LP8ZvOG32YJ8TFkMfgj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0UpOulgMurtrO2VbWl9cTbqs2W2QA1kogOg0ASbiRg=;
 b=IF0YYCFZYrvibqXloNX8/8FB4zkxgbP2KNVip95qH2GB4w7J/LlJhnm3ufEnzRYcnK8Pl+QzfvtsUElWGirKCClxwdjWM9TvkmXhmMGIrX1rM31WunBU8Sk43xNm3yC7wAex8M1dNbwX1zkDSUdu6O8UqRyjkGKmwzUoNDBuflQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6142.namprd10.prod.outlook.com (2603:10b6:930:36::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 10:08:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 10:08:19 +0000
Message-ID: <b105b26c-9c0b-4315-beeb-7879de85d240@oracle.com>
Date: Thu, 7 Mar 2024 10:08:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] scsi: libsas: Fix disk not being scanned in after
 being removed
Content-Language: en-US
To: Xingui Yang <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        chenxiang66@hisilicon.com, kangfenglong@huawei.com
References: <20240307093733.41222-1-yangxingui@huawei.com>
 <20240307093733.41222-4-yangxingui@huawei.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240307093733.41222-4-yangxingui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0013.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd00553-26b9-4e83-65ec-08dc3e8e833b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ngh5DqlBBUxuG1V0UnuB68AHhBcO5g6OFpUoqc9ygFOZqKGtN9pA0GxlH/++3viNkNGTwmWeq5zmHbQpjE4bVBIoVWQ/QIIksFeLCZXT+5tWBt5Sj+wm90Fc2ms4ZsJ9VPDMy1bYHTsv2S8Vz8R+KfczQYJa94bESi5OyqGSvHAmn7pMXVHdqS10pLCIHDaAte+Y32fcuT7W7AtmEbNA9S3eaLEcppOmVHI0ghpJq0pq61G5P2/gj3zUv13H/s3CKP55nCFdyx40td/RExdwb3QCHuage+sgaBH/NhXVIv+lA8H7diyz+LHkMWmhSlBdD0SikH2zscYH8zlDytPDuPBDjo+6LqrbZtm1AM/UamPrYImNtAmrw7Ih074k3TvV6rORQqQC0XzivtF9hYgsvZcPuFIZZag7Iga4ShQQ3SEP+GLkhTS1kSCaNhlob7WvgY0oMnW2NLUxs8s6La7ZdjM/HaPZJwhDegV35l6xNR/UOc6XGYzP4T/PeGKi+d0g2mchb+V+Jxti9gYlDc612IUtwTdYqxCPRpC1eJk08MuPJw40m8SK5vgOGDBjg6wwJufpbVQqBz3OWpB+tM8oAsjl+ViguWoFs57ia6RwRpWMMqf1Ck8B0pxzoYVN9XRCz5HvkCd1H/GeKjVYJMO61i4WziB6SHmohyQ7mgPW8nM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R2svbEcvbCs5bzlteWkrRjNlV0s1WlUrRTVhd0hwYlN6OUFkdTVpd3FhcTJI?=
 =?utf-8?B?aE1tdEsva0JDakFuQnFibDM3Ym5PNjU4Q3o0U3dmb2NZM0NmMWNMN2tmYUJ2?=
 =?utf-8?B?SFNjYlQzbDA5TkJnQ1oxLzhFVm85dy9EbVRmZGpaRytPUjVxSCtCaVMvTmZ3?=
 =?utf-8?B?NW41OFFwcFVUOThEQnZJN3VGQmFRdlZSRjl3M1F0dEpvRnVuQ3pLV3dpWWs5?=
 =?utf-8?B?bEZ3dEhtVURya01wYVRIRm1ROFQwMXJCc1NyWFBDY2VlS0FVaFhvKzlKVi92?=
 =?utf-8?B?WmY1eFI4eWoyMXNpUWY3a2N4WFlNdU5VekJVM3N2a1lhdUo2VEt5QkZYUVFj?=
 =?utf-8?B?aE4xcVpROUxiaitmbE53VnJrRnQzSkgvQnJKRFBacWtNdDJncnZVRlFjaHZj?=
 =?utf-8?B?d3JVc2VlU3pvMXMxM2VNa0NBemhNdWpoYU04dnRKamp0ZzRMNldPaFk4ZnlG?=
 =?utf-8?B?SVNQYTBQemFpNUdKNHZhYjZVTmZxbkV6UlZEYTBPTTMzTTV2ck90WFd3SzRO?=
 =?utf-8?B?L3ozSHJyQ2RsdmI1YTNRU2lNM2lPRmI1ZWZlTllMcUZabTFuUnRqU0lTS2RY?=
 =?utf-8?B?c0ErRkNtWHJKL2xJM0ZnNDFINTg4d0Q2SEJ6NjdIaXdEMHlYRXhWVy9CNTRy?=
 =?utf-8?B?SzJyem1HYS9zbkJnczZyZTZVeG1ZYmg1RFl5TnNneGdZUFJzNzN0b1Y3UVdH?=
 =?utf-8?B?bEtNazFQbzVnNlZkM2pIbGhVdlFrTmdaOXRaM0hUMDlXVU9FeHJ4bDJzWFlL?=
 =?utf-8?B?U1NMNjE0bDJSSEpuYUNOSVZkZ25QMUFGOWZoNTRkcjF5V1pxZG5La08zeHIv?=
 =?utf-8?B?UDFLWjluay8vYUNUWHV6QTVKVENuTm8xRzVJWW8ySTVZSEJ3RlVNMEE2akpN?=
 =?utf-8?B?bE1GN0l4dEQ4Q3ptWkkrK05iUUtCK1FUL2FpWGFZMXg0WTYxWmNKMmNDL3Av?=
 =?utf-8?B?RiswbmwxR1YrT3IvVnQxZXZreEdkTEYxd0Y1WHZudHpkYjUvZzJCemhrWWZL?=
 =?utf-8?B?Z2Rva1k1NmNMUDBEKzZER0N0bVZ0MDJoMDk3M00xRGJHMytqaFJjNm1xK0M4?=
 =?utf-8?B?cW1DbnJMS2RzM1RwL0NnTzNFS05raWNwellJWFBSSmRFNUUrbWd5STlaNzJD?=
 =?utf-8?B?TktETHZCNUFLOEtDRXd3UytuUkpYVnB6N2dMaVZMVVB2MHZ4Wlp1RW9pNWVK?=
 =?utf-8?B?bU11dHpzUjUycTZlVUdycDlPZ2hxR2xSZlNnR0MvbkpNMFE3U2xRWHZJNzdr?=
 =?utf-8?B?NnVoMlZsU2xoVGVUWnBSQzdwcGU1YVovcWNOdnRWVUhtM2QvaEhQMGhSbmNu?=
 =?utf-8?B?ZFppcmhUTlVhMzBPbGVSOXg3cmdjVUJKM1VlTFB0am5GM3hEcHB2S3hWRUZp?=
 =?utf-8?B?MDlHbjFnWlFpQ25TRHBhblJOaEFkOW1uTnVzQUtBZjJHOGFzN0ZnbkNyZzBr?=
 =?utf-8?B?aXFKMHE3NTlxYWdDRDlLOEx6d0JlZ2FRV29LNHZMZXNhM2tiSmNMNWhiSkFy?=
 =?utf-8?B?VWFrNUlSMWZVTlAvc1JTdEJOT014dlZmaG9wWVRTQ3NRaFNpQWoxVDZBczMv?=
 =?utf-8?B?bGdqR3hTWEVYSko5SWpqemZaeEZzUUlhZWV6QkhDQ25NTjhLVGNJcXVsSHRS?=
 =?utf-8?B?aU8xQVFJY00xeGFlZ3FuczI0TUl4TlFLWStPVVBIK3dmcC9UYjJVcHZzMnNO?=
 =?utf-8?B?am01d3BvUWh5cjhlMkk3RTIrZ0FRWVlyaVU5WDgzbmxSbjBrSmJjaVVoemYx?=
 =?utf-8?B?OVVJS2FCVnd1bVkxWUg3bmd2dS9kRVVLTFd5UEhnbXhIL2w5cjBQYTJGMEZI?=
 =?utf-8?B?ZDZJUzIrQTNwTWIwWXJ1cmMyb0UrMFRUaHNONkE5WjhrR0FEaGJ0RWNsczd0?=
 =?utf-8?B?R0xXUFZITlZZWld1THR5MWxLa1ZJWXVKL2IwN25uZmNLYUs2bHd2NlZHMEha?=
 =?utf-8?B?NUkwWjk2MlJMdVlEQkdTMGptQ1NhZ09qQmtrU2RPU2NxaGQrb0gyZjVlVnpE?=
 =?utf-8?B?dXAvZzBFWVVKQ3BIK09RelJ5QWgrdnhoUGs2TFpCY081MmNUa3JQVFhwUi9W?=
 =?utf-8?B?Tm95UjJDSFRFSklqbmNTT3ZlTUtjcHN5UGRLTSs5cWw1WnoyYTFFTldkNmJo?=
 =?utf-8?B?ZUFhNDZLUjRxMnJPclZFcG1LamlZUmtHNmRDUTZ5OFE5bUx1QzllS0JINVZa?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	n19/3omtYWIm9vve9VzmQ/KNWHp2qM9nmdv8s8CBG2acJuQOeiEgF3S2IUUQ/70qoHv57wxqq0GxVPL28Lkn4EkFpNKsbDabYSIVmAtTMGoU50DE6OLEj9grOFzXpeAEpeC2NkjqoLK5L3HeaU2xu/5KZACoz9q93RnMF7QMHmOARIxZHrOFkZkkQukPgwiFoJJZjgdC+8d3WUIN4/M+JmeDzhwWy94LTh4t8wen00z6plD1tUONG8MSe0SQQv/AxjNLvR3v2LyEWxkxT0tBhQn/z1qhVehU1hYT13bLcVPTC4xA7iKGiMF4RzTUaEsy3HGS/wIlDamjlAmW/vNiIHApOBDtZXuEykpOyI2gmZm6/N9rv339KCR8ucpvLLhVzSI0ORAn2P+qH6qnQ8SczO6mQd5SVgXkXxXgBgIiIx5+apCqFp+tnC5tJuRZf6s6InoZQoPmhDRssppq0BxN0+Z1CjsmN7v7JZ85UAm/HcEs4w8u08Jgzm+dI4QHvz7nl/0jWS+K/aMADs+ifhA85g9i16wPfwT41+H8FRurI3EPH5sOyIebRKTTFxepybW0Xw+zoxDv9PDV38WUkoGvcM2cydsFkMQgHhR/dIt8ZFY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd00553-26b9-4e83-65ec-08dc3e8e833b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 10:08:18.9490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEdg/4GDbL8HecMKwVhJenL8695rPaiW/nEo/opAPaO0Jqa9GBrP2p2aWVamPbwhTb012UIAeYFr/ak9wfhqmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070074
X-Proofpoint-GUID: ufdMUiOq-VFSHh6cjouzpkrj4-fcYrCx
X-Proofpoint-ORIG-GUID: ufdMUiOq-VFSHh6cjouzpkrj4-fcYrCx

On 07/03/2024 09:37, Xingui Yang wrote:
> As of commit d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to
> update PHY info"), do discovery will send a new SMP_DISCOVER and update
> phy->phy_change_count. We found that if the disk is reconnected and phy
> change_count changes at this time, the disk scanning process will not be
> triggered.
> 
> Therefore, call sas_set_ex_phy() to update the PHY info with the results of
> the last query. And because the previous phy info will be used when calling
> sas_unregister_devs_sas_addr(), sas_unregister_devs_sas_addr() should be
> called before sas_set_ex_phy().
> 
> Fixes: d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to update PHY info")
> Signed-off-by: Xingui Yang<yangxingui@huawei.com>

I am also ok with a change to revert to allocating the resp memory with 
alloc_smp_resp(), but make the changes neat please:
Reviewed-by: John Garry <john.g.garry@oracle.com>

