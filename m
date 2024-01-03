Return-Path: <linux-kernel+bounces-15717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8A38230D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C501C238CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E07B1B280;
	Wed,  3 Jan 2024 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="boLsoeZk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07FF1B278
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F3C5B40E01C5;
	Wed,  3 Jan 2024 15:54:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Xg2tRQQM6vsz; Wed,  3 Jan 2024 15:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704297240; bh=WpnTenm9HEJOzoqg96hDNa6TBkWGdDEowlsD7/ZMG0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=boLsoeZklD38Vy50LMQbw/BOVKimr4VXDlvNJxIo890wZSVUSquQtmsP0tI/9y3Am
	 keynluXldAWEJL6pW8tMAzhWF2OMHZPf1Gv6fe3W/02/6NOg2d/SYlMQwyJaSmFM4b
	 zDn0MsJHKYATWvdUxXUAUNxXkuwz/nvWuj9Mw8qwPnZuUOXGG7zxr7o3u4qIewy7Gr
	 gok95Hr1ZWqLOfv9MUbRB+NCb5DfLO+QQaWbQd3RQrorWvKllDRfOyzKnPA+G5kXej
	 Q6fLs0OLLp476RgkWImmVL+YIdGzoUsNxzAGgNpDUGCVku3s3/lvoRupHK8WnupfTR
	 KrlFoeVM0cxxghlY6KSAnz6cCYyiSwWw2DGaXBEUlUVHQZ51zLZY9n2YAE1KUdbJhQ
	 S/ww0MPbbAxbWqMCDrnQOu4FaJQNPINBg6+f7cDPr9ZMSFgZzkYvrKpsyWQ+4QV/u5
	 ZB97dIDO/kGf1XkM/VdDrUKJSzq3L2PC+Em4mtb7s7+Tp0l9g5ve6x4p9yl2NMDWDd
	 VpXgaWJT50oIFj9reEPVpDmX3E7OEkDHu0fc1uWdLWTVRbEpbLlmtlKY+UdUviMqIn
	 a1URu/he/l4O3KRDbrWNuZ5TJN3wFnZ8DzLoJKCmbjtQQtkfmk2LiOVP6fzOZKKsR0
	 21sx6wBkxlhAW06CpiWAbcOs=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 991F940E01BE;
	Wed,  3 Jan 2024 15:53:50 +0000 (UTC)
Date: Wed, 3 Jan 2024 16:53:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-edac@vger.kernel.or, git@amd.com, linux-kernel@vger.kernel.org,
	rric@kernel.org, mchehab@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, sai.krishna.potthuri@amd.com,
	shubhrajyoti.datta@gmail.com
Subject: Re: [PATCH] EDAC/versal: Make the bits in error injection
 configurable
Message-ID: <20240103155344.GCZZWDCLfrRR2N18JU@fat_crate.local>
References: <20231220042832.29795-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231220042832.29795-1-shubhrajyoti.datta@amd.com>

On Wed, Dec 20, 2023 at 09:58:32AM +0530, Shubhrajyoti Datta wrote:
> Currently the error injection bits are hardcoded.
> Make them configurable. We have separate entries to configure the

Who's "We"?

> bits to inject errors.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
>  drivers/edac/versal_edac.c | 122 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 106 insertions(+), 16 deletions(-)

...

