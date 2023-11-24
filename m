Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7517D7F72D3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344795AbjKXLfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjKXLfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:35:15 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD221700
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:35:19 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a013d22effcso242946666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1700825718; x=1701430518; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mq/q+zSacFh9TwkvYjfDYYCeewexARu63HiKzNInzCg=;
        b=Axl8QWf6I1f5BuCSu7wW0hMwesL2O6Rw8Ie9uCcVSMVOK2iu+gLW9cr61REERY8qNR
         +vkXKXdxPmKTp/JUCsZ5qOyduf4PSqqM9wY0dnNqyUxeazCfKos95q+p8DpjmpHTxzag
         SXUiwBx28Vcg1WSndGJhp7kb7twJZcgNx+AKSWFAIB9Buqlp3j81glnresbLhWZD7VS9
         DBTQhgbww6nvmJw5xjl6I4ef+rBUqVccmmhX/pohbH8/LbfzY/jFbokP/pZxRUzvheGJ
         Cs5qpTuFUCKG4ZLgna3TfcndL/BsvLl5h3GgcSL46oVnCQBm9JHQvUAUepC1bSt4CwVC
         5T8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700825718; x=1701430518;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mq/q+zSacFh9TwkvYjfDYYCeewexARu63HiKzNInzCg=;
        b=QhZSbZHp5cw8AqawyRQqiCkcSReX6/Zx74EfJCPoPpdgqhM9iD/atVvJIBNqqQYbty
         lJQ3wbS1b6yo/iOasYyuRwKP9aPj15b0pWJQ5BBcQX1nTA3UpxafrSfFzSdnAVswmtnZ
         ZaMnI1sp5ibkvtjC8SyVctaYmkNwNSP3TDk1R4/sMeQWLN0D8FdPyP8jp0XhEeknsFBe
         UjifbRc//cqTPD1zihS+p8kb87x2GsWaWFmGXaCyRcRYJic32i0ivimdkkTf1xCXcjCs
         w5UAYckFOqG4K6LZDWbN9tO/QbvLHU3FzP1JE4kkvfXrBj0rOI0xkaU82V7k+moBPvri
         3Pjw==
X-Gm-Message-State: AOJu0YwiROo/SQ6Cp7AybM5V6kjXcubZ93pgUchNLkTclx0DeEGSYxmB
        D+mvVoQgnCf90FLE3+HFW174Dg==
X-Google-Smtp-Source: AGHT+IFuJVLP/ukmcztwl/R4oM89EiqMEKf4bjA/lNBCTCp94tiW6nAOtKOWi35CKmAiFtBuvNehtQ==
X-Received: by 2002:a17:906:3042:b0:9cf:36be:3b5d with SMTP id d2-20020a170906304200b009cf36be3b5dmr1620418ejd.61.1700825718401;
        Fri, 24 Nov 2023 03:35:18 -0800 (PST)
Received: from localhost (dhcp-089-099-055-216.chello.nl. [89.99.55.216])
        by smtp.gmail.com with ESMTPSA id uz2-20020a170907118200b00a098348d803sm495339ejb.141.2023.11.24.03.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 03:35:18 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 24 Nov 2023 12:35:17 +0100
Message-Id: <CX70EBXCOB66.3998C482R86CN@fairphone.com>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sc7280: Move video-firmware to
 chrome-common
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Vikash Garodia" <quic_vgarodia@quicinc.com>,
        "Stanimir Varbanov" <stanimir.k.varbanov@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231002-sc7280-venus-pas-v2-0-bd2408891317@fairphone.com>
 <20231002-sc7280-venus-pas-v2-2-bd2408891317@fairphone.com>
 <4cfad910-1821-3a31-c372-3f6b199e8f71@quicinc.com>
 <CX5ENKY70B5J.2D6DXKGI4EGX3@fairphone.com>
 <ff021f49-f81b-0fd1-bd2c-895dbbb03d56@quicinc.com>
