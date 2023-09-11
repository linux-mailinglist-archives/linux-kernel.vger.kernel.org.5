Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA8579A4F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjIKHtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjIKHtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:49:50 -0400
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387DF10F4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:49:07 -0700 (PDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-273983789adso4934136a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694418512; x=1695023312;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7onwYJCDf4TCoCeIrGGyufC4VT3xDL+RhkHJlsxI5hg=;
        b=B133/iTorUt4pgGUyLp5q96QSml5MBtYYnAoEoIDh44qmtj57QrsibvhrMi9xmBBeK
         X7N/dsfUX1fzpXmAIlTBlQBjVE+TKqC6QKRZwK0uScl12QJQ1ZdvVgZ9/Hka+/7oXBYB
         YZB3eF8ukR9VV+jvab1kE+m5R0j2lBS/jwjsgPgofitt5kiNExp7OfdB5PC1ktTmLFng
         XNmxjnNvfoSDzC2XtrykbMDMf+eOEHL2GrH3dvra5lPCOcDOUUqRuVoZLVd72jG96Ct/
         luPme1Ebq85EpDzqICEsI+LFKqPSOX2+bnxmwmtQgTITHeIWePZmaXu9YkJJUML8dtx8
         zFtQ==
X-Gm-Message-State: AOJu0YzOtWGwjPJo6u26YQnZlmqMOD6pqHvAWXAZluqEI5uGRuDXfQuW
        1MJN9Oxn9bStRuQy8PJuIe+W2QFkRwwihLcsl/bbYZZStyP2
X-Google-Smtp-Source: AGHT+IHep8Jf4TiKwVMBDkYtyrIVUjzUnF77wQE2b8kkpSYIDm376zKuP2qFz24afYJezPRIYfijo+zGifvf/qLo0innZNYG2ivG
MIME-Version: 1.0
X-Received: by 2002:a17:90a:9285:b0:26d:68ca:439f with SMTP id
 n5-20020a17090a928500b0026d68ca439fmr2366015pjo.7.1694418512521; Mon, 11 Sep
 2023 00:48:32 -0700 (PDT)
Date:   Mon, 11 Sep 2023 00:48:32 -0700
In-Reply-To: <0465d13d-83b6-163d-438d-065d03e9ba76@intel.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a2f3a0605108d8c@google.com>
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
From:   syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, fengwei.yin@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com

Tested on:

commit:         0bb80ecc Linux 6.6-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174c0ad8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13f2a37749f07ab2
dashboard link: https://syzkaller.appspot.com/bug?extid=55cc72f8cc3a549119df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1421990c680000

Note: testing is done by a robot and is best-effort only.
