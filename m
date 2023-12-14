Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D3D81300F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573031AbjLNM2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573006AbjLNM2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:28:42 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACDD113;
        Thu, 14 Dec 2023 04:28:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEkMftRs+X2m7ez6F6ufuPZb0GRWB2vZMaOsDT1H2xMg6vRXoySlStMxZGH88ctKe7oojx2tO1pZM0sGk88a9Ti4uaHowQeQFoObkgEJEJDRSFjKxy9cvcUx0CQKJhnubZzr5beyMX8Qs7Pq4thEpPRteFP7ijglKSUc/nLDFM1j1lDdV9T9Bpf+61XZiMMyst6LiTuIefprQjfxanpAFBRi5d7apRMqvNA8gjxtXFRsrlH2dhyHGPt6jLmLLIOPQAxxDBj4svhFpWU67Avzs3xtmioq9m+hk+NNsZsX84FQctEEcUEskLzmJd5A8xubrhgOa+7wH8VbgmupbYecTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EglM22ZBzFss4vQ3hji0+r9MZtz6bMacjCC4iRAehtM=;
 b=OACSS1AXwih5ukIYx5jZZXtkY96MfsvwAHsnfHjMJqGdQBbSDELuKdywf/PMtZtXr5Rz8u8Fah9IAgs/gOmfwxPASrxGfv32QuTesR3iyJu9V37Irk11Nd8ENFgMC0FoGusxdrUSqY3bHDaoJ9ezTnfhe/16CsxcapZM760O/cRiQacqWCRnWvvtaXcdkGL8uODx4QWpUBADC0L/dBvnNOosydBwCgZsSJBTq73Vfz4bbJmBZziV3EIBsIhRFCCY7wzihCg0edzldmaicoN2E+ivcK1f8YQUY8IMBazgKdiQrzRdWgrLxX/ISJQ450pzWPMeD2alsM8C2OaxLlCUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EglM22ZBzFss4vQ3hji0+r9MZtz6bMacjCC4iRAehtM=;
 b=W2xVQgbp7QQ6lfBsfwhSqZzsfobHoCPexZdTi2mR9f3c5PJQGZbWD/VuSHmWp6353BfdDAV2okDRMvLkd7jO+dYbjZoz4s3IbCWr50bD6R3KySDpjm+JRb0VC2L6Og/WUiDUTHfvRfIHabzoH8fwCgVgwDDhvXitNfDl5B8JTccu8iTvO8nr6WEWUFIY1wVUC09mp5nv66FmZ+VzhSGm7W/xTbcRMZd+jeKcPtWZkKIwTELMEuvZUm5SMzBM6Dfk1gGIn3BqYsf5ZuLDHRQ/evCOsS+DbQLQmUKNNIoyrSJbs63Zmd+j7OvM1UOmgOoa42ZUJ2t2/kNQelevblRcUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from GVXPR04MB9780.eurprd04.prod.outlook.com (2603:10a6:150:114::21)
 by PAXPR04MB8846.eurprd04.prod.outlook.com (2603:10a6:102:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 12:28:44 +0000
Received: from GVXPR04MB9780.eurprd04.prod.outlook.com
 ([fe80::69e:3527:b31d:9449]) by GVXPR04MB9780.eurprd04.prod.outlook.com
 ([fe80::69e:3527:b31d:9449%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 12:28:43 +0000
From:   Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>
To:     quentin.schulz@theobroma-systems.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>
Subject: [PATCH 2/3] arm64: dts: rockchip: expose BIOS Disable feedback pin on rk3399-puma
Date:   Thu, 14 Dec 2023 13:28:00 +0100
Message-Id: <20231214122801.3144180-2-vahe.grigoryan@theobroma-systems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214122801.3144180-1-vahe.grigoryan@theobroma-systems.com>
References: <20231214122801.3144180-1-vahe.grigoryan@theobroma-systems.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0021.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::33) To GVXPR04MB9780.eurprd04.prod.outlook.com
 (2603:10a6:150:114::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB9780:EE_|PAXPR04MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0b1166-e433-4b61-1c7f-08dbfca03567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X976TEfxYMW8hGUoTVbtUP/7ZWNQAi0iFTLkexJwA/0gnfFng2uW4eVIWAgdBkklpy8IQrDqUjempsA2Ahv7HI3XT4aasDDAIwZoJlEw6XxvtPVkjex0FgR5/MliH9wEhBN/aMKi93iTyCE8UDHl0QX21IgLWnkzd7KiJawhaqLiA2oSq0muY2Rn3MuvHgK00syY1R8VmH9RxrXBcwHROBGZkiUFYPvRiaOlNZzK+Kq6c7jBDizSSY/fgU3oSr1ISlcSbqsDprbDpO3SVo/9Xi9wEoJjFlMZiWqFLXcYiS8RRORv4KLcscmmy9JuUk8YTVde42yp0L1/5sftC0yZMsfQxIMyjQcL6n/E00NmoWtja9g1iopr+e17SFprok/1MmGxKs+wsjk0mfFeijwNVD6iYjR0t2zr4oC1RZac2xDu99CN9CPM7mQ+Ct3iUQBszsVRxgLHEELrK9okrTb/Vh2uH5Lk3tL+lz2/ZHUVWYsn68UTNxmKQzS35k9KZnFkTsJEi3mWrQ/MUsmGWNm4zEOa8EIgBdUQHphlWDk8fzRf8G7Poa7Zv29CrHIr6CiG7hVs9aRzK3xP0dMnygj8aHsCrPsLPmECnvbGySxJpdjFaBBItJc9F/x6xCFnrmvn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB9780.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(136003)(376002)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(52116002)(6506007)(6666004)(6512007)(6486002)(478600001)(83380400001)(107886003)(26005)(2616005)(1076003)(2906002)(5660300002)(41300700001)(316002)(66556008)(66946007)(66476007)(4326008)(8936002)(8676002)(44832011)(38350700005)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ColuNPKadqux9uHoDBdwA38M0X7LV701hlkmWZimaavF1iK28IYcOiocKcRz?=
 =?us-ascii?Q?ouFPDcJKsGksQOj1Do6/PiNJzvQMI21b+bz9fggDYexlMNzKFICRWiAAe8MV?=
 =?us-ascii?Q?ecMWBL+1gbxE+12w6eZdfzt6Nc2HbnqCmNvmFpnIBalDp3R6qoXpsBmmKx46?=
 =?us-ascii?Q?3qqK/0pS69t3J3TnhQG3VPFkzeYW/RBVmzHB63AzaXUfd/LwJPwKJmjwT4nh?=
 =?us-ascii?Q?EBBQfrHVp/O+PewjDo5OZTHiEKkBCTH8woOfo3I43Jl0CTFgt4EsFvtgDbgD?=
 =?us-ascii?Q?+22a5Peo0L7z7K0GV1H6A1Cb+NWZq31BZj9N3TL5IIK6y2PMnmO5gmzDSQFD?=
 =?us-ascii?Q?QNPDlcVzC+YsVBNdmrHpKFlYeWHYN2QZ8P1O3a/ftc+gUr8JBSe0A52SFImj?=
 =?us-ascii?Q?6O8WYtGL15TMIPHIxfxbFI/g7kBPIRP4SNFdZ5ik60Itv5gDuyH6pnAkFjBA?=
 =?us-ascii?Q?VFJfEBmeTIWRlKkNFJnfdZeAw0324HRGhvVSB9Evhr+CTwsiOykyDP4uQQeV?=
 =?us-ascii?Q?NyuOucg/gQZPQjfCpOQrw8nCmWm/SVdla8sCSGlJr+oxmO9lnEmX6AX1mvgK?=
 =?us-ascii?Q?bRQV3eDHlaO1noTsjMVBD5EVK+h7PcRNt+WIn1I003/pGk05/1FStxK5Q8bV?=
 =?us-ascii?Q?LlmIRP1zMQqR6/e4gPPuyCn0+7XJ0Ca+UWcwLi/PkO0cSf8fW7dF1YY/6mTF?=
 =?us-ascii?Q?vqXgRLxLYzqOmeFatp6ykcUwuhb/Ua4+EBgF2AdqDJUtlO6GkGKxroA9XbzD?=
 =?us-ascii?Q?Md/76ysPDBWXWIQlBKZRU6ErGqmsMksCkJACmxed7F1pmxbO/OFWPrlvKlqT?=
 =?us-ascii?Q?w2FZIz6TDfI4O4T525auvsCLLnBSgPrsh/u+AHtmi3upQF8vTwK7tVahGY/k?=
 =?us-ascii?Q?GkVIRZ6dJUPRLyb88D/oYcitzfOniAdVpdCNQWBTqMCHICDTPEKYxNEh8GzJ?=
 =?us-ascii?Q?CT2v9pNeilqikPpChq/3FFsw6/jCsyPLNtrSzDF3bFQnKdOmoQhCxg3Yp8ju?=
 =?us-ascii?Q?2KAICryPhkO599BgjCz+8b0rdk7S2YhVLqqb2h4bk9dhmURI65pZOTDfMRK4?=
 =?us-ascii?Q?Hmv/c+5t92BTxKnlrcFWaIy/DHl5adiAU1ikMt90+dDhsGULuXkKH++PcdzL?=
 =?us-ascii?Q?zVD2qr9OW2KdMQFVyiQ5cZIpN2RanYCkqX+WIMDbTHq/UzH/pho3BNR+Apsi?=
 =?us-ascii?Q?2yfwCEUxa42iDIeaKyTGM6ZylKU05Xt1Uxu0RSEaA32tPm5gptHBb0Lgi0sS?=
 =?us-ascii?Q?1v3ca1S6WQWR7027CDp9N7Pwb9J1lSh2zpvpZYhEGdy85iuPjhSVqvGni9+v?=
 =?us-ascii?Q?5Rwa983KebwftOgSZB62jZY1hGaui9V8SjmAKINnKKoqrfN9RYlZ1keVbJ01?=
 =?us-ascii?Q?ClAF+KXH931PAU0+NCxh0OfxugPzf8DewbE6IcL5zDs1QXWp2f8TzkLP+kG9?=
 =?us-ascii?Q?wtWgDLBOAWvhFpfTg/HTUOxEXTekiTZymVP9EniixCwE5/nrqkKAqtsX0Qbt?=
 =?us-ascii?Q?tKdtbPj8tCgRfhm9vLJdlireZVAF2P1il4DX/OiE4hmVXlU7CuydEswg4Uj4?=
 =?us-ascii?Q?jYqwSyllYB89a+l8JUttkpvxCwkTR2MCIbCsgN3BSsS3LU7Hh6qRxyJV11zU?=
 =?us-ascii?Q?lC+bLFkm2+bF/gob6KiON18=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0b1166-e433-4b61-1c7f-08dbfca03567
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB9780.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 12:28:42.5117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLAd+XqUxjljU7DHOI0Qzxx+bm4rurDBJdRl4uhib2tjuSwGfj1tbGO42j7FERJziOCiOZ6329jJxC5owfelKzopG2JBtaqcIyYiCH14UVTDXk3/2nmRv0IaaN5R7XbD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8846
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Puma SoM allows to select in hardware directly which storage
medium to try for loading the bootloader, either SPI-NOR followed
by eMMC followed by SD card, or SD card only.

This signal is exposed on the Q7 connector and allows carrierboards
to control it however they want.

This feedback pin allows to know in which state the SoM currently
is and provided the current state isn't modified until next reboot,
know from which storage medium the bootloader could be loaded from
next time.

Signed-off-by: Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 20e3f41efe97..ea9d6ab73df5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -119,6 +119,20 @@ &emmc_phy {
 	drive-impedance-ohm = <33>;
 };
 
+&gpio0 {
+	/*
+	 * The BIOS_DISABLE hog is a feedback pin for the actual status of the
+	 * signal. This usually represents the state of a switch on the baseboard.
+	 * The pin has a 10k pull-up resistor connected, so no pull-up setting is needed.
+	 */
+	bios-disable-hog {
+		gpios = <RK_PB0 GPIO_ACTIVE_HIGH>;
+		gpio-hog;
+		input;
+		line-name = "bios_disable";
+	};
+};
+
 &gmac {
 	assigned-clocks = <&cru SCLK_RMII_SRC>;
 	assigned-clock-parents = <&clkin_gmac>;
-- 
2.34.1

