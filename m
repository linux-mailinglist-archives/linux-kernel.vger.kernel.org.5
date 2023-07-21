Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E920775C366
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjGUJrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjGUJrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:47:09 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB23F0;
        Fri, 21 Jul 2023 02:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRyhLoP5jNioHSxfmlweb6URpGHiq/t+DY9AVGWuOwU7vGvbYJhWydRsye586HES23fmo70HuowBoWGAdmgkcapBMn473EMJPv0oDH17fJKC07mGa+mg1ppTvXJrBv930cfrAXoMycDy3juUsLJ3x4ogVmObeZy9LY5J9sAcmREdSRvBP/6ZYMVLmiuB0i1b+X0/qvrnpK+YsECvLMtQ3MWovTl9a/Bw2J3lzb8WvyC8mYvlNB1Q4DZgeRokwjYfFQbfs88jbDa4lpmsGS0yfPhp/5S1dDpGTQt+5e8RPJxjxTfWYUoo0Obe+u9yHyiCyjvLZLt0sZTGdj+6RLNL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f85Sj1Pf7S/hIg2p7O0a1eybgIjJgZrXjkRNBEWx7tE=;
 b=RIN2OBBZYp5JhS/28AhrmnuZRbGa4SDTVNoisBmZYMKbpNFoJN0rZayKB3cVLveFRG3PGyOFAU5GIH9AqogE0BuZ0B3+ZBsWI2SmyLSztYXUtbanI3XAR2xchvROxoqCXK8cAtCb2TazfI54c0g5lhn4LOBxP763YvsJpfSb+qxYlJuoco4gbjju2vOfYpxpXB/eMBgG5/9zzJxvNFgMDhq2YEZxJGYQa01ahVIl/f8/q33I5AaawQChjjshvadHxXT0nE4Mqbq0bf4/LoPlQMQ0uUZ3X/qvcmcJTKs82U7QwfbUJ3jHuzeCG3LVhRu0MKxZXfkVPYMFPprEfoLzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f85Sj1Pf7S/hIg2p7O0a1eybgIjJgZrXjkRNBEWx7tE=;
 b=XFMFuqY8WkT9rBj0JJJaUFperO2e/CowUJVLfnor+j8GpNQrOMMFPLawcE1DVYNloXT3t5/L0/8Fc9HNCfz5R2acrE8ccAFOq2mNmt9UGiaT8ZGDL4RuFKiZrM0HM/8dTF3VhdxcbW8F6uJl5nZp/0VSP1MUTA3/giJsUW53a5oVTWFZk+t+glW9Sb/Jl3jVHHTFErvp6UWTQHe+CxajjKSREYwROYvmzeT1CBUNEo6QH73Y6qpZlzEqo8enD4CnmRxfZQBeSVQMhtn1K/VJzcsXjgiT/mc4RdwAF9c8D4EDvvnuKOMnB6n6SHbb6EOmEM+gVzs5DDg+CqzcxA6iXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:47:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/22] thermal/drivers/armada: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:22 +0800
