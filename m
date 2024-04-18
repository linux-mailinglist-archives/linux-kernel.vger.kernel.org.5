Return-Path: <linux-kernel+bounces-150495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A568AA022
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A8C1F22F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E5616F85E;
	Thu, 18 Apr 2024 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oZYZuw+U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fJHH/VQ3"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E811494B2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457990; cv=fail; b=pglxBqvugpgaKIM5OEBrGlt5HtU5ds7oFpY7S+Vv8RW9/snw15Czc7sT2yV+SYy221agH1ncsfCNsMMDhWRZsBWd7/cKeIjPUqEqbOePVcizL7MD7k2PLGkY/3h1S5IbQ6vJFlTLjBOXfjwyjguVEMZQAU2HcLRx4qF4bXvjV+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457990; c=relaxed/simple;
	bh=NnRFQdkVzuw2OVt/Yii0aHBuknZ/TilgGms1c07Q2yM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vCxupVKml11MuHcm2QcvE7uwtF8TGxV4JUe9uc7IrX8OMChaBzKAfR9gPvXcqJLybpq0XnmBjHVGLGa/TYGsYt6HcWT5vrQuz9ttKf4g7hKN4mVRFVtlYEjcofGRyFwfuPPGaLQRfeguyHiU1FGDn7uPuDfYt3/Cc1lnQ0sDj/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oZYZuw+U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fJHH/VQ3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43IGOWm0004814;
	Thu, 18 Apr 2024 16:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=0Fi/AfeFX1iycJr9gF8HeeQNrUq+sE4mS75v15MozHE=;
 b=oZYZuw+UTiHszeRygopgNNMkmqnnBxfFkcx1uhTlOE/CflbgLvZU6/K58CWS3yOp6khp
 bt2QbCGcSz/VM/i91v23bWfMB7yyeJlL+wwsVQxhnpPkpvE4utogt7oafoYTcE1IeORq
 nG8EAPlFLbYrPBtIgPs4XUJERo3DIrrwxv2dulhrInbuJHb165P3vcQn8+JkASGYdxOu
 6L6bMyWFe0SCRDtlGlT4rQ8RjJ9HwEJrrkc1fyxiuSKT27fk9x/kGQkprWdGx3gAMrLj
 3RqK7LYQ7l6aIzzMel2GyCQeGI6IK24GjxkRLF5kC7FXIYUwQ6Kz1nXTX0FTBp5nqqoi Dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkvayx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 16:32:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43IGSlbt021678;
	Thu, 18 Apr 2024 16:32:19 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgggymdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 16:32:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/pfyKCc21eLMmh7LiV5OShKikds5TGWWQ/XyBGD+dHu/uINYf9pVaRzGrqVkbat2EJbdm3RBuzkLVvYkvTDFGkRlNWGcFIbqXBYtm/22tdqydic+4Ymy20ce1+U4LsJF5x2ZtLjijFvkHz68sDRKXDkWnFDCrL2KE4cL57I1ubYt4nj8PMYQjZWQqkkVJeaRo0RZVbYXGWSxckgWDKFsm846WyrfOvAxZphsU0B+UbJ8akY8tQxSboyXg/eConze0EfnpEKpyeneOFHJemut8F2cZwyQf384y37T4WSlSot1hEAvXy6yrA0AA8QQH/GLAHCPCxvf9Qy+6zdu9b1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Fi/AfeFX1iycJr9gF8HeeQNrUq+sE4mS75v15MozHE=;
 b=IWVTO77kWoEojA0Y5Nqug55f3v5pizficM1TS1P30CApnd3Z90pfJta8LEXYLnoNqlap74pIblw4EWF5AOBIKNg9DpyVvoiJw56PW01pYDYRLjjnhbWnxE5K2Zaq3lhIWZ6tDe6tF5ulyL8RjTreq/wSV3/NK1FsZzpnqGj/iSdePtr5egsaqEcySj+h/UVwkhSyE22umsIJSZPrpMrRPg+zreXSSfqP5xj5Rgg88mVWO8orUSCNIa7A9WAXZBjFum1jacYx2hQDvu33Y+CL2Ll538Gh5y63OHHwmsr3Q0yYHhqEQ1lvCV1iuHYJSmEL0VYE97zeHzWZvd0yas7L/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Fi/AfeFX1iycJr9gF8HeeQNrUq+sE4mS75v15MozHE=;
 b=fJHH/VQ3BiqhGI2QVNEXjY/Bwvw6mZoHXyShSMZ1DQgMSSVfNcQUFKFnv+GLedzHOvq0U0YOp3EDyhobNUu0I2Q9Ge9cAb5xyiN5YqgQYdxHD3AVxzuax6Aag1jLyRPC7WYHhdPlXWeLKTvQQ0WkRqDqsdFk3IFcXU96eGAXuio=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by MW4PR10MB5751.namprd10.prod.outlook.com (2603:10b6:303:18f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.52; Thu, 18 Apr
 2024 16:32:16 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::894:70b7:573e:da46]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::894:70b7:573e:da46%5]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 16:32:16 +0000
