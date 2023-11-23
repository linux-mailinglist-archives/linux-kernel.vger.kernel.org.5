Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D8C7F5734
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 05:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344592AbjKWEEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 23:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjKWEDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 23:03:52 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826381B6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:03:57 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-4aff11732bdso160299e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700712236; x=1701317036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7qPw5ycerKBMB3jFyF+3AvRZw5Lq7E7FvIBMNy6g4I=;
        b=NjXH3vNJvAyIh5pb2bYXB3BqaOyWf/2Oj2LEA+5dgRbG4BNHs5QBlLa8rVwJXnwbNQ
         vqaCZwAm5tytuM/BQ5al10sASm7UjBsu3a3/95LH5jNXM/zyMxPsMxQeWu6vm3MGf1Uy
         d7WiHAfLC6v4bnwAvhFvCLLw3rrHc9ukJy23w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700712236; x=1701317036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7qPw5ycerKBMB3jFyF+3AvRZw5Lq7E7FvIBMNy6g4I=;
        b=Sm560zyjzWK3ZQB9FVui2FkQamC4rZ6WfaDofvLkl5ejzs+iJdwxEIfw+C3Mp8xcBE
         7q2ssCp95WyEOYHaNzejJBsuMpKVE3uXNu1Bt5PyDiLdZGeQ8wEJiz0bV2Tfh5ir48YD
         FvuOQNcilfLX3HqM0ykZXexfnrd/3nUx1aPLNnQUApl79+KGzRK1qG0HIgltqAh+M7MX
         9vhGZDEUUemDwe1uM4mhEBVAoLRHiBBdrKTRZd0hOyJdvCfBANbvOw/AUWz3pBVJkTPp
         3nBzUg1YX1fdtCIB+mMBTy8miM1q/p6haW/lE/4eL8pL+Pfgl8QA4alFNg5ovqTOkfBF
         ynHw==
X-Gm-Message-State: AOJu0YzJCDtppLHbe2oNbwGMzvb77K8yPqKRt0NycH1sbp530+P4Rulh
        cARj8JBSZF+QxNUeFfk6UPBXRxRcHUgZkgPSZCePZw==
X-Google-Smtp-Source: AGHT+IHEv8FQH3Av8pAElQ9qfERfjfmvO65gGkD4/bsfmu9pB1X3gTPTuDyn4/gzP/yQpR9bECLgDg==
X-Received: by 2002:a1f:e784:0:b0:4ac:9a8:2f29 with SMTP id e126-20020a1fe784000000b004ac09a82f29mr4770504vkh.12.1700712236519;
        Wed, 22 Nov 2023 20:03:56 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id s45-20020a9f3670000000b007bb3e53712esm82402uad.36.2023.11.22.20.03.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 20:03:54 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7ba962d534eso144787241.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:03:54 -0800 (PST)
X-Received: by 2002:a67:c088:0:b0:45f:8b65:28f0 with SMTP id
 x8-20020a67c088000000b0045f8b6528f0mr4023922vsi.12.1700712233600; Wed, 22 Nov
 2023 20:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20231103102533.69280-1-angelogioacchino.delregno@collabora.com> <20231103102533.69280-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231103102533.69280-2-angelogioacchino.delregno@collabora.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 23 Nov 2023 12:03:16 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhS_OckB3ap9Sq1U9D5b7605N=w4WyPjJoRJCSRxW5_5g@mail.gmail.com>
Message-ID: <CAC=S1nhS_OckB3ap9Sq1U9D5b7605N=w4WyPjJoRJCSRxW5_5g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] clk: mediatek: clk-mux: Support custom parent
 indices for muxes
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 6:25=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add support for customized parent indices for MediaTek muxes: this is
> necessary for the case in which we want to exclude some clocks from
> a mux's parent clocks list, where the exclusions are not from the
> very bottom of the list but either in the middle or the beginning.
>
> Example:
> - MUX1 (all parents)
>   - parent1; idx=3D0
>   - parent2; idx=3D1
>   - parent3; idx=3D2
>
> - MUX1 (wanted parents)
>   - parent1; idx=3D0
>   - parent3; idx=3D2
>
> To achieve that add a `parent_index` array pointer to struct mtk_mux,
> then in .set_parent(), .get_parent() callbacks check if this array
> was populated and eventually get the index from that.
>
> Also, to avoid updating all clock drivers for all SoCs, rename the
> "main" macro to __GATE_CLR_SET_UPD_FLAGS (so, `__` was added) and
> add the new member to it; furthermore, GATE_CLK_SET_UPD_FLAGS has
> been reintroduced as being fully compatible with the older version.
>
> The new parent_index can be specified with the new `_INDEXED`
> variants of the MUX_GATE_CLR_SET_UPD_xxxx macros.
>
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Tested on MT8188 with a Type-C -> DP adapter to an extended display
Gigabyte M32U.
The DP output reacts smoothly to resolution switch and refresh rate
change, and the internal eDP output also never freezes.

Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: Fei Shao <fshao@chromium.org>
