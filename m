Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3197F3A81
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjKUX5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbjKUX5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:57:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F13B9F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:57:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122A9C433C7;
        Tue, 21 Nov 2023 23:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700611028;
        bh=Rwo3rb9FrObkYkqTOlrM9PJnnIJ4v/wPUUpJ/QCrqsw=;
        h=From:To:Cc:Subject:Date:From;
        b=ljU9aCwQ99rUy1H4h3zN9d9GGGiQwxYkjTDWNNVPe410topjEwcfutPVykdAHuxn3
         DAG4He9/jzlxArtFOXwJckOpMsIw1RlD/2d2zdfjU/N1IhxP+GtOuJOZ3kpV4qAA6O
         2tkyn5De1OxxwPFizzcfZTk1MnBm4iWSARnflyH8Uv28fzPzQM1HER+M65HFVcQoh8
         395j7u4lY5T7zv+sdVT/VF+roZf9cxoiptGyZed/778H41IfFbRCbfXO0mKyt7yMYB
         Yb38qKNct5dDnmWrS+I793LNHNvnzVll7hBlzXtYKa6pZRHv+zbLQTlr0paHGM2FCw
         2DGnDSOTV6QAg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] x86: vdso: clean up vdso Makefile
Date:   Wed, 22 Nov 2023 08:56:57 +0900
Message-Id: <20231121235701.239606-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Masahiro Yamada (4):
  x86: vdso: consolidate targets and clean-files
  x86: vdso: simplify obj-y addition
  x86: vdso: use $(addprefix ) instead of $(foreach )
  x86: vdso: use CONFIG_COMPAT_32 to specify vdso32

 arch/x86/Makefile            |  3 +--
 arch/x86/entry/vdso/Makefile | 28 +++++++---------------------
 2 files changed, 8 insertions(+), 23 deletions(-)

-- 
2.40.1

