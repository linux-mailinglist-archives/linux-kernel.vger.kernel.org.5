Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A591B7B2F62
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjI2Jij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjI2Jic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:38:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299771A8;
        Fri, 29 Sep 2023 02:38:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9TWV022472;
        Fri, 29 Sep 2023 09:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=H70Kb5To4c+I7RjuZVipuDWhe9KKC9Ipgu212PqVmP8=;
 b=WgNJaGclR+r+gj0VDL+VxElWdzeO8kLFd5/9VKvkmxga0jldKSJz4e9W7pONbnfFYNLV
 OIrTpJzKuk0VdRHT7UPs1e2cBWSIlRoUgq5NkCULKg01ioC5KUj/l4r5T/f4XLB0PbZ+
 uCaJO6pb7xB/RIb1G1Tp6hzP4S/mRes76isq5moytUFOQaruf4JRZrZSQS5+wT3qvgZN
 jmCC3l6iXh/AmsPqlBN496B83DpPaGQv4OdZAFV4uVJk2JP2K272NALip85FQwOw5Jc+
 0WRtaLblgjXRZo5wIMzoPUUtGUB8TbL4/dyNF5R+YpT7FAHWhU/SyhaPkHKMtUVDYxvN 8A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbp9hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:38:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T7msw3014617;
        Fri, 29 Sep 2023 09:38:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfbk60g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:38:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HD1HXmkkyaJHePN5SCuR3tma/EZlO5e9n+sboUHScFsSuIwVOVNg532rPnL6kQkgmGTj48kmvODTBsslwyzfTbxDvyIlxKhnZKqNta6c3iQrzXojdeE4xccJby9FS6pgcwH3ZgGe8pnBcQmv1B9Fd0x/8CTu4z1Dis3UDQDMWEz9d62gSnrJ7zNsOGaA0tM+48swpLPmJiA5IY2v3HHHXks4Rea9r6Bn7Ylnp8mUcwFgjW72gOEaTnONAh0q4bLTiNmdqRC6brgj6dRiSSTWjNNnhChaTrMd9lhaCr3IH0UmrOfjei6vE12IsNw86UMSZj8dl/5MtFsi61X2WPMVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H70Kb5To4c+I7RjuZVipuDWhe9KKC9Ipgu212PqVmP8=;
 b=P4RBYpLckRcXyhZuqJ4TLOrBfhKcXjUDdi70aYSnaIUDj7aM6ZSy49b2WBzA5UoyebYTT4WKu3u6Ytx9A77kWsyaV3FJGfS/UPtNOuJH979Qo/+CAEcg0lxav/wrSjpGbC/mxFyDsBmvhP4l4l0Ra1RtgVfLUSvIMaia6cOHVWlTia6BHVWnNi6NPDRAzwyMclidiwH7mFrcInJIYRlKSvgRSSsvc7jkvCyG4wKc+bJbsrAIGR/XmqJtWfiyqxqCCckp2/4LF7O0qJfC7R53GHJR+vtnMFuUTp4xivUWWVETuF7ptIabbJ1+/nk5GlEyzcUek/XGXw9jKhze3m91XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H70Kb5To4c+I7RjuZVipuDWhe9KKC9Ipgu212PqVmP8=;
 b=w78dflW6B7Qe/91NK2WkBB2Ivsm/rQjpigeuO1Ia5jf9extpw5XQbwOfigQvQLVjfupCnSl1TFjyJACHQzHosEt82xHmGjPgeHJcJVd+37wUwg0rWWf2/8iSSbmHs+JMZ7IJjR+CqDLZMrjglkUXtqat3RJd5l8eYQn185UyNSU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7197.namprd10.prod.outlook.com (2603:10b6:208:3f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 09:37:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 09:37:48 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     martin.petersen@oracle.com, djwong@kernel.org, david@fromorbit.com,
        himanshu.madhani@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/4] statx.2: Document STATX_WRITE_ATOMIC
