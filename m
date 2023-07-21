Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BC875C39D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjGUJuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjGUJti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:49:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2C13C1D;
        Fri, 21 Jul 2023 02:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaSvtVA8WOU9YZTnb9NU4Cbw3W78DOV1+OdVlVuZ0ky6WIAy3TLk+36ijwKLToONA4hF9G9BAoHte2S0TzVeSDLk4wzJah5vF2bEZ1Wf350WQeV52m1o01ALJQZSM904JEZ1+/qvVRdIGqn3tSl46/h/RK3VUlesGbAN31gCamJpNA+rySUIcvoutmE12PWc1fSx+tYetiSBDJSEqB7BKLLKXSoO46AGnPXqp7oNwMpzJVQZsCRfHsTkuj08rxvnNbekZ08qsSQLxLwqxHklGqfRNjgHcnPjbltO9xkU9yShI9mvrZ2+GsK4pfv8eyDNoh7pQIzU8rkKt1KCa1V8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDVGgpitxTT4QdqfnkpzTt8ouLLBgOS6RWAujk0isLI=;
 b=C5CbYOSjPBsoBhb4e0e39IyZEGIU/Yvo6a9Sk/fqxi5X42XJwQHmkFkA9jcFTDFne2X+WGtLEMhC3j21cAZwzsk26Z8XCL/tli4AyrefuVn/crvfYvq63MhOSqlVHiyu+9AWK8vMQVpSv16GQohdNTI3thmsX9gIe7M/YsPjEjHFT2hxiVSouIg4dvV8enWS/di3Keo9Smk2KFiU2ExMJjiFz5HkignF1ItiQfEprpx7NHZYQKoIfVoO0sMP+itTtdsMgaDbHXAzncz9cDLMe1XjDc+vcNzuZFai/NBp/p6iTAf17YVKvYkAWFE2OlhPD5KJsqF7XENfYoJqhga0Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDVGgpitxTT4QdqfnkpzTt8ouLLBgOS6RWAujk0isLI=;
 b=WMNetiS9o/NWbhoqQeem0ItQ5BWoNQOPMaAH9bY2v7qyIKjUsw7PprP8f1DnMf7LUEhg1T3ltH4Z+9P4f6WAf9UnCZgesms7U7EwMN0nx5+UVIPPn3TP3h9zIvQlNPm6qe4WVgSB7/5YKWMmu5pFwJ7he3q+rb+6tc8wWiGI4HfUYzNNOVxi0B1a65/CLyifTRlN1kGdE2wwAQPlPiQpf7EvEi3S/KOz5E1wxuzCwzsFBl2PWS77kTlnBx7Mtbu91uKmK0l/2FbJTEjWaDChTEBh3vZ+Lpw6x30fwGjWugvC9EG1l+4jTVWkuZHDLYwiPRV9HEoggcnZXRL8loF61w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6311.apcprd06.prod.outlook.com (2603:1096:101:13a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 09:47:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:45 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 20/22] thermal: qcom-spmi-adc-tm5: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:39 +0800
