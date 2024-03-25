Return-Path: <linux-kernel+bounces-117815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3279788AFDB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C631C613E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DF118E1A;
	Mon, 25 Mar 2024 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMN8378x"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBF014A9D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394713; cv=none; b=HBd2zEdypsOLfKR3Di4UCJXpr+fAN93IMw566oQOJOkcHKO1ZYa5fEFK3qf7JMetPB9pylFj9BAU7XC1dpI0EdJyxlovhM3MuY7LnjIV4k41ljyL2sD4PL6Du1tAeTsYhBcZHDvyTJR0+I9crjR18Uuq7R5fCVBfxj2jHpiglP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394713; c=relaxed/simple;
	bh=w3QXnaTJuW/Efbl25UkF7wqu/APitQdvlop2brptunU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rq4ki7zDchVKT6c1T2gKpR8r3XEVrr2D/gO9tPEfyh6ZOE8FJNq832S0XkIqP2bE+VNsdlYRguxdqeJUrpon7SiXtgBiLnX4f6S++UCsSms2PcKgWOGo1kFfAGiOwwLcHGGNVNGw66El0ogdiU8c/zJWAtc2yC48ORKN86L4WzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AMN8378x; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a474d26fb41so219200466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711394710; x=1711999510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UIctYBDjNcVi7Hr0/+0MyF/aF6Y/JpYFokueqrrlBd8=;
        b=AMN8378xMKOmrpFeLSIRPFIgLgC+QiPvLuxbsNjgxk7DD2rHVO4TMEXvr7w8HQm6X8
         A9fMw56W5llmSl548nkmKfUfeowmG+V+belIWmbcR7Sm9oYWG6+qyjaiYECicI/CTIQs
         gFM/2mc6WY8su/glpb+kk2DNYKDSyTOQuJHF00E5Pj2xpzcSvuBGDJHtXsKewpqLkyeq
         NAGW34geZX40LvOP65iyUKG1S+frRDEm82y99sfwmvHcgnLBiIOktDKR32Lijua5gVy3
         dEt4tAz5/ML168UQSgw7TnCYaGJL8WdCJSknfIDzEZ0YYjuiPToWAkdTQwozlRKePGmG
         UxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711394710; x=1711999510;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIctYBDjNcVi7Hr0/+0MyF/aF6Y/JpYFokueqrrlBd8=;
        b=XRZ/hn26gIcqHu/krhBXt83wKWtFTR6/0BX2XTzP3U/1nngok1nl/DCHEEoAsJTyRN
         /xiA+yeZg3Na2kocFfcZz3r0GG++F5lPoOG8zPuHCuqc3wQkzpIfP/AlZHlqGlDjTI4V
         iZfPmKH7l97WP7Q+poiZTb48gxDzUubvQZlvfDsNrikyVWMUwBeF+MwOm6AMn+ym9vcR
         EopE3SIVOIS4y4HOYwGHijM/+K7dN9JuO3VlGas+f+QSoefMa3qT8EcVGT0FPohkYPNf
         oEJObYLKNV4tlEiIx0hRL5GtbB3P6XVBCC2QChWr7gcVx+22VxNwoig8/VyaLIc4JlEy
         mQug==
X-Forwarded-Encrypted: i=1; AJvYcCUWJk0WTP85prf0yV5nN/lX1R4Tt6yuM7A58iz/T6TjACFlBuYJkGfwXiGp8lgwUpl8wFsGXmEmweeJC0ewktXjjEDsOE+Fxux7Ize3
X-Gm-Message-State: AOJu0YwTGWmoTPYD0p3Hx+NRs01huO9yRyw5mb02GK+kNvAz8mBx867O
	wx6XZwQ2oI/aywKXuylQX37XLbvjyeX6z8V0OUpL42SUJ7iv1yUwoMeGPosijl8=
X-Google-Smtp-Source: AGHT+IG7ii6adj5Axsf7U57rtZ6AAQ+V61xVzuov+kR52qdv36JS9kFhtzgz5FdV84cMs11DrLAyMw==
X-Received: by 2002:a17:906:ca55:b0:a47:df55:cf6c with SMTP id jx21-20020a170906ca5500b00a47df55cf6cmr3471526ejb.63.1711394709879;
        Mon, 25 Mar 2024 12:25:09 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id lv16-20020a170906bc9000b00a464f709687sm3342977ejb.59.2024.03.25.12.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:25:09 -0700 (PDT)
Message-ID: <22993de7-ebe0-40ae-b756-81dcbbd82db1@linaro.org>
Date: Mon, 25 Mar 2024 20:25:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8250-xiaomi-elish: set pm8150b_vbus
 regulator-min-microamp and regulator-max-microamp
To: Jianhua Lu <lujianhua000@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240323100443.2478-1-lujianhua000@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240323100443.2478-1-lujianhua000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.03.2024 11:04 AM, Jianhua Lu wrote:
> Fix the dtb check warnings:
>   sm8250-xiaomi-elish-boe.dtb: usb-vbus-regulator@1100: 'regulator-min-microamp' is a required property
>   sm8250-xiaomi-elish-boe.dtb: usb-vbus-regulator@1100: 'regulator-max-microamp' is a required property
> 
> Fixes: 69652787279d ("arm64: dts: qcom: sm8250-xiaomi-elish: Add pm8150b type-c node and enable usb otg")
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

