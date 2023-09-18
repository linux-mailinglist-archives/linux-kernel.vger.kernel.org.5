Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBB07A5222
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjIRSgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjIRSge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:36:34 -0400
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C5F128
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:36:28 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5735a879147so6694372eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062187; x=1695666987;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zL7t4GHuNYKyFje4T0iRFTpqFYTS+UOIKhf9ZmTQit4=;
        b=G6TmgmkGchBwM0ihFF9WtoJOOw0dwa2anNm+UdYNuUIwb+tH1WNuK3x2dfq97UOQrO
         7yl/RID3aqzd+lQ2pxTGKi/RQiq3Cmou7SbaeDMe8ebXwDq3rwwx0A5RsGCUmwjnbrLM
         ncyLC40N4/k/dW4JKmdMfFKgo76mXm1N9WyH7sxnJxcE5c3RyWprEYzq01jYy7UflOvL
         7YcOC4aVjFJxwZ5vqWAi9srsen3k8Rw8ApI6XyisOGe0qNvCZabPN7QWEh7azmUg8ZbG
         pJLISB/0F+GtcfSLmZLKQcebj92XkZZrO6FKPTRF7LvEg8C0DPxyKIrOZInmMT5ImhrK
         0jOg==
X-Gm-Message-State: AOJu0YwUTXSm5IjiankNIP7Qkpy6PVwBtLgnc5MaEIYWwA6Ka2QX4hS8
        SQTgfcawR+dyf+DsTmOuh9nd7EBZtMNeVQgJIgKy+uGHd/yf
X-Google-Smtp-Source: AGHT+IHKojlF3DrjzfacrM8ON0QKndS3TFyKBRjiZYO1OODXGZpL+wOYt0U6a2mzN7TiYu16z4GdSgQOZJVCPNaBlJoYXEf1UR65
MIME-Version: 1.0
X-Received: by 2002:a4a:4151:0:b0:573:52fc:4901 with SMTP id
 x78-20020a4a4151000000b0057352fc4901mr3179529ooa.0.1695062187261; Mon, 18 Sep
 2023 11:36:27 -0700 (PDT)
Date:   Mon, 18 Sep 2023 11:36:27 -0700
In-Reply-To: <d576d53b-bce4-21d3-fddd-0e26e9b44f89@oracle.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b455e0605a66b2d@google.com>
Subject: Re: [syzbot] [fs?] [mm?] WARNING in page_copy_sane
From:   syzbot <syzbot+c225dea486da4d5592bd@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        sidhartha.kumar@oracle.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c225dea486da4d5592bd@syzkaller.appspotmail.com

Tested on:

commit:         7fc7222d Add linux-next specific files for 20230918
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17fddb62680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79253779bcbe3130
dashboard link: https://syzkaller.appspot.com/bug?extid=c225dea486da4d5592bd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137cae54680000

Note: testing is done by a robot and is best-effort only.
