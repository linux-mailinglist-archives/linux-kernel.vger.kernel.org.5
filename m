Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1910875FF26
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjGXSeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjGXSdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:33:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA4A1FDE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:33:10 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFNxi0009810;
        Mon, 24 Jul 2023 18:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=xQJoMgoSWuoE1d/KIP+d/A+97DWByakHDeKsSva1Xvo=;
 b=CvXRE1cssKFolEP7d+4oyBzcVV80X5Fg3aBc5EMhesGVjKg039I1VJRkTE5wcnGzMYcQ
 nW5Gea5ksB3L5ufhN8ZxW2iJS6jcqpdOeFQi0l8rWd2sDpO5ntLI6Fu7uHy9c5rXOp95
 HT7LMWmMN4iTwpWN/JqeY7Smig0hpLY4YcSZ3TkQ4HSGLaiKfXXm94GRRE/OsC92u7a0
 9lcVUp+Wo31zNrnIqp28nowDu+mEl/NRukE7nwoy7qrt9zMsVg5GmuociSFQu1oFOgn2
 yBJjr1hwuCxt+yibSr+WYudXVPB5PJm6U+dk5ZMa6bj79IHzzlvN69BI+yNjrQnwTJQ6 vA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qtue77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OIIiB2000339;
        Mon, 24 Jul 2023 18:32:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j4a0cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhnabyaYtBMbJCWovRvUD6ksp1hzw5ymCPZ+VP1F6mIMno6L+1SF2lQZLxr1ge/LmH3DC0kSPyrMD6MZk14Kjslbfg/XlWgCsdNbN5V9QebEJUpynFtA4BjfmIiNqTjgmwU7Uxl0ClfivAA4eIxtDT6BPVFyIAEha9mdtc25HM344Cvx87695kQNZAaqEY5i0oswcmhXdwBqQcWYMNR7jfw7OSo8B3+HggyrOMNc3mtjt8m+qwSumRwhvOtk8Yl+8qsBPyEryD6EJE9Rp0daGDqsGDRNr2AVddMkwr64XUTbQUwfQNvWYYG8m6xh2molw5OO9DrboBLthiDuxN9Jvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQJoMgoSWuoE1d/KIP+d/A+97DWByakHDeKsSva1Xvo=;
 b=oWO0eF5iK7tinlviXgxzkEoInX3Mm/x4RnhfE/ZVpyFsMrtwoShtS/PLRp/dnLGzzZTQMiRKP+142j6O4+I8ldUNoc+fSBP7paIjKed8d0s/qUa9fxip59H8J/KdE8PB8NqG3ivKwPfSBwbn5UNOzmaPoEwBXsRDMq4azKvqVF0n7YCeAY1Pzc5TmJMELLJhOYczJrDWXLg+NuIBB4MqADogvIoLenjVYNrkGJx98eYzWRzIhQ45Jnl7u//o7twNdu3sw+dTnZ3nOqwrrwyr1Zd/3NIjZjHSHCPRG6pmFXVvyxn7bL0G6vDjwEZ0Xtbx8C43ZMB9SlCttVw3IfQtoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQJoMgoSWuoE1d/KIP+d/A+97DWByakHDeKsSva1Xvo=;
 b=TjVd04I9+aY4Qm4FI7X+O+YpMRu5wojUAkkzcqUOJQbwxyW/mnIJim81++wuAyRb68owE/cAsRVAMNZuMK3swgGTYaCNIymCQZ81VuIwT9DYbGRive6CCsEOn/aeTCBWJjRPP9fc/3oLJyLCLq4POU2En3XCYbCHiOqsjuW3Wk0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB6609.namprd10.prod.outlook.com (2603:10b6:930:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 18:32:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 18:32:51 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 14/15] maple_tree: Reduce resets during store setup
