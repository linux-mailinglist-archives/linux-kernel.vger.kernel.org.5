Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E787D4F73
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjJXMHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjJXMHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:07:30 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85ABD79
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:07:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b9af7d41d2so3662255b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698149248; x=1698754048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnbQ6Q2EDEmeDrsBAt+FskdauroAd8IioN5ZwkR9W1E=;
        b=Z8ToVP4YdGc/2ZIa7dKHtDbq3o5iYB93FcJ955m/jR+4ZFG9BZ2pDVZOWevPLLIxLR
         72Q00xewF8LcZybXSDwEK12lSPK7Z6UHFZFsCJsjtMOwuqN7MfnN7CphIVPa8P3BrHaP
         kakWlChh7qkQVb4Ak0+Rm6zAMHBjaXcLRg7X0prRxG9dGGvcInGW+Dg6RaAB+xRWygRq
         hgTqbaVLLI1nzUjBUNtoOgbkMV48SU3I4vkwAifvErV/HuRHG5NJOAm1kOuDMzzIVHOK
         gUyVWBQVVr5ZN51Fy2JYNJXYmzi6GCIB+DyBVXhMJ4gqDfOXfd0bBglXOeFkVaHM1Zyi
         5v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698149248; x=1698754048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnbQ6Q2EDEmeDrsBAt+FskdauroAd8IioN5ZwkR9W1E=;
        b=IzbG9rN1cjL3m/cIWbxIueAxBRI6ux8xDA6yOhJ7Bhdry0U8GWh2DJkhLgZpq2nSs5
         PCso/BsTuWojLVcGorYzgnq0w9tndJXn679oQh3wpUiPlbdPe6bbUDRzT7fnnkpR/oJ1
         KCeymnaOK4TvpQOkJCxySpGUdUTOvclMSRhcSk9LS6gL2+ZK4ztelxGbec5gVqV2xSNV
         oN+ykg9HVdTxpIT71AHWk5yRtQRqgMdGLNWkFgiTWur/Z9as4XbFFPXOOtF67RRlOx8R
         IGYGmyZdALgq6xTAiQFpFnbffUBUta+y1rhvfJwJOaUXZ+ZVYOoLtUX6vQ4/X9c7j7T3
         JbnQ==
X-Gm-Message-State: AOJu0YxUNAizEfBF8tXmzK3St7G3Fl6Ye/Z1LGbw4GhoP2+0PSk7W4ul
        oe4u7sXYKRAU8+Ot8zEUmV1LFdGLISfBKsZl75KHIg==
X-Google-Smtp-Source: AGHT+IG0RTgNFoEme/gXUtHy69ZlWk+VDdfjWqZ9EjZXIbatFOkLD9Eb6PUwQTRfBjWAxVZwmGXX+UlFPH+OLG/I4So=
X-Received: by 2002:a05:6a20:e109:b0:163:2da1:387f with SMTP id
 kr9-20020a056a20e10900b001632da1387fmr3054954pzb.50.1698149247695; Tue, 24
 Oct 2023 05:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-2-apatel@ventanamicro.com> <87h6mgs09f.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87h6mgs09f.fsf@all.your.base.are.belong.to.us>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 24 Oct 2023 17:37:16 +0530
Message-ID: <CAK9=C2U7nRc95-DoxesfOzBBat8wNMhTqi4NTJWgJjQYd9NZow@mail.gmail.com>
Subject: Re: [PATCH v11 01/14] RISC-V: Don't fail in riscv_of_parent_hartid()
 for disabled HARTs
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 5:25=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Anup Patel <apatel@ventanamicro.com> writes:
>
> > The riscv_of_processor_hartid() used by riscv_of_parent_hartid() fails
> > for HARTs disabled in the DT. This results in the following warning
> > thrown by the RISC-V INTC driver for the E-core on SiFive boards:
> >
> > [    0.000000] riscv-intc: unable to find hart id for /cpus/cpu@0/inter=
rupt-controller
> >
> > The riscv_of_parent_hartid() is only expected to read the hartid from
> > the DT so we should directly call of_get_cpu_hwid() instead of calling
> > riscv_of_processor_hartid().
> >
> > Fixes: ad635e723e17 ("riscv: cpu: Add 64bit hartid support on RV64")
>
> Patch 1 and 3: These fixes are stand alone, and doesn't have to be part
> of the series.
>
> Wouldn't it be better to pull these out of the long-going series, and
> try to get in the fixes ASAP?

Yes, that is correct. In fact, PATCH2 can also be taken for Linux-6.7.

I suggest PATCH1 to PATCH3 (3 patches) be taken for Linux-6.7
since the merge window is pretty close.

Regards,
Anup
