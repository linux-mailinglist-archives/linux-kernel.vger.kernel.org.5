Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EEF7CEB1A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjJRWVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJRWVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:21:38 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDE1114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:21:36 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ccedabb330so4722396a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697667696; x=1698272496;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3EPpHXTERq+D2JCxH5Po5ARyBy/ijqQRwM7V/k2tt8=;
        b=YtLjNxMF8vZm93XfzgMNf+nwUW9YNFFHtip4bl4qqkZnoUBaCy9HGThGT6YZ8eV8Ph
         LwWt7/X00d5zaw1PfboI+LE5Sii2pUC1jUqUdigShS+B9n2XM0UnN21fZeOaRv6rL3H+
         Dd7Mznq1ss914evlPunxG0/vxG0+Z5gSCYgQRPyCatVpZp5gS2Qmx1IIDx4s720R4uV7
         HyfL1JrZTQoM1yjIJHh4OxsBFVmlW8uOZoM4Puh8HKIR8TH7zrB0nL4oAih2XPE02HEn
         L5Lijux4uGeMkNrbJeyEnFI0bM2ypf12XkEVN//QGcbs95E+6q99jGIiBd7Uuv4wQOjd
         5wuA==
X-Gm-Message-State: AOJu0Ywn3b4RhCK8RHGuB/JGuaa2IV6esAF2fdYSUzwt9wrOsZTBAWev
        C2u1bHVEHsCsQP59Yh5nsnSKxD3NWrJl7g0ae/jYjf0HCNMz
X-Google-Smtp-Source: AGHT+IGEaGVuNuTersxZpbZ/i3hlLMkeGBtI/luOSEuaqEob9pquLVHBO68Qfh424vjT4D0DpFszoSL+jHEx7PRhCI+QsmSlhxZ2
MIME-Version: 1.0
X-Received: by 2002:a9d:7a93:0:b0:6cd:9d4:fd63 with SMTP id
 l19-20020a9d7a93000000b006cd09d4fd63mr180198otn.6.1697667696259; Wed, 18 Oct
 2023 15:21:36 -0700 (PDT)
Date:   Wed, 18 Oct 2023 15:21:36 -0700
In-Reply-To: <CAOzc2pxr_Lzgbv-ddvifVdcOrA0X-2Y8Zz+WHjFWAuGu_CdZnA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb7b260608050f04@google.com>
Subject: Re: [syzbot] [mm?] [fs?] general protection fault in folio_flags
From:   syzbot <syzbot+1e2648076cadf48ad9a1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vishal.moola@gmail.com
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

Reported-and-tested-by: syzbot+1e2648076cadf48ad9a1@syzkaller.appspotmail.com

Tested on:

commit:         34d60af8 syz-fix
git tree:       https://github.com/VMoola/kernel.git
console output: https://syzkaller.appspot.com/x/log.txt?x=146e70f5680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4894cf58531f
dashboard link: https://syzkaller.appspot.com/bug?extid=1e2648076cadf48ad9a1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
