Return-Path: <linux-kernel+bounces-61136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A5F850DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A621C21AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BE0182A3;
	Mon, 12 Feb 2024 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2sbedfI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEA017C71;
	Mon, 12 Feb 2024 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722067; cv=none; b=JWJncPOBzz/N4Xj0M4mCKaRvjH0sWgSWGPnMoroyyDSNarsYVL5HJg3uYOkhQlSfgdWVlvC98B3MtBbZrJZDPOGzvaN++Mst15NMzk0MuQBSahNgiE0CJ8kPannQUPuBGsR5VRGb7GinfDOjvB1U6cnvRnbpzpi9YXiDrL9v+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722067; c=relaxed/simple;
	bh=6lp/WH08J/LRYj3MSpfMxgfWTwohOEkcpPcuQchVods=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=EOhtc2CYcjzmEF8mprbb/n8Rlp/SMAAFG4LTi2XILK0uH3gxEs/hm4sIGXVzRlYQ5PWvKeSOe3O0zTjx6BWKESPbR+imsnp0R+j5h+gLwi+XSy14HqPjeNpj+meZ4v5PgnkWDwvaSDKgcLqLzWngv+DXg51suK/FCrY9G8n0/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2sbedfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B8CC433C7;
	Mon, 12 Feb 2024 07:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707722067;
	bh=6lp/WH08J/LRYj3MSpfMxgfWTwohOEkcpPcuQchVods=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=T2sbedfI/LZ26pARy0lxvc9zmdh4lHKKljYEP6/5qJaKWWXBKvA1+OT15u3PB8D8a
	 RJNdgz8JnnOLnuXe8dBUrGN/dcN/AjpTlwfeyTbQxOiit0OEXRo1w11Vw2aUxlQY/Z
	 cEs0f4wjhMXPsvEJijvPndqpydpjD7NtGXzwY50CIT0F0esWYu/I0ALEkxJkQ7GYds
	 iz0XfohaAis2DZzXuqnglZ1OdrkYgoDO71WJJeCtWCz5FPSEVeHPDFWNd2Rrk7Cinf
	 o+Dnsu6820ngR0j1zxOvI12SLfeHA9PxG5T6MLhd6KEbpkowoVWbqaS+ZHuk63ydtf
	 nO298PTCVEwCQ==
From: Kalle Valo <kvalo@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: miriam.rachel.korenblit@intel.com,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  ayala.barazani@intel.com
Subject: Re: [PATCH] iwlwifi/uefi: remove CONFIG_ACPI check
References: <20240211201919.3751551-1-max.kellermann@ionos.com>
Date: Mon, 12 Feb 2024 09:14:23 +0200
In-Reply-To: <20240211201919.3751551-1-max.kellermann@ionos.com> (Max
	Kellermann's message of "Sun, 11 Feb 2024 21:19:19 +0100")
Message-ID: <87r0hif92o.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Max Kellermann <max.kellermann@ionos.com> writes:

> This fixes a build failure on ARCH=arm when CONFIG_EFI is set but
> CONFIG_ACPI is not, because uefi.h declares iwl_uefi_get_sgom_table()
> and iwl_uefi_get_uats_table() as dummy inline function, but uefi.c
> contains the real (non-inline) implementation:
>
>  drivers/net/wireless/intel/iwlwifi/fw/uefi.c:359:6: error: redefinition of 'iwl_uefi_get_sgom_table'
>    359 | void iwl_uefi_get_sgom_table(struct iwl_trans *trans,
>        |      ^~~~~~~~~~~~~~~~~~~~~~~
>  In file included from drivers/net/wireless/intel/iwlwifi/fw/uefi.c:11:
>  drivers/net/wireless/intel/iwlwifi/fw/uefi.h:294:6: note: previous
> definition of 'iwl_uefi_get_sgom_table' with type 'void(struct
> iwl_trans *, struct iwl_fw_runtime *)'
>    294 | void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt)
>        |      ^~~~~~~~~~~~~~~~~~~~~~~
>  drivers/net/wireless/intel/iwlwifi/fw/uefi.c:392:5: error: redefinition of 'iwl_uefi_get_uats_table'
>    392 | int iwl_uefi_get_uats_table(struct iwl_trans *trans,
>        |     ^~~~~~~~~~~~~~~~~~~~~~~
>  drivers/net/wireless/intel/iwlwifi/fw/uefi.h:299:5: note: previous
> definition of 'iwl_uefi_get_uats_table' with type 'int(struct
> iwl_trans *, struct iwl_fw_runtime *)'
>    299 | int iwl_uefi_get_uats_table(struct iwl_trans *trans,
>        |     ^~~~~~~~~~~~~~~~~~~~~~~
>
> I don't know how the driver works, and I do not know why the
> CONFIG_ACPI check was added in the first place by commit c593d2fae592a
> ("iwlwifi: support SAR GEO Offset Mapping override via BIOS"), but
> since it did not add the same #ifdef to uefi.c, my first guess is that
> this piece of code shall be used even if ACPI is disabled.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/fw/uefi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

"wifi:" missing from title but I'm guessing Johannes can add that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

