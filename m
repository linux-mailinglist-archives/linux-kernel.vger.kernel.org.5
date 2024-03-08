Return-Path: <linux-kernel+bounces-97642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0895876CF4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2BD1F2273E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68875FEE8;
	Fri,  8 Mar 2024 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pEvl+ZDc"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDB35FB89
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 22:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709936208; cv=none; b=Xl45pgH9QV/skmgGHN4GikTtAH0xp3VZTMSlnWWRDIr4qVil+WvAZuY4hzcbuTS/lP/FH12TDA3dsjb4z1ghVn1vMUmV0OmN0xeXtClUheYweTwxupUlNSK2mHSRmWU+Eo1+3Kd532Q7n/6g0MbKEByJuSN67VEuX5nptM6KmdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709936208; c=relaxed/simple;
	bh=3WW0T20esXbPOV4mKyfxQZFN7v0CB7rUWIid/qvBbzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlnmEayEs44p2ui4nM9ImpplYF7vMAxUJ0uPDoHl7UvehXzsGFRnasw1H5DK8hPaap/4qxeSG6r8E/Kd32Ab4jiqLdp/MXA4p2miIGEK8kdocXRYsc9yuLkz+DOpvxVUxQ6LjF9YE1eFE628dtceeaQEBBSzT7RaTXhm/5RYQzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pEvl+ZDc; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d288bac3caso16431601fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 14:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709936203; x=1710541003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M6WGaze6LMAlVEXi3gns02EuthFsVIHKV8ef7UH1OcY=;
        b=pEvl+ZDcfl3XdByzsZ8XmwzPIVGLwyuxM4NTxIyyefgOVfpfyyiavbhExyeaZl4cPt
         eY8sJSgKKQSg6RXhlS+glClSqouinLjOPx1o8IDqXwMqT63pNYoQUH4iH4JawB5grFfv
         WQVaRQGGLUi0rKMa7tKZOk1gQXuEmOcMeO7yXoCwnEv4bcMl5DD8DjL3d8VIvBok1m7J
         L7pK8Un2gpw0/vI4ii4C4nhgc2ol9bwkr/dSvz5dbYmonMPJHImirBXc3zYcZHjxVILb
         VcUF2CwZVgTlhnB3tVbsoLk6L6WpE4FpqQbbqPCBjisRjB8P0twULjn7wO/FdpjGQd80
         0TEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709936203; x=1710541003;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6WGaze6LMAlVEXi3gns02EuthFsVIHKV8ef7UH1OcY=;
        b=oRQYZx8HD4qRav+y0L4D6v3X/vxwNK/X1yPaTF2KkC4h7Gx/+jy/Ti5nY0aCiUJMEt
         nu/JwxcKwtKHo5ZGiBhlb7yC1FQ6saZG9cNPp91s6mzj09B2gDBe2/g9cqJu7aV/c7KF
         oixId6/U8SvHcFhFVvqtA+D+27mZcWBN539oMrlFqFMTJYoEUjkesDRkfXllQMU4T6TP
         vsjzXcRKs6czwdSWbGdrjjI0w8H3kPAhFxG6ITF1Tfoc6l1hOC6ZZLfbfHkb0yVKXtIN
         TfjABKtmWa9DOCkp1i0BmQfnu4ytRpvHsTh/k2f4lneL8Hi0X6bT/EevwvnDsW7Ec71L
         EYWA==
X-Forwarded-Encrypted: i=1; AJvYcCXPdCiBkc8r1ldtlN85b2Kw2QUBgLdlyl5Ewo3JAS4EgMM445RXnKZcFr6QG/xblzixI3Ulmw3b0o+SCTYUbi/pL7SSJBm4BHBnyq51
X-Gm-Message-State: AOJu0YzQa600FS0QfWs1btCQgNSGxvUeIHEz5tQNP9OP0g42uWoU1lzN
	2wV9aXctVHlLbRlufiRqR6lOoQ52AXKMkXVVHnx6vFBom2i7wT/NDchH7UJRGtw=
X-Google-Smtp-Source: AGHT+IG8oIdUaWDUUl+189MyLSxZd0dF1RBIwDfYyW6xHy+HlRtY9C6YLdmMrDpxClx/wBzmhEFyFA==
X-Received: by 2002:a2e:a383:0:b0:2d4:d50:2358 with SMTP id r3-20020a2ea383000000b002d40d502358mr325274lje.18.1709936203563;
        Fri, 08 Mar 2024 14:16:43 -0800 (PST)
Received: from [192.168.16.246] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a16-20020a2e8610000000b002d2904e959csm73954lji.5.2024.03.08.14.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 14:16:43 -0800 (PST)
Message-ID: <83ab8945-5c57-48a8-9dd3-cc525a92c973@linaro.org>
Date: Fri, 8 Mar 2024 23:16:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ARM: dts: qcom: Add support for Samsung Galaxy Tab
 4 8.0 Wi-Fi
Content-Language: en-US
To: Bryant Mairs <bryant@mai.rs>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, luca@z3ntu.xyz
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>
References: <20240219214643.197116-1-bryant@mai.rs>
 <20240219214643.197116-3-bryant@mai.rs>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240219214643.197116-3-bryant@mai.rs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.02.2024 22:43, Bryant Mairs wrote:
> Add support for this tablet based on the MSM8226 SoC, codenamed
> "milletwifi".
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Luca Weiss <luca@z3ntu.xyz>
> Signed-off-by: Bryant Mairs <bryant@mai.rs>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

