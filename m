Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E16077F5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350498AbjHQMCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350487AbjHQMB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:01:28 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F442133
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:01:27 -0700 (PDT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1bbebf511abso92257975ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692273687; x=1692878487;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBf6PY/869q31Lz3aUHUNyMKO6fNHdycIEIQJfeT+Qg=;
        b=IptTbzYCNUgPwENZeUgDYImCr/ZU07asoqfwim6dbN6NIBwSFfB3QHrLDSavpWjnb3
         2LkQII+yPwWx7DeoGEbZKNBuqflAWXh5IABdEzWEXeS7a1z1BPb89dblKqNipBoXEgfJ
         zcFCQPsix7ANlVDERflqOBdEQFQG+seQgZrPLK7qdgvHFgXTTpe6/ryHBFc0SV1hOfdd
         yBCTb7Tw8CaemwBkSamEmVwiJhMiuVFQWlmn6RvQHZjDvchTbGR3hr8/mf+LcbfQmVI7
         MCQzDO7pAqjCQIRtaVieHKi0pxdw26Rttsn7lLCahRJjnXUlbmHjrCXlatG35PfyafBl
         YuZA==
X-Gm-Message-State: AOJu0YwgNn9nKhqIMZTc1gSBvaVJgerPClQGOLG8ZNcOP1vIOLN8RQl1
        oXl8NjinENPQsZPcf8x/hKMUZYiOpzGiGxbjOtpMf9NOmHdJ
X-Google-Smtp-Source: AGHT+IEHuY73Y/Rx+X9qZo9nR41hHIr96Sr5TsO/CzJaJL4kEkoEZdbOMGBga+DIw42xLYgFuPGtI+Kx9jgmPtyDIP2fbIGE+N74
MIME-Version: 1.0
X-Received: by 2002:a17:902:e743:b0:1b8:a555:3865 with SMTP id
 p3-20020a170902e74300b001b8a5553865mr1784086plf.6.1692273687259; Thu, 17 Aug
 2023 05:01:27 -0700 (PDT)
Date:   Thu, 17 Aug 2023 05:01:27 -0700
In-Reply-To: <20230817104037.1766-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdf0fb06031d2ba3@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in toggle_allocation_gate
From:   syzbot <syzbot+52d2f6feb48dc7328968@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+52d2f6feb48dc7328968@syzkaller.appspotmail.com

Tested on:

commit:         950fe358 Merge branch 'ipv6-expired-routes'
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10fb456fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe63ad15dded26b6
dashboard link: https://syzkaller.appspot.com/bug?extid=52d2f6feb48dc7328968
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147b456fa80000

Note: testing is done by a robot and is best-effort only.
