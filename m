Return-Path: <linux-kernel+bounces-22195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D6D829AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E6C284150
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B10948789;
	Wed, 10 Jan 2024 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JymvvTKU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E14482C5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A939C433F1;
	Wed, 10 Jan 2024 12:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704891239;
	bh=DSftCYS5P3sY6sXRehEQNrxOkJKQDn0sOejoV2fg5Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JymvvTKUs+GoeQjT66hDu9rBhhr/0asgzWbB3OpyQXMCCaGXAYIrIsn+NMw274RkQ
	 7lT/0gqb/Aj6cKR/Xf6IWubi3vtd4Tx2GxoTfyrrH41wAQkJU5MANcz9iZjVg6kYVn
	 +u+QT9yz7gJDBA/+lC8K2dfssi2iNLkZo2eiD33knNOwMBHw9woEcAYW5VCV8Zp2XC
	 sr+jAJTsi2NVVeuwLLh2eTsHdpcObfCEP2leNLbrD2bAsd7/10Vp7TelZq9jhA1SOz
	 lxzPguWX6d04iEnXnMOdxcl03AwAw+EuvgPZdT7yjja3ji7zse24Gd5wwC25i/tk1a
	 7FniQR+zP41Yg==
Date: Wed, 10 Jan 2024 12:53:55 +0000
From: Lee Jones <lee@kernel.org>
To: chenxb <chenxb_99091@126.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw:[PATCH] mfd: Clean up errors in lm3533.h
Message-ID: <20240110125355.GH7948@google.com>
References: <6415c2b.7f89.18cf3465704.Coremail.chenxb_99091@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6415c2b.7f89.18cf3465704.Coremail.chenxb_99091@126.com>

On Wed, 10 Jan 2024, chenxb wrote:

Subject should be:

  "mfd: lm3533: Remove superfluous whitespace in DEVICE_ATTR()

> Fix the following errors reported by checkpatch:
> 
> 

No double line spaces required.

> ERROR: space prohibited before that ',' (ctx:WxW)
> 
> Signed-off-by: GuoHua Chen <XueBing Chen@jari.cn>

That does not look like a correct email address.

> ---
>  include/linux/mfd/lm3533.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
> index 77092f6363ad..14fde840af67 100644
> --- a/include/linux/mfd/lm3533.h
> +++ b/include/linux/mfd/lm3533.h
> @@ -13,7 +13,7 @@
>  #define LM3533_ATTR_RO(_name) \
>  	DEVICE_ATTR(_name, S_IRUGO, show_##_name, NULL)
>  #define LM3533_ATTR_RW(_name) \
> -	DEVICE_ATTR(_name, S_IRUGO | S_IWUSR , show_##_name, store_##_name)
> +	DEVICE_ATTR(_name, S_IRUGO | S_IWUSR, show_##_name, store_##_name)
>  
>  struct device;
>  struct regmap;
> -- 
> 2.17.1

-- 
Lee Jones [李琼斯]

