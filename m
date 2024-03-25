Return-Path: <linux-kernel+bounces-117333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DB788AA1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98FC1C33DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D0759B70;
	Mon, 25 Mar 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mSNUN5Cl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aqyp3K7z"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6A12B95;
	Mon, 25 Mar 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379440; cv=fail; b=oGqwxmmgSwfc/13T8CvgGQ02G+y91X++7UDRCDxFFuRt4L/Omo2jnWttRFL6swIs7wDjinXtek9TWHRfpeDRu8Uh4uiVcaq2ZThiVReMyLMvkVVjdqS7SemvhBfJcWBeVb7kC//6MNVRPSifjzvYtjjA5cDUFFcXomdz2we9K1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379440; c=relaxed/simple;
	bh=djhct1nIEpmG3QT1C5HhPkh8upfWZlwyg8UW8XxBWos=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oNEQTOwT+VQAFJcCuQZ0+T9TMa/rBjTfq2+PMuRF4p0vfkYirUvba5gYzoE0QPPmfOIAsN8fvPVwqLahPpKIy63v2jpUMKavxE2oRjFLsoDtv7ZTDXJ2F1rjDpxUKQNZPyqP83YC/ICZt2TF8DR7nM7C95vTf2mesacH7S9dXgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mSNUN5Cl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aqyp3K7z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PBufQ1018655;
	Mon, 25 Mar 2024 15:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=liUpamxuHWr99HHnI2QT6ySO+qoGxgUhPvOL0mGsjeE=;
 b=mSNUN5Cl7nGzvPYLRDouXa5cOsc+X34Jy0iHcAaeHsy8l1S7PxihZrO1UZrC+1LayeL4
 VlAm7Poev4oUbS9fjlfQ4GusI3rFtrOLsS+77s0Hd3gQqLLgJWlNF/Pgb2UHYptrheFA
 kzZrLmRloHni64nyi9pszq7UUGBZz9Kj/JIPI2WnnsRWI5+I528o9cmXrRWrB2DhxJeQ
 8u5IXNau4iitgHDcr8D3wjwtL5fOKbjfEZfpm8Pol50gc1SdjnKGCQ5aE4Rdrt5XZmYi
 oWMM4+pZ9fFbRUNcSrwJ2BGfXnRZ7up7+1QJYFAuRfXWhgIHQc7sZvud/JaEIZ7uWSCF Jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1np2axyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 15:10:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42PE15lE006893;
	Mon, 25 Mar 2024 15:10:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhbw1n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 15:10:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TE26HxqavB5FYEwfuOVeI82ymClLoRIuYpSxyRhlYaG5e9R6sJWkJxEmgnkJpayTXAK7hBVZ/SuWXPeZ1lh9/ogRr/6VIr8x16HTi841dHkeo9uVQTbyk1Y/cQSmH8npAgoisAi/x62BQ7kkk6XtIZywpvygaE02zKZ62XRfdW1pf/qnJj2QPv5nTgL+HvDb79UZ+XUhput2pdz0vjn98uVGn1PUzuPcjKNaSe9K9dZbn7OVSj7EfdQPqG/wlP4aaIFlg61qqD2mX1THpoZ5d46Y875P4Hy8hbkC+9C6CWx9FWhHs8kJBpNyUlpidd/AvzQVbCl9zPIRqV5Nybv1eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liUpamxuHWr99HHnI2QT6ySO+qoGxgUhPvOL0mGsjeE=;
 b=WUIVfmD1VlkMG/GN0aSARGV2QB9+92cyNnwAbKjEX3y6uWbH8petN59MZuM29fTeEFDt8Hp0w55PrlHg3fJoHgF2h8UjrDUlAsoY/oZFkyu+KacGCTg3do54dgFRnRBy0i8wHsGmxo2IB0Yi/7QVPbenvIOECq21L2druL/zekM3L8/7HEerySCw/KKz4frMygPNNjA7PGPR864AOPUbYsAw8+I9UAvonahSKK7+AdrYfSnrWgcSFSEmqE5HrcIsWYwa1BxhoF5GkFSjqzlKS1quub376CxnywP8FkDpfisA6piTfqH6q2aosQy9ZatUNpPRmudy4QuRVjaQNRk0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liUpamxuHWr99HHnI2QT6ySO+qoGxgUhPvOL0mGsjeE=;
 b=aqyp3K7zvbvefBseulIkpij8S207mhubSSuNK9qWG4QyvhZQvOz2uWocrsl3CqFXf4MLC9qtO3wshbf/yXWRZwMo0lLp6y3l6/klhasSxQJ+lEyiU223Vtgpks135AAyNS4df3eWHbiZ7OIdpXDFdMhqpyThTqHqe5qWGJxhiaw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB7499.namprd10.prod.outlook.com (2603:10b6:610:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 15:10:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 15:10:11 +0000
Message-ID: <3ea54627-339f-4d19-896d-5843a8b9e55e@oracle.com>
Date: Mon, 25 Mar 2024 15:10:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: libsas: Add SMP request allocation handler callback
To: Jason Yan <yanaijie@huawei.com>, Damien Le Moal <dlemoal@kernel.org>,
        Yihang Li <liyihang9@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@huawei.com, yangxingui@huawei.com
References: <20240325131751.1840329-1-liyihang9@huawei.com>
 <da4de4e0-6d13-4509-b288-a9d122d1c2d3@kernel.org>
 <e7612e81-dc44-7bc6-3bd2-0b71367408ec@huawei.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <e7612e81-dc44-7bc6-3bd2-0b71367408ec@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0280.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e03d2b3-73e6-4d0b-0e5e-08dc4cddaa4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Nxtbjq3D9mkEZXEkupXLJwjQYYPLqdZhZwrZ52nRDP3y2eP6OMyA2zbCfwX6HrYlQjfydn9pBjlbSEzzVHQ1gIU2YNegwn+G29+aGkrn7RXMkcrCSIQN3sbNTkihKXtoODqM4PNtMFA/0O/xYjj8x7pBjbJeadHjCD6zWDXGTHD0sOQk2h8W/u6PVKSI5JB3mR1ogtu+ay4NnlRerwaYB7X+mqAevrxqa7ATKzZ6dq/SQS62FaYJSzQTaUd/9yqFLZPRWe/LBO/ATsQWy2YRMkGahyWlJvmiTNJoMZvqBeEljfm/hNF/6NtSbhrBIZi8fP8O77XQakj3f88S3djrerx7i8uu/DVjSH4zlfxtMgTIl58ypADL3CSuvIJt6oyCGunbWPU06VvLuoxe2Fjc5XvhBVPEvFk3sPOSw+DNB1nuOUhseMkLik0Usfh4PBDhQ7ujy9x0fokOihiHDI3kO8Hpjx23jEiXTHzWQlkBV1AX+9tyt1TnO2e0uXnzfamuZDdoDXwzY07h03p3ELVbfsTm15RFxC7UTcE5MgQ1KH+5/PNveQbKQWdqCPRESnd/N/OTf0WH92N9eteI6znNaRIhJtSwPruXQ4lFU0DSBS8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?alRtTTJNWEtCRUlPVjlvK0N2V2ptZ2t0WVRHM2lSQUxyMzR5SW84STB5dlZW?=
 =?utf-8?B?akxsRlZSM1dCRWxsQ2w2TlNNYXpDZ1YzNXA0bUN1bi9kLzEzcWViOHQ1Ni8v?=
 =?utf-8?B?WHFxYllBbi9iQWF0aXNiRUhlSVl2TFhXZEh0ZzhtSDBYRUVzejhoRFFHSUVC?=
 =?utf-8?B?QkFqNlhCTXQxQmJTUDJ1NTd3RFpvWWpKZDBKbyt1S2xXTUY1dTNvdmhHMVNC?=
 =?utf-8?B?Mm41MVY1UzJXRlZSK2ZzNjZLSUo2d3BGMDVHRlFhQUx0Z3BnMTlIUE1rZXFG?=
 =?utf-8?B?UUk3ejJaVHZFNlBEZ3duenZCMDlHdEFhaE0wYWRIQ0luNjBraEhkTHozNWRP?=
 =?utf-8?B?SU1aa0hGTE13QnpIU2l3eWw3V2NSckE3RmFPYW1UeW1CTkYwMkwvNy96cUx2?=
 =?utf-8?B?L3E4Vk5rNjRqVzJRaVFrc256M2Y3Qi9zQStqdUF4RHVkVENkMWJQU3g2OFA1?=
 =?utf-8?B?SEIxR0xuR0x0cUNyYWtJajhaR2cyNkpqQitZMkJaRDZaazl4LzNkU0t5KytX?=
 =?utf-8?B?Y3R3UFMrWDlUSGFlNUgxQm5FZFZzSUpjY3ovYVVieFpscWI3ZmVTUjdPY3di?=
 =?utf-8?B?dVRCK25kRWVxUnM1dlFHWFBPaU1LOUtoSFV4UUpaeGkyR05rTE53bk1pRnhq?=
 =?utf-8?B?NVRmOGFTQkNGK1pKNlB1T0IyNVhyU0liY0tzQkd3MDNjOGUzNEdpTE94Smh5?=
 =?utf-8?B?Ymw3eTRkVHpJY05kWEpzVUpLWHR2UVdmNWVuQ2s0NTYzMzcyd3dGeFVBMUJJ?=
 =?utf-8?B?OVk5QmVRNzYwMExBMmVZQ29SUGtDYzRVandKWGdkanZmak54QkVFTURKbGxU?=
 =?utf-8?B?S0ozUEtTWGc3Z01EWCtWRGRVMG5ySTlCc2tVNmtrbHJpMEJWbUJzMTlLVEJM?=
 =?utf-8?B?QzJud0tSaE15cmJRQkcwV1RsMnBuRFdDdERDWFFOamZHMzVmUXVjcVc0ak5z?=
 =?utf-8?B?a0hsYkNhbms5OUd1MUJ1RUJKSE5ub09FV3VkZDNxV1psbVhtd25XWTRKdkJh?=
 =?utf-8?B?bTRqamJpb2g3elpxczIwdlFEZUFLQW82VkpKWDF3cGRvRWs2TEVYR3d0dDNO?=
 =?utf-8?B?UzZuak83UUJ6T0F5MkVzYVg2TFY1MTk4cFovUG5LNlZYK3JaNlNZSUVjZHpZ?=
 =?utf-8?B?L0Zrb0pDR2pmU0pwRS96ajVtVUdqUUw0UTJtRmZDMVBObW9aWVFxaFRwZ3Zu?=
 =?utf-8?B?cTIzK0x5d3JJMkc1RDNvQlJjL09sSmM1QTVNUkdEdnh3d2xTeThqd0NqQWpV?=
 =?utf-8?B?RTdMeVY0Q0lpSDM1aGI4Tnp0UjF1L1JuNTBsZENYY01XVXRqMGRiVmdzOWkv?=
 =?utf-8?B?cXNFSEVpZXpSeGVRN00wek1HTlYxbm4ydHdpSFNRUk8zTWN3RC9mRkc5N1di?=
 =?utf-8?B?OXc3WnNSNTI2VURrWlpnb1FWeHIrQ3NIdmhJbEdkYWNaYUZJWTNBckpWSHpM?=
 =?utf-8?B?VjA3WVJCcmF0MVM5YlcyU29SK252NTE1MlZNQmxHYUdLZXVPRTBUSGVmd0Va?=
 =?utf-8?B?Q1AyaUVaQ0N2em1MdUlKOXFMb0EvVEtlVnMzZXhJNitpZ2V6WHJXTUo4L1VC?=
 =?utf-8?B?NWV6eHduWmE5SC80K084MHpSR1pxa3pVOEVsT2o4VUNZZ1M0aktXWnEwMmhL?=
 =?utf-8?B?L0dmYmNzRWc0eXc5Rll3UEJiQXd5OEFLanRVall4QVNaU1RjNlU0WU9CN2JV?=
 =?utf-8?B?VkU2T2k5NGIrN2pZSnpnUjIrWDVhc0QxMWFuMU1menpBUE95enJjbDhqOGlD?=
 =?utf-8?B?V3c0Q0twWE9EREtjR1pMZUcwWWdBRUcycXgzN2QvTEdKRjMzN2FYcGdjNFJY?=
 =?utf-8?B?c1g4UjNkaWczY3dFajkyRWk5MkkwOVZpMkJhUmtoZStqWGhWOHRETDY5M3Bw?=
 =?utf-8?B?NTE1TW1Mdkp2Umt1WmcrSHcyK0tzOFNoUC82OTBUQlRGYkozRGI2UDJvTm5i?=
 =?utf-8?B?Q3U3VWlUWXBpa1JqMHBrVHBjQmo2S3FDM1FtdFN3QjcrMmRnR3NWNW1XdVZh?=
 =?utf-8?B?cmUzOFpUZTJwb21OMjJBbkI0UGlLSXoycGIyQUhXM1BZb2xDeHZwUkFDVysy?=
 =?utf-8?B?S0JmRmZvb0pyR3lNdTdCRW0xQ1ZZNHA3ZlBGclh1RTAxQjRWWDRGQU9HY2tY?=
 =?utf-8?Q?5JddI1uBOd/mmLBlUzNEiDUKD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	E3FaY2aZbVlJMabPUjGKF/J2kMVPk6NFkWZgmJDnMrPAXGpg42yaq3EcmASX18ucA/caAUWy+L0HbUmdaPdGLIjLqZmNQyvF567FUEFqCKhUMRP9v6D7UXAXpwJE+tzThFOorByYaJ+0ZknNhxGz+8jnSJJuwdkLtE+dyJV7Js1dD+r6wOV8/PX77cTlKOeEjwgWl/EkFEgVXnnOuO3OBZBpTrQDzbxJ4NJUae6JclyQcQLFDqJVJArxmKa4HJHbM0X4oNMcBQSYD5grfljcys+j8TQUqNlBrGoDuaisc6haSVkKmoqKag1MSpD9Eov9oLpABXz0xEMHlkG5ntUeVFkoO6fbyo8CKhG8W3QE6S21XW1hhjgQnr2FQB6QsmV+ak4BqsrrsW8gw1c5VwbtAgEC3gCiR7xeH2xbgjIxwLmXN+L6kpbVyZuuk1k2fH7Rudcx+Ocdnhz43Caz+bcUaUtDXKM/rgD7+Px8yANpYXR0FqBfcTxRn4uUfdECF4YR+FtupgRzD7j8/fLBqLpSyrMVSzTSWR/ijcqL/eNyUgErtE8j6Lcji/ulJv94+ygOjs8nswyjbtIFbt0ZS0TZ61urRSIU5tMWXryBHXMd9NU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e03d2b3-73e6-4d0b-0e5e-08dc4cddaa4f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 15:10:11.0317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wIfbQVhgpfLLjQYUQRDaKbpuCd57IV83opP2m+oC2QtsoSOtfiLhDG/DDOhgvNQvZLKGOh/OOp+BP+h9Lhy2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7499
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_11,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250083
X-Proofpoint-GUID: 3GhrghPW7ImWzc_GTcPUl_hOluJuKXF7
X-Proofpoint-ORIG-GUID: 3GhrghPW7ImWzc_GTcPUl_hOluJuKXF7

On 25/03/2024 14:21, Jason Yan wrote:
> On 2024/3/25 22:03, Damien Le Moal wrote:
>> On 3/25/24 22:17, Yihang Li wrote:
>>> This series [1] reducing the kmalloc() minimum alignment on arm64 to 8
>>> (from 128).
>>
>> And ? What is the point you are trying to convey here ?
>>
>>> The hisi_sas has special requirements on the memory address alignment
>>> (must be 16-byte-aligned) of the command request frame, so add a SMP
>>> request allocation callback and fill it in for the hisi_sas driver.
>>
>> 128 is aligned to 16. So what is the problem you are trying to solve 
>> here ?
>> Can you clarify ? I suspect this is all about memory allocation 
>> optimization ?
> 
> After series [1] been merged, kmalloc is 8-byte-aligned, however 
> hisi_sas hardware needs 16-byte-aligned. That's the problem.
> 
>>
>>>
>>> Link: 
>>> https://urldefense.com/v3/__https://lkml.kernel.org/r/20230612153201.554742-1-catalin.marinas@arm.com__;!!ACWV5N9M2RV99hQ!L85qzmByNbkBbZByXKuNMAhvt8wxKPCsogKt3Pgn93DTkzfc54jA3of5XL8oEDDDDTMU1OtghdKiLZdKe5ub$  [1]
>>> Signed-off-by: Yihang Li <liyihang9@huawei.com>
>>> ---
>>>   drivers/scsi/hisi_sas/hisi_sas_main.c | 14 ++++++++++++
>>>   drivers/scsi/libsas/sas_expander.c    | 31 ++++++++++++++++++---------
>>>   include/scsi/libsas.h                 |  3 +++
>>>   3 files changed, 38 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c 
>>> b/drivers/scsi/hisi_sas/hisi_sas_main.c
>>> index 097dfe4b620d..40329558d435 100644
>>> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
>>> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
>>> @@ -2031,6 +2031,19 @@ static int hisi_sas_write_gpio(struct 
>>> sas_ha_struct *sha, u8 reg_type,
>>>                   reg_index, reg_count, write_data);
>>>   }
>>> +static void *hisi_sas_alloc_smp_req(int size)
>>> +{
>>> +    u8 *p;
>>> +
>>> +    /* The address must be 16-byte-aligned. */
>>
>> ARCH_DMA_MINALIGN is not always 16, right ?
>>
>>> +    size = ALIGN(size, ARCH_DMA_MINALIGN);
>>> +    p = kzalloc(size, GFP_KERNEL);

Please make it clear that kmalloc() will return a naturally-aligned 
memory for power-of-2 sizes, and so ensuring that size is roundup to 16B 
will give a data which is aligned to 16B

>>> +    if (p)
>>> +        p[0] = SMP_REQUEST;
>>> +
>>> +    return p;
>>> +}
>>> +
>>>   static void hisi_sas_phy_disconnected(struct hisi_sas_phy *phy)
>>>   {
>>>       struct asd_sas_phy *sas_phy = &phy->sas_phy;
>>> @@ -2130,6 +2143,7 @@ static struct sas_domain_function_template 
>>> hisi_sas_transport_ops = {
>>>       .lldd_write_gpio    = hisi_sas_write_gpio,
>>>       .lldd_tmf_aborted    = hisi_sas_tmf_aborted,
>>>       .lldd_abort_timeout    = hisi_sas_internal_abort_timeout,
>>> +    .lldd_alloc_smp_req    = hisi_sas_alloc_smp_req,
>>
>> Why this complexity ? Why not simply modify alloc_smp_req() to have 
>> the required
>> alignment ? This will avoid a costly indirect function call.
> 
> Yeah, I think it's simpler to modify alloc_smp_req() directly too. 
> Yihang, Can you please cook a new one?
> 
> Thansk,
> Jason


