Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4307CDE0E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344820AbjJRN5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344798AbjJRN5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:57:36 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B404D13D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:57:31 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1e19cb7829bso4222536fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697637450; x=1698242250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBuadUMoZdX2+d4FKX3AvurIxVLVlW/YP0Lt3ncRpOc=;
        b=Nwr8ZZxXZ3UQ4UCDDDr9a30Pf6O+b+iJcq9fwvKBt8IwZbwpv2EtB2b4HDaOQwb8qM
         X1F2XnM1h4dTJfdat3XHU9o2oEYjCtejxrbVblBVaa31Uxz30mGDgKG9zTS54VU5b6nW
         yIV7VGvWq36Spt7WRnsfAaMpLV3aaC7V9Ma+XHyyBBqXrcURnN5BpMmQ8fXM8/8Vntli
         Q7qIHB+3JVGMwSq2DE3vmlZdElDji2lSantDMSWs2uWmV0zV0nS31jiRaU0B/geqnJwp
         6sOqts0ivkn8X+Z0qp3OgGLSOdIz9oc1yGke6Mv3VOpGSlf6EECSnmrdzrP3+xOvrRqU
         jEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697637450; x=1698242250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBuadUMoZdX2+d4FKX3AvurIxVLVlW/YP0Lt3ncRpOc=;
        b=J45dqEQtdJPPNoty82PtxiV5pOFy3MQO2sOadMTAeiniVWbUYuLXM42RvGDQwHkDwb
         i2gu2EdjnpLasry2Bg9FMETnnG7U5Z+BjJA2pV575CYHGzM3fnYylJnfei4mJDL05cCE
         EfFiQEajR4qkq1EO+znZu7kY/EkXVsS1yxqei83ZBGNrOM1UVGfi4ZNIcFBX2HGB8I0w
         90dyHyZBzQrIA1VBcWhOk92wxMcgjctN1TD0sKkYTWFkOwn9OaS4R9MMbTV2VBav4cWl
         8kQRmoBhNII1IXoYrzlql/DKxf+nvpzBUXbL9cj6cT5L7qY5mVMTJ0I/aoio67NxOvUU
         UPww==
X-Gm-Message-State: AOJu0YxHTodoJRCWnug1zG5HK5eAp9SrtkLeupoBT9ryqJi+x8eSm0OS
        +ng97Ku9bUehpd8kQH3g0LFjkUp+4EKPS0Xd9Ig=
X-Google-Smtp-Source: AGHT+IFF0o2PmNbSZo3TsClLBR+UztvtVKhytK8oRPSPGDQcKHK/7AQ70VgMMQwUEbUC1ToXvVKOIMh/JtBrqizqtvY=
X-Received: by 2002:a05:6870:3926:b0:1ea:746d:1703 with SMTP id
 b38-20020a056870392600b001ea746d1703mr6501624oap.7.1697637450690; Wed, 18 Oct
 2023 06:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231018010203.110189-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20231018010203.110189-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 18 Oct 2023 09:57:19 -0400
Message-ID: <CADnq5_OW4ZPV3Sm-8EC0QuVjA35tGtjN1SV4pLBnv1inU9umxQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Remove duplicated include in dce110_hwseq.c
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, harry.wentland@amd.com,
        airlied@gmail.com, daniel@ffwll.ch,
        Abaci Robot <abaci@linux.alibaba.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Oct 17, 2023 at 9:02=E2=80=AFPM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
>
> ./drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c: dce110_hwseq=
.h is included more than once.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D6897
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/=
drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> index 74602a5fd6dd..51e42cbb3cdb 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -65,8 +65,6 @@
>
>  #include "dcn10/dcn10_hwseq.h"
>
> -#include "dce110_hwseq.h"
> -
>  #define GAMMA_HW_POINTS_NUM 256
>
>  /*
> --
> 2.20.1.7.g153144c
>
