Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1419C75FF22
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjGXSdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjGXSdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:33:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F23D170F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:32:55 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFOVlw006783;
        Mon, 24 Jul 2023 18:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=hrDmPpaMKx0ZmJlNZflnSRH9wchNm2l1B+6Yyris8W4=;
 b=0+XIjUj0OuyGdc29lc87dDzpcIF1NUsb6akJJcq2MkcjnHU8yg7VxT3Is9OaiEMHZLQ5
 feishh6wqRCnaqj8Vn9ti8rnOw9XlKsyeKj/wP8cHb++c3kOgaGCD3sBoJ1axWvX8bUn
 hJU3wAmwlB3ZncxkEdWajuhUqgB4Fz7KazukFhlwdtYaEJqifhpGfjnJeD+RPhKuhmAf
 B362ReRvO339knQoWuD3IYE+Hx8gMtJR7/ILJrkQFg1NAA/tzhaVKqPwDJUHt8ouEYCe
 dvbxYQbo1VtDZKBu8rsLiU5BSpQglaWvudp3s0pgFU4bH8fVHYnKJMWAB4VUiw7vmCK7 kg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061c3fut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OGuCBt035387;
        Mon, 24 Jul 2023 18:32:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3t3t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6pLww8I2wZjOjUEoFW5PPBus9/lW1HwD+0jXg4sUHkuHkBJIX20uuuVbXhyouEuEobystVrxI19JW/93LZxgytMe/Ksp1fuIcoKd010w7gKEux8Df80rsQTCt5LX1klK1hg68UXlL1ySozU8XlBYFatxIXMTDLPYlg4nPvsVOZqtsV4a5f47ws85QF+xpkktLOSObsZ6OqjGuhTbqN+QWWNwqteEsIGHbv6e7aoQ7yabnEztI9fNOmeOrhUeV+mQOAMgmLE/yEEgBh9w9/UqG8pjUi91AksAUDe532KW+ienHrgawshF7wNB7iP82//sanR26sLkFwpDRxPZxUySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrDmPpaMKx0ZmJlNZflnSRH9wchNm2l1B+6Yyris8W4=;
 b=X0MFo4hmHUyIL6+OvlnrazFLiumDia7QlQkazwahe5V0biPd45wWU71nLdWN+UtrGA5bn59qOKXa5RkfUEkM9EQ83Y6NzF9uep5igGIozqwYgwXWd8I9a9o0zN0jktq81fBaouWvElp0yCa5sHfTbkF27eGH2mv7E2wbhCTYafNpiownGU7IS3GODLE9tEz+G8VPYL2Gob0EWGRgjg7/maZYQG85znbScTdGe3Fs5UeooBtJq5Qtkec5lmwYISicWScPz5zVZ0bYJHsyzyLNdtlRo9oEVXxGl2t/2TqoU3tzsC2mlF7gWltv3rWBtxIcxio3DKCjYAz/cXzBuXnTfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrDmPpaMKx0ZmJlNZflnSRH9wchNm2l1B+6Yyris8W4=;
 b=HLbYd8VMnjJpOTr9AZncqaP90VY+TzDdPy4QO8s0HRFPWtE5CSLO2zL1XQMrATuSzmj+mkgMPrAdhS04xk9NxSffKY19pcodPeCGAUNoHmIR6q5KCxB5K6bO4WBOp3uxuxVZj3sPiw8NS004eIkblb76pc+PJw3KgAGrOYsOI9Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB6609.namprd10.prod.outlook.com (2603:10b6:930:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 18:32:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 18:32:42 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 10/15] mm: Set up vma iterator for vma_iter_prealloc() calls
