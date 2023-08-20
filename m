Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18BA781C1F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 04:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjHTCmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 22:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjHTCmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 22:42:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CFE6F6B6;
        Sat, 19 Aug 2023 18:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70B12610FB;
        Sun, 20 Aug 2023 01:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BF9C433C8;
        Sun, 20 Aug 2023 01:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692494854;
        bh=rGHXKl7d7hc+MScJBmR93+78PNaEoYTZ7ZZkoFXRR74=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ps0ShGPt5Hb/g/plKJczhVZhCQE6haTIRM4vRSroaIToQcaRuPfnQfxLKxzyjd33t
         YLaI5HhFcM8UEcRbKL030iBwjD1IqY0BGUeoGRw4g0ZrjahP7wqjpRSOzVBY+B3KlM
         Bqv90T+4awHAimXSIlTF5Sswu8h5gycwgAPOCTBavdNprmLamTsafvyuGRLrl2u98Z
         dOwI3PNp9YvCUDa3iNk124h1Vv6BSgHToReCXQezj7bwELY2fg2esoFchz77EYgPTc
         zOVi1aff2aoZ48MOf7SKAGXCs/tcl0U1qJI5ePnEbNyZpC3YOaHLJALf8//Qg411nL
         WDrHmPtQqBOcQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1c52dbc300bso1312957fac.2;
        Sat, 19 Aug 2023 18:27:34 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz2VPIkszpbjLSh4+HwaU1GPUyb4m60R97eHOkWOTgINF6sy39g
        7ads49t2D0PzLL1KwQPv88sKHlNMCH05JgYKUSI=
X-Google-Smtp-Source: AGHT+IHsTFKullMv6NpUecq6ISPm/F8b5FxJ+gAG5fHYEV8j3VuY8VfPsa2Adt/9YY/pJO6tpk47BamZEiVhCA+GzrQ=
X-Received: by 2002:a05:6870:d250:b0:1bb:753d:e6db with SMTP id
 h16-20020a056870d25000b001bb753de6dbmr4341954oac.3.1692494853990; Sat, 19 Aug
 2023 18:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230816062219.1086685-1-nicolas@fjasle.eu>
In-Reply-To: <20230816062219.1086685-1-nicolas@fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 20 Aug 2023 10:26:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNATa6gf9FP9=Yh9YyBb+5Gf+Y3skLP5+8DXXbDSB-2Khng@mail.gmail.com>
Message-ID: <CAK7LNATa6gf9FP9=Yh9YyBb+5Gf+Y3skLP5+8DXXbDSB-2Khng@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add usr/ (initramfs generation) to KBUILD
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Nicolas Schier <n.schier@avm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 10:40=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu>=
 wrote:
>
> From: Nicolas Schier <n.schier@avm.de>
>
> Add scripts for generating initramfs to KBUILD, to prevent idling of
> patches for usr/.
>
> Signed-off-by: Nicolas Schier <n.schier@avm.de>
> ---
>  MAINTAINERS | 1 +


Applied to linux-kbuild.
Thanks.


>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d516295978a4..eff293e8d3bf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11296,6 +11296,7 @@ F:      scripts/dummy-tools/
>  F:     scripts/mk*
>  F:     scripts/mod/
>  F:     scripts/package/
> +F:     usr/
>
>  KERNEL HARDENING (not covered by other areas)
>  M:     Kees Cook <keescook@chromium.org>
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada
