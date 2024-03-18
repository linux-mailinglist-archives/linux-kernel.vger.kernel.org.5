Return-Path: <linux-kernel+bounces-106404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D6987EE1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F010FB21DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6CC54BDD;
	Mon, 18 Mar 2024 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MFUuGSff";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VVJO+bRE"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062C54BC8;
	Mon, 18 Mar 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780907; cv=fail; b=XLdQVHzvtuJhA41a14t9ZCfyRaTNSiTf/SB+uLyBRWeK3dnliglSigG5F4w2xIw7HfDb7B0fXt1Cn8sqhKCk4+VCopfDLYeZAnpwb+P8qq/g5Cl77fGYR6kALZzPjHTbCYnduTNDkGdfsciDbqVcd26elpoMjgCIGJa0/gv063I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780907; c=relaxed/simple;
	bh=Yq7/sP0Xa5tZyqKHqM1lz6kmfQS8l6Eu+Vov/2BNe3E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QuoeW/yY3FIbLKXj0zJPorgj4XUVRopJTMckYSHNHQkWuErzFZlUSO2C9jhx9DKKf7s/Chm5XUCjYevK3YE+6j8C4Ilu89O3CWe6lKq3888acOWOldaRN3feYMEoxYC+7NRZgpjJ6nTThNj73r20gXjdQtLWmSDBe7aDtQpz+b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MFUuGSff; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VVJO+bRE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42IDPI7d021359;
	Mon, 18 Mar 2024 16:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8PmYTOqoHIsWPG80DAO1Xmv+fKVKDeTqztupcN/687I=;
 b=MFUuGSff1bmjZi9RExKhQ0t7VeHc9J/cH644P2oa4SRLeUUFbbJ4mEl/jT4l+maeCGDv
 GMeM5bNKb/eC2zLPoW010P6uz0ir3rIdsBuQPS6JHl4hl2ZBKcL/cD9g2c65BjPLh+5N
 WIN/vNE+kzPzm6PP+XqwMOzmQqsrUk3kinIJ+sySgAHZL9oYfXvsnj69A0uuc37j7yhE
 qSptHVeLXTdFQHNihGu5v2JsHMUD3iTwBirQj62i1YaL2LbKw4sZme1sQOkpusIwQR7m
 d4fyiT+vVFXFLFirK22qmdcyzFy7y8gaeU5ZddgUvTP9xSGUV27wD496MPPlJ8giag/l 5g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww2bbkj8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 16:54:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42IGMQdo015763;
	Mon, 18 Mar 2024 16:54:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v5h0r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 16:54:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ifz338LXqoHpi5/uSiGYwitL7TKR410q3U3HC5YwN/7tAHmwwgBLDFfehVVxhUbeFh85xKz0lWNp7puWcafw0JHus94K5z1E+zlW2RTia7JwJ5qq3r5Nng0ClvP6v3PO0pCyvmYnfvii//VG28CFDKBlQsni7bdP6eSV6rNoFSOXQDsL/Hw5NCzPn5asth90ki2xp8B8CxJMPqqVUMmNxG0pTiDoHeUU4W/pYIxGTFCDtaGt8Dq/0DKz6pQ2PDqL/EE1RlgFTg5+eyACAROAfl4AhH3XviCEImN3a94ey++yrLadM/INIcoqQaOUpxAtxBRloOpXjlXx/pSnWFskzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PmYTOqoHIsWPG80DAO1Xmv+fKVKDeTqztupcN/687I=;
 b=SmAxU8ZAtxulmI2om8w2dYKpFo7enXjrgfqqrk95IyRcYTgdztak60/OUJnlB6VDO0+/1P11+LUL8ackK440G+CdqAuvFe6vhGhzinBbWvlMxrTmX5HxlaG8G5/xTJ2r3mEXrM54RoVOkF8Oqi8e487TirPnZEzKe0U/BayAXpQhOBsUZv8lHYterhbrAWQCklKgp9P7mwxLIoc4JM280Tda2ClJ/RGLRxzP5qMmPbL8riLiPlFQbwq0rq0FVuIp6DmoUUjecdnI2nHqaPJygk5jPi9xhGlMyk5Yp3vtpIfTXNGkDS14h9yYJiza6YvWqXlVc7Flf1vZIBHWjFqlMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PmYTOqoHIsWPG80DAO1Xmv+fKVKDeTqztupcN/687I=;
 b=VVJO+bREbFiJG4I558uybizuWdaO+iMAsb+AraB8tchYCDB6C6NVGnzvYKd4+YS6q17TmwzGhU5dfPqhIE/cPMfqO5WM6i0n79p+4D8nllWqDOCIXHkHbVWQoUeRPaP9nAbcU+mS5JJhqguumH4QX1ZslV0yOVGQjatA2Ew9FWo=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CO1PR10MB4466.namprd10.prod.outlook.com (2603:10b6:303:9b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 16:54:42 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::ee66:40c0:bcee:ce7]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::ee66:40c0:bcee:ce7%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 16:54:42 +0000
