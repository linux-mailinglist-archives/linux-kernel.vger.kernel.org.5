Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B9F7F4846
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbjKVNxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344271AbjKVNxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:53:10 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E489D45;
        Wed, 22 Nov 2023 05:53:04 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vww0FXz_1700661181;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Vww0FXz_1700661181)
          by smtp.aliyun-inc.com;
          Wed, 22 Nov 2023 21:53:02 +0800
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
To:     wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        corbet@lwn.net, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com
Cc:     tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] add two sysctl for SMC-R v2.1
Date:   Wed, 22 Nov 2023 21:52:56 +0800
Message-Id: <20231122135258.38746-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set add two sysctl for SMC-R v2.1:
net.smc.smcr_max_links_per_lgr is used to control the max links
per lgr.
net.smc.smcr_max_conns_per_lgr is used to control the max connections
per lgr.

Guangguan Wang (2):
  net/smc: add sysctl for max links per lgr for SMC-R v2.1
  net/smc: add sysctl for max conns per lgr for SMC-R v2.1

 Documentation/networking/smc-sysctl.rst | 14 ++++++++++++++
 include/net/netns/smc.h                 |  2 ++
 net/smc/af_smc.c                        |  2 +-
 net/smc/smc_clc.c                       | 15 ++++++++++-----
 net/smc/smc_clc.h                       |  3 ++-
 net/smc/smc_sysctl.c                    | 24 ++++++++++++++++++++++++
 net/smc/smc_sysctl.h                    |  2 ++
 7 files changed, 55 insertions(+), 7 deletions(-)

-- 
2.24.3 (Apple Git-128)

