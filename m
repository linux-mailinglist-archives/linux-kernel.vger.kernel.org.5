Return-Path: <linux-kernel+bounces-45058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7E7842B39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B9528B23D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1AB14E2E4;
	Tue, 30 Jan 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LDqrw3MG"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B36014E2D0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637056; cv=none; b=ozKJXEVIzSl+PTL/2Smc78TRZW2hpmBeCJcAaWuon/vPs7KWfqWiFhbk4QdH2MWoTk8t+Tg6NrLotH6vdO+u7KFRTHoi5bBwOJcdjPk6aXtnaz3Whb4ADW3mb0TrOhLDa5mAC3FblMbXNlVAevtHmTSt9Zan2/r9kWE3vT6HV+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637056; c=relaxed/simple;
	bh=uNnbLSEG7vRgFLDN8cuC/CnL+LFVE2mM+aBI0U2VLLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lxeY1pn06DB/6UrRe8LaprZtLIVCSZNfUfTy4XxdBaw90qgPX4q5AyRsIDcE8NXEsG1l6Jn/X3+N1kf1cPX3NUD6hreVSiDxkzOrFyrJMCoxGXG1Yfl3l2piiFIUXUWX0KcIk2MHdh8HH05ktztR7VZP7RnwSxpH+x4Na/O+B5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LDqrw3MG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso4909576a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706637053; x=1707241853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Sy5WNKTeRWZemdsrhPsxPXofNmoa6xDLcHSRd/vzX0=;
        b=LDqrw3MGiQX6rvAbzbdLI5W9KIH9UkFxAPlR0ppX++Q8KGliRNqaQ9h1B2lxk7c+fS
         c//pm6rlUWCII2G28STCijjcmCYIlc2ih3XqGaPuVreXnrkaIX/S8AOTIp92JFoyvmr1
         MDeXq3PK3LtNGbX9LWQUaKn6G2af0dnQkuG2A3lw7Dd+ZRfAEmHLr4vMBCKJZuqqTHH8
         oNyecF9IZf8nA0Vz+m0bE3XB0lMP+2nbxOqJJlbxvwSBH3gFBEx/2XJfzjFEnY8rLrtG
         BCNzm+uycy7xfpPF0S79oy0VrqwT/6G1agcSNLIOtZ6WCftjhsk0GnGh1iFVvbwKV5Ws
         pGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706637053; x=1707241853;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Sy5WNKTeRWZemdsrhPsxPXofNmoa6xDLcHSRd/vzX0=;
        b=qdsMDmZA9gdm0EBmPBua1Lb69GXdPxziILtTSXYNcUtJO16tWrcipewjFeqMQjJJty
         jFtnjEPUcZnKs03FA4CrLyDnZcxbBZpfJgK0gj50UCH6ikXyRlcpbwuNaxFheG0TEx/9
         6SoovmPmU4p5bq+4+oFNzxyLbHky+pBvKibdWkECoGvpVcSvlgvDvrsh9RZe3OSJLeVV
         ewsnpvdhAMGIPg4wl1QAsBmFHmEL+1aES6q5OcJRejezmWxZyXExMxoIfy/P8KzCFQ0A
         9RaxHuW+2OmgGorqc3Xw6sdZwOFZr8Z173Qa5uKuiZ6ArANAD1e9iY4oHvfKuasenpog
         7gnw==
X-Gm-Message-State: AOJu0YzKJYuHilam4G3BHVt24RGhvtFP2f8y45mTAyHogjpbNpT/5WMh
	0FiVqDlNBUsrGCs6Z42PCSE0n+BQx8W43oyp2L815xWoe1sk3TNgm8t4JI9+0mM=
X-Google-Smtp-Source: AGHT+IGzjAV9IJpHgnUutA4hIlhf9FYgMXipOYI1qQIMEowEfKJTSIKQFKqtdlD6AClFpB38subB1Q==
X-Received: by 2002:a17:906:4708:b0:a35:de06:23fa with SMTP id y8-20020a170906470800b00a35de0623famr4063237ejq.6.1706637052778;
        Tue, 30 Jan 2024 09:50:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWUVwqvTzg3EDQikKK01v+ae1jrTYs3oPyl4Le9Mx8c6egxjLbk2qpYKnMva4AUrxwFUTX8QsvFTylA+9vXIsaDqmBCXTHZFdOpGHtDsEigFMqyjPwBnhkBSReYhc27B5LGiujXK3/pgvY4kIGihgFUzSDKtlAk6CRDRmV1b8TwbXQgH/RitfSXKYFstjI7uj0U01dz8DaetkWbqOLYVeCx19YUtUDNLMxOD31t+HU9q+74Ar72Vj6TakZBgFD+hyE11HcnqqaG3inJVo68rJyQJIdwM5Ik+6L/HQYBzv42G6QYWdoNAsWrSAbUdg0QMg6Mg/+sfXG+ejZLjKzLPd5RnLGYclUGQKUAZV1TVcwGdaY2hnrgoPsGJ6cVsTaN5WNTE5SLLQUZE03I6tR61Pjfee49s4vgLzDe0rkBJdwj5VgToRHriA==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id d24-20020a1709064c5800b00a35ffa25d3dsm1380755ejw.29.2024.01.30.09.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 09:50:52 -0800 (PST)
Message-ID: <b6c8ea0f-8cfd-41a1-9146-cd9742837714@linaro.org>
Date: Tue, 30 Jan 2024 18:50:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml
Content-Language: en-US
To: Dragan Cvetic <dragan.cvetic@amd.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>,
 Jonathan Corbet <corbet@lwn.net>, Michal Simek <michal.simek@amd.com>,
 "Erim, Salih" <salih.erim@amd.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <20240130161259.4118510-1-dragan.cvetic@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240130161259.4118510-1-dragan.cvetic@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 17:12, Dragan Cvetic wrote:
> Convert AMD (Xilinx) sd-fec bindings to yaml format, so it can validate
> dt-entries as well as any future additions to yaml.
> Change in clocks is due to IP is itself configurable and
> only the first two clocks are in all combinations. The last
> 6 clocks can be present in some of them. It means order is
> not really fixed and any combination is possible.
> Interrupt may or may not be present.
> The documentation for sd-fec bindings is now YAML, so update the
> MAINTAINERS file.
> Update the link to the new yaml file in xilinx_sdfec.rst.
> 
> Signed-off-by: Dragan Cvetic <dragan.cvetic@amd.com>

You need to fix your way of sending patches.

b4 diff '<20240130161259.4118510-1-dragan.cvetic@amd.com>'
Grabbing thread from
lore.kernel.org/all/20240130161259.4118510-1-dragan.cvetic@amd.com/t.mbox.gz
Checking for older revisions
Grabbing search results from lore.kernel.org
---
Analyzing 12 messages in the thread
ERROR: Could not auto-find previous revision
       Run "b4 am -T" manually, then "b4 diff -m mbx1 mbx2"

And it is the same for other versions.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you know the process, you can skip it (please do
not feel offended by me posting it here - no bad intentions intended).
If you do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

Best regards,
Krzysztof


