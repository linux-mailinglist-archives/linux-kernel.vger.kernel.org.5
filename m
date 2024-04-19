Return-Path: <linux-kernel+bounces-150904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123888AA68E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00FC31C20C42
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F013A2F46;
	Fri, 19 Apr 2024 01:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AOhE3YLF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ccu+RIca"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC76810E3;
	Fri, 19 Apr 2024 01:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713490549; cv=fail; b=NyjQo2Z7/6glsJSfnlF1pWbbGJEho7/DYEqwwtXa92asaSf9evh3JACWSpB7CuyfiLgXEQd3cRzrCqWKZzrOdAKjdKISq3kovhL0I96FqjsSD751SSMCuomi5uY/c9JmwagZOYb/RB5vVIf2pOa/LQ+F0FUxS7RVqGEHUABBWz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713490549; c=relaxed/simple;
	bh=WC98Q9wUiQlFJDxovStHrQvdAu/Mn6+Lvyfov/ECx1M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u7NY63MpBTbrd5cBCW5HDR1ufK20MI7UgwIFV0Z1yHH/8vaWNs4hG4FKtnjNYkjTMQiPeaLy7pd3BXhqERoBShURF+lPeILm1na2QXpRebWUrJlMEK3SR43ur4z/Jcf5PH8QYZDZd8ZcUey8qGmWNl7301BRZwWQTi/kNHsAAWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AOhE3YLF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ccu+RIca; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43J1KSTS032491;
	Fri, 19 Apr 2024 01:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=wFHiUGN0TtOhXb9YK2MHm9g6Sz+F177wJhqo+jQkYE4=;
 b=AOhE3YLFxXFHJh0HfmWfXxL9RAJOPaPuzKzbXnj9mfFm4EyBRPAZmBhDX9+6Re498e0C
 4difkvdxUEORVNDOEyhPNbUFzmrO3ARfge/YhfhmPRsY1mQEI8RK3zwhApHrshkUGq46
 E1lb9afScPPisorVGS8JEgbYTJW7I1m00Mr3IMM6vGSo4nngPUbpBKcr+7pt/vZWeQSI
 j3y2FhLMSYeeMj4LEk4V8YM3uplaQ5KItB8e+hGLUxuZdWmQLe8Vq+KCTbhGGw98a1Hz
 hdxCVmAZzSssOk0LMDkBaKJ1vakBhS3cp9CcAfLfyF3b7AXTluZKhMZgm62p8/HzHWPO 1w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhnukxth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 01:35:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43J1Ykmw005391;
	Fri, 19 Apr 2024 01:35:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xkc7wct36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 01:35:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ms6hyZKIpCGcCC0yI9UXMyAIIA4DOZ3+L8Z6UjKT1GpQpHQFS8VYnBlrJMtE+ITfdwyyd6Guy1dWRS9MoftDZGEgSrSU3vvQ99J/IN9yXTtMVv0R3PFAegz3pkIN7A1HsR+7bi9eg0GLbdZFTQwF65RZYYSNQUvkU6O/chlX52CwbZ9qKpOPvKP1NGcuSJYm117+lBs8GEfscykl7VP19DkXmml5okVXGfTwfhlqK/6r8Oh1uBNLrZJ1ceOLrnWT4GepwvZa/1Inq1iMmt6jwwFdETxD/6iofHDOFBuXj485JlY/tWmJW0m1S0IyGoi8jbz8Bj/OxOlIomIfrkPfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFHiUGN0TtOhXb9YK2MHm9g6Sz+F177wJhqo+jQkYE4=;
 b=HBTepSZEixbSKPd4o5Rxa2TwT1eAz2qaQaAFnDbk0qLk5NQ/VKNoZ5XeAo3+eVHnEH0tl+0pdNbXg3npYJGSP/ckL8mL0sp31O1VLTsDtgGWuodpywaz4tTvFyVRt/uhZ+UXStD0gBkkpL3ndmnSH/0tO/xZwYsBIPjBhKHXCkzkhOKv+Whwwy29uRjDxG2aGD2qN4Ev74HBqDzTZoqldzViJWnfkCj9bnbAl9/JhqstF9A6aA/5yKC2jeS2ZJcmgYaVxqRAAiQfGzfA5BMXxvSZTAO+Np4gnfiu1S7qhtJwApX8A5GjEhx4cKXYo21d2rgcyLJ+A3X2rtl1pbe3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFHiUGN0TtOhXb9YK2MHm9g6Sz+F177wJhqo+jQkYE4=;
 b=ccu+RIcaenNl9s1Ze/c8ZcSjHTUv1I7KMnGpo5cdF3APBVk4m3vFc+hAoSre/4BqUncHqpjB4treTX2gGiaOj05atolfN0aCiYSJkKFQ6ZoFaZ+E8Be2ak/d5s22395d3oKn0vFoCX7zznDKD51CUWOmjcEDqh9WjhFPeO7xJIY=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by IA1PR10MB7285.namprd10.prod.outlook.com (2603:10b6:208:3fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.55; Fri, 19 Apr
 2024 01:35:35 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::894:70b7:573e:da46]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::894:70b7:573e:da46%5]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 01:35:35 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux.dev, tglx@linutronix.de, joe.jin@oracle.com
