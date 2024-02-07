Return-Path: <linux-kernel+bounces-55824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF63484C225
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D831F230EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE4CDDC9;
	Wed,  7 Feb 2024 01:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QjQAZJ0k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cO04nqkb"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0108DDAD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707270833; cv=fail; b=lmDOYLlC+S/Fpx1WETh7B8NC4+V4pjCbAnHKCwKEmoC+j6Y1XaLiWqzhNZYHqfZhllVhx7IUILd0xwSH4qbTgKGs5u/hPkNIRbTls0JYhvA/1oa8bXnkOGKtLiPxv97GBQOcHTLCmzittZ5+W1jN9Fou6P8iXHKNBrsI7igIt3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707270833; c=relaxed/simple;
	bh=T60zexABA3P21+lImwWRDmiDysjyIWegSUHYajwULLE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Efag1jo0YZGMfkfdlq5PEFQZHQHJqBGhlKMa1JKtim4ePS7b/o7SNu1ao7XQ0i/iyYXMDExnEuumaeKZ1qifTrlv75O5WVazaAT9zSLJ8FpSArnsdpWioUHQEgWtBuLuD8ZuLAO8+kT3U6xt9b7OOPOpiC+APzuJmvT2YilyAhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QjQAZJ0k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cO04nqkb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416N4IrQ007649;
	Wed, 7 Feb 2024 01:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ohFdwq5Ib882bTktsRPqNN3P9oX0SurcmCx0Xo3M48Y=;
 b=QjQAZJ0k9FLuV/zTnQiKl8+5tRHRxLnsUDKqeRsgugUJmtVyvFZuDVdd8TKOc+EDKUC1
 1khtv4GUEkYM16Jc4w0QNO6RKM4a3WGJTXy1nGFAVjE+Sqrm14V1pt1vEcrTa3icoa1j
 eBXK56fVy3d3OxgHMmQiWjI8L+J8NZaBh4JUXgI1Kcl6AgQt7amjXlTw02l4zJ4rMBYH
 qwlUjqXwSanD64KVrWv51kykAJwpmmoctxSHLpo7c7eJmh1a4ZJk7f9f8h/6kyjb/6lA
 L6WbmZUG0ZBcfw73spg5FKnHOsPB2tww+ux9MfyUrbHUH3Ki0F1WSEc8aJXCGQrzaeY2 TQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbgbm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 01:53:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4171Ixhp007193;
	Wed, 7 Feb 2024 01:53:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx8hgre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 01:53:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHIDmOpJ+mssJ4pCtI6OrQt90eYOE5e80CrsZ+BNeqHyjoTDznCRDKAlVqAFe+B9k1etCGiYuQy3DuUVvrzIMsewgKDrPQxHM550Luy7SXOL7MUNwVxSnuA2dHvp3QDyJSmUeWisdrr50GRmK6yR3WZ6nZjJAetS0aGCkzVcL9tp2YdGCWr577Uczv4tSRU4rNEEfe6ZFNYNW176J5tkbi7uUcKGS/l4fxiZpz5cllV3cMIXmDvD+xePyE4O1vcPupQCu+L6/kEyE8SiO6ugtFAHbSc772PyDxbT0BlQk3gbo4Bf9K+UVDm63Y5jC1LionzwaoA/J3lZ3vZ1g725lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohFdwq5Ib882bTktsRPqNN3P9oX0SurcmCx0Xo3M48Y=;
 b=jb+AnjYSr4ntbQm5DNVOe8aSEaecHW1wzgf4BIPjDGi5yK6RNZlSJnSGh1bHq1MmR11/i8cgGE0A+z5W10ueWE2x6/ObVI40ACY8eME8sWLFYy/zJJtE00Bv/gDyPNXYY0ENkZgSfbD3l0u+yx92h3vXg9HZ5A03Wr5/ylkWk2veDw+m4cdo9ma5Bgh5D4KLgIg09YqnIxcRZLru1TbEz5yIZOkI6PJFlRhOvqST6b5PqoPzmREyjWvjiZuSVhMftA/e304ZQ8dA9NxIorCWmezg5vBkbKVt+uDIAfxBKaM1vpOqWAwDa0JoA+WfpIQKrhGUdhQH7uT9dLPB3DlTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohFdwq5Ib882bTktsRPqNN3P9oX0SurcmCx0Xo3M48Y=;
 b=cO04nqkb16IVnv5hJvCET3LVq2bRB22LiYBuxsfjzbMKLYccZKXVv5Z7jfFWrajE7n96jypaqOWalReFjZ89WKvk8xCvigKeTw3Y1+ObA8Jly296C/ZvMpivvR1ZEdJwgGhEek13iIiNmnYkC7CrmaEvAW3oB/T0S33qPiR9oQE=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CH2PR10MB4117.namprd10.prod.outlook.com (2603:10b6:610:ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 01:53:09 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::210e:eea7:3142:6088]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::210e:eea7:3142:6088%5]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 01:53:09 +0000
