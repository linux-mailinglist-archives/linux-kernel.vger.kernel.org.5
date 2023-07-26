Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD4876382F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjGZN4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjGZN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:56:39 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2039.outbound.protection.outlook.com [40.92.98.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D042697;
        Wed, 26 Jul 2023 06:55:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofTNULpIWhGlvJ3bpKR3nc+KISkiGSC+9qYz1ZQiUwkmkYB9UH2Bz/vEBS0gOub6Q+oLmsvlt0JlytyCoH6U8+M/mrfrYdQKr+5UzIx3dfltUhRabBMgNe2HhU3vSha+WV8Lz4s/iiBNSvtRw9YPDMOybVjtbHk1WbNI0D6mTGl3ta5ag0YX+ee6kg3r0UJIqNx1npURWhkwJ87WK9zGOcQue+XnblyN6BNJSOBnTMsd1GInMp0YVA9KdBxsCRIt95xinQRKLnQ7+xoV+Cve0gfUTHlTmJoSs1HqasBydHBlVBVA/EsW8Os06Bu7p+Yu1UmDmkrqexztNSSQZ+Y09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cQxaTz7g73oz6xbuuUqbQehs/F3w6onjtnuM/ot98Q=;
 b=Cdmlmmttniavquykn6gE0kQTEeXeBmTIwPyIqjsLVa9JGLrJHCrhUFbm5kM2xN3SLhK5wGIYEmShYgvyh6tN5h9DJYBswefsPwO+SMT2Ru6hpnKiPdqL/0m5dm0geRLzYyQJfKJwlmBbYePpXxOw3cWsDOxqBBdsvizRZItpgIN0TMTc5FO0+yec7uj1JMx9sDMlCH+6vefMvaPHYwvyKj6xCaY61WR++/v6tBD8ZnGcIlK5Xr2OsfmwIEPkEwxIrH+cNSmPPp4NN6EsTMAoYJEjrmcthpt3PclngfXHH3T6/fcOUxXhwa/SCWz+CWvozNKIBzqRj9b9EAspthCeSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cQxaTz7g73oz6xbuuUqbQehs/F3w6onjtnuM/ot98Q=;
 b=n4tY015RC0wf1+nw7BXM8pwfYC4hTnhk6xOlEKz1FAvmv1bHVaWvA9b53iAEJwMEe1pAEL2kyNfp0OTEcURhbXCRxPUpr1bIKywR9W/3jUMTir2w+BCiZng1zncnNU89Z89vhHh35Jc7DIBKahjjnftOYkTEkUHaI5S99mzhdQLXmt5F4TvlmModRHlmi1bnKEiTQSrUKOo7RDBolmUNCsrkrFyWl/99Ic4loiEDdbf8CLSzh0PfcA0BfyK9PqvbwXli/3V5zdqZcRkYDyNyMtubCKatEsvYblo35PlTQvRQDOZHLW250X1eitQ2yelu72kzRRBcKILp9H9GmNSnwg==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYCP286MB3724.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 13:55:43 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f4c2:4b38:d074:f1e9]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f4c2:4b38:d074:f1e9%5]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 13:55:43 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     daniel@makrotopia.org
Cc:     angelogioacchino.delregno@collabora.com, ansuelsmth@gmail.com,
        john@phrozen.org, kvalo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
        lorenzo@kernel.org, matthias.bgg@gmail.com, nbd@nbd.name,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        shayne.chen@mediatek.com, Shiji Yang <yangshiji66@outlook.com>
