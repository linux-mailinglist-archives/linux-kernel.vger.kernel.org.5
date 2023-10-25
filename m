Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4AC7D71A1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbjJYQWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjJYQWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:22:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981A610E;
        Wed, 25 Oct 2023 09:22:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rm+8Cm0KZxVAnZAxe5QHjuimnW91pgHhpTMqCYFrnmd68Ah5t1sd4qGogUjBzFjStDGWxycK4/x2eUbQ2KGN08l5U3RXnF2QPV2UsgptkQgMBCeYXr2QebpiebuX6PtC5IqQ1s3DipB4nthRncwzZWF6ZPmB1IoTSz2EUqA9uinLeDdrbebJrTB/FlxpVJMlFx/xN90Y/L1F/6I8l0bSAdAyvJ3dZshvg1AWMoVB8vDkb/VGcGOV3L3doAhpxmWnABC0MKDsGud1AHWegbp5zWDGgxBJ4PI8dE0ugWIjnrqsb/gq9Htytoc9fCJf9U+7PZCGar/c4lVEzq67kQxy8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3x2jylEEFQhqMBQxTF3MG6sZk4ZTnycZ0jC+ICuTNxA=;
 b=Pdp6gMWxQfK3p2B1z4CSWhD0HwCWEz38OkF+5Xa7QSHGFJT00YQhXyoFxZGjxIj+fBsmYdorhb4+rnzkX5KITiEfa3ec8ETp0Vzskqnl1vkL92TKa+BMSfsps3dpdytIUP5VqgwtcREjk61c+8B/oqPBU5Lv1MmHjXXB1BJK3uUPxH4q5EfXan2Yy8NgfUdLxX+QUJJXhTfzVBQiFrUSz0BJpgsUrnoZRStgA1YpuWstn5pgjEYecvo/YVGveu76EXSN4jzdGNd2HHwKQUpX1rO9Y61D1j9W+rv0vqg2+VcBJoe/xngq8h22bKxj538Kzb4uJeUmh0EWTXZtznpLMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3x2jylEEFQhqMBQxTF3MG6sZk4ZTnycZ0jC+ICuTNxA=;
 b=foZ9tYz7nBfrmoY1u9z/RZwUwyTciKgNBrK5ZXVHu4H/JfkSRi+j3E/yGWGitUyeoLJBJZXm6dgHQZo1R//ztnUX4KuAJwNbrRw3OpBfbnyyQBw9Y6sTNeB3OGsLW9ywYqSlWBDOX/FQXL79bzb5N04nnbCAQSwQW6r0ccByGQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by VI1PR08MB5376.eurprd08.prod.outlook.com (2603:10a6:803:13e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 16:21:59 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b%6]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 16:21:59 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Wed, 25 Oct 2023 18:21:55 +0200
