Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E578F7D34D9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjJWLnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjJWLnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:43:05 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCDB10D0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:42:57 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7c08b7744so31467517b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698061377; x=1698666177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SHpOrdrjUq/RCpEv0rxQXUbu6fq2w6SkA9rTlRoXwdQ=;
        b=M+qe/nZOuAFgg4z2E81XWD/9yNz10ufKCHIU6ggwE4UTwrnm3xPhxVaguo9i9ToDb5
         o5ScsvGEEBlNRa3w5gptS/yVRB9YAJPeSCBWVa1F486/UhrvAjj9d5y+TFCu35ogRmFq
         ATPCyxMfxAm9HLP+A3K6A4CLsNNYdnz+s5o+RxIYzgh5hs4BI7D+lp/h251yh3xQgpOO
         WK+p+bPHuMlGJqj9T8Yhn6mrYdyshq4KWM5bzhF+CDE6KM6RhtlwOHMcY/Zy/1mm+L8s
         NfdXfQ9mMd3Be/4njrLl4cLENidIkgSsYtsgrRnTJyx8TLiSXxwD197tBJvqxG5u5tux
         tUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698061377; x=1698666177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHpOrdrjUq/RCpEv0rxQXUbu6fq2w6SkA9rTlRoXwdQ=;
        b=PvSZNyTZvQ//M6P/KlDPM6JPOJruvfQz6U714pNZ8jQ3gvQkVCKem9mVB68wKol51a
         EBKujvPZ2hBPiO5D/jPf8hbtLX/+FjGalMLpRl6qIeTZmJUaLeyoOzmmr2DD1Kuomfbq
         OuMzQ/+GTbhKEBuGTsMvoNLQUHYXC3wEMRp9xajlUvedIbHbq8bZpTv67bMo/hfatKGx
         Ift3NBASocEVNUqLVn8uInB4d54wmNlfXPhJYtoCfJrqo0wtPWomrrfjkX9ErB1FfDAS
         zPo2Gi1BYtC4BYsM84W9eLTue8Gdy7KY3YG21Ej4kDCJBKK+qjQ63ScIL9cumhH0Ox1o
         9CAw==
X-Gm-Message-State: AOJu0YyAuHTRgK50M12BM9joNtdHXi5njqptuowLABbqLFZHDT8KuSav
        A1rbwWAkknvrzhedeq8LxjfSPl/vLFtjWTKf7/HtRA==
X-Google-Smtp-Source: AGHT+IE3/2ZI0BAAgKeahHy0bltN+bgn69act0vLj5jmqXpHgASUMtPiWCTt97Rumz+LhvcD4bX6c/AKBBiunSB2yA0=
X-Received: by 2002:a81:8943:0:b0:5a8:1058:5d97 with SMTP id
 z64-20020a818943000000b005a810585d97mr8762458ywf.45.1698061376807; Mon, 23
 Oct 2023 04:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231019195752.62692-1-edson.drosdeck@gmail.com>
In-Reply-To: <20231019195752.62692-1-edson.drosdeck@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Oct 2023 13:42:20 +0200
Message-ID: <CAPDyKFoeuVHu+Rt7kg1zbz1oFW8aCkQJ5swCbmSnA_Xrhx0eYw@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: Use octal for file permissions
To:     Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc:     adrian.hunter@intel.com, CLoehle@hyperstone.com,
        brauner@kernel.org, axboe@kernel.dk,
        victor.shih@genesyslogic.com.tw, f.fainelli@gmail.com,
        asuk4.q@gmail.com, yibin.ding@unisoc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 21:58, Edson Juliano Drosdeck
<edson.drosdeck@gmail.com> wrote:
>
> Octal permissions are preferred as stated in
> Documentation/dev-tools/checkpatch.rst. Replace symbolic permissions
> with octal permissions when creating the files.
>
> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

Thanks for your patch!

Replacing symbolic permissions with octal permissions makes sense to
me. However, I don't want one patch per line that needs to be changed.

Instead, please go over all the files in drivers/mmc/core and fix all
of them in one patch. Another patch can be done for
drivers/mmc/hosts/*

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index b5b414a71e0b..edb653d8fbfa 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2916,7 +2916,7 @@ static void mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
>
>         if (mmc_card_mmc(card)) {
>                 md->ext_csd_dentry =
> -                       debugfs_create_file("ext_csd", S_IRUSR, root, card,
> +                       debugfs_create_file("ext_csd", 0400, root, card,
>                                             &mmc_dbg_ext_csd_fops);
>         }
>  }
> --
> 2.39.2
>
