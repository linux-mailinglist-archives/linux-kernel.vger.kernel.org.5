Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EF875EEAF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjGXJGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjGXJGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:06:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4672F1A2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:06:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb7589b187so5986381e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690189604; x=1690794404;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MWiZQGtEoDd6vYkaCeUUHjlAedCnBQMw8cP5GB7UACs=;
        b=T9je4nDcYplTvk7qGBjMRHyCVdXOwnMahnWtLXKXhBoorgvTE/t5sdwcXUZiBncr6U
         bLqrke6vUMhkeBL6adwaYPqoRzfb7M6Vmm2/Vh7dlQ1lwqgr8m6WPZb0stCWt3q5jbE8
         kAy1+N8x8aEiDHWJF1FclVDmfZFoksV7OJrap7krdYpWSmzBAMXKYX5S3W8OTJBQbgn6
         aTvAktMm7eey+yYsXs1il/63EvZnlg70B6SD8LTUDdW4BMpChes/r/SzVm//lDlbBx8+
         xUG5p+szFz5jJJ/VtJNOFrr0YzY4AnjQEB/M161fAMQJaXgS+XYKlJD+liV3ErxJrtGy
         whnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189604; x=1690794404;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWiZQGtEoDd6vYkaCeUUHjlAedCnBQMw8cP5GB7UACs=;
        b=Gq6Cw6XWhQFyiM8LYoWqOh/PcB2aRW3qsQ5vt60Z2rvj8sJiXGgC6gO3iPVEtq8xml
         vXvAy5ypZo53XW4TiCt4v7kfw+VvK/4oxeNmpurPzi9RoC4of510d5PTb3uw9gmFX2iq
         GdGVWcWOj73eqnRjsEhYni6mBKuvsfsuaBzl3QzGbbfNKZAHNXt19oOeYffkJeDTm5gp
         V8fwC9nzPh6sqO+X90eQvLGUxfnOucj3jE6UlRDohmB8KaNv/6yeiqrHmp9V3DrnXYmu
         BVFDOxPUF2cOCqN5ZJH7oh6H/uo3qTQyxG+po99ZQwpOrxBRRvh9fDI0qNZqIIQXP1ce
         5vxw==
X-Gm-Message-State: ABy/qLY8Shw/el5mIQbJiOVuNm5Mopk3Nt2DiluIpFTwW4L9OEmCVNbn
        6UGo2z3R91fFEB5+k1xQPw1mVw==
X-Google-Smtp-Source: APBJJlGtZfuY7Kf4FYV4ziuMtTtkHqU8SSVKob/5rCL8zHjE3hyY370Fx8+xNu+OdiqC5x51a1zcgw==
X-Received: by 2002:a05:6512:ac2:b0:4f7:6a40:9fd7 with SMTP id n2-20020a0565120ac200b004f76a409fd7mr5296059lfu.47.1690189604320;
        Mon, 24 Jul 2023 02:06:44 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id t18-20020aa7d4d2000000b0051de3c6c5e5sm5824932edr.94.2023.07.24.02.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:06:43 -0700 (PDT)
Date:   Mon, 24 Jul 2023 11:06:42 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v3 6/6] can: tcan4x5x: Add error messages in probe
Message-ID: <20230724090642.o7qzib5onl53nmqc@blmsp>
References: <20230721135009.1120562-1-msp@baylibre.com>
 <20230721135009.1120562-7-msp@baylibre.com>
 <20230724-switch-mulch-3ba56c15997e-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230724-switch-mulch-3ba56c15997e-mkl@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:37:51AM +0200, Marc Kleine-Budde wrote:
> On 21.07.2023 15:50:09, Markus Schneider-Pargmann wrote:
> > To be able to understand issues during probe easier, add error messages
> > if something fails.
> 
> Can you print the error codes as "%pe", ERR_PTR(err)?

Yes, thank you, I will use that instead.

Best,
Markus

> 
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |


