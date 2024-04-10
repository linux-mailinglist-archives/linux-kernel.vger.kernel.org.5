Return-Path: <linux-kernel+bounces-139254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A76F28A008A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4EB1F27911
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED32181311;
	Wed, 10 Apr 2024 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C/NpLJAW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qvb3j6nU"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890EC13C9BB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712777086; cv=fail; b=o24E8TCkf4eaXgMfnhatqJFPRsVFT7pwshtlevQGwmzdq2D4v1jloiBfu6snBoBkGef7a6QtY5B7wPZnWsX91aYGshHa3/xisQQxU+olcb+sphK/vobrBzFplyHlqCmZSGCYX0USIUrpaljxa4/X/iEyYgx5jVGSTAsEoCK/C5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712777086; c=relaxed/simple;
	bh=6JLrrSp1jpobQmNL6n+hDi70eUyZJuc8ccYCiS6m4Ng=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dn8+9V3QR2Zq8O9TLjXQ6ySDH1xMYY9UQ3JXH1lkyqifAGf/gjzJgbn4VAKnZB4hrC0VEIvsvieOalVRRzqspEmLLysf3eEnmarGWNCc4LUB1HUf44pTWhsOxwU4DTXaM6cVMaTlcaVvOGy3n7ZkdUfZXLIavRcIQ54dlHBLjxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C/NpLJAW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qvb3j6nU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43AJ4IFa026485;
	Wed, 10 Apr 2024 19:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=27yhbqYm3R7y/sAr63tMLArq09dSljIiqHdplYXEBOk=;
 b=C/NpLJAW1iWyZjq0kERXYfhJdltVc7kQLtOFkTIfxTPbYyRERxXyc4ftc1HZ7Jm2x3JH
 l0U4vxMic4344NqvzCxVdzOYwwT4jUg1NnV/xAkjNEdBitXkA2XTZkuQZQozHrrrU5+2
 qRxAyQuw3xDSnKXzyTXXMjm8BlN3ULCY9x3GrUjZvVXBBSFpILhR1XM0HuOlOExiOycy
 F1+a/kgWwccolYiAe3AXkUWJ7qYlWMMURI92ZLK02CDXX20/hWynuBXd6EDnz+zFQ8XQ
 f7pn/JLTB9LsGJx9J24yb5vUOOEObMy95Ef3Lpdy/dq96wzFlWYWL/fuu1HHlrWu6cuh tQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xawacr5gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 19:24:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43AIBwEv026464;
	Wed, 10 Apr 2024 19:24:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xdrsrprpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 19:24:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rm3zNRiCcZqibJT4OsahIu+pE8cTv1GFimoJsOB26pnF/SYUaIO774P/juuQlO02eQ6HfiR6jNFHfLAQdjkw1PNHh+B6LVWN676W+pYhtdO3rvD5VCKwNV9VL4kF2dQbD+LM404wTaPk9pPQ1fbsgeErcnnpPPGv3p6QABKAFQHRPzFpqXvSO/8ZER8CZ+Hd4HY1uR69KpwnjH4/Hv7sSdJ6FRZdDLbHFBPs+zq8x1+0xWvRhtPAvLscgm7xhrpTxiWHUwcuToxD10wF42HA5aJfVF3ZkY1Z3aA3JQ89CyW/bW/1AseeIHTaiyKzEjx5CA4h4BchpKFhhyyHgYmfqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27yhbqYm3R7y/sAr63tMLArq09dSljIiqHdplYXEBOk=;
 b=RSaSug2Whb7Joo645H3PqaeTdiPVo7dMJOS11nxk1HCYCFrI2F2LWWZ7TrRH+SdW2aqauk36r1/XgIymUUFwjsiwmvxDm3eEoKz/eswfEOHKrUC9YNYJDYmCPfyrLRiRFkneHIeHFBHRVcGauWm/7x6AR6mxEGKyfYe1LdSWindb65xslCLVs5Xgyf+wxmGti8Gcxjl4xewuEPtOuWigAHWh7QaqVmYzpkIMgvaDbNqgZyCoFa6hudHTuA8oflcoNfqUdfIo9PktLc7CwATsCrmay2x09rEAz9ACo/Zr12AYuxi0gXlUlrUtyhp2TLzbYJpbZK3eyw/FAHs79OxzxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27yhbqYm3R7y/sAr63tMLArq09dSljIiqHdplYXEBOk=;
 b=qvb3j6nU/hVOJBPR5kE8j3FKmnoDhi1Pk9XE/y4i6WfRvRJnieiAKewR+JRmXbQZLlqzsOJ63xwWvsA5y6bKxGiyM9EQTibnTEMxH2BbtZi2DJCh7QljDyoSwZrThpE1m0NOlbuHeUoF7Yz0C5Yj6IUOsoGMhawxyJND+YoZJ6I=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by IA1PR10MB6244.namprd10.prod.outlook.com (2603:10b6:208:3a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 19:24:16 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::1bae:2a6c:1de2:3856]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::1bae:2a6c:1de2:3856%6]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 19:24:16 +0000
