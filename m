Return-Path: <linux-kernel+bounces-95299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E777874BED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9267287106
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C9F127B4D;
	Thu,  7 Mar 2024 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cDPueikS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q4wNwvNK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9545685279;
	Thu,  7 Mar 2024 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805906; cv=fail; b=P7UBMJxy9JSEJf5M4JQbEOiBcdJwjYkOCE7W4qlsTTaFj3ljUrSwa86C5I3gtn2u4Zh58OE28f6aBQDXrcIGX/tcGAVmArcZcjg329DO18afdmRUIw16q6kCDaCB5gs/+Qn07zYeq5J3EuoCjqpI2qvb95ej89KEMY07DeyHwvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805906; c=relaxed/simple;
	bh=h4pRqW7qyL2xWc2o9uz2bK3EGGVqe7CvYmX96bSDSZk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mB9Q5I0ZgGoxHNZX3E/kqAFHQ8VGNbfIeGyraj2orzCuFlARGn/U5iUhLYr81KaMNBH63oLvMDqctmPDsnJd83AV2favYUFTeOb1LFRczpx9oFDZere4RuKpdDf1vBQutLt5O2Argwaa3O9ESpmDNg759w3m8BcEO90PeneW2/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cDPueikS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q4wNwvNK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279n5GB020679;
	Thu, 7 Mar 2024 10:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=gtoUi766jZfW+1o54d4FdSg9Tws06O3relubQZ1IRs8=;
 b=cDPueikSB+E7/OR56F7gQW2jwr644RsTJVWnhubzTK6GJGsmtfaE0F1oEQN5GIgjAwzm
 DAWYIMoneSRBENj05zW0c/3+A+4rWmTpw/6kfM3BnOtpqc6h1XXXx8TaWAMSGzuF79Qt
 mtxJSW4MOLGHgOSZCAwhRQa+fyQA5D59bjXypt7KeZohJq9VZ1mwUKDT5qLKrJ8Luz3Y
 0HxIX4StH5DlKWB4OUUHOtUkthK4HeftvroudiQO8Acc+ZFUnm5UZm0tluEnJKwRVxxo
 oth3l+LdMeAtcASE5XGiceTmqOWjJ5mCGWL8wQ4u04Yl8aYrMqfOb7vtSFNk3HL9exfm Zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw4bg3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 10:04:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4278G5LF031907;
	Thu, 7 Mar 2024 10:04:47 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjayyr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 10:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWxvJgLnJZXbFK/qvg8DhAWA9yJdGkE4Pb1PYol9gQVJv5oEtyrkfjCK/GBl5OBRLiM3JSwPCeZTqQbmsOTMBlxa7jgq4gIsNdJ35qpE+U0EMH03CCl6Yqs4W3bJ4MaKR+eXtKaiDgT1QSZN1Bthz8K89/K3tO/GloC8GhxlEB6K+17+EQkRm7z6CgODQssEwCvye1XaMZRTTadyUbhiYULjTXqQP8sDUsEnNx/PTfAOjXeg+pQl4RFrhP6RdQcezm8yLeDojsSyKzzO/+jRv4lRnJCHcQ/Y+a1QEcfmvu7EztSQoeQn8siA1Z9vacvlHahM6CKkeT1Ma1cSoRINPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtoUi766jZfW+1o54d4FdSg9Tws06O3relubQZ1IRs8=;
 b=Sgp5P3GCdlhIrlkXHFmr/nTcQVujBx4ner1JZNX1DURDuvWyr2b96aTuatBehqu74pgu+M32JuqbgefMiRMju7HXJRFdHdIjXIk9D9HEGRiowKwRPrTaX85wW2at3XoBFj6trfXpjf2lCRL2viwk3uXE6u8AEoZgVuTlQUWzke/u3OT4bzs0jxqD2rWlopYNkJK/goc7KSND5zf62Xxn/gctlKKT60xyrG7BxRWYslj4+FUCb7GyxwEKZXxbqaoBfUbNFbt4/b8Q4P3htXFc4GVxEYGpVSErokYm1WWLZUOGEh5v9+nB/dGeCU+JXaZnQq9Qj6kjAqpjqEDNdk0hgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtoUi766jZfW+1o54d4FdSg9Tws06O3relubQZ1IRs8=;
 b=q4wNwvNKn4Np2dv2hXNdjDKe3/LGRh3Wczob+1SMEvUW7KdDb5vuDpSV7yC33iJR/ib+9owflPAXR8AS0Xcke4sifBd0p4chC1QGz419fyClJocsjSIQGdaMyPwvuPvuaArL8MDJ9AOUEJrXg2V1rbWl0av2PTKxRk4UvjmMVSY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6142.namprd10.prod.outlook.com (2603:10b6:930:36::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 10:04:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 10:04:45 +0000
Message-ID: <01c09e14-e991-4c3f-a747-3cfd591c56e8@oracle.com>
Date: Thu, 7 Mar 2024 10:04:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] scsi: libsas: Add a helper
 sas_get_sas_addr_and_dev_type()