Date:   Mon, 24 Jul 2023 14:31:56 -0400
Message-Id: <20230724183157.3939892-15-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f5e988-5a6b-4980-93ac-08db8c74630d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wl/tsSZWlVRishQmZYWSfLHIN2SjARo3xUA+Q5yBwapdBliLjww6oiLKcP2BNil0kSXYDKvtvRvV7hpkOV12/64bXE0GY2OSeyMfG41yWX9tvHNF3w0THL/YwXY/aTqua2W3oBLH+KDvyUz0z30xNERtzzWmSF91r8n3QSQYAu9PedpFGoicIuvFfVjl5mzZy6k+NxKa1TR+hGuivZahbmEwkwTlNFXDukbmggYAuoJE/hWA3eHUZYzv/kvz3SbaKO3YuQ2FbGLHCiOA2j07aW5JJn57iSiCAJvafoM1oJTnDndHZm1KRuAnKDOPLxvgn4+0yuPCuw6fb1N5rFRvJWqEDBL4gtwLYKvGveJ9lkAvNaRGLURm+C4IvLDBb4FmCdKN0g9tNt/2ENyj6fCIpJklS8TeBvTPSwTdJmR5ljJHkOmyBGyVZOTQYUiQ5rq9MUbd6AvJ4X7j6+mOW/3W2fKQHPN5/cT09YGEk7LeVtYjw+dU4iUhg9NvoB82wicN29uzcjMmmlpMyW0HW5YMZDlU2dBGVJs0fMUrcGQeI2u0s7KBC5GRsc8AlXF7jC2+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(38100700002)(107886003)(2616005)(36756003)(83380400001)(8936002)(8676002)(5660300002)(478600001)(54906003)(66556008)(316002)(6916009)(4326008)(66946007)(41300700001)(1076003)(26005)(186003)(6506007)(6486002)(66476007)(6512007)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jmD2E6jyyKgNtGZBPpAq2C91jy1ixkqL74ZDpLzXWPfus4+XwYgEJLEUt92U?=
 =?us-ascii?Q?YscalFDj0TAlXL006Sfm+fAOzpL0ek0GXwvwoz9F8rcx/4FYJcTOayfyqEGa?=
 =?us-ascii?Q?TO0/7/2h/MRHAWIb1RcGyBuS5M17vGMXu0k4le86kr+VXEDXaJZIQBvTt7vA?=
 =?us-ascii?Q?6WgD4kvx8KsDbkFEqOdbo21gDYZbL83xzqIwDZRb4Uxjs2Rg7Xp4MnQeTO9v?=
 =?us-ascii?Q?4uhRK/ZcHUG4Fq91zniXUVrzgmvtFLN+vL/vwiQiuZkcOfXAnywrWdHFN7i0?=
 =?us-ascii?Q?2Gi1WGOBq+i8hx3CR/IDO2kdiTaRvU8+0TWu4+tpylGMAw7U/aiKv3cLGpPi?=
 =?us-ascii?Q?86ujdofnw2EjJxU5xsF1Ex98Pz6Yvru+dhwvGiVfGszpWrQqVad7+MBN5Web?=
 =?us-ascii?Q?SccutFCqIdy/gt+Rccdt1hj4/zTvuC2l4ThOdkenaTfPksOG6tkflxN+0Hg5?=
 =?us-ascii?Q?XzO4El6fLewqINedM+fddPNg6MAFU7h+hNJqfNV75DfLTU8UgJCy88oeTyWe?=
 =?us-ascii?Q?Y7YMy0ZotKtmZ8ocMgJP0Gg0Qin3UobYziThzyGNIIUQ6PM4JfvpmNdn6En4?=
 =?us-ascii?Q?uJjGatW3+AMkvCTn3lsv4+sxAsnpm5xQaoYK8C0x3xuhWHALp5lRDijSDkcM?=
 =?us-ascii?Q?DGbEc5cflSc5DATpxB+0v32+GylAd9Zt16aDbUjMzbr5DWwgEf6y9BNkS8q1?=
 =?us-ascii?Q?j4Na70YqRfrPtbSnQZE2KmCTBFsVz/cJCOupXr8vs6Bk73F14DdaVml4krMq?=
 =?us-ascii?Q?44TqdBVTl+X8yFNDuKMztD9vwvU6LVbQob4IUqTKSwMuaXrMVX6FKCtjNhFi?=
 =?us-ascii?Q?OPu5HJXdZpvqKl3LJg5vs9VNDrM0otQ75YftoK28qwbD3OlOpEP7F8xL2SmM?=
 =?us-ascii?Q?wP5/cWpT/Zm1Mq+LXh0Yla0pzg/16EQmMVq3KNi8f4KhScEEjWze4XtiQqmx?=
 =?us-ascii?Q?iSim6rxm9ru8V9hzZo62NJthVyH5KANsNEq6pzFgbYw1VeJHTZcSYaYygIQI?=
 =?us-ascii?Q?voY4GFA7XS5xHxJB3PWkcuBpkTW4iTHnqt4CU8hwA68H997wpYTYtI5ga8BX?=
 =?us-ascii?Q?SoPDhmaz7HBsF/Bd4H2Q1Qa7sfsW9QLWuxPC4rTrDd12Loifk+LKPXYULZV4?=
 =?us-ascii?Q?pjVDeCqrJWeYwtrJNjgXyD+Nlmu9XwDmyLH9kqhW51suOhYG47Oo/7xHk9NK?=
 =?us-ascii?Q?k5QyYph/WfCD6DtVhf4iLiJ0rz3iSX5znw6llSW+KLFDDetmsKcII0XhLdM8?=
 =?us-ascii?Q?6Gl0ZiRnRDosFDBFijXFM8nzt64wSQgSo+C30+JEfAksokoSUOQIS5DsOMtA?=
 =?us-ascii?Q?+0D7RIPj3MwsyyKYG/O0z/0QE6pnIHRGrFWaHDVdAuyvLyfkehiR+zJuEOZe?=
 =?us-ascii?Q?dnOh6y6Xfc3oR/o+tReLFaPk02JIOeeLTM39LILECerW925EzolnbUM3t24Q?=
 =?us-ascii?Q?lwf7X7rkRzgoyIY7OQ2JQJ2Jgfi4W2Kf+75io9G/AorUo0l66VOv11oU5IJe?=
 =?us-ascii?Q?VDM3NchFDurzbsAq+tgiX5bdXHsMYLTBeRivvXHsfa0m0qmgrEFjcU2ThyyX?=
 =?us-ascii?Q?iEjuPZjRd/bsexXSc2KhP7f1lAd7CIs0ar1eLe9Wv1Q+bUQaC6XmRGjeFdOc?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nk/Z+NYGJ+deeXyaFcvEXktt6XPYfGBazBXsIhkg3TwUV73TxukGtbAQrSc7PDq9svR3YSM8AVQhZhwUH8kM1PcS6OsdLOCxTmxUYZPyY5yXMSeWdcXggNZLvzHBHH3S9M3fmQ0wYRraPagsGwAAJYTZca9JGgQ2s6sNU6fXimN+qZEchqkQIOes8FCocd+EqnhWQSb2dY93MXh1vtYJw4o9jjU0G/0BUQQIfTurjYrkxbq0Wd+1z0++1I22058YFNESCu48ww3KPD1BGZ4Up1CuOPIDjLbQM21HkKPGQOSkw75BfUc1gJjX7VUnDBWFfaADQH1dW1b6Qan4ftQg108wvEOeg3g5wanCNEgjmcQfVCLv+OSYr4tmHbCu/dsLCUgKsxqYje41qo1HnSMJcw0Phgf2oEum0p6SW9lRys35p/LrTxXMF1YJDT9x9fWyTYQVuRKKfj/T0cWS8lCV6385wG6NQQOEufbf7SGeyRZpjJohl7yOniPhRD0aFJAq/wYSXMEWZn3/rmYQc0MJq7u91bO8l5o7CuQ2klM4336HXhY66WejIqAOB/NVdJIuQBk6YsEzpIIb9MOiPWAOKzE2LKYHDgDy1wcFxHIrPh9XzuPXnMbDpKoztxKa4S3m6bp1XOK70aFVyS/msZKMeQ4nipA8EIgoSbGxUwiAc/vcnUbQdlfwvFbMm/nKSUHxne6RDw0dUoCQCBlU6oJjMjirQZhYtqhdfBS7zkiZR/OtUj1Kjt9gaZ+gafjgTPUUKWLdT1Pzc2ovuisxw4kcIkoAyY//ET5VL25I+P4WDkdLyxjtv6+YNQw0+rHpX/wba6tSluTLxhixHbjfpeAcyE4wwqmmYUBIuv+4U5Yfc6hSSnhexlOdAnPeuq4aQCkUBxCiGPvttALT6J8oRp1gA59igZYggz7yke+m6SQjt2Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f5e988-5a6b-4980-93ac-08db8c74630d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:32:51.0099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zj+WtY2r4xMuyhbWvpo3kcyt/mxzwLBJX7HRYFcCAJKNmfX8+UVAjfd/m4W/N5Idzc2O7RNNW35D8TTAV4heQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240164
