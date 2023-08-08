Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F063773CD8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjHHQKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjHHQIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:08:30 -0400
Received: from p3plsmtpa12-06.prod.phx3.secureserver.net (p3plsmtpa12-06.prod.phx3.secureserver.net [68.178.252.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA6F72A2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:46:16 -0700 (PDT)
Received: from localhost ([82.27.99.45])
        by :SMTPAUTH: with ESMTPA
        id TLQvqvQJu7sg9TLQxqseTR; Tue, 08 Aug 2023 05:03:31 -0700
X-CMAE-Analysis: v=2.4 cv=ENXAkXVC c=1 sm=1 tr=0 ts=64d22f14
 a=YwMIiW7BGddQzL8MrqPWMg==:117 a=YwMIiW7BGddQzL8MrqPWMg==:17 a=VwQbUJbxAAAA:8
 a=qCof3rqyAAAA:8 a=6JrHHfw-_58uzLPiYokA:9 a=AjGcO6oz07-iQ99wixmX:22
 a=sGiMcuukUhmiu4iKGgn_:22
X-SECURESERVER-ACCT: atomlin@atomlin.com
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     tj@kernel.org
Cc:     atomlin@atomlin.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 0/1] workqueue: Rename rescuer kworker
Date:   Tue,  8 Aug 2023 13:03:28 +0100
Message-Id: <20230808120329.3400069-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCZzZZ3vSB/UIi5sSVeFbA2XMoVacHblsgvTAw2bkfoqSNJQ4NBFE96GG1O0BCv4hOhwcTfHEoQj1IUZ6QqiF6d9f4cPIQVwAU0H+zv265gAOUfxq56M
 H7DpVHtnEaAjJXcj6U6t/Sh8MZGQt5wR+B5uO5LndaZC39Z2TydF+ep982+mbXvfsGKZCAQ9xt0s8It5l13tqkkzspjWNYV3OmDEW5D/Ex+UYkZ5OgenJfKZ
 L+/Lqp9wLaxMBWAfqNSHtasT0PJBSvkyxR3WVbKkIxSrMfjxua3DP/GCpTl+Lxxwd5SdZTnsKO2SJuXFu0Z3+w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each CPU-specific and unbound kworker kthread conforms to a particular
naming scheme. However, this does not extend to the rescuer kworker.
At present, a rescuer kworker is simply named according to its
workqueue's name. This can be cryptic.

This patch modifies a rescuer to follow the kworker naming scheme.
The "r" is indicative of a rescuer and after "-" is its workqueue's
name e.g. "kworker/r-ext4-rsv-conver".

--
Changes since v1 [1]:
 - Remove CPU affinity comment about the kworker (Tejun Heo)

[1]: https://lore.kernel.org/lkml/ZNFxmnGHxV0z5gKA@slm.duckdns.org/
--

Aaron Tomlin (1):
  workqueue: Rename rescuer kworker

 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.39.1

