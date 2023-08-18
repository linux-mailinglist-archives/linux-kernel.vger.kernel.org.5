Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADDA7806E6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358458AbjHRIKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358468AbjHRIKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:10:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAFF2D5D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:10:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c353a395cso75653266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692346199; x=1692950999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiCIlvzYwG8n2+vbOKpLaC5KHQFHrRqdS+H+uHcY65o=;
        b=FKizvyWxGCpW/H/vrdKQd2nS32cwS6WSvNkpzqNLgayFdeRm9QSzeK6pUBfXV6rqgx
         dN8Gv+BvSHU1LzW9bkVPKZ/8ylO8VWYxQijqt29SSFlpY+IayPcjjz7ynHdEPZ6LpIWu
         Kixti0qeC3lk/D78sItLGCvhuf4Hmg8GYX7+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692346199; x=1692950999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiCIlvzYwG8n2+vbOKpLaC5KHQFHrRqdS+H+uHcY65o=;
        b=Vb93cMVYuLdBxkKZDj4Q2Tz26SlmNFt3oM4QNRW3DMM78BW6b4BoMyBFScl/tKMWPH
         uMS2qfVjNA0voQFR+H4HcX1FGJjAQaKghUIWFl17ECRuHW7/NMV84RcvCApmxfkNWbOz
         /Q8P5/0hHhslmLwoOJKj+YGnyCMKpLeZHbksS8nif74nxO30Y5CZW62N+Z8bNn+7UMKb
         4kBRX7Pb7Nu5hRnv/IliTD/H1yIF9tHGBgqo2viYUrX/cAdmFHboO46BgdUE2cTnoSIE
         D0UKXJWp4MW5/hxjJbIDVNvq7g0TgkEGIdVtfSNuZwrJCROhPax+iORW6EfXC65mxuGq
         CEMg==
X-Gm-Message-State: AOJu0Yw9iBoEH4JA3LrC5smNM3dv0Urv5hlNBDB4KFPIb3c5emdHriSu
        nofTkZ9o3rNPnj45zfsDcC8LkWd2v9DEVmorKsooqw==
X-Google-Smtp-Source: AGHT+IHhHaWV8VPkDdHGpDW7e/LMy8Idy0xiBGsivuqTR6JgnonnBkUxU3FGAYfwaNz2XYy1So21kA==
X-Received: by 2002:a17:907:2717:b0:9a1:688f:cf2d with SMTP id w23-20020a170907271700b009a1688fcf2dmr125850ejk.39.1692346199417;
        Fri, 18 Aug 2023 01:09:59 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906125000b0098e16f8c198sm905071eja.18.2023.08.18.01.09.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 01:09:58 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so8229a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:09:58 -0700 (PDT)
X-Received: by 2002:a50:874f:0:b0:523:bdc9:48a9 with SMTP id
 15-20020a50874f000000b00523bdc948a9mr79606edv.0.1692346198340; Fri, 18 Aug
 2023 01:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230509004729.3941096-1-brpol@chromium.org>
In-Reply-To: <20230509004729.3941096-1-brpol@chromium.org>
From:   Brandon Ross Pollack <brpol@chromium.org>
Date:   Fri, 18 Aug 2023 17:09:46 +0900
X-Gmail-Original-Message-ID: <CALWYx-aJi0c_yZYUci33_AJb82tKfyuwSi3C4_uP+=FZygjFHg@mail.gmail.com>
Message-ID: <CALWYx-aJi0c_yZYUci33_AJb82tKfyuwSi3C4_uP+=FZygjFHg@mail.gmail.com>
Subject: Re: [PATCH v3] .gitignore: Ignore smatch generated files
To:     linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, masahiroy@kernel.org, ojeda@kernel.org,
        alex.gaynor@gmail.com, keescook@chromium.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 9:47=E2=80=AFAM Brandon Pollack <brpol@chromium.org>=
 wrote:
>
> The Smatch static checker creates some data files in the kernel root
> directory.  Add them to the .gitignore file so that no one accidentally
> commits them.
>
> Signed-off-by: Brandon Pollack <brpol@chromium.org>
>
> ---
> v3: Rewrote a more descriptive commit message and removed "change-id" jun=
k
> v2: Removed trinity stuff
>
> New to development and looking for tasks to work on to get familiar with
> code, I noticed smatch generates some files at the root.  Since this
> tool seems frequent for newbies like myself I thought it would be worth
> getting rid of the chance of accidentally committing these files.
> ---
>  .gitignore | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index 47229f98b327..fd8572cb7db7 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -171,3 +171,10 @@ sphinx_*/
>
>  # Rust analyzer configuration
>  /rust-project.json
> +
> +# Smatch tree outputs
> +smatch_compile.warns
> +smatch_db.sqlite
> +smatch_warns.txt
> +smatch_warns.txt.caller_info
> +smatch_warns.txt.sql
> --
> 2.40.1.521.gf1e218fcd8-goog
>
