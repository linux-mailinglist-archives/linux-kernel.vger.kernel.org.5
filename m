Return-Path: <linux-kernel+bounces-52607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3677849A5E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2496F1C22E01
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B7D1C290;
	Mon,  5 Feb 2024 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6nGWrAg"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A4C1CA95
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136458; cv=none; b=q4paatgu1mAIVkTOGE0UCGRniIG6bfiEkH0161RmZ9hTXzn6gv99weadx/XSFLhUw2LVlIDTNXanXBhVR1BylccofrOPSO4FAGzXYyHqijWmKTFeLVmui6qjsa6e7S0x3yijOA0UUEzXHNBABnYbtw9IpPWxaTrUWmmjbfuehRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136458; c=relaxed/simple;
	bh=Lt+YO25hZQQoh5UbuLV9sPDAooCUgC9jCahqzJLHKKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVcfQRr/Xy3klBIGujuPT8P5nCCEiofVTQ5jjHLkq1A4hvuF+bRJ+97pAVEZfqG5B648DHG+arkCIHwkVvPB7LgPPpK0QMEX43WkOBElrVwmoZPDW2QVoBUuLVdRgsRRbzPJvnAq3XAzqK32DCjigFpXsSzA3z54jJthdDlLNI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i6nGWrAg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fc654a718so25717095e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707136454; x=1707741254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOll/KAvysnEkpc8lsNAZeYhoN8z0n3ub5NB0HgkO48=;
        b=i6nGWrAgzoMJBvW0Aw5D6BaTTNzJAYs7nTYN22Qyi6VmQJVLVAZlCupmxhTJ7Jv80R
         VN5ucQjZhU8HoQ3XZ90V/oMJnZlX0aMPgmVTw5LfJbZQDDD1XkBae3YIBBDh6vH/0G7H
         wLSHvLgPsVyXKp8RDOs8oy+yI3/dPRtBtR/tR0r61y6Gln/R6bt1c14bJ49R4XWJGMTi
         gcWiygUnWTBpthHgAIW3Z1Px2LQoC/jhjm/updFLAVuL/oNlHQUEgPHQPZQ/S4nE/DzE
         yOb/hulHsbJd5PYmZNuz88QNTP8ysR+9k4WrUDPBlEJCixyWAo2Mmmk9qPLmVeCDuiQd
         1Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136454; x=1707741254;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOll/KAvysnEkpc8lsNAZeYhoN8z0n3ub5NB0HgkO48=;
        b=qylYA0jl6YmDFKNElvWKZBTouva6qa7e0HgP2idqvaOm4DhLNBkvMT/2DVuEUa5DOL
         gjXaeUm1LJVPY/YZCbYGZkNnfbjqZ9bXBtix0r5Srk9E3dYBI1dNaHs/2f4S0fGmu+fu
         GWP4lc7k5Kl/UakGQo2JxVyDE22db9XJAySwCuGi6goslCMpPZf96pNHG1GtHXbN5qSS
         cNmK12G9OebkQ3JgF+m8PkpGK3MC1DKkH2DVb4a/J1sI6vd37E2h40JLrfBQzKDmTxpW
         wXlnZobOpAWjutEZCjkjcrAUBh0NiPqrm9MEQ6QKVLnPJJR9zBjfDuQ5gkMHuwqobUNB
         Okow==
X-Gm-Message-State: AOJu0YyQSOB8Kf1Mjk8On9IfkfFV+L5Au4dnuN2iIBcZzDkRtSpg3Yp2
	AmZo8bfVJtZNURBeB5gdGL3p1GpWlY7NiqCqt4TG4SP4ulgE250vno2LRJQbvXc=
X-Google-Smtp-Source: AGHT+IHUseuRt5lvkX2tk9yas/yYzx5gYOTRQSfmjvqF7tgUFaYlXxD9XJt2FA2mGWDmNsn7XHiF3A==
X-Received: by 2002:a5d:4d10:0:b0:33a:fdc3:a61c with SMTP id z16-20020a5d4d10000000b0033afdc3a61cmr6714694wrt.31.1707136454483;
        Mon, 05 Feb 2024 04:34:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUOgcZhPRSBQOjhybBynGeSx8PGkCcuL3M5wlj2Uh4ewpUeh6/hhCXy4MMmaGTsfzXDy35pYRDgGhw6gnDA41UlBvUjnzDXuR7hJcyqu/EM/Z6J41h1haCIeOMyFSmmjMQyv+2V8UhKTB/lPm72urRZz6h3gPa62MoOBZacm0ANan3lsEmmAnMIHmQMQ502O6FmrMo7vjXC3+Jyp+YTWiosQDeocOdBJMSKExf4sZxUb9S+HSVS9QRnyYRXWxn5KjfP8/zSG0cCIALY++3ZO54pg4RECykkbQlYSCyeJZssj06YSIovgOhn2fQxB5doqom+eVyByJra6YIonnDIcmJ/
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id e35-20020a5d5963000000b0033b3cdb9336sm2256202wri.57.2024.02.05.04.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 04:34:14 -0800 (PST)
Message-ID: <32a36a48-fff9-46a0-a934-ec1894a14d1b@linaro.org>
Date: Mon, 5 Feb 2024 13:34:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] dt-bindings: arm: qcom,ids: Add SoC ID for
 SM8650P
Content-Language: en-US
To: Jingyi Wang <quic_jingyw@quicinc.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: kernel@quicinc.com
References: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
 <20240205115721.1195336-3-quic_jingyw@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240205115721.1195336-3-quic_jingyw@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/02/2024 12:57, Jingyi Wang wrote:
> Add the ID for the Qualcomm SM8650P SoC.
> 
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


