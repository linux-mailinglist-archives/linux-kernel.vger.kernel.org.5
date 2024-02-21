Return-Path: <linux-kernel+bounces-75350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077D985E710
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4511C24F57
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0670E85C6A;
	Wed, 21 Feb 2024 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A/+Y4Q36";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X32Sfdff"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328681097B;
	Wed, 21 Feb 2024 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542953; cv=fail; b=F1GzGaThwoQhzcR+YZRjxuwi30lFRcESrkjKwqwC3NgMbcVvND133T6JTuIRC9CtKsNaFRtsbSTHV1pSdr4jMBhvOpYDjQnqP+4kj4rmQ2ufagckJDmmPmrQl2EqzDLNyR5fV6abgo/wjHBo09W8666Xh9FOncVHOQI+WFMMKE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542953; c=relaxed/simple;
	bh=7Rl4HqLnUY6i+QVOWzNOQ57BnHsmdJXjlX+Sb2FXe7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kd0yjquIeDN3O1+xhkDOFcEb+kZTD5sWh67jAFXIYw4DlmeJNtNpAV2TjPEDwHZF/aMvC/hExRxv0xdZIGyPbB8keXNZ2nby2rcyZziU+rz3IUX0AOhsDEZc/VloNAwLieWNjlIfCrOiKSJUTkpAffzInd4Vx0FgfCr+t8/f2CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A/+Y4Q36; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X32Sfdff; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LJFClX012122;
	Wed, 21 Feb 2024 19:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VDwreWdq2w4NecpdR1NOLmJ4fota0eDzaX1C2D58K9s=;
 b=A/+Y4Q36Hw8GN++QhoPfyhS4agdWmYhDNyHqJLu1Q4Q3tamEYAt3p4A6RlhfIqqeQDFy
 ARfhGTDRzidUMyY9BlxdfiZFxNgaYC5vUM3Y25ECwTKwwnZtFao5NefPCFHxNUQ6bJ/F
 nJOvF18yJ1UDwx0ew54pLimAO1S+I1f/9IWvgdVRRPjHCSxciqY5i2ei8DksV7wGlsgK
 AgDDIdsd+NCaxdiL0pR0fTzi7YKah4av/vfR8r9aKVVKfmKSeKqDDHD+6+Bq5O8e8rsf
 /b7t7o49qyr5tdiXuHaYgzKfr1JK/+I/ed1MgN1hTrzELijq0EFKwoubA+FwkKV5kFI5 og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd5fw2avt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 19:15:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LI8pH7032526;
	Wed, 21 Feb 2024 19:15:39 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89ggqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 19:15:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQ/umACDrFBB/8/4WahdvxOMwkN0mNBLoD7G1qhz28ep+I5FKRxbACWjmWPFvT5FX5AW2DPVaiGZYdmkKoL3Uswu/V4vRCS8o0iQWr4LUDqUqoae3i9c8lJgxSY9tDADVsHgBszL5tn0oGDLBGu5UoaGDurueBxItBbX50jRPbWbUdlzsL1xWxfgZJ9q8WWTmFE+2V+IITQGTA/GUHBOIAT/s5Lw5AiQqzhoMGXtJwkOHqsK23EmO221Q3hSTCQq+F8BX2l1cRh+STSwqZS1TP3uY0baky0DDSMr2vvKMfQtEUlr6eyg3EtUHQeCVOfCPkJVe7QCSrX1muSzMJ4Ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDwreWdq2w4NecpdR1NOLmJ4fota0eDzaX1C2D58K9s=;
 b=IHRUXJbz7+nYMgs+ykWenZj3m82zcbfZUXjNOYO1AJz0r7uMnzUwR+Bx4SZ3rFTVXSW+dvGwuh+pmnCOGSXOPdDDrayQi6hZpn66U27qiNwzk/f+L3ekqwk2OvMI3D08R2RfW4iuIqSOAAQ1PRAvBZg7dQtjOnlV+dJvSTwu3dP8If8AFoKQxlxaRupGBr8lL2mOx8zG3RBBQ8HIYvLq4oyY1jCfbuhujWlQslirsYZzO6i/WFsq9zukOKC+2nqMY3RMUlKbX9uu8dkMsrPcvi94Vq2B3PQgi5viHZ0JF7dgI39EMR6eZX716gjzXJeaTQNp+E4wl+3EbZs6b72eFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDwreWdq2w4NecpdR1NOLmJ4fota0eDzaX1C2D58K9s=;
 b=X32SfdffOuRSODqxNnkJqlWcKz4AXjawzZkCginD8C/Bu8epsioQL8HGuEaE3o8wLeO3jQk+ZcCjDbe63FC9PMTmMHtPT4W1HWQXbmno2doaErGkUtjR9VF5vLpW0X5ZgZaMcnX/e1zxlfv4BZM2iBWew4fxIi0XmMm4ZCzPz64=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by BLAPR10MB5234.namprd10.prod.outlook.com (2603:10b6:208:30c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 19:15:37 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::1e9b:c7cf:d15b:c41c]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::1e9b:c7cf:d15b:c41c%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 19:15:37 +0000
