Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D529D7568D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjGQQPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjGQQPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:15:38 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919231B1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:15:36 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-66869feb7d1so3105810b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689610536; x=1692202536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=loU1C5x4p9UkGcEtbmYkzDU6K+z3uaBTem3hfNNmwKQ=;
        b=s347ujev/arYWeUr14UEPuUdWYBStaLpJKHfJdQVKw4Y3vZJyM4rFQ9SFB0oPpdjQy
         vlXbbeUQUOoO2krl3H1zd0m1Leh6PPT1j1970eiUHkAJZ3J2PndLo6A2jw6LoufLjdhl
         ubJ5nh7baVcOKeaSMCV6ToYZx9nwCg4O2/yekEgjaECgbe5HgU7rmE05wQPuVpjVgN/P
         5S2ppAPmtSuGDiHuCShqfp9azEU0kRaU2tmfrbX952hXQP4FyCo49fdqvlM8b3v821J/
         v6HX0FViqgaifaT4i5xdGLRh9yEpe4dXe3nnUdMPDX18+CQ/5XnmoQTpzkkyB54WsVAV
         tV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689610536; x=1692202536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loU1C5x4p9UkGcEtbmYkzDU6K+z3uaBTem3hfNNmwKQ=;
        b=KE65KRqmifdc1KmBU3HgCbRwZebm4RahioTB5zOTnl2yTXsJ8e7n6ItvsCeI4NGvn4
         Ct6wyFy6Pd6IKrvRLoTXzYr5bM5/xlCY6yf6SqbytaO7KqtU3a4MMuxrU+lzhc5LRLis
         gbn0V30WmDMFojK0AnwouNtp/R7hxKInXDs9+jAfvxh+cttNGf7/OXYWgYYmYh1d1ABZ
         MMRNswmol3WyHYlUREtM3MmGxSzifubkPc14+eoJQXuctHdoaE6ct8DrScRDQYBWh98I
         nh5RRdZ7de4J5TwDjBZjggNiOKE4TPAsN/y6u0fe0tj61TNJ/bFIXxogW6gCAHJH7Ovm
         B4qQ==
X-Gm-Message-State: ABy/qLa4EY9S9XYqhabHUZ2jgpMgHVrAiLEHSw7e13xCeX8noPsv/oqG
        uxPVW7cu2SSpt9fbhuYhwOgAJabpdiEcKQ==
X-Google-Smtp-Source: APBJJlH1BkyNnXyc/AKqxY2gNyKB5RxSK8NDJrZSpq6MCqvG3Va3Wk3rUlfuRtgwP2TzN2wY2Jou9A==
X-Received: by 2002:a05:6a00:ac4:b0:663:5624:6fde with SMTP id c4-20020a056a000ac400b0066356246fdemr16100074pfl.22.1689610535983;
        Mon, 17 Jul 2023 09:15:35 -0700 (PDT)
Received: from localhost (72-24-220-98.cpe.sparklight.net. [72.24.220.98])
        by smtp.gmail.com with ESMTPSA id i18-20020aa78d92000000b006765cb32558sm5600pfr.139.2023.07.17.09.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 09:15:35 -0700 (PDT)
Date:   Mon, 17 Jul 2023 09:15:34 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/5] lib/bitmap: add bitmap_{set,get}_value()
Message-ID: <ZLVpHmPK5oLhGPAo@yury-ThinkPad>
References: <20230717113709.328671-1-glider@google.com>
 <20230717113709.328671-2-glider@google.com>
 <ZLU7mkhUiDQodaw1@smile.fi.intel.com>
 <CAG_fn=XNYQC8gKKQr3Mz7CVw8H=Ubmr+QaUu-jraoT4sN550rA@mail.gmail.com>
 <ZLVQOF0F4OfZQ8Qt@smile.fi.intel.com>
 <ZLVQ0NCC8SI5F8xR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLVQ0NCC8SI5F8xR@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:31:44PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 17, 2023 at 05:29:12PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 17, 2023 at 04:14:57PM +0200, Alexander Potapenko wrote:
> 
> ...
> 
> > > > > +             map[index] &= ~(GENMASK(nbits + offset - 1, offset));
> > > >
> > > > I remember that this construction may bring horrible code on some architectures
> > > > with some version(s) of the compiler (*).
> > > 
> > > Wow, even the trunk Clang and GCC seem to generate better code for
> > > your version of this line: https://godbolt.org/z/36Kqxhe6j
> > 
> > Wow, indeed! Perhaps time to report to clang and GCC people. I believe the root
> > cause is that in the original version compiler can't prove that l is constant
> > for GENMASK().
> > 
> > > > To fix that I found an easy refactoring:
> > > >
> > > >                 map[index] &= ~(GENMASK(nbits, 0) << offset));
> 
> nbits - 1 it should be, btw. In any case it seems the code is still better.
 
 Yep.

 Alexander, for the next round can you please show disassembly for the
 functions in case of compile-time and run-time defined start and nbits?


 Thanks,
 Yury
