Return-Path: <linux-kernel+bounces-79456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00CB86227D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 04:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B851C20DEB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 03:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D36E134BA;
	Sat, 24 Feb 2024 03:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e7lpXvp4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zE8JDSFX"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA398125A7
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708744808; cv=fail; b=DOrgaP89k/qyZ3lVa1y6faEm1kzTWAVqKGTEaRoXSN9mXjUNGt3rQe4OIiApx9jQDYil/HsF5LWD+t3WbVkLocxVseE+gpXqmFmOvMVqDDH5KM9xXWTX3PEMs/YCtkv4BFqfq9ni7/p8/esuyv7d639tdUTTASRDzv0i8TixRfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708744808; c=relaxed/simple;
	bh=04fmlmMS/s7eBC3uEp6180IBX0fKEHpxPs/mROcAOz0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CWFvfJuaIfeeuLpMOTiQFwhKgffA+CWRN9ZDvuHIgLF5dB3mmghdWzNC80uO0djhwPZhtaD4z2axgAkUh383Wg7PSmHOP763ACNLGVGif6V8BG5CJvFtmMx/VWhTmAvC1eWhk8oCd5Tl07jehMrpSR0wZJ7GXcn6mTMGjRm5vXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e7lpXvp4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zE8JDSFX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41O25wP4006523;
	Sat, 24 Feb 2024 03:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=PTftI5eD81ZnySBFf+/K/zgK/zyZsAzpgX0DQJPwMrU=;
 b=e7lpXvp4ypG2DELwuhgqeLcSu6EFcfJTMTrXvFm9AmNXSi5Lja56i1nAcdSStVzXmUbH
 QZOq1rc/dJ7Cslo626VIkuzuC8hWbIp3OLbZARwOgT9uODJkfxA189y3emi/FO+qSBlv
 8S3ofoOIan7Fg5LkdxGjRBRnozgUXg9J+v5VNvs0VGLVfg9PulJuAInWxSuuxQJyFon0
 IjydH1qLpWXttqEmP3ARs65wrfESNt+Z5vHTNCyd/RM7IuB6CdRy76WZ06nFoJh02Hjt
 JV3P2rM6xWXZeu8XM0TiAUaAb6L96q3YsTKNtgVitgQNoubkqU1oBKDdpDaVZiWWPn9N Mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7cc821t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 03:19:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41O1XO1r003655;
	Sat, 24 Feb 2024 03:19:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w3a4aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 03:19:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CILhHGnerq0UBodmEDGx1KNzI/fJ3wFv9KQsFLTtZqXteIhMr3v8+R59bX6ZkaUwE4rfprZ17qXaYuuaGhgrpkyD/0Y+Z159J998VjvN7LCP7DNG8QNAS6hzXw5NdpZw9Edi3eNfxPTiDB61+GEp91nE8D8SADu8tXVyl7gE6Mf5+5BkDQ+PoEWmv7V1QaVLCDQxwM2cANVg34apHpClWONFeI5Qz/oa9Xp1AoJbU+XW9WUri2LpYownRa0SApmibwzP/f8tjsPE+J8LIfarhNNOQTGYSaJpAZAgyfo4GvG4alWIqiYfShztWxsnWrCA4+DXSTWBoUTxtDHvYqhc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTftI5eD81ZnySBFf+/K/zgK/zyZsAzpgX0DQJPwMrU=;
 b=DJylz4qhSPXEjS1qIwxiWCqnCs+u3JQHbIw/+m1oE7rQpaSRQVnEBqpH9o6C497ej5qNjMbcFZ/+pjewlENBT1sH7UoIYSbXApKb8ofJGrzt9EQUa5eF9LtbvAJmiD8fK+AaLpmjs7Vl1hy1bfEWshg1yFP1Nv8fPdS2VqthIrAVIZZdjlJ4DUDH4Z/c682IFjCN/gn4/ZABIDhjiYL2IvnVABxo2Or8C6mLyl6y7XqX+yXr7DIUnh7D93m8l78O6LRRR79fO+2DXFjAFUPR1JlFhZsRyodTZ1R81z2O6rN7h5d3ulACav8g09oJ52HJrrUlqSb8NPufLmRBVaKNFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTftI5eD81ZnySBFf+/K/zgK/zyZsAzpgX0DQJPwMrU=;
 b=zE8JDSFXzYf6ZVofsKTcU8vH2Npivn8oPSoAuAHJ4NaB1iYNV8u8WTV3fhH45AnBF3kImQ1N4ua1LRyk0GzdLig2uZp/zlzNueT/qmizNZdl6aLLaSv5WUGDtjxcqvwU9bkBdxsmboFjuKbC3CCxRPflkx4SJaoj+02BmSuJqzQ=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by PH0PR10MB6981.namprd10.prod.outlook.com (2603:10b6:510:282::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Sat, 24 Feb
 2024 03:19:31 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::8156:346:504:7c6f]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::8156:346:504:7c6f%6]) with mapi id 15.20.7316.023; Sat, 24 Feb 2024
 03:19:31 +0000
