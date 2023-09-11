Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB4079A31C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbjIKF70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjIKF7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:59:24 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2119.outbound.protection.outlook.com [40.107.117.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BFFCD2;
        Sun, 10 Sep 2023 22:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hszEYDJ24Nyff4Py/ljW4qDwx+B4uvYKuULeNgX7LvCKgPdZwdmSvw1zAktesVTxHESlDdsMjkiBmvVndjbNPacWCr2LN4TB0gGP4sTa6zJobUS0GD/BxON8zw4FgZhCJKpRZxUg9arOd9zd3vhubHjDX8J0WoII727Q1SP84RF6WNbsdluohfVVkRcxLhxfFa+759OvDDDph/rS00nMmAQnHiqnTntjmNkHPlN7s7P7oovMlsz4fQllXi75Sxi1nD/82qYd5ejqbCveqvBFsUetxJQwDKvtZYK2MZY/e1ar0K7qhzPwkwJ2nBijWli9fLfmgbFz9Ox7CuXHM/BuDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vb8PoTPYckGyQbxiYXlK40vldOSLOGu/bVZ/ziPyTpY=;
 b=kDxVTa1zEc3ZozmyijDhuizme++Mf25YeFaIdFSFIV5gjIy/Uro1/kHVFMRlVkc76S0rt5MePUjvz0eEcU6LstK/v1dCdcleuOlms/u78R9EyspiLOcnt5Bj32mUHeau5afCvw8riPFd90OSY1bdcQj/R8PFELX7GdpfqPveaPBFRvlEdPxUJey7ivd/+7pNCrC/DBDlXmxTbwn4iKf1J0i/wB3li6Ef2S+e/8CFW+Cm0Ye8E6KrCuG6ZxlfPh9SowaDLBwB1k8p041rW6R4TVBM75D0ElM4PE51f6ioNXQAhc/9+AeEDcaeN8fL1qQXtoEJ3BFzfbeSl9dXHS+JGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb8PoTPYckGyQbxiYXlK40vldOSLOGu/bVZ/ziPyTpY=;
 b=FZKSnn5IRxQYhSj9Pj/7NBTTQnQ8QtXcUtNxl8oPWma/ECmKEX3HpLNpZNiZI9Z+PPf78fVhSpsbYAv2mupNkYmETAJYks/5iSXhtmUzjJfTvoZqL1cIOzUt3DGP1HTQZf8n5/XGrnM2Q58BwRyyUH+lpWcvsZpqoZJPBNrw51sf26iEPtRjlfuAkemIKbgqtGxlLLUmjZOXFNxBB6ATiLKXgObTJHs62QVo77Mf64b7gsYDsfTiAcxHvyV0qjbzk5PyYPR4auwH4PwOxKL3UJ1iSigIeWk9mcRhncdZ5qtzSuHsPxXLq8Sdn8mAIKPv+eoArtNILdTdDuIQPp/6iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SI2PR06MB5170.apcprd06.prod.outlook.com (2603:1096:4:1bd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Mon, 11 Sep
 2023 05:59:16 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e%3]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 05:59:16 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lu Hongfei <luhongfei@vivo.com>, Bean Huo <beanhuo@micron.com>,
        Can Guo <quic_cang@quicinc.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Eric Biggers <ebiggers@google.com>,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v3 1/3] scsi: ufs: core: add wb buffer resize related attr_idn
