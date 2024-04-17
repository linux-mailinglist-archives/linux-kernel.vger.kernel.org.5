Return-Path: <linux-kernel+bounces-149161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7D98A8CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA101F20F13
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2533B18D;
	Wed, 17 Apr 2024 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZqCjp6U"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A00F38F87
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384352; cv=none; b=LpXRtGk3Bn0Ut4WsktcaxsIGVyoHImP1fQt5OLa8OMMA2y3kjRFT1fL7llwzIX+kqry3U/BtonzJmyPN7zeKmfogD/gaRpp605Y/I7gRD764xrY736DECEahdg4bOJCrnypMVlyMyBYOUALnb4jSRVy4yXc46bg39k/Tm592vEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384352; c=relaxed/simple;
	bh=pvHWzYmLrZ0P7p+FLaEBRE7mBd86FkiwsjLuwJoqArw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5s5z1TjhxUtt8I4f/dqgHDa20D13kb8Ii68bUML8WCnDvNQTxi2Epl9SAbrEjb0xPxhMlDWsgycsKEzaBSgq+Qg/+W9lVYy8txsHNZMpgYqTnhxmVKhhNbSNyccocOSI5uKImmcdwpixRMKtVyqd+zvSr3DVuHd5dy8ftGMBNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JZqCjp6U; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a51a7d4466bso1961066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713384349; x=1713989149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TJECuK0zvvSSv8Y2M38p/7A46rXzNqxLhYzmOryfH9M=;
        b=JZqCjp6U46ZZY3bbMLGocf9Y1TJ6AcVywQym4Z1sUHyBxRL0cVDsDpRzYQKU5VfnN0
         0bl53xS1ZW9a1xENZ2dDqSOIMPJaYi1wKpmqGnHvAQ2d4aYFzKdOtAdc85T6CET6scX+
         +7qANQEDzFdJNFtVrnWr1YyAf6M5hCbHdFjK55wxjeol2GCaQiZkRV7Mc57Bkj5o1lbB
         imi2nL7chwyTkO9+wdgLztUtJu5e1i+trx27dY6tGUdnonu0mXu3FNR2iuddgRw0N3xS
         pmoGPvY0VZfB5vYrs/2u13viPuJwI8E0fpCtnNoW+t2qGXE4HWGyFCcRd+dBbDponon0
         jUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713384349; x=1713989149;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJECuK0zvvSSv8Y2M38p/7A46rXzNqxLhYzmOryfH9M=;
        b=DlWwxjYcs1GqNYWA/LPnnZrsCoEj3tdVzmhI3SmLJqwH4V4E79rPN6AZ5BlBt4JGob
         oZP/pb4aosjCXSHUoI37E3++Sd7PbHieGd2QRc+SYbVY56GHpR2dL49OHPDTOnsMQJdL
         3UN/xZtH1GTYIV6W59WHvtqfc4/H5bqx4o+iuwgTaWxnk/OCXWQTga4gvAy9nYZ+FHaZ
         3HAFM1tZkyWtyRQNKJ/Bob3AYZRud6ICqhrMNeqM7FgxUYYFa9+NFHszgsXTE20e4SMy
         g0LF3Y3KhZ4kRVKmdamaIVtypeErwg/pG6i4UulYPk5XNUufjcWVtPMaz4x3gB1s58lJ
         9bKA==
X-Forwarded-Encrypted: i=1; AJvYcCUx1U8A+iKCY8HqU71GB0DfCVsIzXtz+k0uawKSSIbBGCaaBvy7+1O4Zl6pHmZyb+onm9IVj1ljjUjbHx+BFCfqlqnxrQ7JrG4rI7Bl
X-Gm-Message-State: AOJu0YzGLxxUJGIi1L6KMDdkUalqX9x4vn6uAIOCDU5X2b6hIJH10+zp
	4p4qaBT+kVoZDcrcr3en/WRz06n9CR0LmoHsCgRzdkwMUjrn1Yq96LmiTqkP/dQ=
X-Google-Smtp-Source: AGHT+IENjcBRUXm0ig4yY51WEWDHOhZiZWrdF4ysyCTKe06RRQiaHJedqVCuf/olgVOaxajtP2wzpA==
X-Received: by 2002:a17:906:6885:b0:a55:690d:de15 with SMTP id n5-20020a170906688500b00a55690dde15mr330643ejr.61.1713384349408;
        Wed, 17 Apr 2024 13:05:49 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id si29-20020a170906cedd00b00a4e5866448bsm8475444ejb.155.2024.04.17.13.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 13:05:48 -0700 (PDT)
Message-ID: <693e631d-08e9-4ba4-8752-83246697b39c@linaro.org>
Date: Wed, 17 Apr 2024 22:05:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Switch to devm_clk_bulk_get_all() API to get
 the clocks from Devicetree
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240417-pci-qcom-clk-bulk-v1-1-52ca19b3d6b2@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240417-pci-qcom-clk-bulk-v1-1-52ca19b3d6b2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.04.2024 9:02 AM, Manivannan Sadhasivam wrote:
> There is no need for the device drivers to validate the clocks defined in
> Devicetree. The validation should be performed by the DT schema and the
> drivers should just get all the clocks from DT. Right now the driver
> hardcodes the clock info and validates them against DT which is redundant.
> 
> So use devm_clk_bulk_get_all() that just gets all the clocks defined in DT
> and get rid of all static clocks info from the driver. This simplifies the
> driver.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Even better, you can push the bulk_get_all to a common function so as not
to duplicate it for every gen!

Konrad

