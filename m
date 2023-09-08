Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7710D7985BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbjIHKXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237583AbjIHKXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:23:31 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20723.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::723])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592C81FFA;
        Fri,  8 Sep 2023 03:22:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BH7CrOjQd19sK3DxGaPP+48EmYouRVXjWENf9X/+iS+8q+gH7ARk57DjZ60IjEkkok2uaTy5OlC1yQ4gyZmPZy+L7MRTkVTxTgHVAmlfVXHEp8KzKF+ixpK+SZ3TWSLC3W42k6JGeexl/QCISacqYY2NPOWGOsfb66E5TuwGuU1oAkAulBzqfVYFdj1jzYZqheUqpu/TEhnHnD8MsItn0ZdvarWZRBwhuMiCtnyz7r1Hb5meQY118HtjXlqIMx3SRtMjO20ATcSoElYvlDRdh/pQyL66OfTEVQHSvDfQGWZtjfZnwzogSrLAP/seErDSudIxabk6XoI6efrCccHGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+wDdi8IhyMgPYrc9WFMlZ0yVIb40ZMZSmoDMvCDGog=;
 b=E41nMWh+hsjVCsOBQ3mfJFYbv31CM1CapFgbnbzzNBFWJDrxwwhjTR/xQz3AwiwKxB88ePM72XYtrWy0W0yuypwL+ZEttlOyfdPor367WQnwVBwa8qjRqfd29J6OPeDobuwPZbvNPQpbzz/14+FGX/dqRWrYiEXdp7Dyzn4ypsoPqWkd/5Pzjwt8RUaGwpgE7LtSsA84EBrs7A0OehA+LdFAvJrDOHfWopZQIKMifHbhA+QL+bFXquc702g1IvQrFk9IcknY89/B6BMxHdAVI+lVwkhgT8VFiIX3g3eGixX8FVEZTkTROjET5cm/LTKyHoKX681+axOqck9P4+O/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+wDdi8IhyMgPYrc9WFMlZ0yVIb40ZMZSmoDMvCDGog=;
 b=Ikb0TX6Gp5/+YFD4LNFyA9d7+n+knYvWgOwkMA49ru0W87C+OEeA2DTHyKIrcv4al4hrCk6Epsc9qqqNzPpNKLN3uZqdF9NZrpcd8HNpHBhdShfpt/oSMAZ67pzDlnB+ENeEVzChdwdETFFEOaDYGYbpVbKxQ2AIOe5S51gYzV++Rn36GRdCv992WRPQ5ZqJw2oEI/Pkm/wteJqflzRThdDcY+Z+l8EL+GahOyfewuDwdf+2vPW24vPYYiyQUwjeV+XldoZobps94HNrktnnvFQ8r99aO7REesJ//zrVMEwZOAMQKik3heFxWqyH9LWkBa2dqBP+xoXuEIPGW+RBXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by KL1PR0601MB4033.apcprd06.prod.outlook.com (2603:1096:820:24::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.38; Fri, 8 Sep
 2023 10:21:29 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e%3]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 10:21:29 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        Can Guo <quic_cang@quicinc.com>, Bean Huo <beanhuo@micron.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        zhanghui <zhanghui31@xiaomi.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Eric Biggers <ebiggers@google.com>,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2 0/3] scsi: ufs: core: support WB buffer resize function
