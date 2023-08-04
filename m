Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E04C77086A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjHDTBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHDTBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:01:30 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2047.outbound.protection.outlook.com [40.92.99.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820BA46B2;
        Fri,  4 Aug 2023 12:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dam07evaW3rm4aRECJux+vi7cWJ48OA4yYRFibwwlZFDy9qpQf5jvIurJ3xnxQvBMMAdAEaCDwNfbUD0Nfvhz9IxwwxG36raU9lZBnT49ej0g/XYbcUgHYiui2lepRWX84i/rX9llT0x/wxVTsQBzkePlrVWYwGM8kiJ53thtMEmQjpjhTrn8f6Lss1VFloJw3Q42aHIdNIj3KrQaYqTZ+XLe2iBCplPuxJHQf7h7oMjuUMVxxhXzhSXmz7o+UPSUrxvtIojw2ofdm5TfXPfg6MKTpU2w+DlpCZsEF2jswR4danyNptRWeM6Q0itQMLUTbCxb/8qLVSadzNYWRjsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YsSN3S/rkfmLyFz51L4ArTDSWeX/owN6kSMYZtZ0q4=;
 b=FrqO2II6WTl13We0JbuZ4x1/fes/7cGQMristiMtJ5BgqoDAJlMVXzFmEp+hCKLkYhLYGidT+itC2TXEVH0Fhfz54O9eQHxXN6unXuNHA1l6cgF+aCqNxWVxfrJJys8j+iQh/zAL1nZYRBAseD2h6zwAZDBSrkznxnleUcewkCGFjSdW5HGsTfolj2vzF4Tyt0GImDXafhnCNMuwXLLqcxbTlT7ro/hyQRcN9twA+KxtziQMrHsLG02TZvuPEbwyhMkNzDs+jBbOb/lJPgTvSARl2tRQ4JMe9lwXHZpVFUwzlxx96y5VmYmbXdURKj9b+u2kWbklzTHCuuFm6TeB0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YsSN3S/rkfmLyFz51L4ArTDSWeX/owN6kSMYZtZ0q4=;
 b=lZj2p3eB/DZ6Zjm/5Ph+Qp7lCDiWR+S6s0FEtX1ka9S3s2wVeUVkVlxdeUX1UbWnwsmC1RsebLXojOZEM5AMlTuBf/aZ21EBxASCKk2/7WSeJgjEvDJ3bijHUjkLo8W87QAX/LfSDgJIQK8MrQkGV5BQyTP8MLnIAwnhFf+3j+d0+UY4TV9xnvlB/WY7W66BkmKao4ekI1x9Ifl2+fKHHG0L1iGaj+HTD0h67lcW2EePcKMjZPd85jQHtDM75tQLmWupDKhsFeN9RW9ar7La5jeRNVSLLcWMdnAoJ3/6cff0AlPffg85/SrAJNFuJQh5UF5BivltabrLiYqMVB3P3w==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TY3P286MB3567.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 19:01:24 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597%3]) with mapi id 15.20.6652.022; Fri, 4 Aug 2023
 19:01:24 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 1/2] ARM: dts: am335x-bone-common: Add vcc-supply for on-board eeprom
