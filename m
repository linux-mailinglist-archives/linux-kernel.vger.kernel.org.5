Return-Path: <linux-kernel+bounces-82223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D0C8680B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F081F27D25
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA6A130AF2;
	Mon, 26 Feb 2024 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F1evF/eM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KH/3LmSR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4D130AC2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974976; cv=fail; b=Om5fdMfI29vie95W+D7xW377Icunw4VEb5m292M6vskNeMbP4+zZyeCIpGUKFcnu8k8SSzKAaqOHLmRnc5teJzBl5kMXr7rtQz0Bm/a6SUhAkprvnIN8866Uc/q7On/3I8NZfATl9Rek9qHV8TQrwjDMWUQZgZROHGJTGn3iBYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974976; c=relaxed/simple;
	bh=LjxeBxMV0CvJH9bU1FrhmwUii02kFLLFGPbgldPbkow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IB9GilIbemWEYfTZdFar2dSuMetUBcoMqZxKQG9WzLi4IqYbFm+RKfDl5+Q9OllV2tWmF7/GweY35Q5EZ9O7uix9dCtLVwVaGUtoHnv/VjViJTSbVhhfv2WHmIttUztQVJ0/GrLXFLZl1mwV1q/IvmuFqxvHM2BVq5zdnnBsj4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F1evF/eM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KH/3LmSR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGmiMi027974;
	Mon, 26 Feb 2024 19:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Y5e/DitT5X9f0SbkeL7Uylprzgj/I5HwJP0sI1/k0Ls=;
 b=F1evF/eM2Z1+xSd+IXHOBY7dkWrTAHC6V3+dnrFsB3CbVS0bZ7L+vahM7E6da+cc7Wgb
 uEmqXH9TK4wYMz8IOE3VAuc73JaMr7+FjwyCx9lyhJiz/NQm0Y9yqh+CxMdzxAtjk9oZ
 hK2cTrbDmXcTcRmrE69RRbzOzLziBiBwJ0R/9/bgM4/0FGUbzo+uIQyQfzyHKHBaJgqW
 PVN6233xZQYSOH/F68Iup6wThjmafM617xx2fZuBstajW2YESUpQNwAKY/+YWiY63kPk
 R91YZiQGX1K3oHdiHIpnxhT7bM8c4vv2bRjS0FfGfK/HlKRSj5Uf9TM/bfV3L+B48TeH 2w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf6vdwehj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 19:16:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41QImrJH025593;
	Mon, 26 Feb 2024 19:16:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wchjun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 19:16:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8tc9Na7Xc0lub7bV1nffBSbStmfVVWAA0XRsFTGKBw3Fk5mdRkxDPkFpwSVqudX1VM4vdZaG59BsGU+qW5eWrxLpp7p2m6V0bvwm4rbDVhsAVjj0Pdv+hc02hiQRwkyaTgfJR1RdJnWgRFesMCcD3c+rlxdRJLd+dyUhRN5I2E0EwmDdkjFaED9IwvGQ3DDEMQgkrK9wVRJxUOrpngn1G0waMQmKXGcx9ohcVCYYjUjdH7znAe3EQzzJ9ZAKrK8ons0OSHoZJD/H4b1x4ByDeBHTJg9TprNolx7g/WX1el7fryRImEflCxxvReW0fXCeNJwiLp8H/OkRSQ+/rDfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5e/DitT5X9f0SbkeL7Uylprzgj/I5HwJP0sI1/k0Ls=;
 b=Z0LfWA6FodlIVmQ9KNCUmJL/unHiU5F52y4zFhSryNLdEQWxa22z7N2n14DLgV0c+NmYOIz3Z9zg1XAY3Ak/oJxxJc8K5cZEp6kSKyydLOoLy7yXbHsZkpE9T/R+6KUNz3E0DZeR7IpoghIq7w0qj//JTpcIEVgG9YB7zgial6pqK65QGr6t50jJSbxcsBuYdgKaQ9iPlY9LLw9xSA37psPZDrJyRGq2lKQMUIUHAH6yZjbBOirYCrYQFcI8U4+4TtYvsTH1DwVFDVH+RpW01tsPaJHPJyFoTXIl58DYQN0rgB84znY1xC/NMu8kwPUtBq7lh9679yEjTAdkFeDYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5e/DitT5X9f0SbkeL7Uylprzgj/I5HwJP0sI1/k0Ls=;
 b=KH/3LmSRD/YqGBgNFcc/ptMuqzqQdwoBaVelgXsJ8XEEKu86vUjX3yMXGJxyKXzQ6hgQXaUiJbJCqtB/0otppUHwoGTyXELmX2De2DWkZz3RpA2QfulvgSyu0D2vECZl4W6odh6Lr0R0cUk3GndPdyeBgayxZrV5IbNeplH1Cbc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6440.namprd10.prod.outlook.com (2603:10b6:303:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 19:16:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 19:16:02 +0000
Date: Mon, 26 Feb 2024 14:15:59 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [for-next][PATCH 2/5] tracing: Remove __assign_str_len()
Message-ID: <Zdzjb91cJKvgHUMm@manet.1015granger.net>
References: <20240226184932.303400070@goodmis.org>
 <20240226184950.974920801@goodmis.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226184950.974920801@goodmis.org>
X-ClientProxiedBy: CH2PR19CA0016.namprd19.prod.outlook.com
 (2603:10b6:610:4d::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a764fa-713e-4fbb-bbba-08dc36ff5f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qzo6lC/Kv75g/JsXmNlQ7P25RIel1Hgt4z4u1HGUDGPNmzUcF79KB3Xa/2bbvQkX9owbQpVXQDJLNqRwifelgAVi5uirhNlR9LWbAZM+H/RVIatwSY9WJf523BczTXE8TXkyuXXFG6M/eiBveAXsxkev9bIfD2FIQeE7nylptV/e4+jeQ8VoA6EtYC2DasuTOKT0zBmJeYOWWS30flUlFmhJJAXVyt1M+T9nHsD8271zeMo4d7vE3trzbdnpv0i/s/E1sBRvkQ+GfCy84BC0Xdw2L7yyAhXouROTigtPXv8N8x2P8EWFq8E62deZqfKH/oV98IQoT2FAb1ZlutIei3ADRnnefqEOqNuHmifYoFB8jR7vFB6AcBKYG6kOeIVD2iZtqXDyA0jNIeNpZWqE5jXUDSjeR3O4EEtVealir6oS1j09sl4/9sSFTmkhfEkAFZfhTx19G/KfLU2wQgtSqoOy2Yn8oFKYC31vjYZLUmEMNuBa68DvIc/8vtTjx0RrSIqm3Fg7TJhIWO46QKkWNs9kw46k7B0y1APdTEOtHUbAo9439zRJks8+Fx5mid9cPJZo+Dww5knIlC2exZb0GVC5euL3atX485PdkajljrSxS/n6Jny5L2lVJ6Eeeia/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rExiuTHuGuCwDXZCuzNwtpjXKy/SSZIBMiTwPL+BHzOiWkI72z0CvHjZRNZZ?=
 =?us-ascii?Q?G/ufcAtMW+BnKe433+7Vkbj0Pp/gfbge+x10FYdkJxqtvzygP3FX8IhVaPJM?=
 =?us-ascii?Q?G3aPMeQAIvsJZ4eUs6Uc8CtG0V5i8B9+1pf7fjyhs769Sy8jPzpTb7hr3KkP?=
 =?us-ascii?Q?zpVNtSyTnyDWLnP4DeLniHzVCamF3XLdi8aAKsYfsHi4AjUfgRWKWLBSPX9b?=
 =?us-ascii?Q?r1LMdjpDI6ZOwslZmqa/xt1X06xyw5B8FicSV9SUiZOs3hKfh3VXYpoZPg+z?=
 =?us-ascii?Q?Wgp+pL7Y90lLO1DBxwtWD482n+/A1WOxHLE3rMpl3aFBOCAK040NjePDibuP?=
 =?us-ascii?Q?N2Ko5hDeqQD+7qdhTeQgtQzJA3aw3FDlj+lXpauhjyfuFm4R5xHvaDvsREeq?=
 =?us-ascii?Q?C055ryvF0CsTv+7QnBIOUx++x0FShVqT26+UnrlE/1IUOWOKm/OHpNK6wbMw?=
 =?us-ascii?Q?qbwy3u3eTLR0fLs75A60LOrNSmdDOAUW/AE0EOEsB/xV4YXBnIhv2WxwwrfA?=
 =?us-ascii?Q?IomRB4tYOBGmuy4KlCenLFIuLqdM2KAWsG6oZ+B9O3+LOWhXgQeV3QX5m7Mi?=
 =?us-ascii?Q?ZoXG1qUSdzrDFGB/A7SQakhAgaO73EF7FuipbOb+jQs+pBvcuZj5qJTM9O30?=
 =?us-ascii?Q?9umIHMOYjeHJR+F5Lct1tU0CEEjqRjg51umXSrP5ZvMBu1bTTokXRjRxcVFY?=
 =?us-ascii?Q?0Tw0g6cm2wkaV72EUwFyKtU3qawB23Xw4V+AnnyZ3l5s9BuokKlfcNnMFeVn?=
 =?us-ascii?Q?fniPRHzWWISC/nxMTuaihPtsG1lBznMhfT6ifLOeTTeSy1nE2iwJzul7vViI?=
 =?us-ascii?Q?nytn+b6Ex8Fj/CnEmEWKlwyrlx3ymmzBjwnhQGg5LjR3sPH0TI86cMbH4iWk?=
 =?us-ascii?Q?8JuG+aAHvvTsiCSrEBaE/cgreZ9UC7R4cDTVxVmTMIBmgeGr2so33d3Ic2zY?=
 =?us-ascii?Q?S2ULbJPFsYRrkWYmk98OIQmXjQuaMshlgGBzSb1HUiRnyyomb+pL776XUBxz?=
 =?us-ascii?Q?Bq62VZgovsxEzUQEixDDVxRfp0ne2wP885LjCByCRz2dht31cLUZ54ropxZN?=
 =?us-ascii?Q?CIEfxfIJ/uamAIdBUFUZxvFd079yZ2JFVXF6R2BQNGemOa0U/DAu7HJj2beR?=
 =?us-ascii?Q?Ng/dImf/hd2Gt9Wa/jLd6c/hXQ5CGTHuPzZDLOZ4i1jd6P6EUCzT/mm6oizz?=
 =?us-ascii?Q?elUHYxXwOSlV7CU9Bu/96qEvSD0hBWJ01KUzb8wVgfaOIq9JwX7XFwJBvGBt?=
 =?us-ascii?Q?LJi5aYtQNKbQSFIJ/GcrgWBm/jiHMLxvtW/FGqfv04kxrD82zSp8HpkYSFhT?=
 =?us-ascii?Q?gsLmsipPxriQ99ySWrT+XXDU8dld97NfftH8TUtBXLW8s4SqMfRcN2DIXUnO?=
 =?us-ascii?Q?yjmxgqAUBrytlLGPWc5zqVur6kFpO0LQUNSQ4ogqlMvXJ1SDt64LAdAAP68M?=
 =?us-ascii?Q?qqGuMMCJS9U9/QiGUgMMNEgAjBLm0M7DM9R1UrvOxNMz4mvsS8MVXqkf+slW?=
 =?us-ascii?Q?6gwJm2Y5gpaPUfDdLcVF5/HJ6dnUmCHKmskZ9NxzlJDkxYQ9Wjc8DCgiUgue?=
 =?us-ascii?Q?50s57xggP308ZY26JP29QoGPn6NGMmOhEH7XiDKBDvZYvWItxhC79nFkmpXy?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PucHzyf9TjikbvaMG2LLURXVGHfBFCHQZLyJNjzMgiQGkD9VmpPNqIHSePCGY6Ss2e7WqWC44Bl3KVOVCDoCCHbL42q7eJJSVHfvkZO0XCt+Q6oRsTWsYZDDxb2/bLq5G9AyVtYOfhOSN2m32YxRpgSiiI0ppSwiP/nKcFhZAXQmP4hTwnG8Mu0X9dapImUUM7LMdX+j0vG2CvYrXWqF2xgDjZDAeIgRqNjBwlSgqy4RI1SPA2NVv6w56U6jJ7ccRSfOWFbfvCpyICet5fXVMRVK5yA5EAcWJLo32X4blXXwWCVfyO+ocqt5ZzrBQeGS41KqJtwN9bjILYuhBdQlwmWDySTMf2j526XNRa0BrN+kJo+CkVu9KinB5NXy5oXaq9TKQ5XmXXtR8T762MlvuQxaUM7yKBp8jPFtJQRjsNXIf8srM4ADodmmdTQQnTLy4D6bYOzwlV7dTwBHCFfYV+99Who/OvFuL0qRllPYu4jpcxi4uWKH8UTxSWjTkGPlho+ZFw9cDwvXNtLOO0wVVXUpUBJGsTdEaS+07boGL9dcc4X2fuiie7QPepG5hDm2rMj6fm9/W6iNMLq48pwt1HNCuB//gc7WSPupRBM+zhs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a764fa-713e-4fbb-bbba-08dc36ff5f80
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 19:16:02.7317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8+pIECzTIwjWJu0qLSkPVqfEstU8pD0NAFbh+sNOt3w/7Yf8D0ZNc+uzIbwJogGnCTbZqURPioR2ujTjiIFiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260147
X-Proofpoint-ORIG-GUID: ZvMYk6FJbNtakVLZPfc01y25mzE4S5IC
X-Proofpoint-GUID: ZvMYk6FJbNtakVLZPfc01y25mzE4S5IC

On Mon, Feb 26, 2024 at 01:49:34PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Now that __assign_str() gets the length from the __string() (and
> __string_len()) macros, there's no reason to have a separate
> __assign_str_len() macro as __assign_str() can get the length of the
> string needed.
> 
> Also remove __assign_rel_str() although it had no users anyway.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20240223152206.0b650659@gandalf.local.home
> 
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  fs/nfsd/trace.h                              |  8 +++---
>  include/trace/stages/stage6_event_callback.h | 28 ++++++++------------
>  samples/trace_events/trace-events-sample.h   |  9 ++++---
>  3 files changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 2cd57033791f..98b14f30d772 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -102,7 +102,7 @@ TRACE_EVENT(nfsd_compound,
>  	TP_fast_assign(
>  		__entry->xid = be32_to_cpu(rqst->rq_xid);
>  		__entry->opcnt = opcnt;
> -		__assign_str_len(tag, tag, taglen);
> +		__assign_str(tag, tag);
>  	),
>  	TP_printk("xid=0x%08x opcnt=%u tag=%s",
>  		__entry->xid, __entry->opcnt, __get_str(tag)
> @@ -483,7 +483,7 @@ TRACE_EVENT(nfsd_dirent,
>  	TP_fast_assign(
>  		__entry->fh_hash = fhp ? knfsd_fh_hash(&fhp->fh_handle) : 0;
>  		__entry->ino = ino;
> -		__assign_str_len(name, name, namlen)
> +		__assign_str(name, name);
>  	),
>  	TP_printk("fh_hash=0x%08x ino=%llu name=%s",
>  		__entry->fh_hash, __entry->ino, __get_str(name)
> @@ -853,7 +853,7 @@ DECLARE_EVENT_CLASS(nfsd_clid_class,
>  		__entry->flavor = clp->cl_cred.cr_flavor;
>  		memcpy(__entry->verifier, (void *)&clp->cl_verifier,
>  		       NFS4_VERIFIER_SIZE);
> -		__assign_str_len(name, clp->cl_name.data, clp->cl_name.len);
> +		__assign_str(name, clp->cl_name.data);
>  	),
>  	TP_printk("addr=%pISpc name='%s' verifier=0x%s flavor=%s client=%08x:%08x",
>  		__entry->addr, __get_str(name),
> @@ -1800,7 +1800,7 @@ TRACE_EVENT(nfsd_ctl_time,
>  	TP_fast_assign(
>  		__entry->netns_ino = net->ns.inum;
>  		__entry->time = time;
> -		__assign_str_len(name, name, namelen);
> +		__assign_str(name, name);
>  	),
>  	TP_printk("file=%s time=%d\n",
>  		__get_str(name), __entry->time
> diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
> index 2bfd49713b42..0c0f50bcdc56 100644
> --- a/include/trace/stages/stage6_event_callback.h
> +++ b/include/trace/stages/stage6_event_callback.h
> @@ -32,16 +32,13 @@
>  
>  #undef __assign_str
>  #define __assign_str(dst, src)						\
> -	memcpy(__get_str(dst), __data_offsets.dst##_ptr_ ? : EVENT_NULL_STR, \
> -	       __get_dynamic_array_len(dst))
> -
> -#undef __assign_str_len
> -#define __assign_str_len(dst, src, len)					\
>  	do {								\
> -		memcpy(__get_str(dst),					\
> -		       __data_offsets.dst##_ptr_ ? : EVENT_NULL_STR, len); \
> -		__get_str(dst)[len] = '\0';				\
> -	} while(0)
> +		char *__str__ = __get_str(dst);				\
> +		int __len__ = __get_dynamic_array_len(dst) - 1;		\
> +		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
> +		       EVENT_NULL_STR, __len__);			\
> +		__str__[__len__] = '\0';				\
> +	} while (0)
>  
>  #undef __assign_vstr
>  #define __assign_vstr(dst, fmt, va)					\
> @@ -94,15 +91,12 @@
>  
>  #undef __assign_rel_str
>  #define __assign_rel_str(dst, src)					\
> -	memcpy(__get_rel_str(dst), __data_offsets.dst##_ptr_ ? : EVENT_NULL_STR, \
> -	       __get_rel_dynamic_array_len(dst))
> -
> -#undef __assign_rel_str_len
> -#define __assign_rel_str_len(dst, src, len)				\
>  	do {								\
> -		memcpy(__get_rel_str(dst),				\
> -		       __data_offsets.dst##_ptr_ ? : EVENT_NULL_STR, len); \
> -		__get_rel_str(dst)[len] = '\0';				\
> +		char *__str__ = __get_rel_str(dst);			\
> +		int __len__ = __get_rel_dynamic_array_len(dst) - 1;	\
> +		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
> +		       EVENT_NULL_STR, __len__);			\
> +		__str__[__len__] = '\0';				\
>  	} while (0)
>  
>  #undef __rel_bitmask
> diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
> index 23f923ccd529..f2d2d56ce8e2 100644
> --- a/samples/trace_events/trace-events-sample.h
> +++ b/samples/trace_events/trace-events-sample.h
> @@ -163,8 +163,7 @@
>   *         __string().
>   *
>   *   __string_len: This is a helper to a __dynamic_array, but it understands
> - *	   that the array has characters in it, and with the combined
> - *         use of __assign_str_len(), it will allocate 'len' + 1 bytes
> + *	   that the array has characters in it, it will allocate 'len' + 1 bytes
>   *         in the ring buffer and add a '\0' to the string. This is
>   *         useful if the string being saved has no terminating '\0' byte.
>   *         It requires that the length of the string is known as it acts
> @@ -174,9 +173,11 @@
>   *
>   *         __string_len(foo, bar, len)
>   *
> - *         To assign this string, use the helper macro __assign_str_len().
> + *         To assign this string, use the helper macro __assign_str().
> + *         The length is saved via the __string_len() and is retrieved in
> + *         __assign_str().
>   *
> - *         __assign_str_len(foo, bar, len);
> + *         __assign_str(foo, bar);
>   *
>   *         Then len + 1 is allocated to the ring buffer, and a nul terminating
>   *         byte is added. This is similar to:
> -- 
> 2.43.0
> 
> 

-- 
Chuck Lever

