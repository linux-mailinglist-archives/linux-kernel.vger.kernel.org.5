Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555FC7592D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjGSKYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjGSKYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:24:15 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F70E26AB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:23:47 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7836164a08aso360198839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689762213; x=1692354213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahbeWucAcoOgJsJY2s8d1VaxXiv71GHKoX+Vccdy9XU=;
        b=EPBukdUU6JZL7z6rax1O8Y1jHxExtSvPJnsurmUPhC//wDyCKsnEIw6X+7A8G7MeJV
         c4yDExgcwcvfrRyQbsYkWalcWU/zFvzPGIoK+/JOWSys6t1UlBfjbd1Vqd9otuPPA+MT
         Qz+qhGIpykg0AX4Z01moBKrysghiXmOSxaTXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689762213; x=1692354213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahbeWucAcoOgJsJY2s8d1VaxXiv71GHKoX+Vccdy9XU=;
        b=ddqfoBDJ40vz48VPU3TrcwR91qjQ98cnCw5YaO3Ih/32glAEKlUEh5jortNtCG4Lzo
         vdtIydvtTdDPR8Y79YKXnZsPYe8YW05foemNpteahrFPuGeA7Ksq6kK5wPakgy4DcKpM
         3aGw+4C+DwqOpOoRiGr4xeHbPPQwJJSWASEb602Z20Nd0b01N9iNVK1IlMDcqk1IHj4R
         29alvARbAgze15fzyi/sZ2svIcXZTXCNvNf4Yx976FteW5SWNeYRkpRT6+cZOkuwu2jf
         DlTYi7DiuqW9eOm9jJO8w6dTbCzN+nOjIU4qp9VoHiO3NH23d6iAr4QXpXP22k5Jl+k2
         Edgw==
X-Gm-Message-State: ABy/qLYVR8luTf9Ro21jhud++bFdoY5Zl/GLZ3zKwJomu4ZdVKrpAJIr
        ghgISjAQxL/RMsd3VYdzwkQGvQO27w/NRsvbxJU=
X-Google-Smtp-Source: APBJJlE1NSWYPNYDpFj1aSoF/n+Fc6csiwz/L/rS0MqFVXNUm0ovnsOfH0oR9m3y7ja0T6J9BSTmZg==
X-Received: by 2002:a6b:a17:0:b0:785:5917:a35f with SMTP id z23-20020a6b0a17000000b007855917a35fmr2055677ioi.8.1689762213132;
        Wed, 19 Jul 2023 03:23:33 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id p7-20020a0566380e8700b0042b326ed1ebsm1214829jas.48.2023.07.19.03.23.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:23:32 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7872d448c5aso361504639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:23:31 -0700 (PDT)
X-Received: by 2002:a05:6602:3314:b0:783:60f7:ade9 with SMTP id
 b20-20020a056602331400b0078360f7ade9mr1781762ioz.5.1689762211675; Wed, 19 Jul
 2023 03:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230719075056.72178-1-angelogioacchino.delregno@collabora.com> <20230719075056.72178-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230719075056.72178-2-angelogioacchino.delregno@collabora.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Wed, 19 Jul 2023 18:22:55 +0800
X-Gmail-Original-Message-ID: <CAC=S1ng+s5Fr_Evwct6E5yPZD8hN_NLYnx2sitrUWK3b4ti73g@mail.gmail.com>
Message-ID: <CAC=S1ng+s5Fr_Evwct6E5yPZD8hN_NLYnx2sitrUWK3b4ti73g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] drm/mediatek: mtk_dpi: Simplify with devm_drm_bridge_add()
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 3:51=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Change drm_bridge_add() to its devm variant to slightly simplify the
> probe function.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>
