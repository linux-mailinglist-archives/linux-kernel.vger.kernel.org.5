Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208047B7923
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241589AbjJDHzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjJDHzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:55:13 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266ACA7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 00:55:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5334f9a56f6so3135653a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696406108; x=1697010908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8MtHSb/RNsDy2bsyLe9wq+5v559vVDhKA/xX66EHAE=;
        b=XES2M0O2gCyOGgxitAc4ea2r1Vu+jkOJ3uDfpuU2vCTeo5sFGxFCpP4aBYn5464JlB
         RwpdH4GMSnDhsWjg0i2MazAIzLLSIEDnULoTNGlS0lb//5PGL1z25/dz8h+/DGZW5ZJM
         CGPE0+Fgs3t7kwg+gRbffOkL4kNGH4iJh78UQ/Ld0yLz2wkVE7UJZ79JAjqEz+neThDm
         9F+YN6OH3QWsxxykZUPibY3w0ufFheN669Ad6duJ0Uoa4aaphoQcX7bD/pexXF0g9cHn
         I6CeGa5hRbt4SWF3ReQHHFHXxV2yvrp5eVfQjdSMUdE28/9FKc36DwRQK6MAYSgA6d7U
         3RMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696406108; x=1697010908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8MtHSb/RNsDy2bsyLe9wq+5v559vVDhKA/xX66EHAE=;
        b=w9TNCIAiCjtt2g3rCVWdgMEENcaH3ov3A6T9X/Tl4jJJaWJwDPlzhVwehN/NvBb9LG
         HSpEoPT6WLGTUvrhEq456x82VccQVaoDbAoZ+EEEXdAA3zchf7hIhhISuWc2aOrRWrbu
         Y3Pq567jEk011d0jjXtCYOS4sDVB/oM2AxExrS65tu43WeafY56HVvyx0SV+uVenPE16
         FOxXekvICl6TTO43V3urfYrQQ5xbpu3bE61dZHkvJdBiq3qje6UPlzuNXcLwihmiyxT3
         nn57O8Ose7WRpYE/APjBQhLTWY1a/4JTArh5UcfLzJqwQX50DZ7az8AVXvlvnZakxrZG
         s4GQ==
X-Gm-Message-State: AOJu0YzYdGOESS4qT0G6q+16UJsac7WKz72omqIWO7QXi0Gc3+8nPG/3
        Rzo9PEKLFPEHSt5ucMscRL2rqA==
X-Google-Smtp-Source: AGHT+IGfixRwO8WxB7/Ghxm+3SUGkv8WpbxAjPmH6yRHcFEJgUYrWUtaRRYzSR9XlDxsqH7Ta68lfw==
X-Received: by 2002:a50:fb90:0:b0:52e:5b10:23ac with SMTP id e16-20020a50fb90000000b0052e5b1023acmr1305874edq.36.1696406108137;
        Wed, 04 Oct 2023 00:55:08 -0700 (PDT)
Received: from linaro.org ([86.123.99.172])
        by smtp.gmail.com with ESMTPSA id c6-20020a056402100600b005381936efa7sm1982410edu.16.2023.10.04.00.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 00:55:07 -0700 (PDT)
Date:   Wed, 4 Oct 2023 10:55:05 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Viorel Suman <viorel.suman@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>
Subject: Re: [PATCH 0/7] =?utf-8?B?Y2xr77yaaW14?= =?utf-8?Q?=3A?= misc
 update/fix for i.MX8
Message-ID: <ZR0aWSviogXjw+od@linaro.org>
References: <20230912-imx8-clk-v1-v1-0-69a34bcfcae1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912-imx8-clk-v1-v1-0-69a34bcfcae1@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-09-12 17:18:58, Peng Fan (OSS) wrote:
> The patchset is to upstream NXP downstream i.MX8 clk misc patches which
> has been stayed in NXP LTS release for quite some time.
> 
> There are a few fixes, but should be fine to put in next tree.
> 

Whole series LGTM.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
> Peng Fan (4):
>       clk: imx: imx8qm-rsrc: drop VPU_UART/VPUCORE
>       clk: imx8: remove MLB support
>       clk: imx: scu: ignore clks not owned by Cortex-A partition
>       clk: imx: imx8qm/qxp: add more resources to whitelist
> 
> Robert Chiras (1):
>       clk: imx: imx8qxp: Fix elcdif_pll clock
> 
> Shenwei Wang (1):
>       clk: imx: imx8qxp: correct the enet clocks for i.MX8DXL
> 
> Viorel Suman (1):
>       clk: imx: imx8dxl-rsrc: keep sorted in the ascending order
> 
>  drivers/clk/imx/clk-imx8-acm.c     |  6 +++---
>  drivers/clk/imx/clk-imx8dxl-rsrc.c |  3 +--
>  drivers/clk/imx/clk-imx8qm-rsrc.c  |  5 ++---
>  drivers/clk/imx/clk-imx8qxp-lpcg.h |  1 -
>  drivers/clk/imx/clk-imx8qxp-rsrc.c |  4 +++-
>  drivers/clk/imx/clk-imx8qxp.c      | 13 ++++++++++---
>  drivers/clk/imx/clk-scu.c          | 20 ++++++++++++++++++++
>  7 files changed, 39 insertions(+), 13 deletions(-)
> ---
> base-commit: cd04b2fab5ee58862674e9bab3cbc8e9a8576845
> change-id: 20230912-imx8-clk-v1-d2089920a23a
> 
> Best regards,
> -- 
> Peng Fan <peng.fan@nxp.com>
> 
