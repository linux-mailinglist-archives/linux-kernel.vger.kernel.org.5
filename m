Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E07E79E160
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbjIMIC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbjIMICx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:02:53 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CBD198C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:02:49 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7a855441a36so604410241.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694592168; x=1695196968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVi9HWsbyhPpxRlpwWkXgfmiV8lk8qQbW6adbUERlyM=;
        b=WtqJJ8zdF2DvevVlZUhifJqIjvzG6d52EXJ/FGWxwKb04dsvN5ilpFnQXqaon0qMZ5
         7Egy9zqeMIilpPtvctkBSU5dgbTyt6mMFVRybsrt8hv8RnSx7mNzQtgnjs/YWV0kDZF5
         UwvQBudXGR+np6IbljBax6FU+eL6TJXZ8eKpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694592168; x=1695196968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVi9HWsbyhPpxRlpwWkXgfmiV8lk8qQbW6adbUERlyM=;
        b=LpEMt5C3S8j/KPVQVuswdo7Ux30vza5qpxBQ6uiDstycs+SczsGbAmBThCv/THMCMf
         SfF15OUAyYVMzTNzYZxtAxHNdeQX8jqeC1A+tfO6qyA+0oj3jnWza/D31SfvpQ1elKxU
         +RKo1tfQ53ehweWjMVCGy5tqr1BdTfvnfpzyEDVBCUmOlO6a477SjxmJOwdehzACkGpv
         Df998lbshF1Mv3jzSbr4m1FMb9jNYP1K6B+IvusmRQoSkpoM1hhlHMsBkGpRSbFZZ4uk
         CJ0ZrFhEqDI7eS+CKjiQVOVgbOMXiDP06SCC0oj3kB6tKlYQ2JUVm3a9+/M3G02kUL/3
         Y6WA==
X-Gm-Message-State: AOJu0YyEaO/PqDC+G+8OJUJzquWGZTfpzMsCwQSKp0gvnCYFcvQxzhm7
        UwDGs9DXfGRl9/xU+yRNg3KH+JBRo9uKJKL85P4=
X-Google-Smtp-Source: AGHT+IG1R2njgKcwR00E0/V8UyFQ66dRBCfuNxtfXxCoKwrky9jyAmdzMEzIAQN+dcpd07js5/jnJQ==
X-Received: by 2002:a67:fd54:0:b0:44e:a216:59a2 with SMTP id g20-20020a67fd54000000b0044ea21659a2mr1458457vsr.7.1694592168655;
        Wed, 13 Sep 2023 01:02:48 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id x188-20020a0deec5000000b00582b239674esm2970889ywe.129.2023.09.13.01.02.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:02:48 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-59b8f5b6c0aso28451327b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:02:48 -0700 (PDT)
X-Received: by 2002:a05:6602:3281:b0:786:7100:72de with SMTP id
 d1-20020a056602328100b00786710072demr2263328ioz.16.1694591694827; Wed, 13 Sep
 2023 00:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230822132646.9811-1-jason-jh.lin@mediatek.com> <CAC=S1njUVqt969Wv+dMc5wD3Uyu-2Cm4qCUwkp7kfeG_uBbpVw@mail.gmail.com>
In-Reply-To: <CAC=S1njUVqt969Wv+dMc5wD3Uyu-2Cm4qCUwkp7kfeG_uBbpVw@mail.gmail.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Wed, 13 Sep 2023 15:54:18 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhhAevMct0SoipCRpVmHmMGEuvu2yKmkjuVVUpeZxZ5ug@mail.gmail.com>
Message-ID: <CAC=S1nhhAevMct0SoipCRpVmHmMGEuvu2yKmkjuVVUpeZxZ5ug@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Add spinlock for setting vblank event in atomic_begin
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 3:12=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote=
:
>
> On Tue, Aug 22, 2023 at 10:27=E2=80=AFPM Jason-JH.Lin <jason-jh.lin@media=
tek.com> wrote:
> >
> > Add spinlock protection to avoid race condition on vblank event
> > between mtk_drm_crtc_atomic_begin() and mtk_drm_finish_page_flip().
> >
> > Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8=
173.")
> > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>
> Reviewed-by: Fei Shao <fshao@chromium.org>

Also, I verified that this fixes a real world system hang issue on the
MT8195 Chromebook.

Tested-by: Fei Shao <fshao@chromium.org>
