Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A433375C386
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjGUJs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjGUJsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:48:22 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2112.outbound.protection.outlook.com [40.107.215.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FC530DA;
        Fri, 21 Jul 2023 02:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggBM+bqdfFHPmeWa/kBYl3IqgGG0WXW+VfsAEUwa39ct9DB4NVCkDPEpDluL9NG/tUxcVQM3nYo6kxeQaE6jsjlraHeUeHvtdKsRxrn8ZfOf+uop430CgF7eGOW9IbzMABnOU7hh7cQvNPTpxxfbR/aYohQqj/exoiXqbZaIsHqqKHTXVq6mwg+qG7yYDd4hf+3dCGKUmiQY1NXD/A78vzDgKbROWIEIPy+I/0Bx+jP+q05zt6jZadA4powd47Hr16TFOlrhF+rv9SlVaEgQRNgoD8urdlQdGGDSrMMthFWzmK+sl3IvsX+4ImziJi5w9lI5Bf1eW7aCUVmWrx2log==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLDhRPJ94KJ9YnANj8lefH54Ay4lhdCGR4Yz4x9Uz7Q=;
 b=n5V+T6dLeAhl8mTtGCEhlCwGYHoOYZO4uTCqtl8O4Q8Has+59uaXmJprLgmOPDwIxI4isqnT8GRDxFzYtiycb+l5u0wrNvTKpZjWGPFwe/eMzQ2TvLtODPHc63ZGMcpsItEfXxr5y0ORcE8Mp2X4GJXWtcAhrwMSedn7t6N99aJTqobVjk64FQAdPS7TrwwrlOFbCO9/vj0rjX/h3xsLLi5m0ecpMPEJCPHf6E4YsLb6L5mYhA/R6P3WaQFAL6jLHSBzduzUXv0PxLW2ZAlro3mhyaD6DyiTJjvF8CDJlJmQ6iRgdRoMdhA2co1S5X3Wo7zy1MenS02rkNJnxJ/l/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLDhRPJ94KJ9YnANj8lefH54Ay4lhdCGR4Yz4x9Uz7Q=;
 b=BSZ52gzXGJDO7PUwNkRSAiPx0o+deyRFm/crRhHu3eVjAe2tloasBCiEb2gdvn3zCAumn2KPevKcWivK+TwYhjTC3oZ0Y+Ta5N1dDOiwZy97z6AtDDDCDQpaZP15VS6KD51fiaRlxUxANWjIUtWVTp0R0BA1G6yTwctUNZjIFv1AxOh5dU0xJUJONw97qOwne/2piHsOfenevPWfp8YHxxvu7Yh44Ps7X3q9pRs+XSIDwsEDemZukXr3nuLOSRJJAYhqDVRiMmpnD3KjpFqS1qremp3X/7xkA09oFugLVTXRlEo9uYkDn6gTdNDDCSCdU4OlSJEC0T5QVVtuoMNsQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:47:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:20 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
Subject: [PATCH v5 10/22] thermal: intel: int340x: processor_thermal: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:29 +0800
Message-Id: <20230721094641.77189-10-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8c6eccb2-f36b-44e4-6689-08db89cf79d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGvDbGfXi4aorYe+CUHUkREmGZ3vrj0uMRcCStlCVG+bNEsfZEO2pfJ+3Xkzh4c9mTyZ0LObPNNhnIPYNthkgo8RQZAvmbT+oMb8y+m6rvE9eMBHikaCXWPIBWioIaES1v9vOHkfpECN2I2r2dZ/Wa15vwY4+n/FS/BErYoDFtr+m3MDvex6DgZkTKx4YVq8Exz4JRnmHBQfiGPilbhxAsfnHMBxrNsHXmiTqzIBx5i2N6q9aj0hbD0khCh7Wt59ct0d+g/ABY1juvIi1OEszsTUOlDsgC7mhu2HX9kkXBLEYmIUMQ50P1KBbw0OT995ooHjuX2iN3ROTPIXjEokbcT8EoPSbvJ5PigqD2opHdD2tdHcdtLaGlrGYg+Z6JB796eTniSmCtiRp2NpNT7pRioP1a4xeqasOVk1/va5V4yVbtau4sT3o6SPAmCYsi0P4sDTKzSuCa6tZn7VDCFKXkCTlNg640whva41YhnQroghjqKIQHKP1z/bDCC/A0kJBJ5PmfTrk/rXW5a9c+qTTrvdnsaDN4rJKAR/tYO7b85UUzFeg/tHkzmrd0dsl5X3YhwYiMhoIA/t/7SA8qhnE8jtinMMikxGn43Et6uyy7R+03H7uVRYwJCgCPmu0i1M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(2616005)(2906002)(38350700002)(38100700002)(66556008)(316002)(66946007)(478600001)(6486002)(41300700001)(4326008)(6506007)(26005)(186003)(1076003)(66476007)(52116002)(6512007)(110136005)(54906003)(36756003)(5660300002)(8936002)(8676002)(86362001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1F1djJxc2tBckNrRUkxRWJFOEJTNlcyQ1QwcHVyU2tDODNyTUIrRDBBU1pQ?=
 =?utf-8?B?emJpUER3UHpkOGhXOUdtVjl5ZVJWMytZMDR1SnFueFBWSUdyYmEvV0Z5SVJy?=
 =?utf-8?B?TC9IOTQxSHkrMCtEdWdDUFVwdXNGTzZZTmNLeVFHS2MyOWlJMFUyc2xKUEdG?=
 =?utf-8?B?aVYyOFV2YnFnemJxamZuY281bzdWMS9UZ2ptK3VZOWc1YllTdEtxSm5pRjVk?=
 =?utf-8?B?d2tqeUhVMWluWDB0Q1hoVEU0Y2RSVUV4V28xK1Njb3VNbk5NRERMazFreVRy?=
 =?utf-8?B?ZU16YUhUY2IzdWRjZFpXNUoxY1hiYVVxK203blZWN0VPcjJZZ1drbGV4QkM2?=
 =?utf-8?B?b0FHRGpoQUpvMFRXK3JodnVzUnY0NUpxTnk5ZGRVaDlONkpGM1JvM1ZMVkdP?=
 =?utf-8?B?VTZtaUVGczFjZGZnUCtiZVlBcGFpYlVyNjV5eEo4UitUNFg0U2oxOG1uVTM2?=
 =?utf-8?B?NXRUcExrbFhJeXZDNVVpWWlQbGI4ZlQrRmFmVU83OFEwSkN5UnhZVGxQQXAw?=
 =?utf-8?B?dERzUzRQSG5zNlM1MVJIVXVEam84ZlJTUndqbUszOWIxLzRwTjZyM1hKdklp?=
 =?utf-8?B?TThhSEhXRkpXU0JnTUdHTHZpekhTcGJNQ3Q0Q3N6SlByY2FjdUROREVTUDMr?=
 =?utf-8?B?V0xLOUtuNkJ3V3k1WDRwSUxoUlBUMDl3Rm1HS1RvUUxGMGNzamtvc09xakdr?=
 =?utf-8?B?NG9IbHgwbzJWK08zNEVyVzJad2pJQzZETWROMEpyMHQ1Z2hEbS92dGVhTisv?=
 =?utf-8?B?azVxU2JMelU4eHFTWWhLcG16VXJZQVRoeTRKV0thOUpiWUNHMldYZHZKNlFu?=
 =?utf-8?B?YXU2RFpDdjg5UFJYRHRkaTFmZENwbUFhUjcybEUwOHBHN0tuMUJuSll4cVVi?=
 =?utf-8?B?cDZIOUg1TWM1UjJ6YS9BS2FYaXFCKzdreDNmZ0NoeDRXbFdFMHlXbnQzTmtx?=
 =?utf-8?B?Qy90bTZQMW9jcDFKMndkaFllNGpBOXVVL1hDVW9sQk1lN2YxWXg0RzU2c3dE?=
 =?utf-8?B?ZUlTc1VEM0daVE5OTkZiTmRSM0EwdCtNTWp4Qmgwd001UVNDUzVhNGU0WlA4?=
 =?utf-8?B?SisyVlh2ZHBoNnYxbTN1VXRDRDQ2b09aV2tOaEZzRjl2eGF0aFN2ODdZVDF5?=
 =?utf-8?B?dXZ3STZHeXEycFF5WTdtNUhmaHdBalpyY1A3YXgvcmxzT2pVVHFHVkdNYkho?=
 =?utf-8?B?RGNiNVl0NTVOUDl3eDJXc3VhSDQxOGYxenNEczIrSFFwcXl5cDgwVlc5bStI?=
 =?utf-8?B?OFZIelNqbDdOTFd3NGVGbXlYVzYrYm9hWnZCR0NWdU9iSzFVYXVxQ0MvaVJS?=
 =?utf-8?B?eWlDQWpJSWpnQ0pTTVpvcmRCekpEMlBub3U0TnNGSzM3bVRMWmh6UG9xV1la?=
 =?utf-8?B?ODd1ZUFwVEhQRkFyeFMzdTArcVd2WFR6Vy9pNFU5czhDeTRvREdwRkxyeVVx?=
 =?utf-8?B?VHRkL0RLYnc4ZWdoQWVBZXU5ekVXOVFkWEQxR0RSeDdxeVNCai9rS1phbUFR?=
 =?utf-8?B?cXU1aXBxbk5xS0NXbEVLdVYzYXBtR3hSTE96WHZJOTZ0L2ZEVENQTTN1eFkw?=
 =?utf-8?B?OTdDVkhqVzYwMFYzVzl4U2xpM0RMdnpubUhETHpKaTM3cyt4Z0IzUkh6UnRj?=
 =?utf-8?B?MGk3SzhVV29pRkx0Rm95d2lMVGZySFpId0V1K29BYzVRZlZMRElMVUh2KzR4?=
 =?utf-8?B?UlIxWGtvK29uQityN2pQTStWakxKZmhuNWZsd1ZmblRoQllJdm1YcWQxZVRR?=
 =?utf-8?B?bUlBUVVhNjZLMjJqQjkvdmJLWjhrMHlNaTg2SmNQQlBrbUs4KzRuYXJUanVs?=
 =?utf-8?B?dWFIcW4xZUlhaUVNeGNoa0sxRE9YcjJ6cVpENXNpMFdYRWNYTkxBaXRjQnZk?=
 =?utf-8?B?M2xidmNSOStsblg2VlQ4R3FncjZ3dGYwTlR5Z2ljYzNLUEhNODZHbExLRFRn?=
 =?utf-8?B?OFV4YXhpK0lZeTBna2xMY04xUktOZU5GK1VWc0tIMGIwa0Y4NDN2YjFTYjcr?=
 =?utf-8?B?OTZIYnhFQzhqLy9lUzZPYzdmVDFwcEwrS1UyT2NrenVROWJLanlRYmtHdnRO?=
 =?utf-8?B?UzNyQnRWbW42aHB0cTg4bzVLSWhXbGdZQ285aWlWZTlWMVM4eHZFenBwd3hB?=
 =?utf-8?Q?NyYsT5GWR0SPUQ3LFCwsmsGqP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6eccb2-f36b-44e4-6689-08db89cf79d6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:19.9843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzftlrL+dayb8x4C5+NMUQSSJBChHW4uGfhD2tVFifS8msJgeix7MIp4/JSNudi+nLuWcM/bz0bqJp1jaFrgTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6789
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
 .../intel/int340x_thermal/processor_thermal_device_pci.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 0d1e98007270..ee766904b314 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -258,13 +258,10 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 		irq_flag = IRQF_SHARED;
 
 	irq =  pci_irq_vector(pdev, 0);
-	ret = devm_request_threaded_irq(&pdev->dev, irq,
-					proc_thermal_irq_handler, NULL,
-					irq_flag, KBUILD_MODNAME, pci_info);
-	if (ret) {
-		dev_err(&pdev->dev, "Request IRQ %d failed\n", pdev->irq);
+	ret = devm_request_threaded_irq_probe(&pdev->dev, irq, proc_thermal_irq_handler,
+					      NULL, irq_flag, KBUILD_MODNAME, pci_info, NULL);
+	if (ret)
 		goto err_free_vectors;
-	}
 
 	ret = thermal_zone_device_enable(pci_info->tzone);
 	if (ret)
-- 
2.39.0

