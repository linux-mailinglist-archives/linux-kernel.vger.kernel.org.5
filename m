Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74C678A1C8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 23:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjH0VOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 17:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjH0VOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 17:14:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2105.outbound.protection.outlook.com [40.92.21.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE678B9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 14:14:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2fBxNrqxdIeBvOR+UpnrJF8nPN03nW/6cP5t6L7478cJ48VOTC/hXPHgQ6wmtpygY8Dawp7S12W3a1YDhYORzEnAC764jXewyt0Dm4Gpji6XcPyjQJc4sgdxIHA/T34yuv3ECrsX5kaJXZZbig1iFCtFH7WfDu22BvgWL1nJNiTgJ9e+X7nl6JyjDlF0Kzd1dS4ljv1kOWS3gJ7gD6o7qpreZGPeFb/ay0s8ep/yxVZjN0ngH6Mm1jlFgvty8sjQ88z/By0mB8R03/3RROMfVZbV2aae+uF0cju/WKJlzoDRJSMTY5hZ2+qqwACeDqqtNJVZP7qhWFZe+m2y1jtDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiyhI/ksJO1VmSbN01GFsg1ppIzukebEnwSabK6X+uU=;
 b=dpwsHycdP96+9yEZp37jPTC+P2fsKKyvqdwoTnwQMPJkzZbsAazjez5LAta+GkXY1YtQ3I56k9lqEB/d5rPrk9xTckSxEhke+Od/4qK+ITN3ChM50wI1uK8ruQy9FgyzVu1VBL9sNrpFObisAc058baZr3duzDmzjeq2qo5p7tZAVVCX2a7nqUtMw3atzhrX+S3QEwyWG9/QW12XDRCr849pfab7T3Az9J8cIX7zv+npIbE4FU/iCwU/vkb6Sn8tQaUjb2EPiuc7Ow+4QyobvW2QYTINUcEb6hawdlKVPr7XNkqIg3PVDs3rjY0UuRZlcoQ/OnCmEgIorhcQt98O6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiyhI/ksJO1VmSbN01GFsg1ppIzukebEnwSabK6X+uU=;
 b=fzNtW2/J19QyIoiaSzq3+pDO46d6TtdDp2O/WNvzCsmIZhBI9Lx7cP/C2nPgKHD+05Me9LTdZLyXL1gQBmo74j027LcxH7gGw3OUocktjgwtKekVfnthje51EX3uqi+7drcrb9Fve/balZOQU5HH30AYIaf/g59I3KlFcUoj+OdU+H/1FAu88U/1riGDGcWWDR48DAXsvxPu2dDtzh6Em8YLip3fU76IerFP9s67NbHOrI24WfZaUkA6B/bjkk8Yl4gWBtEC0/LIkrbTTEpn3VP4ygSCodt1rj0jIUn5aPrT3/N7BN917iRO7YxNgd6Lxhyiq16wFVciWAF8V+03+w==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by CY5PR11MB6115.namprd11.prod.outlook.com (2603:10b6:930:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 21:14:27 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 21:14:27 +0000
Date:   Sun, 27 Aug 2023 17:14:25 -0400
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 5/6] staging: octeon: clean up the octeon ethernet driver
Message-ID: <PH7PR11MB764383A618A0A6CC0CB51C37BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [JfPbzLps5zn8q5rxwhDZ8DFXIgi3/cw5g4KY3Ucgyrr86C9uGXMquaqgvXl/1RTL]
X-ClientProxiedBy: BL0PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:207:3c::47) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <2p3cr6zwjkoair36cy262jfau7olp7vhosizzfwleu4nflpbxa@xqcqhcwmfpq3>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|CY5PR11MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 761ab778-6ac7-409c-a7d4-08dba74298a0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E64OMxR5EgWAmENSGNotRRW2Qbi01x+PrQaahwuC9wdc4dUIXRf1QS9hknQksYQrnxATeyZipmoF+EcnxeT9eMyKdBzqaZH1GgQVyHhaHM7//vus/onH8UDV2h0snCnW8oJPxGewHthRJmnfQUE6KRiQtFZExgHVozgmlEXmN+otikPk5pqhG7m6l5kSxruPtB7h28ZfVGnSwZXvXdawLzBcemrRZgAd7yPnH9DVJGTtv3yUWvr2xvk9Pu2+fNKyTa0Dqxh75kvcaj/p3RiKpLObHEKR/SapAvJ7wUWsOnlPRfOZuJsulikkNyZWw10z8iG26GMiZPQ9RANfLEtE5eQ4AGaP6m5b9bs9wb6XG26Kfx9QYJ9YbdhaXPi9TZtYFVbumxSGHxDsFcI6anFo+8+/ItfyG0EU15poP3fikOuFyTi4m9a5A98exLGVHndg5jciRfBN6sQ72MZHkMQY6vmE6pxWqePGTZFwz5lf3UOPi5GKVQtu4NKKhpJQ/Q/r8aWKZTa033CjcB2h4Y8LMqqgeNnd/aItIqOhdXAViubg1AdGe+Ykd2+pcf8aanV0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dYO1ncpMyYuy4KlcAy8KHewQeqmOE3Vg4be6m+UyuMDqxqZlDIBZx4IhInLS?=
 =?us-ascii?Q?5/InMxZavIAnzkXvb5JOzUSZmG9bz2/MFIzE0JZvUGhTNr4bCnAHVHieRlRM?=
 =?us-ascii?Q?1UJtmEEdRWV09f8hmMiZmLzI/88ZjXGizj1JDdB4Ah4h/YZ2dERsrhDtiDeH?=
 =?us-ascii?Q?DxGG+rrKXHtRu9fsaZ4bqmY25aRl2JRn0f96P8pmYumf5FVY1ojE72LqCxP0?=
 =?us-ascii?Q?tbeCSg2wwINX8vD0P1SBbwXP2atTLYPTGwO7QyrOZI+aW2qoSj0aD/fdchL5?=
 =?us-ascii?Q?pnSL2DpUFcvIMVDY96VmNyheHqNtiusSvA9rUjTpPoVDpFHm2SzPgxff/jxv?=
 =?us-ascii?Q?Qt1NqR87vPNYcg0KsbK6iwZzN8Fm0JES63kjll5T85gTXTxNdzN/0i3NG+x3?=
 =?us-ascii?Q?K2TYbgq11oOj1d31cTEspoDJC/bJYq4DoLU/ucMY9K2r0l4lCWfYzOLErxhy?=
 =?us-ascii?Q?eGM7Lt6PjGHgaRBrs2eAaHiMppg3SBL4wZQHjun+/AhrkpSNAHNmB5UCz1du?=
 =?us-ascii?Q?Gp1Az5WCX1kZZed7SFIqWDnSO+WoUC7B4TDFPRLCeQXH9iCK8gUrbvdG59lw?=
 =?us-ascii?Q?9hvAs5y22TPfocZaCk+Q05DjMFn7JvMgmaj4plK0zZtYuNAycgu2HwMf1wmr?=
 =?us-ascii?Q?DTytRgAjTj1APEfVGHSDl5Pk0WcrD1D5tIJyYGE31ca25zF46CYS8NXdCo3R?=
 =?us-ascii?Q?AMk0Su6G2ZsCXoTvycvU/gY4hh5jvDW0MbdpA9DgB58eC6KanbA2+QTVsQN6?=
 =?us-ascii?Q?c2s6i4YHLa1ml6C9+huJRY7aUx28e42Ifu1p8b03HddTZK1Y9LfaTSLs/Jh8?=
 =?us-ascii?Q?vtvmQNo+muQUVssC51BR+dALDpTyhZIKgqq7ZuDg9pfQ4teyzc9oq0zeTbVm?=
 =?us-ascii?Q?qyN80+b+Xv+cW32PuuJIkwScclc/2KEx0oJLhsZTasI5iIP73LNIy0sqBHRK?=
 =?us-ascii?Q?/tkvdhANBHpWQimJ3P8LrUn0l6ZPQgBOHNr+l1Y2sAMizdnaWZtc6Vfy+BpF?=
 =?us-ascii?Q?uy06nc0HcFqIF8e2NDvSla66r9o3Ojq14LNXBLYpT5qhbDgRnhu2x7c+uMa+?=
 =?us-ascii?Q?SH9G/W0JKto8KQMrbtrObCb/MKsu538UlC1akel3Ph0EtvK84jUaT8ik7iz/?=
 =?us-ascii?Q?4YjoiE19QoeS4MBuv1IBM08cCJhM/gT4wm6qKlufD7VC4eckFGzFwMN3K1DH?=
 =?us-ascii?Q?GBNV42l4fNGTcJtaxtPmf+5kDiygGhifD5x9yoqFXU9NUZ/MOacRfzwu7kKZ?=
 =?us-ascii?Q?JflRU6o6qL8rMBI9hmlfl6mQPEczpoXO2AStaX3jyg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 761ab778-6ac7-409c-a7d4-08dba74298a0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 21:14:27.6905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the octeon ethernet driver better adhere to the
kernel coding standard

Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
---
 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 2cdbcbd8a97b..b9852994882b 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -244,7 +244,7 @@ enum cvmx_pko_lock {
 	CVMX_PKO_LOCK_CMD_QUEUE = 2,
 };
 
-typedef enum {
+enum cvmx_pko_status {
 	CVMX_PKO_SUCCESS,
 	CVMX_PKO_INVALID_PORT,
 	CVMX_PKO_INVALID_QUEUE,
@@ -252,7 +252,7 @@ typedef enum {
 	CVMX_PKO_NO_MEMORY,
 	CVMX_PKO_PORT_ALREADY_SETUP,
 	CVMX_PKO_CMD_QUEUE_INIT_ERROR
-} cvmx_pko_status_t;
+};
 
 enum cvmx_pow_tag_type {
 	CVMX_POW_TAG_TYPE_ORDERED   = 0L,
@@ -1384,7 +1384,7 @@ static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
 						enum cvmx_pko_lock use_locking)
 { }
 
-static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
+static inline enum cvmx_pko_status cvmx_pko_send_packet_finish(uint64_t port,
 		uint64_t queue, union cvmx_pko_command_word0 pko_command,
 		union cvmx_buf_ptr packet, enum cvmx_pko_lock use_locking)
 {
-- 
2.39.3

