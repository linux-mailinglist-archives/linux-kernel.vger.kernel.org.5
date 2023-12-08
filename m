Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4250980A7F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574412AbjLHPyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjLHPyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:54:17 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18197BD;
        Fri,  8 Dec 2023 07:54:24 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7c59ac49f12so1141897241.1;
        Fri, 08 Dec 2023 07:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702050863; x=1702655663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HJckfY/O+WNBjP92Ja6mDXLeNrN1XJG5KdYfPf1kDfE=;
        b=bBHTe6GqfZKijwEanWccxNSxeuRVvqDFSSCOoPotlNvxMiQd29XhPsozqSxgtSO3l0
         fB/zLm2tltjXORKNVFgnh12GBZ2eAQfp8n8eHwC2xQCSpdU3qNFMMFC+A2XG6AuhaLQg
         W/rxyLWAcQb1Sp7cBGfLVGw+u2yL5bI1kmneIsyCuYBZkF8F8N+2WeGjeajc6xZQkl1/
         quJG8duwxdTiybGkGlKBB3Ta5oantGMnDF0Oo5a2k53DGCkqaUh8wMHdJdye8e0q1Yv1
         YG9qqzQXnZ5pF52A8H7qwx+1zfhAyZqa9DA3C9Y0RDTCfj/T+rSPmQ5GORNGYuNsu9M/
         buig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050863; x=1702655663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJckfY/O+WNBjP92Ja6mDXLeNrN1XJG5KdYfPf1kDfE=;
        b=q1Ug+ChiFO0S6/VvKsw8G/ieN9VZcEU9uWf/HWuGHwffN/aymo1dHT9GEaJji+RHoB
         uy61+rzrvPLgrXCFA1yfWYk/Rl4fdQl9BEeorNaARkKAqNSgEogucO+da0JP+UfYlEi9
         zwoq2bpaNXKL+tY0uw+tvTl8u/2MVI/PkgbMRCNAw3W3NnMYTjqWzMAEaDiTOUcYKRCx
         1bgYrdY0s/PMIzrNi2rIctIixq7F1UyWL4p5BaxxGfrJ2NTHVmmfuYEieGzevHhs5UQv
         kqaMQ02k/kvtmty+F8rSyxIPsmxxLoUfy6EHFq7uDgBl+LI+dKKt5GrxyxUe/I9OzN6b
         n0mg==
X-Gm-Message-State: AOJu0Ywew4CvZuAGX44CLurvnGdqIfxU2RlSf/q+WOziBKn8rwaTecQW
        do8gYKbtaRYu56HXUeoLPB02LHpzFXAsKeOUaQPGVqgBDRBuAw==
X-Google-Smtp-Source: AGHT+IHqBcm+dyGPEwNbp3iBaa2Wq1bBEaTn16dQ0uJjK1ajD86blAwTvlSgHu6XUY+NKK3+3Id6Eb+/MX/wT5gCikk=
X-Received: by 2002:a05:6102:1007:b0:464:a0f7:6ce6 with SMTP id
 q7-20020a056102100700b00464a0f76ce6mr870724vsp.13.1702050860319; Fri, 08 Dec
 2023 07:54:20 -0800 (PST)
MIME-Version: 1.0
References: <20231206151134.26052-1-quic_pintu@quicinc.com>
In-Reply-To: <20231206151134.26052-1-quic_pintu@quicinc.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 8 Dec 2023 21:24:08 +0530
Message-ID: <CAOuPNLhVHHGa45rGvXrcYaDvxvWk7H7Ckip=jiM38ppKw_7uvQ@mail.gmail.com>
Subject: Re: [PATCH] of: reserved_mem: fix error log for reserved mem init failure
To:     Pintu Kumar <quic_pintu@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, robh+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 at 20:45, Pintu Kumar <quic_pintu@quicinc.com> wrote:
>
> During fdt_init_reserved_mem() when __reserved_mem_init_node()
> fail we are using pr_info to print error.
>
> So, if we change the loglevel to 4 (or below), this error
> message will be missed.
>
> Thus, change the pr_info to pr_err for fail case.
>
> Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> ---
>  drivers/of/of_reserved_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 7ec94cfcbddb..473665e76b6f 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -334,7 +334,7 @@ void __init fdt_init_reserved_mem(void)
>                 if (err == 0) {
>                         err = __reserved_mem_init_node(rmem);
>                         if (err != 0 && err != -ENOENT) {
> -                               pr_info("node %s compatible matching fail\n",
> +                               pr_err("node %s compatible matching fail\n",
>                                         rmem->name);
>                                 if (nomap)
>                                         memblock_clear_nomap(rmem->base, rmem->size);
> --
> 2.17.1
>

Looks like the patch got pushed twice because of some network issue.
Please consider this one for review.

Thanks
