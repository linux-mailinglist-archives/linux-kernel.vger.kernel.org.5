Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E1D7F37E4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjKUVNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjKUVNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:13:19 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEA31AC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:13:15 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc2786a8ebso87364365ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700601195; x=1701205995;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZWvcvFWT3P94ESec92OyEYUrt6Ss1wkXtTKq4rDYxM=;
        b=mN9t3kxsVYTzjcKuI62ouPQoX5i8fmp8ogpF/ESQ8gxLKc3DQKmj0nSELFk+W5UMGP
         DY0wiIYqiShX14qdQY3FCK89kUsJFtuxLdLVbmYbLDdUwI2ql3Pgd7YLGoOBfnhmeeLP
         AOGkUobsOHkBbxarIQfvaR+DmmsYLwzEamajgh//2bmuHAuhiSNwZMJshj121f6Pc5L4
         TBn6ENTOeiZlrumgMkacMGWpUXDhZXR8Amnjf0a/nmTWmBUNVE66Bx2qdVieS7db/DO7
         yJcwYZF2eDm6BLwacM6HlexwHf+lW6A6OvGyCLX447iAcWcsYHNrRv/myod2x8Biq9Qq
         JRTg==
X-Gm-Message-State: AOJu0YzmEF0Zb6+qA5arYSIqu41ThWs5pwL2neQGr0yKLq2JBtjcBOBe
        MBao1M6hIdRXRckp41ZMJ2WPDtUblFKqEpHX/uEo5hSBjwY8
X-Google-Smtp-Source: AGHT+IHM9W+C7Oq0Uv4PwRYXwS33JJ9uK/HjdaAoEujXz7jU6ukhsoO+N83LgpXYrU44Q8AnLhnEdLDIby2oGWjGRHsGykut9M7s
MIME-Version: 1.0
X-Received: by 2002:a17:902:f688:b0:1cc:fd93:ab34 with SMTP id
 l8-20020a170902f68800b001ccfd93ab34mr79222plg.1.1700601195534; Tue, 21 Nov
 2023 13:13:15 -0800 (PST)
Date:   Tue, 21 Nov 2023 13:13:15 -0800
In-Reply-To: <0000000000003ee3610599d20096@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a1fec060ab0120c@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __media_entity_remove_links
From:   syzbot <syzbot+0b0095300dfeb8a83dc8@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, nogikh@google.com,
        sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
