Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79FA7C9283
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 05:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjJNDfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 23:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNDfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 23:35:30 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CE1BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 20:35:26 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6c4f235ee22so3778834a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 20:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697254526; x=1697859326;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFHQ6stX0jHvZqwpx2BV7Ej53N6n2XukQK6TD1x7uLo=;
        b=Yd2ZhMr1BPdExFbl1UEQ6G5QN8kAaY2AQiYB1YESCFRscbxPAsUBQllxsn9WyAXhst
         CDp/KiiuE1k/Le4rYzMTlStz0C6q44UORzMDuxzuzBUhCwOxcSaQsBhIXLZnH9X2Z8/m
         R2bYygX654Qgki1JKmqRiVxGParzsvtxFMePaonjPajMHLhGDQXwhWJbjjqdT47PJaDj
         b4q9XC/t/brhzRic5RlXqgQhWEKUU1P/WUPq8gpf6+6N4uCpTETaroeh+K07EMO1bpq/
         FZ9vinREE9Cp2qcVWbjoH5F6uUpls1vhIMMr5uBPYqiYrDWaFuZ+zAkuxJsDSjoGBDHs
         W6Ww==
X-Gm-Message-State: AOJu0YwxHWjnUmmG/c1J0Iu091aknH8QUoAvOCfbxRpn+SLdgL8xZy+u
        2t0AS912uBnJoiIOO7OX3A1Gc0mPiwUaZatNtv1C0srcCp0l
X-Google-Smtp-Source: AGHT+IEKxhnSvDP710Opi0CqLEH906yGM0swaD1Pr0CDTlnA0p6y2opbrmss4QtCFrwmGI74nQZA5LMtI3UFj+WxAsqAIG6o2aIM
MIME-Version: 1.0
X-Received: by 2002:a9d:75ce:0:b0:6bb:102d:1ff6 with SMTP id
 c14-20020a9d75ce000000b006bb102d1ff6mr8958434otl.1.1697254526029; Fri, 13 Oct
 2023 20:35:26 -0700 (PDT)
Date:   Fri, 13 Oct 2023 20:35:25 -0700
In-Reply-To: <20231014030548.1561-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e19970607a4dd3e@google.com>
Subject: Re: [syzbot] [net?] [wireless?] WARNING in ieee80211_bss_info_change_notify
 (2)
From:   syzbot <syzbot+dd4779978217b1973180@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+dd4779978217b1973180@syzkaller.appspotmail.com

Tested on:

commit:         8cb1f10d Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1042c729680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d83dadac33c08b7
dashboard link: https://syzkaller.appspot.com/bug?extid=dd4779978217b1973180
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12982711680000

Note: testing is done by a robot and is best-effort only.
