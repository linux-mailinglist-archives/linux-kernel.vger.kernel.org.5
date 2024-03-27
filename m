Return-Path: <linux-kernel+bounces-120585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DE288D9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E243FB2521B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CC0364BF;
	Wed, 27 Mar 2024 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NxW4AYP4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="upnFakAT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F58D1EEFD;
	Wed, 27 Mar 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530045; cv=fail; b=swO1D72sExb7T8kAiYu4rCbQ21v5ClT0Rg4zKbhVya8ip72JaUGur8hROUAP0Kj/EOxvt/RNLIzzQ31m0ihjASXz6pFVeb0cvEWxB/yOOl75Vm6tACnZ3YB9HXPeKq77kUD1RWcAYBJwG3DELRMNZ+OtED75MR6LM/dlxkR5DSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530045; c=relaxed/simple;
	bh=UefKP30GBVwE7q3YmYhjifrsKECSk/r7i4NlhP223Ug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aVPyvElOFFFZrv6VAqiiunwb0/RnNszX2KRwvkg8YqgXDpcCv9KbZTSxeRv77Jht9FEk125ctwjYVkJcA14ewDcUcdYz+mVMRactpvmYL+2liPKqWkEqKJr9zdHrXHw4cm/9VG9mMN7K/WIUwLVQFTXn6xjYq4Vz9KV1xIdIszc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NxW4AYP4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=upnFakAT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42R871st009110;
	Wed, 27 Mar 2024 09:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TGJnVTxrTddphhfIBn0fkepYdBqkUUgFfi/OzTwbDMw=;
 b=NxW4AYP4/LzzkCSd+R5U6YeaIWhMdE8TVk5g+QQ2wl7zMfgVty40RWSfIonyQcbdDoNZ
 wuwvZ88lrAUC2d5J/zNh9ayQEgZnAPJEPTuOalBPRUrHTzhhROdLLzC09nbg+SLoKLd5
 dbdL5/ZQhB2NqqIpbLNXFGr5g35yNzw4oPZU0t9mPYco4I8YPeb76Z46yqIcEoBlxwam
 bP9fB0c20Be0B/HQ8T3VEX3M/tYH2HSEcI+jGJJynQ8VCi4WwjM5Ze1JDzfFjmw+U5ky
 0A5OIXp+yLxxKyLMcw6+kgC1UYpwt/cQUKCIpCdsi8y1c23AcwRczrmE1vVdeZFUlKZq rg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x4cxy0bbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 09:00:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42R7n135004758;
	Wed, 27 Mar 2024 09:00:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh8euuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 09:00:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1zZ1Wp8XbEdhSm2JmGUyzwUwT1AEjbg7dZ6mtC6iX+V/H5KJAsxKos0NS77y9ltXPGst8H6Dx7+HXa9aTfWy+jsvlVthI4Gdz4q/yUiSrHkiXs6EXFVFgZMqVRhnc+tEznzzSH05suoo567c6GogN+6wG2wHlny4qeuAfuykLDekCrxLg5AyKtUNi4qo+Q8H4KdMmHAKZaJ0Crl7dzz0jTOas5so/vxzm9FzgBqGjjaxGczJ4qtNzGv4CAd4l83t00LmORV2csNdmQhahTmgG+PgXBRj2IRHdvNXy/I1SfTlOehAx2IMUMR2MA9MnyF/HJWuPxgFPxBtmEDRm8H4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGJnVTxrTddphhfIBn0fkepYdBqkUUgFfi/OzTwbDMw=;
 b=h9Q1C1eRCQErLsFNeVJpwwiWldiGnPLkdTcVWVI0ukYRhU1uiZ4k51CmEUaB4GdfS4YUG/5SGNibgQ221+BPNjPICsUgkD0L8ftdcIxpTrEZBm0aqRpfuHnQLC4IiEqs0GmysZxIVxIcl40Kh9a+oKwxradThkZnJuaCGvanOAsQYcRGD+nOIV8qShuOa8IX7UaEQpEmbsgueEfu+oGwla6hzGcVlNm4frg3zbvs004guaQ6b49rYf3yQx2mfC05hT0ZhjMcGptuuam+dmMdMMWdNZPHlgoqb5GGGbVc+PYpjgKFWCKNTevMI/EE7foU71ToBupZgMxkpAZ8ktyuxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGJnVTxrTddphhfIBn0fkepYdBqkUUgFfi/OzTwbDMw=;
 b=upnFakATKgSoH3WsEqyszIhkOitkcLi5wJXuid7bUwz2+iP7axw2uVHWOvMWrGOSZfkTA3IvVqtELVteELoaPpNawQRGOCCqne156eG+sB8PZV3OoUEnASc21y4+WekHyJD71XACjHggZx1WVTHa6UJH4L0vDYZrRIgFVLIlwAY=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH7PR10MB6108.namprd10.prod.outlook.com (2603:10b6:510:1f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 09:00:20 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89%3]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 09:00:20 +0000
