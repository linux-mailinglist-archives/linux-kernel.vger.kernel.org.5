Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6CF7DCDDC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344553AbjJaN3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344492AbjJaN3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:29:33 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2026.outbound.protection.outlook.com [40.92.98.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670A6DF;
        Tue, 31 Oct 2023 06:29:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anwf2q8KIHxZBDCjw/JOOLj6ybMz0C9T+ktwN1becOQO1ZLgZI+e4lNv0tB6LFZI7fpRUMy+tcw1ksCJEQGHz3TNh4HGIhxyasrj+axMSNI9y+qYJJmIqlZ49UCTxgz4eWA7Rc/wRVrW1XG1QJwlaKL5xAdyLh/UFuL2m1xQYEGTHOH3DTDmq0DpdwkUMTGgeOA7CzUcmHV5RmBAZn90h+axBoOk9Cp47QNgAWce/86CaubX5Efhg08BZZYrZBFs2k8nViaokWUj6QNcaJLwrCsI6Xtf/HaoiQW6ZD0faVyudu2Alnr6Wvi4Xu3ElwOXGF4BtflXYsg4TEZ/Y7Mk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCHyy08YXwWgNjNmbSUARLQu52+baGLYFiddQdm3xxE=;
 b=Cm6wXFHHO77jEPEXPEiab6RsWZqrfeZMbwx7rWjzjOGScZu6CUoTb1XigtjaaLHN0LpZB0TGDMra3AcT+1VkxNYCyu2tICYcdWdeUxWn7bTR17vOCXlXhXGjKQw4m3QyA2044ETjr+ri+jXdXs7LruBfYUPXqW16DIcjr5hvjzuqRxC2oSTItZx70xURYVfb9w3tSCrCTiAZtIP5l7hLwsFkwAC+7085mMrwj74HnifvNS+q081L8YwpDXTONxQMMa7GLaHLUeMzNUYeN/0AxOJW9n9g8PNtptb8kV1m4b9hIMAOGjm7cu43BotH7YTPGWWegvVI8zSMqs+/Sx8pZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCHyy08YXwWgNjNmbSUARLQu52+baGLYFiddQdm3xxE=;
 b=G7fbNGTjXIbIElotZ6XAyI6WTfThKdQqHhXykm5I97bdj3Be5MR+IaXv49Q5RvIEibqP3uZIaLP4yxTDOKWxPnSVcVsUyKalWD9+YGGi5jregNNTdChH50taAv5j9mNClnH1e4trBblYGAmCW56F0/j3E2u3ibNXdpRSuiCuPkeKq01sT+tc9+qw3Bu2LhTfHXUz4XrihF4nxnFgLsNAWi9S3HkVOoX1j/lL+v4zgyxcj9Uv7bnKJEqA+ibXPwfijXvXM76jA2mj9pLLjOAbUvSXSOIYU7iB4TqLPX2/IrpHErfpEYbU4oA7f+sfAoo9q9Sy/ZQxc9MQ0nThnfkRdw==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYYP286MB1668.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:fc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 13:29:27 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 13:29:27 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     devicetree@vger.kernel.org, linux-leds@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olliver Schinagl <oliver@schinagl.nl>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH v2 0/2] leds: add more LED color and function definitions
Date:   Tue, 31 Oct 2023 21:28:59 +0800
Message-ID: <TYAP286MB0315D3014B329FE6B5873F76BCA0A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [UEev8ijVLm5nUeXN64f8mo06QF+dRwVm36dFCE90XXw=]
X-ClientProxiedBy: TYCPR01CA0068.jpnprd01.prod.outlook.com
 (2603:1096:405:2::32) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231031132901.11732-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYYP286MB1668:EE_
