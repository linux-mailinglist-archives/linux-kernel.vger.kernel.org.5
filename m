Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7D07DD186
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345157AbjJaQZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345151AbjJaQZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:25:09 -0400
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1A1F1;
        Tue, 31 Oct 2023 09:25:05 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698769503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2/WqVk2ZLmZJ6bgdjF1aGMs2a9ubs62YR4GPwL+7LDI=;
        b=Pm0ogUfAr1KunimWLPdFW+wIyni6jlMAfmX2xekYUo2NrYptSIi+SqiGgvUuzeqZ6L/eQC
        EWpXSR3DIR0CWH+SSPTYkcCyBRKX+AE3tgoLZN2Mi4avD9d9/YU1CA18Nq0ZE0DfkmbJkw
        q8Fgez5OCtEcFfBHxr8RCgsAV4JOGjI=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcache@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 0/2] Two small closures patches
Date:   Tue, 31 Oct 2023 12:24:50 -0400
Message-ID: <20231031162454.3761482-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll be sending these to Linus in my next pull request, sending them to
linux-bcache so Coly gets a chance to see them.

Kent Overstreet (2):
  closures: Better memory barriers
  closures: Fix race in closure_sync()

 fs/bcachefs/fs-io-direct.c |  1 +
 include/linux/closure.h    | 12 +++++++++---
 lib/closure.c              |  9 +++++++--
 3 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.42.0

