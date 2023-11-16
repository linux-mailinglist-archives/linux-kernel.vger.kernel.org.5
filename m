Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184807EDEEA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345068AbjKPKxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345043AbjKPKxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:53:36 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4706C1B6;
        Thu, 16 Nov 2023 02:53:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X54U0a2b5lMnFXFteZwFJQKCTv8WWpGIz3ClJ+F+e5CpNJqn0WzySKE86iSbXuqisQBYaVavv9iD+UYyknv0/7mOoDBg7XLVGSDX4m8tvCPFhYkIO8lHRQEz1UV6YiKaWzdFzRipFLT7UZ6BxeaBigPUCgrGVPjM+Osa1otVUXOi958FltfwUPhJqjFTRdVLCDeLZfXzEF8NZstmNy/w09JL2rAfQP3yDw4soENnYjsdThoq2JlJfdl6S0uEnUYIXXFDOGfNkAsMuG4TKPBYqG5Ll/4LEDzwPd5v7A4NHo1lFw8Cu371WBxfPu9ZYL5FeNvsMAMuyQuuEatzcsUNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXFm1JVcKK2Sm2WULWvxrSdeaYJ06T+WVyWjZQZfxjw=;
 b=eBFRpkTxbgNhJV0vrvqxq3nylNcyT4JOM0tzbTINT3aZbqU1JqsmdQ5ThWzWvny6NkisnDN8msYny89wOitB4cFPzDHHdGiSo9OAiKW9epiIzGH65coxdp5AHNJOrn9Ckx9Cyxbx0gIS0fM4dAsKcsrZ+hMsSS62PtjOMjkvtyZDnRChAVtMM0wDBTCj29xu5z01M0g3TSthZz2U0vTCeee448d/mUEaE+Ni19ogcp8tDo4y1HwPPk/yrkQS+1Fx72dQTHVEg3oTFPGnx2pimJx65JRq6oUKwANJBEyTkY389KKp3p+yB3/meJOTTHHkFq9J0laZxEQDhDdS4FXEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXFm1JVcKK2Sm2WULWvxrSdeaYJ06T+WVyWjZQZfxjw=;
 b=J1EpFjD2/JZVJb/aVOZP7AGtHE82op0UYotPPW5Kh61Zromiw6740eKg4j2WdD/H0nuTbR8MvTMKMA81uOKqCdZUzGspW0r8KWh9CIQ11mOXinoUpukJpQZg6sLd9SEk4VMRKj0VWyaP6hCsM2EhqprmOid33wdyCPMGidMaI+w=
Received: from AS4P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::11)
 by AS4PR01MB9160.eurprd01.prod.exchangelabs.com (2603:10a6:20b:4ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.26; Thu, 16 Nov
 2023 10:53:28 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:5db:cafe::48) by AS4P189CA0023.outlook.office365.com
 (2603:10a6:20b:5db::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Thu, 16 Nov 2023 10:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=asem.it;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 asem.it discourages use of 151.1.184.193 as permitted sender)
Received: from asas054.asem.intra (151.1.184.193) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.19 via Frontend Transport; Thu, 16 Nov 2023 10:53:28 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
         Thu, 16 Nov 2023 11:53:27 +0100
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
Subject: [PATCH v7 0/2] backlight: mp3309c: Add support for MPS MP3309C
Date:   Thu, 16 Nov 2023 11:53:17 +0100
Message-Id: <20231116105319.957600-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Nov 2023 10:53:27.0497 (UTC) FILETIME=[21068390:01DA187B]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|AS4PR01MB9160:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 698f4505-95c4-4921-5dcd-08dbe69243f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iuram3dqDY3MuLlb6cYkxmKlRmh1wphtg4KIeu2/wpRU3Cj7C/PrCC4gneno55bIC8paZQggEXzYFaSqQM2YQA66UN676A/zi9u3tjNK65jdpk1TfZ1+MPaJhElJa3biL5EzGTI9CxhNTNC4/3Fpx9vsNtrVRSnO1Ml3N1hvHtaPfk2K/sfcPiP959r2EWacW28bTH5Nnz7Xkmxu3iziuDVAYY5hkvuqkm5lOFlJoVE03VIVGFw39tFtD/TAgZgzgyDg17ajyBHBP8jWJhgJj2fFQTIceMgaMLoCJ+uylAEdJLi5ZWuU6kzD1tejLtLXpOlxWAMss7HR2Fu7Y9PxTMiil5+kCOI7P8frMC78CMY9aGBfHKEATiRc3Qho6VXjLD2uf9RBmXpsqxMfguGzNUGmKmlbdJwS27NcwtLAHEjpxRHvlzH1GqchHEAl9MA+hmzeImhPgalJWorjCt7BYTaocVarCyG3756MJllFzSg+C1c2gfJqIxa0q1m6gdBhorsJDDJDbri9G7mQMLjUQ+CAUUrsEKjYXpnsmyK+skJu5OREU5n1/M5nxBlEIEeNxrnsZh2g7GzCIbxRdvyinCdW5JxOF3S7JyubwNrJ7cAb+WsiPJrskjfjgWvhzezA49mAqScMNgFW1bPWDs1jWUl3VJK05Ydcz15p/8VOUjhyc/d5eRxRgW5bqiYhTtocMq77MDRsApqYf2BmRNCwXpdVXqgUvcq7GFvBDlhzSo+ab5vUKKoioZsnevocEu4N
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(396003)(39850400004)(346002)(136003)(376002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(46966006)(36840700001)(70586007)(316002)(70206006)(83380400001)(110136005)(82740400003)(356005)(8676002)(450100002)(40480700001)(8936002)(4326008)(81166007)(478600001)(36756003)(6666004)(86362001)(5660300002)(107886003)(2616005)(2906002)(1076003)(36860700001)(26005)(336012)(47076005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 10:53:28.0415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 698f4505-95c4-4921-5dcd-08dbe69243f4
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR01MB9160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset (rebased on v6.7.0-rc1 kernel version):

- includes and updates the mps,mp3309c.yaml dt bindings file:
    - Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
    Note: the patch related to this file was previously a separate patch
          and sent in two versions (v1 and v2).
          It has now been included in this patchset, starting with the
          version v6.
- adds the related device driver to support the MPS MP3309C backlight chip
- adds missed history of previous versions
- adds missed "Acked-by" and "Reviewed-by" added in previous versions

Note: about the first point, the mps,mp3309c.yaml file updating, there are
      no compatibility problems with the previous version, since the
      related device driver has not yet been included in any kernel.
      Only this dt-binding yaml file is already included in the current
      v6.7.0-rc1 kernel version.
      No developer may have used it.

Flavio Suligoi (2):
  dt-bindings: backlight: mp3309c: remove two required properties
  backlight: mp3309c: Add support for MPS MP3309C

 .../bindings/leds/backlight/mps,mp3309c.yaml  |  10 +-
 MAINTAINERS                                   |   7 +
 drivers/video/backlight/Kconfig               |  11 +
 drivers/video/backlight/Makefile              |   1 +
 drivers/video/backlight/mp3309c.c             | 443 ++++++++++++++++++
 5 files changed, 466 insertions(+), 6 deletions(-)
 create mode 100644 drivers/video/backlight/mp3309c.c

-- 
2.34.1

