Return-Path: <linux-kernel+bounces-59598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812D384F989
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38849285DDD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56FC7AE5A;
	Fri,  9 Feb 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhn8bnjZ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C71F4D112;
	Fri,  9 Feb 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707495798; cv=none; b=CRJlne/virMPDDUUSlyMP5x2iPs57bys6mrTSw+k8xiVoTT4c03USLCzruKfV+EfrdwURzJNx3S5JKza5wfaTfHvQR3OVg+N/rb27Nc+0JyI5DhhRiKee8q3Idjr5/XlcNtc/VzIUYRvXXOtEh0j7fXVruwtAAg7uLxEi+WCjGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707495798; c=relaxed/simple;
	bh=2TBg5zcGBE79jg8DKHE3zKwjr56ZuY78r47c4MYTacU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxeFDJgN7pV+5s5hKEkSyiBD9k5kvw8oULsR22yBZ9MfZf+NNFpbXEhhPEOgBrfNJVC2bRr0hoHqRWxGgkyvNxoDFG6FHGQz5yYep41AJlgPLUr8dK3P0Jehn9BULao2AvsrusoqqIi7WlnchGNkpFjLEFojGNaRqo8TY4ye3UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhn8bnjZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e04fd5e05aso802609b3a.0;
        Fri, 09 Feb 2024 08:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707495796; x=1708100596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QQQBKLjQyRTCG35dC9zHxKeiiPTtpNzAEQO/pnUue8E=;
        b=jhn8bnjZVZ5tYFTjzMpgve2CJ9D6TfsxrhUq0p6EwUY0+5x7aarx1b8YOHWkQ33Sm2
         iSPvrSlaFnhehsADzonYFFa+vJvhjeh+zjbkj2FKABFDYEc7Pnny4pWd9HBhCTVlDj4F
         2lC74RPqQhcEhICq/ScSSD0CAA+guWfhbi6lTfp2O46TbDGlT52OvILIPJ1QrRdp3i/k
         E5OeMRY6ifft9Zeq6+ABjebfGhFnm81w51wAOxNKlveUmCoY6kGqjGj5P6TUlxmK2Gqo
         O3RHGW6DL8uwmaSkzb7r91PV66INdgeFRyLh4q5jT89NIlTKSLCsLB5G7fTGWyTx34F2
         mgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707495796; x=1708100596;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQQBKLjQyRTCG35dC9zHxKeiiPTtpNzAEQO/pnUue8E=;
        b=esI3rxCG0rqXYAsw8sJwF21sWIYCpmwpeF2QBY5HuFOHCi7eKe4DSlur01LwtHGt8N
         BIotSE2UCdRFZ7GgtINQxGQlrNG+YJ54oqTcjZ08ANUB0XjF5t3b6JylR2BPAUOIkEGF
         oj0my/EuOmN95+xgYIpCkJkEj72TZqHbrycwF6JJn7ydm4DAgUkcgcAaF3Lh6GknLnOT
         o65scRxsbnTRiVM8IlHbGxlKBSb8DkN5n2dY0imMwzL4C2vt1682zvj/xxhZ+2N17YWk
         9Ddy9eeas9jSc17LsP0737DWcMnbnONFo3Oxgt/75HunDs5if0GL02+SZr09nN66ZNEk
         FYHw==
X-Forwarded-Encrypted: i=1; AJvYcCUafyk/9TrWB1OLqUijdm1hOdxFsw13zwha7hNJM/R0qyaNz1Hc+U+kTPG4PC2Od1+9Kf1t4MdVMm94aH7n/RX+s7tE8lZ9Vl4/gMM1HMi7ZYkmhnjTCNCb+E9Git26tXGNHVuwPyzA+yxHw5E6hByaYWQUtKQuAOGzVU0YJgcx5N10i6LBg/xe
X-Gm-Message-State: AOJu0Yy1843OYza8H6msZyH8SI1PARVKw1Rw2LcKpewCtnlNAwhAD4k+
	PgUTTuzJAndso/TSm2CTRLLtLpLnXznWLU3zKqq7neZ8u99ZF9w6
X-Google-Smtp-Source: AGHT+IHTU4/1a/CISb70dOmWPVCk00XDYiKe9Fl+Wj5pJ25bKNH+jrEss1h296t9rTc3vksNHw7ykg==
X-Received: by 2002:aa7:8251:0:b0:6e0:5094:409d with SMTP id e17-20020aa78251000000b006e05094409dmr1761099pfn.2.1707495794217;
        Fri, 09 Feb 2024 08:23:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIuEQTylwDoBi/eYwTZVjznm2ngNCe44Lw3mhfD2AoTdgjtMkcBHixyBjVTAvxWa9MuUYbD4Tc7cqIpzLae+uOZmFIoq8hLYQ/VdXD4V7tC1kDs3TFmAHOOu5A9dqXuyZ6roKMR7OERx9UH5oSKPfRf/dzEuxtKQhvfLEMZ0TGZfS9acWR8Ew+O5Jw32x9ZvtEZJ44iRLwmhYNfujIYgpcf3g1OkgHhp+xB8pqyW1xIWIagYYaggHfykc2vFUrGrIlSxiN/oiUFk1N+fYDdMfHghZlUw1d91n2Lqp2Ih2mplXQ7Iy8xrGb5Eq7XiRcN00Jbqzlt/s8xSmJMjrOJKXjhkA8FzpDmRqcmYP/Z/RaZicXpX2KMInMPaEZEmhvr2q3rAYUOiC9nYsknXYlxmbOs2wQ
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b7-20020a62cf07000000b006da96503d9fsm727751pfg.109.2024.02.09.08.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 08:23:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d3cd4559-efbc-4e6c-9390-ad26ce330d23@roeck-us.net>
Date: Fri, 9 Feb 2024 08:23:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: watchdog: qcom-wdt: Update maintainer to
 Rajendra Nayak
Content-Language: en-US
To: Jeffrey Hugo <quic_jhugo@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, wim@linux-watchdog.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 quic_rjendra@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240209161800.3872964-1-quic_jhugo@quicinc.com>
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
In-Reply-To: <20240209161800.3872964-1-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/9/24 08:18, Jeffrey Hugo wrote:
> The servers for the @codeaurora domain are long retired and any messages
> sent there will bounce. Sai has left the company and appears no longer
> active in the community which leaves this binding orphaned. Rajendra Nayak
> has volunteered to take over as maintainer.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index a4f35c598cdb..47587971fb0b 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Qualcomm Krait Processor Sub-system (KPSS) Watchdog timer
>   
>   maintainers:
> -  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> +  - Rajendra Nayak <quic_rjendra@quicinc.com>
>   
>   properties:
>     $nodename:


