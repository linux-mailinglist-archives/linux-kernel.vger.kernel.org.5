Return-Path: <linux-kernel+bounces-14074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCFA82179A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B595282358
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DAA4433;
	Tue,  2 Jan 2024 06:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/bL/xLt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A6469F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 06:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d426ad4433so32447555ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 22:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704175885; x=1704780685; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NFh97dSRDNqfznFeNWXlDnnw+ZiewGRvUxlIWQr15og=;
        b=y/bL/xLt/esxMZlGN+KDsZwTa8TzIUY5wcjsDSdOKAURLe69Y0v0QqtLDX64K0usHR
         bTVvRTTzeTrA8DMlfmhOfdrnK58AxmWRz0wZQIBWlW0Q50L9bj4O8qURIxKK2ZeYR2Mr
         1RGcp2G9t37VWHmCBTj+cQCPLTJ8zfTROCAJOXmGW+uqRPJk8CEU2n2/hW7aUwvmonVn
         SvVwyiqHd/MoXdtLuLwt2hIwag2sMRcIRXOFkgCO2sKEd/Bf/nB+WhGUuk+YdxYLBJcx
         TQ9mxb2SQkI56NpVpXAuwhY+CCcocrjtbNrNrhtHum87AMhHz8hV85h528tkgjk2BpNZ
         oRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704175885; x=1704780685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFh97dSRDNqfznFeNWXlDnnw+ZiewGRvUxlIWQr15og=;
        b=uzD3OOC5uT0FGVmotHwLb43QduGGLvHQnmM3sDFo4MnVQ2Zi/tUPUE6wqx2ama30jh
         UAK2k6Q7zS+gEHvT58Tk6+q7/K+lCG9vuS8aoXlg0OyiWssY9B77XUoyWclQgvpUWp8k
         9Tv9wXuCsfC9SLgIsEWbmmu/iRBUyND29GM5FwZD7Sj0c1vl6aI92V4xWMkfeLHMXdAS
         LL+kIM4cjLoEkah0VElVUKsPZuDxOLKvp/Tpq6pTpfxgbjzszt5Lm2Sw1lEoulvOxd0Z
         2xwaRHr4tenpr+UNe0ukT+ykOCUd7Xs8fKORvl1rU1pNOBxec4lLFw+TTKiCNUJMz8L2
         Tl1w==
X-Gm-Message-State: AOJu0YzEe0ZmM1SwWbHy61ZdBUBQOwxnAIRBHzl8qDjXN46VznLmfO9H
	Vsbp5fsC/Brj4mXVghpc1Khic5nafg2rGw==
X-Google-Smtp-Source: AGHT+IGMG9kgP1ay8/XmAdvbQ3f25qeBNjP26A9CY6DqKapdjgwQVVolkoGyVz+bDEsj9mPV2GA8Cw==
X-Received: by 2002:a17:903:120a:b0:1d4:9ac9:eab4 with SMTP id l10-20020a170903120a00b001d49ac9eab4mr2420060plh.95.1704175885729;
        Mon, 01 Jan 2024 22:11:25 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id b22-20020a170902d89600b001d4b46d8c10sm3389640plz.66.2024.01.01.22.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 22:11:25 -0800 (PST)
Date: Tue, 2 Jan 2024 11:41:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: cherry: Add CPU supply
 dependency to cpufreq-hw
Message-ID: <20240102061123.frvwltggqqh6m7pm@vireshk-i7>
References: <20231229212853.277334-1-nfraprado@collabora.com>
 <20231229212853.277334-2-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231229212853.277334-2-nfraprado@collabora.com>

On 29-12-23, 18:28, Nícolas F. R. A. Prado wrote:
> When the mediatek-cpufreq-hw driver enables the hardware (by
> writing to REG_FREQ_ENABLE), if the regulator supplying the voltage to
> the big CPUs hasn't probed yet, the platform hangs shortly after and
> "rcu: INFO: rcu_preempt detected stalls on CPUs/tasks" are printed in
> the log.
> 
> To prevent this from happening, describe the big CPUs regulator in the
> performance-controller DT node, so that devlink ensures the regulator
> has been probed and configured before the frequency scaling hardware is
> probed and enabled.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>  arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index dd5b89b73190..505da60eee90 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -502,6 +502,10 @@ &pcie1 {
>  	pinctrl-0 = <&pcie1_pins_default>;
>  };
>  
> +&performance {
> +	big-cpus-supply = <&mt6315_6_vbuck1>;
> +};
> +
>  &pio {
>  	mediatek,rsel-resistance-in-si-unit;
>  	pinctrl-names = "default";

I think the regulator needs to be mentioned in the CPU's node and not
here ?

-- 
viresh