Message-ID: <109dada9-3164-9a04-5b7e-1031ff399017@oracle.com>
Date: Thu, 18 Apr 2024 09:32:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] perf: arm_pmu: Only show online CPUs in device's
 "cpus" attribute
To: Yicong Yang <yangyicong@huawei.com>, Will Deacon <will@kernel.org>
Cc: yangyicong@hisilicon.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
        linuxarm@huawei.com
References: <20240410095833.63934-1-yangyicong@huawei.com>
 <20240410153419.GA25171@willie-the-truck>
 <d7c4da97-92ba-4cb7-ecd5-5edc4f52fd8a@huawei.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <d7c4da97-92ba-4cb7-ecd5-5edc4f52fd8a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0067.namprd07.prod.outlook.com
 (2603:10b6:a03:60::44) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|MW4PR10MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 037a708f-0c8d-4c03-f1b8-08dc5fc51c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	I0ACq050akSAY020EpqbCLMAq1Lw7fYbmasj8XVYt70mqlywy/LsBcb18N4Rj3CbOGxH6b4/nsCG24rzSNoSYtNeuFThP8bLcbthB8CHYcPX+PfYW02kGM/B1yAqEb9PUTwtW/7KS6jrFgGewAHg63spmVfGzrWH42bgB+Qb4+zANpWWXiIG+bmOowtvsWYgSXGeHH1gZHJTHroSpqaalbpXk94m/R1js11MTuydt8FreV5zdJndGm+pOSteLWZZ2WzkbjCIU2uvBpaNJTVTO4g+o9RE8cp3OThkg5NrRAzuV1nHlyyUz8C9Jk9wXP0yRJCiqshxOedIWFhcA7rwxkgIgonggrd8bHJSLaHh2UNrFLMoptBsHGm21Ri0HKZqPrepqBKEk2yVrt+yHuR6GV8by4WM8P/rHzG8MhvfUXfIJOMXPSt6yLDL/r3fFNI9X0lY9A8o803MU4/lRuRwCee//xqW9atOPkp5nKbCBPessj75y5/r0V5srbWr+YFDeBFLELbq7lOtszE4Mlgh56BPZXR84wLldIxOpkWryRhKlo+Nk5SS7WGYDa6x6UfZRHstgVoOsKZ1DWvLhWY0lr0GJSQ8gl29qL2ycbxkwcnskzZ0uX6xp8bD//Z9tbg0
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR10MB6425.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ODZ3NWM1czZ0OExWdk1TRG8zWllMNE9yR3QraEZna2UyRG5jb0JFb0RoNFpK?=
 =?utf-8?B?SzBZMGkrOVA3ZjR5RW9ReFR2NVh3aFNBYTdLYVJjWHV0Z2dEc1U0aVQ5M1dW?=
 =?utf-8?B?STZlWndzbXlJZWFYSk9MKzZxY3pRR3JDT1QwQ3R6MG13VUlNdzFwaTJQYnQv?=
 =?utf-8?B?QTdTU3Z2ZEg4SVI4Y3FoS3F6RnBWWnZlaUw0bEVOL25hZlRxeklRNWpsTCt6?=
 =?utf-8?B?RmpSd2lTYzFvd20waTJRU0RBbDY3aTl6STEwb2h4SGJRM2t4VGsvb3grWmRO?=
 =?utf-8?B?VkpyZ05LbUIySFNXUHhyVDFabU44Y1V0dU9kcERoV2UrbDVMVkQ5blVib2R3?=
 =?utf-8?B?d1NDbXBsejFaZ2l1V2ZEamRjTDFTOXBYSkUwUlFtUUZiWW9MVm5ySnFHL3BL?=
 =?utf-8?B?bnEzQnRWNTZxYW5heTBxclhoYU12SjlyZ3l3ZnVaVVR5cTNsb1RraGVJRFpC?=
 =?utf-8?B?MzVDekwvUzZGZEdlVmpEcXprTys5M3k1dEFMaEplMEIrcGFEVFh1Nm1JZlpC?=
 =?utf-8?B?UHFpMFJ3NHZFY0NzeXBQYjdNazhRNTdFRFlETXJ3Qy9qdHQxY2JlaVYraXBp?=
 =?utf-8?B?OGNNVzA2RE5Md3VZMlhMcGNScVdYbWZnTzR5TGZMdmFyM1BZS1FPSE1zYi8y?=
 =?utf-8?B?eGNLZUZPTWhsZkxiVXJVUkdXd2M5Z25OU0RLdGo4dzRYM2F3UDFrV1g1a0RQ?=
 =?utf-8?B?anV3SzVlT3BhZFo3Skh4NU9CbW5SS3g5NkZ0UGVKY2I2blNjMWw4c2g1QnQ2?=
 =?utf-8?B?NzdmTVVaZmxCbkJlVnoxTEYxaU9FNEdjSEY5N1NmaUk5ZVBQNWNoejU4TGNq?=
 =?utf-8?B?VjZjaFJSRWRBYmo4cmNKSmFHdWE1di9MV2FRVk9nRUtXYWdHbE1OcFVjV2pS?=
 =?utf-8?B?d0RmWGNic3dPTGRHdDVVcCt5WXBkL2hrbklxODBIQzA4cWM4TXhhczg4ZVJC?=
 =?utf-8?B?dHo3OUI0SE5pMjRaUVZ1eXIyR1lRVmtaVnN5K1AwMzBqeFVmSzFWOEQ3NlRU?=
 =?utf-8?B?bE9WNDNpVjNPc3BRa01taWNDUkVpZWNra3ZJZmFURUZjVkVIaG5ZOG9YRWZL?=
 =?utf-8?B?YWdUdUd1Wm50eHNaTnYrb2RTWUQxc2l5WXBucitLbElYNHB4eE9XYTFDOUg0?=
 =?utf-8?B?NTJHV3dtU0VqNnZLNzk5TWtiSzUwcWFnZkNxaUZzajV2ampSdnFva090WHBs?=
 =?utf-8?B?RzYyUjZBRjRoUjhKaWc5eTZGMEZwYXMwd3Vmc3JkcTVNTlFMclZhNDlPaVM0?=
 =?utf-8?B?bitINEQ0MHZEV3Z0bHYvOE53OVV0T20vTTFJaTRVQ2lldndTSHBIcUpnVmJW?=
 =?utf-8?B?VlcyeE9FZkhBdVdUa1NLMVJqdDJBRUNVeWNVVTk4QWJTaVNOekY1NEhaN0Rl?=
 =?utf-8?B?TXFtWmk4RXdSeXh2NFNWSkxyUzV3aSt4Q0lDMDVia1FQaXJZd1hhTVRGblBn?=
 =?utf-8?B?V0VHWFRjNHU1d2RsQnNaSTRvZzJwQnFaMkV4Y3RRWnBWbVpZY0dSdndXRFV2?=
 =?utf-8?B?aytGNmZhaWgwN2FvejhSL2dXekgwUlF4SGdad3BnY2NqNFkrMnRtV204THJZ?=
 =?utf-8?B?YVRvbXdvQjNkY2dPazdQU1N3c0FKYVN2YmdiWE1VdmZlWUdSRmNjT2E1cGZL?=
 =?utf-8?B?c1laWVVHNDFXaVpzenAwemcwcW5DSVdMTEUzRWZoUDRtemN5L1JtaHZ5N3Mr?=
 =?utf-8?B?SHFGR3hJR1QrcHJ0Vk8wWGZnTE8rMUFjb2FheXR4c0Z3M20yQ0xQMTByemtj?=
 =?utf-8?B?dkRSNTNkdjNiV2RscnRCWXB1eWc3UUtHWUlpRnhlb3E4c1QxRXFxei9TbHpV?=
 =?utf-8?B?dlJBeWVwWDBGK0dSYjJ4Q1psT0U1SnFRQVVraHVGSDFRbk16UmZ6NGE3MjVS?=
 =?utf-8?B?dHlFWUNEZ0g1YzVpNTRIbnE4YkhXNjVjUEYwNmMzQUlZL0t2a0o0NVU1YnQy?=
 =?utf-8?B?cWdLaTUyNi9INytYekR4Q0hGWVRNVnhaME9GZUNhWUJaZTJ6V3NXdmRrUy8x?=
 =?utf-8?B?c1d6aVRJdUcwdVdzakhDeHphazhtcWtXWWVJZmh1dGZxTzV4eXdXbDBpWkRa?=
 =?utf-8?B?VDRWMDJjYjltalMwb05qM3JkZXkrbDZ0UUVMaVFtUldKUEMyclN5QWRVQzVL?=
 =?utf-8?Q?746lO7KwqG5/2+VCBXY9hI9Ea?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	T7s+0sOG2yx9I4kD3/D2ecOpXvuXmbf6QqF047vRXIhwyL2W7YZdZrkHEubIy4QRYaC1KtHqKbTDVvaJP7T8RFXT8/z6Nn/gtuaMqxvt9EmN8RCpdjJ1olJ9ozzsnFcn4A9nsl4U/8bbzawJRb6ZoGOb3EO3UjQS3khvrY7nwggDitdKmUBGABrdMh/95Y7QI7Vr9DiT6At/qmYBEC/IXokBjAapRkYTgs27sNJin2IBHieNCeS8f8+101BKaUtUuzLQqs327SUJ9gIsbnxPPqRvdqhlPY6vmfKD/xLQ/Y9TtF3h4HKpWRNssKQOsTLKF7zzvDdGRl7T+dIM2auTQtvUrq03KoyJBM0lKXWQWSiZl6DXjnGSJ+3puoczVVaKiDThGQWp5LrrhFyzFklDpBoHuHD02cFUm9lX2O6BdpLZrIefZClx46uA7EKttC7FkroWbC5Pr6aUlLRMdVh7t3uI2Kjdofg6HQeR9qz9i/aI2SjndCSkjlvgVzSmpfg2tpyuv6jZfrlriQxH9KA5s4+cVw0ZelrfcKmnaBzesWwkwVJ1IrVumqq+RViCLuJ31F8xQg9TUWvWvewANg1IlpbCD5dyadLuOCHUfg6teeM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037a708f-0c8d-4c03-f1b8-08dc5fc51c29
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:32:16.7577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRlfOk24sq0HTEdXErpuNHkHhsyTQy89jTPObjQJK7dW34DkfxX0BG9btJvsYU6sNApXrD6dR8XeyK9RDn3auw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_14,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404180117
X-Proofpoint-ORIG-GUID: OfrrkrfeaTiFk7cWcJIKU_CbiUgFb0iH
X-Proofpoint-GUID: OfrrkrfeaTiFk7cWcJIKU_CbiUgFb0iH



