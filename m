Return-Path: <linux-kernel+bounces-99695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B76878BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38C31F2279E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169D333C7;
	Tue, 12 Mar 2024 00:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="on3AX2wL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ugp8m4t6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897FF28E7;
	Tue, 12 Mar 2024 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710202987; cv=fail; b=WXPslKKhZ9630EKaRg1PGHYu8TQ1cjEDW06O9MvqAAiq+v7PS3DUwo+0ggMf9h0OvW6ULmxpSySFuzm1Uex7JDxKRLumwLbZqKHGufBID3ZCE5YP9v+brVthMuydnWBu3TthkQL6WjDwOk2Hz8jMnzn/RO4grdU9tb0lwUIo2l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710202987; c=relaxed/simple;
	bh=QutcXQOT4+hGePXOwkL4eDKdZPD9EoV+hzjnnKU7txs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sCqfV9XmZHt1vAxQOLlhyCKhxZUu8iDjzqlvfASVkzuf10BAeH0JLviT9YoY0Y9sj+wDH7+vYCky5gbKevNwS9KMJ1YzAmucCwDK7JfGpzzkd7MA5YR0g6qR78Iia+mSTUtJ6ZtFooFSB875IkIpDpShl7SPtBK/28qPEB53vbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=on3AX2wL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ugp8m4t6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BMT4Ej002012;
	Tue, 12 Mar 2024 00:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=X7MrArq3qJFhCe0ow8sj8Uv91jqfAhtk9erRXxEOrWc=;
 b=on3AX2wLIkn5Yl9TmCSZuvq3qg3upJr0DCaDMCPL9qz9KqrSBnc/OP5wmYBCWHmtlGoC
 iAXDTZ7dLxiGyXm739x1U6Ei7fBP6UrEIDsh3v44OFRQvUzTb6/SiRU51Ag1JRK/mU+1
 wUXIHepAynLvBe36rGI3E8ezOFPuYENLtdwIIOPdlE+U3AJ56ZBYlZTZwgUgv3lxU5ft
 LFM8jthHQysM6/pZqhrK53PqAa0KUjfmONfjmnhqhnVuzdgSAPyAuQDe/r9WkpdjfJoN
 Ep1LFvfNWYyUGeT5b9bfjH6kIDo/DOMByQdw1Z0TG2JaEYqjXUSyIqJQaEL/GGi2JlfC iQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftdcp5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 00:22:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BN1NCT033740;
	Tue, 12 Mar 2024 00:22:41 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre768g07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 00:22:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8S5PZE3LPwz6ySambaLX6GHgWZOWBdLI1fvCmhI8B5/yzSXrrbQCSqzIqdFgHMaZhwenCj0H5HBz3KRChVXiDiIUWKNJlkH0PQHeXNzPu8GKtfYBGf+e/KkvH3BgsoO9W9Py8tDbig0gC3Lj98jnQC3u1H4orHOtBMJmxcV2ERfbOWEtm70SZC19jGg4jBy+hmwIn28h9n5qAV+PwkrgqwRQW85xPsytAj2QDlsee2vw0Fn5KepZ7qwTuDXTHNYXgva84argxXS/emJTey5MudoVybZQzZOstlFNrNrGsmrUuU7bFgJtB2spe/hDMKMabICVC/BO79QPZe+3BZCSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7MrArq3qJFhCe0ow8sj8Uv91jqfAhtk9erRXxEOrWc=;
 b=ni8NkQOl0qrYZ2BZ5GlBC5RC2iGrUXKbVEgONsjeCYB/uAXCExAd+YuuVWh/oyo1PBpYcadV2rpqrmqc3S4Oshi5f1KQsrGCVbPL1cUoVenqSA+EZ7SOd8say2+Or+TXEMFxox/rr7/vDpRBBp5rHDmkUr8z/mfRwzETimoi3uXP0YwUvoaqtDrZPg6Fq1tF859wXJPEuRwb+vN/pSHKrDhN/vqlN93LPjqJ9twyFLv+eUdXqwK/BvUoET3YMlDtntMaC+TTTGdJf1EayZuRgngjTDI5bkyEMKd2ST3GGFjAXqgsXJkeQRMQ/Dcgy+mgMlSEHy/lJDPgZNt+fRKnuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7MrArq3qJFhCe0ow8sj8Uv91jqfAhtk9erRXxEOrWc=;
 b=Ugp8m4t6107HfhRWn9qMMEuQR8TXPG+LbwrAiPPbdAGXbAOgAcTN3bzEOJdFZT+oGdhjABh/WSjYBYVo4N0WA2Bbu+0hhxHY9iaz+02F7NPwP2O+gL4VnQRD1HJKex5l2IAJENoIempo6k4AMXc/6CHCksYljx1rzcaZlk1yBVM=
