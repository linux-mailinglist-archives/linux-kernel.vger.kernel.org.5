Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB90776FA8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjHJFhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHJFhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:37:32 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F9110C0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 22:37:32 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bca66e6c44so555484a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 22:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691645851; x=1692250651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UFdkTxk/r2phv46cParOTF4SmxA+o425ukdUTiBx2M=;
        b=DMDrrjz48RQUTigBcy/4yyYJ6If7zVm2CNzlAg57CmNwk6NZgDZxnuybDHLEkM7MIy
         +1FDHpRLPFY7l/FcWtOXz+8TIlxqOE/+cHkjD5vm1wWnHX+26FISqokFi/q/Obaym1q1
         zj47QsX4atiCaDO/hYEE+WKe6UYdn5v4Ai1HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691645851; x=1692250651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UFdkTxk/r2phv46cParOTF4SmxA+o425ukdUTiBx2M=;
        b=eGFnlrsJGeYOs+KYSw9/52kDf6xrje1SIkABFT0+Y6urmH0r2RqlqnrnFjv9P+Ev/M
         F0ZydRJEMoj4vWc2kzwD4PBSzbWG88adVKiVQqTrHFPVjJXLBORlbcpvqLU7S/pBBB0V
         EMgjbQkzMZlf1GtsDv7+bmRJ7XQRzpXanThdskITWiO0g8jAAWS8VvHRdG9VOfvdPyvP
         b2YWSPDTUuPrNJl1KRLdcyLdymwZ8bXpXX+Q2s6Q/EftHLMN2GKOfWeqvQHUw7myHdDo
         Lsl8YT/YxBYFx0950VA9hMZXlmLG3EWK2BCb5VVbdiFvih1JSg/qS3X0GvnSnjRZQf91
         YdXw==
X-Gm-Message-State: AOJu0Yx0S42FpVZohuklCxTEpAkjo9aS7ZumAtuTMsVNHVTld2nP9qSU
        Hg0x8EH+U5sNJJ+7DyOUAhXRh1OCjYSCli3LC7k=
X-Google-Smtp-Source: AGHT+IFl40r3s8KJBWEEraDDuadcyet01dHwVFwkUzjfETQoyZvWzkfHlFA0ZJm4NcShw2zvX4wUdw==
X-Received: by 2002:a05:6870:6193:b0:1bf:a95:7a3f with SMTP id a19-20020a056870619300b001bf0a957a3fmr1677371oah.54.1691645851696;
        Wed, 09 Aug 2023 22:37:31 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id g15-20020a0566380c4f00b0042b5423f021sm195054jal.54.2023.08.09.22.37.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 22:37:31 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7909808a504so18188239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 22:37:31 -0700 (PDT)
X-Received: by 2002:a6b:f00a:0:b0:780:ce72:ac55 with SMTP id
 w10-20020a6bf00a000000b00780ce72ac55mr2466455ioc.10.1691645851246; Wed, 09
 Aug 2023 22:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230809181525.7561-1-jason-jh.lin@mediatek.com> <20230809181525.7561-4-jason-jh.lin@mediatek.com>
In-Reply-To: <20230809181525.7561-4-jason-jh.lin@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 10 Aug 2023 13:36:55 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhi6Tk31a2wayVybcBdmE=wngawzoaz8B-4L9UXpqzD3Q@mail.gmail.com>
Message-ID: <CAC=S1nhi6Tk31a2wayVybcBdmE=wngawzoaz8B-4L9UXpqzD3Q@mail.gmail.com>
Subject: Re: [PATCH v9 3/7] drm/mediatek: Fix using wrong drm private data to
 bind mediatek-drm
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
        Project_Global_Chrome_Upstream_Group@mediatek.com
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

On Thu, Aug 10, 2023 at 2:15=E2=80=AFAM Jason-JH.Lin <jason-jh.lin@mediatek=
.com> wrote:
>
> According to mtk_drm_kms_init(), the all_drm_private array in each
> drm private data stores all drm private data in display path order.
>
> In mtk_drm_get_all_drm_priv(), each element in all_drm_priv should have o=
ne
> display path private data, such as:
> all_drm_priv[CRTC_MAIN] should only have main_path data
> all_drm_priv[CRTC_EXT] should only have ext_path data
> all_drm_priv[CRTC_THIRD] should only have third_path data
>
> So we need to add the length checking for each display path before
> assigning their drm private data into all_drm_priv array.
>
> Then the all_drm_private array in each drm private data needs to be
> assigned in their display path order.
>
> Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 multi =
mmsys support")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

Tested-by: Fei Shao <fshao@chromium.org>
