Return-Path: <linux-kernel+bounces-30407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928AB831E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422C828B6E5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3112C84B;
	Thu, 18 Jan 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Abr4ElsV"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1939F2C6BD;
	Thu, 18 Jan 2024 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705598428; cv=none; b=K488MWr/dV+K0k8aR8PV4qwq1aycQH44INuRDZLoPkWkii9/rv71XQI6c86PBc4Inln5VudMcPF44ZjsEeuy/i+hUtf2ZSg5xt1wVAwQGdzbbGEPliDgtSYb58boARm0+Ns6EnxMKnZjsBHxJFm3tk6SpVhCP3r0fBus8BBUu3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705598428; c=relaxed/simple;
	bh=AhBxUMiPWi0pJ79e4Muw8Q5X3mcmykTHVQCaSXf4MLk=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=giMCDOtVVvxy/ie8zdik/kXVvzK9+3O1FSiz1wzRYkUdsvAfs97GuN7fg5IeBdG3zStqicKaJmdzs496hKWJKJkfDiE5ZKpOZC3si9riJUfaxkJDisL3Uh8WB7fshGPlRSRO+l7dtxccDcLuwum0Jmd1muHQhfA1QfwMe4EM85E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Abr4ElsV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=utuWuDjXoRldKpL3sc8RaeRaG0cDdvSyns5k11OdnWo=; b=Abr4ElsV3qXeLBD8ICokyBRqNc
	BuPGZij70p5LIRy0gnvgxvLEmiRzhdzYUuoYOAOS0GTfYxU7Bjx80rr0g2ljM1Hkya6ox3p7yRJbn
	ywD0gppxzfFAVWZC31shhlQQNa+1SXp2nenTjtuYFD4i/VWd7JxPDU3mRG+QipA9DU9Ygq5ir7vhd
	TSf5IBELm1FMeWstsQITYvc1xF2WQW9j2cVdjL4+4zdRuZTRZYjXQAPIfi0ey03cWkda6IzhfIcz/
	XOSgjpEaigt0v7OBNcCq2bzhNw3xBvypvDfpFyEQfSJeJ3BhOFDvXzqlD5WUO3W6eji2KPCij4n2c
	9tB5I5tQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQW40-003NJm-0m;
	Thu, 18 Jan 2024 17:20:24 +0000
Message-ID: <663ad3f4-f877-4817-8f31-dce1ff12ff40@infradead.org>
Date: Thu, 18 Jan 2024 09:20:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] wifi: ath10k: Fix enum ath10k_fw_crash_dump_type
 kernel-doc
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240118-ath10k-kerneldoc-v1-0-99c7e8d95aad@quicinc.com>
 <20240118-ath10k-kerneldoc-v1-5-99c7e8d95aad@quicinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240118-ath10k-kerneldoc-v1-5-99c7e8d95aad@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/18/24 08:12, Jeff Johnson wrote:
> The kernel-doc script currently reports:
> drivers/net/wireless/ath/ath10k/coredump.h:27: warning: Enum value 'ATH10K_FW_CRASH_DUMP_REGISTERS' not described in enum 'ath10k_fw_crash_dump_type'
> drivers/net/wireless/ath/ath10k/coredump.h:27: warning: Enum value 'ATH10K_FW_CRASH_DUMP_CE_DATA' not described in enum 'ath10k_fw_crash_dump_type'
> drivers/net/wireless/ath/ath10k/coredump.h:27: warning: Enum value 'ATH10K_FW_CRASH_DUMP_RAM_DATA' not described in enum 'ath10k_fw_crash_dump_type'
> drivers/net/wireless/ath/ath10k/coredump.h:27: warning: Enum value 'ATH10K_FW_CRASH_DUMP_MAX' not described in enum 'ath10k_fw_crash_dump_type'
> drivers/net/wireless/ath/ath10k/coredump.h:27: warning: Excess enum value 'ATH10K_FW_CRASH_DUMP_REGDUMP' description in 'ath10k_fw_crash_dump_type'
> 
> Fix these issues with the enum ath10k_fw_crash_dump_type kernel-doc.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/net/wireless/ath/ath10k/coredump.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/coredump.h b/drivers/net/wireless/ath/ath10k/coredump.h
> index e5ef0352e319..8d274e0f374b 100644
> --- a/drivers/net/wireless/ath/ath10k/coredump.h
> +++ b/drivers/net/wireless/ath/ath10k/coredump.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: ISC */
>  /*
>   * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
> - * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #ifndef _COREDUMP_H_
> @@ -13,7 +13,11 @@
>  
>  /**
>   * enum ath10k_fw_crash_dump_type - types of data in the dump file
> - * @ATH10K_FW_CRASH_DUMP_REGDUMP: Register crash dump in binary format
> + * @ATH10K_FW_CRASH_DUMP_REGISTERS: Register crash dump in binary format
> + * @ATH10K_FW_CRASH_DUMP_CE_DATA: Copy Engine crash dump data
> + * @ATH10K_FW_CRASH_DUMP_RAM_DATA: RAM crash dump data, contains multiple
> + *				   struct ath10k_dump_ram_data_hdr
> + * @ATH10K_FW_CRASH_DUMP_MAX: Maximum enumeration
>   */
>  enum ath10k_fw_crash_dump_type {
>  	ATH10K_FW_CRASH_DUMP_REGISTERS = 0,
> 

-- 
#Randy

