Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3388770385
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjHDOuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjHDOuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:50:10 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A5846B2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:50:08 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9338e4695so35396981fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691160607; x=1691765407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SMo6gMfYlM/VNtFOwn/e5G1+vIj8kyfLio8gxupX/74=;
        b=Mfog46uUvnC1c3rJIRnxVP4Rn1RbM25sv6wJsTw/NSVKIwWmjjCO90AC35/gzaa/Y5
         F3rZRVvXDuuGz6MMqir/9Eh0mflOU0TgDqPn9elrJExaK5oBz588NIunZgMZIHUVzB/G
         54NpDe2kPhOJN3NU+NolDhb/A3wovEabDWmtdgXv8KGTCPee+zgTuRPt533tcJFlA1i6
         XRq8+VcfmJaRwMDSYHJ4QfTZl/APXx0z8YuY8Vqr5gY407AiuxzAQB490bCFp3dlR39b
         aW8l1/6W0FrEM1CVF9+wIoB1ktl2ZJhCjkqt/OpAIYpjy0mln0oczHM5luyUJBt6gvXD
         12hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691160607; x=1691765407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMo6gMfYlM/VNtFOwn/e5G1+vIj8kyfLio8gxupX/74=;
        b=RlDzPOtrqnAG2EErIWc14F/NByD/GKg4TOHs8Q9g8QI7vDy27aUeGIiisO/B+9aUJn
         E5GQa9sMe9Qj35RwtBU1XwhfhX7zFfA6Jt5OLyWIpDUuh/Bi2hUn+9NeVgdF7XiSfQlc
         DbPbfJHBOpnyRCDqn+6XYwQ0GYAGpoZDZXmi5pNk0m/OzBB1tL/q3S5W2M4cMbYzZ6zo
         UEGQ+ZicIkptPh1kQgQZcR22JuKE3FMVJB7q0k1N8RzHXRSKk9YmDHd5+7Y3msEd+z4t
         ZY/0wg7FSI3hEW77liYhVvL2Xe/ZhSTYLWeiTL+FTqh1mhnnOXwHo3wxLkAhO7Q4VFcu
         aPWQ==
X-Gm-Message-State: AOJu0Yx36TnfpEM78qqFYHjXg913N73spW3lC6ENi/gpAqTPC5R8HjZa
        vAXF6zrReAV1DLab6119jSnSyA==
X-Google-Smtp-Source: AGHT+IH9U6AIT6bF+8F9r2Z0sZcprmA3N5tubjVSO8iveevPtXWr9d3p3tebi9qlowrLhtjtfMqA8Q==
X-Received: by 2002:a2e:a176:0:b0:2b9:ee3e:2407 with SMTP id u22-20020a2ea176000000b002b9ee3e2407mr1664532ljl.38.1691160606509;
        Fri, 04 Aug 2023 07:50:06 -0700 (PDT)
Received: from localhost ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id l26-20020a1c791a000000b003fbb06af219sm2540259wme.32.2023.08.04.07.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 07:50:06 -0700 (PDT)
Date:   Fri, 4 Aug 2023 16:50:05 +0200
From:   Julien Stephan <jstephan@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Louis Kuo <louis.kuo@mediatek.com>,
        Phi-bang Nguyen <pnguyen@baylibre.com>,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        devicetree@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 sensor interface
Message-ID: <72ixohoacq4vgj7nqg4l5gt5bs5e5ewain6a5ovqs3winx3qzz@sbg5lfohq5mq>
References: <20230630100321.1951138-1-jstephan@baylibre.com>
 <20230630100321.1951138-3-jstephan@baylibre.com>
 <da891ec5-473c-5bef-d88b-661fac70ed25@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da891ec5-473c-5bef-d88b-661fac70ed25@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 01:02:02PM +0200, AngeloGioacchino Del Regno wrote:
> Il 30/06/23 12:01, Julien Stephan ha scritto:
..snip..
> > +
> > +static const struct mtk_seninf_format_info mtk_seninf_formats[] = {
> > +	{
> > +		.code = MEDIA_BUS_FMT_SBGGR8_1X8,
> > +		.flags = MTK_SENINF_FORMAT_BAYER,
>
> Each entry fits in one line.
>
> 	{ .code = MEDIA_BUS_FMT_SBGGR8_1X8, .flags = MTK_SENINF_FORMAT_BAYER },
>

Hi Angelo,

Actually not all entries fit in one line. The last 4 ones don't:

       { .code = MEDIA_BUS_FMT_SGRBG10_DPCM8_1X8, .flags = MTK_SENINF_FORMAT_DPCM | MTK_SENINF_FORMAT_INPUT_ONLY },
which is 115 chars..

so what is the best? put all in one line except the last 4 one? or keep
them all as is?


> > +	}, {
..snip..
> > +	udelay(1);
> > +	mtk_seninf_input_update(input, SENINF_CTRL, CSI2_SW_RST, 0);
>
> Is there any way to check if the CSI port did reset, or is it *guaranteed* to get
> out of reset in a microsecond after deasserting SW_RST?
>

I will double check this

> > +}
> > +
..snip..
> > +
> > +	val = mtk_seninf_mux_read(mux, SENINF_MUX_CTRL);
>
> rst_mask = SENINF_MUX_CTRL_SENINF_IRQ_SW_RST | SENINF_MUX_CTRL_SENINF_MUX_SW_RST;
>
> writel(mux->base + SENINF_MUX_CTRL, val | rst_mask);
> writel(mux->base + SENINFMUX_CTRL, val & ~rst_mask);
>
> that's better, right? :-)
>

right :)

Cheers
Julien

> > +	mtk_seninf_mux_write(mux, SENINF_MUX_CTRL, val |
> > +			     SENINF_MUX_CTRL_SENINF_IRQ_SW_RST |
> > +			     SENINF_MUX_CTRL_SENINF_MUX_SW_RST);