Date:   Fri, 29 Sep 2023 09:37:14 +0000
Message-Id: <20230929093717.2972367-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929093717.2972367-1-john.g.garry@oracle.com>
References: <20230929093717.2972367-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 364669fd-2ab8-406b-7a35-08dbc0cfbde3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5DLIS1Bc73pQnN2BpZ8wKDS1/aHNUC0VZR6GsjmjH8ZnL0K8sofSpTy45sA8D/5U0BW7mLwckKhfXbVQIxR43O4eBKMwd+lEiHeZpIM7T4amaCBRrIhkTee/DG6KF87EC+8R7PEq4cpRGxOKcqT/37nyXB+1tSLaQ510aoY/IWRAzuEGxVt7rXxj392s7Ed3J8CW0b33ME8DikioaVWLurrVOzgCF9edlg1atjrtRnD1wiIJ8DSur3SWxDDyPCgbvLp8ECKZUVtfaURMAmPaO2VcCaLI/rUOVGvDF4aQ9VV/hnkJ4nVhuCiuBGE1VO2ylmrm/8vmGnm8p8T3ZIurF80aw6J/CCK8+czBTHzTwCZ+ARqZ2x7O2xNFuTnMgp9q6D4V8ACfScSmrlm8k8CPdOHL+/kOyuVauyAeFIpA+vZXd8J2Vq1fYiPAD3iqgwJtwM7mKRH0gJg9Vu2oiPKSTAYqPTD/1RH/DE+pJffC6Z9LpuxGNowSyEU0pKrTwmvOjun/Cg/V35FUEkhm+aq1NohDgWy5OqCQyjiUcPKTBiQ9V3kiMkknm9mlfR2Vxo5h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(86362001)(103116003)(6506007)(6666004)(83380400001)(6512007)(5660300002)(38100700002)(6486002)(478600001)(36756003)(8676002)(8936002)(4326008)(1076003)(107886003)(2616005)(41300700001)(26005)(66556008)(66946007)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PZbnYSksUu0FJ9IF1aWl3u4+U2I3+/T8S3tsvC1ut3xs0e5A8CSnnK2JkHTD?=
 =?us-ascii?Q?BqNo2wPGpMdeEnn5BihJboJKYl+70cn0sfxJe2SDv1pKe8VrAhPiEF+MmTdG?=
 =?us-ascii?Q?65lWVReRb19PHat++o6/tkXiXfB9F/TUFChANgzrF3VGwM3ypiFZ1Ct6aIZx?=
 =?us-ascii?Q?oKJ9/SkJgSeTstF7lhpQhn5l6ndvUQSqKTl6QfOjUm096OSCW3yWPaNUwi+t?=
 =?us-ascii?Q?pvey0LTGujnSGEKpKwXZ+vA8of5C857t1WhtfPU3Pz1mp4TqIsVUk9XhAVBd?=
 =?us-ascii?Q?DR8iMqeQfUtWftbjH406ZkF41dBkc0yYkhRi6Ksc+z9wX1TLTS9diDYQXE/T?=
 =?us-ascii?Q?Q2YWJLp/B8IZwcv4JB1RRNWZXQs89l2c5NF+hYunbGE5VGTotMlXjnWdbvv7?=
 =?us-ascii?Q?91g/8gF3pcU4EGzgoq8+GgfbS20BWcu2/K/RuaBTf11lqUYYJrOx76wfCjh/?=
 =?us-ascii?Q?IS+pM6gM5feSgyIRjsudjibET30ePb2jA8j5ALDYeCNK5ITKStJbDrTb/COo?=
 =?us-ascii?Q?7rIqQbzjqr4ldLP4ebfLb71jQS649QabMv4r4r5/P4yNcfOZ0ZxLaWffJ2gc?=
 =?us-ascii?Q?l2HZrLiECxuctCvMkmlPFtS8tnLG9EbHiz9jtIO8D9PKXGZ5DKySQ2kMT+Qk?=
 =?us-ascii?Q?HDl6MM6D8XDPIeqeG5ZPNr/tGm1l3usg/GRKTKi9zSzfv9nZzm99pgT1fXoc?=
 =?us-ascii?Q?1N29YCSiPfZBWSVj9hGYc39o5BO37FEFiCOI3VNkKNdXLUGd0AgqolgWx6/H?=
 =?us-ascii?Q?P7xL7XuuEDFQrnUZMUFeVp+MlKkCX1U7J6eyMI4LvQUnSYAGPEe/UXxnnwJL?=
 =?us-ascii?Q?SKwMSiiJFWNTmzYcwxfQtMGFy2W2nU1Q22DF7FxReJnTGyn8m2lBgjorNudF?=
 =?us-ascii?Q?Ov+oMX+2dqSHAXD4uu8WsOltnAuREdpG3tTQogCyi5EfzXQR1yq24z6JEenw?=
 =?us-ascii?Q?lTEDC2Re8sSqDP6q5M1S1gZvLhUnt5/JbO1M7k9cUBL8ItTTX5irM+PTxFme?=
 =?us-ascii?Q?Ap10kuTdn1ZHCrSUVN8rGMsVNRfyMEF1iwYJcKJ/KnO1qT7f3plEUroKT5wi?=
 =?us-ascii?Q?NlbHkaRrjcxfofU7gmNWBBU4eowNlptUicf/8h9mdPdBxoiTw0K9Rz0FyBT7?=
 =?us-ascii?Q?1hc31pFDq1+oS+jbim7qMfaNSoZsKC+lcy6uzp1Gzda0kBILPkOtXSycXzbN?=
 =?us-ascii?Q?zgEbttrBKel4HE2nXpeuvtEkfbZs+DqBWyfpL+bBUappUUqZA8a/eOSNjoR2?=
 =?us-ascii?Q?otq2qkyD+rXdd1hvju8LclACKZOjjk6+2f2sKv8M1MwXLtK4s5DaTN7Ijq4I?=
 =?us-ascii?Q?TqWOEtlmKHnM1CxClAeLJSVfgkTfigkoSg1FpD9uwPQN+FmvMpP8pnmkkUpH?=
 =?us-ascii?Q?+FWW5WFsYNMu/71DQsE7U5jaVKG9yFRqh96U23Xe88ce1mpC5HB4M6wgfPEd?=
 =?us-ascii?Q?Uj1xufXJ4WewmYc2lJFJOGwTKNxNfc4OZQ7JJ45VA3fEt+WcQFFeBtRHs9IG?=
 =?us-ascii?Q?S4WTDeQvdzpokmZC24t5He1egUVL++OB+LFvLedAFHJhFsJr9ecclKfrGu3P?=
 =?us-ascii?Q?0d+AeG739kdkNO72iXRfUs9MkH2rd+BfBwdOGlTzYEi9ShdTXK8vckW95NM+?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jAnO+Arwn076xuHIKqBaAbEDuJfe9gYMu4NDO8WCWfCgryTRGgD4SluO61+4pd+HjCeIUYXJj1FkUkMimELKzQKMskbJNPzR6rGV5L452XDaUUeVWB+gTjH9eLZUyP0wG97/cPvGpjmJP6o1PXclNmtigewKgRHkCuIjgJoEryvX1wMSLuu0Rl2L4V0Ahv25MeQ3d53QnzvWEwqPI/JwD5F6igrQO0vNr7LZvD/p/dBHGx8st0Am4pxhxdUfMVwPhNFCQ1+E7xngoBhlQOM45tTetynzW2e+A7nIROTHUsqPk1EDhq6kAxFb0WSAVrhCPOkyHmSjGzbi9YC8D5kCf7CiesYmoKptEoRRFVuiDkMML8O0gzITnVC2gBc2PzLJ5TqwQXsjCR4XXiPkqj4wx4LOxxQ/cv4OhXAeWl40LI4/JKeqPTN9dVIpUEefPZC2yVdvpp3BQp5i5nObRNDgNQQYnu3ATDb9bIjOBFyFMCN54msdbCOGHyRQX0ASnlMKn3eqfxGY4NNJiwFyT6tVO1I7r6OlMW0ypgZGfLGAFLfR2mlsJ6HLvH0Tm7ojGjKWk0SU6euS9lrRh38I0zkOqE7WXUoykyFqYQAZYroSMg8eRvD3FCil0+b/d8ezmwjnkh/y36KcKes5VGN/z2CIhhgxEFoCjgVnanzKiJ85TmoacO4Pd/XXCrbhQr9z4e2Gjt8lH+neWGyXg7umMQS+00kePuQgofdQBGvQbl5xDlBN/Z1H6tBRvK4PS2Trg5q3cNrTM3CEBnLyJB8wF/pHo3pVH7GtOJTDQHg0vpou9Afni4lIQ34KWp5hz/q2IGfTlE1svTZ6VEEjqCfFacxYtA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364669fd-2ab8-406b-7a35-08dbc0cfbde3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:37:48.0977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPRRmzwNsNUo/s9zLIEJtqfXECbzApe8buO+L13ndSLrUEs5T3Q35bDr+FHSHbVUyfp0ehFYy/MP1+Rh/v7VhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_07,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290083
