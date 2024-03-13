Return-Path: <linux-kernel+bounces-101511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B6587A819
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58401C21B02
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2A03FE54;
	Wed, 13 Mar 2024 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mURp2qfu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hYEj6SR3"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBBE3E48C;
	Wed, 13 Mar 2024 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710335507; cv=fail; b=o2v6SBbVNCNaiIkYv5DMG4SXrv+UoFbMcjZqoFv5IYfjdI/2ts7FoT9VWnfpYlRt+awX98H9b06HLaAyhLdeWZS+Jy6ita2RjAggU0yf/dKQxxFXdOyIW75/wv4XaUBU9ReGBqgaLPk9c59tZ1cL+W8tu7d2DP7XTKzUn8xJHoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710335507; c=relaxed/simple;
	bh=/ZlMigZiobWq2WjROeJ0U56DGOuqVvizv81b/u0hXVk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y7okhEDyWNffo6MKvFHaOPORwEG9Z/tmiPGKtXdQZckXlPRGKh5E2NQWagdQm4jyGbacpoQTlmri7444AvHXcNOl5V3Ky7XBApU1GXRYzU+t9wBMR6RuUPn4r/1OdoUbziQhr5DLRKTl8j6mDy6iJDbMQFL/8D3oC6MERZGLEog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mURp2qfu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hYEj6SR3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42D8i7sp031169;
	Wed, 13 Mar 2024 13:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Vuv1TyEs4M3FeCwlF3M9IMJFdCilMBBjHBgI4CutJWo=;
 b=mURp2qfupP6IF3g9UpzoJQPNfyc/BDl6OFR4hTDjKTyKUIbBmrdamRWfFFH0cq+eUJM6
 7e4ARHZ5NfviDNSA3VzVFklIE/KMgAx9Q77AGq+hQuHvyKTt6kc21uQDLKtK+qtYWhmB
 c7MdTxOMuYx5n27unSPGm26MUbC2w+1j7MF6rZEUIGY9ogp47+4hRoKF9hLUmjqIQjSn
 4TpJxrxCcuODAcjL+7jtiqCPgzijAuS7QwI1fA6U9JcWBDOqK1uIe0l0T2HMRB/UHTWc
 T5MaMCCGA5wgr2bXmN3S3GyzxnLOSWjGgy2kG3NdDVUSUlhIGaNG9AOiTbMvJeM7hdtn rA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrepd0sq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 13:11:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42DCxWo8004775;
	Wed, 13 Mar 2024 13:11:13 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre791d5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 13:11:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBzmKU2dCsd7ZFwnqE4qv/AMERtWq5uCf825DxSakDd3cD1RMKCrb/qjOGM8UnUaW2yI80SGnELRlQxv15f0z18uPUeZxTT9pa+AJiXsZmUiwyuOabzV7Z2geAU968Xnptq7ucZ+aJN2ckb6lNCraRsW+JvbdTsx0fv7ExMqHsZwwUE7Vf6/Cyhfwpo5oNe3Moava/ddhWAfi9Q2NDEQrkCn684gtOFRxP1plIYTRTl81SqawClQUmI9IRyJnv6ag7304q6IBEL8iFWjDg64dKS7dqkVFBibjikYAijl9jCdGFRYQHnd61K3C9cscEq7BQFCa2sjwwa23XLQZ4XWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vuv1TyEs4M3FeCwlF3M9IMJFdCilMBBjHBgI4CutJWo=;
 b=MJRzJ0uuu5oKLmBsP8UXz+5nc3+0al4KNYuZfgI6RGBVQ5/mEdbR4PG4b5zgoPdiU1Gxa4TzogCXcRTHhpsw21p7idke0ydl5EuvOt0NRdQhTube+6M65HtbmqEbwgn2oW3w66T3CF1YlDOvcpHG98PuFRPA7gJo98qe3xPNBWISNAvjqDISaIspLNKrgo0r1GgYfdPNPAGW3+Ikc06++RSA1iK6zep4Gv9JFiBBgQZV9Z9hExH84hiPiEHZ1m+huVLgb0PcmKMAtgLovZ6DZu8D4WzJptE6htNJclAHpOSHUFsdVfTNCigk06K/WQG29fooytmScwUA7V0f0tVLBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vuv1TyEs4M3FeCwlF3M9IMJFdCilMBBjHBgI4CutJWo=;
 b=hYEj6SR3Mu4ZTnBDQkBzLulMt/nbTUoERJJIOpnaHc/cK1h7LFc5edWDLM7kYKhV3Th3ZF8mnNKpU64MPqJPFlpKKp44JMydHwUPU3ZNpZi/cNynZG9cxcPvJLfacfTEcrRoEWLc5qICFG+P8uvDhCy7PLXFm4jDTad/PI4hF7E=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SJ2PR10MB7670.namprd10.prod.outlook.com (2603:10b6:a03:53b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Wed, 13 Mar
 2024 13:11:10 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::c671:c95b:c99a:d9e]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::c671:c95b:c99a:d9e%5]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 13:11:10 +0000
