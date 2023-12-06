Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5A6806E37
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377729AbjLFLkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377766AbjLFLkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:40:12 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E8F12B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:40:17 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b83ce0d549so8629500b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701862816; x=1702467616;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZWvcvFWT3P94ESec92OyEYUrt6Ss1wkXtTKq4rDYxM=;
        b=I+0mNDEKKOEkDZU5+xiWiwfDtaM6nqEhx/PwXDbDIbtgn8JdNH9zf7pGXQ6p6c6EtX
         WzGeW+CoOZhwqWXsCN689hbXYJfplNAvRTN+Mld1wtOKpyRdffmzeb3QKItDg+yztn8u
         FmgQaqbWofoDp0yBQ535duxBXY9Z5geREVYhv57g3GxsRxr40lLFOicDsj4v5VpXS9yE
         AhpHHu4kVmygukhKK2ELgGEqEHleakN3ChtEqcWpEI3ZhvF2PXuEwB0T0JUDL5cateDz
         kTuKFSO0XG+s9poI9D1wJsD3UJKN0ZyikysZE9UmZI/y8OrwVLeeDRsSfaOyYvXt6veA
         d4mQ==
X-Gm-Message-State: AOJu0YzNbmruoBZK7v5BmVe+t/1vut1tD7nsYHpFTpt9zjfr/r3ldGW4
        3Lj9vJyBxPluawET4rwt9jA2q25Ph4T0ekQZsc3WUgSSMIaG
X-Google-Smtp-Source: AGHT+IF30lSMDndHoVg2hQdtUmnxotgzo3as2Lm5GYCQztnzYfAogJgPNYAHJk6lB9qUllZmbMV+u1ITI60NV8NBZ7PXTC2KMXoQ
MIME-Version: 1.0
X-Received: by 2002:a05:6808:158e:b0:3b5:6a59:abb7 with SMTP id
 t14-20020a056808158e00b003b56a59abb7mr793260oiw.6.1701862816633; Wed, 06 Dec
 2023 03:40:16 -0800 (PST)
Date:   Wed, 06 Dec 2023 03:40:16 -0800
In-Reply-To: <0000000000003ee3610599d20096@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a45bc3060bd5d08f@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __media_entity_remove_links
From:   syzbot <syzbot+0b0095300dfeb8a83dc8@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, nogikh@google.com,
        sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
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
