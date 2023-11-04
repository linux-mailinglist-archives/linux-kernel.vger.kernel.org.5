Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298987E113C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 22:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjKDVTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 17:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjKDVTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 17:19:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2025.outbound.protection.outlook.com [40.92.21.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13850CA;
        Sat,  4 Nov 2023 14:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVXWz+L9lIN8lXCfpDDvFSGzO5zUfXnsqWL519MGunjUJODC+J2p8EJ4Gomel6sNz628qLZhPDfwtQB879GXYP0+/N6vvC0QzNWhlIyltUcqlLMFUGlhA+G92XONdd/a/UhuD6m0wcc0fpI+5cbuoK+Cdjxkbum2msxux9UtAcUtliSI4UxeKrf/EnYYgDiurkqs+kogZUjap4ETvOdqWODTUb3QN7nLdef993tZkiH8Du3lFKj4Bm8f8iE+13wa2UeqSx+K1Qb4wVGnGQCEIz0Z5bPGHoXd2U/nfkNVkXcuDnOAq6QtAlfFEGhGkWMlB0g06unA6vo6GVStN6S8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxznYe91Y1LgfNMSbH8NGIagCjTUtmOY/ZqsA92VgFE=;
 b=ig4Xp6w5fEyA13yjLI5D+Ne0b6ZtRp3Nj/ctq3ZxjwT79VvZghWNUNAcWyDQ9mxxY+h0KFGqmrFS0VEbBivNTNIPGXBKpwfiUo4cdfcddf1qIexglDJ379uuSd6U4NpvSRptX1W9lUe0wMJiUwaZrvjdPk1qWWddMo5JT4Gc36kk8qaC+xxkt/EZi7kpGoXdS+k9K+lMKNFAAY2UYmJSzio1XFjXpbUVWRrY/8wnXusvXM7+XoW0t1/nv+H52QSTwqZezGNKf62bQD8+AvmGQxtQJbN2lZkzwmCmpVeK0Mx7lV/GGfhl67Pk/rMfSuLQH2iS9SAXgn+OD2YnceYCLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxznYe91Y1LgfNMSbH8NGIagCjTUtmOY/ZqsA92VgFE=;
 b=T4qhOCHNuS+QIXm/cnYMv2mUhLPIGosYcgWcDuI1LbQvThdS7uHZtA0p46gAJiGKhHfDz1w5lTyFrcyTgDulfFk1aTL/nCt0+DR2osz8IefLmc8Rj9jNrYCpJDKXkljx5wJZJI/+Qxar/ItXKn+Xm8or+XGdBCYEQ2PD/il3pXeLmV/LUSb4axsUe3lL51V/OBMxkZqVPB5z1JmF60V5uYEr8r9j3/pnoxGIVKLB7bImvy7Sqhntq67CCFj95HNS0GGSIWHfuE52zX1WmLpD2AoJchjLgy2Ea7/scM5AdFAvj9HNxitEHyrN643WtYpJkyKsZ6Xy/u1B2hjF9HGmhQ==
Received: from DS7PR07MB7621.namprd07.prod.outlook.com (2603:10b6:5:2cd::16)
 by BN0PR07MB8973.namprd07.prod.outlook.com (2603:10b6:408:154::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Sat, 4 Nov
 2023 21:19:35 +0000
Received: from DS7PR07MB7621.namprd07.prod.outlook.com
 ([fe80::60ab:103c:162d:d50a]) by DS7PR07MB7621.namprd07.prod.outlook.com
 ([fe80::60ab:103c:162d:d50a%3]) with mapi id 15.20.6954.025; Sat, 4 Nov 2023
 21:19:35 +0000
From:   Alex Spataru <alex_spataru@outlook.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alex_spataru@outlook.com,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Kailang Yang <kailang@realtek.com>,
        "Luke D. Jones" <luke@ljones.dev>,
        Andy Chi <andy.chi@canonical.com>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        Luka Guzenko <l.guzenko@web.de>,
        Yuchi Yang <yangyuchi66@gmail.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for ASUS UX7602ZM
Date:   Sat,  4 Nov 2023 16:01:52 -0500
Message-ID: <DS7PR07MB7621BB5BB14F5473D181624CE3A4A@DS7PR07MB7621.namprd07.prod.outlook.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [flRNzzerLAHaig4tFlLpBn3eHGribbru]
X-ClientProxiedBy: SA9PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:806:6e::19) To DS7PR07MB7621.namprd07.prod.outlook.com
 (2603:10b6:5:2cd::16)
X-Microsoft-Original-Message-ID: <20231104211906.221206-1-alex_spataru@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR07MB7621:EE_|BN0PR07MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: b717d0a2-e21e-4185-408d-08dbdd7bbe17
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qje9zM8875MeP5oCYbnjVlvzO2EiKiSW37t25tN0eb6KladWKe/Ffi250wtI2mBNIHJCv1CCA5w/pGKEfJ7VE0+xIDU6Fn5gg4ATY+L6W9BSsy6nwZWp3OXkTWOEOoHTxC50NTh8kbsfXEK3vkyffEpGx5KDboGEIntCohI6f82kw/9CgbGoF2BDEog2imGXe4NlOLJKEYenKfInZK2KBBqYGZjBzbp7nMkg4fSV5dgFkOuf4kaJGHXNf3h2kgmmOHWTEoZKh3nYK0N1Gjn9gECI/6ShLcqMuVf+1A5qtBb8YbmNKv6YBBgX1sQ31As70u2BKpBOZ6SaAowBHmn3J1PIoxtJfXU/fcte/cRsvT752SviQFaDeWrI72bJ8eZac4oTco4wI+bR3HUavRJlOb8JYmoQqTm5mTJN/IVD8r2E6fdSxSJqHAixPnEjEEqb6iNWnUaW3eTFscPuNjV+4jzFvtI8/s4is8WVIgpGG90rl8b544655n6NdYW72sdgT52P3i3vM+M3g4l/jBIQ7Pla+1XClOM0PDIbrB4vLx+zd+ALdJ/vj7H4iwIcOvv3JqpPG8asdTV8z6jzd3IjYpmW71qq371LyS4zV1qi0CuAI/n0Qx1e+dGGazrZfYaf
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z9q0pAWXU/5CowRWY7jThL5xzQZHN8RDS7e5zO3s/34kvzPtSupCUbaey3Qc?=
 =?us-ascii?Q?Yv8Y6dJt0bMR6yUlEEuk3V75mLg35/mGD5o2z9xn43EH7vDNHMaEFiNWYE2x?=
 =?us-ascii?Q?55dwI+4bkfhHV/Wcl1b9wTZ5w+Gqo1rFWjPx0hHpZeYTprIhJXCLTxcI2r/4?=
 =?us-ascii?Q?QaJP/dNhYnqai3r8nQzGFwZ7utmQue1bOcJA75t53sb5YCvBpxp4HcfU1O3N?=
 =?us-ascii?Q?xcgj6YGKkFrFbUqOJZ75ZqXMW6XmGzTEbtw1Iaat/P84rjw8iyqIYxSUM4dQ?=
 =?us-ascii?Q?fgGpl6Lu3uSBf/mX31zEJ9rKD+tYDpglO/Q6vlkjB7/6mSukogjRG8vD1vLV?=
 =?us-ascii?Q?ZVfknFrPoIUEhk5Wpdvn2A6RdfFbUQmwnh/wWMoMb95EEpepBYl1Enkm0K81?=
 =?us-ascii?Q?wDkZvY7EqeFhdwdm3uLS9v7/GRpT9oNeE1TLLPBFCvL4aQ5kkBrQ6qBRLxjK?=
 =?us-ascii?Q?kFphm01XMrvc3Mjh6h6JZEx9383U9g5UtUOmXWy7XTzup4RxjgPpORrZKCmN?=
 =?us-ascii?Q?bGjGtzDFRtUInydN34d60m8a5oCDJE1T+AJKFlqXAS1HrEs2wSr4CSo4oYUY?=
 =?us-ascii?Q?DahUfsCsCvmq7X7gk6N+K34FyGag6cn4hX44ixk6348FuXSm9dQU5V8q4seO?=
 =?us-ascii?Q?womfL+uYLRBn2cfQm8fh/ITy3y0klMy/t7taer/401amog3xL6VsD8XkhlPV?=
 =?us-ascii?Q?RCIIfvCIzKey5wHLaVDhiX0fcH75hjNyHiZOQoeIJCcfrX8t2Gd96xREAkWQ?=
 =?us-ascii?Q?HZVNjJVa+zDP8rygLVy3Azklw8Ggyf9S2yZm4tACT2TW7+u1EAVfFsyWJMgE?=
 =?us-ascii?Q?/BwdfyMuRSX22iZycXNAQIoKZV4kCI+jEyNg29E8tsRtFarqbLet4jyRfZYK?=
 =?us-ascii?Q?6TspzJZ49obzvCki85O5PZ9YOeHuJznCgTB7Q2pXhZ+l07wAOSKpxn9/6lEh?=
 =?us-ascii?Q?GP01bshkknIUncByigW/G9I+Cs1OMF1Mk6URhWocBH0q8ABboV/hscHKTjX6?=
 =?us-ascii?Q?NoMYmLs/eSIt7EEgwNkCw61wCjDU2P1qu4nYwkNsC1N5ZvEGzP9tBjvqBGIJ?=
 =?us-ascii?Q?n46opivbd2wxl00dB3JLOeCbDrcDX1PIid9DuqNHKfLEqs50kJEH3cYMSI2d?=
 =?us-ascii?Q?e4+gzCw046VFYvP+iql98XJp9mllhdpHs2hPzYUdkKqO+vL3WS/CmmQddbgM?=
 =?us-ascii?Q?ke0/F4Se50iCivfVe+WSy/VP9Equt9hwk00tml4SozbCwEByN2QqtK6T68A?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b717d0a2-e21e-4185-408d-08dbdd7bbe17
X-MS-Exchange-CrossTenant-AuthSource: DS7PR07MB7621.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 21:19:35.1839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR07MB8973
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables the SPI-connected CSC35L41 audio amplifier for this
laptop model.

As of BIOS version 303 it's still necessary to
modify the ACPI table to add the related _DSD properties:
https://github.com/alex-spataru/asus_zenbook_ux7602zm_sound/

Signed-off-by: Alex Spataru <alex_spataru@outlook.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 58006c8bcfb9..415d3832952b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9929,6 +9929,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
 	SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
-- 
2.41.0

