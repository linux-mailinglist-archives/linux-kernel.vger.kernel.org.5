Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD028091E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443819AbjLGTv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGTvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:51:25 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5C310EF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:51:32 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a1915034144so179500966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 11:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701978690; x=1702583490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyNxMC5UaWA8P1oAZwMgXZGctvwxcnYFcLUj2/+v4A4=;
        b=sMeoIOB5zF8VMBBfBEWvh0cLeRB+50UV9taV/QDpYmqujSA9LYTaOO/5TPsPq9ZFY3
         CIfT0BAwYLrD3IUNCpNgUQaQ/MwCDGupoWz4ICeTNr38J4ujtAVf7+UXWkeWlbIBVZhO
         v0TESlTagtGV6ZdCroVkobHBea9Sy+SuygbS8V1gzylltOxGLsbE1TKq2GH92xccvf+7
         sas/szFF5Rx4anesbQEbnZ/dWQ72huVherJpuTgVe+yzW5SaIJqX1KdLUoSO8MsNq1yC
         OUSPVjhFgruiUL1lfO/ZkbD/GVCcz45ni2TEp/HliCKSrVxvt0Uk7pjGkOY1paZ7b6is
         gw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701978690; x=1702583490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyNxMC5UaWA8P1oAZwMgXZGctvwxcnYFcLUj2/+v4A4=;
        b=ej0bzhGf8JWnMOhSVa0A/6va3qNtasjA+ySbUjJRpaQF8RsJJaP9/RkM5bCR6UbdqX
         gLmuWciZvqiGZG4KPq/3+U2rzINYWs2sEKtH491m9YFwHH7AGvvQ4jVLyjWifeE2tkxx
         2CgqAVk/z0tKfYAe+L3w3AqLCwb1stcrQkDelrPSnvJjoKMSJD1rFcfERvN6qkzAQ647
         Vbea611Aj2xdT5UYwHvOCMOvTtptQLOR54XdhPIdkaAIWEm9jzTpQ4FNVvOfEkRollMt
         2owzeEMbGC7l1bm2B+rrQCRLaB9AIY6SNerqJDB9GBHygxJYaEiZVm03s+MZ1p0rOBVK
         aAHw==
X-Gm-Message-State: AOJu0YwQYuamwG9nvPqMbBWeQP2OdwWwifm4YKs1osXTD+HL5lyrlTIM
        HzNYoYFnP7rjkgefojxnm6CJbKDaxOFe/fbts1cBL4o/c5kZDy1OAqo=
X-Google-Smtp-Source: AGHT+IHn6Gpxs0pG2yGvus7gTfzV0S7QzvF4q0Z2d5XIfpkMDbFezPPz4AmGj5WO8CtAkKxxm4NQ+Hh/9bolotTv8wE=
X-Received: by 2002:a17:906:f2cf:b0:a1b:e80a:b68 with SMTP id
 gz15-20020a170906f2cf00b00a1be80a0b68mr1854717ejb.143.1701978690497; Thu, 07
 Dec 2023 11:51:30 -0800 (PST)
MIME-Version: 1.0
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
 <170138159609.3648803.17052375712894034660.b4-ty@chromium.org>
 <20231130224021.41d1d453@kernel.org> <202312011018.478B0E750@keescook>
In-Reply-To: <202312011018.478B0E750@keescook>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 7 Dec 2023 11:51:18 -0800
Message-ID: <CAFhGd8pT=QoTaPAzH+NPzu=i1i9oX_7wcP6X1_aDDTJ0vUssmQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_strings()
To:     Kees Cook <keescook@chromium.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 10:19=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Thu, Nov 30, 2023 at 10:40:21PM -0800, Jakub Kicinski wrote:
> > On Thu, 30 Nov 2023 13:59:58 -0800 Kees Cook wrote:
> > > Applied to for-next/hardening, thanks!
> > >
> > > [1/1] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_string=
s()
> > >       https://git.kernel.org/kees/c/f1c7720549bf
> >
> > Please drop this, it got changes requested on our end because
> > I figured Alexander's comment is worth addressing.
>
> Done. Justin, can you please refresh this patch (or, actually, make sure
> the ethtool_puts() series lands?)

Yeah, let's let this patch die. The ethtool_puts() is on v5 and is
getting good reviewed-by's. I suspect it
will be in soon. Then I'll double back and do right by the intent of this p=
atch.

>
> --
> Kees Cook

Justin
