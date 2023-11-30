Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B0D7FEDE6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345245AbjK3LbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345259AbjK3La5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:30:57 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469C4173F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:31:02 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-db40b699d2bso697105276.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701343861; x=1701948661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r7OU53fGBOPG6Pf4dr1TYI+8Sj5e49OX70Q1sOZhEyk=;
        b=sv/PdGSfE9Z5FdcY3EK45zoWKbMNLrwNd5bsAsu2RU4pTxMjEpom1hkjOi5f7IsD6t
         0orvMN81PS4fNiX0ULxOb1NGGZ2nL6T9g/8h7sgyiY7P557nMf3Oo/7dvX8rbLsxNsIj
         n0yHsK6B3m7uHYB2+ovIArGitkaf3DN79bB9yBBbu3KyN59vLUf+5rp6ngKg3WJUjBbU
         s+hKadHLVHBZe1287puHKUzMQ3hJIm/DbLwEMejgbm11XHkS2/Cjck7Uorqkvr4yRYS3
         tAUBCeOvgug5mWeYMnw44HrUjOMWHfhWmyReDDXwKziWn6TqegxjTpdFIAJHhb0DmxyQ
         wjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701343861; x=1701948661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7OU53fGBOPG6Pf4dr1TYI+8Sj5e49OX70Q1sOZhEyk=;
        b=sMMVOmrK01virKZ9uJza07lB7Wm6tsv96J9Ueumho/c2krOyaWO7IbNHUS/yLK1EOx
         F6cFracrbt5h0UHMpX0WNZ0TQvUiGRMe5geHuQZLBZGmkgCz40q1QkbGvWZQ6SxUOKRz
         utoZKzftoynsiJnPI8CSzpolKgwktNLRwWrxUqRBJYpUxDH1XQuE0SYCNmUPVvsf0W5S
         bjIKr2DtNQMFeSomwafZNUJk68eiYwDukTKcMA4PMjLaXMFBTuWJkevHr+luTfXjgD2G
         jN5DWh+XbzhRiEpLjNrW9mUyiwRLo9mAfxR8AsKifBDqypKAzZfZW4mQb6Bihp621wss
         57Pw==
X-Gm-Message-State: AOJu0Yxcel8SZ6Y3t7FuO+6M4EoKAZqRbph5S8FL++jyeTetRt7z+OFB
        gQ8cmrdy189TQ3J1zfOEb3beoCTGoGUOOjNJvWo6OA==
X-Google-Smtp-Source: AGHT+IGLBA9cAvCW/BlFwViZaJGDvVrjeHv8nYpm9n0xFyqiDsBqoa/xFpj/b8u0mPKQS3ZU6c/jj0h4qWRRrKDRbwY=
X-Received: by 2002:a25:ab0b:0:b0:da0:76eb:3d31 with SMTP id
 u11-20020a25ab0b000000b00da076eb3d31mr19895548ybi.15.1701343861311; Thu, 30
 Nov 2023 03:31:01 -0800 (PST)
MIME-Version: 1.0
References: <20231123-topic-amlogic-upstream-isp-pmdomain-v2-0-61f2fcf709e5@linaro.org>
 <20231123-topic-amlogic-upstream-isp-pmdomain-v2-1-61f2fcf709e5@linaro.org>
In-Reply-To: <20231123-topic-amlogic-upstream-isp-pmdomain-v2-1-61f2fcf709e5@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Nov 2023 12:30:25 +0100
Message-ID: <CAPDyKFr9jtg8rf2bs1N3zR146TvCmHgTwqWRr=LJNjervpfOkQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: meson-g12a-power: document ISP
 power domain
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 at 17:17, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add MIPI ISP power domain ID to the G12A Power domains bindings header
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Applied for next and the immutable dt branch, thanks!

Kind regards
Uffe


> ---
>  include/dt-bindings/power/meson-g12a-power.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/dt-bindings/power/meson-g12a-power.h b/include/dt-bindings/power/meson-g12a-power.h
> index 44ec0c50e340..01fd0ac4dd08 100644
> --- a/include/dt-bindings/power/meson-g12a-power.h
> +++ b/include/dt-bindings/power/meson-g12a-power.h
> @@ -10,5 +10,6 @@
>  #define PWRC_G12A_VPU_ID               0
>  #define PWRC_G12A_ETH_ID               1
>  #define PWRC_G12A_NNA_ID               2
> +#define PWRC_G12A_ISP_ID               3
>
>  #endif
>
> --
> 2.34.1
>
