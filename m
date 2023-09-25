Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E117AE06B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 22:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjIYUuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 16:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjIYUuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:50:04 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E026D19C;
        Mon, 25 Sep 2023 13:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4oAI2IyyX4/a5i17hkz3kfbKrIk3Fvi4vEF5DsrHMUaRD1Hv14+8u4s9/Ol1utywBdhwu9WJr4FTfdpiX7VKkkD+qy8INS6gJfnoPRu2cEkqXHta8pe0ZuGlhV+cxx2KFdTlYBxhyhl2QcBNc7Jy5iNTAS6+wsHwbYfds3id0TijMRgMtLSG3gAhaIv121STXNmIEltmFGJ748fRabHPvDiPJ0eYvvS4AqyyA2+/+JNabxz/FRyflbgcpr8t9giUwD4PHRODH7lTi6lM9RW+yfS2Im8j+Cwmp6SAZ5OrDfjWBmOJ1s/78kNvBOlCoZ9B/o4cpLy1E0UFpTaoSDm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58BvkHJLPT4T3z1grdJOnTsbHOzNJh94wZ/IZ9kxKfM=;
 b=HvgSVUWqxiVW862esTw4TEG4E5X6Ba6pkaeBvQC5nBTHZcXS3vvQ5XU9BA2Cnxco2gOmGAun9R+JdCg9e8Qid/Px72TRqXotO9ipOgzDGGi1iCAlSNBgLHBigqK+Th6MY4h0G+Q+4ur4njRRUNTnmciUvwehkj1RBjc1pJ/V6VD+u+VIHrhZnQAw0FUry3qrxgXlNIvl0I9SuYWEMU9C+Vb6R43WcquqV+duZ8JEJHkS7UGl3mmEaO9PTiteYeGgiU3lVUNVRuzdOjM5n5ptjSY9dC/0Q8VuutVE3BwRz4I+CBp/vWr+ZedF0/tKdsjVlq88Vun26Ys9eSMGcwzcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58BvkHJLPT4T3z1grdJOnTsbHOzNJh94wZ/IZ9kxKfM=;
 b=eFEhndKy2UQGIGLkrvUr/RhizXg4rAANpMuu+4/Rv61MBgndhUcKw6r/N8yja8bP2n4vjXd9e7l1e1xOSWRyXnvqaEJw4QdwNXfN91gWjtLy4FQdzIQ3Q1/bBZCTJB6L0TfOPX7QSxG+lrwRyruSjx+mTE2IwZWcuVg220oM278=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7809.eurprd04.prod.outlook.com (2603:10a6:20b:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 20:49:53 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 20:49:53 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, shawnguo@kernel.org
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shenwei.wang@nxp.com,
        sherry.sun@nxp.com
Subject: [PATCH v2 4/7] arm64: dts: imx8qm: Update edma channel for uart[0..3]
Date:   Mon, 25 Sep 2023 16:49:10 -0400
Message-Id: <20230925204913.3776656-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925204913.3776656-1-Frank.Li@nxp.com>
References: <20230925204913.3776656-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::14) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: ff849374-ad88-41d9-c006-08dbbe08f7d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1De/z2kExRaKVozD8reG54SDHzF6ppSMetZkcpLxjDXYThNxSmmL7g5hAZZgcH8DA3z+u0T0hPrqWRjejGxVbMxyP1teZ4IzeBii9gL4t8cr+toDXIj7eTIYNZg2oe7lqEJwyTFPiGe6RKHYBb5b7tnKY96XRslLDkfyVfaixgj3GVZeFidMqgynzDBnWKxlzfuFD9FxUdh7J7YaquclUhB9A0Ta0mBDu5rdnQs0b01EptZn9YtDslyOcbEKlDbtxK5I7va0sLe3h6dmMkTx9K1IsIwyK4ANjO6u1pfPz8F4O3fJIzGv1ncfXSQfaulzvV+wCfaFMWCZr6TaMjmXf6MNPOt3VWr46s9lg+nnXcquPBQNiuEoGAhF+4kMnjiZZYDlWgokUVoxGBfQsmhsr6UaB1NKgqK1+dZhNjv9Hv9CMB5m2M3uBbGN/KjxYgYFuC6Je5uGN0PEMVFJRZ9qjMk4gthY9gdoEd7MtKr2kggaAR8DoIxpVsH3LnsIHEjCV/bQibwOmjmQLZpE5kdPpbuvw5NEmBMIof+ZXkyZT++x2+VVzaswE8Vn915kNCYnJYJGiefgkxfal+GM28ZvuB39hcLyTGcnsYpa5/RFcxXCK8TjvNUTZjwjoHwriy/LJzVikE1Mspk1I4jCqCuNTS8P/tev9iLhl+JyWFpJc65dU6UnZjMY8n2JdtufDHYF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(4744005)(5660300002)(2906002)(316002)(41300700001)(8676002)(7416002)(8936002)(36756003)(4326008)(2616005)(86362001)(66476007)(66556008)(66946007)(1076003)(6486002)(52116002)(6512007)(6666004)(6506007)(26005)(38100700002)(38350700002)(478600001)(32563001)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pP+HiFX1KYj5Hgez12G/MH2tJYcyMq/qBCVn1Lefn5XOmVrnS+4blRrx28va?=
 =?us-ascii?Q?gDqMvbzNkE6I9iIR+RItyRsMgeRnpDeNIBRlZerqmpawaAyo6RZKVYQ7srZH?=
 =?us-ascii?Q?GgQSpVnI+1uyOCIyjK51O+vRqPkT8ULA/l4p9pjGHkSytaLOc01Or+i4QDzL?=
 =?us-ascii?Q?yoKfNXcHXC6rnJglAa0NVCLyfgiiBYwFzzKqNOYZx2hgqZVBQ6OaJOHGb1A7?=
 =?us-ascii?Q?bZ7V8QRi4ngh8IpG7apozH+nQZdECM7ol3OY8QpiOFWMEQTQE26r9zpJrNcv?=
 =?us-ascii?Q?sJNsXJBWg61qfJZKUbcfRiMHykrt4U2I1F3hKF5zzbPE/lVBtWuELDrCVIlB?=
 =?us-ascii?Q?tlQXWnABNS+b1UXQ4QhqeWwyX5SQVE0EtA64XqidKrhHKUhS8ySGaUemMBK/?=
 =?us-ascii?Q?Vkt7772gCfRU6SvJ6SNykdW1w3ich0DZL6HUaUmmPk2+Myoa5a9DXWfP60Df?=
 =?us-ascii?Q?vz2fYVujlwFphwA4+YzV7UaukVEa2e/X/UWwVTOAZ+I34aTKSS9zNX1wFpni?=
 =?us-ascii?Q?4VATXeMv6/sUYaJMKjQmnUW2UDWmkvPx4q9w0fdsTq40CDyRZpAcileIPBnn?=
 =?us-ascii?Q?dn1xJpSOhsc6ncbsDrci+rE6+tMAsWsLo5mdA/AtT7lTErVKb/LgMxoCJV6M?=
 =?us-ascii?Q?Ia38XMVgtddzcj3NI+xO6KAzVj/FjiefmLUaQd1A4U5mrbBFLfqlOD35RF1F?=
 =?us-ascii?Q?IuWap1FbWWI4ilcg6c/3BvWktrMYtSi6UX9RqJIMqdWdrBJwCXnwOlPnba5A?=
 =?us-ascii?Q?Rji2fTAp5ii2/lfHGaAODl2lEZtELcAll+yF/C0v1FXR+4KQy9IokMVTXOGm?=
 =?us-ascii?Q?5jrhuCwv0t5+XmS2v9A5QLO+8u81n8Wu1beBpr20ZfUSO9Op6ZA5gb7GilAn?=
 =?us-ascii?Q?e0rHTGaPaW7kiDcVdq3ZTiLL4rIrHrh6fjazzMtr4oV9EFRI1kVtwJhKJjzx?=
 =?us-ascii?Q?euU0E8m3I0nd3JjL3B34LByNPO4jq3c3e/X+KTjN4LOE9Qk7aLkm8t1MvnnI?=
 =?us-ascii?Q?aTkDX8xI/d3jfREoLoK9x1RWK6tdx43SWIsVSltLiRbGDWnB61eDoYktBbw1?=
 =?us-ascii?Q?e0Uf0HYhoRKe6i6VXrtCIi5ik8wu4StKkFywy44yC0dUYKqab/WudN/4DHfi?=
 =?us-ascii?Q?a5krA30Wzemw5m3jO9CyVE3ciEVvX3ORsEq+55sRXBS+Z/9LdVqFrmVNipVM?=
 =?us-ascii?Q?yJaolkN+bcvLfGncm3ozXgH3lSpNip5JVlnur5brLzOiSX4lOi7P1L2JFAT5?=
 =?us-ascii?Q?F5e7r53Vi3L/bR8DWf4/1hu0EPu1RtC5clWx9W2nNEptWbvpli7QGaJ5Qw8w?=
 =?us-ascii?Q?+h0h9YDrQB6s80mQTd9pSGVdfZj9ocoGw4fT8rwlcnZDlnxHvKVNh07gSuTX?=
 =?us-ascii?Q?qjRbGkRdwQE+CC2A959sSJXldn3bSLj8eFsnNxmtsMwp+KgBFcmfRJQrQW16?=
 =?us-ascii?Q?aCwL770oITwQM41A+BFt3OrEVNFEkcZKXuqFzDpdkWyezlu2gKajA6KywQil?=
 =?us-ascii?Q?4BXgXTwVGGm1yih39If8od3tcyT9KehCSl31CHHsv2nPmkRGn5YX5jIN+4RG?=
 =?us-ascii?Q?SuPP2qMNbxo7wwZN2eI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff849374-ad88-41d9-c006-08dbbe08f7d2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 20:49:53.3565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vCayR65QF3m3nm2RFBQiO8JukA4DQYR03rZcJWV+OhUwQiBq1Y174Zpc19YussgDnz6rNhzxHwVZd4dT1gnqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

imx8qm have difference dma channel number for uart[0..3].

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
index 297ad4ef4a78..01539df335f8 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
@@ -116,18 +116,22 @@ &flexcan3 {
 
 &lpuart0 {
 	compatible = "fsl,imx8qm-lpuart", "fsl,imx8qxp-lpuart";
+	dmas = <&edma2 13 0 0>, <&edma2 12 0 1>;
 };
 
 &lpuart1 {
 	compatible = "fsl,imx8qm-lpuart", "fsl,imx8qxp-lpuart";
+	dmas = <&edma2 15 0 0>, <&edma2 14 0 1>;
 };
 
 &lpuart2 {
 	compatible = "fsl,imx8qm-lpuart", "fsl,imx8qxp-lpuart";
+	dmas = <&edma2 17 0 0>, <&edma2 16 0 1>;
 };
 
 &lpuart3 {
 	compatible = "fsl,imx8qm-lpuart", "fsl,imx8qxp-lpuart";
+	dmas = <&edma2 19 0 0>, <&edma2 18 0 1>;
 };
 
 &i2c0 {
-- 
2.34.1

