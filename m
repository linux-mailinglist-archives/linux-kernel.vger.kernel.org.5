Return-Path: <linux-kernel+bounces-5755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED472818F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A555C288433
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2F93D0B5;
	Tue, 19 Dec 2023 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dV0jASy1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kJPeNGM5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2818B3B18A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJHJSFQ017172;
	Tue, 19 Dec 2023 17:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3ra6AxZxvbli2Ngqozj4/AyBxhsiXwlGX3PzRP3ITjU=;
 b=dV0jASy1jQAF73GlFSLFVxcrf0wqDAWnwYkF9hGtBxweb1ASw3EfQ2BbsupPN3KTFXjS
 KxZQA8B3ba4SVNCwXsKHsWntr2/3+CUVyVaE77hpMVdoDwBXg5KuzMn0OdSqVxs2uAMm
 TTKBJ/Xx6v6kX7w+an924SQiMqJTiL+QBN0KYjGeUaWNeHFS11/kme/wHU3xcHJbLKwO
 2cJt5gejmNcqTFwr7fKlKTo4n6jDZPOw6XvnBAmQ98wTKMWh9LmDyKajZ7Nh96VX4LLV
 CV6k6aLdVJljabsOxIJOYhvPHkuu6BkuPrZbU4lKTgchJKjCsu2VuFtger3hy6cjHjMm 4g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12p46ma2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 17:59:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJHrTQV020990;
	Tue, 19 Dec 2023 17:59:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b7edxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 17:59:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKHlQiokiAbBO+VnHzseKyfk8K5AU4nZ63xsWm+FIQisBvtMZGNgjVvG0jovCQvDBuX03m5b1meWI8zgPsdC0MLTLp3FNMIgI1F48FG1y5YhkW9yzsNWavHLAqkncduroPZixUF4HuWiDzkxfIiPjxv7sMxOtkj6uDmdvQLXgKKu/1BsP9k9BalpEzv/NED9r2wu2X5g4EbdDJHTwp1LSD2tmSNsyirHPfR/VeXQgWnDP1CGmLDzBP+fBmuxrxmkobstIBZO7AQHSLhHKN4Hoq/q7uLvp0j6o3cI3G3FHRnatLH3Z55DfogA8dwWB6nT/XYEX3KgGJXu/ne+efn85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ra6AxZxvbli2Ngqozj4/AyBxhsiXwlGX3PzRP3ITjU=;
 b=Q/tm02vIA1tIRUjrMNN4uP7pJroe6ZLSW1wo2x5h2COc0Iby1LlVsAm3Z7GWsUzb4A2/OjC6htYThJOAY7mDt3dPp24g0SQDJ4ZkWj0pmUls7FyKgS8c8yFBMPhTBFxOIgPRfYyFgcmRf0JD/BuNgd3dBY/wqWyTepgNSLPrzDWU5brIYGM9ua5tTl1bs92SCYA50TgCFpPBsPyoIRdNmCYO4hh0UEn1FlgiZW3oenL2q5ey8QcT2W7GVPDh05RqFeqyHclG3NW0z2gGcKBAuv+rUTpWDJ5KcT656eHKEHf9vtqS4lp9/Z2sycpbYirF+iml741OomBz+KIZY0WaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ra6AxZxvbli2Ngqozj4/AyBxhsiXwlGX3PzRP3ITjU=;
 b=kJPeNGM5biOaN/bKlNJGQAFtS2CnlGa824K/sqgEaENQcyw4vfA9rcMiAhi2T2c5jn0q56GQ31tGo5yEsnbEkTAgnsGsao7P6sQTuH/tjKwutDSZ8a8ZzFLQ+xxPujh/l14HtOx8ywvF1FXKYy7iw1Tjhqn/PqykHXwZOXCRqDQ=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by MN6PR10MB7444.namprd10.prod.outlook.com (2603:10b6:208:472::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 17:59:03 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::dec8:8ef8:62b0:7777]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::dec8:8ef8:62b0:7777%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 17:59:03 +0000
Message-ID: <621b6d36-b30f-05a0-eb65-b33b7386b2b9@oracle.com>
Date: Tue, 19 Dec 2023 09:58:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2] perf/x86/intel: Hide Topdown metrics events if the
 feature is not enumerated
To: kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org,
        joe.jin@oracle.com, likexu@tencent.com, linux-kernel@vger.kernel.org
