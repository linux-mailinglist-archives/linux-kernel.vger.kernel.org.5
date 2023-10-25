Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BB27D7145
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344408AbjJYPvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343780AbjJYPvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:51:15 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9F3182;
        Wed, 25 Oct 2023 08:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivpaSCO/vr8f3jS6M+IgGQCMm10HuGjscok1e8DSjrvldzwaCLbz0OrREc3jAO1hrl5yNxKan1C3pt3FDFzGyc9jA4iQcnM51WZIOv3xhNVqYdjkE7iaoq8YkqMkgeVQmsvpwN/1LWtwNMMQwtDfQngD/mbFwDxkFp+Qx1lPizVfo3EibVTPkPlXB9YjZxlC5VYwVWEy+N493sB1E1XK4NR8intVvXPia7oVflDKSHAzLUeCj7tSjSFLDswwX+sG56AqK+VUxtAfQ3rJjReuvEBMVhmRe4ExtSRzequCfERAnHNdPJN8PENrF61hsU7CtSSOU/GEGby0fCuqvmnluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGUZwAaFuAPJBm2px7vb6P5m+iiV8jGnPBLUM1awQI0=;
 b=RX6Psmfs8QpMAfqLY+FCLhjGm/GnI8C/t6ZQa6tTsqjJEOZb/ivvjo8IwkfjGqiyg3nHALZ9sgBMpGoaIRO6AUt/FXvNiBlTck+3RQv1/y9tllFTZPqPQR3kbONX7jYI5D9vmHfZuxfvuTBcuKUXU35RTxXsYytVm+wCW7Hp5beig+e4HXrcpWEcfTHgm+2Ng7xYijJ3cRXqbWZsgqjTKtms0y7VQHZNI7FlcKnfSjhrWxdc8U1alb4Ew3Y84Yuq+E1wjxgqbFE6v18OYna8fNTwZDsCbxUEA6LkB3hkcT8GNI/gLLgDRvs24EC4qX9Mq4paE1sNJL8aQ1aMNIaGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGUZwAaFuAPJBm2px7vb6P5m+iiV8jGnPBLUM1awQI0=;
 b=camlQTDK7ObVisiROZvgFN36kb0nsYu0cyfHd0f8M7eUvZduXrqi6G9Lap/Z0cYi5DXsJOu8lNTjA9mFFs+l8XM0vSb4rdwBijALwNErqS+ahzs2qNC1WFCicZETMpnrUBqN+uZbpGu2boixaS5LHIdUTjAj4cwPubW56brwViQ=
Received: from AM6P195CA0020.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::33)
 by AM9PR01MB7203.eurprd01.prod.exchangelabs.com (2603:10a6:20b:2c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 15:51:05 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:209:81:cafe::a0) by AM6P195CA0020.outlook.office365.com
 (2603:10a6:209:81::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.36 via Frontend
 Transport; Wed, 25 Oct 2023 15:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=asem.it;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 asem.it discourages use of 151.1.184.193 as permitted sender)
Received: from asas054.asem.intra (151.1.184.193) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 15:51:05 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
         Wed, 25 Oct 2023 17:51:04 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v2 0/1] dt-bindings: backlight: mp3309c: remove two required properties
Date:   Wed, 25 Oct 2023 17:50:56 +0200
Message-Id: <20231025155057.886823-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 25 Oct 2023 15:51:04.0513 (UTC) FILETIME=[0F8C6B10:01DA075B]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A791:EE_|AM9PR01MB7203:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: facfd5cc-8cd6-4adc-f042-08dbd5723275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAQeInu82Lp/vHYzfwMO88OddYGwkKS1LmbUEpsaZlPooPOB19+/DPOMLHIu9H5JXS700//dK6CuxWZ9Evi/KkjPLiBF7cJnGQsDjLcuoOSj7ubhnYwKnmUnNn78T+EX7ap4EltDG56CmzIeexyYdGXNT1YsGsJxJRuKBtyPeWkr4d4ScqJ6H1Nv3CWAsYin8/QlznYXlPjQaSI4kHat6KuHfke8xKdiNvpk6QOVdw9u6k6ey32EpiSU+GFzU9zkRc7f/8V/5VaOvb8btdtCDSvsIwN7LP6F6rPbC/5nlrMvRRFYK+m9bskpMJWcVLIIjX4/XOtXRBmWps4GUbj+xl2rO+wZD1d9BGOmRlGKTAD9tJ0XOtDFAP4EQoT9Hc2Zw4shkf+1/eYlXt0zpe3Rb5e5OeqkSyRvG2/+LyoV1QMmVg+26+AvBThWQQpuSD5/yXKIaOfyf97e4N3K33njUco1X/BFckiXxH4xt6izI9c8J4k8Oc+TK3RXhL53ZRw8VfqkdtRz3zEGZgugHu9QbmHAO2QTfaJ3BI00WaMi4mCd7fmC/osVIh0/v7Q5tEx7lJrR8C1XQHbjE37TQ0Qn3gjw7JG3Umh+VTgrxD1DUaRBzXCPGuvm/HGp2RXtpFI1sEn4wfoFVNpS+t+OPAFAPg9xORUZ/V2J0hhd2Pjz9Hz3IaGlCqybXwQaVYAaE1W5dh/uoyTzm7W4sE2BTrmqxDk6MAhzKOQ+Qb4gu24J+WSBcPP08/vJWMtnAOFFd/gi
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(346002)(39850400004)(396003)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(46966006)(36840700001)(41300700001)(450100002)(2906002)(81166007)(70206006)(82740400003)(6666004)(478600001)(356005)(47076005)(40480700001)(336012)(83380400001)(110136005)(86362001)(36756003)(5660300002)(2616005)(107886003)(36860700001)(1076003)(8676002)(8936002)(4326008)(70586007)(26005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 15:51:05.0916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: facfd5cc-8cd6-4adc-f042-08dbd5723275
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR01MB7203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remove the following two not-required properties from the
"required" section:

- max-brightness
- default brightness

These properties are not really required, so they can be removed from the
"required" section.
The "max-brightness" is no longer used in the current version
of the driver (it was used only in the first version).
The "default-brightness", if omitted in the DT, is managed by the
device driver, using a default value. This value depends on the dimming
mode used:

- for the "analog mode", via I2C commands, this value is fixed by
  hardware (=31);
- while in case of pwm mode the default used is the last value of the
  brightness-levels array.

Also the brightness-levels array is not required:

- in "analog mode", via I2C commands, the brightness-level array is
  fixed by hardware (0..31);
- in pwm dimming mode, the driver uses a default array of 0..255 and
  the "default-brightness" is the last one, which is "255".

NOTE: there are no compatibility problems with the previous version,
      since the device driver has not yet been included in any kernel.
      Only this dt-binding yaml file is already included in the
      "for-backlight-next" branch of the "backlight" kernel repository.
      No developer may have used it.

Other changes:

- improve the backlight working mode descripion in the "description"
  section
- update the example, removing the "max-brightness" and introducing the
  "brightess-levels" property

NOTE: the "brightess-levels" property is present in the last version of the
      common.yaml file, so it is not decalared here.
      For this last version of common.yaml file, see my patch:
      
[1/1] dt-bindings: backlight: add brightness-levels related common
 properties
commit: d5272d39995f4150062a67e6f2cef556edece740

Flavio Suligoi (1):
  dt-bindings: backlight: mp3309c: remove two required properties

 .../bindings/leds/backlight/mps,mp3309c.yaml           | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.34.1

