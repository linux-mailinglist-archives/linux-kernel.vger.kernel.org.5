Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A340813371
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573389AbjLNOpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjLNOpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:45:17 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6548D91;
        Thu, 14 Dec 2023 06:45:23 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-28af2f9a0f6so1015417a91.0;
        Thu, 14 Dec 2023 06:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702565123; x=1703169923; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0OGUCjiWquGGsTrpvsPwR69C78xlzg3lziD6TLbqES8=;
        b=RZ8Zs4fy02E4KcM8ysZ3MCN0dhSQ34LVTlyv1f/WCBY3+b6GjRZgQt9wnb51rwNm2N
         Bje+Shd0RS5STqjPkfaG9p6yuxGYT3HlBl8pvzqW2U5/JncQyFWBFXpmOR1MT3A+UoWk
         /6TJBEM5nfmKoKuQMpTV1cgrnY+c6asTb4L0ATMFKBn0+m6ODcxU7A0/GtETemNEEGuv
         qSq2HkJWJLTQjX3lZTZ8luy4jpEYo5usbs6pkQNpgzDlFRHVxImL5SebUFT/b+Yj9tA4
         k6JgRcaxzXgGZn9Xe3mmOJpGeztW33bJFqUhMaAuJ/+ZPFJcLSSYdpVTqi13RVxC/YAB
         bVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702565123; x=1703169923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OGUCjiWquGGsTrpvsPwR69C78xlzg3lziD6TLbqES8=;
        b=k9/bqfWw0bodtTytzGiM/5XLdfS6MftupSzwleull5BHsvXyPcMZEOnhcM3EagxEQu
         fH89JmvrDOBcCi4+xRDK0t1ve5aKyYlBHOSC18Q74s65ypP2daVcmXoC7YWGexnGsimu
         fgN1mC+rriM1mpno/lpWYPIwa3QoQqJsvkMInMxtoz37jCN3cE5j/RqxqhEaEARVA+nh
         ryJRUdhMoOJ8Ehgi7nNHq88ekb6r6hg6cK75VjjzuLJSb/up60fAR+WDcy7vZTH9V1AV
         YpHwblYKOrN63trTjgLSoGmLIY8m3EYjP//6E4tWeIkaNQmLNiSrtj5OOjqY06MvIR9N
         FIcw==
X-Gm-Message-State: AOJu0Yx3lpFvFAGMOdtAb+PHfWkd4qhJkU7Jainpl63H3OCgacnBu0sJ
        bVSeOyfpZ07gWLkp+EO8U/k=
X-Google-Smtp-Source: AGHT+IHlvDwW8/5QhXnoHYWgF0ufF5XpxbzlaA0e2gNQShtcPzR0gE3UtTlJOecqDkGfggAg8j5Qvw==
X-Received: by 2002:a17:90b:1d0d:b0:286:6cc1:2cc2 with SMTP id on13-20020a17090b1d0d00b002866cc12cc2mr4538662pjb.76.1702565122780;
        Thu, 14 Dec 2023 06:45:22 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id nb11-20020a17090b35cb00b0028017a2a8fasm13360780pjb.3.2023.12.14.06.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 06:45:22 -0800 (PST)
Date:   Thu, 14 Dec 2023 22:45:17 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, andy@kernel.org
Subject: Re: [PATCH v2 2/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
Message-ID: <ZXsU_UN6g0Fdj4qx@rigel>
References: <20231214095814.132400-1-warthog618@gmail.com>
 <20231214095814.132400-3-warthog618@gmail.com>
 <CAMRc=MeoeOgZaz6xT+ScVjOemVovrEHvQDBvqsN1pD9U3haE_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeoeOgZaz6xT+ScVjOemVovrEHvQDBvqsN1pD9U3haE_A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 03:29:28PM +0100, Bartosz Golaszewski wrote:
> On Thu, Dec 14, 2023 at 10:58 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> >
> > +/*
> > + * Used to populate gpio_v2_line_info with cdev specific fields not contained
> > + * in the struct gpio_desc.
> > + * A line is determined to contain supplemental information by
> > + * line_is_supplemental().
> > + */
> > +static struct {
> > +       /* a rbtree of the struct lines containing the supplemental info */
> > +       struct rb_root tree;
> > +       /* covers tree */
> > +       spinlock_t lock;
>
> Looks like this is never taken from atomic context? Can this be a mutex instead?
>

Correct, only from thread context.

Can be a mutex, but it only covers tree lookups which should be quick
as the tree is kept minimal, and I wouldn't expect it to ever get to the
mutex slowpath, so a spinlock seemed more appropriate.

Cheers,
Kent.
