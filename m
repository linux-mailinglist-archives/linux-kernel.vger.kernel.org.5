Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27CB8132EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573455AbjLNOU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573448AbjLNOU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:20:57 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A9611B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:21:04 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2865681dcb4so5955274a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702563664; x=1703168464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGeLGltwXN3vwmV5KtDW0blU4ZwQ5RWvUp+fn2t50nA=;
        b=pQcNDxKIaC9ixQJ8J4Pf2FxpBzco3IbJW9W7AvF/t2aR0ibjoj6ZqU60fFEgecv62Y
         RuRFnEMGdFV0T5QmMmmkeLeRqQFhDAZjlLEEFyfTNK6CaCuzf8iq/GAtM1XW9RpTCmA5
         cph701AcjnP8QTCsHmzPDFbaOgdFAxkrv+PH8OwWDe6hkzB5QCLITAKoXJhfIrVkTX9A
         Cizm/U+nsgFYYDApeGN+M6ZXHKORkhc1dzx9IDlB8yEvjcoEz1g7CXxsXnQAGg5nZwb3
         HLk0aDbJtFXzostMkPbhrGPuj+vfYYBtJGJ7qco9jRK0bRQANWx5b0DRGG4E2r1L1Pag
         gn9g==
X-Gm-Message-State: AOJu0YwK7u4XEe4dnI74NJmi4jMoUxJqxiLmqjqKQNADbPloT5t/WZJP
        Sr8vIIblUCI5JfqvGjn+cijSw7BFk/d3VncfO5CJVEjGGyln
X-Google-Smtp-Source: AGHT+IEIwiUsN41eHnoXe/vwLLM7mrYri+zxMCU75XK36imZsdkm+T2QdGIawCHtPaPGROyTz97hTbO6s1SSd/QQFeD5OJ4TMXZa
MIME-Version: 1.0
X-Received: by 2002:a17:902:e74e:b0:1d0:a6c4:e2bc with SMTP id
 p14-20020a170902e74e00b001d0a6c4e2bcmr1392921plf.7.1702563663885; Thu, 14 Dec
 2023 06:21:03 -0800 (PST)
Date:   Thu, 14 Dec 2023 06:21:03 -0800
In-Reply-To: <tencent_1ABB7A33479EB71B484B311B402575BA2008@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064bfe4060c78fed4@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dns_resolver_preparse
From:   syzbot <syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
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

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com

Tested on:

commit:         48e8992e Add linux-next specific files for 20231213
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12c0cb2ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978b8aaa2e92a8f
dashboard link: https://syzkaller.appspot.com/bug?extid=94bbb75204a05da3d89f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=149ece7ce80000

Note: testing is done by a robot and is best-effort only.
