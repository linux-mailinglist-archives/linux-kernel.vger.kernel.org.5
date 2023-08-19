Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7323781627
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 02:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243442AbjHSAxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 20:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243437AbjHSAwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 20:52:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BB444B2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 17:44:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IFnroL023142;
        Sat, 19 Aug 2023 00:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Y0M1KA1yrSVeKfynevc6l+LcV8CLK0zixIWyAZJH/hQ=;
 b=E5jHXTESBtSA8OPSHKGcJ3oLu3MlixxgQkPA9lmmHMV5bTVTm2lafAfjaHIloTFQ/dG+
 DkjBvrn7GgYqjiZUL9brZZuquIbLJ7r7mwJcclPSDBh6txNTzX3Loxf2id6+yVv6IT4/
 +o+leQSP6bvDLNLa+rjQ+YlrtvLR3ouc4g4J7tz0PYtBXbD8nQyjATeOYxre8hNqkfEP
 nZ6y36b83+EPUyfq6H8xdMa7hKGjqMxWnv6AmHLEURb2ZugBxNVOptpQnKqIbq3HzNXf
 bP08SJeV8aXDJs9s475E6uNMH2302FMPsS4ndRRsu9iKB1djhPW69BOwTdBsP7/8WUvX 8w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfvs3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Aug 2023 00:44:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37IM4Vx3020093;
        Sat, 19 Aug 2023 00:44:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey412sgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Aug 2023 00:44:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuJEdBFyw+fofEaR0qbp8p6H0+hyRnKbZj0hRg5yEpxH634sdS6sPs9jiA9b2vE+9VlgcrSl7fiCEh3TNoMgZiNkt9rnUE6xfEnWpFuL4U0O3fDaHKXiHATnxUkdfY7edR/ZgjQSw7PWrbm4+Qv5OqPlMAYs8Cn60lpZcmHDpu3ECd1B3iYpjrrqfTVcVA87o4jxGNoVMRgRjoCf3vpqtB+mFLL/8F0QnnnO1/48UhBx/hwJh8yuX+mbRGMNMcE9+VfPJ0MTHPJfFwBGyaPWGpSGd7lTYu/f33UoC8HKwu6ovk3eTTqypEnigclWERn3nGLC1yMz0DWMWZzfH6/F0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0M1KA1yrSVeKfynevc6l+LcV8CLK0zixIWyAZJH/hQ=;
 b=EuZCl+HJ6PmK6nspZaB6qrmtIdb4O6vYiHgpN97rBpfNmex4PwjcK2OCW8oP2WAxbvs6S8Dc3Ej3J2cGEaIqkYpQCOzAboDeRKbgAzfp2xre7QT5rMSrxU2jhhm15wlXLzOsHA1FMzVdpnNptmgOgZSaoOGGibG3X1w4k/vbdgEq6H0qc+7obFOqdUdcooe+TpqWByvjWLDeeYoTDyaCJIvXwpKuAzY5sSygBr3VfrsTot0wbkxyRRbShE5JDT0i+3QD8fXsX65Em34uBb9I6ZScZv2PSt/Hk+gaQ+eyPkoWVbgOlfK0zPCew3zncI4IXut2vqzRCZ6317EMH60nHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0M1KA1yrSVeKfynevc6l+LcV8CLK0zixIWyAZJH/hQ=;
 b=f4VuIjD81ramYWE2qg9Inqop9t62LE8Thiy8OJBbKL0crgAPoC/qSqIoSXbugSLrJX0yQwmW9mhsrQl9RwKMqRor3c5TeMAe7Q7VNdRClNcT3qkwMDjgUAW2r3a1F+kSldbrFlQvr15xLcr0jLRb4KDiV9R/3QLPDfEgV2cTT8E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7167.namprd10.prod.outlook.com (2603:10b6:208:3f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 00:44:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6678.031; Sat, 19 Aug 2023
 00:44:10 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 2/2] maple_tree: Clean up mas_wr_append()
