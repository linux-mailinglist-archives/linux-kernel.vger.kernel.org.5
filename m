Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E149A75437E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjGNT43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbjGNT4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:56:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB6830CB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:56:16 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EDQUwj013553;
        Fri, 14 Jul 2023 19:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=HW0GS/XWDsRWyS4uR8KoW+GN3DBOkGA3uX40nMNHdnU=;
 b=PLyIAvXYE/VPCrvrVp3Gir6Y13dyWLPegMKYAgDrlbGVVoi90U7v1hc09qP/375BNxaX
 xtTMxETF4C3E63SORkYPMD/rHnXIrJaGZHq5FLmDWeOijvyImNc0v3tNj0S6IJUdRnVu
 /MwcTM/m0jWL6x14bt4tDBXmiD0Csi9sOAJCNXBzppS0SoflyFNGcQDK2we4EkkYjDUF
 XeJG9dhnzZekXJlfm6JX5XOpnWIkp5gu6Fenkozb8lhB6aq2/a/bmNVJXevO6M/AX2Tw
 kabulkHaTKZ3heOVmnkA3m7xUkhJ32RtoyneZMgEPlcjn3CdSh8n1q3TQhlFdhL1e+H6 rg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rtqgr25t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 19:56:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36EHxNTJ013788;
        Fri, 14 Jul 2023 19:56:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rtpvs5c64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 19:56:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoJTP9QFuKEB/tyj99lCzXJGH66GzpHQTL6gNyJKuJK9koBEZhmkpLiLEzFftPTjF8DokiY/HNURNYLg3p7XAsWU+0gQ9Ka3ZN3JPY1yLFueqEsOrl/6sAhpr1s2gXfqF1d0DAJdrX2ykiT7BhPte681IKUzR62d3GJBnlEJhObK4CkVL5D1SrUsSUMGzGFxqGvx+ITooXol6/OhjriztvMErmI71SIKCFgxWk0eht/sZpWMyfwtvVurCnF9kQKE/sbrih+xB+ZQN54xuJtHTBLLjCyoEAJ050pXgkDoUxCiezCgNAxEGaAfJ3E+jKnWye9ozGN0nbT8Z/DScr0jYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW0GS/XWDsRWyS4uR8KoW+GN3DBOkGA3uX40nMNHdnU=;
 b=i/Duo8g81uxTCOEie1xBWCVCEwFydfhAOeYa4K/S6KwVZ1TjbqoZ74OSexKDzqp8L/7xy7jxthTnBoy94JtoacnJr+/AAbHevZ53cVBFNHn9LrIKs621Nb8Tw/VxJQwLS1CX/t9IXlM7TBKbKQtdQZ8r56Q4xLNUBJOZoxe6+IIH0nMpO+bSfV7A7dIuDbmAqxEX4ctqroq7U3ocIlTIkDVM52ojVtxguk53sPWd3auzAQt2FV7eHNqN9lQsBzUvJXE61TMfJELy7hKaura95yaV+YwAhRm7r4wDWpa8+JX9w/VDURswUt2H2qOT6L6cTouBmG88bnAHH1aAuaMxPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW0GS/XWDsRWyS4uR8KoW+GN3DBOkGA3uX40nMNHdnU=;
 b=XDWu6ydK8lDl550QyP8PlbNSxxVOjdHszdz+nYvYVpRzms9KWVk4Tj6+S1On6sQ9Zd8gD9jTsVO8eNmOVB6dL+SZy4MSCmMXotpJ9dqy5r8zhxsB8DJ9d19GlJpZzV1WkZkEe9AbRXIas6k4S2biL/uqmM47MSBWKe7KXKvaEFE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB5922.namprd10.prod.outlook.com (2603:10b6:208:3d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 19:56:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 19:56:01 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 2/4] maple_tree: Relax lockdep checks for on-stack trees
