Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5508C7914C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbjIDJbU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Sep 2023 05:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjIDJbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:31:19 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C60DD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 02:31:15 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5738949f62cso758716eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 02:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693819875; x=1694424675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG988PTwvScD3wLbWtRomruo1Gx7FVCGpITmTrjaWCc=;
        b=Mw6hJr5x1L0i1BuBfcDN47rSM8sDPpMb/mskKbLMUoOVDGE/eIkdJDZlb5ss4yv8La
         zj4RcGNYzZs8ttjfCIVUayRsXFB6oY01Wh+/Za7rSQzoXpKz+jXonR94L00iKBtgVjJI
         34GzMrU2ERc4o/+lFPVHLqS54Az8E9Bu6LVx+wMsrhBjqbyipuTq7lRXABLhsWGuMiNr
         IK+t8icrA+FJRjBCESIKqUx7RnUmIg58Wdcg9tRm0ZEle0LZB3fWNj4cZEVYBmbd/YRT
         32O/PBKnhFyHEO5/NxOG4yM1XspmL5QnRmKrOa3K0fjp2FgobSfsshy+LxnZJEBjX9JH
         6J4Q==
X-Gm-Message-State: AOJu0YxKQYFuQtnezmEe4R6/97f0vbsPQI/Y3rBlJN+xc44rzjEbMxh3
        39FdE2R4mga1ZGl3QylH4femFcSx0K85Uw==
X-Google-Smtp-Source: AGHT+IG5860/PzNUBsX2dSCwjdHcmO1SKTiwzyGU0beaGWbEtQAzTRNL8F/GQhyr3UPyPpewPMv4PA==
X-Received: by 2002:a05:6820:284:b0:56d:c55b:4792 with SMTP id q4-20020a056820028400b0056dc55b4792mr7778586ood.6.1693819874826;
        Mon, 04 Sep 2023 02:31:14 -0700 (PDT)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id 62-20020a4a1a41000000b00573a0631d98sm4718016oof.34.2023.09.04.02.31.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 02:31:14 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5738949f62cso758700eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 02:31:14 -0700 (PDT)
X-Received: by 2002:a05:6358:2812:b0:133:595:1c with SMTP id
 k18-20020a056358281200b001330595001cmr9719035rwb.31.1693819874112; Mon, 04
 Sep 2023 02:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230831121623.36293-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230831121623.36293-1-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Sep 2023 11:31:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVoDDV-VgPJL75u_t3KeAPhb1xEFX2VigVC3oS51pG6wA@mail.gmail.com>
Message-ID: <CAMuHMdVoDDV-VgPJL75u_t3KeAPhb1xEFX2VigVC3oS51pG6wA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] zorro: Use helpers from ioport.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Aug 31, 2023 at 2:16 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> We can use the DEFINE_RES_MEM_NAMED() macro and resource_contains() helper
> instead of reimplementing them in the code. No functional change intended.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

> --- a/drivers/zorro/zorro.c
> +++ b/drivers/zorro/zorro.c
> @@ -117,17 +117,13 @@ static struct resource __init *zorro_find_parent_resource(
>         int i;
>
>         for (i = 0; i < bridge->num_resources; i++) {
> -               struct resource *r = &bridge->resource[i];
> -
> -               if (zorro_resource_start(z) >= r->start &&
> -                   zorro_resource_end(z) <= r->end)
> -                       return r;
> +               if (resource_contains(&bridge->resource[i], &z->resource)

Missing closing parenthesis. What happened to your cross-compiler?

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.7 branch, with the above fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