Message-ID: <3a8ae9f0-6250-4a53-bee4-4765024c8992@oracle.com>
Date: Tue, 6 Feb 2024 17:53:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] hugetlb: parallelize 1G hugetlb initialization
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>, Gang Li <gang.li@linux.dev>,
        daniel.m.jordan@oracle.com
Cc: David Hildenbrand <david@redhat.com>,
        David Rientjes
 <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, ligang.bdlg@bytedance.com
References: <20240126152411.1238072-1-gang.li@linux.dev>
 <20240126152411.1238072-8-gang.li@linux.dev>
 <f8c89a25-e7f2-4f3c-a99a-a1945e18e026@linux.dev>
 <277e0eed-918f-414f-b19d-219bd155ac14@linux.dev>
 <6A148F29-68B2-4365-872C-E6AB599C55F6@linux.dev>
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <6A148F29-68B2-4365-872C-E6AB599C55F6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0037.namprd19.prod.outlook.com
 (2603:10b6:208:19b::14) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|CH2PR10MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: 271fd0d7-f83c-45a2-e7f4-08dc277f88c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	E3KuEAY64FaAILCdStXsP/RU7uvHvhRoGBN4TPCVhBL2Dp89eEmhVdxT99IAtrG44wrNz/PKOf5M/vzmbay+YhF5nYtzKh5LxxJS87p/tKmDBUiFhOB5a85NxGtTM6pIb6JiPSMLSfpQE00YbKDvLH/HdNhax/Z2xQq2LOL2IHQdXdmbNOzt32VBWnD3mrhqbpPadvbAzD1B3rG6Zuc+ecF9zXkl+/rp43AgPzgimiBka03yl6QY/Xgu7fONmLROPnvLmumLnUueCMiJEi1G34qtq7YULTHMicyvi0FiMZUFbnH9bb2+ZZHOPN0HRAN+xkchy0TD8C2IUr3h7RPlautCwKxya0OCuYaOXw47DpR0FlPnxp/Z1k/xMGav8ZNV71wBsP+GbtXIf5F9XWfdiUSfScQF1l5xtjPwnipkKRGrWL9u636VEjcfeP5jA37UXsiRZJqlHLs8AEb8Z/wCbh+thVBYEE8CnNbM0WVoC+Ca6WC2yM4v601lzWznQe5bQui/1cqpbVRQ5MlxBra5qubTYydLDD5Un05imtONi2nrOxfgkVr+48AIxl4XpcNO4JQZrH/gr7UJE4r0XU5S1k7NAkge1NA++zD4W8GJTyGIFMQFVyAuWT9T0vjaXLs3NotgW67BOM55r6q00VX4XQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(31696002)(6512007)(6486002)(66946007)(66556008)(66476007)(110136005)(54906003)(6636002)(8676002)(53546011)(8936002)(6666004)(6506007)(36756003)(478600001)(316002)(4326008)(2616005)(38100700002)(26005)(86362001)(83380400001)(5660300002)(44832011)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T0MxQ1JGa3BzV1RwRVNQQUpkM1VOaklHUVplU2ZoTEVtb2FVK052dXBDc0VM?=
 =?utf-8?B?L3BqaUs3TVdXQUNCNTE0TlNIZ3g1bWl3VFlsS3IySWpEU05IeGlnZ1FGZGRM?=
 =?utf-8?B?ejRiY0J5RDI0V3JmblBvM0M4ak5HV2gyNzhzU2xabXp5eFFGdTUxWUdGQXZu?=
 =?utf-8?B?OTBVYXNaZGl2TUxHZkd6eVo2ZkJ3cG9idmVSL1c5UjdrQk5mVlBsMnZEelBh?=
 =?utf-8?B?SEd4VENMMVROa0g5dldFZnBGTFdYR1IzQXN2VjBJYXhuc0hVcEtZb2xSTnpt?=
 =?utf-8?B?RW00cXNzWDZuZ3lua1VvR2M3NEQwckhhTkZXSjVjWlZLdFg1VVZMdWE1a1ZL?=
 =?utf-8?B?Y21UWkpBcURqOHZmOGU2SHJQeTg5Q2JEQkxLQ3l2djJZYmlqT1JzME9rWS9H?=
 =?utf-8?B?UnlCVWl2OTFlOUI2NWVya0lSWHRzeUNEd2NhZGJOU0d3Nm1kMTZsVmw5dWty?=
 =?utf-8?B?ZHNVTVJZVXJOQnNXaGlSK0UzQ3dNYzNIRzZOM3RwQWRra1NmbGRZL1B3Nnpj?=
 =?utf-8?B?c28vSlUrSEdFakZOaDQvMzlTejU5dGZTa2xtYzAxUGJGVkVjbmlTZGZ0OFZV?=
 =?utf-8?B?emlPZ0lyK0hkQS9hd1V4RElmSVV3WWRTY2FhbUVzeFNGVk5xdnZQM1VCeHFu?=
 =?utf-8?B?QndPbytIMm9pWnBLZWs1RWJlNS9LU2gvY3FFOFJFZHNLaE1KUk1CcVM1UnJ1?=
 =?utf-8?B?OE1kSGdWdzltVlE0Rk5laStTY2lzUHRqcjh6K1pDWGhiNnVrRGJqbUpISlhV?=
 =?utf-8?B?bjlXV1JDQnRnRGNmdFlQeVh2QkJlZk1IeE5CL2RHa1UwZzZTRGpmWUVYS2h1?=
 =?utf-8?B?NWVWd0VXdkcvOVFpb0lXQ0tXY1dTYmlsSUZoZmFKSE5wT1FUN0UvVEdaRkxu?=
 =?utf-8?B?MGlTWGJNS0JPRDV4eTY3QXMwUWR6R3ppYzhYVjBFbjhnUlZERGdlRXVHUkVR?=
 =?utf-8?B?aEZQTG8wc005d3oxRXQ4K292TUlYdlI2RVM5dWhSOEx0QWdHQjdtYVd3RTdM?=
 =?utf-8?B?TU9mdTJ2QnBWNGJ6Z1JxeWpJajY4ckZYNDBKWEp0K3lEUXlnYlJDeXVlMTZT?=
 =?utf-8?B?ZDlNVXl2c1FOeU1mL0NJS2lpNks4ZVVjSnE2VnBLdWZvNHdOWFVydnc1dnUw?=
 =?utf-8?B?UVZSQXdHZWpLd2Q5bk9MTnNFUUtNMkdSTVI2cXFRYUpXbVdScGFOdjNWWGIr?=
 =?utf-8?B?djJoWEVrOC93VEw5SnNGQmJjdUMrK2dYVGRWRVo4c1h0L1I5dGlQR1o5bFFo?=
 =?utf-8?B?MWc3Vk5OdGdhb1FNUE5MSG96NUdSNDRtMEc5aDJCZ2RxMXYwRkZINC96TVFR?=
 =?utf-8?B?UmlNaWJ2Z2hENXlidUJYUm0vMWpKWTk2NFI2TngzdmFROHVFbnVuQ2p3RE9W?=
 =?utf-8?B?T2JRVnhGai9WZG5uRkczdUlQUWFoeE5BVVpyVG84aTlOWkl4STRnMlRwRDFD?=
 =?utf-8?B?c1g4MWdwNXdsN3k3ejZwNExYODVqL3ZMMEZhYzBhWGtXTFZxSGprNFZBNk1H?=
 =?utf-8?B?THE0dHk0eEJSUjZVN2l3V3hrZWFabENTZEZrSWRiSVQ4SUJoQ1lZLzRLU3RL?=
 =?utf-8?B?RGQyeGZiajM0YkxTRUJCZ2Z5KzU0bU1sQW1OYVEya0VyUmlRaWNwc1NLTklJ?=
 =?utf-8?B?THhnTG14d0JDVit1QlBNUmZ5T2FCWGtxOWluNGxqbFo4Mjd5Q2xMVWd6bVh3?=
 =?utf-8?B?YnEyNDZ0M0F6QTUvbklYNEsvRk1USEh3WlJEWWpZaVk1SVR5MG5FVFZOZHVJ?=
 =?utf-8?B?bTh2VW9GM01XUHU1TUZzTmdNdFRwd3dZYXFRK1A0QS9ITG5pQUMreThIWCs4?=
 =?utf-8?B?OXJ2b05jYWFlb2JhdUlpOHZCV0tOR2doWW04OVhoOFoxSHRSaXFsOHpxb1gx?=
 =?utf-8?B?clc5bDliNHlKNXVUUEtFT3ROZTdibC9lZzhmQUNJd3RSaEZGQzRrL3E0eGVL?=
 =?utf-8?B?WWtyY2Q1RzNJdlYzUnREYUpoU0JTdVdXbEpGYjhETTNiYnFVeTREeDdrN0x4?=
 =?utf-8?B?cHY3dm5EaUhGY3UwNGkyS1NHS1U1Y1JmekZrSEIweFp6SnV3QUNyVnFUSDds?=
 =?utf-8?B?QW10bkx6R1QxR05ac3crUEw2T2FqcFhXKy9waWFXWmxZUjJla2FGZDQvUGpM?=
 =?utf-8?Q?ODeHO5a3x12XtsPiBuv5ljqLU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VdqDDQeN00kBwqtwTY0FHXDrh8YQH87mNsz+u8W5AnzdHN/XGtLqnLTf4obcS0Yof6RuGUZ0g0EHs9vhVemhqZ0eO3D23Qm5vfKksBQRCaWj55O/zsd1wVs+eny1wPMuhDPbYfhjI0Zo7fliC7SMn8w/lq9DT+n8+lETH/4qnJvdaw8gsdl024cq+Ex2OOGCozQ3MfvuJSbGUPD18gug+lHV0G0hu9TXm/i/H+axBRor4qpBXcg9YMK44vVGW8H3CPB4EjJzIdllk/LUQDIfTfyuRgskMSDKFWlVFvcotcbVf2mBsuILlBNW+pj1dcASnCZHQ1mnpTnCeQALo3Pn6tEYWQq9IdD0w1yZRCdREAnwoGzyCdaMGEc4k7Qw6/CIc8X6+E8m1oIeHjDb3L4dvRuZ77NioUp8Ibas+QzRl2NNLJr96JhI7eFB52IzYQmEkY5vQqy/QPxTSHJfmrF+3W1+6sSguF4rB3xlXon2SH7HBGtbcqOdh6Dtq8sY7OWIIM08TSF7x/E0wuac6kjJ2hWrqNdGY5jq4UNGBeutssslHj8wYXYCyiLCCNPmXJN1kJ4uDeFn8GBaVvwLEdkR0xyXF+eNv9SJIuuZe0KGECE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271fd0d7-f83c-45a2-e7f4-08dc277f88c0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 01:53:09.1346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wyhc1DjIHISkaboDODuUeJq9QY1YWY4n1v44u6YdWTdPA97FXzrGL4vqbzXNJ/sZIv2Tky2zHgjCy5KXRw9dMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070013
