Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BD976D8E2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjHBUxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjHBUxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:53:21 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2FB1FF2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:53:19 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9cd6a554cso3177381fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 13:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691009596; x=1691614396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eq52sqKujE7MhZWH3BLjlYfCHWyi+6Cij3678vJINY8=;
        b=WFpDH4+vwqWFh3iuVbfBbBnnqWinG0vOI+7SH6GvFbJR5yOc0MUHr5FdJFoUX1BV+A
         OE5jbIAhGmw5fDfFnNVd2fvKf5TUbDtcnsZw87o5fD3cGdk8vR+RlSUoc2+E6ynBQoFh
         rmwobIsjHRZIN6DS3gsaUxcvkJMi3E+5ZXIhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691009596; x=1691614396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eq52sqKujE7MhZWH3BLjlYfCHWyi+6Cij3678vJINY8=;
        b=XhBQ29bfqkgDct2ze5puN8p1Uai9/Q9Ymp1ENTbG46qpUJy3OzfRyRT8Hrd0WgDOg5
         C6QVUrQhlRH/QPiLyYS4d6QsieVbSvzDePK1c7nHOhN0UdjWAwn3u6ZC6mu/YcBKAuQs
         xili15IltZp92R4ZI0UDO+aD3NQJ+T70sFdO03o7W++qRbwu0mVPMLqyyJjT+0uOpqJX
         yFxqWbGUExi80kw2YomLYn0UlPjrVTQK37STjYx8vKPsCKsm/GWhnltcE9ETXTzlB6fR
         nbLGgikmsINh4abBSws9oIWZfiyD+PmP5uqjaYYY4zzo4DFTa1FLoTD4Z6MMojQaZSXN
         r0IA==
X-Gm-Message-State: ABy/qLY7H0/ECdmchpaD1jOwH+2ro/NCMR3zCXpS391xOGTi6QymNFlq
        SGEs94JCFZwIkbiiUUJaOunangDG/ADpeGg6CwgE+7Ep
X-Google-Smtp-Source: APBJJlH9A6URBipp7iFnnZ5bg6tTwMn9+rPy85iVH53wyhw3wou6pcPDPZ+gvfEbuYTzZD1EB8lcHQ==
X-Received: by 2002:a2e:99c7:0:b0:2b6:fc80:c45f with SMTP id l7-20020a2e99c7000000b002b6fc80c45fmr5100471ljj.13.1691009595742;
        Wed, 02 Aug 2023 13:53:15 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id lz7-20020a170906fb0700b0099b6b8a0d04sm9663581ejb.157.2023.08.02.13.53.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 13:53:15 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so755a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 13:53:15 -0700 (PDT)
X-Received: by 2002:a50:f69e:0:b0:522:3c11:1780 with SMTP id
 d30-20020a50f69e000000b005223c111780mr444850edn.0.1691009595009; Wed, 02 Aug
 2023 13:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230802095753.13644-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230802175628.1.I7a950de49ec24b957e90d7fe7abd5f2f5f2e24c3@changeid>
In-Reply-To: <20230802175628.1.I7a950de49ec24b957e90d7fe7abd5f2f5f2e24c3@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Aug 2023 13:53:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V=2wjVvY-qv4j=41FrWVOehUrLEbHu9Pr2PmRDSHjLcw@mail.gmail.com>
Message-ID: <CAD=FV=V=2wjVvY-qv4j=41FrWVOehUrLEbHu9Pr2PmRDSHjLcw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: qcom: add sc7180-lazor board bindings
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 2, 2023 at 2:58=E2=80=AFAM Sheng-Liang Pan
<sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>
> Introduce more sc7180-lazor sku and board version configuration,
> add no-eSIM SKU 10 for Lazor, no-eSIM SKU 15 and 18 for Limozeen,
> add new board version 10 for audio codec ALC5682i-VS.
>
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.googl=
e.com>
> ---
>
>  .../devicetree/bindings/arm/qcom.yaml         | 43 ++++++++++++++++---
>  1 file changed, 38 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentat=
ion/devicetree/bindings/arm/qcom.yaml
> index 450f616774e0..e0efc80a72e1 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -460,7 +460,7 @@ properties:
>            - const: google,lazor-rev2
>            - const: qcom,sc7180
>
> -      - description: Acer Chromebook Spin 513 (rev3 - 8)
> +      - description: Acer Chromebook Spin 513 (rev3 - 9)
>          items:
>            - const: google,lazor-rev3
>            - const: google,lazor-rev4
> @@ -468,6 +468,7 @@ properties:
>            - const: google,lazor-rev6
>            - const: google,lazor-rev7
>            - const: google,lazor-rev8
> +          - const: google,lazor-rev9

I don't think this is correct. lazor-rev9 has the Parade bridge chip,
not the TI bridge chip. It can't be lumped together with the earlier
revisions. What you want to do is leave the "rev3 - 8" alone, then add
a new entry just for "-rev9". Your brand new revision 10 doesn't need
its own entry in this list because it's the "newest rev".



> @@ -550,6 +565,24 @@ properties:
>            - const: google,lazor-sku6
>            - const: qcom,sc7180
>
> +      - description: Acer Chromebook 511 no-esim (rev9)
> +        items:
> +          - const: google,lazor-rev9-sku15
> +          - const: qcom,sc7180
> +
> +      - description: Acer Chromebook 511 no-esim(newest rev)

nit: please put a space before "(newest rev)"


> +        items:
> +          - const: google,lazor-sku15

You're missing the second item: "const: qcom,sc7180"


> +      - description: Acer Chromebook 511 without Touchscreen no-esim (re=
v9)
> +        items:
> +          - const: google,lazor-rev9-sku18
> +          - const: qcom,sc7180
> +
> +      - description: Acer Chromebook 511 without Touchscreen no-esim(new=
est rev)

nit: please put a space before "(newest rev)"


> +        items:
> +          - const: google,lazor-sku18

You're missing the second item: "const: qcom,sc7180"