Message-ID: <8c7b1d37-758a-46b2-b8aa-afd333140bf4@oracle.com>
Date: Wed, 10 Apr 2024 14:24:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/jfs: fix order of kfree() and mutex_unlock() within
 lmLogOpen() in jfs_logmgr.c
To: Divyaank Tiwari <dtiwari@cs.stonybrook.edu>, shaggy@kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        brauner@kernel.org, jack@suse.cz, axboe@kernel.dk,
        jinpu.wang@ionos.com, dchinner@redhat.com, lizhi.xu@windriver.com,
        johannes.thumshirn@wdc.com
Cc: Yifei Liu <yifeliu@cs.stonybrook.edu>, Erez Zadok
 <ezk@cs.stonybrook.edu>,
        Scott Smolka <sas@cs.stonybrook.edu>,
        Geoff Kuenning <geoff@cs.hmc.edu>
References: <20240410184857.42754-1-dtiwari@cs.stonybrook.edu>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Language: en-US
In-Reply-To: <20240410184857.42754-1-dtiwari@cs.stonybrook.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::9) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|IA1PR10MB6244:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/ZjWid02l4+MRomyqnUPY+rGsLP032f8GFMv2ruubG9t7lXa4YQUlr4AzGWARHqPzwT3ueoZFF05Z/Yez2AcCLpnTIFD48l141gZfSlSJpA290RcmQqsLKzypyVmzChPRLc3I3iC32vfReMIXSwb4cCjGzG+1BElI/cjx9Kapm1URaHzp2D/ybPJ9ABp3JRboqcNzllk6HqHj++OkHu5HcYQ7OSy0TXrnDrVWu6AefsLvJmdCcMyzQ9aDTu65iJXooqgcxrz1rsJ8le4/51iBgXvhm6JuCnjTr3T5yoaXQw7+D/dun7SwCnah1y/VJ+NITRrscBqbgzJlVNogPKRbGumOEAbCASc6GaVK2PgyQ/BPBoLYDDGf7QKnWYI9fGRlvlJFVbPB7wrDvCqdn4c5Rr/WjapnIizp4GdAdtpZLbWB8Kwkt2lPShpLiZ2bF9Aj9PcODgvSi+F6vSWQPR7jvmrw4cBtbGMWUJiU30MvkQFoCTPkHlPQX1Ot3Ei5d1DAqYTCB6y35FgqdWgat67K0v2cdadquH/jJby/oSNzXsPRoKPYvtuRI1Mq5ScrK7vo1ZGe8hpcM8JWs55CZsmcL2C7gg1pidKqmYGHu2mSB98Zf5lA+TS2uYqFXBoaeBtEPKy7Onz9bUr33alIQBX/L47LJPIG1vjLGsRaKJVbWuCdemh2uNAdbg8WiOD9++GX5URYl7zgocZX0NzBnhZkA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bS85eVVrMjY5ZGJ0V3RFRnhaczdJd0xQWEk0ZjRsdVZVVnF2V3BGdUN5QmFt?=
 =?utf-8?B?TVJKWVZBRm9QckVpampSbGpsaDA0U25WWlFHRFNFdmdhR0E1K0lpNlNpQTlt?=
 =?utf-8?B?QTkyeC95NlI5bkFSRWRYVU5pclBWRHNDQUlKY09aaHlMMEVsU1FQaDJXYnZi?=
 =?utf-8?B?SnJ6MEc1THVyWWYwUEhJS0Q3a1oyZjFhekd6OXcvWVU2algxS20vSjJkbVRo?=
 =?utf-8?B?ZXFxRXJxMlpaeW95NXNnaHhrVmZYekJDY1R5K1lxL3ZXdENCS1Rhb0lnVHA4?=
 =?utf-8?B?TTVTZWJKMFR0aU9XZFVlK3lDRWpGOVFNbVlaMWI2WFRpNnFrK21jTVJ6QlQ5?=
 =?utf-8?B?Zk9BUWR3OWlQdjJJbm9weWU3VDdxblovN3lMRHVhWEFlcU1TMXgzdytvRlJ3?=
 =?utf-8?B?bGxHRnBDOEpGbzZXYU1lakV2QmJNYkZBV2JHdWk4OWQ0dUJZS0RCb3NPa2s5?=
 =?utf-8?B?VFBSL054UFo0TCtDaHgyRjV4NnpYaUltQVhJYUtNK01weW5TZmdmMGNCU1p6?=
 =?utf-8?B?dTUwc21VNkNuVWRnNnhodWMzOEdxcnJ3Qlc4dE1MTEdBVTdwWVp5SXBveS9F?=
 =?utf-8?B?RmJNc2VpTkc3WmUvSFV6czkwQ0ltMXkxWVBxM3J5VEZGZ0p2QmhHM3JsZ0Nl?=
 =?utf-8?B?bENTNjJUOVVzSWx3L3kveUZzY0o2L0V0VzJmd3NiRmkwM3pVR0R5UUdMbXVl?=
 =?utf-8?B?WHR1MWxSQUZGTnh6WHk3M0lkKzRpVXRhM1Z4dHdnSWVFZUlvdUZheTVRN3BL?=
 =?utf-8?B?SGJuOVZubk9keC9udHdjQ2VwV3JzNGRTbXpFRU1xaTNoblprdG1sM29VUWFr?=
 =?utf-8?B?RDZaYVJQa00yT1ZKaUd0aGd0WnBlczliVy9iSUEybG9RWnZsZUNGT3FJZTl6?=
 =?utf-8?B?QUJIRllCWEsyVW5MYTRVaWVhRThaVnY0Vnk1TUdhMEh0RkkybXdmazRQMkRy?=
 =?utf-8?B?Und5em5LVFh3Ym05Wlk0b05WalVFN0p0WFJCcXBhcjN4QjU0M29iNlptMVpV?=
 =?utf-8?B?ZVdMc1RIbSswTXRaZ0NyaU9DU2pPOGxXWHJ4bktLNHcxdEVzaWRHVWc5VXlO?=
 =?utf-8?B?dFJJZVF1OXlacmM4VklKeUZ3aFhWTlB5M0lYZmJDSGhLY2tDSjRQcTJ0aUxK?=
 =?utf-8?B?TllOdmNqSDZybnJ4U0t5SnBmZHRZVzdlTkdWSXp2aXpCNHNBaVFXbVgxckky?=
 =?utf-8?B?UTVaeE92S2JsQitlcXVHS2RGL0ZMcng5M3J5eTRURnZZMWhnRzZ5UUhxUDh6?=
 =?utf-8?B?eTBQaTlhMUgrOTJKTStrN3BLNzJoTWMrV2ZtWmx0bFdvRnMrL25mRFU3d3Zz?=
 =?utf-8?B?cURQWnBTcEprc0NRd0daVFN0ajJGejNCUDMrQnRQbHJsRWZEMVp1VDExNndl?=
 =?utf-8?B?UFpxYmptaTFpWkg0VGlwNDBHWnBSeWYwT0JNWHZFbkI0YThLd0ZjamUvS0xH?=
 =?utf-8?B?S0RBRmwyTUNCVGFFdkdtdGRwUXMxTjk1THlmSDJ4blMrd05YR1NxTkV5N0Jt?=
 =?utf-8?B?bDdKZUdJVDYvTGRUVDZ6ZkRjSEVZWTVBWXZ0T0pwUlNRa3dmaDNndVUvN3Fz?=
 =?utf-8?B?cEt3K0wzclVRV2xyS1paR3Z0TXJhNitjMktQL3FxTW5UK3F3SEp2bTFxRlFm?=
 =?utf-8?B?UncrMUNmc2lFYVJhRFZuMmo0WmFXRnNBMkluY2JqaTdmUWRabWlOUitsMmJj?=
 =?utf-8?B?eEMyRXBwVXhwdmpZRnBUVCtzL1VFdlN6M0xzQThxbnFuWDJuNFRBL2crUTRI?=
 =?utf-8?B?NTFHR2ZEKy9BWWY2RVVJdHhHV2kzVDJEd0h6RzRQcTZTeUoyVDdTWkhldVd5?=
 =?utf-8?B?d3FFKzVkUHJkNHNHdkpaK2RIWkhmNXB6d0NiM09JVGF4ZHpveTNPL0x4NTg1?=
 =?utf-8?B?OU8zNWdxb2RYVm0zOFF6aGYrMTZtUzFaeGNUWHhtcFo0SC8yKzFJZEYzS0Z2?=
 =?utf-8?B?QUxxVm1ra0xLaXovL0pOdDZMZHFTVEpsVDR3QnVJUUUxemlkZVpaQmMwV2pC?=
 =?utf-8?B?Y3VNODdEaWtzOVpML1VHSE1Dd0lJaUpwYmM2SDJmSGVoWVpzd0tGTGJseFht?=
 =?utf-8?B?WVJKWmhRU2N4ajNCRHE5QldyRHk4UEVxZ0lNbEJPZFo3anlFR1UrUnpqN0VD?=
 =?utf-8?B?UEVOYVB6MGV6UkRXbUNlS0haVHdXWDdLQ3ZuaUx6NEdFSmlJNitpOUZNQ1c5?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	t9FWf55MbA43TKDvigRH3icPTneFfE0mQCT3T76vJZgtsBuFxG2XaYEsj1wpDaBtEiIK4x2evg93JWg/sqLl/MMP3z56TzeLnCq+DUmTLxoprOlK7+EMhhRjyykaA3Nvo7tpq7z/8E963Sukk4yirK7E3gB1PgAcmfoiFl6jtBTyG9WliLe0uanbOHImZQFqfMC30qMJ68qyCKE4qLpeDEhw5WfDuTrWP5CpO9gOlJdqBb977OZGOcmfytmji99hR7q7GqmktX7A/NPQ53+zGSVhGnh+tuiFjh3IryDGg4IAVgS08S74eVGCjTEx4W9GzDCOXODm/v8rngEkmevDdtnBubCqM12Ipzqnij+i3YyhFUJEwoJ1wji/BF7gEj/zI/VKO9T+Ar7jokTvN3dUEdl2D4RpHo/f3Z9DRN0bQ9vlQQxMzgNi1sfDmZ4NYtoc5wk4rTGOvfRiBwY0NCNAKcArQxelQUeCEuh++Dbqy955QXlo1Ix3nWkgz8NUKN2BL3GikzsFnksozIrHO/gx4LX1LkHDDJoUZt4FrHpwjXDtWNKICttcE8mW0oUTN+ep295htVTD+nezWwaNszAIhVlgHUlTig768KWHSRLvDp8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2917f9-0d97-4676-c462-08dc5993cfe1
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 19:24:16.3700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+tiTF1uX2rnJihwZAFn1jorlav7DyPDhfFckc0Mn+Ta8zXlThT2Ad2AMGRdKDRE34C3VsBR0D7wDGBpHsXKTg9BevIaeOzzfruRdcIPhPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404100142
X-Proofpoint-GUID: x1_ddx8G05bttP1Ujz844jAWCPmORajz
X-Proofpoint-ORIG-GUID: x1_ddx8G05bttP1Ujz844jAWCPmORajz