Content-Language: en-US
To: Xingui Yang <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        chenxiang66@hisilicon.com, kangfenglong@huawei.com
References: <20240307093733.41222-1-yangxingui@huawei.com>
 <20240307093733.41222-3-yangxingui@huawei.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240307093733.41222-3-yangxingui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0024.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 99dad832-6c1b-45a5-3904-08dc3e8e03d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gfsjthl0oEvYM9cZqi5i6FJF7Au/sIOAfcO4GPGd3muYVkA3Rjcpszmxy4baNTliIouP2ESlWbcY8tZVU16dGa+Ml5c0iaxYOpaIdqBi2JWsQborOfL6a2+CapR0bpS+TVGiXfwLmH6hxJw8E/5pdX8tZ8n9Ul+4FEovRdxHoOWhDAeSwx5NCAAY1v06ETfeimglsTbzsLEoV3blcBOuUab4Z4C3Zw2jPcT9uwhVf/HTXVYhLYPxFTDAGG0m14siDXSU8VEuSfBv2JpqDqlTXwLOVqEhvzDatd3VKahmvqIQEIVxyGPRgkoOHY5pBYSV3KMpIOGajnKlG/5sn4nwp6co+PbS/IfCH5qOKoFIpib/20ZJXp+4NZpwMP4cwb65cK6r1luT8Ofr593FQaE8QGDBpAIwjrMPXSfAiOi8K2tIzwi9GmiEpfkvTB0pOBOCq6fjKT348GLBaUy48Es+GtWLrx/8oePFa9XOV5av4HGZUALGSkuAO6Xqhmk9KqC+bM8P0QwHiwXektg2BOn6POof7QuBL3cUgjoE1iv5L7ICVKINDpoXRSXh9p9C3SIdwdjin5kEiipUAgHmonGWyEREhYtN+d7nn2cUbNWJBiSTqmruWdyqnHDB6cDrf6nY5q3kb4x4HwVstdDRd0RiMJCDyji0BLCA/7F7MUUSBzE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0dYU3BWU3B5aElTdVVadlVnVng5NU1Hazc5LzBrZE5mZFhVOEFyWUxkUEpl?=
 =?utf-8?B?MldxLzB5TWx0WVB6RnFDZXZpZFV4TXRuRm1mMCtHakpEWEF1Qm9YbXQvTTBz?=
 =?utf-8?B?U2FKME5UWGYvZkdOOFR5L3N0eFUvd1pUaEgxSXRrTEF5aG5oT0JsR3dRTVg3?=
 =?utf-8?B?NzR6blZudDdETkVzT2hydEdZbnp4a2ttbVFPdEhoYnpwVkF2aDI2R1ZRbG91?=
 =?utf-8?B?UzY5bjlOMFozS1FWYXg5aTRqNWhzck9IVUVFUnEzWkhSaXZqYm9HN0hBNWdp?=
 =?utf-8?B?MS9GWmYyZ0VYQ2hjWWhyRUFQdFhlM0xhUHdVdUtETUtZaXdWMnlvak4wUmpD?=
 =?utf-8?B?WGMvQnE4T2IwOHlEV2RtRTRpa3BoMmM2Y1ZYS0dwWnpkTks3YmhqNE5rVEJF?=
 =?utf-8?B?cXVRaEE0NHNTZG5uUE44WHkzeS9vTldxeTg4eFVKWU1XdWN1ejEyS1luV3gx?=
 =?utf-8?B?Nkt5ZFJWRDJSQ25uNlZUcmxPdGZhN3BZaERUQzJPaEZPL1ZIME9CVjRjQ3dC?=
 =?utf-8?B?OGpLSzlmVmZONDZPeUU5OU1qbWdJak9CSDNHb1VhZWR5ZlVESHlZQWlTQjMy?=
 =?utf-8?B?Tkhsang1Z1o1VjJzYXFjamt6UzFPRkhUd3ZQS3g2V1BZM1gzQjhrWWFPT1BP?=
 =?utf-8?B?dG94aE95RlNCdUFweW1QbzlkbnJXVzc1b2dpdW5KcjllOTRXNE9BdWI0T3FC?=
 =?utf-8?B?K3phM3puZmZJRzVVeGNOVlh0eVJjd3JFdTBqekFuR00ySzhLOHc5aWJ5TzNS?=
 =?utf-8?B?WXA1UXFrYkpNZHRFcGo3TjBEQlppSXg3Y296Zmw0eHhJcWRZQVZqM09uWlVO?=
 =?utf-8?B?RkUvMUNDMHBGbUc4a0M0WDEvSE1rYVlYSW91NVBiT0Z2UlFXUzI5N1UrU3pp?=
 =?utf-8?B?b3RhdzJINmJVNmxOK21UU2tkaGFYOHF1eWpvY1NiMmFTeTlnUXRqd0FoSWpu?=
 =?utf-8?B?c2RCYTlmekwrdllFZGlKSDVWQzhRMHh4RFkzYmtDTnQ1bjN2RXJKVDlNYXIx?=
 =?utf-8?B?T3ZrcS9YL3hlMUJOZzErKytBQXArNTRzQWZReVc1L1NWazNOR3hkOFVvMEFD?=
 =?utf-8?B?YkdPN1ZHRVJMbll3bzFvUjRPOVZWSXZ0YzdnMXpGME01WXAwK1pOMnlVdFl5?=
 =?utf-8?B?SnVITU9wQzdmWWlQak0zSzZCR2RNMUFVVkptRmdXdHczQzVHSDdlWGJEdUxl?=
 =?utf-8?B?aHR6YlZCWHBLVDgxWnhJUjVETWhkWGF6V0xkSUdydDNDdVZ2bmc0MlhXZHp2?=
 =?utf-8?B?ZVZBUjZ3SFcvM0RmMnJWdnZVOUxiUFh0SGUvKytiUTh2bGJLT2djVU54ODlz?=
 =?utf-8?B?aDJrdzZSckRGYzZRY3ErM3A5MEQxN2lqVjhOWHJJZ3MvOXV0QSs1RzF1T1dT?=
 =?utf-8?B?c2kySlN5MG04VGtiUm01eldvZktGU3Fqak5hZjVWREg4b2o5akdwUTZVV3Nm?=
 =?utf-8?B?TzJ0MERKbjJtWE5xWThNU0tMYWlZdzRtbm5xNmVaYzlaN3ZIbXNhc25lc21S?=
 =?utf-8?B?eFJrZXRxczhqdU16TGJvcHRMYStwbHVlTy9JVDM2UWxXc3RFOUw4SldjR2xW?=
 =?utf-8?B?K0lzREVmaWlBZXh6SWxSR1NMTEEwVmF0MTgyNmFVRW1kaFpXYys2SG5ZSnMr?=
 =?utf-8?B?SlZEcS9LZmpjdi84YWdHWUVJK0RZdmtVamxmQUNsRWc3clpoSkNHN1Q5YzVF?=
 =?utf-8?B?YzFndlEzWmF6U2g2cnRXc1lpWE9VN3B1U25WeFZWL20vSis2a3ZiTUlTNzhH?=
 =?utf-8?B?WkdUVDZWSzdzS2phSUxDKy9Ob0RaQy84MHdJRGp1blQzWHBRZWk3aVV4cGxt?=
 =?utf-8?B?ZUZrL05oWlROenROcVFIdG9vdXYrbXVJQm1iSUp4TVdEb0ZGR0h5RnArSTVn?=
 =?utf-8?B?TmtrM0pWbVV2SUxmOFNMN3RMS1Nhd0U3NWhhWHRjQmRNb3VUQjdhMjFXR0Ry?=
 =?utf-8?B?OTlOcVEyK1F1YTJ4Yi9KKzlscklMTXFHbVpseWQvQTlwdlhGd05wdjErRmoy?=
 =?utf-8?B?bmg4RWF5Q0tEMHNBa25RbWsyaVBQcklUYzJYZ09DWm5BbENzSHBVckpSb1RQ?=
 =?utf-8?B?V2ZBYUxuZlZVRFd0Q05VUWRTamgySi9RR0RENzJMTlZad1prbWR0TStybDJl?=
 =?utf-8?B?SUlweXU1NzNSTEVUZUliZ2NQQmc4RTdUaWlKTE8zQTJZSEdleGs4aTlnYTg2?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DMNofHAVmEn9m1wi5q6zMbB7IiLAHbsTgcMJONi0VueABZyxxR7c/9+R+ZfAPs+yVwh4ECVkTgqdVtsyXJ7kZADCRYHLFEr4HDnDqh8brAf+/+qzAQgCWJTVjoFnHgjw+gyHPZZ4rKqBFjGXtzakebTCtwMuwt+pW18s4K1Ubexr+Ra6VdPwknWrn7OYkacDGay7AGeR0ju4+IT6Ts3Qq7oR9EquQ+o4W+XiOyvGNEEy6RAxP7zKnipfkCA8VMIryRkQzeCAkzItt4gG5wLzKv97dtds86+3hmt5rXkWVdb3L4W9UmYtfEO33N6eyPzxAmeM11yN1ZccpKtv18/MB9DCmoBP5h0d4Un9G0jhfTT58+I7Q/U/N0KaE757KA3/xmt2lEISrj0i5H0n5qlL8Q2yFhntvDw920UQ8H3c2cnxHkI2ni4JneAHiavc9VzcuIuAjFdqPm9aDteQjXHdoipC7CZwupAoDU0EkL7Q9UutFvO8lqIah0V+NMpAv+KZ9PwNyNQnx7x1LA28MW63s6KJNCJ2GcPEWcTiUdILznWoCAS2hb9SkgjRd/2h/9X/W34RN+orvQDpV0NJURBfph+00laAvjknToGvNZR6lq8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dad832-6c1b-45a5-3904-08dc3e8e03d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 10:04:45.2313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogbYF3bOzJ3ZKZb1wXdYzFM8D+yUfSHzRwmNFaMgmjlOuQYIA+a74zvVy96P6gIEkWHnh/tCNRa4mumXZhCNjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070073
