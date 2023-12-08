Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CE380A069
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573557AbjLHKJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573537AbjLHKJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:09:43 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC05911D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:09:47 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db548aff7baso2588293276.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702030187; x=1702634987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZNJdOgnTD3YcBum6U88iX7U/INKHt0AizM4EWV5IGP0=;
        b=hUUtBuQOKOmP6kVPiF/y4Lic6SIJId/bCnuMh4mlTKWIlveovSMHMXFtl82AO4FrZq
         7kTF4HonlEKtCovssG1YVxjnPpxFo9FC/+TphzjZrEIclglmb7mdouW/3nqUcdPNcPN4
         nqPDVhqs+TizRCawG0XfQwC/MJ7++sYP6l4crjEElugjFu7b7+YSMFHMPQiqkXl11GAq
         /Bj5YIaNGweP5VTQ0qEilRF20lMUPZ0PmgQV+ffFsj1pn8wVNLWcLFNDF3DFWvh0g8uy
         B4JXulVPZNZfofNsS/1ZnJmmFWp8cet98tcdHwOOC05T8NHRyPGY/SVFFr26Wq5tcc/1
         zwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030187; x=1702634987;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZNJdOgnTD3YcBum6U88iX7U/INKHt0AizM4EWV5IGP0=;
        b=jx2V2gllQN8+HOxJUCsqZHKnCx3BGtkdZgB1Ot2s5knaGdLjfuBriv18eW/NrenN2N
         l1PlfempkK09T2Yafm251ePqxjW7K1UgS0raA7JbA9idXgnkayetGjFdmMa2oghTe5Ud
         X9aYDeRDj4jid/z8BMqxdIGRq2hL+c4CfGendb9ZPG8LUyso3TJmd0G/PIux+JXgzO1X
         M4EUdcsCx0V1aEhRleaDAqP3HgPC+Yzb8YGcV3fA7KYhrw4vtN/igJ3rONC5x+4vnX8L
         kiMcatruNCvJ+kfvkBGQ67hg4nGm9cLB1ekt8YYmRgi6sI3UlobqT6CwbpHgxkNyXGzm
         tJXg==
X-Gm-Message-State: AOJu0YxGwLHCSefSVA4RZG96UlmGSzq+DGA6siGc2gGsbSIuPHoKoi8U
        DUIV0Fjy1TnuI40LBU1WDJfsQjNiz1qwHg==
X-Google-Smtp-Source: AGHT+IHTKUtelEN9ry7G8JO0oWDMjRg+GteO8sBFE+t84Xa6DtfewAHNHnUwLtzaRV+ZcTprCzoNZmTRSah3qA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:d150:0:b0:db5:347d:44b with SMTP id
 i77-20020a25d150000000b00db5347d044bmr40829ybg.11.1702030187085; Fri, 08 Dec
 2023 02:09:47 -0800 (PST)
Date:   Fri, 08 Dec 2023 18:09:28 +0800
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFjrcmUC/03MSw6CMBSF4a2QO7amD0B05D4MMbRcyo1CTQuNh
 rB3a0cO/5OTb4OAnjDApdjAY6RAbk4hDwWYsZstMupTg+RS8ZNo2GOdabnrNbBOi7MpcSib3kD
 6vzwO9M7WrU09Ulic/2Q6it+aFSF59adEwTirVcVV3StthLpa5+wTj8ZN0O77/gUe59CsowAAA A==
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231208-kunit_bus-v2-0-e95905d9b325@google.com>
Subject: [PATCH v2 0/4] kunit: Add helpers for creating test-managed devices
From:   davidgow@google.com
To:     Rae Moar <rmoar@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KUnit tests often need to provide a struct device, and thus far have
mostly been using root_device_register() or platform devices to create
a 'fake device' for use with, e.g., code which uses device-managed
resources. This has several disadvantages, including not being designed
for test use, scattering files in sysfs, and requiring manual teardown
on test exit, which may not always be possible in case of failure.

Instead, introduce a set of helper functions which allow devices
(internally a struct kunit_device) to be created and managed by KUnit --
i.e., they will be automatically unregistered on test exit. These
helpers can either use a user-provided struct device_driver, or have one
automatically created and managed by KUnit. In both cases, the device
lives on a new kunit_bus.

This is a follow-up to a previous proposal here:
https://lore.kernel.org/linux-kselftest/20230325043104.3761770-1-davidgow@google.com/

(The kunit_defer() function in the first patch there has since been
merged as the 'deferred actions' feature.)

My intention is to take this whole series in via the kselftest/kunit
branch, but I'm equally okay with splitting up the later patches which
use this to go via the various subsystem trees in case there are merge
conflicts.

I'd really appreciate any extra scrutiny that can be given to this;
particularly around the device refcounts and whether we can guarantee
that the device will be released at the correct point in the test
cleanup. I've seen a few crashes in kunit_cleanup, but only on some
already flaky/fragile UML/clang/alltests setups, which seem to go away
if I remove the devm_add_action() call (or if I enable any debugging
features / symbols, annoyingly).

Cheers,
-- David

Signed-off-by: David Gow <davidgow@google.com>
---
Changes in v2:
- Simplify device/driver/bus matching, removing the no-longer-required
  kunit_bus_match function. (Thanks, Greg)
- The return values are both more consistent (kunit_device_register now
  returns an explicit error pointer, rather than failing the test), and
  better documented.
- Add some basic documentation to the implementations as well as the
  headers. The documentation in the headers is still more complete, and
  is now properly compiled into the HTML documentation (under
  dev-tools/kunit/api/resources.html). (Thanks, Matti)
- Moved the internal-only kunit_bus_init() function to a private header,
  lib/kunit/device-impl.h to avoid polluting the public headers, and
  match other internal-only headers. (Thanks, Greg)
- Alphabetise KUnit includes in other test modules. (Thanks, Amadeusz.)
- Several code cleanups, particularly around error handling and
  allocation. (Thanks Greg, Maxime)
- Several const-correctness and casting improvements. (Thanks, Greg)
- Added a new test to verify KUnit cleanup triggers device cleanup.
  (Thanks, Maxime).
- Improved the user-specified device test to verify that probe/remove
  hooks are called correctly. (Thanks, Maxime).
- The overflow test no-longer needlessly calls
  kunit_device_unregister().
- Several other minor cleanups and documentation improvements, which
  hopefully make this a bit clearer and more robust.
- Link to v1: https://lore.kernel.org/r/20231205-kunit_bus-v1-0-635036d3bc13@google.com

---
David Gow (4):
      kunit: Add APIs for managing devices
      fortify: test: Use kunit_device
      overflow: Replace fake root_device with kunit_device
      ASoC: topology: Replace fake root_device with kunit_device in tests

 Documentation/dev-tools/kunit/api/resource.rst |   9 ++
 Documentation/dev-tools/kunit/usage.rst        |  50 +++++++
 include/kunit/device.h                         |  80 +++++++++++
 lib/fortify_kunit.c                            |   5 +-
 lib/kunit/Makefile                             |   3 +-
 lib/kunit/device.c                             | 181 +++++++++++++++++++++++++
 lib/kunit/kunit-test.c                         | 134 +++++++++++++++++-
 lib/kunit/test.c                               |   3 +
 lib/overflow_kunit.c                           |   5 +-
 sound/soc/soc-topology-test.c                  |  10 +-
 10 files changed, 465 insertions(+), 15 deletions(-)
---
base-commit: c8613be119892ccceffbc550b9b9d7d68b995c9e
change-id: 20230718-kunit_bus-ab19c4ef48dc

Best regards,
-- 
David Gow <davidgow@google.com>

