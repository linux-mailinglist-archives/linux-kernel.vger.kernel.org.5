Return-Path: <linux-kernel+bounces-12700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0934281F915
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BBB1F22DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2128832;
	Thu, 28 Dec 2023 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="dv8rhXUf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B05C8D2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2345aaeb05so663767466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 06:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1703773797; x=1704378597; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfOkw9nEcZxbA1rEGXnw7Xr3Fbv2QGCNa/sv3AZ14y4=;
        b=dv8rhXUfeIIde9MZGjI6hLX+c81tekNQVvOna8wokRJYaskThEmkjZYVcF/8UpVNCA
         WJvzBrDudVuXUJLvRRMGFNAs8WtmxyuyueFvSJhJ+dH9MnSewQju440m90hKwZZAa0om
         EgT6qlyZDvDCdWti/BMZksKdrs6NyWCgFer1tHKrgEWph9k43KGI3aLlLZfAAfwFXLF8
         U0azGfF+09/drjuMrS8jDXlqVMLvS8kAeywrbt/EGcJEWcGLD8zE0rJLTgyqAqUjK6Ww
         Kuy+6x16nf1MtO3T0xaQvNIvZ2+6MXejx7NpdRdH260DejMtu4KIswRtwt6++COxddGn
         rZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703773797; x=1704378597;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IfOkw9nEcZxbA1rEGXnw7Xr3Fbv2QGCNa/sv3AZ14y4=;
        b=VDjrg5S2e05KFKHMZF1CIC6D8esfp5ourW638Q5/eFevf5DDW1SH2zAsVo9/Hr/QKG
         s4IdD57bgrqNEbYiV3kswk+nOT5kiWCh1s00TsaJHaN485ST5imiSdwdfVBCc64cCEv5
         uBZD6WsgbHacOVNAuAjY+wQPpodedfzujYa1z/g0qzMDrrpE4g0FgXR1GQ1YbWegPncn
         PICh9ZbAEbmjcfoooQXjf+bhBnTaz4wlQ+UQNX+A5v0E5V5ip+4sUc4L+YAZ58KuJMoO
         pQLRtRG0MBR3arb37hQg4aqzT4DdCcHSeYmRiGM47mT6Kx4f5ya3hsfuVkJ1GcWXpN28
         N1xA==
X-Gm-Message-State: AOJu0YwsfVn44+pgDxw6nBLY5/tP2od9PwIe4pfv0vke/GT7kkK0Q+Qx
	Xo7LQUdtXDcbUWhoJu5r93S+V4gzKKToXQ==
X-Google-Smtp-Source: AGHT+IEwzibakp4+9ZXJZVidzN9ogA4Ep77wRAfVlvNC3XZ4Cuo92tm68q7JErfyuMvnMmslNephwA==
X-Received: by 2002:a17:906:7810:b0:a12:78b5:3d81 with SMTP id u16-20020a170906781000b00a1278b53d81mr4527886ejm.1.1703773797149;
        Thu, 28 Dec 2023 06:29:57 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id r25-20020a170906281900b00a1f7c502736sm7523221ejc.164.2023.12.28.06.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 06:29:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Dec 2023 15:29:56 +0100
Message-Id: <CY01EKQVWE36.B9X5TDXAREPF@fairphone.com>
Cc: <neil.armstrong@linaro.org>, <konrad.dybcio@linaro.org>,
 <agross@kernel.org>, <andersson@kernel.org>, <conor+dt@kernel.org>,
 <davem@davemloft.net>, <devicetree@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <krzysztof.kozlowski+dt@linaro.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <marijn.suijten@somainline.org>,
 <robh+dt@kernel.org>, <vkoul@kernel.org>,
 <cros-qcom-dts-watchers@chromium.org>
Subject: Re: [PATCH V3 2/2] arm64: dts: qcom: sc7280: add QCrypto nodes
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Om Prakash Singh" <quic_omprsing@quicinc.com>
X-Mailer: aerc 0.15.2
References: <20231214103600.2613988-1-quic_omprsing@quicinc.com>
 <20231214103600.2613988-3-quic_omprsing@quicinc.com>
