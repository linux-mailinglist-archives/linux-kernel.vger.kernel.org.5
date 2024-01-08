Return-Path: <linux-kernel+bounces-19700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E394827123
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32551C22A14
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963024778A;
	Mon,  8 Jan 2024 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Z8T0L5q4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8824653D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5542a7f1f3cso2066690a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 06:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1704723759; x=1705328559; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMMgLl4XRQ9TLf0vUhTzomvNdXTeUOyP7FWSiUcr6oQ=;
        b=Z8T0L5q4j5AqzRGryoPzRdRWGrL2nOridhnSiCHpPzMRMjY576uZ1tqfG3KUiMcRSX
         gGmc0sB2rTI47mzYSeUJs0I0A4ItLpL2OvIWf7Fub3I0EGbtRFyTPwMq7pKp+43l1XxV
         Ob1Ck8xLVwX0Dnv95ZsUQ1AmShw8+6yYlBOHyQQLtgf8fkI8qT+S9akIfp7HD46ztOPd
         wkk+tB1WzGIY/pRrdXOvAhM+/bp3b8RHXve/Gc77x9HbuZxR5W67e1UVN9mFTpmtXeOq
         rHMasYauoH9JbGIvgEziHufqa16BhwFQoD8dZnfodWu8n2trFYxnd7YL7+I806ikjmkF
         R4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723759; x=1705328559;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OMMgLl4XRQ9TLf0vUhTzomvNdXTeUOyP7FWSiUcr6oQ=;
        b=lcTdCDTwUKGJ+3XLgJhDtvFuC0sOljWk8kNLsdoXPtVBfGGsc7Emj2WwR7g1Xz/eg0
         bPmDaSSbLKCP93CUOeZCQNEhHze0P+ivTc5ux4+GQqXd3C6vZ2sfbWbvFAHqu4CQC34Y
         vHlrsQ4FbbsQFYQ5IJJqFbHIqJWR9hEngI4eYrRmb8nL03zFBDRPEcAe0Xy7rAHMHItj
         phkroXy+1hS3J1raWSv48eM2/6sXET4776UIHBL6Eu1LwMrAzkMplEQLIGmKuQfulk7E
         hw3gGIoBhYsH3PUZoaUiuMSl3ALF7Z+xlKW3qmcOclKJ3Wa+YYRiFvd1GgiXXWk8Ibmn
         c5rw==
X-Gm-Message-State: AOJu0YzAIprfUHsi+vMbJxoa6ip5zgW2iDhfn3dNi4L0MlovDhNw7/Tn
	m+LvGVLaIm08aN3BxzF5I8JXoSxtNSnvMQ==
X-Google-Smtp-Source: AGHT+IHemUG5qaZGoETj95zldC92QIk78YaPkA4snM+h6XObqyWR81gB9QZGYvlmTpVCVXCM/O+zLQ==
X-Received: by 2002:a50:c29a:0:b0:557:aba8:631 with SMTP id o26-20020a50c29a000000b00557aba80631mr1026886edf.19.1704723759382;
        Mon, 08 Jan 2024 06:22:39 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id t8-20020a056402020800b0055712dec5a6sm4367215edv.2.2024.01.08.06.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 06:22:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jan 2024 15:22:38 +0100
Message-Id: <CY9E4ZCHOMWU.C18NR0H7V1QX@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@linaro.org>, "Andy Gross"
 <agross@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Bhupesh Sharma" <bhupesh.linux@gmail.com>, "David Heidelberg"
 <david@ixit.cz>, "Stephan Gerhold" <stephan@gerhold.net>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFT] arm64: dts: qcom: sm8350: Reenable crypto &
 cryptobam
X-Mailer: aerc 0.15.2
References: <20240108-sm8350-qce-v1-1-b7d586ff38af@fairphone.com>
 <a5923bf7-0a05-43bd-b282-b45e5653ac4d@linaro.org>
In-Reply-To: <a5923bf7-0a05-43bd-b282-b45e5653ac4d@linaro.org>

On Mon Jan 8, 2024 at 3:18 PM CET, Konrad Dybcio wrote:
> On 8.01.2024 14:49, Luca Weiss wrote:
> > When num-channels and qcom,num-ees is not provided in devicetree, the
> > driver will try to read these values from the registers during probe bu=
t
> > this fails if the interconnect is not on and then crashes the system.
> >=20
> > So we can provide these properties in devicetree (queried after patchin=
g
> > BAM driver to enable the necessary interconnect) so we can probe
> > cryptobam without reading registers and then also use the QCE as
> > expected.
>
> This really feels a bit backwards.. Enable the resource to query the
> hardware for numbers, so that said resource can be enabled, but
> slightly later :/

If you think adding interconnect support to driver and dtsi is better,
let me know.

Stephan (+CC) mentioned it should be okay like this *shrug*

For the record, this is the same way I got the values for sc7280[0] and
sm6350[1].

[0] https://lore.kernel.org/linux-arm-msm/20231229-sc7280-cryptobam-fixup-v=
1-1-bd8f68589b80@fairphone.com/
[1] https://lore.kernel.org/linux-arm-msm/20240105-sm6350-qce-v1-0-416e5c73=
19ac@fairphone.com/

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qco=
m/sm8350.dtsi
index b46236235b7f..cd4dd9852d9e 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1756,8 +1756,8 @@ cryptobam: dma-controller@1dc4000 {
 			qcom,controlled-remotely;
 			iommus =3D <&apps_smmu 0x594 0x0011>,
 				 <&apps_smmu 0x596 0x0011>;
-			/* FIXME: Probing BAM DMA causes some abort and system hang */
-			status =3D "fail";
+			interconnects =3D <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names =3D "memory";
 		};
=20
 		crypto: crypto@1dfa000 {
diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 5e7d332731e0..9de28f615639 100644
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
@@ -1206,6 +1208,7 @@ static int bam_init(struct bam_device *bdev)
 		bdev->num_channels =3D val & BAM_NUM_PIPES_MASK;
 	}
=20
+	printk(KERN_ERR "%s:%d DBG num_ees=3D%u num_channels=3D%u\n", __func__, _=
_LINE__, bdev->num_ees, bdev->num_channels);
 	/* Reset BAM now if fully controlled locally */
 	if (!bdev->controlled_remotely && !bdev->powered_remotely)
 		bam_reset(bdev);
@@ -1298,6 +1301,14 @@ static int bam_dma_probe(struct platform_device *pde=
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

