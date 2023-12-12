Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB580F68C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376737AbjLLTWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjLLTWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:22:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573699F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:22:58 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702408976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YCkCgyHz2zEGYPKuNhqR4fBENLAkx9EBCVbSwxFQCzs=;
        b=l4La2Y+svRQQyKnRCxCHRCaw+D+KPv2k0YM5kIdFbC6EFaiHiEJam1GoZUhPY4Q3aWbxad
        5wghU318fZBzC/qvBH/Cu6U5FuCeUEJgUR+C+KTqcUh15gU/zH9IdWTmsdKcY3yl16gOiE
        s8rai+HXUeqsM33wIDHuzgMg489DSX0Ggo5acEj8O/ULlXL4/nsOt3osNVJ8J0IOX5ULvQ
        9BhQTpxg2JqF7y7I+Rzwk20UsUGriKUYsXb+Ax4M9krPlJFdAjsLzhZWuQZhYm103BK8UX
        H7gp8jMej2B8pWi9BmJPPQH7qe15OcsrkTAfnXUbgFTXFiALnHBJq2AFG6NQhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702408976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YCkCgyHz2zEGYPKuNhqR4fBENLAkx9EBCVbSwxFQCzs=;
        b=DpuSHArtZyfCRIRXx+cMTLH8tMWYAQv7YcHSNw1w2H3lljiMZbZIT9m5l9iQtKkcVnA02A
        32L0eLcErJWplsCw==
To:     syzbot <syzbot+f2c4e7bfcca6c6d6324c@syzkaller.appspotmail.com>,
        jstultz@google.com, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        syzkaller-bugs@googlegroups.com, peterz@infraded.org
Subject: Re: [syzbot] [kernel?] possible deadlock in alarm_handle_timer
In-Reply-To: <00000000000095a67c060a59bdce@google.com>
References: <00000000000095a67c060a59bdce@google.com>
Date:   Tue, 12 Dec 2023 20:22:56 +0100
Message-ID: <87le9zp6nj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17 2023 at 06:13, syzbot wrote:
> HEAD commit:    eff99d8edbed Add linux-next specific files for 20231117
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=134b7d84e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=61991b2630c19677
> dashboard link: https://syzkaller.appspot.com/bug?extid=f2c4e7bfcca6c6d6324c
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.

Offending commit

  5431fdd2c181 ("ptrace: Convert ptrace_attach() to use lock guards")

got removed from linux-next 2023-11-20.

#syz invalid
