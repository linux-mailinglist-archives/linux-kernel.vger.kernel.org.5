Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52AE7A8DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjITUtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjITUtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:49:21 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BA6BB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:49:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5033918c09eso472099e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695242954; x=1695847754; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6FhIbvn7MsGlLObvmOiWL/jIm9VZXSDgz2MjQZTKc18=;
        b=T24J5cD7Mkice2Xyf+OMoqOHdGKfX+kda3LRAb9LTtDbVEWjR+aUnQlSldamJcVaui
         +V6drE184SL0ph4PvRyFnn8wQN9BOacJkcljKS+2qYDJAh3Uf2lMTvr1VvSeWdq053S2
         RPH+oyDJb59UBnmlNjyMMmsyyzP+nF+hPNyvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695242954; x=1695847754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FhIbvn7MsGlLObvmOiWL/jIm9VZXSDgz2MjQZTKc18=;
        b=KWDImFB0uibq2G29FYxlPvfMACQYvOp/GTdmBKYpnp7ys7z6J9liKjk6ht2wACaf6N
         GfPEO7sYrmpSjlRa9W41nGaidr00N5/qTO16e5anl8sEjVc+rCftcg83xI1WbQH2jtjD
         rztOhlS3fHTPBSdq23QDlBCmuA78moUi7naYbn+E7iSdsOUKL/BDJFU3Q+9Sz1+SnS7G
         4OoDAQLDwPYv7T3evUxAu3TvF7L6nYgKj6QG8nBuABvIxzPPjpLdl0sTQbPXEr6Vihax
         8Xyb/guGgkRhpFK56xdVfzA9cUxC9QJqENHSJaSzADrYeME/OEwfgKkXZXmFJulrWxyY
         0rKg==
X-Gm-Message-State: AOJu0YxVNsKk1U/TDv/gI7Y1RSZSWSc937xEBGUf13rq/o5O6/kTh75i
        9ST5eWXtVcggLkTnzek5XP+Aih/i/o+80z8/PfJGTJes
X-Google-Smtp-Source: AGHT+IEjdP6w2SBEPTiAdsKHR5LuqGbhoOP9jG3K7xMLv26T4BEeb35EGuEDEKU6Fx5ZnT7ntpBRQg==
X-Received: by 2002:a19:651e:0:b0:500:903f:6084 with SMTP id z30-20020a19651e000000b00500903f6084mr2762336lfb.63.1695242953884;
        Wed, 20 Sep 2023 13:49:13 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id fg5-20020a056402548500b00530aae2d5bfsm7319647edb.9.2023.09.20.13.49.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 13:49:13 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-53087f0e18bso170376a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:49:12 -0700 (PDT)
X-Received: by 2002:a05:6402:1505:b0:525:69ec:e1c8 with SMTP id
 f5-20020a056402150500b0052569ece1c8mr2859302edw.40.1695242952648; Wed, 20 Sep
 2023 13:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230920060615.GA2739@sol.localdomain> <CAHk-=wja26UmHQCu48n_HN5t5w3fa6ocm5d_VrJe6-RhCU_x9A@mail.gmail.com>
 <20230920193203.GA914@sol.localdomain> <CAHk-=wicaC9BhbgufM_Ym6bkjrRcB7ZXSK00fYEmiAcFmwN3Kg@mail.gmail.com>
 <20230920202126.GC914@sol.localdomain> <CAHk-=wgu4a=ckih8+JgfwYPZcp-uvc1Nh2LTGBSzSVKMYRk+-w@mail.gmail.com>
 <20230920204524.GD914@sol.localdomain>
In-Reply-To: <20230920204524.GD914@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Sep 2023 13:48:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjx__9L2Ej0DBWGgyjxEKkdKJW=zDvjEhLTBsBgd8MdOA@mail.gmail.com>
Message-ID: <CAHk-=wjx__9L2Ej0DBWGgyjxEKkdKJW=zDvjEhLTBsBgd8MdOA@mail.gmail.com>
Subject: Re: [RFC] Should writes to /dev/urandom immediately affect reads?
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sept 2023 at 13:45, Eric Biggers <ebiggers@kernel.org> wrote:
>
> See my first email where I explained the problems with the current behavior.
> Especially the third paragraph.

I really don't think that's the obvious way at all. Anybody who treats
a seed file that way just doesn't care, and whipped up a (bad) shell
script randomly.

Whatever.

             Linus
