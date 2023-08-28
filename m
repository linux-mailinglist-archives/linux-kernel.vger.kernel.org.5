Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DD878B768
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjH1SnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjH1SnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:43:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F27B191
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:43:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c0c6d4d650so28102355ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693248181; x=1693852981;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGFv0KOXFwsFGIQtlmNnnSy3onBLZ4jPiluBZd43jh0=;
        b=hUZVBfBLCfOF12nM/nYgd6df9d5R8HJiXNKOSMqu8RIUN6buEMM3WGbSYLxeOzjE3N
         UobeVxtDcb/nHM5zkWqfnlhNhyk2vRcDRHANQHz8JFqevOk2SdwCanRGqlced4BUGl8y
         hQQmcGZS8lNNT2Jve7F7YtLgz9ZTdxx0TDKbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248181; x=1693852981;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGFv0KOXFwsFGIQtlmNnnSy3onBLZ4jPiluBZd43jh0=;
        b=RGh1xmWt6aSUZUK4yeOF2RysrPh+QJiUtE/FSPe4FqPXPMQicP/iqWacoT7XKFdOmh
         b+mXvkV0tQwUUKCGPxyRSFeiaNmdCSO8p8Yz2984hgWYFuKjaFc/rilg9dPCoyzzPtSN
         EosfLqaj+yGy8dIlL5AxTGe4BP5f0KZpE9MYOjl7p3G/SQ0jlaxO3Z1cDnI8STxPk3vg
         KPk416hMfrCumhrWqu90Tg54nVigO+Z+wkRq+ToQLFrRDaeinELb/DYPeqD1veAZHCvd
         QyqxIFoN1HjpfvEOhfokiuIEMkvR5aPmjbK5fkz/i6MUTSOTEodsHT+37756BiusorB8
         0XPg==
X-Gm-Message-State: AOJu0YyAIcOCCmlutTfs2thkBfKqwizJhU5Tozsn/nCsl+LVme9x5qUR
        87/fWjcggteeVjgWm4cAYtaMDQ==
X-Google-Smtp-Source: AGHT+IHfsRAH75dLN1s6nCHDyMpbBQ/eXRvdSO0cOOqA/mrXdTkhjPXt1U0oyo+eGP8cGzaqa9cR7A==
X-Received: by 2002:a17:902:ea0f:b0:1b8:1bac:3782 with SMTP id s15-20020a170902ea0f00b001b81bac3782mr30568804plg.6.1693248180686;
        Mon, 28 Aug 2023 11:43:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902c18b00b001bb9d6b1baasm7693185pld.198.2023.08.28.11.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:42:59 -0700 (PDT)
Date:   Mon, 28 Aug 2023 11:42:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Jann Horn <jannh@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Justin Stitt <justinstitt@google.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Song Liu <song@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-hardening@vger.kernel.org
Subject: [GIT PULL] hardening updates for v6.6-rc1
Message-ID: <202308281138.5E9835A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these hardening updates for v6.6-rc1. As has become normal,
changes are scattered around the tree (either explicitly maintainer
Acked or for trivial stuff that went ignored). Details in the log below,
and all have been in -next for a while.

Thanks!

-Kees

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.6-rc1

for you to fetch changes up to 5f536ac6a5a7b67351e4e5ae4f9e1e57d31268e6:

  LoadPin: Annotate struct dm_verity_loadpin_trusted_root_digest with __counted_by (2023-08-25 16:07:30 -0700)

----------------------------------------------------------------
hardening updates for v6.6-rc1

- Carve out the new CONFIG_LIST_HARDENED as a more focused subset of
  CONFIG_DEBUG_LIST (Marco Elver).

- Fix kallsyms lookup failure under Clang LTO (Yonghong Song).

- Clarify documentation for CONFIG_UBSAN_TRAP (Jann Horn).

- Flexible array member conversion not carried in other tree (Gustavo
  A. R. Silva).

- Various strlcpy() and strncpy() removals not carried in other trees
  (Azeem Shaikh, Justin Stitt).

- Convert nsproxy.count to refcount_t (Elena Reshetova).

