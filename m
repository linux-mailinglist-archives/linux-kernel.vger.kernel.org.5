Return-Path: <linux-kernel+bounces-36866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B45283A7DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3817D1C2307B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459AF20DFC;
	Wed, 24 Jan 2024 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RLMpCnV2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sbeSzYEx"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819CB481A1;
	Wed, 24 Jan 2024 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095753; cv=fail; b=kF/oZNRGpIS6fZViqkWUp7EUZ7UozAXlXhKNNllFKhRnk2hUcQIHTxh8ImpBfRt1hN+zvSGI5WGSgsGoNeNI0mDvBQi8ZEt2SbrdN6+sLN63T9Gup3H3bOvyfOAwTIj8mPX6+9PvIL6xaxGDSC9fNjE7T/83KtUpcbP9J0gUanc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095753; c=relaxed/simple;
	bh=PGsTtKCaIXhJcbBDY2Mi7npv9HDRxSTEq+ri7TH9bQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QPmoiGunZJEUFqfS8nH6apuThemDmYqVg/+GVchsgQKLGHvoSOFDXK+XoNCxhEeoTdLzwVmwhOkNwscI1gsvc5zgEf1rp+H4G7trXmqODYDgdjxNWDfJJG47sZIb4o18zCnPn5NKbArIFJ1w8mHEneD7+hCiJVyBqZ9/tHeoWMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RLMpCnV2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sbeSzYEx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAwjio002348;
	Wed, 24 Jan 2024 11:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=tMp0FldAFhIhKfFYkhbzFAmj6JyD9uSQjdq17pQ4d60=;
 b=RLMpCnV2yIpn6GMWZYzNjowxLJSqUu8fjQOVnu/MpXg3HG0qEE3amnEIkF+EwXHudWm3
 a7HW13iuy7FlTznxxemk0wB8E9aIiramwwy35maox9F6sO6ZZHF5PKQSpJimDdmUvIrO
 xmh4Qm046Jt2WfVatwJW/TrjgjbybLWXSzW4OdBMCRnCV6TiZDDEdLmTZjoGkK9t7U5y
 eAxp+LWzJEuLN7zYZ33hfF5UhpqwSGCh1CKbkkPTmNSb6RzchQAZoaS2JxEkxc1l0z11
 y21bSLBPBUxbiOLLJri1cjBWgpOxE75RBBn9afAoK/8CC9PQK3zJuM7PWbDBHr/97E6l jQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7n81w02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:29:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAbrrj006305;
	Wed, 24 Jan 2024 11:28:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32se9ar-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:28:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0Y3YP06A0WeAofjE6swtjRye0jX3vG4dE+209XS7hp/qc4izAi0i2vIlRvoUOtCxKpqdpFLbvGPR3qtiKgUEbljy6yj7e5/7T5gQnemh6b8ymfjlEJCD+EPhphbwwTl0vPtU6D0nwSkwC+PaAOLjflhEjFxcdp7ZmNrvqSwc9G4H58cHS3rYpACqUzN+c/9IBHcidm4FMskK5tW0icqavHt0BQN7lDeImqIZfK4m9gxnqK7Exzo//vkynvua+doI6S4epxoyVBbRxXsA8+LdvfiDJw8ll/fo77ibI9YgI/lwjaUO4urADkzdVGcjSfsESNVqUHWUtHt/PNqCUpRJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMp0FldAFhIhKfFYkhbzFAmj6JyD9uSQjdq17pQ4d60=;
 b=oYb9vtv58DPJ+OVdJz0oZS7qSTvUTw9fZTHBfe/UfPhybXCfZ61TtZGtgX5j/KY0nyb+royQFsOJKvx1/tdcO4PQoAWdQu+yzyNQw1R5GnLZ7QjoRc0itQrXKAS+TcykR+55JZbjMzNAwWwO6TLVToeFJKKgYSZyRiVyVS/lwZiObxYu/s+fhWy+addLibTJp/JTR129MH2rn2wL2x215MPgAd6NKfnfgjMwXXq+ZoEyNzFfRgllQUs94TxHl0imiMH3rImoxbKtIjX8lKB+SdOGEz9SKipYxDIx0CN8tFzqUZj/Emfm6qCnIdHQow3884jMcbPiTUB4ETeKeeJEag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMp0FldAFhIhKfFYkhbzFAmj6JyD9uSQjdq17pQ4d60=;
 b=sbeSzYExiGMG+vXc/AYZfBnok0Ex93G5/zlJr6/Nf7Ic1HRqeNXIP0LwzOW6P2WIw+WonThrjWu+EEiwv9BZd+Ra7lbBkJ+ygGNEArVKNZzysdUwuO4sJwGzwPUbeTTi3F4ml6biaxzaerQWawv/3I8jj70pH/ooULXuvYX854U=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5615.namprd10.prod.outlook.com (2603:10b6:a03:3d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:28:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:28:16 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: martin.petersen@oracle.com, djwong@kernel.org, david@fromorbit.com,
        himanshu.madhani@oracle.com, hch@lst.de, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 2/3] readv.2: Document RWF_ATOMIC flag
