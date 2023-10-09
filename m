Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4297BE15B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377514AbjJINts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377502AbjJINtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:49:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10D69C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:49:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDFCC433CA;
        Mon,  9 Oct 2023 13:49:45 +0000 (UTC)
Date:   Mon, 9 Oct 2023 09:51:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org
Subject: Re: [PATCH v1] samples: kprobes: Fixes a typo
Message-ID: <20231009095103.6d08e72a@gandalf.local.home>
In-Reply-To: <20231007153900.GA20160@atom0118>
References: <20230817170819.77857-1-atulpant.linux@gmail.com>
        <20230923173040.GA159038@atom0118>
        <20231007153900.GA20160@atom0118>
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

On Sat, 7 Oct 2023 21:09:00 +0530
Atul Kumar Pant <atulpant.linux@gmail.com> wrote:

> On Sat, Sep 23, 2023 at 11:00:46PM +0530, Atul Kumar Pant wrote:
> > On Thu, Aug 17, 2023 at 10:38:19PM +0530, Atul Kumar Pant wrote:  
> > > Fixes typo in a function name.
> > > 
> > > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > > ---
> > >  samples/kprobes/kretprobe_example.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
> > > index cbf16542d84e..ed79fd3d48fb 100644
> > > --- a/samples/kprobes/kretprobe_example.c
> > > +++ b/samples/kprobes/kretprobe_example.c
> > > @@ -35,7 +35,7 @@ struct my_data {
> > >  	ktime_t entry_stamp;
> > >  };
> > >  
> > > -/* Here we use the entry_hanlder to timestamp function entry */
> > > +/* Here we use the entry_handler to timestamp function entry */
> > >  static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
> > >  {
> > >  	struct my_data *data;
> > > -- 
> > > 2.25.1
> > >   
> > 
> > 	Hi all, can someone provide comments on this change.  
> 
> 			Hi all, can someone please review this change. It has been not
> 			reviewed for quite some time.

That's because trivial typos in comments are considered very low priority,
and are usually only added (if they are ever added) if the maintainer has
extra time, which may not be for a while.

-- Steve
