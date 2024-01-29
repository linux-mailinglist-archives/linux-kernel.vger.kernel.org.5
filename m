Return-Path: <linux-kernel+bounces-42344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFD683FFF5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66083B20E41
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FCE537F1;
	Mon, 29 Jan 2024 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oSSH0rR1"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BAB52F8B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706516549; cv=none; b=JLVvtCQMYjKxN+PaBP/ui0GTLjUUWDfVsvNy7Vixftfy+Bz3+k83orSOHr6yUylKuGtuZUEAG5N0qGzffl7qpRc94jfvqYp4Unya3PhHc94aopz2HBK3ULTnCwlYzhqDMbmK92+uxCn1Ev4cezI5a6FQ3FSYUcrMzpe922I0sww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706516549; c=relaxed/simple;
	bh=iVndGplK11tlk0wRE8UwW8xt7op1z+ybg0rd4YlxqVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpnwwarkc761O6ndMSpws2GV4qkQF1qY74uWBzFXGge69obNPksqqZsxBhbpxLELOybX46UrWORxVlUpIuBG0Uy8QD7gmsEWV9nQ+BU1WPGTjKEmg407UkXaG0WeROMe4gYR+1+f32DKYA5yZSu44Ud6ylL1dnJbgkvomrB2BiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oSSH0rR1; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso2059051a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 00:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706516546; x=1707121346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jYUrX/JqLoqDNiEyqHE6O/3ek0ba0V82a3jQZ+ZKIgU=;
        b=oSSH0rR1xh/OxOukC9q3AGMyeL0H5WU0XKhGUXG3LtU6Cm4qfyCr8COaod5wQlN8xm
         6hQ6Cze8SPQtFOOa/aQt0IzvxZv0z+hheMck9O8yMpr3W78AqiHWtEnBtoqYet+4JW3X
         Vdtvp/YWVfPckijvDDnhlR1dbyVYTBaGAgBdFcJ+mOw2H69eO+QIlH5+TItHsIDEJGm1
         ZFpcYWw506v8zOqVy/py3VKMDLa8Gyd0COphG75eqiA9tzISVkBnj7RIx7k9xKe20TEe
         NAZGhw4zO8tsRfRfubfk0OOYUyMs/Cmk12c8UKb5b/JFi9z8jTeWPKEZyyptyGGCW5Xm
         u/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706516546; x=1707121346;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYUrX/JqLoqDNiEyqHE6O/3ek0ba0V82a3jQZ+ZKIgU=;
        b=IXC69pj6wFIK4hjD2oNSqMpMzlIrxxCUkrJwTNvTaTrjFLDs+Rrs8DPxq/i2OOpk1h
         qZo3cY+TIj5itCNPJNTItK1gfxo4FExZqyGCJaBu5Cka+iK6gIKP4GzMmeVB/w+IZicb
         NC782hFrJ2EeM5d4e2/YC6/8MeDXXtXbSnogaxSgMxpxMjRCg7YsJzVy2Ufb9yd/Ewvd
         IWmVlIpvP/Xi2spKov7B60omGDn5Nv95FYx0p+zeFHs8Xl9ey1Rq/jE2pnS0HoVfBiG8
         hDPiOaTzYdj25CcTU6MRolxafFxMfANUaxQXcrbqX2wgYIeXaWtVnEZ7P1JQ7uQbXZN7
         Mkbg==
X-Gm-Message-State: AOJu0YxaHSwoVLPZwVyBlrtsdiiGSoDVUnsWtlDf+kwCWlsJy1Aw7Tug
	728QdRZQCSHfXIIJQwhw3upc2fs3md4LidG9YpA/hl8Hp8ekzpcOVVL+qZi4WyY=
X-Google-Smtp-Source: AGHT+IGZtyAjFHxpr2gMxUzY0Dm9MiDT0z5B5bzujJ0RZK3cvYGk/cr3cOXzGlf3IMWLB1Jg7A9TRg==
X-Received: by 2002:a17:906:2498:b0:a35:eab5:3313 with SMTP id e24-20020a170906249800b00a35eab53313mr254994ejb.75.1706516545925;
        Mon, 29 Jan 2024 00:22:25 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ku17-20020a170907789100b00a32fb8e79e1sm3644677ejc.65.2024.01.29.00.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 00:22:25 -0800 (PST)
Message-ID: <509ef748-80e7-490b-a096-80c942eba92d@linaro.org>
Date: Mon, 29 Jan 2024 09:22:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] ARM: dts: qcom: msm8974: Split out common part of
 samsung-klte
Content-Language: en-US
To: Rong Zhang <i@rong.moe>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
References: <20240127172155.63624-1-i@rong.moe>
 <20240127172155.63624-2-i@rong.moe>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240127172155.63624-2-i@rong.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/01/2024 18:21, Rong Zhang wrote:
> Samsung Galaxy S5 has many variants. Variants that support LTE use klte*
> as their codename. Currently, the only supported one is the one without
> any suffix, namely, klte. It is known that other klte* variants have
> only minor differences compared to klte and can mostly work with the
> klte DTB.
> 
> Split the common part into a common DTSI so that it can be imported in
> the DTS of klte and other klte* variants.
> 
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>  .../qcom-msm8974pro-samsung-klte-common.dtsi  | 812 +++++++++++++++++
>  .../dts/qcom/qcom-msm8974pro-samsung-klte.dts | 813 +-----------------
>  2 files changed, 818 insertions(+), 807 deletions(-)

Why code move is not detected? It's difficult to review it. You moved
almost 100% of lines. Please use correct -B/-M/-C arguments when
generating patch and create new one with proper code move.

Best regards,
Krzysztof


