Return-Path: <linux-kernel+bounces-152298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD308ABC0A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 16:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C60228184F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 14:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F31D27737;
	Sat, 20 Apr 2024 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hyezQA9b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZiKroDIG"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8071E4B2;
	Sat, 20 Apr 2024 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713624334; cv=fail; b=uccjhgG81xx57QkYJNFQ1mOtHZwupJpLGW/O3E5tWAzh8XGvLIRdzacrbleOAHC0NjzeHdLTsGdMpCLt3xAqZIU3f2c3wBZVyaPCu0nH6KZNEMM0o/hjGxu4R9GOwhRhQfB3Vfs/nVruWYHO5pBHsaUuh8zKDair3ZDUAdQvT+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713624334; c=relaxed/simple;
	bh=08PGmteJR3j95qFgmQvx4ersiPm2PPrkdm6a/o0vsTc=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=pUgj0QKiYbf6iEU2q2OCWFrBnoRMfdFb/tEBQgLk4sh2/aDxt/6naGrhV4sx5gSUEc3l+prdUurjFTqgMGY24CCTNClM0aO9GVyjXSY+pJ698f73P9Q334YCIdXXAWuIARZIkl+hyHskF+sNaJyDUkG4XEiOCGpXIvbifiJ5AF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hyezQA9b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZiKroDIG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43KAL66S014902;
	Sat, 20 Apr 2024 14:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=9ade4GLnvvQVY3rKoklb4Gr5MUfNkWisMHGBsT6xgeU=;
 b=hyezQA9bamiUeGDS8VaWeDo/O1GxUJ/BsEv2KxKo7ACEFFzCUw6dyVMKmy4PyyStVLJT
 6LSW3cyx/31hcVbxvRiQMb6OQ8nMtxHXDRdaUQfJdCcioDPtr77My2wAuiUM4yNn8ycf
 9x6P8NOwJezrPbMcbDosiZoPzW99SMb8nljkDo+JPQURUdDfdtRs/jtfiYCU3eHkCe0L
 tpy8ONSCmPkZvTZYolaIYwAFTO4mTr+Y8HS6cu7FZj4F5Po7bIA87aq1Dvg8jLUTOEDj
 lQzg8KacX+Qua4fBw5yPrHgJhscyIYKZcJxVI6fb/CKP5RdYgeF8ophkXabHrlNz2iCx Ug== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbgcs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Apr 2024 14:45:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43KBCjie009921;
	Sat, 20 Apr 2024 14:45:00 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45a5psx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Apr 2024 14:45:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIqZ9a8TibSecSeU56O4Avf78zbAsE7fnn5qmfO1EAN3y8XjFx50mwaOB+7UBVFctK/HdKTKa6t/4+tfWpcipIXhSqKAV2Ue/So1ozt7vMddaYOFHPrPKbCpxzhSaKjQJ0gH73eJP2wOG1QZo58uMMxZBIUa0eEpS1Aag+c+0TJKAt7smchbqkXD7dJM73adPJ7cl8u3FF5mqXU2r7+HJGJFIFhyzGLyduKMdCe/J4eObVmnVe5PfBY4BX9ooGCfSQU5AXYZPIqrOcPMZC1UAHfLGv45ujYLGzfe264WhO96XYCz9g88fYEFdDguIlc5HAnu5m1OZTxuHmzw0vWC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ade4GLnvvQVY3rKoklb4Gr5MUfNkWisMHGBsT6xgeU=;
 b=QUP4tQ6aajAJ+hVrOdtmfxKrnmCf6RsQ3ZlHv9JR38iRjRfUTXjK/mVgG5p1ZRxsLolWWdSGeaux14wwEXqPSAjcM5p6rKSrybI7ylyGtHFAi8p5JKBuJw/XcEy5ev6pEL8mYuQglZDgq3cgO26pr7PLfuWCWXKFT3VBSEU5gJgL22Cl/RbhJ2DfOoXiiTVp946njSvlrq5CSPopq//+5GsQE3MDFjIfoTz+/1o8uFV2xsZrudyKCXI0RxC5eWkYzEVzqH8EBWOtWsBNJu35gT+c9jrZ7qUdrNaChi4ShZ93rZ3DjrTQ/Fk2KgIE4QeNEhLluVksTBrr8f5wpdLEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ade4GLnvvQVY3rKoklb4Gr5MUfNkWisMHGBsT6xgeU=;
 b=ZiKroDIGnG8DpL3tm79mHP98QmVZTuHw3HYj3s3pbDW9OVzDF5NBmReoHgNFM/88DJmj5MbNg/V1i9NsVd0/nMvr5tIzniZSscyhP7wFwrthbmmrryW6d6Tk4KOmpuZZk4QgrYQj2yjHNBgeRNeGWhZUD7IXwXKM1m8T6sTB+mQ=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by SA1PR10MB6567.namprd10.prod.outlook.com (2603:10b6:806:2bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Sat, 20 Apr
 2024 14:44:57 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::ccbd:84e7:983b:de7]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::ccbd:84e7:983b:de7%4]) with mapi id 15.20.7409.042; Sat, 20 Apr 2024
 14:44:57 +0000
