Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD75779042
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbjHKNGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbjHKNFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:05:55 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992F63A91
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:05:30 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-403e7472b28so12703951cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691759129; x=1692363929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zFecgYSyy3fcX0MpgCf/lDrE1WYMG3tL9ZTr5KHL5M=;
        b=UgcCwz3fTmoSFxRXlfMxGXF2G5UMe7XxG/IQbtFFPagyunIfAdfntmOoEOn559HKPq
         ux0MihFhHwW5Tsnr+wgN8wD1IvKJg67erTemFx2awDwmPZUkkVHU3O7lituqqJFPJOFb
         S+/shT1fSEDbG8f8aUsVXVa87FwYhsQgGmOxIdIbEXAGYlsu3n0nD5d/MvUGPoUPuRPD
         97iG0oj/dH1u/XY92cCAG8ogt7gG1e35PQ2d3/7zGLGO9CzkL+L/c86+FGWhQdwxSKNH
         jqKBTogCrqbsNXgfqjlps6iACeTRabj0xnnuOByWd21OlKHYr+dPyBXPFrK7e1r+EZ32
         88kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759129; x=1692363929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zFecgYSyy3fcX0MpgCf/lDrE1WYMG3tL9ZTr5KHL5M=;
        b=IHxh6HzMTuliW2YPcDrxYBpD/bvyCjyDUT55S8t+D4/iT25dRsE8ZoiRHTsRfe2/17
         IoueF3+jipXLrOmYJ8GgR945VeMStv73DXdC+mgjRFE9gSsfx3w2nvB58Kp8nHxkGpph
         HsvhqSMjV7YBHpMZcY6+WI4KC/4/Q9Gr2EISTUUrmJbZusW6DbJDWVZebTvWVLgNsh1e
         n/DhrgTCYvdpWWJ6upNpfwMoZ0oe2FUUZytyt8GsiyDotN9e5kG4834RGoffb8BDqkK3
         mAnbI2MCkm0btBXObpx0DaFgMY6cbnL/HyJuUi8KZJa+Q64iLR9IjrlbsltNNV8r7Utx
         qJ2g==
X-Gm-Message-State: AOJu0YyqnuTr3raCU2sbn45cw5wOSelsjOCxHkMR/2jYwcgeAnmfuIiG
        nAM1tEdUEpHuiaBzUHhaQH0N5lpx9Gs=
X-Google-Smtp-Source: AGHT+IFI5mwDPAKiVtbpZadPynGtEbk6pbhoFqtAXShRaWXUutNrotGVeDIPnwf3Rb3XYujpE2p/vg==
X-Received: by 2002:a05:622a:cc:b0:403:df34:9575 with SMTP id p12-20020a05622a00cc00b00403df349575mr2254747qtw.34.1691759129257;
        Fri, 11 Aug 2023 06:05:29 -0700 (PDT)
Received: from localhost (2603-7080-3d03-3cb9-d639-a70b-9607-2020.res6.spectrum.com. [2603:7080:3d03:3cb9:d639:a70b:9607:2020])
        by smtp.gmail.com with ESMTPSA id w7-20020ae9e507000000b00767d572d651sm1171968qkf.87.2023.08.11.06.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:05:28 -0700 (PDT)
Date:   Fri, 11 Aug 2023 06:05:27 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 6/6] bitmap: move bitmap_*_region functions to bitmap.h
Message-ID: <ZNYyFzUWwVcpUhK7@yury-ThinkPad>
References: <20230811005732.107718-1-yury.norov@gmail.com>
 <20230811005732.107718-7-yury.norov@gmail.com>
 <ZNX/F45GKXSRDgG/@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNX/F45GKXSRDgG/@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:27:51PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 10, 2023 at 05:57:32PM -0700, Yury Norov wrote:
> > Now that bitmap_*_region() functions are implemented as thin wrappers
> > around others, it's worth to move them to the header, as it opens room
> > for compile-time optimizations.
> 
> ...
> 
> > + * Return 0 on success, or %-EBUSY if specified region wasn't
> > + * free (not all bits were zero).
> 
> Run
> 
> 	scripts/kernel-doc -v -none -Wall
> ...
> 
> Seems like the original code has all these, perhaps update in a separate patch?
 
Yes. This patch is named _move_, which means - I don't touch the code.
I already replaced (1U << order) to BIT(order), and I'm not happy with
that. We need to do that in a separate patch.

Thanks,
Yury
