Return-Path: <linux-kernel+bounces-89620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E01B86F322
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 00:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944081F22117
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 23:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AFA53E3E;
	Sat,  2 Mar 2024 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YlUMlZvr"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C12144C85
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 23:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709422357; cv=none; b=E/Vhco5jUkpbadvu/0UfJuB0FATnaWTCvuGFym72Fy9hhJsY5Requiy8h20bnpuDgVAb2R+OaZU1t92ezL7a+hFgUObczOHE4BtSZMItczUUnpzHmCrr9ZseACpbTRPUVrJFvWAOW1+HPgpoltMxVhIYXxJXOjmMXnrcjsoO4To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709422357; c=relaxed/simple;
	bh=ilr6PnvyjkOM4v70Hd+kVvbi7WJfxMXJh+DgYm1FJkE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rH2oJDhdLg3mIdJD1LjoOnDm02iRCIxRs0jwH3P51FfA0MYvxPAOVKqC0BuRYg0s2EcouHL3NQ9w7BiTEW4tYu3aiMu9nf4468o/PiPpUHvHFKyeM6qgWhmqOtoZzfewOgcvHOGJ25At7ODTJB+7wCyD0biMh/Zoy/IUOwYCu1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YlUMlZvr; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513056fe2b0so1104720e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 15:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709422354; x=1710027154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4mPvliG0dt9rHz01RD3Gj/gHYtffBEQ9/E8ecI4CxY0=;
        b=YlUMlZvrD4i57ph9snk0fBpiJL9btUMPrBB1/UjWy3MN+VWLV3BYMpX3jXXZj8pJPe
         a0T1lxcqS7ZY2sf7M3Iu4WlKNta6/ZqfMjnCL7yc9N4EqwZYU+vWMzMWY0+FGXnG01Fi
         DCpzzATeT8bx93xAsaOeLQIEk+YR9FnVZZQt45WKfWw/w3b9Sfb8YafYcRQ/mgS67Mbk
         Yz4YXjyarBswCqzin/h9CZXFBhDDU4DZl+/TU04bvI3kDXEICjcwQGNRxFQbGTlJ5XOF
         gCV/ARw4uagRMOfDprA3aKm0RjbJHhp5QXH6lo9K1+JD6PQlf4+1Ek1T2Dd/TvUY7y+i
         DkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709422354; x=1710027154;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mPvliG0dt9rHz01RD3Gj/gHYtffBEQ9/E8ecI4CxY0=;
        b=R9ct46rSmVs8srLrxZLLO6c2GDz5VnkBUIW0W1IgbgwHnT6Mi4HdiidOL9w5X5weiz
         NCiC01Jc7Lj1yyFTjmy4ZnSrhtOirdHrIUS7I9G0spfMbSdR/qQqH9l2Rp97ELQfkcJf
         VQIekdmsIMxy06duRIdOocs+NMLIbtVwD+2SlkDreTEsgS7cMDX+OvNMq+eJ/rZwq/Z0
         gWPwyovZ6UifG/0RGyfBaE7jI2H4w81NmC20HbJu86vsi6E80GeSNr84MKIHgX0F2ZYK
         KqNnqjJF9ofxyCAPFanQ7AXwbWaWBdalF1YvYnyv6K7wjY+FLolOJAxBr/PnagAcUPDP
         Hwhg==
X-Forwarded-Encrypted: i=1; AJvYcCUZY0IbU4SNnTcMcfji1zFISnEA5WhHl9OuqMdhywGhoOW4shHJXnobHWroFzzq5XuZCS/FAKz1mwepm9OkTZ6VjL/hYJ+BckfahMyJ
X-Gm-Message-State: AOJu0Yztx1f7br7NxLjgknCKI9XlDiNyCprsG0NGPDFIb+f1JgUDlGX7
	TgbH4tJGZVBSDkyJucAdx/Jln0zzOhzwmR534BeTq+uFNmqQWgAsQKzVmKebvDE=
X-Google-Smtp-Source: AGHT+IGvsd9RXSx2de7PE8W+Uv1OJDjbRwGPktI1j/KtV+TeV3VbABqVT3gysdEY5SbCwwFKkTQ+Mg==
X-Received: by 2002:a05:6512:3e1b:b0:512:fab6:6df7 with SMTP id i27-20020a0565123e1b00b00512fab66df7mr3471091lfv.3.1709422353740;
        Sat, 02 Mar 2024 15:32:33 -0800 (PST)
Received: from [192.168.1.102] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id i10-20020a056512340a00b00513409c4472sm153119lfr.31.2024.03.02.15.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 15:32:33 -0800 (PST)
Message-ID: <2aa5d81b-c7fe-14e0-40b8-80ef5ba364cb@linaro.org>
Date: Sun, 3 Mar 2024 01:32:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: Re: [PATCH 3/3] arch: arm64: dts: sm8650-hdk: add support for the
 Display Card overlay
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240223-topic-sm8650-upstream-hdk-v1-0-ccca645cd901@linaro.org>
 <20240223-topic-sm8650-upstream-hdk-v1-3-ccca645cd901@linaro.org>
Content-Language: en-US
In-Reply-To: <20240223-topic-sm8650-upstream-hdk-v1-3-ccca645cd901@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Neil,

On 2/23/24 10:52, Neil Armstrong wrote:
> With the SM8650-HDK, a Display Card kit can be connected to provide
> a VTDR6130 display with Goodix Berlin Touch controller.
> 
> In order to route the DSI lanes to the connector for the Display
> Card kit, a switch must be changed on the board.
> 
> The HDMI nodes are disabled since the DSI lanes are shared with
> the DSI to HDMI transceiver.
> 
> Add support for this card as an overlay and apply it it at
> build-time to the sm8650-hdk dtb.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

<snip>

> +	mdp_vsync_active: mdp-vsync-active-state {
> +		pins = "gpio86";
> +		function = "mdp_vsync";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	mdp_vsync_suspend: mdp-vsync-suspend-state {
> +		pins = "gpio86";
> +		function = "mdp_vsync";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};

If you have a single pin configuration for active and suspend states,
then likely you may have only one device tree node here.

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

I don't add my Tested-by tag, since I don't get a panel working on 6.8.0-rc6,
while in runtime MSM and DSI are enabled, the panel driver is not initialized:

   panel-visionox-vtdr6130 ae94000.dsi.0: Failed to initialize panel: -22

--
Best wishes,
Vladimir

