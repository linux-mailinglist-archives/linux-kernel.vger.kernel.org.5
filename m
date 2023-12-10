Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7138580BC0C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 16:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjLJPnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 10:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLJPny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 10:43:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE90FFA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:44:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B452C433C8;
        Sun, 10 Dec 2023 15:43:59 +0000 (UTC)
Date:   Sun, 10 Dec 2023 10:44:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH 14/14] ringbuffer/selftest: Add basic selftest to test
 chaning subbuf order
Message-ID: <20231210104436.00d94363@gandalf.local.home>
In-Reply-To: <3b45bdf6-234d-4859-8344-c18b48c8b415@efficios.com>
References: <20231210035404.053677508@goodmis.org>
        <20231210040452.274868572@goodmis.org>
        <3b45bdf6-234d-4859-8344-c18b48c8b415@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2023 09:26:13 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:


> This test has no clue if the record was truncated or not.
> 
> It basically repeats the string
> 
> "1234567890" until it fills the subbuffer size and pads with
> XXXX as needed as trace marker payload, but the grep looks for the
> "1234567890" pattern only.
> 
> The test should be extended to validate whether the trace marker
> payload was truncated or not, otherwise it is of limited value.

It can be, but for now it's just testing to make sure it doesn't crash. I
ran out of time, and if someone else wants to extend this, go ahead.
Currently, my testing has been just manual observations. I threw this in
just to have some kind of smoke test applied.

I agree with the API changes, and will update that. But given that this has
been two years and never applied, is because nobody has the time to work on
this. The reason I'm pushing for this now, is because Kent hit the limit in
his work. Knowing that he would not have hit this limit if these patches
were applied, I feel more urgency on getting them in. But this is all on my
own time, not part of my Employer (hence why I'm working on the weekend).

-- Steve

