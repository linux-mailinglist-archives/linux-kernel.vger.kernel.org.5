Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851E478B4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjH1Pko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjH1Pka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:40:30 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2084.outbound.protection.outlook.com [40.92.19.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8823699
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:40:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJ3uTCw6KkUTkM+4WzvLyLFP1LEv3aE/XNPde1FMX/mFrPMAHlShLeATM/a6CVNB1wAsXmarEvf6Jq3kf4KjqYhdsTem9NvJk+CyQM5rGJQC5mHe9Fs1UvadUgRp7JUk8A8ON0x7jaAinbu+O2k3uz6V6P9hOCNPW7CsqUyc94rh97zUKiZmPDrQ2X74jXL1RTFw1muXSdbnTzSs9TccoVraQXFVnD8brziEG/pmVRKv6doxnAI428SBXC+POnLM/BsP/DqG9YqkonvfBsPEYlOGJktAkP1NNKgOP0w8rx6XY4r5CivPoHaOzZUrBISvJ0az4KFcesGYIb1fSXi6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioNbeEC6J0kDqQp2J9wH34rR299CMTj3Sl+zQiiCSAY=;
 b=kKZy2O7yIoMXMFcErxQ5H6hNNZGKgEonX1J17bXkgmKl+lrAycf8c9Ic5pWpMAoGx+BODQoxcax2TmX/j9j8xceQoK/j5rf3Pl+6Cj1xecDGzmHDokniZQ+iao3qk7dcRUg/43opks0iOWVr8TNqkeTEoT7AE6sZiKIr3RzCaZ+KJ4jY2sWEAgvC592VA1fs8o0KjexmNF537MJb9y3TGFIxl5ZphMCt1a+DmRFp+3qTI8nnqNHnw1q9lRBMm1OIzVWQ/PxY2Omr88PjYF7qtF07iqLk53/RZ+8lEa30VhBBrq31S22E4ql/DAbi8s6xJ2va95cbPmkNNDcKcUihMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioNbeEC6J0kDqQp2J9wH34rR299CMTj3Sl+zQiiCSAY=;
 b=r7LLfvQYtPSsqj2iGijns6yFVS7RZbtUYw9XrGwin0durW8E4mcucH+xsuiU79nRNOZz0iBQfZ3oYQlCmDj1BDVHtxAYApE93fvZAcyCc/U4eRayB1KjqTMAO8NFhfEF6lLRnvrRcucFWuDuvwZ0YII/PbDcQbe3EKXO+Xy1iqIOvuOf0d3V9hIoWG6n6AuXc07o/l4KB3CLsi0BZh7c0WNVzQXRsrTY59ufgEur+f79vdca71zNrUOcMoEZcef3HYdn5aw7XRvIxhwzp4UeuOQfFnFZ9CQg4/NCtlefvbvFwSuMNT16taZhajR/rXcYNCZofNFVpMBtXWXi/K0mTA==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 15:40:25 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 15:40:25 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v5 0/6] remove typedefs in octeon ethernet driver
