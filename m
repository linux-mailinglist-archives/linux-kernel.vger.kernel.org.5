Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE957FDF52
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjK2S3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjK2S3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:29:45 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143D6112
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:29:52 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b4734b975so397245e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701282590; x=1701887390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1PZV2QPewxHMt+nvpSEk026io2gN1RNWhVSG3HcbufI=;
        b=ZaduLkb+rOLxauZf9q5vfmcAfO7S3qqCezc+/2IQ/mnMFIvmVAZnYE1jpZqi1YfSzH
         B297LO5Q6VrWHBdTJQ5Ij1F1Hz7igqkG1bPzwE9+yzeLa71e8y1NmBYHuwKZm38rZx+Y
         k81vsoHeGD0ddBOTxC/PizgzKO453qtPHxZIDdD6SYcvbYNMml6likwRgtmvZQ91gqed
         56UM2MfE8eTxtIJIhGP3rQ1v85zXRl05/EawC1Pj3GNJUAKwDpLBC9mbV4ZM0KNbnJd2
         mBxCvhc6jM62d0cL17W3arjty8Zbh6VRwPvdxEqtp498H76hJc3/JKsTAr2JFFFdC1uP
         LqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701282590; x=1701887390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PZV2QPewxHMt+nvpSEk026io2gN1RNWhVSG3HcbufI=;
        b=ke705UDnqmAPJ3RVIhqTtgY1MdNav8bbM2EhiyM42kpFuJvSgJv7gyhFnl6V232UFQ
         7fu3otqKZRWwZxRv/cDSwpJf3jg8lYJzITj7KmziuDcc5VjInhAFxjF9m+RVkkUdh2/F
         vV7J+hjermWLboUSFcV3oeEI/AWdjXB1KtOfaYhsXggTWIj11TnXg5iRw4I1QeSJorpC
         Doc2eV4/cI4LdPu8aI04t+jfA+UWp1kGvo/8ScwkJFY+DvgoZC30YeyILmEnkFbAtUEZ
         HQe8wsxQTg4V2YJTcS9kd1QIjMYXno7DZAurg6rlcaPP8oSZn2/tOWbMNRoS810lgeCQ
         dIag==
X-Gm-Message-State: AOJu0Yx39CW7Kzt8q7yyOHxbWhfN7NCHZX/fkdoXdq6jvYgoLOI52fR7
        E5g9T4SHIMisZJIodVZo0+ID3MutxtI=
X-Google-Smtp-Source: AGHT+IHI7Jg7NWdN2dQmGOw5cIlj3MXJKetXHVlNzAuZAziMMd6csd8fyL5P3GvEV7dK0hIoGVOh4g==
X-Received: by 2002:a5d:48c9:0:b0:333:1c69:dd5 with SMTP id p9-20020a5d48c9000000b003331c690dd5mr971955wrs.6.1701282590188;
        Wed, 29 Nov 2023 10:29:50 -0800 (PST)
Received: from andrea ([31.189.63.178])
        by smtp.gmail.com with ESMTPSA id 2-20020a5d47a2000000b00332ff137c29sm10453314wrb.79.2023.11.29.10.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 10:29:49 -0800 (PST)
Date:   Wed, 29 Nov 2023 19:29:43 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com, charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] membarrier: riscv: Provide core serializing command
Message-ID: <ZWeDF0eHyOc/b9UJ@andrea>
References: <20231127103235.28442-1-parri.andrea@gmail.com>
 <20231127103235.28442-3-parri.andrea@gmail.com>
 <91ab0210-07f9-42c4-af7f-a98799250cf7@efficios.com>
 <ZWYDtB/otYvTMZWd@andrea>
 <0a84c0e0-2571-4c7f-82ae-a429f467a16b@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a84c0e0-2571-4c7f-82ae-a429f467a16b@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> > index 217fd4de61342..f63222513076d 100644
> > --- a/arch/riscv/mm/context.c
> > +++ b/arch/riscv/mm/context.c
> > @@ -323,6 +323,23 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
> >   	if (unlikely(prev == next))
> >   		return;
> > +#if defined(CONFIG_MEMBARRIER) && defined(CONFIG_SMP)
> > +	/*
> > +	 * The membarrier system call requires a full memory barrier
> > +	 * after storing to rq->curr, before going back to user-space.
> > +	 *
> > +	 * Only need the full barrier when switching between processes:
> > +	 * barrier when switching from kernel to userspace is not
> > +	 * required here, given that it is implied by mmdrop(); barrier
> > +	 * when switching from userspace to kernel is not needed after
> > +	 * store to rq->curr.
> > +	 */
> > +	if (unlikely(atomic_read(&next->membarrier_state) &
> > +		     (MEMBARRIER_STATE_PRIVATE_EXPEDITED |
> > +		      MEMBARRIER_STATE_GLOBAL_EXPEDITED)) && prev)
> > +		smp_mb();
> > +#endif
> 
> The approach looks good. Please implement it within a separate
> membarrier_arch_switch_mm() as done on powerpc.

Will do.  Thanks.

As regards the Fixes: tag, I guess it boils down to what we want or we
need to take for commit "riscv: Support membarrier private cmd".  :-)
FWIW, a quick git-log search confirmed that MEMBARRIER has been around
for quite some time in the RISC-V world (though I'm not familiar with
any of its mainstream uses): commit 1464d00b27b2 says (at least) since
93917ad50972 ("RISC-V: Add support for restartable sequence").  I am
currently inclined to pick the latter commit (and check it w/ Palmer),
but other suggestions are welcome.

  Andrea
