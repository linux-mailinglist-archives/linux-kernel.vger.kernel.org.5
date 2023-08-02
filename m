Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E659476D334
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbjHBQDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjHBQDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:03:14 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D40F1706
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:03:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so15489a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690992191; x=1691596991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za9/LfvVZ7eM6zvkykUhOmAQ0qY1ch8TU/IFytMhX4M=;
        b=6//jNLKGkOcWqPrgJot5RC/qXvaqe+Bd0xVZEPTWE7X8JKF5z4zF/Frg7xtreNN9ok
         zMRW9BZrv0bJEc9T2q+dkNATNf9dM7sGFZNZUo5xbUXniYsRF/4EwdOIIexTObuXCtvA
         xXofoDgJEG79szSKIdh7CSwT3Zs1rOdAMD7x39Z+hSBA+Us91bdedbh1AUxzSWIVmdPQ
         NVr4NTZbB9u3B8dLgXJPDmnvAHY39I2qYjFPtV29CWN0k0fqUHHJ/YPbwyq41onZ38uL
         zX7AqqBiOX6YP3hX+4eMELxBA50Isrjh1bK8Mt7SGxLKLJ36Ege+k3g5N2ZyGGZiCZZo
         J4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690992191; x=1691596991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=za9/LfvVZ7eM6zvkykUhOmAQ0qY1ch8TU/IFytMhX4M=;
        b=aHxEIFkkCLfnVi/AyJKL3vouv7D3eTNFmcrAOs9WiWZu5bcVbLqABpBSOgDBxr/i9M
         UkHreTxAtqclksN2z/pQQGhSzlsGQm4bWPVsy2ENtQbGpRKqrNYVVh3oL8X26s1yCI3x
         3cbtPNY+v9he5x+OU9GKuGlDUZqkhmXkczXHa0xh5cTOQz2ktmt3UCYrUT6CTnhAzSBv
         42iAGFk7EM+lWuwUmajPFw4EvwXhcldoFYm562Mu7ww96cyYdo+sbIpZoW3O87vcw835
         P/K0I+iby6rEo6RwH1t5FVY++qATO0Vqo1BuEtBSBdpR5E+NA22fSdNBrEoUUIUkuslD
         cQcA==
X-Gm-Message-State: ABy/qLbkLrzLNfsBWBBwbVG1MtoZmT6NcvH7jWy9MedH+LWna7KrFxQF
        RdTr/PAiO66zVEvNmlEKLlQbzowLqdTmMNvx1sFV9g==
X-Google-Smtp-Source: APBJJlEfELW2rqnvq5LQ+CzLJhRPevBhtyiwazy4H1ItIqPof+Qg2AP5Q8OZZTjTlmA9QIC9MJp1ykjwxmklB5tl9Lw=
X-Received: by 2002:a50:c31c:0:b0:522:3ead:377 with SMTP id
 a28-20020a50c31c000000b005223ead0377mr280782edb.7.1690992190613; Wed, 02 Aug
 2023 09:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230802071947.1683318-1-yangcong5@huaqin.corp-partner.google.com>
 <20230802071947.1683318-2-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20230802071947.1683318-2-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Wed, 2 Aug 2023 09:02:58 -0700
Message-ID: <CAD=FV=UPVaPZ-SqTfLGdLfXRagv_F7D67GZwWxSqtD=6POOZFQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: input: i2c-hid: Introduce Ilitek ili9882t
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, hsinyi@google.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 2, 2023 at 12:20=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The ili9882t touch screen chip same as Elan eKTH6915 controller
> has a reset gpio. The difference is that ili9882t needs to use
> vccio-supply instead of vcc33-supply. Doug's series[1] allows panels
> and touchscreens to power on/off together, let's add a phandle for this.
>
> [1]: https://lore.kernel.org/r/20230607215224.2067679-1-dianders@chromium=
.org
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../bindings/input/ilitek,ili9882t.yaml       | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
