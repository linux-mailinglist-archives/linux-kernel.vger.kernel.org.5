Return-Path: <linux-kernel+bounces-65167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D528548D1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A331F22632
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B741BC3B;
	Wed, 14 Feb 2024 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TTrHitLZ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FA81BC2A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707911862; cv=none; b=tR+XP4BX4aO009TqDlzbLzMYvCrJSOC2W2dEizgtcWqW+9sCEOdcl3rL9WbNbr8hseRcWlUe5KBhDmxSUtQI+1gL1tAwKCKO8H1KZGJfvY5wgWoAGj5w7rtG3gh/8bvrNDYEQMzK9LIWqfySsDmCIx85KOfdqX9jRY0u464Pyp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707911862; c=relaxed/simple;
	bh=h4KbTL61QB+JiFC9XG6gAWCagP6OOPnl1hSrrrkSn/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hekTxY5CAaKHjpaZ6m+FSopuYoOZTIend2nEuyWReccy/1uCzmtLhgiEHykAAeoXzawmMnUYFe6kInr4T+q67DDD047If1Lqh6d90XTKOb38BeoQEZV/wMhwBKhRazTz/k/yRpOTq7MpQVClaa7ToMQVZASNt3nOGL0aCQBEij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TTrHitLZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so738409366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 03:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707911858; x=1708516658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67q8O6A3dDM88ECGRBJ5lZvEBNDnrZm5U5GWLi3eh9E=;
        b=TTrHitLZxZ7tH03ET0RbLTEKI3/tokTESngWlDZrONg0NONUJ6HFMoEkcssWHTRT3W
         jtKSOraYA/oWZ0ElFl3dhR5cDdLrmmk0s7DhJh6YhCJy7XmCaazJ2hC6I5o34NF+KzQP
         WPsVaEeIuVtADiyisA8FXGvYfRWqmnKbh0K7cs3RHlLHSA69Qvw8kAvSt0poPLrx0fLv
         siV6McpBRdrSi4N+i2jEFjsjPjAPgMTTT0kzOZV5vvWMybIx+nGVTWWhyDBGl4zMqfeJ
         3TckMXO8W612W2Rk6X4w8fT1sOq4/9BkC+TCbNcZnCX8zlbdcqzdqf9Pc4zix4JvxeBy
         2zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707911858; x=1708516658;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67q8O6A3dDM88ECGRBJ5lZvEBNDnrZm5U5GWLi3eh9E=;
        b=Puogy+iKm0ExgMwB02tVtGDKsbl5YvKxLg7MTr377Ep8E8ouzrOZQ2rNMBH02az/D5
         L81Z+Fjg/OPTZ4wJvQRPGS8vSFAy9Qxywf7/QmaULfDpI9mMF+AX4q97bzBbgHbiihka
         RFWISVXfaT0dz/buR60ynA6rCXGyqPZaUDLccUAJppoSbxlU/QEjj94KQLQRfLW55z+I
         u2RrmLym9fb/LpuIUCIcNwx/b+6nduVix+vhHhyF2+oBAjKT9zupCm5RdepVcMtB5oNC
         Io1cICY9WJClrTEaBu1c1yxVrTGZkXZyzlz5EtLFK7oX8pNrIlNMl70HAOGQqAFVt/bj
         hIJw==
X-Forwarded-Encrypted: i=1; AJvYcCU2SvEh+RFu43gwOwJCdXaJMXqhDvyqlzTs9lYQ4q+j78mgawFm0ojk5Vk0u0J7u+CC9WSAVhepQVIXc2fjXaUeP+oPeIaQ390gZ3WT
X-Gm-Message-State: AOJu0YzKwgLJf7gbfcX6Gcsd64gUUoVcw4Y6/o9fwbsmEDOAOcWNy1Wv
	JoVVd6Xxmia56HKuJmEWhQxOzE07inTxyrVBr12lKnf+GzmSe2Mx4//YwYDY/Pc=
X-Google-Smtp-Source: AGHT+IGE1Vuu7kglDmlBOi46q1a0g5RNdAQeeirYMFNz+tvDmx6rwXqVbVxN462cZFPcPsNwINX0EQ==
X-Received: by 2002:a17:906:5291:b0:a3d:5406:a437 with SMTP id c17-20020a170906529100b00a3d5406a437mr889248ejm.28.1707911857651;
        Wed, 14 Feb 2024 03:57:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVN8h0YmVC/rv0qAQYdSl4KNCIy+El5+WYB8lB5xiPBKPn3aLgLPJMrvXLIuDatahpbtz316xK0RKE9baEAzgEQTBcccwDm4+5V9V7NwJ+cf2XRWuoHnbqARh2FQD9Ml/kmm71rpTmU7S1gqN6nmePf/ZRhHBbECwIXTpdrVKa2p0fLJQWblUZmU7+IO7NwwjDGdZm46V62UaB6/TLbMJaKjotg7MttGq5ewADhqpxDRPYYWLehxi+YnSCDEjfE3pNO4fqWEx8WrYF+6E27LbnpsQRFibYUJxyGR/okQWx/3HCG08GhcQ8iv6IwVIus5yAT66vri30cro5zA86/xHOf8E7z8deH6lF2wupoMm6taXHyQsG9Tm6YB+qQHeVS1XDeokxjnEBRr6NtRx4hior7u3CvL3U+lrLhoGToIpaX2ORcey8phOcnHCjlEnVlbCdg6pdaWdv/U91qZlw6
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id xa4-20020a170907b9c400b00a3d669a2055sm88651ejc.88.2024.02.14.03.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 03:57:37 -0800 (PST)
Message-ID: <d1d95a3a-8164-44c3-9156-5233d3e787ba@linaro.org>
Date: Wed, 14 Feb 2024 12:57:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] dt-bindings: PCI: qcom: Allow 'required-opps'
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240212165043.26961-1-johan+linaro@kernel.org>
 <20240212165043.26961-2-johan+linaro@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240212165043.26961-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 17:50, Johan Hovold wrote:
> Some Qualcomm SoCs require a minimum performance level for the power
> domain so add 'required-opps' to the binding.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


