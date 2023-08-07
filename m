Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB3C771CD9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjHGJGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjHGJGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:06:11 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80641E74;
        Mon,  7 Aug 2023 02:06:08 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3777qe09009643;
        Mon, 7 Aug 2023 02:05:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=1ZYe9p5uQpp/BnEztj
        QC2WK9L8Vdvm6gJ3xELUclIbk=; b=KNteAllZnsjg/okRngtb3dy/gFnvuvFb6C
        LvOnCekapyLPUfCp++r2ziESls08zEIVh/yb7GAjNOT9Gg6qF+YEQTsW8cavpreA
        o1mDr+aXf3FB2BvfOPesXgWxUZTAxw8R2M3y5RqrW8jX8/eQ0aCBWLAuVqFK2iE5
        MBYO5j1Dm7002wKgZ0ycKEdBOy827aIT31jeYj6hZZ4UBwkp/MdGxhJYkAQLRmzl
        R99Jw3a9XK+Bp9nqjTibMgFecw6Va5fI8QJxu/OCG5wKC/9LO+7T5vzKYP9quATw
        83jQccjn9qzS322pRMCyt4m5OsEcog/kQohgYZBKi0v8NiXfB2MA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s9hq09ard-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 02:05:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j++u01FQpD9Arj6O+HTPGEBmCsCLyy35aA3MiOO07fOUUEAkMCARA49hMMah3w4eDF+pxtdOiNwPQYKpMNKFTiMmcSXBHNyxZ9RucYdOHbicxv67YXfWtHZfdFX4U+mssJqn3Fge4Or9uM21ZpjLwZkZ/ZYl8M8cywHsls7cDZayvlUyBQH3MdgUcHZxj2HUrlCnQz1LG6UpRNMUNLWtRUDHVR8tLQ6XP6OsEdH5AKSGoapFiKzsymKZcPzA7DZ9H0ECCdOzYj9WmmZY9lRySAjE6bmLtkN/nPHf0NJdhRys1qH4avoqVtotSqkr9tftVX47tlxfngzq6xZq8QlZ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZYe9p5uQpp/BnEztjQC2WK9L8Vdvm6gJ3xELUclIbk=;
 b=WjI15myRTJCISyO8hyQrGuR0z9eBQFJtcP0VaiduHDqoCcjCjMq+U/uwVett/nxyiwPb0PKlpOmPCOdYNCJ/n4j/E9lrSDFcoV2DK8dfkHgyid00K3LT2DVjCN7yCccNpg7bNw/aVVCMtQ8qg+tfcQ1kSJHxG7httSQe2bM6Z24g6g12WR0BYWMRnK5eWLpN1zjbvcKL5Eyvg6Nq3YhprUsTX9+C32ANckagseYdG0e4bYKr7KAZztGOx1nKlj7n+FUoVdZuGnV++E0xhKOtNwEvVXnJ+9U5NvMYo2xHX0gL0KQ1y5REWiyaJoJpKxjLEI/Y/eDrqEhTrZR5jqEqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH8PR11MB6949.namprd11.prod.outlook.com (2603:10b6:510:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 09:05:53 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 09:05:53 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     slongerbeam@gmail.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: ov5640: Fix a memory leak when ov5640_probe fails
Date:   Mon,  7 Aug 2023 17:05:35 +0800
Message-Id: <20230807090535.575164-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH8PR11MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: abe6e74e-5c23-40e0-41a0-08db97258090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6DjyLp6+n2Rhv+zPIpz3mw1oPsVySLQOst8F4TpiYO3Fxw7/KhAp3+C/nvEI7t8o/kLpeScBGtg4HDlYaIx7TDkmGT+ub2N2OlwILKFsosVyLyrJ40qMwc4e71b2SxKayxMnHKQn16z5otTg1wZ/7EZlqMyLpELL85g5GMEsOaAguyonKxpocUDnEsxBBJY51/F8QozU6ppCmnGj7fLjBr8B0d4O3Iwc/t36meWlSAYkFRoz1qodb2t+oF5uqXNXt/+6YF/nBm3S5YTi85E9uo9GEts0WvAst7EXY3Mgp7cbPIfp9EfkhydeIpvPe3czi+H59Q97oJuGToJuAHWL6YeU09JMLYAh5RxPGPHANmi6gqO5X6j9VUhtZL3j+A5VyXqJPU07RzOPe072dsiXkwVNNKyW28LuP3JtrcjWGqpr6C9ng9ROLjgh1SU/1krUrZLEozVkWqelLdyHFE7+Vn1bPbz0yTiFREs8DNp3H5flze50hg2EplNg5CRojv7FQsfowb445prU0EPtzaQlq3PlL9i3APwMHoZ2sVbdN1JQ1EtVNZNCz/N7KDhUYYf8+uUhY4pda/75gvEXUPimdOs2zbJsTE5CIsN2noL9j+NvCCEWCZK3jxlNFuYaEbUKfEK7NtVsp19opvW/Wk/K+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(136003)(366004)(346002)(396003)(451199021)(186006)(1800799003)(2906002)(4326008)(66556008)(66476007)(66946007)(52116002)(6486002)(6666004)(83380400001)(5660300002)(44832011)(41300700001)(8936002)(316002)(8676002)(38350700002)(38100700002)(2616005)(478600001)(36756003)(26005)(6506007)(1076003)(86362001)(6512007)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QzRHt1QzPASsBeotbfcnnyBqDAomaSQHR2V5BbgHQwHM3QMy32uVgmHiRJ1b?=
 =?us-ascii?Q?l5sOZVA2yn6z3zYc86Y+3ytjpdMMAwmpK3xH0bWISXQbtHf64nEC7PZkK40s?=
 =?us-ascii?Q?1Dyu47k9GNocso95jATXUz+AZyZ83iYn7j8Z59fdQNewLly7Gfo0yMeg1CS+?=
 =?us-ascii?Q?AXJc9QbpkvkgdaTwbnw36p1mVUWZW4BH6JQ3gHwx7ToRwqPngvHKy7x7+uKT?=
 =?us-ascii?Q?kmeeixqlmo3BRed8Cuk5W53Fj5O1f/skaymGw9A9WlEZIhJeaNIz1EUSgA1O?=
 =?us-ascii?Q?mL/Fis+kHkjFp4DlnIw1lMh+OKNEj9c6pxGygFFgyBcBOHnn3aJ6y0UpQkum?=
 =?us-ascii?Q?o/kqJUVpe5CIkQHHpCzxvhsMIZzd2TZha7vp63GGBLbDLyPbSzb9AvSEf2XM?=
 =?us-ascii?Q?arZiX70qitZhK147iqP9/qeybKtQp5bZenJMHIBvGAgE2oZ+EJgDIJ61F9Ty?=
 =?us-ascii?Q?fT1XjDU7YiMramHwbmp2h3WuSRVi+wWKp15U4Y6NQz2BAPbz54sQSEZlbt6d?=
 =?us-ascii?Q?L4w1a5qABaIkzJbht88/5+Re0WV8++X755fzyCpvJ870Kn3Bwz2UNH8MxA4Z?=
 =?us-ascii?Q?GHps5oWG8Bz7+vmDcEJSBpy3KD58+STG5T8WCXaaBfOSno3FtBDHhIAn5bfc?=
 =?us-ascii?Q?G60svCAXqGGBK9JVrS4u2dOYpuNndaXpuhApiRKeWxc633lZidyGycpM5vws?=
 =?us-ascii?Q?aC3J7Urj5YoNfaAlekIWjxRGqfEsREtppY7pZ6tcnk7HL9uAvs8Cd2K8cuBD?=
 =?us-ascii?Q?TWnvgi+kxIXjVzekl7HIY0tzHJwXFSDNr4WfvaLX26in8HRrFnixdtSApRAv?=
 =?us-ascii?Q?83JY6YVTtR2lwJc6L5pA2hVhcX2LHuyEmWo02qEdKecevhoiQMyuYaCR8vVM?=
 =?us-ascii?Q?0fyWa8F5I5VELbkLZ10eX9U39Kl3eytvOA6AaGRQiyXzpadmO6HVIHKKl9Ck?=
 =?us-ascii?Q?Q78AOhLjELIuVxl0sy3/SjjFbAVzpt++Tn8SN5pDaCETHEWYudT+O7czVkVg?=
 =?us-ascii?Q?qYQnwWDGNniKIL4iD6/o445Mg3TySSs64ahk/7LAfVlEgLQJ1JevipkX66R1?=
 =?us-ascii?Q?Ean9jd9QYt5+1DZhYWu7jbZ93JWYqpUEF+/FUNVQ2DEDLO74RbXNv8IItHBu?=
 =?us-ascii?Q?oWoyg0IRr30c4/2yPH5dAJ55Ghinmpllu3j1TAlll3PDeAoOgV3pRTm/ZPR4?=
 =?us-ascii?Q?F1I9XrMS9pPhuk1VV1KbYQ9fuO576LhHQU6sE/qnORWVotuo1UUS1GDwlQ2T?=
 =?us-ascii?Q?U19cnNU14nxW/0crmm/zZClfCqjjL7vsM32g2cDemXOyoZFogqTBrj9lA7Pd?=
 =?us-ascii?Q?nhITYUMtRyd1zKZ47YgIGiy8W1FKthyETsE7nKroDFeEaQzYF96zH6EAf8Yu?=
 =?us-ascii?Q?YUF7R1yYFTpD5RZreaIk09pn1PmYsHrHiuuUo/dnrzZWwigE//ld1OBy6Xwq?=
 =?us-ascii?Q?/cmvfIswYYk1GEVKN6SGna3TOEPvzUwcJSsQ7DRd68OWw7iAuE5xYgu0E7kC?=
 =?us-ascii?Q?D4ZgCoaOpNT27pkNYRQiPHFh7wpyX1MOieG1NC/CZ8X2MblHlAbtYv8dXs1D?=
 =?us-ascii?Q?cE48JvhuBsXGFoF0B1ajBV/9q5qK2EnZXpVb4cNpPDEtspk6PKUmDxw040Ty?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe6e74e-5c23-40e0-41a0-08db97258090
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 09:05:53.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNIGSqapiewErXKgPjpjYjwpnIzbh4o4++t1BXSX0LbCtd9HnmPheVIC9nZecd/ZrFr5stBsQpBqyPBsLuZnNg32SsAUddIP4ioawE3toDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6949
X-Proofpoint-ORIG-GUID: 0Tozk6j1uWOAcf6_Fbkhy4tlWFaTau_v
X-Proofpoint-GUID: 0Tozk6j1uWOAcf6_Fbkhy4tlWFaTau_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_08,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 spamscore=0 clxscore=1011 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxlogscore=978 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2306200000
 definitions=main-2308070084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sensor->ctrls.handler is initialized in ov5640_init_controls(),
so when the sensor is not connected and ov5640_sensor_resume()
fails, sensor->ctrls.handler should be released, otherwise a
memory leak will be detected:

unreferenced object 0xc674ca80 (size 64):
   comm "swapper/0", pid 1, jiffies 4294938337 (age 204.880s)
   hex dump (first 32 bytes):
     80 55 75 c6 80 54 75 c6 00 55 75 c6 80 52 75 c6 .Uu..Tu..Uu..Ru.
     00 53 75 c6 00 00 00 00 00 00 00 00 00 00 00 00 .Su..........

Fixes: 85644a9b37ec ("media: ov5640: Use runtime PM")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/media/i2c/ov5640.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 36b509714c8c..161706e75268 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -3923,7 +3923,7 @@ static int ov5640_probe(struct i2c_client *client)
 	ret = ov5640_sensor_resume(dev);
 	if (ret) {
 		dev_err(dev, "failed to power on\n");
-		goto entity_cleanup;
+		goto free_ctrls;
 	}
 
 	pm_runtime_set_active(dev);
@@ -3948,8 +3948,9 @@ static int ov5640_probe(struct i2c_client *client)
 err_pm_runtime:
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
-	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
 	ov5640_sensor_suspend(dev);
+free_ctrls:
+	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
 entity_cleanup:
 	media_entity_cleanup(&sensor->sd.entity);
 	mutex_destroy(&sensor->lock);
-- 
2.25.1