Message-ID: <41f28393-0211-4448-8add-ad3c55d02210@oracle.com>
Date: Mon, 18 Mar 2024 17:54:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: drop the version constraints for sphinx and
 dependencies
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Akira Yokosawa
 <akiyks@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240301141800.30218-1-lukas.bulwahn@gmail.com>
 <m21q8732wo.fsf@gmail.com>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 xsFNBE4DTU8BEADTtNncvO6rZdvTSILZHHhUnJr9Vd7N/MSx8U9z0UkAtrcgP6HPsVdsvHeU
 C6IW7L629z7CSffCXNeF8xBYnGFhCh9L9fyX/nZ2gVw/0cVDCVMwVgeXo3m8AR1iSFYvO9vC
 Rcd1fN2y+vGsJaD4JoxhKBygUtPWqUKks88NYvqyIMKgIVNQ964Qh7M+qDGY+e/BaId1OK2Z
 92jfTNE7EaIhJfHX8hW1yJKXWS54qBMqBstgLHPx8rv8AmRunsehso5nKxjtlYa/Zw5J1Uyw
 tSl+e3g/8bmCj+9+7Gj2swFlmZQwBVpVVrAR38jjEnjbKe9dQZ7c8mHHSFDflcAJlqRB2RT1
 2JA3iX/XZ0AmcOvrk62S7B4I00+kOiY6fAERPptrA19n452Non7PD5VTe2iKsOIARIkf7LvD
 q2bjzB3r41A8twtB7DUEH8Db5tbiztwy2TGLD9ga+aJJwGdy9kR5kRORNLWvqMM6Bfe9+qbw
 cJ1NXTM1RFsgCgq7U6BMEXZNcsSg9Hbs6fqDPbbZXXxn7iA4TmOhyAqgY5KCa0wm68GxMhyG
 5Q5dWfwX42/U/Zx5foyiORvEFxDBWNWc6iP1h+w8wDiiEO/UM7eH06bxRaxoMEYmcYNeEjk6
 U6qnvjUiK8A35zDOoK67t9QD35aWlNBNQ2becGk9i8fuNJKqNQARAQABzShWZWdhcmQgTm9z
 c3VtIDx2ZWdhcmQubm9zc3VtQG9yYWNsZS5jb20+wsF4BBMBAgAiBQJX+8E+AhsDBgsJCAcD
 AgYVCAIJCgsEFgIDAQIeAQIXgAAKCRALzvTY/pi6WOTDD/46kJZT/yJsYVT44e+MWvWXnzi9
 G7Tcqo1yNS5guN0d49B8ei9VvRzYpRsziaj1nAQJ8bgGJeXjNsMLMOZgx4b5OTsn8t2zIm2h
 midgIE8b3nS73uNs+9E1ktJPnHClGtTECEIIwQibpdCPYCS3lpmoAagezfcnkOqtTdgSvBg9
 FxrxKpAclgoQFTKpUoI121tvYBHmaW9K5mBM3Ty16t7IPghnndgxab+liUUZQY0TZqDG8PPW
 SuRpiVJ9buszWQvm1MUJB/MNtj1rWHivsc1Xu559PYShvJiqJF1+NCNVUx3hfXEm3evTZ9Fm
 TQJBNaeROqCToGJHjdbOdtxeSdMhaiExuSnxghqcWN+76JNXAQLlVvYhHjQwzr4me4Efo1AN
 jinz1STmmeeAMYBfHPmBNjbyNMmYBH4ETbK9XKmtkLlEPuwTXu++7zKECgsgJJJ+kvAM1OOP
 VSOKCFouq1NiuJTDwIXQf/zc1ZB8ILoY/WljE+TO/ZNmRCZl8uj03FTUzLYhR7iWdyfG5gJ/
 UfNDs/LBk596rEAtlwn0qlFUmj01B1MVeevV8JJ711S1jiRrPCXg90P3wmUUQzO0apfk1Np6
 jZVlvsnbdK/1QZaYo1kdDPEVG+TQKOgdj4wbLMBV0rh82SYM1nc6YinoXWS3EuEfRLYTf8ad
 hbkmGzrwcc7BTQROA01PARAA5+ySdsvX2RzUF6aBwtohoGYV6m2P77wn4u9uNDMD9vfcqZxj
 y9QBMKGVADLY/zoL3TJx8CYS71YNz2AsFysTdfJjNgruZW7+j2ODTrHVTNWNSpMt5yRVW426
 vN12gYjqK95c5uKNWGreP9W99T7Tj8yJe2CcoXYb6kO8hGvAHFlSYpJe+Plph5oD9llnYWpO
 XOzzuICFi4jfm0I0lvneQGd2aPK47JGHWewHn1Xk9/IwZW2InPYZat0kLlSDdiQmy/1Kv1UL
 PfzSjc9lkZqUJEXunpE0Mdp8LqowlL3rmgdoi1u4MNXurqWwPTXf1MSH537exgjqMp6tddfw
 cLAIcReIrKnN9g1+rdHfAUiHJYhEVbJACQSy9a4Z+CzUgb4RcwOQznGuzDXxnuTSuwMRxvyz
 XpDvuZazsAqB4e4p/m+42hAjE5lKBfE/p/WWewNzRRxRKvscoLcWCLg1qZ6N1pNJAh7BQdDK
 pvLaUv6zQkrlsvK2bicGXqzPVhjwX+rTghSuG3Sbsn2XdzABROgHd7ImsqzV6QQGw7eIlTD2
 MT2b9gf0f76TaTgi0kZlLpQiAGVgjNhU2Aq3xIqOFTuiGnIQN0LV9/g6KqklzOGMBYf80Pgs
 kiObHTTzSvPIT+JcdIjPcKj2+HCbgbhmrYLtGJW8Bqp/I8w2aj2nVBa7l7UAEQEAAcLBXwQY
 AQIACQUCTgNNTwIbDAAKCRALzvTY/pi6WEWzD/4rWDeWc3P0DfOv23vWgx1qboMuFLxetair
 Utae7i60PQFIVj44xG997aMjohdxxzO9oBCTxUekn31aXzTBpUbRhStq78d1hQA5Rk7nJRS6
 Nl6UtIcuLTE6Zznrq3QdQHtqwQCm1OM2F5w0ezOxbhHgt9WTrjJHact4AsN/8Aa2jmxJYrup
 aKmHqPxCVwxrrSTnx8ljisPaZWdzLQF5qmgmAqIRvX57xAuCu8O15XyZ054u73dIEYb2MBBl
 aUYwDv/4So2e2MEUymx7BF8rKDJ1LvwxKYT+X1gSdeiSambCzuEZ3SQWsVv3gn5TTCn3fHDt
 KTUL3zejji3s2V/gBXoHX7NnTNx6ZDP7It259tvWXKlUDd+spxUCF4i5fbkoQ9A0PNCwe01i
 N71y5pRS0WlFS06cvPs9lZbkAj4lDFgnOVQwmg6Smqi8gjD8rjP0GWKY24tDqd6sptX5cTDH
 pcH+LjiY61m43d8Rx+tqiUGJNUfXE/sEB+nkpL1PFWzdI1XZp4tlG6R7T9VLLf01SfeA2wgo
 9BLDRko6MK5UxPwoYDHpYiyzzAdO24dlfTphNxNcDfspLCgOW1IQ3kGoTghU7CwDtV44x4rA
 jtz7znL1XTlXp6YJQ/FWWIJfsyFvr01kTmv+/QpnAG5/iLJ+0upU1blkWmVwaEo82BU6MrS2 8A==
