Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE7676E550
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjHCKNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjHCKNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:13:35 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8290830FF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:13:30 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d13e0bfbbcfso1206629276.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691057609; x=1691662409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyimAFlYaiJjtTA8U5ah+3F3rF+u3NSjXHAB9IaNAQg=;
        b=YeEOB2uGRQ+Gkk54R5WS3lnPacjtAW/6uZXLhUFFfP7/os9j5RNhldw4kpe0drnbnI
         QmkaayEPexuPK5861Nx/Qb79RxdU3y6CREoDlK4kY6Xi4MMRh313vs3QsLGerLNNXVdX
         9+xgFj1ou1eoAOOyfVoSgkXwv1YwzY8nYMxe/sMeSN5dFg84W5Xg0HZWOMjOEK9RVL7k
         JD2IkYIWki5TlFjaArW4TYQGNJzX3hPXQnCoBfiaYMt870CKWXdC9hmTHWaG1V/WWD9P
         t56H+ZcTzDXeIGa0BXzwVLUAd/pGKOPLL2m5RSa//R5oDuvp22sUruUrhaFm54qIoDLW
         8EjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057609; x=1691662409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyimAFlYaiJjtTA8U5ah+3F3rF+u3NSjXHAB9IaNAQg=;
        b=AXJPpD1HC1e7VVh0dkfuAQsczRQ3LjJCFo0H6yzDMVpZuaS7c0TVUjYn9STPtxoA+r
         oITmRO4nk7hUAJd0Z17MFpX6r4DJ03hIXfjpjZuc0HVnye9lsEPdRDMaoJSzhQqqEI8w
         LG1dkWedsnDNjwL/WUrTyzYyL4vq73BNmuugBwtqF4YZaNrhIZidPtFbnT4bcN4bE5qs
         r90YCJng1uArbt5hKJOPzVQUotgclaEnPZc7KjWe7G3yhdZka7/Ehf3IRiVKUAixQDZG
         Y7/kdFUmvuRFvRp+Y6vIMz8DjfUnMBA1gVauRMqlOM+3Z+9GEchPvb8zfII7U+facOya
         AEug==
X-Gm-Message-State: ABy/qLYJyY6o7iqgSiMxivkQZyEeozNTizJCtwY3R31xsN9frqK4xJH0
        b9OgjIlArLBtGAzGh/km4eAlza9Fu4Q4olJa+AyynA==
X-Google-Smtp-Source: APBJJlHZkf4lDbHH5eHSI0cfG7Niqv2dCi3GQGtKY5iNJBt9cROKVZIZTa98+190YEEaJ91moWGaL5pS17U+3haBWkY=
X-Received: by 2002:a25:fc1e:0:b0:d2b:1545:22fa with SMTP id
 v30-20020a25fc1e000000b00d2b154522famr17699735ybd.3.1691057609726; Thu, 03
 Aug 2023 03:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230803071454.5902-1-arinc.unal@arinc9.com> <20230803071454.5902-2-arinc.unal@arinc9.com>
In-Reply-To: <20230803071454.5902-2-arinc.unal@arinc9.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Aug 2023 12:13:18 +0200
Message-ID: <CACRpkdbnenrtWCgYrxc+-mUpG6DNh=3fN3rXXA7aYVp=A9FriA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: BCM5301X: Add DT for ASUS RT-AC3100
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Wei Xu <xuwei5@hisilicon.com>, erkin.bozoglu@xeront.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 9:15=E2=80=AFAM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.una=
l@arinc9.com> wrote:

> ASUS RT-AC3100 is ASUS RT-AC88U without the external switch. Move the
> shared bindings to bcm47094-asus-rt-ac3100.dtsi.
>
> Remove the fixed-link node on port@7 as commit ba4aebce23b2 ("ARM: dts:
> BCM5301X: Describe switch ports in the main DTS") states it's not
> necessary.
>
> Replace the copyright notice with an author notice.
>
> Rename the model name from Asus to ASUS on bcm47094-asus-rt-ac88u.dts.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>

LGTM!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
