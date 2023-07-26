Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D056C7632FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjGZJ7G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 05:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjGZJ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:58:43 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEDB131;
        Wed, 26 Jul 2023 02:58:21 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-cb19b1b9a36so7199508276.0;
        Wed, 26 Jul 2023 02:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690365500; x=1690970300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ecr5DuKM0I5ynjeHKow0SnRxwSONxQfyEz+Sj1iub0A=;
        b=PqDxwBJNweXmRb4wbpOHO3TnVTUOZ99Y4BaBhXvYy4X98+oaSyOWGjhrCGRtHXvyZZ
         pNLbkaC7rOox32wGsYjnI9ItSKah35lmZsdf0tdGdgRrCRJnxiNxsAlaULmAfqwywJiO
         Q81sv2PiUglecDZYe1E2JRLn9hqqjy9k9j6edXT0jCOhr5B0p3m7DV5nIUFUW1oy1vU4
         rx1g/Vrxo9t2CLKrUzYsKylHRqS9rUsu3Crh5jsHdx2RcwMb49G50SQaCXeXJBFYRv+2
         IM6uAZyoPS249QJg07bDx/XQemwp1ITeeIWFhOemQYWBe8aPIws9l8pcXQzWKIZGt61q
         rNxA==
X-Gm-Message-State: ABy/qLYrrS3wIdeHkU0eIwxjL8bmZ2woNMpD73HP068NYb0nhgzabuIh
        9WHZnE0IGP0YIxSV/IGdj+4MZhfXPTdn6Q==
X-Google-Smtp-Source: APBJJlEM6pbl/4YHVw/RESPmzGwX5JRSJZSeWMonyew2g1ozpz9DfQSjGAHYdld4UxbWMGJ4wQj+cg==
X-Received: by 2002:a81:49cf:0:b0:583:9c78:9a84 with SMTP id w198-20020a8149cf000000b005839c789a84mr1479590ywa.43.1690365499905;
        Wed, 26 Jul 2023 02:58:19 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id d205-20020a8168d6000000b00577269ba9e9sm4089394ywc.86.2023.07.26.02.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:58:19 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-cf284f4d7afso7185648276.3;
        Wed, 26 Jul 2023 02:58:19 -0700 (PDT)
X-Received: by 2002:a05:6902:154d:b0:c4b:ada8:8b86 with SMTP id
 r13-20020a056902154d00b00c4bada88b86mr1571135ybu.64.1690365499428; Wed, 26
 Jul 2023 02:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230726070241.103545-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdWfwTyJoLyGs=8gPt4jT-3nc0ywA_NNGr6r+4+cD=Lygg@mail.gmail.com> <cb272650-e829-7528-de6d-f99fef2d7f81@linaro.org>
In-Reply-To: <cb272650-e829-7528-de6d-f99fef2d7f81@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jul 2023 11:58:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV1=DCU-uqhvmtFeJX6v23VHo3-N5drWbr=R_A32GZrsA@mail.gmail.com>
Message-ID: <CAMuHMdV1=DCU-uqhvmtFeJX6v23VHo3-N5drWbr=R_A32GZrsA@mail.gmail.com>
Subject: Re: [PATCH] AMR: dts: renesas: r8a7740-armadillo: switch to enable-gpios
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Jul 26, 2023 at 11:47 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 26/07/2023 11:11, Geert Uytterhoeven wrote:
> > On Wed, Jul 26, 2023 at 9:02 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >> The recommended name for enable GPIOs property in regulator-gpio is
> >> "enable-gpios".  This is also required by bindings:
> >>
> >>   r8a7740-armadillo800eva.dtb: regulator-vccq-sdhi0: Unevaluated properties are not allowed ('enable-gpio' was unexpected)
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > i.e. will queue in renesas-devel for v6.6.
>
> I think I made typo in subject prefix:
> AMR -> ARM

I had noticed ;-)

> Can you fix it while applying?

Sure, already done.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
