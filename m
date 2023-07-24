Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51BC76001D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGXT4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGXT4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:56:35 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274D410CB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:56:34 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1bb493c6ee1so3657207fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690228593; x=1690833393;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0HbIfON9h7OtlOqGplVgAJ/Ron1dfOFrue7VmqDYzg=;
        b=HviviiH8QHCDN80a9CLD0kduVyC4tgyhY3qu4cFaYywgUxSeRWx6sseZ/nojaMNO+/
         xh1WqAVsKkGydcvBAIX0KRXUdbpPWwSJ7+y07RKjdl1YcolxoBXnDSItRWb1KkRVYQP8
         b81h5xbfxs6nKTRQI+hnw2mucmybL2je9nJz7YPtTE+i/USrL3aRsDQ2wQdofuDFhXrE
         7DZB6KHQwb1tg6QWtGojCmGSfp8XbXcMNm/RrJxI+0V4LM6sNJz++Di1Jx9qhBkdLKuf
         0Dh9FICbG84GVMKuJE9ITLrogYF/UFQ1ym7vBypmZPWTJzucyzpjiN0kd9MO7L8XUV+S
         W4rQ==
X-Gm-Message-State: ABy/qLbsivdeIzXPwMw4/wJS0zBS9QVsnffkCq3CpdfMaiSs9rDFTPcC
        YGZv3bBGfi95CuEaLoc/7pqGFMZtA8Dh8ifcyRi9dIOWXuua
X-Google-Smtp-Source: APBJJlGy8FHZDVrssAfEDgGHScfjKPZjYZWznrOxt65Wocsqqyr5rTphmuoPNIEOMBE7bKR1W0V4AWAMQMX5N468FTXqgMvgSHHN
MIME-Version: 1.0
X-Received: by 2002:a05:6870:955e:b0:1bb:51ab:a7bc with SMTP id
 v30-20020a056870955e00b001bb51aba7bcmr7056676oal.1.1690228593534; Mon, 24 Jul
 2023 12:56:33 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:56:33 -0700
In-Reply-To: <ZL7Una9vhJpX+dkb@bombadil.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e82d5806014102a7@google.com>
Subject: Re: [syzbot] [modules?] KASAN: invalid-access Read in init_module_from_file
From:   syzbot <syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com>
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
dashboard link: https://syzkaller.appspot.com/bug?extid=e3705186451a87fd93b8
compiler:       

Note: no patches were applied.
