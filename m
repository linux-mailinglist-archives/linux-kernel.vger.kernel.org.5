Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F857854F7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjHWKKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjHWI1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:27:25 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2134E271D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:24:35 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d72cf9156easo4883326276.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692779074; x=1693383874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GniWlVWGgJe/usin4/V+GE0UMfoAT1xMp6M7UZ1H1gg=;
        b=EgQAb8hmKslJNMYukltCiGV4bSaCAIN5pfuUQvHWwS774QTzoM8aanZpDAK0hMFS5O
         Qkuv72IvSnfSgyHS2RhMlRiK8kfK0i5lCuLy9+L2qceO1bABnB06+LpaLRvnoiBTaO/J
         E09KLk5hfTyzVOsUtXDkUzErGlV783OkQN1L8FnCzWe05ZAdqCanXOKn0Sy48MF1jEID
         BGmuKg3zvb8a76p9+/wkKA2NVT2nhWqzYhAbz2LEfJF1Sj/QlWN06Mhf7MLysztBUw/u
         6TjU1AB8p0qmNal0Del8N8r7jdlmA/osRcCVJun0m5rO6OD1jaYQFUB/0brcErZ+XnXq
         XqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692779074; x=1693383874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GniWlVWGgJe/usin4/V+GE0UMfoAT1xMp6M7UZ1H1gg=;
        b=MI9wB1iivVOsNCahUDKeo3bCEv220R8W/eXWmucB2dgCAP9dIH4KvrJRT9l8Jn+oFT
         RU9VmAC6iUuknW1A7mMOy1HsmF8pInWfg9nge3FwTqA2nqSxwh2qUyBC34BLt6F5EFrK
         kHr/+BZUA/32XyTcHqFx5ie3SPEnRsvdxTGjjdsf2fsf+sX88SsxVlt+TTGdTH1/LJlM
         j8mVk1KSzx00nNZdX0Jxc9TEmtursMjlRDSDOpnuewQSTR4waxC3M9rYbJEIs2lEraci
         Vok+UnE2PYZagzwd1/DkooT3l5atza3SD/sgoxbuRGn+iPQ+OO40zoF8jZF45YSt78EW
         Grsg==
X-Gm-Message-State: AOJu0YxTOuWratIPKDTlKfhVQb98JPXpsMTFevvIX9v4Vzn5RcdHVMOt
        X5jRtxoshSg2xDzzOrL1disDKmeHrX585YbXKnHsdw==
X-Google-Smtp-Source: AGHT+IG0ucSlZ5SgGYhp1sPhDWN7q5O1kvR9k/V936eSIUllnP/1qA7Om4HgIbaSVmqUdIsYYVJybDqQB7BY+bKaO28=
X-Received: by 2002:a25:d847:0:b0:d6b:6b53:d1ab with SMTP id
 p68-20020a25d847000000b00d6b6b53d1abmr11472536ybg.38.1692779074564; Wed, 23
 Aug 2023 01:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230819010928.916438-1-robh@kernel.org>
In-Reply-To: <20230819010928.916438-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 23 Aug 2023 10:24:23 +0200
Message-ID: <CACRpkdYA-Yda-bQe_bcZkDFEuz6DvNqYWvWx9X3awiHxNOsLew@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: renesas,rza2: Use
 'additionalProperties' for child nodes
To:     Rob Herring <robh@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 3:09=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:

> A schema under 'additionalProperties' works better for matching any
> property/node other than the ones explicitly listed. Convert the schema
> to use that rather than the wildcard and if/then schema.
>
> Drop 'phandle' properties which never need to be explicitly listed while
> we're here.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch applied to the pinctrl tree.

Yours,
Linus Walleij
