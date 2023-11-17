Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61BC7EEE1C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjKQJGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjKQJGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:06:39 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782C31A5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:06:36 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a84204e7aeso19801307b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700211995; x=1700816795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7M4IZAQ9+XnnOMIQTa5CdmsUeDB/YjFOMkhJk8m36U8=;
        b=puCuLAK50vv6TomWvohI6jd6pNVl/IJilCOgRPAaTfWut6WhfilDeCknRCnjqaMvfB
         GUgnNetzoTXR31sd8ZfaVqAICicPsc7M9CavGggXJ5iz2nQHeZX4pyVC2rDJcMQM7OAl
         bVQ1ga5oLmVXG9JvSKBY4Ce706JFuOWaqcJztBuww8mooRqsxvNz8meWrcaeW4aZlR6M
         HR/vGRkuH7wUVAAvsRRGfSWE6Crelr23Pt67+DmvUnLTS4hI9rLfTPJNOygA05dIqLxv
         L8BduMTCFPTe3cUhy9+Vxg0mcZaSGyfk7UJnCPPrZ9nbw5ZuLx/p6jSoMCBUIrKwmt/p
         ZH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700211995; x=1700816795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7M4IZAQ9+XnnOMIQTa5CdmsUeDB/YjFOMkhJk8m36U8=;
        b=FtfgH3p1TPFEPGmA0ZANtIwZXYg5aqJLP35cL/qV2OoXfQRJLuwlOGn2O7oGmWPt10
         LZig+qyyNemu8zyWX5vATlp4b6ke1HGp44PaWizjcB9MycUYXsM3r+19yfwk1947vO+e
         rC+i21kN9irNZiZMOSGw6zkchSLwSHJV8HYlg0ojLT297CC0skVIqpT3vPR3SABpBxe0
         khfpFeC+rSBUYdmte2eUcrJSJnsgzRU1Dghj4oB2uCmLPzMtYIIQPiAfuZ7EAIaWKJ3t
         1i8Ei3FbK5alLoaPAJ+cJyEvJPANZGW73xuFq++eKgzADB+fCzTd29I0gGb8B4+cG6BX
         53NQ==
X-Gm-Message-State: AOJu0Yy2GyGP2c/Cd5mNdD3Xg7NYVmO3vIa9mEoI3YY7Br6kgX53JN5B
        iAQSpdk5UhkMoVtWcxx2krnDcso3WM8FoQMEGv7/sA==
X-Google-Smtp-Source: AGHT+IHvocYihGXhsoXfu9oZPl3MGyCmjSepLGXk4+LJxU49mkOxTdvhOtaUaUzIwDCfjQrpBN+oiNjND7EMB8oHRdk=
X-Received: by 2002:a81:8357:0:b0:5ad:cd52:d6f0 with SMTP id
 t84-20020a818357000000b005adcd52d6f0mr21344300ywf.45.1700211995690; Fri, 17
 Nov 2023 01:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20231117055849.534671-1-quic_rohiagar@quicinc.com>
In-Reply-To: <20231117055849.534671-1-quic_rohiagar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 17 Nov 2023 11:06:24 +0200
Message-ID: <CAA8EJpq0M3ykX0DsdHoMnqs8EAfU98w2Ky350Sgi9_AWpTHB1w@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: defconfig: Enable GCC, pinctrl and interconnect
 for SDX75
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, geert+renesas@glider.be,
        konrad.dybcio@linaro.org, arnd@arndb.de,
        krzysztof.kozlowski@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, m.szyprowski@samsung.com, u-kumar1@ti.com,
        peng.fan@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 at 07:59, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
> Enable Global Clock controller, pinctrl and interconnect framework
> support for Qualcomm's SDX75 SoC which is required to boot to
> console on sdx75-idp platform.
>
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
