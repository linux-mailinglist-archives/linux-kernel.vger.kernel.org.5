Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D1076C626
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjHBHNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjHBHM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:12:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430F318D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:12:57 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68730bafa6bso406564b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 00:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690960377; x=1691565177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjxrCLS3cadHatyI0X73qAxEEIoqBtkiSqn6zI48PFU=;
        b=qtEEl1wWBPiXWXTuEIEBv7RZq11mEMXySpGXNhrEJov+ENEjlslfHzDaZO8BGLhlET
         IfqsdtoCbaiiyZrnbLedqJWvnCqNDNgrp7gxgIpSOlznlKmKAytWlfuxVu+g9+ceywM5
         fCghSUNp0w/dxO/SfQk8ktDqtyKd5LBJcNXBQ9S9rhJJ1QU3NyphcHwlcxT4gMpoHZBw
         Oy3WB6DNdl+s64AunvIll966F/KIyu6pOmp0fv4nwjkrETLG+vNloKtMb5kUWl5+0IvN
         fFEGXXnotoE4LW6N1jXQNbOxrB6HD5acYFZRLk/EEv5v8bz9PwNt9t6Oq8Z8Gs1XTooR
         pCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690960377; x=1691565177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjxrCLS3cadHatyI0X73qAxEEIoqBtkiSqn6zI48PFU=;
        b=KTR7XW2olzqaffwtgpFc9Qmlfj9g0774VaFabgOgIXzmu+/Xs2Q3SUeiUfwisnVIaF
         BsRoVG4dNGWD+GaG0YKxRV6MScytUbX4da1aEXbOC0NvLn7dUsvvWKmgDpp+vDH8A/s+
         CsUJuDYYlD/btWOwdJiXWrHS5jMlu4u+2Mpj4fb+dwwY21no8AYYG4GMsQxaZXUyvIUL
         zlJhWMOB93TjdzENnVgg0TTlQDi/C2ytNItPtp5uLhs3/UtPLSTt4xkvZOZ5wa7cPbEm
         Q0+srvQp6JPomwTkWWt4/86pYTiC0w8TLvftpFh1ypL//tmDcLipryRp3BydWvKQjP0B
         NIYQ==
X-Gm-Message-State: ABy/qLYgSYh6QIVzNhpQJPqOaJh4cLIFVx2EVxuzP3SxUaCjNx9D9Ap6
        C374iB3NQPP9Z1H+Bah58hJQasm3Zx4WSlnOgZw=
X-Google-Smtp-Source: APBJJlHC33MnC4vHRx9ZtDX9wNMk14xZ7mUaL2MW/X8yj9rXRade2j8zWGlUChySW6lC5l5SeDS9LuM99w88FSG53fI=
X-Received: by 2002:a17:90a:e602:b0:268:220a:7080 with SMTP id
 j2-20020a17090ae60200b00268220a7080mr18220320pjy.2.1690960376616; Wed, 02 Aug
 2023 00:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230802052117.1293029-1-chancel.liu@nxp.com>
In-Reply-To: <20230802052117.1293029-1-chancel.liu@nxp.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 2 Aug 2023 15:12:45 +0800
Message-ID: <CAA+D8AMY=EG8SYFOb9wmoBcr19qqhMpw9OsTB6nf119G6Li_3w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Update the register list of MICFIL
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 1:21=E2=80=AFPM Chancel Liu <chancel.liu@nxp.com> wr=
ote:
>
> MICFIL IP is upgraded on i.MX93 platform. Add new registers and new bit
> definition.
>
> changes in v2:
> - rename check_version to use_verid to make it more explicit
> - rename fsl_micfil_check_version to fsl_micfil_use_verid
>
>
> Chancel Liu (3):
>   ASoC: fsl_micfil: Add new registers and new bit definition
>   ASoC: fsl_micfil: Add fsl_micfil_use_verid function
>   ASoC: fsl_micfil: Use SET_SYSTEM_SLEEP_PM_OPS to simplify PM
>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Wang Shengjiu

>  sound/soc/fsl/fsl_micfil.c | 100 ++++++++++++++++++++++++++++++-------
>  sound/soc/fsl/fsl_micfil.h |  64 ++++++++++++++++++++++++
>  2 files changed, 146 insertions(+), 18 deletions(-)
>
> --
> 2.25.1
>