X-Proofpoint-GUID: FTqAVpKU25PgDBJqBQSFpj6qcsAPhYaq
X-Proofpoint-ORIG-GUID: FTqAVpKU25PgDBJqBQSFpj6qcsAPhYaq

Add Daniel Jordan.

On 2/5/2024 1:09 AM, Muchun Song wrote:
>
>> On Feb 5, 2024, at 16:26, Gang Li <gang.li@linux.dev> wrote:
>>
>>
>>
>> On 2024/2/5 15:28, Muchun Song wrote:
>>> On 2024/1/26 23:24, Gang Li wrote:
>>>> @@ -3390,8 +3390,6 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
>>>>        /* Send list for bulk vmemmap optimization processing */
>>>>        hugetlb_vmemmap_optimize_folios(h, folio_list);
>>>> -    /* Add all new pool pages to free lists in one lock cycle */
>>>> -    spin_lock_irqsave(&hugetlb_lock, flags);
>>>>        list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
>>>>            if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
>>>>                /*
>>>> @@ -3404,23 +3402,27 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
>>>>                        HUGETLB_VMEMMAP_RESERVE_PAGES,
>>>>                        pages_per_huge_page(h));
>>>>            }
>>>> +        /* Subdivide locks to achieve better parallel performance */
>>>> +        spin_lock_irqsave(&hugetlb_lock, flags);
>>>>            __prep_account_new_huge_page(h, folio_nid(folio));
>>>>            enqueue_hugetlb_folio(h, folio);
>>>> +        spin_unlock_irqrestore(&hugetlb_lock, flags);
>>>>        }
>>>> -    spin_unlock_irqrestore(&hugetlb_lock, flags);
>>>>    }
>>>>    /*
>>>>     * Put bootmem huge pages into the standard lists after mem_map is up.
>>>>     * Note: This only applies to gigantic (order > MAX_PAGE_ORDER) pages.
>>>>     */
>>>> -static void __init gather_bootmem_prealloc(void)
>>>> +static void __init gather_bootmem_prealloc_node(unsigned long start, unsigned long end, void *arg)
>>>> +
>>>>    {
>>>> +    int nid = start;
>>> Sorry for so late to notice an issue here. I have seen a comment from
>>> PADATA, whcih says:
>>>      @max_threads: Max threads to use for the job, actual number may be less
>>>                    depending on task size and minimum chunk size.
>>> PADATA will not guarantee gather_bootmem_prealloc_node() will be called
>>> ->max_threads times (You have initialized it to the number of NUMA nodes in
>>> gather_bootmem_prealloc). Therefore, we should add a loop here to initialize
>>> multiple nodes, namely (@end - @start) here. Otherwise, we will miss
>>> initializing some nodes.
>>> Thanks.
>>>
>> In padata_do_multithreaded:
>>
>> ```
>> /* Ensure at least one thread when size < min_chunk. */
>> nworks = max(job->size / max(job->min_chunk, job->align), 1ul);
>> nworks = min(nworks, job->max_threads);
>>
>> ps.nworks      = padata_work_alloc_mt(nworks, &ps, &works);
>> ```
>>
>> So we have works <= max_threads, but >= size/min_chunk.
> Given a 4-node system, the current implementation will schedule
> 4 threads to call gather_bootmem_prealloc() respectively, and
> there is no problems here. But what if PADATA schedules 2
> threads and each thread aims to handle 2 nodes? I think
> it is possible for PADATA in the future, because it does not
> break any semantics exposed to users. The comment about @min_chunk:
>
> 	The minimum chunk size in job-specific units. This
> 	allows the client to communicate the minimum amount
> 	of work that's appropriate for one worker thread to
> 	do at once.
>
> It only defines the minimum chunk size but not maximum size,
> so it is possible to let each ->thread_fn handle multiple
> minimum chunk size. Right? Therefore, I am not concerned
> about the current implementation of PADATA but that of future.
>
> Maybe a separate patch is acceptable since it is an improving
> patch instead of a fix one (at least there is no bug currently).
>
> Thanks.
>
>