Date:   Fri, 18 Aug 2023 20:43:56 -0400
Message-Id: <20230819004356.1454718-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0005.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::18)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abcf94c-f584-4e5e-5624-08dba04d66b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mX3gax1YC7hg2b54phWecCAbTyGUZsvKWf2tvI7T1d/Yit2OhE8Y+Mm+4qxvavfZVFbKe6gRW0zRJJqRUfrjsjd6tOaBRxyIoSI/2V+jXpMGvdoPQvpi/FhrW6VUcaCKQOoyPyEzSZvZzUOYEU57jbOHopK2MGYF5WEyWT+3MHiQXIkrZ+JDsmp4Uw48VCG3/xVc7c+vTTQhgiaMKZ+IVxMrzH70hCwMcsc23NzA8SBqL4V20A0GTyv6iTD+uIsFpRFaLoBOPpDJ4/KUam+LeZ+ezzOOT9vLcK3vCgZXSscui5KYhFbAeT9MCYNb0La6I4kKB+VjdMD8/xpimbZ2ditX1Z1f1WyWrVDF8pUCIUrzTgfQ9I1RwFcygCqfU0hheJWvZOcqGY1PuQxzWvcV2/IeQlXJaMIjVgvXHwoFPmzNfRr5Dxau3s39APkihWqK8DGSYR/SBeieWTeLFBcjwi7BxKWWtwa0jT6iJd734d1in1HFuCjhRVCKb7dSq/Zg3Z5E6kEOy8+yODUEk7ep1k2M4j1odiMoBZGuC+mxfnbpGCplqRjMyxQvLlJWwozu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(38100700002)(6512007)(107886003)(1076003)(83380400001)(36756003)(26005)(2616005)(66556008)(316002)(2906002)(6916009)(66946007)(66476007)(41300700001)(86362001)(5660300002)(8676002)(8936002)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YvyvJeG7GQK5cLIk3052lLAmCRCjehC8bn6y05Kofu5LvN4lxXJo2RMHVy4k?=
 =?us-ascii?Q?/OILWUTYaH/EzetQ22BKxFgXig00zgIgGFzfYRVYzgBpvINEBdN7hBnKwOg0?=
 =?us-ascii?Q?GhFHXF6WbFQ3dvsBjoTWhM1VZaKEbr6LsNL4vJLccNuvuTpegk5YmUCZ4XUL?=
 =?us-ascii?Q?W4SSCjFtESQ9S6/vw4cklDSdRWUE/+83hPBAt3Yde+h26SCOmBafFw5V4LKA?=
 =?us-ascii?Q?6c3/UKbPsjvYt9bIa75mlcv88lnaqY0X+3PDVfRUt+R9iMIiiOCiSK5YCvbL?=
 =?us-ascii?Q?RoCqWF+3XQbHl/koZKG0NGZPaf2la4VBsVUTXXnJz3x6o4QP+wCE+zY0yP8k?=
 =?us-ascii?Q?G03D/bM2JT15Bz2Q78TN/4J6AdAeFmlyEhrOi036X3K0RxLWNE3ezQ9R520j?=
 =?us-ascii?Q?3ssF1vtGhEljTphW7DA+Fr/agrlV/2LOOCdjjrtNlEJ3PzgxjyYzMfPaIhRd?=
 =?us-ascii?Q?qQa+aKnKhgcJtx7Hrb3S++1vpsnuvQ0M3EKLKVKgqEFYX1OglL0Yb8ULqoNG?=
 =?us-ascii?Q?EzQo0oYOvy6xx8sycZFr0XEP+8cyx875pzMvjENvoUDqwuCiiO7Ff4144RH9?=
 =?us-ascii?Q?WE+xTArDGtpSS4WrWM3dpP2hQVDuwUTr36Z8s7V4fbImSh3FGmzLPwjrqdTv?=
 =?us-ascii?Q?eaMosl49QLsAUFMCoFQBcSRkix6CrtWndEY6kKhyzeEH9a6w4/fDlpzZq/6m?=
 =?us-ascii?Q?MKqQPou5V+Kjjoupq9XFbQTtbUoznaevwH9brHcKWgYF5kNXw27pSlRPXhjM?=
 =?us-ascii?Q?G5aHsjm9G9KmTHsZFv34UVvrVgiBiDU1Uc9T+yRvtjm1kY2FrT1y6euxxM75?=
 =?us-ascii?Q?2i6tdYzRiLekDE3UwUC+Z2g9jUyikLy7o+pdic5GPV+iM1ndzkiKP7/9ViYo?=
 =?us-ascii?Q?LQPqMqH/IzZClisJYRgmNadkZbxf1brJ0SlqWbeeRzWZT9U43fjCTTbTimB7?=
 =?us-ascii?Q?nyPqD5KoVqpwigZig0yuY67KXK3OyPEygUOFON/lcRDWYBhIkOaXGYaFPDyi?=
 =?us-ascii?Q?MANhCmJRj+hmSoWA91pdE8mB7Z3H/fk5n3GUB79xrvcpn5dWUCHYKF7/OXXW?=
 =?us-ascii?Q?IC+fWNSHZSio70YMqTjzMLST2MOThaCliw6FMIoC08x2OflM3rSius7nYyWX?=
 =?us-ascii?Q?9Q0pEYmnGaKTomLHmBERJvtYCJsZUokDgCp1GWDlqTKpQVI5MKdzgXST2YGL?=
 =?us-ascii?Q?cfcjKlq6InBfk6jnJsts8gnn51nGUQ1hxNeUE0tGdvxbVwea7kNeEzSO6swL?=
 =?us-ascii?Q?RaKC3p5XdHfdFnIHObapsWMvobOJhQ1A6QAHQPANa5hUXtvd4nSyaBzD8fr7?=
 =?us-ascii?Q?9mbk3ZliAazRFdaEUDoUyPu9QVleuSE4sY9rGLI34gOsg/A6w2dZhYVjfhMX?=
 =?us-ascii?Q?ypt78eSori+MwgplDhOlZ3L/fWxSMHcSEiegF4r5xljw/UAgZA77rexdRv0h?=
 =?us-ascii?Q?G1wv2kYr617J5prcVT2us7PB1UYE8QlmkcSOhl/DocZ70yCSVzEJWyEnFdGE?=
 =?us-ascii?Q?Ayrpyuf7G/Kfc7v9eztYqCuCBHhA0qfFkO/Tx68O3ejJJbixG3FJMsIavo9J?=
 =?us-ascii?Q?Y+OOED7auVCjhe3WGnTqtjoBunWxMGuaHUfYl2AOSbB2qWVWNkDbu155CW1a?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5uOYdfByeziR4VjdUhjLppiqcfbEMEvgzwPBh1kfONqmgr+YloXfLKTjRbeAgEaUnBsj+u3oRIhYs7bDNm3PJevXyB8c1loL9OBCs89V8S2eLg8i0RH33fWyxFEqHAJrUshgFXDW4Jk4492vpDrvrCvFtLvgW/6iycO2ggUNbV2ci/m8c7RflXvSp5blb/6qXaqBapcYaIrlkr3zIK1RTlmBXJPLTT9b2m8ur0kp+bZKZLF6SQ3Lrw4fX1FT+3vZ2eV2V7cBzY33NDXf2cobyK22Qo0Rqq4yHp+Hy6yIgJsECc1fVc3keMpdHOugcUwVIm1KhL1xojz5uHpqqNog8CotCRGMLyMvmUcKyG30WYUqFGiaVx2UFVAlBfCsPQPQJsnQaLEpQsrw5uZ20cedeZ18g//SI72ZE9UnYf65gShfz+sDQx8WxrK8gLC06LSwGMue0dXPXF4A1eh9FR9ixXwtfblpFtyjSxG8tVe/nhOXpGODDCBUOnaoYB06aQzgGla7DHQ2+DSjR9T9GfvqOIb1jP9xjdH3R6jWV19IHcMZ/DW0Sd7gvhbsQ1wDpTZwo0Zz/xfmNsIBQsUVwd4fnv9k+I3gKkWoK+6Wkz5BXNHh+x5Xe9WUf/3NWIGDROXQXVmmtaTTXKo0sC89XoT0YBryMcFieTVW2Gz+HYWLkaDLkF5R8kkG2In9/0WHs4rn9J8jRXs23g9h7X5A3++2AY5tUbclvK7i540TSRG44sNR064Eh5Kimw3C/FyF2rm6FS2R6N9CZ9MexYvqrbcFg6m0FEfu2AzfsJJSGA+ELc1Z1BPHDAwx5tzemo6NHZbZuNexqnRLn1qbEz8jXBXrPXeg8PC6bPtAjoUFATCkl2n5moIq+Ry+4YSYkQCa76nKHLzIkL1570+ciErpzvTSpQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abcf94c-f584-4e5e-5624-08dba04d66b1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2023 00:44:10.0781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LULOF07cmJtPranT4poCle280/QIrPQDWfqOl0bF29WFIItnMpH/8ByzETabTuUBw0YpUnhU2+7NtAfqNxt3OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_29,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308190005