Message-ID: <aa7b1a88-f554-42c1-a874-a742e6614712@oracle.com>
Date: Wed, 13 Mar 2024 14:11:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] doc: distros: new document about assessing
 security vulnerabilities
Content-Language: en-US
To: Matt Wilson <msw@linux.com>
Cc: Jonathan Corbet <corbet@lwn.net>, cve@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        security@kernel.org, Kees Cook <keescook@chromium.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@denx.de>, John Haxby <john.haxby@oracle.com>,
        Marcus Meissner <meissner@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Roxana Bradescu <roxabee@chromium.org>,
        Solar Designer <solar@openwall.com>, Matt Wilson <msw@amazon.com>
References: <20240311150054.2945210-1-vegard.nossum@oracle.com>
 <20240311150054.2945210-2-vegard.nossum@oracle.com>
 <Ze9GmrqiW18GMkU6@uba002e82b7465e.ant.amazon.com>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <Ze9GmrqiW18GMkU6@uba002e82b7465e.ant.amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0032.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::7) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SJ2PR10MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 1896f5cb-b3dd-4904-136a-08dc435f0ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qTnVK9k8GFDKwDYaFB6OC5mf70tSPN81PHfyfnZu/5iZW7qUhGgvwoPRgXdiZyDQJ3PjHFfYrpzjGkV/gjWPid3C5X15J2b88/cNLtEGRmoS8gg6Lq9CyJl4dfEo7E1KyDqcPBiUgxh6/s9Kla+Zk3kmjByDmLXfrY4oJywIe8mDqBxZZ16rYfacX1zBamYLe2F5jS7R6YacB4UCd0w3TLA/UNKp7RNKHlCtJs0PV0Tybhtg5nGFpeI1UXZQwaZO9IMKaRI3m5FzRlTx+UKadSd/mR8+S85fcKwtKlYnV0dBpeCyoZL2oFzzQssPniXEHb0Mck+g8aOc2cFs4pJoA1ROZDyJWbOGHNqDOSIZneFnVkDwjeau3q8NXoWLgNKXSntYqsMSjLIGpq2gQXsDoa82o8UPYrCa6jcoMkNkcZHE9wwGZcFty2oIa91VJMnRRKGqiRgfMMU6e8LusSSJx57Gq5ED2bE/pXBVE6eyPXQdRHTBiVJDTpSnWrsUoQHzdHjkAgVBKsWAhs+uHh7aeheQOZ3Fg78dQoSmykCxqXskT+6b3sMvdOJaHYYYKrm/ETVWjuMXjKyI4AaRa0OO8zmIYRKfdIV6iVlJFdD5P98=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SXYyaE9Rb0RjWjNFOWhtaTB5eUNGaHVKMktVVGlSMlJaTUR0SW9haGNiYnhn?=
 =?utf-8?B?NnFUdzk1WmtOemNpL0k2VkFMZloxQnBPeTkxQklDc3cwMEM5UHZpUjV2TTlV?=
 =?utf-8?B?ZE94T1ZrU0Q4eFNOSW1LUWVmZmdYblFvWVpCNGk5bWpCSjdxZXRKanF1eXdW?=
 =?utf-8?B?SG9sQW1VbllNUFVtMXJFUTl0d0N2UThtanZqb1JSdmovWHk3ZjQzcThUN0R1?=
 =?utf-8?B?NmZnN2dNU0pxQWlzRDZ2c0lZL1U1RldXOHlXUkFmUXJiQVdVSlJ5ZnJzeHhT?=
 =?utf-8?B?WXFEeHEzdm1FNXVaOWNYRmtpY0JTWE1UNkVHMXJiR3J5NU9LRlhyRVFKbTJm?=
 =?utf-8?B?YXdpL0poYUNWaTdzSUdYU1ZXNHVDMDA4RGU0VmtzdUlwQi92WlVBUlFzeVV0?=
 =?utf-8?B?d05FQ3dhMURmUHJoVEYwcXpVNGFJY1h0d1YvcWhPSE5SLy9wTlRRYnQvWDJl?=
 =?utf-8?B?aVRnekVYTEJtUGR1c2o4cEJtUGYrRktISjJsdVFQbUxHVjJHUm8wa0RDbG5k?=
 =?utf-8?B?eEdzVlV6elE1d0JnekJoWFhGa1RjQjhxWG1acVZFMW9NTE5MK0hNU3hLeTRp?=
 =?utf-8?B?TkJOQjNRR2tKU2ZhelJRK2JkSXNtRWVVbzRvT2plQUtEZHlDUk1odVYwbDJV?=
 =?utf-8?B?NkMyKzMybFRXZDFGL3FReHQ2aXF2V29aYUxSUEtmbGFxNWE0WUlJbUFad1Z0?=
 =?utf-8?B?UmRhWWRUQXk5OUN6enhSQ2xmUVdhc1I5dmUzbUEvUytvSjNMb2RyRVFvRVdB?=
 =?utf-8?B?MXlMbDRyQm9RemxBaG9ZS200V0Q5WHBvYmJ3Vm52Y0tXZVJDRWNJbXZNRkN6?=
 =?utf-8?B?c0dEdTFwOGtUS1FHZzJuNDI2WkR5V2tJaE9jMEo2a0FxVk4zaXVSRWxiTk5G?=
 =?utf-8?B?bmpub2ZEU2NmS09EblBiN1ZxZWxlMDZ0dUpHUmp5QVBYWkdJaHpLTHFUMnFT?=
 =?utf-8?B?dlNTZmZGczlScWVqK2VHWXM0VVkzcFJ3S2dIVTluUk42TXA4MEpWb2g2YlBl?=
 =?utf-8?B?YVN5VmsrWGtSZVc1K2FKRWQzT1poL2pGeFdDVE5HYk5JWkFscVF5ei9CbHNo?=
 =?utf-8?B?aUpGQU9wNENJZ2doWWlZUEVFdi9VZm5PdElQQzUxcUVXSnVMbVh3RVd1bnA1?=
 =?utf-8?B?QkM3QUZyUWxuTm1aN1hRbUdqMkNTMXVqempQU3hoTGJZa2FhMkNEbGZSakth?=
 =?utf-8?B?MC94bkNsUWJCVmVVZk91V3d0KzlveHFERk5mbzFkU1dIQzF2VnJvS1FXaXZo?=
 =?utf-8?B?anpHUjhxaHJlcjZFWk9HcEpPQmRBcXIvUGVUUmxjdXh1azJ0ZGVVbFhqdXp6?=
 =?utf-8?B?cFF1eWk1NVViVUxjL1VEbTJzSEplbE5xSDJ0TE50ajZIbnVFMUQzeGcrTlRP?=
 =?utf-8?B?MmtHQ0Y5SDMvdWlZb3RMb2s3d21oMFltS0dXQXZMcUlXZ1hYbTdMRGpENERo?=
 =?utf-8?B?VHRCN1BSS1I4QU9QU3J6Ky96Vk9makhIdVBXWkpqL1U2cGNwMnFwUzNrcjI0?=
 =?utf-8?B?M055NUhEQ2RqRVptVzdqbkJpNlBvOWRnWkFDVUc1OTk1SERpZ3VhYUVtbUhF?=
 =?utf-8?B?T3hFU200MFJGTEw1T1hPSThtb3ZYTjNkVzZzdkZGbjh6bmpBRVJFczBhblQ4?=
 =?utf-8?B?TStkNW1xcnlRSnVybWs1VzFpcFMxSlYvdkxIalFPT0Fsa1lhUGpIYzdJN2VZ?=
 =?utf-8?B?TUdWMXI4UjRvNXFIWFljbUdjajNJc0xmbXI3emt5dWMxZW5PSnJzWVRYR1Bj?=
 =?utf-8?B?S3N2M2JyUTZwVVdkMzMyOGU5U1A2K0xxVFhua0NlQjMramZTR0wxUFNzTUIz?=
 =?utf-8?B?QUZsMVM4QXJyQU9qTkpIcUR3a3RBdTdzcldxRWFHWk82SkhuTFM2MjBZNExN?=
 =?utf-8?B?TmFGQ3ZQcW9SQ1M0OVl6TmdybE9ZeERPL1JhOVhNc3VkUFZ1L3JlQ1lYWXR1?=
 =?utf-8?B?emFpZnBoRXcyZGwvVW5uWTh2eHc2end2UndYVWlERVpEeW9jNkxqMUN4UmZC?=
 =?utf-8?B?TUsrbEthNzBrN0VKTjd6cm5TVmtIdEd4ckZ6Qk84K3RjL242YXRlQTM2TEUr?=
 =?utf-8?B?WjZZbEw3RjMrNFVwakVPd0FMeDJtQnAwUU9PTXhjYmpFZEZleW90RS9kRWhr?=
 =?utf-8?B?N2poY29PZ2RyN2VRVzFJVDgzd0swc0tvS0h2SW55Yk81NVlMVlhLOEpNY2Ix?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dFTknRzk9khi8Oo/iIRviOFoMH10j+t6CdWO6Qt7I5lZXoVpe56L4aghT6z9c+Eo0fXJZ1Du+itQDMazLgYCr8bv/JmLDe8l/SZdD92UZF571Nt0EYUrzfBPEYcULtqXwRxIL/rkfetzJH557p9NPYmxNIV5ej7KNm9akz6beHB6W3UWaUXZ/WBpBcN4YfAbroZfwrqUVL+N8y9nQ0Usn4IMFUztni8xrWJMv5qQmgQq88iR/tzSpME10lpn6LhVpKag4NFcp2FGRX/RCL6pa/+sBvGGZgonAVh6bp3HMfOJoccleUq3xjPAwG5OcKrH5TMRM1OLqWRaQCoXthAZzA+83/RrQtWVXcm7RseQikaDIiuTAaOXMLAKYAxdscjeVlkMrcdMN9mnW7BK34m1PjWM5xo77iWFVrwWnzXOXIdm003dJ2dUErInbrm4ClXuJG6gp7I2Ijlx5Fq7I5NnbE7vwKrVMEqdvOy7HD7AfqOYpYj4a+V9apDdQpuDuKqKz1Cz/QkbUB3ruWzY/J7rPPAaEVJFG7Xm3MwGlSNrpoPr9BVS/9RigX/I8T9qgxVZao7W+BCcWDkaBdA2UA+bvinfav+5MOXcUO7NIly05Y0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1896f5cb-b3dd-4904-136a-08dc435f0ce9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 13:11:10.0082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwFE+5C9CCH/K8W5xzunVL27DjjMkiC/zlza+3QL2TE2jaM/Zd+kSXnPjqfiSh8ImJlb0Fw5FzF0kB9J+YO5zjdD4aZVwE9ncpCU8nLvSZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130098