In-Reply-To: <ff021f49-f81b-0fd1-bd2c-895dbbb03d56@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Nov 24, 2023 at 7:38 AM CET, Vikash Garodia wrote:
>
> On 11/22/2023 7:50 PM, Luca Weiss wrote:
> > On Wed Nov 22, 2023 at 2:17 PM CET, Vikash Garodia wrote:
> >>
> >> On 10/2/2023 7:50 PM, Luca Weiss wrote:
> >>> If the video-firmware node is present, the venus driver assumes we're=
 on
> >>> a system that doesn't use TZ for starting venus, like on ChromeOS
> >>> devices.
> >>>
> >>> Move the video-firmware node to chrome-common.dtsi so we can use venu=
s
> >>> on a non-ChromeOS devices.
> >>>
> >>> At the same time also disable the venus node by default in the dtsi,
> >>> like it's done on other SoCs.
> >>>
> >>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> >>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 8 ++++++++
> >>>  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 6 ++----
> >>>  2 files changed, 10 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arc=
h/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> >>> index 5d462ae14ba1..cd491e46666d 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> >>> @@ -104,6 +104,14 @@ &scm {
> >>>  	dma-coherent;
> >>>  };
> >>> =20
> >>> +&venus {
> >>> +	status =3D "okay";
> >>> +
> >>> +	video-firmware {
> >>> +		iommus =3D <&apps_smmu 0x21a2 0x0>;
> >>> +	};
> >>> +};
> >>> +
> >>>  &watchdog {
> >>>  	status =3D "okay";
> >>>  };
> >>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/d=
ts/qcom/sc7280.dtsi
> >>> index 66f1eb83cca7..fa53f54d4675 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>> @@ -3740,6 +3740,8 @@ venus: video-codec@aa00000 {
> >>>  				 <&apps_smmu 0x2184 0x20>;
> 0x2184 is a secure SID. I think qcm6490-fairphone-fp5.dts needs to overri=
de the
> iommus property as well to retain only the non secure SID i.e 0x2180 ? I =
am
> seeing below crash
>
> Call trace:
> [   47.663593]  qcom_smmu_write_s2cr+0x64/0xa4
> [   47.663616]  arm_smmu_attach_dev+0x120/0x284
> [   47.663647]  __iommu_attach_device+0x24/0xf8
> [   47.676845]  __iommu_device_set_domain+0x70/0xd0
> [   47.681632]  __iommu_group_set_domain_internal+0x60/0x1b4
> [   47.687218]  iommu_setup_default_domain+0x358/0x418
> [   47.692258]  __iommu_probe_device+0x3e4/0x404
>
> Could you please reconfirm if Video SID 0x2184 (and mask) is allowed by t=
he
> qcm6490-fairphone-fp5 hardware having TZ ?

Hi,

On FP5 it seems it's no problem to have both SIDs in there, probe and
using venus appears to work fine.

Are you using different firmware than QCM6490.LA.3.0 on the device where
you tested this?

>
> >>>  			memory-region =3D <&video_mem>;
> >>> =20
> >>> +			status =3D "disabled";
> >>> +
> >>>  			video-decoder {
> >>>  				compatible =3D "venus-decoder";
> >>>  			};
> >>> @@ -3748,10 +3750,6 @@ video-encoder {
> >>>  				compatible =3D "venus-encoder";
> >>>  			};
> >>> =20
> >>> -			video-firmware {
> >>> -				iommus =3D <&apps_smmu 0x21a2 0x0>;
> >>> -			};
> >>> -
> >>>  			venus_opp_table: opp-table {
> >>>  				compatible =3D "operating-points-v2";
> >>> =20
> >>>
> >> Changes look good. Is this tested on SC7280 ?
> >=20
> > Hi Vikash,
> >=20
> > I didn't test it myself on sc7280 (just qcm6490-fp5) but dtx_diff
> > reports no differences except for status =3D okay property being added,=
 so
> > there should be no change on those boards. See below.
> >=20
> > Regards
> > Luca
>
> I tested on SC7280 (herobrine) and all good.

Great, thanks!

Regards
Luca

>
> Regards,
> Vikash