Message-Id: <20230721094641.77189-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230721094641.77189-1-frank.li@vivo.com>
References: <20230721094641.77189-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 4def374d-d1b1-4a65-af29-08db89cf6eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJYYi3XonCH/O/pl/L40rEq4q21J+BJuETu3exDBCatkv9DqPm03JOHwfQrPtq/7oPFMPjTIGk5t+S5UHiT3GSGIMotcUnPwQfXofrHv9epVloi3z9+CcPjmQMOWq9Adxq3ZjoX6mwmyBFQMOiGfrN7CFrYsE252/z52LkJS/cMybbMIl7iIDGWFJtAk8Rj8q3HQ5ENLW31rSXKs8U1X7cJgkrqsG7keLuqRkh3h3ofpQ/7L1IB87PuELs8kct+g2gZpXyXWgFGqmc6p0l+8begsWfJXwN405/F8G2EfVELlrfR5Xi8Dl8qpPTgkwMO0zyO1rNb62cUw2A+zdfMjxN/WmrX1lkcJK9T1oq6Nwj7995lZCiEXvaWjePqcLaaBxw4EJ4ijIbQ9StngrbGHC3GcHMHTh5uyGe+xDVdlInOoQDzLUqp28VvZRok/r46S7GhuZAjQto00R45vDPJRXeAegHZZCGsP/XsxEFXATOyY6ofp1eWSrhzkgydAadBJv/tzTziSa/njEBvCT7XE2MB55noJ6so8kiRg3g6munpI1tF7E1buM7UzRDvnzmp/FMSpeJlvBj/pj/L1wcRAtZakYVqf+04kmKzW8AkeU9rFc6mCRoTwXg32EPlPSyaj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(2616005)(2906002)(38350700002)(38100700002)(66556008)(316002)(66946007)(478600001)(6486002)(41300700001)(4326008)(6506007)(26005)(186003)(1076003)(66476007)(52116002)(6512007)(110136005)(54906003)(36756003)(5660300002)(8936002)(8676002)(86362001)(6666004)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE55VHVIei8zV0hRQmRkWnhuZ1NveUFDTjgyNlY1bk5xY1d0VC9hQkRSY2Fj?=
 =?utf-8?B?MDdmdlRCM2FWZEFxY2pTUHVVSWdVODJrUjZQVjJpTWdORTJsNjJPNmJ4TXZv?=
 =?utf-8?B?L1I0NFEyaVVjMTNWbGhkbHdSb0FuQlBORFRHdWhHR2xsUlVjNzQ0akNHVkJG?=
 =?utf-8?B?aHgvRU92eGFVWjY1TndOSnZYUG5YZUFYVFc0QjRnQlovSmc5dWluakZjOVUw?=
 =?utf-8?B?bkFQQWRmUk12R1A0cWZvRGJyT0JhTkJYaDIvRFNySVhyVVV4Wmx3WXFUZnVX?=
 =?utf-8?B?cllscTA2Z2t3cFpvTmFlVjB1TUhlU0hWa3dwaUo4UnRYODgyUlhQOFIzaW42?=
 =?utf-8?B?TXVsS1hxRmxMWVZmZ2pBOWxyOGhUckNtb0h0OXcvUzg0dEJrYWJ4WW5hOU05?=
 =?utf-8?B?b0ljNG5ZRnlPczh2dFNGMm03STRkbWN0YUovcDZET01Pb0pMUXlpRjYxcVUr?=
 =?utf-8?B?UFB5WmR0UTBoRndueFdrUjhmeU1rb1d1OWRKQkIwTzAyYjlzYUMzVnh6MWlB?=
 =?utf-8?B?K0lvUEp1MXN2aW5zNUllZUVRK3JaZGxqb0lRazFRb1ZaTDlPOG0rVEtNYnBh?=
 =?utf-8?B?QWlsbjd2aUV5U294V1Y0NE9naG5uRGVuK0tvVWRqbkgyT0VucVZkODdjQ2tn?=
 =?utf-8?B?dFV0aFZiQkRDbzltZkFkdjF2RmRKTVJlM2FKTjhsR2hFRXRycWdtN1g4Smhj?=
 =?utf-8?B?WjhBaEVLblh2a29acHV2WDlTUElsNEhUMUNGRGlmM3dHcGJZQWVEdEVqN1hz?=
 =?utf-8?B?MmgrRzI4c1BlNTlRZUgyeXZKajlPTVVlZUZJT0dESnFPN2FWZzY4eGZPOVFF?=
 =?utf-8?B?alVHVmp4dHhZeEVidHN1akFDNG1vTmhiVnk1WHR5emhnYndjK3N6Myt6SFlV?=
 =?utf-8?B?WTBGdEhoVTdiUi82NzZVZG14SVdoVVpUYlRnLzVSdVlPdlJkUEhyRVpPajJO?=
 =?utf-8?B?SHpZRGpKQnM3bDNJVDEwY1pmdUg1NURMYnNDV29MZUFFMjJ2U1J1bStGNzBt?=
 =?utf-8?B?cnBVb0xYT2xjSWJUK3BlUHd1R0VtYTRZVFJUUFZ0U3VBNVplWVV1WmJzKytH?=
 =?utf-8?B?NjNPbXFWdzF3NllIOVBiMml1aU53elFuLzh1aHJRUHJ2VzBQdXBzZHEzS05E?=
 =?utf-8?B?T2Ird0tKQnJZai9wY1VEc05wMUZPRm9pSEFraGVZQUxOK05STmxQWHBYVkNI?=
 =?utf-8?B?Y1hubzBzSDlyaGNaQzZJUkpCUzZvMkhtSWE1aDBJOTZHRjY1NGpYaUpQbXUv?=
 =?utf-8?B?WWNsM1NoZ252MjdyZVQxaTdEdHN3dVJMSUpMbnNqdEFKSzlTWVFWalI5RFVN?=
 =?utf-8?B?NXQwaUtFWi8yY0JjVHlGbW1JOTVNNzNpcGFSZnN1MVBLaElvaENLT1Rxenlq?=
 =?utf-8?B?dTFPWmdYUlR1cE9sYlQzZmdhL3k2Zm5zMWVHK3IzaEVqdDJwZzZhWmZ6dmhq?=
 =?utf-8?B?cjVJeFFGemlMOUJxZjFucnBGTXVXeHprdVk0NitUUTc4ckVtYnhteDlEWjQv?=
 =?utf-8?B?MTFRekgwa2d2VFRGQnB0clo4SE9GTEJaVGdYSVBBdHpvdmZId1hOb0JTRnQw?=
 =?utf-8?B?SzVvbjlqclRiTnZjKzl1YVRybXFkd0ZOM1NJQ0tmQk44bnJpcHV1TzFYaW9P?=
 =?utf-8?B?R09lR1lJMXNCaDRTWjl5dlprNFVrdzdwd3dLT2tKZ3dnRjNlMGE1aGxaeDJR?=
 =?utf-8?B?b0ZxWkRYMmhMc0hGQmZ4ZXhVVzg3cHpLdzhFV0tqSUVrRnpXVDJSNjJ5QzFQ?=
 =?utf-8?B?SmYyY0VlOFNWWjVpb3VHeHRlc1FhVlJ0NjdSMkpZUkNoZEpFeHFSRW0rUHVi?=
 =?utf-8?B?Vy9yZVhJZXFZcE9qZ05OVjdidmFHNEVYOGtlQ3A4RlBPVThwWE45OW9TRERp?=
 =?utf-8?B?ek5qRnJxdm1SMC9BUURnZ0o2SVpSd09nRmNLWWVEOGhxaUMzY2J1RlR2OWRj?=
 =?utf-8?B?ZGJGalZvMDd0cUlhbjVqK1F3dHUwTG9FZmxsa05UMjZIeDJGNEpPS1Vrdmp4?=
 =?utf-8?B?NGwzNEJMY3ZnZFpDMFhtRXh6d24wVXBuYXpRVzV2LzkzUDQ3Vlhna3Uvd1hD?=
 =?utf-8?B?NEhMZzcrd29TWjR3STdwOFNqaTFWcUExczhyZFF5TUFCdVhyK1VoazdGTW1v?=
 =?utf-8?Q?Esh4z/GDRqA+Y0ILr4YqJ8UCL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4def374d-d1b1-4a65-af29-08db89cf6eae
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:01.2807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gmYkR8dc9XF+qesatesHwZSGh2apvo7BaSLgRH+a0142eBL24znHvbuOSvRPGllviWQSR5vnZs2BBlXF7VYUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6789
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more than 700 calls to devm_request_threaded_irq method and
more than 1000 calls to devm_request_irq method. Most drivers only
request one interrupt resource, and these error messages are basically
the same. If error messages are printed everywhere, more than 2000 lines
of code can be saved by removing the msg in the driver.

