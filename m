Return-Path: <linux-kernel+bounces-69038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2DE8583A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEEA281E45
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA76E133425;
	Fri, 16 Feb 2024 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehv+7/5f"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E75D130E34;
	Fri, 16 Feb 2024 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103467; cv=none; b=cMGnmOD+7dSN+lX6cxWYH1o9/0kUprK4Dz5SMtR517hmfWnSFY7Adsm5Sa9Fp6xq4tzaI1JfjTn9PGrgBUNIazV7oEKJvTtwPXD8ZettHtoCoHu7LjBXgplXmxGas2xS7GZ3adrNZdpQ3yMoMdOT9fXG5FA3gUIYfdkroMb/cWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103467; c=relaxed/simple;
	bh=khoiFjUd4dcTUW8wesggwnEKbiZ4BO5mCPFbLHCUyGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDvro2Q4Zpjk6Gs3fsO/VD7J1wHh2o1NghHjkWfMFBA9j8HKgQ1H0StnKeiFlkEvP9+z5zGX0ddwL0ywvuvx2yeQFcTYRSm0QGrbTvP2yPu3cTKLC1AX+DddxIMEUFfQEwBLGHIqdtMgOEUfjfxjbLaPVqEueQf1lpTEr8CUN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehv+7/5f; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6da9c834646so2085725b3a.3;
        Fri, 16 Feb 2024 09:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708103465; x=1708708265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kbU5Q7mwroDZ8CIL6V8jiBVhQYcx+nOogs7IaVh1Fqk=;
        b=ehv+7/5f+8GnzROcLthPy92fL8MbBbRCo/QTEm+QbVKjv9Ek0N+twaeStL+GDfz1Fs
         yzhK8uYnM+Qnhu+3beSXFoWLEvARUjeDUtbdPhMBqUuIONR2RvXLII9Ur6ufisAsNr2Q
         o02dXS/A8pnEqevOmM7raKKoh0OfNKY/TCyfdYVfObgAW5wHfsqbjcfs4LfpshOberSK
         a58En/8wfKv4Vp7fAUIeG4hj9Y3YRWqS+7P+Msx7LNWmm4ZhfUfaT0xeEEQI7eLs9DvS
         aD/BBNZ607IGEaA3d3Jg3e390MKy4HRHStiep/VYC786KfFvn5G9gTI73dN/ioDkVTaW
         XmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708103465; x=1708708265;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbU5Q7mwroDZ8CIL6V8jiBVhQYcx+nOogs7IaVh1Fqk=;
        b=f2boUyEsgepNZubNCP+Os97fThiuk5SWd22pcaJJvilnq9z0Fvw5NHV7Xs6pM7ZkQn
         7fvVuRXHMsz6a+hNtJeDQDuVpmOwFOC9iV8bBDEwxFEzxnguAvDeOazpOEKhYXWqwxYB
         zx4JSBYAbV3LncaSedPCJCbVcCXuTLvf0N5ywXROrBGlFNVKa9DJPLfUZieyIALpTolA
         afFczMX7FV6xQQGhyNIlM98pH5nzMuFiWz3tYXzhzm72Wo4fd/DXgVPMvaBScQtl5TfJ
         eEiWbUOIopbJj1ObifiHNlu/Y0DA+Zc8q1NvkxWdQhkZ4j40Ui0c+0fSbebmMlU8jrui
         RIXA==
X-Forwarded-Encrypted: i=1; AJvYcCXEMnxK56GEEwLkHQD5voBOxbQ66spoREr2NK0svEllxoBykfDqIhsOSHywnEYGLqcUswMhAeO/3K1EtfbH7jbygeYeZGWtaBEaYZNovb2uuQxWS/PF2n+KMQIbyqckISws+HYFOwga5Q==
X-Gm-Message-State: AOJu0Yzuo28PQwGQBpjMzv7vC4s3fI/OQkCrHJZ0zByNsCXtTu+hFo+9
	TiDMDi6wgV5jQg2PFad0Oq6t0but5/U0sJykce9tDuhdo9yiCm9I+k8yFfDG
X-Google-Smtp-Source: AGHT+IGpXPRsKXf8RvFRnaco7jjWeE++VILS9Oa+BWJuT+sagdYYoqYmeixBQxZlTq/7+f6ydqGlKQ==
X-Received: by 2002:a05:6a21:3409:b0:19e:4ed7:127a with SMTP id yn9-20020a056a21340900b0019e4ed7127amr5997160pzb.46.1708103464655;
        Fri, 16 Feb 2024 09:11:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h6-20020a63c006000000b0059b2316be86sm147382pgg.46.2024.02.16.09.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 09:11:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f0f523c3-7b1c-404a-89c3-0c7345001676@roeck-us.net>
Date: Fri, 16 Feb 2024 09:11:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: add common properties with label
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20240216-dt-bindings-hwmon-common-v1-0-3c2c24ff1260@linaro.org>
 <20240216-dt-bindings-hwmon-common-v1-1-3c2c24ff1260@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240216-dt-bindings-hwmon-common-v1-1-3c2c24ff1260@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 23:55, Krzysztof Kozlowski wrote:
> Linux hwmon core code parses "label" property for each device, so add a
> common schema for that.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

 From hwmon perspective:

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   .../devicetree/bindings/hwmon/hwmon-common.yaml          | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/hwmon-common.yaml b/Documentation/devicetree/bindings/hwmon/hwmon-common.yaml
> new file mode 100644
> index 000000000000..d83f4180f622
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/hwmon-common.yaml
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/hwmon-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hardware Monitoring Devices Common Properties
> +
> +maintainers:
> +  - Guenter Roeck <linux@roeck-us.net>
> +
> +properties:
> +  label:
> +    description: A descriptive name for this device.
> +

Would it make sense to also add shunt-resistor-micro-ohms ?

Thanks,
Guenter