Subject: [PATCH 2/2] dt-bindings: rtc: nxp,pcf8563: add hiz-output property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-topic-pcf85363_hiz_output-v1-2-50908aff0e52@wolfvision.net>
References: <20231024-topic-pcf85363_hiz_output-v1-0-50908aff0e52@wolfvision.net>
In-Reply-To: <20231024-topic-pcf85363_hiz_output-v1-0-50908aff0e52@wolfvision.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698250918; l=2113;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=rqDdWYoPOl/WqKlVTb3ATpZe4jxSW4DUjdgvmC9BmGg=;
 b=S8MFlT+EJBnhx+hltMYRFhalHnII5UAvH7GJJKGI8jetvw3yXZ827Ae8xqMEzvzC10fJpYByw
 0dMSKVyyzkAAcd2YPU4rYGn/ZM/gDu499JrYK2JmsyGgO/UJ5B0HZfk
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR0102CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|VI1PR08MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: f41c3f1c-5771-467c-37f9-08dbd576838a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BhXvqCPpFUdKfwSHTBAYxJ8t7jGRbDJ2HGGn+ANcc/NmvGzcz6zy78fJCGDfttZ3U0k9BOc4c+VkBqXxf/gdOU2s5rIMhPBCktfVgGLL+Ww6liJ04OSzaeOt+pZiPE7C1u2KbyW7Rl3AT8GTvF5TsEykp1/iHDpQvvM2P7UY8sfHny+dZenGRRLRdMOtxARsW5C0GuzsZmiQiioC1EpuIYhfunadexx0PUj0ELoydRnSXiliP768YEq0vkTWoT0S10v+dpl0bSU5ICDVTFKNAL5Ru58eo9KJVY8koS4cdEMo0esYxjOzes/sWaehs3MBzE4BnS9Ml+9TaEJEe0DCIOd8QuxSIHx5EPUyX8K4mtfVKHwDsP84z64Ssjl9/9sUDsH8yTRPWwdrHkWpX5Bw0pbTkeDfGCi1t7R88B7qSvkAs7pzWcuv2mPLQ9zZJLoPkwaNL0AKytsFuvkqr4F3tIk5PaAhUD3W8DRyuDDNuw3HyOXCi4Il+9R7hgQSIMj4W4ybnOUsKYC+JhNpwgCvYF4AqkU3bdVJ12wzSoMT0Pq+i7jaAW2TFsHFuHaJBWvfvFWhpi9g+4b6Y0nUN9Co11RKFgkmYHuWcrVAWhYiLQQK7QHSvv12CRzCdCCSIVR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(396003)(376002)(136003)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(4326008)(2906002)(8676002)(8936002)(44832011)(83380400001)(6486002)(107886003)(52116002)(5660300002)(41300700001)(6512007)(6506007)(86362001)(316002)(110136005)(26005)(478600001)(6666004)(2616005)(36756003)(38100700002)(66946007)(66556008)(66476007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTFMMG92WWNCMUFCK2Q3cUFHQmZ3blhCL2l3ekFzV2x4S3g4UXNwcllCZWt5?=
 =?utf-8?B?aXV1YUdJZ1IwQVFJUTh3S2ZvUGhVL1hjVERpVnIxNEtXL25WU3R3MDdrbnNu?=
 =?utf-8?B?ZEJ2R2ZmdFowdGx1MzhJK21zWkh5L3E4ZkprN3JBZ0JmRng0NTBkd290YkI2?=
 =?utf-8?B?ZWE5TUNsL1VBQTJySnp6eStYV1F2djZuUDhkUlR6elBnaDg5eDdYSzN4RUhw?=
 =?utf-8?B?UER4UmNIUXVSWVE1YTJRMGdTbG0zU3BKNk95UmVEZG5MS2FRcWNWanc3Q3M0?=
 =?utf-8?B?RUdrU2pYWkxBdzZLVlZCdkZUalVNcTVKcDdPRzJ0YVkzV0NPNm5RME0yM0JQ?=
 =?utf-8?B?RWNPNndiLzl2eEpqa0pYUGZDU2RPa3ZveXdZbnI3SkYxaERteDQzalRiZGtY?=
 =?utf-8?B?TEJyWVQ2VE5CYWI3NndJL2Fjbm9ndy9rZUlzMlBPWGcvY213M2NiL1RzM3hz?=
 =?utf-8?B?VjY3WFNPODZUd2FTRllEOG1zQkQvMThueW9ycHBOVUpvN2ZOa3pHTmtsYlZQ?=
 =?utf-8?B?eXFKbFRPemp3S1RrOWY2OTg5NDhxVExWTHFqeUJqSmtlM1JvdE5BdnY4ZzZZ?=
 =?utf-8?B?NzJsUi8vbXlhZnVTcHJld3lGRU05RjVoTFhuOWVzRFhyTnhKb25sb2NkcmZ0?=
 =?utf-8?B?ZjdVZ2FlcmFkS0xqblRDV3ZRdlNzTmY5MXBoaGc3OGdmRWg0bEh3SVpnTGN3?=
 =?utf-8?B?SnRQdGxrbEJJZHdOY0J5VWFWajFJY1JmVHcxWk9IZUlGZ3ptNitpREdJZ0Ry?=
 =?utf-8?B?YmhsR0pkSytITnlUY1pvcjdKVk1VQ1VEbVpzdTRNUjhQK3pVWXVnQnBhcXIy?=
 =?utf-8?B?R3lSa2hScUxMbDZ1NmlzVUM1V2xMektJMGg0MnNZV0Z3dUo5RFVMY0Q3NEto?=
 =?utf-8?B?UGNObCtmVTVCSnVTV2hkSkdqQXhxSWdUSnk0QTRqNnBmTUtDTGtyaE56cVdF?=
 =?utf-8?B?TmkzMVpXamd4U2dXenhFK1ZNS3FQN1dwaXF4RWNpd0FtclZmSGxUWTdJMmJV?=
 =?utf-8?B?TlZwbnlVV0FIcWVmWlkza3Nnd1hwS3l5N0hIbWdGdzdTalJMdStFeW1kSVZ2?=
 =?utf-8?B?Q0UyYzRkc1hWc2g4SWRvQ0RjdXhrRnlxR2hBM05tRlJDU2g4NXBqSmt2cWhv?=
 =?utf-8?B?dDdQVGwyRWVYcHNNTXU5bWZJdjRpZjdRWkxnT3c4eFlMeS9FeHJQSmJMb3N6?=
 =?utf-8?B?TWpNWWJDaGN5RWFobGtuNFk5N0Rpc2dYaFJzRmIzQk1LVTg0VCsvenB0S0VS?=
 =?utf-8?B?ODJuY1lSTXpJUnVPWlk5eWlheGo2Z1pyRUVPemFKTFRHREdJd2taSFhHK1BC?=
 =?utf-8?B?T1hNL1A1Tzhzd1dEdVYxNVc0T3R4ODFrS2ZjdXc2QWd2dmlMd0xGRE1wNnlI?=
 =?utf-8?B?d3hMcVlkbXFBVjJKdWtBaysxRTRSOGJoajkwNEVaZ3lLK1BJVHg4TCtPWWdS?=
 =?utf-8?B?enRUSS9LVVRIMlZqZlYrRkR4VDV3UmJVQUptdmRIV2ZMOG5EeHY1cTIwZEZJ?=
 =?utf-8?B?ZktuU0t0QkNwUXRIT3hnTkVuQnB1bllnbFZsWjVSSXRPakMxUEtkMHBwVGhB?=
 =?utf-8?B?MnM3WVUxTTZHNFpxM096d092ZUNVZzJRcVAxejUxMlROM1J0Sk9JRERNazZt?=
 =?utf-8?B?RDgvZU9qbVpFcXF6cTFma1RVRFV4NEFuMUw5TzYyTTlJeUpZQkEwOGhxVTFj?=
 =?utf-8?B?TWFBcHdCcnFXTDhoUndhUTNhdTlMeHhQVVFPUU9lQzlpbHVqT01CYmhydFVp?=
 =?utf-8?B?MkRQOE1nYnVadG1NdnZsb1F0NSs0R1VGenZsdTFZWDVCcGU1Z3ovQjJla0Mx?=
 =?utf-8?B?SUVKcENPc1lxNW93dS92VnNUOTJFQ2xKa1F2NWMrMTNWR0VJN2RSVk1vVXB5?=
 =?utf-8?B?eGhvTkw4MVgxUTh5SExtZTBESFlCeis1L0VDb3hsSnJxK01pc2RBQ3ArRWp1?=
 =?utf-8?B?c0d1VUg5S2l3VG1KMUoxUnNxQTQ2cUhXWUFTMm5XS3J1OU03R1kyVU5CTTNV?=
 =?utf-8?B?VFRVNHg0OTZzWVhXandIbjJnZktCc2ZjNFozalE2V1J3NWNUdGRmb3NtMVFH?=
 =?utf-8?B?djVwcXRQVXFxWWt3MUpMdFMzWGQ4bzhLaVhQTTlkMVFTRmtjVHJYK0VwUHNO?=
 =?utf-8?B?VWtsMHJoWWt4QzBJVXMyNlRVdXp1V1U0TnNpNVFTc3ptU0lpRFl4Ny8rcHpv?=
 =?utf-8?Q?BVTtQGVr1EKWXWh5PSL6Rmc=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f41c3f1c-5771-467c-37f9-08dbd576838a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 16:21:59.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGXW0xwlcr4hqXWSZn/ltlwsaQeKidBO8R1wrQqvYGb/AeP5chhYB53OarEisTb+02AZO0Od9oz3yMZuAOmjz5WjAzC9CAQkJswSI2dVsV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5376
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "hiz-output" property models the RTC output as a high-impedance
(hi-Z) output.

This property is optional and if it is not defined, the output will
either act as an output clock (default mode) or as an interrupt
depending on the configuration set by other properties.

Two modes are defined in case the high-impedance is used: "enabled" and
"sleep". The former disables the RTC output completely while the latter
keeps the RTC output disabled until the system enters in sleep mode.
This option is especially relevant if the output clock is used to feed a
PMU, a PMIC or any other device required to run when the rest of the
system is down. For the sake of completeness, a "disabled" mode has been
added, which acts as if the property was not defined.

Document "hiz-output" as a non-required property.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
index 52aa3e2091e9..4b27a9154191 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
@@ -36,6 +36,19 @@ properties:
     enum: [6000, 7000, 12500]
     default: 7000
 
+  hiz-output:
+    description:
+      Use enabled if the output should stay in high-impedance. This
+      mode will mask the output as an interrupt source.
+      Use sleep if the otuput should be only active in sleep mode.
+      This mode is compatible with any other output configuration.
+      The disabled value acts as if the property was not defined.
+    enum:
+      - enabled
+      - sleep
+      - disabled
+    default: disabled
+
   start-year: true
   wakeup-source: true
 
@@ -56,5 +69,6 @@ examples:
             reg = <0x51>;
             #clock-cells = <0>;
             quartz-load-femtofarads = <12500>;
+            hiz-output = "sleep";
         };
     };

-- 
2.39.2

