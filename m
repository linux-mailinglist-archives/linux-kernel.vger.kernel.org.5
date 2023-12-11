Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CB880DF4B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345291AbjLKXNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345166AbjLKXNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:13:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858119A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 15:13:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904BFC433C8;
        Mon, 11 Dec 2023 23:13:12 +0000 (UTC)
Date:   Mon, 11 Dec 2023 18:13:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ring-buffer: Fix and comment ring buffer rb_time
 functions on 32-bit
Message-ID: <20231211181352.088aeef5@gandalf.local.home>
In-Reply-To: <20231211175904.29e01e8b@gandalf.local.home>
References: <20231211201324.652870-1-mathieu.desnoyers@efficios.com>
        <20231211175904.29e01e8b@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 17:59:04 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > 
> > - A cmpxchg interrupted by 4 writes or cmpxchg overflows the counter
> >   and produces corrupted time stamps. This is _not_ fixed by this patch.  
> 
> Except that it's not 4 bits that is compared, but 32 bits.

That should be "not 2 bits", as in "shave and a hair cut!" ;-)

-- Steve
