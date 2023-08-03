Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC1D76E545
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjHCKKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbjHCKK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:10:26 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE1B3A9C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:10:16 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso815879276.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691057415; x=1691662215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzoheOVoApFkBi8efvoleCyPSfM9DvWM5QQV+Ya+c3I=;
        b=uqAsa9qDXw9qEv1T9dA5E6t5cevfehHlK/j+OVaR/fQPBavYZgYH8GRpUwtl+IJnM3
         9k37vNclaKnGxBMP9LVKs7zXpgYt9R3T7xh9Wps4L1+fc12mKQK3RyqVzGR4O1A0qQs5
         8BTWBtMwN6MTM/OtMlG0sL6avTOsJ7zryxcAbi3iXUZ0NBbuR3OYIKXml7HVpHLoZcmC
         HCfUapa9cYmdSQl5MjqHctANsbAImsdL+p1o2hXxWfPO62N71EW2d4HMeeeV4yVXXEL3
         OMLaQq+Vjg4KGfxror/+ek90/LAPrHR1Hzy3dgT6iMifiETIl1r8LArQ/1851vhySez4
         OhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057415; x=1691662215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzoheOVoApFkBi8efvoleCyPSfM9DvWM5QQV+Ya+c3I=;
        b=k7RS/PUshSpvkKtkWtmY0X8g/d11WW/9dzNLzgEHJ98vmXJucnipaLSlEnw+b4nLNu
         ZFdYJJggfLQokKVgotUCzcLm5NTzhz6FggU2Jejg6S5n+toqoNVurTKTKcfhfey3KYrA
         6u+4iku9lfa0ycFVNBW+7ATR9okg6WhHJCkpZdIh8j5QAQ/xyN1U1tiYmhBROTAFbMAb
         n6metYQ4gjUFFhSl5LGwf7K9KwDHKQIKLiROX58TYvq7PPlLoZZWmpJAIH1fShkkG4TK
         xg7opdZYrqlR17l9Aqi/WZALaxhnAB4ApadWppD/PA/EsvGYUy3PdiEHuWLkNz5cG1tq
         huqw==
X-Gm-Message-State: ABy/qLZ9YXZVg+uEbpYAiJiXvNYxTRhZqFZLldlOmIzPLwKwzWjFFC05
        BE4mjW+snV7jd7Tbl3BGUC71azYKLubiUfXEXx45zA==
X-Google-Smtp-Source: APBJJlH8TvCLA9MeYzPpd5lR5Zz1cFeWcg5lH76fCl8w50BQenvYH3w0bkj5eDVTfFJLhTethWD9GWQBYiUBQlb1vn4=
X-Received: by 2002:a25:25c3:0:b0:d29:fd19:cfac with SMTP id
 l186-20020a2525c3000000b00d29fd19cfacmr18171500ybl.50.1691057415210; Thu, 03
 Aug 2023 03:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230803071454.5902-1-arinc.unal@arinc9.com>
In-Reply-To: <20230803071454.5902-1-arinc.unal@arinc9.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Aug 2023 12:10:04 +0200
Message-ID: <CACRpkdbOqLikZb627F4EFoFSs9NrzaJJqXpKem4dhUwb+oPCOw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: bcm: add bindings for ASUS RT-AC3100
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 9:15=E2=80=AFAM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.una=
l@arinc9.com> wrote:

> Add ASUS RT-AC3100 under BCM47094 based boards.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