X-Proofpoint-ORIG-GUID: yli1hODLcMkMSqqu70cvZhuk_cKqINMH
X-Proofpoint-GUID: yli1hODLcMkMSqqu70cvZhuk_cKqINMH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid setting the variables until necessary, and actually use the
variables where applicable.  Introducing a variable for the slots array
avoids spanning multiple lines.

Add the missing argument to the documentation.

Use the node type when setting the metadata instead of blindly assuming
the type.

Finally, add a trace point to the function for successful store.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 05d5db255c39..ee1ff0c59fd7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4106,6 +4106,7 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
 /*
  * mas_wr_append: Attempt to append
  * @wr_mas: the maple write state
+ * @new_end: The end of the node after the modification
  *
  * This is currently unsafe in rcu mode since the end of the node may be cached
  * by readers while the node contents may be updated which could result in
@@ -4114,42 +4115,46 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
  * Return: True if appended, false otherwise
  */
 static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
-				 unsigned char new_end)
+		unsigned char new_end)
 {
-	unsigned char end = wr_mas->node_end;
-	struct ma_state *mas = wr_mas->mas;
-	unsigned char node_pivots = mt_pivots[wr_mas->type];
+	struct ma_state *mas;
+	void __rcu **slots;
+	unsigned char end;
 
+	mas = wr_mas->mas;
 	if (mt_in_rcu(mas->tree))
 		return false;
 
 	if (mas->offset != wr_mas->node_end)
 		return false;
 
-	if (new_end < node_pivots) {
+	end = wr_mas->node_end;
+	if (mas->offset != end)
+		return false;
+
+	if (new_end < mt_pivots[wr_mas->type]) {
 		wr_mas->pivots[new_end] = wr_mas->pivots[end];
-		ma_set_meta(wr_mas->node, maple_leaf_64, 0, new_end);
+		ma_set_meta(wr_mas->node, wr_mas->type, 0, new_end);
 	}
 
-	if (new_end == wr_mas->node_end + 1) {
+	slots = wr_mas->slots;
+	if (new_end == end + 1) {
 		if (mas->last == wr_mas->r_max) {
 			/* Append to end of range */
-			rcu_assign_pointer(wr_mas->slots[new_end],
-					   wr_mas->entry);
+			rcu_assign_pointer(slots[new_end], wr_mas->entry);
 			wr_mas->pivots[end] = mas->index - 1;
 			mas->offset = new_end;
 		} else {
 			/* Append to start of range */
-			rcu_assign_pointer(wr_mas->slots[new_end],
-					   wr_mas->content);
+			rcu_assign_pointer(slots[new_end], wr_mas->content);
 			wr_mas->pivots[end] = mas->last;
-			rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
+			rcu_assign_pointer(slots[end], wr_mas->entry);
 		}
 	} else {
 		/* Append to the range without touching any boundaries. */
-		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->content);
+		rcu_assign_pointer(slots[new_end], wr_mas->content);
 		wr_mas->pivots[end + 1] = mas->last;
-		rcu_assign_pointer(wr_mas->slots[end + 1], wr_mas->entry);
+		rcu_assign_pointer(slots[end + 1], wr_mas->entry);
 		wr_mas->pivots[end] = mas->index - 1;
 		mas->offset = end + 1;
 	}
@@ -4157,6 +4162,7 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
 	if (!wr_mas->content || !wr_mas->entry)
 		mas_update_gap(mas);
 
+	trace_ma_write(__func__, mas, new_end, wr_mas->entry);
 	return  true;
 }
 
-- 
2.39.2