Date:   Mon, 24 Jul 2023 14:31:52 -0400
Message-Id: <20230724183157.3939892-11-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:208:23d::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b3e78f-c814-40b8-87e5-08db8c745db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6JLpdxjVZYXmn4/7Lbg5i70sLy1VXH39iGBPhCiY/7QwQytOsTkgu2V60eg3Ayc9OzLnpc7i045iEUavMazjFWu6bsOiyALMIpndbijPpVDQZMCTaUDLNqi5J8oHHEpFrCzv5NTDahjAtQkC+f19I/q4UQxyPCcZIQ3DHwcPfOzUGAtvAxT7ePqXRh90TXTwENShrB7ntUrpu5vTDWtzAbEGICeOnqHdrgtd/+VVRqGvXEKUTLknHEzJmcpURGckApWKlH34jdCX2I4SkCfHCaKmkTF6/w6L+halnigDPrwtYUjtMCDxU10uCXP4NvhQ0ouqrmSopgz0RPYckW4ZN+bTNNDyFFcyxCQQ6jlwpCGOjAzqfCHkOi+caRdtGeCwSyrzS7Th0rsioH402zPutgTuOd02+Bfh8C/sIiulsXzOegl7mx9Y54WMHS8/+kU5MMexG9/di2oig+ZWxanEALeb+O/uigOz5O+RGrE4VCxmPcD36AGemilLKrs2mwqM7MMxzyxLrCzoM3TJMp9+BoCEUy2NxNjJsyKn867Dkl1hkhh5Ar27ssS+Y9U77dwE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(38100700002)(107886003)(2616005)(36756003)(83380400001)(8936002)(8676002)(5660300002)(478600001)(54906003)(66556008)(316002)(6916009)(4326008)(66946007)(41300700001)(1076003)(26005)(186003)(6506007)(6486002)(66476007)(6512007)(6666004)(2906002)(30864003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ahYxKku74OTnA1iZQOGhs6bq1VKr9HfwXki6ikKAvark44sscJ+70yUq35H3?=
 =?us-ascii?Q?xmGVLHGkk4gDQfRXSoKYxiH8r+buqC9QkODoTsKIjA/rzjpawQOU//rlyuEc?=
 =?us-ascii?Q?24K6ALWD0ucYaTorpVur9Sen8iny5yjK3qO4b+OQD4yPhIIUBzxNezNdqAsq?=
 =?us-ascii?Q?gOl9u3efEzk2AvDRYcXW7t6ayTXhuZ3B7fhrQndwPQSofyX6Mes1RTnNVBhE?=
 =?us-ascii?Q?e6dMhHn+B04ayyMBUUhgMAVq74e/HRh9RdKH/aB6c5XIr5D+y9Rhd9wllz2R?=
 =?us-ascii?Q?k4cgqHkW0TflIDs6drvWvBd0WbxInzYr3BUMqDIyrS3yX/bI4n/l4hkNq3tL?=
 =?us-ascii?Q?oet7RpqQNA6d1reD33ES1SOgmgMgMkicgRc3OkRAsCUQnv++yXtgKuwFuMDb?=
 =?us-ascii?Q?0YTvDdJKYVSjYTeOzHHW7MkkjtaYqImOb4oy/9+RX7bTSKEov1klfGFhyoAc?=
 =?us-ascii?Q?LecfhWPlsYKQdHJhIYSWlhhDOHqjemDIf29+KW3ux0VWv1JGj5bK9GUyV3XG?=
 =?us-ascii?Q?7YScZYVpCEd54hyZiBVQKqgt7mS+wC/QfhzPk6yUjpE4VbtbZf2gqAarcu3i?=
 =?us-ascii?Q?FJUKSy/TalUfQ/U2ABLL6xnLV51aRVD95C0VstdQq6s5b5hI4NSy2NwaAnZs?=
 =?us-ascii?Q?hAm+ATWVki/asyFpT5OW5L687irWdEQPiGyB7UDfR/ycf1qai3D71E7wDIhi?=
 =?us-ascii?Q?zSRy7KkuBhov1SzjbLPNm4PKWp4B4cidfIH6qhUIvxT+AQyA7azQ3pkfhszk?=
 =?us-ascii?Q?ApQpK5EjV/oj7OF8QenY+l5AzLZX5d9ruR++oeKghe79ilGZ0CG/9oLyMJVj?=
 =?us-ascii?Q?MwbXw+HDU0JJlqU6uyaotceqCKI2N9HD5MAndGeJDalPmnXbp61zoOdZ2d+S?=
 =?us-ascii?Q?3QT6U6jEmX0Y+XXeyVZ03c9SW4HR/gRDj6qLXGr085U4PydvQJHHnOwG3HK0?=
 =?us-ascii?Q?4ejDPHEOuzvFBHMOglzpvPfmeL5L/VRNiY0Q45sAr/Fzd/Z0DzAo9nA/cjRg?=
 =?us-ascii?Q?Or/6OE5zvxdOWSKevlsmYe2uC/WMeOHG6BvSPXw6bzicw2qCLBo2QxbGMw+h?=
 =?us-ascii?Q?LR6Q8ueHQux0VO6CJH4+aPsG0pG1D3CBgFeWfW74Mh1e84yACBuv5CyXgPWg?=
 =?us-ascii?Q?i1hOvTuLXm3MXNzYoriDng7gDJktAuvOhvtgJbHHx36utV2f2HVSoO7EXnOT?=
 =?us-ascii?Q?1Br8NJ/zTPZr4CxJFBDHaPrj1JFtgvBjWVl6nM6wtjSccTJ2PTmQF2Ry6oGo?=
 =?us-ascii?Q?8s69gaVv1jY5BwAha65qswIF8TdSsSRKi3O0TYOitjBOvbaWYJjg/IaLJlsa?=
 =?us-ascii?Q?SQti9wxwLR2Ptvua8PDiJv6upAo6H80Ca+7gCXzlZ09wWpEZ/9uGqv2DKAcA?=
 =?us-ascii?Q?SFG0RrPlVM+mz3Q1XoRm+SSU4jvD8E4Dpeo9nXygulYBssjwABaM6Bjbh45K?=
 =?us-ascii?Q?V4FzWgxjx79mLsPj4ksRfjrDWpo6W4QCIBmaFBUD238htIIO3FmRArn5b/DV?=
 =?us-ascii?Q?36NaXObdM+I3EbyRVHKGHssev4FKBZrswiOCB38Alf37t9kmlz+NGZTb4/X3?=
 =?us-ascii?Q?RaUFjqtR3WHkEfyPBvyGl0btO5LpAH0VEFnaHqkk78ZGN8qXLr4moSovR00F?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NDw89Hxiy5gYezYOsnkZWl3aA4KDyGyXOSghlgRMEfHE1fc+FOe/ecxF8XtZ/1hG1MEC8Z9HHlXyojcGCzou5uuyi+bMNOLFQNzuqy7OnhreItzdkbOOGlOjzcJrm9wI/ox6IGr/914tPPNM0gsgUEmY3nSs3/ch/6wJDGcjkNCvCaj8pIMgff2zM3fvT0r9JpsvuazSi49YLiNyAZdDPDtQmIZ/hgEsAj4FyCjBvaoStFFXVeqQ1dVCo10z7GEyk6rGAk5xIEUUicSMDTJ3XAut/O1+W1P6V+CzEmA6k2jeJtoVrev00/1J2vSJ2ABqPuywxddESocCeLqcNDtXx7AIymdZ+guryLWw8AYO04eXrj6dr6ImWk2Xkc18/h79nXa3IHyT/ZSvjLn9OJfnqAd/NOqIbkmQX9PczxaU86X7ua6xnfh6QhmQlOtq6+IhdGeEoxzJNEzdmChoMoxNLCBaYIhnvTZrFx5UFoMVDBme33FTaxVlZuovBlhg9qSR1ocJUBdVdkQ4SfZc+Nv5h9TYf3niB+NV8da1JK6j5ecDcPaveV7kJqcw8WKwuMrRWW3HnpZLtS1rMGfbuy40EgHQ1KGXZF+qPp9hw3sCBYeh7sL6753kkSvkrSWUCamee6sH5S8Eq5cyroLvDxI1QaGFHMOSJdpDdDX+bYPD1fteHfSgjsooBWaue3vQEOtDRaN+WhH46OaaCBo7B7rjf9WQRmkHYuuWzPaWz1A5El6JVXTLVOiA7YJ4794p+X46FNE7OISDNgcGs+CbcVQxT5gyrWcVnhpZMpGcaMSoJzWWEnaODM1pcFUef3fNMDumoJHCV+1mlSyHFiXBoEUWrUIkppf/AGOzj/hcMfaCQjzEBwvhr/Ny3K+fA3i0HzHcDir+vVS/MPEk3w2zf1mypbqVBPMYUvzCL84gPeCc5EQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b3e78f-c814-40b8-87e5-08db8c745db7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:32:42.1838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7DHeoqjFlMQeeCM3tCx7wLdfFodvIrEFtbboHM+96f3ClLHvT92IKyNKGD6PdNl4j0HD/wVThuPApcMAhYcgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240164
X-Proofpoint-ORIG-GUID: ipKwNxEytsIutRdz4NfKB9e0kWKBkEpY
X-Proofpoint-GUID: ipKwNxEytsIutRdz4NfKB9e0kWKBkEpY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the correct limits for vma_iter_prealloc() calls so that the maple
tree can be smarter about how many nodes are needed.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/exec.c     |  1 +
 mm/internal.h | 18 ++++++--------
 mm/mmap.c     | 69 +++++++++++++++++++++++++++++++--------------------
 mm/nommu.c    | 33 +++++++++++-------------
 4 files changed, 64 insertions(+), 57 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1a827d55ba94..0b9484358a49 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -701,6 +701,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 	if (vma != vma_next(&vmi))
 		return -EFAULT;
 
+	vma_iter_prev_range(&vmi);
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
diff --git a/mm/internal.h b/mm/internal.h
index 2f35c0ef7b7f..5a03bc4782a2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1052,23 +1052,21 @@ static inline void vma_iter_config(struct vma_iterator *vmi,
 /*
  * VMA Iterator functions shared between nommu and mmap
  */
-static inline int vma_iter_prealloc(struct vma_iterator *vmi)
+static inline int vma_iter_prealloc(struct vma_iterator *vmi,
+		struct vm_area_struct *vma)
 {
-	return mas_preallocate(&vmi->mas, NULL, GFP_KERNEL);
+	return mas_preallocate(&vmi->mas, vma, GFP_KERNEL);
 }
 
-static inline void vma_iter_clear(struct vma_iterator *vmi,
-				  unsigned long start, unsigned long end)
+static inline void vma_iter_clear(struct vma_iterator *vmi)
 {
-	mas_set_range(&vmi->mas, start, end - 1);
 	mas_store_prealloc(&vmi->mas, NULL);
 }
 
 static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
 			unsigned long start, unsigned long end, gfp_t gfp)
 {
-	vmi->mas.index = start;
-	vmi->mas.last = end - 1;
+	__mas_set_range(&vmi->mas, start, end - 1);
 	mas_store_gfp(&vmi->mas, NULL, gfp);
 	if (unlikely(mas_is_err(&vmi->mas)))
 		return -ENOMEM;
@@ -1105,8 +1103,7 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
 		vma_iter_invalidate(vmi);
 
-	vmi->mas.index = vma->vm_start;
-	vmi->mas.last = vma->vm_end - 1;
+	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
 	mas_store_prealloc(&vmi->mas, vma);
 }
 
@@ -1117,8 +1114,7 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
 		vma_iter_invalidate(vmi);
 
-	vmi->mas.index = vma->vm_start;
-	vmi->mas.last = vma->vm_end - 1;
+	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
 	mas_store_gfp(&vmi->mas, vma, gfp);
 	if (unlikely(mas_is_err(&vmi->mas)))
 		return -ENOMEM;
diff --git a/mm/mmap.c b/mm/mmap.c
index d09f11a9ad85..58f7b7038e4c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -397,7 +397,8 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 	VMA_ITERATOR(vmi, mm, 0);
 	struct address_space *mapping = NULL;
 
-	if (vma_iter_prealloc(&vmi))
+	vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
+	if (vma_iter_prealloc(&vmi, vma))
 		return -ENOMEM;
 
 	vma_iter_store(&vmi, vma);
@@ -648,19 +649,16 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Only handles expanding */
 	VM_WARN_ON(vma->vm_start < start || vma->vm_end > end);
 
-	if (vma_iter_prealloc(vmi))
+	/* Note: vma iterator must be pointing to 'start' */
+	vma_iter_config(vmi, start, end);
+	if (vma_iter_prealloc(vmi, vma))
 		goto nomem;
 
 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vma, start, end, 0);
