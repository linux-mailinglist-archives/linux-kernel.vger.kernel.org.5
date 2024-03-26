Return-Path: <linux-kernel+bounces-118441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7180E88BAE5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F338D1F3A8EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C4A130491;
	Tue, 26 Mar 2024 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjurYNGD"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E35513048D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711436483; cv=none; b=d7zr6bp8TizOdXO35Poiul+iDvMsMlFeQhSocaBmBZ306RhLSxxF0ijCA5fcLS+RU76iTnjut2879wp2iUFQiEvI6nXFXWbkHt47NacI0s+bVZCxLVRUwC8ytNh+AP2Ju/lus5DtIe8AuJ+XqGdymVRzbkLgJW5j3pMj4M4HipQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711436483; c=relaxed/simple;
	bh=ce4FUdchGbnfK/QZMB8J4T4OqOvkDq4PURMtxHWTs9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ar/J1XB01qLUtwlPyfwPEKZwcaMuZSgznllqI9fJtUhNnslGEPFjY5r8Jn9fCrxkadZlC+OJ8IVZ8/Kxi/KvwRnDIIY36kubKIlDH7dRbE/EDMNmrHQBE0f5ya0ReYn97VzEy2TEimodBJz3WzIJCBmy238dxayU8m/g7HxRGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SjurYNGD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c0d1bddc1so2215483a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711436481; x=1712041281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nG4I7sL9td2jNIUZM1b4vCjHaKrhTkrvxk5qoWU/Idg=;
        b=SjurYNGDYxhRgkYd3VOaZ5cDgrzLJGv5ERCJ2L0JeZ5wD8Lr0dFuMKXSnoxBuIhSXC
         G3Q6F/nfcaX0rnIIv9fGjUcfjQhi0ZcXPGMwtOUJe3WWmKxoG3ldlFd0Rb9hUhri9kGE
         DaDxBGs6gpunGYqEGRoVH8pQOrJoG0AlAnLJ+9wIj+0L8X4iX5MCjHlhyl1paO2MOitv
         C0T5eGYPKcyKum9FB33v2MPv0spaVj6RT4ntyfzzflpOPvW9GwfeZYmJcIFxS0pmvHTK
         OK1IW9neuehwX9613RTC1ffC+PnF7UZZrkiCYxZTfcqdr4hTDplwVp1XWOuf7NvBmV9U
         FaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711436481; x=1712041281;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG4I7sL9td2jNIUZM1b4vCjHaKrhTkrvxk5qoWU/Idg=;
        b=NaiU0Tu4RnRiy3Nci6GIDCYs7uPz9Xc+9vj+XsjxO0XXSqukCq5JhFNpgJ8gcsN8Fn
         CXLUDkPsKJ1HmnAtXzMZEn7tXoMLXfw5EIpUgby3mp2FBHkd2O25aaRELKAlXbrH+jAL
         Op7f4LE0kyhEoLSw5Z2++klI3chcsgWcu+Hlb6mW2o28kz1ptIZP4gswCdawIsv3LaI5
         XdnVzCU/ZdEtPJGHmy7wIoJgymVcSa/NbLAzBtMS+gNCOkW0Z1x7I8+xV+PoWVV3eBMG
         JKa/zmxAKqgr+ZWFbRV6GtiUlMySldhfDePs0HxoCWGquN7LN+qNZioEaW8lS5jbVqdI
         426A==
X-Forwarded-Encrypted: i=1; AJvYcCUlKAtjgwN8OgQOalcoYJbkJ9+S3aZBaPBNYJVbwXoEuw490+BrhMwF2etMZUVRgfoV8go3V7vPFqVSjVDeqWHztNlNEiGAfVx2bC6I
X-Gm-Message-State: AOJu0YxAi5xtCuQVJiUuyEZM2dNHyRhHFoBQmDn4nwrj8R6vXXBrqqoa
	A81mXvnJ+GnR3eKH5hAcijHb8uaUzmdUXSsSHTSxfmswvu2W9FLEv+6nwYNUH2EicXBC+pFo+9h
	A
X-Google-Smtp-Source: AGHT+IE8RknrDfvhgcqWWt7MA90Qn+duT7+xgjDCbqjb+VLfqRE9jLgDi5k239bfumDcSYXqrK0QhQ==
X-Received: by 2002:a17:906:af06:b0:a44:b9e0:8592 with SMTP id lx6-20020a170906af0600b00a44b9e08592mr6922236ejb.8.1711436480613;
        Tue, 26 Mar 2024 00:01:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id q8-20020a170906388800b00a4729f093ecsm3860919ejd.53.2024.03.26.00.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 00:01:20 -0700 (PDT)
Message-ID: <ec122998-8dfb-4790-8b12-a80b8e7a639c@linaro.org>
Date: Tue, 26 Mar 2024 08:01:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc2: Add support for Sophgo
 CV18XX/SG200X series SoC
To: Inochi Amaoto <inochiama@outlook.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Minas Harutyunyan <hminas@synopsys.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Chen Wang <unicorn_wang@outlook.com>, Liu Gui <kenneth.liu@sophgo.com>,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <IA1PR20MB49537ED844CEBF19880326CEBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49530A43A81CF4B809DBC2F8BB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <IA1PR20MB49530A43A81CF4B809DBC2F8BB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 03:37, Inochi Amaoto wrote:
> Add compatible string for the DWC2 IP which is used by
> Sophgo CV18XX/SG2000 series SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


