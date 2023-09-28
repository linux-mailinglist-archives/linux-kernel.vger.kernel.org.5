Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F32D7B1176
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjI1EXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 00:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjI1EXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:23:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BBA114
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:23:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d814634fe4bso19615722276.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695874986; x=1696479786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I9BwMViTX8cfyxhxmLOd2Ac11XDedzRf29xVDKRKMs8=;
        b=WvPCC02Po+M/wNO7s4F+l/gifobp+kOubbIQXxBCwkD0dLfhxj+26Rf6uqIFabaN4g
         iKwD9S6pxCvOXSThBTs9bzApyzv9CHTDC93t8aaXtneABhuR+CWlH69wwziYby3nVvTF
         wxePDNsQ/NlQzQM+RV7HzHABqgORdfrn6dtnz6fc9K1U2m63+smuyFux3APDyYPiBmTh
         aIqxgGXvsB8oa41Zj+ISHrTOftTdkP6Wdc9eeouod+NKuu7YWqI0LmEih4m09N8nVKdp
         19txcR0SRgXO04m2nTgbST9zZoY95eVEiERSEKP29yHJeXGIU3P11k5ZAe2KJH8DT+/n
         XyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695874986; x=1696479786;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9BwMViTX8cfyxhxmLOd2Ac11XDedzRf29xVDKRKMs8=;
        b=w6IIGdWDRIwaaok6JWz0bUjcaYkyMVTXoMx9jDB0SlQIn62N9rNtrttglziinWLTtF
         Va7W1+WGjGLOKQNLjCuWxkZWC1sNk/1eYQkyjC8wyktHMgHHwdNkps+WI2C8FH3huRD4
         T8x0YWIGEEaF6c+4V8IBAeJEPGmMGUtELw42Q03ITRU8ae74RNku7Ly/RThubSOvOiAi
         bvYzbIqstjkG7Txwv/e7oyxC5sXaeiEOBwmC+ZiokbPMiJHQ96qMR2HcJs/7baslmi7f
         UqLr+sZySEchq07UKltffnp5Xg4L8V5eIQVlxDgvWl6hGvynHZeJCZMMuKlFeLEBlMMp
         oB8Q==
X-Gm-Message-State: AOJu0YyP0sbzEhxOuothx9HuN3EwDBtF8DDy6+O/afZdZcbI4Z0bmdW8
        O9xwkvPTtN67kgIgWrg91Fmd/yBfhUVSI1g6Ag==
X-Google-Smtp-Source: AGHT+IE2Ao+SFPQtgEEZ6maQf+v00aN/badqSm7geGWZeDb2K4zAIisJ3qbNnNiA/mG1hWXq56MeB2hAxPZeh0qI3A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:fc26:0:b0:d80:1391:1f1 with SMTP
 id v38-20020a25fc26000000b00d80139101f1mr1476ybd.1.1695874986047; Wed, 27 Sep
 2023 21:23:06 -0700 (PDT)
Date:   Thu, 28 Sep 2023 04:23:04 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKj/FGUC/22NwQrCMBBEf6Xs2Ui6FtN68j+klJCs6YJtJAlBK
 fl3Y8Gbhzm8gXmzQaTAFOHSbBAoc2S/VsBDA2bWqyPBtjKgxJMc8CwcpWnRvKYaCpO2drJCqg4
 73bcdKYQ6fQa682vX3sbKM8fkw3t/ye23/QnVf2FuhRTYG5QKcajWq/PePeho/AJjKeUDDj6BM rkAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695874985; l=1991;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=RL0cLxaMLKz5FSJbcqYyGpT9mQvf/e8HzhwcC6bZRuQ=; b=f8qTBGJkKuArzWwVhoBvcVTfbkZXHZE5J2T1+RXxVYW+pq4zN1gTs0dyX1rAssYngtpTk/odr
 4z/a9pgd5myDkB9WYnaT6DcWjK+oWZvDlLMiZP2Mcwsk/0WklmQe515
X-Mailer: b4 0.12.3
Message-ID: <20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com>
Subject: [PATCH v2 0/2] get_maintainer: add patch-only keyword matching
From:   Justin Stitt <justinstitt@google.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to add "D:" which behaves exactly the same as "K:" but
works only on patch files.

The goal of this is to reduce noise when folks use get_maintainer on
tree files as opposed to patches. "D:" should help maintainers reduce
noise in their inboxes, especially when matching omnipresent
keywords like [1]. In the event of [1] Kees would be to/cc'd from folks
running get_maintainer on _any_ file containing "__counted_by". The
number of these files is rising and I fear for his inbox as his goal, as
I understand it, is to simply monitor the introduction of new
__counted_by annotations to ensure accurate semantics.

Joe mentioned in v1 that perhaps K: should be reworked to only consider
patch files. I wonder, though, if folks are intentionally using the
current behavior of K: and thus would be peeved from a change there. I
see this series as, at the very least, a gentle migration in behavior
which is purely opt-in and at some point could eagerly be merged with
K:.

[1]: https://lore.kernel.org/all/20230925172037.work.853-kees@kernel.org/

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- remove bits about non-patch usage being bad (thanks Greg, Kees, et al.)
- remove formatting pass (thanks Joe) (but seriously the formatting is
  bad, is there opportunity to get a formatting pass in here at some
  point?)
- add some migration from K to D (thanks Kees, Nick)
- Link to v1: https://lore.kernel.org/r/20230927-get_maintainer_add_d-v1-0-28c207229e72@google.com

---
Justin Stitt (2):
      get_maintainer: add patch-only keyword-matching
      MAINTAINERS: migrate some K to D

 MAINTAINERS               | 21 ++++++++++++++-------
 scripts/get_maintainer.pl | 12 ++++++++++--
 2 files changed, 24 insertions(+), 9 deletions(-)
---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230926-get_maintainer_add_d-07424a814e72

Best regards,
--
Justin Stitt <justinstitt@google.com>

