Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DE275C365
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjGUJrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjGUJrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:47:07 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAA72715
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:47:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZF9tVg2gJqNJ+PZrKIQ71MJ+og3AinHuKx932B2I1siTt58soODavXoiJMnBKA5bGjWtOl37C6YZHdf110F8AF2CBrmnG8WLhLh9rb4F2Sj6chsv9LJhljQ+nt4rwABBkqN2vfz3sRXbiBRY23bZriq4pUfbSUoKgft7qOV+VTFGNgyQxZxjPbVRp5N2wHCSy9CsxSz6TE9Jnoabuq58bHbh95Q77bnGtm828sA2gXOvUPE+zfhK43pVANoAKji2vHksV3oAjjPPsJJN23D7ImRRIPrJE71/1c2691mv366mhPQjyp7jXsyVYb0QAr5vigpfDK6sIsSY4wjBWMnhBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxSaJcUJrOhYfCgqHyxB2Dz5FjATs5FXCAzpxy8vL+A=;
 b=BCicPA6lCdQAYIdlHzrApMGxMY/fw5uqrOP35LnlvvAQStKz1czH5m4/ISno3XdH+ODDRjJkKSMfaxgaaGQb30SDnBdQwbNwqqhhsWOIrZswzQidyDV2cBYy2FSQuwh9XfRQbUlG3sT3iwvAERXsQT+Q1tFH/Q4CLQVrdEQmCgqEr7ntKaxoAIh76HcdpKplP+KyArScwQb4AthmtvrkYDsqTtiamWSHzhdD+6a75ueoKkA0R8beeoD7GEPHXGmx3AvkEx60p351SJ/ac0fSKDzYUbXy6WxGYS8uJKb+/6HeE/8KPowSCiB7Ic2H599zOKU63cIdOEgTCc1/adbj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxSaJcUJrOhYfCgqHyxB2Dz5FjATs5FXCAzpxy8vL+A=;
 b=LIlmhHl4RwO7jdDkbLswj1Cn7osX7s44UC2ka54T7KRE3sVlMd5h9usKb3lO3TLhLCyavOcKSLq/zs2sILowp/JGT6BeM36YgtqHhFbG7+ZhrQgknrbDNKcRwmpbe2TeH4sxIH3SJi5C/kBksRBctEnAwY2YH+co0ZW8uE25wHkMPeFnPj6LGVrXS8PhEvpXt4AkykakaG3RQ7fENkZ01c9+3KXIUGEDPl+Cnx8kKMbxKAAoz0RCQpozRgPo2K1b5KhtBJi8gevc15FWbFOYKHERZpxY5bY4LR9lyufwlQMtCeETX4SAB0QOYQouS7dDRi92uTTCmglR7dXxcbVqpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:46:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:46:56 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/22] genirq/devres: Add devm_request_threaded_irq_probe() and devm_request_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:20 +0800
