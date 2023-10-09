Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EB67BE3D0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376348AbjJIPEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJIPEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:04:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9166BAF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:04:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668CAC433C7;
        Mon,  9 Oct 2023 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696863842;
        bh=zB+vI20UfPAoIRDFm4Wc3RigAKAOlJQXx6ZG9XBMgtU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X6kFfEI4HpwGjzHjtOzXmkTx/+6u72xXY8H7ww/5qDY2nhVN81Fj6QaE58qWjoxng
         NsYO21WczbjklYww+dY+HfEEmT5pywPC1VFv35AGphK7rOxfnsUHfPEBwQUFRZwGwZ
         8z78vN4K8b0BGXjXV596E9NN8EwUX5bLb7G7GSLfLG9uXNC35stIsbhlrkBDz6qTf/
         5dCXhoxKBix+k807kRU7R/e7mTylWjKvBBPytgUSC83b2O/YHmHlyf0YXwkAbiOaq4
         LM41jMrd3WKOTsERWM56INn6efOz0yeEkJx1I/JQtK1KjcI8Fc3NdgfxNlUXx933Xc
         by1xxCh/24I6w==
Date:   Tue, 10 Oct 2023 00:03:56 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org
Subject: Re: [PATCH v1] samples: kprobes: Fixes a typo
Message-Id: <20231010000356.1805c6e0f517245161ebdf03@kernel.org>
In-Reply-To: <20231009095103.6d08e72a@gandalf.local.home>
References: <20230817170819.77857-1-atulpant.linux@gmail.com>
        <20230923173040.GA159038@atom0118>
        <20231007153900.GA20160@atom0118>
        <20231009095103.6d08e72a@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2023 09:51:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 7 Oct 2023 21:09:00 +0530
> Atul Kumar Pant <atulpant.linux@gmail.com> wrote:
> 
> > On Sat, Sep 23, 2023 at 11:00:46PM +0530, Atul Kumar Pant wrote:
> > > On Thu, Aug 17, 2023 at 10:38:19PM +0530, Atul Kumar Pant wrote:  
> > > > Fixes typo in a function name.
> > > > 
> > > > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > > > ---
> > > >  samples/kprobes/kretprobe_example.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
> > > > index cbf16542d84e..ed79fd3d48fb 100644
> > > > --- a/samples/kprobes/kretprobe_example.c
> > > > +++ b/samples/kprobes/kretprobe_example.c
> > > > @@ -35,7 +35,7 @@ struct my_data {
> > > >  	ktime_t entry_stamp;
> > > >  };
> > > >  
> > > > -/* Here we use the entry_hanlder to timestamp function entry */
> > > > +/* Here we use the entry_handler to timestamp function entry */
> > > >  static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
> > > >  {
> > > >  	struct my_data *data;
> > > > -- 
> > > > 2.25.1
> > > >   
> > > 
> > > 	Hi all, can someone provide comments on this change.  
> > 
> > 			Hi all, can someone please review this change. It has been not
> > 			reviewed for quite some time.
> 
> That's because trivial typos in comments are considered very low priority,
> and are usually only added (if they are ever added) if the maintainer has
> extra time, which may not be for a while.

Anyway, let me pick this. I found this in my inbox now. :)

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
