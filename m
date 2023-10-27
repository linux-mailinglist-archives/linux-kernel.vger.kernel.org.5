Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABFD7D9098
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjJ0IEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbjJ0IEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:04:00 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD2B1A1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:03:58 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7788f513872so137715885a.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698393837; x=1698998637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrlLD9BQJAsTiZgds5zkaHdkPR/+w81GfdeLQRMW4mo=;
        b=PTr6hv/TYcArxfqe49/+8UaqrhPeFk/T7wAfX1qBOuTXW4q39QEt0PjTIm/8dMMcoY
         3ez0A2MHDUksC6eONfzV0eCodg1BCrokylr7iGrX5oV7Eqfa01lFM/OYRgzshrH7MDuD
         mfEWtkxNhss3PH68HmhEQV1P7CbdXBzBHwvsfrqWMN3RrCj61QJ+q17O0FTAvGL3GBku
         aaORfVUSuEnGeJSuEDC6nE3TacFoIlR4sJkgIY8uv+9TbMuNuSdt3R2aixacCiu+2fBs
         NaOI441nFMWL1klWSMeKWI/KCB2b6h3qrUAQUBHPENpiLtANr6Hn+0iAb3/VPjhlUJqL
         NbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393837; x=1698998637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrlLD9BQJAsTiZgds5zkaHdkPR/+w81GfdeLQRMW4mo=;
        b=wYRP0xQZ7kX/MXqJJiJI8gzhCYe2UtKXpfphk5zC3F1f+zqzDowGM9XhfDS199SLqq
         STyxNvFGsavv3NOcZXLP7+dxEgDptTbdEAWhxn/cYtmO/WRaP4ScIpG7anwlGn29yIzT
         2RLQWgp1FF6lIKmA9zsvqCSFuDq5GI/FbjxQyLxi6GGZXvkeCSMl4RJnODxwIzRjSmZR
         jwi7j2ed4iZ2QsuvLs7M4qxiDdjyX9IE9Rslyg0Dp2nIumS+1/f3OjieVg0GqI89QoCe
         Wfma61Ow5Iz/UQP0sbAQR3xqdTmCu2xKb0D+HxRpSquEIvziwXV+6ntQNGaichjTZpmT
         gZ4w==
X-Gm-Message-State: AOJu0YzcqegTtQ7lz6h2gkiT6mTw6tzqsgy9AUX2dRTBfPjcled6Q7vw
        IcDco4SvYXeIChladxX7wd8fjpPD9r0TlL1h33n1pA==
X-Google-Smtp-Source: AGHT+IHfDH5GA9cWwLCgjFyYYNIMC7atlAq/q5CkJVPWpsP6HtAVrZ41WnbMLoAldHT6EsV1+z4Mfa/t0u+fB4f6EpA=
X-Received: by 2002:a05:620a:372a:b0:76c:992e:1b2f with SMTP id
 de42-20020a05620a372a00b0076c992e1b2fmr1929306qkb.13.1698393837441; Fri, 27
 Oct 2023 01:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231026135912.1214302-1-glider@google.com> <ZTp2oLST3nR9AZk4@smile.fi.intel.com>
 <CAG_fn=VSYNk=k1kqKo1vQ7Bd87x9evy6GQBfjdNatOp51x8DZQ@mail.gmail.com> <ZTrIoaFE+c5XQXFs@smile.fi.intel.com>
In-Reply-To: <ZTrIoaFE+c5XQXFs@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 27 Oct 2023 10:03:20 +0200
Message-ID: <CAG_fn=U0hJ5fJ2D4gz=exhwn01XoytzhE=h9XWBr8RFp7P_E3Q@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] lib/bitmap: add bitmap_{read,write}()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
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

On Thu, Oct 26, 2023 at 10:14=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 26, 2023 at 04:48:46PM +0200, Alexander Potapenko wrote:
>
> ...
>
> > > > +static inline void bitmap_write(unsigned long *map,
> > > > +                             unsigned long value,
> > > > +                             unsigned long start, unsigned long nb=
its)
> > >
> > > While noticing strange indentation (you have space for the parameter =
on
> > > the previous line,
> >
> > I believe I do not, maybe that's something on your side?
> > There are tabs in the source, and in the original email.
>
> I meant that you can use 2 lines instead of 3:
>
> static inline void bitmap_write(unsigned long *map, unsigned long value,
>                                 unsigned long start, unsigned long nbits)
>
> > > I realized that this is a counter-intuitive interface.
> > > Can you actually make value the last parameter?
> >
> > It is consistent with bitmap_set_value8(map, value, start), and in all
> > the functions above @nbits is the last parameter.
Oh, I see. Let me fix that.
