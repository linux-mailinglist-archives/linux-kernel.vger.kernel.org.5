Return-Path: <linux-kernel+bounces-72784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B7785B8A4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E35A283B00
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587CA63410;
	Tue, 20 Feb 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1dcRABd"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3BB612CA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423825; cv=none; b=Iuf2/S35uAzuQ94EjszVFt5/MbUZx2YErBFsGHqZhOLoRaySVG44Asqxh6CMCL3vGeXBSDNm0CAC5aqA4Fns2YJPfuf3Y8acmsj8J0ntUs3gO1iO8iuXEJNbTXaUA804jpkX+60IJvU+mUcP8Qezjg30hJ5OCpN+rjJSwXS/4rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423825; c=relaxed/simple;
	bh=cSee2MHwUQSWAtYJ7PIHgJTkTGS6VO4I5SKQOP/wUJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7uHrKaPVToCmRSx1q1/fj+rkNf0ok8dDpKuuu+gPfcXYasZRseZVfa4nApBiJenMcWyZwPVguyOgBKt3v3SHttaLsRmRzLbZjIk7BY8NFtlhCibuvLmAWWaKzM/pZZ+4v1s6SHIVU2MFuh2NxgtC6S7lcsV3HWAQ9zXZJ5Jy/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M1dcRABd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41269c801eeso10270625e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708423821; x=1709028621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y/8AZULZ7XSFUyo0VoqNWIxSqHbvtO5lOFpI88SV+9c=;
        b=M1dcRABdlQ3kZ/1RVZwB0huCpd/gHdmImUdGREHytp5RtXLP0N/gD+vOuNJgIavY16
         g+DI2MgOWSs8k3KA8ytCLQvIFLCCBEIiJ0BIEfLfQbUKMMCqVAfyLNtbbyfXdLb3wv8W
         DlkhwNrjwCVGs9gViywr854OYOOsuRtLB1Yzt2/kgSM+77OF6mL1ZVX3Jvfoayn4+fs1
         G3FmtcQxKQZvBbNpUyHv44y67ZZ0+V5axO2Qv5klz91Y0UD0npiL6qIHrFIvuUlt8xAk
         xJPNyRrcrmUfYd+SKym8XiaN5EzuqSN8E5Y3ct1KgY4KhAdqPCzEDszH/lyZbIPLNui5
         +WWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708423821; x=1709028621;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/8AZULZ7XSFUyo0VoqNWIxSqHbvtO5lOFpI88SV+9c=;
        b=bkIzc6qEGXGuex8rM4jbf6eg3f36ZTKLCay6mw4e8190VYTyxj6MJT+yvs8zIYzQ0F
         1oFKNBUZG7DKLWpwvqo8WOx5EoKbGinUudULegThTQy5SlPy13OhP5XNt0N/yBaBhZsB
         kZAITEDGlVsDoZ59hK3WJBw6ln0zjOi4rlir5L0I+yDayoM1lC9sdU/zngKCpFd+9RN8
         d1LAKHiIlcK8LucwHDZa1yqqwO/3jqOlvmrNdmXlepuDpIXrdgzfyvXSHqjG1nocf8JC
         eaeZit2/0jwWio8K85QLXo29vqvRaDupfSyZNOFRQMPb4YPYelKORCSuV5fdhg9Z6xSQ
         p4kw==
X-Forwarded-Encrypted: i=1; AJvYcCW3oBAOMR/ekbIjgS6lrzbTgVTeO3t/zrsNyhNQQNJOewqhB8R04lzn1cpAXNm09wVeJUc1EiwUPSZ6mJgOkDogrgAkMPoJObHwoe+e
X-Gm-Message-State: AOJu0YzBMSA7PQJAeELaHcTxpOKjLvc1c+dIUOQtPBkbRDyq1m59L/nb
	kTD/kdYc1GUSq9CMNaaRUIM3TTbhb8DgzNJxWK0ecIiaRIFy+qxTqLlRe4MbY+s=
X-Google-Smtp-Source: AGHT+IGRdLhP5HmVgrcUhIe4LKpzhAasGmy1OF0IdQgi3GpP6nk9Q59uIrMTOb6NjZlcMjACzIPaDg==
X-Received: by 2002:a05:600c:4f53:b0:412:5f58:53a5 with SMTP id m19-20020a05600c4f5300b004125f5853a5mr5253705wmq.24.1708423821359;
        Tue, 20 Feb 2024 02:10:21 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id s8-20020a7bc388000000b00412260889d9sm14022129wmj.1.2024.02.20.02.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 02:10:20 -0800 (PST)
Message-ID: <875b706f-801a-4a4c-8806-411a67c5a5e7@linaro.org>
Date: Tue, 20 Feb 2024 11:10:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/5] dt-bindings: clock: histb-clock: Add missing
 common clock and Hi3798MV200 specific clock definition
Content-Language: en-US
To: forbidden405@outlook.com, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
 <20240217-clk-mv200-v2-1-b782e4eb66f7@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240217-clk-mv200-v2-1-b782e4eb66f7@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/02/2024 13:52, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> According to the datasheet, some clocks are missing, add their
> definitions first.
> 
> Some aliases for hi3798mv200 are also introduced.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  include/dt-bindings/clock/histb-clock.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/histb-clock.h b/include/dt-bindings/clock/histb-clock.h
> index e64e5770ada6..68a53053586a 100644
> --- a/include/dt-bindings/clock/histb-clock.h
> +++ b/include/dt-bindings/clock/histb-clock.h
> @@ -58,6 +58,27 @@
>  #define HISTB_USB3_UTMI_CLK1		48
>  #define HISTB_USB3_PIPE_CLK1		49
>  #define HISTB_USB3_SUSPEND_CLK1		50
> +#define HISTB_SDIO1_BIU_CLK		51
> +#define HISTB_SDIO1_CIU_CLK		52
> +#define HISTB_SDIO1_DRV_CLK		53
> +#define HISTB_SDIO1_SAMPLE_CLK		54
> +#define HISTB_ETH0_PHY_CLK		55
> +#define HISTB_ETH1_PHY_CLK		56
> +#define HISTB_WDG0_CLK			57
> +#define HISTB_USB2_UTMI0_CLK		HISTB_USB2_UTMI_CLK

Why? It's anyway placed oddly, the entries are ordered by number/value.

> +#define HISTB_USB2_UTMI1_CLK		58
> +#define HISTB_USB3_REF_CLK		59
> +#define HISTB_USB3_GM_CLK		60
> +#define HISTB_USB3_GS_CLK		61
> +
> +/* Hi3798MV200 specific clocks */
> +
> +// reuse clocks of histb

Don't mix comment styles.

> +#define HI3798MV200_GMAC_CLK		HISTB_ETH0_MAC_CLK
> +#define HI3798MV200_GMACIF_CLK		HISTB_ETH0_MACIF_CLK
> +#define HI3798MV200_FEMAC_CLK		HISTB_ETH1_MAC_CLK
> +#define HI3798MV200_FEMACIF_CLK		HISTB_ETH1_MACIF_CLK
> +#define HI3798MV200_FEPHY_CLK		HISTB_ETH1_PHY_CLK

I don't understand what do you want to achieve here. Clock IDs start
from 0 or 1.



Best regards,
Krzysztof


