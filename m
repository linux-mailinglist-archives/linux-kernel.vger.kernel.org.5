Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CFD7A1E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjIOMYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjIOMYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:24:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26946115;
        Fri, 15 Sep 2023 05:24:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyUtnzwxBhImpuYj1n0sSGR37I3Ail0H+gPVXxn/Vv1fpwDo0bTSYdDdw5ckfn17+f+xYguolvD54QgT8S/dzsrno/t7MJQAS8mrZSAk+19D3tuz6JyoeYqrfXx7uQNXAW4jwGmYbhr+Zf8IEBOhZlJFQGiicMnrbYNJWbBLB6FKsYH4EKMpdlvoV9Hi4taiv4fEfvU1DEfWY6zS6bwtpsAqrPJmy0JlTS00o/3DAS59CsIyjH9KPKWfBPG3V74ssaye7IM7tI65cXwtGPrS4YiVOe3IJEPv/KfGthj6/3nPed+wQcvspqgNtwZy1nQGdYTWbiyQqDjOfj/EC8EAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nJsw1y6X6uB8I2gp4C7HgHNXeEGZr1QilwyS3fE9fs=;
 b=NLsQwIMhx5G+QGz17QFckCYv24wncIwxsTb1ZdD/4blyyTpb/LSXHEfBAA/BkKweb7BC/j/LJh08vWakpmRsPaEhXOPPCPp6HXUltGISFIwYOyq5IwEW+136QuMXZ75euAK59rhxSbOJFzElkDJwexAsg9o4KpWl+9EpAH7f8ckXCNi0HMqwEyR2SLzvfwqP0LS8rG6si1uTApy0fhDXYuuAhyfsvSNuYTpf2V8aYnjPanJK3xrgtFS9KLWM3ZlZabvNrFUFwvAW4/g/YZH1Fohb4dYp4u9aHcO30x3xgRJyC5IZYeAfFycgW9WzIdDzC+GmxgVf7DDuWilxo3rosw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nJsw1y6X6uB8I2gp4C7HgHNXeEGZr1QilwyS3fE9fs=;
 b=YbsI+2kR4PwEDqVjLkkM0kRJeOOzegV2P46FfYrHy0S2sbyW+0vIw04dBBajsGiqjlENcKPHLYtMkGpV4zXwqGPHxn2soXQCtgdRItSRDTYHEMLrPwAb7wqq76CuR3u/Sgkj5Zz4PWJHPXxH4HyzwWsuXgvM7VcvFEJLmXC5jRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PAXPR08MB7623.eurprd08.prod.outlook.com (2603:10a6:102:241::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 15 Sep
 2023 12:23:58 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 12:23:58 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Fri, 15 Sep 2023 14:23:49 +0200
Subject: [PATCH v2 2/2] dt-bindings: usb: tps6598x: add reset-gpios
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-topic-tps6598x_reset-v2-2-02a12e2ec50a@wolfvision.net>
References: <20230912-topic-tps6598x_reset-v2-0-02a12e2ec50a@wolfvision.net>
In-Reply-To: <20230912-topic-tps6598x_reset-v2-0-02a12e2ec50a@wolfvision.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694780635; l=1433;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=9nDWf4rjE67YgTLOaBbgR3BVtLCwAFmqsVJzACx3fps=;
 b=uqXmqYcw2/PXrKlSMlBLgla/cRz8p8ahdguh9SS70chbBRpeFHhvDqXVTxYiILeduptM5Fxl+
 fuMaOKllZDKBZxhpcReRG9OcAjTNPN545wbKn308d48WHia6y+WF5MB
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: AS9P250CA0001.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:532::7) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PAXPR08MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b357f1-e3d1-4f68-d6c5-08dbb5e6a2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9c0AxpltFhYTg65FQbBT1ogQRUKaoN3NQyIYrOdhVAE3LNe/hQePOrMclKHVdtozmFPJVTb2KKST181H3mDQpCMEo0wLNxccbmqAzxgzsmnEY0swY1EvaOc4YMlDTEF9XhoFjd3kStHOaVMVqHctZfIyx1fypY/h33H0TPfWLnZyaOLA0y/lo5m0dAk5njed0uL38BLbKrCEMsd69IgwHJd1SneGYhlzn/yMTpNepfQDpVMYI3zTZOckpewf1SB/SV+KAIfkv03mxg0ubtDqw1SkK80MgJ64G+wW2vrZzmiNI3Neh6kCr7clmoUZbEvyxnx3oQuXiJe/MobG/igCYqJUc1IyCkx+SJ4Ne3Adk3K9uXjy+doqN74XPi5UgfaBe4CJ6eUKegO5P7xL3waxldQRjesL4ZFhOFbqGUiw/+d/7JVyU/6IRBtsM3B492LrBP3Cw8HVJN3msfuIVQWIo8xk8Cg7pB1N+GY1hCz1P3Fg2ayz9gtMsmedwGg6nA3bYop01E39ioF0ascAnLPFXrvKGO06AfBezQXcpWQ6e9CPMuJT7jTU1DLXUr2h7pHeFzYyiXZ9lrZJUPlKCNz1Ojwue3ipO9f+X2wQTYanlAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39850400004)(396003)(186009)(1800799009)(451199024)(6666004)(52116002)(6486002)(6506007)(44832011)(6512007)(478600001)(2616005)(26005)(2906002)(54906003)(7416002)(66556008)(66946007)(66476007)(110136005)(4326008)(5660300002)(41300700001)(8936002)(316002)(8676002)(38100700002)(36756003)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekliS25FZVpXcmlKemRtcUppbjNqTjY0cW50emw5NFZWWUEzT3o0ODNUek44?=
 =?utf-8?B?WHZiakpCZTZGQWtVK0YySXJQVllWSEc2OG9PZnRWQW1VNm15SXV1cUFjZTRP?=
 =?utf-8?B?SHN1ZGdESjI4dk9EZTM3VTBHdXFXQUxaYitOQlpLOU42SDIrcy9VOGliTkVm?=
 =?utf-8?B?eUlqSGxjKzEyNUNIUGRtU2dJMzRlV0s1WVFOMjA3V09VamJLSlVkdmtENG52?=
 =?utf-8?B?ZTB5MGR0Q2pYdkZ1Y0hOMDlHMUYvQ01sUnVHdktnNEVpdm1qYzg2OEJTcHVk?=
 =?utf-8?B?YXFZTDc5K2tEQTZEWVlmOVBHZWcrb2NWV2lBbk4wdkVGT2RIbGtvNkl1R2d2?=
 =?utf-8?B?TGU0d0dnVWJmT2xBWEsxM083WjF1T3AyNEpsWkhSMmFBZlRoNUtjRDdYT2pi?=
 =?utf-8?B?bUtGRitSZXdhYUFGK2NRRCtPS3N3Q0hCOG4wVjlSM2FlNU01QmNlK3FVM1dp?=
 =?utf-8?B?VVhHb2Z0dGV0WTJ6b3Q2emxLVldIZ0N0TEFZR2xYRDJ4NHVIWUttb1F2Z2tL?=
 =?utf-8?B?OEhleXQ2T0VvU0RVTmlCSGkzSzFWT3FGV0laSzNQNkdjQ0ROM2ZLckZ0UDRN?=
 =?utf-8?B?WlI1TktobDl6MURYN0htVEs1dDJWaUs0ZXk4NE1tSmhLRFJqN0FxbEJKNkhM?=
 =?utf-8?B?OHpiTlVna3J5U2ZiZkRmQXlxSVlNRi9hQXNHcVBYSFlkSTd6Z2p4Y0lTZnE1?=
 =?utf-8?B?UUF6elBnL3NMdXlWQ0xyWmR6Z1pITjdyUTZVK091NGhtZDBaZGJMVjVLVm54?=
 =?utf-8?B?aytzWG9qYnRwRCtER2Zaa1gyckt6WmZuWERPaUxRVlczNXR2VzdmWjZQWGR6?=
 =?utf-8?B?Szk3QlN0cmwrSDlVRzNHb01BNHI4ZXRYSWRtNEtIZjhsYmtUTG0xbm1sODdR?=
 =?utf-8?B?M2J6R0dyQVVVV1kzWkdmd0Y0bldFL1RFajMvQS9xSmZTb3RDNU1WMkdWUHI5?=
 =?utf-8?B?eUszR2kxU0JzaGFHb05qRkdCaEZCbkVxRWk2bHI1b3JCcmRxV1RPdkV4Mnc0?=
 =?utf-8?B?eGl0TXNCZWFGYm1ybkZPRiswSGY1cXBxeW5TNG04WEk3SXIydWQvNytFT3o4?=
 =?utf-8?B?U3ZLTTd5enJJRlhFNlZDU25qanFxU3lrQ1VRazhvdXh0ZHNEYzZYck9VNVRx?=
 =?utf-8?B?ajVuYzJMWUh2NkZYa3AyN2w0Tm8raExCZ0lkWitTd2dGa2NKVURSOEk4M0sz?=
 =?utf-8?B?dU9DN1dOU3FsaGZlaWpnaExiZFlWNTNJVFhXNnBJZGRxVjZjYmU2c1I0NUda?=
 =?utf-8?B?MUJsRm9mQTEvZ3NrV2xWZVQwb3g0bHhKNzZsVUhFa2VxUkVHSkVxbGdEeTZ5?=
 =?utf-8?B?Y2FtT2lKcnpWa2ZvUGxLL0NOTE5ZVjJPRUV0a1RFZTF2ZzdIZ0hTbTdWWFc4?=
 =?utf-8?B?SjRSNzE2SGFUQVVtbDhsbWxhVzZuV3c5UmJPcFV1aDRFZ3BUOG41anBrRFo2?=
 =?utf-8?B?Q1l5dGd1MEhtQzNocFI2VmNuM28xZ1JDQiszdFRFWUlFN0l1RzF0Yy9aT0Nv?=
 =?utf-8?B?dE5zM0gyS0lNUit3SHJub3czK1BEYktPV1k3enJ4QTBKTS9vbEJOQjk2RzRB?=
 =?utf-8?B?OWZEUEYxVkhsSmJSVU5lNUlUUXBkTG4ySEVxa3VXL1hYWGZDVHdWaThmNGlq?=
 =?utf-8?B?TGF0V1d5a0JDdEw1Y0s4Wmdsc3BxbW1ETy85cFcwT05ST0o4M0d4RkpBMTQr?=
 =?utf-8?B?YmdZNnVLWCtqUXpXNE5NWiszdWNVd0JGeXcwaTJGRm82Mk4xeHZQWHE4MytS?=
 =?utf-8?B?c0RVMVh5MWovT0h1WnhmbVE0cFVTYTRaK3p1ekYwaytGMXBGQVRoYi9QODNC?=
 =?utf-8?B?RUppdm5zd2xEL2t2clYxYWk0TnEzVGVvcDlnOC85MSs4dVVHSXh1cTl3NElG?=
 =?utf-8?B?Qzh4MTlObDRNdi94MUFLNlAvWFFmeDh4RURxdm1iVHNGQkZxNHdzbWFmZGc2?=
 =?utf-8?B?aGJwUDZNcFRtRkNCSXZjaTRYL3Fjb2xXTjYvT3BITW10S05KRE5LdVhPejBj?=
 =?utf-8?B?UmhXQ2RySGp5TGJmUllCdGZ0YmQyenVRQ2dVc2x2UlFNMkJ4cjkzYjgvTDVu?=
 =?utf-8?B?TC9IRTZHU0JyQUFmaEpuQkt2MVhiczJTUmZicThoRE1qbEpEZkpHTFl4Q2pG?=
 =?utf-8?B?bXBFcFJmT0o0VVhCL3Q1MmVOSlFGRWFZK0lGSTIwcTNtczVQbEJrQ0pJMjl5?=
 =?utf-8?Q?Se8VQC9/HfYS2Sc67Epo5wA=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b357f1-e3d1-4f68-d6c5-08dbb5e6a2b3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 12:23:58.1023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKjSDg0rg+It4c07zvbGgeclBZANBEhGJjN+CpKAv9JANru7CM9CRQR0losQC8rGl3PvJWo9NSzasQSDk3lEQx94E/J2N083Q6rlyGlPZI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7623
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TPS6598x device family provides a high-level reset pin. It can be
either grounded or used to reinitialize all device settings.

Document the reset GPIO as an optional property and add it to the
existing example.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
index 5497a60cddbc..b1a621e06127 100644
--- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
@@ -23,6 +23,10 @@ properties:
   reg:
     maxItems: 1
 
+  reset-gpios:
+    description: GPIO used for the HRESET pin.
+    maxItems: 1
+
   wakeup-source: true
 
   interrupts:
@@ -40,6 +44,7 @@ additionalProperties: true
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
@@ -56,6 +61,7 @@ examples:
 
             pinctrl-names = "default";
             pinctrl-0 = <&typec_pins>;
+            reset-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
 
             typec_con: connector {
                 compatible = "usb-c-connector";

-- 
2.39.2

