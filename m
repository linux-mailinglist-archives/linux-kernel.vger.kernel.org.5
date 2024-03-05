Return-Path: <linux-kernel+bounces-92065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 692A6871A62
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4571C21583
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BE05490E;
	Tue,  5 Mar 2024 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gc1DAKTX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BYiv2y6Q"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C94C535DC;
	Tue,  5 Mar 2024 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633735; cv=fail; b=WpAysAEhfzOnkk8I+IB0TQXVwoTOSKEkvujpIuYFUYrqcKL8LzH+gTodjMlEUitQ0X+MEwSl7HRz29H4ALK70Hv4syxDjjuzXIWcxqLhtiA1rMvWgQLkYrfJg8pCTZQcCCG6s1LXo02IhO8DKy3L+tBhyFibrlP/QkM1xJaVsdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633735; c=relaxed/simple;
	bh=uRMFtvq+qlBIvaPnuJ5Zm1RI8gPOLZjd1oSFnaQ16Fs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XBvev3DPiEqQF5o+PvUg0X47f7aODWom9n18j6+8MLE2Z8p3LvwKtdG3vOQmyr4DlyajGRHRtKZPZuKdvV+34M7lOJHBfiGNmAyGKjuU+bJn9CZ8t7G0mKSYrbJs4lK/QK6v9KK1Ail0zRrdlo255KseOb0WpWsCm+XNzjUC5dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gc1DAKTX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BYiv2y6Q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4259jXen019715;
	Tue, 5 Mar 2024 10:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=vqZsT5f3idyfjB0GxjaYiXYzQiY+4lA585y+qvYtOBQ=;
 b=Gc1DAKTXJ4vHyiwLmNgYLbHyQeYBPILcVA/jS0IboJTI4gwkrlt59XFiP48INewZUFkt
 vcY6GdWVOJlW1VX2K2EZ/0JhAGzYx8MCMCw4fMo3p7131r64gJAgjuXhMeqhBYwX5Bwe
 3FxD/6X3uMURhFMmg0uQ6IBPn0I0ct9V+CLTpKCfuk2FNvL46bPBg+NEc9uY8WP45vel
 ku9Ut8MR5WYS4bnSfkFsbm2TDYDWX5cXiBN6bp2/fLep/xM3hDKQn5uh+/h97NdWFalK
 z/LfFxjXlyn8c60kWcI428R2SUwyRy+26q5COdoSsFdTZRBpmwOW2luoEZS4zq9KSnTI hQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktq25umq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 10:15:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4259mCx2016982;
	Tue, 5 Mar 2024 10:15:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj7ak1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 10:15:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9Ged1srFya3o71uaKFciScx5H1Z/74hXnlTO3CVgtdB7SewJL+h2LO7zF9rOP+t9otlStN+eOy6+tYXMD2MBIOqJFiwbvCE7myXg1eOD26rALTgsJmXY/G2auPbQiTpocaguwUnkGED/3HeoF4ZCKqx8Raw7L5RseasatCGz29Sk9gU/2QQcp6Uh8UGuu6MtqVGiMEWYs1K4vPoBTmhdaC/0w+LP146KHQ0gqV5mcRHyMY+yXTcGRre8L/D6DaGZBzHR6QCoGBzoP6i5t7Abo9WVTwUV5X0a70T8DZz12cHIS2b2s8fwov1TuXb290tBKW0YzxHT+J6mjt75A/3fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqZsT5f3idyfjB0GxjaYiXYzQiY+4lA585y+qvYtOBQ=;
 b=XL2fYzLY+ffXKkkhzM+OSrfcNkysaznoVXzdJMIQsBLTga16a1uOIHWgmg5Geqwp2ELMdx3KGGSH14WQRxGltPA4s9t7/f38lvMyccSuzdxURhdARAAEGM+o9we7csO2yQcF/2xA196+F4c/jz8R62kw5hALF/JpM1Bef3wLAr4nd8HdrtLMkNcaz+FB4Db1nhR85wH5eVHNlIEVvWYUY40wrlEf7UqhYx6ATUoUy1MNXjg/ul5+sLEXxP7sIYaml0tOhYUPUEZ1QeOA/18k/etGY8atclisLXeA5FxoGqK6pnNAH+Q2Hlq3KK1QPHeW4ZD1khgALW4L/BHcdHmcJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqZsT5f3idyfjB0GxjaYiXYzQiY+4lA585y+qvYtOBQ=;
 b=BYiv2y6Q6/rD06zRw2x8NjgMKjBhaR2fMx6QfIz8GQuO6aEzRmBfBZAQ+K0EdPRXbnh3wScBA6IpE7+60i0cEwV0EWSdWJRIiAbjTH0czSIkKVLcI5SFEDO914C10z63iXJr1NdPDJCaawqBZq6dGqM+KSpm374bNiPMlv38YBU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4364.namprd10.prod.outlook.com (2603:10b6:5:223::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 10:15:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 10:15:16 +0000
Message-ID: <a7eb46e3-997c-4746-b820-a09229e75581@oracle.com>
Date: Tue, 5 Mar 2024 10:15:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: libsas: Fix disk not being scanned in after being
 removed
To: Jason Yan <yanaijie@huawei.com>, yangxingui <yangxingui@huawei.com>,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        chenxiang66@hisilicon.com, kangfenglong@huawei.com
References: <20240221073159.29408-1-yangxingui@huawei.com>
 <f095aa1c-f233-40f9-ad0f-fcd8fe69a80d@oracle.com>
 <e2a725ee-98b3-fd57-6ee4-af031ffbd6bc@huawei.com>
 <80050a50-af6a-5862-8c12-ccaf91c5ff74@huawei.com>
 <7e1b554b-a675-14d2-59aa-7f37e3dd5994@huawei.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <7e1b554b-a675-14d2-59aa-7f37e3dd5994@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0105.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f873a0a-48c3-456c-02f9-08dc3cfd2707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JdqsZJvWb+bnSwccSgwVrenhE4gF4wF+9UpSfUq3TIxEm+7hQWjhI4gqQG0eA9nAYiuaAsX3pQvbi8bFLfohVlabmfwmGkQeS9ZgwT0W1Pn1zRkxQrkHQwhApzL8+/l4v12fhzUAot5B3lDhkZ0ApP9F50kKYUTW43qS697ByvMqhjOyEf/IDQBe89kp6NW9vpvt92PhG96njWt6RMVmmtArMt3AA6B/GjfZFfDVEZNCvsju9LXtIT5xSBn0UujxkfiFX6XL6HHyTDgrC7kwJ1C3kidaHql/CI/00/OiTdYswv4lp93sdwp6wbnbjByIpy4GBa3uGlkVtnYevCFmpMiMApeP90aWY+YMPEPDTRNLBW/tfUlrSqaD3sRFpypItp1CrngeTItGsBwTWgQROyrglkvD3X+76Y/Y8nxjmsNSNF+5UzYzoo/TVJHmQj1JgqZyr8ypxPFQ7L7LDmy32vt12Os/0CQ5xkNkSgBcy4NMBTGKOZGNp08RviW+eXMiOcAEU9a9UEMkdPYYbiBWKoevFT0T+JgEnJEgI9qaWfEAF9cn/LWf7ha93QKW66RRliniTj4JcONdstZP5OXYhk9+1UiULG69pBdoKapL7uwqiYz9/NHq2mTg2sczf9upDKIL84AfyxClzMC+xL05fP9R6XKTUrG/kuX3dxNIt6w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZWtkMndVZnkyV3JMS2poSTQ0dHFpOVU3em05KzFjcDIzUlZaTitSdENUbHBi?=
 =?utf-8?B?eXlCUVU4ZXRLUWlTME11M2R3Y3NqaUdiU3RUQ1duL2RVNDhkc21QVStwQjlX?=
 =?utf-8?B?YkNFdzVxSkU5VUc5L1NGT2tmMEh1VU90NzIySjdTRHZ0UXlMT0k2ajY1MDl2?=
 =?utf-8?B?c3Z5UUVwd3FuRFVJby80djZ5SWZxckZyaVQvbHBLazRDR3BYSHlURis1SWNX?=
 =?utf-8?B?cFZsUlNJVStiY3ROWmtEMzR0bUxCUldXcUJRazZrT1Nxa1d3TmNPWTkvYmVu?=
 =?utf-8?B?UjJoVXJENUQ4SkhJSlhVTVQ0V01pY3ZCMzQwREgrUTF5VzZXbnVGajNiZlcw?=
 =?utf-8?B?NVFGV2JzV2hILzFyaEtNZHN4V3ZFV21DcWhlT1JQVUdRV0t3Y3BFQzZ3VEhU?=
 =?utf-8?B?TEJhMWhrUXpNcFRXdE9QdWdnMVhkOG9Vd2owcHMrMnhERVdsZC9Pa0lqbXBj?=
 =?utf-8?B?RS9QaWwyTHpoaUxJbnlyQVNFKzFsM084UjZyZDlxblpFMHJNbmFzU3k4WVAw?=
 =?utf-8?B?K3pJM3RhcnNUeTR5R0tuckQ1QkRxdENpMEVyREFVTXdHVlI4Z29yUm1jYnAz?=
 =?utf-8?B?QklmaVR5aTdMUGg0djFZRFk2Y1FKT3lkQUZsOVFtY2tMUkJMMkw2REswV0Zm?=
 =?utf-8?B?Nlo1UndrOWo1N3JGS1VHQTNZYUNLaDViMUpMZGtSTU9RdzlkMXpleDJyS09J?=
 =?utf-8?B?T25iM3lDVmw1NDFFbFdEQW1qbmxlWThnRnRiZ0FwbjBCYTFDLzBFWEg5MkRu?=
 =?utf-8?B?cndVQUNSUHNtaXVWUFBpWC82VkdJV29lOXo2WmtpOHBwR0FKUzRNNWNML204?=
 =?utf-8?B?cmVOZjgxM1M2d0RvK0pMdG9IOEkyMjQ1NkdncG5EUVVKbVpmak1tNXhaeDk1?=
 =?utf-8?B?MlFqR2RKWExCOFN4TkRORlA2WTJHZlJnQkZOdW95U0FienVYVXhwNFd2RHB5?=
 =?utf-8?B?Tk5kMUtTV2x0S2puU1crRWwzV1J1NWF3MjhRVjVENkhWUVJFWjZpUVQzL0Ir?=
 =?utf-8?B?NmdFTk5sTmlYcDBkdmlMK2ZLTlBqNnBxS1AzYW9GSTBxTTA4a0UyODZXTHA3?=
 =?utf-8?B?akxsUzIvbFcyb0Q2ZzRXZmNWcG9QOHlmSDJGVzJxMzNBOU1DNVV0cXdZZW5F?=
 =?utf-8?B?OFNMNlZVWlpnN1N2ZWZhRHl5Z2lJU0ZadFdOZnI3ajk4RUhJZ0gwR0NRQmxE?=
 =?utf-8?B?ZXlqcHVSMURaNmY4UTk4Zkg5dEh3N1I0YXRwOGJkUEwyU0xJdkVubktLS2Fv?=
 =?utf-8?B?YVc3ZE5CcUQwZXVQeHZhZ3lZZXRkeVQ5QjZaYVNBSlVxb0swbGZyWTRkWHph?=
 =?utf-8?B?cFZCSHdJVm9Jblg4NmxxMm5ubWhrUk9OZ0wrNnAzdmJtbTNDMHZ3TUtVQXpE?=
 =?utf-8?B?RnRjU3pBTVR4NGUxeGw4K25zRVd0RjVwYWRpSFR0YmJWYStRd2x6SlRZSVZB?=
 =?utf-8?B?OXV0Y0FtYXJubDExWHVUd0dEMzkvYkFnR3kranVnaXI2OG84ZlZDRlJuSmpZ?=
 =?utf-8?B?bnd3Y2cyM21VSlhmREVmdmJKWkZuMHBtak9kQlBpVUJyeGY5aWVBanptTk5a?=
 =?utf-8?B?WGdnMVMrL0g1Z3dqNDRjdUZKNk1DWEZTMVM0NnJlS2UzN0xXdklQc0pyaUpN?=
 =?utf-8?B?VUJHMEJLeHh2V1I2d3JMaTRWcGtJQzRqV3lSMlZRaXBMbS9nTzQzODNKclB0?=
 =?utf-8?B?T0JMT2JKOExucS9pU0ZTSFFMenAvTU56L3NTWTFqYXIrQ3dyblZQN2hVV3hI?=
 =?utf-8?B?dUZqZWVPaGFLZS9NdVZ2YWtkakFLMUN3bWl2ZUxyMTl2TmF0d3F3dm9HaFQ4?=
 =?utf-8?B?NUFYalllS2tOb3VmQjh5TWhlMEJTTTNzMFRtQnpoZm1MZHA4YWlyRWE0UkNZ?=
 =?utf-8?B?VnhKanhySW9vVHFXU0tPR0dkN0FLVHF6M3dRZ1FEYzlFOWRCOE15djBVdmxW?=
 =?utf-8?B?Y1ZBVVB6UWMyUksyeFJzTEYzSzlpRk9qeXVQeWhNNlBaMGlNQndCcUZSYkxQ?=
 =?utf-8?B?NHJ6eXFYcmh6Y3ZUU2ZyMmF0TysydTJ4endtUmtZWHpZbUhCMWxjaXdnMFRB?=
 =?utf-8?B?bnFOSzJWT0VMVERNcXRjM2RTMDl0VG1SdWp1Y3pBTUlSb3FiT3RtbUVHaUJn?=
 =?utf-8?B?bXpYTkU5bGczd002dk5mVHIxdGtBMllKeGdHK0l3ZnJVMDVMZkhLaVBoaUFM?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FDhHr/uo+pDtXjT54MAfHYcx/CSBwNxecWQdPf5lQY3QlkM38xt2yBgsFGjKT4gE+1PUZZhS/YfbFPZVG46GhBOajAAQMwh3cdFOn9hYuVm1jmT6Wcv7H12v9in/VqIjyhVwprWVklS7GpNEuamXkmM7aVIQWB1WPae1qgYSOwY7UUdBSIySN0EQSZk+iTebPx1OLmrnib4+7dcVuu081oibru8ibQApkoIK/HHZPlnkCWU5UoB+9/PwutA+HIOcRWJri7YKudTfFhnMlkyq43R+IfpJ9liLPGMYCMKcs8LBSiSYsuuBuZ9dBFvb6LeZZjwlUM//2rWo9Ddn9II0CRq8zlKU7GOzctja6aIC2dY9XYlBzexgIv4PRMspMX4OPu9ib4depRgWTM9GtZR7IAeHVik0CXBjjBYd/mapYbegR84WRCxGZnuNWzsDBmB6sBd2dZemM8cK4PENoeUbyvqhlool29rikopUJ85Ens3vVKnw3CYRkaTOykF5iwXQfp6YqCHU5S8yk+6W+VZbgtxC0QudZ6rtq1HJdmo5eqgqoAKbch2Q36UOy5J3rtGbrBexuZHxiiP4ZOGGaZ5KcmGFyjkjJGLxXYoxXBr4SnA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f873a0a-48c3-456c-02f9-08dc3cfd2707
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 10:15:16.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZM2JWTdBokjoKPC6OH6gK4t9XRNhITzT+MW3DLjmaohf+buPDKOfqZGHmQNeHot3R/nzuOph0peH/5uuUEgEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_07,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403050081
X-Proofpoint-GUID: s-3nTvYxnaJLxhSE1Mtzv4CGPqdn0pvQ
X-Proofpoint-ORIG-GUID: s-3nTvYxnaJLxhSE1Mtzv4CGPqdn0pvQ

On 05/03/2024 02:56, Jason Yan wrote:
> On 2024/3/4 20:50, yangxingui wrote:
>> Hi Jason,
>>
>> On 2024/3/1 9:55, Jason Yan wrote:
>>> On 2024/2/29 2:13, John Garry wrote:
>>>> On 21/02/2024 07:31, Xingui Yang wrote:
>>>>> As of commit d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to
>>>>> update PHY info"), do discovery will send a new SMP_DISCOVER and 
>>>>> update
>>>>> phy->phy_change_count. We found that if the disk is reconnected and 
>>>>> phy
>>>>> change_count changes at this time, the disk scanning process will 
>>>>> not be
>>>>> triggered.
>>>>>
>>>>> So update the PHY info with the last query results.
>>>>>
>>>>> Fixes: d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to 
>>>>> update PHY info")
>>>>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>>>>> ---
>>>>>   drivers/scsi/libsas/sas_expander.c | 9 ++++-----
>>>>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/scsi/libsas/sas_expander.c 
>>>>> b/drivers/scsi/libsas/sas_expander.c
>>>>> index a2204674b680..9563f5589948 100644
>>>>> --- a/drivers/scsi/libsas/sas_expander.c
>>>>> +++ b/drivers/scsi/libsas/sas_expander.c
>>>>> @@ -1681,6 +1681,10 @@ int sas_get_phy_attached_dev(struct 
>>>>> domain_device *dev, int phy_id,
>>>>>           if (*type == 0)
>>>>>               memset(sas_addr, 0, SAS_ADDR_SIZE);
>>>>>       }
>>>>> +
>>>>> +    if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM))
>>>>
>>>> It's odd to call sas_set_ex_phy() if we got res == -ECOMM. I mean, 
>>>> in this this case disc_resp is not filled in as the command did not 
>>>> execute, right? I know that is what the current code does, but it is 
>>>> strange.
>>>
>>> The current code actually re-send the SMP command and update the PHY 
>>> status only when the the SMP command is responded correctly.
>>>
>>> Xinggui, can you please fix this and send v3?
>> The current location cannot directly update the phy information. The 
>> previous phy information will be used later, and the previous sas 
>> address will be compared with the currently queried sas address. At 
>> present, v2 is more suitable after many days of testing.

I don't understand this. Where is the previous SAS address compared to 
the current SAS address?

Could this work:

diff --git a/drivers/scsi/libsas/sas_expander.c 
b/drivers/scsi/libsas/sas_expander.c
index a2204674b680..e190038ba7bd 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1675,11 +1675,13 @@ int sas_get_phy_attached_dev(struct 
domain_device *dev, int phy_id,

         res = sas_get_phy_discover(dev, phy_id, disc_resp);
         if (res == 0) {
-               memcpy(sas_addr, disc_resp->disc.attached_sas_addr,
-                      SAS_ADDR_SIZE);
                 *type = to_dev_type(&disc_resp->disc);
-               if (*type == 0)
+               if (*type == SAS_PHY_UNUSED)
                         memset(sas_addr, 0, SAS_ADDR_SIZE);
+               else
+                       memcpy(sas_addr, disc_resp->disc.attached_sas_addr,
+                      SAS_ADDR_SIZE);
+               sas_set_ex_phy(dev, phy_id, disc_resp);
         }
         kfree(disc_resp);
         return res;
lines 1-21/21 (END)

It's like the change in this patch.


> 
> OK, so let me have a closer look at v2.

I have to say that v2 is quite complicated...




