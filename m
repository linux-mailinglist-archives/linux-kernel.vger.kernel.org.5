Return-Path: <linux-kernel+bounces-143324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0978A373C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B78B227C0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BEF405EB;
	Fri, 12 Apr 2024 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dSNmv3LY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NCkzT/tt"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA8249E8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954894; cv=fail; b=hh5d6U2wLpXgPtAlY8Uc2CYOno250zQD6cNtvZbXQ2mmSZK2/wGTg2nXIcimJUPu53bxcz3x2mqu/ci2xnjhvJw6JP2Dz8B8reHu9ctlF5nLQtSzne/u7GqkynrGeNUnc8CU2gC0/0WMQlGYt+JR8gqSLa5ZQD+Q2QOSh7cbRsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954894; c=relaxed/simple;
	bh=+GCAMvLN12aVa/VsZX6IiXVNaG1wEIbusTaoV+/7sq4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qhe6uPyfIK3q/QNJJsw6yQRqtYi3K5Q9oyyYHw5IaYOzsAzCkQne/iOBzqyd+wcX3Nn4EpZzOTFUeZ91QxsusywAcsQRgJspXy+wQFaM2OVT/Q3t++uk6XVQvSnXuBQnVMb425nNTE3uZtiSevtmuS8k70D6rTOp2B01m72qxUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dSNmv3LY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NCkzT/tt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CHVQKt020024;
	Fri, 12 Apr 2024 20:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=rr8sG3aEC6VBzPdnzFWTFhCVMYDEqR/2u13FUU+nLC4=;
 b=dSNmv3LYjE0FiBibmoTvuo7zgDdWj9JNap7HV80PoN0VJjUNiDGe5846JedfB0vw7kIa
 AOb/8RsUxrnBgM7eCfOvnDE+R/bomxOgG+9Ubz982+VgMVdIUFEImy4ItXM9kuTIrr6I
 ku38ArVEW5/2aPKGLKG8vXx++lHOH5rsiOgVkzUci9cYdsLVjo2T75r27gibshjh5UdJ
 RhmXo+jXrI3qWQwxz0ZnqjYnCS0Bkt0ytGvqBuV6eMjzufciEH9JXv9mHk+eJRaXMAvK
 /uzRxUhacTrc3bIEFajFWMpsysk9IgjpxjPDhQeBIptHU69XvtE0dh28HZzOrESktgFq EQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xawacvrx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 20:44:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43CK4s8j040068;
	Fri, 12 Apr 2024 20:44:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuhsa71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 20:44:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YolzylWjnRVfpXcYo7tfhhH235MAaO9vmXQF6iH4YLC1r8JElQqnLSM4kkEebie9YV+fIGz5HgohTBiUdLiJmniIBuCNp1fTJlFBlPNpkJiGVE7p6sQ9PHFYCw9PkFP1lBw2fiLrSTAaq9CEsV2nNaggLMcEy59ozxT+NDnndhZo5pOWlUyz8hVBKEiI0RA8hlZQh1cGKX0hcD5taMIgzRRQvXIhJmn/qP9YgNculvI/rLvcMfpkXNtjMxM73mz3eBGhKHWd6UJ4GZgAGY5YuHbhZ2/gyOi4xiZSOzsoQ620wRuujXpMLFyp5TakPERo8h08gJQ3/7OgFsYtLdupbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rr8sG3aEC6VBzPdnzFWTFhCVMYDEqR/2u13FUU+nLC4=;
 b=Kt/J6wt4P1Suawdi9JsaF2FQTPruZZs/nT4AnHOuh8cyrniE1l1T6m4zuNIjaFJUfqlrrd5Np4MrWRnbr8dbB1A3gfpBGWIVtx2Kj02cO37jTp/qYYaM2+peWkfrbGsCsTAiP3QiGigrSs+lIFe+2wH5fxZFro+CiwrQhPXSyD7ydNI1P/UUEVP9BgTMPuPUFh0M10GHNDzE9cR+eZ4ftCCfweWEc9ifnA0D71EMOPE4qhwmo51zIwQ65HyXXI2KsDJbgH2wQq1BoHajcc+ccskpA5WLPi6jH+8zVBsjnHJJLTsmVwm8bAsY4BWnCTUv061vOVz7nRAc2PJZOiUqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rr8sG3aEC6VBzPdnzFWTFhCVMYDEqR/2u13FUU+nLC4=;
 b=NCkzT/ttvQh1/ROKV/Eg6Dre1lS7kRy2cfUE8t3ZHvCZFcNJYl1h+F6V0SgKH+FVwGzwbMNM5uNdnGYzcZuCaRDm55olPv45p2QOkQ9oc1yJgaapMMIiIuelhMsKA3fuA6WEsGWzNIgLX9zs0pTKEMvpJO74+OWND0ZpEt/BoxY=
