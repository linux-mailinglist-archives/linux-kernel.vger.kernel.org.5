Return-Path: <linux-kernel+bounces-150996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D248AA788
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03652874EB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333798BF7;
	Fri, 19 Apr 2024 03:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdaUhM6H"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384F4323C;
	Fri, 19 Apr 2024 03:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713498924; cv=none; b=ajKZ2BkbZRxIKfS2YkNZ6U+X4pji8j7RJzebRr7cs+qMcVfVEpJtRUpai7SOg4L+0MgiVotebttcCeWTnkWsIpJSNjH/uprCOSGh3oaQ136lW4pl5V1X893M+RhYCWvXQz4WjLCNoexgrYIQkyxxgBcmYoQmD7X5Ksu1ZJ7V8Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713498924; c=relaxed/simple;
	bh=Hj0Ur+O5gK7sxoac/D4Y4m0WjSqic1WO5eelx/iN0zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKLo3QGtam/gp7TCPvQ25eOX9XcgwTagJGIXqKvXAz9Ckwlf85agTJwMwpP3OgJs+1yVVvIwBPkqzuwJv4wiI8E4YDF1yOlChoNenjdiD7hQdaL47jkxAG1sd6n8L0h+SvPAelZUdSh3Xxk1rKlvLzpAfY5R+sV7s9F61oslrE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdaUhM6H; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso1334372b3a.3;
        Thu, 18 Apr 2024 20:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713498922; x=1714103722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Sdu6h80t0SgorDxNNQ6cN+80d3emFIVVAnewaeFSZo=;
        b=WdaUhM6HbqTYFlbUnBUIWawQVu0eKamA5GLZEqdd5CYxRWW3fveXMvhi/V9x8A+82X
         OKHpjid3XpcRnUXkjRSlYcpkynPegw1bo2qOrO2rS/JN6OvfLh2xyn+suz3unoLcRv8v
         r78upuTGsCeN76OvY6RhEgydVVYEeSKJFJj2blw7utHSMSMGCM9GUee6iA7KoKWFSDyb
         JGe5P1pow5t9qEO3xZL71FmCzg2PQOYbY7MIhYjyh2IBayF+Sh1Eq4f581ra8O197oys
         jpJJ/BKW35/fQn5aIw/67Puoe8/OZQ5yD7DFvNvoHQkJWvgWcJuov7ikCTwifO8OigR7
         X7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713498922; x=1714103722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Sdu6h80t0SgorDxNNQ6cN+80d3emFIVVAnewaeFSZo=;
        b=v5qgiKXs/N6bmye/8nvJ1FBCUqoV6exBFnQcwBthrakoEbiZvMxoR7kP6tDT/tdVpG
         H2j6f/Wkvn/OgIsDducw+F9qXdCJJIB88e9OxeOWJHk/MUX/Tt5UQo2ULx2LNlq3l8ej
         iUkdU1IWf9VZvF6Dk2T4BvU2jpJSad5+M7jGV1WbQVGAU7vt7klF6UpGyD4tvqO7dojW
         KQs0oA4U7Pp4SGiR5I7EFZn6qlGI8wrcdnL4pckzOa0GSAs2XeYJYYJCFNvqocxfwu20
         +KMOEGaJstufiHM67NDZw+KYtuYY/f5lzmYf9WvVmQ3Kv4xTPtauPMlhoCqifXV2DfaH
         f1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWXdUDm3O+yhnCNdxiGkwuUGQab0CMPk3sknPhND7lhLdB+/5rKFcSErcKnarn4+0iyXqhDK+BnS6nPaCxNvOXJzrr08op+VyOcdGV/CwZ4LovkdHmQ3pln6id/ux7A8wjRpRWsHauAg==
X-Gm-Message-State: AOJu0Yw6gM7DD5VH482GeBhiEblkNnE8LRpceiX0dCNEzkeykU8zJE7c
	tZ/ozqb+uy/JUyaDGOwVZxT6R2pfHHttR12HjItHCs+CSSgZFxUx