Date:   Mon, 28 Aug 2023 11:39:05 -0400
Message-ID: <PH7PR11MB76438CCE5AB981A59423A942BCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [eUaDLuneDa0uLU2GqCsHzAT93/hHIRVYvq8ssOY043XKbIwVTLKTRmAYtsR+k8lB]
X-ClientProxiedBy: MN2PR19CA0017.namprd19.prod.outlook.com
 (2603:10b6:208:178::30) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <cover.1693236450.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|MN0PR11MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7692da-82b2-40da-c69b-08dba7dd18e0
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmr1VCrDDYJl/lCLgD1Tr5zrqkcZZirfezANu0sAO8v+bs38oJdSAsv90hDzG0L1rKiXNNqEfCh3y2l0jqr8HhfBJ1nulAp+6GLICwbe78gNzZSFVq4LdZmidrzE0xKHC9ktrzGp6tLM8VfxqinqZJOm/zfSTfe9lL43qb471jm6ipg69cjl+xeMg15VR+TqzH21C4o0emkvRCDMx4W9ednkyHA0QJ36FUk7ssKy+q/s28uttkfkBOjwcTLq5gMxg1NWejS4EELfE5qF0Syh/olGm2dTmqavOod6cnuweABB+w4H3IuKcMtp9fzrT6+8JCigCchz4uFjdNB8WB7TNDYv1gNTdmdyl/52bHveO1kqhxVjs0oBV4GKHLEKfZalJMOZmiC02Io0jy2Mn5jUySxvgWMFzkwJ/U+OkJCTHte2ZIr6xOa53J19bSMJgjhL6FT8eGTmSp2uA7xdClUxqJNEUpuRD2foNcu4SZIKPDdTtS/AmtIG9hTI1QEe8ESuRATouk59az7HgrgmMHRxXbc/u8CW7ukHeRx8PWwAeYkgglFCxb6gVesShNhd1XBhile9ho4fanXU2Vo1336MoudGRT4Sgy4a1q4rPBhk532T8DioWpBeNaxZOlMb5l54RGQkAwy2XvZVpWbZJNFeF9OookXchU/b8mMkbuIu3LzyC9zRPNv1/HV7pD16JzRNH0RbxvSqXGQsX1xEltt3B380p6nfMicT2Z52OSd96Kq3srYXS36H63xOyjnVBlZVaOs=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1c4op/0jix5X9V3EP8ZiEEjp8cbXeKm2wQWlHxytK/7TDru7sNVWqq+1M1KO+9t27obOvDUYbdI9AnsAwG1kNhAOevhH+L61J679Bb98PocvCcCP+z1LM2GZ5IBMIdq1PQrBUIwLR0W8FMgByGUrq1CkAQqZfCWMqMphc6jPWJ6Hwz9ZUnfFl5LiRewbyUuklsnAzYcmOdIbWl3ElB76EuyscStMBwxDYSEGpuEwHu+UdB57BNipRihkCyzTI011i/vSyJYJo5U5egrDBqdEKhpxK9+2SADX+PQA1kiLdfaNR2oiEHnN/g+La+4hJ1t95Rg1pEF7HVqMzYZDMRn6tkbcfjYVvWuEbKXEFBk0A/olQg7mBzq0PObUWB2BrEFGMGu/StgS7sJeTsiuTE3sN2D+Qjfpeos7NNHcjKwa4UNDV/TSEDM38rlfAwvK+8O9hcZ+5yIWMZnIcRqpGHYNE560DDRibTCgZnT3UNAHVOrO3yiI+7cCyn4ShUp11CT34Lgq8Wc5Z8fEFyPh6ilwcYVbC2TtclGPM74/K+LnoxMgkd+teTC9+MaFaecLr35K7IwwHhF1tXhIri9qNcEHvwFImNMGQadaYqbdgvDuYnyrtxg1hbXiyhISUDfY7xIE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Un8ayeRBtMqPnW9MdAQV0m8gSsckvg56+G92fp6k5GDdaU6S7QErv999XQdB?=
 =?us-ascii?Q?Cnboxr6DQchT7Fm+2wmH4yL5t5B1iU0tRCy3rKzQRVnT1LvMR4pFfwB5/LFW?=
 =?us-ascii?Q?FcAFQGRTgjSoQcO9O3suaz5wM6HcZo2hfGAUsBWxUl4AvbwjypqwmItSgLmB?=
 =?us-ascii?Q?OLfJzI9EON5DXQOaAAl+nKxOHddEv6o7mXkkjiRO1sFe5ZtZ8zkBpW37C8le?=
 =?us-ascii?Q?/W43/nFHNfv9RrSuc0anEJqk5u1k0vDuI4gHCOCP4DYMcpnb8RX1NPSt9SiX?=
 =?us-ascii?Q?xDwg+g2Yl3SNBvTK8K/jYwvORzXsZB09R4yaaZKYjp1GxeJAVr2CT70uTHJ6?=
 =?us-ascii?Q?/PHbXVoVYksS8bO9+ZSlxw4jAiC4lZNmC+A1xUEJjyNL1PL4bxSJjYL+p+IY?=
 =?us-ascii?Q?gogGaCMcyMY+B/4fkTGKAJsscJM6ZC8B/z6PT5I1HCPgumTohyIYfxaeWX1L?=
 =?us-ascii?Q?ng0GD0o55TOdgZF5qgypowcQ8SKbMAMTzCKofV/dm0OSjVL0qeBlV7bOIgrQ?=
 =?us-ascii?Q?YM2FKluaZW+Q0uVqLrTiIC9GhrVQYHjicl/3xNeXewPGFVxMHx30RPWn0Lvl?=
 =?us-ascii?Q?LtjLfcdBUJ/wYd4HjH41FFCEgo0Lmhz5rSAA5VGSfyjxY+DIjKHL+pC2WWnV?=
 =?us-ascii?Q?n1yqbFKpmqjJ5Zq5J/HzV+f3PLWgnbkRtvuDcHEzvnLDFt0Xy/5Z1OwD4VIx?=
 =?us-ascii?Q?ooqkJ8GBCtLkRXsjtXUQD/yZBCasYeekVVBQPfQu6O2CNyn1YJoWm886K023?=
 =?us-ascii?Q?VbggFYVL+7aWAIhRxk9khliHI/fOAI2I+c5BnQCtBTMbvJLwtjwvGHaYO+wa?=
 =?us-ascii?Q?r5AqCIoWwdF1SdXIlGoUSWznNR5NhNNUQcxN3eNVowK6s1ODhH/d1BVDbEgY?=
 =?us-ascii?Q?EjFl+EWyz3SfPse7aAhsE8KU9Ogl8Ez2Snxi2DvMMslESkRxIeKKAVPfPvwq?=
 =?us-ascii?Q?jupqRbsPdI1to99QnG5d6Q/AX2qig1gmirKHzSFnUiBdyetupb49qAeBDvHe?=
 =?us-ascii?Q?4z5I/WsN/fIZZE/NADAN7i1+xuyl4Xg+upCiTkc3En2MBnhyiIET4175MgY2?=
 =?us-ascii?Q?apvP6IQKNwjGXJ5Xsx0O1Kvg0sFEXg6P3qWT2EKJozH/ffg2wo3k1VqBfnCY?=
 =?us-ascii?Q?pTA5RVOanT/BGOqr9FUJkJmDxs8dUMBgzw32UNdCjdIBiI3bshRVQtggSU46?=
 =?us-ascii?Q?HGnj/p0je/KaXEdX+imWtOMzNAOnLxS6myqICt076YHMdkZ+/ORC4XJxdUiv?=
 =?us-ascii?Q?+3VtajUBdsISFWfz+fGFpvATVfNBwgY/eJRZeMNZ2Q=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7692da-82b2-40da-c69b-08dba7dd18e0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:40:25.4506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove tyepdefs from the octeon ethernet driver, and rename enums and
structs to omit the _t suffix

Oliver Crumrine (6):
  staging: octeon: remove typedef in enum cvmx_spi_mode_t
  staging: octeon: remove typedef in enum cvmx_helper_interface_mode_t
  staging: octeon: remove typedef in enum cvmx_pow_wait_t
  staging: octeon: remove typedef in struct cvmx_pko_lock_t
  staging: octeon: remove typedef in enum cvmx_pko_status_t
  staging: octeon: remove typedef in structs cvmx_pip_port_status_t and
    cvmx_pko_port_status_t

 drivers/staging/octeon/ethernet.c     |  6 ++--
 drivers/staging/octeon/octeon-stubs.h | 50 +++++++++++++--------------
 2 files changed, 28 insertions(+), 28 deletions(-)

-- 
2.39.3