Message-ID: <c9b3466c-7972-47c0-b590-9c1012b53a82@oracle.com>
Date: Wed, 21 Feb 2024 11:15:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
Content-Language: en-US
To: Mateusz Kusiak <mateusz.kusiak@linux.intel.com>,
        Dan Moulding <dan@danm.net>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, regressions@lists.linux.dev,
        song@kernel.org, stable@vger.kernel.org
References: <20240123005700.9302-1-dan@danm.net>
 <20240220230658.11069-1-dan@danm.net>
 <f32cd478-a905-4e98-a46c-0612bc10c38e@oracle.com>
 <2b5daa31-af66-4297-932b-d2fd341b63e6@linux.intel.com>
From: junxiao.bi@oracle.com
In-Reply-To: <2b5daa31-af66-4297-932b-d2fd341b63e6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|BLAPR10MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: 396490bf-a0fc-467b-1264-08dc33117c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	a8++ly+2YYmhAC5yIxWDVwNsWoNSHbRAD3O/ybsgFkzlUjb5Y+SdyJQEumfOt4Yf+XJKDjVYowKn2jEG6VzJJEYegDwjU0FzAYy4XnJrKazmd3VTNNEvnfrIR86MD2amrOZAJhmOEqOBR06M+JM/BLd6n3jKZ87a+c9S5AiA3a3yiIwkyAeDgXfY1koigBKdPI6il9U8p8y+P4bRtsT8JUOg7YI1S7st6l1atCn8G21zsrXZfSzh4q42ocL4RHAv1epRSmj1RC2CC4eiIMVaPnlqErAOW0xJlPfphAjSl4XwyseKHV1GY1HS8zLEyGHolROFYHRv+65Op78rp8Sq5qqd0BpqHvZyIWnlSpZitG3q1Z+Hfai629R8YONfOoNGleYne08JVSnR6kBxLJ4CT5FiaT6U5vWhNX9RmOCGP+GZtUd0yztuwdvPBWT4ZYO7bJh4rbczSQaUIxgTS3GknOoQtd/Hm8ROiDrpDTs6V4fkI/pTWizAILSc2AEYUkKSLUjmtQ/v3qA6I1iE0PdXNg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q0I4ZnlKMkpOWU1saGQ1TXoza3RFa2tWUVUyeDZSREZqSU9uWjl2THZnVng1?=
 =?utf-8?B?VGVGUWs5cTNEUHRud1R3UFhKWTNneUpkMDBDY1ByWkcrSEptVEpHam14QVJh?=
 =?utf-8?B?bFpsanIybkk3YndqWmlwTzBVdzRyZndNYy9FdC9UQ1ZMSEpFNW9CQUNUU1Jr?=
 =?utf-8?B?c2d3bjh2VzRVMk9MamdIL09rVzBrblBaV3ZxMFhaUGNEaDBoMTRwNUhxREwy?=
 =?utf-8?B?UkNCRkNVbHFYRTNrTjVCWnlNekZNRmU1ZVhNL0N4cWJ6ZFlOSlJrKzZ0MTdW?=
 =?utf-8?B?NHhNUjZlZy8rR081UDRBN1pGRTVLVjRQaWEzbUs3Q1dBbzNheVJpSmNIbFBT?=
 =?utf-8?B?WG5YaHQ3ODcvakpCRUpDbGlJYWhMZXFmSUhmWUF5NjQ2eWhwRXhERHVrTjB5?=
 =?utf-8?B?RFArM3F4OUlWZHNoK2JlNW00SFZzRnF6RzRGMGt4NFR2ajZJVXVXd1k2ZFZ2?=
 =?utf-8?B?bGFhbEZxTlpTN0xpQ1c2Q29jSHhuWHVJeURGcExYYVZzK0lSSTVpZmVZNExT?=
 =?utf-8?B?MEM3MmwzUXBFSlc2R0JrOUhJb1BLRlhaYW04ejdZVWppM3B5emRBM00zVXo4?=
 =?utf-8?B?bldtc0NuaFIyUUVSeHBJSDROOW53M2V0aG5zSDkxZ1hWcGptM0x5bHljSDEw?=
 =?utf-8?B?V25rcFRnTnMxcVVveWxOMGlnbGdmU3JZRmc3Rkl1V0JFV1kxdnZFVTlKbVlI?=
 =?utf-8?B?TG1CT1Z5a3Jyem9rc0g3aW9ndTJVQldwaUxWUjFzbWFXQ2d1b0d5S1djMUFX?=
 =?utf-8?B?bHlpdWdaaHVPd1FiMHV6T1ZFL3VWMzhJUnlIdjVoT01xQmI2QXI0SWNnV0s1?=
 =?utf-8?B?a3dER0Exd2pOOXEwMFNOOXB5VFFhRThyL3BCSUZuTk5CUzE4SjVtL1MzWWJx?=
 =?utf-8?B?bFZiOVJEZnhZbFZXL1FsUzU3djNmSTg2eDJJMlFZeW96ajEzdHJVblpiVk1m?=
 =?utf-8?B?OVM3WVBCeHkyc1pROE9OUlBPZkpRWTdqK3pwTCtVZlFqWTN0WHZjak0xbGxk?=
 =?utf-8?B?eExadFU2Z2c0bi9ycFZkVzJiNVR4RytQWFFSeS9PREdoKzgvNlpvZnVpdGt6?=
 =?utf-8?B?Yk84cWxydnZzN21VYklXa2FWVDRoWWMzNmc0MEU3Y2pYdnNwcnJNeDBPVHhG?=
 =?utf-8?B?dGo4RVV6dzFmQ05ZWXBndGF2dVRhREI4NXU0d2N1WDBKMitJY3YwOTV0ZVMr?=
 =?utf-8?B?R2tKVFlWdUNzUmgvSDB3enk3NTlRRDNRTlA3LzhBU2xVQjJPaWUzdkxNV3cv?=
 =?utf-8?B?bWg3NFo0b0k2SXdqSkhvZElwM0RWUVdGQ1M1dGc2RUlveFFpSUowVjRBQTVy?=
 =?utf-8?B?b25uMlBxdW1WVm9sYVNoMEdudzNVSWkwT1poYVpQWG50QWFwUWJaam1qQnJW?=
 =?utf-8?B?T2tFYWNaWWZKdlZYaXhMUEVsSlBPcVFaSTl3NWxkSGdkamhDcE9lbm1qOGo1?=
 =?utf-8?B?TnpRWXcvanZsSmN5V3FKWHNkc1R3WWxFYjhLQTFOdXUwbGEvVXRWb3UyWmR1?=
 =?utf-8?B?MDhvNHlsUXJSSlB2QUV2dDhuV21xNW1ObDR4RTBSYW1LY0FOb3k5bVh3RW5Z?=
 =?utf-8?B?bVhudUsva213MmZWT241WDNQdTdlWTV3SG1PanhxZGNSRERqYnRMaW8vNThm?=
 =?utf-8?B?eGM1K1VPNm9wcjhZaXRqenlxQk0vQ1BxTXZDNmxydjdJWVFQaVpjZCtzV3Bh?=
 =?utf-8?B?SHhSOGJ0aHJvWkNNWnhvdXZLYlJRMldJbnN4cG1UOW81R1UrRmY5WVVJUDF5?=
 =?utf-8?B?QzJvcEc4U20wWWhaZjZYc0w3anIvZkgzTVhZMXEzbno1Um9PK2hNQ05WbGVO?=
 =?utf-8?B?SE8rclN3bG5udXozZ1c0TlBFQ0FiZ0QycjdZUmRESmxSaTdxR3o0TSs1NHJ6?=
 =?utf-8?B?WkhKNnJwZ0wwd1RmUWdwM0lSQkFFL1hGYUVXcDBYKzU0OTBtUmFzdnphZUMv?=
 =?utf-8?B?OFd6VFN4UExYUjltYm16azZWR1RMYU9Vdkh5bVlxUDhMOUhKWU5PQndjTTl5?=
 =?utf-8?B?enFvQjNtUkNqMzlXU1drUTRRc29CQnJBYWVWOXdqVWlUY2xQSUV3Wjh5ZVBt?=
 =?utf-8?B?K3FGODdyTGlqQzI3My95K3ZyYlFEc3Q5VUhWVkpPdzkrWFJSeEJUZlZ3UlpQ?=
 =?utf-8?Q?tIPOOZR8HRHPKyPyo/naS+yM+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fjNh04JIq5RIhIJGO7zWLQ5PjyOoednv+oOPpbBwlQTVXForIhHIcIC7TlWWQyO5sH4tYOkAdaXL9weOcBgo8t2Zcd9o5/RKUn8insFmjF7zJTIBOKJ+2iet8Gkm7/2n1mbJhZ/l2f3KNcWUyiyo0wPgSS6BKNJUT5Ju446VjYU3QNfurJa8+hwgy/sFtKPgg3zpE45Zub1s7kfKvDVNN5i3vOFb8m2lw9am4EtrvTXXylyXWy6NbL36nBYlnKPt9YXPKuzyGkXz8n9AgRf8QRsAMjFMRYp02mP4C0O80a++JSfMrK+yQAF5xcmucyApCn32kiVhXfreW0ug18s+ZVkIEIxejajTXCruoiGSM3aRcKiVqxrkfeniotlN87w1QqWFts0InUmnEspdh1SHsfzarC8hgW+h/kmyLrg/3tEU4HucFZvLhR7z9HbEHoOJvqHLWf7IodW5/iEogFXE9agrGqJkFtJa4AXzwYoq2lx+gr0ElWfjm8RX32U7G5zZ2n4Nz8QcllRoQ54WffXXqhqTJyaRHrm7HpE/ZHY9YOowlm/aQros38sdLfgbfMY5fKx7km3Y5jlLwkZ0J+06L4++FmiK0G7FgMPb6AA7xLc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396490bf-a0fc-467b-1264-08dc33117c06
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 19:15:37.0211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ieyWhqAS7dXMDQx71clVxPduxWp0+Q0Gxtd9St77sSI1x7fB99581UrnN01vlTz2D4aw6OpZgW+SWX8CvaqoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5234
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_06,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402210149
X-Proofpoint-GUID: tJJmCJknyKsTqVo80g8Bg1PbZCfthfht
X-Proofpoint-ORIG-GUID: tJJmCJknyKsTqVo80g8Bg1PbZCfthfht

On 2/21/24 6:50 AM, Mateusz Kusiak wrote:
> On 21.02.2024 00:15, junxiao.bi@oracle.com wrote:
>>
>> The thing is we can't reproduce this issue at all. If you can 
>> generate a vmcore when the hung happened, then we can review which 
>> processes are stuck.
>>
> Hi,
> don't know if that be any of help, but I run below scenario with SATA 
> and NVMe drives. For me, the issue is reproducible on NVMe drives only.
>
> Scenario:
> 1. Create R5D3 with native metadata
>     # mdadm -CR /dev/md/vol -l5 -n3 /dev/nvme[0-2]n1 --assume-clean
> 2. Create FS on the array
>     # mkfs.ext4 /dev/md/vol -F
> 3. Remove single member drive via "--incremental --fail"
>     # mdadm -If nvme0n1
>
> The result is almost instant.

This is not the same issue that Dan reported, it looks like another 
regression that Yu Kuai fixed , can you please try this patch?

https://lore.kernel.org/lkml/95f2e08e-2daf-e298-e696-42ebfa7b9bbf@huaweicloud.com/

Thanks,

Junxiao.

>
> Thanks,
> Mateusz