References: <20231219150109.1596634-1-kan.liang@linux.intel.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20231219150109.1596634-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::11) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|MN6PR10MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c593317-6435-4021-7334-08dc00bc2f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	59QxG2e5eZl7PExINu2fEPsTal5XCoyUx2z2SjGhuoh0Euu+kzzzk3VgaoM9g7tq9/tdu0QLlNX/fRc3kEq7oNDbplwBl8jKnDiHdTovIrN8w/wkpSPz6yF9EBGbJBtkidbL+youFF0z/7TuU8czwl6VDLqEQSLKBYo8iAUxXpTWXNnGwf9dvu0NgCPBx3G8ViuF2E+KNyS1BPzl04abhsrggqCIJdi2xrWGwMcnPKmCIBgh5zQIryuAI/DCmQWyGx5BqxlHnNmzEAFUtHGFR6J7GYDeU4skLavrogKR0L4D4qlZWVKXL9f9PhX5eTiLoxsB3FZOGKzMqi5vSO4/DWMYmlDb90SKsKuecuFkjDgznTdpryBl33/+djvOebbleBslfxAt3wpWCQ8bt2rFT+TqgSWehO0Pi31yr+EIU7+0IWiIgk3EJpgkIXOHW/ih8SRHaOrFZJQKoMJ4zkpPptluM482bOWPqGZrslAyIyiVuwhkvYvMn4R1q+l8YAv1qudTBvuS6Nfxj2qB4KrNqAU/HseW7RS710zMfnL8vo+cJi6l16rlebo78UpejV2FRPIhHC7HcJMwtznDknJVO9hLJmI7JKcVm7ayEa8fTS7juluNsVSnf7eF/TcUzGXinvWbg75N/effGcQqIX0KWw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(2906002)(36756003)(8936002)(8676002)(5660300002)(44832011)(4326008)(6506007)(2616005)(6486002)(26005)(41300700001)(478600001)(966005)(6512007)(53546011)(31686004)(6666004)(86362001)(31696002)(316002)(66946007)(83380400001)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bnpkUnpwTGpIbjF6ZERiMjJNQ3U5cUpIaVJqT3Ywa05yd0wycDJBMWs5dkJi?=
 =?utf-8?B?TU85Vm9XS0Q5dDk2c2QrRVBaQk8zbjkxVVE1ai9sOHFqUEd5dHVtbGM5VTIv?=
 =?utf-8?B?eVI1ZTc5THM4WGI5eWNKa2liYXZDUENUckltT1hicGU1RkRpYTRBUnBrWDNm?=
 =?utf-8?B?c2ZZTGR6QUpnaUVDWm5KRTlHYWZGN21lUmQ2aDEwZHl3VjlIRmlLRXZDc1BE?=
 =?utf-8?B?SXVxTHNXcWZhWko2dUFaREVNVVljeE5SaFVwamFxTTBxaC8wWGRCYlkvdjRS?=
 =?utf-8?B?UXVCSmJNMEhDRDdyUzdKKzdiNXAxMUx1OGl0aXphQlN2NmNqeHd5WTJURUxR?=
 =?utf-8?B?VWZNY3h6b3g4V042NW14SEo3KzdkcGhyNEJQM0JZckZBWXA0Y1hiRzRESVZ1?=
 =?utf-8?B?V3RCZW5TUmtUZXJZSlJQL3JTU3I5N0NyRmdOUE5KVjB3MUVNNTV3RWpIdUlu?=
 =?utf-8?B?bkIvS0YrYUdkWllORytGZW1tMkZYdEdJckhzUStzaU1aN1FwTEtUWW1sYmkv?=
 =?utf-8?B?Sy9SSFVaSzgybnRDWWFQUnNORU5RNUNMWjFaVGV0VWYvanljajJTTitwWFVW?=
 =?utf-8?B?bHhaTCtRRUxjTTdocWtOK0JCbEFHTkNKNllTanRaNm1qdzlGVElXYTkrNlh2?=
 =?utf-8?B?QUVrelBLb0xhU1oxaXpVQktnTTFYUjdkMzRNcXE2YUVSMnQ3c2lKTVJCcUNq?=
 =?utf-8?B?SEMrOGJtUElKN0J0REV2TXVtTzRxaGNOL0F1eDhJTEt2S1M2TWNCSE1qSk5i?=
 =?utf-8?B?ZW45ejNsYmFmNjh0cXdPOXBJNkdCZm5KUUxvVjltLzhpOTF0dTNMaE5DaXlr?=
 =?utf-8?B?UHM0Qmc2TkxBSXhQZUcxL09lbnVidG5wbGtST2djUW9sTFNGcE5XTlJXWDFL?=
 =?utf-8?B?VzBCakd4c1M5YlVQSjkxdlUwSy9WckIvak5iYlluclVtQmg3QndDbmhaenNS?=
 =?utf-8?B?SGNSYUJnWFpDeGFJd3dwaWgvV0xVVGxtbjlBQlNEV0Fhc3loSzVZcmM2ZE1H?=
 =?utf-8?B?aDV0aUdXdUp1L1hOWVI4c0RIUnYydFlKVUw2cUhDU3JlNUdjTGFsSldTbUdW?=
 =?utf-8?B?MnNHY3NsRFNCa3RYa0hxWVhKYVFnbzMzelZRS1dNRkRha3hKbWhqM0hib0Vh?=
 =?utf-8?B?TnB6THQ1OWNiL1B3Vy9WQXVNckUzeVNuMnJRb1NFT1U5Y0NwNEdhZVVNaXpu?=
 =?utf-8?B?VDNUUUZvdkJSdHFFWlQvYjR2UStEcDR1SG9yYTQ3YUhGa01zcFpxTHJnTkhj?=
 =?utf-8?B?MzY2MlJybkhpdFUyY3NtQVNsYWNycWt5UUFMbzN1aE5aVm5jaC9Vb2dNenRx?=
 =?utf-8?B?bW9OL0RYWGVCNlBDY1UwdzYza2NiSjNic01GUW5uWFR4SGU1Y2luY3JpR3ZK?=
 =?utf-8?B?VVc1SEdxYUZ6V0hMdWYzd0lXaXArMkxOWG1GY3hCREV5RzlWaHYweFpwMm9a?=
 =?utf-8?B?YS9QVlRzTmY5U2E5Mnhwc1NuTE84TUVGNi9XdkFRYzRjaGpWc1cvWUxKQldG?=
 =?utf-8?B?K3NwZXN6dzdEMjJjVlVna3Fhbm5EZE5YWGlPR2h0TzcwSVU0eWJKcDlvUUlS?=
 =?utf-8?B?Y0JucnNxbjlLbE53Q2YyQisxeXhzcURRMXg3Zmo2SzVRUk5rRGN2L1RoL01D?=
 =?utf-8?B?VVZGTU0zWFNBMlo5S2lzTEVRSXNqaUc4VGRaZzZUWTdtTXBjNDNlQllWTlZ5?=
 =?utf-8?B?Uk12a0duTjJuaGNKWmlpOGs4S1BxRzlhcU83bTRqLytSTVBaR2tzSlZaM25v?=
 =?utf-8?B?Z3AvTjBIdnkzR3AyWXNrcnJ5VTlaQ2RRUytrT09pRnp6SXZYWkMxT1J5a3FF?=
 =?utf-8?B?NnN5bk9vMGUySjlsQUF5dGlWMjIxaUFSdW1PZmhEa1BrTUxRWDRoaGl6TDdN?=
 =?utf-8?B?cGxxT3B5bGZmZUNXYVVRcStaaFVqWWtuOHZBRDR2WHlVbDVPYSs4ZnlIRXlH?=
 =?utf-8?B?bG5uSjVQYUlKckUzSmpYMWZIZWRYZEZxMVRZYUhBcDY2UlBrQkJidmZGeit0?=
 =?utf-8?B?cEpQZWlOQkJyT3lnT2ZSdEhNNkxYcHZqWWlIMUQ3THZoZmJJNXlpay9iYTNB?=
 =?utf-8?B?OTZkK1VhL2g4RTJNMVpGWWtGcGJta00wWVRsLzBxNFNlVXNUU0RmUlg1UXI0?=
 =?utf-8?B?REh6blRSdnFxR1ZzeXpHc0Yrc1RQOFpXeUludzJXQXBYWUpIKy9vaFUrcHVD?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xdyEBeOPKmiysAp90HhkwftG2/wY0aS384F5MExfn2eQDvE5mQQPDefna7REcbk1qubc/DAG3/FqJ6jCETcZuojTFWQDATffXzanGnbec3VNZL3RkD4LNwWrNo7tp8aXo4+jjLF1ODBUiAjUHd+IXxfbdcCXIEpSDPXkteiQAt6W2om97HbSzrAdW4aDqnIlb1JYoJHwD7qXQyWieZr9wDcrGhyyV9hd1BysqlrX/+1KaLvLYKVxEovvPTMIhrcU0wropoOPhjT3fT0VW1IxwaApyCgz2VqwA81lRw7UEETr6Bqn0fAg2QGvXvaefvl7QwxUiUTaKgtBP5EIissyK9nIp2RTiISGiSAltpYaxu0NOF0fC9cp4HS/vpazrHy21mUwRNfBT87gXp8jOdE1AJv/guo0VPf0g3x4f5ZTYzCLf53FHUtdxx4ZoUy+WfaiW4losjpe0jAKkqFIuXUuG142igODushsjAbY4pnzAgmHuFp1i+J6MyR3Dw9lC2k9byZir3+Rnf6t6FZHu/cUEOP5pIhxiGBJxxn5Rn25cEH6SqXUUlp3GqLNrZmrCnsnK8+1JHTMyhjWOxswW5plom8gYYvDg1Gv7s/ex537baQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c593317-6435-4021-7334-08dc00bc2f1f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 17:59:03.1754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWHpKiWj4rzMaMyHp7lzS4GobFHw7mLsa9T+kCwKcjHJ1MFzl7OhTZcYlWNdKZYc0OCt9MrQ+o4lwdqpDVSwlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7444
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190134
X-Proofpoint-GUID: ph9RNc-BGDtqURfrkfjLLUTpQ6IFVF9h
X-Proofpoint-ORIG-GUID: ph9RNc-BGDtqURfrkfjLLUTpQ6IFVF9h