Date:   Fri,  8 Sep 2023 18:20:15 +0800
Message-Id: <20230908102113.547-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.27.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|KL1PR0601MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: a24253e9-3cea-4d42-a5f2-08dbb0555d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ccAPHvq6jJujTlmUvvlc7YPIwLk7z0XE5h24m1ObsR+DKkAAxu0r+kFAFcfI6vvqTVwd6gvX+7cuv3RpHCkal13jXp69VISkclrQAxdGrMw3kupj5WTaX4n2r7O0vbH6WdqCi62snDF0WgWvJwNlyu8eo+mUaVeHca01XQj0jrVUGZOpcVb5aQeD8++gmfc3qLroZe0xBSgMLTiQj4DBPpwYUq7gP7qn85fZSaCrKhMt1UZsvkbqhk4h3dnS6tk2j/o61p1t9wmj6wycsLQpj9tANUGxaKjZB4/i/p8c7Hn4/iGmVomnx9MQewTADjGXf/bU83f8j1tIwNR699B8i9bd7KQeTTMf+aGMmBkAswGBk/fO2TysqVG7ahkPX4kd5NcXlfI2Ieih0P/WtkPPwtrEECc4dlmSwmW+Frv5VSMI17TQRD6BF1/NsRaKCxKaGivriaAUagMWo33R1bAeQNNvfFagsHPBjIkf0gJaHodtQQ/9xX/E7XfbKBQyMsD2FjJh21DZNAPEFx0M42xDf7czPlNb5iGppUU+FDxrWi5RoNOnZegcbMmK/9PPOa/ckL8dhg2i3hV2+va/mPL3Lbpv1tHXDvpHEM7/Vu+hb7tR3aL2DAhi2ZNWoOUbytx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199024)(186009)(1800799009)(5660300002)(4326008)(8936002)(6486002)(6506007)(8676002)(66476007)(316002)(66946007)(41300700001)(66556008)(2906002)(478600001)(52116002)(6666004)(110136005)(6512007)(26005)(1076003)(107886003)(2616005)(7416002)(83380400001)(921005)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P0XTe7DyBRDND3fw4K+XZA+ZWr6gKZyZNnJ4eLXQVaCFdfscYbyUFYplilQC?=
 =?us-ascii?Q?3zvIl6MHurfDHpivLyPjiYnuebrB6T8AZtEGHuXqreDQxbVk6XSKLJBK2ADO?=
 =?us-ascii?Q?wAL6H8l4xHHXBhe5mCU3HzXb0KmRAkKaHJwzQ3BIlU37ACI9tihV0fQOu1CJ?=
 =?us-ascii?Q?96zZqRuyH1IA6iMtzxwIzS5D9ILsXq0nRtfGSthtI/5aTDvlo2iKLvT2PJZG?=
 =?us-ascii?Q?QqSVGW4NcvT+xM2FqDVutCjfk5h0RfXcDbmk4EqTIeAoB3JAmbKG415bRu5F?=
 =?us-ascii?Q?oGZPsRuAtH8TV2FH1otLZvMC1KUwHYeuut8QThYGM/GApwQVR4wuPEIduLjL?=
 =?us-ascii?Q?rKbeV3bv2qKqLE03/7iaqKz1Y7Qv2SfKqGkX2Vp5rlvkiSAR+Qoa8xMsSCaD?=
 =?us-ascii?Q?z5T8TxD2Fl/Q0qRvbbVl8OlMLvKMq1mqUswRWM1ghIijc8+CiVC81l9DIgGg?=
 =?us-ascii?Q?vIjA3J6umWcEn1EUe0b5GNH4qRsML+y4OAkGRGzewxN2n3eBGpUt1gDOQP57?=
 =?us-ascii?Q?/0NugLyiCbbh5Y/aXpap9kz60wvkERKABv+kKOxMjxbqXcAbAhc+LpDWrKzV?=
 =?us-ascii?Q?2hc9Lm0uCrb5/1mHPWjxWR/3FcdMYqf6BSMtpheNDMpN5f0utjL13YdtbC/2?=
 =?us-ascii?Q?UX208RNBcMtMWBbgAQ0jRw07kgulFfAFmSZCNCxFyohlI+09QF8Vx/K2X8al?=
 =?us-ascii?Q?nk1JeJJaGn/NWnebI9Yp/BWBvWHNRcwFZELK/V+WYcpvIaG7SEO03f+PF4pl?=
 =?us-ascii?Q?zN9Uc6bwttgDmTKAwEQ+uFjtWXaTjpyl3QvFja4wDSWVwFHwfFOh4rMBIWoh?=
 =?us-ascii?Q?PLJetpDPRPxTJCC1s0CTi9ryh7UxmBVDwOwKIIsogTGU3M7VMjkjJXbYAvm0?=
 =?us-ascii?Q?1iBWsdSOFVJz3NyxfnWPR/euwhRYEEfJCIRzltbxpOhfZLcsalxOn2DXFtgj?=
 =?us-ascii?Q?4UmQw/cyRoboQtpA7MQXUNnubt0LBgzW70/bl7RmwP95OMiTwza53ibtKgz7?=
 =?us-ascii?Q?wuQNdXNKNpKZLe5LLmLDoZ0JX9RauHrPNGzypViQProHF2Jq89gr8l/t9pC4?=
 =?us-ascii?Q?e0KjvzcvMP6Ss5LvwcB4toFnIsP+8RDxElKIRhi7bm+RmW2bnXBW0ucsL0hw?=
 =?us-ascii?Q?u4ZMJTNIs+bKs+qEOJ1GwYdZgFgrJ6DF/C4L60q06+M1S4Yee23YeQZPQRCp?=
 =?us-ascii?Q?tUMllO4kGNY83PMOq8J8coSkPYmkTjT4mZP7WSL9vBwIIKoTXH7OWgNkRCGU?=
 =?us-ascii?Q?1YqmYtzOPCpgGmCuQqE1OnseqPHWt8t0xBkh05znlzDLt/N/VsM4hsabILys?=
 =?us-ascii?Q?E2TD4cZNLD5FOLv7KNGmmhAMa1ypzNSoAB7Gi4DGVRPjEyY1Z0nvvq6w2VCv?=
 =?us-ascii?Q?v44C3nXQC+xtdXc5lgFNQqq0mJK1mbG6HPZSIhTLcKX8cvfLzDsooreqJHSK?=
 =?us-ascii?Q?Q5AyEQGqHkVHKwyi3OdT8ITOcuIbGCxvubBeB3/YQYxD06Sktde3IZ0MIiB/?=
 =?us-ascii?Q?ngc0tb0goFZRxqo6NDf24A+uVXMt0ZslUgBCyYx3ghN6fqXw0QRyAK011UtO?=
 =?us-ascii?Q?4p41xYogPXwbpUQmxqz9sVYl4rVGvKMnNOs40uGy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24253e9-3cea-4d42-a5f2-08dbb0555d8e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 10:21:29.3135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMHVkn4H3n5COvDWyjxqrXYNZruWHOIhKL8zhkJ9NMTVN/Y1Eq2ftUJcjEFEWQCAAz6V5PPFpexYi3Yohx3JWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This v2 series implements the function of controlling the wb buffer resize
