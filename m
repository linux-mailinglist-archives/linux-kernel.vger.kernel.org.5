Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCC77BEB6D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378592AbjJIUR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378586AbjJIURW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:17:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9869B6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:17:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399EXxfB014979;
        Mon, 9 Oct 2023 20:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=4H5BtvqSc+0mOYg98doViY1SX0bCxITXGEXdoB6sLAM=;
 b=ujT23XKEa4nsStIg2waYnxP8CJbixv4PuMHqKhSQjZ2SsHsNWevgZVFPsaLtXMvaMBrO
 0DCoKZNKOGhdXMPXtsP+9G9+wCsyL7DEoYozcKx6AyiEqnnRYEdkgnegy/bQ/WvLfiP5
 78KvcIm19SbtD1/oieSlenAg2q0j8+FWK2Q68DRMuuE0iC9WdD5cwKUMOMMc+2hY5xi3
 Tt4KvUNsqBRLkHRYHjqC0bEgTEMdmGW0+zBWL8En+NzY1kqV3FXC3sxoCoiKxfmcZar9
 1FTrlvOLC+t8b+zy61np8EklQOYxKXnpOLNxYJ0bqNf0MYftriAYoMxd+eQZwbMwV7UI lQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx43kmbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 20:16:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 399JV8q5032145;
        Mon, 9 Oct 2023 20:16:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tmfhntnbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 20:16:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iH00Lwo+wX++A266L4wV3K3CXPgllYZ7hWgP6UswUMJJHt/4sQ9zDlrK2G+o5tynaYRWH+UyElx17rUS1iU7slC3+kh4qdUifcuhsfbgkV5OIb6E7KeGKCqzi4owaTo2J9FnSAqnclo2U0T3aeQOBLFlxyHWGGFIhAKeDgLvRqtfKDZvQO/0yjSt/jCIAh73pQVhdVHT0TXApFU1ZwFofUNZvmjrG/I9RP6NI1jKldgDA3VdiMBGE+j6HFjjmPZ8CohaZZ/Z6ZHiZQwGOyEFDNhxbL8UgirM+0zw/MFF6koiDPzD1MvmPuhPvctT0nrT3pxtjXvbvgNizDh1tuLNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4H5BtvqSc+0mOYg98doViY1SX0bCxITXGEXdoB6sLAM=;
 b=fMD707e2ZFbunYtQmMVJVw6l5F+IuQAgOCBuDrgIpc4nD6Q0PaFu/VKWd3H5d51JhSOvopFiC+sQRqnbjmBuxdfStZz9HEu1ddt9IXmE8qtzVnlHvkEIwgPorAuJFW7pZG3NdZwfL8XcKGSumX2RcnjjI/t0xMgTVCNBFceznLUEHCThbsl0hGZPQQ88SWZ5Lum9Q5d/aO0GuHpxIXZnyZ/oeXgdvFmMWjC6BHn0qWv2m4owAZ0CruNuCOB/ZDisyXfirriy7acBpC+n/8HysgF2luJr2tVnYSnoHv63db1e8r7JRuk74Wg3QechjCcR16zU++9t2YMX7/IoMmuIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H5BtvqSc+0mOYg98doViY1SX0bCxITXGEXdoB6sLAM=;
 b=TdLjyEH2KpbTeQX+VNaECaT5c16v8t/fcjb5HqUnKpZ25qFWFliTpf/L0JsSD+9zkxNSOSdFo+sCkgHicBKNQs8LbKlc2ECL5UDg8hdKo7+57dLo88ItsjrLUqu9n7gquEnv8NTeGVifG8fComXkD7lr0uMYBz932DF7b52v5Mw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA3PR10MB6998.namprd10.prod.outlook.com (2603:10b6:806:31c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Mon, 9 Oct
 2023 20:16:52 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e391:f2a1:a9d:967d]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e391:f2a1:a9d:967d%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 20:16:52 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        liam.howlett@oracle.com, zhangpeng.00@bytedance.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 2/3] maple_tree: use preallocations in mas_store_gfp()
