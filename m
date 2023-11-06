Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDADA7E243E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjKFNTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjKFNTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:19:47 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55914D8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:19:45 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso3736743276.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 05:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699276784; x=1699881584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiUiGTDw2L16fzzzRKog25kYUOwp+f3RU1IqM1t1EJw=;
        b=PK+Wa1CJAw4KJe5dtG2df/+I+JsR0ZVpEN225df7FZlsa9KOZrCIP53uEn7I7CTb5X
         7RvpJPYg6LIEl1+wspkFAXGXOeLmjSZcDLD0abmB5/O0vS+WhBkbh4HlsPE5NOzIv93g
         tBYb4QGSRDCvwy1+MDb3Brr2+Kro5L2bJ4Pzrg0pUYviqjLROP4CH1FtiNAu144C8q6j
         5rBqKno8gpWV1slscNTaMP53Tp4wEHb7geZZrEMzkD0EmZpWYJK/pkdHG7tZaL7NYcna
         sZeZ+n74VIzy3aokQC2gGm7Aw8e5pQ/L+ZtjJqFsTV/qorg3q9ea92acRonFGBUulr+F
         uT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699276784; x=1699881584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiUiGTDw2L16fzzzRKog25kYUOwp+f3RU1IqM1t1EJw=;
        b=f6Tr1/yYoodkbnVoa/YSWt7iwMRarEfTE0vwr8WJ8t1l9Fqi/vmXeyNAZWzaiSv0Ny
         3hbA9j84QzrxxSO9wl0/wZTP67GgRL2WQws0NynwbJ+vfBJTdDgXJ8exfOOH6aBKyKbV
         q/VRuwv4gpQnFGpEKvs3nbVQYPx/i9WuWCOiEWyRxBiW7cFXZ48FS8a4jBUVt1+/kpsZ
         5UAt6cuIRXFEPgJXW2sDvowZW8eUBADc5pD0Al2YrdNmHCkJ14VemIUMlZN+6pajZvXZ
         DUh1mhsmmX2S5H0gPchoE8LpI5x9SjLFiNejK8ehQupIetnb0HIt3a+5AmIoOWBDiHCX
         9lHA==
X-Gm-Message-State: AOJu0YzmwD5iJA3CCzu1Wx8cduqULULIwu0GugvoyobFzioi5rFIPgLL
        Q8j4IzbrRruykYF4NuOq8djk2LxMoldNcOaoi34LRPHOp/sUsncC
X-Google-Smtp-Source: AGHT+IHgA9z2qIVT+0Ljt/yzsoxDF3rhQPeogx4ZqKR8ZqhwKwcPAyMLEL/eX7bIE/fWwhyKs/gIAgtXgSK5W+gTASQ=
X-Received: by 2002:a25:874a:0:b0:da0:48e0:ca with SMTP id e10-20020a25874a000000b00da048e000camr23268258ybn.29.1699276784527;
 Mon, 06 Nov 2023 05:19:44 -0800 (PST)
MIME-Version: 1.0
References: <202310182007.8ziiRe0j-lkp@intel.com>
In-Reply-To: <202310182007.8ziiRe0j-lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Nov 2023 14:19:33 +0100
Message-ID: <CACRpkdaB390mn2s3vrVAhaY9Portxdzc8bVkM5F3DtVy-k-r2Q@mail.gmail.com>
Subject: Re: arch/arm/kernel/hibernate.c:29:40: warning: array subscript -1 is
 outside array bounds of 'const void[2147483647]'
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robot,

On Wed, Oct 18, 2023 at 2:17=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:

>    arch/arm/kernel/hibernate.c: In function 'pfn_is_nosave':
> >> arch/arm/kernel/hibernate.c:29:40: warning: array subscript -1 is outs=
ide array bounds of 'const void[2147483647]' [-Warray-bounds=3D]
>       29 |         unsigned long nosave_end_pfn =3D virt_to_pfn(&__nosave=
_end - 1);
>          |                                        ^~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~

So the concern is that &__nosave_end  could be 0 and the -1 would make
it wrap around?

It still has nothing to do with arrays, I don't get it.

Yours,
Linus Walleij
