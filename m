Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B54776FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjHJFoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjHJFow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:44:52 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DA0DA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 22:44:52 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-790b95beeedso18951439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 22:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691646292; x=1692251092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPy+GgB9Rn2CrQzZMkbpjUhP00w0ETOf0gW/R2Mixqg=;
        b=j118H1So/vI4xaykh2wahXSzkfCv2++Qvibqcc3ZO8QrP2bpjF+hSMJ2+Oa3GXR5VQ
         ORhk0hxvdaftxuVDT1jY8YgPsZw3BMEgPmrKNNuoj/7nAFIZkbapxdrrgpcYr7hJ+Eye
         1a/KarSFgmBm+TW2yEM4Qu/SZU5gyVPQAjk8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691646292; x=1692251092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPy+GgB9Rn2CrQzZMkbpjUhP00w0ETOf0gW/R2Mixqg=;
        b=YE773ZhZgvSZgVZFb3F7phWbpQj52cnVhqBbXbu22xRj92FrttFGgVVndtfx9YAyf3
         XUnNtfOYszqgFfC/7UD7cHK6pTZhufC7/kv/76M6jpvim7KmSa8AccnFKfQVR/+LQi6H
         ukIhgZgFq6fQ/2utTat2IGbiH14pWw7xKLrlp0wwxzyewBNiSbtb7mHjSxRqrq7lmraP
         iFGAgJYXXGSlQl0hc2kq09A1DyaVA+xTy9ixege+k89ZX7ZW+Lra3XEBedRFcqICg4/3
         JPCoD0SBsT04AKU0l6Szjchb3YWjRgkZdMa5YBipYV1oHMWiG/VCb4z+V7ENaAdDEjRF
         ua7g==
X-Gm-Message-State: AOJu0YyTRMpOkaRoFQtU+l6cPAXXT6lp9blOmxUIcgSya/4bxkIzQ3Nz
        TpdrFYw9FG7CQwFGFKOEGZ97WHl7f+0/acL28gk=
X-Google-Smtp-Source: AGHT+IH2ClYHwnJ5alddiZq/1p4dh8kNUZsg9STgwYBQkHKdZGoTE1a0eQUDIwvolTjfC3J1oCOS9Q==
X-Received: by 2002:a05:6602:3308:b0:77e:249e:d84 with SMTP id b8-20020a056602330800b0077e249e0d84mr2053242ioz.5.1691646291767;
        Wed, 09 Aug 2023 22:44:51 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d89c5000000b007835686237asm259526iot.27.2023.08.09.22.44.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 22:44:50 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-78bb7b89cabso18341039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 22:44:49 -0700 (PDT)
X-Received: by 2002:a6b:5c03:0:b0:790:ff32:eb3 with SMTP id
 z3-20020a6b5c03000000b00790ff320eb3mr1894689ioh.17.1691646288713; Wed, 09 Aug
 2023 22:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230809181525.7561-1-jason-jh.lin@mediatek.com> <20230809181525.7561-6-jason-jh.lin@mediatek.com>
In-Reply-To: <20230809181525.7561-6-jason-jh.lin@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 10 Aug 2023 13:44:12 +0800
X-Gmail-Original-Message-ID: <CAC=S1njBP2uhAgz8MOm5jxHHPb5M8=UaH8powW2mCFjBWPp+FA@mail.gmail.com>
Message-ID: <CAC=S1njBP2uhAgz8MOm5jxHHPb5M8=UaH8powW2mCFjBWPp+FA@mail.gmail.com>
Subject: Re: [PATCH v9 5/7] drm/mediatek: Add connector dynamic selection
 capability for mt8188
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Nathan Lu <nathan.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 2:16=E2=80=AFAM Jason-JH.Lin <jason-jh.lin@mediatek=
.com> wrote:
>
> Add dynamic select available connector flow in mtk_drm_crtc_create()
> and mtk_drm_crtc_atomic_enable().
>
> In mtk_drm_crtc_create(), if there is a connector routes array in drm
> driver data, all components definded in the connector routes array will
> be checked and their encoder_index will be set.
>
> In mtk_drm_crtc_atomic_enable(), crtc will check its encoder_index to
> identify which componet in the connector routes array should append.
>
> Move DDP_COMPONENT_DP_INTF0 from mt8188_mtk_ddp_main array to a
> connector routes array called mt8188_mtk_ddp_main_routes to support
> dynamic selection capability for mt8188.
>
> Signed-off-by: Nancy Lin <nancy.lin@mediatek.com>
> Signed-off-by: Nathan Lu <nathan.lu@mediatek.com>
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Tested-by: Fei Shao <fshao@chromium.org>
