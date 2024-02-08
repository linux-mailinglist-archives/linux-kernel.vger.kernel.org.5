Return-Path: <linux-kernel+bounces-57597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E3D84DB32
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1FC1F23D17
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2426A03B;
	Thu,  8 Feb 2024 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wd6mx8/u"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226476A329
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380248; cv=none; b=Dfk0Cs+VbE2McPB6xYawtMLGvaJfbdUu4ETzDribS35+gj4hJF44ZzYXM29//zJa/fWcAGSMoaIwPCARlD6L4SbFsmQ6c8aP7vdAZaOeWl+RgXPq2k7ePXHwCpSHP9uorPv+FRQVDPZYxBJUgM3nPTV9ccnepr95Up3jxOAHSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380248; c=relaxed/simple;
	bh=cFhVyO9mZBb4K/oJNzkv3ovfeFXv6ANZP5fBnOocIQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bRxFhaEm8f4NwC8qyPEBAAs+Prpu2euO1Zya5Ut5Pa+uekb9PGqg3AlVHi4K7ebbW46ex0RCASSjmFCjaL5Np6L7kh5dCKVU5TM7yNvf8kcpqo28ljrsGVhmO/DJMVxV6yQjCRruvKVw3RSsn6hYju/YH/b12pNwjGfD0BaBZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wd6mx8/u; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33aeb088324so1069014f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 00:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707380245; x=1707985045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IU/WIemk68VsWlu2CYm5KV56Ntg2w5tMs4G/OWutYU=;
        b=wd6mx8/uUC3HRPMeiYTpgJmVBkN3T9ZblV79pFgprILlRx/vRPcD639GcFMyYo/g0J
         wox6a9kYK5cvZmdL/MMI2oZvS3VtMdrf54GphOfvfKnSXHZEI51Pepy2sUkmj1OGfvHi
         hPiY6Gb1dcUC0K5qFdEWTTP3NmWNVMs74rIBJjZNZOWYJVhy43rePCss9jsP2IMQKpmo
         nQHiBNOK1jcsbOAQ01+wwLES1eVihYVMGC24ySZPQHe+6g6zo3Is91MGezpiNwKskT3X
         C0OTxZPZZ2bYdBphlE9h9YUMjKfnJOJwc/3OFu3EKTAfaJ4zRAYAdzGzwhMbzeBw1w86
         AHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707380245; x=1707985045;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IU/WIemk68VsWlu2CYm5KV56Ntg2w5tMs4G/OWutYU=;
        b=e20P5UZcsG4eJIKyftZXfXU/rLnWbtTb5443eDGQEsvDtF8yEwIGOf/vhJYjR/ATxG
         T7GTksIEWx6ERv+u6UmCP/xlvvltnDo/HIPPnobaOEHgfFOgoNtw0Rx69yfsrYvIRv6R
         bcNNF2fpIi7G/lmo2aTKqaF+jW/2A2QZNWnVg30TuIBPvKennwYCZ90XMxdPhNjsbDdU
         +uco3XygJVYftsv619q5fYaQvCx6XXuQoSDRTGngjc5rtOQBagf9ueeNGVQ/IOC4lYc2
         fdNZnz+/A0BuSa9XjtvvSuBEIwyVhzQ7wl3N3V1OwFaAXFw5h3tnQhfuuMD43Au4DFPZ
         Q2sw==
X-Forwarded-Encrypted: i=1; AJvYcCUFmsrRrU/s3B+WuLY4IpfYBUQwRZnswjZWLTcxokArG+400mAOueJ2iE20sTgiRJZZExDy267KpBQe0Cr/qBbk2w3rOQ0OgLeSoF1X
X-Gm-Message-State: AOJu0YyhiSHLZIW1FwNLGJVj6iVO2wYCIuxpjNL62rtXoOqlHGMHgIxo
	69e8+lRxa53kEu9LNtAqyQEbIFTr6r9lf5wcdpwgD9HYpPcIIw+VsTDh7ENaTVc=
X-Google-Smtp-Source: AGHT+IFeImHD4GuDOV7WqhwUVfZiBY0DZ/budKpAJx1zCNqYrvQLL4URWUwX/ve9jGJzNPq2PfFTTQ==
X-Received: by 2002:adf:f08d:0:b0:33b:464c:b118 with SMTP id n13-20020adff08d000000b0033b464cb118mr5737547wro.26.1707380245293;
        Thu, 08 Feb 2024 00:17:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWG27wGktnvvv/vcScIQhkvRFHsOjG/jG49iIwjK5pxT/d+Dn/v1ylz/jcYyxgk+JHBWMSuMy9PdAtAB4f7cIBdSy4Ra/cA/hJMjx9Gmlp/SHpNJ6rXmDt5bC+CFcETrAheI4enPSlr5XWOCKllmGN6sml4lLeA28fYASm9/leNX/Bhq+k3l35psxVSGk1J3ehuGkiaXI4G1aT0dWKZkuLceUQv4ReuWZgT3PpB1LsJsH+7fPTrn7Vwgcg27Z1mgkbLWbmJrkdGE0UcGsNDfdgYsexq5yRg3SWakzNH/RHMKItSsZhhYXHbTB2Uus1Xddvk7NSj3O8BNLEMmHojjuzaZ+ltLNltWGjgagawb7B4tYHeIJnG0enQp203PsHtGhi249kzFsHDw6H4UBplsfsVHG9XW5B9NgUqu+6U3AAgOwZFt0VnG1Lhn5c/3ZnKbdy4n2R6PjInYFmmIflX+PZlWjYBCsNhj4iD5M29msXQ94/zdWn1JDJkP6SIdjhuIQzt5S+LMOxnaqpo/Jd50+TDrtBdHg==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id r20-20020adfb1d4000000b00337d6f0013esm3099374wra.107.2024.02.08.00.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 00:17:24 -0800 (PST)
Message-ID: <dbfde067-50b8-4f86-a098-0fc160114854@linaro.org>
Date: Thu, 8 Feb 2024 09:17:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] dt-bindings: iio: light: adps9300: Add property
 vdd-supply
Content-Language: en-US
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
 <20240206130017.7839-3-subhajit.ghosh@tweaklogic.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240206130017.7839-3-subhajit.ghosh@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 14:00, Subhajit Ghosh wrote:
> Add vdd-supply property which is valid and useful for all the
> devices in this schema.

Why is it useful? How is it useful? DT describes the hardware, not
because something is "useful".

> 
> this patch depends on patch:
> "dt-bindings: iio: light: Merge APDS9300 and APDS9960 schemas"

This is unrelated and does not make any sense in commit msg. Drop.


Best regards,
Krzysztof