Tested-by: Dongli Zhang <dongli.zhang@oracle.com>

Thank you very much!

Dongli Zhang

On 12/19/23 07:01, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The below error is observed on Ice Lake VM.
> 
> $ perf stat
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (slots).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> In a virtualization env, the Topdown metrics and the slots event haven't
> been supported yet. The guest CPUID doesn't enumerate them. However, the
> current kernel unconditionally exposes the slots event and the Topdown
> metrics events to sysfs, which misleads the perf tool and triggers the
> error.
> 
> Hide the perf-metrics topdown events and the slots event if the
> perf-metrics feature is not enumerated.
> 
> The big core of a hybrid platform can also supports the perf-metrics
> feature. Fix the hybrid platform as well.
> 
> Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
> Closes: https://lore.kernel.org/lkml/CAM9d7cj8z+ryyzUHR+P1Dcpot2jjW+Qcc4CPQpfafTXN=LEU0Q@mail.gmail.com/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 
> Changes since V1:
> - Rebase on top of the 6.7-rc
> - Use the intel_cap.perf_metrics to repace the slots event to check
>   the enumeration of the perf metrics feature
>  
>  arch/x86/events/intel/core.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index e068a96aeb54..e0822ede9ccb 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5699,8 +5699,22 @@ exra_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>  	return x86_pmu.version >= 2 ? attr->mode : 0;
>  }
>  
> +static umode_t
> +td_is_visible(struct kobject *kobj, struct attribute *attr, int i)
> +{
> +	/*
> +	 * Hide the perf metrics topdown events
> +	 * if the feature is not enumerated.
> +	 */
> +	if (x86_pmu.num_topdown_events)
> +		return x86_pmu.intel_cap.perf_metrics ? attr->mode : 0;
> +
> +	return attr->mode;
> +}
> +
>  static struct attribute_group group_events_td  = {
>  	.name = "events",
> +	.is_visible = td_is_visible,
>  };
>  
>  static struct attribute_group group_events_mem = {
> @@ -5902,9 +5916,27 @@ static umode_t hybrid_format_is_visible(struct kobject *kobj,
>  	return (cpu >= 0) && (pmu->pmu_type & pmu_attr->pmu_type) ? attr->mode : 0;
>  }
>  
> +static umode_t hybrid_td_is_visible(struct kobject *kobj,
> +				    struct attribute *attr, int i)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct x86_hybrid_pmu *pmu =
> +		 container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
> +
> +	if (!is_attr_for_this_pmu(kobj, attr))
> +		return 0;
> +
> +
> +	/* Only the big core supports perf metrics */
> +	if (pmu->pmu_type == hybrid_big)
> +		return pmu->intel_cap.perf_metrics ? attr->mode : 0;
> +
> +	return attr->mode;
> +}
> +
>  static struct attribute_group hybrid_group_events_td  = {
>  	.name		= "events",
> -	.is_visible	= hybrid_events_is_visible,
> +	.is_visible	= hybrid_td_is_visible,
>  };
>  
>  static struct attribute_group hybrid_group_events_mem = {