Received: from SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17)
 by SJ0PR10MB4767.namprd10.prod.outlook.com (2603:10b6:a03:2d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 00:22:39 +0000
Received: from SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::bfed:27b9:fd50:e26d]) by SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::bfed:27b9:fd50:e26d%6]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 00:22:39 +0000
Message-ID: <109c30c7-f269-4ad4-887c-c69b6f4cfab4@oracle.com>
Date: Mon, 11 Mar 2024 17:22:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH Linux-6.8-rc5 1/1] ixgbevf: start
 negotiate with api version 1.4
From: yifei.l.liu@oracle.com
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
        "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com"
 <pabeni@redhat.com>,
        "lihong.yang@intel.com" <lihong.yang@intel.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        Jack Vogel <jack.vogel@oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ramanan Govindarajan <ramanan.govindarajan@oracle.com>
References: <20240301235837.3741422-1-yifei.l.liu@oracle.com>
 <51b6c48b-a33e-46cd-9b00-5568ccc529ca@molgen.mpg.de>
 <SA1PR10MB76341C15C41F8AD36254A572C5232@SA1PR10MB7634.namprd10.prod.outlook.com>
 <SA1PR10MB76342477B5AB2541FB8D6EABC5222@SA1PR10MB7634.namprd10.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SA1PR10MB76342477B5AB2541FB8D6EABC5222@SA1PR10MB7634.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To SA1PR10MB7634.namprd10.prod.outlook.com
 (2603:10b6:806:38a::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB7634:EE_|SJ0PR10MB4767:EE_
X-MS-Office365-Filtering-Correlation-Id: dcce74a6-e9d5-4b49-9ea4-08dc422a8650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cRNy9MUf2jdad4M01ndmV6ESD5pD6gy+Tyj2co74oV7uvX2Xuhb9hwVkKstmuPKAi5xeG9+SAM51oYlaDt9LRhHfbFZsmPg5/HwoHPPKcMFiGrzdMBpYnnM2NmC9TdPMYJUz242+iWfdfP0hXpjMxOuqBQfquSPQAx4vGGsc6INpeUFnsXzZSh8XEsNct7QQ91BDoHGfE0xgEdOiRxCBkhEbhtaYGRisazGOJJsstw1NKX3Smf62WFo5cPdbIOuatkT07xikgG3hNdZjGncbFtnot80yQn3SBYDDvOndwokQBp8BQIeRLJwZ9XOYsIu9PZ1FL4LQjTcFLMBLwRuymoz22HP4mT5Hmd+X7jXvf3vTE/2zOzybBeiyqVwacrVGULP9hISZ8GrqSw6TYyd7KK9nmM2eYkGXkWmgxhPSOtG2bRlHWRXWIYlKPIJH0X80hIpApOQlPJvooYW7SQ9z2OsGIdM4xFb2rKWnYEPv0LhIQdHEU+VU8qUbzouGuzZRIIo93hCtiVSzItCXTcrT/4A7YjF8SCdpqkA4S87HDlB2Iboo1Ex6gxpCKDw8+j3wpSMssGaQbhW3VUgponhMlI0iNecNa4u2V8wnPiTytDC9RK5sDRMPzxdyxqqgOXpCnEyP1N/Kh5QPS+zsqnCrdy0JFsY00ZnZ1THWIiBKeu8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB7634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SU5DdzZJRGZQbWNySEt4cWdLNEQ4NTg2T3kzc0svYTZSeVdIMkg5bFZBa2FY?=
 =?utf-8?B?b2syQXJHcmhZYUdnR1ltZUtiUjR2U25rYU9Jd1hmTk1RWjZPeTBmZ3h6T2hN?=
 =?utf-8?B?U0R1akZXOWZsY085ZGYyS0NRZUZMbDREVi9DUnJtMzJmc3VISW01N3k3M05t?=
 =?utf-8?B?OHZVZ0lKSVNsWitWUFVxRmhDU2FCZ2lsWWVxSmN1WS9wZnJ2blREZVFwVE43?=
 =?utf-8?B?MmMyd3JtZmd0dEQ3Rm56NVI3c2dPeElKWDEvejR1SjhYOWdwa2RkTjBmdG9r?=
 =?utf-8?B?RDh0dm0vWHpBUkZjWHJXK2JPYVpRdVNaSUQyU09OTkVTaHY0Vmhya0VpNW5J?=
 =?utf-8?B?WWFJaWkwblJyZWJvM1k2TDVtVDdLUm4xTDdMRjUzaVRiMGYzWDhXcnY5YVdN?=
 =?utf-8?B?OVl1V3ZsVU9zQ1hQby9MWHFKY2UvUVY3VEN2MFRVajNUQloyMDZMRmtqVExG?=
 =?utf-8?B?MHNJODRIbTRGMmVFSFRmUW9WdkNFV1dxSVpldWRVQjBxeFJtLzhETGZyL2Nx?=
 =?utf-8?B?cUN1V210RFBWdGtZWFM4WDNDc1RtK1JvZ0tCTWUweEsrNk1BRWw4RitJeWhy?=
 =?utf-8?B?UWpUTGNteUtuVUwwcEVzWDhPNXdSV2xFekh4Z2lmVkFwOUxJRXhlVzBrcHJB?=
 =?utf-8?B?NDhmck5Uc05iZjBlSjhOb040OGcvTjBEamV4N1BOZTNUd0g3ekN3UWRGSXE4?=
 =?utf-8?B?VTV6OE5JQkRWMnB1MDAvbk91Y01URm5vblV2MlRrNnl1Q2J0UWEwR2lIajhj?=
 =?utf-8?B?VkVmN2ZwYlh5dVhxeUtSWFlrZDl2YjZkb0pvQjBsSUdFRlBGQzRBT2dWQVlM?=
 =?utf-8?B?dk5qYlFKb0crd21KS2VqZ0V0OERwZTZDWUNmRXE4SEtvejd6c29OeU9ockVh?=
 =?utf-8?B?UnVLMTZHTjMzSFNia29vUTEzVjcyWVZNWnd4blZybjcrQklmOUxqMjBQSE1V?=
 =?utf-8?B?bERqMXBlRlVEV2tOTDR1YU0vOC9CTm5IZWw0NmY1MTNLVHhnZm5kMGtZYTQ5?=
 =?utf-8?B?NmFWeU9ZYVBjclhaSGYyMU52ZzBsenhYMUR5N3A0VUFCOHU2eFd0U3YydWVQ?=
 =?utf-8?B?WmxuMHRMcGs3UWxkZmVDcWhmTFRXK3k1aHB0emdLb3hqUkpFL3B6dUhUWFN2?=
 =?utf-8?B?UVBwRndLa3JrTVR2dnQxV0FxMFVQenlIaHdPcXJ1VVJYcitZeEdVZWVRUGx2?=
 =?utf-8?B?VzhGbnJGZnZJNUdmRDBWSDZJa2RSM1hsQTlxUkEyWTBFYjcvQkxCUzVwTEJJ?=
 =?utf-8?B?aVYybDF0WGlkMktMTEtlbSsxanE5ZmJOcGl2SmJLcmpENzhlS0J6OXl4cTJD?=
 =?utf-8?B?a1ZUc0hURXpCY2ZHWFJuU0FuRCtnL3RYU251a1lDWTN0a3FmR0UyN0c3SUlB?=
 =?utf-8?B?VDFqeU5uUE1qa2VnVm1KUXVlZWQxWjF5ZXJkd0sxakV1c0FuRlRNRk5nYVNa?=
 =?utf-8?B?czIwTVNtSjI1Z014RHpUL0xBTVlBb3lCeGdLUGZsWis3elE2Vyt2SUtVZnBT?=
 =?utf-8?B?dzhYUG1JVi9RRHNBZUtDRkk2bGRzWXR5dlBRV3NVT1JDWENVYnpqYjd1M3k4?=
 =?utf-8?B?L0xUSFQveXpDUXcvbjJ6ZmovZ3RtdUp5dmI2Qi9XQzdVUU5kQVE4d3VDbWht?=
 =?utf-8?B?UjBNa3h5cUk2SjRkK2JkODV1THVaQUEwTmdFZXJYZGdpRTA3a3JPLzM5TmZO?=
 =?utf-8?B?bkNlclNRSDB0NFB2WVE3TVNZbU85YjNQMUtzZGQyWG92ZHVPVWUrSGpQQzVi?=
 =?utf-8?B?TW9TbVZXaXlxdW9CRzhHaFVGS1ZuK2tqZkh5NG92d09CRk9CdFZzSXdrZ3Nu?=
 =?utf-8?B?QnJSR05Ha2NwOW9JYk9IejdwVFhoYUt5Z0pJOWZHQ09NNHpWSmt1bjJSUk92?=
 =?utf-8?B?WWc5cmJBcktML3phbk9VSEUxZEZZRUk3enFHZmVpN01tTHNQd3ZzWGhoOEJY?=
 =?utf-8?B?VFBQR3RIdmJEcmQxRVh5Mk0vSUNiZmIyaHV2akJIZEVwTmlFSy9lZWFOOXlB?=
 =?utf-8?B?MXBoTnB5dWRkRDZ3WGFwTlpSYnNMY2NrbnRwdlh4ZEN6bzlJOUNBWkJNdnl0?=
 =?utf-8?B?SHpLMjhoZFdNR3M2SkJaWGFlWXFUemZZWWdqYVFKampzaTJTUVpISnNDbXNs?=
 =?utf-8?Q?gXYujlHbKURgOwM7IMVbNGRcz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7ja4FCE6nBW/Z1x/CeAhLkzodc4cmV5KJSxksULppx5DYUmNvnfeWjadNcenwGcIamyPc/dDTgttHtEQTBk8Yivx3/1UZzZS5YuFq9KZp7x+D0aDmAxf2jIFgBkUnceCymULsykgyCG7Xdgxulr8HzPuxxVaeOFuuiiG58rNuVwHAE0sDO7P27JC0Ydr5QeYO88abFP3Zj658tjOFZ3YrZ4NnKTNgRH8wNpKkWADw7q/Dwwt+5lQdbhu+yUnt6zFbrRExX0ij0z071PytXdZprKS7mDXZP9GXsaACOk+DOOBLnQUK/LllNVQ3PdsjT+WFMwLKfaDDKHS2rssPAMKdnO/FqE2CbCMJ+yLdiJpzJmsWRiOJBoailihpK6MHRbDJsruU3CmsN//xBgE9I5PyPG9TkRR5qUsvyK5mYx66ZN29NQbUyicx5+CfSB96vw5SoQjmK5Ag6I3Jiy8SZV3IuqcVXejOJ/ri5JH6v9X4wej0SjyeY8K5rqqz2dp7VDxTYypp/Jnw2Jg1xhfDAyRH8OiA/KAyB8U/jE5ZbRadRMdGrw5AX86qmZhJf3CQQX4KR8MbzqUZCT4L44tE8HcdZGI+/4oBX6fUIS/INbLAYM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcce74a6-e9d5-4b49-9ea4-08dc422a8650
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB7634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 00:22:39.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaYFDUMbjFXvW1D/7SZrqzkV3rIlE+A2mUX3ARYgsIgsZqCtUkO/SJp196fdQpGVgHsbITKhKR6U0jYV5Br8Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_12,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120000
X-Proofpoint-ORIG-GUID: Aetunu7I5vZYSI-tISofpGHNwiZWaDmQ
X-Proofpoint-GUID: Aetunu7I5vZYSI-tISofpGHNwiZWaDmQ


> Hi Paul,
> I apologize for possible html text in the previous email. I cleared 
> the format and resend them as plain text.
> Thank you.
> Yifei
>
> From: Yifei Liu <yifei.l.liu@oracle.com>
> Sent: Monday, March 4, 2024 1:48 PM
> To: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: jesse.brandeburg@intel.com <jesse.brandeburg@intel.com>; 
> anthony.l.nguyen@intel.com <anthony.l.nguyen@intel.com>; 
> davem@davemloft.net <davem@davemloft.net>; edumazet@google.com 
> <edumazet@google.com>; kuba@kernel.org <kuba@kernel.org>; 
> pabeni@redhat.com <pabeni@redhat.com>; lihong.yang@intel.com 
> <lihong.yang@intel.com>; Harshit Mogalapalli 
> <harshit.m.mogalapalli@oracle.com>; linux-kernel@vger.kernel.org 
> <linux-kernel@vger.kernel.org>; intel-wired-lan@lists.osuosl.org 
> <intel-wired-lan@lists.osuosl.org>; Jack Vogel 
> <jack.vogel@oracle.com>; netdev@vger.kernel.org 
> <netdev@vger.kernel.org>; Ramanan Govindarajan 
> <ramanan.govindarajan@oracle.com>
> Subject: Re: [Intel-wired-lan] [PATCH Linux-6.8-rc5 1/1] ixgbevf: 
> start negotiate with api version 1.4
> Hi Paul
> Thank you for your replay. Please see inline.
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Date: Saturday, March 2, 2024 at 12:20 AM
> To: Yifei Liu <yifei.l.liu@oracle.com>
> Cc: jesse.brandeburg@intel.com <jesse.brandeburg@intel.com>, 
> anthony.l.nguyen@intel.com <anthony.l.nguyen@intel.com>, 
> davem@davemloft.net <davem@davemloft.net>, edumazet@google.com 
> <edumazet@google.com>, kuba@kernel.org <kuba@kernel.org>, 
> pabeni@redhat.com <pabeni@redhat.com>, lihong.yang@intel.com 
> <lihong.yang@intel.com>, Harshit Mogalapalli 
> <harshit.m.mogalapalli@oracle.com>, linux-kernel@vger.kernel.org 
> <linux-kernel@vger.kernel.org>, intel-wired-lan@lists.osuosl.org 
> <intel-wired-lan@lists.osuosl.org>, Jack Vogel 
> <jack.vogel@oracle.com>, netdev@vger.kernel.org 
> <netdev@vger.kernel.org>, Ramanan Govindarajan 
> <ramanan.govindarajan@oracle.com>
> Subject: Re: [Intel-wired-lan] [PATCH Linux-6.8-rc5 1/1] ixgbevf: 
> start negotiate with api version 1.4
> Dear Yifei,
>
>
> Thank you very much for your patch.
>
> Am 02.03.24 um 00:58 schrieb Yifei Liu:
> > ixgbevf updates to api version to 1.5 via
> >        commit 339f28964147d ("ixgbevf: Add support for new mailbox
> >        communication between PF and VF")
> > while the pf side is not updated to 1.5 properly. It will lead to a
> > failure of negotiation of api version 1.5 This commit will enforce
> > the negotiation to start with 1.4 which is working fine.
> >
> > Normally the pf and vf side should be updated together. Example:
> >        commit adef9a26d6c39 ("ixgbevf: add defines for IPsec offload 
> request")
> >        commit 7269824046376 ("ixgbe: add VF IPsec offload request 
> message handling")
>
> Why can’t the PF side not be updated to version 1.5 too?
>
> I tried to add the new api version to the switch in pf side. However, 
> that would lead to another issue. Function ixgbe_read_mbx_pf() returns 
> an error code -100, which should be IXGBE_ERR_MBX. The root cause of 
> this is function ixgbe_obtain_mbx_lock_pf returns that error code. It 
> is likely to be a hardware issue communicating with the Ethernet card 
> (IXGBE_READ_REG returns a failure)
>
> If you don’t mind, I’d format the commit message like below.
>
> Sure thanks
>
> Commit 339f28964147d ("ixgbevf: Add support for new mailbox communication
> between PF and VF") updates the driver ixgbevf to API version 1.5 
> while the
> pf side is not updated to 1.5 properly. This leads to a negotiation 
> failure
> of api version 1.5. So, enforce the negotiation to start with 1.4 which is
> working fine.
>
> Normally the pf and vf side should be updated together. Example:
>
> 1.  commit adef9a26d6c39 ("ixgbevf: add defines for IPsec offload 
> request")
> 2.  commit 7269824046376 ("ixgbe: add VF IPsec offload request message
> handling")
>
> > Reported-by: Manjunatha Gowda <manjunatha.gowda@oracle.com>
> > Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
> > Reviewed-by: Jack Vogel <jack.vogel@oracle.com>
>
> Please add a Fixes: tag.
>
> Fixes: 39f28964147d ("ixgbevf: Add support for new mailbox communication
> between PF and VF")
>
> Sure. Do I need to resend the patch with the fixes tag and new commit 
> message?
>
> Unfortunately, I am unable to find this commit hash. What archive/tree
> is it from?
> The commit message is 339f28964147d. It seems you missed the one of 
> the double 3 at the very beginning. It is in linux-stable from Linux 
> 5.17.y
>
> > ---
> >   drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c 
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> > index a44e4bd56142..a1b9b789d1d4 100644
> > --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> > +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> > @@ -2286,6 +2286,12 @@ static void ixgbevf_negotiate_api(struct 
> ixgbevf_adapter *adapter)
> >
> >        spin_lock_bh(&adapter->mbx_lock);
> >
> > +     /* There is no corresponding drivers in pf for
> > +      * api version 1.5. Try to negociate with version
>
> negotiate
>
> > +      * 1.5 will always fail. Start to negociate with
> > +      * version 1.4.
>
> Could you please use the fully allowed line length, so less lines are 
> used?
>
> > +      */
> > +     idx = 1; >       while (api[idx] != ixgbe_mbox_api_unknown) {
> >                err = hw->mac.ops.negotiate_api_version(hw, api[idx]);
> >                if (!err)
>
> Where is `idx` set before?
>
> idx was 0 before in line 2285.
> int err, idx = 0;
>
> Unrelated to the problem at hand, but enums or macros should be used for
> the API version.
>
> I agree. But for this case, there is an integer array defined before 
> with a reversed sequence of the api version enum. (the desired attempt 
> sequence is from newest to oldest) It may be more readable to use 
> index of the api array. (e.g. api[0] means ixgbe_mbox_api_15, which is 
> enum 6)
> FYI, the api array starting from line 2276 in 
> /drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> static const int api[] = {
> ixgbe_mbox_api_15,
> ixgbe_mbox_api_14,
> ixgbe_mbox_api_13,
> ixgbe_mbox_api_12,
> ixgbe_mbox_api_11,
> ixgbe_mbox_api_10,
> ixgbe_mbox_api_unknown
> };
>
>
> Kind regards,
>
> Paul
> Thank you again.
> Yifei

