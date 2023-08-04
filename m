Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0A8770605
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjHDQav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjHDQat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:30:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3425E46B1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:30:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so305324066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691166644; x=1691771444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI+FjztjAhlDqQ6jCUap2ilPY23v0NvrgrfzfYO4RIA=;
        b=BkIRNxnkRZfRkGvsp41p2m8kMmu1XVyZifIvifsUblLjkCuvnM5jK+eN8dNqbIBC/H
         e7lzPjOP/bhmxXnTxMSgv5FfsyEu9Zu5pXXEY56P9njo3sFJOPrpMPsJ629d21F0vhZI
         cQiKB1eZ9qUFxzwap1VRBaOQUVTnqKmgrTL1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691166644; x=1691771444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WI+FjztjAhlDqQ6jCUap2ilPY23v0NvrgrfzfYO4RIA=;
        b=Y2IdcjPt67gY6gbcuBttVE0INuGxk+IJl/fNOK0tKFNYYSng+0ynewrUxpcVhxOK8j
         yJZz5GsxoXcV4IAx6TCuRCemwNaNkJ6t5Zoqw8hOJ9DFZWgCDzZ6b5pKFVUM20qJyEo1
         eMcv8I8/T6a6DKRWsey2RZkucxMRUEahEF5fr6KIuzXVRfXu66TbIo1/UyiX6J21wWRn
         NbqLBAwSN8wqxRtmRbembjJ5Q3xmRhrf6ayaGmczksEcdvOLRJP9UlwXPKownnUmP8C7
         f45DMkPuHAPW5nq9F21qxhvHNP0b31dUc8l72bN6kxQBjka4pebYaeBUSjmULrRfmS09
         97Og==
X-Gm-Message-State: AOJu0YxqeZ0z9dTxLuGSY2+UldI+pOxQalizmP7qsISTmcTSC8XDl0Fe
        MMQB1XJDKzUK2N2YcwiCMz7DoIWfZmHP1hYj1uYwaoLT
X-Google-Smtp-Source: AGHT+IFWdSDqr6B9nMZoEWCN34Kb1vcrvVGUDkGaEl838tU2gRMbBDg4cz637rJeRIwFkPMVUnDBOA==
X-Received: by 2002:a17:906:292:b0:99c:b0c9:4ec7 with SMTP id 18-20020a170906029200b0099cb0c94ec7mr466922ejf.26.1691166644679;
        Fri, 04 Aug 2023 09:30:44 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id v8-20020a170906180800b009934855d8f1sm1530083eje.34.2023.08.04.09.30.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 09:30:44 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so11491a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:30:44 -0700 (PDT)
X-Received: by 2002:a50:c212:0:b0:523:ee1:8d27 with SMTP id
 n18-20020a50c212000000b005230ee18d27mr54911edf.1.1691166643789; Fri, 04 Aug
 2023 09:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230804095836.39551-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230804175734.v2.1.I7a950de49ec24b957e90d7fe7abd5f2f5f2e24c3@changeid>
In-Reply-To: <20230804175734.v2.1.I7a950de49ec24b957e90d7fe7abd5f2f5f2e24c3@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 4 Aug 2023 09:30:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WKPu2R_j3yh5OJcc95SmxgJsc3+HxSi9_Ks6TvUOYJ1w@mail.gmail.com>
Message-ID: <CAD=FV=WKPu2R_j3yh5OJcc95SmxgJsc3+HxSi9_Ks6TvUOYJ1w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: qcom: add sc7180-lazor board bindings
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

On Fri, Aug 4, 2023 at 2:58=E2=80=AFAM Sheng-Liang Pan
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
> Changes in v2:
> - add new entry rev9 with Parade bridge chip
>
>  .../devicetree/bindings/arm/qcom.yaml         | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentat=
ion/devicetree/bindings/arm/qcom.yaml
> index 450f616774e0..dce7b771a280 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -470,6 +470,11 @@ properties:
>            - const: google,lazor-rev8
>            - const: qcom,sc7180
>
> +      - description: Acer Chromebook Spin 513 Parade bridge chip (rev9)

You probably didn't need to include "Parade bridge chip" in the
description since that's implied by "rev9"


> @@ -512,11 +522,26 @@ properties:
>            - const: google,lazor-rev8-sku0
>            - const: qcom,sc7180
>
> +      - description: Acer Chromebook Spin 513 Parade bridge chip with LT=
E (rev9)
> +        items:
> +          - const: google,lazor-rev9-sku0
> +          - const: qcom,sc7180
> +
>        - description: Acer Chromebook Spin 513 with LTE (newest rev)
>          items:
>            - const: google,lazor-sku0
>            - const: qcom,sc7180
>
> +      - description: Acer Chromebook Spin 513 Parade bridge chip with LT=
E no-esim (rev9)
> +        items:
> +          - const: google,lazor-rev9-sku10
> +          - const: qcom,sc7180

The no-eSIM and normal LTE should be combined into one, just like they
are in your device tree. If you look at patch #3, you can see
"sc7180-trogdor-lazor-r9-lte.dts" contains:

compatible =3D "google,lazor-rev9-sku0", "google,lazor-rev9-sku10", "qcom,s=
c7180";

You need to have a single entry here that matches that. That means one
entry that has both rev9-sku0 and rev9-sku10.

You should be running "make dtbs_check" at the end of your series. As
Krzysztof would say, (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sourc=
es-with-the-devicetree-schema/
for instructions)


-Doug
