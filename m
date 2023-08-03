Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12DA76E5CB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjHCKeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbjHCKeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:34:04 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C3BF5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:34:03 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9338e4695so11634011fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691058841; x=1691663641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xssq6HuuqKN2Ig2rF5/7qFRDdi6y4lBSkM6NwJlpiDk=;
        b=J961eCKfo2aGsgDWhV0WVBWw7rnE9G79errIN1OAK4iGPNpUBYHU5SkcDnOyRlYfhL
         6u3PfGb/W4fBk2BNj35Kj4HU1u9eZXqbul183vWOx+L0g+CXLqw55tLEFpBcjueG/jFx
         TMZFrzbqk1iJyoYb7u1KWZQRFNEf0Jf1USRR3In9g88QiMsLXFUsAdkMEIhWljUUF0y5
         58w8GywjH23OKytdq2Usi9Xn6ny+lSz7H6K3sIr4X2JboJaIdByGXM/N2zCZTRRkb8fn
         41CwSG738ZecET19I855sIS71P0SUG1SkxrOZygWXREPeLIth7EsARWsgrkT+eVh+7rG
         sTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691058841; x=1691663641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xssq6HuuqKN2Ig2rF5/7qFRDdi6y4lBSkM6NwJlpiDk=;
        b=eH2p4OM+ALeIBE/SCM8hEXCk5a4ms+f01oYwdhnizJBYRSLiQ+kH3lH/sGBEsG6ZsI
         z24wnsnUH9d6pUeIzfs3CssgiPQSTvQTRWu4x/ROfE9qewKH/ollZQXcpwdjbNSdkR+T
         c4dBFCYHZX8ATXG1tA8WfbLtC+3H5Y8CLKp5Hc2DHujMUKiJvhEe5hblMJn9r5qgRgFH
         xL7Yzl5j3d4A8RFN03k22oRCuM2iaJm7vQjx0PBlmqa4IcE701rG+9iuthbUcc/dtdoI
         hYFk79qnJYUy6EcGwpvSxlQbH4MMkLNZc6qoE33XonSYqZ/36EL34DtEvFzEsItIwLem
         /BIA==
X-Gm-Message-State: ABy/qLaLfrtbpHBJ5IXBiyvcpcu01J6ztjT49jWIFIKz8pCFP9VTa4sB
        MYIaEvet80oWjppvFHy5UlxHMw==
X-Google-Smtp-Source: APBJJlGPGUkg90Pft4TCcuHnUyjD/blL473+fQwsAgsjx/gNyIUveQvck8Oc1+lLctPzyLKCNKIs3Q==
X-Received: by 2002:a2e:3817:0:b0:2b6:da66:2d69 with SMTP id f23-20020a2e3817000000b002b6da662d69mr7078534lja.28.1691058841415;
        Thu, 03 Aug 2023 03:34:01 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fe26bf65e7sm3940327wms.13.2023.08.03.03.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 03:34:00 -0700 (PDT)
Date:   Thu, 3 Aug 2023 11:33:39 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v5 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZMuCg/J8gwbb0PXd@google.com>
References: <20230728164754.460767-1-vdonnefort@google.com>
 <20230728164754.460767-2-vdonnefort@google.com>
 <20230801132603.0b18c0eb@gandalf.local.home>
 <20230802074526.2fa479ab@gandalf.local.home>
 <ZMpMgA85+DyGirXa@google.com>
 <20230802111306.4f52c1c6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802111306.4f52c1c6@gandalf.local.home>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > And on the kernel side, just a function to update the "writer fields" of the
> > meta-page:
> > 
> >    static void rb_wake_up_waiters(struct irq_work *work)
> >    {
> >           struct rb_irq_work *rbwork = container_of(work, struct rb_irq_work, work);
> >   +       struct ring_buffer_per_cpu *cpu_buffer =
> >   +               container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
> >   +
> >   +       rb_update_meta_page(cpu_buffer);
> >    
> >           wake_up_all(&rbwork->waiters);
> > 
> > That would rate limit the number of updates to the meta-page without any irq storm?
> > 
> 
> Is poll an issue? It requires user space to do a system call to see if
> there's more data? But I guess that's not too much of an issue, as it needs
> to do the ioctl to get the reader page.

I don't think there's any problem with this approach, beside the extra system
call...

> 
> We could also add an option to the ioctl to block, or have the ioctl honor
> the NON_BLOCK flags of the fd?

... but indeed, we could block there. The userspace interface would be even simpler.
How about?

  +++ b/kernel/trace/trace.c
  @@ -8499,12 +8499,22 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
   {
          struct ftrace_buffer_info *info = file->private_data;
          struct trace_iterator *iter = &info->iter;
  +       int err;
  +
  +       if (cmd == TRACE_MMAP_IOCTL_GET_READER_PAGE) {
  +               if (!(file->f_flags & O_NONBLOCK)) {
  +                       err = ring_buffer_wait(iter->array_buffer->buffer,
  +                                              iter->cpu_file,
  +                                              iter->tr->buffer_percent);
  +                       if (err)
  +                               return err;
  +               }
   
  -       if (cmd == TRACE_MMAP_IOCTL_GET_READER_PAGE)
                  return ring_buffer_map_get_reader_page(iter->array_buffer->buffer,
                                                         iter->cpu_file);

> 
> -- Steve
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