Message-ID: <8367be41-c4f1-f82d-7490-c83647de7a30@oracle.com>
Date: Fri, 23 Feb 2024 19:19:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] x86/split_lock: add the source of exception to
 warning logs
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, joe.jin@oracle.com
References: <20240223094746.11305-1-dongli.zhang@oracle.com>
 <8e4c2001-9fac-48a4-a177-dd6472eb3643@intel.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <8e4c2001-9fac-48a4-a177-dd6472eb3643@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0071.namprd17.prod.outlook.com
 (2603:10b6:a03:167::48) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|PH0PR10MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c7630f-0083-4bb3-00da-08dc34e76aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RTuCVdwo6BtrPN8qGvV7GfPbJwB6tcFXCH5dNyAOhSz30t68OtaWOqKgpvTOpmaHHwLVPdadbKroC3cbVcHvHB7FwxOGDI7Idfxn5NCByGQO5W5qE/7ERZt3dI+CAfcJE0MojNiFD3C+pXf/HGbKIysoiqvA3DQfn4FPLzIi5LZs7JJPDnqnr/vwVX9AsQBH4mNrtjIYzAYe+VzDUM+kTmf8AkZDaYNvUOHgyboJ3vWbeeSrUTjH2zw1LcU6ZlsDlFGn2d66tgonRpdZlAPYGjpVHWLN1/AUOl/S3jR2yQGQ3hvoMUVqlUZ4FyXI6gRbus66DtO1KaDlsMnZLlAjfAK75FYBaXMDuPzw1dGZ2QjYESl4O++FbtRJGWAP7uy44xUkzCV0MQVaqn5GeNGSuiRajOTgJjKIQOWKHswDd2nGNgpBHd2u8xSf97uIbL/YEVbwVxzJyIJzDTpJZeyV9zGfPYTxcm0Zg/opVGwEtFpOGRifYPjLg6yfrjz20M2uMyMfHofVAxDYdaWM6gWwsKtrwhod0sh/xFFa5iyrFg0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZFBaNE03czl0QnlrVzBlZ0ZlZzVaZnNIcnNBTm40bWlzTkdvcW5mWEllNnBK?=
 =?utf-8?B?VlE5TGpPYzhjV3pEbDc1dE44ekNKcUVjRkZlVmJoemdFVnI5R2JOYi9hN3hi?=
 =?utf-8?B?RDBRU2RJRTY0TFZzcVVKTXFoeXNYVXkzK0dXK0svVGthenYvUDI1TlgxZnIx?=
 =?utf-8?B?M0t6TXM4UEJqaU1EWGp0TmdSbE14L2NackVrUXRITWMxR0tyTGUzVG5zQ0xr?=
 =?utf-8?B?OWxGaXlVempWUXc2eTlNdVhoSjRmWS9aZ1NBTkJQN291bWtNQm0ya1BDYi9l?=
 =?utf-8?B?M09YQXkvNUNuUDdvY3Bjb2NGY0V2Vm9wRmp2RkpBcm5FaWtkbit0Nlh6QUEv?=
 =?utf-8?B?ME9hWTIrWEZsMm5YZHovRkhocWpGVzJlQUIrMCtoY25BVmE4Z3k2UHFlZGN1?=
 =?utf-8?B?a0kxSTFYbXczQ0x5bVlxTXo3WWRVdCtQVHEyRGFPQ20zWnExVEhNdzU0RHVO?=
 =?utf-8?B?TkI4M3FtZlAzNVFySVkvK2IyVERyVm5IRGtyZmlrb3BGZ2F3bW1hQnRBUld3?=
 =?utf-8?B?c1NHUTFvK25PZGs4Ynh2bEJ5QTZJYWdZZVU1dXdFUTJrWS82MU9EQTg4OU1l?=
 =?utf-8?B?U3hVT0xZUGdaSmxPQjcvMHA5SEI0VnZyNzh5bW9pMytrQ29Ybm1LNTNvdlJp?=
 =?utf-8?B?Qm1JTkFud3hVY0JuMGg5UUtTRTk0NmJNSXJNME1sZUxyZ2x2U21DcDUwNm5v?=
 =?utf-8?B?ZEgxTlBFaSsrVzNGM2x0MUQwWmRuN3dNVllORVRXTWFEYndrczVWSko3Nmc0?=
 =?utf-8?B?d2xJOG41RzBHaWFIMTdOQ0NQSUZaSGo1TUhBYnFqVUNsZm9zY0tUYjAwTjU2?=
 =?utf-8?B?eStFZmRGbGhhc0p5MXJQN1ZvUk90L1J5YWhRMVpkdHZJTmE4eHNSQ3RaOVNT?=
 =?utf-8?B?TVBCNXpKdDJxSnRQTmI1TjZxSFpYYmV1dVJJbloxS21mTDQvak16NmQ2VlRz?=
 =?utf-8?B?b2FocjdOWkp2ZkZ0ZlNweE5semxXbTAweGpBOGpEdzJNY1dvUkZWeHNOV2hI?=
 =?utf-8?B?QldkTzFLaUlJNXgxT3Uwc3RsbDhwY1c5ZmhHTjlOWmJUUndBYWxQL2dNdUZs?=
 =?utf-8?B?NG43WUtTM2hyOTZTVERqR00zdXV6Ulp1T3pyLzdmMnNDY3RmMGptaGN2VnpO?=
 =?utf-8?B?OHVKYm5OMkNLWVUvQUt3RFQ3MGQyWnU1VkNNQXNVUldSZ2h1ZnZRRHphaThY?=
 =?utf-8?B?MWZzUmVDYnNRWmg5NVJGNkNsdnRnQnlyVlVJc3ZwN2pXOHR6cW5CLzFCVnF6?=
 =?utf-8?B?dUpmamFEeHJ1ZzhnYVF1am9XK05tWjgrZ3VraE1Kd2h0MHNZeFJHNWt0K3VN?=
 =?utf-8?B?OHZCb3hDSGxMdFlybDNydU0zSnlkN1dDRit5YW1SM0JrUzZoNFZzUEtubzY4?=
 =?utf-8?B?Ry8vV20rL0FDWHNLOGx0c2g4cjdOdWFtN1h0MVZIajdld2JMYUo3SmV4R2dN?=
 =?utf-8?B?WWE3UHhNREFxR0ZvdGVNOFBEc2hZdjEvYTcwdVAvKzNhbTlpUEVlTE9ycUJo?=
 =?utf-8?B?K2FIdEYreUFDVGtlWkRZdEo4aEJTcTEyN2FGS1JEdk5vZ3lpMUVaMlNxOXdQ?=
 =?utf-8?B?ZWd4WkVxcHk4ZWJsbGVDbDVRTkJhK0V6STd4MllUR0ZSckRKaVJEUFJZRGhE?=
 =?utf-8?B?MnlOdnBKR0pxVVlSYi8yOFNOYy81RFNoYm0zZmxydUE0L3l0NEJsWEc3OUh1?=
 =?utf-8?B?NXo5cStPL3VvNUFtQ0xkTXpFQ1hYVUJLK1A5WW8yS252NG1qRTBJSWhsZWc5?=
 =?utf-8?B?bVVaWk5RZFdnckRKUElLdHZndjMwandtNFlYbkMwZDZVMTJSaXRrVG13RGlk?=
 =?utf-8?B?TDdyNkpWMUlwdjRtMzdmUVE3WWZFUUM2YVBKMFhXdFJMeXByQ3J4eTh6Rkh1?=
 =?utf-8?B?NVJKdS9JUXBDYVVpY3R5amsrUGxmOHo4VzBLT3M3dUc3Qm5uMXBGdXhqMWdH?=
 =?utf-8?B?S3dFWDcybnFzNGU5Wm9KTDcyZmVuMjhnSThxbGdUaXFvRTJlMEM5TmVWV1ZP?=
 =?utf-8?B?V0pIWkpBZjZBOHg3dTZOMzd1T3FFNSs4RWpTNEc4dFV1VXdzcm0xSHB4NkxV?=
 =?utf-8?B?REF4Wi9taHFYQTk1b2hHK28rdXYyQ05ZczNkbXJFSERxdENzOEEzRWlFL2Ry?=
 =?utf-8?B?Z2lDMWN4MTdGYWlTOFVtY1dVQytOaVJWSlRqRWJ6VmVkM2dnU2pDU3Q3WHRh?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZLKh+oE6RXlarfcthJlcD+hcPTNKnn13zWbrZr9N1z6ZZcz9BerTVEkpyeYnwdjHVmDfvlbm378lh0Ff5uwvNfTFCT9SZgqkCa++pDekrYG1Q/ZlmWkZUpAgbNMy59/ficyzBbBzrtu5AtSbQiNnhQJXOLq0XL0JCvSVWz4YkHIzXHeofqFiV7o0j1QLrAZT/QKwu4woxzhb7pHntOonN86McUNuEcnL6UPNa4A+oEtthBWQDh1JPxlwVpJqEUUM9moQemqu5fKu6auPuxmGbAzwljJwcwQOcJGM1iKNTEMBcwuSszs9uoWl1N9NU5RPGejl7LAD9ldJudnhy7RYFZXSEVv9Iih7FoDEDb45zQeMnH3nCFXDXaZVuF56l85Z17NEDwABFTqPlaUnHSA8ppc9jOjnZwUjJEg/kNf7dO//5KdNqdRiYwfOhSWl7l5yIRejBf0u0269ocvLXQBpDrom58140lOeg6+h6WdOmD4kRZ+NL5tXkk5Ru1m8hvnL2XaukyNbHy9LUjWdYM/RF4gcNse/sODzAfCtQX0kiu25YDPyHpzMoFoZBRI1j2A7MfJaiREhmxjOJm10OEj12KO2S222Lva4EDW6gOcprfk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c7630f-0083-4bb3-00da-08dc34e76aac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 03:19:31.2465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWUd7bbou7pyJgbev6oj9ROSltBd/wiKuzQbJmuXA36d9L/VX/fXPzXuBYzcKtJ6XzrZEu1mKvRHpqz1/S3/Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_08,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402240025
X-Proofpoint-ORIG-GUID: FUdNe9SlT0P-ex4ZMGUnAD_4e7295zoF
X-Proofpoint-GUID: FUdNe9SlT0P-ex4ZMGUnAD_4e7295zoF

Hi Dave,

On 2/23/24 08:27, Dave Hansen wrote:
> On 2/23/24 01:47, Dongli Zhang wrote:
>> @@ -1194,11 +1195,11 @@ static void split_lock_warn(unsigned long ip)
>>  bool handle_guest_split_lock(unsigned long ip)
>>  {
>>  	if (sld_state == sld_warn) {
>> -		split_lock_warn(ip);
>> +		split_lock_warn(ip, true);
>>  		return true;
>>  	}
> 
> I really despise random true/falses getting passed to functions.
> 
> Wouldn't this be a lot easier to read if you just passed the string in:
> 
> 	split_lock_warn(ip, "guest");
> 
> rather than bools plus the ternary form dance?

Thank you very much!

I will send v2 after waiting if there is no further comment.

Dongli Zhang

