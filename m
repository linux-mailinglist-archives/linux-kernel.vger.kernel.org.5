Return-Path: <linux-kernel+bounces-102677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D05887B5D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A36BB2305E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8D41FB4;
	Thu, 14 Mar 2024 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JhFQMfjI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZIG4embx"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7147FD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 00:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710376725; cv=fail; b=M1Ch4Pcbaa+IyR/Lcq5UrM9miG8lS4Jua4bigd9TLv0o9wq4++sD9fj7U9xk1On1v+1S/YOhpMI32fFwtLM+974w+hA3AEf3kHkUAH1icOWHAu7QQOftssVM/4Cqz8fdecjFVjZle03IDoxAfOHMceVhw+Da8TSISHoytckaqYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710376725; c=relaxed/simple;
	bh=S/kJTxUJZWpD5TI1UWUuEYQGsQutvE5rR/H5c+kGbW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C7zjysP2qUOAp/Fos8auUUIrrZs1qc+A1+DP83+BTMWH5VJkZ2USqAZB77TYYPIpXpi/htZHCfTZuObh+aCFCJkIvL823foqhbGsymQsxQgu7rnZ28vZiEESBXFLLUKEYHhwVOkkujEiIXOilLFzUzwXt3vq881vDThw1BNMHLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JhFQMfjI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZIG4embx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DKx2mX030097;
	Thu, 14 Mar 2024 00:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+kVXGDpwrS6fgxDatZi6qhL+uGbrufBXKWA5cLohkAk=;
 b=JhFQMfjIDA2zZVBxEpOqG5MuruhgJC1Hcmvl+qnU6BhccK3PCIGt24VmH5e2+JCcVXFu
 9Ed30hwC9s6LuLsMNw0KJAx7WxIsH+/zbgydmPWu5MAzVXgOUfKLd+wHt81H7H4UKCLR
 JyseIRyoKeqc7pEfuUKqgNvP4frpJRv1FcDNMeTYOcWd59Vv6mdMTRm66Fzi0CRSYLoz
 0QGIIuCnxZdjGqQBs6GSX5UwYm58ev520+aGe71tsF2kEG6aXDpi6/53kMhez/LtWESo
 /t24YqimKpiWTWmntGIlci6UE5D15g0NoC5p3h7U4mdgB+V8vRZxU8OdZ4tbE+US80Uu TA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrepd24t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 00:38:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42DMSRg2033732;
	Thu, 14 Mar 2024 00:38:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre79cdkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 00:38:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgVnu7lOgljVY+d6h8nthYsZ4xeH8ZV27FVlWJPKAnuGNgNxt/GmbWQvLmZ1SkC+UEng3zxTsvy2PvXZD52s8HrBujbryrGWqMVkh3PP8gk4GG0P6byisCmgahpCQizv1WV7wlU/URePVjVjBpZVWEf8vrZlsQSa1k/C/QAz8APoKreazMeQYgG+9jljJYjZEiZe41fPW8x6BjTJlQTbtGCJ2ULZoKbtaiEzSKyzgKzh9XwFWiaWKPKtlmy2HIvTFvHRE1+8BDCc8XbtRVNWhsDPwzg+EkFjekfkuY80EBRnxEzs19W5iU/WQCtc4/PPMXdgjdCRVhYLC0IsmEwesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kVXGDpwrS6fgxDatZi6qhL+uGbrufBXKWA5cLohkAk=;
 b=dfEgVFuRn4rKSfjGLMOkZ597iZ1wpG1vEva9BCTnDvwwXCq2XbI5KivCZ1aTaDoei4MqAbj348Vrfa47Z9o4DIGr60v/1YWCD6KfGoKg3m4Y3bnK7kVgpDBJcXYbUUeqMBVI+UJoLv6COFvC9JAPhOrdcCtYPo56a1iiVTu1e2WTynF8rFOVzi/O5565n2wMwc9NTAdIfLpgH63HKE31+gdNso/cDiJ/KZcWOpxD6BxDan6tlbqcALU/DnDdb52eGhqwf9kWdLOB+eMimBmkYOivg0nkzyvmYig/kLa5hgCv5M0eIYj6XK1OTLJSDEmgBRqj/NAqfubA8fgcR2xBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kVXGDpwrS6fgxDatZi6qhL+uGbrufBXKWA5cLohkAk=;
 b=ZIG4embxyneCehx/xMhsahRSTZs+jCiWP4ZMCCf+eJE9xT52ImuK1FqluNPtIqV2IOeehejFe4QZOkPwGZR8Pq2Psyv3SctaT3/axGDlqk1iG3by7oE6lHEnwvKSx/GMl5oGjhTiTqN/yUEbRUUI4HTYeI5IbCu12xdTmomRcI0=