Date:   Mon, 11 Sep 2023 13:57:06 +0800
Message-Id: <20230911055810.879-2-luhongfei@vivo.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20230911055810.879-1-luhongfei@vivo.com>
References: <20230911055810.879-1-luhongfei@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0234.apcprd06.prod.outlook.com
 (2603:1096:4:ac::18) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SI2PR06MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ada313-b73a-43b8-a50e-08dbb28c3b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzOwoOeEK53eK41x1zDyKmfLoAiIR76SvZOWRVueSVT8hbbF5K6O2OYc955NrqEP2mahMTWFH+sGlMMlH/7kOpsArQ4gC6ycejGNogASAoZMoO/BiYcVvM8DA1lsK9+WmDAiBQxwFFTr1Dj5MHF7vJ+xHWkm8UJEWNU6Q5QeA0DHqJ4zsNBKyG2gE2lM4VXg2w0KaSuH3++KQRr6Vik4/6xR0GsRTyFiMKxkcifokY7DOVjiQ8lD6cGD+KtTKdM1ykwgGOmAjjqYI8js6uQvLhXhPjpWX4XrzVNjI+QYPwruo+ds9ocH2aeDzXgUqpat3q0GNBLRgA2ukABNvc3sLTmfdV/BLcrUfW3WISkwXPPS2xryx6xbq2wfZixrE2YZP2NLlLAZYFxUO9/mbd+ljDZb/zFhgVlVb38OKaLDjL6VXG/Ig0TwTJEnlgrvHhsVhjpd32CHgO2DNwnU9pZ7L1XYIyHwj7t+mkxwxFDt9j37LsGTxgBItul7XBJu8/I1uPlXcY1TQHwXSUY9EfMF92Yc4jz7JFljcfX6iQ4gboQT7DTkAt4wjxk5GaoyJVXogWUtrQ9yjM9vF8ZwsvN6Xx4WUPl+k9fSMOUsSExI2eP4eFofp3kZRTSDU7m6mWgNnjha975ROuP4S85AJh5KPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(186009)(451199024)(1800799009)(6666004)(4744005)(7416002)(110136005)(66946007)(66556008)(66476007)(478600001)(107886003)(5660300002)(8936002)(8676002)(6512007)(4326008)(26005)(1076003)(2616005)(83380400001)(41300700001)(316002)(2906002)(38350700002)(86362001)(38100700002)(6486002)(6506007)(52116002)(921005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HaVcC6SMV7FZxDREtfvudpmmrFAwhLVvtt7NjpKA/ipurL97TQ7W0TvrTRiZ?=
 =?us-ascii?Q?CyDxjlcRB9jUYGGMM3NqlNZTa0LtMZnZn0vrDnzJPFZt+M/gTURGrPhlTg63?=
 =?us-ascii?Q?NQqJ1e+JpIP/Ir6EIq+l34f1wacO/cEm9z+LmsaArvlGGWQYNR6DQR9sf/XY?=
 =?us-ascii?Q?ik6W8XKcqasQ7tbgH4maRsNfCZ/JixcgrhNoaqrKSaUX3M7yUNdivEzeDZ0t?=
 =?us-ascii?Q?+imB1HmbVlbjzXgKtYJRlfXFb5siVQgI2Y8rh5y+u0v1/f4KuWGi8Gf6zQab?=
 =?us-ascii?Q?PAszX8SZrCPYusLgneXhxa38GyNFDSYcYGoOb9mKk8oLjzgKak661cX5K4sA?=
 =?us-ascii?Q?BA1QanyouevoW1fAP5DyN5puXyrYgnsT78P3fdHruP9ManWUWpx1cArGO7Og?=
 =?us-ascii?Q?A4ggVe2LmYC6ULVtXdzd3Sy3TuKbcrAlyZUitVm1kQ7PvOSCLrjNHaVQRwTm?=
 =?us-ascii?Q?7Dgr7Q/SxBjd1ROj87VJmv91rB64jjasotYSwIHrJDrtgEt9R7eAgTPUDV/e?=
 =?us-ascii?Q?dDkyHtdR/kE5MCdoJ5eae1yguLcj5OjCt6ZYl1NrlODoluKu+86Iwd5mYcSR?=
 =?us-ascii?Q?+yvNkwHETVUkI8g4M8WmEywZ3ZOrcm9aC1lUldqjE/6phBaoD+BQXlJIn7gF?=
 =?us-ascii?Q?1+49VD8QoHYWGv4IrMQTLOn80ICRNqDu6tDUiAwTj49uqTxgJ+9SugOsQy6X?=
 =?us-ascii?Q?LV9wLuJMgd1S9gNscC0sqMSfFGWiGDg+38j0jFgn7Jkwyx74eX1d52U+Sxop?=
 =?us-ascii?Q?VTjix7o5y2Fs5FnkgXgYWgxkdA0cPqSlkGhBeqOe/+GQulyjXkh1tIuaRb00?=
 =?us-ascii?Q?LXTFRmM1k32DKIa2PvLBuDa6M5/hADwr4KnUqqsxe8Nb/Fuc+beK4bciHRbL?=
 =?us-ascii?Q?QWvuENKvJWikrmwt08Fs6L6QYv4nkETxPRXpbA0kci8GgI5WgpY4OnZ1RrdF?=
 =?us-ascii?Q?AiZHU8AYRQ/s6fxzshYF5ZlO+mYQKNJsV73E/CfxciEjUOL6I1GTbJcCtwNa?=
 =?us-ascii?Q?bXwXbNxfo6kqz6hj7Bo16bfxgHIPZTPFLHe/do0XuHqq8sJDUtpuiz5MGUJp?=
 =?us-ascii?Q?QVz9zktGMt1uiJ/DH10ZiU55Jhppibqo2tbs6sK+WfIb8k4AtJTVeGPPtHBv?=
 =?us-ascii?Q?c5VoSneDpttAd+nXpEeVeghlpn4oRqwMXtchNr4g6NzMIHQtcrFAbb8e00pi?=
 =?us-ascii?Q?6zFSQNRhYgHosBn01nhxmxE8lmjptN0MXPUkzSjqjvg5TnD5N6gMzkjrjufF?=
 =?us-ascii?Q?Sg960ijYwVax8qpFGQ4TKs70aYMPe0VQ/OMzRoUbQ47wXT85i5FhkV1hRW0V?=
 =?us-ascii?Q?7PAmPU2Gf4aBBiIbgbaKNlN1NSYQu9QBvKeCCi3hFlN4Y1zDUK2AhnWKvXwu?=
 =?us-ascii?Q?A9IN+f/wBoFMugyMpoYbMeL4v6yzZ9bcoWbnfB97OAhkyD5Yw6+PaokffjR7?=
 =?us-ascii?Q?tgW5C+HuJikKKbxp/wz87jKvIE8bE9P8/XrhwhWlpQ/r4dUgO7WIERMilGyo?=
 =?us-ascii?Q?NT5GUJ6g5wk6bUDQsKEnJTeOC7DgFE81osWxorVqfMccoExw+8uqVWV3lVOW?=
 =?us-ascii?Q?OYVR/QFVYNBZlAJN0FgNgxJWTS+v4t3DsrEVzRLS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ada313-b73a-43b8-a50e-08dbb28c3b74
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 05:59:16.7617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMsPdrisdMQTqo3Okp1qlskBNqgpCVKmgJrmE8r90fMFW1rGWax5VdisilXggMzc4jEb+kPqLQk91PrLTDkhGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5170
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we know, the ballot for resizing the WriteBooster buffer has been
approved.

UFS will support the WB buffer resize function, and UFS driver can
add definitions for attr_idn related to this function to support
this feature.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 include/ufs/ufs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 0cced88f4531..d174702ae960 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -179,7 +179,10 @@ enum attr_idn {
 	QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST    = 0x1E,
 	QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE        = 0x1F,
 	QUERY_ATTR_IDN_EXT_IID_EN		= 0x2A,
-	QUERY_ATTR_IDN_TIMESTAMP		= 0x30
+	QUERY_ATTR_IDN_TIMESTAMP		= 0x30,
+	QUERY_ATTR_IDN_WB_BUF_RESIZE_HINT	= 0x3C,
+	QUERY_ATTR_IDN_WB_BUF_RESIZE_EN		= 0x3D,
+	QUERY_ATTR_IDN_WB_BUF_RESIZE_STATUS	= 0x3E,
 };
 
 /* Descriptor idn for Query requests */
-- 
2.39.0

