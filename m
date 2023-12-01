Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788998004FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377691AbjLAHqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjLAHq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:46:29 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D108010F3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:46:35 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b8412723c4so141225b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701416795; x=1702021595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1n1B2RLe2dF9RZpTZD6jV4ZPlx3n71Tr2g0HI0zRde0=;
        b=ZXSL/IsqFXayycUbPd22rH7C/4AyAzmb2OpZpA3z3AVaMCrWZM9DYI1sM+PcVAfkoQ
         q3wwuicGRx7Y36kytlGYxxXSu+XImr1vASgPDBipNzze8lp/OddC5z4ZR34/awinbMH0
         igHn6Rnzwl+Oc03Do7z+QQmUM/QcxwmqAx2ItYRlpyr7XLvhmfRk3u64njseN9yljrXD
         1tqmXdrVE5TcJgT7wh5jakotM/3L7JYembUpHHjBVXr9HVtCmta7yuwx7gBe6dq9DRVj
         y3BpUM1OmbWzICA1QayIogVc5k4tR7ljUtMfRWE3cgulkeS1ADpxkOih+I0RKMeUTHPx
         6aRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701416795; x=1702021595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1n1B2RLe2dF9RZpTZD6jV4ZPlx3n71Tr2g0HI0zRde0=;
        b=S17ZbqOYUQB4bezIKqIJYhIh9vVWAI/LQxctced6uietDk9fl8F1zRZqoXfaPH5xHx
         Z6LccqWUmlZ81g66wyGJn5OIU9UizJQ6TIMZSwfa0kO6Q7tc6McMTirCnffz2QmyMQn9
         xYsqygB9MTQM7ybbmAM3U0LC9qKZgluTQR7i3ERG1fePZMmfOiFlT1zudtjwnQcWgKn9
         i66mTyjki/iba6ID4JKjGyamQLcV1jsZaGAYQQur5lA3XUmTviDcmPHddhg1ZMdAMZmg
         g0XgBRknzXEUSva3rDOK3ZkI/9+z/r3snJDajyktZGdJ+MIajDpE6e0T8DgKhHafsMJP
         aiuQ==
X-Gm-Message-State: AOJu0YzxPUNnMUVzV19emMB9q3xCgzRPYOAc37QxMeLJE0t85sBnnDDQ
        D8OqLsisdM/yCb37L0fitX+5sg==
X-Google-Smtp-Source: AGHT+IGJ/0Uzb7wM9BLtcG3wD7lSboIxI7WYxrS+WgHLIRMr74dI1tehnao3O3wfy+ur8NYYHL6/gg==
X-Received: by 2002:a05:6808:13d5:b0:398:5d57:3d08 with SMTP id d21-20020a05680813d500b003985d573d08mr2327432oiw.37.1701416795060;
        Thu, 30 Nov 2023 23:46:35 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id e8-20020aa798c8000000b006cdd5dfc116sm2475258pfm.173.2023.11.30.23.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:46:34 -0800 (PST)
Date:   Fri, 1 Dec 2023 07:46:31 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>
Subject: Re: [PATCH 21/21] binder: switch alloc->mutex to spinlock_t
Message-ID: <ZWmPV-N7Ua795HQ9@google.com>
References: <20231102185934.773885-22-cmllamas@google.com>
 <20231107090849.262070-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107090849.262070-1-aliceryhl@google.com>
X-Spam-Status: No, score=-13.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 09:08:49AM +0000, Alice Ryhl wrote:
> Carlos Llamas <cmllamas@google.com> writes:
> > The alloc->mutex is a highly contended lock that causes performance
> > issues on Android devices. When a low-priority task is given this lock
> > and it sleeps, it becomes difficult for the task to wakeup and complete
> > its work. This delays other tasks that are also waiting on the mutex.
> 
> Grammar nit: "to wake up"

OK.

> 
> > The problem gets worse when there is memory pressure in the system,
> > because this increases the contention on the alloc->mutex while the
> > shrinker reclaims binder pages.
> > 
> > Switching to a spinlock helps to keep the waiters running and avoids the
> > overhead of waking up tasks. This significantly improves the transaction
> > latency when the problematic scenario occurs.
> >
> > [snip]
> >
> > Note that it is only possible to convert this lock after a series of
> > changes made by previous patches. These mainly include refactoring the
> > sections that might_sleep() and changing the locking order with the
> > mmap_lock amongst others.
> > 
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> Nice!
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> >  	 * binder_free_buf_locked(). However, that could
> > -	 * increase contention for the alloc mutex if clear_on_free
> > -	 * is used frequently for large buffers. The mutex is not
> > +	 * increase contention for the alloc->lock if clear_on_free
> > +	 * is used frequently for large buffers. This lock is not
> 
> Grammar nit: Shouldn't this say "However, that could increase contention
> on alloc->lock if clear_on_free is used frequently for large buffers."?

Do you mean "contention for" vs "contention on"? They both seem correct
to me but this was written by Todd, so I'd trust his english much more
than mine.

--
Carlos Llamas
