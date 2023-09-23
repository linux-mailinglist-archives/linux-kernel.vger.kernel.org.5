Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C327ABD95
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 05:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjIWD0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 23:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjIWD0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 23:26:08 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA841A6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 20:26:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso2905709b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 20:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695439561; x=1696044361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LR9DR3BeUG86XkT5sEqTxjBnOBqP8nuIev7GEpE4GGc=;
        b=ZixLuEXkt7URqTMWYy/LiOvTr+2VBk7oX8tD4FFTvs127Gt+hwzaVCCHBuwmbcAR6q
         uFAzMoku/QEbYpnCeDstaHUSGeLwMqO6ONaRVroiZgNB4ylk4ICP1gCaAXQzOyKvrfa/
         bVlkHy1kfghMx1ABW28YhSRDOD2XIdD5ROcIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695439561; x=1696044361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR9DR3BeUG86XkT5sEqTxjBnOBqP8nuIev7GEpE4GGc=;
        b=olS1HcddiXYYb/+y21/S25SFAJlRTFl6SyzU0y9OTuj5oEys8uUhVAJiREdKfNbF4O
         Usx6Vq/IklmN0OIUQ3DsOFzS4JjkX2OClWApbyrCm2F3PPrsMAHJcVcP2q5TPAcrzQ9S
         T+AMZx+k9WL/nxzvjxLUsnsGihZxRz1pprDMkPqR1G3UkUDs2WO2/o7FvtcpDuTqcNub
         8ijlL4+cbYwX0hsjHIw70CMBsZe1JYnoFVB7UQlxYcqwvEexrwHnEc4Q7geY4hD6TKsb
         QFNUza5r0ZH6mWCvjWGpRZNDS9GqbnwRXzuw0dIxFN/yDrt7EYcFFXjBbN/3Xxfijna7
         do6g==
X-Gm-Message-State: AOJu0YyGGeF7a3wstCYnDv5wjxBMLLt0RdTtkf7/S/B5V40SsISJcT/P
        FBCz0lG2cbqzJPxmgX4e2UAtHQ==
X-Google-Smtp-Source: AGHT+IG+yKlVthCSQJVmhQADSNEyr7VJLqnwS4nHKn7LFSAEe8auAjxigMDQH74ce+YiDA1xBlG0bQ==
X-Received: by 2002:a05:6a00:2d85:b0:690:c5cf:91f4 with SMTP id fb5-20020a056a002d8500b00690c5cf91f4mr1235039pfb.12.1695439561233;
        Fri, 22 Sep 2023 20:26:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b0068fe8a42f45sm3894818pfm.207.2023.09.22.20.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 20:26:00 -0700 (PDT)
Date:   Fri, 22 Sep 2023 20:25:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] kexec: Annotate struct crash_mem with __counted_by
Message-ID: <202309222012.49E3C0AA@keescook>
References: <20230922175224.work.712-kees@kernel.org>
 <ZQ41d5majBepW48Z@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQ41d5majBepW48Z@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 08:46:47AM +0800, Baoquan He wrote:
> On 09/22/23 at 10:52am, Kees Cook wrote:
> > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> > 
> > As found with Coccinelle[1], add __counted_by for struct crash_mem.
> > 
> > [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> > 
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: kexec@lists.infradead.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/crash_core.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> > index 3426f6eef60b..5126a4fecb44 100644
> > --- a/include/linux/crash_core.h
> > +++ b/include/linux/crash_core.h
> > @@ -131,7 +131,7 @@ static inline void __init reserve_crashkernel_generic(char *cmdline,
> >  struct crash_mem {
> >  	unsigned int max_nr_ranges;
> >  	unsigned int nr_ranges;
> > -	struct range ranges[];
> > +	struct range ranges[] __counted_by(max_nr_ranges);
> 
> This __counted_by() only makes sense when there's a obvious upper
> boundary, max_nr_ranges in this case.

Yes; it's designed to be the array element count used for the
allocation. For example with the above case:

        nr_ranges += 2;
        cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
        if (!cmem)
                return NULL;

        cmem->max_nr_ranges = nr_ranges;
        cmem->nr_ranges = 0;

nr_ranges is the max count of the elements.

_However_, if a structure (like this one) has _two_ counters, one for
"in use" and another for "max available", __counted_by could specify the
"in use" case, as long as array indexing only happens when that "in use"
has been updated. So, if it were:

struct crash_mem {
    unsigned int max_nr_ranges;
    unsigned int nr_ranges;
    struct range ranges[] __counted_by(nr_ranges);
};

then this would trigger the bounds checking:

	cmem->ranges[0] = some_range;	/* "nr_ranges" is still 0 so index 0 isn't allowed */
	cmem->nr_ranges ++;

but this would not:

	cmem->nr_ranges ++;		/* index 0 is now available for use. */
	cmem->ranges[0] = some_range;

> This heavily depends and isn't much in kernel?

Which "this" do you mean? The tracking of max allocation is common.
Tracking max and "in use" happens in some places (like here), but is
less common.

> E.g struct swap_info_struct->avail_lists[].

This is even less common: tracking the count externally from the struct,
as done there with nr_node_ids. Shakeel asked a very similar question
and also pointed out nr_node_ids:
https://lore.kernel.org/all/202309221128.6AC35E3@keescook/

> Just curious, not related to this patch though.

I'm happy to answer questions! Yeah, as I said in the above thread,
I expect to expand what __counted_by can use, and I suspect (hope)
a global would be easier to add than an arbitrary expression. :)

-Kees

-- 
Kees Cook
