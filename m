Return-Path: <linux-kernel+bounces-49679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E77C846E0D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4041C2254E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8874131E37;
	Fri,  2 Feb 2024 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="negZTzXR"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770A131748
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870003; cv=none; b=RNkGVweW0N8+LDMMaL5zmu0kzOiCdkj6+ODBLX8t+XppkV82Owmy/e/1emTyqw3OhjMkc+cMR8+IVfdWsLDW8I3v5PSPDlHXs4bwm7gVCLp68/vTIMNlMdbKnEBjJZxG+4AXDlB7RyWJD4Zr140Oxe/d+hAc2JUawttYMTwwPog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870003; c=relaxed/simple;
	bh=DMMt/shyGWqcD+ib28kiLpaMXR+euETZG735wBIYD+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flSI9D27SN6qlPzxdnGGM2YlJ8ZaTAApeaT8Vln+mTUikN5pkSPdTkc2fAevbUz/hkxSXb5hW1fJqBBmFxjyk/gesT7s0Gwa4y2A1RnefyPDWFpVhG20BqEc1QoG0P9w84wp8fHZB7iDaKis/pO5IRQDc9IJsALRKlk06oVS/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=negZTzXR; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6de207c85fcso209677b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706870001; x=1707474801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T8iHE479YVvdQnvL1fZ7V63tnI2/lAPeZVx8YhIJp00=;
        b=negZTzXRrjRf79V0Fa9wwXTO+vGf1SvuWwD9EL7YSCEc3Vi7mh40+Vt/R9kmVFnh+O
         quYQE8upbtGWkVftruWEetnbd9P2I2NmZBPx5MviTLeDVLNzeVoiCvRW5+MqgGLhIYes
         nnoKS8t+fdAyY4I4rbYfhgUyphZByzl+mob3zoBJDNd57Atl9pK0moK1A3C28nhW//4U
         CbJPl3mNUsM5MhZq8qfGD2/0dixngpqh0ZDlumdOfaVzWIBZSGtZRwSQVXVdR9heJuYd
         nL4AckRHPNbhK5eLeFg2qr8hh32MDK9ZijtdlDR5HKjeNgf4RD338n6jgD4WDJBWe3PX
         oWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706870001; x=1707474801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8iHE479YVvdQnvL1fZ7V63tnI2/lAPeZVx8YhIJp00=;
        b=RSc3W7o7nS3YSsABrCHUp7hNt/t36XJbubE6bKZj3hTrukGewxxxeGnZ4DybofCZLF
         6H/MzjCbwX97NbaCG5iaLDvY52nAD/tNP2/eQA8VjtZTkhLVGlEdc20Gsm+fPhNS7FyX
         /Bs7lOWqcm20cJNeOEKalBIz0twhDywFus43MaVxZHO39T3sclxdDpF2kljF5CpD3V1h
         HorpEphBadF05iOlcT8Bz1X6VCJc73AD7E++Gs1/I64T/MX2eAqtDIXbqT8BHuTq40wp
         YEfaI55jn4wZKUwQswGc4bwOZT7xEANoYnNlV8bVtjaszp97f/NywmkPiXef7GGo5RhV
         qqxw==
X-Gm-Message-State: AOJu0YyNFVOEGHy03U5aMSsZKl+V8xB4HeHwTz4unIr4icrAJneweieo
	1JljUyqKDveLa2PC8wmoDGTqkv80laQjQfCfYtX/H+HdFkvOWG2h01MTJCRI9JE=
