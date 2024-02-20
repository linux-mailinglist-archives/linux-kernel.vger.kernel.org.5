Return-Path: <linux-kernel+bounces-72769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8E185B880
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204DD283736
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D5760DE7;
	Tue, 20 Feb 2024 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NbTF5PiQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JxlYvDTL"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BC660861;
	Tue, 20 Feb 2024 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423440; cv=fail; b=Un5a9Q037jfO1uoewpHY9k8FSFNz4FJYBmS5y7eTHE3VaYSqHBpBayiwBWHipLuJrPZVfAN1ZKxfc3fMXTh4SJhhRsyLeH3kJ1lBN0TVZiGWUlLII3hTL+Yix3SHGNRLmUD0mYTx/N+JgbqbDoVtZU33j51qzxSI9sJ1cEbiSzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423440; c=relaxed/simple;
	bh=hY+yS/mBkbG2crq+8203F/uXVQvCQpWI+an7qDv41CA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qVihODyHxC8Vpem367t9cTJ+aCdcCFmnhr46ZLIlbwRTukj4op9ZYIxMs+MO5/jQ2cgSvNP2IHGc/jJK09C/FgBJNEK216mtZglp4Qv1VGBQAwz+Qh1RLl9W2i99m0I4FqLVhgEb2+zz2KUUy8xbcSrC+okSu/JhF7/DWU9rP+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NbTF5PiQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JxlYvDTL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41K8xQwA024928;
	Tue, 20 Feb 2024 10:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=0zQPVO3bJnLoJcb3NKdMkdz9eRe+uXIpsmtnWiXLg8I=;
 b=NbTF5PiQ2vrC6mF8vRFrw62U95zvAC23fXIct1m6THH67BjZ6l/yMbXN7WnVzTWmZp4g
 Mfz9KwA737Q7PYA406ZQXjnKjCKaMEZVZG1yU3t0CV7X9jNL8VOALqEiNbsdfmw8NmFF
 7UB1rMMbFTtsRPQvVfhtTjPb+C49lwWAcgaKnLUNP3KFGuy9SL01/gXI5TCs0FAW156m
 78pz6kQhpIxov7T5mc6nekJzi4rHq1quYzu46+tAdnlqvXuMOHJYGuHO8CGEsKQqxIvw
 djrssVzjEBr6/zrbJJbXkfnlPmIzxAfem5blztRg3mxS3ju3DZhE9yZ8iMoKuwrqCVEr qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqc6bfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 10:03:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41K9wq5b006601;
	Tue, 20 Feb 2024 10:03:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak878nx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 10:03:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeUeQV1N54HuocSGR7UKkmwS8xTS7EoiTACBmZh7ICPoDQMNlHtg3yymCh6nd0OGJCWy+rlH2cNoo73Vl4kWcU2CVenUhPgUrMZYzgF9XmPfr63bo12Tcsjm6FAuO8W0uoUNuvBCLJa4v88BXJTOPM0BJmt6crWsYXDGXX+1FaLbDU2+n9+Ew2Bu7g1vMENT9ISm/v3eBYOgZC591BGJgik6BzIt3uCTXov7ws0EynMnLIuEtrZfwfc4SVhDHN+LwrctSrRsesambxQZu7lyhi4ich99IGVSdc+3CT+YyKQnfEFzQDueiiPUq+XCKQ809ogEDcKOfC/9hAFpuwyVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zQPVO3bJnLoJcb3NKdMkdz9eRe+uXIpsmtnWiXLg8I=;
 b=ixt20z+MoUbSkv7K5iSYuWUxINuP6ab2Qfu1DUf/qzATJb1S/ZafbkcQLKpcwUdKMLzdEKBuc0YWlrO/AAR0L2GZdrewsRIxpY4bdTZob1eMbM9jrFP4Z/l7Azu/4xVGgv4PWaTpZXHMdyl7fkvUIeR0/xvdlZEwW5DfR6cvkDDYR35JCmg/sBN/ggE+meVBD53mCZmDf8ViANgYPLpiVtzi7AtZne8fsZhT/bYTlGsREal0NVaUlpeDM+L3vpSZRTNpwoiOtepRx9yHe06d6nb2Ury47JAgGauF9OJKwm3ZmQfGzOsa7BDggyh7b1vJb2qDxrLoFjk3w65M3wMVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zQPVO3bJnLoJcb3NKdMkdz9eRe+uXIpsmtnWiXLg8I=;
 b=JxlYvDTL8fyFJtjb9J2R5obDTu6bvKqFEJeUgIjnuXP+736EY3yM51drDLYadhyyIovUnKc3xXLCTkeVk18yTGgLe0cheMGdZfD4snORn+AjkXoxkBdm8bNc9k1lmWrnNp7WD9iALE67yCTo7NQvZ4Lh1F2Ob4YJ7ox1rVV19So=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by MW4PR10MB6558.namprd10.prod.outlook.com (2603:10b6:303:229::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 10:03:23 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::6e32:a89a:f2b6:864b]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::6e32:a89a:f2b6:864b%2]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 10:03:23 +0000
