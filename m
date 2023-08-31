Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4504E78E701
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245197AbjHaHNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244968AbjHaHNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:13:37 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9771B1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:13:34 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-794cd987ea6so19806939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693466013; x=1694070813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0uJEXICar/m6wRe8rgnaCoFUj0NDUfeIIguEQQrQtA=;
        b=QdXmEYUO0R67juQerc6xiM6XSYWL5hyWW8El1DG1ZhMbqGLy8yYLRMWgf7BAP2h3KR
         hdlRvKrrZFXf6+O+t1V1YkgOdhR4/TL6mpvqUOKhe2u1n3gq9H3MZU/epNrrVpoaqHgp
         iaep+dpxmFmscOMJq2Pv6OwLBSHT5XlV56F9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693466013; x=1694070813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0uJEXICar/m6wRe8rgnaCoFUj0NDUfeIIguEQQrQtA=;
        b=TLQhYqmi+rkucJ80nEWZSs8jPhbVu/5X4MaZBSbrzxFk+35vU9Jn+R0QaWFLjBmCLv
         no3OqIPrlo5sebQNKcSyJEx706elylNKW27kdzc46OkeBgxPrwnueLwbGpJk/xqejIWz
         8LcGtjU7mRcNPog/AUJJ/W7Jcare8umU4437TCezLwgbBF4bvpvMdY8q4n3+To7umHxn
         9Rr/yhfmJbcEsl1ax/Xi3YueinIQrhldK9QtSfzfLvKkNGhVvgb63Fi2JadzHrPhJSI/
         XKtLPH9QTkxIJPBhZegQ26zUaxPNN2bgCjzT2icVtAxuewvMT9BG4+4GZ4C92WoXFbRt
         NC7g==
X-Gm-Message-State: AOJu0YzTFJe3ECM0lEm+zn9TM89yCDazJjStuH2M3r5QVPci2H/gM+8V
        sESF+ebkz8AItAAk9sgYGOILelXwftvzRd6D95I=
X-Google-Smtp-Source: AGHT+IHIJrpmLFcTf6ppIPjqgPvLO1GY+HRZ69Z5ZAXXtUbLTlqJ7qolhg6ix6pK2L0XNomDLGlFBw==
X-Received: by 2002:a6b:4f09:0:b0:790:c3d0:8f87 with SMTP id d9-20020a6b4f09000000b00790c3d08f87mr4782101iob.19.1693466013640;
        Thu, 31 Aug 2023 00:13:33 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id t16-20020a028790000000b00430979b6aa5sm246860jai.0.2023.08.31.00.13.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 00:13:32 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7928dc54896so19918339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:13:32 -0700 (PDT)
X-Received: by 2002:a05:6602:2768:b0:783:4f8d:4484 with SMTP id
 l8-20020a056602276800b007834f8d4484mr4957838ioe.2.1693466011946; Thu, 31 Aug
 2023 00:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230822132646.9811-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20230822132646.9811-1-jason-jh.lin@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 31 Aug 2023 16:12:55 +0900
X-Gmail-Original-Message-ID: <CAC=S1njUVqt969Wv+dMc5wD3Uyu-2Cm4qCUwkp7kfeG_uBbpVw@mail.gmail.com>
Message-ID: <CAC=S1njUVqt969Wv+dMc5wD3Uyu-2Cm4qCUwkp7kfeG_uBbpVw@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 10:27=E2=80=AFPM Jason-JH.Lin <jason-jh.lin@mediate=
k.com> wrote:
>
> Add spinlock protection to avoid race condition on vblank event
> between mtk_drm_crtc_atomic_begin() and mtk_drm_finish_page_flip().
>
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT817=
3.")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: Fei Shao <fshao@chromium.org>