X-MS-Office365-Filtering-Correlation-Id: fa17beed-2fa6-49b9-c75f-08dbda156782
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: krgxuJvCS5a8/a4AWvOi8KVv3l8uazuzQytnyQcHjJdunXYzKjZBVaZEvFMU6/NgINRGqP++yCIra5H5ZGJ8HUT6UfYCtciYnouv66ga4d53abtQ5AKwM2C8mkaH/2ZGAHnlboftgK14otLDVpp0jeSePDth6exX8u2Zw69o/RouOoNTGodwL2xFehiVQAb3ftRUjn4lu0TIiXa0lHALFJ51jof1dNy6C5ClLcyEOYAJouO7V/uqbNr+8s0KIP2EsbOjynWKgIusMCfq0YSremncJjM/sNgBoWMDn+qX5jLg7c3F9bVVVpAJK7RtHVoGwdShSQPTQzhsFhor9j0kKAg7iVwM1J3R50RdaSXfHhxdSrRsfoGpukBDOoZi5l0aI0se7JOaAkJVxTXyr6TSbOJBqRusZ6vt2cRp1UAT0xyrsSCzQhfv0/L04JtkQJHY8aHNF9G7xFP1Qf7gnZaaiuN53zMR+JNc8GG6tzr6B7LCcmxP7G84Ox0+WtrhbMBApsZRbNA0vP9mQTD1Kd3uyTlWHsc//QWp0rZSq4ECvRJPJPl/o1I5levFJfqSqn3fXe7n35t/yftQwZYWhQPpEsT+hNEtOnIIusiEcD4YtKB2oJdTFrfzBHYTYlIRro4c
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5UGcbpCltnxlDnEHaKARlSEKAj5xg3clgDPb3Q4WfXO9mxxsz87krtAHWW1t?=
 =?us-ascii?Q?C9/tKtA6vXpEAwP7aYfPWBt82htjC8h45clTlr5F9xeHVsxiInnYBVY2dVmA?=
 =?us-ascii?Q?BYInhQ4OzYX4ZcZ1xOM2WRFe+LMsArkpWaPYetWu3vjUYwpFi7zwGEZz+lxv?=
 =?us-ascii?Q?soOdqVMeVeuZ06po95Qxdgb82btXVxddEkeP785KL0llzZT3nWh8GDgMSkgs?=
 =?us-ascii?Q?nVMyQXYuFnoOmTTYTwC+8AEgn7qFy2FuPhtECp1rdxSsr28bjoxoo3nIY4Gx?=
 =?us-ascii?Q?CA9+modcW4S7F1wKUnNlp9kkTD1Wag12svXWtXW37O/zjg3mBzdWbJBnjE2w?=
 =?us-ascii?Q?miB65FzR/818O3osNDwHBgq5nCTurPRUoFB9R+GjxtJOrNoXjejOHl3HCCHj?=
 =?us-ascii?Q?2E8e9DOKcZsN4/B2MX5QpUQr9ZBlzBofFIyFtiqIPwlv1g5EOqn1AzX7Mo/N?=
 =?us-ascii?Q?pZm/R9fZgm3TbYjAuWiWejbMeK6JbF8ntgYsobbtVrlDuuxfFpNP0sNhV+Nl?=
 =?us-ascii?Q?goL8p92YcN6MEszEjBZRih0dk+puRU3T3Aam14SbbCN8EJPLrTxq57A7sA5e?=
 =?us-ascii?Q?0of44dBPHPKpuDHaaMUXJ+H2D5G5mS0WN9ZELDbB8mHiPoGeq9jl3W0m4NVq?=
 =?us-ascii?Q?PS0uXe5WBBPkKjAWabcjvWTNFWR7EgVhD3j8//F8X3+HIVQo10bogwTl6FaF?=
 =?us-ascii?Q?7jHIS272SFDOMrLPbZnJk6MDuSn6oLtr8eRbN6VyanPKVQija8713hJ77qbL?=
 =?us-ascii?Q?DIV1z07x+Auw+bwwmTvPT6JNYYRe+08kWQ66FyteACba5KFkgXsQ+z/5Bz1n?=
 =?us-ascii?Q?BjlkQ7NMxWWACij7svuMFnHBNsnTtfzNPtLv5jtxbdeiwQVVQ2lWCL52gNNs?=
 =?us-ascii?Q?MyKhAQfWPZxWdpv6S3jyBatqiY1xL3lwTv+oFs/YTyR8s8U/l9MGdAje/ekG?=
 =?us-ascii?Q?+cDiYoGyLQlzGMR6nA8Ae4nOAGjzWa4JvP6/FAOWFeK937TOub8UfKEQpax2?=
 =?us-ascii?Q?3c3C63vVA95zv8y0o3oSffmJZ4Xh4ly/IEbIDD2xc55q2Q/vZIaOeL7EQpvA?=
 =?us-ascii?Q?q/KUcLWhwD9DQDOLs8raPLtTF/4LZVUe0GABnQB1JvgrYyvH8OHJhHWtnTei?=
 =?us-ascii?Q?BTnGO/OD6hKBHOGDCX75+ZH4xulZi8HoJ1xR3KuM5/i0uQx93OSgwjojpYNB?=
 =?us-ascii?Q?hsZzlHlCemah28FGF7EV17+JSqcbGp0t1QoR5fVSGBkVijIE0vTNJWEnBrs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa17beed-2fa6-49b9-c75f-08dbda156782
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 13:29:27.2769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1668
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This series patches add the missing LED color definitions and
introduces two widely used LED functions "internet" and "rssi".

Regards,
Shiji Yang


Changes in v2:
* Remove the LED name sorting patch as it changes the ABI


Shiji Yang (2):
  leds: core: add missing LED color strings
  dt-bindings: leds: add "internet" and "rssi" function definitions

 drivers/leds/led-core.c           | 5 +++++
 include/dt-bindings/leds/common.h | 2 ++
 2 files changed, 7 insertions(+)

-- 
2.39.2

