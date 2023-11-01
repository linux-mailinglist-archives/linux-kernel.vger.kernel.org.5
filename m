Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B2A7DE72A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348070AbjKAUNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347762AbjKAUNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:13:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2786D11D;
        Wed,  1 Nov 2023 13:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=9GbIiVVmtxjeLQGfLovljVUMJ+L+zaLMrxPAsch8AJA=; b=AXVpfN3jrYeH9Mrr/XwXJGquAG
        vy/vZBAdO/ww8EX58LdE2uPSYEyjEMRLF3k81mSvrvYAyY6ejODqYbCC/uYhvbGVmLUx74gnmiyJm
        TMKft+OtD6Fb9EVoPv9A8mhQPMN+NDkrTEEGbA4qiOWlEw3PhqGhFOmiDOqE78+4ssukmZmESgFSt
        zMPzjEugUTcIRK7XwiSwyBFBsblvmgO8LkoUBM4/NVHhlUc0d4LZTu4uaTqO28zL8liQwFMPDh3ce
        fLHMk32dOTXJOUB2dn254fE24QMaRpqOGJj0Y7ygQuObKqqPD57uesqkTWr9F7DxgWxSRY1KulIDe
        YnQrkHXA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qyHaJ-0084wC-16;
        Wed, 01 Nov 2023 20:13:03 +0000
Date:   Wed, 1 Nov 2023 13:13:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-modules@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        andrea.righi@canonical.com, keescook@chromium.org,
        zhumao001@208suo.com, yangtiezhu@loongson.cn, ojeda@kernel.org
Subject: [GIT PULL] Modules changes for v6.7-rc1
Message-ID: <ZUKxT1CL9/0Dn6NE@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7d461b291e65938f15f56fe58da2303b07578a76:

  Merge tag 'drm-next-2023-10-31-1' of git://anongit.freedesktop.org/drm/drm (2023-11-01 06:28:35 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.7-rc1

for you to fetch changes up to ea0b0bcef4917a2640ecc100c768b8e785784834:

  module: Annotate struct module_notes_attrs with __counted_by (2023-11-01 13:07:32 -0700)

----------------------------------------------------------------
Modules changes for v6.7-rc1

The only thing worth highligthing is that gzip moves to use vmalloc() instead of
kmalloc just as we had a fix for this for zstd on v6.6-rc1. The rest is regular
house keeping, keeping things neat, tidy, and boring.

Oh and this has been on linux-next for over a month.

----------------------------------------------------------------
Andrea Righi (1):
      module/decompress: use vmalloc() for gzip decompression workspace

Kees Cook (2):
      module: Clarify documentation of module_param_call()
      module: Annotate struct module_notes_attrs with __counted_by

Luis Chamberlain (1):
      MAINTAINERS: add include/linux/module*.h to modules

Tiezhu Yang (2):
      module: Make is_mapping_symbol() return bool
      module: Make is_valid_name() return bool

Zhu Mao (1):
      module: Fix comment typo

 MAINTAINERS                   | 2 +-
 include/linux/module_symbol.h | 2 +-
 include/linux/moduleparam.h   | 6 +++++-
 kernel/module/decompress.c    | 4 ++--
 kernel/module/stats.c         | 2 +-
 kernel/module/sysfs.c         | 2 +-
 scripts/mod/modpost.c         | 4 ++--
 7 files changed, 13 insertions(+), 9 deletions(-)
