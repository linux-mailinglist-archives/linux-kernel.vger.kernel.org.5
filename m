Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60AD75FF1A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjGXScn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGXScg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:32:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B9F10E0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:32:34 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFOIWQ005721;
        Mon, 24 Jul 2023 18:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=xzwL7C9F/ikW9y2u2TaUUhmNSNdpMJ6Rr6ICz4tQ5m4=;
 b=UYY4p8g3LWElABz6/IfntA0pm8TFPx7vhT7xUl+1gCBMRsLI+XliRIGh7ZxqYW61wSs2
 DIkWc1ZqQqUpvlc62h2d2G3SlaA12cvw5gP+RptOe6fT1YuzssJdL3GTtcY8HoKaguEP
 nT85+hQA0IfEeDjkoeGoOjU8NLjowYSQQfKJfrztjEiwmDtHmlMkl1O20l+YL5AtGRwA
 H2rbcif5kFylGkiJNdMv6ojSytp0B5FcVv9qk58Ft/nZTIidec0EZ4YUs/3jp4kRM3Rr
 Qg/hezO+r7CEFnAbW2UlKkuw6hYi/bHypywzlSXqOO1eCOUTEGDN5ySOskKk8+yz1yX5 Mw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061c3ftp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OH08Gg027537;
        Mon, 24 Jul 2023 18:32:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05ja2554-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuvW4ADrPyvzrMSvgRgbtrZw9bt66g7fDoWQsT+ch44sU2V6pHs4plmyoISIid3HM+4Hn6t4asBtAMSv/cCqUP5d1YhS4huEQbFnkuHPruPMqVyns4Rj6/zvYdfb+wOBaBbWxHMt40YsnIDFBV/4BbOfaohkRs3YjYFaWhjb1xcsIN8bMp6W0dmhD9jZPyakgOyNUvSjivXNnf5yNlnoJr8cKqGb+Ds8YCtylF4YGd3sS7yihihm061aH+f/afep4r/TtfNXXAVoTfpt0lZ2f5NFeV0hW26f/htjxAphDN92WjTgTG1Sf8EbQ2fi4VOmgqnLXeooO4UTOKKni3KnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzwL7C9F/ikW9y2u2TaUUhmNSNdpMJ6Rr6ICz4tQ5m4=;
 b=k03njCdZe6CR616e0E/308E0KbMt8UJ7312qwP6TlD6vsSg8plkGZQg6Cjzooq4W+s0jTit82dW5wyYmzAyW1jxxHgExaWCOtHXk9fcKurs6+EtdnHPdEl4XFQUVHxkK9E+GVbOIB8K1nvqFlkRqpsYaHVc8+1tBTB5p216sqCZAr4mRDVLBK5HICx5enUlxulu/AZH39j+7n2Eu+GkqUiy6RVmWdf+UNElpcl0JQJ4JAmF5XpTvuH/frLn3u/XPomzaM4x941biROwRzQvnf/RPpV1xiAcad1VMbzy5J31gjQZPmmb8tz+F723pVfsis9iyPhV6+tj7xPaO/w1DKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzwL7C9F/ikW9y2u2TaUUhmNSNdpMJ6Rr6ICz4tQ5m4=;
 b=fEOaeYKl+2l9IPp95aPDe/8/GJ3AUBDQ48zCZuCAh4FLOtjclukT7HDxE4KUcmYQ0U9J7+0X+FXE8+BHX2cNLZh+jhy3PrMU8vAXswIfzvmn9pSNq50GT9phKOPsfRsg62yZfIvRoDlXCQxKS7BvKaZa2b/Qebgxm2PnboJxfS0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB6654.namprd10.prod.outlook.com (2603:10b6:303:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Mon, 24 Jul
 2023 18:32:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 18:32:22 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 02/15] maple_tree: Add benchmarking for mas_prev()
