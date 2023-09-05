Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B2E792D2A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbjIESM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238023AbjIESML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:12:11 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4CC3B079
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 10:42:04 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1d1b55882a4so2214425fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 10:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693935316; x=1694540116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FxvOTJzHccsnhfhevNC+D3OUgDvfnGXsp9yKozqb5M=;
        b=e0WV3eOK4lVk/8ZxTYbe+Db0Eu/SaFL9ueyHYuKdIGjHM0Io7M+Q3C7jUBFyaT/k2w
         ibHVwCUSpJc/ClyG7GuoDq5Het365gDwPEVO3jYB71kyYLKpg/vRZts3+NdlhYofX7dv
         i2n8ZFIbfVYMD4Q18AUW6NODX45EEc3yG8adOM1JHwvMSILas+MGgKm3j79Sugd5PJUK
         o48hZFEBaXJ9wvc40HngTZy2++/z2MOtC8+/HMhcCdolkR/NyKcWcyC+uk/8i3ZcKASv
         OadunJ4UBI8Jfcwmasel3Cup+2hLDygrL+0w3G+mWB3aE0wvxEzFPWVuPlGyQjyk00iG
         ZWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693935316; x=1694540116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FxvOTJzHccsnhfhevNC+D3OUgDvfnGXsp9yKozqb5M=;
        b=TMtXPFW6FCXWZ5YEHd3IuFQeo6SQbU/yLdYD/vGp9c2nm1JqRZfsK/omfoAkqTEFbW
         lhG1syRauy3577D7SSceFmQoj3zHzJgCK2CCNlSnw03eGAihBgb4iyb1y2+4cjjCoRBH
         pWc1HLEgE6zjnU9JJe7XkZ7sFUfijnXuY+96WC8i99122VKUG72cCXbLXNBDooJgK3T/
         5t8EUuNCzk2TwO3Xmq1qobhFW+trXsWyOcLC6CPabgG6e8abIVR+f9UwMc2n6NLZzDYi
         GHm9M+WwsZ7IZdIc8+bNL1oR1NXik5tvNv5vFE5SmanXgIY3SGgB2Wt7vJE9bnu08rKG
         fLIQ==
X-Gm-Message-State: AOJu0Yz7GFO7mx5j2y8bRlxjUomqt/NA/W2971UBPcZ7DLVMiQ1DTnuY
        wXwOZKpdycrtLnw1edmP7Ovm2d11jZVlyPu9Qor7t00W
X-Google-Smtp-Source: AGHT+IEULyA+SzmXMwXkfPZCbstLoINn2mglghTj/XDz8SKyIT1T4Pyv/4f9TM42hUyyoY8z/R2O0qI3j3HONe8VagU=
X-Received: by 2002:a05:6871:a718:b0:1c8:baa5:a50f with SMTP id
 wi24-20020a056871a71800b001c8baa5a50fmr13904768oab.27.1693935316680; Tue, 05
 Sep 2023 10:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230901005226.42307-1-yang.lee@linux.alibaba.com> <20230901005226.42307-4-yang.lee@linux.alibaba.com>
In-Reply-To: <20230901005226.42307-4-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Sep 2023 13:35:05 -0400
Message-ID: <CADnq5_NnozGnxsrok+ne=WHWJPG82+sXu-+DP6bqJXt4p-hRdg@mail.gmail.com>
Subject: Re: [PATCH -next 4/4] drm/amd/display: Remove duplicated include in dcn35_clk_mgr.c
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
        harry.wentland@amd.com, christian.koenig@amd.com,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Thu, Aug 31, 2023 at 8:52=E2=80=AFPM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
>
> ./drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c: dcn35_clk=
_mgr.h is included more than once.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c=
 b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
> index 3b2463c03694..9314e75195cd 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
> @@ -46,7 +46,6 @@
>  /* TODO: remove this include once we ported over remaining clk mgr funct=
ions*/
>  #include "dcn30/dcn30_clk_mgr.h"
>  #include "dcn31/dcn31_clk_mgr.h"
> -#include "dcn35_clk_mgr.h"
>
>  #include "dc_dmub_srv.h"
>  #include "link.h"
> --
> 2.20.1.7.g153144c
>
