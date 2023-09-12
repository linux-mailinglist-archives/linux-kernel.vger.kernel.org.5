Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E41779D91E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbjILStk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbjILStZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:49:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C581E9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:49:16 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso102245891fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694544554; x=1695149354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/XRvcGJZU4I9Q/1OlLUXQ5qApx8JkbEsZY8C02SQinc=;
        b=M3gOLIzvo3gHqTppRPNsQgF8kYF24F7PqQs1d5A19NRNrdTvcLrDcDp41bvyYPciv0
         cpsBBsLVdyBxX4FYtF3RVtxMZ12x65/5mp5hsaoT9JClgXkDLHz8IOLbQ5/eKlmB37a6
         noVc3q/JiUyy9N4TOfRISggs2HIYSpI3KiPtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694544554; x=1695149354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XRvcGJZU4I9Q/1OlLUXQ5qApx8JkbEsZY8C02SQinc=;
        b=EZDEJQQv+vU36yydTIB1Iw95EXobua2HsTs3sw9hWEVAULaBIlZ90qOIirfelw6csh
         EjAQhgV7h23Or5xTICGgCJWSw5sgLxH4OI0N+9gakUi+WvaAZ4Y9h+KWBnxAbUchxzY1
         vmutVsRb25JOSBVVrHa8VhnSCugffH2KUl+w1yVt22Xy8k2cCoLRu0Ond/t9kxTezmEf
         JKkfAQyMyWvrtI/0kNG+/+nKzI3WpmmsplVBWLm2ulR6bPncIVU6axRUL2qO34Cj5Vtn
         HqbZiZINOyfJNZZLEpm8SOHDv62WAx9AhZMw2I84a6KCVUxw7DNR0PKuR/ZwOOZxfRKO
         X4sQ==
X-Gm-Message-State: AOJu0Yyj4HaAo6+Crf77FmgZH0z8f8z4jzF/j/BcrcIaeeA90WvSrt6D
        d54I//JSLLG+9X6A5ERJSGUq6qggTXMnZfAAlgUgEa1C
X-Google-Smtp-Source: AGHT+IFQG23wOQow3UvGoJAfCiaYdB/aee5U+4xGD9t9s5CIrI6KI39fa5ocbAbYDPg+GPBLMfYjRQ==
X-Received: by 2002:a2e:9d95:0:b0:2bc:bef0:8612 with SMTP id c21-20020a2e9d95000000b002bcbef08612mr555772ljj.23.1694544554554;
        Tue, 12 Sep 2023 11:49:14 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id y4-20020a2e9d44000000b002b6e13fcedcsm2054252ljj.122.2023.09.12.11.49.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 11:49:13 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso102245421fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:49:13 -0700 (PDT)
X-Received: by 2002:a2e:3a08:0:b0:2be:57c3:1fef with SMTP id
 h8-20020a2e3a08000000b002be57c31fefmr528170lja.3.1694544552941; Tue, 12 Sep
 2023 11:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <27ba3536633c4e43b65f1dcd0a82c0de@AcuMS.aculab.com>
 <CAGudoHHUWZNz0OU5yCqOBkeifSYKhm4y6WO1x+q5pDPt1j3+GA@mail.gmail.com>
 <9a5dd401bf154a0aace0e5f781a3580c@AcuMS.aculab.com> <CAGudoHEuY1cMFStdRAjb8aWbHNqy8Pbeavk6tPB+u=rYzFDF+Q@mail.gmail.com>
 <ed0ac0937cdf4bb99b273fc0396b46b9@AcuMS.aculab.com>
In-Reply-To: <ed0ac0937cdf4bb99b273fc0396b46b9@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Sep 2023 11:48:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXw+NSW6usWH31Y6n4CnF5LiOs_vJREb8_U290W9w3KQ@mail.gmail.com>
Message-ID: <CAHk-=wiXw+NSW6usWH31Y6n4CnF5LiOs_vJREb8_U290W9w3KQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     David Laight <David.Laight@aculab.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sept 2023 at 03:38, David Laight <David.Laight@aculab.com> wrote:
>
> The overhead of 'rep movbs' is about 36 clocks, 'rep movsq' only 16.

Note that the hard case for 'rep movsq' is when the stores cross a
cacheline (or worse yet, a page) boundary.

That is what makes 'rep movsb' fundamentally simpler in theory. The
natural reaction is "but movsq does things 8 bytes at a time", but
once you start doing any kind of optimizations that are actually based
on bigger areas, the byte counts are actually simpler. You can always
do them as masked writes up to whatever boundary you like, and just
restart. There are never any "what about the straddling bytes" issues.

That's one of the dangers with benchmarking. Do you benchmark the
unaligned cases? How much do they matter in real life? Do they even
happen?

And that's entirely ignoring any "cold vs hot caches" etc issues, or
the "what is the cost of access _after_ the memcpy/memsert".

Or, in the case of the kernel, our issues with "function calls can now
be surprisingly expensive, and if we can inline things it can win back
20 cycles from a forced mispredict".

(And yes, I mean _any_ function calls. The indirect function calls are
even worse and more widely horrific, but sadly, with the return
prediction issues, even a perfectly regular function call is no longer
"a cycle or two")

So beware microbenchmarks. That's true in general, but it's
_particularly_ true of memset/memcpy.

                  Linus
