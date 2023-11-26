Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256AE7F95DD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 23:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjKZWlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 17:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjKZWlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 17:41:51 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090C3F0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 14:41:58 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2859447a409so3741694a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 14:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701038517; x=1701643317;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BBEQ1ZN4Yo2Su2+1uRSXN/dDlB5/P5oUfbcZb1EDRc=;
        b=unEaDMRVRQlCCnCHcDuBAvu90ptnJvNi+uoSKMbBnXANdNsSJn/IUhIxFGzWa39g1r
         Pabq+B+b7XpHeZuyzF3phjn3uxSYTUs8XNNiitz4PgnlTUI5rJyqSjAb9/FZYrkrv27t
         FQ2jAjltZ1HIuG+1qywva5zNKGBAYxudZsXzQTAoVf0PUjlyNUMxvcTQIj+BHlT4Mitb
         AhrLbFFx3xe9dZI9048qJ329xXkzItp6Y8fUH0V+MxZn1C8aFuzinVaZJV8x7R8twAwm
         ir4HOAs+2ckdY0hd7p/7k+abYdotLD7GcwvUiB9pgpJJJXnU+x7CI325afZSGSU0FbdZ
         RHzw==
X-Gm-Message-State: AOJu0YyNCsOHg+iJDGTRWiSSrmKlJFCSET5hcEC1jXLQKiuDsriPygYt
        VZX3EVnff5/zpg5UJglIO7g3Dv44raW85LH7kjTuQ5/UK2RvG0w=
X-Google-Smtp-Source: AGHT+IFMN3W1K1mJLz7d2HLfwa6MqW2y1RcZmTWD9MypCWjw4w6o5b81vAKcQiTSENNPQZcnYkXnv/e8bxZL/uf49CrqzIW+UXpc
MIME-Version: 1.0
X-Received: by 2002:a17:90a:c401:b0:27d:ba3:fbf9 with SMTP id
 i1-20020a17090ac40100b0027d0ba3fbf9mr1934178pjt.8.1701038517603; Sun, 26 Nov
 2023 14:41:57 -0800 (PST)
Date:   Sun, 26 Nov 2023 14:41:57 -0800
In-Reply-To: <000000000000653bb6060afad327@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097543b060b15e4c9@google.com>
Subject: Re: [syzbot] Test np deref
From:   syzbot <syzbot+dc6ed11a88fb40d6e184@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Test np deref
Author: yuran.pereira@hotmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
