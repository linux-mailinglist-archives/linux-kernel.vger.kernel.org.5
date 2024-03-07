Return-Path: <linux-kernel+bounces-95167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16958874A31
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394001C230FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21B682D8E;
	Thu,  7 Mar 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HOyp0kL7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M2/5ti/V"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1726282D75;
	Thu,  7 Mar 2024 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801815; cv=fail; b=WkoYnqQbxzaKlHs1zkuEIUgxDzLlat7jZVx3qLyJDcD0BpQubdVYurP+DnD/cq6uSFgmrLqZ5cIhRczOIS6JTwIFLo9dDn+UpP8kEh4d9d3n126CpSdMlylX62MK74+BnQtz6AA62R0CvQt+yVSvIYlJKZ7iulN/+AH36zzJnP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801815; c=relaxed/simple;
	bh=bXg1SpgiPzLTaYJmVzAtaPjUQn1tkqD2725VjBGMWZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lIF4hgN6Qh6IwRQiBefKcYXNhFbuskGVvGFr7Or2b36W3oNJmBzNQPp9jKRElZZ6WjrfnTKEa4Pve9sxngDiDrbusVs2NURWw4YMpGnltyaLZG7JZI4KJMLMKH7XPOIIczr3ObonlhRfddl0ISczaNVpefz/wtrdvxCmb701fc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HOyp0kL7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M2/5ti/V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4278aQBx003004;
	Thu, 7 Mar 2024 08:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=FTG/HMwrsamiSsVXS5Kn/8rIyMVmLlXjexwSwBdi+x0=;
 b=HOyp0kL7evI88f9qvPxmvnNPeX4BUOId1XKIIjBi4dbDE5OjuJ+jeDrkjTMvm1Wqzhol
 3o/exROUmRXNkgWIiWzowCSzj2pnFou5Mk/cKKt5i44h988C6hjvdT+5PNO02HET2GDK
 tJPwsP2OUgF4oIdpbSU+uk9P8n7uYbHA4mG33w4GwTmW+GoSP8DAB9uM/ZVTM9Jlj4pw
 8nLtM/TUNcdYrcHsnUkLlt9ZmYfEep5Zk212yXs8ER+bN1v9y2H5HYEO233fPI+Ay15J
 KOUTwg1V5tujvBc8gPxzkGVIjORBjfZzRuM2omG6hiaVk4YMKvKmDdRdX1I1WvZCHfkb GA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dkjkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 08:55:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42789CAs040916;
	Thu, 7 Mar 2024 08:55:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjgpu9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 08:55:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMA4j0aUKBuakp7Cp/HzcOhHNsREPA50+CCv0LW/qOUWXW9nn52Dudbhg//vqvpPNDqaFpg/APKYV7TPLVIrQa0u1H93OvwUG2s6pz/ISuO5IDZ6JOeyqJA/s7TiUbuUYHBhd9k2EWKJfgsAMZpzkXMPMRX87ahH/GcN7vc7LYRpuuRv8xPZXq6pB2UI8ZSJlZ6Suc7hPC+mVr5vyRqFFirx3tuVXj5eEcix983OhyMNg+WSxGcJ8LkgCZM9+7hWdAerHjrENQpiH2nm/0t/RwTxpOf7rypuM/nHSingzWjtT/22ZpD3gfMx+0IGU+ruwGoVzfoVFPuow867jKPtrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTG/HMwrsamiSsVXS5Kn/8rIyMVmLlXjexwSwBdi+x0=;
 b=WojANWwZGMh5CeTSvi4M+SBZJYx4Zc6K5fFboBCC+h7TtOSKKnUqkPZ2kcNlwSzLOOMyZAwVLBRhc08aLrzEpgDW1hBvbyCe0JlOoNLpcWKkMQ6ZeyUACO9hCdhJB3o/Arr0xI79roAGzfhw5q1hsCZaopTfRhXtB5rnp6UUYsJgVYBwfzhq1TQzOHt4lI4cFkynWWq3jC6TKDQ2KBIAvcTBk7llb+7wH+QaoQlPxseeRua7kp+lqYBlIPMdRoJwxGPPPdSPResr3cPea9RDm+Cf7/qym4NJS94Zxi4wV95fZTz8Zo++6frpDz1f3nuuytrr7p7zdrsWTpj6IGd39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTG/HMwrsamiSsVXS5Kn/8rIyMVmLlXjexwSwBdi+x0=;
 b=M2/5ti/VCcWpYMQZqfxxVndlUHNErWHY2SkukVHbzmcUxqTnGeDP3ya/PAJxh+C2g37L+N48Vm1Cl3U0EXUgVzPeKvvduncnZkgjE5914Ta7Kga0SsqCdrnTzC30Q1mYw3PbA3/ycP72lkNIsf0LUfeiBxgtAzkyvTj7a4FJ/kk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB5961.namprd10.prod.outlook.com (2603:10b6:930:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 08:55:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 08:55:55 +0000
Message-ID: <c3ebaa55-d05b-4f11-83a8-2a0fb85044cf@oracle.com>
Date: Thu, 7 Mar 2024 08:55:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] scsi: hisi_sas: Add libsas SATA sysfs attributes
 group
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jason Yan <yanaijie@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Bart Van Assche <bvanassche@acm.org>, TJ Adams <tadamsjr@google.com>,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-6-ipylypiv@google.com> <ZehLpV06mpHxjecc@ryzen>
 <ZejYb4ykeF7Qx5a5@google.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZejYb4ykeF7Qx5a5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0331.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5adb47-cca2-4cf3-ca2f-08dc3e84666d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qDIDnBT18X2aEJbyXE3kVaFM1OkJUCsfWGJisfHWcl3Dhg+Bh6xloPq8XMySgxmOo1Og/lNG5+CvR2h/JccYOZht2/oqAA8ACt0EtNcJDFSJhu6WrR5C/NNOx7T6FwhEvXFE8begWU563F9GwOQikogLp+FrUTFZqtWgLLNqLFvkEQGVht4o7Pc8g5Gt23HvDmTjI8wKHGepq4rLLmhyo3xlbZAZOQ3QBmn/d0mPM3Im8p8dW//23dSARmQuy604TFL8z4ZkTZOTAsvuwYcTS2CUBuEVuzpYmSRTUY3jJGNYCo8lY/FnHDBEUdhvhZCZ6iiX/WjS0zn8t5svhG5TfGEeF5CMNWbTEUyHo9Y7OjsuCU0q1LqgDX+bRSGlV2gToz35nGHm3mKpxew8GttO2OSPA9uRRlWENOTFlzVv/OieXUlX2fEXJJrBn1e/ePgFKCocIivP4d2aBkWWny+rfWUfI58Fh6GzB00OdirpnXP4cXwvBzo9rb1Tnt5s0PfaBKUieUmUa8kp+INlkiDXZgQ2xFnbaKbyV4Lo+KGQuD0GOK3I+FO0KtVBzFOaw6sWTilQmkT/tCN2S+pSmklJv/j/eTieMbQ7pD+wmkjfJ+/AyLIyvhCFjbb5pLYZ0WFOeW8sQw5zwJ4lKqvKY1c+ez4mPy1zl+AHweJ+8zo0EE4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SlpLdGE0Y2FTZ1BYWXdFbDIwWkZ0Z1hUZjdKWTNyb2xGZGdpRnYzdlVoMVor?=
 =?utf-8?B?R2N6Q2RsN0o0bXpOQ09rdGRubGRlb0FhcTlPWjJDS1I3K2JLUk8rWVlDWHpt?=
 =?utf-8?B?TlIzUWkyeVJXWVpxMlBzc0VoQksxU1MybVN2ZXZ4SFU5Z0lCWUl0OTFUbzVj?=
 =?utf-8?B?bUZtd3F1TThaakt5TXdrcDZER1phWVFIU0JuUDJTVVRYL2Uwd25UdFQ2YklT?=
 =?utf-8?B?c2xtZUJsU2paU1BWWEgvQWxrOFZuRlIyS2x1cFVJdEtwbnZ2NEJzM1hwdEFN?=
 =?utf-8?B?VjZ5VytySXFtaHBrNG4vMWVNcDBkTXVSTXI1dm8ybE1vZjJsRlNzeWdzemw4?=
 =?utf-8?B?QlVmaXVSUGVqS2xtR2VpZVVUcFc5VitLL1NzYU1hOGhEZHBsRlJYRjFTam45?=
 =?utf-8?B?N0hKOVZKVDRnK1JYYTE2Q2tDdTh6ZGZHaDdFYkcrWVEzSTRhd0NJaEpybk1u?=
 =?utf-8?B?MlJKOVcxSmVORUJiY25sN212VFZpRkgycEM5Z2ZNbkdUVHMyZjJmRm1qUW5J?=
 =?utf-8?B?RGdacWFZRS9YNU9RMUUzOHJGQ1lhWnd6Wk56UFhQM0lkOWZYc3NQU3F6Yzhi?=
 =?utf-8?B?RDBqenBlU0ZhNjNYVzg0Z0g3RjgyOFJINGk1aWkxeEd1bHlIcEs3SHR4NTFy?=
 =?utf-8?B?emFkUEVLYnh6UENlZllBVk1ITEhHanU5VXhIY3UwVkZ0STJMd3B5ZWNOcklr?=
 =?utf-8?B?TUIwRnVRN2RqTFNDbTZ2V01qVmVIbUZsQ1hmVWRyY2tTVFB5MmFCZ2lQNHM2?=
 =?utf-8?B?QkpHcHBOUno3N0srbktnZE1SeFdlZGdxLzZBUkt1c08zUDBmZnlwS2FLZTA0?=
 =?utf-8?B?TlhzMUovSk1pWU9pdEo1N0Z1ZFRQWDN4azVMaW96TWQ3bXVmbEl0cnVDWTBN?=
 =?utf-8?B?T1RHTUtTeCtyT3c3aU9DRzduUmlFN1lTZmt0N0pQQjVtTnRqRmhYMCs0NXJ5?=
 =?utf-8?B?Z3krSkV0V0hTdFRwRGlnUURlc0w1Nmd6RU1KTWREa2l3WDdaWjhMdGZMcXBW?=
 =?utf-8?B?cDVFMHlBQjNzZXNpbytObnBNMUZPQnVwMm8yQkUyU0Z6OVlyUjdpaXBwRFFI?=
 =?utf-8?B?cVJ4dDU5TCs4TURHWlpMSzdWUUVocmQrVGlwbmRTb25ySDNDalNtdEIvSC96?=
 =?utf-8?B?MkZtNHBsT3h3ZlpYQUZyVWVLcTgzdDcyeEJyN1VKT0lNZXBMa1F2eEF3cFVr?=
 =?utf-8?B?Uzk5WmdlbTdZQUtZQ3gzUmo1YTRIUzduSURseElmSHFVMnRRVUx4cjJ5ZDZP?=
 =?utf-8?B?R3VCTXYwd2Z3N3RoZmppd1dTQUtVZHRNSXR4bldZUDUybWZmSitYM3Q4TVlx?=
 =?utf-8?B?SzZCczdBeCt5N0NLUzQ3eldrKzkrK3JSNTZnZ3FvclJrUHE2NjdURllNWWxj?=
 =?utf-8?B?ektRM29CcmxDVE5tVG55WXJ4aG1FL1d5TWJmZy9iZXRyZlRiU2VLL1doN1Fv?=
 =?utf-8?B?Rm1KM2ZBd1k2ZC9QbWJDcmlwUHNFVktWWVlMQU51bUt2WUV6OVlMMGhLUXZv?=
 =?utf-8?B?MDI3dDJoQ3NsQmNxYzdWdklWVUxJaVVBeCtWSnZrODA0b1Q2VythMitOQ0Fk?=
 =?utf-8?B?S2VSRTIzbE1FR2w5d0NIVmdvbVd5K3l0YzgwTHA5TDNBVjZ5YjlabGxuMG9o?=
 =?utf-8?B?dWZMRlZkMmUycjljSFhNS2ZON1l5N09zT2dpeGVmVzdkWkdPTzM3cnFpdFNQ?=
 =?utf-8?B?Q3JEM2VCL2JVZ1JVczhxRXZSWTN6K2NGMVhzaGpScDgycDBVR0V0UUI5WnNN?=
 =?utf-8?B?YlIrQ0cxNGlXYmtlQysvUGIyeENxdUlyb2R3MTNKdDBhb0VrVzdHVG1lMzZk?=
 =?utf-8?B?OEV0RHNIbW13SmFZZkRRWVVNb2hkaDFCZmlrUlpSdUphMktnMFkvVTEvTmg1?=
 =?utf-8?B?WWFwOGRST1FpQjUzQTZNdVZMV2R3bGVKM3RsZFM3U0lmOTRjS21sYkhDakxR?=
 =?utf-8?B?VnJNZ0lzdnVwYVFJVFBmN2dmVngzOHdYUWRBeDJ5V3ZMMDlrUUIxWlJjSEVQ?=
 =?utf-8?B?b3FEdkZmdHRCS0Y0VHVVeW9naWFpVHE1UWhvSTdqeCtBQTlUNE9kWUw1eUxn?=
 =?utf-8?B?c09Ga2xab3grOWc3YUFwV0p4OWp2Wk5meUd2eFR2akkwYlRZMlJueGY4dmRZ?=
 =?utf-8?Q?86es4tEtBCweZvcinalLWqzld?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	75jmFI1cP0lSHS0SSMsgFI4iSkgf0vXhun8Xg6WShWiIeOCgzluAj++SERUBDlZapTy4PFjGsrbAIY6sV0rXo9HURS+f830b5J4IKujfkRGEG9ziA9RXOInpWApl/D3iHLcMI6gYtdf2aTPPnx2EnI/JdtSh6AiyKC1/VgcE88MxxTgGrIbj+wO236l4SFW5+miNac/zvCuGqhJ1d2QL+x4xbWSnQPeLDeD9tE168jH+8ZPgViJXuwkzsTYxATTfO72k585W1JEiavtwDAEjt0mbcjsqH538Ejl+zlu5HLw6CS9866vU7DvZDnG0k/QmBcdmGeRXhYizyBollZQADrPRmmlBeX/93qES01KFWw/9uWuZiRFQIWzcQvB64oOaqcJzX2RKoQ6Y73r4TcMLsNxl0mqnPrg/p0CsIh9DAr76FZ0yth24QTmJ3N/cQN9IavoV/HTYJYcXgbXamNH0oSaEbReE8XpI1MP22CzwJglR3J5XeMMydtocIWSxpNiiTRcSc56wznMhPas+rElmtrGv2ATGOmp4DmoFdrCjEpoEr78aqxJFXT5oDfUik8+vUX17qTVUIxO0m1OtRE/B86CZ0AKBUb+bQ9XJLUUif8I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5adb47-cca2-4cf3-ca2f-08dc3e84666d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 08:55:55.6896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXUSAWexd6F5nIaIo14QcxRMJJQFbByTtmtBRi418ApqBNRufrBowDgwwdBWHDaAQ8Brw5H3pTaegcZcOsvg9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_05,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070064
X-Proofpoint-GUID: C_mSmkwrNUqkNEjgx_QRlFFTHnYlEUKX
X-Proofpoint-ORIG-GUID: C_mSmkwrNUqkNEjgx_QRlFFTHnYlEUKX

On 06/03/2024 20:56, Igor Pylypiv wrote:
>>> ---
>>>   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 ++++++
>>>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 ++++++
>> Is there a reason why you didn't patch:
>> drivers/scsi/hisi_sas/hisi_sas_v1_hw.c ?
>>
> I originally patched hisi_sas_v1_hw.c as well. John Garry pointed out
> that v1 HW doesn't support SATA so I dropped the change.

If you are going to do another spin, then maybe update the commit 
message with this.

Thanks,
John

