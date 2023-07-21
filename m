Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846CD75C362
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjGUJrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjGUJrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:47:06 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A270121;
        Fri, 21 Jul 2023 02:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUkcqD3NiZTKjp1xtzU16fhIaEr4bUOtV4T8Rh7TrRlfGgWfJBffyslg0xE9HicWdo0UZ3Dfj6w+r2yAt5C6Z0F4M31MWQIGuUOhsBFFS+lQA4ggdhufES7cb2MZ2LSYaBDHrA5Sqfp14PNCp50OVsi8IqPvjpcX/dDtvMr+vlQONxkL0VtpAtRDhmhKzF7noKG+WxqsrpivJUccg6ztFGg5LKhBvfKo5HmPk+12q0m/KmIkXkynFOBFHM3eQT7C16t5W75TzW/0E/14JDZ3ku6YTs4DwGmxi4cwykJXlWo0YAEPKMHWV/IIUuAqHNDLVNdDhXmOMMhFR9bbM8pmAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cslGBST80PBLFMrkaY/Jc9M1A0EqquN1GEpZNPex7Y=;
 b=iJFot14QsAyv72wxSMx6hYjatkE58tdkJPlaRH65ekLppH71SS+gi25HMtuCETzps3Z1UHq9BdNogrNfcCWkR/BcHDmen6+KE5l/3Sg3Dj7KPbrErtIIN25SfcOLyoQswKkswO7timKaGcm5r76G8RroERVL56nuXeUiF1O4+RwWzkKytLxZLbKRKuYP3of6bekQHdnRzK+Um5vrnQGBQniNIAvRo3XwWRCS2FZJ4/kZUYnbgP1HtfA9UCpZusDxN6uQkiCiB65BsClfFVPvIc1nQ3DptQi17gEdx7LacKNKFPKujLhdkSltHHrtc3R37Sy114IB6LDAkI7un3t4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cslGBST80PBLFMrkaY/Jc9M1A0EqquN1GEpZNPex7Y=;
 b=KiuBelRL1XtxPBzvfMW2WALHrf5ChiaYMUGjzSc9PPGb/qwmHPomqFuXIidtuiPae0pEP5pgk2y2+A58syo3Phg/92rSsijld5Aq1ylj00PfAdSRsNP+rtov1Gluqj2knJeHKWmSxF2jwI7AdvTHibM3GzmzrIJa2M25qbQgsiO49CpOWA3e8ukujZchYPq4pLN1zZEMDJYlKQf6gyCCE+ej5+kukKIz+2QC02bAKBV6qP1jB9lyweAdnsaf6CJhh/RUy8G1slq2KsuCPnVhezBKMbwddgax7wLkAX1AJucHUFXLSwMZyEkCaRlg2DeGSSz0bsMASVPs0rQcPS984g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:46:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:46:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/22] thermal/drivers/sun8i: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:21 +0800
