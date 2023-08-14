Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576ED77B2CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjHNHnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbjHNHnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:43:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD2210C0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:43:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5255da974c4so1303868a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1691998984; x=1692603784;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SkdvgZrpNCBNVq541zdKdiiiiZ2r32O7R+V73IZDsk=;
        b=00U/dncPTh9ZmUzHnFIyb73hQMRSaPdOjHn8oqd1W8BRRxeYfnEv84NGPhVX2cK1ga
         QP53lHSy3yQcNMnGAoVrS++I07UQCfguw70JcoWUVzOk0V6W//jOCSdv+KHUdvUoB2nt
         gbxVYdLiNkBAus3gXR+gncbVSHOvk6w9nRCGWHv4hnAe3CSok1c7W2TSbHE364dk9H/2
         AUK8KIPQBHVYBsLku67CDRH8mqg+3HEC6bqo/8RZCdlxsdky02XpHexkAg4EV01JR/gD
         YDiSatsEU49TahfnxvSEnijTY8Y9SRkus81W7aZEaS8BRZntO9GEJtbsBBUQp/Ns3q8k
         q5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691998984; x=1692603784;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2SkdvgZrpNCBNVq541zdKdiiiiZ2r32O7R+V73IZDsk=;
        b=dwHBbt9gV/B3Hs+hMQgy1wIm1x+FZ262QBttmqx7i8d3BI00azhUZu2j4ffi6+fBwj
         KHGmCt960Bulm/oeKZnppZ6zi9yfhlFLyrSndnm6hZmqmww9m3fHSEG9nbaebzBnm3aj
         8q749goPyV0+/05eV22kOn0841s4jPbReeZyXk0QA0rUv8LbnMMUbFnnqEvV/7L+joiB
         hnJIeTEEKnK32t/oD9xOBQzRyfGk040MEFj7E6guRMOCcRYbf5kYhWGZ2tAEUVpEyBY5
         wJ0fwHUyj0C3y7dePXUgfaR+J/zt/7zRvnKhROKI02L+KE0epcT/q8XuzSceD8uDA3DQ
         Cv8A==
X-Gm-Message-State: AOJu0YwjW9lV4Jic2oxN6rHc6231qzbeho78H3h/Cm3OBE7qLcvW+Em0
        pKq0rlpqG/96Vz0J+W6m7ppCeg==
X-Google-Smtp-Source: AGHT+IFKd2I6pYof/pk5jG621n7sFXOTIZnPv7RloCIWA3j4n30gcTqyNdbeoW7ZwFmBEbuortd0zA==
X-Received: by 2002:a17:906:3019:b0:99b:65fa:e30f with SMTP id 25-20020a170906301900b0099b65fae30fmr7278786ejz.1.1691998984027;
        Mon, 14 Aug 2023 00:43:04 -0700 (PDT)
Received: from localhost (212095005216.public.telering.at. [212.95.5.216])
        by smtp.gmail.com with ESMTPSA id a18-20020a17090640d200b00993a9a951fasm5448385ejk.11.2023.08.14.00.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 00:43:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 09:43:02 +0200
Message-Id: <CUS3KXRIND5J.VSB0PVWXZ4DO@otso>
To:     "Fenglin Wu" <quic_fenglinw@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <dmitry.baryshkov@linaro.org>
Cc:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_kamalw@quicinc.com>, <jestar@qti.qualcomm.com>
Subject: Re: [PATCH v4 0/3] Add support for vibrator in multiple PMICs
From:   "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.15.2
References: <20230731053712.2220898-1-quic_fenglinw@quicinc.com>
In-Reply-To: <20230731053712.2220898-1-quic_fenglinw@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenglin,

On Mon Jul 31, 2023 at 7:37 AM CEST, Fenglin Wu wrote:
> Add SW support for the vibrator module inside PMI632, PM7250B, PM7325B, P=
M7550BA.
> It is very similar to the vibrator module inside PM8916 which is supporte=
d in
> pm8xxx-vib driver but just the drive amplitude is controlled with 2 regis=
ters,
> and the register base offset in each PMIC is different.

Briefly tested on a SDM632+PMI632-based Fairphone 3.

I didn't really check for vibration strength or anything more detailed
but with the fftest tool the vibrator seems to work fine!

Diff is attached below. I can send the pmi632.dtsi change once this
series is merged (unless you send something first).

Many thanks for sending these patches!

Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sdm632-fairphone-fp3 (pm=
i632)

Regards
Luca


diff --git a/arch/arm64/boot/dts/qcom/pmi632.dtsi b/arch/arm64/boot/dts/qco=
m/pmi632.dtsi
index 4eb79e0ce40a..41ef7dad508e 100644
--- a/arch/arm64/boot/dts/qcom/pmi632.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi632.dtsi
@@ -161,5 +161,11 @@ pmi632_lpg: pwm {
=20
 			status =3D "disabled";
 		};
+
+		pmi632_vib: vibrator@5700 {
+			compatible =3D "qcom,pmi632-vib", "qcom,spmi-vib-gen2";
+			reg =3D <0x5700>;
+			status =3D "disabled";
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts b/arch/arm64=
/boot/dts/qcom/sdm632-fairphone-fp3.dts
index 301eca9a4f31..0d89bc39f613 100644
--- a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
+++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
@@ -112,6 +112,10 @@ led@3 {
 	};
 };
=20
+&pmi632_vib {
+	status =3D "okay";
+};
+
 &sdhc_1 {
 	status =3D "okay";
 	vmmc-supply =3D <&pm8953_l8>;

> Changes in v4:
>   1. Update to use the combination of the HW type and register offset
>      as the constant match data, the register base address defined in
>      'reg' property will be added when accessing SPMI registers using
>      regmap APIs.
>   2. Remove 'qcom,spmi-vib-gen1' generic compatible string.
>
> Changes in v3:
>   1. Refactor the driver to support different type of the vibrators with
>     better flexibility by introducing the HW type with corresponding
>     register fields definitions.
>   2. Add 'qcom,spmi-vib-gen1' and 'qcom,spmi-vib-gen2' compatible
>     strings, and add PMI632, PM7250B, PM7325B, PM7550BA as compatbile as
>     spmi-vib-gen2.
> =20
> Changes in v2:
>   Remove the "pm7550ba-vib" compatible string as it's compatible with pm7=
325b.
>
> Fenglin Wu (3):
>   input: pm8xxx-vib: refactor to easily support new SPMI vibrator
>   dt-bindings: input: qcom,pm8xxx-vib: add new SPMI vibrator module
>   input: pm8xxx-vibrator: add new SPMI vibrator support
>
>  .../bindings/input/qcom,pm8xxx-vib.yaml       |  16 +-
>  drivers/input/misc/pm8xxx-vibrator.c          | 171 ++++++++++++------
>  2 files changed, 132 insertions(+), 55 deletions(-)