Subject: [PATCH 0/1] genirq/cpuhotplug: fix CPU hotplug set affinity failure issue
Date: Thu, 18 Apr 2024 18:33:21 -0700
Message-Id: <20240419013322.58500-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::26) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|IA1PR10MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a547f9-0d46-4924-9f7e-08dc60110252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hM55MRrz/j45h+rRGY8CsGyXmrJSJfz54pa0VP2iW5LYv74wAyO0lapkWvJSyfTwiSXQcGDRUp4GJhGFo4kV/pd3VAp/iaBwJJfulsImYF7AP0k83OcgGpz4q2s3mUYG/LNPUpw+lEj8rxH8xb4ah7NrJRT9Xm3xkKVJRlt6zjAXoV0ig+zSiQ1ZjY/4uFUm9vGsHdniaYBpHQmsYqq7LpaOGDPP1MSzaIK423kPIHPTI7PjzIBG2VU8OaJSjV6Rd4ZYb87a1YvDdMos14or0Vo8jWUvAl62yPfdh73XIrpiuD/MgP2m25/A1qE99k1mSHvrOqBhMy3+JQxYxe8p/4wFaH2zVdxiBFWsCOmPPrsQwOM12pLvJFu2rbal1nDQ4X1YOTwO/7O8mrwiRsB2ymiAJxT73IwUriyeDqRXScaJPc7EXWztb+HV4KC4313Ims/pRo7KSefyK5yGISMB0cyYxXEyLBpqd6W83s/sgFk4EhIjbLUQK4cVfVBcgfBoIVcSjXeoxnQdJE+Vsf0rQhKwZp/ilP1IflGvCIf/DSZBF7zPoWxE08lHlQBzgR5r8IXBYsNrw78Kd14RMnMceadNDwmnFSKNBmcYc0IxaTwKiweOvwezDOuxW7fxUDTyPZL373ch7/jcGbrjYrvJXCpYUpAe5Vgq3IEH6TfzhA4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR10MB6425.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IFd6D/O7TYWaueedRHjuBYPuyYNFgsbopy4gVsDmFH/tTn9g0fsfJfKINmX+?=
 =?us-ascii?Q?hYtSydbCIJ0qBfEgG/wsRwIwoNhsTE5K8Fo7tQl33y/SjOxhFM5sC+W5rgWj?=
 =?us-ascii?Q?lO+L8TqA/4JqjUKlC0WCO6pxpKJCmwpptPO7gqAA9cPn5vgYlK+71NqaID4a?=
 =?us-ascii?Q?e6EYSUVllqdBINdP9YNOVppEQ4i162yJcvOQtU7xfhO31tq6E9Fw4gOwQOAf?=
 =?us-ascii?Q?3229hfZZ7L9GZIzO8ziP8IYpaAoAyPGBq2pTDsOG1Z/VLhOOIMFSeSxraYHL?=
 =?us-ascii?Q?+B2MhiKy87Z/O8nYEHji0kli8SuO9lGt25FvYkyu9UtS2xHkKN/S3kuv7y+y?=
 =?us-ascii?Q?AV9tiLYZ5mmDZzowICtfgnAu83dEtqgP28jh+2t4xaxIjfnk/9316O1sNwkk?=
 =?us-ascii?Q?hv8gqM49I5TfNtCOFk/zqsKvlHaCM+GZOP5oLBzHCJeOgKQvPgrIaIhMA5bV?=
 =?us-ascii?Q?+FtXI72aVRCEq9B9PB1xmnid1raQAX6jN4yx42e36onxI+SAaBzwRwVdS32e?=
 =?us-ascii?Q?ODVOEsvhVDMwGPKxC9V/r3mzw+LRqIpe4fb5ZOoDNOvbAB31p5T2b+Ja6C7g?=
 =?us-ascii?Q?0pSdwHQWPmM6/UuQf5+27VtS4KsReYBFH4rdtBT53fJdTa40FOlmC4tqm2Q/?=
 =?us-ascii?Q?zHQw6V/DqieWC2NybultsXtYI7HpZaAejhll9xdEf1nuqxe2FmLbVL09ffMS?=
 =?us-ascii?Q?XBuVougT9MOoPmxHk++pCsgi4ZInkpEayUpfV7m+6Tj6jpimeOBkURnMrVPZ?=
 =?us-ascii?Q?Sl+XSTkcPWm7l4WxP0kZgLO6ZWxmiJfsPtcNS4mNO47BD0zokU6WAvWWyGXd?=
 =?us-ascii?Q?bNeGFsq7Je+i1IAfvuJ38QF1S1FeB+Atdo6I/NVVG1WzT+KvvHoUpXBvf3Mt?=
 =?us-ascii?Q?Def2A6vQww7mSscAyBzOGtg/j82WA396dxhYPt5O5czMwW+uLw9rlNicUkig?=
 =?us-ascii?Q?UnmX07VF26i9MzOEMqF5iOLNYnnigB6keQnAQjUHlrQ3B3bOZmPrvqIsyAzl?=
 =?us-ascii?Q?OWicWDgiXo9vY06rAOObPhblWlzOuVja4FM9hBqw01E5wBTzL91RdY1GRYxu?=
 =?us-ascii?Q?g+BnCWfCh3ZsEwZ0MIh2SoW72DO/68ijwkoP8VRU75c4tWuP8BDo3PKf+O+F?=
 =?us-ascii?Q?W4CoWwLqE+tndpIrn9St4VQP7JMR6TI2BfxW2E6+kG/Gw2CUH1saBtRqxexZ?=
 =?us-ascii?Q?uPcErkxZg+LKCakTQrhah9uNvmeCnZ6KfA1ItmbQfBiOFf6N9SrGDJZSAydy?=
 =?us-ascii?Q?uNAud9gunYSMth+nApKDY5yjPdNydO50098SH6LrhLrrqNWUICB9D5hPUYIP?=
 =?us-ascii?Q?4dERcxN1/FD4yQovT+Y95zt+IVYTq8Hyeprf3MrzoXjTcQqVznw+jWG4sGNG?=
 =?us-ascii?Q?Juyd50EjVYOaPoH0nnGcJwBB/o2Iu34E4xhH5YN6aDsnsh0eJwxn5hhbMoKJ?=
 =?us-ascii?Q?HNHuQZADQzdIJT0v5SLN8xAxjTzn+UXfbaij6mAIGUa1rgvRJelhZXhPNoCy?=
 =?us-ascii?Q?RCV+uGgdVtgfm5z8YrfvOEsHlUNxaNh3NrGoeMu3awJXrV8YOTlwkltAlZiA?=
 =?us-ascii?Q?zecIC6tRR9byieAZrBb0WPXLViJFSiraPyJB53s9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GCK5R1qMkQACPfbQhrTWZP2iiw9EH0DK731eMfXo+QpEOY0BjK5JPaTref6w5Sn0eB1IoU0pUjIGpj+q1pqj/qgx7+q5i2SocsWvI9+JNBCYKN5PVmhl0Xf2vDOqZhsItPdT0GfehIR4/MLXBdIdDRn2aiUBFj09MePs7OD5pugXzglRxCu127l+pBYvibF7kdPijW9knD/kk2C/O8fvWNzihniCDWDi340z15v/YZ4kNHotThjbPVmEpOkJVCIZq6T2SAiKxdT8K2FK32DPIjUDcwojZdjrImNZQdOHzLNbfEDiRbBZvxe+6s4N7mR/GFNDEbeQfoHZq1Ppaaiiqr3RE3696Z71+mb5O6kbTUJXRr5YfoPYaHOINe48RZGGwuC74tV6M8XOcLbPSCrCxz3ba7p73wu/F2t69urMG5mbqi1iMtE6WoYuMDcHUed8Y7TMnyUqOMfQVC1WUcMblAogjv4LQYWGcBhJGBDdVV3XyjFhnZCwEwu0NKLaVjyVYotmheGJ+Z7BgWMRPhRrY7OTHoWXIpTGi8RP2hWvMzcyf9OYYvDdt242Ib0zvWsiW8X8PV4UM5GIv5UiOrRB7wGT8gsCjdhuOPs2ObwmC/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a547f9-0d46-4924-9f7e-08dc60110252
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 01:35:35.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4xoOcUxAHZOwAxre8l0U7/6ZSZR2mNM2gtSHjG4C7tSg2twiPOL8Hn2a8XRp4VrUahQWAgGqg0VYcAWNvxXSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_22,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404190010
X-Proofpoint-GUID: ewgtRSDdXuVHHqvUXcfyktr1w_4o22oK
X-Proofpoint-ORIG-GUID: ewgtRSDdXuVHHqvUXcfyktr1w_4o22oK

