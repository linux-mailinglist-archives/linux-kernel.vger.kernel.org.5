Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5282A806C19
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377475AbjLFKgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377470AbjLFKgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:36:41 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2044.outbound.protection.outlook.com [40.92.107.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA31D46;
        Wed,  6 Dec 2023 02:36:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R93ckRt4GhPBB+w4Du/ivOoAUwZ1ckvraCRn0cfnfN+zmQ5HQAgYg3CXc85CYmR2UEK6YRNOZxhn+C8DHlYxjDuah4VGHRxS3OR6yMdFRbL/arhdO/vcSZj8+weO+Hv7vBJW2eg79OZO1lfy0xYIGY3hyumPZ2bnbtIjRgwN+bEAR/rXcHx5tnOKl8pZ5llAa5oTsBc91uXy3hloibi7ARGnMJpGic6LIqMFzk2MtSDvNb47658gGSzeI3HKRHCYGVe5dItKSJXUd1Inbh7xbaHtPKZqHQKn6/+ONTi2Cenp7GpEe0/AmwT9VzpxoWjw+Z2mnZ8VWwu9W9oXWVUd+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrnNNDTCSyMkyPuZfO0JGIdt68XZ1JSrpJY8tQwSR2Q=;
 b=We7KIMtpxM04XX3ZtjVCWhyD/caQqtdSzqVheMRPyuTw9A2wbFBK1AD/Qfp+wyOoiRxT7nZQEUVLl4CiA8rb6e1wALo6CkImkGd2UcVC/+3K1sOwWGM9b90FwnKYf+0SlBoAjwqhN0xkge86wIRgxHAfc7Etgsg55yMcvepKCp8KyNTR6/8hfZ8JSoB9f0lk2XHNUm7ReBs553zL1oL3wHHmxv5I6trTs8KQw3FS5Es6kuyE4yghVRtLtcougMDDmuV12eyfonjqGV1pLgR4x/QZZKxDgbqtRz7Ppg9L9gFwtCfM0GGATc1+JB7888/afjMOD5gaHsjnql1Ceh7xqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrnNNDTCSyMkyPuZfO0JGIdt68XZ1JSrpJY8tQwSR2Q=;
 b=psqN49M/szRt7ifmid4CESYYVS9wn67nvbUhkTBxjEukyKiVv7xLohQftOEYzg98CiipC2v4x8yI0sO+an2NF34hGDFakpFtdidZ6MfVhlh0Wo1Cy0FaVlhrGK0NxSUO77KVF/PDMq8u6T6tWMd/p9w1415jLQ+cA2A8ykANarMWavFyIWs6pVKvK8zAHhmvIXRYjTe0yVH3IHnYfuNV3Fca6jKZsf7Eb4d5IbDVs/kBOYkICoQfdYW4CtwDAm2qI5OhFaqV786UxPAcZfnV/gf1Hnfgcn8xbylMCN8PFoxlhBlhqZBivMaRBhoWkaih33Wn360TGPli0K/YnVLddA==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by KL1PR06MB6866.apcprd06.prod.outlook.com (2603:1096:820:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 10:36:39 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::f2fd:d852:e4b9:6166]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::f2fd:d852:e4b9:6166%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 10:36:39 +0000
From:   Allen_Lin <allencl_lin@hotmail.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Allen_Lin <allencl_lin@hotmail.com>
Subject: [PATCH v2 0/2] Add HX83102j driver for HIMAX HID touchscreen
Date:   Wed,  6 Dec 2023 18:35:44 +0800
Message-ID: <TY0PR06MB5611F2CBE520DB21F15DF9B99E84A@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [KVJZniM0nc4/cxrr/Wjm8PRzHGQx9mfU]
X-ClientProxiedBy: PS1PR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:803:3d::27) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID: <20231206103546.808680-1-allencl_lin@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|KL1PR06MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: cec0f647-16e0-4a12-9575-08dbf6473acf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEVjd+KHhnufYCvMTtpxRY4Thy5oC1hSOhZjIxpwdEXCmqbzYUN0wVgiIrigVwPfW1r868g7OEyEU0rBGzuSEJOcChJ0lzy0y9nbqyxWSH/DpH9AAp/7PWuEVuuKhzC+Zc2ltlyMgjDU7st0/qN3sFxJMJqcWKZy9kRiwEW0fH54X1DWDVn9QSmSxNPKAmF8hw07Cc1nKjZmu4SEoAtH62SdN78DaJBLnAZ0k4h8xipq6PC0NZKQfQRGkaldzZzZacewBFlJlJV9r6reEVCyjccjpzEdcSXW6TBaew3ryXY1+0TeL8ikUzhqVDc9Dq/36yAcKXWVTqThplwJbIfn1M2fgcv2Go8h2f1vQeHwnC8gPbQb86iLTOE2fjZoj9PXbnuUqqK2jO9vlpMfQdRs9v0vly/6SVzXLpVy/7rx5y2G7ukiXEZ84INXjPB7+mulDrgkTOre7mBeEUC1aLLqrLtFxaMNXYzC92G8oTf75QkTG4BZG5DE9Gt6K9T/mXAcq8moYcB8Zx3+ceaFJqVRaa3VSzfRwW0N+SCqkjmQYQd/xvD5G/S2uvYHcwnHzBNjY0jHdI235CW5ujeq8S76DLNwwuIZ3tVFuRtXJtp0sVYOqvvQY96FrM6CaGV+Vk1V
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?99w5QYtAoOkCvIUtxYYY5YMwLXpa9a2iuHcn0zaX11yZ/IUCj+wZmyI9UR9t?=
 =?us-ascii?Q?xEiW/ess6eJyoeRj9sBxaw9+ZYwDvi4bvdbYUDZg1iENIU0vYAwvKQfMIhwk?=
 =?us-ascii?Q?LeCeeuSuygexpVTqrH0cqQpt58vnkxgtdVPCdQYBJ0u3Y2Vw2XZyPPAUF6Fu?=
 =?us-ascii?Q?mqcz4G3cPJOVYXNby48Bh4cazSDUzsujnzApvV6XkHkRl3SykJ0K3/PzzhBe?=
 =?us-ascii?Q?Ln9YeVM4NcZFr4e8dQdUC93MliPDK5aasM5fHFf1ll0OWH2vGYwOXAC60Kz+?=
 =?us-ascii?Q?wsdNFnNUX0eE86i8bZQvFb+6bYuFoQntS1/hXgqNhttYvyg8xBji9dNwgLjH?=
 =?us-ascii?Q?0p1/lhSg420uX4VCl3nekCl4xwzCSJC8ek2ewETYt0LkiDNoDzC7Z2RP9Tsh?=
 =?us-ascii?Q?fB4BLo8a3q3QVciTu12arDIkY8cipV9YT9j0wECrM+7pgN78vT352hXGMnT3?=
 =?us-ascii?Q?lhzaAuMp1b73xEH/kCfKAUwTKuwD46HzdPMirBkisSSC/+PAaL5s8oIE0uHd?=
 =?us-ascii?Q?3RM+/yEIw1PPBSnzoCSt503UqLhWJOx0YXki8MJsz/PekkPW2GJVkz8d5KbQ?=
 =?us-ascii?Q?4zl2RIkBgzHrbyaZgGZlbc5duhJDG+Qb2H7IgZORpRcPoHfX9o+jr4yh7doK?=
 =?us-ascii?Q?mERVoI7orRokGBxZ9W3hN2mXhFCN9IM4bOgk7uw5E/Doyk58rNomdIbYY213?=
 =?us-ascii?Q?v+t68OITFqiEd7Zy8+jOdMMZ/JnR/kXJbtiyrQu9xV2eLgTp57FYnv2JJNEw?=
 =?us-ascii?Q?XKwhIqGC0poUUDayqxDdTc0brcdEda/i3cVILlfeExmRbWzQvpcPMnzJXBEG?=
 =?us-ascii?Q?xywtQ9STXydoSgqmW7tv28JhkISyRqs+6wl2fWefY00i0sqnUsIsrC3OVbc9?=
 =?us-ascii?Q?9TuYP5GR6bqwHh6DEMOmYedNsIAYizRPZas7fMMGylVyhoaMpw1h7w9B5kwO?=
 =?us-ascii?Q?dJHnlcPuXIoHH8wXP9M0OOnIJlJ93Yf1V8bLNwgsPbMhjtkHb1FyapJbAySe?=
 =?us-ascii?Q?/LUmdS9r6qRSEABa9AyEKwtqsSOrAo8ESujjoqxXWys+iHvCSe8e1d0dcE7/?=
 =?us-ascii?Q?Amr1tlPUOdn9UIg0edrS3K1IjOiVZAF7sszOzLbkRm+ZicI8wiN2dRYQew93?=
 =?us-ascii?Q?qd76MrXEB4BdZqe754wIvKvL/Gnx9Q/wmo/0MTi8k++N7I3xks/wE4tWqRWd?=
 =?us-ascii?Q?LRIowtdNVK1Gy0zPbiljFu5Irzbl6MZIumq/NA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-f764d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cec0f647-16e0-4a12-9575-08dbf6473acf
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 10:36:39.6043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6866
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This driver implements for HIMAX HID touchscreen HX8310XX series. 

Using SPI interface to acquire HID packets from driver. 

Patchs notes as below 
1. Add the Maintainer and devicetree bindings document for driver
2. Add the driver code and modify Kconfig/Makefiles to support the driver

change in v2 :
- Fix kernel test robot build warnings.

Thanks.

Allen_Lin (2):
  dt-bindings: input: Add Himax HX83102J touchscreen
  Input: Add Himax HX83102J touchscreen driver

 .../bindings/input/himax,hx8310xx.yaml        |   70 +
 MAINTAINERS                                   |    8 +
 drivers/hid/Kconfig                           |    9 +-
 drivers/hid/Makefile                          |    2 +-
 drivers/hid/hid-himax-83102j.c                | 3175 +++++++++++++++++
 drivers/hid/hid-himax-83102j.h                |  923 +++++
 6 files changed, 4185 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/himax,hx8310xx.yaml
 create mode 100644 drivers/hid/hid-himax-83102j.c
 create mode 100644 drivers/hid/hid-himax-83102j.h

-- 
2.34.1

