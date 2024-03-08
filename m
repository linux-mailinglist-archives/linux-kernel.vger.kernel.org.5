Return-Path: <linux-kernel+bounces-96953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6BF876389
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8079D1C208A0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938C15644D;
	Fri,  8 Mar 2024 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GgrqQ3rS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="heYeJdXQ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB359143;
	Fri,  8 Mar 2024 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898270; cv=fail; b=KWe5obifF2DnXCtYh3tvb/BOxjAEFLT6/ykWev00YfXoA8wmjtFTKLvyo3ubtPOAJRKos0Rqk5oZne0+ydgpF2KPQkMU1UPJC+GNVtJ5wBsRcmSk+zO8LdpiwhjyAg+t7XawHfkLuOmx6MdYwU6RofZoA+6qur/jjOOGYkM3/8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898270; c=relaxed/simple;
	bh=+sazlHOLtGKbJzQP5C5HE9PLusavwIMdnD3iyL4KTt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LwwbhNJQ8hf7fzHEF3mM22YMg07xnN3q1iL2TLne/ePaRDUJONKtZDn9+gT4QS/R/S/i9ZdW1o8+LEKF9TKXcYqJ7o0n2w77iYfL7d2/ZhQXD2q4BHQNUqbwA/tRO/+3S613JMLIERE2dsF9RpMJtlrB7X4Tasj5FVH2x0deTMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GgrqQ3rS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=heYeJdXQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428Ai03P003994;
	Fri, 8 Mar 2024 11:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=PVOe8xs+S4P/BpYQtnuECRoZa8x7JWtyFlxxcMqo5K0=;
 b=GgrqQ3rSD5HBufdJ6fraw9tiIS01geP9J7VVWvUdV/gl6dvSCjFwrYwMgXkECBQk0kUu
 /heo8l8OA8kQrDDwdYg++Yz7Vbl5UBMPbaYKLGlJ9O8wEN/giwlCjCM189zq+gyhGdbz
 9DhNzRNj3n5binLrR6gUxLp6AtHCSuIE4Csgdm+n/KhELlDOnyHcp1OidsxiljkaI+8x
 y2073XC6W227tp/+8JbO8zEuSur4DGGnJwcrmA/9kjVv+F72KeUhNSHahVNLP3SQNZns
 WJYaFhIF5iFUCKrVIvUqvPmVDlvU0/fxafG2kli9asE3sZVs44UU78ao0uyxlukJuGvD mA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkthepkq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 11:44:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428BQQop032047;
	Fri, 8 Mar 2024 11:43:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjcn4th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 11:43:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJQjf6tnjKjGKOeP7mWtDgpqyGbRcXUAdHfQStgqTo4jfnBmhgp9QRA8veVIWJzvfdgNZeX2kfO07NZAxfDqBvmh8XtpbiAk1LSzbAgVKrzCKv6uRYji9xzT0eQGxt7ARSS1oGTxZcySlw5z6/I3NMlsaRXiDY7wibWq2Gf5IrqwGYG6ophDSKFPtobGmZnT7OfR4dgu5HZJletpo/vFVJTE1HyxrXoTY3WRes5KqXIS6DCzcajlxk92SEBJer6VapgEJvU1TpC+ieILuK/7svqi2WHM2yDQeL8/3F6v7snZ69jf5Q7oRDsk/t30EmKKggh0y4IPbP4qcVcXzGeMgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVOe8xs+S4P/BpYQtnuECRoZa8x7JWtyFlxxcMqo5K0=;
 b=UAdGW3+2TTVrbkToqwjuapMBhl46dW/x4yKJnThBaXNcjwIsKhd6QepTtuRa8YMuYEjCHJEcSpso3JaNlvrNOWsRDU/dmtXrVZiUiN9k+Lqh2emF9ilsC1VUhyuWDcDfyAyGnrWcqZjjRKJ0UaeCzI5Hf5qTJoUyRx7gkQKUBXPDu7FOru0V8BrtgaPySMpsA0P1w/Y2aaYFh+rm6B7proo5uc5ixX6utguT3nM/4O/s6SV9ddzVvR6chUx88Ip65CsEnM+p6FeZs1/ZJvtwR42Xux1dEGJ9hSJry8uxDU36Jx44KZuv8EqgigRYCljRsul9zhyLqLryFiwqQcZwSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVOe8xs+S4P/BpYQtnuECRoZa8x7JWtyFlxxcMqo5K0=;
 b=heYeJdXQS8EuLWAszPuruipkeJ5ZLZ3eEtG2wcDNaoLBCVf8zgphB8BGN8twNnj+mEGqqdTQeCouSbJSX8+PutE6COm+8yv4B4OlMOLw2kH8fdOzC2r1TNtjxD9NWOYDJew1wQtp99MzFN4R8Mdveq2lYwZemZ2ZaQzbP9LZ85M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4595.namprd10.prod.outlook.com (2603:10b6:303:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 11:43:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 11:43:48 +0000
From: John Garry <john.g.garry@oracle.com>
To: jejb@linux.ibm.com, martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, dlemoal@kernel.org, ipylypiv@google.com,
        cassel@kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 3/6] scsi: hisi_sas: Use LIBSAS_SHT_BASE_NO_SLAVE_INIT
