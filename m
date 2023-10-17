Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C627CCF4B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjJQV3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjJQV3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:29:40 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529C912B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:29:34 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9a58f5f33dso6912214276.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697578173; x=1698182973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k4C4JKwIA7asFauDo29zvruEioTkAyj/G+TnXmdCzBA=;
        b=gimieKTMiqMZ9J/ZE7wQJd8F72xDh4hNRCwaXrxel96uogf6s6Y5Ep65EA3WrWQV97
         IjEVsEc7zD6rsRd9ZK2kv2HBCJmzL71Pq0xTqFQHyp0AtV6V1Y3miwmPAwYWkqFCSmFt
         vblas+BJXlk11usdwVZ3pgNSPKzqBtjmu9LihGQRO7vMimvlAK0tJRwvHN3Za2MMLMoM
         CI8UYLlJk0qkkA4KzNl9G2WZT6PbtFSLT5d8yMVIkA06az4o/df0E11p2ZhOPj7g/OG/
         m7ZtaVHy1tFE2SmZ81ipr44IOlJa2fH2GnBxp6zK61VDOn5edjcczgk14Wp/3ug92wmy
         DrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697578173; x=1698182973;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4C4JKwIA7asFauDo29zvruEioTkAyj/G+TnXmdCzBA=;
        b=Z0EuOa3qfqs7vsADVEl70icYoRkVcp1uPnjXyv9OuYTDc3q9o/nUI1KS5T2RUcXAlj
         mLddJ1/3flVU/dgGg8s7dliWAoILhonD7DVhJHFdoavWZ8CL+Va5mo/uHc9vFvpUrW1F
         4ptxal4e3hjeDqhWxP1K7pIoXxoeUO60lsVJzTQnpqWyOqbJskzQRX0OXXicEZMkFUZN
         HTcaH/oOpb4mqCHw9L8iO1AmuvAeGL59TbgMDSgXsKilcmvoWbFP89XPYwMVn8nVH9xL
         ZYTTKrZWe9yNBuYSGSkhjW1suJWod9NsGATXlBedr26zhg8v9v5mdTRFdHzVRbqqu5n5
         N6aw==
X-Gm-Message-State: AOJu0YyjkzkQLMyruTlZiUuGzsPWOtB4KhqbaaIrz1Qe47jWFuLyGwA7
        pryw/k9a+CpBkQrWvQcZcwpUTsW5pPUfJHNnJHu2VA==
X-Google-Smtp-Source: AGHT+IHYVzSeGslRcQznJjQsW0F50tU/YplulewZG+1qzblCSC/Rty55Ek6MhYAy+3KVQBFoWrissUDTr9tvkwo5jcE=
X-Received: by 2002:a25:b06:0:b0:d9a:5021:4f34 with SMTP id
 6-20020a250b06000000b00d9a50214f34mr3193343ybl.15.1697578173377; Tue, 17 Oct
 2023 14:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <8e61aed5f64e434abc1d7b6f81859c8a@realtek.com> <CAPDyKFrLpim75nUB7ksDie2edkWsnFSq6TbFSFFpw5cY5d4y1w@mail.gmail.com>
 <fabaed5751f04105a9719c1cb0390c98@realtek.com> <CAPDyKFr3NRUgfKtkb2DBrhziekFAB0jT_X3Fsfvjk_bGZLC9mA@mail.gmail.com>
 <fa10aa1c644241808c2ad880088240ab@realtek.com> <CAPDyKFrtBKHHRgeF-JO27ANsbSmt8rdnhn-WNr5Je9okEgA29Q@mail.gmail.com>
 <feb0c4e71e9c48a2a21f18b7d3baf135@realtek.com> <CAPDyKFoq_PDk_JgW4D+o4eEPdcffUq2RLbBreRDqeK47m0UnJA@mail.gmail.com>
 <a82d7e877dc041d4be5e0ef38c2da406@realtek.com> <CAPDyKFo59Q3dmUJU-hJ++=k0uwx2KxamW9KckDX=O_CA84O1_g@mail.gmail.com>
 <a533dde76d2d4345b85cd060a8e403db@realtek.com> <CAPDyKFp3sbbQmKiV6NnuWnPmpfuyWzRBTuYJaWx_7oTLLsXdaA@mail.gmail.com>
 <5752164983174ca68a669c241e7ef436@realtek.com>
In-Reply-To: <5752164983174ca68a669c241e7ef436@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Oct 2023 23:28:56 +0200
Message-ID: <CAPDyKFpeirjA4QmCiqnu4MxN8Yph6d0GiyA95pcmOBRYf8ywSg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: rtsx: improve performance for multi block rw
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 at 04:27, Ricky WU <ricky_wu@realtek.com> wrote:
>
> > On Wed, 11 Oct 2023 at 07:36, Ricky WU <ricky_wu@realtek.com> wrote:
> > >
> > > Hi Ulf Hansson,
> > >
> > > Can I know what is this patch status or has some concern on this patch?
> >
> > Didn't you read my earlier replies?
> >
>
> Are you talking about BFQ for testing speed?
> Because we tested the Read/Write speed are better than before and our customer that uses our reader on their product also tested the Read/Write speed, they want us to push this patch on

It's certainly a very positive thing that your target is to upstream
solutions that improve performance. We all appreciate this!

In this regard, I believe I have tried to guide you on how to move
forward with this. This particular optimization doesn't belong in an
mmc host driver, but rather at the common upper block device driver
layer, such that it can benefit more than one particular mmc host
driver.

I fully understand that making that kind of improvement is way more
difficult and requires in-depth analysis to understand what is
happening on those layers too. On the other hand it could be something
that may benefit a lot of devices/platforms. Unfortunately, I am
currently not in a position where I have the bandwidth to dive deeper
into this.

If you decide to pursue your investigations, I think we need to
involve the experts from the common block community (linux-block
mailing list) to get their advice.

So to be clear, I am not going to apply $subject patch - or anything
similar to an mmc host driver.

[...]

Kind regards
Uffe
