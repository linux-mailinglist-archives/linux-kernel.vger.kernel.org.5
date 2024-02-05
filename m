Return-Path: <linux-kernel+bounces-52686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C8B849B79
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFB6DB2AB9A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968A71C6B9;
	Mon,  5 Feb 2024 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m4AFG/B8"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092B1C6B2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138517; cv=none; b=V6OI1l+qfCB3VOwY2s61zAZmw7/vutT9qJ66oXbsBDBGK156ExTEykotTzcBZ+Wrf7DhmK7UGS1aTbCgc9Qz9UkSDzwkMDRbqOZzYToqtpkobtZxRpYAHL6USsqKdgXXhcZXiZtXcoU67yXlQhz2FMJZaYwjI2jyWezsL8EGFWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138517; c=relaxed/simple;
	bh=JUqJjH28yOcMxLMNI+oGMHZIH3ZKlHk3VuNnrxWF6Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7VrWb89GZpvbI8vIi1B0winWjXSygS5+2PffPOQI21lIVl5NM+NUmRIiSOqfbA2w3sfC/zDmNmXtlsaiuAZLlWT/YS44bGgMq9WCz5jRTU9XQUvrARRPhXGK1kZTAvvfuqLOwvHNrBn7UKZ4rzI05O95jbULWwk5E7IBbEiDvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m4AFG/B8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fc6578423so26799385e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 05:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707138514; x=1707743314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JUqJjH28yOcMxLMNI+oGMHZIH3ZKlHk3VuNnrxWF6Uw=;
        b=m4AFG/B8h4gsqquqTcVaefTknxpFtZT6hRDq0Yd5D+VgBbhEaUibAGNPh4XlJwFx/l
         DUiFpBrIjdppgTW/zM+ikU6Wa7N2ItkaFA3QYKl9X5aG+kiLo/goH/tjDDPdNTCVXz5t
         Z1TpF1e6qOqYzrQIM7lrADTYPpEDnJjDyc2HXR0T3id95cKhy5nE4WmeMKytxOnTFvDz
         zF+RbjrU4wdIbAOu4yLcJkrIRE4Q6XJ5boB8xf8VpBnik2tLp+ciTY4AXjiyqJGSt5vd
         DbXblex9ItrOlnnAI8Cos73rCHZ5BnPyUAi6mkwag47eV+xIjzXOlDFK5hiNnRD/rQsP
         gHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138514; x=1707743314;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUqJjH28yOcMxLMNI+oGMHZIH3ZKlHk3VuNnrxWF6Uw=;
        b=TVjmxRFn1xrSUP2WW7MrzV/neaSImoXlWkjDXABtIZcPv6QYfgHYaVRe3mM/PjybTB
         uGe4Esu5HFzsIzDgfwAbv0Xa4eQs2bi2g6NH1oGdhRRBvxDEQiUqKkQO1hAdXUsEPAFP
         XqQwcmabTdd4qJ1dIRAHAngNhgJArCMp4dFZZAKAiuehixPMFMl3FqZEcpkSxBCcyLro
         Ia73pJksopU1uLHVGt1DmYxATU/F8csGsDgPLZObidx9kVfmO0Umrc/o6GZqm+NsDsbS
         lj1lU9b/JtL5OUUgcmkdumSML36MRPOejHf094H7nZ6o3F7gNQ9iOSTIY+G+Npvl2zWU
         Jo1Q==
X-Gm-Message-State: AOJu0YyTtj7p4Av/93qQLgPzlhtUSKrrUuY5PKGmOEEz4yXlPpFaY460
	Gn2WcmJfnNZ1rEvd0XgoWUdxjq/eD7bV8Pt3V1J/yKWr5Z4eCIjqMP2UKLq0Ee0=
X-Google-Smtp-Source: AGHT+IGmSTNv1NLD4ThyEXavgzPIU3udI55fVjJ4cKaivDzxzfYUr51Ry2wYiCKX2sZ2Yne/Ifpp6w==
X-Received: by 2002:a05:600c:5250:b0:40f:dd79:b758 with SMTP id fc16-20020a05600c525000b0040fdd79b758mr1069261wmb.40.1707138514267;
        Mon, 05 Feb 2024 05:08:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXTydsik0wGIRv1JR9uqlCVCHV3kppJ565jer+6TxSMFiB4IDcto1Ty87l7ISA/ZXi7TEPeJZf+KHXfUgc4aL6sZcwIpEvo+nGEmFGHHqLAShKyTFgQd7rbvvH+IXD4isAyCf6SoQfRvRkmH/gqd+rE0OaOvXrNqQLdwneBITZrxEcS4PprZo3Xqznw6aT51RHLMHpdWlNEZebJ1hGeT1vwg6Y8stjkTLDAZpK4RINu8VHDXhgMich+EdG3f5tlZLlznAjkoxVc0f+i4H/Mtu4xk6XHLq0RhI//FGe3EDPhEcgKuA==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ay2-20020a05600c1e0200b0040fdb17e66csm3289160wmb.4.2024.02.05.05.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 05:08:33 -0800 (PST)
Message-ID: <8714b420-58b9-4d5b-a489-31670c8d325f@linaro.org>
Date: Mon, 5 Feb 2024 14:08:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: Update pattern property case
To: Naresh Solanki <naresh.solanki@9elements.com>, Lee Jones
 <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: mazziesaccount@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240205110244.676779-1-naresh.solanki@9elements.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240205110244.676779-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/02/2024 12:02, Naresh Solanki wrote:
> Driver expects regulator child node in upper case.
> Hence align with the same.

Did the driver have DT support before? I think no, so why aligning that
way? I would argue that driver should be aligned with bindings, the
moment you add DT for the first time.

Best regards,
Krzysztof


