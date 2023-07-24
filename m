Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9D0760001
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjGXTrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjGXTrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:47:42 -0400
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869B8173D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:47:35 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-56768da274aso8182158eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690228054; x=1690832854;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpU/pq4NcXq5eoCMak+87h/qMFbXrT3YYZv+5M6Z810=;
        b=QlQo0ye1Zj7WsraKAxH3gsRLyMwBT8m9Q4WhDLy3HZiFGxQk/bWlmtD2QitMivNQR3
         6T/P0XhBawF/5PSVxCvqeJ+LVT+ekttZRjb7YBOp86SvU8DrhqbASzv8jhM1mSSC3esf
         gssjT5g3m6aR7R0H2WGM52HF5pR3h2P9Vy/rk3rxcPV0I5fjNKrr753zuQPMNtTFJzSv
         vxi9UZRSew+1eksYfMOT5VvM0jlNNs03X8je3nxkrneJjHqqBSN4xfgW+EH2XYFQAtQM
         23nqtQ/iXlE5i0NPSXyQ1FCfrn5EDzy0bEnXAQ0z47LRO6Vp76LiwG5+OUm77zaWXxZx
         W/vw==
X-Gm-Message-State: ABy/qLYXSmONjN/s7Qnk/sg9FB/lx5tVWHJ3m59GdwbebJL2p5nzWLAh
        XrvfRgvZipN7jODCcyVa/7BVOqpnaD6BdfGA1a5PHTShFazJ
X-Google-Smtp-Source: APBJJlFhOkXgA1GDXy6ZXZyeXWFwikYSsd/PZ9QEgWnWucvf96IBK7XT0JXjTa9x+AGx3ADzu3aYiG7whxxn3I6COqeIsSFrzEVO
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1211:b0:38d:ca0a:8e18 with SMTP id
 a17-20020a056808121100b0038dca0a8e18mr20908707oil.2.1690228054801; Mon, 24
 Jul 2023 12:47:34 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:47:34 -0700
In-Reply-To: <ZL7UedKQUDAUThHM@bombadil.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbc360060140e291@google.com>
Subject: Re: [syzbot] [modules?] WARNING in init_module_from_file
From:   syzbot <syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit 910e230d5f1bb72c54532e94fbb1705095c7bab6: failed to run ["git" "checkout" "910e230d5f1bb72c54532e94fbb1705095c7bab6"]: exit status 128
fatal: reference is not a tree: 910e230d5f1bb72c54532e94fbb1705095c7bab6



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6
dashboard link: https://syzkaller.appspot.com/bug?extid=9c2bdc9d24e4a7abe741
compiler:       
userspace arch: arm64

Note: no patches were applied.
