Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5286B7C545F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346767AbjJKMyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjJKMyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:54:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C4892;
        Wed, 11 Oct 2023 05:54:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2792d70ae25so4602928a91.0;
        Wed, 11 Oct 2023 05:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697028847; x=1697633647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugSH8FJbysw/333UJfT2fX6aDJrXjkX7MBOTQ6zLQaY=;
        b=b1Z0nuFnUakxVeSaHlcTOsMoEysbLsq2/IhbUql1diY530QI3J0Ta0ASll3AGmwphR
         1FZSriAftxPE+z4ChLQoMeGkdVm+2NEmYLMiSienDffn5t7AOaJU8yv7DxAOMWKWROjK
         sinZet94juIkl+U7IuPUWwA9O7IfMrXdWd4F7PYCw6JszW44NTRvMvcprMupIOdtPBI/
         pNDKKhGHqPXscVJWvINILuh3DB5k72VBnAOVdjN3IURl+YczPOA9oeJ1mpZCG9RiiWkM
         haj/NQNcG6guijirxhl7YHeoqUzTzffD9ir8UaWHXobFBWPjsVoCecW0DKC2Isl1Ia3p
         Ydow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697028847; x=1697633647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugSH8FJbysw/333UJfT2fX6aDJrXjkX7MBOTQ6zLQaY=;
        b=geRkanNfc5UCpchVO7msiSs0Y9Acfw9gkGbixn175fv2DEBhWg0bJoTw/EFyZpyFLt
         w/vnxA2ysJ/BgHOZVYLU1hZf4oJyElmrmr83U+qHQReg2Qkga5mTCuxK/XKVioSNEFrO
         hrcJX9Y8dVBTAzGuBDV1RbBN1/WL+ykJdw5pfd2KO/qyeLwkFXHD7JRdo5lCOGfuhV4H
         hmOVdRGJZwOl4Tmc7l8qyR3TzS7H66Gv+kBeb4k3C65ofKBttu2mMkwOT/QPs5hI4+qv
         hgnT/QrP4joi+VCoDjCiqElDwGuOAQ8+y/mB2w49oti84TKZEkZ8tyAvNLFO75hlv5Es
         T+9Q==
X-Gm-Message-State: AOJu0YzFFJnTBbfwp2+MGqXC8ZTXWWnnfR093gOOO+HDpHjk08kHf028
        X1Ojh73jHI+xf4ptijerwXbSVQ7vHrRPmZcQ1oOW3zZd
X-Google-Smtp-Source: AGHT+IG45+LupoZQup5ypJxF1tNZKgvqKmwjD6o0mHk2cQIch/yzH1JX9vLwdK72USEMloPr/bS46oBgevyVfPaSOx4=
X-Received: by 2002:a17:90a:a393:b0:278:fa86:13d8 with SMTP id
 x19-20020a17090aa39300b00278fa8613d8mr17431628pjp.41.1697028846773; Wed, 11
 Oct 2023 05:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230906095143.99806-1-aford173@gmail.com> <8cf5b8d1-5f03-438a-94bb-5691dee8cc86@lunn.ch>
In-Reply-To: <8cf5b8d1-5f03-438a-94bb-5691dee8cc86@lunn.ch>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 11 Oct 2023 07:53:55 -0500
Message-ID: <CAHCN7xJ_2HjQ8iCYimPG+CiMQuDy7YpG2sf6Vq30VsddaSs8CQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: ethernet: davinci_emac: Use MAC Address from
 Device Tree
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-omap@vger.kernel.org, aford@beaconembedded.com,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 7:39=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Sep 06, 2023 at 04:51:42AM -0500, Adam Ford wrote:
> > Currently there is a device tree entry called "local-mac-address"
> > which can be filled by the bootloader or manually set.This is
> > useful when the user does not want to use the MAC address
> > programmed into the SoC.
> >
> > Currently, the davinci_emac reads the MAC from the DT, copies
> > it from pdata->mac_addr to priv->mac_addr, then blindly overwrites
> > it by reading from registers in the SoC, and falls back to a
> > random MAC if it's still not valid.  This completely ignores any
> > MAC address in the device tree.
> >
> > In order to use the local-mac-address, check to see if the contents
> > of priv->mac_addr are valid before falling back to reading from the
> > SoC when the MAC address is not valid.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> There is the potential for regressions here, since behaviour is being
> changed. But i do think what you are doing make sense.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

I don't know who the right person is to ask, but is there any chance
this can be accepted?

adam
>
>     Andrew
