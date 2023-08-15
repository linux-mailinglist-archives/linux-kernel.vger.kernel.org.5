Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4E277C7E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbjHOGfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbjHOGfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:35:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB901980
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 23:35:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99d6d5054bcso959185466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 23:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1692081331; x=1692686131;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Laq6PLZD5mjNGl8B5CwbzlD1BLPbLGW1CktYeIcSz2s=;
        b=s+r0v90PFyDxPteMQ4Q1nvVqnU9n3FQrvy9GiQjh133sKXmnnJW6mp3vKZU82EMYHk
         XRZJj/KbtU8nT6GShMoB4ALcEsXJtB2876YeqoVP3gsYJYrbxh8m7DLFX9gLvAQj7yVV
         3P26DVgoPaQ1ZQGfHlCcGco/Q+h8w9lPqnYUNjl+9OVDe5n1GnA9E9ZBFXBTiIer+MIk
         E4ncG0CLvjYfafkEb4VaVzVYbRe6HZ2uvM+rkmlRyNsi2/sunEa9X3TLPFnPTUSTmuLi
         VcJTQpg9q+qA8oZ7bMLpc8JxqvEqmdNYnc2sKpktQzhMBBjBbYILiLf+GQGCtiT81q+Q
         U2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692081331; x=1692686131;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Laq6PLZD5mjNGl8B5CwbzlD1BLPbLGW1CktYeIcSz2s=;
        b=W7TvhGjcdtl/8Y3jxClbPlJjSeBZzgNyYf7qL9gEgm+OFAr1wWwHuatKvpg6Nl4Rq2
         ibZ8pdMtLESr1LN0Gl++cH7SzfNMbufWIoG03SQDxLtZVCUsiFX1R6VXx2liMlnfMftp
         hhxw8ws3o9I2JkGysgdxENeKNeiijlhBd7EyYGd9hAcSD3yAag05eERQL1vucefLdkgi
         czOPMcGOas6REkcp5nj4mpBcUq8BcMKd2eEX8euDbYwDvPsMgmQ7KbYsiOgs6HptZE6p
         Ko/7WETLtlojOSEYlpW36OQqygSGwcbNdGp8xLHLp2m7zalBZ8QmmiUXLyE+guuBsCvs
         3x1w==
X-Gm-Message-State: AOJu0YwgzjsL276yPUlf21N2k6mNteq9oj8Mn/SsIdIA1RNhzRoA7LFs
        pkQSxy71fPnpp1J7enXY8mZkpQ==
X-Google-Smtp-Source: AGHT+IETPNF/Z7ilokCcWZfAWD0iGmFiBWijqpMV+ohFGBHjoHuPVeTOv2HfMMA3Ns4Wy2omaUMAFQ==
X-Received: by 2002:a17:907:7b93:b0:991:d414:d889 with SMTP id ne19-20020a1709077b9300b00991d414d889mr1158350ejc.15.1692081331176;
        Mon, 14 Aug 2023 23:35:31 -0700 (PDT)
Received: from localhost (212095005038.public.telering.at. [212.95.5.38])
        by smtp.gmail.com with ESMTPSA id c8-20020a17090654c800b0099cf91fe297sm6724368ejp.13.2023.08.14.23.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 23:35:30 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 15 Aug 2023 08:35:29 +0200
Message-Id: <CUSWRRL6QOPU.1YM7S0F8F3V2D@otso>
To:     "Fenglin Wu" <quic_fenglinw@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <dmitry.baryshkov@linaro.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>
Cc:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_kamalw@quicinc.com>, <jestar@qti.qualcomm.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: input: qcom,pm8xxx-vib: add new
 SPMI vibrator module
From:   "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.15.2
References: <20230815060314.352103-1-quic_fenglinw@quicinc.com>
 <20230815060314.352103-3-quic_fenglinw@quicinc.com>
In-Reply-To: <20230815060314.352103-3-quic_fenglinw@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenglin,

On Tue Aug 15, 2023 at 8:03 AM CEST, Fenglin Wu wrote:
> Add compatible strings to support vibrator module inside PMI632,
> PMI7250B, PM7325B, PM7550BA.
>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  .../bindings/input/qcom,pm8xxx-vib.yaml           | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml=
 b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
> index c8832cd0d7da..72b72c67a9b6 100644
> --- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
> +++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
> @@ -11,10 +11,17 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - qcom,pm8058-vib
> -      - qcom,pm8916-vib
> -      - qcom,pm8921-vib
> +    oneOf:
> +      - enum:
> +          - qcom,pm8058-vib
> +          - qcom,pm8916-vib
> +          - qcom,pm8921-vib
> +      - items:
> +          - enum:
> +              - qcom,pm7250b-vib
> +              - qcom,pm7325b-vib
> +              - qcom,pm7550ba-vib
> +          - const: qcom,pmi632-vib

With the new revision the standalone 'compatible =3D "qcom,pmi632-vib";'
doesn't pass validation anymore.

foo.dtb: vibrator@5700: compatible: 'oneOf' conditional failed, one must be=
 fixed:
        ['qcom,pmi632-vib'] is too short
        'qcom,pmi632-vib' is not one of ['qcom,pm8058-vib', 'qcom,pm8916-vi=
b', 'qcom,pm8921-vib']
        'qcom,pmi632-vib' is not one of ['qcom,pm7250b-vib', 'qcom,pm7325b-=
vib', 'qcom,pm7550ba-vib']
        from schema $id: http://devicetree.org/schemas/input/qcom,pm8xxx-vi=
b.yaml#

I believe you need to add the compatible also like this:

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml b=
/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
index 72b72c67a9b6..2025d6a5423e 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
+++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
@@ -16,6 +16,7 @@ properties:
           - qcom,pm8058-vib
           - qcom,pm8916-vib
           - qcom,pm8921-vib
+          - qcom,pmi632-vib
       - items:
           - enum:
               - qcom,pm7250b-vib


Regards
Luca

> =20
>    reg:
>      maxItems: 1