Date:   Mon, 24 Jul 2023 14:31:44 -0400
Message-Id: <20230724183157.3939892-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::35) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: ad896ce2-2379-4646-a6fa-08db8c74521a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 10eV4IvLZAJlesy3wSrFk9CNIymU1jddPLGRhKnHtBCSSWq93Ug1wmCDz3fpRCMYtmAIlDeJRY2ferINMU2ocSzaTkaFNeTYGzGqxHxWryKTCmfcO4T4cVBT+ctz6qGcDoYP1tQ6NoZFe1pVQeT9ZiDzdoIFYXWocJt6Q2czJUCxWv0DnqJk+voiQipCrAXfqqfrcQou1jLlnhfX9TvkQTwoC4Dk+wmsdHQJWdXEWjBkkaUoa7GYG6jSIrLX2CpJeuwp/E5p5Iz0Y13K7Cdn1ImjxgpUSB2JqV1IAFFCQ2BGlG3tXcXd9cai4kh3sIf0u+wNU1AmIB/cFRygQbcWxP6HURjpaCuf7cyw5vO+qfsHdRkZGHBZdbkyyyyCW8n5J/CLkqpozwZJUpgRD0DYKQqGVh9fJQesTrlcf9mZX3Xfu/3tfFI+ld95SECUk45vh18u4DmYYSd8hj7BKpYS01ugcLjY9cCBQLwO5xdZFgrHfLGYeZNJCmKbz7mkvXJo8f6cRTHELNs2NIxhsYnKBQKgep4oer4dM9ona4X0OE4wrDL1FI3jN2lNFPHhyzBt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(2906002)(66946007)(66476007)(66556008)(6916009)(6666004)(478600001)(6486002)(6512007)(86362001)(54906003)(83380400001)(36756003)(186003)(2616005)(1076003)(107886003)(6506007)(38100700002)(26005)(4326008)(41300700001)(8936002)(8676002)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+7ks3pHfIlho1JdQvgx1aQQ2T/dg1bepDUR3PPUGMACTRSpckYGdvj0075fz?=
 =?us-ascii?Q?g/OY0XCIQqP/dnEHWe7HxfA5zXKtLBGjMSOUOmcZ2WtHH1oKJ5FQSNy7DyIi?=
 =?us-ascii?Q?iiQdTZuQeJdem0QPDvxzaF7u/YC/lD8BtcOXhavyubQgRcWtKo1PiIapuczq?=
 =?us-ascii?Q?2XCqQ7MCL4z2c290IuWNdgJPc/B3dzr6nRvdYIBg2rvxJG1lE8VmXUbix7Cr?=
 =?us-ascii?Q?u88v0E4ndc/YF65XAeXJelR+5y+ePllvt1Le9kBqsZF6TM2x6SGYQEmDb49d?=
 =?us-ascii?Q?5n/q1hPc02pPn0kTXHP/7DJOjAWxttk1iz5LXN/UcYYcmMlW6CZ1XLGv6Hec?=
 =?us-ascii?Q?lK+B++9CexzpfAJkf3hwm6Wlt53rzBIBbNbU33dFuKySaOM4FHzX3SgsmOIE?=
 =?us-ascii?Q?yMseAJqHeswiHD35nim3o3XKxNrOLWQD0xh36+q62vXaZW6qaTbgoAGRepIH?=
 =?us-ascii?Q?xQk5g2LaAavKdAXiK4kQIf/PonOjJax34rV/LfsEaU4/X2rCb8IF6dsPbz26?=
 =?us-ascii?Q?1qN3HC445sDPW4C0RBeWQJ7yg4J3m1WaKal2dMIruKbfR/0v7tPaWXNOP2M8?=
 =?us-ascii?Q?5dtuZkxOzlFoOIF/MjXdz8omItUiLydQFTYLrEHimGqVVD48lNiomNB2Tc1o?=
 =?us-ascii?Q?oF2r86iONpRd2AzinI6yRMKaPuHN2fbmC76A53Jsv+ArbTJPeLIJvHaF9cXu?=
 =?us-ascii?Q?aDyXslSzvZGlx/f1LnD00sZpSmgb1EUhjAOdLAb7HuYZaa0dQZgerfFCa+RP?=
 =?us-ascii?Q?kaHb+zqnNQwKzf4khFmfag7p4VYiYXaCSCpOl8LhXGZ7v4sk9vlJBDg3DA1p?=
 =?us-ascii?Q?KKjck8ZSStNH6VrzzJupx9n+h4jLdSkpZ6cmoaXZeQVyLv+x2oUb0lmQZAe7?=
 =?us-ascii?Q?Jmvo2kP7uXI3HhpHMwWQPIA8KUwpOHMeH+9lPtjb5sVs/pWsOR4jpeuVd8rW?=
 =?us-ascii?Q?FA4K+JOfBs8J08aRuJcVwWTkrZqKA/O8A7Xns8OVNIQwGMHgyciY42mC8wm9?=
 =?us-ascii?Q?XZ9wnKx8ONBwxfhf5nHlKJHgiqzaWtPao4caXz5QtB4L7DlyvKL7yO5hhHyg?=
 =?us-ascii?Q?VXtpnBxmUow4WPAFggskcR4rxtyrnnklekQUfTF+quw08Sii2hKnushi535l?=
 =?us-ascii?Q?OcfpVx5UYLBHzTOnhyu2M5y/8ccy/612N7/Tv5neW661RMrSgD+whY8I/hyd?=
 =?us-ascii?Q?Tu5USPbDYLm4FTC3SLii2wA3DqxdCTUpXqkTZwwpO86IGX3ZAbvN9y5Ixc7l?=
 =?us-ascii?Q?Qq9ScEzZbgCL08R6n+VUc9M/Z4Axn8W80gyYZsKLNcNDyZoFMkn/pUUQWFbN?=
 =?us-ascii?Q?rx3bp/VQM79tnasR4IvbbETMvAoWJkfC95gTSNoiVzvtBDLAF0/0oQQntQ2j?=
 =?us-ascii?Q?sEthuApyySVelHtI8BSGsfR74o3TKoYkAgc+POgNPfKLay71+7q69/rmv0go?=
 =?us-ascii?Q?fWLikIfiJTbOehAzA3UfpUrJNOHZWgbdogxrpTV8RSj94fkIrsiJBARzCT4T?=
 =?us-ascii?Q?0S/sJGVlRR1VkWYGf4y8MGjUDMEI3Yj7uf8usj7awPb1j2vnQ3tFtzGzxz+R?=
 =?us-ascii?Q?A2MW25DD1/5d3sKoaUaR4pKBbGmy11IgClfmJEqWA612qwlXIN3wDj+h8EYI?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hKTAKEhyg6wOaY03De4J59hb46rOZcSa5ldH1cJ6i3x+utEWtXs9iwYko3Imu6rPDw2J3QHpc9vkJeD1jMU8J+SSinSM8DB/apysgWKizrMSyyS+U5rwupw9/dFVpoz8c7Fb0MuOHN0r488mqJ/dF2ueMc+7O5aVE+98b6ciDDDjvcfC+DzG3rLrmXvo6pQ4EHIJBkDxWCwl8b4hxW5xB2T666XIAUk79nRq6U5HeZvnhHAh3LYRYoocQUmbVGYj++UsHtOCXZutiJf2Wzc5n6faXdC351I4R86XosLkJMTOko2kF5zq1ybRuvYz4K64aUuVse6a66wGhxdSwdeMktBVgRCYLiR2NlHLkt8kRaZM6IiOGaKDDsGcK88RhwO/rgkgFqzLjzCyQPSRWhkdU7kqbCt4ztI77VKncC2NC/UfQUSNai027XKEtworXP2fjgcl9mjhEyhBs63vUn6DfVoJzuj5o7vJvLu12bMsJfu8pduHadh53bQNUENevkIC0t9Zw4QI8suDhDnme8NQnUV9zGCfeM5rgt84b+kSpeBE4B7vf0boviX4qpmn5MLbNzZedLEIgIBNWpVhS/94yCAdmXqMcTzLn52oCPVP0/jQi776K4kgotbhm1PBpqNpCG5QULTKvOp1fIPRCk5ciaIvGofNONUOfAtCXt3xz14l69JOex+ZhBeoacnsHclpiidXneHUfBBBdqq7JHGPPt/AMXzKuTcs6Tt/XaW0o2m61cW4OXy1G6kGXYVQ0ZNx2Rp0w2LxIHAIYEw/SyyvTq6jk+EajoAMqJouJ3isJZ8snoWeOR/K4vI3+Toeew74eubTsMGRtpLxMRKwNHF6/abwzlgAnfNAxGw9UPvtTGgiwPbnB3UDW18B8543GTuPzOcgQn2awAccITCHREGaCCEKJPkTvTGfS+xV9Vy+CAQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad896ce2-2379-4646-a6fa-08db8c74521a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:32:22.5838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skygMwmPJNDgDy4mCCaD/QzzvpI2evEH+nSW1dIKBxENj6HXNe93nt417ZttmKNuj7W6HgJvysrpZofmItc9Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240164
