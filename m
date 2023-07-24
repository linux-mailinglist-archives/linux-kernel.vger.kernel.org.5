Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE26675FFE8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGXTob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGXTo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:44:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E810170E;
        Mon, 24 Jul 2023 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ijMl1Cv9y9enj5ovf4v4qSeTqopWOU/OBedk6+5VrX0=; b=YyikBxOqP4IJ1kWID/9hDC8NVf
        zOz/gVRaTSMkAGC4NSWDNH3v/k6lQMVblxGnrLI+U+XTZkdxMXporuJykIHv5VMrWBKzB6hbbAM8f
        oS9M2AVyyV4K2w/Nmo/6FdGvG1rRvvT0HfAxOc3djXxUrjKf3G68o9izAbb/dZoij7msSPx51SkFk
        8zuAvzqLb6LqIgc+ZlxDYKN1Wr0pA3XD4FMPy8HZ9kib03KSz59iL2jEYhvDrba1B36HdOwAiY+sE
        naOgOJIHgkxWogEFf8mrT7zKmGNAKy6bnEFRduUydeNJqfSiVLmgQls4RJhRH/zQCy81jYAZHUz9W
        PRsXugNg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qO1Tp-005JrW-0J;
        Mon, 24 Jul 2023 19:44:29 +0000
Date:   Mon, 24 Jul 2023 12:44:29 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     syzbot <syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com>
Cc:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [modules?] KASAN: invalid-access Read in
 init_module_from_file
Message-ID: <ZL7Una9vhJpX+dkb@bombadil.infradead.org>
References: <0000000000000e4cc105ff68937b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000e4cc105ff68937b@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6
