Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67147DE69C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 21:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347845AbjKAUAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347374AbjKAUAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:00:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264CF10F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 13:00:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A60AC433C8;
        Wed,  1 Nov 2023 20:00:36 +0000 (UTC)
Date:   Wed, 1 Nov 2023 16:00:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] eventfs: Fix kerneldoc of eventfs_remove_rec()
Message-ID: <20231101160035.12824b55@gandalf.local.home>
In-Reply-To: <9d71fc3b-f7a9-9f23-6fbe-a7665954cd30@quicinc.com>
References: <20231030121523.0b2225a7@gandalf.local.home>
        <9d71fc3b-f7a9-9f23-6fbe-a7665954cd30@quicinc.com>
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

On Mon, 30 Oct 2023 21:57:13 +0530
Mukesh Ojha <quic_mojha@quicinc.com> wrote:

> On 10/30/2023 9:45 PM, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > The eventfs_remove_rec() had some missing parameters in the kerneldoc
> > comment above it. Also, rephrase the description a bit more to have a bit
> > more correct grammar.
> > 
> > Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode");
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202310052216.4SgqasWo-lkp@intel.com/
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

Hi Mukesh!

First, I want to thank you for your reviews. We certainly need more
reviewers.

But I need to also state that "Reviewed-by" tags should not be sent so
lightly. The only times a Reviewed-by tag should be sent is if you
participated in the discussion of the code, you have authored some of
the code that is being modified, or are marked as a reviewer of the code in
the MAINTAINERS file.

For example, you added to the discussion here:

   https://lore.kernel.org/all/65dcdd9c-a75b-4fe7-bdcf-471a5602db20@linaro.org/

And adding your Reviewed-by tag is appropriate.

But when a maintainer receives a Reviewed-by from someone they don't know,
without any discussion in the patch, it may make that maintainer think that
the person sending the Reviewed-by is only out to get listed in the LWN
"Reviewed-by" count.

I review other developers' code all the time, and unless the code touches
something I worked on or I'm marked as a reviewer in the MAINTAINERS file,
I do not send a Reviewed-by tag unless I added some input to the patch in
question.

My advice to you is to keep up the reviewing, I appreciate it (I really
do!), but don't send out Reviewed-by tags unless you are marked as a
reviewer of the code, or participated in a discussion on that code.

Thanks,

-- Steve
