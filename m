Return-Path: <linux-kernel+bounces-92739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A13887253D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3E78B25500
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EB614AB8;
	Tue,  5 Mar 2024 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZ6mXLH+"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEFADDA0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658530; cv=none; b=VEN3822nbzkQYMSzULxzJJI7AoW8XM92KVDH2JhAOKz3iY25JKybYNyT/2gHPCgEEPMkedusP3lI3vbRLglScO4Qi11bLZSIHOJMJaXZDIGjo9J5yBbrWkH1IJpDu3FtT2rtiCGBojkZzbTWwTW7kMVND2ArTh5aJ4RketstnvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658530; c=relaxed/simple;
	bh=bRqLnrkrvBnPiOyAEUSTGG0rnBf7fEkCL6riq4nURWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uNDsaLtqH/h7yzFZLxBFBGQ2ML2QVlNWXHcjPG7lFdmWs1ab46JEUR3/dbm+ClGpEcz/WbmzJYYDp0XX0hVEtHJps4kdPhBEmTeV34uE3pFLOCelFLRYuz9TgD8rEAUZ+JBSrhjBI3QIEW4EHtAq5x0HN6cgPbdf6u+xwH9f4uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bZ6mXLH+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a450bedffdfso328497766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 09:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709658527; x=1710263327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HR0qV5QlhLOvDXQbxvIkurs9mcSUMb1UCErxeQuyfpM=;
        b=bZ6mXLH+MNtbK9D+q/Okz879iflp4tNuyfWJmzB1aPDiNhiFMq7H71ElbYUQ/BHXSo
         nlgRomE45/VZ9XfVECLOhsGmwPSuFGnV+iIP+FzqOzhxNLcRXLyZpMVDzSiEE2kYvbt6
         Osrd0EfdvN0vAzvTxPnzr2A2IaqXSu9YJpGhraLsxTwDtLCoZ/h2NheQ+k44iFL7noD/
         jiNwhQEdypNOkrrpNJmfQ1Img73YOuxzcbur3vuGh+OAlGOysTA1LUF6KTD81Ekuzepn
         vz9FfrQWhBUKuXkcBhUzFIOt37n99/XXD9uiysUeOgqaB28utqAuSnqA/VSZJTSNZuPb
         UfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709658527; x=1710263327;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HR0qV5QlhLOvDXQbxvIkurs9mcSUMb1UCErxeQuyfpM=;
        b=mxvxsQjqNwr+mYaS/mvQgMh0QUBv7+ncg8NJ290cVPoa2t7LVJJtCzV0VzU8hqvLBP
         eTBkSTSz1CgCYqmSCGI01tMPHD3jYUevzEr+SJmvDK4vYhUVczMe9z9V9h8+GZRb1gYc
         ytWRLLPSBqaOPUGk4JK3UCngsREdfW0MIg6PWNXl6PR7daB/j+9YioN50FxphPewtJI0
         7sI9Np92Au/T8zKqKTCtgPtHFT7mT7HCXklGlc/N1AQVuTqBy0YDNAH0m6S1fZqosUIw
         h4cGcrE67b9AOgQoNwqhZJ+VOa5HHVuFp2Q7iPRxOOOFcGQJfwCyPIsBUTi49LZEY4Jm
         zRJg==
X-Forwarded-Encrypted: i=1; AJvYcCWp7+HsNJYFdceWo6z7Dq4ZhDUXSeyh0MSj2YFBk6GLkHptaRGr6YUcWM1zMzpJf2TqUpSWTPBON1aeYAMvE107+az3MCr4rdHbDN7q
X-Gm-Message-State: AOJu0YyciYGa3Btwq7MtsLcAuetcKlrzGOPmkukuer+eaOP7BbsCQQ2R
	jl9X6Kb/eVg+TutP2u8T2clpyaFWVMeIV5QKVygF6k1iQHfot8KSUm3XrHOVaFo=
X-Google-Smtp-Source: AGHT+IHaOHWSs8lbKhkzDrS9+mfNUTkbRhtzwM477YF7TqHyZAThAjpYPA/fWPEUxuNfjT6+hDfyCQ==
X-Received: by 2002:a17:906:a404:b0:a44:8daa:684b with SMTP id l4-20020a170906a40400b00a448daa684bmr8876016ejz.3.1709658526678;
        Tue, 05 Mar 2024 09:08:46 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id o26-20020a1709061d5a00b00a44f6ce3e7fsm3709759ejh.77.2024.03.05.09.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 09:08:46 -0800 (PST)
Message-ID: <b9142874-0afb-40a6-9008-b33bd8f56840@linaro.org>
Date: Tue, 5 Mar 2024 18:08:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] arm64: dts: qcom: sa8775p-ride: Enable support for
 firmware managed resources
Content-Language: en-US
To: Sriram Dash <quic_sriramd@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, vkoul@kernel.org, kishon@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 gregkh@linuxfoundation.org, quic_wcheng@quicinc.com,
 Thinh.Nguyen@synopsys.com, p.zabel@pengutronix.de,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, quic_psodagud@quicinc.com,
 quic_nkela@quicinc.com, manivannan.sadhasivam@linaro.org,
 ulf.hansson@linaro.org, sudeep.holla@arm.com, quic_shazhuss@quicinc.com
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
 <1709657858-8563-4-git-send-email-quic_sriramd@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1709657858-8563-4-git-send-email-quic_sriramd@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2024 17:57, Sriram Dash wrote:
> Establish the channel and domain mapping for the power domains to connect
> with firmware, enabling the firmware to handle the assigned resources.
> Since these delegated resources will remain invisible to the operating
> system, ensure that any references to them are removed.
> 
> Signed-off-by: Sriram Dash <quic_sriramd@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 96 +++++++++++++++++++++++++------
>  1 file changed, 77 insertions(+), 19 deletions(-)

Do not mix DTS patches with submissions to netdev or USB.

Please put it inside your internal guides, so you will not be repeating
this over and over.

> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index 26ad05b..b6c9cac 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -764,8 +764,18 @@
>  };
>  
>  &usb_0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&usb0_en_state>;
> +	/delete-property/ clocks;
> +	/delete-property/ clock-names;
> +	/delete-property/ assigned-clocks;
> +	/delete-property/ assigned-clock-rates;
> +	/delete-property/ required-opps;
> +	/delete-property/ resets;
> +	/delete-property/ interconnects;
> +	/delete-property/ interconnect-names;
> +
> +	power-domains = <TODO>, <TODO>;

This wasn't even tested.

Best regards,
Krzysztof


