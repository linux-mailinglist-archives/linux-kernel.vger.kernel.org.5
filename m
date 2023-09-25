Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8867AD7AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjIYMHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjIYMG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:06:58 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FC6E59
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:06:27 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1dc05fc88a2so14998701fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695643586; x=1696248386;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fg+tsNjDuEyZ/9uFMYbvzRaBPNHZA71lCD3yPGIjXY=;
        b=rPeacqymPLbrvYCrrbyAUoYeLV7QLgZ8R6lPyuKsxjK0oEye/6Qz9fmhCbh8A/PzBc
         Ftbz+wDnkwpdVN7J3GGW5s0Pr4TyuRaEi9TRdaLEOuPl+iYnG9J/DJkZrN1Zktt6crfq
         SO+C4udA+/6aOyEKUcU6abf/JNvI4g88/RdqfAwdRYvd2FV0YO5yVsv/77B2HdByxPf0
         ToyTA1M9ZRA92qaFvf7Rr4lSTe6v3EYLGmC9PxAbAkNw0HTz3rQ9/nOhky/Dp59y/46J
         iHYQV75I8imgle0lGK+YGY1Al5HLpbOH4Mpq2GFbAusvMz2WsOeFJ3rIzP6DZu8MGIXR
         iQ3w==
X-Gm-Message-State: AOJu0YwdpfNlxna+TDvU4pJm+fwYxrwQrm0qMNXhQu9Ki7/cwImU4dF7
        nnMLQspIgAcbIQWMTEybmohvEzZwc8edl3GFv/i8sQCXdMoU
X-Google-Smtp-Source: AGHT+IF2SMHO7b93Gnk2dXlntDN5zaOyf5ekmIDkIQ8cuBQwA4zRPKDDk0ttwXMtCOru8Ye12tc1zED+jY/8uSc9eiasAq63utcn
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a899:b0:1dc:27f6:79df with SMTP id
 eb25-20020a056870a89900b001dc27f679dfmr3131832oab.2.1695643586612; Mon, 25
 Sep 2023 05:06:26 -0700 (PDT)
Date:   Mon, 25 Sep 2023 05:06:26 -0700
In-Reply-To: <20230925114446.1081-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a559aa06062dc990@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in hci_dev_do_close
From:   syzbot <syzbot+4e3a76c5c505a3f49083@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+4e3a76c5c505a3f49083@syzkaller.appspotmail.com

Tested on:

commit:         940fcc18 Add linux-next specific files for 20230921
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17524612680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f140ae6e669ac24
dashboard link: https://syzkaller.appspot.com/bug?extid=4e3a76c5c505a3f49083
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c855c1680000

Note: testing is done by a robot and is best-effort only.
