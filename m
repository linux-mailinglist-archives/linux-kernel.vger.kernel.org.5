Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA197604C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 03:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjGYBhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 21:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGYBhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 21:37:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F52173E;
        Mon, 24 Jul 2023 18:37:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE99F61483;
        Tue, 25 Jul 2023 01:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E36C433C7;
        Tue, 25 Jul 2023 01:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690249034;
        bh=0mn6WxommjNsX3RWGAck/y6So0PDCRRvb9vDhTmonEY=;
        h=From:To:Cc:Subject:Date:From;
        b=B1alLFxxfIbQ9uOwtHy35Kfc5QIljIjZaB76HVbSNqeUDmUH6s3yf5IWMM60xL0RB
         ylWMNMnfGHuEavd9YRpypebB/B91eL6WyAJLi8wx+ovRn9x0gt/5TABkpdf/khdwLV
         RJWPbnQ9PgHp1pxupIalrMW92sTaH5yJ1T0EKTKJ9hKwB7XjrRjPBR7R0AHUFqX6zj
         NUZW+EuwmHW6AuUfrz/j2+Q29qgnuTJEimbKOqXKHO0aEwfvGcpkO0I7bI75IU0PtW
         G+UP4zIfghTn/h78RY7eUg+xDhtOGtTHRJ4oxdF1azTtHmvPEJUmOdoYXtuQxiPBjK
         HNFmZ71iMMGEw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: [PATCH 0/2] tracing/probes: Fixes for v6.5-rc2
Date:   Tue, 25 Jul 2023 10:37:10 +0900
Message-Id: <169024903018.395371.1006584451160707296.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches are probe-events fixes for v6.5-rc2.
One is to fix btf_type_by_id() return value check and the other is fixing
selftest.

Thank you,

---

Masami Hiramatsu (Google) (2):
      tracing/probes: Fix to add NULL check for BTF APIs
      selftests/ftrace: Fix to check fprobe event eneblement


 kernel/trace/trace_probe.c                         |    8 ++++----
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