-	/* VMA iterator points to previous, so set to start if necessary */
-	if (vma_iter_addr(vmi) != start)
-		vma_iter_set(vmi, start);
-
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma->vm_pgoff = pgoff;
-	/* Note: mas must be pointing to the expanding VMA */
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
@@ -686,19 +684,19 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	WARN_ON((vma->vm_start != start) && (vma->vm_end != end));
 
-	if (vma_iter_prealloc(vmi))
+	if (vma->vm_start < start)
+		vma_iter_config(vmi, vma->vm_start, start);
+	else
+		vma_iter_config(vmi, end, vma->vm_end);
+
+	if (vma_iter_prealloc(vmi, NULL))
 		return -ENOMEM;
 
 	init_vma_prep(&vp, vma);
 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vma, start, end, 0);
 
-	if (vma->vm_start < start)
-		vma_iter_clear(vmi, vma->vm_start, start);
-
-	if (vma->vm_end > end)
-		vma_iter_clear(vmi, end, vma->vm_end);
-
+	vma_iter_clear(vmi);
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma->vm_pgoff = pgoff;
@@ -972,7 +970,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (err)
 		return NULL;
 
-	if (vma_iter_prealloc(vmi))
+	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
+		vma_expanded = true;
+
+	if (vma_expanded) {
+		vma_iter_config(vmi, vma_start, vma_end);
+	} else {
+		vma_iter_config(vmi, adjust->vm_start + adj_start,
+				adjust->vm_end);
+	}
+
+	if (vma_iter_prealloc(vmi, vma))
 		return NULL;
 
 	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
