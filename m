Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3F277711D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjHJHPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjHJHPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:15:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F3912D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:15:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso582360f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691651717; x=1692256517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UR7Lvol0nL5qJqdk+EAflqogsBm2jlNb+rpEaQRXEuI=;
        b=qJ4XRDLarXrFBClncAjIiyyvqREnotU+C8Z68t+4hq5DS6i05ymSbaQs22uvMBqJ7p
         C6cB1/oSgIAy5Ah39K7zPFUq4udynF8B2WIXVnhNCT0kgysVvWE3S3tlB1/DflAK3Ag6
         0nhEFlXfJPU9vepMNTmR/7u76Cpzw9UUdqII867VSdH15SFm8bVyxe4KM0IoUyogDtsL
         g66nxzIpxbajTtvKj4g+IfNrcjaipuTGBG2sdV1KDZ0j0P1Wi8LyaLz5a+zo5T5rOoaL
         ihYJSgSEU8Eoaeubu2FaMFjDsqRMCz7T/wViXEoCz+lu3N2PD+wctdEs5QL+kN5NJ6kp
         nIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691651717; x=1692256517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UR7Lvol0nL5qJqdk+EAflqogsBm2jlNb+rpEaQRXEuI=;
        b=PR9dhWY8ZXWcvqwMCSseWdD0e1dLpuhFQpnP5Hieft6hdRgndlX2qDgzLqYWlRbaHY
         XyFv4Hd6Z/4xWPaXgNVMuv6w5OvcPFx1qpY+qVX1e9EH8lIuPS9eSU/DX/xGwLKZxjAR
         SzgpS4TZtkYDHUSKwDNSzBsNYT3AC64paCi7Y39lsLR2ei5PMMwJL6Clykh5ev083qJK
         LyCEstkDEh4yLlLyT9zFuoFtvPS9ii+bsVClOQLK1uNU5VwCShxHds9K1Uk+rN1WLM3R
         r/QAiVIOvYEENTzliSvRJLSGvIf9Om3Xg1TTwug9xBIGHAWcUn5CZwn1II+G9OZltAaN
         NZHw==
X-Gm-Message-State: AOJu0YzgMyNuh4xyXniR72h5v+ZJ44HDMgCGS53dO+fr5liT4XL/7my/
        7VAXWJV18y6Dl2ki1ic3l+lut2EVSM0rYHW1AI/7ew==
X-Google-Smtp-Source: AGHT+IFku+bGrHFUw2ZSjsqeKgHnWsUUDlqTBOOUarcrquYrxDBeGIS90I8A4gObaJoYRSwMWhSYKvLQWTHcsFVCU8w=
X-Received: by 2002:adf:e9cc:0:b0:318:7c3:12c8 with SMTP id
 l12-20020adfe9cc000000b0031807c312c8mr1414690wrn.21.1691651717439; Thu, 10
 Aug 2023 00:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230809164633.1556126-1-alexghiti@rivosinc.com> <20230809114651.eb690e5bd4c60b075eb3111b@linux-foundation.org>
In-Reply-To: <20230809114651.eb690e5bd4c60b075eb3111b@linux-foundation.org>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 10 Aug 2023 09:15:06 +0200
Message-ID: <CAHVXubhcPb3ZF52kM0ZqNi8p-kbXRXPae+0vGioiShyhnZZMSw@mail.gmail.com>
Subject: Re: [PATCH -fixes] mm: Add a call to flush_cache_vmap() in vmap_pfn()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dylan Jhong <dylan@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Aug 9, 2023 at 8:46=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed,  9 Aug 2023 18:46:33 +0200 Alexandre Ghiti <alexghiti@rivosinc.co=
m> wrote:
>
> > flush_cache_vmap() must be called after new vmalloc mappings are
> > installed in the page table in order to allow architectures to make sur=
e
> > the new mapping is visible.
>
> Thanks.  What are the user-visible effects of this bug?

It could lead to a panic since on some architectures (like powerpc),
the page table walker could see the wrong pte value and trigger a
spurious page fault that can not be resolved (see commit f1cb8f9beba8
("powerpc/64s/radix: avoid ptesync after set_pte and
ptep_set_access_flags")).

But actually the patch is aiming at riscv: the riscv specification
allows the caching of invalid entries in the TLB, and since we
recently removed the vmalloc page fault handling, we now need to emit
a tlb shootdown whenever a new vmalloc mapping is emitted
(https://lore.kernel.org/linux-riscv/20230725132246.817726-1-alexghiti@rivo=
sinc.com/).
That's a temporary solution, there are ways to avoid that :)

Thanks,

Alex
