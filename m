Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5BB784243
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbjHVNlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbjHVNlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:41:24 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA06ECD6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:41:22 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso39175061fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692711678; x=1693316478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcgDocHR3AS6T5F0NbvfXCbpFyony7w3WuvNA0XYYRs=;
        b=hfTF+UAST2CfCQfAM7m4zVeEmDW2auHQh/I2FQdfSigtVheBITXh5Gf32pObwshGm3
         0GSACTbnr8EZHR/YKc9szjMp+tvTOGEcTI5oc4FQ1vcREWvx+eCUIwMbqq3dUTJupKwO
         pG2JBvVuESYTC9FR0IUz+lp+pKfiWPRHOEPck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692711678; x=1693316478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcgDocHR3AS6T5F0NbvfXCbpFyony7w3WuvNA0XYYRs=;
        b=iirUlnNIboICs7q4DOSQr1FQC5xQEY3VLNpY5FNRiPKG8LhhKUT9jv5e0EWM/EsuRB
         EPgw7tHK/2koHPHMGbgfr+OSRdi6QjQh7Ea9Pln5VkWDJinNACc0cuKxUnqJKStwlO7N
         i3iKzsY6rXV+XUxAoUsZeXZj5fCYZnY9NceAv79ZsfQK5mT71lQhJVZlRmFhrVVo01T+
         lGwiN0F8WsVvZEzlj+pzyRwQZ2O12qnk8V7zTbZDwR7mjkMcfzXu77IvdiB+qFRHLLq+
         MePD1U3hsVAbsQ+wwWxWNxxYkwwj0E9CgvrUHwDbu3ifz6anZPJgK4gcnLesX6lYRFuW
         CDAQ==
X-Gm-Message-State: AOJu0YyTaMfN2kMQSO3AH5peg+WWl8Lx2Xj1SF7/4l8/FPaKBcbD8Lk4
        WuAfb5M2pIW44O6P1I+Upc2h5e9y7gEc3XU3X+rVdZgw
X-Google-Smtp-Source: AGHT+IFlllZIbVDI/HUNb3ta7gCserxl+6wgiloP9R2jVXCP/WwRjCyFgNSRMLbPFvwIZydl/Bxp2w==
X-Received: by 2002:a05:651c:146:b0:2b6:9ed0:46f4 with SMTP id c6-20020a05651c014600b002b69ed046f4mr7321147ljd.23.1692711678120;
        Tue, 22 Aug 2023 06:41:18 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id i12-20020a1709061ccc00b00991e2b5a27dsm8261688ejh.37.2023.08.22.06.41.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 06:41:17 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fef2fafee2so94395e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:41:17 -0700 (PDT)
X-Received: by 2002:a05:600c:5123:b0:3fe:cd3a:ef92 with SMTP id
 o35-20020a05600c512300b003fecd3aef92mr109374wms.6.1692711677321; Tue, 22 Aug
 2023 06:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230822100359.124282-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230822180054.v5.1.I26e017b00a341e7a5a2e94a83596923713408817@changeid>
In-Reply-To: <20230822180054.v5.1.I26e017b00a341e7a5a2e94a83596923713408817@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Aug 2023 06:41:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UkQhrPH=8N+TcErXHEFMh5nunZsCAvXiYyT+LRk-s5-g@mail.gmail.com>
Message-ID: <CAD=FV=UkQhrPH=8N+TcErXHEFMh5nunZsCAvXiYyT+LRk-s5-g@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: qcom: add sc7180-lazor board bindings
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 22, 2023 at 3:04=E2=80=AFAM Sheng-Liang Pan
<sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>
> Introduce more sc7180-lazor sku and board version configuration,
> add no-eSIM SKU 10 for Lazor, no-eSIM SKU 15 and 18 for Limozeen,
> add new board version 10 for audio codec ALC5682i-VS.
>
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.googl=
e.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v3:
> - correct corresponding of new board and new sku
>
> Changes in v2:
> - add new entry rev9 with Parade bridge chip
> - correct newly create dts files
>  .../devicetree/bindings/arm/qcom.yaml         | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)

In my response to v3 [1] I mentioned that you should make sure to add
Krzysztof's tag that he added on v2 [2], since v2 and v3 were nearly
identical. IMO, you don't need to send a v6 just for this but please
remember to do this in the future.

[1] https://lore.kernel.org/r/CAD=3DFV=3DWKTdaQgH4Cf2OCV9Uy6APjxfP8Pz+1-uWA=
cLC2PphYnw@mail.gmail.com
[2] https://lore.kernel.org/r/55d4090f-d2f3-ffb2-cc6f-a13222f14e47@linaro.o=
rg
