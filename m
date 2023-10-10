Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFCE7BFAE0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjJJMLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjJJMLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:11:44 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33E9A9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:11:41 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d81f079fe73so6450204276.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696939901; x=1697544701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+q8X53t6/nAULKwb/iQeHBUqOXFycHH5TaG/WC1vrU=;
        b=KGKmxhgMP4P3IQJ/iGhtpYpiJ6q3uSNdweJXBRuZwa4UKU/nOrdgNJsi20F1w4WZNF
         l+qpw1x2Kd8wTmFWYu1+06HOCKk7FkoJqWHDn7IUTHhXocB44EZCBO6VJAZRJ0sXSvNX
         bkhWe1RLSXnRLjSy6y4aVXlZrKps30OtwITFamPtgD5Qn5D5gNiCrcbQhrTW73XVUUl/
         OoSk9+Q2fp0YBYruI/BmW/gH7njJmIYgvmDaVBW41O75vCsbClyGwuJ8x2yxZzreXgwG
         2gcmKsBb1IG/8vM7Vpiu+7EJuUNhCNCTFQ1AD/wAe45p6gWo7QzovAPUf/0AixfFPYUM
         Rdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696939901; x=1697544701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+q8X53t6/nAULKwb/iQeHBUqOXFycHH5TaG/WC1vrU=;
        b=edpfLJ2vD6v9nBPE2uGJ7LRE3z6+9PkC5IIqO5O9dUSEMsdN02FmuGOcKP1D65KOCK
         1OjAEoe538Ke/FNGXB/ya9aZtWw3SRNGAF1JR1vDXcpY5PO1p7RTBKv9/27RlWX1FDG2
         Fk4Izt/YR2amos9LNXBmFTeQc8ixl3wPA5trjim9FadHv5NdvtGvkixsjEzMmL6QYnQk
         Bc2dpRJmJ9l4UO1yCBDbBjgOALj3sACc9IDqpznVX6h6Cz1l1o26/1DzFhXXCpj3WO6f
         rhFagwqKsya66vgm+E5lXOpvhUUiryRg6crwwlLoVRnTPa+uiPH80W4IwlGe55uBn6LU
         ZkmQ==
X-Gm-Message-State: AOJu0YyVDcjhkA/xlISkB22mU+TB2S44maN+CFQdAmWgva8FJLyidrwB
        Ruv4nAB+KmZ3tt4j6H0AjH2ADAUxIueTMaDDscTXCg==
X-Google-Smtp-Source: AGHT+IHY62VCVtolYEhTBCIC57nxmItuoQHuHYu3sYeMnpAunQnYQ8ZtY1uLV0kYVpGVCOXn9wxAiQn5CWxRf+sQLyM=
X-Received: by 2002:a25:800a:0:b0:d9a:5c10:d7f7 with SMTP id
 m10-20020a25800a000000b00d9a5c10d7f7mr1507482ybk.60.1696939901112; Tue, 10
 Oct 2023 05:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231006082247.3830719-1-martin@kaiser.cx>
In-Reply-To: <20231006082247.3830719-1-martin@kaiser.cx>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Oct 2023 14:11:30 +0200
Message-ID: <CACRpkdY9md81_GHN8kKJhCE9GbW6k5tRLavaQ4DJtYCf+C11+Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: st,stm32: fix phandle-array warning
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 10:27=E2=80=AFAM Martin Kaiser <martin@kaiser.cx> wr=
ote:


> make CHECK_DTBS=3Dy st/stm32f469-disco.dtb
>
> brings up a warning about a missing argument:
>
> stm32f469-disco.dtb: pinctrl@40020000: st,syscfg:0: [21, 8] is too short
>
> The description of the third entry indicates that this entry is optional.
> The code in stm32_pctrl_dt_setup_irq parses st,syscfg and treats the thir=
d
> entry as optional. It defaults to 0xf if not present in the devicetree.
>
> Update the schema to require at least two entries, use the same syntax as
> the description of renesas,ipmmu-main in
> Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Patch applied!

Yours,
Linus Walleij
