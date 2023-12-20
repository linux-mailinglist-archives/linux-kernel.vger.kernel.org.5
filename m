Return-Path: <linux-kernel+bounces-6881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F8E819ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCA8288236
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B902230A;
	Wed, 20 Dec 2023 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qIi/XXFd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B812B2231A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5d7a47d06eeso48536997b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703074502; x=1703679302; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4l13RPlxCLnLNVbhTc+jLScyAeZTluA6d9ppZm+Uhxc=;
        b=qIi/XXFdkAD3GqAkXy+JKS0zJy0DTo1fHCZhGVvBlytvltaFKW88vYh297mpylO1R0
         zTjahT9NnWM4DvvDrblLrFuLgOibSiSnUJWwPJJI1cvaLdYemklq6YqK99yaTnZsM79X
         yrMuU/fVNC8yxKZEy3AG4Hm5sD24oxymxDj08OgI91K876Ig9+p67XGKmHdYkKeNw0R6
         Y8O+22HDfRnHkmt9RdtEEgEhondR27tMnNd2IWygaUNHL0mtVyVZyQKhZOtLO0eanOtM
         NaqUF61AiHzQFomxUeDUDF4F5Ax87yvQyEzSiKTIC4oQduambYCdLq9mzyOgqWJMSD45
         rCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703074502; x=1703679302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4l13RPlxCLnLNVbhTc+jLScyAeZTluA6d9ppZm+Uhxc=;
        b=HSOchBlLf7/YnzBXcWUTjMcPQTcs8OxCLAMQUt4g1Q+I81sn7IolpufZyxnvebFz/U
         M83Ks3g/ilh9wJfamSR6fJY/ctbgyv5x4OTcrln+liCMe8gPwxWTozHkeFVZ4Qo36Txw
         1AP2N/+v2pas9i6WJfepIFGjdNXXzmHajzmm4Kac+BXmyR+H7vL1y+dX43QT5RAFxaq5
         fl98RnoGc8F6DYibu+Rw0BBZGU/0JO50Ex5NjyvCd57ZZVuTbSXdAut9elhztWbn+4r8
         wOoqUdFHa2AiND1GSq8ashhwKtU5vWPDvc38vbkT9Mv8mbvvwTCcJSoOJKigTvMQ4bNn
         6FIA==
X-Gm-Message-State: AOJu0YyXWNjoeApQBwxI84WERF20RuDrhJcOlR9obverNTtdIFjb7GPw
	IsGbvgX0NZaLCgO5Ke0vIj4Vh6KbGrpZNYBI3fxkHg==
X-Google-Smtp-Source: AGHT+IGzUyozpGOgpDC3PUOwiEMpuZ391fjn7HsJrYV50IQBf6uXJrs7BXMSSj3PZR1gf7dG5KejP3c6KEIiiSOeots=
X-Received: by 2002:a0d:c703:0:b0:5d7:1940:f3f0 with SMTP id
 j3-20020a0dc703000000b005d71940f3f0mr16148316ywd.88.1703074501713; Wed, 20
 Dec 2023 04:15:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220114225.26567-1-quic_kbajaj@quicinc.com> <20231220114225.26567-3-quic_kbajaj@quicinc.com>
In-Reply-To: <20231220114225.26567-3-quic_kbajaj@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 20 Dec 2023 14:14:50 +0200
Message-ID: <CAA8EJpohwgyoRPq_gWKz+cYipsqvFgLdi=X=acL4AJhhU6Erxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable various remoteprocs
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 13:43, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> Enable the ADSP, CDSP and WPSS that are found on qcs6490-rb3gen2.
>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 8bb7d13d85f6..172f9a3678fd 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -417,6 +417,21 @@ &qupv3_id_0 {
>         status = "okay";
>  };
>
> +&remoteproc_adsp {
> +       firmware-name = "qcom/qcm6490/adsp.mdt";

NAK. this should be .mbn

> +       status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +       firmware-name = "qcom/qcm6490/cdsp.mdt";
> +       status = "okay";
> +};
> +
> +&remoteproc_wpss {
> +       firmware-name = "qcom/qcm6490/wpss.mdt";
> +       status = "okay";
> +};
> +
>  &tlmm {
>         gpio-reserved-ranges = <32 2>, /* ADSP */
>                                <48 4>; /* NFC */
> --
> 2.42.0
>
>


-- 
With best wishes
Dmitry

