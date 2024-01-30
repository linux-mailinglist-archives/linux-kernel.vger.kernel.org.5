Return-Path: <linux-kernel+bounces-44188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C322841F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59BA4B2CCB5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7010A58217;
	Tue, 30 Jan 2024 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccmA6EkN"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC95157888
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605204; cv=none; b=gPdTc4PXYsI7+sVoj+ttkN6yxrm6G9tPFTV4PX8rKiXSJ10zFjK6Cf/1liKvO40okh2g6lyk0RtAeKsLXL4VuHtgoyxOQvUKH+NYxwVEq3BoJAC1XoBwWjba3ZcPNO3u1ajis062PtpWTg17bvXVVnv3wouDGcg5D88+LyK/nRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605204; c=relaxed/simple;
	bh=Ss8eXXVOK69pwFg4ALxuF9O7AP24QrPRskLjKqOA56E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVUQTEWjdMQmhkd+R19cqVVbd0ZGNmwHStZlR5Lu8ejOpimcyexV0gIV8HwUZ2IFQVovsxOJA0B7K6IJjtH9+xGLjgyobEN+mwIbsKJZYW+19UcwfzSHjoGBAVY9tKW492p54Adl++qOn95HLzVVwh7Op1aymLCnLk/LXZ4ptIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ccmA6EkN; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55eee4a042eso2626057a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706605200; x=1707210000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Db3zP9xDe7AQg6WDfeMGEY2GUxXn8qP4OsKoMMuxQJ0=;
        b=ccmA6EkNzCqWrEQnNllEh5x+B612famcR+jlP8oxYKGjSZoV5kFif7IeHvL5qOA9ex
         trkC183mEh/r7lh1b7iFoieOKGBSpBGLXi9FL1g9pzocgc9L+zDzcDAlHbV8efoKtiQc
         xh86Nre7G5tEOJACdu1SvoH9jfcZBnNNNWeU1ZqzYIJ4Yp47ynBRJSko3Bx85VlPe2Cl
         30R2qciJAtpnO/NaoFjkf7Ji0gP9xOg0OHy5N78864zBR88IpP3CaqQ0+dZGpSFdhFDc
         e1dEerihR3/7wBOndQJR9kygmz4QjwOHH1C9xMsy9ZnOS03qQuKSNGNKjveI3aWP+m1m
         fGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605200; x=1707210000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Db3zP9xDe7AQg6WDfeMGEY2GUxXn8qP4OsKoMMuxQJ0=;
        b=U/KMjbduuhaoP5l/OzGdqlzaZKea5886A/sA2jFcyxLUegb8zaRcQPVRGJfzQEZuha
         /vV6D4bggWeGZ1z7jMqUheJufxoUFiwhiemvTSFrxXkmWFYARJbbZGvYrtEq9Pvov49G
         eEnav55HWS94YFt/2alpJo3ake9/PSXZaM2TdgrRos78+MQL88QtesV6hAGljWfb6Ts0
         Zg4dwKO+ScdaT2bdGbnGwqO8XJY3cM84TTWoBMyn7Hd92/GncZlmxUaxhmLZsxgYxtD1
         KONbFnA/UBKSLTF3GH5A7KD6Tl3PrujtB/rwd/lJWnpG1NzyMSbf7EmxLIIqj21kSjrr
         IiLw==
X-Gm-Message-State: AOJu0YzgxbqXBcD7juqqTTrghBB1MCDWiILLHVitc+FxEvCddX2i/8ah
	a9kOFjFexNPKXKbWk0+Qrb7Swxjq3Lzy9gOQPq1RWOXcLmuxCYAnqEHujxKUyZ4=
X-Google-Smtp-Source: AGHT+IFpF6eb2hwZ1pcq0BDPc8nFxpTlxhdwU9wZlPnph/0Br1InfNUBcZB2iLz9YJiS9cXsEmiNZQ==
X-Received: by 2002:a05:6402:22e4:b0:55e:f4fb:66f6 with SMTP id dn4-20020a05640222e400b0055ef4fb66f6mr3348290edb.18.1706605200064;
        Tue, 30 Jan 2024 01:00:00 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402195300b0055e96290001sm3700180edz.27.2024.01.30.00.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 00:59:59 -0800 (PST)
Message-ID: <3e078f39-ccd4-4bf4-b11c-5160cc1f0221@linaro.org>
Date: Tue, 30 Jan 2024 08:59:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] clk: samsung: gs101: add support for cmu_peric1
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 willmcvicker@google.com, semen.protsenko@linaro.org,
 alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com,
 cw00.choi@samsung.com, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240129174703.1175426-1-andre.draszik@linaro.org>
 <20240129174703.1175426-4-andre.draszik@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240129174703.1175426-4-andre.draszik@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/29/24 17:46, André Draszik wrote:
> CMU_PERIC1 is the clock management unit used for the peric1 block which
> is used for additional USI, I3C and PWM interfaces/busses. Add support
> for muxes, dividers and gates of cmu_peric1, except for
> CLK_GOUT_PERIC1_IP which isn't well described in the datasheet and
> which downstream also ignores (similar to cmu_peric0).
> 
> Two clocks have been marked as CLK_IS_CRITICAL for the following
> reason:
>     * disabling them makes it impossible to access any peric1
>       registers, (including those two registers).
>     * disabling gout_peric1_lhm_axi_p_peric1_i_clk sometimes has the
>       additional effect of making the whole system unresponsive.
> 
> One clock marked as CLK_IGNORE_UNUSED needs to be kept on until we have
> updated the respective driver for the following reason:
>     * gout_peric1_gpio_peric1_pclk is required by the pinctrl
>       configuration. With this clock disabled, reconfiguring the pins
>       (for USI/I2C, USI/UART) will hang during register access.
>       Since pinctrl-samsung doesn't support a clock at the moment, we
>       just keep the kernel from disabling it at boot, until we have an
>       update for pinctrl-samsung, at which point we'll drop the flag.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> 

Looks good to me:

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

