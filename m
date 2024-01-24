Return-Path: <linux-kernel+bounces-36865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA8583A7D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6651B1F231CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066762BAF3;
	Wed, 24 Jan 2024 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jWv6RhMX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wThLawxq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209421B270;
	Wed, 24 Jan 2024 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095740; cv=fail; b=GyvexYmdrsGHZsiuA4qpVlmihVscqydf5bJ7xS75xgTE1Ah3h4X1gOz78H9h4qFuK9/Us7aUxouQYpweODcFP3All6qD7mS0daVoyRcy2ViH/svZp8DrK7m06SBXDz/3IN/vabyDlVHNUYRJbUglLYsm85JBfLeLSKtW8/evVc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095740; c=relaxed/simple;
	bh=dD+EpPWqh9p2PsYJw7Kx6BfTVXzRE0omUncQuGGoDOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dW0THAreLJPjaCFNvMYDCMSc/kYgXOPayKddXyrG6flBG7QZevXnQ8d52QKOQ+5ok5/IqsMGMSLDPoqZqkQ9RXyydejK9Cqt0UQxJ4d/CkN44foc0fc4/1ZHeVMDveCkCNfOkhagvo6cw93ptY7h32CkhVVpuNjvLBvkqJB+QaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jWv6RhMX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wThLawxq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAxPel030722;
	Wed, 24 Jan 2024 11:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=wZWH3TGR3zGHi6IpHY+/DJBwXgrXZgANjuffCQZOFaU=;
 b=jWv6RhMXJHUTnrZbxR8AsKtR+Yv9tHW9btyK3STfdyTWNdzYZKhBIMcRcOOZsUgavCvZ
 i9rlO9UUWhD7wwTXy6q+Fs9PnCGJtXc76riacCDETRQoVfcZ/GwjiCW0FjMY1IaWr4WJ
 JEXDRTDVdbixBhUJikNLLmaDK8JfoiGqN1l4Zxxqb+zXOMs2LFwYTaCCHf2WX9xcJuZJ
 AgwamfjWiN1Sbr3e1C0h1hde9kfLGD/zRU4CGCLXReF+xrdY51ZJwcuLpTYkbDFTNy8j
 UP1TxykKriZBjd5vi/I5rTfpT61T/OJqJd7Wzf+38QuW5sTeGJSBf5DWdkfY+KwNHaIV oQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cusvu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:28:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OATCL8014262;
	Wed, 24 Jan 2024 11:28:48 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs372vwtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:28:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nddkqYzDjkblwYEefcpk+CdQIsEqtmpRTKk+IrWVQWuwV+X+kQBc4S9m7B+HGSA2Pao5PFFNatXh1IHVJ4lbcX1KfNAADijpElfrczgeq7SvyafxzJwP23IOLvRm3aOPynehQOmsGfmWU5Hj5ptbfuQEkt8ucvUJOrS232JPn00xhGfMjT+bpQdCiFTrvAbioWXO8jIcD6KOus1ooXyWyWUMRKLszDXFoKV//vs+cti1E17AZbX7LN+YY+fKmchHPsm0rCngChUeeTrv90sFcKaFBXH+SsH5AT8zJzyqEc+Cqvrzik8bwJ754aVBW2Mq08Dz0x/lNh3yPO/Pzu4/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZWH3TGR3zGHi6IpHY+/DJBwXgrXZgANjuffCQZOFaU=;
 b=lTK3zepJuo/kGy2iyIFDKZJRyUPl31YShWwuBoVMx4Pyw4AJQl/rO0ic7LqmvjRTPJEKadbYAkZRCOKLg5cZkud9dtHwcqniJXTI5LTH6hdpJUzf1L+B9YFZGIEbYVBb+cG/loHSvx80jvXhBVDPJk42uxaKcZ3sO+LntslrbpnThq5PBZrNMH0NHYHMMtCJiYAHUzt2mI3d8wsYgKxzYGzvRE5Ye4CQ2xk8GC3vIMWEJSxour8iaZqeLtP1HDB9bnjkYiC9lZYJQst1Nnw3HsOvvP7YqbzF1+lbXWVq0vMn8zLwUsF9kiIStaonP8wq4YWAYkJa6iltYwHDdl34kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZWH3TGR3zGHi6IpHY+/DJBwXgrXZgANjuffCQZOFaU=;
 b=wThLawxq4B7P+aEcFqUKUQpSRLDVC6ir3AxNUVIaGOZGca5TFD5TF/3Yj4LeSygC7pn4xA7D5sqiPdvKxsPR7v9QNKC3b/HlrunqORmFNP9rqU4TEvVryXzz+ziGnlLPTrCrA9MbCfhdTlwt79kdMLzVoD57qBVUjhNcLdJeYyM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5615.namprd10.prod.outlook.com (2603:10b6:a03:3d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:28:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:28:12 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: martin.petersen@oracle.com, djwong@kernel.org, david@fromorbit.com,
        himanshu.madhani@oracle.com, hch@lst.de, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 1/3] statx.2: Document STATX_WRITE_ATOMIC
