Return-Path: <linux-kernel+bounces-90188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 193EA86FB88
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DA22810EB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF03171A6;
	Mon,  4 Mar 2024 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XNB1T1jx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W8jhfxo4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AEF168BC;
	Mon,  4 Mar 2024 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540314; cv=fail; b=Rabgz26WI+NGSXihnQXT+4AKA5pLELtOlnz6X+v13dbaMeLlofLp/vzCKtRmIpXgMdrKuBtwSmjYFZAwq+ki9nnT9XjykYtS9LpRDrUyCJtO5lMG+QeRPqQl3kRsuleMYzeduXP2Crfnm+mD8dRxkCqaBhlWdmQwO3D0ljn5/Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540314; c=relaxed/simple;
	bh=9jI7qIZvf/wt1mRokUeNnxopq6KEoZkCaeN0vjfJ8lU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LEYE9KITvjO1xmORA2Y50MTSWGqRZyEHXlLlOOVD2J0KUPsEx2Mq99PXFWu1jJgf3bA2uDJQoRpOq+4ytpSfR1QtudHfLe/iUidhwrIUulIwguBpFvFnkmbqFN3QusOKgRrBj6iV8nOAmCgoDZkI8uvx3FxBMjQtwc3LeTseVmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XNB1T1jx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W8jhfxo4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4247iBDI019943;
	Mon, 4 Mar 2024 08:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=J22M/gXk+KKBTI0kHk5AR7/CRfYbGjGfZ1JQwotal9I=;
 b=XNB1T1jx9oq1P4MvxOjVqmA15MetTfRSdHZPhUskqLOXf94+ZEFA1XPoqYPJ3TlyvDex
 gxyT6WPuZMCMoGGoTL9JflQYSxbqP+OnYMDWWLZtmha6zhoTCxYqhen6rfudUPjE8Zto
 pg7ZyXIIf1a/R97JX4HsjAolp/OZQo8PdTnaWYyMKs6o9A7Lmtnk39oBIU0OrqDa+a6G
 f7hLZ2rbQc38vf5uFPPzwgwysJQb/D/m6oqDLnh7bTU8y2aP4nw5vzG/ahdf0oFDJZlg
 P1zPG5VEsSBagAw9vmzyRRIBSsMqf/GSrLya1UTY3G84esOb+kOQgv+uA/nHJsyR6l4r Pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv0baqh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 08:18:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42472eo9018934;
	Mon, 4 Mar 2024 08:18:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj5dqs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 08:18:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReGnjDMzEl3SQJQgtX2MtsceSMNo9nJ8LapiGz+TJbs8+0cOgkJKbnc09uxlO0S4jlGskSxG3m8dj8eRbE5N4j3VnSWyZe6fT0N0scBxxjtrnUBB++mYIYF9e2vPP2Rmi3gbYtXYEbGv8XY63vDFXDc4ei6y1Un91qNMdydao28x1JFhFabS+7MGfdfgm4mKgec5iIGq+Yes2LEDwg41U3byWNPDjXiIkOlsPhzFy8CxtooMzJN0UH7QMA2k0bC4Z4Bn9HkNriVP5B0+9b4fjcL8Z7HFNrBcKp3Ga2vhWplXF1gP7NKy7Yg0BcNv+etAnj40ugZq5OHsEvnfmos+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J22M/gXk+KKBTI0kHk5AR7/CRfYbGjGfZ1JQwotal9I=;
 b=ML76ylGauGHHghSVyYwdpHRzhsDvnCANXfByob34shkmJq5CQjVv9+Cc0AAMseVQajbxds/8Hepb+HEMtbC6R3w/cegclyyrlLpFzPvCceGy2UuWKCWnX+Q2BEWy8LugIttgPw986eXmh50tKvePiOvTNuQTMaauXkj41HTFwSL86IzeYqpaEFxdQCZy0VotFk8WTAVepCaSZSfRLeS1r8cVAZWTWxIRKGxEq7hx/81WKnR0otSn54Nnxme7lhgE9uHpFF8tCr1HsSLSPliYiIS3vR6SuhkW7K5kaxXv5Ud3VkTz30+6/g/A5MZW+SgU+wWu8tzq9/icPkEDkw0QzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J22M/gXk+KKBTI0kHk5AR7/CRfYbGjGfZ1JQwotal9I=;
 b=W8jhfxo4UVJJPoqmRnLLW9IUGA34J96Q46OFsB/UcLvw5/RC9g71CBIOXvlTiDdjvW6AkhwxQ7fDSOkbXsGRAckcnWaHmz6TfSfmf+E5QNQr34V5cwTLnWQPddd0SRmpI7jBclJNJ1LvA3TYB32yReanRknTWugeBWKRznVpMiY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5676.namprd10.prod.outlook.com (2603:10b6:510:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 08:18:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 08:18:11 +0000
Message-ID: <4d09ccba-32f6-453d-a4aa-6c5b127a1721@oracle.com>
Date: Mon, 4 Mar 2024 08:18:09 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] scsi: hisi_sas: Add libsas SATA sysfs attributes
 group
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
 <20240302201636.1228331-6-ipylypiv@google.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240302201636.1228331-6-ipylypiv@google.com>
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
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d85551-725c-4476-d219-08dc3c23a165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nryvhwg5fu9XaqElfuJW5ooXfxQNdFKElG/mOkJ0ayaCXPyFQTeTvFcI1wPahSuXXCLlg756o/pTS8lcjpZL+3/BtB17y6jT1nq3gxFbbUqA3l30QABUaWSHI4ysWDf8ALspm956e19gyT4xEDhWJiwgQnNSCF07WazC8wFtT7ZqW6p1caTcsY1vdBBJQKX4zb0eXExDBu4kooblJKLPYug95LbV/ndF7aJ6MVgpBEjwjtTeiHz/z7fSU7zlbP6XLwWHuPXFYPhJIhmuje+kGfTFPtLP85GXDNSLuHw3q7/+gZAwAXgM6xcIlBJwDQAq4Ns5n9oxloRm/w+EWHwri5mxec8fcshtD4RLGQGBdDIxZBoVTo9SNdTtt0jXtras69k8bHQK570y2lew5kWeFwGD4YUDzgKNjIvMJZYg0PK6Ua2IYRQ1oYq77Ezo6p6wozZli91UTArQWMoyutqm2Ye56Lj/bufekmtQGgaDREOhdKHMW7KixSPt7d1bJ6hCkaNq3HHfE52nfM0goIfBXk7ylgvCRMv3ueMBR3ar8yFKtybdk0B5UI1HFtdeWRoEJR14oQ/UWANKZiVgN87vNzgEWYtwEQfVtgo3/PB4VtEjBISGxdD26BbNIqYsSbkk5ROQvumDWOyD73/bTuPeCoSvLPUzoGXV4y4qSzKCJ7zKw6sFXu9JiOla/jjSH62XgXGinGtl64VNwnjtwGqS/w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NExhRTFMVXh4SHNwM0xQckVscEc5bk8xa01vZVFyNmhlbTFUQjJRTHZzdDFs?=
 =?utf-8?B?cW0vVmoxZHFNS2xFTjMwQTh0VEtobUxTZThqYzFyanFlS1Fsa0tVWVd1bmVX?=
 =?utf-8?B?T2hmUk9zdlRiRnVYRS8reC9YYml4dHBhaXhTanhhWmFmRlhBbnl0MDJGd1c5?=
 =?utf-8?B?RWhKQS9oSFpPSDJNYzZJODlsSE5EZWQrWTh6MEZJQ3dLNjJnR0p0Uyt0eGNo?=
 =?utf-8?B?cEFyZnkzTjJLcUxSYm1pNjI3Q1N1L01nMHVrbE9UeHRKdE16NW44MHpjaEFR?=
 =?utf-8?B?bm10TEF0dGZPRkVkTUxXbVNCTGhsbGsxbktkZTROYUN4TUFscldXTzI0bm4x?=
 =?utf-8?B?cHE5Ny9xdk9BY1dOdTd3anhSUDVPU3hMcG5yN1Ird3ZPeXNleEpTVTh5b211?=
 =?utf-8?B?Y3hLOW9iRHM0ais4VW5WMG5TTkhDRWhOZHF0NG12ZTZWWG1JZlE4YXh4cCtj?=
 =?utf-8?B?Nkx4aWVyWGdWZUhMRDRibjI0anNoeXVYU1hXUlRna0hWbDRuM0FOTVd6TGx1?=
 =?utf-8?B?bnlEVGl3TUZwTCtRQnI3SHdUTThvVlpRczdjL2ZNUjd2bklrRGgyc0dkWUcz?=
 =?utf-8?B?QkRwQUltZFpPMnZ1dnM3Zk9rMUQvNEVOVENuS0JzRGdoUjBkZEFOcUNDcy9V?=
 =?utf-8?B?cFpwRm5JVEh3NVlUR1kydXZ4djNzR3Vzc3ZGZlRYNFlHYkRtandFelRBeEZW?=
 =?utf-8?B?OGRhK2U2RHU5K3hjKzVNYWhqa0VWLzFhUWQyb1dVeFliYVovNi9NQTh3OWR4?=
 =?utf-8?B?bExaTnBHWFduSGNlNU9KQ1BTWjgrdythOW5qYnNVYkxZMlMzbnBlVVE2MnlB?=
 =?utf-8?B?Z2tNQWpXNlZmUnVrMFlEVkg5Rjl4ejkzeWkvN09jd1k4TmhPd3VqeG1zOGJM?=
 =?utf-8?B?U2ZFdFA0TE5BYnBhVnZ2QlFmUUJUZWF1TEUwRFJFamtyTks4WW1LOXl1ckJU?=
 =?utf-8?B?Y0hocTJxSlpVbGpSMGdLc0xETUtMdkY5dVVGM1dnZ1hxWlZwc0NpRHdKb1hh?=
 =?utf-8?B?bW9yalZrMFk2Y0NIMkxRZmROVHhOUlZ1NmE1bXovOW5OSXdVZ2V0Y2ZKNTlQ?=
 =?utf-8?B?UHlPSkRXUGc0aVJsZkhpZWY3OG9kekV0S3IxZkhuL2dnWHFPNi9qblA1Vjl0?=
 =?utf-8?B?ckJmUld5M0JtSVNHZUg2VmVITUwvdVJFenU2Tk9WNFBDQTdoejlHNC9WUmtR?=
 =?utf-8?B?Tk9adHFhc3kxQkxXQ1NJVVhGQjM2Rk1lcW9yZmRRVXM1cFNNUzl5eEg1UXNn?=
 =?utf-8?B?U2xoL0NDR3VzUDlwUzg4NFZJU2hjYkFoRFRSZU4wZVlGdEF1V3N3WlBaUFl1?=
 =?utf-8?B?U3h4MWFlQjQ1bzFYd2MzZ0dBSWFjTHV1NFI1am4yNzZBT2c1OTNsMnA0V3lW?=
 =?utf-8?B?cnNyclI5anJNb1N0RXBWMW5Xc0F2V0FJNzdDTUVXRDhieExldmlDSmJ1TjdZ?=
 =?utf-8?B?M2xMUnFrcnQwYlhxNWxEVTBCR09lTjhZVmEvSEdBajJTMEhvR1orMkV4QTI2?=
 =?utf-8?B?a3p6U0tuZE9BNXdGbHZMVzN4UVpQTTliMzFCSGdFdTY4VXgwRXNwVkdqeDZN?=
 =?utf-8?B?UUVXdW5NUTlJU3hIQ3l1andiL3NSSGZka24zb0tUZnpKL2Z5d20zc1J5eXhj?=
 =?utf-8?B?R2xVa2plRzhFWU1UaVliRzZrMGxVbEx0a2J3VUw0ZW8vdGp6bXUvUnNFdE83?=
 =?utf-8?B?N2U3WXVvWG14OG5FaThRdG4yMUxKVkswSkpud0RRelkyU3VHSzViMHNiYXJs?=
 =?utf-8?B?eEdIa24wZjJ4UjlrTWFUL1NWLzZlK3FLSmZib3FVaER2NDZrQWM2UiszVEZ5?=
 =?utf-8?B?bkNmUFE1ZHB2OXc4TTFQeCtzUTFJSjJQL1E5Z0RnTUVQVG9CbzB4TFFWUmUz?=
 =?utf-8?B?THdSWDVNR0U0SHUrQTB1bGxNRGVLMEQ4cWRzV2p5Sy9DbU9yazVjT1pnS1Rr?=
 =?utf-8?B?VnNKUWxmWm45UkhrUnQxaWhIUUlwb3ZPQzZRYWhMZmovMHlYenhFMURLL09Q?=
 =?utf-8?B?UkhtanNqNXZsNy8wNzJPd3ZKMXFRSEZmV3RSbHJBajJxT1REdTJlYlM2TUg0?=
 =?utf-8?B?SklMZnI3V1dyQ055RGZmOUg1Mk1lTjVCVWZ2MnNvcnpMaVpBSlZTSDRRTlVH?=
 =?utf-8?Q?YwkqwAecKTz/r2p+o0XBx+2LP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2HRvbZ7cQB0mlMJrHrlgf4+kMS9uQHJ3QedV8IolAv+nTGTPS+3zCJ3gYNZaXBJBnH1nIND9DYlcYrSkmQlmZ+v3qpBfQONskl2Oxoy01ZkaW416clZ4dmE2WwcShUmm2lxSnLQTvZfak2uQs0wNJxEjXfr6ogb4SRpKgmCvQzrROW7p2YqgpzM183GGOgwgeZt4HaIyjxAdL5mWz0qy5amXvekfQVxPoB9eEflPrKHljfifzsW6bk4JUQSqKxHYGJXgbig5+pj5BhihHYWNckL0oUQMrhO/BMdvSJ8miJCadV96kTULuqCQjQWG1t5nk31DXPHS4qbUE6KIKgNLBagyt4CJf+YBu9/4TT6ggibu60jThI91bYPGVRvyASCfE6rpTLG692Asn9I1i3+YxNB4eRh21PW+fg6jEQUi9djvlZZ5SVWssA4CgIw2MqIDMe5JYanJoOgzqOxOWCsbv0k2jB0/6s4NMsefbge0KgBS/4gYg1hWWl0TI9m140RnMTl54c8kUV7QNC6Qv0iJHc/0VqACFGpka+z7MY2pI/IMB1lUarY2MEK57xOXEjLbw4cccv8Ww8+XPzQXyibZmDi09Yj5qD0YjoQT79OEUsg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d85551-725c-4476-d219-08dc3c23a165
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 08:18:11.0916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xXmgoglZ7FDrYo/HiCSA7XBgcW0UdAb1tgwpN/dQu45Gp3CgdjQ3jFUC5VvkmwyuBsQm8ovG9EyvUnmPbDxRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_04,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040062
X-Proofpoint-ORIG-GUID: SamitjNLYaODzSI2ADPunra0ymdBVLHH
X-Proofpoint-GUID: SamitjNLYaODzSI2ADPunra0ymdBVLHH

On 02/03/2024 20:16, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Signed-off-by: Igor Pylypiv<ipylypiv@google.com>

Apart from comment on v1 HW:
Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 6 ++++++
>   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 ++++++
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 ++++++
>   3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> index 3c555579f9a1..97864b56a71f 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> @@ -1734,6 +1734,11 @@ static struct attribute *host_v1_hw_attrs[] = {
>   
>   ATTRIBUTE_GROUPS(host_v1_hw);
>   
> +static const struct attribute_group *sdev_groups_v1_hw[] = {
> +	&sas_ata_sdev_attr_group,

IIRC, this driver never supported SATA

> +	NULL
> +};
> +
>   static const struct scsi_host_template sht_v1_hw = {
>   	.name			= DRV_NAME,
>   	.proc_name		= DRV_NAME,
> @@ -1758,6 +1763,7 @@ static const struct scsi_host_template sht_v1_hw = {
>   	.compat_ioctl		= sas_ioctl,
>   #endif
>   	.shost_groups		= host_v1_hw_groups,
> +	.sdev_groups		= sdev_groups_v1_hw,
>   	.host_reset             = hisi_sas_host_reset,
>   };