Received: from PH7PR10MB6379.namprd10.prod.outlook.com (2603:10b6:510:1a9::15)
 by SN7PR10MB7102.namprd10.prod.outlook.com (2603:10b6:806:348::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 00:38:23 +0000
Received: from PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::de1f:84ac:fe86:2865]) by PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::de1f:84ac:fe86:2865%6]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 00:38:23 +0000
Message-ID: <9578474c-2e46-4d3e-9a2f-1eaeb9bfabbc@oracle.com>
Date: Wed, 13 Mar 2024 17:38:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in get_slabinfo()
To: "Christoph Lameter (Ampere)" <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc: Chengming Zhou <chengming.zhou@linux.dev>,
        David Rientjes <rientjes@google.com>, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com>
 <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com>
 <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz>
 <55ccc92a-79fa-42d2-97d8-b514cf00823b@linux.dev>
 <6daf88a2-84c2-5ba4-853c-c38cca4a03cb@linux.com>
 <e924c39b-7636-4c34-bfe9-603cf07c21d3@linux.dev>
 <b8f393fb-2b1d-213c-9301-35d4ffca1f50@linux.com>
 <347b870e-a7d5-45df-84ba-4eee37b74ff6@linux.dev>
 <1a952209-fa22-4439-af27-bf102c7d742b@suse.cz>
 <cce26aef-ab3e-447b-8b33-5ecd78bf747d@linux.dev>
 <2744dd57-e76e-4d80-851a-02898f87f9be@suse.cz>
 <036f2bb4-b086-2988-e46d-86d399405687@linux.com>
 <eec445a6-7024-40b6-9d4e-7fc2bc71cce7@linux.dev>
 <1eeb84d4-42b1-d204-ece1-b76bfbc548bf@linux.com>
 <0aa3ce20-438f-49fb-8f04-4fc1dbf49728@linux.dev>
