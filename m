Return-Path: <linux-kernel+bounces-16466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD2E823EF3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE9BB23EA9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50C720B33;
	Thu,  4 Jan 2024 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rsxy4YgO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F9620B07
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbd721384c0so302356276.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 01:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704362038; x=1704966838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MP8L5Lud9CCsD/Fvru54/9uS00d5qvumnmZ+CZqZyW0=;
        b=rsxy4YgODcQxuL7bW+wIYJx3927LFYG7ElsAgAwHxQoOEXsOuPFU1kIUTFx7U5OcTZ
         h2sC31P6/Zx2Oyfb0vPL66XL034WAc/OT7dubFbd48jg9QbccCLZ7dsNC+yAXZUlJhh1
         EmkTO8vMO6gDZNL2HVoVuVEJNixl7quyIM+JWmsiVmGZTPgbZ0F/bA6QquVy0p3thBF4
         l3l84BJJNf7YwZ1VErErFgydwrPkWZI+JHLYX08b16UTIDIqbzT3PZGNE+HJdOS9xmPy
         IKHZpqIww+whQ/e82MDxBnyMLVVQnG3uOgl6noHkF3moYzBEst346cak4YP0Wjmnmfsn
         Ggeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704362038; x=1704966838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MP8L5Lud9CCsD/Fvru54/9uS00d5qvumnmZ+CZqZyW0=;
        b=S4d9ritt4na6DR9lmOp4LH0beG2ZqpNyJd7JpOrHZX4/I9Wtx49AeAWG/TZwEAzONR
         vgcn+DQT3OfOHIoGgPqoDCGA4WvLa1+hGqZSRxhSyn/kEdi1SG1FcdlOnXIFrO6oHXkp
         xbAlUzZnBbm9glfVYymCd6+FdpT+uZUdO6fb8iuRad7UlzWnq2OaWwH7BpAZdgGYUewS
         kAF9TakG31ac/qBGKQSPHqff2hfh1HZeEJwQTAP4Vu0RIkDNmZ9+syPz9iZyDjEHHb5g
         u1pF508+pKwxVDqDtuAb97rASom8HZd6igweZYvIfrZ2kKa/y5UmLXGwX0I4FHtCuvmQ
         qoDg==
X-Gm-Message-State: AOJu0YzOMRrDuKAdlrtssT9dqKsPQe3udDeNCstn8UNRnNNVUEEU+WKd
	li1qwsk8NtJGzBEtYGYTNXCqrBHGRxWp7TWT7GwXHAWcA34kEw==
X-Google-Smtp-Source: AGHT+IFFcrjCxmS6ubVsUTEb6rx/JWQMOaSdrJp5TbG0TiZqSQcnUQ30WLwIwX+fUJ40tdfzsyGpEK26pvzPXlRvyNw=
X-Received: by 2002:a25:55c2:0:b0:dbe:ace5:c054 with SMTP id
 j185-20020a2555c2000000b00dbeace5c054mr285004ybb.5.1704362037677; Thu, 04 Jan
 2024 01:53:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104-gcc-docs-update-v1-1-127e4816b798@quicinc.com>
In-Reply-To: <20240104-gcc-docs-update-v1-1-127e4816b798@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 4 Jan 2024 11:53:46 +0200
Message-ID: <CAA8EJprsGke9zZBy_x=YSxz7R1aSpx8r3ndjjXVVKhjKBxd=QQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: ipq6018: add #power-domain-cells for
 gcc node
To: quic_fenglinw@quicinc.com
Cc: kernel@quicinc.com, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 10:06, Fenglin Wu via B4 Relay
<devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
>
> From: Fenglin Wu <quic_fenglinw@quicinc.com>
>
> Property '#power-domain-cells' is required as per defined in qcom,gcc.yaml
> so add it for ipq6018 gcc device node to eliminate following warning in
> dtbs_check:
>
> arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: gcc@1800000:
>         '#power-domain-cells' is a required property
> from schema $id: http://devicetree.org/schemas/clock/qcom,gcc-ipq6018.yaml#

But ipq6018 doesn't implement GDSC support. So for the sake of fixing
the warning you are adding a bogus property.

>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 39cd6b76b4c1..54914912d610 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -386,6 +386,7 @@ gcc: gcc@1800000 {
>                         reg = <0x0 0x01800000 0x0 0x80000>;
>                         clocks = <&xo>, <&sleep_clk>;
>                         clock-names = "xo", "sleep_clk";
> +                       #power-domain-cells = <1>;
>                         #clock-cells = <1>;
>                         #reset-cells = <1>;
>                 };
>
> ---
> base-commit: 17cb8a20bde66a520a2ca7aad1063e1ce7382240
> change-id: 20240103-gcc-docs-update-fa604579e468
>
> Best regards,
> --
> Fenglin Wu <quic_fenglinw@quicinc.com>
>
>


-- 
With best wishes
Dmitry

