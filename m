Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F99475C379
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjGUJsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjGUJrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:47:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AB5359A;
        Fri, 21 Jul 2023 02:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsE54HUe2/tiVY/iyUUv5v0xH4hcc5AEYZWgDdu8T57e81yCrCnALRMeaYaQ8arBy6SLV8KdQJlKY8O4U2CJA/YaK6s3ce0Uhr/Sjy1VDcdZMd5qmjx/DCdyxabwtNAhs7Zw/cZjWz6BwbH6A+0FHG4d//ay42yHxoL75UU27RdvlTMgSe60fBc4IRkAsDc5+glHZaLMPk2GYQNou74NOLGbrEkjhdJZhH/FBA3GE2T4fg4br4m8rFcLz3XB+qGzUObGERIPJYbOueHeDRqifWycBwlkPZqR/3NdZpYwxsZgc4SmQVFkVmqtOEPeFfjNzvyJJBDr5/ReSYmrjYWoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC+Tw9tBAxhMQXbL/7pWy43tyxpZDYL9sm7HLlbfqK8=;
 b=ckixOFQHaWJm/O6wB0XGNLTScDRqgxqMku4RcbTipvwJYC5PClU1aocrHVFTR+GULvhOntQ2wIUiw4Wg21qfRWEBAjp/xQksQm9mD03iI5PpsZb5bVOGAf58LPaq5WDGvD8wQ/t20VAWO4FfrYuXGZ+VWH12PKmdJX8aE0ay1cPHZX4037J9gtrWi126PifEr4SWZDUwGYlXQEbhJE/eRrAgQwbi3NiIWPHWXp5okqFNX5kZjpdn5waml7eD/Q1x7wO+TfTTwzVOfp5w9Tz6/pYzGEho/7L0EOXv9JFINFhMzvjgTdPVvzzRR7ErqXpEtAG1xWHCiGCzwXYQm7FL5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC+Tw9tBAxhMQXbL/7pWy43tyxpZDYL9sm7HLlbfqK8=;
 b=kGuPR3cx1/zZEg2RiiMeJXtXBdhkZGeYvWSkQB1s8ox86hp5KIs0FN35THD1tyL5bHb4CvFSoziYF/X1XX4hLkLDsj4w1pKI4HjZrZ0N329nTkQVgh7FPW5/xaqe3uShDhPUf+dcG8NyJx8aoNg6+9HeD2/Vz+0t0DVFDULFM2x+9QB0jF0fD3159/tR6ARjLjbIz1n4NUvT4utRlc4lRUFFIMdWZ3WMN32IUAHBpwsZgLffKwBukwWNTSSfEWtlzrJVJmudTyAp7/YuC8RZgSxegMA1cI4GmYw4fHiQZJL+h4sgVH+H2twV2t4J3uKxznrcSjc9YbLzk1ao67DrHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 09:47:15 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 09:47:15 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/22] thermal/drivers/rcar: convert to use devm_request*_irq_probe()
