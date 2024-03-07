Return-Path: <linux-kernel+bounces-95033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0784587486D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0448C2836D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7BE1CFB4;
	Thu,  7 Mar 2024 07:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7PS3Vtl"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B30B1CF8B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709794980; cv=none; b=G29AhDh9TMPDt/b6dwLgBDurwCIJCSKSV5Ispry3y57c7s6PKd3g1FqQugp876foEe2AHtW8+TZACH/Ee2iszoELRHLEm58gBy3YrsbgpJLbut8U+9AqefosZgn74If8je6P7AZsZH1L0ZSTpmrEp1ucRlCQIq3AtH1MpcPNY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709794980; c=relaxed/simple;
	bh=OBe7iFZuReG8P/0g/nf5f3rbxG1c9+A1XatMuNZhyvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfBHYnHG1XsAIaMPmfgc3QCGiu7ndnGxr6VXe64A39mu0P0qBGxwBrM85vzqVEmomNYTm6O1afZ9GajZEWihOMPTArc6Q4CJsNrzjbh2x739fm+xHb3CkrQhO/MXaQjt48yMJoS2gRIh/p8Gh8lm7x8QlHwFfGO4TPLoqnxnZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A7PS3Vtl; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-47268589ec9so282949137.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 23:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709794978; x=1710399778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rtVcoO9EdMVwfooxI7FOluwLbnU5D53g+z6OZi75Lq4=;
        b=A7PS3VtlNdmCV2le9Ici8iRzxmVlr7Jiz0qyJmhEri2+PQCx1t8oIt1A2U+eGW2yJo
         DgtI3geHXRRm5yso5VmR9z2Z2hqZe6TicS8LkRTus7cVznHA6QL4GgB2dr00SBuBu11g
         J+5DJviVqRx6Znex4PZcBUMomXhsLoC/4dakCYK+UkWALiGMIrMQe35xVjYz3pJ5LYGW
         M0OMsG237xKiRrc/VXjyOEGAxUJ9ieaNz0n3D3jd6kl2KJfjy7EIXwzmx/hgp6aGDuiv
         lkq978Ot+fqLT6U/h+xaTj8JFkeyL6ZfE0XYDULrJACMVHlU/NLrqL4KwM/BY1k4xQ/8
         xPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709794978; x=1710399778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rtVcoO9EdMVwfooxI7FOluwLbnU5D53g+z6OZi75Lq4=;
        b=Os4fwA7EqtWhrJg5Z4+O9EPqu98zwtmk7zYZkF3tmNxCFj/45HsAQCIZ2yw+/xFmao
         m8uKnrMRbfrEriDGtJ7U39oaXVuC3kpBIk/TxapUx1BAUeJ/vN1zdw/lKqALXzntXgyr
         wpOT0pDyfU3v+rvNU7YWx4W3SqisvnISlwRGqcWWHmV6A7A6PMgDjvvnD79jp1u1687j
         kEA9TPH4wKJOJ1Kv27S4fDV0EjRR8l+ANaHDe2X+WznE0b4JdOTP9dvv+OuCDtycrc64
         2Con8/PnNO1iCFlFsRK8iYZtmTS72z8jXfSHO/BblqbO50rZ/qa5I95HFULflea0dUe+
         uBYA==
X-Forwarded-Encrypted: i=1; AJvYcCWaqUWwD0ZMJyOzTmCS1yMHQgFq1lm4ci42UA3rJ9WhgHXSQpisQMwaejtV4ifow7xZhskbONs5yFy/IQ4KuHY3llYzl6kcewBeuRjI
X-Gm-Message-State: AOJu0YyHgxHuoUDlcdMppNsJLAZn8IWk7NnHn3w/kHKO/l/N68O0qq5y
	HoNhBQoG9o0uu5evJzWKaqDOC1EOysltIfKGwkeBnCBBJbDxBaV1xL6Lxwj3jmRiyJmKBDqNim3
	C1MgLROSZ8ZiZV4vw/idtMNAlqoADsex7S4jMdA==
X-Google-Smtp-Source: AGHT+IFRYze7tO1U5koqDn3Os1b2lN61jQUOyyUQbuPdUoRc6ftbDI4kO7dIUuGq9SfX8vhQ8vNrAhsojMO8KHr5g2w=
X-Received: by 2002:a05:6102:304c:b0:472:5968:b670 with SMTP id
 w12-20020a056102304c00b004725968b670mr261914vsa.9.1709794976121; Wed, 06 Mar
 2024 23:02:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306200910.2732835-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240306200910.2732835-1-volodymyr_babchuk@epam.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 7 Mar 2024 12:32:45 +0530
Message-ID: <CAFA6WYPKJ7N9UUcX607gkcHF7kTswxaQYe4sCcgJXVa_pXSnMw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: add reset name for ethernet node
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 01:39, Volodymyr Babchuk
<Volodymyr_Babchuk@epam.com> wrote:
>
> Add reset-names property to the ethernet@20000 node. This patch does
> not change behavior on Linux, but it is needed for U-Boot, as it tries
> to find the reset by name, not by index.
>
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 761a6757dc26f..c2e65d6a2ac62 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -951,6 +951,7 @@ ethernet: ethernet@20000 {
>
>                         power-domains = <&gcc EMAC_GDSC>;
>                         resets = <&gcc GCC_EMAC_BCR>;
> +                       resets-names = "emac";

I suppose you meant reset-names here instead?

-Sumit

>
>                         iommus = <&apps_smmu 0x3c0 0x0>;
>
> --
> 2.43.0

