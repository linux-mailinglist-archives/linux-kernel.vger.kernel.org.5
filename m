Return-Path: <linux-kernel+bounces-50925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C60228483D3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5371F25851
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C581710A22;
	Sat,  3 Feb 2024 04:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LHANAN+C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YX2rn9Lg"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBF31119A
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 04:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706936228; cv=fail; b=K1vxGGlNeGdY+0cU4dIwdN+pEu7dQSVhhhG226NtmijUG0HdAuJMaY72a5gjTGOY6zz7mjzgZwIHJRi6QlBC1yIclKMlIY0b4bLQBsFOfamNP9PTNeVrZhXGhTTSfdcJ970ghpco3Iz7/oab/JH3ihFdCZk1EsKXCl0QQWsgVjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706936228; c=relaxed/simple;
	bh=d9ZVbk3I+r3Ax022nuPfAwRg3D+s95IrE15zrsqOUdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DtW6pYAhWl8zvLwwvaASGG5Vgex9x+0CJ7rI9+tlKFvT0SAJSbqUZlN6hdyqZ2eK+oIbTH5F9QHaRmNdbWmrN+IDS5kYZPJMumy+ow7BvbyxnM2ctGlsyS2MbRZDQVaE137b+mTulPBlrLe/vZZaLjxE/7kqH9Nioj3nFSNQUCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LHANAN+C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YX2rn9Lg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4133wZQH021993;
	Sat, 3 Feb 2024 04:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=dUwJ2pID1pIrZYXIf+ddXaI3iABDhZfRrCU0gryiNvI=;
 b=LHANAN+CHTYjJh1Kj2wang5XpR5q/WkWpn+y2krxQD6Prx5z6FGxI7CXoasIOyIJtGc9
 9h1NMJnMy5bLWZT8rpkRJ/rAgz5ecWQIqH/TIvqHUkMDfIz3Mpz7NaCuKsyyzKmenW3G
 kyK5RhYFPwGOfirJ6EaLpXE+N3l2+fZ0qZQfbCjj0pPmMcRUidfx01PDYJCj36c/W+cx
 tkotXnYdiR7633pHvoGdOF7mrB661n+ZMjY8OJqmQ0C3gYM8ajJtddFSarTz3lSHlgjq
 H23QplukHZ+EQHithP53jFOTwP5k9zsvnbHeuxUlLwo8q941mR94f5DyHDAhRzJXz6Jo Mw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c32g54s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Feb 2024 04:56:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4131XTm7007100;
	Sat, 3 Feb 2024 04:56:54 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx3ca9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Feb 2024 04:56:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nzu2SFn8uy39bvxMjdKtDdwxt3m3A9/RJASyXDtkRQ/eYRamu05Mh4srRgHwnY17fh4lVmJQHy+/6qiUtgm3HDxgHQzxvwuPxePbWOJp26TqqSVaJTnKJARk/xZBqHa2CAwtAmmNILLmpv6surZzZFvioHaJxF3ttxlZPOKnk1Uq4EHQgfjmUvh+NP3bCZ8eveG5FREFLCTwBkquIuTiUOmdH6FHLxo/EFpQajHIJslK1nBF3lBAs5qpPKes8w+h+Wb+eCzOboQz4dk/XHlWdidkPz7xOu9Lw6wC4kflUjZarTCtuqXrnbMOOSIvALbAlamb8xQMpG/1e2MDNgLiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUwJ2pID1pIrZYXIf+ddXaI3iABDhZfRrCU0gryiNvI=;
 b=W1rTbLIFgJoxz3O/t6r+dz+0Xh2O/QwqCAbxC5ft/q1KOa+ZMWvo+AYYnkY3ezo3z0H/p5cN/aEDQ6R4E9IYnnaAcuZMxgByVgaYPutV2CVNiCnqpPwkMX8BGUBt8g6OzrTFRCF2HI3ZJl/3ScUwfwPejpt7BY3XL+zSxxiNr47nbKG3SBvdN5TkW+YoRg8Nm8x3jch96dm7/0ZDRaDFlvUGpvRIyWdpErL+Sw+sGuGKzQHt4hP9NY+VR7rNK0/wSmX/pPLcnUsdH1k+UqFYs9+HjDJd1ChhaRSPHWoDn/Kj4yTBa6RWvmTpnWKp26AP0/keGkMy8eY8wCnDhC0RnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUwJ2pID1pIrZYXIf+ddXaI3iABDhZfRrCU0gryiNvI=;
 b=YX2rn9LgBMCqiFNvXr9K8HKr+rtEvAXlkVv2qlPfOELgW37xMUnfQKPUIK5dzTYshJpMEVJiWOpKUYiXAwQkMosOzjgYpGfGaJqfbANPLGzuY4Qv9BTgPJ9FgsJQM1FIwIzM39azZ7orlMV28K6YiQcNXkajvte+IJHHKu/9hpA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB5308.namprd10.prod.outlook.com (2603:10b6:610:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Sat, 3 Feb
 2024 04:56:52 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7249.027; Sat, 3 Feb 2024
 04:56:51 +0000
Date: Fri, 2 Feb 2024 23:56:50 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/mmap: pass vma to vma_merge()
Message-ID: <20240203045650.lyavwh7lbaa2z2ur@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240203014632.2726545-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203014632.2726545-1-yajun.deng@linux.dev>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0226.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: 381f3637-48f1-4148-98b6-08dc2474894f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NR+HzrNo9ue4Fu4pc0EHp5j8Sqi5PrBeijuIiq3AU4wdTzwgVcoR1Hgl/EwQ1GfaZ1iitE68cKwqr1gayNy8e03n32fx2Fgdx14xFSThIerlpi1HPMhaogVl1y4ZJH9HkWGw69gRiSuLwvVdFGtUpJ8Ak8TjnrsngMHpGwm1MY+Nn0zosoDhtnsv+VReDwCoTj+aqkmOn7O3JuYL8OH783nokWPlXKqD3V6f8I7AH6LaK2KRA154ApXpxLsxDOlsCGgK5SJ/zbe2zXuv4+tqzzIyw6s0L6NEZUg7nZakaAghZREWkPHcPb4UxFtZvGuzQem2PAVO0cCbziw+yo9+Y6xb33wvAB5rI3jy0zJvYeyFA81s0LWJh6lg2D+9dOdSW1YwGr/d2JzPBK16+Fr8NuPKyl9yp+wiLCiiZhWN6bvUzRgq9o7vI+V5+fTH/8jkLYZSvL0RPhEDcAxAwizrLtzqkMCVpzXh6Yvu5gN588NqLuvXTVAWXY2rkuHtDjOX/UWbOasQHwS+oeZ0jkNdGNDDmcCeVZcYwePHn1JoLsx4HVfh8zChWpAP0PqQiexiBLWLuyfc6tRN85Y2yA7NDA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(33716001)(26005)(1076003)(41300700001)(66476007)(66556008)(316002)(6916009)(6512007)(66946007)(478600001)(9686003)(6506007)(83380400001)(966005)(6486002)(38100700002)(2906002)(5660300002)(86362001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uf5X9kT6aG24WBKQREeok/ahskvjvB7JUJ1JrGMEEjPuCT0orXIQjfNF0t36?=
 =?us-ascii?Q?v3w8RLlbMjiLIzzKyL+FWuWSTE/QZ2ujad5DEsGKME77+LCwDwomNWgU6Cuv?=
 =?us-ascii?Q?gZK6y+UBVuAuYA8z3M1iI704PFqYdMXmAWzDqXv9sq/0m23JucjCIYw9n2nm?=
 =?us-ascii?Q?OKQl8UzbTCRbkUMfirBvrM32Meb3hOCe/DSIdyvPtejaZ455M0m7jTU1Q5xn?=
 =?us-ascii?Q?2auQU6rU1Pn9ZVfmXBmqizRZfO14pHSyTm1k+aM7TkgaMPQHfe3v9kZnJqsV?=
 =?us-ascii?Q?/i+ZFOEXswA2OlW+3iJab6ctpcNQm7TjGZRRCaCjjOhT4exaXnnyysHJumit?=
 =?us-ascii?Q?dSikvXTd9+Tu60EGFH7CI6j6E/virhUlAw5qC+HplcA0yLlxlrok8RbxzVZW?=
 =?us-ascii?Q?8v0Qf7fOcdBPVHRtrkGwusvzUydLeQUY7m3kribpXPTSCTxATnftHTO79s3h?=
 =?us-ascii?Q?FwdGHZ89MwpGmEY53hneuT83jO3GOn06a2gDqOR2N5neLnu1cxUxMopiNVbY?=
 =?us-ascii?Q?AIvGosw0WiGX0puq9ZKbw9XUD5hP2iYKhqvbRLCiJ/oMq6e2H667sTzfv9im?=
 =?us-ascii?Q?b4PH9WNYmRlxWh3GIt+TDZnk97+mVWxG/7EQV9yOuIo0MXLHZEajL2twTxau?=
 =?us-ascii?Q?lUUvHMrmtzOMeXf+iMZc85rr9vT3tnuY+7XOFNP6OhsbiNDs5IiJ1OapfV8a?=
 =?us-ascii?Q?OZJlKF59WoHDfOD0dcwU2whaqU3DRhxH+D8RHo3C/VpzBn5rV+0bRSxb9TmO?=
 =?us-ascii?Q?/77DqAZoGQ9qOjF2QZzyGZZi/A+HkQaJrO2mxPQFrPdOJa6oRoV1yl4IE4o7?=
 =?us-ascii?Q?RwgNYHQgUUdjWIvv08ArXt5/8M1mmgkzTvMfr+Dl2aYbNAPgh1Ox1nqqMe3O?=
 =?us-ascii?Q?dGSbKq71d6jH0Y8BIeYFzkvnq/y+dCly3ZhVNHBXi9+jTC5lqxkvZVrL+Xzl?=
 =?us-ascii?Q?olN5vp9j+DaGJh63EkpQcW+XHW1F9gaaUbqw/MHjJDRACIj71T+CKc40PD9v?=
 =?us-ascii?Q?NhNFobbahaIel1RZ1eV7DhjlO0+MZ2aMOh1Sa9Zz6zOhIpri8zqPf42TC5AR?=
 =?us-ascii?Q?uEltoNlWImAeAgZUL62Q7hUzAMctZBhmY38ML8HLcelYxfEIw5UOZtaGDfJh?=
 =?us-ascii?Q?9eaad+ctKjCKU3SokA+ZiJ1I9zqLIeDU1llRL5rRYWusLAa94mXKKS+iwer8?=
 =?us-ascii?Q?ZAdV94ru4IjUMM4fG1rJu7XdytOICEzilTX9xr4HJcQNPQF9i/5VnyEuoOii?=
 =?us-ascii?Q?REzNeG9F7090FxLCB8wFyGeIJfLrx3pGqpvuYQesyGDMA3IVGulmOZ0pnN8/?=
 =?us-ascii?Q?pEBqBRKWMUdNGkbOmi4awVv1Xla5uc3BHC3sshC9vqD6pMVyLoZ+WV8ZPhy8?=
 =?us-ascii?Q?DT+LqFoH0PgGUUTHkJFuywiJEaeZd+hR3EYZn88tYFmLVayQepXivePB3Bsy?=
 =?us-ascii?Q?ZVfuEtLBHQbGBBpV+y7ou4NOU+svdxghYJ8zlbBdaRXs5bWOB5bHk4K6NOYJ?=
 =?us-ascii?Q?EC6Utjpa0HSaKfbUf94A8sQD4yeFfU84PcY2iS0z0s91Su0DTUwC8nOIuXdH?=
 =?us-ascii?Q?JRv+2WCSTEmpNxkRGT3W83iQwtsmOa0ytxWvaoOEJApkZpgwufCoKasmjbSk?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yqV975Twq9IfvHRVGHQSdeuGNnCwE5cjbWsc6olIo5ypkVR+uGDdLp9p4ilesoSWBmcVj8fDHAXP7XUy0W2bN633wwXl9qcF9T2PmAbLNMVGQwXsotSrKP4l+e/xBcfumUepw0gO+OhWrG6ymz7YZOsN2vjKGeTPdiiKTA0P+x7rWtgWGDDXqrF6QOubJmdoYzkPL251kkWsW+dDHhgKP4U8GxwBOafknY8hYDMhk7TmMOiP7lE2Prgfjxm9bYhrKeJQUIIo9JBApijPNQBriqcLWdZAcrdg5Cqeyup/kJO+tCYpBOxoPyqJIuMAnH1sPDQs/1ud1qHvHiYzW54hJSuxVhXvnyJvy052A1ozafkPJ/sYiUvVW4xQAZ4CYKpmrh1TXsRnQ7VbhL1CbVVRt5VAJhb3DZpGMtRX9+ZwfFPKqG8wsqNfsi/HMAYrLYc0qej3VXfzVERICQ/E0kYSt6dJ//kWQv6s7UMLzZqKjVHjVPvJNd+VlQMJKqCUiWDIxJY/P7+8bOZgSasNmJG4c/JikUfFqPQFXElHKZvZ7i1y4KYzt297/KjPxDWeMUrxH2Jk1OBz4B8Sms0oL3m4yuT94oft0DR/zxrA7buFQUo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381f3637-48f1-4148-98b6-08dc2474894f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2024 04:56:51.9130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMbHUy6aMrZrTkEPgvN3Fx4tMl18eFikPljxfTlExQOySq9utc6RzXnJg4fC5ZFEtpJayvq/Pwjf3ezLCEBcKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402030030
X-Proofpoint-GUID: TwXWzgyj7FA3uvcTlHGWldtdoN3n8b4S
X-Proofpoint-ORIG-GUID: TwXWzgyj7FA3uvcTlHGWldtdoN3n8b4S

Thanks Yajun,

You missed the URL for v2, so I've added it here for completeness.

This is the same patch as I reviewed in v2 so my R-B still stands.

* Yajun Deng <yajun.deng@linux.dev> [240202 20:47]:
> These vma_merge() callers will pass mm, anon_vma and file, they all from
> the same vma. There is no need to pass three parameters at the same time.
> 
> Pass vma instead of mm, anon_vma and file to vma_merge(), so that it can
> save two parameters.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
> v3: resend the first patch again alone.
> v2: split it into two patches.

url for v2: https://lore.kernel.org/lkml/20240125034922.1004671-2-yajun.deng@linux.dev/

> v1: https://lore.kernel.org/all/20240118082312.2801992-1-yajun.deng@linux.dev/
> ---
>  mm/mmap.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 485a6e1e4226..8f176027583c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -860,13 +860,15 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
>   *      area is returned, or the function will return NULL
>   */
>  static struct vm_area_struct
> -*vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> -	   struct vm_area_struct *prev, unsigned long addr, unsigned long end,
> -	   unsigned long vm_flags, struct anon_vma *anon_vma, struct file *file,
> -	   pgoff_t pgoff, struct mempolicy *policy,
> +*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
> +	   struct vm_area_struct *src, unsigned long addr, unsigned long end,
> +	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
>  	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
>  	   struct anon_vma_name *anon_name)
>  {
> +	struct mm_struct *mm = src->vm_mm;
> +	struct anon_vma *anon_vma = src->anon_vma;
> +	struct file *file = src->vm_file;
>  	struct vm_area_struct *curr, *next, *res;
>  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
>  	struct vm_area_struct *anon_dup = NULL;
> @@ -2426,9 +2428,8 @@ struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
>  	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
>  	struct vm_area_struct *merged;
>  
> -	merged = vma_merge(vmi, vma->vm_mm, prev, start, end, vm_flags,
> -			   vma->anon_vma, vma->vm_file, pgoff, policy,
> -			   uffd_ctx, anon_name);
> +	merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
> +			   pgoff, policy, uffd_ctx, anon_name);
>  	if (merged)
>  		return merged;
>  
> @@ -2458,9 +2459,8 @@ static struct vm_area_struct
>  		   struct vm_area_struct *vma, unsigned long start,
>  		   unsigned long end, pgoff_t pgoff)
>  {
> -	return vma_merge(vmi, vma->vm_mm, prev, start, end, vma->vm_flags,
> -			 vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> -			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +	return vma_merge(vmi, prev, vma, start, end, vma->vm_flags, pgoff,
> +			 vma_policy(vma), vma->vm_userfaultfd_ctx, anon_vma_name(vma));
>  }
>  
>  /*
> @@ -2474,10 +2474,9 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>  	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
>  
>  	/* vma is specified as prev, so case 1 or 2 will apply. */
> -	return vma_merge(vmi, vma->vm_mm, vma, vma->vm_end, vma->vm_end + delta,
> -			 vma->vm_flags, vma->anon_vma, vma->vm_file, pgoff,
> -			 vma_policy(vma), vma->vm_userfaultfd_ctx,
> -			 anon_vma_name(vma));
> +	return vma_merge(vmi, vma, vma, vma->vm_end, vma->vm_end + delta,
> +			 vma->vm_flags, pgoff, vma_policy(vma),
> +			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
>  }
>  
>  /*
> -- 
> 2.25.1
> 

