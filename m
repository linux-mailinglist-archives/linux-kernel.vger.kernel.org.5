Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F04760160
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjGXVlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjGXVlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:41:40 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682321725
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:41:37 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-187959a901eso9503717fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234896; x=1690839696;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=di6kLt4kiOi9HIX9Zl3sHUse4426YeJyuKx98IZXml0=;
        b=XtIW/CRQG/a2S+dulRamy2oy39hWWuUeRn3jzBN/nXaeaQg7XgTTa2V4KQSUfPbRyx
         t2O/j51RsEG6yxNYtCP+BCaIgXB3+Yj1xsYx59DeKkWZIH79/1fvw1LC+cmQHW6ZCS1G
         Z7RDZaO33EyTkdfCmTlDVif4hg8Fm0sQGfyN/6tyqNPoX/1Uc8xXRYWF6ctZtSL3Jj7N
         Myn3gsEzNQRQgpDIZPRbOSOdC8RwMB8yPKsfQutDgvfgbQsfjDvJSHykLuWtYC1TEHpu
         8wKOZ4DdVJFousIR1UROB5GkxfTg5CDGsYDiISI5cu8DNzBtj0vmeM9NcHPHLn/TuvuC
         kC/g==
X-Gm-Message-State: ABy/qLbbEmnI1Cdc/JmvqfYuXlnAK8XlvCnOiXnyk4MucmHlEC2FWiWH
        38EZZd++oaO5mhGBE+VxnrG1VOrZAVFTMd+kicfYMpQB+xN4
X-Google-Smtp-Source: APBJJlEHgKxbiRqzAo1p5ExJxSaFpMdx4xL8bTDt7lWT7iVoKpAvcWJPdTYgcDdzSeBNd2JY6Wg309G2oeLjLyHxKN+KQCnnhWMe
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c7af:b0:1bb:470c:901c with SMTP id
 dy47-20020a056870c7af00b001bb470c901cmr7990684oab.7.1690234896203; Mon, 24
 Jul 2023 14:41:36 -0700 (PDT)
Date:   Mon, 24 Jul 2023 14:41:36 -0700
In-Reply-To: <ZL7fogwmV+JJcrVN@bombadil.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009347d50601427a92@google.com>
Subject: Re: [syzbot] [modules?] general protection fault in sys_finit_module
From:   syzbot <syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com>
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com

Tested on:

commit:         910e230d samples/hw_breakpoint: Fix kernel BUG 'invali..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=156bed06a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d182f762168e165e
dashboard link: https://syzkaller.appspot.com/bug?extid=9e4e94a2689427009d35
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
