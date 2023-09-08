Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9C4798B8B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 19:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244848AbjIHRit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 13:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244098AbjIHRis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 13:38:48 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C881FC9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 10:38:45 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d7e741729a2so2162728276.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 10:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694194724; x=1694799524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PH7nP+tiRjJy1Oj0izOADdlmvBzx1PDNRU3LHKdfP58=;
        b=pkKARS8Mzwajry20T45lVTrP1mu7wFZpWXEy6Eu+OFdMoJ5WpPu+QuxKNkHMsnGv4N
         2AA9QlW2NjB9sAnCy12Id7Xt2cedArqi6lJb3wJ8YLo8NMyz2nz8KrrGKjOytKzBDAQX
         rWy+7mYcVSGFofGRLMj7lT+LPen8wy7nmkvgVBIFu6edr5kjO3wRZIb7RGFk3Qm9XKKJ
         o2QVzoHSnnwMMlWEICt/LoZdoxYvo+b4sHWQXxAP/2mpz6s23S0f4mc9UWnwO2pTD81R
         BIinyW5Lf6+JvXZdfjvnWURrNLJRHx/qdXr51Pz9X7BATRIzqlGfAsH1HfuH1Chh+jL/
         dtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694194724; x=1694799524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PH7nP+tiRjJy1Oj0izOADdlmvBzx1PDNRU3LHKdfP58=;
        b=vUFaEv0n7LXGyFXktdydl2ZQxeFyfhGzvdGZCFie/eT8+hqYFQtmuwUq16CW5HYNrA
         xqjG+NXLqPXGm8q8Mv+3NBqidmK2MRcb8MtDJBumG7usDg38D7daCq1A0aXREjwkjOUK
         cq0YE7hAT0dw5JDz4ZLShJMhT9Yaup3jqBjTSdGsV1WYCzOKa4yDT8RqSJ5TIKdllg/l
         F0lEWkqd+rBgCUnE+P45HFT0I++p3i2r9txt5eQnJgQ3Ue3fYRKKTh2xaqWCv9B7jJEZ
         dJA86XTYPMniRNMiOqu3lcXbFWzk06U2+sMBddh1dbarW9igjCutY2iBVP3VVqmXZmUk
         0zow==
X-Gm-Message-State: AOJu0Yx72L19x0kainACT40vAzJdHPOtXNT/zzyF2hAfQKrNpWoDuZlz
        QMB++qWk4i4ccM+j30PbC6Jz6nCjU4kNwqt2NQD54MlRKt8=
X-Google-Smtp-Source: AGHT+IGv295+iNxMHAGZ2rQbIuI2I70/gO7amp8SnKf7Fp+Kv8Dt8E0I5lgcW3ugMttjCx07JvIpeFowNdBEqdfGO5g=
X-Received: by 2002:a25:d74a:0:b0:d3b:b36f:37b3 with SMTP id
 o71-20020a25d74a000000b00d3bb36f37b3mr532292ybg.47.1694194724397; Fri, 08 Sep
 2023 10:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230308073201.3102738-7-avagin@google.com> <20230908173532.1055882-1-vijayendra.suman@oracle.com>
In-Reply-To: <20230908173532.1055882-1-vijayendra.suman@oracle.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Fri, 8 Sep 2023 10:38:33 -0700
Message-ID: <CANaxB-xPyg_Kzra8Q9pugLg=n7eLMkCkVkSih_rHUsoEuiNHeA@mail.gmail.com>
Subject: Re: [PATCH] perf/benchmark: Fix ifdef in header file uapi/asm/unistd_32.h
To:     Vijayendra Suman <vijayendra.suman@oracle.com>
Cc:     avagin@google.com, brauner@kernel.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        mingo@redhat.com, peterz@infradead.org, posk@google.com,
        tycho@tycho.pizza, vincent.guittot@linaro.org, wad@chromium.org,
        yu.c.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 8, 2023 at 10:36=E2=80=AFAM Vijayendra Suman
<vijayendra.suman@oracle.com> wrote:
>
> Typo error for __NR_seccomp
>
> ifdef -> ifndef
>

Acked-by: Andrei Vagin <avagin@gmail.com>

> Signed-off-by: Vijayendra Suman <vijayendra.suman@oracle.com>
> ---
>  tools/arch/x86/include/uapi/asm/unistd_32.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86=
/include/uapi/asm/unistd_32.h
> index 4798f9d18fe8..9de35df1afc3 100644
> --- a/tools/arch/x86/include/uapi/asm/unistd_32.h
> +++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
> @@ -26,6 +26,6 @@
>  #ifndef __NR_setns
>  #define __NR_setns 346
>  #endif
> -#ifdef __NR_seccomp
> +#ifndef __NR_seccomp
>  #define __NR_seccomp 354
>  #endif
> --
> 2.41.0
>