X-Proofpoint-ORIG-GUID: HtEKGq30_quelH1KEI33siRFYTj0dTht
X-Proofpoint-GUID: HtEKGq30_quelH1KEI33siRFYTj0dTht


On 11/03/2024 18:59, Matt Wilson wrote:
> On Mon, Mar 11, 2024 at 04:00:54PM +0100, Vegard Nossum wrote:
>> Since what most distros probably ultimately want is a type of CVSS score,
>> the guide is written with that in mind. CVSS provides its own "contextual"
>> modifiers, but these are not accurate or nuanced enough to capture the
>> wide variety of kernel configurations and deployments. We therefore focus
>> on practical evaluation under different sets of assumptions.
> 
> (sending from my msw@linux.com account to emphasize that I am speaking
> only for myself, not my current employer.)
> 
> I'm not sure that Linux distributions particularly *want* a CVSS base
> score for kernel CVEs. It is something that downstream _users_ of
> software have come to expect, especially those that operate under
> compliance regimes that suggest or require the use of CVSS in an
> enterprise's vulnerability management function.

Very true.

> Those compliance regimes often suggest using CVSS scores as found in
> the NVD in search of an objective third party assessment of a
> vulnerability. Unfortunately the text of these regulations suggests
> that the base scores generated by the CVSS system, and found in the
> NVD, are a measure of "risk" rather than a contextless measure of
> "impact".
> 
> There have been occurrences where a CVSSv3.1 score produced by a
> vendor of software are ignored when the score in the NVD is higher
> (often 9.8 due to NIST's standard practice in producing CVSS scores
> from "Incomplete Data" [1]). I don't know that harmonizing the
> practice of producing CVSSv3.1 base scores across Linux vendors will
> address the problem unless scores that are made available in the NVD
> match.

