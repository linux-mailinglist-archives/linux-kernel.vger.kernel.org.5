Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245467F640F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjKWQjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWQi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:38:58 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110CA19D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:39:05 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-da077db5145so1019898276.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700757544; x=1701362344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ILiBl3fw2ItmQ6qveZxg3Js/iA8qtmzSnw1HvX8bqaw=;
        b=vg6XzRypjX5xFTrQJC5rhS1YGwLkhjI5wjutcbK507mwytE1SQeMe6HYWUhpkQakC0
         qzBGi/kO7vJ1b2tn7bMrJEFafZRWikYAK4E6CqHmYndjr8eVIa456Mbz9xitZdfkUaq0
         3PbZ7EJ0W5rSrfaEtO6L34V2KqvUD4LafDP/GKJvJcWdWJ0vCxlEbYCfjDhDF2Zs63mM
         j5CEApFfPNkirRoZDbgX3jCmM/8STFZi4AwIdr5hgbLUp8ir5Uj/EdCSYujuPYH5Nt96
         KkOkbvXz3bS/TAcCMeW1HY1ywvofzvMaKDUCpKVj1kXx0XdvHT91C/lPlNih2Di23HDW
         22IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757544; x=1701362344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILiBl3fw2ItmQ6qveZxg3Js/iA8qtmzSnw1HvX8bqaw=;
        b=hFsvQriBuMC0skYoAXsal/ZNl3cWAJycDw/fTeImAHvjvNeSbyUQZXOzijDA41CGEj
         W+d6KyuNFeS435lbog4F0vCxBU13Cc35tVPMPxo87fI3saqerXZWTiz5c3vbRd50wWma
         TJFsn+eF1W9eEyWX69tjLW5+55u8kPN+n99LdaPk2A7Hb65lECVrqcugw/XLyADQrVEr
         YPSD5M7DHk/aVCtfV7JlA/Mlety/VVz0l2ECtSjatHqRn8e+Eq8Kx8RxVGSMKpP51KQh
         csXeGKHhM3FtdjrgS3bAHjhPTl9p03/Sz+MPFP14H9rnSJ/i4SKNnlGu+Or1UYfKfyAq
         mTZA==
X-Gm-Message-State: AOJu0Yysk2k+R8J4h4m/9iBhbcomUoCLUR+e/JAPFxC0n24oXBBRKgUE
        W6YeN60XBQXt5GrJFaIKSX7zDe2YZbp8YriA+Wd5+w==
X-Google-Smtp-Source: AGHT+IHyEIVYlN4F4vyQBH9BTfFozPqgQ9H3YOtEeJFgrrYDbBBfTUFwzsGY/k+etU5uqbsqanAFeQTZObkfBoTvB+c=
X-Received: by 2002:a25:8188:0:b0:d9a:6669:68ce with SMTP id
 p8-20020a258188000000b00d9a666968cemr5853600ybk.32.1700757544266; Thu, 23 Nov
 2023 08:39:04 -0800 (PST)
MIME-Version: 1.0
References: <20231123-topic-amlogic-upstream-isp-pmdomain-v2-0-61f2fcf709e5@linaro.org>
 <20231123-topic-amlogic-upstream-isp-pmdomain-v2-1-61f2fcf709e5@linaro.org> <20dee547-8358-4af4-ba90-c5e9a7367c48@linaro.org>
In-Reply-To: <20dee547-8358-4af4-ba90-c5e9a7367c48@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Nov 2023 17:38:27 +0100
Message-ID: <CAPDyKFqcq4F_HtCOomiZK+X1me8KK1i6y9mXjn-Bzg9COzS-aA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: meson-g12a-power: document ISP
 power domain
To:     neil.armstrong@linaro.org
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 at 17:19, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 23/11/2023 17:17, Neil Armstrong wrote:
> > Add MIPI ISP power domain ID to the G12A Power domains bindings header
> >
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >   include/dt-bindings/power/meson-g12a-power.h | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/include/dt-bindings/power/meson-g12a-power.h b/include/dt-bindings/power/meson-g12a-power.h
> > index 44ec0c50e340..01fd0ac4dd08 100644
> > --- a/include/dt-bindings/power/meson-g12a-power.h
> > +++ b/include/dt-bindings/power/meson-g12a-power.h
> > @@ -10,5 +10,6 @@
> >   #define PWRC_G12A_VPU_ID            0
> >   #define PWRC_G12A_ETH_ID            1
> >   #define PWRC_G12A_NNA_ID            2
> > +#define PWRC_G12A_ISP_ID             3
> >
> >   #endif
> >
>
> I forgot:
> Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
> Tested-by: Daniel Scally <dan.scally@ideasonboard.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> If needed I can send a v4 with those added...

No problem, I will add the tags when applying.

Kind regards
Uffe