Date:   Fri, 14 Jul 2023 15:55:49 -0400
Message-Id: <20230714195551.894800-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714195551.894800-1-Liam.Howlett@oracle.com>
References: <20230714195551.894800-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:208:239::33) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 7288b6ea-594f-4422-c9a0-08db84a459a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zp08PH3E/VWJ3D4K5zl84Db0N4Mv67jKFsZ/EXiwoQ8iSASQnqq2sKANGyQe1hPyE6OeHlNPkyoctLChiNPRk6Ui5ZsuiRhw7BkBkY2KO33geweWGTgOVU6pnwIAdCyMt+FCyo7Ow6InfnoSoiYzaUAAa6feA+/pGY4kcqoutYkOotObdclxqiUFDFUMMzVl5vGBUX+VtZ1ef1XFLHtNCDG5NVYJMYiwzOdN5XDD8TqUbFdFZYFPYYmR7hYSFjjJenptbSu92szHxuHQW0r2n2hYCCgEi0b4roWOQqDTS9qCkdFI6GUg8+fmjkTLS/sfNrvXnv6O9wMbGipC06DlduSs1omCmC27VlIRhgSHDNopQqDCunW5ymfb6I05AqxlGWqTfNKgCNABBfcmCaSTtPNZ0A7hL2oc/KHg/w2whaVLf4IBCBlQi6NxMFeKXXQS5yd0MFlFsFkW/G6IyegQ6GMA2PSMS2Rii5AYwo9qRkx0wnI6q0YJWSzDhBaBI3vjjDj3VYhI4oC1D+tIqNIfGKuzuVVAf4ltj/NgFpyZkpLRR4f0FN+hnyJZHn5JLFZb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(83380400001)(2906002)(4744005)(2616005)(6486002)(66476007)(66556008)(4326008)(6916009)(66946007)(316002)(6512007)(478600001)(1076003)(5660300002)(6666004)(54906003)(186003)(6506007)(41300700001)(26005)(107886003)(8676002)(8936002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PVhyNtbmNTXhi+zuxtXn5YgPMWpnBibtKjr1U6M9ICmhoDPsv2RIt6cqh2k3?=
 =?us-ascii?Q?Piv0SHhpoTjPilACC6MAQ0+LnoagACPTpExL86geNepMFi7FuYAeH6xRtH60?=
 =?us-ascii?Q?0Z5yTXTF7/sKpa6DktsBFFqA0D86CDEb/1w/iOXX4FnJIbPxIZTEL8EGhfwD?=
 =?us-ascii?Q?Z4TmRtPJpdf7NXqeMJE3MoZTaZQAB342Pgvc+X60whSo3jrudF7iLxzrInma?=
 =?us-ascii?Q?BcHvJ27oEYTl8wB8aj2wuf0yu83bHUDvb3GpHRxRTOKARZsT1HIBdmpre2d4?=
 =?us-ascii?Q?hZ7udspoN5su/DsrRYLrrOzzX+cRuyGdZ/GrKL3PNUygkpuCkR6rGdk8gyQy?=
 =?us-ascii?Q?JiWoWsdoQLMZ+GtNKWR9Z2+DxRDmbZptq4bQhak4e57ThRcIE3J8K7uBp9L6?=
 =?us-ascii?Q?0yuYo61u98fBo4W1StjWoWn9GhwyF5ycD9SCME3I9+igOTXLYs5mwIM0gh6f?=
 =?us-ascii?Q?HxAW3/4BDnEx/soFXECuQOATcGIc8QTEbJ7Gns8eW1557oNxxqGNPqoXNoqP?=
 =?us-ascii?Q?X1hxNMlXPAaUH3rMk+hvqiNt8u9q4VTAx/Lg7pbPRQSsefTkvzde54Y3cALk?=
 =?us-ascii?Q?pD2cMZ64wuhUOazb1diLn8LEM9I/3wj71YgaQuqHy57ehCNHGXUYiCWx48nw?=
 =?us-ascii?Q?MKPcSeGxX10v0zfL2Ky8wNBcusx+3mDdDodjf2BQuInCpIxEf89yWXjBJaho?=
 =?us-ascii?Q?h/zX76VfkhqEFS4RZzFMgTfuEewUJy/jv+3BYRQ3yTVTFwi3hpCmwlPjsKSy?=
 =?us-ascii?Q?zcHKQRm0qQu1BxKg90y6zWYDaj9H6G/DN4u72lI37Z4bMqAqfVGvQ3/Nu5mx?=
 =?us-ascii?Q?QSuEUN1pmxdwaOX8O9F3Nn8LEewDOBA7WQpGKQKh26qKjA/t5pDIQNbb/fUE?=
 =?us-ascii?Q?6SRinR0y+mx1rEjRT7t0A8ua672yKvtKR+ermyFPpnWzvRW3iloRbfiDeNBM?=
 =?us-ascii?Q?dEENsc0/RGGWPomcHG3Da6gySeTY4xvBU37Cz/hJSJ0klAoEDJiAH1GnW5BZ?=
 =?us-ascii?Q?NpqObAlkJYKnCOli3tf6oF8JbpZTRTwkAPBhbsVAH+N/CBO4iiBoi9A0tY08?=
 =?us-ascii?Q?P7KH1omEYq9WxBTaP3U5vrwqMYsu1/q0ffChx2B4GArGH+SNs/KJkJzR+bJ0?=
 =?us-ascii?Q?vbPg9UKRotbadBY7zVhz5JWTcQ02oRk20vlYkZt+fJMrmgIzaMhVw3Rrxlob?=
 =?us-ascii?Q?I74+nxmTmwo09fOYYGEJogj/rxMCm4djvZTb8TqXRgBWJD3c7PvU/B3s1mOm?=
 =?us-ascii?Q?IeawoxsfgRS9ppc8hwy3IgDUVbRfKBNJJ0QeEPZpfJgoVMBixK0cXU9tl9rQ?=
 =?us-ascii?Q?dwdAKrLAPO3Mecpz1+rYrwwvqGG36BmZzjFevG6Hr+F06xfu/7BZLISuYlCH?=
 =?us-ascii?Q?fSaWYFSrJyIfsAVyonQsKzix8kf2e7OWGnXoYUgcUjIHeWZdrgpzfCcRjqm8?=
 =?us-ascii?Q?lv6FGzrxlHuiJG5AIEBBgUtWoX66iv9d2/40XsJD6aj2NlKkVb74Dg5yfCLR?=
 =?us-ascii?Q?IOyICQHKmHfmy1I4PyrtJCGWnF3KtbBGvYce5kQtqbzNC9m4BvCa4KMCjx4X?=
 =?us-ascii?Q?JsHHIrwv0ypvnERaXcQdME1NDe0/JLwxcX07ffd2V+S/CQCR/DpYXl8MiarJ?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bo1EX5UxdoKYcdIvxqywcOt5lFJqvD7tl7Zm6Ofguffw3wSVHd4O0NGo+PWprgCcB8lDCYwu41BQn97sKVRu8PYBRlweabMhfRS9foeqBEXSxlYLVE6XZmjLburuMvAV/1jvta1dSadO91faDxsECSDu7bi/BW/KzhkUyjV6Tdr9DBGS2iQNJSwQz0A1bjfh/Om6dsZ0o/XSJhDKmmVNVDSXjJbtabFJOarb+7sifSSdnXGODQGuzlL3nPDX4rdfa+oOU0f4GiZknPoJuwD9fx5wEuvhbLNzX5rL+GAmI/+fRgiAAECKWzCwphRq7+7PsCcbrdUfIgYRNGgtSshRoBFCZqAER5V3sG9CyEwf/GN3UR4s1zWV9woB4KAkKM5/OON+/45piq+8KLDlSdCxccA457lG/jNIkCJqk7sto7HCgHUR9CwDO4gC8tA5xg7AN511XcEvvTtuwAXputgKwr1eRKUZBuxIxyeHDGzHrRRj4I2LxFm0RJ/bXG0xo5fJtlpxyWDw0WLNOKYNAbkvlJYFNnZSWtL2hGGbIlfeb/xPfxnHHBMjj07FPza4Yc7x6ifrr6KJUPQaIT8cC+rzpcSkW870TgpzSrl518UpwAOOIwuQp0wVpC2i9yuaW9bUssSpfeVvJmo3MPV1c7qgdifla+c7Ohkaz6X/nSMvWhUFrLrN1DRpbEF7flKYYGWY4QvSnIo5jpwtqci61aXvhzJR7X8S+UBSQlfMEvGZLRZx/wkFZIKIzXLJ8f1SGoAbieaibXg8yXOPr1jbfXDT2YdHudC4Ercs3cDWLbjRRGVwbt0ooUeNPVqM3ViFWuuovfMV3wEcA3q2zZn9oWY3cXdLsaO5Ka0gtDj870Ziqt8Eus5+VXH9nKGC2INeMVFpcvgI0fKAaBPc507H7wMSgA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7288b6ea-594f-4422-c9a0-08db84a459a3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 19:56:01.7576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ud0BJkLYuTVz1W5EUjP2QKRC1hJ+QgZh99coeVl7GXVZa+2sEYCD0OZSje4TWPhMljbsvrkj34J/T2N9ylAQhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5922
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_10,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140182
X-Proofpoint-ORIG-GUID: JWLOOZKZr3Ha4mt4m-O7W6o3L6uLhEWx
X-Proofpoint-GUID: JWLOOZKZr3Ha4mt4m-O7W6o3L6uLhEWx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support early release of the maple tree locks, do not lockdep check
the lock if it is set to NULL.  This is intended for the special case
on-stack use of tracking entries and not for general use.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 7769270b85e8..6618c1512886 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -182,7 +182,9 @@ enum maple_type {
 
 #ifdef CONFIG_LOCKDEP
 typedef struct lockdep_map *lockdep_map_p;
-#define mt_lock_is_held(mt)	lock_is_held(mt->ma_external_lock)
+#define mt_lock_is_held(mt)                                             \
+	(!(mt)->ma_external_lock || lock_is_held((mt)->ma_external_lock))
+
 #define mt_set_external_lock(mt, lock)					\
 	(mt)->ma_external_lock = &(lock)->dep_map
 #else
-- 
2.39.2

