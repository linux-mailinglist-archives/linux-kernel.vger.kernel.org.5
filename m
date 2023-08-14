Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB4C77BFB0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjHNSWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjHNSWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:22:43 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA8FB0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:22:41 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-584034c706dso51621627b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692037361; x=1692642161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ImihNqCDZEllBXBLlPPm212FqeqO2Hv5TY4g220DYc=;
        b=u8QFUvLfP+61tqDzUSKKJJSR+DggyLEtLwaGODXLBpsV2LJKHgajUJYvTQZ/ThZuXj
         kT/NXHl1fbtN+DBqPD5XBQ32fg93M27O/pSjflRag/OKKn+1EakxC8L6usEhZMAN4ko1
         Uv17RdSJq3atTjHN0Mql24Nq2HFqhwlYhBcujhGHDgGRfSQV5GnfKp9HYuBDkLZveLPt
         yQiX/hiuJ1ZIFrYfjrOv2rEtBSKefjio4ElXmMzE+/4Wmg4KrMbIWOlF7HO3PnenqoQE
         wfGoFpmAZfpTwMhSxO/rRpb8heOmYhcfEKxvn3sgKE1apv83fU025UrszFE9dk68qDRh
         Qfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692037361; x=1692642161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ImihNqCDZEllBXBLlPPm212FqeqO2Hv5TY4g220DYc=;
        b=XdjElE++GttDHe0gFqii2uxCfSmh/sfaxLW+uSJgQR8GBOfylMtxaDFQZDW8iymdYn
         hfu/1DXL4j64PKXhxCqgxC3pTtb4sodrbt7bXDtxr7hykLpSkg5DJ91JGnxu8ysWfooE
         SikNtC/oMFtEAZN1HytUigt9Fklqvq2yk9xfzBub0QumVhSYxVSiPFVErMhTRQKC47Ju
         rWj88mH2JcMFN2vPefFel0uFy8rt2S5lyZwXKI3r+CsKwY6qmE/DdKOVq7a/PplpLV3g
         tlsrGFOC+MFphCkbfomvaoljyFy+w0otFVoC5IHXgWnNuplSI60C+1+r1f2sTMiKWXsq
         0q7Q==
X-Gm-Message-State: AOJu0YxKErYK/bRejhJPGWA4kzG9BGDVYnEzlBsI598XirVBw2phZxeP
        JcY+ZxOgQrhZuF9ZwSfXkYVFpUb0q2xekipHW7ld8hQScWQrRF6D
X-Google-Smtp-Source: AGHT+IF9NyoQSqCsdGBy/60m2cNbaWkTF1zofsIqVu9Aqq8Fsyh6TKMhlbbW0+c4+bqEnoARxOcS7czA4ztPBGZDoro=
X-Received: by 2002:a25:ab27:0:b0:d49:4869:1bd1 with SMTP id
 u36-20020a25ab27000000b00d4948691bd1mr11093807ybi.6.1692037360994; Mon, 14
 Aug 2023 11:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230809-virt-to-phys-powerpc-v1-1-12e912a7d439@linaro.org> <87a5uter64.fsf@mail.lhotse>
In-Reply-To: <87a5uter64.fsf@mail.lhotse>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Aug 2023 20:22:28 +0200
Message-ID: <CACRpkdayi5PyH7bifvShWRgtZXsNh9o8vA1TGV8tTORngeO8Hw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Make virt_to_pfn() a static inline
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 2:37=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:

> > +static inline const void *pfn_to_kaddr(unsigned long pfn)
> > +{
> > +     return (const void *)(((unsigned long)__va(pfn)) << PAGE_SHIFT);
>
> Any reason to do it this way rather than:
>
> +       return __va(pfn << PAGE_SHIFT);
>
> Seems to be equivalent and much cleaner?

I was afraid of changing the semantic in the original macro
which converts to a virtual address before shifting, instead
of shifting first, but you're right, I'm too cautious. I'll propose
the elegant solution from you & Christophe instead!

Yours,
Linus Walleij
