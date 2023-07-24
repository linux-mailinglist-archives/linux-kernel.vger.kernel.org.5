Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265CA760089
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 22:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjGXUbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 16:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjGXUbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 16:31:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8931737;
        Mon, 24 Jul 2023 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cZPnreDr2P2h/GQ+L4OSlct8mt5KXo29iB8a2WGbwWE=; b=PFnas0yJuvH3kkkb0BYx8Li24b
        whAPm5P0txbFhDaRjAdDMs15anEl9uzkqz2eB4RlEb/LyDYyIhraZpwtmxLuZBO3DgXQ3yy8hO7U7
        B03Lrb7fpHDkoyO4JFHkazqP/CLpK7mYE4+qBHNKgM0E3OEKryK0h0j7X8Ne7msvMmSdn/HskwE3P
        KsiCaGf0gyYyLcDhoDrxtrEmfIOpYQBV8dflfN84EYiuCiwnnt/hECZ4ag91kz/xQ0Ahg3TI/8qWL
        JfxXaEXy85I+Ni5hF+rLLanw4XKC+E0pEZWk4nRsyCNCvp8b9p3h7DpzTo7LkM4LDzMDfrdBT4F8+
        1+lU+9IA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qO2DK-005NsG-0t;
        Mon, 24 Jul 2023 20:31:30 +0000
Date:   Mon, 24 Jul 2023 13:31:30 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     syzbot <syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com>
Cc:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [modules?] general protection fault in sys_finit_module
Message-ID: <ZL7fogwmV+JJcrVN@bombadil.infradead.org>
References: <00000000000094ac8b05ffae2bf2@google.com>
 <ZL7U/V3SFaJndkhW@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL7U/V3SFaJndkhW@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6