Message-ID: <1a26d598-0063-447a-a79b-16315d2899ca@oracle.com>
Date: Tue, 20 Feb 2024 11:03:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Documentation: Document the Linux Kernel CVE process
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, corbet@lwn.net,
        workflows@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org, linux@leemhuis.info,
        Kees Cook <keescook@chromium.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>
References: <2024021731-essence-sadness-28fd@gregkh>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <2024021731-essence-sadness-28fd@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0019.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::24) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|MW4PR10MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: b2084adb-8334-44aa-8279-08dc31fb2c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yp870GTbXjCfC5aXwxUHalQPJB77cLhBdTjkkxREjbOwUXQoCkHoMA3AzYCyvxm/EkV5MIpaay1TOkKQJ+hpCRlwhvd+aTdmL+AwGy+y7zmgdcO2/mkf1/GRDkEnJ01G4eb9ap4Mrj/aDx54Ws1vBhveVaGq3Tf/ruVtj+zQXQM5KQ0il5jd0flCat/0KgEOiZQvp1EVnlqrCdXoUT05m1KnpuA5wldIwfjN7Fso6/qC/ah4jCDQw3CJd+epghAum6/4+squvmE2gP8mIY5x5vgInHYVoCuPuv6OoiETg7D9issdwkW3x5qMoY3S/aWI22W6AjE3g2DC3XIJ9caDlyovVu2kZXUqfdVZkXU/g4WByi1eCCyW0rvq3tLvjSRhcUMMTKBC45SHcr8O/mTRybxLw9Qm+x9V2VSYos0yGmUo9BqVDtrNUShzDK2H9jK7ApBnkr74pnGYUoCqTm7Oj479A7YREyWtyNyM/iYXwGATgFaR6Lmvo3Ej+n7SPuV8c3HOVyZtSmm4LFlt3BRkxw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZzE2eEoyZStYVHZGUm1GSXpDZEFQR2cwOGJuRUJjUk1lbWlzdVFMVXllQlRj?=
 =?utf-8?B?SGFNa2lsa2RZMUhsQUNiVG5vdkZOdjdoekxTTGJBVG5JMFZVVHRmVnVQTWtL?=
 =?utf-8?B?dXR4YTMyZEpzWHdwd053VmEwQytUWElJQVNPT3g5REd0c3JTWG11UU82T3F0?=
 =?utf-8?B?cS9mNmVKeE5aYWN6NFpNV0lPQWdDQnZqa0Z4WGdCSjFNNDdNT2VOY21VSGV0?=
 =?utf-8?B?QTJOSkRScnFQRXVvcG1FVFl4M3IybGN0S2tIYVdyQlpNK3Zva1lGajNNdjda?=
 =?utf-8?B?alJQL2RFYytVOGFkUVdWWkZtbXY2aDR4S3dla0lCV1ZJdVd1b2g0V0JsN2pJ?=
 =?utf-8?B?cEcyYmhzaDNsMC93eTVHajkwdjRDQWdmUWlHWEZxOENMcXVlZ3lqL0N4S1N5?=
 =?utf-8?B?YmIxR0Q2QW5iRkpzTUpRdEQ2ODFtZW54VGlKUjRzWEVkcFVNbDlXNUluWUUv?=
 =?utf-8?B?a29jUmhXaUpRN1hHSkh2S2ppOTRkdG5RVWdtKzhSOGltREZRSkM2WG14Sk1p?=
 =?utf-8?B?KyttZ1ZFWk9mdCsyUUxWWFNIMzBZait6UW1rUVhxNXMrL2pEZEl0czVPWjFi?=
 =?utf-8?B?bXpxU3grSU5rU3hpKzZnb3FmSVhrNDNkWGRKOFFnTXRwNnZ5M0VKRmtMVnJE?=
 =?utf-8?B?YmdWTEI4Y2hkRUFUeWROQjJ1VVVXOG1sZWhyVWxDbUlzK2tzZUZ1eHpGSFdR?=
 =?utf-8?B?S3d2SFF4dk96SFAwdENFSVB0ZFdnZEtUTUd4K2RKN1krVTNaZzlnTi9xYUQz?=
 =?utf-8?B?c1ZxVXVXT2ZmYjRMdXYvZDZudmJZcWJIQURpQi95TnlmMFJTRlhwRXA1aHU3?=
 =?utf-8?B?NC92dzVoTGxIQjh5QUlpZVJRbGhQbDVneTk2YnNyam8raWJCR0tiRVZ3eko4?=
 =?utf-8?B?blhoeW5rRkhJV3JTNHRkTHNLT09uRkQxbVlqQUd5SVI5WTdPeXdlLzhOOXRi?=
 =?utf-8?B?VFpESURBR2JJcWprY3VIdzFhY2puTmZ1S2RZdTdnWDZuZ2crcUUvZ3picEZN?=
 =?utf-8?B?cmFKYTRHcFE5K1lsKytOWjZhNVR2ZXhnM1pWbDd0b0k4WFB4bXhPOTlXUXQv?=
 =?utf-8?B?RU4zK2dBY3FQMTlHRTdtQ3N4QzFsLzdtMEJxeEoyYWhHSlIrbGVZZGMrS3kr?=
 =?utf-8?B?S1VFbEI5ZXJRMDd6elVJeGRkSWUxaE4xQWF5MkNQbU1yeDdMS3BVTlhPSUlE?=
 =?utf-8?B?Nis4TzQyVnNPT3Z4UlQwQ251czVpVEFpcmxKTWlsOW1OeUhkbElqd1Vnbitv?=
 =?utf-8?B?eXBBa2hNWWQweE9qSm5CUGxjRXhzOURCTTRMYjBpZXloMy9kK3F6SU82eU9Y?=
 =?utf-8?B?eUlXNDdBL0trcThJejJRckNxcTM5T3V4NEhOL0srOHhaMnd6QWphOTFjbitH?=
 =?utf-8?B?cjRTRWZnT0VOb0JDY3JHVENiQzFWVEgyS2h5YjEvdzBPY1R4clBRT1VRRWQ5?=
 =?utf-8?B?M3Q3VGQzZ3hkR2sweWEwTzcycDJWWDJLVlhKbmFKbHJ4bmVqbDd1NHhxWUdx?=
 =?utf-8?B?T3VGRzJPalNrMDJxYkZPU0ZTRGFyRTV5YzEwMFgrd21SUUhXUnpmTlgyZ2J2?=
 =?utf-8?B?STdUVXRsM1p6a1NMcUw1SFZWMDkyQnE0Ym1CUVZSTHpVT0NhbHZCc3dCTytH?=
 =?utf-8?B?VTNpY1A0M3NoUnI2RyttK1BTS2xmeUIwWERtR0k1aUlaVGYwVmRuWnRuU2VE?=
 =?utf-8?B?SjMreWtxK0l4V1JHMDdFa0NrZHlYVHNiV09NT0pyZFhDNDROWE9kdjBMSzFH?=
 =?utf-8?B?ZnpHL2g2bVorOUJ5RnRlZUMzbjJ1U2VHOGJLWWdoWDZsRzZaQ0lCTEVsMmQ5?=
 =?utf-8?B?aldBbnlxWEYyYW54dXU3ZTJFdFpURmpVR0JvZ0RMU2RLcXgvSHRNYnVvdEJK?=
 =?utf-8?B?cCtvazFVc1EwZ0dwdlpESlY1S0h5NHdGSXNBUEwzK2JzMlRqUlJMTkRJS0wx?=
 =?utf-8?B?NExpMXN1SjZ5ZTZ5V3ZNM1UzbTc2LzVmZzN5NjdybXFGQjRudFJyLzU1NndW?=
 =?utf-8?B?VG0yN2tmejNYSHhud08wTWZnNHVzTmkwOGlQSndRaDFoS1ZqaEtRQlpxQzNJ?=
 =?utf-8?B?a0w0RlNFUUk4TE1KRG9zODF3amFXWTJhN1VSTnNReHg1Vlg0ZEQzSlc3blJC?=
 =?utf-8?B?SVJJYktyOTAvd0U3a2VBNFlUN25KMExGOWtTZ3ZseFo4czMxWWpUOXNpZVhp?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	j1MPGOqTKZ4aeBWNWHDaOvGFWU1FzPgQKFUWYXWB4MksBWYukcmae+Vb98eJ0tWohvwQuQ212DMVKdlnjjtJvwZ2pfdAMVEY+7mKUXcxzqB2CDnFtZ9R5VHKFYigFZvl2JzWgi8AbeVRojYLj2Dwe3/l4JVYFYlBFy7OJezsPuKDPDupjDjpYMOgid+mYuk4D5M5hcujpa/EfLMsTTlkaezGpvB49KH9zIjBpUXb2vxWZAVDYp4M42KDjVtvXroAuE14bUFcLOw1kihXWFexn7HKDH9n6ZOyEZTXLhjzDcmhk2jzBirkzGdSFK/tFAMT1vIIEBaqnJwENwa8Fu4il/ohPsH5juI8jdQG6hI6Q+1AqjPUrfBgr9s4dfns3NZ9fDdFQf0AF0evHj2inVnqOZ4uqB19ZBlmgfGlT/9iw3qbO1S1KJYqDGQs+snolPSfgll9/mfm8YWU2OBTK60M7J/4Vdq4PrXUKv1HUvphtxEgpQZDWQGreIBx9EHdwyTZXFc182UVLjbFRXOPmDSR6TMvAcqIeYiR9UOsvbHsHs49lZKTzxOg3AFE5o3ZhsHjdW0vTPUdAfRstg0DQV1XtEdEcbMYSxqKf2EGqJV7nhE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2084adb-8334-44aa-8279-08dc31fb2c78
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:03:23.5272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwnx3o/CPaz4AbDj8nHJ3JLgT5J2Co3W0AAXIsk+vVFoH5OLD4zMhp5sEf3mlXxgt8Os065HRcdzqEUuaEBJFklHlSQPaQN8DM2qM2AXBrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200072
X-Proofpoint-GUID: 3t-V6kOqdhP3MVtWaVGoyQXf348DnvmT
X-Proofpoint-ORIG-GUID: 3t-V6kOqdhP3MVtWaVGoyQXf348DnvmT


On 17/02/2024 13:55, Greg Kroah-Hartman wrote:
> +A list of all assigned CVEs for the Linux kernel can be found in the
> +archives of the linux-cve mailing list, as seen on
> +https://lore.kernel.org/linux-cve-announce/.  To get notice of the
> +assigned CVEs, please `subscribe
> +<https://subspace.kernel.org/subscribing.html>`_ to that mailing list.

Is the list open to discussion as well? (e.g. impact, analysis, etc.)

Or is this meant to be purely as a log of assignments?

What sort of content is (not) welcome? Should this be mentioned in the doc?


Vegard