Message-Id: <20230721094641.77189-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 96f6255f-4cc6-441d-81da-08db89cf6d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YkJVPqDdoPCaO/MbhkSoJ0LTDGeToK5sNowFuzka6xhjQZrlYcrQe8Qlsmy2ae4bygQe0LquxRngQoPxEh/yg2Rg/4n3rz805GVks1VA8gCKjSMMbSpm9FdJu02BzBYFLaZGXlq20h0Pw4/QK5nH5aErt9tuzVaG0Q1FwLiFABHn+n0gT6+urvMy7OQE2DxqN1NL9yFKTFOrAemI8h03eFq/QzVe/uY2c7jwIfpqJpoVLMv7Yq3clyz8jlqIGYFzEYAE2piZyoML0EU47mEsOArdmc8aLlD5Zw3e0+ZVQVL+o+joAi6+xuRWTTiv4+Q9pHSnvmoB5NMbvkFJY57mArOqFhAXpuTPF5KrzIWM8PqMe/Ag1DnDqiCnIUd12Jg/qWfyBPKCQU1PBP1MjPreTzeQ7Q61I597R4B3slPPDZzYXiZigT/kU5tTd4Y4hIhmna+DEd+mbU5nPklrcXSEwGW5I7m+MQSPHtftEZD6BV02vCVVwubqjl45ToZZp1KdViy77FFUy1U8ib4QZSznmgDa6iBmoSCkizGPh8DHK6plAY5LUnX5twfRT00V8YU95CvUzMKz7rBSD1518yqkWpXANK6ajJjBOgYX8x/yXn8lDIaGozjn5QdhyRRfngNe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(2616005)(2906002)(38350700002)(38100700002)(66556008)(316002)(66946007)(478600001)(6486002)(41300700001)(4326008)(6506007)(26005)(186003)(1076003)(66476007)(52116002)(6512007)(110136005)(54906003)(36756003)(5660300002)(8936002)(8676002)(86362001)(6666004)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDgzV3ZIV3NVaExjam9uVnVobHNZL1J4Z01Rem9yQ1hLV2tkbStTL212SCtI?=
 =?utf-8?B?Wkx3VDVGVDZkdjNKeHdqMk1CZ3dFeDQ0eHZCVXQyR0NibldlZVBHaUY0M1dK?=
 =?utf-8?B?dER6QVErUHNPZm81cHRkaGUyaHUvMnk4MzRBaVpZSnl5MHIzN2k3Tm5wTERk?=
 =?utf-8?B?WkoxQXQrenBsOUw1TmR5elVwSjhwZHlMZTdpcU9qc3F0emVtQ0lidldQcDRS?=
 =?utf-8?B?V1NaSStPbnEyTzNITkt0NGhvaHNQdDNHYVkwMEtiZE94cnB1ZmQ1T3NGRkYy?=
 =?utf-8?B?WklBQW5ZWWcxLytsTWJ6NkFNL2ZxREI0Q3Q3SUhhSW9CSDJJMTNPdm9xcDB1?=
 =?utf-8?B?Z2JLVSt2dmp2WWx3Ui9VdHBMRG1NbzIwRTFqK0RIZlFSUTZxaEpwbnA1QWlB?=
 =?utf-8?B?RVhuZ3JFazhoWlZKQnRPWVBwR0c1bmNPeGFITHhFYnJ4a3FsWGw0b3RuT1FT?=
 =?utf-8?B?bUNRVGRzM0t4Nlg4N3pmc0xaZUsxZi9GWFFpdnlnNEdCS1VaQ0thZ3F6SXBt?=
 =?utf-8?B?VTY4NnFrWk9Jb1NLenNFZFcvYm9WR1MxV001K1QwNXppTmlQcE5JQ0dwOUoz?=
 =?utf-8?B?Rjlva1FpLyt5L3V1Q3p3OE5PY3JrcnJNWFpPclRMZnBLUDNRejFLUzFYQmto?=
 =?utf-8?B?bkZJTk5yR3puYWRNK2xYUk0wNG9GYUdXU1lWL1kyMnBIdWVEb3RYQ0RNdUZM?=
 =?utf-8?B?R3I4UHEzTUdLaGJUemcrYko5MHRFVlNESGZITUdrdHVKd05qMEgxZk5tRnAy?=
 =?utf-8?B?NWRoQWRiYzZFeVpRU1ViczNoVzJ0L0htSmVQVjd5UEozR1FYSncvS1pabkFY?=
 =?utf-8?B?ejBEVTJPSCsweXZmVHZWcXJ6bmZLSFozMExDanVkUXZ6MFk2R2R6bEtTQ1dG?=
 =?utf-8?B?K0RhYzFhYTJQa29rY0g0WFZLcER1R2tZY1NXZGlVdHBuWmVrZ041R2pqYURu?=
 =?utf-8?B?SDE2VSs1TUVUTXJGb0xXaXpSQTJCYmxUNGVnY1NVNVJmS09NS3M1Tng2Wjg1?=
 =?utf-8?B?VTFqWmhsM3ZMbldSZityRkQ2OUVOWDhYemM2UnBPcWhYM0JtZmk1alJNL3do?=
 =?utf-8?B?K2FmR2FBMjhOVzJZNzJ2allWWTdiZXZ0VllINmlMQVYxVEpSUTM5TWN2WVRQ?=
 =?utf-8?B?QzA4UGJQYlRzcmtnM0tUM2p3U2ZKNisrdm9EaG5rYlR5ejFtTkwvcVJ5TjBU?=
 =?utf-8?B?eTBBeXJvc0VMeDJObVRKS0plVXhiNmZQSnJBZ2JnNVJNOGNJc1BOTWZadzNT?=
 =?utf-8?B?dy8xbUhEbzNXWXpISW9ZZGIza3BuVDBBcmhMY1RhTFRHTS9GTE90Q2NKOTRi?=
 =?utf-8?B?U3VsKzg0ZGlPUjlTUFhmV205L3IyL3lwSS82aE11RktMSUlndXhjVTFXVVo5?=
 =?utf-8?B?MU8wYS9zVDFyUGNscVVzdk9OMVNuK1U0NW85WUhqL2xacUlkU1BlUmdpRGds?=
 =?utf-8?B?UzhPL2hSMmx6VUhUTjZlUGkvelovaW5JSXJrTGdTOGV3dFdqVlBDWThPdWVH?=
 =?utf-8?B?N3pycDhuNUM2R25RWVJBenpGYXMvMEprV01ZekhsT2RqZzBZZ3hjdHlVN2JW?=
 =?utf-8?B?R1RTMVpOZ01EVUZuRVp4eS8xRTAxVmtKUkJndWFwdnJoSmpvdUFjdFBCZDMr?=
 =?utf-8?B?SldKaDlIL3hTc3BOTDNaTWlNUTF5ZEV1REkvc1EvVzhFaElwT3doeXp3OVpz?=
 =?utf-8?B?RDhCNzlVL1ozdkJ5MlB5YjJ2blNWZzk5bDBIZVJiRFd0Y3grVnpENDlTQmI1?=
 =?utf-8?B?NllkQTdndEFVZDBmL0xnWFdZK0pYYVMvN1U5b28wVFQzQWcrZHhLaHUwejVJ?=
 =?utf-8?B?VlgrL3Y1UnZPOXlJTUFsYkQ1dW1ielVHUmhoN1V5VEh3THhuRmpISnhtbXdY?=
 =?utf-8?B?MGI5ZDBJcXJxdTBMRDR5c2M4OThoNWJTUWh5ejFxTC9DYUNUVXJONU4rT0Vn?=
 =?utf-8?B?a0MycnhEbzB4ejlCeUR0NTB6L3M1WkFVZ3U5MW1MNzY3L2RoSFUrdHk5QWtS?=
 =?utf-8?B?aWNtZFRTWmlPeU1zU09TbjJ3clZoSmNjTHA5L3BxalNOTTV4bkVnVVpWdUJX?=
 =?utf-8?B?ZW9DRUd5K3lGeWlDelhQNkxWa2hhSXNJRTl0bkNPQW1Dam9KWUQzc2FkK3dR?=
 =?utf-8?Q?eC9xEDOGM+rK7yS4xR7jzVFGs?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f6255f-4cc6-441d-81da-08db89cf6d4b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:46:59.0249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pW2SSACajjScwYqnzDxFJFRqKjDgQGYKolViSop/ST3DOWC4v/rKKUARSTAiTCuB7XAzsu8q9fqHJj9nPYj0g==
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
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 195f3c5d0b38..a952804ff993 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -512,9 +512,9 @@ static int sun8i_ths_probe(struct platform_device *pdev)
 	 * registered yet, we deffer the registration of the interrupt to
 	 * the end.
 	 */
-	ret = devm_request_threaded_irq(dev, irq, NULL,
-					sun8i_irq_thread,
-					IRQF_ONESHOT, "ths", tmdev);
+	ret = devm_request_threaded_irq_probe(dev, irq, NULL,
+					      sun8i_irq_thread,
+					      IRQF_ONESHOT, "ths", tmdev, NULL);
 	if (ret)
 		return ret;
 
-- 
2.39.0

