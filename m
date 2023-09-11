Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F252F79BBD3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbjIKV0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237974AbjIKN0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:26:38 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82656193
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:26:32 -0700 (PDT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-68fc6f92088so1442076b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438792; x=1695043592;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fs183G8gntR2RSdkjdDIZpkwT+4nDdXdoG69LS7wnmg=;
        b=ooudzOA2Ds6DUUTQ1ZuDEygU3/drfeGQ0oY0F01WZocCpGld1mXWD/dnB0TV/YxLr+
         kzMW+6qWNUjlGAlPapCRIgj22NiELTEApy3rFY6pYK/SYDfmdaBfwcNy3SYYuL8fcG0T
         hTaYN+Si1x2mjRD5yBKZIKocqwz7dcC87A1/a09TneWcuCuYG7a33ITyuYhWF6xaaguE
         LifZu3wiQrdk5pEjMsSeUz8PExQ30c7zgYZyF4vKcZYBSKbCruOlNpFZbV57bH5vdcyP
         75i9sJpGyBIrVPZnfHzbLknJb5AGH8hebKUPYXNdKdoqJo1GmYXIES/xqYQokw8pOXS9
         gLCg==
X-Gm-Message-State: AOJu0YzucgeJUb4OJ1edoHK4QXAQf11ySzrT21CgYmt1IHFAohTH9kOp
        QV6e/LKTO1Xo2dZJx1Hu0lutVoZH1LyyKE2mTRVIzmM5baun
X-Google-Smtp-Source: AGHT+IF3vYc3DGUgeCGQ64WbOAUbKNWOYKsGdKe2wCbi9rftFKV9ZhNj+ap/q8UNDniBB+GfhTthUkn65a0cvKNzGyPMNwTln3s3
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2356:b0:68a:2c24:57d1 with SMTP id
 j22-20020a056a00235600b0068a2c2457d1mr4081524pfj.1.1694438792031; Mon, 11 Sep
 2023 06:26:32 -0700 (PDT)
Date:   Mon, 11 Sep 2023 06:26:31 -0700
In-Reply-To: <20230911114434.6481-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004af49b06051546ab@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in lock_sock_nested
From:   syzbot <syzbot+d3ccfb78a0dc16ffebe3@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+d3ccfb78a0dc16ffebe3@syzkaller.appspotmail.com

Tested on:

commit:         5a124b1f net: ethernet: mtk_eth_soc: fix pse_port conf..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=12440ca0680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20110ebc6eac9d0a
dashboard link: https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=128cdfec680000

Note: testing is done by a robot and is best-effort only.