Date: Wed, 24 Jan 2024 11:27:30 +0000
Message-Id: <20240124112731.28579-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124112731.28579-1-john.g.garry@oracle.com>
References: <20240124112731.28579-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0045.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::33)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 447ceb7c-c0ed-48e1-dda3-08dc1ccf8f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1HUey8ZaP7VO3/SSGzM/kAM8RDWbkTDzco+3bY+IfhKmcVMO+Oof8pwwu8OnUp9YE/dDA2qWVz4TgWP2TsilseDVprfXlf78HA5D1V7oNJA4yzaQqTBpmm2DH3Ho6eWm61U1MRwr0rWLutQqkDNZUVFoMgPhJrO0ttpdn3Z+vHXUMlSF955hIvpHJRB6xEwStoZ06NpEd1dCpwq6ZC3CrT9u1+dbk9xPLDq2AqI3oM82QdFIzR1Bkohyrz4C/SJ5QsWEAsIsg0MsdjrQl5LK846HIMlxfO/WHQMwAhxUKsLUQapKlEeWPC8XKezyqrkTPGL67jP89+m604HanOoTVQAvQZlFkiWtMmMnXvV+C0wrq0ujQgAMzPbcyzLVIcoNy1sAdWKdGte5ehmL0bnHM2djP8Un08XARyPQueZecNr2GxJMrIZz79l1Y+ek2816RIUn6xJw8ehPIrdQFlqKcPIREQTaweL+drCxsGFz9Qo7AI+LBjoO9wjIN/fyC7WKmnd0slJo1ObM7BXa9jh1H7Te4H/KDA0GmYw956GWfKOs5Km49UY/bwc2WkQWByEK
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6506007)(26005)(83380400001)(2616005)(107886003)(1076003)(6512007)(41300700001)(36756003)(8936002)(8676002)(66476007)(4326008)(316002)(103116003)(2906002)(5660300002)(66556008)(66946007)(86362001)(6666004)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?e3ggV72o5ZIwdjyt6mPJJke413PMSrrU1VDUAb93VjbbhAMT/UGVrU6WNnHl?=
 =?us-ascii?Q?EoT6KiMmv9ENzQjUe3FSL6Zf62bbs/fF2k6DiicO5jcj8ARRwPtfdfmFDyCb?=
 =?us-ascii?Q?YFJQ9H/zoS2LqXWI866Sw25CZBWDbp8cHaYq8TQdKRBOp/dImGPsf7aSsMA4?=
 =?us-ascii?Q?9f9H2WGIixn3pSlSpobWGZt0vuukCTBs93FuQNzpVjKSW70w/Oju4vAo0BkB?=
 =?us-ascii?Q?mmuSwq1PzdYTEqXZ1FKeHELZcHUqkMHVZGtEDintK4BqHgbyjWZB2XGemZTY?=
 =?us-ascii?Q?++qjn8kcAg9cV921ou8MFzeLt8ceG4Gs6KLPhF185sA/cxZDAIRw46UDbKzY?=
 =?us-ascii?Q?QYQ/xwXG7Bdm5Fqjea6BIwnFmXRcCwE17vi9oVaQHlTEltA7h3NvxBk1BNlI?=
 =?us-ascii?Q?lJMFJWze/uzZUaSd76DoiCpTd4RQz3cPKtq2a9DdOkN58bIn+cmRNGQWSwR5?=
 =?us-ascii?Q?C40WMv3c28jQCTs8PGfoSR1vtA+Wi4Z3g5sS0rnHvUdpBphOBoPUtZTKvyjS?=
 =?us-ascii?Q?WyZaDoZvvhOlQ0tO0ZPfG6VwpRFXni8QbVNXrE5JBZd6wW2kX4YaKHZ/ey5K?=
 =?us-ascii?Q?c+Q75LmrSPzc9mxZFgYoa+HxyV9Vj0/FXklyxi4t37MnnNSQKyZNgKRoPyUE?=
 =?us-ascii?Q?NRukWJkOTtOcvXvhCw8p9Qbv8PmjhOe4nYQR4L6wJmdBXg8IR+SxNtrxjQxU?=
 =?us-ascii?Q?kQeli/4luNZtp4/ONa+VjqEXa0O2BKpGJmuBUEsIRJNv0VdpfVuCiOaZBDW+?=
 =?us-ascii?Q?012ffKtnfPKr8aIpPUX8+A0TayYH5NpZIH5XJlvOUMRXIjhgFIRhmmN6aYjF?=
 =?us-ascii?Q?2Woliod7PbVHi5OAF/Y6rA/vBh9wzR4f12KQ48h+/+tlQnmQhD4m9B8f5LoD?=
 =?us-ascii?Q?GmdaddrhK/IM6ugX1uvh6y7/MHt5pXqQway6QKi8ksTqwi6Kec5C2YuO6oY9?=
 =?us-ascii?Q?JJPRpprdn7cuafT8js8DjdoA9WoL5IJTdnvpqjRB/kZcGNhpKQbzlc1TiRqY?=
 =?us-ascii?Q?aWya+kYeWhNMB8tWRNCI4vQCBsW0WdTZemL2G6U2DLQkVy//82D1Yg9V9hoi?=
 =?us-ascii?Q?L6V4d/ZEGt29+w/d+4ZOvmM+LEU1DtcIqGqy3jo1PPQkaEkVdPR321Y60xqX?=
 =?us-ascii?Q?hPV7vJMb0+e6WrqhQASFsYDAGkJ1S/Msrqytv74HYHPS6w9nMPTepvmSeSea?=
 =?us-ascii?Q?0UN+ItfFv90e0zr/uURgRIGQbjrTMM+1pyYAcTy+c/Q+hfMQwDj9VYYvhreK?=
 =?us-ascii?Q?QVlv3FEbsvxXfKDTWhI4h54V11AeM6RvXBqeaUNAnPdVu2SJ1MbSXf5DZQyK?=
 =?us-ascii?Q?XYP3Oo9IDCiBgBQdASem2EbGc2+bNEKOQcI1y/Um8OrONMzPBTP4J0WXZBGr?=
 =?us-ascii?Q?V9+NnJi4JuxQztu8Cv9W67L0AYKEmtAtSfKSSm2n1ifl7EZrR7Q2dJum0k6D?=
 =?us-ascii?Q?x+6hdYRUNFbwIRw2N7IMqAOlqUAkzBDZZrxuFu+md1It4Pikv3iGu8x9jWCe?=
 =?us-ascii?Q?IVubxwOtOBNcx31k78eFpfjQNTEt1CQ7x/Z/QuNGPvgrAHmWjgKemphy8N/w?=
 =?us-ascii?Q?EVoeEigLQ10y74PrykT0QsvhynPkPbgxaiAxSGRlfJberGaRjsAjRGEeG3sS?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4HRFL7irGOl5WwE7EEyFEbFGTUsybJ6Doe0qhVfgSR0P00AnaTUhDR8M8ARIAlXb3KmIueyPXF/s/2rqlvGbW21MlGpCz+f1PsREuJmZadJocH45i2e8GA0LxHJi4Ix6je7JjbRXrb0D9teZLlkUfdnDx8WgLDiMxNkNJSnlT1yRqxtlfgmV7fOTjsatig5YAT4Eekql2P0kPQE//Nv4RntaARQkZQNq2bTY9F4nLgOxSWTf32f1GP4jf0tbFdX1hnQFjIHDbS3KMYwczlf3EhBfG1EByivNmsNyAaAM0napZQFSS48BAXN51vG1kMN/tKMjUGBLIrMUdadby/OFc3c9OKdFkS7Zr5NyCniGVeqxRAdGkCCgjyN8IGBDPGJm1jbdiQ50DlkT+K9aAEuQXiCAxzobWai9eXxLV1WWZHZw8uxVECbu++XhPrpXMTGpvuICThEZ5iJIgPz/JzHcjY5qZARsfWfrle+SrBgFToycCPLyl/qK0LPLxrVAnTP9fxpUIO6gE0m4SCSEgpHqNH8/qOybFtgjMn//1sidxN8EjrbZnrdiGMk8gYigxOOgdxZfj+W3N6sHgH/UURc43zNAtnKYUspXDAWnYcK59dM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447ceb7c-c0ed-48e1-dda3-08dc1ccf8f15
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:28:16.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k40auin3i/Axrij++nSKujziX/cLELMMobJLYxlGDNl0cQXtMWObftd+u/zoO4rfePMnsignZEhA9zYSq7K82Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240082
X-Proofpoint-GUID: zXYq1QrvBLCBsgd3g1VyUOWxN0FYa7Sd
X-Proofpoint-ORIG-GUID: zXYq1QrvBLCBsgd3g1VyUOWxN0FYa7Sd

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Add RWF_ATOMIC flag description for pwritev2().

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
#jpg: complete rewrite
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man2/readv.2 | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/man2/readv.2 b/man2/readv.2
index d39f2b9b9..aa5d6576b 100644
--- a/man2/readv.2
+++ b/man2/readv.2
@@ -193,6 +193,61 @@ which provides lower latency, but may use additional resources.
 .B O_DIRECT
 flag.)
 .TP
