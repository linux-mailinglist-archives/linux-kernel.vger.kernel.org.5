Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED981810E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjLMKEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbjLMKEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:04:39 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF13107
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:04:44 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-dbcc9d4b1aeso728160276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702461883; x=1703066683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UW6j6VNL8VCBZjejnKXWYkB2uzhHDBsJkDlpkHGo9WI=;
        b=xA86cer1x73WQBw6eUxfMW2X21XpNk//+fjeRGf8tTb9N2KJ+6gfoue/niyyGwsIXZ
         cZs4MsPyBSxMI5bfNcUYMLk5y9YzrM2TvgtOQVMODgegWL3l9xqArCxBeLtpurWvM/T4
         zc0DC30OQiFkqBsUjPrvKrd6SvBNQKGnP1kR4AIw19ruooj5lQqtRW69qlBgu+wqGBHr
         CeB/2DLyB3yyMn0WQlhQe/YB31sYGHkaLodh6o0WI1i4HHuFiMbPNOivpwAcRdJ7AFeB
         K4MrqVIb0Bbdk9ZELxyn0YvI5I0rDRiylCvrpI2STPGGPeiqrDRs/ejeSvgbzEEtEt1V
         LrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702461883; x=1703066683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UW6j6VNL8VCBZjejnKXWYkB2uzhHDBsJkDlpkHGo9WI=;
        b=l3wWguUsar8oaHPFflQ4zXOh1AEiwKsEns4hzJ7KYb6004b2vx2G5KL6bSptUv15je
         riuR4FVTIJ+JuxSkWJOlLRTJZfciOxFyelZWmXrCzUblN/D+6e2pX/ft6BnmkVPAHeqK
         6HEurp8+7F25XP6pWvYh2UBu17Eb8SD5vMy1tgJQDDQ9UARZ3kkNJeOPn/RdKG0JfUYV
         TLxLJJ+YBzXlQlX6aEicHQ/SttKOR7Eseo+PgA4sX7elELZWqcBW9wnnba8lMjTLIyzF
         iB9AmZs5X/IJvXXANQlURAkWlKvPvuJeNUA6ho0VBk/lpfve1LeWBc8JtAbRlvhi46WO
         zTUQ==
X-Gm-Message-State: AOJu0YyjS5NMWbLYreHY8kJKEkyVfp5OMF/7tBLXelL9T1io7I13IVDt
        BKA1DtNxNYSNV2FBzeEK9qhwGDUxhz0q1BIh7HiQNA==
X-Google-Smtp-Source: AGHT+IECcIKBRun8rt0jvzDRIVumblmfcQvQhFUzWoInYyHHex90iGUYHdeBU8ksbyCQqmu0eQ+R4+SBWv8N9FwXnpo=
X-Received: by 2002:a05:6902:28c:b0:db7:dad0:76d2 with SMTP id
 v12-20020a056902028c00b00db7dad076d2mr4693790ybh.110.1702461883525; Wed, 13
 Dec 2023 02:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
 <20231117101817.4401-16-quic_tengfan@quicinc.com> <e3e27fec-8ab9-4331-a5aa-2958dd630b11@linaro.org>
 <420ce17d-279e-47ee-9935-35bc03b89f98@quicinc.com>
