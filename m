Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28656773CD9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjHHQKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHHQIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:08:37 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCEB76B1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:46:17 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40648d758f1so42347751cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509576; x=1692114376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KdNPcZqmtXQcuBkzS9CoNBBYMwWbfur9izXMF+UKcpU=;
        b=xGKOHc3ZupnN1cra0vlHNOQRuAa1RFClpSew3SZkzEC2F1yXTeDUMhHmk1NamGC/x5
         M8uP4xyef9sVZrq54HZ8oYHZhYqpNlzfF0Y98NRGx5VEgwR8wG0VKS5CszZwrO2ZVuIQ
         6NW6sdsXfEHi/B3BO59NWkUqyiyhWNMZUaGw0AxpJMxvdkAwhf295nfF4nnWE5UyBE92
         pm5/kgYqNildNUuPJ5vnN6RfP875xMV9gkJLWK0d9N9NtcbLU4CNSyEEvEetiEd0daIB
         ZEtGcSfiNW66+War6lHw9NQGCPp95NKd6i0frTQIoQLWnHps2hlAzm+7rshZ44vSl5Rn
         K4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509576; x=1692114376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdNPcZqmtXQcuBkzS9CoNBBYMwWbfur9izXMF+UKcpU=;
        b=Sb6z/AMaBcTxqiTbre7xCZXA+LZLltZK2fCJl4p76wMQtDCN3K8m+7ktbw3vUJy8sy
         X7WygDGwQoX/l/WQ8txCtfKK3JN+hDDe3RKlxE2cfuwA9XevDmxNmHUCyAIZBSbtnC7O
         ih89hRriUj0/j3oKyx+VK3CePfN4hKbl+jn6TwM+pciLzGcVLB0kTUUa9njHfsQq1OKL
         6Tp8lO1IL+KaTHNfdtop4wXeVA910tCY1tZTm8GEdfWXPtAsC4Joilb5XrA321Q2ju+/
         3P/eSTUG0fSRIzs2DY/5uAclYjiGt0FO/nx/AxYoeOAf14+evHSLc7XX30sq4VSCIrK+
         jyAg==
X-Gm-Message-State: AOJu0YzqStfJPq0DWxM9SqEkmL3AzzOzQwrs+AftW81fx6WAmGKrFGJE
        x9xEUIdqOAmUr30hLNDLf7jjKRlb0g+rj5IclXy1mOyXjHHYxkoFZsM=
X-Google-Smtp-Source: AGHT+IGuyTfHVUm0ldXaXrpMjSkfrIAQhLkFo1ndJ+yOlR8TxUe3HqDJUGXb27eojG4uRIDIwVCqRszIGFSQKMDYZi8=
X-Received: by 2002:a25:ced1:0:b0:c6f:b2de:21ba with SMTP id
 x200-20020a25ced1000000b00c6fb2de21bamr11990109ybe.17.1691507553159; Tue, 08
 Aug 2023 08:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230731122611.4309-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230731122611.4309-1-lukas.bulwahn@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 17:11:56 +0200
Message-ID: <CAPDyKFpffTGpiQ5PSyKm+hcVntE==SH6O0XnvafgyReXwxNT_g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in STARFIVE JH71XX PMU
 CONTROLLER DRIVER
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Walker Chen <walker.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Arnd

On Mon, 31 Jul 2023 at 14:26, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit f3fb16291f48 ("soc: starfive: Move the power-domain driver to the
> genpd dir") moves:
>
>   drivers/{soc/starfive/jh71xx_pmu.c => genpd/starfive/jh71xx-pmu.c}
>
> However, the update to the file entry in MAINTAINERS only addresses the
> move in directories, but misses the renaming from jh71xx_pmu.c to
> jh71xx-pmu.c. Hence, ./scripts/get_maintainer.pl --self-test=patterns
> complains about a broken reference.
>
> Adjust the file entry in STARFIVE JH71XX PMU CONTROLLER DRIVER.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied for next (and the immutable branch) to my new genpd tree [1], thanks!

Kind regards
Uffe

[1]

git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git next


> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 003b0461641a..7a20d6ab1d18 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20408,7 +20408,7 @@ M:      Walker Chen <walker.chen@starfivetech.com>
>  M:     Changhuang Liang <changhuang.liang@starfivetech.com>
>  S:     Supported
>  F:     Documentation/devicetree/bindings/power/starfive*
> -F:     drivers/genpd/starfive/jh71xx_pmu.c
> +F:     drivers/genpd/starfive/jh71xx-pmu.c
>  F:     include/dt-bindings/power/starfive,jh7110-pmu.h
>
>  STARFIVE SOC DRIVERS
> --
> 2.17.1
>