Date: Fri,  8 Mar 2024 11:43:36 +0000
Message-Id: <20240308114339.1340549-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240308114339.1340549-1-john.g.garry@oracle.com>
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::41) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4595:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5b0772-75b0-4a6d-c625-08dc3f6504e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mNTLuRyO3FqzVOqhHuWw/ur6RHA3KDUwg6Wj5fX04usApmRhTPuH5/KbRKldsj1iU2QbqgulBBZBQW5Op4MdiuKRfpSWyi3j4IZqEgX9jzwbh97tCZHcP4Pcy3GGjkWej5DqhmvOvluh6jBQPmrJhcXsgzGirAlAj5v5iFc/9r2lYGMlHke4AwzS3vi7dlMOQwnX6GvNDWLJFAY/g+77NubTbvThFzo2JH/wzNLn99cNYRaZA1CCu/GaBiT6iMhnfPp5pNRKw4mB03bCfm8/ZHJly0GoaKgoJSg2RdkFELZyim6/BXF1vcbvFvl/f+1VzhwEDqbQ/VnUaMjRzjBn3XBLfrRHcPk99cLf8HHq7fEpi5o8Whoa4B7j9jr06WNCR9mlMiP3G7G3IjggC1oLoBARl8sLYLYE0BE2lyskgpC7VyUYdED0UtuAeAGl0nD0r0aA5s+RjYzvF08UBrzkummNNdwaQrAU5/F8XLzVumJ1td45Mtyld0DoB6XkYg74L0hcwDIGDEq5Vnu6Uy0IiDOaCXK68bkW+mDsOLYpkbm69+n0yQo4SHlSx01C7xLyN7TZtKmwBfF4bZUJbJQ264MlwM6gfu0gC2P8md0JLGdBwMvTLe0qy+ZF5m/OAewgXzW2pfidWgOM2E27jtwmSEu4Aa0AJWYNiTk1YWU1QzA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qnseNFrnwqtwbmMxleFfQCAbCROgAIc4J81nACE4NLre04N62CayhSAi1Le/?=
 =?us-ascii?Q?sX3CDKWq3wGSI6nbaFXqe20nKVCQ7zmq63pB0jYVgtE8Zq/WfJk7fzqfs6sH?=
 =?us-ascii?Q?g+4lw6XeYKlBvDErHE0BOcxCgaK4L6XkNqqM1CcSRggEtglEBVEOgaNsd02N?=
 =?us-ascii?Q?7osjAT2PcxbNSY1CgDrMbrwQy1DIVA/YoPohP8djGPKGcBu/bZlsZHfw1+rr?=
 =?us-ascii?Q?GPeC1p2BEVITXXAwM7qJpfLA+gIcGD2miG9p9sCi8swcauiJIQ+uJcYBjxI6?=
 =?us-ascii?Q?5lZmb9yXc6iGEc/DxrctX8XlOoox9/PGSO2ulJvJ2dwP7q6ffDLhoVgNB1EY?=
 =?us-ascii?Q?vMKnn8/AWP2N3/QUS3LC2vAYrEdDObCpYSpiznsqnzl9VAfHTq0EV1yVWHdA?=
 =?us-ascii?Q?u5DEY/a3r8j4/LFO0uOkUJ6r5eyNnt2pL+y1rYF6kEp1zJV43uzOPIhye/UX?=
 =?us-ascii?Q?zCaY699aVsubtEYrcbE37Lc7++tpUquYugqIZTDfkuH0+obPNlG4HxvoiIkv?=
 =?us-ascii?Q?doDsh+MLzGRj6nXlmNVcMnK4JycKu+kEHBSxMrFBnxx/3lsp9N5FTsLmAZed?=
 =?us-ascii?Q?lTuzP9m1ob2n4z9rJW5vb6BXsyC2JNz6ad2EG9QQdgfibzKPhoKGioMZNmH9?=
 =?us-ascii?Q?nY6BLPp3xRjpfSKDYyGzTWtkHo7YbwY1wdAlV/X+bTQGQSw27C42q7ACmQWn?=
 =?us-ascii?Q?rcjKJSqR0y5DnjcLeQR873Z9+tbkMqKFOalDVDR9qx6ezssE3XSwIYLbzpeG?=
 =?us-ascii?Q?pqKjD/zZ2BUgDCL30q0bESTLCmwBetAjshuqTyTY/Y+pc0jhhdt85UCrFxak?=
 =?us-ascii?Q?hyUxSGgGxtoR9rAn+/wjnUS/ZVAw5mJM9pe7HITA7/Wrk0rnbO2JH0xlQA4n?=
 =?us-ascii?Q?iUMWyhT5fuvQ4IoSfi4dbghSfaFt/U7Jo6LfrIpH7/87fbzgWO9JAz9eoKBW?=
 =?us-ascii?Q?26KW6yhvL4XC/aBrw8NucGiemeqI+W3WitCT2Srm8iAM2MJqIkf9vyloQi7o?=
 =?us-ascii?Q?c4dVZCkzW0+YJxfRbh6HAEzlTlIn7Sz9itYrnptQzuhWRnxcvfFpxFli8agn?=
 =?us-ascii?Q?dQsVrOaNpPVExUOrdDVSLPH9Lvq5Z3n/8cizAbU5GJJAgGV6R07+0Evox7gK?=
 =?us-ascii?Q?YxEFbFIgMF0wjY6achaD2Qxe4f7fNUT/EbjNHMgs2YaxPyyRCRv7NesP5Bke?=
 =?us-ascii?Q?g+vZBFTYApo+x4Vmu5SGBlJErc27XI8yEbPYIwOKBjCb4bcaezlUOCdbP8xg?=
 =?us-ascii?Q?6PnZH6qpMW08PpuN7zYGwQigERlzFDbyfIyycYKgtpRsb93XE5dusxb5Edop?=
 =?us-ascii?Q?wqUNFjxCovKStEZwIOKLJbAKZMFx/7z2bpJOZCMmocKhRHhZ1AoHe/sUsIMg?=
 =?us-ascii?Q?X0v5n8RPPTR9Cxc+TT79D5S1/MKhau8oZ9z/5zRQsdCe0cy2a3ihzrapo3iM?=
 =?us-ascii?Q?pSIVBGVYHxscPrVtLzmc0Sg2McPMRQmdTYYsRMz1xPPv9igsD5imJfkI79OC?=
 =?us-ascii?Q?/j8ElVEgAHYvmcyrt2CWY7ZOEP2wGThopHf74Y9lq1+bIpmdezV06l/+NXjO?=
 =?us-ascii?Q?BunM8lhipgL9Wt5MhiYVOYX533owbdKvHjCmhXeT/g70Z22YJzjEUTncTmw1?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fNhRBgRxfGVMhaB2v//4put2dpPKQ4lx5lJ5cCwCEA57Dej6rvT9OrmroXYAaUqM+Rk4QTj0E/7YrxT+azd/FIlJulwbc1PQ604yVkejC83gwXp315iUVo8lpp59Ja7RgTEc/0oLHsJx93hFIjhwkKZLGYyzn40OfVNfe1fN8TpBuEDVVQPtT7+XZx7xoZjD9eA40uAskip9W7hA+tKCnD2a8625PUz2mEIwMk3AicbL3uf1iTBvNEdxabMGwhS/4KjdG0PyU6nECGLyuDK8G/SqbTWQXEdEOKHXapP6+B2lHN0vTmz5C8T0U2HEXeSLnqC4SBs3B48q6mHYgoalDUUH4T+W3h3/mzvAT9nCwi1oOc0DM7xpovPUpX8HcE6ARnuuv4Lrq/Z8NHG8iKJFaFcPXITXGyRLedkd1GtQjCfUBhgz0tPk6RJFYcog/4r5sWisbg6OPrBHLn5H165nGCjq5ZYgt5BaVvPYiFJIzQca2P+7PBPb27hIMiuv+BgfL6zUOkRgZwI/IQRmxANkEAXp7E3FCliNAYSyqleinR6nPIhDBDmKwC3h3SelAXGDzxfzOOhWkwuIt+GRtsONZM04uFa1fcJainFI7xUqSQ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5b0772-75b0-4a6d-c625-08dc3f6504e4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 11:43:48.6915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwnNltxn93rrprVVvMIw+0ti+zzizs6HnUjKYn01bQ6U+EteAi7oAwXRwZuIdx/OHb7QbWoYOt0U1qUSAPcD9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080093
