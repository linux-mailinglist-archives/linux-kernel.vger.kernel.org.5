Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA78D7EE8CE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 22:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345538AbjKPVcg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Nov 2023 16:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjKPVce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 16:32:34 -0500
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951DC189;
        Thu, 16 Nov 2023 13:32:31 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5be6d6c04bfso14058387b3.3;
        Thu, 16 Nov 2023 13:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700170350; x=1700775150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2aL2QW+QmknQfAps94TnRW94rO/JgjpGWzTSPmskVY=;
        b=fqMvYZffIJQ4okt/Ai7QlqpdoQpDVIbv3gkeWj245rxYrXCtGHdnbStODiBUx0wgZH
         Pm2aH7Q1xvnFWPnGn1sTC4ztvgKmAKwU/R3lhGDWAWvTBKHU1M0lhqIT3O76L2/FIlOU
         3WewYRTiOqGU04prOY+Iu2QXVf9Hfb13vy4LpE0KU0NyWsIbjlOPTfpnHnIUep4fflum
         YttW/K/AaBWEdqluLgw94zUJX3Bo8BL+FAgEipVNLBKOUXPQ138+TByN7UnydI0JMlDL
         zvorr8Vs9iZT76fNVKKpwVH4PY4rZxheCUSvNN43Fi9oOm+2zN3Bc5m38Pznh7/k0qdr
         aq6A==
X-Gm-Message-State: AOJu0YyqemzQXckybOi8WhLy1hWRj6fOg7TS4yc/eYT5b4H7emY+IXA2
        LY6XoWwHZqKSYyzmp+NrnZGtWkf8VAe8nQ==
X-Google-Smtp-Source: AGHT+IGGOnMjPvyHLK0vusA1NW/wCYC/X8m6jVjkMxUeQFocIMmX3FUwowgt40j3+WRfRSatuIX5nQ==
X-Received: by 2002:a81:4f91:0:b0:5a5:575:b222 with SMTP id d139-20020a814f91000000b005a50575b222mr16478260ywb.23.1700170350637;
        Thu, 16 Nov 2023 13:32:30 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id m141-20020a0dca93000000b0059f5d686479sm112547ywd.16.2023.11.16.13.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 13:32:30 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-daead9cde1eso1304203276.2;
        Thu, 16 Nov 2023 13:32:29 -0800 (PST)
X-Received: by 2002:a25:4643:0:b0:da0:3b6c:fc22 with SMTP id
 t64-20020a254643000000b00da03b6cfc22mr12442981yba.31.1700170349776; Thu, 16
 Nov 2023 13:32:29 -0800 (PST)
MIME-Version: 1.0
References: <20231116181218.18886-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231116181218.18886-1-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Nov 2023 22:32:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVvAN9YcS4XsyinC1+WfAt0YwdNjv_pCpnfBpmGFeXtRg@mail.gmail.com>
Message-ID: <CAMuHMdVvAN9YcS4XsyinC1+WfAt0YwdNjv_pCpnfBpmGFeXtRg@mail.gmail.com>
Subject: Re: [PATCH] docs: dt-bindings: add DTS Coding Style document
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, Nov 16, 2023 at 7:12 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote>
> Document preferred coding style for Devicetree sources (DTS and DTSI),
> to bring consistency among all (sub)architectures and ease in reviews.

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/index.rst
> +++ b/Documentation/devicetree/bindings/index.rst

> +Order of Nodes
> +--------------
> +
> +1. Nodes within any bus, thus using unit addresses for children, shall be
> +   ordered incrementally by unit address.

In Renesas DTS files, we have an (unwritten) additional rule: when there
are multiple nodes of the same type, they do not follow the global
ordering by unit-address, but are grouped together.
E.g. the second and any subsequent serial ports are always listed
immediately after the first serial port.

> +2. Nodes without unit addresses should be ordered alpha-numerically.
> +
> +3. When extending nodes in board DTS via &label, the entries should be ordered
> +   alpha-numerically.


> +Order of Properties in Device Node
> +----------------------------------
> +
> +Following order of properties in device nodes is preferred:
> +
> +1. compatible
> +2. reg
> +3. ranges
> +4. All properties with values
> +5. Boolean properties
> +6. status (if applicable)

There must be a lank line between properties and child nodes?

And once we have a documented coding style, the next long-standing item
from our wishlist would be a script to sort the contents of a DTS file
according to the rules ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
