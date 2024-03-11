Return-Path: <linux-kernel+bounces-98813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D01877FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001231F214D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3113C47B;
	Mon, 11 Mar 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D41e5qru"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B4A3B7AC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159306; cv=none; b=GWaBNZbluxl5TBdCbp7aZ/TZtgOyml4ak1DskGsnup2hCGdWeB1Z6FG6wq1g//T51zHIBgF8Pswg0jqhyCLHPVgQ6UVaicM+bgmNQVyifte/Q15fxBEBjR6mcT9RPXSMACewy9eS6kD9Ky3k8I1chtW7Ktjn3lM8OsmTz6aVf4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159306; c=relaxed/simple;
	bh=GO3ULI7mQTnxS7jSG4txYsGJozwzQMjf/RmiaZbYSNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZE+3KKlxIaKJFO9XowwqEHvzZqNzy/hoU/eizjGws4yIi1JeDfZwn0RtHIwC0NdvkcJYaakox45R78g0GLTRVMiDPmDlQlRjaRWVqEczM3nRMpqT8db75lAX2HIZ0ZDoOlCiKV1zrzP+4T8SIvq/COr2wfgSAZtqoIS7weW0Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D41e5qru; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-609eb87a847so31805647b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710159304; x=1710764104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ztprHDXJluvRreDSSFUYa4qqYh/2UMDCZbLeEgV3a7g=;
        b=D41e5qruE08HfVMPlt3NvNBCAI3C0+CaXCXDTQdowHGUgFzon6kwWudOlzQow9PFWL
         VZn7QkXPZ0sSoNc6CfD0dUdARWDKIf5pDN1hRh0URNJF9P2tAb+2dK8RrZoAbtyYx+f9
         uVq/63x9VLve38VnaGkHqqs5antV+9T231c4v7Ehxnd8DCHzqRh3C8icCCUlLxJAzo5x
         oPoI+EK8X1Wtav+ygWN04JfIyfiTLcILy253q8ZJzib/D6Pf4EJlhdHmOPSJLwS9MOGv
         lUvXNVLjA+FlWZ0lokvky63N/dn+h9nGUawjRLGxufBtLiACJ7wJOGadbNz5Kq6ycODa
         3MaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710159304; x=1710764104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztprHDXJluvRreDSSFUYa4qqYh/2UMDCZbLeEgV3a7g=;
        b=VaLyFuO0fyFNtOmeqIqw7zX+54HKrjqHGb/MKx8L8my/1IaunNeQZxVN5gQy/CUzcP
         +ePtUGD3fvYw8laE2VKj0PNH6Nh7C9a7hmW4NnvHGYHj2UUf9NrD7tO09bjG/H2LHjd0
         it0d7B8o+OMaf/I1QQb8tCb+zjy+QhwUMW1mwwMQl/fYtlfukfOLSBvHT9LNm/5g+zuO
         VfcjNAsrQHJmgkOna0zY2pZQb8GCUJkavqRgKYzJ0SzuivW4W8khkGj6kGa+10mO23YP
         ViJ+f2q0qpfzgwwOURNu+EDBzTm0EwJsSLc6Sw0PXulcGAZOn793QcVRu/I9dN5KUHSs
         zqwA==
X-Forwarded-Encrypted: i=1; AJvYcCWyzNGkiADlsEwFsx+/a39PWpLqV5v36suvq9W4RgatKvs0HcBgMTdVzQO+Xt+a46BYVZ2DVgRH3yGtAsrEjKKFBlfNV60CKK2muHlX
X-Gm-Message-State: AOJu0YwZNg+KSBhGH71oZp0+XR8NQ/0hmNNIwEZKRV0vikUemSy3gSrO
	Ua3xi9PWlYJZ8Lq1kA7NX4oritr3HR9CTMfucFdWyvpEZCg1mTmrmjIi4MpOXu9GGrSzAngcF1v
	uxfUUUnOhdqpcvA8MVjoWrqhihaHbjRlxc8ms4g==
X-Google-Smtp-Source: AGHT+IHynY17WGsLOoumjxLnrUnR73bC37OcgOsdC+TFcMmdjQ0BKIKC6gkzEtM9/PBYdXA556baFQ8iNcTay77a0Sg=
X-Received: by 2002:a0d:f247:0:b0:609:ddf0:9545 with SMTP id
 b68-20020a0df247000000b00609ddf09545mr3723247ywf.22.1710159303730; Mon, 11
 Mar 2024 05:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311120859.18489-1-quic_kbajaj@quicinc.com> <20240311120859.18489-3-quic_kbajaj@quicinc.com>
In-Reply-To: <20240311120859.18489-3-quic_kbajaj@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 11 Mar 2024 14:14:52 +0200
Message-ID: <CAA8EJpqMWBWAEUCiJXm0x7zjZYbP8SkRDgu+w+goYjB=8JBN0A@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: qdu1000-idp: enable USB nodes
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Amrit Anand <quic_amrianan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 14:10, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> Enable both USB controllers and associated hsphy and qmp phy nodes
> on QDU1000 IDP.
>
> Co-developed-by: Amrit Anand <quic_amrianan@quicinc.com>
> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> index 89b84fb0f70a..126bc71afd90 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> @@ -500,3 +500,27 @@ &tlmm {
>  &uart7 {
>         status = "okay";
>  };
> +
> +&usb_1 {
> +       status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +       dr_mode = "peripheral";

Are these ports really peripheral-only?

> +       maximum-speed = "high-speed";
> +};
> +
> +&usb_1_hsphy {
> +       vdda-pll-supply = <&vreg_l8a_0p91>;
> +       vdda18-supply = <&vreg_l14a_1p8>;
> +       vdda33-supply = <&vreg_l2a_2p3>;
> +
> +       status = "okay";
> +};
> +
> +&usb_1_qmpphy {
> +       vdda-phy-supply = <&vreg_l8a_0p91>;
> +       vdda-pll-supply = <&vreg_l3a_1p2>;
> +
> +       status = "okay";
> +};
> --
> 2.42.0
>
>


-- 
With best wishes
Dmitry

