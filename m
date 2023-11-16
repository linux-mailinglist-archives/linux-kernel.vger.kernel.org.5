Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D4E7EDF80
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345141AbjKPLTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345115AbjKPLTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:19:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A24A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:19:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63285C433C8;
        Thu, 16 Nov 2023 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700133587;
        bh=sVE1ZhzgF+azIDjaftC09+KcqFN6b/NyebhVcP3716U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pIX94orK0kXxh1o6FUN7miEOMvbCikG2L6fD47MqChba1soczCS4jplycsG0sIWn5
         wlxUJLoYG/LkBnX7yrwdGJIlbten+wPkUWGmKkVCxj6fyIaQBGyUNLRlIqEfiNENU9
         s/tkAHNDhhboJWuPPJa/rl9mjLnwCQ9InX1WA8udM6LQPeBC15vdECGAuGVMh1SVs6
         jR5B0xv2P9dP+So1iJUBCKZf8V/FlvWvS8v9zMnIZWENLOk96Df29YUGkNKIadYX5H
         +e58XhFLNinm99TLcZpnUMyw3tHYUFydHafmDHbqlqTTEYKFeuTvOpDs7VOg9sVEG1
         ISzA0zgGhWELw==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b2e73a17a0so378694b6e.3;
        Thu, 16 Nov 2023 03:19:47 -0800 (PST)
X-Gm-Message-State: AOJu0YyzudoRS9Sq97S+OYp/pBq0202oo2WN/oKdz9wvoXU0BC0yalP2
        3mEh8HUVO7+UVQo0mZL2+r/T/HGdNw44jq7s3Fw=
X-Google-Smtp-Source: AGHT+IG5EHn9aQcDgToPoaTjqqvcP1a1M4t+aOZpOsigb6MoTuHcsgwxABvfoX/iZim1ptpeZmWNZZ2Q2xY3URFCfWs=
X-Received: by 2002:a05:6871:a508:b0:1e9:9989:33a5 with SMTP id
 wc8-20020a056871a50800b001e9998933a5mr18170787oab.5.1700133586781; Thu, 16
 Nov 2023 03:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20231111002851.1293891-1-sjg@chromium.org> <20231111002851.1293891-3-sjg@chromium.org>
In-Reply-To: <20231111002851.1293891-3-sjg@chromium.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 16 Nov 2023 20:19:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQN_qGYztWGDmQyfg+eZ5P7RkM47mpgp0dQn_iuhvTSWg@mail.gmail.com>
Message-ID: <CAK7LNAQN_qGYztWGDmQyfg+eZ5P7RkM47mpgp0dQn_iuhvTSWg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] arm: boot: Move the single quotes for image name
To:     Simon Glass <sjg@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Rini <trini@konsulko.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 9:29=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Add quotes where UIMAGE_NAME is used, rather than where it is defined.
> This allows the UIMAGE_NAME variable to be set by the user.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---


I applied this to linux-kbuild/fixes.

I changed the subject to
"kbuild: Move the single quotes for image name"
because it is unrelated to arm.


Thanks.



> (no changes since v4)
>
> Changes in v4:
> - Add a patch to move the single quotes for image name
>
>  scripts/Makefile.lib | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 68d0134bdbf9..1a965fe68e01 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -487,14 +487,14 @@ UIMAGE_OPTS-y ?=3D
>  UIMAGE_TYPE ?=3D kernel
>  UIMAGE_LOADADDR ?=3D arch_must_set_this
>  UIMAGE_ENTRYADDR ?=3D $(UIMAGE_LOADADDR)
> -UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> +UIMAGE_NAME ?=3D Linux-$(KERNELRELEASE)
>
>  quiet_cmd_uimage =3D UIMAGE  $@
>        cmd_uimage =3D $(BASH) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
>                         -C $(UIMAGE_COMPRESSION) $(UIMAGE_OPTS-y) \
>                         -T $(UIMAGE_TYPE) \
>                         -a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
> -                       -n $(UIMAGE_NAME) -d $< $@
> +                       -n '$(UIMAGE_NAME)' -d $< $@
>
>  # XZ
>  # ----------------------------------------------------------------------=
-----
> --
> 2.42.0.869.gea05f2083d-goog
>


--
Best Regards

Masahiro Yamada
