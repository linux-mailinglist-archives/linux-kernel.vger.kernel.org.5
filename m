Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EA678A36A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjH0X1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjH0X03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:26:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2046.outbound.protection.outlook.com [40.92.40.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27043128
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:26:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d24w/1+Dy5oQ8gZKwAX5W+H8+u8mnOncqvwImZG1prTMvxESVS4sFO1BDbldyDeOmhJmBRiGo3PExH1Da4ijnpVdmppOCNz4b2KDU08FBmQSrY6H4we7BClVg43lQBb7/WOmLq3RxK8jFfJkEm2ZpXkfy6NtaNXztBVyEhsKcx7K+hWC4+31/nu8yq3FHTpHlTyq+/KLHxyVI1GooUopEYn6TUbBck9U7iqBlfiioGfsWfwR0/Bn4R+tR06dQRQsYvoP+CcZdqC2xtvR0pFm5aO2WlJ4ly4oG6fWNBmXKklXAxQcFitDCdFSsxWI3jn00DcfAfznTcktEeoDTAg2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wfEjuFCbyGejMoiAKBJV2EurwrBmkpPWPsdWHWwpCU=;
 b=gMXaY7AC7ft8TWDzdUbOJBKQUZgtlfoQvN3c140b95Erqz9z6fEb1w10siajz/Ab0b6ZJAYwZetzjbBcz3uhVnL56Kj0aRpOPcWsBR3gk1Zl2ScAyVBAuULwT9QNjwEXkvhK7J7GQKB/4HpAvT8QrYIPEHhG1sRhP7iTOv/tA+7yaQH4nZbsq5wxbBigz7GEkJ+0/kjgssbvxLAMxuxKU2HNnCoPXbgg19/Xz3fT5huXaTL0xC/c8BGHMLhGbqGD4CLikR/p/mt+cc6WkV+K3DFK+qRgdSAlzxR7bwymA5OKrgoNmXUP64Y3y5BukO981t2ysnZQCl90+n6C12/cXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wfEjuFCbyGejMoiAKBJV2EurwrBmkpPWPsdWHWwpCU=;
 b=eMfeebDvTS9xjugGh3M/MbwlNG/7gLlS9S6yPtMzGQ44mhfQBTv1FRU5z6tQ2HWxeTDiuXKYggIPNEcE11QC6i22E2zhj8Y2FJsO2d065Lq1QWB3wTfFQS9jY4UUOXggbVAHl+2bMBcKIAqujIMXXa93f3ia2KBzgaoFfmUvL63pBqZzAmS0ebh3LCKsBLN/latva/BSxRKx4CX6+vbxAbXGoVQ/a57bOLVmZglKTqiKsQQx4q6s5Mrh6FoRLsw+48y5ZW1MQ+zMNIZUAs7hYac242zkwbu6jsPBBbxuO/6rIhJlsmj8V4VeXS6eaORy6KH745ei76N7ItiGF6sJew==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by SN7PR11MB8027.namprd11.prod.outlook.com (2603:10b6:806:2de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 23:26:25 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 23:26:25 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 4/6] staging: octeon: clean up the octeon ethernet driver
Date:   Sun, 27 Aug 2023 19:25:54 -0400
Message-ID: <PH7PR11MB76435B393942EAD87C160EF7BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693177830.git.ozlinux@hotmail.com>
References: <cover.1693177830.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [yUYPZwg3g/oKNrQDyoDFCL4NEfLWJu4z4CiR5BwLf30i8RgJQCbaiqmbwPAenqHk]
X-ClientProxiedBy: MN2PR15CA0052.namprd15.prod.outlook.com
 (2603:10b6:208:237::21) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <e8d86ef1077e497005eb68b26ae998bfd628e140.1693177830.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|SN7PR11MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: f6aeac85-511d-4ad7-6afb-08dba755064d
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrTVQo2E8YhiYZbimk9QHlfee0RmoCxeVIBm7zJV9IEh+pAKGRfSa8C6l+kw/GVVNNnpsr/R9FyADSZ8B1D5lqyqUOiYF/Q/NORk9txrhGGrU93giLx4+ItvumUq2p7UPkFendIjwH43UHgQjk6euD8F/cip/xk+OSce88QvfKumaJwwvweIKnAACzSc3SeFhvAh7wPZqu9kPWVXmEeDSgbdSZ2XSxiOUKnQZVwRpduzp0onuqbPkgWNOo4ZAz+g8VcJYMnfoGLRZp2Edzh2VAzfRnMAukSx+U8hWAkCtImmDCrwKkk3TDVxuZPicFTD2v0NW/6N+eF/6sg40FyB/HC61z4lKcxLDOEpXMDuIOW00cgDVVOB5JSZFl3Dr1BgVOZktMjmHI68wNS//N1RJx0eCHpYRmUGYyfBw8vk7rAi2IPcZTgJicmrM7PojO+92YBje2WjdqMB7KwuiWvgWBiuYLY9L4IwNdvyTV+uQkJoN6F5Jo+I61nI0yPHZm7MR2AQ3bDgrICykD7iw3dBBOm100bw1eXLV8/+IgdL56yQhvjtP49yw3nIZelI+wSR/WNdEdJti/x7gSGaDm2HXxwItb54BvJnfVfy4Tkenp8DzruuYoO7oto6KvfsvacFpl6wXFbh7pmtXI/3aqYM6vvtAy/gTQmYae4kzxmwhLKCjv3MKSSXGuDhObIpP+5mBc2KWLC7cTAxvFw0ST25iAkzCDH+rlDFWdrV83TQgW1oqM+6cmMUoaDChPMSJJ47QU=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPVyHCOYV7T8ndqY4C9Qjwh6R6oXCeva4T5aZ8aGyI1eN1grofdWfpHyfBQJUIXSAUqgqhjU/f2DltZOsc084F9EapSb+IrzKZK/kDOGHhH4qNzxF6Yq6GE7H7TCoGvP9QfgTDKXm2ODHhNQA03qGryWr0fMqm2/WVG7cR2fMUo9byzus/ud2St1sqMTaeBc32/bk6pKu5e9bP461q07+B2JbYSOE5UQ/lBgnBCsmb48//6HZ+F+7ntQwqmEA1ZoF89qlkjnYUzWNmDZSpR6V8DMXxI+IhalrRpwK0/I09rsCicf0W5KMaofL4TN8FH6+E8tIKj0Ag7V2JEjl8IIbDRzfyG6qVKNEJkFy6+aEUlfhfnZCWgV7OJVPTv/b117CiMQ9iiBGBzcBmhi4Ar7AoHTwdO4bnP5mvC+Z9jEPDJ1RqMhG0vWqCQQkd/kisKoJpWSOhN+3VHTeMCqH4MWGO0wM58P6rE3OR+sPJqlGyoGSBc2feSGzvGvdslq6CF+JJA6p1kUQgm0/iio9orQWWiRKgWUDvd6LjIRfqinQ1IZ+4GADT7ph0k3wfcmNNrh+EKA+cuUP7o/Jpssma9lRpuYHuRR9MNijT676Jbi/uXQ78OV+SXMc4f5Y6jHsHx8
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b3tdHMXDxmU7JibN9S5ABLY1zB7WJ5tqt6/5GFqbxfB1GgMKoScgJFMdPMzH?=
 =?us-ascii?Q?V5hNNU0ZC+nnlqOzYwCQtqgEa1Bk7FN+kD6nS0MyKhn5RKJjPsxX02Ue3WQb?=
 =?us-ascii?Q?JGeTr/08QujBwPjA+EjSculNw3zPeAg1Xr6YzDnbNQBAXVMj6cZoxtkxuySp?=
 =?us-ascii?Q?Jzq+zLPJwW+AiVdDCfzAPY4NDhmTql/3SpZQXp7OGKhkeezVX6vv8rGWBKMx?=
 =?us-ascii?Q?FTWpsToSd0aztor6sqVZFVHiDDEpvCc9Xaxtl+fBNg76LRmCk/TwjjmJmMfF?=
 =?us-ascii?Q?SExKnKRNs9g+JKD/NcTBbsVHQjuBstc1ATvtUGPXVnB9Wtz07d+CJbjATGuc?=
 =?us-ascii?Q?mJTydo89nuiV8F4HTexaZ4xpxwMoWceIKF0esNeJLwUwTXcDKG6hKM1NM4Wu?=
 =?us-ascii?Q?Pvuy6/5to1xI8swBc44huer3rW7qHQrke2w0fGeX2NGq4Ya60u+ZjdhpVJJK?=
 =?us-ascii?Q?m/24YoHBgTfu3hRZhUGdUMsQp4dp6BmOJtmi/+X7OGRUmVg1UwiFuqXiMv2G?=
 =?us-ascii?Q?IyGR882Y3jbn+1ksCV7R2JCg54M9uzEmVfb1bsq5g/2ymqr4BHjVoO8LTy9p?=
 =?us-ascii?Q?eJBTfydqAPyu8s46ndnBoo/US0i0CSlt33QbJDRdDP1XHX3pGC4upuzDdwn/?=
 =?us-ascii?Q?tp1NAoAPe8+x93K6Uz1KMWZjCLQnpVVGoB64K8qU5Bwk46Vq+yKSeW8qpAEX?=
 =?us-ascii?Q?nAXljnoHJUyYX1WXjamYt2l1x8H1eWDwitzHhA3h2I/UtkkI/LnejBkFbDQy?=
 =?us-ascii?Q?oawrFqn7L2K4EpEpSUrYaKnDtx7onfIq14/Xxh7wkEtnOHVb1GliWYxgCKGv?=
 =?us-ascii?Q?ndVVSmrwBFpyYnFZf9ee0cItt61kEdvbJTu2f5vQxjXVbICezkBDKBDUEFoA?=
 =?us-ascii?Q?UHuIxSDwIALHEmm0zX58YgjbXzTLErcGS68dJYP0ofwzHcdvI7pU6mjTLQTh?=
 =?us-ascii?Q?wSVuqi9EKKZwi/mC98vawazI/L2iT/OHTEN70nDqiUrVBJGGLxd9lWqU35Aq?=
 =?us-ascii?Q?KJH71UOV29EXqvfxj1Cz3Pkt/Aux2b7olV2sjJJ4ls6kBPW+LoaMxA6990pJ?=
 =?us-ascii?Q?jqaMRvXtgUCl6De0UXcyvus5DvCpxIy8l2kALUIBr5Nk42/HSxczm9NvSd0r?=
 =?us-ascii?Q?aeaQNSp1XaHL0vOba1vCbU1rWTftt07v9TSVLLFA1srkkRihFErXzR3Ealae?=
 =?us-ascii?Q?0ewi2wmSOb1Pg2h8vxS0vN3NbBWHJUwu/hkvrsarnJWUmeJFrHoQP7JY3ctT?=
 =?us-ascii?Q?nTBDs22ksT2RcVdVPe8LvXKBmp8jUxlugv1Ac31zeQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f6aeac85-511d-4ad7-6afb-08dba755064d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 23:26:22.6046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8027
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
v2: Actually send the patch set properly

 drivers/staging/octeon/octeon-stubs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 4470c985dc5d..2cdbcbd8a97b 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -238,11 +238,11 @@ enum cvmx_pow_wait {
 	CVMX_POW_NO_WAIT = 0,
 };
 
-typedef enum {
+enum cvmx_pko_lock {
 	CVMX_PKO_LOCK_NONE = 0,
 	CVMX_PKO_LOCK_ATOMIC_TAG = 1,
 	CVMX_PKO_LOCK_CMD_QUEUE = 2,
-} cvmx_pko_lock_t;
+};
 
 typedef enum {
 	CVMX_PKO_SUCCESS,
@@ -1381,12 +1381,12 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
 }
 
 static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
-						cvmx_pko_lock_t use_locking)
+						enum cvmx_pko_lock use_locking)
 { }
 
 static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
 		uint64_t queue, union cvmx_pko_command_word0 pko_command,
-		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
+		union cvmx_buf_ptr packet, enum cvmx_pko_lock use_locking)
 {
 	return 0;
 }
-- 
2.39.3

