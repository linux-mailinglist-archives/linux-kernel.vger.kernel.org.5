Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254A17BFAEF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjJJMPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjJJMPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:15:39 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE3A94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:15:34 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41983b83e53so37725361cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696940134; x=1697544934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyv0P0EsUQbglDoISC/Fppji3yoFWL07MHcby8FubpA=;
        b=HXe7J1PDO6yck95/2UeDLimdHvIDtax4ziaElhBzOtGZuw+zQWoF03v5DIz9r1XtvW
         NTzm4CfMm18M1olbospsBAeDEASCMH/5WmezGdrGQjQYrve34UoSdrowyQ/rWZNeq1DW
         KowFetr9h9L/XCKzVmHc+wn1TRIynHR3XYL1594haSePNf3X5cJgZyIr56QWCekTct/3
         eL4DZq4z0txGTRGESVuUhRP4eJBqFa9T1TYvoZ1uzpS/UXJdoBpVorQE0BxC3xIl3Lqm
         ZANaa0md3VRitO0ZVo3eXiXrusVRMW9pvNKFQcybm5F8OtbcpkDS6dStz2Bpi2bVopUa
         acoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696940134; x=1697544934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyv0P0EsUQbglDoISC/Fppji3yoFWL07MHcby8FubpA=;
        b=OwZ1Qt+emvzko4nOI+L8C/5AmOijL7ltDS/wTwoEyJkLW+X1KDIZIV0p9I1f63O97l
         pdVgt8Ufw4X/XvsdQAl/R2VBaScEYnR/iaPLvmUplMXcxfAUwFaR+67uIdG74cFcJ0c9
         scM8DfLNnem1eBc8Yo4PeSZ9uOYX5x2YjeDMx2UfpbmDK2SlGFDl/JLe+bXE7cgBTfOn
         g4MY6BxWYlN/uUQX+krEFnf5lPFnb/NQxlLrG0TDRLcFT0CEvRFBwY3GLPUAq3FQrvsZ
         w5FSydVVuhFfz/B5KWidCS2ApkDBloMPgMcKtbbnybCAh72meWQuDmLWbhIYgNwRzTPG
         59iQ==
X-Gm-Message-State: AOJu0Yw39x0CmBWgmkA7iKVJFIOHy7QQjqV9aMzLp4pAFboXuWiQJgBT
        b4/1zaXewupf7KUDSsYJV0d52ptwPCHgCHcYsa6muw==
X-Google-Smtp-Source: AGHT+IEwUqnvEx+Mf/hDAMwFCZGhEr62ewAQWqnGfydV5k5vPYgdZ50q7jQgpRvOjNa6uAHfl+TYq8Pnof2JwTZuJWw=
X-Received: by 2002:a0c:cd85:0:b0:65b:2cb7:86a4 with SMTP id
 v5-20020a0ccd85000000b0065b2cb786a4mr17762697qvm.43.1696940133700; Tue, 10
 Oct 2023 05:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231006134529.2816540-1-glider@google.com> <20231006134529.2816540-2-glider@google.com>
 <ZSCLuCu9yMyDdHni@yury-ThinkPad> <CAG_fn=XHiVyRO-JiOSFREgJjXWjU9Zc1CCMPYV2Xx4LA8P8tkA@mail.gmail.com>
 <76db1532-1575-614e-5820-5b0fa49863c9@rasmusvillemoes.dk>
In-Reply-To: <76db1532-1575-614e-5820-5b0fa49863c9@rasmusvillemoes.dk>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 10 Oct 2023 14:14:52 +0200
Message-ID: <CAG_fn=VnTiPVpofPQKmGiAvzHOCb7weYO_pmyexQ-7+xn8_ukw@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] lib/bitmap: add bitmap_{read,write}()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>, catalin.marinas@arm.com,
        will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, aleksander.lobakin@intel.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 1:03=E2=80=AFPM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 10/10/2023 11.17, Alexander Potapenko wrote:
>
> >> 'behaves similarly' sounds like an understatement. I think, it behaves
> >> much faster because it can assign up to 64 bits at once, not mentionin=
g
> >> the pressure on cache lines traffic.
> >
> > My intent was to describe the visible behavior, of course the
> > generated code is better, and the number of memory accesses lower.
> >
> > How about the following description:
> >
> >  * The result of bitmap_write() is similar to @nbits calls of assign_bi=
t(), i.e.
> >  * bits beyond @nbits are ignored:
> >  *
> >  *   for (bit =3D 0; bit < nbits; bit++)
> >  *           assign_bit(start + bit, bitmap, val & BIT(bit));
> >
> > ?
>
> C programmers should know the meaning of the term "as-if". Perhaps use
> that. Smth like "bitmap_write() behaves as-if implemented as @nbits
> calls of __assign_bit()".

Good idea, I'll go with this one.
Thank you!
