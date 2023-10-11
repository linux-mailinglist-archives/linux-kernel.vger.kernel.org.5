Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911137C4977
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbjJKFyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjJKFym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:54:42 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98399B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 22:54:40 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7b07548b085so2722549241.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 22:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697003680; x=1697608480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vPU2MuLb43jGuGxMy78ARcGnL6uCt8vs2fvYLKygEqI=;
        b=UO9YJNMsBxqKTs2rsCAskp7YsbkHeQpeChT/yjck6G7P5sDVTq+PGs//siwRipiynG
         5i9N47wRGifMvxfFIo+UXqTGdeSwBbbNFX3g6kuXuY5MoNZxeCau++3MptZZjzInPerM
         SW8o+7AT56a2uV2f0mR886u0i9InYMO0uLzccdSEcMFC8EegFLRPEoRS4eSY6Y5s77te
         +mc98IVjDDIKzooUTLUz2Km6jQ6Q0KV4uNb9P03opgwVCRJm+o1FnG5LGWs9KpYrP1yg
         CiqFK1+GNbrnZOqVTGvz1hRlIbBJr5nbiIta0TKKyeoH+2sFLdEr5SatsCRGTBDiqTi2
         /IBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697003680; x=1697608480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPU2MuLb43jGuGxMy78ARcGnL6uCt8vs2fvYLKygEqI=;
        b=UKaPqpwAX9bTNxNv/t/b+dOZp8h2Lpo8M6CNqNQ4xgc4VZIMji3nC4DkdAHEuKLmWV
         67nkLoAOQ1QW8qBjV+dAswEVOsAMgDqjcDW/IUy8+6anEnPYDMglG8UMyeWsq5Vlca+A
         K3R5RkmWz2XdvpWNnIMQITTF4BMZJbWcO+y1qClEPp1oBPptMsavTTRCgSX3Z20alJhw
         y4T//6sf/O6XpdZVFYR0RS411qZkh4h6ASjxdN3sJAD7BSaEu6Vn+LN5zhBdx5N+Kw0J
         eIMOZm18KcqOL2HDgoL+XFsd2dDDtTgyEpheXtBDtndkqst/tTr1LS7JHsVQJS+T8kN9
         xn+w==
X-Gm-Message-State: AOJu0YwEjTWbQZoKzGoL2trgTAHt3q4YfiMVhUlXwKZRvoDRlZ/u5fpj
        REYi/k5yqW7sRFVEpy3Y21GsCy4dDGZmqXGcvEOlIg==
X-Google-Smtp-Source: AGHT+IFbi7f0QiU72mBg/L5fl/3tI2KIdepfDowwikwQZdAFpdTeLg0SjV2/B2Rv4VUqAP112RAcU5BkZ+cy3mtYVYA=
X-Received: by 2002:a67:fb59:0:b0:452:72ed:7020 with SMTP id
 e25-20020a67fb59000000b0045272ed7020mr19309017vsr.32.1697003679734; Tue, 10
 Oct 2023 22:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231006051801.423973-1-sumit.garg@linaro.org>
 <CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com> <8a8c14694d5ff62e385163bf0852fd3adb675087.camel@kernel.org>
In-Reply-To: <8a8c14694d5ff62e385163bf0852fd3adb675087.camel@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 11 Oct 2023 11:24:28 +0530
Message-ID: <CAFA6WYOkr0P6yy3S_8gV3vTDZQsRXb9WQ08B4=bgP6qWQ+-c5Q@mail.gmail.com>
Subject: Re: [PATCH v2] KEYS: trusted: Remove redundant static calls usage
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>, peterz@infradead.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        David.Kaplan@amd.com, bp@alien8.de, mingo@kernel.org,
        x86@kernel.org, regressions@leemhuis.info,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 00:35, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, 2023-10-10 at 11:28 -0700, Linus Torvalds wrote:
> > On Thu, 5 Oct 2023 at 22:18, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Static calls invocations aren't well supported from module __init and
> > > __exit functions. Especially the static call from cleanup_trusted() led
> > > to a crash on x86 kernel with CONFIG_DEBUG_VIRTUAL=y.
> > >
> > > However, the usage of static call invocations for trusted_key_init()
> > > and trusted_key_exit() don't add any value from either a performance or
> > > security perspective. Hence switch to use indirect function calls instead.
> >
> > I applied this patch to my tree, since it is a fix for the issue, and
> > doesn't change any logic otherwise.
> >
> > However, I do note that the code logic is completely broken. It was
> > broken before too, and apparently causes no problems, but it's still
> > wrong.
> >
> > That's a separate issue, and would want a separate patch, but since I
> > noticed it when applying this one, I'm replying here:
> >
> > > +               trusted_key_exit = trusted_key_sources[i].ops->exit;
> > >                 migratable = trusted_key_sources[i].ops->migratable;
> > >
> > > -               ret = static_call(trusted_key_init)();
> > > +               ret = trusted_key_sources[i].ops->init();
> > >                 if (!ret)
> > >                         break;
> >
> > Note how this sets "trusted_key_exit" even when the ->init() function fails.
>
> Sumit, can you remind me why this continues *on any failure*?

We should give other trust sources a chance to register for trusted
keys if the primary one fails.

-Sumit

>
> E.g. something like this would make more sense to me:
>
>                 ret = trusted_key_sources[i].ops->init();
>                 if (!ret) {
>                         static_call_update(trusted_key_seal, trusted_key_sources[i].ops->seal);
>                         static_call_update(trusted_key_unseal, trusted_key_sources[i].ops->unseal);
>                         static_call_update(trusted_key_get_random, get_random);
>                         static_call_update(trusted_key_exit, trusted_key_sources[i].ops->exit);
>                         migratable = trusted_key_sources[i].ops->migratable;
>                         break;
>                 }
>
>                 if (ret != -ENODEV)
>                         break;
> `
> BR, Jarkko
