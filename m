Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3832E754D66
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 07:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjGPFXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 01:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGPFXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 01:23:43 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FE31BF3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 22:23:41 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1b0271d3228so5438950fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 22:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689485021; x=1692077021;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeyaJBQonYES2sPjVYfvUnHi8qOjn4ED2xJMnJTBG5g=;
        b=D5iIsxq10YraXfll0WTn5mlBMBv8VL7lx4HlP+KNvFSn9bVZVKynm2RH3PUmhfL8dG
         N63GYTU+u7STQgWVSwvWdiTZXGX0IzjhY/7Tp4xq5fbVMgGPiHRV0E+o3YzP5dPmsF2b
         WsnjfqseJMXWk5y+BPKAEjw7/tf3MPrb3AuK7JCO9/FOhp7FiXD+G0XZWDQHk+hZMaXX
         dMOY4CK4pnFpPHnHBcNsZqElfZwPZV8fzDmyQ5Um+I1vwTmuU10wXx9rMPfxUlCneTcj
         LJ6rY55UFBHZ6Oj4owEYICNAzvJhiezrAvmQk6405S4eToDUWkiyed2OsmjrjJ9OPgqw
         NgRQ==
X-Gm-Message-State: ABy/qLZa+XCu+cl2l0k9Jg1WY1dxJrj9R1HGmhGAfSbaJEnofgl/HDgz
        0pGcbP24ibiURsYtN9P/iOjYJf07hcdfYh7JMODhszWQMID0
X-Google-Smtp-Source: APBJJlHi1MeQzR0RABLgkp5ZFmYHz4jN5HuYy/iD+uE9vy23aub8o2eqrp9YfAqNgYnd9jLCSZnbjn2bgifswmuNs2+4ovKfsNM0
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1a8f:b0:1ba:5942:14cd with SMTP id
 ef15-20020a0568701a8f00b001ba594214cdmr3202137oab.10.1689485020990; Sat, 15
 Jul 2023 22:23:40 -0700 (PDT)
Date:   Sat, 15 Jul 2023 22:23:40 -0700
In-Reply-To: <00000000000055cd8405f84c5386@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000879078060093e2d8@google.com>
Subject: Re: [syzbot] WARNING in class_register
From:   syzbot <syzbot+ca3d9f693dfa69f61371@syzkaller.appspotmail.com>
To:     dvyukov@google.com, gregkh@linuxfoundation.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
driver core: class : fix slab-use-after-free Read in class_register()

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=ca3d9f693dfa69f61371

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos
