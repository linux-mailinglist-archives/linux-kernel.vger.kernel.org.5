Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAF577D47E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbjHOUnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239487AbjHOUnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:43:25 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B953F1FE8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:43:00 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44ac6638896so270380137.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692132122; x=1692736922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkRDDoNPzSLjlacKlxL+E41IsOW/ULTgctVKXf9RjXA=;
        b=m4stkC2IfX61gWnvsguNFZFSfNPmn3fKsiWqgCrFf5FLAtPaolg3zje5WZMkO67Wtg
         cJ1cboANk0PbFSG7gWmChbbH2SRfgLJhlJn18V29d0eTqSSjYHrKahlaVw7MzpMfkoXP
         megBaq4sSSR661uam1lPGVlg+VBY6ocde/VBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692132122; x=1692736922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkRDDoNPzSLjlacKlxL+E41IsOW/ULTgctVKXf9RjXA=;
        b=eskPG9BDo1hrckHC5SyNgJZMyLHUvDqExsQc3jlbl07HJFBcO3EeKwBgN+2hR6jKHy
         PtltgQDis96LxX91zNlAILLRelikUAFaPz8Sz7svnTJU7T2aUTUQ+8MOXfuQjSSYwo70
         WPL1M1QV1WDN/6TXmdMG1R1ex6Mvh5bO9nnTo0tp2MVuCD2q9voj6tSTNhSGDbaWOkWy
         +PgbGMb/QQbjAHahPk4hORvnC9PsIOWazDpW9k4l9kAjB8iE+Tz0MLB9R5rA2Q1GX6y8
         is7GiZsg4XVgO2tJmGlE+Ut68G9HoCHpcc/3a7bxL/TzDspY8cX9vAtO/B3xjlvZxzgG
         9r4w==
X-Gm-Message-State: AOJu0Ywypa3q+lQ9R3v8I32mNjJwU5B3PsTx28CRp1ugQcoGGZKdCEUC
        6wETs9D2b5TuyKiBEG7KD2FwaE0VmEQwpSS03s3KPY/B
X-Google-Smtp-Source: AGHT+IHITUivIrD8/2y44NteB+WUE9ZQIcge/r+qgiGKFL2dIVpbhKUHVVWoFagyOq/EkjLoCuXSNw==
X-Received: by 2002:a67:f7d7:0:b0:447:68a0:a121 with SMTP id a23-20020a67f7d7000000b0044768a0a121mr95812vsp.2.1692132121693;
        Tue, 15 Aug 2023 13:42:01 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id y10-20020a0ce04a000000b0063d3744c5c5sm4360961qvk.5.2023.08.15.13.42.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 13:42:00 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4036bd4fff1so94981cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:42:00 -0700 (PDT)
X-Received: by 2002:a05:622a:491:b0:403:aa88:cf7e with SMTP id
 p17-20020a05622a049100b00403aa88cf7emr21591qtx.29.1692132120085; Tue, 15 Aug
 2023 13:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230804095836.39551-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230804175734.v2.1.I7a950de49ec24b957e90d7fe7abd5f2f5f2e24c3@changeid> <3ed8a34b-5f7d-6547-7e34-35e4d0994bba@linaro.org>
