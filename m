Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797477A49D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbjIRMhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241573AbjIRMgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:36:49 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6E4E6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:36:27 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1d6fdbe39c8so1459565fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695040586; x=1695645386;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWaU34tE5V3lz+UvO1udinkKJAkf8+DYl+MZokF/z1g=;
        b=lK3jMFmPxvcaMFUofw+SgZQHaJabA1oXl36AadxfjycqfJseqKyDSU1i/459uCLP7k
         azLaDITUSf7YsBoDRh5TS8sUamPOcFyVTs5O3lXjh04cjPm+plGhFHESY/oXhFU6ltiO
         jv5gpETdOizZ//kNbWVbcCoVqH4ugz/M/08n9x5mGgPbXtTmfeG6fBVTIRY8EiFFIJtJ
         7OAjvp9uZ7h4ujhZvav/qQQScZ/lVGkbIMS+OB/Uqni9RvQcpdyTHuK85Q2IfLdVArrx
         0a9lifsVi25jbSNf7PTN//B9Or1APWa7TaM+GiToRKAgGAcLJ+R0m9dVpAGH5MUdtXQk
         8ZLA==
X-Gm-Message-State: AOJu0Yx2aPZOTMimhKv7e2KezSaB+IhrSFib0CVhPrdKqLIZ6U0UPX/C
        3HVZkJd/CllTAvcLqsuMCFZjGY3tft79JeZj6XmfGW8nVuOU
X-Google-Smtp-Source: AGHT+IEYiZu3eA9QEFXdvoJUWMdymKvILGf31PgOwUrktqOHp3HckAqIr7CctAfp7E3UG0ZZCHXZqRqDZClGNqz97MhcA1zNH5HG
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5b0f:b0:1d6:4344:88ef with SMTP id
 ds15-20020a0568705b0f00b001d6434488efmr3442593oab.0.1695040586719; Mon, 18
 Sep 2023 05:36:26 -0700 (PDT)
Date:   Mon, 18 Sep 2023 05:36:26 -0700
In-Reply-To: <ZQhDRtWYSJWfHvEM@casper.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d28b70605a164d6@google.com>
Subject: Re: [syzbot] [mm?] WARNING in page_add_anon_rmap
From:   syzbot <syzbot+6e4f59235036c3c2e296@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file mm/rmap.c
Hunk #1 FAILED at 1249.
1 out of 1 hunk FAILED



Tested on:

commit:         7fc7222d Add linux-next specific files for 20230918
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=e204dda2e58397ec
dashboard link: https://syzkaller.appspot.com/bug?extid=6e4f59235036c3c2e296
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12af76f8680000

