Return-Path: <linux-kernel+bounces-128822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372BC895FFB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF1CB21FE6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5E9446B2;
	Tue,  2 Apr 2024 23:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gvutjaRg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w/MFVTpA"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E3224FA;
	Tue,  2 Apr 2024 23:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712099807; cv=fail; b=eses2dFpDr6XgIHeqxRyLRc2187RzGf5dncYJSHxje6hGCF3xyPaCpaTg8dw4Oi6ywWSxJ7t6rb+kW/hpCSzGNtaK04Rp1jI8Qvd+86MFfoyHcIHZl3jn9hs9fpomcqey3WW+B5H3fbhCFVzetFs0SoDFFxrg7w57MVz/d6S9tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712099807; c=relaxed/simple;
	bh=bttwJnl62tEnQ3mW7vUbaoHDXq4tVeN0QLuDprWUwE0=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=HM5jyXxp0gf8nia7GfzXOKkevgW66f4N+6M/dO1kzWtdMXzAZpGYUQUu4Mm3u4Z9/TM7+EeJR0GJnqYIIwkWC5LkRTRkBta+wQ7DcMcTX0JCmXneU2Fp72T59n+s6dSQMyVHVnoEhMwxKlLMS9gAq3g2Hrt+oBe6zHjsW2tMHGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gvutjaRg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w/MFVTpA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432MFuCU017577;
	Tue, 2 Apr 2024 23:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=8f6+2cg2wzjgKVguY2+QhOkXf2h5CECF8uqmkC3svXQ=;
 b=gvutjaRgPWYuTk9VUOYCvAUg1mGKVI8/sFJzh6vLa+3gWuRHmtJdsZwGkmMWBD4p2ypt
 UFiFAlmIOScdfWVuC0U6aXHFCDqVY0nZS9Ur5UogNRHfk6xvWva5hiWWI5pliO/pCg0b
 MctJFpoilP21dsSa/Sb2R6CthFDI3uglr2C5Zn600gzpoYgUcz6L5dTY8LmeP32QoSyg
 wUgeLG3zfFaO3ExjJUd/KuynMUMUQI+I6WcYz1YQQfj+y3RCCq2ZtG9imai/zFFB8DaU
 IwJkkQApwTXKOW8lRxIMi29yvqKT7gxkimK0F6WAEw/h8AE9qmjYLqAlppZGVm8In6WJ sQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x695enwve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 23:16:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 432M2ijf031119;
	Tue, 2 Apr 2024 23:16:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x6967hcdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 23:16:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SC4A5sC2CDyJ7K7VtsUTu/Cbq8DCa1kL7WTufWLTOEM4fBsyRoQ5GRxPZjr6cUqRHHYRnyu0lIgl51qt4uDlULLCVpf+Pu5dV1er6wTghiAUaIE7TwH9Vz0+PtBTrsDCUHRjfJvkO//zZ/CyeM6JoyZOzNxer8XH96tnKPaM9qzdyKsHp3dmn9cRd3nz9EXmTtBG6P6uEJWTIeBa7AoNuU5yWdXZWdodyQYT5mL8zQ+1h1nPT59UwzcNqXA5QphMSGielPVlEko/5wQ/TcLlDYAYCK4ZhC3Zxj/4/+Oom7HBFtMwjSs/q6xg5PP55aZuefjeWdHD3kvF4LCZbhs2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8f6+2cg2wzjgKVguY2+QhOkXf2h5CECF8uqmkC3svXQ=;
 b=eFSttPavMnY15/LGO/hvkt/0ihpxGYvkI4psT8dFTYoS9ED2LkNRXWGYwDQgd5vPcRp4LF70pCTTtPlzsUmXbn64qVlPo2fKBWequHcr5jsC33cNmXfXARUAPTh4KeGHpbLgBN6+x0qOeRTyENnMRBL7kUmsUcjYM5i6hzSSDO3HFvJ9PfEBrT54ijZg6gpk1N8XObOzlAPuTHAeobdc2OXfrw6t/tSkzHlQ2rfSrT1d/SIyz+ippRPNGt3MNsnGKCIB1xtwZvmfYKaIRjngdLGKhqw2HQ5UBAu+HHwOYuSPFbg7EP2+ZZtts63cLDG6BBybA2Ce4s6IEq7IaFqvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f6+2cg2wzjgKVguY2+QhOkXf2h5CECF8uqmkC3svXQ=;
 b=w/MFVTpAwwmoLJEX1MKNpTbJ6hGmn+wP4iEfBSUQOZtQUKHji7vQERwwyHyALfLrpQjwvHjOiYkwcAVDIb62Diqwnlahqp5WCibUN4CA3c1q4cQhDNEQWpotz23WIbgg+bUgZkdFZSp4K5r8RmrFEyh9eJslUm7Lauz4Gu88DM8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO6PR10MB5620.namprd10.prod.outlook.com (2603:10b6:303:14b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 23:16:27 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 23:16:27 +0000
References: <20240402014706.3969151-1-harisokn@amazon.com>
 <20240402014706.3969151-3-harisokn@amazon.com>
 <Zgw--fHBH9kEQsi0@FVFF77S0Q05N>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Haris Okanovic <harisokn@amazon.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-assembly@vger.kernel.org,
        peterz@infradead.org, Ali Saidi <alisaidi@amazon.com>,
        Geoff Blake
 <blakgeof@amazon.com>, Brian Silver <silverbr@amazon.com>
Subject: Re: [PATCH 3/3] arm64: cpuidle: Add arm_poll_idle
In-reply-to: <Zgw--fHBH9kEQsi0@FVFF77S0Q05N>
Date: Tue, 02 Apr 2024 16:17:10 -0700
Message-ID: <87a5mb5p8p.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:303:16d::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO6PR10MB5620:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nlomiOf+JRsz+Hv5V9brkHTwDBZWmVcQCqligSVbr39b68e9HWQlqUgdd1c7wTXI11Z/sZSJYdZO42DNJuIO/Oj6A368idzHBE4Q6/r6ZYTTYh9WBRI8wLaFjBACbPQkHXAYC0wNDgc+7EcYGwjy/nfTbFW9KWpPbp3b2GjtQRXk/h0C77U0v8MPXL0nWXHUUatErPEo48fe7yawmTSGL735SIc8G6QsMv6OVJA75sxJpOOi4AqHHslHqFVfUOdWbbvOsg0fWb1ADugvdRoMgOGyXbyaryayscs82fNjBOHghXdW1YyMZLrINvUvgPTdAAYbb+UgasNQroAYo+2LUkqV3Mf+UDKyLsnnPQe93qcjbuyChcwR5+qZDvmTqjA7G/my3jO5iafGnxdQcn0WJ6QibjmbTtEBJHZ4Pw185ndP5dubGVzC7Pm5fX7zIwtBmsq7h7C7Gy+lO+EhNCISh+0QrdrZqpldGaJ7hMTW/JwTEeZGC3ePwOz3Z26fAPv9Y8xtdx72PWs04SihhZyzFBUKlm7yuaXQNX3CldolpXib2Wiz9Tjkrgs6PKJEQEuqy1vYMszcrRYvmsNbKjCX79kRovmyijtuptLgCIYLG0Cp4mcsiioHy0qF9hNtAKpS
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?P7RjPaTUxmbu0SWy7DGjaqSOJR1zsz1lu4lWVvFT0PczTmfMlMmJW52U0CJR?=
 =?us-ascii?Q?fAc0ZwxhYrsHxzskBoXOTwUo1mnQAhOFzfB0jexOAwxJOiO/X9M+yXd/I815?=
 =?us-ascii?Q?nQyfsC3fpHmvsbYZHGSgI3OEthEDNYR/2pd5u5+ZcZEP5vvbGzEDbLGLjFpE?=
 =?us-ascii?Q?RNNETEND7mIEUZUY4TDX2gOdNtaNxS6WYg93gDDHeAoq6nCp8unI45lK6LsH?=
 =?us-ascii?Q?OdsAt8Mx7f8OUc9tQxaTGtqkH38a8rYVzOyYjs1Zs1kQZJI2/jPyi3z2DQ70?=
 =?us-ascii?Q?BTDfNDGgF6fQKF0aD93LbT4oDnyIZr08tggYU1Fm8zqzLAtQIO6jAHMFTEEa?=
 =?us-ascii?Q?dukbRqhJXUhplQrQJetNgk3f0e0Jm2NaWT2vQveRSWisMf9NcTQ1rWBS9hZ4?=
 =?us-ascii?Q?/WqAFq9i+BUVSfjb7GqF4jV8xFTGYnL5bw6iivH3yh5rDo95zEposwBmigAj?=
 =?us-ascii?Q?KQRO1Y++puYrMpPnNQchsldOrpapnnYws76Z2vmGV+trVobcMS0a3zIeNLjA?=
 =?us-ascii?Q?YiqjL8KjqbI8S3OQLbDr27jMIew/A2xCqFBPmrzdLy1jxFSPzyNXNbQ70p4B?=
 =?us-ascii?Q?nlU/Kg6Y8Uh2J2Xv+j0pm6p19g+J29KqDb3g5i0O5ib0EVvi35JPpCWJHxg6?=
 =?us-ascii?Q?Dk+D4fKTCzM3fSIZ8EwK4+tBNasq08pmNggXU8tmT79f37WhdsUaVtSGoTC3?=
 =?us-ascii?Q?utWhfnf2FAGyCl1c8CSOo0CavPjB2mXmO4RAojT03VaOdEc5ehuWyBmUI450?=
 =?us-ascii?Q?KIuRQDZBZzjidc4FzQBwepwAhZX4LnIsdgqtogCPiID3xiEicHuhlpptPBjF?=
 =?us-ascii?Q?KvSLJzvpLDFSIv7Tq5R822L6e7g5L9N9+6kxwWinXLw8aHY0zteZ9CuUBI2L?=
 =?us-ascii?Q?2aLj+CjOIQAYEvoDzFNjTlv1S24QQe2MHIrMO7dVnEL4wW/N89E4/8D9nf/O?=
 =?us-ascii?Q?PD3/X0uKI4wf+mkY2ubIpw0XXZ0tlSnZDO6d4S46Abs4+JqtooyV7Ly6AWFQ?=
 =?us-ascii?Q?pg1HkmWHNy9qN/ZInBuRTWlcuqupsUf/yloWDzGQ5S2df1C5tpTHwSmcf9C6?=
 =?us-ascii?Q?2qnQgtypAFKXmqvUdVlJd/vWdYV3T40uLXwKKZyQLIBatVrIWzkSOUbzb9pN?=
 =?us-ascii?Q?cuD8JZlL2FAH0gFjVy5xpcenIJEQsJKaNyxX8lIWsKGB7k23hHSD6o6v+Jov?=
 =?us-ascii?Q?5NsaBHQBCWAFNb2ttpu8VhzeKzGjBtFOV6A/wI025iljixdgO7ZtWq/ATwPQ?=
 =?us-ascii?Q?qcZLPVvYXdxVTQtE7HLDj/okSJ0/juru7dVhc4rHsx7BWADbGtSAzOZ0QRFW?=
 =?us-ascii?Q?hv6hxa+eA8pK5P7ceBxtviXuETNy5vLHDQuxBV2FIYQ05LUCXewdeu/nqwPK?=
 =?us-ascii?Q?UP3BhtfZtCFlR9X18YpEXMW0pLTjHakn4B3DpZKc+cKToklQ/pYgbDD9bB5X?=
 =?us-ascii?Q?lC5GCdjokyUSC9Q8ieYsk/Sn975Ao6JhPAi+3r4xIw4MdQVJGp66Sr3zUwd5?=
 =?us-ascii?Q?2n3caBgJP6h+Zkox550SMWfI3ZJaOVgS61pgt4FmuWS+aHhBQ0EZSS4wPpSk?=
 =?us-ascii?Q?ceqXPg1U7ZMS/n4U/bJ841YicD3JgofuE5iWOVJomSPo2USB/b29C8jze3sG?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SSsX09Z5p+GOYngHLC0ees/q19nd1fdBk/AAYTmhxfhDu83uiCeLuUWRpyFD9a1JuaXv5OLDA7je62bHCdyFK3SRw+wAda4d2hY0bcosFDmiWRuqvPfiwF5g+MFpg3wpzk4bQ4OXl6IiQXcrcWd9PPha6qElwZfiXjEl5wB0FLUcKVtsYRbXLkw1Uyl4ZUZx0cwPwN74klmiiGHrPAg7JDLSCBKEVY8fPGxbXyoXk6UZkTX6Ei/VMVdxLJMXD+ZzTbqITTQ/D4c9BkOKN7M8ZqqloGHSVBKaIumVi59G8cuL9+M1+3hCsL4ulbmhYfc/Jc44Zey32LLPdptTvhP1lZvXLnDvM4FAJiy/kBSp+p/PAEdd6C9Umhi/HTnCzkLHa7MqkBIb3D7cOgfVGpPPFrwdF5qWSFH9F6RHKwP36UQXtZB0KncMfjpVu1KLqJrxxmDsQzvGLQAENfIX+wUVcm9k1GvI68+ops1t3eEutRivysrfIQJ64NQu0v2GlT5IC5jXsk7UOxiLJUOfn8O5nY6V8vwMLLVMMVbOIdcunzqj1gpOKSps6I66wbCq1vahlo7I9xQpJtp8pC0+khOGyL5zcrM/CrVJTwTySh3pnZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a96be07-322e-4c2e-8c29-08dc536aebbe
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 23:16:27.2756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anFZI67/PGw0jQXDwT0NEAeZdLRVNDBCDqHTVYWcTBsXab2M08vVdzpsnLZvrpXyYRI/cVzFjoZldr6uY8o3pEcPEHX9nCNB9EO2ybX9+AM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5620
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404020171
X-Proofpoint-GUID: aCZznXRV16BLzvuFHkaZL3pCvsEKpM8T
X-Proofpoint-ORIG-GUID: aCZznXRV16BLzvuFHkaZL3pCvsEKpM8T


Mark Rutland <mark.rutland@arm.com> writes:

> On Mon, Apr 01, 2024 at 08:47:06PM -0500, Haris Okanovic wrote:
>> An arm64 cpuidle driver with two states: (1) First polls for new runable
>> tasks up to 100 us (by default) before (2) a wfi idle and awoken by
>> interrupt (the current arm64 behavior). It allows CPUs to return from
>> idle more quickly by avoiding the longer interrupt wakeup path, which
>> may require EL1/EL2 transition in certain VM scenarios.
>
> Please start off with an explanation of the problem you're trying to solve
> (which IIUC is to wake up more quickly in certain cases), before describing the
> solution. That makes it *significantly* easier for people to review this, since
> once you have the problem statement in mind it's much easier to understand how
> the solution space follows from that.
>
>> Poll duration is optionally configured at load time via the poll_limit
>> module parameter.
>
> Why should this be a configurable parameter?
>
> (note, at this point you haven't introduced any of the data below, so the
> trade-off isn't clear to anyone).
>
>> The default 100 us duration was experimentally chosen, by measuring QPS
>> (queries per sec) of the MLPerf bert inference benchmark, which seems
>> particularly susceptible to this change; see procedure below. 100 us is
>> the inflection point where QPS stopped growing in a range of tested
>> values. All results are from AWS m7g.16xlarge instances (Graviton3 SoC)
>> with dedicated tenancy (dedicated hardware).
>>
>> | before | 10us  | 25us | 50us | 100us | 125us | 150us | 200us | 300us |
>> | 5.87   | 5.91  | 5.96 | 6.01 | 6.06  | 6.07  | 6.06  | 6.06  | 6.06  |
>>
>> Perf's scheduler benchmarks also improve with a range of poll_limit
>> values >= 10 us. Higher limits produce near identical results within a
>> 3% noise margin. The following tables are `perf bench sched` results,
>> run times in seconds.
>>
>> `perf bench sched messaging -l 80000`
>> | AWS instance  | SoC       | Before | After  | % Change |
>> | c6g.16xl (VM) | Graviton2 | 18.974 | 18.400 | none     |
>> | c7g.16xl (VM) | Graviton3 | 13.852 | 13.859 | none     |
>> | c6g.metal     | Graviton2 | 17.621 | 16.744 | none     |
>> | c7g.metal     | Graviton3 | 13.430 | 13.404 | none     |
>>
>> `perf bench sched pipe -l 2500000`
>> | AWS instance  | SoC       | Before | After  | % Change |
>> | c6g.16xl (VM) | Graviton2 | 30.158 | 15.181 | -50%     |
>> | c7g.16xl (VM) | Graviton3 | 18.289 | 12.067 | -34%     |
>> | c6g.metal     | Graviton2 | 17.609 | 15.170 | -14%     |
>> | c7g.metal     | Graviton3 | 14.103 | 12.304 | -13%     |
>>
>> `perf bench sched seccomp-notify -l 2500000`
>> | AWS instance  | SoC       | Before | After  | % Change |
>> | c6g.16xl (VM) | Graviton2 | 28.784 | 13.754 | -52%     |
>> | c7g.16xl (VM) | Graviton3 | 16.964 | 11.430 | -33%     |
>> | c6g.metal     | Graviton2 | 15.717 | 13.536 | -14%     |
>> | c7g.metal     | Graviton3 | 13.301 | 11.491 | -14%     |
>
> Ok, so perf numbers for a busy workload go up.
>
> What happens for idle state residency on a mostly idle system?
>
>> Steps to run MLPerf bert inference on Ubuntu 22.04:
>>  sudo apt install build-essential python3 python3-pip
>>  pip install "pybind11[global]" tensorflow  transformers
>>  export TF_ENABLE_ONEDNN_OPTS=1
>>  export DNNL_DEFAULT_FPMATH_MODE=BF16
>>  git clone https://github.com/mlcommons/inference.git --recursive
>>  cd inference
>>  git checkout v2.0
>>  cd loadgen
>>  CFLAGS="-std=c++14" python3 setup.py bdist_wheel
>>  pip install dist/*.whl
>>  cd ../language/bert
>>  make setup
>>  python3 run.py --backend=tf --scenario=SingleStream
>>
>> Suggested-by: Ali Saidi <alisaidi@amazon.com>
>> Reviewed-by: Ali Saidi <alisaidi@amazon.com>
>> Reviewed-by: Geoff Blake <blakgeof@amazon.com>
>> Cc: Brian Silver <silverbr@amazon.com>
>> Signed-off-by: Haris Okanovic <harisokn@amazon.com>
>> ---
>>  drivers/cpuidle/Kconfig.arm           |  13 ++
>>  drivers/cpuidle/Makefile              |   1 +
>>  drivers/cpuidle/cpuidle-arm-polling.c | 171 ++++++++++++++++++++++++++
>>  3 files changed, 185 insertions(+)
>>  create mode 100644 drivers/cpuidle/cpuidle-arm-polling.c
>>
>> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
>> index a1ee475d180d..484666dda38d 100644
>> --- a/drivers/cpuidle/Kconfig.arm
>> +++ b/drivers/cpuidle/Kconfig.arm
>> @@ -14,6 +14,19 @@ config ARM_CPUIDLE
>>  	  initialized by calling the CPU operations init idle hook
>>  	  provided by architecture code.
>>
>> +config ARM_POLL_CPUIDLE
>> +	bool "ARM64 CPU idle Driver with polling"
>> +	depends on ARM64
>> +	depends on ARM_ARCH_TIMER_EVTSTREAM
>> +	select CPU_IDLE_MULTIPLE_DRIVERS
>> +	help
>> +	  Select this to enable a polling cpuidle driver for ARM64:
>> +	  The first state polls TIF_NEED_RESCHED for best latency on short
>> +	  sleep intervals. The second state falls back to arch_cpu_idle() to
>> +	  wait for interrupt. This is can be helpful in workloads that
>> +	  frequently block/wake at short intervals or VMs where wakeup IPIs
>> +	  are more expensive.
>
> Why is this a separate driver rather than an optional feature in the existing
> driver?
>
> The fact that this duplicates a bunch of code indicates to me that this should
> not be a separate driver.

Also, the cpuidle-haltpoll driver is meant to do something quite similar.
That driver polls adaptively based on the haltpoll governor's tuning of
the polling period.

However, cpuidle-haltpoll is currently x86 only. Mihai (also from Oracle)
posted patches [1] adding support for ARM64.

Haris, could you take a look at it and see if it does what you are
looking for? The polling path in the linked version also uses
smp_cond_load_relaxed() so even the mechanisms for both of these
are fairly similar.

(I'll be sending out the next version shortly. Happy to Cc you if you
would like to try that out.)

Thanks
Ankur

[1] https://lore.kernel.org/lkml/1707982910-27680-1-git-send-email-mihai.carabas@oracle.com/

>
>> +
>>  config ARM_PSCI_CPUIDLE
>>  	bool "PSCI CPU idle Driver"
>>  	depends on ARM_PSCI_FW
>> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
>> index d103342b7cfc..23c21422792d 100644
>> --- a/drivers/cpuidle/Makefile
>> +++ b/drivers/cpuidle/Makefile
>> @@ -22,6 +22,7 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
>>  obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
>>  obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
>>  obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
>> +obj-$(CONFIG_ARM_POLL_CPUIDLE)		+= cpuidle-arm-polling.o
>>  obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle-psci.o
>>  obj-$(CONFIG_ARM_PSCI_CPUIDLE_DOMAIN)	+= cpuidle-psci-domain.o
>>  obj-$(CONFIG_ARM_TEGRA_CPUIDLE)		+= cpuidle-tegra.o
>> diff --git a/drivers/cpuidle/cpuidle-arm-polling.c b/drivers/cpuidle/cpuidle-arm-polling.c
>> new file mode 100644
>> index 000000000000..bca128568114
>> --- /dev/null
>> +++ b/drivers/cpuidle/cpuidle-arm-polling.c
>> @@ -0,0 +1,171 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * ARM64 CPU idle driver using wfe polling
>> + *
>> + * Copyright 2024 Amazon.com, Inc. or its affiliates. All rights reserved.
>> + *
>> + * Authors:
>> + *   Haris Okanovic <harisokn@amazon.com>
>> + *   Brian Silver <silverbr@amazon.com>
>> + *
>> + * Based on cpuidle-arm.c
>> + * Copyright (C) 2014 ARM Ltd.
>> + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> + */
>> +
>> +#include <linux/cpu.h>
>> +#include <linux/cpu_cooling.h>
>> +#include <linux/cpuidle.h>
>> +#include <linux/sched/clock.h>
>> +
>> +#include <asm/cpuidle.h>
>> +#include <asm/readex.h>
>> +
>> +#include "dt_idle_states.h"
>> +
>> +/* Max duration of the wfe() poll loop in us, before transitioning to
>> + * arch_cpu_idle()/wfi() sleep.
>> + */
>
> /*
>  * Comments should have the leading '/*' on a separate line.
>  * See https://www.kernel.org/doc/html/v6.8/process/coding-style.html#commenting
>  */
>
>> +#define DEFAULT_POLL_LIMIT_US 100
>> +static unsigned int poll_limit __read_mostly = DEFAULT_POLL_LIMIT_US;
>> +
>> +/*
>> + * arm_idle_wfe_poll - Polls state in wfe loop until reschedule is
>> + * needed or timeout
>> + */
>> +static int __cpuidle arm_idle_wfe_poll(struct cpuidle_device *dev,
>> +				struct cpuidle_driver *drv, int idx)
>> +{
>> +	u64 time_start, time_limit;
>> +
>> +	time_start = local_clock();
>> +	dev->poll_time_limit = false;
>> +
>> +	local_irq_enable();
>
> Why enable IRQs here? We don't do that in the regular cpuidle-arm driver, nor
> the cpuidle-psci driver, and there's no explanation here or in the commit message.
>
> How does this interact with RCU? Is that still watching or are we in an
> extended quiescent state? For PSCI idle states we enter an EQS, and it seems
> like we probably should here...
>
>> +
>> +	if (current_set_polling_and_test())
>> +		goto end;
>> +
>> +	time_limit = cpuidle_poll_time(drv, dev);
>> +
>> +	do {
>> +		// exclusive read arms the monitor for wfe
>> +		if (__READ_ONCE_EX(current_thread_info()->flags) & _TIF_NEED_RESCHED)
>> +			goto end;
>> +
>> +		// may exit prematurely, see ARM_ARCH_TIMER_EVTSTREAM
>> +		wfe();
>> +	} while (local_clock() - time_start < time_limit);
>
> .. and if the EVTSTREAM is disabled, we'll sit in WFE forever rather than
> entering a deeper idle state, which doesn't seem desirable.
>
> It's worth noting that now that we have WFET, we'll probably want to disable
> the EVTSTREAM by default at some point, at least in some configurations, since
> that'll be able to sit in a WFE state for longer while also reliably waking up
> when required.
>
> I suspect we want something like an smp_load_acquire_timeout() here to do the
> wait in arch code (allowing us to use WFET), and enabling this state will
> depend on either having WFET or EVTSTREAM.
>
>> +
>> +	dev->poll_time_limit = true;
>> +
>> +end:
>> +	current_clr_polling();
>> +	return idx;
>> +}
>> +
>> +/*
>> + * arm_idle_wfi - Places cpu in lower power state until interrupt,
>> + * a fallback to polling
>> + */
>> +static int __cpuidle arm_idle_wfi(struct cpuidle_device *dev,
>> +				struct cpuidle_driver *drv, int idx)
>> +{
>> +	if (current_clr_polling_and_test()) {
>> +		local_irq_enable();
>> +		return idx;
>> +	}
>
> Same as above, why enable IRQs here?
>
>> +	arch_cpu_idle();
>> +	return idx;
>
> .. and if we need to enable IRQs in the other cases above, why do we *not*
> need to enable them here?
>
>> +}
>> +
>> +static struct cpuidle_driver arm_poll_idle_driver __initdata = {
>> +	.name = "arm_poll_idle",
>> +	.owner = THIS_MODULE,
>> +	.states = {
>> +		{
>> +			.enter			= arm_idle_wfe_poll,
>> +			.exit_latency		= 0,
>> +			.target_residency	= 0,
>> +			.exit_latency_ns	= 0,
>> +			.power_usage		= UINT_MAX,
>> +			.flags			= CPUIDLE_FLAG_POLLING,
>> +			.name			= "WFE",
>> +			.desc			= "ARM WFE",
>> +		},
>> +		{
>> +			.enter			= arm_idle_wfi,
>> +			.exit_latency		= DEFAULT_POLL_LIMIT_US,
>> +			.target_residency	= DEFAULT_POLL_LIMIT_US,
>> +			.power_usage		= UINT_MAX,
>> +			.name			= "WFI",
>> +			.desc			= "ARM WFI",
>> +		},
>> +	},
>> +	.state_count = 2,
>> +};
>
> How does this interact with the existing driver?
>
> How does DEFAULT_POLL_LIMIT_US compare with PSCI idle states?
>
>> +
>> +/*
>> + * arm_poll_init_cpu - Initializes arm cpuidle polling driver for one cpu
>> + */
>> +static int __init arm_poll_init_cpu(int cpu)
>> +{
>> +	int ret;
>> +	struct cpuidle_driver *drv;
>> +
>> +	drv = kmemdup(&arm_poll_idle_driver, sizeof(*drv), GFP_KERNEL);
>> +	if (!drv)
>> +		return -ENOMEM;
>> +
>> +	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
>> +	drv->states[1].exit_latency = poll_limit;
>> +	drv->states[1].target_residency = poll_limit;
>> +
>> +	ret = cpuidle_register(drv, NULL);
>> +	if (ret) {
>> +		pr_err("failed to register driver: %d, cpu %d\n", ret, cpu);
>> +		goto out_kfree_drv;
>> +	}
>> +
>> +	pr_info("registered driver cpu %d\n", cpu);
>
> This does not need to be printed for each CPU.
>
> Mark.
>
>> +
>> +	cpuidle_cooling_register(drv);
>> +
>> +	return 0;
>> +
>> +out_kfree_drv:
>> +	kfree(drv);
>> +	return ret;
>> +}
>> +
>> +/*
>> + * arm_poll_init - Initializes arm cpuidle polling driver
>> + */
>> +static int __init arm_poll_init(void)
>> +{
>> +	int cpu, ret;
>> +	struct cpuidle_driver *drv;
>> +	struct cpuidle_device *dev;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		ret = arm_poll_init_cpu(cpu);
>> +		if (ret)
>> +			goto out_fail;
>> +	}
>> +
>> +	return 0;
>> +
>> +out_fail:
>> +	pr_info("de-register all");
>> +	while (--cpu >= 0) {
>> +		dev = per_cpu(cpuidle_devices, cpu);
>> +		drv = cpuidle_get_cpu_driver(dev);
>> +		cpuidle_unregister(drv);
>> +		kfree(drv);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +module_param(poll_limit, uint, 0444);
>> +device_initcall(arm_poll_init);
>> --
>> 2.34.1
>>
>>


--
ankur

