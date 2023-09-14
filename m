Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE247A0737
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbjINOZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbjINOZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:25:15 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4850110
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:25:10 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b703a0453fso16671581fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1694701509; x=1695306309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsrwoDLjRwnaUZYSy5S/KIF4yMwSVKMWZIEdp6t3G5c=;
        b=I9XekOl9Ud1KpV86uwCBAIDZrgJoTvDFVWUYZfRvmYr9BaqhWiq85cK7nGOG442iED
         +M18iqa//ZbsN8XStk2NXvTa/SN8+GHFAILZgq1M772EPnCBF2chqjgIswTqZS2x3rsv
         6ANKPWaYh7ccdsqXBn3lSAHQx6AaKcljeDsNa4VQIrN8A5zLLLRanjeNiE2coKCdRM0T
         HGvQGliQg8UZQthvlw40bUllQZ/Nfz7gR/MW/KnyWbD7NJZIb1Eg0Cj0jifpahOkcd3T
         ygHZEZh6glZPxtBruw3Rx2T8gkNwVNxu/tvylCF9Cu7EWs9kpngOhdU235O4QDzHEMfj
         620A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694701509; x=1695306309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsrwoDLjRwnaUZYSy5S/KIF4yMwSVKMWZIEdp6t3G5c=;
        b=dv//aL14UE3EYIADWTNm2nVCE9Wr+MWZe4zGBBagvsYHZzaPu/oTTeoRcdmadUUTqF
         CNiJjIL1jnJpsJIJF0ZXeh9CJ2ZGzVtl+/EBUKKywA2lbjanxOwQFmjcgDBWwcD/7uDX
         Vwrs2ViH8IyF2OIW80wOjTy7dZrUgSlD6XYdyjZC4sCcvbEqp0zBg1LUOfyE0/u/1Lwt
         o1SXaDIFnWR8+AwdAe2yfndVi0RyQ9/r3iRLj/0/ydqw5dXRl6rAhhBnRBWQFdUIwkKc
         Iq3+iJURF9mRr3zyifpQxMpxW+z9qmFC5UHahfLy97SL8UUR6JGnZVZlZ/O1UXxmQ2QU
         1WRg==
X-Gm-Message-State: AOJu0YwoBDiGcmqJSKE/MudHW4kKuTfcFJWaO/+TVEseUpduVHwMJSdm
        AukxnXSVVC6wevb4DYK1DHRFlLzpdoB+5AIMY3m/ww==
X-Google-Smtp-Source: AGHT+IFyq+HOt9ZCbHlcgwJ92zFW7w8JnSXnuczSf+sy7/bCSbqTHrj1vp8l9l0tUJyltYlfynCBiC2Z1KNZnnePLY0=
X-Received: by 2002:a05:6512:3988:b0:4f8:7124:6803 with SMTP id
 j8-20020a056512398800b004f871246803mr5641252lfu.35.1694701509009; Thu, 14 Sep
 2023 07:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230912115728.172982-1-bjorn@kernel.org> <20230914-roaming-plunging-948c78d9831c@wendy>
 <87pm2kap1p.fsf@all.your.base.are.belong.to.us> <20230914-float-uneven-7cd1a18b3978@wendy>
 <87zg1o3kpd.fsf@all.your.base.are.belong.to.us> <20230914-squad-ripping-e8c98e2d336b@spud>
In-Reply-To: <20230914-squad-ripping-e8c98e2d336b@spud>
From:   Andy Chiu <andy.chiu@sifive.com>
Date:   Thu, 14 Sep 2023 22:24:57 +0800
Message-ID: <CABgGipW6NhfOstpe-P7RZeaF-w72GLqiE2sxLsZVzJx1AC6kqA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] RISC-V BLAKE2s Vector implementation
To:     Conor Dooley <conor@kernel.org>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Greentime Hu <greentime.hu@sifive.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:18=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Thu, Sep 14, 2023 at 04:15:10PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
> > Conor Dooley <conor.dooley@microchip.com> writes:
> >
> > > On Thu, Sep 14, 2023 at 02:59:30PM +0200, Bj=C3=B6rn T=C3=B6pel wrote=
:
> > >> Conor Dooley <conor.dooley@microchip.com> writes:
> > >>
> > >> > On Tue, Sep 12, 2023 at 01:57:22PM +0200, Bj=C3=B6rn T=C3=B6pel wr=
ote:
> > >> >> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > >> >>
> > >> >> Hi,
> > >> >>
> > >> >> This is Andy's kernel mode vector V2 series [1], with my BLAKE2s
> > >> >> AVX-512-to-RISC-V translation patch appended.
> > >> >>
> > >> >> I've tagged it as RFC, since Andy's series is still not in-tree y=
et.
> > >> >>
> > >> >> It's a first step towards a Vector aided Wireguard! ;-)
> > >> >
> > >> > This has the same problems as Andy's stuff & doesn't build properl=
y for the
> > >> > automation. What is the plan between yourself and Andy for submitt=
ing a
> > >> > version of the in-kernel vector support that passes build testing?
> > >>
> > >> I'll synch up with Andy! I'm not even sure the blake2s patch should =
part
> > >> of the "in-kernel vector" series at all.

Hi, yes, I have a plan to fix it recently. Please expect a respin of
the kernel-mode vector in 1~2 weeks, if this doesn't seem too long to
you.

> > >
> > > The in-kernel vector stuff should come with a user, otherwise it's de=
ad
> > > code :)
> >
> > Sure, just so we're on the same page; Patch 3 (Vector XOR) is a user
> > from my perspective, no?
>
> D'oh

Thanks,
Andy
