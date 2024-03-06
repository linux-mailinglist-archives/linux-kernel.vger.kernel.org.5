Return-Path: <linux-kernel+bounces-94356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F0F873DDD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378751C22DDD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6992813C9FB;
	Wed,  6 Mar 2024 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CgUzVIrG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yla1Tf5J"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C4113BAF1;
	Wed,  6 Mar 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747892; cv=fail; b=dzhemXBS4rhPuLAIRx0QgGl7YWIrHtbAdl+ZEd2SWdQ6HGJXu1EAyPE8wLLNT3xziNwR+qugj3nX0vaAwcC3fD6Ys9dVd2G3EqkXVQlXiRwGJlQdzPKa0ISTvP+jMMS7Lo6z6+CIfiEMkc0q57zCop9+L56MasthDU9MURDaSk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747892; c=relaxed/simple;
	bh=JTtG/8PfnDdexLStsEcQKbZMMCY3zq98ydJ52IEk7CU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MSLKk+N3L2F3OZWniVeWKKe/cgbfBXtcXejU462iy4QLV+nCmBmv1WJg4lLUT2aYbh0QdgiHnvkDfPXkaMxPpF+ymMmuONr92JXRsYLnLyMCxSfXK5xMbB2mpKi+zdXErZk02a8PDOOYlOF1qe6cgKB/J7FGK577mX+BOJSH9OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CgUzVIrG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yla1Tf5J; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426H473l024569;
	Wed, 6 Mar 2024 17:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EJmHY9UhDtAq7Pu8F3ZdSJkiZ6/Ume4eDOyno9h5q94=;
 b=CgUzVIrGnaVVklwG0x9O6H9CMtEpjd15XSecduHZgQMBIuTBa/uy2wfuVDrK76sj+M8U
 hxUqrF9PE8zVnIS+7jwSb8nzPs601rHqAFAV9bj2ezjgJ1sTLYIDUzaERTihwN4mHYQa
 Bd+p5DUrzirSr6eE05z6Bn+uN2I1sye1xkTL7yfAepsBvGW3x5XM9hr1Ct+NjYkDHtJD
 6p4BBhQmsNuMe9/qL5j2bXNK7namh052bfzywSMv1id2SmidVIPczOyxJCzMz7Ooy4hn
 IO+s/HyDWZyvaYbVD0cH+n0UniFGK5fhfeRj80KmvHe6e1IIa9FxImziVsLGhO7OR/1W Fg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw49j59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 17:57:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 426GYkLf013753;
	Wed, 6 Mar 2024 17:57:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj9nuce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 17:57:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InNG0GjZKPt6WjFzIbBfN/h306IlufhXhcrmIZzf7b7maGpy/7K1l9Z0TWG7HBqdSDH6i1BPOZ4vbucsJCYx3gr35qlv9R0mURXBR+7lUQXCJSOTXPoJ4cDoiWTBrqLttfQPYS8/kJNV7yj7uWbqJvJqth4mD3R/0hW1msekqq1kdpHINbHCn8cm/vVdBRa/e661yXwXmdSE2MjKrXo/vdjJkErQ4qoOh4CgGiR25q/RaxVxUrqtFFWSylPBVI0a5xBC4lXg6UOamx2vBJDgo3R4OYjL5MbVpylQc8tspuLYxWPmLqbNtP+U/7q06UL92PybOfJztuLijaEYwc8BUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJmHY9UhDtAq7Pu8F3ZdSJkiZ6/Ume4eDOyno9h5q94=;
 b=nhPMhQ4cuZYQylNVwxCZlWyLTiQdtQggUCrfNMmBQFiQUq8djnbpEbx9/45OhX50GoozNiQdBFcCK/tK6i/LAIxhtLLR2k/lQKZs3wN9KJ1bqOP2egm3Xl7lQKKMouuPFUfLK1oqnw2kI0cl6MbnV75dwtwD5fqJkVOzDjBQGXPtc7pY3WUPdXL5YgmWODlDgE4bPCuDCQAtf4GxOHaM8y5idilt4JPVbNVFr++BvypnO3ix6xZUefBIxnmxOzpW7cZeBl2DSeo3Que5+OnHJCuNEuKkJ0taC5gTDmNFZcck7gdGnr6unGYOvPDEOXl6sAxaCvL/ARMbGStZ6t9N8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJmHY9UhDtAq7Pu8F3ZdSJkiZ6/Ume4eDOyno9h5q94=;
 b=Yla1Tf5JPXLqweOJXPqktLyutcQKR7ZuWIsg8CExvduhfWy/YiaaEGqArI0ufkVcDUpD0yWXvOmrmKYsiNL0w/FKyj53YUzjOVXq/JLaLqkaa4QVx4N+UORJ7V18GsUEmR8daSUXzoWo+4BKoXn+ircVN57fUR43uVPPAFztKv0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO6PR10MB5602.namprd10.prod.outlook.com (2603:10b6:303:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.25; Wed, 6 Mar
 2024 17:57:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 17:57:48 +0000
Message-ID: <0e336146-0f8b-4ce2-bc28-ab582e2c5f22@oracle.com>
Date: Wed, 6 Mar 2024 17:57:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: libsas: Fix disk not being scanned in after being
 removed
Content-Language: en-US
To: yangxingui <yangxingui@huawei.com>, Jason Yan <yanaijie@huawei.com>,
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
 <a7eb46e3-997c-4746-b820-a09229e75581@oracle.com>
 <15c6d1cf-0aaa-0a01-5bf4-0762f45d7676@huawei.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <15c6d1cf-0aaa-0a01-5bf4-0762f45d7676@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0274.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO6PR10MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3ee929-3d66-4db0-3e5b-08dc3e06ef60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7L4+QP1PDiVcW5o8mxLMJZI02603+dp4SFjX5LI0xPvrfkqW7C7kDnIn/vUG9BOt5Gr+8hegJQg2wbDhnW+JAiysuZtKMt1ENKCJW2CQM80DwbP43JP7xpfiTPnqb8TcSRRl3fKb6WH/P4a2a/uLwFdtlMieyzujqkYIFZWuHphGNHhKnqQkDgEVDUzP67OMwYgf7D/br76eGwwtstvSvhan+xA+csgostdY+iN0gX2x+03TZaq9XsPnXm3/KKVlXI3ptzpPeXKq1Qy2TID/p/oFab+qC7ZEk8486rnNzLOuUh/zS5IRMIcNPTFbD8gRePbJ7nKdm6E6qu5XNkhIwkeEKaHST7j86x+F4AFcMSlxyiQs9RACUB/Zmll63B4OsPYRx8E1u2iu6C8YHQ1II01FLVYGtGsfakzGcCBnd5RUNerzKZL36yhTQLWhLuF+9J1BYBbM6ZQor56UygWHj1j5n5RznuITt1sPMGNma9CnWDws5gk9xncOhCDFeB3VVRFrSBYQbSQ23ZQH1xLS+jVTsN0emCaSu+GDYDA3lc3/mqx5t6LZLYMqjE5jXBMcldGjxuJtb9Pqn176xx+fI5jznvCVsRDlGOYr7LLlXmaKm6Kr2Go19TPxj+RL2C/dPFg6ZU0xnRtotPFUnmrYavyniTVOzixrvSxd7DLysbA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T2NkV0c2a0orb21KVWRIbFJYYjlzb2R1U2ZNWDZ4WVpubGp4S09xM0ZPMjd4?=
 =?utf-8?B?dllVV25KTU5DY0oyK2RDVm5pK3lVeWwrSEwwdHljRmlUY0VETmNoUnU3ZHZL?=
 =?utf-8?B?OW9tSFV2bmkwK3FuUFFlY1dTbnNvSTBXZG9EYkU0NlVQa0ZJV29vUWtRWWI4?=
 =?utf-8?B?OVYvaWlFbi9DRS81RkdXOFlhVGYwWWdra05lUFJMek4ybVk2ckJFdlMzUE5H?=
 =?utf-8?B?Wnk5bWVzLzZOTFBrSnJ3aTNRTnpnT0NYeVJLaTJuY2htTktyZktaL3Vram9P?=
 =?utf-8?B?SjU1a25zQ2tHQU1WYmJLNVdyQVpSaE9idUNzUkNCVStPOXNGZzZnTU5QcFoy?=
 =?utf-8?B?cFpaMHdHMHVlZG5ZYXF2cnRCUkVtOGdPTFJPc1QvRVpWSXc5MU1uOC80eUg3?=
 =?utf-8?B?amw5clJBWEk5RHpKWUxybEV5UDdtR1UyUXh0ZmZWRENLWHI4WnlNL2dVUmM1?=
 =?utf-8?B?cWMzWXkvTzMzZ2hONmhvS09wMncvTUVjNkxYc3dGU2JjTlRXMm9HVWVtRk9x?=
 =?utf-8?B?c0VWQ3RPT1dua1IvaWFMcTN0c1dZT3ZqMlVVaEZZYk0xQWJLMEtXS3NDcmVT?=
 =?utf-8?B?Z2xoK0VNYUpZYlovSWcxMGN5MWJUdyt2SGFacHZjeXFRcWFXeXVWSlNVbkJr?=
 =?utf-8?B?NG9SbXZjUGM3Z2FhaGoxYTMzallLZGdySVlhNGgrZmFvMTNXRDdRRlNnaEY3?=
 =?utf-8?B?d0IvZm50MHJTTTFWSTN4QjFyR1EzbVM4Z2xVUG5JYlZNU1NkdUdZdlJ2N2Nk?=
 =?utf-8?B?THg0Rk44Y2ZkSEsvRjBhZmhNU0xScDFjME5zaWhGZWVLZ3gvd2F1aTZPTE01?=
 =?utf-8?B?V0dWVDlUQk95QmZzd2djRG1SZzZlOGxLZmp6WGhZRnNicmh3ZTNYcmduZlZs?=
 =?utf-8?B?OUVIbnU4T1ZweFNGMk4weEtPK0xZY2xGTU9wSElweTZSRm9ySEwrQXNxVFZo?=
 =?utf-8?B?a0diQ0hTYU1KbncyNmFSRGV5UHdhUEk1Y2N2K0VuaENmakZ6a2huYVhzUmx6?=
 =?utf-8?B?WnZkR0JsZlRVQWZMRDErRHh0Nk1xV0lJenNYd1VxRXVicldJTW9VYmFTMXVv?=
 =?utf-8?B?NXMxZ1ZDTmlNSDBESVZvVEZFQzNTL1MrcHBaUDBISkROblc2RGFMSFVoWEZZ?=
 =?utf-8?B?L3NYNWxrNDNqMWU4WHhjSFNFelh2UnkrajB4cFNaNTVBNjdsYmlrbGVZeGVS?=
 =?utf-8?B?bHpxQTV2NUg3cVNtMnRiZU4vT3h0TktCQXpPUzl2VmtPNDYvaDUxMUhFalF2?=
 =?utf-8?B?dzl1NXdrUUdrWnZwSXk3R3VsZ0pEV1IxVTViUlRmWUs0QlhUbTI4ZFA0L0NL?=
 =?utf-8?B?b2tBRjNjVFpmY3JqUDdLMUdReGVod2xWOGtOSU9UTjBmY3BPakRjSy9Td09l?=
 =?utf-8?B?U2ZlSDkvS1RleVNYOFBKeHNUU3ZwWmVXeFRpV3I1L1FYaHVjQzBFNGZFS0Ra?=
 =?utf-8?B?bnlZRzk1SzN1Y3dyK0I4bndjY0hLaklhNHVDbC9jZk5XSWcrcW5pL3RSZ255?=
 =?utf-8?B?U2MyOC8vQWhwN090aXNZZnRmVmdMYlJHTmR6UEN2V21PamVWUUlMVmNnaHd1?=
 =?utf-8?B?ZGlpU1F0NWgvNU1ialEwYWtleVJJUjMvaDl6YnlTai9wV1ZLMXFFeVoyYnpR?=
 =?utf-8?B?Y1RhemN2TktybzJUaGQ5N28rL0U0V1B3djRETy9aM1NxNkRpUEs4OTlzQ01H?=
 =?utf-8?B?K0hHblZWK1BaZTVBNStET0krUGcxVHdUMTBVN0NFM0I3cVJOeHhKTlZGeTls?=
 =?utf-8?B?K3c0VERLb25ucTRIZlhjcXlKKy9EN3ZwNnBHTUdRRW5tTGEwSFJkMVY5Vk84?=
 =?utf-8?B?WlBNaG40MFVxUGp0WGIxbzVnbWRiTWVabUJVTkl3NjlETm03SHB3eUpVbkpm?=
 =?utf-8?B?UlZUZFlUMFU2ZzRZRlMvamc3ZDY3NTNlRk5BY3pIbHVUdTZwbzRMN09odkov?=
 =?utf-8?B?Y21vbkdOYk8rUzE1SmhmbVZMSzcySVNhcU5XOW1SSVlFSnVEWVJQY24yV3ZV?=
 =?utf-8?B?Qnp3STF6b0Nyc0xtMFFiaXlXZlRqYUh3UW94ZHJHcHZkR2h2YkUxaGo4NDd4?=
 =?utf-8?B?cXZhRVQ2cTFCM3VUWHN2c0s4NFBjbUljRDY2SUVQNjRIZUh0dWpSQ2xBZ0pF?=
 =?utf-8?B?cXl1amkrbS9VWFIzOXpCYU54aEJ5TVJ4TVRaYVBFTkpwTkJqYWV1aXI1bUJ6?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OVTrGDs9PPBJr8cP2UR5zF4Lnm1bKEsuFr9o0NBxclSApApQ0WY0Jz8oFIC62YGu7wtjLNYhL/LoJH2KbQZ7KKl0ri2xrmzVVD1RLxuiCkT16kTBlhMhKTv8x9A62okOBbmx7PohxBUW1baIL8nT07FTCtoNUEN3XkBJM40Gm/6oHlFxc3TW865u2BURqkqEB64Ihm1MflJqboIVcEzlJo21CqsH31uEZQtB7C/3j5htelCuUmVMG0IcPFDr6m3jOJCWPVus4qVGJiRcDRaMt9+kZHj9Xnq/B/mJ7NGO5hTdUC5kWq9x9p1jEoP91w4X3Wm7LU+oEN0vZ+c3eDh0PgZvGlLV9Gg8JYJ8/8yQrEhzEHjlrWTJx2kjpNhEzcerqgNZQIHT+sEiHRFm8ajKlrTPRFfdqFu3t7H9+d86XL/UEyc9JhSx7A+pcw7HDVJJVU5/Mnah5v5eY1DcslXmXbnaZ4+7BndtXoQqYDZ9Y+z0smyj1mekqfWEKRH7ac04nCpoD28tkFS1jxTDQo5negpnA/Pj9sDAoOI99RNYZXKaygKYi6RgFsrrE964wiB1ptogwEJ55rOGVm84WfEK5Tbr0dxQeKZjMHAHAtVixAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3ee929-3d66-4db0-3e5b-08dc3e06ef60
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 17:57:48.8894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bT5Ww8eol1N8pl/uEbusNy6ighd1YJYGipJXG/l7eajoWGHOFW+BLfOJp5Kgt7v92J1OhOaO+Ww7WMILKkk8gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_11,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403060145
X-Proofpoint-ORIG-GUID: BDaJadw9NRYpq1XwFtr5dkbPY_KhPC9-
X-Proofpoint-GUID: BDaJadw9NRYpq1XwFtr5dkbPY_KhPC9-

On 05/03/2024 11:25, yangxingui wrote:
>>
>> It's like the change in this patch.
> This doesn't work properly. the previous sas address will be compared 
> with the currently queried sas address and the previous phy information 
> will also be used when calling sas_unregister_devs_sas_addr() after the 
> sas_rediscover_dev() function calls sas_get_phy_attached_dev(). 
> Therefore, it is more appropriate to update the phy information after 
> the device is unregistered.

ok, fine

> as follows:
> static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
>                                bool last, int sibling)
> {
>      ...
>         res = sas_get_phy_attached_dev(dev, phy_id, sas_addr, &type);
>          switch (res) {
>          case SMP_RESP_NO_PHY:
>                  phy->phy_state = PHY_NOT_PRESENT;
>                  sas_unregister_devs_sas_addr(dev, phy_id, last);
>                  return res;
>          case SMP_RESP_PHY_VACANT:
>                  phy->phy_state = PHY_VACANT;
>                  sas_unregister_devs_sas_addr(dev, phy_id, last);
>                  return res;
>          case SMP_RESP_FUNC_ACC:
>                  break;
>          case -ECOMM:
>                  break;
>          default:
>                  return res;
>          }
> 
>          if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM)) {
>                  phy->phy_state = PHY_EMPTY;
>                  sas_unregister_devs_sas_addr(dev, phy_id, last);
>                  /*
>                   * Even though the PHY is empty, for convenience we 
> discover
>                   * the PHY to update the PHY info, like negotiated 
> linkrate.
>                   */
>                  sas_ex_phy_discover(dev, phy_id);
>                  return res;
>          } else if (SAS_ADDR(sas_addr) == 
> SAS_ADDR(phy->attached_sas_addr) && // <=== Compare the previous sas 
> address with the current sas address
>                     dev_type_flutter(type, phy->attached_dev_type)) {
>                  struct domain_device *ata_dev = sas_ex_to_ata(dev, 
> phy_id);
>                  char *action = "";
> 
>                  sas_ex_phy_discover(dev, phy_id);
> 
>                  if (ata_dev && phy->attached_dev_type == SAS_SATA_PENDING)
>                          action = ", needs recovery";
>                  pr_debug("ex %016llx phy%02d broadcast flutter%s\n",
>                           SAS_ADDR(dev->sas_addr), phy_id, action);
>                  return res;
>          }
> 
>>
>>
>>>
>>> OK, so let me have a closer look at v2.
>>
>> I have to say that v2 is quite complicated...
> Yes, but it works.

I'll check it again.

Thanks,
John


