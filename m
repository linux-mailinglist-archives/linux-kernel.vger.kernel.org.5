Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D00B7F0EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjKTJUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjKTJUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:20:30 -0500
X-Greylist: delayed 464 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Nov 2023 01:20:25 PST
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3B3B9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1700471560; bh=jaBwf+KianUQkbIPZGYVuzwu8wMJafQtGn3I7OKAtlo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=mvUkQ4JN5jn+yHt/KzPd4gFS6DIYaHKf8vOOtlgXNihwfh2/l9Od6tiYiVoFqlHkP
         H+472kiatmS959O3RO/ginABc5Zr5O+5K/9vNeh8W1VS8UEVhmUoKg0D/mBnL06h44
         oF51KWeVxx2t3U4RGtwTN4CV4j5q6ljORtHWwYBNM2Ch7BZSAzfGCcKGMpxVZ58msC
         unjmt8RwPKouTRlrqdDxZjwYExikjppS/sSAPjZmuD9J+KPh1vTRSmwTLYTUmQ86q8
         7s2G5hv1SdIL2IdUUVDH60oUll1htgGLZeMFIcUHY475haqAh3RPqhf80U3x0bTWsS
         spUFlB6K0JHAg==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id F1756680167;
        Mon, 20 Nov 2023 09:12:35 +0000 (UTC)
From:   sxwjean@me.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com
Cc:     corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] supplement of slab removal
Date:   Mon, 20 Nov 2023 17:12:10 +0800
Message-Id: <20231120091214.150502-1-sxwjean@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wx5Tt0RX1M3zhAPfNwfrFALvtFqLHuSS
X-Proofpoint-ORIG-GUID: wx5Tt0RX1M3zhAPfNwfrFALvtFqLHuSS
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=924 suspectscore=0
 bulkscore=0 clxscore=1011 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2311200061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <xiongwei.song@windriver.com>

Hi,

These patches are based on [1] and repo [2], so they are supplement of slab
removal. There is no functionality changed.

[1] https://lore.kernel.org/linux-mm/20231113191340.17482-22-vbabka@suse.cz/T/#t
[2] https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-remove-slab-v1r4

Xiongwei Song (4):
  Documentation: kernel-parameters: remove slab_max_order
  mm/slab: remove slab_nomrege and slab_merge
  mm/slab: make calculate_alignment() public
  mm/slab: move slab merge from slab_common.c to slub.c

 .../admin-guide/kernel-parameters.txt         |  17 +--
 mm/Kconfig                                    |   2 +-
 mm/slab.h                                     |   5 +-
 mm/slab_common.c                              | 103 +-----------------
 mm/slub.c                                     | 100 ++++++++++++++++-
 5 files changed, 105 insertions(+), 122 deletions(-)

-- 
2.34.1

