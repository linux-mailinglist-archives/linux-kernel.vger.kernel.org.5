Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9547180A3F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573778AbjLHMye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHMyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:54:32 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC6A199E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 04:54:34 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5cdc0b3526eso15148447b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 04:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702040073; x=1702644873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzKPwdYAwYCdy6h7bjnYf0Ny9x0IXWZf0PctpusOM14=;
        b=GymOwdMpn2bCXzEW+5FR2yU88+572gP+YVWQgaezvu+Ks+LJ7893+N3yfRaKaDxeQT
         P7eDhlUSwa0kE2QdfEYz5CPldn974JBEL2o0WIt+RYrc5KZ69akrBntn0SKZZuSEYzKk
         2dL7s6LghbPXLq2AGxiZYSkLf/jQiIGCPrlZNXiCVJXpe+M7ZihsEp1/+uQ2SxSs+ZgS
         u1SRngX4omMo41+hmDi6Xj+1EHtrkcVtNWRinetAsHOGj1NulpS6nf11GZ28rTeaAMfl
         CDyOxzaceGkKRcimdcPEOlwKsFZuTy6RuXJu4HcKgHio50dkv7t6S90yHDvZYjE/1OX2
         SRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702040073; x=1702644873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzKPwdYAwYCdy6h7bjnYf0Ny9x0IXWZf0PctpusOM14=;
        b=IRDFJ6HRvea9JLm6ivs2Oj/2GI7OD1sLQpr+HYrpGD5bsxt4DI/JRPajW7f885Wi4m
         zVHR2PCY/NB52FVSZtpFBJdN/Rj3Fjd1mAlvzcvN0IhoW4yV4f82SdcVRG2AayCNw1+m
         1nnsIvUcCM5mzmwwrTu23BiF5zpuWGUuX61CzhlbNqRlF9+fGRQc60N75RJKhaIjvZGa
         tAxDbA+AJjaNZzqHe+67podWY+inxoNxuxDIsg5u3rf2YDONASj771tKv/vsVwOlWgGz
         eGPV+lNsernSmIdjfXlrfdxDuWthPFnBkXWyt57ABTVSnBFLso2Yh/GYZq+K4+HunCdU
         Tf8Q==
X-Gm-Message-State: AOJu0Yz2fynJnZnNF6jhgol+aGZa1sQptWPYh3A0kdfiG+JM7jQtMfph
        Olmo+WJ31SeL+50YG/8jQJOm4xNSPPwDm1qkjpvpsg==
X-Google-Smtp-Source: AGHT+IEAJXSroSapCiPDjhsK4NjurOOebjH4gHV0wHEUSh+xkwhLq/8/MRN114XW47mChKgdM8zLbDjUan/sQcQJbJY=
X-Received: by 2002:a0d:cb42:0:b0:5d7:1a33:5ae5 with SMTP id
 n63-20020a0dcb42000000b005d71a335ae5mr376183ywd.50.1702040073661; Fri, 08 Dec
 2023 04:54:33 -0800 (PST)
MIME-Version: 1.0
References: <20231207111300.80581-1-eichest@gmail.com> <20231207111300.80581-2-eichest@gmail.com>
In-Reply-To: <20231207111300.80581-2-eichest@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Dec 2023 13:54:21 +0100
Message-ID: <CACRpkdbSs-vebvchxx-Tg+O5CUF5M3vZf-iytuW=ZECnHb2anA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: input: atmel,maxtouch: add
 poweroff-in-suspend property
To:     Stefan Eichenberger <eichest@gmail.com>
Cc:     nick@shmanahar.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>
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

On Thu, Dec 7, 2023 at 12:13=E2=80=AFPM Stefan Eichenberger <eichest@gmail.=
com> wrote:

> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>
> Add a new property to indicate that the device should be powered off in
> suspend mode.
>
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
(...)
> +  atmel,poweroff-in-suspend:
> +    description: |
> +      When this property is set, all supplies are turned off when the sy=
stem is
> +      going to suspend.
> +    type: boolean
   wakeup-source:
     type: boolean

As Krzysztof says it seems you are describing an operating system feature.

I can't help but wonder: shouldn't that pretty much be the default behaviou=
r
if wakeup-source is *not* specified?

I.e. the property kind of describes !wakeup-source.

Yours,
Linus Walleij
