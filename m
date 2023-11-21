Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8787F31C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbjKUO6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjKUO6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:58:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E259A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:58:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F244DC433CC;
        Tue, 21 Nov 2023 14:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700578706;
        bh=+gJV5Kq/zk7daeG5FUsmI0jNOy/xuAwkVf/f+7MLU5I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=krU/8KO4ATWr4zxxJrfvksylFL5Le76um3CUG0EvTiIm3ljSQHX9LDTM68Loi9rXe
         Lc15EnK4Facj2erJIGoZHXmQOo/scEBf1NhxP2fBu3qAEk2sG2+zM39WUPIuZ03zsh
         zduzA0o5RhvuAy/Vsc2DuolS70GnfTGdhoAYPnp3+xqeW8hIqdS3LXCEDtxt5IUHoE
         NGAotlvjGIwRIBNZcleOeWep/c7BL6XVPgUVb1To3eBO2RI0iT/m5uP8xgtQia//Kn
         YUthVWnYrPL85KPpksW6K62+I2u9g1PZrxJzAbVvN9awyjyzSTEL3+SaOGWp4T3e9G
         x1sLIt2r9On5w==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-507962561adso8243693e87.0;
        Tue, 21 Nov 2023 06:58:25 -0800 (PST)
X-Gm-Message-State: AOJu0Yz2AEoTPa91cTrntai2w7JVisMm3MrjRS8ort9V156hayecbqG4
        cHGvtlyIKCiven82m1ULoiermthZ3CIrfBO/uA==
X-Google-Smtp-Source: AGHT+IHBiGSizQyBkO4Q43LdN/hKHZvdOgdP/et2Xjgl2vIRMj51OZsWwcNiAsGaNW7Y23qV5f4kXncXYdheozxBgQo=
X-Received: by 2002:a19:f010:0:b0:505:8075:7c10 with SMTP id
 p16-20020a19f010000000b0050580757c10mr7788659lfc.25.1700578704209; Tue, 21
 Nov 2023 06:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20231116211739.3228239-1-robh@kernel.org> <ee10e67b-6a2f-4ab5-91ef-e42d2f03a424@linaro.org>
In-Reply-To: <ee10e67b-6a2f-4ab5-91ef-e42d2f03a424@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 21 Nov 2023 07:58:12 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJ67tZOmhTHQ7KqEbFuDjK8sKHR1FFtAFAaGjZ4uYi9Uw@mail.gmail.com>
Message-ID: <CAL_JsqJ67tZOmhTHQ7KqEbFuDjK8sKHR1FFtAFAaGjZ4uYi9Uw@mail.gmail.com>
Subject: Re: [PATCH] arm/arm64: samsung: Enable W=1 on dtbs by default
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 3:19=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/11/2023 22:17, Rob Herring wrote:
> > Samsung platforms are clean of W=3D1 dtc warnings, so enable the warnin=
gs
> > by default. This way submitters don't have to remember to run a W=3D1
> > build of the .dts files and the grumpiness of the maintainers can be
> > reduced.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Well, there's a couple of warnings on 32-bit, but they look fixable to
> > me.
> >
> > There's a few other platforms we could do this to. Sadly, they are stil=
l
> > the minority. Otherwise, we could change the default and add a flag to
> > disable (I_STILL_HAVENT_FIXED_MY_PLATFORMS=3D1).
>
> 64-bit has still few warnings:
> https://krzk.eu/#/builders/29/builds/3710/steps/26/logs/warnings__6_

I may move that graph check to W=3D2. There's some cases where port@1 is
optional and it doesn't really make sense to fix these.

Also, Conor wants to do this for all of riscv, but this solution is
per directory. So I need to rework it to use a different variable that
can be per directory or global.

Rob