- Add handful of __counted_by annotations not carried in other trees,
  as well as an LKDTM test.

- Fix build failure with gcc-plugins on GCC 14+.

- Fix selftests to respect SKIP for signal-delivery tests.

- Fix CFI warning for paravirt callback prototype.

- Clarify documentation for seq_show_option_n() usage.

----------------------------------------------------------------
Azeem Shaikh (4):
      soc: fsl: qe: Replace all non-returning strlcpy with strscpy
      um: Remove strlcpy declaration
      perf: Replace strlcpy with strscpy
      EISA: Replace all non-returning strlcpy with strscpy

Elena Reshetova (1):
      nsproxy: Convert nsproxy.count to refcount_t

Gustavo A. R. Silva (1):
      alpha: Replace one-element array with flexible-array member

Jann Horn (1):
      ubsan: Clarify Kconfig text for CONFIG_UBSAN_TRAP

Justin Stitt (2):
      um: vector: refactor deprecated strncpy
      um: refactor deprecated strncpy to memcpy

Kees Cook (8):
      seq_file: seq_show_option_n() is used for precise sizes
      x86/paravirt: Fix tlb_remove_table function callback prototype warning
      selftests/harness: Actually report SKIP for signal tests
      gcc-plugins: Rename last_stmt() for GCC 14+
      Compiler Attributes: counted_by: Adjust name and identifier expansion
      lkdtm: Add FAM_BOUNDS test for __counted_by
      integrity: Annotate struct ima_rule_opt_list with __counted_by
      LoadPin: Annotate struct dm_verity_loadpin_trusted_root_digest with __counted_by

Marco Elver (4):
      compiler_types: Introduce the Clang __preserve_most function attribute
      list_debug: Introduce inline wrappers for debug checks
      list: Introduce CONFIG_LIST_HARDENED
      hardening: Move BUG_ON_DATA_CORRUPTION to hardening options

Yonghong Song (2):
      kallsyms: Fix kallsyms_selftest failure
      kallsyms: Change func signature for cleanup_symbol_name()

 arch/alpha/kernel/osf_sys.c                 |  2 +-
 arch/arm64/kvm/hyp/nvhe/Makefile            |  2 +-
 arch/arm64/kvm/hyp/nvhe/list_debug.c        |  8 ++-
 arch/um/drivers/mconsole_kern.c             |  4 +-
 arch/um/drivers/vector_user.c               |  4 +-
 arch/um/include/shared/user.h               |  1 -
 arch/um/os-Linux/umid.c                     |  6 +-
 arch/x86/kernel/paravirt.c                  |  8 ++-
 drivers/eisa/eisa-bus.c                     |  2 +-
 drivers/misc/lkdtm/bugs.c                   | 51 +++++++++++++++--
 drivers/soc/fsl/qe/qe.c                     |  4 +-
 include/linux/compiler_attributes.h         | 26 ++++-----
 include/linux/compiler_types.h              | 28 +++++++++
 include/linux/dm-verity-loadpin.h           |  2 +-
 include/linux/list.h                        | 89 +++++++++++++++++++++++++++--
 include/linux/nsproxy.h                     |  7 +--
 include/linux/seq_file.h                    |  7 ++-
 include/uapi/linux/stddef.h                 |  4 ++
 kernel/events/core.c                        |  6 +-
 kernel/kallsyms.c                           | 27 ++++-----
 kernel/kallsyms_selftest.c                  | 23 +-------
 kernel/nsproxy.c                            |  4 +-
 lib/Kconfig.debug                           | 21 +++----
 lib/Kconfig.ubsan                           | 10 +++-
 lib/Makefile                                |  2 +-
 lib/list_debug.c                            | 16 +++---
 scripts/gcc-plugins/gcc-common.h            |  4 ++
 security/Kconfig.hardening                  | 23 ++++++++
 security/integrity/ima/ima_policy.c         |  4 +-
 security/loadpin/loadpin.c                  |  3 +-
 tools/testing/selftests/kselftest_harness.h | 11 ++--
 31 files changed, 286 insertions(+), 123 deletions(-)

-- 
Kees Cook
