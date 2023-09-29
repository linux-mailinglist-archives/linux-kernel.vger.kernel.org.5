Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412647B2C28
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 08:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjI2GFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 02:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjI2GFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 02:05:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0CF92;
        Thu, 28 Sep 2023 23:05:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAA8C433C7;
        Fri, 29 Sep 2023 06:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695967500;
        bh=Nhavc+nkl/WrTYLi4RrwAIVN6PbgwJffcR2eWRUl1xQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dsyv8DcgjMd9U5QAhkwMHPBCXoPGytz0tKjFa98+Li9uDz/PaeCWGons8jBVOhC27
         +g73GLX3gX65/XN3GcoOco7fjfs4xw1j1TPwXbIptOhPAi/jAf0JlTg/+g0r2U/wXl
         rLpgsbC5WSGmDhfikJ6Vz4OMzPh3Pu5art0sgYas=
Date:   Fri, 29 Sep 2023 08:04:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Edward AD <twuufnxlz@gmail.com>
Cc:     alex@ghiti.fr, alexghiti@rivosinc.com, aou@eecs.berkeley.edu,
        conor@kernel.org, guoren@kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, liushixin2@huawei.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] riscv: fix out of bounds in walk_stackframe
Message-ID: <2023092939-lagoon-punctual-e312@gregkh>
References: <f74665d1-4d28-01a2-5694-b06fde202d39@ghiti.fr>
 <20230928231239.2144579-2-twuufnxlz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928231239.2144579-2-twuufnxlz@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 07:12:40AM +0800, Edward AD wrote:
> Add vmalloc and kernel addresses check to prevent invalid access.
> 
> Closes: https://lore.kernel.org/all/20230926105949.1025995-2-twuufnxlz@gmail.com/
> Fixes: 5d8544e2d007 ("RISC-V: Generic library routines and assembly")
> Reported-and-test-by: syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/0000000000000170df0605ccf91a@google.com/T/
> Signed-off-by: Edward AD <twuufnxlz@gmail.com>
> ---
>  arch/riscv/kernel/stacktrace.c | 3 +++

Where are you getting your odd cc: list from?  This has nothing to do
with serial drivers...

greg k-h
