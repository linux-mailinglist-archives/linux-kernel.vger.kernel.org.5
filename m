Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9547C5AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjJKSEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjJKSET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:04:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652D89E;
        Wed, 11 Oct 2023 11:04:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-692b2bdfce9so30982b3a.3;
        Wed, 11 Oct 2023 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697047456; x=1697652256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVdVmZg52hW6WekTndMoeoclUBi/41WcYYuklZzQFhU=;
        b=IGplU5h5YxQxAOXU0s60oaAnZRPRJYc5Lh6gmDg1WeDUxdu4WFQHi0FvzWW2thbeC4
         EmwLRYSwZgV1EUU3Nlbers2wScgJ4nwZk3e0lEPGDixpz4FSQWMYDizIveR2J0u2idWB
         UZiRZYuIYn3yn14MkZlox5q3mm9F2vU6ou8FAsRqgq5dHTY4pm3xu8NeloEuxzb1E405
         HBvmWIMKU3CS2r01njmoaJ62epSVk/NkAYEE1guYU6XV1FPHxGOWyRuenLDQjZu4/G/X
         tyw1z7sNeij1bdxdrE0qj88DI2v2PrU6HpG2k6W+KntIqH1Ui5/QOPTbzWJLjTSsztgJ
         8Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697047456; x=1697652256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVdVmZg52hW6WekTndMoeoclUBi/41WcYYuklZzQFhU=;
        b=C7SoTBKV3U6h1Nq9UEm4Cf8tHBiXSzWDoo5zhFsKp3f1l61qAs6YBI0Ezj9XlhTHpE
         AiEBHzwAJxA/i3mCqKvA08zRVZFfeuc9jAr8Gi5q/TXCWhwzvHYPfGC7BW0zbxPpo9gg
         44FLIM1szZdu9mboiMURKuThvYPqLmEgkQdN0Svxz2T4zbOInZnCUtUarwWypZr5ZwQc
         XVzxqJBYjU+0VPhHRZS7/fzVoioUZb+BMMszndbk4y+ihxn5TqBGtZiiZ3Q7dpN1HX3A
         1DWo/A+vgzgEdh5B350nJiccAoJHmM6E/00llz7bEe32xWNXXk8D8A4tpZ+JDoLhUfk9
         fw1Q==
X-Gm-Message-State: AOJu0Ywe2/7z2bYQ1p0Q/NR/5qdxIz5D7gxe2xpw6h0zkhGggVuOmvvJ
        kz/KraD4+UN/Id8820BkX/VSoDQ650Q=
X-Google-Smtp-Source: AGHT+IFUwEJe+Lhn2xWyXnoyYJKi719/fpRhZ9eH5zF0QMBjBz4v72A47BUPEWkh1IFzw/EbsH2BlA==
X-Received: by 2002:a05:6a00:22ca:b0:690:454a:dc7b with SMTP id f10-20020a056a0022ca00b00690454adc7bmr24652307pfj.28.1697047455896;
        Wed, 11 Oct 2023 11:04:15 -0700 (PDT)
Received: from atom0118 ([2405:201:c009:52e1:23ff:45f1:c6fe:e28c])
        by smtp.gmail.com with ESMTPSA id q15-20020a62ae0f000000b00690c4577101sm10726910pff.140.2023.10.11.11.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:04:15 -0700 (PDT)
Date:   Wed, 11 Oct 2023 23:34:08 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org
Subject: Re: [PATCH v1] samples: kprobes: Fixes a typo
Message-ID: <20231011180408.GB51067@atom0118>
References: <20230817170819.77857-1-atulpant.linux@gmail.com>
 <20230923173040.GA159038@atom0118>
 <20231007153900.GA20160@atom0118>
 <20231009095103.6d08e72a@gandalf.local.home>
 <20231010000356.1805c6e0f517245161ebdf03@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010000356.1805c6e0f517245161ebdf03@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:03:56AM +0900, Masami Hiramatsu wrote:
> On Mon, 9 Oct 2023 09:51:03 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sat, 7 Oct 2023 21:09:00 +0530
> > Atul Kumar Pant <atulpant.linux@gmail.com> wrote:
> > 
> > > On Sat, Sep 23, 2023 at 11:00:46PM +0530, Atul Kumar Pant wrote:
> > > > On Thu, Aug 17, 2023 at 10:38:19PM +0530, Atul Kumar Pant wrote:  
> > > > > Fixes typo in a function name.
> > > > > 
> > > > > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > > > > ---
> > > > >  samples/kprobes/kretprobe_example.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
> > > > > index cbf16542d84e..ed79fd3d48fb 100644
> > > > > --- a/samples/kprobes/kretprobe_example.c
> > > > > +++ b/samples/kprobes/kretprobe_example.c
> > > > > @@ -35,7 +35,7 @@ struct my_data {
> > > > >  	ktime_t entry_stamp;
> > > > >  };
> > > > >  
> > > > > -/* Here we use the entry_hanlder to timestamp function entry */
> > > > > +/* Here we use the entry_handler to timestamp function entry */
> > > > >  static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
> > > > >  {
> > > > >  	struct my_data *data;
> > > > > -- 
> > > > > 2.25.1
> > > > >   
> > > > 
> > > > 	Hi all, can someone provide comments on this change.  
> > > 
> > > 			Hi all, can someone please review this change. It has been not
> > > 			reviewed for quite some time.
> > 
> > That's because trivial typos in comments are considered very low priority,
> > and are usually only added (if they are ever added) if the maintainer has
> > extra time, which may not be for a while.
> 
> Anyway, let me pick this. I found this in my inbox now. :)

	Thank you. Sorry for the redundant emails for reviewing the change :)
> 
> Thank you,
> 
> > 
> > -- Steve
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
