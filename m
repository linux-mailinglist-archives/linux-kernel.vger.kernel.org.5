Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E8E7DE527
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344699AbjKARQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344562AbjKARQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:16:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81697BD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:16:51 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1GYoW2011191;
        Wed, 1 Nov 2023 17:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Zarp750TVlHsFqy+aCF+76v+a9/pzTdUI61HbGsIja4=;
 b=UEyaQArxB7hm37RvfLE46QbTpvSxcylvJ0YEv4OkY3vGhQh8Ltd1Ej0kKdQKEX9Dd1pf
 YbxXYSqw4XFW53Nr8v0KxsI6dobtlPz2H5xSB7lXeMejBBTDZ7yL3LZUxMB7jP9HL6PO
 63gts7JbGw/NPQuSdY3KhdtJzwD1+cDKr229AAFTuYIVmKPjdlAD66LmCuxHC3/9Ol7/
 KWMYlYAX/tZr3kqL/JzKQ7D+WvqpfYjBqvX8oAmSa0VHZQhHzpw59vevhbTnITxMrYmM
 QSIp3Cv/p1fLtt3fpnwjsApEl0wgpmC7TXNOmONwpDpX9p3mwBm/8yPGFPIsruAOpJ4l 8w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7byxsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1GVSup022547;
        Wed, 1 Nov 2023 17:16:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr7br7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIKRmP3L0a8xZ7b/FxmEYvoo+BrMADv9PPEA6+UHm2isFGFn+7ZPPDOmr4GGCs0qhxzi8ExsZAp14ur7OQsBIEFnxVLGDna3jMxA5JJKLjU/ePk1EY9zJe+TgJvVj0RzNh4bXIsM4WEewRc2YZo8kNXMGnd9/9reP/0G7m8oCCRom21iLa1DoTQmJVswjzVC/qCr7TkW972bRJM0Tz/vmJ8zL4EedYzMf4O7KQnkQNU3YHhcKaragVSCO1HGJLfGxomevkoZtoDG5uUhlRZAyJR63T1rpMxPTBUEdmAj8iQM/5jw1RNr/nXMoSVdoknM0oUhMikcjN70392cJJYtYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zarp750TVlHsFqy+aCF+76v+a9/pzTdUI61HbGsIja4=;
 b=ob0UGcc0wJhBZekAGCcDh196PzVErzpyIW19TvzT+N1E0PD7RgOSRFWXci4MwVOY+dGc0rDWR2EHMX5l92rLqWqdts9pQVG2khe2idWVrVZCCEoQcsd2AA2jaBiZvftMy+kI3z3qRKVSiDOid/zOLWLNCMsZRYjqe/4KjHhxJSWDRzI7Xb8QD6rU3YSVNJjxGX0KBojkVCe25oRkNH6PpZ76PReXpggmDpVNB1Da4LCXSPqW6m+ZFD0sJAQM/Pl/43pKysP7TG7djKSjciZxFKvB025aWIPjlFoA0yMYky16vXv+zFO/s8s+Toyf0yWqcTgUkCXKfeCKtdCQ8XINZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zarp750TVlHsFqy+aCF+76v+a9/pzTdUI61HbGsIja4=;
 b=TYRpq4i74w6HtiNcDY1SNWB9gZKLJZihUrQTBd2ZnfFQO/la+71rkvBbUr99uojiFfhrJsppi46TeYwTeea1Guo3CEKKeA2Y2znCyhmH/LEMPO8l4pOAfAOoAKU0V3QFeAC4fjkUhpn45KLpd2HxPDvz7MbB90Le75FQWCvC9RU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB7684.namprd10.prod.outlook.com (2603:10b6:806:38e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 1 Nov
 2023 17:16:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 17:16:40 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 02/12] maple_tree: Make mas_erase() more robust