Message-ID: <2e689c05-af8b-4eda-9614-c7008891a218@oracle.com>
Date: Wed, 27 Mar 2024 14:30:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/180] 5.4.273-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
        pavel@denx.de, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240325115908.1765126-1-sashal@kernel.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240325115908.1765126-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH7PR10MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6f37b9-e78b-445b-b9ab-08dc4e3c546a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZMHGyU9pXRffZKzZjHGlwZKu8Fyz2w78wc7+ENGNMMlyfDhRKzKN7LloiGTlLowk1W8cSUT66xOXI9HcbDIiZ/0PjpIcW+BjQTtOnpOo3ympookhGZ+EaM2OywvOpuyGHzCGC4iSrln4O0fljAK2eKdeeQuHM85RtPOVi/TZS0vNFajdO+jMHzxg8Rw4xvo1nxAjbdJty0fuOVF6brLUXEpF4j59RCNGiye9gLIMw/zpT/PTwZrDyIFNMmI1uEqrq13SmyhYrjrmufzzMFOFEG4QYbKDzEl62uKO0cdtIGzL7m5KMIsYJQpAczCY+XqzFVmcEmUtlmwyAJrWWKJpkao/T+i7aeHI9PjSrVaA02CHDjW+X6DPU+rcDomcprmqT0M7qz7xL47Vnl9X2zl/SE0jiDFASDxT12i/cjxXjqlBZi/e9WxFklwk4OJkiLD97HDjet96Q34nZt+XOf/NRH4PGSUy3rz1wI0TJlUwSh/tSbfZ8SfWlDw1jgC8aM2FFFh4hm0JWQY9IJQy6pMkH6Jm8GiEIvT8iv5yWzTxiJsMp1KkZfpDFWLSf008gaW/nWu6BwGPmreJbdqvzvej4MlPargQIgClTCoP11Wdg08=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eElVakEvdnNvQ3N4M2oxVVBKY0lmSitGNllTOVNVaUkrZTRxSjIzRTRWQ2lr?=
 =?utf-8?B?V2lacVhBd1VaNFpZTDR1MVkybi9zUGxXQ2dLS3p5VjNtQU0vU2hzNzdTNWY2?=
 =?utf-8?B?Nm8zTjJMU1BFcnIrb3FqRFFQb0dJSWp6V0RvczdyYVgvTTU4YUkwMCthNlln?=
 =?utf-8?B?ejBPdHlOdFduRHZRdDNpendLVWMveWdEbTV6VDJqQWg3TW1QV1AwMDZOSktY?=
 =?utf-8?B?UTNlYkhoMGJXQkt3eXp6NHArZWdUQUN3RlU2MEs3eWdDMW9RWk10dW1OR1BI?=
 =?utf-8?B?TnpTVktpNTNXTGU5TGNvRHZWdFhBeURyYWViNjdzY2pyR3V0OTJ0alVTcnNl?=
 =?utf-8?B?TSswbXVudUNLRHRDdndxd2p3aTFLN1lEVmFOQVY5YTdjN2h1eGZ4NDNxSXhy?=
 =?utf-8?B?U3BkV0VhT2d5NWNlVTYrQ1FjOEozb1VZdlU5ZWh2MFJvVzdyRUxPZkxnSllN?=
 =?utf-8?B?SWpxUC9lZGhOZ3ZvcDVHRTJXcEpyZzdTZFFtem5kVEZCdHVqNHFNS0xMWjNR?=
 =?utf-8?B?ampzTUFlY01tWSsrbU9rdE16WHJjdzl6VXNFNURVdDhjczM3RXpvamFTTjVa?=
 =?utf-8?B?S0NWRGV0VWFZWkU1cWVkV3dZNzY5Yi9tTTNzVDNpVTNsV3I5bG03Y1Nlam1N?=
 =?utf-8?B?WS9nWk9Fa2NqM29pYmZrdGhFWGttWjhFTVNqUXFJRjhpUUtqUTVtenpxWlpT?=
 =?utf-8?B?YnZVNjZVUVhvNE5MUGtPOEdINy84Vm1RQjVCK3NrRnljcFB3NG1ZYjJUSXJt?=
 =?utf-8?B?Qjk3bURGRG95V01sRHRSMUhMb3EyVEp5R1NRbGc0Z2U3NHhycHpQTVBHdWo4?=
 =?utf-8?B?ZE82K3M5Zm55Y3hLMDdaSmczNmVwTTN3MFAzSTFjWnpsYStvSFZzUTNkeWJ0?=
 =?utf-8?B?YjdKcnR5c2NLVnJXdWVsNjRDYnE0bElWWmlSUjR1TWQzZEI4TXhZOFpobGtt?=
 =?utf-8?B?STFNQkJXWnB3aU1PeWEzUWtiUHZVVmhlc29MNjB5dC9neWxXSWgvSDF1VWJ6?=
 =?utf-8?B?TUpRcWdWQ1hLdVh4d2k0Y3ZpeHFwOWlOQ3pqY3hLeWhyREJDa2Y0ckxsWFdS?=
 =?utf-8?B?SDdjNXViVFBjV3NQZ002YUlxY1cwN2NqQkJWTTJIUEFucHdicE4xMmdBMHZv?=
 =?utf-8?B?aHdjMzdHd1ZWMjNBWWd6dFJxWWVBMXgycUI1Z2swcU1mcU9XMG9OMnNtQTZo?=
 =?utf-8?B?TkJtaDkrQlg5ZjY2MDBrWnNGSDNsU0hwY2RGUFFlV3M4bEdkdXMxRnNnRjFv?=
 =?utf-8?B?QVZPL3NhOW1LMnZZZzVBZGNLVGlEajkwdVRYTzNreVJEdTBtak1iSFNjQlJp?=
 =?utf-8?B?eW1Hb2tGMXVSa3JKVU5WckV3U1oxamIxb002dU1LYjE0SVoxU3NScnorOVR5?=
 =?utf-8?B?Z21MeitkNXJETkZVaUNhcnVVclAxZ3VNZENDRGVZMzJWWU9DTXV2NkNLc0Ja?=
 =?utf-8?B?KytDWGdLTFRIZ0xJTzQyNFlROGY4bHc4bjhWUCtZQjdjQmhJcitmYWg5K0FU?=
 =?utf-8?B?V2VqT0xHVk9Bc1Y3Q0E5VjlKREdqKzErTDlOVnA0SDNvVmZKcWF6ZDlwLzRo?=
 =?utf-8?B?KzdWRTRpVEtkNXNsTHhyNVZ0bFJSSHdoTkpoRDhtQm56VXFCVEx2OG5JdkNE?=
 =?utf-8?B?K1I4eEZzMlB5Sm42WDVUbmFTRHRRT3M0ZGpEZHo5S1JlWDg4L0pWWVFPVExQ?=
 =?utf-8?B?c3dpTm1Ha0JZcHplU3JoYzBiNnFJaGVoNnBFTGxhVkF1S1VYS21wU0Q2ZmUr?=
 =?utf-8?B?WUpGaTdMUXNERjd3UDA5RmFnZmhwWEM1ZTgxWGNhS2ltZFB2QkpVdHlGYlN5?=
 =?utf-8?B?dDlqQjhwdFNmSXo5RG9DRzMrZ3k2M21nNG0zOXRhM2N3a2NrR04rSmt5RFJI?=
 =?utf-8?B?Skp4OXQxSlNUQWlHYzNsT0hoWi9Xb2pVdzZmeWw3VWxFMDIxS3hxSktOOWFM?=
 =?utf-8?B?RzNqTER3ckx6b3pWV1pUZ0NPc0lQV25hdzc2Y25IRlJpLzdpY09obXBIQ3hM?=
 =?utf-8?B?M2lxUlptZmpPU09HVjlpN3RFUmg1b0w5b0xybE51VFZiMSs3TTlhVWtUT2Fu?=
 =?utf-8?B?TlczUWtFMGxQMnVlT3JKWitwcHNzeWhKaGRNcXBmSlh3OCtZeEExRW1YNEtX?=
 =?utf-8?B?MWZaancxU0V5cEVTdTk3aVZrd1k2OWI5S2Z1NHIvMWdoZk1qTjM0R29PTG05?=
 =?utf-8?Q?hhlL+wArSqLNsFdfJhFiM48=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Y/xe6yVaNDW/37SI836SG8Zyiydoj34sWvKEQtYrONuN5vqSvn3+h0qLUmZ1yh994x5IRsrkkJXeMaFlQmEWMuSFeUX+qBOymBSfAjOmFxO4qvnpSc0ogqlwf2K03XocgNyHczSyM6bgpuHIFrRY+I3hlb9IB0qjivTsrktNl7C/422Hp7cV4Bgm1GPl4UFmRlVZcbfTr2lu5A54JbFqcqgXqciBdUTT6y0FLeJYw1wGc033doSPv+HTY4P2cD8om57oZUAOrEiqqITxcooA8PY+lRlLGmaEJBUt/n3TVx6/MXD5pBfBkn7wbqPkPFugNj9SaN/2kEmKfU9sDjU6bmaCvfqcQ/zhLJIq9AIM4Fof8wGnV7IgBN9euF/6t4zjk/yx8JYlCV7qrfYwGNby4yKzrXFq+e5yBap2l2KAGETxz/lxEq1HzcmX4+pJ9LTtAXCIytskPZqBHqVEckp5EmJFCEGKEpah/BZ5DYD0UvN/jTRv298ttNOJW8jGM0LUYhNUgyPDBQRhkW7ToIavDi+YOHT3YbpG6QXyQHJLkua4kP4e5E+EQroP+bscpYyWgYP8O7oYN1IMzIcXjv8Vid1RfV34mjySDVl+l9MBCG0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6f37b9-e78b-445b-b9ab-08dc4e3c546a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 09:00:20.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjoofJO+QmRtLv+lCWsbgs/Z1T0hqKTZDdve+7hhqsk2M2abVnuXqMb96b6FvignT7ih+hATmymrRo0+dxNytr54pFu1B6ubcLWTJtk2KG4okmHA3wKXIFfgrNcv6yQ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270061
X-Proofpoint-ORIG-GUID: 57DQ-56nF3F2UjWZmQCCRgyffloyx-aT
X-Proofpoint-GUID: 57DQ-56nF3F2UjWZmQCCRgyffloyx-aT

Hi Sasha,


On 25/03/24 17:29, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.4.273 release.
> There are 180 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:07 AM UTC 2024.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.4.y&id2=v5.4.272
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

