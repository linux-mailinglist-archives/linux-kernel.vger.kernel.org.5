Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E877F7658
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjKXOaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjKXOaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:30:00 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA6619A2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:30:07 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5bd0c909c50so2007422a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:30:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700836206; x=1701441006;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XmlYxFX8Lvp4eVsNiTQXfk92Tw++VYQTInnvw7OtykI=;
        b=CS2c9s49QuWuN7XQtZabzqVzccqfHRGiurmyjklD2VNsom6MIFhmdJru856BZwgNM1
         A4vSlQ5js66D6cPffG0omoV3GMcJwNGYMWKDLKAk3aiW9AEU11dRsrV1wm0+7QcZnJNu
         i5jvGqWviXVOuanCgfB5GiENt/kqWVEDuZXSnlalSnQVFWDJc8m5oFSm8Ud7SKIvV2Yd
         RHFmtGDB5IkUpqwi3dnbuXK4cVeL/qcKwy3317G342lgW79/1bd97GVsHSM/AC0M7HDz
         li+grhhGOLUfE3cP+f44hKHQmSrwg4anZxduXVC6fMfIW2h+21tUbgMF5zyo8i2+cdbG
         DOrQ==
X-Gm-Message-State: AOJu0YxdvgVqSWAJq9uk8hIkVFDx76fKi1x5zspATWUKTbgHD96p+X0W
        xANNFgjcSYEEwv40UJnDO5P1zAJ/N0MwBajsP1N0sg6ceYka
X-Google-Smtp-Source: AGHT+IEHRaK+tB+XKcsGSRVx1JJ6EsTQX0fMR9MKKQbApUJmorZBfK+3yhwBYsS27hljCN4lT6uLw4CcgZV0HnAqbB6bBDLh9lnW
MIME-Version: 1.0
X-Received: by 2002:a63:9044:0:b0:5c2:e13:3267 with SMTP id
 a65-20020a639044000000b005c20e133267mr409640pge.4.1700836206511; Fri, 24 Nov
 2023 06:30:06 -0800 (PST)
Date:   Fri, 24 Nov 2023 06:30:06 -0800
In-Reply-To: <tencent_47C9842EF3AED1CC8927C046F412C5066506@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e90c8b060ae6c95c@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer
From:   syzbot <syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com

Tested on:

commit:         037266a5 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12c1e294e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af04b7c4d36966d8
dashboard link: https://syzkaller.appspot.com/bug?extid=c5b339d16ffa61fd512d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1450c3af680000

Note: testing is done by a robot and is best-effort only.
