Return-Path: <linux-kernel+bounces-104732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ACC87D2E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059C21F20F44
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373074C3DE;
	Fri, 15 Mar 2024 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lNGSgXH6"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F94AEEF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524122; cv=none; b=W14o/sk2aBjk3ntgEZoKxdzHcSTDFgqr+2hL35zJVijFhssr0iAWquP/72SFzAFhU02Ci3AUdb/Xp+K3hJr7AQzosKIy+h1o61BelQjssPpLfNyMEB4/2Mts9JwDO6xj3ImUGnQWS1om1Kov+OxrrfAw9zTfGVL4B+BQ6s2+Z7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524122; c=relaxed/simple;
	bh=8oZV8aP3SBSo3hy+jvbWW+mvLwxem5+OH9Q8I4xTC2c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=i8/WmMR4LVlF0lGmnrgxxSr05UBpqk1u6TSBsYo2ehdB2kAGbIyU6MZI2L1TsVmlEsLZ7d3HIaZ9OOVDjMwJvdXNbiU5U0nO3K+X1w3Pa5dVwoGwIKgLJBl4UefRwgIqNxR9TUU5ChCmtl4qmjz8h/OWzcIGZ/mJx8o7uGrUrrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lNGSgXH6; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513d717269fso1605608e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710524118; x=1711128918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQf/zU1IbIJWQAYBzJwgaR4fassboS7XZvHjBHUMNEU=;
        b=lNGSgXH64x4Tf1wYNYILlptIX+ZuWecB66rtLwReD08uQEQV/us1tThk7JOUcU09Dj
         FyPPKgdDrMoK2wznN7bz3cFVfDpjfhWBHidFbufjuVlPXONV7YNOXBQSFh4Vhmo0Lhku
         t+15WWKvRb3V8BicRewyuFV5N4h7RfgOVhBE67380FGcO0Nk+QKUViRdyfGJtuUrKaqB
         gCTGVeev2M4I9Dg1Ub4zJW0ox+HAwQ/2cPzZ3Y+TbCW8cCm8PaHwoQeMNIXXQnCLZaUh
         SZnv9WBBtMbfGdIqI8UzSIr3nUkI6QvPuUexF83etmwt+DKZYSuiwOe/muXNTL1dw8o+
         eJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710524118; x=1711128918;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iQf/zU1IbIJWQAYBzJwgaR4fassboS7XZvHjBHUMNEU=;
        b=GLmyfH15kqVohVOp3he1zp9v5X1od/nj3uj3YuzRFs07HUOSo4ynp1JtSr46otM4ER
         3SKr9lSvUkaBZIdCbVIxnigG5bSWkCcjgUq0BPx2jX/YW5ApkKzn94JGkcpyGKApucwE
         Ag/KsJD3QEUcmixQXb/9caGPz9UARo3Ti5pD/NCvK6ye01TVLOUTYrR7kURB9rg3G27e
         D5zi6UiDPkbTcfSw2BoBWeSJcnLtwIlsvVXFgTAFlzRAEmVb3WcwslJoAgxybRpYX2at
         MOZdAGAXKJEdqpFajuIvtRfCQysD3q9DscszrMxTQSK/b4Wbr5Q3faDo4gIKIcTinpgZ
         GmdA==
X-Forwarded-Encrypted: i=1; AJvYcCXsArvY5jY5XrFk9xMSTkcmzzXcCKbDTM8094rlseKD5Ofb+dGFiPSsSa+6ajOVXCGjhkueML2joPGXsoDNm3nTAT7q86P4anwF4hSY
X-Gm-Message-State: AOJu0YxI1W6N7L9leh2NKiIoexLOyiMDZkhyUt19MNs2MgtRNCoERc5f
	rQhg1xHpFD8l3iNB5Ohbb8Tllgmmr0ywz1iqvfCtSpAxeMAnbx9L1pgy4m+qhWM=
X-Google-Smtp-Source: AGHT+IGQMulSlRF7Dtm081lDWhL1YsbGIlVuJQPI/UbTHpu33qoEVYfb40RG2YVrbINNMNXXvzA+ww==
X-Received: by 2002:ac2:498e:0:b0:513:ca99:5908 with SMTP id f14-20020ac2498e000000b00513ca995908mr3093475lfl.26.1710524117699;
        Fri, 15 Mar 2024 10:35:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a633:992a:92cc:9c3? ([2a01:e0a:982:cbb0:a633:992a:92cc:9c3])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c450600b004133365bbc6sm9590842wmo.19.2024.03.15.10.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 10:35:17 -0700 (PDT)