Date: Wed, 24 Jan 2024 11:27:29 +0000
Message-Id: <20240124112731.28579-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124112731.28579-1-john.g.garry@oracle.com>
References: <20240124112731.28579-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0164.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: beb27113-eadf-4767-454c-08dc1ccf8cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dEC5kHygWOly26MXDG/HS+Oc91111NawLtmBKai41ahQpOA0EZ/Suw2r9FAOMdKtNItxtLIJY/h4wvzK3FVG6Wbt41wBXr8hC6dwVjt3p2d2xyuvqv5Gom+MhPQcsOp+a8AwSsV+0unxhL/CPmX5mYHxdNs2eScia6hJYAnMHa1RpMMbPAjsTeH9AgkIqdLI5xo1Aipihin/ajElqtVKiKXTVKFC89cPuwfoWy7ZH9xihaEJb0VcJuxvg6DQvfMO8oEn3busSi4cyyL9GSvpI28x+liqPSnWPrMzk6735eLfRwaagRx/DbLNn8eJ54PlywCvZH1SS2ygJ2GqbcpI5b8Zj0pLtZF/aKjS5UhqMkkaTSj3Mxy7TxBdmX91UPnahLEvG+dWmClESOwCz2Z1kVU/M2z77pT6PfgYgm940MLHV8OgbriweR8PsjmjPPDv+XaqoikKYtryeCkEgjctt/m65JAAilvqbHXJguBnIYhO/l6A5DpiQzSysQL/36yA4sAZuQ30a1ESwgkc1DFqgzshnEyUyCwpWbMqn6akczMDyLTNHINpWp6jz/N1TTp+
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6506007)(26005)(83380400001)(2616005)(107886003)(1076003)(6512007)(41300700001)(36756003)(8936002)(8676002)(66476007)(4326008)(316002)(103116003)(2906002)(5660300002)(66556008)(66946007)(86362001)(6666004)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fqxrhAyCooPJKmxNcBmh/4pTkfJNo6VweYIjs09v/t2ZqLSSMKuy3G19P2Eo?=
 =?us-ascii?Q?4w7gkFvl0C9oI3222gxQIk1mpUIwhKKT43npsy+Ts8ZgYCCJjnDqzkIxLkZL?=
 =?us-ascii?Q?EKHi7iyb3Ky6vDjdAI68Hs7+2H1qTDMlduBLokYXrW62rlUG09vwKTTMPSUJ?=
 =?us-ascii?Q?hEA6x4fVOvIerhiZEMfDiloWl21wfWpTzfwECKPfVm6pi+v3yn5QggLc/vn/?=
 =?us-ascii?Q?mxNyYH1w8PqpJMpqDi8sRiGUqLNh5sakvL378/Tw9zNNLnu8Q0TzTUmMDgkQ?=
 =?us-ascii?Q?vM09vsE3jr5yaE9TNyDKfjoSmPPYvM570BndVGU49YnQrG/XxVOFo1yI3tei?=
 =?us-ascii?Q?iS22ubVcmo4oY65n8y2sP9g2HinXD2h5Lj9Og4h8TFq055r1gMtHgaUwzJ3y?=
 =?us-ascii?Q?EheMBUZ6CthwnBgAhMsHnZXoaoNkYUaSuC/GzFfdOG/MoyLVR8J+bnEu32KH?=
 =?us-ascii?Q?m5WlmBvaqM4fsFfOIOsZUW5a+9j21iGRbSlUvuy+RoE9nhzNlO6m+97uQ69U?=
 =?us-ascii?Q?c3CVYjOx+Kp7pFaKPxROgCLadGAVmOgFy2ZlwhymnhCYBiYGme7+kTl1kQpK?=
 =?us-ascii?Q?Vgnc8o+ZVYHK7aKyihtrhn/NZoAHVtWAisS9ToDOY7BkMdDLlSRaHh/vHexr?=
 =?us-ascii?Q?Zbx6c+VY0XUpNvhQU4ArAn+fC1e66KWZzJCgcNs2pc45qAQwIiuWSS1KCS8E?=
 =?us-ascii?Q?pEeRX3sOccYPREKsZbn9AuCXonVTqIj0y3/RtarW2zb+J1ASfbs7710sxtWj?=
 =?us-ascii?Q?X2lvg4/EuvaZJTlDP21JVix0vqf0dYwF4DzYXShxoLEtNuAChYcsdYz4VPDh?=
 =?us-ascii?Q?muIreO9A1g5kyIMyQiVq5gQkUAOCIza+hCAl/snJfb26s5jAi3aLXWmD0wyH?=
 =?us-ascii?Q?6AbCVsWFmUwzpod3jXztlgZB2Kq1qstlk1TrfiP/Ku/oW2sykzE3tGBCqr6Y?=
 =?us-ascii?Q?1UMtposzfv4GFedqGsRKw69C6AAoWyc25sHueHneiVs4lb1TfbU3gdIPiEme?=
 =?us-ascii?Q?rCKIMZwTLfJGL6wo/3KqaO/kLC1nCoNbRCfNAevdtLFyVoHm03+LMZNHaDqp?=
 =?us-ascii?Q?6XqUv0GCQ9u82byB0D3DY81xGlKBxZiWmAgpkQCOkA9HlYW0nHKl+Mq2uLlW?=
 =?us-ascii?Q?Cr6w0z0mdz8b9HEolmmmdcQG/v00sgrgfJTGPPtyrBj5NjPFIssW5BuDwOfa?=
 =?us-ascii?Q?F8vXvh1/YhVtsz1M9MhuLjOcKPIpARCX0BDrVD4xRuP4hY8VPAiCRbv0gyiS?=
 =?us-ascii?Q?23oyaXPPKEwYY+4xUu+kFVIzlC0/I2Sbf0NvKqR5PKCg619BrRXRWb8P7cXr?=
 =?us-ascii?Q?5mOUrWhyJFynJ3lihTVE6nGj0mr+ZzheyA5QnkNWq+cHTBO7vJU7ypaR6Cqe?=
 =?us-ascii?Q?cmJpoiU2C4kww3jxyU2GxfleEtl9UHQGUAZfnAydVXtF3thwmE9mAt9rGH3U?=
 =?us-ascii?Q?yeY9hDSaWP/zfoDp8EtG1GkDQnVLPQDpEJ6aDmq+rojT/IIIyKK4KF/5b3wO?=
 =?us-ascii?Q?ETQnUE0UKloZy3HTDE3ihjzRC1nr10oiUkkiIsviJkHdUst322+fxk4nCWqy?=
 =?us-ascii?Q?ZQt3jm0f/OD6LhSvLP9itFQ55TMIZF/EnzT18a5MwK32APNuzlg9cptnHwM4?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qT/LeqFTIFLPSUl4w2j2B7lCigaHLWS56ff1b/NAju0byOaZXrHrpEJJ6iknKaNrlxy8toHc46/BwCl3SwfGOn8N2xBkSAICyC5RBzlJoTZsuHWlrkSFno8GeN3uMKSfuO4HVoLccSN+whDn3BfW4yp52XcZwyeFDNH67e/Qm2oWBl6exR2MfrzKJVUssDqUibH74x4Qh0a22x5u4RvrCn+u3/bFYlQKr1eeceCJl3o54iFyMDzkq0UnOW/HWK4fi/XraByEtNTUFB22JqlyDjHzpnnAdXxQIFhX6j69qpJE2e74zQwlqHUh7hiu8pT1cwHaMNJJR//Ud/UoFeK/dr0y5CynKBQ9htNMrt20FHXG8aiesyCrr4D5+JXulj5VeeiVL+IWS82lAaDRjiPjMQ/aOHRmZZuZY//bM9RkepQ+r8PCu3Sx+42bhNI6C6GnTqB/XL8+5Rw6YUphMX7zn99qxjj9Ad9ftX2z13s3w7aNeYxSTuVEAcr7rXA3BhZJ7g8ylWTmka/UjW1dxNOWuPyT5JqJmF16v78FWEPrlyBShqX/Yz+tBh15JquNB2Yts2oa5Bx6kVr1l2i6A7dgsKB0uCyKmF33ekRCRfY9IUI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb27113-eadf-4767-454c-08dc1ccf8cab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:28:12.5532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: huI9s40ng3K/wy6GPfZ4P+COADnkf8QYZsb5K/g1odRBMWk0wXww6pDnwyfp2Fv3qphb5CI8GAJjyAStx6NWOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240082
