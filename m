Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1547C5ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbjJKSDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbjJKSDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:03:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C24CD7;
        Wed, 11 Oct 2023 11:02:58 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690bf8fdd1aso28110b3a.2;
        Wed, 11 Oct 2023 11:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697047376; x=1697652176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IhrDqt6wT+HBPU0WXsWFtClOPq+53ObuSHJOrsqvDGI=;
        b=ZQbJRgdcT89Bb+s9X5BpbjBavcUFmGXmyuXJVClUEgfVroecfhFiT3Tco8JvOpA0B3
         N7kVpn2nOVkSpYhoxZDgDYKFpyrqXHsFZP9+rZ6/hw/DP1RDsmKbf8geHcJYBkDrJVAS
         5gqI6rAr8hIQ7PTHjakPJJdx8jHBfvgax9Q5IIRHpF7NWK6/YQc6lr4vtAj2uoXTH63Y
         29tyeVi1ET9lK/7dh40nzXr0SdNcalWpLoma90Jtc052Y4cAqqK3JMh0iiSny8yX69tW
         3JzDVfYnfyVNDxZpVZvKkhZB8Q6ktgKbKXMuh64KIWX4GoyvKVrHQ3K/kRCFBJwsJED2
         Pkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697047376; x=1697652176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhrDqt6wT+HBPU0WXsWFtClOPq+53ObuSHJOrsqvDGI=;
        b=S7ak6RuHpFhAxmHeMTkN6PpBs1CGFbqxY/kHlb+X/IDgjVXNATTf4PV8BRdyVzJDvs
         5zyKmQY2TLQcwCpwHWlkj3YIYtdC4KyUny9XADnWHl7992VMp9LPWe6sJ2p+5lOBNkIE
         1sB/4tfWmKLZxWpmAxL3QflU/30DehgfkjaPHo52Yttz0oMEMAGZ3lm47wRn0YUrBH4V
         +SiRkVs2poGcJRaoJaEKQtYUJOuvhOuSJ07IA+EZthuFicn+rsxGwoS5Rz21eBCkTkSu
         v6h9GbUDomooiUbtojRCOhZrT+dHDZC0HxO0irxBEs+eYkxtwVycbEz2JdRJ9w2RmaTU
         COzg==
X-Gm-Message-State: AOJu0YwSiNW1aGwp6JKAy6bNL2wkHqIgMQDcfBUa6W8r9Z2YyqdqiXce
        YUR0AqlPJtOa9eOZlxDvpB4=
X-Google-Smtp-Source: AGHT+IG/ziOao/lKdC5T4mQ05hUhMzyts3NQzjrRBzke7glqqWrfDqejAnL3KiRfOQg5siWisUwPoA==
X-Received: by 2002:a17:90a:fd8e:b0:27c:fc09:401d with SMTP id cx14-20020a17090afd8e00b0027cfc09401dmr3995106pjb.38.1697047376352;
        Wed, 11 Oct 2023 11:02:56 -0700 (PDT)
Received: from atom0118 ([2405:201:c009:52e1:23ff:45f1:c6fe:e28c])
        by smtp.gmail.com with ESMTPSA id f64-20020a17090a704600b0027ce7ee8859sm239240pjk.13.2023.10.11.11.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:02:55 -0700 (PDT)
Date:   Wed, 11 Oct 2023 23:32:48 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org
Subject: Re: [PATCH v1] samples: kprobes: Fixes a typo
Message-ID: <20231011180248.GA51067@atom0118>
References: <20230817170819.77857-1-atulpant.linux@gmail.com>
 <20230923173040.GA159038@atom0118>
 <20231007153900.GA20160@atom0118>
 <20231009095103.6d08e72a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009095103.6d08e72a@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 09:51:03AM -0400, Steven Rostedt wrote:
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
> 
> -- Steve

	Thank you Steve for the response. I wasn't aware of this.