X-Proofpoint-GUID: jZDlhSAZ5q83izRNtivGjaf8YAYYmVJk
X-Proofpoint-ORIG-GUID: jZDlhSAZ5q83izRNtivGjaf8YAYYmVJk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Add the text to the statx man page.

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man2/statx.2 | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/man2/statx.2 b/man2/statx.2
index bcc67c8e3bd3..23b9c6953ec5 100644
--- a/man2/statx.2
+++ b/man2/statx.2
@@ -68,6 +68,9 @@ struct statx {
     /* Direct I/O alignment restrictions */
     __u32 stx_dio_mem_align;
     __u32 stx_dio_offset_align;
+\&
+    __u32 stx_atomic_write_unit_max;
+    __u32 stx_atomic_write_unit_min;
 };
 .EE
 .in
@@ -255,6 +258,8 @@ STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
 STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
 STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
 	(since Linux 6.1; support varies by filesystem)
+STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min and stx_atomic_write_unit_max
+	(since Linux 6.7; support varies by filesystem)
 .TE
 .in
 .PP
@@ -439,6 +444,16 @@ or 0 if direct I/O is not supported on this file.
 This will only be nonzero if
 .I stx_dio_mem_align
 is nonzero, and vice versa.
+.TP
+.I stx_atomic_write_unit_min
+The minimum size (in bytes) supported for direct I/O
+.RB ( O_DIRECT )
+on the file to be written with torn-write protection. This value is guaranteed to be power-of-2.
+.TP
+.I stx_atomic_write_unit_max
+The maximum size (in bytes) supported for direct I/O
+.RB ( O_DIRECT )
+on the file to be written with torn-write protection. This value is guaranteed to be power-of-2.
 .PP
 For further information on the above fields, see
 .BR inode (7).
@@ -492,6 +507,9 @@ It cannot be written to, and all reads from it will be verified
 against a cryptographic hash that covers the
 entire file (e.g., via a Merkle tree).
 .TP
+.BR STATX_ATTR_WRITE_ATOMIC " (since Linux 6.7)"
+The file supports torn-write protection.
+.TP
 .BR STATX_ATTR_DAX " (since Linux 5.8)"
 The file is in the DAX (cpu direct access) state.
 DAX state attempts to
-- 
2.31.1

