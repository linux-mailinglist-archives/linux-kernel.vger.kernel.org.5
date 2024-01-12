Return-Path: <linux-kernel+bounces-24454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0828B82BCC2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66CCD1F24DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD0455C37;
	Fri, 12 Jan 2024 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dyI+dSMe"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1476A57301
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33678156e27so5179606f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705050872; x=1705655672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1vcfihMbPJOkqRcFLfQWKsQhpfYhll+IXXKznuEtxw=;
        b=dyI+dSMe5xzWOhBFtOk8blSEC04KqBepDxdD7AnSPIyqq1oDr/++ugjwx2BZdicLn0
         ZWMeK5pdVtUAOhRwydH3S48of9lYvdfBQDKEQUJrMH2Uzqu+5U2q8m7nCP1ew1VGEzi9
         lPNJmPEyLVFxapm45pRacH46CJaEfyCcRXzaLo61e9Eo3X1LR6SNJlMTt6WTOl4mdwsp
         DnM0CtzmAAeeaapyUJsn3rk5yndCj8JwLsIT9eF3+6ZaoPQxHhLt5NQXBY97NnwSiWtO
         Ys/f4y0yS7prSNDZdNUnSstRrDCTqGjyzIhlU7FDk9V85uxvA23T9NJAVrDwkbEeRgyS
         GuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705050872; x=1705655672;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S1vcfihMbPJOkqRcFLfQWKsQhpfYhll+IXXKznuEtxw=;
        b=ONSkM9y00IGj+04Z7JyMpeWCuw788YPJiBZnIdXCFi6wud4oWxXeoTw4Fmi5LgSo8h
         62Jem7V71ipqWslt8Of1MWyHJltIAzxSHShBPa8zfnqCJ7pDwHkH3/YvP61x2uOdDhsf
         7RAftTtu01ZGyWPTJv6400pRp0ZfmNXMXllIHC9Vn49v49WGuw+dMgwrc8JEBVqF/ovo
         o42rFLse+iHxIEVUgH1IgIskNQdnAtrlI3RVlVLJOn0MB2Qu7YhPklMBzJmxT0F525uK
         pKK70pJa9FKdu4+SP/aqLItkYQRyvjL5P2RcbMGhmbkmOAR9MD4b/lntX+YDcVIU7VoB
         le8g==
X-Gm-Message-State: AOJu0Yy+wheTItbZSCu4i3R8rvIB7oEb8RMnxnvDemMoRdL7BrCQEvK3
	w8ddeSvWyOC0tuRXlh2rDytjJDrL1oyt2w==
X-Google-Smtp-Source: AGHT+IF2lM8xorKoJqQrop3KBE3nNs+4mQdVKdaLe3zQQlFcjt449y+o2tAd/ER65AYtJU2SG1VAFQ==
X-Received: by 2002:adf:eacc:0:b0:337:4bbe:97c3 with SMTP id o12-20020adfeacc000000b003374bbe97c3mr542587wrn.87.1705050872301;
        Fri, 12 Jan 2024 01:14:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:59d5:231:f1ee:77f? ([2a01:e0a:982:cbb0:59d5:231:f1ee:77f])
        by smtp.gmail.com with ESMTPSA id dr18-20020a5d5f92000000b0033677a4e0d6sm3337106wrb.13.2024.01.12.01.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 01:14:31 -0800 (PST)