In-Reply-To: <3ed8a34b-5f7d-6547-7e34-35e4d0994bba@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 15 Aug 2023 13:41:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WqFo5PFB7+7ZOQtsTLYojjTn1VkaAQpMkqvWUFPOmBQg@mail.gmail.com>
Message-ID: <CAD=FV=WqFo5PFB7+7ZOQtsTLYojjTn1VkaAQpMkqvWUFPOmBQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: qcom: add sc7180-lazor board bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Sun, Aug 6, 2023 at 11:32=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/08/2023 11:58, Sheng-Liang Pan wrote:
> > Introduce more sc7180-lazor sku and board version configuration,
> > add no-eSIM SKU 10 for Lazor, no-eSIM SKU 15 and 18 for Limozeen,
> > add new board version 10 for audio codec ALC5682i-VS.
> >
> > Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.goo=
gle.com>
> > ---
> >
> > Changes in v2:
> > - add new entry rev9 with Parade bridge chip
> >
> >  .../devicetree/bindings/arm/qcom.yaml         | 55 +++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Document=
ation/devicetree/bindings/arm/qcom.yaml
> > index 450f616774e0..dce7b771a280 100644
> > --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> > +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> > @@ -470,6 +470,11 @@ properties:
> >            - const: google,lazor-rev8
> >            - const: qcom,sc7180
> >
> > +      - description: Acer Chromebook Spin 513 Parade bridge chip (rev9=
)
> > +        items:
> > +          - const: google,lazor-rev9
> > +          - const: qcom,sc7180
> > +
> >        - description: Acer Chromebook Spin 513 (newest rev)
> >          items:
> >            - const: google,lazor
> > @@ -491,6 +496,11 @@ properties:
> >            - const: google,lazor-rev8-sku2
> >            - const: qcom,sc7180
> >
> > +      - description: Acer Chromebook Spin 513 Parade bridge chip with =
KB Backlight (rev9)
> > +        items:
> > +          - const: google,lazor-rev9-sku2
> > +          - const: qcom,sc7180
> > +
> >        - description: Acer Chromebook Spin 513 with KB Backlight (newes=
t rev)
> >          items:
> >            - const: google,lazor-sku2
> > @@ -512,11 +522,26 @@ properties:
> >            - const: google,lazor-rev8-sku0
> >            - const: qcom,sc7180
> >
> > +      - description: Acer Chromebook Spin 513 Parade bridge chip with =
LTE (rev9)
> > +        items:
> > +          - const: google,lazor-rev9-sku0
> > +          - const: qcom,sc7180
> > +
> >        - description: Acer Chromebook Spin 513 with LTE (newest rev)
> >          items:
> >            - const: google,lazor-sku0
> >            - const: qcom,sc7180
> >
> > +      - description: Acer Chromebook Spin 513 Parade bridge chip with =
LTE no-esim (rev9)
> > +        items:
> > +          - const: google,lazor-rev9-sku10
> > +          - const: qcom,sc7180
> > +
> > +      - description: Acer Chromebook Spin 513 with LTE no-esim (newest=
 rev)
> > +        items:
> > +          - const: google,lazor-sku10
> > +          - const: qcom,sc7180
> > +
> >        - description: Acer Chromebook 511 (rev4 - rev8)
> >          items:
> >            - const: google,lazor-rev4-sku4
> > @@ -526,6 +551,11 @@ properties:
> >            - const: google,lazor-rev8-sku4
> >            - const: qcom,sc7180
> >
> > +      - description: Acer Chromebook 511 Parade bridge chip (rev9)
> > +        items:
> > +          - const: google,lazor-rev9-sku4
> > +          - const: qcom,sc7180
> > +
> >        - description: Acer Chromebook 511 (newest rev)
> >          items:
> >            - const: google,lazor-sku4
> > @@ -545,11 +575,36 @@ properties:
> >            - const: google,lazor-rev8-sku6
> >            - const: qcom,sc7180
> >
> > +      - description: Acer Chromebook 511 Parade bridge chip without To=
uchscreen (rev9)
> > +        items:
> > +          - const: google,lazor-rev9-sku6
> > +          - const: qcom,sc7180
> > +
> >        - description: Acer Chromebook 511 without Touchscreen (newest r=
ev)
> >          items:
> >            - const: google,lazor-sku6
> >            - const: qcom,sc7180
> >
> > +      - description: Acer Chromebook 511 Parade bridge chip no-esim (r=
ev9)
> > +        items:
> > +          - const: google,lazor-rev9-sku15
> > +          - const: qcom,sc7180
> > +
> > +      - description: Acer Chromebook 511 no-esim (newest rev)
> > +        items:
> > +          - const: google,lazor-sku15
> > +          - const: qcom,sc7180
> > +
> > +      - description: Acer Chromebook 511 Parade bridge chip without To=
uchscreen no-esim (rev9)
> > +        items:
> > +          - const: google,lazor-rev9-sku18
> > +          - const: qcom,sc7180
> > +
> > +      - description: Acer Chromebook 511 without Touchscreen no-esim (=
newest rev)
> > +        items:
> > +          - const: google,lazor-sku18
>
> All of these entries (existing and new) should be just one entry with:
>  - enum:
>      - ....
>      - ....
>  - const: qcom,sc7180

I believe we've had this discussion before. At least twice. Here's a
link to the last time you said "Ah, OK, I guess this is fine".

https://lore.kernel.org/r/d3d4d90b-85b5-5ad9-78e6-5a074c21af4f@linaro.org
