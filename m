Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31F277B77A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjHNLVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjHNLVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:21:34 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DEFE5F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:21:34 -0700 (PDT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-686bf0ee1b0so5079729b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692012093; x=1692616893;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMw17oaNhAh7BEkRFGRNwd9Ud16PU1fy+W7p7hiH7Dg=;
        b=jmvZrugnqI2dveH3B3DdUHIMu/I3h2H4KWR3tMsZz9Cg+jG0Y7utZK62E/8laqWzlo
         cjS/BhZkiVP1+fEWcZW6oQcdZI3GBklDi2rKxVCgRq8MZgPoi2uLWSNbbKIMWfyRDNI8
         u/WYuj+1LDfCejdbf3ZHUTqVwdXbjuVCiDl8DwSCf0If4gx///rVKgP6EwbR6Uwr8pnG
         2zULNJz0XyXTlk6N2VXUdhCYZ18cVme67ZkMareZICK9Egfvc3kg+kDy/alVvlvDhlQS
         1DHQ2cwqkblXgDZeVNdFakgwXTUhwB+6QNAnrdl39Q7hK2q0/8toWkFGk2hcSvlwYh/B
         mj2w==
X-Gm-Message-State: AOJu0YzK5Z3OlCshcZhM8t/waqsBnZC0ohOnXquF+Eq2j98362avRFDn
        vsQhUtaiNU4YLIO8zz2M2l424hsq9yBcALBcGhSAce2yJizk
X-Google-Smtp-Source: AGHT+IHjKEN5jNG1cqbPYnc/uo1mkRQResEb0Du5lfvYCDi8nAd3e342u3bSkb9O0hgak3ppetmjgIf/RXXzBDj4GS4LFX+210aw
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1ad3:b0:678:e0b1:7f28 with SMTP id
 f19-20020a056a001ad300b00678e0b17f28mr4459868pfv.6.1692012093616; Mon, 14 Aug
 2023 04:21:33 -0700 (PDT)
Date:   Mon, 14 Aug 2023 04:21:33 -0700
In-Reply-To: <20230814104207.1308-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbbbc60602e043c1@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in unix_release
From:   syzbot <syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com

Tested on:

commit:         d0378ae6 Merge branch 'enetc-probe-fix'
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1321419ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=a3618a167af2021433cd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a23e03a80000

Note: testing is done by a robot and is best-effort only.