Subject: Re: [PATCH] wifi: mt76: support per-band MAC addresses from OF child nodes
Date:   Wed, 26 Jul 2023 21:53:07 +0800
Message-ID: <TYAP286MB03153BE5014AA32BE048B8B7BC00A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZK9mXE00xEHZV4fi@makrotopia.org>
References: <ZK9mXE00xEHZV4fi@makrotopia.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [VZOMPsTcg2+hanBfxJnwfWTavMFmQcSt]
X-ClientProxiedBy: TYCP286CA0028.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::15) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230726135306.392-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYCP286MB3724:EE_
X-MS-Office365-Filtering-Correlation-Id: 9721e24b-70dd-4803-5c86-08db8de000cb
X-MS-Exchange-SLBlob-MailProps: q6Zzr5Fg03EX4MSurZUzZTQFeLZtFhLusQUcZIfjBDe90lTD8R50MthGcPaV5dqFU35tXsWqHVlwVTM0ANrwM6Iqbdmi45YmrInAP6yicjjdYLEVXC69sKhBuLA3yi3RQQ5i8D7VtbZmW6+VJp12oUFbRgK7sskzYyAsk7oQbqwkV+RJQ0BKnHRWEO96Xdtw+1Bep9XfE1zjfecdLfDqAfpbxvHPBk3UIOQwJg+y879QM8DeW/t//JAUeeh/cHpLm+NJbg852U83FqwVCYqhmzOG8Kcn98fjEvt5ye/mTDUoKgpJ60YyNAKKv9PLazNfsQ9ETvB6zqw1gYI4l5yauPSL9o1Kzp6goDVhc1lL36cQ2OW7uhhDmj5Dw1H5tfif9pAytlM9ewYjFGqIvyATox7TDrkDp7M8MFeH4arRkNKA7ab0bVBS7ZUb2xxIFRu4tavSo1rFcavEUGCZ5XBaK/QeK4matE59LJv/uInqEGM5Fu3z5tm4FKBeFp6SYJUyEDywDTWh41WWvgYxZxYe9fBNmB+HVpQXHzXy2Xyad4freQufpuwEZca95xtvPLFbpN8C2eKQJmBs5scyYuA6ncLdOgyUi6mC2RCAkwfyvIrRbJlnIMd2K9wqaBi4zY8eqC4uKx6AgliXoX+/i5TpUkOMnqEvEsHjf6mEpro9fa+0pQdpIWD/+FgXmzUz5N9k
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3OqgMTSItSS7x5NUqolOgRYHAD1sSglvYUQsF+ge6yv/H55fh+Ly26h2/Fpp8mfRAYwa/L2JPCh2D3M5uTNfb8CJLE2SPIxr1Loc7ZvpJk8YasSTb3YezoBLOA34GU0DmMFec0AgLfmGca1H28v2bnmJro1OIhGHIQM37HWhktt1BvMTxqSUMbYF5k2rlWDNUpIosjC8zE8xOztyqp3TKprYcStMYyH+20DmQTd5Moe7LwJ0DlwijZpSyGKQ6hSXYtwrV+UrPzRRaPnA3Zra6UJzHaBwJrRt69DATsH5Pz9pKOZZzwmKQTaqt4JWfxoJZAzTeolwqgpiOfOkGhOY2rr66968kKhlEcDhUu6hB/KbVuWcn8NfjRY6rJvwJBr9ctP/lc3t9oNv2kOVjbqV/Y9+CLEXEjkE7X+y5qtFWZ6gt7SJZEnjnI2VCSF7YvdgBrNWhgABM803BmhnKBIIhIJcatM8ec4EEkP7cqGrQh+GA3trmfqvk5SBUgOBEnCEJvK9P+oINGy3uQY4N09k0OYkG1dZtuJFKRlwMUHufw5ZIwTTc0df+fVxxXKvj1Ue1DYlEiArb98UixrlMDLSStV5lYxq1sbtnHNH2m4UXYuw/3PgiwfwKnFLCpetoPMy
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zL8ygI1k0WnqLDyuLj0WMwBGTjDJZuLTUVPT1IiR9lFql0sjac5FwNBBGBof?=
 =?us-ascii?Q?h8L47wALCtUaTmDc37eoR4uwVUYg7lB05UGzfHL3K6uD/SivHxqke+5Ey14s?=
 =?us-ascii?Q?jIk+LRO7HFr84FycByq7iJQbw9njqIgEo7fi+fAdZ9WPdq7l2UqZeeWQVj0q?=
 =?us-ascii?Q?fY/oJmf4PA//efF4otkp9ixa2RjL0BiOxz638TeErtxBOOWYvp6ZPWpie1FZ?=
 =?us-ascii?Q?uBcG1jue2YjuU2gZgfLfEYryzGGDOKGEAI9A+V1VbyOQy08tUCfvDzvhmN3R?=
 =?us-ascii?Q?+oAniqjTZ25jj1EbuDf3xIlpSwLwsAyWeToZePcocq5XQIe/FXv+l6c6XJ2R?=
 =?us-ascii?Q?XSCclU/mtva3G3YdTkHlH7rv9U6sbvLocSmW7Wl0V73oC5Uz3ZzfgGk6IvPt?=
 =?us-ascii?Q?SGlIMEWCZByKNVH9EuwKOw9n7DzRm6iT0JRIUfK1vECLkDRK1jxCIKM4/zDN?=
 =?us-ascii?Q?bbhAFJfY4CODk1WtBxFiIAp/tLPT23bXigcH1dqt8O1DRL986pFOP5SP+X8g?=
 =?us-ascii?Q?yUGvTGHJcUhDajm70XQqVj8erZAONe0AzkWsLX5mUPT4ecAn/4Dc6hgp/zPZ?=
 =?us-ascii?Q?ABX/g+r7HnpSW0sqtbA4k0s2PfhTHpYM77ctHgLGCaZB+5SPQU1b6oXxIy4U?=
 =?us-ascii?Q?d5rNQAfwZwwN1kxMo6jtYLBo7sZABz5MdLJNezCXUdVhnhsA9LRteoXRtjcn?=
 =?us-ascii?Q?+bshkd7f6n6sW0xisiIDiSNNRYcNhvzMtvNPID06LZGC7gE5ljQ8kuTncbJH?=
 =?us-ascii?Q?+v249ni9fM6RQY9jSPd+zNK+iMzRA3EmOVBQ6CFD57UC7iTzbxS7e0DkBDC/?=
 =?us-ascii?Q?O1abUkM6rztolAOKsoRj43dkVq5eA0yCyWlVA2xTO0ynlmeAeKQafkbpOMQk?=
 =?us-ascii?Q?1EhjxZ0K0ppI2DhUQaXmXQqnG+cpBhcng7UvqfAaQSu8TW2/llNg9bByPTYY?=
 =?us-ascii?Q?cfGnZ5LJjhBZuw4KKAV3/4iwhSNhYYP6KNm4TZo14qfHqsBT+3lYFt5a7ukj?=
 =?us-ascii?Q?aV7RWZ0VNGcQ56CBwbnkTJUL3m3alLdp8QT4OP6N1kgRFxqC79wrq/AtoSf6?=
 =?us-ascii?Q?9/hkfDVbVAbnoGXZq80KROn7ZA73YoBUuuqLDdThCh4EJf1hayWy+M5wL0ut?=
 =?us-ascii?Q?SELn0ML2FKFKpgM+tO733WG4X1JwluP0oEBmjt9tgnfrX4Eva32odlGWaKf4?=
 =?us-ascii?Q?CV49+/WW75vEpvCKSpJVjXvwvdlyBUYPnf/iqmWKaw/awy56RBpb3/pY4h8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9721e24b-70dd-4803-5c86-08db8de000cb
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 13:55:43.2650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3724
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.
Works well on MT7615D and MT7915D.

Tested-by: Shiji Yang <yangshiji66@outlook.com>
