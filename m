Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFD87F631D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346126AbjKWPhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346143AbjKWPhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:37:23 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2074.outbound.protection.outlook.com [40.107.15.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE14CD68;
        Thu, 23 Nov 2023 07:37:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKJV/ef0lMutd65WYm9jAM8hJay9SYJ85nXXHUdp5GEx4YIawqi9xxnJHZLzrF3HIPHQVVe+s706MQvfqSa9PFHdd6aF8vuvY3z9i1QWCkXOchhZ+Pg1mzkePwnieFvuCKVky+DqKHp0UvT5jAneZMvTlCPaKOz+LovlH1vR3zdStTrbY5XI2bTYPaGDDW8rxCyF+NKgLN+KqwomYzw+qZaScvmH8gs+ErUkhy0pTSf16M7Xuy64+O71Mtn1mUxKc0Xiz+9IzD6BPzzqOU5qZiLjJXYKuV5KKvKN/kmoyKALyRfEOCxNclOqA6wFADAZcQ9hDpoSt8HMeQPVEnVEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSSFJJxILrq9FVlxVr8Xq3i0p/W1AbYB4Pb3ODARUf4=;
 b=Ox/PVd46k29WAXP9jAo1Zmy2N7OrEbYVH/TLmDCC9JSayd2Ff2FapgbqnjbU3PKyRkoJ+uHuPXss0jDCVto+vdJH/lvuopdmtzjKOHQU9AU3nohg4O7lKBYJ0Z0Q3dShm6Hm7qN3orlGkwIplXQT+mbUrU+lqrEJw+EhHZavwNN5yq51QF3QXVDbE/VOZXfEFsiQ/kDArgGCLkFgO1JDS/RhLwUgjj9L1fmXKabbTFH8+WKiGARNCAU2II0MBW/iTXkLQ3Asgu0s06SslZ3tkT3j7kOXOxXmN58W5L7DYX4BRV6hyP6TZz8NHUdi693AYZ86MnDXv6T8Z9JXg8E39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSSFJJxILrq9FVlxVr8Xq3i0p/W1AbYB4Pb3ODARUf4=;
 b=0N7HzVeHsiQN5x+2654+ZACnDnhmgEJF/i5sfiDOaakWc4Wppuqfj3vPDJKoEnezc3ty65831+qYJQaTAZK+CMk8Tp/4lmUp5cr0q6+UolhmMLh6c+XBy6tJbwBwLyIXzM2yqPXGcUG5zG1NCB098bcUcXEWRMkgaYvcdYqHeRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by VE1PR08MB5599.eurprd08.prod.outlook.com (2603:10a6:800:1a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 15:37:24 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 15:37:24 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Thu, 23 Nov 2023 16:37:02 +0100
Subject: [PATCH v3 2/2] dt-bindings: usb: tps6598x: add reset-gpios
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-topic-tps6598x_reset-v3-2-0c2873070a77@wolfvision.net>
References: <20230912-topic-tps6598x_reset-v3-0-0c2873070a77@wolfvision.net>
In-Reply-To: <20230912-topic-tps6598x_reset-v3-0-0c2873070a77@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700753842; l=1462;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=32MkaeWH8tGOkOGWuOxuD6fsyjPm/VF9u3nSmwKN8Y0=;
 b=7MaPjs2xtrZW3Bem4FmSSQaoThsFivd1XCdEbiWJgpTWK99VE+ss8p7RzQhV8jyQMPNrCKamU
 25a+iBKBrmfCW72J7Y/vxPzWLCkeX2edpnM7IaltJ0ZQ/VPOL+7wQpe
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR09CA0156.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::40) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|VE1PR08MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: dd983094-3073-449a-bc17-08dbec3a1739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CtGv7CCCMV87HG7b3lQMqiUURe/HrhdfVX7rAVBz3PdQncJ0KSdVt3vVvkgF4RmvM9L6Hc+fAo9efc8/oS8ru/0h2rt9fEs9icMi2Y/XXaKZ/5hYgNLc4fx/64BTQSrLEb9ZpFtVznLIaufbkhvCvQrjfm/qW66/9W/F61vQzWSIF73dxRvrY30M7ReXLCMnp8hUZ+zUkWNaZYSykvQOT0lPeJ05rWb1IOj6rQ4v1PIpp3AKed5qLP9ox4YeL7z90TnGihe6gpQ/mSRkij0HJvOvG2WLZmbHl6FOeSjldn+voQdavCqCoiGyDrRe1xNAtoTl5hPx8Qx5E7rmjM5vfdfAAc3+lhGB3SGBYgIG2wM05yxZwruUOGUax37Yzz3zFTe1vblZr0cguBNQTe5n49eriNszimVEV1ZAqMcMMpfBLzzLf/R8X+aKTfvrv+C4ePA0n0p1nEypQd+1uFF1rAB0GRZ0/Q2U77EG03aEp2puw4xUa8Z06Cb7OuXc68J5YoLbGAatjlFP1RHWM7+wKL25wlS0D3FCARuKGHKPrFYR7zsn0itHHUZKYzh9Az0SLMzHxUNgwiUG/4fnZ2jeeoWLbEqmiiT1tAGaDKeaRLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(376002)(136003)(366004)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(44832011)(5660300002)(7416002)(38100700002)(26005)(6666004)(316002)(110136005)(6506007)(54906003)(52116002)(6512007)(2616005)(4326008)(66476007)(66556008)(66946007)(8676002)(8936002)(41300700001)(6486002)(38350700005)(478600001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WThkTEUrTDlMbFlXVHc1WG1ocUFQdE1zOGFOQ3hnVWxNN00zNk55RVRDMEkv?=
 =?utf-8?B?WnZ3WkQzMEZkNjAyVzk0L2JPdlJFZE5GRFRGOHlJc205NEdpQkQyZ2h3VFJq?=
 =?utf-8?B?YlYrVHdSLzhacEtXVXVld2k3Yk43eXFYcWgzWUtBTlMybTlIVStoWGx5TkhL?=
 =?utf-8?B?OU9sRUUyN00yL2NpU0o0WGE0NXBsUTl2NlhjcXhuUkhJWjJ3cktmUitjeWUr?=
 =?utf-8?B?MFV3MmlEaElQOXhvVXlvVk1VTXFwU0hFMFhBOWtmYmlBc2ZDREtOV083MVR2?=
 =?utf-8?B?SDdLc0xkeFBXa3pWRTY1WC9CTytjdkVGa2ZFK3Q1U3JCYkZYU3RiOGJzSkMw?=
 =?utf-8?B?QkdCdlNHWDZsUXl6U3RPa0JaV2REZWZrSVJNQ2RBR3ovZFdONnBNUVJVb213?=
 =?utf-8?B?OWlSZzB1eGU4alVOdmRjcXg4cCtPUjhNKytRZWwvN0ZUQjNFNUl5WWtxSXBv?=
 =?utf-8?B?djlHN1Z2NEx1MnE2TVJXVGQwMjJ2dU84aXN2aTUrbG9xOHJyQUxMSHJVQWJ2?=
 =?utf-8?B?bnBZTnI5U2ZVT1dwdHA3QmdkdDMwR2l2Mzl1YWdiNkxCT2gwWG82NUZjN21O?=
 =?utf-8?B?Rmp4ZXk1Q1B5dzl3UVpJME01WGVpNktDNkQ5cmJDYVhEYURKWTRBMUVNS2JR?=
 =?utf-8?B?cGZuTkVMK0ZUUTgwT1hqaUpxa3hoRW1RQkZHQlhPRnFlUDJuWU1saXgvNytq?=
 =?utf-8?B?VmpBVUdRZzdQTlJMTUZQSFkwTkFKc2pVT2FmYk9WMmRhVWNySUIxd3VsdDl1?=
 =?utf-8?B?WUVReFZGT24yRmd4dlN1VzBHbjU3Rk9NZVRuZ2Q1SWk0aWViUVltU3hQRDRZ?=
 =?utf-8?B?NjlnVTBObzA3K2pubWp3eWdHZ2xFdi93OWp2U0loQnJhUHcxR1pRY3ZkbUtS?=
 =?utf-8?B?UHZtRkVaNFlsbXI1RDYzZjJXTmtXZkIvSjBoSW1jS2NhWU9tOHJRQjRwaURn?=
 =?utf-8?B?WjE5Q3ljaEMzanNyeDJUalJhZUpqNlBOaUh3NGNPU081Q1JMQWx0b1hPeVFO?=
 =?utf-8?B?Rnl5dFh5WGthL3J6ZU5peHNEQzZKMW1kWHUwRUhQRnRxbWdvSlI3bE4xcW1r?=
 =?utf-8?B?MGp1S2c2c2YvVlZjZFZreFpnWDEzellmek56RWNPaERaRHRyS3R0S045ZWpZ?=
 =?utf-8?B?OUlIb000VzdzVUZUc0gwajE4UGpDaW15eEl4U29oMjB5TXJZS1RZWXE1SU1x?=
 =?utf-8?B?QVUzMDNtYnAvaUpnSG81WkpDSVNlVDgzL3VzeUhiclpDRFd4czNxbkJLeEIw?=
 =?utf-8?B?WEUwSm9sODlOVVJIT0RnZHlLelF5S1RERGV1RjMxZC94Tk5Yc1UzV29nZEhs?=
 =?utf-8?B?RDhYNitKWE5CN2svSG9PN1prYmNvR3k2bVQrL054Y1MxclhiWnBsSElyc2E2?=
 =?utf-8?B?ZnFTZWZZWEViYXBLMHFYSVlremxEdWtEZ21HV3oyMTNlL3pvVnRQL204SFo5?=
 =?utf-8?B?anpERVNCb1lWdzVtZWdlNFZKTHBGeWRTaDdnUVZqMHZnOXN5NFJXcHdqZG1U?=
 =?utf-8?B?amNyNGZiNzNiZTJqT3RIdFlXUVJDd2MwT25TYkYzTjBzRm1LSzZHM1VoM21V?=
 =?utf-8?B?bERlQk1wVkx2SUlYZkZBd29FT1JHQzRmbVdoSTlFY1l0RWVISXlxN0V1cEpw?=
 =?utf-8?B?aFBNZzdmb1ZDTnEzeU90Tkg2elRWM0pxU1RQTU15NnZTVTBBYlZZR0NGUXRs?=
 =?utf-8?B?bFpWbWVRMkhUVklPYm1ub0JNVG1iVkVqM01ZUU54ODVpcDEvM1JaMnkwNGFl?=
 =?utf-8?B?b2RUT2p4bVRCcG9UUXo4ZVVsYmJiTk5GWUlHMi9DYytnbWlGK1BEZTgrQVlK?=
 =?utf-8?B?NWwybDhSNjQ2UHV5UzQ0YWo3VTZ2QVg1Nk1aaXZIKzBUR2ZFSjVBU0dyRTRz?=
 =?utf-8?B?VnNkaGk4NkNKYWJxTzNzL3RRZjhKUjJiUlhoK29RbDZVZ2d5VUIwdVA5c3Nl?=
 =?utf-8?B?Q04vQzRqZlVkUVM4TXcyRXFwRmdiNEs5N2tFN3Z6QnI4Vi94T3BmSXNXdG1k?=
 =?utf-8?B?cWdYZWdHREV1YmhIWWE5ZXFsV3FEU3QyaUlQS1R6bCtYV0paVVdQMVBmYXJs?=
 =?utf-8?B?RDM3Ri80OUdZazE4cXZmeUIrSUpPK1NSWm1KcmZKYnV6VklnSnU2Y0tvUEZX?=
 =?utf-8?B?UUZQaEZPWlNoUkJ4ek55Q0pyYVhkdUVCTzJmNTBtcGhqNFFyZTVGN1FrcitV?=
 =?utf-8?Q?MlHCYoeoumED3H+K8uyoeJo=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dd983094-3073-449a-bc17-08dbec3a1739
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 15:37:24.6503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0kBs7rfwLN/bNmMpq/Vo3hWLBr6talZ6RX6l9w+DXeKiVz9NWdZAA5yDPe95zr6Y+GuOo+zjfcm6Cx07+nEeFTvtDe1xv0D8kLmyUuh+9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5599
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 323d664ae06a..1745e28b3110 100644
--- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
@@ -38,6 +38,10 @@ properties:
       - const: main
       - const: patch-address
 
+  reset-gpios:
+    description: GPIO used for the HRESET pin.
+    maxItems: 1
+
   wakeup-source: true
 
   interrupts:
@@ -90,6 +94,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
@@ -106,6 +111,7 @@ examples:
 
             pinctrl-names = "default";
             pinctrl-0 = <&typec_pins>;
+            reset-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
 
             typec_con: connector {
                 compatible = "usb-c-connector";

-- 
2.39.2

