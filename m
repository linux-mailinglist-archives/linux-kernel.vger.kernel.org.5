Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223D180AEE5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574786AbjLHVmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHVmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:42:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FDA9F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:42:15 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702071734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJjCpHW3cLeJKhU5Mj5m0X6ylCYnbleawYD+kVkWO8o=;
        b=wAcyLJc183S+uTB9JL1fd3nzhkLsTc+CydcFai81r3InPa1hHObDdMeKpgoelf1Rh0eTeO
        93YM4cikDd5RJTnlQp8/5ViOuqpxyJ4zRcRzk6R2P6ooNPeDr69o3qcZG5u39FAuH6aCI+
        Oi/adljTjwGgRLI4C9Bzd6VauE5psNZvuBxKEhgLr3nq5swEFqfzJpA9rHTWCgBjVH28XA
        sEBGp5+tK9JY99MIKgK+I8k1/U2abDHmU/UE+f+ZXepfMngvM3PIa0c1Q9clWATaYXlmsF
        RUL58ye930SuhF7uRpbVDYrIk38T+pMLon9zlK+cY6wIPnBKEsHpc/OB/gy47Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702071734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJjCpHW3cLeJKhU5Mj5m0X6ylCYnbleawYD+kVkWO8o=;
        b=cH75FL4e+YqF4GV/l0OH2aqjxnTWk5WHjzSScfP+XCanERV2bqJt29LmoVUcPdsP4ZaRxZ
        kZ/GJKbJHMVRnlDA==
To:     xingwei lee <xrivendell7@gmail.com>,
        syzbot+f2c4e7bfcca6c6d6324c@syzkaller.appspotmail.com
Cc:     jstultz@google.com, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] possible deadlock in alarm_handle_timer
In-Reply-To: <CABOYnLyHJjv7bZ3CcXo4zAxZ-o49FO9OsWpQrY4tTLNqCbA4Mw@mail.gmail.com>
References: <CABOYnLyHJjv7bZ3CcXo4zAxZ-o49FO9OsWpQrY4tTLNqCbA4Mw@mail.gmail.com>
Date:   Fri, 08 Dec 2023 22:42:13 +0100
Message-ID: <87o7f0qslm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05 2023 at 10:07, xingwei lee wrote:
> Hello
> I reproduced this bug with repro.c

Which bug?

What happens if you run this and what's the potential deadlock?

Lot's of information missing here including the kernel version ...

Thanks,

        tglx
