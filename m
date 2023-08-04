Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EE977068E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjHDRBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjHDRA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:00:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2C749F0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:00:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374Ei3U8031787;
        Fri, 4 Aug 2023 17:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=+FX2dSTi4gdLWV9WMkxLANUNbJ9NL7dPJboXF2A/Zbo=;
 b=xn6DBMafeB1x+lfRrzT7+/6MT0H2fl1f27DhyInof7u9t8E0krZZTurCAFrJrDM/eWfO
 uPtm3FY3j42agfF5gptNChFCnkZyulZZ6QCxbTx5N2h/MgiikvEcmtwkkyUvDbwKCWT4
 TCY/nRjUSV3Xa1SBn26HsacmZ1bwiNsuDZ4LiLL3lEiS9+ymHuRATW77qhoSoU1LV/aF
 Lh06klQo4Hc8exh5ISwEkYHN6davLuY03Tn1bghlXwx13SzRRdxo18Bs3/CBEEpDkRbb
 xVdnuJU5Hp2rUZyRXyABoe4MMo159zFbLTszMOne7TmLkLQ7eFge/nZkYCZkD4YUyKy/ eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s79vbx9et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 17:00:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374FJgoX029618;
        Fri, 4 Aug 2023 17:00:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m29bngp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 17:00:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iV11Fx5Mx3I7s5MhB0JJZrs3TM8iRA2sq/BabKICYxx0pq8LeszxoPuVOk9JtLr+n9MciKy+pKVun9XCaKhRU1bzvwQzdvl14bdOLM1Zfw11/1X3Ob+rORTZ9UntULXEMa3PMssYAuVmeoSCnuO5Vg3/ie7Xlf2VGM+8cLPSnAfdk0JbQ4JP+DJ2yTvTuQSsrViUCBO11dqDVsSbTgF7KbG03eanWERUwgV2WyDi6QCYVyD1NtNUM2vV0aMw6xw5BoDx+y212jvjGHODhDFJEGcBkt4r7T0VKxHgDkBH9B335ffMpR8IM58l4a0L6s4kkKKdKS37PsemXdshaXqpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FX2dSTi4gdLWV9WMkxLANUNbJ9NL7dPJboXF2A/Zbo=;
 b=aldS8nkp/efxtZ5Und2PzaNbRnHGJ4MiuY7wPN7TMxzYD5C8f/+SWohCCL7Plh+BOxagZAT12KCal9GlA3IUPx59k9I2qRWTERs2rOQ1OWBuVMXlO9jqyPyrFB0nab4zepH5eYLgIaIGV2TOzgrbRjy8QYQkYpWZ3BMvm+UnSi9B0pKNFJyyWIKsrFj5Hx47IsZFnLAbuOBMaerDTKOOEl06i/3Pw8W88pSdRUJu71hxld8LozdoByMumeCi06zPC87dGCG1osyjVRbUAyRe4b3pBoeAa9xJ0s+c1OL/lazFdS8gbLcQdJ4AITCnEjTwT2ycEZHlW9R8fu1vcFVMRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FX2dSTi4gdLWV9WMkxLANUNbJ9NL7dPJboXF2A/Zbo=;
 b=XdI4kVBTxIkvEc1SWjy3RNJ1RETCKfL0WB2JkP8RiGyqFzBO6PZ2i6s92REY+Nu7XGOsCUUA0ZHSSq1piJeBjxF1oRtwls9PpI7+jCYE78vJDWcSr3zAJbYY2/Xr3LK9L6JwNli26DD/S22AvoNPNCCXh8ww/9vx60MFD0zCz/s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4939.namprd10.prod.outlook.com (2603:10b6:610:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 17:00:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 17:00:28 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 5/6] maple_tree: Change mas_adopt_children() parent usage
