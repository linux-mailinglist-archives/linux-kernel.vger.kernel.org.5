Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0027C97C0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 05:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjJODHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 23:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjJODHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 23:07:40 -0400
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DD6DE
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 20:07:36 -0700 (PDT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-57b5e7c753fso4530778eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 20:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697339256; x=1697944056;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HiHLlpJE9rT/tAnJYiWBwlesE5IJn5d+2V5sivCbVDQ=;
        b=VF90ZS1/K6M0eRtR/7L947TPX/+rfR681HjtolbtiouYualtJbHZpH/NbXvWDMP2SU
         KESBXUaJeFfIGhWLUT47HDWw9Mi+CFmu6CkgdoukdUvP/ZBp1brpT2Zh5EQjY+zbXDjV
         mQ1/5N9ZAl3dFoj6226y/6xBQl72IjPIN7Fgmf1up7KeeNteX1WtoWFnJQO+9FREieNI
         mgUFonAT8MR9itpCo10EpljIcAlos3InYqd608GSfoeai6EG2nbPWoTTpCmwl6DVGHlH
         8tRbz5g2zWYxpXdwKJGL+IA7KK0K+mOXlrlhvgiMhQlCRFwf7TboiRTuHP8dLSqXI85f
         p55A==
X-Gm-Message-State: AOJu0YxrtGh49RSqv19S+8sTH6pLHaVIyJHaurf+gWNs7ylGoI8GJVzn
        XXQX7l5W6Xy8x6yQYhc8JurAqn2YjWqREpiFVF8J2V/hyz26
X-Google-Smtp-Source: AGHT+IEOiXTwMXPBzRi2m8/ygbn5M4mqy/gnQswvzGUdIAwN4DJ1wrM6n7RyCl7fmyjS9onlFpPxYpbUnvIpp484BOxDxEz1nVkO
MIME-Version: 1.0
X-Received: by 2002:a4a:641:0:b0:57b:ee95:ad48 with SMTP id
 62-20020a4a0641000000b0057bee95ad48mr9915118ooj.0.1697339256326; Sat, 14 Oct
 2023 20:07:36 -0700 (PDT)
Date:   Sat, 14 Oct 2023 20:07:36 -0700
In-Reply-To: <20231015024043.1689-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006fd2680607b89773@google.com>
Subject: Re: [syzbot] [batman?] INFO: rcu detected stall in rtnl_newlink (3)
From:   syzbot <syzbot+afb3084a933aa2bdacc6@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+afb3084a933aa2bdacc6@syzkaller.appspotmail.com

Tested on:

commit:         d5280145 Revert ".gitignore: ignore *.cover and *.mbx"
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13d5aab1680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53de8828edb29baf
dashboard link: https://syzkaller.appspot.com/bug?extid=afb3084a933aa2bdacc6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17530ab1680000

Note: testing is done by a robot and is best-effort only.
