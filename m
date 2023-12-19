Return-Path: <linux-kernel+bounces-4948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E0F81843C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA922845A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3494134B3;
	Tue, 19 Dec 2023 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z677ve5z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jBClzI6d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9812B8C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0KmVY032355;
	Tue, 19 Dec 2023 09:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=2R9pj7l1SIqFTVh1zwxuWV3QaGOzh8MbpxD0Cq3zFs8=;
 b=Z677ve5ztGCtv9FPWFcxfBCZ8lMDpAcBz+zWm2vLadLIvVpUgRVuFTfa7z3MwJ1/4hHa
 32PnWppchKzWlx6SMulpoyQggtSHmSfLOtzfcmcjeu/X/aRIzhNDMFLbidMJI9f449he
 dZfMrySKn6REw6lKFFKft4qSrihIp3HR+4w18liU6KoazQqj5qFlifsADdknBkp9pD1t
 uPeEKwyGvmnUe72Y6j1DrOyBTMYGvRXLIPVNz8BgZqWq/XS/93dHyGP+GGwqAaoyy0zD
 GgDX3V6x2YaKvdHwXo5lSmPGlu8aAA9gUVUJZOvIdQywNAd98+ZjZJ7WCSy2JrIgIsWs Hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12tc5c06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 09:15:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ7x19o027634;
	Tue, 19 Dec 2023 09:14:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bcjrn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 09:14:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccITgJ1ULwxaINtF5qyRFe73pN3qSE+17QqYL4Yk4zKn/DVYa7x2mPaJmoNz1D3rZXyrakSc5OmENm3uIf5TecDK0tg0KFcp73m7JT2GkIei2ubbZPk0HOjotzekUNXeVVvmJDHiaImCct12XRCNQ09q1JTBDbZmquiXs0NgtWNpIXSZ70loO8uA2ifeLXgiwLmzBXsCVmniJZSu9Ak0wF+1rI8ZMoNpqhRF143ZDNMuI71Yb0tIBQbuY7D3arYtBN9RNwYbOm1ZKAn48d7XOaNOkZ9Utn1nX7Ohum8DL8yjrWkOzhgOndlP23PVfxn0kwGtSK362IsWUMkmZIEeaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2R9pj7l1SIqFTVh1zwxuWV3QaGOzh8MbpxD0Cq3zFs8=;
 b=QFenYwDEAOD5GW0nmJYWWGmE1+SQNNUc3lRSIDdx0U2n7tdRXxAhYIJiKRLJiSeZvkFJpKWKYkS3n3CoVrwwQIA+xikBArKOq/K+JVPhYUQzn6y09J1HBt82zUUWj/KrYs9APC2olIKe9wVnd0fYsLjmCb141sb0oi8QU68gefoD0Uij2bgT23ZUU+GgvhnlSzjI8HytO/uW2FLbfIn5R6NOnSA3EMJi38Vvx0EdpBJZ1yDNU7aISV4HLF6WeuOAPbkNnmoX+VHoXPKaDLdlTgwW+wRNuHUQFfJi9dCnMyPlN0ZYsYNixaghb0YjYpkHSCC1ikeBDtT68EvqSWDsKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R9pj7l1SIqFTVh1zwxuWV3QaGOzh8MbpxD0Cq3zFs8=;
 b=jBClzI6d4g1zXAoK2/ZCDoh5XWZMWHvtDGajn5LM6D910ytbNvDuAVehi6xewYGyj7rGBlKTml1Dz5NEbl3Am9zjmir7BrWdoJfZvZx3AqjQlfcdPDYCLqoS7+V2TFt5gFL2ivtLC/UgbnAC8c8Upo1Lv253VGzBgE8V+mJJ1MU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5085.namprd10.prod.outlook.com (2603:10b6:5:38c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 09:14:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 09:14:57 +0000
Date: Tue, 19 Dec 2023 04:14:54 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: maple-tree@lists.infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] maple_tree: Avoid checking other gaps after getting the
 largest gap