Message-Id: <20230721094641.77189-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 297f9694-3ab4-41b7-0ff1-08db89cf6b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5X+wXCgtxZSOyFtPTy8zq8sNdGDL07VuyNexTis2Y/rERr1+WKzEtrCO2Bz908CxTEI8Jz0ulQMgWxtCEJvQzQtQzMXmVW5SRlWZelgrRaizY3QLFuOjbGX9s9+UW2lS3nW4UAHb5/+9vo8Ql852ocJKppom2cf5WSfHQuu2TqtcrSP0vmzSl24dyog/vcK/zVgnBlgW4eiUDj2yTmOYs2GFJrjhEyX+1ckyWn0hvfS2iV9x3c/Sz8vtX4SzCbLVnpnX9au8IF3eyqZyB9i1BHv96GcqRogsoEVzohUkkSGsguL0pkI2tJgOYcAMYU3j0T8bP3vCT2esGhNuJphZYez8FAGegusQSn8APdZjN+GI2AHgQT6XRZNRvPhyD9dduqm7/A0d7XQJTSHmJj9CJ+3fvJimZNMgDHmTVwVIzGgq8qp9wKNDptuqZWN+bbTO6Qlb8rgusgtTC8r5L8GtXXxu2mtKyaS8rWeWdvXev8HY9UW1lJHeasEz1R1NLdyjsn2jgOKP1iPYvdCWaHt3Oj7Uk/zf4QlvQ0Q5urcTVNdp8MPuWY5JP1AUOtw62tXfUs8Z5QrXGnFa45RCL5GzKiX20kNVSPZhlb7FJoUEknCyCwGPxoqKWy7MS55Beht5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(2616005)(2906002)(38350700002)(38100700002)(66556008)(316002)(66946007)(478600001)(6486002)(6916009)(41300700001)(4326008)(6506007)(26005)(186003)(1076003)(66476007)(52116002)(6512007)(54906003)(36756003)(5660300002)(8936002)(8676002)(86362001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFNqMnR4VXpBNXhDZjRWTndPQWVyOU5jVTV6OUlFYmxBTmlkNjZZaUxmT1hG?=
 =?utf-8?B?cmw1SlJ3SFJGVFFJbU5QQ0lJbTV5MEpuaEJGMjhCWFdwUlJaQkViL0NBaU1t?=
 =?utf-8?B?aVpJS2sxeG83ZG8vdU1LcTd5N1lWUHBHaEJRYTB5UGVyN2RmdnZYL3c2Y0Nk?=
 =?utf-8?B?eHVpekQ4azF4S3dyTDFpZXZuZWFlMllsSkl1SDh3b1FrNUZURGZhNHRxREFz?=
 =?utf-8?B?c2lYczRYcGZHY0dHN3lRcGhSQmMwZTdwTWJxSm5qNFpkbWN0OFB4VkJ5anY0?=
 =?utf-8?B?TTZkMTJYUWZCT1NuK2lvamJEcHQ0SE1TQUtOcndxRzltREM0Ym52d1AyYURX?=
 =?utf-8?B?ZnRqQjlSam0zZlU0Ymc1cnlTQlZqWVBtOTltVHRzc2Vxcis3M2hGa3pSY1ZR?=
 =?utf-8?B?SUt2ME41TCtOYXJIa05KdHRnRUxlVkh2OVJPeFBuWEw5MEI1K2pjUy9FaG5Y?=
 =?utf-8?B?Mmo1UGE0K3l2NkRjSXgzbXlNWHplMlFoWGIyZ21VeDlwZERxM3RCOTdkWU9Q?=
 =?utf-8?B?aEx6dWE3Vnl2THEydkRsL25NRWg2Rit5T2Z2QnZkUE9OWTJ1dU95djRlcldn?=
 =?utf-8?B?K2VIOENoS2t4d2oyOVYzd1N4dUdWMXZHdVNPSFdhUnhnYSttWTZOQmR3UERy?=
 =?utf-8?B?T25UNW1zbDg2WnV6N2R3MEphbGtpMzUrdVh5REdrZXhZL2xxNjlLeUhlbU4r?=
 =?utf-8?B?SE5Qa2w4ZlRMR3NDV29KY1Q3WWhlOTJoV0N3NDU5aVpFQjErVXpaaU82Skhy?=
 =?utf-8?B?QkdmcWUyd3ZLUWMyZHduSnZHcE4rb0hlanBpZE8zSXRlZjdiNWxkY1V3eFA1?=
 =?utf-8?B?ZkNpVENveG9TRVBKcm82ZXlNYzk1bElpUS95ZURzNm5VUkVOd3Nwd0ZHbnk5?=
 =?utf-8?B?cUhHMWtwanlSQWJVY3ZSY2VmTEtFNTFsTWxTWHhpQzIycnRwV2p0RzJHU3NB?=
 =?utf-8?B?SEhxVHYvZXl3UzFuYWtZNHI3VU9hd3hSeUx4L01mVUtpYTVtSFFtWUl3WWhR?=
 =?utf-8?B?N0VWbVIydUV0K09zNFlsY3Nxak9sWEtHOFpReWRwMldZd1JxVHpBOGRkRGkx?=
 =?utf-8?B?V3lSZzJCWExHWjJtN0ErWFluekRNZFllVno0Rk1JSEhaR0w1TUlnYXdZazV2?=
 =?utf-8?B?dWgvcEEwdE5PNFI1cFNyMmxlNktyekZ0QnFBdzRIczlXOHlHUDJEenpRc25V?=
 =?utf-8?B?WGp6K2VETHZSNGR4azlkaTQ1Z1YrNEM2dGE1UW03KzFhYWdCWDVFNWFlK2Zn?=
 =?utf-8?B?L2NMVGhMcWZaWlI2Zmk3ckZJQkUyRGIreHJ4bGh1SS9rNytyWjBEdS84VjNp?=
 =?utf-8?B?NVArOWY4c1NmVGJYZHNsWGl4Q0N6dUhKTGdOQUFvT0ZRUVp0T292UkJSZStH?=
 =?utf-8?B?NEpMQjNKb0hmUlZLbm1JY1IvRmlmT3NuMEZ6VUZRWi9oS01PWmFKNUVOOGM1?=
 =?utf-8?B?UE1USmNoalh6dWxIUEQ4c2gyRzFYemJUWGdTQVVnVVptNlZVWFBkdGx4dHA2?=
 =?utf-8?B?OUdJZ2RQSXY1YUM4WHJ6OTdNazErcmpHV04vZW5qTEhJWFdoQi8yd01LZ1RF?=
 =?utf-8?B?NmhVQTNhRXVqTStMMEQ4WjhMd0s5SVdDY25hL0Z2RnFWVU92dEtOeVF2NjZs?=
 =?utf-8?B?em1BMkE1SnhaZktzRXRMcW9MS05qUGNITTFtNEJxT2pUVjZxdnpBQVl6WW9Z?=
 =?utf-8?B?MjYwUlhJUkliVnFySTBYU2VURGlidjJROXdLZTdPcHR1djBSVG1ZWklFQnZx?=
 =?utf-8?B?MFAzb05NeEZhU3pCeW9UZlhZcWtTdXlmSStyeUtxY0J3NjRSbm14Q1ZlOG92?=
 =?utf-8?B?bXU1elVrazdzM2FrUWt2eTM5ZXJ3TUpUY21kQysveHZ0eFYzc3NFdi96ZG9k?=
 =?utf-8?B?dzRIR2pZOHIwcXovenUxdzNVMHVSd0xzdTA4ZGJURDc0MjcySmJZMW5Zb2lw?=
 =?utf-8?B?elNrdnE2VGRWeVZNN3lpWGhoTksrakdYa0x5Y1FJcmxrVzk3ZXBKd1pmR2lV?=
 =?utf-8?B?dHd5NFMvNHRyNkUwejhFdUc0dmJwc1Q0N0wwTVhJb0xGV2lZRWJZaTJoQ3Rl?=
 =?utf-8?B?bHlJQUhxYVVCanBIekhBWEhPR255Z3E3UzFNalV6YVlKMy9ja2IvelVTNTZ2?=
 =?utf-8?Q?tlkVFQe/h0+glLAfy2KbzczZk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297f9694-3ab4-41b7-0ff1-08db89cf6b7d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:46:55.9916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7zPzqvDXuIn/GHACqUOFYygyiqikSHUEMzinnEq4hJD1Y6rx9yFX2DNytUP/6nvXghNGN6y5p+2xNNj4YrQzQ==
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

So add devm_request_threaded_irq_probe() and devm_request_irq_probe(),
which ensure that all error handling branches print error information.
In this way, when this function fails, the upper-layer functions can
directly return an error code without missing debugging information.
Otherwise, the error message will be printed redundantly or missing.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/interrupt.h | 15 +++++++++++++++
 kernel/irq/devres.c       | 40 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a92bce40b04b..60a3d3bdcf45 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -201,6 +201,21 @@ extern void free_percpu_nmi(unsigned int irq, void __percpu *percpu_dev_id);
 
 struct device;
 
+extern int __must_check
+devm_request_threaded_irq_probe(struct device *dev, unsigned int irq,
+			      irq_handler_t handler, irq_handler_t thread_fn,
+			      unsigned long irqflags, const char *devname,
+			      void *dev_id, const char *info);
+
+static inline int __must_check
+devm_request_irq_probe(struct device *dev, unsigned int irq,
+		       irq_handler_t handler, unsigned long irqflags,
+		       const char *devname, void *dev_id, const char *info)
+{
+	return devm_request_threaded_irq_probe(dev, irq, handler, NULL, irqflags,
+					       devname, dev_id, info);
+}
+
 extern int __must_check
 devm_request_threaded_irq(struct device *dev, unsigned int irq,
 			  irq_handler_t handler, irq_handler_t thread_fn,
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index f6e5515ee077..40494eabb060 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -79,6 +79,46 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
 }
 EXPORT_SYMBOL(devm_request_threaded_irq);
 
+/**
+ *	devm_request_threaded_irq_probe - allocate an interrupt line for a managed device(recommended)
+ *	@dev: device to request interrupt for
+ *	@irq: Interrupt line to allocate
+ *	@handler: Function to be called when the IRQ occurs
+ *	@thread_fn: function to be called in a threaded interrupt context. NULL
+ *		    for devices which handle everything in @handler
+ *	@irqflags: Interrupt type flags
+ *	@devname: An ascii name for the claiming device, dev_name(dev) if NULL
+ *	@dev_id: A cookie passed back to the handler function
+ *	@info: Optional additional error log
+ *
+ *	This is a variant of the devm_request_threaded_irq function.
+ *	It will print an error message by default when the request fails,
+ *	and the consumer can add a special error msg.
+ *
+ *	Except for the extra @info argument, this function takes the
+ *	same arguments and performs the same function as
+ *	devm_request_threaded_irq(). IRQs requested with this function will be
+ *	automatically freed on driver detach.
+ *
+ *	If an IRQ allocated with this function needs to be freed
+ *	separately, devm_free_irq() must be used.
+ */
+int devm_request_threaded_irq_probe(struct device *dev, unsigned int irq,
+				    irq_handler_t handler, irq_handler_t thread_fn,
+				    unsigned long irqflags, const char *devname,
+				    void *dev_id, const char *info)
+{
+	int rc;
+
+	rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags, devname, dev_id);
+	if (rc)
+		return dev_err_probe(dev, rc, "Failed to request %sinterrupt %u %s %s\n",
+				     thread_fn ? "threaded " : "", irq, devname ? : dev_name(dev),
+				     info ? : "");
+	return 0;
+}
+EXPORT_SYMBOL(devm_request_threaded_irq_probe);
+
 /**
  *	devm_request_any_context_irq - allocate an interrupt line for a managed device
  *	@dev: device to request interrupt for
-- 
2.39.0

