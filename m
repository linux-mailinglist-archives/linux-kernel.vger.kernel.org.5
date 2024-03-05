Return-Path: <linux-kernel+bounces-92439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593F687202A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137A0284E27
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152E985C7A;
	Tue,  5 Mar 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fMFRwzov";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H+9DiggR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C4029CE3;
	Tue,  5 Mar 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645410; cv=fail; b=pxm//g2Y4IcQBZjtrqE8iJzwCyK/1dDrGd2l2PO7+da7CX1GMLEtEExbDi0WndoOd1wW8KMe+fPrLV0ylQL+mNyrbi/ZBJL2ipiRRRRHubxtpTrddSwl7mhHae39OmkkDkr3LKoSKad4GjFGmE1Frx+m0TmYG8wNLKC3RMd/VLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645410; c=relaxed/simple;
	bh=lc06rAJESL7JFAJGlHBOglZ11eURzYz520qopt7df54=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ABOJ2mddpzNH+9xTBUa2bXtMB9lFeZx9ZINy1LERJWplFneaayjfcOEztRBWK96OYSdMiPYvcKkbTaoM8xQsvmvILVG87sn4zXfYnEkgPK2P4bmMAomdFnVWxn3ig/MK7J1bMXnQ2B8WwVmAlxqjFvlAcQrdsDZ9ZI15m14rqE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fMFRwzov; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H+9DiggR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4259jTjG013889;
	Tue, 5 Mar 2024 13:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=SUZRZwP0s4CkFjaVDOyUNIvltYgVePb6XI10k9wEqBc=;
 b=fMFRwzovTbPwr//i9K4+mPMpT/75s8PdctQaGGyXoBwI1KZ44aJ6rnJcx8X0+eCjf8KN
 V4hT4mgBjS0s2gD42YExrN+d4AjpGW/CipT8kCPIXlM2z6FQucdc38TjPy/bezNWpplc
 RbZAZhkJWx6tOFZXjHLNTnlRahxcLe15pln14MPZZL4fARdGrWbIoRYK/bbiZ0Wper5F
 AUr8lPWDITbJ4G+JUQ486oyYjHmp9wKTR3jGyoUpdKnEDBM6HS+/NnebrZweU2NTOT1+
 QzmtS8CozMLZNvgwIK7/CgQJTcBzfs7AAgAkSipjXzxhgYudDcnsunijW5LA5wep4J5i Gg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkvnux78y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 13:28:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425D3cAT027496;
	Tue, 5 Mar 2024 13:28:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj81y4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 13:28:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wt52AAoAiozU39lwFOUqb7G976xVWtJFgfWhAB5puxeT3wO2r+87ZKr3g4T+Vx2Bo9j+PaIzOjqklIynhKqcXq0WVtEJH2OyjJfH0w9ZDYvxsJiV+6jNvFkSXVw7Tou/nbkJ3hbLW69GbAJOQUPwtnSHvcbN3pqXhfgTa0N2HlLbo8YzjwFO03xBtmWu6E8gYjO0YBFziNsYnXCBTgR54zNwP7DuMofHwL/M44SSlOUnweJvB7bbjDHzOt2qjWfDg7louSsQmKgvmAHyK/xV0K3DneTG2/giC+Ip2tAayMYitkNDPZg2PxCOZYh0qtooSGJ69ZZh4HQQHuVb9MvDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUZRZwP0s4CkFjaVDOyUNIvltYgVePb6XI10k9wEqBc=;
 b=UWEn/k+vHdbhJgYH29BdCCuSAt87JprX4iV+xl8/txYqs+oT6gnHXhv4r3+h7Sv2QzovsRp8CVVRYTjQQatePTowLUOvOSfJj+XUV1LGr1AKPwjg5fYffeYnk64r93m/gw1KPgfRdqleR+VzVFCd+MwHD+CAOfwQvpNwEEeAQ77kMWuSyqB7qas0PdvjAG9/2E91nKf8M2iIgnfIBLo3YY7inP8aNbpP3evqOGus4b5jAtlKrKcZCpkGXeqdupOzbTB8B3d2Oq6xLoINfcM2uPYvlHEp+MAimf+IbzMthPaGsdxo4QcvlSavp/sZBaC2Jwd9zMMfAM7gjNdoPeDfdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUZRZwP0s4CkFjaVDOyUNIvltYgVePb6XI10k9wEqBc=;
 b=H+9DiggRLKytsHE5JawUtPwwMDlw4n3rU27GU40J4I42M+Oo93krkaYLg3UKJABSCgtv1xJbAmRURyX5eGd+O11DogwxNzV6fREqzpsvu1t73dZibRasbj0w8LUCFZEFN086tRzF6JanCTpTaZr1TIfdhH4EM8ImYYzSKbXREVQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7082.namprd10.prod.outlook.com (2603:10b6:a03:4ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 13:28:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 13:28:53 +0000
Message-ID: <f54e9c30-b483-4dae-9b22-24feb4fc289e@oracle.com>
Date: Tue, 5 Mar 2024 13:28:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] scsi: mvsas: Use LIBSAS_SHT_BASE
Content-Language: en-US
To: Jason Yan <yanaijie@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        dlemoal@kernel.org, ipylypiv@google.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240305122452.340471-1-john.g.garry@oracle.com>
 <20240305122452.340471-6-john.g.garry@oracle.com>
 <8834df38-413d-855c-433c-653d7023dc8b@huawei.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8834df38-413d-855c-433c-653d7023dc8b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 709e14e1-5891-4fec-6672-08dc3d1833ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z26Bg03wIK/C9IvHsLppfhijkAbXa5fivl8d/yKfUdfUiJCs/v6TLe7LVpBL9FykK+fGf2rMsURiW+RvXKSYyEH/TQaIf8eq72apGkSjZJk8m7bqOUas2dl6P5cVB90D4xD30aKOgTc9xP2OppSsrOXqGtuFc1JDlOVpTg6D8Xc/mbL+Da9RupwB53XaQac/YxLuB9wTvsngJAQ3Zqqz9DwZZ4/Sy0EPyrIb7bL0IkD2i5VV8yLag1NK5uiis0x/0MrEwz7VzQ39WG2eKcWRFvAgKsRzO2FFQpF7s4uRMu9DbKdL6FssqwvLdaBHWG6Kw7RIrm3OXPzHOwz61PAs+mHuQlCBiS7Je6Z9xaomo4pj79ZhYI8/JsvVzg0ZzCkwj1fafHOeye4nrMiWMKc7yMPxZxPpUF98iIKrGU7iHDpduhcdBlKf+tTLMVoIABNEotdcJiK7mwwRBzbUFrlypMgVV8fy+DtbF2YelgX/H0xi4NlAzra3nN7zekQfcvrBma3kcbO/1jVvtoyPxwC4gU2c3FwTt97LrZva/e39FcoSCgV2lcWNM1MlIjOvkMXXkFkZMTlookZu1kWYsbzZ5MzOvnXauVPzrLGVQ4ngr8b7y5jFshb2MkD+acVexfESKpGRn/xZXzzwW0Xyb6qcZxq5gBFLlvjA3YtmlD1bvzc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?elJaWkl1TURMS2tJK0p6TXFxc21VdVRwdFNtclBMT1V2SjBKeGNjcVFkRnJp?=
 =?utf-8?B?bThRekRYQ09vM3Y0YXdkck9DZ2lQallNd2k3THJiaEVFaDFsTXQxMWNPTVMx?=
 =?utf-8?B?MndNRjFVOWc4MU0wRU4rbXNxM01aeFExdHg4a3NBT29sM2xSOWRqdGt5aDBO?=
 =?utf-8?B?QkVxYitxNXJSL2VJRWIweTZIdlNETlJNUjUzbWVVTFRiMmEwQ0Q5dmlFQXRP?=
 =?utf-8?B?UG5jZU9URGN3aGJjdUFEWlVHVUhwQUlnbTRPTzFwNi9TTVNwdUlsaVN3Y044?=
 =?utf-8?B?NG9JODBjTkZHMVUrTGhxaERKNEZ2UEUxMENBL0dac0pEOTRhQ3JteEo4Wkp0?=
 =?utf-8?B?RjJ2ZkZwZTREbzRhVTdpY1ZUNWs4U2xaKy92OGhsWHVrVzdyQVVLWSs3VTI3?=
 =?utf-8?B?M2hxS0l6NDc4SDF2bDBFVDdIaU9jd1Q1eWtOb3BMeFBaeGJJN2lCMU51SGRI?=
 =?utf-8?B?UHUyRFFHV2dpZU9yRVViSktjeURvdlRmOUlweVN2OEVKa1dJdUhXVWNYK0Zn?=
 =?utf-8?B?dWlYeHQxMDVsd3NNTm9sZmg4RFo0YzBiT3FEdlRiWEQvS0FZdnBycG80cm14?=
 =?utf-8?B?bUZaYTBrSjEvQ1RWTVU4NlhRMXpBbVN3WWZ0SUtXN3VKdjVseEVrbnpucE9Z?=
 =?utf-8?B?cDRNOHlyendJaUd0dW5mVmZscjVRRS95WUhaMnF4TEpaY3dqU29ubE9uMTk0?=
 =?utf-8?B?RitlbHpINzBsK3pkRGZsYlV1cGhCcU8yaUREMTFpOEpqem4vb21NREFiN0Jp?=
 =?utf-8?B?YnlJalkxaXlwWlpJRkRXRjNLaGZDSXpheWpVbkptOXFxTTR4ZlE0RTFlRlRj?=
 =?utf-8?B?N1FPdkVsTlBNMnB4VUZpTWhQOC9vWnYxUWM5MzYraURwS210QmpvWmZVVTE2?=
 =?utf-8?B?OWpsR0ZOcnJaUkxPU2dPYXZOakdaOE9tNVJCaGVBbEVrMUgwN09jOHIxQlpV?=
 =?utf-8?B?SEJrZ3ltVGdMT3BYOTErRklGbWlqenhKaE9WaGRweGV0K0RtUkJwWVpab0U0?=
 =?utf-8?B?YWxDSlRYUHRCMm52c2JnUTRmZ2NCT0NwMG5yUzI0RkhBMCtjRHJMdWNySzVx?=
 =?utf-8?B?TUVRRWlSWjJVSXNUZkMwOGdZWVRPYmswZkptRjBmNEk5azhFaFdodEpNZlRt?=
 =?utf-8?B?MnZMQmJkck80OHFrY242NjhkV2JKZml2RkIwSjNpeFNmOHFZKys1b3JhRkNX?=
 =?utf-8?B?T3ZWRUliUEZBZXZ5Z3cwWUtaUytoM2d4UWNaR3ZWM0tNZ1JLTVlCbjRqb21S?=
 =?utf-8?B?V0F5dDgraXVFZFVsSlFvK0o5ZXhHT1VtMUVxUG1aL1NPNnpxUmoyQUtuK3dh?=
 =?utf-8?B?MVNEdm9ZbjF6MVAwQVdYenJxNC9XcWdUUFBnWTdLNDlYSnRiczdLeDBDQnVm?=
 =?utf-8?B?VHRxM1RQQmVlcmoxWE9GWXdMOElMUzlHclJmeDdyMWNVa1RzS1NTNklRRFYr?=
 =?utf-8?B?WTh5UmUzU3pObGE3elUvZlluZ3F0eHNHZEJKZ2FjMmVKRG1TWmtlcXd5K2hi?=
 =?utf-8?B?UzZwdWMvbEVGeGx4d0ZsaVlzUnpKUlBqTmVDVHdpcGQyUmNwbTY0OWxaV0JW?=
 =?utf-8?B?WWticXVrcVFlQVYvWHUzUk9YaGk4TjIyekhhcnpWTWVOd2JiRkZMUXRhcGo3?=
 =?utf-8?B?MVczSnZBUUcxU0tVVWJ6YnREaFNxcEh6bG5PQjNkeWV0OTFBZ1R5REs4aDQ1?=
 =?utf-8?B?OWVYT2c3TzN5SW1PaFBkTlRRejRCNWNudXVUYW9JMWR4U25aQWM4bVZvM3Zi?=
 =?utf-8?B?Qk5MWklycFFBTlh5UVByREQvdStHdjFqbFAxdkpxVXZzMm93aDVRenlyRGtE?=
 =?utf-8?B?T0MwMjRRcDBCOTRkUWU0ZG9GVzRLN3k2VUpXK3VCWUdkdDRicFNvOHc4Nm5m?=
 =?utf-8?B?VVRJYm5RWGxlRlE3ZW9yaHUyRHdEazY5Wk9PTjFLK3FlSldWOExuMGEzZDU0?=
 =?utf-8?B?OG9Ibjl4NEZRYUhWdGZ6aGI2bTZDeEk1YTk0ZUlMTFZlODhZUjZERVdhaDVv?=
 =?utf-8?B?OHR5WndVMytQd3BSbmhxbXV1c1V5bXBRbmJ6ZnlJVmRBdFM1dHowNk9IUEhJ?=
 =?utf-8?B?cHpCbUdRRkNMOWNyK0MzM1B4RW9Kcy9jVE1TN2RTZTJlTkRYRWlrRkdGMW0y?=
 =?utf-8?B?UTl0d3BLMXdTYjBEbVJ4K3VOeWlZeGVHNzA1U2lRY1BCUm1FVUxjY1ROMjJ2?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jsLW/Y7V1kVRix5qBIQyuGPf+uYkE2jvLtRpCH437FMlOwh5kDAEb8tTNfWFmdIE0yAXl6z4yJ0WWzihE/Sd1FvQLSd7TC17Uc3zgNSSLioJqhXbNn6Fm+BIgt3HceN4+0/IQ0Xl9KPaLoao4M7WPTYG/oNK7B0MVNm5Ho6kTQRdNwlZrb0QXTDJ+axdI7Ii/F86cIoe5Iw4FHekrVeryYEIEHezjoaAfEugbYrFoqDYKZVe0gy3NEjBsTtNYHkzWu+QyH930nyyJW2EDHxaw1rNlYHMUqvwFqq59kdScjDEsHLl3+U+yk4f5BSPTZSPosBQKYZCMhfPvaXiXce7R7yYlwOJnkatsOeYvCgrpw9gCMkCiQOwglYkxS9R5zBP36FDtfm2TSXebiH7+cPsOS0woCk1g3hHEtzAcwozWlVhnCFcS56m1Aph36MAGXePZLLmzERdiaPbf1UyQnhXu8eSjfyApXqhWIWDCNM2PNW2ySh1/WvUOncgUgDjj9UpuiMVL2xrtpm8Fv4xY6B++MzuVPJY5VdhlSfa4a+xaspPnHY80Anob3AOwAAMajXGtk/ex7SXuFOrVLbRMFsPSlNuS28f9zidMtxQUrD/cCk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709e14e1-5891-4fec-6672-08dc3d1833ae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 13:28:53.7158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukbGiafoPSDU8XZZ6DeYreCSELl3Ml4Fecnz7kpZqksnM/bX40D8NLXNA28NUT1TwrnxoULKfCfN16Q0y0058A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7082
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050109
X-Proofpoint-ORIG-GUID: pPlGkpzCHNOa6mpxq3VRiOs9Mdxl0n8u
X-Proofpoint-GUID: pPlGkpzCHNOa6mpxq3VRiOs9Mdxl0n8u

On 05/03/2024 13:19, Jason Yan wrote:
>> -    .ioctl            = sas_ioctl,
>> -#ifdef CONFIG_COMPAT
>> -    .compat_ioctl        = sas_ioctl,
>> -#endif
>>       .shost_groups        = mvst_host_groups,
>>       .sdev_groups        = mvst_sdev_groups,
>>       .track_queue_depth    = 1,
>>
> 
> Doesn't hvae ->eh_abort_handler too.

Is setting eh_abort_handler actually really ever required for libsas 
drivers? We have sas_eh_abort_handler, so I assume so..

Thanks,
John