Date:   Wed,  1 Nov 2023 13:16:19 -0400
Message-Id: <20231101171629.3612299-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
References: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0500.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6d2a9c-9aa2-4d0c-bdea-08dbdafe5007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ash5OAdfhWSD8TYTWpzY4xjYjpqv6fuRKQXkhr02udmvMSv0XUNLqSJe0nwtvxcfB/9JFXzjEeURNpNRzgRDvubE/PzisPGRfRAgH/cCGGEUNHHQ3JNXhOLjplI7D4A0nK/i0eoHzvK3ztVYFXE/MkeEFmBUnGxaTgVNEPybnVwHx0mwrxxZR1RLVCq6FO8Qvlg1PgNEKA4uA0W1SgZW94DGM76+ia2c2mNjc5ad1qADubwI5EVnU/cpiKimOglA7qlBf6VUlu64F81y+wUV9Sh8XX9Sbdeyw9zTPC0IK+X885esAuJ8vP6P+nvxuc2+bkJ96XaoinqxL0ERA/Ig4k6ea6iaZxMZp3DXV5fQ0oAUEp2jOjXTyC4nqXuQHq9Bm4FZFzk3MJCwlOx5qxPAaEfE1jLblQd5Ra7nOhD50SMDcyLEUcGU5FE6883G0FPd4MPHX5c2cV1JAkzLwjvhuDVp++0vVWmEtkjDl39v6lBGJCDzWt/NvoJpv1pyKeOFB9x8Y2x3tuf7xcJebAv0ZD1gnyMxmEaBh3boVv9GlFk+N9vUO1YIR7qcVsK0PSVk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6486002)(8936002)(2906002)(4326008)(41300700001)(4744005)(8676002)(5660300002)(66899024)(6666004)(6506007)(66476007)(107886003)(83380400001)(1076003)(2616005)(36756003)(26005)(6512007)(38100700002)(316002)(86362001)(478600001)(66556008)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3JPP0hnmCJmVVkybsYwzDbvJvhRIE1UuNeBys1v5NBMUuC+Oll2uB1I8JzgD?=
 =?us-ascii?Q?gXOe9AMEsNZ+zg9Y6aSWTaiw4EC6kuU59aQ9PDxNMbolR52sNcn68dgYZOww?=
 =?us-ascii?Q?bv5gq9WswORxsN8R8we20xxNTzZkvZpOUWIpOgPqwpsD70FtPNsteYE8Rq9o?=
 =?us-ascii?Q?FNutbpr4Wg7FmnNoO3AR6ljAKW2wzdD/ozNy0SDplFJQGLqqJqDOJ3e4P7Wq?=
 =?us-ascii?Q?gjkTsSd53HXJ7JlFOgxaCCMoM0NRQh3tUBlnEYjHn9JW0DHFwqF0RLjKsehC?=
 =?us-ascii?Q?YxxQME11lMhzihQ5686H9l0OIlvgnKIxtZ6r71RFrlfY3+YhlbitCDxvnFzn?=
 =?us-ascii?Q?2StihnY/weJJdFgLdElX98JjUTWVk/2bsi94WrOUyoTHFLodgGbZBc8jlN4P?=
 =?us-ascii?Q?Ehm9YgJn6pukZC5+w0R4lL6QT95jtstiC3C5szYfLKtA/auaDf9VPwrvTneB?=
 =?us-ascii?Q?V+sXVCNGRw7d5RMx61dE0LO7B7zEn9lf1um9S7LodRNkqnzInatIySyYPH/j?=
 =?us-ascii?Q?dOhiTa/II/32ZOAJMDl7e1jA725X3PIA7lVznsizkZedBY9fFtfDOAf+GOVd?=
 =?us-ascii?Q?zAd8OIWxpkooTOcfBIApBkDnsv+PUYNKHUZy5CbJ5gt6uMvEl8nCtmiag9yW?=
 =?us-ascii?Q?WFn4Cb2Murb0/7iiUXrT+6Wgw8wRWQRL+82ja2V2FaPd4nmRrKufWWfASnit?=
 =?us-ascii?Q?od7CkcQ25977XUi1XrTYAJifq80xXso8vV4ZpaKtEY9qzlpZY/4JDvs3qtxy?=
 =?us-ascii?Q?i7D9kaXB1PUVQ2WAMb/z1igHZki38wZj1tmB+aS5oPPcnlaGzak+YYySaa3/?=
 =?us-ascii?Q?iBnG+iBmvwXay31KXzTsUCzwO0LADkCVaYGNTbvQ0T2MNxCbX0pqWsDvoreU?=
 =?us-ascii?Q?+SJd4LLyxjGgXUtGODsK1Y5LWjrY6EJzfZb2KEMWTU6q064/e742q02gZQl6?=
 =?us-ascii?Q?lH+mhH+iliKrzYkI4tzQpO/bP5+LdSPviO10+FU/1z7BEAjap6W1AATGuJHv?=
 =?us-ascii?Q?HyOngr/n2GmAE8jTKfTSjdJCfFJjkQ0vj0SiB1IoEwSyv5RcRiU70QEzHuw0?=
 =?us-ascii?Q?PfdxMEqjVXCYEG9CzKoOYPLiKxpTQ64+sNDn2sJ/3JH0x+fexhImyPLneirx?=
 =?us-ascii?Q?1cBmbf2d+ELBKzsPN4uOMKYra1iIj5BHyX1h+ENA2hxeNV1k3JatdbLA5LEx?=
 =?us-ascii?Q?C2vMhIzPJBDVprurY8NBeEZ1od0HtMbPVan3KAD0RMZTdDLVK+00eiyuiBlr?=
 =?us-ascii?Q?4giY0Pup5KkVOxaa+DSJDT2kPTZP1tUqLa3WoKUmLdEdPN9VcwiC5wGhQXao?=
 =?us-ascii?Q?lNQoTtYjQtLDjSdjq1ERDvBJENTt5C5X7Q7tPVyA+r+7KhPscs8XfWbvsN53?=
 =?us-ascii?Q?AcJmIQCFg6rUs+fPrvu1eZObxgpTAVMiPixKqybs2i5NydNo2WRsLIfIpDJR?=
 =?us-ascii?Q?9uwE+nqydaAV3MQt4RlAbxOyU4O15G1fuPqvRzrpDVeGJj9aMJXkkup18UCb?=
 =?us-ascii?Q?/2W5AJGJXv/TR70JPVhnH1hgUAnp4ndzgV53q2Ud/I1pe3Za9ranAAEPhqoj?=
 =?us-ascii?Q?GibU+P+kPPtkHvhikztxqQ94fzQKhXI2KvlIPUYz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VbxbxRsEponxjTIDccFQ/k4qNCLVQDiOR5U6Hqx5t5JwUDPobjbVCbCSj2wgUsUTcUewGMLc6/FpGRZFLu8OtVEyQDn5cpxmOV7c05zLBc+ikHadbtbYW2BH9Ryy3gQzitmX3ewaRlo0Rngg+87qo7g61j3vH29lrg5N6ehxpGaUhIgaarJwHLb+vH9hF6xD+B3Mn3BtdE9q9o64AKeBMFJLS5OUirdVLV+fO6DyTKligkxxjqUD8OlGJXRVaeo+uao3MM5W5oh0GFA3GNVOudNChloLxWBH9T6Y9Sug75Jq+6JNhGNtYVWREfbB8Pcv2N+GIeGxbZHOP0V+/hvEuW8rop/sgI4tXbfTyusyuX4pzm/rO54pHhkVVrcil8PfD27yLJqIEiFTIhlyDIaEELvelqOxbHcvOPlWbRzg8u7p6ENc5jeChkI3Bj5S84ha2VbV4rUXa6xD7890I995OnGFy0kyVQzK3vX4C3EFJXzoiI9RYRW+dyXCnTcj26z+4J3sDhGtUpPb+zQGHYBK4RCG6pp26uj7DC+EqKMwsdFsrx1zGC7fDzIRUu/wNoQh3HhkUkQYVpOQah8utMtPmcEprdQHWjTyHdMPjon4bg1XPdDABBAm5H4CqJbPNAvZuDlVsRxJhQ/LgIpWacRzQI722SbW5DTD+nFieREpn/yoX7sdIjdXX/bsv4Oei5rwVMO2sOeBUWS12Rvl3kekQOLIj+zSWHdIxWwseawA6/ZZ8Ui1FSUSTtrOgPjOMmBeDLPHxmPP7Ctr7wk4t8LX7M6N9uHcc/nyu2KSBHHgBHoTA3VXzgbeom7pX74QCUmr8LDrLpv8hRbqOBCUbnEtRQ5tEYo2TRIflVEz6fbnrdSaSxNkitQqQKPher9VNMnB5Udi7BA81L4j5usV4bONeA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6d2a9c-9aa2-4d0c-bdea-08dbdafe5007
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 17:16:40.3679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bO8vUXqp8Y60B+ZwWLUA7WHgON74z6jcPj4u3gOmBUuir5MIlFYeRIPhgX2dJz8m9TUqSLgSHwWO6se0tiBDZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_15,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010134
X-Proofpoint-GUID: 6kGqw8JWo8JFCm603ROyXiBMqoodNANf
X-Proofpoint-ORIG-GUID: 6kGqw8JWo8JFCm603ROyXiBMqoodNANf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_erase() may not deal correctly with all maple states.  Make the
function more robust by ensuring the state is in one of the two
acceptable states.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 0fcbfa7e9942..b6b2d7031cae 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6161,7 +6161,7 @@ void *mas_erase(struct ma_state *mas)
 	void *entry;
 	MA_WR_STATE(wr_mas, mas, NULL);
 
-	if (mas_is_none(mas) || mas_is_paused(mas))
+	if (!mas_is_active(mas) || !mas_is_start(mas))
 		mas->node = MAS_START;
 
 	/* Retry unnecessary when holding the write lock. */
-- 
2.40.1

