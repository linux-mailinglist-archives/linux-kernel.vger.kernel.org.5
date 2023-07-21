Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DD475C36B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjGUJrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjGUJrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:47:12 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ED6121;
        Fri, 21 Jul 2023 02:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlBnFID395hIWZq+tA4uOukFYY/FkZlzQBu5zT7tVw753PX1Mhl8sSR3dBx/RVzpGiYjD2rWZ+NBEX3quNO6+rWlNUOEgYsnWHL4m2gMVolNw6WAdgzRkp4v94eTV/T9RIscjE9vNxDAFKUC7Ci6m3uskBfqF4qvLoBPukAAXHg+Y6cwAnOe46Xul3XbkmEW1u+rNRyQ1ICKvrQp/d11Fjs09F+OZyH++eAMAAVoLccJKM623qD92AxNoryJ8uSCVsTH/AuApHEf4V8tK7tqfDh6jWwEnh4VL7HRkdaOHJJ6dJ/sk8sWn/DmIJzedjZetO1b9GMx8BVKOhxMkpnmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZN/WFcRaP+9FH5BrXgS8aXZCGQPSUC13FV+qNWDPYY=;
 b=U8uyrTNEWl0DaPNn1ufB8CWc2L1LtbjtMJs1Oco2c3tsmVq/EYJHqWUf3nBX99nblJcrMcfHZrypNlG5jllH+9O2MA8Y/uRjri7FnaOd3DpJuIrLn38p4SlkIOHIfabQ6Q5cNziRNjl2O9dtYw9XeOmyT+sfcmZdqyUyrHX2dNLuBhXTQVRECdfW7M/fmLXZe07HGcH+X+nz3+edIMP8S3771Jh+dvh/UI9gKLMYcvdYZd/MUYX5FEjMvW3w4ebUiL1nQoDqVV7kU7uKTmHJ1UZLC8HtgJwS1YJSHEOMvlTmmOT5Y1jY/KTErdyvRxcPi1Bx12M03+m+doTRMCzrbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZN/WFcRaP+9FH5BrXgS8aXZCGQPSUC13FV+qNWDPYY=;
 b=ep9CqEnu0mGdkvWCRjA9ppnKJJ/8RruH02IhFwNlq2QTGBI7i9rSHhrOkwKqyvg8cQaX25hxUHUiOA7WFPZjQJYL3DBufGquc//l6ErW5DPjiMHsayg18MnmFWUL/yPYx8k/e5oE9Dh67mhpn5qoEvEWPbMZpED4JsIGD3QNtELTiQd/lratoa4uPZQRg4/WMVx4pmGcK9NmruLkH3pLgKa57AYYKWFnW11azTwz1IfbI87vUohoIf5EIPxtUbpj7zuUDPpFQ7M1rj/+JhOTWkak33ZEr+vmSfVfd859CHvvJAZWU4PIdW0r6XrTNTHHNlHe1mn1Jd54rwFiJjsLCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:47:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/22] thermal/drivers/tegra: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:24 +0800
