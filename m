Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66D47B9E31
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjJEN6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjJEN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:56:30 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2063E49E2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 22:09:20 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7b0ec7417bdso231013241.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 22:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696482559; x=1697087359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7bEBtEYjPvvx61gyTmPre8FgWkZQY7aYUEmeh34j9bY=;
        b=ef6ui0Tgz/BabvsXqsDNOh7CZwb2485FoapDPuyDwe12/0WfTjVj5t7I0g2jAjUxJj
         79wp2tMMGga9I2GEN+UfeciKYW+lCRi32lwRbsdFcNY0t0TwzyW2PLjHAsYLUeOYlsRW
         BDYlonPvTiYZrCQGAC57MtU4Xmr7QQ5Z2fvjok2EhM2K+BKPeVa1qPTt86hmVr8YLC0U
         JtVLt6FvfpbTTl9SvznVbykjuMZb9VDxB9SmDlLiKSnUC4H/rZmxcCINI8RWwskpXR0H
         NpBLU92WrA9589ylDnvyG0q4yL16J42Q4R7JiwfvNRxlH+GCwlll/GlvQt/jPJf71Wsf
         6vHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696482559; x=1697087359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bEBtEYjPvvx61gyTmPre8FgWkZQY7aYUEmeh34j9bY=;
        b=n8vhbiiYM+LjfBW3v43FdjwTpnqPfcAGwh0/2trKITPe6UxAVeYumqGDfNrYnr5M3Q
         T3eMtPfLfW1xNjRw8w21UF/FRFS+xiScO7hytxhN1uBVWyjQnLlfHgHICaifJwRpXIQl
         +MQe33f6YwG6/mb0BN/2FS88qy4GMzr3WttxwLOLz12CdFz+ywIvFTa96uXiThVs4R+w
         9DIEhXRp+6cCaCOa8T9ZZjAN0vLVXSzV4egl+luz+1JrIhy+x6ZCz8zRNNYDaVgnExOT
         Kf2RwJZPAxsgoQIEfzLlD7r05a5MCQSXrL9ueNe2LpqrFjt2Rn2OZSAkIS41Sl6T1Von
         bHAg==
X-Gm-Message-State: AOJu0Yyrt2cbUS2GsnfmpPlNpIhVqv+vIVXZnDDNivAdGT7yWwHZeoiM
        ktpw74thtOOtsNQB6OfO7E4AcUZd2EtvA7Q8zz0Lxg==
X-Google-Smtp-Source: AGHT+IEmsVk+ScjHbQ3jhM5HJo34k8xVptKNZ+whqSl1OcAeZX+EGApqLDrnlovRf4mPN0muKVjgWJqH2cfpMeNfRwc=
X-Received: by 2002:a05:6102:34f6:b0:452:721b:1cae with SMTP id
 bi22-20020a05610234f600b00452721b1caemr4326904vsb.0.1696482558795; Wed, 04
 Oct 2023 22:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjrZgxjHZuXwrGeFnng_whUmtToCWE5GQ+HORhGSeiX8g@mail.gmail.com>
 <ZRhKq6e5nF/4ZIV1@fedora> <CAB=+i9QiJ=BXkQuCFJTh3dMXrkKQvVA2EM51Mj6SsDMimWQ71g@mail.gmail.com>
 <CAHk-=whosoBSLAWzSGUZ8s=UwAVG9rsQ9OVPvw97S2RRFGfk2A@mail.gmail.com>
 <5427bc3d-1e14-781a-53a2-f702774715f4@linaro.org> <CAHk-=whJjhoq2wGOx9e0zK7-EouqdaRREvmJJLN+HX-Zht3miQ@mail.gmail.com>
In-Reply-To: <CAHk-=whJjhoq2wGOx9e0zK7-EouqdaRREvmJJLN+HX-Zht3miQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 5 Oct 2023 10:39:07 +0530
Message-ID: <CAFA6WYMzhjDW46Qm0hBxmbE=_rdjG7ibEYtM9Rgq-gwQ1GU20w@mail.gmail.com>
Subject: Re: Linux 6.6-rc3 (DEBUG_VIRTUAL is unhappy on x86)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        David Kaplan <David.Kaplan@amd.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2023 at 06:16, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 3 Oct 2023 at 05:06, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > However, on the flip side I think there are security benefits here. We
> > wouldn't like any indirect branch speculation attack to leak the trusted
> > key material contents here.
>
> No. Turning *one* indirect call static isn't a security benefit. That
> argument is just bogus.

Okay I guess there is some confusion here. I was referring to
following calls in my prior reply:

static_call(trusted_key_get_random)
static_call(trusted_key_seal)
static_call(trusted_key_unseal)

but it looks like you are only concerned about:

static_call(trusted_key_init)
static_call_cond(trusted_key_exit)

So I agree with you as I can't envision an attack which can be carried
out by trusted_key_init() and trusted_key_exit() indirect calls.

@Jarkko, if you agree then I can convert these two callbacks to use
indirect calls instead.

>
> This code needs to be fixed. No static call rewriting for call-sites
> that are just used once.

@Peter, can we have a policy enforced for module __init and __exit
functions somehow at compile time? If not then can we have it
documented somewhere to mention static call invocations aren't
supported from these functions?

-Sumit

>
>                Linus
