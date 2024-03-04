Return-Path: <linux-kernel+bounces-91062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3A387091C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802051C222AB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417316216E;
	Mon,  4 Mar 2024 18:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="e5cWzcyq"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D586169E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575696; cv=none; b=FDyFqTcHaCGIdXmP/985YpUrQlteDPpRaXEcqqUMIOS2X2DSzP78sQBzr8SJ/uNY7UQWo9IxyIW3UOaEGk2IRRxGVM6F9rdrpvJho7jZl4onajmxFvlG4lVxgGAYJZR7O7JiYJyeNUz3eeaVM0wH5icyRxeWafUCK/G4RZTGNHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575696; c=relaxed/simple;
	bh=SCCU9dbfZqUMw7g1ftHwe7lhiBrDP1IoW13xbyD472Q=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=jnA58rNv6nr5VOyMkYEQvwSnaVx20DyVt6vFz0MZcoFNOL3mdnZIN1o3+0j0zKCjRcnvzTw8seS0n6WM1KrA/cERxOwqp0blG8S4nDggat8Nv3W3mj+U0OiiG2nKLL8IYi5hN90Zvw5Jq9V+a9D00xVXpvH/F6ZS4ZrDWkaToLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=e5cWzcyq; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d3907ff128so4775491a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1709575693; x=1710180493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aizblNvc9Cf2btttMWelCC6kMijS1p5vy42920jDwTY=;
        b=e5cWzcyqyDy+69v+oaErXiT4T6SwOmNPAowtEemMkU4mmWJ4T5hfleUs4acVf8v4PO
         FFiRsFy6LVb6QRv6ydgK1vY59/vytWvEL7lbZt1jjc35GaEqJYxN0XXkKDdN8J0p91ey
         lSbzRoCalAND2OhVnq0e36pM1NdKhfA6mzVtIMgDbaLGhdYMHK+2K+mQUTkIEvR08hmX
         0NLOjA0lvjzFXETVgGw30WodRrfz3g567iEVDAYvaPW4tMpv+42fIaq9c/V638m/2FFV
         F2c/zzjj+yXliFZgtk+UBRi+WaDH6sm/cTE36niNyTsbh+u7Vqiqo8YWi2gC4CUjyEjD
         yYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709575693; x=1710180493;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aizblNvc9Cf2btttMWelCC6kMijS1p5vy42920jDwTY=;
        b=TQNUhDYBGVSlPFFIntUR/gAVBQlDNbW0G2gM9MMSe65BNEGlDYRBrE50+qBnrPBwq2
         j5uhlkZ/PsD6FbRE1YmjoPdkr8fQC2plzRkPi6Sg53PQBjgZq4deOh3vcnT7aRTmmfeD
         Py/lwYXGSfLbR6HoFf/TPh50TFJynlRGCC9uN0bHNc5cqvbOyVDOreBhLhSOnN/ZYJfN
         97EweaUm0zpgxVeMwSvwhcKzICmNcq9X+uGabMGgTcMNK0HfCJzvR3VvkDgi14ZO47UT
         gAAaq7aOa350D27ULfb8J+8F+grBDIbRyDw+BNtbnr1nwudIMHreG5/+qGrKGtbRjxY1
         avsg==
X-Forwarded-Encrypted: i=1; AJvYcCVA2qXdSQ1DIeRgypNN+0VpbiVZxbof54iaXlS6AFhVAFV/AHbtUg1geDcCiFWFknCWq1vUk7/LHhYCsGtSrJwb0QfHfeuf5ePoN74c
X-Gm-Message-State: AOJu0YzXixGg5fzAopw2LbYHzmAN12r8pLfBP4/6EfjXyalhSfMp9An/
	9zOYpXelbWtp9GaXe65mBj5wBQji4O30Avow3aerBB/k4XNF1Im7Oc4rti+bHNU=
X-Google-Smtp-Source: AGHT+IFhlrCJ7z/RMUFxQQf2zMzCvbw2MLdNLsKVNf46b6Rg0IEtkQiqwfm6zGkZbeAOroe6+Tng3g==
X-Received: by 2002:a17:90a:8a0e:b0:29a:a08d:4809 with SMTP id w14-20020a17090a8a0e00b0029aa08d4809mr7511710pjn.2.1709575693052;
        Mon, 04 Mar 2024 10:08:13 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id l3-20020a17090ac58300b0029b2e00359esm5161382pjt.36.2024.03.04.10.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:08:06 -0800 (PST)
Date: Mon, 04 Mar 2024 10:08:06 -0800 (PST)
X-Google-Original-Date: Mon, 04 Mar 2024 10:08:04 PST (-0800)
Subject:     Re: [PATCH v15,RESEND 22/23] PCI: starfive: Offload the NVMe timeout workaround to host drivers.
In-Reply-To: <ZeCd+xqE6x2ZFtJN@lpieralisi>
CC: minda.chen@starfivetech.com, Conor Dooley <conor@kernel.org>, kw@linux.com,
  robh+dt@kernel.org, bhelgaas@google.com, tglx@linutronix.de, daire.mcnamara@microchip.com,
  emil.renner.berthing@canonical.com, krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, p.zabel@pengutronix.de, mason.huo@starfivetech.com,
  leyfoon.tan@starfivetech.com, kevin.xie@starfivetech.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: lpieralisi@kernel.org
Message-ID: <mhng-87e7ef5a-d60b-4057-960d-41bc901b6c7f@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 29 Feb 2024 07:08:43 PST (-0800), lpieralisi@kernel.org wrote:
> On Tue, Feb 27, 2024 at 06:35:21PM +0800, Minda Chen wrote:
>> From: Kevin Xie <kevin.xie@starfivetech.com>
>>
>> As the Starfive JH7110 hardware can't keep two inbound post write in
>> order all the time, such as MSI messages and NVMe completions. If the
>> NVMe completion update later than the MSI, an NVMe IRQ handle will miss.
>
> Please explain what the problem is and what "NVMe completions" means
> given that you are talking about posted writes.
>
> If you have a link to an erratum write-up it would certainly help.

I think we really need to see that errata document.  Our formal memory 
model doesn't account for device interactions so it's possible there's 
just some arch fence we can make stronger in order to get things ordered 
again -- we've had similar problems with some other RISC-V chips, and 
while it ends up being slow at least it's correct.

> This looks completely broken to me, if the controller can't guarantee
> PCIe transactions ordering it is toast, there is not even a point
> considering mainline merging.

I wouldn't be at all surprised if that's the case.  Without some 
concrete ISA mechanisms here we're sort of just stuck hoping the SOC 
vendors do the right thing, which is always terrifying.

I'm not really a PCIe person so this is all a bit vague, but IIRC we had 
a bunch of possible PCIe ordering violations in the SiFive memory system 
back when I was there and we never really got a scheme for making sure 
things were correct.

So I think we really do need to see that errata document to know what's 
possible here.  Folks have been able to come up with clever solutions to 
these problems before, maybe we'll get lucky again.

>> As a workaround, we will wait a while before going to the generic
>> handle here.
>>
>> Verified with NVMe SSD, USB SSD, R8169 NIC.
>> The performance are stable and even higher after this patch.
>
> I assume this is a joke even though it does not make me laugh.

So you're new to RISC-V, then?  It gets way worse than this ;)

> Thanks,
> Lorenzo
>
>>
>> Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> ---
>>  drivers/pci/controller/plda/pcie-plda-host.c | 12 ++++++++++++
>>  drivers/pci/controller/plda/pcie-plda.h      |  1 +
>>  drivers/pci/controller/plda/pcie-starfive.c  |  1 +
>>  3 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
>> index a18923d7cea6..9e077ddf45c0 100644
>> --- a/drivers/pci/controller/plda/pcie-plda-host.c
>> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/msi.h>
>>  #include <linux/pci_regs.h>
>>  #include <linux/pci-ecam.h>
>> +#include <linux/delay.h>
>>
>>  #include "pcie-plda.h"
>>
>> @@ -44,6 +45,17 @@ static void plda_handle_msi(struct irq_desc *desc)
>>  			       bridge_base_addr + ISTATUS_LOCAL);
>>  		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
>>  		for_each_set_bit(bit, &status, msi->num_vectors) {
>> +			/*
>> +			 * As the Starfive JH7110 hardware can't keep two
>> +			 * inbound post write in order all the time, such as
>> +			 * MSI messages and NVMe completions.
>> +			 * If the NVMe completion update later than the MSI,
>> +			 * an NVMe IRQ handle will miss.
>> +			 * As a workaround, we will wait a while before
>> +			 * going to the generic handle here.
>> +			 */
>> +			if (port->msi_quirk_delay_us)
>> +				udelay(port->msi_quirk_delay_us);
>>  			ret = generic_handle_domain_irq(msi->dev_domain, bit);
>>  			if (ret)
>>  				dev_err_ratelimited(dev, "bad MSI IRQ %d\n",
>> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
>> index 04e385758a2f..feccf285dfe8 100644
>> --- a/drivers/pci/controller/plda/pcie-plda.h
>> +++ b/drivers/pci/controller/plda/pcie-plda.h
>> @@ -186,6 +186,7 @@ struct plda_pcie_rp {
>>  	int msi_irq;
>>  	int intx_irq;
>>  	int num_events;
>> +	u16 msi_quirk_delay_us;
>>  };
>>
>>  struct plda_event {
>> diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
>> index 9bb9f0e29565..5cfc30572b7f 100644
>> --- a/drivers/pci/controller/plda/pcie-starfive.c
>> +++ b/drivers/pci/controller/plda/pcie-starfive.c
>> @@ -391,6 +391,7 @@ static int starfive_pcie_probe(struct platform_device *pdev)
>>
>>  	plda->host_ops = &sf_host_ops;
>>  	plda->num_events = PLDA_MAX_EVENT_NUM;
>> +	plda->msi_quirk_delay_us = 1;
>>  	/* mask doorbell event */
>>  	plda->events_bitmap = GENMASK(PLDA_INT_EVENT_NUM - 1, 0)
>>  			     & ~BIT(PLDA_AXI_DOORBELL)
>> --
>> 2.17.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