X-Google-Smtp-Source: AGHT+IGyBwaxrESeGxC8XP4K1xlGjY0jVJ9oR9qu3J3AKH7owVK+n9PHDJdr8gY/ePIPIdZgjaabNQ==
X-Received: by 2002:a05:6a21:1f16:b0:1a7:6e6:edd6 with SMTP id ry22-20020a056a211f1600b001a706e6edd6mr1132842pzb.52.1713498922433;
        Thu, 18 Apr 2024 20:55:22 -0700 (PDT)
Received: from [172.27.234.152] (ec2-16-163-40-128.ap-east-1.compute.amazonaws.com. [16.163.40.128])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902e88600b001e4ea358407sm2315725plg.46.2024.04.18.20.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 20:55:22 -0700 (PDT)
Message-ID: <84b162f6-fc34-4008-83f6-2ee9e42c5a59@gmail.com>
Date: Fri, 19 Apr 2024 11:55:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 2/9] irqchip: Add RISC-V incoming MSI controller early
 driver
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 Marc Zyngier <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Atish Patra <atishp@atishpatra.org>,
 Andrew Jones <ajones@ventanamicro.com>, Sunil V L
 <sunilvl@ventanamicro.com>, Saravana Kannan <saravanak@google.com>,
 Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240307140307.646078-1-apatel@ventanamicro.com>
 <20240307140307.646078-3-apatel@ventanamicro.com>
 <8738cb85-fac1-4a15-9666-eb05316f5368@gmail.com>
 <CAK9=C2X+Aovid=AFXP-EOj3-f6xDYiGsMMNOqknFr58nu5dgbw@mail.gmail.com>
Content-Language: en-US
From: Eric Cheng <eric.cheng.linux@gmail.com>
In-Reply-To: <CAK9=C2X+Aovid=AFXP-EOj3-f6xDYiGsMMNOqknFr58nu5dgbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/19/2024 11:44 AM, Anup Patel wrote:
> On Fri, Apr 19, 2024 at 8:53 AM Eric Cheng <eric.cheng.linux@gmail.com> wrote:
>>
>> On 3/7/2024 10:03 PM, Anup Patel wrote:
>>
>>> +static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
>>> +                                  struct imsic_global_config *global,
>>> +                                  u32 *nr_parent_irqs,
>>> +                                  u32 *nr_mmios)
>>> +{
>>
>> ...
>>
>>> +     /*
>>> +      * Find first bit position of group index.
>>> +      * If not specified assumed the default APLIC-IMSIC configuration.
>>> +      */
>>> +     rc = of_property_read_u32(to_of_node(fwnode), "riscv,group-index-shift",
>>> +                               &global->group_index_shift);
>>> +     if (rc)
>>> +             global->group_index_shift = IMSIC_MMIO_PAGE_SHIFT * 2;
>>> +
>>> +     /* Find number of interrupt identities */
>>> +     rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
>>> +                               &global->nr_ids);
>>
>> Will here check if the pass-in interrupt identity number is (multi-64 -1) &&
>> between [63, 2047]?
>> Per spec AIA v1.0, Sec. 3.1 Interrupt files and interrupt identities:
>> "The number of interrupt identities supported by an interrupt file (and hence
>> the number of active
>> bits in each array) is one less than a multiple of 64, and may be a minimum of
>> 63 and a maximum
>> of 2047."
> 
> There is already a check on global->nr_ids to ensure the above is satisfied.
> Please see further below in imsic_parse_fwnode() function.
> 

Right, thanks.
>>
>>> +     if (rc) {
>>> +             pr_err("%pfwP: number of interrupt identities not found\n", fwnode);
>>> +             return rc;
>>> +     }
>>> +
>> ...
>>
>>
> 
> Regards,
> Anup