To: Xingui Yang <yangxingui@huawei.com>
Cc: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
Subject: Re: [PATCH v6 0/4] scsi: libsas: Fix the failure of adding phy with
 zero-address to port
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240312141103.31358-1-yangxingui@huawei.com> (Xingui Yang's
	message of "Tue, 12 Mar 2024 14:10:59 +0000")
Organization: Oracle Corporation
Message-ID: <yq1v84cayam.fsf@ca-mkp.ca.oracle.com>
References: <20240312141103.31358-1-yangxingui@huawei.com>
Date: Sat, 20 Apr 2024 10:44:55 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::33) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|SA1PR10MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: aba8acd2-9b30-4e52-5db5-08dc61487306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gLGhmb14fa/datAVsvAhr/fMX/Jm1xyurNjEvLX+cMeju+LaX5q2/lW1htLY?=
 =?us-ascii?Q?M6JFZY6crclz7l/VozabgzH6ojLolo3MQemL1lZr4cmb+k6USvccRkIMUtUC?=
 =?us-ascii?Q?JdK88rEub4oIx0WfXNujC28DZM7QGzuUDdFMfXwwIyUm61q293IonfGkUV1O?=
 =?us-ascii?Q?nRxJNgMur8Dt04J97qULaDdnOZT3lanAPSvhL/OM8H+KJvoCQ6r0i0O3nArv?=
 =?us-ascii?Q?9VKggfvFlVaIsunNltkZd62bxEWIgF6p5cuDQnA8tYz6t9/AnywKlBo1MhU3?=
 =?us-ascii?Q?1r2Qdhh2/gfJGIoUqymolkhcMpMp75uhs06ZH9e40xjEa0rKkuAYqccbwS75?=
 =?us-ascii?Q?wV2DQ/VD5cV0o1p7aox2eAJi+BmMJ/+irqHAHFOTiMtJSk5obORf2SRWk/q9?=
 =?us-ascii?Q?jbGk7fXE8qbY+kdr8NIPFfjKN2RUTWGR4IGnlmRnQ9CUkToBlIiTZx2Kf4ja?=
 =?us-ascii?Q?RvQ/B5ygBB/b8G4IJz2hmCUJmC3lGZiLt9LJ7nvd/h7FWvuHuY/60qncKeIw?=
 =?us-ascii?Q?Ks25hbLLSkBkGK0pLMOzCQz/yw3L6BWtKM41Sy8axH6Hd3+rRiDsn5f+v8xO?=
 =?us-ascii?Q?yseuMgHp1NKmAkbV+6ACYI2PJGySbebHt0KkcKQ3iOt/kx8KTGc/V4LIoQjw?=
 =?us-ascii?Q?r9mXI56oN9qpFZsfC2QA1O1PoqEi7YYnLRWW6Q8sQNF3Jtz3fQ8wTskesOMK?=
 =?us-ascii?Q?Vt0yvtDjwbrIZElWJ94NcD3skrEgUlb58MfXQN3szWl1Oh3lUTV/OcOdeUnC?=
 =?us-ascii?Q?mnWTTK0a+bxDMuQo19cWdCPX8E9Y9aOOyk2LvGCPVG5XZ4hnSAWIrhAXG70N?=
 =?us-ascii?Q?i0N1ni3m9iCtbRFi4V3W4VKTxwLKdIHEoq31QhFlIumBABhUdBdwocvn5WFq?=
 =?us-ascii?Q?fJEvS1K+HxDzz2EFCwvPK/7FTweoIb7emNMYWqsNN2GgkKGgMzWaiw5N7YHr?=
 =?us-ascii?Q?HeINZct6jf0jS+mqmeHze3gLvaShTfu9CC3I+aU1QHmjBAsA8UgcfcAlRIuw?=
 =?us-ascii?Q?cikarpP0n9ko+yf0MA2nJI5FYpy8z/y3WRM0erNfCBfAQNF6U989kw7lOATh?=
 =?us-ascii?Q?5h3JMEcfX+VVKDRDKlzenZUaY8FyxeUXyZcXiuFK+05AioLSGL67PAiM/SQF?=
 =?us-ascii?Q?WhBMcNBtVXKrXDbTTWNPvdemyln5vbCEw1fz5MbJpTV3TufSbVo9VL9Dtb7N?=
 =?us-ascii?Q?cFDl5twahh1jlUtgR+bMaRfqfWKe1ruN4lbZcV9pPHdrX1OwnPQMeu7awRB8?=
 =?us-ascii?Q?zG9jTBx6XPj3MMXJ6vQiDAfmxRkvQ/HFTmeWl695Uw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MQ4AR/eSYBGLQ5K+86al6urSK7hqz+2+csgfeuUSRB9stslLTJ9oSUuSsa3B?=
 =?us-ascii?Q?CAYasbbcPN/iWte/pu0ujhSXAYzBlSTZZI/QhUP+jv9Pxj8QDKWiIQFHtGAR?=
 =?us-ascii?Q?thUPMIvvjZA6iMZYbaH7DE0jVe5x87RWiZC4Fw3NKrkQxvS3mgQhFkRi8MG5?=
 =?us-ascii?Q?Zmez8mtoKebcNjnNxVlMvpQ8shqo+tF0dMuywNmfBEFmqqVkqKqdHy+vM4he?=
 =?us-ascii?Q?vrgXn0Cce/iXHsOIMltTpIAr8aWFeLiTFw6OvI6sSSDDdeJIcRlPFNvvQuim?=
 =?us-ascii?Q?o+IPhGS98Q7b58mJy9EQj7QfwVwIZN0FrW6Xd9MLmi5ZqDLCT7c/LmyJR9KZ?=
 =?us-ascii?Q?2XibOAHSn8w1A53x80Ys4atUtjFSbENve1zs4vaDTa9zBit2dlfsynvB32vJ?=
 =?us-ascii?Q?hqkdJheJeIomrIQcb4SdcAJw91ltESXs84/flg32QZ4dt2mpzDv55qRa37M6?=
 =?us-ascii?Q?xS7MgA73PwwIEXzakm+PO00Ln+Sgmd9gZ7YBguhoz2UPEmmv6HHNjet1+mPO?=
 =?us-ascii?Q?+fGW4Z+07n7QJdbZ1u8cuw6wlp7nT7ZeEeUwBhBq9MHIp1DGOstBm8iVp/pb?=
 =?us-ascii?Q?hppcSsAVr03D66SQFmI8kLq7hZ7+InpgmVtBJW/SzTw2wSzC2OiZblsLpG0Y?=
 =?us-ascii?Q?HNtpYRnfPGsA32FAb6uKxXUy5fn4jHUkfv6yVEQLK5k178svrfxRftzUvQvP?=
 =?us-ascii?Q?lJd+7kMLhjnQ/lVboRnR0JTgKwTRy1lp/hsyOFWb3FQMPTF8kzdc87T7Edyg?=
 =?us-ascii?Q?PGqIMggDSogqCwoWDcceXvbOi0WJG660xl05R+KTZdLeYHXuQ/TDUi66C56L?=
 =?us-ascii?Q?L73bOd6oI+sbQv1GKhBivn89dcKgMp7W8F3NUHTKSvOLM7TqkwikycizcoQr?=
 =?us-ascii?Q?REmfwtH9sSAzcrwyehCvwFKcbcc32cldX8Vna1WAuEn3bOlcJ+CkQKdakq+H?=
 =?us-ascii?Q?lgtri5Opb6Bn+Gr66DahJeFe4jrL/pfh8GmGdJHMZEaAfowPmfhIvimwlY3S?=
 =?us-ascii?Q?GwpEYKqUnjE2KDYB2eojpiKSqqdvA8290rXGM86zKjpxtnXGdKOzVAyl45s7?=
 =?us-ascii?Q?g3RNeMjNN7ek6Qfs/NEg2aU7gFd4CJDO7OMe1uvifLDnRJ9a6TROGcM/Ysdx?=
 =?us-ascii?Q?SgOrhpabHEfPvW0eoLZOUIliyTFzUQKnw6Y9KQ5gShOXhzpbpjMVrLw94mNt?=
 =?us-ascii?Q?927oAYF8//nv+PuqmHa3/9RDvBbABC6k8CUDy7NuMgK5l/mwzmb7FSTziv9x?=
 =?us-ascii?Q?rAZSxqU+DHQGX4KzPtmTGm8CwRAOhXr3KW9NerJO53nVzecRnAw7/YYZImP8?=
 =?us-ascii?Q?QD/5bfpGQZmdBWpCzaVjLiEpLGdtm5XaWOiKz7bYZ/0Vm/NC1jqT2qw02yc0?=
 =?us-ascii?Q?1Fr2B4fE002MpoGNOOGjn0SCBL0kohbCN9ESXTQQK/WKOrr0OMS8/KX0+wh7?=
 =?us-ascii?Q?K5a/q5JDFha9GKFXWmDjsXIpofvxdMzOmWnD047tIf9vSRoXJ9clTe47JZqd?=
 =?us-ascii?Q?Y7Dd9O/cvWLIx2fkqiOxP84JF/I4upIHdKXt8/auV7EHwYHfOsuub6fYHqQA?=
 =?us-ascii?Q?Ql9zAfaDlIDFj66IhEoyHciSPqBZw6dxSpCfbRBjZoR1NmOKzFuqQLX0eNuw?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HlOKelw/3/KV83IVYlUhSnEWBoa+iXeiXcp9soEBX9qK1dPcgzmlDkAtGFg97+xmvQDX3GjHkODSOmrgPHP6omU/BzES9PG9uDyUj8YjGuYCPO1Wld/wevGys/oRp749HM0VdIH8tQ9no7JuY0VTILckddQP3QWlZkgR6E2E90jJv4QIrj30LEGVRrPZHAgnI6IFS8T9OVIwqhyjo5P1y7FTF07eRoBuAuQgK+emYXlpL1lCYsNcQB1CuDfodWPfx8zUsO6uGktu/0M+RuOjSdBVtI1YAjhEyctrtFCH+DDE9ku+fKyRa5pinbzWzDwOL47hLit0L921RjFlxOkP1qmJ1RKOmqCxa6HrvALZoD2eADmVbKYlUAcRC+ah1V2d3lPuvKBe00v6nFMungqZBcZwXXF+nBZ5tX25aG29nt4Huxf3EZ9LP1UcdcAfRqpGWbj3c2yOWOPqw45o8+RwBOCIWObTJbEaFxfW/M9EZOWQ3f7n+AZL+qjym3dkiGdqJLEggWuDGQgTebC/vjCQXM5ndaI9i0aIP23NjY1dYLLcoMQsTUHX9bVu9dPNRlhqD8zC/a5TSES/iyOc4/jgDT3q+NjLBtVBZY2CRFkaPIE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba8acd2-9b30-4e52-5db5-08dc61487306
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2024 14:44:57.6453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgDHhN24cqP9+qKhOLBQAm1fFZIkkJtkccek7e13FXGYN5JhGCAMVlg/wnTFBwDzbMwGF7Cfs4VFtaR2SWFptwnrGUOW2DMMTViyzLw55zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-20_12,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=750
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404200108
X-Proofpoint-GUID: so99B_RsWawwNHEKEbjq9hS83xMQs5JP
X-Proofpoint-ORIG-GUID: so99B_RsWawwNHEKEbjq9hS83xMQs5JP


Xingui,

> This series is to solve the problem of a BUG() when adding phy with zero
> address to a new port.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

