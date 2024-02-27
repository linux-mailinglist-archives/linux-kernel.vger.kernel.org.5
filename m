Return-Path: <linux-kernel+bounces-82536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEB68685FD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046A21F250F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC0763D0;
	Tue, 27 Feb 2024 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="efAvwsP7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O1jK4q/z"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A01C525D;
	Tue, 27 Feb 2024 01:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997731; cv=fail; b=MPYsyhSEAwd1wKY8c3dJC4TuN9PKbho3SS7tTDCsRs60bWS6QiIwfTBwEVgbzhMUeoq9h6hWXuw1eJTzQ0qMomR3fT//CZPsYSfvvblLUMP80PC2kyq9zY9QxrP2JRx+l4mSQFfGR9hq+f1PA5LiMMQpUnCSKRNSyLBZpOBrvdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997731; c=relaxed/simple;
	bh=wYomsfpJ5emE/RdojX+0irdUAwWIn5rykcvikO1V/so=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=VWIbinC5wjdBkkpMiv33ZO02nKwgP0ViPN04U9HhQT4sV9chkv0WdJ1epVj54zqwceXBpLixr0xFse9xGId0aQmcfP0wWgpviGASoarOJXmqA9eQhX+Wtb2BD92cwN4bCJVNPGJZstJJNmNAbhTogpFhit2OarToMj4SKq0Z/xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=efAvwsP7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O1jK4q/z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41R1Dwx7023968;
	Tue, 27 Feb 2024 01:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Pj5hnfO9SbYL+GjRsuy4Rn0xqp+QDeHccta4e+eq/zs=;
 b=efAvwsP7HZ6nQCl2ukKrPghIEsPDxsI//EdfwGC9EQWmknpVG0+RkwbxzBWLe0yqjqJc
 DyVKITXq0xQ6XrCr1Xu4p3d0K4ox7ZGlzRRF34B75AkhOKnn05ZDI/4f7WQjTsNoPj5d
 d4itrjqNWqEIUODRBmT9CqmlXzhwPD9BYiCtSlquLjTUHsHz1S7lKx+1Ihuf1r+toqSM
 Czn4xLmpDRrXzN8owAnPXNC5L5EbWvaauNQeA3yj2hH1cTL741Vko2ukX6mbsrEsUdMU
 O9EQQ3RawxNR+Ii8DJADIQa8QD+Weei3Xt7R1z6Nl1Zk7C/4qz24P/DW209egorsQuI7 Ig== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7ccdy81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 01:35:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41R0JGNA025545;
	Tue, 27 Feb 2024 01:35:11 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wcxwv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 01:35:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRlaglEeuiRugya0Ve9nScdCtBKyARi8ijNFzqTfGdTmIhn7AA9VYjAFaPM24ccHZSL5mA0U/uNqI7Kv4a2MXGw+ChITNF4zjU/Vzn2GIqXU6f1taSM8yeK9EOQQHX4zBTx/RqaGSUj513oSLLZI9pA7n48MG29rZTUcxlvLbHuhH89hN/fkYrb3X617J2dgAYYdJdxbAqsxnuMJiuqUEZxkNBu0Q7WFLKxIpTKwl+GkJcPbZuytMWMd8ObM/hw5Xx15OZdwYVpJBYcWBTlFX9pDjhtysmbIsRknoegPoAPYp6+2nt8tW1iNTu/QsEIE6txxD0oEeL3JQeofq86Vcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj5hnfO9SbYL+GjRsuy4Rn0xqp+QDeHccta4e+eq/zs=;
 b=Wqgt0BlivODPMQS/qOcmwDkIF1TD600+ZtQ48BVQ8irUUMeOHEblV7IpW2zM546TeLDgnPpFDOA6msx8lzTwg2hR9u3DtmxTcixT1wpnC3W36uvzTGAKZzi5JPUgff1w6EoTSSycFkMn359sCOHzepNwDVPa8tlNXMqHPpTyEGdzVOHtK/9O2k1JsT6qiW7plYWvvReOYyladaJW0+qrepmKY2ijhgbeQjYsdT+gXZRSdMFl98gA29BgdRKa3MtEPSVaGBMLOm4hijKVU84eSMo4EJO9ora+8qM2xwGekQGBYx0GjPdY1XMUOQvMy02J6u9eVgR3m6+8l2HOsnncRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj5hnfO9SbYL+GjRsuy4Rn0xqp+QDeHccta4e+eq/zs=;
 b=O1jK4q/zcq01+8dJgqy2CED8YkY0zlF0lJDX6lT1wyfUP8fWCzPfH6Wn+cb8gMEmTXZVjihfi9/UBDw/UkemjX7oIL20YWRo5pV5OVqRfpBWDQrkkqaog1Xn5guThFEKKzZpj+OgmGZ3EPCGLoAVlAO0+sf4pFE4AFkA0YDQ4HY=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by PH7PR10MB7088.namprd10.prod.outlook.com (2603:10b6:510:268::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 01:35:09 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::e542:e35:9ec8:7640]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::e542:e35:9ec8:7640%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 01:35:09 +0000
