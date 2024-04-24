Return-Path: <linux-kernel+bounces-156254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1E78B0050
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A282869DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB3213FD81;
	Wed, 24 Apr 2024 04:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="vHt1dJv4"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACCE86277;
	Wed, 24 Apr 2024 04:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713931546; cv=fail; b=o/mZcjX4dJZX7DkEQeCrfbVQLXUSl+Hb+d48FB52fAbr+6voxtTPCP4G/MyDydZ2j7l0pD2/cKRtywb0P0URyGQS2ijBl8YFwwsUmFCFqp+7EL74jErpg0ooFCBl0KV1x8mhgH9YP962UBY9QLuey1go6yMvXUtUOWzpQDk+vUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713931546; c=relaxed/simple;
	bh=pHur2yB3hUe0UyECrtA9Jp418Je/GDJrcElRNSfAy34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F9yHx3SKGRedRoYEvHXKFqiIT9Tmx/Gep4Yx5tByTnN3yJhbs6FdNf/TpdHiU7/1x7Aj96/Eo1WPsuA9SYmijCw3ldy2/5ScNitnZ7asLouUXQkLnT3z5j47ccpjNcFjRDqKquC3l7giAJS3qhfjS6TVGmldofj8lfFCbXgU02Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=vHt1dJv4; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O0qbcs022581;
	Tue, 23 Apr 2024 21:05:28 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xmd7gmdec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 21:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gq0GEaXCX30psGGRQjQ9/N904AETXBUc48x4Ase3CQ/94mf1OgrotLuHqXvX03aXj/n8AyurzsZ/FLTUs0bwjdAd2Mga2C6qkuPFyEhlyuGgDbgxw3BeeaFowcx9iWCRXLKEhVou5VQMyN6CmxIepfaXMezdgGObM3GHNUhyKAUZhRqBoN0vga35S4q8xmQikLDXJ7hDeI/bWHR5PReQos5Uo4I9PLR3WN/bfrlB6MueFzDQ/wOpumFoxObfzZRi1mO040yNbyIokEcVOlN74p9ZloVURCMB8Hpb2G7iZU+pRpbygCDNjE13IRvPBa7xsPpMsV/cVVe+//dckBFfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHur2yB3hUe0UyECrtA9Jp418Je/GDJrcElRNSfAy34=;
 b=k0BXC/i7uNYaUFCSWqbz8JZSghl4DQ+hr0s2Nl0O6052afO6iagbR50yJvadLZ2aVRFYWu/OqouiTlQ7mdDy7XMWQ3bEdrCGwaAQWT4qgfolED1HugdiwtlvQFPgYXcwqKTl9CfbGbFRO8fX/faMyDbkJHoTHIph1Aup7EpXSqyXBUF5Q7X/2d8S3GZO8bFt/VlO+nWKgtWsbX4or0Klw2OpekDGbcEw8vFAHNyEdmqFrvdUYdXn1rO5++eGEpBxRBJ40zQnA2z0cDfv2MRs0a1kTeiex+jEbue7BvMZ6OejUjvNlUb143Uz9+2etkYgSF2WS4Gm2j2zcVmaPVcYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHur2yB3hUe0UyECrtA9Jp418Je/GDJrcElRNSfAy34=;
 b=vHt1dJv4CKXpSZFi9/9Rw7WxqKiIVyByAxHcRUovZeBPvn25oi4yEw7FrlIlL0fbCmn2XdScettj2L3WB3ruuQ6Q5tHod5j/yT6+xkkCC3xJ8a+wOF1tVQtmZT8Rnsc9BI81IjZQ0LzcD8iiHcL/30T6pqymdf55aKQdFqQB5o0=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by BL1PR18MB4119.namprd18.prod.outlook.com (2603:10b6:208:31a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 04:05:25 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 04:05:24 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Su Hui <suhui@nfschina.com>, Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com"
	<ndesaulniers@google.com>,
        "morbo@google.com" <morbo@google.com>,
        "justinstitt@google.com" <justinstitt@google.com>
CC: Suman Ghosh <sumang@marvell.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>,
        "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net] octeontx2-af: fix the double free in
 rvu_npc_freemem()
Thread-Topic: [EXTERNAL] [PATCH net] octeontx2-af: fix the double free in
 rvu_npc_freemem()
Thread-Index: AQHale8echJ0ENQhBEqBSWB8BTqVhLF2zRXA
Date: Wed, 24 Apr 2024 04:05:24 +0000
Message-ID: 
 <CH0PR18MB4339B5AE1813587AA743C78ACD102@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240424022724.144587-1-suhui@nfschina.com>
In-Reply-To: <20240424022724.144587-1-suhui@nfschina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|BL1PR18MB4119:EE_
x-ms-office365-filtering-correlation-id: 6035d852-aa9c-4f9f-bc87-08dc6413c4a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Z0Fpb0Q0czgrTFgrbGFCbnJkUzhQamlpaVEraS9lclI5ZTg0T1RUam11bSsw?=
 =?utf-8?B?QTY0aXJXUlBTdER2RE1RNTRTbWpNbSsydzlER2ViYlNrWHU1UHhSQUpnL0VS?=
 =?utf-8?B?Q0ZZODlVc05LOEJQRjdaSXo2V3dVTG1WVDFZVDRrUjMxZnZKb2tkelp0Mjly?=
 =?utf-8?B?dW51dHljK29OS01hQXRjMGZXSzFiMDdQMTZCR0pFbmYrU2hFSnN1M3BMUDhv?=
 =?utf-8?B?RlVDMkx6Y3BqZnZPdkVvMFNIb2JweittS25VWHc0eUFEUkdwcytmL3gwWERC?=
 =?utf-8?B?RkxXVHl6ZDVodHNOeUE2UmI2WDlBdCtUSnJJL3B2YTJ0bEtpK3M4dlNQZUtX?=
 =?utf-8?B?UVFqc3lOcEJ3TGkxRWRsVHM4Q2tEenA2SEZOSGZ5NHg3blFnN3grT3paL01m?=
 =?utf-8?B?enJzN0MzbzhlY3JBM0FpYXRBb0NLUG1XQkh2QldnSXN4SUdrMzhuQ3U4L0RG?=
 =?utf-8?B?Q3hpdUxVZG9sS0Qwb2NkdlVEa3FnZ3RrUXc2QWVDVE16WHBnM2grZmZNTmw2?=
 =?utf-8?B?bDFFVDdIODVnTEZVRFhuRnE4RE9CcXdWL3FGZSthYmVZZGcvKzJWK3MzZVd0?=
 =?utf-8?B?WDdRVkdqdFlhZjBYenYzenZtbGdVRFdPQXRDU1B0ejgyZk9jRjlxSWs0Njd0?=
 =?utf-8?B?ZkFDYVpuUkZXUDFYWlJlRGlrQ2JQMmI5TDRiSCtjcjVrNDV2ckNVbTRMcmVv?=
 =?utf-8?B?VUNRaVJEcDdNakwzY3dacDB6RVdRNUNLais5dk9QWk1TczMxamRvQUJMVFlx?=
 =?utf-8?B?eUx0cGZYTmVFOTMwSTdDelNzcG9VZGZWMzFJM2V6QUFkOVNYTWFLOGZvNzNH?=
 =?utf-8?B?ODRNeVRYQmRGTHBIRWRONXk0RXB4UC9sTFJvbXdRQUcxVWE5NGNxMnYzTWph?=
 =?utf-8?B?UjZ6LytLMGs5REtyOTdjTEd0UG42QWZCOEJHZFpHVEt4SE1yNFhQS1FYWWNi?=
 =?utf-8?B?cVNPVFFNbDAxMFpmaDFHMW9zNFJuclc5UzlYcHljaFhxNGZhbXFIdWsvVW9l?=
 =?utf-8?B?VHV5TTlrdER3c3k4Rmd5THJxQjFQc0NlS0srTFJrMnEvaHBtTzhEaEExWUo4?=
 =?utf-8?B?QUtFZVpTOWZxS2hsVWw0VEZYT2Nwdld1a0R1YkJ1WXAyM3o5QXBqODZIRytT?=
 =?utf-8?B?dkxOaGtrVXFwaENIQ1kweTA0OFJqTGdPQzh0U0tHM0tOY0VDT0Y3ZEY3TUlR?=
 =?utf-8?B?aGxuYWMxVnFHNE9Jck9oUndCTXNLZUVHRkdxZ0MyZWJudHAzT3pucEdaOTEr?=
 =?utf-8?B?bVNOYkFBemxWU1VacFpMV0dta0RVVDQwT3lVR08xaStPVUhpOXQ5R2M1Y0oz?=
 =?utf-8?B?TXBNS3NXN2tYMXhBUjlrYU1wMFFEUUZFUjNNTFFIS3ZybWluakZJeWVWakNR?=
 =?utf-8?B?U2plSDhEaXlVNWMzaHU2aklJMEFlL1pUYThBZDcyOCtDelNHMGRaazV6bDdh?=
 =?utf-8?B?em5ZemhaVFhxamtIMCtxRkVrYzVCMTBHd1NOL21XUHVobzFhSEo4OWxmVTE3?=
 =?utf-8?B?REdJK3JKK3VYK0FRWjhaVFl0R3ExZ2NWWndncWxacS9KeWpuRzk0Ymduc1dY?=
 =?utf-8?B?YlBmTjRqS0ppdE5idDZsemJ0TS9kUjhPSFliWm9VbVVTNnVWS0ZWZ01JZkRX?=
 =?utf-8?B?ODQ1bjMvWmFhYkRvc2s0VWUvc1YzOXAyZXU1TDlFSmFVSG5UcitNZjlWL0xT?=
 =?utf-8?B?Sm1KVEMwSmVNQmlIN3JDQmJZUkIvVVM5VUlSc0MvU0ZzYVJPMC8xbHZJdXZu?=
 =?utf-8?B?SzJ5bmE3ZWpnNWs5ZGNCYzBwdnFnTTdab0lPWE9hSm50d05SalNpOGJyTjZH?=
 =?utf-8?Q?2Y9Ai8APwOWW92JB2VlZ46j/DbV/5XsgH2/ZM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eTQycEJYczBYc0plYXFRNmJjTW5jTDUyQWZsNFE0b0RWVjZNMXUwWHpmeFhE?=
 =?utf-8?B?Wi8vZ3dXSTV5cDRCa1p5RnZKWjRTR0p1VGpEaW5VVjAwT0ttWGNBZlBwaW1R?=
 =?utf-8?B?ZFJGVklIQVVsa0NMTmRrZ1FORGVjam1RcHVVazVZandGY0VkM1AvaTl6SkJW?=
 =?utf-8?B?ejkvTk4rQTZSVlYwWVZSNS9ya3hZcjdiS2VXWGgzMXNDTjdkQkFjUmJHSTQx?=
 =?utf-8?B?VlF0M1JndzNvOEJpdUQ4RFR6RlljYjNHRFJYemtTUEZOamx0NEZ0VEtqQmNy?=
 =?utf-8?B?M20raGxtdmgzNytUQlZLcEpnT1FGWWl1TWVUVjZIR3JVNnlNNHdxMkg2bEFJ?=
 =?utf-8?B?NGY4TW5qYzdPUE80UmloT2lSdllZZUJQcmlCUnpLNkNLOG5qUlZydGdIRzJr?=
 =?utf-8?B?aWhJcnFJenpuMXljelROVE5hTzlKbDc4MXpST2E2a3B6aDFwT2REM1hsdCsy?=
 =?utf-8?B?b3kvVWpnN0w2NHY3djhCNG9Ea0ptV3VmUHFMRWJsU0FEeXZGa3lLeTdNUWsz?=
 =?utf-8?B?L0k2R3kxNXZ6NC9IelBycUZaSDZlNVZlRk4vM3NtN0NjWUg1bkxFempZV1o3?=
 =?utf-8?B?enRCMW5seEduMVNLYzh3WEYxZGlUZlEvd3dHeWZYcjJ0a3dUcnRHTFpaOUFy?=
 =?utf-8?B?Mjl6alhwZGE3dHg2cGZNYlZTWTBXSGQ0MVdnckZHQWdUWU9mNXRaU0M4NFVv?=
 =?utf-8?B?R0RJaGpRRkNqNDdBUTZSUXVNVTQvWXBUK1RTdnA0N1FUdTl2TzQ4T3RYc1g0?=
 =?utf-8?B?eUZ1R1BrSmpUVTZxcnBya0tIRWc4ZFl0aGZRdDJxTm42NE9QTllMY0xMSnZ2?=
 =?utf-8?B?aFlhamdVdFdwUUJTTGRiU1BXQ1lyTDhCN1dYeGZWSzU0cU84MkpSWEN5b1hV?=
 =?utf-8?B?SzRoR0ZPam5US0FIR3JXY1lSOE5EZHdIVGZZbGZxd1h6Y0JvUDRyWGEyRE94?=
 =?utf-8?B?cW92ZENZbFlpZzJyUktFVzlNbnJ0a3ZEaUJEVE1DS3FpeFJXbTJ4Z2NpWWFs?=
 =?utf-8?B?UDhZaGdhZmNLdDVmdUJxZUpSaWg0QVNJS1lHcXhYZlI2Vm1pVUpQUnArSlM4?=
 =?utf-8?B?bnluY2dkZFBmSnRZckdCcjNxbTNUMmZicUpjZW0yNHVBVkt5alN4VzRPMXNa?=
 =?utf-8?B?VldqcEVHZ3dzZmlQeFFBam9JdFhDbEhTMmN3ZStpZzVwdkRsYWJGeWxXSEJV?=
 =?utf-8?B?S2VUcmJBcElTM01mRzZYTDJzVnY4MXY1QjVHaTVMWU9pTFNkYWJSVC9pekdT?=
 =?utf-8?B?REhaZ01ia2RySC95WG1CVGF3MEQ3aERvN2RrQWpJWUQvNnNDWTVrMlc2Mzhm?=
 =?utf-8?B?VVhlcllZSnlrSEQ4d2lQTDJNamVWdkpYMTJjNVdOMEJtZWNON09Ea1VYdlZr?=
 =?utf-8?B?YnRka285WStqck9wNzV3Z3pUVXNEMVZWemQrQUlReEZmTzBHak1SUkl2TUxZ?=
 =?utf-8?B?elVTYjE4aXp4ckdFNXFnR2d2aEFPbCsyTmx0cTBIcjVYZGlCWUFtcjlIN2cx?=
 =?utf-8?B?b0xudnM4NjdnaWxrbjRsc0hSSW9RNVcyckk0UXB6SDdsejNPTk4xdndmQzl5?=
 =?utf-8?B?UDFzcExBR1NyWDRKemt3Z1Y0dG1CajlXSW9aTnRXdlk0Q1JMNEEvTkVLQ3dl?=
 =?utf-8?B?Nkw2MTZoRkR2SkhDVnRCSng3M3dNOWN5Znk0VXJUcThMbTVNZ1UvL0ErK3py?=
 =?utf-8?B?Z2h3VTY0WHA0TUxyUXo0WTU5RHNtUGo2MnhNUmFzalE3SHJnZStKeTZ3ajc4?=
 =?utf-8?B?YUxoK0dpNlU0aDV6bVRVTk5YMmpuaUJMME1IdTJuVklHaHpnZ044WDdEeFUr?=
 =?utf-8?B?Z0MzQU42OVNHOWFVSWFXMWhtOTZWa25KR28rK1FHMkVNL3MzU2ttNkF1Q2pp?=
 =?utf-8?B?NTUwVzk4THNYSm9ucG1QclgzY1AwYkNnTlU4MXltR3AveHpkMmtmaW9mUkRX?=
 =?utf-8?B?eE0rdXJpWHlSZm1wZzdIN00vakRJQS95ZU1lRGo4RndTY2c2d2M4bXRWT0Q4?=
 =?utf-8?B?T2tZQnBveVg3eGs5SDd0YklQVlNVNURCdmJrekZrNllpK1BTZW9rVGlseGVV?=
 =?utf-8?B?ZXdyOUJWdXNFeFdweThVTHZtbXdsakJWcXlHTGo0OU5NSytvUU0wbVFhYnc0?=
 =?utf-8?Q?JCXc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6035d852-aa9c-4f9f-bc87-08dc6413c4a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 04:05:24.6102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETSnHu1310E7fveJs9lBK2uivYOmByo9+GXhcDokSfjEfn3tQ7WxfsMEPp6ESH+VYvwJrNrIJ9MzxyYIxPPUkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4119
X-Proofpoint-ORIG-GUID: -VzQHOC1tEcHhOmdMPidkl4LAWYAt4BM
X-Proofpoint-GUID: -VzQHOC1tEcHhOmdMPidkl4LAWYAt4BM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_01,2024-04-23_02,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3UgSHVpIDxzdWh1aUBu
ZnNjaGluYS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMjQsIDIwMjQgNzo1NyBBTQ0K
PiBUbzogU3VuaWwgS292dnVyaSBHb3V0aGFtIDxzZ291dGhhbUBtYXJ2ZWxsLmNvbT47IExpbnUg
Q2hlcmlhbg0KPiA8bGNoZXJpYW5AbWFydmVsbC5jb20+OyBHZWV0aGFzb3dqYW55YSBBa3VsYSA8
Z2FrdWxhQG1hcnZlbGwuY29tPjsNCj4gSmVyaW4gSmFjb2IgPGplcmluakBtYXJ2ZWxsLmNvbT47
IEhhcmlwcmFzYWQgS2VsYW0NCj4gPGhrZWxhbUBtYXJ2ZWxsLmNvbT47IFN1YmJhcmF5YSBTdW5k
ZWVwIEJoYXR0YQ0KPiA8c2JoYXR0YUBtYXJ2ZWxsLmNvbT47IGRhdmVtQGRhdmVtbG9mdC5uZXQ7
IGVkdW1hemV0QGdvb2dsZS5jb207DQo+IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5j
b207IG5hdGhhbkBrZXJuZWwub3JnOw0KPiBuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbTsgbW9yYm9A
Z29vZ2xlLmNvbTsganVzdGluc3RpdHRAZ29vZ2xlLmNvbQ0KPiBDYzogU3UgSHVpIDxzdWh1aUBu
ZnNjaGluYS5jb20+OyBTdW1hbiBHaG9zaCA8c3VtYW5nQG1hcnZlbGwuY29tPjsNCj4gbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGx2bUBsaXN0
cy5saW51eC5kZXY7DQo+IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogW0VYVEVSTkFMXSBbUEFUQ0ggbmV0XSBvY3Rlb250eDItYWY6IGZpeCB0aGUgZG91YmxlIGZy
ZWUgaW4NCj4gcnZ1X25wY19mcmVlbWVtKCkNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBDbGFuZyBzdGF0
aWMgY2hlY2tlcihzY2FuLWJ1aWxkKSB3YXJuaW5n77yaDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0
L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9ucGMuYzpsaW5lIDIxODQsIGNvbHVtbiAyDQo+IEF0
dGVtcHQgdG8gZnJlZSByZWxlYXNlZCBtZW1vcnkuDQo+IA0KPiBucGNfbWNhbV9yc3Jjc19kZWlu
aXQoKSBoYXMgcmVsZWFzZWQgJ21jYW0tPmNvdW50ZXJzLmJtYXAnLiBEZWxldGVkIHRoaXMNCj4g
cmVkdW5kYW50IGtmcmVlKCkgdG8gZml4IHRoaXMgZG91YmxlIGZyZWUgcHJvYmxlbS4NCj4gDQo+
IEZpeGVzOiBkZDc4NDI4Nzg2MzMgKCJvY3Rlb250eDItYWY6IEFkZCBuZXcgZGV2bGluayBwYXJh
bSB0byBjb25maWd1cmUNCj4gbWF4aW11bSB1c2FibGUgTklYIGJsb2NrIExGcyIpDQo+IFNpZ25l
ZC1vZmYtYnk6IFN1IEh1aSA8c3VodWlAbmZzY2hpbmEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
bmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9ucGMuYyB8IDEgLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfbnBjLmMNCj4gYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfbnBjLmMNCj4gaW5kZXggYmU3MDlm
ODNmMzMxLi5lOGI3M2I5ZDc1ZTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9ucGMuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfbnBjLmMNCj4gQEAgLTIxODEsNyArMjE4MSw2
IEBAIHZvaWQgcnZ1X25wY19mcmVlbWVtKHN0cnVjdCBydnUgKnJ2dSkNCj4gDQo+ICAJa2ZyZWUo
cGtpbmQtPnJzcmMuYm1hcCk7DQo+ICAJbnBjX21jYW1fcnNyY3NfZGVpbml0KHJ2dSk7DQo+IC0J
a2ZyZWUobWNhbS0+Y291bnRlcnMuYm1hcCk7DQo+ICAJaWYgKHJ2dS0+a3B1X3ByZmxfYWRkcikN
Cj4gIAkJaW91bm1hcChydnUtPmtwdV9wcmZsX2FkZHIpOw0KPiAgCWVsc2UNCj4gLS0NCj4gMi4z
MC4yDQpSZXZpZXdlZC1ieTogR2VldGhhIHNvd2phbnlhIDxnYWt1bGFAbWFydmVsbC5jb20+DQoN
Cg==

