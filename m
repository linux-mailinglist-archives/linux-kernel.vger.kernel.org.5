Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47D67FEBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjK3Jbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3Jbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:31:31 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFE28F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:31:37 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cde14ff73bso670735b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701336697; x=1701941497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8OBcWs9lPOHMqo4r9Od8zwOOfWlpHAGN+FvmpBlGKI=;
        b=bhoqoJ2GfXNh/2FZPFM51/Bnfdg12IK7mdKxpoSItOTK1I537Ctn9BG4j+D2X76Y4T
         CN6FEtFXyVliMu17iY+dRFVQ7hooXL0NZwIvjUXdY2TSuLYMU75pBfNwvPbufgqSB1Mb
         1YExLfBAlc+qeZHQwVozve7XDlRELYn4obHt7NCAahKlgW/uCxm4ZvFzK473bl7ukyYa
         HEW4vz4HqTq0BfxuAgYaAe9RhmXHvWHHjO/8PHc8abtkNWKBZ84bBGYrKEIckwqqtoYy
         7SN3dE6ud32DQOsLpxyURRYALgzFj3PUPFFCL0Z7ZX3Flo/Mze8S7gugPfM6d5VM4EgQ
         WQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336697; x=1701941497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8OBcWs9lPOHMqo4r9Od8zwOOfWlpHAGN+FvmpBlGKI=;
        b=sjKaaIecOmymLX2gpo9Dettx8V1nb4qnuTs/kgamfDBUqx/zykgVkccAwP1um5aZ0m
         yquH2lQodBlR/kIyXXrnHLBJOkQxb1SzOX2dIdCB7mMQYgTbzMuoVrjNWCCGtimD3Uhd
         XLvaxwFo5mFf8Tw61wJ78m3y935L1Eh4kKlozojLD/YqIWlH2efX0iGq7UhI5Daqhz8M
         P8VIkaD7Jvbg+e9XT0LyLY+7LTPaaxuLwIiwrhkUYhw5LwLERsBzs+I9/jAdl0JwZAIn
         RATvAkUSnpUG+ZNjbdm5wheOBRam+FYMMvsXrIu518bS0b6wNXO/v39uj2VXQ5QHMVRx
         xchw==
X-Gm-Message-State: AOJu0Yz6PLQuKhbNbGdeVRMtPuhJq37UQlkXD2wwR4K79hLXorXFsj0c
        kYDMmUgwurJkZDt79IyGGyemukvr/98PYOS3n4KAEw==
X-Google-Smtp-Source: AGHT+IF3oL/DbPdKnDGhckZzmA5c9sL11ngMJCD23pKkyIij1ndLdvEWXMDzGlwxpmNWJO35Sc6QYX9lQMcvnyPWdfk=
X-Received: by 2002:a05:6a00:2296:b0:6cb:735c:67af with SMTP id
 f22-20020a056a00229600b006cb735c67afmr31018795pfe.0.1701336696772; Thu, 30
 Nov 2023 01:31:36 -0800 (PST)
MIME-Version: 1.0
References: <IA1PR20MB4953C82499C5D81D2C6A020BBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953F9D77FFC76A9D236922DBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB4953F9D77FFC76A9D236922DBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 30 Nov 2023 15:01:24 +0530
Message-ID: <CAK9=C2WAv5jJBt56xBea268DeyUA+YvbU7i+ahVjueafCi-r6A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: timer: thead,c900-aclint-mtimer:
 separate mtime and mtimecmp regs
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
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

On Sat, Nov 18, 2023 at 12:39=E2=80=AFPM Inochi Amaoto <inochiama@outlook.c=
om> wrote:
>
> The timer registers of aclint don't follow the clint layout and can
> be mapped on any different offset. As sg2042 uses separated timer
> and mswi for its clint, it should follow the aclint spec and have
> separated registers.
>
> The previous patch introduced a new type of T-HEAD aclint timer which
> has clint timer layout. Although it has the clint timer layout, it
> should follow the aclint spec and uses the separated mtime and mtimecmp
> regs. So a ABI change is needed to make the timer fit the aclint spec.
>
> To make T-HEAD aclint timer more closer to the aclint spec, use
> regs-names to represent the mtimecmp register, which can avoid hack
> for unsupport mtime register of T-HEAD aclint timer.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT timer")
> Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005693.h=
tml
> Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc

The ratified Priv v1.12 specification defines platform specific M-mode time=
r
registers without defining any layout of mtime and mtimecmp registers.
(Refer, "3.2.1 Machine Timer Registers (mtime and mtimecmp)")

The "thead,c900-aclint-mtimer" can be thought of as is one possible
implementation of "riscv,mtimer" defined by the Priv v1.12 specificaiton.

If it is not too late then I suggest making this binding into generic
"riscv,mtimer" binding.

Regards,
Anup

> ---
>  .../timer/thead,c900-aclint-mtimer.yaml       | 42 ++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mt=
imer.yaml b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtime=
r.yaml
> index fbd235650e52..053488fb1286 100644
> --- a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.ya=
ml
> +++ b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.ya=
ml
> @@ -17,7 +17,20 @@ properties:
>        - const: thead,c900-aclint-mtimer
>
>    reg:
> -    maxItems: 1
> +    oneOf:
> +      - items:
> +          - description: MTIME Registers
> +          - description: MTIMECMP Registers
> +      - items:
> +          - description: MTIMECMP Registers
> +
> +  reg-names:
> +    oneOf:
> +      - items:
> +          - const: mtime
> +          - const: mtimecmp
> +      - items:
> +          - const: mtimecmp
>
>    interrupts-extended:
>      minItems: 1
> @@ -28,8 +41,34 @@ additionalProperties: false
>  required:
>    - compatible
>    - reg
> +  - reg-names
>    - interrupts-extended
>
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: thead,c900-aclint-mtimer
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: MTIMECMP Registers
> +        reg-names:
> +          items:
> +            - const: mtimecmp
> +    else:
> +      properties:
> +        reg:
> +          items:
> +            - description: MTIME Registers
> +            - description: MTIMECMP Registers
> +        reg-names:
> +          items:
> +            - const: mtime
> +            - const: mtimecmp
> +
>  examples:
>    - |
>      timer@ac000000 {
> @@ -39,5 +78,6 @@ examples:
>                              <&cpu3intc 7>,
>                              <&cpu4intc 7>;
>        reg =3D <0xac000000 0x00010000>;
> +      reg-names =3D "mtimecmp";
>      };
>  ...
> --
> 2.42.1
>
>
