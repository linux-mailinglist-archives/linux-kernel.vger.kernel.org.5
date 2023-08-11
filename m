Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F9D77933D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjHKPeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbjHKPeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:34:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425D73A89;
        Fri, 11 Aug 2023 08:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D13156758C;
        Fri, 11 Aug 2023 15:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44638C433BC;
        Fri, 11 Aug 2023 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691768045;
        bh=4MzACdlIZlT4kiPh32h+2tEBbj8sHiOYBV0xuY5gCnA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mpfa5cR3b+qbCipAmz4ccGTs8IP5FeChN+a1Nj4juIiWEW/BPKTTOuBtoTxSBQCoq
         3MM3tUqdZOHesQXsmFxnepxoEBL/joOxTkJI/+nSu9vXMfAL9X0ixhuh8ZBkddf3Xh
         gxJx9SflcBDNAMZtz8EYMHmK3/IXLs2KOAnFn9L7bCxv0LI9cqEDbf95C4OdZr+rd+
         lOc0/GnBug1uMVskR5UOKKDgshRzCJosGoLlw4/nfQmGs04rnrYkPTlcKtvwy0+X8i
         GPcIEXttLhFGrRHgplcoulyInwRbSUtZ7MtJq5H6pXgfGTyJtkftnKTY7sQIn01HGi
         HKe8T9+vWm/gA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so32475731fa.1;
        Fri, 11 Aug 2023 08:34:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YzjnXuLR3E22/Gy+zNyET3455WLcmTJ36u2Uk+STqP1Ia1Xa/OB
        C8ib7njd+UemKAFtkG/HdIH6RtBoGJi7cKZ9sQ==
X-Google-Smtp-Source: AGHT+IFZ3aVB1SpfouKUheoAhPAD7BYG9/XysJRzy/GBST8Zv2ieS8bxN0limvWccpCh2IOb7uIAdnGlwJrc/UBdW1Q=
X-Received: by 2002:a2e:7809:0:b0:2b6:e625:ba55 with SMTP id
 t9-20020a2e7809000000b002b6e625ba55mr2028099ljc.41.1691768043319; Fri, 11 Aug
 2023 08:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230629073419.207886-1-tanure@linux.com> <20230629073419.207886-4-tanure@linux.com>
In-Reply-To: <20230629073419.207886-4-tanure@linux.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 11 Aug 2023 09:33:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKd_XYB682eHoW+omjGWLpuz0QL6zc0VB7u-Lm+X=PmOw@mail.gmail.com>
Message-ID: <CAL_JsqKd_XYB682eHoW+omjGWLpuz0QL6zc0VB7u-Lm+X=PmOw@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] tty: serial: meson: Add a earlycon for the T7 SoC
To:     Lucas Tanure <tanure@linux.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>,
        Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 1:34=E2=80=AFAM Lucas Tanure <tanure@linux.com> wro=
te:
>
> The new Amlogic T7 SoC does not have a always-on uart,
> so add OF_EARLYCON_DECLARE for it.
>
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/tty/serial/meson_uart.c | 2 ++
>  1 file changed, 2 insertions(+)

These 2 serial patches will probably never be applied if you don't
send this to Greg and linux-serial. IOW, use get_maintainers.pl for
your patches.

Rob