Received: from PH7PR10MB6379.namprd10.prod.outlook.com (2603:10b6:510:1a9::15)
 by IA0PR10MB7304.namprd10.prod.outlook.com (2603:10b6:208:40e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 20:44:37 +0000
Received: from PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::de1f:84ac:fe86:2865]) by PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::de1f:84ac:fe86:2865%6]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 20:44:37 +0000
Message-ID: <e348dfcd-6944-4500-bf84-c58b8c2e657f@oracle.com>
Date: Fri, 12 Apr 2024 13:44:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: limit number of slabs to scan in count_partial()
To: Vlastimil Babka <vbabka@suse.cz>,
        "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        junxiao.bi@oracle.com
References: <20240411164023.99368-1-jianfeng.w.wang@oracle.com>
 <e0222219-eb2d-5e1e-81e1-548eeb5f73e0@linux.com>
 <38ef26aa-169b-48ad-81ad-8378e7a38f25@suse.cz>
 <a8e208fb-7842-4bca-9d2d-3aae21da030c@oracle.com>
 <1207c5d7-8bb7-4574-b811-0cd5f7eaf33d@suse.cz>
Content-Language: en-US
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <1207c5d7-8bb7-4574-b811-0cd5f7eaf33d@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0201.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::26) To PH7PR10MB6379.namprd10.prod.outlook.com
 (2603:10b6:510:1a9::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6379:EE_|IA0PR10MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 639a5492-4636-48ff-e2bf-08dc5b315e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TuH4iNGuTZ8XCZqf4khC3tfGjhtU7qAyYnlnxV7Nspp/RaL53eQaRO1bmrcfCiy7FPHXFvWC2RkKIas9VSye4JfMaQakAoXFsvwTdkur1YeOY+ZW8HxzwpuzbW8URouAfEy1Ay1bIKc/MhkSvMpQDcv/o2FcCW75PX03PZ1wCA/8lWYpN3D08CdeOMpmnTjboEvXpL+OoBQCblxYIvYWe6V6kmrcWnFjdtnyOKyylmRw+rMlfNQiN2dLw+HkzbKPB4FvKn8tHIDwNNQWP097+CtN7z1QtRyHvAAUQ/xM4mFMnIIlSxEwKp0I8VHVYVJ+nPp00k2u6b8R4bAyM/jAhmBH2TlFgnMwOoEVcRLERbq4G+VFC3cBd7W2zP783BD1GTRtbLTEZGP7Du3JtT2BVvXDF4M9QqDuWVALz6QPgSfk0UDxD23dkNfoorhIFg9sBFziwBA5KXp+1nQA3C/faFhygOCyIO0MJhMYSa2tddP9cUhlYCjlPpoX6QAEFpHhLVFojyG1Rt8Ngx5syAMfksmHe1HafYP6NDJ8Fw9v8VI/MAhvONVuWe3qRGGaqeq1hCdFFJ34X7lE3jG9cIjLyRu0Ans81uH75+Gmb+E8Xi0AZyI+RzoTEN9esfPyipVyz127/ys6BBgGG0NRHAL/++ir8mEBPE3z7Ywcn6SbWmM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6379.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L0RmL0xkanM1Y2htRXdBU2hTVVFTcHo4N0lTMXlKYjh2UXQyd1l4ekt5RWIw?=
 =?utf-8?B?dk03anBiRUYvbVpnc1F3eVA5UTlqeTBXN0huYllPK0FwSlJUalE1NDJzTEQ4?=
 =?utf-8?B?WEUrSXJvbmRCOXFjQWQ5Z3VBZjFsdGRTbXFyR3lqeE95aHpKUjV4TFBJcnJ6?=
 =?utf-8?B?Z1hEK1lPV2tZTlFzRmNvbTEyVnNkTmhXUXR6VUhLOU05L1BHOWxlazlpd0Jy?=
 =?utf-8?B?ZnlBV08vKy9RdUQyOHhuUDUvbzU0TVZCSitHMHdYUGpuZUcrMlJpM3NkMjFO?=
 =?utf-8?B?TUNRdHNKdFpDYmVDY1FlSEk3UVQ0SEE3TTUwT2Z4VVlIWkZwdkdwWEM0VzRz?=
 =?utf-8?B?ZC9UKzlMMTAxeGV3N2xqaDhqQ0xqK1lqZjVuOWhReUFwSnNHNGZJWVBkSHFx?=
 =?utf-8?B?Uzd1bzVYQWpwTTB0RmV2WFBzdUcydzUreExoMitvVmY1bFR1NHZ0YWtXUUhw?=
 =?utf-8?B?UFNIUzZMTWlBeXpuSjFqR08ySW5scmNNb1VnVVpaZFRDcFViSlRCRnlRUFZH?=
 =?utf-8?B?NHBPbHREVjhwV1RkbDJkM0V1Vkp1cW5aY0hOeVVtcmRuZHVteEUwZzZOb3ow?=
 =?utf-8?B?ejUzcUZpUG9oQ3pjMkNEK3B3TkdWb1E4dG91UklkdUJzNGgyWmpvb01ML2xt?=
 =?utf-8?B?bzFlZnA2NzRkVmZoTEZjbkllSWZiZnJuV3VmR1VObnBiM3dETTg5QUFIZGFQ?=
 =?utf-8?B?cHdPZmQvWFJRMTRaNlRwMGNEbmVzTDBlZm5FbGtEeW9pTjJoMVhMTGlqU0hi?=
 =?utf-8?B?R29Hblg1SGwwSUMyOVFLdEczVko3SUF2MnNzTmVYME51QXV2RDZLbTNtQnBi?=
 =?utf-8?B?UW8wQUtsVEhFdVFNMkhtVzFCZlcwOVl5V3dzZTVYZ01ZNEprTTZIeE01enFa?=
 =?utf-8?B?MGxUaWxIZ1RwTjRERVltZE9aMUVocGorbWJSNHpIbU1kcitDTzR4LzRGOGdD?=
 =?utf-8?B?MTZxZTRmSks1Y3FwemFiQkF2ell3OXZBbHBEYmhZdTl1WUNMTFgrdWpkbnNp?=
 =?utf-8?B?bDN0RFZ0ei9aU3VWVnJ1T3lmR2JuNGVtaDczZ3pzaTJEbGlOWVYyVnlpL3Nv?=
 =?utf-8?B?VC9yQ2JLWVYrRWFhNkE3VWg1Wm45dHB6ZnpILzlJZlZCNm5KbGxRWTUyTjRY?=
 =?utf-8?B?TTNDQ1piYnhtT3QxWUQ0ODFNVTAreTVzRHlmQ0JuUXZEUkF4YkFMMDdWRFZx?=
 =?utf-8?B?NHZsK09rR2RxU0JLNUsrdnJvQzNmRHk1VUxNZUpjWExzWTRRY2V1c2x2WXJH?=
 =?utf-8?B?SHBtVWE2K2pCSWxsOStZMWZsT3dUYkVKMVp6UVFvTXVETHcwWXZxNTNkMTZC?=
 =?utf-8?B?MXVnVlZtNFhXK2U3WndvUHFrZWJsNE5ycmZZK3AwN3JOUHFOdzErYlRJRS9p?=
 =?utf-8?B?cEZkUnM3TE52OHNYNnNpUmtXWi9xaWJtL2daRGV5QzdvK3dHRWhPcHhla01P?=
 =?utf-8?B?a2lKN0tLUDR2V254bnEzeDY5YmZNR3JSbHdndzVLblBhenBMM0pyQWYzcFZM?=
 =?utf-8?B?U3F4L2NrME5RZGphMEEveFpHdEt3YVhRekZ0MCtLd0h0ZGFHVE95WThaSVJX?=
 =?utf-8?B?RFkvaTVENkxZK2Z4VXNMaG9Oek9PZGxOUVYxeUYyUmh2TkI4Q05KaHh0a2Qr?=
 =?utf-8?B?dEZyT2RuMU5iUlEwK091cHk2WFJRZVJvY3RaQ1l0Rzl0QnRyRSt3SWZNUStw?=
 =?utf-8?B?bUxBTVg3NUJ6QmRtZWRkTVQ0MEUwMjZxdEZHVFpBM2NaUzFMREQvekozb1pK?=
 =?utf-8?B?RlVkejNyczdKbTMrblJwM0FJVDd0Vm93Q1d0b2c5eGY0TWVZNTBFVSt1R2Za?=
 =?utf-8?B?bjBCQWlmVisrVmV0YnJNMGpjU3VUTS9QSWQycG9CREcwakpkZ24rcUhsWjFr?=
 =?utf-8?B?eDg2QlFsMzdFN1FtM2hub3VXdysyVHJMWUc4TXRsQlBFRWZrSFBlTnVmZUlX?=
 =?utf-8?B?OHJJTkpBdERqajc4YzhkU1d5d3JQN3RubmhTMVpYTEppbkk1bG5FSUNPT0xn?=
 =?utf-8?B?MHE2b1NTNk5aR2Z2UkNQYW1iOUo1SDVNdklUVjdxaVpmbmplbXBleGxWOEZq?=
 =?utf-8?B?ZEJWN21nVStsVzVXNGFYK1dCeDh0U0JrTEIwekRuV3BXNDN2dllGT1RKeEV2?=
 =?utf-8?B?UWtmYUsvdjVXcUQ2aTk5Q0l4TXF4aVphbEZvWnpGUGN3SkR0SXZhYm95Mnd2?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uOq+Dw5sIKlZYu/rKmvAUWT4Cu6i5dNRESaWhIEdepgddLUhgo1w2f/1ozzS0zy+ox0onsuPKk8tsJNh3p9wlvH18kjrBoaZ7bpDXyfDgVRplWkA4N+SHMudn5CketCPUXcTxS2XNIydN5fhGU83ogsy/M8shxl4CZd405VZQNgBxT8ZCSK1I5RFG/Z5IekZfpngjviaBEiyGHuZFQTDcywzzDyZZQbU3LiKDcOFQrxKlmWGOyh5GA1MJMGt7PMHiaRuMcry67oPcT6np6I2lOdaCpJ0TchkePBMn8HQR7k8g3pY/mD1Unl4r0kRIK14RQkgrHdiEWVmqepzEbEv9400oDn2UsXeRAfokBnP1LKZpzfYv0tVukKXY6/EsnGu//vOCNzgp489c3L1aUedZ2AC41RnYs7WpFpFuU3hau03KjKeCZ6ny56O1NBlnm3s32oCztJAr7eF2X1ARMwfPEL5mo/eY5xDCQDPX1pCcIW/zPgn/5WJk3dt2G9vQtIaXIVRkpf7oWKXBRL09uvJ4/VuYTV9jmH9KP1/T6ye371us9Jq2Y3tPUc5XUPGk7P9T0x8+VOiOBwqBAR8fc9wu8n4OcpNuPjMy5u73cHIy/o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639a5492-4636-48ff-e2bf-08dc5b315e48
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6379.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 20:44:37.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXaEC/8V5Wgo4jnoxH8FjrQkv9AsRinGTJUchO8r5k/dDz+W9TrFOhNYid2LrC/C5dP2DKgY1p0M7gFfniMDxnrRiTdnbvzhd/E2DTOhhTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_17,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404120149
X-Proofpoint-GUID: _hymhvOvlLqavESBBn32oOiqMkp44G6j
X-Proofpoint-ORIG-GUID: _hymhvOvlLqavESBBn32oOiqMkp44G6j



On 4/12/24 1:20 PM, Vlastimil Babka wrote:
> On 4/12/24 7:29 PM, Jianfeng Wang wrote:
>>
>>
>> On 4/12/24 12:48 AM, Vlastimil Babka wrote:
>>> On 4/11/24 7:02 PM, Christoph Lameter (Ampere) wrote:
>>>> On Thu, 11 Apr 2024, Jianfeng Wang wrote:
>>>>
>>>>> So, the fix is to limit the number of slabs to scan in
>>>>> count_partial(), and output an approximated result if the list is too
>>>>> long. Default to 10000 which should be enough for most sane cases.
>>>>
>>>>
>>>> That is a creative approach. The problem though is that objects on the 
>>>> partial lists are kind of sorted. The partial slabs with only a few 
>>>> objects available are at the start of the list so that allocations cause 
>>>> them to be removed from the partial list fast. Full slabs do not need to 
>>>> be tracked on any list.
>>>>
>>>> The partial slabs with few objects are put at the end of the partial list 
>>>> in the hope that the few objects remaining will also be freed which would 
>>>> allow the freeing of the slab folio.
>>>>
>>>> So the object density may be higher at the beginning of the list.
>>>>
>>>> kmem_cache_shrink() will explicitly sort the partial lists to put the 
>>>> partial pages in that order.
>>>>
>>>> Can you run some tests showing the difference between the estimation and 
>>>> the real count?
>>
>> Yes.
>> On a server with one NUMA node, I create a case that uses many dentry objects.
> 
> Could you describe in more detail how do you make dentry cache to grow such
> a large partial slabs list? Thanks.
> 

I utilized the fact that creating a folder will create a new dentry object;
deleting a folder will delete all its sub-folder's dentry objects.

Then, I started to create N folders, while each folder has M empty sub-folders.
Assuming that these operations would consume a large number of dentry
objects in the sequential order. Their slabs were very likely to be full slabs.
After all folders were created, I deleted a subset of the N folders (i.e.,
one out of every two folders). This would create many holes, which turned a
subset of full slabs into partial slabs.