via sysfs that will be supported in UFS4.1.

The patch 1 add WB buffer resize related attr_idns.
The patch 2 Add ufshcd_wb_buf_resize function to enable WB buffer resize.
The patch 3 Add sysfs attributes to control WB buffer resize function.

version 2 changes
-Using sysfs to control WB buffer resize instead of exception event handler
-Removed content related to exception event
-Solved several issues that caused compilation errors

Of course, there may be better ways to implement this feature.
If necessary, please point it out and I will optimize it as soon as
possible.

As of now, there have been no UFS device releases that support this
feature, so I have not tested the code on real hardware.

------------------------------------------------------------------------

Lu Hongfei (3):
  scsi: ufs: core: add wb buffer resize related attr_idn
  scsi: ufs: core: Add ufshcd_wb_buf_resize function to enable WB buffer
    resize
  scsi: ufs: core: Add sysfs attributes to control WB buffer resize
    function

 Documentation/ABI/testing/sysfs-driver-ufs | 52 ++++++++++++++++
 drivers/ufs/core/ufs-sysfs.c               | 71 ++++++++++++++++++++++
 drivers/ufs/core/ufshcd-priv.h             |  1 +
 drivers/ufs/core/ufshcd.c                  | 21 +++++++
 include/ufs/ufs.h                          |  5 +-
 include/ufs/ufshcd.h                       |  1 +
 6 files changed, 150 insertions(+), 1 deletion(-)

-- 
2.39.0

