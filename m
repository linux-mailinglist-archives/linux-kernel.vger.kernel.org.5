Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8D17DF723
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376822AbjKBP4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjKBP4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:56:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903EE12D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:56:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE72C433C7;
        Thu,  2 Nov 2023 15:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698940570;
        bh=Mg3ASjH3LGIBymJxkih3/f/vhHtATnZRAp+P/YEAyuM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aT18hCEfRPJkqEubpGGoqZBA0L44HkaPk+EYf1O9ZO31iBAnfyGAC+wcSay8CksJL
         9MyKdqpQ7/CEWiYvKpn61FBO1A972EF1iq22aVe9CszshMST8QB3PnRCFEY4ECD0Hr
         aYwDixHAGFHbuCB8q2mB5hHN54ocKaTkWeDjKYmk=
Date:   Thu, 2 Nov 2023 08:56:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     woodrow.shen@sifive.com, Andrew Jones <ajones@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Glenn Washburn <development@efficientek.com>,
        Jeff Xie <xiehuan09@gmail.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6] scripts/gdb: add lx_current support for riscv
Message-Id: <20231102085609.39a22424bba9a75a1523e23b@linux-foundation.org>
In-Reply-To: <ZUPEDWofcqgzsgMS@debug.ba.rivosinc.com>
References: <20231026233837.612405-1-debug@rivosinc.com>
        <ZUPEDWofcqgzsgMS@debug.ba.rivosinc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 08:45:17 -0700 Deepak Gupta <debug@rivosinc.com> wrote:

> Ping
> 
> + CC: akpm@linux-foundation.org
> 
> Who should I ping to make sure that it lands up in mainline?
> It's quite a trivial change to support lx_current riscv arch.

I moved it from mm.git's mm-nonmm-unstable branch into the
mm-nonmm-stable branch earlier this week.  mm-nonmm-stable is what I'll
be sending to Linus later this merge window.

