Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE2D7A5195
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjIRSGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjIRSGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:06:08 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2046C115;
        Mon, 18 Sep 2023 11:06:01 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5031426b626so2293576e87.3;
        Mon, 18 Sep 2023 11:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695060359; x=1695665159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CKdtwrHX9h1DYPfJUeRRaXbqtpaVmfYt1U1WzQ3+7bs=;
        b=ODf1e4gqLjiMq36pAFhsOGnzyxsbP3c4hiTiPN/u3lmEymr/KVjrYAxAEV9Rcg/YT1
         Y7fZn6MVR2eSqMUJZCCaz7lRvPyJ8ytgvGInLLLsCLtYT06M/G+PYXmYwXQF3iG7Aiz7
         SnyPKnvtqZDEYW+DmwlQqzJesZhHtsz4gZ4nCu5cyTtNt5aLRlF3nTQxaryP4b2l+nOo
         eKdil0vc3JP8wluHMou9MovPZwBm+mHRcN8YjqOGZb8Q45tFbsyDxz11HCq+Ogo455DL
         1yp1DbYSkKkx6xb3ndu8ZpssNpClbvPKZ4eL38sFLf7rIvYEeHDfq/0ji0lUqaCkNiaA
         SQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695060359; x=1695665159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKdtwrHX9h1DYPfJUeRRaXbqtpaVmfYt1U1WzQ3+7bs=;
        b=tBGoOJ/JtxNiwNbDXzuaZqZ2RMu4JpDmYCIBprYkQIenOBUrZgS2Xu7aus5558X7HL
         AhCtO/LgYk/MaeOm3zHNr/XYddgGtZl1cskraO9L1WUoHrtNl3cIsz2VmstYMHoS8jAc
         M6ksIKV9bHreD7cs84Z+50c7Ghc/KdXow8+mmFdKMxhkxqpm7vsH93asNcQykO3MRQV/
         NAy+qYVDw/FwuaN7cWefghcclaMcvSC+Rl6LbJP8Ldp9bXsJaO3qJBNsmwuQdeM+Fa/f
         07YmLhCBbR+DMmRIiEeq+pQEouq8/D/fA/g/kSpghYhZDUmbLhHW/Xi9ieqFnRbxTeah
         X1hA==
X-Gm-Message-State: AOJu0YzcivF98QXHLqcRThATwSNwnlUySt0DRf/xgfPKdn4VLHQKHckA
        k8cYy04PR4Q/cBddrX/QSH7qk/m92/BPHTSDHr8=
X-Google-Smtp-Source: AGHT+IFXN7l/mdsgdrO4ji+WnHGSExjTx9sIQQWWSfSABQ2Ll3GGhB5DZw3ei/EfymWbBw68Dw2z79cKlNYX9CN4iA8=
X-Received: by 2002:a19:6756:0:b0:502:ff3b:7671 with SMTP id
 e22-20020a196756000000b00502ff3b7671mr5803223lfj.9.1695060359169; Mon, 18 Sep
 2023 11:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com> <87fs3bbdjb.fsf@oltmanns.dev>
In-Reply-To: <87fs3bbdjb.fsf@oltmanns.dev>
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 18 Sep 2023 20:05:48 +0200
Message-ID: <CAJpcXm7nrLzbDmNVCACy3ycBnhWY7HxWhCwroOCF-+GfMT_A9w@mail.gmail.com>
Subject: Re: [PATCH 00/13] imx8mp: first clock propagation attempt (for LVDS)
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank!

On Mon, 18 Sept 2023 at 19:24, Frank Oltmanns <frank@oltmanns.dev> wrote:
> On 2023-09-18 at 00:39:56 +0200, Benjamin Bara <bbara93@gmail.com> wrote:
> Thank you very much for including me in the discussion. If I understood
> Maxime correctly, your proposal is close to what he was suggesting in
> the discussion you referenced. Unfortunately, it doesn't cover the
> rounding aspect (which you also mentioned in your cover letter and the
> description for clk_detect_unintended_rate_changes in patch 7. I've been
> pondering the last three weeks how to find a good solution to this
> problem, but so far haven't found any.

I think if we stick to the idea of always enforcing the exact "typical
rate", we cannot avoid physically impossible cases. IMHO, it might make
sense to add a set_rate() function with a "timing_entry" (e.g. used by
display_timing.h[1]) to the clock API, which gives a suggestion but also
defines the "real" boundaries. This would provide a shared parent PLL
more freedom to provide a satisfying rate for all its children.

Regards
Benjamin

[1] https://elixir.bootlin.com/linux/v6.5.3/source/include/video/display_timing.h#L64
