Return-Path: <linux-kernel+bounces-91905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7387487182B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF53F1F22620
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432E57F7EB;
	Tue,  5 Mar 2024 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+I0qLaF"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5685F9EB;
	Tue,  5 Mar 2024 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709627011; cv=none; b=ge3cBwucr6q5tEj94r8Q4Bw+Xt0WHZBCjwb1uHU2ATG5AGwmpC0kV19uEmumJG5LKTMYstgkNsMx02Wo7dKWUXoc+yoUOUZ0zvrm+N9hHBNRFhO/WJimfH/JKt1pARezl7ncq33XeEjgofKimQ4RYiDBHgr7/IHIit27kfI6hGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709627011; c=relaxed/simple;
	bh=l1DPh8I9/0GRMz+a/czF69K1K5RvZU+Lc7FpDQBLt1c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KR7leg8bnovTFgdZ1qh8BEQviaZoAqm5V2j9Nz8qJ3t7rxhG6fnUVfERZzYckxjgNDgnJfUjizH7nF93lcRWrOYneVW94dVk/AeWNNjU0FL5ARCcnRCscCaboDExAkR2sI4GLIsNbo/JtkyF5T0iIOsu96jy9S8VKR2KagiqUHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+I0qLaF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6da9c834646so4864715b3a.3;
        Tue, 05 Mar 2024 00:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709627009; x=1710231809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1g27t8FIKz+8joX7Ftwg5jvloiAU4fC8Iy9tYf6ghx8=;
        b=N+I0qLaFiUFeVcfZc6kMiWs6Z2KIxEa2TPDbhfltC92nWfRT5QxwwV3y0EMY4XwNj9
         Awjm55wkUR6nPpWmtEfoZJvyuDmRIL2U8fzrdIIqrn6QZWwtUqCLUW7FrvegzgSiPiES
         rCDq4KDDzQsMpaXISVKShqQO0q1N7sKGAMoPUwaooDrgK+umlyeP2fS/MXLTdKIURoEI
         bn3NsYevYhAXLsvdcP2Ae02y2n8ixB54NHMagdqtnGlz1ljKGG1gmcufiT/oT22AY+qu
         y44sdnZ8MGEioExtOa+8gc1DNe39MnjL29v5xCITXkYS1Vn67BPzHV1o64jkx3EDU/vY
         iw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709627009; x=1710231809;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1g27t8FIKz+8joX7Ftwg5jvloiAU4fC8Iy9tYf6ghx8=;
        b=ZRKKdEMq2hIPnP7y4lzJqNpYUB5FU17eWSxd7aUtkE1x06By9jI/5i87eN4OLqlOC/
         JYokUCoeiNO21RVnT8Vj11vEwPPi1mcuru5OChJ3lXMVITYAlD8ZzZJDw363hJWvQW8C
         lUbmT4ILqiVYJ2shDh9woLAG64Ic55aZi62lXrx343N8PwuNbwK1ygIjF4CrLWcvqjG5
         bSofJalRixub1yT8rVWAasswRnNURd2S9LIdMTIBUBPc/5GwdCqj5Lthrxx90ZSzJkZ3
         vJILlGuXlr3pEOXreZg/WMgXSjj+79y6EXlUyZIyg108cpZaMWrBk3yH1aX+PsU+Sw7Z
         qh4w==
X-Forwarded-Encrypted: i=1; AJvYcCXPL2MrPBls1+nTMWlg+TEJf/IvMYp/M93BjDPcR8OGsLDSKs5+ClpVnYP/SJ96HnbPllne/T1VER1RdG9yl3DvOE3HLbDdHN5WUDEX7RdC0YOH6/xDk/MJ9AMlq2Gjezr5msMR4Kt3e5ECWqdn7/ZOByiuAoP+8MigE+hipXWSBBAu
X-Gm-Message-State: AOJu0YyGb9GDEQjnEXN/B2bydicUxxuH30ATxIGCDLObcsebPj6JKIbW
	tgUrRIjqIj02oXKI9GLraqjZtfmOjp2MXUYMMlmxwdGCsTU0yPpk
