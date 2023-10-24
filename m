Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851987D5CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344268AbjJXVLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjJXVLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:11:42 -0400
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD1C10CE
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:11:40 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-581e2c9197bso6870264eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698181899; x=1698786699;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZWvcvFWT3P94ESec92OyEYUrt6Ss1wkXtTKq4rDYxM=;
        b=AuaJChwAqGLkvd3l774a88pBENGuhVV7sM8r0r4tZceXytjG4CwzpVvYQNeXEyXrjt
         ZNXEXglDsem6z3+718c3+8KMbxdlPFBTyXZuBAGpG0Z6gZqb7LTCaZ/VMNlYd0hO/McD
         TM40oHoXChHXeCfxvA8Wk44kd8P6XwL1PQNI8xpgDEkVrAMg05p5Ua1Pad65ju9mskqt
         7nzWUdlUk7xFXPJml3t2Gz4+3tJla13VPNKeL6EDmVb6/7mMVZ6fAwlLtjNft9J73N+7
         c14Iv9qZISH3WtBjC6X4Bvu1azA6JinsRzOWQwnkDwGCS8FlsHeBEOgfaENeoSylxABO
         TBqA==
X-Gm-Message-State: AOJu0YzDm1OOMrZ1ssLzsgYBi3lx+6dZQ7QpZ7msViaJE7550dF77+Ut
        sCMQMTXL4/15QjdVd9fRGrlh1pCCVei2piCAUfc65gFne7Bd
X-Google-Smtp-Source: AGHT+IFIGdjAGzKoTrnYimPKPHmDG1kjuJTZCw+8fwLQZBt4HO+eQF/KgxqQt+0nli6xsdzu/gL97sZ4XmiD0ErEiKHID+MmReGv
MIME-Version: 1.0
X-Received: by 2002:a4a:350f:0:b0:581:def4:738d with SMTP id
 l15-20020a4a350f000000b00581def4738dmr3989735ooa.0.1698181899638; Tue, 24 Oct
 2023 14:11:39 -0700 (PDT)
Date:   Tue, 24 Oct 2023 14:11:39 -0700
In-Reply-To: <0000000000003ee3610599d20096@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e45f1006087cc8ea@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __media_entity_remove_links
From:   syzbot <syzbot+0b0095300dfeb8a83dc8@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, nogikh@google.com,
        sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
media: uvcvideo: Avoid cyclic entity chains due to malformed USB descriptors

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=0b0095300dfeb8a83dc8

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
