Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D523F77645A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjHIPse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbjHIPsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:48:33 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED0F1FF7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:48:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ba0f27a4c2so103345161fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691596110; x=1692200910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E1r9SEbY/6BeSSvbVtRdbVSYPWqzFDwd0F7d6h1DkFU=;
        b=gIQZNr9zucdDpiDYxZAbnSd8p+eXyRJwgBN2PAmxVDna8ceKNJtFeXf7HTwR1SVrIq
         XMYqqlFBKE09cOyG0eoO6o3XAIff8kErBdLGucfq2Q4c3e2Ujajt9Ybroo+jDb/DVd87
         iSdZjDH5wfyPOcr+0if2kWXr20MjD3dJUWkvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691596110; x=1692200910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1r9SEbY/6BeSSvbVtRdbVSYPWqzFDwd0F7d6h1DkFU=;
        b=DjuKlQnh/TaCOtjUc6EGT0vEuCX31c9YX1JidNLdCzkb/dg0MndQcEsMorx04An4sJ
         ipFYdLj3dUdLFq1Rfj/1HPIooyS012KiicZXd1HffHFYBG2r1+4r9JBObEHkEyMfgPos
         Jfhe53/wKoeMag1VRXrf44xPxeZus4/pXxDj6A18DB1JobrfglSrTUdmi3ec2F5BXxwM
         7KdIWPlATU4GwcR7C9DnMf87NEcwGqgKXOZCnZ7B1Dch7dGGYZ6asSKFY/h45nKnl3qo
         JY7xApLsV83B0yG23ICZXd5g5vj0gZPJSik0RcXrygpwr92TQLG7nMwVcnmIpVmUIHub
         TxJA==
X-Gm-Message-State: AOJu0YxXBptG0jwU6z62LlTM4YpLgs4PO/mQ6OLkEVu9uiL7DzJ8zK+V
        nVDEsVFW9UqHJvOsON5Xgf63avPGWKnQIrYtFgUhrm7P
X-Google-Smtp-Source: AGHT+IEYjVC7nTlVEEsmvsWTB7N6Q1RiVZW/DSuQWqwawuNqwFLYaT8Ajxx2BJ25uYvvr9T69caZjg==
X-Received: by 2002:a2e:b6d1:0:b0:2b9:d71c:b4a4 with SMTP id m17-20020a2eb6d1000000b002b9d71cb4a4mr2276607ljo.12.1691596109929;
        Wed, 09 Aug 2023 08:48:29 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id z27-20020a05651c023b00b002b83dbc71c9sm2771287ljn.54.2023.08.09.08.48.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 08:48:29 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4fe7e1ef45dso2463437e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:48:29 -0700 (PDT)
X-Received: by 2002:ac2:5bca:0:b0:4fb:89ad:6651 with SMTP id
 u10-20020ac25bca000000b004fb89ad6651mr1974250lfn.28.1691596108621; Wed, 09
 Aug 2023 08:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <87edkce118.wl-tiwai@suse.de> <20230809143801.GA693@lst.de>
In-Reply-To: <20230809143801.GA693@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Aug 2023 08:48:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyWOaPtOJ1PTdERswXV9m7W_UkPV-HE0kbpr48mbnrEA@mail.gmail.com>
Message-ID: <CAHk-=wiyWOaPtOJ1PTdERswXV9m7W_UkPV-HE0kbpr48mbnrEA@mail.gmail.com>
Subject: Re: [PATCH RFC] Introduce uniptr_t as a generic "universal" pointer
To:     Christoph Hellwig <hch@lst.de>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 at 07:38, Christoph Hellwig <hch@lst.de> wrote:
>
> The original set_fs removal series did that as uptr_t, and Linus
> hated it with passion.  I somehow doubt he's going to like it more now.

Christoph is right. I do hate this. The whole "pass a pointer that is
either user or kernel" concept is wrong.

Now, if it was some kind of extended pointer that also included the
length of the area and had a way to deal with updating the pointer
sanely, maybe that would be a different thing.

And it should guarantee that in the case of a user pointer it had gone
through access_ok().

And it also allowed the other common cases like having a raw page
array, along with a unified interface to copy and update this kind of
pointer either as a source or a destination, that would be a different
thing.

But this kind of "if (uniptr_is_kernel(src))" special case thing is
just garbage and *not* acceptable.

And oh, btw, we already *have* that extended kind of unipointer thing.

It's called "struct iov_iter".

And yes, it's a very complicated thing, exactly because it handles way
more cases than that uniptr_t. It's a *real* unified pointer of many
different types.

Those iov_iter things are often so complicated that you really don't
want to use them, but if you really want a uniptr, that is what you
should do. It comes with a real cost, but it does come with real
advantages, one of which is "this is extensively tested
nfrastructure".

                  Linus
