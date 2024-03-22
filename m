Return-Path: <linux-kernel+bounces-111938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A23887301
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B5C1C23284
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E620865BBF;
	Fri, 22 Mar 2024 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNvbRt+S"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6462965BAC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131852; cv=none; b=HB0Lma+l9arAaa/wsp/MZ5/oC4BjnGCQG8Ep+SktKO8J7KXplj1eztSjw3XPEmjtXYJbrJnoHO99gLip08HyJ0dF9lPfu9a0/TVAwwe7h3CGK0Z40UV3OmHSunVckWrNGb2gLjq2WYfes2B0vRgwAgqM0GIrrpT370sz9tE9DwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131852; c=relaxed/simple;
	bh=dXVjwnhtNFUH/T+0aRLLT7N6X5tjidoT4jCBFosLnew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RgJfzIukhSo6NKxhpsexysI+DV16ea+X/VPpr+2yE8UJ7wFbUVTdtlIe5XWzz2oO/ZdcZWmjm0EdjH/q9bxcfdMpzew4XbHYCXDJL+Duac8WqDGB3/oOajDkrltDdxXs+PWLRv0e/4axVDXWbko8w8F0fpl6fL4CszysziSxb7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vNvbRt+S; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46dec5d00cso322012366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711131848; x=1711736648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dXVjwnhtNFUH/T+0aRLLT7N6X5tjidoT4jCBFosLnew=;
        b=vNvbRt+Skp5E/7i8BllO5Py96Bo74LgQQwYbVpjQSW8tQhS6Ka/szNN3bZBgYQSYWE
         ulhSQxVoTOrGtxsrO5MKMW/Zzv5QEkZyRIpusw77YVdAuC582pXqhCBj8oYzRCYt5gYD
         kJv9tjzUlO6G3a9TUgp1A2j/7F4tITZqAyeUvcGKLqGoycRAEV8Z2v5APOlnrlMMXBYH
         YDQu53XqQUCj+cMOpngI6PVB9VdSpMJGGAkeY+qfFEUYOXPC1RRUbp7uisI9HB7LEDwe
         oxDQQqnbfHqbMLGL7DQlQ6iei4gZ67zMINUy6ZhsxbvkhNDPuO9pHZGrI18xmq+0joq2
         8SCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711131849; x=1711736649;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXVjwnhtNFUH/T+0aRLLT7N6X5tjidoT4jCBFosLnew=;
        b=d6JQ9vs/YrEuGzXWkH6y4lKyrMp4jqOtEFCjhCvpLfrEvkkWjS+a6hR/0pHWaeSfM0
         eAXrfygicd717wJqnUUZ7NpA5WaVod0/3SFwDW8NOhDD0qls63r9rYNaZfW4r2EwioC/
         LSOdGjVVHK9ZLoER3HHsjkgGM63w737JdhKTnrex6ttieF4Qy4ReUrGWXpnGjRckXMLG
         g9+w64B+E4sf6x8hET6TpeAtkdsd/8rwW/mZ5iXy4rpYnpCH15RZMlDH1wlJ8PTvBCS9
         3zr5WJBpZfOb/IHNF3QApks2F/E1ngXMyrLk8U3h3XgqLiGMmtObNma80zKuEdeJMZCX
         s6nw==
X-Forwarded-Encrypted: i=1; AJvYcCWR5BI5ojakzebSwPn/1mvZQffeuGpwq56ww4tP13dMGyHYjFrNXEIjLSSy5WE12D8yZhbkR5RKvc9TokyfwjZ0Sk3LQme/PwP5K9ut
X-Gm-Message-State: AOJu0YyTT1ak0ic/rGx1EIVCJg0GAQQniiE8l1XUnwejyExKixO1bmIt
	D++tWb4knEK5oyVxnjbsJx2BQaDQ5Ak8h8Ak5MaeltBqjdX9leAtoGzEQAxIYpiR1j3Ii0aO+Vh
	SuW8=
X-Google-Smtp-Source: AGHT+IGaaI0/MM2XayEcg9GbedaqFCIJBCGMUuXaCvmO49f+ZB/T6tePv+wXqryNTHSmiOOs4BjFKg==
X-Received: by 2002:a17:906:d81:b0:a46:a9ad:837c with SMTP id m1-20020a1709060d8100b00a46a9ad837cmr308318eji.49.1711131848631;
        Fri, 22 Mar 2024 11:24:08 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id w24-20020a170906131800b00a46b10861acsm77304ejb.208.2024.03.22.11.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 11:24:08 -0700 (PDT)
Message-ID: <1d62c159-a484-4eb4-a238-c4b6fb22fad0@linaro.org>
Date: Fri, 22 Mar 2024 19:24:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] firmware: qcom: scm: Rework dload mode
 availability check
Content-Language: en-US
To: Mukesh Ojha <quic_mojha@quicinc.com>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1711034642-22860-1-git-send-email-quic_mojha@quicinc.com>
 <1711034642-22860-3-git-send-email-quic_mojha@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1711034642-22860-3-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.03.2024 16:24, Mukesh Ojha wrote:
> QCOM_SCM_BOOT_SET_DLOAD_MODE scm command is applicable for very
> older SoCs where this command is supported from firmware and
> for newer SoCs, dload mode tcsr registers is used for setting
> the download mode.

This is a bit of a spaghetti sentence, but I get what you're saying.

And the patch looks good!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

