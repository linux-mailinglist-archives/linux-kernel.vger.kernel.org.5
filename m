Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4E0765BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjG0TRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjG0TRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:17:32 -0400
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9B22D47
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:17:31 -0700 (PDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-56364632e59so2033047eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690485451; x=1691090251;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2dqufUBrl0nII8I3NVvP+WLtgUK63Uk2N1boEclcrU=;
        b=Sl0/fVN1Co8JPlaIzIQlXSXi92RYZUCtbf3syokvv5G/OMuO9Oge7cYCJn2Kgr5RaJ
         vgQsXPCENCQR0XMWLibiV+RiFN4kkg1vZ5Aw/Wx/M4IOrTG08EVeUrY5VFeTuet/cDYt
         0u7iCVC27KQMmEmFN73rHfG13OkWXzzHARW9sf6DwmM0Al5Q9xMsHdUnqgsC9GOpwQ+T
         Da0MwZ3I5WyzvfEuHAnFT3pOeT3CYtGlBrV7EfNikC+tTozEjBIDf6I7/zZK70vcSpjF
         oJnSvs+LLgwXIOO73pklG0mIA/oHKsH7Ciq4QJOgxyBFqLqRVJbLFK/48NpFfjx0gOGJ
         GnRQ==
X-Gm-Message-State: ABy/qLZe9eAA/A+vzDH++BIZB0m6Zs7Rutdf5x5lGMsNvFM6ivX3F7IS
        Zdp7pLBQH65T4tTja3aKWUFCs9uDPlh9D4W9P7YzVM2Ejfqv
X-Google-Smtp-Source: APBJJlHur4MTMyzIC95Y6ZbewE77IEcyMJMUsWQayds7pvG1vnxcf9jj2rW/DpRUL1iDdeff0EGjafaYWPJwxRrNNXoR69H6Lg4I
MIME-Version: 1.0
X-Received: by 2002:a05:6808:13c2:b0:39e:9757:6263 with SMTP id
 d2-20020a05680813c200b0039e97576263mr303822oiw.0.1690485450895; Thu, 27 Jul
 2023 12:17:30 -0700 (PDT)
Date:   Thu, 27 Jul 2023 12:17:30 -0700
In-Reply-To: <ZMK91N6V245iS1qu@casper.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc767006017cd057@google.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
From:   syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, liam.howlett@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com

Tested on:

commit:         451cc82b Add linux-next specific files for 20230727
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next next-20230727
console output: https://syzkaller.appspot.com/x/log.txt?x=120b5655a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e0802de3cfc61f
dashboard link: https://syzkaller.appspot.com/bug?extid=8645fe63c4d22c8d27b8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12145a36a80000

Note: testing is done by a robot and is best-effort only.
