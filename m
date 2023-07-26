Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFA6763174
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjGZJP4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 05:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjGZJPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:15:33 -0400
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE22A1B8;
        Wed, 26 Jul 2023 02:11:39 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-48651709fa5so117663e0c.1;
        Wed, 26 Jul 2023 02:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690362699; x=1690967499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyiSThx+2pC2hdINtTGFZ6Ddt40MRlVbeYYKFL+/WlI=;
        b=JbvLQVB+0BsbBbBmp+j9s8T6u/i/qZdZwJ9hc4CN1EtVguM/xDKzrn+RJPWkRsbKUo
         OdrdDh7jUumWBHGAPkbpv0vss+ILNOxM1MOgcLZgjOc2WZKSv1LbGJVAG+Y1lM71POgu
         B481291+NOKv+o27Xpy0FLKDymuVr1cvjY01pvd0F5UEadaL36hmra8zaC0945KdWjmN
         Wg1RfuAJdaKAMPZIOsdEWPbN28FYBxIIfPU9gtmlVH5rmKWszjWI0ApaDxiZeeuPS6Ru
         99VSbfmtr9cn4J9PcPJLw3yRXqFFgm7DDKoyGnYesBSpAu9/AiClCJczxfJlUgc7F2Xg
         ITiw==
X-Gm-Message-State: ABy/qLa7TixDOeiao7JyNpDyt3xXkugGk7lBWWWmN71pd21VbfSnUeJK
        Wkaw/MuUM2tcDpis7O6Imc0tbtIOSyWOtg==
X-Google-Smtp-Source: APBJJlGSRsSNKpxb2DtOOooC2wbT3mwIlZgRW0glDMZPTL94ruYKAN0MFeDBN7qiHaDtDxt5trSCQg==
X-Received: by 2002:a1f:ce03:0:b0:486:242e:5b5e with SMTP id e3-20020a1fce03000000b00486242e5b5emr851988vkg.13.1690362698725;
        Wed, 26 Jul 2023 02:11:38 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id z12-20020a056122104c00b00481341b4a9asm2044725vkn.45.2023.07.26.02.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:11:38 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-48159634694so2380306e0c.2;
        Wed, 26 Jul 2023 02:11:38 -0700 (PDT)
X-Received: by 2002:a1f:c10d:0:b0:471:17be:ba8d with SMTP id
 r13-20020a1fc10d000000b0047117beba8dmr1051356vkf.3.1690362698050; Wed, 26 Jul
 2023 02:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230726070241.103545-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230726070241.103545-1-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jul 2023 11:11:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWfwTyJoLyGs=8gPt4jT-3nc0ywA_NNGr6r+4+cD=Lygg@mail.gmail.com>
Message-ID: <CAMuHMdWfwTyJoLyGs=8gPt4jT-3nc0ywA_NNGr6r+4+cD=Lygg@mail.gmail.com>
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

On Wed, Jul 26, 2023 at 9:02 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> The recommended name for enable GPIOs property in regulator-gpio is
> "enable-gpios".  This is also required by bindings:
>
>   r8a7740-armadillo800eva.dtb: regulator-vccq-sdhi0: Unevaluated properties are not allowed ('enable-gpio' was unexpected)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.6.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