On 4/11/24 01:55, Yicong Yang wrote:
> On 2024/4/10 23:34, Will Deacon wrote:
>> On Wed, Apr 10, 2024 at 05:58:32PM +0800, Yicong Yang wrote:
>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>
>>> When there're CPUs offline after system booting, perf will failed:
>>> [root@localhost ~]# /home/yang/perf stat -a -e armv8_pmuv3_0/cycles/
>>> Error:
>>> The sys_perf_event_open() syscall returned with 19 (No such device) for event (cpu-clock).
>>> /bin/dmesg | grep -i perf may provide additional information.
>>>
>>> This is due to PMU's "cpus" is not updated and still contains offline
>>> CPUs and perf will try to open perf event on the offlined CPUs.
>>>
>>> Make "cpus" attribute only shows online CPUs and introduced a new
>>> "supported_cpus" where users can get the range of the CPUs this
>>> PMU supported monitoring.
>>>
>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>> ---
>>>  drivers/perf/arm_pmu.c | 24 +++++++++++++++++++++++-
>>>  1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> Hmm. Is the complexity in the driver really worth it here? CPUs can be
>> onlined and offlined after the perf_event_open() syscall has been
>> executed, 
> 
> Yes. So we have cpuhp callbacks to handle the cpu online/offline
> and migrate the perf context.
> 
>> so this feels like something userspace should be aware of and
>> handle on a best-effort basis anyway.
>>
> 
> Looks like it's a convention for a PMU device to provide a "cpus" attribute (for core
> PMUs) or "cpumask" attribute (for uncore PMUs) to indicates the CPUs on which the
> events can be opened. If no such attributes provided, all online CPUs indicated. Perf
> will check this and if user doesn't specify a certian range of CPUs the events will
> be opened on all the CPUs PMU indicated.
> 
>> Does x86 get away with this because CPU0 is never offlined?
>>
> 
> Checked on my x86 server there's no "cpus" or "cpumask" provided so perf will try
> to open the events on all the online CPUs if no CPU range specified. But for their
> hybrid platform there do have a "cpus" attribute[1] and it'll be updated when CPU
> offline[2].
> 
> The arm-cspmu also provides a "cpumask" to indicate supported online CPUs and an
> "associated_cpus" to indicated the CPUs related to the PMU.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/core.c?h=v6.9-rc1#n5931
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/core.c?h=v6.9-rc1#n4949
> 
> Thanks.
> 
> 