Date:   Fri, 21 Jul 2023 17:46:27 +0800
Message-Id: <20230721094641.77189-8-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 735b28f0-2ae7-4018-3897-08db89cf76d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iabuIMEDtyVit7Z+kgPtdxxo64epokqH1k85JJcJZsghZgffTDzc8dSJ8KlChLVcGajRE2SwMQGMsDezXUIDXC+C22NGZm884n33DgG4nsKN9mOYHWh/Ti4Tdf9flJ4cFyZEjsTOKMyeFzl1FpCoJb1kifb+LxclLI6yWiohQPwu5rvjW7HMvxRmuNW4gxVXh+6P49K61fpfGaSs/s0do6z/MyPLhQMavVkvN0kcFGdHM1/bzqG9PNo4XUOF2NqM4Fhe0dTjqpOlPn84/h9r78cPiu5/+dy/eQipUtZ05fdohtclMPLOt+BaKQOmTO1JOxC+m5eI2eBVl04vVRyPWstkWvCkqM3GnROYl7CI5MuY9jwt2XBKBB+089Vpq17KDgkkdUQqaEbvkvfjY4LF++n3avgTLdALrzz73x2fJCIS9Po0FZCHtrFR2MKvCZRk71Z4hF3xYHmkWesG2GxKH3tnLiywlEbeBbexuxFWEtHr017CQnGd7nfyVWv0RJnvwLmF+OGWgQmPylleI9kD9ApImihmrpCd87sx1I/bLRz9QEtbRoeDcYVCkxReGnHKwUY2W8Unoeul7+32YXpVRWhF1cexXS04LcCt+FsY8p2wiiGz9hQ1F9UYBLASm5yt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(2616005)(2906002)(38350700002)(38100700002)(66556008)(316002)(66946007)(478600001)(6486002)(41300700001)(4326008)(6506007)(26005)(186003)(1076003)(66476007)(52116002)(6512007)(110136005)(54906003)(36756003)(5660300002)(8936002)(8676002)(86362001)(6666004)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGp1SmlhVXd3dmVCY0ZNQXNwWU5kTytwbSsyRVhIRWlXZ2tzWER5RnNOWEg1?=
 =?utf-8?B?QUJGM2IyWCsvMHgxR2hyNTFub3B4UmswZTY4YjZRUHNOMm9RclBrVW13dHNv?=
 =?utf-8?B?MTR3RDZaU0pMaUltTys3czl0MHI2QkVXVDJUa3RXOW9VcWlZV2xiZFM1amMz?=
 =?utf-8?B?WC85VlZnK00xbGtlWnYzdDZEaVJkWU5WRVZYZnI1M3VLVmNjUzRBdzJ2OVc5?=
 =?utf-8?B?L2cwUldYOFpSejhpM203eGQ2Z3R4S2JsT0djZUorcFZKaVZPamlpSXlVK1Y0?=
 =?utf-8?B?UDFSRkNQd1R1ZjRYVE5Jbkpid2R0aXBwUFdGNG5jMWt4MlhhbnZzbXNmdkZE?=
 =?utf-8?B?eUlTc2pEWkVjUzI0bTRWVEJYSDBTNnB0bGZvNXZXcGFudm1UN0pYZ2ptSVY4?=
 =?utf-8?B?blZQTWwxMUU1S1Nkck5nRUhuL3BLalNQQXp3V0pnU3RVMGpwRGx4YmVCVlN5?=
 =?utf-8?B?dUszU2VtWFNBcUYxeTRwdWtsdFI3NjczRmx3RWRPZnNkUHJrT1JIT3lNZDdD?=
 =?utf-8?B?ZFRRd1hNbWt1ckk1MjFwTGJvZzhnb0grRVkvRVhwN3JYck40NUhSN3F4L2ph?=
 =?utf-8?B?TjhKc0pZLzB0NDFRN1JEQ3QwQktwRG1QbU91dGxCZWZHU01SejdYRm9mMW9x?=
 =?utf-8?B?VmJaakxVbXBreGZVZzJ4T2dmRldzUnA2bDA5MDJ0VFRxNDZlWHhKOVVQMjBp?=
 =?utf-8?B?ci9iK3ZHR3NRUXpsbVRRSXpBWlJBcWtOWk9tV3kzRGtKMU5scWlQbk9kUVF1?=
 =?utf-8?B?RWV0VGhkck9IdU9ZWHhodVY2NlNxOE9jVGR2akwvM3B1akN4N1ZGaW9sYS95?=
 =?utf-8?B?Qm9WOVlmTXI0N3c4cTdhc0dNZE1paGhtczFzbXA2Skd6ZFEzaEtwczAvcUtp?=
 =?utf-8?B?Mnc5aGhtNzVocEtUUEI0cjV5UTA3MTRDVjlLS21RQVJKbjgrSVF2SFlLLytS?=
 =?utf-8?B?UjA2RTVDT21OZnZDeThnUEk4U3hhN2NsWUx1L1JOTGxIay9LUk9HV2FOb1ly?=
 =?utf-8?B?dWFnODRIQzBzQi9oLzhwRlo3MDlTaU5mdVU2L05WdDFGczZQVE9xd29NQ25r?=
 =?utf-8?B?Rkx3OVNnMU14QnJPaHh3d3lWeWVBRmxkVCtWZnZlTk53WU4vR1dQRzdXSHU2?=
 =?utf-8?B?Y0dGa1ZBUGJqSStjajVqQmVFWWNYVHluNEpkN0tORS9FT25mUmxZNG03OUxJ?=
 =?utf-8?B?THdqRk5qZmduU1d4Wno2U2Y4cmo0K2Iya0xoUlJiU3AyMVRTMnRvbVNOdUpi?=
 =?utf-8?B?M1pJcWpJWnZWbDVnTDNUL0phbTd3Z1ZJSnFCT1JQWGxyc3pWa3ZGdml5WWZx?=
 =?utf-8?B?bkE4aVJJMTh0ZG1tNVpLd3c1cDMrR1pJdHZ0YTEzcjFqcDJlZFB3UEZ6QWpv?=
 =?utf-8?B?MHJ5LzhmWHd1NG9NbXd1c2xZQ0piRmFUZ3NOYm9KdGtkRitZRTdjVklEQWwr?=
 =?utf-8?B?OFBGZExMeVVpaW9lbzI0eEVqNEYrbHgxelVGcU1uTEJXODgzeURDaU45Y3ZR?=
 =?utf-8?B?ZzlhRytSRkNGOXdTVndJemhVbWhJZ3oyYlVpU2llbnlzUVRXRlYrV1ZoWS9v?=
 =?utf-8?B?cWl3QVg4VFV1T1pWaUZxMnI3WTh6RHRBOVgyRTk1SmJkdkdjMUh5MUhRek9Z?=
 =?utf-8?B?YmVISXV2dHJiQkNsTm0wZDFYYUpIUmd4eHFUby9OL0ttOWFySzZZeUxpSFZT?=
 =?utf-8?B?bVd6aG9qdlZ2aHVENmVoZ1RSNmZGOEd3NWVUckhhY2JJWUZyaTVySUFqNnJW?=
 =?utf-8?B?SHc5K1ZXM1VVbFZhSkZtZHRqOC9jVjhJT1gzZ24wSGdWNDdPTS8rd0ZXM3pG?=
 =?utf-8?B?UWxiM1pkUE9oWTdEMjhhOFJ6OGtzTy9nZDQ2NEd6andscW9YR2dDcXkvU1dy?=
 =?utf-8?B?WmM2QkFCYlkzQWdWL2dxNEthNkRYSlNXU1lmeGNjZmRUcFAwc2ltQk5DK2hO?=
 =?utf-8?B?Z0h3K3hvcXpzTGVTUWUybjhReENHeHVHNk1CRHZjSkhrVk1NNVN5VG11YUVr?=
 =?utf-8?B?YlZTRjNOVFJ4Y0k3WFptQVVSOXUxQzhNTmpYT0hUc1RJM2ZSQm1kZHI0c1lY?=
 =?utf-8?B?ekVVbk5ITnN5Z1Z1cDhjNk9yU3NyYlMzY2JteU14WXNIWmNMUG16K3hVbW84?=
 =?utf-8?Q?DGVAGemiJTMb9zlC+gkbTrSwA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735b28f0-2ae7-4018-3897-08db89cf76d9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:47:14.9940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTEUwsAhi3qp3oxLpuhxlw+dBc+AfnajAD4A6RlUoI9Y++6hRVK1+3peal+cz8vP4h5UjbWxrn3vwgDXjt9Jxg==
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/thermal/rcar_thermal.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index b8571f7090aa..56f3983dcd5f 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -446,12 +446,10 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			idle = 0; /* polling delay is not needed */
 		}
 
-		ret = devm_request_irq(dev, irq, rcar_thermal_irq,
-				       IRQF_SHARED, dev_name(dev), common);
-		if (ret) {
-			dev_err(dev, "irq request failed\n ");
+		ret = devm_request_irq_probe(dev, irq, rcar_thermal_irq,
+					     IRQF_SHARED, dev_name(dev), common, NULL);
+		if (ret)
 			goto error_unregister;
-		}
 
 		/* update ENR bits */
 		if (chip->irq_per_ch)
-- 
2.39.0