Message-Id: <20230721094641.77189-20-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dac6673-6c6f-4d9c-f323-08db89cf8935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: srgO8q0mpqgKBoKgZ+JcioeFAfus8MhZERhiFSAF9zqjDEXLhewOFSxvd11NCi+wWLIHSNkeAV1kq9DoElEzO0co2NewFuAuzJkvtc9gO4aZb/qYdKbmqBOAyGhZgUrAj2XvVhBuwDeMAmoJwehkYVM69LBjewtkAM6F3GDz6eyMrgR7P9Y46ZNjBtim2YNnH1+pOA5NRW37LpRiF/v+lR3Vw/wQDjCVANzJam77RxqSv88la1cTSN/XSXRU+JxlIzCVBFEek9inJLS+EpiyszWraug1j8SwDBo9oLVJ/fCaSSMTcKSEvDJNsmlCRaHL1wJQDyXFzTjn8h5QBT9l9jR/2EOzIMnPyunzkmmBewkVi3e/LYYzhWKr2HQg+69MXBf1umSfHvJ6zmWswu/LX4i29lWRIW2fpXVif1ypckQA4xxlkniIdTVV1cHBek2FH97FRFRRC85CzjLkcpvbUSpj2YeHVdweF+D5P6QXaihNpgcPF8GErsQdOvLPtN1rp6jqZ0RMgWVDvUyU5GPL0PExUBggCmHi436x3g5U9wEzYnGKlfG6bq47rmPKv4mSRtODiNQDrCQqxNkXuaFIMOfZxwloWMnORwpw21Ik/zTuSSLLM1Er4eZbabwKTjCk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(54906003)(52116002)(6486002)(6666004)(478600001)(110136005)(6512007)(186003)(6506007)(1076003)(26005)(2906002)(41300700001)(316002)(4326008)(7416002)(5660300002)(66476007)(8676002)(2616005)(66946007)(8936002)(66556008)(38100700002)(38350700002)(36756003)(86362001)(66574015)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmFHYnI4NHNCUU1hc2pncnRzUGY3d050azNYVEM2M2xRcVZnMENqVHVmSlR4?=
 =?utf-8?B?K1lYb3ZvclBrRngwU0x3Kys5TnVKeGZjNTVXMjJ0YUV4QU4yNmpDYXpnVTE4?=
 =?utf-8?B?ZGcza1dUYnBKREhNUHhCbzJnSEZpajFHa2VISCtIL2FHcHZkSEFqZEIwdStW?=
 =?utf-8?B?TEVBRWpIYnNtcEd6bFFRL2loY1dQNWx4NTRLRlFXWUkvVXpYZm5idzVsMWVj?=
 =?utf-8?B?UHJBODNmWXNmZ3M1aGZ5Y2xjMjNScmIzV0l3TjhrbUxCc0dPYzhZbEFDZWJR?=
 =?utf-8?B?cDQ1SkNUdzUwc3A3cExlcTZoWTlGRjM2bW5OS0taRmVqTytESXR4R1BHMDVr?=
 =?utf-8?B?WlZDM2gyZVZQNU1OR2dYUm40SExsOFk4ak5LeUdrZmlwUG82em9pSFpoeTJU?=
 =?utf-8?B?LytxK1hPcDloY3l6dXdMQXVhTFNIZ1loWlJQVDNKVkp1YzNQUXVKNFQxMGVN?=
 =?utf-8?B?ejBzNG81VlVTNm9xcFozbmtmYXFwYUJGNzA1V0ZZYk9kSXRvbkxwNnlTOWJC?=
 =?utf-8?B?bUErOEp6VUd1N09Va0pDQU9qci9MVzZBUmJNYnBQUDg2b3MxR3ZDL09YR0kv?=
 =?utf-8?B?SE9CWXl0ZGZxTVphb21odmgzeVlpU1BqMUdtcERheWdwMGZSOHRMaStteFQ5?=
 =?utf-8?B?b25xRUZaSDJTRHdnUlVTVEVjamdXTkM4Yk5ndjI4RTAwMEs4bi9PUVU5QXlW?=
 =?utf-8?B?cmdzZDl4dS9XRHpiQ3JGamlFZUw3a1dzSWZTUGllUlVsNVFuempxQWhkV3pV?=
 =?utf-8?B?QXdva0M2T2tiRmFzUE5CNW0vQWdWN0JQQkpCc1d4U2hDUTZEdTFiaVVnNU9R?=
 =?utf-8?B?bEliQXZ3NHVWeEpZZ2NheEgzZlJwd1NPQ1dLcU02YXpjNGhVM1plY1hETXhW?=
 =?utf-8?B?NjRjVkRGcjE1TW01OUtUYmhOZkVXY1k4VDhYcDBoYitqTFAzVGdlelBDTmpV?=
 =?utf-8?B?bFlKUTFIazUxVGZMclFOK1VGOHdOb0lCREFrUlVSNzhHTTQ1QXRjQnV5VDUz?=
 =?utf-8?B?RnZzVmprYTVCa0NmYUo0RHNIR1FFd2xrNTJRcTg1aW9IcWJXcnYwTFQ0aG12?=
 =?utf-8?B?REpzUUd2RmhETGdVSWg2aXFNODdhUGpJb3ZnNmViOTltRm55SWw4dE9sdDFa?=
 =?utf-8?B?ZXZtWjdpcWkyT3hkcW1wYytCd3VZQ3kxOEd3Nk95ODA1Y2lFenVUQlFNZXVy?=
 =?utf-8?B?NkYyZmMrbithM2IyeURSMzdjN0F1d2RaTXcwRXhCcjBBUnZMZTRJT09xK0xK?=
 =?utf-8?B?dkpqZ2IwMjRZV3h5SWxXbTZZRnlzVlAvQ0tYaDRxL04wcTJNOUwvWlMrMWo1?=
 =?utf-8?B?K05EaDg4MmtYaG82ZW1VdmJmS0d0RENDTDVIUlEwU1FHZUxUb01jeS9teGpE?=
 =?utf-8?B?b3pNY3ZlL2ZOZkZwUGdIT0lPVmh1Yi9LVnlOamNyK1RKaXNGMlZXd2JOc21u?=
 =?utf-8?B?anBUbUp1cUlZSG0yRXRNQXpIZmIzYnFEemhHSEVhSi9zQy9oU1N6c3drdVM4?=
 =?utf-8?B?ZENnb0xGOG9NczgzSmZXR2pxRjQ0R0FKMG00U3hDaXNoVTFwd2c5dU9rRC9B?=
 =?utf-8?B?ZnN1cTRFL1JDS2s5cTBSTGF0azU2VExRckQyejZOUCs1Y0pHQy9MVnc4RkhU?=
 =?utf-8?B?MkdyZHVlUzBZTjZwT2dHRlRwbXVLVVhXNFVDUWVEd2d2TTYyQXM0aXl0WmY0?=
 =?utf-8?B?NVVTd0ExWGNpMXFhTUM2M2RCc3JvUmJEUkVYOHk1NDlpbzliTmRjV254Mi9k?=
 =?utf-8?B?OXc5UitMT1RhdVV1WE1vSjRDTnEvL2ZERW90RjFPUm1BU0tBWmRERnpGVVVh?=
 =?utf-8?B?VTdGbkVRa2xzQXNSYmRmaUx2TTViQTErTEkrZVIxREh3WlNmeHRHMURiMld3?=
 =?utf-8?B?UUNpM004eTBCK2kwZFFkNHQ0N2JKZHlnZVRKUkU2c2MvWHk0clA1dXRiK1g0?=
 =?utf-8?B?MFJSODJ6WUVjaEZqRUhhZVh1RklpVmQ1Z1RXVkkrNkdZa2lMQVdLZGo0NkJZ?=
 =?utf-8?B?VHlDdndtK0tWZkEwQ0d2V0JVaUtSM1RPcDRva29LWkRjZEdFb3ZGZmQ3TWxu?=
 =?utf-8?B?WGRYaTRSbHVTeUN5dW5FWjI5NTh6Yjk3bmNjQ3R5eExzelAyZkwvN3VXeGdO?=
 =?utf-8?Q?Uo+vLQfADWszfFQ9CWUtDYigZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dac6673-6c6f-4d9c-f323-08db89cf8935
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:45.7886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bln0xofjKsrV1z3kn7cqGyKU6+dlyIcvr24REKgnsOO169NSSeYnIuf3p119QYN7cZ423FF/o/ubVHa3XgOsfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6311
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 5ddc39b2be32..90d46dc60806 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -1044,8 +1044,9 @@ static int adc_tm5_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return devm_request_threaded_irq(dev, irq, NULL, adc_tm->data->isr,
-			IRQF_ONESHOT, adc_tm->data->irq_name, adc_tm);
+	return devm_request_threaded_irq_probe(dev, irq, NULL, adc_tm->data->isr,
+					       IRQF_ONESHOT, adc_tm->data->irq_name,
+					       adc_tm, NULL);
 }
 
 static const struct of_device_id adc_tm5_match_table[] = {
-- 
2.39.0