X-Proofpoint-ORIG-GUID: rn3o3K76By7yq1CAL2qe0QPWA07HpGKk
X-Proofpoint-GUID: rn3o3K76By7yq1CAL2qe0QPWA07HpGKk

Use standard template for scsi_host_template structure to reduce
duplication.

Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 18 +-----------------
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 18 +-----------------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 18 +-----------------
 3 files changed, 3 insertions(+), 51 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 3c555579f9a1..161feae3acab 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1735,28 +1735,12 @@ static struct attribute *host_v1_hw_attrs[] = {
 ATTRIBUTE_GROUPS(host_v1_hw);
 
 static const struct scsi_host_template sht_v1_hw = {
-	.name			= DRV_NAME,
-	.proc_name		= DRV_NAME,
-	.module			= THIS_MODULE,
-	.queuecommand		= sas_queuecommand,
-	.dma_need_drain		= ata_scsi_dma_need_drain,
-	.target_alloc		= sas_target_alloc,
+	LIBSAS_SHT_BASE_NO_SLAVE_INIT
 	.slave_configure	= hisi_sas_slave_configure,
 	.scan_finished		= hisi_sas_scan_finished,
 	.scan_start		= hisi_sas_scan_start,
-	.change_queue_depth	= sas_change_queue_depth,
-	.bios_param		= sas_bios_param,
-	.this_id		= -1,
 	.sg_tablesize		= HISI_SAS_SGE_PAGE_CNT,
-	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
-	.eh_device_reset_handler = sas_eh_device_reset_handler,
-	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.slave_alloc		= hisi_sas_slave_alloc,
-	.target_destroy		= sas_target_destroy,
-	.ioctl			= sas_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl		= sas_ioctl,
-#endif
 	.shost_groups		= host_v1_hw_groups,
 	.host_reset             = hisi_sas_host_reset,
 };
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 73b378837da7..b8646f6e4c6d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3562,28 +3562,12 @@ static void map_queues_v2_hw(struct Scsi_Host *shost)
 }
 
 static const struct scsi_host_template sht_v2_hw = {
-	.name			= DRV_NAME,
-	.proc_name		= DRV_NAME,
-	.module			= THIS_MODULE,
-	.queuecommand		= sas_queuecommand,
-	.dma_need_drain		= ata_scsi_dma_need_drain,
-	.target_alloc		= sas_target_alloc,
+	LIBSAS_SHT_BASE_NO_SLAVE_INIT
 	.slave_configure	= hisi_sas_slave_configure,
 	.scan_finished		= hisi_sas_scan_finished,
 	.scan_start		= hisi_sas_scan_start,
-	.change_queue_depth	= sas_change_queue_depth,
-	.bios_param		= sas_bios_param,
-	.this_id		= -1,
 	.sg_tablesize		= HISI_SAS_SGE_PAGE_CNT,
-	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
-	.eh_device_reset_handler = sas_eh_device_reset_handler,
-	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.slave_alloc		= hisi_sas_slave_alloc,
-	.target_destroy		= sas_target_destroy,
-	.ioctl			= sas_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl		= sas_ioctl,
-#endif
 	.shost_groups		= host_v2_hw_groups,
 	.host_reset		= hisi_sas_host_reset,
 	.map_queues		= map_queues_v2_hw,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 7d2a33514538..16ef89002fd4 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3315,30 +3315,14 @@ static void hisi_sas_map_queues(struct Scsi_Host *shost)
 }
 
 static const struct scsi_host_template sht_v3_hw = {
-	.name			= DRV_NAME,
-	.proc_name		= DRV_NAME,
-	.module			= THIS_MODULE,
-	.queuecommand		= sas_queuecommand,
-	.dma_need_drain		= ata_scsi_dma_need_drain,
-	.target_alloc		= sas_target_alloc,
+	LIBSAS_SHT_BASE_NO_SLAVE_INIT
 	.slave_configure	= slave_configure_v3_hw,
 	.scan_finished		= hisi_sas_scan_finished,
 	.scan_start		= hisi_sas_scan_start,
 	.map_queues		= hisi_sas_map_queues,
-	.change_queue_depth	= sas_change_queue_depth,
-	.bios_param		= sas_bios_param,
-	.this_id		= -1,
 	.sg_tablesize		= HISI_SAS_SGE_PAGE_CNT,
 	.sg_prot_tablesize	= HISI_SAS_SGE_PAGE_CNT,
-	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
-	.eh_device_reset_handler = sas_eh_device_reset_handler,
-	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.slave_alloc		= hisi_sas_slave_alloc,
-	.target_destroy		= sas_target_destroy,
-	.ioctl			= sas_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl		= sas_ioctl,
-#endif
 	.shost_groups		= host_v3_hw_groups,
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
 	.host_reset             = hisi_sas_host_reset,
-- 
2.31.1


