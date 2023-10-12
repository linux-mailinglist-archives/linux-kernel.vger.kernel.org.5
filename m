Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5124F7C6F11
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347221AbjJLNXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347209AbjJLNXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:23:10 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292E691
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:23:09 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3af8b498d31so634596b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697116988; x=1697721788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8XZW0ufKm9dLqcUAr2E7C0T6CPSVb2O8KRDWlUZW7k=;
        b=Pj2pD91iktQRQEqr4UKXQw40PEvdG7Hy+lvj6uGAphPoNaCWCkUoEfSxX4OSglNIlH
         kUn19d02so2LvqekC/z9RzQ4Ui0MTVM41PFg4A49R/sklxCkRTVPX+axKyyn5cMMfkpR
         /TgzVy5X2CSoGyNcQ7y74NHW/yPNvJNuXyTpyPjBs1tmCVDx0HaSrEIGOD+OxiXbJ40f
         fWp1tMLq3ICmuZLIZRzzR6VCI6RyB8u2xpymx0YOS6/TnJ1EQI04uCc3PWSUjC/3YJZ6
         ixNxzP3pz9kUeF1WJ3x1I6o1Ir9kmB080j4D9S9set24lcYotJ4h4rki3cDC8kwtNePk
         1fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697116988; x=1697721788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8XZW0ufKm9dLqcUAr2E7C0T6CPSVb2O8KRDWlUZW7k=;
        b=NOrVbmJbl+wl/yS3LYgxHVzo8/ll8mB9ZTOuaAGkLXHWFpfhV/LAnwPbX5gmbzPxRV
         GmVrKSmr8tOJ1FEAsb8v2ZSF9o9pRAS1A1ofn6MF//GqXsv1xJiLfsuGJayzp1dEqHwU
         6mT44HkAgA0+s75aTdYMbQZ1bI1AtXqaPNruSIMSW6br7HjbaLk0xaDO7BoxdxJMXhxd
         6XTbfXxAA4ve26RkxPwuFhUjNuZxQLJNVbpxV3eFtCb9tS2DzEpgQXDBNj3gIpZ1njlU
         KaufYlWon5xzI81ismIKndp0l82WIxoX8AsNr8CGFD4FRSgDWw5ZYmm4Wp1lRrdeOHio
         ea2A==
X-Gm-Message-State: AOJu0YwSHXBIZl6aRlL49H3N0Fime1iKyCnm/F5XzDmH2y+TGqb7ZeLN
        tuPwvwyiJsmtEDhBKzvtDVsOrsXjFnut4J64kCeheg==
X-Google-Smtp-Source: AGHT+IHpWoYW1aTxV9uv2s8J5A/sQqG3SGjaCfpdaqh29dBRSKX+p1QDRY8zBMF/unHPfwLCe0HxgH1IJLrYVSLVjZo=
X-Received: by 2002:a05:6808:2a47:b0:3ad:fc3f:1202 with SMTP id
 fa7-20020a0568082a4700b003adfc3f1202mr23844054oib.53.1697116988380; Thu, 12
 Oct 2023 06:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231011172836.2579017-1-glider@google.com> <20231011172836.2579017-3-glider@google.com>
 <ZSbjRjUriEUebKs2@smile.fi.intel.com>
In-Reply-To: <ZSbjRjUriEUebKs2@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 12 Oct 2023 15:22:28 +0200
Message-ID: <CAG_fn=W_7nqtKZdDOfjYT51+T-iqAyrmEHrH9O45k1OH8g_NKA@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] lib/test_bitmap: add tests for bitmap_{read,write}()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
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

On Wed, Oct 11, 2023 at 8:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Oct 11, 2023 at 07:28:32PM +0200, Alexander Potapenko wrote:
> > Add basic tests ensuring that values can be added at arbitrary position=
s
> > of the bitmap, including those spanning into the adjacent unsigned
> > longs.
>
> Would be nice to have an additional test like
>
>         bitmap_write(..., 33 /* or anything > 32 */);
>
> This will require ifdeffery. So at least this code may warn users about c=
orner
> cases in the agnostic code.

We could go with bitmap_write(..., BITS_PER_LONG + 1):

        /*
         * Setting/getting more than BITS_PER_LONG bits should not crash th=
e
         * kernel. READ_ONCE() prevents constant folding.
         */
        bitmap_write(NULL, 0, 0, READ_ONCE(bits_per_long) + 1);
        /* Return value of bitmap_read() is undefined here. */
        bitmap_read(NULL, 0, READ_ONCE(bits_per_long) + 1);

I'll add the above code in v8 (sometime next week, hope to receive
some comments from the ARM folks).
