Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D9080B923
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 06:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjLJFjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 00:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjLJFjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 00:39:02 -0500
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC8DF3
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 21:39:08 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1fb36840642so5892822fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 21:39:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702186748; x=1702791548;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9O9GjUJQ/avf7U+KfjX1DdOjomsqOUGB126nSngaWg0=;
        b=RwTF0PJItSLpiQ2nSLc4VV/myuu+pAiqkDsumoifC3guj9szRyL6RFoBIr6bskQpUX
         qjhL9FXq+QHphQaNTf20dMMqYxooOs8n0asgyZjAsqPGkr4UvOskUCg8va1GY822ao2f
         PdbTC2ZFyjirvxRsoChSePyC2XS7imOcHl0Yk5b6yLdxQfK3VjAz/3nTH9OlKCbucz9C
         m6R/Krjb1A2Z3g4uxt24KvEUqh5zfGMbj8n1/A3qR8adzWEe2CXHLP2mQggAnns0FHsl
         xK3Tvxn6RSdqqkuh7hY5/CiN2UdydB5g56lwWPeTDOpMjz+nmzVcOp030fWu63GIu6AO
         uEYA==
X-Gm-Message-State: AOJu0YxSju1YIKWLibWUxWGHYCUb87zTqy9w9SVYkolDnerVTU76wL7T
        YmePaIrS1PR+WBmWKinGhwq/RFbFfWEZ6jeWA6pWNstr9ljD
X-Google-Smtp-Source: AGHT+IFLfgjL9sjx6ayojkyPi+knAHBAldOrtx0ok28Sgu9AnvnbbTBie8P+fWfvZbqjdATuN9gxtOm129QsQUXy0sIG9npWhnzH
MIME-Version: 1.0
X-Received: by 2002:a05:6871:401:b0:1fa:a6c9:882d with SMTP id
 d1-20020a056871040100b001faa6c9882dmr2923076oag.2.1702186748025; Sat, 09 Dec
 2023 21:39:08 -0800 (PST)
Date:   Sat, 09 Dec 2023 21:39:07 -0800
In-Reply-To: <tencent_9CCF8C7BE26EA02CF16DE894A8E88EEDA60A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075224d060c213cf3@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert (2)
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+006987d1be3586e13555@syzkaller.appspotmail.com

Tested on:

commit:         33cc938e Linux 6.7-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=113d92bce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37d1b8bb20150e6
dashboard link: https://syzkaller.appspot.com/bug?extid=006987d1be3586e13555
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11778c96e80000

Note: testing is done by a robot and is best-effort only.
