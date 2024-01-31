Return-Path: <linux-kernel+bounces-46058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DDF8439E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A5A1F21973
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AE069E13;
	Wed, 31 Jan 2024 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fUZ/qCtS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7204469DF2;
	Wed, 31 Jan 2024 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690999; cv=none; b=FztdIh71SNMzn3ZI+NBfLf7rI7oxnBObgSbUFH8lcCmVvh1sJGZQyV+hN2trRGdUK/AVBIRghGl9Wav03x7xOVGTBZn3snXV074EPR5VNxzZSZjCt5kkR5m+Z6MElyGFcPU8ZxeG5X44+IhtDYXdMKYbA3dpOjGCxl6IhKa4Kz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690999; c=relaxed/simple;
	bh=2TF0fuW0AC4plZY7IwMFNw7VYTrwAJYUdZEei7XNV7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4HFXkKTS2fF4hkJnyvGmRYjLgrqjLzKAvhSg5A+PHvwRJu3N0XY4r9MAsf1Qu9VGo1ZanmQzBUsjx2P3NRwNwgA+kqJcbg/FLK5PInuPVl4qG8aa3YM6/wqukrnblYhdV5EJih/q+5OE0hOse6XCHOTYhP3fAlqPAlSOQiT7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fUZ/qCtS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4C59E40E00C5;
	Wed, 31 Jan 2024 08:49:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SE8613EvfTI3; Wed, 31 Jan 2024 08:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706690990; bh=IAFQhZRRdXVvRc2AYR35Su3cYNvuKMDgqxW1MSXcqls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fUZ/qCtSpCA+q/NPIeXhzpdGhqnotgSjjN5FONz9iNzmESA2oHshHjD+CVWp1uEe4
	 pbN/kVJ8raofVsjAtuMtEP6sMtm1KzoU8o+KKDw7Od0n3ow6W3TgT01fBR4yAbobJJ
	 0OH+UxBrCpalcTBkwKUBnw2OPQqdmzWkjzEMau5KKb42dKWk7/gTC4bFLwjI45ELNo
	 rj+sUf9s08/ILJCsXPXSFZlimNUn2AUqXJkbcLrGKaLWAd+VYoxdRdr9X+7Kotmbu8
	 2JihPHGutt3+EOAPDQevoYkFsDc5vuRmPUl6u9vDGaoFHZVz9PRFrCqMXV8wAqMZWh
	 oyMxmohj3VX4VrJ/0sgcVUb+2jsD6emsUva5A7KHkSuVVYsPEcjP9wW+cXyMOMf6oe
	 IIOQssHeWhgtN79oNC/Ow23mFAQxf8zCVB/7/Lrcn2PRArU3LMjmHNpCg8J8yDTcof
	 N9QQRk4VUnx7IRm5UoD+zYt/srecMb2dVzuYaj+28k/gKFveOa16W7I97D1CCjWD2k
	 b0kDe2IWjiCVb+v6uXIYtMMhw3wZRmVLjqiyFIw3dq746EOq1150/BRmckXLu1kXy2
	 usH2ufssSuZjklm1ft66LJ6tE/pdh+WaqnTXCpnUme/9bxWKblPdU55YuvvcVpAfb/
	 ccQQp0P2FQ/ekyaLeKHDYBH8=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EEED440E01A2;
	Wed, 31 Jan 2024 08:49:42 +0000 (UTC)
Date: Wed, 31 Jan 2024 09:49:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Muralidhara M K <muralidhara.mk@amd.com>,
	Yazen Ghannam <Yazen.Ghannam@amd.com>,
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RAS/AMD/ATL: Fix array overflow in
 get_logical_coh_st_fabric_id_mi300()
Message-ID: <20240131084937.GAZboJoRjQLxlANlw1@fat_crate.local>
References: <279c8b5e-6c00-467a-9071-9c67926abea4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <279c8b5e-6c00-467a-9071-9c67926abea4@moroto.mountain>

On Wed, Jan 31, 2024 at 11:24:25AM +0300, Dan Carpenter wrote:
> Check against ARRAY_SIZE() which is the number of elements instead of
> sizeof() which is the number of bytes.  Otherwise we potentially read
> beyond the end of the phy_to_log_coh_st_map_mi300[] array.
> 
> Fixes: 453f0ae79732 ("RAS/AMD/ATL: Add MI300 support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/ras/amd/atl/denormalize.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
> index d5d0e1fda159..49a900e066f1 100644
> --- a/drivers/ras/amd/atl/denormalize.c
> +++ b/drivers/ras/amd/atl/denormalize.c
> @@ -405,7 +405,7 @@ static const u16 phy_to_log_coh_st_map_mi300[] = {
>  
>  static u16 get_logical_coh_st_fabric_id_mi300(struct addr_ctx *ctx)
>  {
> -	if (ctx->inst_id >= sizeof(phy_to_log_coh_st_map_mi300)) {
> +	if (ctx->inst_id >= ARRAY_SIZE(phy_to_log_coh_st_map_mi300)) {
>  		atl_debug(ctx, "Instance ID out of range");
>  		return ~0;
>  	}
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

