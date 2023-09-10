Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB1D799C77
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 05:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343526AbjIJDwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 23:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjIJDwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 23:52:42 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46BF19E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 20:52:38 -0700 (PDT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-68fb91577e1so192470b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 20:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694317958; x=1694922758;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIPs/h/5Rv2sf9Q4kdsaOE5qumqYd7X3O3BHiyy2z9o=;
        b=LEzbJ1GT6JHIFEn9+PY8rKzOvwVJBXhG6ChURRakgE+F3iZAI4x+fLXx17xOdwbHy5
         ZAL+wiWqldSbCXtN4uZdyRA/JqvHZnALnrAi63fiDx2/f2EaCxlLTXLS2ZpPUHOn4zC1
         l/z0NjEdw0waY/tYX29qxo1VBaMdImRRbh+GGRCbbavRVzGAsqZkhSOwduj2J3PC63xH
         Ipx8DQ3yxhFVN0k6o8tCw8trbt32nk3yREC+NlnGX5lrv5CrUksPMb/W0WlyXFi/fRGm
         SbOMtlGtjYVmtnuxfbjAZ1SgwWMFMx+QGnJShXNxnv75+Xx9CGxxWjq5AvMnKlSpe4pI
         M9AA==
X-Gm-Message-State: AOJu0Yx8YqNZZF/a5hC0/ZgmrAyUVaB+Qau7V/Qoivg4M4JKPK59aO0B
        FQPxDEuB08uQsKFTU4Y2KTzDaYu9GHaTPSEiJOCgxuqg3hbj
X-Google-Smtp-Source: AGHT+IFE8w9mzMYaJ4WNQA8PEiYFA1v0zr+aU4ciU5s8YSiU50CGyWKvpe7phw7QAGal3Zcj/lFcvhE7ropQlok3havLP9EVXTzG
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1388:b0:68c:8eac:65bc with SMTP id
 t8-20020a056a00138800b0068c8eac65bcmr2322185pfg.1.1694317958428; Sat, 09 Sep
 2023 20:52:38 -0700 (PDT)
Date:   Sat, 09 Sep 2023 20:52:38 -0700
In-Reply-To: <20230910031719.6205-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c7f5d0604f924b5@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in team_device_event
From:   syzbot <syzbot+44ae022028805f4600fc@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+44ae022028805f4600fc@syzkaller.appspotmail.com

Tested on:

commit:         f8fdd54e Merge branch 'sja1105-fixes'
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=112f3908680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=44ae022028805f4600fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14564e94680000

Note: testing is done by a robot and is best-effort only.