X-Google-Smtp-Source: AGHT+IF9SKk6a4cMNQbrF4DFhdgx+5PiAEPa+d1ZvTRbePz3trVKCB/TlEEpEu54Ag6zLp5U1oxZjA==
X-Received: by 2002:a05:6a20:d486:b0:1a0:efd0:b183 with SMTP id im6-20020a056a20d48600b001a0efd0b183mr1640050pzb.44.1709627008927;
        Tue, 05 Mar 2024 00:23:28 -0800 (PST)
Received: from [192.168.0.13] ([172.92.174.232])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e5d200b001dd02f4c2casm4781542plf.164.2024.03.05.00.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 00:23:28 -0800 (PST)
Subject: Re: [PATCH v4 1/3] riscv: dts: starfive: Enable axp15060 pmic for
 cpufreq
To: Mason Huo <mason.huo@starfivetech.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Shengyu Qu <wiagn233@outlook.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20230606105656.124355-1-mason.huo@starfivetech.com>
 <20230606105656.124355-2-mason.huo@starfivetech.com>
From: Bo Gan <ganboing@gmail.com>
Message-ID: <c8b6e960-2459-130f-e4e4-7c9c2ebaa6d3@gmail.com>
Date: Tue, 5 Mar 2024 00:23:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230606105656.124355-2-mason.huo@starfivetech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 6/6/23 3:56 AM, Mason Huo wrote:
> The VisionFive 2 board has an embedded pmic axp15060,
> which supports the cpu DVFS through the dcdc2 regulator.
> This patch enables axp15060 pmic and configs the dcdc2.
> 
> Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>   .../starfive/jh7110-starfive-visionfive-2.dtsi  | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 2a6d81609284..9714da5550d7 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -114,6 +114,23 @@ &i2c5 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&i2c5_pins>;
>   	status = "okay";
> +
> +	axp15060: pmic@36 {
> +		compatible = "x-powers,axp15060";
> +		reg = <0x36>;
> +		interrupts = <0>;
> +		interrupt-controller;

This appears to be wrong. I'm working on a private tree of OpenSBI, where I validate
all PLIC SYS/AON/STG CRG/SYSCON/IOMUX, and other devices... register reads/writes.
Looks like this `interrupts = <0>` will cause the kernel code (my vanilla 6.6 tree)
to enable interrupt 0 on PLIC, which is wrong. Of course, you won't see this problem
if you run upstream OpenSBI, where all writes to PLIC are permitted. I assume PLIC
will ignore this request to enable irq 0. Still, this is wrong. Can someone from
Starfive take this issue? Attaching the backtrace here:

# This line is from my OpenSBI
jh7110_virt_plic_write: U7 refusing to enable interrupt 0
# After this, I'll inject a memory access (write) fault to S mode

# Below is from Linux
Oops - store (or AMO) access fault [#1]
Modules linked in:
CPU: 0 PID: 62 Comm: kworker/u9:2 Not tainted 6.6.0-gc3eb9993b167 #14
Hardware name: StarFive VisionFive 2 v1.3B (DT)
Workqueue: events_unbound deferred_probe_work_func
epc : plic_irq_enable+0xd2/0x15e
  ra : plic_irq_enable+0xa8/0x15e
epc : ffffffff804650bc ra : ffffffff80465092 sp : ffffffc8003f34c0
  gp : ffffffff816d2290 tp : ffffffd802411f80 t0 : ffffffc8003f3010
  t1 : 0000000000000001 t2 : 0000000000000003 s0 : ffffffc8003f3530
  s1 : ffffffd801eaee30 a0 : ffffffd8bff835b0 a1 : 000000000000001e
  a2 : 0000000000000004 a3 : ffffffd801eaee00 a4 : 000000000000001e
  a5 : ffffffc804002100 a6 : 0000000000000000 a7 : 00000000000007ad
  s2 : ffffffff80ede5a0 s3 : 0000000000000001 s4 : 000000000000ffff
  s5 : 00000000ffffffff s6 : 0000000000000000 s7 : 000000000000001f
  s8 : ffffffff81707af0 s9 : ffffffff80eda688 s10: ffffffd801eaee00
  s11: ffffffd8bff835a0 t3 : ffffffff816d3420 t4 : 0000000000000002
  t5 : 0000000000000000 t6 : 0000000000000000
status: 0000000200000100 badaddr: ffffffc804002100 cause: 0000000000000007
[<ffffffff804650bc>] plic_irq_enable+0xd2/0x15e
[<ffffffff800649e6>] irq_enable+0x2c/0x64
[<ffffffff80064a76>] __irq_startup+0x58/0x60
[<ffffffff80064ada>] irq_startup+0x5c/0x14e
[<ffffffff800621f4>] __setup_irq+0x582/0x644
[<ffffffff80062368>] request_threaded_irq+0xb2/0x154
[<ffffffff8055571a>] regmap_add_irq_chip_fwnode+0x6fe/0x8f2
[<ffffffff80555944>] regmap_add_irq_chip+0x36/0x4a
[<ffffffff8055cb1e>] axp20x_device_probe+0x36/0x114
[<ffffffff8055cce6>] axp20x_i2c_probe+0x6c/0xa0
[<ffffffff8063a8f0>] i2c_device_probe+0x11c/0x23e
[<ffffffff80533464>] really_probe+0x86/0x23e
[<ffffffff80533678>] __driver_probe_device+0x5c/0xda
[<ffffffff80533722>] driver_probe_device+0x2c/0xf8
[<ffffffff8053385c>] __device_attach_driver+0x6e/0xd0
[<ffffffff80531a2c>] bus_for_each_drv+0x5a/0x9a
[<ffffffff80533ba0>] __device_attach+0x78/0x116
[<ffffffff80533db6>] device_initial_probe+0xe/0x16
[<ffffffff80532722>] bus_probe_device+0x86/0x88
[<ffffffff8053034a>] device_add+0x3b2/0x552
[<ffffffff80530500>] device_register+0x16/0x20
[<ffffffff8063bb54>] i2c_new_client_device+0x14e/0x214
[<ffffffff8063d9ae>] of_i2c_register_devices+0xa2/0xf8
[<ffffffff8063c246>] i2c_register_adapter+0x130/0x32e
[<ffffffff8063c49e>] __i2c_add_numbered_adapter+0x5a/0x86
[<ffffffff8063c55a>] i2c_add_adapter+0x90/0xb4
[<ffffffff8063c62e>] i2c_add_numbered_adapter+0x22/0x2a
[<ffffffff8063fd34>] i2c_dw_probe_master+0x288/0x304
[<ffffffff806409c4>] dw_i2c_plat_probe+0x288/0x37e
[<ffffffff80535946>] platform_probe+0x4e/0xa6
[<ffffffff80533464>] really_probe+0x86/0x23e
[<ffffffff80533678>] __driver_probe_device+0x5c/0xda
[<ffffffff80533722>] driver_probe_device+0x2c/0xf8
[<ffffffff8053385c>] __device_attach_driver+0x6e/0xd0
[<ffffffff80531a2c>] bus_for_each_drv+0x5a/0x9a
[<ffffffff80533ba0>] __device_attach+0x78/0x116
[<ffffffff80533db6>] device_initial_probe+0xe/0x16
[<ffffffff80532722>] bus_probe_device+0x86/0x88
[<ffffffff80532b86>] deferred_probe_work_func+0x70/0xa6
[<ffffffff800238c2>] process_one_work+0x14a/0x23a
[<ffffffff80024760>] worker_thread+0x314/0x450
[<ffffffff8002be5a>] kthread+0x9a/0xae
[<ffffffff8000248a>] ret_from_fork+0xa/0x1c
Code: 97ba 000f 0140 4398 000f 08a0 9bbb 0179 ebb3 00eb (a023) 0177
---[ end trace 0000000000000000 ]---


> +		#interrupt-cells = <1>;
> +
> +		regulators {
> +			vdd_cpu: dcdc2 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1540000>;
> +				regulator-name = "vdd-cpu";
> +			};
> +		};
> +	};
>   };
>   
>   &i2c6 {
> 

Bo

