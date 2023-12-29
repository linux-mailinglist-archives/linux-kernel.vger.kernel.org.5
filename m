Return-Path: <linux-kernel+bounces-13011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE5C81FE68
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4D01C22B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AE210A09;
	Fri, 29 Dec 2023 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="bfUwC1If"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8510A31
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a2331e7058aso802035466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 01:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1703840456; x=1704445256; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YFW2Iq8e4IPK1klqEUPGasZZ4lNFL4o1U6qQyaGioA=;
        b=bfUwC1IfPl9BrSIPCEdLyPwGiW5Jasbb+GV7gUIqeJUIqNUIqHrX/BJOAuTO8ys/g3
         YHaqN9v38oHo0s0y6lGZIZSNi5BJCdngr44CiCeWCuACEtX1MaQ2bgNS3xEJMBS5V8in
         ixCUO652TGVBr63mMpUX6UOn+aZUTlzH6hU7FPa9HJPGhh3mLjmANw//rGDDaYEpAy00
         Eq2j2iQRIsq8yqSbsTxBZGxwxVD/qYHC0v9e+kmrq++xRSNayDM05IGZWBebdbfPkSwk
         tQagy/tRExtug1R1Jzt4QlPE4H4bPNYdLkb/LV0PH6683LmAyC83/63RQYT1teShK7+l
         Sxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703840456; x=1704445256;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4YFW2Iq8e4IPK1klqEUPGasZZ4lNFL4o1U6qQyaGioA=;
        b=Iwo/mpVD4fht6LqshQm9HIkxK6rQRgswFMu3uEBF4jV9bx++FEZ9jzb6pe45JrPQxB
         B8ITzhCFp0IAiZ9M9JHhqPixlllpY7Du6n2dVUnf+Y8d4n29kIvO4wBmFaSDAWGnSuiV
         AFUoLJWGc6S+FzkbeNc3H0UiJ7cPmovU4iES9j6hUiHvJZdByjnZNnAwFMN3flEu7srU
         UaFwuNPJaEiAAgojzvfT5NGOPhtl4zgzcrGLd6cBixvdwqlHAeLkRYtPRWv1z+1tqHJF
         K7Rc9DqGIK8KsIgjhIOzH4gWTEmxdDeMk1V8JW/ZgZstC/inbtOUjT2Ny6P4Hl1UCD/u
         YLgQ==
X-Gm-Message-State: AOJu0YztW2YvoA8MnXtxqX24zKKD5C+fJGs5k7mIdp86xvjvor3By2gv
	2F3Fblb+hqbo+DLHZAmr7vJAyJlCmzsdsA==
X-Google-Smtp-Source: AGHT+IFsgyvxY2FIbSeZ4Rhwj26H1SnL4iCSe5/raWPACAtLD2F4iWeQeP0GVD7tgQnJsAiTpkU2iA==
X-Received: by 2002:a17:906:6016:b0:a26:a0d9:10a7 with SMTP id o22-20020a170906601600b00a26a0d910a7mr2218391ejj.76.1703840455776;
        Fri, 29 Dec 2023 01:00:55 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id bz8-20020a1709070aa800b00a234b686f93sm8161508ejc.187.2023.12.29.01.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 01:00:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 Dec 2023 10:00:54 +0100
Message-Id: <CY0P173KMGJY.25N4DSRYNK5A7@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Om Prakash Singh"
 <quic_omprsing@quicinc.com>
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
X-Mailer: aerc 0.15.2
References: <20231214103600.2613988-1-quic_omprsing@quicinc.com>
 <20231214103600.2613988-3-quic_omprsing@quicinc.com>
 <CY01EKQVWE36.B9X5TDXAREPF@fairphone.com>
In-Reply-To: <CY01EKQVWE36.B9X5TDXAREPF@fairphone.com>