In-Reply-To: <m21q8732wo.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0139.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ce::10) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CO1PR10MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9720e3-39d9-4496-37c3-08dc476c1b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6QDxS3Rnz9zM+FXwlVmKZ8ELSOOeZV5eByRsqreAei0DpFH2w3BmF2+ifRvTdRNf8lW57lwIMvtHORXB5y9ELOAdrHUIDkNM2PnsZqStc/J4hb74Fag2dw91am92tbdmAhXP0b31ZyJgQ2ExtsRtj3keXv1wNwBs6pdIWUzZWmS/dxXx5CQyaZILbF6L8VDYilYiPqKPwrn+7mS8GbVyMpWibNJMybuj4VlyhihtxNHCXDAPmR8atWL/AUiWtpOYc/6QkYSSp/78EztaGV14jjOD3U0yy55AZ+k/uldezhIa8ufSex1Jk0FBbBJQqv1bvHia6bWfVoMM+3qwn7TSqmV1bEsiErlv/G+uEVF5ZAWai2FECZYpxdNuvrZjnjwNLSaHNAI72MX9mVSfLJ4V7jKzfTS3/FmbzkalblDmIMEvnCYXygfDbzBnr+Pq7TGtISAD8wPv2bkU+erHJ0CD4AHLQ9ukimmt6nEtza+GwhhJof0NJPC2Zwhahnxuqejc5n+VKL7bYwZldTtk0gy+zG7xdZ8JEFZosLVOuxZ3zaCIBMIrYIeaE/V8YN0S/AAC69XlWuKADYdOjDK2VNE0RXGMTr8kj2MRfIkSUpRKlDGQU9VCf1S5CeC+BIRfTLk4
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R1orcnZOczN0UHFCNkdqMUV1NTFRY0lLc3puSlpnNXBkYzIrWkZaNEJBWmhk?=
 =?utf-8?B?d3FKME1HS3JjRW96TER6Y2RqU2R0TnRIS3FPVlhqTGNuNUtSYTU3L0RSRy9v?=
 =?utf-8?B?ZjlibTB5RlI1Mk5TTjVQbFc2dHArTlpyNmpjSFJqTHI0akxaTE5kbllDZkFU?=
 =?utf-8?B?NGkxeUUwcEY0WWZ0YW13czN5S2YvNU5PR1dkVzAvdHJLSGduTVQ3UFIrS24x?=
 =?utf-8?B?Nkd5a0dUR3dxTG0zeEFTTHhicGVoemlxSEVlZ1JhdHhONmVmZW1VZjN2Zk1F?=
 =?utf-8?B?ZjY5enFoZGQ0VE1leG5LYk5sQkQxbDlxeC9FR2h1RXFCMm9MZHVDYnRzY2VF?=
 =?utf-8?B?SXJwTFZtOGtKKysvMXhLUnlaZkVkck03em1lMUlUM1N6Nm93YkNCRXZlRk9V?=
 =?utf-8?B?MitvY0ZlaTBsS2Q0WFdsMFU4eW82dkIxeTg4VUlvRkd6TU1MR21zSjRTS0Ur?=
 =?utf-8?B?em5oa0NHQmxZNTFIdG15eERYdGNHdWlieG5ITW9jNFZxaGc3UTdxRkVTMXVU?=
 =?utf-8?B?N3JhaHo0eHpKTWlMUTBScHhwc3ZML1FDZzBtMC9UM1hlUmtyVHA1TVpoM3FR?=
 =?utf-8?B?Z1YzalZ5VzlQVDJqUTJmc2FBTGV1Zm05U1Y3c25TUkVYSHkzVzFuUmhlRTBW?=
 =?utf-8?B?U29kOVg1aGg3eG8zRVJrcmNYS2h6TVhoQ3d5cjU2MDY4alFlNTRSOVlNUk9l?=
 =?utf-8?B?ZERlUVgra0RTeHNFNHR3bDBScEx4UCtheEFjUjFkNWhCNnVaN3RXQ1FRM1pP?=
 =?utf-8?B?QWo5ckk0TWxHVzdSSzc2cnhGZk5PTm5oZFRHMmZ6TEZZcEpFeU53d2cwdkxa?=
 =?utf-8?B?eFpEb2NMR1liNXgzbzlBTEFKWHZadGR3M284UUU2YzhkaFFKVC94SGZRWkxs?=
 =?utf-8?B?MTFjYkxiUG42NVlJTysyejcvTE83THJ6c1VtanIrQTA0S2s3d3VtTS9pRzBk?=
 =?utf-8?B?VEdEcnc5MG40SjRjK1hBbTNURmRXTlQraFR3ZndDY1ljc3h3SVg2RUxsdkV6?=
 =?utf-8?B?eFZBN0tpNGhLci9rSk5heEROUVNwL0dKa2JodlMvekU3MFpjM21ISUhVZ0N6?=
 =?utf-8?B?aGpTemx5MFltVFk3aklLS1ZsaWt5RS83ZkJlWGQyc1BtVXgzS0RKV0ZQNlFG?=
 =?utf-8?B?dENqMnQ1Y1JoeFcvOFMvd3J1YnZJWWNEN3RVNkx1SkYxUHdzMXkxT25xeXEw?=
 =?utf-8?B?ajRvNVE5MHl2SzZKdmJPRU5vcDhxRENQK2UrOGVYaUlOb3hWVmNNaXVEWmhZ?=
 =?utf-8?B?VnhKQlpHZms1bG9oYkdhRzFPdDFTVmg3ekJleUU5N3ZoT09JOGpSSG0wMmNE?=
 =?utf-8?B?QjNoV0ZqN1pBOHNVcVRXQ056U2sybFJWQkgrdERBeU1hMUhxd2ZxRGJzOVZw?=
 =?utf-8?B?bHE4b3c1Nk1ReUZ0dnZrVjZFckJmbmtmWllzWkR6eUdjNkJLRlFPWFJndHpa?=
 =?utf-8?B?RmRRVkovRVBrRUc0S2ZYcW5XdGpEK0ZxN1ZDQ0hkMURSS3I4aFFnbW5tWmNF?=
 =?utf-8?B?TTRubEFFWHJSK2VEVkZwRmFzVGppTFRxVlowVFpTTFhwdTVXMkk0SmJMbm4z?=
 =?utf-8?B?eSsrYTlGNXd1TXpiUW5GN3B5dTRZNGMzcHVoa1VUVUNaWGRXSFNINmZ3OW14?=
 =?utf-8?B?K00vK3QvNHNUbDZuTGVjV2FRdmV5dkN4bUF3SHByb3I1L0laeVlFeDB3QUNn?=
 =?utf-8?B?OUZEWXhSVzhhWk9TS0RVMVVTaFd2aldpcUx5ZjNkNS9vRE9Pd0dZZjZTWXhn?=
 =?utf-8?B?cGVYMFFFV3h5Mlo3ekFrYlA0TG1MUmREUi9rdThFSnBJc1d0bkc5VDAwQmtE?=
 =?utf-8?B?R3NaWCtJVXFiSFBHTUJNZGdudmhsRGNSZk5xU3pMQkJmSVh0L0E5MERtMFhI?=
 =?utf-8?B?NDBta1hkKzlVY09EekxhdXRqK24raDExUUxjMHdIbUV2V1lKMGl4TDA0ODAv?=
 =?utf-8?B?R0VTQ2JOUTNKWGJoWUltTDBiN3ZYZjlrc01waG5mWFlubnZNZkRNZmhOWkJV?=
 =?utf-8?B?Yk9lSWUrOE13aWFlM1AwdzVPbXR0Nm92VDl3ckliT1hkSGhOT0NVZyt5V2xX?=
 =?utf-8?B?MVRRL0JjdWVwSW5ydEJjT2Q0MVRtZXFUTlFNMEN2cmlrejVUK0ZGajRLK29l?=
 =?utf-8?B?YVptTnpXaFJ5YWF2cXRSOWpNd2ZzbnhDN2xWY3U3L0diblQ0VDlPTGYzUVlj?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	m02Bddn1ydm87jSeBPVD35KzEmNwQHhwuABnSoK91RXtnGaEKTgav7ByjTn0+xcDJ9QHGsFvdWuzDSV+OItrXZDOCXYpxmz3EpawrxHbU+jnvZayiPwtUrGRP6MUSKI1fVoyLojuy5nVRgfcLwuUdM+jE/31Eo5DSNEVOLczkc5wP6I1cMVF9KEl8g7VTDDLfnA3JYlX+lYG2beAJRNq//d7zPrQpWxGfqfkwPGY+0edow+QdKG9PN7ktMjQduLnrkU2cTvrFiZzOp8dHYP/XHgw68D9toZtelPr7R1AYUH/XFkXY3RIZhd3o07crKCfU5ovhXpQ5QHzRL8QTzmYnhJiuozzQm0+7E63+F5KCsTUhU62S5kZx966tQw2fdMrolcgu06+o5C8HF+a3n9JMWMyNHeIq0YdcsViy1xJFPvzWGNFGYVUpewQL5EGHWYboq/H8EsQ3w+rnI9n4crtscBQVwJuwtgM0J06lghjwXmQHCrKzulG/c7DSJXMlnXDMpPt7wvbiUbDgg6v9LDWLAetJdUAuvkyMo9jkC+DGDHLRowQBG3llVs4ZfFn/gjxG7n9vTsG2xPXXpi4BqUbgShxkf7LVqc3TX7ysnoiKf4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9720e3-39d9-4496-37c3-08dc476c1b87
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:54:42.4959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdPWy1d+8ysj3WRey7TeoWasb+wq6D6zycy1Q170RGauiTHYq1fV1/p+HSHHp9w9UpiD2cURYK/dYnhy832ROptRxeFgijd/lyrsNa6FfHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180127
X-Proofpoint-ORIG-GUID: YaZHTFALFbRF-GKK4ujtiGkHez3OWpPi
X-Proofpoint-GUID: YaZHTFALFbRF-GKK4ujtiGkHez3OWpPi


On 18/03/2024 17:44, Donald Hunter wrote:
> With Sphinx 2.4.4 I always get timings in this ballpark:
> 
> % time make htmldocs
> ...
> real	4m5.417s
> user	17m0.379s
> sys	1m11.889s
> 
> With Sphinx 7.2.6 it's typically over 9 minutes:
> 
> % time make htmldocs
> ...
> real	9m0.533s
> user	15m38.397s
> sys	1m0.907s

Was this running 'make cleandocs' (or otherwise removing the output
directory) in between? Sphinx is known to be slower if you already have
an output directory with existing-but-obsolete data, I believe this is
the case even when switching from one Sphinx version to another. Akira
also wrote about the 7.x performance:

https://lore.kernel.org/linux-doc/6e4b66fe-dbb3-4149-ac7e-8ae333d6fc9d@gmail.com/

> I have an experimental fix that uses a dict for lookups. With the fix, I
> consistently get times in the sub 5 minute range:

Fantastic!

There is a github issue for the C++ domain but I believe it's the same
issue for both C and C++ domains:

https://github.com/sphinx-doc/sphinx/issues/10966


Vegard

