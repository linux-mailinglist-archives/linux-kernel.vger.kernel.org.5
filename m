Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0C281106A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378004AbjLMLqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjLMLp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:45:59 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EFCD5;
        Wed, 13 Dec 2023 03:46:01 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VyQzxsZ_1702467954;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VyQzxsZ_1702467954)
          by smtp.aliyun-inc.com;
          Wed, 13 Dec 2023 19:45:59 +0800
From:   "D. Wythe" <alibuda@linux.alibaba.com>
To:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, coreteam@netfilter.org,
        netfilter-devel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ast@kernel.org, "D. Wythe" <alibuda@linux.alibaba.com>
Subject: [RFC nf-next 0/2] netfilter: bpf: support prog update
Date:   Wed, 13 Dec 2023 19:45:43 +0800
Message-Id: <1702467945-38866-1-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patches attempt to support updating of progs with
bpf netfilter link, introducing a new RCU-protected context
to access the prog, and adding a corresponding test case.

D. Wythe (2):
  netfilter: bpf: support prog update
  selftests/bpf: Add netfilter link prog update test

 net/netfilter/nf_bpf_link.c                        | 124 ++++++++++++++++++---
 .../bpf/prog_tests/netfilter_link_update_prog.c    |  83 ++++++++++++++
 .../bpf/progs/test_netfilter_link_update_prog.c    |  24 ++++
 3 files changed, 218 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_link_update_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_update_prog.c

-- 
1.8.3.1