X-Proofpoint-ORIG-GUID: jlev4soIQByIryVWud4_ys-YzQe5ESZo
X-Proofpoint-GUID: jlev4soIQByIryVWud4_ys-YzQe5ESZo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some benchmarking functions in testing for mas_prev().  This is
useful to ensure there are no regressions added during modifications.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 9c4cf5fb2b7f..0674aebd4423 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -45,6 +45,7 @@ atomic_t maple_tree_tests_passed;
 /* #define BENCH_MT_FOR_EACH */
 /* #define BENCH_FORK */
 /* #define BENCH_MAS_FOR_EACH */
+/* #define BENCH_MAS_PREV */
 
 #ifdef __KERNEL__
 #define mt_set_non_kernel(x)		do {} while (0)
@@ -1801,7 +1802,36 @@ static noinline void __init bench_mas_for_each(struct maple_tree *mt)
 
 }
 #endif
+#if defined(BENCH_MAS_PREV)
+static noinline void __init bench_mas_prev(struct maple_tree *mt)
+{
+	int i, count = 1000000;
+	unsigned long max = 2500;
+	void *entry;
+	MA_STATE(mas, mt, 0, 0);
+
+	for (i = 0; i < max; i += 5) {
+		int gap = 4;
+
+		if (i % 30 == 0)
+			gap = 3;
+		mtree_store_range(mt, i, i + gap, xa_mk_value(i), GFP_KERNEL);
+	}
+
+	rcu_read_lock();
+	for (i = 0; i < count; i++) {
+		unsigned long j = 2495;
+
+		mas_set(&mas, ULONG_MAX);
+		while ((entry = mas_prev(&mas, 0)) != NULL) {
+			MT_BUG_ON(mt, entry != xa_mk_value(j));
+			j -= 5;
+		}
+	}
+	rcu_read_unlock();
 
+}
+#endif
 /* check_forking - simulate the kernel forking sequence with the tree. */
 static noinline void __init check_forking(struct maple_tree *mt)
 {
@@ -3537,6 +3567,13 @@ static int __init maple_tree_seed(void)
 	mtree_destroy(&tree);
 	goto skip;
 #endif
+#if defined(BENCH_MAS_PREV)
+#define BENCH
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	bench_mas_prev(&tree);
+	mtree_destroy(&tree);
+	goto skip;
+#endif
 
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_iteration(&tree);
-- 
2.39.2

