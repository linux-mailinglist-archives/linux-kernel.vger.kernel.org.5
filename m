Return-Path: <linux-kernel+bounces-16142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8189282399B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D6F1F26113
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1604A29;
	Thu,  4 Jan 2024 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GK5GAQ4B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34F44414;
	Thu,  4 Jan 2024 00:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=z9OvDNJy0durGaaJOE76nAC55m5S+o9VSdvUuuk1bME=; b=GK5GAQ4BMSwaUZWIIZ2yOQz1UH
	OO2MBjL+L5CE1F6TyxZWqzlVCfYZB/7L2LP7eNsGSKZOOoi/ygBeRr3BEs3GrpyFq0bXRXFoPT7F4
	twLgyihWq30cr0Yt7vjZGDqibnbRdQvdiBTDRO8Mgw9zO8AhDFKOGzqIAnTYirO3BbWB3xV2i4jXi
	VGakgW7fwp84UN5koD4GtKxAmnKq/UCYD0NvurK4YYiWiYgNeaCN3Ohcl1EwTkMDsD1jDAoGwEK8t
	FQJwqLg3gkwAPPfUQoBm2Vls5zic/Cm1Fcz0Cd+E9PaA0nMPOvxU3mGTosGjz/xWFF1k0up787qm+
	XamtGtFg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLBXB-00CTy8-15;
	Thu, 04 Jan 2024 00:24:29 +0000
Message-ID: <b91cc934-f343-4699-9711-a3b52cfbd39a@infradead.org>
Date: Wed, 3 Jan 2024 16:24:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] alpha: Fix typos
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, linux-alpha@vger.kernel.org
References: <20240103231605.1801364-1-helgaas@kernel.org>
 <20240103231605.1801364-2-helgaas@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240103231605.1801364-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/3/24 15:15, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos, most reported by "codespell arch/alpha".  Only touches comments,
> no code changes.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> ---
>  arch/alpha/boot/bootpz.c             | 4 ++--
>  arch/alpha/include/asm/core_marvel.h | 2 +-
>  arch/alpha/include/asm/fpu.h         | 2 +-
>  arch/alpha/include/asm/sfp-machine.h | 2 +-
>  arch/alpha/include/asm/thread_info.h | 2 +-
>  arch/alpha/include/asm/wrperfmon.h   | 2 +-
>  arch/alpha/include/uapi/asm/mman.h   | 2 +-
>  arch/alpha/kernel/err_impl.h         | 2 +-
>  arch/alpha/kernel/irq_i8259.c        | 2 +-
>  arch/alpha/kernel/osf_sys.c          | 2 +-
>  arch/alpha/kernel/pci_iommu.c        | 4 ++--
>  arch/alpha/kernel/sys_eiger.c        | 4 ++--
>  arch/alpha/kernel/sys_marvel.c       | 2 +-
>  arch/alpha/kernel/sys_miata.c        | 2 +-
>  arch/alpha/kernel/sys_takara.c       | 2 +-
>  arch/alpha/lib/ev6-memcpy.S          | 2 +-
>  arch/alpha/lib/ev6-stxcpy.S          | 2 +-
>  arch/alpha/lib/ev67-strrchr.S        | 2 +-
>  arch/alpha/lib/strrchr.S             | 2 +-
>  arch/alpha/lib/stxcpy.S              | 2 +-
>  20 files changed, 23 insertions(+), 23 deletions(-)
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
#Randy