@@ -981,8 +989,6 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 
 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_start);
-	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
-		vma_expanded = true;
 
 	vma->vm_start = vma_start;
 	vma->vm_end = vma_end;
@@ -1922,7 +1928,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	struct vm_area_struct *next;
 	unsigned long gap_addr;
 	int error = 0;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, address);
 
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
@@ -1947,6 +1953,10 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		/* Check that both stack segments have the same anon_vma? */
 	}
 
+	if (next)
+		mas_prev_range(&mas, address);
+
+	__mas_set_range(&mas, vma->vm_start, address - 1);
 	if (mas_preallocate(&mas, vma, GFP_KERNEL))
 		return -ENOMEM;
 
@@ -1992,7 +2002,6 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end = address;
 				/* Overwrite old entry in mtree. */
-				mas_set_range(&mas, vma->vm_start, address - 1);
 				mas_store_prealloc(&mas, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				spin_unlock(&mm->page_table_lock);
@@ -2037,6 +2046,10 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 			return -ENOMEM;
 	}
 
+	if (prev)
+		mas_next_range(&mas, vma->vm_start);
+
+	__mas_set_range(&mas, address, vma->vm_end - 1);
 	if (mas_preallocate(&mas, vma, GFP_KERNEL))
 		return -ENOMEM;
 
