Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2F977A036
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 15:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbjHLNvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 09:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbjHLNvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 09:51:31 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8361FE6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 06:51:33 -0700 (PDT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-686db2bb3eeso3622744b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 06:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691848293; x=1692453093;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBo60cRttCxg4Vq2B50qv7wtBQmTl3C9+XPrwGwxr18=;
        b=fI13a6KWRvNZNydFgp6sNCRxIFnhiCbX12ZlO1xDk55Bt4PV5rRbtykyInG3mlU0Zj
         KflpIocCFwLqJqnD3oVAIExT61LB+RPp+WqtPGExf29GxBfxq/NR+s46r9zlb71diZqy
         iWklPEdfb4Mxa7PTbItsGXWGOWEEy6wC/wgLCgd9lLYx0QBeuDWkvC5xb7y/OC94wPA5
         1iAnlB5FsDKyX3j/YaIrgC+TDdOinERmvg1HzJVoKj6Rbp7mErwStB1gdzZI0G/b9kt5
         i/N2O3wHk3VhU3NqYOaM6GFdgDyxClOdB4X3VG6tTJqD5Gd/9FG12HFWKOFiOgoLLyUP
         dZ4g==
X-Gm-Message-State: AOJu0Yz4ifbtqtPqjcLiAsIBVZ9J8BsDExVTMd1cbcQjODZALp3mZuPT
        UWXkDmVy7E8ElPeoOXGBfwrPx4R5chQMiVMR4BD2iS+cpNwN
X-Google-Smtp-Source: AGHT+IFCrulR6Wd2Fhyj5+t7brVuz5mACfBZWArSJGSsmfcU0UVSJcxgF4TWeeWAtkigEhY5md/u8AzlCVj20PRw8oVNuRwLaeYE
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1704:b0:687:a55f:a9ef with SMTP id
 h4-20020a056a00170400b00687a55fa9efmr2033983pfc.2.1691848292977; Sat, 12 Aug
 2023 06:51:32 -0700 (PDT)
Date:   Sat, 12 Aug 2023 06:51:32 -0700
In-Reply-To: <20230812132354.896-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008450600602ba2009@google.com>
Subject: Re: [syzbot] [net?] WARNING in rtnl_dellink (3)
From:   syzbot <syzbot+4b4f06495414e92701d5@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+4b4f06495414e92701d5@syzkaller.appspotmail.com

Tested on:

commit:         048c796b ipv6: adjust ndisc_is_useropt() to also retur..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=107419c3a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=4b4f06495414e92701d5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15d7ea27a80000

Note: testing is done by a robot and is best-effort only.