In-Reply-To: <420ce17d-279e-47ee-9935-35bc03b89f98@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 13 Dec 2023 12:04:32 +0200
Message-ID: <CAA8EJpqoUBbq52EHPK+TYC67RzRJt9pnDwLA1SrFdPmXxyG3dg@mail.gmail.com>
Subject: Re: [PATCH 15/16] arm64: dts: qcom: sm8550-aim300: add pmic glink port/endpoints
To:     Tengfei Fan <quic_tengfan@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tglx@linutronix.de,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 at 10:11, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>
>
>
> =E5=9C=A8 11/17/2023 6:32 PM, Dmitry Baryshkov =E5=86=99=E9=81=93:
> > On 17/11/2023 12:18, Tengfei Fan wrote:
> >> Add nodes to support Type-C USB/DP functionality.
> >>
> >> On this platform, a Type-C redriver is added to the SuperSpeed graph.
> >>
> >> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/sm8550-aim300.dts | 88 ++++++++++++++++++++=
+-
> >>   1 file changed, 87 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
> >> b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
> >> index 6dc3040b9f76..f3c558dd40f1 100644
> >> --- a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
> >> +++ b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
> >> @@ -100,7 +100,15 @@
> >>                       reg =3D <1>;
> >>                       pmic_glink_ss_in: endpoint {
> >> -                        remote-endpoint =3D <&usb_1_dwc3_ss>;
> >> +                        remote-endpoint =3D <&redriver_ss_out>;
> >> +                    };
> >> +                };
> >> +
> >> +                port@2 {
> >> +                    reg =3D <2>;
> >> +
> >> +                    pmic_glink_sbu: endpoint {
> >> +                        remote-endpoint =3D <&fsa4480_sbu_mux>;
> >>                       };
> >>                   };
> >>               };
> >> @@ -519,6 +527,62 @@
> >>       };
> >>   };
> >> +&i2c_master_hub_0 {
> >> +    status =3D "okay";
> >> +};
> >> +
> >> +&i2c_hub_2 {
> >> +    status =3D "okay";
> >> +
> >> +    typec-mux@42 {
> >> +        compatible =3D "fcs,fsa4480";
> >> +        reg =3D <0x42>;
> >> +
> >> +        vcc-supply =3D <&vreg_bob1>;
> >> +
> >> +        mode-switch;
> >> +        orientation-switch;
> >> +
> >> +        port {
> >> +            fsa4480_sbu_mux: endpoint {
> >> +                remote-endpoint =3D <&pmic_glink_sbu>;
> >> +            };
> >> +        };
> >> +    };
> >> +
> >> +    typec-retimer@1c {
> >> +        compatible =3D "onnn,nb7vpq904m";
> >> +        reg =3D <0x1c>;
> >> +
> >> +        vcc-supply =3D <&vreg_l15b_1p8>;
> >> +
> >> +        orientation-switch;
> >> +        retimer-switch;
> >> +
> >> +        ports {
> >> +            #address-cells =3D <1>;
> >> +            #size-cells =3D <0>;
> >> +
> >> +            port@0 {
> >> +                reg =3D <0>;
> >> +
> >> +                redriver_ss_out: endpoint {
> >> +                    remote-endpoint =3D <&pmic_glink_ss_in>;
> >> +                };
> >> +            };
> >> +
> >> +            port@1 {
> >> +                reg =3D <1>;
> >> +
> >> +                redriver_ss_in: endpoint {
> >> +                    data-lanes =3D <3 2 1 0>;
> >> +                    remote-endpoint =3D <&usb_dp_qmpphy_out>;
> >> +                };
> >> +            };
> >> +        };
> >> +    };
> >> +};
> >> +
> >>   &gcc {
> >>       clocks =3D <&bi_tcxo_div2>, <&sleep_clk>,
> >>            <&pcie0_phy>,
> >> @@ -552,6 +616,16 @@
> >>       status =3D "okay";
> >>   };
> >> +&mdss_dp0 {
> >> +    status =3D "okay";
> >> +};
> >> +
> >> +&mdss_dp0_out {
> >> +    data-lanes =3D <0 1>;
> >
> > Why? Are you really limited to two lanes for DP by the hardware?
> I got confirmation from a colleague that it is right that limited to two
> lanes.

Excuse me, I missed your reply earlier. Is it 2 DP lanes and 2 SS USB
lanes? Or are there just 2 lanes which are shared between DP and SS
USB?

> >
> >> +    remote-endpoint =3D <&usb_dp_qmpphy_dp_in>;
> >> +};
> >> +
> >> +
> >>   &mdss_dsi0 {
> >>       vdda-supply =3D <&vreg_l3e_1p2>;
> >>       status =3D "okay";
> >> @@ -861,6 +935,18 @@
> >>       status =3D "okay";
> >>   };
> >> +&usb_dp_qmpphy_dp_in {
> >> +    remote-endpoint =3D <&mdss_dp0_out>;
> >> +};
> >> +
> >> +&usb_dp_qmpphy_out {
> >> +    remote-endpoint =3D <&redriver_ss_in>;
> >> +};
> >> +
> >> +&usb_dp_qmpphy_usb_ss_in {
> >> +    remote-endpoint =3D <&usb_1_dwc3_ss>;
> >> +};
> >> +
> >>   &xo_board {
> >>       clock-frequency =3D <76800000>;
> >>   };
> >
>
> --
> Thx and BRs,
> Tengfei Fan



--=20
With best wishes
Dmitry
