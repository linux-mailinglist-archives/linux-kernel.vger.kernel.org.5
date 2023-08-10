Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AB4777FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjHJRwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbjHJQhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:37:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFC9273E;
        Thu, 10 Aug 2023 09:36:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BDD866424;
        Thu, 10 Aug 2023 16:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3EDC433CA;
        Thu, 10 Aug 2023 16:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691685406;
        bh=BSii6h7dQ0AiVaEnC/x7rXj9az+FG25BK/9BAQs3xlA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oMpc8QrKes1v6+WUjszY/FrTspe/682xgAiwNfn4sPSDNlHpcbqU9fHJfnt8jy1rj
         QIraMIt9fXEhHOQTfnAx+hXMM3zv6RSIO35cYJqFpBgHwi3ZXPqS7Mi4atRVBJUGGV
         rp1W5mjNRXxxySZ0t7JpX6u9I1+CrsJ+JlQFosmXALjq3iDHb7qBcyHIcd+Us7HTj6
         jE/s0QAJDGmpJPv57mPlPa+a7HKU9iTAgRCBlsHS1JFRF5WugyDHpzwFX30Hia+hbL
         A3aMmWa+n+btqItwLqbCSu2TlyCRmH+/h0wgFY2r50IU6Qwzs6h5qs5Z4GGSIqt1zz
         W1RWH+hetDzLw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b9ab1725bbso17578881fa.0;
        Thu, 10 Aug 2023 09:36:46 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywcqgjsn4fLiYMi6b2jbnTAvBsyAFbfDloeogwC/MRe8Ujh619s
        HuwwLOzv+s3VamivSCnUHTRyNc9h4pHK5milFw==
X-Google-Smtp-Source: AGHT+IGvZg0aYNog8ttUlumgymSsNd7CaDsdwH7Z+984SGykjIn7WXZ3vZr7n5jdJOw8bGCBGpJqFveTkp+/OQRjjKk=
X-Received: by 2002:a2e:700c:0:b0:2b9:4492:1226 with SMTP id
 l12-20020a2e700c000000b002b944921226mr2427865ljc.11.1691685404667; Thu, 10
 Aug 2023 09:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230810061140.15608-1-quic_kbajaj@quicinc.com>
 <20230810061140.15608-2-quic_kbajaj@quicinc.com> <169165201539.3911513.11768504895031523847.robh@kernel.org>
 <8636b916-749e-2bf7-8ec6-202aff4ab872@quicinc.com>
In-Reply-To: <8636b916-749e-2bf7-8ec6-202aff4ab872@quicinc.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 10 Aug 2023 10:36:31 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+U3T2nqoNLnKcGjd7NXYxth6-CzBHbOyxSjfhGqaErAA@mail.gmail.com>
Message-ID: <CAL_Jsq+U3T2nqoNLnKcGjd7NXYxth6-CzBHbOyxSjfhGqaErAA@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: cache: qcom,llcc: Add LLCC compatible
 for QDU1000/QRU1000
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     agross@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@linaro.org, srinivas.kandagatla@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        andersson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 4:27=E2=80=AFAM Komal Bajaj <quic_kbajaj@quicinc.co=
m> wrote:
>
>
>
> On 8/10/2023 12:50 PM, Rob Herring wrote:
> > On Thu, 10 Aug 2023 11:41:35 +0530, Komal Bajaj wrote:
> >> Add LLCC compatible for QDU1000/QRU1000 SoCs and add optional
> >> nvmem-cells and nvmem-cell-names properties to support multiple
> >> configurations for multi channel DDR.
> >>
> >> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>   Documentation/devicetree/bindings/cache/qcom,llcc.yaml | 10 ++++++++=
++
> >>   1 file changed, 10 insertions(+)
> >>
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> >
> >
> > doc reference errors (make refcheckdocs):
> >
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/2023=
0810061140.15608-2-quic_kbajaj@quicinc.com
> >
> > The base for the series is generally the latest rc1. A different depend=
ency
> > should be noted in *this* patch.
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> >
> > pip3 install dtschema --upgrade
> >
> > Please check and re-submit after running the above command yourself. No=
te
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checkin=
g
> > your schema. However, it must be unset to test all examples with your s=
chema.
>
> Hi Rob,
> I did run the same steps locally after upgrading dtschema too, but it
> didn't reported any kind of error.
> Here also, error is not mentioned, can you please state what's the error
> reported with this patch?

No error. It's a problem with the bot's CI job.

Rob