X-Proofpoint-ORIG-GUID: v0vLrvm9cVxrIg4v5vLjFkxbkzKZ7Xam
X-Proofpoint-GUID: v0vLrvm9cVxrIg4v5vLjFkxbkzKZ7Xam

On 07/03/2024 09:37, Xingui Yang wrote:
> Add a helper to get attached_sas_addr and device type from disc_resp.
> 
> Suggested-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   drivers/scsi/libsas/sas_expander.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index 1eeb69cba8da..d6147616339f 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -1631,6 +1631,16 @@ int sas_discover_root_expander(struct domain_device *dev)
>   
>   /* ---------- Domain revalidation ---------- */
>   
> +static void sas_get_sas_addr_and_dev_type(struct smp_disc_resp *disc_resp,
> +					  u8 *sas_addr,
> +					  enum sas_device_type *type)
> +{
> +	memcpy(sas_addr, disc_resp->disc.attached_sas_addr, SAS_ADDR_SIZE);
> +	*type = to_dev_type(&disc_resp->disc);
> +	if (*type == SAS_PHY_UNUSED)
> +		memset(sas_addr, 0, SAS_ADDR_SIZE);
> +}
> +
>   static int sas_get_phy_discover(struct domain_device *dev,
>   				int phy_id, struct smp_disc_resp *disc_resp)
>   {
> @@ -1684,13 +1694,8 @@ int sas_get_phy_attached_dev(struct domain_device *dev, int phy_id,
>   		return -ENOMEM;
>   
>   	res = sas_get_phy_discover(dev, phy_id, disc_resp);

At some stage - I am not saying necessarily now! - it would be good to 
stop this function returning both a linux error code and a SAS protocol 
response code

> -	if (res == 0) {
> -		memcpy(sas_addr, disc_resp->disc.attached_sas_addr,
> -		       SAS_ADDR_SIZE);
> -		*type = to_dev_type(&disc_resp->disc);
> -		if (*type == 0)
> -			memset(sas_addr, 0, SAS_ADDR_SIZE);
> -	}
> +	if (res == 0)
> +		sas_get_sas_addr_and_dev_type(disc_resp, sas_addr, type);
>   	kfree(disc_resp);
>   	return res;
>   }


