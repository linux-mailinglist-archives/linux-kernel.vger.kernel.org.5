Return-Path: <linux-kernel+bounces-36863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9D683A7D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E4F1C22EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BE61B592;
	Wed, 24 Jan 2024 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eN88id3m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gWE91RCL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80181AAA5;
	Wed, 24 Jan 2024 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095739; cv=fail; b=ZqB85+G42OxQKZHIfVCqJ/J57Ddso7VaF8hvLnPeB7cgYxSj6HRqj34MMAsvMhcGuPMxKoutpV8GT7IODqICTapz9v9IBgjV9KeutCZr0BPFyRT/CpfyHkpoHKRekvkxdimU7RvchaN+Gig2ZMJYpAKjyViUz35TAH0as/WHydY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095739; c=relaxed/simple;
	bh=7p/LLIO3uDDR6gkPZf0s0oboHPVtb2MdMmvvavcx43o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=F2H4u2poe5uiNei++dftj7YbN2fLYpD8EhuypkVoL6hmUjFmfT30I7ae2qm44h4uG9XMtsiH6XJQXIBq9y8DfhZxB6QrwO0uwfuhmvv9R6aWQWAeMI0K4xyimV9EK2GXL4ayUw670hv4r7CiWTj2Fy3oMfnonZ+NIexixA6AR4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eN88id3m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gWE91RCL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAwqw8026946;
	Wed, 24 Jan 2024 11:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=DWgxgFL8puBkksddk6Rn/kN/9+BsZT0h06jfuQ7xWLA=;
 b=eN88id3mBViM0MPqX/6IObFuvhIRkfxT5KD4GD+X6oOaQWvH4qxrnAVvEyKoK11EQ67D
 eI8bcGWUU6V64el9WQW4ZGsjHJI5/L7a26RTe9X4eFPLY5aqDku0r+nVNgBjE4HmSNSn
 d2C2/tTooIfuQaeHJArzZYyADLsTQ3Hi2zohZfR0gHRzv8Oi+iRUTcFv64yophuhpVlm
 2hRPi+KliCzoWtlfxhigWP/mgdPMCyj0OD44wYTbTDcDUo8fdd6Mz+atDNCuL86COKO5
 Nm1QAR9CtvJ7rYTAmQGmpTdIAFkpOyUSUsPrXL3vuGPDpCL27JOX+zhvsPJS+ErYwR1p 9w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cwhv0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:28:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAbrrf006305;
	Wed, 24 Jan 2024 11:28:45 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32se9ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:28:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQeEBOXbyfrU+N6keTb2XoYM5h2bO2M0Sy46bKLP5h3CoT/hZxc+z6QJazGhV8QNNIBpZm3ZDTqo9MXNbLwlr7PX6FjzBSIpg/N2LX86D6ePIMbjtkrpSNgxvOyuFu0ruNJPF71KYvWfll5CZW7FUH2psp4jhLPY52OeQEkKCcVP992ix7da3cxQRbjTUexN3cqvZFGDQ7djjncVHK3y227TRA6yPXYA7rR3cm8fQfbudA9vpUA9gOp8l/i6jrSE+8cJpBF1Ca6IsuVUs2iCaZYwrEX90CW5T+O6rLlt1sLloBO7okQFImOLz1+fd/lYdPQKislpELD+W0p2at3cOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWgxgFL8puBkksddk6Rn/kN/9+BsZT0h06jfuQ7xWLA=;
 b=M7fUURrfv4/dIVphBVtkysv3LxUd/UlrECp01fiZcwTYLhYJUAR4XvX5RoDR7Xtt+e6jiCctYi2XV8WSuOOT458xyuy3+z2lCUX/44hUQsrL4H9EuZJtvEs8ej4yjI+IzUOL2xUdXB3V6yYCVZNU0RJaZ5O9sEgMtnp35pDUX/y9IgRJaWEOZPNY5NOyXs67KfLNzhNz6v5xGQjN+NUAi4ubVKPvPL1Nn9kXJgTe5dpyJtktoigm4cgo9Mz/mTsvj6XBG4G0KYzaKVfmbdC8Jxwo2BYpXOOUjpZ/7v9jD1pZ0Zt2MrmG9h7IbZG9xmTnXJlY0I16MjG1BNIyCNcEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWgxgFL8puBkksddk6Rn/kN/9+BsZT0h06jfuQ7xWLA=;
 b=gWE91RCLeroln6vjJvrAAxfxVVLbKdWbwa8JD/7hKn6pe2KnecdRvKwr7BTFus7aEEg6mclAz0fQuYnDiz+FIGyzC1RwHbnkiRPm8myVW9gbyXQDyA5AN2WaEj+oeNOGilQ/yNN9Z1MNPriQTM8zbw9qxqBDm30PMP/ZEJt/zsI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5615.namprd10.prod.outlook.com (2603:10b6:a03:3d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:28:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:28:08 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: martin.petersen@oracle.com, djwong@kernel.org, david@fromorbit.com,
        himanshu.madhani@oracle.com, hch@lst.de, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 0/3] man2: Document RWF_ATOMIC