On 4/10/24 1:48PM, Divyaank Tiwari wrote:
> In the jfs_logmgr.c file, within lmLogOpen() under the “free” label,
> mutex_unlock(&jfs_log_mutex) is called before kfree(log). Through our
> model-checking tool Metis, we found that this is one of the potential
> causes for nondeterministic kernel-hang bugs in JFS. Specifically, this
> indirectly results in the “log” variable being NULL dereferenced in the
> function txEnd() in jfs_txnmgr.c.
> 
> Fix: Swap the order of mutex_unlock(&jfs_log_mutex) and kfree(log).
> 
> We checked the entire JFS codebase, especially the file jfs_logmgr.c where
> log is allocated and kfree’d multiple times, and found that every time,
> except this buggy case, a call to kfree() was followed by a mutex_unlock().
> This ensures that any shared log resources are protected by the
> jfs_log_mutex lock.
> 
> The small patch given below fixes this bug and we are reasonably certain
> that it is the correct fix.  Before this fix, we were able to trigger the
> kernel hang bug fairly quickly through Metis. Through multiple experiments,
> we found that we were able to cause the kernel to hang mostly within a few
> minutes of execution. While we are fairly certain that the patch below
> fixes *a* bug, we believe there’s another race/bug somewhere else that we
> have yet to identify.  With this small fix, when we run Metis, we can still
> trigger a NULL ptr deref of “log” in function txEnd() in jfs_txnmgr.c,
> but now it takes anywhere from 6 to 137 hours (almost 6 days). We are
> hoping that this fix will also help some of the JFS maintainers identify
> other potential races.

