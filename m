Return-Path: <linux-kernel+bounces-28861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBB58303E1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC788B22A24
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7074C1C28C;
	Wed, 17 Jan 2024 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hd/lmmY3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TAftkyaA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4384D14A83;
	Wed, 17 Jan 2024 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705488423; cv=fail; b=sMcVV/ZlanHDGp9MSNxDpCR1t4H87g2EsyrcCm3s8HeOrJoLDMFNA6GOpJBWsJLQ1EFeJmnEqnBcyKQm3cILdpxSN4UYPl5r1I7XPIvzbZ/rvNDYpkiisLvqp0WGiB7c905lcXHldgvpeZmydhlRojgbYaNappMWYYvNYxWkHrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705488423; c=relaxed/simple;
	bh=XuGWyVs2Iic1xBXQAFGFcQxiUVY65vYYP4QUy9Vg7oI=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:User-Agent:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID; b=npnL8/3/f5HqJND/mExRcovHtpMkbb3F1LIzgCIT8XXo9iIAYCYRZHeGC/TOuzCobQ+7ldZl9ejDNLw6NnCYFd5Vdmc3xS2j0tusB9PPpoS59Bx2RCDo9MFoxxDYUqNOavEHQz4D9Ux0OzdSXNdIHkDqR16uqv6l7Ydp25wujjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hd/lmmY3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TAftkyaA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40H8naWV000771;
	Wed, 17 Jan 2024 10:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=owXtpRZJNE40GVJHN8/wdEHEIlywbk75lrV0V5BRttQ=;
 b=Hd/lmmY3/62m1fIAASeNnAQ3WGgdkUslH+25tNRp3vMpoqXTCzp7a8N/WL8sd/0pZjet
 noZubQsJOd892hyGdzc98vKaTyEgc3Lgu0NulhbLrNlvE8+4ntwX0lMimNldrK9lPUjX
 FSS66RFrk1h3e/isY4nDJV4y/73Qj7ksxomk3pNA+jQpmVWjOFTwrzGWQqAv16txaJ4s
 WApQYCoddB8VLvfS8iulA/XyuwGWkWicowwan0Mdl/bPmDwHHP6OzgYWdFradBoc1p/U
 KkIJhrx01iiIh8uuMRzKM4cPPsJnrHOMl6PBIaTMLaEONC7z3/UOJWSMEBHjIVMq4NZJ 5g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkk2u7eya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 10:46:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HAIA6w020141;
	Wed, 17 Jan 2024 10:46:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgya0s22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 10:46:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFTidC2rcGHn4KzZgsl9ez/JHiWWUs7CoiylGH7dzIGphJNEEltliYNnKjwHbVnza5azZES9vfs7NnJwlXqN1djXV9cmfqSjBMamL04U23j50L8aIXfZDkfowKtCQLkUjftXjsP4DLAvHxD9kbo9P9b2UjV8h7AERS3zLGdNJNLdO2zQHq7buB9nABJMTjrzuo7f17kUpEe1OsEwvxrA48FfTmloWuzBIZ2d7Q+25VyIytDOmrbH20uXSxeMQSrZA7KALly2ZUJNanyiOkCNl4WsOy8PVOMXYXFcuXkRfFdZm8wHAhv6TcKEhOWDqteQIiDZeL0oeziT1NoaWmhglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owXtpRZJNE40GVJHN8/wdEHEIlywbk75lrV0V5BRttQ=;
 b=GEEAJWSnB9WIjfIYyAtUIj3ar2H+Ef0wRJbGzaHDoYaswvvOWGHoxLTTOR1YRTE6oQE2Njy/Ugr3mYKqvq/Ku1h5YMg+Tac0410gAT9MuUbp56Uga93gCwDemT0Z3vpnkwQMcndhkVKKpF4dloHd0V1L1qBAXoxJpCZrRRwseFyj7wKiP4EsTRA2gx+m8FHlTPvFK7GV1dHP4Ovkjigg1PR9+0SMdpwH93RGtciomp0VTT03xDdZVanAZB8sXst23MuYOGL/QmwEbWOnb8WC/EKnq+loL3UqOU/sy3Hg2qLsJ/2bw+VRQkIhrlXZDduN7bQANEMiHT0JZmaBxuq2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owXtpRZJNE40GVJHN8/wdEHEIlywbk75lrV0V5BRttQ=;
 b=TAftkyaA2heW3SH20Qpq8TnsydhdGnAwZB7Rqgm5G5mZxnZEcbReOC57Tvxqjywwi6VvblZZGQJ22QzBpPOAKbPSXDrzMtTC8wpH0NoXV2yfjU7P9fQj/INx4tYaAkm9A3p8JE9IYT8Dfz1ODonVVKoTksRQiRRGWV/rAwtkyuE=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by PH7PR10MB6649.namprd10.prod.outlook.com (2603:10b6:510:208::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Wed, 17 Jan
 2024 10:46:34 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7202.024; Wed, 17 Jan 2024
 10:46:34 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Andreas Larsson <andreas@gaisler.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        Arnd
 Bergmann <arnd@arndb.de>,
        John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        software@gaisler.com
Subject: Re: [PATCH] MAINTAINERS: Add Andreas Larsson as co-maintainer for
 arch/sparc
In-Reply-To: <20240115150200.513531-1-andreas@gaisler.com> (Andreas Larsson's
	message of "Mon, 15 Jan 2024 16:02:00 +0100")
References: <20240115150200.513531-1-andreas@gaisler.com>
Date: Wed, 17 Jan 2024 11:46:30 +0100
Message-ID: <874jfcjkzd.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0203.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::10) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|PH7PR10MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: e03478aa-72b6-485e-70fa-08dc174992a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z4zeuVg7ecOlAXhd6zLtnRhcpd620feMtDwy9TROB7CQ1FLKnOdO5DoBU013vFfvjOMq9q02MBUQKLJ2MyBNm1Dy6noEolisYwZRlLYLiJyeUp5K2o3Zt/6jHXnwbhMhsOK+S+UYKUAb9OZtm+LEgmaQV6t72jqbTi2aT7eHxFQw5k7sOTqOQZPp6CGspzm7rRf8yAKmRbbHgekx+/05TpamJnLOViGpfu3jYwVsAr9q3/BPmKmZd7c+5usCKr9FQRElLwoVbK1DXEQdZUWS5xg9cYAlU3zvRiETV/m/5/VjmIeFDYLuxBZhzMW+UKsvBvjlU8DRZb1VqgPgUIGARb4XnVweZ3JbIQGrx6tasEZQWuFqmO3idcX+g95cJHRycaFtkZLCKNThSeX1IXh8hOuJIFcyLnb5HGbNu4+Xi/YeAaS+QYwi9KUUEPdtmhgfciEwIuKpyENYFhEnqCprBf8e49fPUZZ1drRCFQFlR87TsQTs1GhV5QscJxAe+Rv8lDgybb7kOzWKTXm0vE5PX2Z8Dd+DFVTUPTWr5sLbV+1v9uRpmmg3KLQ/7aQY50msgkog+SWHqu94vW/Jo0rK7g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(376002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6486002)(38100700002)(4326008)(8676002)(8936002)(6916009)(316002)(66556008)(54906003)(66946007)(66476007)(26005)(966005)(6512007)(2616005)(478600001)(6666004)(6506007)(41300700001)(2906002)(86362001)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?o5NZoRScE7ieRkZQ3NPb4fGvPv+P7RjjLTNd3m3lxzwRa84ayleLIFPL1kWw?=
 =?us-ascii?Q?OlCO+YWgcWnt2DG8SfqhYzdTj4U/jWgqyEFQuk9bXrMwV2En2dwy6jOv8Yft?=
 =?us-ascii?Q?UuSmDN/VhjTm/8nUF6y2fJMKhaPeUgZcuQgk0jz1U3IH0338N7BEj0q+gG6/?=
 =?us-ascii?Q?7WvChWIrkN3OE/NisZlFW3BrgtgPUDoBv6OYBASavHWVR5L4w94p7y7HtT0C?=
 =?us-ascii?Q?+IyjPfJC1oglyNNTXCp4GxocvUmlxNHnEmOt8BQsR6cm/eEVAjwUnkUbZctT?=
 =?us-ascii?Q?i9DiNnLlWSqiRwL+D1AMXanfzJw3OAAbvoaShesTeSq2/yPwTgPXEYjwuQHa?=
 =?us-ascii?Q?Vtz03FUOxHkAHMlDo9jBmuiEBYNyIgHDOARdU3irPNK7+CV+5gtHxiGRZcKg?=
 =?us-ascii?Q?Kf/GjgxmQxSyNCstOl6pqyPLZ4BA2I9q2D+nrev/QtuBb+HNQkYrQd8ExsvY?=
 =?us-ascii?Q?cT6yShRrdIl6PRBvtVJNQfA6ZXMqpB3418o9p7Uogh+rHss76E1Wbyu5CvjZ?=
 =?us-ascii?Q?eYQwHRgcaCGbZ+MRtrrm9l+GGnAeDOLXlGAtwWLfmapBG4rBeee8/W5h4QyE?=
 =?us-ascii?Q?LdRIv1wA48teFL+skzmynt4GWbJHBOMP9iAhCrBHPvUh/dP6655xGqGZPCEw?=
 =?us-ascii?Q?5sBaeg36V1LRPpg0vPbhzDP1O5rQVm+iff0mBy33xdWh2ocj3IZv/Mgy0gR+?=
 =?us-ascii?Q?aB+ZjAX/5rOlxAFct2YSQYcQSL1g+7tnGdaA9hAAazKgXFd+oqAEHeUzwgY8?=
 =?us-ascii?Q?FUS98Kf3+rkRnEzwJYQHdDrLIzqqTkjRkI2w3jflyyFCWekxT6SVYXCTBjUi?=
 =?us-ascii?Q?blQeTi+QSkNu0xZKk5dV4KBjtGYiUKMEIYCH4hPWOClFQOk42C2YDjqcRCLO?=
 =?us-ascii?Q?8XJ1QFPD9u2xMjjU/Cz8WaC/uKQq/OlhWHq5wqEuTIAe8FqBVWPiqk0hivoF?=
 =?us-ascii?Q?cU51J4POzZAAAbAFkum65C2C7D9c2AnXfTfuA/dQ8NVER7apaHtmPmNpEkSm?=
 =?us-ascii?Q?fCDnbtBr6QGvCLfd4jUVrGD7AjElW+MxrsReSXoYRQSgYLtPZ1dwa30Z/Oon?=
 =?us-ascii?Q?DDziPrf6fcXDq8DdV+4vTJAV+9srkXi0so5W/z0gK092UEoGtpZTCjQraw3N?=
 =?us-ascii?Q?iwxmxRLS8J8G7afzUPZBYyG+bcT/YIO5Ig+pzXdobWgX3zaY/YreOplJlf1u?=
 =?us-ascii?Q?rLZyaZED9qj4+sZixLT0LCQbpfdAdkyXqKwvZnlKBdVFysmbvau+vy9BZaT3?=
 =?us-ascii?Q?gEbALJyB5jLPIy7DHXptdJqru5sEJVjslrcJGfEjd74L2CnYphpyeIBs7eoU?=
 =?us-ascii?Q?QCDbate7uzjLXt65JuZZDic/eaOMhWuogMmIleg1RFjOIwtERkeU2Nk/w4Yn?=
 =?us-ascii?Q?5gdRoADnB9OHRacGHxgknMY0QSGgRvltS/acz/1xCyKDS7VhuryU+cHVaDsT?=
 =?us-ascii?Q?PHYvKKUbXky7ChJcOgeuSG2n0LRTBm7/DC+IV/yeuuWwSP7++gcMLZpwsQ34?=
 =?us-ascii?Q?ez+MdlMQ/GKzmeVxEYFoqCZjZRYewW7uDqVYXoqN+IbbZcyyBINW/j9Sxf+b?=
 =?us-ascii?Q?fKd/udz0Lk8rDbgEBiMyXa4ewPt7l22dItYxDxL/ODr5MI+ZLI39mPPQIgq0?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5mXohXuio13YcUnp1UFetmdcVm2GUHNkZXaUZa+3x9ulzx7OJoCeOrTL+0x+U3BNMaOD1b4UrwxUfYDqMKcWNJr6GGnMxboWpeMcv/bvKtQk9Mn1S8zgqVokFhtAN9hFpgTQHh65ls1DuQ8YrnM/wHFcNwYIVaK18A7myKV5rtJwlASLMVeDhEGj+gz1DxCsY9Z0G2QpfYKoGdjS5rGAmv7uCxFMsYdLb6oj/OwxC5szjW4Ds2lhrEwLG4IkEIRJ2EXFxRkPRKuqeaWwrkMoPa7Ca99YK7nQyBRsFBhNb5EAyE7WL/0q+urfM2/PME7ugktAsskOc8WldEPsKwoP2YxvjqQqdnHctFwVWAuI1bciSawOuVs+6lmEIzQo4ozoRLKiTy0EvDCph7zxylyAX7EdFRN8aSGqKedv456yK7zk/PMeSPQYzogjljUWY6xlqUxenfSOjqRyPis0wOisVXShdGF5VEQ2QguhOGcPYGZduq+xNcfRzdXm/1QNm7hQdSYUEh2l2wRYp1WFkdAZjEoy/WSnZEC5LttuwqmJJDsquEEnnMmezPjf17Gqq1zjriSixBdHfv3KV/N2iPbXTSQ1UYe18RW9gwkg1DYCCD4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03478aa-72b6-485e-70fa-08dc174992a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 10:46:34.2666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoU1N8axG1T8+ZTIgwTvUmyp7NLFPyG+Gppo2ElvHQp6Asg6m+oSLl0GDXYs3TLHcXiFBXOk2pbU7tBVXT451+siD1QeqgjRALST34v1r54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6649
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_05,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170075
X-Proofpoint-ORIG-GUID: W_WL79-jwpX1Joe0jxoskYLN4SEPRnfX
X-Proofpoint-GUID: W_WL79-jwpX1Joe0jxoskYLN4SEPRnfX


> Dave has not been very active on arch/sparc for the past two years.
> I have been contributing to the SPARC32 port as well as maintaining
> out-of-tree SPARC32 patches for LEON3/4/5 (SPARCv8 with CAS support)
> since 2012. I am willing to step up as an arch/sparc (co-)maintainer.
>
> For recent discussions on the matter, see [1] and [2].
>
> [1] https://lore.kernel.org/r/20230713075235.2164609-1-u.kleine-koenig@pengutronix.de
> [2] https://lore.kernel.org/r/20231209105816.GA1085691@ravnborg.org/
>
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 391bbb855cbe..9e12c8cdbef0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20431,6 +20431,7 @@ F:	Documentation/translations/sp_SP/
>  
>  SPARC + UltraSPARC (sparc/sparc64)
>  M:	"David S. Miller" <davem@davemloft.net>
> +M:	Andreas Larsson <andreas@gaisler.com>
>  L:	sparclinux@vger.kernel.org
>  S:	Maintained
>  Q:	http://patchwork.ozlabs.org/project/sparclinux/list/

Acked-by: Jose E. Marchesi <jose.marchesi@oracle.com>