Message-ID: <7a7aa05f-9ae6-4ca0-a423-224fc78fbd0c@linaro.org>
Date: Fri, 15 Mar 2024 18:35:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFT 0/7] arm64: qcom: allow up to 4 lanes for the Type-C
 DisplayPort Altmode
Content-Language: en-US, fr
To: Luca Weiss <luca.weiss@fairphone.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
 <CZUHV429NTF7.1GW9TN9NXB4J1@fairphone.com>
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
In-Reply-To: <CZUHV429NTF7.1GW9TN9NXB4J1@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/03/2024 18:19, Luca Weiss wrote:
> On Thu Feb 29, 2024 at 2:07 PM CET, Neil Armstrong wrote:
>> Register a typec mux in order to change the PHY mode on the Type-C
>> mux events depending on the mode and the svid when in Altmode setup.
>>
>> The DisplayPort phy should be left enabled if is still powered on
>> by the DRM DisplayPort controller, so bail out until the DisplayPort
>> PHY is not powered off.
>>
>> The Type-C Mode/SVID only changes on plug/unplug, and USB SAFE states
>> will be set in between of USB-Only, Combo and DisplayPort Only so
>> this will leave enough time to the DRM DisplayPort controller to
>> turn of the DisplayPort PHY.
>>
>> The patchset also includes bindings changes and DT changes.
>>
>> This has been successfully tested on an SM8550 board, but the
>> Thinkpad X13s deserved testing between non-PD USB, non-PD DisplayPort,
>> PD USB Hubs and PD Altmode Dongles to make sure the switch works
>> as expected.
>>
>> The DisplayPort 4 lanes setup can be check with:
>> $ cat /sys/kernel/debug/dri/ae01000.display-controller/DP-1/dp_debug
>> 	name = msm_dp
>> 	drm_dp_link
>> 		rate = 540000
>> 		num_lanes = 4
> 
> Hi Neil,
> 
> I tried this on QCM6490/SC7280 which should also support 4-lane DP but I
> haven't had any success so far.
> 
> On top of your patches I added the following for my device:
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> index f5bd51806819..e7be17844da1 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> @@ -712,7 +712,7 @@ &mdss_dp {
>   };
>   
>   &mdss_dp_out {
> -	data-lanes = <0 1>;
> +	data-lanes = <0 1 2 3>;
>   	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
>   };
>   
> @@ -1344,6 +1344,7 @@ &usb_1_qmpphy {
>   	vdda-phy-supply = <&vreg_l6b>;
>   	vdda-pll-supply = <&vreg_l1b>;
>   
> +	mode-switch;
>   	orientation-switch;
>   
>   	status = "okay";
> 
> 
> The output of the dp_debug file shows it's trying to use 4 lanes:
> 
>          name = msm_dp
>          drm_dp_link
>                  rate = 540000
>                  num_lanes = 4
>                  capabilities = 1
>          dp_panel_info:
>                  active = 0x0
>                  back_porch = 0x0
>                  front_porch = 0x0
>                  sync_width = 0x0
>                  active_low = 0x0
>                  h_skew = 0
>                  refresh rate = 0
>                  pixel clock khz = 0
>                  bpp = 0
>          dp_link:
>                  test_requested = 128
>                  num_lanes = 4
>                  bw_code = 20
>                  lclk = 540000000
>                  v_level = 2
>                  p_level = 0
> 
> But the monitor stays black and the following appears in dmesg:
> (starts with plugging in a dongle, ends with unplugging it again)
> 
> [ 1773.538161] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
> [ 1773.538197] xhci-hcd xhci-hcd.2.auto: new USB bus registered, assigned bus number 1
> [ 1773.540215] xhci-hcd xhci-hcd.2.auto: hcc params 0x0230fe65 hci version 0x110 quirks 0x0000008000000010
> [ 1773.540260] xhci-hcd xhci-hcd.2.auto: irq 185, io mem 0x0a600000
> [ 1773.540372] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
> [ 1773.540384] xhci-hcd xhci-hcd.2.auto: new USB bus registered, assigned bus number 2
> [ 1773.540396] xhci-hcd xhci-hcd.2.auto: Host supports USB 3.0 SuperSpeed
> [ 1773.540524] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.08
> [ 1773.540534] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 1773.540541] usb usb1: Product: xHCI Host Controller
> [ 1773.540547] usb usb1: Manufacturer: Linux 6.8.0-00058-g113103fa3b95 xhci-hcd
> [ 1773.540554] usb usb1: SerialNumber: xhci-hcd.2.auto
> [ 1773.540999] hub 1-0:1.0: USB hub found
> [ 1773.541028] hub 1-0:1.0: 1 port detected
> [ 1773.542010] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
> [ 1773.542146] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.08
> [ 1773.542162] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 1773.542174] usb usb2: Product: xHCI Host Controller
> [ 1773.542183] usb usb2: Manufacturer: Linux 6.8.0-00058-g113103fa3b95 xhci-hcd
> [ 1773.542193] usb usb2: SerialNumber: xhci-hcd.2.auto
> [ 1773.543241] hub 2-0:1.0: USB hub found
> [ 1773.543282] hub 2-0:1.0: 1 port detected
> [ 1775.563969] [drm:dp_ctrl_link_train] *ERROR* max v_level reached
> [ 1775.564031] [drm:dp_ctrl_link_train] *ERROR* link training #1 failed. ret=-11

