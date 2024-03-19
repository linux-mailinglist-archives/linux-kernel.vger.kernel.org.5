Return-Path: <linux-kernel+bounces-107711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4F6880090
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07D91C2203E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446DA651BE;
	Tue, 19 Mar 2024 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sc7ahwSe"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1224B33
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862098; cv=none; b=HG/JZcImqYj3lxbf16pwg8ndoo9gc6WAYd5mWIXWiMsvBnNpjzSHiRfIytx1g9tRdPEIh9/+JQdN9sgMPXIBelJ/5R9LV/jvv9AMNt5uWSZWJVWbuvPxUfZPwV13jfIsq8twtxP2ZjudwRQV1kn6wbj7nhWllNTv+xp7O4VuBaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862098; c=relaxed/simple;
	bh=Iebj8IQWBTDSyQOcN8l27jVQbNugY8Umi0XfChxI060=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjUEkATAvyjhovO7vYi4mJTgsHER+R21vXNXH/w5MMNzCs//ftOlIKyNibCQtQexTAF7ZPEIFjEHQgKLp9MZWAZ5Idvut+FFaWw69nPQBE0sR6I09AStdMvDmBE3/ekdywUYOr/TpYWjmJtGsiz3U3xOO1pvVwTWXmXPQY74+OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sc7ahwSe; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so7154514a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710862094; x=1711466894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Uw3yViolL256D4KpZ/VNe3q1jCT/oeAJQE+OzIT+f9c=;
        b=sc7ahwSeFLVgvg3AWckEjSPyMlZT2xaSCGY3/VkuI9x3wxJALClLvDidKytFJb1CXY
         1xaEZ49DMri2opJ3G8ikTdbcRg8glAyjPzEbzCXCxwUU32H8QZunY25S5ix1XDCBCiM5
         niR0GYxMFsD+nG5ElELjxCIVdKlFXlfx0TVCYKGxm4SEH87A2cfv+MvocK2rjtIdTWb/
         RzPAEWn15w+8uZVavNGmVmmGwnk6w9WeAwMvXAYKXP89pdyTuLtv5vmYzDIgLIdGL3Od
         6FZ1qw2jxgIBFYe6OOKecJZDsIhPWh7ElqSQD25aSg8vh3SP5s5MvtD9380HpsC1S2EV
         tuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710862094; x=1711466894;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uw3yViolL256D4KpZ/VNe3q1jCT/oeAJQE+OzIT+f9c=;
        b=YGOgabwB00ctGAOxzwbKYdfS5pAES1QYlAZhMZC1jDAvesfj/yDFGa29RfxAb/eDwL
         tFsImc+o5GoOIKTlugoZ44j1ANpnqOMOtVPj6tbPidH4EcCduK1th9CCpyma8dBttPkE
         5jRylbv++EolnhvdAKbOzUVW3sTikVM+sRGOCqcFrQ00FPbF178oyQz/QeAgocdqDgFY
         udtlwNy85Ic8WihCbRJI4l8ZNGuqSASthDEBCK3uK/DZ5oBoCPMyhS89Jzqmz73ZJ2XT
         mbQTiuYaMfmtGVBM6qTsOiqi4nXwpYkUCOqS80KcJ2liHe3yJaYjgbTjs+QLSj4fzt8T
         4ZZA==
X-Forwarded-Encrypted: i=1; AJvYcCUcOUnh5nbgW0Aoe7UX6Lb4JwAWodWMb23kwm+Y8EjiMUi8GPMWPj1vPXlyyjirpGKBICqumCDkOtPkHVTuBZjJAuaLyJUaX150/vy4
X-Gm-Message-State: AOJu0Yy3lQAaKC9QEOEwyK1Oz2K0lhDQpeU1lG1usMogqMpw8wfqgapl
	ToS40G0qhN1zRxWioF42iVGtEaVViqlBRVinPEScQM2fucvJwIVIWvr/Ns36nr8=
X-Google-Smtp-Source: AGHT+IF7Mn55tuJjB5sm1mYK+MpMA1+6VQ2Ca0a6t3Dpj8QQx0mBwM7GMKkkizUXQTiG6BR8sjxbqw==
X-Received: by 2002:a17:906:c14e:b0:a46:a786:8c8c with SMTP id dp14-20020a170906c14e00b00a46a7868c8cmr5971856ejc.77.1710862094598;
        Tue, 19 Mar 2024 08:28:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906845900b00a4652efd795sm6232497ejy.83.2024.03.19.08.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 08:28:14 -0700 (PDT)
Message-ID: <ba8418ab-2829-416c-8e20-414f7818cab9@linaro.org>
Date: Tue, 19 Mar 2024 16:28:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] dt-bindings: Add bindings for vmgenid
To: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, thomas.lendacky@amd.com,
 dan.j.williams@intel.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: graf@amazon.de, dwmw@amazon.co.uk, bchalios@amazon.es,
 xmarcalx@amazon.co.uk
References: <20240319143253.22317-1-sudanl@amazon.com>
 <20240319143253.22317-4-sudanl@amazon.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240319143253.22317-4-sudanl@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 15:32, Sudan Landge wrote:
> Virtual Machine Generation ID driver was introduced in commit af6b54e2b5ba
> ("virt: vmgenid: notify RNG of VM fork and supply generation ID"), as an
> ACPI only device.

That's not a valid rationale. Second today... we do not add things to
bindings just because someone added some crazy or not crazy idea to Linux.

Bindings represent the hardware.

Please come with real rationale. Even if this is accepted, above reason
is just wrong and will be used as an excuse to promote more crap into
bindings.


A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

> 
> Add a devicetree binding support for vmgenid so that hypervisors
> can support vmgenid without the need to support ACPI.

Devicetree is not for virtual platforms. Virtual platform can define
whatever interface they want (virtio, ACPI, "VTree" (just invented now)).

> 
> Signed-off-by: Sudan Landge <sudanl@amazon.com>
> ---
>  .../devicetree/bindings/vmgenid/vmgenid.yaml  | 57 +++++++++++++++++++

No, you do not get your own hardware subsystem. Use existing ones.

>  MAINTAINERS                                   |  1 +
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/vmgenid/vmgenid.yaml
> 
> diff --git a/Documentation/devicetree/bindings/vmgenid/vmgenid.yaml b/Documentation/devicetree/bindings/vmgenid/vmgenid.yaml
> new file mode 100644
> index 000000000000..17773aa96f8b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/vmgenid/vmgenid.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/vmgenid/vmgenid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Virtual Machine Generation Counter ID device.

Titles are not sentences. Drop full stop.

> +
> +maintainers:
> +  - Jason A. Donenfeld <Jason@zx2c4.com>
> +
> +description: |+

Drop |+

> +  Firmwares or hypervisors can use this devicetree to describe
> +  interrupts and the shared resources to inject a Virtual Machine Generation
> +  counter.
> +
> +properties:
> +  compatible:
> +    const: linux,vmgenctr
> +
> +  "#interrupt-cells":
> +    const: 3
> +    description: |
> +      The 1st cell is the interrupt type.
> +      The 2nd cell contains the interrupt number for the interrupt type.
> +      The 3rd cell is for trigger type and level flags.
> +
> +  interrupt-controller: true
> +
> +  reg:
> +    description: |
> +      specifies the base physical address and
> +      size of the regions in memory which holds the VMGenID counter.
> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      interrupt used to notify that a new VMGenID counter is available.
> +      The interrupt should be Edge triggered.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    vmgenid@80000000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

No generic name? Kind of, because *it is not a real thing*.



Best regards,
Krzysztof


