Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817CF77773B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbjHJLgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjHJLgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:36:53 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD0026AB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:36:44 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EA95A3F13B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691667402;
        bh=GbiiR39UCc4MIS05Cs+xA5vgxUMTWHglh2uulV8ScwE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=BhvgsXgAyzYvVxzv7gd0yZjCNhan8vwbdlD1fucysarL0vdT8rkLLd1bF7ZqEM240
         4GPdE3wrIIoDf7wljx2ENrZmL5b1phu4/vbuZvBBRXCgzRusa9VVTKhE9HPLGQC459
         pHRfvbe5CUPmwGJP2j0NjzDOykUCLZdovOvnFCQBYu9x7ziRrBo3kbfRaLOrEw0P3Z
         8mpsBqxKipwswUQTGy+PDVXJMuTRRvWnKUz025VU4n2jAkhU0tTUnVEoqygZ0bOeoN
         vOP1x0Tp6tUsEzw0c/NY1ynv92hmR1W0PqVYnznYNsQh+fZ778n2h9vKay1V+zY1zb
         u7B/1dHlOoNBA==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40b52fc51b5so9973731cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691667402; x=1692272202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbiiR39UCc4MIS05Cs+xA5vgxUMTWHglh2uulV8ScwE=;
        b=hPk8wNTKFHK+tUqWvidJeDvCjQs6V6Qkf2JnmXIgPGcbB0NiJUv2p7a1eItCJXCQX3
         jCDedGY/23NBalVTEctk8p/rf3jO80FrpL2oTPgH4rAsEBpjLEwfb6hTfBy47HnKh57k
         QQGSfxn2v1B1Tw9e3QrUlV2jmTBRNbwnosUpL5hIeHwc5SaXQqexJiMsjEhfpuS/Bu/5
         rJsu1QFgXNzyfGVp+rtq4q38Iie3nB0ugd27dGPoWoBR/Cj1ZWSFkUkeoIDEuU6b3d9X
         aXPF/cB+GYnbYm4dL1VLMtFeU3htMM3CjcGUPgk1eIkAET1N1GvKpjN/Rtxddx/m7WFE
         Du2Q==
X-Gm-Message-State: AOJu0Yw2v5jYMGR+1WVl6nxEEb8oM3uvUqa/tbY8SF0YzwNfeBI94JZS
        wZ3TqBc0wjpzC5FNu6qMVJmAmsJ82wOHOtvV4jSCA6qmVLh3+uDWk9Rpznw8KtdlP904E0Q6qYZ
        ZktDpsrznh2UR7dZ+SUN/rx2KZtkf8b7eJaQehwAbPDEcyCMHMJH0Ru59cg==
X-Received: by 2002:a05:622a:1006:b0:407:efdc:7e00 with SMTP id d6-20020a05622a100600b00407efdc7e00mr3070339qte.13.1691667402145;
        Thu, 10 Aug 2023 04:36:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf9XiASD6iBgaWOFSh+9FqFKpaKS6+j0drjrGbYeTYSluv6VVQ44qjsbNdILTBsQv9DZuoA/egUsHGzxgkSp4=
X-Received: by 2002:a05:622a:1006:b0:407:efdc:7e00 with SMTP id
 d6-20020a05622a100600b00407efdc7e00mr3070320qte.13.1691667401891; Thu, 10 Aug
 2023 04:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230718034937.92999-1-hal.feng@starfivetech.com> <20230718034937.92999-4-hal.feng@starfivetech.com>
In-Reply-To: <20230718034937.92999-4-hal.feng@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 10 Aug 2023 13:36:26 +0200
Message-ID: <CAJM55Z_EdSRxriT=NkrCzvUi0phnPzTs=dMHRgOSHULOMWuvnA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] MAINTAINERS: Add Hal as a maintainer of SFCTEMP
 HWMON DRIVER
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 at 05:49, Hal Feng <hal.feng@starfivetech.com> wrote:
> As he is the submitter of this driver, add his mail so he can
> maintain the driver and easily reply in the mailing list.
>

Acked-by: Emil Renner Berthing <kernel@esmil.dk>

> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aee340630eca..5056079ade77 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19256,6 +19256,7 @@ F:      drivers/net/ethernet/sfc/
>
>  SFCTEMP HWMON DRIVER
>  M:     Emil Renner Berthing <kernel@esmil.dk>
> +M:     Hal Feng <hal.feng@starfivetech.com>
>  L:     linux-hwmon@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
> --
> 2.38.1
>
