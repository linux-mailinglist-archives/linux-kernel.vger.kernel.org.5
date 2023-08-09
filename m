Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDC077664B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjHIRVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjHIRVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:21:46 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E54EDA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 10:21:46 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so859581fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691601704; x=1692206504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1XYH3jJ0fFMcP87tUDEXy9T7rFDPHtJSPapZra9b610=;
        b=RqP3PpkgFUk5/+sLrwi/fNb6ViR7Ib+J+zMxnUPUMB/ArHXJxShRVbtUbMxdBMXg7N
         HLcgcWBi1yypE0jvljNMGPtmh0xdF41Upun8L3x3E7v2cTWPCZSDFMDjNlvEjoHuzhqM
         TMxHfYcJBnzTl/7BkVkC7ZpBfQ4Mjuu3a0MYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691601704; x=1692206504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XYH3jJ0fFMcP87tUDEXy9T7rFDPHtJSPapZra9b610=;
        b=TuggyGUDQp1KY7DWBhitIPnypMn9icfoL4PxRhcwf2QKRdbCMhk5YBWErHi/FhSVPJ
         1JkxJnbOGXMbd+WPb1PU8MhBO7UYAKDFxrLQ8aB/0B+NTSZzickApjpF8bf4EtYtrVVX
         v2lOmN1hv3eDB//OI1G0Op0phJkiGnt4/N/qTixpTSwDzDZ4PVbA/KFQ9ij6zmxycFEZ
         BLJDU+ELtnzvEQTZmuHNEPODXJI7ZCThvtVIbJe8Gzh8tpBBGjj17GMU8Ydgzvajm967
         y/kyiGOZR4T5BEtUQAZs22fsZg0/oFZ9n6oH5GCxjV2KVuMI2/XD61tvvNLVuowONdPd
         Q/Jw==
X-Gm-Message-State: AOJu0YybJLeH9RfmDmmrSre1Lj6AWe61jFXTMjHpjZ+uherL+3gifOTh
        Vv++a/iXQh0XKtPTj1eaZ//cZUUiwtup9wn9rUSUHS0g
X-Google-Smtp-Source: AGHT+IH6NUxpryt4YxVDqGQ+mZ+bxKeFf1TFH+qGi1zUNP2Ua3IMlgcIE9z5b4ntO1FSGpchxbWeyg==
X-Received: by 2002:a2e:8650:0:b0:2b9:d28c:9c2d with SMTP id i16-20020a2e8650000000b002b9d28c9c2dmr2344585ljj.23.1691601704056;
        Wed, 09 Aug 2023 10:21:44 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id f12-20020a2e918c000000b002b9b55fefe0sm2806289ljg.131.2023.08.09.10.21.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 10:21:43 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b9bb097c1bso1044791fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 10:21:43 -0700 (PDT)
X-Received: by 2002:a2e:9ccb:0:b0:2b6:dd9a:e1d3 with SMTP id
 g11-20020a2e9ccb000000b002b6dd9ae1d3mr2399575ljj.44.1691601702926; Wed, 09
 Aug 2023 10:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <87edkce118.wl-tiwai@suse.de> <20230809143801.GA693@lst.de>
 <CAHk-=wiyWOaPtOJ1PTdERswXV9m7W_UkPV-HE0kbpr48mbnrEA@mail.gmail.com>
 <87wmy4ciap.wl-tiwai@suse.de> <CAHk-=wh-mUL6mp4chAc6E_UjwpPLyCPRCJK+iB4ZMD2BqjwGHA@mail.gmail.com>
In-Reply-To: <CAHk-=wh-mUL6mp4chAc6E_UjwpPLyCPRCJK+iB4ZMD2BqjwGHA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Aug 2023 10:21:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXUWPf6PySkmQXGG0vFPvCtKKX4Mwh5Wvsw1ZGjN2ggg@mail.gmail.com>
Message-ID: <CAHk-=wiXUWPf6PySkmQXGG0vFPvCtKKX4Mwh5Wvsw1ZGjN2ggg@mail.gmail.com>
Subject: Re: [PATCH RFC] Introduce uniptr_t as a generic "universal" pointer
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 at 10:01, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Right now the kernel buffer init is a *bit* more involved than the
> above ubuf case:
>
>         struct iov_iter iter;
>         struct kvec kvec = { kptr, len};
>
>         iov_iter_kvec(&iter, ITER_SRC/DEST, &kvec, 1, len);
>
> and that's maybe a *bit* annoying, but we could maybe simplify this
> with some helper macros even without ITER_KBUF.

Looking at the diff that Christoph quoted, you possibly also want

        strncpy_from_iov()

and honestly, that's a bit of an odd operation for the traditional
iov_iter use, but it certainly shouldn't be _hard_ to implement.

I'd probably initially implement it as a special case that only deals
with the "one single buffer" case (whether user space or kernel
space), since that would presumably be what you'd ever have, but
extending it to the generic case later if people actually need it
would not be problematic - those "iterate_and_advance()" macros in
lib/iovec.c are all about that horror.

               Linus