Content-Language: en-US
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <0aa3ce20-438f-49fb-8f04-4fc1dbf49728@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To PH7PR10MB6379.namprd10.prod.outlook.com
 (2603:10b6:510:1a9::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6379:EE_|SN7PR10MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bce44a3-13c0-4d73-d7e4-08dc43bf0ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UiGgym/Sbo4jrW7em0UICpuwWYDwsuY/58vii/N++Tgqag9EaCfoLQFMff9s1TPEDTr04aeQQgdW/XJaJAmvJJnpencTF/SX735c56Vif6SS0Eg6iOWLGpoQlmUPr8jSSeoj+GRTj3QoW3y/pZl+c/NLSBUMpttANPg7uZ+YaaMIGYxnXb+hDU60NM4oSwhXO5pCCf3cISdO+trliKtXi+cFYMdH0GIFkRtuxJatJ8hOlKt6Zz85MUHewZcZ5S6cdSO3CChyH/BuuQXVrpnCOOKBDGkinlh5oEvOptHL6QputAlwIaVO8Ie+CxRS+uml55wtDcSXmIwWUU9234fxDCBrbw9Oj6nSWj7B/QQLFJaHDOv3PpF2TSu+hbMdQo8myGYoz9QuIooaaVZYXGy6gaJxz1HHNVNVzrP7eyhbkcj4iWFHnUK57pKfGZtWiLhC6w5eVQvBFCXZ8dglouHZOANH2ivVyFH4HCLQEeudlaOM1/unR0gOtGFLdNIikkjUPUGd730wYvOFSMGAYtn1NLIoawU6MIUmmLKniYUQYkh0SKxcIUTXyOze4wmhqmuNzjFhfyiGFdph5QHr5bw60VikwtNGBotjsJx3so/+Lke/HBbXBtgAuch2oJHlBwV9X4BLz6RAu6ISS6mX40LaBpi0vuB3j3/gWvPcJcZXa2s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6379.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K3RrQ1NweDZYWlJON2xyc1AyMDVmNGFxV1BPajY0cFJORkFzZG5DcjluMy9R?=
 =?utf-8?B?SnB0bG1FeDhQVUFRSTRETVNsRURRUUJYY20yN0g2a1dHSDkwd0xLclpzV2Yr?=
 =?utf-8?B?S2NVRTlKRmdRaXFvcm84aWNua0M3cXNJYm1xSjZ4NnZDckc0aGlkQStCOVll?=
 =?utf-8?B?ZkFFbGxaMUEzdXEzd2FRdXBUVVNOZWxIcjFkVGlyQyszaEl1NWxXb1lhRzhX?=
 =?utf-8?B?RUs3dFhQQ1JUUXdtNFRCK1JmWVVLN3lSdTVYeWxXT1B5aUdzTTBwMU9rTnVn?=
 =?utf-8?B?TSt2eU5lWkVDZkdlZXZKMUlaeGdEWEdtTENoRXdPUUJ6TnRJTVJkRXBBSkNp?=
 =?utf-8?B?K2xEa0k0aHp0NUFaTkM2dlVHYWxYWUhlcVdJNnNQaGVDVFRjQkl5bGZzZzkz?=
 =?utf-8?B?VlM5Z1pSN1NuTU9ORndSTFZQOFFneEdSbnRhdk9HWkEvLzUrMHB4ZFkra2hu?=
 =?utf-8?B?bDJ5NTFwUXFXOXpMN3h1WTFhRDQ3Y0t6UmVoL29YZE5PUWlsTTIwU2lWOUE4?=
 =?utf-8?B?Y0wxRlZMWUFzQSszaUpoQjdTTk91KzUvNUdhVlRoS3JSSHJPWlFJbWhMYmdM?=
 =?utf-8?B?MC8zUmsvUGpPU0R2eG0wRWxKM2xwbkhVeWxmR29sdXY0dnVtYWdrWm1CQVN0?=
 =?utf-8?B?aUZzV3Y4SlZXRDJta1N6b1RPY0tUVUc4ejZ3S2lKRWxEcHJ0d2c0UllLYWEv?=
 =?utf-8?B?Wkw3NlU5dHV5cUc4SGw5QVd3dmgxL0RDOCs1WHJGVmpIRU5sYkEwVDdEdkIz?=
 =?utf-8?B?WnowZHE4YjZCbVhjVkRQVzdrWk5jb3pMOGhGNDdBV0NLY3A2dW0zSk0wNkZn?=
 =?utf-8?B?Nm4wWWhtQ3JoemEzV25PTm5LUG1VVFNRZEpuL2h6N01OdDkvbHFKRUxzZXJj?=
 =?utf-8?B?WUxwM3RqMGZSV0dISW16STAzcmE1RWZjVGRyUkZucXBJTTRJQTdLb08wL1pR?=
 =?utf-8?B?UU51a3BNd3lTZmpEa09yeWdkSnZubkRWbXJFZXhnOVZxaVJPTm92eVAxcUUy?=
 =?utf-8?B?eTZJZ0tnTHUvTDAvbzRYYWcrSUhnUlNFdDRhY1F0SS9pbkhIMk1SSWNtbExu?=
 =?utf-8?B?NCtRNEMwUXdxK1NlNk1MVlRPalc3SFd6SFdjZ0NhWjgwZG9MRzNJT0pFZTRh?=
 =?utf-8?B?RjYxRVNsenZNR3RFSGdaMG5haldVdGhzVHp5RmYyRHFVUTBmYVhKcm9zbEow?=
 =?utf-8?B?bGFKYXdHKzhkYlhqeTFEZ2RpMG9paDJsb2h3Z3pSODBoT0pBTlZTWDdyVkV6?=
 =?utf-8?B?TG1nQlREdWlRTmVsTXFuNzBOYnd4eithMm5yQTJROHIrNUpudmY5Z280bGpu?=
 =?utf-8?B?TkY5Nk56dGM5VFhhS01vNGZLdzVaSVhtdmZXY1BZcm9iSkpjR20wNkdxcTgy?=
 =?utf-8?B?bHREaG1nTGpBTldNZGNheCsyYVRkYkNPelFha3JsbjNKZUxwRGp0bzFMQkRP?=
 =?utf-8?B?anNsa2Y1T1AyZFJ6RmRSMkRvY1Q1ak9PcWFIanFmZnJjNW15OTZ6cEJsSVBX?=
 =?utf-8?B?ZmIwUGsxK1grZGpsL1hLT1gvRkNodmVURUJ4eC9EYkFDNHg0T2hkYWYwVllD?=
 =?utf-8?B?eGprMWhNeDVzenhLN3hiZzQ5Mk1QQ2o2c0dlc1NKUFIvR2RoeXM0VkVzQmht?=
 =?utf-8?B?WDJnSndEZGFsTS9Rd2ZlQlZycFl3RUFsMXRCaFFHdlZKYlBmZ0VhbHUyNUZY?=
 =?utf-8?B?M2FZQUVIdXFKL2U1ZnJFb0xadk5DWTVPaW9BNzAzZWtxM3RER2VhRzBhU3pv?=
 =?utf-8?B?cHhWa3hYREZhS1hkbUp6SG8rdlpqV1p1aUxLb0tiSkdnVVpiMGI0S1lRSG4z?=
 =?utf-8?B?TEE5bFdneDdPNnBBQ1p6eUxTZ3g3Z0ZzSzZ2OUNXQmIxbURLeVNwS1o4UENY?=
 =?utf-8?B?NUVOVjdNbHlQVzhkMTBYbEdBejl1cVdyRThoR0traXFoa0tVZCtxQUtabEhn?=
 =?utf-8?B?eUV3eG9kS3lRck92bGhQZXkxTTVRYVlyS3hXbGJ2MDJmMFJSaFN5OFdpWmFX?=
 =?utf-8?B?QW5QY3RYeFc2WFJtN2hvZkVJQS94TWF2ZCtoTS9jQk94MHBNbS83SkxycE9E?=
 =?utf-8?B?WlRENlBJdVVRS2pBZlZPZW9VaTBUdllXdXA1aGJJaGNiT1F6SEZzRDZLQTBG?=
 =?utf-8?B?RmZJZEFXMURMZTdsUElDL1dId1RmQ3JuYjY5RmU4RFA4S2dvQTg1Q0JiYmwx?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4YgYUlOSbBAjidQCwRGp2wg/vJBKLQG2WldkpJDSWueWFU6jyE98JNfdcjZkWnqCRWfkKCn0QtCNCRQWKB8m/dHZLUEJOV4D5dKW6ZPtSCSMgf/n4Et786cNDp3U4mqxMYj9nDQsg/wZCnTr75LhbMQ5E8QXWIbf3iF2NEzgR0+7PZjUhOdpBAk7AHP6JU7W5fsm2SKxXEtE3CspntYp7Re6TZHuNn6+v7HcKIv/ydvl342jVH4ZC3O9PUy/m9MbCdkhIxTRzfa6/qJo04X1Bqj/QWMbht8jtaeddWkErRQUC4W2oDlHDotOGRTRFa7AqYJgIZfyQLnv8kU+naTms2z1PepUoPX7PReUyHK8wFVPT3b1woPfLyJqxv2yYr7UGqrSW8UY/v2Vl6pIUrRTHM0IM/i6wuLT3hGy2w+33lUfcbmoeh6hmYG7uitEmtvJ1Rf8tZIgTGtrJ2nxOd1qk2Xohr9umuq+r1u0UI6yATHZ8v9she0f3Wt8HYPVK83wK1jjQ6EIbeSTTkWDoNFfqE42RjEfZbK2OPpem/dmxl5lNYlYFBBKVqxhI9cOx2jna35af+fe4pzabNqIHc4K0RlZprQZK4REQA6t2DPPup8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bce44a3-13c0-4d73-d7e4-08dc43bf0ddf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6379.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 00:38:23.1579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1mFEpZrQI6kTpuVF8PVPlbuIE8Vfq4cbIZB0hzv6s81bk0v2ypUbjYSNJEjNEUnqHTEEnTazICT7VjOJsYn9vNCix4RKqgd7xe4hZF3rNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7102
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_11,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140002
X-Proofpoint-ORIG-GUID: eF-ndeUB38Y3SYT5YuiC8Q5W7i24-DDO
X-Proofpoint-GUID: eF-ndeUB38Y3SYT5YuiC8Q5W7i24-DDO


On 2/28/24 1:51 AM, Chengming Zhou wrote:
> On 2024/2/28 06:55, Christoph Lameter (Ampere) wrote:
>> On Tue, 27 Feb 2024, Chengming Zhou wrote:
>>
>>>> We could mark the state change (list ownership) in the slab metadata and then abort the scan if the state mismatches the list.
>>>
>>> It seems feasible, maybe something like below?
>>>
>>> But this way needs all kmem_caches have SLAB_TYPESAFE_BY_RCU, right?
>>
>> No.
>>
>> If a slab is freed to the page allocator and the fields are reused in a different way then we would have to wait till the end of the RCU period. This could be done with a deferred free. Otherwise we have the type checking to ensure that nothing untoward happens in the RCU period.
>>
>> The usually shuffle of the pages between freelists/cpulists/cpuslab and fully used slabs would not require that.
> 
> IIUC, your method doesn't need the slab struct (page) to be delay freed by RCU.
> 
> So that page struct maybe reused to anything by buddy, even maybe freed, right?
> 
> Not sure the RCU read lock protection is enough here, do we need to hold other
> lock, like memory hotplug lock?
> 
>>
>>> Not sure if this is acceptable? Which may cause random delay of memory free.
>>>
>>> ```
>>> retry:
>>>     rcu_read_lock();
>>>
>>>     h = rcu_dereference(list_next_rcu(&n->partial));
>>>
>>>     while (h != &n->partial) {
>>
>> Hmm... a linked list that forms a circle? Linked lists usually terminate in a NULL pointer.
> 
> I think the node partial list should be a double-linked list? Since we need to
> add slab to its head or tail.
> 
>>
>> So this would be
>>
>>
>> redo:
>>
>>     <zap counters>
>>     rcu_read_lock();
>>     h = <first>;
>>
>>     while (h && h->type == <our type>) {
>>           <count h somethings>
>>
>>           /* Maybe check h->type again */
>>           if (h->type != <our_type>)
>>             break;
> 
> Another problem of this lockless recheck is that we may get a very false value:
> say a slab removed from the node list, then be added to our list in another position,
> so passed our recheck conditions here. Which may cause our counting is very mistaken?
> 
> Thanks!
> 
>>
>>           h = <next>;
>>     }
>>
>>     rcu_read_unlock();
>>
>>
>>     if (!h) /* Type of list changed under us */
>>         goto redo;
>>
>>
>> The check for type == <our_type> is racy. Maybe we can ignore that or we could do something additional.
>>
>> Using RCU does not make sense if you add locking in the inner loop. Then it gets too complicated and causes delay. This must be a simple fast lockless loop in order to do what we need.
>>
>> Presumably the type and list pointers are in the same cacheline and thus could made to be updated in a coherent way if properly sequenced with fences etc.

I am not sure that the RCU change will solve the lockup problem.
The reason is that iterating a super long list of partial slabs is a problem by itself, e.g., on a
non-preemptive kernel, then count_partial() can be stuck in the loop for a while, which can cause problems.

Also, even if we check the list ownership for slabs, we may spend too much time in the loop if no updater shows up,
or fail and re-do many times the loop if several updates happen. The latter can exacerbate this lockup issue. So,
in the end, reading /proc/slabinfo can take a super long time just for a counter that may be changing all the time.

Thus, I prefer the "guesstimate" approach, even if the number is inaccurate or biased. Let me know if this makes sense.

