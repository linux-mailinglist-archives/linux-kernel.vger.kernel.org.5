Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FAE77B730
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjHNK6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjHNK6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:58:31 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D191AA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:58:29 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1bdf1994d0cso1087625ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692010709; x=1692615509;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jt+fZe5qHeWTcC3zwLZwIuTS6MRkvJX9hiajkyq/+XY=;
        b=iT7ScZC61kfQdWM1ZP64ZakN6xUht+NRyZP1LEevivJ85fediJVqLfhad48s6Nci92
         uhYsCKyOG46CMRxlQ8eLnZXs/yDDUsmcDK7c0lBbMMqcK5gcnkgBDhoidf9QA8pxbO72
         Y7ngc1BzQ6ozFCPxo2j3PqhTjTweusvoEYmqeEQfAEhuSV/xdZosKYC2tnE6gFkEG20E
         g5la0nzsEd2/J3z/E7h81qNPUjgq5//oL3wgRHOWs9Ig5exgY4a1yOXAfleBlig5g1MM
         D5qogiWVCTleT4zQsa1cXFsV5urXEYkR688TpPQ1JIY+uGWZu/cwL02BaJZnyd68w3Yj
         mwGw==
X-Gm-Message-State: AOJu0YxxFYkj4ysYEvffjNVZN3jOL+JolLdxfvAwsNaXHhm0oe45wYL9
        WaTuuZNvHNwED/thPsCTB4iW+4cWL76QncmaGZOLkxWk3OEl
X-Google-Smtp-Source: AGHT+IHEaxcbUHfPPXJW/ee2VLwAZG0v/r9/fX+5i9efmJxRnPaIynno0ZG5w+2svxM06+sVmuhYd7x06exRmnjxoZXdTP5M8mdo
MIME-Version: 1.0
X-Received: by 2002:a17:903:1ce:b0:1b0:3cda:6390 with SMTP id
 e14-20020a17090301ce00b001b03cda6390mr3977680plh.8.1692010709051; Mon, 14 Aug
 2023 03:58:29 -0700 (PDT)
Date:   Mon, 14 Aug 2023 03:58:28 -0700
In-Reply-To: <20230814103505.1252-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044ef170602dff181@google.com>
Subject: Re: [syzbot] [net?] [wireless?] INFO: rcu detected stall in cfg80211_wiphy_work
From:   syzbot <syzbot+b904439e05f11f81ac62@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+b904439e05f11f81ac62@syzkaller.appspotmail.com

Tested on:

commit:         cacc6e22 tpm: Add a helper for checking hwrng enabled
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10e1bc65a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=b904439e05f11f81ac62
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1338569ba80000

Note: testing is done by a robot and is best-effort only.
