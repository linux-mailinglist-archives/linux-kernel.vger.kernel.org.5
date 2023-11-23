Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D4C7F574E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 05:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbjKWEIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 23:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbjKWEIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 23:08:17 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58891722
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:06:00 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4ac4cd60370so141837e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700712351; x=1701317151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB5imdoPod8S9hEhNPZ14DUI1/eZZtU6LRuwv6Kh2nc=;
        b=POwUu8GZxKXJnLLlAm1XaQIkh9GYni4F4BzkP8ugLdCJL2QH5kwfXtQH2jHLmA4tw6
         OSj7RSA/tcf1q7tQQpj8zBjm9IngVMO5FFlIgl9hPWIa8P3Vz6/cHuHAo91q8nlHf716
         FuqaG4zEpUw8tWHpOpJaZ9AY9GVc8iAEB3LLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700712351; x=1701317151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB5imdoPod8S9hEhNPZ14DUI1/eZZtU6LRuwv6Kh2nc=;
        b=kqVEyzd/eMkzAv0hUSmpUEcVhbGmNcdguzP4XQOnqiRfPMBeyXIOSI1Kaqhau2WXil
         UXM8P5Hlc22lOTiHmhmv3a9Klsx6d1QzV8e7YD416uyxqjT5e2VeXrCqIVdiG5zTRmje
         2atqOMBQRNSDCP3/p4VlhkCZTWzrbjNevADnE3BySfSjmgtIxHxZP2/iq+oxQem6o/wz
         0Cf+EiSTjIaUbbEI4JKziy+scLifCiy/TkeXUzVcHU8Oy0BUU3Z3FG94/wYIWhN4c/Du
         ZgR3HSWV3arxbrKs30GGq43qldD6gM+Pa7eJabZ5JapsFwNqdb7kJBr5pLaHVJ0+geUb
         MVFg==
X-Gm-Message-State: AOJu0YyiVc9OL1eDSGSgBv/f8/3WBAt5Q0zcZUB8z22HymRHqMOOyhG+
        oh3erZgDpEXoN5R/aEPOgC2ak0q1F4SR16qMv6Qisg==
X-Google-Smtp-Source: AGHT+IEgDqY8hgbAB0sAyOtzUvtQesijSdFyP7FbKM2sJ5M8mQtSe7vSSBu2MSXtIzZNBjmw+PPFvQ==
X-Received: by 2002:a1f:49c3:0:b0:496:2e22:29e3 with SMTP id w186-20020a1f49c3000000b004962e2229e3mr3989815vka.1.1700712351259;
        Wed, 22 Nov 2023 20:05:51 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id j188-20020a1f6ec5000000b004a8e99b9f45sm131960vkc.45.2023.11.22.20.05.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 20:05:50 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-45da9180517so137750137.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:05:49 -0800 (PST)
X-Received: by 2002:a05:6102:1285:b0:462:a479:79fd with SMTP id
 jc5-20020a056102128500b00462a47979fdmr4441694vsb.23.1700712349221; Wed, 22
 Nov 2023 20:05:49 -0800 (PST)
MIME-Version: 1.0
References: <20231103102533.69280-1-angelogioacchino.delregno@collabora.com> <20231103102533.69280-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231103102533.69280-4-angelogioacchino.delregno@collabora.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 23 Nov 2023 12:05:13 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhL-i7GhP=qRwf+Z_=K2Ee42ZceiPHAuQznsmP2ENXp9g@mail.gmail.com>
Message-ID: <CAC=S1nhL-i7GhP=qRwf+Z_=K2Ee42ZceiPHAuQznsmP2ENXp9g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] clk: mediatek: mt8188-topckgen: Refactor parents
 for top_dp/edp muxes
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        wenst@chromium.org, msp@baylibre.com, amergnat@baylibre.com,
        yangyingliang@huawei.com, u.kleine-koenig@pengutronix.de,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 6:25=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The top_dp and top_edp muxes can be both parented to either TVDPLL1
> or TVDPLL2, two identically specced PLLs for the specific purpose of
> giving out pixel clock: this becomes a problem when the MediaTek
> DisplayPort Interface (DPI) driver tries to set the pixel clock rate.
>
> In the usecase of two simultaneous outputs (using two controllers),
> it was seen that one of the displays would sometimes display garbled
> output (if any at all) and this was because:
>  - top_edp was set to TVDPLL1, outputting X GHz
>  - top_dp was set to TVDPLL2, outputting Y GHz
>    - mtk_dpi calls clk_set_rate(top_edp, Z GHz)
>  - top_dp is switched to TVDPLL1
>  - TVDPLL1 changes its rate, top_edp outputs the wrong rate.
>  - eDP display is garbled
>
> To solve this issue, remove all TVDPLL1 parents from `top_dp` and
> all TVDPLL2 parents from `top_edp`, plus, necessarily switch both
> clocks to use the new MUX_GATE_CLR_SET_UPD_INDEXED() macro to be
> able to use the right bit index for the new parents list.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Tested on MT8188 with a Type-C -> DP adapter to an extended display
Gigabyte M32U.
The DP output reacts smoothly to resolution switch and refresh rate
change, and the internal eDP output also never freezes.

Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: Fei Shao <fshao@chromium.org>
