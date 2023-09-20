Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16637A8C07
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjITSsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjITSsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:48:53 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D463C9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:48:47 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso1996501fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695235725; x=1695840525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X1hFrP0vWNBME7dDNcg/fEbps60Tl05diwzAP59+3sw=;
        b=AXQsgJaTWvfLszH1nhmige5zIrolkGN5tWGUxIw594N1LopPbLxoF0j0ViApTvCNuY
         keo4+edsKUcrkrlobuH2zC/yx6NOiZIyjZ3ACCvlz1LuWC5bdy1EhXcwv6t4xe9ZTD9p
         dliCbhUkn6qj8aV3SfMYY+lz3i3ajWTOPpXFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695235725; x=1695840525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1hFrP0vWNBME7dDNcg/fEbps60Tl05diwzAP59+3sw=;
        b=n54inCMK2gCfcPrmM4qrReYmo3mBATxzuO5HYjSalDYrDpglzrW5FTf+8PQUOJ469T
         Sbd1vp8Y9h/b2kwvzglLYOUOT3uLJRD52XRZEie8jRfmJHLlGYfoKxAyZ5a5MmDGiz2y
         herv16ziEQvHtjZ2y6xX9TmKUAjx8A5tHf1PLqw7tCMlSxuHMAfrLOZqnTXbdJoXpGjs
         J1DfBA0vbngMTIcDO/9Iwp5XrKRofFQ+Q9i7wGKx+ktEqhCCWyMUn6/5JAYI7UYw/F0m
         cE2SHGW+Z8qaFOnlCEeQHFqijetXTvTXxQs+uppjnniiLgdkCOGRwbD81bYan4CUFYHn
         Hkdg==
X-Gm-Message-State: AOJu0YzLwb6qB6rD4MIfPedAoA1WBNZPq8bpcH6EcGNxG3/3ej/dv+KE
        vJOpGwySIjlERL9UrJTTrnKJzrVfGZKJEB38QEvEhA==
X-Google-Smtp-Source: AGHT+IFpZsXlwMCvFrdGW6rJkotu6TuXtxmlcCCygNbx88P4G9tS50ZiSbB+7xHmA/qAhkWOuwJu3g==
X-Received: by 2002:a2e:804a:0:b0:2b6:e105:6174 with SMTP id p10-20020a2e804a000000b002b6e1056174mr2955907ljg.47.1695235725584;
        Wed, 20 Sep 2023 11:48:45 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id w22-20020a2e9bd6000000b002b9ff8450aesm3222090ljj.91.2023.09.20.11.48.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 11:48:44 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so309066e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:48:44 -0700 (PDT)
X-Received: by 2002:a05:6512:b1c:b0:503:6b8:a84a with SMTP id
 w28-20020a0565120b1c00b0050306b8a84amr3636614lfu.54.1695235724132; Wed, 20
 Sep 2023 11:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230920060615.GA2739@sol.localdomain>
In-Reply-To: <20230920060615.GA2739@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Sep 2023 11:48:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wja26UmHQCu48n_HN5t5w3fa6ocm5d_VrJe6-RhCU_x9A@mail.gmail.com>
Message-ID: <CAHk-=wja26UmHQCu48n_HN5t5w3fa6ocm5d_VrJe6-RhCU_x9A@mail.gmail.com>
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

On Tue, 19 Sept 2023 at 23:06, Eric Biggers <ebiggers@kernel.org> wrote:
>
> This would be the potential change, BTW:

Entirely regardless of your fundamental question, no, that's not the
potential change.

That causes a crng_reseed() even if the write fails completely and
returns -EFAULT.

So at a *minimum*, I'd expect the patch to be be something like

        memzero_explicit(block, sizeof(block));
-       return ret ? ret : -EFAULT;
+       if (!ret)
+               return -EFAULT;
+       crng_reseed(NULL);
+       return ret;

but even then I'd ask

 - wouldn't we want some kind of minimum check?

 - do we really trust writes to add any actual entropy at all and at what point?

which are admittedly likely the same question just in different guises.

Also, are there any relevant architectures where
"try_to_generate_entropy()" doesn't work? IOW, why do you even care?

                Linus