Date:   Fri,  4 Aug 2023 12:59:50 -0400
Message-Id: <20230804165951.2661157-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230804165951.2661157-1-Liam.Howlett@oracle.com>
References: <20230804165951.2661157-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0414.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 6127e6f2-a361-449d-471f-08db950c4dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kdbRdliBhZuprvvy/Bg/p+D/lK2ECMsIgcXW5EghNkhprQFJoPwMdaXDKw8d+dVSBr7Gsq0lJFmf+fHuFp9AC9PUavamTZrseDuRKlgdZVnXhUyNODTFiNtLJL9DdegchhmwhWXXddtDzrP1wwHy+0ESlJ8QMIohH1e13WtXU2/7529/rUQRanXs++BaiYY/1quLqaSjC9Fjzfdxn0xH8NmQdY0WUaQMC/cpzvBAHT76mmRGwR6/uDMCzAaTGDwl20dSX8JvlHmFn3Jfohiv1ftiRocb7hlFiiLvKjjMvLD5r8Rlpfj+T4Ae28y/El+JuFjtPsMxMt3GHZWxshsHx8jevRmvS8vStC9yO45Fpe4XSpXjywd6NMWETsFF3fMFCf3tcr0Cyci8uLR+hfId13vN6dWcuWx0GY0k9Vfz+rSluwslsO6lsRuhrL1npwPxH1JtCDk/dF3vF8OljrjNTLxDgkPhIY0WI+nctMJfsZo2Yv9kqDK+vfWLKVBqjIjM6F98d0QGN53SwhJNRbIeP5zglN0DJ0Y1JgGdtNIanZDWQ/jTrGffiMNFaj/2c7i4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(376002)(136003)(186006)(451199021)(1800799003)(6666004)(6486002)(6512007)(86362001)(6506007)(26005)(1076003)(107886003)(36756003)(2616005)(83380400001)(38100700002)(5660300002)(41300700001)(8936002)(8676002)(4326008)(6916009)(66476007)(2906002)(66556008)(66946007)(4744005)(316002)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PLIrrkQQqcwypLoGVzPMoQDqCLXIncDCchem/Her+9352AQ1miIPhxn8ezpL?=
 =?us-ascii?Q?33QOLN6pqOAdRVuS/rZOrnvn2CZZBPIQ37ElhCgbbMSSotp1aTZVthLAYROH?=
 =?us-ascii?Q?m9MYUXmTi/v6RKPUeM29EdZmD/S9lNwBs1Js4Ayksuy/s1EwPaGe0DbuXXQ4?=
 =?us-ascii?Q?v57Oa+bopTduuRLtctcCqfmngGqohOXHM3PCu4CQ4TOJllK9csTkn7xC9eEk?=
 =?us-ascii?Q?FL0hIKJDEad24JlNInQUqd1+Ni+4G6+Aez7m5pbY/bXy4TGuJ/Uzzyv4oLSr?=
 =?us-ascii?Q?hGv8BmD2dyyt2pmtrOSRch7Istdsk5TJiDn96wwS8e0zMRTLHIM4q5Mnzf5g?=
 =?us-ascii?Q?xEVUMGCn+XlfMjCZM6xfh0YYVrOBnQfgDXrjTYqjvzF3L+YQhjydWTBlhUUm?=
 =?us-ascii?Q?zzmy2OgLWBB59w0WQIa7i5TYgXhO8X4oJgQJU1RqusTEAbVrzgP+LheLE6sE?=
 =?us-ascii?Q?QMdKWJmmIxR801UibdtyDk8O0XQjj8FxbAw695fvAvEux74vE3aApEVvQIlA?=
 =?us-ascii?Q?/hUliiXFtjZ8yXuOdM2NEeaKdwND4l0Yv1DBGdkA0HpqdEvOdCADgk2zCj0Q?=
 =?us-ascii?Q?F7DMEKdWRcMuW8PALBqW9RDX8pv8MgqpKb7WyVkJnJ1+oAzZluihY4s9bq4Q?=
 =?us-ascii?Q?1uKJ9cTH2+s2iWAHLTcGD+6jlbJfUmIplw4msblY+tdt/+Itv6y8FBd0xQD6?=
 =?us-ascii?Q?bNUBvIVJ7Dk39HvwmdVuz1PKWkrqMFEGMLRHY0gX/bI7Jbz5JGo7AF6r8/nF?=
 =?us-ascii?Q?WROzyCVs9VlmlRzTxSvrKAcK2hNDIAwyEcce4pU+wL8P1u3XwcIUg48UL7RT?=
 =?us-ascii?Q?UU18pw0RLTTZthKfHCTltkdZatdbJMtcjwC301nBPO8B3B68gf25I2Zwj608?=
 =?us-ascii?Q?OMQ3SVd9YQCFK1YRwtlkbvDjNCQ8blLfG+Iae+NbfDM01/iDtxwMrYea9I73?=
 =?us-ascii?Q?0SiTKtS6u/nXsmBZjQUfp+jt1Qjka4ws1iuR+w2oxDRBkXDf14b79WI+QzQH?=
 =?us-ascii?Q?T2kPjOjaCHveOtidQOqaBKSTRf5D2H85K4JRADq1GSJUeWqam5vRL19RXUit?=
 =?us-ascii?Q?dk3ZSFghRnFHSApnjjWt7PXELgw3YiSIzdunJ7H/2IgiNWEvWoBQeoI1ntOS?=
 =?us-ascii?Q?Q1xHcJOCac0nyhEVpVv6XEvrKJ6qwNrvFi6iASG9TBo2xcWhu1UD0AYOrer4?=
 =?us-ascii?Q?u6YcAiJK4ONDzaPNVMiu0HdkPgklC43h88EfbSSQMU4Sx9Asqtkv6WbKkfO+?=
 =?us-ascii?Q?JShs1hRBJKmOOozb9/qyTEkBblINYJueQ9pMkUOn9f5rsWirV+uf3PHRECMU?=
 =?us-ascii?Q?LyEK68dUStctyndOsIuuibBSl5YvEN8xQel/UvZdxFbNIhPtIffP7evTsXct?=
 =?us-ascii?Q?p0abnQEYmJpBdEuvYkDBJTOVknshAbVgWodp23z1sYrWBvekqCl5Hf17PwCf?=
 =?us-ascii?Q?DkPLGBoz8IYogDmVH0btX6uUY4+yziUBbOvbfDdeAnkyK/kzeeH0bCHlllow?=
 =?us-ascii?Q?Niv6cZz5mqfLzO3rf3AUPDY6rjhTA5mleLGaYO2ABWgkMfcLrMJSEerY+4QF?=
 =?us-ascii?Q?9HPHNzhpLdA749KfSP62P7jWBf2GygQZASJUMIw1vysVcB2QB49I3fHEtcoY?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?auEpgGJ5aUqJhWt2U0/Mkn7BrbYAZF+RHNg9UkWaiA5ZXwGg48F5r9r51QTc?=
 =?us-ascii?Q?Mg71W0i+rxWXnXDB/JrWxAdji/pcS6gYdviFSLRZoj5r/09fjg3ozk9qQTk5?=
 =?us-ascii?Q?LwSJJ8X01cNDJEtX0QFEIQfNa3IUhGoWwAjCXvCmxvtd8Ai6zBZeuRUZPndM?=
 =?us-ascii?Q?+6I0BaGxlYffDA2Pq9PXQMIuBDbUPcFJvAsJ/my5q1Zjf/d/xUQYC8MfjAUv?=
 =?us-ascii?Q?E/MALrqUcBbf1G6iks8G7Q2ULPQBD4Sr0AjwuIZE2SXNqfLT+M6xPROoJaZL?=
 =?us-ascii?Q?lJJXC7s4ebV7xJIjOtq/V1DP9E8VV5r7sL/pfJ60aAiA0vGbfEKzoKbRqZs2?=
 =?us-ascii?Q?0LI8+mUIcNivSqNWpU+H3HmIo7s9ZkVSqw2I9GNHgB59L/CWdZgDFDE0vpKN?=
 =?us-ascii?Q?OviFLm9WCReaPoEqJj7c1OvDNctUoRfOOfK0yq4Gg/YakdmRfF2fvhk8qLvR?=
 =?us-ascii?Q?xHtAz3JQhEIsgw6IqTEa0w7gBT+7pHojflf+n1iWzDpJbFr3qE4jqes+NWEF?=
 =?us-ascii?Q?TSUBy0WixSTndHw0qj7Sm2jERuWBJEUq+GVRsMvuZEBZtvy/ojOKmtybcyid?=
 =?us-ascii?Q?VJDvNRqA3DNsyFN+PO6Da27rLmQzsr9F1eMwK1WODBexkpJwT6cNTzEyUdZt?=
 =?us-ascii?Q?0w6aIHyuM+AiaBo8J7dU50clXX6WWNZ2nObTV7iJXW1uqyLU8/j+XdEKAqk5?=
 =?us-ascii?Q?99mDrZKXntSQyrgbSzGFdA5PyYlUQSxpedFO/bXQ6txvW3ozDzBmVArzAlRM?=
 =?us-ascii?Q?6GcBS6orLhRbVXkLUjZVekvpy+0Y0tKESfXbxX2Z1MiOt0aZWios9hshWjHU?=
 =?us-ascii?Q?l3m40KlDym6BQH/BljJEVBwAeWFUWXMjhjwa1Zw5SU5K6EN22eE4RbhbSGsO?=
 =?us-ascii?Q?hMF3Yy523OjgiZTeGfkTpUjH/ayeINhlVOmdDf8R+hlULPTgHZtTI043lh0H?=
 =?us-ascii?Q?v5/9T65wz/T/rcSJ3CLjQeWzop7TN4E7Uk1ZUVzd5fE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6127e6f2-a361-449d-471f-08db950c4dbd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 17:00:28.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LWLMoZ0eeUWD5WnsyOgJ/QYUBMFaZ2XUzE/oN8ZuJE5HoDmr7Q2u06AUglyw9/dOXaqahkcPM/8JYrdkAMhXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4939
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_17,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040151
X-Proofpoint-GUID: xS_U-pDC2ZxjaOzu5KYktNiTOmdHJga7
X-Proofpoint-ORIG-GUID: xS_U-pDC2ZxjaOzu5KYktNiTOmdHJga7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All calls to mas_adopt_children() currently pass the parent as the node
in the maple state.  Allow for the parent pointer that is passed in to
be used instead.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index cf41e0dbb87b..8e94f5495a97 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1702,7 +1702,7 @@ static inline void mas_adopt_children(struct ma_state *mas,
 		struct maple_enode *parent)
 {
 	enum maple_type type = mte_node_type(parent);
-	struct maple_node *node = mas_mn(mas);
+	struct maple_node *node = mte_to_node(parent);
 	void __rcu **slots = ma_slots(node, type);
 	unsigned long *pivots = ma_pivots(node, type);
 	struct maple_enode *child;
-- 
2.39.2

