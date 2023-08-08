Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49FC774E8C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjHHWsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjHHWsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:48:35 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1333C114
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 15:48:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583312344e7so77595457b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 15:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691534913; x=1692139713;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w6IYf4nshxor0R0BfWz4JihwJzXUnsgpsQ8Bx+FCm50=;
        b=v/F4rK8C1c6Y8YTaAeOsPAc5rlC8DfTsdhN2NcOQy8xZRaoS9cvitj9HgolcvWE5XN
         ZCiP+oEC5RA+WP6fZlEU1CnM2RNWG7JAxRMbaAZFn9uJ6EZdyRVTLnMIFZmpJ0leHpqh
         7spA+UxF93A8SpFyC9uM2L+GVmrc2Oz7NekmEKSBkf/D0u4FLjt9CTUbtd+8gtFhaZz7
         k18znWmvXCXpii8KvsTYg2aJQtU0osYwWxLYMWbgCMw6nzwrDCkx//Fl2Uaf3ok/PA19
         fBUF7829XdzW7mM47blfRSu0JxMy05t+IbWe2W6Sq0zG9sswyCnMVFGIHsZd252DX9zq
         QYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691534913; x=1692139713;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w6IYf4nshxor0R0BfWz4JihwJzXUnsgpsQ8Bx+FCm50=;
        b=E/ue6+Tg18UFnxxIQesTGemDiM8Q2dgbcMNCXWEMup+9IowZ4EmSFH9bcNqkWb5xc3
         kpLEBIWxpTO4QNvbliU14EN4SOYTHcTU9TfRuleSthI/78vD1VUqOGMkW9FmuMrULQoG
         ZqpPoHDjKoe+Xx2UKobITmUV0Ls5viPj92QQT/7yHq8zeEU8MS2wSQl1kuS2pJk7F5dT
         BQwporcJ5enaLlzxWlHV9cI/l0TxpbkYy/fBQdnLRo+b/CaX9TbqbZYLP8wW7cNGtoxh
         Fw50dAkTVSP/wqo31uRC5aCOQIa4i9Y/UUj90Vq1eOYfefoCC/i1Z/nDrNggOi3eYwKZ
         LGUg==
X-Gm-Message-State: AOJu0Yz5OfuF4TfLQs3Q059quA1O0iWqsA0i7pJV12JbwJeYf+E2qn8d
        OttLJdm+RcuQW+wIsZIMpHERSKC+Livwqay02w==
X-Google-Smtp-Source: AGHT+IGCKCpjw+qQSDFPyaaHwnCmIRgOXWU0/CPaXzJcAH1H2D2px83oqOo3PmhmQlTBWJHjAd9H6SpIq9/Lr6ycUw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:aa0b:0:b0:586:4eae:b942 with SMTP
 id i11-20020a81aa0b000000b005864eaeb942mr25570ywh.4.1691534913334; Tue, 08
 Aug 2023 15:48:33 -0700 (PDT)
Date:   Tue, 08 Aug 2023 22:48:05 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACXG0mQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwNz3bzUEhBOy8wpSS3SNTEwMjcytExKMks1VwLqKShKTcusAJsXHVt bCwBxh7PoXwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691534912; l=1704;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=ZOPiCy7w2pT1kz3c5DhiCZiV+zTmBFI8xyOrhaHPkq8=; b=35hLj7PJ6DP6/IdiB2Ylc5Y2G6xQ/3oI1SXKLWZ4BpDIns5/qOxf/7y6WjAKgN2o0Nv1hmmKZ
 7RXdFr4FcSnA1LghMYnhNj8402rOA1pYEJ9KZdZBr1W0Mso8AV+M+KL
X-Mailer: b4 0.12.3
Message-ID: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
Subject: [PATCH 0/7] netfilter: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

This series of patches aims to swap out `strncpy` for more robust and
less ambiguous interfaces like `strscpy` and `strtomem`. This patch
series, if applied in its entirety, removes most if not all instances of
`strncpy` in the `net/netfilter` directory.

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

Link: https://github.com/KSPP/linux/issues/90
---
Justin Stitt (7):
      netfilter: ipset: refactor deprecated strncpy
      netfilter: nf_tables: refactor deprecated strncpy
      netfilter: nf_tables: refactor deprecated strncpy
      netfilter: nft_meta: refactor deprecated strncpy
      netfilter: nft_osf: refactor deprecated strncpy to strscpy
      netfilter: x_tables: refactor deprecated strncpy
      netfilter: xtables: refactor deprecated strncpy

 net/netfilter/ipset/ip_set_core.c | 10 +++++-----
 net/netfilter/nft_ct.c            |  2 +-
 net/netfilter/nft_fib.c           |  2 +-
 net/netfilter/nft_meta.c          |  6 +++---
 net/netfilter/nft_osf.c           |  6 +++---
 net/netfilter/x_tables.c          |  5 ++---
 net/netfilter/xt_repldata.h       |  2 +-
 7 files changed, 16 insertions(+), 17 deletions(-)
---
base-commit: 14f9643dc90adea074a0ffb7a17d337eafc6a5cc
change-id: 20230807-net-netfilter-4027219bb6e7

Best regards,
--
Justin Stitt <justinstitt@google.com>