Date:   Mon,  9 Oct 2023 13:16:38 -0700
Message-ID: <20231009201639.920512-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009201639.920512-1-sidhartha.kumar@oracle.com>
References: <20231009201639.920512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::31) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA3PR10MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de33596-c95f-406b-19d1-08dbc904accf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2P9cZnWrh8m/33tYCndTboE7nyH7P8HMx9DM0cVuHPui/3vpkP/a2CXGxUmsPZN/6UeHLbQjc/kRQ10q6ZbmFW1Oc578Rp9doohqUKAyIMAQATwrfkPKu6S9EHLQRYx/TPLTAlSH/YVPLfXITpGxAsffVQ039SKAz5ZvlXBSYAkyl2mYIlKLXgja1EJjRp2na2OCi8KuvdScikmysKo3CH3mcEywek4yNz00hR7f2bt8SrnQzObHjJQImkbVyYs2aQztJ988awdnsRV9nsNvqSR9wTbkL28n3yyZnimvE+fIwZGmhttJ4N4oDhK5v83SbXZy2+7rt1FK6Wv4Ut+SHD2hqwNQ9ViryQ0pioFMwnpblGuJiw/tedrkbRqw3DZMaaknyHB0lAhWNvanw3InLp2kpA8cbyrf35T8Q6Hk59f7MZzo1f402a72NL8QyQ0opLf4bQFE++oyxrTB0IMNfk3bpbtPKSPd0gXw2U1zOsydmNy3v1TElK43dq+YmRmiV5XWijIgOcNgdUYfQh1AnqTjpvHaw9HIWICmpkOsQpZdRaaxUvvwVy9Y5Gtk2CF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(86362001)(38100700002)(36756003)(6486002)(6512007)(2906002)(6666004)(478600001)(8936002)(44832011)(5660300002)(41300700001)(8676002)(6506007)(4326008)(107886003)(83380400001)(2616005)(1076003)(66946007)(66556008)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CYNtsjwMFytaiHutQniWb+QtCfJ8wzdZx3US3L+9n+zOXCMB9BZxeeYhOClT?=
 =?us-ascii?Q?8WEXudUUffy1vKcGf8R3saRqF9erdlPCJ3UAUglquNfJqFQKe1aOinrkHK72?=
 =?us-ascii?Q?eTZVoDM129nsCKz7URJdO76oADGwMc/x7GlE/l/ByHg4gGFfh3Zm//SyL1CY?=
 =?us-ascii?Q?nXN3RrmhmfWWoikOrVBocDi7xp5zEG9dUdluLpz/d3kRkBvlqC8drCNK3MBo?=
 =?us-ascii?Q?DPmFONbDO1LspmS32uJv8QH9dhyTqKlh+AUltzZyNhnpjHpr5r7lHFe/hIId?=
 =?us-ascii?Q?4foE+oqXPHAYoOWeD2LdBKja/2PPO7BVjgIOk3q+6rlfdTe2HUbfgjIoD3qc?=
 =?us-ascii?Q?k3Jgu75dT53MXkceYAskOU1NnVroxiFXfqyLXoYc2gHTeD3BkOjBLHYO9uq8?=
 =?us-ascii?Q?A1O/Q6OFloUIjBijqnvRCdakFyfCGIL9fTS4zl5MydsDN/WCGfu/Cfz8+MKo?=
 =?us-ascii?Q?8BZta7FXj/BDv4TbPOfqWwwbb9n7tCQ36BgqMifj50Z7Bc5fFo4UdMGrcv40?=
 =?us-ascii?Q?LO6vp3A5imeaWU7d9y5ulyDMDsdRC8SIDl348C/klY/0CkkCXXdmTjflgxer?=
 =?us-ascii?Q?slWzPyKs09Ub6iUBZQIx7ZrwlQ5IE5Z1hDW/YqNJyl2BvVVRfywJNyCThzND?=
 =?us-ascii?Q?aA7TUJnU04mCmUi+kZDWyEWVOz7svLzcWqZMXTO+YTErTlMaqZYgxCnQF5Jo?=
 =?us-ascii?Q?Hj0y4mwMNQ43OvvH0+bRrEFwIDOb+SFkPimv1sm6ZMW+LJBFAxABJOKJLch9?=
 =?us-ascii?Q?38mM83ISet7F39W0QYfC76y7sMASsRsbDCYRkRhP4ajsWNS8hhd2fJCxcqnZ?=
 =?us-ascii?Q?F/hhC7zP+SqEY5Ep2gh1KySSrF/qaxIxrs2cTa08DpFoCSGwMtHlXeo/cwve?=
 =?us-ascii?Q?H69TyfW3lnisjY3HoM/scefV0gs5WJuXERJCwNctlY22pRLrTElyy3pd1FET?=
 =?us-ascii?Q?2tJAWMq9oLjuCDaM7obmySv/trwLSmZNkrAO1DxxOGxm5jaX+RlOlHnJaSIG?=
 =?us-ascii?Q?9D+aoP8r5oDwrrm21GesccEzBZbvf8NkzZKh2cf2aQTE5YD4IDt+I/CFsw1t?=
 =?us-ascii?Q?lxKqgE8QGUtyI8rBqgSRsoCP1PJl2ti1ySefvP8DIFIGV3yMCh2bCU7abspe?=
 =?us-ascii?Q?2oOmZ2pMJMpLkrszwNKOkSqL41axZK0MF8vSMEjpfauULWOYHwSulmC3gCip?=
 =?us-ascii?Q?J6ywpSrDf45WtuGZlknsW/HkJ5TFeiD27fDCjM2Mb937OgPccJUhO3g2QNYa?=
 =?us-ascii?Q?/f8hDYmX5QG64g78wnPD9Ok5rN2X1kd7J35y56wKeGGn7GbwEtkElmf9vnHv?=
 =?us-ascii?Q?7AL9WSTuYFxwIeCjCU0boek5YAshl+hmcbZ4nccRrCrdi//lXY2mmXrYTsYs?=
 =?us-ascii?Q?RJXypaM3hzFgUDIIFzJAy9Z8JA7MjS/hRRa7HsC+ZONxfaapJa9rJ/1MWQxF?=
 =?us-ascii?Q?An89QW2ilVtqgXON5MZeOHdixmFtCrptj/ua3x6r3qn2FW2vNs9315X7rgcs?=
 =?us-ascii?Q?xXKflQAl6r6JqYrBwh3i8+Sz/iCR8q+8wYIZtQ7DMOUytOVEWrpB1VYfUmyp?=
 =?us-ascii?Q?Snr/J+6FTmIBdnpQhXQWt/VSoMBK3KxILpauoduuYncEq1ev3rkcbEQAMmP7?=
 =?us-ascii?Q?ONL5m993mflYb0aNA/H1rcE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?HyPEzU2lsgwdMlF983u/IDfS26yBDJmaALuor8kHa+geei2tN3v94MHV9Qcx?=
 =?us-ascii?Q?6CApT8s2PLT0H55yRR7NKRQu7bn04SraxmjuaqRr0q+m3WubrpLm2JTfae3p?=
 =?us-ascii?Q?UnnZZBop6BiUKzUz3moVp8S7A0jL+oGt8LNC2VFxCdxltlKUGDIRyheO9PHZ?=
 =?us-ascii?Q?hf9f6zdSJ5Iox6BGtR+ndP1l6BOCvnjsyVcCq1LmHt/AT8dqdaqKP7cyZ/fj?=
 =?us-ascii?Q?XJMiNtOkyj24lH7tDh1/w2Q+gm1E/4PBfRKse3WKKSzWoMeLIb2DilLvPWcN?=
 =?us-ascii?Q?7CJP+7TgRAzEvLiTx1rbxfMj+PgHVV1qaad5UjoLYB3QNuOuOJ5ZZ2dP79YW?=
 =?us-ascii?Q?SFhzdTe6A977dX5RzAm9Cqs+wVcm7LQSBQYTAfnY8eG2WAbGTxnc7AawMLBl?=
 =?us-ascii?Q?hg1PFmTEXYx2rxgTmLrkrvqDYRb95tA3ATH3HOcQovyY733nK3ppDEAXRLVE?=
 =?us-ascii?Q?fqfhO78TdLqGJIoGpJNYPSJSai87rptzYvKUUG/cg38oLqlgjpQ2CDSoIj5B?=
 =?us-ascii?Q?yEzU3fj3a41U99Nu5T8V6qsF+SfT+5dkcxY4/FV+qCjo2ZdpuUgJDMDFMeyT?=
 =?us-ascii?Q?/QUobwJDl4Fw4x1ye2FWIIyr/Vq/JbKpQKa81zrBBpZSVa04JXDNwDp54Yso?=
 =?us-ascii?Q?vIPBzX6M3g5l43+Xbauw09F2hiVUnvGXu/PkQDfw+a8pgULvUYmtm3Zjeygr?=
 =?us-ascii?Q?wvVME7PpBjMa+FVP047bHTsezntwKIRliR82TyiMeeoLh3RksQ/I18hbMhwX?=
 =?us-ascii?Q?o8cveC6fimAL4qvCSaaZRzN7NG7ouA0/BZhX7kR9o2fsU/nIUJI3CAMljKeJ?=
 =?us-ascii?Q?qDHgjSjieqtJ9roj2CI+4pIvXi95SWFnAiFeMyt6Pok7tMB3GKD6hD/qLRq3?=
 =?us-ascii?Q?Tgibw+Z8lpFhSk5uNHtYHRZ/V14DJaj7I3UDVHd9PcPx8g0+g4QKRe19U2e3?=
 =?us-ascii?Q?FPnoF6CvJuwgNrS7AGkdRg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de33596-c95f-406b-19d1-08dbc904accf
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 20:16:52.0423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znOV2H6GjDyY0wwOtwwh6BmvzYZdzEYKiATTmdXiw/tfSZ5aS8Vtqpwu6ubu85gb/EC0XqvFLsiyGprtXvpISkf+8vcoIES60Hljveo1Ab0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_18,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090163
X-Proofpoint-ORIG-GUID: kf9SUGuqoWXaUrzWB7HsuGtKv3iwpWjE
X-Proofpoint-GUID: kf9SUGuqoWXaUrzWB7HsuGtKv3iwpWjE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preallocate maple nodes before call to mas_wr_store_entry(). If a new
node is not needed, go directly to mas_wr_store_entry(), otherwise
allocate the needed nodes and set the MA_STATE_PREALLOC flag.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e239197a57fc..25ae66e585f4 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5478,17 +5478,33 @@ int mas_prealloc_calc(struct ma_wr_state *wr_mas)
 int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
+	int request;
 
 	mas_wr_store_setup(&wr_mas);
-	trace_ma_write(__func__, mas, 0, entry);
-retry:
+	wr_mas.content = mas_start(mas);
+
+	request = mas_prealloc_calc(&wr_mas);
+	if (!request)
+		goto store_entry;
+
+	mas_node_count_gfp(mas, request, gfp);
+	if (unlikely(mas_is_err(mas))) {
+		mas_set_alloc_req(mas, 0);
+		mas_destroy(mas);
+		mas_reset(mas);
+		return xa_err(mas->node);
+	}
+	mas->mas_flags |= MA_STATE_PREALLOC;
+
+store_entry:
 	mas_wr_store_entry(&wr_mas);
 	if (unlikely(mas_nomem(mas, gfp)))
-		goto retry;
+		goto store_entry;
 
 	if (unlikely(mas_is_err(mas)))
 		return xa_err(mas->node);
 
+	trace_ma_write(__func__, mas, 0, entry);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mas_store_gfp);
-- 
2.41.0

