Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBF57721F7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjHGL1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjHGL1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:27:04 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996414C06
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:24:15 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a7292a2ad5so8318235b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 04:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407404; x=1692012204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwfVymtOK+K3LEl93QSTFGuwvurewP2VKoIis4HDBs0=;
        b=O68gUmWaxpBopVfoSkBuyHG4FWAzP3gwjopmWfmchW2cWYDJr3fS84DP7lIHp7WHgV
         i0H65aPJK8YEUSRgJoDBX/fdQlGyY9NJEydd2hsAq9Hcn66Ul72Io00bqLu5jNYa0TNG
         OFPmfg239lJZl278jNkcEWaUeZglldz6sLe9omZM81dmKTrhMq6Al/o9JlnyN8Xaruow
         V2BFrIRuJWpiS9kO/wgF4ckZrZ5FWViga7VAIZeKYwYxMxJAS+dpPHlnd5POKcU1ri6b
         3vycz858d5az0B+USwLYkVEpHkkOaarwcRnOx45/fDQ3e3NYZpoddxHrDGG+DzLHFjLn
         AURg==
X-Gm-Message-State: AOJu0YzSw7XQotIGFbHyU9GfIF0tnWHNF/5CcJYqZ+xbY57sw3IPSoSQ
        O+1jy8Iu3ZF3c5XNbHc3IafRG1cOc4eG3owNJitoelE/f4Qn
X-Google-Smtp-Source: AGHT+IF8QmHe3nn8bc5bmjxfRKuhbWt0HTMmTj/NcdLn7aHbEPXckpoaCU8aX0ZoSvbfX+2GF8IkndObZ9SfbBYZ3e0GTGG1BvFV
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1523:b0:3a7:36d6:bd2c with SMTP id
 u35-20020a056808152300b003a736d6bd2cmr15725378oiw.11.1691407404436; Mon, 07
 Aug 2023 04:23:24 -0700 (PDT)
Date:   Mon, 07 Aug 2023 04:23:24 -0700
In-Reply-To: <20230807103711.1810-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008313e606025379e1@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in validate_mm (2)
From:   syzbot <syzbot+70b97abe3e253d1c3f8e@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+70b97abe3e253d1c3f8e@syzkaller.appspotmail.com

Tested on:

commit:         f7dc24b3 Add linux-next specific files for 20230807
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=123794dda80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=81f901dcd08ced60
dashboard link: https://syzkaller.appspot.com/bug?extid=70b97abe3e253d1c3f8e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