To: John Garry <john.g.garry@oracle.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann
 <arnd@kernel.org>,
        Sathya Prakash Veerichetty
 <sathya.prakash@broadcom.com>,
        Kashyap Desai
 <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Arnd Bergmann
 <arnd@arndb.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "James
 E.J. Bottomley" <jejb@linux.ibm.com>,
        Ranjan Kumar
 <ranjan.kumar@broadcom.com>,
        Tomas Henzl <thenzl@redhat.com>,
        Harshit
 Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] scsi: mpi3mr: reduce stack usage in
 mpi3mr_refresh_sas_ports()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sf1e667y.fsf@ca-mkp.ca.oracle.com>
References: <20240123130754.2011469-1-arnd@kernel.org>
	<96bb914c-79be-4867-b59d-62f80dbcdace@oracle.com>
	<yq1bk887zg8.fsf@ca-mkp.ca.oracle.com>
	<87d89b4b-463a-42de-a361-bc138d3543a6@oracle.com>
Date: Mon, 26 Feb 2024 20:35:07 -0500
In-Reply-To: <87d89b4b-463a-42de-a361-bc138d3543a6@oracle.com> (John Garry's
	message of "Fri, 23 Feb 2024 08:53:28 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:a03:54::42) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|PH7PR10MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: a5683304-ed72-46a9-a261-08dc3734556c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TXM5qDALXvoiC/RaH1iPW9p/dFJx/0n7/B5840vwuUHajU9RjP39AQqavudJHI93WeBbai5T9ixJhhMDr+qGggMl6CQZcO8w6DuCMh9QrIJiUNwdWMsPcgZB/XZjcgxVVBS0nH6Ho8KUfFSeX93EHHWJUCb0LP6++ij42QWzwGkXxkNNJ4u1OLrmzBMoTR1MyaWGYSf+lVqniH205s4SbQzaBa89EabnezowjOKuLbNeaTl4RjrhiZgzVqFj3bwzEkfOLYHubw6QznqDV2D9xFQYHQP6oTTNPfMWiQSoJG7BhfJPHvVdXN1neoYmSCtsYea13ta8r5Q2JAm7wDIJdcryQLpqLuY9jZ0NCb3oDuzorlO/dXhAFomCEWRorvJMUfAnAM+MS60tT057zc+sarMP+8YwWHxPPmSoIDALm/38szIbWDL6mGwlxX+NBjSddOBQPbsqL+seBDl6h5N5hH7iNjir7hKD3vfHUZ1Dox4fyOYcWb+xsAFi0KtrFVkm10QXl50rohKjhZ7syqoebSC9gw6AZvQg5SspYuOsE3MDLJPw5HwFfdF5OA6jN3YEf8hY8HAuA43xzijTBHB7uovVlscqY8Lxf2qQZmGLdP8XAdFN7iX8PHO3yphMrgZkWPOTXUkPRgIHDENYQ7bgWw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mCeARjfrnwHGp+kfdAaOXITFiDM+LChBEBh+HcK5NEGiGmfMVq/XgOusrD9L?=
 =?us-ascii?Q?DOIAL6HZBdu+k64Vn39A1PUKk5zBodU4JAKE0OUQ8ieGnWtJWsLt6jagWC4b?=
 =?us-ascii?Q?Z9S+Z62Bu5mCoCRBPfR2kiUF8Df3YqUzq3zHcIWwM6pgL7E8xUL5yFxgopp/?=
 =?us-ascii?Q?JUomjX16z50ukTUF1X5564bvLc/ctlY4UrimH7hYlKNuPt8Nbzu5weiX4bWB?=
 =?us-ascii?Q?Gm5KbvN0n11Qh8wmnnpavOP+hrpqqvVIhdU1miVCx4Xdx7cSm8wufgpjNdzI?=
 =?us-ascii?Q?l7/DHpMl88VNEGVrhoe1itdGZlNzgWgmdIIePzeAw813IFCH6srz6BaR2ZV5?=
 =?us-ascii?Q?2NjH7E8m4ezKgCzk1EVsFs1JJCtmbJqAGdGnFMUPKDup4rvh8EaiPHWwzfmJ?=
 =?us-ascii?Q?9oteiYh7q24Dswz6FOBjphU3VELDnSr0pOk51/RitHDKpawF8W6hDkcmplFB?=
 =?us-ascii?Q?+4tfuFz1n633kn+TvrXhsqE/PW/eMdV/nLyfStvfalhsFn1QXFfi2J9Yv0HY?=
 =?us-ascii?Q?mjM8w2DD3ZrUg/D1ZKb5a46vE20JUxJzfZL89xWWWXqQ8YRC4q/SE0+OORhP?=
 =?us-ascii?Q?bvX3YaAWjM+jCYPU2bDbCntFpFw/bNt+HD7dbUXqchSHfa4MyobvCdisQpvK?=
 =?us-ascii?Q?SMkueboNARzzHz2Z4HwYMRKeGgCu98vdMlQH8U3ks67foxP7cW23WWEzw7kP?=
 =?us-ascii?Q?5VmD8dXQYBNIxziqcNDl/hBkeSnS+aoh6TBkI6+u/vUV00zK15xeiUNlon+/?=
 =?us-ascii?Q?TG3H+TqJ/7t960kUpUHMMHEX9fTgnIGqEoH+hK1N4q0mTrFPC3ytp7zFu/at?=
 =?us-ascii?Q?l2LLocBtfTUH0/nRZaj8SmDs78Xc/2S8Xw9tszwGsawaNbAVum9cXqSyKVlB?=
 =?us-ascii?Q?OZTgSrj5FvKd+0yIflPchlYLNx6KocMGSNwcH7CbfM/2stoh/ouD1SAtTwtC?=
 =?us-ascii?Q?4i5uuMKfhgF3CK08vp/wBhMU8iiD2/Jk2Gv7wUs1gf0L5kSchYO5JBIYPnZs?=
 =?us-ascii?Q?IXtBo2EwxY6zQLdlYh32XhxESsF8S+TK+yknvaEvVMZ0LTEJkMsLYC4la1VY?=
 =?us-ascii?Q?fQW/5cY2egs1366Zv/MoHZfyX64bQlEmipq6vPGtlHCrINYr0gvCbM5j2ip+?=
 =?us-ascii?Q?6TOX0X247MZMa4oywUX880sHkJIe1s6/eWX6fH8x9WNKsvMjm70EVJo9duqD?=
 =?us-ascii?Q?byY1BERN4bVlaA6G6SZ+q2E65kHkFbx0yrfpcqsN9JjAFxYqZyqLMRT0Ze7b?=
 =?us-ascii?Q?ueOElUhCW12bdt04C4k/K6eZODvNRoL/cnU+F7UO/oH7Ol1qJyUuGpKyIiEF?=
 =?us-ascii?Q?yU5ecafn8DC1bObd6WGTxnHocDFRY4lYdLc5cH5a+TZQLaayhMSqA0kRQ+iM?=
 =?us-ascii?Q?aBKXgt7shujZ753KXCIdtnysOfA/tJDZA/IQ9io0MaZUPVrBIAqp8u52nsEz?=
 =?us-ascii?Q?03S1bYnQVBSUS3HVKxz8xqtvL6ICMc+2v/JX0jvnRbLpXwdsXD+Nkl1I3Q1r?=
 =?us-ascii?Q?5GIFGKSRwRixdhGuivTNojDHKK8EOu/NjkBqEPKlIHps0h9smx+++94MJYMS?=
 =?us-ascii?Q?y7STzM1dCWGXQ/PLYgr6elhMMzH3+Zz0SlWqPFVEFDpNsfn6v24gZyVYEObP?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yrveCtDQQ3lm9jSDW7yVoZ2u/U82qWi1b6TKVsKDn2JJxwnQKowvIlnizH4ta63zU1hSB2QDAoLpapsr/3KLZfhWD34g1qDWHeGQ7zt16bruP8HuM79R06ErI+A2PU7C6niJPJZskCZtKFK4fvw6cSXdBvso0v0GXEhr+LmVMpX89UlaYJFY7n4KdYX+vscw6jX+6IuZqIeAQ2+AFZwwIYpJpu4JIGQsr/oOUkOOSkWvEFi72iYGnVOIyqzxLruOc2122PfCFkSJi+ndaPSjhmpVOE9Du3i+fZ+Km/YNh1ktKQJ8lXq4uVufcTz2HE8e2YaiCr/l7R5dmc/ZqTdE5bBm0mAco5MpPjxsn1VGXh7L/X8POWuvNR4aWf3PgNssL8+k6vloXA/kJ85CsTqhbLeVuvJlM+IOx1/J/k02QndaY+SdS1k2mJ/hbPydRWIzcevILO2P6KMZqZjja9mwL8TWC9b2bGPxiVRqWEoYzHmN/Nf7h2vbYs/drS/tDLbGC/vQzZyZbZRhrA4uzysRVs8vuBXPSYEMr5m/Hf4jO7z8wdsXWBbwxwALB1Z6LjjW45hJb3dKQdZM+Hxx72qP+QZrPES3oASAs4FEr6MKocA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5683304-ed72-46a9-a261-08dc3734556c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 01:35:09.2801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giTL570JUGqLek7blamNuz0Ph5HLJ5fHotzqoYQU5zp/I6hs4lI7Pcln30+p72FDqiG7Io0Zx7XlGT8kg09OqenJZSzN23EiSdYQhk3i0wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270011
X-Proofpoint-ORIG-GUID: 40_8CyvAUGZCJB_rCpJ1bXgcgpdzB6t-
X-Proofpoint-GUID: 40_8CyvAUGZCJB_rCpJ1bXgcgpdzB6t-


John,

>> Broadcom requested changes and I haven't seen a v3.
>
> From checking the history, changes were requested for the v1, and Arnd
> addressed them in this v2. Since then, there has been no activity.

Interesting. For some reason I kept getting the previous version when I
queried this patch.

Applied to 6.8/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