Date:   Sat,  5 Aug 2023 03:00:42 +0800
Message-ID: <TY3P286MB261112A0916D7185EB5304D29809A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804190042.2529-2-wiagn233@outlook.com>
References: <20230804190042.2529-2-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [XrOyQvcxSscIFb7IWRAfWMuon9cuTYiN]
X-ClientProxiedBy: TYCP286CA0110.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::17) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230804190042.2529-3-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TY3P286MB3567:EE_
X-MS-Office365-Filtering-Correlation-Id: 3682c3cc-d6ef-4a48-443f-08db951d32f5
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmpxrhdUD5+exU9PLY0XN71Vka4GvO4JoMGst+pLzZiZIVRa/eZSSyaBaXbSWiVk8OupZoLhuDy3kBzfPeJhosuFI3fOZADQ8+LAUCrm0qAPJv1ay8mmxnu7+JJjPkXimpo0oulIYmgD1uFHFeUy6dNMIrEJ2zBdE548KfQp+tK8Ktf7YTYQ7Yr2VVyqUgmrnM9PJA4GnZGW+P1LhIY0bnBp715talK0uEp9j0dksGiD4Xne+vfZIezsa+aNzL5cTZnwcRRTTf/e5hBK7qBWfwR7E+jEVmbycf7/Ec1ajryxDkaz5vWIwnQpn0OmCuXu0aCd5+XYsWDzogj+TfhPYmZhLDj54fkvoU9ssuOtoX4RlkK8V1ZSBftTrYgR+mMMUJW72CHmBFwJajZwq9PnNlGEBX7BNHPtcq1+9fKe8glbTn2Uel3p3xdgbMa0mZZSNGKDBFqcNo/C5x3hZDs/AiuGF+i4q6hDIMlDgUGjIxOvtLI1d0kUnZx944PuWjBFzQk7KrpW/YbZ1e7MaMv/PdbgHeM2SA51dZGPg6An7TW8eZcnW+EZ1/JgyaQbvG60VNv72pyI1AGil5AqY5WR/cnCIQyFspaOjyJrmQTbAtIPwAP8MT8El1DN2RJNe90/fijxVnPNuIS3OEp3OjuUVh0oksYnQdEPBFT2mK8XymQoZmK5elQmW3M1IR/9xqEfjxA23jE7pghDISNhWfoAW0tb3yTkv/Qxz2gXLRnSEXX+s/Ex3G0OchMu/myP2ahJY5g=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ojrRL3zK6ONWvYjkMRnVoHqclidaTjbKngZ7ViNV12EhswqBfma3wbaekB9jSFTnuh1dy7lCQ+F0KKfKHJsAOu1X3pALKQPK/ZmdKmI1tGjQccCgSheDSFJQuOpEVeleB3/8gvb8RQM9RZDxiqfdneichDhYkGe+6zdOeI7CggXFZu2izhzs70Rh2G3xNE36lZzCfBiBvcHYLRDo3hqSaHSHWPqUtVa/H9JNmU5M1AxfsedcgytWC8iPyNJd7UjF4l3qHOJ4CBGBPPRywoLwd2QbymYQmrCUJZ/fNe7RmY1cpu/ildi9PU18z9HeH2XRg8ogPGXs5/66/9smwS0frf2dT/gjGs+189ITGzWKay1oy6G14fJRhEDzH1qCTc5azo5v2UhuUSJG7pLKYGJnycgRDzo5Qg2UC12HNLiWeiX4H8pZUobrlqz2ltwG5HbYAQXXHphh6Voe1Qqa+96Wc3WC63ip/z+5eVhEJvBpDN0nTUI73c0sZERZjGHtZ21Izp9WKTX/QeJK6YNPE8LSjs6ZSy9WNemfAhSHtVfvCIPbVIppSYy/gX0y1LhbLrz0t++D1RIjKsILaXEL/bhS/GoQNAkYASktHLIGw8uyZ/dsnK/JTlkdmsnIPIOUBJyr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c/bxz9i6OwpIsLEyoRG/XwK8NUx82iNc3uUE1KuzvI0Q7BHpDtvnLHd6jxba?=
 =?us-ascii?Q?+fh6iEu1JU4qrhDDJxEO3OsLeBhYjCX01TI++KMxjNDXB71Xyaz4Kr2YvAPV?=
 =?us-ascii?Q?0Twhqy0USNyzZr/xxdpGR5lO9AtE0tYnimWke02AFKb4fd4aDYq15m0Uf1aa?=
 =?us-ascii?Q?++RMQv1E95E94JjZURCHSIBrWlCCyTUTez4V/MtFnfsaqIH62xJ2FU3H7eDW?=
 =?us-ascii?Q?Fs0gRXyUUI21qVIOzC217CvpYFvoOuTswP67lS6LJMXr0ttSdNyJGkRwAi1I?=
 =?us-ascii?Q?+P6VnV1FTz7yinXhig+TcxOVAolCCsSqecGdV451A14E5MlCdtDwWYFlgwt3?=
 =?us-ascii?Q?aqBFpnq+BJaBf38vgZa0IoFh99b2P2gw0gldbz4jXx9p7QDs9jeVr8qL6IZf?=
 =?us-ascii?Q?snxj2kcgGuR1Pi7So4p6ME/4ECeNPKt37mydz1KXwsNOubsqwxnqc9dECGfJ?=
 =?us-ascii?Q?wFflx3l51Ebh2x1bpy0Ju0YXZc/UopirM5kSOvyaT4n4WjWx6FxEqEdeVIDQ?=
 =?us-ascii?Q?fu97zIbweuFA/6jM3GDiIIAwZ3eCQZ4aUd99EcIHQnK7Tg34QmRKUiwDudfs?=
 =?us-ascii?Q?Cln14cy8BSLJ80o5CLD9n4LrqrwF4D10AF5lrPJZ6R5XxQo2vRr46UcdezqT?=
 =?us-ascii?Q?bxAwr58AkmRySxhQbGbwtw3EghvhjkVUg1SJKUrHeBGpFqTu4X/w597TCpbz?=
 =?us-ascii?Q?OfImzVvHRYoX/cx8KJRFfFiYXpLs7xL5Vmt2FooaMgseW56D882vg/BTfQQk?=
 =?us-ascii?Q?2rUJGDpIyQWN46gnTqDsdyLYX00YNr52z1BchsZX5nce6iR52X0M4vCTkrh5?=
 =?us-ascii?Q?RMEc+KmpjaD8B4Hz9P+dGMf8C3TfTKuFgZNo75y7AhO61ObAY//25vZgSmJF?=
 =?us-ascii?Q?aI5R8ESrCSsyAq4s5kOupn9HQOekUh1EkZ/c9MatbH+cwZctJo/gWDKTYK/a?=
 =?us-ascii?Q?dB9BzAH4SviUB1tGgSF8HQhP2XjSvMHQTpAWdlVcN5zsKTsd6F7/N80GHWY1?=
 =?us-ascii?Q?Nw8J/SDb3KDBfCGhCCjzclsgrFhWU0f9Ml+zpslZuDN9J978XAJhurZFHINe?=
 =?us-ascii?Q?ak5/kMFFuYLytLyBVghdSMUUp6ZcYsO7727aDDOV0u/g4mQaEPaXkfWs7NXW?=
 =?us-ascii?Q?zrOLcJOXlmz3PJgmo8VLUDgevVNBlrL78dbYIKZWwj4GBHEsxn6ATQdpOOXL?=
 =?us-ascii?Q?NSs+4Nfw6ksV37f+fEb28nc0CHE31B1shN+NBA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3682c3cc-d6ef-4a48-443f-08db951d32f5
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 19:01:24.8403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3567
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The on-board eeprom on beaglebone series has a power supply from
VDD_3V3A, add that to dts to reduce dummy regulator warning.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
index b958607c71dc..7b784a87efc6 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
@@ -215,6 +215,7 @@ tps: tps@24 {
 	baseboard_eeprom: baseboard_eeprom@50 {
 		compatible = "atmel,24c256";
 		reg = <0x50>;
+		vcc-supply = <&ldo4_reg>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.41.0

