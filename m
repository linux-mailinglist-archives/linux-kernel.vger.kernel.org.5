Return-Path: <linux-kernel+bounces-88923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A131286E870
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBBE1C2581E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440411E88A;
	Fri,  1 Mar 2024 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRSK5Ct6"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA82575F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317878; cv=none; b=iT95naMFp7Lrn1BNwM+q7fStT4BQmyjKjl+2WTynfWEzjAY4RuxkwUoGtmE2E93m9ReecxInQK5jxlEdlEqCuRNE7oK/HL37MIl9kmW7o2BJovcYatjoydbo4euO0hstA22Jr8sXza28x1BNTDQD3XH86dvndbEF5h1v8lDsYMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317878; c=relaxed/simple;
	bh=t2D6o82ramXjNQyWSQZ6o4bdmA4fnf7ZmkDue7UkBiI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QEJS2Rj9IOCUTCGGqhnWU6LC/qAtjasmz3OZPlLHbgR2ZFsn2NJyR3Z/y0pTucT4cD6hFjW9/+Ze2/+gYER80P6y4V8yrHuC+TDhkRtvK86niZ5FG2dM5olExJ1uJT59Eaysq0MJygGWyRRznWj6R2Tyglm+KZomEFmg28tmf7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gRSK5Ct6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412a3371133so18345775e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709317875; x=1709922675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00fDWV96hGzMlgHmADg+FHDT30+NNE+7RPj/2lJdLsA=;
        b=gRSK5Ct6ei4SZWbBSeL88XjNqqTu8jO0u9oerZ9V8dMAMRRgOEGNoEdNsNPST8xEZb
         oOX6BU0Bw13r0fem9a0gC56KA9xKqYYr5oy6ySlfRrbBuLGPidRnB68SR8ClIjn1nNJh
         EIglfZI0eGCIGKy2JuNH6cOO/l1Qm5Z6o1dJ+MS20DDNlvMNKQTiWWMDSwi3Kikncus9
         yMyjZ/6iECT3OIg0V+OPGH6fS1sBj6wm1rCvYoDmGyVRxng6twMaOJ/P19Mc/mVxwSLE
         6D0Kzhg97lj9C6ekIMGtgGUqbLUnQBeIIn6eGkfQ/7tnVYrd7pb+MLluHOsxjBc8vpO3
         uebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709317875; x=1709922675;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=00fDWV96hGzMlgHmADg+FHDT30+NNE+7RPj/2lJdLsA=;
        b=Yv+2uHJZNEMCHPgsQnAAYmQiUcMHoPxj8l1BGyG5G+or7O1I7NPdbvXnvpd5bP09QW
         rqWXQyeZIE/W69n6IyNCCaZvQYq+PuKRdY+rDKyCO3rlnl2MVBWCFyrbdhNvT1FhlGNK
         xoFkLZEvHjXPYc+JdyBvJEWKat6mlGmvbJXUQIrnr4clV3t9m1etWz3MI7rjGh9KJofG
         9T8kcOTjWmcntlpw+7/O+rFcF/KaDghPyhR4cTODncMRVKzzBeJR/RZlskAzNBCo3SdM
         EeNvH0FfxQEt02TpE1DTpdsR5xSyg11INNsAdhtJoUfRThoB0GIHSYcjSQXOUcHi3swr
         gDUA==
X-Forwarded-Encrypted: i=1; AJvYcCWx02MlBpolShkUmwJ15KlrPA34fjari5TYx/foRLldEOfAXUVKekkoKwXMWfx9dR34JYtCneQxk4VgkiPSdmRRdXbjPF0QPZnaslJ2
X-Gm-Message-State: AOJu0Yxexei7hFwP8ozLzlAkpWcbk98rEUb8dZ5qmUAF/5B0vPIUQ1QH
	ud1426GnzVrBDcsqgwZo49TnMOiw4ZloKe1RuILR7Ksr5994iWlNhiE0c1NvUHk=
