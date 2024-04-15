Return-Path: <linux-kernel+bounces-145265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0C58A519E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 020FAB25B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B047762CD;
	Mon, 15 Apr 2024 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jypabp3S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DF80lcZ4"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7027074C1D;
	Mon, 15 Apr 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187846; cv=fail; b=gi0MK6KuZBlPkyAwR6Fvwh+6qRqy0LGeyLE6P1uifzeT7l6W6wZQ3wOs/oPU80HQmS6p16m0VK7NSVfZwZE26djds3qQdVeDyOyfmhrfZpHRWOiposiW7j5ek6XnEa67w5QXrlqy3PUylYB/trzUxJ9Pcu6YCMA546j2SsTKD6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187846; c=relaxed/simple;
	bh=M/hiOC0IYbXyMI52Yo6tUc2lKAwyBwR4Z1dcXzTapcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KNXEaEFjiZftcDEHj0wTig3d3PTFKWzonFlhIvO5y4usmBzFQqakt8r99S4if1qnLpXLxC8PPay9xymuqWHOskWBTUAixcD8EjWaMIg/3LKKexgTigYL/20vmA69VqLj5Z1nsUnV/FPmoh+0UODJUNIC44V5I5vdYUmJK30a+Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jypabp3S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DF80lcZ4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FDI2aJ028263;
	Mon, 15 Apr 2024 13:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=EJqZsqrc1jo6o+9dyGfLCHFCdNx658Fwj/kg6wvWCMg=;
 b=Jypabp3SyHLz+R99llWHdP4SD7/05SGqDShjjx1srRi9hXUnAeDw7dnY7uOtnNFUJzQc
 HiI2vGFijBN7Ye4hzjvA4CB6CL12EN8J1BpVrP8CZFb+N84pUo4vE/nqhi9Spb2Ua1ZA
 8kfkwXvAcfUdZ2d1RbvAUto2Zv2ScZuPLIRWscrL9sRWdhh233ccEUZ2FrG0JCUVatXq
 Aj+LRZLxt9VgYQF6o30Rh30ttBYdhruf3dTgO4AxaJVG7qmmpYihKWVqoOIHwlitoI7Y
 YKz7/sSL2tTTAVpnJ9AYaEHMJLUS5yjx7rchKadb+wMdXR9XTAjaMVi5v7fCiLEET6va 4A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfj3e2tag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 13:30:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43FCT9dr028797;
	Mon, 15 Apr 2024 13:30:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg5sbx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 13:30:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcDitBORA5kBqpQ/AJaDkUvZqlZKwaq4+iTC88jzAJQgOHO7zIHcSprBl3wwrsyx5acAVo5SKkJZhlZSBBRnfivZ7hVTAk2lavzWlIRwEqPDFgEr9u8uPigjD8q1Q5PD2GFRvCqqQvc34ftLwRfFpMggWtk03k7+rvoyUz8NTar32eW1E5XRHASGfYAspMuHzsiidSgQm8mIQ9p/lHjwZIbltXrF/LuZy9gFdDbjfBsjFha1zOu7pspS8wYbwfKqM7+/UgMetUqLuRAWcg4ozFI2xA54Yj0LjdwAJa2irf4YYyuGG++898Q+6wWdanBPol5xq3tAM9XgA8ljg1DIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJqZsqrc1jo6o+9dyGfLCHFCdNx658Fwj/kg6wvWCMg=;
 b=PF3/eHBucQ/ZBnYOUNCjCq+FthJvHfmn50lojCOXcoivZvLDlfcRAZOF0JAe5kno+oHXsvdG+YjkbcpQ5ARwVDtuLyQbTiVeS1RzVASTP0cKoaN8KMsPwaU41SzwD1nFMQIkrHIiZTLw5ASh2CY1OMfowkMT0/pU45W84dmwLeuaZtylH/ICbWMcX/NnzpY+QfKBsliX9krLAdE/n/e1eDEz8lHDbXsBaA2xwE2e87m/ba6hUIKmNXdR+UtG8h3P5+EX/CYrRwHeevMX7jLZVPLrXGUbo4UCBHFbkrxknhCzlSihpX0DN9fqNBM5poTL8oRk8Zid5X4BPvb03Lb/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJqZsqrc1jo6o+9dyGfLCHFCdNx658Fwj/kg6wvWCMg=;
 b=DF80lcZ4ZXHGqNt5WjGZJMStbo6txcmxl9J6DiD7/8oGQd7tDfx5CIniUM0/4M3hPOc8VA/Z2HI1jxC+45GxdTPfLMd5oLg2PwBThROantXLjX8Tx/SHbrEbZguSKcIdXE0JMXBsgKM/s8vmUwJEmGCMFnpzUGanVMwyL2/aiJI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7773.namprd10.prod.outlook.com (2603:10b6:408:1e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 13:30:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 13:30:27 +0000
Date: Mon, 15 Apr 2024 09:30:24 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net/handshake: remove redundant assignment to
 variable ret
Message-ID: <Zh0r8FXN45ThNLwk@tissot.1015granger.net>
References: <20240415100713.483399-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415100713.483399-1-colin.i.king@gmail.com>
X-ClientProxiedBy: CH2PR14CA0011.namprd14.prod.outlook.com
 (2603:10b6:610:60::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV8PR10MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 3303ca9b-4692-443d-92a8-08dc5d50369a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	z6M0j3yHuxm1cbPndxFha/bcHeMMZG9/CAF3GCnzB2c97H0BjpZiKVI7DypyOhOsIYrvskWOVU/z15UaDRBlb8ZWTJxWDbPn+DwKua+/Kwp6Gsvvc7PAqs+yAeN7qZwmP2mx1OOTFudnYCDz2FWjIhs0gu9J/6uEjd1genXkqtCcQPaIs+bIALYxed1cLJgxEBa4aoCGoWwVcp4IcjdQzrp7kjF04gpplZB4wYW72rQ3XJDdCx8w0c+wpZYLseLJhda9WRX9Nxv4Nuj2Srh1zqt21+0tw9lxy4LjuhNlBKSVVzUGLchNwsxrkZJwYpEDhfrbus7SklPuTQp3GiNiO+5DzZQdTzpk5S0gXZbmzOmLipMK2ezfK63OjAHmrtCkYtg1qFUtO6ICq3mR4TiPA1EjWebIZKefpr0PerDqzXj9UyeuVo9bBrdQWQYIFqxPN7HD8qfqBaEwjjWXTb6B/kwWM44dYhfoAJtscH72n3gkB+q6uiTVY3taAGX2UJeW6WAZBjUlITdmGe4ZH60+5slR30zD4P9Ir5KRLpMWYYbQbSOQF+Biwzg/Joua0AB7NPlQhXcThERB3H+tM9F/mXuRMfP/8Y2C9txsFGYCyZrFT142yXVZz79TldoJlkDdpt9fycbxSs/Qc5A5weExXuw9ZRnDObWh9isQnsC2Ipw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?md/Q3ekAANxJZuOf1O6RQHkRlGd8c0p33U5ezkK1CmKKSj/6nJm2Clq3Nf9Q?=
 =?us-ascii?Q?Dr/E/filltfsGL79eDw5InOaC41eeoaJULrOBqSUau3+MoB3QxWzeUCkVwVW?=
 =?us-ascii?Q?7eE6Q7RaPZOK2+hvAEwm6WXiIdrYSN1RBCwKP/PpvEJDZfZLXhSDL0BPiaq5?=
 =?us-ascii?Q?ff6krjEjAuHmQ0iecuYitasSnG8a0EF1pPbO77RheORVsdZrFkHgHn4nRdEM?=
 =?us-ascii?Q?vYXtEYplRluErcOLIUZUWGKQ9q3Dp54jkr8EzhKEcWJWdgCRztVbIcsAjfPt?=
 =?us-ascii?Q?YDDF5iuB64k5f/JF0bcCmjfkGmTzGDp2xJWP9x87X6kGXpr1g6RbaQ8/IF64?=
 =?us-ascii?Q?S4VRrHUas6QD31NZpVFmdwMyXJnI3u8AIV/G1dCHbfF1C2muy+H9lxO6R1f8?=
 =?us-ascii?Q?tkRFjw1zMPP6Vu1K5GaT5S26mqkcBX/Bx2j3tOi4t5JOP6E4qRizvMh0QsxV?=
 =?us-ascii?Q?BuesadsN3sIJzObIqOg2f+rcWbX4zJYhLPL5gUpl1UEJ1D1OTrjz7Favv4dN?=
 =?us-ascii?Q?+SDvyh/fH+umoe/1cJXfTt9/MtTB5xj4z4+5iNJROPfoGRL1KiQdK3ovZzef?=
 =?us-ascii?Q?rg8B6SZZG5LDocFTstByO6+8eFLqE/Jez509KeVw/6OMUou/ObSDFIKivJ16?=
 =?us-ascii?Q?Gn0HKAorb4jFhWYABHdmpj8t7lMJhDOW8RMEZ1Nl/8XXzsSnqymiRHFiWWL9?=
 =?us-ascii?Q?ZrzMVysZhaKMEscuypETwIEBT12JGbWBpD7FIPBW0iGg4QdDti02xPBQgZTU?=
 =?us-ascii?Q?knB3ej8IesUnqcxH5CsPZCL+zdGYdH8L2+mljALU6aHIK6aI7ZoDD/VxLv7q?=
 =?us-ascii?Q?/92K1HpGcbXZLNSyzilcA5HSYNLJ1VARthRsmkIDqc4jvZSqXxdfiPnAy2dc?=
 =?us-ascii?Q?IjPBFFcVdM18wMvmwLuomubZyPBzRbJT2cwE7IWQ9ioRdFGuU2ThD6Q0wDut?=
 =?us-ascii?Q?1Uzx8e1+UgwcXcNzUmseY4PkKKgrM/gP0Go1aeGwX0mmrE7lRfG9E+tv56bP?=
 =?us-ascii?Q?jNcKgOYS46Haoa4OTDdyqiSRb+x3R0OQNMI0nFSgD421wTzScG560aM+Isoc?=
 =?us-ascii?Q?jYruVqY52z35InBPXQrDqZcB38rqKzFLwNKTjj35cleRn7SHKyyMwmNJK8n1?=
 =?us-ascii?Q?loJ+oVHTJrO0SEDdgLFCJVkO4SgeN0Y9kLdJ4fYPyOxcJbR6sJ/XONrlMPBd?=
 =?us-ascii?Q?a+q+DwfATnWiP80A3TXhekDUQzX6BcFftdFICvYmq7KrOQdtl5nkq50Gegx5?=
 =?us-ascii?Q?+2+Vd+mxOXsfUlt2MhMH5c2cXoUXOFvIPObUZ1B8NJ27m0vtpyql6QHB7DAc?=
 =?us-ascii?Q?5m3fg7JmpP7zmctEtRYF8KqVyTclSGGbQjO3coIU53AwnXZuzxRfJ8VrJ6mC?=
 =?us-ascii?Q?Bu+jI9E6yqjpoD8XLltCDP20kC7WbDYCgkvFaux4xOhnU40HCanEJxogMWPx?=
 =?us-ascii?Q?bs8oJO073YSWW+uTKOWQJwu8mn7G0Yu1GUfkAPz3d0n+vSILujmXy299erx2?=
 =?us-ascii?Q?xW7QvbOx+KDL/tCF9uEvjr4brAwpZ5Lng0YxizEL8+aUAkAX3NGSajm0sD68?=
 =?us-ascii?Q?zPIYVV1l8FN3FkjFmN/QRWaDtHAxYwUlKCDkRTmcxc86jWkeXLTMBGQ/W8sd?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	M1nKWl8TzPhAJctsuHz/qjssxse/8W53Cz4gugbze60AmjZULNERbpiExM4xbHG1ILWl3iwmsRENcWH8yC1f5ZRLadBkWa8KCF/bcxWYzkTU1bW0Wplq39gU2pc6QF0YUKyiW/wxsDBZAYejRi+Dd7HBH0MOWpN0co34Tfz9LTLTqnSQbDoM8fI51sOyvNRe736Z1HoScn038vEsGTomH7vm7ghbbDyzcPt0/B9pzmt5fIBn0onvvSHqI+AfJIdErSgr3ui0ekN5KPJiLYf51CawjOxbBLCxKl0YNEqKlmXOxSyq5NAkt/wzt9++naiIzGhsueFaioaInI2PyX0aG+iXRWmbPI86E+ebyqK/51o/x5tOsmcxwQGEYRKNtzAM5GVylZ9HblIb0gr4VLmvAylVkTAUq4pIYIrxBkadUhDplQsuSpPsGs+P0YJzwAtb9+WikVq9C3WnpcpUgwZcN6Sx8/PTSGI/yW3fW114jgalWItaiwC2AAjy7TpBNU319dhR95O5FEAaWEdtF7KW3dfHXhb+v5xcLJ9BjIAXcQFN99Ac1Xfo83ecuKo30G5Topl+KSSjC77JpFs4kRqTfqvey/HiUY5MKnNpX1fYsRs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3303ca9b-4692-443d-92a8-08dc5d50369a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 13:30:27.7990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnWXTO/5+1ZMpWzFut3llO1mBguG8ZyunS8mCDfrggEotVK5xDxUuUTjbYl35zy3vdryPxWk1X1d9L3BBS6bBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7773
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_11,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404150088
X-Proofpoint-GUID: ds4nb4Vb6o5mlVIEDwLL3jPiDnqnIP5H
X-Proofpoint-ORIG-GUID: ds4nb4Vb6o5mlVIEDwLL3jPiDnqnIP5H

On Mon, Apr 15, 2024 at 11:07:13AM +0100, Colin Ian King wrote:
> The variable is being assigned an value and then is being re-assigned
> a new value in the next statement. The assignment is redundant and can
> be removed.
> 
> Cleans up clang scan build warning:
> net/handshake/tlshd.c:216:2: warning: Value stored to 'ret' is never
> read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  net/handshake/tlshd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
> index d697f68c598c..d6f52839827e 100644
> --- a/net/handshake/tlshd.c
> +++ b/net/handshake/tlshd.c
> @@ -213,7 +213,6 @@ static int tls_handshake_accept(struct handshake_req *req,
>  	if (!hdr)
>  		goto out_cancel;
>  
> -	ret = -EMSGSIZE;
>  	ret = nla_put_s32(msg, HANDSHAKE_A_ACCEPT_SOCKFD, fd);
>  	if (ret < 0)
>  		goto out_cancel;
> -- 
> 2.39.2
> 
> 

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

