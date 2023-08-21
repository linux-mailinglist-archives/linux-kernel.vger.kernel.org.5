Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFAB782873
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjHUMBN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 08:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjHUMBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:01:12 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D416DE9;
        Mon, 21 Aug 2023 05:01:08 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59231a1ca9eso4289017b3.1;
        Mon, 21 Aug 2023 05:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692619268; x=1693224068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUUJ2/PRflFLbJIM097SQqKNn2Udb4Em6AFpSfljQKM=;
        b=Xs1I1Bv4hIsYOvhC1G3PNzQydshwLaND1SvecruEHscDwxgEH3bTDAf13f3NLSTC4S
         pUkWpocnIPhbrCA4YMR+/5+etP1AeVy43lelOaC3jR+IaDc+Zu53xK3orS90At5oCJwF
         NTC5Ss3SGpj6llggflZUC4KvpDOSs5Oc0gDkMj1SdXN69Vt5B3mXIvqdWUOFSHiVJ4cB
         NRC1dvyf3BOfIvPKTHMt1GUEbEQf7pAiPTLO0Y9klkkU4UW4PKW+CIStM4GrfeIlntEk
         RiqlNLEXLXZ19Zy9R4DbKDCppXRDitfhUrvXJfMS6gabZiTSVUySUrp1s6NQHk/sD/Vu
         t6hA==
X-Gm-Message-State: AOJu0YwL6lfeafBcUE9wVF6lQiCY/BYEt+BdKn+zb14pNSLt4sIoU0x6
        dweCUOUHaNs7l0CE2bpRu8TE4T+dnt8y8A==
X-Google-Smtp-Source: AGHT+IGmDSzPhFYwMdcIrHFIzxQtJC76YO8IEpS2URkdLJE9bBDTmIfVHkmsg+iK0EDMfwrhU5i7QQ==
X-Received: by 2002:a05:690c:3409:b0:58a:4b31:cbaf with SMTP id fn9-20020a05690c340900b0058a4b31cbafmr5495027ywb.35.1692619267911;
        Mon, 21 Aug 2023 05:01:07 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id b67-20020a0dd946000000b005773b750d95sm2172330ywe.28.2023.08.21.05.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 05:01:07 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d7484cfdc11so1581536276.1;
        Mon, 21 Aug 2023 05:01:07 -0700 (PDT)
X-Received: by 2002:a25:ca54:0:b0:d13:e334:241b with SMTP id
 a81-20020a25ca54000000b00d13e334241bmr6529985ybg.21.1692619267052; Mon, 21
 Aug 2023 05:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230819010928.916438-1-robh@kernel.org> <CACRpkda94qc1Mc_yz+c2rYFdyhXsX-XRFTntv1fiw=HrpDqAOg@mail.gmail.com>
In-Reply-To: <CACRpkda94qc1Mc_yz+c2rYFdyhXsX-XRFTntv1fiw=HrpDqAOg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Aug 2023 14:00:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVUJ0U0ftjr+s=2p8gYwwEtxaKe7vGpm7CxCiGPq92y4g@mail.gmail.com>
Message-ID: <CAMuHMdVUJ0U0ftjr+s=2p8gYwwEtxaKe7vGpm7CxCiGPq92y4g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: renesas,rza2: Use
 'additionalProperties' for child nodes
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Aug 21, 2023 at 12:34 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Aug 19, 2023 at 3:09 AM Rob Herring <robh@kernel.org> wrote:
> > A schema under 'additionalProperties' works better for matching any
> > property/node other than the ones explicitly listed. Convert the schema
> > to use that rather than the wildcard and if/then schema.
> >
> > Drop 'phandle' properties which never need to be explicitly listed while
> > we're here.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> Looks good to me, but Geert usually handles Renesas stuff so not
> applying unless I get asked explicitly to do so.

Unless some new bugs show up (hold wood etc.), I do not plan to
send more pin control PRs for v6.5 or v6.6, so please take it.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