X-Proofpoint-ORIG-GUID: QeVSkXStqPUr25MpyJt72DlGxVDssZVS
X-Proofpoint-GUID: QeVSkXStqPUr25MpyJt72DlGxVDssZVS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_prealloc() may walk partially down the tree before finding that a
split or spanning store is needed.  When the write occurs, relax the
logic on resetting the walk so that partial walks will not restart, but
walks that have gone too far (a store that affects beyond the current
node) should be restarted.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4a111785360f..a3d602cfd030 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5424,19 +5424,34 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
 
 static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
 {
+	if (mas_is_start(wr_mas->mas))
+		return;
+
 	if (unlikely(mas_is_paused(wr_mas->mas)))
-		mas_reset(wr_mas->mas);
+		goto reset;
 
-	if (!mas_is_start(wr_mas->mas)) {
-		if (mas_is_none(wr_mas->mas)) {
-			mas_reset(wr_mas->mas);
-		} else {
-			wr_mas->r_max = wr_mas->mas->max;
-			wr_mas->type = mte_node_type(wr_mas->mas->node);
-			if (mas_is_span_wr(wr_mas))
-				mas_reset(wr_mas->mas);
-		}
-	}
+	if (unlikely(mas_is_none(wr_mas->mas)))
+		goto reset;
+
+	/*
+	 * A less strict version of mas_is_span_wr() where we allow spanning
+	 * writes within this node.  This is to stop partial walks in
+	 * mas_prealloc() from being reset.
+	 */
+	if (wr_mas->mas->last > wr_mas->mas->max)
+		goto reset;
+
+	if (wr_mas->entry)
+		return;
+
+	if (mte_is_leaf(wr_mas->mas->node) &&
+	    wr_mas->mas->last == wr_mas->mas->max)
+		goto reset;
+
+	return;
+
+reset:
+	mas_reset(wr_mas->mas);
 }
 
 /* Interface */
-- 
2.39.2

