Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209DC7AABFD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjIVIGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjIVIG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:06:29 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6F1CC0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:06:24 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-6561c09ead6so10107236d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695369983; x=1695974783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTKdN21Skq+tGvcpiDoTtuySmWZyznetp2O1lmfJ8Sc=;
        b=WZx1Za2RIgJA0Q2eaPgjFFrwlOZpWYYrUDq4rkPQKlpOZgjCNwyF/EaQQfdeJejI+5
         otXrF52+irl+A1eAhSZFfVOPt6RA+vjhyAAe9sr1RvqdWwUi0yDfXcAXTLFpCztlEC5q
         EoJwReIdocagfWLzfzpe6/Rb+0g/K8PdQ4+q6GDVeS2CdNSQIVdX6ihJV+Q1zVjX7gMW
         7LOZiQYeZZgPqiCpdtgqr6cFQ6X98F2/bngxLBGo4BOdu3a1+B99ovXs9TxyCeJ/g9j/
         Uh+lGZvpBZbwSngBzaugcXPYzcw6Q8r5Nj1A3N13Y1OPFTqHoMfx9Z++GU/m3jjh5vx/
         WncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695369983; x=1695974783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTKdN21Skq+tGvcpiDoTtuySmWZyznetp2O1lmfJ8Sc=;
        b=h4bmZ08v9khRJUGtYiNtfHxIAe6gIWOR7sSkIJirk2mL7noaRJTEns5sUHNGw7vOPT
         UQ1qlgVtbSuPBsn8KojwP6zsb7BBGUgQin74EQ8/ApE2lo129y388EZuAIZ2l1OR1iO/
         3vbIWDeIcFwW8/RtcTLN1UdFJauqPChjieMj7y7xMtozVxphBRY27uijFiVR68NT9dQo
         VhuWJDka4zJRtaI8lr7hfx4ZLCQyQiDJTlvFRtnphx72QKwIQZHJ0v09Xt65Ta9l4UbF
         mTFmSgWCqtNCVtZ7TAEOjijyGJKC+K4egUptPnDs2vOKYUn49oYvZpwCFabrtMkw0Xqh
         qNMQ==
X-Gm-Message-State: AOJu0YwY2rankz5MrIeSeimyQKtBugd38PeWBGvxKhzw7u+XoJ8wUvtP
        eRMPIVnMugl7salBBlGc5H1pL6HZ3VuG/DsD7zXL9w==
X-Google-Smtp-Source: AGHT+IG/Qvjmt/Z9s1xC3GCGreQcT0C63z4qUBvgRzVHYUV8GlhSI45Su64qvjm8RnXTz10mEkYhZrXOdgLp+eelx4M=
X-Received: by 2002:a0c:ab11:0:b0:636:e4f:6b9a with SMTP id
 h17-20020a0cab11000000b006360e4f6b9amr7594617qvb.17.1695369982936; Fri, 22
 Sep 2023 01:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com> <20230720173956.3674987-5-glider@google.com>
 <ZLprDcPQYdY0ytpc@smile.fi.intel.com>
In-Reply-To: <ZLprDcPQYdY0ytpc@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 22 Sep 2023 10:05:46 +0200
Message-ID: <CAG_fn=VWTYg=9n7XEd=6FZiR+1EMv6tzd63DauHdiVXWac6rEQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] arm64: mte: add a test for MTE tags compression
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
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

On Fri, Jul 21, 2023 at 1:25=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jul 20, 2023 at 07:39:55PM +0200, Alexander Potapenko wrote:
> > Ensure that tag sequences containing alternating values are compressed
> > to buffers of expected size and correctly decompressed afterwards.
>
> ...
>
> > +#include <linux/bits.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
>
> > +#include <kunit/test.h>
>
> Keep this in a separate group outside of linux/*.

Done.

>
> > +#include <linux/types.h>
> > +
> > +#include <asm/mtecomp.h>
>
> ...
>
> > +/* Functions exported from mtecomp.c for this test. */
> > +void mte_tags_to_ranges(u8 *tags, u8 *out_tags, unsigned short *out_si=
zes,
> > +                     size_t *out_len);
> > +void mte_ranges_to_tags(u8 *r_tags, unsigned short *r_sizes, size_t r_=
len,
> > +                     u8 *tags);
>
> This is interesting. Have you run `make W=3D1` on this code?

You are right, this is fishy. I added mtecomp.h and moved the
declarations there instead.