Message-ID: <cdc18e2a-b7eb-4b54-a513-481148fb3b0d@linaro.org>
Date: Fri, 12 Jan 2024 10:14:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/4] drm/panel: Add driver for DJN HX83112A LCD panel
Content-Language: en-US, fr
To: Luca Weiss <luca.weiss@fairphone.com>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg
 <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20240110-fp4-panel-v2-0-8ad11174f65b@fairphone.com>
 <20240110-fp4-panel-v2-2-8ad11174f65b@fairphone.com>
 <CACRpkdaWTfPDCin_L6pefHsokjNyO8Mo6hWPdzPLLi1EUkKUuA@mail.gmail.com>
 <CYBZEZ4IM6IL.VR04W7933VI@fairphone.com>
 <CACRpkdZQbVXfBa70nhDOqfWPbsh-6DgX-uvZOxr19pzMmF2giQ@mail.gmail.com>
 <CYCLSCKPPBOC.1B1MP3VOOC0Q8@fairphone.com>
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
In-Reply-To: <CYCLSCKPPBOC.1B1MP3VOOC0Q8@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/01/2024 10:00, Luca Weiss wrote:
> On Thu Jan 11, 2024 at 8:05 PM CET, Linus Walleij wrote:
>> On Thu, Jan 11, 2024 at 4:28 PM Luca Weiss <luca.weiss@fairphone.com> wrote:
>>
>>> In some internal documentation it says "LCD Driver IC" "HX83112A" and I
>>> don't see any reference to Truly 5P65 anywhere.
>>
>> In the Android directory I pointed to I see this file:
>> HX83112_Android_Driver/Truly_5p65_module_fw/UpdateFW.bat
>>
>> (Notice the 5p65 fw dir is *inside* the HX82112 dir)
>>
>> And in that file:
>> adb push TRULY_5P65_1080_2160_HX83112A_D01C01.bin
>> /system/etc/firmware/Himax_firmware.bin
>>
>> Clearly indicating that they are pushing a Truly 5P65 firmware into
>> the Himax display firmware directory.
>>
>> To be fair, that is the driver for the touchscreen part of HX83112A,
>> but ... Truly is a well known manufacturer of display controllers?
>>
>> But... given that you have a @fairphone.com mal address and
>> a working relationship with them, can't you just ask?
>>
>>> On their website they have this sentence:
>>
>> All OEMs want to look like everything is their own product. It is
>> business as usual.
> 
> I can't tell you anything there that I don't know, sorry.
> 
>>
>> Further on the same note since I guess you have a datasheet)
>> please bring in #defines for the commands (the first byte in the
>> write sequences, for examples:
>>
>> +       mipi_dsi_dcs_write_seq(dsi, 0xbd, 0x02);
>> +       mipi_dsi_dcs_write_seq(dsi, 0xd8,
>> +                              0xaa, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0xff,
>> +                              0xff, 0xff, 0xff, 0xff);
>> +       mipi_dsi_dcs_write_seq(dsi, 0xbd, 0x03);
>>
>> Clearly 0xbd is HX83112_CMD_SETREGBANK?
>> (This is easily spotted from the similar structure in the
>> existing panel-himax-hx8394.c.) So please add #defines
>> for all commands you know, especially if you have a datasheet
>> because we reviewers don't have them and "it's just magic
>> bytes" isn't very compelling. It adds a lot to understanding.
> 
> Right, the register names seem to match more or less the ones from that
> driver, plus some new ones and some differently named ones. Will send a
> v3 with that.
> 
>>
>> I strongly suspect other Himax displays such as HX8394 to
>> be using a Truly controller as well, hence the similarities.
>>
>> In a datasheet for their TFT800480-84-V1-E display controller
>> Truly kept the init sequence name of void LCD_INIT_HX8290(void)
>> for example.
> 
> In that datasheet (assuming I'm looking at the same one?) it says
> "Driver IC" "HX8290-A[...]" so there the display driver is manufactured
> by Himax and not Truly to my understanding. Truly is assembling together
> Driver + all the other parts that go into an LCD.
> 
> For the panel used on Fairphone 4 that part is done by the company DJN.

Looking at the discussion, this seems to confirm the Display+Touch IC is HX83112A,
and Truly is the panel manufacturer and all assembled by DJN, so IMHO the initial driver is right.

Perhaps the compatible should be djn,hx83112a-truly-5p65 to reflect that ?

Neil

> 
> Regards
> Luca
> 
>>
>> Yours,
>> Linus Walleij
> 


