Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A182F7AF8F7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjI0EA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjI0D65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:58:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126AC1E978
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:19:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-597f461adc5so206887297b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695784767; x=1696389567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DGozN3Q2BjVab5DdC5Xqh5aKsGm98+6kSJqgQyphx4Q=;
        b=wWxxFkNRhyFJrl2HT2Y7HKBAuHEyijl48YBQ4zrpWFFvwamXybQrAjZLJz6FJLS8qs
         9jjNd38wrNAm6nQSX3ceOHEFR9mmPW2oaddv7AX9KqZLoW7Wa8+JIYO1VkA4idV0gtSB
         +9W0zcWejYSxex4PV19AQXMQoolXKulgQYZTNqrWCfs2vwDxBJoI5GtsNJE8vjAtxxiC
         bs4bSMLdiVL5Ov6DK0AE0G0Rr8qDL7qnQt26YhjcZhKOwB/gTTqsjSO0P1FNCwpNMTS4
         kLrC5SjVOFkyzSr43c5pQyLl6TGTRdlsxYLBS0sVSAeXBKFTUEpiTC+BIBs7u7Iddebr
         Gu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695784767; x=1696389567;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGozN3Q2BjVab5DdC5Xqh5aKsGm98+6kSJqgQyphx4Q=;
        b=tv99oHsWH980fO/SVvn+hmLbokwtcxdk4FuHlkam/ZCrDjVvA0kG5Wopj61MBbwzZ8
         LkAjWUHPCA0hugEuzCExr7edHnnuTpqPrKo7/K4hmwJ2Ot+CFeRePuXzCfmSiDwOfw3O
         GlG414nUVahIHh6O3OlzgqnWLTW+37n1JeHz6sULh5s1kZy66KCP/QRs0a718BRZFxhM
         rhq8ROSfaLJe/1N1Qh8NirAMzKxzbiAkk3o7/SjMT/vXPJcSUMfAJgj1HeS00mDDXqfF
         UbxaKdSV8f4LYZMLm7k//OII+m8EvBX68gUsFYLyOADyUXruHfsjIwiNPBAi0eiKHfxX
         jDUA==
X-Gm-Message-State: AOJu0YykcmwdxlVMUMDoQuAKeS4YIIyvQGTlPG5kGj0X9EE73opxPAiE
        IRGKKd1ypAVHwLfC/USIN7DoMwo+ez8UbEm5CA==
X-Google-Smtp-Source: AGHT+IFacMx8GpxVXB6axPpq+vXi8WKy5ZXo2AjxMntJypqIRg0l1HjRPdST6huJcVUl8MLsrqNan5P2YE12nFDdbg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:880b:0:b0:d89:dd12:163d with SMTP
 id c11-20020a25880b000000b00d89dd12163dmr1445ybl.1.1695784767190; Tue, 26 Sep
 2023 20:19:27 -0700 (PDT)
Date:   Wed, 27 Sep 2023 03:19:13 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADGfE2UC/x2MQQqAIBAAvxJ7TrBNsvpKhEhutocsVCKI/p50m
 MMcZh5IFJkSjNUDkS5OfIQiTV3BstngSbArDiixlQN2wlM2u+WQCxSNdc44IbVCZftGkUYo6Rl p5fvfTvP7fozB+mhmAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695784766; l=1608;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Z/OmsHcYrM5MtXvVa9TZMGeFKOHN5xCyog9zO9xwJV0=; b=lPG98gO1n66aeEpHpqKhRK8xSwE9XYPSVvpQeaoQ1BmEHFgA6zvp7wzCceTBEOWUVNotomdWM
 vmWsWEkLWirA9uPCL0HWgUEeGew3+yB6ftxyokDo8HNY/g8F8Kwa6gZ
X-Mailer: b4 0.12.3
Message-ID: <20230927-get_maintainer_add_d-v1-0-28c207229e72@google.com>
Subject: [PATCH 0/3] get_maintainer: add patch-only keyword matching
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
tree files as opposed to patches. This use case should be steered away
from [1] but "D:" should help maintainers reduce noise in their inboxes
regardless, especially when matching omnipresent keywords like [2]. In
the event of [2] Kees would be to/cc'd from folks running get_maintainer
on _any_ file containing "__counted_by". The number of these files is
rising and I fear for his inbox as his goal, as I understand it, is to
simply monitor the introduction of new __counted_by annotations to
ensure accurate semantics.

See [3/3] for an illustrative example.

This series also includes a formatting pass over get_maintainer because
I personally found it difficult to parse with the human eye.

[1]: https://lore.kernel.org/all/20230726151515.1650519-1-kuba@kernel.org/
[2]: https://lore.kernel.org/all/20230925172037.work.853-kees@kernel.org/

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Justin Stitt (3):
      MAINTAINERS: add documentation for D:
      get_maintainer: run perltidy
      get_maintainer: add patch-only pattern matching type

 MAINTAINERS               |    3 +
 scripts/get_maintainer.pl | 3334 +++++++++++++++++++++++----------------------
 2 files changed, 1718 insertions(+), 1619 deletions(-)
---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230926-get_maintainer_add_d-07424a814e72

Best regards,
--
Justin Stitt <justinstitt@google.com>

