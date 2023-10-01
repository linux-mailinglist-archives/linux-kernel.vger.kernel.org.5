Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1C97B4785
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbjJANIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjJANIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:08:41 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 01 Oct 2023 06:08:36 PDT
Received: from mail.sakamoto.pl (mail.sakamoto.pl [185.236.240.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63633AC;
        Sun,  1 Oct 2023 06:08:36 -0700 (PDT)
Authentication-Results: mail.sakamoto.pl;
        auth=pass (plain)
Received: from ungoogled-chromebook.pub.zentralwerk.org ([2a0f:5382:acab:1403:df7a:1afe:5a62:f4ea])
        by mail.sakamoto.pl (Haraka/2.8.28) with ESMTPSA id 60621AFF-99C3-45A5-A313-4DC9D3876F09.1
        envelope-from <april@acab.dev>
        tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
        Sun, 01 Oct 2023 15:07:27 +0200
From:   April John <april@acab.dev>
To:     aprl@acab.dev
Cc:     April John <april@acab.dev>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: 
Date:   Sun,  1 Oct 2023 15:04:52 +0200
Message-ID: <20231001130537.15038-3-april@acab.dev>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Haraka-GeoIP: DE
X-Haraka-GeoIP-Received: 2a0f:5382:acab:1403:df7a:1afe:5a62:f4ea:DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=acab.dev; s=s20220914329;
        h=from:date:message-id:to:cc:mime-version;
        bh=cL5BvNrnjDap5bK++GVy7L1DpwjaT1Jeu1v7F7sdHXc=;
        b=QZV4p99Tnr2E0DQibDcjBr9bNrSBQeMB6W7zBjXqaojj9uuE9gXtdCGw0czseIM4yoKyiFdDqU
        1APDcfkocIzbNjflcssn0SLKiiRL2gX6aThmYBsd+JCwrKqTD3RAkYNvM8NZ3GFLpSwHv5lIxDCP
        qhDoxWWK/4m7iZlIhxnw9KFYGA7rHbhyJHswMvCQb5veVKXC3E7Zxohjhm2NucvdBCosI5i8gqxy
        Mb15/6FB4kbkfdZvK9G0hPevQoXUSWr2x5b88pOOzW0ZPnfbIpHERjIKqYA7SMZr5SNCNQ8buMtS
        ruuycOTeH+VxcYichpZFOAG2oIaEnEOhoOF6SP2g==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Subject: [PATCH] /bin/dmesg to dmesg Path
To: linux-kernel@vger.kernel.org

Dmesg is not in every distro at /bin/dmesg, in NixOS for example, this fails,
but the path should in most cases contain dmesg.
This follows the example of replacing /bin/bash with bash Path in the codebase.

Signed-off-by: April John <april@acab.dev>

