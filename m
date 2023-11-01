Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E539C7DE91B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbjKAXsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbjKAXsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:48:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8511CC2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 16:48:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58825C433C7;
        Wed,  1 Nov 2023 23:47:59 +0000 (UTC)
Date:   Wed, 1 Nov 2023 19:47:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 4/7] eventfs: Save ownership and mode
Message-ID: <20231101194755.7daa6f60@gandalf.local.home>
In-Reply-To: <20231102084332.754ff8867b7616c36bdf65ad@kernel.org>
References: <20231031223326.794680978@goodmis.org>
        <20231031223420.568912586@goodmis.org>
        <20231102084332.754ff8867b7616c36bdf65ad@kernel.org>
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

On Thu, 2 Nov 2023 08:43:32 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 31 Oct 2023 18:33:30 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > Now that inodes and dentries are created on the fly, they are also
> > reclaimed on memory pressure. Since the ownership and file mode are saved
> > in the inode, if they are freed, any changes to the ownership and mode
> > will be lost.  
> 
> Do we (need to) allow to change the ownership and mode of the eventfs files?
> I thought it was fixed on the files in tracefs...

Yes, it's the only way to allow non root users access to the tracing directories.

> 
> Otherwise, the code itself looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Thanks!

-- Steve
