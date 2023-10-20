Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219937D15CE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjJTSay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTSax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:30:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08541106
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:30:51 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso9206115ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697826650; x=1698431450; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cZuRq2gL8uMCs3ZHk4SNfObSI+VLtMFw8GdVz2Oq9JI=;
        b=L6KOYpZgmtlJXbw7dGwbdQ/zW7iCiULHX7NQcRahENgJVTcZcHQvtuITNSzTvqpojl
         nRwJ9YS++RgRHIKnHBZ47XwpMVEo5zBb/2qYXKWrnctpDXP2WtPi35QN6RMCm+BeUfmH
         EYXL+AZ95/i01liMAM/2jOcCrKR2gP5YlNzOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697826650; x=1698431450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZuRq2gL8uMCs3ZHk4SNfObSI+VLtMFw8GdVz2Oq9JI=;
        b=SMD5fijSQlrg7tWKlqT9U/qfPIOzySHy9BwsIEKQT2jI2jVD1zIhj0R1QeNqRLjgKF
         Q+KrwQMzQU5FXxYWJk08o1+o1EP2HaPRT4fRHgT9Y/EK35+WQQtkE407lQj71zL06Wjh
         NA+mCxCVaSgWpJ7AdB0Zqjxrti5854zcIZfP/Vcr60+mq3mSQDJB7krQ8TR7FmGFodWG
         ci/OwyLSQwjbG2qZycsnUsxs63fZfdsFIHP0z+3d41/gXOznzOc0J7q3ypN/+CSueF0I
         9pgYP7rfpy6gwBDBpwHFeXuKpnmBHA8GFOkBKC4jCyI8RqSAi+6yRvOWrWNzE20WdAlE
         F6sA==
X-Gm-Message-State: AOJu0YwW6ysVdtRhb6q4YNqMPSmZ6sZLZ38agP8uur65fdOYSQrMMr53
        PwclKzA9V06C1KLRohsC7f4hYA==
X-Google-Smtp-Source: AGHT+IEQ/F2SAMlnSzkRLURMBAtWQ6fc35crjlE5m0/e74pZblxdiqWb1ZN3RkP4kY40SbLz7aRDKw==
X-Received: by 2002:a17:902:e5d0:b0:1c9:e2ed:66fe with SMTP id u16-20020a170902e5d000b001c9e2ed66femr2549273plf.52.1697826650428;
        Fri, 20 Oct 2023 11:30:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jc15-20020a17090325cf00b001c746b986e5sm1839961plb.45.2023.10.20.11.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:30:49 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:30:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Justin Stitt <justinstitt@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <202310201127.DA7EDAFE4D@keescook>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de>
 <202310182248.9E197FFD5@keescook>
 <20231020044645.GC11984@lst.de>
 <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 10:40:12AM -0700, Justin Stitt wrote:
> On Thu, Oct 19, 2023 at 9:46 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Oct 18, 2023 at 11:01:54PM -0700, Kees Cook wrote:
> > > Almost all of the remaining strncpy() usage is just string to string
> > > copying, but the corner cases that are being spun out that aren't
> > > strscpy() or strscpy_pad() are covered by strtomem(), kmemdup_nul(),
> > > and memcpy(). Each of these are a clear improvement since they remove
> > > the ambiguity of the intended behavior. Using seq_buf ends up being way
> > > more overhead than is needed.
> >
> > I'm really not sure strscpy is much of an improvement.  In this particular
> > case in most other places we simply use a snprintf for nqns, which seems
> > useful here to if we don't want the full buf.
> >
> > But switching to a completely undocumented helper like strscpy seems not
> > useful at all.

I'm curious where you looked and didn't find documentation -- perhaps
there is an improvement to be made to aim one to where the existing
documentation lives?

> 
> There's some docs at [1]. Perhaps there could be more?
> 
> [1]: https://elixir.bootlin.com/linux/v6.6-rc6/source/include/linux/fortify-string.h#L292

Right, And it's even valid kern-doc, which gets rendered in the kernel
API docs, along with all the other string functions:
https://docs.kernel.org/core-api/kernel-api.html#c.strscpy

-- 
Kees Cook