In-Reply-To: <20231214103600.2613988-3-quic_omprsing@quicinc.com>

On Thu Dec 14, 2023 at 11:36 AM CET, Om Prakash Singh wrote:
> Add the QCE and Crypto BAM DMA nodes.
>
> Signed-off-by: Om Prakash Singh <quic_omprsing@quicinc.com>
> ---
>
> Changes in V3:
>   - V2 patch was sent without actual modification. Resending the patch wi=
th modified file.
>
> Changes in V2:
>   - Update DT node sequence as per register ascending order.
>   - Fix DT node properties as per convention.
>
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/q=
com/sc7280.dtsi
> index 66f1eb83cca7..b819724c1255 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2233,6 +2233,28 @@ pcie1_phy: phy@1c0e000 {
>  			status =3D "disabled";
>  		};
> =20
> +		cryptobam: dma-controller@1dc4000 {
> +			compatible =3D "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> +			reg =3D <0x0 0x01dc4000 0x0 0x28000>;
> +			interrupts =3D <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells =3D <1>;
> +			iommus =3D <&apps_smmu 0x4e4 0x0011>,
> +				 <&apps_smmu 0x4e6 0x0011>;
> +			qcom,ee =3D <0>;
> +			qcom,controlled-remotely;
> +		};

Hi,

Unfortunately I seem to have boot failure / device crash with cryptobam
enabled on my qcm6490-fairphone-fp5. Are you aware of any firmware
differences that could cause this with QCM6490 LA firmware?

Looking at downstream msm-5.4 dmesg I do see this BAM being used so it
should generally be accessible from Linux.

[    5.217214] qce 1de0000.qcedev: Adding to iommu group 18
[    5.223741] QCE50: __qce_get_device_tree_data: CE operating frequency is=
 not defined, setting to default 100MHZ
[    5.234986] qce 1de0000.qcedev: QTI Crypto 5.6.0 device found @0x1de0000
[    5.242981] sps_register_bam_device: sps:BAM 0x0000000001dc4000 is regis=
tered
[    5.251124] sps_bam_enable: sps:BAM 0x0000000001dc4000 (va:0x000000001db=
63156) enabled: ver:0x27, number of pipes:16
[    5.262783] QCE50: qce_sps_init:  QTI MSM CE-BAM at 0x0000000001dc4000 i=
rq 9
[    5.271820] qce 1de0000.qcedev:qcom_cedev_ns_cb: Adding to iommu group 1=
9
[    5.281083] qce 1de0000.qcedev:qcom_cedev_s_cb: Adding to iommu group 20
[    5.289376] qcrypto 1de0000.qcrypto: Adding to iommu group 21
[    5.296326] QCE50: __qce_get_device_tree_data: CE operating frequency is=
 not defined, setting to default 100MHZ
[    5.307675] qcrypto 1de0000.qcrypto: QTI Crypto 5.6.0 device found @0x1d=
e0000
[    5.315867] QCE50: qce_sps_init:  QTI MSM CE-BAM at 0x0000000001dc4000 i=
rq 9

Any idea?

Regards
Luca

> +
> +		crypto: crypto@1dfa000 {
> +			compatible =3D "qcom,sc7280-qce", "qcom,sm8150-qce", "qcom,qce";
> +			reg =3D <0x0 0x01dfa000 0x0 0x6000>;
> +			dmas =3D <&cryptobam 4>, <&cryptobam 5>;
> +			dma-names =3D "rx", "tx";
> +			iommus =3D <&apps_smmu 0x4e4 0x0011>,
> +				 <&apps_smmu 0x4e4 0x0011>;
> +			interconnects =3D <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>=
;
> +			interconnect-names =3D "memory";
> +		};
> +
>  		ipa: ipa@1e40000 {
>  			compatible =3D "qcom,sc7280-ipa";
> =20