Interesting #1 means the 4 lanes are not physically connected to the other side,
perhaps QCM6490/SC7280 requires a specific way to enable the 4 lanes in the PHY,
or some fixups in the init tables.

Abhinav, any suggestions ?

Neil

> [ 1775.597965] [drm:dp_display_process_hpd_high] *ERROR* failed to complete DP link training
> [ 1775.598149] [drm:dp_aux_isr] *ERROR* Unexpected DP AUX IRQ 0x01000000 when not busy
> [ 1776.632081] [drm:dp_ctrl_link_train] *ERROR* max v_level reached
> [ 1776.632145] [drm:dp_ctrl_link_train] *ERROR* link training #1 failed. ret=-11
> [ 1776.662978] [drm:dp_display_process_hpd_high] *ERROR* failed to complete DP link training
> [ 1776.663039] [drm:dp_aux_isr] *ERROR* Unexpected DP AUX IRQ 0x01000000 when not busy
> [ 1777.717501] [drm:dp_ctrl_link_train] *ERROR* max v_level reached
> [ 1777.717524] [drm:dp_ctrl_link_train] *ERROR* link training #1 failed. ret=-11
> [ 1777.751427] [drm:dp_display_process_hpd_high] *ERROR* failed to complete DP link training
> [ 1777.751518] [drm:dp_aux_isr] *ERROR* Unexpected DP AUX IRQ 0x01000000 when not busy
> [ 1778.793550] [drm:dp_ctrl_link_train] *ERROR* max v_level reached
> [ 1778.793617] [drm:dp_ctrl_link_train] *ERROR* link training #1 failed. ret=-11
> [ 1778.827260] [drm:dp_aux_isr] *ERROR* Unexpected DP AUX IRQ 0x01000000 when not busy
> [ 1778.827334] [drm:dp_display_process_hpd_high] *ERROR* failed to complete DP link training
> [ 1779.279889] xhci-hcd xhci-hcd.2.auto: remove, state 1
> [ 1779.279942] usb usb2: USB disconnect, device number 1
> [ 1779.311920] xhci-hcd xhci-hcd.2.auto: USB bus 2 deregistered
> [ 1779.311987] xhci-hcd xhci-hcd.2.auto: remove, state 4
> [ 1779.312019] usb usb1: USB disconnect, device number 1
> [ 1779.317772] xhci-hcd xhci-hcd.2.auto: USB bus 1 deregistered
> 
> Regards
> Luca
> 
> 
>> ...
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Neil Armstrong (7):
>>        dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Add mode-switch
>>        phy: qcom: qmp-combo: store DP phy power state
>>        phy: qcom: qmp-combo: introduce QPHY_MODE
>>        phy: qcom: qmp-combo: register a typec mux to change the QPHY_MODE
>>        arm64: dts: qcom-sm8550: allow 4 lanes for DisplayPort and enable QMP PHY mode-switch
>>        arm64: dts: qcom-sm8650: allow 4 lanes for DisplayPort and enable QMP PHY mode-switch
>>        arm64: dts: qcom-mode-switch: allow 4 lanes for DisplayPort and enable QMP PHY mode-switch
>>
>>   .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         |   5 +
>>   .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |   6 +-
>>   arch/arm64/boot/dts/qcom/sm8550-hdk.dts            |   3 +-
>>   arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |   3 +-
>>   arch/arm64/boot/dts/qcom/sm8650-qrd.dts            |   3 +-
>>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 168 +++++++++++++++++++--
>>   6 files changed, 173 insertions(+), 15 deletions(-)
>> ---
>> base-commit: b321c0e8ca754d8cd9f23ceba958e3ea93c6519e
>> change-id: 20240229-topic-sm8x50-upstream-phy-combo-typec-mux-31b5252513c9
>>
>> Best regards,
> 


