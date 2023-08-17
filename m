Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C541E77FD18
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354041AbjHQRgt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Aug 2023 13:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354088AbjHQRgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:36:35 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C74A30E1;
        Thu, 17 Aug 2023 10:36:34 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-56d0deeca09so17072eaf.0;
        Thu, 17 Aug 2023 10:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692293793; x=1692898593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4POan3u+Y/SlkSMPxL3CN9jU2ZHvHGktHCzOOpZh90=;
        b=LNTimVv8zYF6pbeZqo8aSGp1Ufw3nc6BEY0XZuC2Xxc1X8bb4pMIlGXp9UdsA1sopg
         P7L1ej+D857Qz0mYwbG3tiszG0RJXrPlazxWwdEQNAzf4Lr6iIwa/uqXmcPIVdpImcIg
         T3XeAC9INrF7wT7QTgU0bftc8zNk7vvSnjgCkx/58bnTT8hGSGueUTL7WODTrzYnVrYl
         NkNLUr6F+9Gul39+z8PcBGdG6LLy0cNBLPdmRkewcf15+Dzq5SyJDFwRAfy7xCqVxqh9
         A4WN40RdpmhVzf81a9DOpvJJEcI/3ALM+i2wS4hLe9on1dHKWabNS0lhc7BBOVPyvetf
         U41Q==
X-Gm-Message-State: AOJu0Yy9CpI1AUQ9C+FSXIQuVJEXfJnV+Gsn6av3mvg1vsE3LI5v2Gpo
        n5Ak3KFY2xfqPNpUlWsYwtAfs/pe5OgPD/UpGL253vDR
X-Google-Smtp-Source: AGHT+IGTcQ9DCtLw0ChNdKRuXWWJaUVH4+ikaRgueJDspC3PzGinK/JGoJSbvfTgAT/9gKzQ4Azi1uRUFzZ4gJkY+rA=
X-Received: by 2002:a4a:bb05:0:b0:569:a08a:d9c5 with SMTP id
 f5-20020a4abb05000000b00569a08ad9c5mr532699oop.0.1692293793201; Thu, 17 Aug
 2023 10:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230722025246.8332-1-yuehaibing@huawei.com>
In-Reply-To: <20230722025246.8332-1-yuehaibing@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 19:36:22 +0200
Message-ID: <CAJZ5v0gsij=EFws0JiRD8TyzmnBSwNiKpBZqVGfwU2hiwjdaFw@mail.gmail.com>
Subject: Re: [PATCH -next] ACPI: Remove unsued extern declaration acpi_paddr_to_node()
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, Jul 22, 2023 at 4:52 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> This is never used since commit 1e3590e2e4a3 ("[PATCH] pgdat allocation for new node
> add (get node id by acpi)")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/acpi.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 641dc4843987..58a0fdf68ca2 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -477,8 +477,6 @@ static inline int acpi_get_node(acpi_handle handle)
>         return 0;
>  }
>  #endif
> -extern int acpi_paddr_to_node(u64 start_addr, u64 size);
> -
>  extern int pnpacpi_disabled;
>
>  #define PXM_INVAL      (-1)
> --

Applied (with a typo fix in the subject) as 6.6 material, thanks!
