Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604C67B0443
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjI0MeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjI0MeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:34:18 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5BBE6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 05:34:17 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7abcef80a82so2527870241.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 05:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695818056; x=1696422856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0B1rH84Q0zQKtWn5iPGBgUbFVQHRp03937YMHNZVgSY=;
        b=vMCoY3KRBrgvPse/ihJlS0fvdagCIbeA6GwthYL9ofl81AxT/1GAp3BkRK/wLTzGUP
         ytLV/cUCpQUU5XU1csJxdxd+GN2shIiiH+l8KutusiW0PyGzSvT8Ky9quFi5rzKpmGGp
         9yPy3zNUn1zdktxpxdKby12ELBkpDRaZoNNe+Fe4l/gUTbQM9fqvl5R5pd8rlXSpeO03
         9I36hfqYofglaqY/0t/0YY1oIMCeHQhm1J3Bep9ignrBnc26MS+SjeBTBUV0jf/YWa38
         Nb/w8JJt2+Z/xMjeF2tz5ivZj/bHc6+aeQ3r17yVqsuW7N6QoifqChqUUgv5G2aH6zIE
         V/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695818056; x=1696422856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0B1rH84Q0zQKtWn5iPGBgUbFVQHRp03937YMHNZVgSY=;
        b=kFDc5/+OhwJkxXawJyGXTS+WaPa/IjpczwlC1ReHwaUnPjrJRD3Xey/MzOZHAafL1h
         UN78XlfqbRXOS+bT0s+xxlIhYKNXB6iIX+tnfgMy+DjOwJSOV28D8twD1CSIpnj3NKjU
         wJ3/dGjXeazeC9ln2VaNX5mjDb0OW6EKMskfvdH6bSz5rJmoOC58bgUuvojv8jIP50Po
         R1my0rxoBdb4OtfL9CEOLZdSTsjbWGowpMS7t5nyZWXYvTzu+S67eim4je5P0+VuwgJx
         u6o8d6dNw7kraRWFO4ijnKBlHq/mME84QPaZ+85ubdzhQvCURIXuA3F6WPfG8QUGktwx
         TPLw==
X-Gm-Message-State: AOJu0YxsZCIxAwtqL45MKsTO262SRitlBO7RPw2WMJRlTF3lChuJXGIC
        DYLSUl2uA4gElKJTLE1anvb0qVq0wmnYE5w4qc9kAg==
X-Google-Smtp-Source: AGHT+IFoIgpk6Z9L8T58Xq+u2oegMsKOTlOo9mUwAXQgdNjWIvWjaLK8A9LmHfK1TmbAIhDKE2uKiUq2gefswbwzYXU=
X-Received: by 2002:a67:ff82:0:b0:452:cfeb:1613 with SMTP id
 v2-20020a67ff82000000b00452cfeb1613mr1929597vsq.23.1695818056376; Wed, 27 Sep
 2023 05:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com> <20230720173956.3674987-3-glider@google.com>
 <ZLyQk5Wmcx7Cf84W@yury-ThinkPad> <CAG_fn=WQORJConbBPzaNF2Nuxaf9Jmhy1Vgj=nk7gj902SQxOA@mail.gmail.com>
 <ZQ2WboApqYyEkjjG@yury-ThinkPad>
In-Reply-To: <ZQ2WboApqYyEkjjG@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 27 Sep 2023 14:33:35 +0200
Message-ID: <CAG_fn=UU12KcRLB6-s423MX4YM563URz=q7i570=VnH1C-1m7w@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] lib/test_bitmap: add tests for bitmap_{set,get}_value()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 3:30=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Fri, Sep 22, 2023 at 09:57:32AM +0200, Alexander Potapenko wrote:
> > > > +     unsigned long val, bit;
> > > > +     int i;
> > > > +
> > > > +     /* Setting/getting zero bytes should not crash the kernel. */
> > > > +     bitmap_write(NULL, 0, 0, zero_bits);
> > > > +     val =3D bitmap_read(NULL, 0, zero_bits);
> > > > +     expect_eq_ulong(0, val);
> > >
> > > No, val is undefined.
> >
> > Why? bitmap_read(..., ..., 0) always returns 0.
>
> Because it's unexpected and most likely wrong to pass 0 bits. We
> guarantee that bitmap_read() will return immediately, and will not
> touch the memory. But we don't guarantee that we return any specific
> value.

Fair enough, I'll remove the expect_eq_ulong() from the test in v6 and
will also add the requirement for nbits to be nonzero to the doc
comments for bitmap_read() and bitmap_write().

> It's not a hot path, at least now, and we can spend few extra cycles
> to clear output register and return 0, but user should not rely on it
> in any way, especially in a test that is intended to show an example
> of using the new API.

Ok, for now I'll keep the "return 0" part.

> Consider a less relaxed environment, where we really have to count
> cycles. In such environment, we'd return a content of the 1st input
> argument, just because it's already in R0, and compiled doesn't have
> to:
>
>     mov r0, #0
>     ret