Date: Wed, 24 Jan 2024 11:27:28 +0000
Message-Id: <20240124112731.28579-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0038.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c22e7b5-e271-406a-f417-08dc1ccf8a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hycHOcqG3Dc9kxCL8Wo34YqmjjVUQCSHu7sTtXRfQ7gfwoLXTCrsLr9Zlco8Ad1WS0Byhtes/LISquoGNUMMHLlB13fluwKRTZ0YFvSyPIAhVuaMZmfXm4h0L/HJWPguD1erWNietSGABtezzl1V0yDN+dhPuHJODJs+mjJDYh5kddGsAmAc/GK8NtWtEQHOVkMQ6DwlGbogB1BwPF9wzk04jTY5iO+Vcf9MwwkB1UHoZC2qKidl03GRtP6EliMKXY2Ld+gW5d4T6A+0IG3C0auj7YE/9CL3+90JM2LtOSUsBPFZ7kRUtQ1VOOh9l0AOQoBQefzJql3onqQqbhlyw5/H8QtJrNtmxe3kD27x/d4fiEtdXdyA26kRT9jL0iAOJWwMZjqmsD5UggnRuGyD7VXPn85tPl8vauFrz9O8p4MNgM8vB95DXgRIULUqfQLdBLcR5VrgKWKAvZl6KOoqDy0+pvUY4hKAWZ4u07rpxTuZCg7vE1uLYhM7rzDi4guwBuyQ9weNUzaeArbrya6ijvfYDdxoYhM/H8yq8gtJ44riUkj6IwJQCvVhSswlo8UX
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6506007)(26005)(83380400001)(2616005)(107886003)(1076003)(6512007)(41300700001)(36756003)(8936002)(8676002)(66476007)(4326008)(316002)(103116003)(2906002)(4744005)(5660300002)(66556008)(66946007)(86362001)(6666004)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dZoBOZx7BhnS2DiLLl/QKRKFRjH2QxN+evxqeZmvp8NOeG5BgjXTjibfV5Vz?=
 =?us-ascii?Q?prasujPpTRAoS8o4aHlevu/NR8OVo6/GL8kR1THkA4yQjS7SVJw9wKK8Cpyc?=
 =?us-ascii?Q?d5VxUo6m8xLlp+PuQLsKJtNxD/W/HVXfIJbQFvNqROfS7eY9ahCbAUJ29He1?=
 =?us-ascii?Q?eO4bJuqFftNhMo7JqU6dUJzJ90+KbHJA7g8j5TAkyLNS9h82pLGAMhTtKnXa?=
 =?us-ascii?Q?GNd1yplharaGwqpBXvLR8LTtyEEmDYur8ZXRkYkuP+BszJO+QZc+jnRJqfV7?=
 =?us-ascii?Q?pbk/tHt3I7rx7k/GauVeFD40by8gJzSk4XmHepNh0D6Q5Cd6J8rESzivCm+R?=
 =?us-ascii?Q?5JqQ19wQ2mRRwjXKpU+DlzsQ114TYXLLtBJn5Hi9iAmDTwRWpWvdNT7duPQ2?=
 =?us-ascii?Q?K4hkU1rc7Ssjvl13pw51TBrGhZBSB5S7mr5Ae5leRQez/ZAvcqN9UG63mjw0?=
 =?us-ascii?Q?dsK/51AMizPKv35JcUapNcX8CN7ogyBCc74g7T08gwfKuuUSwszsYwZigPoM?=
 =?us-ascii?Q?S/gJ0VF/6aDQ0i6aqhv19z3DoStPMQbEsrhvEbOfpwFjqCCZpiAbC9IFzQ5N?=
 =?us-ascii?Q?JluDcivhjNyzNYEBnttVrHUve1rsAADNM/5QHtx94MqriHAjaFpZuYxnDqCN?=
 =?us-ascii?Q?OX3nLz0S4fgm4Fhs6ytG7ATz4LBaxFHq7N+WnnkBNOky1Mk19gfcj6mgGk7v?=
 =?us-ascii?Q?tYKh9wl2qCmghMsqfki6sD4JywYHX1rw3L687kJ3Mztxg01SaR09ZSGa1t1/?=
 =?us-ascii?Q?JldLKxXs4/n4LmOm0PRAlXWQ46A1Q5lixH2Dzxbk55fYk2dCqIUSK2s7bSBm?=
 =?us-ascii?Q?cSP3xh/Q2QJkhdEg/zDeSSCFm9EIyXHKbr5dc/P7afvjdm7R7apYnKxhMWKy?=
 =?us-ascii?Q?KvwQj/+jwKffWcxmaL22HcGw04jPs0M1Pr7A4K1ri0EqJVnjzUpwSVkFfjoK?=
 =?us-ascii?Q?3GrO8EfCnWKAG2NlOYEYj+yM+4IGBHcMegoEhLKEhNFuYMMXmy0hnkkd3Fq+?=
 =?us-ascii?Q?WdN0uJY6gyt5jdz971j4ZM6TEx4hy01au3AaV7Leoig2OHD+pSnSLtqrSfcG?=
 =?us-ascii?Q?OlFSujjyBGr9CIr4spdco6oPWJHwcQD6dPZzoJaph9p1T3Y4H6VHOKzSAEnq?=
 =?us-ascii?Q?MU1Rce5LWYC3bGSCBZhxoZRGTLXPO2xkeuUTEedPL4EGxPbquclwPI0Rhxp+?=
 =?us-ascii?Q?B09ICm6tmTclDbI3shAC0VDA8jaFpxUiP7ycd7rNJBLuDzIBMmV+RGnyJwbB?=
 =?us-ascii?Q?GP41jKb9OIqWvfIcz6/013ezGTmaDGWdRokGhgcNcxOTdBFD1VnNgyAdXKzq?=
 =?us-ascii?Q?4WCrMZWn1RChwvuCAyz/bN8dJ1Bl+brWdSZrN1DshF1fWoxugXTWjAZzrQmT?=
 =?us-ascii?Q?EFrz6+qCMWlM82yLm/EbRt0KRsIVjXXfs7q0x1u47DmI8GJPAbu3T3Bo+7sC?=
 =?us-ascii?Q?jZO+47BSv1ZevEdXuoQnCUx5+I/89mUUGa+5yrPV7fJ+ugL48cxyIjvOa9CW?=
 =?us-ascii?Q?YLiInaUHrm1v764bTF6aHcYh+poj99wntDaOhA3wVaJAurySxYmLg6sOsvEH?=
 =?us-ascii?Q?UhgsO4ZZlmnkYjNMWzdcTFAE1ZM0eZZk84zMgGNEXUq9oqusUZBdcgh1MSh2?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rCmjgIwHr3tE468/2d4XCmrglITDMu+mDIcrw+kzpW1GE8gfZgZHUKZYEN76tsNPPQSTOigK3sG2440PxFu44uNRhC2x/Ic2a2IEOoXNVKpHXAA3YeHVltcJRfvKCWNE4zFoxkFLyrf+iQPYMNTSc8gM8SMk0K1BJr8JEMkJmhqv6ZG5sQBqwe2TNTvhuud20C8PRqJrQyB+CCqsSILnsR2+BBnzauxmT8TV2TaLBN+1dBJYXf4kE012b0NdScVNHUhiNdGNE+X5ZxlC7ENjeyP0ghXbYWx2rb6JNcv5i2+qj/XzGCK5TIEGVy+WCSoqPSry/hElG0z3hBoY+9PdZJ+hPWt1E9tHVEpeG9zUeYSmR8Pe2iBZAq0KUk3VCvtcjyVR+ZH7yZ7wiIq1Gkz3BHj072JOj56BEIbUN8ceSug/D8rp2Bwgf7sVe0tE5DZsIDYCsNimFGP+5W4LuSJmPT54xwOdaNp5h4npaQjtubAZYpgbBPBlgaXB6sG7DpXphxgDEAZSNDElL4fRd+zryEPz4YceiYKQCj5Dl5dnXz37Gj6Ko/ENiyaHze+5YpcQT1H36yU7bC8heZPIJOFwEWKtLRxWZXe+7eO6YmRtiJk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c22e7b5-e271-406a-f417-08dc1ccf8a6c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:28:08.6988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAZ6qV8lMrRnqTusbR9EF5S1BhcRaOAwLqOQ/W21GPbL/qzP5JeBsvXSSwcUIC6uddhs5/P1AzsR5k1t9VHwyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240082
X-Proofpoint-ORIG-GUID: 3Fw4j-3mjNjMRhOKBSj-K3c4Go2HVLxp
X-Proofpoint-GUID: 3Fw4j-3mjNjMRhOKBSj-K3c4Go2HVLxp

Document RWF_ATOMIC flag for pwritev2().

RWF_ATOMIC atomic is used for enabling torn-write protection.

We use RWF_ATOMIC as this is legacy name for similar feature proposed in
the past.

Differences to v1:
- Add statx max segments param
- Expand readv.2 description
- Document EINVAL

Himanshu Madhani (2):
  statx.2: Document STATX_WRITE_ATOMIC
  readv.2: Document RWF_ATOMIC flag

John Garry (1):
  io_submit.2: Document RWF_ATOMIC

 man2/io_submit.2 | 17 +++++++++++
 man2/readv.2     | 73 +++++++++++++++++++++++++++++++++++++++++++++++-
 man2/statx.2     | 29 +++++++++++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)

-- 
2.31.1


