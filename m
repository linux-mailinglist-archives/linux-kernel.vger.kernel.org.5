Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AAA7D3870
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjJWNv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjJWNvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:51:25 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE9F91
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:51:23 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66d264e67d8so19853226d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698069082; x=1698673882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyzTpU6yHxwPKjUHrtmf7X73Sbkeynns2+Ejar0tKFU=;
        b=vH/9vZ1XoLGtU8WkgO7fgdycRnQVdONuvt5IZL3RKZBHbOI8mf4a1IDCHbEawCqf9A
         vUeVt2o2jI/OHNPuUsf32aewHHJ6ZFHAaC+bCHu2OejtKTIT2wdqfDOk+UpqO5fB5ljj
         EMoJMRgL0v+iVrHhSavPF0GWtM22xx13tPyigWCm8sK8bGqRFRUwmk9C3D1ebZlFYm8e
         1pw6354ShnWKbWnGemFZ4OGOPwZeIobmo3t4rqhUXHh1WLbuA+L+VTsBF1CLmCtOvDzJ
         GOBq84vRDJdFSOXCqDHoqwVXItkYwi7hoasLsiZb3WVqxutC9tAi8B+T5JrYDnYiTpp7
         jW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698069082; x=1698673882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyzTpU6yHxwPKjUHrtmf7X73Sbkeynns2+Ejar0tKFU=;
        b=mHMhvAytwPYZaEZUmiQ3SBsi9ADBSH7UCGttqpYxw114WF4Eh2cni1G3m6GW9akShs
         OR2LEs1YrBTU855GqYus+4BTkfkDaohCAJy0qPFHKqYgkIip3wnbHP5VdYtc+wdx5rrP
         yJhKFTfywFVZ6k9Vl60V8nw2Cr0RQbAN6a2DtvMT45REHCLR36ZeJt3bpR6y9d8Smrim
         zFvacr4mw2nzWuGgbHC9aAYvSIDXjjM0B8AiMUvC9ZDAplqt1DQaIO0C+uEH3Dm3vuo2
         +1/SxVSz9AoGJmFD3AMQ0UxI47Yz3slUH1V/BUzswFmmJAXWqdT1KUpG3GwgxMJwTP9o
         VH4w==
X-Gm-Message-State: AOJu0YzMDk6SxSMJ/geDCYKkOx6zLB6KsBAISt3/9AYEkF7rTJvDgZ37
        AYm8jNNWF1JiYKoTVXmpj/6d6YaKuF0f2A9uv2YQRg==
X-Google-Smtp-Source: AGHT+IEak2TOTKrgumBn2ZcWuB0eRHL2jwv/eMSyTXiaFbiUXrrjRS61MgPfi8BZksmu9eUzIg68Fxzdg8aAcPHvDAc=
X-Received: by 2002:a0c:e0c9:0:b0:66d:aabc:15d0 with SMTP id
 x9-20020a0ce0c9000000b0066daabc15d0mr5631237qvk.6.1698069082051; Mon, 23 Oct
 2023 06:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231023102327.3074212-1-glider@google.com> <20231023102327.3074212-2-glider@google.com>
 <ZTZZyuWKIMSGv+dF@smile.fi.intel.com>
In-Reply-To: <ZTZZyuWKIMSGv+dF@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 23 Oct 2023 15:50:42 +0200
Message-ID: <CAG_fn=VOJM5Ok+rvTMB08TKW=1xkU+LmMDWEPugxBaE0XgbL_w@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] lib/test_bitmap: add tests for bitmap_{read,write}()
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

On Mon, Oct 23, 2023 at 1:32=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Oct 23, 2023 at 12:23:27PM +0200, Alexander Potapenko wrote:
> > Add basic tests ensuring that values can be added at arbitrary position=
s
> > of the bitmap, including those spanning into the adjacent unsigned
> > longs.
>
> ...
>
> > +                             val =3D bitmap_read(bitmap, i, nbits);
> > +                             (void)val;
>
> Is it marked with __must_check? Otherwise why do we need this?

That was a weak attempt to prevent the compiler from completely
optimizing away the bitmap_read() calls, but I haven't really looked
at the result.
The reality is that even with this check the calls are deleted, and
the size of the function is only 68 bytes.
Replacing the val assignment with a WRITE_ONCE() actually ensures the
bitmap_read() calls are not deleted:

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index ba567f53feff1..ae57ae48ef3ad 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -1360,8 +1360,7 @@ static void __init test_bitmap_read_perf(void)
                        for (i =3D 0; i < TEST_BIT_LEN; i++) {
                                if (i + nbits > TEST_BIT_LEN)
                                        break;
-                               val =3D bitmap_read(bitmap, i, nbits);
-                               (void)val;
+                               WRITE_ONCE(val, bitmap_read(bitmap, i, nbit=
s));
                        }
                }
        }


> --
> With Best Regards,
> Andy Shevchenko
>
>


--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
