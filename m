Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D00575292C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbjGMQxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbjGMQxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:53:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19402D40
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:53:22 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8bbcfd89aso5578665ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689267202; x=1691859202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NoNGGvzPoC+CfmJaMdzXCn37KFGOyeGfI/UvmRM+Do0=;
        b=G9AtbbPvATaVSbvSLJQJamXs5udACD6yAYKkKVVbhuaLC65+5LQidnKuoPpjeWgaYV
         Kkq8yIQGtzi7ifWRea8+yytsz/kAGVCRcxsJZdCBkiGqZ9K4yKEPdGjomttT8OLr5UOB
         H4rvrN3juTFhitd2ZgQHx5oFthRgOwbJqCdV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267202; x=1691859202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoNGGvzPoC+CfmJaMdzXCn37KFGOyeGfI/UvmRM+Do0=;
        b=URGheubER+EuePi+XUQiPnxn1NLDkdBKie/xWDqxVluFHT+vYuDoIcIJMujTjcS3jv
         gJlrlGswCCb3jsVEwPQ6lG/yfU8I5QU+qLT2KHdLI9n/u0Yrx/EwAgju62G5yAjey2gk
         KImEDY+BIenQe+xhHhrwdzi8B9lsTa3mMPLYTkIhng2O+s6M1+E/401G4ZQ+x6Jvk+/e
         Nb1K3jp1hRWnojUZ1LD8repLNcIbSsD6Nt8x8uH/Hp91mHMLLHYycuk5Wn4mhfnHzPEb
         +S0hgBkFNJf+0kA7T1fTBARgg4oijKqintiy8pvsXjY44We1w2QE11c+uX7CIAq78z6A
         UKUA==
X-Gm-Message-State: ABy/qLYT7MFaYtl6eglb/A9Cqm7sbfgphhNeHYdP4upZErAHoRBS8h2Z
        DVvwkTIBw0J1Pz75cG0Fnm6ryw==
X-Google-Smtp-Source: APBJJlHkhNi7qzNBIMq9ENOHZGdML1MCvQrdLivOAcrVfd4jNxyTp4Ll/r2OE+3aX72+qVOTZosNkQ==
X-Received: by 2002:a17:903:482:b0:1b8:a2af:fe23 with SMTP id jj2-20020a170903048200b001b8a2affe23mr1383903plb.2.1689267202150;
        Thu, 13 Jul 2023 09:53:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090274cb00b001b077301a58sm6134977plt.79.2023.07.13.09.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:53:21 -0700 (PDT)
Date:   Thu, 13 Jul 2023 09:53:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] tracing: Add back FORTIFY_SOURCE logic to kernel_stack
 event structure
Message-ID: <202307130953.B54C43B@keescook>
References: <20230713092605.2ddb9788@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713092605.2ddb9788@rorschach.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 09:26:05AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> For backward compatibility, older tooling expects to see the kernel_stack
> event with a "caller" field that is a fixed size array of 8 addresses. The
> code now supports more than 8 with an added "size" field that states the
> real number of entries. But the "caller" field still just looks like a
> fixed size to user space.
> 
> Since the tracing macros that create the user space format files also
> creates the structures that those files represent, the kernel_stack event
> structure had its "caller" field a fixed size of 8, but in reality, when
> it is allocated on the ring buffer, it can hold more if the stack trace is
> bigger that 8 functions. The copying of these entries was simply done with
> a memcpy():
> 
>   size = nr_entries * sizeof(unsigned long);
>   memcpy(entry->caller, fstack->calls, size);
> 
> The FORTIFY_SOURCE logic noticed at runtime that when the nr_entries was
> larger than 8, that the memcpy() was writing more than what the structure
> stated it can hold and it complained about it. This is because the
> FORTIFY_SOURCE code is unaware that the amount allocated is actually
> enough to hold the size. It does not expect that a fixed size field will
> hold more than the fixed size.
> 
> This was originally solved by hiding the caller assignment with some
> pointer arithmetic.
> 
>   ptr = ring_buffer_data();
>   entry = ptr;
> 
>   ptr += offsetof(typeof(*entry), caller);
>   memcpy(ptr, fstack->calls, size);
> 
> But it is considered bad form to hide from kernel hardening. Instead, make
> it work nicely with FORTIFY_SOURCE by adding a new __stack_array() macro
> that is specific for this one special use case. The macro will take 4
> arguments: type, item, len, field (whereas the __array() macro takes just
> the first three). This macro will act just like the __array() macro when
> creating the code to deal with the format file that is exposed to user
> space. But for the kernel, it will turn the caller field into:
> 
>   type item[] __counted_by(field);
> 
> or for this instance:
> 
>   unsigned long caller[] __counted_by(size);
> 
> Now the kernel code can expose the assignment of the caller to the
> FORTIFY_SOURCE and everyone is happy!
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20230712105235.5fc441aa@gandalf.local.home/
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Yay! This looks good. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