Message-ID: <20231219091454.5ouig5jnvjziol4e@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	maple-tree@lists.infradead.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231215074632.82045-1-zhangpeng.00@bytedance.com>
 <20231218202014.mpotsekdkszasn4t@revolver>
 <20231218202845.buffbdq3vhpiv2py@revolver>
 <00ffc2e3-446b-473e-89b9-a859f36e43dd@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <00ffc2e3-446b-473e-89b9-a859f36e43dd@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::30) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a5a471-02db-443a-1a56-08dc0072f84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yyw6AZS8lh8FJoa0NZ7tS4N5qmrP1STB2tysIOnEGKpaXLheMpcvTA2GQuMRIlY9XHqqAVotuZ+0JB9V82SenKIa1CD3kX8OpULKh0VUdiUu5lYDpj51Zy5TX6rMmNwUS/petYhAs5IEVcPWGHpbFjecLsah1VNSYwSTYnjGmnxILVvkknaqZ4qOQBlTUCGobuBPxl3hU/BCqQH9Tqznb3HdwHVaUQTdUMBuuYlrhgLRaNeJLYM6suYsDpJ/c7mDnvrSNE37hmO93DCYzzzBcOg+0CVj6xJKocAnnUJM/jNac3cugr9zoI63aqT0t1lhuVD6t+hV6j/uWAxfR5jt5Sj0d72OJ8ll0ySjcludLNT6tX7TbkZ5oYd75uuI5DKNocatu8/gTr6MJMZxMahLhTU1dIBEeklpH1xQ4UcQZ86UDKXRwR4NqGGDtHA5lp4NXFGemv3sCgVwf3D+ipJURP1m1Ce1o8B+Ub6LPh6ia7j8Us0+8jbdRXt0c/KETJ5drvV+qcnuJyBfBTcNfNHylTmT4g61WK9waj1i0xifTmQm6uwsXNpEidJS45GPJEGV
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6916009)(66476007)(38100700002)(86362001)(66946007)(1076003)(9686003)(83380400001)(66556008)(6512007)(6506007)(316002)(33716001)(6666004)(8676002)(8936002)(478600001)(6486002)(26005)(5660300002)(4326008)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dzFXU2w2U2pIU0FEN3Z5Z1M0WFN1U1pqc0VhdE5RWmNOa2ZSOXpsakUzTnIw?=
 =?utf-8?B?UExaRTVmOW12WlpqYTRPTzBvM1dTeXFoN0VkR2g5NFNEV1dpeDdaSUhXSFBq?=
 =?utf-8?B?cCtRK0xHTDIzSHd6RXVaTVVtaXFWbzAwZUxRaEJheSs1Ry9uaUtKL2d5MEFy?=
 =?utf-8?B?SHdRVmh6eS80V0VqTmt2TnZaQTlra3Vkd0tHeU85c3lOS01QcmhkVTA2YXha?=
 =?utf-8?B?MUJsTVRBbEkxMlFxMlgzYUtYU3EyenNMNDZIZmpqeHVYa1I5RlN6UkJlWkRQ?=
 =?utf-8?B?MTVqTkNhcW9XcC95TmczQ25NTEY0QUlTcTJtK1BOVkJMcy9IcU5DSlZGZnp5?=
 =?utf-8?B?OFQwOEJaNjJCS2FrWE4xZEVheUZsYXdWZlhpQlQzYkh1bElEMWtEQk5hc2I2?=
 =?utf-8?B?MjVQc0hMWkZRbFlyTFJ2MTNFSHppVEFkNFdmTkVqUjZHQUFnUlN2a252cUlv?=
 =?utf-8?B?ODVNUm5jTmttWXAwQ1lnclRRZWNEdXRkYkZZM0Q1OVdFQWpmeXlDTkdPdzky?=
 =?utf-8?B?eHljQXJ6UThabEt1cXBEdEJpNlVwbyszVjJNL1ZTNm0yWkE0c2ZiS2VjaGRv?=
 =?utf-8?B?V2RXdnVRYTl5ZFlZMHcyNGk5cUhKRVk1NXFXR2VLZkxFbHNBenpOUkRNT3Jr?=
 =?utf-8?B?blo2TVFLZzEyYVdURjBwL1IwbGNBaDVHZCtMVEQrY0xnLzNqTzVKSDYwMHdn?=
 =?utf-8?B?VG02bnFEaEc1ZWNUaElwdWZ5MmJGNUxwUlpWaDZUOXk2TExtSHpqZzVZczJR?=
 =?utf-8?B?ZjZCcWNGeXcvTHFKSmJkUHVyOWpRb0M2QStzNWVNOFNLNkFzalNtZytxSWR3?=
 =?utf-8?B?MlhKaDMvcXp4Mk5xR0JVTkE4L00xVnM2T1lCVXlGemFrcUNuRmlBVmZnbTcr?=
 =?utf-8?B?bnlUaVJmTFBuZTlIYVdCbi94VXRWTWFWVWJxNjF1TXVPcThHWVNoK2ZQRFpS?=
 =?utf-8?B?czVhMlZnaWxEZ2xzRGk4SDVhMGIwWHRYbnRvaVhQRHBXUUkwNk01SGlNc1Ri?=
 =?utf-8?B?TWpGVXBrNlFESzNta1hHTWVQdDlTcTlPVHVXUXYvWXpuZzQwcXZYUjBHWVpi?=
 =?utf-8?B?R2c1VG9mdkpXSEhmZnh1V0ZnQXpBa1Q2YWJkUFBtSW9pL0tYYXFsQmV4cTZi?=
 =?utf-8?B?aFNIZEdySG1kNld0dVEzZE5aZUtBTWU5ZGNuR3RGeHJGeUNpaGVuVENJZVlh?=
 =?utf-8?B?enRSRThJblptVEltTDRNVC85Y00rTm9HalhNdzYrdUhFSGtuWFJnWEVWSVhU?=
 =?utf-8?B?a1VqbVR0TVlYeWNwWXpvNG9tMVJDUWs2cXNEYy9KZ1FIQkJ4M08vL0c2TTdX?=
 =?utf-8?B?U3FpWjl1QmRCZFNoeWxaR2ZXNW13UG1YWGFYWUJBcGYxdXRiMFE3a3E5ZFNS?=
 =?utf-8?B?K2FmellvR3ZuUlNlOVYxL1F5dmhvRUk3Slh2RGpZbnZLTDFPdXN4ZEN5SHhw?=
 =?utf-8?B?azBzQUFDVUxoWjB5WjIrampOa0xQa0k3N3luT0cwMWlkRU0vQlEyaXQxWXRo?=
 =?utf-8?B?VWMyYnczb1c2cmwzWm5RZTZVaGUydnNXQ3BOZnFsamdEeUsyTGNGWTlNaFMw?=
 =?utf-8?B?ZVBoL3hmd2V5WDRPWnZNRHdhc3hjUmpWazdIaDdyQVdieEVPTE1SVHoxSFJT?=
 =?utf-8?B?OTFpcWtndzFVK3hWV0M3MHJpZW5WQmlWZmovOW9HUHBWclNxeDNmUmhPUGVT?=
 =?utf-8?B?amNtWWdwYWZvTTRQb2txb3grNHZ5Tm5nTkFDblJoMFFsdTJnTFJuL1VzTTZK?=
 =?utf-8?B?dCtoVnJ1K3Q5RDVzcituaHNYcTN3NGVOQmlGMjNab1pYNkFHemw0ajJkNFp6?=
 =?utf-8?B?eWVXcXladkNXbzdqUnVObkhSN3ltdFVqYVlUNTN2VkNRR0FZWkNWVjlBdGsz?=
 =?utf-8?B?SUZRaW1mT21ZZUJieExaQmJjUW5rOXhrY3VmUGE2akhKREJtN3dhTmFYdDhQ?=
 =?utf-8?B?VWxmZ1AvQ0dEeVpycmNBbnFWVWVIbkZ0UmhBUElGd1AzdTEvWitycTNteDg2?=
 =?utf-8?B?bWxBR3BKNCtEWVNRNXZNU09IZlZFdlRZZjh1SlRqWjlLWVVwcEp3b0NnbFNE?=
 =?utf-8?B?Y3FjRTNhTU8rZkU5cElwMXppZ3RrTE1xbUpKRG5xNUNmS3h4c0E1QXlmcFZB?=
 =?utf-8?Q?wM0LHA3aWF7R3Dt4nPA0wGITg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sC3/DZoMYBnt63nW2VGoWihNBfQZwienzrW3dLpRcynvUx63mVfww3AX9SNgChcPwl3m381Jak7aDbe1Ja+iKTUBjIJqZHd1hFasxhs1d6CrGQ2cUmRkDxmF0ZAcflrmfMuffJJZWKf/0pnzmnC8CY2G3lm3hpFWdg3yNphc+Lpc9OE6ftsC+PO/03RVLd9EsPI+f19wagJOt++x3R8wYLMZ7yygtyyD4taJ/3ofwty68M08v5yzQvaVj3cbfH+SfxCg9VAVK0vsiyRgY1smZyQP0B7Cd9eS9NuWrpzxzRuc2jeqaP3xTZDf8NlbMKsr90uXPf2Pp63anCB+3ax/6X52+x1unpSzPtRv3NPjHQZ6yj6sVDdlq5dlacRWg20frdDFkv48yjc6ckQeM9OT8sSaAL8nOUhuRtmDvXNO0sNUhVIoteT0blndFb0p/nS2etwO2SrEK93wHCI5JXVKW4h7FSUjESGYFiX4Vj0pTLzJNOxrE/ertN1ueYmrB7t6c/Ri8AgPvQdX+X1KYHvOnji8+XUDg6+dXDTnc8Zr7Y8TJJIkLRJr8PC2cOt4srHWAg7MZJ6eNcVvCLyPK53Pnxvd4cFx9AfpQnAhcZkGnkU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a5a471-02db-443a-1a56-08dc0072f84e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 09:14:57.7119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rY2Og/L28Id1JqLxlscpZzPmrKkGglRJ8aZTuHw+uJ9ezdLjp+y72Imrok1I+FLgpneLunZprJpaOyJx3s/y8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5085
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_04,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190068
X-Proofpoint-ORIG-GUID: yy0KVZxPv4QhPG-LBu_fmYniXJZ4gJh0
X-Proofpoint-GUID: yy0KVZxPv4QhPG-LBu_fmYniXJZ4gJh0