Please refer to the commit message of the patch for details.

The cover letter is to demonstrate how to reproduce the issue on purpose with
QEMU/KVM + virtio-net (that's why virtualization@lists.linux.dev is CCed).

Thank you very much!

------------------------

1. Build the mainline linux kernel.

$ make defconfig
$ scripts/config --file ".config" -e CONFIG_X86_X2APIC \
                                  -e CONFIG_GENERIC_IRQ_DEBUGFS
$ make olddefconfig
$ make -j24 > /dev/null

Confirm the config is enabled.

$ cat .config | grep CONFIG_GENERIC_IRQ_DEBUGFS
CONFIG_GENERIC_IRQ_DEBUGFS=y


2. Create the VM with the below QEMU command line. The libvirt virbr0 is used
as bridge for virtio-net.

-------------------
$ cat qemu-ifup
#!/bin/sh
# Script to bring a network (tap) device for qemu up.

br="virbr0"
ifconfig $1 up
brctl addif $br "$1"
exit
-------------------

/home/zhang/kvm/qemu-8.2.0/build/qemu-system-x86_64 \
-hda ubuntu2204.qcow2 -m 8G -smp 32 -vnc :5 -enable-kvm -cpu host \
-net nic -net user,hostfwd=tcp::5025-:22 \
-device virtio-net-pci,netdev=tapnet01,id=net01,mac=01:54:00:12:34:56,bus=pci.0,addr=0x4,mq=true,vectors=257 \
-netdev tap,id=tapnet01,ifname=tap01,script=qemu-ifup,downscript=no,queues=128,vhost=off \
-device virtio-net-pci,netdev=tapnet02,id=net02,mac=02:54:00:12:34:56,bus=pci.0,addr=0x5,mq=true,vectors=257 \
-netdev tap,id=tapnet02,ifname=tap02,script=qemu-ifup,downscript=no,queues=128,vhost=off \
-kernel /home/zhang/img/debug/mainline-linux/arch/x86_64/boot/bzImage \
-append "root=/dev/sda3 init=/sbin/init text loglevel=7 console=ttyS0" \
-serial stdio -name debug-threads=on


3. Use procfs to confirm the virtio IRQ numbers.

$ cat /proc/interrupts | grep virtio
 24: ... ... PCI-MSIX-0000:00:04.0   0-edge      virtio0-config
 25: ... ... PCI-MSIX-0000:00:04.0   1-edge      virtio0-input.0
.. ...
537: ... ... PCI-MSIX-0000:00:05.0 256-edge      virtio1-output.127

Reset the affinity of IRQs 25-537 to CPUs=2,3.

-------------------
#!/bin/sh

for irq in {25..537}
do
  echo $irq
  echo 2,3 > /proc/irq/$irq/smp_affinity_list
  cat /proc/irq/$irq/smp_affinity_list
  cat /proc/irq/$irq/effective_affinity_list
  echo ""
done
-------------------

Now offline CPU=8-31.

-------------------
#!/bin/sh

for cpu in {8..31}
do
  echo $cpu
  echo 0 > /sys/devices/system/cpu/cpu$cpu/online
done
-------------------


The below is the current VECTOR debugfs.

# cat /sys/kernel/debug/irq/domains/VECTOR
name:   VECTOR
 size:   0
 mapped: 529
 flags:  0x00000103
Online bitmaps:        8
Global available:   1090
Global reserved:       6
Total allocated:     536
System: 36: 0-19,21,50,128,236,243-244,246-255
 | CPU | avl | man | mac | act | vectors
     0   169     0     0   33  32-49,51-65
     1   171     0     0   31  32-49,51-63
     2    26     0     0  176  32-49,52-127,129-210
     3    27     0     0  175  32-49,51-127,129-171,173-209
     4   175     0     0   27  32-49,51-59
     5   175     0     0   27  32-49,51-59
     6   172     0     0   30  32-49,51-62
     7   175     0     0   27  32-49,51-59


4. Now offline CPU=3.

# echo 0 > /sys/devices/system/cpu/cpu3/online

There are below from dmesg.

[   96.234045] IRQ151: set affinity failed(-28).
[   96.234064] IRQ156: set affinity failed(-28).
[   96.234078] IRQ158: set affinity failed(-28).
[   96.234091] IRQ159: set affinity failed(-28).
[   96.234105] IRQ161: set affinity failed(-28).
[   96.234118] IRQ162: set affinity failed(-28).
[   96.234132] IRQ163: set affinity failed(-28).
[   96.234145] IRQ164: set affinity failed(-28).
[   96.234159] IRQ165: set affinity failed(-28).
[   96.234172] IRQ166: set affinity failed(-28).
[   96.235013] IRQ fixup: irq 339 move in progress, old vector 48
[   96.237129] smpboot: CPU 3 is now offline


Although other CPUs have many available vectors, only CPU=2 is used.

# cat /sys/kernel/debug/irq/domains/VECTOR
name:   VECTOR
 size:   0
 mapped: 529
 flags:  0x00000103
Online bitmaps:        7
Global available:   1022
Global reserved:       6
Total allocated:     533
System: 36: 0-19,21,50,128,236,243-244,246-255
 | CPU | avl | man | mac | act | vectors
     0   168     0     0   34  32-49,51-53,55-57,59-68
     1   165     0     0   37  32-49,51-57,59-60,64-73
     2     0     0     0  202  32-49,51-127,129-235
     4   173     0     0   29  32-40,42-48,52-63,65
     5   171     0     0   31  32-49,51-54,56,58-62,64-66
     6   172     0     0   30  32-49,51-52,54-57,59-63,65
     7   173     0     0   29  32-49,51-52,54-58,60-62,64


Dongli Zhang



