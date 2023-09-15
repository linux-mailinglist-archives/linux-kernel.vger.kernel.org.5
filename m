Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FFD7A167B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjIOGwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjIOGwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:52:07 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A141C2707;
        Thu, 14 Sep 2023 23:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtpXWgwbR1oHIpOI/KHBZF6ZFpvvh6T0AN3zaXaJ+RDtztUWKjhvZkkbS24B0T9QjbtOJDK0B/0/fB1a7oy0GNwhm33GjkQ0o6Q+DvgtT62Upkwap05L/6PzDvGRZwaMMO56ncD8xAoV1OaxZEMbGb/BK8/5+8UZ6RdVIglyzYzqCGs+pIlonilw8nobsLCjz+VyzNh90jcZi8nYrGtKR/TDDnuTGglPo3Oqt8NlUCNpybnNEboEIsgvKy8Otl3o+XtWvn/Bdt+HaG35A/yuX3Z+vDRxBgKQEw74qfpcLlgxSiuGTjACveBSwwY1rGTxyOwOJFZTskK7fOVEnJlP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukOIz1Pdsy/PjF/gqYINmL+CxjpII62ECaD8soHyT68=;
 b=m4zqeqGen1X1uraGdVGmC1+nRfPLBC2nwrgPuc5vYcnpIr7KOldFo1wt0KLRRXV+WeuqGSqwpGcqVl0QxWzreac/qpGW+s8707NOKxWxzdT1xII+xYt51nDmKSS5j7HdyQWJlMwFEX+ObyWT2C+nLRVzzTFi1kZyLSBUcRe+YtEJv+fckn4XX1LeHewsOLt94Q4Z0bGwRgVYNrnG+D3KPH2ZuTOONvqW5KY8m79eCKVsZQTkS20uFbw0LdDJTkwUdUun3uC5HBjDJYAcunDX+EPwzUqv2w/0/Iq72uPjVHKUAcF8x1T+n8RwzG/1Hc6Gc+v556n7DNyIyukFeW21+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukOIz1Pdsy/PjF/gqYINmL+CxjpII62ECaD8soHyT68=;
 b=ljz/qNorflt91HkSIP2ARud3ksznAlVMcCYIdSvAf8yYh0dRumaSfzyW8O5E8UqaqkyuSNW5axWoCbitqUlEqzgvFGipkDQ/674YOfcIOQHDDKKlOzXHLONHooqnRb45bfwHkNlo6U62qMYzydvSvyBC2lhDO+Ev0BWbVg7NYxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB9322.eurprd08.prod.outlook.com (2603:10a6:10:41d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 06:51:55 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 06:51:55 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Fri, 15 Sep 2023 08:50:53 +0200
Subject: [PATCH 2/2] dt-bindings: usb: tps6598x: add reset-gpios property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-topic-tps6598x_reset-v1-2-78dc0bf61790@wolfvision.net>
References: <20230912-topic-tps6598x_reset-v1-0-78dc0bf61790@wolfvision.net>
In-Reply-To: <20230912-topic-tps6598x_reset-v1-0-78dc0bf61790@wolfvision.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694760668; l=1264;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=lRll9wS40knwX97TAkwcHx+ORXPs6OvKVeKUWONOPKs=;
 b=6/+vZVzXnidIhtNKXr633WGQz6xFexmWehet/q/uZ1v+sjvt43Be1BnQnZX120CAsu+q6/yT2
 kInbhwhARc4D8z3x4Kl6V/7I6YRZ3VgufqbBQJOBZayl8b7aL6XbhIw
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0296.eurprd07.prod.outlook.com
 (2603:10a6:800:130::24) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9ebd6c-9e2d-4d6f-5faa-08dbb5b82571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y8IIZDiYXQBpGFJ3nrpk/OfQjW95M89YApMCy9mdEJAnuJqS/Dpo9LK1W0/v9bLF30LY/Y1UzAaNPNdm08hdLBnk3IriOFafKpa0OI64UjGlarMW6e2mP+wLTwAMKLjxDDVIXblsn7n52x5/C2MvbjSN5vpTTNnGaLAjzqpPKhqRuCFM7TqxkAakTCcJoQt+h+lO/4p6bMS4i5TqImwSBzm103AczybEyTbZvK0hI+sO8tgJHpDuCcYanAl0pplRiPG6hoi3fF8D5PlM3wYzLiY8h7F68EhAGdu3NYwScrMYMU6kflP2NuMpvz+8MgHO6TpIFDtTEG2ub9ywMZT0QxVbBfABw7+qNwXZ95wEzZKJ226v1FL656K8Tshqti552Ir77ZrkPClBoVovtrCtYcgZgvdVK8Tj+T0Nj3V2FF1m391YBK1NZmTnHfZjulC4E5yNOCJ8zEm5eUzYxDXn7giuvnrxgVyDoBTlfB4d8IvkPcKE/mqVMcviH3J7CfZwq7wuvr2sbaSxm5qx52UbaQkMmwQXoXiqXIH6TLAUhJ7VNn0bA4Nuw6KUSbkY3FbfhxmJ61Sg3xK61+bB0TudYFnDw5Bay2RrKSaCgoBf8J61zfn1SczEnUe4+lqgHkqb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39850400004)(1800799009)(186009)(451199024)(110136005)(44832011)(316002)(26005)(66556008)(66946007)(107886003)(36756003)(6486002)(52116002)(6512007)(6506007)(38100700002)(38350700002)(86362001)(2616005)(66476007)(478600001)(2906002)(4326008)(8676002)(8936002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZytPWTByMkRuOEpPMUNzU3ptZUFDL0h1cmNwRE83MFVGZTI3ODRJelIyYWVs?=
 =?utf-8?B?WXNPUXNxZXM2aE90eXhLd0h0NGRaaTV4U2FsWEE0ZExmZDRCVTlrM2J4YnFB?=
 =?utf-8?B?L0wzdDNac2t1cFhzRGpwRS9yK1BsQUh6dm51cFkwU21mbkVZbUpSaHpPNmJ6?=
 =?utf-8?B?UmliMWM1SXE2ZWJyUjl6dnhDSDYxcGJvc2tvWjNpZXliOXNkR2tuTTZnbnQ5?=
 =?utf-8?B?TDdsaml5dnhkUm1LempIb0VXUy9RK2Y2dDZXSkdSVjMrM1o1VXVKaFJ6RE8x?=
 =?utf-8?B?MnRGaG5HanRFSUV4MXI5bkdwOFI0Mkxxa2w2ZlpHNFJGeS9QbG1OZis5QUVh?=
 =?utf-8?B?UktlT25aTWUzc3A1dlhsSkpGcVFNd1dadGxXbnZVd3RGbXZ1c1J5QkMzR3l4?=
 =?utf-8?B?MUpCY01oOEJGWXViWW5QazFQUFArV3RBaHNzaXBCcGdZZTJ6VEtwNVVBRDhp?=
 =?utf-8?B?QWpCY1FMTGs5dklQMURjbjJpNm5jdUpmcXIvT2dLdDNFVXBpSUdIQkUzUWxj?=
 =?utf-8?B?bEJsVkpGK3lBeFVxQzBlU1B5Y25ISlZwT05JK0Q0d2ZjWER3c1lkUndQTXg0?=
 =?utf-8?B?NS9xRFM5enlIUFExZVNLeG41TlpkS2NCbnlPYzBZVW9MSjhwVkYySDNHcEVk?=
 =?utf-8?B?Y1h2N0tBVlhrU1RNMUE0TVl2K1VGOUN6cnl3dDRhNDBNdHc2MXZmRHhJUnJ4?=
 =?utf-8?B?T05UY1lKY3BNTmhVeU1KY2E3Z09uNWd6dmczbFRRU0RzaUtTQkdhZ1Eyd0ZQ?=
 =?utf-8?B?SVlQSTBkT254S01JV09tL1BXTU91RERnTkErVmJ6ZmRNM3l0WGxWRkhVTDR4?=
 =?utf-8?B?MXVMSGMwem16TUlCUk5zM2hxcWlDQmhjNjhUNC9zZkhXVzlsbTNLUExuVm5N?=
 =?utf-8?B?aVdINHNOWlZzbnprc2JmbTFIZk96R1JGMm1YdzQzTkdYeVFRb2lIb09SMkgr?=
 =?utf-8?B?OTJFbGxXa0lSeTlhZ3ZNT0hzRHNIQnhrWlN3OW9wekRNRG14eGFabW5MaVAw?=
 =?utf-8?B?VG05YnhPQmVqWHZrK1Vma29xUmhoSVNkMTNlMzVZQ3Y2TUR0SXRVbkxNRGdz?=
 =?utf-8?B?elliR3ZsYVh5OGc4N0xST21RNXhMWktEZ1gwYk9sajZEb0hiTytpMGNNK3lr?=
 =?utf-8?B?ME92anVsQTA1MzJVYnRIbG1wN2VhL0ZGZ1ZEdU9lMlRTekNrR2k2NEZNd2pK?=
 =?utf-8?B?RVQ1UmdZeXYvaFo0dHNsdk5TbGU2eDgvbC9yT1diR2VmcHcvUm9TRC9pcVly?=
 =?utf-8?B?RE1zOXdBclkxelY0ZjdMYTI1bVJYc2JPR0J0WGF2bmt4c1BnNnE5VTFPZUp4?=
 =?utf-8?B?VnIxcEd3MitFUi8yOUFyN3MrNFY1RlBHN3NXM2YzL0hDZ0ZJT2NlTUpTOENX?=
 =?utf-8?B?VkRmZExuVnhCMkVISTgxNUd5bktUYXJNdUJYR3YwUEFlbU9CbzZ2enZ4WHZm?=
 =?utf-8?B?Smp5eE9QQ2F5UkV2ZmdaV1VJRjhsaVZ5Y0kxanNKOGJ1S0lSL0l5Y0V2TGpv?=
 =?utf-8?B?MWZtRnFSTk1Qb2hLNkpGV3lkaG82bnNiTHJrU2VKMitSZUJOU0FrdXErRnFz?=
 =?utf-8?B?cmREc2YwQ0UvazNoa3plWW93cDJGaE01MmQrNEpsTTFWUWVhQzVYWTJxZ3Az?=
 =?utf-8?B?dXd4UXRlNWg0VDg4akNyak9QQUJMSmdrUE5CVDYvWDZucFFzS2R4dTV1Qk9W?=
 =?utf-8?B?Wm5ZTkt0RHc0Zy9JT2ozWjhDbm16SU8zR1lNUTZtVHJHT0M3bGRFRFlxOWFE?=
 =?utf-8?B?TXJlOU5ENzd6ZlF0azh6cUE2U25LU1hqVFhGR2E2V005TnM3dEk1S2dyZDZI?=
 =?utf-8?B?YTFRRHpTU0wvcXh4MUVJSWhPMVF1d0dsbzNHcmRnSlhpdTVZZ2ZvMFVDejEz?=
 =?utf-8?B?d2h2eEVzV2gzVU5yMWFTdTI3V3ovNXBuTFZuaWE2OFdiamZWNzFJL2k3ck91?=
 =?utf-8?B?cEE0ZENQOFJncHBvMVZlKy9SMUJiQ1o2WXhhd2JvWUJ4NjVEWFZSRUdEZE0z?=
 =?utf-8?B?dnVtbDEvMC9vTWF2dVJlUi9CSEpFVWxucjMwdHpRS3Zmb0lDWnhQWFRERmVn?=
 =?utf-8?B?Z1RuV0cwcVR3TW0xMjBUR0R3MzRzc3VJcTdlNHMzYnFSQjNpeGpDMFhxdC9E?=
 =?utf-8?B?SmRvRnQrTXpCSnd3MVBPNlZScENWMW82Q0tQdmN5eWhabmVuWEhwdi95Ullk?=
 =?utf-8?Q?wCw9W+2w+5MmEfllZsQwDiM=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9ebd6c-9e2d-4d6f-5faa-08dbb5b82571
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 06:51:11.5080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYAHhOVDcZ3IhsznhboC2BE5d8iI43qA3yeLBNQ0nhnQEWZF4NQMI/IWLSm8hqv4G7rf1/6fof5J7S2vtGGE+7dktpqAuq7f4SOSJ7ZJlp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9322
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TPS6598x driver supports an optional high-level reset GPIO.
Document the new property and add it to the example.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
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