> @@ -847,12 +849,14 @@ static ssize_t xddr_inject_data_poison_store(struct mem_ctl_info *mci,
>  	return 0;
>  }
>  
> -static ssize_t inject_data_poison_store(struct file *file, const char __user *data,
> -					size_t count, loff_t *ppos)
> +static ssize_t inject_data_ce_store(struct file *file, const char __user *data,
> +				    size_t count, loff_t *ppos)
>  {
>  	struct device *dev = file->private_data;
>  	struct mem_ctl_info *mci = to_mci(dev);
>  	struct edac_priv *priv = mci->pvt_info;
> +	u8 ce_bitpos;
> +	int ret;
>  
>  	/* Unlock the PCSR registers */
>  	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
> @@ -863,14 +867,98 @@ static ssize_t inject_data_poison_store(struct file *file, const char __user *da
>  	/* Lock the PCSR registers */
>  	writel(1, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);

You lock the PCSR registers...

> -	xddr_inject_data_poison_store(mci, data);
> +	ret = kstrtou8_from_user(data, count, 0, &ce_bitpos);
> +	if (ret)
> +		return ret;
> +	ret = xddr_inject_data_ce_store(mci, ce_bitpos);

... and you lock them here *again*. This doesn't make sense.
>  
>  	return count;
>  }
>  
> -static const struct file_operations xddr_inject_enable_fops = {
> +static void xddr_inject_data_ue_store(struct mem_ctl_info *mci, u32 val0, u32 val1)
> +{
> +	struct edac_priv *priv = mci->pvt_info;
> +
> +	writel(val0, priv->ddrmc_baseaddr + ECCW0_FLIP0_OFFSET);
> +	writel(val0, priv->ddrmc_baseaddr + ECCW0_FLIP1_OFFSET);
> +	writel(val1, priv->ddrmc_baseaddr + ECCW1_FLIP1_OFFSET);
> +	writel(val1, priv->ddrmc_baseaddr + ECCW1_FLIP1_OFFSET);
> +}
> +
> +static ssize_t inject_data_ue_store(struct file *file, const char __user *data,
> +				    size_t count, loff_t *ppos)
> +{
> +	struct device *dev = file->private_data;
> +	struct mem_ctl_info *mci = to_mci(dev);
> +	struct edac_priv *priv = mci->pvt_info;
> +	u8 pos0, pos1, len;
> +	u32 val0 = 0;
> +	u32 val1 = 0;
> +	u8 ue0, ue1;
> +	char buf[6];
> +	int ret;
> +
> +	len = min_t(size_t, count, sizeof(buf));
> +	if (copy_from_user(buf, data, len))
> +		return -EFAULT;
> +
> +	for (pos0 = 0; buf[pos0] != ' ' && pos0 <= len; pos0++)
> +		;
> +
> +	if (pos0 > len)
> +		return -EINVAL;
> +
> +	ret = kstrtou8_from_user(data, pos0, 0, &ue0);
> +	if (ret)
> +		return ret;
> +
> +	for (pos1 = pos0 + 1; buf[pos1] != '\n' && pos1 <= len; pos1++)
> +		;
> +
> +	if (pos1 > count)
> +		return -EINVAL;
> +
> +	ret = kstrtou8_from_user(&data[pos0 + 1], pos1 - pos0 - 1, 0,
> +				 &ue1);
> +	if (ret)
> +		return ret;
> +
> +	if (ue0 < 31) {
> +		val0 = BIT(ue0);
> +	} else {
> +		ue0 = ue0 - 31;
> +		val1 = BIT(ue0);
> +	}
> +	if (ue1 < 31) {
> +		val0 |= BIT(ue1);
> +	} else {
> +		ue1 = ue1 - 31;
> +		val1 |= BIT(ue1);
> +	}
> +
> +	/* Unlock the PCSR registers */
> +	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
> +	writel(PCSR_UNLOCK_VAL, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
> +
> +	poison_setup(priv);
> +
> +	/* Lock the PCSR registers */
> +	writel(1, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
> +
> +	xddr_inject_data_ue_store(mci, val0, val1);
> +
> +	return count;
> +}
> +
> +static const struct file_operations xddr_inject_ue_fops = {
> +	.open = simple_open,
> +	.write = inject_data_ue_store,
> +	.llseek = generic_file_llseek,
> +};
> +
> +static const struct file_operations xddr_inject_ce_fops = {
>  	.open = simple_open,
> -	.write = inject_data_poison_store,
> +	.write = inject_data_ce_store,
>  	.llseek = generic_file_llseek,
>  };

Put the fops underneath the respective functions.

Also, the injection algorithm needs to be explained in a comment here,
step by step, and not have people figure out what they need to do by
parsing inject_data_{ce,ue}_store() by foot.

> @@ -882,8 +970,10 @@ static void create_debugfs_attributes(struct mem_ctl_info *mci)
>  	if (!priv->debugfs)
>  		return;
>  
> -	edac_debugfs_create_file("inject_error", 0200, priv->debugfs,
> -				 &mci->dev, &xddr_inject_enable_fops);
> +	edac_debugfs_create_file("inject_ce", 0200, priv->debugfs,
> +				 &mci->dev, &xddr_inject_ce_fops);
> +	edac_debugfs_create_file("inject_ue", 0200, priv->debugfs,
> +				 &mci->dev, &xddr_inject_ue_fops);

That function can return NULL.

>  	debugfs_create_x64("address", 0600, priv->debugfs,
>  			   &priv->err_inject_addr);
>  	mci->debugfs = priv->debugfs;
> -- 

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