X-Google-Smtp-Source: AGHT+IF6Vbai2YBU7cb51y8R4IB03FxPQx+BBkX/tfJTtHIPiA0XBZiwJtgRNHGa4tUQp7qa7GJeHQ==
X-Received: by 2002:a05:6a20:7486:b0:19c:9c10:fa27 with SMTP id p6-20020a056a20748600b0019c9c10fa27mr5462240pzd.4.1706870000941;
        Fri, 02 Feb 2024 02:33:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUE4ny+RfqFrQN3ryErdIfcptjtiUDXiAnUOdO8oSK4hhFsFYWe37sJfIbcmbdh+n9iSFjmgJOylcGTuWgAnnJg8Ck/toMJwjx3Ha9RnlqV0ti/2dFnQVZ4XXCGAStK0s2Bkkj1LHDNHM6CSubetnEajPBYkxC9xYe/G2BeVKyhgcaF6HhrN9qRhNvnyt5NjRqcXjz3sZdsydpAemlP78SDJi21qiUfnV29zoyoqabPyCl2nt0H0NYH35uo6WJrrCjbLgTKxjk6x1J6HbmZpTnQEPVhPZmKYb1gqK2wJKCZc4D+XUbi0NdKaStXWC6Vu4NHC+Hz4pUUyObRAR3LxOueT3GnzfZoxQOZZGec1yObxzzYUR8awfMF6wo67wFXPDV6hG5v/4uxm0ip6MUS7ITWAjHGGRMBU2GPGgj2yov3Ln5fyYNe98r7y1G06yaZnA6A0ow5DAu4sxD2sZn2YJVJmrMLRIQCuGgI+YsviiAkLZ4MGpbDyMQZfXjvqhKzSoaG3+OaLdOeywYmOwTtFwAxgHgh8APY6t9bD7HG4EoJLE/rjmHWih00OTsF9hVw6ayr/q6SEo2XzVwHOt20RQ==
Received: from ?IPV6:2a01:e0a:999:a3a0:6d51:959f:bb28:92? ([2a01:e0a:999:a3a0:6d51:959f:bb28:92])
        by smtp.gmail.com with ESMTPSA id mj10-20020a17090b368a00b002963e682f6fsm1111059pjb.57.2024.02.02.02.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 02:33:20 -0800 (PST)
Message-ID: <f2e5fdbf-971c-4f73-af07-3c3a04bd0069@rivosinc.com>
Date: Fri, 2 Feb 2024 11:33:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 22/25] irqchip: Add RISC-V advanced PLIC driver for
 direct-mode
Content-Language: en-US
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
 Marc Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>,
 linux-kernel@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Atish Patra <atishp@atishpatra.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Andrew Jones <ajones@ventanamicro.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-23-apatel@ventanamicro.com>
 <eed1ee03-923b-41e8-b99a-accc1278da6b@rivosinc.com>
 <CAK9=C2U5_Ho0XUvEXRgASDKrGaVvPX68+UV2+=Z4k=cUaM3=6A@mail.gmail.com>
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAK9=C2U5_Ho0XUvEXRgASDKrGaVvPX68+UV2+=Z4k=cUaM3=6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 02/02/2024 11:30, Anup Patel wrote:
>>> +int aplic_setup_priv(struct aplic_priv *priv, struct device *dev,
>>> +                  void __iomem *regs)
>>> +{
>>> +     struct of_phandle_args parent;
>>> +     int rc;
>>> +
>>> +     /*
>>> +      * Currently, only OF fwnode is supported so extend this
>>> +      * function for ACPI support.
>>> +      */
>>> +     if (!is_of_node(dev->fwnode))
>>> +             return -EINVAL;
>>> +
>>> +     /* Save device pointer and register base */
>>> +     priv->dev = dev;
>>> +     priv->regs = regs;
>>> +
>>> +     /* Find out number of interrupt sources */
>>> +     rc = of_property_read_u32(to_of_node(dev->fwnode),
>>> +                                          "riscv,num-sources",
>>> +                                          &priv->nr_irqs);
>>
>> Use device_property_read_u32() which works for both ACPI and OF.
> 
> In the previous versions, we did try to unify property reading for
> both ACPI and OF but MarcZ suggested to keep th ACPI and
> OF probe paths totally separate hence we use OF APIs over
> here because we should reach here only for OF probing.

Ok, indeed it makes sense. Discard that comment then !

Thanks,

Clément