Message-Id: <20230721094641.77189-5-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8586879e-d2ef-4691-cb8d-08db89cf7265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N1R/WRYUXWBRTlE/G6rI4oDPrXXitKWVveITneUu59A89PbAwXLRDrsboXQb5ia+kPWCK7OCn8eKoxNNciLT88c/jwRpVRMKqdGH/lN1RJ2Y28Hl/oZ7YnpCqDR7Eq4PPwYNb15x1Inna9Dc3QBYy0wTmlkIkMroaMNxD9LghV4+sR6qoJYp/ov8FB3y/GBoduKl2spiMtozsG8s8XlKgGM/DR1Ujx6PQ4tiv2UnMvuqxGNpX0yGcgjLIVATPvRBrRGa5F54oMLrDm9pHM9f6qrFHWIi2m2LtNTTKtFnLpITIlSGaJoMo7fupW2hZalF6wDoFd2UxpSBtT1iVsfBW9R5BWv0mD57WJtFaiuMp/oOdGKm3fLBPpzQkmHsMis5umpPahRj4YBvuuOs62f/2EJH7PiosOl95mGXvrzjmxl4LYsi6l0VLObTcE5/Dpzm6jAYhBJz2K6lHBCZg6I/82EKZ5yCvP5w2tv2Yl+jpO7X+avFfTtb63+7/wwagj1ppL7IxzzHNkhPYZk/Fzc3BX0tbsfGff+wJfXU0R+eFXR2bSF2p/ImBYtFfAkHCPRvWoAHtVn1FvJ/uueRVrP7MQIqPMisoAdT/TbIsMM2H+UakNfkZpSedeFJ3pCRvAhH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(2616005)(2906002)(38350700002)(38100700002)(66556008)(316002)(66946007)(478600001)(6486002)(41300700001)(4326008)(6506007)(26005)(186003)(1076003)(66476007)(52116002)(6512007)(110136005)(54906003)(36756003)(5660300002)(8936002)(8676002)(86362001)(6666004)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW9mV1p0MjR1dG91ejk3TGgzRFpFM1NBRVEyRGhqWDMwa3MyRUMwSEJ6S0NR?=
 =?utf-8?B?VDBPWXBUTmhEbnJ4MmVEcmllOWpHZHc2Nmo0czM1WWRIb1BZd3BNUW1uUUR4?=
 =?utf-8?B?T2lHSVFtQTlGYjFsK2pBWEZrbEl6VThqa1ZUeUNJdDFOTllQbHlJYzZWSDdQ?=
 =?utf-8?B?eWFBbGdvclRneTlDL0tiLzNjQWZueEdyZFlNNlh1cTZvd25nM0RUbDRBQVFk?=
 =?utf-8?B?VlBIT20vcDk3dGoxc1VpcmMzR3VINjhzRDFhT1pvRURlSXJEQU9tQ2w4MWdz?=
 =?utf-8?B?SG5ESmY2dWY3T2d0WnhFYnZiU1VLS05zdzhPSjdYbEpPcVlsQmV4Z0F6a3dK?=
 =?utf-8?B?ZFl1VElrNWlnUzRUdHNISjVoKzdJUmtCNFFGaEZ6L2pJR1BUMWZaYVF0Q000?=
 =?utf-8?B?Z2dxZlFTcXd6MlJseFpWQ1FKNk5sendTQmNaSDFUdUt3NStOdTd5d0R4bmlw?=
 =?utf-8?B?ZHhtenBoOUJEamdxMnpDZDkxRzJtdnRWcGlFL0ZFZkFralVXWXRRVmZqZ21J?=
 =?utf-8?B?T0Ixa3FPaUxWRS9nTlAyNHY4ZmU3N2cra2NlVldJNGRTcS9oL2ZuNHFRNUsw?=
 =?utf-8?B?MDJ0aC9DZ1NmektNMEF1UWpsTjNob1liRzk4ZjVKSkk5WGRoWnpWZTJMNWxM?=
 =?utf-8?B?UnZESXBhZ2xYY0hBQjg0YkdGK2xEdmlZZ3V4L3I1TEhhdXFQaE4zbHU5U0xw?=
 =?utf-8?B?eHppT2hsM1EvRExxbUhtbTQ2QXJxUDRlMGxBbjgzQnZjcDZOS0dYNWM3Z0xu?=
 =?utf-8?B?dFhTeHFjTjlldlZoNGkwNmdXQmtGQ1JTWGVlWW8ySVVMWm5uNS8xOEU5REZh?=
 =?utf-8?B?bkVtZ2ZYUVV6RExVZVltbEdQYko3RTZsVUlmL25mVmN1c3AyS2pyVlZnN3VP?=
 =?utf-8?B?K1dWdkIwOW1ncjgwRDh2V29NaHdJOTh3cmtwRFRlWlpzMUpYdFRoTFZpaTh3?=
 =?utf-8?B?ODEyczVadTQ4N2xqMU5iZlVIRERyU1U0dTRtZkpRdGtuZ1FoeGdGc0N1cnZK?=
 =?utf-8?B?YlZSN3Nyanp0RjNKT1Zyajlib0hIZG1FbnhPdit6aFFkQ210aENxYkkwcDZ6?=
 =?utf-8?B?ejJYV3lLWmhhaFJtRFkvUjBQaEVPQjhQNVRFampaNDdpcmdJZW51Rm5Ocy9O?=
 =?utf-8?B?VTZiUnpIM0thYnNwa0o4b1dMeFZob0I3bGVwdGpqM21TdjAxdHMzdWRlMmY5?=
 =?utf-8?B?dUI1ckVRMDdNSjM0Z3BRYnFVNWw4TGRJVFhqSE1mL2lSaWV0cEwvclNHdmVo?=
 =?utf-8?B?ZGttQ3FoOGpmRkwvVWFGRlkxUEVvQ0JISG80NUlzMWRIU0FqWDhRS01rMW1j?=
 =?utf-8?B?aEY4bXN3dHZZRlR4V010bUl5aWJlejAyUkdoVFlWNVFlYTFUTE1zdjZDcTV4?=
 =?utf-8?B?NTZGaFh2cTVMa05HZllJV3hqMmRub0REbUVMOHIxcDhmY1RZT3E0eTE2MmU0?=
 =?utf-8?B?elREU0FkMWNhVXMyTzVHc3RYd1Z2WTEreS9nMXFobk5jYWViNDRIN3h5bURI?=
 =?utf-8?B?ZkE5YWlqdUFveUJlR2wzV0xQd1R3b1MvSWw2TTFnSmtjdHFXN0w0VW15ZG5X?=
 =?utf-8?B?cFZNS0lHTTY3ZW5XMkZMeVdGT3pSNEp6ZWVoWFhlUC82dlljc201KytUK3ZG?=
 =?utf-8?B?WWRTdDdBVnNhUDlnNmpQd0tOM2kyVldhSzFjVGxmWElXOG5tVmtZa29uTFdL?=
 =?utf-8?B?S1l6VGpITEJTZ1BMWWh5dDdJckM5OTVuVEgzSmNyMjRibEJvNFJMSnZqdm5l?=
 =?utf-8?B?dlFMK0hnSDFQcDdXdWZWejlFSDM3djlaVzJKRFpvVFUxYWVtbWpmSi9LbjAw?=
 =?utf-8?B?OTR2MVRzQmZ6VWU3c0VhK2pLS1VhM0NTTXJIY1ZkcGZIenNVcUs0aFA0ZXdZ?=
 =?utf-8?B?Q0hPa0lHa2dEdVY2YUZId2g0VGk2UUNpckYzNFlFbWFSeVdZVFkxVEpkWUM0?=
 =?utf-8?B?ZW54eXJjZk85NXpUUDJ1cHREQjRWUVoxMTF0dExtOCtsTzNvQWZsZnhmQkFu?=
 =?utf-8?B?cFVFWjV4NTRjSUhxU0dYcHhDNUdET2F1VXBKTkMyYkhUUEdNT1Q0UHRteW9M?=
 =?utf-8?B?ajE1aG1EY0NHYmFGdnRVb1p5N0V2WkxYMWczTnpFdng4VXMxWU1YbjF3OVVh?=
 =?utf-8?Q?1Z6Ao4G0v5WetW/2nDd9jK8DV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8586879e-d2ef-4691-cb8d-08db89cf7265
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:07.4997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNW3TPwwtEjDrm5Rz4FYU65osTkUsFpEgq9VpYL5lhx99qUiQhIr9x+rwn/fyMoruybFom/egyYNNbnF3KJsDw==
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
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c        | 38 ++++++++++++-------------
 drivers/thermal/tegra/tegra30-tsensor.c |  9 +++---
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index ea66cba09e56..3d144377d90a 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1993,29 +1993,27 @@ static int soctherm_interrupts_init(struct platform_device *pdev,
 		return 0;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev,
-					tegra->thermal_irq,
-					soctherm_thermal_isr,
-					soctherm_thermal_isr_thread,
-					IRQF_ONESHOT,
-					dev_name(&pdev->dev),
-					tegra);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "request_irq 'thermal_irq' failed.\n");
+	ret = devm_request_threaded_irq_probe(&pdev->dev,
+					      tegra->thermal_irq,
+					      soctherm_thermal_isr,
+					      soctherm_thermal_isr_thread,
+					      IRQF_ONESHOT,
+					      dev_name(&pdev->dev),
+					      tegra,
+					      "thermal_irq");
+	if (ret < 0)
 		return ret;
