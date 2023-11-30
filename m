Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3288D7FEDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbjK3LVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345030AbjK3LVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:21:40 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30286D7F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:21:46 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c5f0e325a6so667591a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701343305; x=1701948105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltGzMuZdljyy4p9L7jjaFw9tXSIPc3yGXDmblWBRMWY=;
        b=HwRYZxT33wKpw1I34GferT86sdlGV6yQZQ1NKjEV0hoj1+4j05Pal8/LDJE+1PinI4
         rzDTzwgtoRQcu4MpL6VjE0Mw7eS3MguN8+NPzHT5oENJCLcP08ENDUqprwFF8to0822J
         6nbchimMNk2ZkrlvKYqxLW/EH4T3nrtnIe/a8QmDd00rke9cOkPCtBquO0+a961QCy7y
         gcMm6w00fadV0HjryReLfXM3d3Xi5DWdIQxfKtjxzBHsfAUoUpU67RvOdI1/gdGTYTvg
         se+SZQjJQEke7+jLdXWA4AS6RXGnR5s23YLEArS3bita0NkHIRzJWSCVhp5y7q04LgkU
         erRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701343305; x=1701948105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltGzMuZdljyy4p9L7jjaFw9tXSIPc3yGXDmblWBRMWY=;
        b=fKcoWq/AR5HbIpnMRZuuX+SbQmKRbvVde+sgg+Z3WAG2ifFzoWrFJFwWVpL+TN8xLj
         4mOm6AW7eN0sBuj+rH7quyeinzkm8dQl8B2r6K4GKK14s9E3KALHqLKUxROiKlTc9R+2
         +Y5gIVS2WqfCLPwuTnKwtTea66Tl2kJayzzCfT58ei/iKfLX9vx41dpfITRXBmXMGO2/
         /7ugMfMmxnSClOuVDi/ZFVsXI8ho4jSCPKKSKEX57pL5t06LhPBuyhPBm/k70J+j4omf
         tih18yYexkh0ffge4yUega9duH2uePxZTuPp0F1r8Hwjbhcc+3B9Xgy1KrrSHMb+fW7B
         ekUw==
X-Gm-Message-State: AOJu0YxwaGqD6ywHR9CP0bEfo5TXBTZr9eKP0Cc2ei6+dc4kEiyIvlLi
        8bpi8U+RuCkYlEBWf7xIQEeN0weUwG6KhvWzrpVE5A==
X-Google-Smtp-Source: AGHT+IF1S/IheRCM150IkNersDCOV2nBhyW4KGeG1e3KISfGM2lz6pCiY+RuMxoMWvr3xnAIuZKsEHeGFOSAh6Y227M=
X-Received: by 2002:a05:6a20:1594:b0:18d:b43:78f9 with SMTP id
 h20-20020a056a20159400b0018d0b4378f9mr4632472pzj.39.1701343305387; Thu, 30
 Nov 2023 03:21:45 -0800 (PST)
MIME-Version: 1.0
References: <IA1PR20MB4953C82499C5D81D2C6A020BBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953F9D77FFC76A9D236922DBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CAK9=C2WAv5jJBt56xBea268DeyUA+YvbU7i+ahVjueafCi-r6A@mail.gmail.com> <20231130-decibel-passenger-6e932b1ce554@spud>
In-Reply-To: <20231130-decibel-passenger-6e932b1ce554@spud>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 30 Nov 2023 16:51:32 +0530
Message-ID: <CAK9=C2Vsx8ddpYiqUhvqnJpdb-FKeNhLz3PsVpSeEz4TeQHiEg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: timer: thead,c900-aclint-mtimer:
 separate mtime and mtimecmp regs
To:     Conor Dooley <conor@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen Wang <unicorn_wang@outlook.com>,
        Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 3:27=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Nov 30, 2023 at 03:01:24PM +0530, Anup Patel wrote:
> > On Sat, Nov 18, 2023 at 12:39=E2=80=AFPM Inochi Amaoto <inochiama@outlo=
ok.com> wrote:
> > >
> > > The timer registers of aclint don't follow the clint layout and can
> > > be mapped on any different offset. As sg2042 uses separated timer
> > > and mswi for its clint, it should follow the aclint spec and have
> > > separated registers.
> > >
> > > The previous patch introduced a new type of T-HEAD aclint timer which
> > > has clint timer layout. Although it has the clint timer layout, it
> > > should follow the aclint spec and uses the separated mtime and mtimec=
mp
> > > regs. So a ABI change is needed to make the timer fit the aclint spec=
.
> > >
> > > To make T-HEAD aclint timer more closer to the aclint spec, use
> > > regs-names to represent the mtimecmp register, which can avoid hack
> > > for unsupport mtime register of T-HEAD aclint timer.
> > >
> > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT tim=
er")
> > > Link: https://lists.infradead.org/pipermail/opensbi/2023-October/0056=
93.html
> > > Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.ad=
oc
> >
> > The ratified Priv v1.12 specification defines platform specific M-mode =
timer
> > registers without defining any layout of mtime and mtimecmp registers.
> > (Refer, "3.2.1 Machine Timer Registers (mtime and mtimecmp)")
> >
> > The "thead,c900-aclint-mtimer" can be thought of as is one possible
> > implementation of "riscv,mtimer" defined by the Priv v1.12 specificaito=
n.
> >
> > If it is not too late then I suggest making this binding into generic
> > "riscv,mtimer" binding.
>
> We could definitely reorganise things, it's not too late for that as
> implementation specific compatibles would be needed regardless, so
> software that would've matched on those will continue to do so.
>
> That said, does this platform actually implement the 1.12 priv spec if
> there is no mtime register? The section you reference says:
> "Platforms provide a real-time counter, exposed as a memory-mapped
> machine-mode read-write register, mtime." It seems to me like this
> hardware is not suitable for a generic "riscv,mtimer" fallback.

Yes, the T-Head mtimer does not implement both mtime and mtimecmp
so technically it only implements a portion of the ratified RISC-V mtimer
chapter.

>
> Am I missing something there Anup?
>
> It doesn't even implement the draft aclint spec, given that that says:
> "The MTIMER device provides machine-level timer functionality for a set
> of HARTs on a RISC-V platform. It has a single fixed-frequency monotonic
> time counter (MTIME) register and a time compare register (MTIMECMP) for
> each HART connected to the MTIMER device."
>
> But I already said no to having a generic, "riscv" prefixed, compatible
> for that, given it is in draft form.

I am not suggesting T-Head timer implements aclint spec. Also,
since aclint spec is in draft state it is out of the question.

My suggestion is to treat "3.2.1 Machine Timer Registers (mtime
and mtimecmp)" as RISC-V mtimer defined by the RISC-V privileged
specification and define "riscv" prefixed DT binding for this.

This binding defines two possible values for "reg" property:
1) contains two items: a) mtime register address and,
     b) base address of mtimecmp registers
2) contain one item: a) base address of mtimecmp registers

The t-head mtimer seems to implement #2 whereas the RISC-V
mtimer (Priv spec) aligns with #1.

If we want to keep this DT binding t-head specific then
we should remove option #1 (above) from this DT binding
and add separate "riscv" prefixed DT binding for RISC-V mtimer.

Regards,
Anup

>
> Cheers,
> Conor.
>
> > > ---
> > >  .../timer/thead,c900-aclint-mtimer.yaml       | 42 +++++++++++++++++=
+-
> > >  1 file changed, 41 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/timer/thead,c900-aclin=
t-mtimer.yaml b/Documentation/devicetree/bindings/timer/thead,c900-aclint-m=
timer.yaml
> > > index fbd235650e52..053488fb1286 100644
> > > --- a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtime=
r.yaml
> > > +++ b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtime=
r.yaml
> > > @@ -17,7 +17,20 @@ properties:
> > >        - const: thead,c900-aclint-mtimer
> > >
> > >    reg:
> > > -    maxItems: 1
> > > +    oneOf:
> > > +      - items:
> > > +          - description: MTIME Registers
> > > +          - description: MTIMECMP Registers
> > > +      - items:
> > > +          - description: MTIMECMP Registers
> > > +
> > > +  reg-names:
> > > +    oneOf:
> > > +      - items:
> > > +          - const: mtime
> > > +          - const: mtimecmp
> > > +      - items:
> > > +          - const: mtimecmp
> > >
> > >    interrupts-extended:
> > >      minItems: 1
> > > @@ -28,8 +41,34 @@ additionalProperties: false
> > >  required:
> > >    - compatible
> > >    - reg
> > > +  - reg-names
> > >    - interrupts-extended
> > >
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: thead,c900-aclint-mtimer
> > > +    then:
> > > +      properties:
> > > +        reg:
> > > +          items:
> > > +            - description: MTIMECMP Registers
> > > +        reg-names:
> > > +          items:
> > > +            - const: mtimecmp
> > > +    else:
> > > +      properties:
> > > +        reg:
> > > +          items:
> > > +            - description: MTIME Registers
> > > +            - description: MTIMECMP Registers
> > > +        reg-names:
> > > +          items:
> > > +            - const: mtime
> > > +            - const: mtimecmp
> > > +
> > >  examples:
> > >    - |
> > >      timer@ac000000 {
> > > @@ -39,5 +78,6 @@ examples:
> > >                              <&cpu3intc 7>,
> > >                              <&cpu4intc 7>;
> > >        reg =3D <0xac000000 0x00010000>;
> > > +      reg-names =3D "mtimecmp";
> > >      };
> > >  ...
> > > --
> > > 2.42.1
> > >
> > >