+.BR RWF_ATOMIC " (since Linux 6.8)"
+Requires that writes to regular files in block-based filesystems be issued with
+torn-write protection. Torn-write protection means that for a power failure or
+any other hardware failure, all or none of the data from the write will be
+stored, but never a mix of old and new data. This flag is meaningful only for
+.BR pwritev2 (),
+and its effect applies only to the data range written by the system call.
+The total write length must be power-of-2 and must be sized between
+.I stx_atomic_write_unit_min
+ and
+.I  stx_atomic_write_unit_max
+, both inclusive. The
+write must be at a naturally-aligned offset within the file with respect to the
+total write length - for example, a write of length 32KB at a file offset of
+32KB is permitted, however a write of length 32KB at a file offset of 48KB is
+not permitted. The upper limit of
+.I iovcnt
+for
+.BR pwritev2 ()
+is in
+.I stx_atomic_write_segments_max.
+Torn-write protection only works with
+.B O_DIRECT
+flag, i.e. buffered writes are not supported. To guarantee consistency from
+the write between a file's in-core state with the storage device,
+.BR fdatasync (2),
+or
+.BR fsync (2),
+or
+.BR open (2)
+and either
+.B O_SYNC
+or
+.B O_DSYNC,
+or
+.B pwritev2 ()
+and either
+.B RWF_SYNC
+or
+.B RWF_DSYNC
+is required. Flags
+.B O_SYNC
+or
+.B RWF_SYNC
+provide the strongest guarantees for
+.BR RWF_ATOMIC,
+in that all data and also file metadata updates will be persisted for a
+successfully completed write. Just using either flags
+.B O_DSYNC
+or
+.B RWF_DSYNC
+means that all data and any file updates will be persisted for a successfully
+completed write. Not using any sync flags means that there
+is no guarantee that data or filesystem updates are persisted.
+.TP
 .BR RWF_SYNC " (since Linux 4.7)"
 .\" commit e864f39569f4092c2b2bc72c773b6e486c7e3bd9
 Provide a per-write equivalent of the
@@ -279,10 +334,26 @@ values overflows an
 .I ssize_t
 value.
 .TP
+.B EINVAL
+ For
+.BR RWF_ATOMIC
+set,
+the combination of the sum of the
+.I iov_len
+values and the
+.I offset
+value
+does not comply with the length and offset torn-write protection rules.
+.TP
 .B EINVAL
 The vector count,
 .IR iovcnt ,
-is less than zero or greater than the permitted maximum.
+is less than zero or greater than the permitted maximum. For
+.BR RWF_ATOMIC
+set, this maximum is in
+.I stx_atomic_write_segments_max
+from
+.I statx.
 .TP
 .B EOPNOTSUPP
 An unknown flag is specified in \fIflags\fP.
-- 
2.31.1