On Thu Dec 28, 2023 at 3:29 PM CET, Luca Weiss wrote:
> On Thu Dec 14, 2023 at 11:36 AM CET, Om Prakash Singh wrote:
> > Add the QCE and Crypto BAM DMA nodes.
> >
> > Signed-off-by: Om Prakash Singh <quic_omprsing@quicinc.com>
> > ---
> >
> > Changes in V3:
> >   - V2 patch was sent without actual modification. Resending the patch =
with modified file.
> >
> > Changes in V2:
> >   - Update DT node sequence as per register ascending order.
> >   - Fix DT node properties as per convention.
> >
> >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts=
/qcom/sc7280.dtsi
> > index 66f1eb83cca7..b819724c1255 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > @@ -2233,6 +2233,28 @@ pcie1_phy: phy@1c0e000 {
> >  			status =3D "disabled";
> >  		};
> > =20
> > +		cryptobam: dma-controller@1dc4000 {
> > +			compatible =3D "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> > +			reg =3D <0x0 0x01dc4000 0x0 0x28000>;
> > +			interrupts =3D <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> > +			#dma-cells =3D <1>;
> > +			iommus =3D <&apps_smmu 0x4e4 0x0011>,
> > +				 <&apps_smmu 0x4e6 0x0011>;
> > +			qcom,ee =3D <0>;
> > +			qcom,controlled-remotely;
> > +		};
>
> Hi,
>
> Unfortunately I seem to have boot failure / device crash with cryptobam
> enabled on my qcm6490-fairphone-fp5. Are you aware of any firmware
> differences that could cause this with QCM6490 LA firmware?
>
> Looking at downstream msm-5.4 dmesg I do see this BAM being used so it
> should generally be accessible from Linux.
>
> [    5.217214] qce 1de0000.qcedev: Adding to iommu group 18
> [    5.223741] QCE50: __qce_get_device_tree_data: CE operating frequency =
is not defined, setting to default 100MHZ
> [    5.234986] qce 1de0000.qcedev: QTI Crypto 5.6.0 device found @0x1de00=
00
> [    5.242981] sps_register_bam_device: sps:BAM 0x0000000001dc4000 is reg=
istered
> [    5.251124] sps_bam_enable: sps:BAM 0x0000000001dc4000 (va:0x000000001=
db63156) enabled: ver:0x27, number of pipes:16
> [    5.262783] QCE50: qce_sps_init:  QTI MSM CE-BAM at 0x0000000001dc4000=
 irq 9
> [    5.271820] qce 1de0000.qcedev:qcom_cedev_ns_cb: Adding to iommu group=
 19
> [    5.281083] qce 1de0000.qcedev:qcom_cedev_s_cb: Adding to iommu group =
20
> [    5.289376] qcrypto 1de0000.qcrypto: Adding to iommu group 21
> [    5.296326] QCE50: __qce_get_device_tree_data: CE operating frequency =
is not defined, setting to default 100MHZ
> [    5.307675] qcrypto 1de0000.qcrypto: QTI Crypto 5.6.0 device found @0x=
1de0000
> [    5.315867] QCE50: qce_sps_init:  QTI MSM CE-BAM at 0x0000000001dc4000=
 irq 9

After some hints from Stephan Gerhold, it looks like when the bam driver
tries to read the registers for getting num-ees and num-channels we
need to have the interconnect up, otherwise the register read fails and
resets the device into EDL mode.

After applying the patch I've attached below the registers can be read
successfully.

The patch I've actually sent now[0] adds the values read from these
registers as static properties so that during cryptobam probe we don't
need to have the interconnect up because we don't read any registers.
Stephan Gerhold mentioned off-list that this is an adequate solution
because all the other times the cryptobam is used by the &crypto node
the interconnect will be up.

[0] https://lore.kernel.org/linux-arm-msm/20231229-sc7280-cryptobam-fixup-v=
1-1-bd8f68589b80@fairphone.com/T/#u

I imagine the cause why cryptobam & crypto are disabled in sm8350.dtsi
is the same, so the solution there probably also is just hardcoding
those properties and then using &crypto should work as expected.

Regards
Luca

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qco=
m/sc7280.dtsi
index 83b5b76ba179..b2517631e884 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2345,6 +2345,9 @@ cryptobam: dma-controller@1dc4000 {
 				 <&apps_smmu 0x4e6 0x0011>;
 			qcom,ee =3D <0>;
 			qcom,controlled-remotely;
+			interconnects =3D <&aggre2_noc MASTER_CRYPTO QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names =3D "memory";
 		};
=20
 		crypto: crypto@1dfa000 {
diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 5e7d332731e0..b2f85c6bcbea 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -40,6 +40,7 @@
 #include <linux/circ_buf.h>
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
+#include <linux/interconnect.h>
 #include <linux/pm_runtime.h>
=20
 #include "../dmaengine.h"
@@ -394,6 +395,7 @@ struct bam_device {
 	const struct reg_offset_data *layout;
=20
 	struct clk *bamclk;
+	struct icc_path *mem_path;
 	int irq;
=20
 	/* dma start transaction tasklet */
@@ -1298,6 +1300,14 @@ static int bam_dma_probe(struct platform_device *pde=
v)
 		return ret;
 	}
=20
+	bdev->mem_path =3D devm_of_icc_get(bdev->dev, "memory");
+	if (IS_ERR(bdev->mem_path))
+		return PTR_ERR(bdev->mem_path);
+
+	ret =3D icc_set_bw(bdev->mem_path, 1, 1);
+	if (ret)
+		return ret;
+
 	ret =3D bam_init(bdev);
 	if (ret)
 		goto err_disable_clk;

