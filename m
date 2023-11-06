Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A077E23FE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjKFNRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjKFNQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:16:57 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A18BF3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:16:54 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7dd65052aso53817587b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 05:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699276613; x=1699881413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmQ2IOK4VigklEem+xi/Ol6X6Y0vHqrd8mxsRrkTK0M=;
        b=o0D26NB2AErclWx0GC3/Xj4jGskaDTCUZeXGjBAHl5kF7yXgrHIlVnl/IkaJJzRc49
         Bocen/NPiQl1J70QhbPOEWeSanRyNcwGTzXKAauv681tWvXzuvnSzYCqgNoYApe4Fp/I
         6Q2tkF0jFbgJJzH4nsR75jyow5gQp6Ro68KWLkEQbnUFapAmiNIhEPqt7Z+6UQm/aJQF
         GGJcxD00CwwqVzQaWrzQoYbADUancFisiZywXi+zkT4D5nY8tRN+WqxVlzmN18G7UHdl
         Ce21UnLe+2Ehes2VdBMNFw2lrIMDxkiAzgdQ2nTaIi4E0J8enm43ml8rrtVYqyTUEqc4
         wHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699276613; x=1699881413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmQ2IOK4VigklEem+xi/Ol6X6Y0vHqrd8mxsRrkTK0M=;
        b=gYOnGXD7in2qYdt9j+9eMyAwKJW5gbmkLYs8huot8w7yXD9ouCsW64HKakAvhHmxmf
         RKkyt+FhxsoC9639ULA6MqQMjmSBqWtuE1BTX0fvIxI/IqN9mx8gh9lJxvKwMQ5nN6+1
         NRm6Hrxs3I/RrakCq0gTFrx8CrCYyyL0xQLDkZwlBHBpoqfZETMlA/KQkQGexc+gz/A6
         frXg5++PTeqq83hqpSXi7KPnp2PF+V+6ime3ZqQN4orhXy5WHmgPYUvGLH2Mnv8vDlHg
         HlfM77LKdpx8ZCyP427ZLoVG21vtBMjecOvkblqrAbnLQrJkvDAdSLyL6FWqjXO3lcYQ
         a9JA==
X-Gm-Message-State: AOJu0YzwViVEIaUopUYyOXjBfblcJYKP/mbNo7nT5MJ1gxs9niw1eN/6
        dqK/J/yu8WOtKLsgaOZF1U6V0o+6Xv9PYhhbMq3TvKmZjbUSGYuD
X-Google-Smtp-Source: AGHT+IEYdwFGrQpGmkQoM+END07GEaA8YSVQaf19XAB8XjDlCXnkhETD4WV4pjnnBA9GjZXOEomsSXTdH4JAzr2deNY=
X-Received: by 2002:a25:54e:0:b0:da0:ce05:ca2c with SMTP id
 75-20020a25054e000000b00da0ce05ca2cmr25226767ybf.7.1699276613651; Mon, 06 Nov
 2023 05:16:53 -0800 (PST)
MIME-Version: 1.0
References: <202310190854.yTRUMqLL-lkp@intel.com>
In-Reply-To: <202310190854.yTRUMqLL-lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Nov 2023 14:16:42 +0100
Message-ID: <CACRpkdZ-1OcZ-cz0V218-VxAc07DMPvKWee3MHngs6Hrwv4zPA@mail.gmail.com>
Subject: Re: arch/arm/include/asm/memory.h:298:23: warning: array subscript -1
 is outside array bounds of 'const void[2147483647]'
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robot,

On Thu, Oct 19, 2023 at 2:22=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:

>    In function 'virt_to_pfn',
>        inlined from 'pfn_is_nosave' at arch/arm/kernel/hibernate.c:29:33:
> >> arch/arm/include/asm/memory.h:298:23: warning: array subscript -1 is o=
utside array bounds of 'const void[2147483647]' [-Warray-bounds=3D]
>      298 |         unsigned long kaddr =3D (unsigned long)p;

What does this even mean?

>    296  static inline unsigned long virt_to_pfn(const void *p)
>    297  {
>  > 298          unsigned long kaddr =3D (unsigned long)p;
>    299          return (((kaddr - PAGE_OFFSET) >> PAGE_SHIFT) +
>    300                  PHYS_PFN_OFFSET);
>    301  }

Array out of bounds? It's not even an array! What's up with this warning?

Yours,
Linus Walleij