* Peng Zhang <zhangpeng.00@bytedance.com> [231218 21:34]:
>=20
>=20
> =E5=9C=A8 2023/12/19 04:28, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Liam R. Howlett <Liam.Howlett@Oracle.com> [231218 15:20]:
> > > * Peng Zhang <zhangpeng.00@bytedance.com> [231215 02:46]:
> > > > The last range stored in maple tree is typically quite large. By
> > > > checking if it exceeds the sum of the remaining ranges in that node=
, it
> > > > is possible to avoid checking all other gaps.
> > > >=20
> > > > Running the maple tree test suite in user mode almost always result=
s in
> > > > a near 100% hit rate for this optimization.
> > >=20
> > > This should only be triggered for right-most nodes and root though,
> > > correct (mas->max  =3D=3D ULONG_MAX from just before this)?
> Yes, only for right-most nodes and root.
> > >=20
> > > I wonder if it's worth special case checking the first gap if the nod=
e
> > > min is 0 as well.  Might be worth looking at, but this patch is
> > > certainly worth doing.
> >=20
> > Actually, not just when the min is 0, we have a special case close to
> > here for slot 0 so we could just check the same sort of thing there.
> I think that the first slot in a node does not have any special
> significance. It has a lower probability of being the largest gap,
> so it may not be worth considering.

It has a higher probability of being a gap, but since there is a special
case for it already it won't be checked unless it is a gap.

The left-most node at each level will probably exhibit the same larger
gap in practice except for the root where it will the be end gap - at
least on x86.

Since these will be hit-cache I'm not sure either will make much of a
practical difference though.

> >=20
> > >=20
> > > >=20
> > > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > >=20
> > > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > >=20
> > > > ---
> > > >   lib/maple_tree.c | 3 +++
> > > >   1 file changed, 3 insertions(+)
> > > >=20
> > > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > > index c9a970ea20dd..6f241bb38799 100644
> > > > --- a/lib/maple_tree.c
> > > > +++ b/lib/maple_tree.c
> > > > @@ -1518,6 +1518,9 @@ static unsigned long mas_leaf_max_gap(struct =
ma_state *mas)
> > > >   		gap =3D ULONG_MAX - pivots[max_piv];
> > > >   		if (gap > max_gap)
> > > >   			max_gap =3D gap;
> > > > +
> > > > +		if (max_gap > pivots[max_piv] - mas->min)
> > > > +			return max_gap;
> > > >   	}
> > > >   	for (; i <=3D max_piv; i++) {
> > > > --=20
> > > > 2.20.1
> > > >=20
> >=20

