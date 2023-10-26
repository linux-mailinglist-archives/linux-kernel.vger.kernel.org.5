Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869457D87F9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjJZSCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZSCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:02:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80981AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:02:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075F1C433C8;
        Thu, 26 Oct 2023 18:02:48 +0000 (UTC)
Date:   Thu, 26 Oct 2023 14:02:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Justin Stitt <justinstitt@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Yun Zhou <yun.zhou@windriver.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-trace-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_cstr()
Message-ID: <20231026140247.3a3c68e4@gandalf.local.home>
In-Reply-To: <202310261050.A621A7F121@keescook>
References: <20231026170722.work.638-kees@kernel.org>
        <20231026133850.138d5415@gandalf.local.home>
        <202310261050.A621A7F121@keescook>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 10:54:26 -0700
Kees Cook <keescook@chromium.org> wrote:

> > Do we really need to call it _cstr? Why not just have seq_buf_str() ?
> > 
> > I mean, this is C, do we need to state that in the name too?  
> 
> I'm fine either way. I did that just to make the distinction between our
> length-managed string of characters interface (seq_buf), and the
> %NUL-terminated string of characters (traditionally called "C String" in
> other languages). And it was still shorter than "seq_buf_terminate(s);
> s->buffer" ;)

Do you believe that people might get confused with it as seq_buf_str()?

Can you envision that we would want a seq_buf_str() and seq_buf_cstr() that
do something different?

-- Steve
