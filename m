Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8D7755E93
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjGQIgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGQIgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:36:47 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B88D8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:36:46 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4Fmm6yfxzBR9sd
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:36:40 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689582998; x=1692174999; bh=BNkHpP52Ps8+FjJEZaBkoygylnC
        +RgDyNMxsC2jDSm8=; b=Bftt+7EJIKNiKeCTa3OlQgnPjk8gwPWdXyDnP1IniSJ
        qRvGxN2Y6M9fov5zfBP5t8n3tjaSeCh3sC5cSx24y6UGq65b959At7/IJyIDeYTl
        0UXjPRd6OzlIHFlk+cHvGumyOVdkt+2p3FWW8dCl5Uxfet7wrQNUJdegJoNccFE4
        qPInvA6Uf4uv6f5rDZc4FrW7YjwupSU+h5gyE6KHPQxlq+9WsSC5wW82fJV1/Whs
        rSc/2qZzabDYnUbGEDGY4t5r1sRMtTZXtB9rf63cEKlToKd9uohZcZH3BBlesJcL
        RFkiBWTBiQGNIwki6VW3mPpSRVyEH53RD2mNOfz0tgw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id seUIgG8igIjA for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 16:36:38 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4Fmk3fZQzBR5l8;
        Mon, 17 Jul 2023 16:36:38 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 16:36:38 +0800
From:   shijie001@208suo.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com, adrian.hunter@intel.com
Subject: [PATCH] perf tools: Fix error in demangle-ocaml.h
In-Reply-To: <tencent_ECA15CC61879850D3C89CB23F8F3DD32600A@qq.com>
References: <tencent_ECA15CC61879850D3C89CB23F8F3DD32600A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <d4736a9417d2e364615d5a0361b1d3b0@208suo.com>
X-Sender: shijie001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following checkpatch error is removed:
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  tools/perf/util/demangle-ocaml.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/demangle-ocaml.h 
b/tools/perf/util/demangle-ocaml.h
index 843cc4fa10a6..7fff95ae354e 100644
--- a/tools/perf/util/demangle-ocaml.h
+++ b/tools/perf/util/demangle-ocaml.h
@@ -2,6 +2,6 @@
  #ifndef __PERF_DEMANGLE_OCAML
  #define __PERF_DEMANGLE_OCAML 1

-char * ocaml_demangle_sym(const char *str);
+char *ocaml_demangle_sym(const char *str);

  #endif /* __PERF_DEMANGLE_OCAML */