I'm really not sure how this fixes anything. When the lock is released, 
nothing should be referencing the data structure. Also, calling kfree() 
doesn't have anything to do with the value of sbi->log, which would be 
the cause of the NULL dereference. It may only affect the timing by 
holding the lock a little longer.

Can you briefly explain the test case? It seems you are using an 
external journal. (I don't think that's very common, which could help 
explain why it hasn't been discovered.) Are more than one file system 
sharing a journal? (I don't know if anyone actually does that, but this 
was designed in from the beginning.)

That said, the patch looks completely safe. I'm not sure if it is 
necessary since nothing should be referencing log any more and a 
use-after-free is just as likely whether or not we hold the lock while 
calling kfree().

Thanks,
Shaggy

> 
> Note: All of our experiments were performed on Linux kernel v6.6.1.
> 
> Signed-off-by: Divyaank Tiwari <dtiwari@cs.stonybrook.edu>
> Signed-off-by: Yifei Liu <yifeliu@cs.stonybrook.edu>
> Signed-off-by: Erez Zadok <ezk@cs.stonybrook.edu>
> Signed-off-by: Scott Smolka <sas@cs.stonybrook.edu>
> Signed-off-by: Geoff Kuenning <geoff@cs.hmc.edu>
> ---
>   fs/jfs/jfs_logmgr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
> index 9609349e92e5..ce9af4ef1e41 100644
> --- a/fs/jfs/jfs_logmgr.c
> +++ b/fs/jfs/jfs_logmgr.c
> @@ -1144,8 +1144,8 @@ int lmLogOpen(struct super_block *sb)
>   	bdev_fput(bdev_file);
>   
>         free:		/* free log descriptor */
> -	mutex_unlock(&jfs_log_mutex);
>   	kfree(log);
> +	mutex_unlock(&jfs_log_mutex);
>   
>   	jfs_warn("lmLogOpen: exit(%d)", rc);
>   	return rc;
> 
> base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702

