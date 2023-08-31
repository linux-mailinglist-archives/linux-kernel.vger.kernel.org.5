Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B737678EBE5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbjHaLWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjHaLWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:22:37 -0400
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1369DCF3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:22:35 -0700 (PDT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-271cf74f2a2so839104a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693480954; x=1694085754;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C47g7eG4Z3NHn1IyTXipothfao1p4iMkSkhWe9h0jN4=;
        b=dT1+KgvFb5naO8Eb1zvh5L9agf/F28qWD51NulW/ymh7zSQUD7JbfFS9Abn/Dl8xnV
         qwNIf+3TDgJ4hAhv+VTzxevJsSsyp2auQ0nU9Hf2JoDrFXw/hcO9fWURTSBszcC8hNsM
         xWjljFZymVmCdEBOBgFjjol7OYolOaqITzOa3sNtRsUf9+pwoiOxBPAP+pTZU0dPTx7d
         z++UkjsCOsiZHhxFR/EMYk/rXAk9jtZ2mObWsoAW6f08gc9pthWf9yw/iaNOE+MjHnJb
         t6V6FobadQlgl/4L5MWofLE68CDAlCYydaeQ5cOjIKzfEIgNOSxAxTyuw83YsEbmWOtQ
         B0Nw==
X-Gm-Message-State: AOJu0YyCapKQRBrxS9s5TUHWvuDD7XpS7vr8GdgFz7tg/xKoYUeshP4y
        ULmd2caG0zcrBo0kFyZyKcU3KaEQYMr6AXxnnYsdr4dnCsiV
X-Google-Smtp-Source: AGHT+IFe3NYFjS6LyOenVJEo4KugpG2QAoLO3/wzDMU8O8jVaY1yPphhTpJmw44tyo7xp4Zg4YKUSR8dSD+sV3h1rMI1BKPJfxYK
MIME-Version: 1.0
X-Received: by 2002:a17:90a:d18a:b0:262:ffae:56cf with SMTP id
 fu10-20020a17090ad18a00b00262ffae56cfmr804890pjb.8.1693480954656; Thu, 31 Aug
 2023 04:22:34 -0700 (PDT)
Date:   Thu, 31 Aug 2023 04:22:34 -0700
In-Reply-To: <20230831105150.4549-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc839e060436421f@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in netdev_register_kobject
From:   syzbot <syzbot+d2c31705e468a347e6db@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+d2c31705e468a347e6db@syzkaller.appspotmail.com

Tested on:

commit:         a47fc304 Add linux-next specific files for 20230831
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1716e99fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8294f0401243efe1
dashboard link: https://syzkaller.appspot.com/bug?extid=d2c31705e468a347e6db
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a4e470680000

Note: testing is done by a robot and is best-effort only.
