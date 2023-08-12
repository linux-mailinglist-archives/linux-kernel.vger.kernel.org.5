Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9C277A097
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 16:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjHLO42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 10:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHLO40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:56:26 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EB210EB
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 07:56:29 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1bc4abfca29so36756145ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 07:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691852189; x=1692456989;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWn/SiMBsUWh8aEQS1UjZZq2kt6kqJzGEXADZ6YwC/4=;
        b=k4zzeT8LzndyI4cazy1jZbfYo5z+C6NsVO7bIs/jrHPciuJ3irDqA3CfzmwCZ4pW2v
         2qmDGkpE2P5St+/B1gf6/2Co1eMaxICtmVUVaJcO44rIkt47ImldmdlafkZxLscPUj9e
         cmjHCkf50MKjg9bNIQcGeX9GRbuj0xhV1FXSBL9pgO2SiT3pO1b6gktUpyLaiUgoldHR
         E3bSrvQTGNhPwOxhhGLPkG73W/rvRbpmFx8fpunq5JZ+s6VRxpTs+8vQBFr8dFBN020v
         VH4KDfoKA1r3eJSlV3iG22hg+EsCqXqLfjBNGqe8EzS3rpYYvQNC+2D4cgZfc+4tNYZu
         D7OQ==
X-Gm-Message-State: AOJu0Yx+Lkd3ktAfinOgjKnzs6I1nO/eV+lfZjWkzuR9+ESxOafJaTc5
        q3kvXikVpc0w1MEQ0iU3PnThESDDs6+Oq1kzQERSDxhmLupQ
X-Google-Smtp-Source: AGHT+IHuhcHaDqNFImo78uJEsBm3KbWeKYQm53ce0cmOUYJAhMDOGnelTywH8wgNf+BT0ZhMzL8Q4QuNpel7i+oLAhAjm4sHjuTX
MIME-Version: 1.0
X-Received: by 2002:a17:902:ced0:b0:1ba:ff36:e0d7 with SMTP id
 d16-20020a170902ced000b001baff36e0d7mr1933969plg.12.1691852189120; Sat, 12
 Aug 2023 07:56:29 -0700 (PDT)
Date:   Sat, 12 Aug 2023 07:56:28 -0700
In-Reply-To: <20230812142725.948-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bebe770602bb0805@google.com>
Subject: Re: [syzbot] [net?] WARNING in ip6_tnl_exit_batch_net
From:   syzbot <syzbot+d810d3cd45ed1848c3f7@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d810d3cd45ed1848c3f7@syzkaller.appspotmail.com

Tested on:

commit:         048c796b ipv6: adjust ndisc_is_useropt() to also retur..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10a16cada80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=d810d3cd45ed1848c3f7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1664153ba80000

Note: testing is done by a robot and is best-effort only.
