Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23FC7DBE07
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjJ3Qgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjJ3Qgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:36:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658729B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:36:35 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso1473926a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698683792; x=1699288592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xavDmDYDKGApF37pHfgaeVpvo2fMN9hqfhiSorYJU94=;
        b=kUc4CRwPR2GBlOsecyBr+QjtRkefpigXdSs3oescTtah+xV2mj0aeHdltzbKKdtk1I
         ckq/n1Kxhrn0RZ9nClR8bmqFpzRp3nykn1LSizHTlnrjz3LIo5ufMWld1nTBPtCGVzDH
         GI+7nUrEGOjq7VFMyGVXKafaRgRot67+fjB3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698683792; x=1699288592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xavDmDYDKGApF37pHfgaeVpvo2fMN9hqfhiSorYJU94=;
        b=PSBDkuiC4Vdl9hIGxhsXySMkf1U4WlEOTlFFRz4Qn/5M0DJ1YYdcDAwcJD9yyhK7vp
         /hG4MDJTEOgWV2umZ+9t16+PrMHOmuasDc9UsoRZESCUsOyCdRyM9tKCmp72fz+9OklE
         +pppw0bgVzOt3SuBWXfuoUPZOguH8CLJ5X9otaYHGnzXigXJ0vi+Ecgh7trcKFm6sArE
         15dnRmliADtJNV4aUvlNnAhPykI6e90wFRNat7ZG7yXUSyJ9WE2CtFPhyD1GrLI6gIX4
         5TGgAqXheWcMRUhAjYxK+8XySjO+aIrSLTKoJ9W18Ovjh59WKodbdiTQIeEqYBsCgbWp
         nHlw==
X-Gm-Message-State: AOJu0Yx8jPiPZ6bohJYI1p7nTtYi7ucKEzs6bk0sDy++XfKcLLhZlMWv
        zV3AiUShPElJxzOiybBCDbMlPxCXwqnkhOOeiwCKmcRj
X-Google-Smtp-Source: AGHT+IGciLuheXPqqOE5C7sW+XL2b9RmFUxjVF0v6tEWSgvD4bvJ3kZOjY5/9zqjCbaKXeOTK1Z5ag==
X-Received: by 2002:aa7:dcda:0:b0:530:8942:e830 with SMTP id w26-20020aa7dcda000000b005308942e830mr167132edu.2.1698683792291;
        Mon, 30 Oct 2023 09:36:32 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id q8-20020a50cc88000000b0053d9cb67248sm6426844edi.18.2023.10.30.09.36.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 09:36:32 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40837124e1cso1035e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:36:31 -0700 (PDT)
X-Received: by 2002:a05:600c:1d17:b0:400:c6de:6a20 with SMTP id
 l23-20020a05600c1d1700b00400c6de6a20mr133775wms.3.1698683791371; Mon, 30 Oct
 2023 09:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <0b1790ca91b71e3362a6a4c2863bc5787b4d60c9.1698501284.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <0b1790ca91b71e3362a6a4c2863bc5787b4d60c9.1698501284.git.christophe.jaillet@wanadoo.fr>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 30 Oct 2023 09:36:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WSh7wKN7Yp-3wWiDgX4E3isQ8uh0LCzTmd1v9Cg9j+nQ@mail.gmail.com>
Message-ID: <CAD=FV=WSh7wKN7Yp-3wWiDgX4E3isQ8uh0LCzTmd1v9Cg9j+nQ@mail.gmail.com>
Subject: Re: [PATCH] kdb: Fix a potential buffer overflow in kdb_local()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Martin Hicks <mort@sgi.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 28, 2023 at 6:55=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> When appending "[defcmd]" to 'kdb_prompt_str', the size of the string
> already in the buffer should be taken into account.
>
> Switch from strncat() to strlcat() which does the correct test to avoid
> such an overflow.
>
> Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  kernel/debug/kdb/kdb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 438b868cbfa9..e5f0bf0f45d1 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -1350,7 +1350,7 @@ static int kdb_local(kdb_reason_t reason, int error=
, struct pt_regs *regs,
>                 snprintf(kdb_prompt_str, CMD_BUFLEN, kdbgetenv("PROMPT"),
>                          raw_smp_processor_id());
>                 if (defcmd_in_progress)
> -                       strncat(kdb_prompt_str, "[defcmd]", CMD_BUFLEN);
> +                       strlcat(kdb_prompt_str, "[defcmd]", CMD_BUFLEN);

Some of this code is a bit hard to follow, but I think it's better to
simply delete the whole "strncat". Specifically, as of commit
a37372f6c3c0 ("kdb: Prevent kernel oops with kdb_defcmd") it's clear
that "defcmd" can't actually be run to define new commands
interactively. It's also clear to me that "defcmd_in_progress" is only
set when defining new commands.

The prompt being constructed here is a prompt that's printed to the
end user when working interactively. That means the "if
(defcmd_in_progress)" should never be true and it can be deleted as
dead code.

-Doug