-	}
 
-	ret = devm_request_threaded_irq(&pdev->dev,
-					tegra->edp_irq,
-					soctherm_edp_isr,
-					soctherm_edp_isr_thread,
-					IRQF_ONESHOT,
-					"soctherm_edp",
-					tegra);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "request_irq 'edp_irq' failed.\n");
+	ret = devm_request_threaded_irq_probe(&pdev->dev,
+					      tegra->edp_irq,
+					      soctherm_edp_isr,
+					      soctherm_edp_isr_thread,
+					      IRQF_ONESHOT,
+					      "soctherm_edp",
+					      tegra,
+					      "edp_irq");
+	if (ret < 0)
 		return ret;
-	}
 
 	return 0;
 }
diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index c243e9d76d3c..dd4c2deba93a 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -593,12 +593,11 @@ static int tegra_tsensor_probe(struct platform_device *pdev)
 			return err;
 	}
 
-	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-					tegra_tsensor_isr, IRQF_ONESHOT,
-					"tegra_tsensor", ts);
+	err = devm_request_threaded_irq_probe(&pdev->dev, irq, NULL,
+					      tegra_tsensor_isr, IRQF_ONESHOT,
+					      "tegra_tsensor", ts, NULL);
 	if (err)
-		return dev_err_probe(&pdev->dev, err,
-				     "failed to request interrupt\n");
+		return err;
 
 	return 0;
 }
-- 
2.39.0