And tglx point out that:

  If we actually look at the call sites of
  devm_request_threaded_irq() then the vast majority of them print more or
  less lousy error messages. A quick grep/sed/awk/sort/uniq revealed

     519 messages total (there are probably more)

     352 unique messages

     323 unique messages after lower casing

         Those 323 are mostly just variants of the same patterns with
         slight modifications in formatting and information provided.

     186 of these messages do not deliver any useful information,
         e.g. "no irq", "

     The most useful one of all is: "could request wakeup irq: %d"

  So there is certainly an argument to be made that this particular
  function should print a well formatted and informative error message.

  It's not a general allocator like kmalloc(). It's specialized and in the
  vast majority of cases failing to request the interrupt causes the
  device probe to fail. So having proper and consistent information why
  the device cannot be used _is_ useful.

So convert to use devm_request*_irq_probe() API, which ensure that all
error handling branches print error information.

In this way, when this function fails, the upper-layer functions can
directly return an error code without missing debugging information.
Otherwise, the error message will be printed redundantly or missing.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/thermal/armada_thermal.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 9f6dc4fc9112..b7f549b6f825 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -913,15 +913,12 @@ static int armada_thermal_probe(struct platform_device *pdev)
 
 	/* The overheat interrupt feature is not mandatory */
 	if (irq > 0) {
-		ret = devm_request_threaded_irq(&pdev->dev, irq,
-						armada_overheat_isr,
-						armada_overheat_isr_thread,
-						0, NULL, priv);
-		if (ret) {
-			dev_err(&pdev->dev, "Cannot request threaded IRQ %d\n",
-				irq);
+		ret = devm_request_threaded_irq_probe(&pdev->dev, irq,
+						      armada_overheat_isr,
+						      armada_overheat_isr_thread,
+						      0, NULL, priv, NULL);
+		if (ret)
 			return ret;
-		}
 	}
 
 	/*
-- 
2.39.0

