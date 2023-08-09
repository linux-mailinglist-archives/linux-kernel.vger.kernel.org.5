Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4704F77500E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjHIBHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHIBHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:07:40 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCCFFB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:07:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56942667393so79031197b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 18:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691543258; x=1692148058;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cYMuekBbj+9f4BIAzTUfsUU97y+973XUFTIbO36R3rA=;
        b=YIMsp/gepK4kb1PZrGz/jrI1btP3/fBq0VS+Jtihn9KfhSn8ASHiORAJli9LUEFqQq
         HoxnuyBFBTo8dB+4vGMJnI9dJSLhOl/0LOqk8+JXBkWgQ0YcMOBlBgBDWTd9ZQGfUb7v
         v134eGbaCnhWJ6LlAN8bF4NJMexGDk2YjiUYpRwvqCcb+On066DYJ1u9PdLs/mhAWZdL
         P1gjm7ryz172CjgpqGQWMkMzbxADrIQ8l3m6Sj95aHIH88NNhVuWYh6o6EDtv1MxMUfp
         Z+g/P1Xrj3jChKB/JxAPZwQvvPTJAq11vzytlJrZk2L/TCIWjrIcFl3UwEkZphez2g1v
         pb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543258; x=1692148058;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYMuekBbj+9f4BIAzTUfsUU97y+973XUFTIbO36R3rA=;
        b=RYgh7Pl/0jRFkQVeS/ap4ToGdDMO2wKtewJRi1U0wkq0frnZujsBM0mjEfEfhYHRbF
         GsGTCidw4lLixGoW+UK2uoNj1bgJKlmH9UM9oWAk70WFbWhx9teRndmGulU0VhuTZbmd
         Uw3kqwdHJGY8p+3Azxlx5zWim/l+J85vYa1ZtPc1CDdZoem3VgJB/sup36fbq+pZuh+7
         /S0njAJ/r1g/I8hm1I1fSjnBWzKFqPcxZhBZAQh2SACsyNJ6sPSKQqkUGl8IyHZsbwo2
         9Xae4MzRVJFHsieMd65WmZ3zaojksDvgZRm0Wm78RZ1c+RYNn2f36lqRLJCBSiJAaz3i
         imVA==
X-Gm-Message-State: AOJu0YzRkk1t3zv52JdL6knuASTPYlumBbe/q4oDVxED6jsmf12XEzYJ
        zNLAmGDCKlyzRa/+sGofjaQizET12orZQYF13A==
X-Google-Smtp-Source: AGHT+IGd83ZX8ReCo4MMl2lJZKLr1ZI7hb1MShC/jpbSLkoqOwVElD6/rAY/fzNhyBCRDKlaKo7v5RwRnBDWeusQ7Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:860e:0:b0:d5d:511b:16da with SMTP
 id y14-20020a25860e000000b00d5d511b16damr23286ybk.2.1691543258744; Tue, 08
 Aug 2023 18:07:38 -0700 (PDT)
Date:   Wed, 09 Aug 2023 01:06:03 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHvm0mQC/13MQQrDIBCF4auEWddibIhpV71HySLa0QykGlSkJ
 Xj3mkA3XcziH3jfBhEDYYRbs0HATJG8qyFODeh5chYZPWuD4OLCBy6Zw7SfoSVhYB0XUrRXpXq UUDdrQEPvw3uMtWeKyYfPwed2//6k4U/KLeMMjVLYoe75ZO7We7vgWfsXjKWUL1fUF26rAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691543257; l=2008;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=DjNoNzSyECOWj9GeXGlWOMxAjhA7ZpfNH4jo0ilcj8k=; b=eCNgnGJeu1Qv/WXO/mUtZaRocGNwb35CduUVrPmAFtVA5M7UN6+TZeUoZU4xYFxcchLexcVlB
 GpJOw23FBD2Dy+A/fk64whbFgk/e9XmhwgV8fBND3vzMDG/7xrdupwr
X-Mailer: b4 0.12.3
Message-ID: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
Subject: [PATCH v2 0/7] netfilter: refactor deprecated strncpy
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` or `strscpy_pad` [2] due to the fact
that they guarantee NUL-termination on their destination buffer argument
which is _not_ the case for `strncpy`!

This series of patches aims to swap out `strncpy` for more a robust and
less ambiguous interface `strscpy_pad` . This patch series, if applied
in its entirety, removes most if not all instances of `strncpy` in the
`net/netfilter` directory.

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

Link: https://github.com/KSPP/linux/issues/90
Related: commit 8556bceb9c40 ("netfilter: move from strlcpy with unused retval to strscpy")
---
Changes in v2:
- use `strscpy_pad` instead of `strscpy` since zero-padding is needed
  (thanks Florian and Kees)
- Link to v1: https://lore.kernel.org/r/20230808-net-netfilter-v1-0-efbbe4ec60af@google.com

---
Justin Stitt (7):
      netfilter: ipset: refactor deprecated strncpy
      netfilter: nf_tables: refactor deprecated strncpy
      netfilter: nf_tables: refactor deprecated strncpy
      netfilter: nft_meta: refactor deprecated strncpy
      netfilter: nft_osf: refactor deprecated strncpy
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

