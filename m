Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E8F774445
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbjHHSQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbjHHSQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:16:03 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285DF1F439
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:22:34 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-63cfd6e3835so34086516d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691515353; x=1692120153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QToAetuOKqk6KlcwFnxlW4pv9tJbYlRSUo8zVZOIBoo=;
        b=x3+okNrHxwteJVxE9P7xvlSvMXSMSfFQLXfreCFLO+KwUMB1ZcLkHHWvsw8C1crZfi
         94/Wv7lhK1/n5VulvtHVY0DXE3MdbInnralMazMsyNkQDLoupBzwQrKVvYxj5pWCPA2+
         WooLZaDnpKfes/b0/A19G1uhHVaDc6CtW3H8qRJQbZD/TSJWWVeoMtgCgplEmW8gs49P
         W3K3dooGHhgco6o69EVttAFhlfEznGqM92TBQQtIVdGvnekAS6qEq1nOM0ZLwHCthmHf
         2OSXnBlD1FDXktBAf9BSUKU7BeBPbN/XWswa9E1b+ewibdmiaCVyqIksW5wmwYo85QZt
         EFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515353; x=1692120153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QToAetuOKqk6KlcwFnxlW4pv9tJbYlRSUo8zVZOIBoo=;
        b=ay2pvaigFo16j8Pi6Fv2olKHpf0ePUbJWKE35ws3tT7AWHAWa9UqKVI5trDfaA6z+Y
         WLaSqKGAa9sgrR2CZpEFkFbM9j9fBWISbNmny00kZei5JMeiPJUrJ+QhZVX5Cpqy1CJ4
         Lb2O9mvHb/WV2l52NXnAuBdZ1O/sIcCpWYv7RrtHIO1X9YGrV8Wdb7O7dWjO5Jsle3Cw
         4V8NUq2HAosTzEvbziL3wjxZ9k1C4/EE8RHJMWFlQD0Dky404Qz9pJZ49/9Ec5M1iOaP
         T3DzaTgGwpFBH1290kfcIzjRakFDzDwinLzIxWKd7r0yXKn0M6bxRNku+BUxesd4FSdm
         j0zQ==
X-Gm-Message-State: AOJu0YziPIPoJz2s+iIwymzzURh6l69G5oH+XDPYG4E+eDEYYT9h4vWz
        V3ZDipCopSpUIaEzXDVkoURQPn7BiIzOBij/hKkYSw==
X-Google-Smtp-Source: AGHT+IGx1Hvm8GzUNEC4qBxcvszi1ZgPs7hwI3gCJ7ARlCRyZ6+kA7nZ6709ZdZ9q/d5dH8ck5s7td3mHpji47CG91s=
X-Received: by 2002:a0c:cc03:0:b0:63f:7b35:6ad8 with SMTP id
 r3-20020a0ccc03000000b0063f7b356ad8mr88500qvk.23.1691515353160; Tue, 08 Aug
 2023 10:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230808-um_hostaudio-v1-1-3d40fbe1fb1e@google.com>
In-Reply-To: <20230808-um_hostaudio-v1-1-3d40fbe1fb1e@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Aug 2023 10:22:21 -0700
Message-ID: <CAKwvOd=+GHvgFhZyWbZsR8+-Z0WzVAvncM-mhcycR1q244GykA@mail.gmail.com>
Subject: Re: [PATCH] uml: audio: fix -Wmissing-variable-declarations
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 10:21=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> I'm looking to enable -Wmissing-variable-declarations behind W=3D1. 0day
> bot spotted the following instance:
>
>   arch/um/drivers/hostaudio_kern.c:316:3: warning: no previous extern
>   declaration for non-static variable 'module_data'
>   [-Wmissing-variable-declarations]
>   } module_data;
>     ^
>   arch/um/drivers/hostaudio_kern.c:313:1: note: declare 'static' if the
>   variable is not intended to be used outside of this translation unit
>   struct {
>   ^
>
> This symbol is not referenced by more than one translation unit, so give
> it static storage.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/llvm/202308081000.tTL1ElTr-lkp@intel.com/

^ D'oh, wrong report, this should be
https://lore.kernel.org/llvm/202308081050.sZEw4cQ5-lkp@intel.com/
Resending.

> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/um/drivers/hostaudio_kern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio=
_kern.c
> index 5b064d360cb7..c42b793bce65 100644
> --- a/arch/um/drivers/hostaudio_kern.c
> +++ b/arch/um/drivers/hostaudio_kern.c
> @@ -310,7 +310,7 @@ static const struct file_operations hostmixer_fops =
=3D {
>         .release        =3D hostmixer_release,
>  };
>
> -struct {
> +static struct {
>         int dev_audio;
>         int dev_mixer;
>  } module_data;
>
> ---
> base-commit: 14f9643dc90adea074a0ffb7a17d337eafc6a5cc
> change-id: 20230808-um_hostaudio-21d7207deaed
>
> Best regards,
> --
> Nick Desaulniers <ndesaulniers@google.com>
>


--=20
Thanks,
~Nick Desaulniers
