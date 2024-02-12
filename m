Return-Path: <linux-kernel+bounces-62374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D53851F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE42B213CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA6C4CB35;
	Mon, 12 Feb 2024 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AIoXSvnu"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2AB4C627
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772622; cv=none; b=R03BgexMibq2ODmPgFnm1aMWRKokUdCfh8gaHZRAGZV8tBH4eF/DgfcsbFCaAeZ0eNGQJlukScTzOHKoT/rY5WZzrxi/nvtUjgqU+MymTrNF20MwTKMrCvdGlWj9cxubjoKBIPNL/LiTs0cW7x+/pH2BGcDRH8kfKsK2zRuHHdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772622; c=relaxed/simple;
	bh=nAx2mPQTsaOk0/7xVAy29UdElMfrEAZDlaWkMPGlOzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WP0+A/DEkOTFeES+9ClZJ1fzR5/cZ5BmUP+FUC9eMTdHyi7l0MmaebLaERjhMdVNkcwmqtPRb4PsZL0yDN/kBbqQNwpToXMZglUq4Sms38tbdSG1M8fnIismpr2zuZFlQ0hXSJdSAaxjuxIV7Y8v37R5eEDjrul7n7lO/Rj8lAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AIoXSvnu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33b401fd72bso2440702f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707772619; x=1708377419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lThJKVe/txBS0wmOHDLSoMleAO0axNAH8qnzzAys7rE=;
        b=AIoXSvnuPiY1BB1Bp9xvgfr9KWa9UaNWm1q+36Af+IxGMsMjGo4nJJ3Cy1I6RynqNS
         VqX4cnOIwovJnCC9JECDywymVZJhqtPSV2+q7k4dg4FjJ1Ew3dV6bVevUg0a++ECc5z1
         N8XQH0spWhIF+iuzVI8KfhwaJzzfKuHdbXSkgElYx4fox8knMxTJPiprYhYsjS9KBRVk
         UsNtZXYVKozs2Cgcq2OVhZgWUmfHdsPFHX2G7O9Cc4HDFFDNhhTtN8muPtNaJexZuTkQ
         +VqHoz9s7QESeZH/H9HKum1XyWUk5KPD58/O1fcDh9zwqRFyeq5EFboghCkPLaucROhz
         MLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707772619; x=1708377419;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lThJKVe/txBS0wmOHDLSoMleAO0axNAH8qnzzAys7rE=;
        b=Q6SMPl2/hLTMhgQxlZ1p6f4tIZqYp0/rpuDStKar0iBVtcomJ6jB2nTMHAsPRmGVOE
         zoE9QkcSqcCPOtATgnB+G74HLnptTQH5peR5kG4r1MP1L8VSGkqqm3lt4rQJDskuEF9i
         50V4BvxyuxSc7y6hCCgAiQZGYR2qcIwznbn4vAOAt4awBgsGWbK+u1f7j82mqyzkApCo
         9O6qStO7ri4vd60hhYDlf0LT7NGEI7olEIzzSqjLXSamy4u1xIHX/KXw21wlKEVdyxzT
         iAhuhif6x8v9rfBmXkl6UlP6iZVOaIrgfEtt7VulQwdXWV3ANwGG5GjFM+TJLw//IOIH
         a3OA==
X-Forwarded-Encrypted: i=1; AJvYcCUPZZgt2FdvFLPdtFQPH2XnByjtMEes0k/oZK36fXOaq0zZOxguuKkJjxRDkpUIby03ggiNbM3HFpnC7nNBb/PVCVqrunnj4/JzCdhW
X-Gm-Message-State: AOJu0YzUCmYipJ+LN+NZD5285T1bq0aOvDTvxECFGBFqX5dRjTsfP7mh
	nt+LhR+/c5I4UOkhePWC7vfWRLVyKJm5vPpsS9G2lSbPHEi6r4Y19y4XUam4hEc=
X-Google-Smtp-Source: AGHT+IGTEzLXiSLefrTtyD2tqT6VQjiVCehBeTj4eoWFAgGTSlLmRNGpZHyK6JzNp5Yrnvd5AsYZwA==
X-Received: by 2002:adf:ec03:0:b0:33b:628f:3690 with SMTP id x3-20020adfec03000000b0033b628f3690mr5081505wrn.20.1707772618895;
        Mon, 12 Feb 2024 13:16:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXlMPcx8sllE1ZnkBUXVn3caXq1aZ/blSXEAP0vaw+7rK/rHY6+E06HI2ZDbOGEGPCaLZLfcSMMzeJsKNfrEI27LEqzHuo5eM6wtaCJ7O3J9BxqrZ9WTlH8TiNQTcpBNfDkUVkfCONwl3yXYqD9CfWUK675X1sFAHY/OEPjctXpzVfgQukrm2pz8+D5BMgxQpUFeFh3lFcTx0T03UfZdVHtJ17+Th+NkII7pmepnDnMI19N/b6H9EknWzjh/38CdKoTyExR0kPT2uFpjc97ICK5vjrfsGvTZchoMdXWr3rH/vk=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id z7-20020adfe547000000b0033b55186901sm7738185wrm.94.2024.02.12.13.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 13:16:58 -0800 (PST)
Message-ID: <177b479a-bbd9-4bf4-9e32-246d130d6aa1@linaro.org>
Date: Mon, 12 Feb 2024 22:16:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: qcom: socinfo: Add Soc IDs for SM8475 family
Content-Language: en-US
To: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240212201428.87151-1-danila@jiaxyga.com>
 <20240212201428.87151-3-danila@jiaxyga.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240212201428.87151-3-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 21:14, Danila Tikhonov wrote:
> Add Soc ID table entries for Qualcomm SM8475 family.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  drivers/soc/qcom/socinfo.c | 3 +++
>  1 file changed, 3 insertions(+)

I assume you are going to send DTS for SM8475?

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


