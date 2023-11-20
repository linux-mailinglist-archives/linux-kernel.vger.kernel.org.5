Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDED7F0EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjKTJQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjKTJQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:16:09 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C513B9;
        Mon, 20 Nov 2023 01:16:05 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so3780959276.0;
        Mon, 20 Nov 2023 01:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700471764; x=1701076564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpwOvzzEhozZ00SFHXEpmejOMEaeMFuJw7NXLVeDvN0=;
        b=BMe4TT7GeyVUaXK/zUrqC1giG57HOYo1BT7seqXWWcIJTuzyWI8a+pT6OaP2/bAidH
         Q2C4GrQMwWKFsckP7RCTEE8UDr9mcIbBzSBObnDUwphHWObgnVD+81fbRmpq0gVoJj2n
         3ZHnSFE/UaMCULDgm+aUMKNQvvLtDPTIdbclmeYCK3PnAYACb5feJxVxD5VHtcEnJ7eO
         2UJpRT7rRwi1iQWwJwaB5FINLXjcr27p3Gpw5R/nOh5KdVutRncZqCrwlhASxNjy5S4P
         ywhanJD6UshMMtO67+Jw86WYrfMwNrYiK9wOmH+6Yke8lz94kMHDUB3A2txCu/6sirtx
         eSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700471764; x=1701076564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpwOvzzEhozZ00SFHXEpmejOMEaeMFuJw7NXLVeDvN0=;
        b=gHVY8whAoezf7bpSLdaPM9A7UzzwPER9TcbA5XP4BZa5ltMv7deQzVV36qixY8G/TW
         Vl4reCJpd0tQXYNcolmOEad/dSOprv6dKhoJu5NquXGpwTNqPlw+iZHhoJlDYCmUprkq
         7JNLU/wLIN5u1Ea2migpKbG9QhcozOl1YVxq4t+Sr+WRbnPmqHdIZXfvmm4q5bOFPBKj
         LEfQltLl6xDR3Myocgq9MjFD6mBR5M4gXWfmplHat8eKQWDhZuUgkIBeuL5jHayKZskX
         KLLo/sv+uZZmqq7GlYPoedoScVgb0HkL3k/DYd00gSGvkWvvcCdevm6EGwRhZUnao5R0
         k8Nw==
X-Gm-Message-State: AOJu0Yym3nxcnLTIspMl70K9bCbD2k+5CqSCCS8U4plSoVHgTPFuMUub
        wPWufQ271Luj3c45BT3N7kbyAEg0iixPJUbcNi4=
X-Google-Smtp-Source: AGHT+IHQZdFmExncdM9w92IhRdz9hY7vAbs09uTd8RTDMHe6yfQhLY+Jt6pDbPzwWpTI/d6kO1raiNKHVl+oY27Gx6U=
X-Received: by 2002:a05:6902:4e6:b0:da3:b87b:5b7c with SMTP id
 w6-20020a05690204e600b00da3b87b5b7cmr5863456ybs.38.1700471764148; Mon, 20 Nov
 2023 01:16:04 -0800 (PST)
MIME-Version: 1.0
References: <20231119104514.25536-1-tanure@linux.com>
In-Reply-To: <20231119104514.25536-1-tanure@linux.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 20 Nov 2023 17:15:52 +0800
Message-ID: <CAA+D8ANMZd1xT2nyNskaroz-X0pDTv2fCSPxKc+H4R2RS3FRCw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_mqs: Remove duplicate linux/of.h header
To:     Lucas Tanure <tanure@linux.com>
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sun, Nov 19, 2023 at 6:45=E2=80=AFPM Lucas Tanure <tanure@linux.com> wro=
te:
>
> Remove linux/of.h as is included more than once.
> Reported by make includecheck.
>
> Signed-off-by: Lucas Tanure <tanure@linux.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

best regards
Wang shengjiu
> ---
>  sound/soc/fsl/fsl_mqs.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
> index f2d74ec05cdf..86704ba5f6f0 100644
> --- a/sound/soc/fsl/fsl_mqs.c
> +++ b/sound/soc/fsl/fsl_mqs.c
> @@ -10,7 +10,6 @@
>  #include <linux/moduleparam.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
> -#include <linux/of.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
>  #include <linux/pm.h>
> --
> 2.42.1
>
