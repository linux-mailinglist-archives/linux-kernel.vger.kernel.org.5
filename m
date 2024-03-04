Return-Path: <linux-kernel+bounces-90192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D5486FB9B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FD3281A09
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F96E175B9;
	Mon,  4 Mar 2024 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X4pd6aVk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uy1e/9Fy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBB0171B0;
	Mon,  4 Mar 2024 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540357; cv=fail; b=rGuMg8b+ZNY4cEXuZmep0dqmAQ7owmh4bNfyWa6tVs0TlyCzsv65GCvvpEml7Z1RnNvRM160sgLb4BHPvJyguQ1lVo3pvz82V6efHVNJvv6+65V1APe1r3v03ry7L+IcSbY05Vem7f/5BpNlN9iQ2I3yl5mNF5VjmxVg5qwA9/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540357; c=relaxed/simple;
	bh=3cfHu5DvwQEP6vfIpGR9a6G9vTV7T4yBNz5sDN+BUHc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G/PMT28is6XSWwQ/EV7NAy3zHU8/I7kUoB8bsOFrC3XozMOkfR286DotWz9MwQjOxHtOtp64UZjSYSHijTxxIaplxmYceMZ2iOA/kKwuWDoVVBteTC+Gk83JkcjwixbNFr3WDXBE+2NwM4XOK2KIqLYzegcgfqSVNpSsngubsgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X4pd6aVk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uy1e/9Fy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4247hwie011682;
	Mon, 4 Mar 2024 08:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Kq8/cNWQ9SgHGl9bGzIcmIi9ElVPzkVYLMVRXAa1d/E=;
 b=X4pd6aVkDcssRsEA/oURr2GIUhJRr8ygRW5uVh8BSx39j2gdFJNTjfNcN+dw7V3Hjd9y
 DewguoCJANdyB4YE5YdCRE/4VlMSgm0pHQXw2YVi4zhRORd199IQy5z4M7d6iwvDB28g
 XU70+iDPQrfmjwgdBUYvvAamRkp8nN4pPY5tXWeehRHxjGS3+FajZSCQwx5YGaCvG5vN
 Z962lk/WglHKHF0DHDK2ZtdhT4ViOMGFtuacTpYEQuqdnK39l2MBHM/mztWHcIFr37Xl
 +juXhprezTdj/uWwWfvMMaZsVYgYIoxuucWfkk2jd9Q2wOb5UTVk2PvwcXndZF+NOlPM gQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktheated-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 08:18:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4247QhJ7017638;
	Mon, 4 Mar 2024 08:18:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj5phud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 08:18:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uwcrn9x8S7Iu00m+Jqgi2278moROmGRoRMjp9xhRqL0piTYM/fPlUrC44MVlBvOPBwW8uKlAQLFB+0GgSeMS/aVKlbgJbXkf73AKLiEc2a/SWd4/u8rPulrJbJVapoGU/amE7UGDEdfl7g5O/QsvzYpTSrDjneP+k1Xt3pPe62NyjBrBAv0Z/SpOZM/nrsCfCJUslQXQBjww637GU6lLlwNPdfmAS1UKThjLUXhJxGj1ssAYp6/Ixc0a/0rGxv4Jh5OxOv60dvRdW0eahYM5lgohpekFZy5vU4BrHlRr92k+gLn8Meu9Pc/LUWDusNdM9M3fWg+a4ch4/xtUuWwf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq8/cNWQ9SgHGl9bGzIcmIi9ElVPzkVYLMVRXAa1d/E=;
 b=VNogqdqgoxD7Ltb3aoIs2JSSoz1nR3GEQqvhrDrZUrd5qpPVcrgbZHLd59zsaBq+z4Z6Puc3FV+eQKIm/jUaPAN+pAKHrlIvHuucl16gMiFv8yFgHqsvhE5bPngF/GOB3G6RoWIeIlTXKdEmZHJP0VTa+Vk6eQRgaVG09UlDFuouSJY+c6KzGD3YuOgR8AOMNCzjQnF1/mTFA8yDoLkvN/6jb2S5GWKzoPehwRGRS/9I9OUL+kkHZeRf7sIo2q0OlgK9Cc9ymSczoW4VL8QCgYcenw0Tl05lTHde50mRG9NRPF7ZZhXPLJN2J7OYcdWe31rmsrop5EXiC3EWbeD2xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq8/cNWQ9SgHGl9bGzIcmIi9ElVPzkVYLMVRXAa1d/E=;
 b=uy1e/9Fyy6d5GDEkITPDSDB0tNSiiPF/1aUyeAR1GWiCNoNOwM460KDu1Ieb+XrET+jo3EWYrmtLeEMvn+qykih9aKwyIVEVBTAZv13FtPHueAg1cNJLftDoWBTPjDLjZfLPqlt1TD0d6OM9bMD/LwQu/RjE+sYM9DkyVB17HfU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB7206.namprd10.prod.outlook.com (2603:10b6:208:402::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 08:18:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 08:18:44 +0000
Message-ID: <8b65b2c3-4313-489a-8454-8ea82f6ad56a@oracle.com>
Date: Mon, 4 Mar 2024 08:18:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] scsi: isci: Add libsas SATA sysfs attributes group
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel <cassel@kernel.org>, Jason Yan <yanaijie@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240302201636.1228331-1-ipylypiv@google.com>
 <20240302201636.1228331-8-ipylypiv@google.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240302201636.1228331-8-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0213.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f9220ab-de7f-4e85-aa65-08dc3c23b561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RRT+PQgAiDjFwpF9AWZ3IiOyWsux+2kSZbaSZ39QPD4CDptwyyTU4QSIKEShoP7O8DCFSsR3AZc3t8u5Wpr8k6vl0hPaQX4Md+pB3RNWa51ClWXSd7W61Guu/WPBPmo/kss2b69pZa46xfVfRJ8q2Hp2N43SbVudgoMJFnxJ1e0agok0MVzLI6ht7fM4BI8jvPp6REyLx9TgRaW9L2WpRvDL7MBnAvd5tS5Ro4zS4Ir0I64QbF1SEujoXIjb7fk+JYJhi2CzyfW9FaJcbC4zXmu6C2coSoUwtekaED/y9986EX1nkulf9OhAgzPVrSJ6ENFlIQdVupKhxPvuwDz0klMbxwn+vSNwQUCMr/L98a0/mNIVGUlIgt/vb8Gnhpz7/AADPpYRUm2fJNOzX50wMj/H1u19U6XMLN92DcuJqaZYKBb3GcCw4GJHWgKMqpmjmHqIOCYSQt4DYqabcYO/aTWVXOK5x3gGmV2Qt43GCWyRqKQEobOXAZhnDI2nhrnzGnmRNz8d8TedCegO6i2w5sMWs6jSnWuj/msIekUsZJbQxHepYn0IgURi+sR6Id7zvQbSfAY712JHXP14hYkf257ETsTYNBqzt1vZ3mTVzoufaM7AP7xD+VzkyIvCuu59nMk6e0TFuPHWzeojSxfC3ZsgrR/K11qxoGJveth5g7Mn9QOBf4/TCHWhDAjzdeWsSVHjgnczFuzenybGVJSzNA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bXBabjBvZW93UWl5dFNWRUFrcFRPZk14cjhlckpzY2F1M2F6cjQyRENDMVJP?=
 =?utf-8?B?MkJObkhleWJ0blgwcUViNkFuVmRIZjFmV0h2a1V0WHN4VkcwbVZZRlFtZFFT?=
 =?utf-8?B?UXp1dnBuUjVzcVRONUh5c3J0VHUvbzZYcVJjM3FVL1FxMXZIMlZMV2RIWHJR?=
 =?utf-8?B?K3pBRGRENlkwOE5velNiOEtNU3grVVFzcnZOdnRTbElrOS96YWVab0pvakVW?=
 =?utf-8?B?Z1dsVTBBcTNocS9XR1pMOXNCTWxWeHZEbEE2aDAvNXFoSStvVDNFTFQ4SlFy?=
 =?utf-8?B?dHQ4a2pBblhqdWdxdnJ5SUJZTjlSdHZFRGd5Q2FwdnhJVTdha0lIZmFZZ3U0?=
 =?utf-8?B?WG1RQSs0T3Q1ZU11bHBOTTNjZGtzSXNJMCtMQlp4ZEV5cCtFeW1ld2dnNTUw?=
 =?utf-8?B?RUQvSkFIMm9VZXVSSXFZWDhZZ2RSYS9nbjErVzhrU2JFelhyUFNzYmp2c21Z?=
 =?utf-8?B?N2tvdzhhWDBzN0RJck9EWnBydVloUFI4UHZlaVovNy9IdUtvMFZCNFpObFBI?=
 =?utf-8?B?dFFXSEFvV290aTVLYzZJb2lxbjNxTEhGQTM3QkhjbElMR3ZqR1F5VFRzUTR1?=
 =?utf-8?B?ajh5KzhhMW9VMFpKZFNudWNXZkpRL3lIMEFiMVRhNk9jQXdkeXZyTHJYZjBv?=
 =?utf-8?B?TzNjZ3pxdlp1eHlzVHlxa2VVbEU5NlV3TTg1NndWQ3NFVEM0Y2lrV1BtM3Bn?=
 =?utf-8?B?ZWdxQW91czcyMzBCdnJpa0ZnaHJ4QkVvZUVlOUhsb1AwL2k0UFRCRk5nVVY1?=
 =?utf-8?B?Y3R4cVp1Q2x3SE9jQmtHWTVKM1B6OVFhWkZnMTcwNTFHc1NNcTNmTWdHZjJI?=
 =?utf-8?B?UlZMbUl4b2cwWWlpL3VmWWlHZEFYY1hKMXgwNSthTjZZeFhtTG43eFZtZU5r?=
 =?utf-8?B?Mm9Id2FkaEJPUmZ0Q0dFWVVOYUxQVlphV0NSaXNCeG9Ia1YycXVoMGNCUGJ0?=
 =?utf-8?B?QjM0bUd6cGRXaUlVNkVnbUZQZDVZUlVHRGV4V1Z4MkhhTnZxeTNiSTRFbFdn?=
 =?utf-8?B?eE5QaVVQMVlpc3pXR2pSTlRENW03TXRVNy9CaG9DcEdwS3B0Rkc2dWxOTnFF?=
 =?utf-8?B?bXZLSHBIUm40bFV4Ny8weG12eXhDTjM3aEpTc1A2OXlOSkJGVFAzZ1Q3SzEr?=
 =?utf-8?B?YlVuZlpIa0tNTHBrVmg3bEtURHBsaEFTWGRiVEloeS84K202RjdYN0pEb1U4?=
 =?utf-8?B?UnhHTTJTWllqYzY3Z1Rsam1RZjFCTnFhb3k1b1RKTGFyNVdzTHJYSHM2Q3RS?=
 =?utf-8?B?c2dxVWthOUF6QzRXTmpmN2plWVd4S2ZMY0R5UWJ3VWhFQmdrdnNHS3lHdW4v?=
 =?utf-8?B?WGF4K3JPaEZCOEdpcmRzZlgxSTZLK3VrT0NRQlVmUytOOHlMUlhmNEZ1R1Fl?=
 =?utf-8?B?bmlRMk1SZ0pzT2RzeWgxSlFoM0pDWTZHUVYzTUdoTm0xOTFIMXlwK1k1L0tZ?=
 =?utf-8?B?TzVoK2Ywd25FU2d6YklpQjUzZHNYa2lCT244OXZBUytwLzlWdFNwY2YzVXRu?=
 =?utf-8?B?d1g1VTE1WHYrNnZzTlRoSEoxMDlqYThndW16SGhxWGVBdncyV25JUzFxRjgr?=
 =?utf-8?B?TjB5dTNMeFNoMk9XRUtMMWQrZ1N2eVAyNXlDdkdpdzIzdTVtZG50alk5L0F5?=
 =?utf-8?B?ejdzamZNa2NhVDZjWmpTdk9QbUl3bElrWXh5SHJITFRmcG9rZ3hoa3dTeWpG?=
 =?utf-8?B?R2NoelU4Z1JnaENZNGhBMHVZWnhSd3ArRnpoaHBHY2V2am1lUkhZdDNBb0Rs?=
 =?utf-8?B?MGQ1NGxEWGh6MjE3d2l4YnVrQUJFdi8xc3FjVmhwYWw1amF4N1VtVHBpUm5X?=
 =?utf-8?B?OUtCUXJnT09xUXpWaG92cUxMc2kzaHJ5ZHBocWRlaUZVUVZDRkxPclVhMVMv?=
 =?utf-8?B?YU4xQkxaNDVyV3k3Uk9lalMrdFZRZHZwd2ZORXgyMU10MEFoZGlsY3ViVzdS?=
 =?utf-8?B?dk5MSDVDMG9sMFU4aHNlNlNGQnlobkkvVXBhQ1pYcXh3ME84TFJnaHNjam95?=
 =?utf-8?B?d3B5UzR3cittSUZSbDNGNThZcWpGZzl3bXp2cHR6K2lLSm9VT2ZtOWZyL2Z0?=
 =?utf-8?B?SE1YRG9lNUJqdTh1OEM2Ukg4Q2YweUZaQ2l3VnloYU5qbk9kd0IxSEZtdndZ?=
 =?utf-8?B?NUtJbWxtdkd5YmVaUmRzeHlwMkQ4aEJsa3VQUE04THlrem1Vb0o1c1J5bEVE?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mPqSIB5Iq5y8tna4A5wzrYJ1l9qqEbo8TqFV89rs9M9g+DAa1wRig75fhKoIiOAP9ceT1yrR+eZfoifQozVm8FVkjFqi9ANcGRKoBemtoZr85s0Ufm3LdKv3O0Fx6Bv174zL6S1rS9WIo7LJ7fNrQylKerUtpKClrXyLdDXdB1thO0L+qGXiCj7mZwQ3kSDJ3xKaRCAOAh+1kwS/2s1YoxSxpD1Fh2A2at5OIumsV2WlNUJszrKZqA5chOKAoyuhLXjrEwHBq0WBCl4B8hiKtEL4VCrEk/eTGpIMYuBU3t4sUea0M/0iKKlIi/8elOc2HnJ+KjDS39VdkApOHgDZXTh5kwE5Oq+JJxz1bEc1AAcXj7rOzCb+s2ipA3aG++USDqrd1cXVbdymvRf8dzEW8+wDchb7d/IGpmcEQEhMKeYo0aoOLadL2EhlK/KMah9cEogOPbO0+r+2+KkNnj3HcHA9CsCeqBob0O8qfFdovDiv5osxgBuTg0BSY+Cf+0EH49OY/yFxDx+5IcLU1VDoA1oSqkHVNNw4dExLM594eNWpqIFQgTWXvd1wKoMItyebhMjObgCbSpU3sP0Q99q1BJpyx2k5DEUBSok8mA9UlqQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9220ab-de7f-4e85-aa65-08dc3c23b561
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 08:18:44.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVNkfMA8nlXsYjgjiMRpvYQbR8f5zAG592qfADpnCEf53bp0NAq++Rg2FjIqGvtZeipAaBrqe3jnrdbb0lMk2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_04,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040062
X-Proofpoint-ORIG-GUID: 9AEWQ3EzZvrKXLGKkJ2NiiAg8v7NuChG
X-Proofpoint-GUID: 9AEWQ3EzZvrKXLGKkJ2NiiAg8v7NuChG

On 02/03/2024 20:16, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Signed-off-by: Igor Pylypiv<ipylypiv@google.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