The arm_dsu has the concepts of 'cpumask' as well. It also has 'associated_cpus'.

When the current cpumask offline, the cpuhp handler will migrate the cpumask to
other associated_cpus.

# cat /sys/devices/arm_dsu_26/associated_cpus
4-5
[root@lse-aarch64-bm-ol8 opc]# cat /sys/devices/arm_dsu_26/cpumask
4

812 static int dsu_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
813 {
814         struct dsu_pmu *dsu_pmu = hlist_entry_safe(node, struct dsu_pmu,
815                                                    cpuhp_node);
816
817         if (!cpumask_test_cpu(cpu, &dsu_pmu->associated_cpus))
818                 return 0;
819
820         /* If the PMU is already managed, there is nothing to do */
821         if (!cpumask_empty(&dsu_pmu->active_cpu))
822                 return 0;
823
824         dsu_pmu_init_pmu(dsu_pmu);
825         dsu_pmu_set_active_cpu(cpu, dsu_pmu);
826
827         return 0;
828 }
829
830 static int dsu_pmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
831 {
832         int dst;
833         struct dsu_pmu *dsu_pmu = hlist_entry_safe(node, struct dsu_pmu,
834                                                    cpuhp_node);
835
836         if (!cpumask_test_and_clear_cpu(cpu, &dsu_pmu->active_cpu))
837                 return 0;
838
839         dst = dsu_pmu_get_online_cpu_any_but(dsu_pmu, cpu);
840         /* If there are no active CPUs in the DSU, leave IRQ disabled */
841         if (dst >= nr_cpu_ids)
842                 return 0;
843
844         perf_pmu_migrate_context(&dsu_pmu->pmu, cpu, dst);
845         dsu_pmu_set_active_cpu(dst, dsu_pmu);
846
847         return 0;
848 }


However, I think the userspace perf tool looks more friendly (just return <not
supported>) in this case when I offline all CPUs from cpumask of a DSU. Perhaps
because it is NULL now.

# perf stat -e arm_dsu_26/l3d_cache_wb/
^C
 Performance counter stats for 'system wide':

   <not supported>      arm_dsu_26/l3d_cache_wb/

       0.553294766 seconds time elapsed


# cat /sys/devices/arm_dsu_26/associated_cpus
4-5
# cat /sys/devices/arm_dsu_26/cpumask
4
# echo 0 > /sys/devices/system/cpu/cpu4/online
# cat /sys/devices/arm_dsu_26/cpumask
5
# echo 0 > /sys/devices/system/cpu/cpu5/online
# cat /sys/devices/arm_dsu_26/cpumask

#

Dongli Zhang

