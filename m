Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACFA7D077A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjJTFFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJTFF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:05:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63301D4C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 22:05:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE50C433C8;
        Fri, 20 Oct 2023 05:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697778327;
        bh=fkP5kKXCMlyWPz7pz7wvmEyP0oUqwxiPLe8Hc+jGjLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pgtOpclt1U1oMhg9MqET8TC6szYa15Al9kd0jIeU8oG5z16svOE3D7r/LYKs31a1n
         i/VInf/SiAzumSwkkTtpCo/tgjbKO9Z/NeQFBOJkuLNx49NUmQyu8wcBVybT7Q/NyL
         OhPi6LcRsT0LcsspWDvPP3xXDfTHJYlyLr9Hb6MQ=
Date:   Fri, 20 Oct 2023 07:05:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Justin Stitt <justinstitt@google.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] trace: Move readpos from seq_buf to trace_seq
Message-ID: <2023102012-pretense-agnostic-d377@gregkh>
References: <20231020033545.2587554-1-willy@infradead.org>
 <20231020033545.2587554-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020033545.2587554-2-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 04:35:45AM +0100, Matthew Wilcox (Oracle) wrote:
> To make seq_buf more lightweight as a string buf, move the readpos member
> from seq_buf to its container, trace_seq.  That puts the responsibility
> of maintaining the readpos entirely in the tracing code.  If some future
> users want to package up the readpos with a seq_buf, we can define a
> new struct then.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