X-Proofpoint-ORIG-GUID: 4RYDV04I0S0fWdS8222O2u6CWcTyNAOg
X-Proofpoint-GUID: 4RYDV04I0S0fWdS8222O2u6CWcTyNAOg

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Add the text to the statx man page.

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man2/statx.2 | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/man2/statx.2 b/man2/statx.2
index 0dcf7e20b..aa056ecdf 100644
--- a/man2/statx.2
+++ b/man2/statx.2
@@ -68,6 +68,10 @@ struct statx {
     /* Direct I/O alignment restrictions */
     __u32 stx_dio_mem_align;
     __u32 stx_dio_offset_align;
+\&
+    __u32 stx_atomic_write_unit_min;
+    __u32 stx_atomic_write_unit_max;
+    __u32 stx_atomic_write_segments_max;
 };
 .EE
 .in
@@ -255,6 +259,9 @@ STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
 STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
 STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
 	(since Linux 6.1; support varies by filesystem)
+STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min, stx_atomic_write_unit_max,
+	and stx_atomic_write_segments_max.
+	(since Linux 6.9; support varies by filesystem)
 .TE
 .in
 .P
@@ -439,6 +446,25 @@ or 0 if direct I/O is not supported on this file.
 This will only be nonzero if
 .I stx_dio_mem_align
 is nonzero, and vice versa.
+.TP
+.I stx_atomic_write_unit_min
+The minimum size (in bytes) supported for direct I/O
+.RB ( O_DIRECT )
+on the file to be written with torn-write protection. This value is guaranteed
+to be a power-of-2.
+.TP
+.I stx_atomic_write_unit_max
+The maximum size (in bytes) supported for direct I/O
+.RB ( O_DIRECT )
+on the file to be written with torn-write protection. This value is guaranteed
+to be a power-of-2.
+.TP
+.I stx_atomic_write_segments_max
+The maximum number of elements in an array of vectors for a write with
+torn-write protection enabled. See
+.BR RWF_ATOMIC
+flag for
+.BR pwritev2 (2).
 .P
 For further information on the above fields, see
 .BR inode (7).
@@ -492,6 +518,9 @@ It cannot be written to, and all reads from it will be verified
 against a cryptographic hash that covers the
 entire file (e.g., via a Merkle tree).
 .TP
+.BR STATX_ATTR_WRITE_ATOMIC " (since Linux 6.8)"
+The file supports torn-write protection.
+.TP
 .BR STATX_ATTR_DAX " (since Linux 5.8)"
 The file is in the DAX (cpu direct access) state.
 DAX state attempts to
-- 
2.31.1


