Return-Path: <linux-kernel+bounces-98173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECD3877609
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2577E1C20D4C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 10:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9EC1EB44;
	Sun, 10 Mar 2024 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FHTufgvX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u3n55P3l"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1F41DDD6;
	Sun, 10 Mar 2024 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710065004; cv=fail; b=pgBKHvT8XhlgwdrkcCnbBhFlTRwTyTwg8TCSqsps1yd76cZfWZh0cKUZVovVcHzIQdazcYprJq/sQfqT804NQhxJIffGjxF4760DmkrypBLAdCSgdOXOAjOEVUhUs5l4cg3hqylcn86sxdWfDSfZijHmHAOu9syuqz9HCKstpiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710065004; c=relaxed/simple;
	bh=t3Yd8HsiP1jhE4Hejuc1Uo+al025SBzhuGc6c0Ke4Vc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C7RRDd7x5AoQIVqkcmr7FShNw5H3QArE049x7FWhG6OCxAacuTRYXKk1rZintzEfjoDdIHamd7WJxu5185n05bPWRhnpGamWp15aqhv1/yn97gc0gbp+u1QGF3egEz9RSbCh7Daa8dgQkMaEqftxb5V2p9lHJlxJJuFcHJU3fl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FHTufgvX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u3n55P3l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42A6TU1r019911;
	Sun, 10 Mar 2024 10:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ORtweBowOnut5XR4xZPVd9JQaQJRY8M8FKYCXZlZtM0=;
 b=FHTufgvXNfcpk8HPnr44OBn6XDomd3Cu5KSsRKAyZL3uGwY9sEOFhITn2HlSjZqzGJ0Y
 QBqnphMLppY6py6VLl5vFKeRllhlowSkTUsfAs4ZOuEOH7b9JT8PkbHdjJzmhR1fzX/T
 KS0ZfmJQzCQ5pNtvm95gEWtCMFuvbaajDFYt269CNOlLFVtdqOvkGvEHjC/vnimT3uwy
 Iet8Tm01uihB6B1vWV44bvKMtsYSQ+SQU1kgvEqGTHYOu9TYtJmFKRECl+BixxvD9OAR
 NcOryC+cfXf12UkFTFk17hZ2iszv/EhJjpjgAgCubObu41qu4kPnklnk7kd2EORGNkKp og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftd9bk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 10:02:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42A6Odta004805;
	Sun, 10 Mar 2024 10:02:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre74nghe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 10:02:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MscI+KzhfAnCpTelfPZCPk76fzO/PcukhSqyez1bBNlzFXvMIhSy3o8awagWPtNPyvNsPVZloW//JfZQcVlQZAZzuOpc2qZGo5a2K/HDjk1qPO8kZG74AVKKRaZb9/cvcFP5l8ifR0NMGrfNRwWSdQVL+4YmPc/nwOD5CR3nc/09NfPfmGGyOZtLIzk6K1+gS4cYnaPsVgxvT7FsG+2+0gEfeLe6uaaXPPl97st2U9isJOIsAJPXV2GWcBgrMnskV9KY5MhCbPYoyyCsFF6V2XwZIsbuS7lsyKoQDou6zp8w1+SH7WeVqhtzwH4Mrg1dIggf2/yBQOBMv/yElcj8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORtweBowOnut5XR4xZPVd9JQaQJRY8M8FKYCXZlZtM0=;
 b=HPz2XEVW1AKeY+J5ZaOCtLAixVmEqbySwBH36wp8WYPvJapkwSC5QqdjJS/we+88q5PKTI8nsDQoZlpZlTMK9FNuUnyXQiv5Ny+jlLkmRb1T/CtrOLsudZU8VgWlgOimyz2ZWX9/lEOGCPP+JbQNyDcJ7EvwZUQbXx+xOR/b+ddtAmdX8d/PonsiN0XX3QGP55KcImW3alWgUOq8N65UbQ1r/4MYjgvWzlgCJhB4vvlaCzSTiKMsTw7DykZzi0DsVCZ2SetEKlzjP1ALPcbM29HnKX8X6SIhzZpQjM7Y9WJRjO4XFj+YKT2tyIlCce3iQOKkbvpghCNIwhuoOM0tnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORtweBowOnut5XR4xZPVd9JQaQJRY8M8FKYCXZlZtM0=;
 b=u3n55P3lDMjYQ/ZoKz6bn2wkfwQNT15J/Sva/YrjJL2GZlSqNBxGVNZ1LadkLYfgfC9ct6rtryR3caBQxxGSE17+rlcS9051eHV3kzKC5WTVKsalh4ulr/gr9THy57rCRqWtXHN0wjy4f00wdRs7kClAGCTLw8BYU6Q+WzLI6dE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5719.namprd10.prod.outlook.com (2603:10b6:a03:3ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sun, 10 Mar
 2024 10:02:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.031; Sun, 10 Mar 2024
 10:02:46 +0000
Message-ID: <3c343fde-01cb-4cda-bf20-9df0ece94359@oracle.com>
Date: Sun, 10 Mar 2024 10:02:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] scsi: libsas: Add LIBSAS_SHT_BASE
To: Igor Pylypiv <ipylypiv@google.com>
Cc: jejb@linux.ibm.com, martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, dlemoal@kernel.org, cassel@kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
 <20240308114339.1340549-2-john.g.garry@oracle.com>
 <Zetp8ufVfxxo6DOF@google.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zetp8ufVfxxo6DOF@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0354.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ad2783-98f8-4157-3524-08dc40e93c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	owkYbtBwYvW9vkmFHw69yYjJjgOP31DhSFXOD4WFuMIEPKji+ofIbEodmLycDNceQMfV8TdeTkLpkodouEsbpbXRz2Lt8i8mwqqRu+/i3UgcGIpNtt8n4gDT81spRbx6IMZQpkpfHBqJcBWUi9HZe9XrtJKuzQtoGSIaNMgD/mRonIj18QKR00Nghfh3RgznyKD0iMocUEITE54kgEWdLKqeTkUCGJqqBDDMgqD/7iIyKzlOtIN0FggLf9SMHh6nCmY4BGqvom6o81Oennk8iOjkFibKHGjBIdSeiKRc93DOMiuntOQsEMr15pmZESrp9kCOwCCvlUNg9gvjg8rXK2QepFHbeH+4DmZ9ZEOiKTUcCQowbs3klaSs1TTqYBaB+qgH1zTVHXlNMgwmmBOBVTI3hQi1rEohijHv/HV4rg6oqd84+mtsy+qXt19zjsrgmsPePBXJ4Kwixp+fcwQ1vDLeyilNeP/xy8HsKHGJil13tCucze+eN+S94m5FdKeRkPe3e47a5ECXU/7voJqLl1bxbi5/gIWSayRNZ+fwTYqaur1d7gcoH1s8JVEx8jtwuyPGWSb0uAInFvJh9vL8KaybHpNH6s0NKZ2A1uVq0P8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RGE5TlUvWGk3c3lWZ25aWm5qSmN1dC9ER0hmc0ZYRzY5WkNDaVNVVXROeU1p?=
 =?utf-8?B?SnFiNWw0bG1YdmhOanRNWUxxbEdhR3RWMU5rd2IyNS9uVlJ0ZS9RcERuVFJn?=
 =?utf-8?B?dG9kUEc2SkVvMWIvSjN4SVdLWTBIdE0ycDZjdnJkamFoc3NtOXpscjVvMCtl?=
 =?utf-8?B?K25rUnNhY3ZoYmJHVnJJbElGQ1B3eXR0NTIwWHdsZkpOV29FMyt3WHNGMXBs?=
 =?utf-8?B?K3lIMVRTLytXUFh3a1lHamliMTRKWjBFZmpacGZQSnBuSnFoYk9JaS9wQUJO?=
 =?utf-8?B?VHM2NlZyU3hOWUh6cEY5NmhhMXZKVFBhQW5nOHkzUDJXbDBNSDd2Ni9jVi9T?=
 =?utf-8?B?ZVV6VzRsNmVCZHp3YWNqKzNuWXdtWVdYZ3NhRlo5cUtCWUVEemxDR2JxMUNo?=
 =?utf-8?B?TGZnYyt4RFNpelhMKzdDTFE4bXV3eThTSEUrbEdHZ2N4VWxSNlN1VklRMm5S?=
 =?utf-8?B?ZVhCQkJXcnNmWWlPZHJaa3IrZ2VwbGxIazNXam81Qml0QitJUUt6STN2N3Bl?=
 =?utf-8?B?clBXNG4vM0FCYzIzL3pzVytRL2FTV1pTRWROaFFHeHZOVDJUc2NNODlnMS9P?=
 =?utf-8?B?QkN4Q2RFdWVxUm94a1R5SVk3RXBPb00xejlocExIcFlVeW9tRzU4Q2FGR0VC?=
 =?utf-8?B?SXVKVEUrRENBcHRCQTRVVk41b29kZGZMMHp5ekpUT1htR2dJbjczL2FqTXc3?=
 =?utf-8?B?RW9BVkMzYVUxZGx2aWVTRVFRK0dQMStvTXpkdnhvQktYVHhxR0UxRDE4WXJU?=
 =?utf-8?B?ZkpuUldmcHF4Tjd4cGpZNXhRVnRwenFDRGEwZjVvaGVtUnBtZ1lidHBpT1FX?=
 =?utf-8?B?ZlJCNHBxNEtXNC96V1JFbjhZTWtnZ3RFcmtZajZDZm5LZHo4Rzg0anJjckdL?=
 =?utf-8?B?aEtra0VzS3E1RzB5RENiNG52anY0VURTOGl5RjFtOG5aQlFzWVJhQUdKUFlG?=
 =?utf-8?B?S2JlLy9tQWMvU0JlT2xHVFhya2k1eThJTUFFMThHWTRQNUU5bmtra3cvVVE0?=
 =?utf-8?B?b3liYk5JVW8vVXQzZWFId0I2TkFmV0VNOFl1UW9ocnZiZ2R1TTA3L1NXcCtm?=
 =?utf-8?B?dTJvZFNXQ0g2bWhIRGNLTWlQWHl2NzRqV0cybk1HamxyT0EzaEFJZThNaEs4?=
 =?utf-8?B?N2ZQcHBpa1lRWTVHeFBqN1Bub1BzRU5DOVRESmdOYjJXYjBUL0pOZk41MkNu?=
 =?utf-8?B?RjdDZkV0ZTV4b0h6aHNlc3R2Znd6ZVhTQVh0a0owK2tVUE00d2NhRUhjK0Nx?=
 =?utf-8?B?dG13MmZEdnRoeU80SjZrNEcyUWxBNHdwVWVFYmsyekVyWHBCN1dXdWphOG50?=
 =?utf-8?B?L2ZDb25oRHVpeUJGQlZPeERlRzBYZktkZ0ZIZXBrUExzSTF3MGpQUThaS2Zu?=
 =?utf-8?B?MHV4TisyaFhSSWUrNzdFdHh4cWc3OXQ1L05iTXRnaU5wUG5wMzFYQWU1aE9P?=
 =?utf-8?B?QS9JUElOU2JFRFFhQkJRVE5rUnlpbXY5QmxtYkNzd3JFSHM3WUI1bXhjWDZB?=
 =?utf-8?B?Z2t5NDQwam1nMmIvU0dvQ2RhdjVYM1plZ29SZXhuNUlVRlRIRDArUzlFODB0?=
 =?utf-8?B?UGp6ZFRlQkVNZU81ZHluV3lSbHljai9tZ1lFK2ZaMGRGQW50alVEcUp4THll?=
 =?utf-8?B?cUpDaG1MR2ZhVmRuSFpBNmJjSzB3R2M5d08yT2d2MGlrU09UT05Fc0VjNE5s?=
 =?utf-8?B?anF0eFJtWlh0QVhRNmFPbU1PMmhnZnExbnFYRTdrekZ0cDVNTGdLT3dPOFpu?=
 =?utf-8?B?aUg5SVorKy9MaUxOcWtldk0ydzhWd2ZSQUJiSlVRTURmbWtHZmVUK0xRbS93?=
 =?utf-8?B?MmkzWFVmczUyanltVXBVdDVnSnFBYUdVUTh2MC82UjNIWnNJUXdpYmxSODlj?=
 =?utf-8?B?ZFI2VnFNdGtac1JQQzFYaExjOFJnQmFjSDlIVWJIc1lUREpKNFQzakJ2MFR3?=
 =?utf-8?B?UStScUh3V0VtOCt6b3ZkdXJGZENoTlFBeWE2YzJJNTd1VjFUR3JGMUdzcDFZ?=
 =?utf-8?B?WWtORG9yd01wSTVTYXh0eWY4Vkc4b2cxK0hRcmZLRThWNWxSMGVwWHNUUlhM?=
 =?utf-8?B?T1N3TDdFSVVmMmt0NnBZWFN1aitHWndKOG9wd09aVjNQQVQ4UGtLK1BuM2Jn?=
 =?utf-8?Q?ER5Clwk54D863P2ZdvEGbjJ3j?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RqNdCTAmGVeGhvQhMnmfcWht+8Hjir6Yli0zazBjXS3t/rdXDFXCrQ3fKqOEPA7PCrtcEb0+MY9na7mCRCgufDZZjimBczAB9w/Cm8U/OWJCwh4zevIuLo6nQ5AP7IqqU8zwYgVY8ENxh+O181SGANyCdwSvjH/F1X5493x6u4fKsBvn62cKn4VsbQM0Um6Yk2gVkxIrAzpVimCFc2Zw5Em7fi0pohBfpNGRlp8zKWX8Wl2ZE2uSNABUSXSqPUnoYmUOd12MyLZEU/mZ4NnMrdRsY4wRfy/Fa8mo4kbnij92lJIq4voW2Y9ULnn3u/A5t5UUU63SJIcQ0KRaqTSGEprEGdXtyVebONGfhWISweEUM0oZ150Mbi4EjrN02wf7zjkCvJDRcrgx9+wNywBPRFJ/pkKtAm+rrHK7SyJtxb54/NyhLkAbx3spVvhdsVZmlPyZlOqbVNr2gJP3l4/gfSbyqVZmI7K38VrP+crYUyEpYcB3IZzi5oG9vlnvug6ye9ixmVA0UH02MuYBmauopDl+lMQijtt6pbUvpqhmrnlVJF/ThmFnKurKfwzB60AW0pBB8Pt9/M6YFm9+tdZlb0hG+4W83+VLYuX0PT8/ClI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ad2783-98f8-4157-3524-08dc40e93c32
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 10:02:46.3915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9AIwnuCKPlvTknOvF7akR1+jKERsPcdNILhJCHYVP/5XQ/HQHVe54LMO88zBHmawnfU1+3SXpg2h7HZT1mXPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-10_07,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403100080
X-Proofpoint-ORIG-GUID: cgngnN9W0bHPdlhIVNUhZ4hjeeH3r1bz
X-Proofpoint-GUID: cgngnN9W0bHPdlhIVNUhZ4hjeeH3r1bz

On 08/03/2024 19:41, Igor Pylypiv wrote:
>> Even though some drivers don't set proc_name, it won't make much difference
>> to set as DRV_NAME.
>>
>> Also add LIBSAS_SHT_BASE_NO_SLAVE_INIT for the hisi_sas drivers which have
>> custom .slave_alloc and .slave_configure methods.
> Looks like libata drivers have no problem overriding default values that were
> set by __ATA_BASE_SHT. For example __ATA_BASE_SHT sets .can_queue .sdev_attrs
> and then AHCI_SHT overrides those with AHCI specific values:
> 
> #define AHCI_SHT(drv_name)                                              \
>          ATA_NCQ_SHT(drv_name),                                          \

which tag are you looking at here?

That looks like an old definition of AHCI_SHT().

There was a significant change for this in the following:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/ata/ahci.h?h=v5.14&id=071e86fe2872e7442e42ad26f71cd6bde55344f8

Thanks,
John