That link actually says they would use 10.0 for CVEs without enough
detail provided by the filer/CNA (as I understood it).

I wonder what their strategy would be for all of these new kernel CVEs
-- should we expect to see 10.0 or 9.8 for all of them, do you know? I
assume they do NOT have people to evaluate all these patches in detail.

> But, stepping back for a moment I want to make sure that we are
> putting energy into a system that is fit for the Linux community's
> needs. CVSS lacks a strong scientific and statistical basis as an
> information capture and conveyance system. A study of the distribution
> of CVSSv3.1 base scores historically generated [2] shows that while
> the system was designed to resemble a normal distribution, in practice
> it is anything but.

Yes, agreed.

The article was interesting; thanks for that!

>> +CVEs and CVSS scores for the kernel
>> +===================================
>> +
>> +CVSS (`Common Vulnerability Scoring System <https://en.wikipedia.org/wiki/Common_Vulnerability_Scoring_System>`_)
>> +is an open standard for vulnerability scoring and the system which is
>> +commonly used by Linux distributions and various industry and government
>> +bodies.
>> +
>> +We won't go into the details of CVSS here, except to give a guide on how
>> +it could be applied most effectively in the context of the kernel.
> 
> If the guide has something to say about CVSS, I (speaking only for
> myself) would like for it to call out the hazards that the system
> presents. I am not convinced that CVSS can be applied effectively in
> the context of the kernel, and would rather this section call out all
> the reasons why it's a fool's errand to try.

I also heard this concern privately from somebody else.

I am considering replacing the CVSS part with something else. To be
honest, the part that really matters to reduce duplicated work for
distros is the reachability analysis (including the necessary conditions
to trigger the bug) and the potential outcomes of triggering the bug.
Once you have those, scoring for impact, risk, etc. can be done fairly
easily (at least more easily) in different systems and taking
distro-specific constraints (configuration, mitigations, etc.) into account.


Vegard

