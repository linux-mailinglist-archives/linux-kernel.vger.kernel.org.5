Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9695A7F0705
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 16:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjKSPDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 10:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjKSPDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 10:03:52 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78747129
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 07:03:48 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9d267605ceeso467311866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 07:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700406227; x=1701011027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhgRPtKLHKyCASHu64uGyNWJNnaZJqXUqiVwYsPYYoU=;
        b=NZgvpYRW8YZncxiKBMikj8AV7NDU1UQkrq/yFlrg9obMLjl8cPTpyICwk+WJ4o1r2Z
         J4I69qV7Z+u44pMyq+PdpUH2LdiisV3aEHD+ke8Cra6fWzHeiJiGC0u5Z8cp35rUIgqJ
         b+kQ31hCbHxVILgScPhO9GmIOyszTAZRJGzyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700406227; x=1701011027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhgRPtKLHKyCASHu64uGyNWJNnaZJqXUqiVwYsPYYoU=;
        b=SYo/shEx6TNkWTmr5+lgJ23OTns6rfEJLGPTk1fvP5RuJYcTs/HU3B0Kg48gLXwHDE
         c4H0tIr6SWJCrbNfgNvGI26tW03icU+/eHwlSGvGhILHMhs+lMOmjdLJuxRe5vsaOa7q
         2tn7FljU7x3GDCzCYPkvXe2p7nQHZSij6Ro0zmzkLY0qwSzephPtPy1bh9ro/V0rQtY4
         9XVsswpUJ23zQlkUYL7hFIcmOLBjde298gR0jVm7lbAB9+Pl074KhvAA/IYOyp2HHxRG
         QnvaVELv0X8Ty3tuLurMFiyg+8ZBilDp7YOR1LlxqNvbz2lxY+Qkl9puwq7+wRYPWJ6P
         HBNQ==
X-Gm-Message-State: AOJu0YyKbIohCt+aPmckNgKd2h9oNtelgqizZermxKxvWCpRRaNqTbPJ
        BeYITlmzSv194nQaSn8LnQ3Z323+wba58+zrM7Cx+g==
X-Google-Smtp-Source: AGHT+IGzFEU8YWTTy6VrQtmHjiot+wlxwXCg5vwgI/KdLmFFd5niB+Mx16ggwlizicPuNRRu/BhQLB81+rZ1kcxVG90=
X-Received: by 2002:a17:906:2ce:b0:9da:e694:e6a2 with SMTP id
 14-20020a17090602ce00b009dae694e6a2mr2846142ejk.4.1700406226754; Sun, 19 Nov
 2023 07:03:46 -0800 (PST)
MIME-Version: 1.0
References: <20231111002851.1293891-1-sjg@chromium.org> <20231111002851.1293891-3-sjg@chromium.org>
 <CAK7LNAQN_qGYztWGDmQyfg+eZ5P7RkM47mpgp0dQn_iuhvTSWg@mail.gmail.com>
In-Reply-To: <CAK7LNAQN_qGYztWGDmQyfg+eZ5P7RkM47mpgp0dQn_iuhvTSWg@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Sun, 19 Nov 2023 08:03:35 -0700
Message-ID: <CAPnjgZ12nzMmpqJ5-=TzY+Dxu=4keFbJAB+RU99FqxKZfxjNUg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] arm: boot: Move the single quotes for image name
To:     Masahiro Yamada <masahiroy@kernel.org>
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
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Thu, 16 Nov 2023 at 04:19, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Nov 11, 2023 at 9:29=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Add quotes where UIMAGE_NAME is used, rather than where it is defined.
> > This allows the UIMAGE_NAME variable to be set by the user.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
>
>
> I applied this to linux-kbuild/fixes.
>
> I changed the subject to
> "kbuild: Move the single quotes for image name"
> because it is unrelated to arm.
>
>
> Thanks.

Thank you. I sent a v6 with a fix and without this patch.

Regards,
Simon