X-Google-Smtp-Source: AGHT+IFEic06454DIPjHdGIhjkTFcQQke8zNWqIpZhtgGWNUnK5McNBCaU6INJ6zvLIZyqlDxtOTcw==
X-Received: by 2002:a05:600c:5105:b0:412:b0ef:22b1 with SMTP id o5-20020a05600c510500b00412b0ef22b1mr2001771wms.4.1709317874803;
        Fri, 01 Mar 2024 10:31:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:7f8a:cf96:378:4490? ([2a01:e0a:982:cbb0:7f8a:cf96:378:4490])
        by smtp.gmail.com with ESMTPSA id p26-20020a05600c205a00b00412b62f6e35sm8342697wmg.15.2024.03.01.10.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 10:31:14 -0800 (PST)
Message-ID: <4ec8a486-285b-40f7-8501-28550a9f83b9@linaro.org>
Date: Fri, 1 Mar 2024 19:31:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFT 7/7] arm64: dts: qcom-mode-switch: allow 4 lanes for
 DisplayPort and enable QMP PHY mode-switch
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
 <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-7-07e24a231840@linaro.org>
 <jfwskyt3wllpf33ceeibrodorsfmhctfulfkzpkgmjikzbr63n@f4llf7wcmyxi>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <jfwskyt3wllpf33ceeibrodorsfmhctfulfkzpkgmjikzbr63n@f4llf7wcmyxi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/03/2024 04:00, Bjorn Andersson wrote:
> On Thu, Feb 29, 2024 at 02:07:07PM +0100, Neil Armstrong wrote:
>> Allow up to 4 lanes for the DisplayPort link from the PHYs to the Controllers
>> and allow mode-switch events to the QMP Combo PHYs.
>>
> 
> Please adjust $subject and commit message to suite the x13s.dts...

Sure I realized this after sending the patches....

> 
> 
> With this series I'm reaching 4k@60 on my X13s (with some difficulty due
> to current hotplug issues in the DP driver) - but 4-lane DP works, and
> so does 2-lane combo.
> 
> I tested switching between DP-only and a USB device, this worked fine a
> few (3-4) times, after which the USB device stopped showing up. The DP
> display continued to work nicely and the debug prints from the driver
> indicates that we're moving back and forth between the modes...
> 
> The problems I had when trying to implement this previously, with the
> device crashing on disconnect have not been seen, across 20+
> attempts.

Greatm nice this was fixed!

I also experienced USB issue after a few connect/disconnects, it seems that messing
with the USB PHY doesn't make DWC3 very happy, not sure how we could actually fix that.

Thx for testing!

Neil

> 
> Regards,
> Bjorn
> 
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> index a0fdef55a40a..6c73e0fc001f 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> @@ -556,7 +556,7 @@ &mdss0_dp0 {
>>   };
>>   
>>   &mdss0_dp0_out {
>> -	data-lanes = <0 1>;
>> +	data-lanes = <0 1 2 3>;
>>   	remote-endpoint = <&usb_0_qmpphy_dp_in>;
>>   };
>>   
>> @@ -565,7 +565,7 @@ &mdss0_dp1 {
>>   };
>>   
>>   &mdss0_dp1_out {
>> -	data-lanes = <0 1>;
>> +	data-lanes = <0 1 2 3>;
>>   	remote-endpoint = <&usb_1_qmpphy_dp_in>;
>>   };
>>   
>> @@ -1112,6 +1112,7 @@ &usb_0_qmpphy {
>>   	vdda-phy-supply = <&vreg_l9d>;
>>   	vdda-pll-supply = <&vreg_l4d>;
>>   
>> +	mode-switch;
>>   	orientation-switch;
>>   
>>   	status = "okay";
>> @@ -1149,6 +1150,7 @@ &usb_1_qmpphy {
>>   	vdda-phy-supply = <&vreg_l4b>;
>>   	vdda-pll-supply = <&vreg_l3b>;
>>   
>> +	mode-switch;
>>   	orientation-switch;
>>   
>>   	status = "okay";
>>
>> -- 
>> 2.34.1
>>


