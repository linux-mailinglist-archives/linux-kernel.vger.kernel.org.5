Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8E07F9C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjK0J2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjK0J2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:28:05 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B2B18A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:17:30 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c887d1fb8fso48571941fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701076649; x=1701681449; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=bEIoGh5O/BzqSyDdvmfvLEUiDH4K1xP/uQvVNiufgcU=;
        b=a01z+9wnmmRIlXAKMaYLJ9I//hXNmqrHWLIPX9pCbGiV2nzr+U5fR0zyy1AjH9O1Pq
         g8GKW2mBUNJCBFTsRrqEZRM0MnRzZQjJgWEtTAzxr0oJt3VWw3L2P1cMpI0rn1Qbf8Qi
         Ztxz5dnrvYDXyvLRwcJuPWsHdXp/dXTR2Y/tMm8DyccHycJA5fEsB64VruFkuy15s8ut
         /spTQQSsfESK0BjiBy6TSYvv47KW4boe3loy5YT3tjitdEVLDkr+8zB9If9qGMsLjJra
         y1uV0WEBnlGD10F6wAxsCSb2QWcffaSju4Coy79dtbZQ2P7nZ/mL/lH8TdSmIoWmeNWF
         X91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701076649; x=1701681449;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEIoGh5O/BzqSyDdvmfvLEUiDH4K1xP/uQvVNiufgcU=;
        b=NgYEhgPO4cg6YWdnMi3QZdrV8lrUJmwgGCtd4VWaxd5MjRgM4TTw+Yk4jMtGIsbUIT
         efPoCaT8VX4IcD2ACHU6WdtMqkm52Nf3nD3n+IG+4SKF2IWAY6X3YuFJG8Dyb4Z45Tfx
         DeXSooABGL2T7a0eBlBnLrzkZf+SdtqDv9JbkGPr4kMB2Zent+Pn51MWdpF14uBdLiYA
         jnHYybzGpWS4l1cizcl31k382WacIOkEL8GQTJ4QaIhXClAQgigJVdzzD0yQTg+13tga
         B+z8/cQgmfuQjciofIc8ubcgfXtX9dajEVcp0MXvx0dTzKV+L7O0iMwkI0VJ6W8kk9dn
         2Pow==
X-Gm-Message-State: AOJu0YzLHXd4czMSpoxdheLYbjhJupXW6BmtoluloQRo5Um2yGrinMx/
        VeD04PdTg8Yyf5J1t0c/KrqGHA==
X-Google-Smtp-Source: AGHT+IGy/JmtaB1RId0/b5RlEgolNkKFgTxdlq7MWzbR6GDUGon0doGnidwbBevghTckT6+7ygTSrA==
X-Received: by 2002:a2e:8387:0:b0:2c8:8745:8f0b with SMTP id x7-20020a2e8387000000b002c887458f0bmr6234114ljg.47.1701076648575;
        Mon, 27 Nov 2023 01:17:28 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:fd31:fff0:e26c:d593])
        by smtp.gmail.com with ESMTPSA id dm16-20020a0560000bd000b0032d09f7a713sm11439739wrb.18.2023.11.27.01.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 01:17:28 -0800 (PST)
References: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org>
 <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-8-95256ed139e6@linaro.org>
 <1jbkbjdxk8.fsf@starbuckisacylon.baylibre.com>
 <b23ddc3b-d995-4cd6-91f2-3efa59d345a5@linaro.org>
 <1j34wvdtux.fsf@starbuckisacylon.baylibre.com>
 <41a1246e-c885-460a-8208-16844e95e1ae@linaro.org>
User-agent: mu4e 1.10.8; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     neil.armstrong@linaro.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 08/12] clk: meson: g12a: make VCLK2 and ENCL clock
 path configurable by CCF
Date:   Mon, 27 Nov 2023 09:38:28 +0100
In-reply-to: <41a1246e-c885-460a-8208-16844e95e1ae@linaro.org>
Message-ID: <1jjzq3zhaw.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> 
>>>
>>> I suspect mipi_dsi_pxclk_div was added to achieve fractional vclk/bitclk ratios,
>>> since it doesn't exist on AXG. Not sure we would ever need it... and none
>>> of the other upstream DSI drivers supports such setups.
>>>
>>> The main reasons I set only mipi_dsi_pxclk in DT is because :
>>> 1) the DSI controller requires a bitclk to respond, pclk is not enough
>>> 2) GP0 is disabled with an invalid config at cold boot, thus we cannot
>>> rely on a default/safe rate on an initial prepare_enable().
>>> This permits setting initial valid state for the DSI controller, while
>>> the actual bitclk and vclk are calculated dynamically with panel/bridge
>>> runtime parameters.
>> Nothing against setting rate in DT when it is static. Setting it then
>> overriding it is not easy to follow.
>
> Yup, would be simpler to only have parenting set in DT, since it must
> stay static, I'm fine trying to move rate setup to code.
>
>> To work around GP0 not being set, assuming you want to keep rate
>> propagation as it is, you could call clk_set_rate() on cts_encl (possibly w/o
>> enabling it) to force a setup on gp0 then clk_prepare_enable() on
>> pxclk. You'd get a your safe rate on GP0 and the clock you need on pxclk.
>> It is a bit hackish. Might be better to claim gp0 in your driver to
>> manage it directly, cutting rate propagation above it to control each
>> branch of the subtree as you need. It seems you need to have control over
>> that anyway and it would be clear GP0 is expected to belong to DSI.
>
> Controlling the PLL from the DSI controller seems violating too much layers,
> DSI controller driver is not feed directly by the PLL so it's a non-sense
> regarding DT properties.

Not sure what you mean by this. You have shown in your the commit
message that the DSI clocks make significant subtree. I don't see a
problem if you need to manage the root of that subtree. I'd be great if
you didn't need to, but it is what it is ...

>
> Setting a safe clock from the DSI controller probe is an idea, but again I
> don't know which value I should use...

You mentionned that the problem comes DSI bridges that needs to change
at runtime. I don't know much about those TBH, but is there
anyway you can come up with a static GP0 rate that would then be able to
divide to serve all the rates bridge would need in your use case ?

GP0 can go a lot higher than ~100MHz and there are dividers unused in the
tree it seems.

I suppose there is a finite number of required rate for each use case ?
If there are not too many and there is a common divider that allows a
common rate GP0 can do, it would solve your problem. It's a lot of if
but It is worth checking.

This is how audio works and DT assigned rate is a good match in this case.

>
> I'll review the clk parenting flags and try to hack something.
>
> Thanks,
> Neil
>
>
