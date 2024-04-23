Return-Path: <linux-kernel+bounces-155572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A268AF414
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91321F227F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9712C13D2A0;
	Tue, 23 Apr 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yoVNQySV"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BED213D29E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889646; cv=none; b=Mt6peI7RO9RSc6jBAMWxNEQHklkhQmxfVtmYBPws0q8awk625rq7OFmk4HM1KKd9L0JFUROtjigVg6ZNawxQCSQti8iE+7ijOeF2ibO7J+uMyc2AKzT4SPEiQX9+ub1TRwoSyuYG2m1q58vX8aaDCBw8qgBZWRcIOc9fZYj1oHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889646; c=relaxed/simple;
	bh=EQJ5cy072218OcU0VNKZTKMmx1FbJ6/ILN6XbogZpUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EfZPxwpKJQ5e1qERFvl+VD4epjOaNmruJYnOJHQULsM0e/fdgvJ7LIMf7ew537Icm9tKvGC9+XLbJkohqTfB3TQ3S8kYYLeE4haqQlk/9IwgfuXJnjpJezU3EdQ9+S/qagMmZ4FKllsALdFryOYpyehJZCs6JELzok/qTbXdTik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yoVNQySV; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-518f8a69f82so7079197e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713889643; x=1714494443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cASMFkFKtW4dQmdZLf0kAw4iUFwBsQueRVTCTQiPPls=;
        b=yoVNQySVTNs/mNCO9kNR5flpR7ec4ah7bfD1Zw86Vk8BHTskc9ybxsF4VEVtl9f0bc
         /w2p1YFkIc4MfJuG4hpHqYsedZcdcw/nD2YN9O8MDzRSPq0vULizK3LoEud7YLGEwMXf
         Gea1PHwxnFUN8YQ9Q58FKvYCN6nxAY22TyDqdbwfD59YBNnoMHb3nE/BGL04yj/Rj3Z+
         XAF9lM9feoxNzFzrMsJcfaG6pzTsve973wYcONLPda9H8LtJT2nwC76frBKzOShm8Z3G
         p9LL/yn8kbyIF+DnZ0ijuz7OVBT2TMWHTFWE6gvTU4TBBWM3K2eVAvqcw0UUzoJVXCEe
         iBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713889643; x=1714494443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cASMFkFKtW4dQmdZLf0kAw4iUFwBsQueRVTCTQiPPls=;
        b=HNktSXDDAooWBv7X/tOvZKhKu9tPaNi3G/sD/W9WJ10Rx5dB1alConRKL+bCcd62QV
         y210siZZ5HA00+wiGqrDxwFM5fvWNEoKaf1bzo4PedaEx2v0vfBVlcC2d3+GIHv/WxI3
         PnRCXLsC0KI+QoHly+c8AFqNu6OH5yLElo+yIX+R0e6hHd5zDdEasjjb/hltt1CfLIyc
         qUmyxNczySxJk+tXGwPwm8qxZuBKGLCrUZJkgbK4fc9XS1IIjoHj73tfwARKG2SpLxo6
         j4cjPz96aeHyHQxe/MRl4V5GULSDg6CgvY1Z18Zb5jipg3zdo9IBjhuwl9Ks21+KdJwc
         RE0g==
X-Forwarded-Encrypted: i=1; AJvYcCVHSUv94/Gj8XT/XcknGjO/cTej9YdPl3NXSOWs14Vg0SenRwGvbWK6+rlMiWp9DAsTEImBspKGtxe65UiAayldwYzqEDwQLqoJi+yV
X-Gm-Message-State: AOJu0YyxHovo7P/yiOb244lVqhy5z3ceTR+nkb4caxAXNJnt6P8ADAv9
	otdEbxCB9/MTovood1OctvxBYly5taZ7ENxTSY0N7U2Avk5QiWj+PHmboNqRkIFUcZwb5BeTkxW
	K
X-Google-Smtp-Source: AGHT+IETx5o8BLiFSVLpHMkKMolgXKQTO/RqpXUZgITjgBeIO8iGV4h8eYnJQq3RpA/wigp0XHNXBw==
X-Received: by 2002:ac2:4291:0:b0:51b:c6b:f87d with SMTP id m17-20020ac24291000000b0051b0c6bf87dmr32173lfh.35.1713889643320;
        Tue, 23 Apr 2024 09:27:23 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id b28-20020a0565120b9c00b00519758673cfsm2028932lfv.12.2024.04.23.09.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 09:27:22 -0700 (PDT)
Message-ID: <141c72c8-d859-496b-80bb-0921e50446dd@linaro.org>
Date: Tue, 23 Apr 2024 18:27:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] arm64: dts: qcom: msm8976: Add MDSS nodes
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240413170317.34553-1-a39.skl@gmail.com>
 <20240413170317.34553-3-a39.skl@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240413170317.34553-3-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/13/24 19:03, Adam Skladowski wrote:
> Add MDSS nodes to support displays on MSM8976 SoC.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---

[...]

> +
> +				mdp_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-177780000 {
> +						opp-hz = /bits/ 64 <177780000>;
> +						required-opps = <&rpmpd_opp_svs>;
> +					};
> +
> +					opp-270000000 {
> +						opp-hz = /bits/ 64 <270000000>;
> +						required-opps = <&rpmpd_opp_svs_plus>;
> +					};
> +
> +					opp-320000000 {
> +						opp-hz = /bits/ 64 <320000000>;
> +						required-opps = <&rpmpd_opp_nom>;
> +					};
> +					opp-360000000 {

Missing a newline above

[...]


> +				dsi0_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-125000000 {
> +						opp-hz = /bits/ 64 <125000000>;
> +						required-opps = <&rpmpd_opp_svs>;
> +
> +					};

You can borrow it from here

Looks reasonable otherwise

Konrad