@@ -2083,7 +2096,6 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 				vma->vm_start = address;
 				vma->vm_pgoff -= grow;
 				/* Overwrite old entry in mtree. */
-				mas_set_range(&mas, address, vma->vm_end - 1);
 				mas_store_prealloc(&mas, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				spin_unlock(&mm->page_table_lock);
@@ -2324,10 +2336,6 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!new)
 		return -ENOMEM;
 
-	err = -ENOMEM;
-	if (vma_iter_prealloc(vmi))
-		goto out_free_vma;
-
 	if (new_below) {
 		new->vm_end = addr;
 	} else {
@@ -2335,6 +2343,11 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		new->vm_pgoff += ((addr - vma->vm_start) >> PAGE_SHIFT);
 	}
 
+	err = -ENOMEM;
+	vma_iter_config(vmi, new->vm_start, new->vm_end);
+	if (vma_iter_prealloc(vmi, new))
+		goto out_free_vma;
+
 	err = vma_dup_policy(vma, new);
 	if (err)
 		goto out_free_vmi;
@@ -2692,7 +2705,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma_iter_next_range(&vmi);
 	}
 
-
 	/* Actually expand, if possible */
 	if (vma &&
 	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
@@ -2789,7 +2801,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		goto close_and_free_vma;
 
 	error = -ENOMEM;
-	if (vma_iter_prealloc(&vmi))
+	if (vma_iter_prealloc(&vmi, vma))
 		goto close_and_free_vma;
 
 	/* Lock the VMA since it is modified after insertion into VMA tree */
@@ -3052,7 +3064,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (vma && vma->vm_end == addr && !vma_policy(vma) &&
 	    can_vma_merge_after(vma, flags, NULL, NULL,
 				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
-		if (vma_iter_prealloc(vmi))
+		vma_iter_config(vmi, vma->vm_start, addr + len);
+		if (vma_iter_prealloc(vmi, vma))
 			goto unacct_fail;
 
 		init_vma_prep(&vp, vma);
@@ -3067,6 +3080,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto out;
 	}
 
+	if (vma)
+		vma_iter_next_range(vmi);
 	/* create a vma struct for an anonymous mapping */
 	vma = vm_area_alloc(mm);
 	if (!vma)
diff --git a/mm/nommu.c b/mm/nommu.c
index 418cc0669c1f..1fe0ee239860 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -583,7 +583,8 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
 {
 	VMA_ITERATOR(vmi, vma->vm_mm, vma->vm_start);
 
-	if (vma_iter_prealloc(&vmi)) {
+	vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
+	if (vma_iter_prealloc(&vmi, vma)) {
 		pr_warn("Allocation of vma tree for process %d failed\n",
 		       current->pid);
 		return -ENOMEM;
@@ -591,7 +592,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
 	cleanup_vma_from_mm(vma);
 
 	/* remove from the MM's tree and list */
-	vma_iter_clear(&vmi, vma->vm_start, vma->vm_end);
+	vma_iter_clear(&vmi);
 	return 0;
 }
 /*
@@ -1054,9 +1055,6 @@ unsigned long do_mmap(struct file *file,
 	if (!vma)
 		goto error_getting_vma;
 
-	if (vma_iter_prealloc(&vmi))
-		goto error_vma_iter_prealloc;
-
 	region->vm_usage = 1;
 	region->vm_flags = vm_flags;
 	region->vm_pgoff = pgoff;
@@ -1198,6 +1196,10 @@ unsigned long do_mmap(struct file *file,
 
 share:
 	BUG_ON(!vma->vm_region);
+	vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
+	if (vma_iter_prealloc(&vmi, vma))
+		goto error_just_free;
+
 	setup_vma_to_mm(vma, current->mm);
 	current->mm->map_count++;
 	/* add the VMA to the tree */
@@ -1244,14 +1246,6 @@ unsigned long do_mmap(struct file *file,
 			len, current->pid);
 	show_mem();
 	return -ENOMEM;
-
-error_vma_iter_prealloc:
-	kmem_cache_free(vm_region_jar, region);
-	vm_area_free(vma);
-	pr_warn("Allocation of vma tree for process %d failed\n", current->pid);
-	show_mem();
-	return -ENOMEM;
-
 }
 
 unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
@@ -1336,12 +1330,6 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!new)
 		goto err_vma_dup;
 
-	if (vma_iter_prealloc(vmi)) {
-		pr_warn("Allocation of vma tree for process %d failed\n",
-			current->pid);
-		goto err_vmi_preallocate;
-	}
-
 	/* most fields are the same, copy all, and then fixup */
 	*region = *vma->vm_region;
 	new->vm_region = region;
@@ -1355,6 +1343,13 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		region->vm_pgoff = new->vm_pgoff += npages;
 	}
 
+	vma_iter_config(vmi, new->vm_start, new->vm_end);
+	if (vma_iter_prealloc(vmi, vma)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+			current->pid);
+		goto err_vmi_preallocate;
+	}
+
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
 
-- 
2.39.2

