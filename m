Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394117E946E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 03:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjKMCWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 21:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKMCWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 21:22:11 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2077.outbound.protection.outlook.com [40.92.15.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE15219A3;
        Sun, 12 Nov 2023 18:22:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SilCnvCQ8et+7ewDOGZJ73dUzNbIhkH8eaNwuXgseZqKqUdkretRccQCR0O0nXT11zEj1DTkjlf/uRuXy6K9ob8KcxUDg2NJEopZqBVcyzgV75gevSlbMuKLJj8VzIrymMH1efeVSRAAB11waNmbVCGkek3MT13MYGo2P7HztbvH7PoWvdsPDvnMOelqEkv8R4lthfOape+h/sAyfAcTTqPP0Qmx2dhcxfyht7PQqkpzvT0ym6FCjZtBdcVX9S9F8LEYM4xTvjPs+ihYubQ58Bc9zVGLAMZA2lgDU2b0AsmO+f1QhO3qAUijh88kyZU5Czw/sq/Z3bouLllQ2Lar0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQMWpymeoTpuaMalh1DVoOuuEFVWgQql0iJzlOGxR4E=;
 b=gjYcst6mdQcQ6fOHV3Oo3nkKCqQpdJW4zvYyxI/Y08DVTwHDchB612+fht0hbm1MDLgcZveLkDzml2y3wWM7O/XEbSyys9xYcs0owB3nApmRCIvLV6LnWMhHr/UEv7PjwEAACl0k9ttDyy+8ARe1rhTElRdYgcFIZF3PmQ0ajb43VWU5+2eHxre7ArZOrvpGHl8uUYlYJQzAzpfrzbF6tQIuMU6gNlVPItdvRhASEdSrRAIuYH9tgJNeVYSCtKdwp7NroS8cPxGjFodPwJmfqoe5SlQN5CpmrjzH9zqXmwWDmDIXJS0uGqVtDFt2d/qlXnJk2347W1hVg/sMdfpe2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQMWpymeoTpuaMalh1DVoOuuEFVWgQql0iJzlOGxR4E=;
 b=g36lSVu1ysTuGf0D4+0ZpAySu0UQAxUnNsI5JXLnKopFNhTkJ8L4IyP6wupY7mleFFGpRwEOW1GvD0VTxk0JvKbV7bDGVYTfFMtn8feTYpalgWfgXXnY6l+uWpVWTh1jYYC0kSsNEImM707gOjJ5C2n05ccmzuk0NHdSiOrt7KxfXlaszqc2XcJeNhoFO4RGrIposvje3R+7L0r5sv8DKsoCHlg6Id7jcTkVinq0xDqbVlQonVSTKhr5mqw8v0tE0BnNq75QndkF7zzfeY0vsdOB8lFFa82jwTk6TYCLH6l1zDwKLk2V5dug77nBAzv/tq3n4rlhUHX1E+TYcnSjcA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ0PR20MB4533.namprd20.prod.outlook.com (2603:10b6:a03:3ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Mon, 13 Nov
 2023 02:22:04 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.6933.029; Mon, 13 Nov 2023
 02:22:04 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 0/2] Change the sg2042 timer layout to fit aclint format
Date:   Mon, 13 Nov 2023 10:22:36 +0800
Message-ID: <IA1PR20MB49538304E99DABF0208C00A0BBB3A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [tD0OtFIvJ4wZ/yk8YKvmWx02inennZONpGrb9so1Lpk=]
X-ClientProxiedBy: TYCP301CA0055.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::6) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231113022236.35992-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ0PR20MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: 01adb556-87f2-4fff-dd09-08dbe3ef5376
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNqHbGWbq+JgB+ukfxv28Z+dAeKNwon5Zu4Cl362zjSfhfbX2ozYhoG/UqeRG3/c2h8tj1p3507sCKPBSomUL9gFBeI+n6GLkDSlXkTLZ9y8LK1ux9abAl33M/53ktC4+mbEkPriPIH+mmDhXn2IxBiP0Bo/+OzNB6nrUQXfRQX0GjNSLSF1wt3tAWNRgjbDPzrCd7AMhKgWFL89x9X4gltyQGYY5Pj6f9gkeBl7SQssQB2hNeGMarfbwdQUHqzeufKy56yJtYAtR97ZsfeJWAqr/7ppEbIW8UkMxSX/LAp97tEU+AoDJCWDErZeP5lGNC7zirD10hUg2QDxT7f7dClxJVfqGumRV0m1Z81iej0UKOKWIqDupa4oPHU60I4cEkKlUn2c5Hbn8thBZdIDvi1dXciooXDg6YqiQTBf9c/XI1GCUhW1R37Ha5bkangQayqKTmAM3Oh+DvSWyLUx16Vox+F1RGcwX+DNwxb5ks88z3pVE0zJIs1yDUNc4p8Dfz2MVbsXbxHmgFH3q44D7XuGg0hqzui6saAy/yrhfk28mYCCiQ+Dv9KmqvVWPyj7dpcXYhSb4cZbOOczfG4brJtmm04uV5rVHu6QZ4hDaIuS+ALtB/fmA+JWvVVxCB/3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X0fXaavE5yyGFZyHWmRzC69Mn6eAPLXDREXs4sP+eBg0wbSAtQwyvwI7FKMV?=
 =?us-ascii?Q?DzisBzNMofkIYTqN21+cvlEa+SIqBcIjx9hjO9i1i6P6pKuAqKkqrs6a1JaU?=
 =?us-ascii?Q?I/cVAoRNBaRSP97capmQA1AKVNY2s0hlSpoqwzdAJXAe3U8GJ3utaDzZwN2D?=
 =?us-ascii?Q?1vWcD5j1slseItP9Fs62yEhwkhUyWS4KdU1EP/JGvmRHaxiK+iE2qQeOE+FZ?=
 =?us-ascii?Q?wkyn0W3tCZkgt3cc7+6/F1fpywOB8m5i7njg5UOgY6ukmWozVDnwIDdSScar?=
 =?us-ascii?Q?qeuxsvWcvHT6fMp5iShw8I6DjxKdtKUTrJYUpYPWUA2EsT7spiH7D6d+Rb02?=
 =?us-ascii?Q?V9waWO9MIm5KEwWGlCC1WkrZXjMTgLZLNfzvYB6bgyElKH5/BvC1hgIgoouv?=
 =?us-ascii?Q?0bvYjDtx1qSAW4ltoRT0WiIkX2NiwREwqzr5yv1NrEDI6eI6sl+avKNdy1kT?=
 =?us-ascii?Q?C6T8bSqiej4WfrrXyOaZ+3KGA565laWmxEm7BBzoH103urynatLWhUlPXETH?=
 =?us-ascii?Q?QF5MzPtP8QTokk73AvaHlKtEEatCoffKXqOGvLQSXAUxLk3h17AejXWCbDGl?=
 =?us-ascii?Q?p5snhu/g+ZTo3k0oqvnjzDY/wJ58jAN1hHeKNUOA/NRSTgdnSECcEQE91/FZ?=
 =?us-ascii?Q?sqbI0emJg7uLxUS6mEXv1a4W2m1nk5/Hr74vkCXPGTT0XzzRKER5nYPCE4oX?=
 =?us-ascii?Q?99lNf/nZWNwI5qWEzTGV5cZvfi/ui9tWYg3cWXBqQ2GL+yyLfsWAEuPdljQF?=
 =?us-ascii?Q?mO1CgFY9bICJ77onYfi4OfBYgYJhWOI4hEs9jbULgrnfSlNoQI6CBeEa3hjB?=
 =?us-ascii?Q?3bt31ik6BUfEmDZHDUjMbLHQzR26fYuUfLyDopJqCG0mYnfH0rkLuFYSIkuO?=
 =?us-ascii?Q?Dc1RmOb66aOd/U8jBFiVy6TeDTwoyiOBNpWb1k3f7tX5iEyJ4cNNynz7uLCP?=
 =?us-ascii?Q?oMAGwsQH/59zfhRRYfJtMJVGDQ4nnbIxJOpR76W92neAUHdwcmk2Q/vHcyW3?=
 =?us-ascii?Q?uHo2e+Dv/IVeoCZMWhlgboyQcVqACdSts4uPfa51fQ6zd9HYHFig3wFurIm0?=
 =?us-ascii?Q?x5UZ89A9i1RfAEfmaam7eaFU4hQRqtMR9B3WOfenggyzrksziljT6nn3475H?=
 =?us-ascii?Q?us4fejXB9n+q8n94b1WtWTw4+LEuCQgG85+x613on+iNKpFGLTKSVc1lFjcy?=
 =?us-ascii?Q?w4iOsmOOyoQjwrmqYidVo0qvm9qjQaDMkdjVMM5Ab2jpoYwYLQA5UdOxcgk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01adb556-87f2-4fff-dd09-08dbe3ef5376
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:22:04.6836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB4533
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the sg2042 uses different address for timer and mswi of its clint
device, it should follow the aclint format. For the previous patchs,
it only use only one address for both mtime and mtimer, this is can
not be parsed by OpenSBI. To resolve this, separate these two registers
in the dtb.

Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005693.html
Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005738.html
Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc

Inochi Amaoto (2):
  dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and
    mtimecmp regs
  riscv: dts: sophgo: separate sg2042 mtime and mtimecmp to fit aclint
    format

 .../timer/thead,c900-aclint-mtimer.yaml       |  5 +-
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 80 +++++++++++--------
 2 files changed, 51 insertions(+), 34 deletions(-)

--
2.42.1

