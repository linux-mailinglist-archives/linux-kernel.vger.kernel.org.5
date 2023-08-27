Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D6678A366
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjH0X03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjH0X0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:26:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2078.outbound.protection.outlook.com [40.92.40.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C66BB2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:26:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8sMm8qa2FPUI9HKcjXXezuxlqDRvl29S1qF/olWGYNT0j06DU5Zyrht2eMp3gb8w9kSjzRKXXp/AqSRIC0xr2uGackKHxT0E4ZFd468uJfMEreHus4cqfn2wj8dawrWmy25c09mQgSXsUcZjaYJK2pSNSC6hi4Hp7ezrt6rOyV3oX0gnjtTiOOfxUqgeAVapCM5Q8zGoRa0ueDh5KZfty9DX+8zuaHJ89WsfuKCCsY9WlVl4XhXB95xb2Z8hAS4bQca8ygFYDFAs70b9tVFN3OQZDARagtOPEbns/3eDLZ8U06UVd2dt0I/xHCeVWzxAMoacGJho8H6XW6ODBqc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=At7I4bJXDrA20A1yHs7L3BbzZLw6zJWy4PqaKt3ayKg=;
 b=OnQZvU1tsl4S8bxL3u72s4L3g/E/HDvwzJKTJpbrPnw2RiqS1SFpP5VAPpztbirWn1cvUx0zP34UwTdDipOPpNddgFKnPa75aXhHX/f0zTz2iIXnrHx1im84KUT/iavGIC4LXM/aHl735wbTfRHy2DdGY/oOH+r+4ORo0GPFUUmlY+8xj9LVwfXqwPYj2sGOFW70FA+vfeMJVh+hoKHcETKCXjKfNISYRNAN5ZGB/Yqis4oBSeqdTMJU5/pwq+/hzLlf9rAuqER6HAXyiXO2hv2VajUQe5ptAlUbCm24DRAo38ylHvi+ZVC2kkvwn8v1LWjIpKIqvy9W0VPQAYQZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At7I4bJXDrA20A1yHs7L3BbzZLw6zJWy4PqaKt3ayKg=;
 b=PGiGDWLD33MCaabVkk9Ms213mp0xz9L3mUCC8HpxhVXnnN4396nyZmg8RVmhrVjuPhR+EpC2k6CjspRJ1HjQaVWeI3MgUrTkNAqKp3dFTigkGnjijkfzU2M/yJk7SXOtbhAHZywhkoqI1OwG+vfLoGopm10x8vGjQxi/AeYfm+49Wi1MCSWCz8gOhJdCy1mUmu4AGn1eonUlVbyJ/9LkLGZ/BNbO8qrMtksjb/Ql5jjLP26Dkvpze4KcYGPq+Y1UE2GVzXRy8IAH7f9kZVI2a2CJJGczna5l1V2k62ar9BIi3FrlseI0zNHtck0ugY655Xb6HTaWmy4P47tigIlKFw==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by SN7PR11MB8027.namprd11.prod.outlook.com (2603:10b6:806:2de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 23:26:15 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 23:26:15 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 1/6] staging: octeon: clean up the octeon ethernet driver
Date:   Sun, 27 Aug 2023 19:25:51 -0400
Message-ID: <PH7PR11MB7643BFDCDB0260EB1F9D3510BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693177830.git.ozlinux@hotmail.com>
References: <cover.1693177830.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [4zJbEjAdS3GQVVc+2vZUbE+1On87OkTRnslLhNoBysG1ehKs6GxS1UxWNj7UW5Hk]
X-ClientProxiedBy: MN2PR20CA0046.namprd20.prod.outlook.com
 (2603:10b6:208:235::15) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <1a5289442790798dd7eb80884cdaa8334b99c78a.1693177830.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|SN7PR11MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: f24f95f2-1d98-422f-93f0-08dba75501f6
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrTVQo2E8YhiYZbimk9QHlfee0RmoCxeVIBm7zJV9IEh2erBqrPQl60ikNP98iirYNZZ0IYg2rn9ps6WlS+ifCjSQ4U39TvBw1iy7riB5OQWwTeaSHq6NtBj20Dbjw5bnP/a9BZnL6H4F5qRzALFLnr5xsYtxaVb7DrDGJACef4fziPkZw3/OhgloonsY0G+DCFhk+ks8XX0dTu/I4eTZcVrBHi6y/GeN4oBHkvAYtKOauzYI82VKXsmfUdV48elHbb5IlCR2XtWSL2FEC6UiLoB+b2gf/WumfSA2mwduEOJcH7tkNe8e13QX+AoHVUPB9iiE/4HOaIgMyqtFlBmUYPE+8SHU87Eb/3EQ65Cuacz1xqajha53nDojXBm/xkuaB66xOabrO9Bw/yID+qfHwTI+FRoViLnPPzbyPhzuHPteCHFreg7GWATqO7KiAI85IN3xDmbmfpZxzUdqZX2kR/vI5qmWsGCrYS4gTjzoQ+92SZ2wgKq8lxOpg4zAoDMkzg6VZBq6CEn/wBe14pYLMhwx+FC/cMqVAFx4jvpL4pS1efp2XDf1Ix4GymFpUoezSgCdud6du98zXs0P5Qc5eflWr572i3wlhY7oY/nZFAcTVNqqLAdcETQ/ZrUycsdomTVML8E+442dhZoKvvTa5RboUA45eqgTDP/+AWrqcv6nzcvQl/4US5GrjONzyccdJ7p22u3J0TQyMHSGKC4LZWajHo1vovXgUS/TU5gE15V8W/ZJikA4QCq+cgdS7Wm0I=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLwWpP+KoYHUDdSoa/xIjns8Ek8nkab5RWhGLd+udQke3Lbdxhf3YOrtOmXHuJHxalxDndGN482QgH6u9H27kzaqbQ+KohMywJC0A2AvlPJb/kmqhLwd9NDBekjmaiaKWsOnC5HkSHMMqpXz/SqLA0ujCahv9o65q34k9uZkupYITaNINLgiJtqW0ue+DIzjrWL4mTLRC7MmRCxIcB3G8JaiRDj1dLoFXnG37E6+9mWDzfZWCscHA4cBu+4rlkcxCbi3g+rElko2oyfNQTrzindBtdbZrp4CRcJupakIqSjIdMghC5resW2b7npqikSdwe0HJ508pipoGfKjg1gxbC1iLdNMIJ6S/EbiiVkmfRPaUoRnfZ30SikTSIHYlA04FFX8oLbdxbns/IhWPSF+wHJNh8XUd3tu/5trsi2IvMcKgD1S7fAvY9Arf/9zJiDzqzlDqUbP1o9kK+u7JxSzJMz7HvzCqg/aDcI7+udVkqUNX75RVKygcrzEbgTDjWRH53nNPc3fOSOBovVjTKjW3N1jR9IRcpey/fTCz49wNTwHW94KDiWKVQNoaIAjT69Xqw8/T6uaU+IR5uAay33ndtFTmGx8qXemdwS1vD3yS2MKsppi/TgKmvr59d13yHcB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hh6rmtW9RsoBPJDyTtUGd5EmPJKWRmZcc/x9pP9piTzvXi5MtrhktDaz59ci?=
 =?us-ascii?Q?oxSaq/BAi3ioqSWi1K3qTejozvLz+7p8GLOy1yKkoQDynHzmxAFD/PTkN+Qg?=
 =?us-ascii?Q?U0g5eRKFz50ncCJcjZ1C1VRetHmhbV+UvZLIjFwY6tGIW0yMqW1u3vIqGnqE?=
 =?us-ascii?Q?uRr+bBk2bnD4gETH5p6yH+6j8eZcICt8lH960CrSbwqBOJG2B6Dfjs3F+I2K?=
 =?us-ascii?Q?i70mLGu1sGl7RxWhXynASltvODDKdY4HRIeb5crpeZt/tltdmVnmC/vego6j?=
 =?us-ascii?Q?1ceMqHRDB3xhZTX04xTcsEsGZR3I21KWyKWrm0+by68YxWvI0hIQ04jzRkIX?=
 =?us-ascii?Q?RfjERuZz63qAMwbRAtQv/+v8r1wsTYllh3+kX1rvBBqZ65TAUsbxJZGL7vL2?=
 =?us-ascii?Q?ew1xKFERzp0pxZuQSAzKdQqQtWrNVNgwgjgWorv5tkRDyO5kczXg/SV3vBFc?=
 =?us-ascii?Q?f+E8IM12pL0FdcDW798+Beflsd7OlCuAOmhKhVPGNMVd+a2TmysAvM8yknEA?=
 =?us-ascii?Q?EIJXYart4RW10LW3zU7d1YAn8h8OHlzqfIjsLBxeYg0uBcMVIIpiHJS78UD4?=
 =?us-ascii?Q?mqVTEWYBCJpdhxhhZGCVa3Yv/JuGTYf5UO6x3DHD95FkEozQOgvzO2WQNXbd?=
 =?us-ascii?Q?UUN7eqpSCjUCIv+V/2T7o2sj71dsY7VWrlILhk7Cl7eadzKHs+Xzmheq6CJT?=
 =?us-ascii?Q?4G6EnBeEItfDKSeLSKIVZlCvVs4p0Apam5jFmi/g1TfjKkiI+lizQDBYu4mo?=
 =?us-ascii?Q?rEMFmXxYF96lPHpH1Zi2CIBqQ4ynAq8DMrfIwJBnKrj6cJQu/XsMmGRdLLUQ?=
 =?us-ascii?Q?JehcRuq7bipvDcWyDEOQYlpRyZb9TJB47a7wn7j17YNkgBcMtUF8oIgQwHdQ?=
 =?us-ascii?Q?z8TuvQ8sdSwMQ8LKciEDylDUSaYpUdrn8RfVChWGNBdVzuRrwgCM8HTmKK+2?=
 =?us-ascii?Q?rw08cYMAM2IX22P6EzzKGECTkNnU4rYXAD4VF61APzS4IHPxlX0a4iRF++zv?=
 =?us-ascii?Q?06Z9pJITWLhQ4prMFdKcv7J96F6DYL9Im8RbuMvONny59zd8j2MieZuEXVgr?=
 =?us-ascii?Q?YHtwKSvi8bQgFuYWcsB8jtt54l3uATgFw0MR38f49YSb/YdKrfgqkPFTIY2q?=
 =?us-ascii?Q?6a6YXlwoSBUNN3hrWR8KhhAMm4qC9oFXg7mg17yXFuISpiKqmsURCN2KxbSs?=
 =?us-ascii?Q?/T0Ayf9pH8GzKghkjDth9AVtXsVejBRj/5nUX+YFBxio53kTphWgkpU08DxW?=
 =?us-ascii?Q?X7HBOwwAhk/rwkTIyl0nkfNm1OAX2zMfzvlzmkGM6Q=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f24f95f2-1d98-422f-93f0-08dba75501f6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 23:26:15.3298
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
v2: Actually send the patch set correctly

 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 3e7b92cd2e35..9f269626b862 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -213,12 +213,12 @@ enum cvmx_fau_op_size {
 	CVMX_FAU_OP_SIZE_64 = 3
 };
 
-typedef enum {
+enum cvmx_spi_mode {
 	CVMX_SPI_MODE_UNKNOWN = 0,
 	CVMX_SPI_MODE_TX_HALFPLEX = 1,
 	CVMX_SPI_MODE_RX_HALFPLEX = 2,
 	CVMX_SPI_MODE_DUPLEX = 3
-} cvmx_spi_mode_t;
+};
 
 typedef enum {
 	CVMX_HELPER_INTERFACE_MODE_DISABLED,
@@ -1362,7 +1362,7 @@ static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
 }
 
 static inline int cvmx_spi_restart_interface(int interface,
-					cvmx_spi_mode_t mode, int timeout)
+					enum cvmx_spi_mode mode, int timeout)
 {
 	return 0;
 }
-- 
2.39.3

