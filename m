Return-Path: <linux-kernel+bounces-119060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D886D88C384
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8982E73E6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C255574BF8;
	Tue, 26 Mar 2024 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eCwMBf8/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ha2OuJxk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32177175F;
	Tue, 26 Mar 2024 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459966; cv=fail; b=GV+8Eh6ciQ0Cw67Vd5f0CLdAIfvh7u/A2h1jwuxYHgQocZqvkNWu/qOaaa50PWpQeoAaB2V88ULXJcS0B7o9hsOB3X3Q2aKhtuyGMBhJRBDQ1MW3eU96LgaLbOIrmF/fWNJATxZLJsH5eCLAOpw3OzOsBdIO2laX2TxD1MQpNzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459966; c=relaxed/simple;
	bh=5wR0NFf7W6qgbWV3fizxMtSSsl6MW5CU70kMr0BqeaU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YVaHL3ijVcuYmpPnCQtUzhTV6k3biYp4V9Bf81aU0hQisC1m8XbcFYLIal1jXWnxoleF+/oMnruRHTIu3lgc9YpgR42gPIpHYexsiDoYYRPSCuXs1bFazednkUOggD3qOa0GkwvM4zzPv55EkFfoMI5fVI+Wdee9EHIZQTsz3lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eCwMBf8/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ha2OuJxk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42QBncQ9002482;
	Tue, 26 Mar 2024 13:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ZspF6n0JmYDCIW3dyGBm2l42ulP4hkOv63M4osAjpcM=;
 b=eCwMBf8/9DG5Xayvm5Rcj2hXadigA4gkiDyPo8DEX/HVtqVfdgdW1owFH3FajAJxXidV
 AGcGVRoSbLFKCNvxOmHhHglNwjrQc+2h0ebBoUx9rx6OD8KKNVmILat5tsJ73WwQrLhe
 2fFMOGhkV2l0M9+U0OyAth/mnehJY3EDL1UNcG5Tp5DeH14EdG6MCaMzuiqiyfbxntvX
 65y6vTpcHie2bWcQISJwx7jNBZjYI6fGpZnV+6YQM65sedgMkKI06jAGMlK0+gYSupa4
 w/AVtfPE+zrkHA/KnSAywA9qbiKDdhn9aok44uKsRMxfwh0iFFKa+Uve5FyFMOIes9J4 kA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x2f6h3wng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 13:32:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42QCMUlA013376;
	Tue, 26 Mar 2024 13:32:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhd8gd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 13:32:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0S8g95oOvhA71JbO3P0de3VjFXBnppIumfQ59S/eJmhF6MbjNkuLdSnE+Nc/KtKtJGk58l5NAzLYuItzDyaNcz9QKv8kJepw1vEdDxawlGiY2rT68z/VJx1ssYC6lK2r0T1tRVZIBAzd08VEGeNH8UWQm7AinuTDsT68UbgkugB2HanK6VIqm4YJUIbrAs46z8MYPLvQpywNAt0MGVkNBy1EuXtyF+OOwjP9cSB05lkEIFTZJ3tH+XvUt5OJ7AJDQMbMsFslOVUy3pkpeJef7Dimi4rxPSzm3R5xa6N9D84y7Wxnbx8FQ2OyF4qouIjZeueUf7R8WDAgrOCdvI4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZspF6n0JmYDCIW3dyGBm2l42ulP4hkOv63M4osAjpcM=;
 b=g4i0l7xtfFWNsfNzovMgLHKf5yCmcXHpRhmUNXVC5a50Zog2ytRddhorpRxzmsZR9myzAYyKgRFwehpVVLfo19zIQFZ/p9A1OSGj9gyecYnS4POa59WEyi9wpFub7TCEMqE47aNImgiWHvQZH3qD7I5OpZCZ0rpH4KCq2KCRH1EDg69PGRPrMUCe3oGqZRVpm169PTfJgEbZT/grNO2kgV2qXjNXEjd1mIfhuQV2ZGc6CnbJDVS5Jdfj/poqKehPykYVhz8Uxt2guoH34mZzADejkv7J8KGrUBQ8WKCi+xhtSYWsEIEVHKojD3EL29xUWt0htz6dz9tPRLIxG2s/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZspF6n0JmYDCIW3dyGBm2l42ulP4hkOv63M4osAjpcM=;
 b=ha2OuJxkulGgfKXwvONZ5BY4a+chMszvtXct8opIASlkk+ARZZYGiHMVJ0vDT9rmcNxLDwe4v90jf7hpLm7bEM7vsdoMj7a2Ky2rnChUX21TBjNe0wL66deCh2PFQiqN8wD53cDJCXD+7DBVNpkQgNpVa4SO1DTg24QVjBLQ3tw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4749.namprd10.prod.outlook.com (2603:10b6:a03:2da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 13:32:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 13:32:13 +0000
Message-ID: <0ba9914d-7060-498a-beac-2b19770e1963@oracle.com>
Date: Tue, 26 Mar 2024 13:32:09 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: libsas: Allocation SMP request is aligned to
 ARCH_DMA_MINALIGN
To: Damien Le Moal <dlemoal@kernel.org>, Yihang Li <liyihang9@huawei.com>,
        yanaijie@huawei.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@huawei.com, yangxingui@huawei.com
References: <20240326124358.2466259-1-liyihang9@huawei.com>
 <5b5b9392-7fd2-4c87-8e41-5e54adf20003@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <5b5b9392-7fd2-4c87-8e41-5e54adf20003@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0456.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4749:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	INg5kCI/6wr5tAxkFuSmshX12TlbWDTv4FhrrAsBUbjsYDo3J8g7L9I9gp3xUl1fH/dS2Lwz2DMzscsES/dSlkcLtum20QD9TTZODyuCK53ysgzmhulsFC3UV28MC9Gy9FO1fWrBDgQlUCOfQBWoRyuXUilxdq+ic1lpaavAtpvZV0iBA+lYGlnbBF1h5Wk24ct1soWjltnv9VnQj2kcJ1j0DKm4AdwtYuAtMJ2q4yJJLfVSaC0u3ZNxpkQ/4wfrEw9Key7Q49mhL61kbbhIZjacT8n7YeW3jbn4Ksub9u57OsjHzNqeurRxEtKrCyiqXIWehp7sW+jPPqMgCSvA43kPU5S5/MBK5pUT6E2/mCuKhgY/V8n4p5L6REvmiFe7y+7yg5egaJuq4WGedXGA2zIoLDoI9aV9A0qngqX+MnT8bhGoOx/W66CX51OwWgZnOs1sdSHtkG/PBJ2MMWeT0qBu/lwo3fOOftzr1iLxY231Y+ilYfRM+p2qM5/BloW7pGu+5BgrDzHKyYaRBg4m9arNMLJycFi6m2S2rKOzdH7BqMK5b+Pycj73elSiWPRBMgPnZEs3KZNUZRbheP+XkaunV2tG+Nj9ZJqCx14j+WY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aC9VTnlLRklqUGRhY3JrWU80clg4Rk45OHU5ZDByYlBFSnRCVkVCZmgzaVMr?=
 =?utf-8?B?QmExcE1FVUJEaHU1V2lGeitOSUI4MFlFSWZxbDcrYkM5UVJueDV6S3FGOXNt?=
 =?utf-8?B?SDlaem14SE5LK2M3TGFybWhKaEtVY3RSbWtLcGFneXhkZkxFK09lOUlOK0pC?=
 =?utf-8?B?M0Z4NldxV2p5U0kvLzYwc252NzgzNFhNVmJjUGhUWXNPdlpsUVpzMTBvYWhi?=
 =?utf-8?B?dXE0dzJzUEliemZSU2xRL0ZJMlJhbWlsRGJ1RVAzMTlva2JNbnhyQytMcUtZ?=
 =?utf-8?B?OTdRcUhrMXRUeFFnV296RDN1MTVrcGpyc0ltTXI0YW9RdzVITTNlRDd2K1Fz?=
 =?utf-8?B?S0lTb1B1WDR2YUViQ3I1YU1wUFR6MjE5NVdCblZEVkJ6ZTdZdnRMRkZUMlk2?=
 =?utf-8?B?RzRnRE9JQmRzeW1XUm12OHBoc3ZQVVVxcU8raVRXV1lZaXRmSFdNS1UxZVFE?=
 =?utf-8?B?dEZGM1VMeWtTMzNVOVQ4L1FhUkFFYitaemhWNHlaL21wTDY1QjdpRnBlbFFh?=
 =?utf-8?B?aW5qUnl2WmM3YUZwUitDM1BxdTZGOHVZbFd5Vm4zZGR6QXBLanNWdXZFV0d3?=
 =?utf-8?B?UGl3TjFlSXMxbUFmMHpnYnJzQ0l1VjRwSzRjbGIwTkd6aTluaWFuVDhYMFA0?=
 =?utf-8?B?YmFKU2MweWxyU3k5SmZyZ2lBZnpUVzVZSUp5Q1JlYlRzWVN1SWtPU20rZ3la?=
 =?utf-8?B?SWtJc1Vwb05yR0t3UTdsV1FPQTdXdDZkdWpoNHdnQm5vTXU5RDFNaTdEWHNM?=
 =?utf-8?B?L3VzUytMdXBTS094R0IybVV4Y1RLRFB0SVNxR2tMNHpUSkNiSml5R1Fkbjdx?=
 =?utf-8?B?U1dsOWpxbXJwQzVZT25id0JLeWVocGdzYXR6OWdVd1c2QWV2QWc0Vy9lVXNy?=
 =?utf-8?B?aHhJZzJWVHhTY0d2Vk12OGxXS0RndXNkMXoyeExPeDRMRFBMUDJwaFJVbnRa?=
 =?utf-8?B?TUJLVXh0MzNQRDdUYnhPeUZ4ajFvdWVmZ3IwU0RjSStIV1RoTjdESnllSi9H?=
 =?utf-8?B?dVJYODNjOGw5Z2RrVWtvNlgxQVNTRmp3MnhzZU5lbnVVL1hpRWI1OTBFU2tN?=
 =?utf-8?B?QzlVY3k0M2E0UXNZbDBXQWtWVkpndWdZK2NNdkxqVFpBTjJBeE9kT0tnWUt0?=
 =?utf-8?B?a3RMeTVRUUlEdU9sWHErcTQ1eHFOM2xVWkhMWDFnQWtnTU5wV1pycGVnYWZq?=
 =?utf-8?B?OUVTYkdVM3h0UnVjUitnSEMvR3JuVFVYUU9YOVh4RGRnQ2c5eldLSkREQTJr?=
 =?utf-8?B?NkFIZVNLdXEwMlorSDNSS3FNVkwwVEhKWjZ0TUVKYzlHVmZCZW1hTWdwOFFD?=
 =?utf-8?B?Q0M4clpnajlJV29zNVFKR21JdUJJRHFvb2lpZUo5T2VaWjlFK1Q2WTkrUTFK?=
 =?utf-8?B?MnhHcFZZT2hSSUJrWFJ4M0JJQ012OHROb2ZCREluSnBqenZVWkhOTnRBVmZy?=
 =?utf-8?B?blFUTDhOS08rUmlvaUQ5OE9PNlNjd04zYXh0dms0OERHa3A4NE4wcHlrSzNL?=
 =?utf-8?B?cExudTRYd1YzVElKT0hsbWZRaytZZDB6Mzczc2sxNDdqcU9iamtjM0lPVGZY?=
 =?utf-8?B?S0ptd0JCMXpQT0ZsTGtBM1owdFhGanVXK0M2Tk5JWWVYeE9zaVpGbXlpcTUz?=
 =?utf-8?B?OHBZNkcreVpXU0l6c0pPckg1ZHF0UGpIZDJ4bTNveFdSNUgzYmRndGVCb2l2?=
 =?utf-8?B?My9WdmFqbkZlaC9kYXpFK1dHMFp3dENwN0JPeVJ0aHQwa0ZkTGI4VmtxVW5Q?=
 =?utf-8?B?L1IxUWlpeDJ5bGc4Q3JzZnBDUjE5VXhjaEp3YmorMXFmdXp5cVdHUTVxUUpM?=
 =?utf-8?B?QVIwTXVFMmIyV2lGRE9CckljN3FQS3VWSEpTNG14b2IrcXVsb1J5VEFkczBv?=
 =?utf-8?B?MjlleThKckZvYWV0eXNDcmNXaWZXbkRUUG41bDU0b21JbVdrdnF5OXY3aGUz?=
 =?utf-8?B?MVpuQTBIbkhxcEJBcU1qOFR4dkg3bElDa2pxU2R2R0xPMlU5a2M3Zkg3dXJL?=
 =?utf-8?B?emJLeHhnYUhweFJsVnpFaFByeEVLa3I3U1R4U3JoVWRKRjVnL0Njckpwbmdh?=
 =?utf-8?B?YjNOZWFBOFFDQWJWZElDM0dZV2xwb0dCWk1RK29HM293WTNDZVU4aDFScjQz?=
 =?utf-8?B?Njd0cVl5VzNuVG8xWktFck9CZEoyOTMxTDVEUStqVHhaVVdBMXFRdWRYVFdW?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pNAHP/EcOzZCZokot6dAr49IcGDmcg/dGc8nzSPhNoAilQMp5kU4wXtbLX+5LTHjJpJMy6Ks1w/xJm/vkr6qo8X0WHoJFgrM1XHI1TPNgpUz3K25mN5kXFMdHbNgB62OIVMz7cESlhyt0utYVOzPofRVIbjv0MdISU/FiEbqaKtsJhvc8oMOaV5w8iCT7PFnuvJ0eW3Wo3VappHw1oIIgZFSivEzo5Pv+7Hn3onJp2J28E5oJHwV35+DtW0KLb7ESWNKeI6EO7R9URCuD8dIeTUHUVnN9q3zM6DKnzNCt9FVyp4HpA1gD6KqN+v6Bo19Vnhm9SG0y7Fb9cgxkCYnPML60XPZlYXZzun8cMsfTKrb1fuIRep5zQrBEGwbF3NJ2sFa/PPNPF21NIwqHnG86hd36/6D0tv0FBaf3AO5JUK1DtDavIITNFOej3XNK7xUESwuMnZ6A0GxIBvXFx+1cVbcMWtg9PPZtKGlkd6ubBRP3DSG5rzsOoch3VJOQu8Faird90bkgIGQGVq6dcffrzD+gCBZy4g8SjGm6bOTJ7Kzfyqba47EiiVOfyof4zMvkxOWzNAFmW8mDGiYGW/kQ1PWau4l3x5eYfop+bBnJhs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae43ae57-3e76-4b0f-3e4a-08dc4d992574
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 13:32:13.5581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snb4D5+JoX/rkOa8I4wo7nd3haeCtLERdUnpZHIpcCGmdRMCJy0ALmVyEjmBfHFzH1ef5bYcF9vIPZeZnNyIrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4749
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260094
X-Proofpoint-GUID: ChhFw9B4m4KUkrBajUHZY4OoYdUIRFym
X-Proofpoint-ORIG-GUID: ChhFw9B4m4KUkrBajUHZY4OoYdUIRFym

On 26/03/2024 13:14, Damien Le Moal wrote:
> On 3/26/24 21:43, Yihang Li wrote:
>> This series [1] reducing the kmalloc() minimum alignment on arm64 to 8
>> (from 128). In libsas, this will cause SMP requests to be 8-byte-aligned
>> through kmalloc() allocation. However, for the hisi_sas hardware, all
>> commands address must be 16-byte-aligned. 
> Otherwise, the commands fail to
>> be executed.
>>
>> ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
>> operations, so use ARCH_DMA_MINALIGN as the alignment for SMP request.
>>
>> Link: https://lkml.kernel.org/r/20230612153201.554742-1-catalin.marinas@arm.com [1]
>> Signed-off-by: Yihang Li <liyihang9@huawei.com>
>> ---
>> Changes since v1:
>> - Directly modify alloc_smp_req() instead of using handler callback.
>> ---
>>   drivers/scsi/libsas/sas_expander.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
>> index a2204674b680..941abc7298df 100644
>> --- a/drivers/scsi/libsas/sas_expander.c
>> +++ b/drivers/scsi/libsas/sas_expander.c
>> @@ -135,7 +135,10 @@ static int smp_execute_task(struct domain_device *dev, void *req, int req_size,
>>   
>>   static inline void *alloc_smp_req(int size)
>>   {
>> -	u8 *p = kzalloc(size, GFP_KERNEL);
>> +	u8 *p;
>> +
>> +	size = ALIGN(size, ARCH_DMA_MINALIGN);


If this is a hisi_sas requirement, then why use ARCH_DMA_MINALIGN and 
not 16B as minimum alignment?

Or are we really talking about an arch requirement?

>> +	p = kzalloc(size, GFP_KERNEL);
> 
> Nit: why not:
> 
> 	p = kzalloc(ALIGN(size, ARCH_DMA_MINALIGN), GFP_KERNEL);
> 
>>   	if (p)
>>   		p[0] = SMP_REQUEST;
>>   	return p;
> 
> Otherwise looks OK to me.
> 
> John,
> 
> Unrelated to this patch, but I wonder if the GFP_KERNEL used here shouldn't be
> GFP_NOIO... Is this ever called in the IO path or error recovery ?
> 

These should not be called in the IO path - as they are management 
functions. But I am quite confident that they can be called in SCSI 
error handling (for libsas).

Thanks,
John

