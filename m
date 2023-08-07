Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCF27729E5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjHGP4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjHGP4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:56:44 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DA2E5A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:56:43 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-63cfd6e3835so26495856d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 08:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691423803; x=1692028603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/3HCjX2FDd6NwWI7Dfn7wM+IO0cTfOjTBaP0ZWhR0M=;
        b=I1KtwYq4X9vF8dUm+SAYay5Osh496KIl8EIso0fdsHP6AuSjHU/0bwM0PCABqlhzXP
         Y5bIJbEowf/pc1Yae2myn0Y2m4fnl2Afx/gzEsZ5KOBfIgomZuEBj4r0bN5WYsopRJ+6
         YY0qTlRtCrdJ36hp71KMjmnUHyVCoYUE7LJunJ02bO+hwe8W+xNIclOjcrFUskUNK9LR
         8syzk+aviPXbxQmmAnvyDKcn03pXe3PJ9JqZX5X9LyPnPOCD69FiPKj7ZxxJ2zITHklH
         vhKD9sT3f7KjYfnx+knNpFj0qsm0J+dFMlRC9AoEJ8RNc6cJVcRWBRwkQbDwjCIE/qkf
         LzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691423803; x=1692028603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/3HCjX2FDd6NwWI7Dfn7wM+IO0cTfOjTBaP0ZWhR0M=;
        b=Zfdx5xCDMALHEzGQwchlllcFxvUbG70yPxFC1+n1S7DK/ljKh8i4g1pvBye8nrFuXy
         +xWCqI7BGLqXhJ0uWV+jpF0RWOjUigT+dUQyULKZJFv+fUpGi88fU8iy8nKAe5OPfe4T
         Hjmd0RhI+FTv+QWtu+Nrs07Z4g2VNplsCJ0Fn0Ichy3IYpBKo06GgWKoWZapypDYrHfZ
         YVe9RLp79Jfc6SMkjbssiYJJAPYlr2DwvxWlWNcs54XW7R3nWfKTHs1EkM0kqmLULyRD
         dI1CLQu4pzIskfTFhuxl+/ooXnxE0ZmHSn/nEVHOSavzN5pk70oQv6hjsmvzhBvxaHcW
         ExRw==
X-Gm-Message-State: AOJu0YyQhBy5Z0T3Ar89YyUxPFdnHGKZE3EFVf+6Uoeu08z068kJyVFQ
        N+VnrydGYtOGpgSjUaVM11ZNKL3T6YvAl2qTi6QhhQ==
X-Google-Smtp-Source: AGHT+IGlTi0iRwJC5cwOfwrT4Jmzbh8fldheRHVXoIZi9LPsr5+w6AnDdx9fHDpY4Q6JYsbgGCWC9X9YJ1lew0ivQg8=
X-Received: by 2002:a0c:cb8b:0:b0:63d:3abe:162b with SMTP id
 p11-20020a0ccb8b000000b0063d3abe162bmr8702323qvk.38.1691423802650; Mon, 07
 Aug 2023 08:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230806083021.2243574-1-kernel@xen0n.name> <CAAhV-H4ypd-+z-KbeGM6C_mNk0aggk2yhdDik-XfPNWqsO=j=A@mail.gmail.com>
 <d591bfef-9146-abf6-04d0-96600ebb7a15@xen0n.name> <254baed00504ef3cec36e58540a3fdcca346a407.camel@xry111.site>
In-Reply-To: <254baed00504ef3cec36e58540a3fdcca346a407.camel@xry111.site>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Aug 2023 08:56:31 -0700
Message-ID: <CAKwvOdkJy12sZiqPyoZWb2-m4r5zywjo-cHkHGBu9XksU-RRxg@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Replace -ffreestanding with finer-grained -fno-builtin's
To:     Xi Ruoyao <xry111@xry111.site>, WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        loongarch@lists.linux.dev, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>
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

On Mon, Aug 7, 2023 at 12:17=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Sun, 2023-08-06 at 18:31 +0800, WANG Xuerui wrote:
> > > > +cflags-y +=3D -fno-builtin-memcpy -fno-builtin-memmove -fno-builti=
n-memset
>
> Can we only apply them for GCC <=3D 13?  I think with GCC 14 the built-in
> implementations are quite reasonable (well, maybe it's some human ego
> because I wrote them :).

Yes, and because only GCC-13 and older users should pay that penalty.

--=20
Thanks,
~Nick Desaulniers
