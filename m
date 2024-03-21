Return-Path: <linux-kernel+bounces-109623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633D7881B79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8700E1C21427
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9402379CF;
	Thu, 21 Mar 2024 03:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOSZgcwF"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C11E6D39
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710991709; cv=none; b=RpWcVgTFydyt6PLP9jSexYVC4yysZLMBzyDBaNejcxphuK/MdbEDiTjY9uoHykExGiFu3CaG8i9OWtb8B69TfFXhqKX/M+s97CCzkB3uRel2z0JNCURDwy8k4ydlhXUVBlm3TKY0rwF5Dk47OIijZioZh/ErP0J9t84pAyzeRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710991709; c=relaxed/simple;
	bh=xdEV9UiD3koUbrvPWZeqQcXLEOAuX2ygzDLUH6bKPkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELKvHSb9fFX8p05iNpA4VQJZNVec86sohv0Oyg4ZaAqCAtAwlQfRyJRKQnexI4mgl2bhChfXDpUDAMMaU97ODgEElO0dPzSIlntsR4ZW+v44zGYAhjo/fz+cYvpVWbyWXi1Uk9pfzdPxt/raITB2WYu+QPDqigOvA8qXwXME6dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOSZgcwF; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2297d0d6013so333045fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710991707; x=1711596507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7cheEznH9/bunJzLxgRV2InNzXngEocXk8K3lCsX5Ro=;
        b=gOSZgcwF5/r+elZ6F13gCJij6FK45lrQMXpMo3AXxrvT4bXwlYb6UG4aXDoLd5qryU
         f/j7k62kduhIJbzuFnCiRARdv1Emwbum0Fuc84dVWrttbEaiFXfUPUNakwq0OUsQlRu2
         jUgauH2uBwfS7Qk5owGqwpTpdXEkH2f8p/LN0c5GrdUG1wK4yEoEFARRyCvO+ZVprT9X
         vAx8zOzPrx0h1TZOiebWxrNgDIPjqtUx+hfA6XAY2SFWmbgU/+uJ/eQy19pXl0JYWByi
         wMuV5bf19JVZNlSSdh0g91rH+ky8oYA+2eBTbQHoVQRqGssC7GhEQJr8PcTgMsjHt0nq
         HnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710991707; x=1711596507;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cheEznH9/bunJzLxgRV2InNzXngEocXk8K3lCsX5Ro=;
        b=jjgRyBHStO/i3Qwzc4ONpAG7oum7oltDAvKDU1wAdTAZ01RQ9vVYE+JE4jUrQQ2spo
         Q2djwZVxYQnMmTiG0FXgge+umcScbfjQI47LaAx5f7iqXvTnJ0ghXYvBV+bHXhb7Ux0s
         D+l/AfQ6GScP/eChAlL+QfVbnvv2CBGVWoV0u8R4DQOPlijhsLRfvfUC4o6sFd4HKoJ1
         Rb7taA7fu6X3IYSsaX/z+D8v5OxBBgAFtWeqsi0wutH97OlxwyclBk4NL54MlO3THyh5
         L1PzE70egKv5LQSVyWFVbIQIM7Few+7hgX1cqQpNNWmvh+l2hf+vwz/yIE8F5XPTNTky
         yUGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/LvQf6kr5aSMood/AIWqn8PrnRIYk/hpQLF2hnrpaeH1TdwgCBJx6kem7zEF8AYLIPzAxxr9JeLmlvSQ1HfQJ5EURSIsizY8gPJy+
X-Gm-Message-State: AOJu0YxZPQ8/uhKSADFCF0BI8RmAqsQ0RnSCXDRWxpACYm6nC/B7oPrG
	OS+OAephQ/4UkLpRDhwLwmnK0A2KqLzGFUAgTRe4k9QRw0Eiola8OMpY1CUFUWA=
X-Google-Smtp-Source: AGHT+IFPqaRShwuDsNLqtZOfOtCcU42vj7hJqYUzDGKSw0DtTHuhRD2ByvpcEZ80TWkbUf82hZSikQ==
X-Received: by 2002:a05:6870:f60d:b0:221:c9ef:5b with SMTP id ek13-20020a056870f60d00b00221c9ef005bmr4044811oab.18.1710991707382;
        Wed, 20 Mar 2024 20:28:27 -0700 (PDT)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id jw35-20020a056a0092a300b006e6a16acf85sm12519916pfb.87.2024.03.20.20.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 20:28:26 -0700 (PDT)
Message-ID: <8aa7d7ac-1c8e-4a8f-8d88-ffaadcbcafb8@gmail.com>
Date: Wed, 20 Mar 2024 20:28:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: rawnand: brcmnand: Fix data access violation for STB
 chip
To: William Zhang <william.zhang@broadcom.com>,
 Linux MTD List <linux-mtd@lists.infradead.org>
Cc: Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
 joel.peshkin@broadcom.com, miquel.raynal@bootlin.com, dregan@mail.com,
 kamal.dasu@broadcom.com, kursad.oney@broadcom.com,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Richard Weinberger <richard@nod.at>, David Regan <dregan@broadcom.com>
References: <20240320222623.35604-1-william.zhang@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240320222623.35604-1-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/20/2024 3:26 PM, William Zhang wrote:
> Florian reported the following kernel NULL pointer dereference issue on
> a BCM7250 board:
> [    2.829744] Unable to handle kernel NULL pointer dereference at virtual address 0000000c when read
> [    2.838740] [0000000c] *pgd=80000000004003, *pmd=00000000
> [    2.844178] Internal error: Oops: 206 [#1] SMP ARM
> [    2.848990] Modules linked in:
> [    2.852061] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-next-20240305-gd95fcdf4961d #66
> [    2.860436] Hardware name: Broadcom STB (Flattened Device Tree)
> [    2.866371] PC is at brcmnand_read_by_pio+0x180/0x278
> [    2.871449] LR is at __wait_for_common+0x9c/0x1b0
> [    2.876178] pc : [<c094b6cc>]    lr : [<c0e66310>]    psr: 60000053
> [    2.882460] sp : f0811a80  ip : 00000012  fp : 00000000
> [    2.887699] r10: 00000000  r9 : 00000000  r8 : c3790000
> [    2.892936] r7 : 00000000  r6 : 00000000  r5 : c35db440  r4 : ffe00000
> [    2.899479] r3 : f15cb814  r2 : 00000000  r1 : 00000000  r0 : 00000000
> 
> The issue only happens when dma mode is disabled or not supported on STB
> chip. The pio mode transfer calls brcmnand_read_data_bus function which
> dereferences ctrl->soc->read_data_bus. But the soc member in STB chip is
> NULL hence triggers the access violation. The function needs to check
> the soc pointer first.
> 
> Fixes: 546e42599120 ("mtd: rawnand: brcmnand: Add BCMBCA read data bus interface")
> 
> Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Thanks for the quick fix William, I had missed that the difference 
between systems was indeed FLASH_DMA being enabled or not.
-- 
Florian

